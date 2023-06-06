Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECC4724A84
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 19:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbjFFRs4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjFFRsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 13:48:50 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 685B910F4;
        Tue,  6 Jun 2023 10:48:48 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Bxb+t6cX9k90cAAA--.1089S3;
        Wed, 07 Jun 2023 01:48:42 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxZuR2cX9k29kCAA--.11270S3;
        Wed, 07 Jun 2023 01:48:38 +0800 (CST)
Message-ID: <dd2409ed-dac2-30b5-783d-8d84e38ad5c9@loongson.cn>
Date:   Wed, 7 Jun 2023 01:48:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] linux/pci.h: add a dummy implement for pci_clear_master()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
References: <20230606161346.GA1127246@bhelgaas>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <20230606161346.GA1127246@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxZuR2cX9k29kCAA--.11270S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF15AF45XryrKF1UAr47Awc_yoW5tw1fpa
        y5AF1FkrW8GFyjkw47Xa43ZFyFva95Z34ftrW7Kw1q93ZFy34ktFsYkF15Krn3XrZYkF4a
        qwnFka45Ww1UAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
        AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
        6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/6/7 00:13, Bjorn Helgaas wrote:
> On Tue, May 30, 2023 at 06:16:55PM +0800, Sui Jingfeng wrote:
>> As some arch(m68k for example) doesn't have config_pci enabled, drivers[1]
>> call pci_clear_master() without config_pci guard can not built.
>>
>>     drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:
>>     In function 'etnaviv_gpu_pci_fini':
>>>> drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:32:9:
>>     error: implicit declaration of function 'pci_clear_master';
>>     did you mean 'pci_set_master'? [-Werror=implicit-function-declaration]
>>        32 |         pci_clear_master(pdev);
>>           |         ^~~~~~~~~~~~~~~~
>>           |         pci_set_master
>>     cc1: some warnings being treated as errors
>>
>> [1] https://patchwork.freedesktop.org/patch/539977/?series=118522&rev=1
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202305301659.4guSLavL-lkp@intel.com/
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> I applied this to pci/misc for v6.5, with commit log as below.
>
> But I suspect that it might make your life easier if you include it
> with your etnaviv series.  You may be able to avoid adding the
> CONFIG_DRM_ETNAVIV_PCI_DRIVER symbol.
>
> If so, feel free to include this patch in that series with my ack:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I do want add this tag to my all  of the patches in the drm/etnaviv 
series, thanks.

and I really love you this idea.

> If you do include it in your series, please use the commit log below
> and let me know so I can drop it from my queue.

No, please keep this patch merged by you.

Because this patch belong to drivers/pci, Its belong to you domain.


I might choose to  remove the CONFIG_DRM_ETNAVIV_PCI_DRIVER option at 
next version

of my drm/etnaviv patch If it arrived to drm/tip branch.


But I guess some reviewers may still prefer a 
CONFIG_DRM_ETNAVIV_PCI_DRIVER option,

depend on the attitude of etnaviv folks.

> Bjorn
>
>
>    Author: Sui Jingfeng <suijingfeng@loongson.cn>
>    Date:   Wed May 31 18:27:44 2023 +0800
>
>      PCI: Add pci_clear_master() stub for non-CONFIG_PCI
>      
>      Add a pci_clear_master() stub when CONFIG_PCI is not set so drivers that
>      support both PCI and platform devices don't need #ifdefs or extra Kconfig
>      symbols for the PCI parts.
>      
>      [bhelgaas: commit log]
>      Fixes: 6a479079c072 ("PCI: Add pci_clear_master() as opposite of pci_set_master()")
>      Link: https://lore.kernel.org/r/20230531102744.2354313-1-suijingfeng@loongson.cn
>      Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>      Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>      Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
>> ---
>>   include/linux/pci.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index d0c19ff0c958..71c85380676c 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1904,6 +1904,7 @@ static inline int pci_dev_present(const struct pci_device_id *ids)
>>   #define pci_dev_put(dev)	do { } while (0)
>>   
>>   static inline void pci_set_master(struct pci_dev *dev) { }
>> +static inline void pci_clear_master(struct pci_dev *dev) { }
>>   static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
>>   static inline void pci_disable_device(struct pci_dev *dev) { }
>>   static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
>> -- 
>> 2.25.1
>>
-- 
Jingfeng

