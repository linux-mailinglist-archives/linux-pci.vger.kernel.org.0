Return-Path: <linux-pci+bounces-15243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9379AF3DE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 22:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C491C2229F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1030B2170D1;
	Thu, 24 Oct 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l7BNFItf"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58C200139;
	Thu, 24 Oct 2024 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802549; cv=fail; b=l62X/KnS+89kgPuVr7tfNfM2s5PFYnlmG2KrgohctY6Zl+nCP0Mw2WinW/kkTx5YSTCUPZm9LUZ9MKXN5MRUwU33HLolQbBjjI09V6mRsgyp2bRXY7R7iuQK8AB28ScKvmPPDYFCAq9EvUO1i9TXuKPLDMzJLWELDwBg8KMPoLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802549; c=relaxed/simple;
	bh=m/FwtlHiYrAps1mkcMK3XbQDbcLOYoRH/NBYh7k2Qns=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=penub7pxWh07LbUx5daoDb5r899zLQ4OzWFh0dopqk+nTScSFawL3m8w3FNaWWx9dNl/E4tDOrLDpJJHL5pxlWKFXAiaz78vBv1YrceB41bHtfxoA7QCY/enSuDErEPN7YMr7DsgGVmkuYsdE2uTB1S2olEIPLmIeaNpYKIy3R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l7BNFItf; arc=fail smtp.client-ip=40.107.105.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bljI9Mf6hGH42DHGdy0NuYDtWrOqv63+s7H0pLmUuQa3QZ4uNl0EZuoM7+ljQjREpa+EupfVgjqvh0En9MbcZEZymVSSx/LxNZiTu+pmX2kB2SpSACUNcmsx/4pLnPfSoIsio6AJEIwJrPtQ7kBdoibYfl5qaTPXvgP3E1pSnJ8nEAjrpDsHpCZ7qeAuLHohWISC9qKmr0TEDZDg05pZF/SHVzPf+RF1MdD1rNK82xkIn5bl2vjHVwWTL8r9bYUMrAU0uQ7PUJ7GGDHNytubGwPmqVcY33qusHXyVjrnXXD8aYfexxquE1OKLgw2FFo/xJM2gzWamKuNdGQajn8FhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXSC/+4XeFnAaeLe8Zg33weCJ32yXdCxNoRWfCy7Uys=;
 b=jPJ250TGut8KfzTBpR2h6a65fSoKqNWkG1JDVqv0A/Bz3HkPj60M5kV6oApWgQMiloPBylZBEkvsbTVUhmXy9rAW81k6B56oew/DpWyL4IJkM0jTtI9pRx0zLR3oAWzEwdWfhJf992k726v5DBPqkiVy8yq12rjKNrxQxvdLfhLuknmBmjHw4p5j23kddJ+t6KFHn0XOmn8+Uhhu3cqbQvyHhC0WriX7jR+jj1aVhAO0Qz3tW+whRxXR3VV02rzwrU+omW0UwZXZ6UsEXSmGVG1/2PL4e6gPnRHpTFZEEgVHea9TKpOPmHUPtxj36OePial7YqVHUHpCNkmbHTkJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXSC/+4XeFnAaeLe8Zg33weCJ32yXdCxNoRWfCy7Uys=;
 b=l7BNFItf6g8Gu2bhdZ/eQ5e1eArF8GiC8T5MY+8zKfOldSZ1UkoCEvya2i9ZWWMDIBRK7PDg/fL6BIwvP7zPPRFK75+8o97mOPTzVTqdsXpLkyp2xNaE49ZkeiR8pmUVLutu6uJyQxvimsOSnObgUxPefzMja/8zigfWBxhhSwzlXbtLTvzVk4nM3ls6H8fKdiOVxEyLnKzhK/1kp+bpiNN5CNYdjTpr4DW1bWgrBvLEl0YFGRCWb/yz37FOLdk3ep2hfauwh0vM5J+K7XtQee/nah8P8QccrzueVe4uKWCmwjycjwhwjStuw4gaIdcVWCXqFLHwMqYkdAXwURNE9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 24 Oct
 2024 20:42:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Thu, 24 Oct 2024
 20:42:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 24 Oct 2024 16:41:44 -0400
Subject: [PATCH v4 2/4] dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible
 string fsl,imx8q-pcie-ep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-pcie_ep_range-v4-2-08f8dcd4e481@nxp.com>
References: <20241024-pcie_ep_range-v4-0-08f8dcd4e481@nxp.com>
In-Reply-To: <20241024-pcie_ep_range-v4-0-08f8dcd4e481@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729802524; l=2245;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=m/FwtlHiYrAps1mkcMK3XbQDbcLOYoRH/NBYh7k2Qns=;
 b=m5Z77eCpz0KfGVrSQ8G0m9mY4FDQI+h8dn+co13soG8oDM99wh1tkact20JO8Dq97bxVTwmXl
 8Rg0Ag/aq+fBFEC6ofPqGM7cpioVoj1k5bTDGa47/3tj1SYOq4FrMP+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cea029f-f71f-4246-b4ea-08dcf46c5d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVgzN1ZrNXRJQmZpeGRMUkZDakpuRmxnRXVIY1c0dndlQmVHZFZtcHpuWS9T?=
 =?utf-8?B?WDRKbUh1ODY2UlNPbENEQk1EOWJSb2dtcmdhOFg0ZEVaMWtsTWVvY2todnZP?=
 =?utf-8?B?cTF3WHJ0QUxEQVNCQW5Jb1BqYnVGVTE5VDlIV2YvbHdIMEFDQlMxQVIrTDZR?=
 =?utf-8?B?QS9zMTh5RlEvLytwZUdRYXJ0SGRBdUYzK01nZ2l4emwwdDBYQ0dFcEtHRUZo?=
 =?utf-8?B?WE1nVXpGL0JWMmlqKzJYWmJZcGtiN1BNeE1TRjBVMThxWVpGQU9aZ0RjSGtp?=
 =?utf-8?B?OW5USXg2d2QvdSsreXVEZ1dxZ3NWZWMvMmRRcXFwSXgrV1pwTlJjVytEb0hy?=
 =?utf-8?B?dy8xVTRTbWVSVnRBQzZOcXhOT0QwSFF5K2FwdHFhNVgzdXUxMWpYYjJXUHo4?=
 =?utf-8?B?amNhaVBURC91ZEZ5eTR2blIvbjNVd2Q5eGh4TmlqY3hxK1dOVS9xSnNZdmww?=
 =?utf-8?B?S2R1K2tWenIvWkRWbm1WejhPRmUvcHVTL05pdmVhY2ZoL1NydlZJaWNRUzNX?=
 =?utf-8?B?WEdJMnA5eUJqUm8yaHQ4OVlEWmV0aFpqandmSllQVElsVSt0eUFOd0N2eGpE?=
 =?utf-8?B?VEFpUHJQbGRPZXE0RWNkamRhK3c4WDhTb3JWZ1FoTFFHY0c4RS9sa2VpK20y?=
 =?utf-8?B?Y3NNYkhnSG4zTWIzOFFBT3hlaHpMcjlRK1BSRDM0KzhLeEc0TW5vZUxsSVI1?=
 =?utf-8?B?NTQ4b3h3WjlqczA1dGNIVHh3elZDTzRFenR1TGNySHFoQTkzbjA1bHUzbnUz?=
 =?utf-8?B?a0FZUnd6OHdhb0svNWRYMjNIdHNsODlpUGIrVHZ0WHhoSVU0RXp5TGU1ZlpG?=
 =?utf-8?B?UHl3dnI4aVhUWWtGencwbnJyNmtvTVl6dXgwQVNUVkNkMVd6dStTQjRCOUdv?=
 =?utf-8?B?dW5pcEVMLytMcDRoQTFjT0FoaXRUVUYxZHRnSW16SFA4ZG10K0RsZHozZ3J1?=
 =?utf-8?B?SlhscWltelJuN1RhRmZ2TzhOR21WNkZSNk9GbnhYM0krUFNDQnFSQTlIeURG?=
 =?utf-8?B?TXBiZVpmSjNRUUpjZmVvenc1ZzFpRVBla3NiamlLU2JxWmxmSnkxUnltS0xz?=
 =?utf-8?B?Z1A3RWRCUVluK25TQlIvWW10ZittZ3lDSm1pb1FKajYwdjlhSFU5NlJKMFNz?=
 =?utf-8?B?dlhOM0tKWlNqVmxNcnpmdjNOUmlnWHBFRHEvRU5IRnlNZ2ZZb0ZhVWpZQ1Y1?=
 =?utf-8?B?dEM1RFhINFN4ekd3SGw3bmhOaVg0dHlsa0Y5akRUVlhyZFFhWmMzdjJ0b1Ry?=
 =?utf-8?B?STgxc1k4MllDRmdWcXFEcUE2VmxBd0c0MFpYOFlJVFV6SVliQTVjWnBjeWlT?=
 =?utf-8?B?b0VaUUp0SjA5aW9OUFU3SWQ4d3RqeWY4cUo2a3lMSHExSHZvc1l5WVprK3JM?=
 =?utf-8?B?eEFvOFlFVDY3K2hEZmYrUzhOaHI0aFlCTHFsWUJnUnIvbFgwYlJVd3BGTWll?=
 =?utf-8?B?cHNmSml2V1dWanBnQlNOWnZZZmU5ODlTWmdMWW9JN0VJYVdVUWg3YnNneTRU?=
 =?utf-8?B?RnhRWHowK2Eyayt5aDIxVUhrVWZOUC9STUEzR1R3a0hrN01nYWRNaDB5VU9E?=
 =?utf-8?B?SUNFd1ZzUUlTTFNQL0FJQUpYTlkyd2Z4YW50MmdHcC9HQ3UxQUp0THRvNHlm?=
 =?utf-8?B?OFpranpTeXRRTithZHdKb3FFQkNTNUlZb0dSR0NUbkxlS1N0TFl3bDhxOUMx?=
 =?utf-8?B?dGpRTGdIM3RpUTJMeTJtYjBNbmxLTm05R3FZL0hMUWhPM3gyUU1oK0tTSnpU?=
 =?utf-8?B?ZEgxTWptTm11NmJ1SGg3UDZvYWNZL2ZLUnVSMmNKNmJqYlNnUkp1QzZaYVBE?=
 =?utf-8?B?K2RPUDlUOFNQUGZKaE1IUllFd1U1Qy9lNDQ1eU55M3p6ODZQcjVGem94R1k2?=
 =?utf-8?Q?ThFXcw/zFNPOK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WndueEMwdzN5Si9wcHEyU2lrZVlMRFI2S0dZOFcrMW5mcVpZTVkyckRFdHRT?=
 =?utf-8?B?Mm9oR2I1R2tzbjA5TjhYZTZ0aXowa3hPK1ZJUXNBclNiVnN5dEJwZ29acld0?=
 =?utf-8?B?V2tKNk8rUXlpZ0czYzB6ZFYybzdjNEJwbEJyRmpRZjdLMloxdUg0VE91Q0Fx?=
 =?utf-8?B?ZGt4bHF3QVZWS1N6YWg3bDFTb254NktWcklxSzFxd04yN25aaU1HMlR4Z3Jw?=
 =?utf-8?B?aDM2TTNkRW05SWJlUlRHU2oyTW1MeE94YXlLSWgrQXNycVJ0TkRMdmVFNlZ3?=
 =?utf-8?B?eTUxQ29ya002eXd6UFJlVHY4ZHlFRnpCTXR5bklRTU9oOXQ3SFdLUFB2aldr?=
 =?utf-8?B?T0tWV2d1Y0VJZnFVR3hFV0ZhNE9CcjZobXM4RkRvZDdjS1pPbkIwUk1vV1VV?=
 =?utf-8?B?MjU3MnJ4enMwWUVPMm5XZGdUUER3S0xXTDNWMkJXemdpdGRBZ29xTHZzdmdq?=
 =?utf-8?B?ZGQyaktwM1BKQUpOb01OeWp3Z2hUdXhHNE5Yd1kyVGRLbU9xSG42T0xkK2tp?=
 =?utf-8?B?UGpCOHlaY1B2NjVnR1AzV3JnY3hNMWw1UEJyT0VpczNybjJaVUZQYUlheHZL?=
 =?utf-8?B?eG91K1VmZm56RXFzTkNyU3hHMFc4Q052aWlsbng2ditWcFhMa2dHQnpUa3c4?=
 =?utf-8?B?K1Q1MmtHQmRzNk1Tc0MxTVh4NzFBZEY4YkpEeGNzN1orcFZ5RndTV3IxNmRw?=
 =?utf-8?B?ejFPckd1ZFh5NVlWUkIyU0ZHaXNkbGREYWNpUjdJanRsREhNRjRDTVE5cytJ?=
 =?utf-8?B?VzR5MjJVa3l3V0QrMzRZMGJibEJzRDhFTk5rRmNXd2lFb2YxM21CN3pQaHpG?=
 =?utf-8?B?dXJOSnA4azJ3N29jdFh1ZGlKNFlNeVhUYTVjVHZCbEJFdDRZeG5ENzBORVQr?=
 =?utf-8?B?TWttOVp3d2NHR1ZWb0grZ0VtMVY1dDZCS2J4dGU4K0pNbzlQR01rTkhOK0Vm?=
 =?utf-8?B?U0NXczc1VnVtd1lZWWdIUjlaM3NNVVAyUXB5bXRZVlFtRVliZGttN0s1d05p?=
 =?utf-8?B?bVNKZms4MGduZjNXeThtVG1HeGowSFdKQ1ZQcG5tVmQ2WVVWbUtzeWhZTzcr?=
 =?utf-8?B?d0JlZzRIbTZyMTB4c1NIUlpkQTZ2ZC9MYklJQVhxbkFBVzJzTXdBYlNZYVh0?=
 =?utf-8?B?bVhyaFUwQ05TNitNUWo1MTZLcE41WlRVeUdJdU5oa25VMTltVHpwT091R1pT?=
 =?utf-8?B?ZEFibWpUQ1A2eTM3WGlZRnA4MG9OMVBtMWFucUdtcGRReHdmZ1JZZFBCSzJ2?=
 =?utf-8?B?Mk1lN2wydUQvU3ZueTBVQmlMVXBaeWo4ZklsR0JWUU9BSDBrSGlQMnBBYmNC?=
 =?utf-8?B?VGJyenBZVXNxQWNvVFhxQnFXMFdSTWJmK05jdGRLOHFpYUd1SWdMS2wzK3B4?=
 =?utf-8?B?bVBpMlg0eXRjS3ZpdWsyV0Y4SGtWS2lsUEMwSER6ME9PMXFFNFhRZ3NtRlZ5?=
 =?utf-8?B?Rlp5WlhuYks3UXdIUjV3UDQvS2ZybVkzRFlDV01ONnVMZlBCN0VDR21JZVNG?=
 =?utf-8?B?bzNBK2dPY3BzcVYxQ0JaL1lYclcwTXpPVS9ZWm5tc01PeUZCRjFaaVVUTito?=
 =?utf-8?B?UTdLaWR3T0J4dTYzQktWUUdCQm1HanZ3VGozUXY0QXhXTjBKN3pOTnlhQ3h6?=
 =?utf-8?B?cWVad1N2Smlmcm1kNDFReUZ5SkhKNTdqcHBldGJCT1dPaG9hazJrOEtYSy8w?=
 =?utf-8?B?YklsYkVLVGNnc0RUR0RNcDFvYWVDcmdZa010RXhoVVFzaWdQOElXSWRCL2R0?=
 =?utf-8?B?eVFPRE9FZmdIbkhBczhFRkRQaXRRa2RVamhpOURRcWlTeDJQUGQvWk9nRzNY?=
 =?utf-8?B?djEwZjJjOEIwUU53bk44TW80OWoyOEpueXQwdnVlWG5vaitEWlp5NmRTU3NF?=
 =?utf-8?B?STJWQTdDbHFtK3pmNllmRzIxMEQ5Zk9QcFM0RitZZCtoMDl6K2dDZ25NY1Ro?=
 =?utf-8?B?UTdxR2Q1aWtpMkZid1RnUmx2REV5N1VvcllvVFNFWmVneE1mQWZweVNXNGlU?=
 =?utf-8?B?ckduNmFFdi81cmRiVlplQzdmQXU3NStGZnZTWFhINS9tcXlHN1RnZmQvV1Q5?=
 =?utf-8?B?Y0xUb2xiZjdsVlVwcFlkRjlMRk02TXdhR3BrV2tndXQrempUMGZCbjV5Si96?=
 =?utf-8?Q?4wl11rt7PJ/Ms8ZL/ngy4w4iH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cea029f-f71f-4246-b4ea-08dcf46c5d04
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 20:42:23.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCRUNEVf3E1iSwfEJU5Ca1FimR5vrLD08ghUMvRIvHkEx9LtYOo6I9WzNTNEQQMA4A5yE0xklOi6ph9rrvNqrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517

Add new compatible string fsl,imx8q-pcie-ep for iMX8Q. reg-names only needs
'dbi' and 'addr_space' because the others are located at default offset.
The clock-names align Root Complex (RC)'s naming.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- none
Change from v2 to v3
- Add conor review tag
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 84ca12e8b25be..7bd00faa1f2c3 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -22,6 +22,7 @@ properties:
       - fsl,imx8mm-pcie-ep
       - fsl,imx8mq-pcie-ep
       - fsl,imx8mp-pcie-ep
+      - fsl,imx8q-pcie-ep
       - fsl,imx95-pcie-ep
 
   clocks:
@@ -74,6 +75,20 @@ allOf:
             - const: dbi2
             - const: atu
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8q-pcie-ep
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          items:
+            - const: dbi
+            - const: addr_space
+
   - if:
       properties:
         compatible:
@@ -109,7 +124,14 @@ allOf:
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
-    else:
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8mm-pcie-ep
+            - fsl,imx8mp-pcie-ep
+    then:
       properties:
         clocks:
           maxItems: 3
@@ -119,6 +141,20 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imxq-pcie-ep
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: dbi
+            - const: mstr
+            - const: slv
 
 unevaluatedProperties: false
 

-- 
2.34.1


