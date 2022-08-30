Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EBB5A5CAB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiH3HPr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 03:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiH3HPq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 03:15:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6574C543DA
        for <linux-pci@vger.kernel.org>; Tue, 30 Aug 2022 00:15:45 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1oSvTF-0007FZ-08; Tue, 30 Aug 2022 09:15:37 +0200
Message-ID: <d3625367-9f7a-c864-7908-0c819bf3f496@pengutronix.de>
Date:   Tue, 30 Aug 2022 09:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 0/2] Fix the wrong order of phy callbacks
Content-Language: en-US
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1661173856-1192-1-git-send-email-hongxing.zhu@nxp.com>
 <e6d5f688-f4c3-6094-91f6-a160b601c07d@pengutronix.de>
 <AS8PR04MB86767CFA73F8C639EDD16A298C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <AS8PR04MB86767CFA73F8C639EDD16A298C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Richard,

On 30.08.22 05:47, Hongxing Zhu wrote:
>>> [PATCH v1 1/2] PCI: imx6: Fix the wrong order of phy_init() and [PATCH
>>> v1 2/2] phy: freescale: imx8m-pcie: Fix the wrong order of
>>
>> This introduces an intermittent breakage. Can you squash?
> 
> Hi Ahmad:
> Thanks for your comments.
> Do you mean to squash this fix to the preview series?
> I'm afraid that it's not easy to do that.
> Because there are a lot of pci-imx6 code changes after 
> commit: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver").

The way I understand it, if a bisect ends up between your two patches, i.MX8M
PCIe will be broken, whereas it worked before. I thus wonder if we shouldn't
instead squash this series here into a single patch.

Cheers,
Ahmad


> 
> Best Regards
> Richard Zhu
>>
>>>
>>>
>>
>>
>> --
>> Pengutronix e.K.                           |
>> |
>> Steuerwalder Str. 21                       |
>> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.pe
>> ngutronix.de%2F&amp;data=05%7C01%7Chongxing.zhu%40nxp.com%7C3277
>> 61bac5b9407d977008da89886b15%7C686ea1d3bc2b4c6fa92cd99c5c30163
>> 5%7C0%7C0%7C637973516254656985%7CUnknown%7CTWFpbGZsb3d8eyJ
>> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
>> C3000%7C%7C%7C&amp;sdata=hasOtX77%2Fea5yLbV8C7wOfdZStF5erHOL58
>> Zf6ZZbo4%3D&amp;reserved=0  |
>> 31137 Hildesheim, Germany                  | Phone:
>> +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:
>> +49-5121-206917-5555 |


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
