Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BF81D5B25
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 23:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgEOVEi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 17:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgEOVEi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 17:04:38 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E7E92070A;
        Fri, 15 May 2020 21:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589576677;
        bh=8QOoNfGi8E4W2PgwtJTgUzAA6o5+YdXKdyQfXuEb9VU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EDS4e5iAKL42BGWOFtGltwCYnuMWIRkHFmfME+bvTJgnYJnSqKXHZjZQMWjBEYJ01
         wWY2ZUGNdCmPyzuUatY2fYy53j7wzGS0wp2hMU+v0kMUafzI+8Ug9lDu3cFn9diVFd
         sRq0OrijnD/0JyLbp1QiJ9tYuNNhsb6eZXhCBAaQ=
Date:   Fri, 15 May 2020 16:04:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [RFC PATCH 2/2] PCI: Add basic Compute eXpress Link DVSEC decode
Message-ID: <20200515210435.GA544190@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515175528.980103-3-sean.v.kelley@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 15, 2020 at 10:55:28AM -0700, Sean V Kelley wrote:
> Compute eXpress Link is a new CPU interconnect created with
> workload accelerators in mind. The interconnect relies on PCIe Electrical
> and Physical interconnect for communication. CXL devices enumerate to the
> OS as an ACPI-described PCIe Root Complex Integrated Endpoint.
> 
> This patch introduces the bare minimum support by simply looking for and
> caching the DVSEC CXL Extended Capability. Currently, only CXL.io (which
> is mandatory to be configured by BIOS) is enabled. In future, we will
> also add support for CXL.cache and CXL.mem.

This looks fine, but AFAICT, it doesn't *do* anything yet (except
print a few things to dmesg).  We don't normally merge code until it
adds some new functionality.  So just FYI that I'll wait until that
new functionality comes along and then merge this as part of that
series.  But let me know if I'm missing something.

> +	dev_info(&dev->dev, "CXL: Cache%c IO%c Mem%c Viral%c HDMCount %d\n",
> +		 (cap & PCI_CXL_CACHE) ? '+' : '-',
> +		 (cap & PCI_CXL_IO) ? '+' : '-',
> +		 (cap & PCI_CXL_MEM) ? '+' : '-',
> +		 (cap & PCI_CXL_VIRAL) ? '+' : '-',
> +		 PCI_CXL_HDM_COUNT(cap));

These could use pci_info() and FLAG(), as in pcie_init().

> +	dev_info(&dev->dev, "CXL: cap ctrl status ctrl2 status2 lock\n");
> +	dev_info(&dev->dev, "CXL: %04x %04x %04x %04x %04x %04x\n",
> +		 cap, ctrl, status, ctrl2, status2, lock);
> +}

> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -315,6 +315,7 @@ struct pci_dev {
>  	u16		aer_cap;	/* AER capability offset */
>  	struct aer_stats *aer_stats;	/* AER stats for this device */
>  #endif
> +	u16		cxl_cap;	/* CXL capability offset */

Wrap in #ifdef PCI_CXL.
