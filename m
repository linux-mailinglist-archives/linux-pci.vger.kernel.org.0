Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365373F6F25
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 08:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbhHYGIj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 02:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232442AbhHYGIj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 02:08:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09BA46138B;
        Wed, 25 Aug 2021 06:07:50 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH V8 0/5] PCI: Loongson pci improvements and quirks 
Date:   Wed, 25 Aug 2021 14:07:19 +0800
Message-Id: <20210825060724.3385929-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset improves Loongson PCI controller driver and resolves some
problems: LS2K/LS7A's PCI config space supports 1/2/4-bytes access, so
the first patch use pci_generic_config_read()/pci_generic_config_write()
for them; the second patch add ACPI init support which will be used by
LoongArch; the third patch improves the mrrs quirk for LS7A chipset; The
fourth patch add a new quirk for LS7A chipset to avoid poweroff/reboot
failure, and the fifth patch add a new quirk for LS7A chipset to fix the
multifunction devices' irq pin mappings.

V1 -> V2:
1, Rework the 4th patch;
2, Improve commit messages;
3, Remove the last patch since there is better solutions.

V2 -> V3:
1, Add more affected device ids for the 4th patch;
2, Improve commit messages to describe root causes.

V3 -> V4:
1, Rework the MRRS quirk patch;
2, Improve commit messages to describe root causes, again.

V4 -> V5:
1, Improve the MRRS quirk patch;
2, Change the order of 2nd and 3rd patch;
3, Improve commit messages to describe root causes, again.

V5 -> V6:
1, Rework the 1st patch;
2, Adjust the order of the series.

V6 -> V7:
1, Use correct pci config access operations;
2, Add ACPI init support for LoongArch;
3, Don't move to quirks.c since the driver has ACPI support;
4, Some other minor improvements.

V7 -> V8:
1, Use CFG1 method for LS2K/LS7A pci config;

Huacai Chen, Tiezhu Yang and Jianmin Lv(5):
 PCI: loongson: Use correct pci config access operations.
 PCI: loongson: Add ACPI init support.
 PCI: Improve the MRRS quirk for LS7A.
 PCI: Add quirk for LS7A to avoid reboot failure.
 PCI: Add quirk for multifunction devices of LS7A.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn> 
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/acpi/pci_mcfg.c               |  13 +++
 drivers/pci/controller/Kconfig        |   2 +-
 drivers/pci/controller/pci-loongson.c | 184 ++++++++++++++++++++++++++--------
 drivers/pci/pci.c                     |   6 ++
 drivers/pci/pcie/portdrv_core.c       |   6 +-
 include/linux/pci-ecam.h              |   1 +
 include/linux/pci.h                   |   2 +
 7 files changed, 169 insertions(+), 45 deletions(-)
--
2.27.0

