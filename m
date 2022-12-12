Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18AB64993E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 08:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiLLHGi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 02:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiLLHGf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 02:06:35 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0322DD1;
        Sun, 11 Dec 2022 23:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670828793; x=1702364793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6LqKiGqF8xQfUNOA0F82eClaUz0ge/qFTczNzGwS3pA=;
  b=UDidpiUsE/aUlPJeCOEca3WEpes9DLWpdab2oBoj9RKS5O8B8SKXeZif
   QUC/lZqdcejxmWM+ocwNYdySc5mXCrZ0xsIVklQS7UTHTMDTJnSAmhuVo
   ZjtfiB8iaDwA9obMf/B74GkfrSYcaXXk2zoWn5bQeZOlcXqBp3AjzKrV2
   9v94GS4PEnt/qFV4ylqgWz4sxpg2fO3/hMTMMvd/e+ddq+duWpqi2Z5D1
   kXUXDrIQuf+vrBYaBZxPjx7/tWV85rvHcFecs+69GrdzRgzLiFeeSq9ol
   hXfPSgqDiDPm42bHSuCTrY7gmEJS4/YQGC56YRx/d8ofJqMlCSQw8+NSa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="317811822"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="317811822"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 23:06:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="641643046"
X-IronPort-AV: E=Sophos;i="5.96,237,1665471600"; 
   d="scan'208";a="641643046"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.168.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 23:06:30 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH V4 1/9] PCI/CXL: Export native CXL error reporting control
Date:   Sun, 11 Dec 2022 23:06:19 -0800
Message-Id: <20221212070627.1372402-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221212070627.1372402-1-ira.weiny@intel.com>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL _OSC Error Reporting Control is used by the OS to determine if
Firmware has control of various CXL error reporting capabilities
including the event logs.

Expose the result of negotiating CXL Error Reporting Control in struct
pci_host_bridge for consumption by the CXL drivers.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V3:
	New patch split out
---
 drivers/acpi/pci_root.c | 3 +++
 drivers/pci/probe.c     | 1 +
 include/linux/pci.h     | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index b3c202d2a433..84030804a763 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -1047,6 +1047,9 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
 		host_bridge->native_dpc = 0;
 
+	if (!(root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL))
+		host_bridge->native_cxl_error = 0;
+
 	/*
 	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
 	 * exists and returns 0, we must preserve any PCI resource
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2f4e88a44e8b..34c9fd6840c4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -596,6 +596,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_ltr = 1;
 	bridge->native_dpc = 1;
 	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
+	bridge->native_cxl_error = 1;
 
 	device_initialize(&bridge->dev);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1f81807492ef..08c3ccd2617b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -577,6 +577,7 @@ struct pci_host_bridge {
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
 	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
+	unsigned int	native_cxl_error:1;	/* OS may use CXL RAS/Events */
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
 	unsigned int	size_windows:1;		/* Enable root bus sizing */
 	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
-- 
2.37.2

