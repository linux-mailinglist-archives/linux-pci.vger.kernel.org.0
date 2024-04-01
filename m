Return-Path: <linux-pci+bounces-5467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8C989370D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 04:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA1F1C20A88
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 02:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF62443D;
	Mon,  1 Apr 2024 02:40:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E769A523A;
	Mon,  1 Apr 2024 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711939204; cv=none; b=p/LesmxStxzfQagDTyR6FeUZ1zZpXlUfsdQpjlGvjDg2O+zCDIiUly1Q9m4yfEznmByVTvbVvdJ7pqUa/uc8YmW2+k9wJTX5NfMxATfdHl3pQdh6T+ufjJPciPpgh0Gu011HgBj9QDL1D4UjOR9FRQCF4gHlYFc6Xln3eFoiI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711939204; c=relaxed/simple;
	bh=rDGADCXyQhug1jHaaVuWWWUGQXoCuhG2D6lBeCel1wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L8gF3CKUCRzcveQaYLMQyNobxqYeEzSTRBWs9nJtuVw+/bGWXiND0Zk5TDAHx80xWlKeTAczElbaBJU/fW9REBdyWfd/1IKrY5WbYGLorpZzFcQCVBDjcjDif/x+IunYA52q8+eAyRNP6Ns5C8nmipAK9C2c9YFfgYIfSUujAro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,171,1708354800"; 
   d="scan'208";a="203857166"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Apr 2024 11:39:51 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 415C2410EB80;
	Mon,  1 Apr 2024 11:39:51 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Frank Li <Frank.li@nxp.com>
Subject: [PATCH v3 7/7] misc: pci_endpoint_test: Document a policy about adding pci_device_id
Date: Mon,  1 Apr 2024 11:39:42 +0900
Message-Id: <20240401023942.134704-8-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401023942.134704-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240401023942.134704-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid becoming struct pci_device_id pci_endpoint_test_tbl longer
and longer, document a policy. For example, if PCIe endpoint controller
can configure vendor id and/or product id, you can reuse one of
existing entries to test.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
Cc: Frank Li <Frank.li@nxp.com>
---
 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c38a6083f0a7..3c8a0afad91d 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -980,6 +980,7 @@ static const struct pci_endpoint_test_data j721e_data = {
 	.irq_type = IRQ_TYPE_MSI,
 };
 
+/* Don't need to add a new entry if you can use existing entry to test */
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x),
 	  .driver_data = (kernel_ulong_t)&default_data,
-- 
2.25.1


