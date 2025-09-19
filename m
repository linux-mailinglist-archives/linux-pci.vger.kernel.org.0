Return-Path: <linux-pci+bounces-36544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5073FB8B71C
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 00:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A227E2ABA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 22:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3C22C0F83;
	Fri, 19 Sep 2025 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZOKlpcQN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A722C3278
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319839; cv=none; b=AB9AzhE7ZkbCWdTM/U81n8NLpIMzI0JaMfQRrEUwEWcp/m2MRC7fzlzym0DY9X4EHErCHUsq/IiIuh1qYcBQEH3zUJGYgdH1eOgVGqmia8Fw50lu1WnZb7ixzEchIKE6eVSZyv8Fvy1BD5QdMsQ02rNkjLQJzuiUgGoJH6JX3JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319839; c=relaxed/simple;
	bh=4q1AnSE6bsLLkAJ7K9Pc3wIAgoqhjjlrMBV8BMtECGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EklC1ZgnTGQoP8yPuFLcZ01lpGYLPQ5HKSLXovvnq0owMJoFkBTf8JZaRoewb1N7D+SjUV6FmcLUAbTMFLmM0Gu1gIiZPyZyIrIozV8Msfoy/uIivQEf8rwmHIwOqqC6YkM/ZhyA7bc/gFAoXHpZWoJg1DliJaDzmRVJv0WtQ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZOKlpcQN; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-423fe622487so29029965ab.0
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758319836; x=1758924636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgcPdNC8TLKzaK2dbK4ItnfKIaHmVEGBsiI70uCF/kk=;
        b=ZOKlpcQNv9mtCJncgT0M17yvi/LItfAg3M5m6iC9d1xJWZyaMWu9LWDZupd8gpU9hS
         AkMKTvC606zKsy3Ajy3n57j0AJAYpHgcwI8iYrVBvS5RQWvPoEtXPWocVT7jK2dHit+R
         RuhEdhr4fib+VHKSSEVgTK0sbTNWVqKHwUaNEdUsxd2AaaXftW8XFnfBhqlafUrl71Oy
         /o7Y4gAkzCcqPGH90tPxWEC5iXR1Rg2wU0+yUu9KCOrztCwJWDross7EBXxY34YKw/H4
         NRWwp3oW+y8Bf/diZCDK66y7sWNT5AnmCu2M0Q5JuJmYb/d1OwaRRSS0RoPqE3AdlAcq
         uSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319836; x=1758924636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgcPdNC8TLKzaK2dbK4ItnfKIaHmVEGBsiI70uCF/kk=;
        b=oKmkr2lJClRBRCu/IXe4CsYR6kpWF2mD8RmGD+ScrZ8IA5qo9SlUALZqVyarps0YAx
         Yir+iBBYWocMmJSIgkLS4qLK2qx8s60LGlJIls2Buls3C9yCgVtn/4se5jVgmMWybQAR
         Ir6s/G254616xcaeGoR8TmIHTSpawrzAGIzPDSwrTMqMxdZxZNUJ8PK+FW2w6+45efPg
         NFdhe1KAIawiJbFBDsSgBv/AfD8deDpRyak66nTQ7aejaASw1El1LkGXdHi9Xgr6y466
         v0lMeSTljBKnKkSyyYq4v2X7JJkQKEp/RlW0ePoqo7c7X3nk3jA1gPKbyRwAQM1tI+wQ
         e/Eg==
X-Forwarded-Encrypted: i=1; AJvYcCX5zsy/kOyXvaG/28K24Q5D+t65EbokYoCNAqzhFSHKvz93PYp646h+TLjuJHYQVqgC3CugykoXlts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8hI77Bv3V8b2E/9RkoLKbdNUi+zmFj/q2VZc5t6HgYPgJA717
	3QKxPNec5MbB/pB/xd+thr32qHwDbZ3wbPvLFyTXs4idfbbdapIenShlclvuRuxWvnI=
X-Gm-Gg: ASbGncv3LfnlzLDo4y57UWaMn8cdZ9jn501mVs5L5+zFSSK0GsdW5l+eyJu0UnLjNYz
	zM/Bc0tLEb72KwGf/ptNR/2movAz3qN4CSQNI9kQkT8Ao3H0y71r3QG6+8kHK34aV1pUKAgZyld
	E2SINT1qgxikquludShM0rPPMpE8JprCn0dSkfLsPdn1rC57imjZ8Ha4jptoV7BdMQJdR/VXcaj
	txiBIJ0QB/WeZ0D/RefagSn3uL1XczmYjTmxKKnVPNVkBnWN17t/3SVqKrnCW9uN2cL7Rl4P5Oi
	uNqND6BVPWm0T4t+v7IZHTgJHNpcBJ2EhUUAz9ZOdbKsy3RUTp5rMFEQLfPk03wmJhHaYXznebP
	7gSYXxXjIGbWq6ggmipcE18mSPwLtrNcYQRNy+9n5S7Q21XIC1Xcv/IM2LBFIINDes+aL4Wao
X-Google-Smtp-Source: AGHT+IGUMi5Y+ZNyrqZVZaqAnb8mulirnkLZLTN1tiOo9Dktfk1VavRS0LndvmbeW3SqfgHBdfpwmQ==
X-Received: by 2002:a05:6e02:2195:b0:424:672:e0fa with SMTP id e9e14a558f8ab-42481927108mr82251805ab.11.1758319835807;
        Fri, 19 Sep 2025 15:10:35 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d56b5a45csm2587794173.70.2025.09.19.15.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 15:10:35 -0700 (PDT)
Message-ID: <21ad322f-5abe-4a97-9373-d027b846ee8c@riscstar.com>
Date: Fri, 19 Sep 2025 17:10:33 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] PCI: spacemit: introduce SpacemiT PCIe host driver
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
 bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, tglx@linutronix.de,
 johan+linaro@kernel.org, thippeswamy.havalige@amd.com, namcao@linutronix.de,
 mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, inochiama@gmail.com,
 quic_schintav@quicinc.com, fan.ni@samsung.com, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-6-elder@riscstar.com>
 <sptrmspkmqrwsh2iv4rmha45vsoz5ks7vhcdp3dytsxyabn6qn@mmk7z6tf5wcv>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <sptrmspkmqrwsh2iv4rmha45vsoz5ks7vhcdp3dytsxyabn6qn@mmk7z6tf5wcv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/25 3:09 AM, Manivannan Sadhasivam wrote:
> On Wed, Aug 13, 2025 at 01:46:59PM GMT, Alex Elder wrote:
>> Introduce a driver for the PCIe root complex found in the SpacemiT
>> K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
>> The driver supports three PCIe ports that operate at PCIe v2 transfer
>> rates (5 GT/sec).  The first port uses a combo PHY, which may be
>> configured for use for USB 3 instead.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig   |  10 +
>>   drivers/pci/controller/dwc/Makefile  |   1 +
>>   drivers/pci/controller/dwc/pcie-k1.c | 355 +++++++++++++++++++++++++++
>>   3 files changed, 366 insertions(+)
>>   create mode 100644 drivers/pci/controller/dwc/pcie-k1.c
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index ff6b6d9e18ecf..ca5782c041ce8 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -492,4 +492,14 @@ config PCIE_VISCONTI_HOST
>>   	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
>>   	  This driver supports TMPV7708 SoC.
>>   
>> +config PCIE_K1
>> +	bool "SpacemiT K1 host mode PCIe controller"
> 
> No need to make it bool, build it as a module. Only the PCI controller drivers
> implementing irqchip need to be kept bool for irq disposal concerns.

OK.

>> +	depends on ARCH_SPACEMIT || COMPILE_TEST
>> +	depends on PCI && OF && HAS_IOMEM
>> +	select PCIE_DW_HOST
>> +	default ARCH_SPACEMIT
>> +	help
>> +	  Enables support for the PCIe controller in the K1 SoC operating
>> +	  in host mode.
> 
> Is the driver only applicable for K1 SoCs or other SoCs from spacemit? Even if
> it is the former, I would suggest renaming to 'pcie-spacemit-k1.c'

Yes, I will do that.

>>   endmenu
>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>> index 6919d27798d13..62d9d4e7dd4d3 100644
>> --- a/drivers/pci/controller/dwc/Makefile
>> +++ b/drivers/pci/controller/dwc/Makefile
>> @@ -31,6 +31,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>>   obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>>   obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>>   obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
>> +obj-$(CONFIG_PCIE_K1) += pcie-k1.o
>>   
>>   # The following drivers are for devices that use the generic ACPI
>>   # pci_root.c driver but don't support standard ECAM config access.
>> diff --git a/drivers/pci/controller/dwc/pcie-k1.c b/drivers/pci/controller/dwc/pcie-k1.c
>> new file mode 100644
>> index 0000000000000..e9b1df3428d16
>> --- /dev/null
>> +++ b/drivers/pci/controller/dwc/pcie-k1.c
>> @@ -0,0 +1,355 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * SpacemiT K1 PCIe host driver
>> + *
>> + * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
>> + * Copyright (c) 2023, spacemit Corporation.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/gfp.h>
>> +#include <linux/irq.h>
> 
> unused?

Yes, and there are a few others I can get rid of too.

>> +#include <linux/mfd/syscon.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/of.h>
>> +#include <linux/pci.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +#include <linux/types.h>
>> +
>> +#include "pcie-designware.h"
>> +
>> +#define K1_PCIE_VENDOR_ID	0x201f
>> +#define K1_PCIE_DEVICE_ID	0x0001
>> +
>> +/* Offsets and field definitions of link management registers */
>> +
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
>> +/* Offsets and field definitions for PMU registers */
>> +
>> +#define PCIE_CLK_RESET_CONTROL			0x0000
>> +#define LTSSM_EN			BIT(6)
>> +#define PCIE_AUX_PWR_DET		BIT(9)
>> +#define PCIE_RC_PERST			BIT(12)	/* 0: PERST# high; 1: low */
>> +#define APP_HOLD_PHY_RST		BIT(30)
>> +#define DEVICE_TYPE_RC			BIT(31)	/* 0: endpoint; 1: RC */
>> +
>> +#define PCIE_CONTROL_LOGIC			0x0004
>> +#define PCIE_SOFT_RESET			BIT(0)
>> +
>> +struct k1_pcie {
>> +	struct dw_pcie pci;
>> +	void __iomem *link;
>> +	struct regmap *pmu;
>> +	u32 pmu_off;
>> +	struct phy *phy;
>> +	struct reset_control *global_reset;
>> +};
>> +
>> +#define to_k1_pcie(dw_pcie)	dev_get_drvdata((dw_pcie)->dev)
>> +
>> +static int k1_pcie_toggle_soft_reset(struct k1_pcie *k1)
>> +{
>> +	u32 offset = k1->pmu_off + PCIE_CONTROL_LOGIC;
>> +	const u32 mask = PCIE_SOFT_RESET;
>> +	int ret;
>> +
>> +	ret = regmap_set_bits(k1->pmu, offset, mask);
> 
> For MMIO, it is OK to skip the error handling.

You mean even though the regmap API returns an error,
it never will with MMIO?
- regmap_mmio_read() and regmap_mmio_write() always
   return 0 unless there's an error enabling its clock.

Sounds good, I'll simplify places that use this.

>> +	if (ret)
>> +		return ret;
>> +
>> +	mdelay(2);
> 
> If the previous write to the PMU got stuck in the CPU cache, there is no
> guarantee that this delay of 2ms between write and clear will be enforced. So
> you should do a dummy read after write to ensure that the previous write has
> reached the PMU (or any device) and then clear the bits.

Wow, really?  I was aware of this being possible for I/O
writes but it seems like something regmap might handle.

I'll add a regmap_read() for the same offset and discard
the result *before* the delay.  I'll do the same for this:

         mdelay(PCIE_T_PVPERL_MS);

>> +	return regmap_clear_bits(k1->pmu, offset, mask);
>> +}
>> +
>> +/* Enable app clocks, deassert app resets */
>> +static int k1_pcie_app_enable(struct k1_pcie *k1)
>> +{
>> +	struct dw_pcie *pci = &k1->pci;
>> +	u32 clock_count;
>> +	u32 reset_count;
>> +	int ret;
>> +
>> +	clock_count = ARRAY_SIZE(pci->app_clks);
> 
> Just use ARRAY_SIZE() directly below.

OK.

>> +	ret = clk_bulk_prepare_enable(clock_count, pci->app_clks);
>> +	if (ret)
>> +		return ret;
>> +
>> +	reset_count = ARRAY_SIZE(pci->app_rsts);
> 
> Same here.

OK.

>> +	ret = reset_control_bulk_deassert(reset_count, pci->app_rsts);
>> +	if (ret)
>> +		goto err_disable_clks;
>> +
>> +	ret = reset_control_deassert(k1->global_reset);
>> +	if (ret)
>> +		goto err_assert_resets;
>> +
>> +	return 0;
>> +
>> +err_assert_resets:
>> +	(void)reset_control_bulk_assert(reset_count, pci->app_rsts);
> 
> Why void cast? Here and in other places.

I put void casts when I'm ignoring a returned value.
It's not necessary, but it reminds me that the function
returns a value, and at some point I decided to ignore it.
I can drop those if you find them offensive.

If you're suggesting I should issue a warning here if
an error is returned here, tell me that.

>> +err_disable_clks:
>> +	clk_bulk_disable_unprepare(clock_count, pci->app_clks);
>> +
>> +	return ret;
>> +}
>> +
>> +/* Disable app clocks, assert app resets */
>> +static void k1_pcie_app_disable(struct k1_pcie *k1)
>> +{
>> +	struct dw_pcie *pci = &k1->pci;
>> +	u32 count;
>> +	int ret;
>> +
>> +	(void)reset_control_assert(k1->global_reset);
>> +
>> +	count = ARRAY_SIZE(pci->app_rsts);
>> +	ret = reset_control_bulk_assert(count, pci->app_rsts);
>> +	if (ret)
>> +		dev_err(pci->dev, "app reset assert failed (%d)\n", ret);
>> +
>> +	count = ARRAY_SIZE(pci->app_clks);
>> +	clk_bulk_disable_unprepare(count, pci->app_clks);
>> +}
> 
> Same comments as k1_pcie_app_enable().

OK.

>> +static int k1_pcie_init(struct dw_pcie_rp *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct k1_pcie *k1 = to_k1_pcie(pci);
>> +	u32 offset;
>> +	u32 mask;
>> +	int ret;
>> +
>> +	ret = k1_pcie_toggle_soft_reset(k1);
>> +	if (ret)
>> +		goto err_app_disable;
>> +
>> +	ret = k1_pcie_app_enable(k1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = phy_init(k1->phy);
>> +	if (ret)
>> +		goto err_app_disable;
>> +
>> +	/* Set the PCI vendor and device ID */
>> +	dw_pcie_dbi_ro_wr_en(pci);
>> +	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, K1_PCIE_VENDOR_ID);
>> +	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, K1_PCIE_DEVICE_ID);
>> +	dw_pcie_dbi_ro_wr_dis(pci);
>> +
>> +	/*
>> +	 * Put the port in root complex mode, record that Vaux is present.
> 
> There is no 3.3Vaux supply present in the binding. So the supply is guaranteed
> to be present and enabled always by the platform?

Actually, I don't know, I'll ask.  Thank you for pointing this out.

>> +	 * Assert fundamental reset (drive PERST# low).
>> +	 */
>> +	offset = k1->pmu_off + PCIE_CLK_RESET_CONTROL;
>> +	mask = DEVICE_TYPE_RC | PCIE_AUX_PWR_DET;
>> +	mask |= PCIE_RC_PERST;
>> +	ret = regmap_set_bits(k1->pmu, offset, mask);
>> +	if (ret)
>> +		goto err_phy_exit;
>> +
>> +	/* Wait the PCIe-mandated 100 msec before deasserting PERST# */
>> +	mdelay(100);
> 
> Same comment as k1_pcie_toggle_soft_reset() applies here.

Yes, understood.

>> +
>> +	ret = regmap_clear_bits(k1->pmu, offset, PCIE_RC_PERST);
>> +	if (!ret)
>> +		return 0;	/* Success! */
> 
> Please use common pattern to return success:
> 
> 	regmap_clear_bits()
> 
> 	return 0;

Now that I won't be checking return values this will come
naturally.  So yes, it will look like this, and there are
no other instances of this return pattern in this file.

> 
>> +
>> +err_phy_exit:
>> +	(void)phy_exit(k1->phy);
>> +err_app_disable:
>> +	k1_pcie_app_disable(k1);
>> +
>> +	return ret;
>> +}
>> +
>> +/* Silently ignore any errors */
>> +static void k1_pcie_deinit(struct dw_pcie_rp *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct k1_pcie *k1 = to_k1_pcie(pci);
>> +
>> +	/* Re-assert fundamental reset (drive PERST# low) */
> 
> s/Re-assert/Assert
> 
>> +	(void)regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>> +			      PCIE_RC_PERST);
>> +
>> +	(void)phy_exit(k1->phy);
>> +
>> +	k1_pcie_app_disable(k1);
>> +}
>> +
>> +static const struct dw_pcie_host_ops k1_pcie_host_ops = {
>> +	.init		= k1_pcie_init,
>> +	.deinit		= k1_pcie_deinit,
>> +};
>> +
>> +static void k1_pcie_enable_interrupts(struct k1_pcie *k1)
>> +{
>> +	void __iomem *virt;
>> +	u32 val;
>> +
>> +	/* Enable the MSI interrupt */
>> +	writel(MSI_CTRL_INT, k1->link + INTR_ENABLE);
> 
> If there are no ordering issues (I guess so), you can very well use the _relaxed
> variants throughout the driver.

The only writel() calls are related to updating
these interrupt bits.  I think you're right.

>> +	/* Top-level interrupt enable */
>> +	virt = k1->link + K1_PHY_AHB_IRQ_EN;
>> +	val = readl(virt);
>> +	val |= PCIE_INTERRUPT_EN;
>> +	writel(val, virt);
>> +}
>> +
>> +static void k1_pcie_disable_interrupts(struct k1_pcie *k1)
>> +{
>> +	void __iomem *virt;
>> +	u32 val;
>> +
>> +	virt = k1->link + K1_PHY_AHB_IRQ_EN;
>> +	val = readl(virt);
>> +	val &= ~PCIE_INTERRUPT_EN;
>> +	writel(val, virt);
>> +
>> +	writel(0, k1->link + INTR_ENABLE);
>> +}
>> +
>> +static bool k1_pcie_link_up(struct dw_pcie *pci)
>> +{
>> +	struct k1_pcie *k1 = to_k1_pcie(pci);
>> +	u32 val;
>> +
>> +	val = readl(k1->link + K1_PHY_AHB_LINK_STS);
>> +
>> +	return (val & RDLH_LINK_UP) && (val & SMLH_LINK_UP);
>> +}
>> +
>> +static int k1_pcie_start_link(struct dw_pcie *pci)
>> +{
>> +	struct k1_pcie *k1 = to_k1_pcie(pci);
>> +	int ret;
>> +
>> +	/* Stop holding the PHY in reset, and enable link training */
>> +	ret = regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>> +				 APP_HOLD_PHY_RST | LTSSM_EN, LTSSM_EN);
>> +	if (ret)
>> +		return ret;
>> +
>> +	k1_pcie_enable_interrupts(k1);
>> +
>> +	return 0;
>> +}
>> +
>> +static void k1_pcie_stop_link(struct dw_pcie *pci)
>> +{
>> +	struct k1_pcie *k1 = to_k1_pcie(pci);
>> +	int ret;
>> +
>> +	k1_pcie_disable_interrupts(k1);
>> +
>> +	/* Disable the link and hold the PHY in reset */
>> +	ret = regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>> +				 APP_HOLD_PHY_RST | LTSSM_EN, APP_HOLD_PHY_RST);
>> +	if (ret)
>> +		dev_err(pci->dev, "disable LTSSM failed (%d)\n", ret);
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
>> +	struct dw_pcie_rp *pp;
>> +	struct dw_pcie *pci;
>> +	struct k1_pcie *k1;
>> +	int ret;
>> +
>> +	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
>> +	if (!k1)
>> +		return -ENOMEM;
>> +	dev_set_drvdata(dev, k1);
>> +
>> +	k1->pmu = syscon_regmap_lookup_by_phandle_args(dev_of_node(dev),
>> +						       "spacemit,syscon-pmu",
>> +						       1, &k1->pmu_off);
>> +	if (IS_ERR(k1->pmu))
>> +		return dev_err_probe(dev, PTR_ERR(k1->pmu),
>> +				     "lookup PMU regmap failed\n");
> 
> 'Failed to lookup \"PMU\" registers'
OK.

>> +
>> +	k1->link = devm_platform_ioremap_resource_byname(pdev, "link");
>> +	if (!k1->link)
>> +		return dev_err_probe(dev, -ENOMEM, "map link regs failed\n");
> 
> 'Failed to map \"link\" registers
> 
> Same for below error prints as well.

OK.

>> +
>> +	k1->global_reset = devm_reset_control_get_shared(dev, "global");
>> +	if (IS_ERR(k1->global_reset))
>> +		return dev_err_probe(dev, PTR_ERR(k1->global_reset),
>> +				     "get global reset failed\n");
>> +
>> +	/* Hold the PHY in reset until we start the link */
>> +	ret = regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>> +			      APP_HOLD_PHY_RST);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "hold PHY in reset failed\n");
>> +
>> +	k1->phy = devm_phy_get(dev, NULL);
>> +	if (IS_ERR(k1->phy))
>> +		return dev_err_probe(dev, PTR_ERR(k1->phy), "get PHY failed\n");
>> +
>> +	pci = &k1->pci;
>> +	dw_pcie_cap_set(pci, REQ_RES);
>> +	pci->dev = dev;
>> +	pci->ops = &k1_pcie_ops;
>> +
>> +	pp = &pci->pp;
>> +	pp->num_vectors = MAX_MSI_IRQS;
> 
> I don't understand how MSI is implemented in this platform. If the controller
> relies on an external interrupt controller for handling MSIs (I think it does),
> then there should be either 'msi-parent' or 'msi-map' existed in the binding.

OK your comment earlier made me realize I had more to do here.
I'll work to improve that.

> But I see none, other than 'interrupts-extended'. So I don't know how MSI works
> at all.
> 
>> +	pp->ops = &k1_pcie_host_ops;
>> +
>> +	ret = dw_pcie_host_init(pp);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "host init failed\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static void k1_pcie_remove(struct platform_device *pdev)
>> +{
>> +	struct k1_pcie *k1 = dev_get_drvdata(&pdev->dev);
>> +	struct dw_pcie_rp *pp = &k1->pci.pp;
>> +
>> +	dw_pcie_host_deinit(pp);
>> +}
>> +
>> +static const struct of_device_id k1_pcie_of_match_table[] = {
>> +	{ .compatible = "spacemit,k1-pcie-rc", },
>> +	{ },
>> +};
>> +
>> +static struct platform_driver k1_pcie_driver = {
>> +	.probe	= k1_pcie_probe,
>> +	.remove	= k1_pcie_remove,
>> +	.driver = {
>> +		.name			= "k1-dwc-pcie",
>> +		.of_match_table		= k1_pcie_of_match_table,
>> +		.suppress_bind_attrs	= true,
> 
> No need of this flag for the reason I mentioned in the Kcofig change.

Because this doesn't implement an irqchip?

> You should also set,
> 
> 	.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> 
> to make use of the async probing of the devices during boot. This does save some
> boot time.

That's great to know, there is a noticeable delay during probe.

Thank you very much for your careful review, Mani.

					-Alex

> - Mani
> 

