Return-Path: <linux-pci+bounces-24734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C26A711D9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC1A3AA822
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387FD1B808;
	Wed, 26 Mar 2025 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xn7ccwdy"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF91A3144;
	Wed, 26 Mar 2025 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976046; cv=fail; b=uFBPXdaLdiH9DNbu0G15xBVmaBTHIf6lKBEN+RiFIeMuxYXZjwqxbEXwNOVRSw9K5r/WYZHOLiGGtuZaXspQvxjXFokQ7+j+VU7VH3LedcKkz+l1v9bRobz4xtoaD3JabW0cUvC344yBqZKdWWSG6jvNwSRFV1FoO87iz3EqOyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976046; c=relaxed/simple;
	bh=ecEhozmkpuCzpF0PPieMXp0Z1BjusanvnIMz0ECBv8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t/O/pVzDyBadti7u1eGLzTFzKcRlkanSJ+8owWIyF44lx00zAz6e2aNnEOqyAoyMkdJ+zRf5mIhGI8H2+VckqKCXq25rSLPp8jbM3wRNqYpay51gQINyImUCAZf/tzyyQ1AHk5rM+DhzlFUEQkinMRRsNsTurStjvUYIP7Fb7Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xn7ccwdy; arc=fail smtp.client-ip=40.107.247.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxzXu8Uco9UvMnRLEItOG4ZsUIhek4Y0vOI0LO+aY4Zg9f0CKllsFF1rtl7Y4wh/LoT9NbXCVUjayIwc7/VIZ9BOJIRIObgou7StsmVdAWjFwPh2C/iehwhmh/EfTVdJhpJeZHUUOVzJBhQoO80+25Z3pgpOmeXDtbb7QidA/II1r464UMMouJlBATPDbTBUGlMwvBQLpyDW5VMViNOZ/+foDbj7MkNn0wbXECBkLZ4hfDsj0Pu2a+EQRzaQQPAwhTxgKi12mK4Sf2WeWY+HuFq7R9WGRNBCmR+cDVWuAfbC9OFA6Tj5qcy0N1opelA3KImYnJ7uti60oekfXLVT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01lUZ5ND5Xaz0Sli9opUe0Q+CxfG6MY2HFgv79RuFGI=;
 b=fz87QyXg+dYlUYg3BCKVJCrqXX2ozZJ6RAqfWxx/DB6YGTK8Oc1RN4hNBG5UsTn4E6Zhm3jgX4CcqxlHLXprnIAuEmzrqaOVrtoVx1GGnKH21w2brNRWnvsGMxpiLIV9rqWU7iY8yL+wFQV5Qu5We0OIUyTXMzWE26pT3gBnDFhEwvC9Bf03XDNt0dGGUoTlS+QrZpp5Wvo959AVClfQ429hF7msDBkgg/eDcLJkeG7Mth+Kp4v1+uz8apJGSVveAXAZR61hGmC5d2Kawx7pjIXdb7qhiQ3dt/K3Sd+YUdzREHDEdT4SydWHhbAuQqCBBq75gNwI2P54jLVnn00Gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01lUZ5ND5Xaz0Sli9opUe0Q+CxfG6MY2HFgv79RuFGI=;
 b=Xn7ccwdyLrF0YX+V9F/bKSsRZm6WrvWF9GcB+Uql6/EiGXZhlrldl6LLz+ASe4GhxQMSXXg4qlLh/09++ndlpVVq7nA6NeIvYrHSjf9wbH1v3JHp2pcWC+75ywUf2l26Isz2hj51hv/39m4x/g21WaRSByWfcHslLfOPXvEpQwtSr85TNWmwYcazBH/VciiKU6adFbUWyCNUxtVSFQ4Nd6OFEwm/+UEDh+gYigm+6EQaWJH5nZUEu2H2chwr3MIRC+jJ7UaAgJ4US4t40i52yprELPQFPO+FO1yPPVGzsknIjql0Q07deSOn5/DSfBXVb7rxYpqXJ6cvdUTE59d5Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 08:00:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 08:00:41 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 2/6] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Date: Wed, 26 Mar 2025 15:59:11 +0800
Message-Id: <20250326075915.4073725-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250326075915.4073725-1-hongxing.zhu@nxp.com>
References: <20250326075915.4073725-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: a46d60a8-0281-418f-4429-08dd6c3c4dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D6cirggQwh/2uH0ujFkgRiJPnHbiC65YOko2m0pwOSWKCisnit40icBTrso9?=
 =?us-ascii?Q?AggCZUns8Ee+bQ2zWsN219oYG6jdZBcxZNAtFuNC3iUbU/yFD6VIVtXjR1li?=
 =?us-ascii?Q?2SDnchh6fk7XmawK6qqkBUslM0Av416V8X39YZTjTfTSaKJF5z5f0YrzniWt?=
 =?us-ascii?Q?ozDoO/b3W5B5xBGfvDvpTSHCUXenQhqNLT40o/3rQvyepAKrstyjeY8A0Mly?=
 =?us-ascii?Q?NwZ3PdydUAa/anmeHKPSEwwhsiLMdflKRHAWHgk8B8cQuWkqQo1Sh4JWCSrM?=
 =?us-ascii?Q?EUTCXPTnAnyvmm+0GKXuvmF5kOQkAQRZhRLekyfkOYYLF+lCQTfZO5kEMNAv?=
 =?us-ascii?Q?PW/J63RZNh5k95Emq1pgBwYFqYsrKf9bsaYQOP5X4uBMkoxKleSWnES6/tVq?=
 =?us-ascii?Q?1/ZBqn376GOnv14O4L7o8fX1nBrm9dYAxZsJ1CHVNUTYgg0Da1GF1EZkU4Wn?=
 =?us-ascii?Q?f5eMkMXG7lpCTK6yq1UHQUeDFCcasejTmPKXerp8lRYkeyQmxNCILRlrkonG?=
 =?us-ascii?Q?wUOPSikSsNDZLUbsaQLQVaOKrqoyKF64lmMPdmyNdqBVU73UDRYtBGwrH5wJ?=
 =?us-ascii?Q?B4TaOqfPf62k1BNp7xj7OYEBVD66CCaA4m7+/dzPZ7k2RlN6HcGMtFurMrMt?=
 =?us-ascii?Q?85PUSWbSKZpweUobC0vGhaaD2TuWXkutPOt7kYpHcqjgkbuAsZeUwixIAk36?=
 =?us-ascii?Q?MhVUk7kQf4l85aPrMVhQOWww6z3zzVT14NPPl3m1GVuCQWA9xzMC56ESAQcd?=
 =?us-ascii?Q?KCw2x0lF+XWK2tGxVhKItLF6ZKVgqShZHMkAPw3PKNU47DYn+n0c2tuQrrHQ?=
 =?us-ascii?Q?3Zi/Jle7dn1h1hirSBLgbEXoEhgnusdlSWTzm8PuQrRHx30gYNajy2Xc8Lh8?=
 =?us-ascii?Q?r4fr+1cZuf6NwGvbA4kOJc+K26tQaRVkSa9eR9G5FwL2pJ9lU4Kdt4sIBj4c?=
 =?us-ascii?Q?wY9KgAviN7XsQ/GIw8Vy+VbbgVvmjWmeTCUezaykhTIaSMn+QiQik8sSE/YG?=
 =?us-ascii?Q?UMchjPEOrj+GuCQTgUAbYW580O0L2gxSDE/83Slkne6TK3VEvOPdcUP1qR91?=
 =?us-ascii?Q?WpDAOOSg9t0zGnfhXP+hZgoPjygCMfRrWvaikvjt5a0DDYd8x9dvkP/Ly+Co?=
 =?us-ascii?Q?4ENbpbv9dkNgv3Ng15S2xls7XPD0JDA61wUP29Hj0sBvdIo+F8z7KDWzrsdP?=
 =?us-ascii?Q?g6q/ZQy5mygleliWHbFe5zObA5u4BiVYub1X0H5yODV8cBMYk/upbfmIfbpA?=
 =?us-ascii?Q?DZGuN+RHDiuR1jNjbkjX5zJrJ8+mPPDzHXoxin7JkKugpHF4sirGRi8PPdXB?=
 =?us-ascii?Q?N9gm1V0ggWeaa1Z9O/CwY3JQV2yOKSWwk4F7h6mUHDaZCRVvDAWBDIurAwWb?=
 =?us-ascii?Q?qRJ5SxKSmuoJuOPC0JKLMJMePwK1+SztazPZ/zoZ9r1FRpf6bJLNH2SYUCld?=
 =?us-ascii?Q?RQcQ3qoKowGEIpUHG6aO0b86TRFqf/cbVBB0j/5LCveM90nFAKB9fg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?un0dRJhozEp9jQHBztBl011nH1TsEmxLLpDo0j3OJX8Rca20KjvcNcfU7jjO?=
 =?us-ascii?Q?Vc5CxeLhJZNJ8VmHwDQurIZYqsGVRiohLCNwD/jpCRh9fM45aRmrVWxlrqWU?=
 =?us-ascii?Q?YrpzcuOyJwwbPpfSfTcaxtICHi2ipikkDh4q98FAjSYQtqC3K8LrpsNDDpqy?=
 =?us-ascii?Q?3TAvrqDF7QnWs+IEi8LpyHo03HB0c1TtZXWKeDy9Mm25zWv+93p45kvonoiB?=
 =?us-ascii?Q?NbBWf/Kh2cWmqJ82eWatPXL9fhmyED/RnZ/NjPmJMoEQDCgs3xakvdNUnUOh?=
 =?us-ascii?Q?ma3t1yh/94iLYwdOwsrcAGDXsygpN0FM3QY/AWYRXF1P5PzJg0RL4CvDmq5a?=
 =?us-ascii?Q?p2Snt+BbC5JO5yfaLBtbKd6PsFOThKOOCZip3X/btxZEHXA8Pkbo3R/M7uch?=
 =?us-ascii?Q?5oeosXr/GcXzw0dpQWa52Ox/UkBYm+vBxDUUdwiDvxfpEchC7N/rIYhIj3m0?=
 =?us-ascii?Q?At2fn4mRoBzzyWermztGWu9KaNQJUF7uFkKdsur6e20jnAogz7MKjbXxL3N1?=
 =?us-ascii?Q?83PwjVPCUOhvCYC9xFA7aTqjsb65lRWtqvbiKLQ2GQ6nAqYU/q4FTbdOQtL2?=
 =?us-ascii?Q?Bf7bzPRjzr+zVhbC5dnLlPRuQ/XuFWl8RsCa+N0UTwnkncngGh8I+KVnCgVj?=
 =?us-ascii?Q?ZCJCbACGlMrQTE4G+9h8hQzWzhRHFKkTk/oD9U766Sbx8GU9eAwIZRG7Q6Pz?=
 =?us-ascii?Q?7cNAn+JS4t0NW0mM3h8UxsY6jpvihW3PCK93G0DU7qEO/MuujGPCvJTcFwLK?=
 =?us-ascii?Q?1RfhdW4aqph94WSbAe6dHgh/K0+cXMltJXBmJ8Ty2qh6lL2PVeMSwZOoiqMl?=
 =?us-ascii?Q?kNyzr/0AZi4xzokD/ZzlrRQTVm/S+IXGOIlirF73/ID972e+/HjHl2rLmJGr?=
 =?us-ascii?Q?t9d/+MTHpVOa95Q/k2vL4vKfho+G63KTE/80eIl4mcLlI5KbrSYP2SIojUmz?=
 =?us-ascii?Q?ll7mjJvkKhG3ZWLtwjoC1n343/EKjBEblooUWdZbZaCg19aHdFvqUbWtjn87?=
 =?us-ascii?Q?FH0i8PvYW2LoshHZFnhdRuGgXKzT7ozbAIw+NwXzeTeXKL19aUOt3Z2ox89p?=
 =?us-ascii?Q?edkkcyM8hyplg+Dww4w48N3goeOpleW0YMbwmGaQ7Sshuu7mhRaeJ2hwakt+?=
 =?us-ascii?Q?FkB118svT2pR1K85kiHIfVnJDNkbhuOvdtxhl8t7kc4RK0YlBB/tPTl2zy9n?=
 =?us-ascii?Q?bGxliTn2klOMomRBjV9D0XI6rjAG0B3pql0ncZuThiuMqUQhtCGIRzypV1C+?=
 =?us-ascii?Q?auiX/EOYa9pRKrfTXdQsmtzDPv0hgYo4xSb/Iq8hCVf2AJIcc4iX2RsA6xra?=
 =?us-ascii?Q?CjvQNsf7mh1IKf1foKphR/RFqYHVUo4pZUMVzDYzIak++w7rfh/9t1WvwVOC?=
 =?us-ascii?Q?AhsTG1bwmcMt76yL2Q26oZba8XQ+Nz5KOcTZPtdtvVQEJjtsoTluTBY9rFyy?=
 =?us-ascii?Q?3hgWH/da+yVykQo8F4+cu1AHEfA1wVNdDPy/CEEoKGZx4LkhclXXxxSsag5h?=
 =?us-ascii?Q?LzAni3q1H/Wm7pgvdB4rkDUzbKqvx4TNtwFkf8gDtY5mPfFy7/49iPAAFaYA?=
 =?us-ascii?Q?i0WIRGaQhye65dYQQpbKQgPL1IEpVo8GdP5gC+if?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46d60a8-0281-418f-4429-08dd6c3c4dbd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:00:41.6546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLGdCPNGR80FtGCyRBMlME2Fakd5MFUacBFwbhk8no+D19JBGZQVkgvYyuFu00Nr4o3ROKdXlMLvk0ND2G/Zdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8948

Add the code reset toggle for i.MX95 PCIe to align PHY's power on sequency.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 57aa777231ae..13e53311cc0e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -71,6 +71,9 @@
 #define IMX95_SID_MASK				GENMASK(5, 0)
 #define IMX95_MAX_LUT				32
 
+#define IMX95_PCIE_RST_CTRL			0x3010
+#define IMX95_PCIE_COLD_RST			BIT(0)
+
 #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx_pcie_variants {
@@ -773,6 +776,41 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 	return 0;
 }
 
+static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
+{
+	u32 val;
+
+	if (assert) {
+		/*
+		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
+		 * should be complete after power-up by the following sequence.
+		 *                 > 10us(at power-up)
+		 *                 > 10ns(warm reset)
+		 *               |<------------>|
+		 *                ______________
+		 * phy_reset ____/              \________________
+		 *                                   ____________
+		 * ref_clk_en_______________________/
+		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
+		 */
+		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				IMX95_PCIE_COLD_RST);
+		/*
+		 * To make sure delay enough time, do regmap_read_bypassed
+		 * before udelay(). Since udelay() might not use MMIO, and cause
+		 * delay time less than setting value.
+		 */
+		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				     &val);
+		udelay(15);
+		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
+				  IMX95_PCIE_COLD_RST);
+		udelay(10);
+	}
+
+	return 0;
+}
+
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_assert(imx_pcie->pciephy_reset);
@@ -1762,6 +1800,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 	},
 	[IMX8MQ_EP] = {
@@ -1815,6 +1854,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
 		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
 		.init_phy = imx95_pcie_init_phy,
+		.core_reset = imx95_pcie_core_reset,
 		.epc_features = &imx95_pcie_epc_features,
 		.mode = DW_PCIE_EP_TYPE,
 	},
-- 
2.37.1


