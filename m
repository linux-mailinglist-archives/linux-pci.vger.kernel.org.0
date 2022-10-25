Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA1960D6D8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 00:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiJYWLR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 18:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiJYWKy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 18:10:54 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2045.outbound.protection.outlook.com [40.107.96.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87072993A9;
        Tue, 25 Oct 2022 15:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3eB9VQirvGVfogWUrRayIAGuyekFb7dVsdWFeNtfn1pQeHmUeJneScLeqTEQKdZ+e7vFfalVENpjy+Deyw6zlZZoO64PBOM+0FlnV8tqPjQHpKHfhpW/26m9RRRoiKG/ceoxebBrK9Bib8r5h9RulfayceQlpn3l/0LmqmRNNN0MbfjoAyqGc/mshtXnpspRa2MGRqW7jMgyfeiSzd5qSfQeIR387EHXJXbzDftUPS96ywpCI8mjP0shrrSVPf0+kTegB8XCNuySwAGuVjIhNjOYm2kXPLK6Gj6ENXmizUCpcgvw2u9PTUhstuQs580KljW2rk1X3qH3fnkpqVvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jiRo/hM9NqoJag8d2jT/x/LvS3lQdwskCt8tlystQk=;
 b=d9kTONXjU7wpaFbXlXg9CbIaxJLMkOtKdrg3WqHWn/RoY9loOXXr5QNSrh/1NWN5fAc1QRGFYCEUZIdPs/0Q98RLb+GzbbR+IbJZdipBRUHSEYpdEmgCYg8pkuY52MD/XxP0/2Mi3/1q0phtYUGJ90rlRevLjvu4x037YDJ10NCWBcWljaa8JwO6IHFm4QEh010i6CrQQNZ4VgTzqvrhMSq0AvOqbGgD/Df5tT6mygIyDKkrKji1OEGUK3E5m+M8B0/ir5IHzpBLTmEGoaQXetOIHlNy1me+PhyiuJQIgvainS25LNI/agT/Nv6pPJXVAl/4Uxqg+0uu2aRWEMoVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jiRo/hM9NqoJag8d2jT/x/LvS3lQdwskCt8tlystQk=;
 b=BSe6kI86qw7+9MUGf5kRuBmh9ZFKJoVu/8kBlZSreuXfdSsWh++HSs+MuXG+rF9s7GB5Mun99O1mTHLNrVncBVBzwpicGJ2bPfiG/4XNMGxJVFUsgEJtmPDgWk3L81ug7NPuHOpaO8OXb6ejWb8QqqHLGOJI9SlyzPCsvnDcPz0=
Received: from BN9PR03CA0127.namprd03.prod.outlook.com (2603:10b6:408:fe::12)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 22:10:48 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::65) by BN9PR03CA0127.outlook.office365.com
 (2603:10b6:408:fe::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27 via Frontend
 Transport; Tue, 25 Oct 2022 22:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 22:10:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 17:10:46 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] PCI/ACPI: PCI/ACPI: Validate devices with power resources support D3
Date:   Tue, 25 Oct 2022 17:10:54 -0500
Message-ID: <20221025221054.12377-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: ffea848c-b1bd-4547-9d81-08dab6d5c5bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYdl+qjBpG8BaZ3MzheMnfFwVqk7nnLStwBauDZHD+FgNdem7ZvFYa20XkS5e/BaQSuHW7MM0mCSiBNeFl7gIATqGKrYNRh3CqE/n3feUzGvQu7K0braVdi6eRO4E3gN+siYrJptXFJOQySYQVzqryvkDSoWcN54pJ+PDZlhlD9xfFE1CZKVFje9Kr3mewtZOYwDNN0kNpOaveOP7YitC9D/UbJ4azXzLIsp2qKkNnxEuvsDG6IygGPUN8WsGej52sFhZZAXjvG6RdVO+YzFF4Y1gpspzOZA4Ev0wUo3YrgkFVml2cmp8eFqvS1KL2u0tiO8JqMQvl+DZI5sG48KTIzxlXA4QkKEjbvIruRdNTGCxxS5o3DFV15oN5/IEUEcVmyjTI6cpJx8aDncv6NCtxJSdj7txI/VNY1zk+juZPsmJQPcKHjCRsjA1tfZAYblHd2U27tyNELnsftm659eaL/oa4FaE5HluCwxSZ5aw2Xs71owB1hfGq9tUde4wTz/+23PzFbWAP4xAfhgkKJv1Y0SMhsdTpFk5meVqSCWqlqbLS/Muof6r9BBkbizzJZZO35oQGDTzvW8NgEIIMyDOv9bR3mkZiU9D9hJ2ihzXQHlr+mehsLevCcGbH4KDyPE7lS4zrG/y7hvbxhuNQcR/lPWAyNdaxbRu3/iXCTPv83klDCeOqlu6/f7e+lJvJAZPmTES8NxDNeO6OHwvzUR45nIoZY3J0qAy99h5BJCaAWpp31mWVMHSNACKT387ndCBgLzSnyp09CXvECKfn1hvg175vgMQrZT4L+U5KgGWuQubUqP0VIdsUJtECuz56uE
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(4326008)(8676002)(2616005)(26005)(16526019)(66574015)(186003)(82310400005)(7696005)(70206006)(36860700001)(41300700001)(40460700003)(47076005)(1076003)(70586007)(5660300002)(426003)(2906002)(8936002)(44832011)(336012)(478600001)(110136005)(19627235002)(316002)(6666004)(54906003)(15650500001)(83380400001)(86362001)(36756003)(356005)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 22:10:48.7705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffea848c-b1bd-4547-9d81-08dab6d5c5bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Firmware typically advertises that PCIe devices can support D3
by a combination of the value returned by _S0W as well as the
HotPlugSupportInD3 _DSD.

`acpi_pci_bridge_d3` looks for this combination but also contains
an assumption that if a device contains power resources it can support
D3.  This was introduced from commit c6e331312ebf ("PCI/ACPI: Whitelist
hotplug ports for D3 if power managed by ACPI").

On some firmware configurations for "AMD Pink Sardine" D3 is not
supported for wake in _S0W for the PCIe root port for tunneling.
However the device will still be opted into runtime PM since
`acpi_pci_bridge_d3` returns since the ACPI device contains power
resources.

When the thunderbolt driver is loaded a device link between the USB4
router and the PCIe root port for tunneling is created where the PCIe
root port for tunneling is the consumer and the USB4 router is the
supplier.  Here is a demonstration of this topology that occurs:

├─ 0000:00:03.1
|       | ACPI Path: \_SB_.PCI0.GP11 (Supports "0" in _S0W)
|       | Device Links: supplier:pci:0000:c4:00.5
|       └─ D0 (Runtime PM enabled)
├─ 0000:00:04.1
|       | ACPI Path: \_SB_.PCI0.GP12 (Supports "0" in _S0W)
|       | Device Links: supplier:pci:0000:c4:00.6
|       └─ D0 (Runtime PM enabled)
├─ 0000:00:08.3
|       | ACPI Path: \_SB_.PCI0.GP19
|       ├─ D0 (Runtime PM disabled)
|       ├─ 0000:c4:00.3
|       |       | ACPI Path: \_SB_.PCI0.GP19.XHC3
|       |       | Device Links: supplier:pci:0000:c4:00.5
|       |       └─ D3cold (Runtime PM enabled)
|       ├─ 0000:c4:00.4
|       |       | ACPI Path: \_SB_.PCI0.GP19.XHC4
|       |       | Device Links: supplier:pci:0000:c4:00.6
|       |       └─ D3cold (Runtime PM enabled)
|       ├─ 0000:c4:00.5
|       |       | ACPI Path: \_SB_.PCI0.GP19.NHI0 (Supports "4" in _S0W)
|       |       | Device Links: consumer:pci:0000:00:03.1 consumer:pci:0000:c4:00.3
|       |       └─ D3cold (Runtime PM enabled)
|       └─ 0000:c4:00.6
|               | ACPI Path: \_SB_.PCI0.GP19.NHI1 (Supports "4" in _S0W)
|               | Device Links: consumer:pci:0000:c4:00.4 consumer:pci:0000:00:04.1
|               └─ D3cold (Runtime PM enabled)

Allowing the PCIe root port for tunneling to go into runtime PM (even if
it doesn't support D3) allows the USB4 router to also go into runtime PM.
The PCIe root port for tunneling stays in D0 but is in runtime PM. Due to
the device link the USB4 router transitions to D3cold when this happens.

The expectation is the USB4 router should have also remained in D0 since
the PCIe root port for tunneling remained in D0.

Instead of making this assertion from the power resources check
immediately, move the check to later on, which will have validated
that the device supports wake from D3hot or D3cold.

This fix prevents the USB4 router going into D3 when the firmware says that
the PCIe root port for tunneling can't handle it while still allowing
system that don't have the HotplugSupportInD3 _DSD to also enter D3 if they
have power resources that can wake from D3.

Fixes: dff6139015dc6 ("PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Reword commit message
v1->v2:
 * Just return value of acpi_pci_power_manageable (Rafael)
 * Remove extra word in commit message
---
 drivers/pci/pci-acpi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a46fec776ad77..8c6aec50dd471 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -984,10 +984,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
 		return false;
 
-	/* Assume D3 support if the bridge is power-manageable by ACPI. */
-	if (acpi_pci_power_manageable(dev))
-		return true;
-
 	rpdev = pcie_find_root_port(dev);
 	if (!rpdev)
 		return false;
@@ -1023,7 +1019,8 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	    obj->integer.value == 1)
 		return true;
 
-	return false;
+	/* Assume D3 support if the bridge is power-manageable by ACPI. */
+	return acpi_pci_power_manageable(dev);
 }
 
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
-- 
2.34.1

