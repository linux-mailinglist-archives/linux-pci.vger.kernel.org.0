Return-Path: <linux-pci+bounces-42969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C37ECB6915
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 17:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D85E03023A1F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F24828C874;
	Thu, 11 Dec 2025 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="EK5bYr2r"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D782C314A90;
	Thu, 11 Dec 2025 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765471391; cv=none; b=rcoNa5ypEjRtYa06s/mPlpyYDNpXJst6lf4Ki/IL5sw/zsfzNnYGmtEjKSYhPlZ7Q/mykX4POg2GY82LED49ycAI4nMhu2dF71O5sJWkrHq0hRZSA75W9rwGjF8+0hHRSWTMmGvsvu/nxTPG1AFJOxtTHy0IXel6bcERlBSO/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765471391; c=relaxed/simple;
	bh=KUvNQ7iAewHmRCa/SKUqtGLe6cvR2GaCE3uIokzBdq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXAyzlFJK29nrVZ/mZbbj+p9mrVVSYQVfAf52cnwuv10Nyhbrq9RQBm8Lq6ArLDAWFo8Xvmm2Nj/qS0mHcKaLIY+1xfYl9uEeIsntP2gyi/mz2pKchNTx87n6842cc2aiEbcsEzlS0Ihdikq7VtMy4D8fizHK6Wi8XCDitVkFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=EK5bYr2r; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1765471388; x=1797007388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DKSob5bpQnAeRXMsGtljG7uU7j+ZeakRF856afxzdTE=;
  b=EK5bYr2rLnJRXNwGr17s43LfwCSAudTW2JtR8rVo4CpaC93eD6yjhb3p
   RyNFTIl+bN0rjcAP6WnUinE6B7jFLk600+nassc6ieOjTC1VdiqYjoy6m
   pYqX/algwh3zh/veoar1lPG9UF0NweQG9G3bbRndscqPTYE3lyjqCsyLv
   lySOf8GLYVpoYKp5krmpZh0MFLW5SUAk5CKmdKdZh22oU2QU+hfuFK4Wa
   5524Zn2Y2Q4Qww3k8njrjPUSTauS/kYvvIG8Wz2VkZw1nxtj3gVSUFwqP
   lUtrYrlyl0FvbgUeOGaHECRmeB0O1gvFE1/FB2iu7EZcEJlbb3DRq60m6
   A==;
X-CSE-ConnectionGUID: NPXz6eHoTAeecfj7GqVRGA==
X-CSE-MsgGUID: 44YjqNuoSvOhQQhZYdiAMQ==
X-IronPort-AV: E=Sophos;i="6.21,141,1763424000"; 
   d="scan'208";a="8908780"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 16:43:04 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:28588]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.162:2525] with esmtp (Farcaster)
 id ca357886-192b-44c7-bb4e-6b5fecbc811a; Thu, 11 Dec 2025 16:43:03 +0000 (UTC)
X-Farcaster-Flow-ID: ca357886-192b-44c7-bb4e-6b5fecbc811a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 11 Dec 2025 16:43:03 +0000
Received: from dev-dsk-darnshah-1c-a4c7d5e9.eu-west-1.amazon.com (172.19.90.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 11 Dec 2025 16:43:01 +0000
From: Darshit Shah <darnshah@amazon.de>
To: <lukas@wunner.de>
CC: <Jonthan.Cameron@huawei.com>, <bhelgaas@google.com>, <darnir@gnu.org>,
	<darnshah@amazon.de>, <feng.tang@linux.alibaba.com>, <kbusch@kernel.org>,
	<kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nh-open-source@amazon.com>, <olof@lixom.net>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] drivers/pci: Decouple DPC from AER service
Date: Thu, 11 Dec 2025 16:42:53 +0000
Message-ID: <20251211164257.81655-1-darnshah@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aTfTiBy1GoJIFqtJ@wunner.de>
References: <aTfTiBy1GoJIFqtJ@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

According to PCIe r7.0, sec. 6.2.11, "Implementation Note: Determination
of DPC Control", it is recommended that the Operating System link the
enablement of Downstream Port Containment (DPC) to the enablement of
Advanced Error Reporting (AER).

However, AER is advertised only on Root Port (RP) or Root Complex Event
Collector (RCEC) devices. On the other hand, DPC may be advertised on
any PCIe device in the hierarchy. In fact, since the main usecase of DPC
is for the switch upstream of an endpoint device to trigger a signal to
the host-bridge, it is imperative that it be supported on non-RP,
non-RCEC devices.

Previously portdrv has interpreted the spec to mean that the AER service
must be available on the same device in order for DPC to be available.
This is not what the implementation note meant to imply. If the firmware
hands Linux control of AER via _OSC on the host bridge upstream of the
device, then Linux should be allowed to assume control of DPC on the device.

The comment above this check alludes to this, by saying:
  > With dpc-native, allow Linux to use DPC even if it doesn't have
  > permission to use AER.

However, permission to use AER is negotiated at the host bridge, not
per-device. So we should not link DPC to enabling AER at the device.
Instead, DPC should be enabled if the OS has control of AER for the
host bridge that is upstream of the device in question, or if dpc-native
was set on the command line.

Cc: stable@vger.kernel.org
Signed-off-by: Darshit Shah <darnshah@amazon.de>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes from v2:
  * + stable@vger.kernel.org since moving to v6.2+ breaks DPC on our systems
  * Minor stylistic changes to commit message
  * NO functional changes

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
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


