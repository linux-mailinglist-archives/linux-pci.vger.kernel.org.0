Return-Path: <linux-pci+bounces-11507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C28E94C413
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 20:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA20B21B58
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6CC13E41D;
	Thu,  8 Aug 2024 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WKK6O+gV"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF2213DDAE;
	Thu,  8 Aug 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140524; cv=fail; b=XmZVK/2REOPXLYy7iYzsqsVd5bl4TyXIXBWOecXyyUoiihogLvqXLboG/dnSgIWu3WyZq4BYeG0/sy3jtyf3mOe6HOicruJ4z7M/vkwtyusqIxg4PPZYCeOE2MfkhajjNvGUqjqbSFrx1bhEDnqD6JPGjiKd/0SIL8cZMyT7jyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140524; c=relaxed/simple;
	bh=iicoeTZv4tCuVowuqs32aHk45LrOK9aR9LbCpd4Gb9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SH3qtKicFwUQcIoQ3QN9aRZR86vjkrc4XOrs6BLNJtIRjj8rxKcAFChH+gvloptVTHOCbhWCG+uAyTcSNHPwmOFFQLndUcB/39cdEDrPmxLYIEIwEC3mj9keZyNpwrDOTTYt2wwcLdWZM2eBtxamlCatXQ7rG0D7C54sBXNurBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WKK6O+gV; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZiHJfMuWGPjJHNxcNokaqyPFTO3CpQWctsGNpfPexwW46i8azPp1DrCiJe1TsLcTw8n00r49c86bO5+jBmOV7uBQ0MZwN5KVFQ146hL83rohkJNFAakhtseA5hXx1z5O4TnVbOkyhBNyfSZPhMzusw1h67W/UfG2ZpgIoF5aKEnn1xfjGqMtp1IC4pIZVQBsYeteqZY/qd98Qk+TxPw5kNhnXJHLxP2boZEAQVlUgHnTdp38Lmxl1XpZ3mA7iN1UNW/cTgmh07xJKR99AcAOHV9yhNQp6pB1rKtr+BxoZe7hAp75NO+kSsrFuNpKz7ND4bNGY8HW5muIc4k07hqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJKuQMZ5Sqbgs1mbQeIT8OVPFdvYANWFZc/i/WJEDHU=;
 b=tr38HeOKlBiSAezZY+1zqapOYsHzzMgWosOAKwP2W9v6NGaWIaSuARwWWcTfKqdTGJH0w8/jwE2BGMX25WlXB13wI0IR1AHxRy1lKZfV5xFAqC0tc27+lR5D3vW43kz8zApmP60zxcePBfjoyn6u1Gwf3olmfA6OmejkafZEbMiOzl7aSzv4lyHSQffi04JbLDY+QrCwieJV2ApLINMookp2a3Wc2ID6yiior91Rrp1gY2uR1EM4QN1IoWPVoSTRv8EW4qrO0B1rwvsZn5nHPOnQ7pp7+zV15cx/anNhAOLWnhpUhovYx9v5IKfJtdI4ntdUhadL3+Lpv5cHvrKEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJKuQMZ5Sqbgs1mbQeIT8OVPFdvYANWFZc/i/WJEDHU=;
 b=WKK6O+gVkMrwxRA/nMa209oVY5G8iHsSqR2Rovdh8UsK0GrQiKgnrYFXNNmnEYm4+fF4mq82twkpk5S8ZAJ7ScxgZMGXNEPZjcV9j8u3jAH7gTAdFwp50vadgl57DDKlXBQgwLSxpwdZkhP298qvqyPA82uKSKzGyiip3WadFkeLe4Tsrj3xvBbQChuqzRWccGLzut9iSnfp/+c8Ge9IfrC/A2mb5Co/zYEg+nA07qaJbqvIuF7pv718rk21BXRUFufKopCNuwKiQtk8z6ARq8FQQGFXbh1NUCYqTTR3BHKL2HiLwzMmximgHkjkVOXR0ElTiR24KoOqU8TD1oFd+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 18:08:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 18:08:39 +0000
Date: Thu, 8 Aug 2024 14:08:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Zhiqiang.Hou@nxp.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 3/4] PCI: mobiveil: Drop layerscape-gen4 support
Message-ID: <ZrUJngABI8v3pN6o@lizhi-Precision-Tower-5810>
References: <20240808-mobivel_cleanup-v1-3-f4f6ea5b16de@nxp.com>
 <20240808172644.GA151261@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808172644.GA151261@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:a03:333::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d5092b-39d7-4d75-609b-08dcb7d52123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jidsBCTf4c2J+TywYuD5iY32V5fm8weYbSoheCNvY3NFSxmZNCyyaabe9pxY?=
 =?us-ascii?Q?ZPxX1QEATe+XKrj2MbLIEaP4HjGf++RKL1BPRwxfV7nn9+hglFrLZgJFQp+X?=
 =?us-ascii?Q?ufJmBcZ4PFVESWgOMEbIroajq7ZLYHMznj2n/ywvYPfwT9j8z+Jjutggtjv1?=
 =?us-ascii?Q?2D7joUVCwQGhCNBEjW0QT0y9fQPUBM2oRrziwoHDfA2xMSU8cocyVLColjck?=
 =?us-ascii?Q?lM6A9IyUERHTglu/T2urirQUJfS4aGH557RizDVUTVcdz4ggxVNiV1kiPADE?=
 =?us-ascii?Q?walCAibfwQJ3qEvOASqMC/aCGNfHzJKn5RwuueDtA1EAQ7pd2MVxBwbAiV5t?=
 =?us-ascii?Q?BTi+SDBh583AjGTjODWAg//T2B8y7Z4fjceeDfmiLF1OhrYoRgDI1sYuSYBB?=
 =?us-ascii?Q?7VsM2YL7DtpAYiGrIAixdLO39roM/wNFjGOZmEaHkUxD94f/+aeheSmQyx0K?=
 =?us-ascii?Q?s+v6c3u5KjoXthUBegDA8eREu1qXneejPY5kWweMLAxhs+O0dUAFMB5j2ObR?=
 =?us-ascii?Q?GEvRjvCO3upPNEsLfksz14tEfE6EVMMtVBbqqj94CuFx8p9HzWNBi+yxGMog?=
 =?us-ascii?Q?fiajPJCemgX3IqU96J5OZw19YV1aIzhX5afTTZb83nUm9APx8smwPI8Mv123?=
 =?us-ascii?Q?h08X0NCpYE4ohmQnyC1n5FrJk1V8HVMRIz68+v2koonJcxHLkGq9kwI1y7gb?=
 =?us-ascii?Q?g0eb35j6smlkS2SkRC2UEBOD1X32/fYgujx31jQOlUbC2+m4JhK9BzwQ3DFe?=
 =?us-ascii?Q?QK9p8ImaeGkr7RQsUDK0k0T7weSMlhDcECj8g1AkUBCEYgLpnNiX1g5KTLjQ?=
 =?us-ascii?Q?s7WSWYOhm2C3+d3Gi/8NbmTaFiJy/3HkeX8BQqSBIAh40NPqA+EzWBfO3zAy?=
 =?us-ascii?Q?zpNhJOX2L/gONEz6nywKwGA5sdjTpBfWCDs+M8++f/CILQqtYQ5pndXo/ihn?=
 =?us-ascii?Q?kQjW11XyJHkjoeombz56/y3BKHNoz6TaH0uvq0FVZTRqmTGfunPnne+qR1kP?=
 =?us-ascii?Q?FF+c1YN0feZvvBwzP0WfMqjpngWWc7yAkY3Ja3LIlAZ38W7zb7HV5YMNJgXA?=
 =?us-ascii?Q?Tdw81U1JxFH9+IQEWwv75KsfQiGI7Jukl6dXSGCvVopiA1InAF72TSHFocxf?=
 =?us-ascii?Q?VZUQ28ebSJYEjhVUPoY9S2HWg6lrzayIXngW5+oV+DNnA+HI4280KmjS0cLl?=
 =?us-ascii?Q?jY33rxNgDPSG23JbBOnBHFHZ6vqXgCIJb9qu+bzQQJ/x9wdsOQZv5M9sb35m?=
 =?us-ascii?Q?vuA2Tz8iikoXhsMEcKVpE1gqfBwCzkTfuWYZMK+YxszKp+ex88im3CXK2Tfp?=
 =?us-ascii?Q?w3sII3r7Ens9sabiip48+PUxpMIOz7oDTF0h0IBYzQCMcs90/pWV7lielZ/w?=
 =?us-ascii?Q?M//HLL6YISnVsEgHctGhid8MZ//wI2K+q4p90/7A6YU2jrMWYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fisCn5qlOQKfX4JQkRftSU47skimreYi8v3oJiVw3Q1Yb/mXoNDIjehLKope?=
 =?us-ascii?Q?JWnBG6RFH42e2iWTaQXnDaoBscac2XJ5vTHbRbfPVZ9LNyA0Re/SyfobPlGD?=
 =?us-ascii?Q?1KIjJg3GvnLnwzmipWMv/eFOqM3LoqYVBYv/OiA+Yt8Pv2a1fWkZv5KEBFL4?=
 =?us-ascii?Q?t0r16Gb1W90UdRDWMVCLluqmpGBPKMeivt3Nh0MJzNXbFieg3l5N+TYDiHHQ?=
 =?us-ascii?Q?FNTd4g1JUM4+S4b0GW/mu+ZebqTEBJybX+EnosazE+MkirxPIDmJvihJpVon?=
 =?us-ascii?Q?jASc+RkJ2229hadUK5jtEmmZi/ibB/EIqMtUvJr2B+Yl8Xl4OxtaaDaLwtqr?=
 =?us-ascii?Q?66KkdJI25eNcYaFa5xiZtpHYO4ZBUUwJ7wSujwoOGrJbeSuSednDfQ2IIwyF?=
 =?us-ascii?Q?F1yfwiiY/k0Jyk2b5Y5zP5ne2lB5mqp2J0pFGoosTzOgrgOF/mag3v47pWLC?=
 =?us-ascii?Q?4dh2nI+hOKVgxHRLGREgAgS/dHYBpiR+l6kCH9z7EZphHsKFbnTO8SfhfnBT?=
 =?us-ascii?Q?1xpqaWxIAdkCfyrB7Iu51GZUOZsIOpnY4/oG8lyEinm3WEKxq4hF1v7ElaaZ?=
 =?us-ascii?Q?7PW1fIA8o+BUSdFeeBtoTxbfifGg7EeuQ3+SeipYbBW+atFSv7xwcknsSNxT?=
 =?us-ascii?Q?ETcJxiEbOsCpVUzXq+CAv2EZP8tFj33YjGZlW0gwR4mm2S9l2VcRjYGxoWE0?=
 =?us-ascii?Q?0db+Ap6xjnCJ0mcpUmF9AS4h9pus/hEDQPY0BO6Cqwoed38FYwL6ft6albZA?=
 =?us-ascii?Q?DZJvbgHjMGn5YaT/idYKGFTr3dM+tgko8ayGqDOEr5uHg6UDP8ZVz8yekv0s?=
 =?us-ascii?Q?3+OU5cl8VwZV5S+A0ErzmFVpcs5GFBKSkAltCc3D+Mkzqdxl1jSOt0IWUEpX?=
 =?us-ascii?Q?FPnz+e3J1kzKZ1fV0Tk/sg4S5NOZncQmcgXwum0bwEYmINPwlZ3BZaRjlZon?=
 =?us-ascii?Q?kDQDA0KGc1LbXCnOlhgUN5iZbAzRNNdhQdb8O4GRlPXhz59M5rvaAlw3QH97?=
 =?us-ascii?Q?j0NoaBC3piIoA6cyejejGEzR2Ij5Bt3bkvJTQbDjZaXIUgoFmSRoHv1vdERM?=
 =?us-ascii?Q?4mKQhwFRDuqpyD+ICbMfQY347+kYSc/f8/j7yvceWaulVd7qBiwfaNYJJvkf?=
 =?us-ascii?Q?S7MB1jGYrqs1uDSmI5N8vhAA/JBSQg0kd2FMG3/SVxL1jaJ9tBA0Lw5Qb6pv?=
 =?us-ascii?Q?+cMTSP+U5Vrn0M7/i/4aFj70ZtnmiXKchwuPkAH/zNDdQo/rNMPoppcBKilw?=
 =?us-ascii?Q?N0c/3ewTbKnH1Utmk6Fiq5jYkIS9qd2pZIMRgYtl7Nl1kSMbZZ7Pe3BhDm4g?=
 =?us-ascii?Q?N2IORfwv3saZK4u7aQ8bu/qvJSF5Xg3XgEnauGFTbxJWjnQq60phffUDA6zd?=
 =?us-ascii?Q?QhV553/md54yZNA6z4zZDLutmJ0xYSlBxpw4dqEgLf5ESf7Ta+qks7Gokys/?=
 =?us-ascii?Q?59xtG8573+tht2URlXgXgi51TwQHw8oP1U+B5iFIFkWvnR1DVwIxZszwdkPd?=
 =?us-ascii?Q?tshrvQo5p55bTGKoalXOMuVp0jvnKf2bof0sDDQQYdSZFwvFYRsGuRL3dqPd?=
 =?us-ascii?Q?nsoOVx1eVNjtpfGfBPo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d5092b-39d7-4d75-609b-08dcb7d52123
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 18:08:39.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2YhKK8HsY4vlX3GoFQcCQMhF4L+YDsS9e65M2scXafiHQPo8mxQPqdiCBV60BFaotUFu3QX17onlEJ2M54ZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820

On Thu, Aug 08, 2024 at 12:26:44PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 08, 2024 at 12:02:16PM -0400, Frank Li wrote:
> > Only lx2160 rev1 use mobiveil PCIe controller. Rev2 switch to designware
> > PCIe controller. Rev2 is mass production chip and Rev1 will be not
> > supported. So drop related code.
>
> I'd love to drop this, but only if you're confident that no Rev 1
> controllers are in the field with people using them.  The explanation
> above doesn't go quite that far.  It's not enough that Mobiveil
> doesn't want to support Rev 1.  If we know that all Rev 1 controllers
> have been destroyed, that would be perfect and useful to include here.

I can't guarrantee all Rev1 have been destroyed because some may left on
someone's drawer or lab. How about drop all document firstly,

and set kConfig

bool "Freescale Layerscape Gen4 PCIe controller (DEPRECATE)" if COMPILE_TEST

So layerscape gen4 will not built. Sometime later, if no one complain, we
can remove all safely.

Frank


>
> Bjorn

