Return-Path: <linux-pci+bounces-34034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8876BB26022
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 11:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821A1162A04
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB0D2EAB8A;
	Thu, 14 Aug 2025 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m1nehHrC"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04B92E9ED9;
	Thu, 14 Aug 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162006; cv=fail; b=C9AXJc9tRypIT6eawRaj+RwnkEcGRLi7A7DenCMcY8LXVPAOrHh+P48tzo8/jS61Ss1ssQdhYsGxVB+2SsrXZQU6jNipL4HtG5hN3KD99y2fgCI5tULQ36KZyJLsQc5na224JIqjR1YdMhoNO6gMq7/6j9THHbCMsYhp8KgdzGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162006; c=relaxed/simple;
	bh=QJEw0wFvuWTFk5LC+1S1mRnqexQ/UZ823A2JtqSI7WA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TfmVl/3x3B28SDgp1nIJEcKgR5dqItEo3blgxuMXlSBO8R1UEbpp/OsB1d6AT2Ts2xqPSZA/OLxdotK+4IKEtNQiN6IJQQqKvX9wMAOee0tFZxLBbTg0wa7fsOcer1wR7nvX99VpVfI2oiZqCtnTnrm2j/rmbufAL+8GIImOSAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m1nehHrC; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc+g6P1snm1BeVva8eOG6emScID4bamMcqaGuF/rwbU4nTtaOVUN3+nsB4mtAlgWTqS3MHyjx1DIrkGmOP2uA5RhLvuw9d5klp+XiQHqHtkJqZ9oQ0teLmxshM09XmZdVqMQiAKYSTrJGtCLRixgmNvSQlEcLiYME9OR13fjza2eErABrD4i87vNvD/rVkPa/LwQVV6ydjJy9cAVgbkL4Xp52Ac5wXJN0wSFxgr/jwZzVoCVLYSmSHEvLDvi2uGIOEQ+sryBL1NTeJQ1UHJd3gRdnOPdWZA7hUhNI+u66YZUfpW7188yarPB9g38zOmcsbQBvxgMZzOW/F5TMfyGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0gb00LyZoAZOA75YtXXJqNnknW6FtN+rIWRKloEKwc=;
 b=fVNcNFWL6oE03JBctP+rUFU6WdpMl/jfVLHObBbPx1V/m81PJzLak59IkVUNyRMXFaecfDpSsR3k0ruBBWgXKrh3e1cF5y1KxWQ+05WM7PDoSSXbmRDzCkcmgnIQ6qrr3Rvd8JHdORfkXMtrgbjZR0AFzq8mm62cqO6xGi8eaz5t+nnUjgyiTNFHXuDo4Njv186A+VjEpswf3GLqEYBLSma5pxrgb2BINZLsPxB0xlgz5gG4gbiZEhW1bRvEJbUw5iShrVmE9Z52iHCcZE7NooQQemTwKS5LxtOMQ08O+cUFQ2Gxf7C7QafEqoNNJqNb+tPfOJsXLE+uwJA9FtXv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0gb00LyZoAZOA75YtXXJqNnknW6FtN+rIWRKloEKwc=;
 b=m1nehHrCRRW5xKySFG6qTo+0wBJVJ9G2514XtAVMHQMnwQyml0nuhmPpbWGjPtk+fAgqCZ9U7rYDs0Hf2Z7tw6lV6UgquHJh2oldXw/C/OLH0dXVWUSZo3V8BWfPUoBolKiQk1BgbZeybtex0MVYMWeaJXxxWWbg7Fi6dSTxxxfV8y1C9Ehpf8EmIqt4hyMaM8mp7luXcVybzPxKlI2y3KKnSUPzu6MYRkQa22eTJn1TsnOjTVJ4i80pbTJ5x0MoI/ANIwUC+ccmEKhpylkN/vCmbfPzu2dMr/dftgNFSWzG6QN1ovDCqjm1qQhlNOP+4ix+qdQ+WKPGlPGASodnTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VI2PR04MB10905.eurprd04.prod.outlook.com (2603:10a6:800:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 08:59:59 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 08:59:59 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v0 0/2] PCI: imx6: Enable the vaux regulator when fetch it
Date: Thu, 14 Aug 2025 16:59:18 +0800
Message-Id: <20250814085920.590101-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|VI2PR04MB10905:EE_
X-MS-Office365-Filtering-Correlation-Id: aa02d05c-f506-4d67-8997-08dddb10f25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|52116014|366016|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rRgnkO/54lx/gRMl3Odf35pA/UT3mc0CYOILSNnbkkDkm/9ONi55nVSHH5cc?=
 =?us-ascii?Q?89bPc1bLv96PcPmOF9NaF8bGDX3pqs53QTZr+PfCSdp2VXDhb+DuIUcvDz3y?=
 =?us-ascii?Q?fWSc10GARWg+iMMYfY+RfNG512SNUPb+XDHEfXdpDCGYAa+GOaNphuJnRD9X?=
 =?us-ascii?Q?OH88ZG03EHCuNt/92zgFW0Vw5nfENEGn1iRXkindTMtPwjj0o8C0aqbIBqg+?=
 =?us-ascii?Q?WxQMgU9LCwpj0wa17TB/De3JF9zCbegGGrpH0M7ijBYqVB5TkqYsaByp7Ncw?=
 =?us-ascii?Q?XTxCpuf5H0MlFPcpFM14KGkqv/YQKayN8Fpg6oFpF7nTeVJuSXecFvOskk8E?=
 =?us-ascii?Q?ZWNhIpRittItKVenASrszLoXAN6xtrqZ4PmasNffjnvzgryVY7wFiSdi3sFU?=
 =?us-ascii?Q?LlIfNQalMoioEVpaJ8CJKFXj3rbzXBKRW98oeRzbSzgS9bnl/F3tp00ObnZc?=
 =?us-ascii?Q?J/Y61yd/wnFJkLMYulX/5J5L7/8CHO47QkapAVSld8SWVMPBUPY6oKTO1gWY?=
 =?us-ascii?Q?X/y0YpauQgmenUjkb8Y4n4IxqxVrDVuAjwrfW6hkPItqq+qRHw4y9h7UGSnn?=
 =?us-ascii?Q?lRqG96ZcAB/dUqL480LI3hpNpuxxLD2TJVdyTh1ElgyAXqLn+BO4nfeZmT18?=
 =?us-ascii?Q?2B78K2VMQ2cEIXkmkRqJQ3ydSyV9OB+dKUXlmp/q+byBhI7PATctV/sWWtZm?=
 =?us-ascii?Q?ur/W8WSx53nHzq3+pH8SMcPrK33Izkx6YYlHH7ruf91lWnMioiM0XnL6/K+X?=
 =?us-ascii?Q?3+bOJi/Fp0ckaRC5qf4iJVkZlU+EuCUf2MMZH2HRnLWS5DF6qbdpNHt/fY7v?=
 =?us-ascii?Q?APHPgMh8PLi5PvyoJWOddlkksAGg1BxhV6kcbjjZH21sEh8rzx8ReCjTEnv9?=
 =?us-ascii?Q?z2g6mbc4LUUFZN7r2+P/vkQrI5c/ZgCoyYrSj5+x5dB0ily7GELvVBIEmtrc?=
 =?us-ascii?Q?avV5IAvowASTfNpu2PrEh3BAsGpmWcDSS+sHvxF2dDbIrTrGvx22gnNM2KJG?=
 =?us-ascii?Q?Ew72XpyvB6RjJ2p9M2UEe3nEDT+8l/SlGSk5vntAoQazq30EZ7fBWABpTBR0?=
 =?us-ascii?Q?TY/BsBhyE4as/QD9AxxRKBTtQZ6lsMyDODW/cKwKHEFbXyhymiqqphvBzElx?=
 =?us-ascii?Q?Bi2RE483Jh3BYoP/aNZNJ6pOch9BvVr2IiXlZvRbqMHLBv2HwyU03FA0EM0A?=
 =?us-ascii?Q?BxyuFjK8KqayZQzOYY+OFbOyI0s/OlEH5Lvqi/jSFJDh1ZNGit6VSZ0ZrhsV?=
 =?us-ascii?Q?0NaXSScorGtBg/7vBtB5/roroIUNgg4NbRZI5908rW/ee0tWLo1iLIGGoDdZ?=
 =?us-ascii?Q?5ZoSoWK3Z94bQAQ2xpU0ZUF5BnW6Tr7gXRpuYAPB6aF5nRI6FMg3yiDUYE/e?=
 =?us-ascii?Q?0WZni7uvhFDU8D7YyygFUi3oZspU1ihGmXJ1NHzlLoZDW858OVEpiOpKch5N?=
 =?us-ascii?Q?H447iI8AN8mzQ4UCiDturtiPNjM7VKb2rvGvKrVFqoFaeohVEVolG+1wpKdj?=
 =?us-ascii?Q?tkuTMPO4IVE6VTQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(52116014)(366016)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ORBaMWG2gmcSGdcwB0uwCXTDArpcrwEycOsyh1HgLClQFSUh+m04VnKTxwpT?=
 =?us-ascii?Q?f8upHbcreq/1idKD1txLCr9XsCewbl2rA/oJdqA44M2MGBFrB2WWh6Tea8xK?=
 =?us-ascii?Q?13j4ASPWpbfPet6Y/lsh3ZQ9I3LNpFx8VyKqtORTx3gcR9C2xGp467/Zxrqg?=
 =?us-ascii?Q?NXS4KGuv6hAjnziHykVJJLzSYPnGky1loHpf08KInQCYzV4fNa4Z84+S1XyM?=
 =?us-ascii?Q?8ko/RVXhbCaSYiFETTDvpe4G1rfXvdVVra2w/YdFlMAJZbFHMBYozn77Ih/7?=
 =?us-ascii?Q?NhTw2X4tRZ425ywkFH6R4Kq5wKQZPTB0PhHf712q29VNLjQHm1xv/4Iqqsy1?=
 =?us-ascii?Q?rQmo22PYQj8/cDJFdp2coRnvM5hjQZxdfFYNPjplkyomCCXHe+y7ZrjEKZ/O?=
 =?us-ascii?Q?uPVrtT6imeXVMIGxcAmRtj+1s4WoSgPVPkgp/NRkCO/8lJpT6Bqv6QlPu3rY?=
 =?us-ascii?Q?UBQT8NphGW0i9f0mFBaElHbtw+0QZ84eokTFO6C8X1bJfjdQVSjSpMIXpjiE?=
 =?us-ascii?Q?M3RHtRjD7IAd0w+5qgXgyaelfD6pvMrJJDVHmLn7I6VxLRmOkI+mMeUwiV0U?=
 =?us-ascii?Q?QZV9KymLhhlbxmjaptcIkWfdcy4deG69egEauGlZyK3q6XVHv3HB7sFYnRw/?=
 =?us-ascii?Q?simzi/EZmIjcT3ILTgUG4559+dPmZvPZXJna6voO3KSKNyL0ZCzzswrw7OZg?=
 =?us-ascii?Q?D9TlK3jLkTuHOZ4LxqE9a+koob/QzQ2WUS3tMYriMtuGCwzXcQ50xgGT0LcY?=
 =?us-ascii?Q?TlG58IS/og/iP+4cEOtXkItzPs30tZoFatjz8TdfimCypUM990KU2dJNK+U7?=
 =?us-ascii?Q?5QMt2K7nIZu/9fDDhvLeV4ZWzHhV/Tx9pRjQRDpD6WeFA3rUIAQmuMkyTB19?=
 =?us-ascii?Q?bcfB8tM5FjvWSMb7gSo+O3Q9um1wpZZLE5Tk0xGBR049dw3f4mIu3B3nc5nR?=
 =?us-ascii?Q?BlyuQdQjK3LC8/07a1PqMzJdGPwQMwCLEbe7qNubPPP7ES6VePPbZVCOKwDc?=
 =?us-ascii?Q?EtQZHOQfc4jgMIdGtWNQ6Pc81stkJHFrRo1NkrXiN/2gpvnpuH4FPBbbRq5x?=
 =?us-ascii?Q?6ZkeEp/KgUEcoC8Ph7VQyZL/RPbtyI1uKjHexJ6kQeuNsYsdCD13B8XESXL8?=
 =?us-ascii?Q?zi7oStREaoyOv9fhd+Y7GhPyczhEdflN3ZNlKdvE83jsdhElsDHABo99QHaq?=
 =?us-ascii?Q?DJPRCKLQWpw+g8DbCjMIr5vYhtvxN7D7rBqeEWF+/eyh5XoCGtHjzHLg5ACM?=
 =?us-ascii?Q?qC6k8Z6oVCpnR+NH83NxUZ9y19+GeUl3Nrl6p78M8VKi7jJPMg12EFDOJsp4?=
 =?us-ascii?Q?zaIDSK+H69RvOAVHtzGFqb2FejkfGNQddOiT0gKT2y1r9Xux/Ake0CdmfaxA?=
 =?us-ascii?Q?wcAHfcxKXQdakcEVeXxS0ooFKRPUoc2KL4HefzqRwsNQYGD23DMEVKUcWelm?=
 =?us-ascii?Q?oTqMtUR+OqzYxugovlE3cYSwTX8c5MEKDF4FA5hYztXqhmeY028RfkTAr82E?=
 =?us-ascii?Q?+3j/ImUkXnz9ckPa46HGaHvQdDkjBDRcalXBZjgTCg5MwEMDy3VMKEt7M4mF?=
 =?us-ascii?Q?2/5iqta+rPIe0GKerSQytFMwva8PjM2vCcvsQXWc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa02d05c-f506-4d67-8997-08dddb10f25c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 08:59:59.3185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShkMXGxFZgL0VxzDVyBaI0l+u0VlpuTHnFArMUJv29vPGqqeFaBffvkkvi8wgtFQ9D3RYsKWDKX/uFlstAumwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10905

Refer to PCIe CEM r6.0, sec 2.3 WAKE# Singal, WAKE# signal is only
asserted by the Add-in Card when all its functions are in D3Cold state
and at least one of its functions is enabled for wakeup generation. The
3.3V auxiliary power (+3.3Vaux) must be present and used for wakeup
process. Since the main power supply would be gated off to let Add-in
Card to be in D3Cold, get the vaux and keep it enabled to power up WAKE#
circuit for the entire PCIe controller lifecycle when it's present.

v3 changes:
Add a new vaux power supply used to specify the regulator powered up the
WAKE# circuit on the connector when WAKE# is supported.

v2 changes:
Update the commit message, and add reviewed-by from Frank.
https://patchwork.kernel.org/project/linux-pci/patch/20250619072438.125921-1-hongxing.zhu@nxp.com/

[PATCH v3 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Add vaux for i.MX
[PATCH v3 2/2] PCI: imx6: Enable the vaux regulator when fetch it

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |  6 ++++++
drivers/pci/controller/dwc/pci-imx6.c                            | 15 +++++++++++++++
2 files changed, 21 insertions(+)


