Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35883CAE97
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 23:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhGOVfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 17:35:11 -0400
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com ([40.107.223.84]:36593
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231527AbhGOVfG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 17:35:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krJJZUQYqmexDkoVM5TATN8ITI8eDcTiQKEdcei4GuZGx3C64TwvyVSdp41hExRy0UqXaXmbXnQ4qiA69QVTFIqyqVNJoBw1Q1XVzI/glQ5pr7TvCooxUrJcP/ya3nZ2eQAb6/WQRKhsvhTjDVkvQbcYy0zgHpUEP8os/n4+a3bkTEVUERhhtv/oXkC2FFvLj7Y0rQOhe5o03kJ9UDu6IRKUvzTN9+H4NBR+MSUJmREIaDIraeDj3UVMPzJzkneO3vnJGCNAAIxJAqQzAsf2JlF+mioCh+VK8v1Y2JCuFBO8JWYbmGTNMITELLtGVKLEsIj50iGCDLprmdNBaiTgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1smU2iB93tQPjFzQzhqdG79mTBolDEEd+p/AvMitkc=;
 b=KhdRIqWf1dW0PLo6JIIk4JjcmGe1TRcyOn6leseCIjSDgBKIMHkgJipeJoNcs8yCFO3cQ35oPJQnvkak7Xvwc39JcOsvcyL4PNeovH148DtCG8AriFY9R2vIbPCVCcHmdL4DDFm1auiuyqFxyarZGFq2nMQ6p8ZkC7DHIofwJU+MYVZvZgUv1DEwzbsRuifqDQrPIC78FwuK2CJvQD+LJwwFCM346BQIqBvhvJO2OQSwxEZDOfwdNliFhLIMN777Qr1iavrUnC/N+5Ol14n+T7kgR792O5g0Zq6qT5/Z6hkftme2CdRDyQBVFw+1aF+yzmcdXDXxVQGRJtet6RrPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1smU2iB93tQPjFzQzhqdG79mTBolDEEd+p/AvMitkc=;
 b=I4DAhwhHUCzE6rpbplF3qVU8Kw7ww1843QCwZjudU01UtIOrEaHHAC4bNa3Ptc2RvRJajMfaYHd5NsG5HeLeEV3oq4gnLO06MzAsa4yrE8+wMGCib/pQnPOMyyv68SVBSDYFlECBFud6NW1fHt6Vg08EG3HLtYSnTwUR1bHfw9OJKIAxLC1P2cTeKqAQ1NhI15OCyn8yLGF7GkF1met/gJCrbQDN0piZ2gzi8NaYJ25X4lXmZpaybFU/Byl+0dkLTy5bcyeG1XZ5HyFMX63X+agBRobaJnbbcp3TMl6EP5oi7bv49HUq4gEBw6qbYcQ6ShXU9VZuC77G4vA6z+vw2g==
Received: from BN9PR03CA0060.namprd03.prod.outlook.com (2603:10b6:408:fb::35)
 by MN2PR12MB3023.namprd12.prod.outlook.com (2603:10b6:208:c8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 21:32:10 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::d9) by BN9PR03CA0060.outlook.office365.com
 (2603:10b6:408:fb::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 21:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 21:32:09 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 21:32:05 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v11 6/8] PCI: Setup ACPI fwnode early and at the same time with OF
Date:   Thu, 15 Jul 2021 16:30:58 -0500
Message-ID: <20210715213100.11539-7-sdonthineni@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c62fba77-e0c8-402a-85bf-08d947d800fc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3023:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3023BD952D4F3BBCD91C3F5FC7129@MN2PR12MB3023.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tozVFMrHMsybDcm3eyG4wuJg4AJ8c+PjDmbiCBpOEmDAmEfn1/sTpWohFo+FRJUl5ixJIhEbAme1y+gLp8sVUB1r+v/u9pwCLGsU86qSjcCbS/KOlaYodcvv6nCUvcgzgKovaXENTUkCM5V01eUSLowRMD1S2jF4AE4DOioD4ZwzPx1BI6XvxQeaSTVGbf0gBm+k4Z3x6rZ+IeIMU4a5AceNCOniZ1+Pxp6RUTqUK7D38WUaXiQFYdmSeZ+nt/2J2x44avglfjTP/eJfYGXyvHOG92yS0J+DiCWxg3r5L8rYHrXUAevN4jGfO83kgAxbZv/x6B36SrGRl478eBb6oUbi45lVnMnnlcz1IlenGzmxr2UWziR5/10yW/+31G/qyGFDXM6ysSanyp+itn2TzDac4jpcUx0wzBCipUok16686r26mOSV0De/H/TY7v4+o/LuEDZ+H9GImMp9tJ7AZ19LmJN+Vfdixv8mrCw85UvIkqJHQ1+mbqQ7eBd6T/vyg3uQjdxDXAgv1H2aE6ccPSZsxWs9g3yGL2yqM3G6+91exrBQcqvixqxQX8IpO4aMZKv6Ls0B6Vwcyw1dCw9/Nurnu4SiSoZ+vJMLqthjomYf/PLtoIldRvU2YzHG7Pko8VJffbEamkQOg3Iv8FFYAncl97hLa+0ZIVQkyy2b4SCEBLw6FHL5n4Pbvah+DgqD7blvs2BYSXUpAQz/c/L8dZG0XVzyD86LXaUGHLyxkMlKrQVlvMHFupZZ4wrl/Z6pzk7/rWdrBtIqgOArOmvo2A==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(34020700004)(86362001)(82310400003)(83380400001)(8936002)(6916009)(8676002)(5660300002)(26005)(16526019)(186003)(4326008)(2906002)(2616005)(70206006)(7696005)(70586007)(336012)(426003)(316002)(36860700001)(47076005)(356005)(82740400003)(6666004)(478600001)(1076003)(107886003)(54906003)(36756003)(7636003)(36906005)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 21:32:09.7466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c62fba77-e0c8-402a-85bf-08d947d800fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3023
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

