Return-Path: <linux-pci+bounces-16906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9A09CF3D0
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 19:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D3BAB27823
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5861D515A;
	Fri, 15 Nov 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/DqiZsy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C21CEE9F;
	Fri, 15 Nov 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689849; cv=none; b=jN0i1Uf25GMTOpkvwUPhji9WtO/OB/RPT1a9Knf08tI4vfSkzgl+ozqWqbBSFcNlkIlkDen4CQM6OqmxG63VMmJ7j3XGh0sG5uCR/SJM838QPFi9YANaPCYNUwf68R1D3e+KURwOtv8JDVht2GMpMNAlLSyZs+d+ilEd6RvmFvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689849; c=relaxed/simple;
	bh=P9vPaqkvdnj3RZZRoSi57ArSc52yZfn5QJ1q2s/oo0o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=stfRBATAm7UFyCECANwxBwphtcPUOK7CBc7rrfug3PUxrHVyTrZISpiW7ge/F9252y3VW1oU1Dh9vsHUyQYtQXvtwT6sSkKtmHEUooYL2avNoHZEpy3IKrTSObBm82g4qlXgGriLA/zPQ2jlCPZDVcCOliLAF+cLucmHeCGbNcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/DqiZsy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731689848; x=1763225848;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P9vPaqkvdnj3RZZRoSi57ArSc52yZfn5QJ1q2s/oo0o=;
  b=f/DqiZsyKEsnTGTBqf4BGN1iTHcQsqMmyQMBoDi7/HEuCyOB0D7AnuKV
   iu8QuxowgugXXa10Q8uZAHaRu5nBL4MeWxuhSRIqFyqmZWhWiCmNe0/NY
   JZFITBUoZlgAbzYBa+jftAFnGFuouEQvO1oRM8XaKG9Va2RRk+NcQQ/he
   lva+crIu04+P64tuX7B146JQVAE9+dhQ/wOzpaD2zI9+CXYmPSBwBZtjX
   cd3kZkzj4WWfKVdk/EE4Y+WAWuDFWmYtJoZ2UWIWYW42M3p5yHfdXx2Q+
   uXEzwnEGZwfJuPglVCLvetliAygjUUrF9oOnzNVbFzjDrv6v9CiqvZyjJ
   w==;
X-CSE-ConnectionGUID: XgGw5G78S0WmVoNiXO+2sA==
X-CSE-MsgGUID: 4V7ojmreTISQURKM3iI3gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="31773936"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="31773936"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 08:57:28 -0800
X-CSE-ConnectionGUID: MNYqYWCgQrWW3QRvTO7RHw==
X-CSE-MsgGUID: SvSO5lY9RdWbZeYtvZE5rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="88615069"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 08:57:24 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Stefan Wahren <wahrenst@gmx.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] PCI/bwctrl: Remove IRQF_ONESHOT and handle hardirqs instead
Date: Fri, 15 Nov 2024 18:57:17 +0200
Message-Id: <20241115165717.15233-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bwctrl cannot use IRQF_ONESHOT because it shares interrupt with other
service drivers that are not using IRQF_ONESHOT nor compatible with it.

Remove IRQF_ONESHOT from bwctrl and convert the irq thread to hardirq
handler. Rename the handler to pcie_bwnotif_irq() to indicate its new
purpose.

The IRQ handler is simple enough to not require not require other
changes.

Fixes: 058a4cb11620 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
Reported-by: Stefan Wahren <wahrenst@gmx.net>
Link: https://lore.kernel.org/linux-pci/dcd660fd-a265-4f47-8696-776a85e097a0@gmx.net/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/bwctrl.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index ff5d12e01f9c..a6c65bbe3735 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -230,7 +230,7 @@ static void pcie_bwnotif_disable(struct pci_dev *port)
 				   PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
 }
 
-static irqreturn_t pcie_bwnotif_irq_thread(int irq, void *context)
+static irqreturn_t pcie_bwnotif_irq(int irq, void *context)
 {
 	struct pcie_device *srv = context;
 	struct pcie_bwctrl_data *data = srv->port->link_bwctrl;
@@ -302,10 +302,8 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 	if (ret)
 		return ret;
 
-	ret = devm_request_threaded_irq(&srv->device, srv->irq, NULL,
-					pcie_bwnotif_irq_thread,
-					IRQF_SHARED | IRQF_ONESHOT,
-					"PCIe bwctrl", srv);
+	ret = devm_request_irq(&srv->device, srv->irq, pcie_bwnotif_irq,
+			       IRQF_SHARED, "PCIe bwctrl", srv);
 	if (ret)
 		return ret;
 
-- 
2.39.5


