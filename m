Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A9728FED
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 08:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjFIG3d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 02:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFIG3c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 02:29:32 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645CA1BDF;
        Thu,  8 Jun 2023 23:29:30 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3596TEFh066166;
        Fri, 9 Jun 2023 01:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686292154;
        bh=DYYqo4zPKH1HSJq+p/LTNQyqEXppjLh0B0eUMMGbySE=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=UwC+dIgV8bWckwBBG/cQCsXAKrog6wgzeJjP1FEgyqRfzYBMK/QUIcsV7uoR/cb4o
         6NdA+vd2dAlICCljD3KLtiEqEii8fCQhc3ue9pgkZW3wmEHPgMKlVofYwWbAc69Y9g
         AhOG3WG4u76tAIPgKY2e6+UaHZGkkKa3my+c/rpM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3596TEKo109938
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Jun 2023 01:29:14 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Jun 2023 01:29:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Jun 2023 01:29:13 -0500
Received: from [172.24.145.61] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3596T9ik022880;
        Fri, 9 Jun 2023 01:29:10 -0500
Message-ID: <a63fc8b0-581b-897f-cac6-cb0a0e82c63e@ti.com>
Date:   Fri, 9 Jun 2023 11:59:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
CC:     <tjoseph@cadence.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>, <nadeem@cadence.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>, <nm@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3] PCI: cadence: Fix Gen2 Link Retraining process
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20230607091427.852473-1-s-vadapalli@ti.com>
 <20230608154206.GI5672@thinkpad>
 <67865af6-7ea4-63e3-6c35-4cd038f36af3@ti.com>
 <20230609055737.GA6847@thinkpad>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230609055737.GA6847@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 09/06/23 11:27, Manivannan Sadhasivam wrote:
> On Fri, Jun 09, 2023 at 09:46:20AM +0530, Siddharth Vadapalli wrote:
>> Hello Mani,
>>
>> Thank you for reviewing this patch.
>>
>> On 08/06/23 21:12, Manivannan Sadhasivam wrote:
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
>>>
>>> cdns_pcie_host_wait_for_link() function is called even for the non-quirky cases
>>> as well, so does this patch. But if your patch is only targeting the link
>>> retraining case, you should move the logic to cdns_pcie_retrain().
>>
>> In the v2 version of this patch at:
>> https://lore.kernel.org/r/20230315070800.1615527-1-s-vadapalli@ti.com/
>> I had implemented it as suggested above by you. However, based on the discussion
>> with Bjorn at:
>> https://lore.kernel.org/r/20230509182416.GA1259841@bhelgaas/
>> it was agreed upon that waiting for two things in succession doesn't seem to be
>> the best way to implement it. Therefore, the cdns_pcie_host_training_complete()
>> function in the v2 patch is merged into the cdns_pcie_host_wait_for_link()
>> function in this patch.
>>
> 
> I think Bjorn's point was to make the wait_for_link() behavior same across
> drivers. While I agree with that, I'd like to know whether adding this wait for
> all cases (not just during link retraining quirk) adds up any latency or not.
> 
> Can you measure that?

For J7200 SoC which doesn't have the link retraining quirk set, I added prints
before and after the exact section of newly added code with this patch. The
output with timestamps for the case where no EP is connected to the board is:
[    1.350061] j721e-pcie 2910000.pcie: <1> Before link training check
[    1.356324] j721e-pcie 2910000.pcie: Link training complete
[    1.361883] j721e-pcie 2910000.pcie: <1> After link training check
indicating a latency of about 12 milliseconds.

On the other hand, with an EP device connected, the output is:
[    1.349822] j721e-pcie 2910000.pcie: <1> Before link training check
[    1.356083] j721e-pcie 2910000.pcie: Link training complete
[    1.361641] j721e-pcie 2910000.pcie: <1> After link training check
again indicating a latency of about 12 milliseconds.

For the J721e SoC which has the quirk, without an EP device connected, the
output is:
[    2.668926] j721e-pcie 2910000.pcie: <1> Before link training check
[    2.675178] j721e-pcie 2910000.pcie: Link training complete
[    2.680734] j721e-pcie 2910000.pcie: <1> After link training check
with the latency again being about 12 milliseconds.

Now, with the EP device connected to the board with J721e SoC, the output for
the training phase is:
[    2.685335] j721e-pcie 2910000.pcie: <1> Before link training check
[    2.691592] j721e-pcie 2910000.pcie: Link training complete
[    2.697150] j721e-pcie 2910000.pcie: <1> After link training check
and for the retraining phase is:
[    2.807581] j721e-pcie 2910000.pcie: <1> Before link training check
[    2.831578] j721e-pcie 2910000.pcie: LINK DOWN!
[    2.831905] j721e-pcie 2910000.pcie: Link training complete
[    2.841653] j721e-pcie 2910000.pcie: <1> After link training check
During the training phase, the latency again is about 12 milliseconds, while
during the retraining phase, the latency is about 34 milliseconds.

Note, the above latency is measured for the Non-RT Linux kernel, with the
assumption that the latency will be lower for the RT Linux kernel.

I suppose this indicates a latency of about 12 milliseconds for the PCIe
controllers without the Gen2 Link Retraining quirk, while for the PCIe
controller with the Gen2 Link Retraining quirk, it is a net latency of 12+34
milliseconds = 46 milliseconds for the training and retraining phases.

> 
>>>
>>>
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
>>>> +		usleep_range(0, 1000);
>>>> +	} while (time_before(jiffies, end_jiffies));
>>>> +
>>>> +	if (!(link_status & PCI_EXP_LNKSTA_LT)) {
>>>> +		dev_info(dev, "Link training complete\n");
>>>
>>> This info is not needed.
>>
>> Sure. I will drop it in the v4 patch.
>>
>>>
>>>> +	} else {
>>>> +		dev_err(dev, "Fatal! Link training incomplete\n");
>>>
>>> This could be, "Link retraining incomplete".
>>
>> I added the word "Fatal" since Linux is almost always guaranteed to crash if the
>> link training doesn't complete before the PCI subsystem attempts to enumerate
>> the EP devices. Therefore, adding the word "Fatal" will help the users identify
>> what the cause of the crash is, which would otherwise be overlooked, unless the
>> critical nature of this error is conveyed to the user.
>>
> 
> Ok.
> 
> - Mani
> 
>>>
>>> - Mani
>>>
>>>> +		return -ETIMEDOUT;
>>>> +	}
>>>> +
>>>>  	/* Check if the link is up or not */
>>>>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>>>>  		if (cdns_pcie_link_up(pcie)) {
>>>> -- 
>>>> 2.25.1
>>>>
>>>
>>
>> -- 
>> Regards,
>> Siddharth.
> 

-- 
Regards,
Siddharth.
