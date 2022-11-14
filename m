Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A69627D14
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 12:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbiKNLzp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 06:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbiKNLz3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 06:55:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24670286CB;
        Mon, 14 Nov 2022 03:50:57 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C52B66016A3;
        Mon, 14 Nov 2022 11:50:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668426644;
        bh=rSfdqTdE8g5pVk/aI7ZmXOStoeYghRLVH9p0R1kbpRA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Oe9YtSXjQQZ85Odb4k7Zlo2gY1T6Pw6uTs4XnOSaGwOtBwjrlL/shpUE+8AwAPDyu
         BPT/+46VoUrSr7eQL6KX/zgvZEU5PuxB23s7JdhVAHS7StyypCG7x1pXa7WTjmiPhQ
         +BgeRFiCq+M0R00ir4qJZMiiiv/d/M+7YPeeAApO5qGZglKpxqqRLoDCHyu7O3BjNO
         zFEBTURCKFB+YlltZtZRry22VE5EupoBc/m+kY75QGTFNzpTlkXCVDKKPKFJY9oM27
         eSL8ajonPwMRxDNz3LRlmonlq1rQnJ1rEHfV20GUujukIJZCKZfzvtLrjubpgOICyg
         2+2xmua4gbetw==
Message-ID: <ee410f80-1697-6146-9755-981f2d45e88f@collabora.com>
Date:   Mon, 14 Nov 2022 12:50:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 10/11] arm64: dts: mt7986: add Bananapi R3
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20221112091518.7846-1-linux@fw-web.de>
 <20221112091518.7846-11-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221112091518.7846-11-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 12/11/22 10:15, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add support for Bananapi R3 SBC.
> 
> - SD/eMMC support (switching first 4 bits of data-bus with sw6/D)
> - all rj45 ports and both SFP working (eth1/lan4)
> - all USB-Ports + SIM-Slot tested
> - i2c and all uarts tested
> - wifi tested (with eeprom calibration data)
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

..snip..

> +
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
> new file mode 100644
> index 000000000000..def16e36f1e6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
> @@ -0,0 +1,458 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Authors: Sam.Shih <sam.shih@mediatek.com>
> + *          Frank Wunderlich <frank-w@public-files.de>
> + *          Daniel Golle <daniel@makrotopia.org>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/mt65xx.h>
> +
> +#include "mt7986a.dtsi"
> +
> +/ {
> +	model = "Bananapi BPI-R3";
> +	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";

You have to add the machine compatible to devicetree/bindings/arm/mediatek.yaml
or you get dtb check issues.

Regards,
Angelo

