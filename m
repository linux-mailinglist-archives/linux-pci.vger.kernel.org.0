Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF07A3CAE94
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 23:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhGOVfJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 17:35:09 -0400
Received: from mail-mw2nam12on2082.outbound.protection.outlook.com ([40.107.244.82]:5345
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231405AbhGOVfA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 17:35:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDYZQeihnY8IxcXoaWA+0THXoR9Ziub9sl7RxyKIOu8oa12qRnKvxVJE+nI0mM2yDCQVrjEj1Hok8ncPqrtsDqGpT+rhvNXfOunQN27DMLhjG1RGBfhrb6uM6XYDigzdc0Kgu4AIZCqeJjn5pkmlaXOy8uh6BTi9SyPQ0dj4pQCgOyYvUjjZZwJQs3j3X3Su43+VhLLNVjHj+nT56RrKY5JjYnNlFw/y7fX4bmx9yDnehxqPOu/lNDwsqKhRnfO+ZH+1aEeQjl361Q+EjdpU8xynGtC+dBj51UP3ahszrdBjcdCPbWGC82hBubxG1+pWA1e0a619l/L+io3hCKaWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPy1cW+x+aIesqEakKo/iI1KkcGL54cHthCCKR1n5DA=;
 b=V6Y/CeuQqs0mHkUzhVsBf1akQcp/7fVSYv8XI4xHC1e0EF+WDFLqI3Di6oOhUujrh5r40jgNr2eZk68SfxDMU6vpYI0KlldB3xO5BnY3dkm1o/zvlNIpcCzHJFTUWWTODV8N1QFblMHUrq0XX+jYDn+79Fbj/t3j7RHd8i+5/GUshQh9ROtgN74jT7xSdRBXLuSrVkLjNCimr6LfUdWBeZDjbRaHXe0M66Yw+dVZuZkgG8VNj4zn7k9lPyPPP6YYh1jbQ9xtrpWIYEGQozNI2S/iDMuIXKIJjXaXk3gSkzucqvM1QjUFbdXOK5ly4IM61AtJxIhkD7rAcesMUy+8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPy1cW+x+aIesqEakKo/iI1KkcGL54cHthCCKR1n5DA=;
 b=AdNMLs++2R+slC3sPYVaX3Sr0ekOqemZZjoxQpW1blkxMvu4vkly7kLvZCEnB0XJIECNKjgbDJRyRNNH9CN5ZyKFB5n/eFbbJCEWmtjW6WqhDEGLzDS+bFyJ3GH/yurGONM//TG/tEz/ixlsmNgZFP7SvLW8m+V7fGd7IaqjSkLSqKX1iRfK0YFMZLKgIO0FodzcV6IG2TBx+Sud/1DgDOrJpjSKErLEl91jWoiSylmXQ4ME+Sxeg9COnWZVPqQfElICRo4EVKnfISzYbrSKJqJzp4EQXYyhzOdbW8DojRp2jcx3d2m2m8gFpBzObGgtlInYPmulMqdfzwBmgiiCUA==
Received: from BN9PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:fb::10)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 21:32:04 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::d4) by BN9PR03CA0035.outlook.office365.com
 (2603:10b6:408:fb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Thu, 15 Jul 2021 21:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 21:32:04 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.187.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 21:32:02 +0000
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
Subject: [PATCH v11 4/8] PCI/sysfs: Allow userspace to query and set device reset mechanism
Date:   Thu, 15 Jul 2021 16:30:56 -0500
Message-ID: <20210715213100.11539-5-sdonthineni@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ee13e45c-b2bf-4c79-eaf2-08d947d7fdaf
X-MS-TrafficTypeDiagnostic: CH2PR12MB4054:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40548BE05B83B0ABD93C08DFC7129@CH2PR12MB4054.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lEYqyh4YkfU9/XGFJ/WxlcwkUUI2yAsngEinmJYgKwPMC0YnKKSK/c6kJ8OvMQgqzBfMX0p7ros07dD9Cs3yLngv2rtqBsZAFmYH4Di5rnnBPg4HMVHMYqjidwOoRYSaEOTlnYr5OS7U81rcURGaVPekVfkk5R2sx0l4k2K8rNKH/MeNdXR2Ggcs/2iIBkzTQ4xRpywYzjKUPEdBNZQkRZ/JS9srBCJ4TjJuekOQ8tir2b1H2l31j81xKeUV5ehGqfSBMNg9n2g4+XRxkNj4uWMZ3ffaTDdFy0aLrSD2CxccS72+GhlgnlyKJ6/yirMDWcHg36nKQprSEXKWU3PSA8esAueUKlLFpATDPp8PC7aSdUvbDGDzXGTMXThP6TJuDqT2CanNWtA30lSzR61ljViK8ixPW5BSGMxZLqzWgWu4cP6J6CVigOHWKtw8qhuw9IIzmW1u5Klg/M6vKHNAJDW4I0aYopVIxkpjCfhnrqz38qxOnXrPZUJn+bs6MYAT9omkcbRFwMCTP5MWqhjJYqJUOwnNZkxeQ37+mv4/vaeKmFx9QMLg0LxKPf0rN7ybstC9vs2WR6ADzgRPpGTByirimSyYLExNbw5hVg5ij4iZYIzyUPnZTD6HribHGsLchmHtX1vW+oqjenYsD9ibV0nqLBnY3D6XM6quxQJ91v7yi/WJK0BIL1MX3hSuSXb1Tr0BxIVnuOwmKClF1UtA8luaRXfSiNQiuiaS18r7r8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(46966006)(36840700001)(83380400001)(1076003)(186003)(4326008)(8936002)(356005)(107886003)(26005)(54906003)(316002)(36860700001)(36756003)(82740400003)(34020700004)(5660300002)(16526019)(2906002)(47076005)(6916009)(36906005)(8676002)(70206006)(82310400003)(86362001)(70586007)(2616005)(426003)(7696005)(6666004)(7636003)(478600001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 21:32:04.6432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee13e45c-b2bf-4c79-eaf2-08d947d7fdaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
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

