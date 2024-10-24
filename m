Return-Path: <linux-pci+bounces-15172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5AB9ADD25
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237491F21E63
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3871AAE27;
	Thu, 24 Oct 2024 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UpC8hV+I"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B4D1A76DD;
	Thu, 24 Oct 2024 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753743; cv=fail; b=UKAbg8c/HNWxSf7rtOPIIOH0IVFIcWWv61iSTm3VArusMrLP+Q+Sl0glHHnvB+aMVxsYsmhGqZk2WS0Go1T0aMAfGe3Zi2XM2JmcOgwlEDYrmgXgUYEG0v4ktK4a/HOciu3VMYknY0tzZ3o5PR9eY+nZtdUssC7/rzxQhyGdGo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753743; c=relaxed/simple;
	bh=L6AvRQhlt4OHN8voqkHc5K3vgOP9V9znkwVrvSEa2cM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WSosxhX4UmmWLAvskWbij7LfM/ccHGXw5d9Tzz8w+pExq8RWyr0PJSPYf69Y9pIueAz6O2VXw8UkXCHF9lREOPCCFlFF9WXhFVrT7mQt3RRDnz5WJ9y2rispY9o9MkCK+ORmS7RAIVQitNmVTNZHEf1Mrff91mluI4SS2+FLDi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UpC8hV+I; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iO2Rnbb9z0s/1Wuqe5xwWJE3m76L9hr5ImtGCSNJBoGQpIzqhAkXMZl+SrgumwSiI3enxeUF7/3jJRvmkWC0gKwVU3j2wPfvfSUbHyxfIg0Mdvhzxs//1P/ptaAe2kG5/JsPFari+DG8cxcm0mG9k9abKv207hqQ1jVK4XQXhMKaYZfGXGSG6rcl59UpW/ddnai486YZKktPQgrgvefjoPXT4RER9PPYTP3DXQxGy9EqVVgGhvQyC9YmqHjYpdUzU+Hv2+qHSe+IVSaAZMfDjVFoEuQ1ImLQnH+Xlco193GaS8hXG+7sD4EWmkyThXbIm7tGVnjJZzzCfjKZgKYG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKrh9kk9xSm0bZHZNQWQvwxoSP/BC5SLqXmCtoou8c4=;
 b=u+z7rdQKRdZbf9Phx147c7VpUtzwJ8WbW91Rg7GZzVbVHURUA7+ERl/fQ9X/cnoBLjB0SXM7ZQqQ4CsQgQHK+DlGX3xh7LgOXLwnHQxHAP8ACVSA6sqynIEoSp/VtxWm1ZBAJk4Lbqh2PuKuTz8QrUQlQV6GdG8oO3LWYzvBlLNbQzG/FJqCT98Lox0u+1T0SBaSZ/64z9aXOO7ywgkFoYpG5C6TXQvjgm2AY598GakMrdd99kGSd6ovky0zna7B5fBpVRquW4UAjo00dvppOgdFVKITSS/slkct3on4N6u0bdwPA6vWDsADs0tOn/99ZNbBpwH3LFKJAnv804p58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKrh9kk9xSm0bZHZNQWQvwxoSP/BC5SLqXmCtoou8c4=;
 b=UpC8hV+IfR23gNaLtoF3rq2GNhWjwezNnBTifnBNwgzT+Di6TDRFLbIAB3+iczWfFFAo3lq0thqzfAhkevubfW16OLLCcY8b/J6g5CyetBSejHjsrcl64WOR2TRLLT0Cogd9simwdbvFKIG7scN/RsWwjH0VzzY2vs/FdqRKJzn+wB7nDQDPM/ArVmKMPAZXZ4QRsAlinTO/fyRVwPYdK23ikHIs+rfGbI3csHZF9NAonV3GH12LpaObFknGcopyAQeExkMwfGU2m6FB1eck/AnS9iXIIl2ZIaQ7IkfQo+dLBsyv7V0zDOEWGxQ7sFadm1UZQFOJ9f2ZjofHvLrW/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 24 Oct
 2024 07:08:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:08:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v5 net-next 03/13] dt-bindings: net: add bindings for NETC blocks control
Date: Thu, 24 Oct 2024 14:53:18 +0800
Message-Id: <20241024065328.521518-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024065328.521518-1-wei.fang@nxp.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7ab1a0-6f6f-4838-2de2-08dcf3faba01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zjtJdjAFgVGJZ87wxTt7awc334Ew93twkixBHJ6/0c2s/pYR0FYlFdCw24CG?=
 =?us-ascii?Q?k4BbkEy6ky1A3e7S/e15z4wgY8BjCRQ/rlbhJlabD589Nt1PYt0bAtwAna8p?=
 =?us-ascii?Q?XcFFbYGA9llnijbtRtgmdjZZMMK9+OoG1fBPKox9bHJDIKoRdY0uYhzVjavV?=
 =?us-ascii?Q?kVDMZGCQ3pJ8jB3eW4KOnmmfyKjIpL/qJjrBA5ziDfEK2ysTZ0BMe0A9kHs6?=
 =?us-ascii?Q?Igr+FTDAKO4abfelNUpojqa+IXVcyBTYOBhsYQY69cdPIRL5EEEBeZltXoTI?=
 =?us-ascii?Q?H2YEWvplqacsUkXcVZXJ/f3zUPE1ZYfpPvffuQ7VKTJj8UrMw8Mw9PmTcT0d?=
 =?us-ascii?Q?wJIuFOVwdMUdgfEDvxT9xa79deVo1e/nZ9FtFpMW+UYRUkVQ1M8kgd6J4uBj?=
 =?us-ascii?Q?QwgFXDMGuSKC+XcpCWue9w5dSANIULMLDV9VkldVKIkY4XSGxSVWTGLsNvHB?=
 =?us-ascii?Q?L7NZQvMidz2s3ChuWZyqLVcATN+Q4tte2P+9xaFXjjpaC3UxtRk9V70A1Jiw?=
 =?us-ascii?Q?8scnIYNZfHjkz3ZBbQKBiT9E763/BmvTGKxJyiY7PE0qArpSqMAEIYW78CKS?=
 =?us-ascii?Q?YqS97j5tpUxKHqpII6oDxGf2Akk1V9YPdukoCFQuzVxBmVhP+A2ff0cYiCVF?=
 =?us-ascii?Q?ku/yeI916kJaBaANvBKrDY5H1VNE61D4Cmq7gxCyo+7nm/kAKdRD7zPpmCJN?=
 =?us-ascii?Q?y5hyNYdCIat0TsDUSm/B5uxVkh4bIOA/hNOTmlLnK6bOx0uApp0axlJJxBav?=
 =?us-ascii?Q?2MS3CG4jo7PsSU8zEvk09WRc8ljNrJyCZIgwoC20Hbidzb+VwgRXNbmYvh4/?=
 =?us-ascii?Q?BboMnq7IGI8GDuFD4nZOfNWoawVGoLfdoAfHsCWF8IA8VQtsCb/vH34JDhwX?=
 =?us-ascii?Q?HFS3XXP1YRf52wks51FiOWXKw3hskr/SwrNfXwwbyflVRR4+S/TaGr/dmqan?=
 =?us-ascii?Q?1eYsL1E/aob//EdaY6eUX1c77y00GKeIn/Lt5SDbb0umJqo+LhQ9IyKs6ZHe?=
 =?us-ascii?Q?5s2w7qN0F3+Iv04DqOXHIcKbrqPrYNtNKg6cSznBn+3HvA9w0iTKEcX6/CCp?=
 =?us-ascii?Q?JZlWt0HMLQ9j3OhOisZIYUB8IFm6W7lrE2wHZzJOT0CJc2WpLK2SxaAWvKWX?=
 =?us-ascii?Q?Hck+z0nAEp8kbJLN8XUQIuXeR3Pcp2WuB0qLR09R4VSi8GSTNU6vSNMxgEXO?=
 =?us-ascii?Q?kefiLfM209ZVI5FSIG7SirbkX9P87bZ0D1HGG7tyYZ04IhNAUq5QBA6mIfDQ?=
 =?us-ascii?Q?wP0RIvV+7LSQiLm19RAZDIBWPsBjqEP1p+UW1JofKrJvIsTUd1bfhTuLch1r?=
 =?us-ascii?Q?oFQcXOlR0cXjfL0ikQeP5vhSFzytRQipBTctwzhMCC9aBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xVCy+jAnRy2KjM79hg2YKCjOP9gQGs9PsB0wM0GzNDkXWwQtgTx+tIiHITsM?=
 =?us-ascii?Q?3Ycs2WkhAx/vO/78OdRVtBLv5MbtI27gCwYObvfJ7EcTWlo9LL7zVRUN120u?=
 =?us-ascii?Q?d3aDAqBjPt+xOGRUjJytA8e87ZW63wW5FYkbGFhogeKBrQVL8T9yXITqe46R?=
 =?us-ascii?Q?7LdW1b1Z3T3KqizAS6+nOEhqc0xD6xXux1njmbDXxrQHewqT6+0gWKLalHAV?=
 =?us-ascii?Q?b0psx75diMKm7Q55cXnbrlwom5FEx+LpQm1gBZfqtWEtclwFkNqMBVMT/0LJ?=
 =?us-ascii?Q?pEo+Bvzfx+rFjhrGXE/qbbRa6AdsuHDiFMZQc4CcD9ASxWKe7N2B9RZImRK4?=
 =?us-ascii?Q?JI74sowQw9V3vQsOg3E7oloTjpuobLt1mGK5MgiSkkxKxFdz8ER8+HG6PqeP?=
 =?us-ascii?Q?YkIrZKS0l9cdGu1rTvPA58UvJ1X0K1rokVPTI15e3KQpum34zNW8Z8Ia7rl/?=
 =?us-ascii?Q?Drs7T8fGQqqw7V1wWGruR7lueQ8fN6g1M3iKUf1H37djvd+ea/cIvAkPOQtP?=
 =?us-ascii?Q?bjy4qAks7hL0eiuMD6GFbbHSmkE5gSqPWfF+PCJc3YU8rxs8NpMVq/qFXT7O?=
 =?us-ascii?Q?4tD5akkUIiQG24It00Ucwf2EWx5Fd67PdJwcXs2ukgQHMR3ZD+pnfQEF3tSs?=
 =?us-ascii?Q?M9hsztEaYZgW4mNb0UqMLqyUVeBHu2kuzexS8Y+N8Ei7IJDS8Fzj0tpfjDz5?=
 =?us-ascii?Q?FD3Vi/8SomaG3tk1OYw7Kn6RDjQu7FjUevwV4PNDUGd4Wl8Rx7hrNXEBkLQC?=
 =?us-ascii?Q?Psh6E3TwcvmlzJxrHP6BS2Fqg/wL9F5Yu857mh+RJQCXx40cFf0VgrJGEp5W?=
 =?us-ascii?Q?lUEd3cv61SaspIrSBmiKy8oBy3cGgdi2mY/JY7HQKK6wvTcPGTntX0sSEITy?=
 =?us-ascii?Q?xdvp139J8rvJPUYl7NQZIJRlE7JaxXx0KlVWtOJ9JHqowkb4mM1uD1nQLYuk?=
 =?us-ascii?Q?9MubAW66Di/3LnozVNi2zvSGhJTBFravt5/eTC/L+DUQTMt+P4FO6lIrjrzj?=
 =?us-ascii?Q?yYPuPYrHNbBg4vOd1DjEQPs4SSA96Xczx/prFeq3SbdvWMy+SuEMnkCBT3JZ?=
 =?us-ascii?Q?KTgcCqdtixZfHjRzU6OjppCa3BUXX9xVvy4/nUO9sRbeTsQViiWi5/jsxNf8?=
 =?us-ascii?Q?wORxrLzR2CW1N6WLBhxaUZQG+lz7EKWv7QZ6fXrNGwqkE3r8RcxUIsz5MTBi?=
 =?us-ascii?Q?6VHuvo1FtBmJJ3lDiyDfdSfkXkwCsS2fiOgnspZKfwmvgSvq3Pz42tpXJgjk?=
 =?us-ascii?Q?Fr5L2I+u4N7petEpg/fSVCWJxSBDmRLvZVzdp1GI3IKghFDgCO12KIt6lT0q?=
 =?us-ascii?Q?NC6fJygvzR8AujZuBfqTm3dEtBJa7tu6V9zHkBQf6U5CVuh4nReb4wsFBrNb?=
 =?us-ascii?Q?tM6J8Kty39sgDbqaGFcHN7QGvsLfW4cZqNqB1Z/URDJ6kOlF47KUGDLzHhCW?=
 =?us-ascii?Q?7sPZ/U93jHqmp6BQw+VvOxRjpKRjaVnswkinlp3CDHL92vsnaYKLLxufCMma?=
 =?us-ascii?Q?rN5gE8vGdGCwF7qM9DCojVDI0hYE9AcWnQcwjuQkVtEwXrlWmPOQsdOSesB3?=
 =?us-ascii?Q?7lqRmxK0TLopvHsOlB9eVDkYOL4TO3Ja3nos4+v1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7ab1a0-6f6f-4838-2de2-08dcf3faba01
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:08:56.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctHVwH0MNzYrBbuoAAIRp37RjzIXeevCVDlJA7nuXtOcZO7BjNG4KXYtwlJwZM73Z6Vv77KmcpNmmaip0JkRhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153

Add bindings for NXP NETC blocks control. Usually, NETC has 2 blocks of
64KB registers, integrated endpoint register block (IERB) and privileged
register block (PRB). IERB is used for pre-boot initialization for all
NETC devices, such as ENETC, Timer, EMDIO and so on. And PRB controls
global reset and global error handling for NETC. Moreover, for the i.MX
platform, there is also a NETCMIX block for link configuration, such as
MII protocol, PCS protocol, etc.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
1. Rephrase the commit message.
2. Change unevaluatedProperties to additionalProperties.
3. Remove the useless lables from examples.
v3 changes:
1. Remove the items from clocks and clock-names, add maxItems to clocks
and rename the clock.
v4 changes:
1. Reorder the required properties.
2. Add assigned-clocks, assigned-clock-parents and assigned-clock-rates.
v5 changes:
1. Remove assigned-clocks, assigned-clock-parents and assigned-clock-rates
2. Remove minItems from reg and reg-names
3. Rename the node in the examples to be more general
---
 .../bindings/net/nxp,netc-blk-ctrl.yaml       | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
new file mode 100644
index 000000000000..97389fd5dbbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nxp,netc-blk-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NETC Blocks Control
+
+description:
+  Usually, NETC has 2 blocks of 64KB registers, integrated endpoint register
+  block (IERB) and privileged register block (PRB). IERB is used for pre-boot
+  initialization for all NETC devices, such as ENETC, Timer, EMIDO and so on.
+  And PRB controls global reset and global error handling for NETC. Moreover,
+  for the i.MX platform, there is also a NETCMIX block for link configuration,
+  such as MII protocol, PCS protocol, etc.
+
+maintainers:
+  - Wei Fang <wei.fang@nxp.com>
+  - Clark Wang <xiaoning.wang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,imx95-netc-blk-ctrl
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: ierb
+      - const: prb
+      - const: netcmix
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ipg
+
+  power-domains:
+    maxItems: 1
+
+patternProperties:
+  "^pcie@[0-9a-f]+$":
+    $ref: /schemas/pci/host-generic-pci.yaml#
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        system-controller@4cde0000 {
+            compatible = "nxp,imx95-netc-blk-ctrl";
+            reg = <0x0 0x4cde0000 0x0 0x10000>,
+                  <0x0 0x4cdf0000 0x0 0x10000>,
+                  <0x0 0x4c81000c 0x0 0x18>;
+            reg-names = "ierb", "prb", "netcmix";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+            clocks = <&scmi_clk 98>;
+            clock-names = "ipg";
+            power-domains = <&scmi_devpd 18>;
+
+            pcie@4cb00000 {
+                compatible = "pci-host-ecam-generic";
+                reg = <0x0 0x4cb00000 0x0 0x100000>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                device_type = "pci";
+                bus-range = <0x1 0x1>;
+                ranges = <0x82000000 0x0 0x4cce0000  0x0 0x4cce0000  0x0 0x20000
+                          0xc2000000 0x0 0x4cd10000  0x0 0x4cd10000  0x0 0x10000>;
+
+                mdio@0,0 {
+                    compatible = "pci1131,ee00";
+                    reg = <0x010000 0 0 0 0>;
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                };
+            };
+        };
+    };
-- 
2.34.1


