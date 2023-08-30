Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1B78DB6A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 20:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbjH3SjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 14:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243659AbjH3LYf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 07:24:35 -0400
X-Greylist: delayed 527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 04:24:31 PDT
Received: from out-249.mta0.migadu.com (out-249.mta0.migadu.com [91.218.175.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DB9CC9
        for <linux-pci@vger.kernel.org>; Wed, 30 Aug 2023 04:24:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693394142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UVeRm0Qrmz75iUlOftz3q81yqnv4xdH4SnIPvu/ykCw=;
        b=W95kqu/ASc4Qs/CReJBbbTSbzo/SKUxrTDVGenwuNHcHC+YPzK6nTL0dE/FnvhvVGL+EVL
        +o9jXFnzfT8tqzMePgE++xHgB8Eq67I/GHwxgL897XP063iC3VO/n4sPzSqCd3vNip2tnA
        CWEzxYinutWzWIQ+Y/V+XdejXsahLUg=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [-next 0/5] Add the pci_is_vga() helper and use it
Date:   Wed, 30 Aug 2023 19:15:27 +0800
Message-Id: <20230830111532.444535-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

The PCI code and ID assignment specification defined four types of
display controllers for the display base class(03h), and the devices
with 0x00h sub-class code are VGA devices. VGA devices with programming
interface 0x00 is VGA-compatible, VGA devices with programming interface
0x01 are 8514-compatible controllers. Besides, PCI_CLASS_NOT_DEFINED_VGA
is defined to provide backward compatibility for devices that were built
before the class code field was defined. Thus, PCI(e) device with the
PCI_CLASS_NOT_DEFINED_VGA class code should also be handled as the normal
VGA-compatible devices.

Compared with the "if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)" code,
the newly implemented pci_is_vga() is shorter and straightforward. So it
is more easy to use. It is designed as a inline function, the more common
case "if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA))" is put before the
less common case "if ((pdev->class >> 8) == PCI_CLASS_NOT_DEFINED_VGA)",
so there should no performance penalty.

Sui Jingfeng (5):
  PCI: Add the pci_is_vga() helper
  PCI/VGA: Deal with VGA devices
  PCI/sysfs: Use pci_is_vga() helper
  drm/virgpu: Switch to pci_is_vga()
  drm/qxl: Switch to pci_is_vga()

 drivers/gpu/drm/qxl/qxl_drv.c        | 11 +++--------
 drivers/gpu/drm/virtio/virtgpu_drv.c |  2 +-
 drivers/pci/pci-sysfs.c              |  6 +++---
 drivers/pci/vgaarb.c                 | 19 +++++++++----------
 include/linux/pci.h                  | 27 +++++++++++++++++++++++++++
 5 files changed, 43 insertions(+), 22 deletions(-)


base-commit: 43cc31da9146f9ce60e4a03d96ef0807c2cdac94
-- 
2.34.1

