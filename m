Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FFC30C9F9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 19:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhBBSex (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 13:34:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:28947 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238679AbhBBScn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 13:32:43 -0500
IronPort-SDR: RA6xi+MQ8ULlDIniSoiye50tp/BuI5+NL0wbtnNh6ad72lCrNzXk/aIsfyyD95osLVQQ2J8L7d
 r/3r7TpDQjxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="244987727"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="244987727"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:32:00 -0800
IronPort-SDR: Lb8WyJ3EBTlCkfAzdn8o0ZDcIwM2VGbNL4/5mCrYT0bo92LlqD2tsPvRKRk2ya41RqW1n2nOyQ
 Giaz8SfgDgSA==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="582135589"
Received: from joship1x-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.131.202])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:31:53 -0800
Date:   Tue, 2 Feb 2021 10:31:51 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
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
Subject: Re: [PATCH 02/14] cxl/mem: Map memory device registers
Message-ID: <20210202183151.7kwruvip7nshqsc4@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-3-ben.widawsky@intel.com>
 <20210202180441.GC3708021@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202180441.GC3708021@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-02 18:04:41, Christoph Hellwig wrote:
> Any reason not to merge a bunch of patches?  Both this one and
> the previous one are rather useless on their own, making review
> harder than necessary.
> 

As this is an initial driver, there's obviously no functional/regression testing
value in separating the patches.

This was the way we brought up the driver and how we verified functionality
incrementally. I see value in both capturing that in the history, as well as
making review a bit easier (which apparently failed for you).

> > + * cxl_mem_create() - Create a new &struct cxl_mem.
> > + * @pdev: The pci device associated with the new &struct cxl_mem.
> > + * @reg_lo: Lower 32b of the register locator
> > + * @reg_hi: Upper 32b of the register locator.
> > + *
> > + * Return: The new &struct cxl_mem on success, NULL on failure.
> > + *
> > + * Map the BAR for a CXL memory device. This BAR has the memory device's
> > + * registers for the device as specified in CXL specification.
> > + */
> 
> A lot of text with almost no value over just reading the function.
> What's that fetish with kerneldoc comments for trivial static functions?
> 
> > +		reg_type =
> > +			(reg_lo >> CXL_REGLOC_RBI_SHIFT) & CXL_REGLOC_RBI_MASK;
> 
> OTOH this screams for a helper that would make the code a lot more
> self documenting.
> 

I agree, I'll change this.

> > +		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> > +			rc = 0;
> > +			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> > +			if (!cxlm)
> > +				rc = -ENODEV;
> > +			break;
> 
> And given that we're going to grow more types eventually, why not start
> out with a switch here?  Also why return the structure when nothing
> uses it?

 We've (Intel) already started working on the libnvdimm integration which does
 change this around a bit. In order to go with what's best tested though, I've
 chosen to use this as is for merge. Many different people not just in Intel
 have tested these codepaths. The resulting code moves the check on register
 type out of this function entirely.

 If you'd like me to make it a switch, I can, but it's going to be extracted
 later anyway.
