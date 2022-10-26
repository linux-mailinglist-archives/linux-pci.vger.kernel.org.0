Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC0E60EAF8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 23:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiJZVwb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 17:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiJZVwa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 17:52:30 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A3896203;
        Wed, 26 Oct 2022 14:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnLyDVCV4Uzpx0ZOGK2qvQlvcpXatmvJ4YraPtEAeCr4gr02TaS8FoeScc1sFSPE6JzBg4m7K9qMeOKtVVCjXGMF7UlnKUBFrJPnregMwX8fJjU9pv567aOwkJyb6g6MNUSRHtkKO0e6jm0/joaSG/I/N6V6zVNVaP7sNNEp40fqekghdeTm06oPenEBY5XwoAldt9uWBT36zIFBHZ9c79gx0ws23Xlqz/NUerQtp0BXVFfRmp/zczg+lfYlwcd7oBxnfZB0unm4vR4qy8ryJE+qd1DiW+s2KH2zzIWKBvTh7l4UH2d3Q9FpwEbhSk/EibqEqM5iwHOw6J6d2+ejCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtpT16z2IwOhfNjfbroj61fDbyDNuGPcQZ74E21akNE=;
 b=aww8TsQxKIkFhEsCr5jl7op1slU8tV6FSgRjadJtUJwm9CvMiGFXPKJsPATwlfaMPLG7SBcJmL2hn8gQpyjoyhJqhJCuLVII38FoD4CZBtQZv2DBA2wpCUyb3ofpH8DQURCneA93F6YPvpfLZTZO39u0CBPaTfS28oOFDwcEd87Fe+poJOr1X6ofc6xzwyM68+YjbLOmYCmB6rFRpcXkWGF6g/IuEIZny8//hgEZ0rV85m0mNSf0XovqtQ6u7WBg1hsAvoNH3wfTeI31t0JxqG4ZP+3ZYuN2dxIVr4f1ds5yXCbKMS8Bjp66gNGNcYSoNQgpbOMx4v7afyuNBBmvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtpT16z2IwOhfNjfbroj61fDbyDNuGPcQZ74E21akNE=;
 b=SmBvG6Nx4SunMR/08wojnnP73trx0CB0pqxIE3U3zO+YeCL4M/cDOmwkk+kTmH5qZ4b221Ww3Gw9HkVk2tFe/J8az921vQStAcRMgaJOh5dLzQjyoJ5mGGhWNzubsw/5XfzROjl/8QrrH/c2N1gch1UGgtnDgLXtLVsh7PuR0wA=
Received: from DM6PR18CA0016.namprd18.prod.outlook.com (2603:10b6:5:15b::29)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Wed, 26 Oct 2022 21:52:26 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::a4) by DM6PR18CA0016.outlook.office365.com
 (2603:10b6:5:15b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21 via Frontend
 Transport; Wed, 26 Oct 2022 21:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 21:52:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 16:52:25 -0500
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
Subject: [PATCH v4] PCI/ACPI: PCI/ACPI: Validate devices with power resources support D3
Date:   Wed, 26 Oct 2022 16:52:37 -0500
Message-ID: <20221026215237.18556-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ff3ea2-1662-4c39-757c-08dab79c5f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4NLf5u8Y/Z2OSmTsdtDQAY1W1pwL41EipaRMRkiacbtdmfCql0LcsVaPbhl3dSh/IzqITwKUBuZEkzfjFWOIbe27XL5APqeG0S+K2CpkjzRnE0KjtLWjobAjyTC4+trT5wG7d1EAETQCFmLbjH8gdwZta16K0NyFrD96Wo1D+MhORPWqUBkRgYfmoMfxmc127a5U6SWHmYymTNvq3yxlJ8macrxWehZUC3A7qMIV9Jih2imj+je78XSXXP1ssH+NjVqhPtASzcgLKfcs0CTVIklC3T9PnBqcy1s7lGxEj0yU+8tJY9yFMAc3ojbNectxzPFHp8Tn9X78oRKrRItl8X9h9diCpkmTQCbXvnrKyALo2hqFtpek6VAZR0GPF7E7e41w0aUIbr6iRNvtb2X5HSqVvNcdC4qDnR5CDfRiNM6LPnvjnDOw5zgZVy14Q7PSLMUVsQXgmEVr6dnDpMK5WJEkceVrY8C36gC7Q9euIa2FCzaKTNtPbEtTtrrdMwDPummCTnlOHz+2bvLiZuMeUE+enrjzyZg0gX1pSkECyY5u5kG1i+CG1uEuaWfA+7JKPsW0Hfltf2qyKzBstTJKgMUBbNmQ0J1m/mmPQUmg00jt0biDxEDxRUS0HFw22AjGGwqWq7kCsLDY4AVfAHBNOYrjLFWbypaoy0hvGHxtQJDI1jEDCYPEjWSWsqpcIJdU0V93QIKgE+sIKfj3KZBh2sn9c/YnHi3okJ5ZlinDpqA/2j2sGEzekfoD5ikzwxtLfM/ePnLciwwRMuBUG2TplbjuQ69J/dBPKjVhxkMSu43dymO/H203OfptkErWjAQpPOiOG1K4RQAH4lAoCN5OaYf5U/apwjEQwwAAjLOvcsk51/xTjtwTCTTck58MmNh
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(16526019)(83380400001)(316002)(336012)(8676002)(54906003)(186003)(86362001)(15650500001)(36756003)(110136005)(40460700003)(44832011)(7696005)(426003)(8936002)(70206006)(2906002)(66574015)(5660300002)(40480700001)(70586007)(19627235002)(2616005)(26005)(1076003)(6666004)(47076005)(41300700001)(82740400003)(82310400005)(4326008)(36860700001)(81166007)(356005)(966005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 21:52:26.7061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ff3ea2-1662-4c39-757c-08dab79c5f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,URI_TRY_3LD
        autolearn=no autolearn_force=no version=3.4.6
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
* USB4 router <-> PCIe root port for tunneling
* USB4 router <-> XHCI PCIe device

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
when all consumers are idle long enough, they will enter their deepest allowed
sleep state. Once all consumers are in their deepest allowed sleep state the
suppliers will enter the deepest sleep state as well.

* The PCIe root port for tunneling doesn't support waking from D3hot or
  D3cold so it stays in D0.
* The XHCI PCIe device supports wakeup from D3cold so it goes to D3cold.
* Both consumers are in their deepest state and the USB4 router supports
  wakeup from D3cold, so it goes into this state.

The expectation is the USB4 router should have also remained in D0 since
the PCIe root port for tunneling remained in D0 and a device link exists
between the two devices.

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
Link: https://github.com/torvalds/linux/blob/v6.1-rc1/drivers/pci/pcie/portdrv_pci.c#L126 [2]
Link: https://github.com/torvalds/linux/blob/v6.1-rc1/drivers/thunderbolt/acpi.c#L29 [3]
Fixes: dff6139015dc6 ("PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3")
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
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

