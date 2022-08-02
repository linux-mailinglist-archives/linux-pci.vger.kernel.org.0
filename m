Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F1E588156
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 19:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiHBRtv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 13:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiHBRtu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 13:49:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54A4DF51;
        Tue,  2 Aug 2022 10:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64E006124C;
        Tue,  2 Aug 2022 17:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ACEC433D6;
        Tue,  2 Aug 2022 17:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659462588;
        bh=SiDSLNYqS+YCU6eABTOFnw8yzFj7rK8ND4yKHLw9GSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ej5aZu6zGAp7YNdqGlldZ+bgVeK6ayHmJAE2qmFYUPjrc9IfUztB9D+8hNrfS7oiC
         aN/Ax6B6iQqVhZNwukHUCxo4Q6LOrqf2uBn8gKpLxp3E16qx8sWC9vqFK3/iUcub7z
         Mhb+ail9AjacTKmhJV/7BY03t2mgpH5A1aEwZWv6HvlJb2jhq9zj+5LHdh3dYjV2EQ
         jr3ckbQsYt4SJ0rjh8+4MtwSd874bu/srH/ZfwyNqZ/QJmgd/nOKLDWqA4pIDDyxb0
         Dw8CLx2emQpbbmlPe6xnPi8ZEuGPBBu9hx/R5vlheVhckR2GpoL6QwL1vzadOCelKb
         KAdFhIQ/S2fjQ==
Received: by pali.im (Postfix)
        id 3C024F81; Tue,  2 Aug 2022 19:49:45 +0200 (CEST)
Date:   Tue, 2 Aug 2022 19:49:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, lpieralisi@kernel.org, kw@linux.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 0/2] PCI: mvebu: add support for orion soc
Message-ID: <20220802174945.5nyywb4mmbnhkzys@pali>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220802173423.47230-1-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802173423.47230-1-maukka@ext.kapsi.fi>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 02 August 2022 20:34:21 Mauri Sandberg wrote:
> Hello all,
> 
> Here a cleaned up version of the previous series.
> 
> Changes
>  - instead of removing PCIe related mvebu windows add them in pcie_setup()
> 
> I intentionally left the ORION5X_PCIE_WA_VIRT_BASE in place as all pieces
> in the puzzle have not found their place yet. It will be replaced with
> ioremap() or similar when the problem of passing the address to
> configuration space from a device tree is solved.

Hello all, could you please look at the issue how to write
representation of PCIe config space in device tree?
https://lore.kernel.org/linux-devicetree/20220710225108.bgedria6igtqpz5l@pali/

Without it we cannot finish this conversion of orion5x pcie code from
arch/arm to pci-mvebu.c

> Tested with DNS323 both DT and non-DT builds.
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
>  arch/arm/mach-orion5x/pci.c                   | 14 +++++
>  drivers/pci/controller/Kconfig                |  2 +-
>  drivers/pci/controller/pci-mvebu.c            | 59 +++++++++++++++++++
>  5 files changed, 75 insertions(+), 14 deletions(-)
> 
> 
> base-commit: 7d0d3fa7339ed5a06d6608b7cde9f079eba62bb1
> --
> 2.25.1
