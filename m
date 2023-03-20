Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B776C1E85
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 18:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjCTRu0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 13:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjCTRtp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 13:49:45 -0400
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 10:44:17 PDT
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FE6AF1E
        for <linux-pci@vger.kernel.org>; Mon, 20 Mar 2023 10:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3216; q=dns/txt; s=iport;
  t=1679334258; x=1680543858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lL/L1M5ipRbcKUTE79G1Dbmu5VJ+KpCTQx7b3yegPPY=;
  b=AfPcha93Nk5iaWzlHHRAAdXGJ6CeKznIf3QCq3HsGLN/J9Ts729nwj5s
   wpXxhjle7HLOSBGrm4/Ipm+GM3iBKe21ryuSzjrGlQ4PMH3XkFa4yVQCM
   pEsYvbZSAkfiqtJnefWDhKtys0oM/+AkCMjJP4UPB9dCS2+92AVPCQpT5
   g=;
X-IronPort-AV: E=Sophos;i="5.98,276,1673913600"; 
   d="scan'208";a="34119886"
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 20 Mar 2023 17:42:22 +0000
Received: from sjc-ads-7158.cisco.com (sjc-ads-7158.cisco.com [10.30.217.233])
        by rcdn-core-10.cisco.com (8.15.2/8.15.2) with ESMTPS id 32KHgMo7024218
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Mar 2023 17:42:22 GMT
Received: by sjc-ads-7158.cisco.com (Postfix, from userid 1776881)
        id 12D75CBEFAB; Mon, 20 Mar 2023 10:42:22 -0700 (PDT)
From:   Bartosz Wawrzyniak <bwawrzyn@cisco.com>
To:     vigneshr@ti.com, tjoseph@cadence.com, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xe-linux-external@cisco.com, danielwa@cisco.com, olicht@cisco.com,
        mawierzb@cisco.com, Bartosz Wawrzyniak <bwawrzyn@cisco.com>
Subject: [PATCH] PCI: cadence: Move 28 bit mask CPU addr fixup ops from platform device to J721E platform
Date:   Mon, 20 Mar 2023 10:41:34 -0700
Message-Id: <20230320174134.3418224-1-bwawrzyn@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.217.233, sjc-ads-7158.cisco.com
X-Outbound-Node: rcdn-core-10.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The 28 bit mask CPU addr fixup is used for generic platform device. However,
not all platforms require to mask 32 bit CPU address. Move 28 bit mask CPU addr
fixup ops to J721E SoC platform driver and use empty as a default one.

28 bit mask was introduced in commit d07701a17aec ("PCI: cadence: Add
new *ops* for CPU addr fixup").

Signed-off-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
---
 drivers/pci/controller/cadence/pci-j721e.c       |  8 ++++++++
 .../pci/controller/cadence/pcie-cadence-plat.c   | 16 ++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 918e11082e6a..9436ae322d58 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -35,6 +35,8 @@
 #define J721E_PCIE_USER_LINKSTATUS	0x14
 #define LINK_STATUS			GENMASK(1, 0)

+#define CDNS_PLAT_CPU_TO_BUS_ADDR	0x0FFFFFFF
+
 enum link_status {
 	NO_RECEIVERS_DETECTED,
 	LINK_TRAINING_IN_PROGRESS,
@@ -156,10 +158,16 @@ static bool j721e_pcie_link_up(struct cdns_pcie *cdns_pcie)
 	return false;
 }

+static u64 j721e_pcie_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
+{
+	return cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR;
+}
+
 static const struct cdns_pcie_ops j721e_pcie_ops = {
 	.start_link = j721e_pcie_start_link,
 	.stop_link = j721e_pcie_stop_link,
 	.link_up = j721e_pcie_link_up,
+	.cpu_addr_fixup = j721e_pcie_cpu_addr_fixup,
 };

 static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index a224afadbcc0..8b8a072fdd9d 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -13,7 +13,6 @@
 #include <linux/of_device.h>
 #include "pcie-cadence.h"

-#define CDNS_PLAT_CPU_TO_BUS_ADDR	0x0FFFFFFF

 /**
  * struct cdns_plat_pcie - private data for this PCIe platform driver
@@ -30,16 +29,9 @@ struct cdns_plat_pcie_of_data {
 	bool is_rc;
 };

-static const struct of_device_id cdns_plat_pcie_of_match[];
-
-static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
-{
-	return cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR;
-}
+static struct cdns_pcie_ops cdns_plat_ops;

-static const struct cdns_pcie_ops cdns_plat_ops = {
-	.cpu_addr_fixup = cdns_plat_cpu_addr_fixup,
-};
+static const struct of_device_id cdns_plat_pcie_of_match[];

 static int cdns_plat_pcie_probe(struct platform_device *pdev)
 {
@@ -77,6 +69,8 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)

 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
+
+		/* Set default bus ops */
 		rc->pcie.ops = &cdns_plat_ops;
 		cdns_plat_pcie->pcie = &rc->pcie;
 		cdns_plat_pcie->is_rc = is_rc;
@@ -105,6 +99,8 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 			return -ENOMEM;

 		ep->pcie.dev = dev;
+
+		/* Set default bus ops */
 		ep->pcie.ops = &cdns_plat_ops;
 		cdns_plat_pcie->pcie = &ep->pcie;
 		cdns_plat_pcie->is_rc = is_rc;
--
2.35.6

