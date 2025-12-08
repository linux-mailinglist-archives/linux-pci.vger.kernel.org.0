Return-Path: <linux-pci+bounces-42753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B4CACFE8
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 12:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A69304FB8B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C2831355B;
	Mon,  8 Dec 2025 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="RpcYFn5V"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE413B8D7E;
	Mon,  8 Dec 2025 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765193156; cv=none; b=ryBXP9h+cWiIs9UN8ibGBdvh8noqZ34W97d5CjUChKlrzhgA69Kccqmm7/UhluiPe7SKv3ksjYurYXrc5vTEOirPzUE+r2gKGsCAvcDTxFDE6YVKL7+DcohFa7pHhppFbAnChcVsD+ZYOxSoGGtTsha8Aa21EKYYQUUyvroDw/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765193156; c=relaxed/simple;
	bh=+7DnTNmigqCIQ/RGe+CbPpDuPrlb0eNlrEzi2fIt4sQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k61oz4R0RDDEkeY4ueurUnz9R+XtFj8Uptp5E3Ne2NeHMXbIumOac4QV5VyNMHb4mDH1aPjFOm9KmoOdgBUoMYoHGBq5PL+FS1ldHC0GpXw0y7LOvOsWySCxOYXM79lLzj6tf0joPrNVxwK+sxcTnj5jijP+hdaR3tMvg+kBA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=RpcYFn5V; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1765193154; x=1796729154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HcNkJX2HSTavVPvjBAoTQOXVZGz+Iq5G0B+epFFhj0s=;
  b=RpcYFn5VSKCYzGdN7mXe2hVfNz70VaVBoKPG0PjWGjytCTuickzhlsMA
   3YpIgyZbacKRUB2lCd3WLfFB71Z27diAxpmFBaLekdaybHKec/wwIhClP
   tMyBtCIpFkaEsNXtfp0gKodg8I5ewg7YxdhSYRi8Aky1/n5VHVfCN8O1A
   VCObYw3z77Vklu0R63V5mohx3o5uQI/bIXL4cO2ATAk3uyMCSRXQc4y1j
   x6Gd7LVvEHZubmsLp1gpRfleKexRvOFr9Ui0yh57+P75UlOUmyhx84VlT
   RKLaLQnOgx84dl4PCpBwQXQvNe902gcVyBbANNNOMj7HtQeh3zZnPqclQ
   g==;
X-CSE-ConnectionGUID: UT3X/0A8RYG2wzcXPZ595g==
X-CSE-MsgGUID: MjtfYFaET/umpyEaQcZMMg==
X-IronPort-AV: E=Sophos;i="6.20,258,1758585600"; 
   d="scan'208";a="8185406"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 11:25:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:27294]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.134:2525] with esmtp (Farcaster)
 id bed23072-1309-4b69-af94-a2a96753a148; Mon, 8 Dec 2025 11:25:51 +0000 (UTC)
X-Farcaster-Flow-ID: bed23072-1309-4b69-af94-a2a96753a148
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 8 Dec 2025 11:25:50 +0000
Received: from dev-dsk-darnshah-1c-a4c7d5e9.eu-west-1.amazon.com (172.19.90.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 8 Dec 2025 11:25:49 +0000
From: Darshit Shah <darnshah@amazon.de>
To: <lukas@wunner.de>
CC: <Jonthan.Cameron@huawei.com>, <bhelgaas@google.com>, <darnir@gnu.org>,
	<darnshah@amazon.de>, <feng.tang@linux.alibaba.com>,
	<kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nh-open-source@amazon.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v2 1/1] drivers/pci: Decouple DPC from AER service
Date: Mon, 8 Dec 2025 11:25:45 +0000
Message-ID: <20251208112545.21315-2-darnshah@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208112545.21315-1-darnshah@amazon.de>
References: <aSnWyePbCKPvjpKq@wunner.de>
 <20251208112545.21315-1-darnshah@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

According to [1] it is recommended that the Operating System link the
enablement of Downstream Port Containment (DPC) to the enablement of
Advanced Error Reporting (AER).

However, AER is advertised only on Root Port (RP) or Root Complex Event
Collector (RCEC) devices. On the other hand, DPC may be advertised on
any PCIe device in the hierarchy. In fact, since the main usecase of DPC
is for the switch upstream of an endpoint device to trigger a signal to
the host-bridge, it is imperative that it be supported on non-RP,
non-RCEC devices.

Previously portdrv has interpreted [1] to mean that the AER service must
be available on the same device in order for DPC to be available. This is
not what the implementation note in [1] meant to imply. If the firmware
hands the OS control of AER via _OSC on the host bridge upstream of the
device, then the OS should be allowed to assume control of DPC on that device.

The comment above this check alludes to this, by saying:
 > With dpc-native, allow Linux to use DPC even if it doesn't have permission
 > to use AER.
However, permission to use AER is negotiated at the host bridge, not
per-device. So we should not link DPC to enabling AER at the device.
Instead, DPC should be enabled if the OS has control of AER for the
host bridge that is upstream of the device in question, or if dpc-native
was set on the command line.

[1]: PCI Express Base Specification Revision 5.0 Version 1.0, Sec. 6.2.10

Signed-off-by: Darshit Shah <darnshah@amazon.de>
---
Changes in patch v2:
  * Don't touch the PCIE_PORT_SERVICE_AER attachment
  * Stop relying on PCIE_PORT_SERVICE_AER for enabling DPC
  * Instead test that OS has control of AER at parent host bridge

 drivers/pci/pcie/portdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 38a41ccf79b9..8db2fa140ae2 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -264,7 +264,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
 	    pci_aer_available() &&
-	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
+	    (host->native_aer || pcie_ports_dpc_native))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	/* Enable bandwidth control if more than one speed is supported. */
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


