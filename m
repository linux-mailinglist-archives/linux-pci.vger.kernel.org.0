Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5EE704156
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 01:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245527AbjEOXPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 19:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245507AbjEOXPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 19:15:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E377DB4;
        Mon, 15 May 2023 16:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxlOrzWnH43rIDyQ26flDhbJej0zS2RCq+1iuMh7BbTMxtgsM0BiPvv0MOG+da39SirAWYWmctZAtuygjGbzBilj9c39RF9QDRaKEqsuDBb4s0lIn/HIHewnaYFjJjIjcJXIrZSk1i2SL70WZ2SPH0ZSe0FsQinG46J+Q8CHdC2XJmVo3LkLjpy2f2JclRke+Uh3hWY6Xnna9WEKZuYh2umT4mFrOsfVBuQlVdSpPG6lT4unfV+BEnWoGmS2w7NrxfEKjoaxWVJhraI40eypJzZHK3tLGyguy6g+A1HAmOTMJLJ0vPmBdvMu059C4WkhuvfZUL30XuGhGeL1bREuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpUwHQQJF9yaoE25meXcCUuScWcpbKVoYIsl6GNOyDM=;
 b=OKwDiC3ylXEF2RqrsRZdxt3vUf7OvJSQDOMMpcuqwcq/uqaG4JSbn48v1J0mPF36BLsh42dnU4zjXuL1KDKrqCiGqjsct8jQwpngHf2qiVSHk7NXmoaiNzzwZ49C8LyHXfVnvLtBmwuq+AUTvQfy1P7vALD+2B5uO43AE1qWDd81OUi6eQBtVdqbfAjB51gW/6z7S20EoZsH5NzW8F61QQfZPG3O+y0sa4pnPcfc5eR71U4+sMkLwquyxdRLYdIqvlwlDGCgRSxTAqOmbmc6tt3zNRIfYRDkjw60bYwrm5+E0MN//LuLRyv6jS1QavX77xvv42LUFmGsLvMVZNr0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpUwHQQJF9yaoE25meXcCUuScWcpbKVoYIsl6GNOyDM=;
 b=bScFahbNKYsX0jKvY1AMh5RlHt4CeGUrQ+niXyD9Sek+p4mOAsrwBn8jS4cp2ckcClZQW/gqQcvw7t7HQFyuunbX+uPfxtxxMiNRHXAK5SVacjPHAr1xqaGQcwjw+/C334eDkT2U4GyMWLHD8IkzZa75IYzXOAAulEVgUWGN9uM=
Received: from MW2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:907::32) by
 SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 23:15:35 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::6a) by MW2PR16CA0019.outlook.office365.com
 (2603:10b6:907::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 23:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 23:15:34 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 18:15:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "S-k Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>
Subject: [PATCH] PCI: Only put >= 2015 root ports into D3 on Intel
Date:   Mon, 15 May 2023 18:15:15 -0500
Message-ID: <20230515231515.1440-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed3a954-b627-4a0a-c16b-08db559a497b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q47pxEyUG0WvPiSz4FdUcL3otX2wfEuxYO5JAPYlz7Hi34ofyvlelFLGIGHr6luDp5I9HiL046Ld+eGupluehcdkuDu64HXUZzyAqOCOlAmuSzw5jv0QQOKBrctSAKmcQQLAIosrvLM7qGrE4YsJlCb8nqqUzHJV6R0vRBPcaTx+GoaXurg2DGSR8SRvMiez0tL6x8LpKpuJnDzGvsiwg/pd5OU/+o0LAzsiLg2TfhyWXLsSD2MCClNlnlI5gn7kKxnYXKznb2+eht5JtxnURVIAzuYwWR8QAwNkN4fracFq4KNDrvRnBCOqOYuLL9+FgvNLbLpIG/UPHyWoJw/FNqPMRVUyYekMDJaan45gZ8JPE4syeXnoWNGoGNxVGF2f2kYnhuT7fd0A8Ve3B1TZ+Ug5s/6UFP4mxOHfmPLxuKoAYmbyuLwozarzlBwj98z5/VrpkZnWiIA9YAXVeIf88YgNBDlbu5DTlxRNm4+gywOuBFjdCaEqtMj9kxRH3qBAZ2bhCOC4QAO/wNXcj7SCC29M14l0qs1yj8FIlhECza208ZiXWu+DS7Iy09M9sWEYVqdXW7nuwxfweYDcTsN3tkPqHrt4QJbJWUoeKawg4mBKQMz/5r3R+Wt6ongxW4JhGGsi07HVacEu71MLYGrcMB97268UE2VLf3VntsdGTJDUwzOQdBCE2hn16vP5zgKfTRSwKxAFQQHEFaZb7knzAebQNxkuF0N7r3hM6GuHE6MTXgLXjIrcjLfwSOsEY8zd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(47076005)(966005)(16526019)(2616005)(186003)(41300700001)(6666004)(426003)(7696005)(66574015)(336012)(83380400001)(1076003)(26005)(40460700003)(478600001)(54906003)(110136005)(4326008)(82740400003)(70206006)(70586007)(40480700001)(316002)(81166007)(356005)(5660300002)(8936002)(8676002)(44832011)(86362001)(2906002)(36756003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 23:15:34.7822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed3a954-b627-4a0a-c16b-08db559a497b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Using an XHCI device to wakeup the system from s2idle fails when
that XHCI device is connected to a USB-C port for an AMD USB4
router.

Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during
suspend") all root port go into D3 during s2idle.
When the root ports are in D3 over s2idle it's not possible for the
platform firmware to properly identify the wakeup source.

As a user presses a key on a keyboard the APU will exit
hardware sleep, but no wake source will be active so the kernel will
let the APU enter back into a hardware sleep state.

Here is an example of that sequence of events.  The USB keyboard was
pressed after 11.9 seconds, and then a GPIO was triggered after
another 12 seconds.
```
PM: suspend-to-idle
ACPI: EC: ACPI EC GPE status set
ACPI: PM: Rearming ACPI SCI for wakeup
amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
Timekeeping suspended for 11.985 seconds
PM: Triggering wakeup from IRQ 9
ACPI: EC: ACPI EC GPE status set
ACPI: EC: ACPI EC GPE dispatched
ACPI: EC: ACPI EC work flushed
ACPI: EC: ACPI EC work flushed
ACPI: PM: Rearming ACPI SCI for wakeup
amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
PM: Triggering wakeup from IRQ 9
ACPI: EC: ACPI EC GPE status set
ACPI: PM: Rearming ACPI SCI for wakeup
amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
Timekeeping suspended for 12.916 seconds
PM: Triggering wakeup from IRQ 9
PM: Triggering wakeup from IRQ 7
ACPI: EC: ACPI EC GPE status set
ACPI: EC: ACPI EC GPE dispatched
ACPI: EC: ACPI EC work flushed
ACPI: PM: Wakeup after ACPI Notify sync
PM: resume from suspend-to-idle
```

If the root ports are in D0 during s2idle, then the wake source is
properly identified and an IRQ is active for the root port, waking
the system up.

Here is the same sequence with root ports in D0.  The USB keyboard
was pressed after 11 seconds.
```
PM: suspend-to-idle
ACPI: EC: ACPI EC GPE status set
ACPI: PM: Rearming ACPI SCI for wakeup
amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
Timekeeping suspended for 11.138 seconds
PM: Triggering wakeup from IRQ 9
ACPI: PM: ACPI non-EC GPE wakeup
PM: resume from suspend-to-idle
PM: Triggering wakeup from IRQ 40
```

Comparing registers between Linux and Windows 11 this behavior to put root
ports into D3 at suspend is unique to Linux. Windows does not put the
root ports into D3 over Modern Standby.

As this policy change to put root ports into D3 if they're manufactured
after 2015 was originally introduced for Intel systems narrow it down to
only apply there.

Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ede93222bc1..7d1b078b8d40 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3010,12 +3010,17 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (dmi_check_system(bridge_d3_blacklist))
 			return false;
 
+#ifdef CONFIG_X86
 		/*
-		 * It should be safe to put PCIe ports from 2015 or newer
-		 * to D3.
+		 * It should be safe to put PCIe ports from Intel systems
+		 * from 2015 or newer to D3.
+		 * Windows 11 does not do this over Modern Standby and this is
+		 * known to cause problems with s2idle on some AMD systems.
 		 */
-		if (dmi_get_bios_year() >= 2015)
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
+		    dmi_get_bios_year() >= 2015)
 			return true;
+#endif
 		break;
 	}
 
-- 
2.34.1

