Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A614D5101
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 18:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245230AbiCJR7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 12:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241138AbiCJR7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 12:59:41 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93554166E0C;
        Thu, 10 Mar 2022 09:58:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Blk97fQUEeq45ytR48MglP4L/WTlcF2qOUU3fR+ia+xXhJLw8CaFfFMEUuEayFsDlk9TWxGHEVI49B80INMI/bxZCMK8raV+J7eeav4rcveswBOz0Mf2gKloXomflrcu7N8Fm9prXyL0yp1E5wKV4vLa2OMYTvg0eWu8uuovlNxunheypJazZHGrChOseLxuZbqkfZaIBiOgGiHfQifWU7wrQ4ic84I3+cT6REEhX+PgACGAN5vgg1W7YnAzW7O96tdW2HWHgJsJgNRi7fUoT3H0Xjz8gN70HtRs5B9uBe4sjSH75CxC4PjLimhXeTxvaTZGJntsLg+hVBi1TmO8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFecLuFmddS3zhEIG0OHrcLwWn5JT/47mMwT70dFwkQ=;
 b=a2Ed5U5k34CfDphfGllUG6Yj7zljtFzyp+feUMxfdaiE3s3RD/f4Ia1KUh21gx9Z6mi8ezNNvvj/ACmkA6oGHzErD9PZwZflPOJVzv2r7THHqa4/CNeKXMbmuUdeKZjevyZF8+SzMe1hMOTQQVrHcjbTefuIeTKikfQXG1b7Lz0nGP4ml8uybvCkepK5aYr7vshYZvzjakb1+1qNNNFxEJjRJp96TdEn4kctxog/aTaqz0FuuHk+V3kwglc6wzQWpqffTeZeCAjriP1gbZ9JorCeTZXm13VLXYy3KYc+1cxqwUByTWa3Dgy8GbgNgi+d+kwpPnYAF1eT0sKWIxi8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFecLuFmddS3zhEIG0OHrcLwWn5JT/47mMwT70dFwkQ=;
 b=IOJitR0jwb1qw4drogzaovCCFyTv2xJYcN5qovRtXJQUEnEdggeRATFHklU/tYrcUzTcHdz0OzvrKma2Keeg3D5kYvXLdE5W5i40ZvamaWGWedTfen/dVG9YqR4EiKSqE8zHdrqiCGNRQQyiXI5CRI/XRYYkNF4i90CAj1w9SBw=
Received: from DM3PR12CA0053.namprd12.prod.outlook.com (2603:10b6:0:56::21) by
 BL0PR12MB2420.namprd12.prod.outlook.com (2603:10b6:207:4c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22; Thu, 10 Mar 2022 17:58:36 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::59) by DM3PR12CA0053.outlook.office365.com
 (2603:10b6:0:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 17:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 17:58:35 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 11:58:34 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
Date:   Thu, 10 Mar 2022 11:58:32 -0600
Message-ID: <20220310175832.1259-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4aff9d6-bcdb-4373-1f9b-08da02bf9936
X-MS-TrafficTypeDiagnostic: BL0PR12MB2420:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB24204BDBFA27DF794769F2CDE20B9@BL0PR12MB2420.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtvFiVwPUTuQo0euVWfRFwNveuiwGDFAeuDBgCropOs6i+OLtXHtWqTudbxiOjxz0aztUhn9QmJiKccgWROxCLcS3g2byvJXhukA9d7xbrbAVVlsD5qxaBdcvMuIvxTOvaay/7e+584pcVrhjX4OWnAflknnaCCXmBJ3UGvL4fN61G8hA73deQkc7BjG7mBDkpZLbki8kufLxylvNRkTMNI0opOxSz8/Mr3rOpk3FgCIAsEBCC5bllPtq/Sq77IQh4ao1zheZjB2eYgtdA2bqy3NB9pWncZMM24SHVLQF1hEd7gZYMQw/DNiHRHca8Pn6Q0W2nJWMZhVmxizaljKkmlhkMT/6u3rugftruuI/q6vggiwzX8UkPp5moBlOjLKuGCVgcr9mMv7tMDcSeSUjezrYr0h7+Yn/JGOcxZJBWCjChoDmB3kcXJ2/VtmfQMFuInsKsfm3R7Wi0AQYSr0QISAgebirntETm4tgA/LKGtakP8D7MxxiRxeQGnvb0pm/ekZxFk/FxBeFNo0fn+859llQWca34ZaP3rtR+huMaJhBZplpcNFlCT5qaibeL2nONvnETJyFNDvTdL/AG7k8nxqMuhmpA7XPac8CZhVy52e4xMLosYeuXkftbJH8uMVAm0gN/096289xhG4NDbvhvg3fyJFVKZH2xXW31Zkzt7S5+qhDrycLmGsu1U85B24dIDBJ6Jqb5qHvKNezFUJqqeiJjzcfI7ywBMZ9e72NQ2FmyztBbz4Dqq6UHnclaDT8YNOgk0dSgs4NzfnBwWn/U4yaHjOSin4SJOZ/LWYdImPhbFrY14yV3O/BD7Uupos0BVbOG/Rtew8HbGiNU1BG7qMcZbM+DNCvZpfVwxEM6U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(6029001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(8936002)(82310400004)(83380400001)(2906002)(36860700001)(44832011)(47076005)(36756003)(316002)(7696005)(508600001)(966005)(54906003)(110136005)(40460700003)(26005)(186003)(1076003)(336012)(426003)(2616005)(70586007)(70206006)(8676002)(4326008)(81166007)(86362001)(356005)(16526019)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 17:58:35.7722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4aff9d6-bcdb-4373-1f9b-08da02bf9936
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2420
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The `_DSD` `HotPlugSupportInD3` is supposed to indicate the ability for a
bridge to be able to wakeup from D3.

This however is static information in the ACPI table at BIOS compilation
time and on some platforms it's possible to configure the firmware at boot
up such that `_S0W` will not return "0" indicating the inability to wake
up the device from D3.

To fix these situations explicitly check that the ACPI device has a GPE
allowing the device to generate wakeup signals handled by the platform
in `acpi_pci_bridge_d3`.

This changes aligns the handling of the situation the same as Windows 10
and Windows 11 both do as well.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Add Mika's tag
 * Update commit message for Rafael's suggestions
 drivers/pci/pci-acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a42dbf448860..9f8f55ed09d9 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -999,6 +999,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	if (!adev)
 		return false;
 
+	if (!adev->wakeup.flags.valid)
+		return false;
+
 	if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
 				   ACPI_TYPE_INTEGER, &obj) < 0)
 		return false;
-- 
2.34.1

