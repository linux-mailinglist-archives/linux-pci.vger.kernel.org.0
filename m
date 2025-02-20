Return-Path: <linux-pci+bounces-21923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84597A3E35F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 19:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595B317831C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CE12139C9;
	Thu, 20 Feb 2025 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IiGTpmop"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C15214200
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074848; cv=fail; b=kRT8iqYrayHvodcYgcIch6Po13bP0xyNluoPevzdqC/xm998BoAO0lFnpmhEbyKPVzrp/6l6FHhTtybZF1xJKmuxpPQGYvwvF58Wzt6YTColz7B122L+j1HMDKbZUfo5MFUBnJGYy2NvZe6h3mBE4ACdRzugMIoFh0ZhNR9/FCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074848; c=relaxed/simple;
	bh=Z10Dhoj2TWWEyogQRs7iuXhpFLbpEq8KZkCwNGgCk3s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X2fWQIT5ZKiwaD+bABUL89/vbJ3fwBqsmLXVUXpObDhKEe6pSINs+5XAyBSvPANJQSiU9jvpBf5BQyuJMIBjgaXOJNu6sG48WNMvTl2LYTxNCQfX8hLJYTzamcooLEiIFcW1oJObkFVhOoxREvwDbT0SGjfhle1lWSGQkZ8E8jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IiGTpmop; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740074846; x=1771610846;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Z10Dhoj2TWWEyogQRs7iuXhpFLbpEq8KZkCwNGgCk3s=;
  b=IiGTpmopwnVcqM7h7ApPkC8n/1/7qgr0UsY71MbIJtUWcsmFfWMjVldT
   iRoVncH0TLtSMGhwkSpTp1HoP/CAJ+0w5yt2phZkPzC/Bo1ibo4Iz2mQD
   zTOzSly0JQpqawzgJ9qhuu1cwW2v/Sv1jkAKD7pbVgtoQFEDiaCMQ32lE
   ZFhiYQgN+dUVd3a5Or36Xw57J8l5iMy4gPsw1nX2T/XumdqVLBgSHggx5
   ZDoL5yoq8L6gMn0LdFp+F3rYGrDwW4OIJvJFrPsZqjeTDX8VVlSr8iOdf
   Y1CeAbiH3Cyjhcn8qX632h4NfiDRYtfGDAJDkurrb/GSWTJtcioCpuXb5
   w==;
X-CSE-ConnectionGUID: 4jc/pqUfQpKKtc/1qhbSaA==
X-CSE-MsgGUID: 7xjrZ7Q5Tfykz33uMKfDuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="41131642"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="41131642"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:07:25 -0800
X-CSE-ConnectionGUID: wgCF2O1aSYqLrKpP5cK2kQ==
X-CSE-MsgGUID: Tcz4I3TVSw2oOR5qUnd4tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114974347"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:07:25 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 10:07:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 10:07:24 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 10:07:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvShwY34OyLKy4SSpTLzZaDYA53g0aiTtfrB0XPUXabqlZ2yEMV1/KJgLJRMBD7UhzH3Rwz7wPtTI3BWLrqlVHyfQ5Ite4KbFx+MXJSP8aohMQ1Fvjb/1NITlq4U8t1AkEk4QSPTtbLzKD/sqmEti7WWXdzMxt0IuoKCelWjkikqe7oWjcWOl1usxUV108USKTB3LpbiPZeHGdqgZvUsTKKixDKWeaDRRsPrA8AvjeMsoZuoi+u4k7n+4mOiiqJzubeFzoe+WOl7pA0701/grcQwgTiSLhNYcNiqUmTBsj7M7Or/9jkDykNe8jVdOKT6qA28YV+Yta9VQEgcq5uCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbDeRM251+QgNNbTVERlkU/ECQBjXKoZ9c/d336uXJE=;
 b=jDyL+Nz0vsy+Moo/D5kbMsslYvnsboPux2X9N9BqlprlWetSoNbQPbdzcmBhVV36XYoNY/i6Bht4WxFMrH1rici8InUAltS+TpKvzyjYxFdmhRCwXZrlIJDu7lpF0spW43Si2moy/ORsUYxy1nC7yJYsTRLgkTf6KtBHkDqOkzSEd0z7F+1M0NJKKut1BtuGt8wyjp2lS6mIty0J5Ug3ctW6ib/I7nHHmWoYsLEzqo+Sfy3iQSuUse0E7ncrVRRv7zSszGvsm1tnaRRArTx695km9AjG3SvlBQ5Kt3ujmjZJ2M3R09LLBUBGISpJjK6nwd8+bEbGedGMY2X9fW6Wyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH2PR11MB8868.namprd11.prod.outlook.com (2603:10b6:610:284::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 18:07:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 18:07:20 +0000
Date: Thu, 20 Feb 2025 10:07:18 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: <linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Message-ID: <67b76f5663f7f_2d2c294e2@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
 <2e7f85ea-40ce-4b38-acd9-56c02718771c@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e7f85ea-40ce-4b38-acd9-56c02718771c@amd.com>
X-ClientProxiedBy: MW4PR04CA0140.namprd04.prod.outlook.com
 (2603:10b6:303:84::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH2PR11MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: cfadb2dc-1dfb-4ae3-a5de-08dd51d96b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bllFNXE1N25YeHJualczWmtLYjN6dnVzazdKQyt3KzE4ZWRaZzI4bWg3M1JU?=
 =?utf-8?B?NitmeVJOa3ZUOVdjclMzZnBzZXJ6c1RxVG8xT1o5QmlQVlVVWkZWajlFaEsr?=
 =?utf-8?B?Q0VmVjVhMVNOQVk5VVM0TXg3a0tLN1MrcTBiZ1BmWDNYSTVISUJaN2IrM09S?=
 =?utf-8?B?NXRYa2pIVkc0YlIxY2theDlSelFjVExKeU1ZSkh1Qlg2K3JFRmU3SmpBcHdG?=
 =?utf-8?B?UWdyaThLKzJPVGlZb09jZmRIVlJCcUo2MTQ1Q0pMdWo5UURjRThFUklkZzF6?=
 =?utf-8?B?RUUwdnQxL2R0bGNTTWF3M0lBTUFsSGtsWGtVeEJzK0ZSODBVZ2NxOERYM1FP?=
 =?utf-8?B?d2ZtL0I2NVRzOFFidGk5QlUzZThteFp5SVdYNk1jQ2ZLdDhaQ1hMWFpuSkdK?=
 =?utf-8?B?eERJcTFKSW96SVF2YkJ2a1libFo4ZkdCSUNraG10RE13Y2o5ZjRMdGNjUmJD?=
 =?utf-8?B?UmJHQWk1cXlUN0FMK2NtVXgvbFdRZ213YVhvNW4rTklUWEttRHNoRjE3QnFJ?=
 =?utf-8?B?SFZiMTAzUVdwMml6bnRwcnp5aWpvYjFYTytlZU1qNkc2STQwTWJJalMyQkk2?=
 =?utf-8?B?dzV5NjNJeWcyVmRHK3JJMXVJQzdIRVRiYzNmY1VBYWhkc3pEK2x3Znk3VDJT?=
 =?utf-8?B?SkR3UGtiTGpQc1Npc1lLYnNrTmQ4c2Z0NmxXL2s3Ny9VS2pOSDlRMGxyUUVk?=
 =?utf-8?B?d3JlaVFhNEdNSFNPYXQ2UG1uY0JRdlk5aWc1dXFPMXVVbHJIOTM2anl2V1lW?=
 =?utf-8?B?MlRDeXdQdzNhQlU0c2J4c1AxR1VudkZ3TUxqbFFtbGFoSUpicUN4dU53R2h3?=
 =?utf-8?B?dGdJd3BKK3NNOU5GSUNHbXJXTVNBdHpidDh4dlRzZlorWVQzOVdGS1RBSlFE?=
 =?utf-8?B?Q1BQVTUwT2Z5UmV1am9hSXZNc1Q5ZGlvRFRod1dYUkR1YjNFenJBU1I2TDdX?=
 =?utf-8?B?WDFRbHNoRS9tTnFwbWJSMjJCRzEycS9henJ1YXhiQ3VUMmthR2N3OWkwYm8y?=
 =?utf-8?B?UGg2NkZkaml4cHBiNnlNR0Nsc29lYTNKS3IwUURZRzVqUkgvMlR2SklGb25a?=
 =?utf-8?B?dFBBRUZwZkY1N09SaXlueU5WWlMrZ0RuV1o1eVo5T2NLRmdSWmpYWlgzM21K?=
 =?utf-8?B?RlErcGF6NUJMMEF2RmF5Y0YxVWtlTmpPSndtdlJrWFFBKzYyUDFLRTdrMmFl?=
 =?utf-8?B?NVp3WG1iVEt2WEUwQ0U3UjlDVEMvZDhTSmRUa0pjNnVtamFoclU0em1keWNv?=
 =?utf-8?B?b1hKcE5pZ29ENTdxT2RFbENON0hRaFN1eFZXdVl1M2JvM3BRejc5WG8wNlVz?=
 =?utf-8?B?amhUUCtrM2w1ejVXcHdPNG41N3dhNjdxck56MTNHb2t0YWEzNC92S0pxMEdO?=
 =?utf-8?B?K3VlUEEyQjkxU1oyMFFaSUFqSHU1eWM1VUJzTVk3WHZkTnlaaU9hcWFFNGRB?=
 =?utf-8?B?RmpuRHA0aHlZZ3Y4eFFGcVBXbWxqajlCWGhqMU9sTmxXL0sxeENiYm8zNXJT?=
 =?utf-8?B?eEIvYy9CWk5YNi9haWpGM1ljTzJ6eWw2UWkwV2xxbnROMjZqQitvVy9iNTZX?=
 =?utf-8?B?YUgwVzdlZVN4LzljZmhMb0loV1BOVFY0MXdaQXVCUEI1OWs4cDRhSCtBNDRQ?=
 =?utf-8?B?eG9Ya1BPdlBmbkJIdGZVdjRiL3pyL0x6RG5vZ0tJYmtmWEtLdFE1R1VZbTdm?=
 =?utf-8?B?VEtUa0JWVjc3RUQvejhVdVJjc3lFckZ5WVBJY3k3R3IvRlhGM0lVT21Gc2VO?=
 =?utf-8?B?RXVTUEpmRDhjMEVpcGJ5WTVURlh0VG1RcWxzWGZ0OGxUdnlPUkFJZkxMcXc3?=
 =?utf-8?B?U0dLZ1ZBRWU5MlFOOGJpa1ZFYis3dStySStROUpZbU50UXdtNXVWUk1vV2c3?=
 =?utf-8?Q?c66l7bq7HK6Bv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U045bkRUdmlCcnZ4Z3BsWGtidno3QURaRDl0cDQ3RmVYVHhNNlQzSVRydXBU?=
 =?utf-8?B?ZVVYb3FBb1VqM25aSFB2V3FkcHNjcFpnSnVPcUtFTjdBTmp5R1pIdktsc3lk?=
 =?utf-8?B?eUJaNUMxWC9GbFlscU9pK2RoaURPRC9ZYWJHWVU4QkZ4NDZiVVpaMko4czMw?=
 =?utf-8?B?ZGl6UUdLblAyaTFYZmdtMUpmZ3daNTRrcEd2b3NidERHblhHdnpsUW9PNWFL?=
 =?utf-8?B?MzZoRlR0Q2VmRFViK2hXaFdlZ2pxZHZwZHpOaFp3bzRUcG5iZXhaTTlyOEM3?=
 =?utf-8?B?MjE0aHZweU96STY3ZlZLR3E5NitEaVB0dXFzU0NiR2tFaHEzcUROdTJYU3ZE?=
 =?utf-8?B?S25BNm5uaXFWRjdjeXBEVGtsZlRVYm1LM29kV1hRQzU1cHRVWlhTR3k1RDB3?=
 =?utf-8?B?SU13VVRJYWVjOEJVc0RIdklnZFZqNU9ORXhBc0N3bUtZODVUMDlVTFFsakpW?=
 =?utf-8?B?K0sxL0E3VzY5cEtCVnZidW50ZDc2ejBiUTdxaU9WL1VQdVlXVjU1TjdGdlZ4?=
 =?utf-8?B?OUZkSW4xQnBSY3dLWjAvc1h4aHh6d0JUd24wRmdaRkowVnZQV3AvOW0wUXRh?=
 =?utf-8?B?MHdVTGtId1dENUdla1JQamdnNXhCZDVZS2M5ckZ0T2Vvc3puRWtWbWNLQXJN?=
 =?utf-8?B?d1dmVnBhaGduSG1uejRWQ1NjeXNXS2txR2N3VXNsRWErSG4zdWI4WTlHLzhl?=
 =?utf-8?B?WmpkV3pqdXFncjRoVUwxZ3l5VCsvQ1pqdng2MTZwVWRxUUI3YWMrYnc5SzMz?=
 =?utf-8?B?UnljMHlmTE8rUTQrOXRaMFV5Tkl5VHBFZnE5RzZUUXlHajVxcDhoNld4MDIv?=
 =?utf-8?B?S1VuTkpjYW9EdDRRSFNxUCt0TGZaNDVJektOaTBsZnNmNkFQelhnYWJURit4?=
 =?utf-8?B?TmVsR1RRZy85d3F1UTNoRnlCN2pKcEdRelBhUHBHMk9pa3ZxY0c3KzZ2b1FE?=
 =?utf-8?B?VysxMVlpNWV2d1VqVkRuL1lFUEIvZUdubjZ0SDEzQ05Wdnp2RkpzaCs4ZUg5?=
 =?utf-8?B?U3lIRlc0NEEzSEQ4VEN2WGpTdE1iTVZYZUp5STVWWmMvRDB2bVpKRmN4M1lW?=
 =?utf-8?B?RkU2Z1lMS1kxdXIxY2RsN1VYclJXT3VabldQNnJ0aDlDZEI3Wmx3QzdJcFJa?=
 =?utf-8?B?Um5KUGR4MDBNcmhVQTVlNDlkcGdpYkthaVQ3YmpFSDRmdCs0b2RUUU1KT2Vo?=
 =?utf-8?B?WjdkZXA5L0tSVzNXalRsdFZXem1VcDdMeHZabWh0M3pQM0M5Rlpya3cyMkox?=
 =?utf-8?B?cVVUNklaY3FKa0NLT1o0WncyeVRwTEV0YkExcGRYZ3cwcTBoUVVvVS95eTZs?=
 =?utf-8?B?amRIV3hNSDY0UzB0Z1VubWpvQXh3MUJrVUYreHZXc0Y2TWxyemNPd1I4Wnha?=
 =?utf-8?B?T3ZOWWFzbU1UTXlsdGt1eEcwbVpGcTZ6Y3IyZmUwWXFGSUgrL2dHZ0d4L3Y3?=
 =?utf-8?B?OWNrb0tHVTl5K052ME1Ya3lLcDR1MmROaDkzSUxmc2R3TXR0NkE5OHNIZG50?=
 =?utf-8?B?eXVVT3RkMzRKRG5xR1ZwVFF0WVpFMVRxa3JOVXVHRGlpeWMxMzdTQUhRQkRo?=
 =?utf-8?B?Uy9nUXJQVXo5WkVtcEV6UkNvUUdEWXU2QmJnWXdkaWVLdXNwUGREMkJoY1FJ?=
 =?utf-8?B?TFkrWHVCK0hOU2dTeHhPMVkvY29vNlRQaStsVTZrWGNWa0MrYkl4U2ZvdXB6?=
 =?utf-8?B?UExQdVdrOFVFZjI1RkpIUGxLQlVVVHdkRVFiTUw2cURPdDUzTkpKRGt2c0Jt?=
 =?utf-8?B?MCsvK3BMbzBtVG5jTjJaQmw0ZjFvQ1JNZ3BPWE9kb0Y5eHVyTGl2V3gwejFn?=
 =?utf-8?B?Sjh3elA5b1QxZHFabFNxeWs3bWlzenBTQmlPaDdPWVFIcFN3R3FmSTlxMWZU?=
 =?utf-8?B?WHNzOG5JK1ZWRFVaWWNURFJRRkp3Tk5iSWxTK1hDS3JFWXlxdXFuSEsxVEZQ?=
 =?utf-8?B?YWZiSEdxdVJEaGJXVDVNUlhjU1RCakxZbW5DdkhRanp1Q0poS29nYzNhd2dZ?=
 =?utf-8?B?UURNMDF4OERUNFdIZ1Q0M3dpc2xKTDZQZzNDZWRMUk5TWFRXQXprNU1ENHpM?=
 =?utf-8?B?U3E3dWVwY0lqSGRtejFhVUxvbnIzUXo5Nk8xckMrMUxKNVdOYm52a2RmdUtk?=
 =?utf-8?B?cEJoUzVwQnFPL0ljaTZucFlFWlEyajcvME93SGVhRXhYSmtFdWZueHdnSTQz?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfadb2dc-1dfb-4ae3-a5de-08dd51d96b22
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:07:20.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 749kz0MDrwcIaB7DVG2hi+hT6NAND9g8GETXGQuQQibYjSIsDjN+ef0CWMPG2MYqiPHhxjsJf/ALY0vrwOs2X6S99F5sRuUS1VyHkPHW1BM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8868
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> On 6/12/24 09:23, Dan Williams wrote:
> > Link encryption is a new PCIe capability defined by "PCIe 6.2 section
> > 6.33 Integrity & Data Encryption (IDE)". While it is a standalone port
> > and endpoint capability, it is also a building block for device security
> > defined by "PCIe 6.2 section 11 TEE Device Interface Security Protocol
> > (TDISP)". That protocol coordinates device security setup between the
> > platform TSM (TEE Security Manager) and device DSM (Device Security
> > Manager). While the platform TSM can allocate resources like stream-ids
> > and manage keys, it still requires system software to manage the IDE
> > capability register block.
> > 
> > Add register definitions and basic enumeration for a "selective-stream"
> > IDE capability, a follow on change will select the new CONFIG_PCI_IDE
> > symbol. Note that while the IDE specifications defines both a
> > point-to-point "Link" stream and a root-port-to-endpoint "Selective"
> > stream, only "Selective" is considered for now for platform TSM
> > coordination.
> > 
> > Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   drivers/pci/Kconfig           |    3 +
> >   drivers/pci/Makefile          |    1
> >   drivers/pci/ide.c             |   73 ++++++++++++++++++++++++++++++++++++
> >   drivers/pci/pci.h             |    6 +++
> >   drivers/pci/probe.c           |    1
> >   include/linux/pci.h           |    5 ++
> >   include/uapi/linux/pci_regs.h |   84 +++++++++++++++++++++++++++++++++++++++++
> >   7 files changed, 172 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/pci/ide.c
> > 
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 2fbd379923fd..4e5236c456f5 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -121,6 +121,9 @@ config XEN_PCIDEV_FRONTEND
> >   config PCI_ATS
> >   	bool
> >   
> > +config PCI_IDE
> > +	bool
> > +
> >   config PCI_DOE
> >   	bool
> >   
> > diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> > index 67647f1880fb..6612256fd37d 100644
> > --- a/drivers/pci/Makefile
> > +++ b/drivers/pci/Makefile
> > @@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
> >   obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
> >   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
> >   obj-$(CONFIG_PCI_DOE)		+= doe.o
> > +obj-$(CONFIG_PCI_IDE)		+= ide.o
> >   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
> >   obj-$(CONFIG_PCI_NPEM)		+= npem.o
> >   obj-$(CONFIG_PCIE_TPH)		+= tph.o
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > new file mode 100644
> > index 000000000000..a0c09d9e0b75
> > --- /dev/null
> > +++ b/drivers/pci/ide.c
> > @@ -0,0 +1,73 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > +
> > +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> > +
> > +#define dev_fmt(fmt) "PCI/IDE: " fmt
> > +#include <linux/pci.h>
> > +#include "pci.h"
> > +
> > +static int sel_ide_offset(u16 cap, int stream_id, int nr_ide_mem)
> > +{
> > +	return cap + stream_id * PCI_IDE_SELECTIVE_BLOCK_SIZE(nr_ide_mem);
> > +}
> > +
> > +void pci_ide_init(struct pci_dev *pdev)
> > +{
> > +	u16 ide_cap, sel_ide_cap;
> > +	int nr_ide_mem = 0;
> > +	u32 val = 0;
> > +
> > +	if (!pci_is_pcie(pdev))
> > +		return;
> > +
> > +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> > +	if (!ide_cap)
> > +		return;
> > +
> > +	/*
> > +	 * Check for selective stream capability from endpoint to root-port, and
> > +	 * require consistent number of address association blocks
> > +	 */
> > +	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
> > +	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
> > +		return;
> > +
> > +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
> > +		struct pci_dev *rp = pcie_find_root_port(pdev);
> > +
> > +		if (!rp->ide_cap)
> > +			return;
> > +	}
> > +
> > +	if (val & PCI_IDE_CAP_LINK)
> > +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM +
> > +			      (PCI_IDE_CAP_LINK_TC_NUM(val) + 1) *
> > +				      PCI_IDE_LINK_BLOCK_SIZE;
> > +	else
> > +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM;
> > +
> > +	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {
> > +		if (i == 0) {
> > +			pci_read_config_dword(pdev, sel_ide_cap, &val);
> > +			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val);
> > +		} else {
> > +			int offset = sel_ide_offset(sel_ide_cap, i, nr_ide_mem);
> > +
> > +			pci_read_config_dword(pdev, offset, &val);
> > +
> > +			/*
> > +			 * lets not entertain devices that do not have a
> > +			 * constant number of address association blocks
> > +			 */
> > +			if (PCI_IDE_SEL_CAP_ASSOC_NUM(val) != nr_ide_mem) {
> > +				pci_info(pdev, "Unsupported Selective Stream %d capability\n", i);
> > +				return;
> > +			}
> > +		}
> > +	}
> > +
> > +	pdev->ide_cap = ide_cap;
> > +	pdev->sel_ide_cap = sel_ide_cap;
> > +	pdev->nr_ide_mem = nr_ide_mem;
> > +}
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 2e40fc63ba31..0305f497b28a 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -452,6 +452,12 @@ static inline void pci_npem_create(struct pci_dev *dev) { }
> >   static inline void pci_npem_remove(struct pci_dev *dev) { }
> >   #endif
> >   
> > +#ifdef CONFIG_PCI_IDE
> > +void pci_ide_init(struct pci_dev *dev);
> > +#else
> > +static inline void pci_ide_init(struct pci_dev *dev) { }
> > +#endif
> > +
> >   /**
> >    * pci_dev_set_io_state - Set the new error state if possible.
> >    *
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 2e81ab0f5a25..e22f515a8da9 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2517,6 +2517,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
> >   	pci_rcec_init(dev);		/* Root Complex Event Collector */
> >   	pci_doe_init(dev);		/* Data Object Exchange */
> >   	pci_tph_init(dev);		/* TLP Processing Hints */
> > +	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
> >   
> >   	pcie_report_downtraining(dev);
> >   	pci_init_reset_methods(dev);
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index db9b47ce3eef..50811b7655dd 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -530,6 +530,11 @@ struct pci_dev {
> >   #endif
> >   #ifdef CONFIG_PCI_NPEM
> >   	struct npem	*npem;		/* Native PCIe Enclosure Management */
> > +#endif
> > +#ifdef CONFIG_PCI_IDE
> > +	u16		ide_cap;	/* Link Integrity & Data Encryption */
> > +	u16		sel_ide_cap;	/* - Selective Stream register block */
> > +	int		nr_ide_mem;	/* - Address range limits for streams */
> >   #endif
> >   	u16		acs_cap;	/* ACS Capability offset */
> >   	u8		supported_speeds; /* Supported Link Speeds Vector */
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 1601c7ed5fab..9635b27d2485 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -748,7 +748,8 @@
> >   #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
> >   #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
> >   #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> > -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> > +#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
> > +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
> >   
> >   #define PCI_EXT_CAP_DSN_SIZEOF	12
> >   #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> > @@ -1213,4 +1214,85 @@
> >   #define PCI_DVSEC_CXL_PORT_CTL				0x0c
> >   #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> >   
> > +/* Integrity and Data Encryption Extended Capability */
> > +#define PCI_IDE_CAP			0x4
> > +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> > +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
> > +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
> > +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
> > +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
> > +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
> > +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
> > +#define  PCI_IDE_CAP_ALG(x)		(((x) >> 8) & 0x1f) /* Supported Algorithms */
> > +#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> > +#define  PCI_IDE_CAP_LINK_TC_NUM(x)	(((x) >> 13) & 0x7) /* Link IDE TCs */
> > +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Selective IDE Streams */
> > +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_MASK	0xff0000
> > +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
> > +#define PCI_IDE_CTL			0x8
> > +#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4	/* Flow-Through IDE Stream Enabled */
> > +#define PCI_IDE_LINK_STREAM		0xc
> > +#define PCI_IDE_LINK_BLOCK_SIZE		8
> > +/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
> > +/* Link IDE Stream Control Register */
> > +#define  PCI_IDE_LINK_CTL_EN		 0x1	/* Link IDE Stream Enable */
> > +#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> > +#define  PCI_IDE_LINK_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> > +#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> > +#define  PCI_IDE_LINK_CTL_PCRC_EN	 0x100	/* PCRC Enable */
> > +#define  PCI_IDE_LINK_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
> > +#define  PCI_IDE_LINK_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
> > +#define  PCI_IDE_LINK_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
> > +#define  PCI_IDE_LINK_CTL_ID(x)		 (((x) >> 24) & 0xff) /* Stream ID */
> > +#define  PCI_IDE_LINK_CTL_ID_MASK	 0xff000000
> > +
> > +
> > +/* Link IDE Stream Status Register */
> > +#define  PCI_IDE_LINK_STS_STATUS(x)	((x) & 0xf) /* Link IDE Stream State */
> > +#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
> > +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
> > +#define PCI_IDE_SELECTIVE_BLOCK_SIZE(x)  (20 + 12 * (x))
> > +/* Selective IDE Stream Capability Register */
> > +#define  PCI_IDE_SEL_CAP		 0
> > +#define  PCI_IDE_SEL_CAP_ASSOC_NUM(x)	 ((x) & 0xf) /* Address Association Register Blocks Number */
> > +#define  PCI_IDE_SEL_CAP_ASSOC_MASK	 0xf
> > +/* Selective IDE Stream Control Register */
> > +#define  PCI_IDE_SEL_CTL		 4
> > +#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
> > +#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> > +#define   PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> > +#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> > +#define   PCI_IDE_SEL_CTL_PCRC_EN	 0x100	/* PCRC Enable */
> > +#define   PCI_IDE_SEL_CTL_CFG_EN	 0x200	/* Selective IDE for Configuration Requests */
> > +#define   PCI_IDE_SEL_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
> > +#define   PCI_IDE_SEL_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
> > +#define   PCI_IDE_SEL_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
> > +#define   PCI_IDE_SEL_CTL_DEFAULT	 0x400000 /* Default Stream */
> > +#define   PCI_IDE_SEL_CTL_TEE_LIMITED	 (1 << 23) /* TEE-Limited Stream */
> > +#define   PCI_IDE_SEL_CTL_ID_MASK	 0xff000000
> > +#define   PCI_IDE_SEL_CTL_ID_MAX	 255
> > +/* Selective IDE Stream Status Register */
> > +#define  PCI_IDE_SEL_STS		 8
> > +#define   PCI_IDE_SEL_STS_STATUS(x)	((x) & 0xf) /* Selective IDE Stream State */
> > +#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
> > +/* IDE RID Association Register 1 */
> > +#define  PCI_IDE_SEL_RID_1		 12
> > +#define   PCI_IDE_SEL_RID_1_LIMIT_MASK	 0xffff00
> > +/* IDE RID Association Register 2 */
> > +#define  PCI_IDE_SEL_RID_2		 16
> > +#define   PCI_IDE_SEL_RID_2_VALID	 0x1
> > +#define   PCI_IDE_SEL_RID_2_BASE_MASK	 0x00ffff00
> > +#define   PCI_IDE_SEL_RID_2_SEG_MASK	 0xff000000
> > +/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
> > +#define  PCI_IDE_SEL_ADDR_1(x)		     (20 + (x) * 12)
> > +#define   PCI_IDE_SEL_ADDR_1_VALID	     0x1
> > +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK   0x000fff0
> 
> 0x000fff00 (missing a zero)
> 
> > +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT  20
> > +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK  0xfff0000
> 
> 
> 0xfff00000

Whoops, was moving too fast, fixed.

> 
> 31:20 Memory Limit Lower – Corresponds to Address bits [31:20]. Address 
> bits [19:0] are implicitly F_FFFFh. RW
> 19:8 Memory Base Lower – Corresponds to Address bits [31:20]. 
> Address[19:0] bits are implicitly 0_0000h.
> 
> 
> > +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT 20
> 
> I like mine better :) Shows in one place how addr_1 is made:
> 
> #define  PCI_IDE_SEL_ADDR_1(v, base, limit) \
> 	((FIELD_GET(0xfff00000, (limit))  << 20) | \
> 	(FIELD_GET(0xfff00000, (base)) << 8) | \
> 	((v) ? 1 : 0))
> 
> Also, when something uses "SHIFT", I expect left shift (like, 
> PAGE_SHIFT), but this is right shift.
> 
> Otherwise, looks good. Thanks,

I too would have liked to use the bitfield macros, but I notice that
this would be the first bitfield macro usage in pci_regs.h and that
bitfield.h is not a uapi header. In fact, there is no bitfield.h usage
in all of include/uapi/.

How about a compromise, I will add your macro to include/linux/pci-ide.h
based on offset and mask defines from include/uapi/pci_regs.h.

