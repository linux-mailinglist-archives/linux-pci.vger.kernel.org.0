Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F15E76C8FB
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 11:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjHBJI0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 05:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjHBJIY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 05:08:24 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39F272A;
        Wed,  2 Aug 2023 02:08:22 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372988cG025542;
        Wed, 2 Aug 2023 04:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690967288;
        bh=sVfGcElZUqw1E2kyfrVI8It33Bquda6ZK7Bym2RIWlg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=A1WQmC15S+g2k4FIBBgdiz2C1eMHcX6Jsv2vkNsniyPe6cobYkcTJtwg/cKmLAbB6
         OHE3n+JQ7Oi+a1fBvijrfM/827b3NX/+vrqyC4Vx5upJOnuroGo3MqoyQKyFMAU9oW
         pkA5r8dkqfd/i9v56XJNKab2qD6aY/PcsM9Q1tcc=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372988xu024201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 04:08:08 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 04:08:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 04:08:08 -0500
Received: from [172.24.19.15] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372983Nh119753;
        Wed, 2 Aug 2023 04:08:03 -0500
Message-ID: <8951d4fd-279d-8a78-65a3-daeb4befa899@ti.com>
Date:   Wed, 2 Aug 2023 14:38:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [PATCH v3] PCI: j721e: Delay 100ms T_PVPERL from
 power stable to PERST# inactive
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
References: <20230718155515.GA483233@bhelgaas>
Content-Language: en-US
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <20230718155515.GA483233@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/18/2023 9:25 PM, Bjorn Helgaas wrote:
> On Fri, Jul 07, 2023 at 03:21:19PM +0530, Achal Verma wrote:
>> As per the PCIe Card Electromechanical specification REV. 5.0, PERST#
>> signal should be de-asserted after minimum 100ms from the time power-rails
>> become stable. So, to ensure 100ms delay to give sufficient time for
>> power-rails and refclk to become stable, change delay from 100us to 100ms.
>>
>>  From PCIe Card Electromechanical specification REV. 5.0 section 2.9.2:
>> TPVPERL: Power stable to PERST# inactive - 100ms
>>
>> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
>> Signed-off-by: Achal Verma <a-verma1@ti.com>
>> ---
>>
>> Changes from v2:
>> * Fix commit message.
>>
>> Change from v1:
>> * Add macro for delay value.
>>
>>   drivers/pci/controller/cadence/pci-j721e.c | 11 +++++------
>>   drivers/pci/pci.h                          |  2 ++
>>   2 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
>> index e70213c9060a..32b6a7dc3cff 100644
>> --- a/drivers/pci/controller/cadence/pci-j721e.c
>> +++ b/drivers/pci/controller/cadence/pci-j721e.c
>> @@ -498,14 +498,13 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>>   
>>   		/*
>>   		 * "Power Sequencing and Reset Signal Timings" table in
>> -		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
>> -		 * indicates PERST# should be deasserted after minimum of 100us
>> -		 * once REFCLK is stable. The REFCLK to the connector in RC
>> -		 * mode is selected while enabling the PHY. So deassert PERST#
>> -		 * after 100 us.
>> +		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 5.0
>> +		 * indicates PERST# should be deasserted after minimum of 100ms
>> +		 * after power rails achieve specified operating limits and
>> +		 * within this period reference clock should also become stable.
> 
> I think the problem is not that the current code is *wrong*, because
> we do need to observe T_PERST-CLK, but that it failed to *also*
> account for T_PVPERL.
> 
> There are two delays before deasserting PERST#:
> 
>    T_PVPERL: delay after power becomes stable
>    T_PERST-CLK: delay after REFCLK becomes stable
> 
> I assume power is enabled by phy_power_on(), and REFCLK is enabled by
> clk_prepare_enable():
> 
>    cdns_pcie_init_phy
>      cdns_pcie_enable_phy
>        phy_power_on             <-- power becomes stable
>    clk_prepare_enable           <-- REFCLK becomes stable
>    if (gpiod)
>      usleep_range
>      gpiod_set_value_cansleep(gpiod, 1)   <-- deassert PERST#
> 
> I don't actually know if phy_power_on() guarantees that power is
> stable before it returns.  But I guess that's our assumption?
> Similarly for clk_prepare_enable().
> 
> In any case, we have to observe both delays.  They overlap, and
> T_PVPERL is 1000 times longer than T_PERST-CLK, so there might be
> enough slop in an msleep(100) to cover both, but I think I would do
> the simple-minded:
> 
>    msleep(PCIE_TPVPERL_MS);
>    usleep_range(PCIE_TPERST_CLK_US, 2 * PCIE_TPERST_CLK_US);
> 
I think adding 100us more is not required since as you said and as also 
mentioned in CEM spec, 100ms covers for both power rails and refclock to
get stable and 2 consecutive sleep call looks different to me.
But if still required (please let me know), will do the suggested 
change, along with other fixes you asked below.
> This is slightly more conservative than necessary because they
> overlap, but at least it shows that we thought about both of them.
> 
>>   		if (gpiod) {
>> -			usleep_range(100, 200);
>> +			msleep(PCIE_TPVPERL_DELAY_MS);
>>   			gpiod_set_value_cansleep(gpiod, 1);
> 
> I wish this local variable were named something like "perst_gpiod"
> instead of "gpiod".  We already know from its use in
> gpiod_set_value_cansleep() that it's a GPIO.  What's NOT obvious from
> the context is that this is the PERST# signal.
sure will change variable name to perst_gpiod.
> 
> Tangent: it looks like the DT "reset" property that I'm assuming
> controls PERST# is optional.  How do we enforce these delays if that
> property is missing?
> 
yes gpiod_get shouldn't be optional, will fix this too.

>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index a4c397434057..6ab2367e5867 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -13,6 +13,8 @@
>>   
>>   #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
>>   
>> +#define PCIE_TPVPERL_DELAY_MS	100	/* see PCIe CEM r5.0, sec 2.9.2 */
>> +
>>   extern const unsigned char pcie_link_speed[];
>>   extern bool pci_early_dump;
>>   
>> -- 
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
