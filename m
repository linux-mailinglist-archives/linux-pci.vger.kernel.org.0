Return-Path: <linux-pci+bounces-39615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC15BC18E7D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096501C86082
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924FE31A7F0;
	Wed, 29 Oct 2025 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RmXN51l+"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazhn15011020.outbound.protection.outlook.com [52.102.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2763D2FF171;
	Wed, 29 Oct 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725170; cv=fail; b=oBDDLOrWupG2kScuS8GRfZQA031x6Fm3RuakXdDXb3oVT0y5x/xdVab8ElKM9P7ZxFl3oQkgVjWCer3Jtl9onjntgwP+SRn2ZfPCPfKBjfJAIz+Cw7VEpvp8ADrkFhWNMQUXWQ/Pi8FgmydB7NtR2UfCN3cyjGD79HHRVCc1p00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725170; c=relaxed/simple;
	bh=M7bZK/+9ryFxTGYt4mjxLj8UwfD5GwPdYXo7/JJBzq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/+oiJdDp2cfje4FaZiT+3zSM12HFlaLh0+FxXzXrYS0beBOi2xmx6gJ8XF+L8IU32v/CF7pXmvZk6LyKZcioR6u5gnIdqTJEWTHNvv7/qYq85mO16KSwopQFp190CAfoVUu0PH9Yl27MhdlvH9bu+qEt9fRBe2QEzybzlzgFTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RmXN51l+; arc=fail smtp.client-ip=52.102.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buWigI3Djgpyvj3pDXqkeekQqxF7p7RUDzNMr3a+tfxyMPBkiKfJ51MSVY/Q1I7/mV+gHeuC6tBD7FNqHys0XVOzkaL1t/lTEtAQ63dEWB3ca94XZcKea4XDwrpydoWY5OzOKPsSA2TtWFbY2+KhRLbnnTWIpMFSUaUJmZKHGVb3WCOvORNNCEGSZSZb6eixzQMacgT/AytQCBGAkQOTP0TmhxFmOz00R3mwOmmFcwViZz/ue4ENA62ebPsGoap3KZudJGZ62ZUavR6NVTtYe71rQn2ZN2kIs05IpubdfLFuNi2YRWxlDpsyCIGa/JD4alUHwHgl/0kUl8IwPeRDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjJzJGX4vwMeFOqRERbz5QFgTGRliyrTF4Ms37svBoE=;
 b=xE3X9D6XQweiQnkv15TTF+0tJMKH/dqVntpItStTT/69qOqvwTK/i6OqRPVbE/6sDv860kZKhKkc2rNEbr2niNWjuNV9WxVFdOhv9iMvmRH0DlpRwyvtD5Jep2jUO6SVMn8ODNKPWt4g+nG11D0LgUuhkPEJtFCVQHBpXvxhofvvb/Uk8yfvwT63wR1OYgACXsw3FvAsz/mYqIYEBuMYWTFEs473WxIvD7IWtbRBKTDXWv2apri+3uqrLfeiCJVtvuBDh3m6b8SygMJwGUhT0TyuBsYN/5E/jHuhVcS9+6nuukmDTSysqQ/PXdWcfIUTOoxYXuWtVKsnnCZCZtRltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjJzJGX4vwMeFOqRERbz5QFgTGRliyrTF4Ms37svBoE=;
 b=RmXN51l+AXCHeJz5uqjjUhUNnEhO8A7FH8y57tXLYdXR04cQ4LOnNkmyBwB2D6zqiwss/FrStgs+LMbM/nKvTVHstVinQ6n8yaOGqSGW+70S8Q9qS8OsJ7MY3pmz/Avx/9JzETd9TNe0/rEtDMIj8JbGcIEtO5aUA+DKhvM1x/Q=
Received: from CH2PR11CA0004.namprd11.prod.outlook.com (2603:10b6:610:54::14)
 by SJ0PR10MB6375.namprd10.prod.outlook.com (2603:10b6:a03:484::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 08:06:03 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::7d) by CH2PR11CA0004.outlook.office365.com
 (2603:10b6:610:54::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 08:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:06:03 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:06:01 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:06:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 03:06:00 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59T85aXh3704660;
	Wed, 29 Oct 2025 03:05:55 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<christian.bruel@foss.st.com>, <krishna.chundru@oss.qualcomm.com>,
	<qiang.yu@oss.qualcomm.com>, <shradha.t@samsung.com>,
	<thippeswamy.havalige@amd.com>, <inochiama@gmail.com>, <fan.ni@samsung.com>,
	<cassel@kernel.org>, <kishon@kernel.org>, <18255117159@163.com>,
	<rongqianfeng@vivo.com>, <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 3/4] PCI: keystone: Exit ks_pcie_probe() for invalid mode
Date: Wed, 29 Oct 2025 13:34:51 +0530
Message-ID: <20251029080547.1253757-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029080547.1253757-1-s-vadapalli@ti.com>
References: <20251029080547.1253757-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SJ0PR10MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 9679a8f8-24fa-40df-b94c-08de16c2014c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|34020700016|36860700013|376014|7416014|82310400026|921020|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pysx0YqwSzSzoRaJoueQLlDtOnKq5+DkMehVFM+XMCgC7D6aELJNnLLqs72P?=
 =?us-ascii?Q?vqQXOAm1v4VnLPLewSQ7k6U08oCUuOoWXefkL6Y+DvA29buKa4SZVrcPtxMm?=
 =?us-ascii?Q?65kcZ8MaO3vAtc7YiIGggJ2Q3bsWFvq7+BZ4lx6JRHh60BcpSwVhgysUO368?=
 =?us-ascii?Q?WdowGLKsjg0KM0CeLtA+C052RahXgE8DXBit0ZYRX9JNzwbRYHPEKAQ6rvdp?=
 =?us-ascii?Q?1R4boPU/GSi+2MwaYOwfaOVi8QhsD81XG3cSgBuA+r5OeSF2HRNuc9RBjCk4?=
 =?us-ascii?Q?cPDhK+tUtoz88ies3YXx8zzgYUQvcCp5irZpUASsYBGazFdlRs1NFZEqjKgW?=
 =?us-ascii?Q?nwT+ylNlx/mV2Cel9prLnKodEcSbaNfxBpILqsJkoNps7R+OmIWaaFzPCZ+x?=
 =?us-ascii?Q?PyilyJF3EoU7W3o+Jj/PaYx/4ibsA+8jPkeVPao4yGU7iSDMfwOLCuQvGyKS?=
 =?us-ascii?Q?nCEBD44gV1v7CVLoUKjRHeKn724gPUgFDJMhDxpSs0etuWZpcgCp+m+CXoZ+?=
 =?us-ascii?Q?URgYJJL/L79WFru6ZKUwrM7coRpya1S/R+3SHUmggk/hkVnK1NBlt0UiYyJv?=
 =?us-ascii?Q?XrVrMgW8OTamFo7tMd5+0wGvmZdAjUjPH2ET7Lm5UXskPQZ+MFuFPKoeJEE/?=
 =?us-ascii?Q?cgfAYi7RbVa5dBlyIVMrHYWinaxBogTTc1/9JlEHAkFS5evyBGaiAQQ8DwYJ?=
 =?us-ascii?Q?pDkQBMf9CDSnUVuwgrRAWQaQoqinWxdGHh6NqwLGhxG8S0BzbHkgSdgHLbM0?=
 =?us-ascii?Q?AuCPCTedW0KpO2CDgR7nM5ePeoPUHf6xgfXF4eWp299XqmotCsg6xPin4Xk8?=
 =?us-ascii?Q?5cgMzN5T4+g2p9/MrWTeX3gT4OgItaA1p19CkU/3pTGQbtRphJC0Y/xjX16j?=
 =?us-ascii?Q?fbZ2lE3N/H0w+jhN9AKp3cXfMuI7r9pz01tTiwjDAPe5dpoa5jKENo0hQbKE?=
 =?us-ascii?Q?9IvobyjzoR9qn+HycXncA9k+zurLKdeoUAaETYC3wigE/DTeoypxZFzTvCma?=
 =?us-ascii?Q?tJQrXTtrErpKuIR/gELtkK8EipHDhIusEeWfIYbESZv3tNy1A9jwBRUKKQaK?=
 =?us-ascii?Q?Y6XWly2pYnNZlwquYHrkJL5DyZ0fOHzxs1anz5mvF6SEsJHQy3K3Dagdsn8B?=
 =?us-ascii?Q?8cXq51WrHbWpNtbTKTLD3LmJkIa/DI6TVscwTbaqs/5DcF5cXbdznkkbKiQx?=
 =?us-ascii?Q?dmsxUUcCcUJVvLMMxsGl0/ovxLL9woErboqIUevhvJA5RXGR8l1DKG02/kG4?=
 =?us-ascii?Q?Qi5AaPDZf55acAAXmWiFhyOI5CxJUjJB+IiA9mhbmG1B93TRqy2x3PUylC34?=
 =?us-ascii?Q?LBOlBYN/jUkwHCfSA90X2Vnn/mBS17Sx3VIo9Ms4f5sJx6ar6PtpZAW8w2Qz?=
 =?us-ascii?Q?Y04L+VwHAEDOlPgwuzCLzEvUmKRGUTr9cACFJw4RRQwe5TO3bknyzMNLrT+n?=
 =?us-ascii?Q?LnWB2UlXCE3BgrDTKy7G1ZnrYIQp6lrwIKPxL/fdUUp5q+KZ1+7z1pbNj9v7?=
 =?us-ascii?Q?rCQPHqA+kcdhjO/oXEujZSbyBm6GRpH5LMgR?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(34020700016)(36860700013)(376014)(7416014)(82310400026)(921020)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:03.3882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9679a8f8-24fa-40df-b94c-08de16c2014c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6375

Commit under Fixes introduced support for PCIe EP mode on AM654x platforms.
When the mode happens to be either "DW_PCIE_RC_TYPE" or "DW_PCIE_EP_TYPE",
the PCIe Controller is configured accordingly. However, when the mode is
neither of them, an error message is displayed but the driver probe
succeeds. Since this "invalid" mode is not associated with a functional
PCIe Controller, the probe should fail.

Fix the behavior by exiting "ks_pcie_probe()" with the return value of
"-EINVAL" in addition to displaying the existing error message when the
mode is invalid.

Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

NOTE: As stated in the v4 patch, although a Fixes tag has been added,
the patch doesn't have to be backported. Hence, 'stable' hasn't been
CCed on purpose.

v4:
https://lore.kernel.org/r/20251022095724.997218-4-s-vadapalli@ti.com/
No Changes since v4.

Regards,
Siddharth.

 drivers/pci/controller/dwc/pci-keystone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index eb00aa380722..25b8193ffbcf 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1337,6 +1337,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", mode);
+		ret = -EINVAL;
+		goto err_get_sync;
 	}
 
 	ks_pcie_enable_error_irq(ks_pcie);
-- 
2.51.0


