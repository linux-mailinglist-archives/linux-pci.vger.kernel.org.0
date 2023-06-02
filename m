Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4407201F3
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 14:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjFBMVf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 08:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbjFBMVT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 08:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2491AD;
        Fri,  2 Jun 2023 05:21:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4573164FD9;
        Fri,  2 Jun 2023 12:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63064C433EF;
        Fri,  2 Jun 2023 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685708467;
        bh=PLdBfEClAMSly38pIj5EbZNFFoVKxAsoZhfeXQhzduA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L1sdvIBBDriYTc0lag8r7w3THWmMo0Y5lCAZz/kfobeaQPaWnxiQZ3xyJd8vyt0dN
         EG2ERiE/y7zFLcEsOJuLtfXnu3283Y4wIJCtt+gktxlKuyPsoo8jIJmRJ0lJMj1tD8
         LDJWnR3fkz9ZVm3nnuAPWZLBQUt8/agkm08cJFwy/WaCjrGj4uIbQzdGhtlT2fMwpd
         qFn6MVBebfAJcJ2pGcqrghuTogK8PPe4vZgnVW9dQ1Cd4zBeORfty6obIWl8EMdtEz
         BPNi0BVkOxLfPAvjXF2aXqtk87CpZs5KwNOKta0qHTlIvxqJXwKgOfNtBQXXEet8Ej
         EMEdzpGsIvePA==
Message-ID: <7a4f4f8a-8edf-0ac4-2e9f-a341fd589e8e@kernel.org>
Date:   Fri, 2 Jun 2023 21:21:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/3] PCI: endpoint: support an alignment aware
 map/unmaping
Content-Language: en-US
To:     Shunsuke Mie <mie@igel.co.jp>,
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
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <8bc9affb-7b72-0495-16de-c0867a141f9f@igel.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/2/23 18:42, Shunsuke Mie wrote:
> Hi Damien,
> 
> On 2023/06/02 8:43, Damien Le Moal wrote:
>> On 6/2/23 00:06, Kishon Vijay Abraham I wrote:
>>> Hi Shunsuke,
>>>
>>> On 1/13/2023 2:33 PM, Shunsuke Mie wrote:
>>>> Add an align_mem operation to the EPC ops, which function is used to
>>>> pci_epc_map/unmap_addr(). These change to enable mapping for any alignment
>>>> restriction of EPC. The map function maps an aligned memory to include a
>>>> requested memory region.
>>> I'd prefer all the PCIe address alignment restriction be handled in the
>>> endpoint function drivers and not inside the core layer (esp in map and
>>> unmap calls).
>> That is a really *bad* idea ! Most function drivers should be able to work with
>> any EP controller hardware. Asking these drivers to support all the alignment
>> peculiarities of every possible EP controller is impossible.
>>
>>> IMO, get the pci address alignment restriction using pci_epc_features.
>>> And use a bigger size (based on alignment restriction) in
>>> pci_epc_mem_alloc_addr() and access the allocated window using an offset
>>> (based on alignment value). You can add separate helpers if required.
>> That is too simplistic and not enough. Example: Rick and I working on an nvme
>> function driver are facing a lot of issues with the EPC API for mem & mapping
>> management because we have 0 control over the PCI address that the host will
>> use. Alignment is all over the place, and the current EPC memory API
>> restrictions (window size limitations) make it impossible to transparently
>> handle all cases. We endup with NVMe command failures simply because of the API
>> limitations.
> 
> I think so to.
> 
> I'm also proposing virtio-console function driver[1]. I suppose the 
> virtio function
> driver and your nvme function driver are the same in that the spec is 
> defined and
> host side driver must work as is.
> 
> [1] 
> https://lore.kernel.org/linux-pci/20230427104428.862643-4-mie@igel.co.jp/
> 
>>
>> And sure, we can modify that driver to better support the EP controller we are
>> using (rockchip). But we need to support other EP controllers as well. So API
>> changes are definitely needed. Working on that. That is not easy as the mapping
>> API and its semantic impacts data transfers (memcpy_from|toio and DMA).
>>
>> I do have a patch that does something similar as this one, but at a much higher
>> level with a helper function that gives the function driver the offset into the
>> allocated memory region to use for mapping a particular PCI address. And then
>> this helper is then in turn used into a new pci_epc_map() function which does
>> mem alloc + mapping in one go based on the EPC constraints. That hides all
>> alignment details to the function drivers, which greatlyu simplyfies the code.
>> But that is not enough as alignment also implies that we have to deal with
>> boundaries (due to limited window size) and so sometimes endpu failing a mapping
>> that is too large because the host used a PCI address close to the boundary.
>> More work is needed to have pci_epc_map() also hide that with tricks like
>> allowing the allocation and mapping of multiple contiguous windows. So EPC ops
>> API changes are also needed.
> 
> Could you submit the your changes if you can?
> 
> I'd like to solve the current EPC limitation for the mapping in a better 
> way and avoid doing similar work.

Will try to cleanup my patches and send an RFC next week. Need to rebase,
cleanup etc. Not sure I can make it soon as I am busy with other things for 6.5
right now.

You can have a look at the work in progress here:

https://github.com/damien-lemoal/linux/tree/rockpro64_ep_v21

There are a bunch of epf and epc core patches as well as some rockchip driver
patches. The first half of the patches on top of Linus 6.3 tag patch are already
in pci-next.


-- 
Damien Le Moal
Western Digital Research

