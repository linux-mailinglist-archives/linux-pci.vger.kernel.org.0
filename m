Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C40A7B59C9
	for <lists+linux-pci@lfdr.de>; Mon,  2 Oct 2023 20:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbjJBRtZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Oct 2023 13:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJBRtY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2023 13:49:24 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D8A90;
        Mon,  2 Oct 2023 10:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FE8nMnO2c6JrvJQKM+5jBe6oj7AjfjbYwhHxCvQex4WHKz664NbJfsZlGosUNIO1FKKKgoNsjKO/LSkrtdaBf/LEDdqlOxfWXA7HCw74IKoYD5azb0+N5ZDcNGvh6HspGB7dscycoKG6KtFaZlClmQge4FgitfCXpSdhpXGN3XOo/bGwKmdkVNGPb7Q9XNg/cWDTqT4trEoiCRaR1vb8e5rqni3N8yD26z8pEwEDMJRbyFu1O3g2ELPVa2/i3ouhTIXVqdbgqXpQZd9BSE11jdCv2iPQIbw4ZstgpBQV2HmMSujs6Aquf/YhXezK7ngAJ+wpXn5/xdijzuLTlIMXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPMeGHVanzPVrpaYz5YymxFowD8wx3CRT3mdwr6axzs=;
 b=XSnevzHnEFqD6VFKPF/cy6GlY4ix+bOZk9tPW3J6zHpOWAq3IgZ9AQnxxDnDV1KKznDbjUIjQUneRPaYDoUBs1DyjYeUfvyb2GYekkYYybL6bVzI99JH5alIfk0ydTj2TiSEHj32McQAHmXXlYvNw0h+dY+qjCUBVwNw3EJjeICu6Asr/84BpWKG28yrWJrNuGk+OZ8TTqH7oE0UmQG6tyk5ao65xBZZgiayIM8XoDE/0xQkpbUKnimi3/Z4MSHjY1WzJ+SV0qnBWEpGGjvTWrl8pGq5KJXaUTS1EfkFQ9+f02x+PK6qrZHV1O79YWbiR0efJOlhduw03IQTjw80VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPMeGHVanzPVrpaYz5YymxFowD8wx3CRT3mdwr6axzs=;
 b=dXSqjVU/YWxMqY/QqrbKwlUtJB9TOjHrVUBogS8q6YLp5zl6oMZUmY39xOHzbGZ4SRpb+2Gfj3xTGnJc5Hs/OcEA94MK1qiiiGJJyIXpkOdsChOcPM7KtxSdm0QiheCgn95a4DH2MGr1TxT1we3JdvfE4hOHkd6jNf1pHI/u6xY=
Received: from MW3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:303:2b::14)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Mon, 2 Oct
 2023 17:49:15 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::af) by MW3PR05CA0009.outlook.office365.com
 (2603:10b6:303:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.23 via Frontend
 Transport; Mon, 2 Oct 2023 17:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Mon, 2 Oct 2023 17:49:14 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 12:49:13 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <bhelgaas@google.com>, <lukas@wunner.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] PCI: Make d3cold_allowed sysfs attribute read only
Date:   Mon, 2 Oct 2023 13:10:25 -0500
Message-ID: <20231002181025.82746-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fa1525-c551-4ce6-4968-08dbc36fe4a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWyReT9rSb0/aLUuGfWU1aA7cNGR8QYbtYXz1sJnBgr5LJ3iwBe/3imSpZpFSfJDhNSNUoOoeET4cukPnOcV7bTmo9A6PdWI+mbt2xaKN/+fLCg+PE936R6jLxzy9j/U30XOVoaFLiEWTKgNRKOL++JIhOO3oDADTI1Dfh6J29lMH7I4WZwJSMAOU9b70KZapo+3yHuaK9u679IAEPFehjsl++20QLa3iL94kGX0oE0j9Z/tvK8e3VZqa64las4SYaPQss29yUT7Pe/UmngiREfLvzIyrRZOOOLZL1IJvhYt6sazyyciPO0dZY3G5uuKQ5ItBkASW2DKIeN0CeaUsVUeW+gc6YfQaW4B4IwYRdSXM8TWyhYa2nBXqTL8Xh20yd2gviU0O1f2XM/bvalmlcv18PeO8RWysvtbNyPCXB3um3tVxY2Ldi05bQJWxr/3S41OcAU1BKT6IXfxaK5w00VL6VKug4tsZu9qp0ym8LdNpCej9PLN1klHH+cszCG/ui7c4gM6Gkijehm4R6bSt20CAQdibUeNSr8hRCM0kT29DvKdzMnPs820idR/j0nxfcB55qhywYY+iJk8pqhjdzyR5lcrwVGdq8UydyZpfRNXKHOGDxE5+4G0BYZzEjgBgOANHOm08JQ/XXWIYKeQBR3IhUuH75myOukVKvolYu5ntdFhGL3wbLkuVrcOSWs55PzkkreAsnkeGvORw9jrcsT/0K1YAVLx/6IftCni1UNiPlr46t4CYae/HD/+7anoJ4OD6TBElzJyLaBq/e0yQlC1ert/4cIwaLUEnsufN5w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(336012)(70206006)(110136005)(40480700001)(54906003)(316002)(41300700001)(478600001)(6666004)(70586007)(36756003)(86362001)(40460700003)(2906002)(8676002)(8936002)(5660300002)(4326008)(1076003)(83380400001)(26005)(36860700001)(426003)(2616005)(16526019)(44832011)(7696005)(47076005)(356005)(82740400003)(81166007)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 17:49:14.5899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fa1525-c551-4ce6-4968-08dbc36fe4a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Before d3cold was stable userspace was allowed to influence the kernel's
decision of whether to enable d3cold for a device by a sysfs file
`d3cold_allowed`.  This potentially allows userspace to break the suspend
for the system.

For debugging purposes `pci_port_pm=` can be used to control whether
a PCI port will go into D3cold and runtime PM can be turned off by
sysfs on PCI end points.

Change the sysfs attribute to read-only and simplify the internal kernel
logic to avoid needing to store the userspace request.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  3 +--
 drivers/pci/pci-acpi.c                  |  2 +-
 drivers/pci/pci-sysfs.c                 | 22 ++--------------------
 drivers/pci/pci.c                       |  3 +--
 include/linux/pci.h                     |  1 -
 5 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..436e25cdf3ad 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -283,8 +283,7 @@ Description:
 		device will never be put into D3Cold state.  If it is set, the
 		device may be put into D3Cold state if other requirements are
 		satisfied too.  Reading this attribute will show the current
-		value of d3cold_allowed bit.  Writing this attribute will set
-		the value of d3cold_allowed bit.
+		value of no_d3cold bit. Writing to this attribute is unsupported.
 
 What:		/sys/bus/pci/devices/.../sriov_totalvfs
 Date:		November 2012
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 05b7357bd258..a05350a4e49c 100644
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
index 5e741a05cf2c..8c120f6778c6 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -519,31 +519,13 @@ static struct device_attribute dev_attr_bus_rescan = __ATTR(rescan, 0200, NULL,
 							    bus_rescan_store);
 
 #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
-static ssize_t d3cold_allowed_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
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
-	return count;
-}
-
 static ssize_t d3cold_allowed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	return sysfs_emit(buf, "%u\n", pdev->d3cold_allowed);
+	return sysfs_emit(buf, "%u\n", !pdev->no_d3cold);
 }
-static DEVICE_ATTR_RW(d3cold_allowed);
+static DEVICE_ATTR_RO(d3cold_allowed);
 #endif
 
 #ifdef CONFIG_OF
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 59c01d68c6d5..8c5a6f68f63d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3067,7 +3067,7 @@ static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 	bool *d3cold_ok = data;
 
 	if (/* The device needs to be allowed to go D3cold ... */
-	    dev->no_d3cold || !dev->d3cold_allowed ||
+	    dev->no_d3cold ||
 
 	    /* ... and if it is wakeup capable to do so from D3cold. */
 	    (device_may_wakeup(&dev->dev) &&
@@ -3204,7 +3204,6 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->d3hot_delay = PCI_PM_D3HOT_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
 	dev->bridge_d3 = pci_bridge_d3_possible(dev);
-	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
 	dev->d2_support = false;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c7c2c3c6c65..5f4ed71d31f5 100644
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

