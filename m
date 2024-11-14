Return-Path: <linux-pci+bounces-16786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F859C9049
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB0E1F24503
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 16:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A5D13C8F9;
	Thu, 14 Nov 2024 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VPJLotSB"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B6199935;
	Thu, 14 Nov 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603308; cv=none; b=WPcaNZuI7WIGuZgh8s4rNPHpN7P5brQtWN58yZ7qyyBa8fIjUU8uuUhl2WuuXN5mV16SVJ11sRU277E4JKP4E4jS9Ve5NFASUBunPG1WoKIvlQ5Pyb1gpxgURk36ZtPSbx5EhzUnHrMNgbQ4ez4gmKGQmfNyA+otNA7uTjK1/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603308; c=relaxed/simple;
	bh=d2CSBkGniD1g0Zd5IbjtbUBcIhdorGbcXo+psM4v8qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AadaXxkHuFU0pzEpg1hGcYT8EOYfOdIJOs8NK9lZ3tnzVZucTNIKqvvHIEI2aamzjhShne0wSTYdS1h4pizElVNneFx6qudctJ4p6UAC+VnHW1G81otTeUvoJFroe3/lF6J1iayg7fr4IcQCjIajAj9/kCqXmIX2zogUEz3nlow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VPJLotSB; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7C90CE000D;
	Thu, 14 Nov 2024 16:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731603297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbCjH7pO14MiXwzgxsl9nSqpGImZn4JYlN31kU+nsak=;
	b=VPJLotSB7hZyMyJwbWUnKitXEhLctmC3hy1X81AvEKuWjQBGprShhOb+eB7HrOzf+lQRz/
	/dOdszsEOFCxW4BqsjSA5VE4SKeR+VtJ/iMJotlzeMLBa076LjZiaJkf3jViYiTA1JaxeT
	t+g5adsc5JOpAVPRdsMu24LFpRyDGUwpxr+ViRpzG0pZRuwm/I/jRkasFeARYXFCpjGwPm
	mEoTuEsu6pZnzRny2rfwJ+5TvP5s4AJfTdppMhQRnYe16XrttaDTlJ0QPbg5IrdtrBVc4s
	V0/qB+ygk+G1ILB8fJ8v289w5JoMnruYwbBS6wXmWg8NgnRC5lWV03EEcycbPA==
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
Subject: [PATCH v3 4/6] PCI: of_property: Constify parameter in of_pci_get_addr_flags()
Date: Thu, 14 Nov 2024 17:54:40 +0100
Message-ID: <20241114165446.611458-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114165446.611458-1-herve.codina@bootlin.com>
References: <20241114165446.611458-1-herve.codina@bootlin.com>
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
2.47.0


