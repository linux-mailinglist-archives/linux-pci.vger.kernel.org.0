Return-Path: <linux-pci+bounces-39878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BABFFC22CC4
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 01:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175C21A6387B
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 00:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B9E1B394F;
	Fri, 31 Oct 2025 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3Nois+w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC761C8631
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 00:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761870859; cv=fail; b=WYtnjmydAmJXMsBUrWI7zpImlf9WNZ3wHbtlACJXbmWwBXZzUT5HKV4k8JlpL6+Cjp6mKrI0qbFWne0UxY9+PIyAZULjvNtqwd0DuJjCxGWKS2UmvZpS8zD4Ze18jHUxqDK56fxxVe4WOkX6KOctp+w7xrH+T0wA6KLK2EMbvb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761870859; c=relaxed/simple;
	bh=JaMxYDdHnkZjB6gD5EOHIfVh3N3qlOzV/ZtD+xa8/EY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=jsYUDXIZ1xI+Q7hO5Xgy+u0uCMU31nZ0JEhOIVjvlD36h39gBOD8AhhTc0/skcNZk6LPfn4SHYS2sUR6BmHxZUvMl1XFyh9OKb20xyJoqrkPXrLa8wNLOgGJm1fxbMPedjOIzr9ItYysI/JOD4TeZsKUtYvnzYqnagCZZ1a+OPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3Nois+w; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761870858; x=1793406858;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=JaMxYDdHnkZjB6gD5EOHIfVh3N3qlOzV/ZtD+xa8/EY=;
  b=H3Nois+wfy4kS7itKjNgCfHElWjB1KV8/6R7ZMlbb0FmpEQKH9pITdqV
   rohGbhdPfhJV/t5fKFVaAJTLJoGsSG4hYCnlSEbNjnE/qjgqrmdseaJmA
   ZXCCEW/vyDgJH5pd81E1dshzvEX8Jnhzda9/+W/UxAyhSry3f7s3xHMIZ
   v9ibY7eyNBQbQKYc3FUsJWokDRFITBylMw/1DiL4Iz94PomAhuWT7J4LG
   MBbEQH7Tp0d0/ujDWH+0LxNDYL4AH5Nd1IY1+GxnqdLvceMnrxu3RwkW8
   4/J+9v0u2sVIb7B35OfiHN88HneWlodNYoUBBDZhA3rUal17TqZI+NniZ
   A==;
X-CSE-ConnectionGUID: VNgBRoD9RtiwvL9aHqkEtA==
X-CSE-MsgGUID: gMObH+9tRxyAe8PPe+2y8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="66640292"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="66640292"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 17:34:16 -0700
X-CSE-ConnectionGUID: RWd0RaLWRXqtewLYmeTdPA==
X-CSE-MsgGUID: NEuyfwICRC+sGhNBlGEAQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="186034198"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 17:34:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 17:34:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 17:34:15 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 17:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg0hj/awrphYZRE4N+uZClPy/yeMqWWRCMLnBqdht5gP3PcdU+302oi4mMMyjGF8JEcL6aOuvu/NJzSQ9Hz7DQolzvnCkg5zfcelYwFOxYo9bJP3wfuJZ5WcSYuXS6uOGVhHN/UlhyutcAuZz0AZ0oJslS/pcRxrosRs7gZsh/OpMcqaIz1eQNn3aCJtnQVr64XNP9Ncz9asOhBAo8N+diZnInEo34oV9/+v/cCQzPk5NhPPjHztdce0k8rl/fayHAVZq23igzW0Hgjo/xWtB0WJhzvnFEjGWGQrXeNDHWIiIkDFjmLZDmNu6IJGLmqALaPhOPjX8o6njcR9l4sQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ggq5SvEYy7mWLwyVQxNmkHCoAMqcoNAwiAlzrBe/eOk=;
 b=rKV9uXCbRZfqWU9gysR0ezj8h+kaHxVE0Y7BwBKtg1xUD14lrqQy1QszKJmM9+IZ1MmtaM4AfRvSdsmy7ZpOQXF57phFdpVLkeaPEdMWBKyso2skubA1W37zJryLDyOY8YG12B+//t4A8/b2RC0VaAiwDKGO8DxPr/LwNr/8Z82j+mXH329H9h7ZZQ8ieWYeOTVovvrRG51ghqBxfEmmZVibpxf4pDbD/mJfmn2/ZZO5/AlVJdFMSYt+GkVbSLqOV4mabN5wBB4joIvDFD8mp2CQnJxQY5LyIx3sQ8W8TjW7u5P9Stcyjf6qBT/GQh/ChZi85AXiz0XOJpgAr+WKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PR11MB8716.namprd11.prod.outlook.com (2603:10b6:0:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 00:34:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 00:34:13 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 30 Oct 2025 17:34:12 -0700
To: Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <yilun.xu@linux.intel.com>,
	<aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <6904040413093_58c1910054@dwillia2-mobl4.notmuch>
In-Reply-To: <96cba9e4-ad1d-4823-b30b-f693c05824d4@amd.com>
References: <20251030213717.GA1653974@bhelgaas>
 <96cba9e4-ad1d-4823-b30b-f693c05824d4@amd.com>
Subject: Re: [PATCH v7 2/9] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:a03:54::47) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PR11MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: df4dabf4-f728-4f58-800c-08de1815373d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGdjKzdIQzJxT3ZpSEpoTkZINUJHVityekhVT2tpNXZ5ZjZmRzgzUUk4WDhV?=
 =?utf-8?B?QzJNTW11b05TenEydndINlNpSEh1cGgvQVRQYlRZOTNjc3l4SkNrbDM2NWE0?=
 =?utf-8?B?dGJWeDJMUzNURnZsNzU3Vm9DazA3ZXh3Ui9MdDhMbTF5di8xaGJodEIvejdG?=
 =?utf-8?B?eDRFaFRMbC9hdm5ITjhwVUhRajNubFd0bnBWR1VnV0U3VXlqN01IR0FCM0Ix?=
 =?utf-8?B?NUdnbThCQWwrQXBTZHJDa1lyNXNmVUdwUzM3K3hRM3ZTaytXUnRETEdNaCts?=
 =?utf-8?B?MEpZWFlvWUtEU3dnSnQvU2NUdEdXVW9QWm5qdS9kNWpsN0VpR0xOT2JxWVcv?=
 =?utf-8?B?L2hvYkV0b3R2RGpydVVSN0FIQU44b3NqeTNyV2Q5V1JiaytETGxSTlJXc0Y3?=
 =?utf-8?B?bzA0OEhhVTczMHgzQlJPNkxtYlRHSmZWdm5KNnkvS2RkdmNueFdUK1dXSDlZ?=
 =?utf-8?B?OVRaTVN6cktuNjNSSXhJeFhHUG4yTUFFelhDUHE4RWxnV3Q0aUVpOHRQNC9p?=
 =?utf-8?B?T2ZndlBqTXZucDdPSU1UUmhjZUlVbEF1Zkd1YkpvSjN2UWhqcFAwaGF3amhI?=
 =?utf-8?B?TlBQL1dMclFZam5XeWlzR2hDclFzMGJBeVlQbFNRQXN0bDNZTjRxSmRENWFn?=
 =?utf-8?B?ajFZSVpBY2ZiU1MxTHptZDArWDVoc3Q3UjVvbGcwL3dINDZaWmxRczYyeUxY?=
 =?utf-8?B?bnROazhjZk5OZGNnaG0zeS85eFV4Q1VYUXp6R3BYT3o1U2NSazhtVWNGUi9u?=
 =?utf-8?B?bnJ5aE5VbWs4VXhUTE5vUXg3eEo3bG82YUMzWWdOUXc3T0lYL2xiQ0krOHl3?=
 =?utf-8?B?QkhXd1pIRVBTQnJzeGR2eGtwamxnYWpyY3lWdUxCTXlsWWRNTFFvaVp6cndM?=
 =?utf-8?B?Rm1wVnBib2laaXBHMDVySUFWZzZaYXI5MS80Z1JTVjJNdjNyb1h4ZWVSaEIr?=
 =?utf-8?B?Rk5Ya201K0FhUk9vTWVITGxOV1FmeHBsTTJyYllnWjFkUTJQSjM3dG5TNEdF?=
 =?utf-8?B?LytNY3FidHhyK3F3OWtmdlBKRkxMT1NRR2ZpUnJtOVRDUHcxWGEzcS9jQmpH?=
 =?utf-8?B?bktXeHRNS3h6N2lBUFZVcUZwNUk4Y0l1amRmOWxOajVwdFVFbHE3YTI1Y3V2?=
 =?utf-8?B?bHd2ci9tN2Ntc0V4K3lJclBCVWlDZjN5aWVoQjEybFlLSEFwaFhzalN2bVda?=
 =?utf-8?B?VmpDcGp5Tklsc21MVE5YWUhQa1dwZXVTRVVEQWNtTnNwaFk1U2J5cmNmMzc1?=
 =?utf-8?B?OGlpN3lYQmh5dEliQkl0alNVNG9xN0gvL3dXK0ZvajhjTUwrTnV1bElsZFFH?=
 =?utf-8?B?S05aVGhsaFNsQXQ0Q0lvd2g4VEYxVXdqNkxES3l4aFFwNFkxdjYwVGk1bm5P?=
 =?utf-8?B?VUdUK2lqWExUdXFTVDJpSE1TTVpweitQemFKRUZHRW1nbXJCU04wZitkaTdR?=
 =?utf-8?B?cXdvVVQ0NHBEYUpTTmhpTlhOREQ5d2lrSkQzSlp0RGU2bENhc1hxbFQzU0Uw?=
 =?utf-8?B?OXlsZUhpSUpHcHYyUnVMdk5lL1g3ZW5qK1VqaGxrTkdjc1lpcXVRdjZBaFBx?=
 =?utf-8?B?YUNURy9LMkZhR2wzVis4TGVjaW9HSXA2U1ZXL21ZOXhIWm1xU2xvQzV0dmc4?=
 =?utf-8?B?ak1ZSjBsb2U0SnpTeldzTlkvcjdSOEV6R1NOOTJ6L3BDcFRKaE5ITzRsVkw4?=
 =?utf-8?B?ZmNUSTh5UklhVWx0dUpZb0tFRW12RHF5REJsRkRKUFhvMVRTWkZIaTMvRkVr?=
 =?utf-8?B?N2pWWnJwSWZWR09SRXFBbEYvR05yanhNNmV3dVU4djNhdEd6TG16a0lSVXY0?=
 =?utf-8?B?NFlEMUJKVG9uNGh4Sit4VnZkTmNPUzBLSTcxMXczY0hvSmJvSE9PS1NqWEJa?=
 =?utf-8?B?UzNscW0xRG44MFhKSVpVSGQ2Y1EvOTBneVpia2RmRWp1MUJUMjdWZGpBZzcx?=
 =?utf-8?Q?SiPAm0F5BiZmQQAcLZXXdLZ79IVe7bY6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3AwdkV2S3p3dFJxNnNXeGdNTERBbWdoTnNXR0tXcnhjb1gyeTZlbmpnaEQ4?=
 =?utf-8?B?d0JGbnVXdU0vQ3lWUFR1WWJQQTJ0bGFqZFp6UGdUZWRFeDJoNW9GeUUyemJj?=
 =?utf-8?B?bEduUkl1UHEvdmxSc1hQNEgwTC9tUU9nN0RDUmtxLzB2MGdyM0p2dEhxYldQ?=
 =?utf-8?B?a2hienA5M2lUTGJRZXlzTWxWWFYvSjVKTEc2TUdZdFBrRzJDR1RWWE93OVp5?=
 =?utf-8?B?RndhQ3UzNmZwdzFrR3lzMzBUeWtMdmJnbTdWbHc5eWk5ak4rTWdCRUx3eFhQ?=
 =?utf-8?B?Q1h4VkVsQ0ZNdGNhUmd6VU5rWjBqdTBCSGJKM2w2TDRuSnpCc21QWk9kTFJR?=
 =?utf-8?B?OEJISEk2T09uS2hFRmF0aWNjaFl3SmhGY2MxQ285QzhFNVFEYmVTUXYyeFhz?=
 =?utf-8?B?VU53L0cxdzE0WTYrYWQ2R2YyVk5YTnlXclowYS8zNCtpRDJSeC9oUlB6UzJ6?=
 =?utf-8?B?bFlKOUlVOHFLOFlISFpOMnZLNFZaMmtjUmV1N0ZDVXV6YVVyVzloMENvbi9R?=
 =?utf-8?B?OGtCLzRnYXRaMElWMlZMeFNJQ3p2OUdpb3hxUllSR05KYnN0dVRWS1p2ZVZP?=
 =?utf-8?B?UXZ4SHI3VXNPSTI0bDhTUjhVU1l3RTVncGpNRWdMMFgwWHd6RExJTVRwS1d3?=
 =?utf-8?B?ZmRSb0dyc3IvSHZmTUJqT2lNZlNKMkNSa05YOWt5SmE3b3djdUlmZnlSTnZx?=
 =?utf-8?B?RnBrdGR0c1dMb2Q1S25vYmtVRm41RWRKenJLMDFLb3UrRWdBZVROZmlTRk9T?=
 =?utf-8?B?Nm12TFpsMjhCSUx6VmN1VG5HZDgzTlJIMGlZSFZWM3dZVjk4MUxhbFQ0V3ZU?=
 =?utf-8?B?ejVPblYvdjBmTzlPOXNya1NTcnY5SUtnSTNleEZSVFdmQXEzTVpIS0FzR3Mz?=
 =?utf-8?B?R1RPSU01SU1YelY5dnlTZ24zR1RBazJJMnJmcERJRTV1Vk9qYlBneUJTWTFv?=
 =?utf-8?B?UjRiSCtlZU9yU2tyeUYzWXp5bm9RNmRON0kydlN1ZGJmcFQ3NnpDcFBRM1dR?=
 =?utf-8?B?RFk0allMZDhtaU93TzV5dFNrSVdOUGhpUnM3Y1FTSHg4NWJEQzgyR0NHYVBj?=
 =?utf-8?B?aEJPNHRpTnhlcWFHNXpONU02YVJ0eERVRHZtR0M0dEpsNytYR2NMWDFvSDds?=
 =?utf-8?B?eVBpRDdXNVYxQ3FHdU4yZEVUa0dhMmFFam1DejhHVEhBL1VickNyaE4yK251?=
 =?utf-8?B?SUhjcmtaTnM5bWVHZEpvT1pabkY0aWdBaHZ1L3ZHWkVuMDd2VUJZRDRkQmFu?=
 =?utf-8?B?VU16RlJ5R3I2Nk9QbmlWRDZqN2JEM1dUZ2F0bk83L2pWNG5TZmc5ZTd6eG5P?=
 =?utf-8?B?dGttQ2NoZkV3UDVJSDlIbTlHQjV2eTJ1NWNjQWpxZUV3OFN1U1ZGK3BiaVdY?=
 =?utf-8?B?OGRQdmNpV2E2aEt4VXNJS3RJMEdCQWxZbWVQanJEa0dQclhYRTI0SFAzVkV5?=
 =?utf-8?B?NWZ4VGFZcWpCbXNjT25IbURxS0lpN1d6UGFjV2lhQ1h3cHR6WlF0RlFZd3hU?=
 =?utf-8?B?Mnl5QkNFc1I4V25QMmwvL3BuWTB0YzkzWE1MWWFvN0tHT040S3RpbzJrQ0hQ?=
 =?utf-8?B?QlA2aGY5YzhHNTBCdmpsQ0FROTg1S3dSUVNXSk5tK2xQKzROWkZjZmo3dnox?=
 =?utf-8?B?blRtWEhKTU5vdE1LMjBwWDUwNHhnd3pvQW85a01YMW8vS2ZqV1JjWlp2UjdK?=
 =?utf-8?B?bXAyQ3dNTFBIYm1lREFMUEV3NWpKVGxDUEhERXBoWk5JU3NDUUpDbVJlT0pV?=
 =?utf-8?B?MDAySllxZEdvMFRVSG1aVTRreGROZzdMd3dHOHV2eVlYZ3FxQ3pDL3dRTjYr?=
 =?utf-8?B?VkFIVmtXdWZOeTloMGoyajVFNURZNitoeGg3VHhNcStQbWhoOVhQWEo3MExZ?=
 =?utf-8?B?azFUOE5XMm5qRjJKQWtxWXREUE1ZR1dpeHJwS1hzT3BieHE4ZkNFa28rSmhv?=
 =?utf-8?B?SllmNngrRU1PMFRmTHBPRmp5NlllaERsU1ZxRTJ5T3d6SjlESnFpK3NqeDRP?=
 =?utf-8?B?VGt0MkErWXFmV0hEK1lmNDA4SXNCdEpiT3R1SW5ic3h4ZVA0OCtJbmwyK0dr?=
 =?utf-8?B?cE15ajVVc1hTSjdNd2VwanYyRTQ3Um8vK1djekx5SVVkSERHb0JZNy9jMm5H?=
 =?utf-8?B?L09KTGJ6OUJ2TTdqWnpabWhZUDdEdWN3ZkZSeUdxTjQ5SlV6Q0wwcmtNOFhB?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df4dabf4-f728-4f58-800c-08de1815373d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 00:34:13.5450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsWygaL2j5MrE02MeV6pRxGdoZnd9+DHn7PJpXhIe2PoRujhAMsm+QQeaLldMyLexaTDh0iB0PkOnKZYn6D/iNDoJtP1aYDZfbat/AV62E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8716
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> > I haven't been following this, but is there an advantage to referring
> > to r6.1 instead of r7.0?  I assume newer revisions of the spec only
> > add useful things and don't remove anything.
> 
> We are adding here a bunch of macros for all the flags defined in the spec but we are not using many of them yet (or ever). And we are not adding the XT _support_ (which came in r7.0) right now, only the flags.
> 
> So what is the rule -
> 1) we add only bare minimum of the flags which we have the user for right now?
> 2) we add everything defined by the spec which the commit log refers to?
> 
> Right now it is neither but if the commit log said "r6.1" - then this
> patch is a complete set of flags.  I do not care all that much, just
> noticed some inconsistency when I recently touched "lspci" so feel
> free to ignore the above :) Thanks,

It is a good catch. If it were not for me trying to calm down the
changes on this base set so that we can call it "done" I would go add
the XT bits now.

In this case it is purely incremental with no near term user, so let it
arrive post base series.

