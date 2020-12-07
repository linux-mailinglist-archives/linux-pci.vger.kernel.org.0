Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32CB2D1340
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 15:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgLGOME (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 09:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgLGOMD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 09:12:03 -0500
X-Gm-Message-State: AOAM533K7mylYjlKBJ002qI/Bh7S4yxf/mu6Mefukiv3mGvSLQm8stza
        2Bsqv87i27NBHDyqx61MnRNoZA5WZEGA0j+v0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607350283;
        bh=ExbBzZtI76UIjnZeTT9Tidvp9JWGG6DdN47dk5OWT64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HXUtVYWbEghrfqPpgZG0Y1ErflAbUdMPLlwaDgZKC3Xm/xJUURi+KUE5Ug3i94Jch
         hhMlMaTq5wwIA6QwbfvMIBe6UxG8trIqaG5bYvXmWJlsflDCKJ83tELbOicSQBWcHn
         H28CyhVnUM2yZX0lN3SUJyeifh7aDQ/MVafEXsI4kK2U6n4F/IA5v7WyLQwsbX5k1Y
         v61sVEEkiudPX1WHMM32iwGcchJ7QffcaMhKWKTIHEPQVvs7S5+uuajJaYw7sFZVUo
         3+sKPXEuQXAvd5FE5GaUcuQkvNA7CDQAUeLsRWdFS/n6hjIC8VFf4QWjQ5vWTU8jZC
         8prnuxMZh95GA==
X-Google-Smtp-Source: ABdhPJzi418/wAG1uSdNQ0XyK71kDVSHlT1jf4DMFycIClUbi/y6/taTpCkNTIVC8ZnZlVTR4UMz4o+PV3YFXeModGs=
X-Received: by 2002:a50:c091:: with SMTP id k17mr19981518edf.137.1607350280143;
 Mon, 07 Dec 2020 06:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20201118071724.4866-1-wens@kernel.org> <20201118071724.4866-2-wens@kernel.org>
In-Reply-To: <20201118071724.4866-2-wens@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 7 Dec 2020 08:11:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJphYYUsQR_kLH_y1gOArTifpEVUiTJfDpDsL8WjGxRfA@mail.gmail.com>
Message-ID: <CAL_JsqJphYYUsQR_kLH_y1gOArTifpEVUiTJfDpDsL8WjGxRfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: rockchip: Make 'ep-gpios' DT property optional
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 18, 2020 at 1:17 AM Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> The Rockchip PCIe controller DT binding clearly states that 'ep-gpios' is
> an optional property. And indeed there are boards that don't require it.
>
> Make the driver follow the binding by using devm_gpiod_get_optional()
> instead of devm_gpiod_get().
>
> Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
> Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
> Fixes: 964bac9455be ("PCI: rockchip: Split out rockchip_pcie_parse_dt() to parse DT")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v1:
>
>   - Rewrite subject to match existing convention and reference
>     'ep-gpios' DT property instead of the 'ep_gpio' field
> ---
>  drivers/pci/controller/pcie-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 904dec0d3a88..c95950e9004f 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -118,7 +118,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>         }
>
>         if (rockchip->is_rc) {
> -               rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
> +               rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep", GPIOD_OUT_HIGH);
>                 if (IS_ERR(rockchip->ep_gpio)) {
>                         dev_err(dev, "missing ep-gpios property in node\n");

You should drop the error message. What it says is now never the
reason for the error and it could most likely be a deferred probe
which you don't want an error message for.

>                         return PTR_ERR(rockchip->ep_gpio);
> --
> 2.29.1
>
