Return-Path: <linux-pci+bounces-5978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97B689E4FE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 23:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220AB28201D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 21:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5BA158867;
	Tue,  9 Apr 2024 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YflYaMFf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4B158213;
	Tue,  9 Apr 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698414; cv=fail; b=D39IpNDHbD9sGfEJUQI75cjcVLfKm6B+E416yebGmldSJn3YP4HEM8nGEPfKIoM0sudmZziBaf4/S0iy0De3VrgedwU6umz0pgvzy8s4njP3op+CqF0JHyf0JDG1O6J3phJr6wnCKPrArMThmktStfIjBVCKs16j4p4DUl2GmQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698414; c=relaxed/simple;
	bh=VDjkqrawbe2u8q0F1c9uDKggU5f/g0Z90wWUTmB+FGs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rcQokldAFtnzQqeTkYMllKQZPwmyBbbdz925JHmDCQK95zbacRFKubXilwqXoLZ4U03t+jx6uUSCnhMzQMff4bYqE4G0EffGqLfjGSVHFb7pvngnUdfUm7HA6UkyDs0K8FkragBDwnfNEksTGCcA80Rvdr63VpcW83eRMf8iKnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YflYaMFf; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712698413; x=1744234413;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VDjkqrawbe2u8q0F1c9uDKggU5f/g0Z90wWUTmB+FGs=;
  b=YflYaMFf5Y86lmULT1df6jQgLA8OthqO/LM1AiX/Y4ZtTRXACDIMDjpo
   GaJPwdZ0HaE6GlgmCx+8Xf3cO2owKl08LBxkGa3PZ8/nJ1Pha14qMUn1T
   ILLJ6QGRGbuRLJDpBbUSEmTZzJQ2BLgohxbm1u+vWMJcMVn+zm1H7xR40
   x8ydiFPMYjRuG9ec+ulQndCWu5+wWqspBtN0kg9s+raRtW3F2J8sidb0i
   XHoapMguPe51iFBTEI3mcsejcoHdU68zHqymwj26bSFLIjliL7ywIzV7q
   2CXD3bkKK0spDSFvRil19rDDYew3YT0m6NGcMVH26UccLHlPtUbZm6i+e
   A==;
X-CSE-ConnectionGUID: LONn4MJ5Qxm9wOtpjtLL0g==
X-CSE-MsgGUID: i+gO8PjyQSeeLLpqSluOkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18602493"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18602493"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 14:33:32 -0700
X-CSE-ConnectionGUID: yLnpU6FxTVGbPXY1WL4J5Q==
X-CSE-MsgGUID: GYpHELaqQ8iRnLM6PZFZtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43593833"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 14:33:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 14:33:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 14:33:30 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 14:33:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT5tldm+2ngVPwXxVm0v6FOdlegVOGZB5p+q++NUDyiEsNK+hz4cYWY0q4zPEvrqs8j9hDuF2Jlyjz9UrOt01sWrJ7sjxH+dm9AS5J/R662V884G0Z/3AJqnCmjPAD+TSaFHPjL5BaYQhUzcOL5Kf8J97Ebxd5wpqskAx/DSYkVCfOT5znFD8MxiUXUz7XeP03PX2pSdl8x1SRAgiJPgIzcxjesmO0QQtcPf7I3tYqzv0y4hR83BpA8huj/1sQ8VTZ/vA9v/rHTCneu/qNI5elh3ohS+jxtNSnBGPyMbt/MFolvFbI4yQ5AWOH6MssCbJX9SFn1DpX0JJvJz14X9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m5mXAgmhqItU0eQxq/XMnAR3LPeAC/QyrlGPe5g+Dk=;
 b=UeBJbnNVswicPoTfI2KfmV20jigcfIvZb+Oh2Kw+CKQU1dtjwjg09Pzhen9CS9t13b2OUb0HvD1X9IYMpLjx4ZjcTKL8PR4piJF0VW5qpDDMqXZeARvifMSr9dxIpft3WfO1BX2LWHAeMYz7cs834AYak8WI9Wc4XYP76Sewog3CSkN713HZS7DSneWerYoEqv1I0/tT/tMqhnAFRMvInaQMwsfgPkE1I/bnH2XCQcvMPyxSYB9vshyq14Oo3WrPZhpFsCmW1ioxJpjHfpnYZaXlLWl7vvAUOs8P9F+quluXbELjNuSJCC38SGSLhisKOd1fLOrx71A0FVS2ol9q7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6561.namprd11.prod.outlook.com (2603:10b6:510:1c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Tue, 9 Apr
 2024 21:33:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Tue, 9 Apr 2024
 21:33:27 +0000
Date: Tue, 9 Apr 2024 14:33:24 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	<kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>
CC: <y-goto@fujitsu.com>, <linux-pci@vger.kernel.org>, <mj@ucw.cz>,
	<dan.j.williams@intel.com>, "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: RE: [PATCH v4 3/3] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Message-ID: <6615b424e055f_2583ad2945c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240409073528.13214-1-kobayashi.da-06@fujitsu.com>
 <20240409073528.13214-4-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240409073528.13214-4-kobayashi.da-06@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:303:b5::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6561:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tz2MhjKZ9gkHpazm0ALjeBi3WvZqq1Q9K3NCw5Ga2CfcQ+RNQc0wbSr7BY6z5WNc5KgDt2BYFVksSFF69DytdIbPxN5X5VI8R2Z6b1/xjDlBOcjjtUIJKF36Nb+5Az0m84rSbt7rBO1U/FvAIoeUslNvRKzKlL3O7w+xO5lrJbr4AvkIBzETs2L1plWoS/2nO8Xr6fG42oKha/h7yzSHmj0UsJGhcEeQoQ3KjBEKRvTUXejNZy9BBpDW7CSLu8KfEPe7n8+9gBtC/5JhQE5vINs7LUf3dmc8tNyjrP8l7oAsU+Ybvt8LX5aaSJedZ3uNFDrxKlNKhTtxXDJ6mEd24Vncp+7VmwveJcG8VKHtwBixYv+3lrk8R/06uUlsLpWY+bIxF/m3tXxiDigGatYUXgzxqat0OU9C8FQ5X8RaLL2Nopbr5DiN4/ApnfISrncXOx3GjFLZET79NlWKFDRshRRrihJwXyun4iHqszZJhsQ/B/WVOF4/bP6eTGMtC6RMG+OW9pIwA+VGmgJabdR8idq0ndhuCLDsbWhjtaPSNDnusPyfv52nc6Qn3Vy5+IzDH7FiGHla7j8oD99GSH1kkFpStQOXFbR7x6mRnOBh5t1ETQZsfP8NPG0pxdLGcfOeZLQY3fezEzXu91vfxmePh7DZeo6yJmkcfRrtBvLnbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PtoY9Cair7oW7Fk2BhoH86GeWl1I1QcplkmnrflZh0soFhUsquPs3QCjvzRB?=
 =?us-ascii?Q?ixRD6s45n3mqStVCH4VAcasRelePm+cjCuMTQszXGisnjz+DwRNByWOSPqI3?=
 =?us-ascii?Q?x3NJWrDrOsbL9p3KvXwY3h2VXbJP3FobgnBfhYQksAWYrp5TT0/3KRzdjjV8?=
 =?us-ascii?Q?CLblOL4hW1vtVJc3mckGybPuQ3coyc9YLEyfeL3a4rwzfEtBWvLJ/PtLZPsk?=
 =?us-ascii?Q?pl/+EAfUh0cbKiHFrHeCxmPliMuLjf9k2K/v0zO2SEzdtB7VtYMrnUit44MB?=
 =?us-ascii?Q?V+lrb/sA8dHqgf5RDyEGsN1wQI3zn4EFB8fy3QEUwUrX8EwRJcKCArzbGNnO?=
 =?us-ascii?Q?Ej1CCDSx2KlAwGOKPXZF4TUemdC4UxVwncxAhfEY1DJCOLJQ0V/MT1lmcSSD?=
 =?us-ascii?Q?KQF/dE/em/0bQU9Bf7ggdTgP/M2XBHoitPnxJ0foLIALU6t1HvBfwbcL/IZg?=
 =?us-ascii?Q?7BscGbIKeav4wcoVamnJ20dIBGuM4VKTlSnR/VD3JidoVYwHur2PBoQZVazJ?=
 =?us-ascii?Q?SSg5dB2lFct+XDZatsQztVzi0SJUdCn6sm5sn3ZNH7OHZrRm7pVno3DaXxXG?=
 =?us-ascii?Q?w3hqbtbUTW9u0u2ba5mbvTdP9rGTx687VoG/hOd3Uxhqp1hmm8sa+Rbmxs1D?=
 =?us-ascii?Q?GxHh7qTT7D2WMyPysysZVzdyUtal+qjsx5WsNEElF/TDaoLWaF+tuuK+4lS7?=
 =?us-ascii?Q?6drAhcFLy52XPULn3diMwbczIRFAtEtCygeEqwn+Y73DdrFsIHIo4+ejaAer?=
 =?us-ascii?Q?qEjfyOf+CD5Sp042bqI1pr5CirClwCjEB4lfXs9A45LLp3M1RGYVAzn5u5WE?=
 =?us-ascii?Q?V1KsFKqiiDR1sDj6mB9ttTHFYGN7yS+YMAF/sq522KRKzp5ns/sS7Y1+sAPJ?=
 =?us-ascii?Q?ikTG1ilq+L43x0UbJaNuDiR7kJTwPHWpkHDAjrOtydk5GtCIjoQsra+ql1/4?=
 =?us-ascii?Q?y6fw3hPuxNgsoLBz6CHcgPD7nIrTVg5s4mRBDkQx3B2lfC9tpnUFPOHbfvZM?=
 =?us-ascii?Q?QFcjouUWGsmpeUV1zs7XtuPMqHQjegYI8L3fsyLRfPBLorLcWRuoFQXcr+hN?=
 =?us-ascii?Q?uiY+/2+aLz2UP4n/jJhBdcjzObu7YhuNzAB9RXKPUCtsjnF4GeVO285pnlF8?=
 =?us-ascii?Q?fHFQ08IJmBFwED495b3AAlg8Be4G9zcEwuQKLlhNTD85Btk70Edn57uhsyVu?=
 =?us-ascii?Q?D/XkbePILAczuGxTr4DFUjarRDeyps+stYEPbhJV8DFEFHmNOz9s3ImrHe/k?=
 =?us-ascii?Q?i8WEtlOOx8xSh98rDl944XxqwgUFb0hkfZ/Z4hz2dYZ9CiFoN40fee3wsSSt?=
 =?us-ascii?Q?v/lIUGWA7v1l32fqOlQuFLDqWKuvtUMy33AHdg5eocTcHNZgpebRnRwVfEpR?=
 =?us-ascii?Q?ATXCaWc5FAm/k3riGINZHoQv6BLZJttZgI0czN0N1mJyEI8SBlsrC+6AAJUl?=
 =?us-ascii?Q?O9VXmfr7ymZqFl5y3lGrJDjOAn+IShobgqYydZD1FUNk84YWG4wsIGt2ZEqG?=
 =?us-ascii?Q?EK/M7qwPF97xBy1DOgIwsn6rl0qE9m/Z7jCMGleb3FQt08ZLMIeu6+7+C4F+?=
 =?us-ascii?Q?tHb2gAQBke4H20xFO+Q+pPdWldMOMALKPXSRsFaIgW3nGs35VcIdAlKvlfDz?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 312e7b33-7794-4ad9-ce50-08dc58dcb16f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 21:33:27.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Srwrxh6YVg2QONqUWoHycn/Onn4WF2o1oCk60uPG1AngxtJvxiJYlxAYn0174Mmqe9vtyfghNC9/N2+MOr1fnbFbbNOpLVBfHV0ULenFmcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6561
X-OriginatorOrg: intel.com

Kobayashi,Daisuke wrote:
> Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.
> 
> In CXL1.1, the link status of the device is included in the RCRB mapped to
> the memory mapped register area. Critically, that arrangement makes the link
> status and control registers invisible to existing PCI user tooling.
> 
> Export those registers via sysfs with the expectation that PCI user
> tooling will alternatively look for these sysfs files when attempting to
> access to these CXL 1.1 endpoints registers.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  drivers/cxl/pci.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..0ff15738b1ba 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -786,6 +786,79 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	return 0;
>  }
>  
> +static ssize_t rcd_link_cap_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	struct device *parent = dev->parent;
> +	struct pci_dev *parent_pdev = to_pci_dev(parent);
> +
> +	port = cxl_pci_find_port(parent_pdev, &dport);
> +	if (!port)
> +		return -EINVAL;

A few problems with this:

1/ No need to convert to the parent PCI device when there is a lookup
routine to go from cxl_memdev to its upstream port.

        struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
        struct cxl_memdev *cxlmd = cxlds->cxlmd;

2/ The port reference is leaked Add a put_cxl_port() __free() routine
like this:

	diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
	index 534e25e2f0a4..d81bc4cc0a4c 100644
	--- a/drivers/cxl/cxl.h
	+++ b/drivers/cxl/cxl.h
	@@ -744,6 +744,7 @@ DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
	 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
	 void cxl_bus_rescan(void);
	 void cxl_bus_drain(void);
	+DEFINE_FREE(put_cxl_port, struct cxl_port *, if (_T) put_cxl_port(_T))
	 struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
	                                   struct cxl_dport **dport);
	 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
	
...and then:

	struct cxl_port *port __free(put_cxl_port) = cxl_mem_find_port(cxlmd, &dport);

3/ The port corresponding to a memdev can disappear at any time so you
need to do the same validation the cxl_mem_probe() does to keep the port
active during the register access:

	guard(device)(&port->dev);
	if (!port->dev.driver)
		return -ENXIO;

...then you can read from the cached PCIe capability similar to how the
error handler path reads from aer_cap.

