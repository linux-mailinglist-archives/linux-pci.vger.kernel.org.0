Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF17751BA56
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 10:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbiEEIb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 04:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347885AbiEEIbW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 04:31:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540622D1EB;
        Thu,  5 May 2022 01:27:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 72C5A1F44D84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651739262;
        bh=mFMc9Q2nDIQR0sOpjH1myPXm3e8CImboII/qXcWq5JU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GMIp6mRlSS7KAQ8A9IVcFvFyA43EZx2MPS9THZM+iZp6wpQiki8+SaO1lrUujJzUm
         XFpVDRI7ZuxDVrblKkw9SzZ95TX7oitciWHideclbO2hu+2iPvKcv4hMOcQH9b2N+J
         d6erKHQJefc2MvAkjyyOIFrIuQ30TUY/10s7wUGPryG3A/8KmfGrgsWSHgsPLvv7Oe
         O1OQPK0t5Hv36s59X6fG1lbTmXe6VwCjL6iOiRFw/1+xhqqtegNSkEstE71eZCJBLK
         xv8Lx4XPlRt3ycvFmuvQ0IYO+VFDxQn4fDCysKSIwFF/UTu5OCkPMJDmA+PG/K3Ub1
         gn/ZBPqYeHCtQ==
Message-ID: <2d50b30d-ed3a-29db-266e-9e395e9e4c6a@collabora.com>
Date:   Thu, 5 May 2022 10:27:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Change driver name to
 mtk-pcie-gen3
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220504172128.27489-1-nbd@nbd.name>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220504172128.27489-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 04/05/22 19:21, Felix Fietkau ha scritto:
> driver_register() will refuse to register another driver with the same name.
> This change allows pcie-mediatek-gen3 to coexist with pcie-mediatek built into
> the kernel.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 3e8d70bfabc6..2e665cd7e735 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -1021,7 +1021,7 @@ static struct platform_driver mtk_pcie_driver = {
>   	.probe = mtk_pcie_probe,
>   	.remove = mtk_pcie_remove,
>   	.driver = {
> -		.name = "mtk-pcie",
> +		.name = "mtk-pcie-gen3",
>   		.of_match_table = mtk_pcie_of_match,
>   		.pm = &mtk_pcie_pm_ops,
>   	},
> 

Hello Felix,

this is a good fix - and being it a fix, this requires a Fixes: tag - which also
gets this scheduled for backporting, which is important to solve this issue on
all of the affected kernels.

I'll make it easy for you as I've already checked the commit hash:

Fixes: d3bf75b579b9 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192")


After adding that:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo
