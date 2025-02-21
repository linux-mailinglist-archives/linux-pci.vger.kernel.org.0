Return-Path: <linux-pci+bounces-21983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381FBA3F8EE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51ED619C3B97
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBA02135A1;
	Fri, 21 Feb 2025 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4jbDMvuW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B7213256;
	Fri, 21 Feb 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151801; cv=fail; b=C+CHG4EqaqYVMDJzdZ5RRKmB3gTq/VTtQpSg/hghUo520eR05Wokr4jEDq4O20/gVmg+bTU3pndL4GUQFsGmgLZH3aaumMeR1rQhy0bIw7+i6jrc/9IPtVbiDfxrBeLcfwzjEeudp2N/afftFqYzKuGYIbPefP6MuopGb1JXlX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151801; c=relaxed/simple;
	bh=e0cGIVek4uCeSzWo7pyVO5l+uUUO9wtP7kq03vuhREE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BhT0jgd3ahBVVHl/EG2O94QieGnmJvInJNlFOTZikVq7cx+IVtwuohaKVV6ivttrihDrOdHEznD6oa+0/mxtdELbSd+TFGSAKds4esIDVK+rabYiZSJ0O6LaqKUso5iXqzCY4q4T+SJ8PzBU1s1hKcBZCqJ43aJ9k5CNxsScZAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4jbDMvuW reason="signature verification failed"; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAkIGcbvXfupr95QNYuUdZVMcz/qNR8Y3DolypbYium5m/kfs+PZSYbjsyBN+WzWv1bivud6iLo/1M+arWbf06c/qDUN7YJq1jLs9VtwxeyYVuyGWeBLkZyVirmMCx1hv5cXuwscGCkmimuE1QwN0fsRJxz6rWBU5gyxq55Ez/M1f4aU9+rG2WRKl0/0oXR0mDfxR12d7lR1vxjYpQsKHe945X381ViijUqQc14kPkpensS9N98OxaW4vdUAys127zsOMs75zdNPIPNBpbogNbyMeZlrc9pvod1Lv1JT0zE0/iVzhrHo/jjQX+GBhHIdran6/NQPjcHZlY4I9aNVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aZoXArHo0CjeNsNhMgAtONYyjCqjZMQfEkUxxzfaA8=;
 b=yvW/qpd3/WY1RERkcbIjtHLR6ldmoDgi8fRhIw/H7LNWetLBix+Au5fjC2dQWMCl4dkJ4D53beN5Czzrpvi8SPGZkm1Hc8Z1ZRR1KqoPLWMagIalnQpD1h0Geg7FELgHw3Wjlndc50Y4DiAOpyzpM4Slv1FO2sYhixoZ3AvqsAz/va8hGIqBBvrjUgnMHTvGLTTTPJmS/N2gVGUnpqWI5gsD9DCeS6hBLkBhBAmSHcYgmPOdGVRIE9whOJ5EtwA9S7JKBokFWA9MVOIC/brN9qozgSv/O3VHWLhLcriLLmDnKVJsJELD+2Lj5r7mTw9UWVxHLevmtbUx+ut5mcDrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aZoXArHo0CjeNsNhMgAtONYyjCqjZMQfEkUxxzfaA8=;
 b=4jbDMvuW0J9KpyOy4UW+A+jp+oQEa90UDkfJQ3/n+4UcKni1TurHj+6OpsjJiQt+zz0+LssEX3xgkXlI9Vf/NHjlUZyzel0szNGAo/d9Bo1XEuliXxgR6XPdH9Sewlo6DL/AWOiJNAiyBDTofKRyGGSMVhff+dES9hiXPtwVKGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:29:56 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 15:29:56 +0000
Date: Fri, 21 Feb 2025 10:29:48 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 1/2] PCI: Track Flit Mode Status & print it with link
 status
Message-ID: <20250221152948.GA926653@yaz-khff2.amd.com>
References: <20250207161836.2755-1-ilpo.jarvinen@linux.intel.com>
 <20250207161836.2755-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207161836.2755-2-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: BN7PR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:408:34::17) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc801a5-64fc-4712-a935-08dd528c989e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?sgfK64rED3Ytk7iq+jiK9ed164pcFSc99ia7RQeWu64Eu79r24MTkg25Un?=
 =?iso-8859-1?Q?4/DJ5r5QB9Yn9Vxcvde3zawOsXzLReMTXrvSZv3gXB6df8H1Etllb2DOcc?=
 =?iso-8859-1?Q?CI9utkrZNnkHj1Mo7V/BNOaCkid2Egccyh3zjv8MJOf19G/Rs1IOF9AsaH?=
 =?iso-8859-1?Q?8giwFaahtMaJYZFVU6LMZCGoLDOHK0XEaQ3c7kBhT/Nnqjss4sbS65ojih?=
 =?iso-8859-1?Q?sRj50Wh3hLkLumITTZQ5luz6vsWG9N6gdFVaIsiG+ZVMg3YClLoadhOYpG?=
 =?iso-8859-1?Q?qSx9Fxzqfe+RFcLXQFBwxTF1+AA3wf+3rCHfaCZsb0s19CncPeI9dz9ulC?=
 =?iso-8859-1?Q?670DujvS0wMk1s7WDufNxnIVWXWmGQWS9csEvYvJoxgnTzGDl7AUPthn0U?=
 =?iso-8859-1?Q?Xe0h2+MJNvEMQK5S8TPadeb1MLC4zFtQGzLiuvmE6+S/SaI15LOg3gy7FH?=
 =?iso-8859-1?Q?Slu36YbuCkFhv7o/DtXhtpNXtWWNPYnVragoTGaSnT0DQBOsjBIBjSZRN3?=
 =?iso-8859-1?Q?02qrppXc1lZm1nz9M01ifbiC3/O00gur1liLJPWmfRczzNedBCVMzV5w8u?=
 =?iso-8859-1?Q?eZfCjgZIB8UWMuvnX0h9v9PZpYNYdWmNp5LbPfMOdljnwzdCDMBAg1TyU0?=
 =?iso-8859-1?Q?vJOuWuRuFuH+M8N8MzDtSM3bb/nLM8xTePwtCgxVsHIoeV+EuJZP6sqHMV?=
 =?iso-8859-1?Q?8YcCrypEeWZs+Xkiv9bjBMW99AHnrMukrWa629q8AAmkSMM+9CceOrEfNo?=
 =?iso-8859-1?Q?EZIty+Vt+YtwTMSVNmrVd99wzFGgjgqqAhZDzfhQu7MwlwcfMrA6EGz1Vz?=
 =?iso-8859-1?Q?mJhSwbuwuH2oUZfoMCQ9DoovbUFso22ZfAQeOj4rZ0h2IQgdOo3LDyKSIj?=
 =?iso-8859-1?Q?FgtE8/lvNc0RwCXb2hlLbCyOLWDOaTINE415ZWJMjHovGwXoJTtuan/fV9?=
 =?iso-8859-1?Q?qHksEFmMQaykdpY+Z7eTG/ncAnxg3zippIRlgaKltuuo/hUh3e5N9ds5lr?=
 =?iso-8859-1?Q?iPRyFwMWJD2JbcBT5658vciq4qKLfZCHsnwqaqCOcOcBTfAKd34EuE9C1O?=
 =?iso-8859-1?Q?tlR2KIxBWoZxw9HfaKfMxOrMHOM1QMKzKh1Zg24ja4AXqJISvjuZGuqlFj?=
 =?iso-8859-1?Q?v8X6NogEKpafqPkROyVvEaT9hu5kdB1lBlZKRjnR2dE8knOGUa3oXWpIdc?=
 =?iso-8859-1?Q?By+fR7omvfe9q9RQtyCUtbRr11Y16CI0F3Col9WplQLpjDapsbRhdAsWCg?=
 =?iso-8859-1?Q?2/oTXdst+LjOrE5qFehU3EdNw7mXC/BghMqMgGpx60Y9tmrlFx5CL52sOJ?=
 =?iso-8859-1?Q?QoKZB8u10n3tyHc7cbpMMTvgHJGG1kKDSERUBavODOMlmq385EVW9/0gzt?=
 =?iso-8859-1?Q?VP3RuGPGWT4ZLQwINAiRcllwv2EXM59UTFoBuquy6ZMAdFYtFCMSP6YjVY?=
 =?iso-8859-1?Q?Fz8VmHX30pPRxKlA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?DsnmIGD9h4UKWNdCLD1NTnV4aRTF/hr6qrg3V4+nafso9mAShOv9CYsJ4U?=
 =?iso-8859-1?Q?Qav8unVIqj759jPUY0PJK8FIA/u8KRvLtvpmrtCxT1DHYl+Y27VgnTOMh6?=
 =?iso-8859-1?Q?wEXeEw/lQlxCNCIMLKHJmbE6ZtRnOcoV8aHghWQlzf7mOi3dkS5TfkRH5w?=
 =?iso-8859-1?Q?UJ0fLpNyWrCaMcToVZ6eEpSPmn0B2/VP2ykeBhBXGFlEHgbPvLXY/pBAaL?=
 =?iso-8859-1?Q?ptyQRd1FnYJGy9gXKauy375palYX1yja89EYDDCtughXT5mRbrldEkcdTh?=
 =?iso-8859-1?Q?ig5xf/BHPUFNN+VedFawBiLhz4E193K6Q6oxf2Gnk+CmpKR9rVpwsXJ4av?=
 =?iso-8859-1?Q?qZ+w9Q11+hqhFNI2TsKzL0ZpSm869XoiOugIZBnKnvDSbern1+DkoxLO8H?=
 =?iso-8859-1?Q?ssFlYaZobYu2Yl0GVot4ChgxjDFnofS+SiKLb/pgfOnCeCZ3l77YzxceHR?=
 =?iso-8859-1?Q?68LVD0uQhnmwiRl4EvBlN/mVyEYea6zm8Z7K+hPRweKDpiazcTDLZ7S0oj?=
 =?iso-8859-1?Q?5nkm3l4EDWzjbjaKK1vXcOJdlVS6lCEIvN1EWifI8nyEOAQhlRK8esHuKO?=
 =?iso-8859-1?Q?ytnxY7c/1Ar1WZRIDNgTiyGzQxzyApuci/IqCfmCaygG39gnk4PDfv2tZm?=
 =?iso-8859-1?Q?RQrBrShdbiRUNKXx4M8TTaxfgH1BXAsCc/vgPnLFwW78XC05DhzAt7QVqd?=
 =?iso-8859-1?Q?HZFOuVJBaOWa1df+y61iWec1NZoBbGajnFYYS68HR+n60ODDmVVW7kKlC3?=
 =?iso-8859-1?Q?3d8wweu5HaGtDUA6rDZ6iGkMNNT0vtHk4opPfSQcOpO2efHNjf+cB+fZy8?=
 =?iso-8859-1?Q?wV+yjJ0GJ6UfHDcwdVb5PMJlixxy4Lf6h731Ab2ExBQa7FKyRNg7mOWI2D?=
 =?iso-8859-1?Q?j5oN6dj9hsljPqf/0utVEgkqubTsmNOz1Mw7TgFBgSrI1gbZrc6iDWJaN6?=
 =?iso-8859-1?Q?iIfVDQRa4Xz5Z1zR2v8ktWveAHxUNZYXe0pj8LgozdPCmvotGu4hiC2Xwa?=
 =?iso-8859-1?Q?8chU6yOeTJ3q6UKa55lHpMuck02PL0qhQIqmwJhLyO7ElrOWWYzvnYcnxo?=
 =?iso-8859-1?Q?y2hflgZV3WDxZiAHr7NoPfcgr1XHCwtTDFBf6miSj2rg+vqF83f17m6ni7?=
 =?iso-8859-1?Q?6Or+8QuiLOWWS7E8jz1uX8yBHRaOM6PnpjcmbZHk3umVnV9M2faDSmrFiu?=
 =?iso-8859-1?Q?VLHnFFQYQd54hApWVzVurFf+3J1t0BH0npKBb3CvC1u7LD/5L5HeNEKf15?=
 =?iso-8859-1?Q?WTgw9+J+jIOGoA6k7bc6enlojmEIZT3QgOJMd8G91FnGkB5MTx9HlawSF7?=
 =?iso-8859-1?Q?W0rcuOpPZHwz0qD/BwapfP4aF85RZuKkPgWbnytyajqch594wYvroFzJVS?=
 =?iso-8859-1?Q?S3QHVt3JLfzCRa1xie8/IMMJGA3o/YDfp4X2KxgeYwjDQ0a/n6He7V/HzF?=
 =?iso-8859-1?Q?gmo4BhEF1uPLV+WTN3HrZqLqejdpy8xjaPi0nweJU7FwM9XOEsfUnxCkXK?=
 =?iso-8859-1?Q?o7417WWMk8BouWWIv/9xTa/TILtSVBclTvnMTDB1aoVjzsrAOM9ntYCuyI?=
 =?iso-8859-1?Q?PA8roPAcHvThamOlGdULcmIHoeKfLOUvcLob2pj9pIKbhtey0D1LsQmMFg?=
 =?iso-8859-1?Q?kxIpO4hmhWwUdLXSLUpQZvZthSn+CI7m1P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc801a5-64fc-4712-a935-08dd528c989e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:29:56.7489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLBvqK7YIAQOnfi4vxQz93ft9gYBELMJiMzt/vUajpyG4f45mi1GHVNn1bSG3VrpB/n1BbdLDopLNLOsMD/YNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076

On Fri, Feb 07, 2025 at 06:18:35PM +0200, Ilpo Järvinen wrote:
> PCIe r6.0 added Flit mode that mainly alters HW behavior but some OS
> visible changes are also because of it. The OS visible changes include

The first sentence reads oddly. Maybe a slight change?

"...but there are some OS visible changes because of it."

> differences in the layout of some capabilities and interpretation of
> the TLP headers (in diagnostics situations).
> 
> To be able to determine which mode the PCIe link is using, store the
> Flit Mode Status (PCIe r6.1 sec 7.5.3.20) information in addition to
> the link speed into struct pci_bus in pcie_update_link_speed().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |  5 +++--
>  drivers/pci/pci.c                | 12 ++++++++----
>  drivers/pci/pci.h                |  3 ++-
>  drivers/pci/probe.c              |  5 +++--
>  include/linux/pci.h              |  1 +
>  5 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index bb5a8d9f03ad..10130ac9f979 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -292,7 +292,7 @@ int pciehp_check_link_status(struct controller *ctrl)
>  {
>  	struct pci_dev *pdev = ctrl_dev(ctrl);
>  	bool found;
> -	u16 lnk_status;
> +	u16 lnk_status, linksta2;
>  
>  	if (!pcie_wait_for_link(pdev, true)) {
>  		ctrl_info(ctrl, "Slot(%s): No link\n", slot_name(ctrl));
> @@ -319,7 +319,8 @@ int pciehp_check_link_status(struct controller *ctrl)
>  		return -1;
>  	}
>  
> -	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status);
> +	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &linksta2);
> +	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status, linksta2);
>  
>  	if (!found) {
>  		ctrl_info(ctrl, "Slot(%s): No device found\n",
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..313c66863752 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6190,21 +6190,25 @@ void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
>  	enum pci_bus_speed speed, speed_cap;
>  	struct pci_dev *limiting_dev = NULL;
>  	u32 bw_avail, bw_cap;
> +	char *flit_mode = "";
>  
>  	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
>  	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
>  
> +	if (dev->bus && dev->bus->flit_mode)
> +		flit_mode = ", in Flit mode";
> +
>  	if (bw_avail >= bw_cap && verbose)
> -		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
> +		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)%s\n",
>  			 bw_cap / 1000, bw_cap % 1000,
> -			 pci_speed_string(speed_cap), width_cap);
> +			 pci_speed_string(speed_cap), width_cap, flit_mode);
>  	else if (bw_avail < bw_cap)
> -		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
> +		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)%s\n",
>  			 bw_avail / 1000, bw_avail % 1000,
>  			 pci_speed_string(speed), width,
>  			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
>  			 bw_cap / 1000, bw_cap % 1000,
> -			 pci_speed_string(speed_cap), width_cap);
> +			 pci_speed_string(speed_cap), width_cap, flit_mode);

Does the "Flit mode" message *need* to go into these lines? Could it be
its own message?

 +#include <linux/string_choices.h>

 @@ -6190,21 +6190,25 @@ void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
  	enum pci_bus_speed speed, speed_cap;
  	struct pci_dev *limiting_dev = NULL;
  	u32 bw_avail, bw_cap;
  
  	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
  	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
  
 +	if (dev->bus)
 +		pci_info(dev, "Flit mode: %s\n", str_enabled_disabled(dev->bus->flit_mode);
 +
  	if (bw_avail >= bw_cap && verbose)
 		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)\n",
  			 bw_cap / 1000, bw_cap % 1000,
 			 pci_speed_string(speed_cap), width_cap);
  	else if (bw_avail < bw_cap)
 		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)\n",
  			 bw_avail / 1000, bw_avail % 1000,
  			 pci_speed_string(speed), width,
  			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
  			 bw_cap / 1000, bw_cap % 1000,
 			 pci_speed_string(speed_cap), width_cap);

>  }
>  
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..9c6a4a980678 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -406,9 +406,10 @@ const char *pci_speed_string(enum pci_bus_speed speed);
>  void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
>  void pcie_report_downtraining(struct pci_dev *dev);
>  
> -static inline void __pcie_update_link_speed(struct pci_bus *bus, u16 linksta)
> +static inline void __pcie_update_link_speed(struct pci_bus *bus, u16 linksta, u16 linksta2)
>  {
>  	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
> +	bus->flit_mode = linksta2 & PCI_EXP_LNKSTA2_FLIT;

Can we align on the '='?

Thanks,
Yazen

