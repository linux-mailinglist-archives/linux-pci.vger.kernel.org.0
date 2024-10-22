Return-Path: <linux-pci+bounces-15024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052AA9AB3BE
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 18:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891B91F22266
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0D51BB6BC;
	Tue, 22 Oct 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PC2l2SRc"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286151A264C;
	Tue, 22 Oct 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614032; cv=fail; b=LBuMJdT2cJ1gGkvisCNK9gSIHgg72qcrx08q7yhR98A4MzaJbsNRzT+LYrtwbwtcALma3pSGuJDGVeHot/LEt6yuKo959zjGrV8KbxTrhylA/mdVSoD5TcekFbyzTHGDRAm2JijAP4TrgMebCW8S6E/77XEUv9CrGFR9fVSYWlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614032; c=relaxed/simple;
	bh=JV6o7H8WE2r7yNIxucUIwGiB8JnkdQUFm84CuSc2bSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q9zMv+iFzqzf2UZPW2nyrQTkfmE55z1yXAq+qXJX24VZgSaLLVp6oVTjdkqocwBBQsluMTtjtqBfPW2vCMlC9Id0l2kVV1daAs93QbpU70jeUN63BUX/TgzJBytmiNhWX5STKcYG+3BiBBOfIeSWtcVBj53c52qUQR/fh/wqbQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PC2l2SRc; arc=fail smtp.client-ip=40.107.247.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVMq1COb+2suVYoF67OBzTSHxEYLe/FT7l1pBwUP/bmJp8ZuSbhoO7TENVfoMrnUuTGKzYoFU+hX4V9uDn/nilo4NdOzCN56V/HchjKqnybPOtMmCLEsru+b+paYo1cSetaMHBx/g4o3pD6CgYqL4Qq6oDqNHDbPduThpkXF4tniXChV15BxVmcs6lQHPvQvxSOnKJmgodk63XOmlgzMYvCA5PW2GR6soalGDgh8jIXtS4WuK/3bmACilGYyk6o3VU7UpglrBdXI0/IPhtSx5t1J3l6dLKC3SfCuICcEqMX/79TB4C4Q61ixwvkWXobYo2Eb+N34KgDypGDkr2WRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n84pwxWRBGbFNxsIaSL9GbpSrgOkqyKUbacooveV5f4=;
 b=hKZdsKvogI4bJf3qTlh8he2figeSQTxcy0oKH/C3h99I3Pw60AKaSceBP7f3gHrWDQoIhRO2UPH8Cl6O1NjEipkAPelfycUSJoSxiddUOKEBRHrY6j8wZSsKR9gr6OAcE0ExAhAe8/DucQvkqvhSAi6gMCXFyOwwIdyYEo0LgGCs1V4S+MheEsBLd0Gya8ESqnPsywts1Dg5hFz8NH+Adr0oBZevyNXMP1jtpKMAu4VYgyv4yffA++RdnWKa3KL3b1pMg8F0Trk2HrZEOtCAgGfzAAX8WCskMqTlWhizfiiqrvBzlN/f614xg0vQeis+GEuxC1lWguI/kH6Uhw9mpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n84pwxWRBGbFNxsIaSL9GbpSrgOkqyKUbacooveV5f4=;
 b=PC2l2SRciJPkxVT3CPPnXUtpj/sc7h4q+fx+XyD4kkvlzG1PEObrHAwKsA1N/rwAeDGdURXKn1hdLzBiHMhRk0KIvxLBFucL3iDJbsUrHX7Xzjw9tkJiFefi15D0Se5HzP3lQ/jmjyeqTY6dIPb8M5MhWJrbPBWf3ZCoAaxj4z+RiH5ktFJyV6H3y7YSOie6B8NU1CKxJRi1SceJCTZHcdIjMYCx86S+CN1vJsAoccXriUSkhnGpAJvlHqGd3m4A4JqzfOH/BOGNLji5MhFzue6lrITAbKXcnFV7wPEcATDU+ImrjfyohzOQF57n1Oba/oZcXxE5Kl94r20bgdd04A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7468.eurprd04.prod.outlook.com (2603:10a6:102:8d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 16:20:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 16:20:26 +0000
Date: Tue, 22 Oct 2024 12:20:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v4 net-next 06/13] net: enetc: build enetc_pf_common.c as
 a separate module
Message-ID: <ZxfQwCcGoyvNB9C3@lizhi-Precision-Tower-5810>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022055223.382277-7-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c0bbb9-577e-4007-4c35-08dcf2b57012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k0aWiLWZx8G/+yEIf7V4kP1USCZCTFirGTS97NGnCXA3YQpJPu8jogYoYho9?=
 =?us-ascii?Q?jXXBLGTRgB0x1WQwxAW0NIybm5L9Qr1XJyss8GmyzkQhF/b2N2Vgpv0m6Z10?=
 =?us-ascii?Q?XtKhtOICGkt3cgwpw/1WHsnXaUm5CFjQCB8l9uM7EfOkCMlsDKXXxlRKNtHX?=
 =?us-ascii?Q?GlIEEDUxcXNC9zEBSDL2cZTEHgU3rpTQVf13KZtIb0WuZR/7IGVHOY4vSnPB?=
 =?us-ascii?Q?mOo6ozpSl2cjRoHojqAiY3GKLVGFUQcxh1zTDhm0T5XXC3oSAho3fuPuMxfI?=
 =?us-ascii?Q?ryAwlQI+hGq8V8V5GPRVq/Ls2GLKfOtWsR7u1wk2LwJkwFZgjDfCrO3wxxXj?=
 =?us-ascii?Q?3T4+znlUgLKmJNcv8yGO5IaVfsvdUzzasLyPxHGWSnREJfUrjhhioYxR+3GW?=
 =?us-ascii?Q?0w2BW/tkSk4Z9YSjMjDrUUBJRD4lPenWlxh74V/txWKAlbmA7nprB3tSHoMI?=
 =?us-ascii?Q?Y9o7elXzgz9x2coMbMZSRZnw/602e/A4WQnvNU7RqbL6y72eTYx1O+m9h9YT?=
 =?us-ascii?Q?FA5omkgXxHDtfsQ9EGaxYBbk8CUqPJLzPhdLLRxldyqTmhoLZLrI/1DK6c9A?=
 =?us-ascii?Q?QUdpA+n7Q3U9QxL5l0HWZONzp2oAp5lHVI9vHXPDcfICCa8zhBX9I1ZUQ7sM?=
 =?us-ascii?Q?PFtrldq8MvpYNNI0Ai/MNlrouA7rQC3jrE6a/UaoYoBsO7me3hMp2Z9VY0hM?=
 =?us-ascii?Q?9W3Qt2c4mKSt5wPoIk7FODxvEY7ob5UIFigQYDHa4L/i97a8DBxc/CN+cWR/?=
 =?us-ascii?Q?OZRQNRfTJfGFf/oB459b8UYlxkRMa1HaqMk6bOzmTsGBQCBwLkyC4HxHxy1Y?=
 =?us-ascii?Q?mOqX9U9Iq6TprEfV6ywLOK2xTsiBCYudirOWPFHSLU33txJQAZJZIRj+2JK9?=
 =?us-ascii?Q?FfTBwaNBqcLYo0mchHK0cicdILcuvjMtFok7mokPnCnyaE5+bHnHSlDzX04p?=
 =?us-ascii?Q?R9YDm61XC7jMmZkzF+bKM5jp6/WwtVFkfES/lHbUNxtIeL88BYZyFfFE9vEU?=
 =?us-ascii?Q?LDNZWlkoOK+AAFNEAJLdX0I2cDWW1l8KzXqy9swRdDSOwfK0RLXdpqhGuRb1?=
 =?us-ascii?Q?4MRJX/BQB/DJs2cJY3hRAiPN9HSOuF7HsfGVgMcMzo3aD6kbm+0lfEkRXNpI?=
 =?us-ascii?Q?KAWS1flyNZ2zpGA6pBTxAYS36RFjs2Zw2Z7PgOKFDv5L7x2RIwPXZ5zJ7pZL?=
 =?us-ascii?Q?MpzrKHxXuyGw8RJf2TJQQAeD0sUu1NIcxNqfO+Zoo4QdUbtqXWkzgzOoioOD?=
 =?us-ascii?Q?I+CpxRrfY0v2NQM/rdMT603wa0waUzRKvSnRZbMQpxVX5q5frZUXJRYMMS1P?=
 =?us-ascii?Q?lPCV8idF6qVopxSN9VpFgN3PlkcUZQ90bsOWXeiDW9mmFtjC5LsLeZASABEy?=
 =?us-ascii?Q?pll/mTU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ee30tbogHP9doUvVUdxrkbo5IBaQIAEBD3OIvYhWnhxbCN/toE6VTiBodNQ?=
 =?us-ascii?Q?9DoONJ/j4zMLGjp8e6ddVNx4IuEQLeClhbkDsiY2/nZtXwoxnVA0tKkwaDFt?=
 =?us-ascii?Q?UwJPz58Cau3Uhz2GVB2MZxp/JpwPy3klh16KNTskBN4cv320iceQ6GVdkZ6c?=
 =?us-ascii?Q?itE858EepUOQ8RUJBhIls4vrFsLGNB/ZBnS0acsj/BF+yawymKopCKzRClKR?=
 =?us-ascii?Q?X+dyp9k2VvWVu25DdPctB8rqQtjtwip7W0ZEy1nSOblLgS5guRzdjoVddzYZ?=
 =?us-ascii?Q?LWdo1asmM7WU4/vr1i4W9TmgGpKWq5ARzw0qvTDGcSZKlZC04OeoEifeeTkD?=
 =?us-ascii?Q?NztHB6VpEmt0IXWP9k8INOhPD9rr877uUzwuw6/9S4Hn9Q+vlJWjOWsyNxPP?=
 =?us-ascii?Q?Lb9c1C0BOrQzRlCAUCbngF/myHVZRoE2Z+CD5PBDoTCSN00YSAZWmoKpKV7y?=
 =?us-ascii?Q?wsMKOI9Mjx1YahFw5OIP5pnRJQxr26BF/TE62ix6fqSgSa3oObx+21Qtq/ex?=
 =?us-ascii?Q?BNrulDXGol/2QkS3y9FYOLVJm0Qd1t2P6XfDFwmPkra0GOGjUB2T15D5yvBE?=
 =?us-ascii?Q?4YzkxxH9iH0MFgxc4Nu+S1lfhAYj7yL4FDKMtbbkm55Snb//fMx6+rok4JmH?=
 =?us-ascii?Q?EC7S4GpeJrz4WQ+nBLB2w6I1ph+zOqvJVfoBdCR7oRvJV9Qs4BiiUUIXWMuu?=
 =?us-ascii?Q?puoCC0J2GxhteqnVTpYU2wWcwhkncErNc+PfirVUh6K9T0MBOojQlOuVebQ/?=
 =?us-ascii?Q?g2YlFshk3CPa1GgHkXFmVtX4Ug1RHBn9C/Ya6LseN0KGcaBlvZNsWxlkZy52?=
 =?us-ascii?Q?kjlNBPvD5kuhuMn7+yFLZ+WZHKTpjApvcIxiK7O730Xw/00DPHd73bVkzEmP?=
 =?us-ascii?Q?cGDz5ZVJ9VL9F6U0TbFJx0dqghvtnNs1m53JX/iIx4Cn1FA1jkOK29fAGxov?=
 =?us-ascii?Q?fwjn2qKBYt+w3+PVBW0Vx11F/NJZN+Hc5jA/ZWSDOryC5f5G8DEWAlaz5BXv?=
 =?us-ascii?Q?jQKJdAnqYaka11PDZnC3nFppEALpVPghcceG3Xh7qi8+3JI/WK0Vv20HEK+P?=
 =?us-ascii?Q?+va4IIgwXHYHPqylJgXFw7HOX+qhWnxp3CGxlPdMIVM6oPBmDZlB5N0wgIAw?=
 =?us-ascii?Q?JUZAp0vLxIMkjxoC/6IrMCi84qa3LYUjtcLV+n1l8efeO5UlRpE+ryKaKCu4?=
 =?us-ascii?Q?f+RZ8xSxJeUC2/d/DGMxP0t/LKJwK3eph8rvF7sXXo/ItDVIHWpCvqmtiNSq?=
 =?us-ascii?Q?oblA/4yHP/DK5kUJYr++UfrgZ1NxEpbMeNrc4goTMvs9j6ybOtH2khmB7xxs?=
 =?us-ascii?Q?kAc1+kJAx3D916d3xqppsfeoxrjBi2xgILh7KAHgfjSE9M95OnR5KKlKDLWT?=
 =?us-ascii?Q?KPt7/CMJgj8W//nSfJ0wd5icvKEQ9VeZsHowHoO4l890ui8W7sFvC/Zc2LSg?=
 =?us-ascii?Q?MvMs4HuZwnNzJfZcmCCCe/TqDRxGAfzOcs6vj4Q/fK1qogGqq6Q4ZEW0EQwo?=
 =?us-ascii?Q?WwSXFerAjPdwbQJpCCVRnlHOISzn0hNvh7C4qD9+XDmt4wsVPea2/ZOpgDvi?=
 =?us-ascii?Q?hqrhHLHyzvXymF0csVqQMNaPylFxxlxw4xg757VT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c0bbb9-577e-4007-4c35-08dcf2b57012
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 16:20:26.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGubR1YRnPeIHJFExQZgHj8DBoX2GN7CQZQRsS0FIGxPbsns/zgBd69xeQgK52SEqvEN71LnJepsZUVfg1tqtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7468

On Tue, Oct 22, 2024 at 01:52:16PM +0800, Wei Fang wrote:
> Compile enetc_pf_common.c as a standalone module to allow shared usage
> between ENETC v1 and v4 PF drivers. Add struct enetc_pf_ops to register
> different hardware operation interfaces for both ENETC v1 and v4 PF
> drivers.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v2 changes:
> This patch is separated from v1 patch 5 ("net: enetc: add enetc-pf-common
> driver support"), only the changes to compile enetc_pf_common.c into a
> separated driver are kept.
> v3 changes:
> Refactor the commit message.
> v4 changes: Remove the input prompt of CONFIG_NXP_ENETC_PF_COMMON.
> ---
>  drivers/net/ethernet/freescale/enetc/Kconfig  |  9 ++++
>  drivers/net/ethernet/freescale/enetc/Makefile |  5 +-
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 26 ++++++++--
>  .../net/ethernet/freescale/enetc/enetc_pf.h   | 21 ++++++--
>  .../freescale/enetc/enetc_pf_common.c         | 50 ++++++++++++++++---
>  5 files changed, 96 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
> index 51d80ea959d4..e1b151a98b41 100644
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -7,6 +7,14 @@ config FSL_ENETC_CORE
>
>  	  If compiled as module (M), the module name is fsl-enetc-core.
>
> +config NXP_ENETC_PF_COMMON
> +	tristate
> +	help
> +	  This module supports common functionality between drivers of
> +	  different versions of NXP ENETC PF controllers.
> +
> +	  If compiled as module (M), the module name is nxp-enetc-pf-common.
> +
>  config FSL_ENETC
>  	tristate "ENETC PF driver"
>  	depends on PCI_MSI
> @@ -14,6 +22,7 @@ config FSL_ENETC
>  	select FSL_ENETC_CORE
>  	select FSL_ENETC_IERB
>  	select FSL_ENETC_MDIO
> +	select NXP_ENETC_PF_COMMON
>  	select PHYLINK
>  	select PCS_LYNX
>  	select DIMLIB
> diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
> index 8f4d8e9c37a0..ebe232673ed4 100644
> --- a/drivers/net/ethernet/freescale/enetc/Makefile
> +++ b/drivers/net/ethernet/freescale/enetc/Makefile
> @@ -3,8 +3,11 @@
>  obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
>  fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
>
> +obj-$(CONFIG_NXP_ENETC_PF_COMMON) += nxp-enetc-pf-common.o
> +nxp-enetc-pf-common-y := enetc_pf_common.o
> +
>  obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
> -fsl-enetc-y := enetc_pf.o enetc_pf_common.o
> +fsl-enetc-y := enetc_pf.o
>  fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
>  fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index 3cdd149056f9..7522316ddfea 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -11,7 +11,7 @@
>
>  #define ENETC_DRV_NAME_STR "ENETC PF driver"
>
> -void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
> +static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
>  {
>  	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
>  	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
> @@ -20,8 +20,8 @@ void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
>  	put_unaligned_le16(lower, addr + 4);
>  }
>
> -void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> -				   const u8 *addr)
> +static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> +					  const u8 *addr)
>  {
>  	u32 upper = get_unaligned_le32(addr);
>  	u16 lower = get_unaligned_le16(addr + 4);
> @@ -30,6 +30,17 @@ void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
>  	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
>  }
>
> +static struct phylink_pcs *enetc_pf_create_pcs(struct enetc_pf *pf,
> +					       struct mii_bus *bus)
> +{
> +	return lynx_pcs_create_mdiodev(bus, 0);
> +}
> +
> +static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
> +{
> +	lynx_pcs_destroy(pcs);
> +}
> +
>  static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
>  {
>  	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
> @@ -970,6 +981,14 @@ static void enetc_psi_destroy(struct pci_dev *pdev)
>  	enetc_pci_remove(pdev);
>  }
>
> +static const struct enetc_pf_ops enetc_pf_ops = {
> +	.set_si_primary_mac = enetc_pf_set_primary_mac_addr,
> +	.get_si_primary_mac = enetc_pf_get_primary_mac_addr,
> +	.create_pcs = enetc_pf_create_pcs,
> +	.destroy_pcs = enetc_pf_destroy_pcs,
> +	.enable_psfp = enetc_psfp_enable,
> +};
> +
>  static int enetc_pf_probe(struct pci_dev *pdev,
>  			  const struct pci_device_id *ent)
>  {
> @@ -997,6 +1016,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
>  	pf = enetc_si_priv(si);
>  	pf->si = si;
>  	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
> +	enetc_pf_ops_register(pf, &enetc_pf_ops);
>
>  	err = enetc_setup_mac_addresses(node, pf);
>  	if (err)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> index 92a26b09cf57..39db9d5c2e50 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> @@ -28,6 +28,16 @@ struct enetc_vf_state {
>  	enum enetc_vf_flags flags;
>  };
>
> +struct enetc_pf;
> +
> +struct enetc_pf_ops {
> +	void (*set_si_primary_mac)(struct enetc_hw *hw, int si, const u8 *addr);
> +	void (*get_si_primary_mac)(struct enetc_hw *hw, int si, u8 *addr);
> +	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
> +	void (*destroy_pcs)(struct phylink_pcs *pcs);
> +	int (*enable_psfp)(struct enetc_ndev_priv *priv);
> +};
> +
>  struct enetc_pf {
>  	struct enetc_si *si;
>  	int num_vfs; /* number of active VFs, after sriov_init */
> @@ -50,6 +60,8 @@ struct enetc_pf {
>
>  	phy_interface_t if_mode;
>  	struct phylink_config phylink_config;
> +
> +	const struct enetc_pf_ops *ops;
>  };
>
>  #define phylink_to_enetc_pf(config) \
> @@ -59,9 +71,6 @@ int enetc_msg_psi_init(struct enetc_pf *pf);
>  void enetc_msg_psi_free(struct enetc_pf *pf);
>  void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
>
> -void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
> -void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> -				   const u8 *addr);
>  int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
>  int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
>  void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
> @@ -71,3 +80,9 @@ void enetc_mdiobus_destroy(struct enetc_pf *pf);
>  int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
>  			 const struct phylink_mac_ops *ops);
>  void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
> +
> +static inline void enetc_pf_ops_register(struct enetc_pf *pf,
> +					 const struct enetc_pf_ops *ops)
> +{
> +	pf->ops = ops;
> +}
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index bce81a4f6f88..94690ed92e3f 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -8,19 +8,37 @@
>
>  #include "enetc_pf.h"
>
> +static int enetc_set_si_hw_addr(struct enetc_pf *pf, int si, u8 *mac_addr)
> +{
> +	struct enetc_hw *hw = &pf->si->hw;
> +
> +	if (pf->ops->set_si_primary_mac)
> +		pf->ops->set_si_primary_mac(hw, si, mac_addr);
> +	else
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
>  int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_pf *pf = enetc_si_priv(priv->si);
>  	struct sockaddr *saddr = addr;
> +	int err;
>
>  	if (!is_valid_ether_addr(saddr->sa_data))
>  		return -EADDRNOTAVAIL;
>
> +	err = enetc_set_si_hw_addr(pf, 0, saddr->sa_data);
> +	if (err)
> +		return err;
> +
>  	eth_hw_addr_set(ndev, saddr->sa_data);
> -	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(enetc_pf_set_mac_addr);
>
>  static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
>  				   int si)
> @@ -38,8 +56,8 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
>  	}
>
>  	/* (2) bootloader supplied MAC address */
> -	if (is_zero_ether_addr(mac_addr))
> -		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
> +	if (is_zero_ether_addr(mac_addr) && pf->ops->get_si_primary_mac)
> +		pf->ops->get_si_primary_mac(hw, si, mac_addr);
>
>  	/* (3) choose a random one */
>  	if (is_zero_ether_addr(mac_addr)) {
> @@ -48,7 +66,9 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
>  			 si, mac_addr);
>  	}
>
> -	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
> +	err = enetc_set_si_hw_addr(pf, si, mac_addr);
> +	if (err)
> +		return err;
>
>  	return 0;
>  }
> @@ -70,11 +90,13 @@ int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
>
>  void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  			   const struct net_device_ops *ndev_ops)
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_pf *pf = enetc_si_priv(si);
>
>  	SET_NETDEV_DEV(ndev, &si->pdev->dev);
>  	priv->ndev = ndev;
> @@ -107,7 +129,8 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
>  			     NETDEV_XDP_ACT_NDO_XMIT_SG;
>
> -	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
> +	if (si->hw_features & ENETC_SI_F_PSFP && pf->ops->enable_psfp &&
> +	    !pf->ops->enable_psfp(priv)) {
>  		priv->active_offloads |= ENETC_F_QCI;
>  		ndev->features |= NETIF_F_HW_TC;
>  		ndev->hw_features |= NETIF_F_HW_TC;
> @@ -116,6 +139,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	/* pick up primary MAC address from SI */
>  	enetc_load_primary_mac_addr(&si->hw, ndev);
>  }
> +EXPORT_SYMBOL_GPL(enetc_pf_netdev_setup);
>
>  static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
>  {
> @@ -162,6 +186,9 @@ static int enetc_imdio_create(struct enetc_pf *pf)
>  	struct mii_bus *bus;
>  	int err;
>
> +	if (!pf->ops->create_pcs)
> +		return -EOPNOTSUPP;
> +
>  	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
>  	if (!bus)
>  		return -ENOMEM;
> @@ -184,7 +211,7 @@ static int enetc_imdio_create(struct enetc_pf *pf)
>  		goto free_mdio_bus;
>  	}
>
> -	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
> +	phylink_pcs = pf->ops->create_pcs(pf, bus);
>  	if (IS_ERR(phylink_pcs)) {
>  		err = PTR_ERR(phylink_pcs);
>  		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
> @@ -205,8 +232,8 @@ static int enetc_imdio_create(struct enetc_pf *pf)
>
>  static void enetc_imdio_remove(struct enetc_pf *pf)
>  {
> -	if (pf->pcs)
> -		lynx_pcs_destroy(pf->pcs);
> +	if (pf->pcs && pf->ops->destroy_pcs)
> +		pf->ops->destroy_pcs(pf->pcs);
>
>  	if (pf->imdio) {
>  		mdiobus_unregister(pf->imdio);
> @@ -246,12 +273,14 @@ int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(enetc_mdiobus_create);
>
>  void enetc_mdiobus_destroy(struct enetc_pf *pf)
>  {
>  	enetc_mdio_remove(pf);
>  	enetc_imdio_remove(pf);
>  }
> +EXPORT_SYMBOL_GPL(enetc_mdiobus_destroy);
>
>  int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
>  			 const struct phylink_mac_ops *ops)
> @@ -288,8 +317,13 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(enetc_phylink_create);
>
>  void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
>  {
>  	phylink_destroy(priv->phylink);
>  }
> +EXPORT_SYMBOL_GPL(enetc_phylink_destroy);
> +
> +MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> --
> 2.34.1
>

