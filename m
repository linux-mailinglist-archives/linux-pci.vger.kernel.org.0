Return-Path: <linux-pci+bounces-731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC0680BC19
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 17:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CFF1F20F42
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEDB17725;
	Sun, 10 Dec 2023 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WugWokQl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DE1F9;
	Sun, 10 Dec 2023 08:15:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUWM0qutTMMeenq1MAyWuVl2Ac5ZfWwhPASMMvE2GSw+WDK+mVtuvTmI1FqK9Tv844TlloXulWGi0GM+Wbozm227Icaa8EarXa7EymGB59jS2uQRkhFMlYEYy2EznTURuH5mhoPv4KHuQay8Sz74nQrDaXltiUlUSsEkPfF4I0cywXVw8L8idCCnwVyKbua+Z7amVSSU2n4nmdcivo31jSW+r/VETyi8lv9aY0EfrS4IWK49UBv6gEdEtbM9myavz7Zgp4tDnWpWUHdC1ZMZBlvOmryqyvdTsCRIbip37uqBEBaGlgljPgJ17eMvRGwj4EVBWxhIf62gr8XUjx91pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0cVJClnKI0t+S5tf/NWGenaSQY7dTKBr3BxoBA+0yg=;
 b=UGztRtYOB+Q+UbXi1c1mBnPetxV6zNQBSEpx14ozt2mYiVEcHsNm6kXEgpYnoHP1ir1uB5FzMd6/H0ZdmhvPxt+3qPfPv2/8FdkMz+ihTc3E52daGSxTF2SePhEO+64i0Of0/QNKwNpBq3tKrf/UwDOFjfXA7yLg/zFcxiQ2VpKNvxKgK2QtXLLEqMhCSTEQ5syHHAvrEFSiY2S/C2LOeaQYIUd9iFmoFSZUzC5Dva1Q6hr/lTTr+4OC3jD5pRz/K78VhZknx2FYp72nKXpoPBvaiAt97UkMBNPQQoeBaJUPNsz7tQyVqo3toqmy4hv2EKHOkLdhdVQejx9ek9AxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0cVJClnKI0t+S5tf/NWGenaSQY7dTKBr3BxoBA+0yg=;
 b=WugWokQlCzKNdd4LZfCYgc+CgdEVr30USTES9WYlFrNv0avtgUNI3BLKYEstMgOs8j3ZJi8rZetjo4RCoYmNy6/stV0D3ymRkhGwI93bHS84nrvy2Y9O6df739q6UtYQT82XKys/IfhlBDvPwcLMSqji9theFdFLwSeYF3IIIe4=
Received: from CY5PR17CA0058.namprd17.prod.outlook.com (2603:10b6:930:12::20)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Sun, 10 Dec
 2023 16:15:45 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:12:cafe::55) by CY5PR17CA0058.outlook.office365.com
 (2603:10b6:930:12::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Sun, 10 Dec 2023 16:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Sun, 10 Dec 2023 16:15:44 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 10 Dec
 2023 10:15:38 -0600
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
Subject: [RFC KERNEL PATCH v3 1/3] xen/pci: Add xen_reset_device_state function
Date: Mon, 11 Dec 2023 00:15:17 +0800
Message-ID: <20231210161519.1550860-2-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ff42dc-c1c3-4b41-b08a-08dbf99b42f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sjxsHOhfjm4BdqjLcc6/A0HrcK0KDCJsgTUEjobA6Pvj1fuXPvL4dSftfmoeOMf2UhVA6hfZyw9uVwKZj4Vw2uOm0oaA5K+HCXjGTXIu4M2kX/mcvCF7Aq4B64EVGrGo3jcuEAAL8l2rbWzms14he+qH1D8ORQ0ZwCE+WpCEUxUxuMeMmn8iMd67jyx3k58xXMe7PDrm4rtnhfeRh+CmY7A2crE03Z8EsjCmmWqouYzyO8VxsJnR9RtQg6Ht2RKyOrU9pwyhGvkTKLy4X77UV6U4XGSk56m+ueiIl2kgtAscsusRP3O4emgXv9jsPmNuXNRnQR0Yr1Lg5pAdx/rmGy/sXFN8NAISB4d4fbReLDTLgXTo9R1tBTfz8EhcYdbegFcDV+7b8gAJ0wTZq9ENjRsWtllmkvMBl2QT0bgD0o9dmvjNT6B5SBMw85ldmFL4BNNQ8nNdCjswyvzo25JHaT19C4Z3xZOF8WAedafYzqZ7kiTPY296Gw6d56jpepby+mjgyas/uRvFE0kxLQ+d25jMxJ39zjkf6T/ezvjE0ksXT70NrcYSC2x637hrYThr7db489RheqQ9U2W8ckGKJSOYvKD6nSl8+vVZ9ZZ6lOqkKT0wGU8HMxAjC0beus8YD9Bj/kY8NaDokaXSK+hQG3bPmnkkysOMc59R6woEcbrM7VCxCPAmo1nSBlq+ZpAGNAotujG/dujiql/ieHqAGEXiFEMT2cRKo35gcuC58EykX7QHDXV1XPSUIsprn5KkyerRYfNecvW6Vc0Bhw4YNg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(41300700001)(5660300002)(7416002)(2906002)(2616005)(1076003)(6666004)(7696005)(36756003)(478600001)(36860700001)(47076005)(81166007)(82740400003)(356005)(426003)(83380400001)(336012)(40480700001)(26005)(16526019)(8936002)(40460700003)(8676002)(4326008)(86362001)(54906003)(110136005)(316002)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 16:15:44.0477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ff42dc-c1c3-4b41-b08a-08dbf99b42f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216

When device on dom0 side has been reset, the vpci on Xen side
won't get notification, so that the cached state in vpci is
all out of date with the real device state.
To solve that problem, add a new function to clear all vpci
device state when device is reset on dom0 side.

And call that function in pcistub_init_device. Because when
using "pci-assignable-add" to assign a passthrough device in
Xen, it will reset passthrough device and the vpci state will
out of date, and then device will fail to restore bar state.

Co-developed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 drivers/xen/pci.c                  | 12 ++++++++++++
 drivers/xen/xen-pciback/pci_stub.c |  4 ++++
 include/xen/interface/physdev.h    |  8 ++++++++
 include/xen/pci.h                  |  6 ++++++
 4 files changed, 30 insertions(+)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 72d4e3f193af..e9b30bc09139 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -177,6 +177,18 @@ static int xen_remove_device(struct device *dev)
 	return r;
 }
 
+int xen_reset_device_state(const struct pci_dev *dev)
+{
+	struct physdev_pci_device device = {
+		.seg = pci_domain_nr(dev->bus),
+		.bus = dev->bus->number,
+		.devfn = dev->devfn
+	};
+
+	return HYPERVISOR_physdev_op(PHYSDEVOP_pci_device_state_reset, &device);
+}
+EXPORT_SYMBOL_GPL(xen_reset_device_state);
+
 static int xen_pci_notifier(struct notifier_block *nb,
 			    unsigned long action, void *data)
 {
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index e34b623e4b41..24f599eaec14 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -421,6 +421,10 @@ static int pcistub_init_device(struct pci_dev *dev)
 	else {
 		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
 		__pci_reset_function_locked(dev);
+		if (!xen_pv_domain())
+			err = xen_reset_device_state(dev);
+		if (err)
+			goto config_release;
 		pci_restore_state(dev);
 	}
 	/* Now disable the device (this also ensures some private device
diff --git a/include/xen/interface/physdev.h b/include/xen/interface/physdev.h
index a237af867873..bed53afc4c52 100644
--- a/include/xen/interface/physdev.h
+++ b/include/xen/interface/physdev.h
@@ -256,6 +256,14 @@ struct physdev_pci_device_add {
  */
 #define PHYSDEVOP_prepare_msix          30
 #define PHYSDEVOP_release_msix          31
+/*
+ * On PVH dom0, when device is reset, the vpci on Xen side
+ * won't get notification, so that the cached state in vpci is
+ * all out of date with the real device state. Use this to reset
+ * the vpci state of device.
+ */
+#define PHYSDEVOP_pci_device_state_reset     32
+
 struct physdev_pci_device {
     /* IN */
     uint16_t seg;
diff --git a/include/xen/pci.h b/include/xen/pci.h
index b8337cf85fd1..b2e2e856efd6 100644
--- a/include/xen/pci.h
+++ b/include/xen/pci.h
@@ -4,10 +4,16 @@
 #define __XEN_PCI_H__
 
 #if defined(CONFIG_XEN_DOM0)
+int xen_reset_device_state(const struct pci_dev *dev);
 int xen_find_device_domain_owner(struct pci_dev *dev);
 int xen_register_device_domain_owner(struct pci_dev *dev, uint16_t domain);
 int xen_unregister_device_domain_owner(struct pci_dev *dev);
 #else
+static inline int xen_reset_device_state(const struct pci_dev *dev)
+{
+	return -1;
+}
+
 static inline int xen_find_device_domain_owner(struct pci_dev *dev)
 {
 	return -1;
-- 
2.34.1


