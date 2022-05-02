Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD035172A2
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 17:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385818AbiEBPgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 11:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385871AbiEBPgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 11:36:07 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2D7BE0B;
        Mon,  2 May 2022 08:32:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DD83041E96;
        Mon,  2 May 2022 15:32:21 +0000 (UTC)
Message-ID: <0ccc44cd-21aa-3670-24b3-4ee051dd3c12@marcan.st>
Date:   Tue, 3 May 2022 00:32:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: es-ES
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220502093832.32778-1-marcan@marcan.st>
 <20220502093832.32778-4-marcan@marcan.st>
 <CAL_Jsq+_cWZUXtJVXC_cwhmADj0NQc95v1sqgFioMsfEX6OqGg@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 3/3] PCI: apple: Add support for optional PWREN GPIO
In-Reply-To: <CAL_Jsq+_cWZUXtJVXC_cwhmADj0NQc95v1sqgFioMsfEX6OqGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
> standard MMC/SD DT properties. The secondary issue is we'll end up
> adding more power sequencing properties to control ordering and timing
> for different devices. The exception here is standard PCI slot
> properties like perst#, clkreq, and standard voltage rails can go in
> the host bridge (and for new bindings, those should really be in the
> root port node). For a complicated example, see Hikey960 or 970.
> 
> Of course with power control related properties there's a chicken or
> egg issue that the PCI device is not discoverable until the device is
> powered on. This issue comes up over and over with various hacky
> solutions in the bindings. The PCI subsystem needs to solve this. My
> suggestion is that if the firmware says there is a device on the bus
> and it wasn't probed, then we should force probing (or add a pre-probe
> hook for drivers). That is what MDIO bus does for example.
> 

I agree with the premise. Right now macOS does not actually power down
these devices as far as I know (except maybe sleep mode? not sure what
goes on then yet), but I think the hardware actually has an SD card
detect GPIO hookup that would allow us to entirely power down the SD
controller when no card is inserted. That would obviously be ideal.

FWIW, we do have the device nodes downstream [1]. I did in fact have to
add the SD one for the CD/WP inversion flags (and had to add driver
support for that too).

That said, as for how to make this happen in the PCI subsystem
properly... I think I'll defer to the maintainers' opinion there before
trying to hack something up ;)

Meanwhile, I guess I better get PCIe hotplug working, since doing it in
the driver isn't going to work without that first...

[1]
https://github.com/AsahiLinux/linux/blob/bits/000-devicetree/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi#L222

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
