Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81112419CE8
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 19:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhI0Rfr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 13:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238253AbhI0RcH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 13:32:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62C7A60E08;
        Mon, 27 Sep 2021 17:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632763821;
        bh=+XPiy1lkMe54dEZDykhM7x1ydKFAwCm7W2f6EXWbvzM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=koTlTr/gYSHZQEDGbsyDcJTBZZ2o58S4Cjd/MOT12MOq3U8YzEF35X48CiYRHm4xt
         smk/UmPVERvwxrIuvBEXfaqKciIC3C8gAb4yYR04Dui2p3/5G4Ivp9iXXMyqe6SwSt
         Eh4LgZmnUiOLk0V2POGyJ9dFBMUOmV/497ald04OVdq5nylDt8+eRQq6gPZtxur4eZ
         2Xr5Dww/0qBqqEdH/8meVLYd2zjrBA9+UoY1A6UnN5ue2Yj2InS4lwPdYI/AtPvIMj
         5zMEpU0AU2pp9TZKW67YNL0l/AoOOciJThq7sDOiMhq0uOrrtZU6c3a9aJhRe9CbfK
         UJnZGxNAzt/6w==
Date:   Mon, 27 Sep 2021 12:30:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, bhelgaas@google.com,
        andy.shevchenko@gmail.com, mgross@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/5] PCI: Add #defines for accessing PCIE DVSEC fields
Message-ID: <20210927173020.GA659547@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922213007.2738388-2-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If you repost this for any reason, update the subject to:

s/PCIE/PCIe/

So it matches the commit log and other usage in drivers/pci/

On Wed, Sep 22, 2021 at 02:30:03PM -0700, David E. Box wrote:
> Add #defines for accessing Vendor ID, Revision, Length, and ID offsets
> in the Designated Vendor Specific Extended Capability (DVSEC). Defined
> in PCIe r5.0, sec 7.9.6.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> 
> v3:	No change
> 
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
