Return-Path: <linux-pci+bounces-12974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 434B3973737
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 14:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514EA1C243F0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 12:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FB3188CB1;
	Tue, 10 Sep 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTxhbBv6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F9A1E493;
	Tue, 10 Sep 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971256; cv=none; b=l4EYPBHTl53I+c4+LpL9jrDcYQP8EUhvBFKrKNDmz+FHTWkAJEORwaqDORTb3ZAphSUh4/uXcPKam6lbFqkxnn1Z/ax7/lLyjSSk8HzEC0EnfUbl8F6Yzwjy6UCwIaNgkKvKbPTiRk5dqZjES0QBzwnQp8WDnIZdUMNEQ+3PDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971256; c=relaxed/simple;
	bh=gwKzcskD+Xvx79IytQ+gKqrFgMZsQ/6AZGY6f4DtPVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6ncpnCMaFDg0e+JDfkkjRiHrbJFdfbIZS1YZh118yV/6Idvwb/oV+10QKfTmvb/C821U+ORGN7mwbm8gugFHXVV6F5TXcfmyYEsKCO3km75wAEaTxlIjvVr6yj0kcUNSf2pmiHEuooxxI9KgWoVr101Oag1YUMHyfVBqvG485k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTxhbBv6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725971254; x=1757507254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gwKzcskD+Xvx79IytQ+gKqrFgMZsQ/6AZGY6f4DtPVs=;
  b=XTxhbBv6G7CWDV3PJD+Qgl/GwoCaRdYpI+fp3GT9ujIBSaAyTOCyepFZ
   qIfRI+NZXl7ckS4NuEC/Ji7O/AhpDlSGhwfh6XjtNjElZjTW8HjBsTvcu
   1JW5M4nePeZ7EcGCji28lQz/d17RRgaWN3x7WJp1oFhVlCIQWPbjZgqom
   0TkmiKg+ium6KY96N80MnLnwDePu1+fH1LdWij9PbDRrPPKglarIsCwy+
   AvOIdZxYpP0B1GBhA/8ffejAkE6p+CYsowcRjWkdhJdMv1iHMeNS4Jxv0
   TpWrKwlP66XOjwkBRRiUHwcto6w8Do4dAm9JMIuuDQkJjpkP5wnLqLljS
   w==;
X-CSE-ConnectionGUID: eSy8KJy+R7KVVacDHrGF+g==
X-CSE-MsgGUID: 0kGbs5O3TlqAYVQfuSdDSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="27634204"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="27634204"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 05:27:33 -0700
X-CSE-ConnectionGUID: c79Vi7k2TtuoW0BQ13Tslg==
X-CSE-MsgGUID: tTnLFkRQQIOvwgmwbjzu3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="66968067"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.224])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 05:27:26 -0700
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
Subject: [PATCH v7 1/8] PCI: Protect Link Control 2 Register with RMW locking
Date: Tue, 10 Sep 2024 15:26:58 +0300
Message-Id: <20240910122705.4068-2-ilpo.jarvinen@linux.intel.com>
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
index 4cf89a4b4cbc..25362d577824 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1270,6 +1270,7 @@ static inline int pcie_capability_clear_and_set_word(struct pci_dev *dev,
 {
 	switch (pos) {
 	case PCI_EXP_LNKCTL:
+	case PCI_EXP_LNKCTL2:
 	case PCI_EXP_RTCTL:
 		return pcie_capability_clear_and_set_word_locked(dev, pos,
 								 clear, set);
-- 
2.39.2


