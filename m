Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6153F7B5219
	for <lists+linux-pci@lfdr.de>; Mon,  2 Oct 2023 14:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbjJBMFV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Oct 2023 08:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbjJBMFT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2023 08:05:19 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6872394;
        Mon,  2 Oct 2023 05:05:15 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxNuj5sRplz5MuAA--.35409S3;
        Mon, 02 Oct 2023 20:05:13 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxK9z3sRplVSEXAA--.47905S2;
        Mon, 02 Oct 2023 20:05:11 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH pci-next v6 0/2] PCI/VGA: Make the vga_is_firmware_default() less arch-dependent
Date:   Mon,  2 Oct 2023 20:05:09 +0800
Message-Id: <20231002120511.594737-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxK9z3sRplVSEXAA--.47905S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww45XryUWw4kGw43CFWDWrX_yoW3Ww43pr
        18Wa13Ww4kG3WrKrW7XF15CF15WrW8Ca97Jr1Igr48Cw4xKw18CF9IqF4jg347ArsFqw17
        X3Z7Aa4rtw17JagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
        wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8w0eJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The vga_is_firmware_default() only works on x86 and ia64 currently, it is
a no-op on the rest of the architectures. This patch completes the
implementation for it, the added code tries to capture the PCI (e) VGA
device that owns the firmware framebuffer before the PCI resource
relocation. Since only one GPU could owns the firmware fb in normal case,
things are almost done once we have determined the boot VGA device
successfully.

Note that this patch requires the target platform has a way to set up the
kernel's screen_info. On machines with muiltiple GPU co-exist and On UEFI
environment, the firmware framebuffer should be put into the VRAM BAR of
the primary GPU. For the arbitration purpose itself, changing PCI class
code of the GPU to be non-primary is not required.

The provided method is tested on x86, arm64 and loongarch, all of the
machine with UEFI firmware shipped.  See below for more information.

1) LS3A5000+LS7A1000 platform with three video cards:

$ lspci | grep VGA

00:06.1 VGA compatible controller: Loongson Technology LLC DC (Display Controller) (rev 01)
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Caicos XT [Radeon HD 7470/8470 / R5 235/310 OEM]
07:00.0 VGA compatible controller: S3 Graphics Ltd. Device 9070 (rev 01)
08:00.0 VGA compatible controller: S3 Graphics Ltd. Device 9070 (rev 01)

Before apply this series:

 pci 0000:00:06.1: vgaarb: setting as boot VGA device
 pci 0000:00:06.1: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
 pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 pci 0000:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 pci 0000:08:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 vgaarb: loaded

After apply this series:

 pci 0000:03:00.0: vgaarb: BAR 0: [mem 0xe0050000000-0xe005fffffff 64bit pref] contains firmware FB [0xe0050000000-0xe00500ea5ff]
 pci 0000:00:06.1: vgaarb: setting as boot VGA device
 pci 0000:03:00.0: vgaarb: setting as boot VGA device (overriding previous)
 pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 pci 0000:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 pci 0000:08:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 vgaarb: loaded

$ dmesg | grep 0000:03:00.0

 pci 0000:03:00.0: [1002:6778] type 00 class 0x030000
 pci 0000:03:00.0: reg 0x10: [mem 0xe0050000000-0xe005fffffff 64bit pref]
 pci 0000:03:00.0: reg 0x18: [mem 0xe0065300000-0xe006531ffff 64bit]
 pci 0000:03:00.0: reg 0x20: [io  0x20000-0x200ff]
 pci 0000:03:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
 pci 0000:03:00.0: vgaarb: BAR 0: [mem 0xe0050000000-0xe005fffffff 64bit pref] contains firmware FB [0xe0050000000-0xe00500ea5ff]
 pci 0000:03:00.0: BAR 0: assigned [mem 0xe0030000000-0xe003fffffff 64bit pref]
 pci 0000:03:00.0: BAR 2: assigned [mem 0xe0065200000-0xe006521ffff 64bit]
 pci 0000:03:00.0: BAR 6: assigned [mem 0xe0065220000-0xe006523ffff pref]
 pci 0000:03:00.0: BAR 4: assigned [io  0x5000-0x50ff]
 pci 0000:03:00.0: vgaarb: setting as boot VGA device (overriding previous)
 pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none

Loongson UEFI firmware does not support specify which GPU to be the primary,
the firmware set the ATI GPU(03:00.0) as the primary GPU with this hardware
configuration by hardcode. The problem is that VGAARB can not override the
platform integrated one(00:06.1) before apply this series.

Please note that BAR 0 of the ATI GPU moved by PCI core from
[0xe0050000000-0xe005fffffff] to [0xe0030000000-0xe003fffffff], the
vga_is_firmware_default() function will return wrong results by simply
remove #ifdefs while without take relocation into account.


2) ARM64 (Kunpeng 920) with three video card:

Before apply this series:

 pci 0000:02:00.0: vgaarb: setting as boot VGA device
 pci 0000:02:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 pci 0000:05:00.0: vgaarb: setting as boot VGA device (overriding previous) <--- (Because it has IO or MEM enabled)
 pci 0000:05:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 pci 0000:06:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 vgaarb: loaded

After apply this series:

 pci 0000:05:00.0: vgaarb: BAR 0: [mem 0x80010000000-0x8001fffffff 64bit pref] contains firmware FB [0x80010000000-0x800101e77ff]
 pci 0000:02:00.0: vgaarb: setting as boot VGA device
 pci 0000:02:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 pci 0000:05:00.0: vgaarb: Boot VGA selected by firmware
 pci 0000:05:00.0: vgaarb: setting as boot VGA device (overriding previous) <--- (Because it owns firmware framebuffer)
 pci 0000:05:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 pci 0000:06:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 vgaarb: loaded

3) x86 with three video card

lspci | grep VGA
05:00.0 VGA compatible controller: Silicon Motion, Inc. SM750 (rev a1)
0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 [Radeon RX 5600 OEM/5600 XT / 5700/5700 XT] (rev c1)
0d:00.0 VGA compatible controller: Jingjia Microelectronics Co Ltd Device 9100 (rev 01)

Before apply this series:

 pci 0000:05:00.0: vgaarb: setting as boot VGA device
 pci 0000:05:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 pci 0000:0c:00.0: vgaarb: setting as boot VGA device (overriding previous)
 pci 0000:0c:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
 pci 0000:0d:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 vgaarb: loaded
 amdgpu 0000:0c:00.0: vgaarb: deactivate vga console
 amdgpu 0000:0c:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+me

After apply this series:

 pci 0000:0c:00.0: vgaarb: BAR 0: [mem 0xa0000000-0xafffffff 64bit pref] contains firmware FB [0xa0000000-0xa1fa3fff]
 pci 0000:05:00.0: vgaarb: setting as boot VGA device
 pci 0000:05:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 pci 0000:0c:00.0: vgaarb: Boot VGA selected by firmware
 pci 0000:0c:00.0: vgaarb: setting as boot VGA device (overriding previous)
 pci 0000:0c:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
 pci 0000:0d:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 vgaarb: loaded
 amdgpu 0000:0c:00.0: vgaarb: deactivate vga console
 amdgpu 0000:0c:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem


v2:
	* Fix test robot warnnings and fix typos
v3:
	* Fix linkage problems if the global screen_info is not exported
v4:
	* Handle linkage problems by hiding behind of CONFIG_SYSFB,
	* Drop side-effects and simplify.
v5:
	* Print the BAR and the framebuffer region (Bjorn)
	* Use pci_dev_for_each_resource() (Bjorn)
	* Cleanup the old mechanisms (Bjorn)
	* Make the commit log simple by moving the extraneous details to cover letter (Bjorn)
	* Carry on test on arm64
v6:
	* Resolve merge conflect on pci-next branch.

Sui Jingfeng (2):
  PCI/VGA: Make the vga_is_firmware_default() less arch-dependent
  PCI/VGA: Remove vga_is_firmware_default() function

 drivers/pci/vgaarb.c | 116 ++++++++++++++++++++++++++++---------------
 1 file changed, 76 insertions(+), 40 deletions(-)


base-commit: 87ab156b7bb2a117a79692a96239c667f5b4f08e
-- 
2.34.1

