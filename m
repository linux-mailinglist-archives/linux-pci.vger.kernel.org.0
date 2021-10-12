Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC5342A9BD
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhJLQnx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhJLQnw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 12:43:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11F38610CE;
        Tue, 12 Oct 2021 16:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634056911;
        bh=t3kJPuFKbtd46Et3jtlinmUnjKCMUFRILo+kJP7wZmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqmUrPQbE5X+aRz+WjMDLfSlWo1VQvjiAtRD5aAqBsuG5H3/wGGhEJvbLT/lMPtDI
         kzk71hMIJV+sh0KGmmN0tP0cqCkxrrRhk9ICl3/qtL2nM9f3tnQgenPdZGpzN99Caj
         NDwBHv5ZowQJQq9HEgX/OmPDyXhrx402INuEsDCBJefSqhps8kXxwK7EP4DJS5sCdg
         ETj8FsOvUtmmfame2OqZWO1X8TW7Amw5fyvNbsH59pDJHx/qbnAsOCun8/kW6VYiyL
         wD46W/KE+a0Ov/tsHghlzWPqdH8p8HnFRFeIsIkt0VgkQP5MQ/7X8a7PDHejGdLGhA
         DQv50tuQqT9JQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 02/14] PCI: aardvark: Fix return value of MSI domain .alloc() method
Date:   Tue, 12 Oct 2021 18:41:33 +0200
Message-Id: <20211012164145.14126-3-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012164145.14126-1-kabel@kernel.org>
References: <20211012164145.14126-1-kabel@kernel.org>
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
Reviewed-by: Marek Behún <kabel@kernel.org>
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

