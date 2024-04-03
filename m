Return-Path: <linux-pci+bounces-5586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5EC896422
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 07:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4A91F227FA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 05:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8BB52F97;
	Wed,  3 Apr 2024 05:33:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0465C4DA08;
	Wed,  3 Apr 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122397; cv=none; b=pWBHuzWVXkyMWbu90VoUbj9HBYxZmini7yj1abNrg3t42TFieHLvY7x7UAzzxNXCg9Bz6F9HqmYuCg7l7W/yVlNDsZBz1G+iqoW2qE/uDvU6JBigbdvIQCcCaU4P/6RMHnzZPGI9KZO7mmXpHPoDu42Odi2XqvhlS7id8emMbsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122397; c=relaxed/simple;
	bh=rDGADCXyQhug1jHaaVuWWWUGQXoCuhG2D6lBeCel1wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTbX2MFpHm0aw438ncLKIP/rto97Yy1MIKhshZuQ8sQEJlmal3DuHk9c/n0E5YOnxQJncrH0M7y2aZLmFoefAB38zwljpYWG/CJL1xHq+xBIg0wUZIH5wv1jlNH0RfXZIHe3ira9R5kdEpkSyNaA6RU7E3bGYY1mzKfV9jxZBwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,176,1708354800"; 
   d="scan'208";a="200195946"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Apr 2024 14:33:09 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 76740400F302;
	Wed,  3 Apr 2024 14:33:09 +0900 (JST)
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
Subject: [PATCH v4 7/7] misc: pci_endpoint_test: Document a policy about adding pci_device_id
Date: Wed,  3 Apr 2024 14:33:04 +0900
Message-Id: <20240403053304.3695096-8-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403053304.3695096-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240403053304.3695096-1-yoshihiro.shimoda.uh@renesas.com>
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


