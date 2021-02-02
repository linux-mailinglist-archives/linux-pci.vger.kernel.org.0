Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC2830C909
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 19:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhBBSHi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 13:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbhBBSFd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 13:05:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF04C0613D6;
        Tue,  2 Feb 2021 10:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VyJH7voCGDtQQt4w1TbeXtHjXIusss7wUzDWNNwmpGk=; b=IOskqQICKJhmHUYSyZ0bIKcxSC
        YD51DXLjngLcDn194FfQCXJv9zvz5Jxh4are/lj4k24Adh+aXRs/U+3tV373RLw3lyzqN4rFS5I3a
        prGYth3McC/q8/tJbuE/nKVCBde40lMicMbqrztzsBqgb/xoONwYRLFcn0+j5LomiLLV++NPWtRRo
        dThWOChcYBPEEyy6nLAKIaVyzDDuTQu9qQRXYJc3dEY1uPo7IeCZrTIxtY6DignbximVToZEx6gEX
        04yp/33EIyC9HfZI7lT0h2jKgmq6kV4Y7b8rdFdpsW7R2ayBfvIUfsfS/tcSQskmt2jIJvxsFztDl
        Ee5uLZMg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l702b-00FZAZ-K5; Tue, 02 Feb 2021 18:04:42 +0000
Date:   Tue, 2 Feb 2021 18:04:41 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
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
Subject: Re: [PATCH 02/14] cxl/mem: Map memory device registers
Message-ID: <20210202180441.GC3708021@infradead.org>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-3-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130002438.1872527-3-ben.widawsky@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Any reason not to merge a bunch of patches?  Both this one and
the previous one are rather useless on their own, making review
harder than necessary.

> + * cxl_mem_create() - Create a new &struct cxl_mem.
> + * @pdev: The pci device associated with the new &struct cxl_mem.
> + * @reg_lo: Lower 32b of the register locator
> + * @reg_hi: Upper 32b of the register locator.
> + *
> + * Return: The new &struct cxl_mem on success, NULL on failure.
> + *
> + * Map the BAR for a CXL memory device. This BAR has the memory device's
> + * registers for the device as specified in CXL specification.
> + */

A lot of text with almost no value over just reading the function.
What's that fetish with kerneldoc comments for trivial static functions?

> +		reg_type =
> +			(reg_lo >> CXL_REGLOC_RBI_SHIFT) & CXL_REGLOC_RBI_MASK;

OTOH this screams for a helper that would make the code a lot more
self documenting.

> +		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> +			rc = 0;
> +			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> +			if (!cxlm)
> +				rc = -ENODEV;
> +			break;

And given that we're going to grow more types eventually, why not start
out with a switch here?  Also why return the structure when nothing
uses it?
