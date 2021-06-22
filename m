Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9B53B082F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 17:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhFVPGd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 11:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhFVPGc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 11:06:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0DAE6113D;
        Tue, 22 Jun 2021 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624374257;
        bh=oaiMFoJRDJDuxcwnmjSR+k33zwVVQ5QsiBRDzO4U8IU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MbK5yH3du65dtdfjyFUn8KV0qZJDlPKU6g9XgYx2XWw4M7R+r43TopBpTMzOpd2tK
         0c7iv7DEyrJ856RPFDBTqA1UxsDAUmmPI6efu22i9i41Zo4pMat8CZqgLoq+DgHoYN
         2/khlnmfQwOEolpq9fUyKFqhp8WsFXt4dsiExPRHZT8Kxh2Chb5sVMZeNLxA6G9evl
         nXGAURsPhbmfr/P/Ml46VfYCvsyS2y4cUDd2tXlyZG/tEv/o7wY0LKQl4Jybbg+VzI
         NRGgFkmBNtzI9G3U1DdCQueXD8JK1qRC98grlLycKzEz9CnGloz76kUg/6wEDB1xan
         ddOwzjqelqVRA==
Date:   Tue, 22 Jun 2021 10:04:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/4] PCI: Add #defines for accessing PCIE DVSEC fields
Message-ID: <20210622150415.GA3336733@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617215408.1412409-2-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Dan, Jonathan]

On Thu, Jun 17, 2021 at 02:54:05PM -0700, David E. Box wrote:
> Add #defines for accessing Vendor ID, Revision, Length, and ID offsets
> in the Designated Vendor Specific Extended Capability (DVSEC). Defined
> in PCIe r5.0, sec 7.9.6.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I don't have time right now to really look at the
intel_extended_caps.c patch [1], but I wonder if there's anything
there that could be abstracted and shared with CXL, etc?  If not, no
worries.

[1] https://lore.kernel.org/r/20210617215408.1412409-5-david.e.box@linux.intel.com

> ---
>  include/uapi/linux/pci_regs.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e709ae8235e7..57ee51f19283 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1080,7 +1080,11 @@
>  
>  /* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
>  #define PCI_DVSEC_HEADER1		0x4 /* Designated Vendor-Specific Header1 */
> +#define  PCI_DVSEC_HEADER1_VID(x)	((x) & 0xffff)
> +#define  PCI_DVSEC_HEADER1_REV(x)	(((x) >> 16) & 0xf)
> +#define  PCI_DVSEC_HEADER1_LEN(x)	(((x) >> 20) & 0xfff)
>  #define PCI_DVSEC_HEADER2		0x8 /* Designated Vendor-Specific Header2 */
> +#define  PCI_DVSEC_HEADER2_ID(x)		((x) & 0xffff)
>  
>  /* Data Link Feature */
>  #define PCI_DLF_CAP		0x04	/* Capabilities Register */
> -- 
> 2.25.1
> 
