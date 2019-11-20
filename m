Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D63C1033A5
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 06:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfKTFR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 00:17:58 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6353 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfKTFR6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 00:17:58 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd4cc820000>; Tue, 19 Nov 2019 21:17:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 19 Nov 2019 21:17:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 19 Nov 2019 21:17:57 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Nov
 2019 05:17:57 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 20 Nov 2019 05:17:56 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd4cc810004>; Tue, 19 Nov 2019 21:17:56 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <rjw@rjwysocki.net>, <okaya@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 2/2] PCI: Introduce pci_dev_wait() in pci_power_up() API
Date:   Wed, 20 Nov 2019 10:47:43 +0530
Message-ID: <20191120051743.23124-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120051743.23124-1-vidyas@nvidia.com>
References: <20191118172310.21373-1-vidyas@nvidia.com>
 <20191120051743.23124-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574227074; bh=0wB/nq3VkyKa32HWHP+nZIKV9ao/aUf1HNrbYgl7VYc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FWkBHOsjI4/YJ9QiesHR5D/j8E9/+3O4qTRJdwWE7DR4B09EA8IGj8PG7TnfhKf8D
         yOZgaC/VKdPe8myEPBCR2v8xHPDCxPRfls4KIL/GTsbipHdIMfjj3miKz1r1o0T3XJ
         m3anV1gY8M1eDvSgEtU/fSNpfG5Kb1vMpGeTQOp7D8Jw7FbJtJxsNdOipRH7D716HM
         Q0paVk0SfOi6Mn+mww7LnLkFBfniTccSg0hI7fYqzYKqCmInRroOcqN5pAlOEfd87n
         og7k+lb4UV+grrGmaJWwKkNxBXJ4JE2uNyOILbun18LEd0Oohz7uRRyHMt+WrkGHpK
         3gzuxDjXPxxSQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pci_dev_wait() in pci_power_up() before accessing the configuration
space of a device for the first time in the system resume sequence.
This is  to accommodate devices (Ex:- Intel 750 NVMe) that respond with CRS
status while they get ready for configuration space access and before they
finally start responding with proper values.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 71b45ce73bf6..7672b9a44bac 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1086,6 +1086,13 @@ int pci_power_up(struct pci_dev *dev)
 		pci_wakeup_bus(dev->subordinate);
 	}
 
+	/*
+	 * Wait for those devices (Ex: Intel 750 NVMe) that are not ready yet
+	 * and responding with CRS statuses for the configuration space
+	 * requests.
+	 */
+	pci_dev_wait(dev, "Switch to D0", PCIE_RESET_READY_POLL_MS);
+
 	return pci_raw_set_power_state(dev, PCI_D0);
 }
 
-- 
2.17.1

