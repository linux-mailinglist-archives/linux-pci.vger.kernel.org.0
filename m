Return-Path: <linux-pci+bounces-32086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EB2B0484E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 22:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83F81A6730E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 20:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15D56B81;
	Mon, 14 Jul 2025 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avg8JufH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB717A2EB
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752524192; cv=fail; b=P9zbTTy0iM2WBgkgopXmBmS49EaU24QgihA5cAXsYGQB1ELqXyKFq0xPQ2Xk0iD3ULt0NrUHPBkr5vJ7pZLRqtYZ90MQBK+u/MTeOBT+vw4b8EaufCIfXGcLV9OjVRvXFGxrifdKyw9FmLDwfs6U5vnMXSM3DSeNXDPYglO3NaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752524192; c=relaxed/simple;
	bh=JQdpjWWzhoFbhBPBF9JXoccBk8HRNszSnGMt8HVuS7o=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=iLh74L9LRpuE1MoA5a97jkx3WdQx9gduUjeLK6x0FYcpVkuzDYgOcsbQ+6rOkpM59DY+wcoskdLV4A2y83EQgFEhKFO+jZeqJmfOVfYIrewj84x6BSugo8OgOc4727SwmlNPHA51t1HNdD1/pJy+SMO6rUS42Cqb2J1skcIAPr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avg8JufH; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752524191; x=1784060191;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=JQdpjWWzhoFbhBPBF9JXoccBk8HRNszSnGMt8HVuS7o=;
  b=avg8JufHza+mcBSHqCz+H5vB3ZtHdz2AktBgq/DusJNmZxLiD6lBalU3
   JVj3jQMFoTVtOdpKBup6qB0tI9qXmSV/JYcZLwDurzgRtw3x8PiTu3FIX
   tP/nN51rK0aqKO+rFfdP1/dRNToL8HqnicuxfgYywo1fzhw/ioff9tzga
   ClXQ7jJIvf8lih6mXaPGFUwVwZFHDG7a2ha7B81mQsHvHkGIVzP1g+8Aa
   c/04/tP5E40OuNa0gNE6zY1YLHKgiYMYEsasOOvA8RRRj8Ym6Y1NC57XY
   MQYKg8KcaArfFSsE/90JhocOiBr3F6zrk+7yrsUAHgI+DvuWuxVybhpjW
   g==;
X-CSE-ConnectionGUID: dElsxyUdRROPGFzyRo7jgQ==
X-CSE-MsgGUID: fT7TOWC7T8q3Gpelf/RMIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54817299"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="54817299"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 13:16:30 -0700
X-CSE-ConnectionGUID: xJxWJbVxQg+jkMqstSpyAQ==
X-CSE-MsgGUID: hb3VQ2k7S7imOl5fq6uuuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="161036766"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 13:16:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 14 Jul 2025 13:16:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 13:16:29 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.42)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 13:16:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XylEiMaw+G5sCsJL6UCuDD/28pSAWOKYlDjsR8Rh0P2bwJ2/qc48yV2vLgC/RiL5N+LZlFjRDfMod4ke/13sqK5RFjGkCnje5V0ijcrpQSjufJmFcOoWExivHFDGBiontxkLUykDl3w4UT8D94/e2YtDjU7oP8eHf66rHspMUCyXjr2zN9lnC75DRTVfaflKtoYeDaDp1q2LtUYuZkdogxv0x0cZkwaRLApidCUlPL+QKYtja+us/ec3qjX1ooSPh3Nbv6JZCXYVhfWsxP3dYx+TKnNB640WAs1KyikuCZ1ScCd/mBIpp1hllW30l8eSpSIYftOiY0vkmxZv8eAkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXE9faX+LhiC5CCwCZltHi+qCsn6eDrpoRkkhQqpxw0=;
 b=Wiglsv/wf65x++Js2YH4PcPK8dAJV5Uu2ft4f7qjSZ3Vz3YwrT/kg32c9/i5MWHXTGYFNuf2wURsy/AdFgKfKPMxeJp9rjs2TrUM+k8YD/vdkeOg9S0JL0VWCZ9NkKVKXrvvEEDENQjHxS3SBuQyxIDQcZBaPzjFnL9qG0hsQ3DhvrXSdQ8d1fwrMx/ITomZ4ZCZhg21etQg5g3Nkj1wfEMLdCsjxKZdNLmjrxx/4s9QpOT3O1tWeD9CWhgmrS9kvzRxmO6IJf28KIvWiyQAdL2c6KgbZds1VE8iVTRSzIQCdFdspt+wpUZtx6L0h21P8GpwacAw45+8HUmnXOlJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 20:16:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 20:16:26 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 14 Jul 2025 13:16:24 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Message-ID: <68756598d351b_2ead100dd@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250617151619.0000325d@huawei.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-10-dan.j.williams@intel.com>
 <20250617151619.0000325d@huawei.com>
Subject: Re: [PATCH v3 09/13] PCI/IDE: Report available IDE streams
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da0bc86-0f85-4159-6f47-08ddc3134fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OW1ITC96NTdNUDdWMzJEcHYrQm1aczBGbTlMUFdiWVF3amNBcms4aVpadEx0?=
 =?utf-8?B?NHNpa2RrbnlXUDBiN2ZQRmhudzhrYkxKaXZ3d3J1ZjFTUWY5OXR4QXhSQ0Vi?=
 =?utf-8?B?QjF2ZTdScVR1TmNXYVFPd3k2eEFHdFJvUG5iV1ZWWHpQbFdxbGtZRG5LOTRT?=
 =?utf-8?B?cUFuQlhrYURBMHhIekxneUo1R2lHQlF5dk5XVEpVTjNidmllbDNwTXRIUWdH?=
 =?utf-8?B?MVdmdzN3emk0YzFibVFVeWR4QnBpS0pwSGhHSkpaTWRtRDVKTzlvZzNrcFRj?=
 =?utf-8?B?MW5ELzRaVUxvZ2ZvbFNPRWtjQVZhM0dHbGFlRlgzblRaZ0pPT2pJZXpDbW8w?=
 =?utf-8?B?aE9BMitvc0IycEtZTFlkaG1icFdMYzNkdEJyZEhvSFpTZk4zOUlVUGlsalNv?=
 =?utf-8?B?Zzg0TTB6VndUeTVSYWtTUUtIcFNwRDdGRTQzckk4cHBqdEYwY1NndEE2ejZH?=
 =?utf-8?B?Q3B1UHNUR2lkOEtxNDMzR2lFYXhNU1lsTHprUlo5c0lFMm9tNUpFU2JXamwr?=
 =?utf-8?B?d1FQR3pJUEFNNGhYT3Fza0Q4OVVrRmZURHdRdnU0K1NyRW9PNDBaNWZ6bVRC?=
 =?utf-8?B?NjVkeU1SY0x3b1ZEOTVjcHJGWGRWYllHMHF2OHRSZERMOVBHS0RxREhpcVJ1?=
 =?utf-8?B?Tm94dmErTW5pMTgvUWxteWtSc05jWDhYdnZOMER2U0t0eC93TkI2UHdTMUVR?=
 =?utf-8?B?WHIyR0dzNWJlM2tRNGhDc3RoZ1BJSmZ6KzFkTGk0NWExejVqeHBnUTJJSFFw?=
 =?utf-8?B?eXA0SFVrUGkzNFh1UjdhSU1ObjhrVTVEdzRpV0tOd1JvWUQycEs3czFLZ3Fj?=
 =?utf-8?B?ejBheU11MlBFbWNtQjBQUGhKZElMa1NKZjJtUzBtZGxBQUszamdrUnExQ0pQ?=
 =?utf-8?B?Z2pDWVVyRUd5ZFlHWk1XaUllRjExcXdiLzVpTEREWHJjNEJ4Y0dURDl2ZWU0?=
 =?utf-8?B?TGhSZU1ES004QXNPcFdDVlpLKzRtdGQwZ3JjajkrMDFMQUNlRkxhSzZkQlRC?=
 =?utf-8?B?ZG05cStsRDdJZ2VQdyt1N1VLVU8xYzQvcUEvMmp3Q2w0R1ROQ1RaV1NHeTg1?=
 =?utf-8?B?YXRJV2YwSE5EaFJYbXRQRjFOZmFzWWRnL3RiQlRGaStmbWZjNWk1enBVWk1R?=
 =?utf-8?B?d0YwT256YXZZT2VCQkVxdGFjOEk0Um43S2VtTHNudkE0VjZwM2xTWHUzc3Js?=
 =?utf-8?B?UG0vSEdHTmlZMXM1UjU2TGNrbDM3cEJaUnd1YjBFeGNhUkZBcjFIVjA0SW1i?=
 =?utf-8?B?WUVFRG9aMFc0Z2ZKdjUvQUlCeUZrZ0RoN1ExcFVacEJtRDg0dmVsQ1o5VUha?=
 =?utf-8?B?R0JkY1k4SHJjUGlnbXBHOWdPRE1sUlV0SkJYT2RpdEZxQ21jb0tXeHR1ai90?=
 =?utf-8?B?T1A3Wk1PNU5ub3dOUkxQaTZxQzBoS0hsRm80YzBnV2U1RVkwb3JiREFTbm8w?=
 =?utf-8?B?U0phVitsaHZ2dHBON1VnQVROV1NlV2g1U3U4ZzdrcmZCQWxNRk50U3FmOURH?=
 =?utf-8?B?M0Vmclo5UVU3OWhwUmx2bEFGS3oxWU1rN0JHQW96TlRZOW1YYi9lS1h5cDhO?=
 =?utf-8?B?MmdiQnY2LzlQbGY3dkR0UTRhanJMTVNUdlZFS1poYit5WFhVWUFldTFzaTRK?=
 =?utf-8?B?eTZWcXRXREVPY1k2T2hnM1Ftakc0YXR1YU9qY3VEMlhMMTNTajlmQldlTUJp?=
 =?utf-8?B?RXk1WldZczRtZ2UvV0J3cHVtMFhndWlPcmt0dkVIMnhUcmVpUGkrNnZUWTFH?=
 =?utf-8?B?dlJtTXB0bE9HMUMxYVpIYWhaK2VLTHVTOEZjczA0L1BmTXI1WnU3R2pGTUhZ?=
 =?utf-8?B?SnlOMnFnUU54eDE4K2dNWmlVckF1eEEyZXJjTEVWdHg2RDk0Wi9vWWZjMXhI?=
 =?utf-8?B?cUcvUnFJaGJueW9UM3I1bkEzamU1dzZuckRaTU00NkM0SDR3YjhUeENmTTdK?=
 =?utf-8?Q?+elUXtrtTD0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVh2Kzg3TTlnVTlnK0UwZFZNVkk1YU1zNFYvTmlJY0t2bkdWeXkzQ3c4aW0r?=
 =?utf-8?B?STQvM3EwL1B2WnREQnRVdkJRTlg2WlIyaU1nTm9UZ09xZHB5dHJwMkdxS2gr?=
 =?utf-8?B?SDNtdlFnWEhXMUgxTlJLWFRZallrN2M1OWlWSytrR3NJVmswM0dxMmp2QVpZ?=
 =?utf-8?B?MmlIS3VNZGgwVWt6MkVIeHU4QjVrR0tlM3hpU0JrQnFyRUxiTXNUT3haT0p3?=
 =?utf-8?B?M2QwV3l0R01YKzFjRDM5RDgzeld4anUrUW9ydEx6bWdVbEJ3T3pZbjFJWW5N?=
 =?utf-8?B?SVI2b09zMnhZeVVHbWc2QkFlWHB4cmhYa0hJeFZtSFpoelBqOEZwVzZ6aXpT?=
 =?utf-8?B?QnVoWlcwdGVrbG9BSlMrNG1oNGMxd1E1bHBHTDdLTVpGaTI1THNLK09XZk8w?=
 =?utf-8?B?THJKeS81QmZkUUtoY3p4QjI0TXVyVDN0ZW14SUtZQ05PdG44YWtWNU1wT21Q?=
 =?utf-8?B?WjhBYVF2dEE1WnVHejdZdXZHUis3L2dRNkQwdkJjUlJlNmNIYWIwY0NpeHNm?=
 =?utf-8?B?Z0FWaDRRbU1JWXlOMDVNdjY1MlFxSmtrdWppaUk2RGhVM2ZTYTVVdVVMSllJ?=
 =?utf-8?B?ZW1YRGJxYVQ5REQ2VzRVY3U3YnJPL25GTWZpa2xCVmFwMGNIUldUajU0eVVv?=
 =?utf-8?B?dFRpSlpUVDlSdjk5VUJaNXdDK25VTDJUY205WjNBZXA1VVJyVlZkMUl4Z2xN?=
 =?utf-8?B?NHdkSGVpTUEvTVRBNk4vOTI4Y0w4b2JvRlZvbDVqNy9NM1p0QjhrVkNWNzNt?=
 =?utf-8?B?cUFJNjdOdjdDMnR2M3ZKcnpvTEcwMm1iTDREdXcvTk9jVFB3VGFxMU13Y0JV?=
 =?utf-8?B?ZHFvOTNqeStKNzFQU2JJdWlKRWRFYnpNNExybGJCWEpMY0NRNnBITjk4emM4?=
 =?utf-8?B?RU5aL2lsZTd4UkdMdldmMW5CbTBDMDAyM0hDTDR3bjB6MFE2VGQ3Q0Z1QzZQ?=
 =?utf-8?B?bVVQR0kyVWhpZlBBV0svcUpzU040elhHNFh0OVJvc1pSYThPU2NxVkcrNzFG?=
 =?utf-8?B?OHpkUkRFUjJobXdCaktUL205Q2oxR2hBNFoyYnd5aXdsYnMxSTNPb0FRZGFm?=
 =?utf-8?B?Zk83Y2tPWUNsVnVIMUw5ZFZ0VXBUa0FZK2JSd01FbVBqZkdjcUt1c0U5SHZo?=
 =?utf-8?B?STNSWkxGMmNJMi9CeElyRXA0bExrbFg1S1JkeThYK2V1Y2VvMGd0YktDZStR?=
 =?utf-8?B?ZGM1TXJSZXlSWEtFdkhZN05uWm1IYW1DeXpwb05sRVdJYW9rUURueTFwQ0Iz?=
 =?utf-8?B?WElESnVyc29iYmxUcjBMYWJVdnQ4UmMxL2RmMDJENnUxSUgwQ1FVeUVxOVhR?=
 =?utf-8?B?OTNuMzB1RkZYSTVXQzVnWVEwZG9vS1FFOXJCVjNxNjdrNUlzWFhPSmh0aHlp?=
 =?utf-8?B?ckxqWVN1NFcyL1lkZzRFZGRBV2piZTlZTXFlOUNYZVkwOUMvMWxhbnhubFl4?=
 =?utf-8?B?eE41cEFEYks2aVpWTEZZcWhscHBQZHFQT3hJczVvNXVzQ1ZHUDZPS1NmcGxq?=
 =?utf-8?B?S3hFRHBmV0lDL1dFZGpOVG1QTkxMWDlYZWhTSGVrenQwMUQ3cEx0SVZZUjk0?=
 =?utf-8?B?NGtwc1lDenIrbW43MzJxWVpIMnB3R2I3K2E2MHpuVmI4Myt2Q2lRWGQ2bUVv?=
 =?utf-8?B?RUl6VGlST1VodHBFUUplNCtNRU5oV2NTRnR5MDc3a3NabUVZTTlUZnpHUWFD?=
 =?utf-8?B?ekJkRkIvaVREUE1tYmVvS2dHRitpNnY4WG52TS83aENZWmJIZm83QnZNNnpQ?=
 =?utf-8?B?OStGSFNCRmNsRnY1Wjd5U2UvRFU5Y1RlM1VXMENRTVMwZ0Rzb1Z3Z1U3Rk41?=
 =?utf-8?B?aUdQNGtQOFQ1ZGxQZ3NQcUU0T2F1QjRPUVpITWt2V0ZmNXRLNmJVRU1sd2ww?=
 =?utf-8?B?U1FKVi9kU3FXSWszR1phRGRGNmNPTEtZY2Vmd2piTzdJeTIxTzNJeWozR0Mw?=
 =?utf-8?B?ckV3R292MHNwUnh4NXdKNlp0cWMwNWQ1eVkxU0tvbldwSisxUWtpNkNlbFVW?=
 =?utf-8?B?b3kzRWZpMEozVVNJVkNXdThLYjBKWE1SRU9jMGkrOUFrV00xY2pQbUV2a29h?=
 =?utf-8?B?c0ExS0hrYkRsQU4ycnpJV09tVEV1RndkMW9RMFZzdjI3WEhJaHhJOUg0Zjlt?=
 =?utf-8?B?cnVTMXIwUnU5dGhWVjFlcnY3czRFNjZzeS9KRExlMVArcHh3cUFCVXdoVUtU?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da0bc86-0f85-4159-6f47-08ddc3134fc4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 20:16:26.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvGqKYLqOY16tqj37GtwddJI+Irf512RtHmDoipKw1k38ZLQBbzZ+FH/3yuYl26+2q+vP95ZnDMgYRZKhkgeKWLwhEr8BOaig+dB0So7BUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 15 May 2025 22:47:28 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
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
> Trivial stuff inline.
> 
> > ---
> >  .../ABI/testing/sysfs-devices-pci-host-bridge | 13 ++++
> >  drivers/pci/ide.c                             | 59 +++++++++++++++++++
> >  drivers/pci/pci.h                             |  3 +
> >  drivers/pci/probe.c                           | 12 +++-
> >  include/linux/pci.h                           |  8 +++
> >  5 files changed, 94 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > index d592b68c7333..382866a21703 100644
> > --- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> > @@ -36,3 +36,16 @@ Description:
> >  		stream resources shared by the Root Ports in a host bridge.  See
> >  		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
> >  		format.
> > +
> > +What:		pciDDDD:BB/available_secure_streams
> > +Date:		December, 2024
> > +Contact:	linux-pci@vger.kernel.org
> > +Description:
> > +		(RO) When a host bridge has Root Ports that support PCIe IDE
> > +		(link encryption and integrity protection) there may be a
> > +		limited number of streams that can be used for establishing new
> > +		secure links. This attribute decrements upon secure link setup,
> > +		and increments upon secure link teardown. The in-use stream
> > +		count is determined by counting stream symlinks.  See
> > +		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
> > +		format.
> 
> Is this name specific enough given mix of link and selective streams, both of which are
> limited?  Nice to use generic terms but this one feels too generic!

I will update the description to call out that these are Selective IDE
Stream resources, but keep the generic name of the attribute.

If Linux ever grows Link IDE support that can come in with a different
name. Especially because the security properties of Link IDE are weaker
in the presence of switches. I.e. you need to trust a switch to
decrypt/re-crypt.

So if Link IDE support ever arrives it can call its related attribute
"available_local_secure_streams" or something similar as "Selective" and
"Link" are not saying much to an admin that has not ready the PCIe
specification.

> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > index a529926647f4..b7561ac03405 100644
> > --- a/drivers/pci/ide.c
> > +++ b/drivers/pci/ide.c
> 
> > +static struct attribute *pci_ide_attrs[] = {
> > +	&dev_attr_available_secure_streams.attr,
> > +	NULL,
> 
> As below. No trailing comma here.
> 
> > +};
> 
> 
> 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 56704e851224..93be55321537 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -640,6 +640,16 @@ static void pci_release_host_bridge_dev(struct device *dev)
> >  	kfree(bridge);
> >  }
> >  
> > +static const struct attribute_group *pci_host_bridge_groups[] = {
> > +	PCI_IDE_ATTR_GROUP,
> > +	NULL,
> 
> One of my favourite comments :)  No comma on terminators. Let's
> not make it easy to accidentally put something after them.

Fixed. ...might be worth a checkpatch update for this, my Perl-fu is
rusty though.

> 
> > +};
> > +
> > +static const struct device_type pci_host_bridge_type = {
> > +	.groups = pci_host_bridge_groups,
> > +	.release = pci_release_host_bridge_dev,
> 
> I've no problem with this as a clean up but you could have just
> used the bridge->dev.groups instead I think? If you are clearing
> that out for some other use alter, mention that in the patch description.

Sure, I will mention it.

