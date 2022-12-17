Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C706064FC26
	for <lists+linux-pci@lfdr.de>; Sat, 17 Dec 2022 20:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLQTqy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Dec 2022 14:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiLQTqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Dec 2022 14:46:39 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B23B7EC;
        Sat, 17 Dec 2022 11:46:35 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5E7AD85237;
        Sat, 17 Dec 2022 20:46:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671306393;
        bh=mx0kQyWotAfcs5S7Beuc2iw0C+M4q+8c4LB5R6a+j0s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hYQN5auMc3/MoiYggnmoLVJNSVlZIsxDVSJutAxh1v0NMEGqG7/NlYrA6T5P2pp2l
         q0VX0hQvXSdJsOiR0DayhpIQhMxZtGou9hI2kuPFmZ/qf9pk9xiKSDAaDM8n7jqO95
         mKHSyBTTu/3N9v6Vm51iW0KyN1s6NTBlQjr665fkstxVWwgElv/9Y5b8/Lv8ewbbIN
         zwLy/H287WStOWEbxQ9pzBuyRnso4xhoPhTkHM0qPN10wiw330Ft2PQAU/FgvvDhUH
         nX7aWkPvlNzVI5/eC1XXVivmqkQNhmGD8vsUipW3Za8frOHLjSo3gU8I+Nk1LpM+O2
         V52PBqad9viGg==
Message-ID: <c21996f3-0f1d-8b77-95fb-ab98f3a28913@denx.de>
Date:   Sat, 17 Dec 2022 20:46:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RESEND v12 4/4] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY
 support
To:     Richard Zhu <hongxing.zhu@nxp.com>, vkoul@kernel.org,
        a.fatoum@pengutronix.de, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, shawnguo@kernel.org,
        alexander.stein@ew.tq-group.com, richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
References: <1665625622-20551-1-git-send-email-hongxing.zhu@nxp.com>
 <1665625622-20551-5-git-send-email-hongxing.zhu@nxp.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <1665625622-20551-5-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/13/22 03:47, Richard Zhu wrote:

Hi,

[...]

> @@ -238,6 +251,14 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
>   		return PTR_ERR(imx8_phy->reset);
>   	}
>   
> +	if (imx8_phy->drvdata->variant == IMX8MP) {
> +		imx8_phy->perst =
> +			devm_reset_control_get_exclusive(dev, "perst");
> +		if (IS_ERR(imx8_phy->perst))
> +			dev_err_probe(dev, PTR_ERR(imx8_phy->perst),

I just notice this , are we missing return here ?

That is ... return dev_err_probe(...) ?

> +				      "Failed to get PCIE PHY PERST control\n");
> +	}

[...]
