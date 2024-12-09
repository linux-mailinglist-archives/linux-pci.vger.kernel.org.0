Return-Path: <linux-pci+bounces-17927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DA89E95D9
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 14:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1D2163152
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9D4228377;
	Mon,  9 Dec 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fOjzEgHM"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101971E9B37;
	Mon,  9 Dec 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749440; cv=none; b=EVcvVJcK8+ai6jIFq04TYxlhkTOkeb6cBKVGasGrTvqbfEMcqmICDRC2IGzXJooXO3rbWwQpyJOxqGXwctY2iJVZAPuifWW1gxOoqb7+S2jg6AK5L22WH4nX7Rz2bKenF9JQVJYu0Kq3xBZJCJ1nuzhkZEbSFM9ogoMvs2vJU8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749440; c=relaxed/simple;
	bh=H8MC/Q72vk0UPF9u8+tzJ8SETywEWYWPmMDVOO5AKeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGwU2INzJOq6H34Pygii67Y+CRpcYfx04pZDiA613RT2iwNCFHl74x0qCLNMqqvWfiKXNFPyedcz6q9q2CiRVECM/YzGHrdiaB1CskMj1r/rDtxHw69YtN0SkZOpEoR8lzLKG4/2yxBiYr+/yHaLRKWckJEYOhWBPBU+zlsOPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fOjzEgHM; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DBD752000E;
	Mon,  9 Dec 2024 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733749436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lD+dgpGNPBxXSWsz/EZ9nW0M7S5/QsWHsehlXFF/WCY=;
	b=fOjzEgHMaL4S9WOtg7h4mD1Tfs67P5LSiUk77jQC/AtsRO0bplZnDZJ2fno5naqy/HxCtB
	ynZ7KrB+h5me2tcLVImJ3w/LCy1qbXPoF5vtHlxbco1x91N8X/cAsMcG9VWwmR7VrXtgKZ
	5kIqHAUzSoy1zmURMJYLPCUVZP4OTdSBDRmKjGHM60jSLaQGRkzh+3tvSUhG65Oaji32JK
	4KkV4o2NLk1dWzdkvjWdPnHKG+R0zQeu93IdoLp3Yx4uyJR0WHAtegIO10PgMltO0iLoa6
	Tu7AU1xtxYMUVlZ/EoPd9dAiCpWMLUr7/jEzpB42lmhNvX6xBAvJQh4woUw51A==
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
Subject: [PATCH v5 4/5] PCI: of_property: Constify parameter in of_pci_get_addr_flags()
Date: Mon,  9 Dec 2024 14:03:36 +0100
Message-ID: <20241209130339.81354-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209130339.81354-1-herve.codina@bootlin.com>
References: <20241209130339.81354-1-herve.codina@bootlin.com>
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
2.47.0


