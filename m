Return-Path: <linux-pci+bounces-37527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9D7BB64E1
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 11:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58B044EAB63
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 09:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207BF2820A4;
	Fri,  3 Oct 2025 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="XzFaLGYc"
X-Original-To: linux-pci@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF10280025;
	Fri,  3 Oct 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482318; cv=none; b=J03YeRt6Wbauwj3t9QOTBx/NrpBII8UudI2hX/dd4q7TB5spLLRWcnojYWP+tUbxVtlZE9LykMsx1BjUH4jxHN7shYtg4UFfrMuXRqxcmcBh8895GFUpV0oPEm49i1fTpSfE16WjmcN0YDsAqO+JoXTXHsbtaVNkfRJaZPkmGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482318; c=relaxed/simple;
	bh=7fzfstjpymKacJqV+W3sVXrBT6YXSsV27syOG1K1/r8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DToRRT+u/9/cRwcyv89xT3J7Gs1GXn9vktnPzfkQFp/HpmGUMlP5ppKBpSXDtFYtynifO0xY28+8HKLHjDrDIm35YuiyBXVJzsO5Ec7/t9/waHUf/sv2PPv1c0LBmgcPtGn0wtwEyG3K/8yEK2pj+B5oG0xrCI28c8+PpNibUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=XzFaLGYc; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759482316; x=1791018316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZH4M3TJDFEiGVNF57d3NtXFvxz/3W42480/86LBMCc=;
  b=XzFaLGYc5jkK4rpbAgCvE3yJtNlZdAfYSDr2ePrvmiyKYOfRB9TthG+D
   5PszdhDRzl0GZZPTSPH655dnknu8f7naPGSAB1/GB7io76F/52rOoS95Z
   bUFh6KAKXYZDc5RsHGfPmGi30NsyZ2vsfw6l8hZPD+t62CSeHBxGSf4lS
   80pianl2VSCCcsihKpOCyLPHrzIZ+Yde8nEl8P/93tMVvaAcu7kwCgdu5
   KR5cf6/8X/6tOZfpdD8WxtmLnfNiq6L+koP88DwHNx91fbClaU2DsCT99
   DtIggxpDtRdf9RICPoz1pIavQchRQP12Sy4y4cL61iP9U8KtqUhr0pPT3
   A==;
X-CSE-ConnectionGUID: lpDY9ksMQaqmZ/7Tbc6i+Q==
X-CSE-MsgGUID: oSS405nVTdCIFvuP3NXK1A==
X-IronPort-AV: E=Sophos;i="6.18,312,1751241600"; 
   d="scan'208";a="4093513"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 09:05:14 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:37411]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.233:2525] with esmtp (Farcaster)
 id 106f3034-d241-4716-b882-d45ef7434a48; Fri, 3 Oct 2025 09:05:14 +0000 (UTC)
X-Farcaster-Flow-ID: 106f3034-d241-4716-b882-d45ef7434a48
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 3 Oct 2025 09:05:12 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Fri, 3 Oct 2025
 09:05:10 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Vipin
 Sharma" <vipinsh@google.com>, Chris Li <chrisl@kernel.org>, Jason Miu
	<jasonmiu@google.com>, Pratyush Yadav <pratyush@kernel.org>, "Stanislav
 Spassov" <stanspas@amazon.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [RFC PATCH 09/13] vfio: pci: Fill only spec-defined configuration space regions
Date: Fri, 3 Oct 2025 09:00:45 +0000
Message-ID: <c1c437a9a2a146b302e1904d7af113e6ef4b0ac6.1759312886.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ammend VFIO PCI configuration space initialization by filling only
the regions defined by the PCI specification, avoiding unnecessary
reads from undefined or reserved areas.

The current implementation reads the entire configuration space during
initialization, including reserved regions that may not be implemented
by the device or may have side effects when accessed. This change
modifies vfio_fill_vconfig_bytes() skips reserved regions in the
standard configuration space header.

This benefits the PCSC hit rate, as 4byte access to a region where only
2 bytes are cacheable and 2 are undefined, therefore uncached, will lead
to a HW access instead.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
 drivers/vfio/pci/vfio_pci_config.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 8f02f236b5b4..4fc7156a77d1 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1485,7 +1485,18 @@ static int vfio_fill_vconfig_bytes(struct vfio_pci_core_device *vdev,
 	while (size) {
 		int filled;
 
-		if (size >= 4 && !(offset % 4)) {
+		if (offset == PCI_CAPABILITY_LIST) {
+			u8 *byte = &vdev->vconfig[offset];
+
+			ret = pci_read_config_byte(pdev, offset, byte);
+			if (ret)
+				return ret;
+			/* Skip the reserved area */
+			filled = 4;
+		} else if (offset == 0x38) {
+			/* Skip the reserved area */
+			filled = 4;
+		} else if (size >= 4 && !(offset % 4)) {
 			__le32 *dwordp = (__le32 *)&vdev->vconfig[offset];
 			u32 dword;
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


