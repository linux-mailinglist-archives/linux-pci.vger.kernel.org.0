Return-Path: <linux-pci+bounces-23450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE0BA5CCA7
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 18:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3772A189F0A9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 17:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3412638BC;
	Tue, 11 Mar 2025 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0t6rNNu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6689E26158C;
	Tue, 11 Mar 2025 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715242; cv=none; b=TuBkW9Ewk8lvr3HhKw/oaMSe5ZOmBBHsyH5V2+AvfU2DfGd/v9xRsN030PB5BxCMtOUKxSl+0555ZAeuwkDF9BfuxlI4lZmGA3AUsi9EGqF3W6C9rKmwqtJS7N5MMt0R269DW4Vw4LEplJt9R7/1gL5I1Zi50r9N473h3Qk5OJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715242; c=relaxed/simple;
	bh=6KeP7/65CU2roRCfckZMDuoWh/RmFYC3xcvJpC2jw2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OISjaqb/7BvBV3m01Nx8P1k6LoQ150veCM2o9N7zGoNdxMHUGvHDP5fuaAjwC1fm2nD6S2/TnIMFn/QaztzmdXECeP30zXNSjBYk/g5rNakJWEs8/dh3G9kIYugEqQHU84agZk9HkuI5QjM7yqcM64M9ipMis7kvxVhNwgprX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0t6rNNu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741715242; x=1773251242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6KeP7/65CU2roRCfckZMDuoWh/RmFYC3xcvJpC2jw2o=;
  b=g0t6rNNuaKKO90JLOegeTQxd+xjDWyaOe5JjmZrCJrXvLfh4VXOwWoaF
   N5K2RYfhf1OllAVwB/kbfVh/CAokwyRXbEgPPjKXZxY8vBYuKRaAgNsDL
   vBMWThtZam4VCcYmhJKp2CdFvSJ4ZePy27SRSEbJQrZHxLjZQh1t+aYHw
   PMOaRtpCBpkmwOwRLxOIQkEA5+bK8raxCLP7PnA8HgKGhW5+Qsa65azWj
   fzeJb36onIdRaqeWoDuzknfp9aPePe0vPgp3bxdcmMYctYYLhlKPIh7XG
   2oNZrcTr1TIuxiZOJvPoi2pKbbv57zIzCbg1DeY30+GF9abuPboTDt67n
   w==;
X-CSE-ConnectionGUID: /3H/plutQKay6u7qtKYcGg==
X-CSE-MsgGUID: jo1TbBkLTGmgbyXgDKDJyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46414994"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="46414994"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:47:21 -0700
X-CSE-ConnectionGUID: kVbw+0gPQzywyKoG4Qmvlg==
X-CSE-MsgGUID: oyJwascxQMy1RUINsSbkUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="125291599"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.251])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:47:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/4] PCI: Make pci_setup_bridge() static
Date: Tue, 11 Mar 2025 19:47:00 +0200
Message-Id: <20250311174701.3586-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311174701.3586-1-ilpo.jarvinen@linux.intel.com>
References: <20250311174701.3586-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_setup_bridge() is only used within setup-bus.c. Therefore, make it
a static function.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 2 +-
 include/linux/pci.h     | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5e00cecf1f1a..836d260328a8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -694,7 +694,7 @@ void __weak pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
 {
 }
 
-void pci_setup_bridge(struct pci_bus *bus)
+static void pci_setup_bridge(struct pci_bus *bus)
 {
 	unsigned long type = IORESOURCE_IO | IORESOURCE_MEM |
 				  IORESOURCE_PREFETCH;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c629962f4ccd..9a703355ef06 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1634,7 +1634,6 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
-void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
 
-- 
2.39.5


