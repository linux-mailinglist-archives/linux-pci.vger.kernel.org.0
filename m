Return-Path: <linux-pci+bounces-321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814AD800481
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 08:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BAA281604
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 07:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F1E125B5;
	Fri,  1 Dec 2023 07:15:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE16171A;
	Thu, 30 Nov 2023 23:15:47 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 006638062;
	Fri,  1 Dec 2023 15:15:41 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Dec
 2023 15:15:40 +0800
Received: from [192.168.125.85] (113.72.145.176) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Dec
 2023 15:15:39 +0800
Message-ID: <1168e373-b049-4c17-9cbd-c588bf913bbb@starfivetech.com>
Date: Fri, 1 Dec 2023 15:15:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/20] Refactoring Microchip PCIe driver and add
 StarFive PCIe
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
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
References: <20231115114912.71448-1-minda.chen@starfivetech.com>
 <ZWbcjKiSfvp-74CL@fedora.fritz.box> <ZWchVSO6iQbCFwkp@fedora.fritz.box>
From: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <ZWchVSO6iQbCFwkp@fedora.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag



On 2023/11/29 19:32, Damian Tometzki wrote:
> On Wed, 29. Nov 07:39, Damian Tometzki wrote:
>> Hello Minda,
>> 
>> i tried this Patchset on Linux-6.6.3 but boot with nvme doesnt work. Linux doesnt find
>> /root partition /dev/nvme0n1p4. 
>> I dont know if it has anything to do with this patchset ?
>> Best regards
>> Damian
> Hi,
> some additional information: 
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> [   11.097653] /soc/pcie@940000000: Failed to get clk index: 1 ret: -517
> [   11.104147] pcie-starfive 940000000.pcie: error -ENODEV: failed to get pcie clocks
> [   11.111981] /soc/pcie@9c0000000: Failed to get clk index: 1 ret: -517
> [   11.118451] pcie-starfive 9c0000000.pcie: error -ENODEV: failed to get pcie clocks
> [   11.126371] platform 17020000.pinctrl: deferred probe pending
> [   11.132145] platform 16010000.mmc: deferred probe pending
> Begin: Running /scripts/local-block ... done.
> Begin: Running /scripts/local-block ... done.
> 
> Damian
> 
It is get stg clk failed. Did you enable CONFIG_CLK_STARFIVE_JH7110_STG=y?
>> 
>> On Wed, 15. Nov 19:48, Minda Chen wrote:
>> > This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
>> > JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
>> > same IP and have commit their codes, which are mixed with PLDA
>> > controller codes and Microchip platform codes.
>> > 
>> > For re-use the PLDA controller codes, I request refactoring microchip
>> > codes, move PLDA common codes to PLDA files.
>> > Desigware and Cadence is good example for refactoring codes.
>> > 
>> > ----------------------------------------------------------
>> > The refactoring patches total number is 16,(patch 1-16)
>> > which do NOT contain changing logic of codes.
>> > 
>> > These patches just contain three type basic operations.
>> > (rename, modify codes to support starfive platform, and moving to common file)
>> > If these patched are all be reviewed. They can be accepted first.
>> > 
>> > Refactoring patches can be devided to different groups
>> > 1. (patch 1- 3 is the prepare work of refactoring)
>> > patch1 is move PLDA XpressRICH PCIe host common properties dt-binding
>> >        docs from microchip,pcie-host.yaml
>> > patch2 is move PolarFire codes to PLDA directory.
>> > patch3 is move PLDA IP register macros to plda-pcie.h
>> > 
>> > 2. (patch4 - 6 is processing and re-use PCIe host instance)
>> > patch4 is add bridge_addr field to PCIe host instance.
>> > patch5 is rename data structure in microchip codes.
>> > patch6 is moving two data structures to head file
>> > 
>> > 3. (patch 7 - 9 are for re-use two PCIe setup function)
>> > patch7 is rename two setup functions in microchip codes, prepare to move
>> > to common file.
>> > patch8 is change the arguments of plda_pcie_setup_iomems()
>> > patch9 is move the two setup functions to common file pcie-plda-host.c
>> > 
>> > 4.(patch 10 - 16 are for re-use interupt processing codes)
>> > patch10 is rename the IRQ related functions, prepare to move to
>> > pcie-plda-host.c
>> > patch 11 - 15 is modify the interrupt event codes, preparing for support starfive
>> > and microchip two platforms.
>> > patch16 is move IRQ related functions to pcie-plda-host.c
>> > 
>> > ------------------------------------------------------------
>> > The remainder patches (patch 17 -20) are not refactoring patch.
>> > They are for adding StarFive codes and dont modify the microchip's
>> > codes.
>> > 
>> > patch17 is Add PLDA event interrupt codes and host init/deinit functions.
>> > patch18 is add StarFive JH7110 PCIe dt-binding doc.
>> > patch19 is add StarFive JH7110 Soc PCIe codes.
>> > patch20 is Starfive dts config
>> > 
>> > This patchset is base on v6.7-rc1
>> > 
>> > previous version:
>> > v6:https://patchwork.kernel.org/project/linux-pci/cover/20230915102243.59775-1-minda.chen@starfivetech.com/
>> > v7:https://patchwork.kernel.org/project/linux-pci/cover/20230927100802.46620-1-minda.chen@starfivetech.com/
>> > v8:https://patchwork.kernel.org/project/linux-pci/cover/20231011110514.107528-1-minda.chen@starfivetech.com/
>> > v9:https://patchwork.kernel.org/project/linux-pci/cover/20231020104341.63157-1-minda.chen@starfivetech.com/
>> > v10:https://patchwork.kernel.org/project/linux-pci/cover/20231031115430.113586-1-minda.chen@starfivetech.com/
>> > 
>> > change:
>> >   v11:
>> >      check and modify some commit messages again.
>> >      All the codes are the same with v10.   
>> > 
>> >   v10:
>> >    All the commit message set to fit in 75 columns.
>> >    All the codes fit in less than 80 colunms.
>> >    patch 14: 
>> > 	Commit message changes suggested by Conor.
>> >    patch 19:
>> >         Add 100 ms delay macro to pci.h
>> > 	generic phy pointer related codes moving to pcie-starfive.c
>> > 	This patch Change pcie-starfive only, bus_ops move to patch 16.
>> > 	Some Codes changes suggested by Bjorn.
>> > 
>> >   v9:
>> >    v8 patch 10 squash to v9 patch 12, v8 patch 18 squash to v9 patch 16.
>> >    patch 4 - 16: Add new review tags and add more accurate commit messages.
>> >    patch 17: move the plda_pcie_host_init/deinit from patch 19. Make
>> >              plda driver become to whole driver.
>> > 
>> >   v8:
>> >     The patch description in cover-letter has been changed.
>> > 
>> >     v7 patch 4 split to v8 patch 4 - 6.
>> >         (It is patches about re-use pcie host data structure, new patches just contain one
>> > 	function modification. It is more reguluar and easier to review).
>> > 
>> >     patch 7- 9: modify the commit messages and add reason of
>> > 		modifcation.
>> >     patch10- 16 :
>> >              Add review tag and add more commit messages to declear the
>> > 	     reason of modifying the codes.
>> >     patch17: plda_handle_events() using bit mask macro. The function are
>> > 	     easier to read.
>> > 
>> >   v7:
>> >     patch17: fix the build warning.
>> >     patch19: Some format changes (Emil's comment)
>> >     patch20: change the pcie node sequences by alphabetical
>> >              delete the "interupt-parent" in pcie node.
>> > 
>> >   v6:
>> >     v5 patch 4 split to patch 4 -9. New patches just contain one function modification. It is more reguluar.
>> > 
>> >     patch 9: Just move the two setup functions only
>> >     patch 19 : draw a graph of PLDA local register, make it easier to
>> >                review the codes.
>> >     v5 patch 7 split to patch 10- 16. Each patch just contain one
>> >                 function modification. It is more regular.
>> >     patch 10: rename IRQ related functions.
>> >     patch 11 - 15 : modify the events codes, total five patch.
>> >     patch 16: move IRQ related functions to pcie-plda-host.c
>> >     patch 19- 20 using "linux,pci-domain" dts setting.
>> > 
>> > Minda Chen (20):
>> >   dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
>> >   PCI: microchip: Move pcie-microchip-host.c to plda directory
>> >   PCI: microchip: Move PLDA IP register macros to pcie-plda.h
>> >   PCI: microchip: Add bridge_addr field to struct mc_pcie
>> >   PCI: microchip: Rename two PCIe data structures
>> >   PCI: microchip: Move PCIe host data structures to plda-pcie.h
>> >   PCI: microchip: Rename two setup functions
>> >   PCI: microchip: Change the argument of plda_pcie_setup_iomems()
>> >   PCI: microchip: Move setup functions to pcie-plda-host.c
>> >   PCI: microchip: Rename interrupt related functions
>> >   PCI: microchip: Add num_events field to struct plda_pcie_rp
>> >   PCI: microchip: Add request_event_irq() callback function
>> >   PCI: microchip: Add INTx and MSI event num to struct plda_event
>> >   PCI: microchip: Add get_events() callback function
>> >   PCI: microchip: Add event IRQ domain ops to struct plda_event
>> >   PCI: microchip: Move IRQ functions to pcie-plda-host.c
>> >   PCI: plda: Add event interrupt codes and host init/deinit functions
>> >   dt-bindings: PCI: Add StarFive JH7110 PCIe controller
>> >   PCI: starfive: Add JH7110 PCIe controller
>> >   riscv: dts: starfive: add PCIe dts configuration for JH7110
>> > 
>> >  .../bindings/pci/microchip,pcie-host.yaml     |  55 +-
>> >  .../pci/plda,xpressrich3-axi-common.yaml      |  75 ++
>> >  .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++
>> >  MAINTAINERS                                   |  19 +-
>> >  .../jh7110-starfive-visionfive-2.dtsi         |  64 ++
>> >  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  86 +++
>> >  drivers/pci/controller/Kconfig                |   9 +-
>> >  drivers/pci/controller/Makefile               |   2 +-
>> >  drivers/pci/controller/plda/Kconfig           |  29 +
>> >  drivers/pci/controller/plda/Makefile          |   4 +
>> >  .../{ => plda}/pcie-microchip-host.c          | 602 ++--------------
>> >  drivers/pci/controller/plda/pcie-plda-host.c  | 657 ++++++++++++++++++
>> >  drivers/pci/controller/plda/pcie-plda.h       | 266 +++++++
>> >  drivers/pci/controller/plda/pcie-starfive.c   | 460 ++++++++++++
>> >  drivers/pci/pci.h                             |   7 +
>> >  15 files changed, 1851 insertions(+), 604 deletions(-)
>> >  create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
>> >  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
>> >  create mode 100644 drivers/pci/controller/plda/Kconfig
>> >  create mode 100644 drivers/pci/controller/plda/Makefile
>> >  rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (54%)
>> >  create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c
>> >  create mode 100644 drivers/pci/controller/plda/pcie-plda.h
>> >  create mode 100644 drivers/pci/controller/plda/pcie-starfive.c
>> > 
>> > 
>> > base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
>> > -- 
>> > 2.17.1
>> > 

