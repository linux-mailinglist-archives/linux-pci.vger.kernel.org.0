Return-Path: <linux-pci+bounces-34008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395DFB257AE
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9362A862D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A52F2910;
	Wed, 13 Aug 2025 23:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf3gVVL5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92872F60A3;
	Wed, 13 Aug 2025 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128622; cv=none; b=LbvSPxHgXjA61hT0lRV8wK/nAwzOMPWwQCrQKM+gvdd2yep88sGub9uOzi9WPRCxcIVW3+kzIHsXtAvbnhh5xMXVpBI/J5nH04leSdV5My5AdwGYkAW6odK01SkIF+VyMCrZSm8gwQM+HJRCsvaT1CkbXaQ1G/a24RReIF3uHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128622; c=relaxed/simple;
	bh=WUD+5LHRgd0cb5qv3B4qv6yYvMfh5Md8/8sWpd8KB2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtB+Wex0mLTRcir2CG5VvBqU0sglXP92yqAdaq4ElCDuCauoOv72vd0GwAo6GeBlFq3liQ2otQxVv7E+M49xmzrrPUSP8GOZvwqg/vUNMgCvR8KGjAaRivfSmsJqfyffaZvQXN+3wV179WybKcR3SVff+A3aUats53IY4ulIqTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mf3gVVL5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2ea94c7dso722244b3a.2;
        Wed, 13 Aug 2025 16:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755128620; x=1755733420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IK1UDAHqrS6Wwx5cnSreU+fQQkZ3UY1M1lvt1651jyo=;
        b=mf3gVVL5a3bsd76hRquf4M/zDJudjuO6mpnBXdY/WXxBHFs8uCYhAp2PikRyuCrq/q
         ley4aGMcQPjEJyZ50ozG2/xhTWIWxD5s/XBGsfGRn6r0wHW0EbCBRgAMiH2kT5H7A0Ko
         +3zP9kF/hDUUWCw1WpfefCAsvMErHS+At5arCrxPbgmQOxOkx3KZihYdj1bgomhd+P6n
         jaYBPDQvnLmuOVBTd/X+OZt69SHu16IO1j22xT2zBm5epw1lxzvW32Z1zW+PuctoGxXR
         BcoaOL+ka8wIk2IQgWTRQNgx660ofX2/YCaMW+CNFPug+u2oBHbUTPHzeVuACsMVxsDB
         kO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755128620; x=1755733420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK1UDAHqrS6Wwx5cnSreU+fQQkZ3UY1M1lvt1651jyo=;
        b=M7bQ6NLSkvUauCTjNWkNrCLyDGB+An54qWx82rXFd6PSWhmatjM0gTXK6+FPTGgocg
         oG6jcKW5Q3zp3Jcrbm+RaGLLoxZi5JL4q7l2aX+34J43iLreF82Fj37AkWVuBIW0dIWu
         S0cfw/gQJnMzGW1x8sVMOoyRieinhVI2TvGy6OD+CHxynnmW7aEqaXS4UeqR3kgsN4Vt
         lRqNOOlw/0xE0BVjV8NZJsI2KF8RZUAI7G5W+UopIeiEoSQUP/kQbMpV05Y1XTL27q1W
         wFw9tz2WjBioVRug7GOKLRqy5BB5X7g0SGtMZkdaYHr5Mqdf38Hipjml0qEM4l0et9yj
         5S7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAX4aO3BFmbMetsuAGm6wgU+H61HSkpJ8QLBR8sl7aNK7FlSkhRdt0zjRerwneKqjS4KIWa/Dww9A4@vger.kernel.org, AJvYcCVoV99fCkTzBhgR9vuT3ZHCVcmGL3qvhBXJp30NgtexWbhU1OHQEMJeepwzrM1/F8Z0WD6qppoHLtPmoFzn@vger.kernel.org, AJvYcCXtT45KdqM5xwXqQqhXYcSfTzNexm3LkO7nMzZqEJKXWsfpXa62tubM0MKCY0Qnbju9q/CsKv96RBNm@vger.kernel.org
X-Gm-Message-State: AOJu0YzpD+7dbSuFGLpjeqfsmT6OwJXGcFXRud8JIeMkmhRzVvKQD5So
	eeXI4ChRSZyxfi5H2bulqcvF3CpeBefbcDkIUivjKkuYnqTfXz4f+GoD
X-Gm-Gg: ASbGnctNEIQW7OvHwar6iS+LAj1Jj9pITGH1SEcTAoEXHZJJ9zvpwQUVnPRfjW8RHoH
	NjFv016StZqQUryQix6/z+flLqRCTflVgzFic7qqts05ZBGVOEKUo77/oaWYVWgD8eK75B2XxKt
	WZU5u+2f8kWyp3hevxTz4R87eXxhk8vHJXvQY2mQ+ikuFsabyLXTTcpeEvs9Nr1Rd2wSHXpD8+4
	1w7kA/Oy35zhsFgUKVnKP76sIfsNDqt/vhVYN1T3voQ/OToK6qZIL6znc9PlDjYD3/F+MWAazkw
	iMcOPZngRPKW1q2DBh0c63dsBf9rOxzbVPzJH1BCZT7e5YUHu95LTy0Ssp4poQxPrDel6JoBhWN
	CKJ6LX7yW+dwGk9Zs0h5f/g==
X-Google-Smtp-Source: AGHT+IFHE6Y9GCZJmlkIBg9XHe8uvOA+KyOLQ6/iXAbyBbilyGyOB9TjvMRcZT/9gWJGKiyaE/2RvQ==
X-Received: by 2002:a05:6a00:1995:b0:76b:e144:1d91 with SMTP id d2e1a72fcca58-76e2fd72ca2mr1422050b3a.16.1755128619716;
        Wed, 13 Aug 2025 16:43:39 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76bccfbce4bsm32612704b3a.77.2025.08.13.16.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 16:43:38 -0700 (PDT)
Date: Thu, 14 Aug 2025 07:42:48 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alex Elder <elder@riscstar.com>, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org
Cc: dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de, tglx@linutronix.de, 
	johan+linaro@kernel.org, thippeswamy.havalige@amd.com, namcao@linutronix.de, 
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, inochiama@gmail.com, 
	quic_schintav@quicinc.com, fan.ni@samsung.com, devicetree@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, spacemit@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Junzhong Pan <panjunzhong@linux.spacemit.com>
Subject: Re: [PATCH 4/6] phy: spacemit: introduce PCIe/combo PHY
Message-ID: <valmrbddij2dn4fjxefr46zud2u6eco2isyaa62sd66d27foyl@4hrhafqftgb5>
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-5-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813184701.2444372-5-elder@riscstar.com>

On Wed, Aug 13, 2025 at 01:46:58PM -0500, Alex Elder wrote:
> Introduce a driver that supports three PHYs found on the SpacemiT
> K1 SoC.  The first PHY is a combo PHY that can be configured for
> use for either USB 3 or PCIe.  The other two PHYs support PCIe
> only.
> 
> All three PHYs must be programmed with an 8 bit receiver termination
> value, which must be determined dynamically; only the combo PHY is
> able to determine this value.  The combo PHY performs a special
> calibration step at probe time to discover this, and that value is
> used to program each PHY that operates in PCIe mode.  The combo
> PHY must therefore be probed--first--if either of the PCIe-only
> PHYs will be used.
> 
> During normal operation, the USB or PCIe driver using the PHY must
> ensure clocks and resets are set up properly.  However clocks are
> enabled and resets are de-asserted temporarily by this driver to
> perform the calibration step on the combo PHY.
> 
> Tested-by: Junzhong Pan <panjunzhong@linux.spacemit.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  drivers/phy/Kconfig                |  11 +
>  drivers/phy/Makefile               |   1 +
>  drivers/phy/phy-spacemit-k1-pcie.c | 639 +++++++++++++++++++++++++++++
>  3 files changed, 651 insertions(+)
>  create mode 100644 drivers/phy/phy-spacemit-k1-pcie.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 58c911e1b2d20..0fa343203f289 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -101,6 +101,17 @@ config PHY_NXP_PTN3222
>  	  schemes. It supports all three USB 2.0 data rates: Low Speed, Full
>  	  Speed and High Speed.
>  
> +config PHY_SPACEMIT_K1_PCIE
> +	tristate "PCIe and combo PHY driver for the SpacemiT K1 SoC"
> +	depends on ARCH_SPACEMIT || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	depends on OF
> +	select GENERIC_PHY
> +	default ARCH_SPACEMIT
> +	help
> +	  Enable support for the PCIe and USB 3 combo PHY and two
> +	  PCIe-only PHYs used in the SpacemiT K1 SoC.
> +
>  source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index c670a8dac4680..20f0078e543c7 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_PHY_SNPS_EUSB2)		+= phy-snps-eusb2.o
>  obj-$(CONFIG_USB_LGM_PHY)		+= phy-lgm-usb.o
>  obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
>  obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
> +obj-$(CONFIG_PHY_SPACEMIT_K1_PCIE)	+= phy-spacemit-k1-pcie.o
>  obj-y					+= allwinner/	\
>  					   amlogic/	\
>  					   broadcom/	\
> diff --git a/drivers/phy/phy-spacemit-k1-pcie.c b/drivers/phy/phy-spacemit-k1-pcie.c
> new file mode 100644
> index 0000000000000..32dce53170fbb
> --- /dev/null
> +++ b/drivers/phy/phy-spacemit-k1-pcie.c
> @@ -0,0 +1,639 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SpacemiT K1 PCIe and PCIe/USB 3 combo PHY driver
> + *
> + * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include <dt-bindings/phy/phy.h>
> +
> +/*
> + * Three PCIe ports are supported in the SpacemiT K1 SoC, and this driver
> + * supports their PHYs.
> + *
> + * The PHY for PCIe port A is different from the PHYs for ports B and C:
> + * - It has one lane, while ports B and C have two
> + * - It is a combo PHY can be used for PCIe or USB 3
> + * - It can automatically calibrate PCIe TX and RX termination settings
> + *
> + * The PHY functionality for PCIe ports B and C is identical:
> + * - They have two PCIe lanes (but can be restricted to 1 via Device Tree)
> + * - They are used for PCIe only
> + * - They are configured using TX and RX values computed for port A
> + *
> + * A given board is designed to use the combo PHY for either PCIe or USB 3.
> + * Whether the combo PHY is configured for PCIe or USB 3 is specified in
> + * Device Tree using a phandle plus an argument.  The argument indicates
> + * the type (either PHY_TYPE_PCIE or PHY_TYPE_USB3).
> + *
> + * Each PHY depends on clocks and resets provided by the controller
> + * hardware (PCIe or USB) it is associated with.  The controller drivers
> + * are required to enable any clocks and de-assert any resets that affect
> + * PHY operation.
> + *
> + * PCIe PHYs must be programmed with RX and TX calibration values.  The
> + * combo PHY is the only one that can determine these values.  They are
> + * determined by temporarily enabling the combo PHY in PCIe mode at probe
> + * time (if necessary).  This calibration only needs to be done once, and
> + * when it has completed the TX and RX values are saved.
> + *
> + * To allow the combo PHY to be enabled for calibration, the resets and
> + * clocks it uses in PCIe mode must be supplied.
> + */
> +
> +struct k1_pcie_phy {
> +	struct device *dev;		/* PHY provider device */
> +	struct phy *phy;
> +	void __iomem *regs;
> +	u32 pcie_lanes;			/* Max unless limited by DT */
> +	/* The remaining fields are only used for the combo PHY */
> +	u32 type;			/* PHY_TYPE_PCIE or PHY_TYPE_USB3 */
> +	struct regmap *pmu;
> +};
> +
> +#define CALIBRATION_TIMEOUT		500000	/* microseconds */
> +#define PLL_TIMEOUT			500000	/* microseconds */
> +#define POLL_DELAY			500	/* microseconds */
> +
> +/* Selecting the combo PHY operating mode requires PMU regmap access */
> +#define SYSCON_PMU			"spacemit,syscon-pmu"
> +
> +/* PMU space, for selecting between PCIe and USB3 mode on the combo PHY */
> +
> +#define PMUA_USB_PHY_CTRL0			0x0110
> +#define COMBO_PHY_SEL			BIT(3)	/* 0: PCIe; 1: USB3 */
> +
> +#define PCIE_CLK_RES_CTRL			0x03cc
> +#define PCIE_APP_HOLD_PHY_RST		BIT(30)
> +
> +/* PHY register space */
> +
> +/* Offset between lane 0 and lane 1 registers when there are two */
> +#define PHY_LANE_OFFSET				0x0400
> +
> +#define PCIE_PU_ADDR_CLK_CFG			0x0008
> +#define PLL_READY			BIT(0)		/* read-only */
> +#define CFG_RXCLK_EN			BIT(3)
> +#define CFG_TXCLK_EN			BIT(4)
> +#define CFG_PCLK_EN			BIT(5)
> +#define CFG_PIPE_PCLK_EN		BIT(6)
> +#define CFG_INTERNAL_TIMER_ADJ		GENMASK(10, 7)
> +#define TIMER_ADJ_USB		0x2
> +#define TIMER_ADJ_PCIE		0x6
> +#define CFG_SW_PHY_INIT_DONE		BIT(11)	/* We set after PLL config */
> +
> +#define PCIE_RC_DONE_STATUS			0x0018
> +#define CFG_FORCE_RCV_RETRY		BIT(10)
> +
> +#define PCIE_RC_CAL_REG2			0x0020
> +#define RC_CAL_TOGGLE			BIT(22)
> +#define CLKSEL				GENMASK(31, 29)
> +#define CLKSEL_24M		0x3
> +
> +#define PCIE_PU_PLL_1				0x0048
> +#define REF_100_WSSC			BIT(12)	/* 1: input is 100MHz, SSC */
> +#define FREF_SEL			GENMASK(15, 13)
> +#define FREF_24M		0x1
> +#define SSC_DEP_SEL			GENMASK(19, 16)
> +#define SSC_DEP_NONE		0x0
> +#define SSC_DEP_5000PPM		0xa
> +#define SSC_MODE			GENMASK(21, 20)
> +#define SSC_MODE_DOWN_SPREAD	0x3
> +#define SSC_OFFSET			GENMASK(23, 22)
> +#define SSC_OFFSET_0_PPM	0x0
> +
> +#define PCIE_PU_PLL_2				0x004c
> +#define GEN_REF100			BIT(4)	/* 1: generate 100MHz clk */
> +
> +#define PCIE_RX_REG1				0x0050
> +#define EN_RTERM			BIT(3)
> +#define AFE_RTERM_REG			GENMASK(11, 8)
> +
> +#define PCIE_RX_REG2				0x0054
> +#define RX_RTERM_SEL			BIT(5)	/* 0: use AFE_RTERM_REG value */
> +
> +#define PCIE_LTSSM_DIS_ENTRY			0x005c
> +#define CFG_REFCLK_MODE			GENMASK(9, 8)
> +#define RFCLK_MODE_DRIVER	0x1
> +#define OVRD_REFCLK_MODE		BIT(10)	/* 1: use CFG_RFCLK_MODE */
> +
> +#define PCIE_TX_REG1				0x0064
> +#define TX_RTERM_REG			GENMASK(15, 12)
> +#define TX_RTERM_SEL			BIT(25)	/* 1: use TX_RTERM_REG */
> +
> +#define USB3_TEST_CTRL				0x0068
> +
> +#define PCIE_RCAL_RESULT			0x0084	/* Port A PHY only */
> +#define RTERM_VALUE_RX			GENMASK(3, 0)
> +#define RTERM_VALUE_TX			GENMASK(7, 4)
> +#define R_TUNE_DONE			BIT(10)
> +
> +static u32 k1_phy_rterm = ~0;     /* Invalid initial value */
> +
> +/* Save the RX and TX receiver termination values */
> +static void k1_phy_rterm_set(u32 val)
> +{
> +	k1_phy_rterm = val & (RTERM_VALUE_RX | RTERM_VALUE_TX);
> +}
> +
> +static bool k1_phy_rterm_valid(void)
> +{
> +	/* Valid if no bits outside those we care about are set */
> +	return !(k1_phy_rterm & ~(RTERM_VALUE_RX | RTERM_VALUE_TX));
> +}
> +
> +static u32 k1_phy_rterm_rx(void)
> +{
> +	return FIELD_GET(RTERM_VALUE_RX, k1_phy_rterm);
> +}
> +
> +static u32 k1_phy_rterm_tx(void)
> +{
> +	return FIELD_GET(RTERM_VALUE_TX, k1_phy_rterm);
> +}
> +
> +/* Only the combo PHY has a PMU pointer defined */
> +static bool k1_phy_port_a(struct k1_pcie_phy *k1_phy)
> +{
> +	return !!k1_phy->pmu;
> +}
> +
> +/*
> + * Select PCIe or USB 3 mode for the combo PHY.  Return 1 if the bit
> + * was changed, 0 if it was not, or a negative error value otherwise.
> + */
> +static int k1_combo_phy_sel(struct k1_pcie_phy *k1_phy, bool usb3)
> +{
> +	int ret;
> +
> +	ret = regmap_test_bits(k1_phy->pmu, PMUA_USB_PHY_CTRL0, COMBO_PHY_SEL);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* If it's already in the desired state, we're done */
> +	if (!!ret == usb3)
> +		return 0;
> +
> +	/* Change the bit */
> +	ret = regmap_assign_bits(k1_phy->pmu, PMUA_USB_PHY_CTRL0,
> +				 COMBO_PHY_SEL, usb3);
> +
> +	return ret < 0 ? ret : 1;
> +}
> +

> +static void k1_pcie_phy_init_pll(struct k1_pcie_phy *k1_phy,
> +				 void __iomem *regs, bool pcie)
> +{
> +	void __iomem *virt;
> +	u32 timer_adj;
> +	u32 ssc_dep;
> +	u32 val;
> +
> +	if (pcie) {
> +		timer_adj = TIMER_ADJ_PCIE;
> +		ssc_dep = SSC_DEP_NONE;
> +	} else {
> +		timer_adj = TIMER_ADJ_USB;
> +		ssc_dep = SSC_DEP_5000PPM;
> +	}
> +
> +	/*
> +	 * Disable 100 MHz input reference with spread-spectrum
> +	 * clocking and select the 24 MHz clock input frequency
> +	 */
> +	virt = k1_phy->regs + PCIE_PU_PLL_1;
> +	val = readl(virt);
> +	val &= ~REF_100_WSSC;
> +
> +	val &= ~FREF_SEL;
> +	val |= FIELD_PREP(FREF_SEL, FREF_24M);
> +
> +	val &= ~SSC_DEP_SEL;
> +	val |= FIELD_PREP(SSC_DEP_SEL, ssc_dep);
> +
> +	val &= ~SSC_MODE;
> +	val |= FIELD_PREP(SSC_MODE, SSC_MODE_DOWN_SPREAD);
> +
> +	val &= ~SSC_OFFSET;
> +	val |= FIELD_PREP(SSC_OFFSET, SSC_OFFSET_0_PPM);
> +	writel(val, virt);
> +
> +	if (pcie) {
> +		virt = regs + PCIE_PU_PLL_2;
> +		val = readl(virt);
> +		val |= GEN_REF100;	/* Enable 100 MHz PLL output clock */
> +		writel(val, virt);
> +	}
> +
> +	/* Enable clocks and mark PLL initialization done */
> +	virt = regs + PCIE_PU_ADDR_CLK_CFG;
> +	val = readl(virt);
> +	val |= CFG_RXCLK_EN;
> +	val |= CFG_TXCLK_EN;
> +	val |= CFG_PCLK_EN;
> +	val |= CFG_PIPE_PCLK_EN;
> +
> +	val &= ~CFG_INTERNAL_TIMER_ADJ;
> +	val |= FIELD_PREP(CFG_INTERNAL_TIMER_ADJ, timer_adj);
> +
> +	val |= CFG_SW_PHY_INIT_DONE;
> +	writel(val, virt);
> +}
> +
> +static int k1_pcie_pll_lock(struct k1_pcie_phy *k1_phy, bool pcie)
> +{
> +	u32 val = pcie ? CFG_FORCE_RCV_RETRY : 0;
> +	void __iomem *virt;
> +
> +	writel(val, k1_phy->regs + PCIE_RC_DONE_STATUS);
> +
> +	/*
> +	 * Wait for indication the PHY PLL is locked.  Lanes for ports
> +	 * B and C share a PLL, so it's enough to sample just lane 0.
> +	 */
> +	virt = k1_phy->regs + PCIE_PU_ADDR_CLK_CFG;	/* Lane 0 */
> +
> +	return readl_poll_timeout(virt, val, val & PLL_READY,
> +				  POLL_DELAY, PLL_TIMEOUT);
> +}
> +

Can we use standard clk_ops and clk_mux to normalize this process?

Regards,
Inochi

