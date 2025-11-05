Return-Path: <linux-pci+bounces-40433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1107C38202
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 22:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 205AC4E4950
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 21:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A722E7F17;
	Wed,  5 Nov 2025 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJS++KUo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2392D7DD9
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379863; cv=fail; b=JHMdFvazJydxrH26+OPKaGtUUBgOEOPPAFJGKDlR4xVVs16RrNBKdS+uFnPQstfUnHVl/dR14/1k9OlRyts0SEmiMveJBOeStqiNM533iAw7Hn0b+T+SuTgMB9TlkFGWSiryavvT44JQxSnP/TquZr+C9uax3GxePqsH5iOvyEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379863; c=relaxed/simple;
	bh=iZWukgfXREVIUOTGEHV0TnR1ZdgXia//SEdNpEKWZ68=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=HV0U1a7sFc0oPF0UAHF/6JvuYJY86DIJxMXSr2S9urKcvp+m0i2jLwr5J0rMF1db3QWOnYvB4k2opgZxoTbe0N1goE2sxWfvH6AUTAddU+P3q3ytocBk2WMVW/3U9NhYcJq8SIAOuAr8P3iZws3VuUMe4f6qJLEKWBSkLQC7c8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJS++KUo; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762379861; x=1793915861;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=iZWukgfXREVIUOTGEHV0TnR1ZdgXia//SEdNpEKWZ68=;
  b=aJS++KUowfPiGrP3Nyk9m7K1XlOx19Lk9JvEbdNZ//MBZ7PEqZjR7BSl
   m2Z92Knz0XKR8ObuPnuKF/5dO5O/v2BUWSvyxXVy6CXxN+IFTocav8VbS
   cj60GD9xqnxtl09NTPZ8mAEZqayQOJUEkwbstexIJdxaDucPql8/U0tp+
   y4qIwNW3CpENFp3EUU/21838d5ICQumAdqNGZU0bZsaHETfvULYcucaV+
   0/MPLtBHsTaXYLQs8uqtTWSaCkR0lyvMZ5JJo36PRYSDAbZlmQEZ5yzU0
   kI/ptPZFDXFOMbteKTkls9Gm3cpX5D55nkeoGij/frBtM0if1bbv/X9bY
   g==;
X-CSE-ConnectionGUID: pj8CqQYUQ4Sl6XWFnsiiaw==
X-CSE-MsgGUID: kC+vEz4zS32HIGoVjvabJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="52076304"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="52076304"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:57:41 -0800
X-CSE-ConnectionGUID: peuU0hItS7KPVujpLyJrUQ==
X-CSE-MsgGUID: GWbWf2vZQcSx7EEYfnewSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="188295538"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:57:41 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 13:57:40 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 13:57:40 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 13:57:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDfgbQ6MgofWtqL4dwPeIMyMiqicAzNKv9U6x0QDXcQ3sJcsJTpEnW5QPL/nL30Uy2O2klw/8YY69tkrn/XJ5LpY6xA/KWzbbKuJ/dq852dtZMtQ2pgtUpQaV7ooHsy6IEmkiTQ8rtuKUPJqfFjxGxJ7LP/Q98rtFqyGXQAumE6AWPmz3ESaZ85D+jYjkMFmrKUHHcm46ZQh+xQ0b9a/5c19AYZlMA1mw9k/IjzPybR/1EeyzRoPG6WTM0K+FqibUYD/cNOO4YrwH6/fCtriJ0tygXDr9qFXi0ROb91E7C2h3vmGxg4tXnY03QLxjBaWtQ3jkA2AFzLF8R9Yo4aUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJp9vFOsrC3f98DbN0QYVREoY7bg2c3s1WY2wBPprK8=;
 b=vwvlDkVJsXKNRIsclbVsSgJZkkT8er2IIGQ63exLuwSEjdUbTu/1AtL8q61/grT4xdnEcExF09bS/vK81I+M0wvjWWg17XvqmPkmuc0kX3qqw60pzlxdexGhbL0KETdZ4cSp8pU7HT43DdbG38XWHMJByKvlrAfrlKbjTkTD2/Bkce1jDX68RLl/nkTW7eSQZYABfB9LDfDEId7L8kNuDd3DG7q4ZJOrATovD3AgHlvsGa6YhQoIHvFuqwzpA+0nYda/x3hIaUdfMIFZS5zX7Mrxyu71OjKSHkmAxsxZWvH0mpGvxjaOmtWCWfXRW/c09iUEXWOlcuNZwfFR5Es6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7742.namprd11.prod.outlook.com (2603:10b6:208:403::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 21:57:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 21:57:38 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 5 Nov 2025 13:57:37 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<bhelgaas@google.com>, <aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>,
	<aik@amd.com>, =?UTF-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>
Message-ID: <690bc851d7f98_74f76100f4@dwillia2-mobl4.notmuch>
In-Reply-To: <20251105091732.0000302c@huawei.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
 <20251105040055.2832866-2-dan.j.williams@intel.com>
 <20251105091732.0000302c@huawei.com>
Subject: Re: [PATCH 1/6] resource: Introduce resource_assigned() for
 discerning active resources
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f93477-e2ba-4a40-4d0b-08de1cb655c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzRFSXRyYWJqVkhGaVJubFUwUGRwcUUzaGpTWXJ1WnMwa1BucHhRbCszTjZQ?=
 =?utf-8?B?SkRnOTRoeElNMThHK093dUZtdWs5L29VWHdSMGVscHNVMHpoOVVHaFAxSWFT?=
 =?utf-8?B?bjExWkwvTzRCdGJYRmdyMml4TEJMd3o5SzZqMGlTTUFmbWFZYlVQQWRyZHRT?=
 =?utf-8?B?Vkt2VnA4VDhDbVMrdmd1SkhEaWhnaGpZTjFoTkh5L0hadndDblFOUmU2UXBD?=
 =?utf-8?B?VXFFbjFHTmx6QVBFaW5kWFlOdnQ2ejJuQnYvS0VqeWtvRzJqb0tJOVBSNWFl?=
 =?utf-8?B?VUZjSTFPcDBOQ1pua3VIN3RqZjRLVkxMenVYeUVSVEYxaHVLcFpBTFV3VHJP?=
 =?utf-8?B?d05jUkh3akMzTklGeW1mdk5oRG55cFFjQ3ZrbkprTDNlNzRTeEd2SzJvaG11?=
 =?utf-8?B?eEJWY0V2TzhDUzVWMnMyRDZMb0VwYnZRV1hUZkRXeE43V1pqdG5DSTFGOHVR?=
 =?utf-8?B?VGFqZWx5bmM1bW5BbWNEYndBS0lHdURwRE5xcDRhZjhOeFJTbWdRZ2JETFRn?=
 =?utf-8?B?c1NIa293bndCNGJza3NpcHljVWUzRDhibEo0MjFselFMemRJTnpwelRkaUJi?=
 =?utf-8?B?aXgrSytCdEJlVzlQVmJDalVPcDFvcFBmOHg3bm5yVjgrNXJ2RVVhRXh0SzFv?=
 =?utf-8?B?RDhhZjl4R1VnbFora0xJanNoSzRONHpUWDJ5USswQ1ZzUFN3OE4xTFBNZGJY?=
 =?utf-8?B?dU1BdGdxQS80TzJGU25KUGNKV1ZFZ2g2QVpyZ2FsUk13ME91Q1RBMHF5TGV0?=
 =?utf-8?B?R291TDhnSFkvcDJCVlg1cDg4R0JuSm40dWVEd1pZdkI2bkpiRHhSalh3RjFN?=
 =?utf-8?B?R04yNDFaVk84cU9ZRXlaOThRenhpMXJsQ3JPRGF6YVltN2NIMzRaR25ORW9T?=
 =?utf-8?B?V2VTSC9RK1Q0azBFWk9nZ3JRQnlhS21QRzlGa0VHWW9VZTNQb2JDZXI1N2Jv?=
 =?utf-8?B?QjRhRVRJRndiWWJZSTZnRmUyK2JEekVDZ3FLdW5ab3B0SGtuVElJREgyQ0Vt?=
 =?utf-8?B?M000WmEzeERzM1ZseTR6eUliL1pXR29wbHh2M3pIczlHQXRaWWtiMVFIRVpV?=
 =?utf-8?B?RnNuRHdnb0hsb2w5cFlYY0tDZk1SYmlpa0xsYVFubGF2bVdBTWwxUXhyL0ZE?=
 =?utf-8?B?djh2cTRBMDgyZWxUSkovNVUyME5qRlYzNlBrTGFwQ21YNlVvNVR5bzVNdnpr?=
 =?utf-8?B?bkZUV2lmQytLWFNBREZLa1lzZis0aDhjZHFTMDVYNWF0dmZNd2haRFp4VjZH?=
 =?utf-8?B?UGJ1RU5mZTkwNnYrVGN6dG8weXhKdmNVYnVYdW9DWTBRZWd4TzJXS2ZGdk1I?=
 =?utf-8?B?WG9QUHVxYVc5dU8xa2tRRzUxanJldUkyZXFHQjN4SFQ2TDNvM1lEd1k3Y0JM?=
 =?utf-8?B?VXJUbXZlUHpPUnhqSGFBc2lpVXJGWnIwY2Q0Tk8vNGZ3dEs3UVZBVjZ2V3lR?=
 =?utf-8?B?SU1FQ0hNbzBKN2NHL2pOd1FSR1MxWWtPcDRYYUNsZ0Yxd2draGZlWk9rQzVD?=
 =?utf-8?B?YTB2dXNhRTdRWXk2Q1ArZFQ3OTNyUHFabDR2aEp3cys0VGhoTWY1SHAzVTI4?=
 =?utf-8?B?UEhqVGZRL1VxV2VTdjFXMUJUdUZ4cXdnSURBUllUSzZMNHJLOUdsUld1bU9S?=
 =?utf-8?B?bzRKZ1BBallQZktqMjBFN2pDSVp3RzltYXBLN01ZblhUMXJYMHNobTE4dEE0?=
 =?utf-8?B?L0hGOCtHdnB6ZDEyQ0c1SjJ0dTUwS0F1QU1PenhLaWovTHBieGhINXBCY0Zu?=
 =?utf-8?B?anZkV2VITU1oWEtSS0JPeHlDbFVPNFV2ZnNST2cySzFxTi9VU2dMQTROWmNq?=
 =?utf-8?B?V3U3d3lhcm1mbm1SMG9kVkozelk2cWZaaVRmNG9kSk50UGpUNWNBM1dNbHJY?=
 =?utf-8?B?UUQzbEtWc05NRHhST09oNDhMcEN1NHIyT3BQTjRxR1FTZ2NzRXdBeDdhK1JR?=
 =?utf-8?B?cXFBMFlpRlpCRG1DazhoTmJFcnkwQTV1QlhuTnNKNXpGTi9LK2VDV2pqWTNH?=
 =?utf-8?B?dGVqcUwvMm1BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3lQZm5Pa2VMLzl5Q2ZjV3pscGc2eStkQmtEMVJDcVBvSWFCcldocmZRS3du?=
 =?utf-8?B?eWFXUUtlT0U5cDNRRUpPNGc0dE9rWFNhQXZ1QWRidVlsVjRZVjhBY0tuNjBv?=
 =?utf-8?B?dWJXSXVYOVd5aUlTU2JGdm1ycWV4L1hRV3AxQVdwNFJMbGR4ZDdESzBIL1ZE?=
 =?utf-8?B?NFNTeGZEQ2F5L1VFb2hIRVpzSHhqZWc1RWhzdWRydmhHaldPMGdsUTRhdzZC?=
 =?utf-8?B?R1lXbUY2aW1pOXhCcDg0YS80S0JMQ3VpYlJJUGN3NldsM3I2WFRiVWc0WVJS?=
 =?utf-8?B?N3RNV21UM0dXUVBnNTJaYmo0a0xnRmNXUHo4VWhKK24xYTltM1Z6Y2IyVWpU?=
 =?utf-8?B?ZjlGcEJnMFdVckVPMW9vNGJ5ajJKN1FzSlgzY3BVQng4Y1poTTlxT0NVNzBR?=
 =?utf-8?B?a0VZWWdpcnlscTR4NTUybnJFQ0JTK0hxU25PalRIcDk3VnlUb1VwS3Y3bkpO?=
 =?utf-8?B?ZTU2dXpkZUxZVXkzdS9UZDFMVEpsMnNWRVFwZUlXcmNScEU3aGovVldUWXlt?=
 =?utf-8?B?cTRXM0JQT2NsRmxvRnRPejZORmpaQWEvbklTdkVFNXFvcW1jMkw3cW5PSXpT?=
 =?utf-8?B?cVdHUVNoVERHMHVrS2UzdCttejFxMmdDWXk1ZTJJR2xhUHNNY09EVnpyaHo2?=
 =?utf-8?B?NUhwSjY0WE5XZE1rSkFNUk1MWEFjWGk2dXF1aENjNktYcjJxaEp5NlFEWm9k?=
 =?utf-8?B?dE1IWktQTC8xTWlWcEw4OW80RUt0RXNGVUFXemVtS1VoWHVYVFpQdTZlNFEx?=
 =?utf-8?B?VVpHeWxrNEt5VGFqR1BZRFlpNGJUWFpSaERXVlJndFQ2NE5WcitzQ1pEOXpI?=
 =?utf-8?B?a3NaVFRFSkdRRnA2NWNUTHNaV2NBanBZa0ROUlN4Q05CZjUvaDJUZnhMclcr?=
 =?utf-8?B?eWIrTENiUVZqLzQ5NWUyeE84TWIvbU5tdzBKNXljMk9HT29qcEdUM2ZMUnpZ?=
 =?utf-8?B?bnNTbUxiZ2JHa0hmWUltVCtFZDdiamlxRVh6VHRXZmd4WkFDbTBiaGlxczBD?=
 =?utf-8?B?cEV3c1B6clVxdEY2c05qMy9WRXROYWVETTBLU2tEaXQ3amt6aU9aTithM3RJ?=
 =?utf-8?B?ei9LSXF1WEovL3FUclpIcjZZcmtHL1Q0Uy9YNk03aTlCOGVDM0hROEhDQzdi?=
 =?utf-8?B?WXMyb1duYzU2WHhCVFNIdnl3TDNJSlc0MkJXOWM4YUdVUm5wZ0kwVXo5dFJp?=
 =?utf-8?B?a3FXUHJRcjl4VG40VmwwZ2VJN2t6enFKZ3FnNHUrWDAydkVTTFp1TkdjM0JN?=
 =?utf-8?B?N0RteFVhN3BJMVpDRHJIeXRjK3M5RzV5YUpXVG5XQUwxTmNWSENER21WMUF1?=
 =?utf-8?B?d3hLdHpucE9VaWFIa2Uranl4SlVxeFc3a2UvTE1ldnVsTTVKbFNUSE9Fcmtn?=
 =?utf-8?B?SU9BSURsVHpPWVRoODRxY0ltYWZrQVJsTmZuMmgxSHJoN2hIZlowRzhGZEM2?=
 =?utf-8?B?d3NicWpmRUVDNGcrRGYwM1pjbXA3RFBpNkErZjVlbXphK2poQ0ZZK0JYRVRa?=
 =?utf-8?B?TVlVcVpLR0ZFd1h5OThTVWpTMGQvVENVdDN0VTVGWmg1bGwvT2lyYWJaVk1R?=
 =?utf-8?B?ZUh2bCt2eThPOEFHaEpxbGlFMFdLdHhseFBLNlFLczdGdFA0NFpmcE4rS0o1?=
 =?utf-8?B?a0F2M3V6Z0lWRThXQ1BiK3o5Nmo2MWZBT2tyTlo1UEZHZEp6bmFuTFVpMDI5?=
 =?utf-8?B?TnhtL1JZbk13TzA0ZU1RaWRSUS9xS2xCaTFmS1loOEN1d0YyOXh4b3NzU2g0?=
 =?utf-8?B?cWpoajEvNzVOeXdEUm5QZFlMb2tpUkRBbldITXl2a3VLZDJaOWFxMThzNnVH?=
 =?utf-8?B?aCtGZEJZZGxMaFhtOVNCVGpTYnQzYnFoQXRVWDloQ0NCZHJYUTRlY1NsaEpz?=
 =?utf-8?B?NzNWcC8zR1JYK2o0ZGVhcVJjbGI1RlhIR2xSOWc3TDRyblowQXVwUm93ZWI4?=
 =?utf-8?B?akxrZVRtbmhoOXk3SUNhS2pkZDlLWnFQTWp0amtyNEpySHd6VThLS09DK3ha?=
 =?utf-8?B?cStDZmxCc3ZiSXZEYkRmYTl4ZFBUR09vdWgrR1A1SXJ6RGhzcEgxSUI3dHNL?=
 =?utf-8?B?VE1vbGxBZzB6L2NHbWVYVGdRMDV4K2pUY1ZIY2V3cERmeHI5dVlWR2swSDN3?=
 =?utf-8?B?bThDQ1dDWDl5Z1lTZHF0K0lxOXlHblpsY0ZYK1lQTllXejAwTldNRWtjRWcr?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f93477-e2ba-4a40-4d0b-08de1cb655c5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 21:57:38.4141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLS3C5rBNn8JiLEPIToDEtaMxkcYj1UsKsgh6HV5Nl04LDf4Znj0HbrXeaN69/hFsNQmdn08wudNT/t9FDwtYrZEQ9j9UJ4iiaKjbastNB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7742
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue,  4 Nov 2025 20:00:50 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>=20
> > A PCI bridge resource lifecycle involves both a "request" and "assign"
> > phase. At any point in time that resource may not yet be assigned, or m=
ay
> > have failed to assign (because it does not fit).
> >=20
> > There are multiple conventions to determine when assignment has not
> > completed: IORESOURCE_UNSET, IORESOURCE_DISABLED, and checking whether =
the
> > resource is parented.
> >=20
> > In code paths that are known to not be racing assignment, e.g. post
> > subsys_initcall(), the most reliable method to judge that a bridge reso=
urce
> > is assigned is to check the resource is parented [1].
> >=20
> > Introduce a resource_assigned() helper for this purpose.
> >=20
> > Link: http://lore.kernel.org/2b9f7f7b-d6a4-be59-14d4-7b4ffccfe373@linux=
.intel.com [1]
> > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> One trivial thing on documentation style below.
>=20
> > ---
> >  include/linux/ioport.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> > index e8b2d6aa4013..9afa30f9346f 100644
> > --- a/include/linux/ioport.h
> > +++ b/include/linux/ioport.h
> > @@ -334,6 +334,15 @@ static inline bool resource_union(const struct res=
ource *r1, const struct resour
> >  	return true;
> >  }
> > =20
> > +/*
> > + * Check if this resource is added to a resource tree or detached. Cal=
ler is
> > + * responsible for not racing assignment.
> > + */
>=20
> Some stuff in this file now has kernel-doc style comments. To me it
> seems like a better idea to use that style for new function descriptions
> whilst perhaps not being worth the churn that would be inherent in switch=
ing
> all docs to that style.

Hmm, ioport.h is not included in any "kernel-doc::" statements. I do not
think this tiny function that no drivers should be using needs that
formality. It is an internal implementation detail of resource
management, not really a kernel API.=

