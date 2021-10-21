Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528AE43598C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 05:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJUDyb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 23:54:31 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:50630
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231228AbhJUDyb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 23:54:31 -0400
Received: from HP-EliteBook-840-G7.. (36-229-235-18.dynamic-ip.hinet.net [36.229.235.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5A1B740D4C;
        Thu, 21 Oct 2021 03:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634788335;
        bh=IX+6e3XktGWaNeDui0vqUe8dPvpPrg1YOM7jngPqhLQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=RpoAfF1F5SM28j1D9rJHCfvJxJxwWLvjto9Sna7tdtHjzXFhFXm6X5JWN6KDH0NLc
         EKbVn4XYcVpMJm/KTHF/qDUVu9daE9WM3BO7/qWQZCzRuB8VdavXI9OrBPVV1RSMXb
         D6NPwSzDFUKNnMGgoTQxguWQV9iOi8+gygtplE7iy7iUXDqfC2IH1L9IP70TsjliSb
         vTfjTjKt0Kjrh4JRu+nqMUnVmydDJto+VSJLFapoVIJJRCjV5IzoXlfpm2WAI1Qo3m
         zh/V+Fj67rKXV+jOBi+35r8yfApgEPI4SN2Aq7r9O+qkLTEs9WHilajnn7FR/wgZp/
         MPyNDUZq832dQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     hkallweit1@gmail.com, anthony.wong@canonical.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH v2 1/3] PCI/ASPM: Store disabled ASPM states
Date:   Thu, 21 Oct 2021 11:51:57 +0800
Message-Id: <20211021035159.1117456-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211021035159.1117456-1-kai.heng.feng@canonical.com>
References: <20211021035159.1117456-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If we use sysfs to disable L1 ASPM, then enable one L1 ASPM substate
again, all other substates will also be enabled too:

link# grep . *
clkpm:1
l0s_aspm:1
l1_1_aspm:1
l1_1_pcipm:1
l1_2_aspm:1
l1_2_pcipm:1
l1_aspm:1

link# echo 0 > l1_aspm

link# grep . *
clkpm:1
l0s_aspm:1
l1_1_aspm:0
l1_1_pcipm:0
l1_2_aspm:0
l1_2_pcipm:0
l1_aspm:0

link# echo 1 > l1_2_aspm

link# grep . *
clkpm:1
l0s_aspm:1
l1_1_aspm:1
l1_1_pcipm:1
l1_2_aspm:1
l1_2_pcipm:1
l1_aspm:1

This is because disabled ASPM states weren't saved, so enable any of the
substate will also enable others.

So store the disabled ASPM states for consistency.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Drop redundant change.

 drivers/pci/pcie/aspm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 013a47f587ce..30b1bc899026 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -658,6 +658,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
 
+	link->aspm_disable = link->aspm_capable & ~link->aspm_default;
+
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		u32 reg32, encoding;
@@ -1231,6 +1233,9 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 		if (state & ASPM_STATE_L1SS)
 			link->aspm_disable &= ~ASPM_STATE_L1;
 	} else {
+		if (state == ASPM_STATE_L1)
+			state |= ASPM_STATE_L1SS;
+
 		link->aspm_disable |= state;
 	}
 
-- 
2.32.0

