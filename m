Return-Path: <linux-pci+bounces-19259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3F3A00FDB
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 22:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A2E3A240E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 21:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699F1C243D;
	Fri,  3 Jan 2025 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdM7sGO2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B31BD9FF;
	Fri,  3 Jan 2025 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735939898; cv=none; b=FOFjAlh67+UdwSfugjsEbwKVB/vytiVvVYPg9fO9xU8+Dr2mHtkn2wGnDyP0JOhfzsmqACKo76anOdi91nx6WcccooEEfVK8fXL9RcgxHD1pDHks8MFZ3HhgIhPYgcZfHM8ir9Ci1Y2qhlzcV/2UJwa1MQYZy83bP14jivGfd70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735939898; c=relaxed/simple;
	bh=T3K7Xt/laFZc/LMwoH4OYILNY7Em+VlSsCcVbeg4c9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nbWUp+MR6fYc/uxZIwdy2IaCcG6Jfv0a8bp/wboWIeGi/DQc524BnV3yeSL61mgdxZPVk7IIID21N3iVYiTjdX/nN90TQ4LUzYmCLqLzet5zCb4UIR14fsu0cQ1VBQLKJah/S0Gx4jQxShdigvAPpvRX/MOnhWy85FGyVYUzefA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdM7sGO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B0DC4CEE0;
	Fri,  3 Jan 2025 21:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735939898;
	bh=T3K7Xt/laFZc/LMwoH4OYILNY7Em+VlSsCcVbeg4c9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdM7sGO2qaXMPTZjUtOSF5JeRh5l/trqXU8vci4JYvyyWmEj5sM9/fWlsW2sldZvM
	 0pWQZJRsWz5ufXJuiFjys0BKsBJpKFcK5JnHVWdmwZR0rESPAw0gSkN6j6eiR9b0jJ
	 cKqBgHPERwm0c4dw35iCls+kUqU9TjXiuwuNxDanXZ67aJKx2WdZEtHAYAsrKw+s0X
	 6VTCyn+j/it9Sz7RzRYCd85XlzQfhK2cyE0ArT3vi2PNUV8+qu+huHPm8/EGqeTAs8
	 pLJLFNbmmAswSwx7Eh7/WTabVR3Fbfu/krWWxaNB28SNHp4sFpMklkVF8teETConbL
	 G41rVORmPcVjg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/3] PCI: Unexport of_pci_parse_bus_range()
Date: Fri,  3 Jan 2025 15:31:27 -0600
Message-Id: <20250103213129.5182-2-helgaas@kernel.org>
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

of_pci_parse_bus_range() is only used in drivers/pci/of.c, so make it
static and unexport it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
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


