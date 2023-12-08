Return-Path: <linux-pci+bounces-723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 681D180B095
	for <lists+linux-pci@lfdr.de>; Sat,  9 Dec 2023 00:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10675B2097B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 23:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51725ABA4;
	Fri,  8 Dec 2023 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLXnIC45"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19A5AB83
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 23:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2C8C433C8;
	Fri,  8 Dec 2023 23:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702078220;
	bh=sQJJfOFlVFTuPvg2+4nGY9orsurru3DljPx/NhcBdmc=;
	h=From:To:Cc:Subject:Date:From;
	b=FLXnIC45X77IWjDNkt53NYQcpxGPd107eVhf/cdJ9U15myEJim++TELio0Ye4bq5J
	 WxtoyivUW0tuhuP2L0FKuuTvOy0s0PHYinr8KI1CQ2xnapviwpJBKsY+HJmgaAadW0
	 p/cNWtK1S397/DnvjWRnk2mekRNwaaL+5RHLMKFzWjsXDKJfu2ZE//CPrySrevxHdk
	 gnDIYfific9gLNUZLdP1R+WKzJAxalTdORNHvEj60jFDy9lh3gUbUtbNEPn7Cfwbg7
	 mU8r0wesbJ/1U+rB9qkq14YRIxbabENvVOor+vIJKWMsHw7ixTLZBiH3vSY77hKJvM
	 xgQ/WS/x+AxeA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Treat pci_scan_bridge_extend() 'pass' as int, not boolean
Date: Fri,  8 Dec 2023 17:30:16 -0600
Message-Id: <20231208233016.836687-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

pci_scan_bridge_extend() and pci_scan_bridge() are designed to be called
twice, with a "pass" parameter to indicate whether it's the first call
(pass 0) or the second (pass 1).

The "pass" is not a boolean, and callers supply 0 or 1.  For readability,
update tests to use "pass == 0" instead of "!pass" and "pass > 0" instead
of "pass".  Update the parameter type from "int" to "unsigned int".

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 11 ++++++-----
 include/linux/pci.h |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ed6b7f48736a..ce631d02621b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1252,7 +1252,7 @@ static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
  */
 static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 				  int max, unsigned int available_buses,
-				  int pass)
+				  unsigned int pass)
 {
 	struct pci_bus *child;
 	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
@@ -1284,7 +1284,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	}
 
 	/* Check if setup is sensible at all */
-	if (!pass &&
+	if (pass == 0 &&
 	    (primary != bus->number || secondary <= bus->number ||
 	     secondary > subordinate)) {
 		pci_info(dev, "bridge configuration invalid ([bus %02x-%02x]), reconfiguring\n",
@@ -1310,7 +1310,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * Bus already configured by firmware, process it in the
 		 * first pass and just note the configuration.
 		 */
-		if (pass)
+		if (pass > 0)
 			goto out;
 
 		/*
@@ -1344,7 +1344,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		 * We need to assign a number to this bus which we always
 		 * do in the second pass.
 		 */
-		if (!pass) {
+		if (pass == 0) {
 			if (pcibios_assign_all_busses() || broken || is_cardbus)
 
 				/*
@@ -1496,7 +1496,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
  *
  * Return: New subordinate number covering all buses behind this bridge.
  */
-int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
+int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
+		    unsigned int pass)
 {
 	return pci_scan_bridge_extend(bus, dev, max, 0, pass);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4ebecc7896ef..6b1f13e941bf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1616,7 +1616,7 @@ int pci_add_dynid(struct pci_driver *drv,
 const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
 					 struct pci_dev *dev);
 int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
-		    int pass);
+		    unsigned int pass);
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
-- 
2.34.1


