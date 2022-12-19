Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54831650769
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 07:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiLSGD6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 01:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiLSGD5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 01:03:57 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFB09599;
        Sun, 18 Dec 2022 22:03:53 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B3A6F84913;
        Mon, 19 Dec 2022 07:03:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671429830;
        bh=MkvKsVKAty0HJJf2smTx3uSxYSAK5yNNC63zTBdQT1U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UeKVGrRpVuh9Bsjos7+aMvvA9TjjRs6jSWpD8YO/fuEZEb0J0dM7HrbnKZVulP9Ia
         E6Kt4zHYTnUuSWsDPAa2SMT/cayugvpTATPGwSJ+AEwBbGuDkRMHPuvMBb4d88RxXU
         SjOsPpMWGovmXdITpMTf1WwY6Y5Wf2LAlAsKLR0kOe6iE4p+jeh43UekIO+MNAsL6C
         kDPfYdMmIj00NQbSStbGap5ZRJ32Yb264KDxLkoB8dqKVSlG3cs+HQigAWbJqjafjG
         bbniULICx4ksX1AF6KHNdiiOkEXOvMAmFcBC3n1gOU1NsVVr0e/0J4H29VK0peI37y
         pNOipD2Yb0KrA==
Message-ID: <77487520-3812-0a9f-54e6-e9cb7feb6e51@denx.de>
Date:   Mon, 19 Dec 2022 07:03:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RESEND v12 4/4] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY
 support
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
Cc:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1665625622-20551-1-git-send-email-hongxing.zhu@nxp.com>
 <1665625622-20551-5-git-send-email-hongxing.zhu@nxp.com>
 <c21996f3-0f1d-8b77-95fb-ab98f3a28913@denx.de>
 <AS8PR04MB86767EFD1DE8CC1FBA574D708CE59@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <AS8PR04MB86767EFD1DE8CC1FBA574D708CE59@AS8PR04MB8676.eurprd04.prod.outlook.com>
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

On 12/19/22 04:25, Hongxing Zhu wrote:

Hi,

>>> @@ -238,6 +251,14 @@ static int imx8_pcie_phy_probe(struct
>> platform_device *pdev)
>>>    		return PTR_ERR(imx8_phy->reset);
>>>    	}
>>>
>>> +	if (imx8_phy->drvdata->variant == IMX8MP) {
>>> +		imx8_phy->perst =
>>> +			devm_reset_control_get_exclusive(dev, "perst");
>>> +		if (IS_ERR(imx8_phy->perst))
>>> +			dev_err_probe(dev, PTR_ERR(imx8_phy->perst),
>>
>> I just notice this , are we missing return here ?
>>
>> That is ... return dev_err_probe(...) ?
> 
> Ooh, it's my fault. Thanks for your reminder.
> One return should be here.
> -                       dev_err_probe(dev, PTR_ERR(imx8_phy->perst),
> +                       return dev_err_probe(dev, PTR_ERR(imx8_phy->perst),
> Hi Vinod @vkoul@kernel.org:
> Should I re-summit one fix patch?

I think just send a follow up patch with Fixes: tag .
