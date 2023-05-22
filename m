Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CF270B4E1
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 08:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjEVGHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 02:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEVGHi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 02:07:38 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 120AEDB;
        Sun, 21 May 2023 23:07:33 -0700 (PDT)
Received: from [192.168.43.203] (unknown [113.140.11.4])
        by sr0414.icoremail.net (Coremail) with SMTP id AQAAfwDHvSqBBmtkL08HAw--.36433S3;
        Mon, 22 May 2023 14:06:59 +0800 (CST)
Message-ID: <36474dbb-5020-9044-b47c-cb377fa5dea7@stu.xidian.edu.cn>
Date:   Mon, 22 May 2023 14:07:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] PCI: dwc: keystone: Free IRQ in `ks_pcie_remove` and the
 error handling section of `ks_pcie_probe`
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ZGPeUNqznHKETgqs@bhelgaas>
From:   =?UTF-8?B?5pu+56Wl57+8?= <xyzeng@stu.xidian.edu.cn>
In-Reply-To: <ZGPeUNqznHKETgqs@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwDHvSqBBmtkL08HAw--.36433S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyrAry8ZFWftr1furWDtwb_yoW5Aw4rpF
        4DJF1qkF4kJFyUu347CaySqFyF9rs5Ary7t3s2k3s8uFn8XFW5tryxKr4ag3ZrCr4kJ3W2
        qayUKr9ruFWruFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
        04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUqEoXUUUUU
X-CM-SenderInfo: p012v0vj6v33wo0lvxldqovvfxof0/
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17/5/2023 03:49, Bjorn Helgaas wrote:
> On Tue, May 16, 2023 at 01:16:59PM +0800, Xiangyi Zeng wrote:
>> Smatch complains that:
>> drivers/pci/controller/dwc/pci-keystone.c:1303 ks_pcie_probe() warn:
>> 'irq' from request_irq() not released on lines: 1183,1187,1303.
> Make this the entire warning line from smatch with no extra newlines
> inserted.
Thank you for the suggestion. I will put the warning in one line.
>> "ks-pcie-error-irq" was requested in the `ks_pcie_probe` function, but
>> was not freed neither in the error handling part of `ks_pcie_probe`
>> nor in the `ks_pcie_remove` function.
>>
>> Fix this by adding `free_irq` in `ks_pcie_remove` and in a new error
>> handling label `err_alloc` after `err_link` in `ks_pcie_probe`. In
>> `ks_pcie_probe`, if `phy` or `link` memory allocation fails, we will
>> fall to `err_alloc`. If any other error occurs that leads to
>> `err_get_sync` or `err_link`, we end up going to `err_alloc`.
> I think the backticks (`) are markdown that makes these "code".
> Personally I think ks_pcie_probe() is more readable than
> `ks_pcie_probe` since most people (I think) read these in plain-ASCII
> situations.  And using backticks for labels and local variables seems
> like overkill.
>
Sorry for my wrong usage of backticks. I agree that it would be more
readable to use plain-ASCII names for functions and variables. I will
make sure to update the comment message and the subject.
>> Fixes: 0790eb175ee0 ("PCI: keystone: Cleanup error_irq configuration")
>> Signed-off-by: Xiangyi Zeng <xyzeng@stu.xidian.edu.cn>
>> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> It's best if the Reviewed-by tag is not added until Dongliang sends
> email with that tag directly to the mailing list.  Internal reviews
> before posting to the mailing list aren't worth much.
In our internal review process, only the patch with the Reviewed-by
tag can be submitted to the mailing list. You can check this in our
google group.
https://groups.google.com/g/hust-os-kernel-patches/c/bt397rzVL24/m/l52XYbG4AgAJ
We will consider omitting this tag when sending to the kernel mailing
list in the future.
>> @@ -1309,12 +1316,14 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
>>   	struct device_link **link = ks_pcie->link;
>>   	int num_lanes = ks_pcie->num_lanes;
>>   	struct device *dev = &pdev->dev;
>> +	int irq = platform_get_irq(pdev, 0);
> I think it's better to save the irq we looked up in ks_pcie_probe()
> and free *that*.  It's probably the same thing you get by calling
> platform_get_irq() again, but it seems cleaner to me to save what we
> got in ks_pcie_probe().
Thanks for your guidance. I agree with saving the irq to make code cleaner.
I will change it in the next version.
>>   	pm_runtime_put(dev);
>>   	pm_runtime_disable(dev);
>>   	ks_pcie_disable_phy(ks_pcie);
>>   	while (num_lanes--)
>>   		device_link_del(link[num_lanes]);
>> +	free_irq(irq, ks_pcie);
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.34.1
>>

