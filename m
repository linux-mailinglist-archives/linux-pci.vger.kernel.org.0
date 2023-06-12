Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A1172B65F
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 06:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjFLE04 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 00:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFLE0y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 00:26:54 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10D01A5;
        Sun, 11 Jun 2023 21:26:50 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35C4QW5m068010;
        Sun, 11 Jun 2023 23:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686543992;
        bh=VEhVRvB/ezKAemLvJsdtQR3iIrWDnvFJDWF+f5A78/c=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=XSUOuWUzCAYjvv18CrV/xcJWn2oL2C+hxzXMI/Ygf8ktLNdv2Wpx4yLWHOHjcv0+i
         95vCdxpMZUwrZLMO1BdWIKHp6TsiGIvqd5Gxo6J83WFKp7sy+5t4OQPjQQvoXwSUk4
         M7EKV1jhWQ1ntF4A7ThN8lirPoaHJwaV/I3XtIQ0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35C4QWsw022109
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Jun 2023 23:26:32 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 11
 Jun 2023 23:26:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 11 Jun 2023 23:26:32 -0500
Received: from [172.24.145.61] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35C4QR6b027739;
        Sun, 11 Jun 2023 23:26:28 -0500
Message-ID: <b91f1df7-7b36-bfee-2182-44ccfb900952@ti.com>
Date:   Mon, 12 Jun 2023 09:56:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
CC:     <tjoseph@cadence.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>, <nadeem@cadence.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>, <nm@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3] PCI: cadence: Fix Gen2 Link Retraining process
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20230609173940.GA1252506@bhelgaas>
Content-Language: en-US
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230609173940.GA1252506@bhelgaas>
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



On 09/06/23 23:09, Bjorn Helgaas wrote:
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
>> +	} else {
>> +		dev_err(dev, "Fatal! Link training incomplete\n");
>> +		return -ETIMEDOUT;
>> +	}
> 
> Can I have a brown paper bag, please?  I totally blew it here, and I'm
> sorry.
> 
> You took my advice by combining this with the existing
> cdns_pcie_host_wait_for_link(), but I think my advice was poor because
> (a) now this additional wait is not clearly connected with the
> erratum, and (b) it affects devices that don't have the erratum.
> 
> IIUC, this is all part of a workaround for the i2085 erratum.  The
> original workaround, 4740b969aaf5 ("PCI: cadence: Retrain Link to work
> around Gen2 training defect"), added this:
> 
>   if (!ret && rc->quirk_retrain_flag)
>     ret = cdns_pcie_retrain(pcie);
> 
> I think the wait for link train to complete should also be in
> cdns_pcie_retrain() so it's clearly connected with the quirk, which
> also means we'd only do the wait for devices with the erratum.
> 
> Which is EXACTLY what your first patch did, and I missed it.  I am
> very sorry.  I guess maybe I thought cdns_pcie_retrain() was a
> general-purpose thing, but in fact it's only used for this quirk.

With the current approach implemented in this patch, I could do the following:
In the cdns_pcie_host_wait_for_link() function, I obtain the reference to the
struct cdns_pcie_rc *rc, using:
struct cdns_pcie_rc *rc = container_of(pcie, struct cdns_pcie_rc, pcie);
followed by checking if the quirk "quirk_retrain_flag" is set, before proceeding
with the Link Training check added by this patch. With this, only the
controllers with the quirk will check for the Link Training completion before
proceeding. However, the difference with this new approach compared to the
approach in the v2 patch is that in this new approach, even in the Link Training
Phase, the Link Training check is performed for the controllers with the quirk,
unlike the v2 patch where the Link Training check was performed only during the
Link Retraining Phase through the cdns_pcie_retrain() function.

Also, based on Mani's suggestion, I have measured the latency introduced by the
Link Training check for both quirky and non-quirky controllers at:
https://lore.kernel.org/r/a63fc8b0-581b-897f-cac6-cb0a0e82c63e@ti.com/
If the latency is acceptable, then the current implementation in this v3 patch
could be fine too.

Kindly let me know which approach among the following seems to be the best one:
1. The approach implemented in v2 patch (I will make minor changes to the patch
to print out the "Fatal" error, so that users will be informed of the cause of
the crash, followed by posting a v4 patch with this change).
2. The current implementation in the v3 patch with a check added to see if the
controller has the quirk_retrain_flag set, before proceeding with the Link
Training check.
3. The current implementation in the v3 patch as is, without any modification,
if the latency introduced is not a concern and the sanity check for Link
Training completion for non-quirky controllers appears acceptable.

> 
> Bjorn

-- 
Regards,
Siddharth.
