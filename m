Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916F13CB9BE
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 17:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbhGPP1h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 11:27:37 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:53856
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237326AbhGPP1c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 11:27:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLqg6u+srVNnQEoQ1QCHVEzNItL9Y1CqqlaloHKtK4V123Q8WRFZKH8my5Jp97fjKTdqwUJ91GZBxxMQANzvy1dLMN1Qo/kEnB8dZl52O1QZgMQjLjtiRqa7TTRDmCqwl8M2NjoivzWVH7JWQo8luIXHhcUsUcSr8b82SfzuOG7X2TZm+jDef0zgDgRDLU5Df4d7DAcD9piXhVBmozRz3IFhH2yzPe075vnAh9/vvHmlCRaNNNl8bhccf69nCRrj6heOJuJRp4wPfdBg5v0smLdfST0xSX8Mxp1Wm2sEzRizBZ2RImwFhqgs7XAl/hy2SonWYSYw2bwKsh9g32GKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1smU2iB93tQPjFzQzhqdG79mTBolDEEd+p/AvMitkc=;
 b=hzmtPYlUCLMTkhNkYY+ogHx2ERNca/rPUFjSeRPQMAsv4+TS/NT0J7+knwVt8YDGcNW5+tl6FrePFXYnDn2ILKJNSXlB4aZuvJQxyst67wiOsqQTrOg5s8pVxyP+pP56hjEB9RgAIHbrEkAHMq06qCsvrr7bGpNvwKg7g6xAxVg4u2EnYUWzVkY6ele8NsI7m9Jx/pUEeMXwvgzVX2Fr/MLa9ThFbPmvIqGoofLCliwYS6aoopbRgxXHBKJp5tyaYiP3zBlx6Cxk/XYl+2FZEUM+M255+1vcB3XfQtNL2Go5A/7v5g6HAJr5iWON7vXYYoi22wyoQXooaLfPmrW8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1smU2iB93tQPjFzQzhqdG79mTBolDEEd+p/AvMitkc=;
 b=BvKAmyy5SQjlxDZ73oUTkK1Eaf36XzsauOVmw2MnfB2QsOqEZ1MlwgaFe4TSBFy6KYSqwZfrE/Ltc45HneIMttdeW8T6/hAmQaHTGA/kxHzzsFAZUe2ampalQReNkS+smt+XH9t1ftK6kiaJoQ4K+ziKkE+lhvZy8NBCL1hBRbGw25o56W2SRYEqgD8fCipP08l+aEef5fJ8CbXSSyatjKPzXZS0XOidhq/dgsGm7loY8CygFuFyJcj6C6VixJ3PeziJqA3UqDfa4O6yCMmOLoa8llZm8ecI+/4mJDycoED5jfGSUKzNUODWRFzpyUtXHXBrRgc/+t7Bq7x8jLxKiQ==
Received: from BN9PR03CA0633.namprd03.prod.outlook.com (2603:10b6:408:13b::8)
 by BN6PR12MB1426.namprd12.prod.outlook.com (2603:10b6:404:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Fri, 16 Jul
 2021 15:24:36 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::98) by BN9PR03CA0633.outlook.office365.com
 (2603:10b6:408:13b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 15:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:24:36 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Jul 2021 15:24:34 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v12 6/8] PCI: Setup ACPI fwnode early and at the same time with OF
Date:   Fri, 16 Jul 2021 10:19:44 -0500
Message-ID: <20210716151946.690-7-sdonthineni@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e425bfd-fc72-48c3-5d3b-08d9486dd24e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1426:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1426006ED5084A7C9CC30310C7119@BN6PR12MB1426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUpYHXxwFLC1++aWTte3tLuVdO6uayT6Kqesr8l/0IejVs7GOcBfj0XV0fjyTQxEk0fVjfM33Fv1G7kwTcc/NXc2n4mz5ACtJUv3tbb8Z43XnHdT5VdNSkuX5BefkFJ+otms+s2/9rz76dWObkVX/RPb9MMGSaPSG+YIxje8rRS4EtA0wdgIkfFVipzN0njmE+e5h3tLD209TUYXYBoQqgijyTrhb/+F0A3IMLyvmkT0obn2hQUyhsc0THFBqO+fPhbjQfxD3DAnmbNlkWXDb0WocwBHLA2bIBiqu+YEsr5OUu5len3FaCZPiNhDew48JTPAkvAGtr/UNCYeGcEQoqup9sXbi219FwpRXfo08v9y/O6ZLOqI9R9qkOAN+LNlhotFJxtFqOQyZAr0uUVJIs27pLJ9ZhC3icBNlZR/gndc87JnXvuaZtFK4AdlNquOTYaF1q6jn6zbiqBnvizEkkC869QEjBGWCvVHWfz8KbcGCVcnh5s2pe6aKfC1+I6a/3kMyMYiGRmJt7760y5SskIt0RbnyyWBGr+cl6+A1O9y/0ZKE9vewJH4AfPqMBHTPN+DB+OOPGCzRc+pk1UH5WixtyVNjGo9Q815lFSZTtKwcLKaI4Z7PMJtTLe2u/tYJu3OeY36AtK60K+DdJndN238AM4RuRvhdFQAAhYCJdktneWYUe8lksXB3x1b0vKOnML96d45m9Ij47putmFEeUC0SUyJPbziGOFvVkYVyDRLR5B9jvkkkJK65WY5X6K8Ae+ohycu9IGqAdOtX9303A==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(36840700001)(70586007)(7696005)(316002)(107886003)(6916009)(6666004)(8936002)(2906002)(1076003)(4326008)(8676002)(16526019)(426003)(26005)(54906003)(336012)(186003)(478600001)(2616005)(36906005)(70206006)(82310400003)(5660300002)(82740400003)(36860700001)(356005)(86362001)(47076005)(36756003)(34020700004)(83380400001)(7636003)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:24:36.4753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e425bfd-fc72-48c3-5d3b-08d9486dd24e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1426
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_dev objects are created through two mechanisms 1) during PCI
bus scan and 2) from I/O Virtualization. The fwnode in pci_dev object
is being set at different places depends on the type of firmware used,
device creation mechanism, and acpi_pci_bridge_d3() WAR.

The software features which have a dependency on ACPI fwnode properties
and need to be handled before device_add() will not work. One use case,
the software has to check the existence of _RST method to support ACPI
based reset method.

This patch does the two changes in order to provide fwnode consistently.
 - Set ACPI and OF fwnodes from pci_setup_device().
 - Remove pci_set_acpi_fwnode() in acpi_pci_bridge_d3().

After this patch, ACPI/OF firmware properties are visible at the same
time during the early stage of pci_dev setup. And also call sites should
be able to use firmware agnostic functions device_property_xxx() for the
early PCI quirks in the future.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci-acpi.c | 1 -
 drivers/pci/probe.c    | 7 ++++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index eaddbf7017594..dae021322b3fc 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -952,7 +952,6 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 		return false;
 
 	/* Assume D3 support if the bridge is power-manageable by ACPI. */
-	pci_set_acpi_fwnode(dev);
 	adev = ACPI_COMPANION(&dev->dev);
 
 	if (adev && acpi_device_power_manageable(adev))
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 66f052446de20..a0f20a6e3c04c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1811,6 +1811,9 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->error_state = pci_channel_io_normal;
 	set_pcie_port_type(dev);
 
+	pci_set_of_node(dev);
+	pci_set_acpi_fwnode(dev);
+
 	pci_dev_assign_slot(dev);
 
 	/*
@@ -1948,6 +1951,7 @@ int pci_setup_device(struct pci_dev *dev)
 	default:				    /* unknown header */
 		pci_err(dev, "unknown header type %02x, ignoring device\n",
 			dev->hdr_type);
+		pci_release_of_node(dev);
 		return -EIO;
 
 	bad:
@@ -2376,10 +2380,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
 
-	pci_set_of_node(dev);
-
 	if (pci_setup_device(dev)) {
-		pci_release_of_node(dev);
 		pci_bus_put(dev->bus);
 		kfree(dev);
 		return NULL;
-- 
2.25.1

