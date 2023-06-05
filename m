Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F57223A0
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 12:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjFEKf1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 06:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjFEKfA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 06:35:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21078196
        for <linux-pci@vger.kernel.org>; Mon,  5 Jun 2023 03:34:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d57cd373fso4086177b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Jun 2023 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1685961277; x=1688553277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twZVSE//NTdMHxapCUhykCDCTFCBz5HADUjUvygv/yU=;
        b=oN0BL/JbkoIWQ9mQV8zPC/GggtMQ57NBig283buITfU0v7Uuvyp/2LV4Vu46znAtI2
         OTwLbvuPu1cTQq5i87IObsrZrkx1K95jEPcT0nz96WUMctiGTEPRFGaBjgJBf1QCjvaW
         h/eP2lCQLPPiM2tfNUKlzYSF9EyzPCqghQBhQFjUfDshUQLaIISeWStHZWkpYGyGEzad
         yTnsjaRl3TI6WJQtc/HqL5aLRFWh9YlL8cZUf+nz9jp72yUp80KaAj1FXBY26SbKZdHY
         940Ez6YE/nohuKf2SWoG0rgY/7y09m9xEtR+ACtgrRyR/YX4SJ6+bFbpRDl3L23pTLMB
         ATrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685961277; x=1688553277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twZVSE//NTdMHxapCUhykCDCTFCBz5HADUjUvygv/yU=;
        b=ecepgtBsTFutJFCSJuS5kr33K3pv94SH25b4GtdRk0xCCCYRpWUYVrk6EDOXs8L0wR
         NSyTzfteNvt994BijEtZ86jycskyn5mTIFZNRdfTqH1M+VoxwAhdeFy2fUpH/3IkJd9X
         eNAAzHDYjqPdrUBSaPTQF7pfCn5mXNsqEGuuWDrdxUA8xAZMl7lG9bpnSUaJ4J94lJkw
         BK5n8YtFi5yH9V6EBZtyIt1BCEx/jlsoBuKBRtPnHpDa8QNr9/Qds3eYLL/DxrkgX+D0
         INB/+2VS2j5qGF6efsbEc5fx6b+VLBXN5A00YmcFTAnPLX/uuPrSZkU1b9uMY4iTuKrI
         t0tg==
X-Gm-Message-State: AC+VfDznLyS7+epT1QuCeI2WEGL3gFgWO2pcOujuJfbetHYaUIotq3Ff
        8eltInFmMTyPgg576Cb2bjzWjw==
X-Google-Smtp-Source: ACHHUZ4Gv5MlNsnbuVQtmzTUOeDktQslPUV0FFMvpWWAzywqSh58OeNmGs44nUbn1+HHsCyYDSnTMg==
X-Received: by 2002:a17:902:d481:b0:1ad:ea13:1916 with SMTP id c1-20020a170902d48100b001adea131916mr7643199plg.21.1685961277162;
        Mon, 05 Jun 2023 03:34:37 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id f23-20020a170902ab9700b001b1a2bf5274sm6242056plr.22.2023.06.05.03.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 03:34:36 -0700 (PDT)
Message-ID: <8d74de55-5f89-f887-95bb-db2e8f77cfc0@igel.co.jp>
Date:   Mon, 5 Jun 2023 19:34:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 1/3] PCI: endpoint: support an alignment aware
 map/unmaping
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Li Chen <lchen@ambarella.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230113090350.1103494-1-mie@igel.co.jp>
 <20230113090350.1103494-2-mie@igel.co.jp>
 <e417f2c9-1fcb-cf57-3524-1408c9aae5fa@amd.com>
 <978b63ac-90b5-b909-d259-0668b77f1cc8@kernel.org>
 <8bc9affb-7b72-0495-16de-c0867a141f9f@igel.co.jp>
 <7a4f4f8a-8edf-0ac4-2e9f-a341fd589e8e@kernel.org>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <7a4f4f8a-8edf-0ac4-2e9f-a341fd589e8e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2023/06/02 21:21, Damien Le Moal wrote:
> On 6/2/23 18:42, Shunsuke Mie wrote:
>> Hi Damien,
>>
>> On 2023/06/02 8:43, Damien Le Moal wrote:
>>> On 6/2/23 00:06, Kishon Vijay Abraham I wrote:
>>>> Hi Shunsuke,
>>>>
>>>> On 1/13/2023 2:33 PM, Shunsuke Mie wrote:
>>>>> Add an align_mem operation to the EPC ops, which function is used to
>>>>> pci_epc_map/unmap_addr(). These change to enable mapping for any alignment
>>>>> restriction of EPC. The map function maps an aligned memory to include a
>>>>> requested memory region.
>>>> I'd prefer all the PCIe address alignment restriction be handled in the
>>>> endpoint function drivers and not inside the core layer (esp in map and
>>>> unmap calls).
>>> That is a really *bad* idea ! Most function drivers should be able to work with
>>> any EP controller hardware. Asking these drivers to support all the alignment
>>> peculiarities of every possible EP controller is impossible.
>>>
>>>> IMO, get the pci address alignment restriction using pci_epc_features.
>>>> And use a bigger size (based on alignment restriction) in
>>>> pci_epc_mem_alloc_addr() and access the allocated window using an offset
>>>> (based on alignment value). You can add separate helpers if required.
>>> That is too simplistic and not enough. Example: Rick and I working on an nvme
>>> function driver are facing a lot of issues with the EPC API for mem & mapping
>>> management because we have 0 control over the PCI address that the host will
>>> use. Alignment is all over the place, and the current EPC memory API
>>> restrictions (window size limitations) make it impossible to transparently
>>> handle all cases. We endup with NVMe command failures simply because of the API
>>> limitations.
>> I think so to.
>>
>> I'm also proposing virtio-console function driver[1]. I suppose the
>> virtio function
>> driver and your nvme function driver are the same in that the spec is
>> defined and
>> host side driver must work as is.
>>
>> [1]
>> https://lore.kernel.org/linux-pci/20230427104428.862643-4-mie@igel.co.jp/
>>
>>> And sure, we can modify that driver to better support the EP controller we are
>>> using (rockchip). But we need to support other EP controllers as well. So API
>>> changes are definitely needed. Working on that. That is not easy as the mapping
>>> API and its semantic impacts data transfers (memcpy_from|toio and DMA).
>>>
>>> I do have a patch that does something similar as this one, but at a much higher
>>> level with a helper function that gives the function driver the offset into the
>>> allocated memory region to use for mapping a particular PCI address. And then
>>> this helper is then in turn used into a new pci_epc_map() function which does
>>> mem alloc + mapping in one go based on the EPC constraints. That hides all
>>> alignment details to the function drivers, which greatlyu simplyfies the code.
>>> But that is not enough as alignment also implies that we have to deal with
>>> boundaries (due to limited window size) and so sometimes endpu failing a mapping
>>> that is too large because the host used a PCI address close to the boundary.
>>> More work is needed to have pci_epc_map() also hide that with tricks like
>>> allowing the allocation and mapping of multiple contiguous windows. So EPC ops
>>> API changes are also needed.
>> Could you submit the your changes if you can?
>>
>> I'd like to solve the current EPC limitation for the mapping in a better
>> way and avoid doing similar work.
> Will try to cleanup my patches and send an RFC next week. Need to rebase,
> cleanup etc. Not sure I can make it soon as I am busy with other things for 6.5
> right now.
>
> You can have a look at the work in progress here:
>
> https://github.com/damien-lemoal/linux/tree/rockpro64_ep_v21
>
> There are a bunch of epf and epc core patches as well as some rockchip driver
> patches. The first half of the patches on top of Linus 6.3 tag patch are already
> in pci-next.

I'd like to see the repo. Thank you for your cooperation.

Best,

Shunsuke

