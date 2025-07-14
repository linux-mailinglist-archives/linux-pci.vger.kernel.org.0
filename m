Return-Path: <linux-pci+bounces-32088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B0EB048E8
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 23:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515EC4A33CF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 21:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1DA37160;
	Mon, 14 Jul 2025 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fnsn8Yp/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976A23643E
	for <linux-pci@vger.kernel.org>; Mon, 14 Jul 2025 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526829; cv=fail; b=jVe0Lt0eI7slSz1jFtLyUJBafX4yXrzhU1u4R/D7FsbVoEOkYdW7p1Ph+QSmlWoG1Uh+Iqenh07d+oaZH+as08QLk0vme5JzFUrbMnMkVjUTijS93EbsXiJQaZOgp6EFmsCn9/3Zd4PZwzILgElbSO6l/bb9szS2DNrgDUeK3fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526829; c=relaxed/simple;
	bh=bOawu5wy9g5e3kX94hbtqlk2BfUvtMsXI8NdTA4uxuQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=XglRYfGatbP5Y9InbBecZcP8MQLWHFYXjz5Dku6ZLgKqyyhv95luEiosSx/lXyGGNLmVJOtSndM2yt1AY5I/U9o9hSYDDmdLMeqe2PQsFLcfJW3qwk1uak4tQR6rZDvKr6hke+fieQu+4YyqVTnnL5ebL9GpR16oXFfuE0gfiwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fnsn8Yp/; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752526828; x=1784062828;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=bOawu5wy9g5e3kX94hbtqlk2BfUvtMsXI8NdTA4uxuQ=;
  b=Fnsn8Yp/lzT5TxzIVqItivocOpw85V64BtzKxa4Hu+fGFgEiK961Jfka
   CKa8Ar/lM+kGphed5Altrh0kmqOO8Yi/dRL0bg8Yf3KecTVrCQBLWkvEy
   KuFVvQu+2iCDpiZJl3PROpvxSqw4Z4C7qTNmNbF+X1AWAhF0mXJG/MlEZ
   pictLkp4xEwBvUGp5i1lH66JFhCqJoroeLDYmpiiIR0Pak+jApsRK9jdm
   HSXyxigrwApHEI2Eg8FhkmFnHX5TQlKtnK9PfMDkVPs/HoORT0d6Yoyab
   X7x0CTFx3dJXs/eh5mY4bWpwQ4jV5RMB6AyD36mq4PFgTe4rgPNTPSoEY
   g==;
X-CSE-ConnectionGUID: Cv3at3k1T4GFH7VaqO64nA==
X-CSE-MsgGUID: WxDncw8TRAGtrr+lXWtx5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58388779"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="58388779"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 14:00:24 -0700
X-CSE-ConnectionGUID: GaPoU2ApSFSsGXIFTO3j7Q==
X-CSE-MsgGUID: TeIEK3uuTeW53U0qIrUfQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157128402"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 14:00:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 14:00:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 14 Jul 2025 14:00:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 14:00:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzEdQErGNjnOU0f0wOqkPyjhzyKQj+k77FsOAa0Tuzxbv+alVr9NSopDIlWkkhwaxzW5jXB8MOkQKkzFeA/NCML9lvygkocpsPkLUmjLH+f+YhbAmIBITFqXJ1BJ3t9J5vY0vzDDZBKRdGd2AohceSrGvtNqLr0unhPBUgbBbV6mvkpqGa3RcwgdLrivt4s3GzWPlVdJtWOtbXH1/RBvHcbrRYozo4ogdBmSY6Ku+o/e5Bcxcnu1OoMCAKviKDSOWjy7KWzy31/0Cc7PhAPhnhOvbEBFfXTPSy+fC6JgUjhgPoKMv1qnCs5ebLWLwGUxGh0dPnVfPxaOSvwHCH7ybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmD4b3J3anBalh6qg6bWNr0QeLty4jrmIJKpWKWDNiU=;
 b=tf7i62NG2mE8XHvil8alzUPxb+N/bgB00dpypjEaMYc/7Oum40S7JH5hErvMsOsDHy8fDjrNXQkSibr46xHCaDIOP2LTkvfj9RydaMfOLWrN/sv3fCk1VuMYZ7yIvFDyvq6yrI9mPqPIpG0WExl6vr17AuL4UAJ5OEM85NB4tOc6H/khD75/PJZYif9nCpyVLHIyVRdAVA0G44urucQTAmBuVLf2S/srxvCFnHp+zdYiq4giaKz8Th+dR6hNbYNq8e8fQ5ewJe7HYu/Q+WNiM+5pHxyrEjvlH9gWN3FRzqIjWK5rReBU0jv47Wtbu/cOWIVg7O8h5UGmojt/EvwkwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8046.namprd11.prod.outlook.com (2603:10b6:806:2fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 20:59:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 20:59:50 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 14 Jul 2025 13:59:48 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Message-ID: <68756fc493b1b_2ead100b7@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250617152648.00006e28@huawei.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-12-dan.j.williams@intel.com>
 <20250617152648.00006e28@huawei.com>
Subject: Re: [PATCH v3 11/13] samples/devsec: Add sample IDE establishment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ddc889-1f59-4346-bb7c-08ddc3195fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTQwenE4QitPaHcrTHBkRWtXM3NMaVFlYkhQemhoMHBKcG41a3A2REZrUFl4?=
 =?utf-8?B?azhXQlRKdXAxN3JTUzNjaTVDcW1hSmFrVnJqa1RJOHgvL0tQWTBuL2pvWWU4?=
 =?utf-8?B?bmhEclZUK2RyT0I0ZnFNYjJTTmtTT3NqVkxkS1JEQlNHSUxvc2ZNMW1XZDA1?=
 =?utf-8?B?VVdjY2svS3R2U0gvblFoT1JXM25IU3Y5Sy85ZnBoL3pDOGI2TGtXUXIzWU1D?=
 =?utf-8?B?djlGYVNEUUtvc3Vxb3JIbGZXR2dwaFFuZS9jVWFGWGsxaW0ybzFMM0g2V1VB?=
 =?utf-8?B?N2pvZ2c1OC92cUpMeEk1T0FkTUVobTFQS09DaUVnYWJYWnl0bXY4dkNhVGpE?=
 =?utf-8?B?Wmh5RlZZWU14WjBsZVllWTUyeUZrTTBrYkFrS21lOUJLUENXNjNXaEdLTGt5?=
 =?utf-8?B?RUgyZWw3KzNkTHV2RGFuUmM5Y2xJRUhFeUp5bGNHUzg1UDhXYURGYmtMQ2Zw?=
 =?utf-8?B?SjhXNjF3MHNwOHV6VnN5TFhudFV2dHhOTHRubzVuc1h2Uk9RbHhTVml6T0Ny?=
 =?utf-8?B?NTNSaExhUGl1bjNTMXBhUGNLRlk5UkVQVGUvVW5HMXVyNmNneUhKbTVLcHlt?=
 =?utf-8?B?QUZyUVNJTjBIM3YxbldVR3o0WFcrdG9YN3ZGSXdxTEZoUGJzSnVHU3dZckxl?=
 =?utf-8?B?UzdockZmd0VsOUtESngrRTYvd0JRb3BtUi92ZHJrV2lsSnMyZmxlMk51bVo1?=
 =?utf-8?B?ZXpqUGlOamZNZG1aeFJvRC8yNjZYQ2puM1BwdnJRcEt4NnpqeWNEU1h0SlBE?=
 =?utf-8?B?NHpMM0FZU3RLYUxkU2svVFNsSGJNNkEzMWZ3a0dGWkMrWW1LOTJKUmxtaUI2?=
 =?utf-8?B?Y3AyT1RkRndVUzRycE54aHdJVWFnY3hBcHliQXhtcG1ac25hdDV0eVF2T1ZJ?=
 =?utf-8?B?ellMek9MNWQ5SWN1L293V05XUW5zUFNYaWEyN3ZuWktKQUhWRHhPRkl2Rk4v?=
 =?utf-8?B?aEZsMzZqNHVxVC94RmtScUdYaDRyVkJCMktpT2ExOHY0dDI3U1lXYmpvMXBm?=
 =?utf-8?B?VFY4dEdLZXNrVjNlNEdXZXN3akVmb011ZnBlZ0hCMDJ2UHZSaGZnZWhJUXF3?=
 =?utf-8?B?WFhBMlhtQzZmZTVKekh3OHg4aFNtSnFQajMrcFI4aWFEbEd1RTdqNktmUXNC?=
 =?utf-8?B?ZHdKTS9YdW1oRC95dU1Gek14Z0xvSVNwZnpHcDkzZzRpaVdjaUFzZmJub3RL?=
 =?utf-8?B?Vzlqc1IzdEU4Wk1zQ0NId2gwdmNFcTNzZk1Vakl4V1Fsc2prVkJnbDFOZkFZ?=
 =?utf-8?B?QWdGam1KeFRuZFB4SzMxOVRiRDluOEF0Mkt5dGxQZjlMdVFEVmVaSkZCV2Jk?=
 =?utf-8?B?bDRnSEx3ZzlTeERXeUk1OGJtZlpGeXRrSEZab3hvbWp3R1FFZGUxSXBTRmdK?=
 =?utf-8?B?am1xaXQ1dUxISThGSGtodjRVcStiRnFKWUJnNGhrc2dwSW00aGNsKzJXcldW?=
 =?utf-8?B?VW12dXpsM2pqYlYySGZlUzlFSm5BMUU5MmVsdkxMdU9OTFVLYnVVMU1aZTdy?=
 =?utf-8?B?VmNsSTZYaUx2RnY5UGdxdCtEbUZMV0RJa2x1RE4rMW5WQVV6RTRPM3NYcDR5?=
 =?utf-8?B?T0lRVlJlS2V1SS9rWURGSFJVZjJtU3hCajFTZVRnbzhSdUFKMkhGZGRGNzJk?=
 =?utf-8?B?bnpJaUVXVmw5eTF5Q0lqbHVCeUNNTzJtT0UyOU9qcnBSNnZLZFhLK0NMOTVy?=
 =?utf-8?B?K1ZFSDE4cmJMRlFwMndpRUp6YWE5bEtHelFxVWx3b3VBMEpaYTB4Zm9tRnU4?=
 =?utf-8?B?amE3dU85K2Eyd1dyZDJBL1BZU1hhc1UwWkhsMVFic3BzUFlzVGlLMG1wbEJB?=
 =?utf-8?B?M3BkYStMUmJya1B0UDRIdUpFaEhmWmluRkh2QkE4VE53MjFWdU0zLzh3alJv?=
 =?utf-8?B?VXBEZ0M3anM1dTRhYXdLeCt3V2Fia3RMTlVKd3ZrSFZGWkppRjgza25nQlA2?=
 =?utf-8?Q?NTqrcsgqgFk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzlwYnBXSC94cEN1UkpoRGhSdmQ4Q292Mjk1SWRPWUV2aTliNnR5T20wYXJR?=
 =?utf-8?B?cmUxdDN0d3NlZjhuVUg1UDNHWlhBOE9POFdxWExpVHB2cTdRRFF3dDg4a1Zw?=
 =?utf-8?B?RTJKa21Yckd0KzdEdWZuOFU3L2R2VUpZKzBhQWlrZHNULzZNYUpaQi9EelVt?=
 =?utf-8?B?VWhNODZyVDVuWjNlUHdZUVJ5VVBlRjFDeFQzMHB0S1l2a1E4RUtpRnRRNjBy?=
 =?utf-8?B?L1FVY0d5aHQyWnNjR2hoa09QWG9hNHplU3k4WFBqMTVFZUFkcE9XZTQzUzhs?=
 =?utf-8?B?aERQdWcvRHBRalVkL1Boak5ERWZydFVuSE85SDEwNWRCd3Y1OEJ4U0tVd1pH?=
 =?utf-8?B?VFAvMVlta1JnTEt1cnhSR1dpV2pYQitBV0QyOXh1OTFOaUQ0TnpWeXJBQmtH?=
 =?utf-8?B?RUNXQzNjVmE2TEUwZVhkL05Yd1VTemJyRkQxRnhsVnQvSzljNktHeHpjMUtX?=
 =?utf-8?B?TGU4T3FiK2F6dUtMZGxpVHlYRTdPSUxQWnViZmwxSTdyUVZVemcwQ2dyVFhK?=
 =?utf-8?B?U3E2bm9LT2ZQN0tTWVBneXRjUFB6cVQrMEVURXVjUi9vM2FLaHJqWjk4N1Ra?=
 =?utf-8?B?c0tqS1BiRkpKZmpZWlc3RlgyUktHTTZqQ1gzZm9XVzliYmJ1TWQvVzhBa1Ro?=
 =?utf-8?B?T3F2dTVCU0QzaW9EREJ6MG5PT2p6QmcxM29LdExQZFkvUlpabE1ROHdmYmo1?=
 =?utf-8?B?c3ZqenFDMkFYWHBsQVNlcDNyQnNmTHJGRFpjOHZMdTlWekFIMko1RGY0enJo?=
 =?utf-8?B?NW1hb1krL2NPUks5d04zUXJmNmtReGdSUkxuRjA1SGFlbWJZYm9wKzRwTzBV?=
 =?utf-8?B?MVVSLzllUXl1SEtCL0NEQVl5eExmZXFtVHM5cTVrTTU0eGFJRmhlSks3MldQ?=
 =?utf-8?B?N09pTUJMWWMxQmd1dU1Zb3NDRVNyN0Z4cnA0ajRBckUyNHgvL3JFZmZ5cDM3?=
 =?utf-8?B?QVlNdVc5a2JWYkFkR3grZFBpSmQ3aHFlMjdyUG9nTlUyZGFab05scjNaUys2?=
 =?utf-8?B?bm56YW5iUytIVkdTV3dCSXFtTDlEQVdHWDVRN3ZRSVdTNVhTQ0VHeTFmNWdt?=
 =?utf-8?B?a283YlVwWE55RnVVTnNwblV2QXIrWU5CVElPNjlublBMSHMzTDlGazVIWFhX?=
 =?utf-8?B?eWtlT2Yxakw2NUZxNjRMRUZoUmdheGpJa3oxM1VjT3ZVWFFFb3pwVXVRQXpL?=
 =?utf-8?B?M2pTUVhKVjYwdU9UNWJ1UFdEKzNuYlhvaGZyU2dCS1BtVEFNc0s3S1ROeE82?=
 =?utf-8?B?UHV4SHZzWTJxcll1NGZxaGtLOE05cHFGK0lDWFgveHVOSjVaK05vbkkxd0pJ?=
 =?utf-8?B?R0tPSEFNSWcwWm1VSXRXNlBMUU1iUzBJT0ZacldnSzFhNFB0OGRGVkN1L0ZJ?=
 =?utf-8?B?QkZoanEydDYxS21FU3FRT3BmWk96M1NZZDgwSjdISEJWOEFBQWxwR1NMNkJ0?=
 =?utf-8?B?Mjg0TGxTcXhzUVJFd3ZJWEFaODk5Sm1NZGlUcmRDcU1ITnlvQVJZVXl4djBM?=
 =?utf-8?B?aXhuNTNhL2k3S3gzck5OdkZWc01idk5UN2FKZ0xvOW5Gd1ZPU0Jqc0xXUVRB?=
 =?utf-8?B?ZzNiTUNNd1lCTk4xMEdjR3Z3SEVFVkE1UXZ6MHdmQXBzQmhYMEZpZ0E5dGlF?=
 =?utf-8?B?QTlZelBDS2o1RFR5WSthdlpiRExOZ3d6TjRmQnhTVUVFS3RnbC9xT1UwSXJp?=
 =?utf-8?B?Ymt1UlduSTR2MDBuenF2azRmRExlalplSlBmRzZESmlQaFpDeVBQT2ZJSEFu?=
 =?utf-8?B?Ly9LTkdqQnMwcTdkZ1QrOG9QZFZER1hvN3NsV1g5alFZTTZVZCt3M3VVeGQx?=
 =?utf-8?B?S2NqZ0JtU0RuaXNGNjFIVlpiK1NPd1hmT0JZempQUWpBcjBZdENpVzdYTWFJ?=
 =?utf-8?B?VGJuUS9Ld1BwZWpVcFlxVXZFOUc0V2hxdnpMeERCZEtjaUdvSlFGYlcwbm5m?=
 =?utf-8?B?U3RKSHFsbHpXUytBeGtsVUltaG5wVWJMRk8xODFhdDFHSnp0ZUc1T0pycXFY?=
 =?utf-8?B?RjhtbVlWTGdPN2ZXcDMrYU1BMjNaR1FNK3RXWVF6N2paRWZ5ampWTFQ5OEVX?=
 =?utf-8?B?SVJDYzg1MmhITnFQS3JNWWlZSXhrczI0TUZTTWZyQVgyOUc0TG1nZ1pSaG80?=
 =?utf-8?B?Skdxd3h6UjBqdHFTQkk2WmhYR01Xc3hUVHlTdDFNSGRFb3hZbGVoV3BYckNa?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ddc889-1f59-4346-bb7c-08ddc3195fab
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 20:59:50.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlGqMkUt5BVXe6URKo2prblMH8B2sTiwd/o3wALDzCvx4LYIAvvvfz6GZYUWlPtx25v9SfLlDm7zQlY+lNgypEgM/5jVyC3sb5PxRdRxBdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8046
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 15 May 2025 22:47:30 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Exercise common setup and teardown flows for a sample platform TSM
> > driver that implements the TSM 'connect' and 'disconnect' flows.
> > 
> > This is both a template for platform specific implementations and a
> > simple integration test for the PCI core infrastructure + ABI.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Cc: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Trivial comment inline.
> 
> > index 7a8d33dc54c6..aa852ac1c16d 100644
> > --- a/samples/devsec/tsm.c
> > +++ b/samples/devsec/tsm.c
> 
> >  /*
> >   * Reference consumer for a TSM driver "connect" operation callback. The
> >   * low-level TSM driver understands details about the platform the PCI
> > @@ -74,11 +79,81 @@ static void devsec_tsm_pci_remove(struct pci_tsm *tsm)
> >   */
> >  static int devsec_tsm_connect(struct pci_dev *pdev)
> >  {
> > -	return -ENXIO;
> > +	struct pci_dev *rp = pcie_find_root_port(pdev);
> > +	struct pci_ide *ide;
> > +	int rc, stream_id;
> > +
> > +	stream_id =
> > +		find_first_zero_bit(devsec_stream_ids, NR_TSM_STREAMS);
> 
> Ugly and it's under 80 chars on one line.

Just a missed clang-format, fixed.

> 
> 
> > +	if (stream_id == NR_TSM_STREAMS)
> > +		return -EBUSY;
> 
> >  
> >  static void devsec_tsm_disconnect(struct pci_dev *pdev)
> >  {
> > +	struct pci_dev *rp = pcie_find_root_port(pdev);
> > +	struct pci_ide *ide;
> > +	int i;
> > +
> > +	for_each_set_bit(i, devsec_stream_ids, NR_TSM_STREAMS)
> > +		if (devsec_streams[i]->pdev == pdev)
> > +			break;
> > +
> > +	if (i >= NR_TSM_STREAMS)
> == NR_TSM_STREAMS 
> not that it really matters but it can never be greater.

I does not matter in practice but if the valid values are "< size" then
the invalid values are ">= size".

