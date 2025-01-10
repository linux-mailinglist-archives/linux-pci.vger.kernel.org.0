Return-Path: <linux-pci+bounces-19614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32926A089C8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 09:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F2F167231
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 08:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90E207DFD;
	Fri, 10 Jan 2025 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nwl7RyOW"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3AA1F9428;
	Fri, 10 Jan 2025 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497321; cv=none; b=OIHqh3qcet0070vSdqx6aiZD8kcI4NugIxCLNzSP553I0pW4ckd0/eOx5SwjCiZjfTjCtEy+jMZF8hU1TeNBfJJQj/67vCdLnzOaSkQyx99XSUwr26KHUs18/XWQZF4eOABkYgzv1GtSjb7BaJPQaAKc7I3xHQpItQWEAyUayys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497321; c=relaxed/simple;
	bh=K6YrYOW3EAHUwaREXrvn/g6td90GW/YjSqcHRbukuFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpeMl1340fwa2+4T5B949fQI/pdR/LrAf0fjLQBr+stfugfPNbqlErw7dG1vYlT386AXczS8GkQZJuPan2MplI0BdSB5XR8F/H2sGqRdckZM1q29kZRmB8txpvCUPhhRMLnUKDQvkGycjMANlahRndAc1XRGnUXEGsVOR0oxeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nwl7RyOW; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 117E02000B;
	Fri, 10 Jan 2025 08:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736497317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c7RB7w8J19TlctLPPgGOEfCfHWIGmPuKJMrM/M8OuQ4=;
	b=Nwl7RyOWbILIZ/6xy/XhmOL+1Ljo/fWhMvJE85735o9w78iKwXjjGdkEbw8MfyuXAwwHHo
	f0AAPO88ioDknn48VKcJq4C/asbMWasIZOMugKSXgXn7HM60chydvRXr/axfWkk8MQ85Js
	gMl3ITu3WeltT7xNSTC/Ltx7pwo6T0yLFqTGhXMIIvlHjFwHKyEjt/b4MwijX9+S1qUxLQ
	0dtjBWauQZwgQnf/dJ9PhnQhC8W06IwC60dOX8/cvQSW3zZiMdrU8y3k5E/Xicjd2gzgRw
	Sv31xdO4LaptoDWdR66BObKJ+MO2fpIT8NZFGgnevfx0kgWgNlG1jd5mMoInHA==
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
Subject: [PATCH v6 4/5] PCI: of_property: Constify parameter in of_pci_get_addr_flags()
Date: Fri, 10 Jan 2025 09:21:40 +0100
Message-ID: <20250110082143.917590-5-herve.codina@bootlin.com>
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

The res parameter has no reason to be a pointer to an un-const struct
resource. Indeed, struct resource is not supposed to be modified by the
function.

Constify the res parameter.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of_property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 8aff9ca1f222..400c4c2e434d 100644
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


