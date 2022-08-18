Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67712598271
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 13:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244132AbiHRLtm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 07:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbiHRLtl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 07:49:41 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767FF7696A;
        Thu, 18 Aug 2022 04:49:38 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 201D684AD1;
        Thu, 18 Aug 2022 13:49:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1660823376;
        bh=WQ7yFrQ43wD2Xkn26HybdsHzAjFarYakjSFUugC018Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vZDJ1fJAUFbWwzww70/2p9YtQEUDjkybt/5NKA8MGGL0xZ1DXdx8R/OwD/6avok0D
         HSNAacSM4iumUbfKWf7LQuGe5eRkuxTCRRzXBm0HZk6V5nVlkoSiJMDk1nT0llmBya
         9lHUCoEqo3ZGQ/FbraGhW6WNhxBIHsfWw1q2q/XJ2zB03WeBQzKqkDHl/xi+iSJswU
         3MMi1HFnJmUmkmf63iU9t7PUCWIvVcCk0yIxz41Dcd5RQ1Hki1E6yyEsptF1i0n7hS
         nbUodWhvuNkixEWY81SSW0PsexFf9IzbAfLbfrmAWBVHpLyLwQ5+JjZdTO7RaMxrhc
         v74Pxqt8adMww==
Message-ID: <05dcf1a0-067a-ed50-b07d-b796d22e7b7b@denx.de>
Date:   Thu, 18 Aug 2022 13:49:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 0/6] Add the iMX8MP PCIe support
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
Cc:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
 <2afdb802-9a86-8313-ebfa-9f2fee7e0023@denx.de>
 <AS8PR04MB8676D575ED7FD81B0451BD028C6D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <AS8PR04MB8676D575ED7FD81B0451BD028C6D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/18/22 12:53, Hongxing Zhu wrote:
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: 2022年8月18日 17:20
>> To: Hongxing Zhu <hongxing.zhu@nxp.com>; p.zabel@pengutronix.de;
>> l.stach@pengutronix.de; bhelgaas@google.com; lorenzo.pieralisi@arm.com;
>> robh@kernel.org; shawnguo@kernel.org; vkoul@kernel.org;
>> alexander.stein@ew.tq-group.com
>> Cc: linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
>> linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
>> <linux-imx@nxp.com>
>> Subject: Re: [PATCH v3 0/6] Add the iMX8MP PCIe support
>>
>> On 8/18/22 09:02, Richard Zhu wrote:
>>> Based on the 6.0-rc1 of the pci/next branch.
>>> This series adds the i.MX8MP PCIe support and had been tested on
>>> i.MX8MP EVK board when one PCIe NVME device is used.
>>>
>>> - i.MX8MP PCIe has reversed initial PERST bit value refer to
>> i.MX8MQ/i.MX8MM.
>>>     Add the PHY PERST explicitly for i.MX8MP PCIe PHY.
>>> - Add the i.MX8MP PCIe PHY support in the i.MX8M PCIe PHY driver.
>>>     And share as much as possible codes with i.MX8MM PCIe PHY.
>>> - Add the i.MX8MP PCIe support in binding document, DTS files, and PCIe
>>>     driver.
>>>
>>> Main changes v2-->v3:
>>> - Fix the schema checking error in the PHY dt-binding patch.
>>> - Inspired by Lucas, the PLL configurations might not required when
>>>     external OSC is used as PCIe referrence clock. It's true. Remove all
>>>     the HSIO PLL bit manipulations, and PCIe works fine on i.MX8MP EVK
>> board
>>>     with one NVME device is used.
>>> - Drop the #4 patch of v2, since it had been applied by Rob.
>>>
>>> Main changes v1-->v2:
>>> - It's my fault forget including Vinod, re-send v2 after include Vinod
>>>     and linux-phy@lists.infradead.org.
>>> - List the basements of this patch-set. The branch, codes changes and so on.
>>> - Clean up some useless register and bit definitions in #3 patch.
>>>
>>> Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  16
>> +++++++--
>>> arch/arm64/boot/dts/freescale/imx8mp-evk.dts                 |  53
>> +++++++++++++++++++++++++++++
>>> arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  46
>> ++++++++++++++++++++++++-
>>> drivers/pci/controller/dwc/pci-imx6.c                        |  17
>> +++++++++-
>>> drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 150
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>> ------------------
>>> drivers/reset/reset-imx7.c                                   |   1 +
>>> 6 files changed, 232 insertions(+), 51 deletions(-)
>>
>> For the entire series:
>>
>> Tested-by: Marek Vasut <marex@denx.de>
>>
> Hi Marek:
> Thanks for your kindly help to test it.

Gladly. Thank you for your continued effort .
