Return-Path: <linux-pci+bounces-8968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B377990E824
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 12:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42FD8B22B6D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 10:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E31139D07;
	Wed, 19 Jun 2024 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GDnnH+jf"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088185626;
	Wed, 19 Jun 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792139; cv=none; b=R0o5gOGxtc4QygYyKEzMewG0EHYgAJRCe0rrGdRM6n0gbao8pMxNvjek8ORZB8PU9iyOmoOUQoltW8Ehu1aio2SLYzKA5fc8oZhJCPpVuC8bHri34AFgf5oHUJAgIUXvdW/aF/0j0BKG2SsK2xhiImJo7RinHyxtRT5oh5r6I2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792139; c=relaxed/simple;
	bh=Sa5xfEP1QjIlXJn5BNDwRNY81rwveOsBkeO/Op4FKsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z54uZLSt15NgIEImNkMMDFzJkJmbWMqvxuaIYE0+69HM8gjSd5uHzu0gXR1ZVtkEeY1bhFcKUw+9iVpzi7/K5tKHSk6IYnW4KEMMMKg4karZHB49hCpazX/zk4d/iuFYXD4SCE4I8TsLsj6Yp+GCZQ6Ib8Qfd447dgdkPGRSKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GDnnH+jf; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F663E0006;
	Wed, 19 Jun 2024 10:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718792129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcIvJM/PVv8xQhULVlebx488rIln5blmKYSSLR0xIrs=;
	b=GDnnH+jf9b1CYJdycv9jbarLX53OM2TOHFTrLRm5e0lhyG6Axv32nP9xVPV+ikoyOTp5Y9
	qWw6tMrSNWQdCPX4+x9cACZ2IwYSroD85JOHCwPASlr5ASryhhQ8VzXGdno7Njmd8Jaoh0
	lZMKeXTj+VjIFoUEKch7SGjfkhOCB75v9wa4RWEDo2ebrvTc9bsvW7UDRIY459+NXoslj1
	EErIFnVfmrQYErqQtpFoyWgOBKL5AZn3MMiX5QIJPpkfmUJmOPZll8MBMRNprQ0OVjBgrb
	e0KKicNZxu1r/ucXISo7LVXponxyP+u15y0RzWq9LUzLzr0OTao6idreVdDSvA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Wed, 19 Jun 2024 12:15:13 +0200
Subject: [PATCH v7 5/7] PCI: Add T_PERST_CLK_US macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-j7200-pcie-s2r-v7-5-a2f9156da6c3@bootlin.com>
References: <20240102-j7200-pcie-s2r-v7-0-a2f9156da6c3@bootlin.com>
In-Reply-To: <20240102-j7200-pcie-s2r-v7-0-a2f9156da6c3@bootlin.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
 thomas.petazzoni@bootlin.com, u-kumar1@ti.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com

"Power Sequencing and Reset Signal Timings" table (section 2.9.2) in PCI
EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 5.1 indicates PERST#
should be deasserted after minimum of 100us once REFCLK is stable (symbol
T_PERST-CLK).

Add a macro so that PCIe controller drivers can use it.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/pci/pci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd44565c4756..1a11f2fe3efe 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -16,6 +16,9 @@
 /* Power stable to PERST# inactive from PCIe card Electromechanical Spec */
 #define PCIE_T_PVPERL_MS		100
 
+/* REFCLK stable before PERST# inactive from PCIe card Electromechanical Spec */
+#define PCIE_T_PERST_CLK_US		100
+
 /*
  * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
  * Recommends 1ms to 10ms timeout to check L2 ready.

-- 
2.39.2


