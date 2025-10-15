Return-Path: <linux-pci+bounces-38116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335DCBDC45B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 05:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42FB401DBC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 03:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257A12D6E44;
	Wed, 15 Oct 2025 03:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gwugo9Dl"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A9329B79A;
	Wed, 15 Oct 2025 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497550; cv=fail; b=pZgkK3my8IAfhthkTFX7nhbvxab7ALOdqCZ3kTZRtFA0SFUj+Ck3IyWlfHoNd+hc2cVpcxB2c7d93CYYfLaspUF8a+s2K/0MLSkYkObDsEJfe7y29wdUc7t2Z9T3bSERBMOeXBeMLxSos2MnoMqUcPZaJYmZCgkmPlDGjvMOcMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497550; c=relaxed/simple;
	bh=9FGX3rVpElWRZmjH0ZCRkCLxZF034oGbnQXctMdbBDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QF8jjucm5GUmv2Pi++CKxRncWevrCApZl62zHjcoTc3ahchFBiUKrKtauWqkhtkIdlSwe4ZmolNMIWBpy6OiBjdA8EiiuTnmEGF2iHv1NKA+U9t6uCh5z291aJ7vB8twWSw9r9KeTnwb2vwkQxaunjJXobxsI4EJYpLMUpDFUGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gwugo9Dl; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2118NI2TnC7nEG1zDejYRtt37RlcFKgEmK6rohdYfDT1q+SWkhxp00x5Hgc8c+PWpYWgOlGON/nAS9dZ7u612MXB+5L9aP/j72+CsgY20od8d5PoCDThoyHD9Ll6zDv2xau8BY8SaZY1qGUCOhTpyZKku/uqc0RmUHj/N+WF5T332w2Gj2zZaEeQIM41eSOq1gnDbaka2zREjn5uewjE04+fk36dDz/xqmFvX+Qez4czgBhCcjPEN18LwRFl5JLHTSgQYpFMtpZKDpK8xpyHqyAFOFiDnIAY/TkoJa54T22b1bmIQvNGjapFcIMgWKO/flxBeoYOndXFmQ7yHyi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kla6HHfFPnFU3nG+3Pj7p9mAf7ZkyTWQOC87lZpg588=;
 b=f+mLpFdxVWDCipiNL6FLumLbM4ebsIEhSnyYFFusWqJm346k4jpBUXeEgXdk2nUdtX/+kHWykJVCFKDwALc1hMoPmgmy+Xk0EV6blP6jT9jIaaJGKckD3hQjzs6iIeo7dPBJT67T3O8MQczWM7IoJU+dmm2HWra5eYqvbK9350AW6ZR1hYvY1aDmvaOjpFWse+ICin8tcIzcXsuc3hHZeQCRxcYLyxOK3ULkMwausdBpQCDW72z1V8w7S0FIOUBvb4FWiXjHF2UByFHc6/ABW+/evWX/+37/egPWQ8ZyeyxNHOMmruQCYXw5R0xi7WHV1g8PZNlPQkkpg1GSfQVW1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kla6HHfFPnFU3nG+3Pj7p9mAf7ZkyTWQOC87lZpg588=;
 b=gwugo9DlxGcWz4/oYpH/T+4RGa9kiXpLLa3wU1XATlUOMCPlIhnqmgj4nw59PWGHTTICFxCB7ZezT1YoIaq/q642UYHbndFoZy/1gO2/Mj5Ks4YuLAEICjcdGLA3lJVgX1/h9OuWaPoSc28c8G/Md+fRjM5WJJRl8kPsANlPS8+3lPXNBXF7Sbf/FTTPOKCmyY3KyBhVdb2GYKieU66C/07Ldiy5cNU2N4rf0BpovWSbx32qpmslVa4L7gXk0yt/yqawV/IXEnRXDiisDp6HBZMjiLUXE60v0fsYivfDRWB6yuRvTdPI5mRalMemgOVHv2uZXKgGXSWD1csnllb0EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by VI1PR04MB7006.eurprd04.prod.outlook.com (2603:10a6:803:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 15 Oct
 2025 03:05:43 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 03:05:43 +0000
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
Subject: [PATCH v6 07/11] arm64: dts: imx8qxp-mek: Add supports-clkreq property to PCIe M.2 port
Date: Wed, 15 Oct 2025 11:04:24 +0800
Message-Id: <20251015030428.2980427-8-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4a889efb-0886-45a6-54b4-08de0b97ba6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rHjVmwKYtDPDZYkxOKPJ9Fu4Ogf3EzmACnsMORmmkNLKgqllyUeWd0DdVwcN?=
 =?us-ascii?Q?MLKQxOTUU8OnP3DjbYQA1SYHbVwl9f0NFB//eOEPBxpn7QW4QzKrr7dDWKjR?=
 =?us-ascii?Q?PZKR0GCQKRTp5pMPCg7DywX8PE/T7JAnLrSvYjiNiEJeqOziELL2NCdH3aAJ?=
 =?us-ascii?Q?5p/SgdYZtr9fpJOVCYMG/vhm7VU1TdeCuWmqxdnK6AStwvOW167B5Z5BFmsO?=
 =?us-ascii?Q?R1sddJQxVdK6Pp1muFzy5+wo1Bn7xXdswGp75VTEFE646R5Nox9cz+kIw0V1?=
 =?us-ascii?Q?rGxE9B69Ph5M1wzNnWvnqSDzjJDAkr06R6r95dVAqF2Vy8yxTYBhnppdkwzQ?=
 =?us-ascii?Q?DnOlEiezaj6RpQX6wWxyD4AXs2iNlzTsMv7KPWZX8dtWQfcx2Bong0QELnml?=
 =?us-ascii?Q?2zJ6TR1rXrYooHJ3IKlAK5T/tPiZB3NHq2xPMcYjxQtHmmY782wSVLouystt?=
 =?us-ascii?Q?z5pIScuLRk/dG+AleeAX+2NnGKiuWNXS1FdZt6hoiNkraZ3bOS/HcPiybMvf?=
 =?us-ascii?Q?JnxDENeyVzkXZHdIvnp3qTAoUB64pr7XZts4dQGsU+x3OF5hNqHxXwcnohVu?=
 =?us-ascii?Q?rslpWEnlgi142ZlG0YK6lf32fg0wzszxCv+Et70xF2pdXSMsM0276w/xDEhw?=
 =?us-ascii?Q?mHOeRYSuxXjDcrC4/E9oQb3wMZIHdpaAA07j8/CKx5eyTl51JubgVvJ4gVgK?=
 =?us-ascii?Q?YxOPlT0WTcyRQFRftkUQQUX6dXRhOScSbENZNO+mJBAod+wma25kGDUZrV7t?=
 =?us-ascii?Q?RAgDYhSNjYcZyeKQ0T6EWqLhbjcLplffT8Ykfr3cPG25UTqmJXu3pEHe08QQ?=
 =?us-ascii?Q?/+hMkDBkszqazKLCcCal2LWpUfdTkOfME2ut0zQOwu20oy5agPZy5h1DY3oi?=
 =?us-ascii?Q?RvGY1LPfWLf0kQdH7b+csGG352mPagWgjdz4ZMPVYl1w8cF745wKDy46dR2z?=
 =?us-ascii?Q?HVG0sOknygtacuI8DzL4OVXCRgYGQq0nRmhL4SSqvoKBR9zULS/VfapeT+t4?=
 =?us-ascii?Q?oyWH/F8QvZoaIvVAz+8Pp32wfZXvHCK1YYeBJsHapYXJT7SBNmvjWqw7K4P6?=
 =?us-ascii?Q?ALHj7uQpq409nTu4BTX6BFkO1FsaSNexra6WG6qUQwgcafSpaPRWukShDdpI?=
 =?us-ascii?Q?Mynh3DXoKsa6o02YgBZ5hcTlyseygQTR52IOE5MpIWZDk99VM5/7knLhHqpZ?=
 =?us-ascii?Q?qQrrnlzkxz8pmQJKVy+vxW3QWdSPN8qr/C4zuO/EueX69QEfShgYEmYiAuTA?=
 =?us-ascii?Q?6aboC3/Xv4E8V/j9z4tHm67jERFwGtKKy7wmRSgF3UngbtVz6RQR4GwxhqZd?=
 =?us-ascii?Q?FgeWLp6me9sJ236MmsipT5IK6UcDnsLTExXdSeKCfC7VrD0lRN5Jgn24ts+a?=
 =?us-ascii?Q?PHi2EeK0YO3vz+O7HPEvldTZQ6CfQSf9f5enf9ct3nWwxsHKa6U7ApPMLOO4?=
 =?us-ascii?Q?qyb8dhRFPwhME3GJ+lkGDR2b/FYrT5xBoXuNnkOvrVOoKiCAc5/jolXgUfbP?=
 =?us-ascii?Q?6YQ/HHmZfTmP4BW7aoQHk4VF+7l4aWzWAUisaAO865xGaLjR6wX+opAZpQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F4gFwt0MQND5YjuJ0FaKgICzJoWZzIQtJAxALLU+wGRyd3UyopyOsJx3wd7i?=
 =?us-ascii?Q?1fGXwEiA5DfEefJS/rh4luU0hyBupp1Y2e5J9bZ6a7VMCdXjO0frNK/RwnwE?=
 =?us-ascii?Q?WI8P9ka7Saq+7oDKvhhoFem2xJVLygEJ6NPp2FmomcIRj40oO4sqRAIPQtTQ?=
 =?us-ascii?Q?FzApxvGtVyEV9NB7LGb9OWil0lOV6LQH/CE73zX3UgkkXrBmO9cva/nJDcaW?=
 =?us-ascii?Q?NYPOxycXr42rZbrRZr1xBM8aLEzHxmUWv6Ue/FO9t7mGVSa/ZLO1wM4c8v5L?=
 =?us-ascii?Q?baotMyxI2kc6VNrkpTbtz15k+upwYsJZuK3x75o/XpEmfwxGgIiwQdHD3vLv?=
 =?us-ascii?Q?3k7OWoCc8yf3aDIByDPfVo7RzBtPnke1EsPGxWZ1ImeZ/nq0tBOQa5CtxHnG?=
 =?us-ascii?Q?4UJuPikc5hn9rmI2Qz3cCgINqNvtYfZXyZ1M7zQnKq45tiYblrBWHZigUc6Q?=
 =?us-ascii?Q?8+FQkUqDBJwk9BLiV1uKPy2ExL83xgn2ky/a+Pg7Ld1NrXegCxIIlXLf30XR?=
 =?us-ascii?Q?t5J7dH9H8mIXbMwBWRvn7C7904ZQS2Zg3rGo19WZ/jH68jzyHcVAqZows0Ml?=
 =?us-ascii?Q?Kj64WevwFtcLGURuZeX9FU1X6eZgG5OmhGAuh+Ckbmdo6e6S1PbaBiIPqjyC?=
 =?us-ascii?Q?VLR1c1pf5VRhGoDCJUDbX/hiKYD6Klt2UCPO4lwoQpi3je31boC6h+ZRQ2LY?=
 =?us-ascii?Q?zBzkc8XGMaEkFUEtTpqfM1cXW4QepeEC7Ibp029hBsr/kr987wMLbEBU6bi2?=
 =?us-ascii?Q?MjX/5KUa5O3M+nm0QFqopxtWU2UdTY9zaCHjhWXidiW3KYpZ3tP8j2hpaIVT?=
 =?us-ascii?Q?U523AYVTAQijr7VTB7aAJ93dGeTS177W6Puj0avcMTirLFKTkXJALJ7Bu6wM?=
 =?us-ascii?Q?W9lYeHaYRS3yOakKwEuvdd6b7RT/f5HyJqKwSdR10OsFqikQxSLB3esIuuhP?=
 =?us-ascii?Q?b9BXcqlC8EiU61lKlsO8z6o7IpY7T6ZGOGGvYg0E95zedFT5hti3zFC/jIM7?=
 =?us-ascii?Q?wZfXkZOdy+zsTN9ieeX0Gd93Pw9xYH13l+/8VMHPGr3mPEPYY0orv4yznWTn?=
 =?us-ascii?Q?Z0rq4uXdOfbh4OFoYtB191V7CEpDgEXBgcv9ZCGzgbpkqwW273nigmMiwTNX?=
 =?us-ascii?Q?sI+m2V49sUeEAx+PantXaUfYV4WRDj+YQg+Xn1/dtBsR6bwbjIoa320YtzbL?=
 =?us-ascii?Q?FDY4fHnlLZjht4BSZ/HVzLGaWJi1vYyCgOram3jCFqqDpbTzsQv4VXnPN4li?=
 =?us-ascii?Q?t8PRJBz2Y7TgFDf7eqzHBGEHiOeNe2aJAYKkiugLMR3jUiuEVJpHI55rDoQD?=
 =?us-ascii?Q?PouYHBX3ImvxoWy6rNaKjDKUMow8ZZBIc6+bvhiR8K8zLY88nsCOrGnhBnoY?=
 =?us-ascii?Q?WTRdeSGVO28+ytkaT7XCNJE2MpfI+KwwnldLlCKbp2H0DFdH+BJDxLCoE1zD?=
 =?us-ascii?Q?LOvNpBAui6ojsDeXDNIfrg0F2Hz3jcc8+waqQxUr7xiLXEWkZD2QSq21pYIB?=
 =?us-ascii?Q?ACRT5P8HB5pdZed6VHc9HVpgnNhFDKDhEpxDn4Bpc3UC/J77NzZ4FjakD+KU?=
 =?us-ascii?Q?h6hml/HATrr2260s7z4BGe1Rge3feZtdT0kzDpqp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a889efb-0886-45a6-54b4-08de0b97ba6e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 03:05:43.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRav6pCI69JbqVfnrYe0k3xqgsAqvuSZ5tyaepqjCAF2spz9aQCQiHxLfcA8YTUJGK1dNFqR6qR8BWL5rOYPFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006

According to PCIe r6.1, sec 5.5.1.

The following rules define how the L1.1 and L1.2 substates are entered:
Both the Upstream and Downstream Ports must monitor the logical state of
the CLKREQ# signal.

Typical implement is using open drain, which connect RC's clkreq# to
EP's clkreq# together and pull up clkreq#.

imx8qxp-mek matches this requirement, so add supports-clkreq to allow
PCIe device enter ASPM L1 Sub-State.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 7b03374455410..9c457c2236a61 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -631,6 +631,7 @@ &pcie0 {
 	pinctrl-names = "default";
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
+	supports-clkreq;
 	status = "okay";
 };
 
-- 
2.37.1


