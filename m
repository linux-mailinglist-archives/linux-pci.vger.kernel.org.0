Return-Path: <linux-pci+bounces-26787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF98A9D32D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 22:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585189C2C0F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 20:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3981321ABB7;
	Fri, 25 Apr 2025 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncA71QC3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112C19E7FA
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745613822; cv=fail; b=k0/Cyg4yH/tDTTvAIXi5VD8b8r7L4yqxMxARbXbIhkA4jQEzVoS2slIrH9Gm9hybYDrGQxZE7zlGGsYlrlj+GXaDZ0LGI18lpe3yxq/dEKbvGAl4zG1RFNrnVfGDMuhagpUsAZPSJrh6QRBWOTL0/B5U81gBpmeEWEc3XfPkBco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745613822; c=relaxed/simple;
	bh=SVJSLN70KO0dxvTtm3C9co8ZWWOp5FCebOrAbg56ubg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O++xsXcovgRfyF7PPVabdOzqP5hziciACgdBF1R8Q/scDlbHAAwO6Q2DBFKM62PTZ8TxXdKIxRSsR6Mxa9wHMpWcgXjIoIq+4ZWwxELRyFHaMtUWFFGgkmQ5MD9ujGQUzc15qUTM3hLlxqEyOncvwYH01ePr6ciP5vbvAuzfDEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncA71QC3; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745613820; x=1777149820;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=SVJSLN70KO0dxvTtm3C9co8ZWWOp5FCebOrAbg56ubg=;
  b=ncA71QC3uKMlq1tbGRrUfuG6X/e7VXrc3k1S4Hgsu+U6DOuqVcwCJ6CI
   j8xW/iClTdGtHoOlUZe2crSQFGvreotoVzFUTZ3shw/VdP3LWCbDJhGLX
   F8/8qo+T6BOdzQMw9oxNqwY6XtXOJ4fcNISeoJuOvIrfDeA8YaEMsjZyw
   d5oQUvYonqkwH1gMEI9Ai1YLuqauhde+yeWmCBssMeLc0qJ4RcuzAdPFd
   vhVcrjPIxQvB9+isJtGfL8wau2HTtBi2+xmb7nAJsj81fWJjQP/4sstgD
   fUvbdWW7vrG6Nn40NKVCR67DXyDhN5YrlY+4lPJYBCAeS4tKEw+ZwpVTy
   w==;
X-CSE-ConnectionGUID: 4Zj618wvRbm6il7Ks1wMIQ==
X-CSE-MsgGUID: noEUFhhhSd+diErpcvPBqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="47300340"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="47300340"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 13:43:39 -0700
X-CSE-ConnectionGUID: jyFsLiXeRdWXD/isiVh26A==
X-CSE-MsgGUID: Rg24PaaSTuiUEvUY0Alq9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="138092438"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 13:43:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 25 Apr 2025 13:43:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 25 Apr 2025 13:43:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 25 Apr 2025 13:43:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGOY9fmouV1WipxNHQLR1o5rrFXxSDZZYRVteBJmpl7Ix4uu0PtVBSqjqKEmKb1CBDE/rtRhrZtWSQbOpYWTMktaS8dn4YE1O127Smy0dwY0vFh/OHeJHfgiLIZwB8Wl8YI2qGmAQ+EEDnyQ10RSryZ5c9tQ3LvR8v+Fd0O2bClTyXh1LatbmqR03/eRqv8LZaixQMOj9fnJUk9K9fVEVjeaDAnLmNWRhFmRheomDCBdco2RY0vlf1ReaSmnFbASD0lWHwPblcyFR3F8PCCoBk7QtzaoFzKusIwaxACQvqUDf5VDySW0E57jO1gnKhSB70IH6JGwB0jaLsrJYnanCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ji0anzYonFs96FUpCS6C7drjiM+gFfpxIPvlc9V/Fk=;
 b=rXYmx/O2ychdr+MHwhrZasLGok6+SL5FliUOZ1S73o8tDezen5QONmSkUF2xwZdcA3xbmbK2FmEnku172QjyvKO+94WK66bLBF1yK59lE8qXtsoat4jBUMff/8a3giTYvyxDk+i+XHToOirOAS06d0XGyLILYETBTtFbiHgEMoUXQF2QS5TZrCgjQXuZK8Y5g2jUSZgsPT6y5znfnC7z7yY+Qh7A2PE5kYgXSm+f+DQRI4Z8RMdF+A05EAhIzB1sreIzli+/XpGLHyHFgi2XT6wM6tiq4/elQUlHqILEIx7awhQB9PvzSRXyexQC4ayjiJ77vTL8yo8r0z8wZDBPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9422.namprd11.prod.outlook.com (2603:10b6:208:57e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 20:43:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Fri, 25 Apr 2025
 20:43:02 +0000
Date: Fri, 25 Apr 2025 13:42:58 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dionna Amalie Glaze <dionnaglaze@google.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>, "Lukas
 Wunner" <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 09/11] PCI/IDE: Report available IDE streams
Message-ID: <680bf3d2be818_1d5229490@dwillia2-xfh.jf.intel.com.notmuch>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107250696.1288555.15924775074966673629.stgit@dwillia2-xfh.jf.intel.com>
 <CAAH4kHZS+wOrP-R22bnFRPY10jZw7swxmAsPXegpBjuVvJxe1Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH4kHZS+wOrP-R22bnFRPY10jZw7swxmAsPXegpBjuVvJxe1Q@mail.gmail.com>
X-ClientProxiedBy: MW2PR2101CA0032.namprd21.prod.outlook.com
 (2603:10b6:302:1::45) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c56c71-11bb-4be0-e0df-08dd8439c5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1ZjTmhCWFJEWmo1TlBsaGZaMXRPaFlZNXdlMGtSbjJMRzVRZnE5Um5aMXhX?=
 =?utf-8?B?cUdiZ0N6cHJ4MTNKRmVtRnRTUFE2bjUzNkt1UGttZFk0YmxYSkdEckwzNHN6?=
 =?utf-8?B?cWdqOUM0Q3RiOWlhbVVFdnhiZzNMNUlIaXBWY3Myc0NveGxPRS8vMUhxdU81?=
 =?utf-8?B?S3I4Z0hDL2lQTHFYZ0hWVlltOHRCMForQjNIempVQzRkNGFxMURFRGlEM2Zv?=
 =?utf-8?B?N1NQZWp2clpYVkI4anpWbjJTODFDN1Fnai9TRWJPbUJySWtPalBWVC9HRGF5?=
 =?utf-8?B?RnVZUFRmSU1IRm5SQllONE5kMVU1NE9QZDJpdjd0Tnc4QlB5dWpNdlBnWFpU?=
 =?utf-8?B?Zi9lSWY3Qm0xb1g5djEyUFpKN1BWcmxnNm9ZenRpU0F3RGhWZFBwMW5kb3Yz?=
 =?utf-8?B?aGlpNzRXeDM2TWhLMVBDemVzUWlnSEhxdDZzNFVCWDRiVnN0RzJjaFZmQnFM?=
 =?utf-8?B?eUd2bHpDMVp4dk1lSS9EbWxRanoyVFNxcFZVWHdRd1Z3dlFKTG04cVNqV2gz?=
 =?utf-8?B?Qlk5L0xmVmIvRjkycFhWL1k3a0UxTlR6bUl5bk1ZelVZc2x5TzBsQjlFb2c0?=
 =?utf-8?B?RW9NQUNGdDlhUUNNVjBsYVZXakVHNWtOK21pN1dvSGIyK2ZmTENIZmMybzZQ?=
 =?utf-8?B?N2tQNnFSUE1LeDM3Nk9TeWdOLzNPL3hScDZob09CMWVqZk5od2dXK1BOSy9v?=
 =?utf-8?B?c1hJdXZ3bm94VU9vMllrbURFcVhUNWN2YThjNHI5SW9heGk1S1Bob1E1dW9z?=
 =?utf-8?B?dFRMeXZhVnpkZ1cwbm1JVktCMGxDcnpoWWN0dFYyRndKeHU5aXpIenpNSGNN?=
 =?utf-8?B?VGZUV2tLK3piY0ttRzZzdnJCZk94bDV5K1Bvc1g5UXlMU3Y3ZDFiRGtwUThS?=
 =?utf-8?B?ZXFpMEhRTVFqbHFGcHArZzFIenhKYitEdTBzOExQaS9ySTl2V1dwblV6dUMy?=
 =?utf-8?B?bGxIaDRQaGtYbmlUUE9QV2RnSEh3WjBia3pWV1gxQ2NsZEFrQi95ZzBkaGFo?=
 =?utf-8?B?ZTllY0JYOU9yV21uak0wcDloTGNaQUhqdG0zZHlyNnN5OGxXR0J0eGRuM1Zl?=
 =?utf-8?B?TVliSWg0VFlYbVZCU3lrdXZINEQ0THpHUzFuMEdtTmpQc0dFdHRxZ0xvR281?=
 =?utf-8?B?bE9wRTVxYk1jb1paVWQ0RjBIV05rRHlubW9wTlRhZG95d1B6OEhFOGpIYm1q?=
 =?utf-8?B?RUt3ZDhQNWxlU1VsRHRBc08xMWtUS01Gd2xsOXNrQ01KUTlrZ0RsQk41NFA2?=
 =?utf-8?B?ZTU3NmU1UWlBeG9nTVh1SWtpbUxrV252SWhkYm54bFJBZ0g1UzBHWmxIU25X?=
 =?utf-8?B?RitDL0VNazJjdXluR0RzMnBBQVJUczdTNEhvS2l4c3Y5WWVyWkZmczdsU0dy?=
 =?utf-8?B?TjcrcDlyUEM5eHcvcU9IRERpcW15b1UwTEN6QitaVFhoZXFOZVlIeURNM1pK?=
 =?utf-8?B?RnVuRmpqbXNNcW50cEE4RHR0ekpBYW9pR0JiaVdPZ092eGtsV0IzNm1pTU1w?=
 =?utf-8?B?Q1JWUWNid1BCNW9IRU1XMUtBRnh1UGZHR2RobS9aUVFXbTI4QTlLaGREVHV4?=
 =?utf-8?B?czlRb201M0NZZEtlM2lnRWFoNW9zVGl0M3NqWTI0bEFJa1RnMzJhU3BIK0My?=
 =?utf-8?B?aEpFWE5Ha01mVnJZSjZaWUFPaHliVCtZM01MV2EzZzBuQ09LRWdNcEY0Sjcv?=
 =?utf-8?B?dUJGZFlkOExkSStxeFRPdmltS25nVHhkcnUzMGdVNCtHTFdqVGk2endCUkhu?=
 =?utf-8?B?a2lQZzh1SkpDQkRKTXd4REZDVjBIMHZZOWp6SVRvelhNNEZwMUYwakZTRmdi?=
 =?utf-8?B?ZEpVVFBQOFdybTBDeExXdXhVb081aERFM0dSNXJPZjdyeGtHdURFNG0vanJ1?=
 =?utf-8?B?bXpXRUVYekVmV3BwNHlqRHYzRitsY2NtT2FFdlk0SXp5MWZsZmVBUHF1d21k?=
 =?utf-8?Q?yEClOZ2LThQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUwyMXVzOEUycS9yTUNwdHJsSy94ZFgxNGVGd0hMMzA5OTB4V2pOUE9aWnZ1?=
 =?utf-8?B?ODZnRWJ0VjRNSFdkT1oxSUNCTEgrQmRkaXBoYnRlK0MwSnArZnh3alQxNnVX?=
 =?utf-8?B?aGdNMnQ5Vm0vMDJ6WVNxQkQ3UDFqVjg4bTFGakdpNEJicGlRUU83d2UxNjdN?=
 =?utf-8?B?YWxoRkFiQnZuVjBQak11ZVlmbEhEbDBQUnhRUUNyVFhzQld2RnVOd003YWsw?=
 =?utf-8?B?aERvOXNNSXpVQ2JBY242THg4aEFVZFJLemN2UVUzblZoVE02bStNMXI0aXEz?=
 =?utf-8?B?em9QZmJPMlpqUFRZSmVKNXZ6ZHZFaG95VVcvTVBDNTYwRW83amxrWWd3M2x4?=
 =?utf-8?B?c3NHWWFpUFNYQURiNC81cHQ3N0JCK1EzTzJuWEFqRk5BSDZVVm9OazN1S0oz?=
 =?utf-8?B?WHBHaGNaU1g0dUowTm1JOGQzTXhmSXdmVGdadFhyd2RISEpra1B2aE1CaFky?=
 =?utf-8?B?cEZ1VmVQQnNZemVqZkFuTjJjUVU1dHlyLzE1M21Wa1hSSnZKeWJBQklYajdT?=
 =?utf-8?B?R3FGcGluanNyclFsQWJPUzVVRHdsbm85VHhtOHVhUWp3NXdZZGJaZEl6SDl1?=
 =?utf-8?B?YVFGRktmTnBqbDJyK2JhWUZsYjAyN2NWdGRuYUoxQlhjeVdnS1JWbWcwcUVF?=
 =?utf-8?B?Mms1VUhkSDN3WjNEUVVkZ3kxcStSZVBwSy90bnZKbWNoVVVWa1VGRmRVSGRr?=
 =?utf-8?B?bnZvVllYNlJsNG9ja25qdE50MFhFbDlUMTBQZmVWSCtsbUJGZ090aDJhWnhQ?=
 =?utf-8?B?NThqU2UvaExmeFc0NXpNd0hnN3RSSUVJTVpRVlhKTWd0MHhXRDQ4cnNMZnp2?=
 =?utf-8?B?UXFkNi9zRGJpQmtZUmdySlI5S0JuTTVUY1pGTzZTc3Y5LzZxNW1kdFpyTzhj?=
 =?utf-8?B?Z1VxY2VrRGZPVk1oTlF5R3dxd003S2V4Vk4zWVB4bWVNTVo3Z2NnRWZZYnVZ?=
 =?utf-8?B?SUhyL2xSOWNGWjM0cnA0MEF6RklBb2J5TXFEZXNMZXZteEx4bkEvelBkZEIw?=
 =?utf-8?B?SkhMRzRXWTljOXRzS1dHY0NWUiswUmhMVmN0Z0xTUFhmWDBSNUIrMFhoQ1hW?=
 =?utf-8?B?eXdWS1RlVXBXMW80ZjVPOVRaTHFWR3I2aVdMK2R0dW9EdE9tYlB2ZzFqRFQz?=
 =?utf-8?B?UFZId0NORlBGWVdFNFNDLzB3ZWxRS3JzU3Z0bGgvYk1ocS9oUlhyRm1xcy91?=
 =?utf-8?B?MDQyZzRZT0kxeTNwTml6KzN2YlNzQ0JFQWFHLy9KRmx2UW5lME5WamNQVHZC?=
 =?utf-8?B?N1hoVHczODI2SExTUHVndVRCZHhPRXNWR1lOTnBwWjZ6UHA3UCtOb1dpZ3lk?=
 =?utf-8?B?RVMxTURPMUlXcDNpcGlKTVJsWitHcC90ZVZFREUrWEYycVpPRWpKS0xpdzNv?=
 =?utf-8?B?WlNMcTB3a2t5bitGTDZ5WWZnKzNka3dyMjVBa1JZTXJaYmdhTjVuWHREL3VQ?=
 =?utf-8?B?QTQwSHJVbis0ZU5tZng3ZUVUYjhwejZ3LzN2dWVZZkw4SXFxRGpMRlRoMTBB?=
 =?utf-8?B?czE1U3ljQmZwY1NGbFFYM0xFYlZIYnptYVphV0dwTlViRzJ6dWIxU0RBUHhE?=
 =?utf-8?B?ZFIzMnY0V2NOMXZsVEtTQ2Z2TzhVSVFtRTZOWDk4YWQ3M1RHQW5wdTJuWTRD?=
 =?utf-8?B?eFo0U2hnS0Q1RkpyRVZlZUtBZkExMmJDMzRqT3Y1RWZRemJEYWc5WUJtVkps?=
 =?utf-8?B?U0FqTmwzd1hHK0w5Zjk3ci82eUFsRENvTzM4VTVKem5yeFdWNFlLaVkxY3hG?=
 =?utf-8?B?VDYvYnlxZVhaQytkYlRzc3BrLzZhNGVpTFp4Qm1ZVWlVY1luNVh6eTlHM3p2?=
 =?utf-8?B?NjdSaG1wNGlvenM1ZnpObFcrNS9IMEx2SXZWcy9ZOUxpbm5nN0pIenB1ejNJ?=
 =?utf-8?B?czdvbkhpTHkyVmJ3cmlMRS9Yb05vbzdiTy9qajFuUXlGcmZuMFZDZ1dsb3VT?=
 =?utf-8?B?V3FYclVvV25nUEpWckRsSW1kd3dzc1lsQXRYTUFiN0p5TXNXR29MVm9jZ08r?=
 =?utf-8?B?bmlkVnBEN0NzZEQrTGNjcE9OYXpNOC85d1UxOHhndHd3dFB4Zkx1bnZGS0xN?=
 =?utf-8?B?aFlBR0Y2a1Jqck9kdEdtWFRrdzhWTFNZaGxNK3ZEMjNsZVNmTnJVMnNGN2s1?=
 =?utf-8?B?QTVWeUlSeTBvSEttOUJRc2lMWTh1SlgzNVBmU3NlblgwZVMzYnYxWUM3WWhC?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c56c71-11bb-4be0-e0df-08dd8439c5e5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 20:43:02.6755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFvtK1kiRferl5m8DyKCv2kV5AEmAX9G76fFRh+wn+k9Nql4vmEO57RueZwUf4GOV3Ou5HBhXfANkmXRKegQNXQxlSfeNOVE8cXg7C9z37c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9422
X-OriginatorOrg: intel.com

Dionna Amalie Glaze wrote:
> On Mon, Mar 3, 2025 at 11:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > The limited number of link-encryption (IDE) streams that a given set of
> > host bridges supports is a platform specific detail. Provide
> > pci_ide_init_nr_streams() as a generic facility for either platform TSM
> > drivers, or PCI core native IDE, to report the number available streams.
> > After invoking pci_ide_init_nr_streams() an "available_secure_streams"
> > attribute appears in PCI host bridge sysfs to convey that count.
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  .../ABI/testing/sysfs-devices-pci-host-bridge      |   12 ++++
> >  drivers/pci/ide.c                                  |   58 ++++++++++++++++++++
> >  drivers/pci/pci.h                                  |    3 +
> >  drivers/pci/probe.c                                |   12 ++++
> >  include/linux/pci.h                                |    8 +++
> >  5 files changed, 92 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > index 51dc9eed9353..4624469e56d4 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > @@ -20,6 +20,7 @@ What:         pciDDDD:BB/streamH.R.E:DDDD:BB:DD:F
> >  Date:          December, 2024
> >  Contact:       linux-pci@vger.kernel.org
> >  Description:
> > +<<<<<<< current
> 
> Drop?

Whoops, surprised checkpatch did not flag that.

> 
> >                 (RO) When a platform has established a secure connection, PCIe
> >                 IDE, between two Partner Ports, this symlink appears. The
> >                 primary function is to account the stream slot / resources
> > @@ -30,3 +31,14 @@ Description:
> >                 assigned Selective IDE Stream Register Block in the Root Port
> >                 and Endpoint, and H represents a platform specific pool of
> >                 stream resources shared by the Root Ports in a host bridge.
> > +
> > +What:          pciDDDD:BB/available_secure_streams
> > +Date:          December, 2024
> > +Contact:       linux-pci@vger.kernel.org
> > +Description:
> > +               (RO) When a host bridge has Root Ports that support PCIe IDE
> > +               (link encryption and integrity protection) there may be a
> > +               limited number of streams that can be used for establishing new
> > +               secure links. This attribute decrements upon secure link setup,
> > +               and increments upon secure link teardown. The in-use stream
> > +               count is determined by counting stream symlinks.
> 
> Please describe the expected form metavariables DDDD and BB will take.

I went ahead and folded the below into the preceding patch, and will add
another "See /sys/devices/pciDDDD:BB entry..." note.

diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
index 51dc9eed9353..8ea48b7aa996 100644
--- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
+++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
@@ -5,8 +5,10 @@ Contact:	linux-pci@vger.kernel.org
 Description:
 		A PCI host bridge device parents a PCI bus device topology. PCI
 		controllers may also parent host bridges. The DDDD:BB format
-		conveys the PCI domain number and root bus number of the
-		host bridge.
+		conveys the PCI domain number and root bus number (in
+		hexadecimal) of the host bridge. Note that the domain number may
+		be larger than the 16-bits that the "DDDD" format implies for
+		emulated host-bridges.
 
 What:		pciDDDD:BB/firmware_node
 Date:		December, 2024
@@ -14,7 +16,9 @@ Contact:	linux-pci@vger.kernel.org
 Description:
 		(RO) Symlink to the platform firmware device object "companion"
 		of the host bridge. For example, an ACPI device with an _HID of
-		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00).
+		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
+		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
+		format.
 
 What:		pciDDDD:BB/streamH.R.E:DDDD:BB:DD:F
 Date:		December, 2024
@@ -29,4 +33,6 @@ Description:
 		bus:BB device:DD function:F. Where R and E represent the
 		assigned Selective IDE Stream Register Block in the Root Port
 		and Endpoint, and H represents a platform specific pool of
-		stream resources shared by the Root Ports in a host bridge.
+		stream resources shared by the Root Ports in a host bridge.  See
+		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
+		format.

> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > index b2091f6260e6..0c72985e6a65 100644
> > --- a/drivers/pci/ide.c
> > +++ b/drivers/pci/ide.c
> > @@ -439,3 +439,61 @@ void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
> >         pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
> > +
> > +static ssize_t available_secure_streams_show(struct device *dev,
> > +                                            struct device_attribute *attr,
> > +                                            char *buf)
> > +{
> > +       struct pci_host_bridge *hb = to_pci_host_bridge(dev);
> > +       int avail;
> > +
> > +       if (hb->nr_ide_streams < 0)
> > +               return -ENXIO;
> > +
> > +       avail = hb->nr_ide_streams -
> > +               bitmap_weight(hb->ide_stream_map, hb->nr_ide_streams);
> > +       return sysfs_emit(buf, "%d\n", avail);
> > +}
> > +static DEVICE_ATTR_RO(available_secure_streams);
> > +
> > +static struct attribute *pci_ide_attrs[] = {
> > +       &dev_attr_available_secure_streams.attr,
> > +       NULL,
> > +};
> > +
> > +static umode_t pci_ide_attr_visible(struct kobject *kobj, struct attribute *a, int n)
> > +{
> > +       struct device *dev = kobj_to_dev(kobj);
> > +       struct pci_host_bridge *hb = to_pci_host_bridge(dev);
> > +
> > +       if (a == &dev_attr_available_secure_streams.attr)
> > +               if (hb->nr_ide_streams < 0)
> > +                       return 0;
> > +
> > +       return a->mode;
> > +}
> > +
> > +struct attribute_group pci_ide_attr_group = {
> > +       .attrs = pci_ide_attrs,
> > +       .is_visible = pci_ide_attr_visible,
> > +};
> > +
> > +/**
> > + * pci_init_nr_ide_streams() - size the pool of IDE Stream resources
> 
> /size/sets the size of/

Fixed.

> > + * @hb: host bridge boundary for the stream pool
> > + * @nr: number of streams
> > + *
> > + * Enable IDE Stream establishment by setting the number of stream
> > + * resources available at the host bridge. Platform init code must set
> > + * this before the first pci_ide_stream_alloc() call.
> 
> Is failing to call this a caught error by pci_ide_stream_alloc?

Good point, it should.

> > + *
> > + * The "PCI_IDE" symbol namespace is required because this is typically
> > + * a detail that is settled in early PCI init, i.e. only an expert or
> > + * test module should consume this export.
> 
> Perhaps start with "Expert use only"?

Updated it to:

@@ -480,17 +490,18 @@ struct attribute_group pci_ide_attr_group = {
 };
 
 /**
- * pci_ide_init_nr_streams() - size the pool of IDE Stream resources
+ * pci_ide_init_nr_streams() - sets size of the pool of IDE Stream resources
  * @hb: host bridge boundary for the stream pool
  * @nr: number of streams
  *
- * Enable IDE Stream establishment by setting the number of stream
- * resources available at the host bridge. Platform init code must set
- * this before the first pci_ide_stream_alloc() call.
+ * Platform PCI init and/or expert test module use only. Enable IDE
+ * Stream establishment by setting the number of stream resources
+ * available at the host bridge. Platform init code must set this before
+ * the first pci_ide_stream_alloc() call.
  *
  * The "PCI_IDE" symbol namespace is required because this is typically
- * a detail that is settled in early PCI init, i.e. only an expert or
- * test module should consume this export.
+ * a detail that is settled in early PCI init. I.e. this export is not
+ * for endpoint drivers.
  */

Thanks for the fixup suggestions.

