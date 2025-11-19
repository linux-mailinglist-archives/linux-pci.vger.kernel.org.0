Return-Path: <linux-pci+bounces-41659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC3FC70121
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 17:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F12F4F5AEC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 16:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277136E572;
	Wed, 19 Nov 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gBvM/l1r"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE736E546;
	Wed, 19 Nov 2025 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567907; cv=fail; b=aBaZzcDpqg1U7beDVaOV5loLlW6+U0dEiLI9eOIVOUP1Bo6syltbhvO6UJ6HweWlJp3KSEAIMwraEKLpC+T4SJrFpnX7mLawINYfMJredtstmwMnv/vtlvq4bTYX2U/1zGGEYxHcHZBBX4PcnIO7PhZ0xrvyFSSSJ+InAZXT8xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567907; c=relaxed/simple;
	bh=6ZIDjll5/DXm+Pa77BHMktQjqpGhXbzrbOjxg1zmi2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qvrpYL/wDgPM0r9c+eSxjzKOarZepm7fEUv4Sv5QjUmLh7VutRkF9Okdf9LErHlvPSE5nu3QTb/h1oNFeaBorlu0rFEBxmkO4v+rTeHqDo+HuAIIYr5D3K07rxkcQwc9lzNWDQdl9FJnL9umVRsTk4PlyrOb2x5fe/NY3JQOpB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gBvM/l1r; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBlpCUcNagsOB08g19b7uHi8hk7eD5k0S0JoVvNEF4CtJC8BgvtvlvQZGajc7KMaNHQLBBCn8oqFWZebVjcG9+IOTbkihMxIBpcIELhaxmdZJyXBX3Mk1Kxs5UkKOq2ruuzlRN1PLg+YnMKTCQNMacyQ3EkgBTxF75lxB+2QqY4RjaswFQuf2cqwwFIJgzta5FJu94RtZb9krsZDqqpDwA7UTGW3eimE52bFuPPQ41R2yaNjPgt5m3MSUrdeIxTICfJiep6dJP1XdXNcmP5mS1j5oxXqaQ6hy7MdfclkXjiCNJN42ZLv/cR3ZE/66YNwFfhYxGKubis8IMPxj+HQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzrns1Z4VN4xtVd9P39t1eXKab2yoerm+3XOphNgDR0=;
 b=Qotd7Cs9Gc+FFjtPxXFI57kXJVRzRnuQ7Rhr5FPlW1aqkx0mejVS5+LtdkFkTeVXN1xTXatvSQ65LbFlY3QDWIeSKfXn06EvuJGnUWEviCQu6xTkBoK6loiX6Z+TjsfOtGeVK/3nmQSb2xuoJk+0pJCie5a+qoOWcVrXAq7AkP5OPETPoKYB2YUHpnDhH26l90xlLzO8INEWWgjJQHoL/TxH4Zvy3IVYxZPfJHrdoCZRZCfjRqr+EgJrjL3IrwtiOicQpuNBo67/5fdpn+TyWmFFOgh21CBnQj5WT96XnIMXMrWm7CRWVU8Rkl+enh8QD34cLZ9nBU5/i4yIOlATKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzrns1Z4VN4xtVd9P39t1eXKab2yoerm+3XOphNgDR0=;
 b=gBvM/l1rnY3rYq4SM11VhCM+v/BQzgYqHFRuT86pYbWybEyDXyUtB8gzfvg/XyzTVPjtHihncQCe4fg+EHG3+JUhI3Uk98VFBNvAknx7HWVDKDOZS+wxcEjBCIWeDawf6dSL41VI4c/zZ13ZsM2zp/xAdU6jmEzuv2E05ILYLLapQuBbyV+fQB5Pe+U9zYmn0bOy2h9viadD9Hth72p92hsPpW8bkVHQ/5/p7YCIPgJkV8iMD+71UwBFp4GhHnYazRr4N9d6JrJBTt108znwtR0hpTIi0a18Ki59W5rq440BZfClkGg7JA4lxWRiZFFFj+TUimgSEMkMDM9dP4rsaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB11488.eurprd04.prod.outlook.com (2603:10a6:150:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:58:19 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 15:58:19 +0000
Date: Wed, 19 Nov 2025 10:58:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hans Zhang <hans.zhang@cixtech.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/4] PCI: dwc: Advertise L1 PM Substates only if
 driver requests it
Message-ID: <aR3pEaJ4oTagaKU8@lizhi-Precision-Tower-5810>
References: <20251118214312.2598220-1-helgaas@kernel.org>
 <20251118214312.2598220-2-helgaas@kernel.org>
 <aRz0ak6onKzZs2lY@lizhi-Precision-Tower-5810>
 <aR2lOZDBEdGVd9On@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR2lOZDBEdGVd9On@ryzen>
X-ClientProxiedBy: PH1PEPF000132E8.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::28) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB11488:EE_
X-MS-Office365-Filtering-Correlation-Id: 537d0303-6115-466c-ab2b-08de2784758b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j8PimG7ZvO7k04zXplTPS7SUQC6IJTlPSOEKYIgl6WrOeCNvfI11Bd1SII9U?=
 =?us-ascii?Q?sFYI0xtueA3TM7SJ6Ao94Cyh4e4N/N5d3ZoEpa7K2P6ngbXap4vFslkfpTIV?=
 =?us-ascii?Q?PtQliP7/opPT1RYpv+CcRCDCQvN4bo1vzQyuNmZ4UGLm1hbhYwnUC0j82uux?=
 =?us-ascii?Q?7gjxB6KgZdjJm4i3PCAHIaW8rLoJQTc5YdngcyGKBAuBBK/9UWhElEuV7xSX?=
 =?us-ascii?Q?dYptsmKfzOoiu8Km+2s6PqPzJBBHqsw/rnBHUbDrSPcg8/LXkV7wvKaAAhA+?=
 =?us-ascii?Q?E3d+QZ8RH/X5G759pye7PcEU9OPJsXj1/6hFd32ughyRzy1z2fYB8srqgSxL?=
 =?us-ascii?Q?bZyX8Rb7VOsn84ZPVIRLQCf4t735OlN3aMWm3dnK7X1xVJlCFn12QBVi82HY?=
 =?us-ascii?Q?Y82/zGwHc8iiALyeYIz1QSf0PtPZQrrhTnS0wKDS6KUQEi4Nskz23pnPEPsm?=
 =?us-ascii?Q?4KmBnb1j6EcStEnoiFnmOtRHgIBFxcc51T/iTY9UBfqgg4L9L+9mamyODINP?=
 =?us-ascii?Q?ZCm48lQQnNzIril5UcMSLq07yagOJwfOjwfTl5a1EcUpbeEulgda7KE8hT8X?=
 =?us-ascii?Q?J7DP0C04SSke30aQq4Q1V3bmhLnkMtm1NKV8GIQ9d0wm1efLt0FVAi7rm7lO?=
 =?us-ascii?Q?zjTvP9lRFhWqJi2EZ9vmGdMB3xD0/FBNkrn5N2wdIuNUKEaH3goBtenhlPr5?=
 =?us-ascii?Q?+TyQqCl0PjEq1gdNKWh7SrlwRICMJR75P0cu/oMpuKJMBuW0lQK1+4OKAbeD?=
 =?us-ascii?Q?tJI89x6jBdT/KY3d0bO82RM/wlckt+Lst7CbcjI6a1NhP+HfegtMCSDfUJbY?=
 =?us-ascii?Q?luWYjDSGaiOF8GfHbi5X34t7neW7y1MDnuA576LEe1WPx5iPh5/KVBe9t4LW?=
 =?us-ascii?Q?S52dfFBWVQz0BTVrUN9mGQ6TZTYVW8Uo3aAFyyucSpYcGl06Ia8Hp0XxTHbv?=
 =?us-ascii?Q?f6Ew037Mw7zbzJRLooK4J1+F44IId7SzwSj/R9oHOBmVJSv/nYZG0yY03Q4q?=
 =?us-ascii?Q?4eN8WBZvjRn28CgapboQlLC1m0puYaIB989z3yF26ezcbUNl8NfNCj1ZHD0W?=
 =?us-ascii?Q?uyrAmUmoPit2XRZNB57dCE5D8fB6a5WAQKkJP3RZ5JHXlPog37d33JDVad3J?=
 =?us-ascii?Q?DojGjmNdhjcDFg7PO6NxpEjvDgjwpBxm68n8JZ8+/6xaFWEmreSREmOJbUsJ?=
 =?us-ascii?Q?80h4wsBBPO+UTz82GO3KSzyUuXCMNOUs4ErwjjsFuvmtFe+AJpGStvoKQm2B?=
 =?us-ascii?Q?CCILm0M575e7J4MmQRBFSHJqAYvr59QQN2y/Mu4fPB65yBqSTxfQV36SzBNh?=
 =?us-ascii?Q?J9gSe1EAYBntvW3NAJiyLT/ISdeKgk2WeRU5hTi3r9wPOqsQY4W57mpqQyzp?=
 =?us-ascii?Q?6prBLLIGVkchkCJYjursSOfkPPB2QKKNekgLcYJ6LXqt+OpKdD4L7UaEZdmU?=
 =?us-ascii?Q?sCpn0RSHrz2qu1zrgJxLaLMHCd5PsvrrB5+wnZJpvNPrsHBRf421MQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VsOVhmG3hI0Cp8ar5r64LUM9q9JRA5b7Ckw0z7c7WutWR4TsKs5gK4ekvgf+?=
 =?us-ascii?Q?5EuRthrHQOsutCJaNNGGRHb9lveeGFvagufPLxIR5mEkVDk1Ovk6gy7NDpW/?=
 =?us-ascii?Q?mDgFN+ns7Pau5pOw14SJJmXaiWIXgbOikqJV1d17AufkyUteA/4aKQhUOxFD?=
 =?us-ascii?Q?eFW3X3IL3pl7u6+fq7TZtqEtA70N9OuEljj+sbctydNlmCtQnahNh8XOwsvn?=
 =?us-ascii?Q?71rG6BkycaMOCAB7kyoXZhKjKkzLaA4UCd4QWr8Y/sImMy4J7RlMgqrTvnlL?=
 =?us-ascii?Q?f5GVoz0+7ZRcBNv6sAzM+HyvN3DJVQ+kYnTuG6g2CLo03ijuf4f/UfpGFa97?=
 =?us-ascii?Q?fS4sB4QUrOEJqe8mziUBnHWSZ25c8676MfozNYsFr6HmP1RZsjc5FWc/qVx0?=
 =?us-ascii?Q?7uXkmGCpoBBmzwYOAqvtcBYI0HzoFHHRC0PM5+s7iee5w+PqGhrgH+rvIWfc?=
 =?us-ascii?Q?BiSW4Zula9ljqumfPTsafd2r0PvlL1nZhNYGy7eL1Pu/sVelt/0xR823DTXt?=
 =?us-ascii?Q?z3dyRtG9ixOovrqE2YFphgbQdWI3ukUVqUJZgcJbR/7Lr+Q5n8sIjgn0X8mG?=
 =?us-ascii?Q?4YMfpfjAyMqR577+BEG9LgkK3RzTtXm+gF5Oi+rvgbyCbOBAFT1OEUdrAqVO?=
 =?us-ascii?Q?z69hOcuWD2Ln+kHM4ris3/kgK/rlVzYWCsrvZ3yi3Irwb7dEFlRmhfnTsuHK?=
 =?us-ascii?Q?r+8U+inCVzQnS76T81yemqoQp/4rTh1nd8GwFw93h1ySEOOcuMPpR44zkNwV?=
 =?us-ascii?Q?iIve2lltp3vHcmUQ96dPCoLedldGiQvge8GNKK/62hLKzxzrKVku7LhjJHuy?=
 =?us-ascii?Q?QhYu3lLPK8wo0s2HO/aCwsAM7AVZ7nLUvLgdysWZ+97cn66jYZNUezNKmP97?=
 =?us-ascii?Q?5FjCG/74wKZk8CbCzsmyx06sR36UxeTZxtOxws5SCT6y6y3MsSawTU1rqgSM?=
 =?us-ascii?Q?aEYARwgJTRTiwSFjlIwZ4y5jq0z6LKEDV2vCyv8wQRbtsLcfwK9J33VJA9yo?=
 =?us-ascii?Q?AulStVWPm/gHgfctHrLbb2gA/sYtisj8plr4oZK+VqePejEFY/MbhOZB867B?=
 =?us-ascii?Q?X3zRAudWLqGD17WKdx7r0lnDmtWOy00OqqlC6JMNesnnwtqshmthyqFRGluE?=
 =?us-ascii?Q?59fFq4rbYQBb0AEe5155RwUoOe3M6e+GazwH0kiAM9mzQwzSOBgFhq2C//hM?=
 =?us-ascii?Q?VhL7FPAcz9+3Y9KrOEqi0jjdmAcCciO84zOXTaiZuI7Z8rGXe3Sp7lRGrI4g?=
 =?us-ascii?Q?UqX1G1fgt4lvvf5yJoh4tI0CP0MROsCnvCR7/VBc8FZ/6iBrIlfI6QqZOUtW?=
 =?us-ascii?Q?XV4T59LBVDQNszBaXJRQCa6hUXgnxaIaiyd6hD8SMhKhtnG8AJTiTz7iAK4H?=
 =?us-ascii?Q?VBplW1qaUQXLDCC7Yey+3safTZPW1asTBG/ah3HIphISFDsiTtq32MlnXtOn?=
 =?us-ascii?Q?T3zuXV6/RC31EgT5ind1rJ20DbTg6dUpcaU2iqjMd+6ZwSlslzASj7DuRa8H?=
 =?us-ascii?Q?ayr8Sq/Mb0LANmcUGiukGLN6eV+RtKJEsNH7NaTI49LOU4IyHJLKjHl+fRni?=
 =?us-ascii?Q?KkU+YFLW/dQmoYeBHvc3MXZmUiLYTIynG+OtTjnZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537d0303-6115-466c-ab2b-08de2784758b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:58:19.6628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIUcG/y6JP3+FMkqGSUwY/vjLQ9hFrTm9BGRxbkuNweYIMpETgaDCVqUHKR9t07AOaW4LmlaAMPTOGk9P1p/pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11488

On Wed, Nov 19, 2025 at 12:08:41PM +0100, Niklas Cassel wrote:
> On Tue, Nov 18, 2025 at 05:34:18PM -0500, Frank Li wrote:
> > On Tue, Nov 18, 2025 at 03:42:15PM -0600, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > L1 PM Substates require the CLKREQ# signal and may also require
> > > device-specific support.  If CLKREQ# is not supported or driver support is
> > > lacking, enabling L1.1 or L1.2 may cause errors when accessing devices,
> > > e.g.,
> > >
> > >   nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> > >
> > > If the kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users
> > > enable L1.x via sysfs, users may trip over these errors even if L1
> > > Substates haven't been enabled by firmware or the driver.
> > >
> > > To prevent such errors, disable advertising the L1 PM Substates unless the
> > > driver sets "dw_pcie.l1ss_support" to indicate that it knows CLKREQ# is
> > > present and any device-specific configuration has been done.
> > >
> > > Set "dw_pcie.l1ss_support" in tegra194 (if DT includes the
> > > "supports-clkreq' property) and qcom (for cfg_2_7_0, cfg_1_9_0, cfg_1_34_0,
> > > and cfg_sc8280xp controllers) so they can continue to use L1 Substates.
> > >
> > > Based on Niklas's patch:
> > > https://patch.msgid.link/20251017163252.598812-2-cassel@kernel.org
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
> > >  .../pci/controller/dwc/pcie-designware-host.c |  2 ++
> > >  drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
> > >  drivers/pci/controller/dwc/pcie-designware.h  |  2 ++
> > >  drivers/pci/controller/dwc/pcie-qcom.c        |  2 ++
> > >  drivers/pci/controller/dwc/pcie-tegra194.c    |  3 +++
> > >  6 files changed, 35 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 7f2112c2fb21..ad6c0fd67a65 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -966,6 +966,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
> > >  	if (ep->ops->init)
> > >  		ep->ops->init(ep);
> > >
> > > +	dw_pcie_hide_unsupported_l1ss(pci);
> > > +
> >
> > And, I don't think EP need clean L1SS CAP flags. If EP don't support L1SS,
> > it should be force pull down #clkreq.
>
> I think the problem is that we cannot force pull down CLKREQ# in a generic
> DWC function. That would have to be done in glue driver specific callbacks.
>
> Bjorn, perhaps we should simply drop the dw_pcie_hide_unsupported_l1ss()
> call from dw_pcie_ep_init_registers(), and consider hiding L1ss for EPs to
> be out of scope for this series.


Agree, we should consider EP later. When work at EP mode, #clkreq default
it is 0. RC should not turn L1SS if RC don't support. If RC side support,
it should be fine by turing on EP's L1SS because hardware already support
it.

Frank

>
> That way, we could still queue this series up for 6.19.
>
> Thoughts from everyone?
>
>
>
> Kind regards,
> Niklas

