Return-Path: <linux-pci+bounces-5482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44410893C7F
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 17:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7531F22385
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9BA45948;
	Mon,  1 Apr 2024 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kAXEwxg9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8C0446A1;
	Mon,  1 Apr 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983749; cv=fail; b=UU3vGFC/W7yz2MmreAvlM53JXIo+yY791rrCcrsKJLpBdTmXLZ0WnU6gxdc/c4DfPanfUm+X96Kp4dXQR39nJk/WbIgcueG9DYbp5wzmx0HanLjmugDpAipo5/RxTlohq6K7Skowjr1fHB/vnZWgsLFVqOtVWXFQ9RT5rAqcXdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983749; c=relaxed/simple;
	bh=EZpogD/eoxUMLJyn5WFz78yyy+XeY1RWiHMP2Mkxd2g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SQmiFrcnstm4i/5mMMcst+QJzCLi1TfHiqFpeTjBj1XOgknsYSQTo317qvRH6vW471B3/Jw78t1+yY3GB/Ext7EhNJXpMWFHhTS8T8RmtOSjfJGn1OsEOBv5OoZjkuqbK8pMhB424Wvv9K99dFCHnYpIxp5qCr72+rByag3OKQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kAXEwxg9; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADfnp2JZqI52Y7/bnAgGyj7deb+u2Dh/TVFz390dGafdQAzCzzz9YS/pFByeux9APcN21WdRNtrEEdeI7ROdqzmi1Xj/qajx/YwvrZedy9z8uBJjAL806I9ArtHvp7IcnryR7DfY35tq8txnoUD52NKrT3Kb1dwktlT4rKH3Cx3W7iCcI4Bi8hoHNT6Y+1X4OWHetvJbWJQ7CqHeyeNhEHvQS8wypIhKHOIEDwFkCHTNHSM7W3rH9Fi8iDs+umYbw8h7MTJov/doGkFxtKcDwVWnpsleMe7qMfwNDoWIfuYwcWd+so+1piJZNbvG2HDsnUDe3jEW0xoT/SMEB52xAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDvYaaUMBBjACilIuCAz9pXoEFE+UkUyz3Pi+d3wmww=;
 b=EUn8JQ2J+6ZeGsT0I6JQFxnxs2fHOT9QmzK/8p8U+Sg9H0MkJ1T9TqIAHZRNHpHXRtKuZs7gSDgKBBlQJ9RlX3ZV6le50mBqr4JQ8JIS19BeQgZTeHud8m75RU5GRhl6NK72UJPqZdyrep3QQk4AHpFdMwTjg9foaW5umBUDTwHibF9Fub47tSlG2ERxMvAHFFZNhbmJtRyJoP1KUVD6gF9XbgGOya6s4Za8yqmf0DMVl1dPm0yrMntTwYXTgXEm03PLBTIKxc0Gy6CnFNWQA03+gMnrT8j7nHKWqLNotzMola2nJWKd+1Qg0VOFS0/C9YQp1YUaKuIV4yohhXxwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDvYaaUMBBjACilIuCAz9pXoEFE+UkUyz3Pi+d3wmww=;
 b=kAXEwxg9BgHBcc+QW12Zl2+7CSTgPAjoNwI/tfTc9qs0bzbFJr/5f8mrexhB5vrqpQfvjZx7uV+atkhABW56A8UorU6RsbgtR7Qqj6w24axzw5aQEZu5dSf/yJ063OuI0qPY6Z405uQ6zeR3xsEnkgXuZjaRoS3UmrgD8ajc5lW7h5i2B6WFWlwq99uvH1ueH8/+tHl6XyeJ9CH3N0Z9T5l/XKEP0WBs/pabXC0jusmnJ2SQKfg2hua/qOvBmcPpZFWFXnDLFGPh3gg9Bi8KF+ZPsTFVrcMqkQ+Od4lRFNZK9EvV+tfYXSqz0JzFXxj/uiDe5KRARkHgtic0RImRIA==
Received: from MW4PR04CA0328.namprd04.prod.outlook.com (2603:10b6:303:82::33)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 15:02:21 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::70) by MW4PR04CA0328.outlook.office365.com
 (2603:10b6:303:82::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 15:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 15:02:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 1 Apr 2024
 08:01:23 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 1 Apr
 2024 08:01:23 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 1 Apr 2024 08:01:19 -0700
From: Vidya Sagar <vidyas@nvidia.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1] PCI: tegra194: Fix probe path for Endpoint mode
Date: Mon, 1 Apr 2024 20:31:16 +0530
Message-ID: <20240401150116.298069-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 875855e6-253a-4452-fa3a-08dc525cba34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GC0di54ZIqPnpU6D/+b0qSjsp+YiTAY/cEWbmmcubKUyweWFr+dduR9f6NwK3v9asDjlQEA3tDKlA9N2IyaKcZisM40L/+wyBRZR0/auLJYn4NqymizEGB/+xJ4IpCSIor4ZJMftG17wVR0owlvma+Cd8xLglfYuLAMc9ldm0RwqBdSg7OcBd3sGIrdzZi6E28B+zIrZ3xWIDF3/1LzSpWH7fDEJMGO2TcffehtkDdsiYmb3jO3vOIsfCqBkmNJoMH0WANkv7iZiFnfR3tuj+TRR+nGV2S0ahRzoobvTqrh6a37kO+p0tKVFKAj5y/XvXcuFFtN0L2ixPLFdoTgpaSvQQKICx7u9q+dTVgdGRinzPd4fUOuT2y9TrYM6ONDXaUjz4VyeNhTEC8nycE/kaKxEFctgAszYiu4EToucBazEH/2OyluTSpsdfTkjVM/OtxDBxfCMqV7CQ0dZFPOHFrEw1tXIwFmm4abR1xHO9+14Q80B8tF3JXe8Ab53vNpUrSrHPln4DkI5DHpx2CanyBh+LHZJvdnY21KUWpvD4VHTyMeh2czmexRa93+KH3K525LkW9PL2AFR2hYimzscgDMRTLTGmnq4p9YdueWg50tXVIu/I0P0hR2EuwqiBQlN0O09WNPu811N4ptvDZrs7R80CtMRZsvM7ZL54Ry05edf5U38dFxNKsCyYXkN3pSYKzEw1FF9bvi+/vJ2AQLG5J5u/utQtkucrDaYhyESnGvJfAI860hNcmqtwou/AUFG
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 15:02:19.3333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875855e6-253a-4452-fa3a-08dc525cba34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599

Tegra194 PCIe probe path is taking failure path in success case for
Endpoint mode. Return success from the switch case instead of going
into the failure path.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4bba31502ce1..1a8178dc899a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2273,11 +2273,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		ret = tegra_pcie_config_ep(pcie, pdev);
 		if (ret < 0)
 			goto fail;
+		else
+			return 0;
 		break;
 
 	default:
 		dev_err(dev, "Invalid PCIe device type %d\n",
 			pcie->of_data->mode);
+		ret = -EINVAL;
 	}
 
 fail:
-- 
2.25.1


