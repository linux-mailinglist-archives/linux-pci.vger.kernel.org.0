Return-Path: <linux-pci+bounces-20064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9EDA153C7
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 17:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E771884F53
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3DE1946C7;
	Fri, 17 Jan 2025 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZILPxJOS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D518B495;
	Fri, 17 Jan 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130244; cv=none; b=VcOvKC+v0eYXBOYzRY73+TmEzyEjxMDOVRX6v74JxDha+HP8AzrUOQiHgKosamoNSePyHt6b3WsBDslDVc4CP7rqzvOTIc+SGZjwl4f5PpresiDvgk9J7GcWNF61qPt2LCTXRn7jnMIMsLsz24/hQWuiEbAxWIQ7DPWxUU2m0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130244; c=relaxed/simple;
	bh=il2zcIXZqecb4B2mgeVYxgCDRxXi29ozzPisuPiFSDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RIbDsg1ABGFusqh72nU9XqjTQ5i3XrEXe1hCYy989v45b5laTzflZR39ot+bKADrfiUkNWV8hREoP9JxuIxuWaZ5rcpW7jQCaDksSwopwMcIj0tuFwVcLadDk5sm7NwiqTwHDCRYRR7202Hzd4y1fRJOPbvRnw0imbQvoFk57Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZILPxJOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F754C4CEDD;
	Fri, 17 Jan 2025 16:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737130242;
	bh=il2zcIXZqecb4B2mgeVYxgCDRxXi29ozzPisuPiFSDA=;
	h=From:To:Cc:Subject:Date:From;
	b=ZILPxJOSxXmUeT1nX6KhtttIBeaCLwAGkoNjJf8YaZaLLzf3aW6CMLFrax4OeJUO1
	 dCxq8YzHsxObekaZHIXnPYm3t52QxLOb7f3zK4B9WT/Ym1TG5t8d4dB9pfYCfjCRas
	 OA6Vg+j6RE1N+4MJ9h++PgCtmE0jby/AqTtLqQ/BMeZeNq7YUwTw3cb8wkndo6roXz
	 nxIGVIk5QjhkwumKcQjCTEcI5TRBoD7dEHrfl1dMwZBa2DzFbTpkB+VHRDN0oHYAqE
	 K+P96ddKVYKB+Uh0r8Nz1qo0u+cah08hInMAChVRXTMwVNb1+K3p+yaxCecdZJnYOg
	 o2F6Cvw0W9LOg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: of_property: Rename struct of_pci_range to of_pci_range_entry
Date: Fri, 17 Jan 2025 10:10:37 -0600
Message-Id: <20250117161037.643953-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Previously there were two definitions of struct of_pci_range: one in
include/linux/of_address.h and another local to drivers/pci/of_property.c.

Rename the local struct of_pci_range to of_pci_range_entry to avoid
confusion.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/of_property.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 886c236e5de6..58fbafac7c6a 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -26,7 +26,7 @@ struct of_pci_addr_pair {
  * side and the child address is the corresponding address on the secondary
  * side.
  */
-struct of_pci_range {
+struct of_pci_range_entry {
 	u32		child_addr[OF_PCI_ADDRESS_CELLS];
 	u32		parent_addr[OF_PCI_ADDRESS_CELLS];
 	u32		size[OF_PCI_SIZE_CELLS];
@@ -101,7 +101,7 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
 static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
 			      struct device_node *np)
 {
-	struct of_pci_range *rp;
+	struct of_pci_range_entry *rp;
 	struct resource *res;
 	int i, j, ret;
 	u32 flags, num;
-- 
2.34.1


