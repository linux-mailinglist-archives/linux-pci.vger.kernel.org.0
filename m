Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8B055424F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 07:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356838AbiFVFhQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 01:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354898AbiFVFhP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 01:37:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694036322;
        Tue, 21 Jun 2022 22:37:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+3Vxe+8b3hDb6Tr0XrnzHuuaY3zgU3+8y+i8j+C4FmGkRPSeHYUHNx/wSfobqNQl0tOTbiKX9sCGULFNBWxHm2SoIOiW4PSsZeOxa9g0aEenQE9xSsAzJ2/kvB6kUIHIF5QikKoKxRmLsSIK4QXKYSXzbaY+tsw2zsKd9mdOaj9fy2KQUXMsuvTCLnDCDcLopNWUMxwqbvRCT+Pv+AFavkmvAvXdDvZYRmEj/aOT7hXX/HCysE5/aXq16m4livYxI2LUSNT80LfwCNqzRNc0U9vDlFhRoRpRtQRDT7rbOF63dqfsP4sofRKEL7/M5FmPr8vGer6/xJonzPO26lCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEnJqEyI7ZUSs15iU237mZ5Juwxv0cyLmvzNO3JM0BI=;
 b=OHRVb532gwFcq9XnGWKzQNqjMPiSMjqkcx5woqr/hox/A7QXN4byq+fPGzzgAKrD264vZhNqMqPOee4yA0Bc8jTwF/pPYDSEGBp4oX8tSJLzC8lU85qKD1CiSrzR4Xw2jWBVas3yWYE9AApJYotqymLevLoFLOPkbSfsO7H4BIHTiFzLVihQ/CLyR+IKc+pzEdi4f4DvzTBM9JNIG0aYlKSCU4K4qmGTRRU624tDi4poRSWJJgWvhzhWMafkI6MuqJJ9jJx2fi7bNycRut0CALs3Uk6ONC2VgQmsiPrYR+ehUJsaKUuPDfdYf1ldkXNLo/sr5WsKufYD/jOl3qJ+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEnJqEyI7ZUSs15iU237mZ5Juwxv0cyLmvzNO3JM0BI=;
 b=UONH23QXRL2gjh2y2XkDPjyJX+26x5Qt536lgW5B7Oxu7KzjjbjGo5tpyv1aaaWDBEEwwVm/rjX86O5PgVi1QIi3ExODvYzpz3KE/RtmAqM2BPAcjvCybLChSfhjO6swVJcOLjk0mnxc5+bEDKdcdNe2Dd95tLVfwZ4XErliNNVOL429BcemZxvaFMeeQDDj5SeCAe9Z6A9WSa1MjwK3KAR90RfZBi5btxmeDV4Sf0sbBMalHldNoPXOe1PkS5ZBQQ2hBG44eSkU9DZpdNTGtGY0GxTP7O3jSepZ01+a0Bs1u+o4PbJ9+9TQHZgLncRudWEDrW4Y2qILQgDoB4l4pQ==
Received: from DS7PR03CA0133.namprd03.prod.outlook.com (2603:10b6:5:3b4::18)
 by MN2PR12MB2928.namprd12.prod.outlook.com (2603:10b6:208:105::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 05:37:13 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::ca) by DS7PR03CA0133.outlook.office365.com
 (2603:10b6:5:3b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18 via Frontend
 Transport; Wed, 22 Jun 2022 05:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Wed, 22 Jun 2022 05:37:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 22 Jun
 2022 05:37:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 21 Jun
 2022 22:37:11 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 21 Jun 2022 22:37:08 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <kishon@ti.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <nkristam@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1] PCI: endpoint: Register release() for EPC device
Date:   Wed, 22 Jun 2022 11:07:05 +0530
Message-ID: <20220622053705.3283-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 530fc9e7-ad3b-4bc2-8c90-08da5411427c
X-MS-TrafficTypeDiagnostic: MN2PR12MB2928:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2928771103F1E394167BCA6DB8B29@MN2PR12MB2928.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njF84xoOCgYT2sGvTR2+CtIOkWCLWmMOuypp0z041m9tpKuFsR784zlM3+UnOwIxn5Iv3WhvSg9nZK7Bf9q8VrjiU963BCEZc/onym2oo5PtxlrtLt0erX5XqYY6cRDSP2O0ka3AzziDlCai5PNzIILXBS5uzKkLt2eNo0pXm7pkUAv/NgbHOJ3DrhJHySJ2iKKuaA9YtDCVej4qPW1Lv4HDT/RtM75x8KlsEVbm1iWJ32iIm710s36YV+P8rOV4U2ELepRni0uh2apMHFGtLMJEaMWZxyBOEwomLw+QlIiZNt1PTMmSkSyMHLMJBkdc8kIBzbbW0+kUTz/5kkh0VRcZjv5d19tR/yfZ9jfCjgjIx+r5EZYWdgblDxjNU4DMRNBhc2QDsafHG3xjuUA5DM0ps+B8SbaYOUwSSJ6hvHkt75FXtG/W4BGCLDQ/zUhpRIiAMWgHppmVdkLT1elwMI0Z3DKME/4tHvqqU3VuPOja9tdTgtRc+PAUNwwB13sf+B6BzrM2VLOMgXL2ZqhIX6qSzYK6s/kB++MvOsm+tzdy6OYKk1VvAeThfj2ZLXUIBVZ8//NKf5dDLJ8A8ezzx9Bi3wj9e15bDFG7clVLQqjvFw5s0LTjICY2FY+UsJoGnbCRya2rIsAAKbE6Lahboy4DIC4uwUuozjZsUdwGePebVpMcWTpHJUd7gRoL92EBySrBVCYvR9HRduR4uVmV14BXDEdauJqoTHx8iS4rcqkM4+ibaNXSp6x9jvPRsH/M
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(40470700004)(36840700001)(70586007)(70206006)(45080400002)(316002)(86362001)(2906002)(36860700001)(8676002)(110136005)(54906003)(356005)(26005)(36756003)(8936002)(478600001)(2616005)(4326008)(41300700001)(186003)(82740400003)(82310400005)(83380400001)(47076005)(6666004)(426003)(336012)(5660300002)(7696005)(40460700003)(40480700001)(1076003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 05:37:13.1732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 530fc9e7-ad3b-4bc2-8c90-08da5411427c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2928
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Register a dummy release function to avoid the below spew
when the driver is unbinded for an endpoint device.

root@tegra-ubuntu:/sys/bus/platform/drivers/tegra194-pcie# echo "141a0000.pcie-ep" > unbind
[   55.802704] ------------[ cut here ]------------
[   55.802737] Device '141a0000.pcie-ep' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
[   55.802956] WARNING: CPU: 2 PID: 477 at /home/vidyas/y/mlt/kernel/drivers/base/core.c:2321 device_release+0x7c/0x90
[   55.831544] Modules linked in:
[   55.834781] CPU: 2 PID: 477 Comm: bash Not tainted 5.19.0-rc3-next-20220620-00001-ge53d3cc05d82 #17
[   55.844078] Hardware name: NVIDIA Jetson AGX Xavier Developer Kit (DT)
[   55.850675] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   55.857957] pc : device_release+0x7c/0x90
[   55.862265] lr : device_release+0x7c/0x90
[   55.866558] sp : ffff80000c24bab0
[   55.869965] x29: ffff80000c24bab0 x28: ffff0000872a5700 x27: 0000000000000000
[   55.877410] x26: 0000000000000000 x25: 0000000000000000 x24: ffff000080a946bc
[   55.884840] x23: ffff000080a946c0 x22: 0000000000000000 x21: ffff000083194400
[   55.892275] x20: ffff000082076000 x19: ffff00008203ec00 x18: ffffffffffffffff
[   55.899720] x17: 6620656220747375 x16: 6d20646e61206e65 x15: 62207473756d2064
[   55.907179] x14: 6e61206e656b6f72 x13: 6d20646e61206e65 x12: 6b6f726220736920
[   55.914651] x11: 2e7473722e746365 x10: 6a626f6b2f697061 x9 : 2d65726f632f6e6f
[   55.922132] x8 : ffff800009ff2e40 x7 : ffff80000c24b8b0 x6 : 00000000fffff1fc
[   55.929587] x5 : ffff0003fdf4ba08 x4 : 00000000fffff1fc x3 : ffff8003f44f1000
[   55.937033] x2 : ffff0000872a5700 x1 : 45c50f22e593f400 x0 : 0000000000000000
[   55.944501] Call trace:
[   55.947037]  device_release+0x7c/0x90
[   55.950995]  kobject_put+0x90/0x108
[   55.954797]  device_unregister+0x20/0x30
[   55.958877]  pci_epc_destroy+0x20/0x38
[   55.962908]  devm_pci_epc_release+0x10/0x18
[   55.967406]  release_nodes+0x3c/0x68
[   55.971121]  devres_release_all+0x8c/0xc8
[   55.975409]  device_unbind_cleanup+0x14/0x60
[   55.979951]  device_release_driver_internal+0x100/0x180
[   55.985508]  device_driver_detach+0x14/0x20
[   55.989968]  unbind_store+0xd8/0xf0
[   55.993732]  drv_attr_store+0x20/0x30
[   55.997639]  sysfs_kf_write+0x48/0x58
[   56.001489]  kernfs_fop_write_iter+0x118/0x1a0
[   56.006239]  new_sync_write+0xd0/0x190
[   56.010159]  vfs_write+0x1bc/0x390
[   56.013831]  ksys_write+0x64/0xf0
[   56.017483]  __arm64_sys_write+0x14/0x20
[   56.021567]  invoke_syscall+0x40/0xf8
[   56.025516]  el0_svc_common.constprop.3+0x6c/0xf8
[   56.030511]  do_el0_svc+0x28/0xc8
[   56.033920]  el0_svc+0x1c/0x58
[   56.036936]  el0t_64_sync_handler+0x94/0xb8
[   56.041049]  el0t_64_sync+0x15c/0x160
[   56.044652] ---[ end trace 0000000000000000 ]---

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 3bc9273d0a08..ae403aa54e72 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -746,6 +746,11 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(devm_pci_epc_destroy);
 
+static void pci_epc_nop_release(struct device *dev)
+{
+	dev_vdbg(dev, "%s\n", __func__);
+}
+
 /**
  * __pci_epc_create() - create a new endpoint controller (EPC) device
  * @dev: device that is creating the new EPC
@@ -779,6 +784,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	device_initialize(&epc->dev);
 	epc->dev.class = pci_epc_class;
 	epc->dev.parent = dev;
+	epc->dev.release = pci_epc_nop_release;
 	epc->ops = ops;
 
 	ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
-- 
2.17.1

