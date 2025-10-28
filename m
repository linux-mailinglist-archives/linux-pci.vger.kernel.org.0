Return-Path: <linux-pci+bounces-39557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A09FC163DA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61A97504A82
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 17:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BCF337107;
	Tue, 28 Oct 2025 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Do03anEH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3C339B3B;
	Tue, 28 Oct 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673027; cv=none; b=f5i7oGS6XKHcQH8Z3RyQfYgNHc9Sh4/fqKJyBcHJqVXZ7DQE+y5kYHMBG4yDp6aNyCJa+OLgyIk7bkcRCXxq6QhfMlsTw6ToBA5h4aQ4sSZ86HbP4As06H9QbCepHHvCOFDdflt0nP6Dx07L5R+T6NEkrugTr5qDyzw6ugfRA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673027; c=relaxed/simple;
	bh=EiT5hL30QLFm3yb5FssrJ17hLpcSHd+wx/30o6JfyWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQbkFxwWpwEi6nx6ZZHQZ0y0c/tfLBRQFjRYK1UVHE6jXWwErSQ8OnqAvjWRjz6K28kg4Zqy3yOC1Gr2mELanYPpWKXpUkiwlxmLCrxrVsrbQmfh58mCMtsmR025iNoo39HU68XqgWFYnA9abKWbOdIIkdsh6dwEPkyHmRvz99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Do03anEH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761673022; x=1793209022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EiT5hL30QLFm3yb5FssrJ17hLpcSHd+wx/30o6JfyWo=;
  b=Do03anEH224FBcP0im2y0n1Xi/TaGsAjoCEZh0WfGMiEPZAdnHwurtBs
   zwni+gAmY2vqVjcimY07k3T589CiR8FICC1MZG1YlNXzfcT7xN5lVEXIw
   u1Pw9ruzbeDwMv2emK/PJHZmVOW5o6jnlY4s3sNWvcY5uChKgKvkotPzS
   kWsNMfEfybzfNQhcaRBN/5G14lxLJZesHawgh0bVwdP+A5aJqH3ZWhbXO
   219pHky0Va/9Dfr44emmmZFFakiqX+4ftPUQm9Tg3BzGqI2QIYaceQBqW
   4AvpK80UTzL/IUzic3ttEAye4Ui06s6PZzS7Q89l1OjtzMvm6oIOl6jaw
   Q==;
X-CSE-ConnectionGUID: c+urPVWPRvCvbd3I4lUI7g==
X-CSE-MsgGUID: lGzouIJnSPCf9fvnzhaiCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81413221"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="81413221"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:37:00 -0700
X-CSE-ConnectionGUID: TC3quM/ERgeiXFGUpMlo2A==
X-CSE-MsgGUID: vdt7woL2RBiSVzd55S1BGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="216072445"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:36:52 -0700
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
Subject: [PATCH 4/9] PCI: Try BAR resize even when no window was released
Date: Tue, 28 Oct 2025 19:35:46 +0200
Message-Id: <20251028173551.22578-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251028173551.22578-1-ilpo.jarvinen@linux.intel.com>
References: <20251028173551.22578-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Usually, resizing BARs requires releasing bridge windows in order to
resize it to fit a larged BAR into the window. This is not always the
case, however, FW could have made the window large enough to accomodate
larger BAR as is, or the user might prefer to shrink a BAR to make more
space for another Resizable BAR.

Thus, replace the check that requires that at least one bridge window
was released with a check that simply ensures bridge is not NULL.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index d58f025aeaff..76a4259ab076 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
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


