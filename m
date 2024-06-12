Return-Path: <linux-pci+bounces-8648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C90D904E61
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 10:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8511D1F27D8A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117ED16D4FD;
	Wed, 12 Jun 2024 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h/hlYQsD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C0F16D4E2;
	Wed, 12 Jun 2024 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718181913; cv=fail; b=jkwB6/b8Yoq2VaF5dppZAP0vGnDvLD2Na24N4dJAP9THTq58HeNAfGCwDYxXyHR0wPbhW6LNiv9hwuFfgAwPFNN5IiIuHMkjxn4jdmQGohXOTPF7+ARzrJJwIRWivn1V2jSZYP2rLti0mknwPTJ33zHY3/Ed1opR6ZUIK/+deIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718181913; c=relaxed/simple;
	bh=8DvQRcXgNZ9vKxuQx3yVU8Z9Lx492kxWSfPkF6fVG/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zb0W7dm5W4zxSraQ4xEx0crhcW4UDW7IJxeK9K/TqR1aT3obi96/qwebhBLf8GtWVmX0f9WNgFZPiQ4od4YITaroGrrec4lyj1qrp56wPYvfdbEYECI5i3zA4WCnpadMxYANycvqBqRt6VMzmycwgzUWc4reCfVFbrzf8+omaes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h/hlYQsD; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDL5Z/JRESlXuWJ9Uu63u8gZS7T/iC4obNwLoonGRBMykKGem1IDjbhipvHAQSCbOermlxMEXdz+yFmWf/XxCLIw7AYouKRDWhq6+WwpUH1gFLfqK9aurXVcTy9a5LECMeamFvGz18iYcUihehKhSn3alNzLtyjXPHp73lpoPsB+MRLjxOC4vZUE58sETjYDptnEG0EFPAE7yhMDLXGbJqWDtnfpuk8nZ7Csget3xaERbzxQOabyE+vXTeArT28+7khhteHKMUyTCZQps8/K4bk8bzTahodw1vqcnihwRZOgniAtAmjgtXwUYRBOhlzheWmK6U4yYjYdKkb9FvDJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37ld/qa0yyFk2uQWcIG0Wym/rJ6+yOYPOgxR8FOOtrE=;
 b=IJUdhPNq7RwqUNU+wlVvDV/qoaE6DDH3ZHhTNRtPJL1YtOBb1h+M+s1OvdqAAMDfOMDu4RU97/iYvtUml/l182udLbL7+GSgjXpZITHmkNQlihVMGkB4DvlRhn4l3uqwYLaliR63jp8oF8mHx+ikk0hjWF8Eo0ePN2Wcq8FXtrvrLQyLrhJPZknnxZ9O6PY0pplZsN8+Z1czqChdRCeCH7/GI4Y32GZXMUQM5RhLFwuWjdhHYIT8hIW4eaJNwe75NKz1yQALWDd17kCkf+H7RxAlHXHZ72cYW8nlHJymLYRV4J4IP5nPyVkvwUk+hjngYPQlMrwJf2j3Re56PZZgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37ld/qa0yyFk2uQWcIG0Wym/rJ6+yOYPOgxR8FOOtrE=;
 b=h/hlYQsD/I45VqpsuDzzNekVTC71DFfPDrLv7sVTJAwt+TV4MR2qF3xYQ8f2UPHzLAd3W+HRV3IsZqB9EgsSRL74WpjJqnr9xv4Dt6lq7BjaZHRr1hgZzL4lRAmvNE6GwKBwcbqgOwTV5N4PHRBn6RegCy0EbxOFM+Z0WlefgiI=
Received: from DM6PR10CA0017.namprd10.prod.outlook.com (2603:10b6:5:60::30) by
 PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 08:45:08 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::2d) by DM6PR10CA0017.outlook.office365.com
 (2603:10b6:5:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Wed, 12 Jun 2024 08:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 08:45:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 03:45:06 -0500
Received: from sriov-ubuntu2204.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 12 Jun 2024 03:45:04 -0500
From: Lianjie Shi <Lianjie.Shi@amd.com>
To: <christian.koenig@amd.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>, <HaiJun.Chang@amd.com>, <Jerry.Jiang@amd.com>,
	<Andy.Zhang@amd.com>, <emily.deng@amd.com>, Lianjie Shi <Lianjie.Shi@amd.com>
Subject: [PATCH 1/1][v2] PCI: Support VF resizable BAR
Date: Wed, 12 Jun 2024 16:42:44 +0800
Message-ID: <20240612084244.2023254-2-Lianjie.Shi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612084244.2023254-1-Lianjie.Shi@amd.com>
References: <20240612084244.2023254-1-Lianjie.Shi@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Lianjie.Shi@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: bb874e66-2a88-49a1-b0b4-08dc8abbf68e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|36860700005|1800799016|376006|82310400018;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S0MPWtL+QtfyjBZFQKkjvRkm31G3O1uHAqUWBB2WiGX1gkV1YukHLddzpVl4?=
 =?us-ascii?Q?To03vkiUOQ5RSAh94gtJEqyUCxjovfCR/rZKQ1scsnA56mEp97zQCSbYQd28?=
 =?us-ascii?Q?F+Y+9lWY+y29iUuTa/B4VrztMRYLnm3CQxNRgYAAGGKk1coMDQ//kyg6hPQI?=
 =?us-ascii?Q?uzOcQq7vcxhX1JNOUO6M76hZcj44+oBCfdPhTRXkrhwXL6CV57tE8qKZthmm?=
 =?us-ascii?Q?hY5LepHjLfVtY1TAzJ60TYbi0+WFSRbKih7Onu0pVW58A94bECO610YSniAX?=
 =?us-ascii?Q?gOSJCNiX62/7LEFaRWkZKZpL8RBe5Avp+9hOxLjRdBFHEdht9XxrOGnCaEvv?=
 =?us-ascii?Q?EV2jpr0cmvmUTRzdD7T+QHXGn5/aTxPuwjcH4boydd6AjvFevmXhX1PrslJI?=
 =?us-ascii?Q?6rnBIDaVDq4ohfe6gTdePVoBsu+9Yg5/K1jmap34skkQPK3Ba6dYGsDpvXhL?=
 =?us-ascii?Q?cGCKgaI+VEAk5Zzm5iWbfOfdgrD6sPyPYNFPD45Y9BD2lrAWz5DhlAB5Sg/E?=
 =?us-ascii?Q?Kpr9cT5BCb1H/hrHUjckP6F9XIJQdk5SZLOUlLIxFPGqduxZqe41OKTlwViI?=
 =?us-ascii?Q?2+LDo+dbY1QkpKWMYnu5NeEwJ2dNPs+lHYXo5ZbaSDQMZ7/TEl9MVtR4MFAy?=
 =?us-ascii?Q?Gu96TtVbEe7nGKVLDLntp43Zs8P6RNmmyNDmmfWFCsj43tfC1xOeX8BRQ3mL?=
 =?us-ascii?Q?gkwmaKRdDuyTC+Jn6vLfvzBYrmDk5W9+W/qCz9iK7Y0q68+soa9PVAsI5T7w?=
 =?us-ascii?Q?D5dLJfMJ77GnC2RZDt1X2OdhCyjrZPdwSUfHkwntdbbNAeIg/0AkA9d23jMS?=
 =?us-ascii?Q?207lYOed/aeoEWHFWP5ifpPWn+++Kf0PzpnRoQd1+OefxoI+8M4/0h/Wjhdi?=
 =?us-ascii?Q?JnKmg5POV6oCMmpT2V0CPe+kQGjw5pwa/trgQ0kdqJQeVKxVEWms9kXTq1or?=
 =?us-ascii?Q?NvNdHEowtYOa2tDZSr51fzRK4SKn2//y443NSSi+e0WMte2GMnM0RZ3WJd6k?=
 =?us-ascii?Q?MI4c9mTKQ3tFuUYcRy9EGjIkcP9H4VwuI9ECKHK6OSKQyF1pEfY0hpIVHmoQ?=
 =?us-ascii?Q?y7ZkqrjFQ5NEawEkiPifwO4xlcuSgqy2OII1iMAWZMQ9m9wVpcH0N1OCy30W?=
 =?us-ascii?Q?0D8UMuReN7Zmnwg65CtG8oR7CMN4jgPHk1zxfqnQr0ZxMrRdAsbLBzOifhBK?=
 =?us-ascii?Q?Y4t1y8Nl5Mvlv1DUtlOq6UuEXx2nx5ZlZEQXvIqfePNzkpk/wnRWFVBPKZLH?=
 =?us-ascii?Q?S6YgYdXD/jnav6cNLVLXo282TzsaZ0JUue9k2SEkfAgv2VSUzeic9PdqsF0U?=
 =?us-ascii?Q?mNOCLQsvTcvBcBt5G1pFMDJrxujw7nKJtmjdYqketKPIz0PCXm4Ad4IJytI0?=
 =?us-ascii?Q?s7EQyto=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(36860700005)(1800799016)(376006)(82310400018);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 08:45:07.6862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb874e66-2a88-49a1-b0b4-08dc8abbf68e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140

Add support for VF resizable BAR PCI extended cap.
Similar to regular BAR, drivers can use pci_resize_resource() to
resize an IOV BAR. For each VF, dev->sriov->barsz of the IOV BAR is
resized, but the total resource size of the IOV resource should not
exceed its original size upon init.

Based on following patch series:
Link: https://lore.kernel.org/lkml/YbqGplTKl5i%2F1%2FkY@rocinante/T/

Signed-off-by: Lianjie Shi <Lianjie.Shi@amd.com>
---
 drivers/pci/pci.c             | 47 ++++++++++++++++++++++++++++++++++-
 drivers/pci/setup-res.c       | 45 +++++++++++++++++++++++++++------
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4..12f86e00a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1867,6 +1867,42 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 	}
 }
 
+static void pci_restore_vf_rebar_state(struct pci_dev *pdev)
+{
+#ifdef CONFIG_PCI_IOV
+	unsigned int pos, nbars, i;
+	u32 ctrl;
+	u16 total;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_VF_REBAR);
+	if (!pos)
+		return;
+
+	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
+
+	for (i = 0; i < nbars; i++, pos += 8) {
+		struct resource *res;
+		int bar_idx, size;
+		u64 tmp;
+
+		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
+		total = pdev->sriov->total_VFs;
+		if (!total)
+			return;
+
+		res = pdev->resource + bar_idx + PCI_IOV_RESOURCES;
+		tmp = resource_size(res);
+		do_div(tmp, total);
+		size = pci_rebar_bytes_to_size(tmp);
+		ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
+		ctrl |= FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
+		pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+	}
+#endif
+}
+
 /**
  * pci_restore_state - Restore the saved state of a PCI device
  * @dev: PCI device that we're dealing with
@@ -1882,6 +1918,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_ats_state(dev);
 	pci_restore_vc_state(dev);
 	pci_restore_rebar_state(dev);
+	pci_restore_vf_rebar_state(dev);
 	pci_restore_dpc_state(dev);
 	pci_restore_ptm_state(dev);
 
@@ -3677,10 +3714,18 @@ void pci_acs_init(struct pci_dev *dev)
  */
 static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
 {
+	int cap = PCI_EXT_CAP_ID_REBAR;
 	unsigned int pos, nbars, i;
 	u32 ctrl;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+#ifdef CONFIG_PCI_IOV
+	if (bar >= PCI_IOV_RESOURCES) {
+		cap = PCI_EXT_CAP_ID_VF_REBAR;
+		bar -= PCI_IOV_RESOURCES;
+	}
+#endif
+
+	pos = pci_find_ext_capability(pdev, cap);
 	if (!pos)
 		return -ENOTSUPP;
 
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index c6d933ddf..d978a2ccf 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -427,13 +427,32 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 }
 EXPORT_SYMBOL(pci_release_resource);
 
+static int pci_memory_decoding(struct pci_dev *dev, int resno)
+{
+	u16 cmd;
+
+#ifdef CONFIG_PCI_IOV
+	if (resno >= PCI_IOV_RESOURCES) {
+		pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_CTRL, &cmd);
+		if (cmd & PCI_SRIOV_CTRL_MSE)
+			return -EBUSY;
+		else
+			return 0;
+	}
+#endif
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	if (cmd & PCI_COMMAND_MEMORY)
+		return -EBUSY;
+
+	return 0;
+}
+
 int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 {
 	struct resource *res = dev->resource + resno;
 	struct pci_host_bridge *host;
 	int old, ret;
 	u32 sizes;
-	u16 cmd;
 
 	/* Check if we must preserve the firmware's resource assignment */
 	host = pci_find_host_bridge(dev->bus);
@@ -444,9 +463,9 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	if (!(res->flags & IORESOURCE_UNSET))
 		return -EBUSY;
 
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	if (cmd & PCI_COMMAND_MEMORY)
-		return -EBUSY;
+	ret = pci_memory_decoding(dev, resno);
+	if (ret)
+		return ret;
 
 	sizes = pci_rebar_get_possible_sizes(dev, resno);
 	if (!sizes)
@@ -463,19 +482,31 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	if (ret)
 		return ret;
 
-	res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
+#ifdef CONFIG_PCI_IOV
+	if (resno >= PCI_IOV_RESOURCES)
+		dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = pci_rebar_size_to_bytes(size);
+	else
+#endif
+		res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
 
 	/* Check if the new config works by trying to assign everything. */
 	if (dev->bus->self) {
 		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
-		if (ret)
+		if (ret && ret != -ENOENT)
 			goto error_resize;
 	}
 	return 0;
 
 error_resize:
 	pci_rebar_set_size(dev, resno, old);
-	res->end = res->start + pci_rebar_size_to_bytes(old) - 1;
+
+#ifdef CONFIG_PCI_IOV
+	if (resno >= PCI_IOV_RESOURCES)
+		dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = pci_rebar_size_to_bytes(old);
+	else
+#endif
+		res->end = res->start + pci_rebar_size_to_bytes(old) - 1;
+
 	return ret;
 }
 EXPORT_SYMBOL(pci_resize_resource);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a39193213..a66b90982 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -738,6 +738,7 @@
 #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
 #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
+#define PCI_EXT_CAP_ID_VF_REBAR	0x24	/* VF Resizable BAR */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
-- 
2.34.1


