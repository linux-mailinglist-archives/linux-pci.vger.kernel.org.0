Return-Path: <linux-pci+bounces-36334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6040B7C899
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2F83BD157
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 09:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8C43451B0;
	Wed, 17 Sep 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jMtgeOeQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245C341AD4;
	Wed, 17 Sep 2025 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101909; cv=fail; b=GuhF4Yy34+TdXqeuiWBi2HeneyalpOUpd4U7O62aDegkYuST5TEtpEg/Phm/E1ivTLYJ015ZNgondApVGaKo3CvhVXB3bb21378UkOat32IVf7Km8jg1itPSMudIv/MsgyZs2WxNo4TQz0PEyMoy+SAoQu69rfM0pCbvoyDcUXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101909; c=relaxed/simple;
	bh=DRelEcYBSkVNI0CgHc9M1uCxmeLhjhnsZx4OgU8cF4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JgafFSIqwVZv0CKHjMCBD5jpvsWunth7FR4YaDoSlTdJlPzUjS+j1hYO5GBBKh3vJH1SmT1L+GtCKsUi/jZUuZLQLBDdr6uv3e/sCIR4M4ixjfavnthzW3o2GMBGj+RdQRf9ILvDeNUSodINQYJy9Krg//pXVN7axUKnQdnA28A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jMtgeOeQ; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3+5fDYvAn7pZCCcJlXB0pE1D5L8Ev42qQedf+5NqiLZScQnUVCTk8FI1PdVKitwmO7GelERjeJ8epBM7N4lZY/YuK2hbLDr0b8cnsXK0sz+U2qPtEduPWBDZFTywChJJEOnIQlS0uCJkSvVQ5Su7ckFjgqSva1sJJuh+KZsSn/UQt9rerytPI6auMiafckRLpZu2AXoVUY2tISm/PFiCM1LmtptFX/Pqt4wZbodZkDAh5EMB8E+7a7/ypt/SGJdjhZOBZbaw9mPJuLND8/V5vdUDu4h6bItDvwRcXrjQ+Ago5lft2/YkLiaNc73p+mPxe0EzN3Y+e/trHcT/cHPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcduZLoo/npSKNNeCAfoMdR5ukMyCAWcF1ZInVV/um4=;
 b=jTNyA/U9TcHMrxGnXLRi2BEOtNSFTL87X6BNurgAywo94KSdUOZ7+ekqrYGxw8ilmvf9D8crVhmNRU4d7Bb6PInyIoRwekeP5C2Jd/DZbsRj661QNhF4/K1ZPIb84ctvrzKU16WcNVEU4zIRv0ZgrSuODqJ/RtvwY6rUnRY0XuyxtgtFOfMIWGWmG5nniM4MOUkIG+mZc0A4bzi9iL4wRLDdeqwg6xqplPjCYDpRtr0HrPcKe3Vnh83OTxVZddsjUma95WpBdIcBMHLu4fI3jZlwk2f3IKtDcCh2cutWMyYSH2rFb8zLMEulHmxQh87ZW/Xv0oAb5vsNvRyLvGcxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcduZLoo/npSKNNeCAfoMdR5ukMyCAWcF1ZInVV/um4=;
 b=jMtgeOeQxXyadvPF2EYCP9mIC8qivEi3yjaQ7SWdAt/hXV2rAkPUdHo2powhQyyAFuLU2E214Cpr4uOiREESTxf28SAIjeXPd9THgyUneF4IaoXc6FoAu/+xFFqW1X70DvDm8Iv18NEOy94tUo/Bzp8h5pJEdSLUXOFcZbth0O1yeKhkeT6GZpqoZbS7+RIC2nLcvOb9uqr8bcx1vx7PyXljYZLMLFkKcWNsHEGMBFVgze4Rluiqmqg/Lfv6PGE3t4UQHBBBV6KJNWIY/j8fdvGPmhsGqOr5vxLsXc6j+0AjWia7mXXvfl4F3RMLARMcyQLyGdtIe4tgxR/HiytyEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 09:38:24 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 09:38:24 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 1/2] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
Date: Wed, 17 Sep 2025 17:37:50 +0800
Message-Id: <20250917093751.1520050-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250917093751.1520050-1-hongxing.zhu@nxp.com>
References: <20250917093751.1520050-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|VI1PR04MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: d53c5595-ed20-40d9-8859-08ddf5cdf23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lkbX2DGaOJmB8BeAfGh+M5UnbqaZrrplLCUBI5k9MKE13Pyjtno3dz008TMG?=
 =?us-ascii?Q?/9oNJ8j6b72STJQCc+iTOF2BH0k6U4+7QUgNtesXlDbCG0/dg+dvgam2n7Uv?=
 =?us-ascii?Q?HXc+iXfc7+2lilmxSiB0Yo9gWTwmLJgBTxHO3EOsI25ccIywTW12wfA72chF?=
 =?us-ascii?Q?S+/5dSCQy8+CuLHzMdd/LZBSnr1L8fNMeOOFCkxSED3hLnOX2eZCUTGbZEd9?=
 =?us-ascii?Q?ylN0rtxlArQxdu9AUzHd95vkpTjubxRF3s1pTNEVR2tZ7mlDG2JRrDHReak2?=
 =?us-ascii?Q?goQ9oIDbz/erlyGohxC/Ek3xnHbP04RSOdZz1A4KtUDjbgA3+90Dz4CgJhVt?=
 =?us-ascii?Q?Q6mhxdl/5fs273VbH8grEOTOHFyYXXbdEnch0aAOQaf4dsf673mFD/bMBF0l?=
 =?us-ascii?Q?tcvsvmRN5dKIsOtYEa/OEzrwouszATsczKz+YwJj6J+9xX5WpOYz9yZa1Gxy?=
 =?us-ascii?Q?2v1ZxaOAlgsx86+2rkaDzPOu8IG3FYld9ZRtf+RtTymyj7hv5R+wlrIERqPw?=
 =?us-ascii?Q?p0pt89NDtOrghgwJAB9Wp34JaWfTqyERzOJQateO8jEk971RQ8jPezu2WA6J?=
 =?us-ascii?Q?WnrJ+BNlSHMp4eDFAyltoaGLaIWPTQf9e0Co2tYmft8fgmBuzh8KR729Mypv?=
 =?us-ascii?Q?PWTur1SYf0h/icr9jML+G0LDGUJlo9hgJj6Js+64GOfUWge/kn9kiRiNWbW6?=
 =?us-ascii?Q?/zbWhgQNP5jaZl7QhYdNANy06XuQhcLex2J+PYmB9RmRTQyZ7rhapdpjGVrg?=
 =?us-ascii?Q?ZU/RgT6BRI1RlKiX5pdQ/v6u3Aj6VJaMlQqTCsyz4PmUp854BzunQbqChw74?=
 =?us-ascii?Q?ceOp2ZWSjVATUhEg+BmvgFAFXXAbj5io0ObP50BDa9YZnY+mDdxZiVY8GnQ5?=
 =?us-ascii?Q?eRUJKoceX4Hjqk3hGfD4k/+hAnUgNeQ3OL4O887pnrDMwFuNNXCsEN8wgQDZ?=
 =?us-ascii?Q?TZ/xbL2tk1HI25c8vQH+vBekJHsdwcdYHBoltqvFkp3gZWnjOcFChkIN5jG9?=
 =?us-ascii?Q?BpcT0Bp5yPLuguXjfopLupBdyLEJCeG32nE4HEWMuhehmEwTD8ELYEgSlv6y?=
 =?us-ascii?Q?UDvduGSjbrqROL4ttjH3e8eDT408ikMsa1NLc1F23ozOcQJgDQmBXQzDmVcg?=
 =?us-ascii?Q?uHa2LitilFVvw2s8ReMlugT9Gs+EtUN8KyRJbjW0r14IOlLATUrrjPeVq98V?=
 =?us-ascii?Q?ZlGqDh91jkBnCE7AnBOwaxlAGcPZP1O9QakeleC03A0W3CEv9kw3e9H4Xavs?=
 =?us-ascii?Q?1w1g+2NiQYp2Q3eJfUZDGiTiMjLf+8TCkG/NxmbYgiU3Z/CCv0jImjwImsWx?=
 =?us-ascii?Q?jZkTuHGD50OyN+Z62fTaAL2vpLFBfD3uNyjnuWpLEfwS8aMeXT+pYo8abzAF?=
 =?us-ascii?Q?BfE5KYR0uGsC0/WreBp0MT44/YUdUicASdGBfV5nGhWFJUAFQqCM484rgCC5?=
 =?us-ascii?Q?1pdKtjFifIaVzCHJQQQQUsyi2HmInGpG1qOwhadTVKHTEamngUr028oGqEt0?=
 =?us-ascii?Q?H/ud/txPErjQ0yM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3IpdWYO2ew1fTWThVJHqM6XdFq5ub81c8BpOCiIFj1rkDPM4ro4kn5Zi5QXv?=
 =?us-ascii?Q?KHdJAQ4MZ/HkE3VYsqBlu25yMI0w8+P8/1ZnXfmq6C1PdeKP8CjENxBngR+5?=
 =?us-ascii?Q?s/Iy7el9NdyuQeXuf3e1p87zuMLXaJuXAwGstMaVpFpI7/2Aylj2oHm4elNq?=
 =?us-ascii?Q?nXf+ZAO9BzO8oDsWSCquoklwr1lA4n6t+ISxdqMQ5Grf2SgNfGcsXAgHclDu?=
 =?us-ascii?Q?2N7b5jeYzlLB36Cfw9tf/95O+S9IuI6et9NZwk0DaHSTl/wIbDUitT9aqnPG?=
 =?us-ascii?Q?waOdC/nb/NUScDIxiR2CExONW95Iiziu86vMLBuN6/fLapwvOJK4IJdEQABL?=
 =?us-ascii?Q?MM8ezXMIZ7ZmyTiILdlrEvLACcOiLePM1CuK85zUJSszkSToORd6n7O+1kHA?=
 =?us-ascii?Q?lDWQIfYuTmOZWr1PmJonQROXZvLKy9AHIcz5a6yygeK+L2v9FgTech/Dpxuz?=
 =?us-ascii?Q?iVrnzmmoKF9/OChEG3qafAsDhIWo7Ed2YH3aK5QrHuWdevD+h+Oqoe89DD2H?=
 =?us-ascii?Q?H5Go3JNW2IS/xM4twMiNaniBM6Ma2e+bNvFNXI9ndkkI7hADh+spWnaJF576?=
 =?us-ascii?Q?KIeSB3+neo6Un0n9JiSH4Scr1lKvElFULXdKDbBQJWK8GAQfUWyGcrVfLBvF?=
 =?us-ascii?Q?CM4ECkKfVFw+PvSL3oiUze6jOZT1CbfehCGDhf5jaMNZ/Buz5HMxJU364FpP?=
 =?us-ascii?Q?muzSnh1XWMXsZozuIHeg9gzKXR/IIy9EHreopI4kBJApjJs9mx34hWa4WMKV?=
 =?us-ascii?Q?214fY1pXj0d08kRSyuKGIA+pnLvganQaH0wuzwDoIhT4oO5sh37Y+ThF5GFN?=
 =?us-ascii?Q?2GQ9ft2ZsqvlJTymFU7i7Y73f27OVtPbHB/w7kuYI6zlFD9y0XgL3C0TRTrI?=
 =?us-ascii?Q?R0iQy5DI1sXzFAjMsEfB21OS7mjY8gVa7lGYg/ujOARxMphZr+AaEwwhzc4w?=
 =?us-ascii?Q?Bje9GZFZuwnuaK4GnaP3SQt1D0dJRGzho/hJWOYvijRUEYPnGI6IH+TE6Gwd?=
 =?us-ascii?Q?Jt8jWlKG+sdxXKRpNrsAq5a4LmmODiDGQVP6CZpG9+WkdmWIidRPvV8O0U/s?=
 =?us-ascii?Q?1Y2DpuWcMYwsiEgjKI1Kuok+uo2bH1SjofZavpbwNFppvHzGhLBkM+0Tum7P?=
 =?us-ascii?Q?YCA4IXPTC9M2hIUpS2EQVn5ZbN9sbyNSyM5v7NgxMGKUmv9zwdOKoaeYu8gO?=
 =?us-ascii?Q?h4KRgdJNfgRFoAOcMijQY6FgctRc+VGIXLxmguJkimzpMJ8HeHMBN2OqubTj?=
 =?us-ascii?Q?PJXJE8RzaotnDG6LWIZv4WJTy5l6eAiA1iOcMA2SaEhUa3BfkrWAnr0POZe5?=
 =?us-ascii?Q?aBWmlhE34X9p6gYyFLvkjftizybWf4PLX9gYch/Xa0vwUt7lALbRiL2MUFFC?=
 =?us-ascii?Q?CGTIGhZD6Tc2KqJ4K+hEeN+23vZMqfdX0hxmIABs4pBOGqzjU9GS7E5JdcfF?=
 =?us-ascii?Q?5V9OuMnR7aw3uGXuYZIc13ravF09GZaNqlp8NL0E8kPZNMtN6H19ja2wNwsj?=
 =?us-ascii?Q?QfoEsnJoRUQqVIfuiX5/BdpN73p7agetjZW6lyKDLMh338Y7ud/UCHqHIW9H?=
 =?us-ascii?Q?jg5+KjXPNEnBrhk1ZidPFasw9cgYhqv8QBPiYM7f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53c5595-ed20-40d9-8859-08ddf5cdf23d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 09:38:23.9026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqPtobuJvcaPasWrZZDnwRDgtEyBNbVkN2YpVVYbkNJELDx4ZJPiUduoJvYrHVXUhK+5CIm9mT7qUb6UyL2zMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7102

If the ops has post_init callback, invoke it in dw_pcie_resume_noirq().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501..f24f4cd5c278 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1079,6 +1079,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
+	if (pci->pp.ops->post_init)
+		pci->pp.ops->post_init(&pci->pp);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
-- 
2.37.1


