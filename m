Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C2055F0EA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 00:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiF1WK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 18:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiF1WKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 18:10:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6350934676
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 15:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656454249; x=1687990249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2zLKRQnDxh7TPHB/y3C8aTVoSAZPkdWLiT7+qBMfctw=;
  b=S6v1nwVPwDBLgL5eOavLjYjekAX0DMXLzdPcoZKglqYnHkkah51VlRV7
   Zknsv0dQwbYX+VYa4wsw48/aMB/wcpG5QnIRP8gsTCXlx/3Tb4b3IUGL+
   t2VWurj/FiL26xwiOPYApgklsFwL8A/vIWXxWoTQe9oVWxF7CbVdFc06e
   BWIVB58tP6ROXeDmxV8V5iaHl6VthsssmdoN0DxdB2wTmD+0h+a/uxFxN
   55qh3j9+0sPrOTV7OrM0Q8xsUDnFfV4B/s8j5tyIWfpi/7yxdy20R3hWW
   h2iVVxWzf3xWSsw4o62kXjbZ4Y0wP0W9wYcsKjCFmX69hNYmKypjEqrRi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="307347620"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="307347620"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:10:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="565213638"
Received: from alayek-mobl1.amr.corp.intel.com (HELO fmmunozr-desk.intel.com) ([10.213.173.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:10:39 -0700
From:   Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
To:     helgaas@kernel.org, lorenzo.pieralisi@arm.com
Cc:     jonathan.derrick@linux.dev, dan.j.williams@intel.com,
        linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: [PATCH] PCI: vmd: Add DID 8086:7D0B and 8086:AD0B for Intel MTL SKU's
Date:   Tue, 28 Jun 2022 15:10:23 -0700
Message-Id: <20220628221023.190547-1-francisco.munoz.ruiz@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for VMD devices in MTL-H/P/U/S/M which support the bus
restriction mode.
The feature that turns off vector 0 for MSI-X remapping is also
enabled.

Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 94a14a3d7e55..36597bbbfceb 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1013,6 +1013,14 @@ static const struct pci_device_id vmd_ids[] = {
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
 				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7d0b),
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				VMD_FEAT_OFFSET_FIRST_VECTOR,},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xad0b),
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				VMD_FEAT_OFFSET_FIRST_VECTOR,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-- 
2.25.1

