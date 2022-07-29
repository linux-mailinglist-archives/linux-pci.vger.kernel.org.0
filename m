Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869FC58545E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jul 2022 19:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbiG2RW4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jul 2022 13:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbiG2RWy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jul 2022 13:22:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414EF7FE53;
        Fri, 29 Jul 2022 10:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1D5161E75;
        Fri, 29 Jul 2022 17:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD90C433C1;
        Fri, 29 Jul 2022 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659115373;
        bh=jzsBm81Z2APGky+J4VtIjqj2/KDbhD3FAL0kxiPdSOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=No/qZkAsLquzTWNBkgsZTV6FzgNlYNPu2stjScU01CvzuWBVz/owz/0gsrseusR0k
         MOeJUNaIlftdcULJiwVEOTqZskOMhZ3j67lGbPJz2FBcL+3ArEv7H5D2wk1Z1LZa7T
         tsSYrZZi/6E1wi0L2YA9WzkqQLroYQJVWr8RSxls6u9FjTz3U1EtwdRF7hjzXRss0K
         Blt4/x6p6rou4NiN0bD5ugXfAM1vTXHCksk4bMuZdxrer6HMc8pUQKpB+3rE6tqJ9q
         BBMrSAjIRTlh8bvSlL6IXJ1wNRauLLz0ty+5n/AoKtV/dc57062mNv+Xcnn+DPlc9w
         q5Ez4JKqk3ItA==
Date:   Fri, 29 Jul 2022 12:22:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, lpieralisi@kernel.org, kw@linux.com,
        thomas.petazzoni@bootlin.com, pali@kernel.org
Subject: Re: [PATCH 0/2] PCI: mvebu: add support for orion soc
Message-ID: <20220729172251.GA465917@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718202843.6766-1-maukka@ext.kapsi.fi>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 11:28:40PM +0300, Mauri Sandberg wrote:
> Hello all!
> 
> Working in close co-operation with Pali we made an initial attempt at bringing
> support for orion PCIe into mvebu PCIe driver. Currently the address of
> workaround memory range is hard coded and based on compatible string only. As
> Pali describes in another thread, we were not able to figure out what's the
> correct way to configure a configuration space. That discussion is here:
> https://lore.kernel.org/linux-pci/20220710225108.bgedria6igtqpz5l@pali/T/#u
> 
> I tested this with D-Link DNS-323 rev A1 and it's working. As usual, all
> comments and feedback is welcome.
> 
> Thanks,
> Mauri
> 
> Mauri Sandberg (2):
>   dt-bindings: PCI: mvebu: Add orion5x compatible
>   PCI: mvebu: add support for orion5x
> 
>  .../devicetree/bindings/pci/mvebu-pci.txt     |  1 +
>  arch/arm/mach-orion5x/common.c                | 13 ----
>  drivers/pci/controller/Kconfig                |  2 +-
>  drivers/pci/controller/pci-mvebu.c            | 59 +++++++++++++++++++
>  4 files changed, 61 insertions(+), 14 deletions(-)

Hi Mauri,

Can you address anything in 2/2 (if necessary), incorporate any acks,
and post a v2?  There was some confusion around the first patch (there
are two in the thread, likely the same?), and I didn't read the 2/2
feedback in detail to see if any changes were needed.

Bjorn
