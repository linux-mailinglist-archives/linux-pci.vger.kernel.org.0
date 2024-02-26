Return-Path: <linux-pci+bounces-3990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D168669CD
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 07:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027A21C20964
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 06:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD94B1B948;
	Mon, 26 Feb 2024 06:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iHt76sEb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1781863B1
	for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 06:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927309; cv=fail; b=Bt8GYyBw9LBdxcxUnnvbKTVbbeuJZjZljg7aEwhq8j1gncMJpIM3YiGcEgLExIGwXtjHJONpCupETJVnqEyKxDnf0ifFV12Xih0x6hYz07uR2x4X49CzP3vxZZmeb/FHSVi9jX2K7uNL0Wjr1mH67XqkEe9qkehF3YX4OrChdf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927309; c=relaxed/simple;
	bh=2E88N5VDJdqNWC1D41g7cbldoVLGWlHeMR2MOpXmtm4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QHQHGpTqD28TPH5AjMi2nbeO883PitWiRngEti+PMwkr60lRCx01VjA/Ap7PpfnmQ1Z54f0ChTXqOrVlW0W0S2oOnJWjEPERf89Qa6lIoYMYJCRnWspIoY2WQGnlei5hw5NcE3vY/FH0SlHGssOmqAwCOblup3T9lRTGNYYnNxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iHt76sEb; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpdYsbfX1Gn7CnNzeJxzyZ09onq/LeMooJ/6FcS2dWZOrO8ABypr+x/Zck8vguMSCN+onyyledL24UYt7lo4ZPhrZN7Is8jL1VKoNnHKr7GslaVMUM8zPBOTpG9xTIVngXeUR0cTjTmE7rVucLYRWaHBW3PuIykhluMeUNQJzdxtATOtvGH+e/sGOyfjcLzkATW2T2rD2s0pof0T34NWvPS9srchYQeP75SEFkLkbRzUC/X9TC0RYLDSHR3UaEptxdWPboTrnEdj8vgD1f7M7ioUJ/y8jnMFQTZ5v2GWBDr0GGLumdUBeuZtZz1npiSQvFqCklxPBESGmDb6DYz+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avrEJfNroF2XwMe5cOdoA69Vcmu6Vh8iBEvXd1/h/zQ=;
 b=nsXuQrBjMzju+mzE6ylGsy38/kEmIDgfD7NcPMogfwIWNSv7lmBHeWotQ5AfRVvNdVXbm4a48ymyZHfC+CUscgESBzw8pboDAKkgYOTxuaexSTU7QiYE9QJYRuFQwYlk99heuSDjv04qf611llkEZd++9EFklqOAftpKUX3DnShijyTPS/VJH4hApdXN3dTtRR5/dtlz1KK9uQCKSV44P/o20e+AoB1OuCYlk/L8rAkwpsWyX6oEZnF0ImsTpvM8TAAtBodkuBRLE4pvgq+NkAxEHt0RZtoPF7cjEpXMh2FYkEv8TFYPKgck8cFNM0+c2Vsjs0VPx+fVc83eQa/vrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avrEJfNroF2XwMe5cOdoA69Vcmu6Vh8iBEvXd1/h/zQ=;
 b=iHt76sEbDm1qJTv7TgRmYjYTQSSnyfXe2T+ZSXSoe6JzfbDSRixSIEc7r9k76n0RXLOr9/Y5Rm1dcHIyluCScnAeMdJSZV1TU39rdbF6+nYD0EFn3u45AQzz/JLNz24k5SVILU3ZQMrOeyPgKyLSocyHBNuqf+LwS/wqujHquD8=
Received: from CY8P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:46::20)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 06:01:45 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:46:cafe::2e) by CY8P220CA0016.outlook.office365.com
 (2603:10b6:930:46::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 06:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 06:01:45 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 00:01:43 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH pciutils v2 0/2] lspci: Adding TDISP, IDE
Date: Mon, 26 Feb 2024 17:01:33 +1100
Message-ID: <20240226060135.3252162-1-aik@amd.com>
X-Mailer: git-send-email 2.41.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 9150cf74-f969-44ff-1e9f-08dc369069ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AyAbcUb/mcdGD+sstnVFyBtAaL41YYAPqUcvm7BumdbGuFOBg78WmJ51xGK4eAJCQv3uoAwmrfCUnR3xyqwawd2KCIxPqxJO15lZyz+LljPyGB9+0Y+zwTQIY1PsfDzSmxKDpPUx9vxK+UgQ+Nw5YF8iiEmlInN7Vv0fxBnVEc7FczMEutL+YIq7Y4xmcDCaKtXc+40bfyU+oPpsg4kHGohxY6l2zcuILG6T9B3/gNWOXTETiXT5t8JPBy1hhHxB66DKWgkdAlnk2KMVHbgzKixo+2smLBFYRMBJrcmCAoHxQLjU4+RKkVVd5UswATNbbAb3OjqxI2DnkUB2NSBgJoAoN3z+I46yBGi09G+A1Ej9HEnUUz0etXu89W0SJtyCbArtJmYGVufg1M1F2S8LKya3iZKQw1uq66/ZHbaUI/XTBvAKjBXWeD/4h6LRCbuW6TfsbW05GQmw63Er7Aj5OKELbywXIpu3SnRjsWwRTxw+oRK+GqeD6/vmGn7OOWHMY+7IvIbvMT88RobDU8ZdozpUquCfYVlQJqG2sPajT3hCnj0H176DMmDD3r1BQu7amHNTZ9+CLF5AWJfiDiT9puJuwvnrCIdqPF3j17oEtSMCct8q5RyoTFN3P0kBtq1iMZ6cZb/hzT/mseWLkZ1SMyFTStw6B/A9LPtvzqjQhAwrsdsrFPMeJTpxGsFgWI8Qd5toaNCkDbg4relLsdYvWeLToDr/CDOvYDRkSkJJ4iKRUCDaRlKHNT7PX/lAMpZA
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 06:01:45.6980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9150cf74-f969-44ff-1e9f-08dc369069ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

Here is a couple of patches for TDISP/IDE capable PCIe devices.
IDE enables PCIe link encryption and TDISP enables secure pass-through
of PCI devices into confidentional virtual machines running under
Linux KVM on supported hardware.

This is based on sha1
2ef5809 Martin Mares "maint/README: Mention maint/push-to-public".

Please comment. Thanks.



Alexey Kardashevskiy (2):
  ls-ecaps: Add decode support for IDE Extended Capability
  lspci: Add TEE-IO extended capability bit

 lib/header.h  |  63 ++++
 ls-caps.c     |   1 +
 ls-ecaps.c    | 192 +++++++++++
 setpci.c      |   1 +
 tests/cap-ide | 346 ++++++++++++++++++++
 5 files changed, 603 insertions(+)
 create mode 100644 tests/cap-ide

-- 
2.41.0


