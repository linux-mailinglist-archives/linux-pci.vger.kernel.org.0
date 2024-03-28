Return-Path: <linux-pci+bounces-5305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1214388F50D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 03:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355EA1C26A50
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 02:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ED122EED;
	Thu, 28 Mar 2024 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6tTFGfs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393A22618;
	Thu, 28 Mar 2024 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591423; cv=fail; b=hU5u7QzbpWuzuzCwYQuEzMr0RGSdFeTW/a0xv9pPA+lmhEVZk3kMdQYRfp0XIf51sjedMKtZqYDmFJCL57g8kV+e1x2EQHYF35UcQUEPem4CVnZTfnJJFZInwDUT514gLxvayCaSGyC2DQRxlgY+DrOa3LlLDJdz1QHkVz1Baqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591423; c=relaxed/simple;
	bh=Tr+am0yMYP1eMvw38Eiol97Qv11YMC6sJpKWJwkMCc8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TZib8n0mJuxAMZHMHha/tG3A7i5l7D5vZPELxg+xbhqpKy94hhB8FWBlX2Vwn7pVHSiPlHwqq6nwjKCJlpA5KICWLZGYnsdcCCf0GG/RXghIEBFQFFUxZzJF3ZhaXnz3PNxpw5+SZyOE+TNDokrL2tqiddY4xTlaK4jTnXaU7SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6tTFGfs; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711591422; x=1743127422;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tr+am0yMYP1eMvw38Eiol97Qv11YMC6sJpKWJwkMCc8=;
  b=L6tTFGfsOdoQyeHzvgkRAcvWsABnxamvli1OX02yYn7Ll2B3YWu7BPD6
   N2W6HS8y0kpxtqvEHF4BFqhPuEmbnv5BOSVY/WE5diYdCv3FEyTKl168c
   LwzNdpWYh0q5++48d/x3DJoq5rvZtbopOC5j4mYNPYWc37ZhEE8UTyYxt
   4I7T0w1LqXX7aAjgW5hjLgqqYRp6bjmEsdmW8QfctHIEi36R0pn2xRef9
   TjXNSQfH/b0vPWPT9CzhL7YV2a5uROs5NoO6pOrdXVWamKJYqd3VbPklL
   jSYCrUX/avOJtBvrgRXyFZvDUdgybl21COJAYe/2ODRvNFpHHi8TnBjPS
   A==;
X-CSE-ConnectionGUID: 5lSL5z6iRxSjZEHWnYTcTA==
X-CSE-MsgGUID: OA78CwFvRPuBtyinANBdjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6945469"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6945469"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 19:03:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="39614889"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 19:03:41 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 19:03:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 19:03:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 19:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUGfzdzIzWpObNYVaUrq392HhSr8XNxLCwVNmIl+K5pie0jENl8y23OWpBRT5e3RwjecxisD+1pzc8BcWWEfa5GFEz7EB/sIWzfgC7S1Ef0R6cLg5cUxD2H8+mMsERexkkbD+GOgfSFs3bNUGgdYtV+A0zMlafWwvF0pqLpnyyBQO4wMgq3gY3/ayMRuOiVWRsHGHJRU4TG0joW6QyXBT8kceka7dT4c7xE7+JyHAIuGHuYqhxaVpKLIAVM3vZEDYylKh3MumLdB+K6NpnqSoKt5hkoDxOY7Z/DSCHtU/C4BvCZO3GayXRmC00/zTrlO4cPQpKOTHj8/UJukRqaQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsqHWTbSawg3J6KYcWP1BWV+C/NwVhTstM6oCPvQARg=;
 b=Nm839oXRGimAekLpe1Kfa7aXnL+a1+2uyJSsb6R4Q7HYK0oQu/SRfb2pJ9Nbe52srXwoHKGMIqXFG3SF6vgtxvmsbqdK33As0kpwN/nIUjc+/YZGrIgv+nzrT6tBlk3pmmFTIaO7yQJEosjZENsvx3UUI/lVqfoNvJwH2YkjC/6UBPMdDTnygbRo5lTaMRtQImPplyU+Xrp5TBC1siSQcIQTSEE/VV6r1otP4dBw1MjXLIV6v/rZqqQP9n7dM9AOM0eAMJGWHuHi8JvS4nIRkfnu9Qp9O+GHoveQXbBU/H3NtrZD58ifptqZB1HfrL0Qtlc/a9Q/2DYddYF4qv/5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8404.namprd11.prod.outlook.com (2603:10b6:a03:53f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 02:03:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 02:03:38 +0000
Date: Wed, 27 Mar 2024 19:03:36 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>
Subject: RE: [PATCH v2 3/3] cxl: Add post reset warning if reset is detected
 as Secondary Bus Reset (SBR)
Message-ID: <6604cff84ad05_7702a294c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240325235914.1897647-1-dave.jiang@intel.com>
 <20240325235914.1897647-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240325235914.1897647-4-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:303:dc::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d492cc-9bd1-45ca-b495-08dc4ecb48bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwX3XYisNHcJQyrRT79nBELUwWyIztLuGRylNPHf5BPxUcqKqx9PuWTEXhAQCLh7HnBbq0zkpzdzTjwB5WGxSv96ixWPX7XAenQW/FMuChGs0pkHBICKJkEc4ZJP6+Gh4deAzPba8pW6T4tsXMd9G1kBVR74ex6h25JVieD3RLOk2i4k/ZRH/pIylkk2aPVDEs2jp1Toas88dS39/jJtFQ/wyJAx7P/WE/VChl4KAhRs4GVpp+BZH+NsseAmXDak5DNOPt9J+G1Ir8EdWA9sg5tHqpOSeGLvsPDxni6gYnUE4X+ziLLXPGiYZk3YynDvbofUGnzQSoy1cBhWR6bRUwrbD78VOZFog7CCPZwEFxwKCcQt17huEXRe7D72+iwrmaGB3z7WnnwhENnyXv71rDkLhyJpzQPSkiQsshengL73n0AKBg8EW2PzHC2jjJnE98CtL8JC34ZbJ4jmmvaActRzLNiuQ9Fg13sCxj1PpbDNnm2fww66/DGcVSggVylOjkFPxDCRLwv3eHZg44fhs06/ik//Lzf+l4gYzJ4f9jhqq2XGv6rvfQml1BQMtPwWCbJmtocB3xL7MW+6XonZfOmgsjrWaXpwZLTIr0MdqKS8bvjs4mt91CNjzzJNbsrrac8OesToVrqyudW0RSbjv84bZrzyfzeQL7R/npNgg6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x1wLJeJjC9aEJ/Q+DTefkgIKpwL77HZ+KWJ5ZBJIdwyZ6me4sv6h6Tp3CXEF?=
 =?us-ascii?Q?uKXLUUNveRCFykYJ/Aagj6+dAx0AC59TQjfb3Fu2C0zDnGHQ+WEr0LPpbKL8?=
 =?us-ascii?Q?4rRjHLNxBnJoi4nm+S0sARSbrZ51+w8JaM7mBVwWBcTzIzDq3zsmBIFs+ijG?=
 =?us-ascii?Q?0g0Utv74meOVeVVG224sO2zdAGddM+eLeIhHtD0mxSxwuiIf+gEQrgFjRZjA?=
 =?us-ascii?Q?6pQWK7VQfoUN4EKW9N7Am4Twfzm01xCt2Vm9QZ+M028LIg//nDf8YvDRYqAd?=
 =?us-ascii?Q?hSpNZNJzGonn0q5c71uh3YnhaMGd59yeXPJEvOLT5lu+IvM4k5D7ri7KUg/h?=
 =?us-ascii?Q?A8aGcZWQxLnRIPzFagp01RpXou2R2LTS5saXay3y3kbuQhCY+6cErx0Cplcw?=
 =?us-ascii?Q?FP9P+Z3En2+fjlGV2GfO5OrHm2GWfHWdK+FmykDj6kAgWm4buWKHF7o4rfwm?=
 =?us-ascii?Q?vH4BgA1LFVRScfuhkS/3l55pbyfJY7nVYZW485yLCNZShB3aCx5OQfONBqvr?=
 =?us-ascii?Q?XLNNNBUKL1m2D8eTY3dfJF1CEc3U+errts67lpVRcjwaNrfnKauTjU2xhhtJ?=
 =?us-ascii?Q?3SThLwl6jrC5SLaB5i4X+gAqcV4i+nbFOYUo1cOcBqMU4V4il4JzEGzjrJ6t?=
 =?us-ascii?Q?NWNv5+PuOxLfsFQMxO1jfOqLPoWcavAhwIKGSWmmaETS1pjWaDr53hocCHzN?=
 =?us-ascii?Q?sELEa2hVrN+nLR3pwassjiD8cy3EZE2mto7TMOr7HCCdXgT1Z0rtgtsn1UD5?=
 =?us-ascii?Q?64uz2+vnNBUaMtqTHfbJxCmrP+skxxYPOmznqwUlQoWj25Q7oKEdUI5YO4C9?=
 =?us-ascii?Q?Z6zNwA14rd3azAHiXalAH8Yz1R4RkqWliiAC6VI6zuWwK2kw7zbwNv9Bg3fB?=
 =?us-ascii?Q?Tle1JCQm3IXVRFt+huL+wwgSaFxfmsi+Vnytv50uVxJnSvZxsvNkXCh7uzvb?=
 =?us-ascii?Q?v9ONw51dNasaV7epY1BJB4ie2N+PIuZX+waSgUYMGb2jaB/G/GvNu+/mFM3O?=
 =?us-ascii?Q?fM2krxUVmdXCtoGVz3LlcARoZW79osO9vmMfUgl1LYEZC4QjsVEAqoqNNIgV?=
 =?us-ascii?Q?ojr2B88v5NwVe2MnNyFmYjG4VTt3BledLjAQL5mT43ZUBS9bqjS8UiM4jQPh?=
 =?us-ascii?Q?YDMi0JiIZwplIWEmd+iR3/WD1bSj+YZVbGWWk/9VK5TKt4jTN/Pre5xATEB5?=
 =?us-ascii?Q?9VPKS/0gX4EqFWupMr3IeXH9jDFAjt5R6Z3kfuUlD0e+alMpWNGd1xClWPdy?=
 =?us-ascii?Q?brOTjYCPnnaywicyN5HYUpPdXOLfxNedtvCN+kl7vOcyYVvtvErutYEJg806?=
 =?us-ascii?Q?WcReihkXpkc/X1Ocmk9kAVGs6aEqfct07azkrCs32reYaTRrXSql7jN3q8Qf?=
 =?us-ascii?Q?Q58oGeSU9qh7jbzqX0tnuWQj8ItgmPUeAIXio1HU3dyD3f+lYE0qAe+5nwMO?=
 =?us-ascii?Q?8sMq6ucRU1QmtRWmKEwlFw/1I7rE1Q94wDrF2Ja9l23BFnfAYvVklZoBqtqp?=
 =?us-ascii?Q?cCcreaeaCSkewtVwtYR2uuREPAkwk7BkNCx0XmSw8uSueetqvzv9bTvHRMvz?=
 =?us-ascii?Q?pbS/E/nXVgdN6gVFcyHT9X8LudwkqulCP5AMbFZ87PbSt9YCkc7RdinKO3Z2?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d492cc-9bd1-45ca-b495-08dc4ecb48bc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 02:03:38.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+j7RywrQBqe2NC6K6PTqIVPMHJdJMQSsAEHYAQV5tWIUlEHz+T9DcaCAQt3I9jlIXggrvujb5aaLCme0JMBEovXEdKnYYWWCMMzdur4+lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8404
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> SBR is equivalent to a device been hot removed and inserted again. Doing a
> SBR on a CXL type 3 device is problematic if the exported device memory is
> part of system memory that cannot be offlined. The event is equivalent to
> violently ripping out that range of memory from the kernel. While the
> hardware requires the "Unmask SBR" bit set in the Port Control Extensions
> register and the kernel currently does not unmask it, user can unmask
> this bit via setpci or similar tool.
> 
> The driver does not have a way to detect whether a reset coming from the
> PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
> detect is to note if a decoder is marked as enabled in software but the
> decoder control register indicates it's not committed.
> 
> A helper function is added to find discrepancy between the decoder
> software state versus the hardware register state.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Fix typo in commit log
> ---
>  drivers/cxl/core/port.c | 30 ++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  2 ++
>  drivers/cxl/pci.c       | 19 +++++++++++++++++++
>  3 files changed, 51 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 2b0cab556072..e33d047f992b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2222,6 +2222,36 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_get_perf_coordinates, CXL);
>  
> +static int decoder_hw_mismatch(struct device *dev, void *data)

I would just call this __cxl_endpoint_decoder_reset_detected(), which is
clearer.

> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port = data;
> +	struct cxl_decoder *cxld;
> +	struct cxl_hdm *cxlhdm;
> +	void __iomem *hdm;
> +	u32 ctrl;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
> +		return 0;
> +
> +	cxld = &cxled->cxld;
> +	cxlhdm = dev_get_drvdata(&port->dev);
> +	hdm = cxlhdm->regs.hdm_decoder;
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));

There is no register access in cxl/core/port.c that is all handled in
drivers/cxl/core/pci.c. That helps with cxl_test that knows it needs to
intercept drivers/cxl/core/pci.c exports.

> +
> +	return !FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
> +}
> +
> +bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
> +{
> +	return device_for_each_child(&port->dev, port, decoder_hw_mismatch);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
> +
>  /* for user tooling to ensure port disable work has completed */
>  static ssize_t flush_store(const struct bus_type *bus, const char *buf, size_t count)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 534e25e2f0a4..e3c237c50b59 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -895,6 +895,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c1,
>  			     struct access_coordinate *c2);
>  
> +bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 13450e75f5eb..78457542aeec 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -957,11 +957,30 @@ static void cxl_error_resume(struct pci_dev *pdev)
>  		 dev->driver ? "successful" : "failed");
>  }
>  
> +static void cxl_reset_done(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *dev = &pdev->dev;
> +
> +	/*
> +	 * FLR does not expect to touch the HDM decoders and related registers.
> +	 * SBR however will wipe all device configurations.
> +	 * Issue warning if there was active decoder before reset that no
> +	 * longer exists.
> +	 */
> +	if (cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
> +		dev_warn(dev, "SBR happened without memory regions removal.\n");
> +		dev_warn(dev, "System may be unstable if regions hosted system memory.\n");

This should taint the kernel so that any future crash shows that someone
had force reset an active CXL memory configuration.

> +	}
> +}
> +
>  static const struct pci_error_handlers cxl_error_handlers = {
>  	.error_detected	= cxl_error_detected,
>  	.slot_reset	= cxl_slot_reset,
>  	.resume		= cxl_error_resume,
>  	.cor_error_detected	= cxl_cor_error_detected,
> +	.reset_done	= cxl_reset_done,
>  };
>  
>  static struct pci_driver cxl_pci_driver = {
> -- 
> 2.44.0
> 



