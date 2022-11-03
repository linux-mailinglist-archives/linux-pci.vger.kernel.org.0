Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED99617F6B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 15:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiKCOZd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 10:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiKCOZb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 10:25:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C554A26DC;
        Thu,  3 Nov 2022 07:25:30 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE7B0660294D;
        Thu,  3 Nov 2022 14:25:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667485529;
        bh=V/lrvTevc4IJp5UcDZQsx+cZatS/QHb6/HH934WSbtk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=apgnt2Fj0WevICWRfwwwzURMMEeLtibvGDP8URTDqPQCrugbAIbO9d37xWbX8fZ5p
         82lWXBTUeNjSh2tH98SL1LZPV3g2jBfZn75Flue4TIOBuQbOEzad/EZPP+VIDx+OYw
         SVbm7CVhdzN4rthu2L0kqH1okwLPCJRivCBCBGuWzIv+1eTCh1mlbvtCtWvQKbfXfU
         ipJriuk+lmQcpZC/4AH50W0xvvowSXsDlzzur8NSZx0pkRHkH/t6Rmc5biB53WgZvA
         FpBmLz5kWv3frBmlMqopUpPPlHL71WapWpLyT174RVHmYN3Vs+pkwATSEHcwBRilSR
         G4dYzUCbKhv9A==
Message-ID: <357eb6c1-b8ec-34eb-5333-3a98cc5d6841@collabora.com>
Date:   Thu, 3 Nov 2022 15:25:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 1/3] dt-bindings: PCI: mediatek-gen3: Support mt8195
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
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221103025656.8714-1-tinghan.shen@mediatek.com>
 <20221103025656.8714-2-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221103025656.8714-2-tinghan.shen@mediatek.com>
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

Il 03/11/22 03:56, Tinghan Shen ha scritto:
> From: Jianjun Wang <jianjun.wang@mediatek.com>
> 
> In order to support mt8195 pcie node, update the yaml to support new
> properties of iommu and power-domain, and update the reset-names
> property to allow only one 'mac' name.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Signed-off-by: TingHan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


