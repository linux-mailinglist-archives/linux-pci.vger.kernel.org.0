Return-Path: <linux-pci+bounces-16331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784A29C1F6C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 15:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D2D1F26105
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ED71F667F;
	Fri,  8 Nov 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oGfE/lo0"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0391F4709;
	Fri,  8 Nov 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076571; cv=none; b=YlTgF0hUoziFC5d9UBQ19I1cHKN6ZUYLR14CUzuUP9x3Pf73QlBKakBeBs30+OnjYRXxECljkRB1WYJ7lPFLs8y0vDb8gsnwlvsA1oMU/2F3zvXtGai1h5/GGc5+XJqJY//g1A1TUSdoreBH72BbF/bp5fWZnnYNlBLjw3m0NOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076571; c=relaxed/simple;
	bh=fYwE5EjMh19lhQDnSaq4yYULUe6QFJR/LjTL/pR+GRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3+zVKUBxhT++XPsHBCsS5hjMOnzbejrIY7ofqBMsKfywEFTc1m/x3cBLojlKWw88BrrZ3AdJC3a+PWlh9H8YdjGcR5kQXc4j6VjAIygwN35bLN8yDWDjwVEwysGIkx6Rb5gBRJdzt8I/r0808GSZqg2EvheroAmX577+nEEn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oGfE/lo0; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8B1A820009;
	Fri,  8 Nov 2024 14:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731076567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxzxY5tO2wGGtnAYK1ZdH8OX9CY4/fDjyHiH50aTJak=;
	b=oGfE/lo0wsEqQ1FNpOVEjJlANoPwJhdtUYaUscQOsX+VfPWa33C8o0n28vyCJnEWJXLXr3
	aJgHWSPWMXgFRBhV3bCe9tLDIoXxIUtIVxXc8xjt4z6rw4LyqETvvTXZBRMKpyGEoWbsDD
	Kwh7OB3omL5E0hdtk86yXWn2cKlZLvx4GmIEEJ7EEE1L8fGvUruNvxqyVzTE+g6pyNsg/j
	WY9b3LdAWeUksbEk5YWWT5fZl9wft/UR+cPAp5J89/ZKbsOFvIzS1w82Qo8gCvSJeeW7/n
	OJoi7P/SvdO5kEJfONJbCULTb48pIjWmSAJvYvc9jwQgw1k7U6H8C6UVZvePDA==
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
Subject: [PATCH v2 4/6] PCI: of_property: Constify parameter in of_pci_get_addr_flags()
Date: Fri,  8 Nov 2024 15:35:57 +0100
Message-ID: <20241108143600.756224-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241108143600.756224-1-herve.codina@bootlin.com>
References: <20241108143600.756224-1-herve.codina@bootlin.com>
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


