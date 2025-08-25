Return-Path: <linux-pci+bounces-34664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97555B34494
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 16:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589111886523
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37FC2F83BA;
	Mon, 25 Aug 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gBL1zgHl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F632D2382;
	Mon, 25 Aug 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133506; cv=none; b=hWNVgEow2cPWjm4OR3pXqWnVSVfeenWw4yN/zLCl+6qGIuh0sOPKrts4243g0I29ndTi/nv6BfqUwqNdjuFnNqY+M+N8JgBhKqBPlAw+o0oIiec8ZlKuzsBR8N2dosNsH+MRdPQQlyP73CCAkgAkjZ5tTseAw+9TvHko9arENJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133506; c=relaxed/simple;
	bh=q1CN+D5OKlckJ+DvfarKqNMMhOJ5GG1uwlK2GcPDfvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GQ7gYufxibLpS0yIQ8Wv+pEGI6HhasWAWYDI6avWB0vHhjYsGDqtg6ARenRBH45H+Q1bAAh4435g7ZHRKn5dUaxs/Ws1a/3Yt1nb9Gqv25D/ub3Yv9W+C0eL4dtLStNjhb2DyRc0toGiFE1TjZJt5fG6a6S3gKJC6Rm7o6MrI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gBL1zgHl; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PEdf3l029476;
	Mon, 25 Aug 2025 16:50:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	31laoDor+DKdLySueg4nAlgo6l/Od+GBgTYs+d1By2g=; b=gBL1zgHlFG1i+vG8
	sHR3BY79R9r2+5mkIbUSTLE3skJ6ei5w1EfRLcTl+hppvHwOY5j7Zrujatt+oedK
	zec7GTyTDPieBIqSDzEkKXjpZqqvclo7lPkBKSYMSWo6vuVJW4K5Wpdss2vUIEbc
	j23THcwMRHSoEamghxzZKpiTJiaiIpKN+V51E66ndqY/9HsdiUOLIMSWWw0tjeul
	eY//tnmBYM+vkzWMHgohgabbLQQJAwsjnGe/iXx+8JIdegVbiS5tw9jvN+nTQoMh
	8CY0+uPEpSKSEgoKe3/bnW3C3W6jtel7HP7Hn6Z3gWMEaatUeCzlQIpPMp/ph+ZQ
	pOsfFA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q5uyybbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 16:50:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8640B40044;
	Mon, 25 Aug 2025 16:49:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC2CF71FDBE;
	Mon, 25 Aug 2025 16:47:42 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 16:47:41 +0200
Message-ID: <7378edca-12f4-44a1-9c2a-ea07ebab4ad0@foss.st.com>
Date: Mon, 25 Aug 2025 16:47:40 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/11] PCI: stm32: Add PCIe host support for STM32MP25
To: Philipp Zabel <p.zabel@pengutronix.de>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linus.walleij@linaro.org>, <corbet@lwn.net>, <shradha.t@samsung.com>,
        <mayank.rana@oss.qualcomm.com>, <namcao@linutronix.de>,
        <qiang.yu@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <inochiama@gmail.com>, <quic_schintav@quicinc.com>
CC: <johan+linaro@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20250820075411.1178729-1-christian.bruel@foss.st.com>
 <20250820075411.1178729-5-christian.bruel@foss.st.com>
 <e67d5a27fb00040ba87a0b108322747ecca8d05b.camel@pengutronix.de>
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <e67d5a27fb00040ba87a0b108322747ecca8d05b.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01



On 8/25/25 11:15, Philipp Zabel wrote:
> On Mi, 2025-08-20 at 09:54 +0200, Christian Bruel wrote:
>> Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
>> controller based on the DesignWare PCIe core.
>>
>> Supports MSI via GICv2m, Single Virtual Channel, Single Function
>>
>> Supports WAKE# GPIO.
>>
>> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig      |  12 +
>>   drivers/pci/controller/dwc/Makefile     |   1 +
>>   drivers/pci/controller/dwc/pcie-stm32.c | 360 ++++++++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-stm32.h |  15 +
>>   4 files changed, 388 insertions(+)
>>   create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
>>   create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index deafc512b079..a8174817fd5b 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -423,6 +423,18 @@ config PCIE_SPEAR13XX
>>   	help
>>   	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
>>   
>> +config PCIE_STM32_HOST
>> +	tristate "STMicroelectronics STM32MP25 PCIe Controller (host mode)"
>> +	depends on ARCH_STM32 || COMPILE_TEST
>> +	depends on PCI_MSI
>> +	select PCIE_DW_HOST
>> +	help
>> +	  Enables Root Complex (RC) support for the DesignWare core based PCIe
>> +	  controller found in STM32MP25 SoC.
>> +
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called pcie-stm32.
>> +
>>   config PCI_DRA7XX
>>   	tristate
>>   
>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>> index 6919d27798d1..1307a87b1cf0 100644
>> --- a/drivers/pci/controller/dwc/Makefile
>> +++ b/drivers/pci/controller/dwc/Makefile
>> @@ -31,6 +31,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>>   obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>>   obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>>   obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
>> +obj-$(CONFIG_PCIE_STM32_HOST) += pcie-stm32.o
>>   
>>   # The following drivers are for devices that use the generic ACPI
>>   # pci_root.c driver but don't support standard ECAM config access.
>> diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
>> new file mode 100644
>> index 000000000000..964fa6f674c8
>> --- /dev/null
>> +++ b/drivers/pci/controller/dwc/pcie-stm32.c
>> @@ -0,0 +1,360 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * STMicroelectronics STM32MP25 PCIe root complex driver.
>> + *
>> + * Copyright (C) 2025 STMicroelectronics
>> + * Author: Christian Bruel <christian.bruel@foss.st.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/pinctrl/consumer.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/pm_wakeirq.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +#include "pcie-designware.h"
>> +#include "pcie-stm32.h"
>> +#include "../../pci.h"
>> +
>> +struct stm32_pcie {
>> +	struct dw_pcie pci;
>> +	struct regmap *regmap;
>> +	struct reset_control *rst;
> 
> This could be a local variable in stm32_pcie_probe().


Thank you for pointing that out.

Since we use the same common resources in stm32_pcie for both the host 
and endpoint drivers, aligning the same fields in the struct stm32_pcie 
seems more consistent.

Additionally, we could improve the code by moving regmap, clk, and rst 
out of probe into a new function, stm32_pcie_resource_get().

Which approach do you think is best? Moving rst to stm32_pcie_probe() 
offers slight optimization, while using a new stm32_pcie_resource_get() 
provides better modularity.

Shall I re-spin a v14 with either of these options?

thank you,

Christian

> 
> regards
> Philipp


