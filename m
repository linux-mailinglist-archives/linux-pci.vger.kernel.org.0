Return-Path: <linux-pci+bounces-6503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D618AC0E3
	for <lists+linux-pci@lfdr.de>; Sun, 21 Apr 2024 21:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8071F212D7
	for <lists+linux-pci@lfdr.de>; Sun, 21 Apr 2024 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6E844C8C;
	Sun, 21 Apr 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5oI+s6n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF417446D6;
	Sun, 21 Apr 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713726573; cv=none; b=QHvcG8OY17JlhTgGn9clQK7f2BfwmRvqYZ8xE2KlkQzkh+9WPOrXourKVvUy+Dd2At8vBrrCcEPUjec6mEO8DrrQjES8o4L92Q9MyL0/qfyRx6S/ckfiwuN3ng5pKCZ7EsOZ6agIV0hv7IjKfqIwUznHCixPoSN8r78RYoSePb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713726573; c=relaxed/simple;
	bh=X4v6M4Hrc9fFqCwB6oJpOXB8AHDIlZvB7tTwVOjiIBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VEf+a4i6mjXBhHQtencuGd6/Di7h7tGlCPlLTHxJ3Sg+AyR/CO5rxoZBIrk8elPncIOBQcRneFyNei8u/W15zFS278Ea1Q/evBteFDRytb9QiMch3Eo/ud9nyoFX3Elke0Zw8lZgUKoy7xCZMjws6ReYlvk3lgcsjEPIwB1Lvh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5oI+s6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA839C2BD11;
	Sun, 21 Apr 2024 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713726573;
	bh=X4v6M4Hrc9fFqCwB6oJpOXB8AHDIlZvB7tTwVOjiIBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5oI+s6nKWpN0z3IPZBfeH924VIQIwoJZRC9V3Qr/WQ77udlfzgw42ev297ij29eZ
	 OSZ0HZi3BRcBrYG1chpvFn9oKKB6jDegDUgL4KDux2N6SsBWgwZo3vy3NGn0tIJs1a
	 YOXYRpuz0d+90tTAigwSsaYqZgDO/yX6BOG+HKqHjqTUVHRKjtX+JUrABiJz4+vpS5
	 SF12280Wl6LBSxX3uJvhzgyBLrp55BbaTjVvs1E6hYuuf0IE1hraZf585B8IQ6evOz
	 NcQOdShN+JnZCKO/xmFNHuSTxRaoB7280FLU5rPW9XZorQtD1MWa+HO1xgyiJgrzXX
	 wnevBopS+8bFg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Vidya Sagar <sagar.tv@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v7-incomplete 3/3] PCI: Unify ACPI and DT 'preserve config' support
Date: Sun, 21 Apr 2024 14:09:14 -0500
Message-Id: <20240421190914.374399-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240421190914.374399-1-helgaas@kernel.org>
References: <20240418174043.3750240-1-vidyas@nvidia.com>
 <20240421190914.374399-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

---
 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ee086d029450..2c232c22d6af 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -894,6 +894,9 @@ static bool pci_preserve_config(struct pci_host_bridge *host_bridge)
 	if (pci_acpi_preserve_config(host_bridge))
 		return true;
 
+	if (host_bridge->dev.parent && host_bridge->dev.parent->of_node)
+		return of_pci_preserve_config(host_bridge->dev.parent->of_node);
+
 	return false;
 }
 
-- 
2.34.1


