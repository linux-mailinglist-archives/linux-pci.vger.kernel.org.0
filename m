Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170937599AC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 17:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjGSP0j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 11:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjGSP0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 11:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8D210F3;
        Wed, 19 Jul 2023 08:26:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 281CA6173E;
        Wed, 19 Jul 2023 15:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE34C433CA;
        Wed, 19 Jul 2023 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689780388;
        bh=ns5KGRSm1qCUcwtmraI8e2J0uq3O7YGwgmpNhsjeKO8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VuJDe3s41aLEcac9qwpGYMw6sUAUSCHpi0OK958F/zb6K3iJ/TpwKmKOd4coAUtWL
         uN7N//0+c8CKRqvPfN2zSRHQReSGQvk16uioiHK0LjDTaHpSTmjT32kSvDOGlpQrg/
         +0L/ASu3edgI4rgYBzetyJyYnFl0fLWpMPCRfsYgAymYBtVOCTuTHkEdRdyoAtTXpC
         xWd4g3Yg2olteJ4zEbU6AjYI33BQ+uNmlpnO+lKG+tOfHseWKPy1ZsfH456n/veSn0
         ij16qm258qtfw1T2VgDrXzfImzM5pI2Nm2/bTtmxJloYVgDYtTuPizBBej0yqHl/lH
         8guSi4DjkHnTw==
Date:   Wed, 19 Jul 2023 10:26:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v1 0/9] Refactoring Microchip PolarFire PCIe driver
Message-ID: <20230719152626.GA502469@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719102057.22329-1-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 19, 2023 at 06:20:48PM +0800, Minda Chen wrote:
> This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
>   dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
> JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
> same IP and have commit their codes, which are mixed with PLDA
> controller codes and Microchip platform codes.

I guess this actually adds TWO drivers: PCIE_PLDA_PLAT_HOST (claims
"plda,xpressrich-pcie-host" devices) and PCIE_STARFIVE_HOST (claims
"starfive,jh7110-pcie" devices), right?

> For re-use the PLDA controller codes, I request refactoring microchip
> codes, move PLDA common codes to PLDA files.
> Desigware and Cadence is good example for refactoring codes.
> 
> So first step is extract the PLDA common codes from microchip, and
> refactoring the microchip codes.(patch1 - 4)
> Then add the PLDA platform codes. (patch5, 6)
> At last, add Starfive codes. (patch7 - 9)
> 
> This patchset is base on v6.5-rc1

Doesn't quite apply cleanly for me:

  10:10:15 ~/linux (main)$ git checkout -b wip/minda-starfive-v1 v6.5-rc1
  Switched to a new branch 'wip/minda-starfive-v1'
  10:10:33 ~/linux (wip/minda-starfive-v1)$ git am m/20230719_minda_chen_refactoring_microchip_polarfire_pcie_driver.mbx
  Applying: dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
  Applying: dt-bindings: PCI: microchip: Remove the PLDA common properties
  Applying: PCI: PLDA: Get PLDA common codes from Microchip PolarFire host
  Applying: PCI: microchip: Move PCIe driver to PLDA directory
  Applying: dt-bindings: PLDA: Add PLDA XpressRICH PCIe host controller
  Applying: PCI: PLDA: Add host conroller platform driver
  Applying: dt-bindings: PCI: Add StarFive JH7110 PCIe controller
  Applying: PCI: PLDA: starfive: Add JH7110 PCIe controller
  Applying: riscv: dts: starfive: add PCIe dts configuration for JH7110
  error: patch failed: arch/riscv/boot/dts/starfive/jh7110.dtsi:629
  error: arch/riscv/boot/dts/starfive/jh7110.dtsi: patch does not apply
  Patch failed at 0009 riscv: dts: starfive: add PCIe dts configuration for JH7110

>   dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
>   dt-bindings: PCI: microchip: Remove the PLDA common properties
>   PCI: PLDA: Get PLDA common codes from Microchip PolarFire host
>   PCI: microchip: Move PCIe driver to PLDA directory
>   dt-bindings: PLDA: Add PLDA XpressRICH PCIe host controller
>   PCI: PLDA: Add host conroller platform driver

"controller"

>   dt-bindings: PCI: Add StarFive JH7110 PCIe controller
>   PCI: PLDA: starfive: Add JH7110 PCIe controller
>   riscv: dts: starfive: add PCIe dts configuration for JH7110

Use "PCI: plda: " prefix for PLDA things that are shared across
multiple drivers.

Use "PCI: starfive: " prefix for starfive-specific things.

This is the same as how drivers/pci/controller/dwc/* looks.

Bjorn
