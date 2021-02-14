Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F43831B33A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Feb 2021 00:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhBNXPj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Feb 2021 18:15:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:49707 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhBNXPj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 14 Feb 2021 18:15:39 -0500
IronPort-SDR: lvCgyegnW6k6StVGMoPbB1kxQ7P6VaRhRElmlGLC4gw4g9xiybXpWpZyhnDhBxbx3aUp8lcsF+
 e2QvUFPMGRYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9895"; a="246671017"
X-IronPort-AV: E=Sophos;i="5.81,179,1610438400"; 
   d="scan'208";a="246671017"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2021 15:14:58 -0800
IronPort-SDR: 5baMiPXAMLOLE+02Ny6pfw3U38wyzJ/BY291r/241pX2vv9fWp+/sWXoW5/e34TDtQzqTVMYnU
 aQ6EekstXsAQ==
X-IronPort-AV: E=Sophos;i="5.81,179,1610438400"; 
   d="scan'208";a="398810113"
Received: from cbfoster-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.135.243])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2021 15:14:57 -0800
Date:   Sun, 14 Feb 2021 15:14:56 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
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
Message-ID: <20210214231456.xnwitliczv6qwmjv@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-5-ben.widawsky@intel.com>
 <YClQEefYBR+YKBUv@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YClQEefYBR+YKBUv@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-14 16:30:09, Al Viro wrote:
> On Tue, Feb 09, 2021 at 04:02:55PM -0800, Ben Widawsky wrote:
> 
> > +static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> > +					const struct cxl_mem_command *cmd,
> > +					u64 in_payload, u64 out_payload,
> > +					struct cxl_send_command __user *s)
> > +{
> > +	struct cxl_mem *cxlm = cxlmd->cxlm;
> > +	struct device *dev = &cxlmd->dev;
> > +	struct mbox_cmd mbox_cmd = {
> > +		.opcode = cmd->opcode,
> > +		.size_in = cmd->info.size_in,
> > +	};
> > +	s32 user_size_out;
> > +	int rc;
> > +
> > +	if (get_user(user_size_out, &s->out.size))
> > +		return -EFAULT;
> 
> You have already copied it in.  Never reread stuff from userland - it *can*
> change under you.

As it turns out, this is some leftover logic which doesn't need to exist at all,
and I'm happy to change it. Thanks for reviewing.

I wasn't familiar with this restriction though. For my edification could you
explain how that could happen? Also, is this something that should go in the
kdocs, because I don't see anything about this restriction there.

Thanks.
Ben
