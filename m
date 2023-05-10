Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF2B6FE728
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 00:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjEJW0T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 18:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjEJW0R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 18:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B66530C6;
        Wed, 10 May 2023 15:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15016636DE;
        Wed, 10 May 2023 22:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6F6C433D2;
        Wed, 10 May 2023 22:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683757573;
        bh=qmFQKtkE1gTceJII0jG7RE2nlVK1IKYR6/v22YmmBmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bXm/ueQ/7By5xMiJvEBKO//AYxYB7+e64TST45e1KBR1MKllmiGJZPFlk+4jhUCTU
         aghL+hrcJq2e/L5/t5osxM6TClpA/vrFrbLcRse/cq7LlUIY9lvMkm8icCQdR3GnTl
         GCeXgUkxBlZSgwn57Hvc8xmoRKawGCwhY3Bm7nR4lbO3f2tg7bFxfiVcnRNBO2qSj7
         IEEdbjo/uOiO8rurfCgHjvDQ09goyGgTYN6W35W7Adv6E4jw8w4HWz070TOw3rKi77
         6HIDJekP1nKSD5QMUR2zJcIp9pPtsKlIACLIBOl82DZC9/zUlxOjhpKQko7qpRAmdu
         qqA/ibcqb4kAA==
Date:   Wed, 10 May 2023 17:26:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] PCI: brcmstb: Don't assume 2711 bootloader leaves
 PERST# asserted
Message-ID: <ZFwaA403wLnDg3TI@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508220126.16241-5-jim2101024@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Re subject, what does the patch actually *do*?

It looks like it "asserts PERST# on BCM2711", which I think would be
more informative than "don't assume 2711 bootloader leaves PERST#
asserted".

On Mon, May 08, 2023 at 06:01:24PM -0400, Jim Quinlan wrote:
> The current PCIe driver assumes PERST# is asserted when probe() is invoked.
> The reasons are as follows:
> 
> (1) One Broadcom SOC (7278) causes a panic if the PERST# register is
>     written during this time window.
> 
> (2) If PERST# is deasserted at Linux probe() time, experience and QA
>     suspend/resume tests have shown that some endpoint devices fail if the
>     PERST# is pulsed (deasserted => asserted => deasserted) quickly in this
>     fashion, even though the timing is in accordance with their datasheets.
> 
> (3) Keeping things in reset tends to save power, if for some reason the
>     PCIe driver is not yet present.
> 
> Broadcom STB and CM SOCs bootloaders always have PERST# asserted at
> probe().  This is not necessarily the case for the 2711/RPi bootloader,
> so, for 2711/RPi SOCs, do what Raspian OS does and assert PERST#.
> 
> [1] https://lore.kernel.org/linux-pci/20230411165919.23955-1-jim2101024@gmail.com/T/#m39ebab8bc2827b2304aeeff470a6c6a58f46f987

Does this link go with something above?  "[1]" isn't mentioned above.
I did look at that message, but the connection to this patch isn't
obvious to me.

> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index fe0415a98c63..7b698a9a851e 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -884,6 +884,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  
>  	/* Reset the bridge */
>  	pcie->bridge_sw_init_set(pcie, 1);
> +
> +	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
> +	if (pcie->type == BCM2711)
> +		pcie->perst_set(pcie, 1);
> +
>  	usleep_range(100, 200);
>  
>  	/* Take the bridge out of reset */
> -- 
> 2.17.1
> 
