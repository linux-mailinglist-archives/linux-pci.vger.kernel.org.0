Return-Path: <linux-pci+bounces-19694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F78A0C56A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 00:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F74166B56
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 23:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B241F9F70;
	Mon, 13 Jan 2025 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3sDAR08"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9B61F9F69;
	Mon, 13 Jan 2025 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810164; cv=none; b=jpshLfujMV9zsqZfHLDUNprN0OSgge8knLDvzqUOdxgiyldF4nXHn5+QwSunxa/1TPOUx4Rg/bKP0uX8fqOR5j7KTIpRzp1ztN8o+nHDfjIsRqTcZqpDXTPYB2QnnVsWCxpD+kAkouj/g190tqdcV7xKfiZRc93RMuqf5jqHsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810164; c=relaxed/simple;
	bh=rJrGMPdpmfczXiBtXgEmpnCFtaz2UlUKLGSFOnqDBm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m83KgCP0tZuD9zU/ZWX9qZTuSmIa+kmesofNPHD/3oyXkTqjm5K8WvujfZT0QvhDauoLd29pLI9ltIXGrnukVDOA2arpsSTmE2MkKqW2YBk2ZeMV3BD/MZhsWZGMMJXH3PQozDmctB9xCzP/JwMTubrAtViteUCub4+UR3RGwbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3sDAR08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5106DC4CEE2;
	Mon, 13 Jan 2025 23:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736810164;
	bh=rJrGMPdpmfczXiBtXgEmpnCFtaz2UlUKLGSFOnqDBm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3sDAR08F962mcs3ki8IOzWP7rivPtJ2qpHrUQMXPpm1GJEEKszI1vDHa6P31E3Yg
	 r0lajE3QL4FYVhREhuv89XKOJSqse/xOdMZLCnN1lrALLFrzYYCaWNerKDgQMpXjC3
	 PHr1YU7oAvwoG6owgb/Zxu9Vx2fwmbNdDdo/VUMjccfdMoGSoZXlKP4KJ+s8jrNjQw
	 87e7pIKM+YTqPt5TtEpQ/3SlSFdb1Job0hDB6s2V69Wu+AXhIIZRf9dKFOPSi+bTHo
	 DJ4tVO2J8T3WD6lTkzT/BqRtBpEyrWC2Zal5IKlIWZOe8DTqzbiB91JukHplxjUQYH
	 mzYr/Ae0BThOA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/4] PCI: Unexport of_pci_parse_bus_range()
Date: Mon, 13 Jan 2025 17:15:54 -0600
Message-Id: <20250113231557.441289-2-helgaas@kernel.org>
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

of_pci_parse_bus_range() is only used in drivers/pci/of.c, so make it
static and unexport it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/pci/of.c  | 4 ++--
 drivers/pci/pci.h | 7 -------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 52f770bcc481..2f579b691f8e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -190,7 +190,8 @@ EXPORT_SYMBOL_GPL(of_pci_get_devfn);
  *
  * Returns 0 on success or a negative error-code on failure.
  */
-int of_pci_parse_bus_range(struct device_node *node, struct resource *res)
+static int of_pci_parse_bus_range(struct device_node *node,
+				  struct resource *res)
 {
 	u32 bus_range[2];
 	int error;
@@ -207,7 +208,6 @@ int of_pci_parse_bus_range(struct device_node *node, struct resource *res)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(of_pci_parse_bus_range);
 
 /**
  * of_get_pci_domain_nr - Find the host bridge domain number
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..35faf4770a14 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -797,7 +797,6 @@ static inline u64 pci_rebar_size_to_bytes(int size)
 struct device_node;
 
 #ifdef CONFIG_OF
-int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
 int of_pci_get_max_link_speed(struct device_node *node);
 u32 of_pci_get_slot_power_limit(struct device_node *node,
@@ -813,12 +812,6 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
 bool of_pci_supply_present(struct device_node *np);
 
 #else
-static inline int
-of_pci_parse_bus_range(struct device_node *node, struct resource *res)
-{
-	return -EINVAL;
-}
-
 static inline int
 of_get_pci_domain_nr(struct device_node *node)
 {
-- 
2.34.1


