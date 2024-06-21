Return-Path: <linux-pci+bounces-9087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B08912DC3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 21:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74409B219FA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 19:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1AE168482;
	Fri, 21 Jun 2024 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcx1f59A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC89D4644C;
	Fri, 21 Jun 2024 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718997472; cv=fail; b=VhqCLs4nC0C+o1myFHEx31j6zwSFXeuy1b5mZiS5LDll8d2St3RhBwz/ty/MgIdffglWGenr2RcBJwW3beeUECw0Vv5kEb5uQV2BwmAUvHsFZrihXnkg+tI21tD9R+ulW6dyoY6N9ZHcaaWx86Mxs06RqofQmATtY1mQlEGIokw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718997472; c=relaxed/simple;
	bh=RY22QG5u1RtkT+UWbDUfl1Xt/vqPy8RNkFhSI+Pex6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l0xPFkRy3Ux+hTWG/5NcWrIG2UOC7cwwC4ZWFAc9MpdQsU3tsXevfgiStdW3lpvR8cHzX8LHEcGT308Y6FYIa5/EdrKZ+OMQDO467D/8YkgP35QvT4h0tVyfFMNwaIhY17QPWqAD0E8vJOCWBpcr1TfDrqkKJuH8o8IYnTkbgLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcx1f59A; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718997471; x=1750533471;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RY22QG5u1RtkT+UWbDUfl1Xt/vqPy8RNkFhSI+Pex6c=;
  b=fcx1f59ATi+MSFumYSsXAiPUpqQQi0deKLIFX/GT23wi51gTCRVqvYFO
   QhiRRmHDOO+rRzBXNk8rNpcMNagqYrt8f6+PeLY6uAFDACbL8CyqdBzAj
   qhy1jBnWB1KlnnlLzOEoOUefpzC2LkN9kDGG4cICDnIUbsabeXGVfx7v7
   trCVgeYdrNdT2iWDNXNhVI7ZeTyMHEfkOP35AMRsFqBGVb4YIcuMc5MHz
   hVMpMIels86xkYWOfPb/C1SWnLD9uIfPP6yZhNsMC9YOMk2BcfmUuj+15
   kNUYi6Xn9I0vS4ZK1E/SkKA66cZwcXQO5FjcvL1mCuSz5ZSJpPJispcGR
   A==;
X-CSE-ConnectionGUID: x6xLJDs5TNq8t6SOMaMxyg==
X-CSE-MsgGUID: NY0Oaw6OTsemar0WBTRZvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="38565809"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="38565809"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 12:17:41 -0700
X-CSE-ConnectionGUID: K8G4Q4TCSQ2sdrBFevlgsQ==
X-CSE-MsgGUID: 5rg+R3kNTaeEUdLGmNFzTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="42755582"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 12:17:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 12:17:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 12:17:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 12:17:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 12:17:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JU53m8VycdnFyKDc+vtifkSS1S4XHsj4m1pqmjYtw+gD1DVjOhggfMwFAcE4txhkhgx4rq2vArfh1LxotUKD6+1kp7RjM3/qtAEloKatgS1ogQS3X/cAPXA3mfGdDRut8ObX8ty4OGARCo0qaswPQH9n+h75SQqhoKkP4NEQhrNeoRyE+cExHrPgfn3jJgkmCc3jqPw6bU98PxoSAptOi1Stu+T5JVK/1t7AOygB7Jcd6TxEo4YRFbN73GccpU90B709PhxJFEvXqIIMj3+U1qRA+FGQR2FNePR8ZmuPjr+OnPGy2silhONST8Zy6CO4Au+ibPz2lzP7tbmgg82bHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m286nHi/BH4GDT9FoqSEbvmTkYrRxwFwSkqBHeOyiPs=;
 b=E+IWvoeK/0p29ZPjzaxpUUKb50SpfVSB697g/iXbFdtI9iEOx2dZ6ei43uUk4LULmVfqCXuGUOMUGMxEaOHuVK/leTQSzhr4PV44xXkDe6UJexn+YNSirJQsvSiiXIjmp+uDaV5tmASQfCSI1L/fE4X9JQonKUkPy6moz5hqCtuESElzSH869RGlI6xc4C15QP6fILSaCVvJAQK/c/O4ARfz1B/1Yxb3IHkJp7rrW59KNdo4oJsQhMXTmUZTOmzFiVhgQt9nG3K3cGAU+c173LMq/fCCXwEzdJTj7at/HyiABea3MPunMkUT5gB4On2QsPw9YJDwrSt03z4MfyvwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7062.namprd11.prod.outlook.com (2603:10b6:806:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 19:17:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Fri, 21 Jun 2024
 19:17:35 +0000
Date: Fri, 21 Jun 2024 12:17:32 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] PCI/AER: Update AER driver to call root port and
 downstream port UCE handlers
Message-ID: <6675d1cc5d08_57ac294d5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-2-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240617200411.1426554-2-terry.bowman@amd.com>
X-ClientProxiedBy: MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 105af392-0778-42e1-279a-08dc9226cec0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021|921017;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cLm/tfPYvuhPLRjbNWkYV1PZmSX0rh/eq8ZjeR9CuDkN8rrVwby3XGXeIMQI?=
 =?us-ascii?Q?rQxbr0TkNgNJntfVMqYCRKLnAZER3yinu91eD+kZu+ZFrsHIpyvNkjSt4e1S?=
 =?us-ascii?Q?Ab+ekzleAVX2gBKpWpNjiIifNoAG06+GQfbL2k9hIGKQcIxAvPHf27eynq86?=
 =?us-ascii?Q?/QNfJKTjLzM+ubwTkvIJW9yXv5tH1m41un74fGxrtC165SsF33Jv5rmr75KD?=
 =?us-ascii?Q?Ser7HD+rFcZuHmw2YTMA1W2OpjXegZnj9WrvIRbhYuzZt5v5OowcSxu4cpXg?=
 =?us-ascii?Q?nSnNO26A2kC6qgXe42FQWwAbjAYR66/Zuzx/HIusgDrZ9ej3Tdtdv7KCLhyT?=
 =?us-ascii?Q?IEXkP1auFR6+CZFscpKT009eUo/V9kFbKuQ5vaXcBCZGDqc7vwRyXljw2Hx3?=
 =?us-ascii?Q?cYRbW7C6d6eYzNG9C5oFM2TZ5tLkrBAHxnOFzFcU3l4QrYmZz5BqXE8bak9R?=
 =?us-ascii?Q?AX4mHVt7Ouwh7ldlpF7d3KyccAPZAM4FxLNj2lMRfJBS6H575hMezFocWUVi?=
 =?us-ascii?Q?iUXoz/LYg4zVUuLDTbZNgtMRvVyvhCtLcJZTXM+AG7qYGrM6obpCCZsUHjrF?=
 =?us-ascii?Q?pPnzWJKGEPssK1amtA40MACUKFQ3nOMDFlOQU4pzWTXcqzdG+HMbruDQN3jd?=
 =?us-ascii?Q?jrMH+tpQsqK8uC0iGHB+AUSVyDkikqaTiuMdQPCCPgwr3koGug8A/hnDl3VR?=
 =?us-ascii?Q?FwDJT8FDkDszX2CNbX93GFBi+8YKQBk4ml0QC2HiP/gMqPyvjdYYe2CQgpC/?=
 =?us-ascii?Q?q3SC2rf0gav0eiy4MEstRY4o00DYPh22xoCj+OcbNysEI+ryYfFPg2Qogw2j?=
 =?us-ascii?Q?5O2NkfPC/5uksC9w8BoHE1Ib6SOomqCCz7bJhz/PB1cdsfXFXsowGrYiXPqv?=
 =?us-ascii?Q?7sxfd1Hxt0tWXPw0B3GLyMCi8CKiOxKbKFsx9F0tFZFF7ueMvDXbfuPM6tf8?=
 =?us-ascii?Q?Od9QaJo/7WNKN1jQ2dAtIq4Uob/M58KX2xFIGYT/6KNGC7kMN1GOVkH20cMA?=
 =?us-ascii?Q?pExN2QHl3MWSBHefb/HIL2+04qVO1h5Ik3HjNHoD4enwm+a3f8keOgQX0+gP?=
 =?us-ascii?Q?+lgfPxOHDvUxwY8X1eJxnR24nGP20uqbFVD2wr6OCz57tZk7ohgvfrfgIyeJ?=
 =?us-ascii?Q?XJmRtNT9FgWuqh+CXtfZlpUZOklPvGRk7M11JB6/493OSrpMf+bW1api01ag?=
 =?us-ascii?Q?Zm50Zt892j4QPYz49lHVkFoObuScxTyTDrC0bH+7eCgYKVqWFnBE8GjWZwoz?=
 =?us-ascii?Q?FakvkxSyGHt37LMBVhiskI5EGh4OANMkGMeSqvouxQeJj8pnBm1kU5pP87AE?=
 =?us-ascii?Q?QnYEquzv/RucRdAn3749Fwzbf2EenhOdVy6CcN9R5X7ZaXy1M3TfzM8UREaB?=
 =?us-ascii?Q?1+G37BQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lCtMGiyweEL6Bpcbe2bUFGChXWPmT89Rrh6rLPchok84rtGq4Nc02uXN/RSw?=
 =?us-ascii?Q?cyh2xOk6Q5uoijlFDENkYrNtNv6SHC+xFssWxb0X3NEXd6mBdlq/H/Bf18UQ?=
 =?us-ascii?Q?IIiAYHcXTblaJCpTMtJLmOl0WYfEbI2szF8wDGd1elJKOc2g4wKWrcNxG2VW?=
 =?us-ascii?Q?mVBXRi4t/ChpF+0asmN1UrRNlzhG5yTmIIOp2W4Ifzfedk+0Ns5MCafb/MwP?=
 =?us-ascii?Q?TPI7Cure50URYy5oIRCCT4qlYbGKH7IEZkkYlrHqkNmWphmh/H9i+6xgkvmb?=
 =?us-ascii?Q?ln1rBrH/rOyI1koaBcfrzWNHWKH9HVjPK2KPpex7IjhkS27dQgTCZBtUWFvv?=
 =?us-ascii?Q?lRXkbcHL3gHBnNxVTUt47lH4HggvPxfi6VhoGk4YRJv6Ps8g+fjhqXTm+KEN?=
 =?us-ascii?Q?vohsKt3p9eUtdqGj9t26ligrUpi4JMHqjkp4wXKahpBMAthTpb0TnzxTGQCB?=
 =?us-ascii?Q?QvZa5kVdHRADhLqM2ILaZpbRGfqai1665gWfMW+ieZ9Y/xICo+2iNfbt16If?=
 =?us-ascii?Q?iR3GkZa5h2MmAsXZo5e7oCNkvd6734IZo2TWwVnTGAPPoakAdQtjckGXdhIA?=
 =?us-ascii?Q?XC/RzEVxVjLT7Tc9e2uGomv+Gpf55Z+QYks6G7rI987Ft2TSXo2QIA0+bv7h?=
 =?us-ascii?Q?twbnfzo7BPsHZOGncuMk08f6n4kM2ep+0fDnvJixjulvDtHN/vsq1FIah+2W?=
 =?us-ascii?Q?Z3Ch/B20P+vy3g4hxmGs2uUiOyTnEulLly9wyXKqpu8Gd9oT68uLg8ED7IKs?=
 =?us-ascii?Q?gagFDATqytZ2VnzeT8VOMCFla1btiTcXsSmAiH9QtpgmQ4OjBWtOq+mGP3EA?=
 =?us-ascii?Q?ZSDdv2798GPnHjRPTV8LJv5rkJK5EclGJ3TIjWwMZc7wRkSpipp0O+V/yOQv?=
 =?us-ascii?Q?TDn8oZCCi7YweOyKKxUIJ6EE2WFlkFDBpC5pglTOJwI8ETG+bLDYwDbj8C5M?=
 =?us-ascii?Q?e1IqIUyTY1yIIMl6TT+KzzcRpFTeb6V37Q7DHBEAcz33Vqnie+8o58g4MzMv?=
 =?us-ascii?Q?pHG5lkyMjc9jvKLSuAekjONA1m0mq0lNz0FeMBIpIyrP6UQmebsiSUJf9kxT?=
 =?us-ascii?Q?bUAq3nrteuEkDmounnb9yde0wMLJGE49rRQYJknBbNYrX7P6pwD2TWPNdfqc?=
 =?us-ascii?Q?cZmyfcuCTSdXP8hOOBB8ihZbochoWbW/EgAaeCzVLJnsKP3hGFBQ3GO7gfEJ?=
 =?us-ascii?Q?WFd9znC9sLdU2bqDRO3KLMF3DmrvBZNl9wWqTu5GSBxRqLnGr/FqYSYDCCz7?=
 =?us-ascii?Q?OQI4qkTa5kTLGdfu3wBTs0gkqB6GG8g5p43EWRe6azH5kwMm10fFRQZwJmCT?=
 =?us-ascii?Q?fo79B02hMkH+OPvQ/9Ks+KccGd1I6i79a/YeTXDic2RZ1fipMmZ55RytOy+M?=
 =?us-ascii?Q?6yb5WU76vhSYMLgndc78eDNu5Na2O+jUJPPC/YPIkSyBarW8xsVyQgcVhnpk?=
 =?us-ascii?Q?js8AQYgmRpeCMWUvhFrr2hVdBV7jW4UXoERrUpm7ryea2VDvkMTakjfz3mRL?=
 =?us-ascii?Q?S1nu0TVuN0Rq+RIpZZqOf7ua3CTWf0iAow1kbySrd3B53DvOO2sLlTX9JT5L?=
 =?us-ascii?Q?EPNCQlPfeRx0lkmXArl0D96BQvM8vZ2iziSsreLyCVix9Px/x5hI2D3iunka?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 105af392-0778-42e1-279a-08dc9226cec0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 19:17:35.6733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwTrWv9fG8HU4HRYW/WftBqSwDSk5T2n0n3A1tdhR7LcaECTG3/ZiCgAjYDr3FAW1KTwaVZhP5Y2HZiXZXOBbM/hXOxIniBwLl0wc6tlLqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7062
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The AER service driver does not currently call a handler for AER
> uncorrectable errors (UCE) detected in root ports or downstream
> ports. This is not needed in most cases because common PCIe port
> functionality is handled by portdrv service drivers.
> 
> CXL root ports include CXL specific RAS registers that need logging
> before starting do_recovery() in the UCE case.
> 
> Update the AER service driver to call the UCE handler for root ports
> and downstream ports. These PCIe port devices are bound to the portdrv
> driver that includes a CE and UCE handler to be called.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 705893b5f7b0..a4db474b2be5 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -203,6 +203,26 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  
> +	/*
> +	 * PCIe ports may include functionality beyond the standard
> +	 * extended port capabilities. This may present a need to log and
> +	 * handle errors not addressed in this driver. Examples are CXL
> +	 * root ports and CXL downstream switch ports using AER UIE to
> +	 * indicate CXL UCE RAS protocol errors.
> +	 */
> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    type == PCI_EXP_TYPE_DOWNSTREAM) {
> +		struct pci_driver *pdrv = dev->driver;
> +
> +		if (pdrv && pdrv->err_handler &&
> +		    pdrv->err_handler->error_detected) {
> +			const struct pci_error_handlers *err_handler;
> +
> +			err_handler = pdrv->err_handler;
> +			status = err_handler->error_detected(dev, state);
> +		}
> +	}
> +

Would not a more appropriate place for this be pci_walk_bridge() where
the ->subordinate == NULL and these type-check cases are unified?

