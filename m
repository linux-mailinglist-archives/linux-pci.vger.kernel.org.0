Return-Path: <linux-pci+bounces-6444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05EC8A9F80
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 18:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B04283421
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467B3171089;
	Thu, 18 Apr 2024 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Be8elzeC"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9916F8FF;
	Thu, 18 Apr 2024 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456301; cv=fail; b=ezzWITinSFVCO4jlxiZF3KYWiDzc3h8t0hg3d17lyp6Qso936BjHRi/KjCUncDzlD7lcV2PFGiy3vniEG5e2DlA3UMVyUHmlSKFW4XuigwsxjK0oI5R1dHCX0sxE75p7q/YdGgjajBIGO0xbLnIFjSdk/NRpisgydOnSSJ5yTxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456301; c=relaxed/simple;
	bh=Z1R7qi1P8tpG+wqfBqFnd3RzZIQbkAXoWFjXpkLP86U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SvHtyrt4wti8aZzs/7j8DNlwMTTtOfo16GgXn1JbjNYUfdr5n06CIMxnEJ6jeX5+3x2cdeTX9knbxFdg+8Mc9LoZ3M8wR2+0HoDuvVOooQeS+0qjc2sUzAjpkap8MkPpeyjhP3Eebs6Hi2ckrRMfS+NLMjVyPBzYscons0jdBvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Be8elzeC; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKpzCvWng8khDtIJS7PJ+/OuH4gDI8IA0XSFVzDG1Z7ZsIUHF4G6yuK1xGWRYavgw7ATlbMU830pt9tzXSndQc7QXwR9D75cuPi0nb/euyJYvQosAOiMdxhQmqsozw8V2IrvWD7LWPzCYpE5ycwh7npPGVq45QsuRzRYbiTvxwvj1dNGbQPC29/m/E8YlHtY2azYhZvu1ia2enncRxD0lg8H6GDZMlFNkFXVepO8qH+coxaWCQqrpQr0GrQMmOuZR2/mnhLRdpOLs4TbW/9VdZi+0t9kOwLgufvodKajFdTPZWHTeaeVXxSj1YzGBpfelr2qkJwwM4iTCIfylVfKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpPzzDR2t0W4uJFD/pHJufCGdd3ZJ8oAc5V/JrUqpWM=;
 b=jDUgFEHnepOv4h8vfNUNfX3Ebxb6cbBnEo2DbPjXJT9AfVb53i7BQ9j7iNJlqBhUB63BsBJkiVx5KooL/aHPff9z2qzBsaThdkOeJoGqJtXHtw1ZFnAWCAtxTRFffi1agrOryJbpRqTY4B4TFv9gC5DCGlNCab0nOkk1/oqFNGDZmeuUFi9G7MP4SJl12GsscCmQcFIE4DBp4twtBvl7r7qunujaU6XLJX4i9fpBCPxKDuK9Dan/xzVO71Gn6Tmny4i9sga+/YNMdOt75DaeeuPNMbUoJk8YVOhxBsw/tm0h2TfjHAlQuW5iVjmg2VL8N3uHDeYxr6fxcXNunrvK0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpPzzDR2t0W4uJFD/pHJufCGdd3ZJ8oAc5V/JrUqpWM=;
 b=Be8elzeC194vShIz7zo9YwheqWO8mm8AqE2F1u43G/iTEXvy2xmXr/MeLu3Q0YyteH/kfHP5YfwU1eOhiapTiY6B6phBqI+h/3I4N7Pra3QDfpEXLVe2uuCCKFbRyIRYII9dtu+shCZR8AlDNiRA0keh1iw4QdylruCgHGQhR4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 16:04:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:04:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:04:25 -0400
Subject: [PATCH v8 2/5] PCI: dwc: Consolidate args of
 dw_pcie_prog_outbound_atu() into a structure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pme_msg-v8-2-a54265c39742@nxp.com>
References: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>
In-Reply-To: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713456277; l=12761;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ub0sCY9OqWzN3Pm6SPBEwtB2z80F4sah7lj6v7E5fbk=;
 b=NSX2fxpG7ytfl2dnt9pZtQS3l/bQReS2GVX/l4LvUOioAr/Ul7pWwQE2yQHWuJ3Ixs1VQiKhy
 c0uK5giX3jEBSsPFLOPFViMdjQUj623v8enJYZNnMUT0OMvqu5AvxyA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0102.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: cf334512-6dbc-48a6-49a3-08dc5fc14648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wHTc0zjPajMDQ2QhEjr/IBvbgrYMj4w8ipZQaPNKe4DneXpKVDfnik9fpN3LgJmwvzxhdkMobZC3136LOgz2WGaFj+xCyjFvP8npgs4Ht8PCMdsPsMbPiTB70Zqv6mDOQLGCgAfJNvurjvX+o6QhTJfYR0WmLA3gX14+QxSeJPLTSzcxvic5cot3tiunZ3aCulT+BLi7UIaRcE69px6vJZWWHwxlTIaC9B5SvGQ4XVqFptVkFJg5LeNtbhlUi1I/TYh5mcReEriWxOmLnmDHPfNO6G1UlZGC0xhZgfFg3eUkDU8r9GILUIjOf7RejCCpmwrQZt9KX0sFdBDO5pVcMv6lU1fWfb4cd7y1RzZHfc5KBi6wbQOCx1fbBhT1VhsP7xaAxoj55bmQ15TgxglID1oBeLoTFUbYtLESq6ZoQwf3J46zQ0dZm/s7DArHSSq1w9XaKkFKmhY5+TaW89UmoZm+WTglQ700ITmhn/sfTFEzksYMMVIdjLZLJ3mbO0wBkK1QXzSp6wHcFgXn9JMZdO90ajfWUuD4xA9qUCh+hlA9gIMEqSEuuavzLPySSCu4Rjdf/rx1oW23E2gDJkQgBFF1s9or/wxnX+ulQeO+oQT99JoCLfqKeyI8DraNalxrIww2/Fq2+zIGHUll1TV1BItKzhyVR1ujUto2oYNe6xQe0zU93c3APARTGVyrrYcBpFscWpuKgIeI46Hfncix/NW/p722bOgIGNVAXpfri54=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnpLWXJkMXcvVk9TR1k3Sk56Q0NhVnVySWZXZU9BSnRTSUl2bUhicWdGUEps?=
 =?utf-8?B?bTV6dzBCZkYvN3FESkM2RXUzU1g3Tm5ra0pwTS9Fekp1d25LeG5vOVFRTjZO?=
 =?utf-8?B?U0pQSlVqd0dPMEEwQVA3ckJYYlE1Q09PajZ2U0x4N2FCT1lnekxmU3AxazNM?=
 =?utf-8?B?RFN0cHBTT2NuN2s0YnZWV05mdFlOakRPcEJTZ2FQRnB3dHdQbUs3dEcvVHFS?=
 =?utf-8?B?UjlGTmRUZURvYlh6U3FiUTRoUmV2WndSNWM0WGVQdkloS3BnTGZ5Q2dvbUN5?=
 =?utf-8?B?SVU5VVR5ZEdFY3BCT0NuUmQ1bTZoU09mUFdmdStHeERMK0tMMHlvZ2Y1aW94?=
 =?utf-8?B?alo3SThRQ1FyWUsveWhadVhQQTl1WVRwWG1UaVN1a29VZnRiSlF0aHFCRFFO?=
 =?utf-8?B?QnI1VlVhcHNCTmx6akJQWExwM1AzMlZSQ0tFbTB0aFhBQWtIN1Q0aEt4Z0Yw?=
 =?utf-8?B?bmxxWk9iNzVhNEl3R29LdlJXQk5DUWlZWmxYZXlxT0czZ01qalRPUjIzUEda?=
 =?utf-8?B?bFJPNlRLM0ZMZHFPSmNVZldiTXN5SGgyOFJoeGhzcW1VS2FZN3ZqckVMSm1C?=
 =?utf-8?B?c3RDV0ltYVFqeUxPd0Y4K1ZFUFJKMkhqcVlRY2k3cGxwOTU2aWpHQnU1QTB6?=
 =?utf-8?B?SkorRk1nbm82czIrOXgzSmFDd3U0bURmRllNWU41cUFLTEpTUWM0WjB0YjQ0?=
 =?utf-8?B?bjNUYjlMb1d4SnNnbFpDTE82QXhxUmpMTndCVSswSzF6emZ4eWQrNk5UdkUr?=
 =?utf-8?B?ak4xeVhjbmN6SzJaWGVRK2ZZd2U3bGNGQ0YxempLRVYwN3Mxb0hiTGJ4QmRX?=
 =?utf-8?B?RzJ1R3F1dkdkWEdLbWp5aTFUK2hGWjNXUVZ3dTdIZHRKanl2TVc3RmwxcHhw?=
 =?utf-8?B?Q0YvTlVySEx0emR1a1FyaURJREpvenZDbERXMSt4U0JqZFVJbDBucTF3MXdJ?=
 =?utf-8?B?QzV4N3daRk5MeVFkTmZ4MzlpYVBwTDg4QWZYM3VIN1dXSyt1Q05XWTZMMU40?=
 =?utf-8?B?WXRMbm41TDVVeGJSN1RrTW0waGZvd3ZOV2RRcnkvT1J0cGI1MWtVT00zL2Uw?=
 =?utf-8?B?R1lMeDg4L1BUamN0RGF3eVl5RnNOc1JOUUlvdnJxMllYZForQWt2ZmJqakdW?=
 =?utf-8?B?aFg3VGlnV09SbkhNeTdmdEU0dXROYk1vQ1l1TklaV3BOZzV3UDMzMjVJSzF1?=
 =?utf-8?B?ZkVyT0hab084bnRTVXpKekUrQWpCTmpSeEQwVjJNOVZYSjcyOEp3blFkdTBP?=
 =?utf-8?B?bTVDSWNCdTZ3NnIvRkhiRDB3VDU0cHNINXRmWkJ5TXFsZG1RNmtUd2FwMXUy?=
 =?utf-8?B?SmpBVDNmWlpSa0JKcXNUZkRlSUh0Tjh1RTVVTm5jSkhWdytTVFlab01IaEgr?=
 =?utf-8?B?SHhtNThLMXAxQmhFekZNNlhMUmVkakM5QlpqaHlyVFcwcndFNlNzM21yUSt6?=
 =?utf-8?B?aHlmc0FSb0F0bzRXQUdTRlltQVViNUlXVlFGK3J0dmRMUkh0SjFPN0RYelhn?=
 =?utf-8?B?TEUyb25qZmtBc1ZtWDd0dWs0NFdndVVIR05NbHBXRGdwRm54QWNSazRNZVZw?=
 =?utf-8?B?RGw1OFJqTCtrbmRiQUVoeGtGcWVqVFFUc0FYZUxZTjR4Rzl5bGVCVk12YWFD?=
 =?utf-8?B?NzVpZS9yV3IyYzVPSGcyU01XdHo5TEFMemtwd1AxZkVxV3NkMXZTSExJQmVn?=
 =?utf-8?B?ZTBOV3kyWXVIM0Y4NDFXL3VkZzNKYnAwSVJHUzhCN0RoQXVHc0Z4TmRLVHhQ?=
 =?utf-8?B?ZUF4LzBWWktJdmd5RWJHWmVMTjJsVXM5MmVmRmJDM3VQbWdzWWJxY2owbVdq?=
 =?utf-8?B?SEZPMnlxaG0zUHdTOXpxMHNUcmdHRkkrclM3a2lZVExqWmFJbFRtdm9vVGZP?=
 =?utf-8?B?VEJJcFBRWWs5aFdGU0F6K3dlU0dRWTZtQ1luTm15U2JVeGlOcXVuVWovZjhl?=
 =?utf-8?B?Z28xdUN5RVpCbVV0M3ROb2l5cldxMEhWdlF4eEp0Q1hCaVJyMUhtaVJTSW9x?=
 =?utf-8?B?WGFydDlsays5b1lkMEZmRFE4cmtCdzBnUHhqYlJCekIyN2ZMaStGMkRvRDhJ?=
 =?utf-8?B?V2c4MFJTemtxSjZTVFdXYXQrSWVEMGsyUm11S0NmRUNTclpSOGdjeFBKMmtS?=
 =?utf-8?Q?twyvGcB94b517kbsas5CE4Flo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf334512-6dbc-48a6-49a3-08dc5fc14648
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:04:49.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QSEAG5SqEg6Lv9aTUpF10Xo4GB+RYVEDEfG3IhBovMZU//pPulVhpovsOwaLlhKDRl7jRplnat3PzSIuYWTcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9405

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This is a preparation before adding the Msg-type outbound iATU
mapping. The respective update will require two more arguments added
to __dw_pcie_prog_outbound_atu(). That will make the already
complicated function prototype even more hard to comprehend accepting
_eight_ arguments. In order to prevent that and keep the code
more-or-less readable all the outbound iATU-related arguments are
moved to the new config-structure: struct dw_pcie_ob_atu_cfg pointer
to which shall be passed to dw_pcie_prog_outbound_atu(). The structure
is supposed to be locally defined and populated with the outbound iATU
settings implied by the caller context.

As a result of the denoted change there is no longer need in having
the two distinctive methods for the Host and End-point outbound iATU
setups since the corresponding code can directly call the
dw_pcie_prog_outbound_atu() method with the config-structure
populated. Thus dw_pcie_prog_ep_outbound_atu() is dropped.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 21 +++++----
 drivers/pci/controller/dwc/pcie-designware-host.c | 52 ++++++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.c      | 49 ++++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h      | 15 +++++--
 4 files changed, 77 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 746a11dcb67f1..9dd6a2edc7ae5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -160,9 +160,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	return 0;
 }
 
-static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
-				   phys_addr_t phys_addr,
-				   u64 pci_addr, size_t size)
+static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
+				   struct dw_pcie_ob_atu_cfg *atu)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	u32 free_win;
@@ -174,13 +173,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 		return -EINVAL;
 	}
 
-	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
-					   phys_addr, pci_addr, size);
+	atu->index = free_win;
+	ret = dw_pcie_prog_outbound_atu(pci, atu);
 	if (ret)
 		return ret;
 
 	set_bit(free_win, ep->ob_window_map);
-	ep->outbound_addr[free_win] = phys_addr;
+	ep->outbound_addr[free_win] = atu->cpu_addr;
 
 	return 0;
 }
@@ -280,8 +279,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	int ret;
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-
-	ret = dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
+
+	atu.func_no = func_no;
+	atu.type = PCIE_ATU_TYPE_MEM;
+	atu.cpu_addr = addr;
+	atu.pci_addr = pci_addr;
+	atu.size = size;
+	ret = dw_pcie_ep_outbound_atu(ep, &atu);
 	if (ret) {
 		dev_err(pci->dev, "Failed to enable address\n");
 		return ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d15a5c2d5b480..3a9cb4be22ab2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -554,6 +554,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int type, ret;
 	u32 busdev;
 
@@ -576,8 +577,12 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 	else
 		type = PCIE_ATU_TYPE_CFG1;
 
-	ret = dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev,
-					pp->cfg0_size);
+	atu.type = type;
+	atu.cpu_addr = pp->cfg0_base;
+	atu.pci_addr = busdev;
+	atu.size = pp->cfg0_size;
+
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
 		return NULL;
 
@@ -589,6 +594,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_read(bus, devfn, where, size, val);
@@ -596,9 +602,12 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
-						pp->io_base, pp->io_bus_addr,
-						pp->io_size);
+		atu.type = PCIE_ATU_TYPE_IO;
+		atu.cpu_addr = pp->io_base;
+		atu.pci_addr = pp->io_bus_addr;
+		atu.size = pp->io_size;
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret)
 			return PCIBIOS_SET_FAILED;
 	}
@@ -611,6 +620,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_write(bus, devfn, where, size, val);
@@ -618,9 +628,12 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
-						pp->io_base, pp->io_bus_addr,
-						pp->io_size);
+		atu.type = PCIE_ATU_TYPE_IO;
+		atu.cpu_addr = pp->io_base;
+		atu.pci_addr = pp->io_bus_addr;
+		atu.size = pp->io_size;
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret)
 			return PCIBIOS_SET_FAILED;
 	}
@@ -655,6 +668,7 @@ static struct pci_ops dw_pcie_ops = {
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	struct resource_entry *entry;
 	int i, ret;
 
@@ -682,10 +696,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows <= ++i)
 			break;
 
-		ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
-						entry->res->start,
-						entry->res->start - entry->offset,
-						resource_size(entry->res));
+		atu.index = i;
+		atu.type = PCIE_ATU_TYPE_MEM;
+		atu.cpu_addr = entry->res->start;
+		atu.pci_addr = entry->res->start - entry->offset;
+		atu.size = resource_size(entry->res);
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret) {
 			dev_err(pci->dev, "Failed to set MEM range %pr\n",
 				entry->res);
@@ -695,10 +712,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 	if (pp->io_size) {
 		if (pci->num_ob_windows > ++i) {
-			ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
-							pp->io_base,
-							pp->io_bus_addr,
-							pp->io_size);
+			atu.index = i;
+			atu.type = PCIE_ATU_TYPE_IO;
+			atu.cpu_addr = pp->io_base;
+			atu.pci_addr = pp->io_bus_addr;
+			atu.size = pp->io_size;
+
+			ret = dw_pcie_prog_outbound_atu(pci, &atu);
 			if (ret) {
 				dev_err(pci->dev, "Failed to set IO range %pr\n",
 					entry->res);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b858..df2575ec5f44c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -465,56 +465,56 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 	return val | PCIE_ATU_TD;
 }
 
-static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
-				       int index, int type, u64 cpu_addr,
-				       u64 pci_addr, u64 size)
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
+			      const struct dw_pcie_ob_atu_cfg *atu)
 {
+	u64 cpu_addr = atu->cpu_addr;
 	u32 retries, val;
 	u64 limit_addr;
 
 	if (pci->ops && pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
 
-	limit_addr = cpu_addr + size - 1;
+	limit_addr = cpu_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
 	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
-	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
+	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
 		return -EINVAL;
 	}
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
 			      lower_32_bits(cpu_addr));
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
 			      upper_32_bits(cpu_addr));
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
 			      lower_32_bits(limit_addr));
 	if (dw_pcie_ver_is_ge(pci, 460A))
-		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
+		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
 				      upper_32_bits(limit_addr));
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(pci_addr));
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(pci_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
+			      lower_32_bits(atu->pci_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
+			      upper_32_bits(atu->pci_addr));
 
-	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
 	if (dw_pcie_ver_is(pci, 490A))
 		val = dw_pcie_enable_ecrc(val);
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
+		val = dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2);
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
@@ -526,21 +526,6 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 	return -ETIMEDOUT;
 }
 
-int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			      u64 cpu_addr, u64 pci_addr, u64 size)
-{
-	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
-					   cpu_addr, pci_addr, size);
-}
-
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr,
-				 u64 size)
-{
-	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
-					   cpu_addr, pci_addr, size);
-}
-
 static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae48374627..d21db82e586d5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -299,6 +299,15 @@ enum dw_pcie_ltssm {
 	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
 };
 
+struct dw_pcie_ob_atu_cfg {
+	int index;
+	int type;
+	u8 func_no;
+	u64 cpu_addr;
+	u64 pci_addr;
+	u64 size;
+};
+
 struct dw_pcie_host_ops {
 	int (*init)(struct dw_pcie_rp *pp);
 	void (*deinit)(struct dw_pcie_rp *pp);
@@ -434,10 +443,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
-int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			      u64 cpu_addr, u64 pci_addr, u64 size);
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
+			      const struct dw_pcie_ob_atu_cfg *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 			     u64 cpu_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,

-- 
2.34.1


