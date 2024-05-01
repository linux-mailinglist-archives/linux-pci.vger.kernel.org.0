Return-Path: <linux-pci+bounces-6961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777E48B8D74
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 17:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053701F21270
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4B57323;
	Wed,  1 May 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dyrabhs1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1A41DFE3;
	Wed,  1 May 2024 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714578452; cv=fail; b=gpzKHAziOBSl7nGauWF2sAKoqk2/IJuPgsJI5LqVtTpmCg13N0nB8vqYBf7U1QlJy6QctnBLVa4oZg3f2G8D07vFRonfmU1a66Io4Pwc5ZOjzPvCwmtz2hxG0616WK8cAnxbLt19zPsu+Vzxz2ZtQAB6WVr0U+OAn9YZz+iKpMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714578452; c=relaxed/simple;
	bh=QjQ4AL7W/SVMoRzX6RlJCi7g1acZRQyyEvfCbIod4/4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f48rYpiT7FQtyUZERZQXM/5TU8y1eeuTBiX+85e7saeQUxsJzO6ILh8HIJXl8V+5oLV1acnhGWkmcKgwv3G4Em+sL8R2iFx3tUHiAfGsFOgdhJ3QpVJgDAgzqu+F08hoEin1h8ctx+9mO/JOAsK6ouGEu4NS1InyFghFgXKQ6X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dyrabhs1; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714578450; x=1746114450;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QjQ4AL7W/SVMoRzX6RlJCi7g1acZRQyyEvfCbIod4/4=;
  b=dyrabhs1b5kp7c6sZN9s1lznQgof9UoHBnepWJ3hUM+gBHTxzN2Fy8xk
   dkDp4DHnCe6iUvBwiVBF1pug06dnTHnVLo2hOLP661cIVqSlqbJztd2/y
   gjliZGQweubF8oA3cQWbBP+JWaAR4iXZNEjerURXaCi/S2mK0/dIkp/J8
   yrgbDlufm7O2Ga1ywk2QthnChE34d6X3BMtPEzeNXFfNsHb6AbnCbgWG9
   0T57ET9EQLmOA0D9cy+OUj0j4SAfFe6xNneRYApSLSJv53GOd8qxktLO4
   p6c604cDlqQSX6j6uHecds4DG095lDYVOn+fayTJ4r3uEmP9ShBvKlFIt
   w==;
X-CSE-ConnectionGUID: Vpkhc5OkRf2F/uOriZ6PUw==
X-CSE-MsgGUID: HgQtmfyrSK28FdtGZAYvwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10438763"
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="10438763"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 08:47:29 -0700
X-CSE-ConnectionGUID: vMpuj8CSSQC1l6XvLOOvHw==
X-CSE-MsgGUID: +xS0UtkmTVSU8Q6YafnTbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="26669246"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 May 2024 08:47:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 08:47:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 08:47:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 08:47:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 1 May 2024 08:47:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0e9F3FpFaFqlh51OQtRqU7Q7v6/r+lkZU5+CK13HC0glZ+TJfpS6Ywjysr+FlqMiKxf6P7qtBos8+mG4zQNFZDCXfUSo07mSDRqB8Q7NywR0lRKKFGBIME1H6LcBSXzFahxbleLOtVKpBlPerzQUHbKEObYPFt8AZuHoWy2TdT8wINMeLpVSwWKGjIy9ftPluIeEBV6+Plkh+OYBTwOrFFY6XSXVwTcq+X6QkZxbaWgTNOyJ69sSZcBiXCwe/q8vbWGbY6uZdj/OZClWs/owxY7q70NQirn1A4gl9YSXvD9NEXJBUzwrETRUrDLJeXP44xVIsXvdcm/xOx5LjsREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8hCSlw4rThOqRWVvbcquLLou936tNLggOFK29yeVdE=;
 b=mt0SLxhcQC9tDNc7vXDa+VQgs3PwPNvAuP4qkOtAaZHxd2mHBfOP3WsWBmNQby2ayIlOP8wHA5b+qCfMSNXgZIodd0TCpekRNtJkHALEO6bQV0Q4MyXhnF5krMmKtohsaq4xuWKUt8kVsmVj0hYGX+peiWw4AWHPqhuGbF30OSD0DR36sstDo+5VVqFNKzhv8Rei4ueeNTGLqhyX9vp1GahK6h1Ycwb/VEI2s4g5vE8qDpbR0i4xMTIVPstU1QQEa2nluSY6aGIlMMXzKZBEjBOqNDdU+VJ1ANNL5i0V0jVtqQj0kpegluaU8eiJYv8gb2eLm+l1le0bOCJbb/aHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.36; Wed, 1 May 2024 15:47:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 15:47:26 +0000
Date: Wed, 1 May 2024 08:47:24 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: PJ Waskiewicz <ppwaskie@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <6632640bef65a_10c21294e3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <ce49c67c24f57ffab166d688a1c9e3139733f412.camel@kernel.org>
 <20240429153138.GA681245@bhelgaas>
 <662fe860eb889_1487294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f5078550384a6b9be5a6d05415ea321332c7fb96.camel@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f5078550384a6b9be5a6d05415ea321332c7fb96.camel@kernel.org>
X-ClientProxiedBy: MW4PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:303:b5::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: f157e843-7dfd-4f2c-f8d9-08dc69f5ffbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AUGFy6+dbeFU8gsTU7I/qa4zdoH3c+BgWxlSCfe6YvpkqNon+V+2lC5FoUVS?=
 =?us-ascii?Q?cMsObNi34c3UnSqVZyBAgvmpV0UNoT7lU85Lh6pwpcNLjOUBiy5bSlhUZWiE?=
 =?us-ascii?Q?VhCbcIoplFkI0QsA0CGvDzwLFVLxZSSRZL6DAJgONeFHmPd9NNXrAidcPnUi?=
 =?us-ascii?Q?/u8wyN6WU44pPYH492jFtUIGx+/Oo+RPOPVXwngrvm7NKXSDa1EYn4wXdtDb?=
 =?us-ascii?Q?fQzWeuB0PYeeAbZCTcq6ZJilWef+jYWJuBtfXQ1li4pC0iXE5fuf012MHvEo?=
 =?us-ascii?Q?I0vC3ByrQNfeSHIitLh96kyJZvSm9tESWD5+HsK7D6Mt1Gaa2hEOlgV+sPxs?=
 =?us-ascii?Q?qxFnsdrmR5JiLYH+nPrcT6hpb9CiWYEg4XfJu72e16h9mSh/K9qxynx+r6G0?=
 =?us-ascii?Q?isW7uvNgO6M6CjOKzPQOJ2l6tucbwicmZwDZ21KZdUuWXNxJZiLIGdzOneiQ?=
 =?us-ascii?Q?woORqSQYT2NfYtnaqP5HEwmSNfmRRxvcliMUsNthiA1Hl4+Pw7L4NLyBPT8P?=
 =?us-ascii?Q?1PGZRJ58uWtsXthhO+WFsEyird73V5prcVifsgynK858VBn6hlC1N8mtfiON?=
 =?us-ascii?Q?l9jnMZIUWLcPCkCU/b3FPqCGnDthypXJBTBdRqCu303qKb715evWAFzwpLb6?=
 =?us-ascii?Q?Pf43DisnkwUxzitVhYWamOBru61b+BiY2ruZro+s99zN8OoslWYmo/3GOcmQ?=
 =?us-ascii?Q?uN0sEZoIQ0Z2ucF3BWwXdBI0gTHL2TNgbGGEZUT1bSg5b9OJv1sNxcm3kq4l?=
 =?us-ascii?Q?8ED/yD8xhOBjG/4YPmKnZkzMMbQeI/XpFvun80Q8OEqNCIpn0/DYoI4kcarR?=
 =?us-ascii?Q?HV+Ry6aVKEHRl/RahPB+snKrWUqBZbCCztypVSYiUNw+JjiiozvA0v/qAf93?=
 =?us-ascii?Q?tNtOEjDnWC02Ny6g7/k8crgNMnP9MSqkFYDLj8npSgnCIxdoSXMLi+kMDxj7?=
 =?us-ascii?Q?WlFtUt36XzdMSEulyXeFvhihycU3zoQeg4FgI2ZLZmvZ/Ni6KQLaAXUak37m?=
 =?us-ascii?Q?RVQ6kzoMEkk/zCFzL+I9nRxJ4mTGDRyL4S9cVMLRcSJO0fyMjOHx4f0ojBYc?=
 =?us-ascii?Q?GxyRPYAmp6HQL2uk+CW5FHbGoxGHI9U5jP4iTfL9Ga5vxz5Uoaaf3NUkkFiJ?=
 =?us-ascii?Q?8XYA1DOWlql/4gKH7uy0JkeIN8pc3MXWnuXSiquCJWlQCPGu5gvNDMgfqFVK?=
 =?us-ascii?Q?ZmR0V5MFP3rnfyiol3qne/JXcTizPhgYg1QDfB2jemphuf+uycZbh5fY44Du?=
 =?us-ascii?Q?QBYqxGkvHcPW85hPLJ+xnByK9VaibfJw3N6KuGS48Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lRc2iKElNGSoxXTCrk5bVVDeFYU5gYEohNZPZ4X/o0MZ6ARNFTwhqIdVhe1k?=
 =?us-ascii?Q?WXq5rt04WK+0Q9IfYsJ3mQm8bibz9nhSS0RKj/h/6FlLkmYblrkbcvPEAe3w?=
 =?us-ascii?Q?5eYe3Q4uKimfoNtTDcXaPU3SadZyuF5LbqQXa25Kp2FSkUxe+OLkZfIC7zSu?=
 =?us-ascii?Q?km0Hx1G9eRYd4C+ZfscF8UlGGQCI83QK0NNyXXnW7n1VmK3Zw7PQNCLuph8O?=
 =?us-ascii?Q?nguuKIKqcxZ5xVvHe7BzHLtNxhXerGBfNnj60pnTVtwI3JcPGZbZQOXeXOeQ?=
 =?us-ascii?Q?zshxqWEkt5vGRj6A1XN0k+MSHmHPqaxC1EaZPP4UwuzgPGrVq6s3aZHSIvup?=
 =?us-ascii?Q?wSozo6FnCXNDkKawOZlzkPEjz7k1yLc39AeZjjS5gENM9xURxoEsoOpp7dMX?=
 =?us-ascii?Q?ckegqMlCPbClg0UInfMFEqz1werPJ7+C0JQpkQ4f+VavAS1hkabL8t7i9lfe?=
 =?us-ascii?Q?3Fq0mTO2r0GlVMn0GU6K0VkAayoWqaJngtL7gvse5PHzyZ4QMxpnReo6fK/1?=
 =?us-ascii?Q?mTpvEyHs2n2ITpLYBMotNyTh6DTgRYXJYNk/AMq5ruZ/YZzKvSZ/VGMzN693?=
 =?us-ascii?Q?wtqKfGbKsF5xp1gee86WvmiqDam+CKyrTgKFbtxXAOGTKT8H8O3eO5Dgo/es?=
 =?us-ascii?Q?ME8jCF13rjX+cRPLVJ867gaAx0AQOHcOGNbEnuKoSCgMOvIozENZAQZdgEJ+?=
 =?us-ascii?Q?MAn6ATo1ZuP3FnVlzmyvNLskoqBL0hoQwhix9W+gIEHeafqbhS5nMTSfjAjX?=
 =?us-ascii?Q?8KBpQumkyavMKAQ0XIsS3CUJqoYLKI952mcWIbK3DFwu1KEMypPjobIQ12BA?=
 =?us-ascii?Q?4wxSMq+awaz2SeFWdxs/HYg+oxNNFvmf25LUmqaUi9Ifky4K1mIJH5ZS+JSc?=
 =?us-ascii?Q?orT3E0mBtvHAj0H7q30fE7+ODlfBD2zbvfCs8AODJ72pCOCC6HmcboEbfTlI?=
 =?us-ascii?Q?fUJyA5Iuq5meFZyAvS5Qek9TNV4gNaWhjmogfG23a8e0cvX2BLiPukrzETuM?=
 =?us-ascii?Q?ARb1dd1dBB27yNaWc2eIGJTugR15i6jpkMYdfij24uGfN4YQioDvU7EK4YGy?=
 =?us-ascii?Q?A2kFzTK2aZlYGZIHCsjB3ruhlwG33o0VNOv+E7vO15NI3WiYxWbqrfj591KQ?=
 =?us-ascii?Q?RHMKsVkDFOpZjYCjDxQTQjcLBUYAQlWqZZTbWy+NF9rd2s4aYVlImCFpijGA?=
 =?us-ascii?Q?X6INgIlWq7hSeSOOQWgqNsRUgPI8mtmzIoS8aW2+ZWU3fjIKI6P1DSpTUGPX?=
 =?us-ascii?Q?PiEriTA+vF74SHr13HNkW0Mw4NR2/D96Mg3VEtJAYP+h8IhwpHgugBwN4F6L?=
 =?us-ascii?Q?XZAaTPzPj3viAjLiHZ8V5DKkMwpq+dpGmzA3sR6r5itAcuIHf/MVG6bz9PNq?=
 =?us-ascii?Q?l1Kx+26ffT0RmCHbLUe1+SoCb5i8WLhJl6pnxdDAM44WNjknqrcu5PfBXZT7?=
 =?us-ascii?Q?4uVc6vCG9HCRvKlAclD8XDYWRKZsZXHeMFLT7pAsHmkrTAiW7ol3h4CsM1mD?=
 =?us-ascii?Q?RrXocgW3zsjWy/eXZTauu1kz8P1MzmO6yp/+13hQvAsCQVSKT+Ob1F7UwqrQ?=
 =?us-ascii?Q?/EBlrqW2WD4Og7K+x6v5I5uhusEhLV12dwZFh6DoiUSgdI5sKE6+LhRRdohz?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f157e843-7dfd-4f2c-f8d9-08dc69f5ffbb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 15:47:25.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfWGgCbrLPd23HmkVC6/aJksbRoHpqxeQ94txE6vJ/FfvimPc4cbK7Icp3no/cRiwZJISwE7odfzv3L6jSCVkX4TNfC5bXSPsf0opdCbf34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6039
X-OriginatorOrg: intel.com

PJ Waskiewicz wrote:
> Buggy BIOS, that above value resolves to CX02.  In fact, it *should* be
> 49.  This is very much a bug in the ACPI arena.

Ok, so back to this patch in question, my concern with upgrading:

    dev_err(dev, "unable to retrieve _UID\n");

...to say "potentially buggy BIOS", is that same charge could be levied
against all of the dev_warn() and dev_err() instances in
drivers/cxl/acpi.c. So, it's not clear to me that cxl_acpi driver
failures need to be more explicit.

Otherwise, pretty much any ACPI hiccup message in the kernel would be
candidate for claiming "BIOS is busted".

