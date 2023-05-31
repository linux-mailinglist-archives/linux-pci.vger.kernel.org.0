Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEEE7188D0
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 19:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEaRuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 13:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjEaRuH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 13:50:07 -0400
X-Greylist: delayed 306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 10:50:05 PDT
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 368BC129;
        Wed, 31 May 2023 10:50:04 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:52192.1222275076
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id F41D8100211;
        Thu,  1 Jun 2023 01:44:53 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-xp9j7 with ESMTP id 025c347b68894a6488d9ac3cc33df447 for helgaas@kernel.org;
        Thu, 01 Jun 2023 01:44:57 CST
X-Transaction-ID: 025c347b68894a6488d9ac3cc33df447
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <47c5c3ca-b112-9800-a047-10dab4cdef50@189.cn>
Date:   Thu, 1 Jun 2023 01:44:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] PCI: Add dummy implement for pci_clear_master()
 function
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ben Hutchings <bhutchings@solarflare.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        kernel test robot <lkp@intel.com>, Li Yi <liyi@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci@vger.kernel.org
References: <ZHeDpbtM3FFOPn6d@bhelgaas>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <ZHeDpbtM3FFOPn6d@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


Thanks a lot.

Can you receive my email?

I reply several email to you, but Thunderbird told me that may mail is 
returned.

Maybe you could read the content at lore.

```

The recipient's server is busy or down now.
SMTP error, OPEN: Host kernel.org(35.85.114.177) OPEN said 521 5.7.1 Service unavailable; client [114.242.206.163] blocked using zen.spamhaus.org

```


On 2023/6/1 01:28, Bjorn Helgaas wrote:
> On Wed, May 31, 2023 at 06:27:44PM +0800, Sui Jingfeng wrote:
>> As some arch(m68k for example) doesn't have config_pci enabled, drivers[1]
>> call pci_clear_master() without config_pci guard can not pass compile test.
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
>> V2:
>> 	* Adjust commit log style to meet the convention and add Fixes tag
>>
>> Fixes: 6a479079c072 ("PCI: Add pci_clear_master() as opposite of pci_set_master()")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202305301659.4guSLavL-lkp@intel.com/
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> Applied to pci/misc for v6.5 as follows:
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
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>      Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
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
