Return-Path: <linux-pci+bounces-42333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02316C9510C
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 16:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FD23A3A00
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 15:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E1B288C2F;
	Sun, 30 Nov 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Aq0KfGfC"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011035.outbound.protection.outlook.com [40.107.74.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3030287258;
	Sun, 30 Nov 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515481; cv=fail; b=S8u+9otaycNfuWasB4Q6zqz8DaUINlGKBJbQMvCHgk+mvrZuIEKY7IO8s/A90CUcA29tbSrxZCOqH5a1OTbndjfKUahH+Wi9/uhXPjIFTrV9HcaBOXTuMxHx8RKcpbpzmVWo/c+02OCXKv65csqY68sF3nerIvZ/9WvSzEEeS58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515481; c=relaxed/simple;
	bh=0gVVf2dbINxO82xeGhwelgYu/pmcZJunEJPv0I0aRCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D5FljRyq/XElwQplajtnPcKteHfo9b9cdVO8hTiFjmNKWDqpzupwZ1BaiEFeyiHbiynP9YIFdKFfQRKjcaF/XNJL6WK2vb8V0Y5woubBI5DgrNxosCkLzphaqldIpgdJwvQvZHhlhgzjjytcx6ZBZCf4dT9xWaTBuGKJ4ohwJ0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Aq0KfGfC; arc=fail smtp.client-ip=40.107.74.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suyG2/qyLFosQNAxpzNB7Evebv7RO8Y2ktJ3so3CWeNtEbt7b8BhXilnx8zXR2qvNgDPNXOvPikfRbP+Y4uggnSsQwPkZhzfYjmSr/XvakSG+naos7QjDlOtyUk7YPiO8KfzGhxTysiZnar6YSm4L/wOsSTqiWTz87QP+wK1u1oZPQ8YnsF5wu0xLhZmtks9jiAWEyWeGfBGSPJilgiL5sUJRJ2E1EVnlEaCWENPKDsZ0tKDfPRS5/gsu68ey9YmJ2udKQaZm/wSWoFqaYO3lGhuMno5vfUXEiriV+GcOux+TfwqOEK+UTLLuA3cnASEsMv2NTmtMHwtBamuxzaypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjInjXitM55lcH1fYYU+3JPnRk4aGhgmePwASmpChQ4=;
 b=sAVGW/PiN5ixnJeMVbWZ47dpH2tGAClZPyMYq/x84x0Hu/cJcc9tULFym7D7qloLHv3SbaZIOyrOZwyiORNsLk9y8ryimoPvf25ntXNe9opUuAXomjwrilPKLXayP7zys42cWRnD061+yuFql8V5x3ZGw4tF7Dna/zFCLlcj9qndWhd7qYs1Nlg65b1iezw7xgQZCpbhMcafP9Par7ShOKGEfZgJuKNo55FyLFFKvoMEq9S/5Hj622qDsbEA/oQzTW2ebdGX3N2QJlRnumUB3WwftVRCyqeoBdP3O+Jdlz+u1ASra5Y4hVay1jcP1YPPKxIS3h/URNu3pQCeHjTY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjInjXitM55lcH1fYYU+3JPnRk4aGhgmePwASmpChQ4=;
 b=Aq0KfGfCfHNMLuiQWI5jkCX+GuhYpO76t3ox75fBw3lz2r0kWvVEipBrglg4C6AATsknkqh8aRmLxTHWO6EZPF02c2EJrLsueOs5BuZ3yKuN0fWwFyKU1BtSj7nnepSHsi1KOgEyoZhNVBLXL5auT0W3f9iuXxPAM6cr7PnOYAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB3865.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 15:11:12 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 15:11:12 +0000
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
Subject: [PATCH v3 7/7] PCI: endpoint: pci-epf-vntb: Manage ntb_dev lifetime and fix vpci bus teardown
Date: Mon,  1 Dec 2025 00:11:00 +0900
Message-ID: <20251130151100.2591822-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251130151100.2591822-1-den@valinux.co.jp>
References: <20251130151100.2591822-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0054.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::14) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: c310ed52-bbe0-4679-7e79-08de3022b2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2mWbmidH5QT9fVIiGMbYWDucfjs/dl4PhhAgp6rUoEpNOLWI8KstUUVkoa+o?=
 =?us-ascii?Q?eqONFV4K+mxlmLXkfUeNMPSRTuLJEzAWSa3Ma7MzNS1WxUAt0xzSyXmnCO2Q?=
 =?us-ascii?Q?q//oAS3thwBXKjKkPbXJBfj2eX98d5GU/v1PDOmW5UdbC8PY6PPM2HCiUmDV?=
 =?us-ascii?Q?tqujkNr2749dhWcJiqmHZGQwuEX7jC53+938drJYAZiaHbgSc54mhugA+bqs?=
 =?us-ascii?Q?G92lSP4QfCWAq9H98o9j2CjjbyTizDOjAEBxNA1CX3dXsPPyJlUVplO1lz2S?=
 =?us-ascii?Q?R/eLnPjmy7QEpPXg1ONRiUfNqxjvjWb9gobPiOempdpM7q5ME2ynWr9+4nhY?=
 =?us-ascii?Q?ACRtvWFuitPSUJEcoJIvcXJFGccoOqGQYsERwdDye3TD979V9uVEA+ekWOOh?=
 =?us-ascii?Q?bXz+g9hGfG5uKG9S0Jtk2vWsdOXJG8jxFrcq4KugC4tqBQuq9WzWIWDYjpfe?=
 =?us-ascii?Q?9EZe3nvyNl0kh8MzvmXSkIb9SDF7dIjGLCKJbhrTBxd0iQuna/d8Xl5J0XSo?=
 =?us-ascii?Q?He58ffNmDyCPmdq76L2XsCwyLUcHds3nbS/z2//eCya2IR+KS1P4MwjrDm1S?=
 =?us-ascii?Q?MK7/Lvj25twS3xYMqFRKk5TEbKXKCPORxfTIBrhkPBKR9u6umVFC8W2hFDMU?=
 =?us-ascii?Q?4FJRIhCpz55Q4Mz4Qxac9GjSQjLuQRscI1jsMkbs++sQUcDCbYdhuBlkS8BF?=
 =?us-ascii?Q?TILa8Q9tJ64FSYiUvAowpDH5tduCSEc5y1Qp1VhGYgoDOQdcQ/2Clhpl4i4+?=
 =?us-ascii?Q?FglvxYxvyn16Alkoe0lQa2rN66ZkBZxJCTkI205nMfHdL+NUjxCeOZV52MCQ?=
 =?us-ascii?Q?ghiWVzl7qkfgHXqJ92j6Djor5RGxpXOtbFIG78IqOBJE5gBszOddJWgKfO+B?=
 =?us-ascii?Q?jEe/Ta8BL0oRWaJNIzwCZVhEWqLGTlwZ/ZOGvpq4jbmtRZ9gxW3h2Fl1WbO4?=
 =?us-ascii?Q?NF407Qiy9fMU5Bm0nM1YrOJCkE2FwEspUQSB5lUuV2o+DO2K3c+YMTlcKquP?=
 =?us-ascii?Q?A2408dffjZJ7aa/32gaigLASTEPJQWnrms23DJalMA+/ZXPL5cgWjr0G8uAc?=
 =?us-ascii?Q?D4/OWJE1Gp1mk4E3juLQOJVBn+4dRa3iXPjc/I+gwWgEegJITKUhyKG8bvlS?=
 =?us-ascii?Q?R1dw8Hb5C5dezo3qJlVv4BHy6KHTo/Thx0KbWFEtgZhHQ+GEaAiB1ftyiA75?=
 =?us-ascii?Q?E8N0rfVbrYifHH9Ph9tEtkSZ6JDCWNcFdbJ+8tJiBH1fACDRihDJSv5G5nkX?=
 =?us-ascii?Q?VzfTcvfl4TQvevlXySTGqE42JuK0yneXPczj4dO+YMiU5/jiqx2lzt4Dk5F/?=
 =?us-ascii?Q?nenUuR5U+7lHgp5OmEj2WCq1FLyEwdWBdrbvhTxO74HPmKz7WQU40z8MGrff?=
 =?us-ascii?Q?X+FotFpdid5+HqNeRONYfqczseNlCd1N5a+iF4nx2cEgKbemsNljjSYcNBMk?=
 =?us-ascii?Q?YvGz9Hv64qvhWWLOrQbNJvpOqba0dzOf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NK5yyUP3bUo6AU6LFi+zTtwqTfOQuU8X9+sTy8s0O3pbaUNThU1i7VDNSaZY?=
 =?us-ascii?Q?o4cQt5wpJWm7DvsEwFerPL8Hv51E5Er6s5mcm5LfeEoXFUJqSO94LVNhsgwR?=
 =?us-ascii?Q?kyj8dnXQKTwQiWD1l8/hP+YNUZL7qog0q/yxLDSd562hL8MacOKESm+8YLoV?=
 =?us-ascii?Q?Jpq624LmpGLH2sLvkiN4LPyWpvZC9adUoBOFOvMV1JyxHZY6eSZfF53cDIt3?=
 =?us-ascii?Q?809q+IQ33/nR4FQmhUfSG6EBBDtf8AbyACSrN7x4p5EaFMFjh08HWh2WOlfW?=
 =?us-ascii?Q?cXdCiPA75rusz9ML+fZrjlv5D1xP37fzMRqWPLUyTIaBkjUrcvI51ptT7YIr?=
 =?us-ascii?Q?ZL4WQhiCzDy3aGMLYvdVrmlCT2bPkJ2GJYdecuWrOIjnbDi5sUdg4bZ0pzlm?=
 =?us-ascii?Q?VcRdjEwoxsLPVqZKK8Hh8aodZtjSLjlSbFddTHl53q/is2TrOrXISrBtXven?=
 =?us-ascii?Q?WJJ1UJb37YyBX7tPilW+x2DGHihSMVT2lKrHP05QAoXZsImP4WZniCPvrmOa?=
 =?us-ascii?Q?GNXqMbyysDf+3FiFg8iDLUHtnYVFF40WUq0NGbDSAk0ON+xN9AWot2VccxEP?=
 =?us-ascii?Q?b5hrVtr4KjovBFf/HpY+OuuDaIYlYFmVsEWUPNXvnLBZuCbqUl5ZvDjRRPOH?=
 =?us-ascii?Q?vFC6+QNGUAbV0o6g0WKoZZzE7difov0dn35tooBvrbGYvMvWCV+FkEp6rcJo?=
 =?us-ascii?Q?CSdvPAGvZjzF8GYOwvREWRE6fWiG5jDArkfOdBqGKyLKV2rLfrAH9CV58j3j?=
 =?us-ascii?Q?vRZqHUWAycrEIqmGoMjjXvMOd8vd/rUqbZR0SdhiNbitzLpN96oXqeJmp9N8?=
 =?us-ascii?Q?hrYRypxeKFYpEWMvST4i9lf4S4E/Y+0JHfXIuOWhr5P7BwMtVC8B1xcxqNRO?=
 =?us-ascii?Q?25YI28uKY/hEp0bs9AJKJAHiXF2FPZpXnsVxq/lAwTsaaWBY8wArrhHU1wEk?=
 =?us-ascii?Q?2gZpqiLdECcwYcMFI72RYE0hMBLL/ia6z0qUVVX7U1Qy44ShtkcIIY0MWJNj?=
 =?us-ascii?Q?Rzjm6QFajEE/WaRPNrA8yk5k5QkjQmIKQnmbE0l6lNP4MTKJni8XR3dxtC4n?=
 =?us-ascii?Q?BLmkZaILlkeLrIvc2NvEM/q96tVzHitYK06oE9I2odgna7w2Z/bcELbigpim?=
 =?us-ascii?Q?EOUCJjct2/cpVCHyiMkdswIZcwKwg5XTw0w1P+mjP7KKFkI9qr40LFyIx91Y?=
 =?us-ascii?Q?q5Z1FI5mQbbwSYL9LNb64K0+cUWsDqQ1noUkhpHlQDspqax4sRVX2FPqZBoX?=
 =?us-ascii?Q?VoBPvjbI5ts0lYCBGjKSufjEOxMX5bHQGi0v6cYunbXz9e0C/vtMVAtWHAMS?=
 =?us-ascii?Q?PRPuvRlGUKhQ2rj8Kvw7KL6iA1rx7XOqFSp9y1R8ehkoL62DFH2vR53m1UxI?=
 =?us-ascii?Q?jnxErzoipkr0RPELIafNwhM3e2TcZVNY57Ui3hHpDEuHHFcdhEfdW4gdezub?=
 =?us-ascii?Q?CEnc0nd6FFCNzKxCms+MesKAs5/XJjrLcIj0UaCAg1sywbxjYtyqvjumcgmY?=
 =?us-ascii?Q?DBIF+uruKhpmlEG+gdq4/ejJ1ma+1nDnCnqZ7jjPt0dZWSFBDC8282nD7vx7?=
 =?us-ascii?Q?GhrYEUeevHllNMA6ndoFSz6QTWiFpyNX4lwPpkoG5haPMTeHWSrzFhlOtjxc?=
 =?us-ascii?Q?d2MXYbkZRJo+17H99xtdMjg=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c310ed52-bbe0-4679-7e79-08de3022b2fa
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 15:11:12.3576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+dbbh4QTTJUFPSuwAjCqLCF8xXs+ZvUBYA8AJmWHmFs66OsQIkjmgsPP3HYczkwkhJE+sRdDJLWoxAUqHLH7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3865

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
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 52 ++++++++++++++-----
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index af0651c03b20..3059ed85a955 100644
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
@@ -1097,7 +1103,6 @@ static int vpci_scan_bus(void *sysdata)
 {
 	struct pci_bus *vpci_bus;
 	struct epf_ntb *ndev = sysdata;
-
 	LIST_HEAD(resources);
 	static struct resource busn_res = {
 		.start = 0,
@@ -1115,6 +1120,7 @@ static int vpci_scan_bus(void *sysdata)
 		pr_err("create pci bus failed\n");
 		return -EINVAL;
 	}
+	ndev->vpci_bus = vpci_bus;
 
 	pci_bus_add_devices(vpci_bus);
 
@@ -1159,7 +1165,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	int ret;
 	struct device *dev;
 
-	dev = &ntb->ntb.dev;
+	dev = &ntb->ntb->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
@@ -1259,7 +1265,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
 				PCI_IRQ_MSI, interrupt_num + 1);
 	if (ret)
-		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
+		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
 
 	return ret;
 }
@@ -1346,9 +1352,12 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -1356,7 +1365,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = ntb_register_device(&ndev->ntb);
+	ret = ntb_register_device(ndev->ntb);
 	if (ret) {
 		dev_err(dev, "Failed to register NTB device\n");
 		return ret;
@@ -1366,6 +1375,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -1377,6 +1397,7 @@ static struct pci_driver vntb_pci_driver = {
 	.name           = "pci-vntb",
 	.id_table       = pci_vntb_table,
 	.probe          = pci_vntb_probe,
+	.remove         = pci_vntb_remove,
 };
 
 /* ============ PCIe EPF Driver Bind ====================*/
@@ -1459,10 +1480,15 @@ static void epf_ntb_unbind(struct pci_epf *epf)
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


