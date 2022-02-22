Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6908E4BFE1E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 17:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiBVQI6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 11:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiBVQI5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 11:08:57 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E745165C03
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 08:08:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSmZLiUxorNZ+pWNDEyTTd3EHwM+zTlI1WOF3FplHggoImJYixNFyJ8vsPNLeB9pUfxEdvueRzUk5MO2ShJkNtzZ6AplWxsiGX+WLCLuGbr87tTAbbr8TmTObgDSvyjqZmT1g5x8vfBSEdVLzyBJM8XBzLwD0uhkfI0mhVmfvYeJKzcLkIsqUNih4CeELZgsvI565Gh8GgsdYZ02sp8+VswaLKAktxm5gPhBDg3ctzvWmFs1Ot5vPW0PiFHSiNw/XXSIK/QxzxahSsk3tWzlNmxLEZIcX/559A6r4ThG32P/S2hHW/DO7yvOgV/GI23Lt7MeSKGyaA2objB0EaFH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+cgJ/Q1kWtbzgS72kAdCuuAG3xRIH7LzmgCvQvfaq4=;
 b=VYA/5Rzgpxe/c5u09k59mVkMYMNvunojEZq0YlFauc2axISQ3IE4axAE2802RGfut91yzHOR6ALGdc7a+LOtjnmfymQxUSgrvzjlvWMlt9P0iB0V7cuXYdNCnpY43ZhsSNvaOi18PD+NabrpoOgKc1G0fGptOzGNLxiKJZLRBnStB1jExXOr5ac5ByU7jlI+3+6aOoCcUwWQUO0I0ZUQ88Ox0QhNTkUrucM0Kg3x83hlwqFliJl73Dzuo4qDkyjg4kZ+06prDvsBIDySngoNHycJU9EsOlIxIAh6QMIOs8sOCofSgB7TyEjiFNaWjaqzqFqozoJOVtAabISzFGR/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+cgJ/Q1kWtbzgS72kAdCuuAG3xRIH7LzmgCvQvfaq4=;
 b=sF6JEqNdLyMLNa9aLKx+Jv2ZD3JIgCoRqmJvRrLf4lufmv91+0QdSuc5GTm3EKTr/++1OVrC/z1f+02tGYpukKmC2UmNsPeqpPNayThoJ47IcCCZjY/fspRcL35c7JSwjNJ/VIVtMgE2JXeNT3t3Cgn7WwDb9Z4XsIVID3BXxFs=
Received: from BN9PR03CA0802.namprd03.prod.outlook.com (2603:10b6:408:13f::27)
 by DM6PR12MB3436.namprd12.prod.outlook.com (2603:10b6:5:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 16:08:24 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::73) by BN9PR03CA0802.outlook.office365.com
 (2603:10b6:408:13f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Tue, 22 Feb 2022 16:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 16:08:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 10:08:22 -0600
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
CC:     Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] PCI: Apply quirk_amd_harvest_no_ats to all navi10 and 14 asics
Date:   Tue, 22 Feb 2022 11:08:01 -0500
Message-ID: <20220222160801.841643-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dd7e254-46b3-4bd8-55d8-08d9f61d8da0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3436:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34366312AFA3C984FB254E31F73B9@DM6PR12MB3436.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJLZh0bNktSCbW5BHGyJXJ+XEZoKOn8SvuInSu43h2/k9+uJR8GFyy2hCs+l0AEdm9GNy3uYeH4G2cAua3JLTAfATbdOAMCretIWJ48AzkGWinpGT5S4LBhC97tTBi35Mn+/1nbwgP1GEnvoIAlCSfa5Vz5NAyVtOJOutJ/8mZNMP532U3aEx7GQC/+L0yYkOqelXP3U0qnMIYZFZE/YEUgjgXltFQsfkHtGecfJlfv5BuOwVuM9H2Z9ByH7HrCq/UIGSIScuhvVNEATYkvNzv7q0aqYue4WTHbVhnU+sQo2fFI5hrM3a3U/N4hCxYfMZ7rEQ69Te/6oED59p7RyC8UsLlVNJkiixiimbKcTDIyTXw/53cyKETCUYT4JB1vKFjEPY0A3LyzhgCZ3u+Yt6rgQ0JXh/yKnvn2JsMAsUsOBkMgXvdP/gfu9wUJU0EOoxS5ggQdWTpEYh2DCrSn0juqZzaXvIEr1xeQ8LJS7fdI3Bbcu9vWn450608s0EHaeCiRvK/QG/a+cHmF0Cd7XZMTJq9a5g31vIRPa+mMe5vHrE/LRaHkT/2vvrtd534sEz4FuismejKmiJ7fTRf2Ot8pcr5FImHRPm+ki7LjbQbDCh4tKHOG9UB7GGkjEBbLNZH4td9sidSq4QMOftylAl9wfgYlVuDy5Dvu9DX0tyezMNQxvMdAMzx+vmCKZmvHk1PINdQGre01PmLDzUzrfkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(83380400001)(110136005)(81166007)(40460700003)(356005)(70586007)(70206006)(8676002)(508600001)(86362001)(36860700001)(6666004)(7696005)(966005)(5660300002)(47076005)(4326008)(8936002)(26005)(1076003)(2906002)(186003)(426003)(336012)(82310400004)(36756003)(2616005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 16:08:23.9590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd7e254-46b3-4bd8-55d8-08d9f61d8da0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3436
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are enough vbios escapes without the proper workaround
that some users still hit this.  MS never productized ATS on
windows so OEM platforms that were windows only didn't always
validate ATS.

The advantages of ATS are not worth it compared to the potential
instabilities on harvested boards.  Just disable ATS on all navi10
and 14 boards.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1760
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/pci/quirks.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 003950c738d2..ea2de1616510 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5341,11 +5341,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
  */
 static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 {
-	if ((pdev->device == 0x7312 && pdev->revision != 0x00) ||
-	    (pdev->device == 0x7340 && pdev->revision != 0xc5) ||
-	    (pdev->device == 0x7341 && pdev->revision != 0x00))
-		return;
-
 	if (pdev->device == 0x15d8) {
 		if (pdev->revision == 0xcf &&
 		    pdev->subsystem_vendor == 0xea50 &&
@@ -5367,10 +5362,19 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
 /* AMD Iceland dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
 /* AMD Navi10 dGPU */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7310, quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7318, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7319, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731a, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731b, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731e, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731f, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7347, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x734f, quirk_amd_harvest_no_ats);
 /* AMD Raven platform iGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
 #endif /* CONFIG_PCI_ATS */
-- 
2.35.1

