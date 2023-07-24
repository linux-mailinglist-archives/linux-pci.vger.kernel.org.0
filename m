Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336BD75F7BA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 15:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGXNDd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 09:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjGXNDM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 09:03:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CD7F19A5;
        Mon, 24 Jul 2023 06:02:16 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cxc_BWdr5kKTcJAA--.23093S3;
        Mon, 24 Jul 2023 21:02:14 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxniNWdr5kYjs5AA--.49082S3;
        Mon, 24 Jul 2023 21:02:14 +0800 (CST)
Message-ID: <6c8ca3a6-5898-ccba-cd01-9622215ddd10@loongson.cn>
Date:   Mon, 24 Jul 2023 21:02:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] PCI/VGA: Move the new_state assignment out the loop
Content-Language: en-US
To:     Sui Jingfeng <sui.jingfeng@linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
References: <20230711134354.755966-1-sui.jingfeng@linux.dev>
 <20230711134354.755966-5-sui.jingfeng@linux.dev>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230711134354.755966-5-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxniNWdr5kYjs5AA--.49082S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr43tw13Gw13Zw4xAF1xCrX_yoW8Ww1kpr
        ZYvFyfCFZ7XF1IkrWaqr1UXrZ5W3s5t3yxAFWj934DWFWDJa4rtryfJrW5KrnrCrZ3uayj
        yr15GFy7ZayUXFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
        Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jb_-
        PUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PING, please !


On 2023/7/11 21:43, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
>
> In the vga_arbiter_notify_clients() function, the value of the 'new_state'
> variable will be 'false' on systems that have more than one PCI VGA card.
> Its value will be 'true' on systems that have one or no PCI VGA compatible
> card. In other words, its value is not relevant to the iteration, so move
> the assignment () out of the loop.
>
> For a system with multiple video cards, this patch saves the redundant
> assignment.
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>   drivers/pci/vgaarb.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 668139f7c247..4c448c758bab 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -1468,22 +1468,20 @@ static void vga_arbiter_notify_clients(void)
>   {
>   	struct vga_device *vgadev;
>   	unsigned long flags;
> -	uint32_t new_decodes;
> -	bool new_state;
> +	bool state;
>   
>   	if (!vga_arbiter_used)
>   		return;
>   
> +	state = (vga_count > 1) ? false : true;
> +
>   	spin_lock_irqsave(&vga_lock, flags);
>   	list_for_each_entry(vgadev, &vga_list, list) {
> -		if (vga_count > 1)
> -			new_state = false;
> -		else
> -			new_state = true;
>   		if (vgadev->set_decode) {
> -			new_decodes = vgadev->set_decode(vgadev->pdev,
> -							 new_state);
> -			vga_update_device_decodes(vgadev, new_decodes);
> +			unsigned int decodes;
> +
> +			decodes = vgadev->set_decode(vgadev->pdev, state);
> +			vga_update_device_decodes(vgadev, decodes);
>   		}
>   	}
>   	spin_unlock_irqrestore(&vga_lock, flags);

