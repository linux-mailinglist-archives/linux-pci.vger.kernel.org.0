Return-Path: <linux-pci+bounces-42457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53201C9A6E1
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 08:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C9674E3403
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 07:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CBA302CB4;
	Tue,  2 Dec 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="E4ffC/JW"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011027.outbound.protection.outlook.com [52.101.125.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2830275E;
	Tue,  2 Dec 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660247; cv=fail; b=Afu5yY8FIRrS1XjMWJ5kDvPSUXo3SBQwN8YgbhACJgpKgQ469vqX21swxLK5jv1N6mRf/xiefW/k7YWGer30AkM+m44RbbvlLRZwKyE9HSXQYQ8T7FvMYD8CScVig8xvzIbym188M5rSNAiU6nQk0dzgiqVQ8ZYgG9ziWzMmTKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660247; c=relaxed/simple;
	bh=uzid1QV1XJC1GmqV47rbqHFWIolix5fhpM9QQZi9sHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YdW2tLSezgjq1O4FaDuN1UyKQpmu/zX0jQtW5ZbzTczL0DVyzE16r3VZ4AEAscYi/dUb3xEt9VR51GQEg2beuzeX52L76w3hGMjwgWwOjq+9NbzbFb0t2or/rXpijwRnqu/gNbFQTogFcyl1BDqoRoCspvvz8onby/cVfRjCVuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=E4ffC/JW; arc=fail smtp.client-ip=52.101.125.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doc4plgufLmdmUy3XHJMRj0wJJ2fehYCNdLkJ7uh2PszZPjSi+2nDUat86k2jLqzHZC5kf+IT59L9o65An3wl22Ix7IKu2dzK5AXs+pDM9UufExF03DsBqD5H8HzJdQBtF7HM8NRPuwOZvCGuKOUn09Ma3Gk2lWk5WaRhpR8T0Vm0vaAjzqnE3GnFke0kzyBoPnTXiVJz1P+TkHIlm29Z28Ma678mP3flQqjI3P4L2PZykL14moFiEHK7VT2eOCfTArv+3vXvfUn3uHMyK6SpYA4flC1CULGfHik7pugB8sOBey7mfruGyJYL4P+yK+o9Q4TefAeilq3kfzmF1vSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K0QQwb53P5cZecHOtS9esSM/n+3CJ1HinO8/AkO2dg=;
 b=fBSym1qs8TkZwbXQFZOrtTtK+R2cXEz1T2ndwgAmUyC7xcP93u4WuJjdlOQRP5F5HfdOKJelCrP1UMPb95hebCuXUmdeoQRLWeD5E5izH1+rIqHJdo9vSmSbKwIKoa/EaF9Ec8hjvpJTc3bNS++Y4hfTO+9nbsVB+aUUGIBPw4J4GT/DX6FiaNmjp4WLbnJDwFMfKOulki33+HZoXQO9HVJ9U4b8k2fMEOK6pmh6I+UT5i+a6siGtTEJXKa8x7//L3I/ZB/QQPi31/48tX9dJxWPRuL4hMKwTxKrPjk1ifRc3TlT/oZ/dRHj9DFiRjQyG9/eB6t2yxuhUUTWCO3Tyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K0QQwb53P5cZecHOtS9esSM/n+3CJ1HinO8/AkO2dg=;
 b=E4ffC/JWIMMN6svL9k7AvNPit7MbIJ9NT1GHvc4ScKr+hQjB2Nbs8VETOPG+CPip3UM5eTq7bTOQMdLafeHX0ljWXEEm/86af9+b4ntykKUx1DspVtUpUSypIcxu/YEXov0D2bkmhx+ilQbZwDwqZ6tbB0DVspsAy3JbRERCaDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS7P286MB7356.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:23:55 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:23:55 +0000
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
Subject: [PATCH v4 5/7] NTB: epf: vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
Date: Tue,  2 Dec 2025 16:23:46 +0900
Message-ID: <20251202072348.2752371-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251202072348.2752371-1-den@valinux.co.jp>
References: <20251202072348.2752371-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0163.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS7P286MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e12277-2772-41ed-1afa-08de3173c058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J6miGEBvpCevqeNLA/LaOgAUnxrwJbUdfbuM5CzsGqeP5Xs9l4K5FtLifPGF?=
 =?us-ascii?Q?miJxN6PD2SjC71DSseoCv85OmewyiudPc2CjTosVEume758UY7Xh0zTMJA+k?=
 =?us-ascii?Q?qoCtsFPSMD92VFX6q69Bx5llw/tKQzf6cuqpfbqqQM6B/LGBLwXZ+IAuxs/V?=
 =?us-ascii?Q?T7cKUZbkJyGuMnduK1w7+1NEn5iudWOe5/Av9sJ5mUcsNtEhzKueUWYI4Iv3?=
 =?us-ascii?Q?0f8cxVsl11+DF2/o4JPPbt4AJoGHWKw3F+WJRhnSFfxnCA812kZ1phYwbA6h?=
 =?us-ascii?Q?oPicKLU20hnZR8s8MY2NPfzL0EHxC3sGZBPeBVOtTWBMuorA+oRQS7qEPlJZ?=
 =?us-ascii?Q?awKcNm3YFWGplRwjgYa1gmZljmOWVLp4LuA6cBD/U0b94jSxf58kcdHwGUW0?=
 =?us-ascii?Q?Bx/stdrPdP3srB3apXlz49Ufrbue7wpQDEC0k1xy4Q4tz19FXNAp591hUmx7?=
 =?us-ascii?Q?I3R4SIdVGdfwnSTQjlLejNIJirJ3Hr0+AAn8obZdwAEodOLcWZ8uKZrDexeI?=
 =?us-ascii?Q?BOL3SQDs9ynDydpiaGq+YFiMKtu9Popld5dlYL7dsgx0s8B49Fxhkehu3dZz?=
 =?us-ascii?Q?wF5ICAmQvkNwd15tD+vMFsQmGEDL7IKX4uEtlNrD9BsI0d/YOVoY3OtENH/Q?=
 =?us-ascii?Q?9sAgrRcQs0mx0yJzU7qmCri9tEEoPte83yIA+xoTegdeXDyPiqGDWsil+S7h?=
 =?us-ascii?Q?7NoH6G/11qv6MLu2H2pnjuc0gqwkEPcEu7ZHCgjPEuSeRS2eoxFEyg/dAeNR?=
 =?us-ascii?Q?otT3ln/R/OafEj1YZUck1no30OtT3QQskcWzq81LYiqlV81ktV0+hGWn/b5U?=
 =?us-ascii?Q?cUmn9Py5+d4Ueb1j5xAdrErb+fLRjJe8YxpDyjq/lJkixp6eV8F4VH7akCTL?=
 =?us-ascii?Q?g9sOMIPNHMnaSTrH//AGG9fJNK6AnI5lnzSw8Bdv7vQY+EdIvxKjezJWnJzf?=
 =?us-ascii?Q?9amYgKHWaY17l/tyFq6RQTGID99an7iKAJ5WZ4SBgQrnRbxyIFK+QK7JVIu/?=
 =?us-ascii?Q?L6LB9RU+5jbXZV4KDoq1WJUE1Tn4lNd1pTjGoV2g6Hc+0J4LKhnS8Eb9Ab6a?=
 =?us-ascii?Q?e0YKbGZpKLAacrY4hKx3mQSbKObyXTqZVBas5r696+K3rM1zJPfvo3Mx1qJ+?=
 =?us-ascii?Q?nLr1G3yY0gLGR5qQ03U3vnxEJ0zgap7Ixyb8mwYBS7HNBFNPIlhNlcXNW69M?=
 =?us-ascii?Q?d9HDI3OTAIfFK+CcmotgCWaDYAXnEglXs2xaIs4qgIR6YKiAd5W/DlFozQpy?=
 =?us-ascii?Q?zS4jN4jmLKT3l/TUZ3+bj/G/nPC/XEDOs7naebYrJJw3S0leZn2y+haoAL/3?=
 =?us-ascii?Q?KbaK7e2r4Imle5Kgv9Zd6SzfsfEgKBZzoriVcBf3PzazGh9lSAjybUiopVTe?=
 =?us-ascii?Q?joYqMxJsdy6/hhQhP3XNXVr3JAep5z2EX3mBoNWqAWMS6Ai/Jqg9EmDHblgA?=
 =?us-ascii?Q?27yq3H6QgGT/5qSBsugDGyVOpKMFXFZK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+U4XYZ1NZzcun84zbCxwQFYoD0aneFc7EzJGJKedevZyjLkRR11W5Fpefkv?=
 =?us-ascii?Q?K2StDoZpUvGVmQg6sB72Y4ViKF1q//5gyKqFueLTn2ulP2Dbb3qaOYW2EyA7?=
 =?us-ascii?Q?54XJRIdUzlBOlR04vl87GltGHZyCynQA1zl0n5fXrJwuklTqhmbwBwZcAFQG?=
 =?us-ascii?Q?WSwInBASoG5YxDXDmY/ksq74TzJsgiZ6fYsnwyBxIiFS/I/U0RnYetEbkaY4?=
 =?us-ascii?Q?eAYs+fUPhAoe4jNllOk7tomoa79mHq6wnm07Iix+K5sXr0K9r8IAol6Tycrk?=
 =?us-ascii?Q?A7uTxIXDRZmjem/nci1uNVm8VrTHvwAFHJKTrwQC0OQ8MRPL9DoP/81yrKNk?=
 =?us-ascii?Q?Zqlp2E21AhnM/4MGmpsjme1TS8YxXUzPi1JfZ7DVUrnwrPjRKk5xKYMOSdbC?=
 =?us-ascii?Q?zMG4AynILGSjT56q4DvAKJ7qddNnrCVUBbUwKqJl0do2/y6mIHfbTI+XpOfJ?=
 =?us-ascii?Q?GNiROJN/zQqEAL0wrPZhuE5ZjIlaNNkUfGrmuikS+zay6pGzXDPSVn/3eUQB?=
 =?us-ascii?Q?9GjTlo1zS1tgzgLTPdf6BEU4lShqKRpTEAC1Kh+ueWQnYhsFZ7mJVUxOdoQj?=
 =?us-ascii?Q?xgDbAYEHnKFU+6eog/o+8jwOsoXrxlz3Gtv2GW1rMzegQJdjDxhhrNcChb+w?=
 =?us-ascii?Q?34aOwBejKedO2Oqr2odZme4qqkantSBvaKyQQBXsMkOicgX41Co8R6khVQlS?=
 =?us-ascii?Q?7rvBtHCWDLgmioT4aVipMFhAOx5Z1CGicLtSdU5DovkVIocalTHS93sTYTIo?=
 =?us-ascii?Q?z5G1pJDcBSKu5N/4MZO5Yz0i1XlUu92JNvjpBDim6BD2vb0FQHLr3KVnAgsv?=
 =?us-ascii?Q?dplFMnXUTHbkbjpPEatZvK2mTW+t+qTdjivL4LUfmOnmZ5KI1QFGIGB6pmXL?=
 =?us-ascii?Q?4+Rm+/AC4Ayxnuf/EcyJI429TB0OHPVj+Ri/vCPADr+h/2Yw+QBq2oVQd4ch?=
 =?us-ascii?Q?ZjvCuZ5hZ1wC6T3rIKjf0LyJJIdVs2BE8NRg34FgL8NR9uN+YUn5Ojiue/+C?=
 =?us-ascii?Q?x3HsUT88GjPYVTaSqBBHywEYJaDRlFx1vwduaKaiQnvnyy7UzK1IjFrc85M9?=
 =?us-ascii?Q?bUYiREDud74CJiigb4KuBqS5xvz9QEivwCFcDXrYK25SKjFktPwtBrYqfGp5?=
 =?us-ascii?Q?I0C6gGFk8Tx2aS5Xi0bDngMRoOvCqDEgkflbDgKJhLW345/jSLhSmr36acu5?=
 =?us-ascii?Q?xFLHEhbiMBjcF0sBWwgNhKb0rFfQcIO3PyY3+pq10FcmfWHqynzk9ZWVsNd+?=
 =?us-ascii?Q?LXKUCekkydeZ8nIJSVsMBHqQzcW2w0EYI0iHjn8OYn41QnWRUcODyXtSkiVg?=
 =?us-ascii?Q?FBhzQHCt9fKc3I/Np1fVGkuBaUZg7//1FWVd1PimF2SX2XGbv6ogWn0jRp68?=
 =?us-ascii?Q?uGvaujJOtIAATRerkT8Eszz4m/sipfKmHGc4f5QlWcHsFUy15PZS5eZ1JS7H?=
 =?us-ascii?Q?rigOgCkfBDWs+30VOWi8DJ4Jo18oznKPeogoioFiwASXqWcL/OidV9M1gZuH?=
 =?us-ascii?Q?zXdjPitE2Ec1b7mFD0utL78e7POWSRGRzKi+BvBVyOVkr2AVPadwx8uThQSj?=
 =?us-ascii?Q?cUiGktzqN8/4Fbg/cSgVTLh2jtoO+CY8RfUzncidFWKG7GiaSPnY2bCC8yOt?=
 =?us-ascii?Q?R466e0XR5waaEmMj2Wrxci4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e12277-2772-41ed-1afa-08de3173c058
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:23:55.2178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBFJzu8ekPQxFvJzGbL/AKZ2bWb2iXlM1COsv7pcxYfoAN91pUdbw5WLAxOIljnzoxJPOa7KjTRyCXbe4RJTAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7356

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


