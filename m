Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A33563F2A
	for <lists+linux-pci@lfdr.de>; Sat,  2 Jul 2022 11:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiGBJHs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Jul 2022 05:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiGBJHs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Jul 2022 05:07:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7919719C01
        for <linux-pci@vger.kernel.org>; Sat,  2 Jul 2022 02:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 164C860AE5
        for <linux-pci@vger.kernel.org>; Sat,  2 Jul 2022 09:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A1FC34114;
        Sat,  2 Jul 2022 09:07:43 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V15 1/7] PCI/ACPI: Guard ARM64-specific mcfg_quirks
Date:   Sat,  2 Jul 2022 17:08:02 +0800
Message-Id: <20220702090808.1221300-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220702090808.1221300-1-chenhuacai@loongson.cn>
References: <20220702090808.1221300-1-chenhuacai@loongson.cn>
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

Guard ARM64-specific quirks with CONFIG_ARM64 to avoid build errors,
since mcfg_quirks will be shared by more than one architectures.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/acpi/pci_mcfg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 53cab975f612..63b98eae5e75 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -41,6 +41,8 @@ struct mcfg_fixup {
 static struct mcfg_fixup mcfg_quirks[] = {
 /*	{ OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, ops, cfgres }, */
 
+#ifdef CONFIG_ARM64
+
 #define AL_ECAM(table_id, rev, seg, ops) \
 	{ "AMAZON", table_id, rev, seg, MCFG_BUS_ANY, ops }
 
@@ -169,6 +171,7 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	ALTRA_ECAM_QUIRK(1, 13),
 	ALTRA_ECAM_QUIRK(1, 14),
 	ALTRA_ECAM_QUIRK(1, 15),
+#endif /* ARM64 */
 };
 
 static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
-- 
2.27.0

