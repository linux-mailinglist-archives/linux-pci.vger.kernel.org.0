Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3005F3634
	for <lists+linux-pci@lfdr.de>; Mon,  3 Oct 2022 21:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJCTS6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Oct 2022 15:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJCTSz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Oct 2022 15:18:55 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438804455C;
        Mon,  3 Oct 2022 12:18:53 -0700 (PDT)
Message-ID: <22471e26-0451-2b78-2f5d-67aedc7d0736@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664824731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZmrooAX70B2MCYDwxNzhdWm1o6YdhfzH3yv+vtktIM=;
        b=sxu4kiOr88B9gOMoohG9ShlHf/1ODhllNpVg21R/Scae77XWzZ0NeXj1gU5SxxeyPsvXnF
        2hp9fl+WU4k+To3o1S8dr0Pm3/Wm781HC023GKicRwzpQri48Xqj8lkc2Mr745Sl/PrFtx
        1K/gowL1h8atrTosyCNZMQy7gs3opTY=
Date:   Mon, 3 Oct 2022 13:18:47 -0600
MIME-Version: 1.0
Subject: Re: [PATCH V1 0/4] GPIO based PCIe Hot-Plug support
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, jszhang@kernel.org,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
References: <2a465222-342a-418b-95af-9948f6ce9065@linux.dev>
 <20221003180949.GA2104321@bhelgaas> <20221003182147.jp5gn2jpnf4gucdl@pali>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20221003182147.jp5gn2jpnf4gucdl@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/3/2022 12:21 PM, Pali Rohár wrote:
> On Monday 03 October 2022 13:09:49 Bjorn Helgaas wrote:
>> On Sat, Oct 01, 2022 at 05:50:07PM -0600, Jonathan Derrick wrote:
>>> On 10/1/2022 10:20 AM, Pali Rohár wrote:
>>> ...
>>
>>>> Would not it better to rather synthesise PCIe Slot Capabilities support
>>>> in your PCIe Root Port device (e.g. via pci-bridge-emul.c) and then let
>>>> existing PCI hotplug code to take care for hotplugging? Because it
>>>> already implements all required stuff for re-scanning, registering and
>>>> unregistering PCIe devices for Root Ports with Slot Capabilities. And I
>>>> think that there is no need to have just another (GPIO based)
>>>> implementation of PCI hotplug.
>>>
>>> I did that a few years ago (rejected), but can attest to the robustness of
>>> the pcie hotplug code on non-hotplug slots.
>>> https://lwn.net/Articles/811988/
>>
>> I think the thread is here:
>> https://lore.kernel.org/linux-pci/1581120007-5280-1-git-send-email-jonathan.derrick@intel.com/
>> and I'm sorry that my response came across as "rejected".  I intended
>> it as "this is good ideas and good work and we should keep going".
>>
>> Bjorn
> 
> Nice! So we have consensus that this is a good idea. Anyway, if you need
> help with designing something here, please let me know as I have good
> understanding of all (just two) consumers of pci-bridge-emul.c driver.

I haven't looked at the changes required to conform to 6.0. My 
implementation was more or less a filter driver on top of the pciehp 
slot (if it existed or had to be emulated). It's not really a hack for 
anything and was intended for use with an interposer to a bunch of M.2 
that a OEM wanted to hotplug without adding slot hardware. (Yes I know 
M.2 is not technically hot-pluggable. OEM ended up with sysfs managed 
hotplug with this patchset).

But there are systems out there with U.2 without slot logic that could 
likely survive the event gracefully, given that modern CPUs expect this 
thing in the same way that modern kernels don't rely on Surprise+.


My implementation is a bit of overkill if we'd want to strip it from the 
gpio implementation. If we want to include and extend it, we can make 
the gpio_isr another caller of pciehp_ist() (via [1])

[1] 
https://lore.kernel.org/linux-pci/1581120007-5280-7-git-send-email-jonathan.derrick@intel.com/
