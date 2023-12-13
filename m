Return-Path: <linux-pci+bounces-891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C35C811C5B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30172828DC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 18:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA95F59E24;
	Wed, 13 Dec 2023 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P6DZC4DU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082AFB2;
	Wed, 13 Dec 2023 10:27:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qdq7OpX1BBr3Hqs2RTf2NdIj23Un7oNp3SUWB1fwBYb+MoAkb5BjHTVN0FZqA+QI1SQVD7C0OFeG531cU1WQ9TKTgThYIhfrmCMIwSY6KPVUrOruiFfPDp5GiBpzgNoMuNkeY7PX1gZlykziDai63fEO3QMz1C4wM6i77g44aEFMCaJvRTUZ/xlBE9ibbjCSOhgV2XDY53l08midAbBHAWmrBaHbnofvpVIY5FPUE9IVz2s2mBSxjGsXgwBui3qB8A6qmr88pZ5MpxITzmCoOzBnSkncZnUDct7S9yjjA7pb+0lK2GfkFbBUrd9XFShstinxclevhRo26D+z2ZPeVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoLONdN8Ha01dROawzZjPhN1teCuZjEH7krrdTgtoIg=;
 b=W+zcRQvtT82U47AqkKgPcOx8pfda64uibEJFqk8zei/EhUdlI+BtvdPP5Amkl21NP6EhNtaN474rLJpza4tZZMWq5xdfsgciChpnYM9Gb2Gz34gsDeyRJMt4up4xfKv9HWe+sv5Y4HUcV08gzAGi6HhfKM55AAmbz3pvBOPVVcR30yeaY5tGd/2eYCv6U9O5/7uDmvlDTatGaZ4ht8wd3TAK33MvzSInZKCw9fOnWXEFJBuPD9M1o/sWQUDg28XD7MXmufcWAzn/yBMADvv/DcAPIeGTFYniqUTH2adZXYVmo/5AbY6RW3MQ0D1c2O8i3iwXOIKOtx5r7dgiJluOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoLONdN8Ha01dROawzZjPhN1teCuZjEH7krrdTgtoIg=;
 b=P6DZC4DUiA43k1nko4osd/Z57ouq+JLTUxvpd42JkLqJkF59lIEREhuZaIhaiS09/zWPyQXMXtZbi6SblIt615q4sv09hTbn+dKbBtMwAmKjQqthwdJ0m8ICbZE+bWdSIxR2ZTgxBME5OrQjuJrV4tmrZ5M6frw8nPFhxK6kVqQ=
Received: from BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39) by
 SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 18:27:16 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::95) by BYAPR01CA0026.outlook.office365.com
 (2603:10b6:a02:80::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 18:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 18:27:16 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 12:27:14 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
	<rjw@rjwysocki.net>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, <mpearson-lenovo@squebb.ca>
Subject: [PATCH 0/2] Improvements to system power consumption at S5
Date: Wed, 13 Dec 2023 12:26:54 -0600
Message-ID: <20231213182656.6165-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3aa23d-e9ee-47de-18ff-08dbfc09223b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2egSA8sFNJ4oW2wua6vZ1A1oeuNQn6BHn7zNBLI2AelidxWIOBXqZfC+dNZ2h9SBHw5VxWN4VwDli5hZ5NWbYFNDADEXCP3OYsnu8b2YpRZLxgkF4ofp4NKadU4GPlUcahfruqo7g3m5jE6G5Ue0YTFr5UU5DbLcFDmcCOCth/5O6Gf8Mco3PxIoUH347QMSJdDU63t6RN6/ogS20dA/ST0fBwAMveQ+LeFjb/5aY2+pz5h5vZA8SAzznO8h1zlxoh3O6o31xB7+ZuQ7nzSdvtm7G87uGyjIv6CvS3GOLln47DxGlVku8NZf4vLwrcf+azEZCyCu+1BSPim5t4O7TaL7R4xwQnveGgfNXUkPXuX19vuNkTlCvTCTkSxr11naXqSFtKBd1CCGjD4FO1SQBK5DkxCmKJIze3NSERTYJgmxTD/eW3zHZNpABAIs+hCDlMIFuIVPxAP0GB7j+OzBsvkKGgrbpCbe5TpnOSj96iACd0vFr3xonzvCfAUeBwVtZvz1m6POvWRWmpRXJcIPUXWH9Na/96m6/0Mt+XMA7CR9koYK5cecCUYWgwf0SD2ARtmQWgnUU1m1ykQuryXUi0VHjoTUCFyG6jS0gdlKR8WDgYVVsCFfO9IrxEXxWAgKQ7s2vwNxvmHRQo6Y1iSo5buW1ghVtxENH6BPplXqqoGk8/Hk48lSI0G9uzJ+GCBg/WF6yF8QDlQqN/mfa9h+rOwrPWuHiJeINh53oeCnOE7uWkl5tpLRh4GJuSYKFSHrN3D9tfatxUrwzQBjbi4KIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(70586007)(70206006)(110136005)(82740400003)(81166007)(356005)(36756003)(86362001)(47076005)(36860700001)(16526019)(26005)(336012)(426003)(83380400001)(1076003)(7696005)(2616005)(2906002)(54906003)(316002)(478600001)(6666004)(4326008)(5660300002)(8936002)(8676002)(44832011)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 18:27:16.0541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3aa23d-e9ee-47de-18ff-08dbfc09223b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967

OEM systems that ship with Linux preloaded need to go through energy
certifications that match regulatory bodies in the regions that they
will ship.

If any of those certifications don't pass then OEMs might not be able
to ship systems preloaded in applicable regions.

Multiple models of systems are reported to fail in Linux but pass
for Windows on the exact same hardware.

By looking at a breakdown of power consumption across devices the
issue is that some devices aren't turned off when user puts the
system into S5.

This series modifies the PCI driver and PCIe port shutdown
codepaths to ensure that devices aren't needlessly woken up and
that the hierarchy for all ports is put into D3cold.

With this series power consumption at S5 drops on some affected
systems to ranges that should be acceptable to ship preloaded.

Cc: mpearson-lenovo@squebb.ca

Mario Limonciello (2):
  PCI: Avoid runtime resuming devices if system is shutting down
  PCI/portdrv: Place PCIe port hierarchy into D3cold at shutdown

 drivers/pci/pci-driver.c   |  4 +++-
 drivers/pci/pcie/portdrv.c | 11 ++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.34.1


