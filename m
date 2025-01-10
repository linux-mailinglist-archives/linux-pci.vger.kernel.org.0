Return-Path: <linux-pci+bounces-19613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B4AA089C6
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 09:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA3E7A396C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1CC207A2C;
	Fri, 10 Jan 2025 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h9ZBQiTN"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92E8F54;
	Fri, 10 Jan 2025 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497320; cv=none; b=FmcQmGpvZden+FFSugpHCfIdSH+H1d/T/asGrf6Ku8F1RG0fZ5ehWv4H5eU9Hs3kE5gSnatUnX2N7ZkQrcXmqS+ZGJ3k0CctNwpmvKuVY0WLyywc0BpxCjzN5bVcxxgP7NBxG/eHL5FVsDP4ZeUgfWU5jH+L1lxCff3+GYoC6zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497320; c=relaxed/simple;
	bh=P+Y9UraIZhvdw5UcVwbrlExRQcniBwLNbPoCHyp5MBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUG8LcfeTVC8l2xqBxRK/8gKf+/NDvs6hc2mYpOkpLjoT/i2zwSlyRXfcxgeftGBey9NwtyfiDjjiIBiC1peNBwoLDgd9GN3OquFuBZOOkBbaxoSXtTB472+w0ie1ZfyuMwdgk1HBBE+bpeRcjdlUwzwQFgz0btwfrJm2jcfm1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h9ZBQiTN; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4DFE82000A;
	Fri, 10 Jan 2025 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736497316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3exH2D4DHGEwR8WFnd1f/VkSRJ5bE65THJQbo6YCV8=;
	b=h9ZBQiTNYYJsPvzribTbTE8aKxVKfnMqB2Nbe2VV278x4sLXz4AQrOljNHZZRuoMPFrGQR
	fNLJ99jxv11q260FnjrWXp4S9CJO+V3vKfuZvi8NG2Bv+T4iuHhYFOA7/4TVRVhwJi8VBN
	p9t+J0GFfTdICwpRNSyahDpt9J+8Qwm/zT52G18z0Jv459Feu9yDc75xiL9BbzHlR8utL5
	yw5MsGyaJkl1z2iJaZF4S2851G61t1X32jHO+QVeljHie/UJrCABfaNlVJ1745GLOkAyRO
	+mhXmHPQIhHVtXaHa0SJYwy5lKpNvap8AFBec4KyWQKMQM19Yp/LeIGEWiG3JA==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v6 3/5] PCI: of_property: Add support for NULL pdev in of_pci_set_address()
Date: Fri, 10 Jan 2025 09:21:39 +0100
Message-ID: <20250110082143.917590-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110082143.917590-1-herve.codina@bootlin.com>
References: <20250110082143.917590-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The pdev (pointer to a struct pci_dev) parameter of of_pci_set_address()
cannot be NULL.

In order to reuse of_pci_set_address() when creating the PCI root bus
node, this function needs to support a NULL pdev parameter. Indeed, in
the case of the PCI root bus node creation, no pdev are available and
of_pci_set_address() will be used with the bridge windows.

Allow to call of_pci_set_address() with a NULL pdev.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of_property.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 886c236e5de6..8aff9ca1f222 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -54,9 +54,13 @@ enum of_pci_prop_compatible {
 static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
 			       u32 reg_num, u32 flags, bool reloc)
 {
-	prop[0] = FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
-		FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
-		FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
+	if (pdev)
+		prop[0] = FIELD_PREP(OF_PCI_ADDR_FIELD_BUS, pdev->bus->number) |
+			  FIELD_PREP(OF_PCI_ADDR_FIELD_DEV, PCI_SLOT(pdev->devfn)) |
+			  FIELD_PREP(OF_PCI_ADDR_FIELD_FUNC, PCI_FUNC(pdev->devfn));
+	else
+		prop[0] = 0;
+
 	prop[0] |= flags | reg_num;
 	if (!reloc) {
 		prop[0] |= OF_PCI_ADDR_FIELD_NONRELOC;
-- 
2.47.1


