Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6635731B37B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Feb 2021 00:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhBNXvH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Feb 2021 18:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhBNXvH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Feb 2021 18:51:07 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A9EC061574;
        Sun, 14 Feb 2021 15:50:26 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBR9Y-00E3Yp-VE; Sun, 14 Feb 2021 23:50:13 +0000
Date:   Sun, 14 Feb 2021 23:50:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        kernel test robot <lkp@intel.com>,
        Dan Williams <dan.j.willams@intel.com>
Subject: Re: [PATCH v2 4/8] cxl/mem: Add basic IOCTL interface
Message-ID: <YCm3NFqO9gVtXOZP@zeniv-ca.linux.org.uk>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-5-ben.widawsky@intel.com>
 <YClQEefYBR+YKBUv@zeniv-ca.linux.org.uk>
 <20210214231456.xnwitliczv6qwmjv@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214231456.xnwitliczv6qwmjv@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 14, 2021 at 03:14:56PM -0800, Ben Widawsky wrote:
> On 21-02-14 16:30:09, Al Viro wrote:
> > On Tue, Feb 09, 2021 at 04:02:55PM -0800, Ben Widawsky wrote:
> > 
> > > +static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> > > +					const struct cxl_mem_command *cmd,
> > > +					u64 in_payload, u64 out_payload,
> > > +					struct cxl_send_command __user *s)
> > > +{
> > > +	struct cxl_mem *cxlm = cxlmd->cxlm;
> > > +	struct device *dev = &cxlmd->dev;
> > > +	struct mbox_cmd mbox_cmd = {
> > > +		.opcode = cmd->opcode,
> > > +		.size_in = cmd->info.size_in,
> > > +	};
> > > +	s32 user_size_out;
> > > +	int rc;
> > > +
> > > +	if (get_user(user_size_out, &s->out.size))
> > > +		return -EFAULT;
> > 
> > You have already copied it in.  Never reread stuff from userland - it *can*
> > change under you.
> 
> As it turns out, this is some leftover logic which doesn't need to exist at all,
> and I'm happy to change it. Thanks for reviewing.
> 
> I wasn't familiar with this restriction though. For my edification could you
> explain how that could happen? Also, is this something that should go in the
> kdocs, because I don't see anything about this restriction there.

Er...  You do realize that if two processes share memory, one can bloody well
modify it while another is in the middle of syscall, right?  Always could -
even mmap(2) with MAP_SHARED is sufficient, same as shmat(2), or the wholesale
sharing between POSIX threads, etc.

And even on UP with no preemption you could bloody well have a structure that
spans a page boundary, with the next page being mmapped and currently not
present in memory.  Then copy_from_user() would've copied the beginning, hit
a page fault, try to read the next page from something slow and lose CPU.
Letting the second process run and modify the already copied part.

It has been possible since at least mid-80s, well before Linux.  Anything in
user memory can change under you, right in the middle of syscall.  Always
could.  And there had been very real bugs along the lines of data being
read twice, once for safety check, once for actual work.  Something like

	get_user(len, &user_object->len);
	check that len is reasonable
	p = kmalloc(offsetof(struct foo, string[len]), GFP_KERNEL);
	copy_from_user(p, user_object, len);
	work with the copy, assuming that first p->len bytes of p->string[]
are safe to use, find out that p->len is much greater than len since
the userland data has changed between two fetches

Some of those had been exploitable from the very beginning, some had become
such on innocious-looking changes.

For the sake of your sanity it's better to avoid such landmines.  In some
cases it's OK to read the data twice (e.g. in something like select(2)), but
those cases are rare and seeing something of that sort is generally a big
red flag on review.  In almost all cases it's best avoided.
