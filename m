Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BD6627D64
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 13:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiKNMKZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 07:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbiKNMKY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 07:10:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E58FE6;
        Mon, 14 Nov 2022 04:10:21 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 49C74660231C;
        Mon, 14 Nov 2022 12:10:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668427820;
        bh=dx8y/g3WohBsZ27OyP/AIlNklm8U3hPwF4o+Z1udj+w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SPQSPsXQeim5Y+H7GKLFPg1VcJM12PHQ1BjIEK2Orot+ACy1o7770oH1MTEZSjKi2
         OWiwwd7I2CKwIYBWTACopUjBDtj5F/Sq93OyjHKTexT2kj7Y0w8vZvLkqXNDi/39f0
         QZInlaHGvJRQHlSUD3gi+8eRwXuf8p6WlZ/OhpWIwyXyCqrYqZdWPYeq2TZDSjI2wX
         Z+Q5gLZWeRud6JugoP+kPQP0XbuYARgS11EEqm6PY1NnfFLcKld3l/iJjTHDdBtcag
         iCriPiysO3ZxCiV0FzsMlQR89yKZrqOtGu3rQnO8HeZe6rnCKvjzLI9EGzL0O5FKfg
         QEqEVMizPky7g==
Message-ID: <288b510c-1ff3-ddad-1e80-dfe3de4b2a84@collabora.com>
Date:   Mon, 14 Nov 2022 13:10:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 10/11] arm64: dts: mt7986: add Bananapi R3
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
 <ee410f80-1697-6146-9755-981f2d45e88f@collabora.com>
 <A22EB676-EBD4-4E07-8E8F-BC200EDBCE1A@fw-web.de>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <A22EB676-EBD4-4E07-8E8F-BC200EDBCE1A@fw-web.de>
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

Il 14/11/22 13:03, Frank Wunderlich ha scritto:
> Am 14. November 2022 12:50:40 MEZ schrieb AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>:
>> Il 12/11/22 10:15, Frank Wunderlich ha scritto:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> +/ {
>>> +	model = "Bananapi BPI-R3";
>>> +	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
>>
>> You have to add the machine compatible to devicetree/bindings/arm/mediatek.yaml
>> or you get dtb check issues.
> 
> Have already:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v6.1-next/dts64&id=8c80453864efea0a0ed5ca2b399fd97f2f55a5ae
> 

Sorry, had missed that one.

In this case:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

