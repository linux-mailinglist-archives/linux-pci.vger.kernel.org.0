Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990411A8F87
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 02:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392239AbgDOAHA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 20:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392240AbgDOAG6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 20:06:58 -0400
Received: from localhost (mobile-166-175-184-103.mycingular.net [166.175.184.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C722076B;
        Wed, 15 Apr 2020 00:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586909217;
        bh=kX9vypy+m7pQaRNUL9aqUl2TFQjXB7+7PTmQ2YV4/2M=;
        h=From:To:Cc:Subject:Date:From;
        b=gRO4dsLDyAqo+weACE5eZSSEfg08RLogdh6jLKlPDCPCEsVQztae7cK0OiGuUcwv9
         ILh5pd8J1DFcWTdS4dxehzOA12fPjdELHxJpTzYVyI9DIFZp0ad1zhEo2RRgc9YIbA
         7zRX6Jzi4WqRVzoNGL4Fyrd59AcE/GheFpD+Micc=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PCI/PM: Call .bridge_d3() hook only if non-NULL
Date:   Tue, 14 Apr 2020 19:06:35 -0500
Message-Id: <20200415000635.144283-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

26ad34d510a8 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports") added
the struct pci_platform_pm_ops.bridge_d3() function pointer and
platform_pci_bridge_d3() to use it.

The .bridge_d3() op is implemented by acpi_pci_platform_pm, but not by
mid_pci_platform_pm.  We don't expect platform_pci_bridge_d3() to be called
on Intel MID platforms, but nothing in the code itself would prevent that.

Check the .bridge_d3() pointer for NULL before calling it.

Fixes: 26ad34d510a8 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 595fcf59843f..dfa7ec008963 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -868,7 +868,9 @@ static inline bool platform_pci_need_resume(struct pci_dev *dev)
 
 static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 {
-	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
+	if (pci_platform_pm && pci_platform_pm->bridge_d3)
+		return pci_platform_pm->bridge_d3(dev);
+	return false;
 }
 
 /**
-- 
2.26.0.110.g2183baf09c-goog

