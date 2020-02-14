Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67B4115D497
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2020 10:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgBNJU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Feb 2020 04:20:29 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53170 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbgBNJU2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Feb 2020 04:20:28 -0500
Received: from p5b127dd9.dip0.t-ipconnect.de ([91.18.125.217] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j2X8x-0000h0-3A; Fri, 14 Feb 2020 10:20:15 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, William Wu <william.wu@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/6] dt-bindings: add binding for Rockchip combo phy using an Innosilicon IP
Date:   Fri, 14 Feb 2020 10:20:14 +0100
Message-ID: <17396429.PKOFnNSWWW@phil>
In-Reply-To: <1581574091-240890-2-git-send-email-shawn.lin@rock-chips.com>
References: <1581574091-240890-1-git-send-email-shawn.lin@rock-chips.com> <1581574091-240890-2-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shawn,

Am Donnerstag, 13. Februar 2020, 07:08:06 CET schrieb Shawn Lin:
> This IP could supports USB3.0 and PCIe.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - fix yaml format
> 
>  .../bindings/phy/rockchip,inno-combophy.yaml       | 80 ++++++++++++++++++++++

can we make this rockchip,inno-usb3pciephy or something similar please?
Same for the driver name.

-combophy is completely non-descriptive and looking at the Rockchip
vendor-tree we already have:

- phy-rockchip-inno-combphy.c (this one)
- phy-rockchip-inno-mipi-dphy.c (rk1808 dsi, but should actually fit into combo)
- phy-rockchip-inno-video-combo-phy.c (dsi/lvds/ttl)
- phy-rockchip-inno-video-phy.c (rk3288-lvds)

All of them have quite none-descriptive names

The inno-video-combo-phy already got a somewhat nicer name in
mainline (dsidphy), so I think it would be cool to also do this here
(and for the driver of course).


> +  reset-names:
> +    items:
> +      - const: otg-rst
> +      - const: combphy-por
> +      - const: combphy-apb
> +      - const: combphy-pipe

reset-names are local to the node, so there is no need
for combophy prefixes, so these should probably be:

      - const: otg-rst
      - const: por
      - const: apb
      - const: pipe


> +
> +  rockchip,combphygrf:
> +    enum:
> +      - rockchip,combphygrf

nicer name here? :-)


Thanks
Heiko


