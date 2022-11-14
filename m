Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472F9627CFB
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 12:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbiKNLuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 06:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiKNLtj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 06:49:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC002793E;
        Mon, 14 Nov 2022 03:46:14 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A56B8660231A;
        Mon, 14 Nov 2022 11:46:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668426372;
        bh=cxFh7qe3DRbfD8h/14NTncqtRXbLZFLZJv4ihDVzbSM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CU+lQGStnui0/5eva3vNQRx111R67wmazQ03e6Q+2+xgR9xRTtOqq1dYYMiLVCH+o
         ZeSgxBg243ZHITubQq3NuuJnw06pq9z3jFVOq35LhRK2+hWYGZlyoRowiB470EZ+or
         TwQ0vnM+7pW6Jrd4OLgjcUsE6nBHMty5d2lk5kINmtl+XseY7nugUn9LeFuVvSc8u1
         8fgMEFQdIopfFzOyFBb+KmFCjwOabiQhN0ie6LFDuluML5CcdD2MalUMPut58R/6Yv
         d5Y35/9JmaoJkwqJfOAFd7aNQCiBqXBj0hKfdbemKHUHZNZH1TDGBymyJOzI7wsjpw
         lOh9OAQis6dQQ==
Message-ID: <16de98da-4042-457c-9430-a0b17ec83d1c@collabora.com>
Date:   Mon, 14 Nov 2022 12:46:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 01/11] arm64: dts: mt7986: move wed_pcie node
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
 <20221112091518.7846-2-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221112091518.7846-2-linux@fw-web.de>
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
> Move the wed_pcie node to have node aligned by address.
> 
> Fixes: 00b9903996b3 ("arm64: dts: mediatek: mt7986: add support for Wireless Ethernet Dispatch")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


