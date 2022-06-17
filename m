Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD16F54F218
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 09:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379989AbiFQHma (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 03:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380098AbiFQHmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 03:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4CF674EF
        for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2022 00:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6187F61F30
        for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2022 07:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37925C3411B;
        Fri, 17 Jun 2022 07:42:20 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH V14 0/7] PCI: Loongson pci improvements and quirks 
Date:   Fri, 17 Jun 2022 15:43:23 +0800
Message-Id: <20220617074330.12605-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
1, Use CFG1 method for LS2K/LS7A pci config.

V8 -> V9:
1, Use pci_controller_data for the first patch. 

V9 -> V10:
1, Add a patch to avoid LS2K/LS7A access unexisting devices.

V10 -> V11:
1, Rebased on 5.16-rc4.

V11 -> V12:
1, Rebased on 5.17-rc5.

V12 -> V13:
1, Rebased on 5.18-rc2;
2, Some minor improvements (adopt Rob Herring's suggestions).

V13 -> V14:
1, Rebased on 5.18;
2, Split ARM64-specific mcfg_quirks to a separate patch;
3, Refactor "PCI: loongson: Don't access non-existant devices";
4, Refactor "PCI: Add quirk for LS7A to avoid reboot failure";
5, Some other minor improvements (adopt Bjorn's suggestions).

Huacai Chen, Tiezhu Yang and Jianmin Lv(6):
 PCI/ACPI: Guard ARM64-specific mcfg_quirks
 PCI: loongson: Use generic 8/16/32-bit config ops on LS2K/LS7A.
 PCI: loongson: Add ACPI init support.
 PCI: loongson: Don't access non-existant devices.
 PCI: loongson: Improve the MRRS quirk for LS7A.
 PCI: Add quirk for LS7A to avoid reboot failure.
 PCI: Add quirk for multifunction devices of LS7A.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn> 
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/acpi/pci_mcfg.c               |  13 ++
 drivers/pci/controller/Kconfig        |   2 +-
 drivers/pci/controller/pci-loongson.c | 233 ++++++++++++++++++++++++++--------
 drivers/pci/pci.c                     |   6 +
 drivers/pci/pcie/portdrv_core.c       |   1 -
 drivers/pci/pcie/portdrv_pci.c        |  20 ++-
 include/linux/pci-ecam.h              |   1 +
 include/linux/pci.h                   |   2 +
 8 files changed, 225 insertions(+), 53 deletions(-)
--
2.27.0

