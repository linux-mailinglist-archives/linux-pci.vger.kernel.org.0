Return-Path: <linux-pci+bounces-20855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C18AA2B968
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 04:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2F03A24AF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 03:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B732AF1E;
	Fri,  7 Feb 2025 03:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tF9WAzKY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E2F2030A;
	Fri,  7 Feb 2025 03:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738897483; cv=fail; b=T7rYkKa4qkv1s4hACFR2NMBYzgSlRJB/ertr52On0J3oWqi+I/OtIaVCpCvxXVu/yhkCVFYuAM7iQb4Piep2YXFzIoSAoI/r195zn8QPPHTYLmmKT859ByeItPtvb7NMIDwCHsxNTsxyD/oj4nrSxvkcl3n1jFvccrBHPiUWl3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738897483; c=relaxed/simple;
	bh=v8kx2ozMR1fZN8X8Bh6L6f8sSofQutIOF+rEeaNCY90=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DXcUiPK4fB9OyJcmlmliljS4bReuMG2WCrVm+ALbS9AwvgdAlWkfCcT1SFiK+dshcHpZkiP/YWR7/5m69sJpSdPa0ELCfKAjiDudIvWeeqdWnIdsBPUMkEXYbL118EBuiZSDrBaI8vOE2TZWMiZLd9k5r2GIFaJrSRJvcMVADVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tF9WAzKY; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeT+kCaq7lEbyF0ptXdBLQ/iHFDuO6UZJt8dyiwok+oFTDMQLF6m2ZxMZXYF3TRDskPaDLg0abQeFkvXDv9Cdg0FRvfMr1mwrmx2mkdcmZKv/ZZIJI9IgIo1axijKAdI9BmcePk1YQ/I/AyRZf/FNAUGtgLC64d2kvMUDWmBAVElsGtfHF5mN6YVvReVDoyqjLaPnHeJXovkGTjPIZF1TXXXiP4IbfOQR6ANadSGQKo8/vgn0v2GPx8hN7Nq8i9hRe4r3/l/jsUXSy+QjxhO0lCVD1FYTnOScpAXxG1NnNuv8JhSKvfV/+UkE8BrrAOVz3EWHOk2ppL4rFEuQsPtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DiWakKrrZIIxQG/QZnzqFXfIp8haJWItSfwhpsyneE=;
 b=QOv9yjheqhpD2SpSBF638PfbeBn1eb1MbzWdiKnyjEV5pjEeJjQCkvLIfhciUSi023IDo8En5kZhu3suo+V3IMQroe0Xbw/SXOw2L82HcaR6FDaf1gyQPDkl2Dnw7pBNhjPCgozfN8fqgWtPTLqXwLzuPaNUPa24V0qlyXt6TLeL28UAGqy8KnZjMp3WnDnsPFO5ws2NWQ9U//MLlPvZTokapZap/RpiSA3pE3QRdqqk1fOq+rCXIte+yDSk7wppu6kOebv6iGFNCb2s5xPEsVDblVINKCvbbWbeOFuuTkMSolVOPzi6sNZEt8c4PS+G7fPxdp6fQ+1TePQB6k55pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DiWakKrrZIIxQG/QZnzqFXfIp8haJWItSfwhpsyneE=;
 b=tF9WAzKYHrdA+JnAHa3W4t9dDZ0mpiock5riSYZnBSj5EEcc12C6RvShWUJXyrIPXHgsIqN2LhykyHd6AXwLJq2JNoMMrP82+z36+CyoAtg6ub6O6fDyk48Q080VkyopSJqeJa9R7MIeBq0TeQt0EgQ70NZnNW5CgCYUrOMJ/pi/jIqn8ryQ6E3+tpnHwoYAfNwV5Fl3UmULBIpnTjZUs7yKZq4xx50Ohl3eJG8vlLAeFBr2+QUVygkhsFO3HA3ojTlGUjGuo0UXmqYlKJPux+Qxr6c2DxPm+DZtbz8vxuS9vaBlwVglnARrZNRD0jHZuQDbMdCdPD8w8Q4JFS5Zkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 03:04:38 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%5]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 03:04:38 +0000
From: Tushar Dave <tdave@nvidia.com>
To: jgg@nvidia.com,
	corbet@lwn.net,
	bhelgaas@google.com,
	paulmck@kernel.org,
	akpm@linux-foundation.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	xiongwei.song@windriver.com,
	vidyas@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: vsethi@nvidia.com,
	sdonthineni@nvidia.com,
	Tushar Dave <tdave@nvidia.com>
Subject: [RESEND PATCH v2] PCI: Fix Extend ACS configurability
Date: Thu,  6 Feb 2025 19:03:38 -0800
Message-Id: <20250207030338.456887-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0289.namprd04.prod.outlook.com
 (2603:10b6:303:89::24) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f9aee9-f479-45be-8de1-08dd472428d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QU0MyNIXPXGK+tq4FmjI85CBjpt4YvsVvtHG/AugJH7374ln+ZrrfxPazCbi?=
 =?us-ascii?Q?velVs4B/+z5RZfC1Uijms2fGeTWsuFg5L5o5KXHodk1kX+ldoanMIEvsfx1N?=
 =?us-ascii?Q?N5HpSQyDfSuSHaX5ncohQLgcRWyLiyL9NSfimilakymBqcTtpVUcmN757r/V?=
 =?us-ascii?Q?Xa7scpStX5+W67mXnPEqkbwtaC7Qf6lYrd9Im6Edp8g8anspPEGzS3Y4w6qD?=
 =?us-ascii?Q?lxk/FoYvDEd4HObcjZnti+TDa7pMEweEd1QIRIMw/rIpdMOm9BVLv1r5UfzV?=
 =?us-ascii?Q?xMemMeRA5QIK+eQu7VCbDdcNT9c2OQ0zWYVAxZ3j473oBu2+kJhg98MTJ5Ys?=
 =?us-ascii?Q?tzFEjSeIOD6M0P0IJLjGh3/RPhYXEOZl6JhyxX6/Vx9Q5u0foMLagxwmNFdo?=
 =?us-ascii?Q?KVeCRtF6r2m9rsRgpXuJQRylH1taE8p1ZXwOtEstsOfjBKam24xYma4ERc66?=
 =?us-ascii?Q?pQodUYbWBzAlEr43X+jDEWTNO3i1bYXEF1rKrdgbRJBRuIk+1iEjB4KXArKj?=
 =?us-ascii?Q?VAvMBLSR+PY8g0DV3y3kbgXzGaH+iolTrwIEEBy0tvwyeO1gneIlbdT184Vq?=
 =?us-ascii?Q?sjBBzqKVGbjjZjj5hP/xwReCeLAXh6PPsf5lmcKAQuIkxH1Fc5FA9usmTnEJ?=
 =?us-ascii?Q?weTFU8IVTzKUmBfVZ1N26bu/wGYKN/0Pd3WVdDJQpF6KQuyhY8jlUTcwbZIx?=
 =?us-ascii?Q?0FoZ78JTnYrG2eqweOpUkMyiUeAInumhWYsjqScHMwQSh1WjVUl4fAW89xvK?=
 =?us-ascii?Q?i2R+31TRhT8VkSvFUhUtObiRKTsIsSEe+bUyEu+n40viErZEt0dr4invU3l/?=
 =?us-ascii?Q?axAhNML+05S5wXmR74By7v1aFM+dgoXL+b8uSaOlVpsb6Osg5wRsuLmpCKzG?=
 =?us-ascii?Q?IDKsZSjePvtPHi5Qc33XrcdwNRr11oZBOdCu39JDAuZl5+ea7t3iCGm8JjZK?=
 =?us-ascii?Q?DYcBsGWQhbEF08pzZv0+8uMl8A2Z232i9bSpWqOTCvk9l85MHG0rL3twhOye?=
 =?us-ascii?Q?Kb36w50EP8Trr9fiQxDH5q0+NglVfN27ldOiGtf4bVHRPXNSlShJPWe+q9GC?=
 =?us-ascii?Q?Kv2y5jvD+m3MlTYyxpOB18RBlxG57iFp3TlJ3pQaaq5uMQGP2lOH2FLtSb8d?=
 =?us-ascii?Q?tuWS45ICYyR69ubx/IN7nGMslP8YqPujvvHtUK51fAdAZbHewQVNF30sscOY?=
 =?us-ascii?Q?dEEcqB19myFbDnR9w2HTCOBSp/yiRsYMX9+0GW5Y3DYS/F3m32PDBFcAoMqZ?=
 =?us-ascii?Q?OPNG2L6vBX5FresT/lv9p+TGoatCTR8xfLussTF5Y8kKHgH7Daqvyg/5KSM1?=
 =?us-ascii?Q?TdJnYQkvg7lqpvN9njRMVkhN+lgoL1m07kkJR9itLWv0tP3VtFIyaZAqd6v0?=
 =?us-ascii?Q?UuAKEANfUHQr3quH2WI2AG62GcUtsdhLoMsKHcx5jQKD0PCi4ZVXnk9ec9cy?=
 =?us-ascii?Q?DLKO+yny7XU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uEJ/Qjvoec1XFHS74J3K17vEwqi+d772HjoDm71KbSXFOW5txJcm+1QKeR8V?=
 =?us-ascii?Q?aa6ZPwAggcwLriUxXjPdQft84Xz7U66sLG4XxIe1P6g+HsQuB/1aAJ7HpqsG?=
 =?us-ascii?Q?pon2xIYeQgobes9jKU1JmXBrgJemMKrL3+rMkDhl2BieBKcJ27CivQGz2dEh?=
 =?us-ascii?Q?2SRIUVlLkIzCjQunH3dYcXNFWz7q8c2n/quiffzlq9GqIThhsyaZHlLDzJvB?=
 =?us-ascii?Q?RxraMoHEBF+yY5pzvR6jIf1m27o9d+xz3m1gbKRlOuj8TnQ5qv1Qt3I6aEyn?=
 =?us-ascii?Q?cP84Jrz7ejQRvGwh17VCAkNAMPdRPkD5Bl0wliX/iSINUoiOnEeIwgUIoQqk?=
 =?us-ascii?Q?2xpYyg/M0GlNlFSqa4mz/cx0VMJ5R6oIju5Sm0ZIHTIalgv/sqku9A+kOs3S?=
 =?us-ascii?Q?De4wxRiCcnVc1rmpGUgPZlQMg4YPB5OcmdD0+5ZZvLL0YERbuLJfuamOzy/K?=
 =?us-ascii?Q?D7T+ndsH+d3F+Eu/caz71BYkny0WCmyUU0xU6w2X6bUPcydpH9dK6itugYIP?=
 =?us-ascii?Q?z0VR00K3dAU00hUhpeCoS/YvIQdKy1WLcV5HO865Li5cK9k+RQ/Ww5MAKT9M?=
 =?us-ascii?Q?SDWGIW/sb8I6ebh9mMFKHp/0yO8q5hzD3xO7q9hp0Emt34XfHJQZMEJyLXAk?=
 =?us-ascii?Q?AywXWpR8WvNfnFPHham0wMQ3qrynWBprz7w0y/zhSLb+m56Wi8ZCkYJgw0UY?=
 =?us-ascii?Q?bTQVQUnywL9FBVPK855qeQ9Q4sGdBrh80JZUiXP17N6TVObFepiH3bw2rvuC?=
 =?us-ascii?Q?dDx3ff29SJNqrGiNzrS+eASqLyh1lTWgeoq0e7FHhsgefMg5HTfWSiWq5OCk?=
 =?us-ascii?Q?OdryCQtSv4KoDL4FD9vvvRS9WJBi5hBF9/YMM7DVwyO1JRGKdz1Ze68EbXNe?=
 =?us-ascii?Q?Wkx+zg3hHFP8G0WB6JaG9NaQCxFVkVnp1ydOPrCINghVUrZFyP2I8Xbn6PSE?=
 =?us-ascii?Q?c0R2gK/sBN+tlNDMQz5m7HjKbV9FZuCXnbgA0MYsfh5igUQekgklYgYoRXmy?=
 =?us-ascii?Q?yDc7c+jSnG4We5ijztcV6tWTTgJowVWAFhsktfGnpOxaydhlxfQauKOGslRO?=
 =?us-ascii?Q?WXev+dW7fu7GazGfFJO9WD04qnw7xcl+0S9IomGIbhrFPTyvoQNam6qNoJ44?=
 =?us-ascii?Q?ucwUPdb1UwHR6Z6f175zaIFZfq7m2Pxd2A0dgRrdprU8ASkKSDiGW6CZ64Fa?=
 =?us-ascii?Q?a/u1Qg8I1LuVRZpihEGhQ99NVvQWQyi+oUrMas+2o1SjkSY5KSL26zZQa3V4?=
 =?us-ascii?Q?jvPr6AuFCM8DXLKhv+WHjExCm7jUGlMXiAlDzemnJp1HCfAk9DLGm7VjZuju?=
 =?us-ascii?Q?fsy8fmvrKW0UfUrJURSbSs0tZw4aHVp1Oqi2/69YH3WDaui55Vq+N/jwNbfO?=
 =?us-ascii?Q?UoPYxzaJF+DqdBD6jO6RYoi+KJmkAxhb3pma+bThBY3DCY2G1WCZ6taKOJXX?=
 =?us-ascii?Q?tIYM8mgVOK817BUc40MRjBvVqUJLqjHIYEOl9rDjPOkwT8oKehzsk+25VNVF?=
 =?us-ascii?Q?lAn+J+iJ7p4GDEibp+LGBrYqzLPXOaMdWrjulAf6KOJGXsHhVI+B+zyjapl6?=
 =?us-ascii?Q?zUz8XqmTwH0SehA1mfxfyqhjk3jDyK8ZmZCiav3X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f9aee9-f479-45be-8de1-08dd472428d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 03:04:38.7259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ffp6WweVpcjcUO8HaQ1/yCHGbmKcFoUiooavTenpvcNzeXGRZrnomuPV7A7F1xeftyRUdxoPJLpJVYG0QNsywQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436

Commit 47c8846a49ba ("PCI: Extend ACS configurability") introduced
bugs that fail to configure ACS ctrl to the value specified by the
kernel parameter. Essentially there are two bugs.

First, when ACS is configured for multiple PCI devices using
'config_acs' kernel parameter, it results into error "PCI: Can't parse
ACS command line parameter". This is due to the bug in code that doesn't
preserve the ACS mask instead overwrites the mask with value 0.

For example, using 'config_acs' to configure ACS ctrl for multiple BDFs
fails:

	Kernel command line: pci=config_acs=1111011@0020:02:00.0;101xxxx@0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p"
	PCI: Can't parse ACS command line parameter
	pci 0020:02:00.0: ACS mask  = 0x007f
	pci 0020:02:00.0: ACS flags = 0x007b
	pci 0020:02:00.0: Configured ACS to 0x007b

After this fix:

	Kernel command line: pci=config_acs=1111011@0020:02:00.0;101xxxx@0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p"
	pci 0020:02:00.0: ACS mask  = 0x007f
	pci 0020:02:00.0: ACS flags = 0x007b
	pci 0020:02:00.0: ACS control = 0x005f
	pci 0020:02:00.0: ACS fw_ctrl = 0x0053
	pci 0020:02:00.0: Configured ACS to 0x007b
	pci 0039:00:00.0: ACS mask  = 0x0070
	pci 0039:00:00.0: ACS flags = 0x0050
	pci 0039:00:00.0: ACS control = 0x001d
	pci 0039:00:00.0: ACS fw_ctrl = 0x0000
	pci 0039:00:00.0: Configured ACS to 0x0050

Second bug is in the bit manipulation logic where we copy the bit from
the firmware settings when mask bit 0.

For example, 'disable_acs_redir' fails to clear all three ACS P2P redir
bits due to the wrong bit fiddling:

	Kernel command line: pci=disable_acs_redir=0020:02:00.0;0030:02:00.0;0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p"
	pci 0020:02:00.0: ACS mask  = 0x002c
	pci 0020:02:00.0: ACS flags = 0xffd3
	pci 0020:02:00.0: Configured ACS to 0xfffb
	pci 0030:02:00.0: ACS mask  = 0x002c
	pci 0030:02:00.0: ACS flags = 0xffd3
	pci 0030:02:00.0: Configured ACS to 0xffdf
	pci 0039:00:00.0: ACS mask  = 0x002c
	pci 0039:00:00.0: ACS flags = 0xffd3
	pci 0039:00:00.0: Configured ACS to 0xffd3

After this fix:

	Kernel command line: pci=disable_acs_redir=0020:02:00.0;0030:02:00.0;0039:00:00.0 "dyndbg=file drivers/pci/pci.c +p"
	pci 0020:02:00.0: ACS mask  = 0x002c
	pci 0020:02:00.0: ACS flags = 0xffd3
	pci 0020:02:00.0: ACS control = 0x007f
	pci 0020:02:00.0: ACS fw_ctrl = 0x007b
	pci 0020:02:00.0: Configured ACS to 0x0053
	pci 0030:02:00.0: ACS mask  = 0x002c
	pci 0030:02:00.0: ACS flags = 0xffd3
	pci 0030:02:00.0: ACS control = 0x005f
	pci 0030:02:00.0: ACS fw_ctrl = 0x005f
	pci 0030:02:00.0: Configured ACS to 0x0053
	pci 0039:00:00.0: ACS mask  = 0x002c
	pci 0039:00:00.0: ACS flags = 0xffd3
	pci 0039:00:00.0: ACS control = 0x001d
	pci 0039:00:00.0: ACS fw_ctrl = 0x0000
	pci 0039:00:00.0: Configured ACS to 0x0000

Fixes: 47c8846a49ba ("PCI: Extend ACS configurability")
Signed-off-by: Tushar Dave <tdave@nvidia.com>
---

changes in v2:
 - Addressed review comments by Jason and Bjorn.
 - Removed Documentation changes (already taken care by other patch).
 - Amended commit description.

 drivers/pci/pci.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..c1ab5d50112d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -954,8 +954,10 @@ struct pci_acs {
 };
 
 static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
-			     const char *p, u16 mask, u16 flags)
+			     const char *p, const u16 acs_mask, const u16 acs_flags)
 {
+	u16 flags = acs_flags;
+	u16 mask = acs_mask;
 	char *delimit;
 	int ret = 0;
 
@@ -963,7 +965,7 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 		return;
 
 	while (*p) {
-		if (!mask) {
+		if (!acs_mask) {
 			/* Check for ACS flags */
 			delimit = strstr(p, "@");
 			if (delimit) {
@@ -971,6 +973,8 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 				u32 shift = 0;
 
 				end = delimit - p - 1;
+				mask = 0;
+				flags = 0;
 
 				while (end > -1) {
 					if (*(p + end) == '0') {
@@ -1027,10 +1031,13 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 
 	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
 	pci_dbg(dev, "ACS flags = %#06x\n", flags);
+	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
+	pci_dbg(dev, "ACS fw_ctrl = %#06x\n", caps->fw_ctrl);
 
-	/* If mask is 0 then we copy the bit from the firmware setting. */
-	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
-	caps->ctrl |= flags;
+	/* For mask bits that are 0 copy them from the firmware setting
+	 * and apply flags for all the mask bits that are 1.
+	 */
+	caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);
 
 	pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
 }
-- 
2.34.1


