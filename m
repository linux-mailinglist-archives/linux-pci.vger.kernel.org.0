Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435DF6FDE5B
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 15:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjEJNSW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 09:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbjEJNSV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 09:18:21 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1998E9EE9;
        Wed, 10 May 2023 06:18:09 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34ADHqn0008399;
        Wed, 10 May 2023 08:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683724672;
        bh=e04CwVGEcYcZioFWK5DNhxUsu5YL8S/UKSIPmLEP1PY=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=PnVxA6OrVMYMncIUBXh2q16QlEakh7HOMHzC5f46OuAKMud72GmxqncdACQLe1Qts
         DLn1DDNyj5mbgLZPaNTphJ0/J/5UmoTuDCmtCY/dIT9ygfj+jxEKRljWv4A9nYVuW9
         3qJUWEyz5NcJ0GEbpbLCXsXZufky1jTM7167iIKw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34ADHq9b043784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 May 2023 08:17:52 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 May 2023 08:17:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 May 2023 08:17:51 -0500
Received: from [10.249.138.110] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34ADHlia007546;
        Wed, 10 May 2023 08:17:48 -0500
Message-ID: <0ef69859-7ff9-1988-3c7e-692d8692b59f@ti.com>
Date:   Wed, 10 May 2023 18:47:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
CC:     <tjoseph@cadence.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>, <nadeem@cadence.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>, <nm@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] PCI: cadence: Fix Gen2 Link Retraining process
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20230509182416.GA1259841@bhelgaas>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230509182416.GA1259841@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 09-05-2023 23:54, Bjorn Helgaas wrote:
> On Tue, May 09, 2023 at 12:37:31PM +0530, Siddharth Vadapalli wrote:
>> Bjorn,
>>
>> Thank you for reviewing the patch.
>>
>> On 09/05/23 02:44, Bjorn Helgaas wrote:
>>> On Wed, Mar 15, 2023 at 12:38:00PM +0530, Siddharth Vadapalli wrote:
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
>>>> Changes from v1:
>>>> 1. Collect Reviewed-by tag from Vignesh Raghavendra.
>>>> 2. Rebase on next-20230315.
>>>>
>>>> v1:
>>>> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com
>>>>
>>>>  .../controller/cadence/pcie-cadence-host.c    | 27 +++++++++++++++++++
>>>>  1 file changed, 27 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>>> index 940c7dd701d6..5b14f7ee3c79 100644
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
>>>> @@ -77,6 +79,27 @@ static struct pci_ops cdns_pcie_host_ops = {
>>>>  	.write		= pci_generic_config_write,
>>>>  };
>>>>  
>>>> +static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
>>>
>>> This is kind of weird because it's named like a predicate, i.e., "this
>>> function tells me whether link training is complete", but it returns
>>> *zero* for success.
>>>
>>> This is the opposite of j721e_pcie_link_up(), which returns "true"
>>> when the link is up, so code like this reads naturally:
>>>
>>>   if (pcie->ops->link_up(pcie))
>>>     /* do something if the link is up */
>>
>> I agree. The function name can be changed to indicate that it is
>> waiting for completion rather than indicating completion. If this is
>> the only change, I will post a patch to fix it. On the other hand,
>> based on your comments in the next section, I am thinking of an
>> alternative approach of merging the current
>> "cdns_pcie_host_training_complete()" function's operation as well
>> into the "cdns_pcie_host_wait_for_link()" function. If this is
>> acceptable, I will post a different patch and the name change patch
>> won't be necessary.
> 
> Yeah, sorry, I meant to delete this part of my response after I wrote
> the one below.
> 
>>>> @@ -118,6 +141,10 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
>>>>  		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
>>>>  				    lnk_ctl);
>>>>  
>>>> +		ret = cdns_pcie_host_training_complete(pcie);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>>  		ret = cdns_pcie_host_wait_for_link(pcie);
>>>
>>> It seems a little clumsy that we wait for two things in succession:
>>>
>>>   - cdns_pcie_host_training_complete() waits up to 1s for
>>>     PCI_EXP_LNKSTA_LT to be cleared
>>>
>>>   - cdns_pcie_host_wait_for_link() waits between .9s and 1s for
>>>     LINK_UP_DL_COMPLETED on j721e (and not at all for other platforms)
>>
>> Is it acceptable to merge "cdns_pcie_host_training_complete()" into
>> "cdns_pcie_host_wait_for_link()"?
> 
> That's what I'm proposing.  Maybe someone who is more familiar with
> Cadence would have an argument against it, but I think making it
> structurally the same as dw_pcie_wait_for_link() would be a good
> thing.

Thank you for the confirmation. I will work on it and post a patch.

> 
> Bjorn

-- 
Regards,
Siddharth.
