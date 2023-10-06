Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6DD7BB660
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 13:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjJFLXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 07:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjJFLXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 07:23:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 313C583;
        Fri,  6 Oct 2023 04:23:09 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8CxyOgb7h9li4IvAA--.55266S3;
        Fri, 06 Oct 2023 19:23:07 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxri8C7h9lgVIZAA--.53378S3;
        Fri, 06 Oct 2023 19:23:02 +0800 (CST)
Message-ID: <f903cf7c-4b9d-a6e6-5047-9d4ee0df283f@loongson.cn>
Date:   Fri, 6 Oct 2023 19:22:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [-next 4/5] drm/virgpu: Switch to pci_is_vga()
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        David Airlie <airlied@redhat.com>
References: <20231005215714.GA792609@bhelgaas>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20231005215714.GA792609@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cxri8C7h9lgVIZAA--.53378S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF4Uur1xJr4kWr13JryDCFX_yoW8tw1rpF
        WrGFyFkryftFW7K392qF1fuFyYva9aqFyfCFsY93sI9r98tw15Zry0kr13WrW7Zrs7CF4S
        yw4v9F1Ig3ZF9rXCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/10/6 05:57, Bjorn Helgaas wrote:
> In subject: "drm/virtio" to match previous history.
>
> On Wed, Aug 30, 2023 at 07:15:31PM +0800, Sui Jingfeng wrote:
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> Should be no functional change, just for cleanup purpose.
>>
>> Cc: David Airlie <airlied@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Gurchetan Singh <gurchetansingh@chromium.org>
>> Cc: Chia-I Wu <olvaffe@gmail.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
>> index add075681e18..3a368304475a 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>> @@ -51,7 +51,7 @@ static int virtio_gpu_pci_quirk(struct drm_device *dev)
>>   {
>>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
>>   	const char *pname = dev_name(&pdev->dev);
>> -	bool vga = (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
>> +	bool vga = pci_is_vga(pdev);
> This *is* a functional change: Previously "vga" was only true for
> PCI_CLASS_DISPLAY_VGA (0x0300).  Now it will be true for both
> PCI_CLASS_DISPLAY_VGA (0x0300) and PCI_CLASS_DISPLAY_OTHER (0x0380).
>
> Is that desirable?  I can't tell.  Maybe the GPU folks will chime in.
>

Yes, the vga variable still will be "true" for the PCI_CLASS_DISPLAY_VGA (0x0300) class code,
and this is the major case. But the devices with PCI_CLASS_NOT_DEFINED_VGA class code are quite
uncommon, and virtio gpu is virtual GPU driver, It is unlikely that the QEMU to emulate a
old device with PCI_CLASS_NOT_DEFINED_VGA class code. I means that there no reason to do so.
Am I correct? Is there anyone know more?

For virtio virtual GPU driver, I would like to drop this patch, if no one response.

We probably only need to consider PCI_CLASS_NOT_DEFINED_VGA case for the real (probably old) hardware device.
It do exists, as Maciej mention at [1].

[1] https://lkml.org/lkml/2023/6/18/315


>>   	int ret;
>>   
>>   	DRM_INFO("pci: %s detected at %s\n",
>> -- 
>> 2.34.1
>>

