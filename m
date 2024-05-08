Return-Path: <linux-pci+bounces-7245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E43A8BFF6C
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C821F2AEFE
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDE486151;
	Wed,  8 May 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AixCk5yb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02684DED;
	Wed,  8 May 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176135; cv=none; b=dPPUF7DDXTJHEwmTxq99kJ83CY/v+kHSIX/yzmhvUTQxW+HpN803eJ8/5monQs7z2grjWBrHzuCK9vs5nrw3etbW/urR2XFZrkDpdDgApDYe/euFVQ6BE3Rlz+n1K13itukT/yRyNJH7c2cr4pu7Zw9Mc5ES+KIuLloLU2ccacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176135; c=relaxed/simple;
	bh=MLkyWnj8n33ZGy6Gno0WbKv6yNMO+1Q2hL0zVj/FGa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AF3m6gVlVJTt3jSK+4otcbygw0VU7HJwzWI8kHbVx83RJYdsRtNhGh0UubauEFGGFuPC4jaT5yk/w3JuTz5ZHS2yCK5oxSRdWpU7lHgVVRC26n5eYxhTus+rmt9zkOZjbtLCVIZFWIzdLj5kZ1RvUiQ5XzaDrwtlSA6w7G/vSSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AixCk5yb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715176134; x=1746712134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MLkyWnj8n33ZGy6Gno0WbKv6yNMO+1Q2hL0zVj/FGa4=;
  b=AixCk5ybu/iHo97uTYXSvgEvdS93udOFt8eVYxax9jXYwuO559252NJn
   jpN7roM77xPJArQNNTaj7jWmXFr6Ui7j9ezZdCfV3whQ39Y79l/fREC8W
   1tV71Jhr/SQWxD1eFI4ZCXP8C/IS9kz1oNUWMGl4xo4z9pxczNU11AKrf
   OnOICiYuP42k8bO7WaQmIsniuwT+MgmEBgpBBjpEIRVDOFuoZqVF/8M4+
   eg326GY8b5g7zVNj3POH0x/yKJNZ+HZDFvLst4+giYkfhnU1HypJ574tL
   Up/dR7vE9bqu22OcR+GTPgQkkDHQGuISlS1DpcbuA/55jkM9YnxTqp2B7
   Q==;
X-CSE-ConnectionGUID: 0EPLYadwSRCZecOroz/iEA==
X-CSE-MsgGUID: XJnhH/3vRbyu1ve1V6RS5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="28512703"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28512703"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:48:54 -0700
X-CSE-ConnectionGUID: iGvG/qzBTPOYPi9dRB9yWg==
X-CSE-MsgGUID: YSi+KxecRQuYsBropfuoeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28983288"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.80])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:48:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
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
Subject: [PATCH v5 4/8] PCI/quirks: Abstract LBMS seen check into own function
Date: Wed,  8 May 2024 16:47:40 +0300
Message-Id: <20240508134744.52134-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508134744.52134-1-ilpo.jarvinen@linux.intel.com>
References: <20240508134744.52134-1-ilpo.jarvinen@linux.intel.com>
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


