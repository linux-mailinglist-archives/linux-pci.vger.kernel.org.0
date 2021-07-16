Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446753CB9C0
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 17:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbhGPP1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 11:27:38 -0400
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:51520
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240765AbhGPP1c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 11:27:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBCXfLpB6OhC33mIz1lje+kDWr2o9DmObgPO2GD/LixwX1JNjZg6GZXQx7lH/iv9KFaXvJI7g9GOlcxRkRE1yAupkRNHQbSPr+PWhxHcX1HozGSHwTDaMzvAUWBhvcPRyq43tLkRklXks5XqebOTuXzo9gDJGsmzTfCpTQi/wipx7vV8nGJ1bpV351YNmOh8/ZzOZCMEwK9rSlEpRN2sXTD3U9c2z/elD03tDUy3XuTixiOeAQHFo2DZXvSrNEDuypBNwzR/XAwDXDjqDl/BdZRsYPrbFnaVKWGSWqh5GWmsSIpRLCPmIVj9IzmXCVyQlykjLQNDy2OXrqOEHCTJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZGzr3fqG83VjVOwKMXfakYtivzpnToDyWUHo11oIx0=;
 b=cKEJGn1xyJifdsbxW7HC6PUo+lG51aXahZRCCoJ85B63fROBMDB6m9ZtCDlhBsUFWhQoYIuBrkcqPhQckWo7JzbxU0MVe0kl7Bzu+sGC6Vos51t3lTrpLVHrBDTiTtgfIX8Jj+4L+eCTc2gPEAZr3ipHotiN2fJSEJGfSNwtRNCfPt/VR4zYxGjV3XflZ83SRwBe2HGph8NWXum1IhNlhqZsk0qzgTQX0sC4zeSzhST/fIoo1Lu+czBsntOPXAAZT47vXbmmV+QRa2yQXI/9F24KNA06o9YHxr7PrqscHvU/61lDKXDhZRLUErsuLzGB2gx6H73syQ7ORyHQZzc2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZGzr3fqG83VjVOwKMXfakYtivzpnToDyWUHo11oIx0=;
 b=mob0N+PL43djlHa4kY1N3Tu1x75ptj9Rv+YSkiAtnyQ2IneeAhJK06tNwKUAv0cVeVO4Yl39idWp/axtXC5xtY1vhYKbWiO7OQ+IyjjIZIU41hnh92GELtK4FR2+FQ9DWGwtSrET3MQbwmuHW8touS+BrzQ+2y06PiQmdT5SFTgBhdKSbG6cabN6ap7+aNL0vNY22i5znBGQmm3UJxFhiefPa/bIyVWk7cpCdoqelvm9JOsP+tGbgTANGr+0syI1Qy6NNl9TfOmIoWqQq9Hc5J/ybYWvq9cYyaZmMbNE4sRlQoSyL2S1FBmf4vI6mJ0UDlWPNpAz5H8w35nFnA+0UQ==
Received: from BN9PR03CA0632.namprd03.prod.outlook.com (2603:10b6:408:13b::7)
 by BY5PR12MB3857.namprd12.prod.outlook.com (2603:10b6:a03:196::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 15:24:35 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::b0) by BN9PR03CA0632.outlook.office365.com
 (2603:10b6:408:13b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Fri, 16 Jul 2021 15:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:24:34 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Jul 2021 15:24:32 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v12 5/8] PCI: Define a function to set ACPI_COMPANION in pci_dev
Date:   Fri, 16 Jul 2021 10:19:43 -0500
Message-ID: <20210716151946.690-6-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716151946.690-1-sdonthineni@nvidia.com>
References: <20210716151946.690-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27357afa-ef47-4200-55cd-08d9486dd143
X-MS-TrafficTypeDiagnostic: BY5PR12MB3857:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3857FD695A353C7A415BE521C7119@BY5PR12MB3857.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Sp9X3WWeC0EkLg+ApInu0Uj8Jur9PLPI2WQoPnS+6xki7mo3vMEycR8XUnRat91WpBlxttsSS/IRhtk/HVUc6lear4vLuszbaah+ois2zOogInlVJjpFc8ungwpjF2fiage4WHXaX7evaxHXMMoBqDPo51m8cL6kaGiU4vyaT1edAFDnEsKD4Coe4PX8JsPG1aciAACUGq1Sr7az7jNYroyy6piesTPM4/TGgxHCV4Gk9jxtK/kYWHS0hxJos//X3kT5ix4IIhDCfYLAoe52xhkVjLuqyeXGScCVaR24jMfzjaVewi5iXhjjgfxstU/oQAjN5lnc0LMbKGJjzU/SDJP75KSXuIDOXcG+f9RBwoTQziRttldl2RnTcgqbWINbJUpntBkvDyK+OxCGjS198NgVpESYmLhUogJ0qTKjIdf+Y7dpv9Lokzdqc0kGyC/QMqlRY8qfL2RgymIfeKVHAD9fcVik3KFQE8VtCN07vNjvTcpaSoX7NNzH9zmfFy6gmBjtGaTk6RsyaVC3w61EPcLV6fgzTi/X183H0RDrC8FuTzTJsoIr3yjl5tLyN5f2Vg5yX/pSgACayP92S+cBxjURWRbxHSLdvxjbHEU5jpiHsAdy+lh4Rz0ehXOEzRvxgzodQ085pbwndzaEP0P8APBNSCpSi40GXGl9I5g7HV4z5ANNnqQHWUxMGM1rFhv40gYJpxEnWVGTonFA5ypXVLG1vOfaC2KkDkej64V2Po=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(46966006)(36906005)(7696005)(5660300002)(356005)(6666004)(2906002)(8936002)(7636003)(34020700004)(26005)(82310400003)(336012)(36860700001)(478600001)(86362001)(54906003)(186003)(316002)(6916009)(82740400003)(107886003)(70206006)(70586007)(83380400001)(426003)(16526019)(4326008)(2616005)(47076005)(1076003)(36756003)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:24:34.7362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27357afa-ef47-4200-55cd-08d9486dd143
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3857
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the existing code logic from acpi_pci_bridge_d3() to a separate
function pci_set_acpi_fwnode() to set the ACPI fwnode.

No functional change with this patch.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci-acpi.c | 12 ++++++++----
 drivers/pci/pci.h      |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 36bc23e217592..eaddbf7017594 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -934,6 +934,13 @@ static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 
 static struct acpi_device *acpi_pci_find_companion(struct device *dev);
 
+void pci_set_acpi_fwnode(struct pci_dev *dev)
+{
+	if (!ACPI_COMPANION(&dev->dev) && !pci_dev_is_added(dev))
+		ACPI_COMPANION_SET(&dev->dev,
+				   acpi_pci_find_companion(&dev->dev));
+}
+
 static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	const struct fwnode_handle *fwnode;
@@ -945,11 +952,8 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 		return false;
 
 	/* Assume D3 support if the bridge is power-manageable by ACPI. */
+	pci_set_acpi_fwnode(dev);
 	adev = ACPI_COMPANION(&dev->dev);
-	if (!adev && !pci_dev_is_added(dev)) {
-		adev = acpi_pci_find_companion(&dev->dev);
-		ACPI_COMPANION_SET(&dev->dev, adev);
-	}
 
 	if (adev && acpi_device_power_manageable(adev))
 		return true;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 482d26cff7912..37381734fcc78 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -708,7 +708,9 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 #ifdef CONFIG_ACPI
 int pci_acpi_program_hp_params(struct pci_dev *dev);
 extern const struct attribute_group pci_dev_acpi_attr_group;
+void pci_set_acpi_fwnode(struct pci_dev *dev);
 #else
+static inline void pci_set_acpi_fwnode(struct pci_dev *dev) {}
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
 	return -ENODEV;
-- 
2.25.1

