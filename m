Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05DF3E9026
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 14:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbhHKMIE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 08:08:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48330 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbhHKMID (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 08:08:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17BC7QVK006232;
        Wed, 11 Aug 2021 07:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628683646;
        bh=KjpVc4pTn7uSq3ISvTFRGUJK5IcJ7G970jUpRo1ZtFw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sH+VGD2SL+CXM6XV3vyAje+AiHwrTREJTneuvTjNXV0tfP/27FTt3v9JiZEw51fSm
         BgMPKpyDTqA2MfYIuNVNc/5tyqjzlmoJEL8Y3kLj2yCcOanb7zBImnQmdTTl4EV36M
         u+1swRmdsnblblAwrHZ5GVIPc33syZ80PeYBJef8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17BC7QRU083377
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 07:07:26 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 07:07:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 07:07:26 -0500
Received: from [10.250.151.119] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17BC7KUI038229;
        Wed, 11 Aug 2021 07:07:21 -0500
Subject: Re: [PATCH v2 2/3] PCI: j721e: Add PCI legacy interrupt support for
 J721E
To:     Marc Zyngier <maz@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tom Joseph <tjoseph@cadence.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210804132912.30685-1-kishon@ti.com>
 <20210804132912.30685-3-kishon@ti.com> <87h7g5w8d8.wl-maz@kernel.org>
 <c20be7ae-e4a7-c3ba-f1c9-e4ff2aae0a66@ti.com> <87o8a7arew.wl-maz@kernel.org>
 <7646c75e-29de-1edc-225c-57feeaa80118@ti.com> <875ywdbhta.wl-maz@kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9638f916-d0da-9c0e-6f01-b90c986decfd@ti.com>
Date:   Wed, 11 Aug 2021 17:37:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875ywdbhta.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 10/08/21 6:03 pm, Marc Zyngier wrote:
> On Mon, 09 Aug 2021 15:58:38 +0100,
> Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Marc,
>>
>> On 09/08/21 3:09 pm, Marc Zyngier wrote:
>>> On Mon, 09 Aug 2021 05:50:10 +0100,
>>> Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>>
>>>> Hi Marc,
>>>>
>>>> On 04/08/21 8:43 pm, Marc Zyngier wrote:
>>>>> On Wed, 04 Aug 2021 14:29:11 +0100,
>>>>> Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>>>>
>>>>>> Add PCI legacy interrupt support for J721E. J721E has a single HW
>>>>>> interrupt line for all the four legacy interrupts INTA/INTB/INTC/INTD.
>>>>>> The HW interrupt line connected to GIC is a pulse interrupt whereas
>>>>>> the legacy interrupts by definition is level interrupt. In order to
>>>>>> provide level interrupt functionality to edge interrupt line, PCIe
>>>>>> in J721E has provided IRQ_EOI register.
>>>>>>
>>>>>> However due to Errata ID #i2094 ([1]), EOI feature is not enabled in HW
>>>>>> and only a single pulse interrupt will be generated for every
>>>>>> ASSERT_INTx/DEASSERT_INTx.
>>>>>
>>>>> So my earlier remark stands. If you get a single edge, how do you
>>>>> handle a level that is still high after having handled the interrupt
>>>>> on hardware that has this bug?
>>>>
>>>> Right, this hardware (J721E) has a bug but was fixed in J7200 (Patch 3/3
>>>> handles that).
>>>
>>> But how do you make it work with J721E? Is it even worth supporting if
>>> (as I expect) it is unreliable?
>>
>> I've seen at-least the NVMe devices triggers the interrupts again and
>> the data transfer completes. But I agree, this is unreliable.
> 
> Then I don't think you should add INTx support for this system. It is
> bound to be a support burden, and will reflect badly on the whole
> platform. Focusing on J7200 is probably the best thing to do.

Okay, will drop this patch from the series and have INTx support only
for J7200.

Thanks
Kishon
