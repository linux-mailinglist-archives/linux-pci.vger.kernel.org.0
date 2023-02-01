Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18776685E78
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 05:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBAEa0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 23:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBAEaX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 23:30:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE2FFF3F
        for <linux-pci@vger.kernel.org>; Tue, 31 Jan 2023 20:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 487D6CE228C
        for <linux-pci@vger.kernel.org>; Wed,  1 Feb 2023 04:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7528C433EF;
        Wed,  1 Feb 2023 04:30:16 +0000 (UTC)
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
Subject: [PATCH V4 0/2] PCI: Resolve Loongson's LS7A PCI problems
Date:   Wed,  1 Feb 2023 12:30:16 +0800
Message-Id: <20230201043018.778499-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patchset attempt to resolves Loongson's LS7A PCI problems: the
first patch remove pci_disable_device() in pcie_portdrv_remove() to
avoid poweroff/reboot failure; the second patch improves the mrrs quirk
for LS7A chipset; 

V1 -> V2:
1, Update commit messages and comments.

V2 -> V3:
1, Simply remove pci_disable_device() in pcie_port_device_remove() to
   solve poweroff/reboot failure.
2, Update commit messages and comments.

V3 -> V4:
1, Just remove pci_disable_device() in pcie_portdrv_shutdown() and keep
   pcie_portdrv_remove() be the same logic as before.

Huacai Chen, Tiezhu Yang and Jianmin Lv(2):
 PCI: Omit pci_disable_device() in .shutdown().
 PCI: loongson: Improve the MRRS quirk for LS7A.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn> 
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 44 ++++++++++++-----------------------
 drivers/pci/pci.c                     |  6 +++++
 drivers/pci/pcie/portdrv.c            | 16 +++++++++++--
 include/linux/pci.h                   |  1 +
 4 files changed, 36 insertions(+), 31 deletions(-)
--
2.27.0

