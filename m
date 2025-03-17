Return-Path: <linux-pci+bounces-23980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F89A65C3B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 19:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADFC97A4C49
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 18:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5171A5B95;
	Mon, 17 Mar 2025 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxBExP6h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A712419F420;
	Mon, 17 Mar 2025 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235508; cv=fail; b=d+1t0YXE8tH3f4TAoISsW2QqPHk2cJMNlntHp7zHhZvZ7i6vwo5WSX2NES8bt4/7IvdFdZGrdzkRG9gl8XyN3JCdLg7qPEIh/d/Q1FVrMGBnd01yOhUSB+oTe8EW4FdDKsu6AmmfEZKNzjGj7ZWen8+ezUGm64R2DMFI3u3Ma9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235508; c=relaxed/simple;
	bh=nKxngUp23Tat4OEWnYEr3tdpT4s8H2+B+dMm6nVWgZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lccgjs1588u+z+glD4jZbP0g8iU+Ao1E2S7LGJu+nP8FujA+PVRXXoWQWyd650xVAw8rz7Y/3/yE3YzDYnTh1r6UJ9t//THLnlRKMMzZhkFhpVUt6NYmUBtYFPjK+0Sxt1a2y0PFkleWrLBwxWijO+nyvNN9o1GyoCoRiHgxzIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxBExP6h; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742235507; x=1773771507;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nKxngUp23Tat4OEWnYEr3tdpT4s8H2+B+dMm6nVWgZA=;
  b=UxBExP6hEIo1P30GztkrsZbttrrhynNKvogeY7cToYW+5VykV/YXH95W
   AnEWTny3xkOpabzt35ceuD3EoICugiGzACsChWKOTtIbCjtlJAPYPPQQb
   MBWZ2KjRxVbI1pXbtJDSq0Dn6SabEgtSLRmErH4qUJe8nN2kh1RZuGlCI
   PlAL5s1ALld2YxUWCQH6vkxdPDZx6F3dSxfxVRFN84pgzDYwITgX4qo5b
   MvtTPM54Y63LbXwwsg4KmMpvd5zQ0vQIPDoxqYWJqbgdixL/DIHC7V1Cv
   pC/D7uX7lcsI/izZufX54mRy7rQ13aqnsNCiVNLFDq+f4KyBJ5wHQ+QHh
   w==;
X-CSE-ConnectionGUID: tf/IhRWdQLOK+Ho/BeAWnA==
X-CSE-MsgGUID: MoW4bPYGQ8mdBrMEIcg1kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="68704127"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="68704127"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:18:26 -0700
X-CSE-ConnectionGUID: D+de+9K5TC2fg7pJUWYOMA==
X-CSE-MsgGUID: sVMypzHhRtmJ+uATwxXGXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="126678548"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:18:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 11:18:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 11:18:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 11:18:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dd/f/YyKkrTdcXkY4m0PUv1okOJaOoJhanTBr76VWZkDohmoT+oKNK2WTzAGJMrDVgkXThXfCvsxw+izOvur4q2lMZdQDDhZKQKj9QSmSVKDlHOsOGxDqOb2eGwZ6VCIfaKgypUujAyj9uBPCE5N8Fdk/Ta1M+piTjh3Q/wGXk4jkiIYGlw9pxiFWcBc6l7DEpj4R7A2PDVkSpRM46PsJ7BYIKhPBy00vPzCuuLV1y/Y/QGxfoZOZiPJLP9VBcnyLw/3H8UmJlfhtkWNqp3O6zOfn+/9aRoGkraUkEcLCTWvZmxC7fVF6mHcpeQh4JL5c7BuXtKW3+y+JhAivxg17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfshA1YX2VZtPvPOFfkMDLHOcAnsMiyXu+MtVoCJy6Y=;
 b=uxnkjf3Ab5EhEp+gR4pPeEuDIHUskTh6R8NcrVXOk5o48BfGIt3APP7XiMBn4YjHlhHA5vguTNe3pUmd7qOs99tLyzOgvlyV0mR30ZdoForVQpzXDQC+fCgxkuNT6uaTY+0hO2n69V9kDUrWc+jE1M1+D1VTwdyrZlDlv1qplSeU52qgCI8/doVpMX3KqdAFP+aKaLgP5ljsLEaFI5/wrh7aPj2JCuUH8zeukQqH6/zWd7C1f34ODsTSEpOiFuSE0Khlcn2ltFQ5wm1drgE1UmIU6HpVr4HgDxg0RXkwcOKpHy3J+xByG3zfpNd/9vRj2ckne9rLPExKqK7ESW63aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 CH3PR11MB8212.namprd11.prod.outlook.com (2603:10b6:610:164::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 18:18:07 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39%7]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 18:18:07 +0000
Date: Mon, 17 Mar 2025 19:18:03 +0100
From: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Christian =?utf-8?B?S8O2bmln?=
	<christian.koenig@amd.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: Fix BAR resizing when VF BARs are assigned
Message-ID: <kgoycgt2rmf3cdlqdotkhuov7fkqfk2zf7dbysgwvuipsezxb4@dokqn7xrsdvz>
References: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
 <20250314085649.4aefc1b5.alex.williamson@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314085649.4aefc1b5.alex.williamson@redhat.com>
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|CH3PR11MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe38dc7-53d3-4501-45b4-08dd658010ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aCt4bWxWQnpWS2loOWhlOUJ6c0dwSDd5YnF0ZzcvUEdFZ2w3Sk0zZit3TG84?=
 =?utf-8?B?bW96SUhMbjdYaysxWFBoNVMyTURjTThFa2JPKzNNL0Y5RCsybmNKUUt1OFYw?=
 =?utf-8?B?OEE1YVlJelVqTE51dHZaSXFnOTN3VXpCN2RDOVZObWRZQkw0a3hMKzJNeHhT?=
 =?utf-8?B?YWdyTHJxbUtKc0FaVUNrakJxTWwrRHBUTUJwUEtZM2VkZ01Ba1Y4cXhXbUVy?=
 =?utf-8?B?aTF5czJ2WWVXdFhpd1VES1l1QVAyOTM5K091UXFabVFDYnNSd0F6cFVLMDg3?=
 =?utf-8?B?emhTdStUVVVoSkNRL1ZmYXF1TDlBWHFnZU01RVJzZzhIQ2RsM0tjaDNQc2xL?=
 =?utf-8?B?em5paldtRXBSYlIySDIzQWFOOXJRWDBPcUVlcnFPdnY1bFlHeWcyNGUyZ3Ay?=
 =?utf-8?B?L3l5UlZybUIrYVJLM0hiUUptWTJ4OFlERFE5Nkx3OTZMVndPTGgzQ2pJYjhY?=
 =?utf-8?B?Q1BCT2hMZ0l5emw1UURDcmUyYi9MUkMvNDJTWHVOTXEycGhRSFlwTVFzNnhh?=
 =?utf-8?B?elNnTU1Ga1hJOWNHcVRqL0haR2hFRWZvSDFiWDNTa2RlUXlyL1gwSnl5MTNG?=
 =?utf-8?B?dnE5Z3RmUUNqYWRNYXlsbTljb25rUVl1bmszNWlIRmcvNlN4RW5VTnArV2hy?=
 =?utf-8?B?RmpHZlMyeGk2K3V6ZEJkenNQVEVWREJJV2FlY1RKeVhuZ2drYWhncjhvSzJ3?=
 =?utf-8?B?LzJuSUU3RkdVZ0U4UFV0UU83VUNoTDBhN2R3QjdxZ2tiMkc5WFhaRng4SDhP?=
 =?utf-8?B?dzhWcVBmdnVDczlwekFuclJxK2NjYkNiZEdnZXJOVTNzZkVkbGgxVHhEZVZp?=
 =?utf-8?B?c05DQXN5VXg3bktDVHJBckhtZXdWRzRKaTV4TkptMTRHcXY3WXF4N3R3QkxT?=
 =?utf-8?B?VW90cXN5cytubTVnYktDWWhOTTlFSXdtREU3cUFHWTgzNkp4eGdrNnZtcVdQ?=
 =?utf-8?B?aGpQZ2d0VVpieEVZbHBQTHd2Sm1uVGxxRUpBazdraGtxeTNZRUQyOFZySnJj?=
 =?utf-8?B?Z1VUcmpqWWg1ckJWMEpJRHpvam9CN2pVbmR0YTFIZTNRdzZrck43RnRMbDE1?=
 =?utf-8?B?NWw5aWJoVk1xUStDaUlpYTY2bW9qYVIzWUU2QVFDKzNhbFQrUjMzQWhCRUtX?=
 =?utf-8?B?dnR3TzZVMWh2VEFnTHdnMjlja2VBVmJycTJJK0FHS0Y1d2lLcFZqN0tTdVpu?=
 =?utf-8?B?TFFnbnRzUlpsWGhNNStSNFJRVnByeUtrUlI1cXhBQkFSVW9mckN4RVhsdi81?=
 =?utf-8?B?ek5wdXFvTmVkSUovdmlpelFNdmpJajQyRmxPdG1oWUVYM1h2Yk1uOUxuQnBB?=
 =?utf-8?B?ZzRpaGZwZ01DdWhvTkJIOHp5Syt4QUNiZUFwangyR1NQUW1EWCsxWm8yVzRT?=
 =?utf-8?B?QTF0Q0FxR0dHSlM4WVN4Y0hQc092OGdWTy9XbWt6UEtTUjBFQmJUSm9Bbm91?=
 =?utf-8?B?WU4rSFFZWisvWS9WRUxLdVhBUUxCSitROHdNbGNEMEJKRzdUTE03NmRmZnow?=
 =?utf-8?B?OWhxai9pSWFZT09ldTU5SWdzdExzck1KZXpEWk9qazJOc01jL1pMY2pTdWhC?=
 =?utf-8?B?MkZ0KzM1enVHRDB1eWZEMi9zdzdadXVRY01ZakpUWjM0V0lBVjB2cHlZMWFG?=
 =?utf-8?B?cTl0N2k4d1VuMmcvb1ZhM1VPMEJNSjYxeW94NnlXeXBQdDNlditPejQzc1pI?=
 =?utf-8?B?L0FrRnQvVWZHdU1Mbm14YkJweVRFNnZSVVNRKzNIMDZVZS8yWnhreDh6SElS?=
 =?utf-8?B?c2c1QWlLcVpRKzNhbTVlYmxmL3ovTWZ5Qk83YSs5NFpubVNUOEVkcmpDeG9T?=
 =?utf-8?B?QXVvSUVacXg5L291L2paZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZxVE5Wc1BMdVZQb2dONjRTSHV2d21OT1N2S3l1R2k1OEU2S3FnSitWSnNZ?=
 =?utf-8?B?MVJzTkkvS3NEVFdVYWg2SHBRQ0p6amg3cy93RGdIYkMySlJHbVJsZDdIby9P?=
 =?utf-8?B?TzE1aUR0VkxkRXR1TkczNWRGWHRFTDJ2L0MyaStFcUFmai8zK0krMC8xOGlU?=
 =?utf-8?B?S3ZhNW5pcnBMbnc5a1dYQmRhNTFQTHZ1R3QxS3haWVF6VVU3T1NTWDdwT1dU?=
 =?utf-8?B?YjdaU08ycVNpMFQyM0NZZEthZ2hWMjBPWHcrV2xPQjZZLytpaldxc2NmQ3pC?=
 =?utf-8?B?czZyQUVOOGEySDZVMitmcWZiL1NRZGxYUWFDN1pHVEk1NDJJRkhkd2NoWnYx?=
 =?utf-8?B?N08xZ2ZXd3JkaGUwZ25DUzBaMERwSmQ5L1gwTllsUG43QVlHa0R0WVFlK29G?=
 =?utf-8?B?UC80akROUXpQOEtZazNlT3ErSUdYczBCcHhkZTBaQTRLVVJnSndNQitQdFNP?=
 =?utf-8?B?OVZUVHhIZlJnUmNPVmlLQWkwbG8rd0NITEMxMHJHQ1ROc2xGb0krVndLWjN0?=
 =?utf-8?B?N1Y4bWtFVi9wUDVEclRSRkVEWkc3YWY5OEZDaGJ4Mk55N25mTHlNTFNtcktl?=
 =?utf-8?B?UmRaQVZ2SllIdU5MSG9NQlhQUE1GdlZCa1FZTmplbCtLUG0zMkk3UFRMTE11?=
 =?utf-8?B?dkNxMHI0TFJXVE5iaVRpN2VWUXhQaGNlczdoblZyVTBHMkZ2QTR3d0tzVWkx?=
 =?utf-8?B?d0dqMFArV05KVHUyR0pmMzBVMm9EU2xacTd4bXBCVlNuTTZPcnVzSVpjOFo0?=
 =?utf-8?B?Q1lKWWtJWmVOUk5ucUtMZi85WkVCdDk0T2VKNW1jbEtkdGpuZjdLM1JjWGRz?=
 =?utf-8?B?YTJRMGV1NlB3SjZKZ093dlZ3Z2VQdmIzMkk4TGFaZlVsUTMxOUJoTmliY0pX?=
 =?utf-8?B?cWpUa1E3MXNpNk84L2xWS1FKV25aeGNiSHd5QnhkTDZEZi83MmxiM3J2eERo?=
 =?utf-8?B?TFpOcUhHMVQxZVNBT3BDY0ZWekUzaU1ma3Vpc3NmeGdmelc4VEpubXMxYXIr?=
 =?utf-8?B?MHYzM2J3WmNNV2V0cklkSlZ5aDNmU3A0bVU3b2JnVytWdDcwbHB5SUNzNGVw?=
 =?utf-8?B?MkQ2aUc3VWZoUmVYK1U2dFllMlFRZUFaZ3UxTG9JVVFNampCK1FHYWtrQ0Y1?=
 =?utf-8?B?ODh2Q0puU3hqNk1wTzdrU0t5OWJyNHE4dUZLRDNMZDAvL0Z5ZE9ocjMzS3dI?=
 =?utf-8?B?RUhiYjJqdldpSThxN1pCVWZkU3VYQVNwUHJ6a1h6STA3aDBubkRQbzNQT2lL?=
 =?utf-8?B?VHFubDRsYzZrSjZXeWJsQ0gxL0xMaENDNWh5RkFWanNmR2IxajdUc3E4L2dp?=
 =?utf-8?B?WUZGYlY1ZEZEU2grYWtUZmo5N090Mlg1cnJzNkVNdDVrckhWb3BCVWRPSkFV?=
 =?utf-8?B?cGR1TnF2NDRJU1d2dVovUjlDQXFDNGZrdXBxcHRBWWdzMnVFbmlZdHRhNVhB?=
 =?utf-8?B?VmZWSkNhY3B3RVAzMFM3Z0pNU3BMR3l4Z012N093LzlzSS9wUUtLMWc5ZFNQ?=
 =?utf-8?B?U0ZkbWt4blI5Y3NVRUZRdXRhdjRqWU9TR3IxT1NQVnVYVExiWUJndG5pZmpY?=
 =?utf-8?B?Ylc2MkVJdUJkdDY0WjFSdHlWV1J2b2RpcFRTUE4zMU1FR2JKZDM2YXg0TWNI?=
 =?utf-8?B?cGk3OUpBajJMZmJhK0w4NnEzQnFkSlA0NzdVZ21jaWkyaVpJYU5uU1RobkVJ?=
 =?utf-8?B?OTI2dktnMUxad2JBWDBDd2d3UFBLb3pUTmJ5MmdMNTN2WEFaaWtJYlN1TkVH?=
 =?utf-8?B?Qk1XZVZueGdtOHJPVUhxSG5lM3pCMVFGd3lwbGxPT0dWeE9wdS8vNHNRdUpR?=
 =?utf-8?B?VTE5RzVjendxaVc1K3huTWJXMW51UDZsN013TE8weVVJVzI3REllOG14RnNq?=
 =?utf-8?B?S3JIY2lQajh6RkpRTmVoZktZanhUdER2N1dyWXZ0cVhPbkJ0T3hhenJIa1I4?=
 =?utf-8?B?aDdRK2h6cVN4UW1BTXdaWHkrRzNvV0xTMmtTSnk3VWszOGxZR3RXbk1JL0Vn?=
 =?utf-8?B?TmVLdUpSZ09FQUVzbXNkSVBaVFZYc3ZTUEV3M2VYSGlHdjJwaEZiMG1mOUpm?=
 =?utf-8?B?bnM3V0dWYkswemRrdU1Wa3pjNEtySVRRNS8yRndrNWlNTmpBMFhRNFNteTIx?=
 =?utf-8?B?NEthbllZanlrOVNHZlVDTm1oYzFDMEhvMzN4cS9FYTdQa1JZUUhaS0ZDVUFT?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe38dc7-53d3-4501-45b4-08dd658010ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 18:18:07.2776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUfJ52Y0juknNTTQvuu3n64cRk9TlZPRyWk8MlVeZgB/tvrtHY9ssAToKqfRPggpnTcM+2xQdzj2LkyeeaZ83ZJD6RSHYPd4Zmj5XpNAz0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8212
X-OriginatorOrg: intel.com

On Fri, Mar 14, 2025 at 08:56:49AM -0600, Alex Williamson wrote:
> On Fri,  7 Mar 2025 16:03:49 +0200
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> 
> > __resource_resize_store() attempts to release all resources of the
> > device before attempting the resize. The loop, however, only covers
> > standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that are
> > assigned, pci_reassign_bridge_resources() finds the bridge window still
> > has some assigned child resources and returns -NOENT which makes
> > pci_resize_resource() to detect an error and abort the resize.
> > 
> > Change the release loop to cover all resources up to VF BARs which
> > allows the resize operation to release the bridge windows and attempt
> > to assigned them again with the different size.
> > 
> > As __resource_resize_store() checks first that no driver is bound to
> > the PCI device before resizing is allowed, SR-IOV cannot be enabled
> > during resize so it is safe to release also the IOV resources.
> 
> Is this true?  pci-pf-stub doesn't teardown SR-IOV on release, which I
> understand is done intentionally.  Thanks,

Is that really intentional?
PCI warns when that scenario occurs:
https://elixir.bootlin.com/linux/v6.13.7/source/drivers/pci/iov.c#L936

I thought that the usecase is binding pci-pf-stub, creating VFs, and
letting the driver be.
But unbinding after creating VFs? What's the goal of that?
Perhaps we're just missing .remove() in pci-pf-stub?

Thanks,
-Michał

> 
> Alex
>  
> > Fixes: 91fa127794ac ("PCI: Expose PCIe Resizable BAR support via sysfs")
> > Reported-by: Michał Winiarski <michal.winiarski@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> > 
> > v2:
> > - Removed language about expansion ROMs
> > 
> >  drivers/pci/pci-sysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index b46ce1a2c554..0c16751bab40 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -1578,7 +1578,7 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
> >  
> >  	pci_remove_resource_files(pdev);
> >  
> > -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> > +	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
> >  		if (pci_resource_len(pdev, i) &&
> >  		    pci_resource_flags(pdev, i) == flags)
> >  			pci_release_resource(pdev, i);
> > 
> > base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> 

