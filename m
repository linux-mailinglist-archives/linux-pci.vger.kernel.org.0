Return-Path: <linux-pci+bounces-10155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC3B92E978
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 15:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA392842CA
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECF415FA92;
	Thu, 11 Jul 2024 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLjjkocx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDB015ECE3
	for <linux-pci@vger.kernel.org>; Thu, 11 Jul 2024 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704350; cv=none; b=IioHkd5XlrTm6Er1tCgpT2JxpGdNiq8iQpOs83Vcsp7X9Y6c0dpln4KMjCb1fXbTcusd6b4cYd2N2GjL14oa4eHxwOWE695AcLOdKqMbq3iPwqXnf9kxXtAtRiyVo70VfCFjH17A6O5ubxUOrsUQao3S0+1pG5O4q1bRk3Ldpuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704350; c=relaxed/simple;
	bh=k5bmhPA0dDj6lZmlZdKcCm/UQoTJ5B2ESn1wu8a6a/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VUOYZOio5DqXzX6Z4cJg0sDaHdxEmUD8lCie52FziUp4BT6BxMPiV22FBStzFCMm7effDm64oQPrPXzJhQDDayVjRutsF5cZAfWhm/UxUCSIB26BLfAomeMuHxHt9Klr9puA5hAwzVL7511tJgPhO859ZRdz9havFuEgu9tlogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLjjkocx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B655C116B1;
	Thu, 11 Jul 2024 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720704349;
	bh=k5bmhPA0dDj6lZmlZdKcCm/UQoTJ5B2ESn1wu8a6a/c=;
	h=From:To:Cc:Subject:Date:From;
	b=lLjjkocx3f+o5YelJRRiposcM0mqy+7gZDX7kCmb3rfnVvpigoB8RszkbphxROCDg
	 PBtWRjTeqtnBw6ZF8pQTszOhleOUi7HXsLFBjxAswSHic8lgQERhGRJb3LSneBqH52
	 bKInMPPUC3lhGIMeQWWL6XTo9jsDIZrETljX2qI5NTsGHtLKTbe2sJKzHMnx2X0il7
	 Sz0MFPiLEFAhUhsxhQlZEa0VbTr6FPV5RvfgnzbGiNa/UcDgn/o5/vbpLBgNcw4oUU
	 ZsAhvpgELMj0cuxSxlMS9PgRocs2y0jgC6z5aHTYBbz703yqi0Vn2OM8lIRc+EViLs
	 uGFsDOmWICViA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v2] PCI: mvebu: Dispose INTx IRQs before to removing INTx domain
Date: Thu, 11 Jul 2024 15:25:44 +0200
Message-ID: <20240711132544.9048-1-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
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
Changes since v1:
- added explanation into commit message about why this is safe to do,
  as suggested by Andy. The explanation originally comes from Pali:
    https://lore.kernel.org/linux-arm-kernel/20220809133911.hqi7eyskcq2sojia@pali/
---
 drivers/pci/controller/pci-mvebu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 29fe09c99e7d..91a02b23aeb1 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1683,8 +1683,15 @@ static void mvebu_pcie_remove(struct platform_device *pdev)
 			irq_set_chained_handler_and_data(irq, NULL, NULL);
 
 		/* Remove IRQ domains. */
-		if (port->intx_irq_domain)
+		if (port->intx_irq_domain) {
+			for (int j = 0; j < PCI_NUM_INTX; j++) {
+				int virq = irq_find_mapping(port->intx_irq_domain, j);
+
+				if (virq > 0)
+					irq_dispose_mapping(virq);
+			}
 			irq_domain_remove(port->intx_irq_domain);
+		}
 
 		/* Free config space for emulated root bridge. */
 		pci_bridge_emul_cleanup(&port->bridge);
-- 
2.44.2


