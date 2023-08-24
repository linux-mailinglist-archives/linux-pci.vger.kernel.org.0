Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0917787370
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbjHXPDm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 11:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbjHXPDj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 11:03:39 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC69D19A6;
        Thu, 24 Aug 2023 08:03:35 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxZ+hFcedkmJAbAA--.20381S3;
        Thu, 24 Aug 2023 23:03:33 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c5EcedkEYBiAA--.42989S2;
        Thu, 24 Aug 2023 23:03:32 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: [PATCH v5 0/2] PCI/VGA: Make the vga_is_firmware_default() less arch-dependent
Date:   Thu, 24 Aug 2023 23:03:30 +0800
Message-Id: <20230824150332.6434-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx_c5EcedkEYBiAA--.42989S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww48Xr1ftFyUtrW8uFyxCrX_yoW3AFW8pr
        18Wa13Ww4kG3WrKrW7XF15CF1YgrW8Ca97Jr1Igr48Cw4xKw18CF9IqF4jg347ArnFqw17
        X3Z7Aa4rtw17JagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
        6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jea0PUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the vga_is_firmware_default() function only works on x86 and
ia64, it is a no-op on the rest of the architectures. This patch completes
the implementation for it, the added code tries to capture the PCI (e) VGA
device that owns the firmware framebuffer address range before the PCI
resource relocation. Since only one GPU could owns the firmware fb in
normal case, things are almost done once we have determined the boot VGA
successfully.

Note that this patch requires the target platform has a way to set up the
kernel's screen_info. On muiltiple GPU co-exist machines, the firmware
framebuffer should be put into the VRAM BAR of the primary GPU. While
changing PCI class code of the GPU to be non-primary is not required for
the arbitration purpose.

The provided method is effective at least on x86, arm64 and loongarch, see
below for more testing information.


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
 pci 0000:00:06.1: vgaarb: bridge control possible
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
 pci 0000:03:00.0: vgaarb: bridge control possible
 pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none

Loongson UEFI firmware does not support specify which GPU to be the primary,
the firmware set the ATI GPU(03:00.0) as the primary GPU with this hardware
configuration by hardcode. However, the firmware do support passing the
screen_into the to kernel. The problem is that VGAARB can not override the
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

Sui Jingfeng (2):
  PCI/VGA: Make the vga_is_firmware_default() less arch-dependent
  PCI/VGA: Remove vga_is_firmware_default() function

 drivers/pci/vgaarb.c | 116 ++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 41 deletions(-)


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.34.1

