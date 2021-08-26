Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387CA3F82FB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 09:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbhHZHQ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 03:16:59 -0400
Received: from foss.arm.com ([217.140.110.172]:40292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240155AbhHZHQt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 03:16:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA5CD1063;
        Thu, 26 Aug 2021 00:16:02 -0700 (PDT)
Received: from u200856.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 505AE3F5A1;
        Thu, 26 Aug 2021 00:16:02 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 3/4] PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
Date:   Thu, 26 Aug 2021 02:15:56 -0500
Message-Id: <20210826071557.29239-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210826071557.29239-1-jeremy.linton@arm.com>
References: <20210826071557.29239-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that there is a bcm2711 quirk, it needs to be enabled when the
MCFG is missing. Use an ACPI namespace _DSD property
"linux-ecam-quirk-id" as an alternative to the MCFG OEM.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_mcfg.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 53cab975f612..04c517418365 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	ALTRA_ECAM_QUIRK(1, 13),
 	ALTRA_ECAM_QUIRK(1, 14),
 	ALTRA_ECAM_QUIRK(1, 15),
+
+	{ "bc2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
+	  DEFINE_RES_MEM(0xFD500000, 0xA000) },
 };
 
 static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
@@ -198,8 +201,22 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
 	u16 segment = root->segment;
 	struct resource *bus_range = &root->secondary;
 	struct mcfg_fixup *f;
+	const char *soc;
 	int i;
 
+	/*
+	 * This may be a machine with a PCI/SMC conduit, which means it doesn't
+	 * have an MCFG. Use an ACPI namespace definition instead.
+	 */
+	if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
+					 "linux-ecam-quirk-id", &soc)) {
+		if (strlen(soc) != ACPI_OEM_ID_SIZE)
+			dev_err(&root->device->dev, "ECAM quirk should be %d characters\n",
+				ACPI_OEM_ID_SIZE);
+		else
+			memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
+	}
+
 	for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
 		if (pci_mcfg_quirk_matches(f, segment, bus_range)) {
 			if (f->cfgres.start)
-- 
2.31.1

