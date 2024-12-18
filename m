Return-Path: <linux-pci+bounces-18733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3AB9F7088
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007B216BC55
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6331B1922F1;
	Wed, 18 Dec 2024 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DWCs4eCc"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E5A1FE453;
	Wed, 18 Dec 2024 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734563371; cv=fail; b=c6edyUhtHTfTp7483JuHWGIKCT0R5LluQsCR071/3FVheWFyJP1I87jZPbeReXUFmkw1I554SZhFp2LLVl/gXLHcIRwA8ULtT0KnVDsp8x26N8jKtouVmR8gErfLHj/6nHuDId6buAzt8TRnYrZakJrPVafmqvrfhzHUDE9I28Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734563371; c=relaxed/simple;
	bh=WMSa85DyIKk5/tdaJfRJ0u1YGaIJIzUsaDVlLKYUQJw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=j9yJdEmAXmGNcXObTl94N25ec8K/3BIqxap7++yysk8r76GZttiND5gFzkFFkd4u23ejeJMZA51UdBCC+Wse+SEQfBG/WAMzVIH/UFqGEtv/QBwGCL8WfnKq3keJFDjEGXZsjfMgRb9OEI/wNGpioPM2XsTqjxo8HuKdmeW8YPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DWCs4eCc; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxyxAMaX0raiZBEuLZqrHMxYyN7AIoIv5Xe6F2RS0BhEdmKAbOEBLo2WluGCf3fIC2t8vA1oJV2kWWapgtXq1OuZEMN8BwT01cE2oQJ+6ehpVGlBvvbV4MCj/gtRdNdqhY2ok0gS04+051/PaVij5/cOfHCd8/zjWUSIO1ixFmWN7VBIyohUZkJNEYHMIn+4Dx3Argo7gJc0dEtp4CnuBnA5YEsmoKoq0HdrkRvKH0iJPLyvsmHLMXYWbwhREb5OrOC9uAS9moopyPgAqaFxZ2NPMPfq6NkTAj7gN+OPQsSMwQTruXs6u+6RURaVzbjIX4jxko+9uUslttsf6sic3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FY59PU0GNRFhFxBLb2ptFRe692gLTht110jB5MwRR8U=;
 b=gahCxM1vlVBCMvuURO/s+0yEaBCULUxhV01Q/7Hosk1lLq8SO+86x07K0n0X9NFCCU1OOPI+ZS0lqAH8YZTfhgLKKPNKZGKKdjUs3kRTRpzgbVsuNoIMlUGLbSUlrSfg3PN5zS0LssHa6a2e8OVUVtyfLgqfino0xgCpGbh2lapDO//yJPZmjKvtpYkoYRYIsd5WKfDQKjUMkyCxBNJ4u/8LdT42WTgn84p7Krx/xZUI2yI73gVtDJDgjg3rj3lqQEk4mwF17hmFm9RImAccCUt2K51Em4vCRojUmuOwW93TG0ahq3m74txDzGokIN0YwoEm1Dkf/60MaY+qSR72Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY59PU0GNRFhFxBLb2ptFRe692gLTht110jB5MwRR8U=;
 b=DWCs4eCctgOi2sZM3eMHvIVlMlKumoHQeHIlgF9K76aiWiJgoImViIY+7ZfdOwQG44OXBXw0RUitQ7dmcJRxC11IWEymQNsLQOOhJLgcGPtkMC89a8S2rmvlK6vmJr7ha++ZuwMGale9u7hyfINu3GxoHw7l7Z3uo/ofSQgIZHjKzSH3BFZ+niXXGoaSpydVu2imbSvTJPj8ji3umGLsF92s9vOBHDUJjAFMCehsCt3S3Op3R/EeN6f/PT39lcVqBzcNe7i3U9VfFqhLd/asuvh1adLBvOiF+iZQcHE/rpFoTQy+HpEbREw8S/P0bi04gVi8EKFX8q3k1hUYk8GNJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 23:09:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 23:09:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 18 Dec 2024 18:08:40 -0500
Subject: [PATCH v13 5/9] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-ep-msi-v13-5-646e2192dc24@nxp.com>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
In-Reply-To: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734563338; l=6819;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WMSa85DyIKk5/tdaJfRJ0u1YGaIJIzUsaDVlLKYUQJw=;
 b=jqLq6ZrEIqu8eczljjH4I0jmrLY3w4hnwATqHYpITE2jw5OFWYmkHvPFgLrGbXucIftzD6+Fw
 cDCD54z84XGCfyXHVm+23MeYkzZnf6BaER74RM2V0gEWVeHQXBlEj3z
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: a110d0a8-d652-4bf1-371f-08dd1fb90415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VENVLzdvby9rSkpDQk1mUG1JeEU0TVJCQ0dtL1BpSmhvbGRtNDRVVXdTTTA1?=
 =?utf-8?B?bXk5Q3crdUI3c2ZNQUUvV0picVIvZVpwa3FWWDMxQmVoR2ZJd0hIdEJOWU13?=
 =?utf-8?B?ZkxKOXA3SGFuR0xMN3k4YmhNMkJiZ2NSemI0ZmxoMkF4RnZjM2kzQmRYTDZE?=
 =?utf-8?B?NU16NU5pQ2cvenhWOTQzY3kybkgrM2h5Zy96a2R3VWh1Z2xrOXBCZTJNU0tx?=
 =?utf-8?B?ZVdQbEVNak41ZTN2SkIxdjJsOXN5VTNRVEF5N20vZ3Y4N0gycU5BR3JJWUR4?=
 =?utf-8?B?cGpURVJZaHZjUVBYQjhsRDN4em1WRW54OVNORUx2YlR2c3NQYjJnMUg2enhJ?=
 =?utf-8?B?M1ZKT3kyeFZOdytqd3ROeWdQMUtPTGplWW1TMkFyVjVCVjcrS1dlTFlHb0xE?=
 =?utf-8?B?R2N5cjI5MnV5VjY1WERVNS9UYmx0aDlWSmlJUXp1ZmR1eXdaZlRtSFFMS01D?=
 =?utf-8?B?RGU5bmU0cWZMazQrcy9oNkcxTzd1cmNiQmRIQWo5U3c3dDRSalo1aHFsYjRx?=
 =?utf-8?B?QXhBaFNsWHZPQlBhVmlocVhySzlKd1JxSE5ldnJLNll6MkN6UmcwNStjRkVz?=
 =?utf-8?B?NU5NdGc2bS9pRlUwaGEzWkZPWjFnWWhoTWFyTUc4QjJPNkhPWmh2MStyY1Ez?=
 =?utf-8?B?S2VvbzRrL0lTSE1GVWtob0pTdkFmdDkwMkQ2RlVNSDFQY08wWnFXS3QvWVFP?=
 =?utf-8?B?S0NvWjkxa3VnR0RYa3RWLzFpMjF6RWVNdkdsZnBVWFJPeUlNRFlKaU0yWnRP?=
 =?utf-8?B?aWVZVTZ0SldmM3lvK3F3a0JCQ2V6dHhkRE9qNkx0Sld1d0FKM3MxS1Y2b002?=
 =?utf-8?B?c3l4MHRlTlluOWVKRTFzYlJPK2FYblJrNUMrZjl0WVVJdHoxMkRLamw1ZWtq?=
 =?utf-8?B?RGtnR2JWbUhHeHBkNkw2c1UzMnh5NzVjTzE0ZktPamNwVFJ3eEorWTc4Y2dw?=
 =?utf-8?B?dUYvSFJaREdWL0dVdHVYclVUeFNrYXVOREgxS0gzVXlHb0lzNHQzNzMweUdD?=
 =?utf-8?B?bFNGMkxxUC9pUHRkNlpyT1lWNXVtbllXSkpJQW54N1lHYlFZeE5PaXZwRTlH?=
 =?utf-8?B?MmhvNUFNNWlxU0RUNmx0Q2pRNkFKL0dPNnpNTmo4ZzVRTzNkZEkxNWliK1VJ?=
 =?utf-8?B?U0R2VCtqWnV5UmI5cnRoUk5DMmlkRXJieXhPcTB1YkNEN082emtrSjJkWFh6?=
 =?utf-8?B?and6QktFU0hYQ2k1M0pIWHNocEtQOERJYitqMDhISlhQejVzOXdpSUhwRTN1?=
 =?utf-8?B?VHY0ZnlUeG9SSGlHRW9xd09EdXV0Y2lja0N2UmlvQ01kaWpOZjZRaE5PR25o?=
 =?utf-8?B?cVdiMEFrRU5rUXF6RTd4QzNXdkw1dmxtSUhQcmdDTUFWRTVlOFNaWDlOdG1V?=
 =?utf-8?B?Y0ZFYzdXYnA0Q0JCKzFLNTVLTW51U3E4NnNKdWxsSDZDZ2dIdERQQUh4aDYy?=
 =?utf-8?B?b0t6TlRVdHI3YWYxdmcvUHdtM0dyeEs1c0JOZzNMbGhhd3RMckhpclhsSmN5?=
 =?utf-8?B?R21HUVNhSU9kMnpkbjB4UzFJV1JQVGFNQnNtNzhGYkJSMVV1TnF3SUJNejZO?=
 =?utf-8?B?amQyOFJ6eUJTVkFPeGJreFE1WkR2V0xmcEpGNlo3L2p3RWVQR0ZrTXNzVUw0?=
 =?utf-8?B?c2V4NWxDQktrcXV4bWVmdmsvZ0JYMkNuLzcwbUpvYXdZL0d3Z0orWExtUUdC?=
 =?utf-8?B?cjc2LzVwV2JvRklPY2wzeFdXMEZkbnBNNzhSV1JWeE9jMWdxVzhocUZRS1dT?=
 =?utf-8?B?VzJ3YUFlbjk3eDBXSEJrK3NBeDVNelNVZlgxRDM3N3MvVlFVQXA4V09VcHFM?=
 =?utf-8?B?bG1Dalo0TXJ5dU1iNXhwM1laUXQra1Fqb1BBM0FjSGMrcEZXMzg1Qy9SRUJX?=
 =?utf-8?B?UXpIK2U2QVlrY3U5VUlxVks0K2pDZFNHZjlnS1liNmQ3OG15eTI4S1FSY2dR?=
 =?utf-8?B?VkRSK2xMaHNvQW9Bc1hWWFhKRkJaWGxuMjdCc1VXVGtMbVBwU0FNYXN3emJq?=
 =?utf-8?B?M3VJeHNpZ053PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWxheW5UUHdxTzF2SkNWVGZqcEw0cHQ3QVd2VnRYc1B6UmM0blBVSm93bU54?=
 =?utf-8?B?dmNTZjlyazdybzhoT2lQVHdHZ2RodGtCTTdtbWdWQWhKWSttN1hCWFBxMkxn?=
 =?utf-8?B?Mld1Qi91bU40alYraVh5U3FqOVU5ekY0SmZFUkRBYW1jOEhWL0tDeVNqZEFy?=
 =?utf-8?B?a2llNmcwREZ6MVNldUpSUjNaTFBmNXZkb3dJVjJUeUZjdzJ1K0tORGhiUDFM?=
 =?utf-8?B?S2p5VFh1RDI4NFp4WFZCK1I4MFFvaGY3Ky9icFkvMGtMSnowa1pUcXo1VGRp?=
 =?utf-8?B?cXVWbVRaSTdtOFplSkF4WldiNytkZ2lOd3hyQjh0RElGUjc0ZW83eHY4OEVD?=
 =?utf-8?B?L2dpL3ZmUnpYYk1KQ2VFblE1eVAreEdDbTZUMlVHQ01HV2gxYjBnYnhWeG9D?=
 =?utf-8?B?YkJRSUd5dy93YS9SbDJGUWNyOFMrNnJyK1JQaGRQTi93ZDF1TDlPVW1xSEpN?=
 =?utf-8?B?aVRSWFErTEpKMWRtUCtBR3JpNXREYzUrVGdzUUkzT2l4TE5jMzJsWHJyVG5h?=
 =?utf-8?B?MFd4aExOSlVYMXZ1OHZ3RjhDU2pUdnJRMXlIRWw3aE9uNzlTNnQrQnRKVDlq?=
 =?utf-8?B?QkVaM04xcTg1Z0hpb0t4Y0N3SktBdWp4Zjhwd0h2bmkzanY4ekQ1VXlIaHZX?=
 =?utf-8?B?ODJDWkV1U2YyaHZlV1BhaEhaSUVTd2FEaCs3cWdEejROaUl3WjlGNDVSUzNq?=
 =?utf-8?B?dlZsaGFhcnRCcEdHN2RiZUE5cHdWSEUzZ0UwZisrS2djenRtSE1FN1RKU04z?=
 =?utf-8?B?VG1OMXdGaGU3Z2JYejR3ZmFzUnZsNThFdjNVczFGNjYraXM1a3hURTQ2UHVY?=
 =?utf-8?B?M0FYcHhnaUhFWkt1NTZIOGVVRllxeGQvQVlCc1VGTjdyZ2paK0U0WjRrUUhu?=
 =?utf-8?B?Mm5kOThIQWlwK1VBN2F1NWs1enJJamN1d0FmNUN4cEJkMnR3MlYyODVjQVh4?=
 =?utf-8?B?NGxxSGhZS1RoMGNWQ3hUQWNkNWtBM2x4ZitpQTVuTGVrM1pyeEZkYWFUNmRQ?=
 =?utf-8?B?LzI3Nm5CRkNJbWZHQ2xBand0SWs0SkxBNU91SVdacnNad1VPYngwOEhDdGhL?=
 =?utf-8?B?L2dJMHBEczEvbUtrMDg0OXl3ZGpoc2JoR3JyVVV3b2RrOU9oNjJRWm5OWXN5?=
 =?utf-8?B?YXltSDZiQW5hZDZQa2w2VU1ua3hPMHA5UXJ6RkRwUVlIcWRhNVFRNm5wVE9R?=
 =?utf-8?B?UEJTZXZVajQ5V3NTMUlNZEVnYjhWU1FOZVI3Vmg2SlY1MTkzL3U5WWFZSDNi?=
 =?utf-8?B?VTNWaHdxNWlINDQrZThJUnFsODhRRUxyNjZQWmhaNlQwNXl0UU1vRlVNcitG?=
 =?utf-8?B?ekxkbFZjSVAvTXVyOUxNdzcvaGFrN0k2S2lIaGRONzZtc3NkaU50Uy94MmF0?=
 =?utf-8?B?eHo3V1pMSVY1VG40dlVSYWdvUHJHVFRtRDd1dVdHWjBVLzB5Nm05aGVIZ2Fr?=
 =?utf-8?B?bzBOQkVPY09CK3JMQWdMV3Qzd3dLMHlkOHRyNXJNZ3kvazliYzU5Z0laUG5Z?=
 =?utf-8?B?N2pBLy9NcDJtRFZ2Uzdya1lKeUJoc0Rid3NqU04wL0RmQ1JORCtjVEgrOFp1?=
 =?utf-8?B?YTBFcmlMOUJ5ZzRnbU43Z1A3LzZKVjdPRXRNeUVlNFluR2RwV1ptbnowYVhR?=
 =?utf-8?B?S2VraVJyRllMaDVLNVJPZVV6MUlJZjJBOUt5amRMcVkzVUxkTGVERjZ1QkRD?=
 =?utf-8?B?RnZZMHo3Vit2WmtPVGVvMTVnVGphNEZGM1oyTkYzcEZDTkxkWjZncC8wL3g3?=
 =?utf-8?B?OVJKb1lnR01pSUFrYUFPSGM5emltSWdpay9EYjJtZWx6dmZrNG5wTE9UVXdw?=
 =?utf-8?B?aU4rL1pnKzJNV1RHdnZQRjlHQ2ZESlN1cW1nYjY5bHhscmhZdXVucXpHMzRX?=
 =?utf-8?B?VTlvRks0cGtyY0MwRloxSDdkQkUycEQ3SmRVVnpPbGRIOFlnQjRQR0x3a2pM?=
 =?utf-8?B?WlVsbXZ3bzVvTnBLMGxCY3pIM0dXTHNmRHhMVFM4NnhPbWRHa3FJMFp4aFd6?=
 =?utf-8?B?b2I2UGhWQjN4ZHRlUVEvZmVlQnRGZ1hLb3BjYWMzbzhtdWZJdkpkTmJ5OXlw?=
 =?utf-8?B?dlR1dXlSaEFrNVNnQWc0Vkl6ZTVFSzcwSjh5dlk3MVBaT255WkpWVllLN24y?=
 =?utf-8?Q?NuYUP3LmWbxgXGHIqwzt0/V/L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a110d0a8-d652-4bf1-371f-08dd1fb90415
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 23:09:25.5157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3Yi9eqwe75FzBt/7jQuogdEoZomHmoPKpa8y1ZA5+tBaXFCLKeZ7+APk6aCyanVmo+uXXqYJ7l42xxBushw2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v12 to v13
- Use DOMAIN_BUS_DEVICE_PCI_EP_MSI

Change from v10 to v12
- none

Change from v9 to v10
- Create msi domain for each function device.
- Remove only function support limiation. My hardware only support one
function, so not test more than one case.
- use "msi-map" descript msi information

  msi-map = <func_no << 8  | vfunc_no, &its, start_stream_id,  size>;

Chagne from v8 to v9
- sort header file
- use pci_epc_get(dev_name(msi_desc_to_dev(desc)));
- check epf number at pci_epf_alloc_doorbell
- Add comments for miss msi-parent case

change from v5 to v8
-none

Change from v4 to v5
- Remove request_irq() in pci_epc_alloc_doorbell() and leave to EP function
driver, so ep function driver can register differece call back function for
difference doorbell events and set irq affinity to differece CPU core.
- Improve error message when MSI allocate failure.

Change from v3 to v4
- msi change to use msi_get_virq() avoid use msi_for_each_desc().
- add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
- move mutex lock to epc function
- initialize variable at declear place.
- passdown epf to epc*() function to simplify code.
---
 drivers/pci/endpoint/pci-ep-msi.c | 104 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        |   5 ++
 include/linux/pci-epf.h           |  16 ++++++
 3 files changed, 125 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 7aedc1cafbd14..33503d86cf2bc 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -34,3 +34,107 @@ int pci_epf_msi_domain_get_msi_rid(struct device *dev, u32 *rid)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_epf_msi_domain_get_msi_rid);
+
+static void pci_epf_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(d);
+	struct pci_epf *epf = to_pci_epf(desc->dev);
+
+	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
+		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
+}
+
+static void pci_epf_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = desc->msi_index;
+}
+
+static const struct msi_domain_template pci_epf_msi_template = {
+	.chip = {
+		.name			= "EP-MSI",
+		.irq_mask		= irq_chip_mask_parent,
+		.irq_unmask		= irq_chip_unmask_parent,
+		.irq_write_msi_msg	= pci_epf_write_msi_msg,
+		/* The rest is filled in by the MSI parent */
+	},
+
+	.ops = {
+		.set_desc		= pci_epf_msi_set_desc,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_DEVICE_PCI_EP_MSI,
+	},
+};
+
+static int pci_epf_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nvec)
+{
+	struct irq_domain *domain = dev->msi.domain;
+
+	if (!domain)
+		return -EINVAL;
+
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					  &pci_epf_msi_template, nvec, NULL, NULL))
+		return -ENODEV;
+
+	return msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, nvec - 1);
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	struct irq_domain *dom;
+	void *msg;
+	u32 rid;
+	int ret;
+	int i;
+
+	rid = (epf->func_no & 0x7) | (epf->vfunc_no << 3);
+	dom = of_msi_map_get_device_domain(epc->dev.parent, rid, DOMAIN_BUS_PLATFORM_PCI_EP_MSI);
+	if (!dom) {
+		dev_err(dev, "Can't find msi domain\n");
+		return -EINVAL;
+	}
+
+	dev_set_msi_domain(dev, dom);
+
+	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+
+	ret = pci_epf_device_msi_init_and_alloc_irqs(dev, num_db);
+	if (ret) {
+		/*
+		 * The pcie_ep DT node has to specify 'msi-parent' for EP
+		 * doorbell support to work. Right now only GIC ITS is
+		 * supported. If you have GIC ITS and reached this print,
+		 * perhaps you are missing 'msi-map' in DT.
+		 */
+		dev_err(dev, "Failed to allocate MSI\n");
+		kfree(msg);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_db; i++)
+		epf->db_msg[i].virq = msi_get_virq(dev, i);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	msi_domain_free_irqs_all(&epf->dev, MSI_DEFAULT_DOMAIN);
+	msi_remove_device_irq_domain(&epf->dev, MSI_DEFAULT_DOMAIN);
+
+	kfree(epf->db_msg);
+	epf->db_msg = NULL;
+	epf->num_db = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
index 75236867426a4..26b1c86893ee4 100644
--- a/include/linux/pci-ep-msi.h
+++ b/include/linux/pci-ep-msi.h
@@ -18,4 +18,9 @@ static inline int pci_epf_msi_domain_get_msi_rid(struct device *dev, u32 *rid)
 }
 #endif
 
+struct pci_epf;
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
+
 #endif /* __PCI_EP_MSI__ */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 18a3aeb62ae4e..5374e6515ffa0 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -12,6 +12,7 @@
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -125,6 +126,17 @@ struct pci_epf_bar {
 	int		flags;
 };
 
+/**
+ * struct pci_epf_doorbell_msg - represents doorbell message
+ * @msi_msg: MSI message
+ * @virq: irq number of this doorbell MSI message
+ * @name: irq name for doorbell interrupt
+ */
+struct pci_epf_doorbell_msg {
+	struct msi_msg msg;
+	int virq;
+};
+
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
@@ -152,6 +164,8 @@ struct pci_epf_bar {
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
  * @event_ops: Callbacks for capturing the EPC events
+ * @db_msg: data for MSI from RC side
+ * @num_db: number of doorbells
  */
 struct pci_epf {
 	struct device		dev;
@@ -182,6 +196,8 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct pci_epf_doorbell_msg *db_msg;
+	u16 num_db;
 };
 
 /**

-- 
2.34.1


