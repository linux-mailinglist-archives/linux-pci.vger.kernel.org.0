Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24377933EE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 05:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjIFDIa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 23:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjIFDI2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2023 23:08:28 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2881212A;
        Tue,  5 Sep 2023 20:08:22 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cx77sk7fdkkwsgAA--.5450S3;
        Wed, 06 Sep 2023 11:08:20 +0800 (CST)
Received: from [0.0.0.0] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF80j7fdk4u5tAA--.64736S3;
        Wed, 06 Sep 2023 11:08:19 +0800 (CST)
Message-ID: <abf8053d-4c4a-2562-b57f-db92a0cb15a7@loongson.cn>
Date:   Wed, 6 Sep 2023 11:08:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [Nouveau] [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user
 to select the primary video adapter at boot time
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <sui.jingfeng@linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <44ec8549-dc36-287e-4359-abd3ec8d22d6@suse.de>
 <5afd2efb-f838-f9b7-02a9-2cf4d4fd2382@loongson.cn>
 <773be4c6-0b3d-be39-7857-b3e2942007d9@suse.de>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <773be4c6-0b3d-be39-7857-b3e2942007d9@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF80j7fdk4u5tAA--.64736S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar4DuFWDJFyUXF1rCF4kAFc_yoW8JFW5pF
        W5tF18ta95WFWfAr97Jr409Fy0vrn5Jay8Xrn5WryDA3Z8Gr92v3y8t398Za4UC393Z3Wa
        yr90qas3KayDJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_GFv_Wrylx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcApnDU
        UUU
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/9/5 23:05, Thomas Zimmermann wrote:
> However, on modern Linux systems the primary display does not really 
> exist. 'Primary' is the device that is available via VGA, VESA or EFI. 

I may miss the point, what do you means by choose the word "modern"?
Are you trying to tell me that X server is too old and Wayland is the modern display server?


> Our drivers don't use these interfaces, but the native registers.


Yes and no?

Yes for the machine with the UEFI firmware,
but I not sure if this statement is true for the machine with the legacy firmware.

As the display controller in the ASpeed BMC is VGA compatible.
Therefore, in theory, it should works with the VGA console on the machine
with another VGA compatible video card. So the ast_vga_set_decode() function
provided in the 0007 patch probably useful on legacy firmware environment.

To be honest, I have tested this on various machine with UEFI firmware.
But I didn't realized that I should do the testing on legacy firmware environment
before sending this patch. It seems that the testing effort needed are quite
exhausting, since all my machines come with the UEFI firmware.

So is it OK to leave the legacy part to someone else who interested in it?
Probably Alex is more professional at legacy VGA routing stuff?
:-)


