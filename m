Return-Path: <linux-pci+bounces-26998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D48AA0B45
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 14:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6859217F9A3
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 12:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E192D0283;
	Tue, 29 Apr 2025 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VtxfA8w1"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3AA2D0277;
	Tue, 29 Apr 2025 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928719; cv=none; b=Kyek558235G/aLOxmbs1IOmHKqvkrUPmnwQwYmL0qCt75OZUrf7IliZpYUgA5QpvCzmP4QDdEeck6kZ9p18NxpXwaM67t4PLACui6PSun4YZGvjDUe1gdwbPnJ5nP7g1SPWTB33jM+0el2nG5+spiz3fg2KQNa8VUB4vmFVyWnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928719; c=relaxed/simple;
	bh=V/Ie+ZwTST3Gao5+19A/LCA6skSpyushVizMP3n59hg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lP5POrziLtUHxb0JhrsUxJlClg/7oIGWdQehNRbUAXeZbRb12ozBtD0pGINREyljoDOSvtJwFogexOeMIRcktRJ5fTiTW9j2XWH86bknP8HLJtWbpF+1DOS6zDlnSxevmFq/w2rehK3r30rPb+uHVdPORo0BAtjZDSaKxF/SCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VtxfA8w1; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FCDaB
	JfvI36gqhZRVHJX8XImVX7IwQoIXehlt+PgFmI=; b=VtxfA8w1/u9AKunanELhV
	ShH81ap/U24Cd9ILWNbisnH29NaW9Sma6gYHa9iM3QBCRkpW8viANp0PhGUDCGqX
	0KLWvQEv4UAxg9M8bHB2xPpYz20o7MbGl0q8NSNjw0xEFfhT0fHkzU8yEXW0vnR3
	by973SQuXaWX4jFp2gtK9Q=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHUkXjwRBoU_m0DA--.22532S2;
	Tue, 29 Apr 2025 20:11:17 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org
Cc: cassel@kernel.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 0/3] Standardize link status check to return bool
Date: Tue, 29 Apr 2025 20:11:06 +0800
Message-Id: <20250429121109.16864-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHUkXjwRBoU_m0DA--.22532S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWDAw1UZFW8Jr43Aw43ZFb_yoW8Zr15pa
	45tayxAF1rtF4Y9F1Yq3WDCa4Yq3ZrAasrK393Wa4fXFy3uFWUXr15GFySqasrJrW0qr17
	KF15t3W7GFs3JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEna9cUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwQ+o2gQwOccoAAAs1

1. PCI: dwc: Standardize link status check to return bool.
2. PCI: mobiveil: Refactor link status check.
3. PCI: cadence: Simplify j721e link status check.

---
Changes for v2:
- Remove the return of some functions (!!) .
- Patches 2/3 and 3/3 have not been modified.

Based on the following branch:
https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dw-rockchip
---

Hans Zhang (3):
  PCI: dwc: Standardize link status check to return bool
  PCI: mobiveil: Refactor link status check
  PCI: cadence: Simplify j721e link status check

 drivers/pci/controller/cadence/pci-j721e.c             | 6 +-----
 drivers/pci/controller/dwc/pci-dra7xx.c                | 4 ++--
 drivers/pci/controller/dwc/pci-exynos.c                | 4 ++--
 drivers/pci/controller/dwc/pci-keystone.c              | 5 ++---
 drivers/pci/controller/dwc/pci-meson.c                 | 6 +++---
 drivers/pci/controller/dwc/pcie-armada8k.c             | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.c           | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h           | 4 ++--
 drivers/pci/controller/dwc/pcie-dw-rockchip.c          | 2 +-
 drivers/pci/controller/dwc/pcie-histb.c                | 9 +++------
 drivers/pci/controller/dwc/pcie-keembay.c              | 2 +-
 drivers/pci/controller/dwc/pcie-kirin.c                | 7 ++-----
 drivers/pci/controller/dwc/pcie-qcom-ep.c              | 2 +-
 drivers/pci/controller/dwc/pcie-qcom.c                 | 4 ++--
 drivers/pci/controller/dwc/pcie-rcar-gen4.c            | 2 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c            | 7 ++-----
 drivers/pci/controller/dwc/pcie-tegra194.c             | 4 ++--
 drivers/pci/controller/dwc/pcie-uniphier.c             | 2 +-
 drivers/pci/controller/dwc/pcie-visconti.c             | 4 ++--
 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 9 ++-------
 drivers/pci/controller/mobiveil/pcie-mobiveil.h        | 2 +-
 21 files changed, 37 insertions(+), 56 deletions(-)


base-commit: 286ed198b899739862456f451eda884558526a9d
-- 
2.25.1


