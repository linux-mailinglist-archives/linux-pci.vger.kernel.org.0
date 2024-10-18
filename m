Return-Path: <linux-pci+bounces-14868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDB59A41A7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 16:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E0F1F21338
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 14:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8586E200CB4;
	Fri, 18 Oct 2024 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azrOCbFV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8911200BB5;
	Fri, 18 Oct 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262961; cv=none; b=C0uuT+CcEFluTsTP2eegJrfkHszv3R1cXEuqHOyquEb7Af1jGEQkk9ZaHRnViXT3owsmFi5+ayT4sJSHdS1lGUB0mUnlfaAD6DLYPktLgL5u4qNMenduSOYM2e8DItaR1750P6XOG6Ni4ICebCgTC1Lnjz4Yk57OGOiS4SxDTPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262961; c=relaxed/simple;
	bh=/DSXtCjSVErnBE1UUYAqzfBEJ82zTTDeE4E+z1Hw9m8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dof2f/cFP6F+S7HAnP9GKcpvJ31DHXlRKGTg5DIXZ+2QuXiVBbvRduHRipwjHPDXYMgCZjPlz7qrZkcO+5756rOZyvetVPPvL+7EiNx4XePATvpMJEgRL+Nm/2e6/4NDcjPqXZ7m1OYzb4U9Fht7V0QG23LykUm8EASTZ14iC4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azrOCbFV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729262960; x=1760798960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/DSXtCjSVErnBE1UUYAqzfBEJ82zTTDeE4E+z1Hw9m8=;
  b=azrOCbFV6EEkBmV1vojV1GttAX8nqz6jybs8Gogk1Xi90w9B9FW0RSsJ
   AsgomwGMXFWIDsvWrl1fMfx58f3znN/Ed8bwEzBaFaYAscU34WeKuXaUG
   RaVSw3/6lpxj5P89PMHtdy2w6gIFrz/tNjh45PhFFPTJbystfYP111TlT
   IRfYWHr2jUF8mpPIC2GFMwGWNsd6VV58AjrWZrBYJM1v6YE9J8WvyhlK/
   tiLFNdPXnZmBZvzEHNGOppII+ZWsKpl6IUvjqKyuNeKJXye0an7t+j0Lh
   y9scKPYZdNx8JsdNzu8x08BJFB+troVjQvxBVeRnOICYYpUU5YpvxIWme
   g==;
X-CSE-ConnectionGUID: Uovi8ni/TCK35sMwU92BnA==
X-CSE-MsgGUID: gDzYvtIYQdeQJVi8O7HPJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28756979"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28756979"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:49:18 -0700
X-CSE-ConnectionGUID: EQmBtMLbStqIn64gi1xIhg==
X-CSE-MsgGUID: nD4TO5F3RBqKA34Xu7lIpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="78845200"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:49:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v9 5/9] PCI/quirks: Abstract LBMS seen check into own function
Date: Fri, 18 Oct 2024 17:47:51 +0300
Message-Id: <20241018144755.7875-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Target Speed quirk in pcie_failed_link_retrain() uses the presence
of LBMS bit as one of the triggering conditions effectively
monopolizing the use of that bit. An upcoming change will introduce a
PCIe bandwidth controller which sets up an interrupt to track LBMS. As
LBMS will be cleared by the interrupt handler, the Target Speed quirk
will no longer be able to observe LBMS directly.

As a preparatory step for the change, extract the LBMS seen check from
pcie_failed_link_retrain() into a new function pcie_lmbs_seen().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/quirks.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dccb60c1d9cc..a560ea403b8e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -33,6 +33,11 @@
 #include <linux/switchtec.h>
 #include "pci.h"
 
+static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
+{
+	return lnksta & PCI_EXP_LNKSTA_LBMS;
+}
+
 /*
  * Retrain the link of a downstream PCIe port by hand if necessary.
  *
@@ -96,8 +101,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
-	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
-	    PCI_EXP_LNKSTA_LBMS) {
+	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
 		u16 oldlnkctl2 = lnkctl2;
 
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
-- 
2.39.5


