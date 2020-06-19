Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF377200380
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jun 2020 10:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbgFSIVI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jun 2020 04:21:08 -0400
Received: from foss.arm.com ([217.140.110.172]:46940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730983AbgFSIUl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jun 2020 04:20:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41F2813A1;
        Fri, 19 Jun 2020 01:20:40 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.58.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC9ED3F71F;
        Fri, 19 Jun 2020 01:20:37 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 04/12] ACPI/IORT: Remove useless PCI bus walk
Date:   Fri, 19 Jun 2020 09:20:05 +0100
Message-Id: <20200619082013.13661-5-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI bus domain number (used in the iort_match_node_callback() -
pci_domain_nr() call) is cascaded through the PCI bus hierarchy at PCI
bus enumeration time, therefore there is no need in iort_find_dev_node()
to walk the PCI bus upwards to grab the root bus to be passed to
iort_scan_node(), the device->bus PCI bus pointer will do.

Remove this useless code.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/arm64/iort.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 53f9ef515089..421c6976ab81 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -558,10 +558,7 @@ static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
 				      iort_match_node_callback, dev);
 	}
 
-	/* Find a PCI root bus */
 	pbus = to_pci_dev(dev)->bus;
-	while (!pci_is_root_bus(pbus))
-		pbus = pbus->parent;
 
 	return iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
 			      iort_match_node_callback, &pbus->dev);
-- 
2.26.1

