Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDE16146B0
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 10:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKAJcQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 05:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiKAJcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 05:32:12 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Nov 2022 02:32:11 PDT
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D38FE18E37
        for <linux-pci@vger.kernel.org>; Tue,  1 Nov 2022 02:32:11 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 01 Nov 2022 18:31:08 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 6115C2059027;
        Tue,  1 Nov 2022 18:31:08 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 1 Nov 2022 18:31:08 +0900
Received: from [10.212.156.238] (unknown [10.212.156.238])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 051EAB62AE;
        Tue,  1 Nov 2022 18:31:07 +0900 (JST)
Subject: Re: [PATCH v3] PCI: pci-epf-test: Register notifier if only
 core_init_notifier is enabled
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028170647.GA898435@bhelgaas>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <0faa0138-ae2b-42e0-d378-665527f0b660@socionext.com>
Date:   Tue, 1 Nov 2022 18:31:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20221028170647.GA898435@bhelgaas>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 2022/10/29 2:06, Bjorn Helgaas wrote:
> On Thu, Aug 25, 2022 at 06:01:01PM +0900, Kunihiko Hayashi wrote:
>> Need to register pci_epf_test_notifier function event if only
>> core_init_notifier is enabled.
>>
>> Fixes: 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer core
> initialization")
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> Acked-by: Om Prakash Singh <omp@nvidia.com>
>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> This patch is a part of series "PCI: endpoint: Fix core_init_notifier
> feature".
>> The rest of the patches have been withdrawn.
>>
>> Changes since v2:
>> - Add Acked-by lines
>>
>> Changes since v1:
>> - Add Acked-by lines
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
> b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index 36b1801a061b..55283d2379a6 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -979,7 +979,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>>   	if (ret)
>>   		epf_test->dma_supported = false;
>>   
>> -	if (linkup_notifier) {
>> +	if (linkup_notifier || core_init_notifier) {
>>   		epf->nb.notifier_call = pci_epf_test_notifier;
>>   		pci_epc_register_notifier(epc, &epf->nb);
> 
> Why does pci_epc_register_notifier() even exist?  It's not used at all
> except for this test code.
> 
> It would be better if infrastructure like this were connected with
> some user of it.
This call was added by the commit 5779dd0a7dbd
("PCI: endpoint: Use notification chain mechanism to notify EPC events to EPF").

I haven't followed the discussion, however, this commit say:
"This will also enable to add more events (in addition to linkup) in the future."

Thank you,

---
Best Regards
Kunihiko Hayashi
