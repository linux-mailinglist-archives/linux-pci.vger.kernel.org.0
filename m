Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F65790377
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 15:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfHPNy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 09:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfHPNy1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 09:54:27 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FACE206C1;
        Fri, 16 Aug 2019 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565963666;
        bh=A1QP25a6ETdo4tCWntNKkSXSnYrJaCxFn/gAIPzd3X8=;
        h=From:To:Cc:Subject:Date:From;
        b=XMr0gc5XPndJI6GAjTrlBX7+g8VT71fqDvxPwi9nY5e7Zmzc/a1dF/UMouuUoBqSk
         6GUtgBqVos9yRxIFnh9c+xXx8wxbqr7gdujb/ElVTFwDu8WDvIbYFG/VOyZURAXnZQ
         qMph3dGyOP1L9VjgObrlijdTFj3yQ6q4hQWsGIHw=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] Documentation PCI: Fix pciebus-howto.rst filename typo
Date:   Fri, 16 Aug 2019 08:53:58 -0500
Message-Id: <20190816135357.142733-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

2e6422444894 ("Documentation: PCI: convert PCIEBUS-HOWTO.txt to reST")
incorrectly renamed PCIEBUS-HOWTO.txt to picebus-howto.rst.

Rename it to pciebus-howto.rst.

Fixes: 2e6422444894 ("Documentation: PCI: convert PCIEBUS-HOWTO.txt to reST")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/index.rst                                | 2 +-
 Documentation/PCI/{picebus-howto.rst => pciebus-howto.rst} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/PCI/{picebus-howto.rst => pciebus-howto.rst} (100%)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index f4c6121868c3..6768305e4c26 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -9,7 +9,7 @@ Linux PCI Bus Subsystem
    :numbered:
 
    pci
-   picebus-howto
+   pciebus-howto
    pci-iov-howto
    msi-howto
    acpi-info
diff --git a/Documentation/PCI/picebus-howto.rst b/Documentation/PCI/pciebus-howto.rst
similarity index 100%
rename from Documentation/PCI/picebus-howto.rst
rename to Documentation/PCI/pciebus-howto.rst
-- 
2.23.0.rc1.153.gdeed80330f-goog

