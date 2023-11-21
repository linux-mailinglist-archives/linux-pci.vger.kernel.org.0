Return-Path: <linux-pci+bounces-3-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42E37F2293
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 01:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B631C20F95
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 00:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F215B6;
	Tue, 21 Nov 2023 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026611A2;
	Mon, 20 Nov 2023 16:52:29 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 2A7FC24E203;
	Tue, 21 Nov 2023 08:52:23 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Nov
 2023 08:52:23 +0800
Received: from [192.168.125.85] (183.27.97.46) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Nov
 2023 08:52:21 +0800
Message-ID: <ad43c202-3796-469c-b7fb-7591026e6888@starfivetech.com>
Date: Tue, 21 Nov 2023 08:52:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 19/20] PCI: starfive: Add JH7110 PCIe controller
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Conor Dooley <conor@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Daire
 McNamara" <daire.mcnamara@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	"Palmer Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"Philipp Zabel" <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
References: <20231120182347.GA207554@bhelgaas>
From: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20231120182347.GA207554@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag



On 2023/11/21 2:23, Bjorn Helgaas wrote:
> On Mon, Nov 20, 2023 at 06:07:31PM +0800, Minda Chen wrote:
>> On 2023/11/15 19:49, Minda Chen wrote:
>> > Add StarFive JH7110 SoC PCIe controller platform driver codes, JH7110
>> > with PLDA host PCIe core.
>> ...
> 
>> > --- a/drivers/pci/pci.h
>> > +++ b/drivers/pci/pci.h
>> > @@ -22,6 +22,13 @@
>> >   */
>> >  #define PCIE_PME_TO_L2_TIMEOUT_US	10000
>> >  
>> > +/*
>> > + * PCIe r6.0, sec 6.6.1, <Conventional Reset>
>> > + * Requires a minimum waiting of 100ms before sending a configuration
>> > + * request to the device.
>> > + */
>> > +#define PCIE_BEFORE_CONFIG_REQUEST_WAIT_MS	100
>> > +
>> >  extern const unsigned char pcie_link_speed[];
>> >  extern bool pci_early_dump;
>> >  
>> Hi Bjorn
>>   I have not checked this carefully.
>>   I think the change of pci.h should be moved to a indepent patch.
>>   Could you approve this? Kevin will commit a new patch for this.
>>   Next version I will remove this change. 
> 
> Yes, I think it makes sense to add that #define in a separate patch.
> 
> Please trim out the unnecessary context; there's no need for readers
> to scroll through the entire driver to get to the useful part, which
> is just the last dozen lines or so.
> 
> Bjorn

Thanks. I will notice this next time. 
Happy Thanksgiving! Wish you and Rob have a good holiday.

BTW. Could you give any comments to Refactoring patches (patch 2 - patch 16)and PLDA patch(patch 17) next week?  Thanks.

