Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F9F674D2A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 07:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjATGSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 01:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjATGSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 01:18:31 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9955081986;
        Thu, 19 Jan 2023 22:18:28 -0800 (PST)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nyq5C1S38zRrKw;
        Fri, 20 Jan 2023 14:16:31 +0800 (CST)
Received: from [10.136.108.160] (10.136.108.160) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 14:18:25 +0800
Message-ID: <42dc3ab2-8129-7186-c777-07848ee01f66@huawei.com>
Date:   Fri, 20 Jan 2023 14:18:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI: Exit restore process when device is still powerdown
Content-Language: en-US
References: <4691af50-b718-d0ec-7dff-fd6fa1ff081a@huawei.com>
To:     "zhangjianrong (E)" <zhangjianrong5@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   jiantao zhang <water.zhangjiantao@huawei.com>
In-Reply-To: <4691af50-b718-d0ec-7dff-fd6fa1ff081a@huawei.com>
X-Forwarded-Message-Id: <4691af50-b718-d0ec-7dff-fd6fa1ff081a@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.108.160]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500002.china.huawei.com (7.221.188.171)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

在 2023/1/13 6:13, Bjorn Helgaas 写道:
> On Thu, Dec 22, 2022 at 12:41:04PM +0000, Jiantao Zhang wrote:
>> We get this stack when the rp doesn't power up in resume noirq:
> 
> s/rp/Root Port/
> 
> "resume noirq" seems to refer to a function, so please mention the
> exact function name.
> 
>>      dump_backtrace.cfi_jt+0x0/0x4
>>      dump_stack_lvl+0xb4/0x10c
>>      show_regs_before_dump_stack+0x1c/0x30
>>      arm64_serror_panic+0x110/0x1a8
>>      do_serror+0x16c/0x1cc
>>      el1_error+0x8c/0x10c
>>      do_raw_spin_unlock+0x74/0xdc
>>      pci_bus_read_config_word+0xdc/0x1dc
>>      pci_restore_msi_state+0x2f4/0x36c
>>      pci_restore_state+0x13f0/0x1444
>>      pci_pm_resume_noirq+0x158/0x318
>>      dpm_run_callback+0x178/0x5e8
>>      device_resume_noirq+0x250/0x264
>>      async_resume_noirq+0x20/0xf8
>>      async_run_entry_fn+0xfc/0x364
>>      process_one_work+0x37c/0x7f4
>>      worker_thread+0x3e8/0x754
>>      kthread+0x168/0x204
>>      ret_from_fork+0x10/0x18
>> The ep device uses msix, the restore process will write bar space
>> in __pci_msix_desc_mask_irq, which will result in accessing the
>> powerdown area when the rp doesn't power on.
> 
> s/ep/endpoint/
> s/msix/MSI-X/ to match spec usage
> s/bar/BAR/
> Add "()" after function names, e.g., __pci_msix_desc_mask_irq()
> s/rp/Root Port/
> 
>> It makes sense we should do nothing when the device is still powerdown.
>>
>> Signed-off-by: Jianrong Zhang <zhangjianrong5@huawei.com>
>> Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
>> ---
>>   drivers/pci/pci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index fba95486caaf..279f6e8c5a00 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1764,7 +1764,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
>>    */
>>   void pci_restore_state(struct pci_dev *dev)
>>   {
>> -	if (!dev->state_saved)
>> +	if (!dev->state_saved || dev->current_state == PCI_UNKNOWN)
>>   		return;
> 
> This doesn't seem right to me because it seems like we're covering up
> a problem elsewhere.
> 
> If we need access to the endpoint to restore state, shouldn't we
> ensure that the endpoint is powered up before we try to access it?
> 
> We depend on the state being restored, so if we skip the restore here,
> where *will* it happen?
As the call stack shows the serror happens in pci_pm_resume_noirq(),
which belongs to pci pm framework. The resume process related to pci
devices goes like this:

stage noirq:
Root Port's call stack: device_resume_noirq() --> pci_pm_resume_noirq() 
--> resume_noirq callback
endpoint's call stack: device_resume_noirq() --> pci_pm_resume_noirq() 
--> resume_noirq callback

stage early:
Root Port's call stack: device_resume_early() --> pci_pm_resume_early() 
--> device resume_early callback
endpoint's call stack: device_resume_early() --> pci_pm_resume_early() 
--> device resume_early callback

stage normal:
Root Port's call stack: device_resume() --> pci_pm_resume() --> device 
resume callback
endpoint's call stack: device_resume() --> pci_pm_resume() --> device 
resume callback

The problem is we don't power up the controller in Root Port's 
resume_noirq callback
(actually we don't even register resume_noirq callback for some reason),
so the serror happens because of accessing powerdown area when 
endpoint's pci_pm_resume_noirq()
calls pci_restore_state() which will call pci_restore_msi_state() to 
restore MSI-X state.
So we wonder if there is strong restriction that we must poweron in Root 
Port's resume_noirq callback.
The pci_restore_state() can't restore anything when the device is still 
at PCI_UNKNOWN state,
and if the device is accessible it can't be at PCI_UNKNOWN state, so the 
patch doesn't make any difference
for original process.
> 
> Bjorn
> .
