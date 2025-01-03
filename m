Return-Path: <linux-pci+bounces-19260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B7A00FDD
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 22:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1616188298E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 21:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B5B1C3C02;
	Fri,  3 Jan 2025 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKXdZqoO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826291C3BF7;
	Fri,  3 Jan 2025 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735939900; cv=none; b=ew7thKR4OjgJKbvVsGe1okcnon6ovs0ahQuFzDH0Fkxmz+sMg1Ise4rsHpJVvyH4F9rnRfdySMqntYvbPgLNpwE4OLbg3tCdKpsq9168Sgj7w13Bh0PLeD7KFTLtMn1ERkpOPB/T8ARVBApjN3mKzhLglsIZVzqx0tb+t5rFnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735939900; c=relaxed/simple;
	bh=ztOb7Bjbdt8/rOh3nZBMwe5FXbP3NIWGLtLshH98ct8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BLlm2r+SM0JLcZrIC/tCCbaY5JqXSmzkCh+a/XAV6l89okLvH7aqaGGw+MC6tTmAkHc0MBsHL5CPYXH+WtOkCBW1JkCQHwQ/xsR2UBy6eWy0cg18/Oo6+iA6H2jQor+z3FmzufEFwTf84yEhl7HgBZcIjzIU70886FQG5JgH4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKXdZqoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC2DC4CED7;
	Fri,  3 Jan 2025 21:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735939900;
	bh=ztOb7Bjbdt8/rOh3nZBMwe5FXbP3NIWGLtLshH98ct8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MKXdZqoOf6LEH5y3eWn5fPO0k1j+4ekhPXyt/ieCCAaz8YT9GR4Kavz8CxrxW5R+K
	 tpkQIxXqFBuydnalmcYKGfISPQKeUpyk/ttzWqgfxFx2nYgn9fqSZT5vZ0FPpOuako
	 DJ4aFwJrhlPYuuJBO7flSU7arTKY8IB9XsreLo5tu+GC/UptTzPSUByTMo720kqTeA
	 hFt7kN7T8UABoqEk5DsZ1mZR+VpHF9MrORM8EceNI9RDTqG+EHysIG4puDJDvQ4tw8
	 sAAmqyGVP3DfhzUYheIhaM5iEj/jJdRVo2J7VjujYgfpAvkysOyheeBEg7odAuFHRL
	 oMTcj+p3RLOhw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] PCI: of: Simplify bus range parsing
Date: Fri,  3 Jan 2025 15:31:28 -0600
Message-Id: <20250103213129.5182-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103213129.5182-1-helgaas@kernel.org>
References: <20250103213129.5182-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

of_pci_parse_bus_range() looks for a DT "bus-range" property.  If none
exists, devm_of_pci_get_host_bridge_resources() defaults to the [bus 00-ff]
range supplied by its caller, pci_parse_request_of_pci_ranges().

devm_of_pci_get_host_bridge_resources() is static and has no other callers,
so there's no reason to complicate its interface by passing the default bus
range.

Drop the busno and bus_max parameters and use 0x0 and 0xff directly in
devm_of_pci_get_host_bridge_resources().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/of.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 2f579b691f8e..02cba51e4ca4 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -302,8 +302,6 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
  * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
  *                                           host bridge resources from DT
  * @dev: host bridge device
- * @busno: bus number associated with the bridge root bus
- * @bus_max: maximum number of buses for this bridge
  * @resources: list where the range of resources will be added after DT parsing
  * @ib_resources: list where the range of inbound resources (with addresses
  *                from 'dma-ranges') will be added after DT parsing
@@ -319,7 +317,6 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
  * value if it failed.
  */
 static int devm_of_pci_get_host_bridge_resources(struct device *dev,
-			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources,
 			struct list_head *ib_resources,
 			resource_size_t *io_base)
@@ -343,8 +340,8 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 
 	err = of_pci_parse_bus_range(dev_node, bus_range);
 	if (err) {
-		bus_range->start = busno;
-		bus_range->end = bus_max;
+		bus_range->start = 0;
+		bus_range->end = 0xff;
 		bus_range->flags = IORESOURCE_BUS;
 		dev_info(dev, "  No bus range found for %pOF, using %pR\n",
 			 dev_node, bus_range);
@@ -597,7 +594,7 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 	INIT_LIST_HEAD(&bridge->windows);
 	INIT_LIST_HEAD(&bridge->dma_ranges);
 
-	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &bridge->windows,
+	err = devm_of_pci_get_host_bridge_resources(dev, &bridge->windows,
 						    &bridge->dma_ranges, &iobase);
 	if (err)
 		return err;
-- 
2.34.1


