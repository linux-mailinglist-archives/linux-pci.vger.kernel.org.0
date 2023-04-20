Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E95C6E953D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 15:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjDTNAn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 09:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjDTNAj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 09:00:39 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0AE65BF;
        Thu, 20 Apr 2023 06:00:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1522241D96;
        Thu, 20 Apr 2023 13:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681995636;
        bh=fLE9tMg1S+y52mJHeepsWqa/wGSHDhaLLeWS3MHOXJQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kBRGCB11Do1i/99WeIc+Cup6/KSCJIjpC1ztovsh7AlITDxxvZnebv3MCaY377Nwz
         Xm83QZuSCisFr55orPAQnQvjLWzzjbi8Bs8Zg3JkRTER49/Ehe2FKdcdPd5eX0huVT
         D7Q7S1XBu7XIeNic0JMgxwXVP3h4AuaNGBjB2WkRf/LAe6cFczDSriOOoCAuHFc6kb
         yNHcUInDTp5wcGUG6Wb0CtpEo6sPDeisSv9TmhT9tPXu30Nd70xx28CvLjWpR8C8EZ
         Wqzx+74n0rU2jzhVXnTjc1s7SAKtpRq3vludKSidtsWkROl5EA0gkLYNTdhH3CDkFo
         uM7HKTSoCBw2Q==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] PCI/AER: Disable AER interrupt on suspend
Date:   Thu, 20 Apr 2023 20:59:39 +0800
Message-Id: <20230420125941.333675-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420125941.333675-1-kai.heng.feng@canonical.com>
References: <20230420125941.333675-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe service that shares IRQ with PME may cause spurious wakeup on
system suspend.

PCIe Base Spec 5.0, section 5.2 "Link State Power Management" states
that TLP and DLLP transmission is disabled for a Link in L2/L3 Ready
(D3hot), L2 (D3cold with aux power) and L3 (D3cold), so we don't lose
much here to disable AER during system suspend.

This is very similar to previous attempts to suspend AER and DPC [1],
but with a different reason.

[1] https://lore.kernel.org/linux-pci/20220408153159.106741-1-kai.heng.feng@canonical.com/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - No change.

v2:
 - Only disable AER IRQ.
 - No more check on PME IRQ#.
 - Use helper.

 drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1420e1f27105..9c07fdbeb52d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1356,6 +1356,26 @@ static int aer_probe(struct pcie_device *dev)
 	return 0;
 }
 
+static int aer_suspend(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+	struct pci_dev *pdev = rpc->rpd;
+
+	aer_disable_irq(pdev);
+
+	return 0;
+}
+
+static int aer_resume(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+	struct pci_dev *pdev = rpc->rpd;
+
+	aer_enable_irq(pdev);
+
+	return 0;
+}
+
 /**
  * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
  * @dev: pointer to Root Port, RCEC, or RCiEP
@@ -1420,6 +1440,8 @@ static struct pcie_port_service_driver aerdriver = {
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
+	.suspend	= aer_suspend,
+	.resume		= aer_resume,
 	.remove		= aer_remove,
 };
 
-- 
2.34.1

