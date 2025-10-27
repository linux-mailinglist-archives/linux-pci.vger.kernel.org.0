Return-Path: <linux-pci+bounces-39472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 788E4C11ACD
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 23:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A7274E36B8
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F53932C30D;
	Mon, 27 Oct 2025 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="UBgizNvG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9EF32C934
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603885; cv=none; b=JlwpmkOiYe00qPrrFJInrTZKYcR3SNiodNDw1sGvd2uhF384hmtdfkt2D/Fv1wFbfjRd8RUQZoZDrCNsXzhq9tL+SdyDBbKd4QjCMxihgI7UIRLd95crB0e7KO7/tio/vgvkVlboLRlVnosIxMMBH9iDh7tTR3xIvmrGplUuRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603885; c=relaxed/simple;
	bh=Xcq408hetM6crsHaKGXvBpqCz3XmMmxtSfk5IUobHdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZMLV7W35WdBeFQtxm8v+mlZTwuBQ92TScT2ScVgvKy9iB+1MqyhiPUN9rCc39XBe2Br3AxD5zxLooB5+BPFCHbjeFr9RgsYikC+Cpdk4i4MuQUJ+5HET+nl/N4mblOEs6EDwRv1JYGM5sb3WWW0DE4XjCVDDCxpQdmU+oe1gyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=UBgizNvG; arc=none smtp.client-ip=209.85.166.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f193.google.com with SMTP id e9e14a558f8ab-430ccd45f19so56474045ab.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 15:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761603881; x=1762208681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jr15nwP/Ug09JfxnqEKa3Ir4SMHlTRNyD6RAdom2eOw=;
        b=UBgizNvG0t3UPheXNp/gpJFptl3k9OBy0wkF2Z3Ya3YrphfQim2XV8mmrPX2CcIt2l
         ma2DAuEzUYx9fv/CbCE8TYntUCdt7r9zWTG+Szmf87DjMnq5y4E/8cSEWsuTLFAC9DdI
         RRruo3XfhgNycWYgnkgPm/M1xHCjCBVQ85Ozhi9ktTeww2ZprTDu8ZZyv0IBC+K1mh2y
         A3ga5CGY+M1atA3lUfjaoJ6KLsemWV4bhNEItROTz+QPomrmGRHAuwLbDUYbqnfnRyFJ
         urCUzDvgXA+ET0W9n2/6dm+R1VyD29+Bds/UNKbHkYg0X67XHxepaI2vKIbivlBxyY/y
         8hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603881; x=1762208681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jr15nwP/Ug09JfxnqEKa3Ir4SMHlTRNyD6RAdom2eOw=;
        b=aJymSMdk6Mw8+TPWyCmBhWas42/m8dHWZCiJ5tuqvqkayXFtIuSCWJGFTLMPJSvSMo
         HkT4/DjoOFyFaEgEnVbr46q/kfmdg76wIKWJZc5cAs9MQWSGDRDOVXjoiGPYwMIrzTVw
         ERGau+8HBzAr+mkjI4QsXC19ZksBGuHKQ4f3V0WuPP0d2rtLiecwVltvWxy/y5t+RNWS
         9AFbgbvrGjpVV7Y+QPsFBvUd/xG1ZGHkZCdh91cZtgkmI3cf5lgNb+mfIflA5ntUOrQ6
         KczgSO/3++GdRzXd5HbZ5OxXJTvNN49BKB70TAwhm2Wx9vUK29nlXhD5Ehwkdtid2XM3
         2nXA==
X-Forwarded-Encrypted: i=1; AJvYcCVZfPrGi2lkLSOZk6a6ZNEE3Q+Imd7uF1UKkFzXHjZZVib43AjBaxZ7WQwZpTODVaUYJTmIBq45xQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuNrPqkRv+jH46VD0bCi3ZVUxTzU2o2UZv0vbk0ZBjtmFAwLCQ
	m37e7Z40n25qNEm0VUQvpfJPhLVBs4dO/1UHGa++fS3BvskXdmjfgp6xaXwzotk1XlM=
X-Gm-Gg: ASbGnctaicC5eLGS0EcO+PNLZf1I5UQE+OoK5qsX4k4Mq4iOjIDVqPfXwM85ELml8hZ
	KukFuueiOF7K78sHxRIMOQ79P3Nr6YxO9dG3knLZmP18hmiLQxu3nbqezdh+Z4VrQiPcKthWutb
	y7LCNxnkqg0DB1glYvKpqmg5ZoXmJcUbGl/8iGs3tTZREjgr91UfAqfDgTSWcG1DRDcITcjR3rj
	DKIYlAkWra22qTT81hzAbECdbUtviuHwDhE3lOTKpesfp5X3EOyo5V2AQO5zFT+XT6NPRvPsodz
	b0jDb26X5Av94Br7vuhdZfk6Hn17IjB3hmfHK6mVolH04x/sVi2tfGBWsRjYXEgbssYlmynV7wS
	eO6BnIfBLIn9rJogz2oOeIA0BKT6Lb6NZMwRQK3pinjprLDIzSpMoaA/O2uf84lobjR9EBJy6It
	9CwWaWytF1CoOt7U6vwBE6GedJB8yim1PLQ0tvtRUMXCsa0Q3ETrVC2D8tFkZWgg==
X-Google-Smtp-Source: AGHT+IHgtCyDRXbXGEeFm3CmneAKxFqw+KSMjGpOPKv2tB2gnKd/EwLFmdu68D+m31X9cGHwBwMEuA==
X-Received: by 2002:a05:6e02:746:b0:430:ab94:4223 with SMTP id e9e14a558f8ab-4320f6ca731mr24125425ab.8.1761603881057;
        Mon, 27 Oct 2025 15:24:41 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f67dcb0csm35005605ab.5.2025.10.27.15.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 15:24:40 -0700 (PDT)
Message-ID: <4027609d-6396-44c0-a514-11d7fe8a5b58@riscstar.com>
Date: Mon, 27 Oct 2025 17:24:38 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] PCI: spacemit: introduce SpacemiT PCIe host driver
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com, shradha.t@samsung.com,
 krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 namcao@linutronix.de, thippeswamy.havalige@amd.com, inochiama@gmail.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-6-elder@riscstar.com>
 <274772thveml3xq2yc7477b7lywzzwelbjtq3hiy4louc6cqom@o5zq66mqa27h>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <274772thveml3xq2yc7477b7lywzzwelbjtq3hiy4louc6cqom@o5zq66mqa27h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/25 11:55 AM, Manivannan Sadhasivam wrote:
> On Mon, Oct 13, 2025 at 10:35:22AM -0500, Alex Elder wrote:
>> Introduce a driver for the PCIe host controller found in the SpacemiT
>> K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
>> The driver supports three PCIe ports that operate at PCIe gen2 transfer
>> rates (5 GT/sec).  The first port uses a combo PHY, which may be
>> configured for use for USB 3 instead.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - Renamed the PCIe driver source file "pcie-spacemit-k1.c"
>>      - Renamed the PCIe driver Kconfig option PCIE_SPACEMIT_K1; it
>>        is now tristate rather than Boolean
>>      - The PCIe host compatible string is now "spacemit,k1-pcie"
>>      - Renamed the PMU syscon property to be "spacemit,apmu"
>>      - Renamed the symbols representing the PCI vendor and device IDs
>>        to align with <linux/pci_ids.h>
>>      - Use PCIE_T_PVPERL_MS rather than 100 to represent a standard
>>        delay period.
>>      - Use platform (not dev) driver-data access functions; assignment
>>        is done only after the private structure is initialized
>>      - Deleted some unneeded includes in the PCIe driver.
>>      - Dropped error checking when operating on MMIO-backed regmaps
>>      - Added a regmap_read() call in two places, to ensure a specified
>>        delay occurs *after* the a MMIO write has reached its target.
>>      - Used ARRAY_SIZE() (not a local variable value) in a few spots
>>      - Now use readl_relaxed()/writel_relaxed() when operating on
>>        the "link" I/O memory space in the PCIe driver
>>      - Updated a few error messages for consistency
>>      - No longer specify suppress_bind_attrs in the PCIe driver
>>      - Now specify PCIe driver probe type as PROBE_PREFER_ASYNCHRONOUS
>>      - No longer use (void) cast to indicate ignored return values
>>
>>   drivers/pci/controller/dwc/Kconfig            |  10 +
>>   drivers/pci/controller/dwc/Makefile           |   1 +
>>   drivers/pci/controller/dwc/pcie-spacemit-k1.c | 319 ++++++++++++++++++
>>   3 files changed, 330 insertions(+)
>>   create mode 100644 drivers/pci/controller/dwc/pcie-spacemit-k1.c
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index 349d4657393c9..ede59b34c99ba 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -509,6 +509,16 @@ config PCI_KEYSTONE_EP
>>   	  on DesignWare hardware and therefore the driver re-uses the
>>   	  DesignWare core functions to implement the driver.
>>   
>> +config PCIE_SPACEMIT_K1
>> +	tristate "SpacemiT K1 PCIe controller (host mode)"
>> +	depends on ARCH_SPACEMIT || COMPILE_TEST
>> +	depends on PCI && OF && HAS_IOMEM
>> +	select PCIE_DW_HOST
>> +	default ARCH_SPACEMIT
>> +	help
>> +	  Enables support for the PCIe controller in the K1 SoC operating
>> +	  in host mode.
>> +
>>   config PCIE_VISCONTI_HOST
>>   	bool "Toshiba Visconti PCIe controller"
>>   	depends on ARCH_VISCONTI || COMPILE_TEST
>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>> index 7ae28f3b0fb39..662b0a219ddc4 100644
>> --- a/drivers/pci/controller/dwc/Makefile
>> +++ b/drivers/pci/controller/dwc/Makefile
>> @@ -31,6 +31,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>>   obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>>   obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>>   obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
>> +obj-$(CONFIG_PCIE_SPACEMIT_K1) += pcie-spacemit-k1.o
>>   obj-$(CONFIG_PCIE_STM32_HOST) += pcie-stm32.o
>>   obj-$(CONFIG_PCIE_STM32_EP) += pcie-stm32-ep.o
>>   
>> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
>> new file mode 100644
>> index 0000000000000..d58232cbb8a02
>> --- /dev/null
>> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
>> @@ -0,0 +1,319 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * SpacemiT K1 PCIe host driver
>> + *
>> + * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
>> + * Copyright (c) 2023, spacemit Corporation.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/gfp.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +#include <linux/types.h>
>> +
>> +#include "pcie-designware.h"
>> +
>> +#define PCI_VENDOR_ID_SPACEMIT		0x201f
>> +#define PCI_DEVICE_ID_SPACEMIT_K1	0x0001
>> +
>> +/* Offsets and field definitions for link management registers */
>> +
> 
> nit: drop the extra newline

OK.

>> +#define K1_PHY_AHB_IRQ_EN			0x0000
>> +#define PCIE_INTERRUPT_EN		BIT(0)
>> +
>> +#define K1_PHY_AHB_LINK_STS			0x0004
>> +#define SMLH_LINK_UP			BIT(1)
>> +#define RDLH_LINK_UP			BIT(12)
>> +
>> +#define INTR_ENABLE				0x0014
>> +#define MSI_CTRL_INT			BIT(11)
>> +
>> +/* Some controls require APMU regmap access */
>> +#define SYSCON_APMU			"spacemit,apmu"
>> +
>> +/* Offsets and field definitions for APMU registers */
>> +
> 
> here also

OK.

>> +#define PCIE_CLK_RESET_CONTROL			0x0000
>> +#define LTSSM_EN			BIT(6)
>> +#define PCIE_AUX_PWR_DET		BIT(9)
>> +#define PCIE_RC_PERST			BIT(12)	/* 1: assert PERST# */
>> +#define APP_HOLD_PHY_RST		BIT(30)
>> +#define DEVICE_TYPE_RC			BIT(31)	/* 0: endpoint; 1: RC */
>> +
>> +#define PCIE_CONTROL_LOGIC			0x0004
>> +#define PCIE_SOFT_RESET			BIT(0)
>> +
>> +struct k1_pcie {
>> +	struct dw_pcie pci;
>> +	struct phy *phy;
>> +	void __iomem *link;
>> +	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
>> +	u32 pmu_off;
>> +};
>> +
>> +#define to_k1_pcie(dw_pcie) \
>> +		platform_get_drvdata(to_platform_device((dw_pcie)->dev))
>> +
>> +static void k1_pcie_toggle_soft_reset(struct k1_pcie *k1)
>> +{
>> +	u32 offset;
>> +	u32 val;
>> +
>> +	/*
>> +	 * Write, then read back to guarantee it has reached the device
>> +	 * before we start the delay.
>> +	 */
>> +	offset = k1->pmu_off + PCIE_CONTROL_LOGIC;
>> +	regmap_set_bits(k1->pmu, offset, PCIE_SOFT_RESET);
>> +	regmap_read(k1->pmu, offset, &val);
>> +
>> +	mdelay(2);
>> +
>> +	regmap_clear_bits(k1->pmu, offset, PCIE_SOFT_RESET);
>> +}
>> +
>> +/* Enable app clocks, deassert resets */
>> +static int k1_pcie_activate(struct k1_pcie *k1)
> 
> k1_pcie_enable_resources()?

OK, I'll use k1_pcie_{enable,disable}_resources().

>> +{
>> +	struct dw_pcie *pci = &k1->pci;
>> +	int ret;
>> +
>> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(pci->app_clks), pci->app_clks);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = reset_control_bulk_deassert(ARRAY_SIZE(pci->app_rsts),
>> +					  pci->app_rsts);
>> +	if (ret)
>> +		goto err_disable_clks;
>> +
>> +	ret = reset_control_bulk_deassert(ARRAY_SIZE(pci->core_rsts),
>> +					  pci->core_rsts);
>> +	if (ret)
>> +		goto err_assert_resets;
>> +
>> +	return 0;
>> +
>> +err_assert_resets:
>> +	reset_control_bulk_assert(ARRAY_SIZE(pci->app_rsts), pci->app_rsts);
>> +err_disable_clks:
>> +	clk_bulk_disable_unprepare(ARRAY_SIZE(pci->app_clks), pci->app_clks);
>> +
>> +	return ret;
>> +}
>> +
>> +/* Assert resets, disable app clocks */
>> +static void k1_pcie_deactivate(struct k1_pcie *k1)
> 
> k1_pcie_disable_resources()?
> 
>> +{
>> +	struct dw_pcie *pci = &k1->pci;
>> +
>> +	reset_control_bulk_assert(ARRAY_SIZE(pci->core_rsts), pci->core_rsts);
>> +	reset_control_bulk_assert(ARRAY_SIZE(pci->app_rsts), pci->app_rsts);
>> +	clk_bulk_disable_unprepare(ARRAY_SIZE(pci->app_clks), pci->app_clks);
>> +}
>> +
>> +static int k1_pcie_init(struct dw_pcie_rp *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct k1_pcie *k1 = to_k1_pcie(pci);
>> +	u32 offset;
>> +	u32 mask;
>> +	u32 val;
>> +	int ret;
>> +
>> +	k1_pcie_toggle_soft_reset(k1);
>> +
>> +	ret = k1_pcie_activate(k1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = phy_init(k1->phy);
>> +	if (ret) {
>> +		k1_pcie_deactivate(k1);
>> +
>> +		return ret;
>> +	}
>> +
>> +	/* Set the PCI vendor and device ID */
>> +	dw_pcie_dbi_ro_wr_en(pci);
>> +	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
>> +	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_SPACEMIT_K1);
>> +	dw_pcie_dbi_ro_wr_dis(pci);
>> +
>> +	/*
>> +	 * Assert fundamental reset (drive PERST# low).  Put the port in
> 
> s/port/controller

OK.

>> +	 * root complex mode, and indicate that Vaux (3.3v) is present.
>> +	 */
>> +	mask = PCIE_RC_PERST;
>> +	mask |= DEVICE_TYPE_RC | PCIE_AUX_PWR_DET;
>> +
>> +	/*
>> +	 * Write, then read back to guarantee it has reached the device
>> +	 * before we start the delay.
>> +	 */
>> +	offset = k1->pmu_off + PCIE_CLK_RESET_CONTROL;
>> +	regmap_set_bits(k1->pmu, offset, mask);
>> +	regmap_read(k1->pmu, offset, &val);
>> +
>> +	mdelay(PCIE_T_PVPERL_MS);
>> +
>> +	/* Deassert fundamental reset (drive PERST# high) */
>> +	regmap_clear_bits(k1->pmu, offset, PCIE_RC_PERST);
>> +
>> +	return 0;
>> +}
>> +
>> +static void k1_pcie_deinit(struct dw_pcie_rp *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct k1_pcie *k1 = to_k1_pcie(pci);
>> +
>> +	/* Assert fundamental reset (drive PERST# low) */
>> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>> +			PCIE_RC_PERST);
> 
> You need assert PERST# here.

I don't understand this comment.

Setting PCIE_RC_PERST in this register drives PERST# low.

>> +	phy_exit(k1->phy);
>> +
>> +	k1_pcie_deactivate(k1);
>> +}
>> +
>> +static const struct dw_pcie_host_ops k1_pcie_host_ops = {
>> +	.init		= k1_pcie_init,
>> +	.deinit		= k1_pcie_deinit,
>> +};
>> +
>> +static bool k1_pcie_link_up(struct dw_pcie *pci)
>> +{
>> +	struct k1_pcie *k1 = to_k1_pcie(pci);
>> +	u32 val;
>> +
>> +	val = readl_relaxed(k1->link + K1_PHY_AHB_LINK_STS);
>> +
>> +	return (val & RDLH_LINK_UP) && (val & SMLH_LINK_UP);
>> +}
>> +
>> +static int k1_pcie_start_link(struct dw_pcie *pci)
>> +{
>> +	struct k1_pcie *k1 = to_k1_pcie(pci);
>> +	u32 val;
>> +
>> +	/* Stop holding the PHY in reset, and enable link training */
>> +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>> +			   APP_HOLD_PHY_RST | LTSSM_EN, LTSSM_EN);
>> +
>> +	/* Enable the MSI interrupt */
>> +	writel_relaxed(MSI_CTRL_INT, k1->link + INTR_ENABLE);
>> +
>> +	/* Top-level interrupt enable */
>> +	val = readl_relaxed(k1->link + K1_PHY_AHB_IRQ_EN);
>> +	val |= PCIE_INTERRUPT_EN;
>> +	writel_relaxed(val, k1->link + K1_PHY_AHB_IRQ_EN);
>> +
>> +	return 0;
>> +}
>> +
>> +static void k1_pcie_stop_link(struct dw_pcie *pci)
>> +{
>> +	struct k1_pcie *k1 = to_k1_pcie(pci);
>> +	u32 val;
>> +
>> +	/* Disable interrupts */
>> +	val = readl_relaxed(k1->link + K1_PHY_AHB_IRQ_EN);
>> +	val &= ~PCIE_INTERRUPT_EN;
>> +	writel_relaxed(val, k1->link + K1_PHY_AHB_IRQ_EN);
>> +
>> +	writel_relaxed(0, k1->link + INTR_ENABLE);
>> +
>> +	/* Disable the link and hold the PHY in reset */
>> +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>> +			   APP_HOLD_PHY_RST | LTSSM_EN, APP_HOLD_PHY_RST);
>> +}
>> +
>> +static const struct dw_pcie_ops k1_pcie_ops = {
>> +	.link_up	= k1_pcie_link_up,
>> +	.start_link	= k1_pcie_start_link,
>> +	.stop_link	= k1_pcie_stop_link,
>> +};
>> +
>> +static int k1_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct k1_pcie *k1;
>> +	int ret;
>> +
>> +	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
>> +	if (!k1)
>> +		return -ENOMEM;
>> +
>> +	k1->pmu = syscon_regmap_lookup_by_phandle_args(dev_of_node(dev),
>> +						       SYSCON_APMU, 1,
>> +						       &k1->pmu_off);
>> +	if (IS_ERR(k1->pmu))
>> +		return dev_err_probe(dev, PTR_ERR(k1->pmu),
>> +				     "failed to lookup PMU registers\n");
>> +
>> +	k1->link = devm_platform_ioremap_resource_byname(pdev, "link");
>> +	if (!k1->link)
>> +		return dev_err_probe(dev, -ENOMEM,
>> +				     "failed to map \"link\" registers\n");
>> +
>> +	ret = devm_regulator_get_enable(dev, "vpcie3v3-supply");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "failed to get \"vpcie3v3\" supply\n");
> 
> As mentioned in the bindings patch, you should rely on the PWRCTRL_SLOT driver
> to handle the power supplies. It is not yet handling the PERST#, but I have a
> series floating for that:
> https://lore.kernel.org/linux-pci/20250912-pci-pwrctrl-perst-v3-0-3c0ac62b032c@oss.qualcomm.com/

I think that just means that I'll define a DT node compatible with
"pciclass,0604", and in that node I'll specify the vpcie3v3-supply
property.  That will cause that (pwrctrl) device to get and enable
the supply before the "real" PCIe device probes.

And once your PERST work gets merged into the PCI power control
framework, a callback will allow that to assert PERST# as needed
surrounding power transitions.  (But I won't worry about that
for now.)

Is that right?

>> +
>> +	/* Hold the PHY in reset until we start the link */
>> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>> +			APP_HOLD_PHY_RST);
>> +
>> +	k1->phy = devm_phy_get(dev, NULL);
>> +	if (IS_ERR(k1->phy))
>> +		return dev_err_probe(dev, PTR_ERR(k1->phy),
>> +				     "failed to get PHY\n");
> 
> Once you move these properties to Root Port binding, you need to have per-Root
> Port parser. Again, you can refer the STM32 driver.

I see getting the PHY in stm32_pcie_parse_port(), but nothing
about the supply (which you mentioned in the other message).

>> +
>> +	k1->pci.dev = dev;
>> +	k1->pci.ops = &k1_pcie_ops;
>> +	dw_pcie_cap_set(&k1->pci, REQ_RES);
>> +
>> +	k1->pci.pp.ops = &k1_pcie_host_ops;
>> +	k1->pci.pp.num_vectors = MAX_MSI_IRQS;
> 
> This driver is just using a single 'msi' vector, which can only support 32 MSIs.
> But MAX_MSI_IRQS is 256. So this looks wrong.

In dw_pcie_host_init(), if unspecified, MSI_DEF_NUM_VECTORS=32 is
used for num_vectors.  If it is specified, only if the value
exceeds MAX_MSI_IRQS=256 is an error returned.

In dw_handle_msi_irq(), "num_ctrls" is computed based on
num_vectors / MAX_MSI_IRQS_PER_CTRL=32.  A loop then
iterates over those "controllers"(?) to handle each bit
set in their corresponding register.

This seems OK.  Can you explain why you think it's wrong?

>> +
>> +	platform_set_drvdata(pdev, k1);
>> +
> 
> For setting the correct runtime PM state of the controller, you should do:
> 
> pm_runtime_set_active()
> pm_runtime_no_callbacks()
> devm_pm_runtime_enable()

OK, that's easy enough.

> This will fix the runtime PM hierarchy of PCIe chain (from host controller to
> client drivers). Otherwise, it will be broken.
Is this documented somewhere?  (It wouldn't surprise me if it
is and I just missed it.)

This driver has as its origins some vendor code, and I simply
removed the runtime PM calls.  I didn't realize something would
be broken without making pm_runtime*() calls.

Thank you for your review Mani.

					-Alex


> - Mani
> 


