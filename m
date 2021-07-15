Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC983CAE98
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 23:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhGOVfN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 17:35:13 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:28568
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231433AbhGOVfB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 17:35:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFt2vaHxsXTiPZGLSWMBzTaf6dQ1qo8EeiBdfq2gV4XcN7fu5iXXs30rTO57LNUZWPXw09pbYFxGtuvMnMKZwYXuqEYiJx7hbcWS0lLc2pYmih2auPvwoLUzXRSsuQJbNySAYn+O3K0k9FheaznJkaTkMb8O7EbYgAoQWBdu7M4MuWpTtJHMg9SkAi55TQoGe31bAMMDAcsqd0tSko9cNLBcbu36yK5foEGBTqllYzsg9/PzLc6yWxKCYP9M9Jx9VHZ4uOnIt9rAm5OsLbRC/QTkvjhYjjXNU7HXUBG+JjTHzD/cxZWTzk9vvGYnYIVmNazKFO2E+SoizCYXCfBvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZGzr3fqG83VjVOwKMXfakYtivzpnToDyWUHo11oIx0=;
 b=j46lo2ZdjmP5TU6UDYRCRoyJkMQmcwy6XzfTLBDYV6qfYzzMcfmly845MsDBF5M71ixgnxWA9SllHt/J70fuTTJNGFmjQRtPw6+hSC5EzNGNhW8jALRsGerUTj55FKu49mllbogZKONqN8ACGOSG81DvxxSxXyHdMThGvzg4mgwt/0ITtghOPhgYhHbInZZfKWkVT8VGp2Lbs4SaoL6HhPeS4ZE1wDjrjMbQaP60NQwgLwj7mSyTkPvDQx97IlGJjco8iARV+p6LwzbJJNTACXNZZM5kFu6oFJy69IZ6buGid9TkvxX3S9obvAEs1aTqRRz8bbmN7wxHmgs6eVHc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZGzr3fqG83VjVOwKMXfakYtivzpnToDyWUHo11oIx0=;
 b=XMWW3krXmpIwlE4IzrkG5qmWO4jm2JhTKcRqzkuRv4UlHbS6F1sbOwo8Q51fptkg5RL0JmrUZahKFlELDZ59AL4dpd2VhXxhd3U9YZZVmqnuPl/S8WbOa8MtvrSFg9f1A/m4X/SDGs75IriUP5GbiiZbEaDBnCDbGXNT9MnnFlfkfraV+mvkmqdKKKzDj1Q3sDt6h6cnzRh12Gw/7JZWeqV/w4+t089BETOI+i7PmsHk181TAw7xIgnvckWxq2ZCdN/Si+MYQlKgsz8Hn/VbVj8hW6ATo+ZCIszGtG2I2x/e1RLi8OlrIXVScs7os5dhgxkgqWVGolmsNePgRVijmg==
Received: from BN9PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:fb::20)
 by MWHPR12MB1885.namprd12.prod.outlook.com (2603:10b6:300:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Thu, 15 Jul
 2021 21:32:06 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::7d) by BN9PR03CA0045.outlook.office365.com
 (2603:10b6:408:fb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 21:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 21:32:06 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 21:32:03 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v11 5/8] PCI: Define a function to set ACPI_COMPANION in pci_dev
Date:   Thu, 15 Jul 2021 16:30:57 -0500
Message-ID: <20210715213100.11539-6-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715213100.11539-1-sdonthineni@nvidia.com>
References: <20210715213100.11539-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1706e09-d44c-44c1-9ac8-08d947d7fe7a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1885:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1885A1B496632CEBBCE5E8CCC7129@MWHPR12MB1885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIKtd3jnqB3hQ9rPbogSpmOQJsRjGKT+Eq1XlJVAM+7hmrMR5yklaonExnIfoxG/CB6XULblbCXIQgMESg27mYHwkY66/Xz7Gmi903/lGDveHvl4rMthVeDh3uustPcdDpRo/V4rlPfAcm26BmBHqC556Z+zTtEmJPdjC0UuaUBGjwd1qLE+apnzAYcdkMNHgkmk/etpQ7yOP9Cbwj0UlOWmMDaqKiFV5z0ypRZs8vgBv8iEIwxzboWF60YV2UKGCwMdtY/Wxy31xZ4c+QgRXx7gUyrZ+fbY9843LmzWjkeW+8vLfmK89QyBLLXdSsnL51cYrtHM+lHXHa/DTX9XxcSI1NTV1AB6xowmJ+GpR3mMKVSJIYm12E5yMMI0CCVY2VUjjd7D/fHmgMOzj6fDRIQ9ZxGcysKlwIHsoQKWpk7A83eZswF5C+mbA4BdeLAymiTUXiGxTHLd+C0UiDxlEyCLjwGL9a71go8akvQru7R1+VKRv634f7HOetAukkKyqMrxvSTKhkut8EWLbL6gP6M14DhiU/U239stPNl1SuM7HmlzTY/6Xd0LV1oJbs2kjaCUZTb5M/iGJBJqhzU6pU2Ke5UE02QqPoB0HoEgHo6MFsNbBClsGGJYKHs/eEkRjkltfqsfvECNlxPE3CQdJ1zyKcsWV6J8zIYgXkOSQ/ieLzK4LvonB6YfraIFTc82POMfkLUihIkXsNmvVZ+eV5ptHmTLuxseBiflNYvXfWc=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(426003)(82310400003)(86362001)(2616005)(6916009)(26005)(36860700001)(107886003)(356005)(34020700004)(54906003)(7636003)(478600001)(316002)(47076005)(6666004)(8676002)(70586007)(186003)(4326008)(36756003)(2906002)(36906005)(70206006)(1076003)(83380400001)(7696005)(336012)(5660300002)(16526019)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 21:32:06.0225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1706e09-d44c-44c1-9ac8-08d947d7fe7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1885
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

