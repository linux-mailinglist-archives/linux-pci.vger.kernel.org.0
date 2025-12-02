Return-Path: <linux-pci+bounces-42454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580BBC9A6B1
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 08:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1106B3A4E11
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 07:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0823016EE;
	Tue,  2 Dec 2025 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ND/DQwe8"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010042.outbound.protection.outlook.com [52.101.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4422FF176;
	Tue,  2 Dec 2025 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660238; cv=fail; b=Pzk0Qovkj8Q2obtJjdWr0l3jaF2UQ9KSpBooJWJrDDyIajpzwTv9Llwkjaaz/KiA7zhwCBBS+61UdJ3bijApNJYJvdDUM2b1LLBctoOglS27RX+UO3jDkk6mUSLsjYnNcxhhU6mpaf4mdvOJgy9Md5h6njQvMVpHVBZHDgBjJnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660238; c=relaxed/simple;
	bh=dHIuOxE78dMB4eR1S0qfrBCpZm8MkS4uROVVu8JcQ80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gEf9FwtBsjAjCKDIySWdlX1D+m6i9TPowQFTScEL0nr/bTZLoMsakpTZW4xSt51Zw3UJgw/0Ub8nSAnbcfVcqY6FftDgUIEY/bqJpJXFqqBJMDesPMPXJdakQQD3XzqcstEvDNOZQzCFnvHo/pUEi3TRPr4fjOmq7CVkd603e08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ND/DQwe8; arc=fail smtp.client-ip=52.101.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONClLYVMytnmX5ySeSkaq7GEIpJeqqPhw9vIMiSJVum9aW75ctaOPghGqMcXU2pOQulUEmtvydkh/MMBVkTF0KP4VVFWHmutY2j5c6PEZ4MRTs2/zMU0UlsZS6KpZ4OpRWS/Rj7GdJHl8e9wLCknhP0S2eAHgGZSKaLBVcRc+QYfOB5owWxH1IY/IiRTzMQOZ64jZhjqrod5h93P1jISKhY4p6K4fuxqE+/RHNQHMnyxGHbW03Ve5e/ZjwQwG9zdMAXBvfZzxule3OPXd9ARehZaOqDA5fuo6z2LDi+NSzOoOlAEKIuTItr2UmuyeP+oqJ4B6JBpjIRbNrssGpIl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF3tyzu7RNhEAbAtw8y6zaI4724mGCPZmSXSGTbuoOs=;
 b=D44f3UGk0LWryMDdp6kS5l8ZQkrtKYb9qVhIli0cNP1Is8l/aeJ2pQu8b2FOssP96iJvIsLP8vlqQiqpOpFjSeLqFdkILqUYXXTlo/DRFv9hxira3kqHDCN94XCD8vIO4DNgXrCU1wC7UJ35HUSyldrd2dD/0NPGMvf954CyLG0XhZY3zxMGyftd7Rb7g71BCQRODzrbDIjxdAT7tHDQ1f0T17Ez2ulBBpl/xacb8t4QeiOPZrOlCLUjCm/UWywiJz9tnalAJtRpYViIZK7UmssDixfXeixyy5hFsWPXHiNPIImJmEUNNVMCBoKlDDv5rBOMOZOYi4fAPGO4Ghi8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF3tyzu7RNhEAbAtw8y6zaI4724mGCPZmSXSGTbuoOs=;
 b=ND/DQwe8pMyoi6D83M8VWlGmqK+osOSkjyXZSOkmiPfTV492OofpgDAp/NXv50I2VTC7OD6iUQt6mtdFDCAqcPE35JL8UPTgiuA9wZ7DRnBMro1zV8ORa3bmdsNaiS/Yapk7Y8Oa2iab9PPZcmVT3JEFvDHARUN1r7aqrlfI6ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS7P286MB7356.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:23:51 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:23:51 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org,
	yebin10@huawei.com,
	geert+renesas@glider.be,
	arnd@arndb.de,
	stable@vger.kernel.org
Subject: [PATCH v4 1/7] NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG share BAR
Date: Tue,  2 Dec 2025 16:23:42 +0900
Message-ID: <20251202072348.2752371-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251202072348.2752371-1-den@valinux.co.jp>
References: <20251202072348.2752371-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0134.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::13) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS7P286MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 4191baea-fcbb-4adb-f5e5-08de3173be27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wkGgV75hror3gjU7wl3PFoGmV2B64/zqi0Lw5hRXsXDY7SL1/71YG5qLTrJb?=
 =?us-ascii?Q?JI/7VbIGdMN7mLobupeFKTZZJllgN84bf3CAd0C01RqDJ6BylMmR/AKl66qr?=
 =?us-ascii?Q?tGZjJ6sc5FcG12h+Df047Ag7GV9kPRl7cgCEPvXW/9joQ1v6z4cdJ13knQUS?=
 =?us-ascii?Q?Su1gdXccqsPETAtySsUliJOfqztB4xuQIzEz9Kyz5Jt3cXRmrqXBGy5PDOMF?=
 =?us-ascii?Q?4Dt2GQEdB5cktLsyO0hnqTW0jIC6LrTZ0xLqUW+K9qDOVufE3X6ve1RwnCzM?=
 =?us-ascii?Q?f7zanRNAmKIgSQYFSass1J/daNWXphBgJ/3fMwt/eIyM6tLNFi6rb/v/tXMi?=
 =?us-ascii?Q?gf9+Gv4AeP/o5gQpLQCs8WpbirZEJ0KsdgyyPMhiH/AIfkh+jjhVTBtV2HMt?=
 =?us-ascii?Q?6kHO+m+tGr69Fin4oTnvFFvAgFT/9LYT/qlu94ytplYdEWN/bvXilYggSIK2?=
 =?us-ascii?Q?v6CeGgrasp7J4ry/J69HxNaz/rtgS5zogkM0lV/Fbs07JR5+hkonS2h3QT5y?=
 =?us-ascii?Q?usQuSNXqO69sSPKqdvscLOBL+5NX7LSnChgCyDvx7ZXulnyUV+mMbT23xYMu?=
 =?us-ascii?Q?+p7Depc4JWttnP5flUayjdlfsFikIUQMsgbbbPdiNN+YZOEjoZyH6oC8sM0u?=
 =?us-ascii?Q?/nKw2SSWlNRv91fDL1nPn8MZ8f/szBodZS65Kd6A4QjeOmV1Ij7P9UTqK8Wn?=
 =?us-ascii?Q?9owrBVan5qA/Kaf9+sLPbpDVo5filqVOnqF476izPIkOQ4p2hQMadiW8sSeO?=
 =?us-ascii?Q?YLyIXRcB10lgYJ1AIA4IlkrTk/QFQhaE0TPaPcBIbYuhfC95MH3fma5Pevek?=
 =?us-ascii?Q?5AyTgxm+KPIJzT1UPGrrUlfBsEQc3GEuIYH2ZD2mVOm9lQ7SIFGIRzvhzPy/?=
 =?us-ascii?Q?hb3IH6PxdJwdl3AbwFSsVurQWewPzKOh/HTHl5oHpqQaaiUJaHDCjv+CyTJ5?=
 =?us-ascii?Q?okvskI8m7nkU9KBBn2up/u0/WZxTyPtc7Qytp/OfH8/ioNxoXim9zM0rfw63?=
 =?us-ascii?Q?RECdrNtPAp/SmMCPnm8NGL1wYNUEyCS2JjLWwqh7oN/anWIQprQVOMGzqIL5?=
 =?us-ascii?Q?wCz9nLze0mxEvRBgOPC6/xfxDB4pT77jqulJkA7brWHZwxsXIUo6IO2yUjzp?=
 =?us-ascii?Q?OvMLzw+gZ78kvSGAZf0ZtT2f9accJaLZkw4CnbasxOpeb05o9YL+pnRoVOrE?=
 =?us-ascii?Q?CmcfNjSL7kxIcQsPfYlY/OzSQ1QagDbQZNVkvFMIrUgafoBt56Qlbu8ThUG0?=
 =?us-ascii?Q?NKVQMagzj7o/a/WXU3UyB3N6ssLLAOSLgfLmBK2N3XTu4W5tTcSoZa1XZgo8?=
 =?us-ascii?Q?aZ3R6zYIyi325CJAheVSGBLR6lwdiVhlavHcVHzbXOWxybS7WVOv6uLqPAaz?=
 =?us-ascii?Q?r4dnlGVhriqeET7xmVcJljPzYt7n5gE5l+oeIaML3wTC6UnEZaKDHXj8s1Hs?=
 =?us-ascii?Q?exNOaQuStrl8FmEa2kn4cTOAS+QqcqlA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gbn0EUHa7CrzB018iwxH18/vlJxUjqbtC+J2j4mdge/izdMMi+Ju13BuXTiR?=
 =?us-ascii?Q?iyULz+hb860vcAsOQ5ZZt4rMLmuERhIS57hkA4sN9XD3UWvGmXVZwZlyUkku?=
 =?us-ascii?Q?3gM9b0SP+YfadxJ/kuFe5ZtZG8ZlOy2BJqbT0XnxHFlYCJ+zGMKi7toHE9cR?=
 =?us-ascii?Q?bJArtzqAfjkzlEJhUEXC3bq/OnPGAVh2jXo8iJxxDDlhGPDye6y2BHGQHFY1?=
 =?us-ascii?Q?UnoiTTt3jvwgak3D2SgcCAkQhxzQbWhUVCCSKTHiZTryD2ec7qTTSVOZFyS0?=
 =?us-ascii?Q?TVzp52CCONX20+sz8m0Mptwm73g5/pQwgYPdYJNM2B04KJ9S93Gp96/Sw4Xd?=
 =?us-ascii?Q?PutVPb3auWuG+cngUl50r0hxcKOw8NiWnx3gzHALi+Z4QfFQG/CQkzoCNIpI?=
 =?us-ascii?Q?GjgdJmtYz5JFixxPgsFusWBMNcIpHFUUJcGTJsLFJ0LTy2v9f6zJRJHSy4kM?=
 =?us-ascii?Q?s+dmsLDbFvhC5iyQnBdqyByIvdfJLRz6XdXZNBYdSx6jnFZYLMLjrmnarJfn?=
 =?us-ascii?Q?hzZ6pxa4ic1JbLoF4h5VmZkHQfG9ivc9pZ9pelHl+8+g52Z/IgtGgdDo0jP3?=
 =?us-ascii?Q?vXYA5iVHbhnlrz4TcPI2jIy82pFi93w6hSvEAhTNvYtOn6NP9sit+Z+0sHbb?=
 =?us-ascii?Q?7tt9eaoZULIhbNyrcpQZXnzN0mgjf7KtJ5mIev8mM1zeerixYoP3R2LwEo6W?=
 =?us-ascii?Q?FSfaWnqViXKWmapQsbqKzh4N6je5mdGH/IOzgSqXvjd0QEAOaNnH091bIUA7?=
 =?us-ascii?Q?AGQHusgkZTbbYA49OmqKzSOSiDm4+nejZPRW++Nxxyq94veTFf6BZXKXuMw3?=
 =?us-ascii?Q?tul/Gcd4skx6G8rSbM2jn9NHH3K26mrfsLLeh34PU4MoNfc1aNNsWMfPza3R?=
 =?us-ascii?Q?PxhmTNz85pZU1hP8ClxUeg4caej7JiOsi+Zg25QTAQP21/jncmneyX+8iE/H?=
 =?us-ascii?Q?5WpsOxrFS9qscLyn+ZuqVQTYbjzf1qoVc+1+5vi5YxX6LJBJJZkXXxdnHuHO?=
 =?us-ascii?Q?HDnqZt/EUmEa2KYgr3kNApE0sawm6az6QR4+0LgEP1Xc0PSk8fDYOySUFlfd?=
 =?us-ascii?Q?RDqzOzM3ITYhCVZB4C9UYl2evXg8IJqSw2UpGfJaPYMVVsTQiJ/ngyem/Nwq?=
 =?us-ascii?Q?c/kH0Snq6QIYURAkAfZr808AsBlp+8y3TeQE3m46yVBkKurilYwtmA/yksZo?=
 =?us-ascii?Q?UGkmIBn55P2CROimFbgLp/9qU9tgReqPkThaVRonKsCysAClh/c5U5cAPfbI?=
 =?us-ascii?Q?itZsOzs0uZhwcqMuKlmjam8gaayAW0dcXak5s/8WyVIMHH4vSukN4edXfvN/?=
 =?us-ascii?Q?Mmy/IIMVHC83jaJcZ1kmL59/42ppuk5RdMl9+9iB0Z2PntCUKU+vnNFk0JFp?=
 =?us-ascii?Q?9hrohiI4zuQz3SMbkbkOgFU0YMi/J2UEz4zpo/A4ALwpUNVl+ZUus7wXkpdJ?=
 =?us-ascii?Q?vZFlFSN8YO6Vd9CiS5sunLTZpYrbUqQaWK15EVKciBOPL3i4N/6ksp3H0bIv?=
 =?us-ascii?Q?CwHp79Xm2+7WuR0ZO04bHyakzKKvqSZ5mUSvON7MNI2Pyh6Rk+Tv+0qgQQm+?=
 =?us-ascii?Q?etQsf6DOQ9fax3IKyRvkEIKgYxmjGmxg/e4ALLWDA8Rl9fbBEbg0GpU38BL2?=
 =?us-ascii?Q?97WzwRbiAI/JL7eEXyG4ig0=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4191baea-fcbb-4adb-f5e5-08de3173be27
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:23:51.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzepwoQR/DSy5BTFXAWV84fxdb735rEbMw4kJGRZTEO9y64jQjvvT9d6wMM7OIQWXYnuihuAHn9de5+Rw/sbYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7356

When BAR_PEER_SPAD and BAR_CONFIG share one PCI BAR, the module teardown
path ends up calling pci_iounmap() on the same iomem with some offset,
which is unnecessary and triggers a kernel warning like the following:

  Trying to vunmap() nonexistent vm area (0000000069a5ffe8)
  WARNING: mm/vmalloc.c:3470 at vunmap+0x58/0x68, CPU#5: modprobe/2937
  [...]
  Call trace:
   vunmap+0x58/0x68 (P)
   iounmap+0x34/0x48
   pci_iounmap+0x2c/0x40
   ntb_epf_pci_remove+0x44/0x80 [ntb_hw_epf]
   pci_device_remove+0x48/0xf8
   device_remove+0x50/0x88
   device_release_driver_internal+0x1c8/0x228
   driver_detach+0x50/0xb0
   bus_remove_driver+0x74/0x100
   driver_unregister+0x34/0x68
   pci_unregister_driver+0x34/0xa0
   ntb_epf_pci_driver_exit+0x14/0xfe0 [ntb_hw_epf]
  [...]

Fix it by unmapping only when PEER_SPAD and CONFIG use difference bars.

Cc: <stable@vger.kernel.org>
Fixes: e75d5ae8ab88 ("NTB: epf: Allow more flexibility in the memory BAR map method")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d3ecf25a5162..9935da48a52e 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -646,7 +646,8 @@ static void ntb_epf_deinit_pci(struct ntb_epf_dev *ndev)
 	struct pci_dev *pdev = ndev->ntb.pdev;
 
 	pci_iounmap(pdev, ndev->ctrl_reg);
-	pci_iounmap(pdev, ndev->peer_spad_reg);
+	if (ndev->barno_map[BAR_PEER_SPAD] != ndev->barno_map[BAR_CONFIG])
+		pci_iounmap(pdev, ndev->peer_spad_reg);
 	pci_iounmap(pdev, ndev->db_reg);
 
 	pci_release_regions(pdev);
-- 
2.48.1


