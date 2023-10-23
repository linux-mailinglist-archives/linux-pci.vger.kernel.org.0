Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872397D36A1
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 14:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjJWMc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 08:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjJWMcZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 08:32:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDE4FD;
        Mon, 23 Oct 2023 05:32:22 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E3BC660576C;
        Mon, 23 Oct 2023 13:32:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698064341;
        bh=SIvq/58J/JQ/GQJV0oLXY3FnJr23e8bcn2ZfaD3CmaA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O7yHD1EX1vypBDQI/NxDiFvuZ4e0IVQY3xEquFeKZIGxgYF+uug0FBoTm+nSzJy2f
         FttANybDeMKWUPai5H0ahBwIMEbAHjFMuIR2wKeP/XA8qb4BmvFpRYp5O7j7LaDX0Q
         FS7DNx37piD6OYxtS74fNFjjHuBisD9GyL9m4g6Slm/5mt1Z8z/ZFnBWrTCGwhtF8G
         wCgc6GjrZoYnf/C9gChbxWqgZ/M2mZnIp89/cQ82NAcOUEeBgFVu8ROCMc3srcmTux
         2MAoIsFz1O29WtZryapS8eY7aNyO1yjYOdIcwitsx5l04GKD0xybdpduL2L/PsMwPK
         Bf869hp+djAbQ==
Message-ID: <304abe7d-ab05-4190-b6e5-563525cbb756@collabora.com>
Date:   Mon, 23 Oct 2023 14:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Fix translation window
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jieyy.yang@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        jian.yang@mediatek.com
References: <20231023081423.18559-1-jianjun.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231023081423.18559-1-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 23/10/23 10:14, Jianjun Wang ha scritto:
> The size of translation table should be a power of 2, using fls()
> cannot get the proper value when the size is not a power of 2. For
> example, fls(0x3e00000) - 1 = 25, hence the PCIe translation window
> size will be set to 0x2000000 instead of the expected size 0x3e00000.
> 
> Fix translation window by splitting the MMIO space to multiple tables if
> its size is not a power of 2.
> 
> Fixes: d3bf75b579b9 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192")
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


