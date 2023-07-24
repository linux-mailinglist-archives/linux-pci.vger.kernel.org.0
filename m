Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8613C75E9F2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 05:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjGXDAY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jul 2023 23:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGXDAX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jul 2023 23:00:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21654185;
        Sun, 23 Jul 2023 20:00:18 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.108])
        by gateway (Coremail) with SMTP id _____8AxV_FA6b1kXvwIAA--.22978S3;
        Mon, 24 Jul 2023 11:00:16 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.108])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF8w56b1ki2U4AA--.48015S3;
        Mon, 24 Jul 2023 11:00:12 +0800 (CST)
Message-ID: <d7b825d7-0430-50b0-514a-8685362b640c@loongson.cn>
Date:   Mon, 24 Jul 2023 11:00:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.4 28/58] ALSA: hda: Add Loongson LS7A HD-Audio
 support
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@loongson.cn>, Takashi Iwai <tiwai@suse.de>,
        bhelgaas@google.com, perex@perex.cz, tiwai@suse.com,
        rafael@kernel.org, chenhuacai@kernel.org,
        gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com,
        mengyingkun@loongson.cn, fred.oh@linux.intel.com,
        kai.vehmanen@linux.intel.com, jasontao@glenfly.com,
        amadeuszx.slawinski@linux.intel.com, mkumard@nvidia.com,
        linux-pci@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230724011338.2298062-1-sashal@kernel.org>
 <20230724011338.2298062-28-sashal@kernel.org>
Content-Language: en-US
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20230724011338.2298062-28-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF8w56b1ki2U4AA--.48015S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1DAr43Jr1UZr47KryUurX_yoWrGrW8pr
        s5ZryjkFZ7tryYvFsrG3W7Kr97u3WDA3ZF9rW29w1xZFnavw1Sgas8ur4YvFWavry5WrW3
        WFWqk34xAayUtwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUP529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        kF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
        MxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
        0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
        14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
        vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8
        JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Sasha,

在 2023/7/24 09:12, Sasha Levin 写道:
> From: Yanteng Si <siyanteng@loongson.cn>
>
> [ Upstream commit 28bd137a3c8e105587ba8c55b68ef43b519b270f ]
>
> Add the new PCI ID 0x0014 0x7a07 and the new PCI ID 0x0014 0x7a37
> Loongson HDA controller.
>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> Link: https://lore.kernel.org/r/993587483b9509796b29a416f257fcfb4b15c6ea.1686128807.git.siyanteng@loongson.cn
Loongson HDA can't work if AUTOSEL only ports this one patch, because 
6.4 also needs the other three patches inside this thread. Also, 6.1, 
5.15, and 5.10 have the same problem.

Give me a shout if you need anything.

Thanks,
Yanteng
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   include/linux/pci_ids.h    | 3 +++
>   sound/hda/hdac_device.c    | 1 +
>   sound/pci/hda/hda_intel.c  | 7 +++++++
>   sound/pci/hda/patch_hdmi.c | 1 +
>   4 files changed, 12 insertions(+)
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 95f33dadb2be2..c0c4ca8e28510 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -158,6 +158,9 @@
>   
>   #define PCI_VENDOR_ID_LOONGSON		0x0014
>   
> +#define PCI_DEVICE_ID_LOONGSON_HDA      0x7a07
> +#define PCI_DEVICE_ID_LOONGSON_HDMI     0x7a37
> +
>   #define PCI_VENDOR_ID_TTTECH		0x0357
>   #define PCI_DEVICE_ID_TTTECH_MC322	0x000a
>   
> diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
> index 6c043fbd606f1..bbf7bcdb449a8 100644
> --- a/sound/hda/hdac_device.c
> +++ b/sound/hda/hdac_device.c
> @@ -645,6 +645,7 @@ struct hda_vendor_id {
>   };
>   
>   static const struct hda_vendor_id hda_vendor_ids[] = {
> +	{ 0x0014, "Loongson" },
>   	{ 0x1002, "ATI" },
>   	{ 0x1013, "Cirrus Logic" },
>   	{ 0x1057, "Motorola" },
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 3226691ac923c..9c353dc7740c4 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -237,6 +237,7 @@ enum {
>   	AZX_DRIVER_CTHDA,
>   	AZX_DRIVER_CMEDIA,
>   	AZX_DRIVER_ZHAOXIN,
> +	AZX_DRIVER_LOONGSON,
>   	AZX_DRIVER_GENERIC,
>   	AZX_NUM_DRIVERS, /* keep this as last entry */
>   };
> @@ -360,6 +361,7 @@ static const char * const driver_short_names[] = {
>   	[AZX_DRIVER_CTHDA] = "HDA Creative",
>   	[AZX_DRIVER_CMEDIA] = "HDA C-Media",
>   	[AZX_DRIVER_ZHAOXIN] = "HDA Zhaoxin",
> +	[AZX_DRIVER_LOONGSON] = "HDA Loongson",
>   	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
>   };
>   
> @@ -2809,6 +2811,11 @@ static const struct pci_device_id azx_ids[] = {
>   	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_HDMI },
>   	/* Zhaoxin */
>   	{ PCI_DEVICE(0x1d17, 0x3288), .driver_data = AZX_DRIVER_ZHAOXIN },
> +	/* Loongson HDAudio*/
> +	{PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_HDA),
> +	  .driver_data = AZX_DRIVER_LOONGSON },
> +	{PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_HDMI),
> +	  .driver_data = AZX_DRIVER_LOONGSON },
>   	{ 0, }
>   };
>   MODULE_DEVICE_TABLE(pci, azx_ids);
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 5c0b1a09fd57c..260d3e64f6589 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -4505,6 +4505,7 @@ static int patch_gf_hdmi(struct hda_codec *codec)
>    * patch entries
>    */
>   static const struct hda_device_id snd_hda_id_hdmi[] = {
> +HDA_CODEC_ENTRY(0x00147a47, "Loongson HDMI",	patch_generic_hdmi),
>   HDA_CODEC_ENTRY(0x1002793c, "RS600 HDMI",	patch_atihdmi),
>   HDA_CODEC_ENTRY(0x10027919, "RS600 HDMI",	patch_atihdmi),
>   HDA_CODEC_ENTRY(0x1002791a, "RS690/780 HDMI",	patch_atihdmi),

