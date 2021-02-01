Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5871F30B2F5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 23:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhBAWvg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 17:51:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:7376 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBAWvf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 17:51:35 -0500
IronPort-SDR: cJb3lk1A3o2TRSkYcsftZYQzplplRi6NGDhMqnig6YQjEGQH+YWaMc78g/J1DfbzDQ/6/d4hoP
 dWc/hYh92xjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242282256"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242282256"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 14:50:54 -0800
IronPort-SDR: oHhKkHh06bdvRvwNm4jSmHYo4PebBn4mdxQpmKigtdPMjAR5Owzp9NEOOAlwauFaaJNwXsXR65
 iOJnaFfVq0DA==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="371722457"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 14:50:53 -0800
Date:   Mon, 1 Feb 2021 14:50:52 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210201225052.vrrvuxrsgmddjzbb@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-4-ben.widawsky@intel.com>
 <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
 <20210201165352.wi7tzpnd4ymxlms4@intel.com>
 <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
 <20210201215857.ud5cpg7hbxj2j5bx@intel.com>
 <b46ed01-3f1-6643-d371-7764c3bde4f8@google.com>
 <20210201222859.lzw3gvxuqebukvr6@intel.com>
 <20210201223314.qh24uxd7ajdppgfl@intel.com>
 <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-01 14:45:00, David Rientjes wrote:
> On Mon, 1 Feb 2021, Ben Widawsky wrote:
> 
> > > > > > > > > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > > > > > > > > +{
> > > > > > > > > +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > > > > > > > > +
> > > > > > > > > +	cxlm->mbox.payload_size =
> > > > > > > > > +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > > > > > > > > +
> > > > > > > > > +	/* 8.2.8.4.3 */
> > > > > > > > > +	if (cxlm->mbox.payload_size < 256) {
> > > > > > > > > +		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> > > > > > > > > +			cxlm->mbox.payload_size);
> > > > > > > > > +		return -ENXIO;
> > > > > > > > > +	}
> > > > > > > > 
> > > > > > > > Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and 
> > > > > > > > return ENXIO if true?
> > > > > > > 
> > > > > > > If some crazy vendor wanted to ship a mailbox larger than 1M, why should the
> > > > > > > driver not allow it?
> > > > > > > 
> > > > > > 
> > > > > > Because the spec disallows it :)
> > > > > 
> > > > > I don't see it being the driver's responsibility to enforce spec correctness
> > > > > though. In certain cases, I need to use the spec, like I have to pick /some/
> > > > > mailbox timeout. For other cases... 
> > > > > 
> > > > > I'm not too familiar with what other similar drivers may or may not do in
> > > > > situations like this. The current 256 limit is mostly a reflection of that being
> > > > > too small to even support advertised mandatory commands. So things can't work in
> > > > > that scenario, but things can work if they have a larger register size (so long
> > > > > as the BAR advertises enough space).
> > > > > 
> > > > 
> > > > I don't think things can work above 1MB, either, though.  Section 
> > > > 8.2.8.4.5 specifies 20 bits to define the payload length, if this is 
> > > > larger than cxlm->mbox.payload_size it would venture into the reserved 
> > > > bits of the command register.
> > > > 
> > > > So is the idea to allow cxl_mem_setup_mailbox() to succeed with a payload 
> > > > size > 1MB and then only check 20 bits for the command register?
> > > 
> > > So it's probably a spec bug, but actually the payload size is 21 bits... I'll
> > > check if that was a mistake.
> > 
> > Well I guess they wanted to be able to specify 1M exactly... Spec should
> > probably say you can't go over 1M
> > 
> 
> I think that's what 8.2.8.4.3 says, no?  And then 8.2.8.4.5 says you 
> can use up to Payload Size.  That's why my recommendation was to enforce 
> this in cxl_mem_setup_mailbox() up front.

Yeah. I asked our spec people to update 8.2.8.4.5 to make it clearer. I'd argue
the intent is how you describe it, but the implementation isn't.

My argument was silly anyway because if you specify greater than 1M as your
payload, you will get EINVAL at the ioctl.

The value of how it works today is the driver will at least bind and allow you
to interact with it.

How strongly do you feel about this?
