Return-Path: <linux-pci+bounces-36458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F80B87DF0
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 06:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7393BC11D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 04:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0835238C16;
	Fri, 19 Sep 2025 04:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+bIVmZJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6834BA58;
	Fri, 19 Sep 2025 04:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758256549; cv=fail; b=YYRfLrAZgg7Ff1pEr3ykqLOLX6tBvl6WvVWs2VCd1EfeignYm7m13RdXFeeZtzWnVqu+vhRUo9z2W1tRDxccrWBznieWHi+yhpXuUfcZOXVJBYDLa/TiV+VPssu5aWp9vJ+a6oD/L9QX3ydLfK89k9rAw5mcn+2iCOFEI0vZnWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758256549; c=relaxed/simple;
	bh=1LJbqUUPg//GBWLDakWgCZWXBWJcbMvNgLYoYfUOmWw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NI3EXTnm+Duz6R6Sp0MG3hORuqsc6hFmHQ2+0s1w1jP5FX9kg2YjQ4kZf0eXC6LE1NboLgRIBRYQFfRkk5GmnI2/UhqT32uPWgiyKzRyL/CpDN7Y2d/mWxel5NGZnAlsQQqcIPRePj1TU7l5cCe12FY1yIcRrVMcK6gZkp/zwgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+bIVmZJ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758256548; x=1789792548;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1LJbqUUPg//GBWLDakWgCZWXBWJcbMvNgLYoYfUOmWw=;
  b=h+bIVmZJuRjNb5vYvyDAL1lGDkOWXZoz+LsJFxNVtrCxCnat7Vn4Yjn6
   XMFiIzAAfGsHSRWa7LCtjuHEYmB9ubuU66ONk3OVN44L4LVM3ufvHA1P4
   gGrocoUV7smSoltE6PEqomsieWActjWYamfdaORm+NrPNl8vzyzuVVrrz
   T97jfyNIqGbK+5DzMeSvMy2o26uFgqBI35fyt5i9Ehobmms3DFaICOlMu
   NDLr91Wqd9soFTggTVzx+g+2PCiHf5JS7+zurK/++hlEK2ga+r6nOZxDq
   Y7oFjiaARVL8Gg/X6LGgSLDSzulKkcTjFshi4LzhgQ+jIS++GZsCaUeUh
   A==;
X-CSE-ConnectionGUID: C647/3hURe6x5xn6tnefjA==
X-CSE-MsgGUID: O1XKd+scRteOXIHSh/QeqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="86038634"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="86038634"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 21:35:47 -0700
X-CSE-ConnectionGUID: j35IRFy1RzqzB3J6qTJSgQ==
X-CSE-MsgGUID: hvw7lstgQ+KFJHrCkee9ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="206681541"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 21:35:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 21:35:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 21:35:42 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 21:35:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1yGK+dSwD5y+uAvUXFDVtvqzESILoqbddLYKDMuy4zVRMYaZRwfepxr6Su5gyCeXRk38jJS5nuNEAhXNxZ2oE5cQUDCIHULbEVgnBt0SHEDbBRND+HB39I08hXn1TpvdeJ60sXjZgihGcOHkeTqtH4bUMKTvTcRbTpKcIBmktCEC91IS0pZJaAhHo6G9m3EGsaCOwH6F0Edtyik4b9ffEPWqX+gwEEeandRpJayP85Vr5o/6A/4bk1hLC5DiBO1ACngPy0XkBl68YVuQI1Pg+Ii4oVEAd1CNKhq1uTMvFPQW1OwcnwleIjfVhMTB6j2YyaSJJLV7Wz3dqRUkHtojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDsh3Zh0HTl88IZ0zhIO4Dl+OgGfQh2E0c59aerwY6c=;
 b=IZbqcEVRdHL8DrUnjk+6FeST1xGqNJAFc2NxDoEYL0scHG6pxueSxvkf2ASYBXfdeO10S0ifKurbCBjllgFVE1uU2B9wtFM2CVyV0taM5mW/6Acf6IOyWYUSgJeeb3LRPxZw3iEwXBKZ4jIOcqxnhYvTZ2qrIwxHPUZCEwwOG2BDn2f2kOpi5clG2WMwjxCb28jrVedmzVUqvHiuEeNrw49ZCPOYBD71U6b2omZ6fWu44o85XrrWSM9QsrQ+CNcaB6YVoOUsagD266RH34WJAOlHbInJKVNGymVlRTXo5K667c7JSNL8xowG+I6DOVE0idimRNzbvcQMFJuDwAqmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5273.namprd11.prod.outlook.com (2603:10b6:408:132::8)
 by CH8PR11MB9460.namprd11.prod.outlook.com (2603:10b6:610:2be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 04:35:39 +0000
Received: from BN9PR11MB5273.namprd11.prod.outlook.com
 ([fe80::bf46:a273:e7a5:bf32]) by BN9PR11MB5273.namprd11.prod.outlook.com
 ([fe80::bf46:a273:e7a5:bf32%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 04:35:38 +0000
Message-ID: <7b51dd9e-7abc-4313-935b-0e23deba3d69@intel.com>
Date: Fri, 19 Sep 2025 10:05:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/TPH: Skip Root Port completer check for RC_END
 devices
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <giovanni.cabiddu@intel.com>, Wei Huang
	<wei.huang2@amd.com>, Jing Liu <jing2.liu@intel.com>, Paul Luse
	<paul.e.luse@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Yishai Hadas <yishaih@nvidia.com>, Leon Romanovsky <leon@kernel.org>
References: <20250918192854.GA1916809@bhelgaas>
Content-Language: en-US
From: George Abraham P <george.abraham.p@intel.com>
In-Reply-To: <20250918192854.GA1916809@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::6) To BN9PR11MB5273.namprd11.prod.outlook.com
 (2603:10b6:408:132::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5273:EE_|CH8PR11MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ba0806-70c4-4de5-650f-08ddf735fbb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blU4QU9XbUNmUm9EOWc1QzRkMUd0M0hBY0FCeG5Qdi9NeWJsRG9KSWZYY1l1?=
 =?utf-8?B?ZDdacllIc2Jad1VQSThHL1dsaVhsQ2FWbGd1K3IreUpuYmFPRGEwQjJuUVRC?=
 =?utf-8?B?TzBrYnM5WHNkbFZwZ2E3L1pVcWthYlNPUlVpNm5DcWU1aDdrNXI4MHlVOGVh?=
 =?utf-8?B?c2toRXQ3NW9CcGRHMFpySUhYZktYczM2cENRRW9ydVdPMEd4UU95WEhUdHZy?=
 =?utf-8?B?ZytGSm1keW96MUcxbm50cmk3ZWVJbDVrZmxxZUhNMjRIWGo1aWRLTHpOU2wx?=
 =?utf-8?B?TytWL1RQUkptRXdkYmhIOWdpSkRpcTZkZ0FaZ3dMdlB5bkUrSXJVaXNxUE5w?=
 =?utf-8?B?T2p5WjZOY2RmVklYdU5VWkpoSUNGVEZ0dVBxNlhnTVRhL05nazkxdDJyaDZo?=
 =?utf-8?B?QUY4YlVnb0tiVkdITW5pWHFBNjVaTTFGMGhNUWtDb0M5U0w5dm1iMW5VWlA5?=
 =?utf-8?B?aHJPNnF2TEU1bFJUendYNTdLOUJGT1hqK2pGN3JHNzI1TWJacW9HenRUbEpT?=
 =?utf-8?B?dlNsbEp6dlF6MTl1bldVYTJlVVpmSXI3c2FGdElzemJiWmhqdEgwWE1Ubm1C?=
 =?utf-8?B?ZDNMZnk3VElZR2NidmRPSVp1aDFmYlhDZnJsTTM1ZW1MU1dkQ29RUGorMkEz?=
 =?utf-8?B?MmhGK2JmY244ZjMycWxGcFZUM0F2K2xKUVBGT2ZXcmNYZzFya0hWanJZa0VF?=
 =?utf-8?B?bzBWbmVyc3ViWWlKMG9PTTFaY2Y3OVpRWDBYUWhLSndpYVdOZTc4bUVUS241?=
 =?utf-8?B?R0hKZ0R4YUEwVFY4QWVPMEk0dHNwK1VTTXQvZEdNRFNaR09HeUlUc1Q2WllH?=
 =?utf-8?B?MnRYRnM5TmR4OGl2R0lYZktVUEkxdFRnbWNBQVBBWGozb21RQkpDYi9tRkd2?=
 =?utf-8?B?SGxqcThIUm5uZFpJUlRZalRGUTdwVDVlY3BvRjl1VTFkQ2hac1VGTzRRUjFL?=
 =?utf-8?B?Vi85YnlWT3RwUjNTMiswUmNtVG1lbk9LYk1SUGlheDF5cHRKRXNQYjN6M3Rn?=
 =?utf-8?B?bFh3YlhDNmEyQTZDL21Hb0hYQ2JpV0JaY2pyMU9TeDNQcm05Nnh3ZzhsK3BV?=
 =?utf-8?B?alR3UktqcSt0c29TT3pudVhpSFVtRnZ4bndYdlFkcndEV0NvbFJVYmhFNHIx?=
 =?utf-8?B?WmQ1UWFVVDdCQmp0VTV3VXJLYW13aW01YkVVNE9SMWdLUWhmWUlxKy9OUTlW?=
 =?utf-8?B?MnQ1eElnVi9DT2xBcjRBMGNKb0h6SG1wYVlGY3pRNDNBQTB0MVNITElza2R3?=
 =?utf-8?B?UTFjS0t4aFR0dUpyNVE1WG1hbWVqbDg4aWp2dE01cWtkWWZSSmZST0k2SXFB?=
 =?utf-8?B?V3hOY3BCeXl4Vk1Lc0JhQVloQ0lWaHVtemZNMm5NWjNUcWhLSFFNVDlheksx?=
 =?utf-8?B?dVMrcjloamxvbldBNGo1aVZUYXprbCtaMXkxWDl2UXJWbWs4S093aWMxbnBL?=
 =?utf-8?B?UENGMFRxT1lzYUx5cDJrUEo0VU9KdVkvVmcvTEREa0FUcU9iVGkvMUg2SGVs?=
 =?utf-8?B?UTBic25tTXlSejR4ZkVTL0tXWGtHTG03b21zQ1lIbytRQzJRd3JyUlFXaHhu?=
 =?utf-8?B?eXkydXVONFZwam9TZUZoMXorMlAveTNvOTN1NmNMZVZVb3VWQTd2K2tJYTJZ?=
 =?utf-8?B?TGs4S1pyeGhjMVF1LzlrR2F4STRwL0FLK3VsVVFBUWg0UDVqZzB6UDdpbHNV?=
 =?utf-8?B?MHhYU1hlL3VVWGExYktkVTdYZ1Q4UVl5RHBqcUczNEZCRDM2a2Z4a0puKzdh?=
 =?utf-8?B?SUZUQnh0OC9VN2dCYWtsTnlpbjJtRFVpZFAwY1ZWUDhseTVQRjcxNzRaeEtu?=
 =?utf-8?B?TzFKcU5CbGxWa2dKTkRlWk0zcnJSQStJbGZKU1MzQUFHSmgwaXdBQkFGM0hV?=
 =?utf-8?B?S3RHZEZOMDUxd2xNOTJ2L3o3YjBVMEVUcVJzS09NR252RzJHOXhLZTB2K1hH?=
 =?utf-8?Q?/sY+Yg7T5pU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnhvNGFrVk5Qdm9aYnlrRFE3N0lqVnRnR2FYc3dLS1EwTDg1ZnhraERKbmpt?=
 =?utf-8?B?QWNlUFY3MkpVU2pEeHdmbDhwTzMra0hHK3BUY1B1UCsxUi9SNnZMN0xtVnRp?=
 =?utf-8?B?a1NxTE44YjUvWWkyQUQxUVR6N2YwYmNHcDNpQmFiWlJMRUl0aHRTaTV1b01W?=
 =?utf-8?B?K0xITEt0MHgrVnc1eHZ3akt4ek0vdWZoU3J1RGtKRW44Zm85QnROamN2dGJK?=
 =?utf-8?B?RXNyZzRqcm92aElDOTRUUjE3VVJ6dkxySHQ3S3VnSk1zZHJEVlpEaUNCU1ZD?=
 =?utf-8?B?ckJnblZDbWMrTGcvYnVCTUprYzNiU05wUG81bjhBSWRwTW45MXZIM1VhMVM5?=
 =?utf-8?B?MHlDVGcvZ0F6UEh0VUF1VDRvbFBMMzJGUHlma1Q1K25PWHlDaUQ1RWt6RDY4?=
 =?utf-8?B?N3I0d2gvb2huZFRaRDBTUVR0RGRRbEc0MWlPdWF2Z0xnZUhIT0V1dUVvUGhC?=
 =?utf-8?B?YjFFdWRPZUp4WStybHY4MUVycGthcnYvdGk1cnRTb0dSdkQvQnNWTFczTVFO?=
 =?utf-8?B?ejk5MEVzaHdTOXI1R3JnWFBRb2tlUlpGRXlWUDhKcElDWE5RaXV5RllNTWNB?=
 =?utf-8?B?MVpxeGpXVGRRdHJWemhKanRHN2hnMVNUdTU5VG9EWTJmdElTTnR4dytLSHQy?=
 =?utf-8?B?ZDFiLzNiSWpoa0ErQnFVSi9meHpTd0l6ek5DWE53UGxGTEhGYjFkSTJ1T0FQ?=
 =?utf-8?B?djJkeTMwU0syZDYwcHlWQk1jd2ZUNVJONmJhYm93U0hacnA2Z1VOSVBDVFEz?=
 =?utf-8?B?ekFHS3NzSnlxZUxXK2lMSXRxSlZBNnoyS3NmemREdnZEMkNhenUxajZaVmFC?=
 =?utf-8?B?dzRYbWpSSTR4dnRUaEhlRnlocWdKcDdvWnIxR1VNVU1NQVZPN3hwd2R0b29F?=
 =?utf-8?B?MmJoUGdkcUV3N2dCekorMXh2WXo5Y1A2OGNleEJ6Skd6REdlTE5MWmpBY1pC?=
 =?utf-8?B?MCs2NUJqSmZoSi9qbFU0SG1xU3RTWkVVZVJHd0F6NmU0dzZhQWNqMUU4SXZ1?=
 =?utf-8?B?bWJXaEhCc2RUWmZhQmttSXVxY2E2S3JZa0MzcXk3eVZNaE5uZE8zZm0rQTFB?=
 =?utf-8?B?dDlVUUxrSHBYZFNya3NRR1pQcitYR3ExZ2R0c1dhazR0UTd4aEFYcWhKbHRY?=
 =?utf-8?B?Z2l4S1A3RXYzbVV4QTZXbEVPb3p2ZmIrK1gzc1pVL1V6dXNYdFB6UHkrNGVv?=
 =?utf-8?B?NDNRL1JmdElBVEJ2ZGhCRDZtSHRVa3orVHFNSHUwblpKT2IxSVFEbDNVaS8x?=
 =?utf-8?B?dzdOTHZ2c0hoeDI1d2cyN0IwbFF5ZzY1cllhUGkwck9OZ3ZZWHNrVGJGQlhi?=
 =?utf-8?B?NzZLNGdFNXlXSDYrU0FjV2RiRTg3eTB6SWN0WmdDME9DSDJDcmVhQXNLYTRV?=
 =?utf-8?B?WjVQTVdlalgvaTczTGdRWXZKM1U0cTNuSGdQOWxqTzRZSGNyU3MrK1h3NTFt?=
 =?utf-8?B?cXZKY0pTOVBJWXA2R3d3RC9JS09GM2syTTNZNXdYNzdKOU1HODRMV21URVZZ?=
 =?utf-8?B?cGNybThybnA2UW92bi9McUdxRDRKbkIwODRyNTZmQ29nSGlXMDB1ZW5Wc0dI?=
 =?utf-8?B?TE1zaW9mVllJbGdpWXZrNDdieE1qNC8yNlRJVUZ3Q2VEcXpIWjdYZWszbU8x?=
 =?utf-8?B?UXRBT2JnNHFFMXpFNUZqMnBNSSt6QThnbXFPNGlhY0NEWHpIZnBvUXBLUDdp?=
 =?utf-8?B?bm8yTXdQanlNTlpYbU55cytOUEdjQlZzQjRaZ3ovR3VQQng1a3pXejlCcWhz?=
 =?utf-8?B?M0gwdy9uanRpSzZBYlpzWTF4SmlZeHRrNExKc2REWFNMQm4yYmNLaE80dzBx?=
 =?utf-8?B?WkhLTU10UzkyZjdYNTlYZ2gzSXpSK3RiTG53WE8yRVNXTkhuUFNhRUx4QmM0?=
 =?utf-8?B?djhQZ1RDVWQ4M0dTaXpxcnlvUGNrbTBOV1c2cE9kSDBOdnV4SUxpU1poU2wr?=
 =?utf-8?B?MUczakJJOVZFSEJnMXVMUlIxVHBlZ1lONXgzTkZPeFEzVHdVTHpnU0tFdlJY?=
 =?utf-8?B?aXA3K2pXYVJFaUZhVUVpYkk5bE1vUGVSUTRTYUZTbW1JMWR6ZDRPQ1NCUjh6?=
 =?utf-8?B?Rnd3UE5JQUJmS0NtanIwSmhmZkZvMTExSm9DRldpNnlKM1VGQnYzR1RNK3lC?=
 =?utf-8?B?MkhFWXF4MG1LRGFWdXQ0Mll1cnRPS0E0dmdLOXcxNWNTam4xTTBzQWhuSFBG?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ba0806-70c4-4de5-650f-08ddf735fbb8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 04:35:38.8782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmcJeefvNdfvJBbpO8Vdaw4N353edl8eFjmpg35j+UHdp5vPE7r4XemffxHwSfVEAL3gk1DBlQvbegxTI/SNRtbauCsCSrCViW8mx4qHPXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9460
X-OriginatorOrg: intel.com

Hi Bjorn,

On 19-Sep-25 12:58 AM, Bjorn Helgaas wrote:
> [+cc authors of TPH support]
> 
> On Thu, Sep 18, 2025 at 02:19:40PM +0530, George Abraham P wrote:
>> Root Complex Integrated Endpoint devices (PCI_EXP_TYPE_RC_END) are
>> directly integrated into the root complex and do not have an
>> associated Root Port in the traditional PCIe hierarchy. The current
>> TPH implementation incorrectly attempts to find and check a Root Port's
>> TPH completer capability for these devices.
>>
>> Add a check to skip Root Port completer type verification for RC_END
>> devices, allowing them to use their full TPH requester capability
>> without being limited by a non-existent Root Port's completer support.
>>
>> For RC_END devices, the root complex itself acts as the TPH completer,
>> and this relationship is handled differently than the standard
>> endpoint-to-Root-Port model.
> 
> I thought maybe the spec would mention TPH Completer Supported for a
> Root Complex in an RCRB, but I looked through PCIe r7.0 and didn't see
> anything in RCRB related to the Root Port TPH Completer Supported
> field in Device Capabilities 2.
> 
> It seems sort of surprising that Root Ports have to advertise what
> kinds of TPH Completers they support, but we can assume that Root
> Complexes support both TPH and Extended TPH Completers.  Do you have
> any insight into that?
> 

I too was was scouring the PCI spec for this same information. Unfortunately
couldn't find the solution to the same.
The only statement in the spec that supports this patch would be that the TPH
Completer Supported field is only applicable to Root Ports and Endpoints.
Hence, for RCiEP, this check should be bypassed.
If there is a better way to handle this, please suggest.

> But I certainly agree that as-is, TPH is useless for RCiEPs since
> there's no Root Port, so we assume the completer has no TPH Completer
> support at all.
> 
> Do you think we should add a Fixes: tag for f69767a1ada3 ("PCI: Add
> TLP Processing Hints (TPH) support"), where the TPH support was added?
> 

Sure, will modify as suggested. Thanks.

>> Signed-off-by: George Abraham P <george.abraham.p@intel.com>
>> ---
>>  drivers/pci/tph.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
>> index cc64f93709a4..c61456d24f61 100644
>> --- a/drivers/pci/tph.c
>> +++ b/drivers/pci/tph.c
>> @@ -397,10 +397,13 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>>  	else
>>  		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
>>  
>> -	rp_req_type = get_rp_completer_type(pdev);
>> +	/* Check if the device is behind a Root Port */
>> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END) {
>> +		rp_req_type = get_rp_completer_type(pdev);
>>  
>> -	/* Final req_type is the smallest value of two */
>> -	pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
>> +		/* Final req_type is the smallest value of two */
>> +		pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
>> +	}
>>  
>>  	if (pdev->tph_req_type == PCI_TPH_REQ_DISABLE)
>>  		return -EINVAL;
>>
>> base-commit: c29008e61d8e75ac7da3efd5310e253c035e0458
>> -- 
>> 2.40.1
>>

Regards,
George

