Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B3568140B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jan 2023 16:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbjA3PE5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 10:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbjA3PE4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 10:04:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18E81A96B;
        Mon, 30 Jan 2023 07:04:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EF3F6118A;
        Mon, 30 Jan 2023 15:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F64C433AE;
        Mon, 30 Jan 2023 15:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675091094;
        bh=NP5hS1dR9EZmj2uQzPc5GC8kAzVVdZAEiPRJ9S3ogeI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JfkSBEiDdHCwrsfpP1o2ASLyl1gWXHuRLeuSIvE9vW44hD9mhkvwoROQD8QIrcP9+
         kfiUaMTjYKtpddyFZN8rH6G9MqO7wZz+ISPYrrD4YRTfIPovQZiXJtGC6XfOudB6RT
         ZA3O9mb9VjUFkTDHsOMNoJK83ukgTyNQwOz4IfYQtxqkLVnz5nhg7EG6CeUofwyhgV
         FqaLYi+mLu6CnaOZLUOyHh2sRF+RkeCmeFBpWdKB2/wIqv5P/TxfJYX3IgJqCIekbm
         dyaxlVSrZf+K1XGw3c+JGDbsDFjMMVcmzFy017yUOq/XW5mCkB9znE3yBAo+sjXFrU
         D3/LIj1ZMEcOw==
Received: by mail-vs1-f48.google.com with SMTP id 187so12723596vsv.10;
        Mon, 30 Jan 2023 07:04:54 -0800 (PST)
X-Gm-Message-State: AO0yUKVMZJrUShspaFsw5UnMpJonkhXkIBmGZzzh3ocslQLUJRW0Mpn6
        CtjjJi30mUIs5Q7NSOPwKT6kHRqSm9JOLJnS6w==
X-Google-Smtp-Source: AK7set+hZraBztww+lgC8qx204C8V9L5htt85m/SDlWTCczhWl723RbgSQuPGeGVqFZxYylGIiZSxrnXAgLr+5AEgsw=
X-Received: by 2002:a67:fe41:0:b0:3ea:c8c:48a5 with SMTP id
 m1-20020a67fe41000000b003ea0c8c48a5mr2455575vsr.53.1675091093363; Mon, 30 Jan
 2023 07:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20230126135049.708524-1-rick.wertenbroek@gmail.com> <20230126135049.708524-6-rick.wertenbroek@gmail.com>
In-Reply-To: <20230126135049.708524-6-rick.wertenbroek@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Jan 2023 09:04:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJSZ7v-YSOyUu2zJ0Yu2pU+qm=hRtoyQpdmQdhs1tirDg@mail.gmail.com>
Message-ID: <CAL_JsqJSZ7v-YSOyUu2zJ0Yu2pU+qm=hRtoyQpdmQdhs1tirDg@mail.gmail.com>
Subject: Re: [PATCH 5/8] PCI: rockchip: Added dtsi entry for PCIe endpoint controller
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        wenrui.li@rock-chips.com, rick.wertenbroek@heig-vd.ch,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 26, 2023 at 7:52 AM Rick Wertenbroek
<rick.wertenbroek@gmail.com> wrote:
>
> Added missing PCIe endpoint controller entry in the device tree. This
> entry is documented in :
> Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
> The status is disabled by default, so it will not be loaded unless
> explicitly chosen to.
>
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 25 ++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 9d5b0e8c9..5f7251118 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -265,6 +265,31 @@ pcie0_intc: interrupt-controller {
>                 };
>         };
>
> +       pcie0_ep: pcie-ep@f8000000 {
> +               compatible = "rockchip,rk3399-pcie-ep";
> +               #address-cells = <3>;
> +               #size-cells = <2>;

These are only needed when you have child nodes. Additionally, it
would not be a PCI bus which is the only case that has 3 address
cells.

There's a schema for this in linux-next now. Please test this change
with that. It should point out the above issue and maybe others.

> +               rockchip,max-outbound-regions = <32>;
> +               clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
> +                       <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
> +               clock-names = "aclk", "aclk-perf",
> +                               "hclk", "pm";
> +               max-functions = /bits/ 8 <8>;
> +               num-lanes = <4>;
> +               reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0xfa000000 0x0 0x2000000>;
> +               reg-names = "apb-base", "mem-base";
> +               resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
> +                       <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE> ,
> +                       <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
> +               reset-names = "core", "mgmt", "mgmt-sticky", "pipe",
> +                               "pm", "pclk", "aclk";
> +               phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
> +               phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pcie_clkreqnb_cpm>;
> +               status = "disabled";
> +       };
> +
>         gmac: ethernet@fe300000 {
>                 compatible = "rockchip,rk3399-gmac";
>                 reg = <0x0 0xfe300000 0x0 0x10000>;
> --
> 2.25.1
>
