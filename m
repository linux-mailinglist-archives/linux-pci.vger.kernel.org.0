Return-Path: <linux-pci+bounces-1709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A72828252C3
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 12:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0224B24137
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B424528E2D;
	Fri,  5 Jan 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnE0p1n3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB9E2CCBD;
	Fri,  5 Jan 2024 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704453974; x=1735989974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EB6yc3eYH0bqf6SvAry+9WDusbCWU03uB068cag5tAg=;
  b=JnE0p1n3mFmM/VCJ66oNumYFGY3sJ2gNy7+68loovwj3gZECOyMlWHdS
   G13rxRb8h1kDAZDCsf9HXBf4nAqgUMuCBPAevM6kS/2NW+6QxXM2M4iPY
   FG/F9Vppjcfso6KgINM1fpyh+bpxZ++HIb35W1h2NHkHYpBGq99Zheakv
   WYbOEjQh9IjoV00TdgXVaI0TZInpBsFe6ZCfFs9CBNg4AXUoKYjurre7k
   XadztQDDs8qubrnvUpueF3hh75kyzUmh5TDLsuVzsYafJo62XWIspM7n8
   VPimxLMtzmP3/hJUQMSGvqcYQhjIrp2xOUrsmpG/SGsxZT0MHLMw0ECIA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="10858342"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="10858342"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 03:26:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="773827811"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="773827811"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.38])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 03:26:06 -0800
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
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexdeucher@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 1/8] PCI: Protect Link Control 2 Register with RMW locking
Date: Fri,  5 Jan 2024 13:25:40 +0200
Message-Id: <20240105112547.7301-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105112547.7301-1-ilpo.jarvinen@linux.intel.com>
References: <20240105112547.7301-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe Bandwidth Controller performs RMW accesses the Link Control 2
Register which can occur concurrently to other sources of Link Control
2 Register writes. Therefore, add Link Control 2 Register among the PCI
Express Capability Registers that need RMW locking.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
 Documentation/PCI/pciebus-howto.rst | 14 +++++++++-----
 include/linux/pci.h                 |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/PCI/pciebus-howto.rst b/Documentation/PCI/pciebus-howto.rst
index a0027e8fb0d0..cd7857dd37aa 100644
--- a/Documentation/PCI/pciebus-howto.rst
+++ b/Documentation/PCI/pciebus-howto.rst
@@ -217,8 +217,12 @@ capability structure except the PCI Express capability structure,
 that is shared between many drivers including the service drivers.
 RMW Capability accessors (pcie_capability_clear_and_set_word(),
 pcie_capability_set_word(), and pcie_capability_clear_word()) protect
-a selected set of PCI Express Capability Registers (Link Control
-Register and Root Control Register). Any change to those registers
-should be performed using RMW accessors to avoid problems due to
-concurrent updates. For the up-to-date list of protected registers,
-see pcie_capability_clear_and_set_word().
+a selected set of PCI Express Capability Registers:
+
+* Link Control Register
+* Root Control Register
+* Link Control 2 Register
+
+Any change to those registers should be performed using RMW accessors to
+avoid problems due to concurrent updates. For the up-to-date list of
+protected registers, see pcie_capability_clear_and_set_word().
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60ca768bc867..345a3d2a3fcd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1269,6 +1269,7 @@ static inline int pcie_capability_clear_and_set_word(struct pci_dev *dev,
 {
 	switch (pos) {
 	case PCI_EXP_LNKCTL:
+	case PCI_EXP_LNKCTL2:
 	case PCI_EXP_RTCTL:
 		return pcie_capability_clear_and_set_word_locked(dev, pos,
 								 clear, set);
-- 
2.39.2


