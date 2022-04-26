Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8338151027F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 18:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352776AbiDZQEq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 12:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbiDZQEp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 12:04:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B578B3BFB9;
        Tue, 26 Apr 2022 09:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9785CE1F73;
        Tue, 26 Apr 2022 16:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC57C385AA;
        Tue, 26 Apr 2022 16:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650988894;
        bh=V9bqxROuLoIKwO7jBdqPsf9/DBBXipHAZ1xgMxIrwxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lZkoCILrM0a540ltNPfzBZw+KIGbs4o67Vfcqb0kEq1d0i/snNsZGdNE1pSmcf0mB
         h/yCk72Itf+O/wLTMqFm3kJI54aKe+D4p/cj1tb7N2+V0jZI9NfMZV/7Ti5nPCe4Sj
         kzzxrWTvu5dDz9ZKFQrwD+p5luJrRL6LeZmddGgW0RIHci4pmO8VQzk1hYdugZSNOm
         1MfYeJ1JfhhAqZZ/nk0yGl3w35hrzh2EkbiaVlrbo4H/T16ki0b1yapu+31ippsUcZ
         dXnjDP3s9gSSOEF96HbzT8CS2uMK4400Q5gUS2RMUsFuuxDEJf78veGXM12WkVsG19
         cfVESoP/NLSIQ==
Date:   Tue, 26 Apr 2022 11:01:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-rockchip@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [RFC/RFT v2 00/11] RK3568 PCIe V3 support
Message-ID: <20220426160132.GA1724099@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426132139.26761-1-linux@fw-web.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 26, 2022 at 03:21:28PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This series adds Rockchip PCIe V3 support found on rk3568 SOC.
> 
> It is based on "Enable rk356x PCIe controller" series of Peter Geis
> v8: https://patchwork.kernel.org/project/linux-rockchip/list/?series=634925
> 
> Compared to PCIeV2 which uses the Naneng combphy, pciev3
> uses a dedicated pci-phy.
> 
> This Version is still an RFC/RFT because i cannot only test PCIe-slot on R2Pro
> as the other is a M.2 Key-E where i don't have any Hardware.
> 
> last 3 Patches show a replacement for bifurcation setting to make it more
> useful for vendor-indepent lane-mapping.
> 
> Frank Wunderlich (11):
>   dt-bindings: phy: rockchip: add PCIe v3 phy
>   dt-bindings: soc: grf: add pcie30-{phy,pipe}-grf
>   dt-bindings: phy: rockchip: add PCIe v3 constants
>   phy: rockchip: Support PCIe v3
>   dt-bindings: pci: add bifurcation option to Rockchip DesignWare
>     binding
>   PCI: rockchip-dwc: add PCIe bifurcation
>   arm64: dts: rockchip: rk3568: Add PCIe v3 nodes
>   arm64: dts: rockchip: Add PCIe v3 nodes to BPI-R2-Pro
>   dt-bindings: pci: add lane-map to rockchip PCIe binding
>   PCI: rockchip: add a lane-map to rockchip pcie driver
>   arm64: dts: rockchip: add basic lane-map and drop bifurcation from
>     r2pro

Don't just make up new prefixes; copy what's been done in the past.

  PCI: rockchip-dwc: add PCIe bifurcation
  PCI: rockchip: add a lane-map to rockchip pcie driver

I think we decided [1] to use "rockchip-dwc" for this driver to
distinguish it from the pcie-rockchip-host.c driver.

So both of these should use "PCI: rockchip-dwc:" as the prefix.

At least for the drivers/pci/ patches, capitalize the first word of
the subject, i.e., "Add PCIe bifurcation" and "Add lane-map ..."  I
don't know the dt-bindings convention (I would use "git log --oneline"
to find out).

s/pcie/PCIe/ in subjects, commit logs, comments, etc.

Wrap commit logs to fill 75 columns and add blank lines between
paragraphs.  Readers should not need to wonder "oh, the previous line
was shorter than usual; is this one a new paragraph?"

[1] https://lore.kernel.org/r/20210624180723.GA3543267@bjorn-Precision-5520

>  .../bindings/pci/rockchip-dw-pcie.yaml        |   3 +
>  .../bindings/phy/rockchip,pcie3-phy.yaml      |  84 ++++++
>  .../devicetree/bindings/soc/rockchip/grf.yaml |   3 +
>  .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   |  79 +++++
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 122 ++++++++
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |  22 ++
>  drivers/phy/rockchip/Kconfig                  |   9 +
>  drivers/phy/rockchip/Makefile                 |   1 +
>  .../phy/rockchip/phy-rockchip-snps-pcie3.c    | 278 ++++++++++++++++++
>  include/dt-bindings/phy/phy-rockchip-pcie3.h  |  21 ++
>  include/linux/phy/pcie.h                      |  12 +
>  11 files changed, 634 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
>  create mode 100644 include/dt-bindings/phy/phy-rockchip-pcie3.h
>  create mode 100644 include/linux/phy/pcie.h
> 
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
