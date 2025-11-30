Return-Path: <linux-pci+bounces-42331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E6EC95106
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 16:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D63494E215E
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56F287253;
	Sun, 30 Nov 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WH+DbRxA"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011035.outbound.protection.outlook.com [40.107.74.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64D92848BE;
	Sun, 30 Nov 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515479; cv=fail; b=s1FQwK4+uF8MU6EMCHzzlpmcS14MXVjQotsQQwbj69k63eSu21pQJ9tjPFpmnHcOXJoohBnF24NAKVPqc0NsZHDbpWmmVlbah4QRDRtoX0FvSnxFPuVN/ZQb1L/eSvBFugHhefTEnQ8xOP9+h5U8WDrNsU0hFJ/jK6SxNVEPocw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515479; c=relaxed/simple;
	bh=uzid1QV1XJC1GmqV47rbqHFWIolix5fhpM9QQZi9sHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M6gqY+t3py7IoAT9KMVPXKeVrp/q0EunPuC/sFaJ+6RIV0NuNBwTiMu2yYLjHaTia+nbFPmQEqDG865JNjlrorkIX+8fax6SD1AP1UqCkpEYQqwiFJQR/Vb9FxMgswsjRKVcz2/2QlfmCveO2Uwr7YIXPArnmULN9q+kdvtAff0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WH+DbRxA; arc=fail smtp.client-ip=40.107.74.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmOaCwpbn+klYv+Z7BioVWzHSyosfw11uN9OSe7OeBKWwec2PLwlJqkmj5DfcR7G9H5wPXDiXlue/pvzcxS63HrcD0xrovxoPizU/Igya7gbLfOBZXfCQRtbmszWDNL9DUYRsKKABTAprR+jWtvo9SK6TA7RRFEhKFMu6oU2DLgRdL6pVrO6phuoujYl8t8D8piN9IsUP2oPD5GsShQ1stFLHQNjp7kCex8xG4ugW3Pad6pW7EzgglP1accS9U9avtxxh4MYBRPJ5bVgcB8ujdSpb+7dPz7uTS91J73eJRATl2Vdb1DcIok8bnFb/sN7k63+sg8/WqT48NW0f11TQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K0QQwb53P5cZecHOtS9esSM/n+3CJ1HinO8/AkO2dg=;
 b=dzXGylWeSPbPhFEMIYyDjFr088JaXLJvNmdDX1k1u3onCoPaLle1r65Qn9l16a1qlgFtDzYQ9XYTBXnCwcsXt7kvxaY/k4ZhdGAI0eQfgEHTd4UxTb92D2V7aCTNtu1DHafkNZt4c+uGQbxMXTrXDQBXzQ+e6/2cBVgn7ysJaokiO0DfFg7YiTgwp2ZMyZeUq7lJpQsx4FE7v20+wHgfnM5H2w0NJqo8zbRPZpSklrMx9fZBvSsnEYrZ3g1/VQoEK6OPqtmdP3u8bMML7pRea9m+c2+ghKXPeSgqwe23egd6SxsuBqLKgChh9I1hwrtIJSgRJCy6He1gJoNQk9dC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K0QQwb53P5cZecHOtS9esSM/n+3CJ1HinO8/AkO2dg=;
 b=WH+DbRxAQNfGzeXAW62QnzatXNNYwdzKId7kjzB/G/UrHwqTKP0OFSB7BYBk8Nh/5TV27fxw3J3Gs/2fbeQm826qaxjUXflEk5V/yy5bNT8IcHN9KSxyRhBvdae30MfBW4re9MPcG6ITnWrOnM5Ck2IVPBntPEz2kQWs8tZ+pdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB3865.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 15:11:10 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 15:11:10 +0000
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
Subject: [PATCH v3 5/7] NTB: epf: vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
Date: Mon,  1 Dec 2025 00:10:58 +0900
Message-ID: <20251130151100.2591822-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251130151100.2591822-1-den@valinux.co.jp>
References: <20251130151100.2591822-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::16) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: 80eb260c-b69f-41b4-a3c3-08de3022b1e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CWAUc4xXkzzDOUGEoxZV6SHeWKj5HOD7WjT+JNfmXLVCYdOO7Q8E0llN2g4q?=
 =?us-ascii?Q?rJ8zs2zvGMGiNMGcOnMmPQWwwWV1/pm1JGyyxhln/WnM/sUHxLjktq0DXdkZ?=
 =?us-ascii?Q?/GX25VpvQXWNH1/WbgEm4gwThHUaCBC770gbpacobPj/tV3PGEUxhaI0pFQX?=
 =?us-ascii?Q?v93I4nEzMzS7DZNLil1mIev6rQ/KdDwSYQ6aCx8E5ejkLizHXFiCqbNvwFtV?=
 =?us-ascii?Q?XxarUkuK4eKm3sAZLl4DeqnPsum7+qSoKuQjw1+HzI8IKdOhwWsyWBdzy+9f?=
 =?us-ascii?Q?/Fj3tdLpWyjVwoPQlR0TyS44WCmlYXnv5us/FmPKyt3MnA0zKVzxKenSexu7?=
 =?us-ascii?Q?lvRHtCwJpsmJvL//KurN+8CjJtLKCDerTIbxWd9SgzBKNaoeXDJUa0TklLM2?=
 =?us-ascii?Q?fr3+lhVMiACSPoehe2ijO5iQ8AlyCPy3Ylzq7+awXvVFFanZRGHY/1Bz0da5?=
 =?us-ascii?Q?1Dh2LjWD9Zw02XgceXuECjtfE7TkiqEHUxo69W9m885sS/lAZBOZL/WvdE+x?=
 =?us-ascii?Q?MDLkxW3LznR6EW3Tje7tPy1WLpqAgycYfftMecW8dYRuPp3t3YzDKZRnljxT?=
 =?us-ascii?Q?76g8GPhblXv9VoWTuigHrdyWcZ20ELRdeWoqBwABW/+ZoboMQSsjFhUlk8Tk?=
 =?us-ascii?Q?fRjx/faZxVWq3p74c47Av5I7/IxWjn/gxT76X7C0pxT6/tu+1lAsKgXrixW0?=
 =?us-ascii?Q?yJXdOCp8vbDpBN+bgPsqBkeXw789W9RrRYxArOuvtrOCCf4bLoMllSBSVAj2?=
 =?us-ascii?Q?jp59su8rGqYXUkHSuJLVkjE80bMGNQB+Rldsm6hVBoE3athiT/5FXww4m28X?=
 =?us-ascii?Q?s/Fguap6FWBrLu1cyNSqQsnjsLRW5McaWQ3VbPijyApKst2qeOdD4zN51x0r?=
 =?us-ascii?Q?xQwJb4k8nK8xbCeFV1LBWd2lxMYBNwbP6U557Ju7rVllXm3eFfMJNHR8buuv?=
 =?us-ascii?Q?y5u3UQKaJFs0z0Qn3aid8y4BWrY72/ebCAMGRoxOA6NiacsnIv3xuse3WZQ4?=
 =?us-ascii?Q?7lptcmYr7rJP27EFgW6YvcVt5kKQyB9hZJijnO1zyRtwfnPK76swsiG/dd/P?=
 =?us-ascii?Q?3XpQmBh7J3PWL/7ZoInYA9mE801BOdzfTmPKnPkou77xSAmRkjkBhx4t6lZ0?=
 =?us-ascii?Q?zWuV5EJjf1BWt5dONHUkWk9hn9bdczyWvYa1tKvQO2yay6nnjEsZ2S9D0VzL?=
 =?us-ascii?Q?XfaRYV2UMeRUfDNQPdCqlRVhRT3Y3SzHdDwLEuivxvUBNAAsSMC6NX7Dnl6P?=
 =?us-ascii?Q?IGDyISK/MSbIPmqG/ai1GJI3wJS8ZJSE4Mncbd8/dqar8KEAIRbjEOiLklR1?=
 =?us-ascii?Q?gj7E6qQPHKQRJc49Y1osOxN0ujDf8glg/l3bOHE1SIF5+YiwTkM3s4xzT1IK?=
 =?us-ascii?Q?Tm0WjIy8x57xThV0xvEMU9SgAC7boCWQHxtJP6EheESYIDVrCTa3UiCPtetX?=
 =?us-ascii?Q?In2wHrtdyry6na1XGjn5ipTWcbvrM8JN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KsBbsS0tU/v5Rf5SAqt20UGoNYhwgmS+HaX6qYAiP49AH9c61IGR61l8jtDg?=
 =?us-ascii?Q?06fNG6dR/tZdo9UkzMA9WP4aq8Ii++tk999nwRiUscfReBo2NAEE1X17Ah1o?=
 =?us-ascii?Q?oGUx9gvlc2fmRQl6XEUZE0GF64Kbn5sBSXJH0ZCa4WgGqP98/bYBXQS7/CWm?=
 =?us-ascii?Q?R6K2Gu3GL5P/AmsBVzeDNKXwqii5W6Nha5dDtVghQ2fG75qHD1i+vtxLXGwt?=
 =?us-ascii?Q?E/61KZzBvgwaZaJrbl3NCf3ZWJvtb1Y7PWJby4nCb5HZRY0OwUzuURBTyELX?=
 =?us-ascii?Q?6DmcvDx9IuQDC6jQ6mdDZsba0M9QGvwyHDL97+dnzTeUpHjZGTsM7OSYevGW?=
 =?us-ascii?Q?/Pmc3LS+x7ey5nxu68Al5e/W8tOijKnVUSUtfparvC6xTfLIMCs2UFnkmV9P?=
 =?us-ascii?Q?FRnqMntjMbf/6AtO8D6UxS1BSWe43YEHC3J4ZA+dBqdNxElDzL1DpmW4A5gm?=
 =?us-ascii?Q?KR1h7564X48zJdOlHqey0VsB7SBWB0hJdFkQkTiQTJzVqD+N/MIY4nVsyrx2?=
 =?us-ascii?Q?o3bKutwEMb3M6CEdDWS23lMVAw1I/S9MT3+5B79fWWwlSDVxZg0rS/eWmQoE?=
 =?us-ascii?Q?ZpUQZDEygwuRiU2njP3ARfS2bcy5zcZQISgqnACJ2DJ9fkmosro6Lr+vt/pw?=
 =?us-ascii?Q?TBH1RXnGH4ODtpr7e3T4VHP8Hl+9EBghOM42Kp62fF5KKfS15+IyvE1Q9ofU?=
 =?us-ascii?Q?NcddwqT7QFh0TbVK3qIwoREVi/V9JmaX30H3Mk316cctPmGszrWavJNUY8ge?=
 =?us-ascii?Q?m13o+VFqL9bJ88Qw2XbEH5bnot6fj5Urhirc6cG5XWPTbCRGE8UPzLIOFNp+?=
 =?us-ascii?Q?ovdcqoELGb366MumLZPso2FnxiD/SRAEhKXvTAEfm+hUEa37G1sPquxnqDWL?=
 =?us-ascii?Q?JyLGyYDamw0ht02FsncvZUB/0TMl3CepxSfRXV3WB8qrABF12vF0A3bTlL84?=
 =?us-ascii?Q?ousM0cnUlq0Y7ZwGn3Q/W8T18HY0r1iN0Fi6bbb4NIZSczfNvircHjBpCQXh?=
 =?us-ascii?Q?iTbX5/ojTU19GMZCrHbOp/srpoVDGNoEFqAm+rHkKDsZaVYPUYyIfEJ7Hukz?=
 =?us-ascii?Q?TBc2pYYz0eVgzWeafM4l4YV0ghDvKiFI+abMG8iBCxzNMYq51rmeLGUkdfOo?=
 =?us-ascii?Q?YoUr6KvNz1RiB7c94XCczU1Ca2xpJmgYyRHT0JnBByPD+inZaDZ0t8lpXWu8?=
 =?us-ascii?Q?Lq/L/ty2z7vetEyxq5w/gDoHvowA0UY1wjXhQXyjOetUwrQQlwW7shEMB8m9?=
 =?us-ascii?Q?0KtVrgFgct/QPZAkQga529LBdF6slht3NasbR6U/8MxFQ9aa7A4x3K7F9IDT?=
 =?us-ascii?Q?bLIqSnpx21qq2V2aPYEvQBbEfL+ZLfW9r10vhElo3XqkT2TR1HrHP5PZ56hu?=
 =?us-ascii?Q?2Fc2eYiAnzgDRewjWDnTNL3/y95a+eW8VLOfwDYuBa3yWdb27Xeu1Wp13MrT?=
 =?us-ascii?Q?Y8jyw9kSMrZ+/Tth7W9z6bqcwOI8HTDQvZ8BGOYRAQK/wwkJZCejacrr7xY0?=
 =?us-ascii?Q?A5x0pEBnmq7FBwMH4gRivPORXmcS9QmKX/W/nuxZrYMyLpLvDnLZy6cn7QtR?=
 =?us-ascii?Q?S+kefFqp2iXVN0i9NyZEp0Ux8wKUtIQxiOm4vhCwmboKO9PV0e835hKmoC0h?=
 =?us-ascii?Q?vlbJuUwoFoWzAWrt15Jef/4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 80eb260c-b69f-41b4-a3c3-08de3022b1e7
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 15:11:10.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzcO4rijItEf6iuTEFkdtBynhWZ7NyuEjkeTVhO61K8Emp3iDIYuM7wLZYzeHyzamgFp62hBP2aTrC+sFOxxrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3865

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


