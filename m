Return-Path: <linux-pci+bounces-5304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1214888F4ED
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 02:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034741C246D5
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 01:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFC322323;
	Thu, 28 Mar 2024 01:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYm1KcCu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA68F6B;
	Thu, 28 Mar 2024 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590808; cv=fail; b=T5ENFbgCaRHa2tva1l/7EGG1RJvvuH/l4eMkk/xm/lR9SI4CoSlrL4Zq6WhbqGrkj9uMNnrB5HpLkhA8/WcSqLNEQ+RQo5L5CkpRqQ/XT0aN7t0DX/YRDYpZ4FV0hrUdY6n/V//F5cxTgxEWeF/cz0vgrlR0xbcUWoP0RMGTm70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590808; c=relaxed/simple;
	bh=Yj4w7FkcgwSxKuUSS31l9A0BP9ygXTe9k8pszijXuyY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=egCmAcDnkaSlL1wg63TJjn4qiLlL+b/D/OB4nFHzVLrNxLF3T5HYDS01HD3vlEkaod/dWRueLe8MaABuxz7Zrhlv/7mMOAO1+fpuB+g8pgiilyhvA2nTPhoLtWJ8ekUPI8+sFc2BXm1sezAfkkYhQJtMDoG2cxL9xVuGTusxDCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYm1KcCu; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711590807; x=1743126807;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Yj4w7FkcgwSxKuUSS31l9A0BP9ygXTe9k8pszijXuyY=;
  b=MYm1KcCuceexcYl9ycvHL1NaqOkpC6jeYD390naQh3/s6G7JVTg3gmLe
   cQjOwfib9gcxIezeb9miYDycg41SX73T1ModPHY6RTORSfUMohM1LbTQe
   60GQ8WuioNWodRMSV4ksJF58I13rvy5rBR4dshw+fHWLVR9gQZT3WE0C8
   ekr5pLc6iGtJyuIbEeI7s+0hF6eq4hyjd02Jz3oLcIXVr0nGoFQinEtnO
   1Wo/kxCXPXiKd92tXDo3uTSMWsPG+N+6Red4G0txi0KtFR417GV4GziXJ
   EErhokIshaYBM54sBsjMgODDsdGSP3hW6tw9sU5VKviRtzXcWOjohEvNk
   A==;
X-CSE-ConnectionGUID: RttNQCciRj2rEpEw0eX4HQ==
X-CSE-MsgGUID: KirEQBL6Rx2z5VpjqRUxIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6587348"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6587348"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 18:53:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21002695"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 18:53:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 18:53:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 18:53:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 18:53:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 18:53:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzQ4P/t+IyzZpptoiMx5tMu5AMfY0M9nBCvvaZT/qbCi9Y9fmegtcf6npxlDyvDwqa9b+3CNIi2tzr56ZexVnRPkiAJsu28pNko/q4sMasUlo+LlcwBf14gJGhrtR22f3MZJh3WB6ll00yGE9+0tRkCZhM3LxlByaOzuGKbjqEeWzFwPSIBdRHCTuujQLU5PrTaOHbdhb1Hlb9gPVc/u4RWuFixvCe3tAnlsCAyVY5yaslASx9KkLmQMvhWHTbnL9HeuItztitYVUkkp+6XPmlgpjHVt5gD+CKJo6PcIQwT3pcKyWDp9EdCfzSvNSEt6HGjU3VYEJDAz8J4xOrkk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFjPbPAk5/dy4Z5yPvMxt5X+TGRAUt8TVKFTOgTajbw=;
 b=b84QFyGCXml0qi+ZCqsZyRxDQHUE89IayqbUCSoJioVaSnFfIzHtiTjNgmvPRqde1x710LuxRwEcOFVa/TCFuMJfLdd6dqA5N6FH2ulYXUDtQpjSarnD3nGQjJYYANNPMb5GZEw/6Cg0yN1UD3Yd7aWNt/+O5kiRv/yCir/SMG+1yZKUz+8xGZd9yGAeBFQm6cBXDRzO0QOUYd89rbpfjTGDKi8MhdMguVczHA5e4kT1xts9rvQjJLJXGjFqvPaemUw14HqaqVcbe4kWcIvqV/7dh7Ztxh6p2xyr2UFvaWK6pzyFey9dyHzbkzA5miOsKvxNWaISLToijAIk4zBcmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4593.namprd11.prod.outlook.com (2603:10b6:5:2a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 01:53:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 01:53:22 +0000
Date: Wed, 27 Mar 2024 18:53:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>
Subject: RE: [PATCH v2 2/3] PCI: Create new reset method to force SBR for CXL
Message-ID: <6604cd8fddef5_7702a294c4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240325235914.1897647-1-dave.jiang@intel.com>
 <20240325235914.1897647-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240325235914.1897647-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0356.namprd04.prod.outlook.com
 (2603:10b6:303:8a::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4593:EE_
X-MS-Office365-Filtering-Correlation-Id: 7810491b-246f-4ef7-d8fd-08dc4ec9d95d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbWBbYAzyi4pHVAMBx/UaDcEVBDsHqNCIHuitfLK+9AzCK4XjjGlVWN28/XU3ls9JYb/IZ3kwSunkBOUtFL7bz7o5Biq87YJ8OWHAuqPltASgNxfMi7PduNBAU1w6bdTagiAfFKP7qX7HAxKnFJaOnWOuKJIaj+psyqb7o0QrNMH5q+dGdYZnh3TTko7Fsys+KHW/twfclN9rz368CsRoKNkQ9gKqa/sv+SF+2T4Bvf6qy3TeAtriHJ2irQVzXXgrXrpVevsvojgqG+fYpxYeizT5Qfv2xeQw34LJAmZNO7Vf2dhungxLBxzdM6snOCpXSKyziCBltntVj6MQBn3j6/vG6HiGqBS47haBPTAbwHCzoKzaRjKP1zS/eUXKKhwc/J5bEiIfRud5myVTBbFvKSODrdHklhR6pJmxPdD/EVAxuTeDAkEgrnvPNC3frwG2jTLdPmIqwmtCWBzO6s57r8PuxYrJUwM10f/XtofbLMjw7Mgs6fa0WnWxji8tqxJDz8GOMSeJZ0KemAU1OsqCI0cvxx4qDu1q9gh72LCWXcZhBv3Ju5Ey4I9QG+wFCGV5ugW2xgTgBCYfTo7f2ynlA2KmVdHW6fvQ2m9dcLfoxyJ2QTGnUmKOp3K5f8NS2OA+aJz9evkbk8hcftD7IzBfcfEeuD4w2IsowixWgdMasg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MBBAPXELTfjmeXZFUSNh/x79qvo0rRslfKGNAn1WLKgADSZsS+T4xF1DVKsd?=
 =?us-ascii?Q?f+Yb0cZyXwblSJG6GWuUxjYiKvD9S7Y1h4Ot6jT/e+9AmfBBl460fJG2qOLO?=
 =?us-ascii?Q?Tjvz/+mSvC2Q1VPeg8/39MbBo5QNdcr6ZNx8mJTtndX+kyJ6f9fZPZTVC3hp?=
 =?us-ascii?Q?e8FyOVxWBIifA7pYIJpIwpDXHYwtymFpwe6EiFP3kcJeMUWW820wQv9Lng3D?=
 =?us-ascii?Q?vGBGkZGaiR/rhMBzHKuKvIFw4X/+sw2a7JhBIrfvY1N2lNKlcyrpvRhylJ8S?=
 =?us-ascii?Q?Ci4i0lekK66+/VureD8GqCvX8eBa+cubLELNrbLJ2Ameamb9zK4k/ZsbzfkQ?=
 =?us-ascii?Q?Z08a4zGd7nimCx5EiAbOudmdkM6laMXm/HJLMnerOIWbNw/ustGsXGXhDOxO?=
 =?us-ascii?Q?2lOtO3/yA2BI6paQ15ITiCkAPeSbx/BPfOymwlCKOli6qldZ2QW+xgL/hrOR?=
 =?us-ascii?Q?GlGw0fvwbk+f7nF0NTx19OnqjMzoHUjmamMrl2uvcY26AO+N+8DgsKbkTdoc?=
 =?us-ascii?Q?3Xy5PPLusU0KLeAPRWw9vUhWa0QgNuwZUXS97FHId5cxHAz5buqFD5BVqTUT?=
 =?us-ascii?Q?eCoyP8kTEbuNN89V/puNRUH7LRGY85vJ8fJLspuXa4pIce4sSEOmfYTmxraG?=
 =?us-ascii?Q?jab3IHoICfzUJi3CzeXr+ldDQlX/Z5aQE+W07uo9J+aiMVfsJjPWEFkTCSs9?=
 =?us-ascii?Q?LshAwNj/5JGomftdVeDsK8ar1x9vhqLxqxktbnZWolm5Y8n2mqHNOrmum42w?=
 =?us-ascii?Q?3C1yffTcObciIySXvXvUcLYJ68ZrmDVlu1jUqA6mH0Dux25x1Na4gRFw+mpJ?=
 =?us-ascii?Q?OmiQBUeNKk++I8zl+89DdNHKK0oOJl8iTOT7iX8aiiCdi3v3IHGuLdYvbawe?=
 =?us-ascii?Q?aeXnX4I+V9k3gct1oKQno9rVo1a6g/PNzj4c2dl5dymoZ91odNa+Cv0rDGKb?=
 =?us-ascii?Q?CEijkGUZqIZPeqIjkMms+2nUNotRNwzDeSIAvpI8kRz4YYZlL6vdyR5FDRc8?=
 =?us-ascii?Q?9+0QvWY90TcdaT1Rfp+OnAqoMpH9E9op2IzAyXaXFjk4BmgYDht3t22j6dIv?=
 =?us-ascii?Q?Q+0CF8JQVaxlW4zc/hNFeRDWgQpeguVSpvl8zsuoaxta8n9pHfciTd3IRdkm?=
 =?us-ascii?Q?ThLBZvzYuBiyf4lbCX9VvqLPuV+Rt1q5kAGVLZY38OZNRIgxKnKTgVCzViTK?=
 =?us-ascii?Q?x0EotI8FbsZ5D03OHRFvNB4iZtqHujNc34CWO8YCGvTmO8V26hBSrI2/5K4X?=
 =?us-ascii?Q?6nm/9qHjX79EcLPFLBZfPytOwqhBHNGthYitdMdRfXxa4Y+R0l0VGLx+VTY+?=
 =?us-ascii?Q?3LL+K720RiBS8uSf0hr2mPw8KAqPgacEdN0v8lbfbMusc+KtiWmigobbhjLB?=
 =?us-ascii?Q?sP7A5NRMteUKPPYqAytUyvmrJmgnKPvgCqazBooi0yet8xfOcxXrkD1wAQi6?=
 =?us-ascii?Q?aQrtDIPxqEE5E+z/oHfyVebgu/MkN8XZlYg/RZsOTOIljqKZup/YEK6LDn7U?=
 =?us-ascii?Q?TqXxCUIjY5U0b6vm56TOE6kKXfFvgk6vsCzv1qsK7DG1uxfzaA0umibKrjoc?=
 =?us-ascii?Q?N3/Rnvp4pWTEj3MZFcAEADNbjkb1NxtMEhHEYBXd8ta8cOENKhXwLOvKqJgy?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7810491b-246f-4ef7-d8fd-08dc4ec9d95d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 01:53:22.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76Wf3tqfecJoJmHKvud3RpHQxKV5OflLFbjBJDtvH/xI46/B7bEZswCywfCRsl+SGasVWgp8SlcCqLObx6ljkynrEm8w0E+sw0idebALhs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4593
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> CXL spec r3.1 8.1.5.2
> By default Secondary Bus Reset (SBR) is masked for CXL ports. Introduce a
> new PCI reset method "cxl_bus_force" to force SBR on CXL ports by setting
> the unmask SBR bit in the CXL DVSEC port control register before performing
> the bus reset and restore the original value of the bit post reset. The
> new reset method allows the user to intentionally perform SBR on a CXL
> device without needing to set the "Unmask SBR" bit via a user tool.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Use pci_upstream_bridge() instead of dev->bus->self.
> - Return -ENOTTY as error for reset function
> ---
>  drivers/pci/pci.c   | 52 +++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/pci.h |  2 +-
>  2 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 259e5d6538bb..cbcad8f0880d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4933,6 +4933,12 @@ static bool pci_is_cxl(struct pci_dev *dev)
>  					 CXL_DVSEC_PCIE_DEVICE);
>  }
>  
> +static int cxl_port_dvsec(struct pci_dev *dev)
> +{
> +	return pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
> +					 CXL_DVSEC_PCIE_PORT);
> +}
> +
>  static bool is_cxl_port_sbr_masked(struct pci_dev *dev)
>  {
>  	int dvsec;
> @@ -4942,8 +4948,7 @@ static bool is_cxl_port_sbr_masked(struct pci_dev *dev)
>  	/*
>  	 * No DVSEC found, must not be CXL port.
>  	 */
> -	dvsec = pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
> -					  CXL_DVSEC_PCIE_PORT);

Once applied, those 2 lines had a very short life in mainline. Perhaps
just define cxl_port_dvsec() in patch1?

> +	dvsec = cxl_port_dvsec(dev);
>  	if (!dvsec)
>  		return false;
>  
> @@ -4982,6 +4987,48 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	return pci_parent_bus_reset(dev, probe);
>  }
>  
> +static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
> +{
> +	struct pci_dev *bridge;
> +	int dvsec;
> +	int rc;
> +	u16 reg, val;
> +
> +	if (!pci_is_cxl(dev))
> +		return -ENOTTY;
> +
> +	bridge = pci_upstream_bridge(dev);
> +	if (!bridge)
> +		return -ENOTTY;
> +
> +	dvsec = cxl_port_dvsec(bridge);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	rc = pci_read_config_word(bridge, dvsec + CXL_DVSEC_PORT_CONTROL,
> +				  &reg);
> +	if (rc)
> +		return -ENOTTY;
> +
> +	if (!(reg & CXL_DVSEC_PORT_CONTROL_UNMASK_SBR)) {
> +		val = reg | CXL_DVSEC_PORT_CONTROL_UNMASK_SBR;
> +		pci_write_config_word(bridge,
> +				      dvsec + CXL_DVSEC_PORT_CONTROL, val);
> +	} else {
> +		val = reg;
> +	}
> +
> +	rc = pci_reset_bus_function(dev, probe);
> +
> +	if (reg != val)
> +		pci_write_config_word(bridge, dvsec + CXL_DVSEC_PORT_CONTROL, reg);

Doesn't this whole sequence need to be wrapped in pci_cfg_access_lock()?
Otherwise userspace can get confused if it races to access
CXL_DVSEC_PCIE_PORT while the link is down, or if it races to write
Unmask SBR and messes up the saved value.

I took a quick look and did not see this lock taken from
reset_method_store().

> +
> +	return rc;
> +}
> +
>  void pci_dev_lock(struct pci_dev *dev)
>  {
>  	/* block PM suspend, driver probe, etc. */
> @@ -5066,6 +5113,7 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ pci_af_flr, .name = "af_flr" },
>  	{ pci_pm_reset, .name = "pm" },
>  	{ pci_reset_bus_function, .name = "bus" },
> +	{ cxl_reset_bus_function, .name = "cxl_bus_force" },

Why include "_force" in the name? "cxl_bus" already implies "do what is
needed to bus reset this CXL link".

