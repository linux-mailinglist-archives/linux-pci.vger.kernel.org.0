Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECEB65B907
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 02:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjACBx5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Jan 2023 20:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjACBx4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jan 2023 20:53:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448B764CF;
        Mon,  2 Jan 2023 17:53:55 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NmG2f3086zJqkQ;
        Tue,  3 Jan 2023 09:52:42 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 09:53:52 +0800
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-vntb: fix doc warning in
 pci-epf-vntb.c
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ntb@lists.linux.dev>, <jdmason@kudzu.us>, <dave.jiang@intel.com>,
        <allenbh@gmail.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <mani@kernel.org>, <kishon@kernel.org>, <bhelgaas@google.com>
References: <20221230193807.GA698469@bhelgaas>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <04d1b6b2-3fc4-f9c2-44cc-c54007963b36@huawei.com>
Date:   Tue, 3 Jan 2023 09:53:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221230193807.GA698469@bhelgaas>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2022/12/31 3:38, Bjorn Helgaas wrote:
> Hi Yang,
>
> On Thu, Dec 22, 2022 at 11:43:24AM +0800, Yang Yingliang wrote:
>> Fix the following make W=1 warning:
>>
>>    drivers/pci/endpoint/functions/pci-epf-vntb.c:645: warning: Function parameter or member 'num_mws' not described in 'epf_ntb_mw_bar_clear'
> No big deal here, but I try to make subject lines and commit logs a
> little more specific.  "Fix doc warning" doesn't give any real
> information, but something like "Add num_mws kernel-doc" would.
>
> No need to repeat "pci-epf-vntb" in the subject; one mention is
> enough.
OK.
>
>> Fixes: 8e4bfbe644a6 ("PCI: endpoint: pci-epf-vntb: fix error handle in epf_ntb_mw_bar_init()")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>> v1 -> v2:
>>    Based on latest commit.
> What is "latest commit"?  A SHA1 would make this unambiguous.
It's 1b929c02afd3 Linux 6.2-rc1.
When I make v1, it also has warning in comment of 
epf_ntb_config_sspad_bar_clear(),
so I fix it in v1, but it was fixed later, so remove the fix code in v2.
>
>> ---
>>   drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> index 04698e7995a5..37134aead77c 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> @@ -594,6 +594,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>>   /**
>>    * epf_ntb_mw_bar_init() - Configure Memory window BARs
>>    * @ntb: NTB device that facilitates communication between HOST and VHOST
>> + * @num_mws: the number of Memory window BARs that to be cleared
> This patch happens to apply cleanly on 1b929c02afd3 ("Linux 6.2-rc1"),
> but I think the hunk gets applied in the wrong place.
>
> 8e4bfbe644a6 ("PCI: endpoint: pci-epf-vntb: fix error handle in
> epf_ntb_mw_bar_init()") added a "num_mws" parameter to
> epf_ntb_mw_bar_clear() but failed to add kernel-doc for num_mws.
>
> This patch adds kernel-doc for num_mws on *epf_ntb_mw_bar_init()*,
> which doesn't have a num_mws parameter, so after applying it, I see
> *two* kernel-doc warnings:
>
>    $ make W=1 drivers/pci/endpoint/functions/pci-epf-vntb.o
>    drivers/pci/endpoint/functions/pci-epf-vntb.c:602: warning: Excess function parameter 'num_mws' description in 'epf_ntb_mw_bar_init'
>    drivers/pci/endpoint/functions/pci-epf-vntb.c:658: warning: Function parameter or member 'num_mws' not described in 'epf_ntb_mw_bar_clear'
Sorry, I sent a wrong patch, the comment should be added to 
epf_ntb_mw_bar_clear().
I will send a new version later.

Thanks,
Yang
>
>>    * Returns: Zero for success, or an error code in case of failure
>>    */
>> -- 
>> 2.25.1
>>
> .
