Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27FA3B6FC3
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhF2I5A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 04:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232491AbhF2I46 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jun 2021 04:56:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E512361D9E;
        Tue, 29 Jun 2021 08:54:29 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH V5 0/4] PCI: Loongson-related pci quirks 
Date:   Tue, 29 Jun 2021 16:55:17 +0800
Message-Id: <20210629085521.2976352-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset resolve some Loongson-related pci problems (however, some
of them affect not only Loongon platform). The first patch has been sent
before, and nearly all reviewers' questions had been answered at that
time [1]. The second patch move some LS7A quirks to quirks.c, where can
be shared by multi architectures. The third patch improve the mrrs quirk
for LS7A chipset, and the fourth patch add a new quirk for LS7A chipset.

[1] http://patchwork.ozlabs.org/project/linux-pci/patch/1600680138-10949-1-git-send-email-chenhc@lemote.com/

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

Huacai Chen, Tiezhu Yang and Jianmin Lv(4):
 PCI/portdrv: Don't disable device during shutdown.
 PCI: Improve the MRRS quirk for LS7A.
 PCI: Move loongson pci quirks to quirks.c.
 PCI: Add quirk for multifunction devices of LS7A.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn> 
---
 drivers/pci/controller/pci-loongson.c | 69 -----------------------------
 drivers/pci/pci.c                     |  6 +++
 drivers/pci/pcie/portdrv.h            |  2 +-
 drivers/pci/pcie/portdrv_core.c       |  6 ++-
 drivers/pci/pcie/portdrv_pci.c        | 15 ++++++-
 drivers/pci/quirks.c                  | 81 +++++++++++++++++++++++++++++++++++
 include/linux/pci.h                   |  1 +
 include/linux/pci_ids.h               | 11 +++++
 8 files changed, 117 insertions(+), 74 deletions(-)
--
2.27.0

