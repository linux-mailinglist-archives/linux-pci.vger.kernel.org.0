Return-Path: <linux-pci+bounces-12977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9FD973746
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 14:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC2C1C24BE1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 12:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595E2190666;
	Tue, 10 Sep 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ge7+AS7G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B818F2D5;
	Tue, 10 Sep 2024 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971297; cv=none; b=LOzMA/PsMIbz362Q/6p3JmhfSYtsXgp5dIOOB4T603VoOK7DmIPK/hM+anGYmGRp1riVLpvEpnZZGQHE563wTmYacmcEQZzoB1TFNc4ket9SiHQh4XDdkVb20sqz3u7LBpCp20dET7sx/jT01yE0GWt49fvoOlYrcxENO4dYSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971297; c=relaxed/simple;
	bh=YR7urednVS9iUhKroWQnpFP/vfPtVNNlwGJ3f3KMscw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJx9hnheN3ccJPKqA/J3mLxn/DtNEyDz3YQjBuXo0HxEAOQSvG8Q0XtJ5EbtsHjOQkn/b0Oa3tk0IgHMhjqJlP9jTrb6IHGz4+WcYjURsbGw5dsnRB3h2BuD/hojdhhXwy3iJ8avL99OnjqHj5bWd5VAQSMXtl8bls7C1n938r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ge7+AS7G; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725971296; x=1757507296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YR7urednVS9iUhKroWQnpFP/vfPtVNNlwGJ3f3KMscw=;
  b=ge7+AS7G/Azq6wCOAPc9Fex5P6wIRsh/6lflBvNRHSEnpg0ZXYIYLlOJ
   SPOvWm0EAR1xL0LYfPk0g/H5sAKnL4hLt+/wVuGbWJuO0O7btBNnF2Q34
   43fLCcWfKNDCBs80jobafjDFTLdUu+bdp6+TbFVuEcQMKisx/87f82Tu2
   3JbreJpy9RZzrGjTyP6Uk2/Rlh2V7DPjSWNc1sdC2HCe2KWthhRxn3u7S
   b6qLHLaGdui9rJ4Ne+3C9dIONJ2GnLt7wThlTJ/ctLJuDXkmuEgljduIo
   uDv6qgXqp6/2w7jzlWWTiaP08WT+77/Ld6kqqGHjlXiST4sZ+rWDqC4WO
   A==;
X-CSE-ConnectionGUID: aD3PODn4RtqqTcz6omZT6A==
X-CSE-MsgGUID: pzbe/nVuQBCuTd2aLxR3Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28604252"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="28604252"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 05:28:15 -0700
X-CSE-ConnectionGUID: wdpanONkT4Gojn87RMerAA==
X-CSE-MsgGUID: 0c3XiSqrSE2cihw3XNJqdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67543078"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.224])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 05:28:07 -0700
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
Subject: [PATCH v7 4/8] PCI/quirks: Abstract LBMS seen check into own function
Date: Tue, 10 Sep 2024 15:27:01 +0300
Message-Id: <20240910122705.4068-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910122705.4068-1-ilpo.jarvinen@linux.intel.com>
References: <20240910122705.4068-1-ilpo.jarvinen@linux.intel.com>
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
index 5d57ea27dbc4..6fd9e8401c74 100644
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
2.39.2


