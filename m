Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E8B43E8B2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 20:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhJ1S7c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 14:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230505AbhJ1S7c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 14:59:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C287610EA;
        Thu, 28 Oct 2021 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635447425;
        bh=jVL6U9PYqMj5MznymMVeGWdXkPuD32M/xjwPj8WwgIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VzaZhWRhfTQf8/Xy97oFgf2O2Jr3sQ4XkrRYnpp2QfryrZXHyq0QLd2QZoeMXRG2h
         0o7quDRbhZUROa6n/fYbnsROY1yyCuIL4vYXAXgttI9CvuzaYnXQSvlvJi3azT3tL8
         ue6i+PfzZp6pTWgKWmIly7L/3I1yMRt1uri7I7RE/7HhfHhtAM+LeHASzJZBDZGRyJ
         Bl6WqoaMY9MxmmMfaxZ7Ilyt0tD7IDSYJxNpVbEHXfa6f2ETs+ZlLqJL16v05JU5dV
         dg5FS7hbD5bI14BEEbNvLXGqmBYM/5nfX3LA3HeLuKog+ROKjyrPf3gDJ7pL4/PCPS
         rqfdMGxlg3BTA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 2/7] PCI: aardvark: Fix return value of MSI domain .alloc() method
Date:   Thu, 28 Oct 2021 20:56:54 +0200
Message-Id: <20211028185659.20329-3-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211028185659.20329-1-kabel@kernel.org>
References: <20211028185659.20329-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MSI domain callback .alloc() (implemented by advk_msi_irq_domain_alloc()
function) should return zero on success, since non-zero value indicates
failure.

When the driver was converted to generic MSI API in commit f21a8b1b6837
("PCI: aardvark: Move to MSI handling using generic MSI support"), it
was converted so that it returns hwirq number.

Fix this.

Fixes: f21a8b1b6837 ("PCI: aardvark: Move to MSI handling using generic MSI support")
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 10476c00b312..b45ff2911c80 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1138,7 +1138,7 @@ static int advk_msi_irq_domain_alloc(struct irq_domain *domain,
 				    domain->host_data, handle_simple_irq,
 				    NULL, NULL);
 
-	return hwirq;
+	return 0;
 }
 
 static void advk_msi_irq_domain_free(struct irq_domain *domain,
-- 
2.32.0

