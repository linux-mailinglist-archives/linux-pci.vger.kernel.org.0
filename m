Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5B03804C5
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 10:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhENIBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 04:01:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233325AbhENIBQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 04:01:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7892261446;
        Fri, 14 May 2021 08:00:03 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jingfeng Sui <suijingfeng@loongson.cn>
Subject: [PATCH 0/5] PCI: Loongson-related pci quirks
Date:   Fri, 14 May 2021 16:00:20 +0800
Message-Id: <20210514080025.1828197-1-chenhuacai@loongson.cn>
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
The last patch fix a problem of ASpeed AST2500, which is used as BMC by
some Loongson-based server boards.

[1] http://patchwork.ozlabs.org/project/linux-pci/patch/1600680138-10949-1-git-send-email-chenhc@lemote.com/

Huacai Chen, Tiezhu Yang, Jianmin Lv and Jingfeng Sui(5):
 PCI/portdrv: Don't disable pci device during shutdown.
 PCI: Move loongson pci quirks to quirks.c.
 PCI: Improve the mrrs quirk for LS7A.
 PCI: Add quirk for multifunction devices of LS7A.
 PCI: Support ASpeed VGA cards behind a misbehaving bridge.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn> 
Signed-off-by: Jingfeng Sui <suijingfeng@loongson.cn> 
---
 drivers/pci/controller/pci-loongson.c |  69 -----------------
 drivers/pci/pci.c                     |   5 ++
 drivers/pci/pcie/portdrv.h            |   2 +-
 drivers/pci/pcie/portdrv_core.c       |   6 +-
 drivers/pci/pcie/portdrv_pci.c        |  15 +++-
 drivers/pci/quirks.c                  | 139 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h                   |   2 +
 7 files changed, 164 insertions(+), 74 deletions(-)
--
2.27.0

