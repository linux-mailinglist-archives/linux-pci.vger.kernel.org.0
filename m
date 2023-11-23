Return-Path: <linux-pci+bounces-146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5097F5E12
	for <lists+linux-pci@lfdr.de>; Thu, 23 Nov 2023 12:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5B51C20ED4
	for <lists+linux-pci@lfdr.de>; Thu, 23 Nov 2023 11:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3DB23744;
	Thu, 23 Nov 2023 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09C0101;
	Thu, 23 Nov 2023 03:42:50 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 50DAF80FC;
	Thu, 23 Nov 2023 19:42:43 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Nov
 2023 19:42:43 +0800
Received: from [192.168.125.85] (183.27.97.46) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Nov
 2023 19:42:42 +0800
Message-ID: <ae35cfb2-2eb0-43c5-890b-47b76402ef1d@starfivetech.com>
Date: Thu, 23 Nov 2023 19:42:41 +0800
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
References: <20231121213213.GA258296@bhelgaas>
From: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20231121213213.GA258296@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag



On 2023/11/22 5:32, Bjorn Helgaas wrote:
> On Tue, Nov 21, 2023 at 08:52:21AM +0800, Minda Chen wrote:
>> ...
>> BTW. Could you give any comments to Refactoring patches (patch 2 -
>> patch 16)and PLDA patch(patch 17) next week?  Thanks.
> 
> I think Krzysztof or Lorenzo will handle these.  I skimmed them and
> didn't see any major problems.
> 
> Bjorn

Hi Krzysztof and Lorenzo 
  Could you review and give some comments to this series patches? Thanks.
  On microchip side, Conor have reviewed all the Refactoring patches.
  Hope this series patches can be accepted in kernel v6.8

