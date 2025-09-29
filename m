Return-Path: <linux-pci+bounces-37182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4AABA81F4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 08:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FFF3B6D22
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 06:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B9A22FE11;
	Mon, 29 Sep 2025 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcRdjkoh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933651922FD
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759127376; cv=none; b=niIYuQeU5E349FeJvQuKK45bU1JyHVOeR5lETGphfi365N4UMZp8G0VF9a3XHteIuncbzxZf5SAGKtt/E3wUiNZ0OaFFLQyFrkmQsQRU69xClkZLjwiaRggnJePL2WdQOfQbbcZSoRNVlKNMypO9Pfj4GEjjsFeVLX9hkblZsas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759127376; c=relaxed/simple;
	bh=t+Koxc3Z1CXLljM14T11j+DIy1pU2lXgn8tsIiYMtks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ggQtgb3CR54QNn8WpWfDphYg3EF9idx7QRZfE+pFXAtKHnw1pUqDRmEIVVE9zQj27Mk9MYbGeRlE8SsuHHayLA4mXiqane9AF1vKLPhEMnpeuOCN2T7p4Ikf2ez7U2mHxL6G1zC65+BvpQpvrhsJ+EjOUCgsWXtM7/VAU7SlCas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcRdjkoh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759127375; x=1790663375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t+Koxc3Z1CXLljM14T11j+DIy1pU2lXgn8tsIiYMtks=;
  b=KcRdjkoh14iAnhptwAQSjIDXj6Vl3LtvlDJwsn/f+ex1JQfH8taoCTQt
   zRHxN7QDEHpyLtCqb/XbPoe9QcT/lBQgDz5+2QDxaCm4TyQuMfQ8VXpIE
   AfFQWO78GclH6KWmrfnIizyAtYgbKUkVAm/2FdcsKHrl+OoYQdtB0xxOl
   gzPPpAeGQFDFmbBXNbw/FzpV1hrfbtm1S+W6SJSOceLUT4qzXE9zk2E3C
   CY7/JGVkEhkezK00xPJIWHJa0xLy6efBZkQ66DIgIyoU6TMUPOl8WZYiX
   53b9vl/ScnuUUAANZww6FzGVvNBjpAeAXJnAwMfc2VgRrq9CUecHo+W6Y
   Q==;
X-CSE-ConnectionGUID: et3pKXocS02/y+Vhwf4RSw==
X-CSE-MsgGUID: k4AGc4v4T5m2ye1E+C7nYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="71608722"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="71608722"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 23:29:34 -0700
X-CSE-ConnectionGUID: y7AUmpEeRJq8DmyKyso/Mg==
X-CSE-MsgGUID: J8vTnINATJCqtLkYsZW0Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="201823441"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa002.fm.intel.com with ESMTP; 28 Sep 2025 23:29:33 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] PCI/NPEM: Set dev->npem to NULL after freeing in pci_npem_remove()
Date: Mon, 29 Sep 2025 11:57:46 +0530
Message-Id: <20250929062746.233382-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set dev->npem to NULL after calling npem_free() in pci_npem_remove().
This ensures the pointer is properly invalidated after the NPEM structure
is freed, avoiding stale pointer access in subsequent operations.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/pci/npem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/npem.c b/drivers/pci/npem.c
index 97507e0df769..d0a85da2e3bc 100644
--- a/drivers/pci/npem.c
+++ b/drivers/pci/npem.c
@@ -558,6 +558,7 @@ static int pci_npem_init(struct pci_dev *dev, const struct npem_ops *ops,
 void pci_npem_remove(struct pci_dev *dev)
 {
 	npem_free(dev->npem);
+	dev->npem = NULL;
 }
 
 void pci_npem_create(struct pci_dev *dev)
-- 
2.34.1


