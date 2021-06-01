Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5379F396B9B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 04:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhFACut (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 22:50:49 -0400
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com ([40.107.237.61]:57952
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232626AbhFACus (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 May 2021 22:50:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uh/GJSjA0VBiRmjJqMG004h5PjrWmGP/ZZuvbR4pTJPsTuovP7Sz1DKN36c/emNEQy0J2QliUL7K8NCa7NT/5qo+D7lpnmwQBmoV8koD+XCEu7NKUtWl0fHOwj6XEeFJjWkiceIENiukdUXjHmJePUVqwrXTcR0CM4O5Q3akgQ1FKd97dycfg0CvjlKwabspzcfNTstIeP7/5yi73ZLxM9DjnFtkUgCTGQLIAerHYlk4PM9kj1C7pORWx05gPZDgYn/bvTodTqe96ub/KNaslXJtQN6Qa4x74pvkkraikhdGHSJF2bbHkKrAQS+ekXWRl0C+mvivA+edXuQnXFtmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gaRQgR+j564WFnJx+Fdrp9OETq9b0YyjgHdTNt0vO8=;
 b=GkFD/D0vDwEATsT2UkqPDWEbKA4ROtG73GgNpdt0CvBnAMau4I6i8oObw1OWEwE7uf4YgYcMdc6IwWVBl+/x80Ln7WmEcUDkWsf+/r1w3l8jjBHg8FmbkCUOjP5fXUYJdvkQUwZf2v7AqEPaGyeRgWqUuobFgN8x8lr4cCsOtTjHKIljhyhM+YxSxGA98WeLTFNE2peMC8vSwmf2yFykY+wtIOzYJLRGwTjATZG8zBh79TFBTx0QPVb/OdlSoPhcin15kOVyDSzaILz9HLjrm6g93B3IiOs8mOdJC1G1J+bdS78OPwUHsO9EJf7hdaC0sJ/2H0v14cTWlyowGLyVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gaRQgR+j564WFnJx+Fdrp9OETq9b0YyjgHdTNt0vO8=;
 b=BUX82IwGmR3YRALHqXhcTkTSO6Z9ibeGIN7W8hD8H8Q39QS77rt0k2LriL1oKBJA0OiabT4QIgvYjxiGiyBTP6Ff28K6dBAycz5FSHsQk1L1yceFEeFyNqlngwgbN0TvYkc8uvJ9GbodB0RsN+BB4GfF6qa76s7UJ5b5v7YQWjA=
Received: from MW4PR03CA0353.namprd03.prod.outlook.com (2603:10b6:303:dc::28)
 by BN6PR12MB1603.namprd12.prod.outlook.com (2603:10b6:405:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 02:49:05 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::1a) by MW4PR03CA0353.outlook.office365.com
 (2603:10b6:303:dc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 02:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 02:49:04 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 31 May
 2021 21:49:02 -0500
From:   Evan Quan <evan.quan@amd.com>
To:     <linux-pci@vger.kernel.org>
CC:     <kw@linux.com>, <Alexander.Deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>
Subject: [PATCH] PCI: Add quirk for AMD Navi14 to disable ATS support
Date:   Tue, 1 Jun 2021 10:48:35 +0800
Message-ID: <20210601024835.931947-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f449dd3f-0f6e-4993-7d80-08d924a7d1e7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1603:
X-Microsoft-Antispam-PRVS: <BN6PR12MB160358DAC6B3C4B4F3B819FAE43E9@BN6PR12MB1603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0Ns1x+aWlaxrPfBumxQfB35rgurl4qDyHvt4DbGR47Vu0jq3sk96D8pc0HoWjoN9JN/7Lf9t4HNSoYrtvPIMK0P0o8S0W34WQIwOi5Y6OV20mnA14KHOmOQbo3OwzvPRC69fjrwZ2f76HS3G4kHeVX2smvAG0YIVBX+BSIMem20fkG6O6jVCwIjbZNlEq6DTCqE2bm/X8BLjByYm/idNRsy55rX2cSbhg+9hgwj3YzfV//7Dp9QHf7ppWgKWA5wIuL9xpdPLAK5gvXcyLoMWaQFwGJQgfeURQCcBIIabdjqJ/ScX5vkM6BldtWTVY81B7Vw280p97CXGixrCLCpAYkQiT3Hqz+ZiVYG0ICNNmofYsKTirsJJ+/pM4lNVQAcz7b50sP17AiQOkxt0d9CadRf/bskZTTRCeg2w6VgrUQ4UoP3IiZjRFL1qk4OPwemV0pYUnOmodrgw6bbMqTBCDFrb+is3hkjdKQ7rqvCoWyY/3A2da22TlhWh97YggLDHD4fyYs+BCWyR0Z116Si983erMeA9q5PnTUHdsBUc0qpj8PGjjIv4qD7gePzVI08dMWz22BHXrowSv5aqCHVV4MtEOe1w8LnyeNPyF9Z7S5WJJLIbLfy15QjLwDkKurQrlHm6Tkmo8taxu3dZ5h9eXbXxIieQ+o/4QxFDjRMwldBsCzICx6VeKZM733NayhY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(5660300002)(81166007)(356005)(83380400001)(6666004)(4326008)(70586007)(336012)(70206006)(8936002)(36756003)(16526019)(2616005)(44832011)(426003)(186003)(86362001)(6916009)(47076005)(478600001)(8676002)(82310400003)(316002)(82740400003)(54906003)(2906002)(26005)(36860700001)(1076003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 02:49:04.7694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f449dd3f-0f6e-4993-7d80-08d924a7d1e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1603
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unexpected GPU hang was observed during runpm stress test
on 0x7341 rev 0x00. Further debugging shows broken ATS is
related. Thus as a followup of commit 5e89cd303e3a ("PCI:
Mark AMD Navi14 GPU rev 0xc5 ATS as broken"), we disable
the ATS for the specific SKU also.

V2: cosmetic fix for description part(suggested by Krzysztof)

Signed-off-by: Evan Quan <evan.quan@amd.com>
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

