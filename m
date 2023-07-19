Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C6A75A08D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 23:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGSV1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 17:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSV1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 17:27:44 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A37C1FC0;
        Wed, 19 Jul 2023 14:27:42 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8DxBfFNVbhkjXAHAA--.18836S3;
        Thu, 20 Jul 2023 05:27:41 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF8xLVbhkCBc1AA--.40637S3;
        Thu, 20 Jul 2023 05:27:39 +0800 (CST)
Message-ID: <bf783bdf-d9e9-127b-cad2-4e19a28b3702@loongson.cn>
Date:   Thu, 20 Jul 2023 05:27:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/6] PCI/VGA: Deal with PCI VGA compatible devices only
Content-Language: en-US
To:     Sui Jingfeng <sui.jingfeng@linux.dev>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20230719182617.GA509912@bhelgaas>
 <1a10cb43-7c96-069a-bdd2-3a8cdb7727e1@linux.dev>
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <1a10cb43-7c96-069a-bdd2-3a8cdb7727e1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF8xLVbhkCBc1AA--.40637S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXrykZr1kKw1kCw1kXw45CFX_yoW5ZFWfp3
        48G343G3y0qw1IgrW7ZF18CryUGFy5Ca4UJryftF18Ga12gwn7t3ZIvr4Y9ry5Jr4Fvr12
        yrs7K34Svw47AabCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26rWY6Fy7MI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU88cTPUUUU
        U==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2023/7/20 05:13, Sui Jingfeng wrote:
> Otherwise there 30+ noisy(useless) events got snooped. See below:
>
>
> ```
>
> [    0.246077] pci 0000:01:00.0: vgaarb: setting as boot VGA device
> [    0.246077] pci 0000:01:00.0: vgaarb: bridge control possible
> [    0.246077] pci 0000:01:00.0: vgaarb: VGA device added: 
> decodes=io+mem,owns=io+mem,locks=none
> [    0.246077] vgaarb: loaded
> [    0.294169] skl_uncore 0000:00:00.0: vgaarb: pci_notify: action=3
> [    0.294182] skl_uncore 0000:00:00.0: vgaarb: pci_notify: action=4
> [    0.301297] pcieport 0000:00:01.0: vgaarb: pci_notify: action=3
> [    0.301482] pcieport 0000:00:01.0: vgaarb: pci_notify: action=4
> [    0.301488] pcieport 0000:00:1c.0: vgaarb: pci_notify: action=3
> [    0.301705] pcieport 0000:00:1c.0: vgaarb: pci_notify: action=4
> [    1.806445] xhci_hcd 0000:00:14.0: vgaarb: pci_notify: action=3
> [    1.810976] ahci 0000:00:17.0: vgaarb: pci_notify: action=3
> [    1.824383] xhci_hcd 0000:00:14.0: vgaarb: pci_notify: action=4
> [    1.857470] ahci 0000:00:17.0: vgaarb: pci_notify: action=4
> [    4.692700] intel_pch_thermal 0000:00:14.2: vgaarb: pci_notify: 
> action=3
> [    4.693110] intel_pch_thermal 0000:00:14.2: vgaarb: pci_notify: 
> action=4
> [    4.746712] i801_smbus 0000:00:1f.4: vgaarb: pci_notify: action=3
> [    4.747212] pci 0000:00:1f.1: vgaarb: pci_notify: action=0
> [    4.747227] pci 0000:00:1f.1: vgaarb: pci_notify: action=1
> [    4.747250] pci 0000:00:1f.1: vgaarb: pci_notify: action=2
> [    4.749098] i801_smbus 0000:00:1f.4: vgaarb: pci_notify: action=4
> [    4.799217] mei_me 0000:00:16.0: vgaarb: pci_notify: action=3
> [    4.802503] mei_me 0000:00:16.0: vgaarb: pci_notify: action=4
> [    4.874880] intel-lpss 0000:00:15.0: vgaarb: pci_notify: action=3
> [    4.881227] intel-lpss 0000:00:15.0: vgaarb: pci_notify: action=4
> [    4.881240] intel-lpss 0000:00:15.1: vgaarb: pci_notify: action=3
> [    4.887578] intel-lpss 0000:00:15.1: vgaarb: pci_notify: action=4
> [    4.985796] r8169 0000:02:00.0: vgaarb: pci_notify: action=3
> [    4.991862] r8169 0000:02:00.0: vgaarb: pci_notify: action=4
> [    5.404835] snd_hda_intel 0000:00:1f.3: vgaarb: pci_notify: action=3
> [    5.405175] snd_hda_intel 0000:00:1f.3: vgaarb: pci_notify: action=4
> [    5.405401] snd_hda_intel 0000:01:00.1: vgaarb: pci_notify: action=3
> [    5.405973] snd_hda_intel 0000:01:00.1: vgaarb: pci_notify: action=4
> [   10.793665] i915 0000:00:02.0: vgaarb: pci_notify: action=3
> [   11.201384] i915 0000:00:02.0: vgaarb: pci_notify: action=4
> [   16.135842] amdgpu 0000:01:00.0: vgaarb: pci_notify: action=3
> [   16.140458] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
> [   16.638564] amdgpu 0000:01:00.0: vgaarb: pci_notify: action=4
>
> ``` 


After apply my patch, this events are still will notify me, it is just 
that if we found it is irrelevant, we will return immediately.

No further process is needed.

