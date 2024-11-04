Return-Path: <linux-pci+bounces-15985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20159BBBC1
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 18:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B1D1F224E5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 17:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755201CBA0A;
	Mon,  4 Nov 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MiAzBprF"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407531C8787;
	Mon,  4 Nov 2024 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740815; cv=none; b=UEChm9b8gUF+pH72j9mmadlb9fLphMH3wpIIq2FRnnGadrz5Nmg6pZfqjVkLgTzfAFTmXqck8pGhYJ+Y3trSHG5ElydYe9uyIF+EINdOcrF0IabeiltunvN+P4f2HHTlUw84mYeQCaH2+q++8eBjQmeLIoKnyzv790u3eA9KP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740815; c=relaxed/simple;
	bh=fYwE5EjMh19lhQDnSaq4yYULUe6QFJR/LjTL/pR+GRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqBITnYjL9Gqtyhi62jrRvbKRn8CyVWlewBc/Y1tBB/Op0EpdWIMA1W95TDBU9JTnE01eQApTr0tCC34g3JPm/kjyKF4y1/SMmZJSciQjxHWPYrYRvuJ9CPmarO6AnqGHVAFl7NQBqOW2PB/3fR8VIOfNaOBY9oTcKiFyBupabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MiAzBprF; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D990C1BF20F;
	Mon,  4 Nov 2024 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730740811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxzxY5tO2wGGtnAYK1ZdH8OX9CY4/fDjyHiH50aTJak=;
	b=MiAzBprFjt0Jff5Wi7WHw8BQA+IWWG5WQZCClSV8WnU6BWNDZ1GmjvdMYnf3U8M/KLp7Ug
	o/T3GEpQc3gHHAJG/g+j7ms1RaT98lF+odoIE5lvLY2CDWjEL8PYPQrOz1iGkBohRKmL6Z
	4j6ZWRf67rBtNH6YmYlR2gAcSVg1vqeBYhanKvSpolKs+nKf0BmR9kV+tM9rClfgrhsebg
	zwuba+xbDLKMgcpS+jLDEFLPj2OhsnqS1Gv35doH1VxjOY0S5UWNVQya/twiEvO+lQ49GT
	HqQwoEkqiVYW+gSP2LuKeCdxdUWK4YYg70J+Zd+pmsGPkSKS8ZR56DhHKnBnog==
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
Subject: [PATCH 4/6] PCI: of_property: Constify parameter in of_pci_get_addr_flags()
Date: Mon,  4 Nov 2024 18:19:58 +0100
Message-ID: <20241104172001.165640-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104172001.165640-1-herve.codina@bootlin.com>
References: <20241104172001.165640-1-herve.codina@bootlin.com>
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
index 59cc5c851fc3..e56159cc48e8 100644
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
2.46.2


