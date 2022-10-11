Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7B25FB160
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 13:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJKLXd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 07:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKLXc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 07:23:32 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B0A74B9E;
        Tue, 11 Oct 2022 04:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+X9/eTaOO7lgjDi1xAgOpnZg3ILhH8HrncSUnzNcOd4INRV73us5YMREFH+0Uz91yPckuDOGgsU2BDaAErgh9yUODo1xrhDplsWy8ZsyCifexfMBRTvw+agx0SuwImPUQXAXJROR2NyMhm5AFEcUJX0s59pkYrDfw9J+YWlxXy0qgAdtvlrDakA7HoX40GzBCXU95JuVotH8ALQXGG4i4lafiTol6oKjESa/1sY/TB/stV86tW9a/1iZ1hHjFG6/2M3NALPhF688VWhuP1x8XFyziJt6qyOFiayBIdL0kKfh8PBbqj45PRXZCarm3tNkA2z6ztw2J4iRYaK5t6vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWIw4mmrpHIpUq6fX29v5JIptqXeSfCz0ad/ljxMyXo=;
 b=IVLkUS3NnR01RtZGrhKVYDvqMcnKU+CUmp9Z4Rq7WsEO4b6r3Lp+Iw+Vq/h+EMOhExxyU3AFuWTSqAnQQUsrVbPzfLisE1+ma19BRQo1DD3tzi7cucZH41Z7DHRPbIz9yr+iVZjr9IMBBdD/AEVhd4weZtUgMTN8nm+TsqV4Ny18TNWrWFNwvHbHcfgvfu7aXj1xxRIwPmbTcKbDY118lnGfSQJg2g0kNcqiYQzkedNOPIxKxDbGI+yTD1Z1oNnNnFeN6nc//XKmv7vV/9eaGhDsggWtx8lKTKFR1vgt4of5SeiGYIPRU3SksYWTdz1ar2w1xtxXzXj/z56V6F1xrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWIw4mmrpHIpUq6fX29v5JIptqXeSfCz0ad/ljxMyXo=;
 b=O6CIkGxzzex3ZilvVMRMWwTBnDn4F3GdvUDE/JonaG6NIyxhdjPzJgoGVkQfdt+S7qjhF7u8yho7TAsXJlGKDWYSrkD7InuF7v9zuAlX5Vs5Ci+ry+bSzT/HfwoBjU5mI3bvsOMFSnLanMAsImzPuAfqswIdCVAdKGfqRXpETTk=
Received: from DM6PR06CA0063.namprd06.prod.outlook.com (2603:10b6:5:54::40) by
 SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 11:23:29 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::f7) by DM6PR06CA0063.outlook.office365.com
 (2603:10b6:5:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 11:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 11:23:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 06:23:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 06:23:27 -0500
Received: from mark-SkyRiver-slmb.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Tue, 11 Oct 2022 06:23:26 -0500
From:   Rui Ma <Rui.Ma@amd.com>
To:     <helgaas@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <Alexander.Deucher@amd.com>, <bhelgaas@google.com>,
        Rui Ma <Rui.Ma@amd.com>
Subject: [PATCH] PCI/IOV: Decrease VF memory BAR size to save host memory occupied by PTEs
Date:   Tue, 11 Oct 2022 19:23:25 +0800
Message-ID: <20221011112325.992317-1-Rui.Ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 860d4702-b5b5-4bd2-9ea1-08daab7b0564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xm7Uo1bbIc/f8FcFHIIh244ix9gILwRHi8AnaNUPkBIG/nJvnuqbnPwccOPuXwqplUNJhCw+7yYExhmzYC9m7YXSHxNa4kWQ6dEjhrwF1lg14RCcVmolLuvnwiGzP6f8ZGM5DbJb4gktgWaqbdHRRwd0K/LYShtqKLPq0Dg7ShH/0dlU8gBZ/epIp9iKiyFmuxvGdDgJI4KtwpDeX++g74EfqgkrQBZRlR56fwUOZQsR1Sd7ZcrclkKeCvL0ow3mbj9wqgXUA4jQlQL0psMIuEqrdRiGFpRk1s3EOprfj50Ni+zElkO5u6rCg9Y69Zy3i6L3aSBNLqglD9tMwrNsdyOtb6Wdg1VCIiOJpCk+9mLrRsWB18vS/4XmjDcgiu3mp4OI8Vv9fXldVCg+n+XcoG4kiqslkIkF/xOok4+wbKxDjkrE/4H5ize1i3yMPjHFlmcVdFCCQLFZDNgdVL29N+IT0GYGHvC3VeemqaNeCMVLiSi/DzXQBIFjIBcSVszHDWUCyPSJTmfIVBTJOVlU4bHcbVBWncHkq38k/KH9yXVm3A3hJ2Br5BGKpBJXmlpWPkQ+fWyLS56xBRbXuHJjQlzI/vA6Od62bbaYowv810YTENZD4W8/U+KwgQB0rwT2ai/LPsMK1r7IJU7quYuBBCZ4DGtGY+wf2kb9dkyaG8bJec5Fcb0EU6dF7KhNbVIhTA85mSWkUkvgF3skuPsKzye1MX+X76y7cswuU32bTiAIuC4h4kqJGgbAU/YLu+Nou7DU2TV1n+mXLZtxrhOGkMVnT4wg9gtTLg3X2x6S5CuL1FxknKFl0BgYuZeY+L7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(1076003)(186003)(82310400005)(2906002)(2616005)(426003)(6916009)(54906003)(36756003)(70206006)(70586007)(8676002)(4326008)(316002)(41300700001)(40460700003)(478600001)(86362001)(5660300002)(336012)(40480700001)(36860700001)(26005)(8936002)(7696005)(81166007)(47076005)(356005)(82740400003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 11:23:28.5372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 860d4702-b5b5-4bd2-9ea1-08daab7b0564
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In some certain SR-IOV scene, when the device physical space(such as Video
RAM)is fixed, as the number of VFs increases, some device driver may decrease
actual BAR memory space used by each VF. However, the VF BAR memory mapping is
always based on the usual BAR probing algorithm in PCIe spec. So do not map this
unneeded memory can save host memory which occupied by PTEs. Although each PTE
only occupies a few bytes of space on its own, a large number of PTEs can still
take up a lot of space.

Signed-off-by: Rui Ma <Rui.Ma@amd.com>
---
 drivers/pci/iov.c    | 14 ++++++++++++--
 drivers/pci/pci.h    | 15 +++++++++++++++
 drivers/pci/quirks.c | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 952217572113..92a69e51d85c 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -296,6 +296,14 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	struct pci_sriov *iov = dev->sriov;
 	struct pci_bus *bus;
 
+    /*
+     * Some SR-IOV device's BAR map range is larger than they can actually use.
+     * This extra BAR space occupy too much reverse mapping size(physical page
+     * back to the PTEs). So add a divisor shift parameter to resize the request
+     * resource of VF according to num of VFs.
+     */
+	u16 shift = 1;
+
 	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
 	if (!bus)
 		goto failed;
@@ -328,8 +336,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 		virtfn->resource[i].name = pci_name(virtfn);
 		virtfn->resource[i].flags = res->flags;
 		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
+		shift = 1;
+		shift = virtfn_get_shift(dev, iov->num_VFs, i);
 		virtfn->resource[i].start = res->start + size * id;
-		virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
+		virtfn->resource[i].end = virtfn->resource[i].start + (size >> (shift - 1)) - 1;
 		rc = request_resource(res, &virtfn->resource[i]);
 		BUG_ON(rc);
 	}
@@ -680,12 +690,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	msleep(100);
 	pci_cfg_access_unlock(dev);
 
+	iov->num_VFs = nr_virtfn;
 	rc = sriov_add_vfs(dev, initial);
 	if (rc)
 		goto err_pcibios;
 
 	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
-	iov->num_VFs = nr_virtfn;
 
 	return 0;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3d60cabde1a1..befc67a280eb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -603,6 +603,21 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 }
 #endif
 
+struct virtfn_get_shift_methods {
+	u16 vendor;
+	u16 device;
+	u16 (*get_shift)(struct pci_dev *dev, u16 arg, int arg2);
+};
+
+#ifdef CONFIG_PCI_QUIRKS
+u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2);
+#else
+static inline u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2)
+{
+	return (u16)1;
+}
+#endif
+
 #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
 int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 			  struct resource *res);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index da829274fc66..3466738c1c54 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4085,6 +4085,43 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 	return -ENOTTY;
 }
 
+static u16 resize_vf_bar0(struct pci_dev *dev, u16 num_VFs, int bar_num)
+{
+	u16 shift = 1;
+
+	if (bar_num == 0) {
+		while ((1 << shift) <= num_VFs)
+			shift += 1;
+	}
+	pci_info(dev, "with %d VFs, VF BAR%d get shift: %d\n", num_VFs, bar_num, shift);
+	return shift;
+}
+
+static const struct virtfn_get_shift_methods virtfn_get_shift_methods[] = {
+	{ PCI_VENDOR_ID_ATI, 0x73a1, resize_vf_bar0},
+	{ 0 }
+};
+
+/*
+ * Get shift num to calculate SR-IOV device BAR. Sometimes the BAR size for
+ * SR-IOV device is too large and we want to calculate the size to define
+ * the end of virtfn.
+ */
+u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2)
+{
+	const struct virtfn_get_shift_methods *i;
+
+	for (i = virtfn_get_shift_methods; i->get_shift; i++) {
+		if ((i->vendor == dev->vendor ||
+		     i->vendor == (u16)PCI_ANY_ID) &&
+		    (i->device == dev->device ||
+		     i->device == (u16)PCI_ANY_ID))
+			return i->get_shift(dev, arg1, arg2);
+	}
+
+	return (u16)1;
+}
+
 static void quirk_dma_func0_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 0)
-- 
2.25.1

