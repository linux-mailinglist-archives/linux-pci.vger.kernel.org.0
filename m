Return-Path: <linux-pci+bounces-393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123DA802B8C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 07:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429B01C20929
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 06:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A967653A4;
	Mon,  4 Dec 2023 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FPjJ0qLN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738B19D;
	Sun,  3 Dec 2023 22:06:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWdBokk/dh6RWhqocliKvii5mh02coQPhP5fucsi8JFCMuRj1XHG3TJBqDJBF1eqtq28+wT8KUajoTO6uu5MMkFsO5rigu4P4KWLUeqVSnxA5R4//IVBh9825LZMOnEwAROhiv1OmC4BKXPtMDNmeJvAiUfsFVT9U72dtxVuMzFhZsWR2gQwyrsuxyjhAviU9wKm2z0RLxgvBMIw7L36pIwbERGcw/BUgJDerFvI0W2MqpIZ5NJAbU+wMcUqExroYOHXNMk81VFsGn5SSuVwZ9mSi+7kWbwFaGagWHyk38gngZo8r6gmFZZqIv+9xg6OkvChiAVM8zOT1fSzGPLXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM+eZbTwbtWffccm5eruXbqs3P1sL7GKy0iWBj8S87o=;
 b=HBw//aRdp5fqqJZ3Rdvfi6XiTQH4a0gP5BZ7JtMt4GadZdnfTYGUlfK1L2matPcotkau2zYewci3d7M8jBqKsXX5ZlPOr7ICk/LSVmA0vUtlRiKudKZudvf2rpWkSBlKQRqlMxL5JLARmoNt6iuv+f6nM71lsMdFUlRK6FHSoODixCCyb7Cgsryo0/nYyEzPDiFvKNo+Fk+Ny6ZdM8YWB3j4v6Kyv81iR08t7AWRKc6nTuZ6qjeb0V4hZ1kTAqv4q9vxu2Ao6WgDbvcZ7wGczKx4guVBSwEXigFC6wrgoO7w74kfQTT54cQz88UR3unvCoaeDFerF2nmxBLicnkYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM+eZbTwbtWffccm5eruXbqs3P1sL7GKy0iWBj8S87o=;
 b=FPjJ0qLNsmcy7wNLzlfm9Wo2OlU4odiTt6XwI3SpcJzL0KsYO5ug1LQWPuzDisJ8eD5p940c4+F/SGn+qfa7fN14qi4CJFlyew0wEiVU4T7h38vT/71qhR3MTMK4YmMzBATf11J0g5vM5QA1wjFiQMgSQW7+a3txJxEOp4vowwU=
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 06:06:54 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::ec) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 06:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 06:06:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 00:06:17 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Hans de Goede
	<hdegoede@redhat.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, "open
 list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, "open list:X86 PLATFORM
 DRIVERS" <platform-driver-x86@vger.kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Lukas
 Wunner" <lukas@wunner.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
	<linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v2 0/4] Add support for drivers to decide bridge D3 policy
Date: Sat, 2 Dec 2023 22:10:42 -0600
Message-ID: <20231203041046.38655-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 971c3b7f-c879-4eae-3973-08dbf48f36f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JqrwvLHfngelAHwJsdmT+nPoxD+/I/t6RCo5qBOkHw0LgW0AYbETeIK7yfQFOj2Fu3PSib4iaveVSkwdjTLhHQEWrEjFQ7yc+0/BDqqUqiYnj/9SLnpTM9zJNIaJA68t8CkvTwsy4veDSE9U/mVd4wn9TXxt0SJiMcyHYejQUisc7fVw4bbJcSECY2BUviWrTpFys+nf/Feo5CcEjhghZE7z2dgDJ9sApDKyAxHpNR2yL92FLkn/I3/UUmCbS8Ukr6dN33GU3i17okgRjAtDV1ler6xvKSa4sowoqUOihkw+fXQyXbRnnNFHQxaUP3Z/yaEpFO6XmB8Gg2DqxEiZtnJFT90HcIii4fb0gousyKW29u4D9VwnRf6ex/vI5yRkC1w9TaVBA0ryL98GY8hcOhs/SOOHEWz1Zv0wtaqYgC04L7eL4Tkw46Z1YRTDZmd4ACqU2MWhsn90eK3seNJcwze+i/+Op960BimToHhVrXw+erTAbMN0SSR0MVtNmyE+q2oKbfEiOTbdybE4IGxOKx2CHiyD7/Ddku3MFxjUEEo7mK3e51KDLg2H64ksO6JniAMwO9O5OxmWnzeCstj9oOLwZfeKqep3H6AWMeb5xea0vDnBiAegmkKtCaETUcNDEqH2TYeC+o2xqhgz5itV3ZjznryJa7QwOtD/uy/QCS1PyvZFmY2X3+KJM5WjE7sm7wfRfl40JLC2wXUio7JtLCTcRP4fu30S1zOzXH1Y02BuRyuxD/hWLtPIZg52YeN2W24/NsHMFwllOb989PUUbQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(5660300002)(40460700003)(44832011)(7416002)(86362001)(4326008)(8676002)(8936002)(2906002)(41300700001)(36756003)(2616005)(40480700001)(1076003)(356005)(81166007)(82740400003)(426003)(83380400001)(26005)(16526019)(336012)(966005)(478600001)(7696005)(6666004)(47076005)(36860700001)(316002)(54906003)(6916009)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 06:06:21.0672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 971c3b7f-c879-4eae-3973-08dbf48f36f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610
X-Spam-Level: *

The policy for whether PCI bridges are allowed to select D3 is dictated
by empirical results that are enumerated into pci_bridge_d3_possible().

In Windows this behaves differently in that Windows internal policy is
not used for devices when a power engine plugin driver provided by the
SOC vendor is installed.  This driver is used to decide the policy in
those cases.

This series implements a system that lets drivers register such a policy
control as well. It isn't activated for any SOCs by default.

This is heavily leveraged from the work in [1]

[1] https://lore.kernel.org/platform-driver-x86/20230906184354.45846-1-mario.limonciello@amd.com/

v1->v2:
 * Pick up tags
 * Rebase on v6.7-rc4

Mario Limonciello (4):
  PCI: Make d3cold_allowed sysfs attribute read only
  PCI: Refresh root ports in pci_bridge_d3_update()
  ACPI: x86: s2idle: Export symbol for fetching constraints for module
    use
  platform/x86/amd: pmc: Add support for using constraints to decide D3
    policy

 Documentation/ABI/testing/sysfs-bus-pci |  4 +-
 drivers/acpi/x86/s2idle.c               |  1 +
 drivers/pci/pci-acpi.c                  |  2 +-
 drivers/pci/pci-sysfs.c                 | 14 +-----
 drivers/pci/pci.c                       | 12 ++++--
 drivers/platform/x86/amd/pmc/pmc.c      | 57 +++++++++++++++++++++++++
 include/linux/pci.h                     |  1 -
 7 files changed, 72 insertions(+), 19 deletions(-)


base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
-- 
2.34.1


