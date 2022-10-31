Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214E76137CE
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 14:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiJaNXU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 09:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJaNXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 09:23:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73089658D;
        Mon, 31 Oct 2022 06:23:19 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D302660037C;
        Mon, 31 Oct 2022 13:23:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667222598;
        bh=ctOc72E5TG5g0Jfe6gFuy0T4ihRYDcFuhpGAII5uE5M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BAWpsTGOkdARYdWAUioC/8GohNdfgTZqbfoCUeTdPIdPgS/vDd+CtKLh5X2PPgmrf
         vHXRvOxj7l9b8CcZPGLj3BcXMEsbPT7+TpyBpQFJAoDHeQgxikCv9ewtWsYqLBGtDo
         kLR/QFbkpphY3ixfp0DAeeIom7DCV/wzDs+pc078Kq32W46QXCRgiaRDJWlPhwYFNq
         filMsDgk+XfCzEfz/dyy3MmUrohLNxIJ0zm5jZC1IT9k+ylBzOgon8ej+rw3rLikOA
         KZKPY3YMSoWOrkBg3WpKv+1ctBbb8iDYeVs3X0008NxXAjbBPRZ7bLYQryDn78ks1Z
         wtkxOoSnn5lhw==
Message-ID: <bd40a99a-63e3-b763-5c1a-74a42c384032@collabora.com>
Date:   Mon, 31 Oct 2022 14:23:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 3/3] arm64: dts: mt8195: Add venc node
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
References: <20221028094317.29270-1-tinghan.shen@mediatek.com>
 <20221028094317.29270-4-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221028094317.29270-4-tinghan.shen@mediatek.com>
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

Il 28/10/22 11:43, Tinghan Shen ha scritto:
> Add venc node for mt8195 SoC.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


