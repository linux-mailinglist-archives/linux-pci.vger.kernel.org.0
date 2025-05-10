Return-Path: <linux-pci+bounces-27544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2881AB247C
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 17:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4655A1B656DC
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB301235068;
	Sat, 10 May 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X2PmB14l"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3311B245003;
	Sat, 10 May 2025 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746892645; cv=none; b=b5fXsAGFmuLZXNQHbx5XKfzO0DluewtRcOW0eewKXiA/HqpNzrwYwUKHJhdjMr4yY9tW4hBnbnTOL1ZGc8WIm8aVaSgXv/lPD+iEz2M2o7DvV6xGfCUItFbDLlqRIS1fvyojyfoUXsje6KTYAAfT8QyzmG3m7fb9T83yvNLrg3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746892645; c=relaxed/simple;
	bh=KAhNGfk0o76b7mrzBRdNyO3ZXCX7PG7qTMs6jnDE/9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n55z8L1xEI6iNcvD1s7K1bvE97Bk2jO0ZW/6hnpWfGV2EQ6jHNYc7d5VrXWAzsNfJi4rezEy2LCzyPkEVw/eEEJV3EBw5JcXMd0dWqgTQKEwjnLfUIhDu2TvuLEMYSGI3+gOXTylRVBFqlN+5zGVDc24K7jBYOMcUqyd/GC+WH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X2PmB14l; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=DE
	u0ugbaD/EBsgXHrzA+saK2ZnHcC31tU43n92kMs3Q=; b=X2PmB14lcNS9bPpiGB
	3NxGhEVTtE7UpB/dr22ViWJ840f8diVGc0uL0PU0EzKcJdSy3O1+x+ej4XuCeQDh
	uFVzrWgi4RRBb+pDwTD9UAEPLkrKPeoPl3pN3ce3qimhaCI4m1bKX4IFkneu9N+X
	liB8/omO2GJu96M9LrKtKTQUs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXjxsYdx9ormDlAQ--.43845S2;
	Sat, 10 May 2025 23:56:09 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	manivannan.sadhasivam@linaro.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 0/2] Configure root port MPS during host probing
Date: Sat, 10 May 2025 23:56:05 +0800
Message-Id: <20250510155607.390687-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXjxsYdx9ormDlAQ--.43845S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4Dtw1fAFW7ur4rGry8Xwb_yoWDKwc_uF
	WrCayDWw47AFyvyF1rKF4Syryjva97uryUW3WvqayakasxZr13Xana9FW2g3WrWFWSkFsx
	Cr9xZrWfAr12vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRdb1nUUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhhJo2gfbZ-YWwAAsO

1. PCI: Configure root port MPS during host probing
2. PCI: dwc: Remove redundant MPS configuration

---
Changes for v4:
- The patch [v4 1/2] add a comment to explain why it was done this way.
- The patch [v4 2/2] have not been modified.
- Drop patch [v3 3/3]. The Maintainer of the pci-aardvark.c file suggests
  that this patch cannot be submitted. In addition, Mani also suggests
  dropping this patch until this series of issues is resolved.

Changes for v3:
- The new split is patch 2/3 and 3/3.
- Modify the patch 1/3 according to Niklas' suggestion.

Changes for v2:
- According to the Maintainer's suggestion, limit the setting of MPS
  changes to platforms with controller drivers.
- Delete the MPS code set by the SOC manufacturer.
---

Hans Zhang (2):
  PCI: Configure root port MPS during host probing
  PCI: dwc: Remove redundant MPS configuration

 drivers/pci/controller/dwc/pci-meson.c | 17 ------
 drivers/pci/probe.c                    | 72 +++++++++++++++-----------
 2 files changed, 41 insertions(+), 48 deletions(-)


base-commit: 01f95500a162fca88cefab9ed64ceded5afabc12
-- 
2.25.1


