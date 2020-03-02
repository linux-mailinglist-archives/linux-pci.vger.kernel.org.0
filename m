Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4154176305
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 19:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgCBSqF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 13:46:05 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:56139 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgCBSqF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Mar 2020 13:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583174765; x=1614710765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7WM9yX1OJkKXJJaN0Bul5znh9nhHO2FbDkre7Td3gO0=;
  b=nimA25plg3bHpNwbxFtmaKE//1TLen4iP1OZU7uH6tVA2ukRsf3d/fR3
   2J5C0BrtpEhw5PkvNJhBxSdgGTxRCZR/SvLt+8+Hguni5srCGvrwaaHJ2
   zd6gh2RtpViwb+yyccv4QMdwa6VOaitOO2BZR0SQtM9KpbnyTrjxkmmGi
   A=;
IronPort-SDR: SiPSt2/PaDD1mUduWE3ZZcCXhAAoOWBUkvnPEFRKkR8bW3RmxLCE6FiVp7G5844uo/I33L7l/p
 ClNfH9QdN6HA==
X-IronPort-AV: E=Sophos;i="5.70,507,1574121600"; 
   d="scan'208";a="19142020"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 02 Mar 2020 18:46:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 816DAA244C;
        Mon,  2 Mar 2020 18:46:02 +0000 (UTC)
Received: from EX13D04EUB001.ant.amazon.com (10.43.166.190) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 2 Mar 2020 18:45:31 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D04EUB001.ant.amazon.com (10.43.166.190) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 2 Mar 2020 18:45:30 +0000
Received: from u961addbe640f56.ant.amazon.com (10.28.84.111) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Mar 2020 18:45:26 +0000
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
Subject: [PATCH v2 04/17] PCI: Do not override delay for D0->D3hot transition
Date:   Mon, 2 Mar 2020 19:44:16 +0100
Message-ID: <20200302184429.12880-5-stanspas@amazon.com>
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

Both specifications that document mechanisms for overriding the
D3hot->D0 waiting time only speak of this specific direction.
Nothing is mentioned about the opposite (D*->D3hot) except for
the default value of 10ms in PCI Express Base Specification
r5.0 (May 22, 2019), Section 5.9 "State Transition Recovery Time
Requirements".

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c1a866f733e9..03103bb15b42 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4589,7 +4589,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
 	csr &= ~PCI_PM_CTRL_STATE_MASK;
 	csr |= PCI_D3hot;
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
-	pci_dev_d3_sleep(dev);
+	msleep(PCI_PM_D3_WAIT);
 
 	csr &= ~PCI_PM_CTRL_STATE_MASK;
 	csr |= PCI_D0;
-- 
2.25.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



