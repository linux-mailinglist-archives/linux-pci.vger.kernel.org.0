Return-Path: <linux-pci+bounces-17317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D46089D92D7
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 08:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB95B23F7A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 07:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E778D194AF9;
	Tue, 26 Nov 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l/SVKQtp"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B9317C208;
	Tue, 26 Nov 2024 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607854; cv=fail; b=ZU94gTj3jFuH5ucuY79kGM0VcAJME5L9vLYve9mZL829bgWfC0GgRDqHXzmzo9WIVt/1Gif2tv3LzVpgIbA/nPCfmEJhF+HD7KzFNnyiPp1/cGn8brwhAlcgTwUXS7QBcmR1EeQ0Usb2c3nmr+fVR+OelicbL2ed+5M4wXZwKFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607854; c=relaxed/simple;
	bh=ZYcCRteNnovkcUZklpgpWyVqUFeEFoDgEhVPtnV6pKI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=d1o+4h0oaxG1Qkwdi2Hh9V1kdEmP+fUwx3tcBr7r74EIMUmu4YF14yUmm/eoUue+B/gTO+oXmQDCYCU0wXuBufJU3Up+tA2e/SCEw5sK+/ZWnZjMYbVWyMjb9utt5vnLvSO3hXW+ULE0/CrrAgq9pDy2slGm2F+E9L7VaGLwKUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l/SVKQtp; arc=fail smtp.client-ip=40.107.104.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvaaGPSTvysQJb64AVbZ4P0ZynBppthIHZVrkz8F+xPLW40yAt1OyiRZafXcrwJoHLLNDLT31LzgC2Uoo8+e+J12dpEtYuinw7GuwQg2mO3kkq2HpgdeeCdyKCwKttkbulJwRL8QFVgNjITje9jB3ybbhUK3E6hHX6j4HCHk/+BnKyFPMo6nIgnWIIDjyuG3sCs+c/MZFfJE+Sel/M9iJtm9kXuTYQkV0dZ1XJoZ0SIpoyHx5XmmdVIfLK+gXr5l6HiRqfw0QikdOLZVWJhsz3DU+m4aQyIGg9b2zQ+xolxiXkmI1d+1FzxOYRWot4ROygOLYUYLPDkiHh4IJPYVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeBaRa4Sp9/BBm14vlkr4aUvWWarw6aoxjDtW6doA60=;
 b=UtsXDXw63L18acPwRi/LRjLZci5s3IEyLl6Gdohwtb8ysguOYJk7Rxgf8Ltn8D7jTyT2s1SHLttGlvaeiRSHZte8mxp39RkXheEpzk9BM9gCmVChXnraUY87QHlycrTwovOo3pAOV8d+b6wOIpRLpus8R1HhbT2c1fVVG5v0Bs4G7YPti+RCkxwGcVyfNg4Lz+h3sEuCFfOGo5SXYEDG5Eqqe//YCA3k1DAtdEsYE8VOqrOy91yZD90cfj6xucc9cxfNyMEZMxBGsikilANs1qzNpzv5vnVs9VgUYQcCy86w44EwxF2GEb5FRPukp90RHWpS+YTyJJ4bu1DanL4BWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeBaRa4Sp9/BBm14vlkr4aUvWWarw6aoxjDtW6doA60=;
 b=l/SVKQtp8BvGMxHlKdniPdCqnzKJ6Sn7X81PgW4ll/lodRK7kl47IU4WYgXvhsv9nx+uioRqro3UtCXXJUW4RijEXGDnZYCNVIp7JsOmkor0usrXhRHt8aQHouk2rW8K+0pglqs0o5jV7lROKchgWc/WKdeU8JOVYexFYXleHMh65ev7WqDBa7wYzMOtepHfxaxDGPeIWSNCp90UJP4HrtttRt7NbVU4oXZkxJa1tjW0ULLY/mw3V8V7hhdeWxm2K37dYtJ278Xfv3EuxhDzSANYNzs7L+nmmNfdDQiarqO484R958LcrQP/t5EdjzWdDdxsdkZrLrWjR+wiX+aYvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB9401.eurprd04.prod.outlook.com (2603:10a6:10:36b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 07:57:29 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 07:57:29 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/10] A bunch of changes to refine i.MX PCIe driver
Date: Tue, 26 Nov 2024 15:56:52 +0800
Message-Id: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DB9PR04MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: d69472fc-b106-4fad-9592-08dd0deff98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fvCOX7P6qU3zNUia1GG79u8MoJy+fC4F6S3mBUkR7jr5FpfSvpe/tnjIReph?=
 =?us-ascii?Q?1k2oaZQQrgeNKzU/rQQ3iCZkS9v7IOx6nSUb7Of3teFcHMcGrITdePdzeI7L?=
 =?us-ascii?Q?qqVqdHTQ9EjcHh+JBy6/Tk1UVulw1IwaHaXVzDDxYjPxViTZjAl1rJH+eQL2?=
 =?us-ascii?Q?SEqVUSP2HZgoA4AKE+62kbOptpVWGkZ08BQBLPvq59kalJv9zK+Yo0343xJm?=
 =?us-ascii?Q?5eql3PFqn80DvgaTLEmCP4xqx4eKfTf8meFj3W7LRwvo5jwBRzvwRzTpR8no?=
 =?us-ascii?Q?zEMjFV1C7QjAABnoRX/zBxfXHt+16ClqtTU8C48fLrHk1TQkEdiGOCcAZrm/?=
 =?us-ascii?Q?5swCnJ6TpDmwtijy7eIaMnjU61oolBJffSngc5qiLPfzMG8hxtS28GF/PWjW?=
 =?us-ascii?Q?wZV6tmlx62l9kfNrI5fldTZ0KXKPo9Vlsxvuic7yF/qzG8sBjQIfUcLkJsPR?=
 =?us-ascii?Q?zz51y5dA52RiyK0c7FcLlBFKLBvsDwD6096dYa810ZBXorZUBOhUD3dHgtuQ?=
 =?us-ascii?Q?5S6EMVg0k24J/FmPKoUxV7hHiYzX1rk4vyfHum3qi/4nh0nAhwtt8oGDIY/E?=
 =?us-ascii?Q?/wJTPx0j7sKZW96J6OqFy3B+scjlDEkfT6AwLz+NKihra7oeFXSiitmZPdFZ?=
 =?us-ascii?Q?DW09utw1LAFL/8ccQmvwW6cpEkjdP0jSGJnJcg078FLMTeuOUg9FOadmmbfP?=
 =?us-ascii?Q?CoL41E0HwGc8VEtonXYijz5kjR9iqYnMze9dhRTjjIpy94hkWdNgd1p+4rjI?=
 =?us-ascii?Q?g61yG0TcnoQ+SfWxkakz38bjMtWESwY83zgz7tRPgI5wUxeSUmFmJolfNn+n?=
 =?us-ascii?Q?48tVJFdf+Ntq1PugmgTIoRjZwEXUSVswx+PdhnzzqUlFZWEpJOiY5hQFlxZa?=
 =?us-ascii?Q?3iHQj02zuba+9qzQheP4a219DZ+yfMZIUZBUg8QVdd+95w2QBFuYr4sFbVvO?=
 =?us-ascii?Q?RcaqrHgXq2ccVt5ksTUkUeGQouvm5RVYjhTpyJL3o+d8Cw0iWAHHGwFamC5f?=
 =?us-ascii?Q?O9BgvpFDo/1uULAkjabUYocViOLeL7oHbyGzbZkXsURIb2yKgk8HJxS7o3kN?=
 =?us-ascii?Q?e6HywGmYLICUoIJ1Ls5oYqzE70ixYv8SNXep4/kHaLoRlFVJdzS8va4atHBd?=
 =?us-ascii?Q?/kjN+hfKSFjBlc7MTQTKANsIOlydTt4yKEV8++mIU36kjjj6hoWiWPGHnL5c?=
 =?us-ascii?Q?lrceVVFyullfzlBLy6C9220WetDc4OyDYPPIDNs8AvyiBuZMjS58MFWmyfe7?=
 =?us-ascii?Q?Lr0A30trWORJtDY1oVjGCLvzTDdjs/+6VgZaNDL4no7N8ZZqD/D6zDvi2yyr?=
 =?us-ascii?Q?2qAtiXPtYOoTZDAgiSL5sgDyBKt7RjyiIjwDWH+oP9z6ZMTFAx1tfMOKeiYD?=
 =?us-ascii?Q?GbBLeZX2H+w5m/2e8CUnc2P4ADUL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NZnaB10S1EPXqHll3rg/c70QfK2K0N1f4AMYQ1hDrmyKjq7WCmVkO71OHnxs?=
 =?us-ascii?Q?paAUdBJEpoX38CmMWn3TDVLgm2AhYdqyAvEB7sD5mgjX3ne6Ip+/EqokWODx?=
 =?us-ascii?Q?4QfRa8KvROEDx87Eitu8fCUhjhGrdnlsQD5vGS41bRe5x5Y2ueHd4pUmq99d?=
 =?us-ascii?Q?S84lBGuPk79YUE3IqiZzjT99vRz6f65x34iAyZM587qoffNgcWO8/nVSsCI8?=
 =?us-ascii?Q?Tt3wyeMY84CjBQriRYkhl6noH0B/jwaRoyTESUZpTzrE5qLjo45Hx88p+a3R?=
 =?us-ascii?Q?pYtfm/3dYL24iNyzQXPI7PwWIFfrxrV3G2fa+ieih8NfxVWVGHKQyye5iS97?=
 =?us-ascii?Q?GH5ywfFDqyfV4o+nP7YkGckKoqN31yZ2wNQ0La/w01JIdJPSeZtMJBDFgyTz?=
 =?us-ascii?Q?dAJ/z/JRyf7waE0+i/tpTbvRaCn1S2h+umHsgz6DigtLrwvPdT2I++3bSrWd?=
 =?us-ascii?Q?9PXqFVxSpaJqoT+fWVcRdmelFM5nCGTC0Q3JPzKpI/N9mjp/I2srswOmaXAe?=
 =?us-ascii?Q?GLLNXl34XrbN33Sx9NS5HV/Tt5uIVi0x4KMIsxlREeZBtbqZqCHp/VOT3Bn1?=
 =?us-ascii?Q?ftYqmMhBZSlAlmSR2orj83BYGtd/11yVDXLSRO3Xrf3PnaDIU1SV1H6o6q29?=
 =?us-ascii?Q?8VzYGw30rxkvHEh6NluVMm2x1d7Tt19s+OO2LY9eQ/7CTVKrhhhgAEiClcGy?=
 =?us-ascii?Q?GRK9MYR6pxWyUWMw5HEZW2GJLTFoO/35qzza6a6Jw1KHAaljTsDQv35S2U+I?=
 =?us-ascii?Q?LBVK1D4FcLgMkL9YFV4c8TtF0SIa/Xa48jcQvxEKVWLk8S+XHHSPBSPvLDPO?=
 =?us-ascii?Q?vIuFHcCXBzuIt6bZAy9HO6xlSb855pwRdZIYe60gZilOcNjvrzXl/gH7StJx?=
 =?us-ascii?Q?iRgjS0obC/UOYnSUBecB79xmteAkJJ1zknorv41MV2PAhLt/ejHIKrzxzKkn?=
 =?us-ascii?Q?xzPwsOW5IQW8eTFwfMouggnXlf2B8O08Daeg3UwJ3tWt9XYFdzXZfWYawK29?=
 =?us-ascii?Q?BDWFxONdFbtN1GPCRp7N4vsh0hw98mxMFwdlitKA1XkH1fZmUDCEwDCTA5Mp?=
 =?us-ascii?Q?a5Zzq8owStTru/bz2+Tuw8Ek9/UUxb/OLRuY67QQTYwSpEcuHlwaqklpf3Pc?=
 =?us-ascii?Q?jJjZSIU1msgWUahxFYpgRINmTuoXpAQcPdqFZzY9S3cxEBenn3F/z/jDil5L?=
 =?us-ascii?Q?RMVP9YfOzQ9T/hNRJPEhYFHI0D2sCYWuxH1nrL986x853OE+yWcPg7lcTqoZ?=
 =?us-ascii?Q?zZmhOy8pCE3VdNtz4o6mnQFGZNzIZ3FJI4fh4J1QjS8Rp19Pt5QJN1Df4xVN?=
 =?us-ascii?Q?kwY6fOLVKImzsJVXdHiEXBPVJTafJVh5b1GiN8fg09mxtzIwIYUzANl6bvDU?=
 =?us-ascii?Q?7YA2s/oC4MUOg/ku/iOTE2ATtnr4TMmubXT6e/cgZOP0Jba+OXzdS/9srajB?=
 =?us-ascii?Q?a5cr+SotvVZVDSQ0c9LTIYt5xg0oiiMczZmF9XCyfHQK0/tb+B7ZtW95hRev?=
 =?us-ascii?Q?cY6pH54+nMpBU3l5vE1AE0hQI3SwS+CFot9VlCxzR0YcNcot3saE8AeIpsvH?=
 =?us-ascii?Q?kymfYILf9qHEBsX1rV/O1Sc5grd+zpPeRDft69Ff?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69472fc-b106-4fad-9592-08dd0deff98f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:57:29.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmreukYYJZHYyD2iGoQ5QGNPy16/lrsWOTpOZzEbs+wHLeQrjhzfqrpOxh3jyD8aKgIY2ei/OQqPfJP1VUrqag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9401

A bunch of changes to refine i.MX PCIe driver.
- Add ref clock gate for i.MX95 PCIe.
  The changes of clock part are here [1], and had been applied by Abel.
  [1] https://lkml.org/lkml/2024/10/15/390
- Clean i.MX PCIe driver by removing useless codes.
  Patch #3 depends on dts changes. And the dts changes had been applied
  by Shawn, there is no dependecy now.
- Make core reset and enable_ref_clk symmetric for i.MX PCIe driver.
- Use dwc common suspend resume method, and enable i.MX8MQ, i.MX8Q and
  i.MX95 PCIe PM supports.

v7 changes:
Thanks a lot for Manivannan's kindly review.
- Rebase to latest pcie/next with "tag: pci-v6.13-changes", and with Frank's v8
"PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()" patch-set applied.
https://patchwork.kernel.org/project/linux-pci/cover/20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com/
- #2 patch.
  - Update the commit message
  - Use devm_clk_get_optional(dev, "ref"); to get the optional clock directly.
- #3 patch: Update the commit message.
- #4 patch: Add one Fixes tag.
- #5&#6&9 patches: Update commit message.
- #7 patch: Refine the subject, and the commit message.
- #10 patch: Replace the dummp_clk by one fixed clock.
- Add Manivannan's reviewed-by tag into #3, #4, #5, #6, #7, and #9 patches. 

v6 changes:
Thanks for Frank's comments.
- Add optional clk fetch, without losting safty check.
- Update commit message in #3 and #8 patch of v6
- Add previous discussion as annotation into #4 patch.

v5 changes:
Thanks for Manivannan's review.
- To avoid the DT compatibility on i.MX95, let to fetch i.MX95 PCIe clocks be
  optinal in driver.
- Add Fixes tags into #5 and #6 patches.
- Split the clean up codes into #7 in v5.
- Update the commit message in #10, and #8
  "PCI: imx6: Use dwc common suspend resume method" patches.

v4 changes:
It's my fault that I missing Manivanna in the reviewer list.
I'm sorry about that.
- Rebase to v6.12-rc3, and resolve the dtsi conflictions.
  Add Manivanna into reviewer list.

v3 changes:
- Update EP binding refer to comments provided by Krzysztof Kozlowski.
  Thanks.

v2 changes:
- Add the reasons why one more clock is added for i.MX95 PCIe in patch #1.
- Add the "Reviewed-by: Frank Li <Frank.Li@nxp.com>" into patch #2, #4, #5,
  #6, #8 and #9.

[PATCH v7 01/10] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
[PATCH v7 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
[PATCH v7 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses from DT
[PATCH v7 04/10] PCI: imx6: Correct controller_id generation logic
[PATCH v7 05/10] PCI: imx6: Deassert apps_reset in
[PATCH v7 06/10] PCI: imx6: Fix the missing reference clock disable
[PATCH v7 07/10] PCI: imx6: Remove imx7d_pcie_init_phy() function
[PATCH v7 08/10] PCI: imx6: Use dwc common suspend resume method
[PATCH v7 09/10] PCI: imx6: Add i.MX8MQ i.MX8Q and i.MX95 PM support
[PATCH v7 10/10] arm64: dts: imx95: Add ref clock for i.MX95 PCIe

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |   4 +-
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml     |   1 +
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml        |  25 +++++++++--
arch/arm64/boot/dts/freescale/imx95.dtsi                         |  25 +++++++++--
drivers/pci/controller/dwc/pci-imx6.c                            | 178 ++++++++++++++++++++++++++++------------------------------------------------
5 files changed, 110 insertions(+), 123 deletions(-)


