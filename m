Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3465C176304
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCBSqE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:46:04 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:56139 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbgCBSqE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174764; x=1614710764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cbndvv3qCssTnIgDUBDG4qXe8hnk+TGR5JEIQeTw7KA=;
  b=IV3XC7b4yxa/uuwT8RCDYI8b9rJGw3oFS3yQgDX/YPICCfLqYsc7dJQD
   Lmngum1Ilr6di9yW5n7w7BpOrKZCJKODhQXZzT0T/diZtmHSBRhbCIEF7
   GkTH8FD745UFQCRMw+hUY+f+wweGKFZl74+0F2w+24kjSpslua0ctYIpL
   U=;
IronPort-SDR: 6emHHV9YeIwwbj1EpazE7fNk6bjsuDJUO68Jb04s8JeO4FswiiJeMOdV+nN9ruk0XH0f0cjo5t
 IdPvnLiWbJnw==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="19142009"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 02 Mar 2020 18:46:01 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 1EBA6A3155;
        Mon,  2 Mar 2020 18:46:00 +0000 (UTC)
Received: from EX13D12EUA003.ant.amazon.com (10.43.165.147) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:45:22 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D12EUA003.ant.amazon.com (10.43.165.147) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:45:21 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:45:17 +0000
From:   Stanislav Spassov <stanspas@amazon.com>
To:     <linux-pci@vger.kernel.org>
CC:     Stanislav Spassov <stanspas@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Sinan Kaya" <okaya@kernel.org>, Rajat Jain <rajatja@google.com>
Subject: [PATCH v2 02/17] PCI: Remove unused PCI_PM_BUS_WAIT
Date:   Mon, 2 Mar 2020 19:44:14 +0100
Message-ID: <20200302184429.12880-3-stanspas@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302184429.12880-1-stanspas@amazon.com>
References: <20200302184429.12880-1-stanspas@amazon.com>
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



