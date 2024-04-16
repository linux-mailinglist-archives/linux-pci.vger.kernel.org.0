Return-Path: <linux-pci+bounces-6302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1007D8A626A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 06:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A323E1F22B89
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 04:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2147C2D627;
	Tue, 16 Apr 2024 04:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NKOtAfue"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D5C11720;
	Tue, 16 Apr 2024 04:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242015; cv=none; b=qP3FpGI9RWL8eDqkcKrYbvuq65261mOYWrHbzYrIZcVON/Z8KBIudlkHGHh7Ps1lbwnt+tJ6AwdvxU+lqGCo08xxHgQK42qvvwqosQY5JyBLvddQiuFpkqV8c/FdWVjcny3lTj+SX6jpxTgDXkj6uawGlUM780LzWkUltbl6Zxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242015; c=relaxed/simple;
	bh=oJry8FOQnfEPlAmfb6SMP21v3ppEHori/ow8A3xoHDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n16dq600lWscrfAaHEqafb5mA6iUarieiEw5Wurxa6dn8nLnF0HOOGy4DojsD8GVO17a1gq9SwicHbdS0CfQgZlnlwSAH2aIYZ5/X6WNGNPHBE/Isp+PpsQuYV3RZ6xe+H9dKPTDK7NpaNrDFgUvTX+EuE/RUr2zAls1UcKpIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NKOtAfue; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 656BC3F0FA;
	Tue, 16 Apr 2024 04:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713242003;
	bh=EIqb3ZhtP6vTc/Ol0BEJS2EDfRh93Z4lytIAwmN5HBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=NKOtAfue4ui49NMuPLL0XAKGEFXav6o4C68s62FY4mxrjwrfM4IlFO/o2T99SB7h1
	 E9GAlvpSYHu6NAZtGms4ab9wfWZ9jAovmt+67i/pQuMRuWXWKL2+rkLy9MJxJPaF+s
	 KEIUrUBacCuEPfQK6v3CfSFewEZ5Wy8L2kuC6LwlzrA3xyzo89DEDkJCNJRKNCO6wR
	 Q68K9/AN2CaAUfc5//i/czP84EqEosxaTqfRNf4uLUWVg6etOiZW1UigHHln3r1eMj
	 StHCFMAMxZL78xsjzt4zV6Cm/poJOsXEvB65i2FW7B7WNkqzX1AGEd1eff45PPOhfu
	 m27lNjrJFS3Eg==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bagasdotme@gmail.com,
	regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	kch@nvidia.com,
	hch@lst.de,
	gloriouseggroll@gmail.com,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@suse.de,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v8 1/3] PCI: Add helper to check if any of ancestor device support D3cold
Date: Tue, 16 Apr 2024 12:32:23 +0800
Message-Id: <20240416043225.1462548-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In addition to nearest upstream bridge, driver may want to know if the
entire hierarchy can be powered off to perform different action.

So walk higher up the hierarchy to find out if any device has valid
_PR3.

The user will be introduced in next patch.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v8:
 - No change.

 drivers/pci/pci.c   | 16 ++++++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..7a5662f116b8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6225,6 +6225,22 @@ bool pci_pr3_present(struct pci_dev *pdev)
 		acpi_has_method(adev->handle, "_PR3");
 }
 EXPORT_SYMBOL_GPL(pci_pr3_present);
+
+bool pci_ancestor_pr3_present(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pdev;
+
+	if (acpi_disabled)
+		return false;
+
+	while ((parent = pci_upstream_bridge(parent))) {
+		if (pci_pr3_present(pdev))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_ancestor_pr3_present);
 #endif
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a04f..cd71ebfd0f89 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2620,10 +2620,12 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
 void
 pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
 bool pci_pr3_present(struct pci_dev *pdev);
+bool pci_ancestor_pr3_present(struct pci_dev *pdev);
 #else
 static inline struct irq_domain *
 pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
 static inline bool pci_pr3_present(struct pci_dev *pdev) { return false; }
+static inline bool pci_ancestor_pr3_present(struct pci_dev *pdev) { return false; }
 #endif
 
 #ifdef CONFIG_EEH
-- 
2.34.1


