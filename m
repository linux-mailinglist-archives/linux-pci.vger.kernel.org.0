Return-Path: <linux-pci+bounces-38118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C67BDC447
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 05:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7D1188D9BA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 03:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3722DECA0;
	Wed, 15 Oct 2025 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S+zQyYC3"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AC9273D9A;
	Wed, 15 Oct 2025 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497560; cv=fail; b=RstlrD+NLFPOgLpG7cH48OIyh7TWtWd8OVYmY1mrTACJfj7fcMvssE2LHbeE1D6TtREg8LTvrgxvgRtaYfgIKzLyJL/qcckyT1VuvcQew3Eu4pde43ZcipbmT0KtNVS1hn2dnBUGtb/k/Pd5lU6C14HqhPjXqo/9G+EKEX/hLWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497560; c=relaxed/simple;
	bh=IJus+Baj58O8d5tHY7kNuu7P+btrDy8i+A6EZyzwki4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Th4C88zuXujDtj4VwRC9S9RvrIixr8Pc8XxBNueIwXOtr3uWxNMGwHXfB32j+pL+sxtNdzZkyf8kOSl8QYPSXBLdOr1vwZKiqD3VRHfTfE05S6BeMEWAH5oKtbNhIaYs6mA8eGHuq/aMdps7hrrb43mIzV87zBDzbPzwS7Rc04Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S+zQyYC3; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9dBXjAPmv5i3tKGR1fTWFqUkAGgmDgjhHB/lX+vNErsrxlRevRiuJoSxI4u9f/Vi6ozJ9vjV93YzTYFjiStzI74Vf/HtVz+3pCuH0OcLjPyhE3oHK4CyLpcfP/ZYf4NUjnG4wVZSCqDLyd1X/EfGYHHR00+YWHtkNpw97CanqIS5wBrP6n0gD9kb4NYFHFFiFvSnX5byjQnpVCU0QzIxo/fDI5YzDb7Q4H/klW6uCEndXpeKMLlxiVWDirqrA4O4qaYi+9EGQ+r/tZWQ9x6MFBO30LDTEe1tpL4iHVUAMaQyethNRC5Iv8PBQ0gVFLVkn6ey+EfQvWRjqZMYtfkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PK3wBlqvEztj9KrIxpzU29GmC/F9HkpH1J4KlZi6O0=;
 b=dulA0FxFdIKt3qn7ULf3Xd+IWLI8xwY7nm4JDM1yCBUOtxDKNYNRv8qdV3SwbGhuiESv7YIyeE9/Ggtdzda78rFBP1k5DoMopQP6auDMdsyTkBBYquFwei0ahxTjeqxXQVSeV89tBVWcUR18mA2To/nS1y1K2Y5SbnGu7eBskvi2SEkHF8BffLUVgkIR4pjXDmB4WaghBjna8mMZ1HUA9QMrkH5yceQexhnHLtdNC9277+UK26HYdtpPHLtJxpJamhRtQF9YtEMyo3CeJU1qomeKdQ5vBumtEWK9rlDgmd7GFcIRuK/iItYL/e5WTXlgNbK4T2x0pnByNrtMjpQ0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PK3wBlqvEztj9KrIxpzU29GmC/F9HkpH1J4KlZi6O0=;
 b=S+zQyYC3EWISfC+JVPo68X1obW257RUHhuP2WacpIj+qA8LysU/Ui3kOR0eUq0DW8ZpzjXz5/882kZB/sqPIBGaD0SJC+kyaWes+yAXCRdcrpaV9z+X6cwzX7OtnfiHs9FWOiw0wYXciKdMnJPiDz/je784GsORm3XcVsQ2wDNw4U0aSwC4lN6gKlIlEHcO0sxkwcvBhq0mLkidfR/9NdW8OHBR8QRb66e6XBCko0bL5MonmhJ08cZyz6z3YROURsP+5m03fK/luN/dirfi2PaLE5QHYYLH+s3v+9iORPtRAKAVfDGi4mIzybIcElkutPi2G7FD16oktt3fSdLNJzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by VI1PR04MB7006.eurprd04.prod.outlook.com (2603:10a6:803:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 15 Oct
 2025 03:05:55 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 03:05:55 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v6 09/11] PCI: imx6: Add a new imx8mm_pcie_clkreq_override() for i.MX8M PCIes
Date: Wed, 15 Oct 2025 11:04:26 +0800
Message-Id: <20251015030428.2980427-10-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU2PR04MB8840.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|VI1PR04MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: f9442afa-4452-4692-1d9c-08de0b97c1a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pzkan4OQvKPacaj7dogKAHoNy/MeApyMbJOR7QhWCiNLJSo2ERRn1ZWMlNut?=
 =?us-ascii?Q?F60Rt9kX+nkqtO3IW3NLqR8rExur3LHkc3I4HfuIChDmLCBSWgoaoG7KixcZ?=
 =?us-ascii?Q?XTYu9puUTq4ZPceIKa1GFeZTEobSWi8ZDyZ5C9EmFoDiLxFvqUisa2iYGfYO?=
 =?us-ascii?Q?QX0G6EvzmohIwpFmIHGtPe4ONBvSLDC4BgAorEmQlFMMClUUV6vST+iuxL10?=
 =?us-ascii?Q?aT+0z/u2DZiUPMArbkeSwjfiiO7FvInI7bNI8RShfmsUItD8XQhfIMm6aA7P?=
 =?us-ascii?Q?tWCgeJU3XWe1IJtEWv+fkL8KKy0bCXmML5UAka1Yu16CBD6Gzuxrnf/WZLS2?=
 =?us-ascii?Q?w6JzrgVG2QojdTpVHqBFON3xBwU0gHjin3oUrQNSMUTDfSKFj6e/4lD5aj1Z?=
 =?us-ascii?Q?uQsSmnVnN3fpGya3I1Vv/fi3WWQ008iwsPZbdETnpyRnC7I99XiCwXtKoJf0?=
 =?us-ascii?Q?6LT8/xr4CPNGlX4p0zPv/6E3niwOqS2hZk7vy9lh5EFcl5q2mmy1NFQTonmB?=
 =?us-ascii?Q?M+cSDKUV+N1GXBERSnqlN3+aeg73C+ueJ6KwNah33hPn4gDSTowknPvoJ2Kf?=
 =?us-ascii?Q?ALEAof/p4MUQPKvDaY5d1rOguHzYDR10cGiIRKw3Pd8abhSPLtknnMyVstBx?=
 =?us-ascii?Q?n0Wi6MlbOsD5eBFCB5XssuqHVoTZsRzx+i3q+Aq3HEDaCvnCy8H0ok85EgEH?=
 =?us-ascii?Q?m+5tNdafU7GnGaLrwmmCUhFOwTp01G7TY2cb3tdGiz6tUvtRR4JFOdQ7RtXC?=
 =?us-ascii?Q?tJF0BdT4ngQSJRYGfNZnT9kr+1FIHrzdfPkPl6x+8uY7RhhdgjgyPmhS4O4j?=
 =?us-ascii?Q?wXhYBVKorkJxTsZsm5y9zlJpqyXBsVbx8M5S5ZZHOI0t/ss78fQyWLBrojyn?=
 =?us-ascii?Q?z9Wbb6S/z5EbH8xgacRnlITEe976Q61DSL8FEUySdJYuzxqJgS430Oy9PyY7?=
 =?us-ascii?Q?CdsPG9tkPgwENCmXc7fnXIlDmQA9O02jPBB/dIXYbIbVWswdZ7Bvr8iRnCkH?=
 =?us-ascii?Q?0RanFDFNS68Q2gySBoOtwgApIL4l+xposGp1OJgoSVbe6K5jHY8JEdZ8utM+?=
 =?us-ascii?Q?t+WbhBFpOIAtw+owz0iVJCBH86kHyL8vtZSNTHgNbl8BBf2az6oD6b4GM8aK?=
 =?us-ascii?Q?ca5qJjCc7/GAP2WCybSIpGDILRJBDKHtmSZCny8DjLhKNVLnkClxNGffqZqZ?=
 =?us-ascii?Q?trWT/xjA/BtG3EZrZ/KsJ5DxXxzY+0E6HDShOIir8QH5dZ6U0qNhCj6NOtgU?=
 =?us-ascii?Q?eJm4c3qteMP+TQeaz60L86tMOttH2Jf/aFFrd81O3zlYuD/ZLJSasEHn0CCw?=
 =?us-ascii?Q?ebmTKFl3JUQ3NBj5h+tFUzISb/NKneJ7mEKWDOVl2/Vd50lWpPJCPvPuleRp?=
 =?us-ascii?Q?SZou3Y1IVlKUjQS59ot1xbkLNSDvp189lFoV2vILOeHJl7Tq0m12MbzrRfMc?=
 =?us-ascii?Q?3fcm0YJArZr9VDKx1+8gU2ohz+AUmkocF9z2tKN1m5Jn8vgVlAmSfNerdZeH?=
 =?us-ascii?Q?Rj3nqJGaw9TNsETcQPftVQ2XUeXfEYM+2C2UrEPDqXkp52AU98XxOOLdcg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pDmQ16EY9JGL26O7MEnhniQ4hhYE3xsNQQZSRk4iNoJXaCG95Rb5d79hOKFS?=
 =?us-ascii?Q?AMdjl1RuQ3Kmh3INxv3R4XMDTIHGiFpL3uUqKIIMutzQQpjIzHBZXlNzf6+w?=
 =?us-ascii?Q?qDs6UHbyDz48wxSayF6t1My20a7sFTo812DcJJPrVc+MK/GJQRR+oaKmJFe8?=
 =?us-ascii?Q?AILF5DEeQaZR299JVEcC2LqqmVT4yRucq634ICuI7m1JrTUWiI/T9lscjWDu?=
 =?us-ascii?Q?uZE6225txIgzxGHhrbAJi/FXSntenX0cLG26A0d4c0uhnUSIrSs2r5qdVpbk?=
 =?us-ascii?Q?jw9GaI0Slr9TSlh+wf+LxS4Wetb88r5hrAYgHFQ2GIiHfQba+TF3rUXIgC4C?=
 =?us-ascii?Q?MQ2IXNlsAy6xHg3vb+eYivcjB9Q6EEnYygVZrkzJynsaD0nEOq9NU0Vfk4Rz?=
 =?us-ascii?Q?97SUP3i6EveGXksUtXSvXUO4JeaJwwu3lTuKjajNVs6BjfonE3aQ6sJf6Pl7?=
 =?us-ascii?Q?UUvRsQ/u4OTZzYYQ1ooNYU1oLBSKN5QS3Sh7+lu7Y1oNQZ7pJ63x4C+floGn?=
 =?us-ascii?Q?o7mFqpDVHr/XDK4S6PRq8tUCYg8NJiic03eQKvSfK/C8kMdGGNkL9Ge+Cku1?=
 =?us-ascii?Q?XOUhL4VoYDw77OAQi6fmiyGtE+D2qzsaQxshL7PIZQ3ZMYARoLa+fC+k1Dyr?=
 =?us-ascii?Q?WIp0kLh/hJ9d9DfdLjnQK8aNVnFvC/dU56PU/gM/HChxmGg+WqehVgIqBuAq?=
 =?us-ascii?Q?JDUbC2urpBaPsUb+J96YI7zRpW/F2DUMRGswWd1GYBlyzOhEcwd4aov8nyjD?=
 =?us-ascii?Q?GgVTEbnKmqu4VvlPu3rqpH2P2Ov9CZ7/QS7SZteEf3+FTfFqjXVcx72um3lX?=
 =?us-ascii?Q?aOAWeHWWu5pl2Mj9umYyA4TGm9/UC7LwsPEJJUkIObhJ4eZAV986Q14e558F?=
 =?us-ascii?Q?sWuK7jNkcjsQoKjmyVC7+3COf9OM5f8E4VmDOY7Fp3Hll2EKns4ERZDIU/qR?=
 =?us-ascii?Q?zyMf1rrTN9cgZ97IftR89/XZF5HM6nE6Mot5La4bMbdbq921PHlcvxrNJIR/?=
 =?us-ascii?Q?7+36ZuT1QHOMMAf7u8ebnYIeUuDLe/bSNYIC2A72EYb2j1ed1tx/CBUkjLVL?=
 =?us-ascii?Q?0o7l/lDP43Jqpog5JF4Uln7okfwRp0HtGzvlICU0zR44cuhsa/cPzfumxl5+?=
 =?us-ascii?Q?lCk71ictifwMUEvBXvfJ7TqDXMVbmM6Po4Q0sp3qa3Qrc2uhJnIpLpEFfTwJ?=
 =?us-ascii?Q?5ejlErJ1fW0FYWv568h4QSDthU9R8/KeUa5v2yr7T/u/a52L8nPXuiODRa0v?=
 =?us-ascii?Q?QygDCIM/I+7up1BeeqAcE5XGiS5bzvq0rHDlRdTix8QoFSGc+jFkkYPbxKdr?=
 =?us-ascii?Q?Oo4Pgbr/oyiiZXgoz+ZJiT+oC1Ej9E4jlX7D4Afmh6HyFJ+RdnWQT0FU3Bhz?=
 =?us-ascii?Q?YN1jTqfdE4K0c105ppeMqVBygKsZdla5FUn3WRAcmjze6a3OgrZJPAndCUrJ?=
 =?us-ascii?Q?LZV75usZqXYGJFT9Q3rxAJhyJnBNCDOwhNbOa9z9/D1Am2QMGAIcUW2SxHZ4?=
 =?us-ascii?Q?JF20m4hRxPWQxjWEgQgp4Qj5k5TYw6PWTxuqLK47k3Agw7jW3YqpBnAJR9qh?=
 =?us-ascii?Q?CJn7Vm+tzWjU9244A83n1e+ltrXNkUkG9DsrFIrP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9442afa-4452-4692-1d9c-08de0b97c1a1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 03:05:55.6805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oG6cdxI+Q1e5j8DRM+JCYDmgj86MTxv0OYC7iNNShTkUezO6SNrfygIY1SPDPlaAgrLwR3gZwK/5EwZdb+UNmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006

Add a new imx8mm_pcie_clkreq_override() for i.MX8M PCIes. Pave the path
to support L1 PM Substates after clear CLKREQ# override. No function
changes.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4668fc9648bff..a60fe7c337e08 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -685,7 +685,7 @@ static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 	return 0;
 }
 
-static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+static void imx8mm_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
 {
 	int offset = imx_pcie_grp_offset(imx_pcie);
 
@@ -695,6 +695,11 @@ static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
 			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
 			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
+}
+
+static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	imx8mm_pcie_clkreq_override(imx_pcie, enable);
 	return 0;
 }
 
-- 
2.37.1


