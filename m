Return-Path: <linux-pci+bounces-39611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFCAC18E02
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EA9405626
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36A63126C5;
	Wed, 29 Oct 2025 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GFu/ogat"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010071.outbound.protection.outlook.com [52.101.229.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1373313E34;
	Wed, 29 Oct 2025 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725046; cv=fail; b=OpeLplCoSZ+kQ3my6mBbIYX6DENiDGU3vmvS9l7nT2TUqfRSnd/+qch88JsscY4QyXkQl0DAmaeK7Qi770sMPNuODkBQC08eleckS9wHTWn/JqKgDVZe9uP1ehHmWTPOugM2aw6+WhUFRMKlP9womzYRuhF26NoCa4WQouagmVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725046; c=relaxed/simple;
	bh=kl8QcfBak6blfclTRvIifEhO3U4Ck/VjC01KuEUw4+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vunei935iLTskchUn7SWpOPlPWQpLvNmeKIPR88xq1ZTfX6iYOF4r3r6zlIaTCplE50lEPIp8+QuCSOM9WI1whhfwLDkU9Prkn+VDKmKzxmzVs1Gx0Kleyv4RoBcpBPX+RbUpAR0RatvA6q5ZLKw+NLC7j6fXmF2mOWFbIt9Euc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GFu/ogat; arc=fail smtp.client-ip=52.101.229.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAw8V741rtNz0BVUTc+CS05tTm0TccYroR3Kadl7dkat8uJQsaWRwuMAXcumu/97Iycx1ouR7Igp75J3ASM14+A+UVnVBEwT3PxuWgbZ6GdRmyZbLd44TxG8eQOVwNayeDp6sO8kVMCvjkcS2JHMAcU5LD2nDoQPBt6vyXe5bBaVERKGnaSvxTQsxe5JoW9TFJ62rSEWRDJuS/6rCNvsupico3a6hrKltbSHPAxftDfst8P6pMvjeHWI4mSeYIyjry4ENpPPKnnKdKn6EPinBEDEXMDAYC1Kf2+vcSrRtyfSnqc4sO5++6vL21R4TavI39cZHXPehc397CXIlIRocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXdtTUHoL2AtmZU6sFbDRbf+xkZ4ntu1d8KJ3J1LrpI=;
 b=aS0ec9onR8G9PhgCANGv25Pq/XEkwCrGOSiBO0l3LSLtgzX2EwXaqGk9AYrrGZ/jAlPfSeCopIALOryXcdoVlOuohlU+ohZupYsWZ+FJpFSyPVi/lrFde6VCfbJuUFqfn7bsDmwAyGctCjxRi6XW3y1DmPAQ6WC8Rys7jpuSkBJ0U/vw1TXLiBb7KKMYQMEgTBykhITyu5PrM5F13JabrKEm7708Exnhb4A7PB5exVevSwmNn80qtv7o7KtXpd6rqh3Aq+RB4Wsr9qf7MRQaqnBQWijz+fHgemo0LTBMQ64I7fKDEXFLZRVnVg94gy+JnZUbWz2jz8d5Xh3xmAOwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXdtTUHoL2AtmZU6sFbDRbf+xkZ4ntu1d8KJ3J1LrpI=;
 b=GFu/ogat4azbG9q7UXpIamVpl7ye9hOMgmOAEo8S7eeTXw2bo5SRMSrMyBjxPZUdFsovvyhJn/RlNksdlmp2b3hrrnImVBqI0aOAO4adTI6j5Opd0XIv/Gl4szXkxZm8YTa2zXa9kG98q2z23SU/v410NQILk6AJ6cKbGtD5Qms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OSCP286MB5086.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:349::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Wed, 29 Oct
 2025 08:03:57 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 08:03:57 +0000
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
Subject: [PATCH v2 6/6] PCI: endpoint: pci-epf-vntb: manage ntb_dev lifetime and fix vpci bus teardown
Date: Wed, 29 Oct 2025 17:03:21 +0900
Message-ID: <20251029080321.807943-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251029080321.807943-1-den@valinux.co.jp>
References: <20251029080321.807943-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0112.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::11) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OSCP286MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be847ff-158e-48e4-fbfe-08de16c1b607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TI/V3zd7BZmu1bxxApqm7Q/CeX1VFzWlszOlKWFS0ONGJ9Q+m4soyhxbcT9g?=
 =?us-ascii?Q?ba9hlunIDTOw1JyXz1GMZ9qD+7TBJdjzD9huGSJ4HDkcil/SWFOVMDtEFPKk?=
 =?us-ascii?Q?Qnxs9hIS5FffTHBY9ufsr4jB8fKMdqjv3CyU1OtnKrYY7mrJone+5TAhFzzT?=
 =?us-ascii?Q?GKfiv7o0rwJFBtuSQaXXRPylB2hfCuqtrCSkBgvxM20JcYXKjb6Fj1eZJ11u?=
 =?us-ascii?Q?nhtvLFDAz7X04LUtNN+27W56RIj8OACuaQtZrd8IfpqMm1nXdtvhGourP1tK?=
 =?us-ascii?Q?CbfG1Ak0p0B6X3JJwYnp/3HUKrpTkaZZY9VUeHUJOzbvxLnDpZJ2vOY4FS6w?=
 =?us-ascii?Q?V12F3rAOx3kK/EUao636wrz7XQdh6UTAJJSBrhGr7iQLEefd5CP9qDtt3Qb+?=
 =?us-ascii?Q?4dHW3eFQ+6ubO9pGaazzFhgElJnaBMpO8LESJZjr9p47r7UNyuRF56ek1ENu?=
 =?us-ascii?Q?1jyzy2GG7nzb0EY53lQZVSpD8JHA2Ab2wfdgz0FUpQLEx/yuGHflPaxopOoN?=
 =?us-ascii?Q?/jEhHsoBLjmxlzbS4jLdww22hr4doX8418AOekbCd9zrLqpj5YcnlCAiwjYd?=
 =?us-ascii?Q?yUTGbNlNwNpRB7GmqfvlgBAUn4FFBLt6shpzisCOX/PwyLnTiydYzrjWvR2o?=
 =?us-ascii?Q?/bgxE1SbFllKiCHhsUIIRdOzOCaEHK4LRhbRjunAdgKLK7oaQ7Jc0gj5zQ+b?=
 =?us-ascii?Q?HhRZIhBxsdVyMVDXYf+7Tfxi8o6NRcRZQQI+F6DpB4tFoq1XdSge0BGOvgwz?=
 =?us-ascii?Q?6+21xV7lcsatUklIldts9F62ffyjy6oX8HCPlb92qXof6gvphYeDxvLZ4TlE?=
 =?us-ascii?Q?irj3xP70NS+7y2w9jX2/GVDnqB7sGEu0HRc7m8j5w2GiXfb0CsItopoz/U4Z?=
 =?us-ascii?Q?O19JvHYZ3x36FbIC/MB9Mup+MSIunk4kCYTdba+/nhW6RqiHtwrentu/XuV0?=
 =?us-ascii?Q?qopkyOfS/KH2zI3Hzv/ef0KDlWGiUzI2LnwvCPp1U7vR1G8KVI3SnuLr8Zu0?=
 =?us-ascii?Q?4sYrYTOAQxoonyL9AxXHzQCGeCTID/aU2f+TtD1y/ZnZ8IVdy7MfHOR9J4tu?=
 =?us-ascii?Q?FAePUeeARUt6BbAet+4zshfr/QE0wwSMGLy61a1aEAKW7ntqQH14riLpck10?=
 =?us-ascii?Q?S5kvxKHV0cfXHCM/+fZDUqhpJkFgwsuIXPYYyM0xeGHkXL63OT9Xw+J46q4x?=
 =?us-ascii?Q?KRXDfbJNVGbDsyJuwlWi7eNvvjaoBlonOtGNdt+w5amlwqNEnVM15OGDfHGf?=
 =?us-ascii?Q?rjWE9ZLQkyRlcSmjgyIP/Ooy76nxwV2/69I/8y0fgn8n7NaioICFbHkVJoab?=
 =?us-ascii?Q?i+Inv6xVQQZo+aV6vyjx85yrV0CCnVBgQjqV+er/fQcvJ0YccJXzDnVqBQpU?=
 =?us-ascii?Q?UxQzj0ZP4Kamq/RUAYtAGVK9Ur0K1AT6JU1zx0XPHt4DRUptr+ryaOayDzvL?=
 =?us-ascii?Q?XFBFkxstY5ZKROnGIJr3d1NWP1wSU0SB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1RFv2YRcSBQ2QCiv67kaQdWaPNrQoBzXW8SHq5CCY2qjdyseinPA7CLJpkZM?=
 =?us-ascii?Q?VNd/xf3/afn8dswiiGsmk59p8sLj4BLKplkLYhq4w3paP563YxQ8rlz71Hq3?=
 =?us-ascii?Q?7S8d5giddGNJr/LMJjbtPnQqEqkZE3DNY+whBNuCxAfsPQ9xVqqzWj/ZAL6z?=
 =?us-ascii?Q?8+H9poiLpq/OeauXO2tRwIpUDLDOzfx+WyEFruRWpj7qXaxDlZBs61D0EqmQ?=
 =?us-ascii?Q?WnhtGDJ3bwOlBaku3sYI0NwgCneu6eQM6eO6IWyYQhauk1pNVW+bIUIeTv2o?=
 =?us-ascii?Q?kngjr2gZKykOm2PDkLWCQVy6sqstRykxvFYIfzR0m1BjeoUt8Z62XDuqHWdj?=
 =?us-ascii?Q?8in6IOtkRxa+6YpJBh8si30+zxFYu1dPajp/QCO8O/OR/W6qfTcX+PHTfFao?=
 =?us-ascii?Q?0d8jhPYkn03aUB1Iz95TZZlli8oW/olj/QoK4S8TDlERz94VwWgM0vdJ5po8?=
 =?us-ascii?Q?7Se+kLXow3dHFWC9BHggK5SBZvPvQ0FI9JsNmofruldFbt4f7ZZK2CX28diE?=
 =?us-ascii?Q?7kd/cXKMPUEw6Il3CrlX4/xzfDC+XFjYBHhhnvtxNDZ0Ohf5i+TOOQEoQ+SD?=
 =?us-ascii?Q?neJOpxl2V5IXEDnBQznH3cZ8bp+woTY3rEijO+ILpYYKmThK+Y+2kvBaFtl9?=
 =?us-ascii?Q?3tKO0NGD8EIdvBgGDltR6bnKKrwDPSyTcKU3lo5XsETZurL5kFNO/18tabvR?=
 =?us-ascii?Q?i+8maNk41KBXSXW6sQPnd5U9NoC6VUMUWel0SGE2UDe70yyoK+M+YWS/SuzE?=
 =?us-ascii?Q?7qv6UJfwOqLdOKm+nZ0BC1RoqbFHSLSg0k48BKHa7vHjWweX00VMIi2V5CrA?=
 =?us-ascii?Q?DUUkhSemu+IQLoJGXVjq1R9n654SFdR65f0tFfMq2XywfPKShzlI9qT+mexn?=
 =?us-ascii?Q?EfYcGtxiODl1nnmGRS+6z3zrxA4GE+mxv7mA0MENA37r729p9FkjSHskLDsO?=
 =?us-ascii?Q?E3s3ls6d7dsvy3QYNzv03cYNBJf2pd/fABEwNGEtJG3atywd9qS/ONDcLqo+?=
 =?us-ascii?Q?qKYaqaEMI6yD3fff6S7AedcXWzCFIcnSkLRDWgRakSs85jcZFtRmb7mS4MRK?=
 =?us-ascii?Q?1GR1jf4eQWG3YJqUmb0p4PajH0PaXVVWRaLADj+cWDyGyPrfyrhf/A6b6jJp?=
 =?us-ascii?Q?fdyFRqcc6S67DbmbyHpd9Pzu59O0jytQsxF24KjtdAvTuRW0svC3Bf31xZrT?=
 =?us-ascii?Q?ox6GmkAKqoN7U/PDmfUvvpOFEFDF/7tI8UHljORT57cjXgnFtIllMw6J98gw?=
 =?us-ascii?Q?zcg9y8TxV+5/tfqSOVGZ3MAECg6aoMhJBMpZv+0OgVW0Xy4jNp5+K0H0GZVG?=
 =?us-ascii?Q?EpcTXyZxVGTjVkhGpzuEJLcK3UgbkfYhBH2G2kk4tyhAg+qwwFBUoc9g1f0k?=
 =?us-ascii?Q?fyFPQktX7UNKKmMYoRNlFq76oQEkncF5bw8lXxdB9008OFjcK8g/05GM+R5r?=
 =?us-ascii?Q?ukwIoT2TlsJt4lM7ksTi967mSy9eJvvj5kqo0w5EyzZ+H/xzml925xx0B8II?=
 =?us-ascii?Q?MRdVWTOMfP/yax2hrdfKozdh/8oAa85In8Hbb9FYVFBrjdThO8LP+7P/ZHN5?=
 =?us-ascii?Q?Slv+6ASchG/4w7lMtS8yuXVuqTL5RTgFKCFJufwKq39ICr9kq5cTFCJTjvKD?=
 =?us-ascii?Q?mTpPTCftduo1YJ9OGhUZ8iY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be847ff-158e-48e4-fbfe-08de16c1b607
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:03:57.3465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65IyCZ3OKMgkMMNWOff8yNjbcSIUBuOhQcxzEnNcPZbjJRvZYv2lV6cTfK54I83L3SO7SnZKZP2MYVwR24YU3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5086

Currently ntb_dev is embedded in epf_ntb, while configfs allows starting
or stopping controller and linking or unlinking functions as you want.
In fact, re-linking and re-starting is not possible with the embedded
design and leads to oopses.

Allocate ntb_dev with devm and add a .remove callback to the pci driver
that calls ntb_unregister_device(). This allows a fresh device to be
created on the next .bind call.

With these changes, the controller can now be stopped, a function
unlinked, configfs settings updated, and the controller re-linked and
restarted without rebooting the endpoint, as long as the underlying
pci_epc_ops .stop() operation is non-destructive, and .start() can
restore normal operations.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 66 +++++++++++++++----
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 750a246f79c9..3059ed85a955 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -118,7 +118,7 @@ struct epf_ntb_ctrl {
 } __packed;
 
 struct epf_ntb {
-	struct ntb_dev ntb;
+	struct ntb_dev *ntb;
 	struct pci_epf *epf;
 	struct config_group group;
 
@@ -144,10 +144,16 @@ struct epf_ntb {
 	void __iomem *vpci_mw_addr[MAX_MW];
 
 	struct delayed_work cmd_handler;
+
+	struct pci_bus *vpci_bus;
 };
 
 #define to_epf_ntb(epf_group) container_of((epf_group), struct epf_ntb, group)
-#define ntb_ndev(__ntb) container_of(__ntb, struct epf_ntb, ntb)
+
+static inline struct epf_ntb *ntb_ndev(struct ntb_dev *ntb)
+{
+	return (struct epf_ntb *)ntb->pdev->sysdata;
+}
 
 static struct pci_epf_header epf_ntb_header = {
 	.vendorid	= PCI_ANY_ID,
@@ -173,7 +179,7 @@ static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
 	else
 		ntb->reg->link_status &= ~LINK_STATUS_UP;
 
-	ntb_link_event(&ntb->ntb);
+	ntb_link_event(ntb->ntb);
 	return 0;
 }
 
@@ -261,7 +267,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 	for (i = 1; i < ntb->db_count; i++) {
 		if (ntb->epf_db[i]) {
 			ntb->db |= 1 << (i - 1);
-			ntb_db_event(&ntb->ntb, i);
+			ntb_db_event(ntb->ntb, i);
 			ntb->epf_db[i] = 0;
 		}
 	}
@@ -1097,12 +1103,24 @@ static int vpci_scan_bus(void *sysdata)
 {
 	struct pci_bus *vpci_bus;
 	struct epf_ntb *ndev = sysdata;
-
-	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
+	LIST_HEAD(resources);
+	static struct resource busn_res = {
+		.start = 0,
+		.end = 255,
+		.flags = IORESOURCE_BUS,
+	};
+
+	pci_add_resource(&resources, &ioport_resource);
+	pci_add_resource(&resources, &iomem_resource);
+	pci_add_resource(&resources, &busn_res);
+
+	vpci_bus = pci_scan_root_bus(&ndev->epf->epc->dev, ndev->vbus_number,
+				     &vpci_ops, sysdata, &resources);
 	if (!vpci_bus) {
 		pr_err("create pci bus failed\n");
 		return -EINVAL;
 	}
+	ndev->vpci_bus = vpci_bus;
 
 	pci_bus_add_devices(vpci_bus);
 
@@ -1147,7 +1165,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	int ret;
 	struct device *dev;
 
-	dev = &ntb->ntb.dev;
+	dev = &ntb->ntb->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
@@ -1247,7 +1265,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
 				PCI_IRQ_MSI, interrupt_num + 1);
 	if (ret)
-		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
+		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
 
 	return ret;
 }
@@ -1334,9 +1352,12 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
 	struct device *dev = &pdev->dev;
 
-	ndev->ntb.pdev = pdev;
-	ndev->ntb.topo = NTB_TOPO_NONE;
-	ndev->ntb.ops =  &vntb_epf_ops;
+	ndev->ntb = devm_kzalloc(dev, sizeof(*ndev->ntb), GFP_KERNEL);
+	if (!ndev->ntb)
+		return -ENOMEM;
+	ndev->ntb->pdev = pdev;
+	ndev->ntb->topo = NTB_TOPO_NONE;
+	ndev->ntb->ops = &vntb_epf_ops;
 
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret) {
@@ -1344,7 +1365,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = ntb_register_device(&ndev->ntb);
+	ret = ntb_register_device(ndev->ntb);
 	if (ret) {
 		dev_err(dev, "Failed to register NTB device\n");
 		return ret;
@@ -1354,6 +1375,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 }
 
+static void pci_vntb_remove(struct pci_dev *pdev)
+{
+	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
+
+	if (!ndev || !ndev->ntb)
+		return;
+
+	ntb_unregister_device(ndev->ntb);
+	ndev->ntb = NULL;
+}
+
 static struct pci_device_id pci_vntb_table[] = {
 	{
 		PCI_DEVICE(0xffff, 0xffff),
@@ -1365,6 +1397,7 @@ static struct pci_driver vntb_pci_driver = {
 	.name           = "pci-vntb",
 	.id_table       = pci_vntb_table,
 	.probe          = pci_vntb_probe,
+	.remove         = pci_vntb_remove,
 };
 
 /* ============ PCIe EPF Driver Bind ====================*/
@@ -1447,10 +1480,15 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 {
 	struct epf_ntb *ntb = epf_get_drvdata(epf);
 
+	pci_unregister_driver(&vntb_pci_driver);
+
+	pci_lock_rescan_remove();
+	pci_stop_root_bus(ntb->vpci_bus);
+	pci_remove_root_bus(ntb->vpci_bus);
+	pci_unlock_rescan_remove();
+
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-
-	pci_unregister_driver(&vntb_pci_driver);
 }
 
 // EPF driver probe
-- 
2.48.1


