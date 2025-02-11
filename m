Return-Path: <linux-pci+bounces-21236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A78A318A9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 23:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26C6188A42D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 22:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3544E268FC2;
	Tue, 11 Feb 2025 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZKVaWbp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E111267715;
	Tue, 11 Feb 2025 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313279; cv=fail; b=YvrDtTvy5/F/JTWhMdoO5qG1i+uf7fYn7zO7ooFFuiE+k4SRRKbvPLCbPryVz3EVIlEiH3cWBn3UtWYzM5ifpqAlgweGCwuAhXgVQs9EucJkIbWbXwyw2nFKxorakEUDsfOCkkHg/u0HnRU9e8M3EK5Q6RBt0leas7Fk0nS5Dv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313279; c=relaxed/simple;
	bh=O0mPGeH3XjWFG9rkLK1t//Mm5FZoOqXbOiSQXzq8BMU=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WW7Nt8gpuyg7RvdkCHYy2eWEqh3SQMuZMXDrDgxQvoBqbETQxiTss5Q+ByHC69beFsDPHxvJ4A1TfpXocESNgGNX2jSS32TWolz6CnfMUjeHsrUmdtIS4oZEmejaVWqdKeDOPbZB5donlFYcRUx2HJPULyAmeszm2E5V4nfC//c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZKVaWbp; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739313277; x=1770849277;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=O0mPGeH3XjWFG9rkLK1t//Mm5FZoOqXbOiSQXzq8BMU=;
  b=bZKVaWbp4vEEpGjiNdVafZYvak7CehNdXue05guqjV7p8K8PLUGnW5jB
   S6+O1RkW2G5+qhqccrHQfHT99pYb7zwbKugThDP89dzO0ojQlfrkE4GWf
   02XRPCu5ZFqZ0CwjVq6oMX80mixZ9xRs94JHctjDRZA9I0H1aTeemEi6C
   Ro6Kkt9gaZvwBVEee37GfmRGdBAB+WVxMByVflk0TQc2Z1ncxEC4GwVsz
   BENe3hWTdpnRE3iKuxEdfBtFZRM4Vwr+aMiJQvDV/e8cGgSAyKiKonTU2
   BQ1fLC1U24kpt+jSjrWDtDd6O8oNyIXBHRj24uBodXwXR5LEisMC97I2L
   w==;
X-CSE-ConnectionGUID: ZmYtYY/NRLqnu0+qnoZSrQ==
X-CSE-MsgGUID: jehhNTmESu6A/UcLsvOmGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="42798604"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="42798604"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 14:34:13 -0800
X-CSE-ConnectionGUID: hnA0zUySSmKGDzaKZy0mqw==
X-CSE-MsgGUID: nhW8NZ4eSy6qf/6fvdRv5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="143487288"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 14:34:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 14:34:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 14:34:07 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 14:34:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+h/bOEhuhy0iCCPYJw5PQSftaEv+LZmCTSRl45rE8s6xrrhRE4/qR0bH2kqkkm1+3wEYHXSXwuDsnCB1iEO6jEtIJ7GZVjpZLdImC5yKDz2wYoaMTXkHp0yKQlzVum0bi7yRJNJcKeBLAisfHHwZ0MIUlqCJYHhZj8x+4M9/l+YxE3vVNotw8zOS6UvUhRHvuXnZJY888OdaA/g0/Hs/vnjvNNV5DV0A5UAhw6mWYyCe6EhCZBSH2A1C+wV607qjOm5R3v/k1mghLyd6SDwmk9ErEjlVl1ybPeiljd0HrZLQVpiDlreroTF0Ez2dt9OgXKxKW0T/F9SRNGb/2/R0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRPSIlRTrmaRyOtSQcJXBtYXHMq+dVRYBJOgzkRmkRs=;
 b=P1E+mAKDVj3EBP91vJ0ftxC4twhEc8TaCPh8hG0FnPnU0YH4ixRyNmWbIGOX7D9oJeGBWraQ7z6fwvEiz9lLJHFe7uRVy1P7BZV3T7xK62e4fBkemBcPW2H4IuvQzlikeHLzDlsu9eW54Z0x5QwdFrgrBfJzMt3Knb0axkKB4qdSqhyZWwfdDqYNskFA7K9hBCTpYC9wxCsRg6QY+TMHS3JEXIXBeXihfJhrMh4pFvQZj9GN+MAfUn2b2BhQiTGqntbFOGLYO471GPICJ6onG6sgk4YMQm0S1NnaBzfObU7F+a0RztKVZ/1frW+lVEalflHZY1EP207mAAWMSlZFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6358.namprd11.prod.outlook.com (2603:10b6:8:b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 22:33:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 22:33:44 +0000
Date: Tue, 11 Feb 2025 14:33:41 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v7 03/17] CXL/PCI: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
Message-ID: <67abd04519e67_2d1e294f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250211192444.2292833-4-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:303:6a::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: faef27e7-1478-485d-4f17-08dd4aec249b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1IqInKva53QWaGPgeCSxzG/J5T9N6MXqP03PvjNrsbw955FioiIyGfRcH5oR?=
 =?us-ascii?Q?oBjwvCiKN7Y+6LSmYHtwu2dEptCSb5HEX33m8ykqwD39YNitgpIhOG/F2MSN?=
 =?us-ascii?Q?xzLS/opgB9KIPjqZwKKeojxjltRKOyjxmYSjFVUQuW4hrG0ubEgJu+URm1g9?=
 =?us-ascii?Q?fnSyTYK9uPMAfCsPKFVaTrZ4wnvwFxMmbG9UQUlO1KDld8ewRsR3l/Ff+hI4?=
 =?us-ascii?Q?vFbsQF5NY1p1PohG6u7iks3INiCnqteeoHg951aHeEDobNHC/ZGC2VYWdUE4?=
 =?us-ascii?Q?CRkFuOjSDafC8yk6ac7xddQf0Hk4vY0/GkNlSxQIbURmmpCpu+4fowQ7f0Bs?=
 =?us-ascii?Q?ZTA0oRqKxz4V9xJ5UMHKw6sVeXzyYHTFL18xTQYpNhUkcX12JHHdTPJ89qaN?=
 =?us-ascii?Q?hZ1EjD2hW7ZaQeHpHfuj65uQnA/yj1MABIFdIyCqaRPba4d99fYFO5FDiPmu?=
 =?us-ascii?Q?L9qaJrea63WIENoEQvYxWBQhLoktFqI7yu3wJz44k9wSlkYly4h9mciA/M8Z?=
 =?us-ascii?Q?GBiFXZ+ovqS5e9McsHqSIEfDiZCPAcTKgSXlNboxw/1iLcZBAM6YsyjVhgKi?=
 =?us-ascii?Q?SOVjgBcCUx+eahIzrWdpkkv52FeDxo2eRpgMjsrm3P42H2mWuizWTk7M6Y9I?=
 =?us-ascii?Q?beaCfAvFuT0GR7piC/rIiE5IkPbI0wofO4HVQzSP+jJgXEHiEMuQg1lOI+gA?=
 =?us-ascii?Q?f8ZyKVYkaJzP/j+gzsdN8HkbAzTqOs1L2qXKKAsCdgackLZQl/4fo3fwlN6f?=
 =?us-ascii?Q?RiXMdF+ap0iG2J/RHKedjLgyL7mddHkbJmjtQJUsj1U4NGrTV63F/oQUOvGG?=
 =?us-ascii?Q?pT+Ry0Gj0ZIfPocde1Q6eV+Dqw57gKWIzA//gA8TGqCaQKwpqmKjCKOAZr33?=
 =?us-ascii?Q?WwqvHyJSVyGg5lEh0PKv82i0zAgUfEQ8mAhwX8cu2UUYaVObT3NzEotJLbCm?=
 =?us-ascii?Q?ApYn1gJfNyvWL9+c7zAKMSnoyNEeEDQeT3OYNusqYReNij72poZONbUAlcnt?=
 =?us-ascii?Q?cEQS0QCSpxd1q9MNP6iUJes+XTjzR/3Ky5kgeVbjGSKKqYlTIhFxtnQ8JVLQ?=
 =?us-ascii?Q?ljmjuI74MQD+0Ir3D3ATmz5Q3sf5SQqTg+NaEadsRMTiXtZz5jkSZ5eZKW49?=
 =?us-ascii?Q?3hIzdRaGtg6dQBN2W8Q3zMtWo9KU97X6lNpNxYhY6RJLg2aL+q+SMFK8PYiE?=
 =?us-ascii?Q?YEZIZ6MjaI/TNUE7oxMN+Holhb3hJRPJFenCwvJgqqK9m/sH1Ezb91NUeoFT?=
 =?us-ascii?Q?cvD49n7lkGLJqyPuhzTUL3xOPb2UXHERQeo/KZdNKJTfWOcdMNp87KJz9pZG?=
 =?us-ascii?Q?MrioAOtMD1qjOjG2yXSvPKnQbIEXezKIzc9rNwhVgwsW6xpjScBW8fkS0gY+?=
 =?us-ascii?Q?LqBVnGbUOakBpq2lHg0F9vodxWe+d4nxFd0M4yPpK2W+6G+QzStvaWxtT+D1?=
 =?us-ascii?Q?8FCKWC6AUkk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iG6cYmDv3L/fS81QQe8aDrWsGb2omggZUx/LXFCnJDdUiLSn+4MhtJO9zaNq?=
 =?us-ascii?Q?t4MtJfXB2cZ5PalaSXfGm+UWZYx85WylCypRFkoWLmVRm4AHIEld/XtBxld4?=
 =?us-ascii?Q?PLsNjkXyWpupvuPCOTuo7Qb6L8s/1O+a6SVRRqj0kMT0lbPbcLwbVjzyGi/u?=
 =?us-ascii?Q?gv/g76kWJia0rSO6r0W8gJTIlbwZqlhDwHWSVAChx1sZbSdlGjLp0rSZWqTq?=
 =?us-ascii?Q?NDWybLkhxktzJdKxNCaQI6wPvziiU5C9T7jQBDgjwhQlQGch66S+zM5BZENQ?=
 =?us-ascii?Q?mtqhC3brY6IDg2Jp+FkqQ2AKSL+wRQDKfn3F9m99JEJY2z3CGXqxFJoreHvj?=
 =?us-ascii?Q?0ZygYkXqHSEJUGSUW++HJ7u8wJ067YgCBWL/swfsMbCJ8oY/ZGrM3uLuKpA1?=
 =?us-ascii?Q?ggL3Cc54sbPbMUPpcIQPZwWefauMZQGYP6XOGO7f8Ur4wXaWcv/VHIf+CKMX?=
 =?us-ascii?Q?oppynMRbD0rNDoiQFgCdf8YqyABh8L7hcPs7+Wpy0kiMeRZTgNxnvIsX4Wtt?=
 =?us-ascii?Q?1qlSCdMk2Cx/ItC17Bs803H0B+gh37SQHPfgmczIYBDDpmf6/byymUOEjRGX?=
 =?us-ascii?Q?va1BebFGd6gKbWtMroduMRw1wqIh04aym5wlPhkGzDfefc5nGCfBtjmqJWwN?=
 =?us-ascii?Q?/aZEIsZdKXRbV6E9UMC+NQcX8BMZB9r5b3aPe9qZNICT0nOGPGZLORbISXBI?=
 =?us-ascii?Q?3XvSTLMEfyq0htu44aIK4ZJKKFciuqBwva4HLc5Sw2ToYEPabw6vuNGcFYwq?=
 =?us-ascii?Q?7lTttrBukmZ/e3d4fb8D7UGMDRRdeLPyJHJe02GsTbEQvXgPSzbmIujReDu8?=
 =?us-ascii?Q?rEQ+IuB8DZH792a2TRZZq1OI7UAbJmRYFhLCE8itttEuKZstXMEH6qdPt2+z?=
 =?us-ascii?Q?DDZEpUzK9WfjcC/Uyi6ecABPHaTu9hP/n/3UFx9bO9eeL8ckdeGmMp4VXVSE?=
 =?us-ascii?Q?OvEGr2P/xPtuqL6cqI4902ukIdNGGVa82jYim/u8c+T/lzgFDfO6SbAMSFXS?=
 =?us-ascii?Q?nsWpGtdLffMdmVT85/KmCqNNl8kHq5pWKr1yehiXZwLyOGRATp3jUA7qwMF4?=
 =?us-ascii?Q?DlTfcZz4Hxu17wV7az1twVExoJhRGPHTpFEsMohF62Z7vhMmRz/B+HPqpkCC?=
 =?us-ascii?Q?0d/RQ4Xa/WdKHVlWecrR+4ey9NqVN/CDVvhTeiHJBKQxV0umkTdD9B9BooMr?=
 =?us-ascii?Q?gXAOQOUD5xxn5c3DZ/JrSP4WS8hVCwMO9pVsT6thMpcxK1fbcbSChfFU397+?=
 =?us-ascii?Q?Wz+CNeYCZ+ogxj92/CdSwv1FTSBK8NXl5kLjD16kUxx2142dvZTrCfgS50cL?=
 =?us-ascii?Q?0g/cVg/F//6+o8djr0lrLnMCJcozC/EjZR7u0dytOqm1/l55yYdaurSswy48?=
 =?us-ascii?Q?y0wnIGiEz8ghNxOLruXrg6DF9X/sRNfxzN+yeyOcQJdm/PFJU2VlplDi7Vwb?=
 =?us-ascii?Q?LN2ZP4urUHfBfjoT45Fg7lMUo2y6U8fXIIHsKLi3nUpy9TvXodPYwTxrKUpZ?=
 =?us-ascii?Q?u4a7rmwskkzeDYT9lGBmYX+jOp2mLoow9MtnUzcKEdnANBKaKhLtjlcg/yNj?=
 =?us-ascii?Q?zOPyfRoEZYSy4TlyperjFtLa77oJADJuLfbuOvBC8YqAzURigK4netLfniGR?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: faef27e7-1478-485d-4f17-08dd4aec249b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 22:33:44.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXoOn0MpwtPD27/ekNBLoFAS85uAzTALXNyzBF316x75sXcaEI2AEDD7AKQIVskYfnSR8Bn7ZPuvEZ7cA0WHSt86vDnIZssp+q6rZ6GcsfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6358
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices and CXL port
> devices.
> 
> First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
> presence. The CXL Flexbus DVSEC presence is used because it is required
> for all the CXL PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> Flexbus presence.
> 
> Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl'.
> 
> Add pcie_is_cxl_port() to check if a device is a CXL Root Port, CXL
> Upstream Switch Port, or CXL Downstream Switch Port. Also, verify the
> CXL Extensions DVSEC for Ports is present.[1]
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> ---
>  drivers/pci/pci.c             | 13 +++++++++++++
>  drivers/pci/probe.c           | 10 ++++++++++
>  include/linux/pci.h           |  5 +++++
>  include/uapi/linux/pci_regs.h |  3 ++-
>  4 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..a2d8b41dd043 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5032,6 +5032,19 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
>  					 PCI_DVSEC_CXL_PORT);
>  }
>  
> +inline bool pcie_is_cxl(struct pci_dev *pci_dev)
> +{
> +	return pci_dev->is_cxl;
> +}
> +
> +bool pcie_is_cxl_port(struct pci_dev *dev)
> +{
> +	if (!pcie_is_cxl(dev))
> +		return false;
> +
> +	return (cxl_port_dvsec(dev) > 0);

At first I was concerned that this adds a capability list walk during
error handling, but patch 17 takes pcie_is_cxl_port() out of the
handles_cxl_errors() path.

It is still used in the aer_probe() path which means enumeration can
potentially race a CXL link up event.

I think this is fine for now because the CXL core has the same top-down
vs bottom-up race, and the CXL SBR code also shares the same race
problem.

A follow-on change needs to arrange for cxl_port_probe() to
enable/disable internal errors, because that path knows that a link has
been negotiated with an endpoint and that the CXL link details should be
stable.

> +}
> +
>  static bool cxl_sbr_masked(struct pci_dev *dev)
>  {
>  	u16 dvsec, reg;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b6536ed599c3..7737b9ce7a83 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1676,6 +1676,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  		dev->is_thunderbolt = 1;
>  }
>  
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					      PCI_DVSEC_CXL_FLEXBUS);
> +	if (dvsec)
> +		dev->is_cxl = 1;
> +}

Similar race problem here as it is premature to check for this DVSEC on
disconnected ports.

For now, lets add a comment to include/uapi/linux/pci_regs.h along the
lines of:

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..32df7abdd23c 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1208,7 +1208,13 @@
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
-/* Compute Express Link (CXL r3.1, sec 8.1.5) */
+/*
+ * Compute Express Link (CXL r3.1, sec 8.1)
+ *
+ * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
+ * is "disconnected" (CXL r3.1, sec 9.12.3). Re-enumerate these
+ * registers on downstream link-up events.
+ */
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001

...to at least remind our future selves that there is work to do here to
make the implementation robust against hot-plug scenarios.

With that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

