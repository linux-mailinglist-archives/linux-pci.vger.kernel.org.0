Return-Path: <linux-pci+bounces-32009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FB2B02E5E
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 03:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1B33BF98A
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 01:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195028F6E;
	Sun, 13 Jul 2025 01:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzO8KxMU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A13E3C3C
	for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2025 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752371915; cv=fail; b=cpMI9lbDAtn+qpUPIxM1royOoZF6tY1wZZ1in/6qRA/bE3A1zsSuILGemYOGBOfPcnAbAe9Zr34ACfmpcPtCwrYtNBu25V1hxJUnNXr4Jt7TlixV7G2UplRa/VXsXRk0ZZXldSFTtFXEmGEwzm5o9dJCVv4Di5KtaoR4vGGLaN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752371915; c=relaxed/simple;
	bh=/jENA/IoLDqZ/2I7toDLo6WuBR+s10T73Jashj+YiMc=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=u8Gs4VrBSTOPo/3ZT+s/q+EqG2DMLzsN6Z6hHJSvneGRui5LoWf4+saxF1p8EcuCJk9jfN2Vmp3Mg5vzw0Irt23MOO7SYxq4faTQNmimab8P7kKuGETD/WfrsvMs1d66qnFVmwP2aiGRCuyYkttuYxdyHHfRdEwMMaNw0k0zY8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzO8KxMU; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752371912; x=1783907912;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=/jENA/IoLDqZ/2I7toDLo6WuBR+s10T73Jashj+YiMc=;
  b=BzO8KxMUYOhvfoCRNPDvXIcfH2xV3qaa72dQ6cHwUd6X0lo4X2GMj8eJ
   wSk4PMf4QEw+sSamTv9ZDfiD8NGDLCSx9LToG9WnU9lg5zosxWF5JCopt
   1I7MhimzLnzQWjxd6/DwVzrLbI7Ki43kmrs65bVBz9Kgu41TfsaHzncs1
   byGuVv8ea9PR+ygiTVjbfvXXXu1gubReGb1W3iyoOo8Fhv/0jdBzbZ4Vu
   WwdIfLPZkSSnrAMc/ClgxnjSaC3yjBnwJ5SzW+cTLH53p8YVqymxbXPrD
   tOoEJWpLFaDo7Fq1GcBhofRaVMgKwJmQMHNGlN8+t5wIKLRTuoR8u8beu
   g==;
X-CSE-ConnectionGUID: rJzZafVsR26423mJL1yYAw==
X-CSE-MsgGUID: k31l+c9sR5O5RTRXKEdKLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="77152304"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="77152304"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 18:58:31 -0700
X-CSE-ConnectionGUID: h1HgiYcbRkCMOM/gkcEmzQ==
X-CSE-MsgGUID: VR60gb9hQVmjDpbDg1OtlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="180335018"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 18:58:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 12 Jul 2025 18:58:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sat, 12 Jul 2025 18:58:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.89)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 12 Jul 2025 18:58:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWC5On6tivJr37Ob6POLCD19QsBlkwRsFljTqSJ6JRNKuwXA9+y5co4FuOjuIjqxExD+wElCAr3vIEAyxpi8yLOsU+qrFywYzGEqsuf5yNPiLLpOzxjIQi7r87fb3TR6HDj5Nij7PSYbSuGCyWQ5N520wqUWUx3sEX/dwIK7VDJCNQ2buxFhGJO+bVCO9QsftYa4u48Sd+DTv3qTLJ4OLMMAIyPJijlkFWAZiaHy763Bz+5DJzh5pDPIz8PWOVATBAaOfzTk8JpAF9+B3YjuIsRaojq+LpWHg3A8Nna+/0ewfX6WbCTRgkUVccKusI2IxwsIWRmRDvvrEyDtBZSjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLGZMnY4nXN4CLMQM8GptvndC9N0RTdNrl6YRcUHb6g=;
 b=MWBVbFSepAljbo3eeZKVMSEO+Lc4Cm4BoYJO3d/WNp85JiV1Z/LlKhdoHmbe4TBa7ZbwGdTzXaipjCqHozSlF2vSBBCbp9Ed+wE3S+wQX8vlnPQqk7HiGIGC3nZwqZ5uBbPs7ptcU5N4F9KDIlqDNIcLBTyUvTAf28T8JvM+98FrIe8BLbpZtpXomkvmxdUonxEBxqeRGK1QkS0bamnRP+1tq3sSqUzoRWqLhgMExje65c1oo3GKKJkIEBq4xgkIUIGtBmLLkblQpTArnBHhcG0fEY0CNDlTurRFzYnpWChHCkjuG2UvcHp4cS+TmXxKZX5bFCcw03EHXhG1vlBZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPF7A0031045.namprd11.prod.outlook.com (2603:10b6:f:fc02::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Sun, 13 Jul
 2025 01:58:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Sun, 13 Jul 2025
 01:58:27 +0000
From: <dan.j.williams@intel.com>
Date: Sat, 12 Jul 2025 18:58:13 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Message-ID: <687312b5e4484_113441001d@dwillia2-mobl4.notmuch>
In-Reply-To: <20250617143000.00001d05@huawei.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-7-dan.j.williams@intel.com>
 <20250617143000.00001d05@huawei.com>
Subject: Re: [PATCH v3 06/13] samples/devsec: Introduce a PCI device-security
 bus + endpoint sample
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPF7A0031045:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab23d5e-b1ff-49fa-87cb-08ddc1b0c1ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sk80Z1l3Zi8wSWdEdWhkUjErRE0yNnRzUzF0cGp6VzVQOHhLYytIMjlEbjFI?=
 =?utf-8?B?ZTFseG9GMWdkeERTYXphK25XbHNJN1Q2eTlZck4vTmFPcHk1SUM5R1gxUXlt?=
 =?utf-8?B?WDhnL3BNSWM5bmlrNFFPWmFSTWlhZXZCbUxCRUNPTXBHUnMyaFVNV216VktS?=
 =?utf-8?B?NDNhVUhtRU9Dc3dxZllSTXJ2WGczVnJBV01hMUFoN3JHMXIzdm5rdFVyTmxa?=
 =?utf-8?B?RDM0MTY2WkQ5cVZNSGxkN0JpZlZEaHVLWTVzamw0R0wyVUhmWkVaTlFIQnVU?=
 =?utf-8?B?TTNrbUdBdVlWaVhsQlZyMXJ1dlc4OW5GU2dVMjF0enZMZmxGYVQ2STBFb0tD?=
 =?utf-8?B?TGFibWVHR1VxbE94WU5yYXowVTAxUTNpWEJWd2djSy9IUE5KRTBmaHhHcFc3?=
 =?utf-8?B?YnJSeC9yV0JYeUozMTZJSDhNL0hQc2FvaVhzZzFOTXJmM1dkVmNtQS91UWJ3?=
 =?utf-8?B?WXlIUE9NUzZtSlJhY3ZadWtsK1BPWStkWmMzVXJuelcwSVc2aFlHaVBTc1JI?=
 =?utf-8?B?NHFYVmlPQkhWNjhNYXcyVTJaTWRaSWx3SGUvVy9xc3MvRnlCVG81cnEzK1pS?=
 =?utf-8?B?ZnJDU0xpZVlwVmhobDZyYTltajBHZ2dhdzJtZHJnZDJzSHV0QnIxUXNNYlNs?=
 =?utf-8?B?WFMvTzJhZEkwOUtEM2JRR24xRm85aGF2bDhBY250ckRnSG5pY1QwMFdRSDlX?=
 =?utf-8?B?RXZBYityWkwwRXNlVlNpYzZGck9NSHJrM0RzY00yM2crVnczdTd2bks1a2xN?=
 =?utf-8?B?ODR4K2FGV0JhYW52eGZCYlhPendlTGMyeTRwaTlpZC9SaHphaGpTRWxxTldV?=
 =?utf-8?B?WUpQZy9SUWEvK2REL09rRURzZTJRZ2RERGNaakpVVjdXaU1ocHFXR3MxR0sx?=
 =?utf-8?B?Nm9zdEgwL1M2NEVnejNYVTBRN0YxcVVmVE9Ya0s3T01mUTJtbVk1dHhsb3A3?=
 =?utf-8?B?MEFJSmFjREFsSENiUjlaMTZTVDcrQ0RTN1VZSC81Y0N1UXVGbTBBQ3Zrd1I5?=
 =?utf-8?B?blJRT0Vnc2FHQUJvUFNMTlVTeWkra2doM1lIUW56MGdLWk91b1ZnVUo1cGZw?=
 =?utf-8?B?ei9XcGpnMnp6c1h2a01nc2lBWXlpNCtkODU5cXlJMVFKK0tOK1BtVTR4bVdO?=
 =?utf-8?B?NjhpY1hQVlYwTEszYnVzUkQwQ1JYQWxIbFVsSEpMRnU0bWVBK3VqQlRKTy8x?=
 =?utf-8?B?bjNKWGU3c3VvZ3VGQjlhbmF4MTNoOVdwbitYSVJEOElTSmpZcmtZNHVZSlhD?=
 =?utf-8?B?TXByZ0V2L0ZobGh0ZFBJSXZ4WVV3SDFOdGJTWGhsWkkwelRuem5rSkFiVmZ1?=
 =?utf-8?B?WUVHREExM2wzS1RPRTlSK0FRbTFmN2lWa1JydFh6dDFEak9oQVpXOUU3eklE?=
 =?utf-8?B?ODNQR3lmUzF6MUFHRThEMkt5QUI1ZFltbWlXVzFjYy83SEFHeWlhZjhwWUN1?=
 =?utf-8?B?d2M4NnUwTktkemNSQXdaQ1NxOTYvQzZrVGw5am1zRkt5eWVJSUZHdWZ5My81?=
 =?utf-8?B?a1Q4bURwc0JWWXQzbGRvSTFjRDRNU1g2SFBXQ1lhV3E1eHdQRXQwVlh3N09w?=
 =?utf-8?B?RmZZcFNuNjBlR082WFhoaHc5VzNCb2VHb0Mva25ubGR3ZUk1RVRKT1c3bFYy?=
 =?utf-8?B?K0dGdnlweGFCZ2pTNEpjTUlEOXR0OHJscDVDUS9RSGd2Zk5jNDRQcmZBTUlh?=
 =?utf-8?B?a3JDYWJiVHo0UWZBMy9Nbzg0V04rU0xSWVdtbmliWnVyNThsWlRhZDFMb2VH?=
 =?utf-8?B?MStPYUhURXIveHkvN2EwdUhUa0tGS1NoRHdXQWJsSFhuK05sMjdOazdjU1ps?=
 =?utf-8?B?WVBSUzdZbzFqNzFPU0szRU9yZXhHUUVyRFhzZk5adE13V09tcUpaNzJQQzQx?=
 =?utf-8?B?V2hjdEdSN0pObmsxLzZXSG1iQmxCWU5nYmMzdDZTclFlRW95NVltb2h6VGtk?=
 =?utf-8?Q?OqH0OfTCR2g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRRTlpTUHV1eCtUSzdkVm9sbWJYTERCVlo0MHc0ZHorNWM5TCs2NWZOUWNY?=
 =?utf-8?B?U09SeW5qWVlJZDJFV0RHd2lsbFgzcTBHWUxoQnIzUTI3Q2xrdjU0eVk4QnRK?=
 =?utf-8?B?b0FhVDFzMGw0VHhxSjdCTm9qL3pId3NFTlBDclFtNzN0cGFTN0FKQ3c0QVRT?=
 =?utf-8?B?MnhHcENnR0hJaDI4S3djK21IOXA0OGo1MnJqS3B1dHkwVDBqdWRSYkp1U1By?=
 =?utf-8?B?dkQ4Y2NNNlByNXVJOHVDRjl4elV4a3lNKzRDa2FJVytQbStOUzRoaGhvOTBG?=
 =?utf-8?B?YkhybnErbGxxbUtyWG1qY2xDVUwyMVF3TURuRGdocDVmNlhESDVXOWMzZmky?=
 =?utf-8?B?SzhCUmh1bU92cWJ5V1M1dVdvbVUxQ3hjRTVRc3hEYTN3T1JONlJ0UGVSQVBU?=
 =?utf-8?B?cWFLNnp5VkxHMm5MV2tjVFBTS0l0ei8rdXk1RjJIall2dTk4K1hmTHNzK3lM?=
 =?utf-8?B?aStkOEwrR0lGTlFXV245SVB1T1IyQnVVWmxueEY4dTFMWmJ1eTY2dUpnRm5u?=
 =?utf-8?B?UWcySUE3VkZldWJ0bjBQdXZDYXBlcVpQbWpwQmZOODcrSVhhZmY2VWlBRWZS?=
 =?utf-8?B?TjFiYmlHQ1Vyd0FDUkpGcUtuNFVsZFE1ZVNJa0ZveTBkU3V6YTE4eWpKWEFt?=
 =?utf-8?B?ZWJ2YlpaZ2EwaERCcFZzOWlLbUtJN1g0Sytlb0JrU3JhaFoxUjVaZTE5UVpx?=
 =?utf-8?B?eWRNbVRqc0FrbEdESUNocnRrYnFMWUp2WGtXalEyUjM1ZiswRG5WVXZiSHF1?=
 =?utf-8?B?NmNzNElOZ3pZN25lcklTZ3hrdURMaEdOeXc3V0VJK1NoUmZlNFlUMDMrckpU?=
 =?utf-8?B?TmpFSitTcUlnYzYxdmJkbms0NlFOMnlYdnNlSUQ3eVdjcWRnMDVlK3dTaFRz?=
 =?utf-8?B?TTFGZVFDQXNrM2ZyR1NMdnVBcWwyWWhKa294WUVYVng4KzYxUlV4U0hyYUFQ?=
 =?utf-8?B?NHFCOVNLRlF0alRITkc0MTB6SEFrVk9iK0dGdzVacFZCNDdTdlllUDltd3JN?=
 =?utf-8?B?QVNwNlV4bEJMNVhGbHpNYlRScnFtNHdONmN5NnE5UXNUajJTY0xPbENRSUtJ?=
 =?utf-8?B?Vk85ZEovNm1ad3hRd3pNc1Nha25NakRXRERyVDkxMDJtR0hjTTUzQjk0YTRS?=
 =?utf-8?B?d0RGMUwvK2h5KzU4N2F2WGloWWhTREJPVHREZi8ybGZBeXl4RzZrUmZEeCt3?=
 =?utf-8?B?R2xCZzlTRXg0bGYwSm9EQzhLdHVyeG9WYnc0d0FvVCs5LzQwbFArS0MrcnNp?=
 =?utf-8?B?eWxJZmw1SDY3eVdrVW1QMVF1eFRwMXQ5d1EvdklTWStQNWUyTUNxaVdzd2dv?=
 =?utf-8?B?ckRQVGVKL1ZEK294SjZFRVBBaTBvYWRZZWJpTHUrWS9RNHBXbWFncGNXeXcw?=
 =?utf-8?B?M1ZIdzlSeno1WklZOEw5WVBGNzY4K2R1dUVwVUJobWNUOE1CVnB3QnhxdlZY?=
 =?utf-8?B?Y0pjSUpuWlVhZEhmbDE1STFhZjZPcTM0dzRxenorU29ZMjBudkdhMHlzSzFX?=
 =?utf-8?B?K2tLNmdYamR2cERiWTJCTFcwOGFFK21ZY2pBakxoVnRObjl0V2pMU3dNNGNP?=
 =?utf-8?B?T1hkMk9iR0ZQM3lZSDYyRE9lQU15TzJyWWxOR3k3V2gwNEhjTnEzSVROS0dS?=
 =?utf-8?B?K24wWThicHJZYXFVSUpEV1JudXJ3bWMzSG1tUlBWSk5YQ2RCbGc1Q2VtY2Rw?=
 =?utf-8?B?YkcxS2F2b0ZvQTd3QzI4bGREWkVndmMwTTNPTnRhcWlnOWd1VTIrTHc4a3Fh?=
 =?utf-8?B?N1dMNFVEbFJOdHBPdUxDd3Zod2xnLzJhK0tlTC94L1FLRW5IZWV3WSt0T2c2?=
 =?utf-8?B?OWxycm1pYW5VMEdTa1RpakxWbXg2bURkVVFQVXkzb0FEQmJsc3BhVkFMWHpZ?=
 =?utf-8?B?RE1BZUI5THFHckRHOHZVYjA0S0hTRktWUGRIS0lMZHdLc3B3Zm1OeFBvalVy?=
 =?utf-8?B?SDFVeW9wZEQ0WnNNcllpaGNSU3BQb3Q3WVFqaU9lckdiTVJvKzMxZ1RjTjlv?=
 =?utf-8?B?cDRGNjVKU1NaTzBaam1ES3plM3FnOUpoVXZVUzNqeXhPdkFvSG1WbDBPSVJo?=
 =?utf-8?B?Zlo0REc4aUNwY1g5RWc3bGRBQjBmdENNT3ZXV3FCVGZzTGhPeEdjVXlWR09T?=
 =?utf-8?B?SDF1ZXZwRGY0Z2t3QW1jWnZackVnUEo4YzludGlxcGYrUmNuQW1EajVMaktB?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab23d5e-b1ff-49fa-87cb-08ddc1b0c1ed
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 01:58:27.6307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4BHG72GssPX15JIqcG1JPoSqwAyMneWZAFUNJZio6p3aFgQoSJ0iwUzb75QZf9x+0vLkulyTS65mWT3KJvYECy5Ze6tXyI2kJt7NBMHRvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF7A0031045
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 15 May 2025 22:47:25 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Establish just enough emulated PCI infrastructure to register a sample
> > TSM (platform security manager) driver and have it discover an IDE + TEE
> > (link encryption + device-interface security protocol (TDISP)) capable
> > device.
> > 
> > Use the existing a CONFIG_PCI_BRIDGE_EMUL to emulate an IDE capable root
> > port, and open code the emulation of an endpoint device via simulated
> > configuration cycle responses.
> > 
> > The devsec_tsm driver responds to the PCI core TSM operations as if it
> > successfully exercised the given interface security protocol message.
> > 
> > The devsec_bus and devsec_tsm drivers can be loaded in either order to
> > reflect cases like SEV-TIO where the TSM is PCI-device firmware, and
> > cases like TDX Connect where the TSM is a software agent running on the
> > host CPU.
> > 
> > Follow-on patches add common code for TSM managed IDE establishment. For
> > now, just successfully complete setup and teardown of the DSM (device
> > security manager) context as a building block for management of TDI
> > (trusted device interface) instances.
> > 
> >  # modprobe devsec_bus
> >     devsec_bus devsec_bus: PCI host bridge to bus 10000:00
> >     pci_bus 10000:00: root bus resource [bus 00-01]
> >     pci_bus 10000:00: root bus resource [mem 0xf000000000-0xffffffffff 64bit]
> >     pci 10000:00:00.0: [8086:7075] type 01 class 0x060400 PCIe Root Port
> >     pci 10000:00:00.0: PCI bridge to [bus 00]
> >     pci 10000:00:00.0:   bridge window [io  0x0000-0x0fff]
> >     pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> >     pci 10000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> >     pci 10000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> >     pci 10000:01:00.0: [8086:ffff] type 00 class 0x000000 PCIe Endpoint
> >     pci 10000:01:00.0: BAR 0 [mem 0xf000000000-0xf0001fffff 64bit pref]
> >     pci_doe_abort: pci 10000:01:00.0: DOE: [100] Issuing Abort
> >     pci_doe_cache_protocols: pci 10000:01:00.0: DOE: [100] Found protocol 0 vid: 1 prot: 1
> >     pci 10000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
> >     pci 10000:00:00.0: PCI bridge to [bus 01]
> >     pci_bus 10000:01: busn_res: [bus 01] end is updated to 01
> >  # modprobe devsec_tsm
> >     devsec_tsm_pci_probe: pci 10000:01:00.0: devsec: tsm enabled
> >     __pci_tsm_init: pci 10000:01:00.0: TSM: Device security capabilities detected ( ide tee ), TSM attach
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Interesting bit of emulation.  Only real question I have
> is whether you can switch from platform devices to faux bus?
[..]
> 
> > +static struct platform_device *devsec_tsm;
> > +
> > +static int __init devsec_tsm_init(void)
> > +{
> 
> Could this use the faux bus stuff or does it need to be a platform
> device for some reason?  That support may well have crossed with this work.

Yes, this was conceived before that existed, but it is a perfect fit for
what I need here. Switched.

