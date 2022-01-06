Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394F9485CD1
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 01:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245743AbiAFAHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 19:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245727AbiAFAHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 19:07:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40891C061245;
        Wed,  5 Jan 2022 16:07:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D247A619AC;
        Thu,  6 Jan 2022 00:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC323C36AE9;
        Thu,  6 Jan 2022 00:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641427632;
        bh=QkmWR8jOZfsoz9AfOFqa0DRvfcUZSPmcIrXXakZWhTg=;
        h=From:To:Cc:Subject:Date:From;
        b=bD7l2zPBD+FVFyMhuyn1JR30B2VDAEvl/qVMTbxCtvl1EPvDKaL8x207hCulQRYbD
         mt5oljuFdWaefcTFn41v/eaPAZt9oiLHSd3VFFBXW5GVrdgJOwCI99XZbRIRQVuww7
         PvF0N+rDjzw8XLQ57I1YriLebZ0pzaeq88tQVvWjhpy6H/ZwCv1WU7QG/dA1dcUXbi
         GESc0dlaGBtF70qBUaxvnVDFZm+hBAXV0bOwJXLcND3S1WaTXtT9GextdVGusVcqer
         VLS2/8KobZTBqZ4OTNf2f/hI5q2lulO6A+SAL5qBPCsptjVpkczEZK+WvY63fFOr/q
         nw+4kU7lNyo6Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 00/10] vgaarb: Rework default VGA device selection
Date:   Wed,  5 Jan 2022 18:06:48 -0600
Message-Id: <20220106000658.243509-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Current default VGA device selection fails in some cases because part of it
is done in the vga_arb_device_init() subsys_initcall, and some arches
enumerate PCI devices in pcibios_init(), which runs *after* that.

For example:

  - On BMC system, the AST2500 bridge [1a03:1150] does not implement
    PCI_BRIDGE_CTL_VGA.  This is perfectly legal but means the legacy VGA
    resources won't reach downstream devices unless they're included in the
    usual bridge windows.

  - vga_arb_select_default_device() will set a device below such a bridge
    as the default VGA device as long as it has PCI_COMMAND_IO and
    PCI_COMMAND_MEMORY enabled.

  - vga_arbiter_add_pci_device() is called for every VGA device, either at
    boot-time or at hot-add time, and it will also set the device as the
    default VGA device, but ONLY if all bridges leading to it implement
    PCI_BRIDGE_CTL_VGA.

  - This difference between vga_arb_select_default_device() and
    vga_arbiter_add_pci_device() means that a device below an AST2500 or
    similar bridge can only be set as the default if it is enumerated
    before vga_arb_device_init().

  - On ACPI-based systems, PCI devices are enumerated by acpi_init(), which
    runs before vga_arb_device_init().

  - On non-ACPI systems, like on MIPS system, they are enumerated by
    pcibios_init(), which typically runs *after* vga_arb_device_init().

This series consolidates all the default VGA device selection in
vga_arbiter_add_pci_device(), which is always called after enumerating a
PCI device.

Almost all the work here is Huacai's.  I restructured it a little bit and
added a few trivial patches on top.

I'd like to move vgaarb.c to drivers/pci eventually, but there's another
initcall ordering snag that needs to be resolved first, so this leaves 
it where it is.

Bjorn

Version history:
V0 original implementation as final quirk to set default device.
https://lore.kernel.org/r/20210514080025.1828197-6-chenhuacai@loongson.cn

V1 rework vgaarb to do all default device selection in
vga_arbiter_add_pci_device().
https://lore.kernel.org/r/20210705100503.1120643-1-chenhuacai@loongson.cn

V2 move arbiter to PCI subsystem, fix nits.
https://lore.kernel.org/r/20210722212920.347118-1-helgaas@kernel.org

V3 rewrite the commit log of the last patch (which is also summarized
by Bjorn).
https://lore.kernel.org/r/20210820100832.663931-1-chenhuacai@loongson.cn

V4 split the last patch to two steps.
https://lore.kernel.org/r/20210827083129.2781420-1-chenhuacai@loongson.cn

V5 split Patch-9 again and sort the patches.
https://lore.kernel.org/r/20210911093056.1555274-1-chenhuacai@loongson.cn

V6 split Patch-5 again and sort the patches again.
https://lore.kernel.org/r/20210916082941.3421838-1-chenhuacai@loongson.cn

V7 stop moving vgaarb to drivers/pci because of ordering issues with
misc_init().
https://lore.kernel.org/r/20211015061512.2941859-1-chenhuacai@loongson.cn
https://lore.kernel.org/r/CAAhV-H7FhAjM-Ha42Z1dLrE4PvC9frfyeU27KHWcyWKkMftEsA@mail.gmail.com


Bjorn Helgaas (8):
  vgaarb: Factor out vga_select_framebuffer_device()
  vgaarb: Factor out default VGA device selection
  vgaarb: Move framebuffer detection to ADD_DEVICE path
  vgaarb: Move non-legacy VGA detection to ADD_DEVICE path
  vgaarb: Move disabled VGA device detection to ADD_DEVICE path
  vgaarb: Remove empty vga_arb_device_card_gone()
  vgaarb: Use unsigned format string to print lock counts
  vgaarb: Replace full MIT license text with SPDX identifier

Huacai Chen (2):
  vgaarb: Move vga_arb_integrated_gpu() earlier in file
  vgaarb: Log bridge control messages when adding devices

 drivers/gpu/vga/vgaarb.c | 311 +++++++++++++++++++--------------------
 1 file changed, 154 insertions(+), 157 deletions(-)

-- 
2.25.1

