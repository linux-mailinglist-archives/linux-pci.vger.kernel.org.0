Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF71717556
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 06:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjEaEZU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 00:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjEaEZS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 00:25:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9B6711B;
        Tue, 30 May 2023 21:25:14 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxFvEpzHZkx9oCAA--.6413S3;
        Wed, 31 May 2023 12:25:13 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxi7YmzHZkmsyBAA--.13862S3;
        Wed, 31 May 2023 12:25:10 +0800 (CST)
Message-ID: <3c88cab1-e175-ddcf-b323-437890cc2eec@loongson.cn>
Date:   Wed, 31 May 2023 12:25:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] linux/pci.h: add a dummy implement for pci_clear_master()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
References: <ZHZYVyqsJjiSNNsP@bhelgaas>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <ZHZYVyqsJjiSNNsP@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Bxi7YmzHZkmsyBAA--.13862S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWF17AF1xXw4xXw47KrW5Awb_yoWrGrWfpa
        y5KFyjkr18GFWYkws2q343ZFy5uws5Z34Fk34UG34q9a90vFyktF4vyF13CF1fZrWvkFya
        qr4Yga4UWF45AaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bs8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26F4j6r4U
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8w
        CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
        6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
        vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_
        Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42
        IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1pVbDUUUUU=
        =
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/5/31 04:11, Bjorn Helgaas wrote:
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
> I don't mind adding a stub if it's needed, but I don't understand why
> it's needed here.

For a single driver that supports both platform devices and PCI devices,

Sometimes there is no way to separate the PCI driver part and the 
platform driver part cleanly and clearly.

For example, the module_init() and module_exit() functions,

where we have to register PCI drivers and platform drivers there.

We can't simply let the entire driver depend on PCI in Kconfig,

This will make this driver unable to compile, which it's originally could.

The PCI core could do such a thing for us, and

There is no need to introduce a driver-specific guard then.


There is already a dummy stub for pci_set_master().

Therefore, pci_clear_master() should also have a counterpart.

They should emerge in pairs.

This could probably eliminate pain for PCI driver writers,

This patch is still useful.


>   The caller is in etnaviv_pci_drv.c, and if I
> understand the patch at [1], etnaviv_pci_drv.c is only compiled when
> CONFIG_PCI=y.

Yes, you are right. This is the right thing to do for the driver, though.

Pure PCI device driver does not need to worry about this.

Like drm/ast, drm/amdgpu, drm/radeon, etc.

But drm/etnaviv is special; it's a platform driver that could pass the 
compile test originally.


When patching it (Etnaviv) with PCI device driver support,

This forces the PCI driver writer to add another config option.

(which depends on the PCI config option.) in the Kconfig.

For my case, it's theDRM_ETNAVIV_PCI_DRIVER config option.


This has side effects, but they are not severe.

It boils down to the compilation time thing, while originally we want it 
to be a runtime thing.

Driver writers have to isolate PCI driver-related subroutines in a 
separate source file.

with the DRM_ETNAVIV_PCI_DRIVER option, guard callers of those subroutines,

to let them not get compiled when CONFIG_PCIis disabled.


> Bjorn
>
> [1] https://lore.kernel.org/all/20230530160643.2344551-6-suijingfeng@loongson.cn/
>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202305301659.4guSLavL-lkp@intel.com/
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
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

