Return-Path: <linux-pci+bounces-23338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47230A59BA1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 17:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9666F7A959B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732823716F;
	Mon, 10 Mar 2025 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="EOgTBbIq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DA7236A8B;
	Mon, 10 Mar 2025 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625232; cv=fail; b=YaDlAe8uRcuqTFzAJtLVmZTcOMhm03clnbhN81+p5b0wh3oaz/rYJMz/5d5ZhchWNZ2JdtDFGKK5T85v6fxA/j0vI019q3jqZfy85X9UNFS0+pGzE2PXGxciOgM/1aM0R96Adqqaw1l5cGwddG3vcM4cdNOiTHqaersK+vaoKHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625232; c=relaxed/simple;
	bh=mwiZFmL6V4JRPc5pqnLiZeK9PuWY90iXOdGLS9ygAsA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3uD/H2gTBWDbUTbf75MsoAkVoc/vlHVcgp75dvLJZ91fyYSUxPXHMVKv9baRw1IhiY8n30D8Zz1i3vk/ku38OR+5HCBdtGGTjNSSoHYYtk0ikRIfPlYdzQUpQ8Y4Zd7Hygd//orYzEB26dqao5d+ZExDECbE/5RyS997aJpvIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=EOgTBbIq; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7g0goVgnscLaAHIzH99YHpi5dnx9umb70BLJBr8KqNAEREU/xWvwS42yECYnnl0ru5lXbK37BO+wsCyHu1bW+ljZmxQ3iy2cF3bm9aoQyjBI8QgcPJzMEMGPij9qrsRMmzIm5h+w+FpcnFZY5034oz8xBGJVOt3ad++i/k897LH/isqlQfZOg7pFzFX7jfX1h0vpwlJAm/1k/l/ltnLUHkfnoi+qmYXCkaf7JXbbPpeqhars8PWeil4umklGIn3zsxW7z/K6pBEQHsiDNf6/7QRaW5efR7gyPFIzINChflZftCMREp7aygYXjIaG2uZijLJO2pXetzq8kdqmzyFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9vwysSSt95/k6ws1LPhRFVcz6Wihxz7ng+f8pIUX+8=;
 b=ubOuYLHkGEPr0MJ5JZGeGW3614ir7AcVfLrDxWbY7+udYAaPSw9P9gCmoZPoNqydZHKAb7RExYsvvVThKHwJArYQzWx1arLJ1qkcA/iZIoNUq3cHM9Yh3yisj8NTXJLSbzs5uLk3u8Fzd7/BlIgZCIQ4wtt5HNzoNyuM3E19nvlfaen/WQe8AdW4byOGq0mSQ8qIBDbGcYSNgUi7l0/nWVuE7uKWSVeCkl9D7eoU+L/gdwK+Brgb2USUhg0domCxKWYRJEqzn6AuVkVh1NsgeGJR0+gI4IA9Xhq/fnV+iMalNiv6rr6AJaA4A/40sy9LPVvtg2F5X4LxrXiE4TAA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=google.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9vwysSSt95/k6ws1LPhRFVcz6Wihxz7ng+f8pIUX+8=;
 b=EOgTBbIq2D8ptnQ8IIQo69axYShlhSzclW/iPaqOrBaTgJko3CmGzGz9n9+0BFq0/tT47YYrsW6ORddq/LQrQhkprAh2n7bQPhahvUyRPjgyu8JMXXs/dJvtiyKCkSftalOutA/vwj6KB7YgV+2HlsW7wyYrrnj9LU2K6RONWHE=
Received: from DB7PR02CA0028.eurprd02.prod.outlook.com (2603:10a6:10:52::41)
 by GV1PR02MB8564.eurprd02.prod.outlook.com (2603:10a6:150:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:47:05 +0000
Received: from DB3PEPF00008859.eurprd02.prod.outlook.com
 (2603:10a6:10:52:cafe::6d) by DB7PR02CA0028.outlook.office365.com
 (2603:10a6:10:52::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB3PEPF00008859.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:47:05 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Mar
 2025 17:47:04 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Mar
 2025 17:47:04 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 10 Mar 2025 17:47:04 +0100
Received: from pc36611-1939.se.axis.com (pc36611-1939.se.axis.com [10.88.125.175])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 02FA1E2;
	Mon, 10 Mar 2025 17:47:04 +0100 (CET)
Received: by pc36611-1939.se.axis.com (Postfix, from userid 363)
	id F221C627E3; Mon, 10 Mar 2025 17:47:03 +0100 (CET)
Date: Mon, 10 Mar 2025 17:47:03 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Frank Li <Frank.Li@nxp.com>
CC: Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson
	<lars.persson@axis.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, <linux-arm-kernel@axis.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH RFC NOT TESTED 0/2] PCI: artpec6: Try to clean up
 artpec6_pcie_cpu_addr_fixup()
Message-ID: <Z88Xh75G6Wabwl2O@axis.com>
References: <20250304-axis-v1-0-ed475ab3a3ed@nxp.com>
 <Z8huvkENIBxyPKJv@axis.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z8huvkENIBxyPKJv@axis.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008859:EE_|GV1PR02MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a687633-1729-40d5-3b23-08dd5ff3308d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?88iys/u2b21HstBPDp4JUu9Pn2EsoiMuecsOrAthwCm3dBHelVor4AGgD/lU?=
 =?us-ascii?Q?/hYf9Qaw2DscBmstgaUa7c1IrWbl61K2KGZiSRp79RYsxGIEDz/0bWpG0+d9?=
 =?us-ascii?Q?wpRRo2XU47SeS6uDBg1mzMDPrmpgXc4BlH0RA9jrnYGXbAEvm82Zt+Ar1QXQ?=
 =?us-ascii?Q?57yzwJzH2Z3HtBymPqeZJGdCh9Bd9XrXFshnfKSgFc3Ql5N/SsXiHvMaSi24?=
 =?us-ascii?Q?h78B/F22XjzHjJYpja9y5VKTo32bR8UNDUtMatY7nkBzrx3WXXap0HJWwdyF?=
 =?us-ascii?Q?wvEMdKMOc4WUJtW7GutOTx9Pg1T+Hxu2wuY3PscPLcGBV+O9c7GysWx4A/ow?=
 =?us-ascii?Q?XVQhMf2CNwh12aqSX3OYtRkaQE5Yc47TPBC9iOfxP6MrZcmkSOfMw6QvBZ2a?=
 =?us-ascii?Q?QNJQ/ofyd8TbmJrjeTlierMzQ3OYeOHbnljA8Cb9OnjmEtlZGADmCO8LNFeW?=
 =?us-ascii?Q?Irm4zWGk50T3l87ajHLLDr8v18Q5wcWERvH5+a9hccVUM3WgXJqUa03V3HuA?=
 =?us-ascii?Q?MUcW+syOBUlPgwdoPUsu7O4SIFhYQOBEy60oebTsx3vrk3WkOiJ+nhyIGIpJ?=
 =?us-ascii?Q?7RFKxsTvmBoI4FC6i1PNqYJiwqcD9nfq59Hj8PxVTjhho4uep0im0LZAS6qn?=
 =?us-ascii?Q?MhFwzwcgCdclevwgIOvobyvhaSMlaXIBvdGza+Jhj/nZxCyeHTaFoERfqXta?=
 =?us-ascii?Q?c3ZJkNgV9juXsP/zHoVY48JpLl3bbF+0Wk2QTKj8quWvUOSnUEyuOdaMpb6E?=
 =?us-ascii?Q?EUQeirtAmDF/xmYbdNTvTU2SgvM5IifvIaenG5yMkdRuI//Ud2OqYeMrysMF?=
 =?us-ascii?Q?uWA7K2GCd2TmZ1l+S3rg+ShmOrlM3APIi50MPbV/uZ5RebxVx4Nvo2qhWOFH?=
 =?us-ascii?Q?YTxdyY+Tu4UQC8+BaT8ByNPOn7gEKNV/nPvmpCU96kDpo7uCHTBApMqa8fOH?=
 =?us-ascii?Q?T98Wccz7MIKhCWIVd14X5YDPlIo1OIl3UrOpX5tBI8ftxEy0+fb/1DgS9mO3?=
 =?us-ascii?Q?A+d0AO8clM58TcNwsWDuHA/Wl8K/hlRb0+Ll1isFmOkSPuSalDXmLS3m0Pm/?=
 =?us-ascii?Q?bc5Tdufz8SdQ9hMPUgxdGmat65ZKvsIEcvIx2K53oJi/YUu15IeVt3dWKUL0?=
 =?us-ascii?Q?5LZCis9AbWbpyPbwoAE7kxHAnaPIBJhmO6LoLoYadrqYThpCPfShQT4QgvFo?=
 =?us-ascii?Q?HBY7QtaArTNHUtUUBIZH/brjUJA81Hs6xQwlxWGppXcuwle+3Q0HJ6LwxwT9?=
 =?us-ascii?Q?2x2XuMKDLnzsoRtGt5o9o2yG2BPubEJkzYclB7VUj5Meo0SnoD/ge75NLpDv?=
 =?us-ascii?Q?MG7O4IFhAgk39HyIqOK1FrmUt8mh006nJAJlmgIrtFsBUsAJLFF56GV37QD6?=
 =?us-ascii?Q?70yLRsrYN8rpQrh2CF7bEBUudngeGYMj7x62igWIzdybrFHFekQmS7obyDHe?=
 =?us-ascii?Q?d5z9mmA+WtlRj66BLQONXHyJYOaTi2vDZzZM/tpEJSempe/+X2rBOhe11RNp?=
 =?us-ascii?Q?+lGvN9b0kourM+g=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:47:05.2107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a687633-1729-40d5-3b23-08dd5ff3308d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8564

Hi again Frank!

I've now tested this patch-set together with your v9 on-top of the
next-branch of the pci tree, and seems to be working good on my
ARTPEC-6 set as RC:

# lspci
00:00.0 PCI bridge: Renesas Technology Corp. Device 0024
01:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
02:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
02:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G304 EL/SL PCIe2 3-Port/4-Lane Packet Switch (rev 05)
03:00.0 Non-Volatile memory controller: Phison Electronics Corporation E18 PCIe4 NVMe Controller (rev 01)

However, when running as EP, I found that the DT setup for pcie_ep
wasn't correct:

diff --git a/arch/arm/boot/dts/axis/artpec6.dtsi b/arch/arm/boot/dts/axis/artpec6.dtsi
index 399e87f72865..6d52f60d402d 100644
--- a/arch/arm/boot/dts/axis/artpec6.dtsi
+++ b/arch/arm/boot/dts/axis/artpec6.dtsi
@@ -195,8 +195,8 @@ pcie: pcie@f8050000 {
 
                pcie_ep: pcie_ep@f8050000 {
                        compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
-                       reg = <0xf8050000 0x2000
-                              0xf8051000 0x2000
+                       reg = <0xf8050000 0x1000
+                              0xf8051000 0x1000
                               0xf8040000 0x1000
                               0x00000000 0x20000000>;
                        reg-names = "dbi", "dbi2", "phy", "addr_space";

Even with this fix, I get a panic in dw_pcie_read_dbi() in EP-setup,
both with and without:

"PCI: artpec6: Use use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()"

so it looks like the ARTPEC-6 EP functionality wasn't completely tested
with this config.

The ARTPEC-7 variant does work as EP with our local config, I'll try
to see what I can do to correct ARTPEC-6 using the setup for ARTPEC-7,
and test your patchset on the ARTPEC-7.

Best regards,

/Jesper


On Wed, Mar 05, 2025 at 04:33:18PM +0100, Jesper Nilsson wrote:
> Hi Frank,
> 
> I'm the current maintainer of this driver. As Niklas Cassel wrote in
> another email, artpec-7 was supposed to be upstreamed, as it is in most
> parts identical to the artpec-6, but reality got in the way. I don't
> think there is very much left to support it at the same level as artpec-6,
> but give me some time to see if the best thing is to drop the artpec-7
> support as Niklas suggested.
> 
> Unfortunately, I'm travelling right now and don't have access to any
> of my boards. I'll perform some testing next week when I'm back and
> help to clean this up.
> 
> Best regards,
> 
> /Jesper
> 
> 
> On Tue, Mar 04, 2025 at 12:49:34PM -0500, Frank Li wrote:
> > This patches basic on
> > https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/
> > 
> > I have not hardware to test and there are not axis,artpec7-pcie in kernel
> > tree.
> > 
> > Look for driver owner, who help test this and start move forward to remove
> > cpu_addr_fixup() work.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Frank Li (2):
> >       ARM: dts: artpec6: Move PCIe nodes under bus@c0000000
> >       PCI: artpec6: Use use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()
> > 
> >  arch/arm/boot/dts/axis/artpec6.dtsi       | 92 +++++++++++++++++--------------
> >  drivers/pci/controller/dwc/pcie-artpec6.c | 20 +------
> >  2 files changed, 52 insertions(+), 60 deletions(-)
> > ---
> > base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
> > change-id: 20250304-axis-6d12970976b4
> > 
> > Best regards,
> > ---
> > Frank Li <Frank.Li@nxp.com>
> 
> /^JN - Jesper Nilsson
> -- 
>                Jesper Nilsson -- jesper.nilsson@axis.com

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com

