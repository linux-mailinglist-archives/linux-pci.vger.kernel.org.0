Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA89F2621A6
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 23:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgIHVEW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 17:04:22 -0400
Received: from foss.arm.com ([217.140.110.172]:35344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgIHVEW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 17:04:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DED031B;
        Tue,  8 Sep 2020 14:04:21 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 776D13F68F;
        Tue,  8 Sep 2020 14:04:21 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-acpi@vger.kernel.org
Cc:     tn@semihalf.com, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        steven.price@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        sudeep.holla@arm.com, guohanjun@huawei.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2] PCI/ACPI: Suppress missing MCFG message
Date:   Tue,  8 Sep 2020 16:03:59 -0500
Message-Id: <20200908210359.569294-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MCFG is an optional ACPI table. Given there are machines
without PCI(e) (or it is hidden) we have been receiving
queries/complaints about what this message means given
its being presented as an error.

Lets reduce the severity, the ACPI table list printed at
boot will continue to provide another way to detect when
the table is missing.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/pci_mcfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 54b36b7ad47d..c8ef3bb5aa00 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -280,5 +280,5 @@ void __init pci_mmcfg_late_init(void)
 {
 	int err = acpi_table_parse(ACPI_SIG_MCFG, pci_mcfg_parse);
 	if (err)
-		pr_err("Failed to parse MCFG (%d)\n", err);
+		pr_debug("Failed to parse MCFG (%d)\n", err);
 }
-- 
2.25.4

