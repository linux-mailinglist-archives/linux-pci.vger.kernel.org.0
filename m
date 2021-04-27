Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA43E36C817
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 16:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbhD0O4i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 10:56:38 -0400
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com ([40.107.236.45]:31488
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236368AbhD0O4h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Apr 2021 10:56:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AELwFj+RUMgVsxL+9YxMgEBYFY3Pn0x2cjd5O+Rqq72kGIwCEzqLll6xbyHRWGQxBrS7j+9eYwT5jQAPKXijGP3dnD/eTuqk+/oL2OqmI/p8/iPLlDUWDOnvq0FcLyjGdr8M2dlwjykCDYIyHJ6zaZBYuH24OX59uooN6CguCSiE3838EzZTSaMT8EGna7Of694KLnHPP6ZvJrd9ki0mJD8n+JcF/0jBxULPt7lBw3PqfRWeARzoEBORtdJa4xrHgCuEFuTYulJOxb5c8N9O0h4X/7VI9nbw+AN9rxhUBn+qfFZvqRyMRxKIbhDRhqLosVvF1nYDknYeJr0OkY8vbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNm2ODLdbWIlzfCihzUgQ7QJjbWZbrti0ZEUhppWpFQ=;
 b=iaWlKCelyQDOxmNnmlJlltLViiodS4Op79bBpM2RFuXO/38Smt5JgqRwPqHyLBMd5XCeZtvX9OTKIBhNL1+ZtbXeKft9kYda7XEfdIVBp0ApqkPCEiuqOf6STtF8plStfRxCM8aZuhOP9Gkg9EbqKHjA3gA3uwXlWuepGsWtlmTDRqbmFV5Y1y0UiIQD7K44c/VKpGJ2YGU14Kxv+f4A/OP/U3OEpYKVS2ER+8rgRhwxtM/LGl5HySAxz71+OWq8Z6p5JWHGZKWZoI6VFaZOL6z72OvrqfKor6KZHOyCJMZPk7FgFMRuOO5ySep8ypv8uyGCBMBRG4XYr/GLA95UFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNm2ODLdbWIlzfCihzUgQ7QJjbWZbrti0ZEUhppWpFQ=;
 b=rah6El62CtY9LU/4/whsoiJgl8K8GHJ5ta5+1IU4tg/72XBgIWlymD6ubX5buO9O+VGmbHt9iFIIiyAhcogVf2QHpPLdDPmQoMjM31/EMRf/LmqKwaLFkumVYXkBDkWL354U/XWyliI2K68TAah/eDXoAmSe/K0S/q2tf/sN7CVUF20SwpnqSBGneJdBjXy2n+VWCE5f86MHF16A450RST+aCNcjTwr+d8SDPltdhJR+7rtHvMpRTQK3bFss6rFN9PIx5KM40f0JauAeXEc/9DjlX4X+t0QvxCW0PH2CTIc6+SUqOTmI7CLVvB1+/2/pH9QwE2QPjk9VonTy0oX1UQ==
Received: from MWHPR13CA0017.namprd13.prod.outlook.com (2603:10b6:300:16::27)
 by BN7PR12MB2643.namprd12.prod.outlook.com (2603:10b6:408:29::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 14:55:53 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::6a) by MWHPR13CA0017.outlook.office365.com
 (2603:10b6:300:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend
 Transport; Tue, 27 Apr 2021 14:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 14:55:52 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Apr 2021 14:55:51 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v3 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Date:   Tue, 27 Apr 2021 09:55:35 -0500
Message-ID: <20210427145535.4034-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427145535.4034-1-sdonthineni@nvidia.com>
References: <20210427145535.4034-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc11e3c4-2730-43ad-4f8b-08d9098c8dd8
X-MS-TrafficTypeDiagnostic: BN7PR12MB2643:
X-Microsoft-Antispam-PRVS: <BN7PR12MB264340483F8C4EEE2A6008D3C7419@BN7PR12MB2643.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yG/10LUIYWiyj/l5s7xs+Hx0PV4w8KmD1Wbd6bUnpk/ahLigPYtKRm0Irtl1/8j0/wLxkA/u2KzKRPl9HfiETPpiCdIfkSC5EbAGH8cQ1UK/IhuGWfIRhJlZN6SRA5cGxG4LeoEFmQsnLQsK+NIa9Vy8SgzllapKblRDIzBblMYy9uEK/LtMvVljQzLdf8QC3Ebh9zM66ustIL6ld4rT4R4oJm7uRc33dURPMMh0RENofR3yW/TsBIAXWTA02PVlWHtJLjmErJVces5MrzkjEMlj1E1X/Rc3hqkkDG3S62Ao+xWvw83z3VLVebn3BYoBPBUIc4QeTn7QeKiQJNnKbD8GHoI8YoyO5RJXsehdTNIWI1BVZ78eBitNgNmTsRDpwALvCEwHUcPF2h80JWykLRu+4313lvxVmpKK6q4Qymp6C3n49UOsa8hqYnEijX+k3Ev+hJ07Ecua/IAd2zJrOJfe0tf/GMLixAq1r1F5AYKAD880ZlflqYmKSQgEjEt+EH5AYr7n0ck43d52zJPMeAooaQqLJz5+G1E9QsSLwwPXeAzewRoZZXAMe2PvyRu4kqO+d359NgYNdArNlQvSmtN4t+c+c8uqZ0EVA6vnyj/mWP7jtsPa1gi4MD4bbhC5IZJooBcIX6zkvW/xwRXnnxM98pRhvhhzgySA9irUbkU=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(36840700001)(46966006)(107886003)(8936002)(2906002)(8676002)(356005)(4326008)(82310400003)(2616005)(5660300002)(70586007)(6916009)(36860700001)(47076005)(16526019)(316002)(26005)(82740400003)(36756003)(7696005)(426003)(478600001)(7636003)(336012)(54906003)(70206006)(86362001)(1076003)(36906005)(6666004)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 14:55:52.8381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc11e3c4-2730-43ad-4f8b-08d9098c8dd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2643
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On select platforms, some Nvidia GPU devices do not work with SBR.
Triggering SBR would leave the device inoperable for the current
system boot. It requires a system hard-reboot to get the GPU device
back to normal operating condition post-SBR. For the affected
devices, enable NO_BUS_RESET quirk to fix the issue.

This issue will be fixed in the next generation of hardware.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
Changes since v1:
 - Split patch into 2, code for handling _RST and SBR specific quirk
 - The RST based reset is called as a first-class mechanism in the reset code path

 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..1da80e772ee1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3913,6 +3913,18 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+/*
+ * Some Nvidia GPU devices do not work with bus reset, SBR needs to be
+ * prevented for those affected devices.
+ */
+static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
+{
+	if ((dev->device & 0xffc0) == 0x2340)
+		dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			 quirk_nvidia_no_bus_reset);
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
-- 
2.17.1

