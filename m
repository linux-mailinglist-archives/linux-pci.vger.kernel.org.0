Return-Path: <linux-pci+bounces-13245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D0697A875
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 22:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B041C26E9A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 20:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2E515FCE5;
	Mon, 16 Sep 2024 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OpVGUKU5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76A15B97E;
	Mon, 16 Sep 2024 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726519891; cv=fail; b=AkD2ynp/fH2DUtYt4E4umoNI+DMOyA21NTQ/1xFIeJqWD4wD5GhuoUZI4OIX194VwDcLcAqm4XpRFYhDWtVIbg/vfeJm4RBwxjYHTSqeaH3NCcGVNajka0raxchkIUTHR92EX8YXLUvbL4Yuz56mqDG6FMPKklZ5ySJRPDM3TrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726519891; c=relaxed/simple;
	bh=4xz4L5cHBRS4/lfXuu69Vf2gDGFi7Km1EFzSkNcZPXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVJbzikGzKHpxrnGsAOJ1zGn3mLW4GEw5VoJWsprbhWWsIw52DAEG2NCmvi6GT1dPC8jB11Qxgv22zo8PyPWlMvBEhE5kyNcj5aRWRGMz7UVGUXnpI+GCdOy7zbNQ5G+suR1Jw5LvhCQRgfgSK3SjZ1noxZniG9+Vzpkuh7oZUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OpVGUKU5; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9NuttBZJ99cMUBH0LL+BQKWIqpyN6gbwiE72fCU0Ow0VucjeoJ8Cx+XSUB9hUsZ9XSQPzxmMXTagdGFB5o8LvLpxhVosW2CfPV4iMoWWfMBuzmmL82FHA8Jmt8EAABLMI7Clinh3sHwwd+GAmkpE4T/RrAaX4oUw4Dye3Ss3F48aXrd0dCWy+KH4RrHTi+cGIwBI4CHVT0uKrt+DPUomSaFjGV1JK5gWfCBmwHxac3VVc0t7dCY1zj20z0lklPW2Io2zQE60htREu7s+T9kS+tDlJTNF2gYZP+3yH5WQx11B1XEtdICi6z6ZH/8Dz1XcJURwZnu/XYn+DE448mpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKtIvIccbUe2ws4r9L6LxZKPzp9wEujUe/XQAHI58Kk=;
 b=Am8YbnfpqvAPnq3fvGR/7ajWv7WTDuP5AfmK54P759jfP35R4a0y3t76DgW32dELurtMVegKsXkaEvBoSeT9G28dMKLwf0RSdT6FLTgdixkzM74/7TjYOGx8eKMVLCQyudhJ5T9foItqBZfBBcsHFBChmFAvBs+KNof5kS2UQuEvT3p9vFcDJYEW0PWGWkKYjpHud3TX1bBuFmodeJB+ILQHhYMnJd1vBZ5Vd81lIcoPT/4ooyP5V38CQjS6Ja7jT6LBVbrWlTKt3mH3haS4jU+8MQjSBeIP5N2W2TZcTbyTuxQElaju5IBPpQ+E6AAdmJrSl1OSE1ScJYACJ2GIWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKtIvIccbUe2ws4r9L6LxZKPzp9wEujUe/XQAHI58Kk=;
 b=OpVGUKU5Ix5OvXOplki4L+FwFHrTgKsOHTloXEvTG3jXHJwtnY39cuS6ypVaS4De5YD2KKNwBLszX3DdHWTT2kqBYB5poDfzHTzC4JTTDQiF49pNLPFhztUbwsmhdDG2YXwhjUEUjJ1uSwv9F3IMtmymTPa21rc7FXbrkCxlS2Y=
Received: from BN0PR10CA0014.namprd10.prod.outlook.com (2603:10b6:408:143::12)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 20:51:22 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::f5) by BN0PR10CA0014.outlook.office365.com
 (2603:10b6:408:143::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.29 via Frontend
 Transport; Mon, 16 Sep 2024 20:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 20:51:22 +0000
Received: from weiserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 15:51:20 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alex.williamson@redhat.com>, <gospo@broadcom.com>,
	<michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
	<somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>, <wei.huang2@amd.com>,
	<vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
	<bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
	<jing2.liu@intel.com>
Subject: [PATCH V5 1/5] PCI: Add TLP Processing Hints (TPH) support
Date: Mon, 16 Sep 2024 15:50:59 -0500
Message-ID: <20240916205103.3882081-2-wei.huang2@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240916205103.3882081-1-wei.huang2@amd.com>
References: <20240916205103.3882081-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e90af6c-b233-4b8b-7c58-08dcd69152a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xbT80MeEVJhZPzyBDonYngnLtNnwTp9ytPc8/y6NW63xmWxjLLPFXU4zFv7H?=
 =?us-ascii?Q?Gbj5mf9fRUbuLtHvTxt4SbfF1tXUdd761BfXCBq8Olu2PmaCRdOUHLv/uxg3?=
 =?us-ascii?Q?jXaG4jo8kPCB1l0m7U4LIld5UiYI2m6LhhxC43EVv89i09zZhh5CtpshPNcN?=
 =?us-ascii?Q?uV9/7Z1YiAGf1ZBQjl22Jdnc75EeT9kYHHWdHCwn4tUkWE/VpqpyDpLsZGpZ?=
 =?us-ascii?Q?xv+xfbyqBGaFcSojqQXtuoYjeGfEX6wFh6ECKvEOYwaG2nwGojI/kxBV50Oq?=
 =?us-ascii?Q?7Xy+1nboSRM7PBlEpf4JyOjzTaZjl9p8Q5YkAK4lXlyID6aeOt4+twZHqv6X?=
 =?us-ascii?Q?gkJx3ot9esDkqJXKwGYqsC3jI+I7OaFf9SWN9YTeJhKzSz7vGdZQi4zjA9qf?=
 =?us-ascii?Q?flklmwYcWqwnufmIjMa7VCr3gfjPbvu+0bdQ8yeYjEDzndq/Jb+FaisAbNdB?=
 =?us-ascii?Q?zebZFL2YEwixd+r8xpRVlc0iBJImlRbeWcpnjDBqRXBnOFRX23jXuZs97/0t?=
 =?us-ascii?Q?zj4Sop9GyjpJ72jz+MJyPTFd4Yaf/7worZbMmOJgVLSiUwofKWvyJBLQazNI?=
 =?us-ascii?Q?dr5++zE2TJNli69T6gBqHCwODg4+gVEn9GOruVL4H3l6uwh0Qzj8jy8lNG16?=
 =?us-ascii?Q?QjX68V0ZtmpfwbojcOP6TzZXdt4H3FBlNqe8HMmMBw3rwdJFbs9/p2w1yca0?=
 =?us-ascii?Q?U2S2hF59gmB4adfvB3lOvJbEiEjUvIe+IBY+I5usGnuqTlg2PbwXNfGkBURP?=
 =?us-ascii?Q?1qCbO0LLMEJaFv+8Pm+AOwbxO4NA7Q9jMepaEWBDFV4ggVraoHBnQ6CEjhsy?=
 =?us-ascii?Q?j5v9/MrKM0ydM048A/vG/q8rK/7f0bPZ8etQqsX+YrXIYZCfw5XquTZ33/qo?=
 =?us-ascii?Q?EhikdlYezzgS0r7635sc6eBBXEdIVAQ3F7RkSpCo18Of6Gupejy/FDQoR1Yd?=
 =?us-ascii?Q?My+q6viRB5K7ZJB4h0PA0s1zjFlHsk4PFLPi8cjjwC4+JqV/k0AGTTSAMtVX?=
 =?us-ascii?Q?OfEirl+qbHJFHrgw+/h0xpx95o20ljUlpSpup8FfsqQTQXVRJ1KATcMuhhzW?=
 =?us-ascii?Q?neDir8h/NBFxCOEIykP72v+GuHYZJLU8zbnFtdW3x2mP6X/mchXFzC17qJO7?=
 =?us-ascii?Q?YMf94Au2gUUxKnPv8ZOc38GR82FKYqdahezObuA9iQUANjo85So2rKf8N/ic?=
 =?us-ascii?Q?A3Ovog9br1gAdWGhRnzcilIaqSwrbHSP3hwcTSS3gLd5xI6ndTrqAmzv2xOC?=
 =?us-ascii?Q?eWfj5+ajl1uHugmDzFUmNgoCM0R5H2rLN5pg95PlFbQOP6wCx6eDFsYvqzBX?=
 =?us-ascii?Q?TFID8qWSO6TiRMXZIiqjOrN7Kx8KI6Qi2WoZFzLIr7ILiivMxw/+kgokwqem?=
 =?us-ascii?Q?8b4BCAMJL4657q0icCYR2DEMqrmp5FqVO8Li3yPcfp4EXC/TSjTxzUUve4r3?=
 =?us-ascii?Q?J2ZS9Y0uSUQ8ZGoKTUpCeYyVGY4PnFPV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 20:51:22.2643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e90af6c-b233-4b8b-7c58-08dcd69152a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253

Add support for PCIe TLP Processing Hints (TPH) support (see PCIe r6.2,
sec 6.17).

Add missing TPH register definitions in pci_regs.h, including the TPH
Requester capability register, TPH Requester control register, TPH
Completer capability, and the ST fields of MSI-X entry.

Introduce pcie_enable_tph() and pcie_disable_tph(), enabling drivers to
toggle TPH support and configure specific ST mode as needed. Also add a
new kernel parameter, "pci=notph", allowing users to disable TPH support
across the entire system.

Co-developed-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
 .../admin-guide/kernel-parameters.txt         |   4 +
 drivers/pci/pci.c                             |   4 +
 drivers/pci/pci.h                             |  12 ++
 drivers/pci/pcie/Kconfig                      |  11 +
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/tph.c                        | 199 ++++++++++++++++++
 drivers/pci/probe.c                           |   1 +
 include/linux/pci-tph.h                       |  21 ++
 include/linux/pci.h                           |   7 +
 include/uapi/linux/pci_regs.h                 |  38 +++-
 10 files changed, 290 insertions(+), 8 deletions(-)
 create mode 100644 drivers/pci/pcie/tph.c
 create mode 100644 include/linux/pci-tph.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..8579d0fbcd33 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4617,6 +4617,10 @@
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
 				one PCI domain per PCI function
+		notph		[PCIE] If the PCIE_TPH kernel config parameter
+				is enabled, this kernel boot option can be used
+				to disable PCIe TLP Processing Hints support
+				system-wide.
 
 	pcie_aspm=	[PCIE] Forcibly enable or ignore PCIe Active State Power
 			Management.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ffaaca0978cb..b6f60f7476cc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1813,6 +1813,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
+	pci_save_tph_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1917,6 +1918,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_vc_state(dev);
 	pci_restore_rebar_state(dev);
 	pci_restore_dpc_state(dev);
+	pci_restore_tph_state(dev);
 	pci_restore_ptm_state(dev);
 
 	pci_aer_clear_status(dev);
@@ -6869,6 +6871,8 @@ static int __init pci_setup(char *str)
 				pci_no_domains();
 			} else if (!strncmp(str, "noari", 5)) {
 				pcie_ari_disabled = true;
+			} else if (!strncmp(str, "notph", 5)) {
+				pci_no_tph();
 			} else if (!strncmp(str, "cbiosize=", 9)) {
 				pci_cardbus_io_size = memparse(str + 9, &str);
 			} else if (!strncmp(str, "cbmemsize=", 10)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 79c8398f3938..8eeabbbfa137 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -571,6 +571,18 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 
 #endif /* CONFIG_PCI_IOV */
 
+#ifdef CONFIG_PCIE_TPH
+void pci_restore_tph_state(struct pci_dev *dev);
+void pci_save_tph_state(struct pci_dev *dev);
+void pci_no_tph(void);
+void pci_tph_init(struct pci_dev *dev);
+#else
+static inline void pci_restore_tph_state(struct pci_dev *dev) { }
+static inline void pci_save_tph_state(struct pci_dev *dev) { }
+static inline void pci_no_tph(void) { }
+static inline void pci_tph_init(struct pci_dev *dev) { }
+#endif
+
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
 void pci_save_ptm_state(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 17919b99fa66..61e4bd16eaf1 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -155,3 +155,14 @@ config PCIE_EDR
 	  the PCI Firmware Specification r3.2.  Enable this if you want to
 	  support hybrid DPC model which uses both firmware and OS to
 	  implement DPC.
+
+config PCIE_TPH
+	bool "TLP Processing Hints"
+	depends on ACPI
+	default n
+	help
+	  This option adds support for PCIe TLP Processing Hints (TPH).
+	  TPH allows endpoint devices to provide optimization hints, such as
+	  desired caching behavior, for requests that target memory space.
+	  These hints, called Steering Tags, can empower the system hardware
+	  to optimize the utilization of platform resources.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index 6461aa93fe76..3542b42ea0b9 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_EDR)		+= edr.o
+obj-$(CONFIG_PCIE_TPH)		+= tph.o
diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
new file mode 100644
index 000000000000..1efd76c8dd30
--- /dev/null
+++ b/drivers/pci/pcie/tph.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TPH (TLP Processing Hints) support
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *     Eric Van Tassell <Eric.VanTassell@amd.com>
+ *     Wei Huang <wei.huang2@amd.com>
+ */
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/bitfield.h>
+#include <linux/msi.h>
+#include <linux/pci-tph.h>
+
+#include "../pci.h"
+
+/* System-wide TPH disabled */
+static bool pci_tph_disabled;
+
+static u8 get_st_modes(struct pci_dev *pdev)
+{
+	u32 reg;
+
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
+	reg &= PCI_TPH_CAP_ST_NS | PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS;
+
+	return reg;
+}
+
+/* Return device's Root Port completer capability */
+static u8 get_rp_completer_type(struct pci_dev *pdev)
+{
+	struct pci_dev *rp;
+	u32 reg;
+	int ret;
+
+	rp = pcie_find_root_port(pdev);
+	if (!rp)
+		return 0;
+
+	ret = pcie_capability_read_dword(rp, PCI_EXP_DEVCAP2, &reg);
+	if (ret)
+		return 0;
+
+	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
+}
+
+/**
+ * pcie_disable_tph - Turn off TPH support for device
+ * @pdev: PCI device
+ *
+ * Return: none
+ */
+void pcie_disable_tph(struct pci_dev *pdev)
+{
+	if (!pdev->tph_cap)
+		return;
+
+	if (!pdev->tph_enabled)
+		return;
+
+	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, 0);
+
+	pdev->tph_mode = 0;
+	pdev->tph_req_type = 0;
+	pdev->tph_enabled = 0;
+}
+EXPORT_SYMBOL(pcie_disable_tph);
+
+/**
+ * pcie_enable_tph - Enable TPH support for device using a specific ST mode
+ * @pdev: PCI device
+ * @mode: ST mode to enable. Current supported modes include:
+ *
+ *   - PCI_TPH_ST_NS_MODE: NO ST Mode
+ *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
+ *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
+ *
+ * Checks whether the mode is actually supported by the device before enabling
+ * and returns an error if not. Additionally determines what types of requests,
+ * TPH or extended TPH, can be issued by the device based on its TPH requester
+ * capability and the Root Port's completer capability.
+ *
+ * Return: 0 on success, otherwise negative value (-errno)
+ */
+int pcie_enable_tph(struct pci_dev *pdev, int mode)
+{
+	u32 reg;
+	u8 dev_modes;
+	u8 rp_req_type;
+
+	/* Honor "notph" kernel parameter */
+	if (pci_tph_disabled)
+		return -EINVAL;
+
+	if (!pdev->tph_cap)
+		return -EINVAL;
+
+	if (pdev->tph_enabled)
+		return -EBUSY;
+
+	/* Sanitize and check ST mode comptability */
+	mode &= PCI_TPH_CTRL_MODE_SEL_MASK;
+	dev_modes = get_st_modes(pdev);
+	if (!((1 << mode) & dev_modes))
+		return -EINVAL;
+
+	pdev->tph_mode = mode;
+
+	/* Get req_type supported by device and its Root Port */
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
+	if (FIELD_GET(PCI_TPH_CAP_EXT_TPH, reg))
+		pdev->tph_req_type = PCI_TPH_REQ_EXT_TPH;
+	else
+		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
+
+	rp_req_type = get_rp_completer_type(pdev);
+
+	/* Final req_type is the smallest value of two */
+	pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
+
+	if (pdev->tph_req_type == PCI_TPH_REQ_DISABLE)
+		return -EINVAL;
+
+	/* Write them into TPH control register */
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
+
+	reg &= ~PCI_TPH_CTRL_MODE_SEL_MASK;
+	reg |= FIELD_PREP(PCI_TPH_CTRL_MODE_SEL_MASK, pdev->tph_mode);
+
+	reg &= ~PCI_TPH_CTRL_REQ_EN_MASK;
+	reg |= FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, pdev->tph_req_type);
+
+	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
+
+	pdev->tph_enabled = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(pcie_enable_tph);
+
+void pci_restore_tph_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	if (!pdev->tph_cap)
+		return;
+
+	if (!pdev->tph_enabled)
+		return;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
+	if (!save_state)
+		return;
+
+	/* Restore control register and all ST entries */
+	cap = &save_state->cap.data[0];
+	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, *cap++);
+}
+
+void pci_save_tph_state(struct pci_dev *pdev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	if (!pdev->tph_cap)
+		return;
+
+	if (!pdev->tph_enabled)
+		return;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_TPH);
+	if (!save_state)
+		return;
+
+	/* Save control register */
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, cap++);
+}
+
+void pci_no_tph(void)
+{
+	pci_tph_disabled = true;
+
+	pr_info("PCIe TPH is disabled\n");
+}
+
+void pci_tph_init(struct pci_dev *pdev)
+{
+	u32 save_size;
+
+	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
+	if (!pdev->tph_cap)
+		return;
+
+	save_size = sizeof(u32);
+	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..c74adcdee52b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2498,6 +2498,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
 	pci_doe_init(dev);		/* Data Object Exchange */
+	pci_tph_init(dev);		/* TLP Processing Hints */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
new file mode 100644
index 000000000000..58654a334ffb
--- /dev/null
+++ b/include/linux/pci-tph.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TPH (TLP Processing Hints)
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ *     Eric Van Tassell <Eric.VanTassell@amd.com>
+ *     Wei Huang <wei.huang2@amd.com>
+ */
+#ifndef LINUX_PCI_TPH_H
+#define LINUX_PCI_TPH_H
+
+#ifdef CONFIG_PCIE_TPH
+void pcie_disable_tph(struct pci_dev *pdev);
+int pcie_enable_tph(struct pci_dev *pdev, int mode);
+#else
+static inline void pcie_disable_tph(struct pci_dev *pdev) { }
+static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
+{ return -EINVAL; }
+#endif
+
+#endif /* LINUX_PCI_TPH_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..6f05deb6a0bf 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -433,6 +433,7 @@ struct pci_dev {
 	unsigned int	ats_enabled:1;		/* Address Translation Svc */
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
+	unsigned int	tph_enabled:1;		/* TLP Processing Hints */
 	unsigned int	is_managed:1;		/* Managed via devres */
 	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
 	unsigned int	needs_freset:1;		/* Requires fundamental reset */
@@ -530,6 +531,12 @@ struct pci_dev {
 
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
+
+#ifdef CONFIG_PCIE_TPH
+	u16		tph_cap;	/* TPH capability offset */
+	u8		tph_mode;	/* TPH mode */
+	u8		tph_req_type;	/* TPH requester type */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 94c00996e633..25af1976953c 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -340,7 +340,9 @@
 #define PCI_MSIX_ENTRY_UPPER_ADDR	0x4  /* Message Upper Address */
 #define PCI_MSIX_ENTRY_DATA		0x8  /* Message Data */
 #define PCI_MSIX_ENTRY_VECTOR_CTRL	0xc  /* Vector Control */
-#define  PCI_MSIX_ENTRY_CTRL_MASKBIT	0x00000001
+#define  PCI_MSIX_ENTRY_CTRL_MASKBIT	0x00000001  /* Mask Bit */
+#define  PCI_MSIX_ENTRY_CTRL_ST_LOWER	0x00ff0000  /* ST Lower */
+#define  PCI_MSIX_ENTRY_CTRL_ST_UPPER	0xff000000  /* ST Upper */
 
 /* CompactPCI Hotswap Register */
 
@@ -657,6 +659,7 @@
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
+#define  PCI_EXP_DEVCAP2_TPH_COMP_MASK	0x00003000 /* TPH completer support */
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
@@ -1020,15 +1023,34 @@
 #define  PCI_DPA_CAP_SUBSTATE_MASK	0x1F	/* # substates - 1 */
 #define PCI_DPA_BASE_SIZEOF	16	/* size with 0 substates */
 
+/* TPH Completer Support */
+#define PCI_EXP_DEVCAP2_TPH_COMP_NONE		0x0 /* None */
+#define PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY	0x1 /* TPH only */
+#define PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH	0x3 /* TPH and Extended TPH */
+
 /* TPH Requester */
 #define PCI_TPH_CAP		4	/* capability register */
-#define  PCI_TPH_CAP_LOC_MASK	0x600	/* location mask */
-#define   PCI_TPH_LOC_NONE	0x000	/* no location */
-#define   PCI_TPH_LOC_CAP	0x200	/* in capability */
-#define   PCI_TPH_LOC_MSIX	0x400	/* in MSI-X */
-#define PCI_TPH_CAP_ST_MASK	0x07FF0000	/* ST table mask */
-#define PCI_TPH_CAP_ST_SHIFT	16	/* ST table shift */
-#define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
+#define  PCI_TPH_CAP_ST_NS	0x00000001 /* No ST Mode Supported */
+#define  PCI_TPH_CAP_ST_IV	0x00000002 /* Interrupt Vector Mode Supported */
+#define  PCI_TPH_CAP_ST_DS	0x00000004 /* Device Specific Mode Supported */
+#define  PCI_TPH_CAP_EXT_TPH	0x00000100 /* Ext TPH Requester Supported */
+#define  PCI_TPH_CAP_LOC_MASK	0x00000600 /* ST Table Location */
+#define   PCI_TPH_LOC_NONE	0x00000000 /* Not present */
+#define   PCI_TPH_LOC_CAP	0x00000200 /* In capability */
+#define   PCI_TPH_LOC_MSIX	0x00000400 /* In MSI-X */
+#define  PCI_TPH_CAP_ST_MASK	0x07FF0000 /* ST Table Size */
+#define  PCI_TPH_CAP_ST_SHIFT	16	/* ST Table Size shift */
+#define PCI_TPH_BASE_SIZEOF	0xc	/* Size with no ST table */
+
+#define PCI_TPH_CTRL		8	/* control register */
+#define  PCI_TPH_CTRL_MODE_SEL_MASK	0x00000007 /* ST Mode Select */
+#define   PCI_TPH_ST_NS_MODE		0x0 /* No ST Mode */
+#define   PCI_TPH_ST_IV_MODE		0x1 /* Interrupt Vector Mode */
+#define   PCI_TPH_ST_DS_MODE		0x2 /* Device Specific Mode */
+#define  PCI_TPH_CTRL_REQ_EN_MASK	0x00000300 /* TPH Requester Enable */
+#define   PCI_TPH_REQ_DISABLE		0x0 /* No TPH requests allowed */
+#define   PCI_TPH_REQ_TPH_ONLY		0x1 /* TPH only requests allowed */
+#define   PCI_TPH_REQ_EXT_TPH		0x3 /* Extended TPH requests allowed */
 
 /* Downstream Port Containment */
 #define PCI_EXP_DPC_CAP			0x04	/* DPC Capability */
-- 
2.45.1


