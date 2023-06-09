Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4D4729A0F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 14:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbjFIMbq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 08:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbjFIMbn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 08:31:43 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A53163AB9;
        Fri,  9 Jun 2023 05:31:15 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxX+stGoNkQBYBAA--.3286S3;
        Fri, 09 Jun 2023 20:25:17 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxZuQsGoNkJCULAA--.33833S3;
        Fri, 09 Jun 2023 20:25:16 +0800 (CST)
Message-ID: <9899fa21-8ffd-eed4-2b6e-68ddcd6fd670@loongson.cn>
Date:   Fri, 9 Jun 2023 20:25:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/4] PCI/VGA: Use unsigned type for the io_state
 variable
Content-Language: en-US
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230609112417.632313-1-suijingfeng@loongson.cn>
 <ZIMRpbUHcW5qGFBU@ashyti-mobl2.lan>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <ZIMRpbUHcW5qGFBU@ashyti-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxZuQsGoNkJCULAA--.33833S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWrurWktFyxKry5trWUCr43XFc_yoW8Jry8pF
        W0y3Z5CFW0qrsrAFW2vFs5XF1ruwsrGFyxArWagry3uF13J3s7tFs0krWYqws7JryxZa1S
        vry5Wr1DWa98AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64
        vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4U
        JVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
        j55rcUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/6/9 19:48, Andi Shyti wrote:
> Hi Sui,
>
> On Fri, Jun 09, 2023 at 07:24:14PM +0800, Sui Jingfeng wrote:
>> The io_state variable in the vga_arb_write() function is declared with
>> unsigned int type, while the vga_str_to_iostate() function takes int *
>> type. To keep them consistent, replace the third argument of
>> vga_str_to_iostate() function with the unsigned int * type.
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Thanks a lot.
> Andi
>
>> ---
>>   drivers/pci/vgaarb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>> index 5a696078b382..c1bc6c983932 100644
>> --- a/drivers/pci/vgaarb.c
>> +++ b/drivers/pci/vgaarb.c
>> @@ -77,7 +77,7 @@ static const char *vga_iostate_to_str(unsigned int iostate)
>>   	return "none";
>>   }
>>   
>> -static int vga_str_to_iostate(char *buf, int str_size, int *io_state)
>> +static int vga_str_to_iostate(char *buf, int str_size, unsigned int *io_state)
>>   {
>>   	/* we could in theory hand out locks on IO and mem
>>   	 * separately to userspace but it can cause deadlocks */
>> -- 
>> 2.25.1

-- 
Jingfeng

