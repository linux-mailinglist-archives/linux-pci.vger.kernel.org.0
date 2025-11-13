Return-Path: <linux-pci+bounces-41123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03946C58E33
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4BFD035D19F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B34735C199;
	Thu, 13 Nov 2025 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ycdd7mnP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC1135C194;
	Thu, 13 Nov 2025 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051229; cv=none; b=j9ltkUJAKEKY7TJaBuhyJe1hq1qYBgsEHvWrEdqf485l+FmwcmoHzrQyLA1Rhd9lSMlPY2SPHbrA1oP/DP69SzEVRdcLKJDRL0hOr1HT2F/krLjwHA6gWEXv6JGKQFBOnKtuRTWBQkeu6Z/MKYi4qEkP7+PObAO0UnAr0GyI/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051229; c=relaxed/simple;
	bh=eXY9NGXcwRMx1xvaKvqt9qvpIBzUTXZuSwBZqc+Vd8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrOSEaiu51jm3hm4AOyyMPOnrLAQjQQBU8ynzIgHY+jTzTvOalKwgCDc5O3SzWfdC0wH8QgmD+FxzM9/+GCOZAdwPOVuYzvUvXFZD6Bdzmhz3A5VOMkoIsYaxHo/rYPsub1t8RMG77bWCM1evWDX5XTXdLK7/Uh2eoyeizp+l4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ycdd7mnP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051227; x=1794587227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eXY9NGXcwRMx1xvaKvqt9qvpIBzUTXZuSwBZqc+Vd8I=;
  b=Ycdd7mnPM46jxDge4+qqBQWvAdNSSS22aGKaS7NiszCbh/Ng+1eONZ8H
   PlZeyXevP0uqDarQia6EAy2kX9+d3qwhbDBQh1gBbB2LKLhrienfRxqt9
   drtIOKRZDriezgmTjz4sgcmAJhCVGh/dBaPEUrTfdfCtkdsAkoHb2c0o+
   R9a+n/c1thb8KZm06Ms+666EDiE7D0Id9DGMVSgBb0ScOCt2FxFjHKHxg
   1mKnsxI4baBIFrNxxlRluuhlruibWC/1Dkl3ptmK9suko03tujDYaTcc7
   lZNNfNftB9n8Ejx08VjssQQZbue1GJQa9TdLrNqXJrn76SEmI7jwWaG21
   w==;
X-CSE-ConnectionGUID: e+l/GPS3TfaLlhhZPAaFAg==
X-CSE-MsgGUID: deD9iqdUQWOeuWCxqDj/2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="68766616"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="68766616"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:07 -0800
X-CSE-ConnectionGUID: UPI+Qi84Rr+aHEhkQ6DphA==
X-CSE-MsgGUID: vMO03pLcRGmHlXEzSYk55A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189553826"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:00 -0800
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
Subject: [PATCH v2 02/11] PCI/IOV: Adjust ->barsz[] when changing BAR size
Date: Thu, 13 Nov 2025 18:26:19 +0200
Message-Id: <20251113162628.5946-3-ilpo.jarvinen@linux.intel.com>
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

pci_rebar_set_size() adjusts BAR size for both normal and IOV BARs. The
struct pci_srvio keeps a cached copy of BAR size in unit of resource_size_t
in ->barsz[] which is not adjusted by pci_rebar_set_size() but by
pci_iov_resource_set_size(). pci_iov_resource_set_size() is called also
from pci_resize_resource_set_size().

The current arrangement is problematic once BAR resize algorithm starts to
roll back changes properly in case of a failure. The normal resource
fitting algorithm rolls back resource size using the struct
pci_dev_resource easily but also calling pci_resize_resource_set_size() or
pci_iov_resource_set_size() to roll back BAR size would be an extra burden,
whereas combining ->barsz[] update with pci_rebar_set_size() naturally
rolls back it when restoring the old BAR size on a different layer of the
BAR resize operation.

Thus, rework pci_rebar_set_size() to also update ->barsz[].

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/iov.c       | 15 ++++-----------
 drivers/pci/pci.c       |  4 ++++
 drivers/pci/pci.h       |  5 ++---
 drivers/pci/setup-res.c | 10 ++++------
 4 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 77dee43b7858..04b675e90963 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -158,8 +158,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 	return dev->sriov->barsz[pci_resource_num_to_vf_bar(resno)];
 }
 
-void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
-			       resource_size_t size)
+void pci_iov_resource_set_size(struct pci_dev *dev, int resno, int size)
 {
 	if (!pci_resource_is_iov(resno)) {
 		pci_warn(dev, "%s is not an IOV resource\n",
@@ -167,7 +166,8 @@ void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
 		return;
 	}
 
-	dev->sriov->barsz[pci_resource_num_to_vf_bar(resno)] = size;
+	resno = pci_resource_num_to_vf_bar(resno);
+	dev->sriov->barsz[resno] = pci_rebar_size_to_bytes(size);
 }
 
 bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev)
@@ -1340,7 +1340,6 @@ EXPORT_SYMBOL_GPL(pci_sriov_configure_simple);
 int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size)
 {
 	u32 sizes;
-	int ret;
 
 	if (!pci_resource_is_iov(resno))
 		return -EINVAL;
@@ -1355,13 +1354,7 @@ int pci_iov_vf_bar_set_size(struct pci_dev *dev, int resno, int size)
 	if (!(sizes & BIT(size)))
 		return -EINVAL;
 
-	ret = pci_rebar_set_size(dev, resno, size);
-	if (ret)
-		return ret;
-
-	pci_iov_resource_set_size(dev, resno, pci_rebar_size_to_bytes(size));
-
-	return 0;
+	return pci_rebar_set_size(dev, resno, size);
 }
 EXPORT_SYMBOL_GPL(pci_iov_vf_bar_set_size);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..7dfc58b0e55e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3803,6 +3803,10 @@ int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
 	ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
 	ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
 	pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+
+	if (pci_resource_is_iov(bar))
+		pci_iov_resource_set_size(pdev, bar, size);
+
 	return 0;
 }
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4492b809094b..bf1a577e9623 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -808,8 +808,7 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
 void pci_restore_iov_state(struct pci_dev *dev);
 int pci_iov_bus_range(struct pci_bus *bus);
-void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
-			       resource_size_t size);
+void pci_iov_resource_set_size(struct pci_dev *dev, int resno, int size);
 bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev);
 static inline u16 pci_iov_vf_rebar_cap(struct pci_dev *dev)
 {
@@ -851,7 +850,7 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 	return 0;
 }
 static inline void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
-					     resource_size_t size) { }
+					     int size) { }
 static inline bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev)
 {
 	return false;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index c3ba4ccecd43..3d0b0b3f60c4 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -450,12 +450,10 @@ static void pci_resize_resource_set_size(struct pci_dev *dev, int resno,
 	resource_size_t res_size = pci_rebar_size_to_bytes(size);
 	struct resource *res = pci_resource_n(dev, resno);
 
-	if (!pci_resource_is_iov(resno)) {
-		resource_set_size(res, res_size);
-	} else {
-		resource_set_size(res, res_size * pci_sriov_get_totalvfs(dev));
-		pci_iov_resource_set_size(dev, resno, res_size);
-	}
+	if (pci_resource_is_iov(resno))
+		res_size *= pci_sriov_get_totalvfs(dev);
+
+	resource_set_size(res, res_size);
 }
 
 int pci_resize_resource(struct pci_dev *dev, int resno, int size)
-- 
2.39.5


