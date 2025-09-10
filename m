Return-Path: <linux-pci+bounces-35795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2054EB50D0D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 07:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAFF172B36
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 05:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD45255F2C;
	Wed, 10 Sep 2025 05:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7Lc35lW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8831F257854
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 05:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481359; cv=fail; b=NlcnNgQ8ouQmAOByQnG999wYTp3861GWW5ydPNWR4XyowR0jKjJYYvKRMY3Ui0xEF6rDyTF4OIOAdaA0IBtu643s4qdY5Ygh/jeQ4JY8aHIDZ9PtXn4/nM1TmoFfeIDWKLQH/Fb221zrTt3cI4jA7YInAFsmdn7QvVZGXNIG27A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481359; c=relaxed/simple;
	bh=61PAmTV88Bm4YmVY4KHuH6XOt44HGyIbGQl2qBXC95I=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=MnSy8wnd18szMKu2YB0ghPZBWWWTuJI+bcs+Mu0h70DQvwZTKWmCyykFzm+mYJicKxZzr1VrOpBfcduA7o1Z8p6kHva1oPYac1DSLZyIGWgKmyyNUi2NZq8Izs7x0Mxd/UnNMKrpq9aA2VnWxXhi1x+9CbISe9I68e1KQIkkZ9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7Lc35lW; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757481358; x=1789017358;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=61PAmTV88Bm4YmVY4KHuH6XOt44HGyIbGQl2qBXC95I=;
  b=R7Lc35lWAXHPCDzDbWXSNEImTrmD2gTzrBc9U0RIZeOGhl7vsKhVPBI6
   +nnGPViTGPTpToYu387Jv6mVSFvRw5Y1TgPOXcNhRJYNluaukDmANYZiE
   6H26E8YzrqqEIN5hpvJnRJyo6Ma8QVpbWNM/igvyDg4l1Jh/YwrWHU1Rw
   xn4dH8HxvHU6HslnzaKsKxH4zVgAvWTo3aXwxNd8zzAGrshAaSN0p8mbk
   f1PsybhLtkQ7MrTeF3+7Bgg6MkXp1T8ah9Vxhz5KMThTSKKNArqkYcc71
   pww4N+vB7Z3iU2b36zyqQA0DkzAv2zMNvHhlWNoFpAz2NguqDgX5qkkgo
   g==;
X-CSE-ConnectionGUID: 3QhFLEMjTtStbS6T2jjXQQ==
X-CSE-MsgGUID: cM6h87BkT7WtAjt8EUbScw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="62412238"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="62412238"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 22:15:57 -0700
X-CSE-ConnectionGUID: PboPkDvbSuyxcViv/ui5tw==
X-CSE-MsgGUID: cnl9FbxzRyu4byU+vHGuLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="177620603"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 22:15:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 22:15:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 22:15:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.74)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 22:15:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwYcGrkHzqWmsK2uwacYFuXqKP+Svi/SsiadPpqLAmL7DcUD6d5K5+lP6tgbDgE/SvC4cX9agdRloGoDIKlyidS8xzXs6jN5YuEe3rEuTfNtFoU6u7MIg4zAw4wtQxrp8T8vC3Sdfuj74y3r6DxGLg6X8nFrWr+Wycwb9dmXBBDqDEOhY6DgIvIo66i+vgmw/FIbEuvkbusGpOtCFx7nNvzj0Kxrriq9BZ3Jlr2z46m6DCrT9+go9yriAXKp6Kmw9e5FvROfM0ALrZrjsTeDeuXs3af6PAGeAnSczFqaEuhD0dfZ7ZPq8keDnP3AYNAn1/qp9mD4cZ7nI9+NVpYiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye7YY8SYbIhQ9lq+r968OX0ACi0VlqRFOXfghP9uTVQ=;
 b=pnjHznPlSQTwzx32vvRQwCaHxXAc+ytef2TfO1ZHdQ4U81ItNuJycn4/2XfYps+62Gx5KXtiw70kpCH2ublJbkMcguw2YLF4m6HXRRyiw2gEy2L9gWFFsDFXm3ggXzZQRtz7E72MAwlA+WiEPSw+y7ZjM5SQRh47TM9Me2ErWCGJMaouhw3m6YPeWEo8ijFAt+tSNla/s5BbdIcVoRa17KIiabmhDrTkeVwNPPHgnuCNsCpdrTHVqDTk2Efp4oOjd4l9t5l/MLzvpqesUaT3LeLi9MtnqQD/b+vrnf0FOSzAY0KbB8mNnyqKBLrHKkcuDwguuTPmHdE6EG9VOIzbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5184.namprd11.prod.outlook.com (2603:10b6:a03:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:15:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 05:15:54 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 9 Sep 2025 22:15:59 -0700
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aik@amd.com>
Message-ID: <68c1098fd6d3b_5addd100c9@dwillia2-mobl4.notmuch>
In-Reply-To: <yq5av7lz1rxv.fsf@kernel.org>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-6-dan.j.williams@intel.com>
 <yq5av7lz1rxv.fsf@kernel.org>
Subject: Re: [PATCH 5/7] PCI/TSM: Add Device Security (TVM Guest) operations
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: e844b82d-a331-4149-ba2b-08ddf0291dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0g3elZZeGU2WmRXRWorazRiN3RmVjBQSlRNMnpvL0lJZzRSNll0YnVBUUdl?=
 =?utf-8?B?L09xYzdaVEYvTHVnUHNxblYrS0xtS3hxTTVnZm9uYnRxcmZkbzNkT1h0UG9n?=
 =?utf-8?B?UU5OM21HMGlQT1hvakUwQjhRUEhBcm9sczJaWEhkUFBPdWZtSG9VNmwyQkYz?=
 =?utf-8?B?Y1dpWjkzMnBCZjQrc3ZOK0FRTUhiRmxWVmVYQ25oQ05YMnVaKzVjc0J1SmYw?=
 =?utf-8?B?aTBLZ04vdW14SUpUb2JRZkk4SVRoemhHQW1aNWNZZkNsaWk1Yyt6cGQzQ0Yy?=
 =?utf-8?B?M1M3cmFrWDl3cityUGhZOHJENEJTcmFoTTdJNXgvb05CMitRbUtMUkQzdHJi?=
 =?utf-8?B?VlhUcmRGNnFyNko5M3RVd0FZaGpyR2ZYUnZzc1E5Zi9YQnR0eExvSFVXeXdj?=
 =?utf-8?B?d0k1bmdVUTR0YnNvYnZ6Ry9oTnFDMlM5NlBqdGJtS1FZQmZHTXNwZWdSM0xE?=
 =?utf-8?B?eENFNTFxRVNGVUNXRGh2VEV4RHZsdlZrWFBKYmNWSDBuaTJYTGl0dmJzblN1?=
 =?utf-8?B?eXp0NE9TYXRrWnYrbDZ0VjZqblU3eGwxRG1PdDQzVDhjWXVOTHZyZ3VFWmhr?=
 =?utf-8?B?dXpDZXplYWhkL2FZWjhucVN1anJsNW9yeUFPZU9ia0ROanZCbGI5VVZZWlBG?=
 =?utf-8?B?d05JSithYVVPdHYybC9rdkNhMGZVMWlDWlpWL2FGdmlHRU9TRHlpWnNWRzha?=
 =?utf-8?B?RHpYYlErSFE3OTJHT2p6T29mNlJjRU1mbFZ0RDVxRmpoVXdDVE8wbzJwa0tu?=
 =?utf-8?B?UHNWSDRTVXlYRjMwRzZCUU9zRVJ5Q2pueGUzMDU0dFNwY3FicWY5Z1JtUUl1?=
 =?utf-8?B?bFJ5Ujh3aW12aE9FSEpOR0pNR29IMVJjeHo4RkFpNmhwQlMrUkUvakJrME1r?=
 =?utf-8?B?anpCeTJIbW03cm1HMllBYXpYZHZIZ1A0K0VqZnhvY2o5SHh6VnRicU5hc3Bp?=
 =?utf-8?B?WGVUdDZHdXNKWnFGS0lRcXJJWkQvWi94VFlxMkQ3YzRXS05neTFxV0NrWGxL?=
 =?utf-8?B?MXQ2bEpZLzRTdGxaUmV1SGlSU2dSbUxBT0ZMbmJxWUduZVNrd1I0amZOWW8x?=
 =?utf-8?B?TFgybHZSOXovbktPY25UVDlhTytmYTdONEtpNWxkaU5GTE94RFl1ZzBXUmdX?=
 =?utf-8?B?RDZ1NTc5RmZ0UVNFUjY5UXZqS0UxcGZibjF3WU1qYU1hTVI1YURsLzFVeTIz?=
 =?utf-8?B?dmd3TVQyeU95U3BDb2tuU0twWmRJYXNTTjh4OVlKNEFWc05JbFdaTFJ5NjVH?=
 =?utf-8?B?RURKNTFRSllpck96Ty9CT1FBb2p5UXFKZHJEZXF5R01SejU5TnpJaFU0Tmxh?=
 =?utf-8?B?a3ZFODZBQ0xQaWVCb1p3V0krYXN2cjQ2UnVDYTBQR2c5RXBKWjdQMmRtSzhW?=
 =?utf-8?B?empkSW1NMzZBWUw2SENMWGtudm9ZZTFXSmVnVTVFenZ3bS9sQkhURVNYVWpQ?=
 =?utf-8?B?ZE5CLzlxYmhLSDhReW5qdTJ3SHFNRXB3TlNmOHRjTEFYb0UybVJvMFp4eUgw?=
 =?utf-8?B?UUY0cGNNbC93VW1ZZ0lFaVBPU0JtdG45YjlXNmFYc1dRNHZ2Q3RuYWx1akhJ?=
 =?utf-8?B?YVIranIyMkFGWkh4aStvSVRVbVN5ckhLS0pLWU9IaGZUdjh2QlFYTjJDTGY5?=
 =?utf-8?B?WDJyNHNHMlRNbS9RbnhvMmRteHpkK3Q3ZWRpQ0hGcWFvRFhxMzJOaXZLYTB0?=
 =?utf-8?B?TngrTHNTMHJmREJEV2Zqalo4aW5pTFdyU0VYWUJ6dUo5V2dQdFJ6U2p6cWt1?=
 =?utf-8?B?UDNJa3JDcUpyYi9DRXBuM1Q0bkdlQktmNzRwL2FOdzFiUFNTelFrNndMUDc0?=
 =?utf-8?B?eWVHSXJZQU4xb0pBR3NWL0xweVM0bk9LU1hseWVKS2M4U1p0aHBUVHM4V0dj?=
 =?utf-8?B?THhVbW5zeGZVRGJ4eWdrUkw1aVRHK1FiYlJ3ZVRWOTdjU3VRa3EyUmswZTJh?=
 =?utf-8?Q?RflEGY7w+/w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEk4K0ZFQ3NzV1hMUnJpOFpaUkd3TkJybWV3cmtybTFJU1N4WGNXTkpHRFNh?=
 =?utf-8?B?MGlEZGlsMFkvVjl0OWxYcjFDMXh0MmpTQkJkNzlsdFFDemdsZ2F6LzdyMTRv?=
 =?utf-8?B?dWgweENjekV0QzdHN1hjd3FJcGp0RDh0a3lxSkZHSGQ2SWpic1hsY0VPaGhC?=
 =?utf-8?B?RzlTMC9jaHpyWkZ2cFdLRW5mdmxuR2kwOXhRK3hVN3BNeEltdlRubHJyNkI0?=
 =?utf-8?B?OWRobjMvWW8zdXpiRGplaGVRVHNiai82TmRkVmhSSDd2OE1WeTZnNU4vdmNz?=
 =?utf-8?B?UWRPSkxlK0NzM2hMY0RvMVZueWd3OUFVZEkzRHZUVk12cVAvRGlqdUcvWHFa?=
 =?utf-8?B?T1QvZWJ0emJxZzQ2QzIxRmo4V2JqcHBWYU50N0I5TFlTTFkrZS9MSVN2RHp2?=
 =?utf-8?B?RE9NUGFpbjVLT1JkV2dXM1RacmpnSGNXeE04S04yL2psdmU2azhzcE82M2pm?=
 =?utf-8?B?UnNBUXdTRW9jZkxaQlZYTFo0YU5qRlV3dFN1MXF4cU4xNUVkMC9mZ2NxTlBK?=
 =?utf-8?B?N0E4TCtKNXNsTTlIL25uOERadDc3akRjNnVaWWR2cHlTRmNoYWpqQ1d6YktB?=
 =?utf-8?B?czBZTFJBOGQyT0tPTjAvaE5GNkVjdTdlcDdEOElPcytmWVFpN2xWWVE2b0p1?=
 =?utf-8?B?azN6bkZhYVBOVGxGcHJCTktCaGUrZFd0bDNsYlpvQkxTcUkvc21rL0FsTk03?=
 =?utf-8?B?OTlzc1lPbklITFZqR2dxeXpRS29JdmlmVnlRblpDWUgvTU8zdU1IdHZBdjZt?=
 =?utf-8?B?UDNtYU9xMUV3eXBya2ZOUlNIVFZHTkVxSDJEL0NxZCtLN1REeWlveTFOWTRM?=
 =?utf-8?B?djF1Z01iUVNGK2tIbkYrNUpyVk5odEw0azI1K294TnVsZDZpOU9XcXJQZkpN?=
 =?utf-8?B?S1ZKaER2aE9iU3hjV2QyNHlHRGV3QjFGNXJpbU1adnhzZDZVVnZwQ1NWWVI1?=
 =?utf-8?B?TFFjRDJ0VCtvNE1TVXZCa2dZU1IzWEJHejY3SVpyTUZCS2dRWVFJZmg5Mmhj?=
 =?utf-8?B?WXh1Rm9TNFM2Ynh0aFBXMlg4eHJMMStUcnRLOVVxbDFHdWNVR0NSN2NYWm9W?=
 =?utf-8?B?VkdoYUF6eGo3QjZXWkZuN0hsSTk5SDdlRXhRbjNsdDdmOXFHdkMwRUJYY0dp?=
 =?utf-8?B?dXROb1lmMSt5SjVWWVhRQmw5dHRRQjdVVnYvLzkvNHJKQmUrZUh0eXBITkQ5?=
 =?utf-8?B?eVN3YmpJTXNRZk42eXcwa3hrRktoREFNQWZ1TkhqSWVoOXlSN09ZNFVubjky?=
 =?utf-8?B?T2diMDc4VlpLS05OOUh1UUlVbVRRcm1LY2tId0JXN2RFZS9nd3ZmUmt4aE5G?=
 =?utf-8?B?QjliM1dCdWhjTk1tOURzR2U1NU1ZR0luZXpFMFBDYUFtbEpuM3NTREgrSHhH?=
 =?utf-8?B?akVTOU5vUitQUFN2bDYwd3hiZ1ZyblJ1SEdZSzBHTWhLLzFIMklGOVFlK21D?=
 =?utf-8?B?b1BrbDVUcG1QS21LdHhONkwxRkhlYjQ0M2F0MmZhR2ZnazZDSUJzcDVIeVpB?=
 =?utf-8?B?TFQyQjJEaHBRd3EvSCtqbkFMMTU0eTZQQWUxV2VHUDdRNmMrZy9BVEdleHND?=
 =?utf-8?B?LzJQKzdVV290M3I2clZRQ0NBMzhFdHJnc0ZYRWNqaVlrT3AydFQ0L0RQd2Uz?=
 =?utf-8?B?SzdOYmFCSzloYWl5ak0vMnBBbitkdExkQUY4QmJEYkMrcCtLYjdwdEpMWEdS?=
 =?utf-8?B?cEV4ZTVCODZ3ck51L1JoS1MxeWd2citsci93MUgzZU5iV0xaWWRBM1RrSjg5?=
 =?utf-8?B?blc5MDRJc3k3VGkvSDFXT0pJUi9oeFJZbzJKTFpUUGp2aUhxZTZxSkMyUmdV?=
 =?utf-8?B?UmFvNitEMWpoY1NWaGFwM1R3ZzlkWFRtcGE3MzNjMElVNDRRZFNDN1lmb3du?=
 =?utf-8?B?N0NBNW1ybllIMm9kTi8yVTIrYkRlM3lBcVZzdGJnbGg3b250Mk56b3lIZm5U?=
 =?utf-8?B?b3VYbDdQdXY4LzJtZ25TRUlYY3NjOTliN0p5L0VkQWtkM25JczhOTUlTZ0g0?=
 =?utf-8?B?TTFES1hSdUk5eUNtS01WZ0pCTDNHWlMzdWZIM2NQVnhKajFIaHBNR0dMTGlZ?=
 =?utf-8?B?b2I5aWoxS1F1Q2FSbERuK21OTmhSWlFUNW9OdU1qNlJNVGRWZHA5UW0rYjBO?=
 =?utf-8?B?eXZxVDRtZ1lNWlhyUEFlWC9LcGY3N2lSUGUxcGxNQ0ZoTGUvejJwbTN6STJN?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e844b82d-a331-4149-ba2b-08ddf0291dc2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:15:54.1674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXC91rk6gxhuRyzs8ZMq6yGoCrfrN7J6Z+9Qs6mtkQH38OjVZRY65swbPQhlD30BYEYpQwupGcQ+mBkJ77kwuPIp5ydgRZtbo8p9wzIV81k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5184
X-OriginatorOrg: intel.com

Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> 
> ....
> 
> > +
> > +static int pci_tsm_lock(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> > +{
> > +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> > +	struct pci_tsm *tsm;
> > +	int rc;
> > +
> > +	ACQUIRE(device_intr, lock)(&pdev->dev);
> > +	if ((rc = ACQUIRE_ERR(device_intr, &lock)))
> > +		return rc;
> > +
> > +	if (pdev->dev.driver)
> > +		return -EBUSY;
> > +
> > +	tsm = ops->lock(pdev);
> > +	if (IS_ERR(tsm))
> > +		return PTR_ERR(tsm);
> > +
> > +	pdev->tsm = tsm;
> > +	return 0;
> > +}
> >
> 
> This is slightly different from connect() callback in that we don't have
> pdev->tsm initialized when calling ->lock() callback. Should we do
> something like below? (I also included the arch changes to show how
> destructor is being used.)

Do you need to walk pdev->tsm when you are creating the tsm context?

For example, pass @pdev and the lock context structure to
rsi_device_lock()?

