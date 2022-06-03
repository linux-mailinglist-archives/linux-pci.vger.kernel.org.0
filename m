Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091FA53CCEB
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343620AbiFCQJT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 12:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiFCQJS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 12:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D7E2C103;
        Fri,  3 Jun 2022 09:09:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B94A2618D9;
        Fri,  3 Jun 2022 16:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3E3C385B8;
        Fri,  3 Jun 2022 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654272556;
        bh=9XDqZH7lKMypp0xEWeC0uCWAmpLurZw7YA9gs7/cFME=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lOnBJhZMF960+5MB1wXCaFBswhFih5K6XyC3STZC/40lQ414CeoIq03ECPFdsOekJ
         i3iKetKWPwMOUDMiGL4YJKYtveSRD1A7UzFol1Wvgbc+vTxpwn7hWY0pdmL9bXjMD+
         MFl/5yCcM1ktib7s8fHzW6hGzRdYQHinjXASR7mFYSMdboKI6ZG9oPfvYEz2kXZgPL
         IdwZobgynLNeeduuBwwAHv4gAkNTqetRbhItA5f5SXzPsg15ldXaVHFowth0MeoXSJ
         xcwcb6G+pCNsmBj8DmDHjd5OlP8KeKtYSSGBC6Le4VT2lmu4MInto7ZwONEqIgp5Ad
         lehsaVkAJ/e3A==
Date:   Fri, 3 Jun 2022 11:09:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add maintainer for Axis ARTPEC-8
 PCIe PHY driver
Message-ID: <20220603160913.GA80202@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603024347epcms2p48d01596e10b251bec077581a6c609c48@epcms2p4>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject:

  MAINTAINERS: Add Axis ARTPEC-8 PCIe PHY maintainers

to put the important things first so they don't get chopped off by
"git log --oneline" and similar.

On Fri, Jun 03, 2022 at 11:43:47AM +0900, Wangseok Lee wrote:
> Add maintainer for Axis ARTPEC-8 PCIe PHY.
> 
> Add Jesper Nilsson <jesper.nilsson@axis.com> and
> Lars Persson <lars.persson@axis.com> as Maintainer for these files.

s/Maintainer/maintainers/

> ARTPEC-8 is the SoC platform of Axis Communications
> and PCIe phy is designed based on Samsung PHY.

s/phy/PHY/ to match other uses.

Rewrap all of above to fill 75 columns.

> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>

Obviously we'll look for acks from Jesper and Lars.

Also would be good if Jesper explicitly acked the fact that his
existing "PCIE DRIVER FOR AXIS ARTPEC" entry also matches the new
pcie-artpec8.c driver:

  PCIE DRIVER FOR AXIS ARTPEC
  M:      Jesper Nilsson <jesper.nilsson@axis.com>
  L:      linux-arm-kernel@axis.com
  L:      linux-pci@vger.kernel.org
  S:      Maintained
  F:      Documentation/devicetree/bindings/pci/axis,artpec*
  F:      drivers/pci/controller/dwc/*artpec*

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d4d4aa2..cd6f75b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1864,12 +1864,14 @@ M:	Jesper Nilsson <jesper.nilsson@axis.com>
>  M:	Lars Persson <lars.persson@axis.com>
>  L:	linux-arm-kernel@axis.com
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
>  F:	arch/arm/boot/dts/artpec6*
>  F:	arch/arm/mach-artpec
>  F:	drivers/clk/axis
>  F:	drivers/crypto/axis
>  F:	drivers/mmc/host/usdhi6rol0.c
> +F:	drivers/phy/artpec/phy-artpec*
>  F:	drivers/pinctrl/pinctrl-artpec*
>  
>  ARM/ASPEED I2C DRIVER
> -- 
> 2.9.5
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
