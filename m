Return-Path: <linux-pci+bounces-4357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4264086EE1C
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 03:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D032866A0
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 02:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585836FCA;
	Sat,  2 Mar 2024 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0lrIZ9U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377047483;
	Sat,  2 Mar 2024 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709346144; cv=fail; b=d218NqeYxfv42qri1A61qYmLur6D8Wx3JnidExhCGPr1ogn9ec1QOBFDABjTxEb0YZuwKGxclAD5QmhKs59IGn9fOwEP8qELfOrgRvC9h+gdP8ggKwRjCxUWoi5Q1ER2ZZYdOwmUhZtKdRSlyrh7xemhIfowTMsHgSqFZyI7idc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709346144; c=relaxed/simple;
	bh=tLC8zPR1vzWsLCvaflGBnyS4vUO4CDCpXXIi1GjermU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mNJ95OtTXQxoYa8pW3WDuOfLh/2nMKop43GAMg3mkULBu7C/X9F4AZ1MXRDNhJP1RbUm6CHm5EGcjV9CCQoxQo8zvaacJtsSLSa1YQb7rmtvyquYHLIm4qRnXOgyRSy/ayOUeRusnfo+L2rnHOAbO3hMOsvA3ItaQ1fGFiF90l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0lrIZ9U; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709346142; x=1740882142;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=tLC8zPR1vzWsLCvaflGBnyS4vUO4CDCpXXIi1GjermU=;
  b=a0lrIZ9UL/bckNuaZbrXE9NL1Xhwf48aTgXfNHBbftiJlfrXk79zmViA
   MKS5MJuy/7g7MxbQPCPjJs0/aL31x0HjOLdYm+zE1gPb4v6PUgot69mMH
   Vn2XHbgbU5KSDnA6oJ+CiSKrqt8tDQu/I4UdTqio6EqkEm98Ziz+SU1wl
   9Uw/pZX16uJtkgW2LCMgMAsLUOK/xI8Fonxhg7aLgg9Tcw4GAiBTybfSx
   i3BYnae/4k3qbxWEMGiDiH/6RPJKKpLPva1FGeJkkN2bswW3k4VOZ2XlN
   sdlyaaMDS6PaFYbZdgYhippwgrka3Y2Hxdtp5Put0uJCNBAej3R6e9k0G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="6853595"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="6853595"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 18:22:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8935608"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 18:22:21 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 18:22:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 18:22:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 18:22:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pq9eHMlNdMnQ+2jmzEtU1J58/U6Jo/bClRiUEur706V1a+Pi5UxaXShjbYWOkK3HOin6/MaZCTqGHTkpEaP5feTCKghsLCC39Qt8GMODwqTvY26mrZQ2GMiqUOfzTau5+BvrHGZMQVgBkiqrDQpCPKdiBko22pYxdkQex3fceetUoSqv//K35EAajGrJLYDLl/uuBHhgnev2zT9bzDYBwfGkRMMiQkT2foAq6hYCuYQlFHRNIAsKbVV7fyUJbBrc44QnHZp0BRu+Xqadg9HnDiaH1Am5GGuN7HbdJ+mGzXAcfG517jIOIT9gIUU3ASghELYV6iv0ZGfJvrYTzgv2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdDRi1jt1Wm+OQHFV58D+2584Za7+vkOHaZhjRpYWSc=;
 b=e9Tsu2iPAtCucUb5D3Zaekiw8pLBwhaMWWpbQCjudGWkpndTrViCaubRLHK7udeuxvkgjI+N62eEk2GHgKxZGb6haDQbWOT02U6odrxjPoi1CnlHYIkG+y+ON57Hm1bYZ2MLbHBRWh539aibJ8zf5mzZJjRFmxYop1NoMCjVKnEM+jH9WZ0Pclvxy9oJuC6I7briNHLZaclpCTprN0sG0nNlkL07M0RZrm55hJjWAU3Ft73Jj93rQLqXlr+6x57zyx0DcoI07yn/UlddgJrHvOAvEF3WuHD1YOYEmuNEShp74AqIW6LVGLjRPHrbYxvamQkEvRwoxz732sBNC0qrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8303.namprd11.prod.outlook.com (2603:10b6:208:487::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.14; Sat, 2 Mar
 2024 02:22:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Sat, 2 Mar 2024
 02:22:17 +0000
Date: Fri, 1 Mar 2024 18:22:15 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>, "'Bjorn
 Helgaas'" <helgaas@kernel.org>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mj@ucw.cz" <mj@ucw.cz>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: [RFC PATCH v2 1/3] Add sysfs attribute for CXL 1.1 device link
 status
Message-ID: <65e28d5793f3d_1138c729471@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240227083313.87699-2-kobayashi.da-06@fujitsu.com>
 <20240227164339.GA239446@bhelgaas>
 <OSAPR01MB718293579603A52D4D0F9CF4BA582@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSAPR01MB718293579603A52D4D0F9CF4BA582@OSAPR01MB7182.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:303:8f::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd02486-6960-4100-7952-08dc3a5f9500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqw9LNDdss/UJZTogVqhxVGHPVG7RFU8tN3FtxLyi4gf7rerVI8z8K6BLUUTEIy6UVeQyc32RWA9u4/3NkYxfm/J92ejIfqaa+0RiN1QGZbjExvfh7vfxoihUyDo3xjfKp6ti/i2v0w/5qiazpiwVOYeHtctmVo2U78pkI5k9sX5wJ39N2KhVX/L0ISdAZNn0n3cG+XSSW5S+wcSpEW82C9KkWLop0ugGiv2cUMD3Bi63nPbg20na3pIKaETfhnuPAe2dSTONjxiGW/lU0/n33hz+sQI8HxH5GRRBDy9jHMuEnZl8ODSafbc2pS4aQj983d8y/mPr8OdYdcOucnEtDOTqYdrerDNTM3o/JrBedqnE9tI2wWF82eseZOhfddvsq3qXGEC5n6d4hHVyUFbmHf4BjwyW5RYjfDQKdnF37QN7G9UCwp8ymTeqVOmAdjVPwsq2T9M+2Jm+H/yOLEGYTdZFXIssezxT7mx6vDF65qU6xZkwYJX3TVqi0mDgg6zY+KRfBAtmnpmG2UAzIxIWuZ4/UY/xeq+fYDcqmIWo+OIEbDbhI4mMKU7GbU5MC4UelVkaulqgoLnap8UrK8Rr9CejMy0tGKJKuYhDbayZuTqwfrIyfhdDDXS34A7e8hPPR/cW5sEypHzWOKVx8SUaGTr/gJQnEigHM8F/lF2Sb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzVoaE1LdVdVWmJWQi9QRDNLemV4aVdCTUpUTUFZZkkrZTVGT3FsbzBzZExM?=
 =?utf-8?B?ZHJxSnlCT3F0NHZiUGJyWjBZTXkvcGsrNE0zU0txU3I4ekhXb2xnL0VYUzBx?=
 =?utf-8?B?VWZIQTNvRzBpcTZ4MlpoR0QxRlhzNWJ1UFI2RlhJZXk4UUJ1cnJ4K0ZMRml4?=
 =?utf-8?B?RE16dERvQmhIVjhnV2txRVR4Y2w4Rndra0k5RWhZenFQTHZ1aWpCMStMcksy?=
 =?utf-8?B?UU9IZXVCRzB2QUR1czdFMnREUVRVUkdIWmcrZk1LN1BZT2RWNm51M0JON1p0?=
 =?utf-8?B?MG5UbnZTRStza29qUW5LZFlJdXBlOWFuZk4vQ3Rkc1VLUE05c29VYUtsN3JU?=
 =?utf-8?B?VjVIZC83RXEyQnIvazVzYk9ZdENxZDQwZ0pmU1FZWWJ2Ym1qcjcyWGpJK1hh?=
 =?utf-8?B?SlVibjRMUXMyVUNmcEtUNWIvTy96c2hWK1k2clRsMFBYQmtGQlcxU2htbGFi?=
 =?utf-8?B?OHE3c0hFa2ZkNnBUMlRGcHpRRjZFK1QzM3pRWEh1T2NRUVI5SmlpNHBHZHVr?=
 =?utf-8?B?c1hpc1owU2NneWE0MFV6SnF2dVgwRVdxNnQ4K3JaYWxVbWRwejI3T0c5TmZR?=
 =?utf-8?B?dG9qUGFvMlh5NVJKWHNVcnV1QlFodzBibHlZdk1WY3ltTVZueVUzajcyK3Rm?=
 =?utf-8?B?M2M4M3RFRVFoYi9icktPb3JDTXhpbnZhcnVrVWNiVEg2bE1JOVVXbUJMcTBU?=
 =?utf-8?B?TFNkQWZSemloL0tIM3JRVTdTK0pIR29YNVV2dGVIOFBuMDlxN1A5Tks1K24r?=
 =?utf-8?B?VXlWNXlxNHdSbW5JM1p1Y1lYVmwzMHE4dEhIeUJ1MFR3T2NrTlduVE1DUE1C?=
 =?utf-8?B?d1p6aGRyTDdoUUJ0dmpjS3I0d0tzdjlYdnNEWTk1clFKMFI0eVI5bitMVGJK?=
 =?utf-8?B?UlNvTUhEenR2UloveGREUmt4emM2MUR3K3JudDZTc0JNa2U0UmJpZVFhNWlp?=
 =?utf-8?B?eHRRVjdkbjRFdHZHR0ZVQy9mRDcwYWhGd1NYZjgzK0M1YUJrcnh3TGMwOU1m?=
 =?utf-8?B?bXpxQ2RsVUNTUFFxcW4rU3VRS1FiSzc5RitTTnFqMzRmaEtnNEQyNUVCOEM0?=
 =?utf-8?B?NzMzV2J2UFNCam5iT2F4dTFwem1MMkxVVDNMc3J2Y1h1YXAwOWw5a3dyWDhZ?=
 =?utf-8?B?YXlOcC81TkcwSmp4angyUENDWGI1aEVOMFh0YlZVS01GVFg4a1kzNHdqZ3hz?=
 =?utf-8?B?TTlpcWtkWUR4c3pBYWV6b0FkUG5SeUljRS9COW9pQ1JsTW91VEJLcmtaS09m?=
 =?utf-8?B?NDVzUEx0UjBFN0lrb0N2NXZpUUlqb0JmSXZRenpFakR5ZlIxZWtyN0N0MWJS?=
 =?utf-8?B?WXQ1UGJESFZGTlFQRGFrblFzNk9ISFllekc2R2IxaG1LYkxNekl6MzZZbXd6?=
 =?utf-8?B?bWtIZVZNSmQ3bGprRktnYjQyNW9EUmMwRmszemxSRFNsbjZtU1hnTkQ3VUZZ?=
 =?utf-8?B?eWJvdmxzelU4N09GT3JNSVl5K1hHdDR3eHNXRjUyUVYrWW5yemhrNTFEMzY1?=
 =?utf-8?B?WmxjcUZVYXZjM3JpRHZOdzRIbm1vdjlSUFIrNTFPVEtJRHVXNnZqTkJzNUtS?=
 =?utf-8?B?YUlLNjZtZFlvSVVaN0FNdDRRYTZiTEltbTRSZXN4SW01OFNQbWV3V0wyMzJT?=
 =?utf-8?B?c2RONmdzMk05NndnUzEwa29LWld1M3FhaHdlMnhaZkZoZnVCS2hBYnQ4UVVB?=
 =?utf-8?B?Wll4ajg3NFJScWZFU25yYVVuSVFzUDY5RmFMSmJBa1ozM3dBeVJVaFhSMVhx?=
 =?utf-8?B?dHNkS2JvbmI0YnRWRmJlcUxJeDB6SkNOSmM4M0duNzFKT0F0Uzl1WnhVaU9n?=
 =?utf-8?B?TjRoRUI2cXdOQzdyMEJnQTZZaWI3R0dhS09QeUFqaWkvVEQwbDVDMElpM2dl?=
 =?utf-8?B?Q0hHK0FQWkJQbjVkWkdkeFVGTEJSZzBMazlhNGtrMzhyazRONXNmUmFXT3dO?=
 =?utf-8?B?WXI0R3dHekVTcWpaZXZnc1NsK24zTGxXcjNzYzd2TGc3ODFteVNSaEZPYVlV?=
 =?utf-8?B?dnA5TzE0SHkzUHZMMEJRTDFRWGc1MVE0VkF3Q2lWRXhJMzIrWDgzT0lja1lm?=
 =?utf-8?B?TThBUmxob2lpdnlwSXhCdmNsYkY3dFpSWDgyUzU4Z3JYUXpPUjJ5U0dIL2lr?=
 =?utf-8?B?M3NXOVRUS1l2RHBXallVZUpkOUlpRXdqZkVxSWQwa21aTGJjR1JDUWxVU1oy?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd02486-6960-4100-7952-08dc3a5f9500
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 02:22:17.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYBOjBc4FLdh7sIclFKGh3IHBRb/y+8cltDoJJDVYI1grUU203s9ptkr9oFVT9lVecE5vodObt8lVotggIoMJBK2vlX+9WEb8EmXBENFJLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8303
X-OriginatorOrg: intel.com

Daisuke Kobayashi (Fujitsu) wrote:
> 
> 
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Wednesday, February 28, 2024 1:44 AM
> > To: Kobayashi, Daisuke/小林 大介 <kobayashi.da-06@fujitsu.com>
> > Cc: Kobayashi, Daisuke/小林 大介 <kobayashi.da-06@fujitsu.com>;
> > linux-cxl@vger.kernel.org; Gotou, Yasunori/五島 康文 <y-goto@fujitsu.com>;
> > linux-pci@vger.kernel.org; mj@ucw.cz; dan.j.williams@intel.com
> > Subject: Re: [RFC PATCH v2 1/3] Add sysfs attribute for CXL 1.1 device link
> > status
> > 
> > On Tue, Feb 27, 2024 at 05:33:11PM +0900, Kobayashi,Daisuke wrote:
> > > This patch implements a process to output the link status information
> > > of the CXL1.1 device to sysfs. The values of the registers related to
> > > the link status are outputted into three separate files.
> > 
> > > +static u32 cxl_rcrb_to_linkcap(struct device *dev, resource_size_t rcrb)
> > > +{
> > > +	void __iomem *addr;
> > > +	u8 offset = 0;
> > 
> > Unnecessary initialization.  Also, readw() returns u16.
> > 
> > > +	u32 cap_hdr;
> > > +	u32 linkcap = 0;
> > 
> > Ditto.
> > 
> 
> Thank you, I will fix them.
> 
> > > +
> > > +	if (WARN_ON_ONCE(rcrb == CXL_RESOURCE_NONE))
> > > +		return 0;
> > > +
> > > +	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
> > > +		return 0;
> > > +
> > > +	addr = ioremap(rcrb, SZ_4K);
> > > +	if (!addr)
> > > +		goto out;
> > > +
> > > +	offset = readw(addr + PCI_CAPABILITY_LIST);
> > > +	offset = offset & 0x00ff;
> > > +	cap_hdr = readl(addr + offset);
> > > +	while ((cap_hdr & 0x000000ff) != PCI_CAP_ID_EXP) {
> > > +		offset = (cap_hdr >> 8) & 0x000000ff;
> > > +		if (!offset)
> > > +			break;
> > > +		cap_hdr = readl(addr + offset);
> > > +	}
> > 
> > Hmmm, it's a shame we have to reimplement pci_find_capability() here.
> > I see the problem though -- pci_find_capability() does config reads
> > and this is in MMIO space, not config space.
> > 
> > But you need this several times, so maybe a helper function would
> > still be useful so you don't have to repeat the code.
> >
> 
> I'll take your suggestion and create a helper function.

There is already a cxl_rcrb_to_aer() in the CXL core, I would recommend
just converting that function to one that take a capability id.

[..]
> > > @@ -806,6 +1003,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const
> > struct pci_device_id *id)
> > >  	if (IS_ERR(mds))
> > >  		return PTR_ERR(mds);
> > >  	cxlds = &mds->cxlds;
> > > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_cap);
> > > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_ctrl);
> > > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_status);
> > 
> > Is there a removal issue here?  What if "pdev" is removed?  Or what if
> > this module is unloaded?  Do these sysfs files get cleaned up
> > automagically somehow?
> > 
> > Bjorn
> 
> Thank you, I overlooked my consideration of the removal issue.
> I will check current code and add a cleanup process.
> 

No, the proper way to register sysfs attributes already includes cleanup
tied to the device lifetime. Since these can only show up once the driver
is loaded they are so-called driver "dev_groups" attributes. The way to
declare them is something like this (UNTESTED!):

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..c8535078c74f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -964,6 +964,30 @@ static const struct pci_error_handlers cxl_error_handlers = {
        .cor_error_detected     = cxl_cor_error_detected,
 };
 
+static umode_t cxl_rcd_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+       struct device *dev = kobj_to_dev(kobj);
+       struct pci_dev *pdev = to_pci_dev(dev);
+
+       if (!is_cxl_restricted(pdev))
+               return 0;
+       return a->mode;
+}
+
+static struct attribute *cxl_rcd_attrs[] = {
+       &dev_attr_rcd_link_cap,
+       &dev_attr_rcd_link_ctrl,
+       &dev_attr_rcd_link_status,
+       NULL,
+};
+
+static struct attribute_group cxl_rcd_group = {
+       .attrs = cxl_rcd_attrs,
+       .is_visible = cxl_rcd_visible,
+};
+
+__ATTRIBUTE_GROUPS(cxl_rcd);
+
 static struct pci_driver cxl_pci_driver = {
        .name                   = KBUILD_MODNAME,
        .id_table               = cxl_mem_pci_tbl,
@@ -971,6 +995,7 @@ static struct pci_driver cxl_pci_driver = {
        .err_handler            = &cxl_error_handlers,
        .driver = {
                .probe_type     = PROBE_PREFER_ASYNCHRONOUS,
+               .dev_groups     = &cxl_rcd_groups,
        },
 };
 

