Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF14B4EA210
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 22:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiC1U5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 16:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiC1U5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 16:57:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D56A427;
        Mon, 28 Mar 2022 13:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GY0YJtKTKVrNCu46HrDFsLpb7Od5iKtnm4lJ/xT29/S0TCq9FgoVGiYMfZfsRSlTLR9oqAs/1ygNfneXvXvVXybMWHUF8xlFG40vJO3fW9WXKRK5JJkKUZin0xaZPsxuWcxnu8Em2GRBYDPV+LqeSxnDh7NE42jiQSroIS6n/2q7lrs4Xr3Y17Lbt3pkRvA2/KROEFRdqyKAmUzae0x/QTCaCNKLYITOJferaFNU6PxFV5TjM1WtYywrGXFdWWN7/sG6Btud9e7lk/kSJIt4TiobQjvwVaeNp9JsOaISxvM84M6SyA0gSHaaeCF1P97F9M7sPAlpCgOP+ZFoG2E37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iGQg0tLSdhHhW3xgY70qgGalZ0A839jwOQS8WUOAIo=;
 b=XtWo3pP+thxv5dtWlP+U5VIHkG9N4gGitIw64EjfbqN9HtgCbUwuKIMSfnfAq0z8ubr2/5CJOWXZ5KQeWkyhRyLDL8qn84HW4f9j9d+3wQYw1QbYEd/JoAwf1y4uw8fPYS8sUSYM15WSqntEBLd3Wl7jgkrknKRn5qXB+s/808/dNY71S3BdjOoHwjvBFtzxamiC4rse88P2kNOhlLDPN+m8f5BqP1xSAEWvsdZTotuEIecU0eDr315lb7u+ntfCGX7bMh6Rf7ZZJo/LiPe4TwPIRz5sjgjUc18ohdEg9zEz2TFqAAZgVrKDbvaAgdDE22IJjksDPzwBAgSII0ZRKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iGQg0tLSdhHhW3xgY70qgGalZ0A839jwOQS8WUOAIo=;
 b=jqzafFjc0ytX4F6Xz2hZ5VkRwXyCw/3fyj435i+P4fdT5PtFhNGvwAW9PMw/pqIfYOVeNlg2m3acs9N9xTpEyo/ZLVO715FbXbyNnhPle607IK4gqKAt96Ouor6q9KZkw1FW45bENLCy002Wy+/DG4UOVgyrpQvAbpcU+3FMXfc=
Received: from BN6PR20CA0071.namprd20.prod.outlook.com (2603:10b6:404:151::33)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Mon, 28 Mar
 2022 20:55:23 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::3e) by BN6PR20CA0071.outlook.office365.com
 (2603:10b6:404:151::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Mon, 28 Mar 2022 20:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 20:55:23 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 15:55:22 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 1/2] PCI / ACPI: Assume `HotPlugSupportInD3` only if device can wake from D3
Date:   Mon, 28 Mar 2022 15:55:18 -0500
Message-ID: <20220328205519.250-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c17aaad-c5d4-4ee0-448c-08da10fd474c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4187:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4187DB512CD16845778DC87AE21D9@DM6PR12MB4187.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jd1B8N2KFGm3SZ8mxiDKxcbsnASYtqcHOcyU0uncJmOZEFKJslIgKobr1Nmfn0bB0PxG1k57xZCVevKNowkIxQduL5i0pxJAg9dK2U2lG8HKPBzVEC0oNyjcO25rgj2cjNphNRqI0uDqPOdIKbVEf4WI+2ZyCOwFnEmtLpP/Q3Y2JRpip0ZrM327a65Lrd8JMIWSVI7vCLIVDP1QDPCaKp/uIkm1yhnxkfpLSVPaUeNQzmQtBhXDmf+KgHsXiZRlxSc0sgadWAl7rewC4Vdi9XQtdsJ6LGvc6QM3u2f2uxZIuE8jZUGcPUJHwuvPZL4kL5yVFkHkumyvNnEs+4gvJbh4gcPls7IrcrigjEq6o9/z2pAOB36r0fu6zFBM6LhHLVvZJwRV7pHuZlF0vDrbhXmGesm4ayLA/WE6R5nIGn3M9+3/WaMNRZNch5oEwqdJnJJEmDHqHx6WuAdhuaN5UhDoYJBd4vXy0Y5+p4DxKmPrXDdrkXDl7jVjfJ8jKdYlBbbYGC+/yVuLcQDX2Cu+gdvkJZYLqQfdgcNMBiVLR6XKx4eaYs3WQ0StRHcpFOXxJfCuA7RSh4+Bs9LDbd2+IZzX38L3+YJIBt4yu0iRV1SHJJOp2rcxN3vw87zSq+HV03+rPcCbnV/5Ybsdmw4hAnD0ql6LFKHPYEmNXrzNjdrgLivnm2HVX3JG/7mA+vBHWtifSuaF49ktSzNJKiaI6TVnka/VgttsXULOeHEqNsUVwsWM2nIwSDMvmOeow/E/7SAJBrlPg1qcXsIHCO9wXY5wSYwE4u1eKmhqRHjiwaMZRBfI+8gSPsyiip5GdEFUO4OzJNV1bKUgQBywnhKQCiwsFTmQLbb5lnRN85BA3E0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(6029001)(4636009)(40470700004)(36840700001)(46966006)(356005)(81166007)(36756003)(45080400002)(316002)(2616005)(16526019)(26005)(44832011)(186003)(426003)(336012)(2906002)(1076003)(7696005)(47076005)(6666004)(8936002)(83380400001)(82310400004)(110136005)(5660300002)(36860700001)(54906003)(70586007)(4326008)(8676002)(70206006)(40460700003)(966005)(86362001)(508600001)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 20:55:23.4672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c17aaad-c5d4-4ee0-448c-08da10fd474c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to the Microsoft spec the _DSD `HotPlugSupportInD3` is
indicates the ability for a bridge to be able to wakeup from D3:

  This ACPI object [HotPlugSupportInD3] enables the operating system
  to identify and power manage PCIe Root Ports that are capable of
  handling hot plug events while in D3 state.

This however is static information in the ACPI table at BIOS compilation
time and on some platforms it's possible to configure the firmware at boot
up such that _S0W returns "0" indicating the inability to wake up the
device from D3 as explained in the ACPI specification:

  7.3.20 _S0W (S0 Device Wake State)

  This object evaluates to an integer that conveys to OSPM the deepest
  D-state supported by this device in the S0 system sleeping state
  where the device can wake itself.

This mismatch may lead to being unable to enumerate devices behind the
hotplug bridge when a device is plugged in. To remedy these situations
that `HotPlugSupportInD3` is specified by _S0W returns 0, explicitly
check that the ACPI companion has returned _S0W greater than or equal
to 3 and the device has a GPE allowing the device to generate wakeup
signals handled by the platform in `acpi_pci_bridge_d3`.

Windows 10 and Windows 11 both will prevent the bridge from going in D3
when the firmware is configured this way and this changes aligns the
handling of the situation to be the same.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4-v5:
 * Don't fail if _S0W is missing
 drivers/pci/pci-acpi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1f15ab7eabf8..91c165ea4346 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -977,6 +977,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	const union acpi_object *obj;
 	struct acpi_device *adev;
 	struct pci_dev *rpdev;
+	unsigned long long ret;
 
 	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
 		return false;
@@ -1003,7 +1004,21 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 				   ACPI_TYPE_INTEGER, &obj) < 0)
 		return false;
 
-	return obj->integer.value == 1;
+	if (!obj->integer.value)
+		return false;
+
+	/*
+	 * If 'HotPlugSupportInD3' is set, but wakeup is not actually supported,
+	 * the former cannot be trusted anyway, so validate it by verifying the
+	 * latter.
+	 */
+	if (!adev->wakeup.flags.valid)
+		return false;
+
+	if (ACPI_SUCCESS(acpi_evaluate_integer(adev->handle, "_S0W", NULL, &ret)))
+		return ret >= ACPI_STATE_D3_HOT;
+
+	return true;
 }
 
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
-- 
2.34.1

