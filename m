Return-Path: <linux-pci+bounces-14059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6BD99660B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 11:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742DA1C24845
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 09:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8208918FDB9;
	Wed,  9 Oct 2024 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkiODHtH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C884818FC85;
	Wed,  9 Oct 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467605; cv=none; b=WV+CYnDhtpUiFrjbFcNgbDG3W8zIr9WY1ypioq7eB6vXp93ZIbOnL9jWvC48Z6OvuffRzQMsnsIjZrky90NKsMFCE1NI79m6Y6au2lJG7NuKOFUIpxOM6MSP1VReKobbDODPw0yhyDgFYni2wz45liuMi4O5ydjPdtb2ejpCCoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467605; c=relaxed/simple;
	bh=EqWOymihfMQu67iuY30CPwxqwpDv/+xgSPHEJquv/zI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBhc44uKwy0+LccxCVefuCRkOslu86YRtrL9Qe+ce+RhZl5e1ex1BVWRmrAwdEsS55ash1F8HAnMo+wE8gsWmkhnFG1SwVSwwDErulGVgcq/1YFy+VwhvArqUy/UOLuECGj3zmwCWCmiiTvHvbbPXSAeOajSnoVi5jU8+v1u7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkiODHtH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728467604; x=1760003604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EqWOymihfMQu67iuY30CPwxqwpDv/+xgSPHEJquv/zI=;
  b=EkiODHtH3mhDx5EZLQYReZ9I++UQuJherM4Ud8jzWbc/JhXdWF6zffax
   aY+jxnFHjl4Bm3pfPb8PfhKhvWmVFduQfpdhZsMQLQ2i2dIprHaytJCax
   qbp+8JmrJBxrcUDFEtB37TNcBzhCm1DMe03aaW2FJsk78mo8dr7pfRhI4
   Ev38Ac0u80JJDWeY1aF/6roFodjq4ozuxPkUY2m57v2ExorBSvtAn5vYy
   PQT8f+qeO/cCINSYzcQCHjfAttWsLtlUyb7XPjC5dQwGKBTD619ktOOqp
   f6wKKmX4L0jgOLiqR9rZsF+mXmMqOOb7UMfBYuSmjNl4CBKclsYqDe6lt
   w==;
X-CSE-ConnectionGUID: sxaBT0kESKO9ZqBAkGQi4A==
X-CSE-MsgGUID: 0aB86OkxSVSTSCKBwP80TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38322952"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="38322952"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:53:23 -0700
X-CSE-ConnectionGUID: PuTQTLqlRiSTyokNYBQrwg==
X-CSE-MsgGUID: 80Lqs5EmRtm5kwHVCrcpeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76506864"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:53:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v8 4/8] PCI/quirks: Abstract LBMS seen check into own function
Date: Wed,  9 Oct 2024 12:52:19 +0300
Message-Id: <20241009095223.7093-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com>
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

As a preparatory step for the change, extract the LBMS seen check into
own function out of pcie_failed_link_retrain().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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


