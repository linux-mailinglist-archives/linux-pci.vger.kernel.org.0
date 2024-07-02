Return-Path: <linux-pci+bounces-9557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AADAC91F053
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 09:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0DFB24955
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 07:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927461422B6;
	Tue,  2 Jul 2024 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rj7BOQz5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D774047;
	Tue,  2 Jul 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905775; cv=fail; b=V9LvU1hVlywnJDMF0H4WWNc0NkcguiBJsFap/iaSStV8ZS9VrIWRlkFCYyNS8/nSQOMylp9qs7YODrMVI4R9GFVr/V9PW+9nzP6bXAMg56qeP1PIzpxICIQtdLtxd+0N3y3eHhZj50xNLTJAvtlmpMtekJPwElemEOFl1I3YcTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905775; c=relaxed/simple;
	bh=fHrq/OrSicUdRi7fRcxurnZJjJINrGVstHyfs/10rG8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TutYsfqQCdn9h549dYf7luIk4irdeQTU18LkzNlnwBdaqP3YNMNuYp02cF7988vwq/575KBo7wb6yjMYvICVOo0cBZWyveA043mWObf9XZRJSemBnffyBww5PBqxOSBS0BUXVGM8fNVdPEt/IgmpQdetYHFHG0pJ6YdyB3CJG5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rj7BOQz5; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719905774; x=1751441774;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fHrq/OrSicUdRi7fRcxurnZJjJINrGVstHyfs/10rG8=;
  b=Rj7BOQz5du/WYqm+XUYTK3XiPUDEuBRsUJA0hOWxcQpaFWizaDQAfmz0
   HoW7vJMhaigvidCqirpBXhHZx3WCP+PeclUI/9NPgJcQNrLH0OX07eTTR
   q6TnC9nTQKhjalNzCUM9lGdNzmDZg63JTpIDlrtf6LKOHHuPijDN+gi/o
   LFc2JQzKHp8sCM7W9E8/66gfAx9wW6YJ1va4DjIxz3NEVIaVEXeot9QI4
   DVrWyPFEktNoUp/1WhccW6Y/lD9IySXXv7vs02sEHxLCTxKhns+KHlB6R
   LOA/dLSjzfsPf5/LI7WyjMnVm+xN9wwsev8ubImVdLj1LJATQAWSK+8cN
   Q==;
X-CSE-ConnectionGUID: 0wO/oJWpS0GUjT9moWhjnQ==
X-CSE-MsgGUID: sPTsaWG2QZ6I2J4c5Ivf+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="42491827"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="42491827"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 00:36:13 -0700
X-CSE-ConnectionGUID: 7I+fepwQTbG3kwzSdzRA4g==
X-CSE-MsgGUID: 1S4KWiqzQhGWI4xZR96yBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45812610"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 00:36:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 00:36:12 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 00:36:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 00:36:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 00:36:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCUgO/jWQDSVkjicAMkqNQA5xi8sWJu071oV2Lk0Kbb75bS+9JGyVoqDi8FP+dnLJL7dVvGIYZuacM5wy60UhFIAY/ufAPmJCPogTSTuvFU/Ry9bG6HVwrvp9DqDz+LZ1lW9qNn5e9Yn16RGYmW0hi284gkLle45F/qQ4XTFfGPF6q/kI/DQZ3yt6vjjpf1OPgOGGzAdClNIPb7QJNVqhNhBll1J8wRjafFSPE8V0pIkW37IupvcEICDcp3wfcGNKFB6r0Nq/YS27Q1R14qh/8LPOcHQIXZrX2L0p5yOB/cHkCKTPBgLwfWroAF3r4ZSFt0sHCsXjUg9i9lSCIIVcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaJ3rrQwY3F20RdsDyS1iFfxYvNAh04j7vN+ERwIWKc=;
 b=nJTo0C8T7DGoW89CwMLZl05zuC+ww6V4ZZcQxDrdf1NxBQOctmAklZQ4YP5vrQflBxit3Tx61qMtfKLy3zWqHXh1zlOE23djrQGtsc4F5h8AUsTLuN/o24QlFdiqs7aXPu2YqBF+6czqzMcTf74HjV6ZPCiMxrCZr2WUhICGRBd5k+l4jPR8atyahy7S8TJrNpEnHVbTzBebq8it9Y8Qdq6X/LJpQ01h1I2pImBtYxqqFYqcMWq7El94NquW3XJ3XhEXWDIsrOlsm3Tf4VoVb8Wvlfsh7yRiBvKb5H1O8vAXkN5u3D3d1hM00juEBJur7CPZHzCRzcF1ZH9q2KIBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA0PR11MB7837.namprd11.prod.outlook.com (2603:10b6:208:406::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 2 Jul
 2024 07:36:04 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 07:36:04 +0000
Message-ID: <79ee5354-1d70-4059-aa9d-9d9ffa18689a@intel.com>
Date: Tue, 2 Jul 2024 09:35:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] mlxsw: pci: Lock configuration space of
 upstream bridge during reset
To: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
CC: <mlxsw@nvidia.com>, <linux-pci@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <cover.1719849427.git.petrm@nvidia.com>
 <b2090f454fbde67d47c6204e0c127a07fdeb8ca1.1719849427.git.petrm@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <b2090f454fbde67d47c6204e0c127a07fdeb8ca1.1719849427.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA0PR11MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab41b9d-91bd-4e39-e2df-08dc9a69a0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkR1bmIycHhtbkttVGlGNlhvcUttSDArYkdicHdLV1gvaUtsM0E3OHBmNW5t?=
 =?utf-8?B?QWdHMmlNL2FZclhDcmpLanFJaXFOZkFrN0p2YVYwYzZzMVhwYU5TbWRuNzk5?=
 =?utf-8?B?QTR3b2JQT3ZIVFZwVWFVM1pYbkxadkpwb1NpY0tZWkJMNHZhdTV1bkJOelZz?=
 =?utf-8?B?WTNGUmpQN3N6cUliM3lOdllLUUU3WURzMWZnZXE3MUxyaWRaM1FTaFZEN1Fa?=
 =?utf-8?B?NytIU3ZDa1pwUnFWVktWdklnTVI0Y0dDUjJsY2N1ZnMrVXQxUWJlWnE0ck5W?=
 =?utf-8?B?bmIvaTZ2MEUvUUExWDV0cXVUbFVyUStkaE5YWFVOVVROK283Y2ZFZngya2tR?=
 =?utf-8?B?YnB5dHdXM2FweUlXQitneHBNc3pWUHlCTTNMd0ZSMWtSV081bGpodmRNTUQ0?=
 =?utf-8?B?VEU3Y1M5ZFlYV0xSendaUXo0RTg2QzMzSnQ0TDN3Yzhtc0s3aGVsSkxjOTFG?=
 =?utf-8?B?RnJGRnordVVDa0d2RHhHN3FHWlRFSEIxV0NmOFhZWnNOc0RMcE9LaE5GNk11?=
 =?utf-8?B?T3QrM0k1T083dGNmRStOSDJpT0xKV0tIM2w3R1hzSkZmeDFWT3RKMkhpaXNN?=
 =?utf-8?B?Tlg5STEzMGZzdER6clFFQzNHR2hRcGZBMzFldkh2eEN3amxOMUNSbktseDBJ?=
 =?utf-8?B?cGphck1NallWNHFtTS9YWXpNL0pUR1pJY3l5RkwrR0xCOW5PQmFzUlhsQU9B?=
 =?utf-8?B?Wll4Q3BVLzNXNmhrNHRWbmhwK3A3VlZLREdNMFhWbXNMRDQzcWFaN0lTWHNS?=
 =?utf-8?B?eFp1TUtkMktWcUFiZzltYnNybkxINStiREdEWi95Q3E4U3diTVVvRFdSOStE?=
 =?utf-8?B?LzM5MXhXcXBHQU9mQ3FOeGFWMGNVYklvYVJpdlJ6aEU1YXJEM0k1UmI0ckd0?=
 =?utf-8?B?SDZ3OThQViswblg1d0lHVTNlNnovcjd4elcreGVzN1JpSEFRVWRLSWRCTFd6?=
 =?utf-8?B?bVFsQnl4Y0RaY3V5dTkvUk1Hb1hjMFJJRkM0aUFuQ1p3NXd1RExnMFNGOXpX?=
 =?utf-8?B?b05YR3hrY08zd0kxem84OURUM3RFbFhJYnRqWTE1SGJvS1F2R0VOSHBidG1X?=
 =?utf-8?B?VmZwQzNwRUhjQ1VjNWpCTlcydnZ0TjdjNkNYS3Y1d1Btelp0QThlRG5BMHp3?=
 =?utf-8?B?cnlMZ3E4dXFxN01ZV21xbHd1aVA3VGhvWEVjL0QwUlh2K05xRkpVV200RTRE?=
 =?utf-8?B?NTJuOWxvMEpkWURrU282UXFXakNscER3dzJVYVdYWE1BY2FOVUxKalFYNXdK?=
 =?utf-8?B?ampHcmc5ZTRoN1NKbEF5NnNQaElmMzdERlI4NE4xNzRnZWZXWmtUMm1EM3cv?=
 =?utf-8?B?dDR0RVhHeXF5L2tlQlJsSmJxaEJYRHVLcWV3c3hLUG4zSzVFc1BzdXNicWtr?=
 =?utf-8?B?d2EzbmZxSFVEVzFkK2xjQUtxS3lobUpUb1FlTHN4OWdSaUgwQkJUQTI3OU9J?=
 =?utf-8?B?Y0pNMW5uckVEU1NuQnFoNk9YTjM4bUVWTnN6NDFkQTFpT09wM0cxYk5qL2xF?=
 =?utf-8?B?SWZFVGh5ZWVQTmNua3NhS0tWME1wcitEcUNDT3hONzFQUE1CV3RnemJ4cWtu?=
 =?utf-8?B?MHNtR0h0QXdOM0wrNFhRdlFQTzNEQUJNZ2JmS05kMnBucUxNWCtnKzhLaFJt?=
 =?utf-8?B?d2pWbTVIci9vdTVpUCsxblkxNGJhSURxSnJBL1NoN2QwNklLL0NFM3FGZzVx?=
 =?utf-8?B?ejBJQW9PZkVQaEQ4Y0QyYVVwVmtkN2NvbzhZU0pmQW1TZzA4SjV6dG5sR0pp?=
 =?utf-8?Q?q3A+SQZBrr8fwXeC3NIHrWoRDEsunhZWP0qj5Tt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmtNRHNuTjdwbDR0aEVDMm1HckJQbmZvWEhMQnhLMFYrMGt6dVU5SzRqb3hW?=
 =?utf-8?B?QTMyYUg0M092YjRaRlk1R0h6OVp1bUxpakNoUkozaUtwRGZZYjdOcE9ONUVN?=
 =?utf-8?B?OGJUSHlsTnZqME0rdEpkUWxvMHh1OHZiRksyN3pOUTRheUovYlB6MTNVV3pV?=
 =?utf-8?B?SDM0dUhvRy9jZnBmUGRnNElkaTduU0RYU1VYSmtLL3Ywd2pndTk3OFFaT2M4?=
 =?utf-8?B?R21PeW5UbUs2UWVOWEYzQUJpMVh4dGRtUGMwSWhBSThsRE5iS1d3K3NZbzVX?=
 =?utf-8?B?d1NFM2d5bWppaUlxNlhBVEdPNGc0eitXVW5TazNkYlhsOGlUN1h4dTg4eUth?=
 =?utf-8?B?ZnlSNE1zT1kwT0QwcDJQcitsekxwc0NaZllYUlY0YU9SU3MvNjBjN0EzUFFE?=
 =?utf-8?B?ZjNIekVNT1l3VkliNE9qSkpKbVpKTWFIVGlEbUVreVpSUTBLbSt3czBSYlF2?=
 =?utf-8?B?TnhmOWJZODdPaHVmWTRRT1lqM2crVEtmaXJWTFVXY1daRWxKdkxMUzE4SDYv?=
 =?utf-8?B?QUJnajVTck1YNHYrY05FRStENDN1VnM3REVHemIxS2VhR3hkUGJRN0VmbFM4?=
 =?utf-8?B?dStGSUNKcTFJYy9WcEljcm1jMVlFYytPdHhJVm81RTVORGNBa291QmVJeVdI?=
 =?utf-8?B?MjArRXRaRjBkaDZJaUFUdjlobVNMMkFEUnhOUlpCdllvVGdnUXpJaE96bHlq?=
 =?utf-8?B?MUIyQXZkek5qaVpqajVPTFhzL2t3VnM3a3czOHlnUnphcmNnc09HQnJmOCt0?=
 =?utf-8?B?OHRUeWxGOTdUREU4SDZCazBPWldKMFFaNlhRZzJLeXEwTWo5amFXSFpTbUx5?=
 =?utf-8?B?QXYyMHF6NnJtbXkyYkl0ODF4T2dNcXVSVW1Kb2dPOTdPS0dlelA0NzNaS2U5?=
 =?utf-8?B?RVRJQlo5eVlnd0ZXL2RMUUZZMytxMHU1L1BsdktmeWVJZUFrZWVHSzRKZjFY?=
 =?utf-8?B?djZMRURKcU1RYmNUR2JzR3l5SVYvbW82UXNlMmh6TXNmVVIxVXVPdEVkMmF2?=
 =?utf-8?B?OVZuUmc3QndIaVFlTW16T0dWUXNvc0tacXVpZjFkZ1NtQy8xYURvdmxnMjMx?=
 =?utf-8?B?SGNEVDZIck5CbjVQaGI5a0g3cllrdk0vUzBTY2VmTzdlS1NFZVdXVzYxelA3?=
 =?utf-8?B?R2hqNXppK2JXUGN5UUhjR3dXbEg1d3lMejNTRE1KR04rZkFjZlFyWTJsUnJD?=
 =?utf-8?B?T2FKQkUzVUNPeXhGdk9SR2dyQzQzU09XUk05a1kwd293cDBjTzJPZDBKSFVD?=
 =?utf-8?B?QnpIbHU3VElXQUh5Zjk3UXVobnRKc2M4K0RCYXNrc2VXVzcwZFRIZkwxUHZS?=
 =?utf-8?B?VEVtNnhLS2MyMVhzSzNTSUNhZXBSQm9hNXBiYVVnR3F0dmRPREl6dGc1MTRz?=
 =?utf-8?B?TmM5eWdsR01lS0pnKzQxNGpEZ3N0Ri9BNDV0V2VScU44cUVLWThWSXpDV0lP?=
 =?utf-8?B?enZkS1U5L3NuZ0VjZi9lY2hJL2dqQzJPTkFzVzh3c1dpTFprdGlaeWJXczFy?=
 =?utf-8?B?cnpDU0QrcG15aXdTdzhZZDRtZUkrRXBjM05EK1RQMnVIRkYyVm9UdE9XRVgr?=
 =?utf-8?B?TlpUV3FZcUx0VDB4aEMvVjIzV1hSRVM5aUpsK3VhMThLUktYQnRYTTdhcURl?=
 =?utf-8?B?a2FkR2xvTCtQUjBNK0lhVlhLZ3dYRXYzUE1wLzVvOTdPNjFzY21YSWRWeDMz?=
 =?utf-8?B?S3puSEVHQkphcU5VL3JRb2JrTFdDWUFqdUNVenUyTnI5OC9BOWxsQWFKVHp4?=
 =?utf-8?B?SjV3L2QvcmIwVmp4RUFsTzVuSXU3M3hmdWw1bEUyWStvbWh1cmZHRll2dFRK?=
 =?utf-8?B?MUlvdW56YnBxUEMreE5jaFNyektqSytkd0VuaERvTUp0MFlLN2hUVXlEcFpx?=
 =?utf-8?B?N1hXVVBRRG10R1dKOTNRUU5JQ3kwVGlzZDM0MHYxc3BqOTAzbGx2N0t0WW5w?=
 =?utf-8?B?TnF5MEY4akRrSzJOaUtFMnB5ZTZtV2hOaFZEY1FnZktQUW94amtyMDhYcTlG?=
 =?utf-8?B?SXU2dE84ZW1NbWxFeUdwSjI4M1hwbTFKMEtnZ0Zhemc0RjUzUmdGUEszZ3JW?=
 =?utf-8?B?azlPMVk1Y21nQ3FOVHpVOUxIc0h4TXo0ZStEd3plcXV3MDA0WnNyVDd4K0Nx?=
 =?utf-8?B?SnZNaXBhQzltbG9RQi95VldZMmpyYlRyNS9YSi84aEliZUNIeUtDNlhpb2Vk?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab41b9d-91bd-4e39-e2df-08dc9a69a0dd
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 07:36:04.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgRMffFGJmW+bs6E0nNeebsN4j/zXkeStNZU3unVo42ToEh+8+WeKeBRmUHakiPOZvuOlSd7U+uBfak3anlVPA/Vq3T+iEIkFmjcyQnWo+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7837
X-OriginatorOrg: intel.com

On 7/1/24 18:41, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The driver triggers a "Secondary Bus Reset" (SBR) by calling
> __pci_reset_function_locked() which asserts the SBR bit in the "Bridge
> Control Register" in the configuration space of the upstream bridge for
> 2ms. This is done without locking the configuration space of the
> upstream bridge port, allowing user space to access it concurrently.

This means your patch is a bugfix.

> 
> Linux 6.11 will start warning about such unlocked resets [1][2]:
> 
> pcieport 0000:00:01.0: unlocked secondary bus reset via: pci_reset_bus_function+0x51c/0x6a0
> 
> Avoid the warning by locking the configuration space of the upstream
> bridge prior to the reset and unlocking it afterwards.

You are not avoiding the warning but protecting concurrent access,
please add a Fixes tag.

> 
> [1] https://lore.kernel.org/all/171711746953.1628941.4692125082286867825.stgit@dwillia2-xfh.jf.intel.com/
> [2] https://lore.kernel.org/all/20240531213150.GA610983@bhelgaas/
> 
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlxsw/pci.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> index 0320dabd1380..060e5b939211 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
> @@ -1784,6 +1784,7 @@ static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci,
>   {
>   	struct pci_dev *pdev = mlxsw_pci->pdev;
>   	char mrsr_pl[MLXSW_REG_MRSR_LEN];
> +	struct pci_dev *bridge;
>   	int err;
>   
>   	if (!pci_reset_sbr_supported) {
> @@ -1800,6 +1801,9 @@ static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci,
>   sbr:
>   	device_lock_assert(&pdev->dev);
>   
> +	bridge = pci_upstream_bridge(pdev);
> +	if (bridge)
> +		pci_cfg_access_lock(bridge);
>   	pci_cfg_access_lock(pdev);
>   	pci_save_state(pdev);
>   
> @@ -1809,6 +1813,8 @@ static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci,
>   
>   	pci_restore_state(pdev);
>   	pci_cfg_access_unlock(pdev);
> +	if (bridge)
> +		pci_cfg_access_unlock(bridge);
>   
>   	return err;
>   }


