Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A32727BF5
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 11:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbjFHJyc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 05:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbjFHJy2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 05:54:28 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1325E62;
        Thu,  8 Jun 2023 02:54:25 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3589rs1L025077;
        Thu, 8 Jun 2023 04:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686218034;
        bh=6+5fwS0JDLD0KpIfX92CwlorVGpMYUaNA0VFqOEMhNI=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=KPY3n4bjyOvBlcWpZyjASdmuZC7bWMc7M9eXaNxaMpHIXNRoPMtqBED4t/0gov+cG
         Dq0vdy8e/64lLSxJ/kTSVA11T94woTCWemEw9GE4BbYfx9WviFeqsUmdM0cfOfgzsi
         RSFS54vAF1LyNMy48aG4geCt03ULfOSgOwqUWtcw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3589rsXB042352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Jun 2023 04:53:54 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Jun 2023 04:53:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Jun 2023 04:53:54 -0500
Received: from [172.24.145.61] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3589rob1031680;
        Thu, 8 Jun 2023 04:53:50 -0500
Message-ID: <e9e1543f-0f38-89ed-f179-71ac8724f4e0@ti.com>
Date:   Thu, 8 Jun 2023 15:23:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
CC:     <tjoseph@cadence.com>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <nadeem@cadence.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>, <nm@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3] PCI: cadence: Fix Gen2 Link Retraining process
Content-Language: en-US
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <20230607091427.852473-1-s-vadapalli@ti.com>
 <ZIBanRGGPeFw90NZ@lpieralisi> <5888f3ff-bc95-16ed-3cae-958719d87874@ti.com>
 <ZIGi9Tfk7hemFIM6@lpieralisi>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <ZIGi9Tfk7hemFIM6@lpieralisi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 08/06/23 15:14, Lorenzo Pieralisi wrote:
> On Thu, Jun 08, 2023 at 09:31:59AM +0530, Siddharth Vadapalli wrote:
>> Hello Lorenzo,
>>
>> Thank you for reviewing this patch.
>>
>> On 07/06/23 15:53, Lorenzo Pieralisi wrote:
>>> On Wed, Jun 07, 2023 at 02:44:27PM +0530, Siddharth Vadapalli wrote:
>>>> The Link Retraining process is initiated to account for the Gen2 defect in
>>>> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
>>>> is i2085, documented at:
>>>> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
>>>>
>>>> The existing workaround implemented for the errata waits for the Data Link
>>>> initialization to complete and assumes that the link retraining process
>>>> at the Physical Layer has completed. However, it is possible that the
>>>> Physical Layer training might be ongoing as indicated by the
>>>> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
>>>>
>>>> Fix the existing workaround, to ensure that the Physical Layer training
>>>> has also completed, in addition to the Data Link initialization.
>>>>
>>>> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
>>>> ---
>>>>
>>>> Hello,
>>>>
>>>> This patch is based on linux-next tagged next-20230606.
>>>>
>>>> v2:
>>>> https://lore.kernel.org/r/20230315070800.1615527-1-s-vadapalli@ti.com/
>>>> Changes since v2:
>>>> - Merge the cdns_pcie_host_training_complete() function with the
>>>>   cdns_pcie_host_wait_for_link() function, as suggested by Bjorn
>>>>   for the v2 patch.
>>>> - Add dev_err() to notify when Link Training fails, since this is a
>>>>   fatal error and proceeding from this point will almost always crash
>>>>   the kernel.
>>>>
>>>> v1:
>>>> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com/
>>>> Changes since v1:
>>>> - Collect Reviewed-by tag from Vignesh Raghavendra.
>>>> - Rebase on next-20230315.
>>>>
>>>> Regards,
>>>> Siddharth.
>>>>
>>>>  .../controller/cadence/pcie-cadence-host.c    | 20 +++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>> index 940c7dd701d6..70a5f581ff4f 100644
>>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>> @@ -12,6 +12,8 @@
>>>>  
>>>>  #include "pcie-cadence.h"
>>>>  
>>>> +#define LINK_RETRAIN_TIMEOUT HZ
>>>> +
>>>>  static u64 bar_max_size[] = {
>>>>  	[RP_BAR0] = _ULL(128 * SZ_2G),
>>>>  	[RP_BAR1] = SZ_2G,
>>>> @@ -80,8 +82,26 @@ static struct pci_ops cdns_pcie_host_ops = {
>>>>  static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
>>>>  {
>>>>  	struct device *dev = pcie->dev;
>>>> +	unsigned long end_jiffies;
>>>> +	u16 link_status;
>>>>  	int retries;
>>>>  
>>>> +	/* Wait for link training to complete */
>>>> +	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
>>>> +	do {
>>>> +		link_status = cdns_pcie_rp_readw(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKSTA);
>>>> +		if (!(link_status & PCI_EXP_LNKSTA_LT))
>>>> +			break;
>>>
>>> You can use a bool variable eg link_trained and use that below.
>>
>> Sure, I will do that. link_trained = !(link_status & PCI_EXP_LNKSTA_LT); within
>> the do-while loop and checking for it to be true in the loop as well as below.
>>
>>>
>>>> +		usleep_range(0, 1000);
>>>> +	} while (time_before(jiffies, end_jiffies));
>>>> +
>>>> +	if (!(link_status & PCI_EXP_LNKSTA_LT)) {
>>>> +		dev_info(dev, "Link training complete\n");
>>>> +	} else {
>>>> +		dev_err(dev, "Fatal! Link training incomplete\n");
>>>> +		return -ETIMEDOUT;
>>>> +	}
>>>
>>> I don't necessarily see the reason why you are adding additional
>>> logging, more so given that this now does not affect just the
>>> workaround but all cadence controllers.
>>>
>>> Actually, is that something you have tested and considered ?
>>
>> While I agree that I could have performed the entire Link Training check only if
>> the Gen2 Link Retraining Quirk is set for the RC, considering that the
>> completion of the Link Training is a necessity irrespective of whether or not
>> the Quirk exists, I preferred to add the check unconditionally. I would like to
>> point out that the race condition responsible for the crash is the following:
>> Without the completion of the Physical Layer link training, the call to the
>> cdns_pci_map_bus() function in order to access the End Point's registers (if an
>> EP device is connected) results in the crash. This is primarily observed only on
>> RT Linux where the software call to cdns_pci_map_bus() by PCI subsystem occurs
>> quite fast, before the Physical Layer link training is complete. For this
>> reason, irrespective of whether the Physical Layer link training occurs only
>> once because of the default flow or occurs a second time due to the Gen2 Link
>> Retraining Quirk, it appears to me that the crash could potentially occur in
>> both cases if we don't wait for the Physical Layer link training to complete.
> 
> This means that you are fixing the controller code for all Cadence platforms
> and current code is broken (I am not really sure what you mean wrt RT Linux
> - please elaborate, this does not sound good to me at all), so the
> commit log must be rewritten.

By RT Linux, I am referring to Linux with Real Time configs enabled such as
PREEMPT_RT, which results in faster code execution and lower latency.
All along, it appears to be the case that with the Link Training initiated in
PCIe controller hardware, the driver proceeds to finish the probe and therefore
allow the PCI core subsystem to perform enumeration. However, as it turns out,
the driver appears to have been depending on the latency of other processes
running in the background, due to which the device enumeration process by the
PCI core subsystem got delayed, thereby ensuring that the Link Training process
in the PCIe controller hardware had successfully finished by that point in time.
With RT configs, that latency has been reduced, resulting in the bus enumeration
process starting off much earlier, and occurring while the PCIe controller is
still performing Link Training.

> 
>> Please let me know if this sounds acceptable. If not, I will check if the quirk
>> is set before proceeding to verify link training completion and implement this
>> in the v4 patch.
> 
> Not only this is acceptable but that's what you should do. Current code
> relies on assumptions (that you will have to explain to me please) wrt
> link training and that's not OK.

Please let me know if further clarification is required in addition to my
comment above.

> 
> Lorenzo
> 
>>
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>>> +
>>>>  	/* Check if the link is up or not */
>>>>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>>>>  		if (cdns_pcie_link_up(pcie)) {
>>>> -- 
>>>> 2.25.1
>>>>
>>
>> -- 
>> Regards,
>> Siddharth.

-- 
Regards,
Siddharth.
