Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7824F69E9D5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 23:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjBUWBv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 17:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjBUWBt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 17:01:49 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B811D2B293
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 14:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677016903; x=1708552903;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qg8gwLNpEVZ/vS7KRtMF6qf8aQbtNuIsSDPzlOtBJ4E=;
  b=nTSRyVjhohwQz0N6I7zKVWOGLOXOQqXXzGwmy93UMaXbGETb7Sq2sVAQ
   E9cvdayiUPukV76YR6L6ROHq4C71w9DOljfDpv1G2zOFoEKP3SEnCW2xu
   B9ejecg7ztzv0j9UmeekkbF6m8jwrnipC/V723s0kGKTQHMiva92SToSP
   SUBCtCS3fp8RLhNf2LUHVM7z00zrzmvvYrlf69pZPZDceMWL2iiHIrzZz
   BTykzTi9DXDzQZNVR13Vt3HtsdfairAp6KUr54p9yoUpIBst/MEJSr4IN
   ChsQxPjQoaMYIcGaNTCyWZ0Tdznk2d36yNv5/Nl50Yd0l8CFxK8kr+xOW
   g==;
X-IronPort-AV: E=Sophos;i="5.97,317,1669046400"; 
   d="scan'208";a="223852754"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2023 06:01:43 +0800
IronPort-SDR: wo3jCJNqjvdzDlAkKrOLSJTeJHFwoGG/i0sj1hdLyqpQKEu2FM3imeCiNQh/uvkCn/3V+o9SxD
 +/1H28Z0WKM3Thy3I3SJDjlRbm+XGmvSz0ceXZVcve+EbFDztQ5Qib17JRNsEXsfRJhPgSjJdg
 96Ha3Y2hN117e3dOoXb0uP/3ssiiokP7eRDptBfZycU6qxKGvA4qV+R2rOhddLKzB9E004P9J8
 HTG+MfunWKmokyAUvqkStNSfSQf1jaquaCK50l5i1aVryAS5sPH6JNMnkf3OYR2XhrPlYO2gom
 TyY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 13:12:57 -0800
IronPort-SDR: NlgMux5I63RYD6VWXnMvDBMZrIGKoWXf6LIXHvkoU205nG8HEJ3GJOqaxz7fJZC6hwG5oWIKz7
 UOAFGhef0Yi1vdCCqLeU1ZbSwNeOBfHea1sy5PjLc4M26C/2FKY9lsAsyMKmrGnpKyfAKK75CG
 QmFNRsfJiOOVWY4kHSjcx/YBzw+ZUGjtUpBvGNq7eiBCINPRo4II3/r7kxY0PGJGrXsSg2sUc7
 zEN432ZtD6Us3wrONBxvUX16DlbDqRmK8d5q3LLhVyCi0I3/Ad2pFQo5bxb4IEzFYlecV3F6l6
 h14=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2023 14:01:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PLtY21nVJz1Rwt8
        for <linux-pci@vger.kernel.org>; Tue, 21 Feb 2023 14:01:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677016899; x=1679608900; bh=Qg8gwLNpEVZ/vS7KRtMF6qf8aQbtNuIsSDP
        zlOtBJ4E=; b=hpaO95mn/qhY5RcibhaStJecB/gf5yH1dnIBzyrVyIbjEgg6sG9
        ujyLPNGk0Qx5xssERzFOBnINeKKqhAe3S0hdTuzY7TFm2l+42S5BTfHIrv9wxmrW
        SoOmUDXdnf4Joy8hVKyvmkWgLRY9e2TMgR7boXz7B65UVdlXDp5wML98THtRLte9
        OVD6mbIncRt+zCw5bnsFGxWdymskt5zSN73TM5fNnf9S/BhoD5wjXw5yr3qSOnp0
        JC+9VnMFmDQjoo5dQ/62tms6ffHoKJJnRGc/ktqTF7aTGxfz0SMkPaXSwAE5RzWz
        oFnIefKFkVJd7lvGksLnZhp+wlQGS5T8zMg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id caaAP9rveCtK for <linux-pci@vger.kernel.org>;
        Tue, 21 Feb 2023 14:01:39 -0800 (PST)
Received: from [10.225.163.21] (unknown [10.225.163.21])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PLtXv6cS4z1RvLy;
        Tue, 21 Feb 2023 14:01:35 -0800 (PST)
Message-ID: <bba67239-fb4c-7ab5-c0e8-1df37b39bfac@opensource.wdc.com>
Date:   Wed, 22 Feb 2023 07:01:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
 <38ae72c9-0f0b-1a94-d2e0-f4ea80e94705@opensource.wdc.com>
 <CAAEEuhoQV1A8o_2jb1Qfq5d7dj9HpHL+mkDs8K4vs8v=-81zng@mail.gmail.com>
 <CAAEEuhrnz-u1wUe2OVBawSvrsze+rNObSqhb+SEcAqfc-n2c_g@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAAEEuhrnz-u1wUe2OVBawSvrsze+rNObSqhb+SEcAqfc-n2c_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/22/23 01:37, Rick Wertenbroek wrote:
> On Tue, Feb 21, 2023 at 2:19 PM Rick Wertenbroek
> <rick.wertenbroek@gmail.com> wrote:
>>
>> On Tue, Feb 21, 2023 at 11:55 AM Damien Le Moal
>> <damien.lemoal@opensource.wdc.com> wrote:
>>>
>>> On 2/21/23 19:47, Rick Wertenbroek wrote:
>>>> On Wed, Feb 15, 2023 at 2:39 AM Damien Le Moal
>>>> <damien.lemoal@opensource.wdc.com> wrote:
>>>>>
>>>>> On 2/14/23 23:08, Rick Wertenbroek wrote:
>>>>>> The RK3399 PCIe endpoint core supports only a single PCIe physcial
>>>>>> function (function number 0), therefore return -EINVAL if set_msi() is
>>>>>> called with a function number greater than 0.
>>>>>> The PCIe standard only allows the multi message capability (MMC) value
>>>>>> to be up to 0x5 (32 messages), therefore return -EINVAL if set_msi() is
>>>>>> called with a MMC value of over 0x5.
>>>>>>
>>>>>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>>>>>> ---
>>>>>>  drivers/pci/controller/pcie-rockchip-ep.c | 10 ++++++++++
>>>>>>  1 file changed, 10 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
>>>>>> index b7865a94e..80634b690 100644
>>>>>> --- a/drivers/pci/controller/pcie-rockchip-ep.c
>>>>>> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
>>>>>> @@ -294,6 +294,16 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
>>>>>>       struct rockchip_pcie *rockchip = &ep->rockchip;
>>>>>>       u32 flags;
>>>>>>
>>>>>> +     if (fn) {
>>>>>> +             dev_err(&epc->dev, "This endpoint controller only supports a single physical function\n");
>>>>>> +             return -EINVAL;
>>>>>> +     }
>>>>>
>>>>> Checking this here is late... Given that at most only one physical
>>>>> function is supported, the check should be in rockchip_pcie_parse_ep_dt().
>>>>> Something like:
>>>>>
>>>>>         err = of_property_read_u8(dev->of_node, "max-functions",
>>>>>                                   &ep->epc->max_functions);
>>>>>
>>>>>         if (err < 0 || ep->epc->max_functions > 1)
>>>>>
>>>>>                 ep->epc->max_functions = 1;
>>>>>
>>>>
>>>> Yes, this could be moved to the probe, thanks.
>>>>
>>>>> And all the macros with the (fn) argument could also be simplified
>>>>> (argument fn removed) since fn will always be 0.
>>>>
>>>> These functions cannot be simplified because they have to follow the signature
>>>> given by "pci_epc_ops" (include/linux/pci-epc.h). And this signature has the
>>>> function number as a parameter. If we change the function signature we won't
>>>> be able to assign these functions to the pc_epc_ops structure
>>>
>>> I was not suggesting to change the functions signature. I was suggesting
>>> dropping the fn argument for the *macros*, e.g.
>>>
>>> ROCKCHIP_PCIE_EP_FUNC_BASE(fn) -> ROCKCHIP_PCIE_EP_FUNC_BASE
>>>
>>> since fn is always 0.
>>>
>>> That said, I am not entirely sure if the limit really is 1 function at most. The
>>> TRM seems to be suggesting that up to 4 functions can be supported...
>>>
>>> [...]
>>>
>>>>> Another nice cleanup: define ROCKCHIP_PCIE_EP_MSI_CTRL_REG to include the
>>>>> ROCKCHIP_PCIE_EP_FUNC_BASE(fn) addition so that we do not have to do it
>>>>> here all the time.
>>>>
>>>> Yes, this could be an improvement but this is the way it is written
>>>> everywhere in this
>>>> driver, I chose to keep it so as to remain coherent with the rest of the driver.
>>>> Cleaning this is not so important since this code will not be
>>>> rewritten / changed so
>>>> often. But I agree that it might be nicer. But, on the other side if
>>>> at some point
>>>> support for virtual functions would be added, the offsets would need
>>>> to be computed
>>>> based on the virtual function number and the code would be written
>>>> like it is now,
>>>> so I suggest keeping this the way it is for now.
>>>
>>> Yes, sure, this can be cleaned later.
>>>
>>> A more pressing problem is the lack of support for MSIX despite the fact that
>>> the controller supports that *and* advertize it as a capability. That is what
>>> was causing my problem with the Linux nvme driver and my prototype nvme epf
>>> function driver: the host driver was seeing MSIX support (1 vector supported by
>>> default), and so was allocating one MSIX for the device probe. But on the EP
>>> end, it is MSI or INTX only... Working on adding that to solve this issue.
>>>
>>
>> I have seen this too, the controller advertises the capability. However, the TRM
>> (section 17.5.9) says that MSI-X is not supported (MSI / INTx only as you said).
>> So the solution should be to modify the probe function of the endpoint
>> controller
>> so that the MSI-X capability would not be advertised, this should fix
>> your problem.
>>
>> I wonder if one could still implement MSI-X because from the endpoint we would
>> just need to implement it as a message (TLP) over PCIe (because the space for
>> the vectors is allocated and written, so that part should be ok). I am
>> not an expert
>> on MSI-X, but the reason the endpoint cannot send them could be because MSI-X
>> requires some fields in the PCIe header descriptor to be filled with values that
>> cannot be set through the "desc0-3" registers of the RK3399 PCIe endpoint core.
>>
>> Anyways, the endpoint should not advertise the MSI-X capabilities when it cannot
>> send such interrupts. Once this is fixed you should be able to have your NVMe
>> function running.
>>
>> Regards.
>> Rick
>>
> 
> It is possible to disable MSI-X by skipping the MSI-X capability
> structure in the PCIe
> capabilities structures linked-list.
> The current linked list is MSI cap (0x90) -> MSI-X cap (0xb0) -> PCIe
> Device cap (0xc0)
> So we want to set MSI (0x90) -> PCIe Device cap (0xc0)
> 
> This can be done by writing 0xc0 to bits 15-8 of 0xFDA0'0090 (MSI cap).
> I tested this quickly through devmem2 before loading the endpoint
> function driver
> and it fixes the issue of MSI-X capabilities being advertised to the host.
> 
> In the driver the changes would look like this;
> In the probe function you can disable MSI-X as follows:
> 
> @@ -631,6 +618,28 @@ static int rockchip_pcie_ep_probe(struct
> platform_device *pdev)
> 
>         ep->irq_pci_addr = ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR;
> 
> +       /*
> +        * Disable MSI-X because the controller is not capable of MSI-X
> +        * This requires to skip the MSI-X capabilities entry in the

s/capabilities/capability

> +        * chain of PCIe capabilities, we get the next pointer from the
> +        * MSI-X entry and set that in the MSI capability entry, this way
> +        * the MSI-X entry is skipped (left out of the linked-list)
> +        */
> +       cfg_msi = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
> +               ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> +
> +       cfg_msi &= ~ROCKCHIP_PCIE_EP_MSI_CP1_MASK;
> +
> +       cfg_msix_cp = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
> +               ROCKCHIP_PCIE_EP_MSIX_CAP_REG) &
> ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK;
> +
> +       cfg_msi |= cfg_msix_cp;
> +
> +       rockchip_pcie_write(rockchip, cfg_msi,
> +               PCIE_EP_CONFIG_BASE + ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
> +
>         rockchip_pcie_write(rockchip, PCIE_CLIENT_CONF_ENABLE,
> PCIE_CLIENT_CONFIG);
> 
>         return 0;
>  err_epc_mem_exit:
>         pci_epc_mem_exit(epc);
> 
> In the pcie-rockchip.h add the following #defines:
> 
> @@ -216,21 +227,28 @@
>  #define ROCKCHIP_PCIE_EP_CMD_STATUS                    0x4
>  #define   ROCKCHIP_PCIE_EP_CMD_STATUS_IS               BIT(19)
>  #define ROCKCHIP_PCIE_EP_MSI_CTRL_REG                  0x90
> +#define   ROCKCHIP_PCIE_EP_MSI_CP1_OFFSET                      8
> +#define   ROCKCHIP_PCIE_EP_MSI_CP1_MASK                        GENMASK(15, 8)
> +#define   ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET                    16
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET         17
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK           GENMASK(19, 17)
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_OFFSET         20
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MME_MASK           GENMASK(22, 20)
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_ME                         BIT(16)
>  #define   ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP       BIT(24)
> +#define ROCKCHIP_PCIE_EP_MSIX_CAP_REG                  0xb0
> +#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_OFFSET          8
> +#define   ROCKCHIP_PCIE_EP_MSIX_CAP_CP_MASK            GENMASK(15, 8)
>  #define ROCKCHIP_PCIE_EP_DUMMY_IRQ_ADDR                                0x1
>  #define ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR           0x3
> 
> I will add this to the next version of the patch set.
> Thank you Damien for pointing this out ! This should solve the issues
> you have with
> your NVMe endpoint function regarding MSI-X interrupts.

OK. I replied to your previous mail with the same idea. Looks good :)
Will test that instead of my dirty hack that puts 0 in the MSIX capability ID.

> 
> Regards
> Rick
> 
>>
>>> --
>>> Damien Le Moal
>>> Western Digital Research
>>>

-- 
Damien Le Moal
Western Digital Research

