Return-Path: <linux-pci+bounces-2208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C4682F08D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 15:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1B31F23E26
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990746FBD;
	Tue, 16 Jan 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aGj7n1r6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12A2563;
	Tue, 16 Jan 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw//XRofcSo0Vwht2vHleoTSIlHH1RKg4dbCUlQTt5n412JtxOrmpXonVIoSQ8gYT2Pr/SpFSDhsAS5MSjHo9+UO3YoQ2pvGS0T0D2VQL2Xlf48i3HLa32wwnWcxudDpLsZnIUUfqi2mObIV5DIRH11+7PH/PGRSPFSCBEF4KuB4XUY1XzwExBYYBbc+ZW30RBLq0aOEObl5HSWrRLQHvKmJ03Mo5V5851Ov7OON6zGzlvQS3DRpFZxKsucvKOfwLr953uUJoHCo3F04L06J28kNgUKOYwHwjZwDn9l+3ltAeWS++NrRE2So0z5sjp/cvRh3jyz63xGXoumcYFHM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyM5Rg/rDIjkGQERyt74b7460YcodZePpOgnWPw7Gu4=;
 b=fWOJAYxf2roDnB8fxmBCVGevXLqE7HCkrReJumeaoh64zUmu4OcW5ac7sNzkPrpMuhQloTZVNbAX5TiwhEsuXSeZMOfK4tIHjbk2G9B7GzinEqLS3+/9WsktDIyMMHPS/sAnFXh2lS7AEvRFrdWTOwymnJ63bwK0IMetjRje+fDyzHE37AA/AUdPJFDDGr7QkObRtiP0MeTFWFeaIKf7jh104KzC04A9ZEZaUoUK/a6MlJFWOtlPF4Fi3MGP1Nqb6cS1kAet5K/d/ZgzdpvfJ7efzGQkHiNRO74Gq3BPKcs9MUDyl/hK04cDQRJGesT+EkoUiWbanqiGOyorvczk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyM5Rg/rDIjkGQERyt74b7460YcodZePpOgnWPw7Gu4=;
 b=aGj7n1r6ca8tabEWe4Ah6+dWQ0msg1+wdCkq/xkjNGPeOg7OAVU4qBk4FY0f+JvNU1qDEvyuy1O9ytVguhTAF6vYcdXdrCs28CNWClxYg4IRsfAN3bALP1nNgV/MKU8EdT33OJtjMO1qeNdbstdfCeel7rOKN6tzX66pD3STewgRzFOA3XjR/FlnJAf1+9cTGEwkHXrnsISxhl1BAASqnOxrYQ4JwZwUwqXqQfpgFDF65pYP5RX6RaNTtx3QX3d3i4gMiHFwCkMG02/uxb7MB4ujVRz31iNtbopleCmJxATI9y1aDJABW0oxsflbjJgNhjF9QZxjWv1TtKawsH+93Q==
Received: from SJ0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:33b::11)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Tue, 16 Jan
 2024 14:33:12 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::c6) by SJ0PR05CA0006.outlook.office365.com
 (2603:10b6:a03:33b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Tue, 16 Jan 2024 14:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 14:33:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Jan
 2024 06:33:03 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 16 Jan 2024 06:33:03 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 16 Jan 2024 06:33:00 -0800
From: Vidya Sagar <vidyas@nvidia.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
	<mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2] PCI: Clear errors logged in Secondary Status Register
Date: Tue, 16 Jan 2024 20:02:58 +0530
Message-ID: <20240116143258.483235-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104013229.693041-1-vidyas@nvidia.com>
References: <20240104013229.693041-1-vidyas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: ee05d27c-f132-417e-e689-08dc16a0115b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8k9MPPa/z7PWEugWSeuKValHgkOblPHq4Y7LPkNgDltOq5hXhCdHAdU8oWno1E4p7UiZ4hnwcFWfA/G7qZJb7wOZCBTB/lo6JTYs3ppDjLHM3o0uAxkSpmFjjrZ8mYTH5RyKBrmFCHXEq3WZiuDXxO30Pi7htWKQE/A3wsNjVojF3G3jsMItnx0wIT7KZ/sxdWc6E5RcnmEqoWlVPuYWTojQWhgPZ1oD79VVm8t0MWAFnOzuLlO6M41UlyEgbydIOg9u26nNOz8q1v2bUqMi//9ocaBQFhj7sJhVzh8WaAg/ohBg1QqZwPz5YJZcUi6xVarTiCE+87OpLwDp83QoGsE35dCRuXnJp1EbV+lIA0ah7lSVFDo2ltus8wQGFMF4wPObZxjGxx6k36GamND4j6LxQmFgzc1eVrZJzrhZpHjnwlHBK7VzpJbZn2UMnGPlD1e99e9qEa58WJC585a7PDMHPdFXtnj6IeUHZQ48Jds3BYw04q8BgEBDF2GK4Nz71YTDnhSXNn/4QmD8Ucz2svuDDfWoEKtQQIIKSZ1dzkSVDwBpUO+9zNWG0KXLFN1A9FeZOyeW8BidNMwe1eQykqY5TMjc1BJZ50r9Mx/GgncY//h2c7MSHtbEUB6kQBoDeWL7tOZsEbKRoqf1m7dSM0hW3sCfdz3EYbha5n5+HGLWr0cdVZiLdO+AmWG715mxNc+nDj9PyX//Yk1x+07xnYBgOiClZ7tgQmHfrL9hmfdHUk27W3pCXZZ8HK2eUO8c
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(40470700004)(36840700001)(46966006)(5660300002)(86362001)(41300700001)(82740400003)(7636003)(356005)(2906002)(6916009)(316002)(70206006)(54906003)(70586007)(2616005)(7696005)(478600001)(4326008)(36860700001)(47076005)(8936002)(8676002)(336012)(426003)(26005)(83380400001)(40460700003)(36756003)(40480700001)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 14:33:12.1269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee05d27c-f132-417e-e689-08dc16a0115b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982

The enumeration process leaves the 'Received Master Abort' bit set in
the Secondary Status Register of the downstream port in the following
scenarios.

(1) The device connected to the downstream port has ARI capability
    and that makes the kernel set the 'ARI Forwarding Enable' bit in
    the Device Control 2 Register of the downstream port. This
    effectively makes the downstream port forward the configuration
    requests targeting the devices downstream of it, even though they
    don't exist in reality. It causes the downstream devices return
    completions with UR set in the status in turn causing 'Received
    Master Abort' bit set.

    In contrast, if the downstream device doesn't have ARI capability,
    the 'ARI Forwarding Enable' bit in the downstream port is not set
    and any configuration requests targeting the downstream devices
    that don't exist are terminated (section 6.13 of PCI Express Base
    6.0 spec) in the downstream port itself resulting in no change of
    the 'Received Master Abort' bit.

(2) A PCIe switch is connected to the downstream port and when the
    enumeration flow tries to explore the presence of devices that
    don't really exist downstream of the switch, the downstream
    port receives the completions with UR set causing the 'Received
    Master Abort' bit set.

Clear 'Received Master Abort' bit to keep the bridge device in a clean
state post enumeration.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Changed commit message based on Bjorn's feedback

 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 795534589b98..640d2871b061 100644
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


