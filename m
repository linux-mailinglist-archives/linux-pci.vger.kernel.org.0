Return-Path: <linux-pci+bounces-39606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 528B1C18D45
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2D2034EF1B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210B9311C3B;
	Wed, 29 Oct 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WRcCjjAy"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010071.outbound.protection.outlook.com [52.101.229.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673662F5467;
	Wed, 29 Oct 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725037; cv=fail; b=UnXpV5zOwNsXPiYA/dae4UkF6J88MkweDXyP1+XU3kmA04bTeQpoNzN2oYuitvAPRHkEAnNj2o5l2RZLO7DcHqFLm5Z6COfXkmnKwGtQti4BdpF8ClSJUkKU5N83BWl5Dp8xsM1lVoGfSvkgAPmxKa/YAjjPzPoEThnkGtEWQeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725037; c=relaxed/simple;
	bh=dHIuOxE78dMB4eR1S0qfrBCpZm8MkS4uROVVu8JcQ80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ojllHtEm++5VBHEUXoAxrnJaNP8FOo8kb1w/x0675D6sKUlEYnhLRNxxn2xIr8gPCXeKgK1HnKjOjqgKgBy+LHCE2kxNB7tCclZhfrdNfpZt/AsMvgs//zEQk2ZxkGG9HO2qrEytNYYa0kMBRQpyATMF1OGi8c8JlSvZ+Sk0HCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WRcCjjAy; arc=fail smtp.client-ip=52.101.229.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7VY0uSWBPW+3RBdh17Gpk329G+E+3jDA98VKXhzyELwH0fIxn/XfzKJtNj7O0kc4jlRNhMTTU6JEQS3acIVpvi07oN4Brl2AP99duWpSxxTvGgnksjkyt/8DW4Pcdq4ckWtck8uFfIaY9OqRAgkx+HbrNIEVLJzPWmR+dW/yLKKpmppyRmzTKNMHlXh1gxQL07xecVM+Lw9OtUcpsxWLO5bQ3UxslLIC/XvpuKkN5vHU+XOkJSXTDW6HFrZokxiPcT1VYrqV6lV3UYJtk/bwUxIR9zv6q7wHOPHl8QgP7AtHj/R5549FyqeYBFQ98LE3HgwMEHRHiMzygntEvUevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF3tyzu7RNhEAbAtw8y6zaI4724mGCPZmSXSGTbuoOs=;
 b=evC7EAjboPpjCOLCsamZ7rpf0GbUZ5A5EoL2OKMPXOuNN3YO400KqGqjfHVNxahjuDYnwQqn2k9a+gjjVWoeIoVc2R6bBd0FbgiipjORktlN+8hkRWIzESnJlZ4WjVxPbjzD+mxftcDv9MqW3jYTaX4C+PnTVx4TsH4F+3ugGyaVLSZEHxMtl9pJdYAwgNmJXh+GCgC65bmjMgbYBUWD67Tn6YI84KmMGdRGmGa6dfN1M3x3y/TFNUqM6CnIIm9r0tH9LbOIcB6TkgakjpeGUtKo/T/I2oTbsLjk6Yi1l4jyssjvc7zbi3G1OJOt1af/07OWjws0iKyvjBtIYRPG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF3tyzu7RNhEAbAtw8y6zaI4724mGCPZmSXSGTbuoOs=;
 b=WRcCjjAyxwHRdiImlQLu4fwbjrwb/agXj6N1t949wCKWZN5AJKLUxBMMCEkBgSdZm06lNt/EBvFBGRocrsXf4T9n0rUortPiUem5vjXZOGqOk7zl3ZU08xPRLX8+nHkkgHXY9qLPonkSjWvwh6L+h0MkyiR9tvh8oyCSEJ0i9gs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OSCP286MB5086.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:349::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Wed, 29 Oct
 2025 08:03:51 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 08:03:51 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	Frank.Li@nxp.com,
	lpieralisi@kernel.org,
	yebin10@huawei.com,
	geert+renesas@glider.be,
	arnd@arndb.de
Subject: [PATCH v2 1/6] NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG share BAR
Date: Wed, 29 Oct 2025 17:03:16 +0900
Message-ID: <20251029080321.807943-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251029080321.807943-1-den@valinux.co.jp>
References: <20251029080321.807943-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::10) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OSCP286MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: c374caba-cf5d-4b38-f250-08de16c1b27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nBU/XqfIKbY33ckNTTjzn8NqKZUPA9IkYdfJyIpv9zoRVeIjmC7B+t+4zBxt?=
 =?us-ascii?Q?GSYa7lTYetJI8W675lqWjYZUwzSMaF9opiuaItS+DDLkAeLgk9Ajo6N94TO+?=
 =?us-ascii?Q?qzLXRRhr+BS7KPL884cgLrwvGdd4ulMKhlcLJl7zjlg1KZBMG+RDqVFjSX2/?=
 =?us-ascii?Q?TQMsTO2ABinW1jhPNQseZJOnr+2JnmqSz4PBWVYpMUCOOf423hS0VHvuLbgw?=
 =?us-ascii?Q?+a6SuIGfMGhZ7Tnp6h7xgk8xFb0MClvFqlrpYENLKnrIrfF5C1mRPc2xoecG?=
 =?us-ascii?Q?PWzy55FoYBKTFyxCNlz47WoXBP1HnBE8JrS+Keq2VRXRIE9QCicm9hfaRmNg?=
 =?us-ascii?Q?0wTYFZm4pTKrP37mJ+JYXhJHzySHGWKCEFeTr6+bujPtU1Fq3slCY91/sHvy?=
 =?us-ascii?Q?DGxaSy8ak6vmsfw0wnkIEVpf7Wq7o80npayIWTRnuWmzX/CoZ8fA7TZsPs9d?=
 =?us-ascii?Q?/P0fR24q3gIgRhqtlVW12WpOc/QO9ciSS3ryJCorCswdZSS1umXIhFfLoslH?=
 =?us-ascii?Q?oGkry1BUOHnwZ0qaT7bjtm8/T9EY2463V3WbTtHbUtFnMG87E6afA0EuHWO8?=
 =?us-ascii?Q?1nEGZnq1yLR9UQxiaowRv22b6pm0B1VpWvyCBmX9uz3kv8XFhXM0KjIGbGLY?=
 =?us-ascii?Q?SeyXqutAUAAo6xfA/qGmqLcpF9bos4MPm7ewwy6xcUVMyFa9ohfczvQotqEn?=
 =?us-ascii?Q?3Vu2yKpiDNK67bG79R1hFqGwhSNze4mx4ggTrO+dgt/onVwD/H7BMqMTMw18?=
 =?us-ascii?Q?I9a9rzcc9jBClvXJRdBZOeKaFXR6LsOUYTMdViX+uCC026U7sTzN0ipgzi3d?=
 =?us-ascii?Q?rGmPCKKRFQHezPdu2pVms05Ku6ksg0FeJz6ayMH781DjAQ78IprhUOZRNE14?=
 =?us-ascii?Q?U8zTIJqy4+x5NKGZy8jEFF7vGaCs7g1i+wkhE54vzsXchjTjP/qnwixTx7Ue?=
 =?us-ascii?Q?KFOmqOojyNu+STC7cW1QD1nhoy/Yhh7n4FqZI/oCZUYZXQ/GoBW2FGFIY4Nk?=
 =?us-ascii?Q?QjUShv1z3LwNZEYTuOlHyopu5yJX4bLY3YpDy1J+VHNYBsnWbd53JK3xxmCA?=
 =?us-ascii?Q?Nx1QbURw81o+ETIWIsP0UsUqRT9HYjc7HLcLcpuwNJBpwZ06K4q0MOsFYjOF?=
 =?us-ascii?Q?S+jP7DyzE+pbGJc2LiBKtqolW6wLVOWUJ0gehRubWc7WR/Bhin5lbRLRtZsQ?=
 =?us-ascii?Q?IbZw2HjpL0fRuzf9RyMOaKaFf9FCTez2oRQe4QSelmuGAFNY6KxdcFwTZ3bl?=
 =?us-ascii?Q?dn+MMixcuevHX5UB/+NkPvxv4VvHCc/LOxcx4NOHriNMBOboE2dQHcsXMa2V?=
 =?us-ascii?Q?DzD5XDyHSkzNkNdq3xLxRbZRhzPfxIN8Pq0JqUT6sgLGpB5Wd5RtXR/k31uT?=
 =?us-ascii?Q?JVnkc076i26e3/MZPfXCOe6HGrLkkBrbKOrPPxfH5qXDshZS8CZbRJRIfjhV?=
 =?us-ascii?Q?EiTlbl2nh7RiNyAARKU7gtD9ypmvT21m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RsKyQY/lKoqwBdYjKw1BhmurphoE6D3YHeIOs+I3zC8dNcM6ssYlAkYRVkMf?=
 =?us-ascii?Q?47go2OBfKbL+L1YF4Jz10qdSMYEQRf40RD/p8pN19E1gPPIPE29HJIyJryHy?=
 =?us-ascii?Q?pzQ9NWyJ/XhmU3WkvvstpX66HSBkK9jxFNPuK5fFVyhH7rrN6F3v3Nn2G2z2?=
 =?us-ascii?Q?vk7LVrh2TcFS7b+p9eAPARzqJRaSH7reO2m9hNrjQFLeXrhwJyhIgYs8RaYX?=
 =?us-ascii?Q?oSp9O422AeRdR/enywv1SzUzjFLwx+r73aMMlTYsfKJaaEaCQIIYk3Bj38Su?=
 =?us-ascii?Q?w+hcQkn/ZEev0wyTkQ4hb5JGT6mcmODo9nw6vGIhvytnfhTRJZ9XXmufNoBz?=
 =?us-ascii?Q?iGRNZwIFCOQjCOWKP8gQgD3f07bYoIM3novih8l0npFORn5VymoDV1SkYexF?=
 =?us-ascii?Q?7Kzt5IwHnwxi1MxV6LaK8AXv3BV6xzJLzTkoA26eViAUxPwl/VirUG25o/cT?=
 =?us-ascii?Q?ap9KnTexAEHrSv58r4s6PqHX8kQRbsxNtbfehd0hqdM/JRNXMENslQCjapQt?=
 =?us-ascii?Q?MwBU9vm9golcSVXjzbcf2LFYdf45nFAoM0vH2dq/mxgpF8sth5FNAqOjY8mJ?=
 =?us-ascii?Q?jV0oxgzkuiEETNPZrFzzPRAnkAE0ZAaDtEpTbynjmdm2AGxd9dF3fbpqW99t?=
 =?us-ascii?Q?FCLJ7BhOlcf8dRwi5Sovv6ev/7xXvuaaFrSGeP0xpGWWwECBl2x+S7C8PVYq?=
 =?us-ascii?Q?FdGSb+3iwOZwJD95yc48GIw4EH9a5V8YnKorf7CVBHd8lKPHjtziFtVWULuy?=
 =?us-ascii?Q?BAXkxh9BexWj1WveWZnlM+AilELN1dIUdvWRkyCIlxbpspxhJj4pjRO3N9nc?=
 =?us-ascii?Q?ozueseREtltnIHFKus1fMfTpfUyfd3UQRDqg8I2niKM1nBHegiH2KlHl2v0n?=
 =?us-ascii?Q?RXWD4UrQadR1/XbWTFufVg2zdWyPKKvASEHRdQy+CAigUijGeiMqqj3lwRl7?=
 =?us-ascii?Q?yhiAXAkVSee8Byoiq16yjKx4BVdgZycf8TdIAz67x/lfseNke4fZ0gIwbVJj?=
 =?us-ascii?Q?PrxmnHg9fZjMs3X56AWy/fphAWe+LnMjUiQBqepu/DFCy+BWYXu/Q/x6iBLo?=
 =?us-ascii?Q?sgi06XJRpecwE5ENz0pkCw2TLdQX17r1XTGUE/NeagszskKNKMrZ9o1iJ1Be?=
 =?us-ascii?Q?l4TpkcTWz7X9CWMB2h0hWWPvT0oGIlp72W4fWgO36cP1jMnLccZ+Bf1/F5UV?=
 =?us-ascii?Q?d8oH9mm86bMMzlOU+48x1VUgiDj967Vbi+vR0jpVFlYq/dbJbU8u1mQVd4Jl?=
 =?us-ascii?Q?eSHAbl1fWpQUslI9PWGDrrf+YgoPYBGA7jjmtYHk+MYnW9pw/lzvt7wrmChq?=
 =?us-ascii?Q?HfU2A8FmrC4RHvs5H5cEJzcT1SfcoQoGNh5Rb7W5/P655E6Dhuk2gfYjQgLo?=
 =?us-ascii?Q?xHZn9J0zSLy2D2WXWD4g0Gcaet0HeBatryn7Tk+xggbn8OYcP1GNQU7qxVbb?=
 =?us-ascii?Q?5E0oiENmCJEfCJvcfHauB84+fRlInV6Me2AmK6R2GsxVrluzL7iI//pSSxQ3?=
 =?us-ascii?Q?0pd1cA0oge0qUWDHnZeNxurcvXNLQr6NjsYwm5KxWcdlLlqKTcgGHy+n3aCm?=
 =?us-ascii?Q?FDvpinnFSchFb8WUZFp0x1guxYaavx53uiTCsr5W+gxuPqjQ0yp447IgbqT7?=
 =?us-ascii?Q?c7iOE8ctY3XwZeJm8MW7bhc=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c374caba-cf5d-4b38-f250-08de16c1b27d
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:03:51.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6YDMXTJyitXHVCDay9q6IeuEvIzV+isinprmdu2JWvg4UvOAwcv1t1k9B0nOhPsK7ltuEP3bE8rddAf9SLy0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5086

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


