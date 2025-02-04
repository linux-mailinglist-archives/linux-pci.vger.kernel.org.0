Return-Path: <linux-pci+bounces-20684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938EA26CA3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 08:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3546166993
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 07:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F82E206F0C;
	Tue,  4 Feb 2025 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mS2Vuabh"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D9A2063DA;
	Tue,  4 Feb 2025 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654520; cv=none; b=bJaLgXKsJiRUmLva4vzGiAFJb+5bsVBYEjDPGHCTysq5CzjXWyHD//lg1HAToLsfFGVEwjOyi7+rGo2ziIfM3S8aoubStRxWq1DlTY0E42dndYLDALBXYAZEYmgcVkePb7T/SijgoLXOrjW4m/TPEWG0TNz4TrljbwzQnf/xmkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654520; c=relaxed/simple;
	bh=Z92Iij4ppO//2iG1VjApoeSswpj3ZvFmkzJ2X3J/kqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofosoWnHfqoxhnCeOCrAEsejKCtrnWu7/A54bAPLRvbbQemyvx+5tzBpIqFBHhoFTtV8I5w3hAkNHkUkznPji8crv1J1eglzGiiCKnM+8aMAxnSyAbFeArDbvpvJO+Eb0uJ7Qw8Dkx1CHq/f4GIsxOukS6+NVmGxBD+x3ZNdx80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mS2Vuabh; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 0722144417;
	Tue,  4 Feb 2025 07:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738654515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmiwcnqKRWvJz2/o0/LToxXtK0VEDLbdaqIJoBX7Vg4=;
	b=mS2Vuabhq4EJiME1PPuz0umI4Sck4sQZkUt3NkBUcNUUcS/obFp8j+MgjqNriQio0pbFsE
	xyuU4h1bFUl5vRZulfvBhI4sO0NFdoQvG+O2eLHMr0gxhEnyT5tJagg+R8E6lHqFiytgOk
	qQ5LLkb3HNMzv3WA0AW9YiCeFkWLf5tvHXL/0YnGTuovNxmYmCsUUPyvZu1fqhci6YYAnx
	88WTniYkG672xKWfXrsSqAiUP8J6uILKrp0r70wpwGlhMGIZnei+qW/Cyn/SuM9WrDuXYB
	BzhK48hpTqsrD0w13YqiagR4CUD3xpbKNh6HiJHcX/iwID/jWvmxhd9im+8B+g==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
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
Subject: [PATCH v7 4/5] PCI: of_property: Constify parameter in of_pci_get_addr_flags()
Date: Tue,  4 Feb 2025 08:34:59 +0100
Message-ID: <20250204073501.278248-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204073501.278248-1-herve.codina@bootlin.com>
References: <20250204073501.278248-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehffeigfejueelueeuffelueefgfelhfejhfehieegudekteeiledttdfhffekffenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhiiihhihdrhhhouhesrghmugdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: herve.codina@bootlin.com

The res parameter has no reason to be a pointer to an un-const struct
resource. Indeed, struct resource is not supposed to be modified by the
function.

Constify the res parameter.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of_property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 962d2e8cc095..b17dcb04de18 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -69,7 +69,7 @@ static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
 	}
 }
 
-static int of_pci_get_addr_flags(struct resource *res, u32 *flags)
+static int of_pci_get_addr_flags(const struct resource *res, u32 *flags)
 {
 	u32 ss;
 
-- 
2.47.1


