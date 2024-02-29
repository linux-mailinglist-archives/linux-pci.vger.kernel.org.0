Return-Path: <linux-pci+bounces-4236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD30386C67D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 11:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D24F1C20D77
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 10:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBBA63CB4;
	Thu, 29 Feb 2024 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deKmNk14"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24026351E;
	Thu, 29 Feb 2024 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201518; cv=none; b=rQ2cdx1NT7komXImrZ5hNA6tt8GhApQg4fMqYo0P9GIqbLiNOA0m+MK/b1HG3064MAnvra8/+lXgWzRCDrF90BHzjRIXLvzXPKN62Bqj0zVp1+9HHVwsfn2CZbGu5RvPtjwXxY/AjQKz0IpEP2XFoGWOo2sYtduC2rxfRp4wnz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201518; c=relaxed/simple;
	bh=ys71Qx73aPY+VvXGSfhGOgZv22qzv2kHK8MnQN0BY3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBq6WtakBaokLaOqwSG9tnYl4duQBudswxwMFOOW2Jnrdxv4sz84vlpAEdRVJ2dVt4G3gNQ8rsQ4qjD6gK9XeKNFOatpoQDcBwazlkoM6weyZ8BKQ3OW8uGyVZ/oWn03so8i5P3YK+O8o3z2CMhEAJVBI9W83sTdiApefO/MeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deKmNk14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23793C433C7;
	Thu, 29 Feb 2024 10:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709201518;
	bh=ys71Qx73aPY+VvXGSfhGOgZv22qzv2kHK8MnQN0BY3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=deKmNk14SQ6tTxx6rCfLZzN7hYIKIW75kokl9PfIG3cbavQCl+/a8Fn+QN6hQzrNd
	 AFukfcZrb+eD1Ze2axFkIf7NWk9FbeUQqAslWdbF/ISVmtdLftZm6l3VDiDz1CDtYC
	 BFOFHGA/YHiU9AgfYSrkXEi9YvTi2hyEjPobAsFOYmZOVqVHP7Noy/0QoeqTkPn9F/
	 IHuqN6F7zcmPzKeo1Z4VDE4moJQ0L2UT4Y2o8nymSq/2mBBimd+uoqsCrDV+JN8Wp/
	 Sl7bMONcGrdVL+Dn92ZgAju2hvsIKt8TE58IQUN+pRbkuzrX0JVJncA468Mr63y2BQ
	 Tdh9/Wb0UK9cA==
Date: Thu, 29 Feb 2024 11:11:50 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v15,RESEND 03/23] PCI: microchip: Move PLDA IP register
 macros to pcie-plda.h
Message-ID: <ZeBYZtxqqXn5TlvL@lpieralisi>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
 <20240227103522.80915-4-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227103522.80915-4-minda.chen@starfivetech.com>

On Tue, Feb 27, 2024 at 06:35:02PM +0800, Minda Chen wrote:
> Move PLDA PCIe host controller IP registers macros to pcie-plda.h,
> including bridge registers and PLDA IRQ event number.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  MAINTAINERS                                   |   8 ++
>  .../pci/controller/plda/pcie-microchip-host.c | 108 +++---------------
>  drivers/pci/controller/plda/pcie-plda.h       | 108 ++++++++++++++++++
>  3 files changed, 132 insertions(+), 92 deletions(-)
>  create mode 100644 drivers/pci/controller/plda/pcie-plda.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9f7e907c8749..fc9576e69a71 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16814,6 +16814,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
>  F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
>  
> +PCI DRIVER FOR PLDA PCIE IP
> +M:	Daire McNamara <daire.mcnamara@microchip.com>
> +M:	Kevin Xie <kevin.xie@starfivetech.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/plda,*

This is an unrelated change. It belongs to the patch adding DT bindings
or I am reading it wrong ?

Lorenzo

> +F:	drivers/pci/controller/plda/*plda*
> +
>  PCI DRIVER FOR RENESAS R-CAR
>  M:	Marek Vasut <marek.vasut+renesas@gmail.com>
>  M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> index cb09a8137e25..d9030d550482 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -19,6 +19,7 @@
>  #include <linux/platform_device.h>
>  
>  #include "../../pci.h"
> +#include "pcie-plda.h"
>  
>  /* Number of MSI IRQs */
>  #define MC_MAX_NUM_MSI_IRQS			32
> @@ -30,84 +31,6 @@
>  #define MC_PCIE_BRIDGE_ADDR			(MC_PCIE1_BRIDGE_ADDR)
>  #define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
>  
> -/* PCIe Bridge Phy Regs */
> -#define PCIE_PCI_IRQ_DW0			0xa8
> -#define  MSIX_CAP_MASK				BIT(31)
> -#define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
> -#define  NUM_MSI_MSGS_SHIFT			4
> -
> -#define IMASK_LOCAL				0x180
> -#define  DMA_END_ENGINE_0_MASK			0x00000000u
> -#define  DMA_END_ENGINE_0_SHIFT			0
> -#define  DMA_END_ENGINE_1_MASK			0x00000000u
> -#define  DMA_END_ENGINE_1_SHIFT			1
> -#define  DMA_ERROR_ENGINE_0_MASK		0x00000100u
> -#define  DMA_ERROR_ENGINE_0_SHIFT		8
> -#define  DMA_ERROR_ENGINE_1_MASK		0x00000200u
> -#define  DMA_ERROR_ENGINE_1_SHIFT		9
> -#define  A_ATR_EVT_POST_ERR_MASK		0x00010000u
> -#define  A_ATR_EVT_POST_ERR_SHIFT		16
> -#define  A_ATR_EVT_FETCH_ERR_MASK		0x00020000u
> -#define  A_ATR_EVT_FETCH_ERR_SHIFT		17
> -#define  A_ATR_EVT_DISCARD_ERR_MASK		0x00040000u
> -#define  A_ATR_EVT_DISCARD_ERR_SHIFT		18
> -#define  A_ATR_EVT_DOORBELL_MASK		0x00000000u
> -#define  A_ATR_EVT_DOORBELL_SHIFT		19
> -#define  P_ATR_EVT_POST_ERR_MASK		0x00100000u
> -#define  P_ATR_EVT_POST_ERR_SHIFT		20
> -#define  P_ATR_EVT_FETCH_ERR_MASK		0x00200000u
> -#define  P_ATR_EVT_FETCH_ERR_SHIFT		21
> -#define  P_ATR_EVT_DISCARD_ERR_MASK		0x00400000u
> -#define  P_ATR_EVT_DISCARD_ERR_SHIFT		22
> -#define  P_ATR_EVT_DOORBELL_MASK		0x00000000u
> -#define  P_ATR_EVT_DOORBELL_SHIFT		23
> -#define  PM_MSI_INT_INTA_MASK			0x01000000u
> -#define  PM_MSI_INT_INTA_SHIFT			24
> -#define  PM_MSI_INT_INTB_MASK			0x02000000u
> -#define  PM_MSI_INT_INTB_SHIFT			25
> -#define  PM_MSI_INT_INTC_MASK			0x04000000u
> -#define  PM_MSI_INT_INTC_SHIFT			26
> -#define  PM_MSI_INT_INTD_MASK			0x08000000u
> -#define  PM_MSI_INT_INTD_SHIFT			27
> -#define  PM_MSI_INT_INTX_MASK			0x0f000000u
> -#define  PM_MSI_INT_INTX_SHIFT			24
> -#define  PM_MSI_INT_MSI_MASK			0x10000000u
> -#define  PM_MSI_INT_MSI_SHIFT			28
> -#define  PM_MSI_INT_AER_EVT_MASK		0x20000000u
> -#define  PM_MSI_INT_AER_EVT_SHIFT		29
> -#define  PM_MSI_INT_EVENTS_MASK			0x40000000u
> -#define  PM_MSI_INT_EVENTS_SHIFT		30
> -#define  PM_MSI_INT_SYS_ERR_MASK		0x80000000u
> -#define  PM_MSI_INT_SYS_ERR_SHIFT		31
> -#define  NUM_LOCAL_EVENTS			15
> -#define ISTATUS_LOCAL				0x184
> -#define IMASK_HOST				0x188
> -#define ISTATUS_HOST				0x18c
> -#define IMSI_ADDR				0x190
> -#define ISTATUS_MSI				0x194
> -
> -/* PCIe Master table init defines */
> -#define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
> -#define  ATR0_PCIE_ATR_SIZE			0x25
> -#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
> -#define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
> -#define ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
> -#define ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
> -#define ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
> -
> -/* PCIe AXI slave table init defines */
> -#define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
> -#define  ATR_SIZE_SHIFT				1
> -#define  ATR_IMPL_ENABLE			1
> -#define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
> -#define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
> -#define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
> -#define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
> -#define  PCIE_TX_RX_INTERFACE			0x00000000u
> -#define  PCIE_CONFIG_INTERFACE			0x00000001u
> -
> -#define ATR_ENTRY_SIZE				32
> -
>  /* PCIe Controller Phy Regs */
>  #define SEC_ERROR_EVENT_CNT			0x20
>  #define DED_ERROR_EVENT_CNT			0x24
> @@ -179,20 +102,21 @@
>  #define EVENT_LOCAL_DMA_END_ENGINE_1		12
>  #define EVENT_LOCAL_DMA_ERROR_ENGINE_0		13
>  #define EVENT_LOCAL_DMA_ERROR_ENGINE_1		14
> -#define EVENT_LOCAL_A_ATR_EVT_POST_ERR		15
> -#define EVENT_LOCAL_A_ATR_EVT_FETCH_ERR		16
> -#define EVENT_LOCAL_A_ATR_EVT_DISCARD_ERR	17
> -#define EVENT_LOCAL_A_ATR_EVT_DOORBELL		18
> -#define EVENT_LOCAL_P_ATR_EVT_POST_ERR		19
> -#define EVENT_LOCAL_P_ATR_EVT_FETCH_ERR		20
> -#define EVENT_LOCAL_P_ATR_EVT_DISCARD_ERR	21
> -#define EVENT_LOCAL_P_ATR_EVT_DOORBELL		22
> -#define EVENT_LOCAL_PM_MSI_INT_INTX		23
> -#define EVENT_LOCAL_PM_MSI_INT_MSI		24
> -#define EVENT_LOCAL_PM_MSI_INT_AER_EVT		25
> -#define EVENT_LOCAL_PM_MSI_INT_EVENTS		26
> -#define EVENT_LOCAL_PM_MSI_INT_SYS_ERR		27
> -#define NUM_EVENTS				28
> +#define NUM_MC_EVENTS				15
> +#define EVENT_LOCAL_A_ATR_EVT_POST_ERR		(NUM_MC_EVENTS + PLDA_AXI_POST_ERR)
> +#define EVENT_LOCAL_A_ATR_EVT_FETCH_ERR		(NUM_MC_EVENTS + PLDA_AXI_FETCH_ERR)
> +#define EVENT_LOCAL_A_ATR_EVT_DISCARD_ERR	(NUM_MC_EVENTS + PLDA_AXI_DISCARD_ERR)
> +#define EVENT_LOCAL_A_ATR_EVT_DOORBELL		(NUM_MC_EVENTS + PLDA_AXI_DOORBELL)
> +#define EVENT_LOCAL_P_ATR_EVT_POST_ERR		(NUM_MC_EVENTS + PLDA_PCIE_POST_ERR)
> +#define EVENT_LOCAL_P_ATR_EVT_FETCH_ERR		(NUM_MC_EVENTS + PLDA_PCIE_FETCH_ERR)
> +#define EVENT_LOCAL_P_ATR_EVT_DISCARD_ERR	(NUM_MC_EVENTS + PLDA_PCIE_DISCARD_ERR)
> +#define EVENT_LOCAL_P_ATR_EVT_DOORBELL		(NUM_MC_EVENTS + PLDA_PCIE_DOORBELL)
> +#define EVENT_LOCAL_PM_MSI_INT_INTX		(NUM_MC_EVENTS + PLDA_INTX)
> +#define EVENT_LOCAL_PM_MSI_INT_MSI		(NUM_MC_EVENTS + PLDA_MSI)
> +#define EVENT_LOCAL_PM_MSI_INT_AER_EVT		(NUM_MC_EVENTS + PLDA_AER_EVENT)
> +#define EVENT_LOCAL_PM_MSI_INT_EVENTS		(NUM_MC_EVENTS + PLDA_MISC_EVENTS)
> +#define EVENT_LOCAL_PM_MSI_INT_SYS_ERR		(NUM_MC_EVENTS + PLDA_SYS_ERR)
> +#define NUM_EVENTS				(NUM_MC_EVENTS + PLDA_INT_EVENT_NUM)
>  
>  #define PCIE_EVENT_CAUSE(x, s)	\
>  	[EVENT_PCIE_ ## x] = { __stringify(x), s }
> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
> new file mode 100644
> index 000000000000..65e0f3b72184
> --- /dev/null
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PLDA PCIe host controller driver
> + */
> +
> +#ifndef _PCIE_PLDA_H
> +#define _PCIE_PLDA_H
> +
> +/* PCIe Bridge Phy Regs */
> +#define PCIE_PCI_IRQ_DW0			0xa8
> +#define  MSIX_CAP_MASK				BIT(31)
> +#define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
> +#define  NUM_MSI_MSGS_SHIFT			4
> +
> +#define IMASK_LOCAL				0x180
> +#define  DMA_END_ENGINE_0_MASK			0x00000000u
> +#define  DMA_END_ENGINE_0_SHIFT			0
> +#define  DMA_END_ENGINE_1_MASK			0x00000000u
> +#define  DMA_END_ENGINE_1_SHIFT			1
> +#define  DMA_ERROR_ENGINE_0_MASK		0x00000100u
> +#define  DMA_ERROR_ENGINE_0_SHIFT		8
> +#define  DMA_ERROR_ENGINE_1_MASK		0x00000200u
> +#define  DMA_ERROR_ENGINE_1_SHIFT		9
> +#define  A_ATR_EVT_POST_ERR_MASK		0x00010000u
> +#define  A_ATR_EVT_POST_ERR_SHIFT		16
> +#define  A_ATR_EVT_FETCH_ERR_MASK		0x00020000u
> +#define  A_ATR_EVT_FETCH_ERR_SHIFT		17
> +#define  A_ATR_EVT_DISCARD_ERR_MASK		0x00040000u
> +#define  A_ATR_EVT_DISCARD_ERR_SHIFT		18
> +#define  A_ATR_EVT_DOORBELL_MASK		0x00000000u
> +#define  A_ATR_EVT_DOORBELL_SHIFT		19
> +#define  P_ATR_EVT_POST_ERR_MASK		0x00100000u
> +#define  P_ATR_EVT_POST_ERR_SHIFT		20
> +#define  P_ATR_EVT_FETCH_ERR_MASK		0x00200000u
> +#define  P_ATR_EVT_FETCH_ERR_SHIFT		21
> +#define  P_ATR_EVT_DISCARD_ERR_MASK		0x00400000u
> +#define  P_ATR_EVT_DISCARD_ERR_SHIFT		22
> +#define  P_ATR_EVT_DOORBELL_MASK		0x00000000u
> +#define  P_ATR_EVT_DOORBELL_SHIFT		23
> +#define  PM_MSI_INT_INTA_MASK			0x01000000u
> +#define  PM_MSI_INT_INTA_SHIFT			24
> +#define  PM_MSI_INT_INTB_MASK			0x02000000u
> +#define  PM_MSI_INT_INTB_SHIFT			25
> +#define  PM_MSI_INT_INTC_MASK			0x04000000u
> +#define  PM_MSI_INT_INTC_SHIFT			26
> +#define  PM_MSI_INT_INTD_MASK			0x08000000u
> +#define  PM_MSI_INT_INTD_SHIFT			27
> +#define  PM_MSI_INT_INTX_MASK			0x0f000000u
> +#define  PM_MSI_INT_INTX_SHIFT			24
> +#define  PM_MSI_INT_MSI_MASK			0x10000000u
> +#define  PM_MSI_INT_MSI_SHIFT			28
> +#define  PM_MSI_INT_AER_EVT_MASK		0x20000000u
> +#define  PM_MSI_INT_AER_EVT_SHIFT		29
> +#define  PM_MSI_INT_EVENTS_MASK			0x40000000u
> +#define  PM_MSI_INT_EVENTS_SHIFT		30
> +#define  PM_MSI_INT_SYS_ERR_MASK		0x80000000u
> +#define  PM_MSI_INT_SYS_ERR_SHIFT		31
> +#define  NUM_LOCAL_EVENTS			15
> +#define ISTATUS_LOCAL				0x184
> +#define IMASK_HOST				0x188
> +#define ISTATUS_HOST				0x18c
> +#define IMSI_ADDR				0x190
> +#define ISTATUS_MSI				0x194
> +
> +/* PCIe Master table init defines */
> +#define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
> +#define  ATR0_PCIE_ATR_SIZE			0x25
> +#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
> +#define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
> +#define ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
> +#define ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
> +#define ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
> +
> +/* PCIe AXI slave table init defines */
> +#define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
> +#define  ATR_SIZE_SHIFT				1
> +#define  ATR_IMPL_ENABLE			1
> +#define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
> +#define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
> +#define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
> +#define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
> +#define  PCIE_TX_RX_INTERFACE			0x00000000u
> +#define  PCIE_CONFIG_INTERFACE			0x00000001u
> +
> +#define ATR_ENTRY_SIZE				32
> +
> +enum plda_int_event {
> +	PLDA_AXI_POST_ERR,
> +	PLDA_AXI_FETCH_ERR,
> +	PLDA_AXI_DISCARD_ERR,
> +	PLDA_AXI_DOORBELL,
> +	PLDA_PCIE_POST_ERR,
> +	PLDA_PCIE_FETCH_ERR,
> +	PLDA_PCIE_DISCARD_ERR,
> +	PLDA_PCIE_DOORBELL,
> +	PLDA_INTX,
> +	PLDA_MSI,
> +	PLDA_AER_EVENT,
> +	PLDA_MISC_EVENTS,
> +	PLDA_SYS_ERR,
> +	PLDA_INT_EVENT_NUM
> +};
> +
> +#define PLDA_NUM_DMA_EVENTS			16
> +
> +#define PLDA_MAX_EVENT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
> +
> +#endif
> -- 
> 2.17.1
> 

