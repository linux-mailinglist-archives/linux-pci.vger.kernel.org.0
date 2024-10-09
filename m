Return-Path: <linux-pci+bounces-14056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8265D9965FA
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 11:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F711C23680
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 09:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4452618DF93;
	Wed,  9 Oct 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/pdB0Hj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9D18B472;
	Wed,  9 Oct 2024 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467572; cv=none; b=ibpyRAH6Ra07rjjjaEfs6Poh3JEPPlhdd646cGFDE7uiykW9o3r1WAHdN8YFlEQP/YZL3RP0o10tS9/aXR4l06s7Qu7N5eeW5aWO1Muu5h/BrutIhGGB+aUrWanQtHIyzpFnLehCuZRGujEeydGsXfdwetS1RZKDtu0ARDyRl5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467572; c=relaxed/simple;
	bh=UvsMNNvyxNuhw6DdYGAMplJ2CSOlE+EZ+cj/xKJw6Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDJq3aq95OyAKwpmcJ1zGGhyYKjWqmcp+GErQIt1B9EFq5xVNRtUTD6kixfMIeHeVp7o+gmKPcG1Qm/wNhhx42KyX6wF6/GVNLxrB9KkF9u0Ls+monBVcnDsnUaobDfdRRwT0AV/E2fSP7ImjEr30hIXN7JY5wOZlp121R7A0zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/pdB0Hj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728467571; x=1760003571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UvsMNNvyxNuhw6DdYGAMplJ2CSOlE+EZ+cj/xKJw6Og=;
  b=m/pdB0HjsEeHaiLT6tzrKDllDlbMji1zV6O/cEY7s+zCkOYV31TLf3ok
   LHqvesCNnuRmmmGbjyTxs2OBzKrRny1PcOtM7QorGGmr4+YyQlxR69ZXC
   6CA5qqoB60XAmkJCbI0qIBX06AaphY72Wl29pgn6Os4qfjFSOZsHyVBm1
   y+WkQvzRRd+QjNtxA4lxhvtbjhqGOFdYFCHl7y44d3MaF3fb5Rbe+kSoX
   +vdRtElFXp56u9s5dbq7GLqSmqK7R7nVEQHqNR7isi+STm2ZNvokjcZYV
   OPBiR3ulXiNYMOs3qmdcEhZqVzZYpb4wA7aEE2X6sDzrY05LmImHqqSMa
   g==;
X-CSE-ConnectionGUID: tnylRM5ZRuKYfwhyrIT1Bw==
X-CSE-MsgGUID: 1o4IhN3lTSeU69mNuFMl7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38322420"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="38322420"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:52:50 -0700
X-CSE-ConnectionGUID: KcOr7tl1SHGxmzzLqlK9Rw==
X-CSE-MsgGUID: Q/VcikIOThqDPpzVOXDTUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76506725"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:52:43 -0700
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
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v8 1/8] PCI: Protect Link Control 2 Register with RMW locking
Date: Wed,  9 Oct 2024 12:52:16 +0300
Message-Id: <20241009095223.7093-2-ilpo.jarvinen@linux.intel.com>
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
index f344452651e1..375d9ce171f6 100644
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
index 573b4c4c2be6..be5ed534c39c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1274,6 +1274,7 @@ static inline int pcie_capability_clear_and_set_word(struct pci_dev *dev,
 {
 	switch (pos) {
 	case PCI_EXP_LNKCTL:
+	case PCI_EXP_LNKCTL2:
 	case PCI_EXP_RTCTL:
 		return pcie_capability_clear_and_set_word_locked(dev, pos,
 								 clear, set);
-- 
2.39.5


