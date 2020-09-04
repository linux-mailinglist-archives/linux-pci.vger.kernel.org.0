Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8A025E08F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 19:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIDRIq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 13:08:46 -0400
Received: from foss.arm.com ([217.140.110.172]:54094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgIDRIp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Sep 2020 13:08:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCB621045;
        Fri,  4 Sep 2020 10:08:44 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B9D393F66F;
        Fri,  4 Sep 2020 10:08:44 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-acpi@vger.kernel.org
Cc:     tn@semihalf.com, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        steven.price@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        sudeep.holla@arm.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] PCI/ACPI: Suppress missing MCFG message
Date:   Fri,  4 Sep 2020 12:08:29 -0500
Message-Id: <20200904170829.431900-1-jeremy.linton@arm.com>
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

Lets only print an error if something is wrong with the
the given table/etc. The ACPI table list printed at boot
will continue to provide a way to detect when the table
is missing.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/pci_mcfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 54b36b7ad47d..0bc8c012f157 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -279,6 +279,6 @@ static __init int pci_mcfg_parse(struct acpi_table_header *header)
 void __init pci_mmcfg_late_init(void)
 {
 	int err = acpi_table_parse(ACPI_SIG_MCFG, pci_mcfg_parse);
-	if (err)
+	if (err && err != -ENODEV)
 		pr_err("Failed to parse MCFG (%d)\n", err);
 }
-- 
2.25.4

