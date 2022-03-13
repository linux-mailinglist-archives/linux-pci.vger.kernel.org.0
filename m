Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD5F4D78C9
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 00:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiCMXls (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 19:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbiCMXlp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 19:41:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606A3DCB;
        Sun, 13 Mar 2022 16:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7TCySZaUQR7f2/nI3nnurKPE453JfRofkXT+QjA0ras7kkAi586DN99ZTiXrQ1Cn+I1opy7KgcIqFAr3ofpl8AZLPdjFunhw0iVr/qeXFBmxm2fdoCQyII/Wgm3/gM0ybz7oaFySEKijWCvYXqUtA+YqBpxv1gvVntMeQmr5fBZREjnuvlmfn4b5DyeiQvl01nRTCHGvqHn550RfsMG6mFlTEbdhwS5n6N5visD2siGv+7DZxsTolu2hpQYdMI8ki1iwxm9rTFiFaXDFPzuCnrYmpzbxuYM1JWWZwjO7mEpydo1OHcuzUMi57FhWsVRx6OaOgW22S454rn4rF3V2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JwLele4/a188lj3TUdtlWRTTt98dEJa3zBWOynn/z8=;
 b=leNuetIjpT2LsMvsetGdGYKYR66CTN9RasoPDAIW6fpUykn/cKovb+ImQtssZ3iojKbtV7XrJgVX7FTFsDBWPXFYa6nyChlyI4tH1bBz+a1nL3bTzgaCLZZEwrxEk6rFn8W/27RSClexlacS64Pu4b0YeOCiF1pOWt4sRGYI6pkI7zF4nB2Pa3CZ5SzSih5GnpJVTbOXrL0cmuL9BGxCbQio0bsFNmr4h9YGV4NIj9vsDl9jS8D/iWqDG8QW8Zv3koXH0sdW0NCLLagLNfIeVyjWaSdIB5xR0ehhSlBGNJOuUmTthVmU4tGIg/CimBxCrLhPaDKhOLSYZMkofsfUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JwLele4/a188lj3TUdtlWRTTt98dEJa3zBWOynn/z8=;
 b=Uwoun9154yzNeaouusRR4iWvq6RzupRnyD54GUCJ6m45XwACJt9Ek3OLlQ56uOm1CB7iX4gpLy0u55hPJtxJoiYJQM6l/OHLFKs8Ll9HQkQe2AYcob07g///Iv7/yylAWgk2diQe6uXnjZQS01x4EUsPHRoVZ6+sSmdFq9tb4bQ=
Received: from BN1PR12CA0004.namprd12.prod.outlook.com (2603:10b6:408:e1::9)
 by SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Sun, 13 Mar
 2022 23:40:34 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::f5) by BN1PR12CA0004.outlook.office365.com
 (2603:10b6:408:e1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25 via Frontend
 Transport; Sun, 13 Mar 2022 23:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Sun, 13 Mar 2022 23:40:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 13 Mar
 2022 18:40:30 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3] PCI / ACPI: Assume `HotPlugSupportInD3` only if device can wake from D3
Date:   Sun, 13 Mar 2022 18:40:20 -0500
Message-ID: <20220313234020.536-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abb34730-6713-4a6b-fcdf-08da054ade1e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4558:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4558B7408B88139F0C9ED318E20E9@SA0PR12MB4558.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4vkdg/6hPIudXZwf9h92bOFaRZJaaj5mmp/yu3ldcMqc1x/HUjovcg9Yl6LXfwenb7UcugWcgDEyvjlCAt4d0QdY3hVhGP76ZZvc6cqhrklZA0EUR2c0LL7PMUr2ZpK5tXpjAut3oDB625TCfEM2hzaFZ+kNBuW33R0Q+oN3mkFEEWMBZwL/2NLHxLWjaHCe+WYdYwD5W2+s5gwzm+aOvew01LYZC+5CP7oiddpXKJxAKlH9PpWtgIUpN8yApOrYtkcud8pIapc9TorMgDcoigreRxOt18dRoquoahIUMrP/1ssiwlYaDWEhwfntA8jr/pzyRMAa24yRAGinubrXO4+kZgRn7TXAXD7GgZnpYE3sIw8v59tJpoCQxqnQiuGgICPk7rt7KTWQvKSW3QKtpBFFex6Zt1gr+JFC1fxcPNav0UY6u/fjMxMq9xKQhrfyQYWM7iafjr/DARfxQuYY+gouIYfpUctpLLsmNLv/qeEPbaxTuTgj5ONevqWKfE74LtJ2xC+ILXy++cMct/q8f84RYqC48AfQ6ekL5axW9wpUun9skGe927mBMrFdwFU7HYidtusX0lhndxv2TGVwSxpb+0QH1HpyNXPgZ2c10D5yWseDd9tBKdnT7bnzBC23eGENGIsnPQYm7ZYxD4IESzfsd/79EFcLcPn6tt3hXlbP4zXxVrd0awhzjfqOmkSTNR6777WEraekqYdvk35Pdrqi0aNPnyATlBCHVfxZro249ZXWaj2NzcDCoswV3UuKSxOgUZIj20jVchG5mNFrsP1ZQrKL4QJhm6OEmojss//gnL4tDKb9gBJ8Lx246cPpZZI3Ujd0re66429jINON5FPk3qRd2Lv8R+kVn/NcDI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(6029001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(81166007)(8936002)(356005)(26005)(186003)(16526019)(2616005)(336012)(1076003)(82310400004)(426003)(6666004)(40460700003)(45080400002)(508600001)(7696005)(966005)(70206006)(4326008)(8676002)(110136005)(54906003)(316002)(83380400001)(36860700001)(47076005)(86362001)(2906002)(44832011)(36756003)(70586007)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 23:40:33.3013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abb34730-6713-4a6b-fcdf-08da054ade1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
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
 drivers/pci/pci-acpi.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a42dbf448860..232a8aa21bd6 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -972,6 +972,29 @@ bool acpi_pci_power_manageable(struct pci_dev *dev)
 	return adev && acpi_device_power_manageable(adev);
 }
 
+/**
+ * acpi_pci_s0w_supports_d3 - Deterine if ACPI device supports D3.
+ * @adev: ACPI Device node.
+ *
+ * Validate that the GPE has been enabled for the ACPI device, and if it
+ * was then evaluate the _S0W method for the ACPI device.
+ *
+ * Returns true when GPE is enabled and _S0W can support D3hot or D3cold.
+ */
+static bool acpi_pci_s0w_supports_d3(struct acpi_device *adev)
+{
+	unsigned long long ret;
+	char *method = "_S0W";
+
+	if (!adev->wakeup.flags.valid)
+		return false;
+
+	if (ACPI_FAILURE(acpi_evaluate_integer(adev->handle, method, NULL, &ret)))
+		return false;
+
+	return ret >= ACPI_STATE_D3_HOT;
+}
+
 bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	const union acpi_object *obj;
@@ -1003,6 +1026,13 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 				   ACPI_TYPE_INTEGER, &obj) < 0)
 		return false;
 
+	/*
+	 * The ACPI firmware may have 'HotPlugSupportInD3' set on the device,
+	 * but _S0W may indicate that the device is not able to wake from D3.
+	 */
+	if (!acpi_pci_s0w_supports_d3(adev))
+		return false;
+
 	return obj->integer.value == 1;
 }
 
-- 
2.34.1

