Return-Path: <linux-pci+bounces-42326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D3EC950BB
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 16:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52C1E4E0230
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1226F23A98E;
	Sun, 30 Nov 2025 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ef5599li"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011035.outbound.protection.outlook.com [40.107.74.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549F2222A1;
	Sun, 30 Nov 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515471; cv=fail; b=LQtHLbrQQiU1Rs79LVzqlR2V5+IiBlG1uJ4dgqUY67+vBducytAy+1Xqxpw1672aWJbs7Sc+RkR7DY5YtmXRGFUgg2ZihMAxkAFEghJWQKiDDDA6GUetFkPdNLVuOIUWQTtSa6PvnCmHsVjOK9npc5P1gyuP+4Qynkz8TZr2iq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515471; c=relaxed/simple;
	bh=dHIuOxE78dMB4eR1S0qfrBCpZm8MkS4uROVVu8JcQ80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6WAtr6zucFlW3TOw6+wlT5FGjCKdv9cVJoxnTdI6XBNCtRQ/OXQ6C2u0ahTaLgpcNIKRTzBgcedB9Ac/dV0bUXDJgYLrWNnso1AIxihPq1wSpMY7BaTeUZSAA2xTHI0tSglr1dUyC+zD7JT42M4UUdh9+GslZ85XikmqUtIlto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ef5599li; arc=fail smtp.client-ip=40.107.74.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gpvh2vkhdejddty84hKRlJMySxjL5G7pGRdkf+Ld8tNnHCT/KSYrYEHebZn98MQ8RcdosUmEnQTktS4h5oMPaTVHGBlgJebANpXT26Xkkf5zEId5o7GHuc452JCTdoopALhTUEAL0K+w8ffqQ3SKu8217+gsbzFwtkfWgMx+Ww1YncbaPqp2HMNreXcumpqV/0oZlJObWLfvKXTH4EDaEf0HDZOuLsRKXcfKg3hrvTDrajPnL9jV22EYb6MecKZ9IZQEA+578lkMf/5OBdryMepQHLJi5FJxnUazt02oze0tPmDau05ZS95oNepyhqtj+vPMAX5szmrX/F1XTEUrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF3tyzu7RNhEAbAtw8y6zaI4724mGCPZmSXSGTbuoOs=;
 b=hFNLXJeIjRJp2+FpkcAK2/7EHkdsQV+8kYNFVgalXzQNHdxXY+gJCFW2d4NuhmkW8sB0aCJORpD9MFvs9+XD5T85uZffJJdhY0AlJFZ/hmbA4JvvDvizDJcNFeVq4vGL8a/MmRpFlQzYwkENY790pzRDhUDJB79kXmBZBRASj61j71IzQlnBUEUNOlGKNQDieILDjBn4C3sukoJNvcy9lDHyZmxDBXgVoimvOsLb91IIgbZOU8LeYpQZE9JuuAQGTkWytb8jFihHJRM+YLUdylrf/lRZxOyAMjXl6W9nrVAM8dQG2nEk14atsUrFqpdnkfiOZs+8GpBpp0J+m5MULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF3tyzu7RNhEAbAtw8y6zaI4724mGCPZmSXSGTbuoOs=;
 b=Ef5599lieXnvxHCEm5XDK5Vvlp3m4017hQjVxtyQq7wkfEv4xjGsA4g9N7R/FestmvUgVAntnHoea8lroyqU4PktMQwtdbZd0msmz1Vm/1UOd5ldtLPZJgFftsIfZaxNvTgBpkJaKsuThLWtNTAbakxohlOEYypgRFxIpudz8+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB3865.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 15:11:06 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 15:11:06 +0000
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
Subject: [PATCH v3 1/7] NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG share BAR
Date: Mon,  1 Dec 2025 00:10:54 +0900
Message-ID: <20251130151100.2591822-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251130151100.2591822-1-den@valinux.co.jp>
References: <20251130151100.2591822-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0094.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ebb848-93ed-4636-af9c-08de3022af62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PQMIlo4ZvvWpmhQiF3bJN2DkVhKhMPO1i+RjdhOWJo7kxHZv1y0M7r/q4ebC?=
 =?us-ascii?Q?lwjZkGX+U6YXVBu3jto+EIjdH0DSgluv1ZZ16ANaYZaCjsjAJ6ovxrnUJ8cB?=
 =?us-ascii?Q?NYe+rLcoAsE7HRFIIMnRL6EsWI7HFq1uXZrNGTS3BgfX0nxaVQcy7//VEw8w?=
 =?us-ascii?Q?LvLuiIqDXS42Z8BoFEbcJhQaDgG5YEQXNSWCjLl7VfBrLdkrzXLZZQOh0UN1?=
 =?us-ascii?Q?+f827cYz3BUrMxzZizjyJ2k1lKlGGF5nVX/nPVyLLHFBlv7KL3X889B7QJwU?=
 =?us-ascii?Q?dxYPjSOSHZ0u2xFUIH5kGk36YoW2FupsIGqPXhRZNKIDFJUzFVojlwmqFvtf?=
 =?us-ascii?Q?CDwZTuDATrrji/KNC6qOHRwFV2rXPCT+4Jup6rgGfoKAHHcKPFN7abQMYBIT?=
 =?us-ascii?Q?GuCY/tzJuwI+fBQc3PSWagmo4ujaVpVZ5aVq7vw015OnDe/ThriBt1B8X/sS?=
 =?us-ascii?Q?sL3fKLl6cJ8lF4nb0EDWgjquiusOueW560jI+cLHSMca2bogqVOESjNxiYXv?=
 =?us-ascii?Q?YJ+M4hFOaYCSh/iKGajVZrWnPOG1V6eoI21f1uafFWPRJ+N9XHl4IgRCmgOI?=
 =?us-ascii?Q?iUSS/CryjpXGTS1GfQwaLskYBywJ3Px1ihTAvAxiUu7XFvFCXlhZbNT2QA7G?=
 =?us-ascii?Q?XerplN0RYnSZo1B8wKtoJwlTaftTua0pN6WruW/yMqxKu6uy0OmSO1A4PVtQ?=
 =?us-ascii?Q?ArnocQ0QGEexokutz1ZDLfSrynZKoM4XSBuaBTelI4HhG0aFpN8Q+qxKnL1t?=
 =?us-ascii?Q?NQpfbGK3B0qBHwRboLSpleNPeMaHD41PD+T6bTwXiQJBnx8KhWqauDppHn1o?=
 =?us-ascii?Q?wPv6x/49FYhYFvInVK0j6GP0y6znhhAdmljcDi8u+QCv4SZINor71t2p2SzI?=
 =?us-ascii?Q?X2cGjwv4H0leiBPSE8zlQ/teK2DUH43UHGdwNJxayZyjkTnMargoX3ddjnmL?=
 =?us-ascii?Q?7VSuuM+ZqvXbAlSpsx6vRSmPBKqzlXbVlVeLQFXCocCtax8FPvCp5rqI1rUc?=
 =?us-ascii?Q?r7L/RPTF92Xx8P29b5MFfKx8+kehgQXrY3hxmmRg63EN9gn8qsVjiKykrlDq?=
 =?us-ascii?Q?83eSfym2FIIZS07DXkfbcXWsSN+CJHoXu3Lw4vWRAwPOoSGvrQBSAjVgKFNq?=
 =?us-ascii?Q?9XcDfgnDgGC5S6mpyjZN/ODC3sl4JXWZ/KiGDWN/YoVzpqtl/t84qiAo7uWu?=
 =?us-ascii?Q?VtWjIRq9NzaSj9vt66zOAg0AwhAKykzf0sfTjLN9vq43A5bHb4v/r/NwAFTo?=
 =?us-ascii?Q?OBEefcmB0k/d5cXnkk+kp9P6OTa+UevfGTEvCRT4w8Igonz6CXAfYKg+bk/6?=
 =?us-ascii?Q?plXijVQqRDF3+wmJ5Q0eQw1SOZV+Lj0Z27hNZ/vSt2c1RpRwVjd5FKHuI/RP?=
 =?us-ascii?Q?eWgFC6FyDWVwej8YBF0H8QFsy/bzYFXfk1NF/kdZIx8FCuIfZfjWF6dCcmvl?=
 =?us-ascii?Q?MHtI0aUinzd/CCBulD1To+pYmyFKpH6V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+pNclJmZE1Wg7FZ1fE00EBzpI7/1er5LCmHKzg/1wu0NwYjS1eKCU+NAvZpI?=
 =?us-ascii?Q?Lz/AG3rSJzc14Wy2Dg2anhl5ekdrfWlFIbyUd0fek749Dx/ntecQRxE28qAW?=
 =?us-ascii?Q?hjuLX7c93X1LpcgM+0pfTYr7602ESMZphs3UMtgP3dDgF6L49rrJ3XUwxw9G?=
 =?us-ascii?Q?PukQZbbpepsRRim3gPKDWzyOunrqAvHZ6nSAAsJqtsFZwzj9iRw/6JL+fsCD?=
 =?us-ascii?Q?ZFr8PKsuESoW4fZTPnqKurCsnluYyv/hECFNnss54hoeqwKB7oPRPwZd7hEH?=
 =?us-ascii?Q?kN6v0BCwfqQeospo+W1yf2m+zZmSWJfIFKISd2jm9PSlDXLUg7+y5W4IrW7f?=
 =?us-ascii?Q?wP4TgmMR/2SWyKgvDR6UezdarnIW5g6OymJmre3wyGebVQgZq64CZ5KpeSsX?=
 =?us-ascii?Q?A2UYTCfF6NNRHqlROHkDEIjIdxptoDYz2owBxVWVcH1cXzu9gYlGVa1fypew?=
 =?us-ascii?Q?5z/IeP9n2jwWQrFS7sBMhe/T2wANSCopA9Cin41obXKwXdhUMFFmbbNVLRG0?=
 =?us-ascii?Q?793wCJvnpPbUipzrQmTUQGIO8jxk9G0/XPiQZOZRMi0GR5KPJiYYdoZBBe3S?=
 =?us-ascii?Q?j+W01zJUbCdPADBhkliruN+tpb4Y+c5D1D5vxot9hzcHoExI/BfKXPJAUWp7?=
 =?us-ascii?Q?Wf3IDIWhbPTeQJ6kuf27toNs84hhsVjSDUzTrn6fUu/+RswYLuL9JhZBaOZ6?=
 =?us-ascii?Q?+txkzkBW5nI8ymelME7iwT6FyBmweV1LKwtt+JBMr94WXTbKAGtVm7Wfjneh?=
 =?us-ascii?Q?PmyGp4hb57uouc08YazFVHp74uvUFr2XcmmFPDa1dDk6EVjwVzpDBtjKUZ4/?=
 =?us-ascii?Q?FT5M1gXLhzaYFWSk3s2Gc+Zwvo6V0rP9M2HqpuEWWAmxr7bftp66zLNAZzQ6?=
 =?us-ascii?Q?WfK+C2UU7u6DdRW4DTRxwQ4bxe7vQER9W1wbeBXHabWF3NIS/6RWWmh3QERb?=
 =?us-ascii?Q?KdbSRFr9bUu55ElZkcwipAftKAYLyXxkfK6qU4MyDBd+Gt1wSu9k8LdfGnFp?=
 =?us-ascii?Q?5nDvXm8gm2zItHkx02qxVAFYI/D4c0QtHBEuy+pqOcG0mbVEIsFPK+DdReKd?=
 =?us-ascii?Q?aTI3s9yxSLRuqSGu1uJNHrr71OGLx95EfxitX2322800W8GQBxrKYnYADoGr?=
 =?us-ascii?Q?Imi5kBF7/R/xeZeD2Kypt0WDYUkcNUQYXExq/WlHStsbLvdRmWO+X2n5X2cH?=
 =?us-ascii?Q?0W9cJOQFKpeBOPFCqi2BdYCoQ8muZCB9xwp0AgfQW/L8w+hz0pLODotdOa3n?=
 =?us-ascii?Q?4aVRfTy2epAU5Ji7crEhfxuor9YUGJGkBduYJtwD+v6o0dIGxxglwAszTuTF?=
 =?us-ascii?Q?H6OSJlwljCRe+OmfmUi4xDN/o10RawzbFZXW4rP6odutSXzvAjGVb9hltJ+r?=
 =?us-ascii?Q?9R/n1wPC4Op5NwSB0mhFY50hqUPOuSi8qQDx4HbAaX1SLAd0p0fl1tVEtckg?=
 =?us-ascii?Q?IYtA00jSivylKWt9Lv+zaLzsOsWZldoBwU/iGwMnqvd5XHToL5/ycBfNI9ap?=
 =?us-ascii?Q?zsFPMFcopHjYHB7gtJbq39yi9GZVhWoCtfclUMaBPKErKGZN0mna4B78ehxi?=
 =?us-ascii?Q?FINO5PjBpvw8yt1u2Nhzkl9u4CbuPshVCN7WpDxlcuO8ULrxEE3pkIinl0jZ?=
 =?us-ascii?Q?qF0uVTZGgAc9Aq/DYG8yGHA=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ebb848-93ed-4636-af9c-08de3022af62
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 15:11:06.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/Stf4u62eyqAO3GNqnuojQ5P2bqpmx/aR2xlaiml1o+ZoRjQilXohBzeEo5+QUxXt9/qEGTh2I6vck5oewHgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3865

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


