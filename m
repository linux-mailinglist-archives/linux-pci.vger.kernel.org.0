Return-Path: <linux-pci+bounces-37370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C78BB1AC3
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 22:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539F018959DF
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94FF2D739D;
	Wed,  1 Oct 2025 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlviN/93"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6612EA74D;
	Wed,  1 Oct 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350060; cv=fail; b=cRXKsih8gpfih+fhuxDQ9Iw6ipxlTx1SjZ+I/xqPXBjn6azvcxp0fo8SuzCovy2XYycKbSQC/0LncoLJig19X1sxINs6Paq9HvYrfOjHxIb6ux1ejjQbpkXNU9DZoehT9rHfSRPDWN7+GFh7H3ZB+ezxhGd7AfvAlZc2oSliUu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350060; c=relaxed/simple;
	bh=2BJul5dMNWF6g4qwaK+o8M7sr90Xv/a6ym5Zpth/3I0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=aCspWpG+FKZWOvhWoklR7nHVUgKXYL7CAjduND2u3xwAb/uo0chkGMBUJQxaQoJPVfy7R1GAM/gc5uvcD89eX14CTfiFM9ehMXLnfKjL7lUHCQMfp4mW+B8p6EENSiHUsCr3KyEEs1O6rDF1rZwAl/E88eGpnL/EJiFa9LC6UIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlviN/93; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759350058; x=1790886058;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=2BJul5dMNWF6g4qwaK+o8M7sr90Xv/a6ym5Zpth/3I0=;
  b=MlviN/93XLZiSNiP/FfOk+1TY0FfTTg1s3Ri6e0smFxiS4J//w6PggpJ
   MZ8imt/rrhKqVdn4DvNfjMCHwyPjOxBmrZWOYU2YC2k6t+y7rrKZeXsay
   oiAev8tMt+pbKBX6hxsTxCbP4JKKDbV4lCFzl/PDSIrvn5FnOZZu3oHEt
   dScm8d+lwZWkt7cqQNt6yyRzrfKwRt/h2uUmJm8K1p/cFRs56IY6KQEW0
   +C3CL7CrxPX3qOCLATdSjQkc8tpJ4UCfaMvsWz33FedWYnNxyFfZbaQQr
   X7rUMfZ9XLEdBy3Iwhgkb5GsATTYt8lFypX0Ph0xkLpJDtmlFS3IiFb3d
   w==;
X-CSE-ConnectionGUID: 5nHCSNlgSligy+M0lWI7bg==
X-CSE-MsgGUID: aE7yfaWkR8ukQRbKsIsXWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79285973"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="79285973"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 13:20:56 -0700
X-CSE-ConnectionGUID: MHHj3ODBQGijnNt+hMl4OA==
X-CSE-MsgGUID: Sprtp7soRpeHo7msCpOjNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; 
   d="scan'208";a="177992504"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 13:20:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 13:20:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 13:20:54 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 13:20:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PN1KrrKhK6aG5WnOb201DS9DoxNCUndi6gAeM0SCmjXjf928aQYvM8TosP/ck2jtIPMyj7x6muaDELVoO23G8i/eKIXTeo09f/+e5D5RHKS9Bfcrphl3K3OwmpmLzvxDjcGvDzdEM7ec1k5OGmSCx3MArBtMsC7iAgPsfjU79xIQVmyJStl3lb1RlIjpnUeVLEC9Ua48kIyK/vfd9xmPgcq4ShE8oxxH1EqKE9Vmy66HNGp3Yeo4ulgpe1EnV/PJL0qbEZDB+ekou299MVI6r/zbzW75tuFL6sd6H6y3ynOjiTedrJtcAayRhEh76pmgZyzXNccVQJMkSzWFcBSDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+qasQqkYKnpTDDyqXO6KUCvw+zX5tvHxPjwwxybbcE=;
 b=NmxLtwuiv9+z0v5NxtnYIoS6NJM6Crh0Kaa0gjp/brxVd1YtbvPX2HkNasVp7QZoSP+tw7C6eHItjc4cRjXoaOEAZkDzPfn7nJowWc6pa9noxDb2XHBRudwwlW851EAk9jdJ7KH+7Raew4b2GgxXjj3qKP0zsFb/o1eYVsvLo5JPQWOi4Ouz4s6FoCBx/4o87Wo1wx3cU4gcT8nFWV3udFzAsi9nb/zfy0SgBDXqOowchNGeEZdV1N8pB6b0MTn17AIhdV+jG50SUqjeNhp+Hh5Fmg3mKMWxDercGDiFNuSHlDKqyTl9XGb+rjcmGp3KCOZPa5SFU0k6kvlzmfU6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6152.namprd11.prod.outlook.com (2603:10b6:8:9b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Wed, 1 Oct 2025 20:20:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9160.008; Wed, 1 Oct 2025
 20:20:51 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 1 Oct 2025 13:20:48 -0700
To: Xu Yilun <yilun.xu@linux.intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>
CC: <yilun.xu@intel.com>, <yilun.xu@linux.intel.com>,
	<baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<aneesh.kumar@kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<linux-kernel@vger.kernel.org>, =?UTF-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>
Message-ID: <68dd8d20aafb4_1fa2100f0@dwillia2-mobl4.notmuch>
In-Reply-To: <20250928062756.2188329-3-yilun.xu@linux.intel.com>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
 <20250928062756.2188329-3-yilun.xu@linux.intel.com>
Subject: Re: [PATCH 2/3] PCI/IDE: Add Address Association Register setup for
 RP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:303:8f::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: f1576d02-9752-417c-510e-08de0128041c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGFrL04xcXR6QzJKSTdlWTVnZEN5ckFTT1FyMG5adU1yeVZNLytiSk9IQ1Rl?=
 =?utf-8?B?dmlJaGNnZGtZUUdiVlJWRjdlQXNDNTZ3TlpQNU1TNjg0N01taGJPaTdwQUZG?=
 =?utf-8?B?RCtlaFBlYjRMbXE4ZEhzRGY3ZEJHZE52UlRZbkhNdEtnMU56Y0F1SUwzZ0Vh?=
 =?utf-8?B?S2djZTVsM2xSZU9ackZTb2xCSnlYUjR0cENRc1Nubk4rVVFpeDlHQVRoM25y?=
 =?utf-8?B?VkRlOE9hYWdyR1p3VnlRaVZYWWU1b2piSlpKTDNVZlBWUGcvaXdCSzB0RHhC?=
 =?utf-8?B?KytuVmtMWFh5OUZPdFlUR1NITXRoaHN5cHAvTkk2SGpFWXVENURESm1jSGxy?=
 =?utf-8?B?K3htWlVUb2RpLzVmckM4ci9sL3YvdnNsaDVaWjIvbS92U2ZqUHMyT1hKSGV1?=
 =?utf-8?B?aTNBRzE3Qkw5ZkJ4eVlvaXkyNUYvS1BnTnUydnphSVdYZFp2YXd4MXVHZzVt?=
 =?utf-8?B?cnJxbjRVekVzQVVQbzFsaHZvaW9za0IvZzhDQTdOZGl1eHhaS3Z1alpBaXYy?=
 =?utf-8?B?aXROYnhmRk4wdXNoeS9EbnI4ZWIzcUE0dEpWQVFvdlRwMm9FWEpITDhhSDV2?=
 =?utf-8?B?eDdXTFVOUGRaR3NpM2R1T0x0Q1kzcFBHcVdURU5SNUROdSszS2R6ZzBRSmR2?=
 =?utf-8?B?cW5vVVRxVXZGeHhhUzhQMFJWUFJwWkl1V3UwNmtlKysxWjJRZWpkNEhBbUVZ?=
 =?utf-8?B?cUFpWTlONXJqY1oxdkNuazBGMndWY2VTcCtDRzM4QlZvdVo2M2dRNG1odlNC?=
 =?utf-8?B?a3Badmo0ZUdybmt0R3g2M2ZseWVDNTdIZjJ5UmdrYWFZSkdSc0Y5RnJqcDNZ?=
 =?utf-8?B?OHYxUU5ZemlLVmZacjVDWWl5UU9mSFRPZWlkUk1nOXppQ0gyelJLcGFFZHlN?=
 =?utf-8?B?QWpYUGRqV0hlbjhxSmtScVpsS1RWL3NxdHYxQkV3RWRuUXVLdmcya1NqMmVR?=
 =?utf-8?B?MDBteHVCcXFycnVxZjdMUkJnenFQLzNkVDFpK2h0YU1YZ2FFaDFXdWpDK2t0?=
 =?utf-8?B?MEFPS1U4VFdJSTlGd21JaTBlUktmSG85K1N6R2xsSDlSTjJWRitQekdEVzBH?=
 =?utf-8?B?Mm5oZWFqOTYyMVhGSDdoRjBDVnUrTDZ2Rjl1NnI4WlpPU1lucFJTWG5mb0Fy?=
 =?utf-8?B?VFowTkpRRzBNRmp4Ujh6UU0vYkh2UHIrUUJac0YyQlRrTEQ1amkycWtIVEp3?=
 =?utf-8?B?b2YrUlVkekE0WU9sNlNHK2c5Zk9yakdoUC9aK2t5WUgvaUZyNEpDTXp6dDFO?=
 =?utf-8?B?ME9lWCtFOUhVeXorS3ZvSlh3bERxQnhac1ZJUTNvNjN5aDRsb3hKQWs5dE5D?=
 =?utf-8?B?MVZYaFlQOGx6eVdFYkJ5QmJLUldaaFl1S2drbElYeU0wTnQwNTZuZjFwZTJn?=
 =?utf-8?B?dHNMOTBhODVUZUdmcHkyTVJRRGY2MWdzYnhyclRIVkhvYTJpUU5IRi9SSmN2?=
 =?utf-8?B?OFJiMmR0SzVIL3dqRkJOdW1OWk96ZENweWpyTE8ya3lGVGNLckFTQ3FBZllm?=
 =?utf-8?B?YTFIZTZpQW4xYUxtajc0V0ErRlU3eWthNElQSTBzNlJxOE5sWWFNdkJhSVhz?=
 =?utf-8?B?LzlaMTFEaTZUQjhUa2FiRndwaTZwNHFPTU94UkwvRmZHMDdubWlkSHVmMEtp?=
 =?utf-8?B?ZDZuY0RaZEVlemc4aWlJd3hDREhaUHFJb1NEaUZBazVvZUV4djAwWGs2RGVy?=
 =?utf-8?B?SUlzVG94OGlDMlA4S2UrTVJGSGdKc0huak5pZklTMDB4VWZ4MEpwdlVsMGxj?=
 =?utf-8?B?UHNGbmkwMm0vZkhzZDNzRU9RaHprMnlBRmVKQVptMjdOWkNGc3JOcDA2WkNy?=
 =?utf-8?B?RWNBelFZUGhqNHkwL0UrejRQYktyMHhkdFlTeFJEdm5IVEFGTG1GdUNwQzNo?=
 =?utf-8?B?Ymp5Wk5tdjFuV0xLazMra3hCbXZOUmFEMFJ5bmFlaE81VktoeW5CcnN1VkUw?=
 =?utf-8?Q?r9SAfrN0FVbYGg+EzNE6WwkTEKB2ohaY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0Q5RFRDSXd3UWJPakViS2NqWmQ1cDliSWF2MlVOVzlnbnFRMzBheUNBMHZh?=
 =?utf-8?B?TkZRdk5ia1BGbTZuK3hLTUVEbmVSV3JOdnBFS3N0YnRWckY3WW96ZXRlTm1G?=
 =?utf-8?B?a3ZOTDJmUEx1SWsvQit0K2FkMU85ems5eXExYW1mdzg1Z3ZDNFlPZlVSWnM1?=
 =?utf-8?B?eDU2Qm56R2RUTFhrTXpFL0JFV3JOa2czTk5BNUVWR04rNlUxbTdySXpZNDJ1?=
 =?utf-8?B?RlVJQjRxZVBPUloyUEU0S3BmcjFxVTVoK1JUNHBMTjMybEpleEtZRlUyTVV1?=
 =?utf-8?B?UUpQWUxNOTFYR281R296UWI4NjBKR0VNRmVUckJRK2lIaVlkWGg5YWNkbmN1?=
 =?utf-8?B?a0dwQksxZXVHT0xGbXl5ZlFsYzRQeEhlUHo2QXhBclZjMDlSNzN5ZTI0RVRl?=
 =?utf-8?B?cDRhOUZYZGt5cWtRWlZId1RpWGJKWkZKSXB2NTlmd2ttcEZmUzVkYkc2Y0lE?=
 =?utf-8?B?VDQ3cXJGZHp2U2JoOEJOZVpNMzRNU0NGZ0I5bVVNY2tWMUx5VmpWdDM5NWs0?=
 =?utf-8?B?UExFdHJxN2JKWlorWS85cUtQUXh2dHRVYWpIdnVyR29TVkpoVDU5d2xrbWJL?=
 =?utf-8?B?ci9yS0t2TytEOHE3c3Q4azNlK29TcHhWNy9iTXVkSzJXUFliVmNrZmk0TThV?=
 =?utf-8?B?MFIzMW9aeUtJQko3dyswZStrcXVwMTUyaXFuZXI1ZWo3eVFCR0tJekNwdUZV?=
 =?utf-8?B?NXA2VGFCclYzTm94cm9IZ2NRNWgrQnIraEVvU21oeWxmbGVXemU1WWZnRDly?=
 =?utf-8?B?KzZjaGIzVGRyVisrMXNNSWF4eTRXQWZkcWsyNE5oVURzQnpGeUVmaFpkZHJu?=
 =?utf-8?B?MzN6bk5uNVdYUzJoa3Znd2psTHVZbGgyZ0lBSXZ6cVRTNlFQSWpRMmxWaXpi?=
 =?utf-8?B?SGsycUNQcmdObmZkbW4yc2pyQTNOWENTZnB1Z0VMMlB5WFRZRVpqTXZ6a09T?=
 =?utf-8?B?VkloQlJjc3B2a1J1dDR6dHAvT2tKTWQrbmFwU2tXUGZYclpVM0ZTMHJKKzdi?=
 =?utf-8?B?aUNQTkUyTktnWlZlSEFTNlpvWlUrMTVpcHpxakZlZHlnTmRjZGo1bVp6N01k?=
 =?utf-8?B?QzViTExWR0VMTWZMSVpNR2NYRkdrNmxtZUtwZEpmM25xK2xQR1hOZ1htdDRF?=
 =?utf-8?B?cklSV3YzKzlhaGI3dUxZMFM4WXFCSzRtMDhOcTRHRkZyb01OK09aS04vcnZY?=
 =?utf-8?B?Zm1EQkkxMElJbXl1OG92RWpsTzgxNGNwK0JXRThwcUNlNkRrdyttSmg0RThV?=
 =?utf-8?B?SkRhQVRQd2d4czJ5cUZ5YlZFRCtsb2N2NFdkNk1lNDN5RS8ybzVxbVhybEt4?=
 =?utf-8?B?NW9sengxbGhNYjVzRlZlcHdkdzcrQzlRMlZab1FlRHMrbFMrSDF6ZEhQL0Y4?=
 =?utf-8?B?YzQvL3NXL01lVjFBL3F3ZkJzeGZGaUY4R010VWxzcFB6UUhid0dvemJpdzBr?=
 =?utf-8?B?UEJrdG5qZlhQQy9kWHROQnpVMmJMZEFXM3BiaDI3MGdYRnBET3ZBTzhEbDFp?=
 =?utf-8?B?WlNtMUZxeXZOalJJN1dJaUg4cVQ4UkZTNVJGdTZmM3VNQ2hoa2hSVHlwSjFL?=
 =?utf-8?B?N3ZoQVhpSGVCN3U0UnJpNWhiTkNnU2Rxa3Fya2JRdk1UZE5RcnVsVE53SzVR?=
 =?utf-8?B?d24ya1UyOWQ0WWM4NXBBNlRpejB2M3JUR3lveUZvWFk1b3RIbDhjL0ViYkVu?=
 =?utf-8?B?cWtydjhWdmZuUkdyaVhFN2tzckZIaGJHelQxYk1qamZULzIzVXlQM3RlcnV1?=
 =?utf-8?B?bkhWZmMvaUdhS2JuVGZHdWRXNXJWS3hjNXArS29rWW1GdnU5L1lLNEhxNVhG?=
 =?utf-8?B?RUxFK1R4aThqV3NFd1M0bTJOYXBxWm5adWNCWllCeFVQREQvK1FZeEQ4UW9i?=
 =?utf-8?B?QUpEaGtLNGxJalJIRVVvdzk3cDRiV29CNmliZ3NTMGtvOVpOS2lwaUxnMkkw?=
 =?utf-8?B?dkNtZUdyVXR0eWxtNDRIeGxMWmc1OEMrYTNBdTV3b3lsbU9YRGFmZ2xDWXph?=
 =?utf-8?B?WE0vVkNjemRZeWRjWWxDQVhxOUtxVEk4TW5ucVJPZVJJRjhSeWczT2l4VGRN?=
 =?utf-8?B?SDBNa3lPMGdQMXFJVnJCSy9Bb1l6VmdEcWZGUHlsdU53bzJ5Wmh1N3UzbXIy?=
 =?utf-8?B?THBMZUV4aE9wclhMTThuY29FSEFXTi9lVXlOUjYvRVNjTDRidkIwVzQwZmdP?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1576d02-9752-417c-510e-08de0128041c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 20:20:51.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQYN8aCZFTDMY2+IXS24C48rFmOjQrwoyqg2P8yWcusOSxeHGjoJahuAD6nGHNhvilm1GcDzYjBs5EjYAzb33lwQ+qS+zSEo0d08g0ynBeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6152
X-OriginatorOrg: intel.com

[ Add Ilpo for resource_assigned() usage proposal below ]

Xu Yilun wrote:
> Add Address Association Register setup for Root Ports.

Perhaps it would be more accurate to call this "Address Association for
downstream MMIO" to clearly distinguish it from memory cycles targetting
the root port.

> The address ranges for RP side Address Association Registers should
> cover memory addresses for all PFs/VFs/downstream devices of the DSM
> device. A simple solution is to get the aggregated 32-bit and 64-bit
> address ranges from directly connected downstream port (either an RP or
> a switch port) and set into 2 Address Association Register blocks.

For the bridge the split is not 32-bit vs 64-bit. The split is
non-prefetchable vs prefetchable where the latter is potentially 64-bit,
but not always.

> There is a case the platform doesn't require Address Association
> Registers setup and provides no register block for RP (AMD). Will skip
> the setup in pci_ide_stream_setup().

Instead of calling out architecture specific details this can say

"Just like RID association, address associations will be set by default
if hardware sets 'Number of Address Association Register Blocks' in the
'Selective IDE Stream Capability Register' to a non-zero value.
Alternatively, TSM drivers can opt-out of the settings by zero'ing out
the probed region."

> Also imaging another case where there is only one block for RP.
> Prioritize 64-bit address ranges setup for it. No strong reason for the
> preference until a real use case comes.

Rather than invent a new a policy just follow the PCI bridge
specification precedent where memory is mandatory and
prefetchable-memory is optional. If a bridge maps both, check if the
device needs both. If the device needs both and the platform only
provides 1 address association block then setup the non-optional BAR
first. If that results in an incomplete solution that is a quirk that
the vendor needs to solve, not the core PCI implementation.

Specifically, if that happens, the solution might be either a quirk to
disable address associations, or a quirk to disable one of the ranges.
Which path to take is unknown until there is a practical problem to
solve.

> The Address Association Register setup for Endpoint Side is still
> uncertain so isn't supported in this patch.
> 
> Take the oppotunity to export some mini helpers for Address Association
> Registers setup. TDX Connect needs the provided aggregated address
> ranges but will use specific firmware calls for actual setup instead of
> pci_ide_stream_setup().
> 
> Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Co-developed-by: Arto Merilainen <amerilainen@nvidia.com>
> Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  include/linux/pci-ide.h | 11 +++++++
>  drivers/pci/ide.c       | 64 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> index 5adbd8b81f65..ac84fb611963 100644
> --- a/include/linux/pci-ide.h
> +++ b/include/linux/pci-ide.h
> @@ -6,6 +6,15 @@
>  #ifndef __PCI_IDE_H__
>  #define __PCI_IDE_H__
>  
> +#define SEL_ADDR1_LOWER GENMASK(31, 20)
> +#define SEL_ADDR_UPPER GENMASK_ULL(63, 32)
> +#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                    \
> +	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW,          \
> +		    FIELD_GET(SEL_ADDR1_LOWER, (base))) | \
> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW,         \
> +		    FIELD_GET(SEL_ADDR1_LOWER, (limit))))
> +
>  #define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
>  	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
>  	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, (base)) | \
> @@ -42,6 +51,8 @@ struct pci_ide_partner {
>  	unsigned int default_stream:1;
>  	unsigned int setup:1;
>  	unsigned int enable:1;
> +	struct range mem32;
> +	struct range mem64;
>  };
>  
>  /**
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 7633b8e52399..8db1163737e5 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -159,7 +159,11 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  	struct stream_index __stream[PCI_IDE_HB + 1];
>  	struct pci_host_bridge *hb;
>  	struct pci_dev *rp;
> +	struct pci_dev *br;
>  	int num_vf, rid_end;
> +	struct range mem32 = {}, mem64 = {};

Per-above these should be mem_assoc, and pref_assoc;

> +	struct pci_bus_region region;
> +	struct resource *res;
>  
>  	if (!pci_is_pcie(pdev))
>  		return NULL;
> @@ -206,6 +210,24 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  	else
>  		rid_end = pci_dev_id(pdev);
>  
> +	br = pci_upstream_bridge(pdev);
> +	if (!br)
> +		return NULL;
> +
> +	res = &br->resource[PCI_BRIDGE_MEM_WINDOW];
> +	if (res->flags & IORESOURCE_MEM) {

Per Ilpo this can now just be a size check.

> +		pcibios_resource_to_bus(br->bus, &region, res);
> +		mem32.start = region.start;
> +		mem32.end = region.end;
> +	}
> +
> +	res = &br->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> +	if (res->flags & IORESOURCE_PREFETCH) {
> +		pcibios_resource_to_bus(br->bus, &region, res);
> +		mem64.start = region.start;
> +		mem64.end = region.end;
> +	}
> +
>  	*ide = (struct pci_ide) {
>  		.pdev = pdev,
>  		.partner = {
> @@ -218,6 +240,8 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  				.rid_start = pci_dev_id(pdev),
>  				.rid_end = rid_end,
>  				.stream_index = no_free_ptr(rp_stream)->stream_index,
> +				.mem32 = mem32,
> +				.mem64 = mem64,
>  			},
>  		},
>  		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
> @@ -397,6 +421,21 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
>  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
>  }
>  
> +static void set_ide_sel_addr(struct pci_dev *pdev, int pos, int assoc_idx,
> +			     struct range *mem)
> +{
> +	u32 val;
> +
> +	val = PREP_PCI_IDE_SEL_ADDR1(mem->start, mem->end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(assoc_idx), val);
> +
> +	val = FIELD_GET(SEL_ADDR_UPPER, mem->end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(assoc_idx), val);
> +
> +	val = FIELD_GET(SEL_ADDR_UPPER, mem->start);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(assoc_idx), val);
> +}
> +
>  /**
>   * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
>   * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> @@ -410,6 +449,7 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
>  void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
>  {
>  	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	u8 assoc_idx = 0;
>  	int pos;
>  	u32 val;
>  
> @@ -424,6 +464,21 @@ void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
>  	val = PREP_PCI_IDE_SEL_RID_2(settings->rid_start, pci_ide_domain(pdev));
>  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
>  
> +	/*
> +	 * Feel free to change the default stratagy, Intel & AMD don't directly
> +	 * setup RP registers.
> +	 *
> +	 * 64 bit memory first, assuming it's more popular.
> +	 */
> +	if (assoc_idx < pdev->nr_ide_mem && settings->mem64.end != 0) {
> +		set_ide_sel_addr(pdev, pos, assoc_idx, &settings->mem64);
> +		assoc_idx++;
> +	}
> +
> +	/* 64 bit memory in lower block and 32 bit in higher block, any risk? */
> +	if (assoc_idx < pdev->nr_ide_mem && settings->mem32.end != 0)
> +		set_ide_sel_addr(pdev, pos, assoc_idx, &settings->mem32);
> +

Per-above, just drop the 64-bit policy and assumption. It will naturally
fail if the required number of address associations is insufficient.
I.e. either we are in the AMD situation and no amount of address
association is required, or we are in the ARM / Intel situation where it
assigns memory then prefetch-memory (if both are present). If both of
those are required and the hardware only supports 1 address association
then that hardware vendor is responsible for figuring out a quirk.

Otherwise Linux expects that any hardware that requires address
association always produces at least 2 address association blocks at the
root port, or otherwise arranges for only one memory window type to be
active.

>  	/*
>  	 * Setup control register early for devices that expect
>  	 * stream_id is set during key programming.
> @@ -445,7 +500,7 @@ EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
>  void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
>  {
>  	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> -	int pos;
> +	int pos, i;
>  
>  	if (!settings)
>  		return;
> @@ -453,6 +508,13 @@ void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
>  	pos = sel_ide_offset(pdev, settings);
>  
>  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +
> +	for (i = 0; i < pdev->nr_ide_mem; i++) {
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
> +	}

Hmm, if we are going to clear all on stop then probably should also
clear all unused on setup just to be consistent.

> +
>  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
>  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
>  	settings->setup = 0;
> -- 
> 2.25.1
> 

Here are the proposed incremental changes addressing the above. The new
pci_ide_stream_to_regs() helper can later be exported to TSM drivers
that need a formatted copy of the register settings. I prefer that to
exporting the internals (the PREP_() macros for register setup and the
pci_ide_domain()).

-- >8 --
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index b46e42bcafe3..e7c14ce1b1d0 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -336,6 +336,12 @@ static inline bool resource_union(const struct resource *r1, const struct resour
 	return true;
 }
 
+/* Check if this resource is added to a resource tree or detached. */
+static inline bool resource_assigned(struct resource *res)
+{
+	return res->parent != NULL;
+}
+
 int find_resource_space(struct resource *root, struct resource *new,
 			resource_size_t size, struct resource_constraint *constraint);
 
diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
index ad4fcde75a56..4e33fa6944a1 100644
--- a/include/linux/pci-ide.h
+++ b/include/linux/pci-ide.h
@@ -28,6 +28,9 @@ enum pci_ide_partner_select {
  * @rid_start: Partner Port Requester ID range start
  * @rid_end: Partner Port Requester ID range end
  * @stream_index: Selective IDE Stream Register Block selection
+ * @mem_assoc: PCI bus memory address association for targetting peer partner
+ * @pref_assoc: (optional) PCI bus prefetchable memory address association for
+ *		targetting peer partner
  * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
  *		    address and RID association registers
  * @setup: flag to track whether to run pci_ide_stream_teardown() for this
@@ -38,11 +41,33 @@ struct pci_ide_partner {
 	u16 rid_start;
 	u16 rid_end;
 	u8 stream_index;
+	struct pci_bus_region mem_assoc;
+	struct pci_bus_region pref_assoc;
 	unsigned int default_stream:1;
 	unsigned int setup:1;
 	unsigned int enable:1;
-	struct range mem32;
-	struct range mem64;
+};
+
+/**
+ * struct pci_ide_regs - Hardware register association settings for Selective
+ *			 IDE Streams
+ * @rid_1: IDE RID Association Register 1
+ * @rid_2: IDE RID Association Register 2
+ * @addr: Up to two address association blocks (IDE Address Association Register
+ *	  1 through 3) for MMIO and prefetchable MMIO
+ * @nr_addr: Number of address association blocks initialized
+ *
+ * See pci_ide_stream_to_regs()
+ */
+struct pci_ide_regs {
+	u32 rid_1;
+	u32 rid_2;
+	struct {
+		u32 assoc1;
+		u32 assoc2;
+		u32 assoc3;
+	} addr[2];
+	int nr_addr;
 };
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3a71f30211a5..ca97590de116 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -877,6 +877,11 @@ struct pci_bus_region {
 	pci_bus_addr_t	end;
 };
 
+static inline pci_bus_addr_t pci_bus_region_size(const struct pci_bus_region *region)
+{
+	return region->end - region->start + 1;
+}
+
 struct pci_dynids {
 	spinlock_t		lock;	/* Protects list, index */
 	struct list_head	list;	/* For IDs added at runtime */
diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index 7b2aa0b30376..8e30b75f1f4d 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -157,13 +157,13 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
 {
 	/* EP, RP, + HB Stream allocation */
 	struct stream_index __stream[PCI_IDE_HB + 1];
+	struct pci_bus_region pref_assoc = { 0, -1 };
+	struct pci_bus_region mem_assoc = { 0, -1 };
+	struct resource *res, *mem, *pref;
 	struct pci_host_bridge *hb;
+	int num_vf, rid_end;
 	struct pci_dev *rp;
 	struct pci_dev *br;
-	int num_vf, rid_end;
-	struct range mem32 = {}, mem64 = {};
-	struct pci_bus_region region;
-	struct resource *res;
 
 	if (!pci_is_pcie(pdev))
 		return NULL;
@@ -214,18 +214,20 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
 	if (!br)
 		return NULL;
 
-	res = &br->resource[PCI_BRIDGE_MEM_WINDOW];
-	if (res->flags & IORESOURCE_MEM) {
-		pcibios_resource_to_bus(br->bus, &region, res);
-		mem32.start = region.start;
-		mem32.end = region.end;
-	}
-
-	res = &br->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
-	if (res->flags & IORESOURCE_PREFETCH) {
-		pcibios_resource_to_bus(br->bus, &region, res);
-		mem64.start = region.start;
-		mem64.end = region.end;
+	/*
+	 * Check if the device consumes memory and/or prefetch-memory. Setup
+	 * downstream address association ranges for each.
+	 */
+	mem = pci_resource_n(br, PCI_BRIDGE_MEM_WINDOW);
+	pref = pci_resource_n(br, PCI_BRIDGE_PREF_MEM_WINDOW);
+	pci_dev_for_each_resource(pdev, res) {
+		if (resource_assigned(mem) && resource_contains(mem, res) &&
+		    !pci_bus_region_size(&mem_assoc))
+			pcibios_resource_to_bus(br->bus, &mem_assoc, mem);
+
+		if (resource_assigned(pref) && resource_contains(pref, res) &&
+		    !pci_bus_region_size(&pref_assoc))
+			pcibios_resource_to_bus(br->bus, &pref_assoc, pref);
 	}
 
 	*ide = (struct pci_ide) {
@@ -235,13 +237,16 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
 				.rid_start = pci_dev_id(rp),
 				.rid_end = pci_dev_id(rp),
 				.stream_index = no_free_ptr(ep_stream)->stream_index,
+				/* Disable upstream address association */
+				.mem_assoc = { 0, -1 },
+				.pref_assoc = { 0, -1 },
 			},
 			[PCI_IDE_RP] = {
 				.rid_start = pci_dev_id(pdev),
 				.rid_end = rid_end,
 				.stream_index = no_free_ptr(rp_stream)->stream_index,
-				.mem32 = mem32,
-				.mem64 = mem64,
+				.mem_assoc = mem_assoc,
+				.pref_assoc = pref_assoc,
 			},
 		},
 		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
@@ -420,19 +425,61 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
 	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
 }
 
-static void set_ide_sel_addr(struct pci_dev *pdev, int pos, int assoc_idx,
-			     struct range *mem)
+#define SEL_ADDR1_LOWER GENMASK(31, 20)
+#define SEL_ADDR_UPPER GENMASK_ULL(63, 32)
+#define PREP_PCI_IDE_SEL_ADDR1(base, limit)               \
+	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |        \
+	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW,          \
+		    FIELD_GET(SEL_ADDR1_LOWER, (base))) | \
+	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW,         \
+		    FIELD_GET(SEL_ADDR1_LOWER, (limit))))
+
+static void mem_assoc_to_regs(struct pci_bus_region *region,
+			      struct pci_ide_regs *regs, int idx)
 {
-	u32 val;
+	regs->addr[idx].assoc1 =
+		PREP_PCI_IDE_SEL_ADDR1(region->start, region->end);
+	regs->addr[idx].assoc2 = FIELD_GET(SEL_ADDR_UPPER, region->end);
+	regs->addr[idx].assoc3 = FIELD_GET(SEL_ADDR_UPPER, region->start);
+}
+
+/**
+ * pci_ide_stream_to_regs() - convert IDE settings to association register values
+ * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
+ * @ide: registered IDE settings descriptor
+ * @regs: output register values
+ */
+static void pci_ide_stream_to_regs(struct pci_dev *pdev, struct pci_ide *ide,
+				   struct pci_ide_regs *regs)
+{
+	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
+	int pos, assoc_idx = 0;
+
+	memset(regs, 0, sizeof(*regs));
+
+	if (!settings)
+		return;
 
-	val = PREP_PCI_IDE_SEL_ADDR1(mem->start, mem->end);
-	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(assoc_idx), val);
+	pos = sel_ide_offset(pdev, settings);
+
+	regs->rid_1 = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
+
+	regs->rid_2 = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
+		      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
+		      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
+
+	if (pdev->nr_ide_mem && pci_bus_region_size(&settings->mem_assoc)) {
+		mem_assoc_to_regs(&settings->mem_assoc, regs, assoc_idx);
+		assoc_idx++;
+	}
 
-	val = FIELD_GET(SEL_ADDR_UPPER, mem->end);
-	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(assoc_idx), val);
+	if (pdev->nr_ide_mem > assoc_idx &&
+	    pci_bus_region_size(&settings->pref_assoc)) {
+		mem_assoc_to_regs(&settings->pref_assoc, regs, assoc_idx);
+		assoc_idx++;
+	}
 
-	val = FIELD_GET(SEL_ADDR_UPPER, mem->start);
-	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(assoc_idx), val);
+	regs->nr_addr = assoc_idx;
 }
 
 /**
@@ -448,38 +495,34 @@ static void set_ide_sel_addr(struct pci_dev *pdev, int pos, int assoc_idx,
 void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
 {
 	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
-	u8 assoc_idx = 0;
+	struct pci_ide_regs regs;
 	int pos;
-	u32 val;
 
 	if (!settings)
 		return;
 
-	pos = sel_ide_offset(pdev, settings);
+	pci_ide_stream_to_regs(pdev, ide, &regs);
 
-	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
-	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
-
-	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
-	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
-	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
+	pos = sel_ide_offset(pdev, settings);
 
-	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, regs.rid_1);
+	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, regs.rid_2);
 
-	/*
-	 * Feel free to change the default stratagy, Intel & AMD don't directly
-	 * setup RP registers.
-	 *
-	 * 64 bit memory first, assuming it's more popular.
-	 */
-	if (assoc_idx < pdev->nr_ide_mem && settings->mem64.end != 0) {
-		set_ide_sel_addr(pdev, pos, assoc_idx, &settings->mem64);
-		assoc_idx++;
+	for (int i = 0; i < regs.nr_addr; i++) {
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i),
+				       regs.addr[i].assoc1);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i),
+				       regs.addr[i].assoc2);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i),
+				       regs.addr[i].assoc3);
 	}
 
-	/* 64 bit memory in lower block and 32 bit in higher block, any risk? */
-	if (assoc_idx < pdev->nr_ide_mem && settings->mem32.end != 0)
-		set_ide_sel_addr(pdev, pos, assoc_idx, &settings->mem32);
+	/* clear extra unused address association blocks */
+	for (int i = regs.nr_addr; i < pdev->nr_ide_mem; i++) {
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
+		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
+	}
 
 	/*
 	 * Setup control register early for devices that expect

