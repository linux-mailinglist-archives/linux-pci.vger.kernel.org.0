Return-Path: <linux-pci+bounces-14790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F51D9A24A7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F3628A95E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E291DED51;
	Thu, 17 Oct 2024 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avpGkxX7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852211DE8BC;
	Thu, 17 Oct 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174303; cv=none; b=q695oEiWauhpYfU1LKLbazZPizK/Eov5Q6zeBG+hPmzkupwxL3PzpUsMTt0wuhqIqrNEIcTgETlFLu6me32K1zwEwbmR6WhBI4VEWG6nfFngnV8IsHlJ2DJSqZSvSL6i7ppXgD997GBC4noqF/N+qSWyy4J68XzOq0toY4QK+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174303; c=relaxed/simple;
	bh=5IR1uB3TgtqzCsMDhgM3NCGAzVYFoWeICAq85ssp+Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnUJY+2Ddypd79pDqXEilDlfTsWx6DJ6SlyXXBGHHbpYwotr935B+aYZnpPF8K7WX6ABOeya1B7zyeBlDHwOEyVEE13XOZChlmoWub82aRkGtO6Phd4++ObmLMTK2Wms2HcA9hGdnbUZqB6ns5GOkFB/n86mpMKkzwubA/AtUmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avpGkxX7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729174299; x=1760710299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5IR1uB3TgtqzCsMDhgM3NCGAzVYFoWeICAq85ssp+Gs=;
  b=avpGkxX7idBye7OM1HVX5FpfK3eY/knE17LlVT576FK0NrVFBoAJI06c
   qmBtTfL8fSX32EmaRhU5q646bDs/BTO1T6djdxwIhwkmLqAi44oEKi1Fa
   YYqup8HwTfEux02EaJMvhQjx0m1OYl0puGJnlsTEnKTyFegIoaX7YhiEn
   0QAacnuMH8rUfDgUf3dNw+qUVc3Gp2RT98KmMIa3wR3h3Y2N85bH7tUxE
   gVr0MSeZVWkbxmGR1GAx5R6VWoj6QMnXqQFTscfJNUTWVxBob4UmVOWeT
   i1GB6OplIBDOOxXZV0NnKjuo85Pr0s46UTlaoGsHum/cp3vnJYiYdkbTR
   Q==;
X-CSE-ConnectionGUID: moPGL17lQNeLIMsMZ0Eu7w==
X-CSE-MsgGUID: xje5+rqKRyqI8xBYIoWIzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54075357"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="54075357"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:11:38 -0700
X-CSE-ConnectionGUID: 7LNHrZfTTVmUUOv2f/oL3Q==
X-CSE-MsgGUID: q7uFooHwQpy5EWKpCPBRTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78701389"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 07:11:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/3] PCI: Use reverse logic in pci_read_bridge_bases()
Date: Thu, 17 Oct 2024 17:11:10 +0300
Message-Id: <20241017141111.44612-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241017141111.44612-1-ilpo.jarvinen@linux.intel.com>
References: <20241017141111.44612-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use reverse logic combined with return and continue to allow
significant reduction in indentation level in pci_read_bridge_bases().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/probe.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4243b1e6ece2..cc97dbda7e76 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -543,14 +543,15 @@ void pci_read_bridge_bases(struct pci_bus *child)
 	pci_read_bridge_mmio(child->self, child->resource[1], false);
 	pci_read_bridge_mmio_pref(child->self, child->resource[2], false);
 
-	if (dev->transparent) {
-		pci_bus_for_each_resource(child->parent, res) {
-			if (res && res->flags) {
-				pci_bus_add_resource(child, res);
-				pci_info(dev, "  bridge window %pR (subtractive decode)\n",
-					   res);
-			}
-		}
+	if (!dev->transparent)
+		return;
+
+	pci_bus_for_each_resource(child->parent, res) {
+		if (!res || !res->flags)
+			continue;
+
+		pci_bus_add_resource(child, res);
+		pci_info(dev, "  bridge window %pR (subtractive decode)\n", res);
 	}
 }
 
-- 
2.39.5


