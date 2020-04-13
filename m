Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393191A6D64
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 22:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbgDMUkU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 16:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388459AbgDMUkT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Apr 2020 16:40:19 -0400
Received: from localhost (mobile-166-175-184-103.mycingular.net [166.175.184.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3302A206DA;
        Mon, 13 Apr 2020 20:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586810418;
        bh=+desMrbn6DBSADncFMVbtCinH1NuMHe8VMUVzHzvUhg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K+grn0wCVAMaCZ+CKcYOlRgma0a2RE49ArPcgwQ3ERs11Osyj7aHbzEn7JOKuBcRq
         o5Vx2m/F0YPTaNIjFpaRWPOTA0llVBie8D0PD1cXgU60Q/WfKZzvnKSc+kt2Wimo2g
         h7G6p9oIW1qy9BqjiC6U8g6kFMjk6GG8HZ58dydY=
Date:   Mon, 13 Apr 2020 15:40:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     devicetree@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] devicetree: bindings: pci: document tx-deempth tx
 swing and rx-eq property
Message-ID: <20200413204013.GA147778@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410004738.19668-2-ansuelsmth@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks like "dt-bindings: PCI: " is the convention here.

  $ git log --oneline Documentation/devicetree/bindings/pci/
  11be8af70d86 dt-bindings: PCI: Convert PCIe Host/Endpoint in Cadence platform to DT schema
  69501078fc60 dt-bindings: PCI: cadence: Add PCIe RC/EP DT schema for Cadence PCIe
  847dbf4e1aba dt-bindings: PCI: Add PCI Endpoint Controller Schema
  f9f711efd441 arm64: tegra: Fix Tegra194 PCIe compatible string
  9f04d18b1edf dt-bindings: PCI: tegra: Add DT support for PCIe EP nodes in Tegra194
  6e5f77031cc9 dt-bindings: PCI: meson: Update PCIE bindings documentation
  3edeb49525bb dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4 controller
  34129bb831cc dt-bindings: PCI: intel: Fix dt_binding_check compilation failure

On Fri, Apr 10, 2020 at 02:47:35AM +0200, Ansuel Smith wrote:
> Document tx-deempth, tx swing and rx-eq property property used on some
> device (qcom ipq806x or imx6q) to tune and fix init error of the pci
> bridge.

s/tx-deempth/tx-deemph/ (in subject and commit log)
s/tx swing/tx-swing/ (both places also)
s/rx-eq/rx-equalization/ (ditto)
s/property property/properties/
s/pci/PCI/ in English text (not C variables, function names, etc).

If these are made generic, remove the "qcom ipq806x or imx6q" part.

> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 29bcbd88f457..df37486f1853 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -24,6 +24,24 @@ driver implementation may support the following properties:
>     unsupported link speed, for instance, trying to do training for
>     unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
>     for gen2, and '1' for gen1. Any other values are invalid.
> +- tx-deemph-gen1
> +   If present this property will tune the Transmit De-Emphasis level for GEN1 if
> +   supported by the driver.
> +- tx-deemph-gen2-3p5db
> +   If present this property will tune the Transmit De-Emphasis level for GEN2 in
> +   3.5db band if supported by the driver.
> +- tx-deempth-gen2-6db
> +   If present this property will tune the Transmit De-Emphasis level for GEN2 in
> +   6db band if supported by the driver.
> +- tx-swing-full
> +   If present this property will tune the Tx Swing Full value if supported by the
> +   driver.
> +- tx-swing-low
> +   If present this property will tune the Tx Swing Low value if supported by the

Wrap all of these to fit in 78 columns.  Some of them fit in 80
columns, which is sort of OK.  This one is 81, which is definitely too
long.

> +   driver.
> +- rx-equalization
> +   If present this property will tune the Rx equalization value if supported by
> +   the driver.
>  - reset-gpios:
>     If present this property specifies PERST# GPIO. Host drivers can parse the
>     GPIO and apply fundamental reset to endpoints.
> -- 
> 2.25.1
> 
