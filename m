Return-Path: <linux-pci+bounces-30167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC67AE0168
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 11:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C26C7AEC57
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FDB26657D;
	Thu, 19 Jun 2025 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B47E7zJp"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A36265CAD;
	Thu, 19 Jun 2025 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324327; cv=fail; b=d5IXVWoxzi7hdyx2UNvrEn/F/Z/9Ddqq7BrDDeCqhEHJoL0Q8L/zq7ubjZ572PZINSrojhxQxvVs5U4Ft9IQZFtHGrr/0yv/aDq43fpvh7KRkM0AMZxNRUU0ttRkVAsVJqfCyAcg/THo8/hZeTtV0MBg4ALf4wp43hGG2LBLG9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324327; c=relaxed/simple;
	bh=zwDdfLn0NRJ9HjxGfaHpoRSWsCKljVqRYgKegcxwG9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOYchgyiWJEN57CPtyxuI6DLpSKpNZ4c07f/prmLokCslP0MuUzjMtj7Rc2CBLI39x2UA72U/jUGjRVnez0zdq8B81kdJI2HrTSQzcF12Ya/DCZC9rz0VHnPBRBKlsPCeFdxuEqTQJKDqk2YaqqTphN8uWAT905tlS36VuMIiZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B47E7zJp; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9Ou22CgdgnFdB5dHo55/Yzuszz+mjW83f/U4hmYeHFLQQtpfmx+lIjf3hFuXhihmQI0Pk+P37TN8ZhnMQPmygjm9Ju3OWLpwKmPYaLTNXH8n7JhLVtIk1ucuvOSAC3SPN3BqpEKpvzdzWQ8PLNZ80Ol6iJqgb6UxgkFspKkafiSWYqsG0A1i2sdH9jwQ8v33ORgN3v3tEvctwD5tKf4inEazjA8lZtrsok7k6fIg5MjHnYBlVTd79l6OyerBOcWML94NR72EcbZJH33PHjE/EDnM0WiBQEwUEqphFSp7Rb1hoPt3ogxS5fgpsuXo1nXptGvV4caLhkwNz5cvoTkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMm2V+LTbKwOMniHbv/3EujF3xj8VC9QDT0WuHVky/s=;
 b=Gr3BOl1ehZusMRP8BZ711zFapBmxgBFEOSENKl4P2S6l7sGBL1x03CipxgHphDYAg3bSQpzNWunutA2bv4h5FoyBx7IZzB75T0Gt8WZQgYU88r/a4cMknuewvVnw0Y/uO6KdNEgZOnxiv+jhs78Lgyz28yBVyyYldqDY81EUIoilFU1ik6xJZNrhfiovEJixhcHfjjMYsq9BMGfBBXDSeMBYXsa+IowlCfZ7Z/56X0XTyBsTZl3SSJxHZQsQiZO9EyaJtyUvgiHva/AowHaQBR31lOxLqOLPrBBFAYgsOLjYyIy2VwAStadsPTHBVC0bH1dh4/UXceWzzI+kQwcOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMm2V+LTbKwOMniHbv/3EujF3xj8VC9QDT0WuHVky/s=;
 b=B47E7zJp9U86BBbOPLo7kf//ouq76Q0ra1v8hqX02KBKSb24e+Q2SrqIfIddeLLdtjXhz/3hX8nnDm+QbjNtJYs5/DFgNp2SsuYUfxr2TzQbAp498zvA3UGWHGUAsZmgDx08o9c7uIBDZAOcgbt2B7M/D3uR4D2MEoMNDbwK5oYrgHm7832Hq0RYmweKtWhiNqpPJnyMhYOMXd55jTpAFc4mj0fb50BewYhOYa2dG68yzpK0ckmGZYxlkoksLaSHqUzTIqCQQiGX1N4Eqbf8JQAb6D85qv2vBC0sCTjF3egsGvQBXuLuWlkNVFCN2AxVpcvX3O3AYjlTY6XGJZzdfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GVXPR04MB10084.eurprd04.prod.outlook.com (2603:10a6:150:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 09:12:01 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 09:12:00 +0000
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
Subject: [PATCH v2 1/2] dt-binding: pci-imx6: Add external reference clock mode support
Date: Thu, 19 Jun 2025 17:10:03 +0800
Message-Id: <20250619091004.338419-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250619091004.338419-1-hongxing.zhu@nxp.com>
References: <20250619091004.338419-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|GVXPR04MB10084:EE_
X-MS-Office365-Filtering-Correlation-Id: a4897534-dad3-48ba-dcbb-08ddaf11593b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+plK+K66PaV8UqdXCX2lUTZI3jMPmPRCuv8T8YomqtwXX6NGmaosTKd5ZaMt?=
 =?us-ascii?Q?gjd1gLqSwm5/TDtU84AY/C6hzKRIYyVyHicJUXJNiXc0J50QB8YMpVtIkvKk?=
 =?us-ascii?Q?V4uwvsh9euav6bgFmvUdo3QCVIr9IoQmGt45Hrv+dT14fQVa2WxpjqSqi8AC?=
 =?us-ascii?Q?/6q6za0+lXfVVILmjdQ5ej9mS3r3eANVqnldPqCRIg30VqtCZYnCWSER54mt?=
 =?us-ascii?Q?WhJ7h76Ae8VsyfpzE2WMyzgGhGi5KXedMTjlI3WpXQFoDSDrKHl9reMZcxO2?=
 =?us-ascii?Q?nYcN1h0ui4OmGK/4Mgu5fXzSHaA/d/u8kACJIh1ASICOzC5elo/q+mgfQtaV?=
 =?us-ascii?Q?tt0VEH6/wRhWzdmR34k8c6qpuELoXTwwxLJ3D0hBkKAfF6gkPmIyY9T8CKS6?=
 =?us-ascii?Q?9eNYrHxUMzBikdfG63K+7fb2YjI7cFIg0HrAtrK2BW0/pulB8wSZmQSah7Xg?=
 =?us-ascii?Q?Tk0xsFblIt4jE4oH7EjX4Cwt56oLP1SlBHP06R4quufrsHeZupif1Z1N0KPK?=
 =?us-ascii?Q?AFrGGoXOBbjW+chb3byKL1MVz/8wOrNM+wccVKV2QrfjO7A4dMnkyLHAcZ72?=
 =?us-ascii?Q?whtb0/UWduzT9VY2xoLnNCHsjjGxMIT+5qc4FpIp9QbDxDdtzMILykyuIDvC?=
 =?us-ascii?Q?4Nm+aUe5It59npMuxn+lahFbrWpkrp4iyIn/TVnZEsj/q4zIITKj0frZ6F5y?=
 =?us-ascii?Q?iv8dtBohh4vGXwXgiXiwDI0Z5goxBjJYSBMoEO4yEqzwxJRK4M+W6WHR6vJB?=
 =?us-ascii?Q?TUua2t5plN+6YTgLCeccqnZn7Lr70hvy85pUoFWsaahDBJagdq7eMS2iqXHH?=
 =?us-ascii?Q?bffvDf7TQAmN3kPtA+AZqLz15fM+68QvgjAyGbWGz0C5us+nyasohkNjAUrC?=
 =?us-ascii?Q?DOgOUiZa11PiKCljv5RQUc9K5GQ6gCTrM+6G2jlfUv1REoj5qbiMGheUEA58?=
 =?us-ascii?Q?Br3LQx3Ebkd7r3TMAErX3T5U0ZnCIM/DXVemMomoL34VUGz/4Lx+HmRfS7h8?=
 =?us-ascii?Q?N7cxYYnhfuSn4SOwVSiWLwcqVu6EzZX1MtpEzgp6W/Q5lSYs+BEKaXc6VwN4?=
 =?us-ascii?Q?nLfpQZP4rT90nGXMxxWVjXLQAzor7P8eOhA0xYNIgvLLdfukKoRMvk24JPZy?=
 =?us-ascii?Q?NXSQqQ62oHNi2ygLN+TYYFIynFKslyAJQPwKDK73H266rkrKik33Edj3U3y7?=
 =?us-ascii?Q?VDVs2iMjWhcI4k7ecwL/7C5M5TGFyJ3lLPNV3x9GW+Y7WAcFOZFW1jq1EF9Z?=
 =?us-ascii?Q?ObQz5oRxmbrLdtAk+GA8vKOlnm5Z4jTk/WCGyswP30Oe7P7WU2aQ3280Boe+?=
 =?us-ascii?Q?cww3eVjjBctak6a3wBbljcee2/WdVLPFgBIpyy7GNnGys2BsNU/I0xHtHglL?=
 =?us-ascii?Q?VuwYDNUtihqM9RBa9Fkww2FjvE36NXOzZZ4v+Ip9naBbt5grZ5ST9/xld41i?=
 =?us-ascii?Q?Q6Q3uKrUyzwnoVZj35WXJxpOgnQdPVck1hXutRE0fDkIIosIoMKJY/viV2ri?=
 =?us-ascii?Q?YQ6KRnma0hd+KLw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9DlyQGUX2WFS6SYBsAuyWXzwIdvRVyIy+ZmLt04aotRbfACLSFHlSxirM7S5?=
 =?us-ascii?Q?eS9l+qg8u+pPxftxn8R1Z1p54V2lzFzss9AyAsgX4bpeVbQlA19x9BX7Ps7D?=
 =?us-ascii?Q?jVIOCvAL1wvnYWop8B7SeB7ah7L2VmylxOC4VmCW5D72BthtCmsB7v5gjCX4?=
 =?us-ascii?Q?dvmlLi/9QasNEib7ToWXmNI70Hsf1xjq+IYKHcpuNk3d/G7WrY+OKabj0Ow4?=
 =?us-ascii?Q?/YSzunGtb9yjlvPR61ZrG2lDoCIKEiJLxPlTsdbh2JTDqYSyRtEYBdtoc9Dn?=
 =?us-ascii?Q?OnFD4d37FIXQqS8YbGqB5QyJ3HBJs9DY7/TYzSe7GkQ5uyg0WhS4I/g9va+Z?=
 =?us-ascii?Q?r1eP7hPwyM+Q4Ci4hQNiX6s2bikl+nPo4nwBboOeu52GctmaIQx6PKyveQmF?=
 =?us-ascii?Q?VfKspr6BXJU+9gE45hD6n8I+562Opl8+svdKgM5ZW6tCirkq1YJTdgAT5i0f?=
 =?us-ascii?Q?trR/IJfYUElN2bo4ag0APKow9EwswyEHrFlhmeKhOpKINExIxfVmZrD5mktM?=
 =?us-ascii?Q?5ti0e7v3SBc+Bknan6Xv9owUe+9cUcF8+avJy9W4cOiUtqlHN5+nZRe+5BdO?=
 =?us-ascii?Q?KTItm8v9krFNgPGDpTwGJR2lrYeIVYwjRiOogTdGlusW/b0cOZPy2ZXz3/+I?=
 =?us-ascii?Q?1OCD+qfBnDh6B/eFmgVW/cNmPlMfG3Q6+hnr2224ZwDXZIktN0EANPjSNsrs?=
 =?us-ascii?Q?Wmi8kNr/I8pfAG4kOefPOnKwzY/qaHYpzYgQWaSwc8vwHmGEUf8ksf5Tfbjy?=
 =?us-ascii?Q?q3Z96sLwaN73eGEBZ5PaXVtNorPuEH9jYWMrrpT13/nltZgYKTaDc9pI1bnv?=
 =?us-ascii?Q?7UW6bum/IpfgD5Y1JL/og7byFUUGkxEEwm0yiveYOe/f31vr20cHzlZ8bbtu?=
 =?us-ascii?Q?6w4uIuw9k8c2srEMJN5Kde6inr2ZAjAAJVzsGBILUZhRE86DVyuFdIULzpOt?=
 =?us-ascii?Q?quicwugaaE/ffRpaDeL6lyWZVDadHOoT5ie3PA3iTMQnvx0qQIAkE5GLLOmK?=
 =?us-ascii?Q?PY2RLs1y8oHl2IZ+Q6n9Ld1O9k9Y62jDqnBLj1P/or2Wh2DvzoI+IGLqVQs0?=
 =?us-ascii?Q?+geE6LxxHCyg41n1A9kPca9rzEeOPxGWCBOI1PZrIPRXcRJdlPkXbSL32nnk?=
 =?us-ascii?Q?JFu2K8B/Du0CP2FNbrSYjDPCBzo/qfvGl4q7Gnq5Q5kWoUWv+WHG4Nie4VTj?=
 =?us-ascii?Q?c+V7NZ5CVF66AIKOlOzugBrthOcWdkxGbHr3M/XHEXwo3TtO3cOpVX9vkxJx?=
 =?us-ascii?Q?K2Zed4OBzP2TwUH1E7oH+SXgFeoetQxab57VO6ghViQdCdRE4C7Qc4RV0K+z?=
 =?us-ascii?Q?MmzS9cWakKqBxgMScRgf1peGTbOTs8aATNKYb+JiHNsRzqfCj33BJ1s9GLh0?=
 =?us-ascii?Q?MytuuysPm7FH+QgQMKqNaCJ9wB1JZUrr/rPJUuvdw25Uji8+wCeDW5LIXS9k?=
 =?us-ascii?Q?oi5iqvzK1c3udGSBLjadflV2T2EqTKkSALUY6gcRakZoGZiPBHTql9LtHOqq?=
 =?us-ascii?Q?bU1ZScKsdLYXPbjngx1NFXIC5SCbPDu4G1QELAAjRsgOZCl2aYy+ZCB1/Ov+?=
 =?us-ascii?Q?SWFNj99YBPFHqQaI0h5jylQel3NFWu/iH+zOpH5t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4897534-dad3-48ba-dcbb-08ddaf11593b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:12:00.6622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbNLnd51Tc8JMVMwnxsWXCkEX6bugYJgwuz9eB1s/+pWD9xBEd6iSiq1OuZ4ZC28cqDL35MvJi1jkWpXTcknwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10084

On i.MX, the PCIe reference clock might come from either internal
system PLL or external clock source.
Add the external reference clock source for reference clock.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index ca5f2970f217..c472a5daae6e 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -219,7 +219,12 @@ allOf:
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
-            - const: ref
+            - description: PCIe reference clock.
+              oneOf:
+                - description: The controller might be configured clocking
+                    coming in from either an internal system PLL or an
+                    external clock source.
+                  enum: [ref, gio]
 
 unevaluatedProperties: false
 
-- 
2.37.1


