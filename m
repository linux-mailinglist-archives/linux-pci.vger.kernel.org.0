Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11C1146D33
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2019 02:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfFOAaE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 20:30:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:46446 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfFOAaE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 20:30:04 -0400
Received: from ufdda393ec48b57.ant.amazon.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5F0TfFS010961;
        Fri, 14 Jun 2019 19:29:50 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/4] pci: Do not auto-enable PCI reallocation when _DSM #5 returns 0
Date:   Sat, 15 Jun 2019 10:23:58 +1000
Message-Id: <20190615002359.29577-3-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190615002359.29577-1-benh@kernel.crashing.org>
References: <20190615002359.29577-1-benh@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This prevents auto-enabling of bridges reallocation when the FW tells
us that the initial configuration must be preserved for a given host
bridge.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/pci/setup-bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 0cdd5ff389de..049a5602b942 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1684,10 +1684,16 @@ static enum enable_type pci_realloc_detect(struct pci_bus *bus,
 					   enum enable_type enable_local)
 {
 	bool unassigned = false;
+	struct pci_host_bridge *hb;
 
 	if (enable_local != undefined)
 		return enable_local;
 
+	/* Don't realloc if ACPI tells us not to */
+	hb = pci_find_host_bridge(bus);
+	if (hb->preserve_config)
+		return auto_disabled;
+
 	pci_walk_bus(bus, iov_resources_unassigned, &unassigned);
 	if (unassigned)
 		return auto_enabled;
-- 
2.17.1

