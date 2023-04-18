Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA4B6E57E9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 05:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDRDt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 23:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDRDtZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 23:49:25 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBD235B7;
        Mon, 17 Apr 2023 20:49:24 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33I3nAh0038643;
        Mon, 17 Apr 2023 22:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681789750;
        bh=CO32Djbhl7Q2nG1jrPsAUR0MdzJ0i5giMSLCdIwmiwE=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=B/Aej7SnyzqvSy5u2Jty7oGyvqg5ibOAD9rkKsdGo43WTRgPoiemgFd4pG7x0wsbH
         C8Q0Mj/lG+S0GHJun5WU6rOUhgptGXlE6OkXfo4taKxExK4XVgQSry/8j1fopKArpD
         pXLh7Oi6qG6FO2t9W5Q7tpADf9ISRmqG20advFac=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33I3nA2B026282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 22:49:10 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 22:49:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 22:49:10 -0500
Received: from [172.24.145.61] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33I3n6Yv018527;
        Mon, 17 Apr 2023 22:49:07 -0500
Message-ID: <c0f5b71d-ddee-850e-e8ba-1304e8480e8e@ti.com>
Date:   Tue, 18 Apr 2023 09:19:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
CC:     <tjoseph@cadence.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <nadeem@cadence.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <nm@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] PCI: cadence: Fix Gen2 Link Retraining process
To:     Bjorn Helgaas <helgaas@kernel.org>, <kw@linux.com>,
        <lpieralisi@kernel.org>
References: <20230330170218.GA3155390@bhelgaas>
Content-Language: en-US
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230330170218.GA3155390@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

Can this patch please be merged if there are no concerns?

On 30/03/23 22:32, Bjorn Helgaas wrote:
> On Thu, Mar 30, 2023 at 09:52:06AM +0530, Siddharth Vadapalli wrote:
>> Hello Bjorn,
>>
>> On 29/03/23 22:38, Bjorn Helgaas wrote:
>>> On Wed, Mar 29, 2023 at 08:11:25PM +0530, Raghavendra, Vignesh wrote:
>>>> Hi Lorenzo, Bjorn,
>>>>
>>>> On 3/15/2023 12:38 PM, Siddharth Vadapalli wrote:
>>>>> The Link Retraining process is initiated to account for the Gen2 defect in
>>>>> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
>>>>> is i2085, documented at:
>>>>> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
>>>>>
>>>>> The existing workaround implemented for the errata waits for the Data Link
>>>>> initialization to complete and assumes that the link retraining process
>>>>> at the Physical Layer has completed. However, it is possible that the
>>>>> Physical Layer training might be ongoing as indicated by the
>>>>> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
>>>>>
>>>>> Fix the existing workaround, to ensure that the Physical Layer training
>>>>> has also completed, in addition to the Data Link initialization.
>>>>>
>>>>> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
>>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>>> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
>>>>> ---
>>>>> Changes from v1:
>>>>> 1. Collect Reviewed-by tag from Vignesh Raghavendra.
>>>>> 2. Rebase on next-20230315.
>>>>>
>>>>> v1:
>>>>> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com
>>>>>
>>>>>  .../controller/cadence/pcie-cadence-host.c    | 27 +++++++++++++++++++
>>>>>  1 file changed, 27 insertions(+)
>>>>
>>>> Wondering do one of you be pulling this patch in? This patch was never
>>>> picked for 6.3-rc1 merge cycle... Just want to make sure
>>>> pcie-cadence*.c and pci-j721e.c patches have a path to reach pci tree.
>>>
>>> Yes, Lorenzo or Krzysztof will likely pick this up.  I think Lorenzo
>>> is out of the office this week.
>>>
>>> Drive-by comment: the current patch doesn't seem to give any
>>> indication to the user when cdns_pcie_host_training_complete() times
>>> out.  Is that timeout potentially of interest to a user?  Should there
>>> be a log message there?
>>
>> Thank you for reviewing the patch. The return value of -ETIMEDOUT from the
>> function cdns_pcie_host_training_complete() added by this patch will be handled
>> similar to the -ETIMEDOUT from the cdns_pcie_host_wait_for_link() function that
>> is already present.
>>
>> If cdns_pcie_host_training_complete() returns -ETIMEDOUT, it is returned to
>> cdns_pcie_host_start_link() function which is called within
>> cdns_pcie_host_setup() function. In the cdns_pcie_host_setup() function, there
>> is already a dev_dbg() print for handling the case where
>> cdns_pcie_host_wait_for_link() times out. For this reason, I felt that for both
>> cases, the dev_dbg() print can be used to debug without the need for an extra
>> log message. Please let me know if that's fine.
> 
> Sounds good.
> 
> dev_dbg() wouldn't be the right thing if we *expect* the link to come
> up, but ISTR that maybe you can't detect device presence directly.  If
> that's the case, all you can do is try to bring the link up and assume
> the slot is empty if it doesn't come up.  If the usual reason for the
> timeout is that the slot is empty, dev_dbg() should be fine.
> 
> Another drive-by comment, no action needed, seems slightly strange to
> have two "start_link" functions called one after the other:
> 
>   cdns_pcie_host_setup
>     cdns_pcie_start_link
>     cdns_pcie_host_start_link
> 
> I assume both are for the same link, so it's weird to have two
> functions for it.
> 
> Bjorn

-- 
Regards,
Siddharth.
