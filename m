Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0597558B4A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 00:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiFWWjQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 18:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFWWjQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 18:39:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC47517E1;
        Thu, 23 Jun 2022 15:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 037CA61F09;
        Thu, 23 Jun 2022 22:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC72C3411D;
        Thu, 23 Jun 2022 22:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656023954;
        bh=S4WWJyuDUUy36N0zfidu47v4kR0PUKk0GxxwzmRe/qQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BDBr8miMeRKnq5c6hcSX7Cwi/A8NWFtOL42DMg0ak30Qv5heofcCoan7E8RpSLJF4
         JD2nNVSICrIhhYzZ8aMduitnZ2TaFsSSZKml99RzhN83DyBRbdwgt/B04C7IMzvLse
         G5muGsKXg+CeDEh+MrwJiKNpv14u455bsxPDs+ctqP8vl2oCOH+FKMxX7CzX6qZPmW
         /BENOKOH67q5tChTLpO5IC5RokTrcmJ7QKTDdtqMWXsKbYrD0ESKkz4plg++w1fGK6
         UoarKqSkzRmwYAAmRQgnk2TGl8PI3Yb84uRDTdSlTza0CJXPenwgkisY8D1+fthO9m
         fnXDca7hdJeTQ==
Date:   Thu, 23 Jun 2022 17:39:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v6 0/6] RZN1 USB Host support
Message-ID: <20220623223912.GA1484125@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520094155.313784-1-herve.codina@bootlin.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 20, 2022 at 11:41:49AM +0200, Herve Codina wrote:
> Hi,
> 
> This series add support for the USB Host controllers available on
> RZN1 (r9a06g032) SOC.
> 
> These USB Host controllers are PCI OHCI/EHCI controllers located
> behind a bridge.
> 
> Regards,
> Herve
> 
> Changes v2:
> - Convert bindings to json-schema
> - Update clocks description
> - Remove unneeded '.compatible = "renesas,pci-r9a06g032"'
> 
> Changes v3:
> - Remove the unneeded patch that calls clk_bulk_prepare_enable()
> - Rework the device tree binding (conversion from .txt and RZ/N1 support)
> - Use the RZ/N1 SOCs family only in the driver match compatible string.
> - Enable PM and PM_GENERIC_DOMAIN for RZ/N1 and add the missing
>   '#power-domain-cells' in sysctrl node.
> 
> Changes v4:
> - Remove patches related to PM enable and #pwower-domain-cells as they
>   will be handle out of this series.
> - Add Bob's reviewed-by on patch 1
> - Add Geert's reviewed by on patch 1 and 6
> - Rename clocks and make the 'resets' property optional on RZ/N1 family
> - Reword some commit logs and titles
> - Fix dst node location (sort by node names or unit addresses)
> - Fix the USB PHY node name
> 
> Changes v5:
> - Rename clocks ("usb_" prefix removed)
> - Add Geert's reviewed-by on patch 2, 3, 4 and 5
> 
> Changes v6:
> - Include schema optionnal part (ie 'if:') in a 'allOf:' block
> - Modify commit log on commit 2/6
> 
> Herve Codina (6):
>   dt-bindings: PCI: pci-rcar-gen2: Convert bindings to json-schema
>   dt-bindings: PCI: renesas,pci-rcar-gen2: Add device tree support for
>     r9a06g032
>   PCI: rcar-gen2: Add RZ/N1 SOCs family compatible string

Applied the first three patches (above) to pci/ctrl/rcar-gen2 for
v5.20, thank you!

>   ARM: dts: r9a06g032: Add internal PCI bridge node
>   ARM: dts: r9a06g032: Add USB PHY DT support
>   ARM: dts: r9a06g032: Link the PCI USB devices to the USB PHY
> 
>  .../devicetree/bindings/pci/pci-rcar-gen2.txt |  84 --------
>  .../bindings/pci/renesas,pci-rcar-gen2.yaml   | 186 ++++++++++++++++++
>  arch/arm/boot/dts/r9a06g032.dtsi              |  47 +++++
>  drivers/pci/controller/pci-rcar-gen2.c        |   1 +
>  4 files changed, 234 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
> 
> -- 
> 2.35.1
> 
