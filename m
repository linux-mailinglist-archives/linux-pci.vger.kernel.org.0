Return-Path: <linux-pci+bounces-16005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AC39BC053
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 22:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F1B282B3B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 21:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F0C1925B0;
	Mon,  4 Nov 2024 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfuqUMU7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130318E04E;
	Mon,  4 Nov 2024 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757025; cv=fail; b=gVoKcVqQsV00eGAnXNS/idh1l99exhdw/ud4VJAbK4L5HHeepBC85wYASih5uERZeZhsMnPgA17J+gv76fNWOuIi83EA58xvYIWQU+7rxMty8uIsFzuC3LCE11JTGf25+TRfHDPJUlzWsLpsg88erJF9Qf2JxIUmN4J+WbQdxwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757025; c=relaxed/simple;
	bh=jmMqO9MvMPfZ8kIggObDdwiNwR50JXyLevJ+gUugEMY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gar2MK1TBXpzxDAvZJyDWevP7rKlPUV3ujSafYhrTlmGtOs/Bikl6vm7/do4NEUIwu92NbQ2AJisOUHCScFj75MEz02St4lL2vc7eDXarl4M0SkT5jifl4jUifrZMhH0Fo2gOXtcQrYdBUTIkT5fHXUl7CSFPr48zm9Fk9osg1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfuqUMU7; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730757023; x=1762293023;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jmMqO9MvMPfZ8kIggObDdwiNwR50JXyLevJ+gUugEMY=;
  b=IfuqUMU7PG4+IxF/UE4lMof2Dfr7yvrJ7l+vXfacz/RRlHzanIKzCLqy
   J1G2t9441PlI8MBFUPtTeL+rsslN98lrDxLgdbw2H0T+vtNlmDWmbpFnr
   DURON7L83l50mUUd6OOD6j9bRz4u1hYbwL4DhzKwaMKLlDIVnQ9G4N3p2
   0lk4GU3oTdtIhu5mInhZL1+3jodKsO4cMlCG2h5nXDP0B3mA5qUin1y7U
   VkKYy/mu7t+Xf3i2jIPPOJLVKIMu7D3F9RCI/kJ7juhVDRwjOVwpTQixN
   z6Hv5UVz4tU3t1agdmrOKfmwdPgZStfqUZpaux65Y/iFsPZCbELCQYybc
   g==;
X-CSE-ConnectionGUID: /BXiFRlvQYuEzYF6jwdK9w==
X-CSE-MsgGUID: vcMNsMnsTDOXCn1Qsy7Fgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47942738"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47942738"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 13:50:22 -0800
X-CSE-ConnectionGUID: j8bqeUZfTeqnpVZrfUCH0A==
X-CSE-MsgGUID: /2n1gjogRWeK2lG5nKBGsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="83900979"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 13:50:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 13:50:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 13:50:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 13:50:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFBENX9KIgJvv2hoY2W+pqEkH+VLeuBnufpeEKnE4aybNsvrDVZMtpEDmSZBJD7SApmAEx+xJQuak7if81V8nHuy8it6m5EdRvM3mWZ8Abmr/kQ9ftX0FeJZDLVATmdY75X1feBy0UcGqGAuO4pP6Vp4IEJAPVt0JORoXnGQlSgvbh7ekLaglfFiPDyj3UG2cTBiQnErPBQVyPIOGDASTGLW5BaXlpP5iXzEM8h2vVmmbIS5O9Bx2alOllnVgg/mp0WPqPvOohk44jr+90gyl14q9q81Qkb96o/kzlsZqMUOvKwifJPEt8Dx7gKL3eTokArR//ljlLrNqrL2AJa/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02imvvOhNjnDgY0c/F5ljAY09Ib6vOVmGjfCnGM5a3c=;
 b=WvBVR0jvHj5G8BltMte/p6oKl/Mbm8BRTkMpoXCmSGFmLmLCuwDip35A9bvnX8NEsGS+IGCaVpNgm/Wg/+vbuK1tHmQdrEX4RJMa3ookA14jiX5FV+Kr2OnyG+3ImaivzF214ZKW1IiPq100lJyCZNpoPNft27PGivFRvDxQCtSfibPdBmldGisw3N5KoNwDI9huw1mREU0BRhDKlj0hC03Z3xXCL/OLjGpc+y7ROvlHdGOeCYZ7o6+AHMb1J6OUoamc6kKtqb9BjCPdX/2oF/BKDJFk9tDieJp89wRIF62bBp6GGmJ/dOA/VM9L5K2QgSm+I3h4aq3DAQOdGjp8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 21:50:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 21:50:13 +0000
Date: Mon, 4 Nov 2024 13:50:10 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman
	<terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 05/14] PCI/AER: Add CXL PCIe port correctable error
 support in AER service driver
Message-ID: <672941925f59d_2ce729465@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-6-terry.bowman@amd.com>
 <20241030151308.000005d5@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241030151308.000005d5@Huawei.com>
X-ClientProxiedBy: MW4P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 623e305c-5b77-45b2-ce82-08dcfd1aa97b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qL9j0s2wFAavU2vZZ4U+/QYTZTdlrzWM0OgiwYxse9Lk5hI0/fSEfu1lw4hk?=
 =?us-ascii?Q?NZTJRcZXTT0DkcGnuVyTVIobz+pVl2u/EpD2iLKusJj0yCCasC4DTPykyl8k?=
 =?us-ascii?Q?Ezc6uJygHQQkVMnnCEIh1M4saP0OdB9LDn/sWN22avuORRbDcb38jfUOrzWs?=
 =?us-ascii?Q?rqjPY8nBbtrxZjASIWOdl1vwcGn6C0K+F7AT2KomywGcv1VYqleAR9/eRCFq?=
 =?us-ascii?Q?rUooV3p/AX+UVzRTCBpZn6YDhAdYHD7yEcvkVJeuJYMJqqEHPHcOXsRd9pVB?=
 =?us-ascii?Q?y/4Ma4aVdS2zedjSMoQGCGIjOLG1r3pa2I3CIewJ/7Dk3cfX12tzjqQjQ05y?=
 =?us-ascii?Q?AFhiQzMnLT0wpHZd67PwspjPLFdM25ftojN2i9hJgu3FGO1hIGAVBI/iaGW+?=
 =?us-ascii?Q?7D9kKV8N5TUR08nH08DwW4Yhz+HXkxDQ7dDqj57A7x3wNkH1YxFYq/p37zx9?=
 =?us-ascii?Q?n6HcwuPIq8qcIcSOETqClgdEGWVGVDbK+sZsYEbgi9hxj4VY77Rh0Qz6Vkg9?=
 =?us-ascii?Q?RA5tlWgDnvQga3w+35nDR8c+WLazgZal/57J9KBBY8zqDjTDJ0ndyUo9/ei8?=
 =?us-ascii?Q?fnh3DLEZF/ByP9xvEv87jUAwGTNUBEPt7naAsFdRwt6BQBlSf3NE9ewQceKX?=
 =?us-ascii?Q?4QzLhSIVMhKgAjS4/Hh+vayT/Mq5nG74E3LxnGPrbXn/vlYQctZXKtPjBQ+p?=
 =?us-ascii?Q?uy/tN0xczOOrVcaj+Pb5rpg11OFXJeQkbtud/B6m5HUeXGpxkHl6SCvcoxFC?=
 =?us-ascii?Q?OM0c+kKszVMJDcHAaJpbcbYDAjKWZwwtsQ4ZEo40vlZq49TWpsXf69mEhe82?=
 =?us-ascii?Q?r5VupKulxCJO9AF0NTfc1dScQFL4vqVXfH/+5nAT/I2RnKvvMD21pmDeP18N?=
 =?us-ascii?Q?D0U+6evaVpOHNUHgJ+8vo8Ky+mWbBKLtiO3TlLoha+IUjbXx7z+zdoAQIDbh?=
 =?us-ascii?Q?glpjsRjeqjqxgNaocl4FpyYCuRRb6+FCNDbCYj+qnwTdeWSE8IhvlIBUuM0g?=
 =?us-ascii?Q?DytRh7yi46qY9zIS81u36SfZ6OGBvztTnzzzJCRdrZN9d3U8vvDNucck8ZSX?=
 =?us-ascii?Q?6qErOxicm2+Seo0uhjMd7ZB4FPeLsm5n81bxwrtzhQuC3Ht1o++CtHmZJiA6?=
 =?us-ascii?Q?/+vDALUm59+XeOvP277s76ZfIapY9PRNktqcrWISRJkrfjgJdSvXMDWTBJJH?=
 =?us-ascii?Q?kxyQtq9KVhNIQiPZNDQaWtnLP/r3KHui6o+85j8t1+1gPp0Q6lUxEKuyuvdA?=
 =?us-ascii?Q?u77ggnHJiACbgqk7DG/jv7dJIV91Q2sML1agjmj6K2CcG966OOgwmxLBVCYH?=
 =?us-ascii?Q?0qCtazjj9Jd0r6XaEPe3hUSi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2lv9C/KsQlroQaE64gvgJq53CQBKygMV4dEF6T5U/6nwO4sQ/LEffVgBgqs9?=
 =?us-ascii?Q?0g/G7ZHuVoAhN8BG9qwouYZDN7H8ukWUem12LE9BIb8GAB3aZMYYZB1+qJB3?=
 =?us-ascii?Q?8EDVpyKQRSMtQNEVJbwLvQzMxbE8P5HCFS/+NyHmn6NgFIuc9bCpw/1GFZd/?=
 =?us-ascii?Q?GrpmKZf4xl0S5x9sp97JXJM1/rmkP4o7YMIScxf0QzVtbw+LqL6/MZQ+GCba?=
 =?us-ascii?Q?2yrqbNemkY6xr9cREJT8ROad2y3/pBtYWO0yEly7sYOo8Oll7Wm20LmIiRD7?=
 =?us-ascii?Q?D4zOkwzx3A+WMtB6SG0AUgI9ZlQer/F979aewff2+j3vB4SpDrRZQDAhhwm+?=
 =?us-ascii?Q?FKLvvpX3rrcZuoUicPMkO12oDMhwGxHWTT8Z5r6wXcQlBj+CJ0vE9BFkONlS?=
 =?us-ascii?Q?xql4zq4odmpjCtPR1UCshqijfnAuSp5wz+85QxFCqhLYnLOcf1j0DdIndJRc?=
 =?us-ascii?Q?9kfBjZbs3hNSzk0/L1/DUeBUiff8E554+ADAMiQ2tPtMj1sD2rpK9X12Hehl?=
 =?us-ascii?Q?FAg/IODdhzB1VCuWikdunM3Ld1icv2Jzi8Y8ve3KnM0w9cv/UzVZ6yoyFBAz?=
 =?us-ascii?Q?NuxI5Aogh3J0AJXGHbrlMvqcaEfiUho+LNGMH4P4DIn4wfhfwdJS3Xb52NPn?=
 =?us-ascii?Q?Oj6D/NwRcg2uKq/gR/y3JP0nfF3BUMfslEbF/ViKBg13w61+EMzSJkVGXwil?=
 =?us-ascii?Q?TwmyZNgwk6O5/tdtLwJ0pgdkMOsL51ZqTw8h+8yTRjsN70mnIn6AkxOci2oB?=
 =?us-ascii?Q?nGpCSrKsRN7ff0aD1EhCa8KNZBBBl2hAPnvq3wd1CzWw+18dUqxf51gt65ad?=
 =?us-ascii?Q?Nci6P0XnAiDlWCrucxCdm32eN0ZwfQ52H9heNFjeWMulehLAwYV8OUaIKof+?=
 =?us-ascii?Q?Q/7VI2bdcA87Lwu11iCkctGnKXDPdV1rtUqkEY1t+qBoUfBMMwcuVb3kpboE?=
 =?us-ascii?Q?8L7+M4Adp0J/NsRU8G2+G8equKjOweadikpHPU7ztn62TjrGz2XNfzuhv628?=
 =?us-ascii?Q?/gosmXuT6hBi91zUNqzzkTFBlTyYRn2UaB43T70opD89gV81m42bi1iW+jdp?=
 =?us-ascii?Q?w4EjE7eQSGfeaVJuk+f/KOWFOvB5WKr1/GGqkuWtnZtOmNa8/ol65dFu/jbR?=
 =?us-ascii?Q?6fcgP2w8jKV745rMjJoQivqmLi7hqZ/lSMdRgeAtvemAhSVrRSdaggwJEDCI?=
 =?us-ascii?Q?Tl/qCkJKgWKnDr/O6x6DcNggAM25CMo5ijyD1H+Q8qDAwDMUpztcSng29cei?=
 =?us-ascii?Q?eHo4O/42DYpQPMKdExOlmh6jBaBE9306JNRgnxol7GcF0KX6dDkxTwxwBFtM?=
 =?us-ascii?Q?URpsRfwQT1b2Ek9k924pXinLuFxQjn9gIAPKDCiNraS2MyroXfGykZrB8wjR?=
 =?us-ascii?Q?AIp/W3YMQGfgPKmopQRt8asRTfyJP+xPAXsh7Mwc0JBzeRJP/nFaZPCmPRNq?=
 =?us-ascii?Q?xsPjMGWzCJdE4m2EfMkMjda6bovSUGIE1GkmRHDJgvVUnzAb8/Dgaavd1g0l?=
 =?us-ascii?Q?VPPjH737pY6fuXil96iX7i7JUOvoUgTOGn9hkvvjGz5KNGN6DQcJ8GGmNxMS?=
 =?us-ascii?Q?Xgi2HaHDxtrNe2SRdRnOY4Um8TxR/y+JLNS4Dw/3smTA10DoIVYdm6t6vQr9?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 623e305c-5b77-45b2-ce82-08dcfd1aa97b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 21:50:13.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYepApQebIiTmVJGeGCTPbd5yhI4HgTEo0bRWaS6wNsHws00bSDiq5tvKTSOhFE8xTagN9OojQ8avGTeKGenaKUrVTgl9RwdKDfTgF6629w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6462
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 25 Oct 2024 16:02:56 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
[..]
> Anyhow, I think it is fine but I would call out that this changes
> things so that the PCI error handlers are no longer called for CXL ports
> if it's an internal error.
> 
> With a sentence on that:
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I'm not 100% convinced the path of separate handlers is the way to go
> but we can always change things again if that doesn't work out.

Hmm, if that part is not clear there should at least be more
documentation as to the "why". For me it is the fact that CXL
potentially promotes endpoint errors to region scope recovery actions,
and that PCIe native AER has no concept of AER triggering unrecoverable
system fatal reponse.

To date panic on AER error has only been logic that ACPI APEI can
deploy, and the kernel has no chance to evaluate the error. So, CXL
error handlers is a reflection that these errors are outside of the PCIe
AER error model.

