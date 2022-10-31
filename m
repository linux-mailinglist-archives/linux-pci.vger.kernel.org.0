Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641606140B8
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 23:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJaWeV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 18:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJaWeU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 18:34:20 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874C5F5F;
        Mon, 31 Oct 2022 15:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLwo43qbVn5bm2luEgDwPyOuvc4z0/asTvUeFN1zRuhJ2/yro9t4KJgFuWT2NNwWSRcC9VGh8OibfTZKAAq+wkGW7y4uBPJXHrrhEZZoXB5rMWjBmXKO2cndrts/U24R3hjcZS2ipPdey7W6/hNM2+8TbC1PyJjkURCjrBYcZQXgLdFedlZJrDe/35UgK6BRvTR06pxD3A+CoenClPi+sfxKfgSAGsv16UjtpyUK4UDYZGHREe5BWlmK+XK+QNX4mX4PD6OW/rf2I8fndj7gi1Kgbee8aTkLGlZnBCSvf4p3uSvhiir/XNCQqi3x4uG7leawxHdzXioJJ6tPXuZDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuDgPxzL7NQ4WxC1tePuoGRGTIvqKDvX9DTLGPAOO3I=;
 b=V2bJNDU4SVll1wpC3ZcolMphp1QzTPj4SVMfOO5Hd4vPFoup2A97J2+MpOaIXYl6RAhzPw2OMaJenGgsqexrWdCnM1pg8D1fEyNcOspK99OkqiEbHq5gXvRU1Wokzcxs1ot8DBbMgFaJ5mID1Y9gxtgryL0V8zjRFWF6zemarNFeFQmNVTooyPaYZa3qgOIBysfgenB/+zrD8m00lRP7eedhjgMWmceghsrm46No0NYP23720xs2oqPgrnVYDJaMLGXcayYJyn6MHrcLPtcAX3ms6fd8i19WQvUB7hWfAJ8paJN5nVZs4iKhfiJVG+ACVm2YhR7J/Fdd4mza7vLlzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuDgPxzL7NQ4WxC1tePuoGRGTIvqKDvX9DTLGPAOO3I=;
 b=wq1VBaKyk9PPDpfMmCItGpPy7vPfPpHq0pvqBX9pwP0zfvthLK8OuU3SJtPVTZPr5lYqGJRxmifs5e6QrRr48dONfbB/YE4n13VMsDmdMrW1eu6fzy2+NQUeIV2qjbGQnb7HtldOG9MNmcmLOextA1LDjvaZQHJr21YSMZ/+JSk=
Received: from MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26)
 by BN9PR12MB5243.namprd12.prod.outlook.com (2603:10b6:408:100::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 22:34:15 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::45) by MW4PR03CA0171.outlook.office365.com
 (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Mon, 31 Oct 2022 22:34:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 22:34:15 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 17:34:11 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] PCI/ACPI: PCI/ACPI: Validate devices with power resources support D3
Date:   Mon, 31 Oct 2022 17:33:55 -0500
Message-ID: <20221031223356.32570-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|BN9PR12MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d12e04-46e6-497e-441b-08dabb900aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDU1eniuaazJn0pnlL9NkYUraizIELJkaKTv89VtK1aUkYqzLh8fecizLh2/WmdXzK5+vHptVIKUa+w+k4NUquSGZt40GQ0tYx0TcDOUFHWP8bgfiNrJtavJNLVqzcYizG0hxLYWOr81CDUmTO7mwv2WnxP+RcoVglBQtc681YoFB6a004OD0sDoCUC4I02X1cStpdwy0/xzRUvwIR1YCyUIJXY0zmyQ6YYquxS/3tUJrmqzjJoL39li5W38hQE5P+Pv2FaKu0dDbIk+3R+472YcMD+1hGFbZzxDhRiihDVU0HMD/5K6Fm8GO8fQ/23dava/Jn8me9uPFROCZPb6ZrhvSu6VmMlF11bwU3LSihN0HK0ZYc+69ZJSa2RIZuV9lut5f3ytzL2XyM1rGbu+2EW/U81nR1ZUOjo6QSXAiEa9VhDzjE9Wm869Fps6YN/0MvZ7EBdm+XP/QeU4BsYpsa6Aw6J/DIujWCOoTbmR2q+YvMR5MH6esd2Ar+b1n6Zg2SqZAiZjKONHcvtA7p2SWviVLQFhG/gdoMLjVdN3EhRZ+MSlRcrCLSQpM05iRT8rF/mNVLHq6N89r7zVBTXMAZAn77Mvcu/4wDs4lBQ2ZOTb7U23qv/eQUAegneB8y8rFbS4yIMFdhAv7HrLqz65LxgvPer4gNPdjImLTlInFPM6sZ02LOrGAKPAoKqBlM3s9wqXRuRhqe5LyuJUlXrrEH1MvpnJ3LZNRXpStBTpiGFZKYInrdJRkicIKAMHw6AQ0/eE3+455MvmWV4iStRTfFmaOoZawC/gXc9nPWg9eOQPjdkwq32KTiIuhNu9lGPZOHGXSq897/FUlZO9VgmoKjOvSDklVy9nWNuchwBZBR3rSOE/NEM6HOxSqV2mK3vX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(66574015)(86362001)(356005)(81166007)(82740400003)(40480700001)(36756003)(2906002)(966005)(44832011)(6666004)(15650500001)(70206006)(4326008)(40460700003)(8676002)(19627235002)(5660300002)(8936002)(478600001)(7696005)(41300700001)(54906003)(316002)(110136005)(82310400005)(36860700001)(186003)(2616005)(70586007)(1076003)(16526019)(26005)(47076005)(83380400001)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 22:34:15.2981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d12e04-46e6-497e-441b-08dabb900aa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5243
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URI_TRY_3LD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Firmware typically advertises that ACPI devices that represent PCIe
devices can support D3 by a combination of the value returned by
_S0W as well as the HotPlugSupportInD3 _DSD [1].

`acpi_pci_bridge_d3` looks for this combination but also contains
an assumption that if an ACPI device contains power resources the PCIe
device it's associated with can support D3.  This was introduced
from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
D3 if power managed by ACPI").

Some firmware configurations for "AMD Pink Sardine" do not support
wake from D3 in _S0W for the ACPI device representing the PCIe root
port used for tunneling. The PCIe device will still be opted into
runtime PM in the kernel [2] because of the logic within
`acpi_pci_bridge_d3`. This currently happens because the ACPI
device contains power resources.

When the thunderbolt driver is loaded two device links are created:
* USB4 router <- PCIe root port for tunneling
* USB4 router <- XHCI PCIe device

These device links are created because the ACPI devices declare the
`usb4-host-interface` _DSD [3]. For both links the USB4 router is the
supplier and these other devices are the consumers.
Here is a demonstration of this topology that occurs:

|
├─ 00:03.1
|       | "PCIe root port used for tunneling"
|       | ACPI Path: \_SB_.PCI0.GP11
|       | ACPI Power Resources: Yes
|       | ACPI _S0W return value: 0
|       | Device Links: supplier:pci:0000:c4:00.5
|       └─ PCIe Power state: D0
└─ 00:08.3
        | ACPI Path: \_SB_.PCI0.GP19
        ├─ PCIe Power state: D0
        ├─ c4:00.3
        |       | "XHCI PCIe device used for tunneling"
        |       | ACPI Path: \_SB_.PCI0.GP19.XHC3
        |       | ACPI Power Resources: Yes
        |       | ACPI _S0W return value: 4
        |       | Device Links: supplier:pci:0000:c4:00.5
        |       └─ PCIe Power state: D3cold
        └─ c4:00.5
                | "USB4 Router"
                | ACPI Path: \_SB_.PCI0.GP19.NHI0
                | ACPI Power Resources: Yes
                | ACPI _S0W return value: 4
                | Device Links: consumer:pci:0000:00:03.1 consumer:pci:0000:c4:00.3
                └─ PCIe Power state: D3cold

Currently runtime PM is allowed for all of these devices.  This means that
when all consumers are idle long enough, they will runtime suspend to
enter their deepest allowed sleep state. Once all consumers are in their
deepest allowed sleep state the suppliers will enter the deepest sleep
state as well.

* The PCIe root port for tunneling doesn't support waking from D3hot or
  D3cold so although runtime suspended it stays in D0.
* The XHCI PCIe device supports wakeup from D3cold so it runtime suspends
  to D3cold.
* Both consumers are in their deepest state and the USB4 router supports
  wakeup from D3cold, so it runtime suspends into this state.

At least for AMD's case the hardware designer's expectation is the USB4
router should have also remained in D0 since the PCIe root port for
tunneling remained in D0 and a device link exists between the two devices.
The current Linux behavior is undefined.

Instead of making the assertion that the device can support D3 (and thus
runtime PM) solely from the presence of ACPI power resources, move the check
to later on in the function, which will have validated that the ACPI device
supports wake from D3hot or D3cold.

This fix prevents the USB4 router being put into D3 when the firmware
says that ACPI device representing the PCIe root port for tunneling can't
handle it while still allowing ACPI devices that don't have the
HotplugSupportInD3 _DSD to also enter D3 if they have power resources that
can wake from D3.

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3 [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/portdrv_pci.c?id=v6.0#n126 [2]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thunderbolt/acpi.c?id=v6.0#n29 [3]
Fixes: dff6139015dc6 ("PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3")
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Update github->git.kernel.org
 * Correct arrow direction
 * Clarify some commit message comments from Lukas' feedback.
v3->v4:
 * Pick up tags
 * Add more details to the commit message
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

