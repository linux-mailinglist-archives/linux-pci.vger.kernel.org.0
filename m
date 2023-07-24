Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE51875F7BD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 15:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGXNDp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 09:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjGXNDV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 09:03:21 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC45B1FC9;
        Mon, 24 Jul 2023 06:02:34 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cx7+todr5kPTcJAA--.22197S3;
        Mon, 24 Jul 2023 21:02:32 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbSNndr5keTs5AA--.40503S3;
        Mon, 24 Jul 2023 21:02:32 +0800 (CST)
Message-ID: <0b4fef07-edc5-3e19-8399-39153e1df9d8@loongson.cn>
Date:   Mon, 24 Jul 2023 21:02:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] PCI/VGA: drop the inline of
 vga_update_device_decodes() function
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
 <20230711134354.755966-4-sui.jingfeng@linux.dev>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230711134354.755966-4-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxbSNndr5keTs5AA--.40503S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr43tw17tw4DGFy8WrW7trc_yoW8Kw1rpr
        93C3ZxGw47ZF12vryfJr15XrWrWayrCw4xJF9Fqw18Ca45Ar10yF1DJrZ5Gr97C39a9a1j
        vr4UXr1UWa1DXacCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
        Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j873
        kUUUUU=
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
> The vga_update_device_decodes() function is NOT a trivial function, It is
> not performance critical either. So, drop the inline.
>
> This patch also make the parameter and argument consistent, use unsigned
> int type instead of the signed type to store the decode. Change the second
> argument of vga_update_device_decodes() function as 'unsigned int' type.
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>   drivers/pci/vgaarb.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 021116ed61cb..668139f7c247 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -860,24 +860,24 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
>   	return ret;
>   }
>   
> -/* this is called with the lock */
> -static inline void vga_update_device_decodes(struct vga_device *vgadev,
> -					     int new_decodes)
> +/* This is called with the lock */
> +static void vga_update_device_decodes(struct vga_device *vgadev,
> +				      unsigned int new_decodes)
>   {
>   	struct device *dev = &vgadev->pdev->dev;
> -	int old_decodes, decodes_removed, decodes_unlocked;
> +	unsigned int old_decodes = vgadev->decodes;
> +	unsigned int decodes_removed = ~new_decodes & old_decodes;
> +	unsigned int decodes_unlocked = vgadev->locks & decodes_removed;
>   
> -	old_decodes = vgadev->decodes;
> -	decodes_removed = ~new_decodes & old_decodes;
> -	decodes_unlocked = vgadev->locks & decodes_removed;
>   	vgadev->decodes = new_decodes;
>   
> -	vgaarb_info(dev, "changed VGA decodes: olddecodes=%s,decodes=%s:owns=%s\n",
> -		vga_iostate_to_str(old_decodes),
> -		vga_iostate_to_str(vgadev->decodes),
> -		vga_iostate_to_str(vgadev->owns));
> +	vgaarb_info(dev,
> +		    "VGA decodes changed: olddecodes=%s,decodes=%s:owns=%s\n",
> +		    vga_iostate_to_str(old_decodes),
> +		    vga_iostate_to_str(vgadev->decodes),
> +		    vga_iostate_to_str(vgadev->owns));
>   
> -	/* if we removed locked decodes, lock count goes to zero, and release */
> +	/* If we removed locked decodes, lock count goes to zero, and release */
>   	if (decodes_unlocked) {
>   		if (decodes_unlocked & VGA_RSRC_LEGACY_IO)
>   			vgadev->io_lock_cnt = 0;

