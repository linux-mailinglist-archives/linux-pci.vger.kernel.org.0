Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302403B8E54
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 09:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhGAHq6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 03:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhGAHq6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 03:46:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F1FF61417;
        Thu,  1 Jul 2021 07:44:26 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH V6 0/4] PCI: Loongson-related pci quirks 
Date:   Thu,  1 Jul 2021 15:44:54 +0800
Message-Id: <20210701074458.1809532-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset resolve some Loongson-related pci problems: The first
patch improve the mrrs quirk for LS7A chipset. The second patch move
some LS7A quirks to quirks.c, where can be shared by multi archi-
tectures. The third patch add a new quirk for LS7A chipset to avoid
poweroff/reboot failure, and the fourth patch add a new quirk for LS7A
chipset to fix multifunction devices' irq pin mappings.

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

Huacai Chen, Tiezhu Yang and Jianmin Lv(4):
 PCI: Improve the MRRS quirk for LS7A.
 PCI: Move loongson pci quirks to quirks.c.
 PCI: Add quirk for LS7A to avoid reboot failure.
 PCI: Add quirk for multifunction devices of LS7A.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn> 
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c |  69 -----------------------
 drivers/pci/pci.c                     |   6 ++
 drivers/pci/pcie/portdrv_core.c       |   6 +-
 drivers/pci/quirks.c                  | 102 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h                   |   2 +
 include/linux/pci_ids.h               |  11 ++++
 6 files changed, 126 insertions(+), 70 deletions(-)
--
2.27.0

