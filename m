Return-Path: <linux-pci+bounces-1643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B95B823A3B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 02:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA66F1F261EA
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 01:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3AAA2A;
	Thu,  4 Jan 2024 01:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uWqoZptu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085DA4C65;
	Thu,  4 Jan 2024 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYu9d6R2trY2vp4zkNoxLGj43leVrMde1M14VW8pC4LWir7MJ35KAWYYzWsm8jyq8cOMQWm/utG1Kf5m7nbgD/Iz0uEG0cKTCYRnOTZOwgSbstyTQyrPPF2QEZU3NjIiUDnpI+Dh1E8jgBpZW1k8C+cw7V1QEwKMNj0Ok0VggdUrMSnUGAf2jB9nNWhFi/lZBC1txF/QqbA4h8fDvi7KkNcFM7UOJdwezEv/jiRF3RRAsqTDsyawqJiYEULqF2ZhtMtmjXTzZK+0RUOzcwG9FYk+8+1XERSr+euBNGINlCluHM0GUGRDFfSR10DYDLI/WNW3FlsapsltEkc78Z2T2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EU6cB4aNCNMq6dBsAy+4eBunzy0Kw0LBh13HOFA8Dsk=;
 b=gda2VqMZj+A7TrLM5LGYa686vsy+v1o4vL4A12KwCuc+lvDQ6rfOu6MHenmIVOezwppi3y6o9Q7f0fM6Nn11Up/zrdvWCOcc59esYCGQzigqf+SWWVjdPBMlL1FYw7YT1uNNm59DIDTm2ZYwMzTXjWwnmZEYissKdm/IM4T/t1uRBjzWj8bxu+1ZZ+0+Y2WujkNAF+Vj0pua6+nao/F/J5mLA1aaKr62eU+Zc5/GxlII9TnBZ9+zW/1b81qYnwfu/lVXHdhrFrTu16rNclMN8MdNLZdsdsWNcLld+JkdDOuvammCFUKuDkban3Gis1+uMkAkTR+pr8aVPfCvvJH7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU6cB4aNCNMq6dBsAy+4eBunzy0Kw0LBh13HOFA8Dsk=;
 b=uWqoZptuaJvdiRWjjqE3MfplJHjsObEZyI1YP3CQ/4z6IuIM8p+Gf0AYwjxC6gsid3IkZn54aU2n5R37QlUvyX+4lvTID4FNcfgItl3nZjj2UqeQ2OLPvfwRRQ0YXaJecdIEMhF3FBvW/o1S7o5ykTs7jNgNhs/l8gPeYWE6+GM0h32ib0jcRQRhA3yEqn2MV8/X0BB520Zfd6tl3GF7q7/vrTVvlrVCVSKuWmrMWwIHoHvJZLq2QMio0RqoMWcdNHVQHbOGQcQxBHKVB56vBESA7htHVjOIFx0y8XuYtv9cKgyL9b5EK966GmYTGO4rV8/liDxHPRZaOajUiMVhOw==
Received: from BY3PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:254::21)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 01:32:43 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::c4) by BY3PR05CA0016.outlook.office365.com
 (2603:10b6:a03:254::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12 via Frontend
 Transport; Thu, 4 Jan 2024 01:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 01:32:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Jan 2024
 17:32:35 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Jan 2024
 17:32:35 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 3 Jan 2024 17:32:32 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V1] PCI: Clear errors logged in Secondary Status Register
Date: Thu, 4 Jan 2024 07:02:29 +0530
Message-ID: <20240104013229.693041-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: a6754d01-fb78-4ac2-86f2-08dc0cc50bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rCbB0YUs3TIEF36ms8HxZ65+Zi2laMLEbC7bpqlTdX0SAFVuxzQWIdmXyqyQLIQz+ftU4sCd+q/rkETzUStj+cAtRB+KgB7/nWADgaTHL7agJmBT59wXKkaq5n50BDRJrZcEXdkVnm2+nk+FAvZFtcjpnf55rYOXH5EeqWd2qBSNvmwVQhQL1N5fQcH3rawfif8k4RsOLdnyJWu3tfSNzOM7jgXYGbZLNpGZpSdxrybAbdAW+Rp5BfcerqGVFUHIYOgFpJQXap0027OxgSGDVNUq93CasQ2UCC+Mq/pAtQqiS6nAfm5Ay+pQVjI5pjsh190Z+hVN5ZVgvtSp+NXud+jbCodWT0LbRN15BHUz8FxAWeGE1i7zlgPRfu0isGVMc3I8h0qi3V9XKDn30YV+JR1+pSAo4IeiG/7CGdr5Ox4s92+gjxFBwmfvIbTFPOChOCPrBup0Dem8exvTIn0es+TJ2kbYpD/Jkhadaxd8adH7AJ0v4v7MpYh1WYqjNlCFg5EOO5itw7+JLoV62hor+KvIhwhf0Ztpjjk/Q98+X3rkYkzmmbgfnkMs03TzzswliCfPho+TXcH+xCjEx8yztlFpblqMVmydJ5CIqIiUHj83AY2GDm8OJHzbQzXB8PIUHwpbYgI891lu/6gJ+B9Hyvx2JwgsqyCH9BSPhT5ogZSF+UkxXS7cLaIz91D3i7M3xW7jQ1eYuLtsftan8p+kgnaehq57kv/AldMr3jhW092bkEYDBwWxIeuG9UPHcCKbNfczkn6qKJ1B0g3gTScUzO1gA3U0inVOSdZNPagj9T8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(82740400003)(7636003)(356005)(36756003)(40480700001)(40460700003)(86362001)(426003)(1076003)(26005)(6666004)(7696005)(316002)(478600001)(8936002)(70586007)(4326008)(70206006)(8676002)(966005)(6916009)(54906003)(36860700001)(336012)(83380400001)(47076005)(2616005)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 01:32:42.4148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6754d01-fb78-4ac2-86f2-08dc0cc50bb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330

If a downstream port has a PCIe switch connected to it, the enumeration
process leaves the 'Received Master Abort' bit set in the Secondary
Status Register of the downstream port because of the Unsupported
Requests (URs) take place in the downstream hierarchy. Since the
ownership of Secondary Status Register always lies with the OS including
systems with Firmware-First approach for error handling[1], clear the
error status bits in the Secondary Status Register post enumeration.

[1] https://lore.kernel.org/all/1fb9d746-0695-4d19-af98-f442f31cd464@nvidia.com/T/

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 43159965e09e..edf8202465d8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1470,6 +1470,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	}
 
 out:
+	/* Clear errors in the Secondary Status Register */
+	pci_write_config_word(dev, PCI_SEC_STATUS, 0xffff);
+
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
 
 	pm_runtime_put(&dev->dev);
-- 
2.25.1


