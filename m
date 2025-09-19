Return-Path: <linux-pci+bounces-36536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CE8B8AF20
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 20:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50637C3FDD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E883F247295;
	Fri, 19 Sep 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NvYnZi5O"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5402571AA;
	Fri, 19 Sep 2025 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307083; cv=fail; b=eFRpX3Pep4HjD96M7wBLT2uUKI/hABYAOT7x+wlUGTwfGzpYAqJ7ULGpy50mruYrYmHvlN15EypQ9Xj3WMNq9xPxREfuxkmkwdV24dtqJl9GD2fizPwwJz/mvkQ9UzRju/3/YDSKux/44bg68IJssHnyZAmFFPDP9rKaPfkATTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307083; c=relaxed/simple;
	bh=8XFz0JcIzbXTTlcXrUgOpaeRCihi8NBHJoXBsAa1r3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Msw6s5CjoLY7DiWHubTiDJUSouWdS3v0UEhYtMhTpZCnFsP8A2DexRQ0yHWvdQiUpKNolZiBs0JYy6JoY377Vztv0Xyg78kE2XeSdpaJKF1JPz8jobs0VcvzXuYxip+tV5Q3mWCGAF366+vPMKDVbdDSJzySLaVrdPChmlQ4OXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NvYnZi5O; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZ6CaAYci7gYXZBZEiIfXY4uXtnsevT136FVW8NzaYekRTUV+7NsJA4Bcy8CvxifUAfxgBZv3c05b8qT7nojcnQbV+twWd5Gyane13kb8eMHckZG4FKXYlmwgKmeOTB0xWnw0lSgVL1LUKYcOSjivv7kgQyvth2Y2CY882VqtoaI5Z4o/EUvu+cVp/QAbLDnEOo+nATiMXMko0oPX4oS4O7ykxZAQ7TLsVPHwaFIZ9y1Oh7bPmRSGUBnWV3seNxcc2Jpbv2LVlLIiAhjzPQ/2GStiwce1cnVVnO/M60p/uQd+mnAIBBfaDA7A3QpLnJzFUpsW/RdnkEYYNQkLN1WWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvPkX0YP0j9FtI1gpRGQbH0d825dz3IQ90x16ecxuU0=;
 b=OosY4IhtFmItbJZ31Ta9cmlMZKjVx+6U3X4GAj3sK+sxyFmhwQzX4Ve6y7RbZK/yCavBgxe+bUPJ3TpEFkQnUQpzC0OoAv9UP0/+AB9F9GP/0MilScHUm/66pCwN639iK504k4gZ+rC4aKIbVuXzexVtED1gOrqIMpEuroMztNpKGNAN7oRbn3We7a9fbkTUjkGac01NrUsiZNG0YwNJ8QZk06F/dXa0jRQAAUepjIaf8BqFNWrjayN2opNhTIiLZXInoJLHu9d1XzEM6KTpy9UeTD5D0E77cHV703wgsO0yz5TmDIgjZ/Y96odC1o3Ha76/Ol5RdTyw0o38EJ35sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvPkX0YP0j9FtI1gpRGQbH0d825dz3IQ90x16ecxuU0=;
 b=NvYnZi5OtM95mxLB5XFTzakQIJ2FAKPVk90KKPdL9TmLJszXoqw654F+IPd6XSXVfUYbsnYrH2FjOvsGVf+LzoIqIRm3DiScB8P90E4lmTz8x0Ca8SNwWeVvQLaM0XkwQQfeZai7UTVKfGn6zNVIuVmDpKEYDTBEnc8OL7dpKF61UW9RHP6KCMX4w7P08aURamTPUi0hOXwZ50oXKYEVXnJ0HEixoPvsnjHvBlhfZgsvuRgxGdwwTPCXF60jYBlZhTS8wOwyyKCwRqpomPrapBZXQC/BUEo2JjH0z046+h0qkEynOQqk8BbgfgjWr2FivTvbVkWm6jp+ZmM7rIb/Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10229.eurprd04.prod.outlook.com (2603:10a6:800:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 18:37:55 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 18:37:55 +0000
Date: Fri, 19 Sep 2025 14:37:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	cassel@kernel.org
Subject: Re: [PATCH 2/3 v2] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <aM2i+E7OUqL2fYDV@lizhi-Precision-Tower-5810>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919155821.95334-3-vincent.guittot@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::32) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10229:EE_
X-MS-Office365-Filtering-Correlation-Id: 250f4bc3-91b8-455f-56de-08ddf7aba591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?skfytnPnNvUvy9VKjriCbXbOvnHv84+KiUehVwkEBatMzwDmKCJjLFMHZFo7?=
 =?us-ascii?Q?pdgKI9qqx2Z2USbAKbfzJiv8wrPUMaow76Ap9SGmjpaMAyCDWO3kPwT4PMtF?=
 =?us-ascii?Q?SF1SxLRVdcvD1lLOEoi79mZAq31wiIokorVRfFNa5OxXPZY5NgfUkYHJ4GH5?=
 =?us-ascii?Q?wUI+RK81XnDJMX+7yn9Kby7CMrJ3qCFL159xfnNup3IZFG/Vc0On0Dq808Ns?=
 =?us-ascii?Q?V+bjyLDz0fiVp7Yaud9x/M57WdtCUnkTD738ktAKjqpGvhWka5Bw1h4zjuAT?=
 =?us-ascii?Q?vk/QyuRp5JNu6Eyn/z06QDZmeN0HtdaMfIddHiYR0b4VcmZZ1C8W9EdMtIhF?=
 =?us-ascii?Q?oxPHTI7zCT66R578052DoLcfB4DNALchjMYo5M6hMAnUtVLP0LbQeZdt7fJq?=
 =?us-ascii?Q?4DYOPsAhht/M3KWPcYiXlvlYapMjWBYUd2YHPvSUVyhKJU5vGqB+nCd0xzlu?=
 =?us-ascii?Q?kwg8dvDDNymZC+dUayoZ405tyKT8BKkB48xGQibzJqG1znY0jR3jTLc7wZ4H?=
 =?us-ascii?Q?maPejqQ31OSvfOzcxFK9o+sJihNtU5Sj6rS1TsQD+RllXryxDjUTAtVWnNsb?=
 =?us-ascii?Q?VYrMacGQSI3PRsCQya9eKVGwVL0fu3rtP6vkKvpSO2XQnU2DgAvqw9cLtECJ?=
 =?us-ascii?Q?jJAlf/aAOnCXuh5/u5HRn9nUTpWRND+WpUYMzY6t8DxqEhlhns04JLPWdgsG?=
 =?us-ascii?Q?G7y2pQrsAZPrd/BC0wA1LIMarHrRCeKPDmHw8cpqir0yD3bwdiNv4PEHSHPw?=
 =?us-ascii?Q?/6q0IVcTXWXKEbSfWLsr7y6DjkCKDR5kaF72OmZFakzAEqAZUvs3AkVdG2S7?=
 =?us-ascii?Q?fyagIJr+NHnEIWHgori7ocxdEkRKPP8PFpBlWsbDwurk9RmVvWmAwxOgSjKv?=
 =?us-ascii?Q?zmLxWTM1nvsQ3G9ekPTKRYaBCmx4NtHk0aLqLePEgkidsmWOSh2Ub1gHU1wV?=
 =?us-ascii?Q?w8QgbHmToZEnHFhSxrDRIvR4nxZ9rjg6JZwkabq2vFhJE86aAI8orJyiSTHS?=
 =?us-ascii?Q?uC1K90sIl1w2OyvL+caDHvpUi7o50b1TrZ/ShdrkZt/k+l+zitBFCcf90F7e?=
 =?us-ascii?Q?81bsdsTENVXPCIuQndyvhHYPZgMn0LbViM1FklLwFX4HpScKUBICxSaQI8hP?=
 =?us-ascii?Q?HuYvghCDCmY7xR41GX2+w7SyU/gKOQ109/JwcqIZsuWw/1yeqPUWCFjIPAj8?=
 =?us-ascii?Q?qQGu6YUD6M9OsdUA5wMmUGi3Bedo6Uet2kSELfLFJPhZurVOr+6k6lhhS5TR?=
 =?us-ascii?Q?/I9C2/N3M38QrD3brOeHl/I9r2QcW6pANf6SCMxR88M+NYTNwQkf7MrazKZN?=
 =?us-ascii?Q?R9CNWClZlXIKSJsV76ebIL6xsH9seo9gIqTyRGlvCoNvLewiZivHxgsCl3Xb?=
 =?us-ascii?Q?LnboupfTfu240MsPNh11eliQ7YA9XNupl7i9PZvCDH+0k4d2ACQT1lBvxl6h?=
 =?us-ascii?Q?1LglAEvxvu0RcK5OzbQh6c5jkmHGQz3iaIpycQI5y8lzy1NHEZhc/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FEvaXoLAW+VSmgMGHEnBxrDZ15DGXVEsqkE/OUWJ1hWLY6g5dBIYCqxFay9L?=
 =?us-ascii?Q?NWTTFZCSqBj2hQ/NOEvlGL3uDPRm6YRC99UN7Z2ldJuScDPmRuGEVZtiZayx?=
 =?us-ascii?Q?ISnc2EXKXnkcLkLeUOM9H+ThaizXSCX6AeRGe5h6cVObcavg4w+ih64xGHQm?=
 =?us-ascii?Q?oVJdhQTNQFtmwHzHhhG8m6/DC3cdplP3ta7fJXEGPu+XAHUloelyEH0+ccRz?=
 =?us-ascii?Q?mlzHcSR8DsR6At9FPXr7WEyP9VwvriGLvAewxy9t7KDkOLbxyfJReCy4ZT2t?=
 =?us-ascii?Q?/7d4zCnkgMhnehs4mQfIitshc+85GvxAmix0M3DVrYR+/86nzvxRmglyVMaI?=
 =?us-ascii?Q?hXjnmj0zvSeWzkp0A+ykhoRC2LG+NYBf5c2khtaPImUlWlpx8DIMZansYuqV?=
 =?us-ascii?Q?oDkNCfNtIeLVXvgSUUe794dkQoBbcwkWb56vnnXeWrZWmX2fAsVPe3hmd/qc?=
 =?us-ascii?Q?H5E4GUyBjLSB3D6Z6kEbr9GiH9zisi65ufuRH9RJSJklpP5nmulRqGVJ8tPO?=
 =?us-ascii?Q?uNAP21HD2mSYb8RMqZ2OtMahWTn8sjfwU+PsgNO9cSaySKEuhyY31HpnOizh?=
 =?us-ascii?Q?AnBp6VLLzkv06lMUQf8LAR05ouAff1QNwAlrTuz/OdJtqoHbVW4dZY2VI0Ep?=
 =?us-ascii?Q?7mT+2epD7M7DJ4W5aIf8HjKPpcH3wcddRDWsqLvA/RmbxaS4DT+YBDr+bqH7?=
 =?us-ascii?Q?0WZXSqAPeIh2rFJbZt9OQlmHHTomVq6IFOxpUlEjnK358uAdDM93I4Worlpf?=
 =?us-ascii?Q?Z9d4AITwpuNxGuF75rfeWFzCw5q4Ao11No2LZRQZAOG1CWLBTDIfuCDiewAe?=
 =?us-ascii?Q?1aexyJlPCL3odqob8hQ0iqhUy3kr1F/uwIOOQEpd6LYGo+yZcFqQ9+gPZj0C?=
 =?us-ascii?Q?zdxLx7AjdoHyB17wExndswmG9rdqcxL0p9eC0Pa2SBjg3qxRTgI5vlGeKpI9?=
 =?us-ascii?Q?xmkpMYUKhJZ1f0JYK3WGkadurDS6jMiGVKLpQXC31WXkFhXn/59+HvEl46SB?=
 =?us-ascii?Q?zozr+eAXa7Dlw5HgD6yfx5RiUvhYf06Dh5AJrp4uOPp32BnRXJymG5Mfftpr?=
 =?us-ascii?Q?u+uuoUMG2CpyKHEmD0awQVemZRkFJAEIIz96jnoDyXrxuEOn1vvu7mleTMyH?=
 =?us-ascii?Q?5i11vS8/0QhzMUsie7cV1e4WLsR+jeHAiiAvJe96YIuwvRfwK88R0h3pw3nV?=
 =?us-ascii?Q?Z/O4YOo9VJGg+0Bk55A+2V40vkv9Gt21rAGzLZcab7Lc2oDZhik5Xa0Gozu0?=
 =?us-ascii?Q?8yQ+Vy1zNKAgKdRSt/Ki0fpl/TaWLoCO4B0JbJj8/PIKo6UAhxAUKjoTvoNe?=
 =?us-ascii?Q?IdS8x3tBpLCO0IJ+uC7UiwrXWDw2qpAFjvhGpRPL13FCisHlDbCOHB7eUjqx?=
 =?us-ascii?Q?hMgaXS1DKbS1PiDX6g5/bAbSgB+b/T6alQ72IwhycOJxvw4AuYrEB/54a717?=
 =?us-ascii?Q?0ZLxfv6q1b7Y6QVDu6lrAvu+2myNn5RBRKG2Cz4Qm4o4GGzYGaVA0mxP56a9?=
 =?us-ascii?Q?NHkI9tnl3YnaroOwBBEshKwEzdYOV1SQOKUq4Cn7UZ/kYlgvgDBzO5NGrx3b?=
 =?us-ascii?Q?8RyA5UGrTm0rFhloOUriciRlVCtS1Q/+b7pkFevz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250f4bc3-91b8-455f-56de-08ddf7aba591
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 18:37:54.9366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4P1xo8JoXVsEKD1UmwasQJgfVM1DdhD7MgGtFh1B2g5wTCWESpVTbljKcETYMTP2aPQsLQ3IzHyCNasDibscXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10229

On Fri, Sep 19, 2025 at 05:58:20PM +0200, Vincent Guittot wrote:
> Add initial support of the PCIe controller for S32G Soc family. Only
> host mode is supported.
>
> Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/pci/controller/dwc/Kconfig           |  11 +
>  drivers/pci/controller/dwc/Makefile          |   1 +
>  drivers/pci/controller/dwc/pcie-designware.h |   1 +
>  drivers/pci/controller/dwc/pcie-s32g-regs.h  |  61 ++
>  drivers/pci/controller/dwc/pcie-s32g.c       | 578 +++++++++++++++++++
>  5 files changed, 652 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-s32g-regs.h
>  create mode 100644 drivers/pci/controller/dwc/pcie-s32g.c
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index ff6b6d9e18ec..d7cee915aedd 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -255,6 +255,17 @@ config PCIE_TEGRA194_EP
>  	  in order to enable device-specific features PCIE_TEGRA194_EP must be
>  	  selected. This uses the DesignWare core.
>
> +config PCIE_S32G
> +	bool "NXP S32G PCIe controller (host mode)"
> +	depends on ARCH_S32 || (OF && COMPILE_TEST)
> +	select PCIE_DW_HOST
> +	help
> +	  Enable support for the PCIe controller in NXP S32G based boards to
> +	  work in Host mode. The controller is based on DesignWare IP and
> +	  can work either as RC or EP. In order to enable host-specific
> +	  features PCIE_S32G must be selected.
> +
> +
>  config PCIE_DW_PLAT
>  	bool
>
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 6919d27798d1..47fbedd57747 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
>  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>  obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
> +obj-$(CONFIG_PCIE_S32G) += pcie-s32g.o

keep alphabet order.

>  obj-$(CONFIG_PCIE_QCOM_COMMON) += pcie-qcom-common.o
>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 00f52d472dcd..2aec011a9dd4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -119,6 +119,7 @@
>
>  #define GEN3_RELATED_OFF			0x890
>  #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
> +#define GEN3_RELATED_OFF_EQ_PHASE_2_3		BIT(9)
>  #define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS	BIT(13)
>  #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24

This one should be separate patch

> diff --git a/drivers/pci/controller/dwc/pcie-s32g-regs.h b/drivers/pci/controller/dwc/pcie-s32g-regs.h
> new file mode 100644
> index 000000000000..674ea47a525f
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-s32g-regs.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> + * Copyright 2016-2023, 2025 NXP
> + */
> +
> +#ifndef PCIE_S32G_REGS_H
> +#define PCIE_S32G_REGS_H
> +
> +/* Instance PCIE_SS - CTRL register offsets (ctrl base) */
> +#define LINK_INT_CTRL_STS			0x40
> +#define LINK_REQ_RST_NOT_INT_EN			BIT(1)
> +#define LINK_REQ_RST_NOT_CLR			BIT(2)
> +
> +/* PCIe controller 0 general control 1 (ctrl base) */
> +#define PE0_GEN_CTRL_1				0x50
> +#define SS_DEVICE_TYPE_MASK			GENMASK(3, 0)
> +#define SS_DEVICE_TYPE(x)			FIELD_PREP(SS_DEVICE_TYPE_MASK, x)
> +#define SRIS_MODE_EN				BIT(8)
> +
> +/* PCIe controller 0 general control 3 (ctrl base) */
> +#define PE0_GEN_CTRL_3				0x58
> +/* LTSSM Enable. Active high. Set it low to hold the LTSSM in Detect state. */
> +#define LTSSM_EN				BIT(0)
> +
> +/* PCIe Controller 0 Link Debug 2 (ctrl base) */
> +#define PCIE_SS_PE0_LINK_DBG_2			0xB4
> +#define PCIE_SS_SMLH_LTSSM_STATE_MASK		GENMASK(5, 0)
> +#define PCIE_SS_SMLH_LINK_UP			BIT(6)
> +#define PCIE_SS_RDLH_LINK_UP			BIT(7)
> +#define LTSSM_STATE_L0				0x11U /* L0 state */
> +#define LTSSM_STATE_L0S				0x12U /* L0S state */
> +#define LTSSM_STATE_L1_IDLE			0x14U /* L1_IDLE state */
> +#define LTSSM_STATE_HOT_RESET			0x1FU /* HOT_RESET state */

These LTSSM* are the exact the same as enum dw_pcie_ltssm.
why need redefine it?

Can you check other register also?

> +
> +/* PCIe Controller 0  Interrupt Status (ctrl base) */
> +#define PE0_INT_STS				0xE8
> +#define HP_INT_STS				BIT(6)
> +
> +/* Link Control and Status Register. (PCI_EXP_LNKCTL in pci-regs.h) */
> +#define PCIE_CAP_LINK_TRAINING			BIT(27)

Does it belong to PCIe standand?

> +
> +/* Instance PCIE_PORT_LOGIC - DBI register offsets */
> +#define PCIE_PORT_LOGIC_BASE			0x700
> +
> +/* ACE Cache Coherency Control Register 3 */
> +#define PORT_LOGIC_COHERENCY_CONTROL_1		(PCIE_PORT_LOGIC_BASE + 0x1E0)
> +#define PORT_LOGIC_COHERENCY_CONTROL_2		(PCIE_PORT_LOGIC_BASE + 0x1E4)
> +#define PORT_LOGIC_COHERENCY_CONTROL_3		(PCIE_PORT_LOGIC_BASE + 0x1E8)
> +
> +/*
> + * See definition of register "ACE Cache Coherency Control Register 1"
> + * (COHERENCY_CONTROL_1_OFF) in the SoC RM
> + */
> +#define CC_1_MEMTYPE_BOUNDARY_MASK		GENMASK(31, 2)
> +#define CC_1_MEMTYPE_BOUNDARY(x)		FIELD_PREP(CC_1_MEMTYPE_BOUNDARY_MASK, x)
> +#define CC_1_MEMTYPE_VALUE			BIT(0)
> +#define CC_1_MEMTYPE_LOWER_PERIPH		0x0
> +#define CC_1_MEMTYPE_LOWER_MEM			0x1
> +
> +#endif  /* PCI_S32G_REGS_H */
> diff --git a/drivers/pci/controller/dwc/pcie-s32g.c b/drivers/pci/controller/dwc/pcie-s32g.c
> new file mode 100644
> index 000000000000..995e4593a13e
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-s32g.c
> @@ -0,0 +1,578 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for NXP S32G SoCs
> + *
> + * Copyright 2019-2025 NXP
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/pci.h>
> +#include <linux/phy.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/sizes.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +#include "pcie-s32g-regs.h"
> +
> +struct s32g_pcie {
> +	struct dw_pcie	pci;
> +
> +	/*
> +	 * We have cfg in struct dw_pcie_rp and
> +	 * dbi in struct dw_pcie, so define only ctrl here
> +	 */
> +	void __iomem *ctrl_base;
> +	u64 coherency_base;
> +
> +	struct phy *phy;
> +};
> +

...

> +
> +static bool s32g_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> +
> +	if (!is_s32g_pcie_ltssm_enabled(s32g_pp))
> +		return false;
> +
> +	return has_data_phy_link(s32g_pp);

Does dw_pcie_wait_for_link() work for s32g?

> +}
> +
> +static int s32g_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
> +
> +	s32g_pcie_enable_ltssm(s32g_pp);
> +
> +	return 0;
> +}
> +

...

> +
> +static void s32g_pcie_downstream_dev_to_D0(struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	struct pci_bus *root_bus = NULL;
> +	struct pci_dev *pdev;
> +
> +	/* Check if we did manage to initialize the host */
> +	if (!pp->bridge || !pp->bridge->bus)
> +		return;
> +
> +	/*
> +	 * link doesn't go into L2 state with some of the Endpoints
> +	 * if they are not in D0 state. So, we need to make sure that
> +	 * immediate downstream devices are in D0 state before sending
> +	 * PME_TurnOff to put link into L2 state.
> +	 */
> +
> +	root_bus = s32g_get_child_downstream_bus(pp->bridge->bus);
> +	if (IS_ERR(root_bus)) {
> +		dev_err(pci->dev, "Failed to find downstream devices\n");
> +		return;
> +	}
> +
> +	list_for_each_entry(pdev, &root_bus->devices, bus_list) {
> +		if (PCI_SLOT(pdev->devfn) == 0) {
> +			if (pci_set_power_state(pdev, PCI_D0))
> +				dev_err(pci->dev,
> +					"Failed to transition %s to D0 state\n",
> +					dev_name(&pdev->dev));
> +		}

strange, why common code have not do that?

> +	}
> +}
> +
> +static u64 s32g_get_coherency_boundary(struct device *dev)
> +{
> +	struct device_node *np;
> +	struct resource res;
> +
> +	np = of_find_node_by_type(NULL, "memory");

Feel like it is not good method to decide memory DDR space. It should
be fixed value for each Soc.

You can put ddr start address at your pci driver data, which is just
used for split periphal mmio space and memory space.

> +
> +	if (of_address_to_resource(np, 0, &res)) {
> +		dev_warn(dev, "Fail to get coherency boundary\n");
> +		res.start = 0;
> +	}
> +
> +	of_node_put(np);
> +
> +	return res.start;
> +}
> +
> +static int s32g_pcie_get_resources(struct platform_device *pdev,
> +				   struct s32g_pcie *s32g_pp)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +	struct phy *phy;
> +
> +	pci->dev = dev;
> +	pci->ops = &s32g_pcie_ops;
> +
> +	platform_set_drvdata(pdev, s32g_pp);
> +
> +	phy = devm_phy_get(dev, NULL);
> +	if (IS_ERR(phy))
> +		return dev_err_probe(dev, PTR_ERR(phy),
> +				"Failed to get serdes PHY\n");
> +	s32g_pp->phy = phy;
> +
> +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);
> +
> +	s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> +	if (IS_ERR(s32g_pp->ctrl_base))
> +		return PTR_ERR(s32g_pp->ctrl_base);
> +
> +	s32g_pp->coherency_base = s32g_get_coherency_boundary(dev);
> +
> +	return 0;
> +}
> +
> +static int s32g_pcie_init(struct device *dev,
> +			  struct s32g_pcie *s32g_pp)
> +{
> +	int ret;
> +
> +	s32g_pcie_disable_ltssm(s32g_pp);
> +
> +	ret = init_pcie_phy(s32g_pp);
> +	if (ret)
> +		return ret;
> +
> +	ret = init_pcie_controller(s32g_pp);
> +	if (ret)
> +		goto err_deinit_phy;
> +
> +	return 0;
> +
> +err_deinit_phy:
> +	deinit_pcie_phy(s32g_pp);
> +	return ret;
> +}
> +
> +static void s32g_pcie_deinit(struct s32g_pcie *s32g_pp)
> +{
> +	s32g_pcie_disable_ltssm(s32g_pp);
> +	deinit_pcie_phy(s32g_pp);
> +}
> +
> +static int s32g_pcie_host_init(struct device *dev,
> +			       struct s32g_pcie *s32g_pp)
> +{
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	int ret;
> +
> +	pp->ops = &s32g_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize host\n");
> +		goto err_host_deinit;
> +	}
> +
> +	return 0;
> +
> +err_host_deinit:
> +	dw_pcie_host_deinit(pp);
> +	return ret;
> +}
> +
> +static int s32g_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct s32g_pcie *s32g_pp;
> +	int ret;
> +
> +	s32g_pp = devm_kzalloc(dev, sizeof(*s32g_pp), GFP_KERNEL);
> +	if (!s32g_pp)
> +		return -ENOMEM;
> +
> +	ret = s32g_pcie_get_resources(pdev, s32g_pp);
> +	if (ret)
> +		return ret;
> +
> +	devm_pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0)
> +		goto err_pm_runtime_put;

You enable run time pm, but no any run time pm callback in your driver.

> +
> +	ret = s32g_pcie_init(dev, s32g_pp);
> +	if (ret)
> +		goto err_pm_runtime_put;
> +
> +	ret = s32g_pcie_host_init(dev, s32g_pp);
> +	if (ret)
> +		goto err_deinit_controller;
> +
> +	return 0;
> +
> +err_deinit_controller:
> +	s32g_pcie_deinit(s32g_pp);
> +err_pm_runtime_put:
> +	pm_runtime_put(dev);
> +
> +	return ret;
> +}
> +
> +static int s32g_pcie_suspend(struct device *dev)
> +{
> +	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	struct pci_bus *bus, *root_bus;
> +
> +	s32g_pcie_downstream_dev_to_D0(s32g_pp);
> +
> +	bus = pp->bridge->bus;
> +	root_bus = s32g_get_child_downstream_bus(bus);
> +	if (!IS_ERR(root_bus))
> +		pci_walk_bus(root_bus, pci_dev_set_disconnected, NULL);
> +
> +	pci_stop_root_bus(bus);
> +	pci_remove_root_bus(bus);
> +
> +	s32g_pcie_deinit(s32g_pp);
> +
> +	return 0;
> +}

why dw_pcie_suspend_noirq() and dw_pcie_suspend_ioresume() not work?
can you enhance it to support s32g?

Frank
> +
> +static int s32g_pcie_resume(struct device *dev)
> +{
> +	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &s32g_pp->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	int ret = 0;
> +
> +	ret = s32g_pcie_init(dev, s32g_pp);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = dw_pcie_setup_rc(pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to resume DW RC: %d\n", ret);
> +		goto fail_host_init;
> +	}
> +
> +	ret = dw_pcie_start_link(pci);
> +	if (ret) {
> +		/*
> +		 * We do not exit with error if link up was unsuccessful
> +		 * Endpoint may not be connected.
> +		 */
> +		if (dw_pcie_wait_for_link(pci))
> +			dev_warn(pci->dev,
> +				 "Link Up failed, Endpoint may not be connected\n");
> +
> +		if (!phy_validate(s32g_pp->phy, PHY_MODE_PCIE, 0, NULL)) {
> +			dev_err(dev, "Failed to get link up with EP connected\n");
> +			goto fail_host_init;
> +		}
> +	}
> +
> +	ret = pci_host_probe(pp->bridge);
> +	if (ret)
> +		goto fail_host_init;
> +
> +	return 0;
> +
> +fail_host_init:
> +	s32g_pcie_deinit(s32g_pp);
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops s32g_pcie_pm_ops = {
> +	SYSTEM_SLEEP_PM_OPS(s32g_pcie_suspend,
> +			    s32g_pcie_resume)
> +};
> +
> +static const struct of_device_id s32g_pcie_of_match[] = {
> +	{ .compatible = "nxp,s32g2-pcie"},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, s32g_pcie_of_match);
> +
> +static struct platform_driver s32g_pcie_driver = {
> +	.driver = {
> +		.name	= "s32g-pcie",
> +		.of_match_table = s32g_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +		.pm = pm_sleep_ptr(&s32g_pcie_pm_ops),
> +	},
> +	.probe = s32g_pcie_probe,
> +};
> +
> +module_platform_driver(s32g_pcie_driver);
> +
> +MODULE_AUTHOR("Ionut Vicovan <Ionut.Vicovan@nxp.com>");
> +MODULE_DESCRIPTION("NXP S32G PCIe Host controller driver");
> +MODULE_LICENSE("GPL");
> --
> 2.43.0
>

