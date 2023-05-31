Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999A5717C65
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 11:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjEaJtW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 05:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjEaJtV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 05:49:21 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37D0F10E;
        Wed, 31 May 2023 02:49:19 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxxfAeGHdkTewCAA--.2130S3;
        Wed, 31 May 2023 17:49:18 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx4zgbGHdkLzCCAA--.14647S3;
        Wed, 31 May 2023 17:49:15 +0800 (CST)
Message-ID: <835b253a-b8fc-98de-0f5a-7f3ff0010d6c@loongson.cn>
Date:   Wed, 31 May 2023 17:49:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] linux/pci.h: add a dummy implement for pci_clear_master()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
References: <20230530101655.2275731-1-suijingfeng@loongson.cn>
 <CAMuHMdVU1qurBki6uf3UadK0Dted67pnhE7+2CDGYmK7QCNY0g@mail.gmail.com>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <CAMuHMdVU1qurBki6uf3UadK0Dted67pnhE7+2CDGYmK7QCNY0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx4zgbGHdkLzCCAA--.14647S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KryfWr1UWFy3CF48tr4UCFg_yoW8Zw4Upa
        y5Ja45GrW8JFyDG3yxta4xXFyavrZ3X34fArZrKw1v9anFvas5tF10kF17Cr1fZrWvkF12
        qw47Ka15Wa1YyFJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        CVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_
        Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j52-5UUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

thanks a lot.

On 2023/5/31 15:04, Geert Uytterhoeven wrote:
> Hi Sui,
>
> On Tue, May 30, 2023 at 12:21 PM Sui Jingfeng <suijingfeng@loongson.cn> wrote:
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
> Thanks for your patch!
>
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1904,6 +1904,7 @@ static inline int pci_dev_present(const struct pci_device_id *ids)
>>   #define pci_dev_put(dev)       do { } while (0)
>>
>>   static inline void pci_set_master(struct pci_dev *dev) { }
>> +static inline void pci_clear_master(struct pci_dev *dev) { }
>>   static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
>>   static inline void pci_disable_device(struct pci_dev *dev) { }
>>   static inline int pcim_enable_device(struct pci_dev *pdev) { return -EIO; }
> Makes perfect sense, given there has been a dummy for pci_set_master()
> since the git stone age. Apparently adding the dummy was forgotten
> when pci_clear_master() was introduced.
>
> Fixes: 6a479079c07211bf ("PCI: Add pci_clear_master() as opposite of
> pci_set_master()")
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
-- 
Jingfeng

