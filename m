Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A17649AC4
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 10:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiLLJLi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 04:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiLLJLb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 04:11:31 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6571BDA5;
        Mon, 12 Dec 2022 01:11:28 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BC9BFNp117905;
        Mon, 12 Dec 2022 03:11:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670836275;
        bh=qrghgj2x4XgMN8Xg7u87z1CTWxhDQ+BXpGIAKdAcvGQ=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=vQJZQgFRbQUnfrmI9oLHTc4jP8owd+DSz6BWAsINh1+f8c5GnJUwXneoxLv8ygLXc
         i0GTpWf3KY6mmTxZxuT1SxoNBFyQCNC++9TiEHI8OLSi7Slelfez/z++MW/svaYh9S
         GBNo6vVVIklRDiigo/Se2DpxFSNQ0lWb+VB/ACt0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BC9BFrX065600
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Dec 2022 03:11:15 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 12
 Dec 2022 03:11:15 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 12 Dec 2022 03:11:15 -0600
Received: from [172.24.145.61] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BC9BC4T060165;
        Mon, 12 Dec 2022 03:11:13 -0600
Message-ID: <faa13ac2-27b6-94f3-ecde-60256bbbda1b@ti.com>
Date:   Mon, 12 Dec 2022 14:41:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI/ASPM: Wait for data link active after retraining
To:     Nathan Rossi <nathan@nathanrossi.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20221108222944.GA504625@bhelgaas>
 <20221109173454.GA567052@bhelgaas>
 <CA+aJhH2EEE_n5T0PAcOr5RQbfOzEKF67ckcWMTbP_NesQ5ggtw@mail.gmail.com>
Content-Language: en-US
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <CA+aJhH2EEE_n5T0PAcOr5RQbfOzEKF67ckcWMTbP_NesQ5ggtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On 14/11/22 09:29, Nathan Rossi wrote:
> On Thu, 10 Nov 2022 at 03:34, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> [+cc Maciej for similar retrain issue]
>>
>> On Tue, Nov 08, 2022 at 04:29:44PM -0600, Bjorn Helgaas wrote:
>>> On Thu, Jun 02, 2022 at 06:55:44AM +0000, Nathan Rossi wrote:
>>>> From: Nathan Rossi <nathan.rossi@digi.com>
>>>>
>>>> When retraining the link either the child or the parent device may have
>>>> the data link layer state machine of the respective devices move out of
>>>> the active state despite the physical link training being completed.
>>>> Depending on how long is takes for the devices to return to the active
>>>> state, the device may not be ready and any further reads/writes to the
>>>> device can fail.
>>>>
>>>> This issue is present with the pci-mvebu controller paired with a device
>>>> supporting ASPM but without advertising the Slot Clock, where during
>>>> boot the pcie_aspm_cap_init call would cause common clocks to be made
>>>> consistent and then retrain the link. However the data link layer would
>>>> not be active before any device initialization (e.g. ASPM capability
>>>> queries, BAR configuration) causing improper configuration of the device
>>>> without error.
>>>>
>>>> To ensure the child device is accessible, after the link retraining use
>>>> pcie_wait_for_link to perform the associated state checks and any needed
>>>> delays.
>>>>
>>>> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
>>>> ---
>>>>  drivers/pci/pcie/aspm.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>> index a96b7424c9..4b8a1810be 100644
>>>> --- a/drivers/pci/pcie/aspm.c
>>>> +++ b/drivers/pci/pcie/aspm.c
>>>> @@ -288,7 +288,8 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>>>>             reg16 &= ~PCI_EXP_LNKCTL_CCC;
>>>>     pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>>>>
>>>> -   if (pcie_retrain_link(link))
>>>> +   /* Retrain link and then wait for the link to become active */
>>>> +   if (pcie_retrain_link(link) && pcie_wait_for_link(parent, true))
>>>
>>> pcie_retrain_link() waits for PCI_EXP_LNKSTA_LT (Link Training) to be
>>> cleared, which means the LTSSM has exited the Configuration/Recovery
>>> state.  pcie_wait_for_link() waits for PCI_EXP_LNKSTA_DLLLA (Data Link
>>> Layer Link Active) to be set, which means the link is in DL_Active.
>>>
>>> I don't see an explicit procedure in the spec for determining when
>>> a link retrain is complete, but from PCIe r6.0, sec 6.2.11 (DPC):
>>>
>>>   After software releases the Downstream Port from DPC, the Port’s
>>>   LTSSM must transition to the Detect state, where the Link will
>>>   attempt to retrain. Software can use Data Link Layer State Changed
>>>   interrupts, DL_ACTIVE ERR_COR signaling, or both, to signal when the
>>>   Link reaches the DL_Active state again.
>>>
>>> and sec 6.6:
>>>
>>>   On the completion of Link Training (entering the DL_Active state,
>>>   see Section 3.2), a component must be able to receive and process
>>>   TLPs and DLLPs.
>>>
>>> The only use mentioned in the spec for the Link Training bit is the
>>> implementation note in sec 7.5.3.7 about avoiding race conditions when
>>> using the Retrain Link bit, where software should poll Link Training
>>> until it returns to zero before setting the Retrain Link bit to change
>>> link parameters.
>>>
>>> And I think you're absolutely right that what we *want* here is the
>>> data link layer DL_Active state, not just the link layer L0 state.
>>>
>>> This all makes me think that checking the Link Training bit might be
>>> the wrong thing to begin with.
>>>
>>> Of course, the Data Link Layer Link Active bit wasn't added until PCIe
>>> r1.1, and even now it's optional.  Without it, I don't know if there's
>>> a way to make sure the link is in DL_Active.
> 
> My understanding is there is no way to check for the DL_Active state
> on these devices. Which is why pcie_wait_for_link_delay uses a fixed
> delay in that case.

In TI's J721E SoC, the PCIe controller doesn't report the Data Link
State. The bit is hardwired to zero. However, the status of the Data
Link is reported via a set of user specific registers, which aren't a
part of the standard PCIe registers. With this, I was able to observe
that despite the PCI_EXP_LNKSTA_LT bit being cleared, the Data Link
initialization was still ongoing. This leads to a race condition if it
isn't ensured that the Data Link initialization is complete before the
PCI core attempts to obtain the configuration space addresses via the
map_bus call. Based on the scheduling, it is possible for the kernel to
crash, and I was able to observe this in my setup.

With this patch applied, the issue is fixed.

Tested-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
