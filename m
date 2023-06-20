Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0687736E91
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 16:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjFTOXX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjFTOXW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 10:23:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D04D2;
        Tue, 20 Jun 2023 07:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XREvYiX+puiOkmjFsok8BjBtF1YqXTobZ+jyD5XZJ5R1yXe/SRmKe1VU00td01t6seu5C1IyTZZglAMlzYiN+EvW7IzPfWy9V0v8Jt5J10OZgM042Bwr53soJZml3nPiwOg5FhXYgCgP11t+0R58fV1XGpKawTYWR9NHn2caN/a1MdwEa7iwUxA1QfJg0HRRdonNugFywKhk3Haott4i7ywPvBQGNxe3bXrwuVtAvLf/GdULbH3tF8GBqBFX15+YzI7q4zfWWPSNH+qTkNv2hHMK5zmAJMH/iIp5YFPv6SHlvht3J1TTIw14Rc+N2BQbpnNe50Mq4Tt+PgEsA8Msow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd/drUc/rbwrHC/0t7CW4VimIEKKKwJ7ksfC7IcvgTU=;
 b=oLjGw1nBU7LWgXWmVJQr8sX5ZU6pzvBPRm5qEMzS2ZQlcbxcESCSgTqes7ufK99HmOBJrg6nDzTTwy6w2mJQPS9dCRplPXGXBrwm0b5xR0FJwAOD4+hKQkRDqbIWX2T+N0erVa5IsryFLMokvaUuY9dkpoEwnrPP3PT7Pg4Dp4aP8Q27BRpt2Cd65AX9RshqrswfVhksWcP52H28c/3QvT9LiBTDvmrf5FQGxDsEFLI/DI90wlwkN6GvVYLuXv9vyWoXjotP0q47avpifEVJ0YThWneeybLXtaDwauiDaT0DYpLW/4J4j2B1eBpJTUxEVznV1xQIDNXb/XNzhibHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hd/drUc/rbwrHC/0t7CW4VimIEKKKwJ7ksfC7IcvgTU=;
 b=dtqkcN8jOl9LqD/wEfeGntO/vgGlxquiPt6TChuLxKboeJUQ1vlyksm0CjxfMPlQ1R/Zzix7BsE6/VUSuswyRQr7aV30YaKJ4YjCpdNluQOoUwk9C4SB4VaD7T7PFoJJSfr5AtUKd3zK9UB4BFNMYpM66EQ+YGJkAWJ3XC3ExUA=
Received: from BYAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:a02:a8::23)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 14:23:17 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::19) by BYAPR03CA0010.outlook.office365.com
 (2603:10b6:a02:a8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 14:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Tue, 20 Jun 2023 14:23:17 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 09:23:15 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4] PCI: Call _REG when transitioning D-states
Date:   Tue, 20 Jun 2023 09:04:51 -0500
Message-ID: <20230620140451.21007-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c4f7f5-dba3-4672-3744-08db7199e3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ziCMmkjHW/kfs1pc65LliB7M887vNwNZzevGgN5hi/YTknVurpmM/b6CVkHOfeDsGTRpyT0dzCJr3kE4hN0jd+OUR2DqR5GFWI7tWlaFfVtceiFw4+Jw/5Mttm3cQwLvyN8FLlETfoQYyD+SOKsuBdUqZR9qpOHVqC/5BwaPAriLgxnm/JLld80ZHcaEAIe+r9SLN1zrCuD4ZBzAhHgsk0r7NI8xVBxxNGgQyp14nior6zpFJO8U9+Qjkxl6TNMKGMGbTnUfYTbLKr0lip3pqlBc0QyplbXIx/EFJPET7cMHGK8AcQmi2tmrL4nUgDvGmoCx3SYaNAnWpjP7H6W6md/S5y1VSzbu4I876pvVOEg70z/t7XPs44inz2BQcOCJnHoKUTfAIbPmI4aIHOHWHWYqCK7xOcN13jkJgRbq5XPRIVjx2YYF2SoQJYE1/WbFglUfwePJJs5nv6qC5sfufaAJ2YnzwgrEnpS8K0Tcm5ja/dK9SRb13tdmaVd0fSlG4C27gPRfKyGkSzvhlAK/vAFu5D+vxq8Cu0XFDZptBrIGrr03K0CnPCVrM+2UfMEBcOL4juPwO0LiGfvVBlHsoth8BIuunk6e3e8WdsyaOvk48KysXRTWm87k8qt4GoiKSAVriZNdw9pZY6OSEBDlcqaJd1KRQdCi4NrIo80X5oXEkRT2CThu2ing+saGr5omsCH1iYFl3IlyIj+PQcV9gQIANresKNKZrbOAfeDeqV5cqwe8rpp4cfaGH/7+Pu1UqT4q5flfwbwlQkDFWMMeuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(81166007)(356005)(336012)(426003)(2616005)(86362001)(83380400001)(47076005)(36860700001)(44832011)(2906002)(5660300002)(82740400003)(4326008)(40460700003)(110136005)(54906003)(70586007)(82310400005)(186003)(16526019)(8676002)(70206006)(8936002)(966005)(478600001)(36756003)(41300700001)(40480700001)(1076003)(26005)(7696005)(6666004)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 14:23:17.0452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c4f7f5-dba3-4672-3744-08db7199e3fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Section 6.5.4 of the ACPI 6.4 spec describes how AML is unable to access
an OperationRegion unless `_REG` has been called.

"The OS runs _REG control methods to inform AML code of a change in the
availability of an operation region. When an operation region handler
is unavailable, AML cannot access data fields in that region.
(Operation region writes will be ignored and reads will return
indeterminate data.)"

The PCI core does not call `_REG` at anytime, leading to the undefined
behavior mentioned in the spec.

The spec explains that _REG should be executed to indicate whether a
given region can be accessed.

"Once _REG has been executed for a particular operation region, indicating
that the operation region handler is ready, a control method can
access fields in the operation region. Conversely, control methods
must not access fields in operation regions when _REG method execution
has not indicated that the operation region handler is ready."

An example included in the spec demonstrates calling _REG when devices are
turned off: "when the host controller or bridge controller is turned off
or disabled, PCI Config Space Operation Regions for child devices are
no longer available. As such, ETH0’s _REG method will be run when it
is turned off and will again be run when PCI1 is turned off.".

It is reported that ASMedia PCIe GPIO controllers fail functional tests
after the system has returning from suspend (S3 or s2idle). This is
because the BIOS checks whether the OSPM has called the `_REG` method
to determine whether it can interact with the OperationRegion assigned
to the device as part of the other AML called for the device.

To fix this issue, call acpi_evaluate_reg() when devices are
transitioning to D3cold or D0.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Only enable config space access for D0 state instead of D1/D2 states.
 * Only disallow config space access for D3cold state.
v2->v3:
 * Move call site
 * Rename static function to better describe behavior
 * call _REG with disconnect /before/ going into D3
 * call _REG with connect /after/ going into D0/D1/D2
 * Update commit message
v1->v2:
 * Handle case of no CONFIG_ACPI
 * Rename function
 * Update commit message
 * Move ACPI calling code into pci-acpi.c instead
 * Cite the ACPI spec
---
 drivers/pci/pci-acpi.c | 44 ++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 052a611081ec..182cac535250 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1043,6 +1043,16 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	return false;
 }
 
+static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
+{
+	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
+	int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
+				    ACPI_ADR_SPACE_PCI_CONFIG, val);
+	if (ret)
+		pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
+			enable ? "connect" : "disconnect", ret);
+}
+
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
@@ -1053,32 +1063,36 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 		[PCI_D3hot] = ACPI_STATE_D3_HOT,
 		[PCI_D3cold] = ACPI_STATE_D3_COLD,
 	};
-	int error = -EINVAL;
+	int ret;
 
 	/* If the ACPI device has _EJ0, ignore the device */
 	if (!adev || acpi_has_method(adev->handle, "_EJ0"))
 		return -ENODEV;
 
 	switch (state) {
+	case PCI_POWER_ERROR:
+	case PCI_UNKNOWN:
+		return -EINVAL;
 	case PCI_D3cold:
 		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
-				PM_QOS_FLAGS_ALL) {
-			error = -EBUSY;
-			break;
-		}
-		fallthrough;
-	case PCI_D0:
-	case PCI_D1:
-	case PCI_D2:
-	case PCI_D3hot:
-		error = acpi_device_set_power(adev, state_conv[state]);
+				     PM_QOS_FLAGS_ALL)
+			return -EBUSY;
+		/* Notify AML lack of PCI config space availability */
+		acpi_pci_config_space_access(dev, false);
+		break;
 	}
 
-	if (!error)
-		pci_dbg(dev, "power state changed by ACPI to %s\n",
-		        acpi_power_state_string(adev->power.state));
+	ret = acpi_device_set_power(adev, state_conv[state]);
+	if (ret)
+		return ret;
+	pci_dbg(dev, "power state changed by ACPI to %s\n",
+		acpi_power_state_string(adev->power.state));
 
-	return error;
+	/* Notify AML of PCI config space availability */
+	if (state == PCI_D0)
+		acpi_pci_config_space_access(dev, true);
+
+	return 0;
 }
 
 pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
-- 
2.34.1

