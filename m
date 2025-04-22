Return-Path: <linux-pci+bounces-26444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B38A97A70
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 00:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B95A7AEB92
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 22:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B59244687;
	Tue, 22 Apr 2025 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUAiTsFD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E81E990E;
	Tue, 22 Apr 2025 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745360694; cv=fail; b=Ua4W0k8RmKfSZeIi0P6cjk0n6eP4T0EPajIo12vIwVcjI3frAsAVXMlzC54HSX7+ru1ctdIo80flr3C6lHJj0evrwpMdqztg7W2AZsfAQwrDSBaEX8PQnMwHMuV7nBrBXbUV29DqEbKEPsffk7lwIYEPa/BLiTz5PL0jGBcq2H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745360694; c=relaxed/simple;
	bh=SK8grD3zzXTGeOAL/vWKosDFsE9SCVOUG8D4xV2KKF4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WGIM6KXdXnf7iHX06ErQcVXueLOGVoGMChan5rkN5F/m9eHjNAM2MqYQPPlOqU+1Q8pPMwMbRhufCiERucRTO67aLHVTB6f6dHEkh6iFDAKgfeMFeXZxCg/GHZn53iPADnDGP6U48WmG5yP3SsoKfpvnR+LKcH6bXFV3bQO/3gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUAiTsFD; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745360692; x=1776896692;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SK8grD3zzXTGeOAL/vWKosDFsE9SCVOUG8D4xV2KKF4=;
  b=bUAiTsFDmmr2Q7bOySmTOGxMjk13vXHMK2bi/lTrrcfkTxj+MHv8P7Qc
   +lv92k79d3z6QQvwAXPYdgl+vDjvyL4a7lEeFoDh73y5EUM50F+LStPi/
   YTieQfgYin9az70bpt3S0OobzoRSFGB1LHWNdr7uV6VJvt/yWeXYPN9dv
   qJb+/Oq0kXwaFLgVfMVeG9LCq70F9oV0vYsPW5RbKlz7RAKG4b+k4JCe3
   zUhA+TKzCf/s84jRF9aHsibknoDxDRwby5zbT7HqVYo1peqgbgk5bODQe
   tKUwHyZoaVwkTfXrf3AxdUliqstUw0yPvrEjayeWZyKU/oyVMNKaoErJh
   Q==;
X-CSE-ConnectionGUID: 0gjOFBQtQBCtoMCPOKH/7A==
X-CSE-MsgGUID: PzwRiBgDSXCy7A3t9eANsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57594627"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="57594627"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 15:24:51 -0700
X-CSE-ConnectionGUID: xnVzS8tdSYmmylSaJCyi/Q==
X-CSE-MsgGUID: z8kF1iJFQm+NUXR06gMqKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="132443809"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 15:24:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 15:24:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 15:24:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 15:24:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocpAIB+Zi/ykO17DBnYwhh9MpFc8h6L5pEXo8t00en8RxphxAAYeHLCoaaec7/ecztakGAR+yCRwz+JK3TA0sAIcvyW5vSIO2B29Wp/CnveRNWORjE2drc3BmNPtS5jiZ/ClZwlKX04G9ZAILCvqJt4JGipiTkCIrWRXhWSE+e7GCC4TYQXeMit05bh0111M4d5aIxd7DJ/E75V15THElX1GacEu9iD4oein0hJ0l2lNfsCa8Lbh8A/Lu5puHGTNZTbYSM1TbUsa6CnrLT7tXA0Q7IrCa1+zNY2xwkLcwIWih13+XkKrRdb3FVqdaVM1cUn++qbRaBN9aDNGvl9dVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIgaBEWbgud37nEM3xjAOChwXBzRDAcXPGjCbEK/7wc=;
 b=J4cl5XB587IhFqDtFa9nmyqncmfAWqdd2v8bcP8Sbt0nslWhbsDfQLm4mXF0JAQhaigvajulFTMhkgUphPvSv5XKDmbr4cee0Vp1YeTc+N3s9lzJ/oWE+aIzPXgsmR1XrAUQi5QOrSaRG6eXBjB0dbp8qyeX24Off/9hDIXAmk7JPKENHh4pca1zX/p9f68BVBKdTiJUEOP1lsIPT1LbbDQNdIC8RSkFtQ7rzPAAGqVWaDU1ijhklK1O0Ec//bkUl4inaW0wHfwk/hsd+uUj0FKiP6TEhrtCnDF/m1ZfIjdBoQ3rPwKmOXTmD3cjQbZ+MaFYbmkIbraknW52MA6kKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6364.namprd11.prod.outlook.com (2603:10b6:208:3b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 22:24:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 22:24:20 +0000
Date: Tue, 22 Apr 2025 15:24:16 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Ilpo =?iso-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: Add Extended Tag + MRRS quirk for Xeon 6
Message-ID: <6808171089b0f_71fe294d0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250422130207.3124-1-ilpo.jarvinen@linux.intel.com>
 <20250422200857.GA381276@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250422200857.GA381276@bhelgaas>
X-ClientProxiedBy: MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 751b5c7b-a82e-4922-883e-08dd81ec6d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zwgVEudIBBlDUWOXJLRr6Ovy1a8HX/9tuzkracb/SkIdFvtIBpOBK6HoQDZK?=
 =?us-ascii?Q?7HaA0Ef3qWiDC1VhV15bsnBdRJMqt7kUbr3YGBJJNDAD5XlkuCw5dHUofK4l?=
 =?us-ascii?Q?GMT7EZ0OAquzS+bre1fmvxLq3gketGvlwjL4KWfyc/u82Q0tAdHY9RdabpVA?=
 =?us-ascii?Q?cft1AdQuiJp/n4UksvWlynbbi22Xs169sNoNodtm2EW/xfM2B/oRCsMCPz2o?=
 =?us-ascii?Q?R+9Q+rqbr0z69B8YigQh2bu8n1WbA08ry/btMlUIDYyrWYLbJ0dRBIp/KRHB?=
 =?us-ascii?Q?D9XAEI5mLyp7BdlxJIQm2utxNvfWqhIQ/Cd8r3zGGl5ltJeBeCd6UGHNnSB6?=
 =?us-ascii?Q?GTw8ij2aS/l4WkA9WgmZyJAMSoYYcb74qWNoL/kVCobrhMtBQR7sYaofm09C?=
 =?us-ascii?Q?5b4sLQ/szsb57gYIwPp51yRTWGrvUbClcJqTHemaHW2LJHdLXmFV5sMSHbvT?=
 =?us-ascii?Q?aqE/ba+bqLSwGOehYzVB+aw56ulqk5VgHPaCsFEkMSrIEn8qZ1KfgHxAvzno?=
 =?us-ascii?Q?5isOhVdtsfOJdTlqVzZsm0cKPBJEON44GhNmrUVDcrl8bBoOMxSmHZkwSq7+?=
 =?us-ascii?Q?gKWYHs81W/k8xZVhHVFLEVuiYFS/Kq/EBdpEOLop0zPm6hTOr5bOOhmYLdD9?=
 =?us-ascii?Q?GBKogsbEDIzxX3M6fGOLMxwm2/15IaAcR46xJoy8LlHtnmCKp4WPaPspF1HX?=
 =?us-ascii?Q?Iao+KDr+WLpFFXSolRMxCm53WnRcJmvN+jVdAxnSvop0sfDe9drJG02ddjrI?=
 =?us-ascii?Q?rceAzxeIWLay7XIAqrjwUm2rsnxfsG2flUyDCBqKx5n9nooVufgXWS9aqTIc?=
 =?us-ascii?Q?xFg2ApKbhxfTUsAnHkO+FzvAz/sxcvd8fdsy4ObnaSusbzxXIJAe81MhYhNb?=
 =?us-ascii?Q?1WWKJ8ZLSrTy/brLtEcVEunSggy1IufA9WtFr1SuVRFPjl+ulBJJXETDb2FW?=
 =?us-ascii?Q?fzpfkj+2IO+WNaBRDHiXEEqxbnBeh266lsgx6F9t2hHien7et6727Kn3YYSN?=
 =?us-ascii?Q?EraYxZqXLC2mf5dsco1kmnMChQfjOoz3Pze7PHtN8mmPCFeEtLCUYUlh91Ay?=
 =?us-ascii?Q?xhqxpABxqLkRsy7exdEVgAmninGCpi9fCvGlp5h8geANJkyJr1JLu6kP4eSo?=
 =?us-ascii?Q?pdxxPXppFZcslU9bGxYZ/V0bVcqbzvbOg+AxDb39yZt9SUgqfgfqT6E9K54e?=
 =?us-ascii?Q?VCTJOss8Z6wSAfr7dsyHKEkb7dxqmeOvGlH1QQ1VzCHFMsEW9T3O7ivzpOwq?=
 =?us-ascii?Q?jItIzzjD4TJnJ8ssnIf1YlnBVrq3eCnqqbO3ZE/9guYGjgyYUdzosoGhVaH/?=
 =?us-ascii?Q?CAIY8rhM+OlIOAFXfi96UCRFx8fPVHQ41N5e3+zQfiPDBdLpZsoZpcHq2OIE?=
 =?us-ascii?Q?vEskyEokSyPdDmqyt89eeh5J/r3xtX7HEJOHIQyFPhVenK9IjoxaLaLgOmQC?=
 =?us-ascii?Q?la8VFLIAK00=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cdUE7gOFqPwqH3YDor/7nzo//yonTGRmJb50HSuhaeS0tmKH6vCDPtaahoeY?=
 =?us-ascii?Q?nxkUKu5hwAbl1poA2Yr7Wknn3IC/sGcKd4iMS8j4GaOy2lz9Fi5f1DAKqSEz?=
 =?us-ascii?Q?dDvOZ9wmasUu52BZ2vbtonk/WMnFpAY/wl9geSikIXuDlgRSznC0MTSTXTFK?=
 =?us-ascii?Q?F0iQkvWjzptXvgroDPzVr5py8xBkNsd/+9Hdg22we0aPeMLgBjaBQYzwA2d2?=
 =?us-ascii?Q?EJWIW0Tk4JglotiVxAeVcmK718cWdLp6MIZ1BipUT0u0jBuWSrxhxR/PMU7V?=
 =?us-ascii?Q?XdaAfbFYJoPBAU7sEnvR1XZmxG/+6GkkRm+1+okmncKljhiKV36x1roisO2x?=
 =?us-ascii?Q?eLN+rn3xqgezRLsJ2eqx+uYs2F7plElq03+CsmP5xISs0R/2WjlCOkev+vM+?=
 =?us-ascii?Q?3PHKsmRIHRcn5YJBMd0LNav/Em4ilc+j/Z8uwme+ydy3O5xymvhAriQEUxbr?=
 =?us-ascii?Q?T7xxtjSSSsHRJrwuf1eA8OexM4O0XHmxgzyXxndYGgnKgglhbDa8hPM83Omd?=
 =?us-ascii?Q?qoT6ucpnsFWZgPyvxsRox8QMniZiWwDhODsDTslPgQwOQk3/x/1em/EOgpFn?=
 =?us-ascii?Q?Jx+bZyf7k3RBtiRw03/Dve2hdVQsgrBpghl0cCRdukBIY0jtKiOZ4gtYIkdv?=
 =?us-ascii?Q?rTqvI6tm924dLFKBot+QiS4lkOCzhn6/ico3lw3Guq2R4z7J1GYnr42EqhnH?=
 =?us-ascii?Q?QRx030ukNmJV6J4vvUks+F5UJc8Ef0bmTaQU88dd+D2mLG1V4fQmOC+xGcQu?=
 =?us-ascii?Q?cHVoME4059LJ9w/WsjJDyL/sbFDx9UYBiqSJfhEJN8xHl3eBqKs32+38331y?=
 =?us-ascii?Q?lNTEpN5AwFS+803e2RMCnJpzSuntHa0F9rhPcEE547e7qb/C4XCDdegjk9lt?=
 =?us-ascii?Q?QweiBEm1VwmzvzSQ7tRsVHz31H5Ur1BVmhJ1m5AWKs0NjswRNkrU681Jt/1C?=
 =?us-ascii?Q?I5GW1PhHMpQ0AUoyOIhrGU76SFr1iT0iH4ky9B2WdZwTrC3qMeATQhVGsfv6?=
 =?us-ascii?Q?Ta7m+vFm9Ge7459gsEGCMpOZrvGzt7oeijC6241ojBhj9bWngzI7buOYPwO5?=
 =?us-ascii?Q?B1KE9eO5zjEYcfdy9vJaGvABTK0UOZ4iQTb3+mZ/lO1JNUl4gu+gJY6ywBYJ?=
 =?us-ascii?Q?HQ+lFA95XIvoesiu9iaBiLVkmqZ2Dw5pv0Cvyf42bcOGwK7/13SAJar54Irq?=
 =?us-ascii?Q?Kz7C+NhjidxHZjmxUTnnAjPyvDbGDYTU3RsI/e7uurD8hYVGilc4l4hZBFRa?=
 =?us-ascii?Q?XIRWLgnEb5zr9VjR/ND0/V7nFwAkuMmz8PYNyV6THUtXImCxGHMtvScQCUf/?=
 =?us-ascii?Q?zaCWqRY0l+RuE5K6F4uw2uDYDZtsKBlvNu/92SrwCq3HNvHEW6ezpQq+fHlG?=
 =?us-ascii?Q?8NelcDUucGAQfZNiVsi5cFcCFEzWjMAnJ1ExaAyQehCkZtYlk00SdWfKvnMh?=
 =?us-ascii?Q?xlr+s0k7vA7QtOPiUfpA8K4yhvZqFSKA+z/huv59Jm5fqTXaUXMplzUBYnPM?=
 =?us-ascii?Q?jPUO7wSsOL/3AYcJIL+9CeioJ0DfuooQ+ZTHtlASuhvn5nH5LDiOKdffKDWn?=
 =?us-ascii?Q?vWfTLH618WH5rtOd2hxTqlbm4knQJbmUSep++/E5GqN9cmhF9//0agaWtIHx?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 751b5c7b-a82e-4922-883e-08dd81ec6d27
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 22:24:20.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZIwRZME1tt7OwrHxewTs5jelfzfq7tSwBrcuNvVUURRRIJQW3QAXExKt9rnLp5VhHRSdSoaOOHN5NQS9i2UXTjR5XEbTCR3HV7PwVqZKy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6364
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
[..]
> v1/rfc: https://lore.kernel.org/all/20250304135108.2599-1-ilpo.jarvinen@linux.intel.com/
> 
> I suppose it's quixotic to hope for anything better than quirks that
> have to be added or updated for every new processor that comes along.
> 
> ACPI _HPX might be a possible way for the platform to tell us what to
> do here.  ACPI r6.5, sec 6.2.9 says it's for hot-added devices and
> "Functions not configured by the platform firmware during initial
> system boot" (how are we supposed to determine that?)  In any case,
> Linux does evaluate _HPX for every device in pci_configure_device().
> 
> I'm not sure _HPX really works; it's very general, and I would expect
> to see reports of problems if firmware really tried to use it.
> 
> Or, I guess a _DSM function would be a possible way to communicate
> this.

Ok, I am reading this as "Maintainer asserts the quirk is unsavory,
please make this be something that Linux can ask the platform firmware
if it needs to apply, or make existing _HPX just work. Either of those
is preferable to a new entry in the quirk table."

