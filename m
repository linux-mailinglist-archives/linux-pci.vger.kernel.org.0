Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C04C104140
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 17:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfKTQrO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 11:47:14 -0500
Received: from foss.arm.com ([217.140.110.172]:42698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbfKTQrN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 11:47:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 243271FB;
        Wed, 20 Nov 2019 08:47:13 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 740D53F703;
        Wed, 20 Nov 2019 08:47:12 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:47:10 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: vmd: Add bus 224-255 restriction decode
Message-ID: <20191120164710.GB3279@e121166-lin.cambridge.arm.com>
References: <1573562873-96828-1-git-send-email-jonathan.derrick@intel.com>
 <1573562873-96828-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573562873-96828-2-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 12, 2019 at 05:47:52AM -0700, Jon Derrick wrote:
> VMD bus restrictions are required when IO fabric is multiplexed such
> that VMD cannot use the entire bus range. This patch adds another bus
> restriction decode bit that can be set by firmware to restrict the VMD
> bus range to between 224-255.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a35d3f3..15302a1 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -602,16 +602,30 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	/*
>  	 * Certain VMD devices may have a root port configuration option which
> -	 * limits the bus range to between 0-127 or 128-255
> +	 * limits the bus range to between 0-127, 128-255, or 224-255
>  	 */
>  	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
> -		u32 vmcap, vmconfig;
> -
> -		pci_read_config_dword(vmd->dev, PCI_REG_VMCAP, &vmcap);
> -		pci_read_config_dword(vmd->dev, PCI_REG_VMCONFIG, &vmconfig);
> -		if (BUS_RESTRICT_CAP(vmcap) &&
> -		    (BUS_RESTRICT_CFG(vmconfig) == 0x1))
> -			vmd->busn_start = 128;
> +		u16 reg16;
> +
> +		pci_read_config_word(vmd->dev, PCI_REG_VMCAP, &reg16);
> +		if (BUS_RESTRICT_CAP(reg16)) {
> +			pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG,
> +					     &reg16);
> +
> +			switch (BUS_RESTRICT_CFG(reg16)) {
> +			case 1:
> +				vmd->busn_start = 128;
> +				break;
> +			case 2:
> +				vmd->busn_start = 224;
> +				break;
> +			case 3:
> +				pci_err(vmd->dev, "Unknown Bus Offset Setting\n");

Technically this error+message should be present in the current kernel
as well but anyway, I have applied the series to pci/vmd.

Thanks,
Lorenzo

> +				return -ENODEV;
> +			default:
> +				break;
> +			}
> +		}
>  	}
>  
>  	res = &vmd->dev->resource[VMD_CFGBAR];
> -- 
> 1.8.3.1
> 
