Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281DB72656C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbjFGQFc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 12:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbjFGQFb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 12:05:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3427C199D;
        Wed,  7 Jun 2023 09:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVXo+i2f90cIBgytFvI131GVdWiaysgLiPhyZRwLcdwP/U9bIGdmqZGtN1w4eS8uiHX1CWLykU9pAIqzX9U2WGYDtPr0qtcgXjTjJaI80Vru4dNzmK97Rh3XUneB4RJC8Ui1VS79oEkcD/EKdIsivM6blDh9dMnqxm9v70Mg6binq7b+EjdZT0V4EZmvFGdFg5S8WzxW85o1xBjVXgGXst0OiiS4PUrO/oXa5uk06Ezih6sjpWp6JG1rifHX7UI3oSDc6uMOCgiQEqnKgk9jy0He2iBl/YjeWOP654qdmALATYNLBniyNK7JvcJB4GZvVletQ2k5ebgT2Z6PTRMy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD3lPhNfk2Dhr/onYhVmF+h7fPsCUbIoiw0NS6ztlIM=;
 b=gBOk17OX/mZHh7IiD+xwratb/4zuNnI9zuNFRhLjYTM/fiqHuBnMc9ctEn2eFJFDkVFjRoH7RLBDVjt4OXODRIGj2dptX1C0eyNQpbQPbAIIChcBsqYvv+fNeIfBIqF64vLZAFvlHsJv9MFW+7pFdDj9CDYpd1RidXfzczKpAaakw6gvgexaCNWFaoMcSyDtGMB1Dkode7+IEaeBb4X9HtbneDEZzv+QT8ign3bO9ceUipQsbT48Z+q+YpzR0bWop05vWjjIwKJTJp6ZU0AJxzCq6DmReVMBVNGPhzfQ98RghifFVHLpdT38XLCkl/+mINGpo4sjkKyWXdylneSq5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD3lPhNfk2Dhr/onYhVmF+h7fPsCUbIoiw0NS6ztlIM=;
 b=sDOvU5dPVshY17eEaZ43eKjpadOGUSfJnz94uFFOwlYVT8fRgXM+aeHErI4Sl6lERmQ2qjiWBEbZpA27iEQqNhnBif+UbCFFH5kOb6SVy11h/ysxvMLs1t/ov8A05N/427MVDSJoJJqhMdvSnkdOo1hFaLcXWDTksG3jUD0gaSQ=
Received: from SJ0PR13CA0174.namprd13.prod.outlook.com (2603:10b6:a03:2c7::29)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 16:05:26 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::70) by SJ0PR13CA0174.outlook.office365.com
 (2603:10b6:a03:2c7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 16:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 16:05:25 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 11:05:24 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3] PCI: Call _REG when transitioning D-states
Date:   Tue, 6 Jun 2023 21:57:18 -0500
Message-ID: <20230607025718.29636-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe9dc74-468d-47fb-be8e-08db677101b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+9vpPg/j8wmVVjyzGV5wTc0XeM0AUZZwUdSd0s5udsNmou0wVt9h8UEDyIdrShr1MXIfQFRD8C8YOiFbXjnxxqNgrxBtCAtAT8fqmb5E/Am2BuMIUS+OdTBu2B3LGo2qSzL7+1iFgogVt0ZYU7/J488jmT5900MX7QA/sOistkdCOD3f4enPQcOrINU9xVa0NRjM5jidT2jzC6WwIi58uah6yXKEx/4LUdjTSQHo+HxmuE8IQwPFC2abzQmpULCZFQ2AFfynY34C0P2fCVDiF63p8vmnqLaVQH2jR9s8Y2wZ51BDAjTnvHSdIVb8HoS+q2+Oti5wT4A42jn3icr0tDCY3OUWdoGkU4AWhcBdNfqZsulZdl6FqV9PnLiTvO1W5zY2vvyq98a4C2GWL7fnjZpgF20N6G+YA8Zx28+O/gJXguNLyW0WZGToEgWWXygxFjI/gm6/M3yTtKk57AiDMpM3jch2byWVr5L6JdYnfVCt0Rsj1FfhAd+hTt2fuNcPp7PrQpvkzzpObUADxTZn2dKcaRniDV8pUytJoYYs8f8PvKcZJNI67+IShhQv8Dtkzmvh9EtEbJ/PLEPQr0tNfVQiiinL2vQGyKkvWXwXx8bHcqgHnRax5zjQzOjDdcFqSYZYgu4oXliKy4Cpw6S7SDDeiYqhm0oedlWZY3tVTsisUguW6dRxc+Lb2DzfdY+/rLIEq+67JHedZQ0vEmZ/7hUhN1jqBcVbXKszBC4PIpd9weyErTzwQBEpE4I3fYTzC9Q4QM7EEL+mfpr48c5cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(16526019)(186003)(82740400003)(81166007)(2616005)(1076003)(26005)(47076005)(426003)(336012)(83380400001)(82310400005)(36860700001)(36756003)(5660300002)(40460700003)(478600001)(86362001)(966005)(110136005)(44832011)(54906003)(7696005)(8676002)(41300700001)(316002)(8936002)(4326008)(356005)(6666004)(70586007)(70206006)(40480700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 16:05:25.9369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe9dc74-468d-47fb-be8e-08db677101b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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
transitioning between power states.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
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
 drivers/pci/pci-acpi.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1698205dd73c..2c80ae4ed362 100644
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
@@ -1053,32 +1063,38 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
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
+				     PM_QOS_FLAGS_ALL)
+			return -EBUSY;
 		fallthrough;
-	case PCI_D0:
-	case PCI_D1:
-	case PCI_D2:
 	case PCI_D3hot:
-		error = acpi_device_set_power(adev, state_conv[state]);
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
+	if (state < PCI_D3hot)
+		acpi_pci_config_space_access(dev, true);
+
+	return 0;
 }
 
 pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
-- 
2.34.1

