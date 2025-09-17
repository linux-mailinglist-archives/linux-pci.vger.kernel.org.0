Return-Path: <linux-pci+bounces-36313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A50DB7CCEA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7DF3BA092
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 03:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273BE2F7445;
	Wed, 17 Sep 2025 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FG/ZqHkl"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013062.outbound.protection.outlook.com [40.107.162.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131EA2F5485;
	Wed, 17 Sep 2025 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081108; cv=fail; b=nxmByqHRpwQL4WbyHFz1XlGCv8lHyYOVHqPVI9Ck+YMZ8w/Ab7kbPJGDopS6wOXet4OrNJMqwe7KqaBE/FakHh/u1WueFTGLnfoG6xXRnAlo5MXsF2yv25xOaqPTZQ1jjFzi6gesC2JugnOmbxbYoDliXXw+Ed6VB/9kMiA5tN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081108; c=relaxed/simple;
	bh=sePattRwEnZu7GzaIRwrwAP5AF4WEGy4HVKSqYbNVLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWyDK0N3a4XBOl8Zf44+8hF0s/IXc0Qv1sitWVDqDdpM+D/Z5f/ixbqlnzh8mu4DSjLsbGqQruldWuU2+2nQJxsv+AOXTBLrVm0Fj1vXnvXxU0OOwhfaXr6IcnA6GbBrOjj7RgRr+o6fnwaFQmajxDMDzifG18La/rUwb9mqP7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FG/ZqHkl; arc=fail smtp.client-ip=40.107.162.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTJbnZf4CizMk0vAQy7T4p5gefD3avGDwuR4rVfXeVjvvnjju/QbmxMOmQxhsPEf5jrXREeEmauIIBrawABFJkXkicxgPvRNqUy3dboQDoIeH7feOC37NyfQrmrZU9yxoutFPbZ7tz5e3PfWF7IESi1zDl72z9ryyX6uQov7RmTnUr0s3N+QKVHqnFFkdZbvaXX7pLDxAA2iCV6lIcx+MjN8dDh9ZILBPLJOSRHvpFiw4CoyPFslu4irvC+zwfM/P+uhD22WBQqDTMDz6vnGawIhfeCIBh1QkswHHPp+XXemVgfeTvV8amHZ5VyP8IDzIckVEssY7CV71JzYxNdfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIiJBz38f3alqAM+wPhQryJKmeodGggrVgut8esFaJg=;
 b=g0dtcgFEr/kvb/sWQxKbZ4uF9Zy385xTux01H9/uOOSPnnuvaGzTwuAJ3I4HStB74M4k6K9loqO1hrDBXiBz58hUdlJcjfsiscBRtTs6bcwN5xYFxtveDa57Wgw/XvQ9+w498vCEt5D+5ArLFCPd71VeYKPjMJasdE7LmvGlZJo4FiItBSduzKD08xFcPeMSEAm2jHjY6XBbOnfC6DnQOb1ar2rY1FxBu8Br3D/RSCNHuM2tVglXLrlMInRKe9gZyTQ+7iZcu+HQhqhtlb4Qdozv+iphK7Xqr1j/0OihGDocFAl/3GZLEsQP0cPrGkDzfJdWAEBuDHD59z6hRnOAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIiJBz38f3alqAM+wPhQryJKmeodGggrVgut8esFaJg=;
 b=FG/ZqHkl6cao3+VBYlyJwwzHcjOIz4CJ7QuX4ImQucUEwCl5v9IfgUXNKeYpGtOWitPd6P625glPaviHwj6XXIJDLG16ac38+6pfJ4D0OmT016SZWIo3HAySLRSqoT3OV6txGhp7NBYVcVsz1fB/ZYX+WukeIPOTiC5XZXASHWqMvIRE9VvAsx/lac1F5OoNGUwg0dF1ztsNErm2jG50Qh8p9dR0NDbMXSkmR1isqcYyX3RUwVHi/D31u9iCXaneZmiH6C3bQj2iMA4pJn9tK59ZrJjOM58aMchgbDJ7FmM1xoxGGFMJG1tSMC6RI2Z5/yRG6ZwoaKi2GHolURZC/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AS8PR04MB7703.eurprd04.prod.outlook.com (2603:10a6:20b:23c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 03:51:43 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 03:51:43 +0000
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
Subject: [PATCH v6 1/3] dt-bindings: PCI: dwc: Add one more reference clock
Date: Wed, 17 Sep 2025 11:51:05 +0800
Message-Id: <20250917035107.1003211-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250917035107.1003211-1-hongxing.zhu@nxp.com>
References: <20250917035107.1003211-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::7) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AS8PR04MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 49874262-47d0-44af-e590-08ddf59d83fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|19092799006|52116014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mngMyivLrckb0JKB4X2N1hzwtLu2mIbTeXTfewNVolZwHtRbGL+Nz16jAZFY?=
 =?us-ascii?Q?t5ke8BqBGjkRV/4H174lljWnQ33GQxJoHruU2xKlHcSQIeUwPnZn82SWzKf7?=
 =?us-ascii?Q?woJ5xQ1UbTx+/QCRg+xcDyW2LyKoUGOX2dkPLJ4Ifu+RW6wprnpRsGxDoAWE?=
 =?us-ascii?Q?yIf5xiwE0FR73lhprk4ukG9ZOaJD5Spl6vdG15HAqf5Nlb0sV0C2krVeYevu?=
 =?us-ascii?Q?F0sTVcs31WhYy7TWFyvgevAptadzVsgTpwh9nHgdVO3xtjyZ16FIUTJuyI5e?=
 =?us-ascii?Q?EkXMwbGiHSWRHBdDA+AyhluDiI9bbyysGz+3GdYt9jwpOTtP/gKtYK9YSNIz?=
 =?us-ascii?Q?Q1PCIamiKuwvDS9t/G5vN/GpJP7PDxzmxsxsD/UiChRY8SQQVtQ9SCEwkGyj?=
 =?us-ascii?Q?1XfdSKtVf9xCkSHgoOp9VuPk1TwlWbygrNHskszFadi3BdvQx7IbdrmLDnfn?=
 =?us-ascii?Q?gRlqcgdIPVHvKmkb+67pKLVQrrQYRti2POmoE+AsOnvMllXh+vwISAC8FQA+?=
 =?us-ascii?Q?tNsPWB1qJYcSRAP54nhSNWcaUWXPNEN4PrP8RBsD8ZtD/zuZQ96s4+Q9R7bU?=
 =?us-ascii?Q?h5nUbJ+3vIsgSscv22EfcqLnDjjc77A4m/uTpCL1i8nqwCJDNlne7kjDQY1P?=
 =?us-ascii?Q?owhtZWcCKDtnzr2EQ3Eid+4YXkyAXVCXv72bGhTjjZ9xH6ShuaTbR2V0tFzw?=
 =?us-ascii?Q?nBp8ZqRioWZQqQTVTTUvNE9Wv4QNoXypo69RybRixLfQdxeO7Oow7jz+VN1E?=
 =?us-ascii?Q?2RpjizYgopkuA/xIdMO3Tl3CF8nWSxqRnIE4cQ5ciZ8vGeokEhqe0Y21diU+?=
 =?us-ascii?Q?KcfigTgn2k0y9AN4XgV+UMtriB/TAd88zuhPo/8WAl44MPcMAcTI9gUR74ig?=
 =?us-ascii?Q?bPbQWIk1oIm/eHTYSIkYFqztFqbbz/Em2rWYO6pNerV5e74A7lhCARscNyLf?=
 =?us-ascii?Q?V9aWrxnMJ/0HKIx2UVj/l7Bh5+2bSASAr9Ql7o0AcU2eUn8lnR6Tk0kr7jo/?=
 =?us-ascii?Q?nWOJ+WpxT/Pw+NSjTP8GzOJcYzlF7J5VrdRtK/xFKBFcWYtihX6wm5czPxY/?=
 =?us-ascii?Q?4W3R/WEPqW4ZOY+dvJTZxlEz2BWapyblWrXeUp1IKDqazn5JBsrPS7WzUmBE?=
 =?us-ascii?Q?Ka2TLaWngWhs6C9LK91WIIiU9dtKu101uY8nUGn8GbqIMvjq9JnudeXALkyO?=
 =?us-ascii?Q?eUYCLJf8aWkVSbejOeVJCZHoxxy03cFYkQddTxXj+TPWXpISeQV6UDGr3amf?=
 =?us-ascii?Q?hBu3cC/P1K547qxdEgM55Mrbh2BAwWBxvx3lZstqbvmvmPHnjePbygMAayQR?=
 =?us-ascii?Q?X/hM5ZVxvDN03Hrexj4tsRIyFr1PkzLqyr9mF+IJSWUVgJPCCWVfTd/6B1Gq?=
 =?us-ascii?Q?Spu5ShkKSw++Aa5Oi9//CJoRTpVWvcyPKbZlDsl32fH4bf5tyVLga9H2TMQs?=
 =?us-ascii?Q?ppnE9V+Cl6Ipyl3NUaeEEZvH+S1Vrb2eYTIG0upqrSoYeAsG+Tv5APHYPbLv?=
 =?us-ascii?Q?lL+yQFjr6HLgGw4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(19092799006)(52116014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vhVTJVXyQNjc8/7OYmgerMvWxGgU9cn7/T2JCTNaQ2pk2RTJBvwLQWnHO83l?=
 =?us-ascii?Q?W+k5+KVA3V6gzH9Wlvn6D4u6PfU5RJt4RpFP+Y+x6bEaoU6pYSCcGiXmvOci?=
 =?us-ascii?Q?Xsv920AxqFING2mxtVXCDU1serAEEs3plHo2A90ZJiCtN1Gfljcr0nNsEjSS?=
 =?us-ascii?Q?K5WSCK3jwpEWQsrPtsJKsFlOd0xUOKaLeuqSu09d4AB6eWosurbnTOawkIR8?=
 =?us-ascii?Q?M93AKzBfUGnYrZTAq1T2ivP7A2MaFEblYJfej+6m87lrM5bC61RD0hPqOD8O?=
 =?us-ascii?Q?0tOm7XnyzkayI9t/+lKhIx6hQ5r4oRO6vr0HTJQpS7fPWevgJSnVabBNZ9uK?=
 =?us-ascii?Q?XKYi2GQmAW0gmQYOfo5h7U2g4gvO9KQokFWsp51D0vXkdayxkokBVsGcgF22?=
 =?us-ascii?Q?FM7zdrVcJ7jk04Uj8R9DjOHhDN3eVuLQy6sf/xs0qyBIQT1axcp4SYO6iwzH?=
 =?us-ascii?Q?tHbZCKO3qfZ3+YNw0Appd0JIFn5P8mgignMNLENGKIoLzKfQxyrB8Hc08SEe?=
 =?us-ascii?Q?ecVWQ5MAjh80H+XBiJiyPJrm5RR7jVZ/oO5XMTM44LXY7aZ3ssnnlbq34+UD?=
 =?us-ascii?Q?C0X9eyFMzNzCz7EhQq1ovNB+KNeHDZO6oAQ0QYqJKnu3AYLuzRcA9DsFgvdq?=
 =?us-ascii?Q?9cgZSPP1GbZOkXByyIRHBk0mBxzXpSSw8E50nl/VYoe6+r7sL4aOR+rHxnZu?=
 =?us-ascii?Q?j9iR5sThKlp1EBEj0pT9Askim/T1NqefoE/tLiPBeZppUe6w9v/W31GEgiVI?=
 =?us-ascii?Q?4+2SeLJwfVBPTRmMcwVvCuZcGEarCqhotS1wO+dbqilJimx3dzuQDFFuBlpl?=
 =?us-ascii?Q?vUuUQH4ffPx2LNKoScD/VaxnAjInM+OznhlSnM3Y4PdDKXuS0YVGmBZSEXHJ?=
 =?us-ascii?Q?5l5kloscjAStRP/jn2sWp9ehbHqxYdwz7Lzw0ga7+i7cXTIgSayQZ4VoWaUg?=
 =?us-ascii?Q?LQmD3uVaW/oJudTkSVA6ZNTGRBdcUDVuK1iICoBcVyTruwZt/6MIBZRhNEWN?=
 =?us-ascii?Q?4/I7BlCEUnSunyMulOmO89/wd9BZgYokYyYgAdsY1V+R1pbKB+Kp24K6MD+Q?=
 =?us-ascii?Q?6MX18jR+71AHAS1x8P1c2iUHLogKMdfiBg7GU2oPzK29I6tioFgP6x9yLwLs?=
 =?us-ascii?Q?C65hmt0PP+RFvodBXDRWT4N0DUBvTFlXJDFWw7pBD5IGPrDOqUapNW6l6nAv?=
 =?us-ascii?Q?RAU1z8nKYfHv5v/eK7ijCmGT3yhN3yohOcPRklPaOeh0d/8skFMVpLtAqB6j?=
 =?us-ascii?Q?dewVX3jmAxPRbHU28SFIk4CSUMst7/wX8Dkk+agfUhBIhCIxoLaw+emGQ80w?=
 =?us-ascii?Q?rdh2La8SpcO5f7wTRqkHs1rV9aza0AjZCMxrfJXhyVuXzNA8oB+p1+VTPRhL?=
 =?us-ascii?Q?mp1aaUih3cormLLmR68nAGq7ndh/Rdyo0yNQXEdd6YgGRR8REPZbs0nyiYVw?=
 =?us-ascii?Q?ORn+273tmRemnzSM6ockhUnT7dJJ5TaQDaIYaif/1RlyYJNZpHF+YnVVLIRM?=
 =?us-ascii?Q?FG/7a4sBlCl06Vvgw33Yn7iZAKOUG5uRRsaqMPo8apbUbLhaW9qOt4WeCiWh?=
 =?us-ascii?Q?O/YWyO0XVHYdwhpBtWmRySxvjIcb4XgJmw2jEe88?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49874262-47d0-44af-e590-08ddf59d83fb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 03:51:43.5707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZ5xcz7xJAFbRAlItxKO5D4bTtt2WvYO2kfXDcgzTRcLAPss7PoysTqxVX43rO7Ce9nteVOO4wsIFB6TUCCTgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7703

Add one more reference clock "extref" for a reference clock that comes
from external crystal oscillator.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 34594972d8db..0134a759185e 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -105,6 +105,12 @@ properties:
             define it with this name (for instance pipe, core and aux can
             be connected to a single source of the periodic signal).
           const: ref
+        - description:
+            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
+            inputs, one from an internal PLL, the other from an off-chip crystal
+            oscillator. If present, 'extref' refers to a reference clock from
+            an external oscillator.
+          const: extref
         - description:
             Clock for the PHY registers interface. Originally this is
             a PHY-viewport-based interface, but some platform may have
-- 
2.37.1


