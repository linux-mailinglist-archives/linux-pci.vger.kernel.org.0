Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD8D747617
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 18:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGDQHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 12:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGDQHM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 12:07:12 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A22EE7A;
        Tue,  4 Jul 2023 09:07:10 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 364G6meo127101;
        Tue, 4 Jul 2023 11:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688486808;
        bh=Qp+vFMfuEysL6yAnzeCFNQYqDH0eM850rxMMqfKTg38=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UKFGGx+PbiFt+ARgk3EOsuA9BRRj1du8WmWnWArkd8O9+K5neJ0kNKB4uXZLRMFQm
         AwU2C7ZRaVav3mZ4N02Zcj8BXJ2A5dhXuKksb1wdoFSwKojxj/g2o+tGHeuVzDamZ+
         He9crasw8UCgpyk+mynEM65fuXTPbPjkcbW5PPqk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 364G6mLT020501
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jul 2023 11:06:48 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jul 2023 11:06:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jul 2023 11:06:48 -0500
Received: from [10.249.128.37] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 364G6h1s061523;
        Tue, 4 Jul 2023 11:06:44 -0500
Message-ID: <a245938e-2140-5f77-ab91-6cfbd3ddf66c@ti.com>
Date:   Tue, 4 Jul 2023 21:36:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [EXTERNAL] Re: [PATCH] PCI: j721e: Fix delay before PERST#
 deassert
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
References: <20230703162156.GA525196@bhelgaas>
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <20230703162156.GA525196@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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



On 7/3/2023 9:51 PM, Bjorn Helgaas wrote:
> In subject, "Fix" doesn't convey much information.  Does it increase?
> Decrease?  How much time are we talking about?  PERST# deassert is at
> one end of the delay; what event is at the other end?
Hi Bjorn,

How about "Increase delay to 100ms for PERST# deassert from moment 
power-rails achieve operating limits"
> 
> Some of these useful bits of information could appear in the subject
> line.
> 
> On Mon, Jul 03, 2023 at 04:59:14PM +0530, Achal Verma wrote:
>> As per the PCIe Card Electromechanical specification REV. 3.0, PERST#
> 
> I think the current rev of this spec is r5.0.  Can you cite that
> instead?  I think the relevant section is r5.0, sec 2.9.2.
REV 5.0 also quote same TPVPERL=100ms delay.
I refer REV. 3.0 as pci-j721e controller follows REV. 3.0
> 
>> signal should be de-asserted after minimum 100ms from the time power-rails
>> become stable. Current delay of 100us is observed to be not enough on some
>> custom platform implemented using TI's K3 SOCs.
> 
> Is this delay for the benefit of the Root Port or for the attached
> Endpoint?  If the latter, my guess is that some Endpoints might
> tolerate the current shorter delay, while others might require more,
> and it doesn't sound like "TI's K3 SoC" would be relevant here.
Its for the endpoints, TI's EVB doesn't exhibit any issues with 100us 
delay but some customer reported the issue with shorter delay.
I have been working to refactor this driver to build as a module, I too
observed the issue on re-probe after remove when delay is lesser.
> 
>> So, to ensure 100ms delay to give sufficient time for power-rails and
>> refclk to become stable, change delay from 100us to 100ms.
>>
>>  From PCIe Card Electromechanical specification REV. 3.0 section 2.6.2:
>> TPVPERL: Power stable to PERST# inactive - 100ms
>> T-PERST-CLK: REFCLK stable before PERST# inactive - 100 usec.
> 
> Numbers like 100ms that come from the PCIe specs should have #defines
> for them.  If we don't have one already, can you add one, please?
Sure, will do it in next revision but should this go in some generic PCI 
header file or just pci-j721e.c
> 
>> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
>> Signed-off-by: Achal Verma <a-verma1@ti.com>
>> ---
>>   drivers/pci/controller/cadence/pci-j721e.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
>> index e70213c9060a..fa2b4c11d2c4 100644
>> --- a/drivers/pci/controller/cadence/pci-j721e.c
>> +++ b/drivers/pci/controller/cadence/pci-j721e.c
>> @@ -499,13 +499,12 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>>   		/*
>>   		 * "Power Sequencing and Reset Signal Timings" table in
>>   		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
>> -		 * indicates PERST# should be deasserted after minimum of 100us
>> -		 * once REFCLK is stable. The REFCLK to the connector in RC
>> -		 * mode is selected while enabling the PHY. So deassert PERST#
>> -		 * after 100 us.
>> +		 * indicates PERST# should be deasserted after minimum of 100ms
>> +		 * after power rails achieve specified operating limits and
>> +		 * within this period reference clock should also become stable.
>>   		 */
>>   		if (gpiod) {
>> -			usleep_range(100, 200);
>> +			msleep(100);
>>   			gpiod_set_value_cansleep(gpiod, 1);
>>   		}
>>   
>> -- 
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
