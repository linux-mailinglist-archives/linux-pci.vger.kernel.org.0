Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB443598E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 05:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhJUDyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 23:54:38 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:50658
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231282AbhJUDyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 23:54:37 -0400
Received: from HP-EliteBook-840-G7.. (36-229-235-18.dynamic-ip.hinet.net [36.229.235.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 12CE340058;
        Thu, 21 Oct 2021 03:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634788341;
        bh=bnL4SvcUkS8xPULrMa771cL9UaubDo2X9uN1x+nE4dU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VsmJaSuAgEM2i8YiML2gyGaIyxP7lbJuUxrBRO7OllqI1KIq9L5uEBN223dQuq6mU
         ACwa24TsdkFUsjjENVvX9vATDpTiiKMT4SN1oW1YCMOVF3o9VdvZkI41ciofxm4ILN
         tsPF+837w8cbaIJV2+5F20D0sph5EvLWHG9f5ZTImzi+da3C/EKitnZRPFzjLdtTuL
         H+0iuYuAxDp2hw7QTdJFJ8uhG0oofHcNR3sV/JwSNBiXpMqp+pzQmd6VKjG4lq+Nr1
         5v+eCTp2Typ7YOvyzxRhZWKQnlwq+oRPmyH+aLf2Rx/xtSAPTPSKM54p81wH7oZvnq
         U3OfSOyJDWjOQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     hkallweit1@gmail.com, anthony.wong@canonical.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH v2 2/3] PCI/ASPM: Use capability to override ASPM via sysfs
Date:   Thu, 21 Oct 2021 11:51:58 +0800
Message-Id: <20211021035159.1117456-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211021035159.1117456-1-kai.heng.feng@canonical.com>
References: <20211021035159.1117456-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If we are to use sysfs to change ASPM settings, we may want to override
the default ASPM policy.

So use ASPM capability, instead of default policy, to be able to use all
possible ASPM states.

Upon power management change, pcie_aspm_pm_state_change() always
re-apply the state from global ASPM policy, so also introduce a new flag
to make the sysfs change persistent.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Add flag to make ASPM change persistent

 drivers/pci/pcie/aspm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 30b1bc899026..1560859ab056 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -60,6 +60,8 @@ struct pcie_link_state {
 	u32 aspm_default:7;		/* Default ASPM state by BIOS */
 	u32 aspm_disable:7;		/* Disabled ASPM state */
 
+	bool aspm_ignore_policy;	/* Ignore ASPM policy after sysfs overwrite */
+
 	/* Clock PM state */
 	u32 clkpm_capable:1;		/* Clock PM capable? */
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
@@ -796,7 +798,8 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 static void pcie_config_aspm_path(struct pcie_link_state *link)
 {
 	while (link) {
-		pcie_config_aspm_link(link, policy_to_aspm_state(link));
+		pcie_config_aspm_link(link, link->aspm_ignore_policy ?
+				      link->aspm_capable : policy_to_aspm_state(link));
 		link = link->parent;
 	}
 }
@@ -1238,8 +1241,8 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 
 		link->aspm_disable |= state;
 	}
-
-	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+	pcie_config_aspm_link(link, link->aspm_capable);
+	link->aspm_ignore_policy = true;
 
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
-- 
2.32.0

