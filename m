Return-Path: <linux-pci+bounces-38115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AD8BDC453
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 05:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855543E50FE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 03:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4864E2C0303;
	Wed, 15 Oct 2025 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cvVy3/fJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366ED2EE5F5;
	Wed, 15 Oct 2025 03:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497542; cv=fail; b=t09ZcTbpZgugbFekg6jVJ+qrI1k7XmohMj+OlLkJdr7vpwSViDu0k641uJ6Q9UDDfQMrXoH4zBbGVQK6WHkbRx6GLC6Zg39gGnfUOBBz4zMYhFs0NZP/8BlrrOEB0sLhGEexo0SV02JY6vZdXzqk7GLKYhKpj18c0CEOifoLSr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497542; c=relaxed/simple;
	bh=sYiV47ZIH/7+IjtlD3k8Dr1u7uabIsMRof5PrmcZeH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8Of31UyFG53YDf89od4ynQL524ED5Xc1oEnJ1hkTfeELrWl02aHlEZIpR4EC6c/QxeVPvnZvf33xbaG1BXpqOq8KbtG1RjnZnGLGsO8Rsa+I3sgwbEGsUlnKZJWUrTcNPD9jjfZJtfBb98VqwFUYlI2KKgGe9m54BuDXkF/gvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cvVy3/fJ; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPUA22TPo4CsrS5pfItpM80NGh894SSc5y6s3R8W1l2Gr+lBJwSPWUm7aSXh3S+nyZjIE3Mo21cVbZWRr9xCN5/Wdt4DWXg4fXVjvyibR5/FIi2JT4t7UBQ4uEd0vEQJw6EsNdcEIK+kHdOl/I2g11fyrSsoNM3jgLI7BMhpVo0n/K2XNZRfZL58cmuWX0gwpbPTXgJhd+d5FHPIEbvqgqqckiLv+Nhfp6jxx/pji2s+IGDTjlRPgi87qC5OjQ7QVVL7L5AWz1g00i6niDZs8C/Ko53YX0xKZ8Vc5hz/CeLTo1+7cw95ZDkJKVM8frFQ7ig3XtHzujiHQwX5TmDcJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pudrbaSXJySUQHt6yLN0jgHeQCa2c54YSR80YhoO4wQ=;
 b=jQVgcR6urCJ7hyO8DekFRSm27AweqGu87CkRYCW9V7zzaA4TFlThFnVx+ip1SBLDF8DjdHMif8shxJVZMQGe/528QFT7yAWr1/Qk2gbRKaV8hCMGLFEydVVNwvpSqdYjCrsPCfFcmAw1XGshJCdIAwVgIVTgTKKCo/C20rhUuyXm27u/2WmAR4Qjnzp5uQKPLx74BbUl09MbTbHXHrn0kipqDJBUtkID2JwsEMEb1vpWvyJ1BQTriAGEGIcF9E2kGJeFJzEIEM3gf1iuH0Ga1lUVx8Dv7d8QRzcguFHRZeVgaHx1lNOeV4IlWq7hCpLLaDbPC/NSyZxxBFDhktAQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pudrbaSXJySUQHt6yLN0jgHeQCa2c54YSR80YhoO4wQ=;
 b=cvVy3/fJwAaKBlU82Gkgg1e99cb6IRu1CV1p+H2OtbDK9ZImxP7qBiNqxRpt4JjEvhFobg8Z42+FWx+QYTXhzUaUIv18RwoTwNJ/+1Uyp5/DmbYBym54hLBzSzgAjderpPNp1aK4wNP1cdguiZj8IZt21/jE8vARrzkSYLjOX05DaaXHgx8eWllnedRXW6jMWo/ksZYxHvamww8eYKcNFlfYAmFQ8jnTwoc9Aailm1gbj1l3qHold+fQ0LV7HFm1tjJvSt0MRrwsYuIQfRVL7isb3W+MFtRMr0hpHJIcuQELYjVQg152oTxUUiIv3Gsbuy++OQVRtOA/w272QqB8iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by VI1PR04MB7006.eurprd04.prod.outlook.com (2603:10a6:803:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 15 Oct
 2025 03:05:37 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 03:05:37 +0000
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
Subject: [PATCH v6 06/11] arm64: dts: imx8qm-mek: Add supports-clkreq property to PCIe M.2 port
Date: Wed, 15 Oct 2025 11:04:23 +0800
Message-Id: <20251015030428.2980427-7-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f51141e8-35ef-4136-c559-08de0b97b6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oXMfLElUap3A67qPqLFcmrFMPM3dWSe4BUMB6kauJInUec4WcZh7gf2Q3yJz?=
 =?us-ascii?Q?u2ig66ptQ/8bydgJPhJZmtoOxGhgea5+TB3uql9EV9w+NNvkvzAYagDUuIxi?=
 =?us-ascii?Q?HwPklQXbJDF66+9PCpPie5pa4RvjfcDB/4a02widBlG1FrUF6FsEugC5P+7U?=
 =?us-ascii?Q?C1h7kgRRAPW9fFVaPdstdL7HArmzyzXUn/RQ3qygX+t2Pr2m9bSzA5wtsvRJ?=
 =?us-ascii?Q?OMHvClcXQl3oT2JjMpUVEzW/ewVEu8jfLUXh2xQzdM9L5ef9dGil/5tM1bX+?=
 =?us-ascii?Q?y1tZ0YwEiJOYB3cJlL+BNpkXSU+/emxRgC5NLCjswpv3jCuw+mvzOzht8lfz?=
 =?us-ascii?Q?CyRSlzON3b9OQFreON+tOWa4I76hcZuFMD389UPcNtMBK3WoEYJV0gmJoUtY?=
 =?us-ascii?Q?blPo0TvRNrc0ygBxu/yablkFDs3vxQbPEFAYLF9Nc1kK+vFbc0K+Scui9YIN?=
 =?us-ascii?Q?rZfzBopMoHZwAXyIrNyQJbwYyDIin/eXlYmW5O2kq6JLejQ+btF3zrMorrxf?=
 =?us-ascii?Q?2Y4ikFha6GTb97GNEoXlUscnMke3oKLlzo6RUGq2l36Gho2ciMkcbuMfRdjX?=
 =?us-ascii?Q?nbX7v9GnqW3AgPmv62QLcJra73knLUkjyQkyj5Sl5jLqsKcxyqC2qxZjtMr3?=
 =?us-ascii?Q?vGXeaYRxuNb6gmRAz3aZrDz0WlGNwTLu11vLFNp5Lu/LK3/8zv71KYFfP4K1?=
 =?us-ascii?Q?nfMD1ieUh6aBFoxq/6r/YckghK2zgEn8BfPLhJjFfiYk/VkcQa6NZ5mLkhtE?=
 =?us-ascii?Q?hH8bdGpzSz1+lllKdcIGe1IA62hp6rUjq0aiUPcuRzo61BwXfFGp9sE5EMQt?=
 =?us-ascii?Q?6hzbHefVpiRjN6qP6lOZ666nic6i73K8F1QYm+lfGAZEGLSRzF8VV7SBzed4?=
 =?us-ascii?Q?PYuXBMbQfcnj+eyqqYbRN+wLpcA7RcVU63I/ex0giOT2DA4nTlrS+pFIf+N6?=
 =?us-ascii?Q?hJsKQUFlbz0IVvLFhTpi8HGHx6gYaFkUfMdyRIeH9yo4x+TSPGPzKygJlhss?=
 =?us-ascii?Q?Ox5gt368ic6wpbBFeJwPlxM7l+GGo9YVqptJDquthZPQ/LSUTCoh6410UxVT?=
 =?us-ascii?Q?m7nRzza+npBWzzrja+B7pOCB2TM6q5+AMQu3YobsKzDdrgsmFxcX+M3zDf3Z?=
 =?us-ascii?Q?1+83sBJDavokJk6rmEUk7Xxukdpqe1sVxCkvap5qMbFxHoMkYyN/FFM0A1FH?=
 =?us-ascii?Q?9hQ/hJDz7bOooG23cuTtT1Zc9kwAxfkq2DPWuluMmAX9jV68RMZw1LO6x+ck?=
 =?us-ascii?Q?xxMVEM5rBD+JLZjrvQXm24oLRk/fMBr53pUaqbJdf8iUDPG6Oyy2KMMNQpYc?=
 =?us-ascii?Q?oAVKT5OmsHu2eboQ4Lz5ie5wxw6KZlOBaRt4QPWeiTOf7IIAlBfIDAv4/+xU?=
 =?us-ascii?Q?dtCSQ+XC2arTq0KlPUGzh2gDr9fhwwlINFJrqDEkBtFfLSZQ0o6g07rjGq81?=
 =?us-ascii?Q?cOHXUON16Yd+MN8xvjy0bX34M4DF3LCRRPVhTRhd4YbTY3ZwHy/IUEhnbiG0?=
 =?us-ascii?Q?wIRv08fcXcQ+wymXuju55+IRE1bUqJCGwwR7g12zddxs+YGZbmJ9q5D/yA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eo4WrNLtV0WisUMnWLLQi1vgt9UFO67q3sZm3nGjIO4B/x+M6+F37OUiwcWJ?=
 =?us-ascii?Q?Qp84gVtwIRkTF9zJxzROFmNW0dkEiebUOYJI0eTQq6XSWJFo+iZzANGwrGvc?=
 =?us-ascii?Q?FnVVdsgOkvr9WQHmsvH6FCUGamOategHTuqKxbX5W/8eMoDCuC58oYoM/F5U?=
 =?us-ascii?Q?YNIiB7wk54ONikdxXtBwZ8/ujEPdk8cMek1vEDPpYbk021AWwtkmjxTk+x43?=
 =?us-ascii?Q?ypA4hlwrDA76gWZ5geJjalolxqGGq8F36rTwvVGlSpJsIHzlShGcB6rXgF9N?=
 =?us-ascii?Q?9+gLr9bnNrQ7fzxTKMydSNKd0Ly2lxvNEY8GwtpcT2N5B2MZbHgQcMWdDFOr?=
 =?us-ascii?Q?DHKdR2+U5JY5QvmN1i7kdUDhQKCotirEnlUL1ydFGx8h00i6nhf65KwVhAcW?=
 =?us-ascii?Q?gKO/KcF4/W/iXDJtIaVzlpkJ86KlQkTGwyqAg7ejTCieeyHmGfa2WX8wTzop?=
 =?us-ascii?Q?Z9Xlh7VZXkCSgPwTboF4NjKeFHZCKZsyALSDKcLg6sqRo54f5jQD8oU+8eeh?=
 =?us-ascii?Q?y23eJT5ufp7NHJhXwpNLLA862/o40GWUZYOSduqDfaOXqSfU0yfVDYSbux2F?=
 =?us-ascii?Q?lX9Ss6ytUIbTQZAjGECeKH7OCVb+FpEkzoQqOz6xEUvLYc2NdTIElDBJRb1H?=
 =?us-ascii?Q?A2fJkap8os7U832DhC4jYu/D9+q6ujSWncQERNWmCclT5QXLmMJCmi6tI6VM?=
 =?us-ascii?Q?OZrlh7n8mTTSyP/Brr1H40A6GBCB5r6Ky79mVcrMOMSwc6XpFjnQiMFliQn1?=
 =?us-ascii?Q?2t8n0aosr0AdJnIdHOTzoVhiVja1xFW/CK6i4AD7h4TGMd63ui45EAyw3+x5?=
 =?us-ascii?Q?CTOk1YxGAAcOePkDxDQgEKevsPVd8JxqiC9VapVTLtaUI72N00ASWF62lfeN?=
 =?us-ascii?Q?ptLL53BCTyiSHLVUFS9jCZtCeF6U4Bv2k1x0Hc/QDzDe/u8NpkLg3fVSgrSO?=
 =?us-ascii?Q?Bxj3+W23Y1ozAC6akwaHCO6jmx3ZejUVHo19WnTAPwbli92uNxNrXJl59W3W?=
 =?us-ascii?Q?UQnJEq9VsdsNvAdGtm6WNXSAL8wnzPJjnSP97QiQf0DrzMLX5WUhiYCB+Xtk?=
 =?us-ascii?Q?pzbmy5GELqmf7Ihm8n5pQvfFqz2Gujsc2je/0uUIWYXCUYNb/IXNYfTV7RUL?=
 =?us-ascii?Q?VIbQPaYzomWeegCGYF4Su5SgfhJlUQFtLvYt9WYds62lMUUWoCggdMu2TE0X?=
 =?us-ascii?Q?jVDtTNq9vTlZkUoAVMZMQ6VYpjydESzbrAuBwsK+x9nnDMIsfg9WWjKEGmqt?=
 =?us-ascii?Q?gZ7QVbtj4ojvgqRZbtROJBYq7+SYBYParNajQm4aS2Ula8UKgBYVt4Z2fMHX?=
 =?us-ascii?Q?GmAMTbjKprdwvlVGH2dWAk5CO3dWQePZzjyTG9LktPn16bfStv09yTE9H+ar?=
 =?us-ascii?Q?voFnL8fstK4TsJlBbyEYJaW9CquK+05ImN41IsgdDk7EhiFpWDAmF+b2zspK?=
 =?us-ascii?Q?/LNYy6O40OjwXDm3n/DiTj1LOyp0/7vVbBZQByvKVyNrAf97egiYSrVsRSog?=
 =?us-ascii?Q?2hZAul0MuU148yqRvf4M46EM938fRvYWuU0MO6k82ZtJc3Rlq0KWkfSKzhPy?=
 =?us-ascii?Q?TwX9L+2EXQXBGTQUYlthaf+ROB6s+w9Q2hk27YWh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51141e8-35ef-4136-c559-08de0b97b6d6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 03:05:37.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPsVEf1mv9huMEUA06vFt9Gyqfhw6ZpTyxFJV1Qpg3V8xjAnijhvudIXXAPRM2vn+i/MI/0J1lfZXPPcx/NVIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006

According to PCIe r6.1, sec 5.5.1.

The following rules define how the L1.1 and L1.2 substates are entered:
Both the Upstream and Downstream Ports must monitor the logical state of
the CLKREQ# signal.

Typical implement is using open drain, which connect RC's clkreq# to
EP's clkreq# together and pull up clkreq#.

imx8qm-mek matches this requirement, so add supports-clkreq to allow
PCIe device enter ASPM L1 Sub-State.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 202d5c67ac40b..c1e4775c13849 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -775,6 +775,7 @@ &pciea {
 	pinctrl-names = "default";
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pciea>;
+	supports-clkreq;
 	status = "okay";
 };
 
-- 
2.37.1


