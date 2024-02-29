Return-Path: <linux-pci+bounces-4250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3D286C8D2
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 13:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CCA1F239A6
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 12:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058B57D073;
	Thu, 29 Feb 2024 12:07:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DA17CF05;
	Thu, 29 Feb 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208456; cv=none; b=ltId1aaJEz+V6Nm3kMfb8rkVE5f0mA9aF9qpJnhyVN3u1FWpoa+vdFY6YSkcpISWIgkAHBtbu7nnpH6bBmLRSPlIv2udSXiWLKQrQjCaX0HptmD18GVr6u3pfY5hEY99ceVv8YJdaYLlRdHag6+aRXRvWPUYdTViiDvPh2olxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208456; c=relaxed/simple;
	bh=nEj89xyZoFBvp66Y8Lw8tPcJShRZGoiU+lWaoLYqHpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ebNda7prKlX5YsMfhG2zeHxa+++iVjh3sadb571Q5SxBgkehuAynrEgkkqzXdF9liVecdGHb6ARqnghbmyUoSIO9af0v3wDybXIyiH3PcBE8Z3LcFs1qVDI2nNJnLzwNUUkegBUN/YXRpJF3I3RNdPrOdFII1+3p2ayVLN+Dko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.06,194,1705330800"; 
   d="scan'208";a="199768939"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Feb 2024 21:07:25 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E589A400857D;
	Thu, 29 Feb 2024 21:07:24 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 6/6] misc: pci_endpoint_test: Add Device ID for R-Car V4H PCIe controller
Date: Thu, 29 Feb 2024 21:07:19 +0900
Message-Id: <20240229120719.2553638-7-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240229120719.2553638-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240229120719.2553638-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Renesas R8A779G0 in pci_device_id table so that pci-epf-test
can be used for testing PCIe EP on R-Car V4H.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/misc/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c38a6083f0a7..2fa3c6473c7d 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -83,6 +83,7 @@
 #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
 #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
 #define PCI_DEVICE_ID_RENESAS_R8A779F0		0x0031
+#define PCI_DEVICE_ID_RENESAS_R8A779G0		0x0030
 
 static DEFINE_IDA(pci_endpoint_test_ida);
 
@@ -1005,6 +1006,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779F0),
 	  .driver_data = (kernel_ulong_t)&default_data,
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A779G0),
+	  .driver_data = (kernel_ulong_t)&default_data,
+	},
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
 	  .driver_data = (kernel_ulong_t)&j721e_data,
 	},
-- 
2.25.1


