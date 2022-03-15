Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC844D9EC7
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 16:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241321AbiCOPe1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 11:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbiCOPeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 11:34:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B72C13A;
        Tue, 15 Mar 2022 08:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4A/UypsO49PXHN2LDqc5OxjbAqPz9yy2a8STbFHrEH2z56kMOBtunkj0wQbwu9JL4R2DIGlnTdsMyl9/8kS+yZfjFj6TS7BJiUp/yRIXGt9BsG/0XKMeqmlq2N32xV7/uIFdZ/JK7hubGgblInaQjVkJohOSuhnZgotKxEFdXtJtXITYTpDJs3VQynls979Yy1bxC2DM5QrWWey4UKkb/NPxZeSvrND5tlyVhcx9irU92sgau0ymPZk1kLFk04sFD8r+NPoe1kJB/r6VmcvX2D8Sy0XdVNHwesNVs/k/FDaIdcenUnmACkp4ll0hRmX0lgY3X0EomdyBX4IAcpykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7SxQiqHLYY+fmybu39SLWw0eKZbhp11/XI2IIsNaFE=;
 b=j6Z4opSMUxAiXqXCw/1eD0uMreJu6yV5nlCncqOnghf1PeCK9Z++Mt1wZ5qZdQLClqvXVAamZ6ly3Ckz6aZSJp65o35XNkT+xlrLhKQb7nwojoIJSronJ8W+J4bnYbgxIzRr/va+Wu/ZFmBWppl4OnImqUlrD0Zgyp9T09rqiS9JpU34xmv7UG7SBCYWx+JKtQjN8qNZMHMRgE+yaXGjOQUbA0d62dM93wwohS61R3s/SxDQed3VRTeEyxcoh32rtDHIhGbvFke+DOlTvcGpGT9XpW+R1RqNv2C5DLELKqgnYaolH5Ru8kPweXbp2oN/aCaboNJ7LTj6CtEGgBGpgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7SxQiqHLYY+fmybu39SLWw0eKZbhp11/XI2IIsNaFE=;
 b=sVuL64LZnjctMRuKd37Tw7hayWWeC7TMhmeq7kxHFdnU+fQH7wOEwQQY2Fxm+Y93lVo15A0cp2+50Ri00fKK6Kfvo0iRvCveiVHKawilDIL7QaSK+WIMMqhGgC+sKgX36PMMzJeYjn2y0Eaiw/IuA7cztT1CzpbaB+veBwJwtoY=
Received: from DM3PR14CA0147.namprd14.prod.outlook.com (2603:10b6:0:53::31) by
 BYAPR12MB3046.namprd12.prod.outlook.com (2603:10b6:a03:aa::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.26; Tue, 15 Mar 2022 15:33:07 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::49) by DM3PR14CA0147.outlook.office365.com
 (2603:10b6:0:53::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Tue, 15 Mar 2022 15:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 15:33:06 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 10:33:05 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4] PCI / ACPI: Assume `HotPlugSupportInD3` only if device can wake from D3
Date:   Tue, 15 Mar 2022 10:32:52 -0500
Message-ID: <20220315153252.4880-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b54806e-a4d2-478a-3115-08da06991a7f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3046:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB30468F9B379D6BF5A79D4DA5E2109@BYAPR12MB3046.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPLgWQJu5WW8MQoZC2svSITj9f7Z+zLvo8/ZOJW2HvIe2yZ2m/ezcl20xHjiIlk16YmMICnv0TLCdmWHRbG4WCd6mwC+yRpyDSkewsnXtY0Q3ouQCukRt2OnLSsG8ht6jL4gnJ7UMTGp0jjs078IXP3t/U6Z/ch/ZG9DI25ShqgzvLZdRNgy3aQOe1uDkWq+AcqIFfRRc1LlcK3OkCb7hbnP4EdRjAVh5FQ1E4KqHgzIfa8aHNc24H+2Yx0bSWxdetTkd8B4cXjiYgAmt7pfxSZhtkB8ZPT10OeUiQtJq2uwoBrkBDLByP1SOrK1PesWb5wVRhwIIu6rA6AYUpLAzxtXPudrKU7doF+acgUY3f5ab2HzCm5NejWOZ8IWDZ+nccQ24NsdIULLPFFvmjG9WPONMVLVJCa4uMzSfFrCfehFkQ8hkSA/dHr34+oNARfWZsRrSkHE41OE8wcHpZTMExiiCs2BmTYKRp0IDUXGNu8pqwEyr5xrw4Ya+SZVdnZuLMpmYg9F0L1Us1a+pwuXCFNe64KXHJAP3mnqSAkdUZKnubSLQHmrwtRsgzPEcR/EDtk7pusYgow2OLUSQwUJA9NVh+8/M8P2ZO/fdnnUQFaUoLvuTaYUqFeBEs2p5cdIwinO61cshFWTYXRMHeGT+zM5F8rgJRJOHsxzZFvqrKoeKqu/kKOOA+yn3aXDeygPQ1xPW4v81WU6n2PvWI2VPmCNNYry6ubekUPu/WPhYYHJGGBEKDHpZIkBi32H//Z6Ie5qoQdZbSAoYsCwGwLAjTZJfDXVCCRaZsbYi+4SzgtSUAdy4Z58eDeUFrsSWa2PcQCdWuolH8dDjPklbuwHCFG6XHCwUC4D2mwtkxp0qwY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(6029001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(336012)(2906002)(47076005)(316002)(426003)(110136005)(36756003)(54906003)(81166007)(356005)(2616005)(508600001)(966005)(5660300002)(44832011)(6666004)(40460700003)(8676002)(82310400004)(70586007)(86362001)(70206006)(4326008)(83380400001)(8936002)(45080400002)(36860700001)(16526019)(1076003)(26005)(186003)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 15:33:06.9558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b54806e-a4d2-478a-3115-08da06991a7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3046
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
changes from v3->v4:
 * rework comment
 * only evaluate _S0W if necessary
 * drop static function with only one caller

 drivers/pci/pci-acpi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a42dbf448860..e535dab2c888 100644
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
+	if (ACPI_FAILURE(acpi_evaluate_integer(adev->handle, "_S0W", NULL, &ret)))
+		return false;
+
+	return ret >= ACPI_STATE_D3_HOT;
 }
 
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
-- 
2.34.1

