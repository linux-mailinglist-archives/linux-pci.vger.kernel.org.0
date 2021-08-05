Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734663E1DC4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 23:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbhHEVM1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 17:12:27 -0400
Received: from foss.arm.com ([217.140.110.172]:52430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241884AbhHEVMY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 17:12:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C262813D5;
        Thu,  5 Aug 2021 14:12:09 -0700 (PDT)
Received: from u200856.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 225F83F719;
        Thu,  5 Aug 2021 14:12:09 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 3/3] PCI/ACPI: Add new quirk detection, enable bcm2711
Date:   Thu,  5 Aug 2021 16:12:00 -0500
Message-Id: <20210805211200.491275-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210805211200.491275-1-jeremy.linton@arm.com>
References: <20210805211200.491275-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that we have a bcm2711 quirk, we need to be able to
detect it when the MCFG is missing. Use a namespace
property as an alternative to the MCFG OEM.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/pci_mcfg.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 53cab975f612..7d77fc72c2a4 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -169,6 +169,9 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	ALTRA_ECAM_QUIRK(1, 13),
 	ALTRA_ECAM_QUIRK(1, 14),
 	ALTRA_ECAM_QUIRK(1, 15),
+
+	{ "bcm2711", "", 0, 0, MCFG_BUS_ANY, &bcm2711_pcie_ops,
+	  DEFINE_RES_MEM(0xFD500000, 0xA000) },
 };
 
 static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
@@ -198,8 +201,19 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
 	u16 segment = root->segment;
 	struct resource *bus_range = &root->secondary;
 	struct mcfg_fixup *f;
+	const char *soc;
 	int i;
 
+	/*
+	 * This could be a machine with a PCI/SMC conduit,
+	 * which means it doens't have MCFG. Get the machineid from
+	 * the namespace definition instead.
+	 */
+	if (!fwnode_property_read_string(acpi_fwnode_handle(root->device),
+					 "linux,pcie-quirk", &soc)) {
+		memcpy(mcfg_oem_id, soc, ACPI_OEM_ID_SIZE);
+	}
+
 	for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
 		if (pci_mcfg_quirk_matches(f, segment, bus_range)) {
 			if (f->cfgres.start)
-- 
2.31.1

