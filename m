Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F81724CAF
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 21:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239345AbjFFTOT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 15:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbjFFTOF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 15:14:05 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7B101FDC;
        Tue,  6 Jun 2023 12:13:35 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8DxCepVhX9kcE0AAA--.702S3;
        Wed, 07 Jun 2023 03:13:25 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxG8pRhX9k8vsCAA--.3210S3;
        Wed, 07 Jun 2023 03:13:21 +0800 (CST)
Message-ID: <8ec710dd-1b37-5440-5a3c-b30535b94350@loongson.cn>
Date:   Wed, 7 Jun 2023 03:13:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] linux/pci.h: add a dummy implement for pci_clear_master()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
References: <20230606184602.GA1134277@bhelgaas>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <20230606184602.GA1134277@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxG8pRhX9k8vsCAA--.3210S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZry3KFWfuw13tr15tF1UJwc_yoWruF1Upa
        yrJF4Fkr48JFy8Cr4IvF13XF1Fqws8X34xXrWUKw1q9a4qya48tFsYkF45CrnxXrZYkF4a
        vr1akasxW3WUtagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4miiDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/6/7 02:46, Bjorn Helgaas wrote:
> On Wed, Jun 07, 2023 at 01:48:38AM +0800, Sui Jingfeng wrote:
>> On 2023/6/7 00:13, Bjorn Helgaas wrote:
>>> On Tue, May 30, 2023 at 06:16:55PM +0800, Sui Jingfeng wrote:
>>>> As some arch(m68k for example) doesn't have config_pci enabled, drivers[1]
>>>> call pci_clear_master() without config_pci guard can not built.
>>>>
>>>>      drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:
>>>>      In function 'etnaviv_gpu_pci_fini':
>>>>>> drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:32:9:
>>>>      error: implicit declaration of function 'pci_clear_master';
>>>>      did you mean 'pci_set_master'? [-Werror=implicit-function-declaration]
>>>>         32 |         pci_clear_master(pdev);
>>>>            |         ^~~~~~~~~~~~~~~~
>>>>            |         pci_set_master
>>>>      cc1: some warnings being treated as errors
>>>>
>>>> [1] https://patchwork.freedesktop.org/patch/539977/?series=118522&rev=1
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202305301659.4guSLavL-lkp@intel.com/
>>>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>> I applied this to pci/misc for v6.5, with commit log as below.
>>>
>>> But I suspect that it might make your life easier if you include it
>>> with your etnaviv series.  You may be able to avoid adding the
>>> CONFIG_DRM_ETNAVIV_PCI_DRIVER symbol.
>>>
>>> If so, feel free to include this patch in that series with my ack:
>>>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> I do want add this tag to my all  of the patches in the drm/etnaviv series,
>> thanks.
>>
>> and I really love you this idea.
> Just to be clear, my ack only applies to the addition of the
> pci_clear_master() stub in pci.h.  It does not apply to the patches in
> the drm/etnaviv series at
> https://lore.kernel.org/r/20230603105943.3042766-1-15330273260@189.cn
Ok, I understand what you meant then.
>>> If you do include it in your series, please use the commit log below
>>> and let me know so I can drop it from my queue.
>> No, please keep this patch merged by you.
>>
>> Because this patch belong to drivers/pci, Its belong to you domain.
>>
>>
>> I might choose to  remove the CONFIG_DRM_ETNAVIV_PCI_DRIVER option at next
>> version
>>
>> of my drm/etnaviv patch If it arrived to drm/tip branch.
>>
>>
>> But I guess some reviewers may still prefer a CONFIG_DRM_ETNAVIV_PCI_DRIVER
>> option,
>>
>> depend on the attitude of etnaviv folks.
> The purpose of my ack is to enable you to merge the patch along with
> the series that uses it.  This is a normal way of handling things that
> cross subsystem boundaries, so you don't need to feel uncomfortable
> about it.
>
> It is much more difficult to remove config options than it is to add
> them, because you must ensure that the removal doesn't break old
> .config files.
>
> I will keep this patch in my queue unless you tell me to drop it.
>
> Bjorn
>
>>>     Author: Sui Jingfeng <suijingfeng@loongson.cn>
>>>     Date:   Wed May 31 18:27:44 2023 +0800
>>>
>>>       PCI: Add pci_clear_master() stub for non-CONFIG_PCI
>>>       Add a pci_clear_master() stub when CONFIG_PCI is not set so drivers that
>>>       support both PCI and platform devices don't need #ifdefs or extra Kconfig
>>>       symbols for the PCI parts.
>>>       [bhelgaas: commit log]
>>>       Fixes: 6a479079c072 ("PCI: Add pci_clear_master() as opposite of pci_set_master()")
>>>       Link: https://lore.kernel.org/r/20230531102744.2354313-1-suijingfeng@loongson.cn
>>>       Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>>       Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>       Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>>> ---
>>>>    include/linux/pci.h | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index d0c19ff0c958..71c85380676c 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -1904,6 +1904,7 @@ static inline int pci_dev_present(const struct pci_device_id *ids)
>>>>    #define pci_dev_put(dev)	do { } while (0)
>>>>    static inline void pci_set_master(struct pci_dev *dev) { }
>>>> +static inline void pci_clear_master(struct pci_dev *dev) { }
>>>>    static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
>>>>    static inline void pci_disable_device(struct pci_dev *dev) { }
>>>>    static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
>>>> -- 
>>>> 2.25.1
>>>>
>> -- 
>> Jingfeng
>>
-- 
Jingfeng

