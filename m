Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0348F581D2E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 03:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbiG0Bd7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 21:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbiG0Bd6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 21:33:58 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363153B944;
        Tue, 26 Jul 2022 18:33:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1508E3F395;
        Wed, 27 Jul 2022 01:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658885634;
        bh=J7Mo7gRC9aUnXUlERL8fcZBWoJb2JAks8HFFUOO/0qw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=acyN2D9yFbUZ/Di08hQd138lFj++ds1vlYZ+Yl49z3HG+jdfU29MdKH+i3syPYvvW
         jMeejKm069QBpOOIQ88GvibA3gP6GHjBSbeugvUV/j2Y8a8luyT9yyff0Rn0zoRIrj
         k/P1Lf5C8n17MNcgSuBZB6LdaY/w/VkDLMOfM+7r35laPtNsvYRghH8L+CtTZBiMpK
         3a1iWObZEdTXFhfrKpzFhEPgGEe6bBPREQ5qp+pro2mnXsJwB/bx62SUGi3kbvfk0x
         C0kwAiwb2i3KXtB/ON81AQhdcguRpPJWR5GVC3/Yod9zWEfMTiSsMITi+TN4n0LLPM
         KXrElqQEzq+SQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI/AER: Disable AER service on suspend when IRQ is shared with PME
Date:   Wed, 27 Jul 2022 09:32:51 +0800
Message-Id: <20220727013255.269815-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220727013255.269815-1-kai.heng.feng@canonical.com>
References: <20220727013255.269815-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216295

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/aer.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 7952e5efd6cf3..60cc373754af2 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1372,6 +1372,26 @@ static int aer_probe(struct pcie_device *dev)
 	return 0;
 }
 
+static int aer_suspend(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	if (dev->shared_pme_irq)
+		aer_disable_rootport(rpc);
+
+	return 0;
+}
+
+static int aer_resume(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	if (dev->shared_pme_irq)
+		aer_enable_rootport(rpc);
+
+	return 0;
+}
+
 /**
  * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
  * @dev: pointer to Root Port, RCEC, or RCiEP
@@ -1441,8 +1461,9 @@ static struct pcie_port_service_driver aerdriver = {
 	.name		= "aer",
 	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_AER,
-
 	.probe		= aer_probe,
+	.suspend	= aer_suspend,
+	.resume		= aer_resume,
 	.remove		= aer_remove,
 };
 
-- 
2.36.1

