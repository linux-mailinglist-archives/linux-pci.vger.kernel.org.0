Return-Path: <linux-pci+bounces-1699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 808AB824E9A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 07:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3501F21FE0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 06:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0572031B;
	Fri,  5 Jan 2024 06:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gi8POD9k"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9D91DFCB;
	Fri,  5 Jan 2024 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k09RoEikwXJcESAx7pGucEnlEsmBefpWHk6rwqeY8ahnl7CvvOGAapb1RbrW9cCh+yNBR+5OvVyJrFXooAtyFXnXsqFeF/FF5l1OZhNuZnlzwQi26NNiDrWDFZea0zBmYI5CfKN6m9vqE/Z38P4oVe3TcsE7NzldjLrpctd67lYxgri2ttRgkH4PgECWxicS7ig21wSWAsE7qun1PRy2imF9HeK5mcm0Fdm34DN/bbjS0U85rvb0AX+YxfiryPbCfN2/m1DYOD+4vHcYaFoONJI88vW8gXdMEkI2U/YvXtGJ9F96Pi14oCVYq64s8Y0oS0nRZ6t/z7ZWQbaMpwWI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEBEqKqA7iCm+KmSP0HqBc3BzXcAJJq0BwRgpVVeKfk=;
 b=AnSt9qZLSku8IYIySet92jIngBS0xVuCpkVc8E7ew7XHz/tTyO0kt6zhbwshR1vpUzKQPaqzGfhcL3B3egHI9XMom/9Wqvdpq7nP66LHiluUxxJX/tBTckreh30MXrgXnMNk8wALNXxTfvXO6RXXklBZfgZc9QdKQb54RB9BcMzqeBWxJT26VP+tPG62hNkECgWgQs39s9chS3m38FLSpP+fieiYzP8kq2u81v7Pf282/A6cIzdMP4J8FZme9cNr2sPBwC5Enp6GHSx5rmJErz4sHLlbtn3rFJPBcksU6dsij4V4bNgfgvaIb5Z9tD2Rcjiyo0EmiRcCP50s1L2OAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEBEqKqA7iCm+KmSP0HqBc3BzXcAJJq0BwRgpVVeKfk=;
 b=Gi8POD9k2yEB/Dld1hZhzYUqRirs+P+aMbrUvZTrK7UGzwsmlztMgaq9iy8J0F5TNu3z1u4DXiw7wbSsHrNkawFjZgWpQFqisdcGeo/ZojrfGdr9E2XTbsWkbIJbxx4rAXZcBloV/ajXSZSAsTQ20F21w18U/2OgwJPmE2yulAs=
Received: from SJ0PR03CA0089.namprd03.prod.outlook.com (2603:10b6:a03:331::34)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 06:22:53 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::5b) by SJ0PR03CA0089.outlook.office365.com
 (2603:10b6:a03:331::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Fri, 5 Jan 2024 06:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 06:22:52 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 5 Jan
 2024 00:22:44 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
CC: <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, "Stewart
 Hildebrand" <Stewart.Hildebrand@amd.com>, Huang Rui <Ray.Huang@amd.com>,
	Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [RFC KERNEL PATCH v4 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Date: Fri, 5 Jan 2024 14:22:17 +0800
Message-ID: <20240105062217.349645-4-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105062217.349645-1-Jiqian.Chen@amd.com>
References: <20240105062217.349645-1-Jiqian.Chen@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a331728-29ab-46e1-0d3b-08dc0db6bf8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1RJFOBH2EQw+BwQCZTJX02YzJm8vOWMFi4e3B/Wv6JhFbstCIk4TolRme10eQRaC89MHDZoeSE96Qh9R3fjSq6vc3uL7Xm/DFNHaXIxFh1qhk/yuEnOPE1IVxUpFZt7KxGSyQxiplr6ZWiBrA8ALsZGNSDP33d/yHEHckgaH0d/Z4JjhOTGmv65+PnsN2zs2B9dmBRwWxZJTfgXa8XVBPJGUx2+y5MKezk+jErj/hPkGJ0jyNIFhxCdz3Fa6CD/eocmGrbU5gwoYzIgpdmBnwrQkFnjmcmIhRG+3O036CrjJsHTqD7XOz1gkbo5dUsDE32IQNAa9UXEslF531UGGcz6ZZ2NS9alBSETxr34qhkaehJDKJp1D0FwRliPjGU29FqZAT4C8BNobBgavvATehSLTqT+86r4uyE0nS0lauqBOPOLmUrHKLiod3uCYNNznLHn/E8xN84Es1auHj9REMGJOXZsoQ3aA0SNVCWuE/W8vl3BDBdH6IFV3KQz6nBXp/Tw5Wr7mi4xkAYrHGzA8GntdmsU4Cnm1lKS0hfdeMJm3dGAngznjqd6vw84E2Wquly3NEodiB84ZxNpk6XmX7dAUHpdgJ11MEzsoBwkL3Ig9FT5+9kaqwi1K9VfbVl9FecQdOrdpU1dVB+9ShwUXncsDhufhixZamzl+Kk9ArGrTvBwZoQOTiMRiE51Btr+uDT9cZ7xd/bpO/2Inqk8HnT0R0kiF1LBdsEUIY3zHPQFaK/KPsz4OkxNmS8ajEtVF90mZPB7gTbDAu9E3hSmCuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(2616005)(336012)(426003)(16526019)(26005)(1076003)(7696005)(6666004)(86362001)(83380400001)(4326008)(316002)(54906003)(110136005)(8676002)(8936002)(7416002)(2906002)(36756003)(5660300002)(478600001)(70206006)(70586007)(82740400003)(81166007)(356005)(47076005)(36860700001)(41300700001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 06:22:52.7600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a331728-29ab-46e1-0d3b-08dc0db6bf8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507

There is a need for some scenarios to use gsi sysfs.
For example, when xen passthrough a device to dumU, it will
use gsi to map pirq, but currently userspace can't get gsi
number.
So, add gsi sysfs for that and for other potential scenarios.

Co-developed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 drivers/acpi/pci_irq.c  |  1 +
 drivers/pci/pci-sysfs.c | 11 +++++++++++
 include/linux/pci.h     |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 630fe0a34bc6..739a58755df2 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -449,6 +449,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		kfree(entry);
 		return 0;
 	}
+	dev->gsi = gsi;
 
 	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
 	if (rc < 0) {
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2321fdfefd7d..c51df88d079e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -71,6 +71,16 @@ static ssize_t irq_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(irq);
 
+static ssize_t gsi_show(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sysfs_emit(buf, "%u\n", pdev->gsi);
+}
+static DEVICE_ATTR_RO(gsi);
+
 static ssize_t broken_parity_status_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -596,6 +606,7 @@ static struct attribute *pci_dev_attrs[] = {
 	&dev_attr_revision.attr,
 	&dev_attr_class.attr,
 	&dev_attr_irq.attr,
+	&dev_attr_gsi.attr,
 	&dev_attr_local_cpus.attr,
 	&dev_attr_local_cpulist.attr,
 	&dev_attr_modalias.attr,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dea043bc1e38..0618d4a87a50 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -529,6 +529,8 @@ struct pci_dev {
 
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
+
+	unsigned int	gsi;
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
-- 
2.34.1


