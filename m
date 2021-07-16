Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B763CB9BC
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbhGPP1d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 11:27:33 -0400
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com ([40.107.236.67]:35904
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240866AbhGPP1a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 11:27:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U37IcBeMST7N6a+dmaATLAd1u+2DY6XANUTy1IbdaV9A8JErVnR2DpPbZEmlgqCED75EzT7s3w9dJEHnmLSr8ySfc1L6IjH9k7cd3OAZ3Sr4HP05JMLJEL6NTijTaj76ke6Q4btLcNz65SEjrgNqOz/pApqzqKjFVkdbxP5+s48erosMg8rLIYCl0rjGX0AW5REtXhY/24GoNnDo+KrlcILEgP+TcATmbNz1LWQW+QfIVgqW9IDuLPcf9TPtBuwsyS9i/njppb/2Ewdx3dIQmOoIc3AQk/I62M9yF1xzth1j7o1fkT1f6RqYYoZ6+ZwtsLIx/g0YQUZ3K2QRiMS8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPy1cW+x+aIesqEakKo/iI1KkcGL54cHthCCKR1n5DA=;
 b=HFwRrgtHku6gxu8sbVpas3fiwaPeGMgn7JlKUwO5vrJA6CaAMfQXA5XCXeh5pUOnuvlEODsu9PuOZzm4JFGmSefHqzlZBDXPl2sd59Y8mXP2q2MVL68xQx6ppH8K6OyhyCd8ODnRDraZI8k/LpPaLiNexUj8AzvlQ+5J9dXtr5i87pSZuYg92lUP/vB9sXEKzZuXDCrl1Ve1ENn6oy/mMkoOXHm8BgffMe2Ejz72DeujO4qa1eDzCGl1Dg9d1S2bP9BeVNoKWPpRGaswCvc3UURUrW1BUaV5h6XWlMR9msyuN2xHFqYYNs3t56ChWgxXqlKE0eHK0f/KT9HGrexPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPy1cW+x+aIesqEakKo/iI1KkcGL54cHthCCKR1n5DA=;
 b=KIhZCbj3lrxrXaesU/BH/dZYdXxvWO2fM5q3gePScVZkHJ23hSRzK0Lwlc6CYqjr6A4H5JKK0oLak/ZqIExam954iKMD2TCh/rQ6Hpx/br/23ec0kDkN5PQWvAXYzIsz+7KZ0CHZbqmBlQdISHItNS2gUCD+FpFltZ4eI8OP5JpFNDfGtZzkOPoO6ZNDz6yM1x2bJ2SBoWe/5JEIs4c2xn9ACv22Baeewt4fVyNTx6nXB1OzNHREG/PMZ82xAlZqrW6Cwc44u8mkawZ0mzWICgLYunCK40kCk7XsqcWZK95y0Nhc8hBriblEm7wL3DeFuprcO0QalLZAUbrQnFSCeA==
Received: from BN6PR13CA0027.namprd13.prod.outlook.com (2603:10b6:404:13e::13)
 by CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 15:24:33 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::19) by BN6PR13CA0027.outlook.office365.com
 (2603:10b6:404:13e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend
 Transport; Fri, 16 Jul 2021 15:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:24:33 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Jul 2021 15:24:30 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        "Amey Narkhede" <ameynarkhede03@gmail.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v12 4/8] PCI/sysfs: Allow userspace to query and set device reset mechanism
Date:   Fri, 16 Jul 2021 10:19:42 -0500
Message-ID: <20210716151946.690-5-sdonthineni@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: cfa02b9c-fa86-4836-74c1-08d9486dd03c
X-MS-TrafficTypeDiagnostic: CO6PR12MB5474:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54740D8BDA02A5DA34B22F91C7119@CO6PR12MB5474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVR+1S6BwVRvANlBd//7v5GLGLEfziEf3WWpcvdlOTpylbE/SogmO/php8yN3YmMRIwFLwyRHE1wnmkY11YhwdcaugaRKxexnFDMmk117932UnNEV+NcHwemSeKaIiGHa/KlljWgftidCW5fays2syTFsEBjNRose+HS06olDQ53kK2NPeLKx4ApEziEhnpzMtB5uzdUiS9XD8SCBvb6uGMgZb6B2qacIkQGQ/wIbpOrrz+BFgQJID7xotiQVam3EY46/tCAW2FxhT1bR2HE+1sTIjAzV18CDlyHlFmhFo434p5x5Y66NuEeCYXdA0fkyKGAZdNkOBj0w88xL6QwQ2ueZyU9x73Bx7w/U4/iMRG2GrKiEzGxwhgAsPqgmfYOrWXowYZd0SLxl6nujZh23YJC50gDZcry2G/NwAoGAAL3m7jgK+qJN7CR8yhiXceh3KXzZtE67y86CP6q+CR+qaX/Lkk5vLpD9/8Vmo1bl692ZrUL+vb+s6K/tUHZXfaQxu86DXKliWH7aabSV1EwhVrizjF/fnNU6Sa564rfGWvwluR1t/nkDW2ExBsUbY3omt0rorbU/WJP5Sp8C9CU5qoyRD2DcxxlhRue5E+yhRtXHLgVUL2pGBOn2Nawem/OLyQqpVbTWWqIdXz3aIQeg22mdDLc2HGDfYMbW91LYGqSkU8sgO4KuU46pYOP+8ZuCWngsJ/kugkp0qhYksBtC+4coW4gARB3YWUrgCXBTHw=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(316002)(36906005)(70586007)(54906003)(8676002)(2616005)(6666004)(70206006)(8936002)(82310400003)(426003)(36860700001)(6916009)(36756003)(2906002)(5660300002)(4326008)(7636003)(82740400003)(47076005)(34020700004)(478600001)(83380400001)(107886003)(16526019)(186003)(356005)(336012)(26005)(86362001)(7696005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:24:33.0204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa02b9c-fa86-4836-74c1-08d9486dd03c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5474
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Amey Narkhede <ameynarkhede03@gmail.com>

Add reset_method sysfs attribute to enable user to query and set user
preferred device reset methods and their ordering.

Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  19 +++++
 drivers/pci/pci-sysfs.c                 | 103 ++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 793cbb76cd250..beb94b9c18c78 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -121,6 +121,25 @@ Description:
 		child buses, and re-discover devices removed earlier
 		from this part of the device tree.
 
+What:		/sys/bus/pci/devices/.../reset_method
+Date:		March 2021
+Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
+Description:
+		Some devices allow an individual function to be reset
+		without affecting other functions in the same slot.
+
+		For devices that have this support, a file named
+		reset_method will be present in sysfs. Initially reading
+		this file will give names of the device supported reset
+		methods and their ordering. After write, this file will
+		give names and ordering of currently enabled reset methods.
+		Writing the name or comma separated list of names of any of
+		the device supported reset methods to this file will set
+		the reset methods and their ordering to be used when
+		resetting the device. Writing empty string to this file
+		will disable ability to reset the device and writing
+		"default" will return to the original value.
+
 What:		/sys/bus/pci/devices/.../reset
 Date:		July 2009
 Contact:	Michael S. Tsirkin <mst@redhat.com>
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index a1d9b0e83615a..65791d8b07aa5 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1334,6 +1334,108 @@ static const struct attribute_group pci_dev_rom_attr_group = {
 	.is_bin_visible = pci_dev_rom_attr_is_visible,
 };
 
+static ssize_t reset_method_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t len = 0;
+	int i, idx;
+
+	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
+		idx = pdev->reset_methods[i];
+		if (!idx)
+			break;
+
+		len += sysfs_emit_at(buf, len, "%s%s", len ? "," : "",
+				     pci_reset_fn_methods[idx].name);
+	}
+
+	if (len)
+		len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
+static ssize_t reset_method_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int n = 0;
+	char *name, *options = NULL;
+	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
+
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (sysfs_streq(buf, "")) {
+		pci_warn(pdev, "All device reset methods disabled by user");
+		goto set_reset_methods;
+	}
+
+	if (sysfs_streq(buf, "default")) {
+		pci_init_reset_methods(pdev);
+		return count;
+	}
+
+	options = kstrndup(buf, count, GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	while ((name = strsep(&options, ",")) != NULL) {
+		int i;
+
+		if (sysfs_streq(name, ""))
+			continue;
+
+		name = strim(name);
+
+		for (i = 1; i < PCI_NUM_RESET_METHODS; i++) {
+			if (sysfs_streq(name, pci_reset_fn_methods[i].name) &&
+			    !pci_reset_fn_methods[i].reset_fn(pdev, 1)) {
+				reset_methods[n++] = i;
+				break;
+			}
+		}
+
+		if (i == PCI_NUM_RESET_METHODS) {
+			kfree(options);
+			return -EINVAL;
+		}
+	}
+
+	if (!pci_reset_fn_methods[1].reset_fn(pdev, 1) && reset_methods[0] != 1)
+		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
+
+set_reset_methods:
+	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
+	kfree(options);
+	return count;
+}
+static DEVICE_ATTR_RW(reset_method);
+
+static struct attribute *pci_dev_reset_method_attrs[] = {
+	&dev_attr_reset_method.attr,
+	NULL,
+};
+
+static umode_t pci_dev_reset_method_attr_is_visible(struct kobject *kobj,
+						    struct attribute *a, int n)
+{
+	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+
+	if (!pci_reset_supported(pdev))
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group pci_dev_reset_method_attr_group = {
+	.attrs = pci_dev_reset_method_attrs,
+	.is_visible = pci_dev_reset_method_attr_is_visible,
+};
+
 static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
@@ -1491,6 +1593,7 @@ const struct attribute_group *pci_dev_groups[] = {
 	&pci_dev_config_attr_group,
 	&pci_dev_rom_attr_group,
 	&pci_dev_reset_attr_group,
+	&pci_dev_reset_method_attr_group,
 	&pci_dev_vpd_attr_group,
 #ifdef CONFIG_DMI
 	&pci_dev_smbios_attr_group,
-- 
2.25.1

