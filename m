Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A087617AD3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 11:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKCKaA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 06:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKCK37 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 06:29:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FD0DF31
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 03:29:58 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1oqXTv-0007JU-G1; Thu, 03 Nov 2022 11:29:55 +0100
Message-ID: <c288913f-46fc-32a8-d1bf-515d6522b462@pengutronix.de>
Date:   Thu, 3 Nov 2022 11:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1] PCI: imx6: Keep the GPIO regulator always on
Content-Language: en-US
To:     Hongxing Zhu <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1667455698-14578-1-git-send-email-hongxing.zhu@nxp.com>
 <ff2f43f9-b04e-a224-02c2-d446a68c5337@pengutronix.de>
 <AS8PR04MB8676B8B896C3A4F2F4BAF6D28C389@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <AS8PR04MB8676B8B896C3A4F2F4BAF6D28C389@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Richard,

On 03.11.22 09:05, Hongxing Zhu wrote:
>> -----Original Message-----
>> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> On 03.11.22 07:08, Richard Zhu wrote:
>>> Some WIFI modules load their firmware once in probe, and can't be
>>> powered off during suspend. Otherwise, these WIFI modules wouldn't be
>>> functional anymore after resume back.
>>
>> The brcmfmac OTOH, reprobes when resuming from suspend. Before this patch,
>> AFAIU, it should've been possible for the EP to go into D3cold during suspend.
>> This may no longer be possible when we keep vpcie powered.
>>
> Oh, understood. In the other words, the EP wouldn't be in D3 mode when vpcie
>  is always powered on, right?
> Thanks for your detailed explains.

D3cold specifically, which is the state the device enters when supply voltage
is cut. Devices enter D3hot programmatically and in this case device
supply voltage remains powered.

>> Prior to a4bb720eeb1e, vpcie was briefly toggled during PCIe core reset
>> sequence, so aforementioned WiFi modules that don't reprobe over resume
>> should've been broken by that too? If so, I don't see how it fixes that commit
>> as everything that is broken now was broken before that commit as well. After
>> this patch however, modules that can accept vpcie being toggled can't benefit
>> from some of the power saving.
> The WIFI modules that don't re-probe over resume are always broken, if the
>  vpcie is toggled during suspend/resume, I think.
> 
> BTW, is the re-probe over resume mandatory requirements for EP devices
> (for example, WIFI modules)?

I only looked at brcmfmac.

> I'm curious that how the WIFI remote wake up going on if the WIFI module
>  is totally powered off.

Device may be in D3cold, but link is at L2, so there's still auxiliary
power for device to support wake on (wired) LAN. No idea how prevalent
this is for Wake on Wireless LAN.

>> Why can't users with this issue use a regulator-always-on regulator instead?
> Yes, you're right.
> One regulator-always-on regulator is a good idea.

That's what I do on my side as well, because we didn't want the interface
to briefly disappear and reappear during suspend.

Cheers,
Ahmad

> 
>>
>>> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>>> ---
>>>  drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++----------------
>>>  1 file changed, 8 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
>>> b/drivers/pci/controller/dwc/pci-imx6.c
>>> index 2616585ca5f8..94a89bbf381d 100644
>>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>>> @@ -926,22 +926,13 @@ static int imx6_pcie_host_init(struct dw_pcie_rp
>> *pp)
>>>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
>>>  	int ret;
>>>
>>> -	if (imx6_pcie->vpcie) {
>>> -		ret = regulator_enable(imx6_pcie->vpcie);
>>> -		if (ret) {
>>> -			dev_err(dev, "failed to enable vpcie regulator: %d\n",
>>> -				ret);
>>> -			return ret;
>>> -		}
>>> -	}
>>> -
>>>  	imx6_pcie_assert_core_reset(imx6_pcie);
>>>  	imx6_pcie_init_phy(imx6_pcie);
>>>
>>>  	ret = imx6_pcie_clk_enable(imx6_pcie);
>>>  	if (ret) {
>>>  		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
>>> -		goto err_reg_disable;
>>> +		return ret;
>>>  	}
>>>
>>>  	if (imx6_pcie->phy) {
>>> @@ -974,9 +965,6 @@ static int imx6_pcie_host_init(struct dw_pcie_rp
>> *pp)
>>>  		phy_exit(imx6_pcie->phy);
>>>  err_clk_disable:
>>>  	imx6_pcie_clk_disable(imx6_pcie);
>>> -err_reg_disable:
>>> -	if (imx6_pcie->vpcie)
>>> -		regulator_disable(imx6_pcie->vpcie);
>>>  	return ret;
>>>  }
>>>
>>> @@ -991,9 +979,6 @@ static void imx6_pcie_host_exit(struct dw_pcie_rp
>> *pp)
>>>  		phy_exit(imx6_pcie->phy);
>>>  	}
>>>  	imx6_pcie_clk_disable(imx6_pcie);
>>> -
>>> -	if (imx6_pcie->vpcie)
>>> -		regulator_disable(imx6_pcie->vpcie);
>>>  }
>>>
>>>  static const struct dw_pcie_host_ops imx6_pcie_host_ops = { @@
>>> -1263,6 +1248,13 @@ static int imx6_pcie_probe(struct platform_device
>> *pdev)
>>>  		if (PTR_ERR(imx6_pcie->vpcie) != -ENODEV)
>>>  			return PTR_ERR(imx6_pcie->vpcie);
>>>  		imx6_pcie->vpcie = NULL;
>>> +	} else {
>>> +		ret = regulator_enable(imx6_pcie->vpcie);
>>> +		if (ret) {
>>> +			dev_err(dev, "failed to enable vpcie regulator: %d\n",
>>> +				ret);
>>> +			return ret;
>>> +		}
>>
>> Shouldn't the regulator enable be undone if the probe later fails?
>>
> Yes, it's required.
> Thanks a lot for your comments.
> 
> Richard Zhu
> Best Regards
>> Cheers,
>> Ahmad
>>
>> --
>> Pengutronix e.K.                           |
>> |
>> Steuerwalder Str. 21                       |
>> https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.pe
>> ngutronix.de%2F&amp;data=05%7C01%7Chongxing.zhu%40nxp.com%7C06f5
>> 363342c9464bca5a08dabd69bdb5%7C686ea1d3bc2b4c6fa92cd99c5c301635
>> %7C0%7C0%7C638030559094875195%7CUnknown%7CTWFpbGZsb3d8eyJW
>> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
>> 000%7C%7C%7C&amp;sdata=36fpveVBgKraYIeEJjMSiPA10azBfhhHrNVYTaocN
>> nQ%3D&amp;reserved=0  |
>> 31137 Hildesheim, Germany                  | Phone:
>> +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:
>> +49-5121-206917-5555 |
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

