Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A905432C28F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 01:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbhCCUyu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Mar 2021 15:54:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243035AbhCCOhX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Mar 2021 09:37:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F6D164E90;
        Wed,  3 Mar 2021 14:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614781343;
        bh=NlFuc7oHbBkdu0D8TrF+yX/W12F+rFKaRRXsIdZihKY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZTnsicA9Lbr0SrBuoMOgVmAzMSMD5hmn+bAmMYuoEBo7+LH3jquEorakEdix7QI6X
         O6x+8MBGp40K2eI7bQmuj0SC0ZnzDSNXWX9TB/2SC1vggSVkO95PwKS+KDxat9Y7MY
         azfKUhkU88W2/r/hLDkYbJP/im8BQB7W8VQVIWiqJS6fUPZUmNpMMaS875xGfLeupf
         wWtEm4WTgeefeCS1JFNYKil044l1OIE3QAlKafybk18H18xO6XOLNUumCNM6oZrTkx
         8nmoomNYFE8agqrUrc9UfGYF5ROsFTMgwtW1jRh51AvoryZjePhubvxM9SZwFa3F8z
         GO6IuvXHWyMIQ==
Received: by pali.im (Postfix)
        id 21CF4B91; Wed,  3 Mar 2021 15:22:21 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Sandor Bodo-Merle <sbodomerle@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: iproc: Fix return value of iproc_msi_irq_domain_alloc()
Date:   Wed,  3 Mar 2021 15:22:02 +0100
Message-Id: <20210303142202.25780-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IRQ domain alloc function should return zero on success. Non-zero value
indicates failure.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
---
 drivers/pci/controller/pcie-iproc-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index 908475d27e0e..eede4e8f3f75 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -271,7 +271,7 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
 				    NULL, NULL);
 	}
 
-	return hwirq;
+	return 0;
 }
 
 static void iproc_msi_irq_domain_free(struct irq_domain *domain,
-- 
2.20.1

