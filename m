Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06FFD14C83E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 10:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgA2Jlw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 04:41:52 -0500
Received: from smtprz15.163.net ([106.3.154.248]:37766 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbgA2Jlw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 04:41:52 -0500
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
        by freemail02.tom.com (Postfix) with ESMTP id A69E6B0212F
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2020 16:16:20 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app02 (TOM SMTP Server) with SMTP ID 1724063197
          for <linux-pci@vger.kernel.org>;
          Wed, 29 Jan 2020 16:16:20 +0800 (CST)
Received: from antispam2.tom.com (unknown [172.25.16.56])
        by freemail02.tom.com (Postfix) with ESMTP id 97168B00F57
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2020 16:16:19 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1580285780; bh=60Lbtz1jgTAksZmu0NEEHuwPk57w42bB++U1yIgRLmI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=avtRv3U6MFo0h0G5AIiDBs4B8DrZE0L4gxWE7wIRk0/vIeH/GPjfIba2JEEUyZrgW
         XjaOz5HFdtEERQvauVbfoILN3nY8Cl4dbIQVBfRTx07UucL0IGJalJvJNKVGjwuynd
         4M24XSeMV5cixWDNHX7bAVv5e1s0m7GlOL3ac+VU=
Received: from antispam2.tom.com (antispam2.tom.com [127.0.0.1])
        by antispam2.tom.com (Postfix) with ESMTP id 25FC18173F
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2020 16:16:19 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam2.tom.com
Received: from antispam2.tom.com ([127.0.0.1])
        by antispam2.tom.com (antispam2.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Uq7kVRzBuz-i for <linux-pci@vger.kernel.org>;
        Wed, 29 Jan 2020 16:16:17 +0800 (CST)
Received: from [192.168.3.7] (unknown [111.222.99.15])
        by antispam2.tom.com (Postfix) with ESMTPA id 00BFC8198C;
        Wed, 29 Jan 2020 16:16:16 +0800 (CST)
Subject: Re: [PATCH] PCI/AER: Fix the uninitialized aer_fifo
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Cc:     keith.busch@intel.com, linux-pci@vger.kernel.org,
        linuxarm@huawei.com
References: <20200123222555.GA151102@google.com>
From:   Dongdong Liu <liudongdong3@tom.com>
Message-ID: <5b4157d8-f9d3-86d6-538f-91a31df25541@tom.com>
Date:   Wed, 29 Jan 2020 16:16:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200123222555.GA151102@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn

Many thanks for your review.
It's in the Spring Festival holiday, so reply later.

On 2020/1/24 上午6:25, Bjorn Helgaas wrote:
> On Thu, Jan 23, 2020 at 04:26:31PM +0800, Dongdong Liu wrote:
>> Current code do not call INIT_KFIFO() to init aer_fifo. This will lead to
>> kfifo_put() sometimes return 0. This means the fifo was full. In fact, it
>> is not.
> 
> It's definitely a problem that we don't call INIT_KFIFO().  But I'm
> curious about why this would only be a problem "sometimes".  The kfifo
> is allocated with devm_kzalloc(), so it should be zero-filled and I
> would think it would fail consistently, every time.  But I guess not?

Yes, It would fail consistently, every time when it appeared once.
But when do echo 15 > /proc/sys/kernel/printk,
"aer_inject -s 82:00.0 multiple-corr-nonfatal" executes correctly.
I think this is related with the time when to call kfifo_put() and 
kfifo_get().
case 1:
kfifo_put()--->kfifo_get()--->kfifo_put() //the fifo will not be full
case 2:
kfifo_put()--->kfifo_put()--->kfifo_get()
the fifo will be full when the second time to call kfifo_put();
> 
>> It is easy to reproduce the problem by using aer_inject.
> 
> I assume maybe you mean "aer-inject" (not "aer_inject"), from
> https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/ ?
> At least, that's what's mentioned in Documentation/PCI/pcieaer-howto.rst.

Yes, you are right, I mean aer-inject.

Thanks,
Dongdong
> 
>> aer_inject -s :82:00.0 multiple-corr-nonfatal
>> The content of multiple-corr-nonfatal file is as below.
>> AER
>> COR RCVR
>> HL 0 1 2 3
>> AER
>> UNCOR POISON_TLP
>> HL 4 5 6 7
>>
>> Fixes: 27c1ce8bbed7 ("PCI/AER: Use kfifo for tracking events instead of reimplementing it")
>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
>> ---
>>   drivers/pci/pcie/aer.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 1ca86f2..4a818b0 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1445,6 +1445,7 @@ static int aer_probe(struct pcie_device *dev)
>>   		return -ENOMEM;
>>   
>>   	rpc->rpd = port;
>> +	INIT_KFIFO(rpc->aer_fifo);
>>   	set_service_data(dev, rpc);
>>   
>>   	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
>> -- 
>> 1.9.1
>>
