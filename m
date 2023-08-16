Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934E377D9BF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 07:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbjHPFUY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 01:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241850AbjHPFUU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 01:20:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAAC1999;
        Tue, 15 Aug 2023 22:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKufe2s85WsTL6NIXN0QIyTIBxhI2bXTnfzr+pkpnakaXGYx/uy+yJ+0P/jIaXnfaY3i13LAVFF1IR4VxVYMWiOhjCGmzLICz6JKoiUiflapVJO0tjX7a58LNKWp0gkjmwlaFr7gMK+0PFVrhiNT1JcXUqireTJJOq8qeuY5JheKUaQyeZtnNYIGD2/Xe7QGImsvOQuG1HDQqroZdh7Z0yFG4gIswsIt9giQnPkqUyQY9ULmY9wMUTzHZv7BuLmqXpDRcMu9fxZPP0Y960xoklDQwENFvKkhIklkqHcIKAh9WT3qmXGqQXnefKGZFganB/UH6efRut9Wmy1TbZDSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Tk+JYvf5UeY8XEYcBdNYTw7vyC1DOs3pZFEu1aj99s=;
 b=HGnB9AAGie3cIVpv86TEFxSbhVqT3gdcGIFCga/dtghSIb2LReE/P+kc2Sh8K/zabwY0HMBSMQcC69Gd5oXemIKOQ09S7G7EEdYBQiskK042zregJftNxF96+ypoHj024YodXPAivao4N+HmDcZK89J+QWhAapKXd/tXrUmyJGuLfRjTMqhX4sMkRbStDD1Q9Vcs8w9VchqCrfhz2KWjRvPAEZyQsPeUFWjuTttRZgshg6epMWXq5d5MDzkHVI7qe72hXsqATJC6zr3WVXtNdkx0HDewvdWCE13hf31XVcSFIE8Cdp+hV4jMs5NfV7DYtBKOQv6CdMODUzyZdKlbpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Tk+JYvf5UeY8XEYcBdNYTw7vyC1DOs3pZFEu1aj99s=;
 b=S1wXTPF4i6HmBWDQQxIVLUcAOCn+VSwX1GxMeCttrQlxLjbzBxVknTPGWE3GWn7g0vn8l26/D4MKXRPinTQ2ZHAvGmyAI03oozT3rnOkUVwTF/6ERSEcVPIiafqqB7z7QbxhBvDTf9AMeSDtuKle2TvQJO1wNHpuV8lhprQjnbE=
Received: from MW4PR04CA0059.namprd04.prod.outlook.com (2603:10b6:303:6a::34)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 05:20:13 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::d3) by MW4PR04CA0059.outlook.office365.com
 (2603:10b6:303:6a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 05:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 05:20:13 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 00:20:10 -0500
From:   Sanath S <Sanath.S@amd.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mario.limonciello@amd.com>,
        Sanath S <Sanath.S@amd.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH] PCI: Allocate maximum available buses to help extending the daisy chain
Date:   Wed, 16 Aug 2023 10:49:23 +0530
Message-ID: <20230816051923.2287912-1-Sanath.S@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: c9012912-40fa-411e-dc39-08db9e187802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0hZhLwfTidJkZtS0F242jCntL/uQ/Y45WG5PDpyml638qKtacalmHa9lkevsndR3OsDD8sjTxBc01B8ZWkFDErut4wMYR8mWNXqoicrXSstSMzvYXkdhpid41cVMdIJCDOFD3EqnXuybNnEU+PkoW9TgJ7HJsIQyKxPHQNkXkizognGtSKLMrlZZGZrWeHYK+dHsdTkeAS9q17R6a/rrxvHJBUb8s9ZlCKX1AZ/1mGnXE31gLkQV6aUnFIPxKNTh3dQZOPVBMYB5b+8HQqAM0JWt93Bz0FO5EaM4n5HLTEEql9ZfYsmsmc0KqCEoan2a0AjXl6iXqGEScAAoCbBto8bUvOqupUrgVyJGEzlnZAx7F9XXd+qZhOqfzT30WGtvosDZIyzPlaRaGgG05OSoLTUERMhi4zNlGAjkHbhDLBCu9EKYT2Rev0JdBHnqB4+spSSi3XSs1Jtah20Nv9vhZ9U9qVAy8+lUma07Dy0t4m2K+LilbAouBfKN/DouYMkp2/T7fdeMXRIkV3iv8/kG+2NofLi5sT8SFjC9oEjBqTGwEXZl15fOmCOvW2bcWsdrU5AAPi1hVYwxPh9t1LwwZB0aNr90vsXsMgb8w+c/h4EemV0ZTTNaNpGnwoQ5ZLgJonH91MfY9E1bdCHlKeswik5nHLoO5/EaQyGmrbmJDjQ3EjxoUWPCho0TIoVe8BdQORF+py3g19xJ5pZ65KePDGV/vsWvfexFQ9jKC0qJk0vkvTrF7kiO4L99L1xwAskWrNPyCDFgxYHIWl18UBbuJaMrQAleoJD6bRHFN9aNzU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(966005)(16526019)(1076003)(336012)(426003)(26005)(110136005)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(131093003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 05:20:13.1351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9012912-40fa-411e-dc39-08db9e187802
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the case of Thunderbolt, it contains a PCIe switch and one or
more hotplug-capable PCIe downstream ports where the daisy chain
can be extended.

Currently when a Thunderbolt Dock is plugged in during S5/Reboot,
System BIOS allocates a very minimal number of buses for bridges and
hot-plug capable PCIe downstream ports to enumerate the dock during
boot. Because of this, we run out of bus space pretty quickly when
more PCIe devices are attached to hotplug downstream ports in order
to extend the chain.

Before:
           +-04.0
           +-04.1-[63-c1]----00.0-[64-69]--+-00.0-[65]--
           |                               +-01.0-[66]--
           |                               +-02.0-[67]--
           |                               +-03.0-[68]--
           |                               \-04.0-[69]--
           +-08.0

In case of a thunderbolt capable bridge, reconfigure the buses allocated
by BIOS to the maximum available buses. So that the hot-plug bridges gets
maximum buses and chain can be extended to accommodate more PCIe devices.
This fix is necessary for all the PCIe downstream ports where the daisy
chain can be extended.

After:
           +-04.0
           +-04.1-[63-c1]----00.0-[64-c1]--+-00.0-[65]--
           |                               +-01.0-[66-84]--
           |                               +-02.0-[85-a3]--
           |                               +-03.0-[a4-c0]--
           |                               \-04.0-[c1]--
           +-08.0

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
---
 drivers/pci/probe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8bac3ce02609..ab7e90ef2382 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1263,6 +1263,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	bool fixed_buses;
 	u8 fixed_sec, fixed_sub;
 	int next_busnr;
+	int start = bus->busn_res.start;
+	int end = bus->busn_res.end;
 
 	/*
 	 * Make sure the bridge is powered on to be able to access config
@@ -1292,6 +1294,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		broken = 1;
 	}
 
+	/* Reconfigure, If maximum buses are not allocated */
+	if (!pass && start != 0 && end != 0xff && subordinate != end) {
+		pci_info(dev, "Bridge has subordinate 0x%x but max busn 0x%x, reconfiguring\n",
+			 subordinate, end);
+		broken = 1;
+	}
+
 	/*
 	 * Disable Master-Abort Mode during probing to avoid reporting of
 	 * bus errors in some architectures.
-- 
2.34.1

