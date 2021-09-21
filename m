Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C63413D48
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 00:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhIUWGg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 18:06:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:40124 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235876AbhIUWGf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Sep 2021 18:06:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="223119130"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="223119130"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:06 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="557114677"
Received: from ksankar-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.132.1])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:05 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 4/7] cxl/pci: Make more use of cxl_register_map
Date:   Tue, 21 Sep 2021 15:04:56 -0700
Message-Id: <20210921220459.2437386-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921220459.2437386-1-ben.widawsky@intel.com>
References: <20210921220459.2437386-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The structure exists to pass around information about register mapping.
As a minor cleanup, use it more extensively.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6e5c026f5262..7c1d5d5aef6e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -306,12 +306,13 @@ static int cxl_pci_setup_mailbox(struct cxl_mem *cxlm)
 	return 0;
 }
 
-static void __iomem *cxl_pci_map_regblock(struct cxl_mem *cxlm,
-					  u8 bar, u64 offset)
+static void __iomem *cxl_pci_map_regblock(struct cxl_mem *cxlm, struct cxl_register_map *map)
 {
 	void __iomem *addr;
+	int bar = map->barno;
 	struct device *dev = cxlm->dev;
 	struct pci_dev *pdev = to_pci_dev(dev);
+	resource_size_t offset = map->block_offset;
 
 	/* Basic sanity check that BAR is big enough */
 	if (pci_resource_len(pdev, bar) < offset) {
@@ -363,6 +364,7 @@ static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
 static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
 			  struct cxl_register_map *map)
 {
+	void __iomem *offset = base + map->block_offset;
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
 	struct device *dev = cxlm->dev;
@@ -370,7 +372,7 @@ static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
 	switch (map->reg_type) {
 	case CXL_REGLOC_RBI_COMPONENT:
 		comp_map = &map->component_map;
-		cxl_probe_component_regs(dev, base, comp_map);
+		cxl_probe_component_regs(dev, offset, comp_map);
 		if (!comp_map->hdm_decoder.valid) {
 			dev_err(dev, "HDM decoder registers not found\n");
 			return -ENXIO;
@@ -380,7 +382,7 @@ static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
-		cxl_probe_device_regs(dev, base, dev_map);
+		cxl_probe_device_regs(dev, offset, dev_map);
 		if (!dev_map->status.valid || !dev_map->mbox.valid ||
 		    !dev_map->memdev.valid) {
 			dev_err(dev, "registers not found: %s%s%s\n",
@@ -505,13 +507,13 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 			break;
 		}
 
-		base = cxl_pci_map_regblock(cxlm, map.barno, map.block_offset);
+		base = cxl_pci_map_regblock(cxlm, &map);
 		if (!base) {
 			rc = -ENOMEM;
 			break;
 		}
 
-		rc = cxl_probe_regs(cxlm, base + map.block_offset, &map);
+		rc = cxl_probe_regs(cxlm, base, &map);
 		cxl_pci_unmap_regblock(cxlm, base);
 		if (rc)
 			break;
-- 
2.33.0

