Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12E565BB47
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 08:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjACHdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 02:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjACHdr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 02:33:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC175F71
        for <linux-pci@vger.kernel.org>; Mon,  2 Jan 2023 23:33:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A1B76115B
        for <linux-pci@vger.kernel.org>; Tue,  3 Jan 2023 07:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04AEC433EF;
        Tue,  3 Jan 2023 07:33:42 +0000 (UTC)
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
Subject: [PATCH 0/2] PCI: Add two Loongson's LS7A quirks 
Date:   Tue,  3 Jan 2023 15:33:59 +0800
Message-Id: <20230103073401.1256736-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
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

Hi, Bjorn,

This patchset add two quirks to resolves Loongson's LS7A problems: the
first patch improves the mrrs quirk for LS7A chipset; The second patch
add a new quirk for LS7A chipset to avoid poweroff/reboot failure.

You said you would think about these two patches carefully, so after a
lont time I rebase them on top of the latest code and resend them to see
if you have new considerations now. :)

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

