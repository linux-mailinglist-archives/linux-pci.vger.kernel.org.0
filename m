Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59E67B7FEC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Oct 2023 14:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjJDM4C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Oct 2023 08:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjJDM4C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2023 08:56:02 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C4D8C4;
        Wed,  4 Oct 2023 05:55:56 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxTevaYB1l9hQvAA--.19264S3;
        Wed, 04 Oct 2023 20:55:54 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axzy_aYB1lniwYAA--.50792S3;
        Wed, 04 Oct 2023 20:55:54 +0800 (CST)
Message-ID: <f2209054-4e66-a084-c0bc-d35a7fd2fdad@loongson.cn>
Date:   Wed, 4 Oct 2023 20:55:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH pci-next v6 1/2] PCI/VGA: Make the
 vga_is_firmware_default() less arch-dependent
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231003155420.GA674372@bhelgaas>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20231003155420.GA674372@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Axzy_aYB1lniwYAA--.50792S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww48AFy7Kr47AFy8WFWfJFc_yoW3Xr15pF
        WrGF4fJFW8Wr4fGryaqF4qvFn0vwn5J34jkrWj9w1kCF98CrykXryFkrZ0934xJrZ7JF43
        ZF13JF1xWayDtFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
        CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXU
        UUUU=
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On 2023/10/3 23:54, Bjorn Helgaas wrote:
> On Mon, Oct 02, 2023 at 08:05:10PM +0800, Sui Jingfeng wrote:
>> Currently, the vga_is_firmware_default() function only works on x86 and
>> ia64, it is a no-op on the rest of the architectures. This patch completes
>> the implementation for it, the added code tries to capture the PCI (e) VGA
>> device that owns the firmware framebuffer, since only one GPU could own
>> the firmware fb, things are almost done once we have determined the boot
>> VGA device. As the PCI resource relocation do have a influence on the
>> results of identification, we make it available on architectures where PCI
>> resource relocation does happen at first. Because this patch is more
>> important for those architectures(such as arm, arm64, loongarch, mips and
>> risc-v etc).
> There's a little too much going on this this patch.  The problem is
> very simple: currently we compare firmware BAR assignments with BARs
> that may have been reassigned by Linux.
>
> What if we did something like the patch below?  I think it will be
> less confusing if we only have one copy of the code related to
> screen_info.
>
> Bjorn
>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/pci/vgaarb.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>> index 5e6b1eb54c64..02821c0f4cd0 100644
>> --- a/drivers/pci/vgaarb.c
>> +++ b/drivers/pci/vgaarb.c
>> @@ -60,6 +60,9 @@ static bool vga_arbiter_used;
>>   static DEFINE_SPINLOCK(vga_lock);
>>   static DECLARE_WAIT_QUEUE_HEAD(vga_wait_queue);
>>   
>> +/* The PCI(e) VGA device which owns the firmware framebuffer */
>> +static struct pci_dev *pdev_boot_vga;
>> +
>>   static const char *vga_iostate_to_str(unsigned int iostate)
>>   {
>>   	/* Ignore VGA_RSRC_IO and VGA_RSRC_MEM */
>> @@ -582,6 +585,9 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
>>   
>>   		return true;
>>   	}
>> +#else
>> +	if (pdev_boot_vga && pdev_boot_vga == pdev)
>> +		return true;
>>   #endif
>>   	return false;
>>   }
>> @@ -1557,3 +1563,73 @@ static int __init vga_arb_device_init(void)
>>   	return rc;
>>   }
>>   subsys_initcall_sync(vga_arb_device_init);
>> +
>> +/*
>> + * Get the physical address range that the firmware framebuffer occupies.
>> + *
>> + * Note that the global screen_info is arch-specific, thus CONFIG_SYSFB is
>> + * chosen as compile-time conditional to suppress linkage problems on non-x86
>> + * architectures.
>> + *
>> + * Returns true on success, otherwise return false.
>> + */
>> +static bool vga_arb_get_firmware_fb_range(u64 *start, u64 *end)
>> +{
>> +	u64 fb_start = 0;
>> +	u64 fb_size = 0;
>> +	u64 fb_end;
>> +
>> +#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_SYSFB)
>> +	fb_start = screen_info.lfb_base;
>> +	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
>> +		fb_start |= (u64)screen_info.ext_lfb_base << 32;
>> +
>> +	fb_size = screen_info.lfb_size;
>> +#endif
>> +
>> +	/* No firmware framebuffer support */
>> +	if (!fb_start || !fb_size)
>> +		return false;
>> +
>> +	fb_end = fb_start + fb_size - 1;
>> +
>> +	*start = fb_start;
>> +	*end = fb_end;
>> +
>> +	return true;
>> +}
>> +
>> +/*
>> + * Identify the PCI VGA device that contains the firmware framebuffer
>> + */
>> +static void pci_boot_vga_capturer(struct pci_dev *pdev)
>> +{
>> +	u64 fb_start, fb_end;
>> +	struct resource *res;
>> +	unsigned int i;
>> +
>> +	if (pdev_boot_vga)
>> +		return;
>> +
>> +	if (!vga_arb_get_firmware_fb_range(&fb_start, &fb_end))
>> +		return;
>> +
>> +	pci_dev_for_each_resource(pdev, res, i) {
>> +		if (resource_type(res) != IORESOURCE_MEM)
>> +			continue;
>> +
>> +		if (!res->start || !res->end)
>> +			continue;
>> +
>> +		if (res->start <= fb_start && fb_end <= res->end) {
>> +			pdev_boot_vga = pdev;
>> +
>> +			vgaarb_info(&pdev->dev,
>> +				    "BAR %u: %pR contains firmware FB [0x%llx-0x%llx]\n",
>> +				    i, res, fb_start, fb_end);
>> +			break;
>> +		}
>> +	}
>> +}
>> +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA,
>> +			       8, pci_boot_vga_capturer);
>
> PCI/VGA: Match firmware framebuffer before BAR reassignment
>
> vga_is_firmware_default() decides a device is the firmware default VGA
> device if it has a BAR that contains the framebuffer described by
> screen_info.
>
> Previously this was unreliable because the screen_info framebuffer address
> comes from firmware, and the Linux PCI core may reassign device BARs before
> vga_is_firmware_default() runs.  This reassignment means the BAR may not
> match the screen_info values, but we still want to select the device as the
> firmware default.
>
> Make vga_is_firmware_default() more reliable by running it as a quirk so it
> happens before any BAR reassignment.
>
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 5e6b1eb54c64..4a53e76caddd 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -60,6 +60,8 @@ static bool vga_arbiter_used;
>   static DEFINE_SPINLOCK(vga_lock);
>   static DECLARE_WAIT_QUEUE_HEAD(vga_wait_queue);
>   
> +static struct pci_dev *vga_firmware_device;
> +
>   static const char *vga_iostate_to_str(unsigned int iostate)
>   {
>   	/* Ignore VGA_RSRC_IO and VGA_RSRC_MEM */
> @@ -560,6 +562,7 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
>   	u64 base = screen_info.lfb_base;
>   	u64 size = screen_info.lfb_size;
>   	struct resource *r;
> +	unsigned int i;
>   	u64 limit;
>   
>   	/* Select the device owning the boot framebuffer if there is one */
> @@ -570,7 +573,7 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
>   	limit = base + size;
>   
>   	/* Does firmware framebuffer belong to us? */
> -	pci_dev_for_each_resource(pdev, r) {
> +	pci_dev_for_each_resource(pdev, r, i) {
>   		if (resource_type(r) != IORESOURCE_MEM)
>   			continue;
>   
> @@ -580,6 +583,8 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
>   		if (base < r->start || limit >= r->end)
>   			continue;
>   
> +		vgaarb_info(&pdev->dev, "BAR %u: %pR contains firmware framebuffer [%#010llx-%#010llx]\n",
> +			    i, r, base, limit - 1);
>   		return true;
>   	}
>   #endif
> @@ -623,7 +628,7 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
>   	if (boot_vga && boot_vga->is_firmware_default)
>   		return false;
>   
> -	if (vga_is_firmware_default(pdev)) {
> +	if (pdev == vga_firmware_device) {
>   		vgadev->is_firmware_default = true;
>   		return true;
>   	}
> @@ -1557,3 +1562,14 @@ static int __init vga_arb_device_init(void)
>   	return rc;
>   }
>   subsys_initcall_sync(vga_arb_device_init);
> +
> +static void vga_match_firmware_framebuffer(struct pci_dev *pdev)
> +{
> +	if (vga_firmware_device)
> +		return;
> +
> +	if (vga_is_firmware_default(pdev))
> +		vga_firmware_device = pdev;
> +}
> +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA,
> +			       8, vga_match_firmware_framebuffer);


Q: What if we did something like the patch below?

A:

But the vga_is_firmware_default() function only works on X86 and IA64,
you patch doesn't solve the problems on ARM64 and LoongArch.

Q:

I think it will be
less confusing if we only have one copy of the code related to
screen_info.

A:

Since you have already know everything, you can do anything with those two patch
if you would like to pick them up. As I have spend enough more time on this, if
two copy of the screen_info really matters, Would you mind to squash those two
patch into one?








