Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B113F9621
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 10:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhH0Icn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 04:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231824AbhH0Icn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 04:32:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A85EE60F4F;
        Fri, 27 Aug 2021 08:31:52 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V4 00/10] PCI/VGA: Rework default VGA device selection
Date:   Fri, 27 Aug 2021 16:31:19 +0800
Message-Id: <20210827083129.2781420-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

My original work is at [1].

Bjorn do some rework and extension in V2. It moves the VGA arbiter to
the PCI subsystem, fixes a few nits, and breaks a few pieces to make
the main patch a little smaller.

V3 rewrite the commit log of the last patch (which is also summarized
by Bjorn).

V4 split the last patch to two steps.

All comments welcome!

[1] https://lore.kernel.org/dri-devel/20210705100503.1120643-1-chenhuacai@loongson.cn/

Bjorn Helgaas (4):
  PCI/VGA: Move vgaarb to drivers/pci
  PCI/VGA: Replace full MIT license text with SPDX identifier
  PCI/VGA: Use unsigned format string to print lock counts
  PCI/VGA: Remove empty vga_arb_device_card_gone()

Huacai Chen (6):
  PCI/VGA: Move vga_arb_integrated_gpu() earlier in file
  PCI/VGA: Prefer vga_default_device()
  PCI/VGA: Split out vga_arb_update_default_device()
  PCI/VGA: Log bridge control messages when adding devices
  PCI/VGA: Rework default VGA device selection (Step 1)
  PCI/VGA: Rework default VGA device selection (Step 2)

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com> 
---
 drivers/gpu/vga/Kconfig           |  19 ---
 drivers/gpu/vga/Makefile          |   1 -
 drivers/pci/Kconfig               |  19 +++
 drivers/pci/Makefile              |   1 +
 drivers/{gpu/vga => pci}/vgaarb.c | 269 ++++++++++++------------------
 5 files changed, 126 insertions(+), 183 deletions(-)
 rename drivers/{gpu/vga => pci}/vgaarb.c (90%)
--
2.27.0

