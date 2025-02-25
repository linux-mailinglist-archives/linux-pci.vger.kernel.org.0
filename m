Return-Path: <linux-pci+bounces-22387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE70FA44E61
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 22:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5CF3AF532
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F191A0BCD;
	Tue, 25 Feb 2025 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crm0FCAf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0D40C03
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517711; cv=fail; b=V7hEas+6GkVoTG3KSopKnXf7aFzYx7UkWQVsBfbpcpQxIlbUQq04soUdTOeDIO9pJHhWYi4JGrIezPIEwwiaBUg7LbTo5746xVd3jlefoXrab5Ae91EPSy226ErjQ7nKbp73Lznj1RKjg+NfLudcbRJ1ORiLw8aPynD1sHihNC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517711; c=relaxed/simple;
	bh=hrOXdlIdq3sVfs4g5kVjfkx4BtRxl92J9tfdLmxyzkM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VGH06Jm7/NvKiqZdFB6iKhix5/CdedcVziZoJ34ZIqf/ZLWpMLaUW2KuVU6Gnrh0gouqJIskGLFPvKLOe2dkRCjxg7VwuQw9ai0SE5/SBj01tc75yYH1t23e6z5fNRBKc5FPgdb3dWFCFtiKtPizLPduWAnTvGyyT90zheWLpIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crm0FCAf; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740517710; x=1772053710;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hrOXdlIdq3sVfs4g5kVjfkx4BtRxl92J9tfdLmxyzkM=;
  b=crm0FCAfoN0DjEGV4Txwg1RGUPooLGlsg/ONB9GVvsjy2jIETerV2jmK
   eFKiMUYv1yXrTrvrT5zWdbg+08f8ZdEfMIcntAryS0YBqJfU0Z+QroPNR
   huJNIhyU+CYxo+eGHpndS23nJKrnUV9XM35P6PVMDFNIFdqqbXIm2h79D
   GPZWFgNWXgdsWpxd72YkpwNXBG/+p5CKjY9eE/RPvovAmPwQYnb50xeGJ
   Pck/R7Jd3Bb0gkWZ5BqC5elnQeFrGhzQufFfcj/ebROXIVIe3jlJKNPWe
   cTruJs48e1ZSCnposnfQ4aY62JF5asMr7sN+vuZeF/4DPPYT+dxzQrrh9
   g==;
X-CSE-ConnectionGUID: 1g0iYWCXQ+ePuZwZDdAX0g==
X-CSE-MsgGUID: FFyl4tKeTxSIlYVrgIJLxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="44995524"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="44995524"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 13:08:29 -0800
X-CSE-ConnectionGUID: djrT1TELS8aaZ4NFkLGYmA==
X-CSE-MsgGUID: 7NuMnAH1TvC/7mNl/4ybpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116497466"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 13:08:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 13:08:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 13:08:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 13:08:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWSUWT3evXejFtnncw5TT2dG3ohMkHM6ijU9B4QtoEBvmtKbUXdWmezglsn237/pSChD1kcfpOKoSr/77B7k/Pwz+uDmTgD7fOqSANIOMkedMR9LxpqporaFQvuu05sbkOsicZby3wy8bcyOedBr/S6gUUWMqbe8cVjRqvpTaeS5nj9NIOqWRPAutYxl14SJ+3VLtlDQTM9BatfxLhNUjkrajLb7OVQFZfVy4FpW41jL5/J48yZGAQ11m/INL1w/B69HRafLb1Kq2Nv8IVj5KzMhOkDA01v9f4UwEa/KmX1iUBPpK/usS7q66Bnn//GCDCFfxgEf0uHZJmgsHiJS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJhd+D4/HvVcYN3TtHyIl11YypElny5DwGbirfAyn5k=;
 b=O9QwIfzUEGwEtOKli2hN4jArue1YbjgDHx9G2g08RBDc2tkOKl7rkqG+cywdDwIPCVqIKJ+gvYDoiGRhXsSGCMY6mq9MZv0jKsEPSRyZxC7fpKNyILRaacZAp0MQDooAX5jA+Ke6N8kE1p5ltPP19dEYXAP9uWAlfQtDD36T/ZPzm94Gl0Jywj4PvzFSGZvjMbPfPotTTNf8H9KfFMnhn/qP2sJMtCa4KSMv8zCNtuIwP/vmdTBn1F3GaSPZAjZzauu73ViAhma5uIeTXBomNaW7nE7rsq3IvECREHQ4ts/7T/YhF/2iJL6xgJTyfy/DVwub08FWt4i3qL8YDj8ELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 21:08:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 21:08:23 +0000
Date: Tue, 25 Feb 2025 13:08:20 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, "Isaku
 Yamahata" <isaku.yamahata@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
	Yilun Xu <yilun.xu@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "John
 Allen" <john.allen@amd.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 03/11] coco/tsm: Introduce a class device for TEE
 Security Managers
Message-ID: <67be31446646f_1a77294ab@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741358.1074769.14824760616956254302.stgit@dwillia2-xfh.jf.intel.com>
 <20250128121744.00003188@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250128121744.00003188@huawei.com>
X-ClientProxiedBy: MW4PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:303:b4::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: b029b563-20a9-4c03-2b9f-08dd55e089bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W/KoB4THuqv/CngRchlfp+74OW8Naa8924+nX3Su+IgFWe4aotav8DHirh8Y?=
 =?us-ascii?Q?Avy4CHxLEz7U3GXAo3nzC1EMxSDkeuDMn/oUjzlVvs1/cMFcDXVdg5CkLOpy?=
 =?us-ascii?Q?6Fd3zc3yu20f0u9V44OXOHOCzKQe9OSfrAUsoK+SmHkB0Dze026DCUoBuhJK?=
 =?us-ascii?Q?vw28ntlyttmIjjtxvxcGw3480qAy2hG+1yEbdRtrwQTID5Vi6Bts8oD27aon?=
 =?us-ascii?Q?oC0nSPp33RL5PzZQH38qs3+dn0BloKkq0P7+szCWYCa/6KCxxPGldzsAyBXM?=
 =?us-ascii?Q?fDAT6uENITM6cVIgX+h6LmbeXe+DS1NlicnflfjWfwHYjZe61+YrYjQLk37n?=
 =?us-ascii?Q?OKu8UuLnaZi24PDT6tYemqH7ID9MPS30DVzVFqlb+W4lLkuv80hRryj/tSKI?=
 =?us-ascii?Q?aDVa+50tE8ZEcqzbRWHKWoHyUCO9GUPtGCi50Gkl6ASYK2Um1TuqIM/8PEtM?=
 =?us-ascii?Q?n9O1pkLsQDTRJIe16jStFgbFynWF8mwU5Tz9IL2IjOlA0Ie8mK8RkQXb+Jvx?=
 =?us-ascii?Q?IoTUd/A0pSFEtZ9OMBjruEK029oYZdNjjThp1uTMozegz0PSz4VQ52IqSpRf?=
 =?us-ascii?Q?ZWM+2WE5j7jIE7tnanDnkDuAtSfcGRvMeG76/4Cv3quzv8zYhMzp/6jl6+Zj?=
 =?us-ascii?Q?nMJe9EbS4oCxD5ReE1bHm9/XT+Zk5w3TDNUySYow4kMhNgZioSrdfMpff756?=
 =?us-ascii?Q?yZ5imGKxBuwdfJ3Dxe+zmDg9Uim0FtcEMiiD7afrgDFIk79dAF667gyF9BsV?=
 =?us-ascii?Q?k+KOSMj+BeSthsKMJ9KrMTH6d4zt/PuRwB8G0GOgWtlNtF2goAdQXo77RsZU?=
 =?us-ascii?Q?X0hGAtDnsWjG971lvvSAygiPNa9cZNvnl9Grrn/SHSWs1/qLAVFcv7ofYhEM?=
 =?us-ascii?Q?QUnIdRop2ly6HZmPaI1OZRolPVJBV9BFa1Y+6Cy01h0O20fNBVy5Ogk/51Bi?=
 =?us-ascii?Q?TlyfuK+ImaTGVvoggCHa+IEhEUMQzwfXHGQqlFM/BQH74hpS+AeVBWhSiioN?=
 =?us-ascii?Q?tM8uuKUWlVHhKn/lJqi4YPxbCK81Cpq/35pwhZxNcWRYiMJe/qlG8uIe/upd?=
 =?us-ascii?Q?cD1WrcgtwD8nzF+TYLZAb3euAJNNqkV9aJZTJUn0M0XNh8hooKH1WJZBOgxs?=
 =?us-ascii?Q?5F4zG2z5oQslS98NRXp5qr79L9kszHAx1OjkyZ2FvwhQjbGTCkEgWQzXITSn?=
 =?us-ascii?Q?Y1WrEhmRJ/O+WD2PPf2CJMskyNHJUrkHDS7Ye147ZjkMXkqR8ma0InieNc0A?=
 =?us-ascii?Q?h7lPeiAbg6huMKx6v2lHOvCcb4vSm41X/+ylCqsfyAmhztmLld5akCsvfjO0?=
 =?us-ascii?Q?09fERTzIcM6ueeND9Qw0GKmHDYJfDdhgn7uDQxotwxcHEHHygXkL1jl5hM14?=
 =?us-ascii?Q?pslDPEo/NtXDzISqCrYE8D9cRWYl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jhYEXDiWFJhaCp+Ok9PjQeqskoj2DpmwYtheRt8PEk/+kHaUL2wzJMtK6GQH?=
 =?us-ascii?Q?yWV9UKe7ngUsmcN6G+l1RBotU7iqNmIkHFmhH9WnYgEHePx73dUfZ9Id4EJH?=
 =?us-ascii?Q?5zwkd0LbQp9Ycz9lKtRQ/u370KsyHFxYmBJYVtZh0pbKKgXCcFlBXgy+reyT?=
 =?us-ascii?Q?lCBwHUxMAJ7W3DssuAzHf6HYJSbr6QHpw269ISucN5AzhGAkeUethkJ2G9ov?=
 =?us-ascii?Q?za1jgR+Ps+mT64N2gIjtSDyL2z4/95nn0IiEKbyyBa0IO/mb2T7qSJyYSDL2?=
 =?us-ascii?Q?qWvmFxq0uPrCcly7mHKbI81jUJSJAxRgz4t1+DqsbZ2HQxaws+3FGYORvsLF?=
 =?us-ascii?Q?UM+Fi1JPjAmjdV1faIJFsBzrrN5krWMnhuyX75BRhk53iU0y28Cewcy1WCHN?=
 =?us-ascii?Q?spAgRoZQIKKhIWwzKmmib5UGShs0uLeJrc+xGNo1MXTRh5xyKNXiTP64NAXm?=
 =?us-ascii?Q?A12fp+OIE6IeLyvtyeJatG3RJBZTzvv9Iv5qxxl2eG23C8DSsSPV4QKi4Hp3?=
 =?us-ascii?Q?0fa4zhiM3fZFvZ0k9UIZSZOrn4Gkq0xkQ12Gr+F9C0TZHAmK56kUrXSkUvci?=
 =?us-ascii?Q?frfL6bsEyN58EhjP12lTzsCgnkCnVTQ62ObORpfjC3IPt3c5rWHGhH322ZGE?=
 =?us-ascii?Q?o0yCv085gBGjYA+Cp5cjyfzjGWTNbzBNrot0j5jYG4P664S9mCskbae+5WZP?=
 =?us-ascii?Q?8HTn12oILb4/mYXTkKzd95q0VxJJOu1PeczP8aEKpB1n6k+72fKS3lvOLmPv?=
 =?us-ascii?Q?3J00TEFmg7sISiIWiqPWpxy7H9gWt1e8vi0DdMwWxAk1yfxUtCJbHepCccMS?=
 =?us-ascii?Q?CPlj9FuCnnE4sAqEIws5O+89fRtJOS2kyhfcWWGkdO35cRISCCGa0XTG5D6X?=
 =?us-ascii?Q?X3d3TdHGPEJshZDCUsnabdbi0qlVPvA6BJMOVInCsJY3MYYgtvNhmimg+A16?=
 =?us-ascii?Q?c9ZRQtVKeZ7wfOFf/msYlbMUiFtCl+GuTxceIUorIiqQ2nQZ9tuojM4nlvyK?=
 =?us-ascii?Q?9NMFSZgXDcwzgBMhV/az4aqi8cGB9teNXZSjBR0nZ9xkMEdTtbR0Mt+P7Fox?=
 =?us-ascii?Q?rVfEdfV5MWsfFYZBefki9Fje0x+pMGh3j8z1nxM2BGrYOZOr7d/nA4rUHjv4?=
 =?us-ascii?Q?NwoR8zWB7kN/6Zks2A/pUjQtnLGhLoRqa1g+CQQu0225vM8td2kfW2AF5DBt?=
 =?us-ascii?Q?fnwvVKwH6rcce9iQV/sDiYl9k3i03+ajqWS1yAmVbUucEFfnmF5BFFkDkQaW?=
 =?us-ascii?Q?OZcbUljKwS07ckO4U4wO+YdrJbD9E60Re9FHl3cmH7IsNO1cJpkB1YgAv1bp?=
 =?us-ascii?Q?1sHiD7VkL+cRZ7O+QT0IYIkQMwddQu/eZEf8zKhsF9t4keHSeN2YOpkdM8Lx?=
 =?us-ascii?Q?yQaVJh54Eq3OzrH+APlRl25t9KM7GxC+M3+jSLJY5G3k2dYOwyJr2piqfv+/?=
 =?us-ascii?Q?DnwBf8zCMmGU/O5h6OtylfaHmQvegvmS+tIvadLo8to0C4+aAGabSN4Dal6A?=
 =?us-ascii?Q?FLP6SHvEGeAml8TxjpSXl4KIZ74juooGzqbcy3j4kmMN81V9h7bLvnV7qW73?=
 =?us-ascii?Q?LbYLDuslyAlmpSsxVqNkG/7aZMZZo5pe+lhhFbR4Ouyb0OfVo9Ek07J6c7T8?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b029b563-20a9-4c03-2b9f-08dd55e089bb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 21:08:23.0308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSRY0UqS/ffWgGxAnb4zmDzquW6GJkGf3BzdBkwxJ/lueVaNhYc2LBw5jrpzm1KgYV6WREUtdJz1rqEM9zqVmyXeNgEHip8MXSJBQcn3T8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4769
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 05 Dec 2024 14:23:33 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > A "TSM" is a platform component that provides an API for securely
> > provisioning resources for a confidential guest (TVM) to consume. The
> > name originates from the PCI specification for platform agent that
> > carries out operations for PCIe TDISP (TEE Device Interface Security
> > Protocol).
> > 
> > Instances of this class device are parented by a device representing the
> > platform security capability like CONFIG_CRYPTO_DEV_CCP or
> > CONFIG_INTEL_TDX_HOST.
> > 
> > This class device interface is a frontend to the aspects of a TSM and
> > TEE I/O that are cross-architecture common. This includes mechanisms
> > like enumerating available platform TEE I/O capabilities and
> > provisioning connections between the platform TSM and device DSMs
> > (Device Security Manager (TDISP)).
> > 
> > For now this is just the scaffolding for registering a TSM device sysfs
> > interface.
> > 
> > Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> > Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Yilun Xu <yilun.xu@intel.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: John Allen <john.allen@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> A couple of generic comments inline.
> 
> > diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
> > index 819a97e8ba99..14e7cf145d85 100644
> > --- a/drivers/virt/coco/Kconfig
> > +++ b/drivers/virt/coco/Kconfig
> > @@ -14,3 +14,5 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
> >  source "drivers/virt/coco/arm-cca-guest/Kconfig"
> >  
> >  source "drivers/virt/coco/guest/Kconfig"
> > +
> > +source "drivers/virt/coco/host/Kconfig"
> > diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> > index 885c9ef4e9fc..73f1b7bc5b11 100644
> > --- a/drivers/virt/coco/Makefile
> > +++ b/drivers/virt/coco/Makefile
> > @@ -8,3 +8,4 @@ obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
> >  obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
> >  obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
> >  obj-$(CONFIG_TSM_REPORTS)	+= guest/
> > +obj-y				+= host/
> > diff --git a/drivers/virt/coco/host/Kconfig b/drivers/virt/coco/host/Kconfig
> > new file mode 100644
> > index 000000000000..4fbc6ef34f12
> > --- /dev/null
> > +++ b/drivers/virt/coco/host/Kconfig
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# TSM (TEE Security Manager) Common infrastructure and host drivers
> > +#
> > +config TSM
> > +	tristate
> > diff --git a/drivers/virt/coco/host/Makefile b/drivers/virt/coco/host/Makefile
> > new file mode 100644
> > index 000000000000..be0aba6007cd
> > --- /dev/null
> > +++ b/drivers/virt/coco/host/Makefile
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# TSM (TEE Security Manager) Common infrastructure and host drivers
> > +
> > +obj-$(CONFIG_TSM) += tsm.o
> > +tsm-y := tsm-core.o
> > diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
> > new file mode 100644
> > index 000000000000..0ee738fc40ed
> > --- /dev/null
> > +++ b/drivers/virt/coco/host/tsm-core.c
> > @@ -0,0 +1,113 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/tsm.h>
> > +#include <linux/rwsem.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/cleanup.h>
> > +
> > +static DECLARE_RWSEM(tsm_core_rwsem);
> > +static struct class *tsm_class;
> > +static struct tsm_subsys {
> > +	struct device dev;
> > +} *tsm_subsys;
> 
> This naming seems a bit confusing. To me tsm_sybsys could be:
> a) The subsystem itself.  So something we'd expect to remove only alongside
> class destroy.
> b) A subsystem of a tsm (confusing here in a subsystem for tsms). Expectation
>    being that a given tsm would register more than one of these.
> c) What I think it is which is, which is the device added to register with
>    the tsm subsystem.  
> 
> Mind you I'm not immediately sure what a better naming is.
> tsm_class_dev maybe?  Though that sounds like it should be a struct device.

Yeah, subsys is awkward because even though this device is a singleton,
it is not a 'bus'. I will switch to 'struct tsm_core_dev' unless someone
comes up with a better name.

> 
> 
> > +
> > +static struct tsm_subsys *
> > +alloc_tsm_subsys(struct device *parent, const struct attribute_group **groups)
> > +{
> > +	struct tsm_subsys *subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
> > +	struct device *dev;
> > +
> > +	if (!subsys)
> > +		return ERR_PTR(-ENOMEM);
> > +	dev = &subsys->dev;
> > +	dev->parent = parent;
> > +	dev->groups = groups;
> > +	dev->class = tsm_class;
> > +	device_initialize(dev);
> > +	return subsys;
> > +}
> > +
> > +static void put_tsm_subsys(struct tsm_subsys *subsys)
> > +{
> > +	if (!IS_ERR_OR_NULL(subsys))
> 
> If you are calling this with it as an error or null then
> that smells like a bad bug we shouldn't paper over.
> The only case I can think of is the define free you have
> below which correctly has the same check.

So, I do not think it matters in the end because there is no expectation
that anything but __free() invokes this call, and @subsys will be NULL
after no_free_ptr(). In general I expect that __free() callbacks should
mirror the "skip free()" condition in their DEFINE_FREE()
implementation. In this case though, the usage is so small and obvious
that we can pre-elide that code and just drop the duplicate check.

Going forward though I think this is something that deserves
clarification in cleanup.h documentation and I would argue that
DEFINE_FREE() and the __free handler duplicate the "skip free()"
condition check.

...or otherwise clarify the complication introduced by mixing ERR_PTR()
with no_free_ptr().

