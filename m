Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA56A51FC82
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 14:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiEIMWm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 08:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiEIMWk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 08:22:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E57193223;
        Mon,  9 May 2022 05:18:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1F08E1F43BA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652098717;
        bh=/ElfDQ7Z0+LPIiP82VOSR/z6/oF6F1kOGCw4zRzqtM0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SFNDAWZ+B9j/a0+7UlWwDPvBoOHehJzS5iBQT9zXO/qZkN3if5DX5LWbW2aFUP5vQ
         UcwkEtUhhnJTuuOXAHUCQdF1D8NBNFVLuBHz+xv2PpuOdxhRV38LsVehwOT8P2YEOR
         2jd9vsL03Pc5W0D/lKKlY3CeNu80kOd+9kJZ1hxq0xEr3g3cxZ1lDOB5SxY3WiQc42
         uhoq5OdtWrv6zvXO3G0M25Qk2DG/TcJodNMPDvUKPRSf8Rg2OAmQ4Pbs6IAEkwMbcO
         g4vghNiQAExBdJUJGc4Ci4AYscSw0+Cps3vuO50jOxVQKb78S1jAAuKlMKuJiRadOb
         rLNLAKw/Bmo8w==
Message-ID: <e9839acf-e334-d73d-a0b3-57d951fb8796@collabora.com>
Date:   Mon, 9 May 2022 14:18:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] PCI: mediatek-gen3: Assert resets to ensure expected init
 state
Content-Language: en-US
To:     ryder.lee@mediatek.com
Cc:     jianjun.wang@mediatek.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, nfraprado@collabora.com
References: <20220404144858.92390-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220404144858.92390-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 04/04/22 16:48, AngeloGioacchino Del Regno ha scritto:
> The controller may have been left out of reset by the bootloader,
> in which case, before the powerup sequence, the controller will be
> found preconfigured with values that were set before booting the
> kernel: this produces a controller failure, with the result of
> a failure during the mtk_pcie_startup_port() sequence as the PCIe
> link never gets up.
> 
> To ensure that we get a clean start in an expected state, assert
> both the PHY and MAC resets before executing the controller
> power-up sequence.
> 
> Fixes: d3bf75b579b9 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Friendly ping for an important fix :-)

Regards,
Angelo

> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index f7048ea4c020..dccdfce12b1c 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -838,6 +838,14 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>   	if (err)
>   		return err;
>   
> +	/*
> +	 * The controller may have been left out of reset by the bootloader
> +	 * so make sure that we get a clean start by asserting resets here.
> +	 */
> +	reset_control_assert(pcie->phy_reset);
> +	reset_control_assert(pcie->mac_reset);
> +	usleep_range(10, 20);
> +
>   	/* Don't touch the hardware registers before power up */
>   	err = mtk_pcie_power_up(pcie);
>   	if (err)


