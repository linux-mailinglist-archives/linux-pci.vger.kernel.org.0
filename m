Return-Path: <linux-pci+bounces-5995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F9889E737
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 02:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B156D280576
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 00:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8CA1C2E;
	Wed, 10 Apr 2024 00:48:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A2A524C;
	Wed, 10 Apr 2024 00:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712710130; cv=none; b=fumRi6Fynef8eqR3Z1uirifhm2/R8A4Vqazfw3sE8MCg67YpLLER+KmDK0x4xhLuBv2bXELypJJ3FWGZYm3Nn9dD02sEJS++T6QLQuOM0xm5uNchygHLHlEpUdUszaTWtleyFtWLWtTnwE+ZLD1zd6Ek7zZRAgOOTUyqEWzMDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712710130; c=relaxed/simple;
	bh=rDGADCXyQhug1jHaaVuWWWUGQXoCuhG2D6lBeCel1wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OHoHOzjFun2BsdfUUOiHhDxsDjd30DWQ4bXXZ7WeIKBWZ8+IMNxvK8ZeQNEnwJ+vfWHymgTD124v1vZNcodbluKV4GKrwGePkoO+2tmSbDAl1k49aACGU7KG94BAPjgFSb+NQOUnyLCub4YH2aTW21VC6/5Xa6viRcZ9MdvH6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,190,1708354800"; 
   d="scan'208";a="204871189"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Apr 2024 09:48:37 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 29DBA400F4ED;
	Wed, 10 Apr 2024 09:48:37 +0900 (JST)
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
Subject: [PATCH v6 7/7] misc: pci_endpoint_test: Document a policy about adding pci_device_id
Date: Wed, 10 Apr 2024 09:48:32 +0900
Message-Id: <20240410004832.3726922-8-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
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


