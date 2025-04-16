Return-Path: <linux-pci+bounces-25973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C056A8B003
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6001A1900C5D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 06:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1948122A7EA;
	Wed, 16 Apr 2025 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DdYo3EIj"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011052.outbound.protection.outlook.com [40.107.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C184F227EB9;
	Wed, 16 Apr 2025 06:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783756; cv=fail; b=ftLnPMJV8KcMJz0Wog5VdnkODxgL7JGqMfQ01c/4eAtdWYfGdpAcCz758jmw79G7BysDiO+UFxBqD7bropAtObEgRnLEFCwHhefVhUhat2D/J0zsbbJsjU2LfpwaD7rUgQmz+agoqoDqcvO514gZ8ekcrvHh9eKLamlY0t0dv1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783756; c=relaxed/simple;
	bh=v5tAt/o8kvdvru+aG0vq4HLzOthU1VYe+yXdmHjXPR8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ML7sM9vIIHTywG3Tbx/W63Y9AwQmlQvcnslBrM3M/OG1ciU11wP5JnMXhxkVAzmJFggTWDSsWIJLuRLqFVDc1YwamT/7NZoRFac7spYbTR1HVaywuOrAZZv7eBVuPL6dTUSRIKmlBsrQd7SV1HXs97oJA7ZeaounZ4A65YRrOkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DdYo3EIj; arc=fail smtp.client-ip=40.107.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efaPD7TA3JCr9dEPCPQyA0hV9lXNQurWCTWQkYC+itJh0JsYFnWH89TLiJUdDyLqeK1YoS4fKZgAh1f1JfNyEaZOXENvymbmPX6sNh1RTeJfmq+6R41LKCOu8W9iMBnC0/hF6fkvn/6X/jlMK8QP5GFdsuTRmumgVnuRR2Pm2M26pevZrHi8ww1fuqfq2KRZUrMzQ072T1GsOPlkb2Q+tMhVF61pd6bkgmkpK6FLsMNDIGnYArjCegWgb4fLfCs9l9JRB4x2w/7Mk0wEx83u/n7mwV9yQ7zTho1KGHm0QwGbmps97kk7SbTYPTU6vICWFHZXPGRA7SI/jqz6PHB5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzr8+Aax66JAdJzl4qkbwyf3eVBn4p7nLWZ5q1OiJNk=;
 b=Fk/zoWtnwKfMN+yvmZrF1seZhlrX8SR3Z3LI7PtoJJscZg413U8GkzSsZejxnZRd+eHEwXGqM5GBMx8SgSAPK6gWHijf04HeUS10itb+6mTp/4/PPermHWqOuLxmQ66Dzlf09lTnP61v9N856XYWxD7JpvmhOPPE/UGxFf6i2xFO4r++v/XpBM9IchwQ2z02qMb7YZQ7nohDmbPtmbiy6NiOwc7xm8m4KV7+dSq9T6G3F382h2s4CcslGJ73z+9+btNvvdaI2ywmrEai+LdVcmApFjiQ17CrEU0V0Pnfn2cIPt2iaFYbIMhSIEK20SOSqE4DxXj1y2EfYgj0kKOB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzr8+Aax66JAdJzl4qkbwyf3eVBn4p7nLWZ5q1OiJNk=;
 b=DdYo3EIjfE/vijNMQrMn+cCsUXH3wmJeZnu62UJeBhY95HQfIPt+cRTGdjf1Y5Xp7svmtDDNMdPg07n2mX6hC7AgsHXRy710SGd2dnj1COVEPuoTi9Sw0CC/2kxO7GYqnuPHGxn3w5BDYoXsh2hHmCn4nPP8qj/omhL0zpgIGIFsokrrOwcPJMW4OK7xh1yhsgvbfhv0Xiq9jm7ZfxCc3x+c0zOAWTG2JgmlGdq9MqY1xTpYCG9eWMUv8LBo+XUDWCZoJIBIwhkXuNqqd5ZCU16eul33Irzx5GVoudFYaU3KVVKmVV4L4RBPD/xGJga81Nbq3B/iirnc7jd7HQH25A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 06:09:10 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 06:09:10 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/7] Add some enhancements for i.MX95 PCIe https: //lore.kernel.org/imx/20250314060104.390065-1-hongxing.zhu@nxp.com/- 3/7 relies on "arm64: dts: imx95: Correct the range of PCIe app-reg region"
Date: Wed, 16 Apr 2025 14:06:41 +0800
Message-Id: <20250416060648.3628972-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0e3624-bab9-46ab-d6f8-08dd7cad33f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014|220923002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tub8KLHEapNgsvnyNpEWjNeEuvfRZt+GBWF4x5MrVN+ntKUqfdLv3+o2Ax2M?=
 =?us-ascii?Q?YA3dUKQQuLb2JlRg/i7ZTwYsZVO/6hPiyQsdqAsxWyxyjvJ8kAotlf8oydoa?=
 =?us-ascii?Q?AKRQR5V2YitArjdkhUCANBiV+ajBIx8t1Te0rDM0EvSENeYac+ruM0jQVhFa?=
 =?us-ascii?Q?PW+GAV2bbtTQKVeroTU11j107aHvOmEYI8kkXk41xMNO7BMcWcswHcGkyHxF?=
 =?us-ascii?Q?n28UjgvzjhWPPtEYtU0EISQyT3USw/GYd8z9vDwSPp4Icxu6cC8x5i7hvrMv?=
 =?us-ascii?Q?xhkRkdr6NjMRW7biY+COY8bwvs+nkCICF0aUHfG9t7GgRMVDkULjiWG5yiR0?=
 =?us-ascii?Q?8nq/Ye0baDpbeJuVQLfErCAoMvaGEy2tlDAoI39Nt8csQGMxk9RbzIewUnqD?=
 =?us-ascii?Q?xktRrykMnvCNDyESJX3kfWpYf2/VSi97mCk6XzstY03qa6zi8GUlOLxNswv5?=
 =?us-ascii?Q?DiFSLjXVSXneZrj/GcMFJowoIsde+EdNoJlOtUP77PUam+9kT8DC45C/Aw/z?=
 =?us-ascii?Q?Up6miWwqpDEABXdZIPGsOs/yf3WWUGB7uhutNS5PDI5Lae8mwVK4fp483MRN?=
 =?us-ascii?Q?mkPqN3IvZj5/UOpUHLmBRi3bhXsu9cQBTvOTCeNYOM/IS+a8NhxkYU9g9whh?=
 =?us-ascii?Q?PIl9gYNN6vnLPvTr5TRRNCC5XfN1qjmi7CVunyRmd5vQYeanmrVcO7ul6nn+?=
 =?us-ascii?Q?/F1ZAwEyOT1wUodOnkoSihQILMNP03O1ZVHEiaWIXyOZVZF2Ym5OiUMcnLSv?=
 =?us-ascii?Q?Wa90THo4FVr9OwdS7ab0wHXT+UFMnR0xspe5yErIMW8gyyqpZYlMFGfGPis3?=
 =?us-ascii?Q?DaXm0GJlr59Udz280hXYLUiYGgDW1L4T2eNL7VsFYHy4oC6i9urltjEzsdDE?=
 =?us-ascii?Q?ZfxcaQKX+EKtaCFZQruTIoombn7/ktTCZMMP8sv/8nZa7BnOihEYcjxLyKdF?=
 =?us-ascii?Q?pmCcw7/zlYegFFxIM4ncHYabnSFNlvp4MA6R72T4nP1kaJesjSWt7o9Z3PXh?=
 =?us-ascii?Q?d93TC+e/SSPUCz9Rw01tw5XSCRoUreEEZMKkDHCsCK5DsCLVy/8kFSJ8yY//?=
 =?us-ascii?Q?aJKyhCgQ9bdwi6ap5mCmjYnx/igxhbGMhGhbJQ4XgAE6u4Z1Zm9ckH3ajhrW?=
 =?us-ascii?Q?0cgU6gC9GowM1KIb8ceAxP3sB0j/V6hXC8t2es1zj/mPsExe5tYe7GUZjC6n?=
 =?us-ascii?Q?N0YJunLNHaR54daR4emV2iZLXeLMQqpz0W8sH/HJFkI/d3CEqghrtXFT9OtA?=
 =?us-ascii?Q?qWqMOC+9csCLdMGvXIxuVrS3EYm1z0UVNlouNneoQf5mHHKS+0LVPwNtQl7Q?=
 =?us-ascii?Q?ALgJzPHARpQ7NlHA9kvYIBn/w87I9bVaq2+rhDOY3QogpJqE2L12hxZP3p+Z?=
 =?us-ascii?Q?lv40qcA2aYwYB3FSbX9/ugRXriBw9J91jDse1ZYdpew783YHUaoZ+tGQsdaS?=
 =?us-ascii?Q?dawo5HjXUx+9a1rNH0dH8ZrmY2vSMIFQBfcPqzvNZgANVJLdugjt0e+SvPoY?=
 =?us-ascii?Q?ztxwmYthMynQ0vMjeMBbght8RCgcmZyn/lu4La86B1Lbmf6HgRGuutQVxQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IlFdcPrpeeTOzeEpQB5DNbhP9/lcUC8HcVkKhMhK7HaGlS2PV8acTNFf5Nb/?=
 =?us-ascii?Q?O632pgMV0sAnmvuNfMdtt53F4xacWpufAM0e3Zy/jsbo0o87OKvKbhyTlDP0?=
 =?us-ascii?Q?si5DDOjgeQwtQRYLYjPLPLkwPoSnbctsMiWTrsNniv5aIfufA9ruxdWMObLI?=
 =?us-ascii?Q?kk0r2aLcr3OA0K7evWhuBNAbvivhnuIL983aeRTo66UOKhgBIrzLD4Dt+OtC?=
 =?us-ascii?Q?o3QtuCMkv9VNIueJkdItjfAZp/atSBHKjTXLyf1whAUIcYWDRIgArGHKNNkl?=
 =?us-ascii?Q?jdvCLxGfvY4gLTheq6ZYfLVUCsRL66ZeiMyUEsQuo4+r+Q2czVQv/QgO3EOR?=
 =?us-ascii?Q?TN35j2j/sAjgAz2ZWliZsoutfJ0WNI/qgUWES3wJoHJnSBNS4ajmOhySnvxx?=
 =?us-ascii?Q?OkQpUSDsd+R2RLv97jcKPbFAfhDMHAtrmBnisBE8LRtyqAH9FXtZpdl6uMJo?=
 =?us-ascii?Q?aqdf9/XLP7fGnSlTvmEpy0bsVAGSxupFvalsaeOLw+CIEhUi/88Tc6wZv3vf?=
 =?us-ascii?Q?hvr2ziozrvDM3OSHJyx41d9lK+p5Rsgw9ioAnN6Fb36pwFDwIH1Co8mUvIum?=
 =?us-ascii?Q?Sb7zVMVKb6HmluAVaEC/cZ440CawI4pyI8VjUB+YWD5pvz32/c5hc1t27woE?=
 =?us-ascii?Q?VhwbVZyl5KagcnMs3V16i2tFlu/j7SCUf4FOiHc4sxgKek0dwuIp9IB0aHsR?=
 =?us-ascii?Q?TSZ65Orto7D7j04mrfc+x2Bpi9uI8Vf4xyPYAWMs2FXv97GqoUnAvDA80nQL?=
 =?us-ascii?Q?VO8/zO9e2dSZ3ZeA14MGEP0m3Ggl9I4WWojOVBxbtP7hfCjgNDSr0vp3qa1t?=
 =?us-ascii?Q?PyLw9rjU3CZ9u75+jbaWCchaT+RnOqothmJmFz2iHbRlLjh9l3QsKaisgq+S?=
 =?us-ascii?Q?2gc2rWm8D5flmAZ9JylOqRzuOyhl6qB/uzKD8C8W4F9k/nXN0St8iuv/bZ5T?=
 =?us-ascii?Q?W80vRfkWRUzI+k9X7/pAWaqxUmZDyLzwQyYay6HBORcVMouTJi9eEd+N4l//?=
 =?us-ascii?Q?TY6+vgeZEnHvq9q721BCSWU/WtHzOOnyznqPcvVU5ElltVs/c7BKyaQ34Ebe?=
 =?us-ascii?Q?DMvQuVTYr0ISTnz2XSq3Ua8nx5nYFE7xzVidm7s7TNRYSh9EAA0jq69U6lXk?=
 =?us-ascii?Q?A8C62FN8nOs+zOTw1aazEtZIyEIf8WF6zkicH9vus1GQa6PJ1VvPSwiANri5?=
 =?us-ascii?Q?kOmnkGCeL5mFgg5K5YbTM73Ppyvw/vcbsaDdm7EpBvgeRzhtQe4PKxXculn5?=
 =?us-ascii?Q?I3w7JwGgUw4ZkfcfcfddCLm5ciEAzB3tBbqkgmUPnZFU6oRB+iBVxs4PRxDG?=
 =?us-ascii?Q?9WOw7EFX7d9l5ClNborsIuCD4ve5JXLiSltNOHd2gRq9Kzt/fgWak5kT6Kva?=
 =?us-ascii?Q?wygQoinqigLQ8tAnrvoyC49CAdpNc59F5isQTsgCCXSWn7wJNgRy+mshFKAj?=
 =?us-ascii?Q?vtYWAr/uKWQI9R2mFmV2dsjE+inHX2UynuXCKNypMIMmpT0bX0wpJxk25n4U?=
 =?us-ascii?Q?oucdPCSC2tF4jPwnunB6iVJ8jFoNrvFSkM1OIPvYbMI6eAcTyAQ4fdtoxm2D?=
 =?us-ascii?Q?kbaSV/w0810CGrkFi9Qcrwor917vcWcpJd+2QQYK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0e3624-bab9-46ab-d6f8-08dd7cad33f8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 06:09:10.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cav9dIPerS1Q4KLT5MO15xX9R75EqLkYRBxoFDuu02zDg+LY/4FcDrKyM6ZvztoQNGZhEjNThQs65hByARP7QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

v5 changes:
- Rebase to v6.15-rc1
- Update the commit message of "PCI: imx6: Skip one dw_pcie_wait_for_link() in"

v4 changes:
- Add another patch to skip one dw_pcie_wait_for_link() in the workaround link
  training refer to Mani' suggestion.
- Rephrase the comments in "PCI: imx6: Toggle the cold reset for i.MX95 PCIe".
- Correct the error return in "PCI: imx6: Add PLL clock lock check for i.MX95 PCIe".
- Collect and add the Reviewd-by tags.

v3 changes:
- Correct the typo error in first patch, and update the commit message of
  #1 and #6 pathes.
- Use a quirk flag to specify the errata workaround contained in post_init.

v2 changes:
- Correct typo error, and update commit message.
- Replace regmap_update_bits() by regmap_set_bits/regmap_clear_bits.
- Use post_init callback of dw_pcie_host_ops.
- Add one more PLL lock check patch.
- Reformat LUT save and restore functions.

[PATCH v6 1/7] PCI: imx6: Start link directly when workaround is not
[PATCH v6 2/7] PCI: imx6: Skip one dw_pcie_wait_for_link() in
[PATCH v6 3/7] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
[PATCH v6 4/7] PCI: imx6: Workaround i.MX95 PCIe may not exit L23
[PATCH v6 5/7] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s
[PATCH v6 6/7] PCI: imx6: Add PLL clock lock check for i.MX95 PCIe
[PATCH v6 7/7] PCI: imx6: Save and restore the LUT setting for i.MX95

drivers/pci/controller/dwc/pci-imx6.c | 213 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
1 file changed, 182 insertions(+), 31 deletions(-)


