Return-Path: <linux-pci+bounces-43426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98826CD1536
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 19:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0008130CB7A4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED43340A79;
	Fri, 19 Dec 2025 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2RUhw5i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C8341051;
	Fri, 19 Dec 2025 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166141; cv=none; b=FDPuCYYkTTG9yzGiCCDS42qrh6ryczjlbMzhGtBDpQ+LjmhIzx76lwtmNcDtUSQWGjVmcU6jsTseQqoKnLS0xalvMaqngvXLqNShXNyC5somuAaYo54UJ7HjNnX3EFM0KT0DtdEFexfhgVALTtZBXsO5LwSKuOkLMQt7r1QwwL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166141; c=relaxed/simple;
	bh=PNlP/hFPNCBfjXffRuzG4iVrio2n+yrhCoRQwqLz5iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/Hq8JQMo8VbhK8IW5Ml1/qrrIYw7LuLol6b3nUmHe2Tf6DS8MWxxiKQ6+M6xQcaxb3GYgqIaF0f7pD6R3uF6oPrTj/8IbfEJWIoFC1gZWPRr8azwDZHRao5AqDJcnpu6g5nbsnkfnffkXM0ZhDNGYT28JiNqYy4Qo5BAMbid1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2RUhw5i; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166140; x=1797702140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PNlP/hFPNCBfjXffRuzG4iVrio2n+yrhCoRQwqLz5iw=;
  b=F2RUhw5ia/xbEMiKerV1qbXDdwd4yPrAyoEk71237gjg/6soBqo6yC/6
   Rxl0+GAx8dMSJkfsYXtbEg2wyuYsJFHagG8XmWWeR11Ak7AiCQ4rFNkAF
   q4n9PQnjNgVkH1GXIG1T8LfqTUyTmMtQWaMUVcmZMOgOZGdvkx2BvPCEk
   4O/L7zs5PCNqXoB3QKlk2fLA97cDS5ZoS4xr6pXO6PSwRuai5sCZ1sZyd
   nfIGGMvKbLpAdMM5OVCDMBsVnVJwcEf4OUitB2EJYfQ+OBZOUXzP/z26O
   5r/4vv0ceGvvtj/uqt5Gc+3RPZguG2F2qAC/rLL+oK3hQpSbf8nkQtJ7p
   w==;
X-CSE-ConnectionGUID: C1uTfkg0TmSn9wxctrdQaQ==
X-CSE-MsgGUID: n97qbBADT5Knnl32qTtZ6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="68173923"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="68173923"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:19 -0800
X-CSE-ConnectionGUID: dvZzyn5dTGGfJ+B8qmkxHQ==
X-CSE-MsgGUID: of1sv5hnTEiu/fEzepHwbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="229597876"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 11/23] PCI: Log reset and restore of resources
Date: Fri, 19 Dec 2025 19:40:24 +0200
Message-Id: <20251219174036.16738-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCI resource fitting and assignment is complicated to track because it
performs many actions without any logging. One of these is resource
reset (zeroing the resource) and the restore during the multi-passed
resource fitting algorithm.

Resource reset does not play well with the other PCI code if the code
later wants to reattempt assignment of that resource, knowing that a
resource was left into the reset state without a pairing restore is
useful for understanding issues that show up as resource assignment
failures.

Add pci_dbg() to both reset and restore to be better able to track
what's going on within the resource fitting algorithm.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 403139d8c86a..a5b6c555a45b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -136,6 +136,9 @@ static resource_size_t get_res_add_align(struct list_head *head,
 static void restore_dev_resource(struct pci_dev_resource *dev_res)
 {
 	struct resource *res = dev_res->res;
+	struct pci_dev *dev = dev_res->dev;
+	int idx = pci_resource_num(dev, res);
+	const char *res_name = pci_resource_name(dev, idx);
 
 	if (WARN_ON_ONCE(res->parent))
 		return;
@@ -143,6 +146,8 @@ static void restore_dev_resource(struct pci_dev_resource *dev_res)
 	res->start = dev_res->start;
 	res->end = dev_res->end;
 	res->flags = dev_res->flags;
+
+	pci_dbg(dev, "%s %pR: resource restored\n", res_name, res);
 }
 
 /*
@@ -384,15 +389,18 @@ bool pci_resource_is_optional(const struct pci_dev *dev, int resno)
 	return false;
 }
 
-static inline void reset_resource(struct pci_dev *dev, struct resource *res)
+static void reset_resource(struct pci_dev *dev, struct resource *res)
 {
 	int idx = pci_resource_num(dev, res);
+	const char *res_name = pci_resource_name(dev, idx);
 
 	if (pci_resource_is_bridge_win(idx)) {
 		res->flags |= IORESOURCE_UNSET;
 		return;
 	}
 
+	pci_dbg(dev, "%s %pR: resetting resource\n", res_name, res);
+
 	res->start = 0;
 	res->end = 0;
 	res->flags = 0;
-- 
2.39.5


