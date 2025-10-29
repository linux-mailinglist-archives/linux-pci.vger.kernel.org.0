Return-Path: <linux-pci+bounces-39610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECBFC18DEA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A729B4042E3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A393126C0;
	Wed, 29 Oct 2025 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="iFfwMa+g"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010071.outbound.protection.outlook.com [52.101.229.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ECD313540;
	Wed, 29 Oct 2025 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725044; cv=fail; b=hj4XqPZTX49ssDXEUy+4eUHxNRTwltllj0mWUC3PBgsMckUdPL0RX2493uHZJHoLsqpfINeVZJ1NRXIecYKYRMjw1IsMsUnceoWaNxm9x41lCiAnMwklW2Oc3LGv1hi5RzS7eI9z3AuJtS4P7pfEaalxL8Tbe1p8i1wuBLLKE+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725044; c=relaxed/simple;
	bh=uzid1QV1XJC1GmqV47rbqHFWIolix5fhpM9QQZi9sHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NiC++IYPlMXtQSao8Z9uw/kCdUnEe3Uda+ZfPogZHSsWt+Gja5HJvmr7rK7LkP6y4qZH7zfpp7gR2ckPrQkbVyun0OFZD/F3LRC4W8hchKyTVjUV4kkByePtDkNsoGP2elJ8n245wPCDC4339zW6x3+8W/IlxsfVoyX481GQDwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=iFfwMa+g; arc=fail smtp.client-ip=52.101.229.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaEO0WzgwhzVmxID1alkdNM0gDi5fmd4M+r4O8xH/WmrOuLF5TlYw4i8A3GFkTmzsyabzYhZudYp9Z1N6ZFQFy4j5Oyqeh9uya4Oyk7sV2lzz5A3w5vgwx6Tp2ihqTSGMBnq5Le1AOnL8P0/l83VGvL5d9jty3LbQPTn6cq0KrjihaglRk1VtDNkHja4RVgmp4/t3z0I2/f0d1UJgD00GFlR3MrmH+FiEdBc0WRl8rsrBNWQ4Lqvbx8zC+sbQZBhd6VI1g058drLBt0cf5r8dRzMZ50bGZZbjCyuf3ROkJsNQXABs30Sn7JUpC6J6RDfxT5nIvy+cztgPhNkVEVs4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K0QQwb53P5cZecHOtS9esSM/n+3CJ1HinO8/AkO2dg=;
 b=gYrpcZ6rbstr9tJFC4db2RjRgE4Mwv1NarSRrysg41P/2gBKZxpc2Svl82R3XlLAmLprNGYkITPXtgiO9I72XkKSzAIVOWd8Lk0c7MuApMwrQJpZHNsob2KKhG/+kvCVeldMtAMuw0L9HgWuyEe6zpua2wYqUcfRrX+pI42yqtuwjeFNC3GS3ksIyROPuwuNKXBmWgbPWuw0FbVLUlBr85VFB2ZdLfh66y6+jF4p5V0kYFR4KqDepWLUXngildbIcQnD+BjOHMOtxjiYzfp2tgQYGxNMRkikJM+oLpFkTtazOTAdiE+OibBTXcOwKo2sAY8Tq2FVuCC3wOF6mySTag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K0QQwb53P5cZecHOtS9esSM/n+3CJ1HinO8/AkO2dg=;
 b=iFfwMa+gF0gw189ELun6UTJJUdzODJZOCHslvKfGu/CNVGKXMUCrNSIrNoqtt0fxlEiDUu25PrYJQEGhAHb4xz9PXv5ld0erMlvZeB16X2kUfpW6Kx5CSo9ei6W+tni1k8oaNh8Y7wTZrY9ewfYVrn+8zRgyG0/3hrZDgRuLS9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OSCP286MB5086.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:349::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Wed, 29 Oct
 2025 08:03:56 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 08:03:56 +0000
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
Subject: [PATCH v2 5/6] NTB: epf: vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
Date: Wed, 29 Oct 2025 17:03:20 +0900
Message-ID: <20251029080321.807943-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251029080321.807943-1-den@valinux.co.jp>
References: <20251029080321.807943-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::9) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OSCP286MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: c170ca00-c857-4b4b-fe33-08de16c1b55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+meKfeM8bvcXMhE/t2V44I5OnA/6Xc45TCxgixNMUr0QP009ta8vLNldo5C0?=
 =?us-ascii?Q?EH8bGiVV6cCydYCQVjDUDLSWLiWYD4zgWNS+qlEpr+lNH8nTJZMMTr6Bq+ae?=
 =?us-ascii?Q?DJ5JgYpiHzGR2F/nO8K/JQsoaN0JX+lOfDu6EO+fjQqiLiV1WFBZ4ZmSChcW?=
 =?us-ascii?Q?t3nX1i4w1993e5veUvMgiwfmBIrSR8hdvEFZOJ+N2nPSSMXHNg9qYCPeY4/4?=
 =?us-ascii?Q?vBymCRKFbFuYcyspO4HcS1ln5W4F14T/foLOnDZuuFGQzSMiD54KqyVsjf7a?=
 =?us-ascii?Q?tVRhkML8uV6exnFnjkv/olbsko0nmeuA7m2QN529EouuYC1SKoDXg2AZEbJj?=
 =?us-ascii?Q?4acEqBQxbLgecz3UlOprkKFHiUK3o14dNjozprQEDkT0+eovhIa7cDKdVI81?=
 =?us-ascii?Q?kzIeNI8B6300/RGfYxTGbsE1kFeQT9YebfKqsgT3WRM1FZGKBuyrtRQNfIjY?=
 =?us-ascii?Q?ukUIJXLChMErv43B1UQxWsVSkMQU+RB3j9/q98xHYxRXvsmqVbj52yEN73fD?=
 =?us-ascii?Q?EY6HCcU8Q/ld5EKrY16L1aYJVKNSqnltbl0UsJhl0XSFY7Hn18I0TnD9F0E1?=
 =?us-ascii?Q?CME0boQYLKzoHJLICSzDfTe4wVRaE9goRkDWWeGg4vfs6WBn1dAF+dHVqvfr?=
 =?us-ascii?Q?6RRbYxlgNZ4qOMsYuh9mjYh+fVNoSUqjqORN3HIg2udjnonZVcIUsNw9JJQ5?=
 =?us-ascii?Q?fxFv+HrVGTKFA1om4Rwlj7gfbY3xJW7jmbV8rpOFQJlaN8+ORS9vG9vQL6ty?=
 =?us-ascii?Q?1/UwWOaWhTSwT9ebgjrJLkWznAFvWLXvyIrulhco8ICch0Rfx+g8nG+433dk?=
 =?us-ascii?Q?CVia8pWFNYJZHUcErKK0yfeL0ZZhaD8vT95RApyM6uoBHKtvuH45dzbkG+dt?=
 =?us-ascii?Q?7bM/l99/fY+XjYcVakfrYPuyl4dJqFXKd/YKVfYRPAq4Bl65oaThYb5MrLaz?=
 =?us-ascii?Q?0FkM5lqdr+kqWyGMBxdKxzWqR4rUSQXdvu5v12yCj0pgK918xOT1hVDhDXtZ?=
 =?us-ascii?Q?oZQUoiuYYod1U35YhwBG4Z53Gvph5CDrpcKlqv2Tm0hrBGQwhN1/e8ZDYqNm?=
 =?us-ascii?Q?KXWFiWYSV7YoiSllzQDTSYztAiDYMAOLHdGJtR648dHi7PU844kCv3F1CAAi?=
 =?us-ascii?Q?f4DdzDort4BY11H0mdROfPdRU0rvFVXPUFBh4JYfDWSCo4c5+V8+WsR8ER5q?=
 =?us-ascii?Q?+LhZ3fj4MoOmlSU+A3eZ3TXbUJ6OdaTIhKS7bfq7W8YnxwJyk/H7ScXAqGUF?=
 =?us-ascii?Q?Wq7KD4rcBXrgxpbBNUET8J0E5WihghnTmDKjADymd/UAvY3adbHO7pt5u6EZ?=
 =?us-ascii?Q?D3767Pjnk4Yhhmkyo6ezu/w7yoi9O/603ExETA5Rx8w4H1uxW4jbI3s/Rhw7?=
 =?us-ascii?Q?XsWkEJwd7YjJRO9RuvsLF6f1po4nZifaS6+MxlBZAmgnIaWEgA9yyQOeBPV+?=
 =?us-ascii?Q?9ZoyXpM7lioHjDLMKHk0ljtCDfa9Q/1D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pg+6cBnXH8E8SiK0t53ut6fnQwjRAFIdoVPZWxfNQBhLLHiR9SOFwuyTGUoQ?=
 =?us-ascii?Q?8sIFpbgdfB6gFy8Br05sfhqj6YaejSY50wOnYHBu6ljsdk4P8zIDA7B/COOy?=
 =?us-ascii?Q?0YHGoBV2w+1BtrMukq/aQXevaj3HtnEEmRPDel5QZ7ytjq4ynp/F/63Y+8do?=
 =?us-ascii?Q?X+yiw9MVREPpwu3J59m57mfY4FWj9B3WxB2h1KTfX4bgYX3FPObrUthM0ZgB?=
 =?us-ascii?Q?/iXFthTFsYZ88Ad9tg5ZTXwZdXU6wuEaPeTs2W/t/stzx0NQvfGiNu+z5M+3?=
 =?us-ascii?Q?0oc5zagjwTXty+reHbjfuY5/B8//fuNPlnwXX3WRQBeWnCF33QAcXPEguTqb?=
 =?us-ascii?Q?JV0Sba4BnY5yM5vu8QMkWeba/qQ47RtDiWgHEXBiccxRQgfY7DrSSG8SApXE?=
 =?us-ascii?Q?ynyX2XgEX/xhMtiqjvposLxtUDCiOWsh54Z67+IuEnuN+cYt82qSR0mwdSjh?=
 =?us-ascii?Q?hBl7aWu4xO+2IqfKRAp+cwsjD046CY7PWXgdH13xpr3uYpjFBFgPTmAbvBm9?=
 =?us-ascii?Q?qd2F87F/lO32FDJdOBjxi7iMRKpNoP2JCxLHmo8zmovwm6pUciK/9VDwL+bR?=
 =?us-ascii?Q?2yGKa4tna6l/IsqJZ1Yn3cAMKQLftJRI3ROIA0TUDXfd05DPRKfaajG1FEnm?=
 =?us-ascii?Q?2j3/mGeET1Ha6enJXLfOD2OZcaw6GeCXI/KiSY+geL30gEfhhTerXQfOSz4D?=
 =?us-ascii?Q?E4DJgFebmhxFW8tFWysQuDCyWHSLCTvHgr0/DAROlv87hIPQYYTlpIWfcX8U?=
 =?us-ascii?Q?I57MLZ6CSgFqzMsnEodq1EgLdQTThM3GO3jW3TXMo6hiOq/n5KZgDaQxOGxw?=
 =?us-ascii?Q?Kcj5Ek69ofuOhkObzXJDnCui6ZVihIpNMtgmWT1G8XCSgfQ1ssxzbu6YV/Or?=
 =?us-ascii?Q?iKPbrpZs/2e/T21UYPAowP1Ys2apQIoMq+cLE9ZLzUp0eeo22MR6qWzADW/r?=
 =?us-ascii?Q?b0RaMU2EZSTMWPZ4cW3MI0Z5lRK5lnLv7IhP+PdlHK5H/9vGPlrYFaBXeOww?=
 =?us-ascii?Q?Eueu6ggxYxGyRLA0oBpIUj/I+lIuJlonZ9+PrfRmEhtsooWFgFgFOX6QzPPS?=
 =?us-ascii?Q?tsPPtkCb4QqZUVz8fctvdW+ZqwexFuJUuq8+n5WlACahiF5w7YX98+FV25hK?=
 =?us-ascii?Q?5QSNGcxuxdgSzjypUA19k24zUBNtj1vhEsXC6at29vfho7jfCYapJ63dUhSU?=
 =?us-ascii?Q?AvBmZktNAbHGXug/zzsytMg4fiXQydJKlvpO/vg0BAS2wdhl/OAtQ5ZjpZpJ?=
 =?us-ascii?Q?GD3KhSFqxUZWQu0TZfG2rAFRXq53OE1m4V0YyhmMhBVUehrJDtCGSJigGbF9?=
 =?us-ascii?Q?ztHvWb7jyeokMqppJlyg39WlGgkcp1l+0lHFNAjIVR/gtsA1M3/JWYZKqSdH?=
 =?us-ascii?Q?2PdG6t0eBQadC8gtgP14mLFX4ttlc1Yj92D1oCu5XqP15HK6VDOTMlIKV247?=
 =?us-ascii?Q?g0udvqz4CPKZCL6yklXrCUO1zA9SJeEC/T1zmTUoDiyvwjxVZaxYoWwypL7M?=
 =?us-ascii?Q?bcMsE6569eh5psB3ExgLVbegrEWx9/8GVnt2uFN5tffiyHGgjPNwHZv0TLoE?=
 =?us-ascii?Q?m48LZAeifNTyNHauHGMWt0Rgzv0Jn0w/wCNyZ9D5V3VFmGh3osMvMSGBnccT?=
 =?us-ascii?Q?+mk21BmYzKqw7KSQq/1dMJ4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c170ca00-c857-4b4b-fe33-08de16c1b55b
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:03:56.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojMJkPAM0FdcbW6beQxOPDKu7lD+pAXGzVtOl2TvjmZIk5A79vIJL529qT7bJmBrboIXyQIUGQgHpuzP469YNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5086

Disable the delayed work before clearing BAR mappings and doorbells to
avoid running the handler after resources have been torn down.

  Unable to handle kernel paging request at virtual address ffff800083f46004
  [...]
  Internal error: Oops: 0000000096000007 [#1]  SMP
  [...]
  Call trace:
   epf_ntb_cmd_handler+0x54/0x200 [pci_epf_vntb] (P)
   process_one_work+0x154/0x3b0
   worker_thread+0x2c8/0x400
   kthread+0x148/0x210
   ret_from_fork+0x10/0x20

Cc: <stable@vger.kernel.org>
Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 49ce5d4b0ee5..750a246f79c9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -823,6 +823,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
  */
 static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 {
+	disable_delayed_work_sync(&ntb->cmd_handler);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
-- 
2.48.1


