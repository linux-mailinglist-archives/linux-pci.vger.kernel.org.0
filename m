Return-Path: <linux-pci+bounces-19696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEECA0C56E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 00:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FA73A1CB5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 23:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ED91FA8C7;
	Mon, 13 Jan 2025 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anx6QIs1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884D1FA8C3;
	Mon, 13 Jan 2025 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810168; cv=none; b=sjXXNSvcxGiyl8Ywz+uRNMk22ITkiS0U1gTgfolaxVx+zcJFzAjMI+UUX+OOt0AWJCfORPvgMkFlQp+0QVGOH4S+Xj3H9J2wGQW714NxplcppAH7AACgSij+SHht0rFWrJG4YJmRXVeqNY7zqC9KAqJFRe5fZSkUA96qEUW9sRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810168; c=relaxed/simple;
	bh=v1mS/gitgZcQKO+LBDc6/XGqUnicGeeNQepGI6TNS0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmkeyL59DPZwkxzJFR+aqtKodOExV3ETuKWv+Z4DHdosSuf7AXb7xx3ScDJRm9Bxy3dN+P3EOlVps85/WHgLs2xSMZD5LwwIAJAVW293I3zul5ADZqdoQ0a5cqZuviZ1Q+lWFwmQoA1p+oLcIt6YIjcRJGEn4c1nocfL4wAwbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anx6QIs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6D9C4CEE2;
	Mon, 13 Jan 2025 23:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736810167;
	bh=v1mS/gitgZcQKO+LBDc6/XGqUnicGeeNQepGI6TNS0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=anx6QIs1oxoTknp6/h7OoEy7M1yY1A6GkWOxXXeWB2EmiA+XAzI7einz0DnKjOVoQ
	 9ekqAPzMJzKPzGYak/TgKPmEvHVauOl9VPzFLjDdOZQnIN84yUQyd0+NTqEwOYHqJS
	 RML/YR0ZcFpWlljUYS1eSH9rZRAI6sSL24pG/ACtm2ybjquXGOmn0cS6LiNWtgXIZd
	 RxH3YqJ9J6/hwSfXwy8Zakzg7tcX9LOg2RuKYN1Rgt60uPcVvPlBWbdTrK/33y+tNR
	 e+nLYb8VUAx+9ndLv2KnSvTozlyuzhgK9wy7UFt38NEHvmpHIMNgRYfTgr+jytyaHp
	 FVS/TZBag4CdQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 3/4] PCI: of: Simplify devm_of_pci_get_host_bridge_resources() interface
Date: Mon, 13 Jan 2025 17:15:56 -0600
Message-Id: <20250113231557.441289-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113231557.441289-1-helgaas@kernel.org>
References: <20250113231557.441289-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Previously pci_parse_request_of_pci_ranges() supplied the default bus range
to devm_of_pci_get_host_bridge_resources(), but that function is static and
has no other callers, so there's no reason to complicate its interface by
passing the default bus range.

Drop the busno and bus_max parameters and use 0x0 and 0xff directly in
devm_of_pci_get_host_bridge_resources().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/of.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 48b9274b846e..a2acfc52caf4 100644
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
@@ -343,12 +340,15 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 
 	err = of_pci_parse_bus_range(dev_node, bus_range);
 	if (err) {
-		bus_range->start = busno;
-		bus_range->end = bus_max;
+		bus_range->start = 0;
+		bus_range->end = 0xff;
 		bus_range->flags = IORESOURCE_BUS;
 	} else {
-		if (bus_range->end > bus_range->start + bus_max)
-			bus_range->end = bus_range->start + bus_max;
+		if (bus_range->end > 0xff) {
+			dev_info(dev, "  Invalid end bus number in %pR, defaulting to 0xff\n",
+				 bus_range);
+			bus_range->end = 0xff;
+		}
 	}
 	pci_add_resource(resources, bus_range);
 
@@ -595,7 +595,7 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 	INIT_LIST_HEAD(&bridge->windows);
 	INIT_LIST_HEAD(&bridge->dma_ranges);
 
-	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &bridge->windows,
+	err = devm_of_pci_get_host_bridge_resources(dev, &bridge->windows,
 						    &bridge->dma_ranges, &iobase);
 	if (err)
 		return err;
-- 
2.34.1


