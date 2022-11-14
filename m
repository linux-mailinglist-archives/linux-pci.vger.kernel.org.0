Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C282627D06
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 12:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbiKNLwq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 06:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiKNLwb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 06:52:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85F125EA0;
        Mon, 14 Nov 2022 03:48:07 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F047E6600011;
        Mon, 14 Nov 2022 11:48:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668426486;
        bh=CHmX+6E1YAk8g2efLPnEDW2jq7aJvIc2qx7njCDWAbg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ISGB3QcOomoqudIj399nDcXxYTJ8DKeaCP+uhPUoY+cXM/lZHsNohKf77Awfzu2/a
         8Dt7/9iZb1tqOY+pxyRIq39mZUDMbAU8dNmuKhta45MgghP1E8ibH4LXEtkU0fb8UE
         fwKn4EIRcBASFfKcdWer7AsZxfmkRpcwi40coz/OljJEBrTh58MW/QAozAQmP6tiKo
         hs8VNCRc1tvNXD7nZtRRsc7GyjD5e7GCuDNkfWnNXm1aiAf+A8Z2gFFfw2MWHBxmui
         xraihfTDjrQVHR6jFRGL+iWmbvVyAAVQd2xHmlhSoBkOZwHGuw+Fhn5+dXGRnch2sm
         Hhpn0IA7LJMdw==
Message-ID: <afbf92c2-6237-f113-7942-7757be9773ba@collabora.com>
Date:   Mon, 14 Nov 2022 12:48:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 09/11] arm64: dts: mt7986: add pcie related device
 nodes
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, Ryder Lee <ryder.lee@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jieyy Yang <jieyy.yang@mediatek.com>,
        devicetree@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
References: <20221112091518.7846-1-linux@fw-web.de>
 <20221112091518.7846-10-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221112091518.7846-10-linux@fw-web.de>
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
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This patch adds PCIe support for MT7986.
> 
> Signed-off-by: Jieyy Yang <jieyy.yang@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

