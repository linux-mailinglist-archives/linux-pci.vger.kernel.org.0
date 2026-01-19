Return-Path: <linux-pci+bounces-45162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E18ECD3A43F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 11:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7929E309259C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 10:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A4B3563ED;
	Mon, 19 Jan 2026 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KMlj4hbX"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D0356A1B;
	Mon, 19 Jan 2026 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817022; cv=fail; b=mo74VtdGqfvl8Dh4TrbhM+xck+jjf6Kd7l9K6mggh5tw6qkwCNe7qtHR0VOnJ2uSSB+Mpeu5Q7AUL1wcrKDyl1Ahj2ekRZoI4NqDB9ppNfdZhUezmcOtktSsWJZyAbvlKftwqrMbdTuVZHKaFiYLu/ECazHfgOB40iNwS9fV0l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817022; c=relaxed/simple;
	bh=KRxhfnMtxmnPj54d56BETg3mTi/MCPOxzgfQIvHfGc0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eM4vKVXE4nPZIQCwerUonqewA717oXDtUpW7hbwgp1zoERsNGkadHh7fwY1Q9Izm3gEY92Do6i/t0JHHpYhxsYdMsvuPckPTwFhKcUMW2P2ESkwPbr4QlYCXlF/lIdY1u7xHq6KA/jursA3Ha6d2/fhEXxqVJWWkS8BfuekGitk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KMlj4hbX; arc=fail smtp.client-ip=40.107.159.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3dvZoM78Bg3n16LEQhVu6m+4sXT9TlQ1aoTDfNkWYV8eJoZ+KJOQF5IzUZpt2tJUkVxyw3lcxzVeUpxTPLMK4LHfttJ8GeOezf+LbarfSgfUXxuDPbDXWiu0k3X8xJftA2y6aB0fBIvKhaHhj7hqjfMIoi2bYRtVmdnmQPXRBb40sr8ccGCIg3/asLom95Iplgs3kuyzYneGxaSbdc18JhuIROdDFuPfOKofcopqnpCSqvs8HStGnPPRBKecVA42htZRlD0UT1cFcuWjlO+sn7pXhIYWYO3Vj16JGkf8DnNHsqJHvkyuufCgX63t+J7bR95G/II38QVUm3hS6pG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jq5MMGvup76mjHqhsxbrPCRLJtxY1Z0AJD/WOzAdRjY=;
 b=xFbCM+JDioXsehgBfiZskl2yRTmuyIFXXVV46u2XhWhkQXMqOn5YpGqVqfdYg5BQsN97fZJdjnDl+/EUlcJ7m4UPPvVFVnHgNPKZfPnNohQGwaFgrqsRjYwbk0Lzk2Z+DTrwjkiYWdP2XFbuWXHYx2U1bhCNrH/KObDgsNUWQEi6aDNUA4zoyFUc0H10vdtVqwcL/lIkXtcqKZk7Nrdb9QKqs8qAImVgcs8/OaFEWobrCWTD3Jwhf/e0+wZ46XgpoTo83ysTl03cgR/FjIpncRiPuvZ1WQhhyjyghSDc3+WLdHOKgEVHZDaaytKkPi8aZNe3Mhl92QgFKhlvu9hcXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jq5MMGvup76mjHqhsxbrPCRLJtxY1Z0AJD/WOzAdRjY=;
 b=KMlj4hbXtxiaQniGGtfOjvYMIjjYdeNut3bYv7R+U3oYLi6POoZu04ELdAAWMO9eFSWBBJ0DDuW5z0g4F2uIBHqLSEtQSwnCtMwkxajNwfJMMccwXHeCJuDPNrhHPr1wicC5DjjoW19nvDSxQhKh5b/2qjX5y5LLRYGUHv+v4vNOe6w8kBcaYApUx86tzvI8jZRNQftITcbXbO/2s+26uDpqa59vUufQ9XfDzw4VhHCx4zwkpM/eQSFwvAvYw8jhTHuFX9U+I3Ng4E6FT78jpCH4bHkYbWiajfeCJ+yroUoHSWZXML1yOcxeLb9YZZnPnMcAWUmLW2rzwSPiPKBV2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV2PR04MB11979.eurprd04.prod.outlook.com
 (2603:10a6:150:2f1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Mon, 19 Jan
 2026 10:03:34 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:03:34 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Mon, 19 Jan 2026 18:02:25 +0800
Message-Id: <20260119100235.1173839-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV2PR04MB11979:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a2de0f-b63a-4b52-13ca-08de574201d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LV5hF2Fn7mO0vd76wEjB77ql1u1ouT5dwLrNhvv8e/nYWvOabfqkjzu3eXI7?=
 =?us-ascii?Q?Ww45PrKjGo41Gx7MjDR+yLx5LBB/X6ivJyBM0bYBGFncizSiqylBsUUMoV67?=
 =?us-ascii?Q?kO99U9+H7s9RrfyHh/oKXzi6kWmZ9CEeqlxa6dufXJfRJ8hstf87ZCMLVPBs?=
 =?us-ascii?Q?CwfPej0nRC0qR/UZx5KaoOwCvP2JllCIG8791rANhGqIMlxzZ+Ha6laj7FfR?=
 =?us-ascii?Q?J/hep5AZeKYvdTEmYhF0sCdIepvzKff49s2UocSk7PVYJWS7Vrz4/dgmGc2x?=
 =?us-ascii?Q?JEwEukINIi9fPr1ytAdS6jVIupiCsFsErbJMl3eesZPzEAzBAMfZQiTEBldw?=
 =?us-ascii?Q?+PaUedk/lwLA3YlLWZAQIdwmIblG0plH1GupFBWDXm/klgsubFA+Tx3oH3sY?=
 =?us-ascii?Q?cojWKR+GGRvSl1dl2Pyhc8BJYOoApeu9BNUJK8LyXZj6XUlg04a2za0MxT6A?=
 =?us-ascii?Q?lfgzwB2qH/IJMr3EhoCoiyTasJ/8nBIKCBYfuMvuNHB8sKBdZCFDGi+WlFzt?=
 =?us-ascii?Q?8IeTIDcjbLvrm59y3piq3N85FCr+wvmg4e2Ut1eq6pJ/puRMsm0/xXB2Yqfk?=
 =?us-ascii?Q?KuocSjxjLR4syP7WalhujVutLX0VON303XnIFtDYzw5GrYq+DwFQybafsODU?=
 =?us-ascii?Q?F10+Kge9qSAI5s/OhPr1BgRU5hfa2o5KvHD/Gb2y25GIJN1MUmsOKgdeRIJ0?=
 =?us-ascii?Q?IcGXIxDiJba99bV9Rtafh+H6diB6hh130xs+MEOlEqL5h83jIqYzJxOfY2jn?=
 =?us-ascii?Q?nN1EOKujUmbm/2cmjD+eTW3RQ/6OWTXZUU5j8DsKITgCYGv0hJkrueU+rA7o?=
 =?us-ascii?Q?TgL0S57kB8jMTHOlHHqJqN6ryYOV1JHT5PoDt1fMzE4ijWVZRTPWEoaRcTzd?=
 =?us-ascii?Q?sNuoB+fBF5nG3wh/m3B1c1cjW8Niagq04GmVgvZvdjscip0/VeZxjBr/wug1?=
 =?us-ascii?Q?oeJD1x9QoSQyNYnDRNgbL63arkqkbLOgbwpCeuOkB5OpxtGjeW7Y/Gah3TmC?=
 =?us-ascii?Q?KZVY8b6MEhFzcTs30Ij79bDRrgzU6DCNzCM4u9Gz9KN19ai3kK40IcpW7g/A?=
 =?us-ascii?Q?WOUG0ZVv/qjyYiPa2xjdMzFqUC39dBY3sUcGloaPJA8Cww/mLSJzMTZYaqvd?=
 =?us-ascii?Q?0EFCTLrwXxVjZrXP7gqPIQXsB9F4ajK342Dm9hDu7CNkS7bRQryQH1QHTWrj?=
 =?us-ascii?Q?FO8rFGI1LSPiNhvp2vRwgtHX2aacJbsxSbJI8RPjhj3N98+pfearIRYabYNJ?=
 =?us-ascii?Q?jZ6imN8YyTDB/NDUw6ETl6Swm3tBOXXpnIJn9HWpcjIJulLK8PRdJ102MeLG?=
 =?us-ascii?Q?MBgxBof3Sc+uZSv32KOIJYv8KHwkbDwt2C1hdqjiuy4xoJwC16CdAIXR93RG?=
 =?us-ascii?Q?As59tGsdpwbMr9ndtp4obmQ70L8hbAUwJUJzRgNnuuzZWWLXZttOzV8YLBsX?=
 =?us-ascii?Q?TNKPRPqm7Q4chSuAVfLgpGZlWVynjdmEjTclEPnuC6kKXgme+LrYvJc4+kpy?=
 =?us-ascii?Q?iW80MD94gn8WINHu7c5JaEHh93+FvVzlY053TYQHd96tMIHr8ydpKYlYBp3w?=
 =?us-ascii?Q?TrrybInQdv5d0CVnXL1OsLcSZl5z9Vrqqk3Lq9vljW0qMMgeCGpFcF9+xavK?=
 =?us-ascii?Q?oYuy2ptL3v3C6C3WfIVFS4ps4wbriSu19ODj6PsTvJYX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VsrUMwv9o6WNWKtvLk1xOBOLg0C2H5D82myxpkKdU4mk8P90fkVLXcH/7vf+?=
 =?us-ascii?Q?dLWNNrv5gt95IzKy3qmUkYsL4W5jAHobGp3RwPJzmjrrMPlJSYI4q24YTd89?=
 =?us-ascii?Q?pUBhdySwiCRWQVQmNM8IB6lWb2rIVyjrEAGumzso4jQnpCOdwcHCgA59WDko?=
 =?us-ascii?Q?w+PUk7YHaoOyAmespFPwNaRIgVq/AxAxIGdJl1lyDgA8/BQJnAk7Eb6uYUZd?=
 =?us-ascii?Q?kon4cdvw6WcP6aOlmViZ1ixnILJVbJ7mIIM3X+QEdMpsV5NGGLjL0B674tgw?=
 =?us-ascii?Q?h/BO2SfBi7Bng1rf4NcjOLCKZ/jG6WXXxTIxFEle1EScwWlnw/WluvMPg3CJ?=
 =?us-ascii?Q?OHIXhVw0L0BjI68Ehc8yON1xYmea7vg5ari6/ho+XoHwFaY1dmsnM9iWcxn8?=
 =?us-ascii?Q?f27GmLMFf677V8DBHTZR5zVB6P23iuocctlSU1pXUfcvr3nczOwvo3RCna+Y?=
 =?us-ascii?Q?7A4hCm95W+smdIK78EYLPecD0DLPcD++p1dzDtPX1fnkwIw2B4A0oOek24tD?=
 =?us-ascii?Q?0nVjJKa48b8QR8WO/9M3Vbbc0NWGhMHybvpIBcBhV2SHRCZ/jZvLpvx9xD63?=
 =?us-ascii?Q?TQR1vFsrQM2CSCeMRzD/cYYo/bgoKJ75ctH8zuXzZPo/BMrkAXtqST/H0TS3?=
 =?us-ascii?Q?47hRNiTSl6hyjGfrLamJRtoId9Sd0YvRUtMg4V5TBhkkQdNsdsfSXBeOozGL?=
 =?us-ascii?Q?sMUhvgK/IM4yfZCMLT+IsM6tuXLKlqhqLKMI6ZQqmrEBzn5i+/bNYL9Tlldr?=
 =?us-ascii?Q?eViddtM9DAuOaufcFwpAZsggTuOZTB+0DQRp3dV9FcGn0l9CiH9ksbFYi1lO?=
 =?us-ascii?Q?c7e7rNOpNmaPsceb28OlUBf5U2c1yUipK1FibssMZU94bkiwIjMrpEiMbQZm?=
 =?us-ascii?Q?qFRgKE6qPVqX9YjyDVMKKAUfrDTIn96FwBb7/kiAs2GjwX7HaVMWr5UxatOt?=
 =?us-ascii?Q?IiG6lebv2Bsnm7lZDc3T/kSicstH8ympBRu4mhzyGFpe4col1xOd+IRIFUxF?=
 =?us-ascii?Q?oxPKJV05zHxWfOIU1CEpgFNNIsFvO5h6Zd43DMxgujTThCa7RA85xnIggfvN?=
 =?us-ascii?Q?f3RB4fb/5FHfC4lGxFLfyFcQaPvOcHvHn3243drLm26Rf1qaWtkOwhGDmgnR?=
 =?us-ascii?Q?6jIVdP7Y4ySMWyfJKtsHBM5wGnUjGkupstHtw0hg+LjLSkrpsQ05+Pga1+OB?=
 =?us-ascii?Q?Pl1+xnUzlST0YCnpd+C82oltVX0aPlwHBLjkodRm7fDCn63CfbdSgL3cODhg?=
 =?us-ascii?Q?fHRRoR3tmWNEfV3F6po5T4Ui4fIBLhv8wOlAJtvaQzTFJG4u/s5L/uiGF0Mn?=
 =?us-ascii?Q?ayAVshzcLcFqWcTsVQAk894hpFM7pt1G2hFvK69kKTv/U/nmIf7//KPC4STd?=
 =?us-ascii?Q?I3CYjwiX/TAKRcXYfYp5nXXqxQGRWRxQVtFN25fV/4jdePmyUTbn+IiKykCF?=
 =?us-ascii?Q?DPMycBh06f+/pRzZth0LN6+cr6ymFdEwi0+mX7Gx+FczjtwLc1rm6AM/SjDP?=
 =?us-ascii?Q?ipFCIggHxonMsRXQNWRye7nWbaVsytQm2LU4M6NEd//EHi9zqMw3KI9yHc7W?=
 =?us-ascii?Q?DZS+3SrlTPBG9lhwh37KgNmYUgJJ6x87K/6gGu++bUXtZLvMd8aHzX+pZ03j?=
 =?us-ascii?Q?M0itugSfBYGI/BdCCM5CYUGd0AIt3+XoYV/FK8EzBAi4Acw4wZ7F8RhEXq5Q?=
 =?us-ascii?Q?zEWwsMOVPoEdW57XwCPWu9Xcgl3oIcroIYPXtfQcY1R30xbYIGJ4b79roUkc?=
 =?us-ascii?Q?yIn03Zr8mA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a2de0f-b63a-4b52-13ca-08de574201d9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:03:34.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scMVPvKD0EYAEl7apWAj57Tl5bThYsJh2HYYEcGQX/oRMWRGjF311aTLjOG1YzbMarTBrGW/W9bo0MMISLJ/sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11979

This patch set adds support for parsing the reset property in new Root Port
binding in pci-imx6 driver, similar to the implementation in the qcom pcie
driver[1].

The plan is to add the wake-gpio property to the root port in subsequent
patches. Also, the vpcie-supply property will be moved to the root port
node later based on the refactoring patch set for the PCI pwrctrl
framework[2]. 

[1] https://lore.kernel.org/linux-pci/20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com/
[2] https://lore.kernel.org/linux-pci/20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com/

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Sherry Sun (10):
  dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
  PCI: imx6: Add support for parsing the reset property in new Root Port
    binding
  arm: dts: imx6qdl: Add Root Port node and move PERST property to Root
    Port node
  arm: dts: imx6sx: Add Root Port node and move PERST property to Root
    Port node
  arm: dts: imx7d: Add Root Port node and move PERST property to Root
    Port node
  arm64: dts: imx8mm: Add Root Port node and move PERST property to Root
    Port node
  arm64: dts: imx8mp: Add Root Port node and move PERST property to Root
    Port node
  arm64: dts: imx8mq: Add Root Port nodes and move PERST property to
    Root Port node
  arm64: dts: imx8dxl/qm/qxp: Add Root Port nodes and move PERST
    property to Root Port node
  arm64: dts: imx95: Add Root Port nodes and move PERST property to Root
    Port node

 .../bindings/pci/fsl,imx6q-pcie.yaml          |  29 ++++
 .../arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |   5 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi        |  11 ++
 .../arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |   5 +-
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |   5 +-
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi         |  11 ++
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts       |   5 +-
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi          |  11 ++
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      |  11 ++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |   5 +-
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |   5 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  11 ++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |   5 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  11 ++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  10 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  22 +++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  10 +-
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    |  22 +++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   5 +-
 .../boot/dts/freescale/imx95-15x15-evk.dts    |   5 +-
 .../boot/dts/freescale/imx95-19x19-evk.dts    |  10 +-
 arch/arm64/boot/dts/freescale/imx95.dtsi      |  22 +++
 drivers/pci/controller/dwc/pci-imx6.c         | 128 ++++++++++++++++--
 23 files changed, 335 insertions(+), 29 deletions(-)

-- 
2.37.1


