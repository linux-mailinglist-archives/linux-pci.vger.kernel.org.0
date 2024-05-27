Return-Path: <linux-pci+bounces-7877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A98D084D
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFC31C2212F
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE7E16DED0;
	Mon, 27 May 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nOLzTlWK"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC67163A97;
	Mon, 27 May 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826531; cv=none; b=a8s6+p3twzlAVsuNN9uNFSW+4tSQikYj7QJBARG2HNZeMX8A0DVNez5RtkYBCXf+/KcszVSe7I/MHciO2TyVpiDzk5J4vH9TSPX5H6Z7MFJdfJ0GIDTaD8ew2Fteekpdrcg83ULzuoN8gQfpY3/lb4Iu0dquir4Lu4IFmemEaxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826531; c=relaxed/simple;
	bh=VofzQAz9jwO+Od3EmvQ5kjLYk/NvWLcXsH0JjB5B9VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyW60Fnv1ic2TPdgyiD5GdjxcqDEVTAqbh7pdxk7N2f+n2Fq8v6aseSNsYWv95yo8nhQg2+8x5GJKSUFhi7H0UrJNtIAu6jMtdmNEWT3qtlqTVLs4fH1CFxS71CMIlHDZEoM2QsSzdKErVksf4MghxAvyFeusqt/DwX3W7oIIVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nOLzTlWK; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 4A101FF80D;
	Mon, 27 May 2024 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IilDcbzGzG8MJynaB4el9RJ6tLmSv9BYDf8kPEDjUDQ=;
	b=nOLzTlWKLJ/MbZOfyb4/CjZgC9/G4TPjacYc6yUqFYSaCPd5I6/F++I/cjMCQvyR6+WyBK
	9d6kCAUBs5F+K9whSGwO3p4lu35onnc4n/NnW43mQjsR34Z7km1lD5X7PXUXRRXTEy1pUy
	Bh+qWl8+ZbzxiBKlxdsmfq9jQkCovYfw9F8lbG40LFQ0Z2JGSVz7vN9pcQF2pAWTLiP8wf
	zvJBt3XGGStzm4On1AmLakQBiG4SEYFsTd7mHtRVXaMVXIzB6eluC78WRXxSTc42jJ/GKm
	W1D+893BV++4CIea94xy/ZtUfIwXr5LVFmY/OtShMWKYC0SY5T7p1/i0MJcGuA==
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 16/19] of: unittest: Add a test case for of_changeset_add_prop_bool()
Date: Mon, 27 May 2024 18:14:43 +0200
Message-ID: <20240527161450.326615-17-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240527161450.326615-1-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Improve of_unittest_changeset_prop() to have a test case for the
newly introduced of_changeset_add_prop_bool().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/unittest.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index f8edc96db680..c830f346df45 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1009,6 +1009,13 @@ static void __init __maybe_unused changeset_check_u32_array(struct device_node *
 	}
 }
 
+static void __init __maybe_unused changeset_check_bool(struct device_node *np,
+						       const char *prop_name)
+{
+	unittest(of_property_read_bool(np, prop_name),
+		 "%s value mismatch (read 'false', exp 'true')\n", prop_name);
+}
+
 static void __init of_unittest_changeset_prop(void)
 {
 #ifdef CONFIG_OF_DYNAMIC
@@ -1044,6 +1051,9 @@ static void __init of_unittest_changeset_prop(void)
 					      u32_array, ARRAY_SIZE(u32_array));
 	unittest(ret == 0, "failed to add prop-u32-array\n");
 
+	ret = of_changeset_add_prop_bool(&chgset, np, "prop-bool");
+	unittest(ret == 0, "failed to add prop-bool\n");
+
 	of_node_put(np);
 
 	ret = of_changeset_apply(&chgset);
@@ -1058,6 +1068,7 @@ static void __init of_unittest_changeset_prop(void)
 	changeset_check_string_array(np, "prop-string-array", str_array, ARRAY_SIZE(str_array));
 	changeset_check_u32(np, "prop-u32", 1234);
 	changeset_check_u32_array(np, "prop-u32-array", u32_array, ARRAY_SIZE(u32_array));
+	changeset_check_bool(np, "prop-bool");
 
 	of_node_put(np);
 
-- 
2.45.0


