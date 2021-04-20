Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEF9365956
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 14:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhDTM4Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 08:56:25 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:3040
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231718AbhDTM4Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 08:56:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAgMlKtcmSW/eDD+Po0+vQnyRwKzcMDDZMCdSrf+PWX1xxIOAoAcg4zqcuQNoyI9rQtpmIX1KOrSllOG79fpnlfo9KcmC23TiY3/LbTvNEpjB0Tku3ey4dXWzkOtjAQqXVwWSz/lIei5D45Enjt4YxSeWwTuWVnnMC3tCr24FWbXDEiiw4enBJbodnfvQZpHax/ou5qm2DUkVt156fOKyHQtbJubDEDvfkgURssKx5YoWh+8bjYsdmS5b019gKjZvtA6HBmEPUk8W5EL5HZ8nn16hhkQ/RY/kk+8zUWSdnF+dDaOIngtUL+g4uGPwovZ1FGWlvECKOsNEHzYCnqmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OexR5DyhJ1fn4uqxmLkLzr3rMny/CYaCaX4+9hiMsiA=;
 b=QhfKWW4X5MXoU37zp1d9o/6Cn1jNa6HmQo8yC5c9d1uaz/HRX7k49aU9Kd98aIdysSunXya+RM0838scWQpssTCoAAVMhB/DlwZN25f9cZhABqACuWUfN1q2PLYgF+m7zYgpMEAHFtMYVWImpz1v78WV8UZep5SMzxKbnvt/i6sg1eSZnlO77urMVmHrcg7toxhAvNTQdC/Bn7gwtAO2o7AlXrFHw8WSdN+ZnFS5dZ0UghpuIaFGYikkLYkfQdej5sDYS41wLpUhEsgkxO6kiWoxTiuFTUdY7acLrf3EiRXFHGommSp0BgpCRcA10AYtEXSNRDz3pEzqlk3HptFvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OexR5DyhJ1fn4uqxmLkLzr3rMny/CYaCaX4+9hiMsiA=;
 b=Oa0BKk8c+v6+8QnSU8pCEWbD/oK/YVw0eJhtcKr0V+Ii5aKBnoVGh1r7KgPGfB4n0/grWEQdulHK8nej0A+WyX70KWigRCe8Mio04gPxKTut4qgP94MOhCWi7MdGEeNwvb2bQewxQibDmXxnVD2gtHe6U+skgPPSPsAVO652VY5awcpprJuEPJwRcG0QljsVsbO/WEmetcpfIbKpnYdoNowaALcuDRVHVDP6waDkgftwkKrco6LSeHP6xglKpZrMdnSGdhtwyC99QW6qP4cdfHzVy3bJoMKQew1E6Dzz2O/HGWnT52fdfr+r7uW0HlS/MQ7i3axoZfqfO/w7Xc+TKw==
Received: from MWHPR13CA0021.namprd13.prod.outlook.com (2603:10b6:300:16::31)
 by BN6PR12MB1796.namprd12.prod.outlook.com (2603:10b6:404:106::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Tue, 20 Apr
 2021 12:55:52 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::d7) by MWHPR13CA0021.outlook.office365.com
 (2603:10b6:300:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend
 Transport; Tue, 20 Apr 2021 12:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 12:55:51 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Apr
 2021 12:55:51 +0000
Received: from moonraker.home (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Apr 2021 12:55:49 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Marc Zyngier <maz@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] PCI: tegra: Don't rename the Tegra MSI interrupt
Date:   Tue, 20 Apr 2021 13:55:45 +0100
Message-ID: <20210420125545.1315970-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adcd2801-84e9-43da-47d9-08d903fba0be
X-MS-TrafficTypeDiagnostic: BN6PR12MB1796:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1796044CF798032D3091E542D9489@BN6PR12MB1796.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: giHBO+cVXSNwiPTt8BzZNrNbC4yKD9itAlCvilYDAj7IeGwV9KK9CUjS9uu1FfR9ZfHnX0z3JCIRkItQt0i5RFy1DlmCmGQjPHa3vOmgqxK2hyB4YbMrjoNxm8apy7rnQcuvexb6mfOHGAqePZeKRyUqTkWfftdi2nn3Tw2AJjcO7BWvTMQfAWedGl2Fw/fWEHdNV7vMSzGxMa7HsoyvUy0pYxDYQSfuD1hz07WR0bqnTtxieApPrb6vqhsmVJW7bwLFqoH1Bw1lTMuFLQuxXV80pXdneEPd8e0nSEvJnGo1bmVUPJySOjWV/BTjBiSZTNv0BPc1lKsGy5IJAp1toVvMWXDFUPcbvHdPO6WX7gKMwJzVMiEpfIgdUUq9YGkLd6MVBvffdaug5XAZAMVRa0VawABzqY8DOvirVhMG2yZNepEhK4d8fSupsxUdZ+oDO9/YGgscy3Lxf3N3mMjaoaFZENF0Ht6uEYRnE1Q2KRp6HpDuZ/UuCqwFFq1EdY/PYL3Kapjgz+SxcWZA5sb2/ugBlDJ2scW46mxEalUjM0qM6kXGcVKmJ2Xmbb5IbxrXD6vC53lvopRas8rcDth/geethietCmrPEpwhFU3e+cJV9671TkONaiFqXodfWHBtX+rLWoIeWotSOvdTgtpyCPfkJsUdGH7cHuw18Vdu4i4=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(36840700001)(46966006)(70206006)(356005)(82740400003)(8936002)(107886003)(7636003)(83380400001)(36906005)(336012)(1076003)(70586007)(82310400003)(8676002)(478600001)(26005)(426003)(36756003)(2616005)(6666004)(4326008)(186003)(54906003)(36860700001)(5660300002)(316002)(2906002)(47076005)(86362001)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 12:55:51.6256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adcd2801-84e9-43da-47d9-08d903fba0be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1796
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 973a28677e39 ("PCI: tegra: Convert to MSI domains") renamed the
Tegra PCIe MSI interrupt from 'Tegra PCIe MSI' to 'tegra PCIe MSI'. This
is breaking a PCIe sanity test that we are running on Tegra124 Jetson
TK1 because it is looking for an interrupt called 'Tegra PCIe MSI' which
is no longer found. Although we could update the test to fix this, at
the same time it does not seem necessary to rename the interrupt.
Therefore, change the name of the interrupt back to 'Tegra PCIe MSI'.

Fixes: 973a28677e39 ("PCI: tegra: Convert to MSI domains")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index eaba7b2fab4a..32ca16c87092 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1593,7 +1593,7 @@ static void tegra_msi_top_irq_unmask(struct irq_data *d)
 }
 
 static struct irq_chip tegra_msi_top_chip = {
-	.name		= "tegra PCIe MSI",
+	.name		= "Tegra PCIe MSI",
 	.irq_ack	= tegra_msi_top_irq_ack,
 	.irq_mask	= tegra_msi_top_irq_mask,
 	.irq_unmask	= tegra_msi_top_irq_unmask,
-- 
2.25.1

