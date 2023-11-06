Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A957E1CBE
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 09:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjKFI46 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 03:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjKFI45 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 03:56:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A6FD47;
        Mon,  6 Nov 2023 00:56:54 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DBB4966022D2;
        Mon,  6 Nov 2023 08:56:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699261013;
        bh=2bQrh9kRjs2Bw4B8MQ78bYsQT4NqBoEiyodRc4PVONs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FDYtNNs62qygPiCN2rkjAxEyXDar+qBlAq8PklIeaawgbJuotagpZL9UXpi7hCk/e
         xwlzBeG7+F/E3dchu4toNfgHksxeSbMrIPsPB/pSCJOuOAQbsI1/yAS8f0wdgC+63U
         4wV3ZbKi2qGhaZx3Uo3Xg1QDx/Cf5+wTjRDCyFfqINMSz/+RShlOdmuKWgpJsNZtHU
         PGwa/j/350/shzhiFJd8f1QqYf2EbJVmIcUy410Q2QkGgOGPsK4n3HAaCiUOVe7r/W
         jSwZ+HBileEniXukCZPpfMxDlVwEisByngWE/dyPzQwCEfci9e5JuaIrSUdnpTNcEA
         2H3Y1Kc3Ue+fA==
Message-ID: <08afca95-9e64-4763-890c-809cd5575a06@collabora.com>
Date:   Mon, 6 Nov 2023 09:56:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: mediatek-gen3: Add power and reset control
 feature for downstream component
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jian Yang <jian.yang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chuanjia.Liu@mediatek.com, Jieyy.Yang@mediatek.com,
        Qizhong.Cheng@mediatek.com, Jianguo.Zhang@mediatek.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
References: <20231106061220.21485-1-jian.yang@mediatek.com>
 <20231106061220.21485-3-jian.yang@mediatek.com>
 <ce2c96f9-7895-41fc-a5f9-617b79f64f96@kernel.org>
 <74e491ce-24c6-4d7a-a1b3-708857f03887@collabora.com>
 <1b66b6bc-2a9a-4caa-b4f5-c88f098475e2@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1b66b6bc-2a9a-4caa-b4f5-c88f098475e2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 06/11/23 09:46, Krzysztof Kozlowski ha scritto:
> On 06/11/2023 09:36, AngeloGioacchino Del Regno wrote:
>> Il 06/11/23 08:53, Krzysztof Kozlowski ha scritto:
>>> On 06/11/2023 07:12, Jian Yang wrote:
>>>> From: "jian.yang" <jian.yang@mediatek.com>
>>>>
>>>> Make MediaTek's controller driver capable of controlling power
>>>> supplies and reset pin of a downstream component in power-on and
>>>> power-off process.
>>>>
>>>> Some downstream components (e.g., a WIFI chip) may need an extra
>>>> reset other than PERST# and their power supplies, depending on
>>>> the requirements of platform, may need to controlled by their
>>>> parent's driver. To meet the requirements described above, I add this
>>>> feature to MediaTek's PCIe controller driver as an optional feature.
>>>
>>> NAK, strong NAK. This should be done in a generic way because nothing
>>> here is specific to Mediatek.
>>>
>>> You just implement power sequencing of devices through quirks specific
>>> to one controller.
>>>
>>> Work with others to provide common solution.
>>> https://lpc.events/event/17/contributions/1507/
>>>
>>
>> I agree that working with everyone else by adding pwrseq is a must, but other
>> other PCIe controllers are doing the exact same as this patch: if the supply
>> and gpio names are aligned with the others, why shouldn't we let this in and
>> then convert this driver, along with the others, to the new pwrseq subsystem
>> when it's ready?
> 
> Because you already push to the PCI controller bindings new properties
> which are not properties of the PCI controller.
> 
>>
>> That, because I expect the pwrseq to require a bit more time before being
>> ready to get upstream.
>>
>> P.S.: Check Tegra, Broadcom, RockChip DW, IMX6Q-pcie.
> 
> Every new hack will not make it faster. :( At some point one have to say
> - enough of hacks, start doing it properly with upstream.
> 

Eh, that's a fair point. I can't really disagree with that.

Cheers,
Angelo


