Return-Path: <linux-pci+bounces-32582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C855BB0ADAC
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 05:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B7B3A8CA5
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 03:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB3B1DDC37;
	Sat, 19 Jul 2025 03:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mpIPAmwR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7D2BCF5;
	Sat, 19 Jul 2025 03:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752894606; cv=fail; b=EWxSWGP2C80jImoqgxCITRi5j+aXQacfBRT883uc5ap/6aROcEzaBC9ia7DYNJXiEqMGnkL9HTQqvtfnmTGr+eNbG88tOStPBvIs6WyojDXm1XCewwTz+LpxZolQVIZtjU8bW8/a/6wBjGgMlUgvy9vurCxELd6Nh0GQqMq+5vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752894606; c=relaxed/simple;
	bh=864mpNiXIlIcdO+/ed5E4CB/vFVDyJBw1XtrDzkEECI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EHNMK/iPh9hi8/Q7NUBqiI6Z8jE9ttr0sBpPNFX1mbDkPgmYyk1wQrOSlNh1fIiNyqT1KBjrJRAFTC9dERBsYnJmtuPEoNCaSlWRLSB0tIvNe74q/WLiXZSvqJmHxaWANDZUguAfnuzFIqV03dJzXXNLEDqc9qToFIq9+g9EXEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mpIPAmwR; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9mvPbXq8f8DHaRhKrplGFOGdw/8DESAlFtTNRM32/Ak9cAtsuCdlxk4tC9UZyuZKnBSbSLIaqaqF9ktl0dKM0M8TJ/VzKg9Zy0NoT3TGlRhpzbN0nh4qFgC0whIUB2SILexm96GWGmc6SeGIzOh2u+q40p0NHD8dC9uIqNkFvnTv5InHu2UJt2vHZgevUWMdljdXtir/fXVff/x+Adz7+heAKp/LkJbfmyiRNOEqms2R07DmbhmAbLt3EYPtamJobFQ7jUkJTAB7VdBNodNz/B07K7KPVKLUygdAolYIHLB5Jeb5A77Tb1FIHFaR+5PH2wJT4Keaa87BB/nMyw38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feW/V5rrt76jlD0sIBjZ3UBXxlvb9M+1eKWBDYTvrjI=;
 b=fyX/6nKD6pWJRKA30ZAwZnI7BW3wjXzkqEmzpfyNYK1Pi30LUi4MsiKgiVbbFKVPEL+I+dhMPE5PNuYMy3XD4paex3P3VW3QQnVZBjiRQ6TbIw6GmY5nLTmneG+kKrk3HE9rGGg29e9ySR/9SNx3NNp8eGcv6Cf7YSKQmSd6Qo5ztU9m3Cjv8vchVTIEXkz0hSTjQxP/T+y5slWTXX/4iL1EtJ0pLzIJ0Hb3LJCvQ4DFCpKJgejVpva6WEAWsExjX/Nj78OM5juI0LJCO9ufBKE0fjSDuCwAXGcMxvdcZ2LpFnyteuqF4EbYNom0w1HluKa8bU+IlfCDjUQE1RGh4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feW/V5rrt76jlD0sIBjZ3UBXxlvb9M+1eKWBDYTvrjI=;
 b=mpIPAmwRm+EWxmZdVnRFavvU42iMXr9OUIdkRN+qSNyOpMrRGn9vWeEEV0yzpqpmvqE+WzKYHU9h53gZw8GAXg52toIRPXNolJGFPVd+i7GZqjf/0JeDGo6N/vWDkFMsQikxqKXZEPlrfgwFtJR2HEvfioI6ZAIRWX9SmP+vNCQ=
Received: from SJ0PR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:334::22)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Sat, 19 Jul
 2025 03:10:00 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::ea) by SJ0PR05CA0107.outlook.office365.com
 (2603:10b6:a03:334::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.15 via Frontend Transport; Sat,
 19 Jul 2025 03:10:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Sat, 19 Jul 2025 03:10:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 22:09:58 -0500
Received: from xhdlc201964.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 22:09:54 -0500
From: Sai Krishna Musham <sai.krishna.musham@amd.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<bharat.kumar.gogada@amd.com>, <thippeswamy.havalige@amd.com>,
	<sai.krishna.musham@amd.com>
Subject: [PATCH v6 0/2] Add support for AMD Versal Gen 2 MDB PCIe RP PERST#
Date: Sat, 19 Jul 2025 08:39:49 +0530
Message-ID: <20250719030951.3616385-1-sai.krishna.musham@amd.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sai.krishna.musham@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 047b24da-5538-446d-c09a-08ddc671bfad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YqIf9JFgaWUSKGBaPcWNjQnybypCDyGGU1GG6WyuU6hf1PdXrjW8jyJy5Wmd?=
 =?us-ascii?Q?rzgr6wt+IuL5vVdz/BQvqEh72AwkpeH3SFLZhPrwUwJ/RNN56n/MEIez3M+g?=
 =?us-ascii?Q?jNonVc0cu5HR6/FLPxoxSvI9l5IlKyrOhSiyIazJOqXnhgvG3XO5mWkZ0yv2?=
 =?us-ascii?Q?wPMdckkXC6hCZJV9t40i8qgqbUQQcgOGvK1j9sc9VYxqlpKPOp1tQbyHryh9?=
 =?us-ascii?Q?KtswHQkAzpFc1jDeTVGjzUSVFxnVA0bDhAcxN751A9/utRe1YJ2R1+LifHqo?=
 =?us-ascii?Q?+V5DKEbq9X0EOrjlSmDjonFsWJ6K2cPn+/U77F698RTiGdNwKso8ohBVrzHC?=
 =?us-ascii?Q?TldkGXAwgABeS4bGF2N4pafUcPqQ+fw5/ICT/KW7npNlZDtJai4OmsOg9TbW?=
 =?us-ascii?Q?0u1RH37BJEKEFTFrbjuXnxJHGaHEPXdas6z5dDQwHNQibNv6p5qmumHtOfte?=
 =?us-ascii?Q?bGcTXsBPDNAKcrlgu1Osfl1pFwjuqqWZ5tAdxD7VsLz0o9Mz9jyrqteLaxxx?=
 =?us-ascii?Q?WHqqZ/Ei2Kg6gFTE5rSQ4ivUYFVDakQzjECMivOCJBoMCPbmyFNII46ZZkQB?=
 =?us-ascii?Q?HaHEpksARTYFXzZEMO7AVfyZZih1VGQlcPkkC+czKVdPmZdsAC8iVjCiLSwD?=
 =?us-ascii?Q?znqlbPiPvdRKnVrfGzCFF6ubnST+JRv598u8AXo1/pb+rzpJggEjhSS3Sl7n?=
 =?us-ascii?Q?7FnG37L/w4Tcdsfx+ctbHWT2fOyf7nn0+vJa/uGhR4u6w2/U5Dw84eacl0wf?=
 =?us-ascii?Q?HDcOya8+9ufv0Rsdn5JncFoaIq5bCvvTo2ZynmgnywTLEf3i4vwrwr02Vnzo?=
 =?us-ascii?Q?kbiO+WLXfvudU8cpyUm2tHF7n4VROTGAUAXQ+Dp7090k/G9cmOM1SmNb07wa?=
 =?us-ascii?Q?osp7uQ5XCgiHhXQAgqiGoMuW+2dm0cdB6ISIXdi5bu73rPoWjOJCH+ZzMdtX?=
 =?us-ascii?Q?p/PdUQNE1YrBVhB4r63V+xSWnFL66AqwRUL1BYa3Sxnj+PR6qtL8g0DinMeb?=
 =?us-ascii?Q?BtIVBtLVBA2xtVC6uHB5YLIqmTX9DvCG8lW/5T13ucWdOGEKIyfcOg7vYi2J?=
 =?us-ascii?Q?tBg0lSBhm8pSveDUnUL4Bohva9FyDg7CD+Fu9xgESaS7L+R3SxvMIzKeusFb?=
 =?us-ascii?Q?PUgbuUyw2wJSnR171ZqAayyCyfcTnICzql0JWZPMTYbN9mU1SJy+EY5itNuc?=
 =?us-ascii?Q?i9nmItjgaaMH024h0PNFgchx+z3YmT9be76Uu8Wn13DVh/r0olNDqIw6l1X6?=
 =?us-ascii?Q?QYydDyVjIQLGnjD/KqQW7+Kas/xJgg21LxlALz//lNmxHdfzpv/FgK05WsVQ?=
 =?us-ascii?Q?9q27gniMhrWSQr16nzHsWnqNAoE+3MsxWHqopMgNixMRlbt0/mgQQU8cYdkL?=
 =?us-ascii?Q?Hi2UsQUzxiI1gfprO0vdi9Grb3PbqVvaqs5bX9oKRqhYOtxa7TCXiLc3QbFG?=
 =?us-ascii?Q?R8o8eR0NUlGmcVJN/AtRhbmEjwVbUTpAYIW/abRmEl5aSnqOob4KPu55UHbQ?=
 =?us-ascii?Q?3+21tbR+4tJqmB40JQEj1rBP8MHVLL2gK8al?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 03:10:00.4526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 047b24da-5538-446d-c09a-08ddc671bfad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273

Add example usage of reset-gpios for PCIe RP PERST#

Add support for PCIe Root Port PERST# signal handling

Sai Krishna Musham (2):
  dt-bindings: PCI: amd-mdb: Add example usage of reset-gpios for PCIe
    RP PERST#
  PCI: amd-mdb: Add support for PCIe RP PERST# signal handling

 .../bindings/pci/amd,versal2-mdb-host.yaml    | 22 +++++++
 drivers/pci/controller/dwc/pcie-amd-mdb.c     | 62 ++++++++++++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.44.1


