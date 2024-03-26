Return-Path: <linux-pci+bounces-5201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD188CD8F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 20:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD931C343CB
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 19:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAD3200CB;
	Tue, 26 Mar 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neJFKBjz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED2E481A3;
	Tue, 26 Mar 2024 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482740; cv=fail; b=k/L9FpywrawllisrpqBO66p+xZ5xVlibNYqE0kjG7Na4eMIZVfkfc81KBZbWtMlIkxZ7g1EXEyb/lV0zTtGT7EOp3XtFjVQQSW+LnOX6zr2K82UDQe/JsCx1KDoy/M+oQg1JzEpKFWvAJZR89s+MgRjCdXsTl+SMAUqwC78MDVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482740; c=relaxed/simple;
	bh=OzUHoaNvyI63joNRmXlymN3gSDUA7aJLswaLaeeFv8g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X6aSgck0dalb9VMN/iFj4SUcWE+8HExk72UWMrbhC48LfvRx5jVQ2wZjN45l4MtuDUqZgui9N+F11+6Z63fVkJvkPHk09cW6BGnR9Rlunt3UJR6/v52Cpnxywbz35NtI+DRdzEclt9xuxtLa79Foe8AHy8blQkfBsDU0hWN/O+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neJFKBjz; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711482739; x=1743018739;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OzUHoaNvyI63joNRmXlymN3gSDUA7aJLswaLaeeFv8g=;
  b=neJFKBjzNVNlNIH9jUMkxe5v1NQxcWzRbpbanLBtl11dVe//H64LxVha
   gOY8+MiqGrfrGayButZd+6L6d5pNGt5tR9Fy1eJ5nNlLnBX3czKP0N4Wq
   PwnuMRdawIrRLq3LlklG6yMS8+UvskrTiy/J4BOHIIFagOLTzQgHwZl+j
   hHiHuEYlvTknV+mQUqBvRsKI1Bt5GfbI8hpY+n/0Mxt5+4Zvqf6GmyDit
   ivpPrM/D0cOR5qYCBptS5GrIcyoxuWSxj63ob8RtE8DrMpQ2swUrX3sEQ
   8LoOO/rPRtwZeuVJiXuw91vWzXt3Xjztgz3CfC2w+5Pl+88S4Bb4pUxnS
   A==;
X-CSE-ConnectionGUID: np7AV6h9SRSw69Rz4I6hzA==
X-CSE-MsgGUID: I9WNGAS+T/eCzh4fkO5Bfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17699802"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17699802"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 12:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15915581"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 12:52:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 12:52:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 12:52:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 12:52:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ignQWj9FDmQDF13hjOwSrAtMiOkD/bfiEZuoZ+iFAr0rrIGglWaGA1fO8m6shvIwCfvMCTdH6XDbRhupAxUv/gyNIToeRR59c0XRkvx/ZStAXitKYCT7ovweDRS2NexB/Y93dry5i0xJUsf3xeq8eKtAc46jMWCeVz95H8Ck3zKknnNG/5cAyfON4NmgchTD2jJRwLPc0BFurnkrug2gqLyeUboR0rCrPN5EKo8iqdjewVXklusa+I24sP9EmNkYFvM5m5rB2ndYg9UC8M1j/pdiY5HOmnt/Tcefwx9MbLnMccX5A7+nJBmTapdwsTzn6jsg5tyFU1gbtRvqxoMmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ijnd1CzUd29eN6wDqMVJrpHmdRvycB4YtgtKSgxLt4=;
 b=SvNksmdv4rqDhS/MTYNAZVhDTwJ3y8cUVViDyq3FBfXLPuQpLb6UvJxjChpEJBu1KQjUqG0rNrWfzmUXSWBDvwOinohzrif2Gv9HZ6jmM0ngbSqhT+rkAkmNWilKEwOBspeE3kNMyC0araEiUJEmEZtofziZ+Bz45oZl2eQnITHUvjKp2BnTw1tpz83QwkqY81ofG83gkan7XgkA2zK+To9kIcTN0ugLuPuYZThAj3j99gjQgspV6B51FkLHSSmMr/Zaz9U45vlIlCvqnjr19A5ZX/VNtrGhpfzgr0T/vwUhOYtvZSEmrPhIkG8ZHVaEFaq2KdmhGHGN58oBIXz3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6958.namprd11.prod.outlook.com (2603:10b6:303:229::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 19:52:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 19:52:01 +0000
Date: Tue, 26 Mar 2024 12:51:59 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	<kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>
CC: <y-goto@fujitsu.com>, <linux-pci@vger.kernel.org>, <mj@ucw.cz>,
	<dan.j.williams@intel.com>, "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: Re: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link status
Message-ID: <6603275faabc_4a98a29470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-2-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240312080559.14904-2-kobayashi.da-06@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:303:b7::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6958:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHjS+qAr7C7AaWOrzweLU1Qytc7OEgdwy4EwItk7A1xJNK16/yHo+LCZFkLhudJfW4boCT/gzIhK9QMV+4+KEPkmsovz8QeNzqmM8vpnAeNd3+aK1J74MUDHIH5Hsgg/fYwpAWc23b+mpCBF3C1N0AfaU9uu3D5IaRFUt85pGZKoL4xotpuzoEY19dl4c5ql1zYacXkPA3tcEqwba+ZpTkIZv84wdzmbniaHsgmFb1gKyc3zL7oP+LA7AMf5Yvy8M7tzcZ/O2cyiE++8RizwGNby3OHu3zqUDXNYzMzClDLhka3yNPKvF4QG+Vzk3EcefPROZu568pVc6g0JDES2qULs5dsrXtDp1+J8boPuK3HE9k6v+L3slj4J0tOw4ysmIJZ/AlqBk6AGppC/gyIqtHWYXU3h1E4WL1lYV3XU3JiOOCOcaQSz+tJDTYmfErH4BM8h2JrkREuEknxiNmMxqxNbe5tEQx+cMhzwMv7Sv981xKcRrzn1VLZBw7E3luoD38DUH6jy8AyrRB353iyQaVPWphF+UX5y21X+DDYhRBS7VlniKnCF+LHVc7MSaFnL5uwCoHmBrvzVnHSQaVPX0oJLy3QaHhTlR8OyWmjcuBOSpMWyR2k17i9kBLk1Hs8pwFr8k+2GKessKx7X4T+ALAdjwj3LYA3Cp+K3oIYu78Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vu1bZns79FuTnwD4O8glST2fUA5x0YnlmFUXI+1irFQMv9fauJ+zibdSGwFP?=
 =?us-ascii?Q?yF/9CPQoxkHzeqe1ZiICBmjBos6fkdYtwDe2Pk+6VDxWYRnpqj6KjhsLOYj5?=
 =?us-ascii?Q?jwlP60J9RpF3y0BxBn6KVLG09zDuy7fPRggDpdvpYMLWTTcSKUcOPWvaH+9h?=
 =?us-ascii?Q?3VNs6OlqJitsofarlYOzeovgyM8k6uOTeVEJH9nRhOpbwywHzCqVEJAL7BnW?=
 =?us-ascii?Q?y55/QWlBTlKiScXfm9kYarwMprIRlIXU7hEMioribB0zs3tFUOuLf9Ij9L2X?=
 =?us-ascii?Q?be+ecFs3RvlDmdV6wVrTkNrM2fXgnZH/gY/hcRioLD9Zf1wXc/5WbyxnxFf3?=
 =?us-ascii?Q?JyQTPeMXXDPzvBy7f0Nib01G1aEx6n1UOgOugItKwK7tFI80hdjmqVZfKhUL?=
 =?us-ascii?Q?FVVE3LZmkzx2WbDGx75lJzqVOVXsNO7UQ7oGLWEWBx5bv8b4P59eYKSijFNP?=
 =?us-ascii?Q?hFayUtb+4iqnjSF9Ga0MpPAPRIGzs1NL257H/+sfu7mn0bwUbxYkHiwDzDnX?=
 =?us-ascii?Q?FddYOa5HjmKAPSJMExjqClCs/W5wbvfG7pPaetQH6TjmHmllvR8SxNrkbACK?=
 =?us-ascii?Q?tiqakYdehl+6n+f3h+3riIWjL3yaDTsfTNk88Cko40J/dpRvkzTgftdRFjUz?=
 =?us-ascii?Q?V5L8L4SBY26oCuGlvhrhiKXroGjOnmqBfooyA/8XzkVejdclRQj7bR8dTgvi?=
 =?us-ascii?Q?x2qKHwYbiWYZ4MPqc+7QvUL2s271QI/dLEkiQ9JkTRkDnVe+I44BV+8l/wop?=
 =?us-ascii?Q?7qC/0dpPrP6uiTkj7A2QA4lWvxKV7Vb9oDeOi4tFSV/9JjQ21IRdm5tGg+Gj?=
 =?us-ascii?Q?GaWWLBpuQ3w5VCHWVap4KygBfgZ2EH1N2KNcjhgHVS3RnHuH2GSwsDtcL2sv?=
 =?us-ascii?Q?sXaxpXsGkJHEsofVbmAp2cwDWS3Rc6hyIpXp7UkyAZvtinnfvFP/qG9ReZjR?=
 =?us-ascii?Q?f2tFgQKdjMmaQ0ZeShxJhsIJXBozZsEYHYRjFXS+9+TkQEu1wysPr91VLVrC?=
 =?us-ascii?Q?zJOmZItH9h/Tyy54FpShjuIhSS3BspyN7915zCqcJSB33FLS3zeHmJowXB9E?=
 =?us-ascii?Q?JjKG6KsK1aQJgoVmUuoxxonk0Aq7NJlzOBGStdSNu+6h+MBUc3wFRS0nj100?=
 =?us-ascii?Q?/o2wVwlICZNwazjziY48fUMpSTgblr01I9VfzUpKDka2V/TjogfF7PKf3OiL?=
 =?us-ascii?Q?D3UbVY7yS7WzKSAxSEpjkwdm82b0x/RGOgS7oo6Q5NuzmeXqtaHudit0vdYq?=
 =?us-ascii?Q?CgdyA9zD493+mXn7WpzDOrCiude/KCDvRAxWx/Qsb+gxSVWA0aJvgXsZFDXz?=
 =?us-ascii?Q?bht+oknt8hLjbq9pWO0KPVo6gupe4WvxyWhS2F2y/UCJtwB1giob2sjNkNk6?=
 =?us-ascii?Q?MorlM4nPZGoiqxQSxqQp8psOmtBFtpGQk6V7MfvMA2IrDL1Iz8NIjyfjVodC?=
 =?us-ascii?Q?qbMiVfYqpy422T+8N6mmcZGjhq6804CdJwab2/I/xjJgRjItV5fdopxUPTc+?=
 =?us-ascii?Q?gzfbOUqR0gAcpuJXLWCA53rEkGZ8mtghoavGDRLHetgAf7QyDqQ+YkkEYLIH?=
 =?us-ascii?Q?DKCUA6qEIxKnTUXXTRG94FDi045RgtlrsoN0tVlemDoQ3L32dAc3l8aBgJgP?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 151da974-d2bd-4333-46cb-08dc4dce3446
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 19:52:01.7513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xbzIeEAdJyHdoUIR3lDoG9COflCSbApA3XMc15IUN+AowaXsBoceHScdbf4u9Y+wFyYDmskUUrsvLDO99UgO8ImUI81iefUehVlMC8SN8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6958
X-OriginatorOrg: intel.com

Kobayashi,Daisuke wrote:
> This patch implements a process to output the link status information 
> of the CXL1.1 device to sysfs. The values of the registers related to 
> the link status are outputted into three separate files.
> 
> In CXL1.1, the link status of the device is included in the RCRB mapped to
> the memory mapped register area. This function accesses the address where
> the device's RCRB is mapped.

Per the comments on the cover letter I would rewrite this as:

---
In CXL1.1, the link status of the device is included in the RCRB mapped to
the memory mapped register area. Critically, that arrangement makes the link
status and control registers invisible to existing PCI user tooling.

Export those registers via sysfs with the expectation that PCI user
tooling will alternatively look for these sysfs files when attempting to
access these registers on CXL 1.1 endpoints.
---

> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  drivers/cxl/pci.c | 193 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 193 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4fd1f207c84e..8f66f80a7bdc 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -781,6 +781,195 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	return 0;
>  }
>  
> +static u8 cxl_rcrb_get_pcie_cap_offset(void __iomem *addr){
> +	u8 offset;
> +	u32 cap_hdr;
> +
> +	offset = readb(addr + PCI_CAPABILITY_LIST);
> +	cap_hdr = readl(addr + offset);
> +	while ((cap_hdr & 0x000000ff) != PCI_CAP_ID_EXP) {
> +		offset = (cap_hdr >> 8) & 0x000000ff;
> +		if (offset == 0) // End of capability list
> +			return 0;
> +		cap_hdr = readl(addr + offset);
> +	}
> +	return offset;

The location is static, so there should be no need to lookup the
location every time the sysfs attribute is accessed. I also think the
values are static unless the link is reset. So my expectation is that
these register values can just be read once and cached.

Likely the best place to do this is inside __rcrb_to_component(). That
routine already has the RCRB mapped and can be refactored to collect the
the link status registers. Something like, rename __rcrb_to_component()
to __rcrb_to_regs() and then have it fill in an updated cxl_rcrb_info():

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 534e25e2f0a4..16c7472877b7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -651,7 +651,12 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
 
 struct cxl_rcrb_info {
        resource_size_t base;
+       resource_size_t component_reg;
+       resource_size_t rcd_component_reg;
        u16 aer_cap;
+       u16 rcd_lnkctrl;
+       u16 rcd_lnkstatus;
+       u32 rcd_lnkcap;
 };
 
 /**

> +
> +}
> +
> +static u32 cxl_rcrb_to_linkcap(struct device *dev, resource_size_t rcrb)
> +{
> +	void __iomem *addr;
> +	u8 offset;
> +	u32 linkcap;
> +
> +	if (WARN_ON_ONCE(rcrb == CXL_RESOURCE_NONE))
> +		return 0;

Why is this a WARN_ON_ONCE()? In other words the caller should know
ahead of time whether it has a valid RCRB base or not.

...oh, I see this is copying cxl_rcrb_to_aer(). I think that
WARN_ON_ONCE() in that function is bogus as well.


> +	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
> +		return 0;

This is awkward because it may collide with usages of the RCRB, so that
is another reason to cache the values.

> +
> +	addr = ioremap(rcrb, SZ_4K);
> +	if (!addr)
> +		goto out;
> +
> +	offset = cxl_rcrb_get_pcie_cap_offset(addr);
> +	if (offset)
> +		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
> +	else
> +		goto out;
> +
> +	linkcap = readl(addr + offset + PCI_EXP_LNKCAP);
> +	iounmap(addr);
> +out:
> +	release_mem_region(rcrb, SZ_4K);
> +
> +	return linkcap;
> +}
> +
> +static ssize_t rcd_link_cap_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	struct device *parent = dev->parent;
> +	struct pci_dev *parent_pdev = to_pci_dev(parent);
> +	u32 linkcap;
> +
> +	port = cxl_pci_find_port(parent_pdev, &dport);
> +	if (!port)
> +		return -EINVAL;
> +
> +	linkcap = cxl_rcrb_to_linkcap(dev, dport->rcrb.base + SZ_4K);
> +	return sysfs_emit(buf, "%x\n", linkcap);

This and the other ones should be using "%#x\n" so that the format of
the number base is included.

> +}
> +static DEVICE_ATTR_RO(rcd_link_cap);
> +
> +static u16 cxl_rcrb_to_linkctr(struct device *dev, resource_size_t rcrb)
> +{
> +	void __iomem *addr;
> +	u8 offset;
> +	u16 linkctrl;
> +
> +	if (WARN_ON_ONCE(rcrb == CXL_RESOURCE_NONE))
> +		return 0;
> +
> +	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
> +		return 0;

...the other benefit of centralizing this code is that we do not end up
with multiple copies of similar, but slightly different code.

> +
> +	addr = ioremap(rcrb, SZ_4K);
> +	if (!addr)
> +		goto out;
> +
> +	offset = cxl_rcrb_get_pcie_cap_offset(addr);
> +	if (offset)
> +		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
> +	else
> +		goto out;
> +
> +	linkctrl = readw(addr + offset + PCI_EXP_LNKCTL);
> +	iounmap(addr);
> +out:
> +	release_mem_region(rcrb, SZ_4K);
> +
> +	return linkctrl;
> +}
> +
> +static ssize_t rcd_link_ctrl_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	struct device *parent = dev->parent;
> +	struct pci_dev *parent_pdev = to_pci_dev(parent);
> +	u16 linkctrl;
> +
> +	port = cxl_pci_find_port(parent_pdev, &dport);
> +	if (!port)
> +		return -EINVAL;
> +
> +
> +	linkctrl = cxl_rcrb_to_linkctr(dev, dport->rcrb.base + SZ_4K);
> +
> +	return sysfs_emit(buf, "%x\n", linkctrl);
> +}
> +static DEVICE_ATTR_RO(rcd_link_ctrl);
> +
> +static u16 cxl_rcrb_to_linkstatus(struct device *dev, resource_size_t rcrb)
> +{
> +	void __iomem *addr;
> +	u8 offset;
> +	u16 linksta;
> +
> +	if (WARN_ON_ONCE(rcrb == CXL_RESOURCE_NONE))
> +		return 0;
> +
> +	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
> +		return 0;
> +
> +	addr = ioremap(rcrb, SZ_4K);
> +	if (!addr)
> +		goto out;
> +
> +	offset = cxl_rcrb_get_pcie_cap_offset(addr);
> +	if (offset)
> +		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
> +	else
> +		goto out;
> +
> +	linksta = readw(addr + offset + PCI_EXP_LNKSTA);
> +	iounmap(addr);
> +out:
> +	release_mem_region(rcrb, SZ_4K);
> +
> +	return linksta;
> +}
> +
> +static ssize_t rcd_link_status_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	struct device *parent = dev->parent;
> +	struct pci_dev *parent_pdev = to_pci_dev(parent);
> +	u16 linkstatus;
> +
> +	port = cxl_pci_find_port(parent_pdev, &dport);
> +	if (!port)
> +		return -EINVAL;
> +
> +	linkstatus = cxl_rcrb_to_linkstatus(dev, dport->rcrb.base + SZ_4K);
> +
> +	return sysfs_emit(buf, "%x\n", linkstatus);
> +}
> +static DEVICE_ATTR_RO(rcd_link_status);
> +
> +static struct attribute *cxl_rcd_attrs[] = {
> +		&dev_attr_rcd_link_cap.attr,
> +		&dev_attr_rcd_link_ctrl.attr,
> +		&dev_attr_rcd_link_status.attr,
> +		NULL
> +};
> +
> +static umode_t cxl_rcd_visible(struct kobject *kobj,
> +					  struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (is_cxl_restricted(pdev))
> +		return a->mode;
> +
> +	return 0;
> +}
> +
> +static struct attribute_group cxl_rcd_group = {
> +		.attrs = cxl_rcd_attrs,
> +		.is_visible = cxl_rcd_visible,
> +};
> +
> +__ATTRIBUTE_GROUPS(cxl_rcd);
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -806,6 +995,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(mds))
>  		return PTR_ERR(mds);
>  	cxlds = &mds->cxlds;
> +	device_create_file(&pdev->dev, &dev_attr_rcd_link_cap);
> +	device_create_file(&pdev->dev, &dev_attr_rcd_link_ctrl);
> +	device_create_file(&pdev->dev, &dev_attr_rcd_link_status);

No need to manually call device_create_file() when the attribute group
is already registered below. I am surprised you did not get duplicate
sysfs file warnings when registering these files twice.

>  	pci_set_drvdata(pdev, cxlds);
>  
>  	cxlds->rcd = is_cxl_restricted(pdev);
> @@ -967,6 +1159,7 @@ static struct pci_driver cxl_pci_driver = {
>  	.err_handler		= &cxl_error_handlers,
>  	.driver	= {
>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
> +		.dev_groups	= cxl_rcd_groups,
>  	},
>  };
>  
> -- 
> 2.43.0
> 
> 



