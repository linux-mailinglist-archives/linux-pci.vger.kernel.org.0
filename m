Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8120723C3CB
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 05:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHEDBb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 23:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHEDBa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 23:01:30 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0A50206D4;
        Wed,  5 Aug 2020 03:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596596490;
        bh=8AH4/eUPZDsQ+fVW4NopE/hRdVe2VxDxDVRNG3gh8Hw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ox4surQWFDCe/f1T3HysFeGsbODxhzyEL1Bad7uxlpfViYeKLxBCjlg2DFvgIcC4D
         SlXbND10xcRebErpP9UcAfNCIF9IDNdk+0OzOv59IaP0KpMNa7pWzR/gvoyfC5q3s0
         DzRPmTNkMjcd0vdXGjsPkB5e41W+FP1lSeW0YhgE=
Date:   Tue, 4 Aug 2020 22:01:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH V2 1/9] pci_ids: Add class code and extended capability
 for RCEC
Message-ID: <20200805030128.GA470966@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804194052.193272-2-sean.v.kelley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 04, 2020 at 12:40:44PM -0700, Sean V Kelley wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> A PCIe Root Complex Event Collector(RCEC) has the base class 0x08,
> sub-class 0x07, and programming interface 0x00. Add the class code
> 0x0807 to identify RCEC devices and add the defines for the RCEC
> Endpoint Association Extended Capability.
> 
> See PCI Express Base Specification, version 5.0-1, section "1.3.4
> Root Complex Event Collector" and section "7.9.10 Root Complex
> Event Collector Endpoint Association Extended Capability"
> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

1) "git log --oneline include/linux/pci_ids.h".  Match it.  Mention
the most important words, like "RCEC", early in the subject.

2) https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n555

> ---
>  include/linux/pci_ids.h       | 1 +
>  include/uapi/linux/pci_regs.h | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 5c709a1450b1..bc6d1a4ca02d 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -81,6 +81,7 @@
>  #define PCI_CLASS_SYSTEM_RTC		0x0803
>  #define PCI_CLASS_SYSTEM_PCI_HOTPLUG	0x0804
>  #define PCI_CLASS_SYSTEM_SDHCI		0x0805
> +#define PCI_CLASS_SYSTEM_RCEC		0x0807
>  #define PCI_CLASS_SYSTEM_OTHER		0x0880
>  
>  #define PCI_BASE_CLASS_INPUT		0x09
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f9701410d3b5..f335f65f65d6 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -828,6 +828,13 @@
>  #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget */
>  #define PCI_EXT_CAP_PWR_SIZEOF	16
>  
> +/* Root Complex Event Collector Endpoint Association  */
> +#define PCI_RCEC_RCIEP_BITMAP	4	/* Associated Bitmap for RCiEPs */
> +#define PCI_RCEC_BUSN		8	/* RCEC Associated Bus Numbers */
> +#define  PCI_RCEC_BUSN_REG_VER	0x02	/* Least capability version that BUSN present */
> +#define  PCI_RCEC_BUSN_NEXT(x)	(((x) >> 8) & 0xff)
> +#define  PCI_RCEC_BUSN_LAST(x)	(((x) >> 16) & 0xff)
> +
>  /* Vendor-Specific (VSEC, PCI_EXT_CAP_ID_VNDR) */
>  #define PCI_VNDR_HEADER		4	/* Vendor-Specific Header */
>  #define  PCI_VNDR_HEADER_ID(x)	((x) & 0xffff)
> -- 
> 2.27.0
> 
