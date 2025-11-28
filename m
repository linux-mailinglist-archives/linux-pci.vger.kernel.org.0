Return-Path: <linux-pci+bounces-42263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9FDC91F8D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 13:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FF19347C00
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEE530FC20;
	Fri, 28 Nov 2025 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="UWgiv5aH"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504730B525;
	Fri, 28 Nov 2025 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764332470; cv=none; b=RwDAvRXjAvZCI4miQ/BnRKN16/xZpTyu234UNqPMsWLsU1wWeT9xgyl5mxDtnOREmL6F7CRf6NQkNWjt26xvbdOkfgifJi7Fz1ixcUVxR1TJj90Au0ycWE9TUobLw8lq2WLgiakZA3Nh0XNw224t6NlL0WHSsch1vCrcZstobC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764332470; c=relaxed/simple;
	bh=voQEIax+lJ95q2+3kupqFLZmWHaVnXxQz9a8bJUv7qM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O9i0fVgx6vrKm/Ef3Jje+5GHWNnTZIDcGNlJwdUSu1pbNMW6xBBHOA81AyJxFtzD8RCb6lSAb0jP4uHinoGtTsVrcmt17y+DahMqk6HW3R7W5tx+c0cVK+dwaUpPjnl1I9VRSgPJBGGP813fkX/wgRsNXn6Mq48hAGRbGDesfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=UWgiv5aH; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1764332468; x=1795868468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FBpqoBSIb9xh0FsMqYppfMt2QnqnGC8VmB6HDv9aVQs=;
  b=UWgiv5aHkWWY/m5prKTn9BevVA02Ow1KOlAkURuq2udodc42SMHtUuHG
   bbxdkmt8UgPVwQMU65S6qH19LczDk32qu8Y+iKEvcOyyTrc7sYbImPRKo
   MEUYEXGO9eEYyy7XE1GR1vM1ZIYXfbx4doZ2A5UHNYg+O59MCwheoOjbw
   +oKSI6FemlccnlKEm/UU3JR7VT4G+orXW6fsE9QKcrURW4R8tP5I2JZea
   l1Mhugjx+9CO72zGiDvpRIQzatKOU35KTDk2c6EE2Jb7Oj7mm8bM0AfbG
   CahOMGzwjADlocwbVMpU/n2k35bHenBxcM3LfuN1tn5s84Z2JQyOB4aB7
   g==;
X-CSE-ConnectionGUID: Kfaa/uWHSfSZs/fUbErbkQ==
X-CSE-MsgGUID: +MmWbW5ORsehImpjXwVQOA==
X-IronPort-AV: E=Sophos;i="6.20,232,1758585600"; 
   d="scan'208";a="7836965"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 12:21:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:22047]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.165:2525] with esmtp (Farcaster)
 id a2f1fe75-8bf3-439c-8edd-7db3e792f850; Fri, 28 Nov 2025 12:21:05 +0000 (UTC)
X-Farcaster-Flow-ID: a2f1fe75-8bf3-439c-8edd-7db3e792f850
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 28 Nov 2025 12:20:58 +0000
Received: from dev-dsk-darnshah-1c-a4c7d5e9.eu-west-1.amazon.com (172.19.90.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 28 Nov 2025 12:20:56 +0000
From: Darshit Shah <darnshah@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Jonathan
 Cameron" <Jonthan.Cameron@huawei.com>, Darshit Shah <darnshah@amazon.de>,
	<darnir@gnu.org>, Feng Tang <feng.tang@linux.alibaba.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH] drivers/pci: Allow attaching AER to non-RP devices that support MSI
Date: Fri, 28 Nov 2025 12:20:53 +0000
Message-ID: <20251128122053.35909-1-darnshah@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Previously portdrv tried to prevent non-Root Port (RP) and non-Root
Complex Event Collector (RCEC) devices from enabling AER capability.
This was done because some switches enable AER but do not support MSI.
Hence, trying to initialize the AER IRQ for such devices would fail and
Linux would fail to claim the switch port entirely.

However, it is possible to have switches upstream of an endpoint that
support MSI and AER. Without AER capability being enabled on such
a switch, portdrv will refuse to enable the DPC capability as well,
preventing a PCIe error on an endpoint from being handled by the switch.

Allow enabling the AER service on non-RP, non-RCEC devices if they still
support both AER and MSI. This allows switches upstream of an endpoint
to generate and handle DPC events.
Fixes: d8d2b65a940b ("PCI/portdrv: Allow AER service only for Root Ports & RCECs")
Signed-off-by: Darshit Shah <darnshah@amazon.de>
---
 drivers/pci/pcie/portdrv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index d1b68c18444f..41326bbcd295 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -237,8 +237,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 #ifdef CONFIG_PCIEAER
-	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
+	if ((dev->msi_cap || pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
 	    dev->aer_cap && pci_aer_available() &&
 	    (pcie_ports_native || host->native_aer))
 		services |= PCIE_PORT_SERVICE_AER;
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


