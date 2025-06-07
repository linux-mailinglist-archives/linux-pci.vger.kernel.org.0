Return-Path: <linux-pci+bounces-29123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACDFAD0ADE
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 03:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3771709C4
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 01:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA1521CFF7;
	Sat,  7 Jun 2025 01:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVBL7IZB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE51EB5B
	for <linux-pci@vger.kernel.org>; Sat,  7 Jun 2025 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749261392; cv=fail; b=kwruUeZ3POtyxGKoFXKy38Xw6xGbsdzR0yP8vwoRdt5dZCZhq/HnKU36VfyPnz6yyZRQU0C0wqLi7YbGT/H0AgPcITjRg1wRa3yDq7u1SdSj+ajy61LPsHfowVDX1rBbnwDkxuaR1cOhcvvUyo6V1oiamhEl6vG6IyIJb/GVyus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749261392; c=relaxed/simple;
	bh=rMRV2K1DEcVBSDifj7QCer1ObEOo0jN8jRHPOEf7AZE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fSNmEsLrJDZxUA1FOi2wpR73FaoMD+sPiSVLO1Xgbz4gsNHAc6y+9Y30QEAAurzQI1devHHlTunBR9j+BLSvs/Q2u1mkULUDU9ZjwgnT92e5YBtrTUJh7rKa/dFs3tHl5limDH1AFdS0icbFUSWYm49r/lEEcyeoW1nhyT2JExc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVBL7IZB; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749261390; x=1780797390;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rMRV2K1DEcVBSDifj7QCer1ObEOo0jN8jRHPOEf7AZE=;
  b=TVBL7IZBKWuTvZd8iFMeztnj3410+xY5BnHchi61m6WiaeO87yQmKALW
   WxCuDsyMJt0FYfHGp60pmW9DR19OS7Ufz11jIPA5N6dk7UtM7CoNntwna
   JBc5NxR2Wf9ydznShHOD4gZBe6+ZcawSnTO26W02mMvE2KKtH1pgBFe8y
   WWXvcH+JNkCGCjIRjVelQp44L6spMQgX8q0M7TBmy6UXLxzER6Z+Nh12n
   hWU6Z9sOg0xm0HgNben0K0SCTEhjFUhuDZhJTUEXTM4Lpn4kPZatYQU1K
   zetVu0UqHcCcW0lF/hyXs0VLHNNYsMHjHCLxpp20O6lkSFWX6BopThJoh
   Q==;
X-CSE-ConnectionGUID: 8nJLfPyLTVeE6q2hpcQVlw==
X-CSE-MsgGUID: +xuKDVQwSjmLppe4oau5SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="39051310"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="39051310"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 18:56:29 -0700
X-CSE-ConnectionGUID: wj1U0EyuSx6lYSlFNLlImw==
X-CSE-MsgGUID: Yz0dR0AkTLGC+8HQ3G6d0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="145875760"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 18:56:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 18:56:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 18:56:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.72)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 18:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ev6r6mTNJLU2gac4nPSt40GsJLQfPczFVFTs7ssGQfxPacXy/t3kX64eq29YY6hdvoCri5XVg2smMCICdcbdyaBbrT+qjrC0DD/A/8eMYWajDiFYwikSvbNoR6iDbuPyRVtr8iHL+iaxT2bJEwk1ktEYtBx3GYYAFL3xxCKcd5DXEcSbaxEoENNvMdBm7YVxrLwpOx/TIpe52Tvaq6zPrzpKqIMlnlpWODG+ELdCWULqbAuBEP25PeaCIVOqG19n65MObK+8fgkZKm3KYur9symJmN5pf8ZOddHDbI96Khn2c9K5PPt2IxEoa00unmIEvRbVMZTPrJLRvNQCgBd5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zMnmZN7qGxl5LdQrghJKEw22/jycx1i9D9MLzdYl5Q=;
 b=KCT1MYkv4zXs3gjLZwSHcXbSd/w0uISF+T1I5nUtbNUWLUks53YNTNsnMl3YVRNmV14gdd7siXV27WAPXvtH1I6IJVH9iCAG4hJMO68LZaWwLUHHeWQH9DyUkNEP9gUyztGQnHGTBL6rOTn4L1vkX7TUrWSsDMshukH5Cnk/WULh0ancCou/i+6Gw+mKJatjX3ltViO6ymf7fPnEMJJpcZyWpVA/98HDkMY19azG37pi4rm8883/aiIWKA+T2RMPMXeTtwvvG9m9kFmioQ2/lSqaemokDXwaVAsyz6uRMZ6lwlYjrfk3jiatA069N4FWPJdp4l1tVDKznn24grgcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7330.namprd11.prod.outlook.com (2603:10b6:208:436::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Sat, 7 Jun
 2025 01:56:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8813.021; Sat, 7 Jun 2025
 01:56:05 +0000
Date: Fri, 6 Jun 2025 18:56:02 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <68439c325a714_2491100f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
 <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <5d8483bb-ceb7-4ef3-920c-d6286a7de85d@arm.com>
 <683f7b6fec30f_1626e100ab@dwillia2-xfh.jf.intel.com.notmuch>
 <53c7523b-5cf3-4047-831f-12e0422cdf5d@amd.com>
 <683fa6f622abb_1626e100e0@dwillia2-xfh.jf.intel.com.notmuch>
 <683fa76214ebf_1626e100e1@dwillia2-xfh.jf.intel.com.notmuch>
 <60812b1e-d01b-40ef-9e59-c6ab970e17e2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <60812b1e-d01b-40ef-9e59-c6ab970e17e2@amd.com>
X-ClientProxiedBy: SJ0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: d97b2448-a699-4b81-f0e2-08dda56676d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dPLFfV9FSgnQv7wmEPY+qflIBbDmCv6l/4UK0BPmiEtQ03rJEM+WL4pGUsNu?=
 =?us-ascii?Q?gvjb+O3It7/n0gK0UIEPtjd+DS4bUMbdKe0kWK0nthh27RZJBaIlFmR5sbci?=
 =?us-ascii?Q?nZ0Y7ouUHsOO+lQOhfR8sBLoKpny74Q2pPvHbAQjVa9FIUVy0BIY+zwXUcv3?=
 =?us-ascii?Q?fiwb++TmvBGqzTZTqwmA/KF4RkV1aTXxyXis7M6P2AuoWApTdA56Y7Aj+Nit?=
 =?us-ascii?Q?2/QUe5V3AawuP/fg483dmj1QtA/RTTMO2jgtwBsAQzX1LNK5LLYyQTIEmKz+?=
 =?us-ascii?Q?IMkTgshJ3bXkCDXlmyx1tSLYy42YZLWpQbz/iAWh74kTaJZm1Z41AKhHUsUc?=
 =?us-ascii?Q?Z19+04+SoK5vBph5wbYB76pLhOPhjRa73kctzDu1a0EQJ8ESlBadxsGRuZy4?=
 =?us-ascii?Q?xWhcx3iHJE52+JW0AU7NJ+vhGIqSozXXlWFmJFZULV0A28wlfUny5eacLDfd?=
 =?us-ascii?Q?tTWdTEew6U97nc2sv7Mjejp9FW/mZ3alDKo2MUHzSyEI9H2GLitXBcl5HBeX?=
 =?us-ascii?Q?144PZeXFQUo4onls69A7bElVpgjAQlIsbLBbCqaSQdj5Zi8Yoaa7eMmP7KzO?=
 =?us-ascii?Q?bKkD3JMrWaQITf9cPdYsstd5trybHsp3rF6d6d+CiGpCSiuqzG+7FNPR2H6g?=
 =?us-ascii?Q?Tgt/UCwk3Ie7Sbjobpu6EFRonG3ss7oRrEpX4IMRmBhnWnyG2jM9eXiQdcCC?=
 =?us-ascii?Q?+869LePNah2rCcv3lTyXuR7eHpqR6IQCzHHEtqV1bFzUAqujR+/b097rGXmk?=
 =?us-ascii?Q?D1lMWN7BDRN8dsqrnsD0C2LskTU2QElyDnH4FF4qlmbr5GmgJWcOuhhto4Qm?=
 =?us-ascii?Q?YymZ4wPMi52qebrjS+yDk0XqCPcZagsjYKonE4qPWivXm3/nS/O+rBQmJOA0?=
 =?us-ascii?Q?0X7Qi3r32TYs7u2PVAFLdNSyYy8avYxM776l3y0Kev+B6Sbrgzy04Rtr6SuP?=
 =?us-ascii?Q?s2KQ5xAoYonb/KwkmA0QIe8tOrkx8Dtoog+EFUmkwpcYKUOMVqqb/n1/rAGo?=
 =?us-ascii?Q?Xn1kTp4JTs+VRMZwcgf6gfdD0oa8wFxuU6zRsPn292EpBFiHDkehJ0vOTqQc?=
 =?us-ascii?Q?za+Sc9xnJw8/+AkDCySCnoPmVx6SdfZMS0oW/RDoU9IcAeb0cKwQQPNC+iW9?=
 =?us-ascii?Q?lhxmMVT7e6olYmbxFW+KthkOD+O5Dr6tniGjP+zY7ZCf/khT/u5+XnZ03dVM?=
 =?us-ascii?Q?em3CuO0xeY1HJ6j2q+vZHOgKUdWDt+fmomT1N5+dfbdSSh2swU59LIJ4SPVx?=
 =?us-ascii?Q?Vez0HCss0SuzvuM1Tsw7PBtEY1g/LwuNuuIVMTjzjaYISWiyal9Gz0Apqhlg?=
 =?us-ascii?Q?AGEFYaYcJUE5thq5jGaFvoazgcA0uio/l2wKXMkz10eT7QIqi1MJyKLOMkiH?=
 =?us-ascii?Q?0yVQ0YoWyEh+oZHTLGJkQdoidzFs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XJsqQYHX/kh9+44LaqS+XwSLbgGZkDG04Lw3MdoB/S6p3HYgrKXpoEVNn1gr?=
 =?us-ascii?Q?NuacBfyGfyoG5KEfE+kxPRPzp38fvQiAJigtcxnC3ARnmXLhnOs/hphgj1z7?=
 =?us-ascii?Q?grODax/8fvD5SfHNzTl2CRKahBbS/H0zdZoRgtY5YegN+xxn/DPmigeFanlZ?=
 =?us-ascii?Q?ahw3o6kfZRc3XnZTGX+A1ZUE9Oqo5UJZfM++ujlYXm74Z/n6r/bn1GOlyLaq?=
 =?us-ascii?Q?DJ5DCfTFkEr7L3g5xScMBZfO/+2m9oYc0lvSxrZZvbADw34ArE3AoxzvChvP?=
 =?us-ascii?Q?HWwwTRHQZNVwmG6gwS++Q8QL071E2gHkcwhsfn19GJTsftY/6NrTzNNm/vX1?=
 =?us-ascii?Q?Rrw6Yv2/bUONPBXoR69vxhXzH1IPMFWfaq1I7D6Bc0wsop4l8LU8e2KwrCoT?=
 =?us-ascii?Q?iy1h6UfowYCP6JoTi+4NhmXgJxycybT0t8SQyIj7bJvxN6vJTwBqwNFdUdbz?=
 =?us-ascii?Q?hXrEOkf3bqkBaXxTErr45gj529pKPtoFWkKa/BxmKIp5zfPvzXCBUn10J92n?=
 =?us-ascii?Q?JN4frKf5FZqvusWxo18FloUhqNw6dcSmwHQ3i7Iqm0yQF4KbG9HSbM6tRctf?=
 =?us-ascii?Q?lnmiqkBs4Oflr8fy5TuCt26lBYxMq552FnDD3MiFUvY7EuEFK2AhDZmbdNox?=
 =?us-ascii?Q?j4CJpsW+84fnqWfLvjc/HXWIFiUJnskG7NYOVedsyViwmA1WQ24kuSAN63pf?=
 =?us-ascii?Q?iFiihDSWy4wzeDgFOqyDqWxU9UkFoeoSqi85HLDIGaJqCX0NpaOfg45BpLE/?=
 =?us-ascii?Q?j04lP92zvexuJ6Wsx1tOlqWkzdoVDyrPHN27maEr3/tMwDB7aAdDIZAwyiNJ?=
 =?us-ascii?Q?kDtYMmAF0hA4zi1jsMSG7xCyYzObdZEpnXqy7cyy3Cx/pqgi0WOxGd2lioaf?=
 =?us-ascii?Q?8JRqOxKMab9DVMWmSesRvSlyigkx7AGE984zsFeX/aFwjUtrc17JimPpu2Lk?=
 =?us-ascii?Q?GG5qskRPh6R1E91AXOarnuCGFZgcnBEFl7Jzb0p5BAd0e3J/wUhAHoUb7fAB?=
 =?us-ascii?Q?HF7DrHehLQ/XuSelKvqZAhYzFXL/50/9rxSICZFJRalR8XgnakEloWU2B7ds?=
 =?us-ascii?Q?j/yX4FGiZ54prqFtMXmm9pS6V7pjvFwYDSOIcGMLT9urt8rbbcLhvXQsxEP4?=
 =?us-ascii?Q?Xuy8JPRzM3r02mO4W2RmUXvhdRObVVylgkkqCKIhsWlYByX5LqcVDIfx12JK?=
 =?us-ascii?Q?WWPVbr1JYahVJN3iEattT5fevJOjY38RkAM3fvJBAV7R7AmjEpnnLIxBZXWc?=
 =?us-ascii?Q?pNrJdVG8cRt2eDNHyuz3asfeoaeO66aJr3NUNYc+5+qPy6HQTaoTzsthYqKB?=
 =?us-ascii?Q?xr4/2nwRN3tzVWmwnea3dAsjHFIMk+sLQIQNDCbhmQ12Jtp0pIL80WXhMDUk?=
 =?us-ascii?Q?1wNYXDfqD4guoBnL3SZtCP9xSfponNHIII/qA3JE1qHu/6k6fbi668Of/PpC?=
 =?us-ascii?Q?bI9aU3nOT4CHYzATB1XWJjNavr397ACUVCzf7TDxIJmqiu09o/uNea5tooWZ?=
 =?us-ascii?Q?2x1R3TqHpjYV4ojtElEuE1OncVQuX9F5JUJxojTNI+VFrpTz2qQSvBSbLmLf?=
 =?us-ascii?Q?MZJs3A07xczbJzXHGzrVp7qq7WrQkwvuRyz7LI21levG5DpLNdJB5GP3LMMb?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d97b2448-a699-4b81-f0e2-08dda56676d1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 01:56:05.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjP4avgfNFKmUSr0XRywcdETUy8HvD2Hmf6s+lTQ9XLzVbeWlEt4joYBsZenzs+E/6HgN8SDdEIgSvFn9ORqRITlOOHTSqj+81ZK1gO/b48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7330
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > but the point is still that we
> > have not even got one implementation of a bus Device Security protocol
> > upstream, let alone multiple.
> 
> And my point is that TSM does not actually do anything with PCI except
> SPDM/DOE which can happily live in a library or DOE (and called from
> CCP or TDX drivers) and the rest can be just "device", not "pci_dev".
> I wonder if+how nailing TSM to PCI makes your life somehow easier, it
> is not going to help my case. Thanks,

The goal is not to solve Alexey's case, the goal is to solve the TDISP
enabling problem in a way that all impacted subsystem owners (PCI,
Device core, DMA, IOMMU, VFIO/IOMMUFD, KVM, CPU arch/...), and all TSM
platform vendors are willing to accept.

"TSM" is literally a PCI-introduced term. It comes with a full
device-model and state machine for a protocol that we, OS practitioners,
have a chance to agree what it means. If another bus wants to do "Device
Security" ideally it would map as a strict subset of the TDISP model. If
/ when that happens it is easy enough for userspace to see "oh hey, bus
$foo now has tsm/connect and tsm/accept mechanisms too".

Just like the evolution of the "new_id / remove_id, and authorized" bus
attributes, other buses add workalike functionality as a matter of
course. Other buses can add "TSM" mechanisms to their device model,
"TSM" is not a device model unto itself. Similarly, nothing stops
'struct pci_dev' properties to be promoted to 'struct device' when
needed.

I note IOMMMUFD has the bulk of all the interesting cross-bus shared
work to do here and it already has a generic device object model for
that purpose. It is another example of "extend existing objects with
'Device Security' properties", not "add a new tdi_dev object to manage".

I am frustrated that we are still spinning in this philosophical debate.
In terms of progress towards the goal of "shared commons that all
impacted subsystem owners are willing to accept":

* Bjorn acked the PCI/TSM approach [1]
* Lukas is doing native CMA and SPDM work that may yield a shared
  transport for multiple use cases (SPDM/CMA and TDISP) [2]
* Greg gave a nod to the PCI/TSM staging approach [3].
* Aneesh and Suzuki are helping out with ideas [4], and fixes to move
  this forward [5]

This is not a competition, this is carrying a shared upstream burden by
consensus for the benefit of ecosystem use cases.

[1]: http://lore.kernel.org/20240419220729.GA307280@bhelgaas
[2]: https://github.com/l1k/linux/commits/doe
[3]: http://lore.kernel.org/2024120625-baggage-balancing-48c5@gregkh
[4]: http://lore.kernel.org/yq5att5f4osr.fsf@kernel.org
[5]: http://lore.kernel.org/20250311144601.145736-3-suzuki.poulose@arm.com

