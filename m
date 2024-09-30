Return-Path: <linux-pci+bounces-13659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1513298AC4A
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 20:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389C81C21AFC
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E2B1428E0;
	Mon, 30 Sep 2024 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LYzyGMtd"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE0B667;
	Mon, 30 Sep 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721920; cv=fail; b=Hz/uDVERpz9KXuDyRkHRlt30icHzDHdt7QxlrS+CyclB3pyVEucBfd1/ME1kmgurgRbk3cf23eWAZIXwryxLS2sIvklhBjjBCqATmkYSJ1vfZIC8LlE42I7A8tzWDNK+cKUTlD82Y6P6FRj29CakLxSjFqhg07BSN/1BfmO4LGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721920; c=relaxed/simple;
	bh=3gwDyouWtiGcmzwUVM97GcKaE7eoOS2EN8sfz+VlmWY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=BdCgCwnZzHyKmwCznPrwX00cDCXZubPpTY5BudrKWv4uYL8fvI2qM4eTwYt525Rj3/Fbqk4JWYlh5lbSO1NL3XQqPwPqwdATiorR+BWtiqKx8iN3R+0biJSVxCRsjLtoAEPAtK17tfXUO2T6lFvLx+tRzKa/wqNzIObj8zsrvVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LYzyGMtd; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKaFuF7+VwXEp4F1Kkj72HxZ/3CpXyFC72EP1jfrSMzPwzxud+O2zT8Pd6pXG1Ml/XIWdlv/FPKDAkXEyr3ZoRpFXnlPRRz9W9eF0DA0rA+XncyO5AMqQAWHR/53zF3Y9NVubNDRyNzVk8PamRrVwPS7XgUlzKvXBk1d/VKZ8sLjVxcTWr3uIFQDws4jXWh+iJX++AQWjVpUnVV8S0Ya+EweW3fGlm1qvXDKXgt7A3l8lKoelqoLKD6lsDbro5URhioFEILVE5Ge1SRF1kf+Ky6DN0U/pLnod8DF6YMLDrsoVzrdH/VoBB49wCp6t8V9JwQLGvWo78rb4JtystGrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQw/ydhcYzi6pw0tOVFnhtMwWQwC9CBeLvukS7bofNU=;
 b=o/D1TNBbYnvIZWoGGG44+PM7nlquhE5bf3Nbf2F4oIz3JTm/6wszSy4NiNcZhExaCI8iWG7mz3Hy0jaCChsTN40T6aWBoQ+P39HXfm1PQZfnNnpfftMdVd5k7A1Mdh4G7Rj3wWd0imrwsfpWqvRb7ovpMR4ev8UAFqfeMBU+3Iw+gXJzWXnHnX6S/PQIThCadRsnv94irKCWUOdz0vkGQ2d1nxewFkt7zgNGS6+QgIXBJimodZDQPtC6adnaQ6p1x6cFPU6vp57+BcE/TEGclzaM32FJH9fvQurzwmZ6EA8HXjvqjJd/LfhIU8I8i2r8b8Pq5pGF2Ck+3cIcrUPMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQw/ydhcYzi6pw0tOVFnhtMwWQwC9CBeLvukS7bofNU=;
 b=LYzyGMtdnp5mdKQuLb5WOX2bhFtXbnt6V5uNaTUgmRpM8laI4HhPtufqXNW1m7FAxV7lNC78lgHnH8OuChuMTHv31f5pBEcXIfnSQurp6fVB5Z50rB4dmeAdbHALFSZvlfMPviWV24+kZyWAcIiCNMyfG4hDHl6QTpdeHZYXKmvVqPDC1Rk3oy5PaNTX9157oVvqzwNN8lekT2EatOgymhZu8Qlk26e/JvCq8lfv9igykgWHVfMBse658xO2YZLJk3YZKdw4qsQp+5ErEiaSCSoZKOpKo9lfPUlbw1ABWRXdJPJ+nAMEvv+Cm2JqkzEPf7vvvwD3VMGHEbiZEhLTew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9884.eurprd04.prod.outlook.com (2603:10a6:800:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 18:45:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 18:45:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/3] PCI: dwc: opitimaze RC host pci_fixup_addr()
Date: Mon, 30 Sep 2024 14:44:52 -0400
Message-Id: <20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKTx+mYC/3WMwQ6CMBAFf8X0bA0tWwRP/ocxpLRb2YPQtNpgC
 P9u4aKJ8TjvZWZmEQNhZKfdzAImijQOGcr9jpleDzfkZDMzWUgoGgncG2odTU/famsD17Wqatd
 0XVcCy5IPmN8teLlm7ik+xvDa+kms699UErzg6mgF6EagAXceJn8w452toSS/5epHlllGUBIUC
 LQOPvKyLG9b3X2R5wAAAA==
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727721910; l=4498;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3gwDyouWtiGcmzwUVM97GcKaE7eoOS2EN8sfz+VlmWY=;
 b=3FD3jbNRQtDRdpttJuUXemdRDzrLZD/bG8q0m/VZB73/CtIi5lWhLmNQg5E92hh+4UHVNLWRp
 A2uja3/kqicBiFbB58Gly/+OTEsM3/zLdKZYqsoaZoyLYHX3QIFHi/B
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9884:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f54769-89cd-4b7a-e156-08dce18005b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE9hTGpsSzFiaEpDZG9CdUI1M0RHWUp5b3cyWFVRSDJRaXJVZytLSUZRaVN6?=
 =?utf-8?B?VmorWkw0SEd4OTJQaGNBTGpJOGdBWXR6emFKNnkrS25neGYwTjE0ZkFQY2Uw?=
 =?utf-8?B?ZGcvTlB1RWYwS1BLTzVRTHYxTm1QQ211YjFBWGNMZXpIQVRVemdLOXZIeWN2?=
 =?utf-8?B?OUYvY2cvdVBOeitLWVlwSm1jaHVsN0pGWllHNWlIQWlEMm10RDRPczdhajdO?=
 =?utf-8?B?bXRlTlU0UW5EclF6eTByd0VlczRISEJoZGk4Y2gyaG56Y2k3K0M2NVp6OXdV?=
 =?utf-8?B?aUlWN2pyellpdE82SGhIbnkyNzJTSXBTeWtHUkk1OW1YNy9ONHFRaHQ3NFI0?=
 =?utf-8?B?dFR5Q1VHWHZMcDc5RmZjMnVQQzJRWHN0aFdwUXVWZEhoTHRXcU9hYW9NMk5l?=
 =?utf-8?B?K0lCV1FlbjBXOVk5Rmc0TGxGdzlNaTNXbnlpZk1VU0tYazgxSGxDSy9zdGZa?=
 =?utf-8?B?NXdvRmwyVGVkZVRteTJ4TEVMc29Ha0wvM2xuamFWNDRWWnY2NWVvdEVwNVZH?=
 =?utf-8?B?Wi9Ua0dNT2xLSjlwbzRSVmttajIwaldmRkNSZ3VFYThuSm5Ed0dxanJFaERU?=
 =?utf-8?B?Q3I1ejRvN3JxQldqNWtpVDBURUhjSEp6S1k3M29Eckg4WHUxVnUxcjRJSUk0?=
 =?utf-8?B?clZpM3ZWN1R6NC9kQTFuVzhVT0J4OXR1L3FDN0p1VTRyNFpheXVKbHMwK0Vr?=
 =?utf-8?B?YjlDV0dZMG1zVjE2Q3lvdWxBQUloZjlaQ0N2QnFvcjErSk9rdkhKekU3ZzBn?=
 =?utf-8?B?KzZaQ2hKVkp2aDJtVjhNNHpRYjlZaTU4M0ZwSFkwK3JhSkpyMmM5S0lxM1B3?=
 =?utf-8?B?VWg4ZCtqcWJONVRWd2FKZEU4NXcxcFZ3MHVQMS9Fdit5anF3UmphQ3ZveFZ1?=
 =?utf-8?B?S1RtNGVVMzEzVFdPMlpyM3JDek9FaUpOaHQ0M3RlalkxdjN2anVWR3hkQkhh?=
 =?utf-8?B?OFIzczcwdEp6TnRlV0pXa1dxNkFQdU1NZnBXR1RtaWtnL1dQZlpQRnRjVUlN?=
 =?utf-8?B?cFdRQ0R0aXdvMTA3L3EvblNMTkdSWnJaamNTb05ZNHJVb3VrbEwraVZNa1kv?=
 =?utf-8?B?T0NKTGNaL0NsNVUzWHlDVVVkbXM3TDRXMGhUMXREdG9oSUNHTE5LRW8xZ0hF?=
 =?utf-8?B?Zzdmc3ZGMTJHUnJMS0hNYnBIRXNwNDRScWhoRG1xUkh4bEwvRUZTc2d6VUpp?=
 =?utf-8?B?MmwvUDZJcEtmQmJMWjhjRlY1V3BURm5NNGFrcG5UdDZOVzJvYlY1QXh1QzQw?=
 =?utf-8?B?RGx5dHV0cWl3Ky8yVFpscmg5NXZ0VDJWV1c0c0RCb3dDSndZRnQ0cHdITFlB?=
 =?utf-8?B?T1pKNEFvM3VMS0owTjZjN21LeHVRNDJhNWxWK0VXWmlObUpMU05Xa2c1ZFNv?=
 =?utf-8?B?Y2xIWDliQTh5YmlOMmNFQnBORG1EMHJCU0FKcm9kNUo5RTRrRUphbGlUVEVP?=
 =?utf-8?B?OHEyWEtpMm1YblhFY2orQnVmZ3BQWklRbjdmR01UZXRkU3J2Vjh6S01RZnNl?=
 =?utf-8?B?MDVYdHNqaDFzdUxXRHJCbjdmQ1NFaWlqcWxJUFdHTk1KaFdLY1N2WDNhUW11?=
 =?utf-8?B?dUZzeXBaTXdhRkM4U3RpTFJDbDY2MVRVdDJwZy85TGxPbkhuanRHV3lLbTlG?=
 =?utf-8?B?RUJHbndxcmxCNUo1S2liYVZaREpmYlM1YVl6NW05T0k5L1g2TTUrekdSS3hE?=
 =?utf-8?B?TlVOUnhsMHFVTnpLdk9reG9OMW14cUhTNGtvZEN3Y0cxRkpUUFgwQ0lvbm9R?=
 =?utf-8?B?a1FrVU5ZZ1hOd1duMFNGRld3dFBSbXdLWmU0NVh5Wm8rVVJVczRza3FzRndD?=
 =?utf-8?B?Yk1JcElGRFJ1eVdHaXJkWXh6YU5zenBxOHdIVDhBNmJCOG9ISDluQ010OXln?=
 =?utf-8?B?Ty8wNGJwdGxUL0RKRWlZOVJuVDYrRWE2emNTZHZ1bzd1MERyVkZuTzFCQVMx?=
 =?utf-8?Q?z0LjTTFggBg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmg3dWdjNUZwODJpaWFYWjB4Qk1vTFViaFVqV1hyaTBuTUtvUGRZeGVtVlA0?=
 =?utf-8?B?MWVsYzlhVDNseU0wWnZpQkpBSUVnaFhWTllUMWh6SkNZMFlBZ1hkclpTVjMx?=
 =?utf-8?B?b05RSSsyenBKM011SkxoTTZveFVqTHBXMUZyRWhCdHJ1eGVDZXRqeERHcGNP?=
 =?utf-8?B?S0dpUkFXRmFvcHMyS3BuMFl0azd2T3pTMVFJSksrTUxUN0NDbFB3THlyNHdT?=
 =?utf-8?B?T0xYcWhobWJVeHh1ZWpJVFVPWlBkYUs2K3lGT29QMnV5TmFJZ3Y2YkRKZC9T?=
 =?utf-8?B?eFhIcFhMQzhVMWF4M05rVUZsWk4zMEZha0JFZk5kNEM1cE1LeWZPOVMwVkVQ?=
 =?utf-8?B?VmJqcGFZcU93dm54L2ZXRGVsdDk4L2pyamVPbjkyNXhlRjJhYWhoYllPRDR3?=
 =?utf-8?B?NlRwbzcvNUY1N3gvVVFBVEpEY2I1T3RzUkdWSkE1Z0wrWGEwN05laFVSa2VT?=
 =?utf-8?B?R3ZwOEtMclVld0Z0L2lOa05hUEhEMVkydEtaYWY1RzB3cGRYOTZQaCttM0FQ?=
 =?utf-8?B?aWU3aW94WFJOZlhBR0VPOG55SEh3azc3SnNWMVg5Q2VQeW1KTFR6bDBUbTNG?=
 =?utf-8?B?QnNpTXRIYStUK0I1MWhUUEJtbFhBUlFlTThqcjFLdmNyclc3WmI4WC83dXB4?=
 =?utf-8?B?TERWWWxlOGxGNFloYWdMWFhGVXRWOEpJcDdFOE5BVHpHV1hNTmNwb3hKZUdT?=
 =?utf-8?B?dlZ1YVpHM21EMi91NlplWUNKOXFsUzkvaFg2b1E5V0trK1FISDlURFpuVS9u?=
 =?utf-8?B?VzcwZ1VRZFAvTlF4VzdVb3ExM0x0eUZiSXRmOGFhODVoYzNCdUpHVzI3V2dD?=
 =?utf-8?B?ZUhoTUpibUJoOXFDVWRNaDMwcDhlaHBzQmI2ZmczbDZFcDIwbjhxN01yYjZV?=
 =?utf-8?B?OElLakRzcFBaY1ZJT1hIZm1KZFg3ZXh5N3V6SVB1dUJJeFVMaEtKNUJKLzlD?=
 =?utf-8?B?djFUVG1lcjMxb2dpR0p6TkRwblhXWUFlYWcrbHp3cWx1ZWVacWwwNXltUEpw?=
 =?utf-8?B?aUV6WlBaWFg3UDI3K1pPcUVRVDR5MUhNeDhKVjhYeXE2YkZya3hkY09SUHpE?=
 =?utf-8?B?aFFaczlPN3JNRUVpcWJnTHl6ZWVLQkFIaHVMRmJMNllYQ1dGOFFDbk9NTnFD?=
 =?utf-8?B?SlN1SVA0RjlWTmFZWEk1RFRuZ3hCaUZSbHV2RmJmTTJCaTNkSWhkSmR3cUtN?=
 =?utf-8?B?TlRYOW12bjF2M3p4VVVpeG9ISnFCSGprVWU4cjJFbGtsc3VlckdDM2dOanpp?=
 =?utf-8?B?YUk1YTlSUWFRUW1SMHd2dm5qcktsUTJzK0tPVkN5UVBlVzFUMHFvVXZNb0dl?=
 =?utf-8?B?NHJPRndCWXBKcFZ2czR5c0w1SUtURzZNRjlFdlZESStDRDNXTkdnZlN0cGtS?=
 =?utf-8?B?OEQ2TFJqcnhpV1VQb0RsL2FLT3ExVjhmZDRzNk90bHM5dWFiU0JRMnFMT0ts?=
 =?utf-8?B?ZWQ3Z09naXVtWmRBWWlvcGh0WEV0S1VaOGxINmlueldRcmwrUVVUZ0h1eTFY?=
 =?utf-8?B?U1VPNkR4VkIvckVSY0h1YUw4OWkzaGpWMFpzMldRNnhMK0Y3WmUzUG80anBn?=
 =?utf-8?B?OXZLaVF4bnJlMDRkN09pNWVUNlBJdjJlTzduRHJLb1pQNHZBS2hHc0JvWEtL?=
 =?utf-8?B?ZGxDcWVtUzdPUjlCTTZ4VS92YVc4UFh1SjNOaHlueDB3Yk5zVVorS3BBekIw?=
 =?utf-8?B?RXNkbEpnRm0zZkRVOS94VkZHWVBzY1A0SmpQWlpFM0U5dkVnaDJTa1FBMlU1?=
 =?utf-8?B?c1JZMXlQMUlLTDYvdGw4QXp4THhGeVpCbVhYTGxnVkRVMmFjMEtUS0xTMUdy?=
 =?utf-8?B?N3ZSNy9UZ2VoVjA3YU9oWWVYTjJzVXFxZ2ViQmJyR3RjMDFDcDZrM3dBNnAx?=
 =?utf-8?B?WDJSTkJyZU1OSHBFZDlkV2Q1aU5lN0NNNUhFV2NldlNQM2Y3SGszQWo1dFR2?=
 =?utf-8?B?RFZrRUh3Uyt5YXFtMzhIVmVGTnkzMW5KK0FSdU1BaHpGci9QbkZ6WjNaaTZT?=
 =?utf-8?B?aGFSZXVrdStqZTNZYVQ1OFFGdXVueFR3NCtPSlNEVFMzWDN3WjJTMStvaXMr?=
 =?utf-8?B?S2lzeWpRQnU0czlQN0tsNzJpalllbXJIRUxBVWFvNHNsMlVKM3M1eWpUNjdn?=
 =?utf-8?Q?QmYw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f54769-89cd-4b7a-e156-08dce18005b4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 18:45:14.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iR7k+92GAHOVBjTrpXS+SJPxh/K+NSGXGnUtzpOc8SWRsQT0IRRnWifZS2WOJ5ccb3wEV38caIpWxhkGD4K09g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9884

┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff8_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff0_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff8_0000─┼──────┘  │             │   └──► CfgSpace  ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► IOSpace   ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

Current dwc implimemnt, pci_fixup_addr() call back is needed when bus
fabric convert cpu address before send to PCIe controller.

    bus@5f000000 {
            compatible = "simple-bus";
            #address-cells = <1>;
            #size-cells = <1>;
            ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
                     <0x80000000 0x0 0x70000000 0x10000000>;

            pcie@5f010000 {
                    compatible = "fsl,imx8q-pcie";
                    reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
                    reg-names = "dbi", "config";
                    #address-cells = <3>;
                    #size-cells = <2>;
                    device_type = "pci";
                    bus-range = <0x00 0xff>;
                    ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
                             <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
            ...
            };
    };

Device tree already can descript all address translate. Some hardware
driver implement fixup function by mask some bits of cpu address. Last
pci-imx6.c are little bit better by fetch memory resource's offset to do
fixup.

static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
{
	...
	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
	return cpu_addr - entry->offset;
}

But it is not good by using IORESOURCE_MEM to fix up io/cfg address map
although address translate is the same as IORESOURCE_MEM.

This patches to fetch untranslate range information for PCIe controller
(pcie@5f010000: ranges). So current config ATU without cpu_fixup_addr().

EP side patch:
https://lore.kernel.org/linux-pci/20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com/T/#mfc73ca113a69ad2c0294a2e629ecee3105b72973

The both pave the road to eliminate ugle cpu_fixup_addr() callback function.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- see each patch
- Link to v2: https://lore.kernel.org/r/20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com

Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com

---
Frank Li (3):
      of: address: Add parent_bus_addr to struct of_pci_range
      PCI: dwc: Using parent_bus_addr in of_range to eliminate cpu_addr_fixup()
      PCI: imx6: Remove cpu_addr_fixup()

 drivers/of/address.c                              |  2 ++
 drivers/pci/controller/dwc/pci-imx6.c             | 22 ++----------
 drivers/pci/controller/dwc/pcie-designware-host.c | 42 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  8 +++++
 include/linux/of_address.h                        |  1 +
 5 files changed, 55 insertions(+), 20 deletions(-)
---
base-commit: 69940764dc1c429010d37cded159fadf1347d318
change-id: 20240924-pci_fixup_addr-a8568f9bbb34

Best regards,
---
Frank Li <Frank.Li@nxp.com>


