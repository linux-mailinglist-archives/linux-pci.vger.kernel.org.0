Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E2D650819
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 08:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiLSHg1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 02:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiLSHgZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 02:36:25 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928CAA44B;
        Sun, 18 Dec 2022 23:36:23 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 500E984D70;
        Mon, 19 Dec 2022 08:36:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671435381;
        bh=Voeiz7V8OcQZJcxdSJRCFvpWv4YiQpVgYELZEftdCQ0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DHKKgkZPBX7pGz14kASI7flYNmgKOEQPiF2gBYirqQjSc1xUFQbrW6Sr5GzrT5lw4
         fUuvphceSZl4H39r0tyY7x6Sbi4TXRtnZc0keD7PUyLWNsDnSsZLuLHrALXo+1wy2I
         FQqCbATTkdS3lzLn8Q7RuN6/sGH8pNzCo2s4owIcH2DT+/45PDCRO7B2zJS3rWfVDb
         n1OByfkskDQoMWBJxegeIk3300MCn1QaG1tE27EYylJ7zOM0gBxDO13fI48eTsd21W
         cEZh7mjbP2cRJiSa1JuhXCoqbAAJekczXMcoCobpCUNU4FTrZL8SBYx0oPiQWai7ii
         9+3Cgc25w/SuQ==
Message-ID: <c677ece5-1f84-7f37-ea80-12f19fa6e222@denx.de>
Date:   Mon, 19 Dec 2022 08:36:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] phy: freescale: imx8m-pcie: Add one missing error return
Content-Language: en-US
To:     Richard Zhu <hongxing.zhu@nxp.com>, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, lorenzo.pieralisi@arm.com
Cc:     linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
References: <1671433941-2037-1-git-send-email-hongxing.zhu@nxp.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <1671433941-2037-1-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/19/22 08:12, Richard Zhu wrote:
> There should be one error return when fail to fetch the perst reset.
> Add the missing error return.
> 
> Fixes: dce9edff16ee ("phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY support")
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Marek Vasut <marex@denx.de>

> ---
>   drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> index 7585e8080b77..afc63552ecaf 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -255,7 +255,7 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
>   		imx8_phy->perst =
>   			devm_reset_control_get_exclusive(dev, "perst");
>   		if (IS_ERR(imx8_phy->perst))
> -			dev_err_probe(dev, PTR_ERR(imx8_phy->perst),
> +			return dev_err_probe(dev, PTR_ERR(imx8_phy->perst),
>   				      "Failed to get PCIE PHY PERST control\n");
>   	}

Thanks !
