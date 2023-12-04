Return-Path: <linux-pci+bounces-392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A83802B84
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 07:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063041F2103B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 06:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50277539F;
	Mon,  4 Dec 2023 06:03:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F21B9D;
	Sun,  3 Dec 2023 22:03:39 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 8A28D24E22E;
	Mon,  4 Dec 2023 14:03:37 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 4 Dec
 2023 14:03:37 +0800
Received: from [192.168.125.85] (183.27.97.199) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 4 Dec
 2023 14:03:36 +0800
Message-ID: <d060a66e-33a5-482d-a4c2-609a00d8b89d@starfivetech.com>
Date: Mon, 4 Dec 2023 14:03:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 19/20] PCI: starfive: Add JH7110 PCIe controller
Content-Language: en-US
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, Conor Dooley
	<conor@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
	"Rob Herring" <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Lorenzo Pieralisi" <lpieralisi@kernel.org>, Daire McNamara
	<daire.mcnamara@microchip.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
References: <20231115114912.71448-1-minda.chen@starfivetech.com>
 <20231115114912.71448-20-minda.chen@starfivetech.com>
 <CAJM55Z8hb3vBgwOHoHuJpEPFVMNirhcs8AfZWRn4EgxbOGsq2Q@mail.gmail.com>
From: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <CAJM55Z8hb3vBgwOHoHuJpEPFVMNirhcs8AfZWRn4EgxbOGsq2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag



On 2023/12/2 22:44, Emil Renner Berthing wrote:
> Minda Chen wrote:
>> Add StarFive JH7110 SoC PCIe controller platform driver codes, JH7110
>> with PLDA host PCIe core.
>>
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> Co-developed-by: Kevin Xie <kevin.xie@starfivetech.com>
>> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
>> ---
>>  MAINTAINERS                                 |   7 +
>>  drivers/pci/controller/plda/Kconfig         |  11 +
>>  drivers/pci/controller/plda/Makefile        |   1 +
>>  drivers/pci/controller/plda/pcie-plda.h     |  71 ++-
>>  drivers/pci/controller/plda/pcie-starfive.c | 460 ++++++++++++++++++++
>>  drivers/pci/pci.h                           |   7 +
>>  6 files changed, 556 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/pci/controller/plda/pcie-starfive.c
>>
> 
> ...
> 
>> +
>> +static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie,
>> +				  struct device *dev)
>> +{
>> +	int domain_nr;
>> +
>> +	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
>> +	if (pcie->num_clks < 0)
>> +		return dev_err_probe(dev, -ENODEV,
>> +				     "failed to get pcie clocks\n");
> 
> Hi Minda,
> 
> From Damian's mail I noticed that this should propagate the error from
> devm_clk_bulk_get_all() properly, so -EPROBE is converted to an -ENODEV error.
> Eg.
> 
> 	if (pcie->num_clks < 0)
> 		return dev_err_probe(dev, pcie->num_clks,
> 				     "failed to get pcie clocks\n");
> 
Thanks. I will change it in next version.

>> +
>> +	pcie->resets = devm_reset_control_array_get_exclusive(dev);
>> +	if (IS_ERR(pcie->resets))
>> +		return dev_err_probe(dev, PTR_ERR(pcie->resets),
>> +				     "failed to get pcie resets");
>> +
>> +	pcie->reg_syscon =
>> +		syscon_regmap_lookup_by_phandle(dev->of_node,
>> +						"starfive,stg-syscon");
>> +
>> +	if (IS_ERR(pcie->reg_syscon))
>> +		return dev_err_probe(dev, PTR_ERR(pcie->reg_syscon),
>> +				     "failed to parse starfive,stg-syscon\n");
>> +
>> +	pcie->phy = devm_phy_optional_get(dev, NULL);
>> +	if (IS_ERR(pcie->phy))
>> +		return dev_err_probe(dev, PTR_ERR(pcie->phy),
>> +				     "failed to get pcie phy\n");
>> +
>> +	domain_nr = of_get_pci_domain_nr(dev->of_node);
>> +
>> +	if (domain_nr < 0 || domain_nr > 1)
>> +		return dev_err_probe(dev, -ENODEV,
>> +				     "failed to get valid pcie domain\n");
>> +
>> +	if (domain_nr == 0)
>> +		pcie->stg_pcie_base = STG_SYSCON_PCIE0_BASE;
>> +	else
>> +		pcie->stg_pcie_base = STG_SYSCON_PCIE1_BASE;
>> +
>> +	pcie->reset_gpio = devm_gpiod_get_optional(dev, "perst",
>> +						   GPIOD_OUT_HIGH);
>> +	if (IS_ERR(pcie->reset_gpio))
>> +		return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio),
>> +				     "failed to get perst-gpio\n");
>> +
>> +	pcie->power_gpio = devm_gpiod_get_optional(dev, "enable",
>> +						   GPIOD_OUT_LOW);
>> +	if (IS_ERR(pcie->power_gpio))
>> +		return dev_err_probe(dev, PTR_ERR(pcie->power_gpio),
>> +				     "failed to get power-gpio\n");
>> +
>> +	return 0;
>> +}

