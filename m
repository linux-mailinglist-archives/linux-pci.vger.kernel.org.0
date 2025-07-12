Return-Path: <linux-pci+bounces-32004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6F3B02D69
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 00:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCF74A4574
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 22:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD51822DF85;
	Sat, 12 Jul 2025 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jk739ZjH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7F322D7A7
	for <linux-pci@vger.kernel.org>; Sat, 12 Jul 2025 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752358055; cv=fail; b=LHrPG0vy93AayIt/RIAX6fo8O1Vf4/EQTRFVz0NEW35qa5nNTa3sJYIB+mwRRv33H6KjyHbjqicQNwGjr2dtXyuwv/rt/Ie2kHc+jzJUau46aaUzEevX5GyPqCZYuome6w7NdGxrJESAbmMlSOueLnYLnRSAKaw+XaA2S2jlhaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752358055; c=relaxed/simple;
	bh=nlNmjQ1ZfcVHBcF6RJ8IQeN1vWb0t9zVFdhyDx+EsNA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=u1aGixbMOPWY+O8pjZomOl+QjRneO9OY3+YJz7gKoY+Woe++nCRGUqA54ZXMd2soMFlHvEWsRR+Wak7xDaOr7REJqs+lX513q4nSukUK/UDvVm03KKMyF7seNE0AOWKPzfIrui2ek9PGzxM/AjYx5kSBgulmFSDsiLGlxGXxb+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jk739ZjH; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752358054; x=1783894054;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=nlNmjQ1ZfcVHBcF6RJ8IQeN1vWb0t9zVFdhyDx+EsNA=;
  b=jk739ZjHK6Yf6jgILZsm2mPlL5z6D7b89sR6mZmnM4N5oc5TU9iR4OuU
   hFzKBVPha3aL56Lhbfs+QeorwG0zPkuj+FwQwXZRaYRhl6tnI6P2Hmmml
   zGbjnvsxaXDDMoLJ4UCWcW8H8PpvSDuLdJWwlu36briv38zcCBUI1dmKA
   d7RY7t3sDeOxMtkZdu26aQIXER2JDAOJCS748IK88IuD7xNXbryI4zaao
   YI3OszRc/M0ak+9qNNfv+DkM6itdqxbEeiJ1UmZkReKWISmT2wZdDqtfr
   qhGYP4kJBxCmlYldR9NUhaKQNU86ZLVortMnLfqU9pR2Gh6iKktnwWvNl
   A==;
X-CSE-ConnectionGUID: 9BZh7HCkSZOv3zaq0B+aBQ==
X-CSE-MsgGUID: p6f7rwUgQIKrwbCIrUJWgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66053465"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="66053465"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 15:07:33 -0700
X-CSE-ConnectionGUID: fWHik764ToaaVe9kHTXisg==
X-CSE-MsgGUID: Y+onwmCNTzS0I4H9M/f54g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="157353392"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 15:07:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 12 Jul 2025 15:07:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sat, 12 Jul 2025 15:07:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.88) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 12 Jul 2025 15:07:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQLzJj1m8e4sPXJIMJVTxEQ45HCE6jw17aiB7mpMZw30WgqhKYPc3NKknRlaVgXLfafbt/jCBYBAwOhfMHwvUV/PzHIlg+yVNbgJH6UoCdngbXNwi7ey3ZYbGC6zL2ctbQDRM+J+xR/1w2s0lFYNW/05dEUMNjVLIragAENa7o9RWT8gPEPLZNLmtnoq6vExPXaN+BWkIxY2oI0PowLPixqDJRZk6NvoSKutrKATJSyyumY+AY5Zj1aLE+qb0H4AJi7LdfAjBWnbxWfn3bw3jw6gWc8jdilHuJhaQaIRlSHmUon5viY7ml1a40BRYOylzF1Vz/c9KpEUW1zAyH8SXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqCJ+a+CVBoxdf8M0+lSAcxKvAPbUsNq3ZJUcmsY3Ys=;
 b=XW41Vs+EtoUF2/SF+hVv8TVPmr876Na2nV+idyb4JnCTjfTWnMUlE/8B9EPVVjP/nfefpsLi6VBqLf4cYY8rmKoXS7vYPJYHFt/rgbxda9PJ0q0u7YC/ALocF66IvgOpcKQeOi5F0Ushr/tTzsSPKxn2wGXFXZ13RkycE1o2h79Hqjd2laW7246qnhoSy9kyNfn+86d53w9J1jWMZbAbpozVss6Nmyp8rAYvgQ9a4qSSmGFkuOqLEENKhZwGFD9Y/+oaW8Km2RWdCLpRymKdHmp70+IlfOAAi2vLiA9xTdLMEL98j011MwCdTou/Fir6shKHj/8cYki34DhBVfHoPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8201.namprd11.prod.outlook.com (2603:10b6:8:18a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Sat, 12 Jul
 2025 22:07:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Sat, 12 Jul 2025
 22:07:29 +0000
From: <dan.j.williams@intel.com>
Date: Sat, 12 Jul 2025 15:07:27 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Message-ID: <6872dc9fdd76_11344100fb@dwillia2-mobl4.notmuch>
In-Reply-To: <20250617135145.0000376b@huawei.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
 <20250617135145.0000376b@huawei.com>
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b626080-3d8d-4766-de61-08ddc1907da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnNMa09hcWRwN2l4dU45VnJ6N3dZUWk1dGdrRkpJWWJkdjJaWW9USzNkdEtn?=
 =?utf-8?B?djQ4UHMydHNsTW0zYjUyMmtPUkhuVE1NU1lLS2tpUklycTZEQTM2ekxoWXdm?=
 =?utf-8?B?WXpDZVRTZG5KejR0dzBpaTNkMEhVQ1dYTEgyam84Y2hWMmxsUHJlUVY3TVhL?=
 =?utf-8?B?SGh4a0hVbHlDNzIvMHdtTjNZV0Q3VVpkYUJaUmlvcG9jQmxIN0RlNDRJWG5S?=
 =?utf-8?B?MldiQm12akpmdW44UDM2R3BPbytjQUZuMUkvL2l1dWlkTGc5MTkwbWhGNW1D?=
 =?utf-8?B?ZGhPUDVOTHM5RkVkYmJKZ1NoazFlb21VWTdFY0pib1BIamJUUnlXdm95SDI5?=
 =?utf-8?B?NHVkT2tXalZic0dXaTlnZ21WTHpadGh2T1VIL2hHbG1xZlJlYU1LdDk4VXBK?=
 =?utf-8?B?TnVmazlVbWd6aXVUM3U4NkQ5cW43WWY5cEJpblY5Z2p6WU5MMThMRDdJUkFs?=
 =?utf-8?B?dmtlbTE2c2FDK2JDWDZaZGpCdFcwYm5hZzRmU1Z4SVdQb1d5SEIvSy9CbnpH?=
 =?utf-8?B?Y1pqZjc4NHNoTFFTSjlwSkdUMTlCeXBHSHNWVXZ0NVYvRm1GS28wSGVPb2tY?=
 =?utf-8?B?L2pVU09lMHlkQ1Y4dmxraDNjQmdTUHpsM0hYZWFHYy9qQmZFVkw4RFl1Nkk0?=
 =?utf-8?B?aU51aisxNnpsZk1zVXhrNVVoaTAzUnZSbnJNUW9KL09WZ3lkUVduMnl0ejFo?=
 =?utf-8?B?OVZOSkdiSHhOUlNkdHZEN0hNTFpEODhTVVhxTnh6T0NSaXk0UitMRUlFdmht?=
 =?utf-8?B?NkJzTHRFZzVQUyswOVpmbFN0VVN6Zk5ZR2NJRjRpMWQ1Uk9xaHFiK1FJMEZZ?=
 =?utf-8?B?TVRiampwTktxZU9XSjFPNjBZd2IxNXZPeFZCQyt2eHdFUXNGQ0JQaks1cVhx?=
 =?utf-8?B?TWhDV1VEU2pIN0c2YTh2QlF2eWE3M2M1RXpWRCtWL2NLcWNwUlN0L1lFVmRz?=
 =?utf-8?B?OTZ3RWgvUXFiZEc2empERyt3SDRQZFdseHViOG5DNTB1UEJmRjhaSkQ3NTdi?=
 =?utf-8?B?L0VVaGN4TjhQSnNQVmt4bysxcmlqNkl3NDVLTmpwN2E2RTM3V3lqeXh0OGFI?=
 =?utf-8?B?ZmVzK0xNMWJZejhnOVlRdlEwaVpUMlF5Slk2Y2xsZjdnd1h2NlVRWFFsREVa?=
 =?utf-8?B?M1F6ZncwcCt4ZmRiRTVmZ1dUZXFBOVdEdHUrSEVxa2l4QTIwUStEbnZpbDdV?=
 =?utf-8?B?cTJwQ1VkQ0c2OGRjc2FUK0c3aDNCUUl4R2VnOC9aSDYrd0ZrdmZGRVJHbjVK?=
 =?utf-8?B?NVVLanhuNzBjS3pKREZpNDlNMXY3cnpQVGpwNGZ4alZySVM3MGFOSlVQNk9F?=
 =?utf-8?B?MVgrTFZlS01ZU3hUZ3Q4M3VWNGwraVZ1RXRQREtLcjl3K1U1ZFZmMyttNXZl?=
 =?utf-8?B?YXkrenEycExGRldwcm5UVzBQY2lrWjBTajdYNHdaVm9WOWFlcmk3bWg3aVFx?=
 =?utf-8?B?b0N2bkVvcDArdi9BU0hZZTBNQjAySkp3a0h1cHRaYU9mQUZoMWRnSkFKTEtM?=
 =?utf-8?B?T0VnMHpKOTI4dEdBajNxWFZKUmhEbFdhRWpldmJGQmwyNUNvbmJNdGVEVnI5?=
 =?utf-8?B?RHliakkxL3pWZEN1K2xzdjBTSlYxY0lqNkgraERLKzFTTURqSTY2ek9RcnU2?=
 =?utf-8?B?OUQyTkx0cXl0bVUrOEJ0UWxMWE10KzJzbGR0NnhpWkMzVmpETW1Sakh3SmIz?=
 =?utf-8?B?QlUwMVlrNTNwaVNZVjI2enV5WG5IeHdqbUREVDd6a291N254VjMvcWoySzB5?=
 =?utf-8?B?NEdaSm5PVHZiVmJ2U3Q3YXhzaUsrcFJrYlo1NFJIa1IrNzI4cGVlTEpNMkdG?=
 =?utf-8?B?VWJtcGt0bEZ4aHJoaGpiYkJhVTdNa3M0MHBkMjdNOG0xNHY1anhQQXphQ25u?=
 =?utf-8?B?OXhHTEtrc0hxenlIWnhBNjE4ZTNRSFlwR2FJNUttcnlNNGdpT3hvZDFXamJs?=
 =?utf-8?Q?lfwZymbSaMI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amIvNDRTQTZETE44dWMwaUx0NllZT01QUzBhWWoyNVdVb0xpcit5dHR3NzVY?=
 =?utf-8?B?SnB3UUpEVW5MaENGNU80bjVkeHYxS0w5Rnl6K2gzME5sSlY1VzhlY0QyMXhC?=
 =?utf-8?B?MHdnN2NVemh0M3VpWGxVVXE0aXVvSmVocmRLMVFNcUZYYTBBUnRGMGZlTFEv?=
 =?utf-8?B?QjR2M2VDcktyVjRpQUJlWDJURTFBaUFGRTRFb2R5QW5QMTFCNDQ3c2MrTHZu?=
 =?utf-8?B?V3FFdk5OSlVoUnBvZ0tHekg1RXVWYkJYMVVBdDhXRk9VV2hFTDQ5S1NKREt5?=
 =?utf-8?B?TFRzNTJpMnlOeTIra3FkMFoxdU52cnNYd2pPTkFpSnIzUVVrRzQ0TkxOdU9X?=
 =?utf-8?B?NW16Z05DVFNKU1pxZ2x1YjVhTi9jQlFiakJFbEcwYitzOU13Wnk3MXhwT25w?=
 =?utf-8?B?UmlScU5zT3praFo3c0RrYjlmSnJvSEc0Qkd3RERtSDRkdG9wOCtNYUlCbE9z?=
 =?utf-8?B?Ujl5ZDd3S0RjSll0SWVCMnZKaXpkVVRXdjhoSzYxZVlQZ1R6UVplWHpaVVp6?=
 =?utf-8?B?OVpqalVQdmczS2hWMVdqNHl6M2NGTmNlTnpmbXo3eFYvVU81SjRCa3hVVStV?=
 =?utf-8?B?UTEyaGRwN3ZuUFk3d2cwSmgvUlN6MnlmRnYxZisrVFVXbnZNeGZtTXkwMURm?=
 =?utf-8?B?RXJzWEc0WE1lUVJnaU5zY3ZlMjh6eHZMZm1uTjliRndQbTE0VkFycEFvdTVy?=
 =?utf-8?B?Wlg3VDFXakFOTUZBNFVET1ZEQmx0M2I5QnVDcldkVyt4dUNBZmVmVXBOSjJT?=
 =?utf-8?B?eDdydWJZZy9OaDN1a0lCdDZBMlp1NS93M0gyTkhETW5MWVF1cjUyNXFySkxo?=
 =?utf-8?B?M0cyOWxrOGFGeDlSY3FGbmk3djM2dGlTS3cxK24zSDQySzU3NmRNM2phbThM?=
 =?utf-8?B?YjNlUnRkRkZ2RDN2T21jRllYMWV6SlhmYTNORkdUbWRjVGdFdHoxeWpjRnZk?=
 =?utf-8?B?aGx4QXpEQ1dyeVVZRGRPUjN4MnhtUDhUTDhtRjhnc25FUEk2TE9yRGdzUXA2?=
 =?utf-8?B?WEVWbzFjVTlOSFpDZmNVLzhXVitBZ0RycThTNk1VWk45UlM5VC9uMmFSTWdh?=
 =?utf-8?B?dXRMMTYrblFob1h3SndqY3RnVEdyWklSeFlLN1lZbGFLeWhkUGprMTI2QkdN?=
 =?utf-8?B?ZzN6MGNiREZ1WTRpaG80R2lNZEpuUVNTZVM5WUQ4NmtwdExFTEFjbWM1NjRy?=
 =?utf-8?B?VVUrZWpYSndETGFnalBWTkkvMHVJNGpxVGtKWjBMbXkvd3ZOVkhnN0t5WERo?=
 =?utf-8?B?UE02TW1rcDBUcEtVbGFMdUtPeUtENTJGZXMySXlsRUJNSXMxem5idnErTGlM?=
 =?utf-8?B?alAzdk1VRzBUS1k0UGdEQnJtUzYyUVlwNW1SajJWck5YTFZyNW5QL293Uzd6?=
 =?utf-8?B?YXVzejloeGN0RU02OTk2b1A4TnRjVjUwdTQ4WVZMVGVBcW1kQVcxWUJLOENP?=
 =?utf-8?B?TWYxVCt3a3ZtUFE1S2lvNUJhcHR2cEFvZGUwNWVWK2YxakF0L3NScG1FUkFL?=
 =?utf-8?B?aHN0YW4rZmxhdm1FaU1pRkVldHp4Y0MwNnE3QlIyWjJZYjZPaGoyZi9hT3pJ?=
 =?utf-8?B?Sm0vQmtjVjJRbiszYkoydm1DM3FWdTByWm5pY0JIQjNkNU5iTW5OM0tXSHJS?=
 =?utf-8?B?T2J2OVhFMDRxdkRxdFord2dvUnRMQXBRdzJJU2pyWmcxQ0NzOEc5RWhHYk1O?=
 =?utf-8?B?QzVlNTl6WkRsK1duM1crVkh0WWZLeGhHbHU5YmZGWW1pZ3psalNVSjE2eW5m?=
 =?utf-8?B?NFFoMEhWV2NzOUtYZTc4cklOMXVUeWd4aUVtWERabXNzN0kvbWpabVlNTlB5?=
 =?utf-8?B?ZTNYN1l3cXZ2UW1jeE1CblBiYjZyU3BCT0I1VWh4RVJHbEtxa1dMcEk3NUlY?=
 =?utf-8?B?dXE2Z0I5WjVTSXFsUUZUOEMzbTRPQ2Z0a3pBVnhGcTlQOWVuTzJ1c2xTSkVi?=
 =?utf-8?B?dSs4SzlJUThOZlFPVCtHZWpsVW5IUG5aNmVwalE3MytpWDIrSXRXWStiTnU3?=
 =?utf-8?B?bExEeDQwb3ZFeFZ4dUZrV3VTdk9UVWRqTDY5WGd2UVlQZDFtUE54dm1SamNh?=
 =?utf-8?B?R0dEWkVrZmhPbWJLaDQvVnV3S0RFRXVsSXR5RVhsby9qRGxGbm5JVllzZCt4?=
 =?utf-8?B?QWdBK3p4enBNSGkwdE50ZkppOGMrb3NFdDFCQ0VrZ00yVGhqYW5pUDJmWm5v?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b626080-3d8d-4766-de61-08ddc1907da3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 22:07:28.9603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShpMm3ji6P2pR1v7FOJni27QFS5Z5gLboB76oBhPC0dV1ki9AhUaMzhWvQXnzHqPaS3t5W+fob6S2ejud08lacoN3OXJ+gQtnqkyK1vkszQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8201
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 15 May 2025 22:47:22 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> > Environment (TEE) Device Interface Security Protocol (TDISP).  This
> > protocol definition builds upon Component Measurement and Authentication
> > (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> > assigning devices (PCI physical or virtual function) to a confidential
> > VM such that the assigned device is enabled to access guest private
> > memory protected by technologies like Intel TDX, AMD SEV-SNP, RISCV
> > COVE, or ARM CCA.
> > 
> > The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> > of an agent that mediates between a "DSM" (Device Security Manager) and
> > system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> > to setup link security and assign devices. A confidential VM uses TSM
> > ABIs to transition an assigned device into the TDISP "RUN" state and
> > validate its configuration. From a Linux perspective the TSM abstracts
> > many of the details of TDISP, IDE, and CMA. Some of those details leak
> > through at times, but for the most part TDISP is an internal
> > implementation detail of the TSM.
> > 
> > CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> > to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
> > Userspace can watch for the arrival of the "TSM" core device,
> > /sys/class/tsm/tsm0/uevent, to know when the PCI core has initialized
> > TSM services.
> > 
> > The common verbs that the low-level TSM drivers implement are defined by
> > 'struct pci_tsm_ops'. For now only 'connect' and 'disconnect' are
> > defined for secure session and IDE establishment. The 'probe' and
> > 'remove' operations setup per-device context objects starting with
> > 'struct pci_tsm_pf0', the device Physical Function 0 that mediates
> > communication to the device's Security Manager (DSM).
> > 
> > The locking allows for multiple devices to be executing commands
> > simultaneously, one outstanding command per-device and an rwsem
> > synchronizes the implementation relative to TSM
> > registration/unregistration events.
> > 
> > Thanks to Wu Hao for his work on an early draft of this support.
> > 
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Cc: Alexey Kardashevskiy <aik@amd.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Trivial stuff on this one. See inline.
> 
> Jonathan
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci |  45 +++
> >  MAINTAINERS                             |   2 +
> >  drivers/pci/Kconfig                     |  14 +
> >  drivers/pci/Makefile                    |   1 +
> >  drivers/pci/pci-sysfs.c                 |   4 +
> >  drivers/pci/pci.h                       |  10 +
> >  drivers/pci/probe.c                     |   1 +
> >  drivers/pci/remove.c                    |   3 +
> >  drivers/pci/tsm.c                       | 437 ++++++++++++++++++++++++
> >  drivers/virt/coco/host/tsm-core.c       |  19 +-
> >  include/linux/pci-tsm.h                 | 138 ++++++++
> >  include/linux/pci.h                     |   3 +
> >  include/linux/tsm.h                     |   4 +-
> >  include/uapi/linux/pci_regs.h           |   1 +
> >  14 files changed, 679 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/pci/tsm.c
> >  create mode 100644 include/linux/pci-tsm.h
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index 69f952fffec7..1d38e0d3a6be 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -612,3 +612,48 @@ Description:
> >  
> >  		  # ls doe_features
> >  		  0001:01        0001:02        doe_discovery
> > +
> > +What:		/sys/bus/pci/devices/.../tsm/
> > +Date:		July 2024
> 
> Guess the date for merge?

No, date authored / created, but the Date: tag in these ABI entries is
not generally useful, just going to drop it.

> > +Contact:	linux-coco@lists.linux.dev
> > +Description:
> 
> > diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> > new file mode 100644
> > index 000000000000..d00a8e471340
> > --- /dev/null
> > +++ b/drivers/pci/tsm.c
> > @@ -0,0 +1,437 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * TEE Security Manager for the TEE Device Interface Security Protocol
> > + * (TDISP, PCIe r6.1 sec 11)
> > + *
> > + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> > + */
> > +
> > +#define dev_fmt(fmt) "TSM: " fmt
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/xarray.h>
> 
> Not seeing an xa stuff yet.
> Check the others are all needed or push them forwards to appropriate patch.
> 
> > +#include <linux/sysfs.h>
> > +
> > +#include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> > +#include <linux/pci-tsm.h>
> > +#include "pci.h"
> 
> 
> > +static bool pci_tsm_pf0_group_visible(struct kobject *kobj)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +	if (pdev->tsm && is_pci_tsm_pf0(pdev))
> > +		return true;
> > +	return false;
> 
> Unless this is going to get more complex later
> 
> 	return pdev->tsm && is_pci_tsm_pf0(pdev);

One line works for me.

> 
> > +}
> > +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_pf0);
> 
> > +
> > +const struct attribute_group pci_tsm_auth_attr_group = {
> > +	.attrs = pci_tsm_auth_attrs,
> > +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
> > +};
> 
> 
> > +static void pci_tsm_pf0_init(struct pci_dev *pdev)
> > +{
> > +	bool tee_cap;
> > +
> > +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> 
> Might as well put that on first line.

Done.

> 
> > +
> > +	if (!(pdev->ide_cap || tee_cap))
> > +		return;
> 
> 
> 
> 
> > diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
> > index 4f64af1a8967..51146f226a64 100644
> > --- a/drivers/virt/coco/host/tsm-core.c
> > +++ b/drivers/virt/coco/host/tsm-core.c
> > @@ -8,11 +8,13 @@
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> >  #include <linux/cleanup.h>
> > +#include <linux/pci-tsm.h>
> >  
> >  static DECLARE_RWSEM(tsm_core_rwsem);
> >  static struct class *tsm_class;
> >  static struct tsm_core_dev {
> >  	struct device dev;
> > +	const struct pci_tsm_ops *pci_ops;
> >  } *tsm_core;
> >  
> >  static struct tsm_core_dev *
> > @@ -39,7 +41,8 @@ static void put_tsm_core(struct tsm_core_dev *core)
> >  DEFINE_FREE(put_tsm_core, struct tsm_core_dev *,
> >  	    if (!IS_ERR_OR_NULL(_T)) put_tsm_core(_T))
> >  struct tsm_core_dev *tsm_register(struct device *parent,
> > -				  const struct attribute_group **groups)
> > +				  const struct attribute_group **groups,
> > +				  const struct pci_tsm_ops *pci_ops)
> >  {
> >  	struct device *dev;
> >  	int rc;
> > @@ -61,10 +64,20 @@ struct tsm_core_dev *tsm_register(struct device *parent,
> >  	if (rc)
> >  		return ERR_PTR(rc);
> >  
> > +	rc = pci_tsm_core_register(pci_ops, NULL);
> > +	if (rc) {
> > +		dev_err(parent, "PCI initialization failure: %pe\n",
> > +			ERR_PTR(rc));
> > +		return ERR_PTR(rc);
> > +	}
> > +
> >  	rc = device_add(dev);
> > -	if (rc)
> > +	if (rc) {
> > +		pci_tsm_core_unregister(pci_ops);
> >  		return ERR_PTR(rc);
> > +	}
> >  
> > +	core->pci_ops = pci_ops;
> >  	tsm_core = no_free_ptr(core);
> >  
> >  	return tsm_core;
> > @@ -79,7 +92,9 @@ void tsm_unregister(struct tsm_core_dev *core)
> >  		return;
> >  	}
> >  
> > +	pci_tsm_core_unregister(core->pci_ops);
> >  	device_unregister(&core->dev);
> 
> Using device_initialize() and device_add() in probe but device_unregister()
> in remove results in trivial ordering mess like this.  I'd split the
> remove() path so we can take down in the reverse of setup with pci_tsm_core_unregister()
> between device_del() and put_device()

Turns out in the new version I came to the same conclusion.

> This ordering thing is common enough though that maybe we can just 
> not worry about it.
> 
> > +
> 
> Push whitespace change back to earlier patch.

Lost that whitespace along the way...

> 
> >  	tsm_core = NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(tsm_unregister);
> > diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> > new file mode 100644
> > index 000000000000..00fdae087069
> > --- /dev/null
> > +++ b/include/linux/pci-tsm.h
> > @@ -0,0 +1,138 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __PCI_TSM_H
> > +#define __PCI_TSM_H
> > +#include <linux/mutex.h>
> > +#include <linux/pci.h>
> > +
> > +struct pci_dev;
> 
> Given you have linux/pci.h no need for the forwards def.

Ack.

> 
> 
> > +
> > +enum pci_tsm_state {
> > +	PCI_TSM_ERR = -1,
> > +	PCI_TSM_INIT,
> > +	PCI_TSM_CONNECT,
> > +};
> > +
> > +/**
> > + * enum pci_tsm_type - 'struct pci_tsm' object types
> 
> Kernel-doc should warn on incomplete docs.  I'd add trivial comment for
> INVALID to avoid that.

pci_tsm_type is gone in the new version per Aneesh's insight that it can
be derived from other data in the pci_tsm context.

> > + * @PCI_TSM_PF0: function0 that hosts a DOE mailbox that comprehends an
> > + *		 Interface ID per potential TDI
> > + * @PCI_TSM_VIRTFN: physfn-0 of this device is "tsm_pf0"
> > + * @PCI_TSM_MFD: function0 of this device is  "tsm_pf0"
> 
> Double space after "is" seems odd.
> 
> > + * @PCI_TSM_DOWNSTREAM: immediate Upstream Port of this device is "tsm_pf0"
> > + */
> > +enum pci_tsm_type {
> > +	PCI_TSM_INVALID,
> > +	PCI_TSM_PF0,
> > +	PCI_TSM_VIRTFN,
> > +	PCI_TSM_MFD,
> > +	PCI_TSM_DOWNSTREAM,
> > +};
> > +
> > +/**
> > + * struct pci_tsm - Core TSM context for a given PCIe endpoint
> > + * @pdev: indicates the type of pci_tsm object
> 
> How does a pci_dev indicate a type?  Maybe: Used to distinguish the type of pci_tsm object.

Changed to:

 @pdev: Back ref to device function, distinguishes type of pci_tsm context. 

>   
> > + * @type: pci_tsm object type to disambiguate PCI_TSM_DOWNSTREAM and PCI_TSM_PF0
> > + *
> > + * This structure is wrapped by a low level TSM driver and returned by
> > + * tsm_ops.probe(), it is freed by tsm_ops.remove(). Depending on
> > + * whether @pdev is physical function 0, another physical function, or a
> > + * virtual function determines the pci_tsm object type. E.g. see 'struct
> > + * pci_tsm_pf0'.
> > + */
> > +struct pci_tsm {
> > +	struct pci_dev *pdev;
> > +	enum pci_tsm_type type;
> > +};
> > +
> > +/**
> > + * struct pci_tsm_pf0 - Physical Function 0 TDISP context
> 
> Missing tsm and kernel-doc warns if docs are complete.

Went ahead and added a simple Documentation/drivers-api/pci/tsm.rst that
includes pci-tsm.h and tsm.c. Yes, this warning was still there in the
latest version.

