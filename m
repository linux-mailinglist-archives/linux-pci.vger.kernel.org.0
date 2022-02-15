Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC34B7323
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 17:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiBOPUa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 10:20:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238746AbiBOPUa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 10:20:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF3A108BDC;
        Tue, 15 Feb 2022 07:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 633D3B81AE2;
        Tue, 15 Feb 2022 15:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B299DC340ED;
        Tue, 15 Feb 2022 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644938417;
        bh=cvvJ7Y1uOZsTSQ2EgEC3IyWSOPxIRWdyF+l3TLo73fA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BXhMIXjvG0BZrIJ4AGpwnd1+8ps21YN90C6Bx7kEUxLMo/3m80ucK5R2bJrFaSirP
         hI8uY5ws0E9o9oeS7ygCnZn6rdX20Z7ZkmnXG3d4Itv8GmCZs5x4WR3o9ZsiOD/0xK
         pjCS+7Sc/J+zkjtJHi1ejsXElZXX22ywEpgJgjn/E/G7RBWtv5lenBDo0E9BqIJC1b
         FoMjo02LYKKLmVYTRBDWVWEaSFKMJbpkAxHboipvvicoSmN7zmAnV/ynYX13emGxEm
         PaWa7Ira/bSgUfxTAwWlSxlmJ7QjNPXpVyokVltb4aiYv544BfK1XAdNmBeVpa6Doj
         1g0Yi++3vwe1g==
Date:   Tue, 15 Feb 2022 09:20:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.comv,
        linux-pci@vger.kernel.org, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, david.abdurachmanov@gmail.com,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/2] PCI: fu740: fix finding GPIOs
Message-ID: <20220215152014.GA108566@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfb2b7f9-d2dc-590c-6cec-5923efa9ac80@codethink.co.uk>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 15, 2022 at 11:21:03AM +0000, Ben Dooks wrote:
> On 14/02/2022 16:05, Bjorn Helgaas wrote:
> > [+cc Rob for possible DT/kernel match issue,
> > Lorenzo (native host bridge driver maintainer)]
> > 
> > s/fix finding/Fix finding/ (in subject)
> > Or even better, say something specific about the DT properties in
> > question, e.g., look for "reset" instead of "reset-gpios".
> > 
> > On Mon, Feb 14, 2022 at 08:21:43AM +0000, Ben Dooks wrote:
> > > The calls to devm_gpiod_get_optional() have the -gpios at the end of
> > > the name. This means the pcie driver is not finding the necessary
> > > reset or power GPOOs to allow the PCIe devices on the SiFive Unmatched
> > > boards.
> > 
> > "to allow the PCIe devices ...?"  Something is missing from this
> > sentence.  "To allow the devices <to do what>"?  Or maybe the driver
> > needs these GPIOs to power up the PCIe devices?
> > 
> > I guess the implication is that the code looks for "reset-gpios" and
> > "pwren-gpios", but the DT contains "reset" and "pwren"?
> > 
> > But both Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> > and arch/riscv/boot/dts/sifive/fu740-c000.dtsi actually do contain
> > "reset-gpios" and "pwren-gpios".
> 
> Yes, the issue is the gpio core code adds either "-gpio" or "-gpios"
> itself, thus the find code does not need this. The error messages and
> DT are correct. I'll reword the initial paragraph to note that which
> should also deal with the other comments:
> 
> The calls to devm_gpiod_get_optional() have the -gpios at the end of
> the name but the GPIO core code is already adding the suffix during
> the lookup. This means the PCIe driver is not finding the necessary
> reset or power lines to allow initialisation of the PCIe.

Ah, that makes things make a LOT more sense!  Please add something
about "the '-gpios' suffix" for non-experts like me who don't know the
inner workings of the GPIO core.

The GPIO core seems slightly too helpful here -- we have to know about
that detail to write error messages that make sense.

> > If we *do* want to change the code, please change the error messages
> > to match.
> 
> See above, it is just devm_gpiod_get_optional() parameters at fault.
> 
> > > This has not been a noted bug as the PCIe probe from u-boot has been
> > > required to get the PCIe working due to other issues with the system
> > > setup. It could have been broken since the driver inclusion, and not
> > > been noticed as it is not necessary for the driver to funciton.
> > 
> > Please add a line about what the connection between U-Boot and this
> > issue is, e.g., maybe U-Boot powers up the devices, so we wouldn't
> > notice the kernel's inability to do so?
> 
> Does a reword to the following make better sense:
> 
> This bug has not been noticed as if U-Boot has setup the GPIO lines
> for the hardware when it does the PCIe initialisation (either by
> booting from PCIe or user command to access PCIe) then the PCIe
> will work in Linux. The U-Boot as supplied by SiFive does not by
> default initialise any PCIe component.

Sounds good, thanks.

Bjorn
