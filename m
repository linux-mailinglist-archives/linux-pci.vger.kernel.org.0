Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7FC5A78BD
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 10:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiHaIR2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 04:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiHaIRC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 04:17:02 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA67FC59E6;
        Wed, 31 Aug 2022 01:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbgOo4MeFeukGZ7w4mk7h7txK4yXqCP8n+CVGU91OOUTYryskfY+IKE2nIFPuw16hzeLgeg9X8+P9qKBo81gYXnw1ZvWs0MIgHC+rrWOq92MpNxRi1K799BNS4qpFPyY5mh4pEnXQESsZNsCNbgiQizbk71HGkJfgVKhORkzZw48ZtfAGrxxNaL14leRm0DUXyVVIXez+wn/r++2bC4hAXp36R5kWOoT8+ZV0FIWcqOzmoisKm8IGWJZhxUUdbkwfuDZRanBjK8Err55TEukPgspO9C7l16VBFiAACnXMfZLoJydvbL5AbVKfndJZiOZ3uzxvGQRw9HbYov45FtpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8z+Z6Tdn5o+4nlS7uEC+Ocqx9JQK16JI4XKVYon7zY=;
 b=L3FBB6E84h96V6YxXRfk34bDxe80enw5WeJGWxHHQ0PVbECCYGGHY49O3gmeEqrvnyaeh1rJgG4kAwT285btUxArh+vTxGkcBvaB+/LlzBVQCtJ+euwYGinSIzC+Ccj2XYIKgFbfOHLr6vBNdcqJ1ka3nqPVKyEB6Mb4NOAKcgU5IUmq7+7Lgy4wFXUGu3ysMyfiIC85UwFXbyCzXA1lCH5Orxd6VMsTLIVaHZKkZb3Q+ULfkh1y1Sq8t3l1mleFgAhh1DT/q4oXZGYAgBF/l1j3NrHF7O1RvWwcgK154tvK0l5PLATe2NTov43WnVNmo9nNNiQSrBFxuaGeUP0F/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8z+Z6Tdn5o+4nlS7uEC+Ocqx9JQK16JI4XKVYon7zY=;
 b=KNJanmfiPR69xoKNG7xy2jQmQdE0jtAj48x+0MyxIHbJsjHOXL8tRa3Ps2ADh/D87EA0YonOGUIT+b+NKhgLne1z4gNPGGhrR5y3a+sESXHnV6Zmaqaw8kkehVctZV/jpM2BSQgjdRIj8XOz9UGG1nWJLy5DlOwJjxIbWO7P2yI=
Received: from MW3PR06CA0008.namprd06.prod.outlook.com (2603:10b6:303:2a::13)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 08:16:56 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::9c) by MW3PR06CA0008.outlook.office365.com
 (2603:10b6:303:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 08:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:16:55 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:16:52 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 06/15] PCI/ACPI: Link host bridge to its ACPI fw node
Date:   Wed, 31 Aug 2022 10:15:54 +0200
Message-ID: <20220831081603.3415-7-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220831081603.3415-1-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2513867e-e42e-41ec-0c6f-08da8b292af4
X-MS-TrafficTypeDiagnostic: CY5PR12MB6153:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8oN+BDWLUbIf40FJ3oRMxAQjpdvD/yy+pV3+N1wv+ILrLgX6JaSBqgxjw0pUZyvCbIJFkLmnDQSWeuhVwbHFOVVaJz4TMEkLN9tlHcMS+m6knI0GYlJGFLOah93fLrSZ6gYXLTpwfY48hr+h0BlnAuu9AG6FR8WNj3AZiu5lPCaB8Qc3gJM+Ua8n9URQBW+M0wJpek8UiNlNLkeEgtazAQuaOHyfKavvnZ8v2Q8zf+JCexyY52LkO3FwM+1cVbpbmlB17KZCXVkOxssbA+yj2qWa5PURCDi09mZDfLSC0Cc9dJbsG8Bqnj1AYwERnJX2RJyTxU+5gFSAM2e7TfrSazFbc6E47yRJ1SZ3yJ+XvNXyLyVgqf0Q7CvC+BY0UUWbeTIroPtMqxXr0O9b1jNlbGLD+TCqlO0fWoEmTHHGm8DbrHTqUWQCTaU8FYKrwJjUrj3ZxfPzFqTZq0vPeTziIWiD91AZEcparNHaGF6MrELH2U2GAJoNx0czx0/MxDG+i4ZwZHClidwyVQ+nkn0IcWPQE89v3dUiKEAftqrWnUSrGPCr7P9u414wpNGVQD8BY82ZShDAMs06FHnreQ8lpH9h4m/T5z8/8Ljr+6AxEojDBsWAnstYnnBhPKCSwJ96xWmih9jm1SRDa++9bKAi79OTe49Zcp3WE/znn0UPoBDeIKQLqpHbji1/gLQtAVVptbTzhE/8BAhbWGDw7vvBRnItuSVXuIwxPUaAy/FX9iz/f8MmGCyJuw17gAvW2OpP6NKEMGM/TM+TdPDVAAlpoX9vjyXyckFoa9O2X9q5RCUr9yamVLozXhJPbzCdLMFx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(36840700001)(40470700004)(46966006)(26005)(2906002)(36860700001)(82740400003)(82310400005)(2616005)(426003)(40480700001)(47076005)(1076003)(186003)(16526019)(336012)(40460700003)(316002)(54906003)(8676002)(70586007)(70206006)(4326008)(110136005)(36756003)(41300700001)(81166007)(7416002)(356005)(5660300002)(8936002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:16:55.5028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2513867e-e42e-41ec-0c6f-08da8b292af4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A lookup of a host bridge's corresponding acpi device (struct
acpi_device) is not possible, for example:

	adev = ACPI_COMPANION(&host_bridge->dev);

This could be useful to find a host bridge's fwnode handle and to
determine and call additional host bridge ACPI parameters and methods
such as HID/CID or _UID.

Make this work by linking the host bridge to its ACPI fw node.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/pci_root.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d57cf8454b93..846c979e4c29 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -1083,6 +1083,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		goto out_release_info;
 
 	host_bridge = to_pci_host_bridge(bus->bridge);
+	host_bridge->dev.fwnode = acpi_fwnode_handle(device);
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
 		host_bridge->native_pcie_hotplug = 0;
 	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
-- 
2.30.2

