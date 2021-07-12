Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A803C65AD
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 23:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhGLVwL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 17:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhGLVwL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jul 2021 17:52:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C87D661242;
        Mon, 12 Jul 2021 21:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626126562;
        bh=5+SQKlLNXntVyKAWJ7ubUeOOD27FMsC6Ce0L/Q9WZT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h2Eni2cOBDf3QZXPixc2sRW3RLfB/Cjm2htB3YUgudNs4PrY57n7Ils0zmVonubgZ
         RZg6Z/+r3SdvCluxueaswOSBU3L7QX3p5yJxG3AbAoWW9F5GjQhX7lJiQU2I95jPdS
         UFByboXfdVzmESRMLIhrk/5GL1MaLCjO44xPpiYkG2wtWwhS6kNbO10hkDix4eXBon
         Ia9u/YmsvcH/Ei4UaJLvlBKNWwA1QKnhtt5W6IDvhq5f2UzNqKZERSxefiB/ALjoTQ
         efSJs0Eb7rkAorhDMc8E7fKb9m8rBXH1UEazx4Y2lJ/vD+BYg+iSPMTpgcKIZ/tuIV
         A5Gj63mF9+Epg==
Date:   Mon, 12 Jul 2021 23:49:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 0/9] Add support for Hikey 970 PCIe
Message-ID: <20210712234916.5a1e6387@coco.lan>
In-Reply-To: <20210712081944.GC8113@workstation>
References: <cover.1625826353.git.mchehab+huawei@kernel.org>
        <20210712081944.GC8113@workstation>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Mon, 12 Jul 2021 13:49:44 +0530
Manivannan Sadhasivam <mani@kernel.org> escreveu:

> Hi Mauro,
> 
> On Fri, Jul 09, 2021 at 12:41:36PM +0200, Mauro Carvalho Chehab wrote:
> > As requested by Rob Herring, this series split the PHY part into a separate driver.
> > Then, it adds support for Kirin 970 on a single patch.
> > 
> > With this change, the PHY-specific device tree bindings for Kirin 960 moved
> > to its own PHY properties.
> > 
> > Manivannan,
> > 
> > Please notice that the last two patches are marked as co-developed:
> > 
> > 	phy: hisilicon: add driver for Kirin 970 PCIe PHY
> > 	arm64: dts: hisilicon: Add support for HiKey 970 PCIe controller hardware
> > 
> > The first one contains the code you submitted in the past adding
> > support for Kirin 970 at the pcie-kirin driver, modified by me and
> > moved to a separate driver.
> > 
> > The second one is the DTS file, also modified by me in order to split the PHY
> > properties from the PCIe ones.
> > 
> > Please send your SoB to confirm that both changes are OK for you.
> >   
> 
> I'm fine with the changes. The dts patch already has my s-o-b as you
> preserved my authorship and I've sent my s-o-b for the driver patch.
> I used my korg address for the driver patch but that's fine as all these
> efforts were done in my spare time.

Thank you! Sent v4 with your SoB at the driver part. I'll submit
your DTS patch later on, as it depends on a patch adding DT for HiKey 970
PMIC, that should be merged via another tree.

Regards,
Mauro

> 
> Thanks,
> Mani
> 
> > Tested on Hikey970:
> > 
> >   $ lspci
> >   00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3670 (rev 01)
> >   01:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >   02:01.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >   02:04.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >   02:05.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >   02:07.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >   02:09.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI Express Gen 2 (5.0 GT/s) Switch (rev ba)
> >   06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 07)
> > 
> >   $ ethtool enp6s0
> >   Settings for enp6s0:
> > 	Supported ports: [ TP	 MII ]
> > 	Supported link modes:   10baseT/Half 10baseT/Full
> > 	                        100baseT/Half 100baseT/Full
> > 	                        1000baseT/Half 1000baseT/Full
> > 	Supported pause frame use: Symmetric Receive-only
> > 	Supports auto-negotiation: Yes
> > 	Supported FEC modes: Not reported
> > 	Advertised link modes:  10baseT/Half 10baseT/Full
> > 	                        100baseT/Half 100baseT/Full
> > 	                        1000baseT/Half 1000baseT/Full
> > 	Advertised pause frame use: Symmetric Receive-only
> > 	Advertised auto-negotiation: Yes
> > 	Advertised FEC modes: Not reported
> > 	Link partner advertised link modes:  10baseT/Half 10baseT/Full
> > 	                                     100baseT/Half 100baseT/Full
> > 	Link partner advertised pause frame use: Symmetric Receive-only
> > 	Link partner advertised auto-negotiation: Yes
> > 	Link partner advertised FEC modes: Not reported
> > 	Speed: 100Mb/s
> > 	Duplex: Full
> > 	Auto-negotiation: on
> > 	master-slave cfg: preferred slave
> > 	master-slave status: slave
> > 	Port: Twisted Pair
> > 	PHYAD: 0
> > 	Transceiver: external
> > 	MDI-X: Unknown
> >   netlink error: Operation not permitted
> > 	Link detected: yes
> > 
> > Partially tested on Hikey 960[1]:
> > 
> >   $ lspci
> >   00:00.0 PCI bridge: Huawei Technologies Co., Ltd. Device 3660 (rev 01)
> > 
> > [1] The Hikey 960 doesn't come with any internal PCIe device.
> >     Its hardware supports just an external device via a M.2 slot that
> >     doesn't support SATA. I ordered a NVMe device to test, but the vendor
> >     is currently out of supply. It should take 4-5 weeks to arrive here. I'll
> >     run an extra test on it once it arrives.
> > 
> > Manivannan Sadhasivam (1):
> >   arm64: dts: hisilicon: Add support for HiKey 970 PCIe controller
> >     hardware
> > 
> > Mauro Carvalho Chehab (8):
> >   dt-bindings: phy: add bindings for Hikey 960 PCIe PHY
> >   dt-bindings: phy: add bindings for Hikey 970 PCIe PHY
> >   dt-bindings: PCI: kirin: fix compatible string
> >   dt-bindings: PCI: kirin: drop PHY properties
> >   phy: hisilicon: add a PHY driver for Kirin 960
> >   PCI: kirin: drop the PHY logic from the driver
> >   PCI: kirin: use regmap for APB registers
> >   phy: hisilicon: add driver for Kirin 970 PCIe PHY
> > 
> >  .../devicetree/bindings/pci/kirin-pcie.txt    |  21 +-
> >  .../phy/hisilicon,phy-hi3660-pcie.yaml        |  82 ++
> >  .../phy/hisilicon,phy-hi3670-pcie.yaml        | 101 ++
> >  arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |  29 +-
> >  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  72 ++
> >  .../boot/dts/hisilicon/hikey970-pmic.dtsi     |   1 -
> >  drivers/pci/controller/dwc/pcie-kirin.c       | 298 ++----
> >  drivers/phy/hisilicon/Kconfig                 |  20 +
> >  drivers/phy/hisilicon/Makefile                |   2 +
> >  drivers/phy/hisilicon/phy-hi3660-pcie.c       | 325 +++++++
> >  drivers/phy/hisilicon/phy-hi3670-pcie.c       | 892 ++++++++++++++++++
> >  11 files changed, 1572 insertions(+), 271 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3660-pcie.yaml
> >  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> >  create mode 100644 drivers/phy/hisilicon/phy-hi3660-pcie.c
> >  create mode 100644 drivers/phy/hisilicon/phy-hi3670-pcie.c
> > 
> > -- 
> > 2.31.1
> > 
> >   



Thanks,
Mauro
