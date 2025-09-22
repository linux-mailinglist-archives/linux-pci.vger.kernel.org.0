Return-Path: <linux-pci+bounces-36691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D66B91F92
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4158642490A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E72E8B71;
	Mon, 22 Sep 2025 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fF4cPOY6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aTbC89OW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96A2E8B63;
	Mon, 22 Sep 2025 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555260; cv=none; b=eVIAcUHUZ70cP5zVZjtpi3eHEPEOZuEgkIYOfzwBvR/4+qtiGwYQAcj3wJC8t/XxfBBHTuXWF7F5q/WdWdngSzkOql5YVr7J37qmXXUik5Ovt+8SJ+hIFGzPMDZ1/Da0zztV+so5O95Q9kSnMK3uT02lLwsE79Rs+dB/LmVJetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555260; c=relaxed/simple;
	bh=4g8pdZiNUoEUbdC/+29dwwVutwbVoelgcoRU4UE69Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T/L8WdOQFC6F8MUiA/BcsAew81y3JZ+VUDtbXhM5nLc/qCW0TY8QJ7EDyGlR2bGj7tv2OXl+9YLgOPl1qM89LePhONYL/nUwovg2ojNK0AEX+4lRefWiBp2sZYAmo8e2u6PUJJLMpEkXkL6g3VO8A4dXtbmB2Drbsk5QGwNL3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fF4cPOY6; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aTbC89OW; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cVnGC00nqz9tTb;
	Mon, 22 Sep 2025 17:34:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758555251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T/WfyxJwREoktiQFDoI3msz85U3rthfK4OgtAIm+ta4=;
	b=fF4cPOY6kVDD+HqL2NKouMkZV7oNc6vNAcZ4Jo4e3HSYg9GbBcxOl6AOy/Ks/kqyGBbzsk
	JU2/AI6n3PmJzNi3RGFbA2s19RkBuMk5jeBVPhX/6FEbRktCgh/wYj8jfU5S+oLmhesDnZ
	XA143cJTJefkwoz+dIHju6lQxgKnTxgh784mqhJ5efqic0ZbeJI9aHYW5JNWCAxauJQ1Ro
	6lMi7kEDaMG8c39YcMC/8DiTmBniRBP6JItbL56p22QAgwIN2lzHaGs+gUwbNE3AG/laav
	DKBqulMbPbPzObi/Tg8QxNM13ElkF0wgy4oiAdezLqll4QXXUErMauOBFkSuQA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758555249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T/WfyxJwREoktiQFDoI3msz85U3rthfK4OgtAIm+ta4=;
	b=aTbC89OWGfBoI9HBTujrfBZGB6NCv+2Gq90taOAGwUB5cogLWb4kcTYNfbBDiknJtiSN+6
	4Jk9uAehRpLyHFL+Y18H3Gq/bCClEVNPBE5ALCY2VRNUz1cQOERLSE/gzVnc2lcTkEXlln
	C1aHNje0UiCNSPosaJoGsTCZkbDKK9dtEwxRpMLJQnvbywW/DLnVIuTFaBNP3L+gMDGygC
	2v2Vg5s3Pa3bgOfL+BaubN1AWHV6CofdKTzgflTplp2SVhsq7sf6FunhtnjvqwvDI8sz+f
	fRP4DJbfmUnNzUG9zwb4+J6HEwHNhaR1/dw5P6arntrDYR2WCHHr9ejpAmGqKw==
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
Subject: [PATCH] PCI: rcar-host: Add static assertion to check !PCI_LOCKLESS_CONFIG
Date: Mon, 22 Sep 2025 17:33:23 +0200
Message-ID: <20250922153352.99197-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 78269535d8f6cd48f72
X-MBO-RS-META: c7edgmgujodt3bt7ycs9yx6rdws6b8mf

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
 drivers/pci/controller/pcie-rcar-host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

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


