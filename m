Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13305627CF0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 12:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbiKNLtj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 06:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbiKNLtP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 06:49:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D989B22B2F;
        Mon, 14 Nov 2022 03:46:05 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CC8616600011;
        Mon, 14 Nov 2022 11:46:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668426364;
        bh=F2l6U4uf//w7B2yS+MtWfroeTG0Cin/kPVpU6uxZt6A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=krvOS72U2oAWFGSfKWcBU6ylgO61m+ZruQZzrgqkSC1XLfIjsLchoDO+cAzGb0Hss
         BnOYWJGKtT6ZvV8CKxwcvU+zGMZtMOm90pGOFTfRWZvu7Gf1+x3EuCsBy5os8mOWuu
         p5d0CZTqLo/H3v/2RQXxT6QNBGN5vPm+diS/+6dDu5NMgGEJq8FWgo53KJmvhdlCaG
         jERUkOr2NY247/zTjOuTCrEoAbRWX1Nee78KaD6TlY8GBrNo958jpxJoAfpSIFYddJ
         6lDs6zdTmw31Xu3gevkdO1X0bkI+4kpNMA3snd1Km1e77yd2DgUiTZwHrs/dBzpjiM
         CZ6nuGSWxgZzw==
Message-ID: <c4a12e79-5f4e-8a47-0894-dac4cea0fd4c@collabora.com>
Date:   Mon, 14 Nov 2022 12:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 04/11] dt-bindings: PCI: mediatek-gen3: add SoC based
 clock config
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
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20221112091518.7846-1-linux@fw-web.de>
 <20221112091518.7846-5-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221112091518.7846-5-linux@fw-web.de>
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
> The PCIe driver covers different SOC which needing different clock
> configs. Define them based on compatible.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Jianjun Wang <jianjun.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


