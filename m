Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400DF517913
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 23:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385101AbiEBV3h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 17:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379908AbiEBV3g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 17:29:36 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 14:26:04 PDT
Received: from sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1714DE90;
        Mon,  2 May 2022 14:26:03 -0700 (PDT)
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id e3c03a39;
        Mon, 2 May 2022 22:59:21 +0200 (CEST)
Date:   Mon, 2 May 2022 22:59:21 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Rob Herring <robh@kernel.org>
CC:     "Marc Zyngier" <maz@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>, kw@linux.com,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Sven Peter" <sven@svenpeter.dev>, PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: apple: Add support for optional PWREN GPIO
Message-ID: <d3cd3ad1ee4f31f5@bloch.sibelius.xs4all.nl>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob (& Hector),

On 03/05/2022 00.14, Rob Herring wrote:
> On Mon, May 2, 2022 at 4:39 AM Hector Martin <marcan@marcan.st> wrote:
>>
>> WiFi and SD card devices on M1 Macs have a separate power enable GPIO.
>> Add support for this to the PCIe controller. This is modeled after how
>> pcie-fu740 does it.
> 
> It did, but it's not ideal really. The problem is the GPIO is really
> associated with the device (WiFi/SD) rather than the PCI host and
> therefore should be part of a WiFi or SD node. You probably don't have
> one (yet), but I would suspect that SD will need one for all the
> standard MMC/SD DT properties.

Not really.  The SD card controller is a "standard" GL9755 PCIe SDHC
controller that is already supported by Linux.

It does indeed get a DT node though because the card detect and write
protect signals are inverted and the driver needs to initialize some
PCIe config space registers to compensate for that.

> The secondary issue is we'll end up adding more power sequencing
> properties to control ordering and timing for different devices.

That isn't obvious.  Even though there isn't an actual PCIe slot these
still are PCIe compliant devices and therefore governed by the PCIe
standard power up sequencing.

> The exception here is standard PCI slot properties like perst#,
> clkreq, and standard voltage rails can go in the host bridge (and
> for new bindings, those should really be in the root port node). For
> a complicated example, see Hikey960 or 970.

I don't think there is a fundamental difference between having a GPIO
that controls the standard voltage rails of a PCIe slot (like on the
HiFive Unmatched board) and a GPIO that controls the power to a chip
soldered onto the motherboard (like the ASM2824 soldered onto the
HiFive Unmatched board and WiFi/SD on these Apple M1 systems).  I
don't think it makes sense to describe this in different ways just
because in one case there is a physical connector present.

Note that the proposed patch does add the "pwren-gpio" property on the
root port node as you suggest.

> Of course with power control related properties there's a chicken or
> egg issue that the PCI device is not discoverable until the device is
> powered on. This issue comes up over and over with various hacky
> solutions in the bindings. The PCI subsystem needs to solve this. My
> suggestion is that if the firmware says there is a device on the bus
> and it wasn't probed, then we should force probing (or add a pre-probe
> hook for drivers). That is what MDIO bus does for example.

But in the case of an actual PCIe slot firmware can't really describe
the PCIe device itself in the DT since it might not be there.

And your suggestion would be quite painful in other contexts where the
device tree will be used (U-Boot, *BSD), which all assume that a PCI
bus can be enumerated.
