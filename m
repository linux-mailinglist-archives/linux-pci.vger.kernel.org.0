Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897307777C7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 14:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjHJMEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 08:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJMEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 08:04:36 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F5F01BD;
        Thu, 10 Aug 2023 05:04:33 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxHOtP0tRkSKcUAA--.39405S3;
        Thu, 10 Aug 2023 20:04:31 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjiNN0tRkCxtTAA--.36236S3;
        Thu, 10 Aug 2023 20:04:30 +0800 (CST)
Message-ID: <ae9c5785-5e76-7c47-5837-2570fa18e6d9@loongson.cn>
Date:   Thu, 10 Aug 2023 20:04:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/11] PCI/VGA: Fix two typos in the comments of
 pci_notify()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230808223412.1743176-1-sui.jingfeng@linux.dev>
 <20230808223412.1743176-7-sui.jingfeng@linux.dev>
 <d8fa683-bee4-2c6-612a-9fab3269c498@linux.intel.com>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <d8fa683-bee4-2c6-612a-9fab3269c498@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNN0tRkCxtTAA--.36236S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw4rZrWrAFyfJrWxJF15WrX_yoW8Ww4rpr
        W8JFWFkF48GrnrC3WIvF1jqFy5Z393A3s3CF45Kw17uF1DCw1FqFySkFWYyFy5XFW3CF42
        vr1jqFy3Ga45AagCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DU
        UUU
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/8/9 22:12, Ilpo Järvinen wrote:
> On Wed, 9 Aug 2023, Sui Jingfeng wrote:
>
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> 1) s/intereted/interested
>> 2) s/hotplugable/hot-pluggable
>>
>> While at it, convert the comments to the conventional multi-line style,
>> and rewrap to fill 78 columns.
>>
>> Fixes: deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux")
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/pci/vgaarb.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>> index 6883067a802a..811510253553 100644
>> --- a/drivers/pci/vgaarb.c
>> +++ b/drivers/pci/vgaarb.c
>> @@ -1535,9 +1535,11 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
>>   	if (!pci_dev_is_vga(pdev))
>>   		return 0;
>>   
>> -	/* For now we're only intereted in devices added and removed. I didn't
>> -	 * test this thing here, so someone needs to double check for the
>> -	 * cases of hotplugable vga cards. */
>> +	/*
>> +	 * For now, we're only interested in devices added and removed.
>> +	 * I didn't test this thing here, so someone needs to double check
>> +	 * for the cases of hot-pluggable VGA cards.
>> +	 */
>>   	if (action == BUS_NOTIFY_ADD_DEVICE)
>>   		notify = vga_arbiter_add_pci_device(pdev);
>>   	else if (action == BUS_NOTIFY_DEL_DEVICE)
> Don't use Fixes tag for comment changes. After removing it, feel free to
> add:


OK, I will remove the Fixes tag for comment changes at next version.
Thanks a lot. Also for other patches in this series.


> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>
>

