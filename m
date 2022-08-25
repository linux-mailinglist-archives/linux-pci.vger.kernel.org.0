Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA27C5A104B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 14:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbiHYMXS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 08:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241553AbiHYMXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 08:23:12 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101AEB1B96;
        Thu, 25 Aug 2022 05:23:07 -0700 (PDT)
Date:   Thu, 25 Aug 2022 14:23:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661430184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TArGzTdThvhYzdQovAUE+8bQSNufrXIWdNrfxHDA2tc=;
        b=hk4vCoyD497ddsP26DG6/KNanWkk6tEZq04o+hfYJI5e5Z5F5uix7gwjVe6TGkVMNfGQLi
        Msx8gXHnifznr9DWJ0ToR1pGPV4r2LZ0ZMOPfEu2KFZIgs5GJu7ToRxls2QMm2vpCDy9o7
        5TF6d4p8U1LhXJGkHsYi/Vn1RCGB4Ks=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v3 0/6] Add the iMX8MP PCIe support
Message-ID: <Ywdpps9B3PCno6wK@skidata.com>
References: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

On Thu, Aug 18, 2022 at 03:02:27PM +0800, Richard Zhu wrote:
> Based on the 6.0-rc1 of the pci/next branch. 
> This series adds the i.MX8MP PCIe support and had been tested on i.MX8MP
> EVK board when one PCIe NVME device is used.
> 
> - i.MX8MP PCIe has reversed initial PERST bit value refer to i.MX8MQ/i.MX8MM.
>   Add the PHY PERST explicitly for i.MX8MP PCIe PHY.
> - Add the i.MX8MP PCIe PHY support in the i.MX8M PCIe PHY driver.
>   And share as much as possible codes with i.MX8MM PCIe PHY.
> - Add the i.MX8MP PCIe support in binding document, DTS files, and PCIe
>   driver.
> 
> Main changes v2-->v3:
> - Fix the schema checking error in the PHY dt-binding patch.
> - Inspired by Lucas, the PLL configurations might not required when
>   external OSC is used as PCIe referrence clock. It's true. Remove all
>   the HSIO PLL bit manipulations, and PCIe works fine on i.MX8MP EVK board
>   with one NVME device is used.
> - Drop the #4 patch of v2, since it had been applied by Rob.
> 
> Main changes v1-->v2:
> - It's my fault forget including Vinod, re-send v2 after include Vinod
>   and linux-phy@lists.infradead.org.
> - List the basements of this patch-set. The branch, codes changes and so on.
> - Clean up some useless register and bit definitions in #3 patch.
> 
> Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  16 +++++++--
> arch/arm64/boot/dts/freescale/imx8mp-evk.dts                 |  53 +++++++++++++++++++++++++++++
> arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  46 ++++++++++++++++++++++++-
> drivers/pci/controller/dwc/pci-imx6.c                        |  17 +++++++++-
> drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 150 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------
> drivers/reset/reset-imx7.c                                   |   1 +
> 6 files changed, 232 insertions(+), 51 deletions(-)
> 
>  [PATCH v3 1/6] reset: imx7: Add the iMX8MP PCIe PHY PERST support
>  [PATCH v3 2/6] dt-binding: phy: Add iMX8MP PCIe PHY binding
>  [PATCH v3 3/6] phy: freescale: imx8m-pcie: Add iMX8MP PCIe PHY
>  [PATCH v3 4/6] arm64: dts: imx8mp: add the iMX8MP PCIe support
>  [PATCH v3 5/6] arm64: dts: imx8mp-evk: Add PCIe support
>  [PATCH v3 6/6] PCI: imx6: Add the iMX8MP PCIe support

Thanks for this series!
I've just tested this on our custom i.MX8MP based board with an M.2 SSD
and it seems to work!

Therefore please feel free to add:

Tested-by: Richard Leitner <richard.leitner@skidata.com>

I don't know if it's interesting to you, but here's the dmesg output:

[    0.060405] PCI: CLS 0 bytes, default 64
[    1.252523] ehci-pci: EHCI PCI platform driver
[    1.268608] ohci-pci: OHCI PCI platform driver
[    1.750913] imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
[    1.758221] imx6q-pcie 33800000.pcie: Parsing ranges property...
[    1.765479] imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff -> 0x0000000000
[    1.773695] imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff -> 0x0018000000
[    1.999331] phy phy-32f00000.pcie-phy.1: phy_power_on was called before phy_init
[    2.007562] imx6q-pcie 33800000.pcie: Using 32 MSI vectors
[    2.007626] imx6q-pcie 33800000.pcie: iATU unroll: enabled
[    2.013124] imx6q-pcie 33800000.pcie: iATU regions: 4 ob, 4 ib, align 64K, limit 16G
[    2.120921] imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
[    2.226533] imx6q-pcie 33800000.pcie: PCIe Gen.3 x1 link up
[    2.235492] imx6q-pcie 33800000.pcie: Link up, Gen3
[    2.240380] imx6q-pcie 33800000.pcie: PCIe Gen.3 x1 link up
[    2.246066] imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
[    2.252437] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.257937] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    2.264134] pci_bus 0000:00: root bus resource [mem 0x18000000-0x1fefffff]
[    2.271019] pci_bus 0000:00: scanning bus
[    2.271045] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    2.277070] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    2.283349] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    2.293834] pci 0000:00:00.0: supports D1
[    2.301828] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    2.308195] pci 0000:00:00.0: PME# disabled
[    2.308348] pci 0000:00:00.0: vgaarb: pci_notify
[    2.310109] pci_bus 0000:00: fixups for bus
[    2.310117] pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 0
[    2.310178] pci_bus 0000:01: scanning bus
[    2.310244] pci 0000:01:00.0: [126f:2263] type 00 class 0x010802
[    2.316325] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[    2.323535] pci 0000:01:00.0: 7.876 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x1 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    2.338620] pci 0000:01:00.0: vgaarb: pci_notify
[    2.347400] pci_bus 0000:01: fixups for bus
[    2.347411] pci_bus 0000:01: bus scan returning with max=01
[    2.347422] pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 1
[    2.347435] pci_bus 0000:00: bus scan returning with max=ff
[    2.347455] pci 0000:00:00.0: BAR 0: assigned [mem 0x18000000-0x180fffff]
[    2.354259] pci 0000:00:00.0: BAR 14: assigned [mem 0x18100000-0x181fffff]
[    2.361146] pci 0000:00:00.0: BAR 6: assigned [mem 0x18200000-0x1820ffff pref]
[    2.368383] pci 0000:01:00.0: BAR 0: assigned [mem 0x18100000-0x18103fff 64bit]
[    2.375728] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    2.380965] pci 0000:00:00.0:   bridge window [mem 0x18100000-0x181fffff]
[    2.387853] pcieport 0000:00:00.0: vgaarb: pci_notify
[    2.387921] pcieport 0000:00:00.0: assign IRQ: got 206
[    2.387984] imx6q-pcie 33800000.pcie: msi#0 address_hi 0x0 address_lo 0x42587000
[    2.388095] pcieport 0000:00:00.0: PME: Signaling with IRQ 207
[    2.394218] pcieport 0000:00:00.0: AER: enabled with IRQ 207
[    2.399963] pcieport 0000:00:00.0: saving config space at offset 0x0 (reading 0xabcd16c3)
[    2.399972] pcieport 0000:00:00.0: saving config space at offset 0x4 (reading 0x100507)
[    2.399979] pcieport 0000:00:00.0: saving config space at offset 0x8 (reading 0x6040001)
[    2.399985] pcieport 0000:00:00.0: saving config space at offset 0xc (reading 0x10000)
[    2.399992] pcieport 0000:00:00.0: saving config space at offset 0x10 (reading 0x18000000)
[    2.399998] pcieport 0000:00:00.0: saving config space at offset 0x14 (reading 0x0)
[    2.400005] pcieport 0000:00:00.0: saving config space at offset 0x18 (reading 0xff0100)
[    2.400011] pcieport 0000:00:00.0: saving config space at offset 0x1c (reading 0xf0)
[    2.400018] pcieport 0000:00:00.0: saving config space at offset 0x20 (reading 0x18101810)
[    2.400024] pcieport 0000:00:00.0: saving config space at offset 0x24 (reading 0xfff0)
[    2.400031] pcieport 0000:00:00.0: saving config space at offset 0x28 (reading 0x0)
[    2.400037] pcieport 0000:00:00.0: saving config space at offset 0x2c (reading 0x0)
[    2.400043] pcieport 0000:00:00.0: saving config space at offset 0x30 (reading 0x0)
[    2.400049] pcieport 0000:00:00.0: saving config space at offset 0x34 (reading 0x40)
[    2.400056] pcieport 0000:00:00.0: saving config space at offset 0x38 (reading 0x0)
[    2.400062] pcieport 0000:00:00.0: saving config space at offset 0x3c (reading 0x201ce)
[    2.400091] pcieport 0000:00:00.0: vgaarb: pci_notify
[    2.400192] nvme 0000:01:00.0: vgaarb: pci_notify
[    2.400230] nvme 0000:01:00.0: assign IRQ: got 206
[    2.400431] nvme nvme0: pci function 0000:01:00.0
[    2.405166] nvme 0000:01:00.0: vgaarb: pci_notify
[    2.405178] nvme 0000:01:00.0: enabling device (0000 -> 0002)
[    2.410959] nvme 0000:01:00.0: enabling bus mastering
[    2.411068] imx6q-pcie 33800000.pcie: msi#1 address_hi 0x0 address_lo 0x42587000
[    2.411132] nvme 0000:01:00.0: saving config space at offset 0x0 (reading 0x2263126f)
[    2.411142] nvme 0000:01:00.0: saving config space at offset 0x4 (reading 0x100406)
[    2.411151] nvme 0000:01:00.0: saving config space at offset 0x8 (reading 0x1080203)
[    2.411162] nvme 0000:01:00.0: saving config space at offset 0xc (reading 0x0)
[    2.411172] nvme 0000:01:00.0: saving config space at offset 0x10 (reading 0x18100004)
[    2.411184] nvme 0000:01:00.0: saving config space at offset 0x14 (reading 0x0)
[    2.411194] nvme 0000:01:00.0: saving config space at offset 0x18 (reading 0x0)
[    2.411205] nvme 0000:01:00.0: saving config space at offset 0x1c (reading 0x0)
[    2.411216] nvme 0000:01:00.0: saving config space at offset 0x20 (reading 0x0)
[    2.411226] nvme 0000:01:00.0: saving config space at offset 0x24 (reading 0x0)
[    2.411237] nvme 0000:01:00.0: saving config space at offset 0x28 (reading 0x0)
[    2.411247] nvme 0000:01:00.0: saving config space at offset 0x2c (reading 0x22631dee)
[    2.411258] nvme 0000:01:00.0: saving config space at offset 0x30 (reading 0x0)
[    2.411269] nvme 0000:01:00.0: saving config space at offset 0x34 (reading 0x40)
[    2.411280] nvme 0000:01:00.0: saving config space at offset 0x38 (reading 0x0)
[    2.411290] nvme 0000:01:00.0: saving config space at offset 0x3c (reading 0x1ce)
[    2.415562] nvme nvme0: missing or invalid SUBNQN field.
[    2.428381] nvme nvme0: allocated 64 MiB host memory buffer.
[    2.436360] imx6q-pcie 33800000.pcie: msi#1 address_hi 0x0 address_lo 0x42587000
[    2.436415] imx6q-pcie 33800000.pcie: msi#2 address_hi 0x0 address_lo 0x42587000
[    2.436453] imx6q-pcie 33800000.pcie: msi#3 address_hi 0x0 address_lo 0x42587000
[    2.436491] imx6q-pcie 33800000.pcie: msi#4 address_hi 0x0 address_lo 0x42587000
[    2.436529] imx6q-pcie 33800000.pcie: msi#5 address_hi 0x0 address_lo 0x42587000
[    2.442960] nvme nvme0: 4/0/0 default/read/poll queues
[    2.452699] nvme nvme0: Ignoring bogus Namespace Identifiers
[    2.459882]  nvme0n1: p1

regards;rl
