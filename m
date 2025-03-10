Return-Path: <linux-pci+bounces-23376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D74A5A53D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A837A33A9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CCD1DF974;
	Mon, 10 Mar 2025 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="StnPgIoS"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3311DF72F;
	Mon, 10 Mar 2025 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639566; cv=fail; b=TAe5otPRb66OkeHRpy2KK784yDk/igZmapYtcbpWgehdsERyl4wJaFAXmQssGieuZQwXHp+muSK1H/U1tjYTpgE2bcjZcH8KPOCKGPlWGcytRQVUERKUFyuPsm5695HX2zj9SvzjzizdFzVlerKPUCwYzZA5QdsWU7m2Le/6+jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639566; c=relaxed/simple;
	bh=2F5h8dJ/webiCjm5nKIUN46haFEXAebaZvsjOvMGjvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n9NKGN5K9cXa+X0OcWsvZ5dnzLRl9/9Plq3pj0C8u2MBJiE39hsXEkh7QXhcn5Pv9utPJyb4FDUEsIlHSlMt6HxBf7y0zVMLjrEslk4Mg8uTSIFt3tKv1q0SlJpxDEoMViGQrXK6mB9izaIgYLLifO6esfKFwsJvbAPKJXRg9Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=StnPgIoS; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIhvqOJQTILCbOwFdLkFswKUczy3kSrkEOiuZWP12bIRvnY8Jc5s5WU+6BXaF4T6JpYhaI4vnVHfC75/0osXTx1gImNspZKWpsW4LC2/9dtbHmWZ/4fMwg5XUW3SMVRYj/JI4AeJtbESfPAXsB0eTAHmbgfsQ/FulDz2F+V7DhtLfTwhWNH35JXfmFQTYD1CDxQaT1Yr8mpufNHBgn+qHfd8LTf1+hG61lbmRMwzX6JpkFi5lfn3afJTPD3MA8P73zX7aUSOckmnZed/IOv//Du8A9tuSLPwKarb3D54/JJ05hUdkPn330Agw1YlgfTzI6nAJACj0hCgswsLG05Pgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvJCKsZ2WVttaoszP2hCSSyOWSagBx9V5R/SjxbF57M=;
 b=K4OKmh9422YpLvV0ApHnZBsjd+GxvD84yXRKTKWDeFmTyx27b4LLZF+79Nwz8Jk24U8Q7pQJyRPUG6DSQ3fk8e2WzcJxzxICWps+17maNPYP2tWmBTmv8AR6ATk4xljg+vZxraTe1/Tn9xxmNoQMZ9LMMDN056aPl5wCFF1Sl35k0HgAt21PC3U4V6PNhe8I/s4sKJ5/LuHTXB38KNbUHI4q2AlV19VqFby7ENJxTW+Asd+MvRTx6dOD0ODDOvZv6E54ncAkwWcTmsTN/isJ7+XiUuUtL1rK4OUYN4ORK9ADIplAuBA4p2Rd/HWD/GYG6DKvfIwp+BX+eEKnupdf7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvJCKsZ2WVttaoszP2hCSSyOWSagBx9V5R/SjxbF57M=;
 b=StnPgIoS1MLHJ+nKFMV0LbpDVpesbuNrjTaeo4qlZOth9rziQ3gJ1fp5bg+3L7msM2ZaIS4U9kFq4FoPwgRlNai/ECwIa4Gkiuewdz+Qz5FZwxH03S6EH0hB3yQ9zi3UwvFSTZjICQZJh0pEYp6NnIxisYSG/g8TqRoXdPDGVt6YVS6lkmZ3gxURfs6f816J24kAciCL1lxw9QFmZJZGkNWjOF6DFGcAszZw9U/LNxB0gmhW24YQnJGYogP02+jiktHTln5rwRyb42JRwYHbYe+6OUIq88R0z96qruT16pwuXxd1CJuQIkdFyVAgUPUYiNE4INs55VtjDcx1lDVHEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV2PR04MB11189.eurprd04.prod.outlook.com (2603:10a6:150:27c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 20:45:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 20:45:58 +0000
Date: Mon, 10 Mar 2025 16:45:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@axis.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC NOT TESTED 0/2] PCI: artpec6: Try to clean up
 artpec6_pcie_cpu_addr_fixup()
Message-ID: <Z89Pf9ruO0YWWCfr@lizhi-Precision-Tower-5810>
References: <20250304-axis-v1-0-ed475ab3a3ed@nxp.com>
 <Z8huvkENIBxyPKJv@axis.com>
 <Z88Xh75G6Wabwl2O@axis.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z88Xh75G6Wabwl2O@axis.com>
X-ClientProxiedBy: SA1P222CA0033.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV2PR04MB11189:EE_
X-MS-Office365-Filtering-Correlation-Id: 78450f1c-730e-47ff-4421-08dd60148fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?izZRwRqmIOwCG/mhhlpZSinM5uJkdBjb1m8X8F+eWiqaMAE75AdembaDVI6V?=
 =?us-ascii?Q?W4WQEGM+u4A+Ui/dKV94OOWNcPv6e1gCdgOR9WzIR8Sa7rHiMi845J5snYGb?=
 =?us-ascii?Q?LlxlOnLfUZAF+WMvSafJ/ILjXQba6Tl8ETqkicWGjGpn4mNy0YKmXG6mvwbW?=
 =?us-ascii?Q?WW4LLAMG3U3B0d9yxSCf4xmQR0ISXYRWoOpfMTSXLPGztx7yFCBAphZGmndc?=
 =?us-ascii?Q?3lirIiEPnlC+9TzaMw19PgWrRi8kkTPQk9NZKq/b9CY+/kaokm4OEgz+56J1?=
 =?us-ascii?Q?k8j/YetcvP42Ea7D5Sx4SHD9sxVQLDOC2vC3Pbvu43TO0q9ragFxythGvJtF?=
 =?us-ascii?Q?jC01ETQgXxeunGJyBgCNRzfKVdoJfcsB3XTLQAlo3tPlYjqlaFlmNB27v6T8?=
 =?us-ascii?Q?57KYVkvy634noFTnOAT/KMuMaD334ulb81sCFmlCWRhMUArMvOEhRxdvh4AS?=
 =?us-ascii?Q?M+jWlgF8G0RxBnaf4bpe2Iwq4A+1tV7HBNLhwZQd+Cu/skWEshya7ljSjFQO?=
 =?us-ascii?Q?JSbI3xiqtZIqBu2lYbMrgWid4Y11T48YhJWxrsfnVyZwGzq2VBfSOBbRBbyD?=
 =?us-ascii?Q?oMTpwX7wCqcIfl1hAzzSJACJDRoknPoPIS/uQ279sQPMHuRIBo9O8OgTO6sJ?=
 =?us-ascii?Q?AsbT4KnGjhXARKDT2Xudx4c8Ve8DIcHxOth88FWyYOvKzvuFrjX0F3YEN0WE?=
 =?us-ascii?Q?sAW5i3Caown/o6xxGq9XFfvLh/bX7uBHoQsawkCNcSyxVp15qeBnHbOuox28?=
 =?us-ascii?Q?FKsPcuYFbPn6OmxRtoOHP7L5zDt34vMotzhS/wwcbXwWkrdIAL6Fo10Hb7p8?=
 =?us-ascii?Q?JJTncZ2pJt7WI/zfxUiq6U4Wx+Knzog/it/p8EYrT7/AVRq7rmxBGqnhzrXl?=
 =?us-ascii?Q?DPfzfH9+8/xnecowRtNFCId1EWCae9KKcOHDc5MSdKVwmqfpvf7OCGoyiRuf?=
 =?us-ascii?Q?XLcWK1EgMyjNWZv02gjHSD3tULOjPFoT3Fii7c6T89j3ySpUiAw54KhkDZXa?=
 =?us-ascii?Q?565DOIDaQagTyLImKcnknEf7nW4hMgaCeNYhEFwGGliLVyKPy+wG0q9H/c0w?=
 =?us-ascii?Q?vhVDgCO8eHmuKTkOli+x/UlUQFgao8/ib/jKq9tB6amUaA9usxtUyGhmoPcF?=
 =?us-ascii?Q?lajERZ2xVwMS8dSrX3rqcI8TIBZ+M1QCGVa99Pf7U6aV1XfRgABhxj+Ylk9C?=
 =?us-ascii?Q?VLYraKaaJkt09Oc3CXrRbmTyERFUkJgmH2+MkOO5fE5l4GGcLqTf7O6XQAtg?=
 =?us-ascii?Q?4zckJLzPVBD0mcvvmovCnQzarWsfcFZQvLcsZZio/CMU8tDShkVzZ6SJmPCK?=
 =?us-ascii?Q?8O0YSV6HEKO6g675DzXuyvkwOZP2AbtMKeCJ7CVZWMUAHCMGlrI+sVDx8Bkh?=
 =?us-ascii?Q?MS2X7F1X7dhmpcbW0Aw3SqqfuRCFGT/VF0Y89cQpgwK6QmSnMWwxTZyt15tz?=
 =?us-ascii?Q?KZECfg1Tm1Ao086qgIoUcwPpKEc2jF2u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iif3G4o9ukA4MATAOD1242VTqgJvqyUZ1nIrANI8Sb0bmNyGcG1jBBVk9JbU?=
 =?us-ascii?Q?yeRZxnnXnEDwGlJAAqgIM8tc7rocAdx9RGrYQ5RReBku4U82w8d2TcI/0k79?=
 =?us-ascii?Q?nnQ7PFcIMK70ozyFQ9T1TIR3JAlW6v8jTjIMqIph+pZuuqqpxhD4gIXJW4WE?=
 =?us-ascii?Q?TINz3anUSPqb7z+OkMIefv7pE49hkZQuC6Q8r8CbuQYlnl38kdQ7ALkGt35H?=
 =?us-ascii?Q?52l7/EpqUu8ORz2Y7mA0uTwVgslEG8hPN8y/cmucGp03ZeqlRMdYnFgyc7aC?=
 =?us-ascii?Q?oZetRqbYvfzie9ZkShNMqH3NwnBKG+I1V98VwswOoXDDabO0jUK6kuilbkyF?=
 =?us-ascii?Q?+m4hemXaS6muw6H6ztxKKycWphx1hb/Lb+tzCSFMo/BXfl79UIkiIAT8xyGU?=
 =?us-ascii?Q?M7vUEBEbr36Y9FbasXsHyCyWOLnmbc1c0oERkj9aJX6dx6iBmRzM6aEF8HZf?=
 =?us-ascii?Q?QR5Ltfd78RXIdzjxQmIuBenHyBNCDs/ONNiYaXfCp/jeLTpXSlfnDXgfM5nV?=
 =?us-ascii?Q?cq9FcH/BTP0EZqSm7V7Ruq2SwBF9h/1/QsLpbN2jpoS5dZW6+bvyzBOl+mG7?=
 =?us-ascii?Q?3KMw//g3JRAgBvUZCyHJjvIUzSccizlKmYT62KOlnbPqBqPc1nqmGPNfUEcv?=
 =?us-ascii?Q?dm6wakrg8nT2awhYS3kOOm5DYQIBM6E85/GNgxDeKh2k2eeVoC5DkpxR1d7o?=
 =?us-ascii?Q?SP7P5tPCWc/GQ3AR9DBVfk6RwNepAp/jTJqpWN+Xw4ZO6oOyqFSiuPhdxuZ0?=
 =?us-ascii?Q?7NAKxrxMWTDksTdtsRk4CJJIC2WTfp71Kmb/uMLb/G2wSUw6J1+cldJGWx2L?=
 =?us-ascii?Q?t1lcJSFj2hCgUBJ+ZPN2KCGhaJOyKltpRxWppb/6u62r60lCBTfRd6WK/85y?=
 =?us-ascii?Q?hmybYg9MEM0QbUmTYR5EutSCp0EUobssOCo4juHaSe8FM9zKA9YqvNimbwEc?=
 =?us-ascii?Q?4hM4hR9LOv3aMSpcSK9Zmgo8q20xuKjF8hFrqIqU8wDNP8daSh5ALxPH4HVe?=
 =?us-ascii?Q?kud8ZyL3MyQfmjdhyn4Vy0k/FuhgoWnBCyjQiVyn0NoDwlZMfbQn0FKjZy+S?=
 =?us-ascii?Q?/LFNIWaD+OM0lAC5ILgdGO5XXZgvXXQaz1nRb4TZyvAFqcd4l3EaUDXxgp/u?=
 =?us-ascii?Q?LYq+COBkfK///VUbUFaZnBMD6RoyLP38b81FCEUvtxAtrnFPKum863x/ZjFJ?=
 =?us-ascii?Q?NQoi83kVjFBecpZwKKD2/x+451kDkfaXg/UrQYaXc3YzzOJR5S1f5DJjcrDS?=
 =?us-ascii?Q?N3XBA/1gA36QynPNzAqyNld1n1aekRSyl68OgELIzHIEHuDABvC6Ny1OltU1?=
 =?us-ascii?Q?UiA34EBB2URbxEhfpIvk7ISFROu+XCXaT1tYDOwUElRqkOkmEo3JGjEENKdE?=
 =?us-ascii?Q?dpy6LTk05jYI1jsp6D07d9eIxC0AEzVx4FdgYagRx67IYMd/TzKuWy2HVfL+?=
 =?us-ascii?Q?/W5Lgey9GD3fy9HJtLm5SS5iES9u6IEqEX3ZQvTN0ZAx3SlFGL1HUIb9nHhH?=
 =?us-ascii?Q?JfnsgOJm/Y49pDKTSEUmNmilQCh7EJvkTMdJ1bOtzh/bruKiJ/pjYstycdbl?=
 =?us-ascii?Q?JnKEvvDa3V9IH+yUfvfmN9MziyOtyBhkpsQUfFMY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78450f1c-730e-47ff-4421-08dd60148fec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:45:58.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JWeLQynPM50vGQFpqGUtXBRpMw8OQSjDpvGEFUBI8A30F2hhXjt8IBA8o3KT6M2JR2dGRLATSmczK7X2bprxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11189

On Mon, Mar 10, 2025 at 05:47:03PM +0100, Jesper Nilsson wrote:
> Hi again Frank!
>
> I've now tested this patch-set together with your v9 on-top of the
> next-branch of the pci tree, and seems to be working good on my
> ARTPEC-6 set as RC:
>
> # lspci
> 00:00.0 PCI bridge: Renesas Technology Corp. Device 0024
> 01:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> 02:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> 02:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
> 03:00.0 Non-Volatile memory controller: Phison Electronics Corporation E18 PCIe4 NVMe Controller (rev 01)
>

Thank you very much!

Frank

> However, when running as EP, I found that the DT setup for pcie_ep
> wasn't correct:
>
> diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
> index 399e87f72865..6d52f60d402d 100644
> --- a/arch/arm/boot/dts/axis/artpec6.dtsi
> +++ b/arch/arm/boot/dts/axis/artpec6.dtsi
> @@ -195,8 +195,8 @@ pcie: pcie@f8050000 {
>
>                 pcie_ep: pcie_ep@f8050000 {
>                         compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
> -                       reg = <0xf8050000 0x2000
> -                              0xf8051000 0x2000
> +                       reg = <0xf8050000 0x1000
> +                              0xf8051000 0x1000
>                                0xf8040000 0x1000
>                                0x00000000 0x20000000>;
>                         reg-names = "dbi", "dbi2", "phy", "addr_space";
>
> Even with this fix, I get a panic in dw_pcie_read_dbi() in EP-setup,
> both with and without:
>
> "PCI: artpec6: Use use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()"
>
> so it looks like the ARTPEC-6 EP functionality wasn't completely tested
> with this config.
>
> The ARTPEC-7 variant does work as EP with our local config, I'll try
> to see what I can do to correct ARTPEC-6 using the setup for ARTPEC-7,
> and test your patchset on the ARTPEC-7.
>
> Best regards,
>
> /Jesper
>
>
> On Wed, Mar 05, 2025 at 04:33:18PM +0100, Jesper Nilsson wrote:
> > Hi Frank,
> >
> > I'm the current maintainer of this driver. As Niklas Cassel wrote in
> > another email, artpec-7 was supposed to be upstreamed, as it is in most
> > parts identical to the artpec-6, but reality got in the way. I don't
> > think there is very much left to support it at the same level as artpec-6,
> > but give me some time to see if the best thing is to drop the artpec-7
> > support as Niklas suggested.
> >
> > Unfortunately, I'm travelling right now and don't have access to any
> > of my boards. I'll perform some testing next week when I'm back and
> > help to clean this up.
> >
> > Best regards,
> >
> > /Jesper
> >
> >
> > On Tue, Mar 04, 2025 at 12:49:34PM -0500, Frank Li wrote:
> > > This patches basic on
> > > https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/
> > >
> > > I have not hardware to test and there are not axis,artpec7-pcie in kernel
> > > tree.
> > >
> > > Look for driver owner, who help test this and start move forward to remove
> > > cpu_addr_fixup() work.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Frank Li (2):
> > >       ARM: dts: artpec6: Move PCIe nodes under bus@c0000000
> > >       PCI: artpec6: Use use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()
> > >
> > >  arch/arm/boot/dts/axis/artpec6.dtsi       | 92 +++++++++++++++++--------------
> > >  drivers/pci/controller/dwc/pcie-artpec6.c | 20 +------
> > >  2 files changed, 52 insertions(+), 60 deletions(-)
> > > ---
> > > base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
> > > change-id: 20250304-axis-6d12970976b4
> > >
> > > Best regards,
> > > ---
> > > Frank Li <Frank.Li@nxp.com>
> >
> > /^JN - Jesper Nilsson
> > --
> >                Jesper Nilsson -- jesper.nilsson@axis.com
>
> /^JN - Jesper Nilsson
> --
>                Jesper Nilsson -- jesper.nilsson@axis.com

