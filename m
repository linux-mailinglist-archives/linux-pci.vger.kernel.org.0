Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E2C177708
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 14:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgCCNaO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 08:30:14 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:16728 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgCCNaN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 08:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583242213; x=1614778213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cbndvv3qCssTnIgDUBDG4qXe8hnk+TGR5JEIQeTw7KA=;
  b=Cgx7GVRhT9CG8NsydXG98erpUyfdBdOPNkO0O8vdXes7z7gCM+U0xqKQ
   tLo+D8ijNFhoWPhck7Jr8S2OYWzkOo1Ahh90fe59E8UsaOcis7VuPbnqn
   yAPwSF6dOIwoEffrDhRekmImZ1P3bBo/b9+KwVwytX6XJup7Vqde0vXrl
   M=;
IronPort-SDR: hVVg2IxgfCqsQmQEvFd//MhJ8n2GbgjwmW1a1XTjO36eTFV2aABndg/dA9InMgN71P3MQ5mAKn
 GRi20oa/lZ3w==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="19548917"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 03 Mar 2020 13:30:00 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 225B2A2E6D;
        Tue,  3 Mar 2020 13:29:58 +0000 (UTC)
Received: from EX13D12EUA004.ant.amazon.com (10.43.165.162) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 13:29:46 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D12EUA004.ant.amazon.com (10.43.165.162) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Mar 2020 13:29:45 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Mar 2020 13:29:42 +0000
From:   Stanislav Spassov <stanspas@amazon.com>
To:     <linux-pci@vger.kernel.org>
CC:     Stanislav Spassov <stanspas@amazon.de>,
        <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>, Rajat Jain <rajatja@google.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v3 02/17] PCI: Remove unused PCI_PM_BUS_WAIT
Date:   Tue, 3 Mar 2020 14:28:37 +0100
Message-ID: <20200303132852.13184-3-stanspas@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303132852.13184-1-stanspas@amazon.com>
References: <20200303132852.13184-1-stanspas@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Stanislav Spassov <stanspas@amazon.de>

The last usage of this constant was removed by:
commit 476e7faefc43 ("PCI PM: Do not wait for buses in B2 or B3 during resume")

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6394e7746fb5..659ab3f9042a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -46,7 +46,6 @@ int pci_bus_error_reset(struct pci_dev *dev);
 #define PCI_PM_D2_DELAY         200
 #define PCI_PM_D3_WAIT          10
 #define PCI_PM_D3COLD_WAIT      100
-#define PCI_PM_BUS_WAIT         50
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



