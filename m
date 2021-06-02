Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCEB397E98
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 04:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFBCO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 22:14:57 -0400
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:15457
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229751AbhFBCO5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jun 2021 22:14:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccfxeq0Cr30isF+mJuXfJSAOTbp4gaF5QMft3EFd0tAyNksFBWi0dX1HzlPg2Y6lIimceAcKGyZLgmd+vncEDNB6UQrXbV8+dx8ZOmzAmcl7vVBAA6U+PIOBDawgx/JapYlE2UdNVPb5TRvkdjKzyc+89/APH94Zu9k+jricRauhoEkGiapjjiGaEqemteWz7WBdZp6BgqjmeVHNIn82YhmU/EIXCn0QKDzgNcpMk5t+1/UPT+8DxUrb3jKugtQRkKXFVFhm8uniWX4CsJPhy2VoSoHHGMKgqaj3076rMakhsYBpCOoR/ihwELfj9Eo0MEHmKEV/QeIjwdnVAEsNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhK9XcppwllcrP/m4FOypTZp0a8RnOOWayCNsecIlOc=;
 b=nher4WgDtvDKGKpBW+5GQdwLoPlIL7FbOpuEPpZXf1WBa4MM5Q6m8l5ha9DcbkSSgwCXXYBkBy4PO3SeFKtMaWM8MNpf7z19mal8/Bu/1cDU8yAXflMVvnM+amFErpzoVyG7ogI52sAJukV+mV6s5CYsnkxCc/rWm1wgnwWL0ZDc3xNUxpa2lY/K+uXA+lNpeJs78BCOlT4dj1D8+LHdLq/OSQvpTHlZcHSRHiFDsTJtoV9GuF8gzf3eDJMmd7eKF5bpJ7Xt1dYRBPjfur+Xk+unb5PWB0Cv/bmExqQbl2qE3Q38l2Llu1vkSvokfdP+0BXo1umYpEh2Tgb/DfSXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhK9XcppwllcrP/m4FOypTZp0a8RnOOWayCNsecIlOc=;
 b=nHYUMPt4gQcDU3YWmHK62NimNYTIi8Xws4IBQKZFrhd1ZwdN1AgKc3ZESvr03nsZN3QKWaJ0InLxEb1nrPaefE8ps5/GPb/d0TK5H53+yJ+3Db3kQEiuhJZGQWCrsTSDGJ5Z3VLspTom/aJxDLg+dSBvxfS9PLHKtNqp+D4Ugrg=
Received: from MWHPR22CA0052.namprd22.prod.outlook.com (2603:10b6:300:12a::14)
 by BN6PR12MB1666.namprd12.prod.outlook.com (2603:10b6:405:3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 02:13:14 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::39) by MWHPR22CA0052.outlook.office365.com
 (2603:10b6:300:12a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 2 Jun 2021 02:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 02:13:13 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 1 Jun 2021
 21:13:11 -0500
From:   Evan Quan <evan.quan@amd.com>
To:     <linux-pci@vger.kernel.org>
CC:     <kw@linux.com>, <Alexander.Deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V3] PCI: Add quirk for AMD Navi14 to disable ATS support
Date:   Wed, 2 Jun 2021 10:12:55 +0800
Message-ID: <20210602021255.939090-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90e9321d-eacc-458e-3ab2-08d9256bfa1e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1666:
X-Microsoft-Antispam-PRVS: <BN6PR12MB16669FD6CD82B65A1D2FF634E43D9@BN6PR12MB1666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdijxgUH9/R6rGEtRQS7UFwp8Dz7qPaaN+w4MXz+GrRA4MXMyp0yf8Cep4aDWtJ/tNJLVVG2XUbAndMP2+vC7e0JWlEq2OyA6DYebrfiL5mwQakJ3em/T54CE2bVUQmqWPZmvDGT5hfL7K+Cs8/B6e6zFAi7Is/EMqByK1DdzthFgp6u/E29hcILR+mFR6MGYAKy+mUGetweDJbDeC7VrgBH0ThNChCvAqatQaedf/FASUvcPwxGh41Xq6CLOFmNijssL2RtFoF2ruF/N7bkgo9/idYSNGZyr7F4uJ4azU3MVmVQvgaT8WMF4ZzFMOYbHE2BMGEhphD/HoF/hKSosX+EI9dNw1+yqSvIBOI5c8h4voDk1sGf3PYkz2PETNTs1NPPcLForHOmwF2UBZxZh/Ym0Qbfq7+ewGkuy4n+8bYJ9V/iRGf78EqW+idRc3OibAueahsSPINewNpevLABQRPNNKD6lv1fuuOEemqYaFtEa8R4wteE8OEPowTN/EGg1i6OiDIaHaqcGPvHsBKWZ/Xban/4okrDo0fBFjyjANO/xOfR7ZWL4rvpRsXGBeCXkjPV6F/m7HJL7gnLrnjrRSF7xgAiDzEExQi3RxdHsckFUGsavIgbhQaSabijY6Lgn/4AWAdvUZk06tkluFgz0Fi+1JWOQG986moYT7NhC/NnrFA0x7+dhzVg9Gs7e1br
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(36840700001)(336012)(6666004)(6916009)(186003)(478600001)(44832011)(70206006)(70586007)(82310400003)(2616005)(8936002)(81166007)(8676002)(66574015)(426003)(47076005)(7696005)(82740400003)(5660300002)(4326008)(26005)(36860700001)(36756003)(2906002)(16526019)(83380400001)(1076003)(86362001)(316002)(356005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 02:13:13.6120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e9321d-eacc-458e-3ab2-08d9256bfa1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1666
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unexpected GPU hang was observed during runpm stress test
on 0x7341 rev 0x00. Further debugging shows broken ATS is
related. Thus as a followup of commit 5e89cd303e3a ("PCI:
Mark AMD Navi14 GPU rev 0xc5 ATS as broken"), we disable
the ATS for the specific SKU also.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
---
ChangeLog v2->v3:
- further update for description part(suggested by Krzysztof)
ChangeLog v1->v2:
- cosmetic fix for description part(suggested by Krzysztof)
---
 drivers/pci/quirks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b7e19bbb901a..70803ad6d2ac 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5176,7 +5176,8 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
 static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
 {
 	if ((pdev->device == 0x7312 && pdev->revision != 0x00) ||
-	    (pdev->device == 0x7340 && pdev->revision != 0xc5))
+	    (pdev->device == 0x7340 && pdev->revision != 0xc5) ||
+	    (pdev->device == 0x7341 && pdev->revision != 0x00))
 		return;
 
 	if (pdev->device == 0x15d8) {
@@ -5203,6 +5204,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_no_ats);
 /* AMD Raven platform iGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
 #endif /* CONFIG_PCI_ATS */
-- 
2.29.0

