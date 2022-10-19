Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE11604718
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 15:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJSN3l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 09:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiJSN3H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 09:29:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E43B9AC28;
        Wed, 19 Oct 2022 06:16:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 37E5C66023AA;
        Wed, 19 Oct 2022 09:51:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666169469;
        bh=JRrtscYJcgnvP6zoQUoIszeWzHvqEHR17uOuuaKa6uA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MfG6R1OFvTDzIsvmQwazrsJnhSLRTyrtSrgynYi08JlaDlOxOKCPip8RY8pvSiRgN
         KHb2pqiMn8wrmvIEDU4mM/ucE8/nyn+dbJgdN0muZb0dQ9rgRNqt+jaWTa3riM+zYc
         wDPK6pXdn/LhiAnQa1pF37+eoFm26xSj+Skk3fR4nVOhtpBldwVO0A3+5i+hhu717Q
         jj+iXCHioBkax2EtGx12ed0P2XL9JPxMT9+fiu5dPi0El57ERZ/oxru4OxfRB5GGye
         pf9NGLGTrQ2mEC4wZ3z+qtqmv8BIXMwAtSdLEcv3RrzeHiDI4J0ogl2iIy3WR+CEkN
         xyzf96mibVOwg==
Message-ID: <01ef8a2d-091f-5428-2cb8-41ba3e137a06@collabora.com>
Date:   Wed, 19 Oct 2022 10:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v1 3/3] arm64: dts: mt8195: Add venc node
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Irui Wang <irui.wang@mediatek.com>
References: <20221017070858.13902-1-tinghan.shen@mediatek.com>
 <20221017070858.13902-4-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221017070858.13902-4-tinghan.shen@mediatek.com>
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

Il 17/10/22 09:08, Tinghan Shen ha scritto:
> Add venc node for mt8195 SoC.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 903e92d6156f..7cf2f7ef4ec6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -2163,6 +2163,30 @@
>   			power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
>   		};
>   
> +		venc: venc@1a020000 {

As Krzysztof also said, this is video-codec@1a020000.

Also, there's one more thing... MT8195 has two video encoder cores, but this
node is only for the first one. There's a second instance at 0x1b020000: please
add it.

Regards,
Angelo

