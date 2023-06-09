Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC157297D3
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jun 2023 13:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjFILI3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 07:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjFILI2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 07:08:28 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DC441FDC;
        Fri,  9 Jun 2023 04:08:24 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxLusnCINk0QoBAA--.3209S3;
        Fri, 09 Jun 2023 19:08:23 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTMonCINk_uIKAA--.24411S3;
        Fri, 09 Jun 2023 19:08:23 +0800 (CST)
Message-ID: <0ee84d8a-d2c9-07d0-b738-61fc7c568444@loongson.cn>
Date:   Fri, 9 Jun 2023 19:08:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 4/4] PCI/VGA: Replace full MIT license text with SPDX
 identifier
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230609103321.629192-1-suijingfeng@loongson.cn>
 <20230609103321.629192-4-suijingfeng@loongson.cn> <87cz24rjgb.fsf@intel.com>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <87cz24rjgb.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxTMonCINk_uIKAA--.24411S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr4rZr4DJFW3Cr1kuw17Jwc_yoW5Xry7pr
        ySk3Z7CF4UXryxGrnFkr43tFy7X393AF47KFy7WFyS9rnFywn3Kr4qqr1rta43AFZ2k3yF
        vFy7XrWUWFnrZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j
        6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
        T7K3UUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/6/9 18:58, Jani Nikula wrote:
> On Fri, 09 Jun 2023, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>> Per Documentation/process/license-rules.rst, the SPDX MIT identifier is
>> equivalent to including the entire MIT license text from
>> LICENSES/preferred/MIT.
>>
>> Replace the MIT license text with the equivalent SPDX identifier.
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   include/linux/vgaarb.h | 30 +-----------------------------
>>   1 file changed, 1 insertion(+), 29 deletions(-)
>>
>> diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
>> index 6d5465f8c3f2..341245205e1c 100644
>> --- a/include/linux/vgaarb.h
>> +++ b/include/linux/vgaarb.h
>> @@ -1,32 +1,4 @@
>> -/*
>> - * The VGA aribiter manages VGA space routing and VGA resource decode to
>> - * allow multiple VGA devices to be used in a system in a safe way.
> Why is this being removed?
>
>> - *
>> - * (C) Copyright 2005 Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> - * (C) Copyright 2007 Paulo R. Zanoni <przanoni@gmail.com>
>> - * (C) Copyright 2007, 2009 Tiago Vignatti <vignatti@freedesktop.org>
> Replacing the license text with SPDX is fine, removing copyright notices
> is not.

Sorry, I'm mindless

I should keep the copyright notices(original authors) there.

I will respin this patch. Thanks for pointed out.

> BR,
> Jani.
>
>> - *
>> - * Permission is hereby granted, free of charge, to any person obtaining a
>> - * copy of this software and associated documentation files (the "Software"),
>> - * to deal in the Software without restriction, including without limitation
>> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> - * and/or sell copies of the Software, and to permit persons to whom the
>> - * Software is furnished to do so, subject to the following conditions:
>> - *
>> - * The above copyright notice and this permission notice (including the next
>> - * paragraph) shall be included in all copies or substantial portions of the
>> - * Software.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> - * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> - * DEALINGS
>> - * IN THE SOFTWARE.
>> - *
>> - */
>> +/* SPDX-License-Identifier: MIT */
>>   
>>   #ifndef LINUX_VGA_H
>>   #define LINUX_VGA_H

-- 
Jingfeng

