Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8DD584A6
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 16:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfF0Oin (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 10:38:43 -0400
Received: from foss.arm.com ([217.140.110.172]:55674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfF0Oin (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 10:38:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72489360;
        Thu, 27 Jun 2019 07:38:42 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD71B3F246;
        Thu, 27 Jun 2019 07:38:39 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:38:37 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V11 01/12] PCI: Add #defines for some of PCIe spec r4.0
 features
Message-ID: <20190627143837.GC3782@e121166-lin.cambridge.arm.com>
References: <20190624091505.1711-1-vidyas@nvidia.com>
 <20190624091505.1711-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624091505.1711-2-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 24, 2019 at 02:44:54PM +0530, Vidya Sagar wrote:
> Add #defines only for the Data Link Feature and Physical Layer 16.0 GT/s
> features.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes since [v10]:
> * None
> 
> Changes since [v9]:
> * None
> 
> Changes since [v8]:
> * None
> 
> Changes since [v7]:
> * None
> 
> Changes since [v6]:
> * None
> 
> Changes since [v5]:
> * None
> 
> Changes since [v4]:
> * None
> 
> Changes since [v3]:
> * None
> 
> Changes since [v2]:
> * Updated commit message and description to explicitly mention that defines are
>   added only for some of the features and not all.
> 
> Changes since [v1]:
> * None
> 
>  include/uapi/linux/pci_regs.h | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

I need Bjorn's ACK to merge this patch.

Lorenzo

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f28e562d7ca8..1c79f6a097d2 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -713,7 +713,9 @@
>  #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
>  #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
>  #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
> +#define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
> +#define PCI_EXT_CAP_ID_PL	0x26	/* Physical Layer 16.0 GT/s */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL
>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1053,4 +1055,22 @@
>  #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
>  #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
>  
> +/* Data Link Feature */
> +#define PCI_DLF_CAP		0x04	/* Capabilities Register */
> +#define  PCI_DLF_LOCAL_DLF_SUP_MASK	0x007fffff  /* Local Data Link Feature Supported */
> +#define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchange Enable */
> +#define PCI_DLF_STS		0x08	/* Status Register */
> +#define  PCI_DLF_REMOTE_DLF_SUP_MASK	0x007fffff  /* Remote Data Link Feature Supported */
> +#define  PCI_DLF_REMOTE_DLF_SUP_VALID	0x80000000  /* Remote Data Link Feature Support Valid */
> +
> +/* Physical Layer 16.0 GT/s */
> +#define PCI_PL_16GT_CAP		0x04	/* Capabilities Register */
> +#define PCI_PL_16GT_CTRL	0x08	/* Control Register */
> +#define PCI_PL_16GT_STS		0x0c	/* Status Register */
> +#define PCI_PL_16GT_LDPM_STS	0x10	/* Local Data Parity Mismatch Status Register */
> +#define PCI_PL_16GT_FRDPM_STS	0x14	/* First Retimer Data Parity Mismatch Status Register */
> +#define PCI_PL_16GT_SRDPM_STS	0x18	/* Second Retimer Data Parity Mismatch Status Register */
> +#define PCI_PL_16GT_RSVD	0x1C	/* Reserved */
> +#define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
> +
>  #endif /* LINUX_PCI_REGS_H */
> -- 
> 2.17.1
> 
