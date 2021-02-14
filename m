Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B8731B153
	for <lists+linux-pci@lfdr.de>; Sun, 14 Feb 2021 17:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhBNQxk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Feb 2021 11:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhBNQxj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Feb 2021 11:53:39 -0500
X-Greylist: delayed 1351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 Feb 2021 08:53:00 PST
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C30C061574;
        Sun, 14 Feb 2021 08:53:00 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBKHh-00DvRy-5S; Sun, 14 Feb 2021 16:30:09 +0000
Date:   Sun, 14 Feb 2021 16:30:09 +0000
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
Message-ID: <YClQEefYBR+YKBUv@zeniv-ca.linux.org.uk>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-5-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210000259.635748-5-ben.widawsky@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 09, 2021 at 04:02:55PM -0800, Ben Widawsky wrote:

> +static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> +					const struct cxl_mem_command *cmd,
> +					u64 in_payload, u64 out_payload,
> +					struct cxl_send_command __user *s)
> +{
> +	struct cxl_mem *cxlm = cxlmd->cxlm;
> +	struct device *dev = &cxlmd->dev;
> +	struct mbox_cmd mbox_cmd = {
> +		.opcode = cmd->opcode,
> +		.size_in = cmd->info.size_in,
> +	};
> +	s32 user_size_out;
> +	int rc;
> +
> +	if (get_user(user_size_out, &s->out.size))
> +		return -EFAULT;

You have already copied it in.  Never reread stuff from userland - it *can*
change under you.
