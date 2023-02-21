Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D93569DE45
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 11:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjBUKzi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 05:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjBUKzh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 05:55:37 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047672310D
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 02:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676976935; x=1708512935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dottw58DX6NpLcrIxoBfsO6WcV5uJQI3WvU4f4U5ZFg=;
  b=XSJPVxhTKnDHw5a/i/BWirym4bDLhWG7FuyEVvwAz7cCjhPMlfIaBe2S
   KmZxJDQLLxxDtz44F0Y0AM8TiRL/ooBxIn9m2b5eTtG63qMtqOld0f/+9
   qKiSxgYlLa6UeBz0PR6ATfTRqKMGOSWdlbQfqxDYxamL9OImN+0tWaUDD
   MynWk8ujp7DH0NQy5Bvhb+0JjuFw2YO82S+X4RvbO+jQiqJ4Hs7mnw/ZF
   QHA+R06/faW1+txnl7wdHFqnipwx11/YDpQ1GkXOAc4ENeB2E0e1wuMkx
   jyDT2UowVuZVDQE8YELfOnNeuYpvQauAmSL75lVystIsFF8DKze2xcZ6o
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669046400"; 
   d="scan'208";a="222092272"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2023 18:55:33 +0800
IronPort-SDR: 4IxXbEWFqXvd23TGkT21jBwmzBL4VIPYcOh9pfbhramQcbrPDbD6N+6tfVzZ87iOsAS7UizJAM
 Z2bfiLcd4F1WPTUreQ6iH6oHKkf4bjq73+2VAZ2bICPUTNaUee+q9quRsaHUxGMmsY5HdKW6bM
 UZ86zoUXXrttQQg66sfoePzxsueHLg5UznOrYKYhAhj/w9nYOwBQfy3jzUS3njcDyloQFDHNu1
 2MuDB4mqoNfHsrjgPX6xeFdgE8mATvzjzT2DEVZudh7kpEpvmDAbaKk+d6JQDvoRdXwEKGgQU4
 X3I=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 02:12:33 -0800
IronPort-SDR: SwINKzmJtarYYYOT1DYQj1t3mB98jTD3q88DrY4UtlkOk/bDlJzcfjo46bRpQmr/9V5j1V3Gti
 8nwSr3XDipqrbAK2tWoOUR+I1BT6Bw7MaPpo5V2NqG8oJ8Wjd+HYapuZT++CcQIAjwDDr7tGC1
 5tsZVK8FM9YvOHDFiGOIPUD/DtApCMiytvOnk7TyBT1fpDZwUCrUeTnjyN2r1Dy0vipBCRdasM
 F+g395Hvc5/eNi3XVajW3dnnZlnPvJVJ7iP2V3m8u+iQScali6eVqZROj/C3BD1izl5x6fbJme
 fgM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 02:55:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PLbmP4Ws4z1RWxq
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 02:55:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676976931; x=1679568932; bh=dottw58DX6NpLcrIxoBfsO6WcV5uJQI3WvU
        4f4U5ZFg=; b=RqStWAGmwTKsaOFcjGMNiMQAycpsAdG0h/DujjZpLQIKf7RN8AR
        hlck4UC7t3C4HPOTq6dLYjS83znf9raxBpss1R2Imt+mIRvlo37r/LQaFFafom5m
        fo1dC3WtrmO8LIVKFXaK8WrSvCKPTEsrWfq30tZ2bZVawdtnF2tH6XJ5zzWCDyX3
        FyGgmFhMi+FcqWn0qU+cpNQ5JO6xC5eKzPQvEmLDA5i/SsuzQ71rt1xFWu4jTwU6
        n5xK/cgsCi+LGWrEf+BFxlmMWE3QUntug+ym4lBV+Wg0DoLwkxOTdwavBF3ruDie
        jvTKml0nhnsb97bbB1ki8MpDlF0E85A0Gpw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I0T_kqv0JiyW for <linux-pci@vger.kernel.org>;
        Tue, 21 Feb 2023 02:55:31 -0800 (PST)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PLbmJ0q4rz1RvLy;
        Tue, 21 Feb 2023 02:55:27 -0800 (PST)
Message-ID: <38ae72c9-0f0b-1a94-d2e0-f4ea80e94705@opensource.wdc.com>
Date:   Tue, 21 Feb 2023 19:55:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 9/9] PCI: rockchip: Add parameter check for RK3399 PCIe
 endpoint core set_msi()
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <20230214140858.1133292-10-rick.wertenbroek@gmail.com>
 <ebbddcfa-99e5-efda-0eab-fbd61a33e2c3@opensource.wdc.com>
 <CAAEEuhpDTmAvBZhC9RCueOvqbLb=AttV1KxJrOUBcjHQrpVXmA@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAAEEuhpDTmAvBZhC9RCueOvqbLb=AttV1KxJrOUBcjHQrpVXmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/21/23 19:47, Rick Wertenbroek wrote:
> On Wed, Feb 15, 2023 at 2:39 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 2/14/23 23:08, Rick Wertenbroek wrote:
>>> The RK3399 PCIe endpoint core supports only a single PCIe physcial
>>> function (function number 0), therefore return -EINVAL if set_msi() is
>>> called with a function number greater than 0.
>>> The PCIe standard only allows the multi message capability (MMC) value
>>> to be up to 0x5 (32 messages), therefore return -EINVAL if set_msi() is
>>> called with a MMC value of over 0x5.
>>>
>>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>>> ---
>>>  drivers/pci/controller/pcie-rockchip-ep.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
>>> index b7865a94e..80634b690 100644
>>> --- a/drivers/pci/controller/pcie-rockchip-ep.c
>>> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
>>> @@ -294,6 +294,16 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
>>>       struct rockchip_pcie *rockchip = &ep->rockchip;
>>>       u32 flags;
>>>
>>> +     if (fn) {
>>> +             dev_err(&epc->dev, "This endpoint controller only supports a single physical function\n");
>>> +             return -EINVAL;
>>> +     }
>>
>> Checking this here is late... Given that at most only one physical
>> function is supported, the check should be in rockchip_pcie_parse_ep_dt().
>> Something like:
>>
>>         err = of_property_read_u8(dev->of_node, "max-functions",
>>                                   &ep->epc->max_functions);
>>
>>         if (err < 0 || ep->epc->max_functions > 1)
>>
>>                 ep->epc->max_functions = 1;
>>
> 
> Yes, this could be moved to the probe, thanks.
> 
>> And all the macros with the (fn) argument could also be simplified
>> (argument fn removed) since fn will always be 0.
> 
> These functions cannot be simplified because they have to follow the signature
> given by "pci_epc_ops" (include/linux/pci-epc.h). And this signature has the
> function number as a parameter. If we change the function signature we won't
> be able to assign these functions to the pc_epc_ops structure

I was not suggesting to change the functions signature. I was suggesting
dropping the fn argument for the *macros*, e.g.

ROCKCHIP_PCIE_EP_FUNC_BASE(fn) -> ROCKCHIP_PCIE_EP_FUNC_BASE

since fn is always 0.

That said, I am not entirely sure if the limit really is 1 function at most. The
TRM seems to be suggesting that up to 4 functions can be supported...

[...]

>> Another nice cleanup: define ROCKCHIP_PCIE_EP_MSI_CTRL_REG to include the
>> ROCKCHIP_PCIE_EP_FUNC_BASE(fn) addition so that we do not have to do it
>> here all the time.
> 
> Yes, this could be an improvement but this is the way it is written
> everywhere in this
> driver, I chose to keep it so as to remain coherent with the rest of the driver.
> Cleaning this is not so important since this code will not be
> rewritten / changed so
> often. But I agree that it might be nicer. But, on the other side if
> at some point
> support for virtual functions would be added, the offsets would need
> to be computed
> based on the virtual function number and the code would be written
> like it is now,
> so I suggest keeping this the way it is for now.

Yes, sure, this can be cleaned later.

A more pressing problem is the lack of support for MSIX despite the fact that
the controller supports that *and* advertize it as a capability. That is what
was causing my problem with the Linux nvme driver and my prototype nvme epf
function driver: the host driver was seeing MSIX support (1 vector supported by
default), and so was allocating one MSIX for the device probe. But on the EP
end, it is MSI or INTX only... Working on adding that to solve this issue.

-- 
Damien Le Moal
Western Digital Research

