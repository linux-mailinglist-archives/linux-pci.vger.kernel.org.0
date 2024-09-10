Return-Path: <linux-pci+bounces-12976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FB897373F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 14:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343681F265D7
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 12:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BED190678;
	Tue, 10 Sep 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndeovSnz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D182A19048A;
	Tue, 10 Sep 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971283; cv=none; b=K2Mw34ugQ+Qqfe1qKBU9DIDbMoxVSoSjfoMnyfHU/C5lISPXXwVKvhuPGv7fGmpU5lZsfDFldWA2ZrmmpkCAwIurn6nrxoZzSkr8gBRd0QY3xXXz5WbxHJPs8NMJpPca/VOd1g/nyiXYdFtj2SS1V0jVrW0ch8DR7J712C7yXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971283; c=relaxed/simple;
	bh=xQnwB9H2JmKgkN1pL8WWx/35BcoHuAHvd3MLRul2VDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+KNQGThnfBeW09+MBwcBZErotK5fuJWXZGdEVaBuk0HDm3sN3Ie5wO5IICpf2OfQSxF7SEZDZMsw20uPWo919z7APEDKXe8tvXmUQ2mBVZXcku6AjmARJbTXHUFkkY2IEd/ACwZ6i5AICl4TcD7I/4eHpn81nlZcJ88W+Y0YNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndeovSnz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725971282; x=1757507282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xQnwB9H2JmKgkN1pL8WWx/35BcoHuAHvd3MLRul2VDI=;
  b=ndeovSnzEpzhbfXxuyJhFLcj4q3rabQ5FJunZ+Qa6NvToOuRehCLDA6f
   9LLGuurUwMZY5yZO8ZHpEPdhvt0JeqTt3g1Qbj0Tt33pEjkS2342tD9jP
   Hk7FpqKJNuAB/F8Y2hJvyIZSKhaG4/9wuZBa0P02hq5mfXxY952edg46s
   L0lvIYMckr1UOAnLa3+IOsR0AT42DyUsXVgn+FIArPyx5ZFDR+KINZ2lC
   lP8HA7EBeKVQk2vFPqxO1F1SQyltnul8A/vuKjhEx9AyTUXNkPi6YbBiJ
   UsumpwOye5KKuEZhUyiUTbnEAhHz6ZzGUT6XtXXbc8CmtLbiW+ikslsiI
   g==;
X-CSE-ConnectionGUID: yQP3aH6vT96mUAwxzkvHXw==
X-CSE-MsgGUID: qAcS4XkWTBuh5kmMwF+aKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28604194"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="28604194"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 05:28:01 -0700
X-CSE-ConnectionGUID: fS9F9fy4QrSR9pXZpXnZrQ==
X-CSE-MsgGUID: I1iAGhKFTWaazCW1I/ZY0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67543063"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.224])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 05:27:53 -0700
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
Subject: [PATCH v7 3/8] PCI: Refactor pcie_update_link_speed()
Date: Tue, 10 Sep 2024 15:27:00 +0300
Message-Id: <20240910122705.4068-4-ilpo.jarvinen@linux.intel.com>
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

pcie_update_link_speed() is passed the Link Status register but not all
callers have that value at hand nor need the value.

Refactor pcie_update_link_speed() to include reading the Link Status
register and create __pcie_update_link_speed() which can be used by the
hotplug code that has the register value at hand beforehand (and needs
the value for other purposes).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |  2 +-
 drivers/pci/pci.h                |  7 ++++++-
 drivers/pci/probe.c              | 12 +++++++-----
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 061f01f60db4..b83ed2727c2f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -319,7 +319,7 @@ int pciehp_check_link_status(struct controller *ctrl)
 		return -1;
 	}
 
-	pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status);
+	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status);
 
 	if (!found) {
 		ctrl_info(ctrl, "Slot(%s): No device found\n",
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7c06e55c5072..d723cf48c67a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -360,7 +360,12 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_report_downtraining(struct pci_dev *dev);
-void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
+
+static inline void __pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
+{
+	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
+}
+void pcie_update_link_speed(struct pci_bus *bus);
 
 /* Single Root I/O Virtualization */
 struct pci_sriov {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 761b0538afe6..1b3747069464 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -742,9 +742,13 @@ const char *pci_speed_string(enum pci_bus_speed speed)
 }
 EXPORT_SYMBOL_GPL(pci_speed_string);
 
-void pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
+void pcie_update_link_speed(struct pci_bus *bus)
 {
-	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
+	struct pci_dev *bridge = bus->self;
+	u16 linksta;
+
+	pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
+	__pcie_update_link_speed(bus, linksta);
 }
 EXPORT_SYMBOL_GPL(pcie_update_link_speed);
 
@@ -827,13 +831,11 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 
 	if (pci_is_pcie(bridge)) {
 		u32 linkcap;
-		u16 linksta;
 
 		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
 		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
 
-		pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
-		pcie_update_link_speed(bus, linksta);
+		pcie_update_link_speed(bus);
 	}
 }
 
-- 
2.39.2


