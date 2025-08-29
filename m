Return-Path: <linux-pci+bounces-35111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D02B3BC2E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16411CC2450
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6946131AF2F;
	Fri, 29 Aug 2025 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+8fR+kF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E929D267;
	Fri, 29 Aug 2025 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473188; cv=none; b=IWkbUYintc27jZRjymQ1RwGx11PoSDmKxzapyUTXR+/gZAPCPpaTKIoSvtingUfmuimgPAz1ySVpSzwX73yOV1NFwqgvrP5pUBazunUVJFrymwxJdwiVCK4trEo1TiqJZtBnQNiuYzbmZQOffYByHMZS63l/aNtZNIWooQA0B6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473188; c=relaxed/simple;
	bh=YAtXaIrqxIsPbnTVDScJPvQkrTlHwC25VBd/X8muHHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMKu483v432R1ELJOME5qGRWDb5DASo2DEfvDUJxoC/0QPk4HoTnZopr5UrFzVSgDB5dBjyxUJERkU6eDhcCbRb/80A68qW0njxduvCzQy6wUnIDKpnEhiZ2q/A3wmkJHr7jLJjFwnQcVOwk0c2iG8HNI0l5XztWdNdE+aJ9bSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+8fR+kF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473187; x=1788009187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YAtXaIrqxIsPbnTVDScJPvQkrTlHwC25VBd/X8muHHw=;
  b=U+8fR+kF/pIABhDZ5IzyX4s/O4Nlm7tI/Ur+Oq+KSy3XyjjW5iqx9M31
   6R98zgp5rM1ITwC8DhYfxPgFGOo8DDSWa/bnEmmjSwaxq8RfJYWSZNoPs
   Zh2nqW8DeJbAzCyn75NkPLgBW83GUptRNX+dbc81R9qfMxVJOGqPt3aki
   cWV+hyNgNF3FyelMYUuNKmXjjCSW7/cbJe33UeYcxuR9M7emYiaI0pnRd
   l8zAUxAT0Ir6ipO9HzfYSJxUAb/lgFKN9wHT9OFnrs7ZhL6f06EJC7CHG
   +77yMbOLJKjvykBbJn/fPvf3yaLIxjxcWh7kDkzu8HkANrl8+MuUFK6Fq
   Q==;
X-CSE-ConnectionGUID: ihqhxOxmSYO/7annjSroig==
X-CSE-MsgGUID: VhueZqINQXuf4nO/NU25RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62576129"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="62576129"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:06 -0700
X-CSE-ConnectionGUID: 13Yue80OQL6kD1r017javA==
X-CSE-MsgGUID: 1/heaiDbTTOEc07fs6Zupw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174733754"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 14/24] PCI: Warn if bridge window cannot be released when resizing BAR
Date: Fri, 29 Aug 2025 16:11:03 +0300
Message-Id: <20250829131113.36754-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BAR resizing calls to pci_reassign_bridge_resources(), which attempts to
release any upstream bridge window to allow them to accommodate the new BAR
size. The release can only be performed if there are no other child
resources for the bridge window. Previously the code continued silently
when other child resources were detected.

Add pci_warn() to inform user that a bridge window could not be released
because of child resources. As a small bridge window is often the reason
why BAR resize fails, this warning will help to pinpoint to the cause.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4b08b9cecab3..47f1a4747607 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2555,6 +2555,12 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 				goto cleanup;
 
 			pci_release_resource(bridge, i);
+		} else {
+			const char *res_name = pci_resource_name(bridge, i);
+
+			pci_warn(bridge,
+				 "%s %pR: was not released (still contains assigned resources)\n",
+				 res_name, res);
 		}
 
 		bus = bus->parent;
-- 
2.39.5


