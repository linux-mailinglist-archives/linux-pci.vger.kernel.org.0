Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0187D7A70FC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Sep 2023 05:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjITD17 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 23:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITD15 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 23:27:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A017D9F
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 20:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQyKkQPKDNbAXcnYBpnUCi1XQ/yHOcCHty+i87GLG8Ajy5kaLSilK+UeCoX4k2p78iO05tLTRBi7JLDMt9qu0Lf0wG40qPJUNO8lWURzd16aAiVZ5fIWCYJDtfKgryiJ+yZJfnUoAl5of/T6cVgZP3Jd72Z7DG7FRT5Cu8JdpmzcEsZ6ar68brv7vJF9lp1tmnbFAd9Qm1TdYkf49Q/rZjy/Mg23RZDff3fk5W1gaqmTDDIpTZh9f8Sb5vryPG9US8pwITqsWPcMtuYQ03xt/vOf3leJY5gZuDmfz4cqQVZHtP7+ZnZHEu1aqB4Rs9uEhGsNJj8dijZe9rArzWsIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgronEOfItiiC43Q6JAvapnqM7Zx8h8Xs3VP4Owv7q8=;
 b=EAZQ/Btqr8H9CsKUe4LWXOmW5x+UwtRHit+DqHAq3T458w4ObqNt7CT47/VCQIqMc2lWy1rBlghK52kZyymtWj3b/Z5HVSTrtyRC62pME3cQXgGpCVZxrnNScFUKhww8+hcHy8iJwv3pAFpVCKtIgkbZ6U0RGXsMjC89VWrj1x7ahMHcsQ47W9D/Sz7vQkXFsPT7Lsbw42Eq1wx2FGizd9PZotedLYsaMvf64cigO/34bNZg1bgBPOoVE5cr9ZE++j3nL9Fv0x39I3+0FF1MAvtNVL+kIpdpaIur8oNsnbrQX12oDt5vYTZPxowV8y9zcBFrhV0u/7o2PYy6fhn4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgronEOfItiiC43Q6JAvapnqM7Zx8h8Xs3VP4Owv7q8=;
 b=TKi03xxnqP5jShjVqJ5SNT+OS3zD66eBaDHjFGLLszGZexz0vSD2Gf33mo8/Q4ORJpEiZQXHI5EHQIQDFyKGhu3Ug9hrrfyYBdaAh/dn1pGrcRPRsXAvXbchSmK4woixLHcxlImodTw2PQWc8e0IR3xzukBy3bx8VaEWmll30AA=
Received: from PH7PR10CA0008.namprd10.prod.outlook.com (2603:10b6:510:23d::14)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Wed, 20 Sep
 2023 03:27:46 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::db) by PH7PR10CA0008.outlook.office365.com
 (2603:10b6:510:23d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 20 Sep 2023 03:27:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:27:44 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <iain@orangesquash.org.uk>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v20 1/2] PCI: Move the `PCI_CLASS_SERIAL_USB_USB4` definition to common header
Date:   Tue, 19 Sep 2023 22:27:23 -0500
Message-ID: <20230920032724.71083-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920032724.71083-1-mario.limonciello@amd.com>
References: <20230920032724.71083-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: ffffea07-25e8-486c-e4f8-08dbb9898eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhIF+fwrm620rbAt92o4mth7mnWccMEN8cJizBNEUvlkigwZ1gXLvWZRmUsWXB6Tuvy0/lQXetUJLGYAQDnYR/6ZFk6xt5E1HHAD8oL1Tj/OSV6KlS4IDtVTdcbmVVUT/jEhbw/K693uLHfIzSeqO1JoZXn83vpzR5fHktzyP5diHl4RwPNVYCybFjHE0eI0iiV6n/BS4llMCNkF8PiM2SKfOQgvPcsqZHZ1Ah93OI31ps5sGb0WmDnE6rjRItNZhyqlJQciqJPlaPJmhsj/vWUBBfnHn6rwjwRC10BzLuQC6AwHOxkjfUo8TPcSDfljOuQTYqVsMAFNQpR1RgG9cTYjKjwB/qEzK6ACstUkbbdE0VbxIW6AGXMsiJzpl18PwP2D5PDaQJdow2NFLDJ05WS4o9vXixrCtZZ4GhnwWH640vYcrG2EE7SabOT3yeGcg3AnHK5iWTa2liP4R08hh0GCA9MZPH2o6dGybDkEH8DhXfeESQezq2tbMZrEP0X8eq8xftx+yOsb1LjTKIcYS7+FFsaPHzV50ie+TLDbVGHAFeXV6EQWQR7Cuys7qBp/0272sjTk7beAQG1LQG4qEUpbJ2oLykdLjMysPLuGaoLT0dsoPhqGRBB3OFlZRct1ObZro4RDvhjAGf7oSpmbWY023I8njMETLYLwg8272nCxl4EM3rkVACt4jqzm7ADEC+4pZPXb5vjYHzAvZPY5AQ+phE0ioH+IDF1wCBQOzUPWrcFLjRyzcFRc3xaqMJs25pBwtq5viJUGmoYdG31n1KMrO7b3GpbHtsiryK1tzmE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(40480700001)(5660300002)(44832011)(7696005)(86362001)(54906003)(316002)(41300700001)(70586007)(70206006)(6666004)(110136005)(478600001)(2616005)(16526019)(8936002)(356005)(26005)(81166007)(82740400003)(2906002)(36860700001)(47076005)(336012)(4326008)(36756003)(426003)(40460700003)(1076003)(83380400001)(8676002)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:27:45.7619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffffea07-25e8-486c-e4f8-08dbb9898eb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

`PCI_CLASS_SERIAL_USB_USB4` may be used by code outside of thunderbolt.
Move the declaration into the common pci_ids.h header.

Cc: stable@vger.kernel.org
Acked-by: Mika Westerberberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/nhi.h | 2 --
 include/linux/pci_ids.h   | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index 0f029ce75882..675ddefe283c 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -91,6 +91,4 @@ extern const struct tb_nhi_ops icl_nhi_ops;
 #define PCI_DEVICE_ID_INTEL_RPL_NHI0			0xa73e
 #define PCI_DEVICE_ID_INTEL_RPL_NHI1			0xa76d
 
-#define PCI_CLASS_SERIAL_USB_USB4			0x0c0340
-
 #endif
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5fb3d4c393a9..29aeac53dc41 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -121,6 +121,7 @@
 #define PCI_CLASS_SERIAL_USB_OHCI	0x0c0310
 #define PCI_CLASS_SERIAL_USB_EHCI	0x0c0320
 #define PCI_CLASS_SERIAL_USB_XHCI	0x0c0330
+#define PCI_CLASS_SERIAL_USB_USB4	0x0c0340
 #define PCI_CLASS_SERIAL_USB_DEVICE	0x0c03fe
 #define PCI_CLASS_SERIAL_FIBER		0x0c04
 #define PCI_CLASS_SERIAL_SMBUS		0x0c05
-- 
2.34.1

