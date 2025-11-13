Return-Path: <linux-pci+bounces-41125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 025F8C58CFE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8969D3BCD71
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A5B358D15;
	Thu, 13 Nov 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRfSO1Fz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50423590AC;
	Thu, 13 Nov 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051251; cv=none; b=HEFPkhaHxUDBvSBH4A1s/mcd71NZVevjYg1ICDhigOus+KvZd0WiYaRsHpYTJHbouJsK47hFvuPkvbp813qHjPmmuDsO8Ku4wuLOWzGafi5l3Lf/pwwGDcoBstoFan1HSW/DfV+HT5BSmm+B/E0S7EGSLgc2Pl79Q3IGXTeTqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051251; c=relaxed/simple;
	bh=tH8YgZlv9d0wlhPjzMO9fmgTNpl7ZjS2fL9m6nz41ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQxxx3Msf/eYv+uKzyD9FqCdOPba0eGrXoBKoNcuzSHMejoEWVg7sP6nyc694yAX+Pz/meNalI2fFXHjweFbDGeGv53Pskmzx0tq9jTN7PWmwPyhjWTF6/F1X3/xo+pSrFCgqspN3JXYxqBr6UWiL/sZxVmfBVnWnzVsLyVuUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRfSO1Fz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051249; x=1794587249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tH8YgZlv9d0wlhPjzMO9fmgTNpl7ZjS2fL9m6nz41ok=;
  b=aRfSO1FzoR9bK5JrQ0FZ8h05kPjto3BgVwcNj5FxAkC7v1LUs7brlIis
   YIn9mYOkQwNPLuZCkJQXHq4t0fcD0lTuFvJZh6V5JJ2CYoj/j/XyQjt3O
   VKZg/62S9lItIgIj0QrrZ1Up7SuG7gU9FRttY2v2MEtBVDux/Ypl2xTqr
   2Pz4oKfyOU0yuMub5OpzU+9Eyu4BbDlLCSRofT7tuBsHdcFoegy8WK/iQ
   +F8i6zEByJqngmwnFIoAKPiEeQCM5GkH/4AAfan2xbThpU3X0RhI+OKvm
   bQA8+U6QRlXf7zDxNBO4ppa4GWWlr8jUZVNzgEYFcY38fi8LAl+9Mzvyh
   Q==;
X-CSE-ConnectionGUID: M62wGEGOTfSQbZ3iTnuJHA==
X-CSE-MsgGUID: wgze7nmZTy+9ulpB99LwRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65176155"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="65176155"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:28 -0800
X-CSE-ConnectionGUID: GC8T9ezKSTCEGGdX/L39MQ==
X-CSE-MsgGUID: 0wxTKae0QuaHonn3ZhHtnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189971869"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 04/11] PCI: Try BAR resize even when no window was released
Date: Thu, 13 Nov 2025 18:26:21 +0200
Message-Id: <20251113162628.5946-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Usually, resizing BARs requires releasing bridge windows in order to
resize it to fit a larger BAR into the window. This is not always the
case, however, FW could have made the window large enough to accomodate
larger BAR as is, or the user might prefer to shrink a BAR to make more
space for another Resizable BAR.

Thus, replace the check that requires that at least one bridge window
was released with a check that simply ensures bridge is not NULL.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d58f025aeaff..1a3d54563854 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2424,7 +2424,7 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 {
 	unsigned long type = res->flags;
 	struct pci_dev_resource *dev_res;
-	struct pci_dev *bridge;
+	struct pci_dev *bridge = NULL;
 	LIST_HEAD(saved);
 	LIST_HEAD(added);
 	LIST_HEAD(failed);
@@ -2459,10 +2459,8 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 		bus = bus->parent;
 	}
 
-	if (list_empty(&saved)) {
-		up_read(&pci_bus_sem);
+	if (!bridge)
 		return -ENOENT;
-	}
 
 	__pci_bus_size_bridges(bridge->subordinate, &added);
 	__pci_bridge_assign_resources(bridge, &added, &failed);
-- 
2.39.5


