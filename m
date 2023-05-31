Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278D071888E
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 19:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjEaRho (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 13:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEaRho (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 13:37:44 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C822BE;
        Wed, 31 May 2023 10:37:41 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxlPDkhXdk4wcDAA--.6671S3;
        Thu, 01 Jun 2023 01:37:40 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxi7bjhXdkx7iCAA--.15108S3;
        Thu, 01 Jun 2023 01:37:39 +0800 (CST)
Message-ID: <b0faa79d-21e2-fe5d-f9bc-3abbf488ec1c@loongson.cn>
Date:   Thu, 1 Jun 2023 01:37:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] linux/pci.h: add a dummy implement for pci_clear_master()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
References: <ZHeA6eB5FocARdwl@bhelgaas>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <ZHeA6eB5FocARdwl@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxi7bjhXdkx7iCAA--.15108S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGF15tF18ur48Ar4UWw1rWFg_yoW5CF4kpa
        yUta4jkr4kJr4Fkwn2qw1SvFyFyw1fXa4Fkr98J3s09398ZFyFqr4DtF4DCF9xXr1FyF42
        vr4Yga47uF45ZaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS
        14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5
        JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07jwBMNUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/6/1 01:16, Bjorn Helgaas wrote:
> On Wed, May 31, 2023 at 12:25:10PM +0800, Sui Jingfeng wrote:
>> On 2023/5/31 04:11, Bjorn Helgaas wrote:
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
>>> I don't mind adding a stub if it's needed, but I don't understand why
>>> it's needed here.
>> For a single driver that supports both platform devices and PCI devices,
>>
>> Sometimes there is no way to separate the PCI driver part and the platform
>> driver part cleanly and clearly.
>>
>> For example, the module_init() and module_exit() functions,
>>
>> where we have to register PCI drivers and platform drivers there.
>>
>> We can't simply let the entire driver depend on PCI in Kconfig,
>>
>> This will make this driver unable to compile, which it's originally could.
>>
>> The PCI core could do such a thing for us, and
>>
>> There is no need to introduce a driver-specific guard then.
>>
>>
>> There is already a dummy stub for pci_set_master().
>>
>> Therefore, pci_clear_master() should also have a counterpart.
>>
>> They should emerge in pairs.
>>
>> This could probably eliminate pain for PCI driver writers,
>>
>> This patch is still useful.
>>
>>
>>>    The caller is in etnaviv_pci_drv.c, and if I
>>> understand the patch at [1], etnaviv_pci_drv.c is only compiled when
>>> CONFIG_PCI=y.
>> Yes, you are right. This is the right thing to do for the driver, though.
>>
>> Pure PCI device driver does not need to worry about this.
>>
>> Like drm/ast, drm/amdgpu, drm/radeon, etc.
>>
>> But drm/etnaviv is special; it's a platform driver that could pass the
>> compile test originally.
>>
>>
>> When patching it (Etnaviv) with PCI device driver support,
>>
>> This forces the PCI driver writer to add another config option.
>>
>> (which depends on the PCI config option.) in the Kconfig.
>>
>> For my case, it's theDRM_ETNAVIV_PCI_DRIVER config option.
> So if I understand correctly, you would prefer not to add the
> DRM_ETNAVIV_PCI_DRIVER config option, and if we add this stub, you
> won't need to add it?
>
> That's a good reason to add this patch.

Yes, please add this patch.

Otherwise, other people may suffer from the same issue someday.

After  this patch added,  I will try respin my etnaviv patch set.

If the PCI core could shield the hazard for us.

I would prefer my etnaviv don't introduce any config option.

Compile anywhere at any case.

> Bjorn

-- 
Jingfeng

