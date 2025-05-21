Return-Path: <linux-pci+bounces-28230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07192ABFB4F
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 18:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453A09E031F
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 16:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741541F30A2;
	Wed, 21 May 2025 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgLL2NFI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AABC1537C6;
	Wed, 21 May 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845222; cv=none; b=AUQr5AGN3yKT3lNnUlr3x0TY2v6jgSsKnNJHYj7ReGSv9jY/xIIrgkkk9GYd5gMhR9csGN8dJJam8XDpnr9izeQNh9bP0EWrPWdTDq4+th1/eg3w4WA4XQKUS6IT1E2x0jqhwdNfMHODY5TC6p39m5WIKb7P29q4+JgbDK8VRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845222; c=relaxed/simple;
	bh=yYL5QTXg94mpBYScKovOIYefpClIwY3axIYfrJSf6o8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DCOtOJRWkGtYQdzXs3bl2kgjseM6x9mNsrWgPWbv4nq5j9g/7IgMfyelQj0TE762RlGPlzHuMHXTzJiRTr2/wGg9zU3toQdNfYy30J/mOtmcz+s+10j5BIYrTK32/98n1vNxc51WpW7QSJfJ1I1ziilrf1HmbHBjqdBn/j++LK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgLL2NFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440B9C4CEE4;
	Wed, 21 May 2025 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747845221;
	bh=yYL5QTXg94mpBYScKovOIYefpClIwY3axIYfrJSf6o8=;
	h=From:To:Cc:Subject:Date:From;
	b=SgLL2NFIy+hUJkuFsNEjz+YpHCAqL1WHRL2k+0pqIHJfNXGJ9Kpr5CXdnsgBYgPg9
	 TjplK59dhSaplvs2J0PA9VBsNxiIqIPkIjFi78y9RACCOR8D5UFd4ToflTF1gj2MAU
	 /a11FqG35IMrNmIt5YBuk2JEygwnajsRXj//52eBtI0rY1dn+4NXYJ3aOR0ZVFzE3V
	 ZdYM6FnOr8UzUnUVpa8gKeNUMjNWP6gBzNUPpHfipVBCoSL32MS32mu2r5iz6QQwEI
	 prLCQLqARJm+N0FAj/Wr7C4DFJK0yR5/eZOoBDZjMR5wHqygxMZlFJyK3cSC9zrdAd
	 25tiH2LwcyA5w==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pci: altera: remove unused 'node' variable
Date: Wed, 21 May 2025 18:29:48 +0200
Message-Id: <20250521163329.2137973-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This variable is only used when CONFIG_OF is enabled:

drivers/pci/controller/pcie-altera.c: In function 'altera_pcie_init_irq_domain':
drivers/pci/controller/pcie-altera.c:855:29: error: unused variable 'node' [-Werror=unused-variable]
  855 |         struct device_node *node = dev->of_node;

Use dev_fwnode() in place of of_node_to_fwnode() to avoid this.

Fixes: bbc94e6f72f2 ("PCI: Switch to irq_domain_create_linear()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
I checked the other PCI host bridge drivers as well, this is the
only one with that problem.
---
 drivers/pci/controller/pcie-altera.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 0fc77176a52e..3dbb7adc421c 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -852,10 +852,9 @@ static void aglx_isr(struct irq_desc *desc)
 static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	struct device_node *node = dev->of_node;
 
 	/* Setup INTx */
-	pcie->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), PCI_NUM_INTX,
+	pcie->irq_domain = irq_domain_create_linear(dev_fwnode(dev), PCI_NUM_INTX,
 					&intx_domain_ops, pcie);
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-- 
2.39.5


