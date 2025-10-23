Return-Path: <linux-pci+bounces-39163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70CAC02389
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672651A08226
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 15:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC87B2264D9;
	Thu, 23 Oct 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MGUOZd1/"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB821CC55
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234403; cv=fail; b=V9oRe+5iGstMPAKQyqc48ZAmSpONSjX+QBJ9Zplru1sP8t7kaRBt7X8wHTniOP5Bjv4k9HHW1zWF2oJewqaH0DDhYG5VplWpaVkNZuKwNcp+ZhVdjMeJvw9LZtI7jVI7lu1/HWMSKzuTdiuTUesDGsPVFxj54cY685CR/TkeIpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234403; c=relaxed/simple;
	bh=2HiLkv/OJpnHLakLj4xXN576zQvlZDT3SGOFY7xKyvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=czimXIyRcTLVezDahSQQ0ujAOkZYCTlzz1zd8y4yotAUbBJxzJtEUFv6U5yjiDLc7eOQkphXkfild7dnVP3rjQQ5mpx8ScrjlPSNUFOzMEkst391hWzq6vpTbjfkR+wt74HpVUBcYjgHPG/bET6eLzfMWI8TgPGiUYPEdLdkWqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MGUOZd1/; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2avdLbgirfeEXEqp23HglH984hJuJI0LGxr3fQ5OgsXaJPceu5VB+VpjC+rmht0LFmEYQOVNbS84VdLEmbzVrDstSagaK8f/Cg+Adj36NEVboyITpnMa4iuDsMjF4MF02dapBJ1tZwBl+miWd55g0+fg6me1f1nfoq+Okc7f93ptILR6cq/vTVGtuJwySu6BHUuudL1B4TzAJMrLt2EimNZADFLWqkBWS6Tbj5Vbpv1t/hu9XhZqh/KpEQ8LxXFApztr9XQxwGFtBQ/AlGq+sw2bNlzKTGy5OJkHDj7+AFRdxJW6Uw8mW1oqZn5yXNfzys4Wt8f9etcAY9BJsYmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BouKKC+/bWwnu8x1SN1Gr8TpPJIliFOURRMcWbhm8Vk=;
 b=hQlTOVeIXDC858kBN3LHl6acfMR1L4k6w970wlkjcjtBKu6YLlXAeuzfz93ancdPdW0TNtvmOkDENuZ4F6MmO8Zkrtptw2BjS04f9alX9FiS/iTGZ7sBeJrwqP1xI8yBb49WHEXBRRvv3/wLZs+zjzx1Bt41C/K5dVC6VGnq611xBmGpALnLXpXvF7EwKN8OPzQi1hLgwDJya+tFrSLRXcw7kPneWknYSzWSyeBgf+6aIocnKJt3bvDmtzYb/pO5HQfZ/ICeRZtfG7flZ3I9bQNrDFGqDsqX3H/I/D45Hmu4CSy0H317mYtpbOTQglMxWpZW6cUj7qzeAmHBBKGRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BouKKC+/bWwnu8x1SN1Gr8TpPJIliFOURRMcWbhm8Vk=;
 b=MGUOZd1/LgKCsGkIbCxmTGgMlScM+q8QtDF2wo8yAH4Qcb4lzsBtOASoLM62fG6XRDLsLCtFh9/uPJ11omtUdOivvBCtpLH5nq18JKZWGq8xdF7chJlKBtFplBSmA6CbZdobLS1/jlXDoKhc13xG96FQzHhqFxZkQ1MkIh/69t+KzN2nictJJ8McnxT4ukGkTGK0wXAZl53eKys2UlY7nSuxdgQh1OairzaACQKUwzRPuldOWF+D/tuK4RFXD4LplbcvDZDlQ1zHlff7bVPTxv/2i5KwfFz+x/1J0v+RjYGBFgFTTGuw900wY9GgLBforHH4zaPDa2CdpdZbWBeGZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11637.eurprd04.prod.outlook.com (2603:10a6:150:2ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 15:46:38 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:46:38 +0000
Date: Thu, 23 Oct 2025 11:46:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: dw-rockchip: Configure L1sub support
Message-ID: <aPpN2NX7IkAEU9Rh@lizhi-Precision-Tower-5810>
References: <1761187883-150120-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761187883-150120-1-git-send-email-shawn.lin@rock-chips.com>
X-ClientProxiedBy: PH0PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:510:5::31) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV2PR04MB11637:EE_
X-MS-Office365-Filtering-Correlation-Id: 26382a6a-98d1-4efb-33c1-08de124b5ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4+uvu7OBOKja+9jpI/p9bV4YVAeSOMKEZgLg7MA3Alax4jL0w54RbSwPt/Mv?=
 =?us-ascii?Q?hY6tMWESG/jRPLvcJD7yCOmr9l5w/iHjK7R2gPwi3gTXn8YFAoJlALl62iRZ?=
 =?us-ascii?Q?PICjeUF8weJS//7jOlEuImjyHP8mI3lVrnTMzbGYzypd7n0X4KbnvHS781PC?=
 =?us-ascii?Q?bNQPXs5YFIAeKR/hLocmzDmvStJkNVt5wZhjZTVguQIpWfSVlvxnsQGJA/xW?=
 =?us-ascii?Q?atbTJOChmWG9jR+X0mJNP8mtqZOpi/B79BkdB6ZDEzxfJ3/4bK5yNrXOtGT1?=
 =?us-ascii?Q?QHeJIF1kUMUE0wtE5ekJ0IbAnnksdhFjv5koL6iTmVDMpLEaMPfs91ColrQG?=
 =?us-ascii?Q?dEBelzRrgjycidjKr9Cc4+PxuPJAnK0/F4tcPCXHyjH/jZ8mPbWGdChcrBtm?=
 =?us-ascii?Q?FwHkDDhVaaZGBTs9YSVP51pIPA4I9uTT2iSkofyxVRYL+CuSCvSWsZoZ0vI0?=
 =?us-ascii?Q?RZ/O9fgQ42KSqRl+f/q78lOGjAxI22ZnXoIsugvoqRtzmzzDRygQi196NZ9X?=
 =?us-ascii?Q?NXTwpyIpt5EnsKWr/tFXVCb7E3YoCci2kadWuF/fGsruePxn4oVGHmmzfmL4?=
 =?us-ascii?Q?jk7vGg/d7kePz54dm0VwE1Vbr4d6VDCjbsFAAJThVNOYzKcddwN3MQN2xylA?=
 =?us-ascii?Q?+CeYnea6hoTFb4rOzGKh/CPOwYPEiNqZp42PWQ9Qu4IcZVjrKArBfxVeE/kP?=
 =?us-ascii?Q?OkE5o7bEvoBVra0MaQDYYzl24gfv4rzeqfC5fOpm4gxvmU7x0by6TdrV84Se?=
 =?us-ascii?Q?l4ynJFPSmYQ9+EzmiknHfg7Fzb2qwqQ/UBECOD0/IxQy3qPuyyNsFOifqksc?=
 =?us-ascii?Q?AgizAWH3OFgpzdjLmrTpk6n6rhpt/iYPiOA6afdPlkPNSAaw6i6fH36RnheV?=
 =?us-ascii?Q?63EsEW1ezUXIxAIrW7s0fab1kJxx2tWhgFm6bcYwhi4PyCmWBtiNTW6cpNXi?=
 =?us-ascii?Q?em187I0RgW3jj/FhIRqho8pjquhLsEk57B/lH0rB/FPMW7Uq86gHt6j6yfaR?=
 =?us-ascii?Q?MkS1+49H7XnTxiAnp5yeSVSm2zlkkwIJH4SIK7uGBYXO0tWw9j0PzN/qtpe+?=
 =?us-ascii?Q?pTTh5Z3h96iwgu1C2Ncqh98lWmR6vjaFzCy5/T56JeW3bVCkthfGe4AfTZo9?=
 =?us-ascii?Q?ntvinZfak1zdaUZgNpgzwDrn0Zgi6xfY49pU2no6biX6m+LHkrncGUVK/WLN?=
 =?us-ascii?Q?+UrXSRARDh27buwZ8ydNrEFSpFBEqaWoEFmuO37hkmq/13psxmWG9ynqBv0y?=
 =?us-ascii?Q?BjJRw60d8EdPyGWAvZXFzxAndBHie66TRDLtIl1X6yV9wtx+9QII9lcug1rP?=
 =?us-ascii?Q?V87AkqrgHPql46qMd94c4NFztOSGXfOwTIJsgWwKcbXEDnvJIk3a+AAV+YgZ?=
 =?us-ascii?Q?sJJ/V9r9n2gjcfwrLJIXiT3AIZk6Ttv6vrK77c+MYvsQBtztItZe/dCoJXN5?=
 =?us-ascii?Q?Ep5Au37tz7RgyQqZukla0RikTdlcEuHUKzUtsYrRBxojjqntr0npmXMiJcVq?=
 =?us-ascii?Q?rEr9wVqxtqeX3yCHwr4YnJ9NIZaITg9oCuqo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?37HGu0G8pBvdYAdJYYiy2CLn/PKD0vMnMog+mP600VlvnKx2BerTW/nmPPsA?=
 =?us-ascii?Q?vRUU2RI1DhZeMFf9mE72eJs8FhdZ3kFZm2ailOMCi9fm+d2j4HleW69lIraa?=
 =?us-ascii?Q?5bt3xRmFB/zRPNIREW/4EV+8iXXrG9rN9z9540Ip/GK8T9ipVbJn/sGjr9pX?=
 =?us-ascii?Q?mKwRJUe//AxtPfjiAMhMF+lrOEIU4QgtVCfYw/REttvGutiQR7uXGcRj1Ar9?=
 =?us-ascii?Q?ebTJtxBRIUbCxl89AGJ5xzqofSS2uWcinbRbpWzxfQq0rLz/96LZOwWjCE/2?=
 =?us-ascii?Q?Eko1cAqGQv0OZdQyTYoi4mz8gEYGLvtvaZMjOSdzpH19FAZ7JEcuFnLMI440?=
 =?us-ascii?Q?+X+Cnm1QfaTkUVExxcWfagwQgFrgM6Sm/40hn7wjEI9dMr4TIE64OjFxmUAq?=
 =?us-ascii?Q?7oi5J0CoG+TfGhrk+eU5ru+Syal5A6N/xg3lu5gG4lCqYFDdNMY04sbAuC6Y?=
 =?us-ascii?Q?rkgArEL5q3ZUOhcrIfx6eJfrvIEZAt/jNRXNtjfwLMbTpka9XeP0hPsHzZRr?=
 =?us-ascii?Q?FnqgrhiC+HoiD5xPK2Lw+4vQ5KmEr0iUIoa4y/YyyXWho0lq4LTpJP9OJNSy?=
 =?us-ascii?Q?fkD1XyWvmvuQc9YSqLuu5sWJXT9reoogH7LC8bHREMZzlSOzH/PUqqxFrlFf?=
 =?us-ascii?Q?ZggAJRAlMO0Y0rZppE/jqrl10H8jIu35iIZ3ZcSvcpNXgJ6BvZsRqa/nP2Nr?=
 =?us-ascii?Q?5iwjcH+UPOxRjlF/gQEGFRIHL1xE7w6m8lp9IYLung/OaJbPl03T+gBXq1kQ?=
 =?us-ascii?Q?98IUkPZrTbQg7E90M4NFSjY06bXf67CIqsjdAdJGPlD/8u8NDw+8SXgzjYm2?=
 =?us-ascii?Q?e/jPv+o+uXy/O94fa8+YFVWFzjhXYTbrBiOgH38uXigci/C/+8SyaL0zcWuS?=
 =?us-ascii?Q?Jf4eg6++MdEwe3IEL4w/US/idakcMSXfpDgyzaMulXPEykTBlDDF7LvrU5aU?=
 =?us-ascii?Q?t2eoHQD2z78lqc8mvpws86Qz+1rfOjn3ac7A5NF7PqnTqdOVnJrvye9oe/NU?=
 =?us-ascii?Q?IEHyCfPiKJ5Blr3oTNKZ+ptzWcfRIjlvchZbHxVv4N9J75RYYGrndfsrmAwB?=
 =?us-ascii?Q?bpZBLXSmjNsNtR/oUPUhizri9uUMBi41oJkgJT3dvd1lG0VYo3JRvbmeiu1F?=
 =?us-ascii?Q?ehqiPFcwPyh3U+hrb1pgURzOgDHKERzQiMQAdPSpCewS1f4Kowgs9x6go2pF?=
 =?us-ascii?Q?rVJ4TRBDQ81/ZNBeZ6CUtkrEveqAAlZf4nCysI1yTZKQa215rcFdvVUGa3c4?=
 =?us-ascii?Q?sjy5F0A4dG/UtLScOgJByPsOC84wDYPUrArvVMUDKclSDTbglqcl4YiuYKLG?=
 =?us-ascii?Q?SPRLXw2xWdsNecE1l+nTcA4obWs/q1UbM/Ymm0RH6LNsFzE0CrJstT+Sg1u9?=
 =?us-ascii?Q?Tfp/fKWnzkst+jRCfE9Pmgs0jWPY9wkYCaMYKO/r3zat9TXYatKfLOc+Iylm?=
 =?us-ascii?Q?TnTp0jg0QPHu7LjIzPtSU0OCwhnCfUwVb1u3oJ/+/+Adz+Y8CJnjscBf0joo?=
 =?us-ascii?Q?TrQ5fcKDyIL1HMoJE3vNyeFKjzm62WiOh1VbWZ410CUyt0jE1tiYzwH0iO0L?=
 =?us-ascii?Q?MC3kOEn/tuLnHHp4yLAheEvtflrYM1BIbelaPUkL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26382a6a-98d1-4efb-33c1-08de124b5ab8
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:46:38.8167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvDUs+XVBBw8IkzC2+qlezXl0m6OTs97r1K7bR32S+A+M3y6JAFZYzT66UeQq5tNd5kf3iphIZl8/MepVNOaQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11637

On Thu, Oct 23, 2025 at 10:51:22AM +0800, Shawn Lin wrote:
> L1 PM Substates for RC mode require support in the dw-rockchip driver
> including proper handling of the CLKREQ# sideband signal. It is mostly
> handled by hardware, but software still needs to set the clkreq fields
> in the PCIE_CLIENT_POWER_CON register to match the hardware implementation.
>
> For more details, see section '18.6.6.4 L1 Substate' in the RK3658 TRM 1.1
> Part 2, or section '11.6.6.4 L1 Substate' in the RK3588 TRM 1.0 Part2.
>
> Meanwhile, for the EP mode, we haven't prepared enough to actually support
> L1 PM Substates yet. So disable it now until proper support is added later.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> ---
>
> Changes in v3:
> - rephrease the changelog
> - use FIELD_PREP_WM16
> - rename to rockchip_pcie_configure_l1sub
> - disable L1ss for EP mode
>
> Changes in v2:
> - drop of_pci_clkreq_presnt API
> - drop dependency of Niklas's patch
>
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 43 +++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 3e2752c..25d2474 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -62,6 +62,12 @@
>  /* Interrupt Mask Register Related to Miscellaneous Operation */
>  #define PCIE_CLIENT_INTR_MASK_MISC	0x24
>
> +/* Power Management Control Register */
> +#define PCIE_CLIENT_POWER_CON		0x2c
> +#define  PCIE_CLKREQ_READY		FIELD_PREP_WM16(BIT(0), 1)
> +#define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
> +#define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
> +
>  /* Hot Reset Control Register */
>  #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
>  #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
> @@ -85,6 +91,7 @@ struct rockchip_pcie {
>  	struct regulator *vpcie3v3;
>  	struct irq_domain *irq_domain;
>  	const struct rockchip_pcie_of_data *data;
> +	bool supports_clkreq;
>  };
>
>  struct rockchip_pcie_of_data {
> @@ -200,6 +207,37 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
>  	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>  }
>
> +/*
> + * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for the steps
> + * needed to support L1 substates. Currently, just enable L1 substates for RC
> + * mode if CLKREQ# is properly connected and supports-clkreq is present in DT.
> + * For EP mode, there are more things should be done to actually save power in
> + * L1 substates, so disable L1 substates until there is proper support.
> + */
> +static void rockchip_pcie_configure_l1sub(struct dw_pcie *pci)
> +{
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +	u32 cap, l1subcap;
> +
> +	/* Enable L1 substates if CLKREQ# is properly connected */
> +	if (rockchip->supports_clkreq && rockchip->data->mode == DW_PCIE_RC_TYPE ) {
> +		rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY, PCIE_CLIENT_POWER_CON);
> +		return;
> +	}
> +
> +	/* Otherwise, pull down CLKREQ# and disable L1 PM substates */
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
> +				 PCIE_CLIENT_POWER_CON);

Looks like you force pull down clkreq should be enough, needn't disable
L1SS. when RC force clkreq is low, Ref CLK always on even if L1SS enabled.

Of course it depend on hardware implementation, But I think FULL_DOWN have
high priority to force clkreq to low then PCI_L1SS control.

Frank

> +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	if (cap) {
> +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> +		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> +			      PCI_L1SS_CAP_PCIPM_L1_2);
> +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> +	}
> +}
> +
>  static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>  {
>  	u32 cap, lnkcap;
> @@ -264,6 +302,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>  					 rockchip);
>
> +	rockchip_pcie_configure_l1sub(pci);
>  	rockchip_pcie_enable_l0s(pci);
>
>  	return 0;
> @@ -301,6 +340,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar;
>
> +	rockchip_pcie_configure_l1sub(pci);
>  	rockchip_pcie_enable_l0s(pci);
>  	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
>
> @@ -412,6 +452,9 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
>  		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
>  				     "failed to get reset lines\n");
>
> +	rockchip->supports_clkreq = of_property_read_bool(pdev->dev.of_node,
> +							  "supports-clkreq");
> +
>  	return 0;
>  }
>
> --
> 2.7.4
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

