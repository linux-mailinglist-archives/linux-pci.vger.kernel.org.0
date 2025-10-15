Return-Path: <linux-pci+bounces-38137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86232BDCFAD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C623C22E5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516CC3164A4;
	Wed, 15 Oct 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Eszd/sJi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC93161B5;
	Wed, 15 Oct 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512678; cv=none; b=EG44e/wh3BBXPOFKaYa/mIfbw7ejSY21aLUNIMKy+0c3ldeiehiGOhwX0CRJLP9IFsefVR5bDB39rDNDfdO8B2Dfk80ttvm4AYDzTazlDJLDfI6zszQAJlFANlL3ITn7+774pu8QRq/Iit9DWRjsaknqyo5YfZsq4uRkuvbgcF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512678; c=relaxed/simple;
	bh=yLdnRvJ2/N+hn9q1gZ3j5mFKE+2iMPj0lQtkqSxiT/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2NAJ3cenZnOx9q3AaGiC6KFgkgRFLrM8Yoo+Zwf4ixaSykNAn9CDAlAIL9su22V3hw/Z0a8gqb2Oxe3xAEkjdAsLmubIQ39onbK6hPh1ZNafob4R2djALSVx57AdaNVfrTGyRuRzdQQtDMomrVC+TBWDo1FqSv9RuJlKG+RxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Eszd/sJi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E089B1A13AA;
	Wed, 15 Oct 2025 07:17:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B6D52606F9;
	Wed, 15 Oct 2025 07:17:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0DB5102F22C0;
	Wed, 15 Oct 2025 09:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760512672; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=O5x561gvsAi3yb3m0cs+hCR6idj+Nf5cQYewezGywf0=;
	b=Eszd/sJikO5nLtd75ebng+KGmL6ZL8IAGmGnVmn7BJsjgK9LjgOMG6rdYjFqowdBlglQ+V
	vG1svhY0nKnFBvRSV7Q4kS5o6QgLTC3fLMPwUsdlp8dh3helvvsiiT6cXwaa1WbHirFXRy
	iKkXLMntcMFErQbKGO3+1jTg2Uy8vFsxJMaml4Ik9XSSVIh6HBdSI+NdEabe6GxQWm/4KO
	T42s0wR7Vo+m/VmQGhx1n5robYPqiLhY5/GlGK7GPGX8+Puk37H5vpCuIu/ARzhYbXbASu
	DhDBXVBS9pRn9LOc02fSMiWngMFkSgPmKuM3axugh/eWohQ1+Z7jFbUFSrGiYw==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Arnd Bergmann <arnd@arndb.de>,
	Herve Codina <herve.codina@bootlin.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 08/29] driver core: fw_devlink: Introduce fw_devlink_set_device()
Date: Wed, 15 Oct 2025 09:13:55 +0200
Message-ID: <20251015071420.1173068-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015071420.1173068-1-herve.codina@bootlin.com>
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Setting fwnode->dev is specific to fw_devlink.

In order to avoid having a direct 'fwnode->dev = dev;' in several
place in the kernel, introduce fw_devlink_set_device() helper to perform
this operation.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/fwnode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index a921ca2fe940..a1345e274125 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -231,4 +231,10 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
 void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode);
 bool fw_devlink_is_strict(void);
 
+static inline void fw_devlink_set_device(struct fwnode_handle *fwnode,
+					 struct device *dev)
+{
+	fwnode->dev = dev;
+}
+
 #endif
-- 
2.51.0


