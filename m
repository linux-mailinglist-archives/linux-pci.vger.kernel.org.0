Return-Path: <linux-pci+bounces-10255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3360193136A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 13:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3CC7B21AC3
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 11:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6086618A93B;
	Mon, 15 Jul 2024 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhS6XZKX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3B143878
	for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2024 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044146; cv=none; b=DanbB/J0oj5wIPebrNP7Y8sTk+aWeRlXjlWTe3NibVXFl/NicH3sb2xlmR+fSW6s1v83XRfzKFperraZudH47nHcO+yujCh9Bje8SqL9xSrI2dNOG5HvG1LIWpZN5zVAHrGrKPuxFFSHlN3fID1GWArJkP0CvcNZfRmGCFqT/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044146; c=relaxed/simple;
	bh=GBWvRjJ6Uyft1k+kSz5hldpNuIiPrjwuJYXhdOBdovA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrHFv41I2pFm2B/sWLzR+kvhsLU1GNcXgnH2ovzYRHr7Hv0mTfT/S3azOWvxVredrPaFzABXlLUBCSjKQ0U2OWZmOgHsC0mhupPJtxT6L1r2QcoUJT82G+rUp4mkBur1hVHv2Qy7kx94Y5XyDS2AGW78mKsd4+qQS3a8y7DT9fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhS6XZKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0D2C4AF10;
	Mon, 15 Jul 2024 11:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721044145;
	bh=GBWvRjJ6Uyft1k+kSz5hldpNuIiPrjwuJYXhdOBdovA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EhS6XZKXwXzsjtqjy/rJaeb44sU681IzCcpp0DwpeVIAEGtX2j1axs8+3kGfSqN8C
	 GEVA7dcOlqc/DzC8FL9g/VrntK6pP6S+6IjgZypPlgoRke6TOJQnFxfh6zLLlFpr0f
	 hsnoUgXfT0mVw6e7biUQxB4ZJtxsii0LX0it9W9txkZtsUxHyXN4LryI35wcW30uv8
	 XxvWSgds8nxXfzwBgb/fPzh9Zjlm+AIaMhJAMPGEysPQ8A5HgMcxjBX0IdO4/T4HOY
	 0Q0lR2hCea/E7YVgCrm2eryS84RlnsUsxg9Fx/wLnlxHJu5hLdmh4lWJAZR3ly5hPs
	 YvfAVtVJtRBOg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v3 2/2] PCI: mvebu: Dispose INTx IRQs before to removing INTx domain
Date: Mon, 15 Jul 2024 13:48:54 +0200
Message-ID: <20240715114854.4792-3-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240715114854.4792-1-kabel@kernel.org>
References: <20240715114854.4792-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pali Rohár <pali@kernel.org>

The documentation for the irq_domain_remove() function says that all
mappings within the IRQ domain must be disposed before the domain is
removed.

Use the new helper function pci_remove_irq_domain() that also disposes
all IRQ mappings of a IRQ domain before removing sait domain.

Currently, the INTx IRQs are not disposed in pci-mvebu driver .remove()
method, which causes the kernel to crash when unloading the driver and
then reading /sys/kernel/debug/irq/irqs/<num> or /proc/interrupts.

Unmapping of the IRQs at this point of the .remove() method is safe,
since the PCIe bus is already unregistered, and all its devices are
unbound from their drivers and removed. If there was indeed any
remaining use of PCIe resources, then it would mean that PCIe hotplug
code is broken, and we have bigger problems.

Fixes: ec075262648f ("PCI: mvebu: Implement support for legacy INTx interrupts")
Reported-by: Hajo Noerenberg <hajo-linux-bugzilla@noerenberg.de>
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
[ Marek: refactored a little, added more explanation to commit message ]
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pci-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 29fe09c99e7d..590f121bd91a 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1684,7 +1684,7 @@ static void mvebu_pcie_remove(struct platform_device *pdev)
 
 		/* Remove IRQ domains. */
 		if (port->intx_irq_domain)
-			irq_domain_remove(port->intx_irq_domain);
+			pci_remove_irq_domain(port->intx_irq_domain);
 
 		/* Free config space for emulated root bridge. */
 		pci_bridge_emul_cleanup(&port->bridge);
-- 
2.44.2


