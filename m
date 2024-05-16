Return-Path: <linux-pci+bounces-7558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3097F8C73D9
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 11:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC751F24223
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53748143755;
	Thu, 16 May 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoOK8GXm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C914374A;
	Thu, 16 May 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852018; cv=none; b=cue7SIk3bAWDLjo6EtliHBasZ3U7Ku6cqDWXu5UYzz2Xl7HIrG7LHqmCqBFu5LaCjSPpK57KyRxiP/bkew1kgwgRcHwi9qPaCNv6TORqg4GtgszSbUMVw/bQbH19yecnvF5I2Cb3Z4idtG2rB1tsReu89bAUQd3l9+Nz5OiPfGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852018; c=relaxed/simple;
	bh=MLkyWnj8n33ZGy6Gno0WbKv6yNMO+1Q2hL0zVj/FGa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lv5+Gs+FrolR9EgbETOwNI07RTsQ8AILLf6sTijANIg1a7dZ7Z6aCbCk6IerEjhmygJ2FCXsDqUwWLL4aQkI7pAxb71V4yGbaKE/5j75TUQwakE9MM92PHKJThNiX6dwbW345Z+vwTUNXP53iG4pTPIKp3aTX5u3I9q8EavzAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoOK8GXm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715852017; x=1747388017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MLkyWnj8n33ZGy6Gno0WbKv6yNMO+1Q2hL0zVj/FGa4=;
  b=MoOK8GXmkRpoixL8PewwbZVka5yWtWsiFNpPW4BTUDyIejglvB4Fk/L2
   XpttZDtKpIa3IfEqCXDOjNsBQB1CbGpv6e2Ei9R6A8pQYb2Hbxi8tqduc
   +F+LhZP+KoDgWpK43kQP41WoO/3Kre9AwTREfJ7yIs178yFyTl5w5/7/J
   jvgVai1eK5kBuOEAPtaONNuxjM6/Rb+oJO+LZqHsQLGTCvkdo0Kh7tTt7
   9L+kNPvr/tMVPXoSsfoVsdZG9gNVeM+z6hFbiat5MSYrfT+RZdvxxunis
   iQ7iYH+/j8lzyDanlUofN+8wNoVt1fL9+Vw7clKS34dBXlBGi6jQZbr86
   A==;
X-CSE-ConnectionGUID: rHjAwVbOQzW/rO4h2lIE0Q==
X-CSE-MsgGUID: vdqdVNGDSNKaIGHNAZzNpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22553306"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="22553306"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 02:33:36 -0700
X-CSE-ConnectionGUID: SWIkkdAuR56giQI2tId+FQ==
X-CSE-MsgGUID: aRoLAjYQRuqF9qjBrngFuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31197323"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 02:33:31 -0700
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
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 4/8] PCI/quirks: Abstract LBMS seen check into own function
Date: Thu, 16 May 2024 12:32:18 +0300
Message-Id: <20240516093222.1684-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240516093222.1684-1-ilpo.jarvinen@linux.intel.com>
References: <20240516093222.1684-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The speed quirk in pcie_failed_link_retrain() uses the presence of LBMS
bit as one of the triggering conditions effectively monopolizing the
use of that bit. An upcoming change will introduce a PCIe bandwidth
controller which sets up an interrupt to track LBMS. As LBMS will be
cleared by the interrupt handler, the speed quirk will no longer be
able to observe LBMS directly.

As a preparatory step for the change, extract the LBMS seen check into
own function out of pcie_failed_link_retrain().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/quirks.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2ae06c7b1917..9be942623573 100644
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
@@ -92,8 +97,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
-	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
-	    PCI_EXP_LNKSTA_LBMS) {
+	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
 		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
-- 
2.39.2


