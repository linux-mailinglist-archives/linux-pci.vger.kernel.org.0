Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EDF76071A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 06:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGYEO7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 00:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGYEO5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 00:14:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E4EE59
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 21:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690258496; x=1721794496;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3txiD4SisULDKa8kvXRe0BWXq9sNCNQLjulxe+4hOQs=;
  b=cZklJlRkRhJWo1IpfIYtfwWyFvb2OBjdJKpmuHS1wWbjpQQNuaJxzLn/
   cdQxaxO7pzI9hRH549S3fAQO7rhyBtoPAw3PmueoynrN7Dj/LkN1e4x5b
   abpmaZC1z2XgEPv4zUQhdkOYvOB9EaWNmrIA1LaJvBDX2wHqxV/xCB+jp
   MFFG2n2Yo3ne2gQ+8AANS+jCdgjhinHheU2NZ9ERrj2qozawt77Z8Ikbp
   1E2P8GrqoIlFkmUpMhhAMHPv1OHJFR/0714r/eH/pIyLuG/3iuVPdAWmw
   cdvURkExqVzUHmyMkuW5GUwxTb3gwqrqg+EPXq7LzbKFttwqi/4sz+Hmd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="366499016"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="366499016"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 21:14:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="849860596"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="849860596"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 21:14:55 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     nirmal.patel@linux.intel.com, <linux-pci@vger.kernel.org>
Subject: [PATCH v2] PCI: vmd: Do not change the Hotplug setting on VMD rootports
Date:   Mon, 24 Jul 2023 23:54:05 -0400
Message-Id: <20230725035405.932765-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The hotplug functionality is broken in various combinations of guest
OSes i.e. RHEL, SLES and hypervisors i.e. KVM and ESXI.

During the VMD rootport creation, VMD honors ACPI settings and assigns
respective values to Hotplug, AER, DPC, PM etc which works in case of
Host OS. But these have been restored back to the power on default
state in Guest OSes, which puts the root port hot plug enable to
default OFF.

When BIOS boots, all root ports under VMD is inaccessible by BIOS and
they maintain their power on default states. The VMD UEFI driver loads
and configure all devices under VMD. This is how AER, power management,
DPC and hotplug gets enabled in UEFI, since the BIOS pci driver cannot
access the root ports. With the absence of VMD UEFI driver in Guest,
Hotplug stays Disabled.

This change will  cause the hot plug to start working again in guest,
as the settings implemented by the UEFI VMD DXE driver will remain in
effect in the Guest OS.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..52c2461b4761 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -701,8 +701,6 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
 				       struct pci_host_bridge *vmd_bridge)
 {
-	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
-	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
 	vmd_bridge->native_aer = root_bridge->native_aer;
 	vmd_bridge->native_pme = root_bridge->native_pme;
 	vmd_bridge->native_ltr = root_bridge->native_ltr;
-- 
2.31.1

