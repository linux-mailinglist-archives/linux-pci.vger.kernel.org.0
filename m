Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C07E4E310E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 21:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbiCUUIO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 16:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiCUUIN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 16:08:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E53749CAE;
        Mon, 21 Mar 2022 13:06:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08A961042;
        Mon, 21 Mar 2022 13:06:47 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391603F66F;
        Mon, 21 Mar 2022 13:06:45 -0700 (PDT)
Message-ID: <e52c8cbd-031b-848f-3d78-dff8b93bd416@arm.com>
Date:   Mon, 21 Mar 2022 20:06:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/2] PCI: xgene: Restore working PCIe functionnality
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@ubuntu.com>,
        dann frazier <dann.frazier@canonical.com>,
        Android Kernel Team <kernel-team@android.com>
References: <20220321104843.949645-1-maz@kernel.org>
 <CAL_JsqJacC6GbNebTfYyUEScROCFN4+Fg2v1_iYFfqAvW4E9Vw@mail.gmail.com>
 <87h77rxnyl.wl-maz@kernel.org>
 <CAL_JsqK57KpZmzCE=86dLcHK4Ws_0w0ga4_qoYUe2GwFNpDzRw@mail.gmail.com>
 <87fsnbxgau.wl-maz@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <87fsnbxgau.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-03-21 19:21, Marc Zyngier wrote:
> On Mon, 21 Mar 2022 18:03:27 +0000,
> Rob Herring <robh@kernel.org> wrote:
>>
>> On Mon, Mar 21, 2022 at 11:36 AM Marc Zyngier <maz@kernel.org> wrote:
>>>
>>> On Mon, 21 Mar 2022 15:17:34 +0000,
>>> Rob Herring <robh@kernel.org> wrote:
>>>>
>>>> On Mon, Mar 21, 2022 at 5:49 AM Marc Zyngier <maz@kernel.org> wrote:
>>>>>
>>>> For XGene-1, I'd still like to understand what the issue is. Reverting
>>>> the first fix and fixing 'dma-ranges' should have fixed it. I need a
>>>> dump of how the IB registers are initialized in both cases. I'm not
>>>> saying changing 'dma-ranges' in the firmware is going to be required
>>>> here. There's a couple of other ways we could fix that without a
>>>> firmware change, but first I need to understand why it broke.
>>>
>>> Reverting 6dce5aa59e0b was enough for me, without changing anything
>>> else.
>>
>> Meaning c7a75d07827a didn't matter for you. I'm not sure that it would.
>>
>> Can you tell me what 'dma-ranges' contains on your system?
> 
> Each pcie node (all 5 of them) has:
> 
> dma-ranges = <0x42000000 0x80 0x00 0x80 0x00 0x00 0x80000000
>                0x42000000 0x00 0x00 0x00 0x00 0x80 0x00>;

Hmm, is there anyone other than iommu-dma who actually depends on the 
resource list being sorted in ascending order of bus address? I recall 
at the time I pushed for creating the list in sorted order as it was the 
simplest and most efficient option, but there's no technical reason we 
couldn't create it in as-found order and defer the sorting until 
iova_reserve_pci_windows() (at worst that could even operate on a 
temporary copy if need be). It's just more code, which didn't need to 
exist without a good reason, but if this is one then exist it certainly may.

Cheers,
Robin.
