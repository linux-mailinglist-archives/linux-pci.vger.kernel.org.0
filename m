Return-Path: <linux-pci+bounces-5853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A218489B539
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 03:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C51D2814B9
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 01:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29E51C0DD6;
	Mon,  8 Apr 2024 01:25:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAC41852;
	Mon,  8 Apr 2024 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712539512; cv=none; b=VjU66fBh9UxcWcpkS3i+GcBMZyqATMGDpgYajSDN8HtsNjBv+1QjQxi5joCLIaPZGZgR6uF9qGLyeaRbdcZS9wGQKjFkXCV/FRdV6H2H03asFpCs67XUS0Q69oABdmQkGN5NY/fkylK4M1ejk61+HHlGklDgqO/aAfLCE/KP3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712539512; c=relaxed/simple;
	bh=rDGADCXyQhug1jHaaVuWWWUGQXoCuhG2D6lBeCel1wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LvBljCklRE7FqaTDKP54AnAJTXR/3w52YFlAe0yaivtOqP0HbowEPboKi4Q6WGLhabYwzApa7qfiIZWUvcZeEh/180h3N0sEtWmZjtCMwjLgexX5lN8++J7L8CejAFL043rq34h0FdSbZQ+Gqn7ziVzk5fUueQm2FfRjbPbiZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,186,1708354800"; 
   d="scan'208";a="204613294"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 08 Apr 2024 10:25:00 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B7ABF402C339;
	Mon,  8 Apr 2024 10:25:00 +0900 (JST)
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
Subject: [PATCH v5 7/7] misc: pci_endpoint_test: Document a policy about adding pci_device_id
Date: Mon,  8 Apr 2024 10:24:58 +0900
Message-Id: <20240408012458.3717977-8-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408012458.3717977-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240408012458.3717977-1-yoshihiro.shimoda.uh@renesas.com>
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


