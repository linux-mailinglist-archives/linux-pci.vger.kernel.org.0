Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF76F791DDB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 21:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjIDT5n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 15:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjIDT5n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 15:57:43 -0400
Received: from out-230.mta1.migadu.com (out-230.mta1.migadu.com [95.215.58.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB0F180
        for <linux-pci@vger.kernel.org>; Mon,  4 Sep 2023 12:57:39 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693857456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FYKJvWL/qZgH1oNH2DJwbsBn+zY36FSv76Wxof0/Hpw=;
        b=ahZRccD3k1MiGRI8O0BWNWRD3IedOUtr/0keRN1KW1Sx8oxxGBC/H8Fk52Fj8jEpSRkMCU
        UHifg3825MK625kjMOhTvVz9nwlZISqtuuktamAc+GlDkFDhz8QxW5+KAoxBAwZGU1L9k4
        DZC8AnO8nWX01emVpChRA3WXuoiRVQQ=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [RFC,drm-misc-next v4 0/9] PCI/VGA: Allowing the user to select the primary video adapter at boot time
Date:   Tue,  5 Sep 2023 03:57:15 +0800
Message-Id: <20230904195724.633404-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

On a machine with multiple GPUs, a Linux user has no control over which
one is primary at boot time. This series tries to solve above mentioned
problem by introduced the ->be_primary() function stub. The specific
device drivers can provide an implementation to hook up with this stub by
calling the vga_client_register() function.

Once the driver bound the device successfully, VGAARB will call back to
the device driver. To query if the device drivers want to be primary or
not. Device drivers can just pass NULL if have no such needs.

Please note that:

1) The ARM64, Loongarch, Mips servers have a lot PCIe slot, and I would
   like to mount at least three video cards.

2) Typically, those non-86 machines don't have a good UEFI firmware
   support, which doesn't support select primary GPU as firmware stage.
   Even on x86, there are old UEFI firmwares which already made undesired
   decision for you.

3) This series is attempt to solve the remain problems at the driver level,
   while another series[1] of me is target to solve the majority of the
   problems at device level.

Tested (limited) on x86 with four video card mounted, Intel UHD Graphics
630 is the default boot VGA, successfully override by ast2400 with
ast.modeset=10 append at the kernel cmd line.

$ lspci | grep VGA

 00:02.0 VGA compatible controller: Intel Corporation CoffeeLake-S GT2 [UHD Graphics 630]
 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Caicos XTX [Radeon HD 8490 / R5 235X OEM]
 04:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 30)
 05:00.0 VGA compatible controller: NVIDIA Corporation GK208B [GeForce GT 720] (rev a1)

$ sudo dmesg | grep vgaarb

 pci 0000:00:02.0: vgaarb: setting as boot VGA device
 pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
 pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 pci 0000:04:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 pci 0000:05:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
 vgaarb: loaded
 ast 0000:04:00.0: vgaarb: Override as primary by driver
 i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
 radeon 0000:01:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=none
 ast 0000:04:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=none

v2:
	* Add a simple implemment for drm/i915 and drm/ast
	* Pick up all tags (Mario)
v3:
	* Fix a mistake for drm/i915 implement
	* Fix patch can not be applied problem because of merge conflect.
v4:
	* Focus on solve the real problem.

v1,v2 at https://patchwork.freedesktop.org/series/120059/
   v3 at https://patchwork.freedesktop.org/series/120562/

[1] https://patchwork.freedesktop.org/series/122845/

Sui Jingfeng (9):
  PCI/VGA: Allowing the user to select the primary video adapter at boot
    time
  drm/nouveau: Implement .be_primary() callback
  drm/radeon: Implement .be_primary() callback
  drm/amdgpu: Implement .be_primary() callback
  drm/i915: Implement .be_primary() callback
  drm/loongson: Implement .be_primary() callback
  drm/ast: Register as a VGA client by calling vga_client_register()
  drm/hibmc: Register as a VGA client by calling vga_client_register()
  drm/gma500: Register as a VGA client by calling vga_client_register()

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 11 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 13 ++++-
 drivers/gpu/drm/ast/ast_drv.c                 | 31 ++++++++++
 drivers/gpu/drm/gma500/psb_drv.c              | 57 ++++++++++++++++++-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 15 +++++
 drivers/gpu/drm/i915/display/intel_vga.c      | 15 ++++-
 drivers/gpu/drm/loongson/loongson_module.c    |  2 +-
 drivers/gpu/drm/loongson/loongson_module.h    |  1 +
 drivers/gpu/drm/loongson/lsdc_drv.c           | 10 +++-
 drivers/gpu/drm/nouveau/nouveau_vga.c         | 11 +++-
 drivers/gpu/drm/radeon/radeon_device.c        | 10 +++-
 drivers/pci/vgaarb.c                          | 43 ++++++++++++--
 drivers/vfio/pci/vfio_pci_core.c              |  2 +-
 include/linux/vgaarb.h                        |  8 ++-
 14 files changed, 210 insertions(+), 19 deletions(-)

-- 
2.34.1

