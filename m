Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E6C45834A
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 13:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbhKUM1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Nov 2021 07:27:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233019AbhKUM1R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 21 Nov 2021 07:27:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF78D6023E;
        Sun, 21 Nov 2021 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637497452;
        bh=eMYFmoZSFX2jyVOSCFjFFwc/RwT1DrSIr7UoN3UV1zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yhA5l4/fq4dGiMzBP9UEo6VKSq2+Y8NLneGwVFnYVQjp963jn1aK8kW/32WSu2xZR
         84fjSTgs1mkLutflZnOuHSbnPfNOrLIeS/Bp9dMLmFT2Z5rjZ+4eXPaN9N2aSugR71
         ph6JmWtMVYcanb5vpO42MjgM2Bu0YUkklZSsNoKQ=
Date:   Sun, 21 Nov 2021 13:24:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: Add #defines for accessing PCIe DVSEC fields
Message-ID: <YZo6aczgqoobIcDC@kroah.com>
References: <20211120231705.189969-1-david.e.box@linux.intel.com>
 <20211120231705.189969-2-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120231705.189969-2-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 20, 2021 at 03:17:02PM -0800, David E. Box wrote:
> Add #defines for accessing Vendor ID, Revision, Length, and ID offsets
> in the Designated Vendor Specific Extended Capability (DVSEC). Defined
> in PCIe r5.0, sec 7.9.6.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/uapi/linux/pci_regs.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ff6ccbc6efe9..318f3f1f9e92 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1086,7 +1086,11 @@
>  
>  /* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
>  #define PCI_DVSEC_HEADER1		0x4 /* Designated Vendor-Specific Header1 */
> +#define  PCI_DVSEC_HEADER1_VID(x)	((x) & 0xffff)
> +#define  PCI_DVSEC_HEADER1_REV(x)	(((x) >> 16) & 0xf)
> +#define  PCI_DVSEC_HEADER1_LEN(x)	(((x) >> 20) & 0xfff)
>  #define PCI_DVSEC_HEADER2		0x8 /* Designated Vendor-Specific Header2 */
> +#define  PCI_DVSEC_HEADER2_ID(x)		((x) & 0xffff)

Why does userspace need to have these defines?  What userspace tool is
going to use these?

thanks,

greg k-h
