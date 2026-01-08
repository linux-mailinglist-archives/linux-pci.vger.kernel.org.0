Return-Path: <linux-pci+bounces-44289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1558DD049D4
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 17:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C84BD3016A83
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 16:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCE02D97BD;
	Thu,  8 Jan 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DX2JlgHs"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021127.outbound.protection.outlook.com [40.107.74.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A802D7DDF;
	Thu,  8 Jan 2026 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890363; cv=fail; b=uBNytf1GoZDJO6HfQrgbg/d9MHC5BAQdiivvQJyKPLgEZW21aj9si+rb9bysFQW2pnomW6IEurHDgKfSJpZpDS12K9z9I3btQU9R9sTolFdY99AQnWQ0CwFpCKDHCY7cYBy9VtbOmT4JXj7XxjLJZXfmNoSE1w2a3KRHwbmIWsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890363; c=relaxed/simple;
	bh=gLotboruaomsahM/DU6azM0tq8ZF9+s32OH0AVROvEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ex9me91WkkpyaUFnZVwerT+jxV/8IBnbuywZoB33Mn0U7nVA4A3WGTV04g98EQoKR2vMoTs76NRIZDC93NlrayB2GZA+Cv0RK51MdB09Mt6AKbdJ/gtmsa3C2QP0mXz5oq/aIzsOXr/goph48z3MzYT0LPxJHFGOC+ccct5qTnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DX2JlgHs; arc=fail smtp.client-ip=40.107.74.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6CR5JOmdqypCgkoW5OFe3Oec42OiFV0A1lIDIiZDQzfM+X/ZDheO/04mT/G3X/7xyXf27I3tfrAUdjYrMrOYoEQ+PLxDwzCX6CWxqW09IbZHGnM2LyixyDlkfSZJ2evu2D/tfYEC7oPaYNc2TPQyQkWDB/cR1E6gN5YfE3cas5JlnbZhraMs5koOxKp/1wBux2o3SVdH0vH/gHNHhYJAc1F8LDExUHPP8M/4J0GznQ7UGlTqzfAKUljuF2zM55358nXvIA9fptHveKbjn3z51IVZdxB9ZbXkmNrFqdtDRIdE6Xu5vBhqhKfj5V5S0oc6yVbnjFIw6Grssi/5pDbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPLsrllk9/h9cg87opNAZO7BUvv/WDOPdKR0cTFb3h0=;
 b=WCeoHRFjqVmFqvmegQSX24afj2MGG3yU97PvrLH5skqKRO1NyjxWuB8ZehUnhto/MUrBuVPXZXmnSRvEHqQyapTVEvO0ywhpGvMfy0sZ4JMwIfJrb3m7QqxxUIZTonLqjwbXMrQOolM/CaZ8g7q7oviSCZZyL+SH3kkQARhesyIxVFtll1HzRNrQIaRGa6yWFNj4QzL0ijzZF1bBPAhKeKyQlrTq0B4eRVopQyYj8RgnLe8ooo1wJWL612MF9emUMEksQxpQmWwbFFf33pIG4a8K/kTwybbDKrhKGtB44LaXy0aSi6/2y6EQK25WZJzuYO10Io99HN7H6rLPEyglkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPLsrllk9/h9cg87opNAZO7BUvv/WDOPdKR0cTFb3h0=;
 b=DX2JlgHs8gFZ4FGvLxmRCIomYq8ERUAC4HnzyGS//KcrcRSbyKaaVEUcIkFHWIQIVNRFnRLW5viCAQIjWgYh030+PF43oXyr+RSiBSLnq3anlQNEsiuaTJAg58arq0ZJiL1olxIegRAdWdXqP2WdC9U6gFl8B6l4psLWKGwvmMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB4994.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 16:39:18 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 16:39:17 +0000
Date: Fri, 9 Jan 2026 01:39:15 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, Frank.Li@nxp.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: endpoint: Add BAR subrange mapping support
Message-ID: <3zbztusceiv2imwfj4t3xxju4ht2s2xlkxjv3ncrjmfkl5g6z2@ulqbr6aspryn>
References: <20260108044148.2352800-1-den@valinux.co.jp>
 <20260108044148.2352800-2-den@valinux.co.jp>
 <aV9638ebwqc4bsbd@ryzen>
 <aV-AApRHXLOTEwm3@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV-AApRHXLOTEwm3@ryzen>
X-ClientProxiedBy: TYCP301CA0057.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: ac61bc16-b08d-4116-a630-08de4ed4773b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hw5sp+aioYy396f7/1/JG7cw425VdzE4AmHusG9Gq+8VpmUzeVjcN55o3fve?=
 =?us-ascii?Q?a8ub/d6kMIjkxBvyvgdSrdSeZp38xV6Osb9LOBLLFdoK5Mx3G8e68BtaqYkg?=
 =?us-ascii?Q?Gr1BxVA08c7Ou7o+FXrglxPzjs4xtixb3wgled8nG+WdRFQtRMmJpJpfFYEq?=
 =?us-ascii?Q?vZ0XkWnEzPyda5SKExoumsIjL20+WPfMsipqWvgWDi5S+Le8ZnINi+dKW5Xn?=
 =?us-ascii?Q?cv6gwlqX8akqXN+QEyki9y7kfKQsK0f/HupAIISlo1mGyuC4IeJM4j2zUoVO?=
 =?us-ascii?Q?vGoMOjTHAiLJBcT7qXRptu9NiYG7ocCU3Eqhkxzoj8AUUvxTRd/CUEEBxks9?=
 =?us-ascii?Q?JKlTNr5u27Y557f+JZsHGWOmj7HfXR0zAjJlTU5ic5tecJojrazLtPTDBnKE?=
 =?us-ascii?Q?9qSYLjY5xU+RA50XMgPM/PPME3doj5aGsKt01ndWwTKOnaRugn4M+OdjgOLW?=
 =?us-ascii?Q?0Ekdkh77JBHhV+eu8uY3T2OoT7WQBszmRKdw1tx51bXE2EYMwu+0GnsFgeYa?=
 =?us-ascii?Q?/yFdjSrdYxlHUTvqKr2gaUmYR0J8AgX5WxwQSdVB07OOP7M7Acw+uAn6Brb4?=
 =?us-ascii?Q?dz6topQ3a97NVjng+gdgJO5tV389SrNetiNzRVLajKdShbuJQV1q9qI47iks?=
 =?us-ascii?Q?FsykUveEvq/cMrt/trn5zhI5joAC6oSAjmFJ3BClupUgzoDAfQTKyTobEaWG?=
 =?us-ascii?Q?XyfE/p60BH2q891sfvo+32udp/Vb9V26hi9Fp9psMx7QDMISTotBze0HfPf7?=
 =?us-ascii?Q?/Xz6iqabAQCRaympVX80HDtceayNoh0oSCCDqy5uI86HBFMG1ew5SUN5kFlk?=
 =?us-ascii?Q?v3X1NHURk9g0OE6E6wjBpruJ2Foeg2QeWJDNseU/pT7dccpEJBKjRcD2o3Un?=
 =?us-ascii?Q?aTy/Djtwi8yUwBKQkmNA7FnlEwtp0UWuRiR3xo51WOgB9PDPuEkTHUjLS9T3?=
 =?us-ascii?Q?5tuV7XQObsg5y9uS/esZjsapuub8yUyqTcBQocDxtIPjidYM6NO2YvSRzJdd?=
 =?us-ascii?Q?dTy5sBfQ1V80ih0wGobdyyRoQZwBGszVRui6AK2lNnYTLFUBHbOaKIzmCFa6?=
 =?us-ascii?Q?V6R09vMehQLjZBIPMcJsqw8M/TAQBkLFAxze3MbQe/RA1pOvfMLb8al+Nsxx?=
 =?us-ascii?Q?RUvs4MGxB9/CxHNGYND464vYi7PdUwNwDrELL2bK8VTDEiZN5JCGCqMOUA6m?=
 =?us-ascii?Q?QJMN7wIQNnpL6QUWt5daP8IRiG2EB/jHxQTCYxVwGQ6lQDiVKUMfy9nRZUq0?=
 =?us-ascii?Q?m4kdGoZfICfQz0DxO9vawifxFdQNnojVt9xoTeYS+4dK6KXOIyMEITfTmGDr?=
 =?us-ascii?Q?g1NaQH14EejktA44DH8SxdBI4Xk2GxbXIjYhMbYCjjBNyrI6rgZHNMzhCVTa?=
 =?us-ascii?Q?E2lDs6Bs4WkmCCw2q1TD1fXHJcKRNp9lV5tfERJYmWtWKB4VIF6piW3AENdg?=
 =?us-ascii?Q?4vF4B8Kvc+I+ubVGwW1j7bZRvjRDyhBfVpIVFeNK9JDH8E2KcCQ7QA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XDZrFRaHN3KCvehsoiJRtv2Opg1T8evvn568PG/t67KVaGQKluZsN5eUSaFd?=
 =?us-ascii?Q?txHfLgla1jna4qOKK8HrOmv560pu6wdRmjXB1xn0Ykj9u32cRVZfiBnowVlN?=
 =?us-ascii?Q?NKtD9k1t826OM0TSkMozB5hTuFJFqFDkQAUk/g7SlmaaMp/45xeOOfO8Oxgt?=
 =?us-ascii?Q?5/uq86e1E6HsPkH3oeBhGwjAjv/3jZTHjpcjuWMOURsa85Z9SlSk0vJtXSUB?=
 =?us-ascii?Q?0jHvB/iuSfxiryVqvTplLdw+EOD99rPVGHHI9Jfz7Wh0wYhrx0AdDEubZkaR?=
 =?us-ascii?Q?DPqYtmlYPIUtU77KqBhUQ9QsMn7LtsqeiPo+9tUfElF0NLhApPV+LF5v6NIo?=
 =?us-ascii?Q?SKNJ9w1OPgnSatU350T2P4TTQQeH9ZG5dqIFHyMp8iRJLUbCqso+yVqCUUqQ?=
 =?us-ascii?Q?MKxul267NQAfRxl9dIBYDn6q9Q5OQezzN5E77bdb94RhZRTpgEqNPvX8P/vc?=
 =?us-ascii?Q?1yAzYZcVTp7GFmRf1EYYfPT9gYrt2acD28WKRsqdC4/QFD8zQbkoI9Ohqa+Z?=
 =?us-ascii?Q?btczEFGAr3fECGDj5JV9OxpGsGRWkO5JO9pai52LQf/yd0FbNSacyC2UHKDr?=
 =?us-ascii?Q?pql+u62RSslom9AKKq86UbuHpJnS23h9GJSuPfz/VQyDhYB1sCpUzDAwFQ9t?=
 =?us-ascii?Q?K6FFZExsiwB9wRa+F8ScIkzvgdFk+8EwYmrZTZI5U07cizaXz9bbShIZu/BY?=
 =?us-ascii?Q?g7nGiyPTmRXAyRmyMW4xCoPfPLVI4s2IoqxSDNV2lCQdO/KV3UVhZwsaRDP3?=
 =?us-ascii?Q?IrzrGNhUAIT6S4dlfoqUzKcWtlIzo544xG45Jw947R2YAaGXb9ZkJ/eWre0M?=
 =?us-ascii?Q?mTCk5rED5e6jpfo7DC0p/o+ApmTBhSWsEkkCI6QEJjxmf6i8hAjgsTaqT7mj?=
 =?us-ascii?Q?tgYv4yqpybHX0nLRp0arMApPHxiHyjc6yqaA8c6NwfosMu40WOXnGnDmLMTc?=
 =?us-ascii?Q?Co9I949CEqhBqY0OzlfTdXSHOTCFeeHt8ivMkDY+yUJ77Uuk16Sb7EXUkH+t?=
 =?us-ascii?Q?BU0vixQFfDpPBN84AxgHjVnKJO6L5pZ1k0SXl/5EXNP6bRY22p8s/dT5sHBP?=
 =?us-ascii?Q?5QHGm9n/rPv+ypHaA1CbTWa0MRRqPAxRVBdzYI+PqP9CkK+na33uKMb+z1Hq?=
 =?us-ascii?Q?C+yCXecTtDo0Uc/UKvQJDUvgvIAZhPN19Yi8zG1oPOLKgqzOU7C4jTm9Hx5T?=
 =?us-ascii?Q?sF983ScQecCutpkmXP65DtTlBGV6tY34kOveLvhahPBjbGaTXaPur7Yd/mzw?=
 =?us-ascii?Q?iyElkcbz5EA0oJPjMTJebfSmHAtUTpkwyajYpKOl0jG7D6JnXINCHc+YZN81?=
 =?us-ascii?Q?hTrMq/YOxghzGzocy99O7Fub3JE7/3LwZNgPVIKIHF9AaR+Gq4iXL/1nAabH?=
 =?us-ascii?Q?1gUggf+HTc04Ankgi1DL0+5ZRpuEp1TBJK1iQSh0AZTLlmIEdn1vCc0efm31?=
 =?us-ascii?Q?VPEuFeEVb0byMPeaB5QavD4ESEqNb/mvSESkc9pTVD4uadmqY8MNj+4tjwfq?=
 =?us-ascii?Q?dcMLuWIUEmN9GrpsniTIR/PioA+wu45vyntCBmErmcZ+140gv+hR9qycMBbp?=
 =?us-ascii?Q?K/c/NQrmCeERVXXzE+PijN4ZYR3WdiWCbw9+yNWDgcy8wIr+ux6VjQM0+5Ha?=
 =?us-ascii?Q?Bws1Gh5X0rnT03YnlBPwvIhLOeXdxeSY8T4nBHv7adbUObTPtH2UL655TM1q?=
 =?us-ascii?Q?sXoa1VlQ1rj0eqKaEBRfyJeyUFoF5rIn53l3GLYaEhki6YnpGM2Pdb/uN5T7?=
 =?us-ascii?Q?1+OD3JXHg/4sWAnjZnnstVRCyG8/73+M+8E9utuE/0as4HFq5IT2?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ac61bc16-b08d-4116-a630-08de4ed4773b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:39:17.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDZzt0A5vOLdu3i3XWg4P2Nbkmmrx2/LufJMPRuzblYlWM+mJq2+OmpoGEWvcF88jHrlAYbraL27/8JG13mYXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4994

On Thu, Jan 08, 2026 at 10:59:30AM +0100, Niklas Cassel wrote:
> On Thu, Jan 08, 2026 at 10:37:35AM +0100, Niklas Cassel wrote:
> > The memcpy in dw_pcie_ep_get_features() is a bit ugly.
> > I guess the alternative is to change all the DWC based glue drivers
> > to return a "struct pci_epc_features*" instead of a "const struct pci_epc_features*"
> > such that dw_pcie_ep_get_features() can simply set subrange_mapping = true in the
> > struct pci_epc_features returned by the glue driver.
> 
> I think the best way it probably to create another patch,
> that will be patch 2 out of 3 in the series, which changes:
> https://github.com/torvalds/linux/blob/v6.19-rc4/drivers/pci/controller/dwc/pcie-designware.h#L449
> 
> from:
> const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
> 
> to:
> struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
> 
> and which does the equivalent change in all the DWC based glue drivers.
> 
> That way, dw_pcie_ep_get_features() can simply set subrange_mapping = true
> in the struct pci_epc_features returned by the glue driver.
> 
> 
> 
> Note that the function dw_pcie_ep_get_features() itself should still return:
> "static const struct pci_epc_features*"
> 
> (Since this represents the DWC midlayer driver level.)
> 
> It is only the DWC based glue drivers (lower level drivers) that should drop
> the const.

Hi Niklas,

Thanks again for the detailed feedback. I agree we should not let
controllers that do not support subrange mapping silently ignore
epf_bar->use_submap, as that could potentially lead to an unexpected and
hard-to-debug state without returning an error.

Adding a subrange_mapping bit to struct pci_epc_features makes sense.
I also considered setting .subrange_mapping = 1 in every DWC-based glue
driver and keeping the const qualifiers, but that would duplicate the
same information across drivers and add unnecessary maintenance burden.
So I'll follow your suggestion and drop const only at the glue-driver
level. I'll send v5 shortly.

Thanks,
Koichiro

> 
> 
> Kind regards,
> Niklas

