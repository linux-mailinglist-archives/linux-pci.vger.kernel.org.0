Return-Path: <linux-pci+bounces-39605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 638E9C18D9F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2EB1C82D1D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01827EFE9;
	Wed, 29 Oct 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ctjMHlWe"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010071.outbound.protection.outlook.com [52.101.229.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FEC2EBBB0;
	Wed, 29 Oct 2025 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725035; cv=fail; b=I+VSySqSCiVfbkscwrI/v2UbniyVKLpCs9XtObhXTmX0At1QQF42L9jyyiRp3UvEjr5Vb2hrx6ekmsxZG7i/p7Ufz1S8iIgiza7Uy1ZJ/XLCGY16jrU8jn+NPA2GAotygZqnR9rJa+G7lLzkOSt0OCk8Zw31AbFE+xy7wxT0nIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725035; c=relaxed/simple;
	bh=rdgIYgUNu3532qknOeG60VV4Lkao7mevXwNW+J9GQDA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GM46KOEQhr41zlu8dlzIOmJfjb8IBz7dX7EduReltmxKeZAW8xBtZAe9J5CMmPtZVTy5lEL9VrUZ2+FbzKS3YbNW1Kb4Gjx9h953pC5M9+LM03FmMw0wue4m2D3TGbtcIp65CzqWhq9rasTVEjktOacm0n+t4lCcalg62IAf6aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ctjMHlWe; arc=fail smtp.client-ip=52.101.229.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpHIP9cXb4EF/K4H2YiXpgQFYFNm4uU2iUSgN92Q/GLQL2/YRYIlRfSIoW8g7HwFKeIPBC4PSIziVgsMHn8IQpyWj8iNt7c3sbSFwXuqLd9RwesoqlxFmsOC1XYcWAZCzV/znVjgibtW5glRcFVmPCun7Y6edBldGRuZNx3KQ6PTCM+vGtCiieloPn0Ju0vTMCMTqSVGkPkYb2AFYgx7aPOGdQTw56vhS/kLWN2G2Jg4sKTJMRGPt5f2WFjoKyX2brujHk1PXcQfTe+swbSVrfev1Q9VGADZMAxa0OP1QfACmvxnS4aH5qeZKqY5tKr577bS8q2dtfRrNVerOIV4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgqjjnLiI75eQ2RhwtvKuPTc869wqZMLrnmVcJnUW+A=;
 b=a2OTkjF6/oTnfDVaQdyTG5TtUR3a7BQBSh9LK3zj9xJm37p46uRHUBpG3LjL7XxUHEo4WuwvkdrErvGOogiMCBIQtQctmBg9n7CD3uz6Iz8gz9jPwyODn+JYc7EqVcl/BdlIpb31CJx8lKvnr0zos1HoF0SgdPvXqDmkJ9/lzq59xsFqSLZ1Z/+LI1FpjwbkQJnlZM5VvkPPdNCc6Iy1jTzeUwhs8fp+kbOzh2vs7KQ9Dzu1Cbq6qSSI3WCvHxwyKbEk7nruSuLZSS0Q5VyPEzPA7X64mpFkBZyJrcEXOlCNr1+ILAZHs146CmuyKEQ+C1iBLTQVWWv6bwxySLEpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgqjjnLiI75eQ2RhwtvKuPTc869wqZMLrnmVcJnUW+A=;
 b=ctjMHlWescBwXAPCJtIWEeMBa+tKVVoso4S3/iQHgXEcLaB/IioRM1eEeZB4wqfVw2LeRy1iZR649THBahLpHussKxR7X+LD9Q+ByUiyDM2mfj/mOT4CJ4dHrpJnrWFmimnHih7m04GnRhtwoG3Uw0iHg9dISd09yO4k7u39hyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OSCP286MB5086.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:349::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Wed, 29 Oct
 2025 08:03:50 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 08:03:49 +0000
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
Subject: [PATCH v2 0/6] PCI: endpoint/NTB: Harden vNTB resource management
Date: Wed, 29 Oct 2025 17:03:15 +0900
Message-ID: <20251029080321.807943-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0186.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::9) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OSCP286MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b16586-ac90-4a24-aefe-08de16c1b1a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d+vUTTkQzruujd9PgWtYT1wkESAJwu4uV/W1XTmM8+RUsXqS11X0EVZ5uOb0?=
 =?us-ascii?Q?0J13JoXvO0+jwIXZGktQunySpXMh7tlalEsMppeDxzWdU6JUE7Ga9M+vgHWi?=
 =?us-ascii?Q?8kWphKZ0v2UYcG9xjIIQ9sHJpidJ/7MKYJvCLS0TfjgxBnTlDa0kRQXHsRhJ?=
 =?us-ascii?Q?K21tymOzCBs4ETwenoE5YLuLylyGEnDKks1VRrMn9YZiYYx2oLZtdRfWNLKA?=
 =?us-ascii?Q?c0rnXWZuQ6CerfBGWSyJSy+xDCAxtCX34PEb56E6fxs90KbCjf487KABT9y3?=
 =?us-ascii?Q?gMUV8IAyeh6Eqvj6RR7cyYW5bEpactAgmKmEsxTewrumj6sWtKgz7gtnXgYP?=
 =?us-ascii?Q?JpC2Vn7L4syTRA2dwa73vtttCeQgPJcDzadJCsYh9AXN3UagQAaiOT47t/cF?=
 =?us-ascii?Q?VdFgwUaCcUBBXP9MuEv8z2NIAPc0Kf3FWnU4u6Jmghocqv5jUay8i+decJbo?=
 =?us-ascii?Q?RLkhuX7SaUYW4laGBZ8z1tSzllD+0GWfMzTm/VG8zClXRl6GuydT5HV8ILya?=
 =?us-ascii?Q?95IPc3mzW+gJuBWJO66oFloFT+6qD3Lw5m4Pji504sRPQFhoFo4mhwuTxhKZ?=
 =?us-ascii?Q?CbQrNrVphFR680+HT+9v9Vu0d5x1CSGBlsmJKRA75ddeqaYijSf+v9FwpngH?=
 =?us-ascii?Q?t/oCEJAlDsHj6mv2VBLi9aeOTnYiDfPOs4ZOxP6K8Ov98gVLmq7tJPQhsYFZ?=
 =?us-ascii?Q?GPc+iwjQoakoCpPXwG4a6SmXtELEwcQ43Y3t6P5c3jzAa7H5uDKmd54wL7NW?=
 =?us-ascii?Q?3loWpo7oNgtZr18f/OJmKV6eg1uJPUpqi99EjnUL5+IR3eMda0UGwvOptlii?=
 =?us-ascii?Q?x3SlBFMnljbVkUQHSvWxGTnsemAGabxvQs0ZpeURcKi2v77hy+H+AsHLtkG4?=
 =?us-ascii?Q?rGtVyu46hS5UY7isCb/xjExadjVXFxSgDgRKybF8fXPzPPhbkr83EOXy0G6i?=
 =?us-ascii?Q?uYK7uDZoY4GGi/JLXrc6JyEknjJE4+zM+l5nVQMmquA6xLNEJ1auIaBuc5EP?=
 =?us-ascii?Q?/3JSoZxt8Mwh1THUlpWNY5WYBrvRhtXyIOZveNpDC8AiW2c8aNm2Zb3wOGPD?=
 =?us-ascii?Q?8oUPukZyMnEvtFlsMnjb4i/yUet8LZS/NwH7vnT7UlKJ4tg1jcPgD4yfcBzW?=
 =?us-ascii?Q?huYL4pElO6fZCyC4R3lriye8VaWXg00pm9UY8p5OLAJQ0VLXLYUTxyTJ0Z7O?=
 =?us-ascii?Q?vGw+8iAE6nCMIfb97Md5Pt/f4DvCjMGdL75qYFZF/UoSUqyYK31y5bnoC7XZ?=
 =?us-ascii?Q?ZmYt5SUPeQJ7ITzaiUTo0RmgFm6utC9Xtlvt3MCDaOH9kZvnK07zpwFpB8Y+?=
 =?us-ascii?Q?KCiMIBP/thvOKShbvmbqqEdvcAp4Kfqqy1Ez9jRoZN6aOR6D3QqrvHSBVx2C?=
 =?us-ascii?Q?5sl76BlULDpvaQw/JNN+IjZR8m79KYmCaoxfEPzZQxvkPzXiOMVjEN19YCPu?=
 =?us-ascii?Q?q+XwL2z5l0gz9pAmzlEw2eOnMV8M31kllGqF0PpRIzlWa7VuYWBJkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Lii3wP7dOSmUyiYJXTrqgiP8Ho19KJkf0FACluvJrKQrMR7CDxWoo0UePX3?=
 =?us-ascii?Q?9F2+IdVFJ+mMaXxezo5Djy9ZDTfr8k4XBLkQUvcpM+Qt8XRlthBr24PtRWUq?=
 =?us-ascii?Q?flo3imAppvFkK9If2YRQqihaf7lwcgwMupx5tBIn0mIqnBklG6d2j5WgD5T1?=
 =?us-ascii?Q?cPMYUzrch96kNtSc+cIDFy8yLQYCpi2+yX6RJ0HBr9NZQgvDnN1EVChq480I?=
 =?us-ascii?Q?gLRL5PtIqdswlv90fNqK1h12+OTKadNk8MwRp1kzeURSO/xl3auuMZ2OFDoe?=
 =?us-ascii?Q?zmrSLj34n0MbRJCvz2yuTP9hXspgA4M26b8XqxZkUz5cZO11D9nX+nS4bSBI?=
 =?us-ascii?Q?CruqburwiCPffMYgpLwl85BQiXHNFitMUBG8UUbV2fWcyQZh2LJNvlFXD0yE?=
 =?us-ascii?Q?CbdgvdM2nTSzfX6PfqsjDX0ZEcHoEB/VeR3GqaZtTeB3Afjv3d8y6j42aA3W?=
 =?us-ascii?Q?r9FwG0dUIH+SIPWyc1Ii6rnZWlxZ/s3H2B1I+qwj2pfE0ZF1XStKyeerwWbF?=
 =?us-ascii?Q?RM6xqzItlwtTTFucfddnGat4cxE2NvqDwbRPrZcBxrZ3GL/C8uqfK+jxdj70?=
 =?us-ascii?Q?8B4b0jc5iFSIr+WojnXvzAKDAOsR+29AGdDuXY4+xtAj8WYfnxz6OmGR09YR?=
 =?us-ascii?Q?kRhftZKEF2kMPj1Q5KXS1uqlnEfZCJVy7Uv7okAhcw/40gGbW/xAd9luLl4p?=
 =?us-ascii?Q?EcdN/sGTS3t9KsoCCdhzsNFbsBYTfOTOP7KSHBDBtx2VVMXcbE9kmJphq0ZA?=
 =?us-ascii?Q?SDtAu+z7uqZY5DntXrXL4IWn/CjE6XBg2aJZait6/AKGYdb1Mom29Uk7JNpK?=
 =?us-ascii?Q?KkgdwALhs67/cAi7Vuy0wUB93NqQkKcgtHBD4egeTL40ej27/JPeqzAYILnx?=
 =?us-ascii?Q?BdsKtNr+pTT3xRUexVSNa7Z78Z5GA7myEHHvGJCyb2mdKZDa5GKG+4l8vkJq?=
 =?us-ascii?Q?zFtJRpKHe1gGet4WcpQ6qEY/TlMTMqLfXNPdeC60UsjAI9x0ovU8TIbO2QSQ?=
 =?us-ascii?Q?U68+/SG78p56PsL0ni52bSlaq18VKoIe5Ipfj0zQt99C2YSkN0w/ZmR+wLp9?=
 =?us-ascii?Q?+OhcDo2hDVjWqPxjgJlPjFcMQ9S+1PSY2ytTv39/vuHbjrljqgcJqOBAn7oN?=
 =?us-ascii?Q?dkfcyQru0/PiB1Pw0rXF87qvnh01ZyNxmE/nxxdffWEWHMn5eJsQ7cx9J4LN?=
 =?us-ascii?Q?3R+zCtA6hX90pDLHqvIYRuY48UY+e0ZEI8adxPH6N6K8EiAFt/Ae7XjUOAsO?=
 =?us-ascii?Q?uk4f5KBDZrSzZrNcnU5mBiGFpdga8GQYoj3Sc9acaeqh4RlBSCgS3jZ2TL7E?=
 =?us-ascii?Q?o+WQG654UYoOc06BFLPfkFRbk2Ob665YKRGnHLG2fmvoEzOCb40Lcd9zbSVI?=
 =?us-ascii?Q?bs55N0W3VE57DARXjS65LAKDTSLa/WrJGe0lbv6ANz02Xze7oCtANHq877BL?=
 =?us-ascii?Q?UN7+UBCdcEQ0NG5y3KnsPf0n5Y4JRKC98tn2ZC1H5Py46ikFkbtOA+DPoL0l?=
 =?us-ascii?Q?64dCtvyEaDiBGoiwpoCTtdGomy5DdUMiDZM0ac854/SFZX3jm4CZpUNEnBS/?=
 =?us-ascii?Q?tG+LMnHop4I0R6rkGGnIQyqwEKieBys+tW+wsZf3vqvS19gzf579jMRoB/CB?=
 =?us-ascii?Q?kRyuJG7N54fSWtqDMFzTJFM=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b16586-ac90-4a24-aefe-08de16c1b1a3
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:03:49.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGFjBnzUznTKaYdl99s9R1oYN7DXCdqBozgff7UFKzv21Doc5gL9sRinZhCMMadX6lwOtoj8GpP2crTbDzwtLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5086

The vNTB endpoint function (pci-epf-vntb) can be configured and reconfigured
through configfs (link/unlink functions, start/stop the controller, update
parameters). In practice, several pitfalls present: double-unmapping when two
windows share a BAR, wrong parameter order in .drop_link leading to wrong
object lookups, duplicate EPC teardown that leads to oopses, a work item
running after resources were torn down, and inability to re-link/restart
fundamentally because ntb_dev was embedded and the vPCI bus teardown was
incomplete.

This series addresses those issues and hardens resource management across NTB
EPF and PCI EP core:

- Avoid double iounmap when PEER_SPAD and CONFIG share the same BAR.
- Fix configfs .drop_link parameter order so the correct groups are used during
  unlink.
- Remove duplicate EPC resource teardown in both pci-epf-vntb and pci-epf-ntb,
  avoiding crashes on .allow_link failures and during .drop_link.
- Stop the delayed cmd_handler work before clearing BARs/doorbells.
- Manage ntb_dev as a devm-managed allocation and implement .remove() in the
  vNTB PCI driver. Switch to pci_scan_root_bus().

With these changes, the controller can now be stopped, a function unlinked,
configfs settings updated, and the controller re-linked and restarted
without rebooting the endpoint, as long as the underlying pci_epc_ops
.stop() is non-destructive and .start() restores normal operation.

Patches 1-5 carry Fixes tags and are candidates for stable. Patch 6 is a
behavioral improvement that completes lifetime management for relink/restart
scenarios.


v1->v2 changes:
  - Incorporated feedback from Frank.
  - Added Reviewed-by tags (except for patches #4 and #6).
  - Fixed a typo in patch #5 title.
  (No code changes overall.)

v1: https://lore.kernel.org/all/20251023071757.901181-1-den@valinux.co.jp/


Koichiro Den (6):
  NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG
    share BAR
  PCI: endpoint: Fix parameter order for .drop_link
  PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
  PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
  NTB: epf: vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
  PCI: endpoint: pci-epf-vntb: manage ntb_dev lifetime and fix vpci bus
    teardown

 drivers/ntb/hw/epf/ntb_hw_epf.c               |  3 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 56 +-----------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 86 ++++++++++++-------
 drivers/pci/endpoint/pci-ep-cfs.c             |  8 +-
 4 files changed, 62 insertions(+), 91 deletions(-)

-- 
2.48.1


