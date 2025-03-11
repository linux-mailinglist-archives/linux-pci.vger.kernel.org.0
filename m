Return-Path: <linux-pci+bounces-23448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 963F0A5CCA0
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 18:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FF2179F09
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE81E1EBA1E;
	Tue, 11 Mar 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aaj7vdOh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F6F1E9B26;
	Tue, 11 Mar 2025 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715231; cv=none; b=qibQWqG3SJZOxRKjtqYn9gnt/cC1/QF1p7z7VDim5KbEaflhdfjcDI+ViLQShVJnp9Kwg5+2DUfX18jJNVrZUUxT+I0CZuOU2siA0naV35peouA7rF4DgZDhEgC9+OMz0SfiIihGzOwEwnnc54q2zzm525IPzjE6JI+T0xGodbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715231; c=relaxed/simple;
	bh=dQMNvPwr30uRdcikX37ZIEUV+onSGkBkVN+Ew8Cp57Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mR8LXQ3l0F6s8UB82ZMijfmG0anj2px44XABgJMVPjPeE7jVTIode9FdwtAT6t01yPUnVBIgSbfbJvyUVM6jHKuIuRq3AVMM348kPQbmuamO8BClovwHmFLZ8tSG6vBI5a1jowvsUW5WBSejG4dAEshyP3ZHsFE2irkh5CIyayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aaj7vdOh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741715230; x=1773251230;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dQMNvPwr30uRdcikX37ZIEUV+onSGkBkVN+Ew8Cp57Y=;
  b=aaj7vdOhxbMgMUjC4DXlJ2Io4eWKJwOczqzvk5Lk1NLAxr5l2W7wKZtv
   As/U3P764GZLyDUIi3zevziaIIAeQA0hqLPfW6i0fVOeton7PgEkD2eIZ
   M0AHakpJeXFHyRIlHdMBpD9/2czBnE6b0QokUOmMR46qjgv5EwpfB0DZY
   BE+PRbMJWg7n5NVy7FBYAR/SqW3U+gHgiCpC6WOer19cFbURmOFylZ5xO
   UYcbBWAjBSeVmLv9ACQj77JRs/cTOV71HCxqa2Nb7TVyB8JBeD5LFhVti
   AgkkBWmI+9YVKMSD9RKhNfTETjvE+EEzjkRTmYaPoqm9WCB+HR5I8zswe
   A==;
X-CSE-ConnectionGUID: OTk5xFXbTb2RT2M/i6cfXQ==
X-CSE-MsgGUID: Vf2UoIuhTMia0OtXYkbafg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46550713"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="46550713"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:47:10 -0700
X-CSE-ConnectionGUID: ePXCid82RJ+Rd9kyerh/cw==
X-CSE-MsgGUID: ZijMnOdZT+GmXSQoZ4kqBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="124563336"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.251])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:47:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/4] PCI: Move pci_rescan_bus_bridge_resize() declaration to pci/pci.h
Date: Tue, 11 Mar 2025 19:46:58 +0200
Message-Id: <20250311174701.3586-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_rescan_bus_bridge_resize() is only used by code inside PCI
subsystem. The comment also falsely advertizes it to be for hotplug
drivers, yet the only caller is from sysfs store function. Move the
function declaration into pci/pci.h.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h   | 2 ++
 include/linux/pci.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..be2f43c9d3b0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -309,6 +309,8 @@ enum pci_bar_type {
 struct device *pci_get_host_bridge_device(struct pci_dev *dev);
 void pci_put_host_bridge_device(struct device *dev);
 
+unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
+
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 				int rrs_timeout);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..d788acf2686a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1455,7 +1455,6 @@ void set_pcie_port_type(struct pci_dev *pdev);
 void set_pcie_hotplug_bridge(struct pci_dev *pdev);
 
 /* Functions for PCI Hotplug drivers to use */
-unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
 void pci_lock_rescan_remove(void);
 void pci_unlock_rescan_remove(void);

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.39.5


