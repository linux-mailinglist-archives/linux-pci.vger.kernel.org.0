Return-Path: <linux-pci+bounces-395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E06802B93
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 07:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2661F2108E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 06:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3415E9444;
	Mon,  4 Dec 2023 06:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3gwq0Gak"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFF1FD;
	Sun,  3 Dec 2023 22:06:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2EaCgQ3bR7V6CfBoyPg19SkVN8uq4doCyqF0TBVx/YzvZtefq9Wr/wcAl8QBJtdzcx9mCIsp49+CmkYjePqN3y2l0fEKuk9qKLcwStr5p5wxW4O+L5HH48YDs4m+IkmnGOgsRcgYe7GsuZAC7gNoySyTcUHXYC9vttGV+mYG71yZl7w2EQXGqTkuWKI9SaJ37tm2z2sHrwNaFJJBLYHJtdWVvKyXAHtVQKHnv0T0oWvcxatzi8bUR010XHKbrYydx2urnTWNIgUSNWrVm9PyvxdfiaZ9MeWLc7+lIO2NO67hbiPxaZry56X/O2+F0er/E8NWwwTRRmaNuMdWAx8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhGcRqjPHprlxyIB2UmoWBPn+ZVTrkCvsSoe5EEw1sM=;
 b=IED3wNfaVVjqdXvaVjrAvp/SR5Ss8CzkBVkVI7O6V1LyQt4029jfTjz0w4LQs+WIbaxepLijbC9Tjz6uPyNfzh58ZAjtRzJhzY9EOjSw4+jAaKPLfJ+2bz4KvtF4HwtbDGC/odGQ0lj5b56VtOGRF+eXwhJGXgXefqEJpH9pAQgW23FI+otrG3ViFpv5rT66CJQ1lj7xXJ6XmBhlOQlKzZYkQBJWJ6ho3FauwFpXp5vBpjJ8skOfs64AdEPbj28krIH2CGJFbJbhF+RDOcyyzY+QpZ5VbWwWrD4wSpLak4gMmJW04YgRaC+Fhrtbyig72rBAdDnZq+p20BQGF4RbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhGcRqjPHprlxyIB2UmoWBPn+ZVTrkCvsSoe5EEw1sM=;
 b=3gwq0Gakm7kDLQl6QOzbzA4uYVKY2MqdA+Dcz1hEUNcc9b8wEgS2v02y2+BV0PqrWf2APxAJv8eMZw89ix/Lp26bjdzsnUfuwnB3zQ+e0oiga+HeZtqdUZLL9kfy7uMdAQgAukBbPgaDbkd68VdnzUN6aeTcdaZ7I0ld4R4lEsQ=
Received: from SJ0PR03CA0332.namprd03.prod.outlook.com (2603:10b6:a03:39c::7)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 06:06:55 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:39c::4) by SJ0PR03CA0332.outlook.office365.com
 (2603:10b6:a03:39c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 06:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 06:06:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 00:06:18 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Hans de Goede
	<hdegoede@redhat.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, "open
 list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, "open list:X86 PLATFORM
 DRIVERS" <platform-driver-x86@vger.kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Lukas
 Wunner" <lukas@wunner.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
	<linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 1/4] PCI: Make d3cold_allowed sysfs attribute read only
Date: Sat, 2 Dec 2023 22:10:43 -0600
Message-ID: <20231203041046.38655-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203041046.38655-1-mario.limonciello@amd.com>
References: <20231203041046.38655-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: aceb8e0e-9f1f-402c-19b0-08dbf48f376a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WWNPyM9+Y6P+LXaWhbYpiXQL0y/X9RaevI6rjZnhxaqvmZ6aZnu1ur4Suoor0bNdFFFAb6onAlgqGIzqZDNfoYa7eMZxTUpGdWRtSQBwvecPWEIOQz72hbCvnENgePVK7tLCgr4W/t+d8SkHyuQ4J88lVg1iyDzjs39e1A42t2cpdG82LOC4PrBH0ucVxQu5fE7EFXLqdZK9v1zGJRl6sjTHkUyN5Dkyibr9ouYQpN8sR9uiz4FKPsACHCfxQCU5mvpJoQODJXWqUy/nGvkMaPlNkFC6hHspIM6NBYTiQ5h/1i+TntjMbQUyBVy5h6iLl1uXbKgsOukw9YgFTCtuzUIeS/yePbN0UeOW6zcdkU6nL8ZSPQ/jKdu6bd/jEpiAoFK99BSxzaw6aJxWX8zC/vhljaztz8+44Nws+j0B3TzafAVu4zDQ+Qu/4XrFnLZMxsyVVS/aRnSi4axw9NQGFqxSr1E//F5nTAq5L/1o2BnRAF39sxWOI2bU+7LuSVSE9DFNctyX+W6dxoUZLSlQTY2pUjCPyftwkqEGNIRdCUx0heMi3Eaqupka7g/X8EOfce4ZN2E9YH6zir98EPn8iRJpWPFsLRPJwHU9rDkReJrdtVXO+vUANWsHeRlpxBAERA0qRsIL6NdxAR94XvLiL6nVQDzH6vCnO0fvcLV0Q+n6rvOMazzDbxM/FEg4D0I5rUz6MqSjD/jl45Wrg710jyb4rmBRcuFoBR2ZJEXLygETq9XGwCjjdjVWfvdl3ddCYmMUfeC/axt5ayB9rmz8azilfwG2/e3BBeeIxcthya45C/FaW3rWtFNnxV9IWzUEc1fJuxDzyOWzlQwdgvFn8g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(5660300002)(40460700003)(44832011)(7416002)(86362001)(4326008)(8676002)(8936002)(2906002)(41300700001)(36756003)(2616005)(40480700001)(1076003)(356005)(81166007)(82740400003)(426003)(83380400001)(26005)(16526019)(336012)(966005)(478600001)(7696005)(6666004)(47076005)(36860700001)(316002)(54906003)(6916009)(70206006)(70586007)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 06:06:54.8851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aceb8e0e-9f1f-402c-19b0-08dbf48f376a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
X-Spam-Level: *

Before kernel 3.6 D3cold was considered "opt-in" for PCIe devices.
Userspace was able to opt PCIe devices into d3cold support by using
the `d3cold_allowed` sysfs attribute. The policy changed to default
to enabled with commit 4f9c1397e2e8 ("PCI/PM: Enable D3/D3cold by
default for most devices").  The sysfs file remains however and
can potentially allow userspace to prevent the SoC from getting into
the deepest sleep state on modern systems.

For debugging purposes `pcie_port_pm=` can be used to control whether
a PCI port will go into D3cold and runtime PM can be turned off by
`/sys/bus/pci/devices/*/power/control` on PCI end points.

Change the sysfs attribute to a noop that ignores the input when written
and shows a warning. Simplify the internal kernel logic to drop
`d3cold_allowed`.

Link: https://lore.kernel.org/linux-pci/20230918132424.GA11357@wunner.de/
Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  4 ++--
 drivers/pci/pci-acpi.c                  |  2 +-
 drivers/pci/pci-sysfs.c                 | 14 ++------------
 drivers/pci/pci.c                       |  3 +--
 include/linux/pci.h                     |  1 -
 5 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..b5db141dfee6 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -283,8 +283,8 @@ Description:
 		device will never be put into D3Cold state.  If it is set, the
 		device may be put into D3Cold state if other requirements are
 		satisfied too.  Reading this attribute will show the current
-		value of d3cold_allowed bit.  Writing this attribute will set
-		the value of d3cold_allowed bit.
+		value of no_d3cold bit.
+		Writing to this attribute is deprecated and will do nothing.
 
 What:		/sys/bus/pci/devices/.../sriov_totalvfs
 Date:		November 2012
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 004575091596..cf108259aef6 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -911,7 +911,7 @@ pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	int acpi_state, d_max;
 
-	if (pdev->no_d3cold || !pdev->d3cold_allowed)
+	if (pdev->no_d3cold)
 		d_max = ACPI_STATE_D3_HOT;
 	else
 		d_max = ACPI_STATE_D3_COLD;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2321fdfefd7d..084301729120 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -522,17 +522,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	unsigned long val;
-
-	if (kstrtoul(buf, 0, &val) < 0)
-		return -EINVAL;
-
-	pdev->d3cold_allowed = !!val;
-	pci_bridge_d3_update(pdev);
-
-	pm_runtime_resume(dev);
-
+	dev_warn_once(dev, "pci: writing to d3cold_allowed is deprecated\n");
 	return count;
 }
 
@@ -540,7 +530,7 @@ static ssize_t d3cold_allowed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	return sysfs_emit(buf, "%u\n", pdev->d3cold_allowed);
+	return sysfs_emit(buf, "%u\n", !pdev->no_d3cold);
 }
 static DEVICE_ATTR_RW(d3cold_allowed);
 #endif
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 55bc3576a985..72505794cc72 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3069,7 +3069,7 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 	bool *d3cold_ok = data;
 
 	if (/* The device needs to be allowed to go D3cold ... */
-	    dev->no_d3cold || !dev->d3cold_allowed ||
+	    dev->no_d3cold ||
 
 	    /* ... and if it is wakeup capable to do so from D3cold. */
 	    (device_may_wakeup(&dev->dev) &&
@@ -3206,7 +3206,6 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
 	dev->bridge_d3 = pci_bridge_d3_possible(dev);
-	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
 	dev->d2_support = false;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60ca768bc867..2f4f6013c61a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -376,7 +376,6 @@ struct pci_dev {
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
 	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
-	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */
 	unsigned int	wakeup_prepared:1;
-- 
2.34.1


