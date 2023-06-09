Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DD0728ED7
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 06:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjFIEQr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 00:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFIEQq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 00:16:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A9C2D7F;
        Thu,  8 Jun 2023 21:16:44 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3594GP5Y054485;
        Thu, 8 Jun 2023 23:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686284185;
        bh=CCePwZwBhlOsXVvV2dy4MFyfufTvLyRUAKY7YxDnfXQ=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=fwxev6BzsxjSgiTur3fQUlmZVSYirfqR+wZBEu7ZvTEKX8DpsSNXUiuDLRqrxxwrw
         TzVPMSZxyxgdTdbmT4BLDnhTOafwoVEYQOKP6xxWhVOfrKlUSjC+9bwoG44e3RqG8u
         dYTQLbtv4r6Dsr2IJkrilRqoLe0lJ9iOhYhdojSc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3594GPYu129857
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Jun 2023 23:16:25 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Jun 2023 23:16:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Jun 2023 23:16:25 -0500
Received: from [172.24.145.61] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3594GLIf108488;
        Thu, 8 Jun 2023 23:16:21 -0500
Message-ID: <67865af6-7ea4-63e3-6c35-4cd038f36af3@ti.com>
Date:   Fri, 9 Jun 2023 09:46:20 +0530
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
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230608154206.GI5672@thinkpad>
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

Hello Mani,

Thank you for reviewing this patch.

On 08/06/23 21:12, Manivannan Sadhasivam wrote:
> On Wed, Jun 07, 2023 at 02:44:27PM +0530, Siddharth Vadapalli wrote:
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
> 
> cdns_pcie_host_wait_for_link() function is called even for the non-quirky cases
> as well, so does this patch. But if your patch is only targeting the link
> retraining case, you should move the logic to cdns_pcie_retrain().

In the v2 version of this patch at:
https://lore.kernel.org/r/20230315070800.1615527-1-s-vadapalli@ti.com/
I had implemented it as suggested above by you. However, based on the discussion
with Bjorn at:
https://lore.kernel.org/r/20230509182416.GA1259841@bhelgaas/
it was agreed upon that waiting for two things in succession doesn't seem to be
the best way to implement it. Therefore, the cdns_pcie_host_training_complete()
function in the v2 patch is merged into the cdns_pcie_host_wait_for_link()
function in this patch.

> 
> 
>> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>
>> Hello,
>>
>> This patch is based on linux-next tagged next-20230606.
>>
>> v2:
>> https://lore.kernel.org/r/20230315070800.1615527-1-s-vadapalli@ti.com/
>> Changes since v2:
>> - Merge the cdns_pcie_host_training_complete() function with the
>>   cdns_pcie_host_wait_for_link() function, as suggested by Bjorn
>>   for the v2 patch.
>> - Add dev_err() to notify when Link Training fails, since this is a
>>   fatal error and proceeding from this point will almost always crash
>>   the kernel.
>>
>> v1:
>> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com/
>> Changes since v1:
>> - Collect Reviewed-by tag from Vignesh Raghavendra.
>> - Rebase on next-20230315.
>>
>> Regards,
>> Siddharth.
>>
>>  .../controller/cadence/pcie-cadence-host.c    | 20 +++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 940c7dd701d6..70a5f581ff4f 100644
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
>> @@ -80,8 +82,26 @@ static struct pci_ops cdns_pcie_host_ops = {
>>  static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
>>  {
>>  	struct device *dev = pcie->dev;
>> +	unsigned long end_jiffies;
>> +	u16 link_status;
>>  	int retries;
>>  
>> +	/* Wait for link training to complete */
>> +	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
>> +	do {
>> +		link_status = cdns_pcie_rp_readw(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKSTA);
>> +		if (!(link_status & PCI_EXP_LNKSTA_LT))
>> +			break;
>> +		usleep_range(0, 1000);
>> +	} while (time_before(jiffies, end_jiffies));
>> +
>> +	if (!(link_status & PCI_EXP_LNKSTA_LT)) {
>> +		dev_info(dev, "Link training complete\n");
> 
> This info is not needed.

Sure. I will drop it in the v4 patch.

> 
>> +	} else {
>> +		dev_err(dev, "Fatal! Link training incomplete\n");
> 
> This could be, "Link retraining incomplete".

I added the word "Fatal" since Linux is almost always guaranteed to crash if the
link training doesn't complete before the PCI subsystem attempts to enumerate
the EP devices. Therefore, adding the word "Fatal" will help the users identify
what the cause of the crash is, which would otherwise be overlooked, unless the
critical nature of this error is conveyed to the user.

> 
> - Mani
> 
>> +		return -ETIMEDOUT;
>> +	}
>> +
>>  	/* Check if the link is up or not */
>>  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>>  		if (cdns_pcie_link_up(pcie)) {
>> -- 
>> 2.25.1
>>
> 

-- 
Regards,
Siddharth.
