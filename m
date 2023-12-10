Return-Path: <linux-pci+bounces-733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7194A80BC24
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 17:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C00A1C20895
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43BB1799A;
	Sun, 10 Dec 2023 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z/WxThTi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E980FC;
	Sun, 10 Dec 2023 08:16:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWsm5GfVnWDAEXOev3qPy+9Oo9vEhjgojvAJvK4SYd3C8XZeE5kkk5t/e8sLO/y9nv6rFRXEnGMbM8d86r0PsLX6PXK0En3bY7BKmaBr5hlqW68hZEWDUcLzE3ryONMMkK2jxYfUotH5wmzxIXtB1Bt4ViOyX3vAgGuzyK5jrewKQ+Mrhd5f2UMPwsq34R+vQp1Rl+6cJTpR1QCX3Dn3rqRrCH+0OQomnRcPyz+7EyjxELwadxIHV5vXn8teFvD8HDseLhqRp0O52UxtBkKPLkCThUlGx6fOEowBFxbr3oehXSfgy/7xmNQiyQ5o/V+Lkor7AFtf11aXdyONNX5FtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1QqKGxeBunvmatxkoJCYLpxpTTAmq3J1BXHqGyX7K8=;
 b=NaXUasULf+3697EMIzz8bb3avdG6J6+LdQheCObV0SzYj9e7F6umiXKM75067Qi5uM6gckQYhRlf2gd5dFef7pI3OHh3i5/Pt/i+oKLoO6JxnY/rS6CdD9jTE4V+ymyqg1IsW9xfLAeIEpw4I54p9c/6QyjKyZJko2H4ADmwjoHcsvY11RnknJxqTEAO/zQ0lCxCbnzmy+ju7p4XFrJlgpuEntv5x3w7ACm7D48nutFVx1oLcqHLFNClL8FwVFcazYUeEajBvFYjvQYaxagbD2wqK0mjbgrHXCfKls7IO2bO2HHlYGYoNSy2pnwjQAfelJ5RpV1fCBFO3Ck+Qr3V1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1QqKGxeBunvmatxkoJCYLpxpTTAmq3J1BXHqGyX7K8=;
 b=z/WxThTiyvBGs/YY350WLQvRTM/LIqdbOSDOZTItL6Md9SPEeRdNzoCcYxg8DEOQ2gJAxTEYWzSdz2bDtrTZa/Bf+RzvQiIVcutqYa7l/xvdd/d8UngQBMqKcs7gpUAKKuAGSvujvnZS1bzxr1NTH9h8UA920ycc9u+6KBMXqmI=
Received: from CY5PR14CA0030.namprd14.prod.outlook.com (2603:10b6:930:2::24)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.31; Sun, 10 Dec
 2023 16:16:21 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::a2) by CY5PR14CA0030.outlook.office365.com
 (2603:10b6:930:2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Sun, 10 Dec 2023 16:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Sun, 10 Dec 2023 16:16:20 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 10 Dec
 2023 10:15:49 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <xen-devel@lists.xenproject.org>, Alex Deucher
	<Alexander.Deucher@amd.com>, Christian Koenig <Christian.Koenig@amd.com>,
	Stewart Hildebrand <Stewart.Hildebrand@amd.com>, Xenia Ragiadakou
	<xenia.ragiadakou@amd.com>, Honglei Huang <Honglei1.Huang@amd.com>, "Julia
 Zhang" <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
	<Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [RFC KERNEL PATCH v3 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Date: Mon, 11 Dec 2023 00:15:19 +0800
Message-ID: <20231210161519.1550860-4-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
References: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2f23ec-1ba0-46b2-0375-08dbf99b58cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7cfoB48RFii35Dpa6TXwr7UxlCzYNwfbaERgbGp/VozX/bPoP+7GQKkXxKnbh7P9c4S1i/ANYjSywduz00puSxzU78+U7XlSAKk5dTeMTgG6vGBlrZyMY8Zhz5AScY0Tn8eGITwcP9NUGEKY0dpoGCUhhQKc7oNWLYIxRHRRHOfh0eBJPe+Mr3jHEBhlH2BV9CQT7xlwgE2uKwv1DrHy12MjwsrGW3qvxpfnsZPlzvVJWMJF+I/tyoj5AO3kjb1QpO/8fJahQBfoRGED+kCF4IAQDdbao/hXKt5kX6DghX4l75ZISl0ev8OfnWE3b5mF6oRbd6O7qJZV8kx9FrsiQFK2Jyt1Kr3VlOH4CUBQimAHcDJOB/WHZ56GfF3fdNknTAxdQryfH1dTx9a/UF6VVps96GdlMl0tKIPT/1SPdWImr04VRcoS/5cmkg8nRAIm0M/glfUUIIoluQLd+u1niu4TO94nDm1GwU72vr3DbV2jd1m4zOV7qijvq3FJwN9U9EfL5CAd5XkvAQ4EB1S9aCNn+Y1ZqLmHKjFM7MBAyk2pJxkMmuZyx0XPWWQE4clL5ROBI4HDG8u9sey//vLNJfMglx0RdiSEDVWSMtZxQsr/gnkldZ6wEnHbDszaNz0gUsaWLH1VUu6DdOZp7u5j586pAZQbyUBpIFzo0Rs/zErO47zc/3NtUu3tLFhNtQ22mZ7yfRPuksJOpdU2C3mdiGuUCk1FQWqrA4Qq4CKnk+xfklxcmldrIiUQCEMbdekINtRHBLsjPXosJjj1c7GuHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(46966006)(36840700001)(7416002)(6666004)(7696005)(2906002)(54906003)(70206006)(356005)(81166007)(86362001)(36756003)(316002)(8936002)(4326008)(8676002)(5660300002)(40480700001)(70586007)(110136005)(478600001)(40460700003)(41300700001)(36860700001)(82740400003)(47076005)(26005)(336012)(426003)(1076003)(2616005)(83380400001)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 16:16:20.7041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2f23ec-1ba0-46b2-0375-08dbf99b58cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418

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
index 60ca768bc867..7ef9060b239c 100644
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


