Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12336FC023
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 09:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjEIHH7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 03:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjEIHHy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 03:07:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A74EE43;
        Tue,  9 May 2023 00:07:52 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34977aVt054583;
        Tue, 9 May 2023 02:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683616056;
        bh=m9xWIx7fRxqM+94No2mQfJDt43t0l4QUNDEOExprT2s=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=O6sSPHZwBpVWb4ruA5xFdtMkW6yRkC2D8VvUIszHcuutnNntvJ1I1YTUY0wYEZHSu
         LzlBnPbggayfNVnQy3NvmBwZwpLpuU4Mqdk/kPx6D10cjWvx6XfvhT9nUwIrCB6d86
         iFxsG895IjPdh0SL3KX9HyNokLlaEz889bzHrOCE=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34977aur015186
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 02:07:36 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 02:07:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 02:07:36 -0500
Received: from [172.24.145.61] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34977WMT021513;
        Tue, 9 May 2023 02:07:32 -0500
Message-ID: <6dd91ab0-cc7f-45c4-bded-688bab5d6050@ti.com>
Date:   Tue, 9 May 2023 12:37:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
CC:     <tjoseph@cadence.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>, <nadeem@cadence.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>, <nm@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] PCI: cadence: Fix Gen2 Link Retraining process
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20230508211430.GA1185556@bhelgaas>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230508211430.GA1185556@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

Thank you for reviewing the patch.

On 09/05/23 02:44, Bjorn Helgaas wrote:
> On Wed, Mar 15, 2023 at 12:38:00PM +0530, Siddharth Vadapalli wrote:
>> The Link Retraining process is initiated to account for the Gen2 defect in
>> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
>> is i2085, documented at:
>> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
>>
>> The existing workaround implemented for the errata waits for the Data Link
>> initialization to complete and assumes that the link retraining process
>> at the Physical Layer has completed. However, it is possible that the
>> Physical Layer training might be ongoing as indicated by the
>> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
>>
>> Fix the existing workaround, to ensure that the Physical Layer training
>> has also completed, in addition to the Data Link initialization.
>>
>> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>> Changes from v1:
>> 1. Collect Reviewed-by tag from Vignesh Raghavendra.
>> 2. Rebase on next-20230315.
>>
>> v1:
>> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com
>>
>>  .../controller/cadence/pcie-cadence-host.c    | 27 +++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 940c7dd701d6..5b14f7ee3c79 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -12,6 +12,8 @@
>>  
>>  #include "pcie-cadence.h"
>>  
>> +#define LINK_RETRAIN_TIMEOUT HZ
>> +
>>  static u64 bar_max_size[] = {
>>  	[RP_BAR0] = _ULL(128 * SZ_2G),
>>  	[RP_BAR1] = SZ_2G,
>> @@ -77,6 +79,27 @@ static struct pci_ops cdns_pcie_host_ops = {
>>  	.write		= pci_generic_config_write,
>>  };
>>  
>> +static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
> 
> This is kind of weird because it's named like a predicate, i.e., "this
> function tells me whether link training is complete", but it returns
> *zero* for success.
> 
> This is the opposite of j721e_pcie_link_up(), which returns "true"
> when the link is up, so code like this reads naturally:
> 
>   if (pcie->ops->link_up(pcie))
>     /* do something if the link is up */

I agree. The function name can be changed to indicate that it is waiting for
completion rather than indicating completion. If this is the only change, I will
post a patch to fix it. On the other hand, based on your comments in the next
section, I am thinking of an alternative approach of merging the current
"cdns_pcie_host_training_complete()" function's operation as well into the
"cdns_pcie_host_wait_for_link()" function. If this is acceptable, I will post a
different patch and the name change patch won't be necessary.

> 
>> +{
>> +	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
>> +	unsigned long end_jiffies;
>> +	u16 lnk_stat;
>> +
>> +	/* Wait for link training to complete. Exit after timeout. */
>> +	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
>> +	do {
>> +		lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
>> +		if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
>> +			break;
>> +		usleep_range(0, 1000);
>> +	} while (time_before(jiffies, end_jiffies));
>> +
>> +	if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
>> +		return 0;
>> +
>> +	return -ETIMEDOUT;
>> +}
>> +
>>  static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
>>  {
>>  	struct device *dev = pcie->dev;
>> @@ -118,6 +141,10 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
>>  		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
>>  				    lnk_ctl);
>>  
>> +		ret = cdns_pcie_host_training_complete(pcie);
>> +		if (ret)
>> +			return ret;
>> +
>>  		ret = cdns_pcie_host_wait_for_link(pcie);
> 
> It seems a little clumsy that we wait for two things in succession:
> 
>   - cdns_pcie_host_training_complete() waits up to 1s for
>     PCI_EXP_LNKSTA_LT to be cleared
> 
>   - cdns_pcie_host_wait_for_link() waits between .9s and 1s for
>     LINK_UP_DL_COMPLETED on j721e (and not at all for other platforms)

Is it acceptable to merge "cdns_pcie_host_training_complete()" into
"cdns_pcie_host_wait_for_link()"?

> 
> dw_pcie_wait_for_link() is basically similar but has a single wait
> loop around the dw_pcie_link_up() callback.  Several of those
> callbacks check multiple things.  Can we do the same here?

I assume you are referring to merging the functions together?

> 
> Is the "host" in the cdns_pcie_host_wait_for_link() name necessary?
> Maybe it could be cdns_pcie_wait_for_link() to be similar to
> dw_pcie_wait_for_link()?  Or, if "host" is necessary, it could be
> cdns_host_pcie_wait_for_link() so it matches the same
> "pcie_wait_for_link" grep pattern as most of the others?

If the functions are merged, I believe that the word "host" can be dropped in
the new function which can be named "cdns_pcie_wait_for_link()" as suggested by you.

Please let me know.

> 
>>  	}
>>  	return ret;

-- 
Regards,
Siddharth.
