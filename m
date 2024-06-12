Return-Path: <linux-pci+bounces-8647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93203904E5E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 10:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28B51C215AD
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19715161937;
	Wed, 12 Jun 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w+9ax0UJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7316D33A;
	Wed, 12 Jun 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718181909; cv=fail; b=F3lO3LhI5vBYr3b3JiDzX/WnNNdXellDv6Lnbh4xSj7BpLf57ZgvGduxy5P5O+Tkyyt5+ivyJd/0SBprn6LYbNQWp9qyazkWmmJpX6nKofeaqsaUSk7Xlu4dQc0q0ufqrR0zlOb1hiYOet6BpcQI+YIJrwaWl6QHSAZVHxxT3Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718181909; c=relaxed/simple;
	bh=rZAFnYK9X2DxnoRkZrs2BQlxrNsiFfXr/Yc2/QP4GSQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i51u84LRt66ntsNCr8tC4FQzXos0T6hV0RO0caa+yaka9dvAQxTxxlQQd4a4eNYeilUlRldVS1vT+u+qkREKieyyj4lK7VywXa8TuJNsvokYpJmVycwPEyJj8mVZ9ZG0Q44Kvt9bL5nzinqHjgSirVovTbZrortuCAgg1r0KOkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w+9ax0UJ; arc=fail smtp.client-ip=40.107.96.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGhFgdqHxUNb7PIBrV2aPUJLXcirddLj8fLA3go2pMs9GRa+DhUtL5fSAf+YW0PyOE2toHqnthe2xVoMyFkEog/w3r4nJ2ll14iauFUxTlISNs3azh/J4nWY8AgAXVmebhT2TXF7pfd3MsYfKN34EFpD8+uXtyp5KF4IQ0w6PJThjH+qi1ZWZegVSA9v/hxGZz2VSpt7dZhExGUPHnHmYqR4IeWg1rSbt7pnBqyO3dcJNJnn7hhbeoANBOUarda7/Oem+j19zs7pppEetgft/oMszhglbLbea1x28j4DNSlLUtAZ64mcv6AGSDyZap2NHVeuxFSJS43IA6f7qa+M+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ENBEAZ2OUGMx3S8FXtTlvcmee4PDXZTmoMOSE5z8Z8=;
 b=PPcR823ztfvtBhAV2XgGRZ8PBgCXAy99tGpGOiQFAE9Huu09jK5PDwT11+TpxO83jhjE48n+2xX5nhk6unhY27l57tO5ds/3fhYuO6govaqXcCtoan0rGjP+AX/+UUZXfVxN08A+LuX91i63JdU6Kh6le+Dx2sfZWDrcfG4bgcvuvBmfMotiRSusuugHqWylzTwFIb/jzJRU9DQuRm3cVoVJceR7tPdB/7/rBO2qhzEbpuQYgSRs5o4RESS07NQNAbtt/vysqR3dC5smRgoBiw5KcAUME1gsdOVhsN7Lc5CdIRi+Kt7YJAVmwYm4gWfw6XfdbnBQ6hTwL+ZkmD1BrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ENBEAZ2OUGMx3S8FXtTlvcmee4PDXZTmoMOSE5z8Z8=;
 b=w+9ax0UJQNStqlYq8GsnqinIrZdbB0zLFpbH5etcATiD2PiUqeVJPZZp7cgUJ8ivL5hrYsOnThNBSNrjgimD9ENJW9YcGgWHSeNJqXWvze2JACfK/kakayZHJUXbsNiPUMHCYQYa9tQwFRa0SPOEb66FjCVj99S2gHTaOKD7vRk=
Received: from DS7PR03CA0075.namprd03.prod.outlook.com (2603:10b6:5:3bb::20)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 08:45:03 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::8a) by DS7PR03CA0075.outlook.office365.com
 (2603:10b6:5:3bb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.28 via Frontend
 Transport; Wed, 12 Jun 2024 08:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 08:45:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 03:45:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 03:45:01 -0500
Received: from sriov-ubuntu2204.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 12 Jun 2024 03:44:59 -0500
From: Lianjie Shi <Lianjie.Shi@amd.com>
To: <christian.koenig@amd.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>, <HaiJun.Chang@amd.com>, <Jerry.Jiang@amd.com>,
	<Andy.Zhang@amd.com>, <emily.deng@amd.com>, Lianjie Shi <Lianjie.Shi@amd.com>
Subject: [PATCH 0/1][v2] PCI: VF resizable BAR
Date: Wed, 12 Jun 2024 16:42:43 +0800
Message-ID: <20240612084244.2023254-1-Lianjie.Shi@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Lianjie.Shi@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 46742bc3-5b9b-4b06-9c7b-08dc8abbf3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|1800799016|376006|36860700005|82310400018;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FqeIC2xutJ8BRM5Pe/yMjJn1pghCbg3MqzqSDwPq4WzLUeQIrsGG4+usHBEz?=
 =?us-ascii?Q?vtsdRilfUM2CVMGTOgnsegikq4yRzs2VyJVAdgzDI7C2XV6FtFlHWhV13sKE?=
 =?us-ascii?Q?vjuPi16WiPDB4D42plUc2G4lB4oflIiyHajA3LxPDGbMvqgoyp7dojfrvS04?=
 =?us-ascii?Q?DDEuSzxRwREs6nDZhyNZmGzasWPu9hSe8CmfE3Dovs2qaaA6TjirpwBhP5Ya?=
 =?us-ascii?Q?pfAUnhYbf09rXyWvaLoU6vCOzWoKw6L5LC4GNJ/HXGSVhaEOQo5TYulEd/k1?=
 =?us-ascii?Q?pvmWU+DbGwh0pUTZy92JKxVzVQgwmwXHReo0nLoAsaue8DBQ5HN/TBqbrsg0?=
 =?us-ascii?Q?4nzAZvROosrfdHnsT9s21mxaidY9sae8eNXKWgIqy4m6AliCJa2Qz7LS/x4q?=
 =?us-ascii?Q?1WrFSUJfE7S8/PRsx24781YToGcVFDeqvEmLGureRLOjFuoodHv5p9vDVmMr?=
 =?us-ascii?Q?T1LtMKOio4LHWN5IVjLf6AIF0PJca3YZqGpBqNgd7iJZEvjnmw1uCsSCylSD?=
 =?us-ascii?Q?6DU1olN3JZxBsCHoyeoGLan+b83XYlqqiyBGpAK+FqJOkDEGW89MgRmS9WW/?=
 =?us-ascii?Q?+/UUtbO+irk0yIjTuyrJvPQy6vTXh2KfjddF/lE4RMZJe9eXiWWYtA0yxPf9?=
 =?us-ascii?Q?Vpapiq4pDU6fUTLU5EmL6vpwr0SKZ97NUMA94y662RxgE732IdiXFIrQmiH4?=
 =?us-ascii?Q?dMSvJsS7rV4COt0wT9AX8meYW6BXViIYbMEcg0ocbGLOdNU/yAy12/2v6LA2?=
 =?us-ascii?Q?RTMij8eoxQve5yR+LxtP9WWdUqYewTzt2LC4xk72LTqndPmquBSUyOvdZ6tC?=
 =?us-ascii?Q?cIvUdxoaVNuyEu03CXVmWKFn6A3o//kSy3Zaz+zdGTl1iC1b4jSh0K8nb/Hs?=
 =?us-ascii?Q?tFZAUOwWv0MQR8n8YQ/B19242lQ6O02wQvrE0IevGRlxH3zid3yNe6uM7GZS?=
 =?us-ascii?Q?JHfNPuTmwfHRXfHUPhCM/JMdF9UXdqdWkadYxuUHvguukKkgxlH0TlIy3Y40?=
 =?us-ascii?Q?KNZ8xVnhfMLOnl2DZ1ag6Y9xzXboxwkKN3KaqWdjjz/tYjHNTKYdjMKRmn4l?=
 =?us-ascii?Q?cJb0LfzKhLC8Wn7gwBZCC+TlgKw8w9Xbfj3SHSrWkPbe8s0V3QwBxlI8fI1s?=
 =?us-ascii?Q?h7WU+Ur7jbTTgqJhqiqcZ7EFgOZ4Zee/8JXaqL74OHt8k4ox3hGWoDWs702U?=
 =?us-ascii?Q?+mti2BjUfnXdocc/R/9ZkbbEGGFPQPcso0cZICyAw3Ldp+To5MA2dNLINFag?=
 =?us-ascii?Q?yKVvPdewYgYsBC8DuwZlJzCmXyDGLrAskQlRTX4XdMTiOwky877I5oXdfsle?=
 =?us-ascii?Q?rvToUbZpUpcf1epFS3I4AMj0RstL7bPo30vG/OthYJr2gP+5CGV80dHpD89d?=
 =?us-ascii?Q?fJVwwaZp9IJ71ljlVufj/4CmOrZrUSEWZHr4f9osQDMYGMrk6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(1800799016)(376006)(36860700005)(82310400018);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 08:45:02.9117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46742bc3-5b9b-4b06-9c7b-08dc8abbf3ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227

Similar to regular BAR, drivers can use pci_resize_resource() to resize
an IOV BAR to the desired size provided that is supported by the
hardware, which can be queried using pci_rebar_get_possible_sizes().

This feature is based on the fact that (default VF BAR size) * (supported
VF number) covers all possible resource/address ranges (rounded up to the
power of 2 size). For example, the total size of the resource behind the
BAR is 256GB, the supported maximum VF number is 4, the default VF BAR
size should then be set to 64GB. When the enabled vf_num changes, the VF
BAR size will adjust accordingly as
- For 1 VF, VF BAR size is 256GB
- For 2 VFs, VF BAR size is 128GB
- For 4 VFs, VF BAR size is 64GB

This feature is necessary to accommodate the limited address per PCI port.

Lianjie Shi (1):
  PCI: Support VF resizable BAR

 drivers/pci/pci.c             | 47 ++++++++++++++++++++++++++++++++++-
 drivers/pci/setup-res.c       | 45 +++++++++++++++++++++++++++------
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 85 insertions(+), 8 deletions(-)


base-commit: cf87f46fd34d6c19283d9625a7822f20d90b64a4
-- 
2.34.1


