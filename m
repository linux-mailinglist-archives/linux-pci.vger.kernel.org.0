Return-Path: <linux-pci+bounces-14759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A1D9A1F34
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 11:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A23F289FA5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23FE1D95AA;
	Thu, 17 Oct 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWj2D/Hm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2441DA113;
	Thu, 17 Oct 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158956; cv=none; b=jPVczPelUM5ZrCxp4Vpm2q7UvnnDt9GJLQhCZxLPwVrd5l2u8TY9whSmdFxr4Kr1tuZKl0x0ttRfdgdqpP0s+mje6OP5cRqdV5KL+RadAKJZuJ4zI1rNVp7ktSCYsvzCf7vFqINSSSmV2k37Kd1UZzABcMsqS5CDJDdHYPuHrBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158956; c=relaxed/simple;
	bh=wYiV3LayTuqB3bImr/dzDxL6xWUW5nltsyRpCARFUYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=j/GMuoKm7nmih6yUzB6o+6PeJS9JXt/0iYTRJd6K35fWFLf7rpY+T/CkZ70ot8spGvAx5pcB3+H49GIGTzdQpdqA2giSWjruEx4/KrPrHCN8DKqbX6rbqxSPNGeBWhzT/g7oryacpLSyDLZC7Oh5ZQKsD2DC4KI3hXVCQI5yios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWj2D/Hm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729158954; x=1760694954;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wYiV3LayTuqB3bImr/dzDxL6xWUW5nltsyRpCARFUYU=;
  b=bWj2D/Hm9Z+ijtLG1POVrvdSt5XQczZi/UuwqYMimnnT0GI80fiuQLNQ
   82UcSflgL0Vf0/J3MHJeQXFGRUBuxtegwGfxJWD99S8e1kM3F9WVpFVrq
   cb7FVHVnfcdQT2IafaN4nVZT1baB9fAocPfBx9iFOM1dw1FTFIsvKI01d
   Uw3V9w6PvfhUXyre8LZwreYTXh+QkZshSsQfoGxjfykgGsKn5H2OzrtGU
   fHhoFQxplE0syoX9nNBB1BRe/DbLYz7ms2q4sYJHyUCdZjnlKLQIc7BZy
   6+mgw0ASqgF05OtaQg+VlAi21+HShbQL7QqDDuXXqYDMPQfSrQ4dKXGiB
   A==;
X-CSE-ConnectionGUID: VDQn3VtNQWaHYkmqdOQLsg==
X-CSE-MsgGUID: FUkXbjPiQAqHTI+nJaGaqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46104319"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46104319"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 02:55:53 -0700
X-CSE-ConnectionGUID: hucNkVR6QdS/TYUZRQ947g==
X-CSE-MsgGUID: 7DnR3U6bQ2Gq0bzFZZ8geA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83324502"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 02:55:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/1] PCI: Improve printout in pdev_sort_resources()
Date: Thu, 17 Oct 2024 12:55:45 +0300
Message-Id: <20241017095545.1424-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use pci_resource_name() helper in pdev_sort_resources() to print
resources in user-friendly format. Also replace the vague "bogus
alignment" with a more precise explanation of the problem.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v2:
- Place colon after %s %pR to be consistent with other printouts
- Replace vague "bogus alignment" with the exact cause

 drivers/pci/setup-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 23082bc0ca37..0fd286f79674 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -134,6 +134,7 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 	int i;
 
 	pci_dev_for_each_resource(dev, r, i) {
+		const char *r_name = pci_resource_name(dev, i);
 		struct pci_dev_resource *dev_res, *tmp;
 		resource_size_t r_align;
 		struct list_head *n;
@@ -146,8 +147,8 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 
 		r_align = pci_resource_alignment(dev, r);
 		if (!r_align) {
-			pci_warn(dev, "BAR %d: %pR has bogus alignment\n",
-				 i, r);
+			pci_warn(dev, "%s %pR: alignment must not be zero\n",
+				 r_name, r);
 			continue;
 		}
 
-- 
2.39.5


