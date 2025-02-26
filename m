Return-Path: <linux-pci+bounces-22400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CB9A45346
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 03:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8612D16BA0D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 02:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EC021C9F4;
	Wed, 26 Feb 2025 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hCHTDNen"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2060.outbound.protection.outlook.com [40.107.241.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E5721C197;
	Wed, 26 Feb 2025 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537846; cv=fail; b=KaFqMqqMBo7/kx8D8MUUOtU+tx/eEcKuPp9/MYVhB6Pk3BwkNqoicZDBWwnsN8WSIVLkZXUlPTNCD4aoK858ZUchWOwKuKt9lisNn1wEE6+zMCMLkMqHlcaDZe7VVQiJq6DIWHdpT6ug+kzwf6maFRRZyl0OrjQCB3RXQG4V17E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537846; c=relaxed/simple;
	bh=CIT+hE+j9szy82dffZlVmGqICUA71BSOlx255INcehw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qoM+csCNlgKcUSA04/NM5frwgqGAfINBihhbOLk5wV5xx+7z2fLJ7Q/DyRigXZyxqt7fYscdHZanz/WSIICYnLaEM8lTKsmgTajXYIuYS/7Kj1zBZltEmDoQwnNpovcDBSqhX44rT/Lg0ynEOns0q7ISjY1t0hQ6et7gHJdGJyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hCHTDNen; arc=fail smtp.client-ip=40.107.241.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMEJphcfQHGLTuN+o+M74k1+45yNzzLcuZ9bZP2n+4SwztlKAisWiL6BGRlw84OJb/wt6v3MBQrwiNTq7DZLhDfvbrzyYQFtOWDhzufErYb1MHQtQZSspTsSzONswaN2UIOlInqMQdT8Wm7/r6CPH7zGVc1rWcVnuDxlqxqH0K2f+pNTu5uzqwTTMRpBCMzFDJ20s2pl+x8T+xnmu9S8dTpz+66EGX9GJDcx8WtQkINP1jFdrO4twve1lOotl0S1vY2mU+LALw/sluVbveRX4ccBFfHs9PgL95zxMmWr29ZspkbPV0+UZqJUctnKK8dzuIr84nV+tI+ChlU5j8Tqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9naiSAwXhkX9XnnDuXDajGQ5uNqQoM403e6LVYkOfY=;
 b=k+/z9sIK7Yl4ymaIMJUtq7wTfQmYnSkC2E6hU7/GsJRrp+zqJqOoEARup/nJwbI3NsLaT26wq5hwf+Er0qG6d050FevlM6LewyF4GnY6M9slgVXLbqNfG82/7Je0HwHIamBT3P+wliFeHsgJFZqBJqLtGBrhJSn0yjyW1Zd9VR7LRkuWcRYZWA406N96xWbTRJ6OBP9+PqJoBVO167n4cWnl1EVOmBh0vTtmLDnPa11Nmnctb84JkUX8cUuw5y92oTBweKr7XteCoXK/U/McH+oDsLb7gSVh0nXLzF3pZI0lawQ10gig50sy88MjgZIipXfP6M7CudZDtL5kufpp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9naiSAwXhkX9XnnDuXDajGQ5uNqQoM403e6LVYkOfY=;
 b=hCHTDNenCUaRqH44csLuLrOuBMV5qfyGhpaHE01J9eTtE8NBl2OPYzDMHAw14OHcBqJrcZVweVu61KeMR/J/Kg23+l9AmBaWpeOBpp7QcvwgVN4aXhNfnxfMssxnBInAywl9FuVd3LBEJd66e8YaqZONbEZjZOrNdpuAajg7hideiFNsc/NIylz7q1MayY82r3Z5LoVkL7uARhcc4k1iCWA/2rUrn1p47lU8FlYfIPHq2O25yEbypdRmzmLYba4jgBSVOF8KWLxNhn75sxmElH6R76n1ZpzLl5LxtK291KCm3HJEeEzWqvffuoolP+pjQLV/DXWOz64DtTbVJiR3Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8387.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 02:44:00 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 02:44:00 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Use domain number replace the hardcodes
Date: Wed, 26 Feb 2025 10:42:54 +0800
Message-Id: <20250226024256.1678103-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 2727a1bc-6230-4ad5-86c9-08dd560f6cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ICmenG+xJn2OPmMJxgyG/9WjbacoO9I/zg8Ricwpw3Zlidc8pL4m2fW/WRJ?=
 =?us-ascii?Q?whxW2/KDpnMqc2MrN4aV7DonsU00RXU7lZMz0ysiOXdE/h3oRuy9Ci+Ly4NP?=
 =?us-ascii?Q?druObzTQnuf/PB70WPkwOE7Vv525C++cmou04O0f0wq/VJ2poJh0bQelq4iv?=
 =?us-ascii?Q?WkDaVNz6cxVtyykWnzSHx9CO1tplLzfqcZYYt/RgQWovcutaJQAPjDtDEi2y?=
 =?us-ascii?Q?Db3lRoXNLBWmUJ4yNssjx0TQx4WciG1ju6svtrk5gG6OrEfxq7Kbwss50nxa?=
 =?us-ascii?Q?QMRqD8XXMJXbF27qlgIBHsmSFx3gHYFFpIBgEHEPRprbZAPC3jrTw/9cvlQL?=
 =?us-ascii?Q?TI3iavKj9DmRPyRFlK7Nbg2lDHBM2QVSrzqMGpcQSf03P9bkRM8XALG3+TLG?=
 =?us-ascii?Q?R93WCyLPnALzNcEhjhIKpx6Q3C1lLr9p5i1d5lxj+Jx0v+al5yFzpjdIDSsG?=
 =?us-ascii?Q?HscUiExyLiReCo22DfuYmSL3pIBa0R/Kb7sozafx/53muls+qhp58lfB428Y?=
 =?us-ascii?Q?YQuEFePNOiULY6u2bVw9jljSPDLGXmTCMtcKRTp96SmmkmrItiPHn+VjMuUJ?=
 =?us-ascii?Q?aLiFHLsGVinNHSp6iwjNt2PM3z8ymFfrEA++SWvg+oM4aeMuyLSXrE8en98u?=
 =?us-ascii?Q?Aqohc5W1U9D8r+k9L7dio+EKILgffOWU2wAXpFClL6hfBF2Jrn6gLRSXHscA?=
 =?us-ascii?Q?ofumjHU/+95C8qHBli0EnpCMnaXa1zI897xXS+v/gLdVGV1UFb27lrvI5Q9t?=
 =?us-ascii?Q?/2uh3he0/7DD4Qnu0i934RwlM+PN6KuU8Iv7t7knHhBi8b3dBjfW4gfsF53J?=
 =?us-ascii?Q?iPi5GLXGNQbAVzOg+5R4Z3OaLTe06v41rzCmgg6rwb2F8zqlPhBFNAcxeD4T?=
 =?us-ascii?Q?+gt9xZJ1iZgUzW5iwa+wzsyyV7MMrD3SzhjtapIOYIFIUUwz6xffjfHKBIYG?=
 =?us-ascii?Q?T5IGn+bCD1TCHBBoA8evx/nedtL4yazo3w3vtfj0njfZqTmPAfuZaznh+qVa?=
 =?us-ascii?Q?SnbAzjKYprqBo4LvKq1MMUyVr4Ic0vZJ5lNtaGtQzyIfebJ1rIXDBqhDtBvD?=
 =?us-ascii?Q?YDYw81WAxp5OB0FHTCRVo6dDpsEHYMbfxPn0zYdqa5VxhiDgCuohE8Td2wnC?=
 =?us-ascii?Q?JsTlTChL3a53akOSIVd8vCusFGpG/gn4qsMUJ14gJIWFlhywwqAVjZFnNIpG?=
 =?us-ascii?Q?bk7yKK++RHSThaGCiwJNgVSkieI6it946ieQg5i2ATxGdmdd/ZKbLvVNlN7L?=
 =?us-ascii?Q?rf7nzPhOiYCT2vVRzSJddzEnPedSip//6lXGbkK7pZH4oMa33Sn+tWaoynLu?=
 =?us-ascii?Q?BoAJLeezn+pKKiCSa5mqo0puVf90tvLCYP+tfpqiHGI15f7e9zCUworK3gdc?=
 =?us-ascii?Q?esj1239iXCTvlJOwRBgW8seGY4ejUF5v5YC6GKZV5lPQ3JREbEkpV4OUNn5Q?=
 =?us-ascii?Q?8NNUqeFTvLiV1IRg7ZRtBtiu0gN05u7z3l5LE/wPdEwLts2MnIAhqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HluluSKwPRsmv4sDxcDG5yh+Vn9JbbRR1LhnusLCdz9gbzK+x5AXRitzXtjD?=
 =?us-ascii?Q?POLp3nlDC8OklD/GlYvo1HX0r1e6lljL0Kff1v9O6Mk4CKADkKG6rla86eWe?=
 =?us-ascii?Q?nY11VS6vpwtsSR2PTUC89pOLiTo7E3cPp8/0utOvMvVM1ZeV50Zx4IrRYqNJ?=
 =?us-ascii?Q?MGFz/jVjdrGz4Ef8hJsa44AJ9UlZl9K0gPBHQpx0DAQtqUnNAQzLIDS2e6nM?=
 =?us-ascii?Q?zFLFcZk2lhUuuaVC6Hn3t0sCbcRWHvlJzqYwOTeBZ7HaWiOOpDH82jnHXC/g?=
 =?us-ascii?Q?jTHM5l/w19hPjpvjdRuKOo6SRtVINqrhUJGRI7vuNQyRjrZtV2N1HcnHAYWm?=
 =?us-ascii?Q?StAcydIbAaEWMVVZ9S7cxbzsn0+U+LC7tKQ0r0/OQagyH+6nE6i0OR2nd1y4?=
 =?us-ascii?Q?r1dNTfP5NnUieFNTpjnccPc8QAYPDCgisXcIeC+yp4WX4kQyg5OK0LY8BuxM?=
 =?us-ascii?Q?5jvn4M2Abopp33IcotELStnQesN1MTYgwv6wtKpPOVMCyHReRnuFEdrEIofR?=
 =?us-ascii?Q?3qmimEnguDvJaM+PcS4voi2fYSSOJH+p0SMvZ5SVlxF0jnodUnyQn6nZUvWs?=
 =?us-ascii?Q?il+HskRIbTcynkdi6lIOLIoopKzWemdR4Z8vj6TdUDwkGuuKE/XjodXOWpsT?=
 =?us-ascii?Q?rW5YRE5/5QN8M1a+N1JUrSzlnpD08obn2KO0hCfihRBcXF5v6M4GAz4nxbUj?=
 =?us-ascii?Q?Kq7dxB2jBULZfh6I7OPs1Wni8Hx7/KBcA4WfouFh2pLbO9oNex9V+yRJtz7p?=
 =?us-ascii?Q?BkpBiQ187BejhKMZqird8XqvVH5tJeaCkrY+h1KrDXQAgsUyZGuo0/Mm2vEP?=
 =?us-ascii?Q?+EumrT8VHNCjkrfRgeN0NR0QozerhiRm4iIibfip4rrVPy+sISeoP+DHSsM/?=
 =?us-ascii?Q?mrHGkDwYhQqp2UZzyy+w2Mclk/RD3lzbGIUE5mCjXB+WcBmVWYcbZI6/SSA3?=
 =?us-ascii?Q?CqoyBA5h2XVLEWzIHO8xte1A+hlycFyJbI/jyGFtP2ioMWJrvZRvh7b7T0oF?=
 =?us-ascii?Q?C62lE+BMKWGOTPqydhfgcD7XHntiRmn8p/Hrix//SBw0LQV9yYWOzkgIY8LV?=
 =?us-ascii?Q?UYPEd2SQFAspCMFYd1cPTboYTwvqNYbVHr/2DQ82gKpTWB18l/3eEfuttHJQ?=
 =?us-ascii?Q?9AhIMAqKOjwl/gE1Bk0KT1SziKiiq3KkFpeCPRa9rQoVi38oGZFgdFuMg9Td?=
 =?us-ascii?Q?MiXxqU2oixwu0VkoY9m6YC1L23tMHkAUi+5iDOOCLoSPca8LryGqoeOxE/b0?=
 =?us-ascii?Q?bgYJcLOgIb6C/vsW0nklWCYBsYWY9jyx4TztRQIfu66V+YmRVdlc+d6tNhUv?=
 =?us-ascii?Q?+aal1AnnJBu3Ars7XctVF91noKlSo38MzHQCAPFgnsiZCtt+j0PMWQXTASya?=
 =?us-ascii?Q?8yw/RTu2PiLCZOz5co7PDElMT85l4uOnEdBMg/s0GInSI23D3K8SR+2GTvcG?=
 =?us-ascii?Q?E+pSk9dhRTAZbdohjr5cEcLqHNbCdKk6OyhYxaq0GjQOsjslktpibp1gVxmj?=
 =?us-ascii?Q?mFVwK33aMQa6VStJuSSFLVFC5vz2Sb+iwnbE4Xq+xQ31LcbAI1ozJxWcmwrw?=
 =?us-ascii?Q?tTP+8FyKf76a6QWs+/F356UsrvtVP/Al1euN3pI4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2727a1bc-6230-4ad5-86c9-08dd560f6cb8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 02:44:00.8280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 596NMRP6vhhM5nZI0HCo99G+uzfJLGT3/YWyE8zQh3On/y9HbW3ArV0expXpSA6eLCf5byaS1xFkhkEoDGEmuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8387

Use the domain number replace the hardcodes to uniquely identify
different controller on i.MX8MQ platforms.

[PATCH v1 1/2] arm64: dts: imx8mq: Add linux,pci-domain into pcie-ep
[PATCH v1 2/2] PCI: imx6: Use domain number replace the hardcodes

arch/arm64/boot/dts/freescale/imx8mq.dtsi |  1 +
drivers/pci/controller/dwc/pci-imx6.c     | 14 ++++++--------
2 files changed, 7 insertions(+), 8 deletions(-)


