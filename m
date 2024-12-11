Return-Path: <linux-pci+bounces-18166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225199ED324
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 18:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D02287B85
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436EB1DE2BA;
	Wed, 11 Dec 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SsMQXOY8"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27461DDC11;
	Wed, 11 Dec 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937221; cv=fail; b=PVTrTNwGRRhkOU3llzmITx7gU31V7BEYVlmHXymVWoj5hje6YWUedGDE4R4HRSaOdy3c8WykL/HXlzlZU1V+t7fkucsIGsvilkXZ19GGiFefSC8Vr4PCmXZXUB/bsMPuZW0doi7W+mfznOfneznBELTxaBYZge8RyWxGNBfIxE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937221; c=relaxed/simple;
	bh=gYJR4lKCwQmLIMC4EOeJtFeCoCpT0mGjTxoaVChZ6JE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=n1YqtNt7ouz1YNd882wcnFkzOX08i0f/cZGZwuPEPjZV8b8C81X3M5sR+cbIteaSPI3IjiZSl+hZvAqN1p75Hba9In8nsjk+l2nZX4B8VWZVatGfVHbKK74DA/UejDPIqD5dCuMEQDkoC483wIx7ry/k0dRYHm6a/4AujM9UouE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SsMQXOY8; arc=fail smtp.client-ip=40.107.105.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcZh/wKGhEb+Uf31sU4a34SCCCp4p0TekteiUsniBO1SrR88ikRvlrhQYoF9rxTtIIZCLNT2sEvDAJF7O/3P4A4RUsuNqQ+IEoP73cwly/UDKDQQVGTU+5s81e1FMs02pa98HHm6AEm7SsaRHFpA5LPpUulKOISzeTmCvW43uZafEJBUYD8NH8ts+p1I5/viumNB1rHkpEc4/wY4E2xiO+c5vO3HxTaWyS6W+hjJYMOsNO9BGSRcTdA5RlRlnFFIDPsEVp/LAIlJZCQBFEUurqR4NO2W4xMLcO7ZkEjGKa4Fav+hAWQz4ZpO8bQCoHqWUPbrDDh6jUBjkITRdmSdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq+DzQKg5/uJlPUpbg2uD9SkaufF9+/slw7inz8CbAM=;
 b=xd+7S2MH6ImnA09inXpOBe85KOgr0RSWXTMwHZgCNSHkFV1tEs6jrhlneAay9Z8N7YGawr7NiY501yEYIsDW/Gebjue+8U13s8chpDIm7gD2QWzNEzVnrELSJuBQJCLxktsRYt17qR5Tg8el1eo3Cqkf3n+Hzkr3YWnIcDKvQxgYBH+jW+1Zc4vLmRcI2TcD8g4NskwGmimgg1/PI6Y0YRuE3BE9ZCdgkUj54kkfgLSI6bjE7D6/oSSJkmeziZUBBw9YuBq5VUJxpfyAekkFusRNaZapZq3vyH2A0OgPYj9D1F6MVMEA/qGUMA9GUz2JzLNA/aCD+bCwLqYPUPPgFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq+DzQKg5/uJlPUpbg2uD9SkaufF9+/slw7inz8CbAM=;
 b=SsMQXOY8nPOB8qJRfgLsP0Kz/LUpcTHq58QZsKrpapln7zZ/A/a+Hp/ZfpiPRMjVJEONEhbaTlLDZd5i+KD2i5lCowHuNtwmua8lSQ0zEPjZMINgop7Fef2K67KdFmyoXAn37QfAIDiHPbFAkxl+GADKJyoSbeBi/EtmC3ELDoDfc3SEil5LA9fwTDltkArcgPOBozKGjB1csZ8xyel038XP6H6KOhupSUNnu/5nWeyQPkDZ4igCZVQj5W5DvK7gGy9uy8iq/+GqsDnmz0KMi0OfgLMBqLYN4Nvtj87CbTyz6sEKJMoTWewC4bygDhR9Ilop7qnWZJwsaQfUdxiy3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7537.eurprd04.prod.outlook.com (2603:10a6:20b:282::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 17:13:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 17:13:33 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Frank <Li@nxp.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] dt-bindings: PCI: mobiveil: convert mobiveil-pcie.txt to yaml format
Date: Wed, 11 Dec 2024 12:13:16 -0500
Message-Id: <20241211171318.4129818-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:806:d0::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9e83c4-a5e3-424f-2cec-08dd1a072402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gbjDBwTcH0lLAjDGY2CVEJsVfs+LDGATF+F81GUfj6YUkiIUKsS6dKI/GsFs?=
 =?us-ascii?Q?FCW/3qnSVTLbp84bDt3UGnmzySlcX1vfbQlp6YxJme0qv+5BSimZqONyNodk?=
 =?us-ascii?Q?ubE9F3oMPmFHwi/ybAZchjs2OCdVgi3dPJp/32GDxtup3lRB3fyGuSxfWIuC?=
 =?us-ascii?Q?BcZ20oeWs70aLE/EZ3mx8fsB6ytbEUpMvtClSAg1ETl4PVjVnxpu4DrQunVj?=
 =?us-ascii?Q?Rk1yvxoQP/mWGzTJ78RRNetugP1z71boID018LGq6Ogk0wfGLgpBlo414w7F?=
 =?us-ascii?Q?hQOfP5cEAfcaA2BAS8EnMik4BqPGxPBeEvyGEyd9HvHPu8sQZikLm23sOjtC?=
 =?us-ascii?Q?S353E+XqxSM9siaN9Yu2ga6ndUxuzdPsA309a7tc1XxkHVDZEBjn0+m9QdR6?=
 =?us-ascii?Q?yC74fPPfoZ7eahocgR16OSo7nE2YszTFHpbP4vlEIFPucPOiN9TDDwCs10P7?=
 =?us-ascii?Q?kHQnh2jvJCrP+K3JKQf+99JlplZ/M5iVYltj5zZc/0fYDpDbCzGbTi+L6yIk?=
 =?us-ascii?Q?SRkRtYVZvFfhUE2tlGobzPLaw3/YsrH8RinhKW01KiTRM7NMnwGkPppz81Ej?=
 =?us-ascii?Q?GfHAb6oHbjlNx4/pHxIlFdyNEOnJV+8wLIIWBbOsLVdjRUQ4K8d9QLgHJ7Sc?=
 =?us-ascii?Q?CrblvtMEZlTmdcX/OnozZjrR4ZfG488cJQYhW/YQ04Txdy5zNhAalwDgMsmn?=
 =?us-ascii?Q?A5I08pIaLo1iFlwl1fMrePMgbTP58l4/gJVG26rG05FxJVTdLfLxRnTWjODQ?=
 =?us-ascii?Q?ZK2JOdHqcsSdJRvpEu90smpGwSsAghWUFXXVp38f1rek31wzPUSBjFeNdCAS?=
 =?us-ascii?Q?18yPxbiFMAeRozMFn0L90XRXmibJlI55/FCOu30Jq9VMGsU6dUtCZMDTVDND?=
 =?us-ascii?Q?XvyfheonWz3WrauiakGpakRuYKzJ5P7PhVLDVBRy1QhUYHVzaQE1UXZLFMlW?=
 =?us-ascii?Q?HRQnWtDmc5/PY1VX3W5TkxHX3Yrlpj4UNt6CAApCW2DgKDhh3MGlnmulDtW9?=
 =?us-ascii?Q?TvUnwYzzI0OH0MtPhlgQq/GEHu9wv/y3E3qaIcz3zJMDvBiy5xPEJBW4VuIL?=
 =?us-ascii?Q?waaOifnqdDHXANM1Kv8XPtvmkXqAmzv3KkHvEuu2Ht/tv8Tnfcic14etM186?=
 =?us-ascii?Q?TwMNP18k0FXxNcdEST/0XuGeqrHBrRvPyVtA8xNVMEZ6dVJojPMgXgQe+A1+?=
 =?us-ascii?Q?zwVAdPXKkluriR/HCFf1MC89shfHAxV1eMZZWkTkK1f9MKjdQjaWBK+nwP2w?=
 =?us-ascii?Q?ZT5EBomQBnnS5QD1ta4wL7pGxko81danyztECfuEt5Un6+z+FnwrF9qEHiJe?=
 =?us-ascii?Q?+l4voNFUmsTthAH/rA0e/EsSjx5p3C/wvFZwsOgZyimC3P9vY6RFbUGkV5To?=
 =?us-ascii?Q?oOXoZZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ysTjGGezYGQSKdfLwVITpegbixH3aHkWKqnicqqc4c3KESpINa5w7J/XtNnX?=
 =?us-ascii?Q?NsgHXC6ZegJai+TbmIoDwxzmqofYd/Rmid/SmiVg9rxtapzvZGjdO2l/d2n/?=
 =?us-ascii?Q?yJdBUKrm8fWz4WdgBNsEBMCYeCj0WbmzeLZkWhQNc5hXqCcAOE6DjRXRXijV?=
 =?us-ascii?Q?HEi+6uk2udWbc0KzSKBL128WI/yRQv0fQzzShWN4hrgnV767YU7NgPDWTgzP?=
 =?us-ascii?Q?FaWI/CM0yfakTpBn6JEbngOqTSGuiDxw8gd7JaaLAHEQxEl54Q8r1bWUabRl?=
 =?us-ascii?Q?sXdIZ2T3qSmC+kbBlMTydfFfpWCk+t8wkmwzJgdnQ5terXhehj2pJSS1MJE5?=
 =?us-ascii?Q?28bADoRtq8p8dbOOl+Zyu7M/9E999JSfGFXAI61/ot/18HYBDBTK9WIA9YgW?=
 =?us-ascii?Q?PQR6hYkh6KOTT69ErPwtwoEgU73+Hh25Kk2KEQzI65PDzou+NlgfEMj7oHbb?=
 =?us-ascii?Q?WpP+NQYsCYWeYrPmm8+lfuaqq73GeZ8q5L1AFysky++H5ltb19R4Z/UgM0VA?=
 =?us-ascii?Q?77BcFr27p0IcaTwdIcoRxXYsk3+s0G0bitssUAjNVaH3gZsev5SuUgYsxs9H?=
 =?us-ascii?Q?/ZB6fDEiX2lWjmsosPEa9efRzOUvJUcomMoGtzNKkUIFDq+7MKobf4n9svjI?=
 =?us-ascii?Q?KCuQMTN+l/lFS9dCOTyOWdyR9qdcS6tTE3HHZeAzCtASC3gHMxZGjUkPg+QH?=
 =?us-ascii?Q?McTkpSvzy4l1aCG5+bCF9o70YufeJAJ7vD2QFT6t6skOxR2ybdGP6TaHXokU?=
 =?us-ascii?Q?iosCVbZBfxDFLx1YLhW0MrmE7bLSiRmEVjK3fuAPQ6MIeKl9nVWv2/5dUTsH?=
 =?us-ascii?Q?FdeM3gvlur7+fBPFz1BgbynHPV3P+/p5Ch+U93X/zX72MTMFgjZABq7oAS9a?=
 =?us-ascii?Q?+i8zB0h+YtjcQhe7R7R2i63z0Zegu1KF6yAx2Lm7ohGOZw9JfPpccHZDFcup?=
 =?us-ascii?Q?sLLEK1XiFlvHFg0oLekHeKpJafVHqMoV4rp9zlf7A1jyJoVXETbrj8KJCUiL?=
 =?us-ascii?Q?xwtORmqJDndfq1NWr9aK/cdSEPDzIqB8mDdGC9FNRqjOBgaUtpy6m0bUfbrm?=
 =?us-ascii?Q?/L6X8RVbgoPpCIJi5RwsgeTl7xaOe9axI1T5P7kn68tTFGkpx79ZiyV/TL5M?=
 =?us-ascii?Q?EG2rzPKRuiOpen75Fjme93Cp9xjJGykCEXKpYYZO98+cM7pMxmPvCXfmqPE5?=
 =?us-ascii?Q?MRU9iDdZ1Jbe4RqqeAylGHd3n5H/OBpdz1Msa/C6ybAnoKrU+GW1u9QcruOf?=
 =?us-ascii?Q?OrNRD5F0+oL6QV2aDabkAOT8DR1b4MEgjppKVrYp491vmlKiPF/VZoN4/8BU?=
 =?us-ascii?Q?LymoLYxcNz4pUErCz5hDjlthQb8j1qobZbw71Pn3Qe2e1L3k8wNGFcHkQCmq?=
 =?us-ascii?Q?PnAdQjxm4ICJni/IEJkoqaVeILU+NGihW5CbcYZBukqxhVbGCJyX3ZQBVZTi?=
 =?us-ascii?Q?X/6kF/GdrHIhUB0UnN0N0sx9WoNW/BzxqQrr70LKbxWWOVLA986Ucz2dPUtv?=
 =?us-ascii?Q?McxxEMsFQs+ySpIMTmExvGDvwRqjasE/UzGlcqouQEW7+496eSyIJ8vtOIHJ?=
 =?us-ascii?Q?fmK723fpGmPDtmZ9A3I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9e83c4-a5e3-424f-2cec-08dd1a072402
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:13:33.0328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOITLz9MbYsKS5QHqTCkClvWN827f76S+d4Mgb2AYYhMy/z1O3IXuA5DyL08Fq0sKcmCkKsP/RRQGhdClKFWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7537

Convert device tree binding doc mobiveil-pcie.txt to yaml format. Merge
layerscape-pcie-gen4.txt into this file.

Additional change:
- interrupt-names: "aer", "pme", "intr", which align order in examples.
- reg-names: reorder as csr_axi_slave, config_axi_slave to match
layerscape-pcie-gen4 and existed Layerscape DTS users.

Fix below CHECK_DTBS warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/pcie@3400000: failed to match any schema with compatible: ['fsl,lx2160a-pcie']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- add discription in commit message bout reoder csr_axi_slave
and config_axi_slave
- sort compatible string
- move range after reg-names
- Add restriction for reg\interrupts\interrupt-names for mbvl,gpex40-pcie
- Add interrupts minItems for layerscape-pcie-gen4

Change from v1 to v2
- update MAINTEAINER file to fix below
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070127.BkBJhnZ4-lkp@intel.com/

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt

lx2160a r2 already don't use this IP. But someone still complain when I
try to remove old r1 support.

So convert to yaml file to avoid annoised CHECK_DTBS warnings.
---
 .../bindings/pci/layerscape-pcie-gen4.txt     |  52 ------
 .../bindings/pci/mbvl,gpex40-pcie.yaml        | 173 ++++++++++++++++++
 .../devicetree/bindings/pci/mobiveil-pcie.txt |  72 --------
 MAINTAINERS                                   |   3 +-
 4 files changed, 174 insertions(+), 126 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt b/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
deleted file mode 100644
index b40fb5d15d3d9..0000000000000
--- a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-NXP Layerscape PCIe Gen4 controller
-
-This PCIe controller is based on the Mobiveil PCIe IP and thus inherits all
-the common properties defined in mobiveil-pcie.txt.
-
-Required properties:
-- compatible: should contain the platform identifier such as:
-  "fsl,lx2160a-pcie"
-- reg: base addresses and lengths of the PCIe controller register blocks.
-  "csr_axi_slave": Bridge config registers
-  "config_axi_slave": PCIe controller registers
-- interrupts: A list of interrupt outputs of the controller. Must contain an
-  entry for each entry in the interrupt-names property.
-- interrupt-names: It could include the following entries:
-  "intr": The interrupt that is asserted for controller interrupts
-  "aer": Asserted for aer interrupt when chip support the aer interrupt with
-	 none MSI/MSI-X/INTx mode,but there is interrupt line for aer.
-  "pme": Asserted for pme interrupt when chip support the pme interrupt with
-	 none MSI/MSI-X/INTx mode,but there is interrupt line for pme.
-- dma-coherent: Indicates that the hardware IP block can ensure the coherency
-  of the data transferred from/to the IP block. This can avoid the software
-  cache flush/invalid actions, and improve the performance significantly.
-- msi-parent : See the generic MSI binding described in
-  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
-
-Example:
-
-	pcie@3400000 {
-		compatible = "fsl,lx2160a-pcie";
-		reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
-		       0x80 0x00000000 0x0 0x00001000>; /* configuration space */
-		reg-names = "csr_axi_slave", "config_axi_slave";
-		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
-			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
-			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-		interrupt-names = "aer", "pme", "intr";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		apio-wins = <8>;
-		ppio-wins = <8>;
-		dma-coherent;
-		bus-range = <0x0 0xff>;
-		msi-parent = <&its>;
-		ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
new file mode 100644
index 0000000000000..667b955bf25d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
@@ -0,0 +1,173 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/mbvl,gpex40-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobiveil AXI PCIe Root Port Bridge
+
+maintainers:
+  - Frank Li <Frank Li@nxp.com>
+
+description:
+  Mobiveil's GPEX 4.0 is a PCIe Gen4 root port bridge IP. This configurable IP
+  has up to 8 outbound and inbound windows for the address translation.
+
+  NXP Layerscape PCIe Gen4 controller (Deprecated) base on Mobiveil's GPEX 4.0.
+
+properties:
+  compatible:
+    enum:
+      - fsl,lx2160a-pcie
+      - mbvl,gpex40-pcie
+
+  reg:
+    items:
+      - description: PCIe controller registers
+      - description: Bridge config registers
+      - description: GPIO registers to control slot power
+      - description: MSI registers
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: csr_axi_slave
+      - const: config_axi_slave
+      - const: gpio_slave
+      - const: apb_csr
+    minItems: 2
+
+  apio-wins:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      numbers of requested apio outbound windows
+        1. Config window
+        2. Memory window
+    default: 2
+    maximum: 256
+
+  ppio-wins:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: number of requested ppio inbound windows
+    default: 1
+    maximum: 256
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 3
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 3
+
+  dma-coherent: true
+
+  msi-parent: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,lx2160a-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 2
+
+        reg-names:
+          maxItems: 2
+
+        interrupts:
+          minItems: 3
+
+        interrupt-names:
+          items:
+            - const: aer
+            - const: pme
+            - const: intr
+    else:
+      properties:
+        dma-coherent: false
+        msi-parent: false
+        interrupts:
+          maxItems: 1
+        interrupt-names: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@b0000000 {
+        compatible = "mbvl,gpex40-pcie";
+        reg = <0xb0000000 0x00010000>,
+              <0xa0000000 0x00001000>,
+              <0xff000000 0x00200000>,
+              <0xb0010000 0x00001000>;
+        reg-names = "csr_axi_slave",
+                    "config_axi_slave",
+                    "gpio_slave",
+                    "apb_csr";
+        ranges = <0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        apio-wins = <2>;
+        ppio-wins = <1>;
+        bus-range = <0x00000000 0x000000ff>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 0 &pci_express 0>,
+                        <0 0 0 1 &pci_express 1>,
+                        <0 0 0 2 &pci_express 2>,
+                        <0 0 0 3 &pci_express 3>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie@3400000 {
+            compatible = "fsl,lx2160a-pcie";
+            reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+                   0x80 0x00000000 0x0 0x00001000>; /* configuration space */
+            reg-names = "csr_axi_slave", "config_axi_slave";
+            ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
+            interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+                         <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+                        <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+            interrupt-names = "aer", "pme", "intr";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            apio-wins = <8>;
+            ppio-wins = <8>;
+            dma-coherent;
+            bus-range = <0x0 0xff>;
+            msi-parent = <&its>;
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+                            <0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+                            <0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+                            <0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
deleted file mode 100644
index 64156993e052d..0000000000000
--- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-* Mobiveil AXI PCIe Root Port Bridge DT description
-
-Mobiveil's GPEX 4.0 is a PCIe Gen4 root port bridge IP. This configurable IP
-has up to 8 outbound and inbound windows for the address translation.
-
-Required properties:
-- #address-cells: Address representation for root ports, set to <3>
-- #size-cells: Size representation for root ports, set to <2>
-- #interrupt-cells: specifies the number of cells needed to encode an
-	interrupt source. The value must be 1.
-- compatible: Should contain "mbvl,gpex40-pcie"
-- reg: Should contain PCIe registers location and length
-	Mandatory:
-	"config_axi_slave": PCIe controller registers
-	"csr_axi_slave"	  : Bridge config registers
-	Optional:
-	"gpio_slave"	  : GPIO registers to control slot power
-	"apb_csr"	  : MSI registers
-
-- device_type: must be "pci"
-- apio-wins : number of requested apio outbound windows
-		default 2 outbound windows are configured -
-		1. Config window
-		2. Memory window
-- ppio-wins : number of requested ppio inbound windows
-		default 1 inbound memory window is configured.
-- bus-range: PCI bus numbers covered
-- interrupt-controller: identifies the node as an interrupt controller
-- #interrupt-cells: specifies the number of cells needed to encode an
-	interrupt source. The value must be 1.
-- interrupts: The interrupt line of the PCIe controller
-		last cell of this field is set to 4 to
-		denote it as IRQ_TYPE_LEVEL_HIGH type interrupt.
-- interrupt-map-mask,
-	interrupt-map: standard PCI properties to define the mapping of the
-	PCI interface to interrupt numbers.
-- ranges: ranges for the PCI memory regions (I/O space region is not
-	supported by hardware)
-	Please refer to the standard PCI bus binding document for a more
-	detailed explanation
-
-
-Example:
-++++++++
-	pcie0: pcie@a0000000 {
-		#address-cells = <3>;
-		#size-cells = <2>;
-		compatible = "mbvl,gpex40-pcie";
-		reg =	<0xa0000000 0x00001000>,
-			<0xb0000000 0x00010000>,
-			<0xff000000 0x00200000>,
-			<0xb0010000 0x00001000>;
-		reg-names =	"config_axi_slave",
-				"csr_axi_slave",
-				"gpio_slave",
-				"apb_csr";
-		device_type = "pci";
-		apio-wins = <2>;
-		ppio-wins = <1>;
-		bus-range = <0x00000000 0x000000ff>;
-		interrupt-controller;
-		interrupt-parent = <&gic>;
-		#interrupt-cells = <1>;
-		interrupts = < 0 89 4 >;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 0 &pci_express 0>,
-				<0 0 0 1 &pci_express 1>,
-				<0 0 0 2 &pci_express 2>,
-				<0 0 0 3 &pci_express 3>;
-		ranges = < 0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
-
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b13..e0fcdd8b6434c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17901,7 +17901,7 @@ M:	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
 M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+F:	Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
 F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
 
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
@@ -17925,7 +17925,6 @@ M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
 
 PCI DRIVER FOR PLDA PCIE IP
-- 
2.34.1


