Return-Path: <linux-pci+bounces-36823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFA1B97D18
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 01:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C881AE23AC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 23:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D91C2FD7BD;
	Tue, 23 Sep 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="t6zq26Tf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uRo8Vx5j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6B223DF1;
	Tue, 23 Sep 2025 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758671229; cv=none; b=e23S4TS6iCwaKWlNGVNhvwSywHEKCjqeWySw8bx7teH0jd6vj2CGr9W/+Xih/MT8FPCdLNxR3Xe62O7KdxoJFuWv4vdn+fCK+5jKotPPPdiGIntWchJD+K6MWRJ4LhN/3q6Ang4KvYt5mPor21GQmN5nxRxmRp0eRiL34T2x89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758671229; c=relaxed/simple;
	bh=8YgpqE03TuFSZdkW7VrnoXlZj2IFVZpYR2gJHtHFLPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sSsS1aWkUQyI6QTrKoovB8kLmT9q+U6S/LX7D6DFaBjcviMhn/vagAOz6JoxX2SgHTqSPQRqJXIrF1seBMGPpmwAzteZVXxU3OKDhhOa6EY1JmnNOTxrZdPQIyKHo7y+KHpMAQeN1mPZNtRJ2d59qw50a7PRldmNVnaOMuW2JlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=t6zq26Tf; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uRo8Vx5j; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cWc8N3L1Tz9t0f;
	Wed, 24 Sep 2025 01:47:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758671220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=itgmMwd0vgP5PZhXQStLZwyQ5NKDgt2vMyRJtHWxfhY=;
	b=t6zq26TfpmPurufgNe3Zr1qEwXCVwvEXQwTXv89gast/lvK/9D4xxihA3Fp0AwU2Zlkjhf
	1tq+cD7uvxhZp8nTtk1wecIiyTJagtmz4FT3ls6fhq1cdLTd+hnq9xY2tULzEV3UmPt1Ot
	S+pUXu3Li0KuavilQIi1oBtrb7X71vQaKN5ZPD82wXUoph+rlcMT/+rh0GpjywHmDIkRZR
	eD4jD6BbVnPbTymh/uHYfOY+QOj6o+lj7R722vBfanmRKjNkWORKN1M3lNAgbj3TtJr7bv
	s/SGpinoDhPOesEjQZvVUQh8DEj0dnJysgKVrvjTuxnB0g4RmIs+dD99E2zFtQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=uRo8Vx5j;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758671218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=itgmMwd0vgP5PZhXQStLZwyQ5NKDgt2vMyRJtHWxfhY=;
	b=uRo8Vx5jveMoobMXiFFJ7yE5V1j4GJBisPxrTO3Y1HPd0fRzWCw/+4IxgTQhiwKetqJ/e6
	IE7TB5pVU0nDcysPMGsJEV7Vr1jx7hDH8GRczOJnUhWcGNKMmIdGUwzway/crNztzfwkV1
	IoelGxcNFv7CDcNkpiZpJzSIpVdsG0prbl0Xhsi7mnUnXQEwVLtPRPdqN9qEz9PK97B61S
	bHWkir6FejYAAcLURVj9xNTRwcugtaXEuHul/qmZcMsBaxSEBkApQMQizE0ZBFfbdotjKc
	tyHvYoAu2N74yZ7ZRqbaaY0zC4pcxTbT36Wkv4EFM4sxS5Y5ce3ukhGhfhB3qQ==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] PCI: rcar-host: Add static assertion to check !PCI_LOCKLESS_CONFIG
Date: Wed, 24 Sep 2025 01:46:18 +0200
Message-ID: <20250923234644.82890-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e57ee752eec6cf1c657
X-MBO-RS-META: cwmw45enrhaw5sa8tr4qxzks97g1geux
X-Rspamd-Queue-Id: 4cWc8N3L1Tz9t0f

This driver can not function correctly without PCIe subsystem level
config space access serialization. In case PCI_LOCKLESS_CONFIG is
ever enabled on ARM, complain loudly so the driver can be updated
accordingly.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Add depends on !PCI_LOCKLESS_CONFIG into Kconfig file, to prevent
    this from being built when PCI_LOCKLESS_CONFIG is not set at all
---
 drivers/pci/controller/Kconfig          | 1 +
 drivers/pci/controller/pcie-rcar-host.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 41748d083b933..3f489bed289fb 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -244,6 +244,7 @@ config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe controller (host mode)"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI
+	depends on !PCI_LOCKLESS_CONFIG
 	select IRQ_MSI_LIB
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 213028052aa58..29e13f7ff7ff1 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -35,6 +35,14 @@
 
 #include "pcie-rcar.h"
 
+/*
+ * This driver can not function correctly without PCIe subsystem level
+ * config space access serialization. In case PCI_LOCKLESS_CONFIG is
+ * ever enabled on ARM, complain loudly so the driver can be updated
+ * accordingly.
+ */
+static_assert(!IS_ENABLED(CONFIG_PCI_LOCKLESS_CONFIG));
+
 struct rcar_msi {
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
-- 
2.51.0


