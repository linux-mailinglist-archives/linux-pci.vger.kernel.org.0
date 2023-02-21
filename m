Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E30669E9C7
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 22:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBUV6K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 16:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjBUV6J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 16:58:09 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F721ADC3
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 13:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677016687; x=1708552687;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g9TnFRqAZqcDsGZcV1iYV9pTjzWi1/1bs6SxLfEGNWA=;
  b=GH6weQ0NW5KgMS7uGJDvXxM4E3VZIWdghXkd9Nuf04WbSQT7mluqk8rv
   GkBOk7jrVDYYzZQW4t4xuEvwW7o+q3FmWsyowYfzkuayBhYV6jWDF+DhU
   bs2MDdM7xJhT1EO4AMrwLfKK0wrNOQ5fvIpkxH8Mh6OtxI/saJV72ZRLJ
   xHIgdDeTytQB3p9oNcbBVma5ms366aSXeu9JwJeJKdWOQVWWorchpBNQu
   G8vbRR/YGxhvAqBm08E+2trwhwv1QZIymAlr4VY5beD7X1/1a3p+p7+nb
   WqiNMlD4ZbvwZebrbk68c4ScvEKREgmrGaNWLqe3ywiuklQZR0pXysDzo
   w==;
X-IronPort-AV: E=Sophos;i="5.97,317,1669046400"; 
   d="scan'208";a="222134152"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2023 05:58:05 +0800
IronPort-SDR: d5inycvAYXH5WFdpUUl6uE0+R1f8smEkkWQ0/l+HXHcB6G3facIHZPc7cdZGyXsLThs80sLUYw
 SP73luUxH9E+J0Kmy4mAzYZKfRN//U3n95pnuYGm3h5nBGwAqMCqtGN0Dx9LyhfARg8oGLnm/0
 my6Mnjm7wC13BDNcFi89kKm5vXi8VC21cDNu5RHe2UkhWkeaHZzgaYgEF9nh21wYoRbgj5r5zH
 /aVIKwD7x3QJ2ecbFwdLVi2XkUQLENoa+yD96A1/g97Cjn3H7uV6kJlJd2lrsmm0r8J11ESxKy
 Dk0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 13:15:04 -0800
IronPort-SDR: 9UMmnryTP1vQ7bfVi2O9+j+l1YFo8E7VzDh/uyCMTS3f+N+f+q8A6rD4C4jhWOBaTIOPZe3R+M
 pRcx9EYnUjvOEFNzCCXHurC1B8noBEe9NNzoyYnCzzetOPwjLk/lEciIXAoAb2lBqttybQuL5e
 2y+deOzv/Ftu1hAN2YvuwLNfsVXUOCDKs6m4SxcZZ1gq/KOcHejLwzMGNzZ0IFJCReLTnq/Q5s
 HOAjLyhdKFwSEoEiX0rmQ36QQUjR4/fT4bqQkxupOim+aQaTJLfU95E3dd2TQjaCEotz374CvQ
 UrU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 13:58:05 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PLtSr5tHBz1RWxq
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 13:58:04 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677016682; x=1679608683; bh=g9TnFRqAZqcDsGZcV1iYV9pTjzWi1/1bs6S
        xLfEGNWA=; b=Rb9/RTEigoXlpl3/WTaPyfgRujxS0dNLPQlHHKqTpzdykTvexkm
        mK+7rSBYPQchCE4X3iRubIdTVA1kuy2s3/s3FL3IymSUduI/0C8ClvciOyDM8gqy
        nThhdHRXBkRNWw68JXTvoGQluphxoEZ+yvmpAAIMCjrncML4W8JH3FV3E3nQyyDG
        j/xPAI2U+cEZqSkvYKF1xEXUxe0bhttNRB1cf4Vb6tlHY++EsL3TP/kw1vlBMCnB
        emJm1kL5Pd/hvTIfCk01L9mRDeWcf9IBkZLlW/d4hgwTSMDu8fM8TVnrkkUyQ2zL
        cfzPhfLndTkVUweNAu5WFR+P0WGYENfno1g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lCjOm0Xm-wk1 for <linux-pci@vger.kernel.org>;
        Tue, 21 Feb 2023 13:58:02 -0800 (PST)
Received: from [10.225.163.21] (unknown [10.225.163.21])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PLtSk5wLTz1RvLy;
        Tue, 21 Feb 2023 13:57:58 -0800 (PST)
Message-ID: <a524ec1c-68ee-e20e-683a-40822b2235fd@opensource.wdc.com>
Date:   Wed, 22 Feb 2023 06:57:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 9/9] PCI: rockchip: Add parameter check for RK3399 PCIe
 endpoint core set_msi()
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
 <38ae72c9-0f0b-1a94-d2e0-f4ea80e94705@opensource.wdc.com>
 <CAAEEuhoQV1A8o_2jb1Qfq5d7dj9HpHL+mkDs8K4vs8v=-81zng@mail.gmail.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAAEEuhoQV1A8o_2jb1Qfq5d7dj9HpHL+mkDs8K4vs8v=-81zng@mail.gmail.com>
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

On 2/21/23 22:19, Rick Wertenbroek wrote:
> On Tue, Feb 21, 2023 at 11:55 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 2/21/23 19:47, Rick Wertenbroek wrote:
>>> On Wed, Feb 15, 2023 at 2:39 AM Damien Le Moal
>>> <damien.lemoal@opensource.wdc.com> wrote:
>>>>
>>>> On 2/14/23 23:08, Rick Wertenbroek wrote:
>>>>> The RK3399 PCIe endpoint core supports only a single PCIe physcial
>>>>> function (function number 0), therefore return -EINVAL if set_msi() is
>>>>> called with a function number greater than 0.
>>>>> The PCIe standard only allows the multi message capability (MMC) value
>>>>> to be up to 0x5 (32 messages), therefore return -EINVAL if set_msi() is
>>>>> called with a MMC value of over 0x5.
>>>>>
>>>>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>>>>> ---
>>>>>  drivers/pci/controller/pcie-rockchip-ep.c | 10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
>>>>> index b7865a94e..80634b690 100644
>>>>> --- a/drivers/pci/controller/pcie-rockchip-ep.c
>>>>> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
>>>>> @@ -294,6 +294,16 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
>>>>>       struct rockchip_pcie *rockchip = &ep->rockchip;
>>>>>       u32 flags;
>>>>>
>>>>> +     if (fn) {
>>>>> +             dev_err(&epc->dev, "This endpoint controller only supports a single physical function\n");
>>>>> +             return -EINVAL;
>>>>> +     }
>>>>
>>>> Checking this here is late... Given that at most only one physical
>>>> function is supported, the check should be in rockchip_pcie_parse_ep_dt().
>>>> Something like:
>>>>
>>>>         err = of_property_read_u8(dev->of_node, "max-functions",
>>>>                                   &ep->epc->max_functions);
>>>>
>>>>         if (err < 0 || ep->epc->max_functions > 1)
>>>>
>>>>                 ep->epc->max_functions = 1;
>>>>
>>>
>>> Yes, this could be moved to the probe, thanks.
>>>
>>>> And all the macros with the (fn) argument could also be simplified
>>>> (argument fn removed) since fn will always be 0.
>>>
>>> These functions cannot be simplified because they have to follow the signature
>>> given by "pci_epc_ops" (include/linux/pci-epc.h). And this signature has the
>>> function number as a parameter. If we change the function signature we won't
>>> be able to assign these functions to the pc_epc_ops structure
>>
>> I was not suggesting to change the functions signature. I was suggesting
>> dropping the fn argument for the *macros*, e.g.
>>
>> ROCKCHIP_PCIE_EP_FUNC_BASE(fn) -> ROCKCHIP_PCIE_EP_FUNC_BASE
>>
>> since fn is always 0.
>>
>> That said, I am not entirely sure if the limit really is 1 function at most. The
>> TRM seems to be suggesting that up to 4 functions can be supported...
>>
>> [...]
>>
>>>> Another nice cleanup: define ROCKCHIP_PCIE_EP_MSI_CTRL_REG to include the
>>>> ROCKCHIP_PCIE_EP_FUNC_BASE(fn) addition so that we do not have to do it
>>>> here all the time.
>>>
>>> Yes, this could be an improvement but this is the way it is written
>>> everywhere in this
>>> driver, I chose to keep it so as to remain coherent with the rest of the driver.
>>> Cleaning this is not so important since this code will not be
>>> rewritten / changed so
>>> often. But I agree that it might be nicer. But, on the other side if
>>> at some point
>>> support for virtual functions would be added, the offsets would need
>>> to be computed
>>> based on the virtual function number and the code would be written
>>> like it is now,
>>> so I suggest keeping this the way it is for now.
>>
>> Yes, sure, this can be cleaned later.
>>
>> A more pressing problem is the lack of support for MSIX despite the fact that
>> the controller supports that *and* advertize it as a capability. That is what
>> was causing my problem with the Linux nvme driver and my prototype nvme epf
>> function driver: the host driver was seeing MSIX support (1 vector supported by
>> default), and so was allocating one MSIX for the device probe. But on the EP
>> end, it is MSI or INTX only... Working on adding that to solve this issue.
>>
> 
> I have seen this too, the controller advertises the capability. However, the TRM
> (section 17.5.9) says that MSI-X is not supported (MSI / INTx only as you said).
> So the solution should be to modify the probe function of the endpoint
> controller
> so that the MSI-X capability would not be advertised, this should fix
> your problem.

Yep, that is what I did for now: write 0 in the capability ID of the MSIX
capability list entry. A cleaner solution would be to change the next entry
pointer of the entry preceding the MSIX entry. Will send a patch for that.

> 
> I wonder if one could still implement MSI-X because from the endpoint we would
> just need to implement it as a message (TLP) over PCIe (because the space for
> the vectors is allocated and written, so that part should be ok). I am
> not an expert
> on MSI-X, but the reason the endpoint cannot send them could be because MSI-X
> requires some fields in the PCIe header descriptor to be filled with values that
> cannot be set through the "desc0-3" registers of the RK3399 PCIe endpoint core.
> 
> Anyways, the endpoint should not advertise the MSI-X capabilities when it cannot
> send such interrupts. Once this is fixed you should be able to have your NVMe
> function running.
> 
> Regards.
> Rick
> 
> 
>> --
>> Damien Le Moal
>> Western Digital Research
>>

-- 
Damien Le Moal
Western Digital Research

