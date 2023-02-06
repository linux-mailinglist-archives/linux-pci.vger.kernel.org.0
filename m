Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BD168C808
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjBFUvs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjBFUvo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:51:44 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59012DE73;
        Mon,  6 Feb 2023 12:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716700; x=1707252700;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hv/W896d+eaEclcVrbd282vgqnn+BAffzWLknUdDUJk=;
  b=YRhREw5gro5NYQfRTwAN0jPlEe87bZooZdPMUWaMNFQDj6miAnWQDCq/
   vTK/ZZJEtLYg2PNdKpCNGey2xdEMBHovlHKhcSVPubiahu9B/4SXbWXne
   UPPoGejBlG5Vo1wQ1I5OR1fQMGoRua2cIBbIGQRUTt2af/BkOmKNOmPBb
   TV/UUhlbPR3oH5GbQWCCrgK3IkatSULPaV/8TyPWbAoFXQwhROpLeEqHi
   GDG6sbhcoeDpwuGx+8zMu3F6YidF0I+u7WetpUTbfT98p6+3tH5dBzJrk
   Rpq+sFOmQLe3k/UH9+5jAst6JedyUvRokMWVkWU7lnCpu2oQdPhLT+qny
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327946615"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327946615"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="790552345"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="790552345"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:39 -0800
Subject: [PATCH 15/18] cxl: Move identify and partition query from pci probe
 to port probe
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:51:37 -0700
Message-ID: <167571669593.587790.12939497495344674151.stgit@djiang5-mobl3.local>
In-Reply-To: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the enumeration of device capacity to cxl_port_probe() from
cxl_pci_probe(). The size and capacity information should be read
after cxl_await_media_ready() so the data is valid.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c  |    8 --------
 drivers/cxl/port.c |    8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 258004f34281..e35ed250214e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -484,14 +484,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_dev_state_identify(cxlds);
-	if (rc)
-		return rc;
-
-	rc = cxl_mem_create_range_info(cxlds);
-	if (rc)
-		return rc;
-
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 03380c18fc52..b7a4a1be2945 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -127,6 +127,14 @@ static int cxl_port_probe(struct device *dev)
 			if (rc)
 				dev_dbg(dev, "Failed to do QoS calculations\n");
 		}
+
+		rc = cxl_dev_state_identify(cxlds);
+		if (rc)
+			return rc;
+
+		rc = cxl_mem_create_range_info(cxlds);
+		if (rc)
+			return rc;
 	}
 
 	rc = devm_cxl_enumerate_decoders(cxlhdm);


