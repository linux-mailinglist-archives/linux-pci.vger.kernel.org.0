Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856017BF7BE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 11:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjJJJqC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 05:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjJJJqB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 05:46:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F694;
        Tue, 10 Oct 2023 02:46:00 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 648956607243;
        Tue, 10 Oct 2023 10:45:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696931159;
        bh=6H9Fj2tHWKm+K4ZGzGla2mVcICa34lDD8nktakutjLo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BOV1amVx1RHjJcfG/Juc7idTOADT5dPAhDeFPXtCHpZEG8Hikn6RKf4HB2LHgMEsK
         2KAASVv/MZIKZV2hqNAQZftl+QQbgLJm6Qu0Xd3IFngyIS45lZ4e820Lfv4cvrTQVd
         5gDF60go4lFLlGcBBXM8hwd1eHZzUpOYpIeRtmIV/ZjZh7h1cCsmvvk+3/mk9OCQdx
         QMOrwfMs8fYy/xlxVxnuZC7fgfLpuiCmGHQthYja4UUFiUZkx/kCVqDrixf6ifSgXB
         myjaI7Xog2MF1g0M4uJwdi09kmwsr8FfXemLQ2KriBgBIzKq0dcS3Rq38evxPFbm4z
         GwF5ozFb0IUMQ==
Message-ID: <50bb99ee-8ef3-343e-7359-526662f511cb@collabora.com>
Date:   Tue, 10 Oct 2023 11:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 controlling power and reset
Content-Language: en-US
To:     Jian Yang <jian.yang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chuanjia.Liu@mediatek.com, Jieyy.Yang@mediatek.com,
        Qizhong.Cheng@mediatek.com
References: <20231009084957.18536-1-jian.yang@mediatek.com>
 <20231009084957.18536-2-jian.yang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231009084957.18536-2-jian.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 09/10/23 10:49, Jian Yang ha scritto:
> From: "jian.yang" <jian.yang@mediatek.com>
> 
> Add new properties to support control power supplies and reset pin of
> a downstream component.
> 
> Signed-off-by: jian.yang <jian.yang@mediatek.com>
> ---
>   .../bindings/pci/mediatek-pcie-gen3.yaml      | 30 +++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 7e8c7a2a5f9b..eb4ad98549d1 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -84,6 +84,26 @@ properties:
>       items:
>         enum: [ phy, mac ]
>   
> +  pcie1v8-supply:

There are another two controllers having such regulators and they all have the
same name for those supplies; Can you please change the names to be consistent
with the other controllers?

vpcie1v8
vpcie3v3
vpcie12v

Regards,
Angelo


