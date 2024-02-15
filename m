Return-Path: <linux-pci+bounces-3540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DC8856DE9
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 20:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84538B23F9A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 19:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AA913A247;
	Thu, 15 Feb 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AwVSK7Ir"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97613A266;
	Thu, 15 Feb 2024 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026065; cv=fail; b=gcaLAcVfU/ZKdnqhD76WJUsu5yjxf844BBIl0AAYM/aINg194OxaejYdTFmX18HFuFmZgGEhnmewzl267LUECuDB3FkJSRaUjJskfU7QLQxRPkaGoe8IXjQszMCdp8erPubX2SVh0bbbTcSncx/tXcIHiNVLO4mM9OqL4OpTfRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026065; c=relaxed/simple;
	bh=ErFeK0ZQ7Xij3015VnXJdx02/oazNb+gl/rOzDHh8rg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=begYLNkZ383F/SmOkWoMnYkU2fNuHOOA9dRC0enNn+XifEaXVgPiGTDsCUSrm2gh1uGRZ21y2Z6CWN6DNTAJgZH1ldZ0egcx1MT1TTTtmu5XrbFoawc2LlelhIi6HYAya9HMSopjaVZY4L80+KYT3J9VR+nSEw3Got/JfZ1Ni6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AwVSK7Ir; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuoQNaimh2KUMmIP1c9ubH9QTIM2mH546jRG5qVh8vmFthpJp80pFKXrx+K2pJ9DTdr5QhRDpjkep95pqI6Ye6/sR/vnbIzQOog84IYtXYqZtH+hAgsEVoqG6i5SzQcBTrzRQLWKEbT15Yrcp64g3R4nQHO8eHHlMjZ2YfV2kOyLG7xzDiziXKGDObFuyqftK0lr2qVNuZT3fBd2dKuY6/pM7WjsrrI/wIyjfI+1YYlOTGTGHDOmKDiObPESsI1qFF6Ju6b+uAFP2Vt3zcf1xGgW2Lyw4SLXxy3Cin1atgA+nlf0RlMeB9ER4hwikgG8g0LA5QERVrWeYWvEhDVSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuqahSwnlRv6kCMUVZESVsUa1kQ7D7dRMWauWlFkE9Q=;
 b=kul135O/gAbsUoEkC2RR4qGj3o7ET/A3fad790wKXFqAqa7pSXPURcljA1NcjROFAIjJIYjfWK5XtPaSsvTnf0jWRqX8NsE8X26hyhBO4UAfpaEtud8dGfV24FaFfN74b0YzFi902NoPu+qj4moK5jMvpyEq2BYrZbWn1f9cq7SwG/4BY5ANXDXYVexmrW/WpqFlU66EZ8fG0fun9NrJU4WmfQJsNq1l/0KN1oCXgmsIpqeC1k4e5JGkCN1MMcLoAToNBl4L1A7S68J3w+xzaa7/8vWb2ZqVZOR3WOSvhLbq+S6Xm/6+0qWpdc5/i+kqBd66bvU7XFZ4nlQgvfNj1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuqahSwnlRv6kCMUVZESVsUa1kQ7D7dRMWauWlFkE9Q=;
 b=AwVSK7IrGmLkE+BYuJH0aUAzTVYzLfJubhki5O7Tatli87RY613C5VbbZP5dSEmmDlNjO5XLWQloBScR05J9v2cDBk4znwPdKYgGMv1b3fY9hyCvXcqur1AijJvXzJYX9mpUcv9DvOAKeziQomAsPKt4xgd8wbE5aj4q8Xrf8eQ=
Received: from BN9PR03CA0192.namprd03.prod.outlook.com (2603:10b6:408:f9::17)
 by SA3PR12MB8024.namprd12.prod.outlook.com (2603:10b6:806:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 19:41:02 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::29) by BN9PR03CA0192.outlook.office365.com
 (2603:10b6:408:f9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 19:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 19:41:01 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 13:41:01 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>,
	<benjamin.cheatham@amd.com>
Subject: [RFC PATCH 0/6] Implement initial CXL Timeout & Isolation support
Date: Thu, 15 Feb 2024 13:40:42 -0600
Message-ID: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|SA3PR12MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bc5288-6558-4a85-e6f6-08dc2e5e0ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DDmtU4TcxXs5vp+REklP/D1YvkBeq6nts8B0jelVe69ObU10i9duaTGa+qb4GbW92ZNFkEDpz7PnNAgHT4bmRgwgZpcfFXOSG9X3ZeT9vqChXt/DZYWIag74AxNmVJ8BAr73Mm6Ukds19w91FTjNMRw3+z3mO2TP9cm01nUB9zBmVavQcWyJmLwmztzg2u3mQtBcF/TlAaPU8e8hBVDAlM8apUQBMqC9vjk+UNTCeW8nHVRfSJVJodDMsXi5jznUi3/g0l/vFzfw6Ce05bAxxU/kwmJTjl1cq97WKJx6fSloXgPGpoM5nI/y1atPVLcvEvr5FDWRhDb2/L8FGcRqt6DlGE+HzKt04qJ3wZezDwjTydzUBSNVQc4jAOAdRQY+j9Jt1iZbpC1HlewGxOqHZN6wxeVWjQNrvAzxfeOpt654BUPcJbEgabylLCpgrq10rs86OwDCX89NwRdyvZdix5wj5K59Q1nxCLdXChzG0/xgdJl0sRkWxo4iuR+tKEVW8Cg3ee2P8VxPdHmavvnWy9H++dO+lHKxfu1xKJ0y9K1cZOOD0uM9Tk9HoRcrz0TJ44KIFyXEIz1Inve0G5qOBvmm3FlNLk7rMbnKsFklKMPBfIVW6AV6JJrvw3SdwNuHEb1koP82xB2e60GE+bZVAUXPOkWeAMggBLqs597rmgU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(186009)(82310400011)(36860700004)(1800799012)(64100799003)(451199024)(46966006)(40470700004)(26005)(336012)(41300700001)(426003)(2616005)(1076003)(2906002)(4326008)(478600001)(70206006)(8676002)(8936002)(70586007)(7416002)(5660300002)(54906003)(6666004)(83380400001)(316002)(7696005)(16526019)(356005)(86362001)(82740400003)(36756003)(81166007)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:41:01.9818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bc5288-6558-4a85-e6f6-08dc2e5e0ab2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024

Implement initial support for CXL.mem Timeout & Isolation (CXL 3.0
12.3.2). This series implements support for CXL.mem enabling and
programming CXL.mem transaction timeout, CXL.mem error isolation,
and error isolation interrupts for CXL-enabled PCIe root ports that
implement the CXL Timeout & Isolation capability.

I am operating under the assumption that recovery from error isolation
will be more involved than just resetting the port and turning off
isolation, so that flow is not implemented here. There is also no
support for CXL.cache, but I plan to eventually implement both.

The series also introduces a PCIe port bus driver dependency on the CXL
core. I expect to be able to remove that when when my team submits
patches for a future rework of the PCIe port bus driver.

I have done some testing using QEMU by adding the isolation registers
and a hacked-up QMP command to test the interrupt flow, but I *DID NOT*
implement the actual isolation feature and the subsequent device
behavior. I'd be willing to share these changes (and my config) if
anyone is interested in testing this.

Any thoughts/comments would be greatly appreciated!

Ben Cheatham (6):
  cxl/core: Add CXL Timeout & Isolation capability parsing
  pcie/cxl_timeout: Add CXL Timeout & Isolation service driver
  pcie/cxl_timeout: Add CXL.mem timeout range programming
  pcie/cxl_timeout: Add CXL.mem error isolation support
  pcie/portdrv: Add CXL MSI/-X allocation
  pcie/cxl_timeout: Add CXL.mem Timeout & Isolation interrupt support

 drivers/cxl/core/pci.c         |   5 +
 drivers/cxl/core/port.c        |  80 +++++
 drivers/cxl/core/region.c      |   9 +
 drivers/cxl/core/regs.c        |   7 +
 drivers/cxl/cxl.h              |  37 +++
 drivers/cxl/cxlpci.h           |   9 +
 drivers/pci/pcie/Kconfig       |  10 +
 drivers/pci/pcie/Makefile      |   1 +
 drivers/pci/pcie/cxl_timeout.c | 592 +++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.c     |  36 +-
 drivers/pci/pcie/portdrv.h     |  17 +-
 11 files changed, 799 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/pcie/cxl_timeout.c

-- 
2.34.1


