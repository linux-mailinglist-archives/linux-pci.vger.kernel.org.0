Return-Path: <linux-pci+bounces-29084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EEEACFF70
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 11:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35D71797E1
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A799627F736;
	Fri,  6 Jun 2025 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwkeNdKB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496625395C;
	Fri,  6 Jun 2025 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202717; cv=fail; b=RQenDpy5NVlQaybmFD1QiUG6CgfWs2tcWfTZSHIcEUTMV9RfZj4nfuFcYS68UUaeI3hpU/OOIrn3tHy8ZE+Az5tUNsP8ZzXvzYGUL7UtYpgrm+Ra8LgTSo/IQd51Rio0YvUMCuGhneX5URDuz+nqT4TFGbsmwhEtQXY9BIdQOns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202717; c=relaxed/simple;
	bh=qRpDQJ14CyrjWy7HdsLidisPUscl9xLWQTTGYo0tNA0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dUiF9PCW3ZSIRkf7n1C5m8qWHNAXyOXj49+7oQtXZoG/mIWbMGrOBWPtktDo2R7lM1lqrKcusSQknEC75AaZG+GHGD0mlaB1Et8BSyUorFtzPg0LVxtmJ/+9gaV6lsOMM2KpYcwaY4z2/mL0egTlvuFYsG3pt9U8meLoidadAxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwkeNdKB; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749202716; x=1780738716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qRpDQJ14CyrjWy7HdsLidisPUscl9xLWQTTGYo0tNA0=;
  b=EwkeNdKBMWxMHikFwmGawEOIBdlrE4N01fkJo9xEwX9rGkJc7oWKIXlG
   Rz5EVIiLIe6xrLW7qaDjzF/8SskVhIpuQxT0GbB1xw3xVPnKO1wpz9+cx
   1DDC77g+dRAXlYt6RrJzUGF9RqJ57GRlw4SSGuG+zTIehUUqXFiOZC/ax
   HrSh3EPS1PYo5KecebMp9gEiVmpaTa2UOq53cVT/gSxxNmJRJsHNsliPm
   XfE3ZJxAaecjVRW6sb4/0BG78ckxNF0ZQ0wcPRKqHIVq4MAPjlgkWqxF+
   v0cfK1viedGxlzKy+wOYm5wHo4oOgePaHXxgNkQe2G4OCsIxIs/SB9KDB
   A==;
X-CSE-ConnectionGUID: ZZ7Fk514TziuATJvflln0A==
X-CSE-MsgGUID: Rvk4cq6XRmGMrXXjtCvXAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="55156373"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="55156373"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 02:38:34 -0700
X-CSE-ConnectionGUID: E9SGOEfbRSyLixg6VZPKkQ==
X-CSE-MsgGUID: ViDHLtlpQH2gqfR2zCqG/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="145707894"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 02:38:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 02:38:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 02:38:33 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 02:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmT1NAKiI3EnB7hmXwmBaBt9MjQ5XIlotStvxc0KsZnSoP/v6riJip7uAiM0r9LG3ipEKebL8fF6P7ogplxzXWyKw6D8Oy6W3EKupjMyq/w4iP4AtcuO4twylpLlyvonuIzoHO2NAD+1alDdSBn48ABJy2tr/MUXhj1KYeuobCYv+eLurjCoXOgoWY1qEgDa6QxZ8WfWMKnFIUhRGKqO1wFHsDqesJ8gqjQ3JIFt1TRTX7oXjFrcYHoErtWcRUkQe8fUq18JSWv++pNorIRn8AqXZNr6Gb6W5Yb8RSU02bgfq7iotHhVpuEd9BT/j+UClwTg8jJ4rZm4WiahLOPZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bytKDtg78ynC8xE41zK7hVFannqKFLupwkX1W806KQM=;
 b=aCPrIr61KmergshSH/lM732lRzr5y0nLrtH2L3OmoJoocFzfzYtJhDOgFU0s3CLjDrLoUInGeXGB8qxtKccdAjFaZNNWEcrt8t9nAZANcmyQXcFVFyvX31yolewx1ucsLU+dZpz/3tyHhlndOBInR/d6CT8K/bTGO3NTzbJ5MRxbHhfegA9TaY0eelHZUmDWPlju4pZrj8knMjNw+NcyMy/SAjT5TbtANVFp6fAG5IhBUp4vZNpixuP1t4yNqCw+YK7XHeencujbeZA6Ual61BwOtS42fXo6T0/HY/wm37Z747h2/3ZLUNjHU0soBmS1nlpRfIny+LYJoddEX2JKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5703.namprd11.prod.outlook.com (2603:10b6:8:22::5) by
 DM3PR11MB8672.namprd11.prod.outlook.com (2603:10b6:0:44::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.20; Fri, 6 Jun 2025 09:38:12 +0000
Received: from DM8PR11MB5703.namprd11.prod.outlook.com
 ([fe80::f734:e507:3083:e454]) by DM8PR11MB5703.namprd11.prod.outlook.com
 ([fe80::f734:e507:3083:e454%5]) with mapi id 15.20.8769.025; Fri, 6 Jun 2025
 09:38:12 +0000
Message-ID: <59cb5e00-c343-4d86-90ce-60a1b3b1ae5d@intel.com>
Date: Fri, 6 Jun 2025 15:08:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4,04/11] drm/xe/vrsr: Introduce flag has_vrsr
Content-Language: en-GB
To: Badal Nilawar <badal.nilawar@intel.com>, <intel-xe@lists.freedesktop.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <anshuman.gupta@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-5-badal.nilawar@intel.com>
From: "Poosa, Karthik" <karthik.poosa@intel.com>
In-Reply-To: <20250529111654.3140766-5-badal.nilawar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::26) To DM8PR11MB5703.namprd11.prod.outlook.com
 (2603:10b6:8:22::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5703:EE_|DM3PR11MB8672:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e05420-05c8-4075-4351-08dda4dddaad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXlPcTBrNUhqOU1oS3FNOU5pdWE5Rk9IMWNnWjhDSFVydDlyZCtMbVpTK0Fa?=
 =?utf-8?B?U1ZPOGdaaTdMTE4wcFlwU1dKQU5wRG1HM3NibkdneUVRVGJNSjFNNmRJNEpr?=
 =?utf-8?B?VEVpVkZlaWJSbmdQa2ZBV1BBWTcvQzNPeE1VQURENlkxQ1hDSHBNN3QwWS9Z?=
 =?utf-8?B?RlduWVJFUVdEbmMrZ2JSakIyTlVPZzJ0UjUrOEtzTFJ0aDFrSmtBRExRTG4z?=
 =?utf-8?B?SmZTMVBvWHhnNXdpMk5KcDAwTDVRY0l2YXFCdCtyditGaEFvRmR3R0hqSEFD?=
 =?utf-8?B?amNRZVlXWUttR1dvOEV1bkNPbERZYTAwYlV4bHVnUEJMTmRsV1NFcUlXYnlV?=
 =?utf-8?B?MFFmUVVTWkN4K1hqay82RVNuc3ZVSC9OWlhCSURpK2RHbDB0UGdCQkcrK2dp?=
 =?utf-8?B?R2JKUlRKVUI1dTRNUzFSWE4xTU8wWWNKL28xYVk5NC9mcmt3ZG41RFF6SG1V?=
 =?utf-8?B?RDlRb3NZR3R1R2VqWjRjbEFZNTdPSG5vcDJXanQ4cktYcm5uZ1dIbDlNMmpV?=
 =?utf-8?B?SGJoRWhVN2l6ZGZmMnNkaWY3aHdIOXJ2TzFGM3AyR05oV0dlRTJrV1lScklh?=
 =?utf-8?B?N2Npd0cxNTVrZmZhNERFa05lT0MzTHFrTzY3cWRRUmZkTTU5KytsUzU3T0Z0?=
 =?utf-8?B?QnZMR00ybkN6MXhiY0pEZFJ5eTQ1ckovdDBGS2NYMGZqSXdKR2VpblVJQlhF?=
 =?utf-8?B?YXhVTHBLdkRVTk4yVzJvanpHbHZyd1lieitnUWhWL1o4eUQrV2xWY0tDQ0Rr?=
 =?utf-8?B?NnBxbEl5WVRJb2dtUE9xcnVTYnJ1ZGV1SUVPU3JQbDhiUEVHQTRoM2lmdFBl?=
 =?utf-8?B?MmNKcGNRYTdnSnVjV1o0UTMvcnAvMkpYUm9ZenpWMWZVbHFkN2oyNUh3dlhT?=
 =?utf-8?B?OXkxRHZGWkNaU3JEUkJHNFZZUUNBTjdPcVM5bUJFMWZiRis3cW4vQ1JySkR6?=
 =?utf-8?B?M1pOWHk0ZUtYdE1uZEd4MWFwcWZpOG1PZFNDYjUrYUFlbHhGNnI0aWlBcFl1?=
 =?utf-8?B?aEdzYlFDbmdsYlpENnpBV3YvV3dxS2pXdmJFVForNXFjNGxEb08xUmNhaGpJ?=
 =?utf-8?B?RHN1V0dOYkM5NmlWdHNIeVpaL05TcmpVNXA5cGc1bVpiTVk3QnFGSmw5dkhP?=
 =?utf-8?B?UGFLL0JIWTR1VjdoUG1jVnZ0QnIrdnE4Rng4ZEFRSTlxb3JTRjI3Um9GVC8z?=
 =?utf-8?B?NlJRdlYvWmZCV1cxWm1aSzBKODNzN3RZa3hGN1BkUWhidzQrTmtpdXJFUmlH?=
 =?utf-8?B?dGdEMDNBbW1JUG9GRlRjMkQzQUZqL20rZmY3cUp5dkkvNllRZkcyRTJEcXQ2?=
 =?utf-8?B?UU5BcVZtQVQxd055THNEUXdHaEJibitFcmp5RDJnaXRLU1Y3bjFKMjVCcnIr?=
 =?utf-8?B?U2FaemZIZ1hRWC9RUG1uQ2hHbU12OE5kRmxsZnNiRVAyOWlDRzZjd3ZCYjVN?=
 =?utf-8?B?Uk5qSXRXV0Y5cS9YdEFIdENEQitmcXJDVnVOSjVzdjdRTGRvTjZsSUN3eTlV?=
 =?utf-8?B?RmZUUllVZTFHN3d2eE1FVElHM2NueE9BNldYdVRuR3pVNDBpR055cExSN0FE?=
 =?utf-8?B?by9Hb2E4eWFVZHM5NXBHcldxWGlsdFgwd1Y0cTVBK2lKWjduTnhsM3YwRzg0?=
 =?utf-8?B?b2dvSGhJMjNxQUJ1Ti82eDN6a2p3d0w2MWxUL3JvZ3orREFRdkpScHVqUVho?=
 =?utf-8?B?a09BUU5DbmhVdDl6bnUyOGhMbXVBOXFuZU1pc3E1K0pOek9wTzE0eGMwVkpy?=
 =?utf-8?B?ckxxK1poUHNVZVh2REcyUjFDTk16SThZVU1qazZYd0lmWG1mcTRqTUU5amZu?=
 =?utf-8?B?LzhCQ2tnR3AzQ1VheWpMcC9URUF3QkE1ZGVJOTBrZ1lSTVljL3RzSnpWWmFR?=
 =?utf-8?B?RGNzVWMyNTJvR0NtYzM0alBEUWRoOXQrMWFaZFNob2RuSDlGeFBhaXAzMHJa?=
 =?utf-8?Q?b1D9wjqpKWY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5703.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy9EQmUvQWxuS280Tk5haFdEd3AvMTk4Z2V5VzBrUnRLUDJIQmZOeld0RHQr?=
 =?utf-8?B?NUxiK3J5dmpTWUdDYlF5YWNZRzFtamZFZk15a2t3TlE5QzI5WHhXbmdYR29z?=
 =?utf-8?B?RitmT2ZKU3V4TnA2aDczLzJBOVV3bDRUUEJvZnZ3dWRES3VQZUdTR0pRME9v?=
 =?utf-8?B?OXhVMjRtZlBMN0ZGbjloSTRTRXh0bEJVRitnU1paSzg3QlFwTUpKSkpWck1r?=
 =?utf-8?B?MkpOSnZyTmNWeVl1VDd2YlR0MUN4NWFsSWpsUlRHMDlYR1ZuRFdyTHhhZ2sr?=
 =?utf-8?B?S0dINFphdEhML24va2NGRUNQWGNoRzJOd0NMMm9ZdUJia1VZM3prKzBhRENC?=
 =?utf-8?B?bDlpTXk4djJtcUtCd1g4ZERIUlgzS09qMWp6SW1RWjVyNE1TWnhoUkpIUTVu?=
 =?utf-8?B?MjFLMUZVVlQ0Z2w1dEF1a1J3cnE5VWx1MU45M2FIME5NdlVBeTBCbllxSjhX?=
 =?utf-8?B?Ym95ZC9aZVdlQnc3anBRd0hFNWxFdjRubEdYZnp2RjJNNEhDU3ZvQ0NFK0Vy?=
 =?utf-8?B?ZkRGZUNPVjUrWnBIWHc2TEQyRm1VMVVRUEQvbHZKSEkvTFBUMmo2VVNaNTZk?=
 =?utf-8?B?T0hDNVQ2dzh3QktKY3R3bXNBNTllNzg5cVNqcVB1NHgyQStwQ3htNWRnVmlF?=
 =?utf-8?B?VWdlZFdQdVRWeEVtQlZiYzRSdGxDVWNVMVUxZmt6K2FqRy9XbzdoL0prMHhW?=
 =?utf-8?B?b0JHU3JIbExoZU9OZDZWL0J0RnJjRUxMSkUwU2doNnFMdHE0aGFOQk94VExD?=
 =?utf-8?B?U2FiZVdJWVFmMFlMWjlyVmtINy84OWYvNmcwbHl2Y2JxOENQRkZNTk5ud0xC?=
 =?utf-8?B?ZWV4dGJkWkxVWk1PeURhYW5POGltWVZPbS9KQ2s0UW1YQThYa1BFdWVNTUxU?=
 =?utf-8?B?akpYaUIxdkljempBMUZlSk13WmxSbDNGbHJXZG1zdVNiRHBBZWZkWHRxQ2Vo?=
 =?utf-8?B?NFQwcEJDSnkwU05SM09acVdpZnV0U3l1RXozVFRkcXFpSzJZcVp2aktpSUFJ?=
 =?utf-8?B?MGxoNVpNbGZvWHJ6dFdzdDB6ZU9EWWg4M2xXcU9PVktmTVhYSHVteGFwK1M4?=
 =?utf-8?B?Ny91YW9wUTZvTVQwckFNblg1cFc0R0QxbkhUUTlTTnp5aUUxcWtib28ycVBB?=
 =?utf-8?B?aW10WUpWREk3TkxGTlhUMG1KN3NSejVWdnJMamxjR3g0R3YyR3J4NXk0NEZt?=
 =?utf-8?B?ZXg1OFhBL21zRTJkQytqNHVMUEdsZld1dVBzOGFjYThrR3R1dFBSRTVRcllD?=
 =?utf-8?B?UmtBbnE4V0FXaytHTldJZHI4WUxlMm9vbDVhdnYreDJZMXNiaEJVUkxzeFk3?=
 =?utf-8?B?UGVtdVlweis0bTBCeTBzOHRKSDJETndwSTJGUHJpcWhFMkJEKzVtRzdBd0ww?=
 =?utf-8?B?dG56VFNCek1vY3RLQXpML1I4WlN0elJMTUplNGk5K0xZWktpTHBoUDF2Y1FF?=
 =?utf-8?B?OVZXRS91YmhmUStKdC9HbEVaTkRsOXZ3NCtIcndPblcwNVVWVkRzSnRIeUdQ?=
 =?utf-8?B?c2FzV3pYVk94UDR5L2hIMG9wNmlmM0ZJbWZxL0UwdDdWM0dHUWI0R1NvYmV2?=
 =?utf-8?B?NnhsT1V5ZGlLd1JtSW5CZVZPMTdZTGVQSnkwZlBSV3BLWkJrajVjSVoyeXZZ?=
 =?utf-8?B?eWZUVHd0MHBsazlJQ3d0ZmlSV0NQR2FqRXYwNjA2ZitGbFRnbVdnM0svUkJX?=
 =?utf-8?B?WDVxWkRLL1phc1QrN3c3ZkRyaHFqUkVXczBla2taMXdQTDcxMTNtdk5GNGNJ?=
 =?utf-8?B?dER4VzIwZ25DcEh6V3VMUktFTGhOVFhkdk9zK3o5RlNSZWoyTEZ0cnJ0OW12?=
 =?utf-8?B?YVkzNHFMUXlSZXdkR25yeEdBNmhVcVhwYnRNY2FROTNsQksvLyszbXJoVXcv?=
 =?utf-8?B?bXBmc0lkQWRxSEhHQzE5bUF3THhmWUhFeGdrYlVPY1UyZjhUclpUQWI2YWlC?=
 =?utf-8?B?OHZrWjBYMXpDdTE5UTYya3dPK2ZTcHE2dVYxaDhHR3hrZGdaY0d3VUpLTTg0?=
 =?utf-8?B?N2tsT0RPRzlCTEt2a2lIT0paZmlSYkdiOXNBS0JNU1dqRkNHTzV3V1VrR2ZR?=
 =?utf-8?B?NW1JVURmVjR1b3VleWZhOWl2MzlHNFB2TFpyM1JzTHd0UkswTWdSbzZET1ZP?=
 =?utf-8?B?K1p5RDIvRW9Rc29YQmhWSCs5dmk2N3QwYW1KRWFsVjJQQmtVamNFYlI3UEZh?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e05420-05c8-4075-4351-08dda4dddaad
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5703.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 09:38:12.8244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2aWl3pzfT8lN2TgaoV4nxCiBJS0JjAAaY8XDUlzPKQtIo1Y9vt9T9HiasFN6Amfy31qAFWqKSzal5DxakAIcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8672
X-OriginatorOrg: intel.com


On 29-05-2025 16:46, Badal Nilawar wrote:
> Introduce flag has_vrsr to determine if platform supports VRSR feature
>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_device_types.h | 2 ++
>   drivers/gpu/drm/xe/xe_pci.c          | 3 +++
>   2 files changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index f81be293b260..e2749ed2a61f 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -334,6 +334,8 @@ struct xe_device {
>   		u8 has_sriov:1;
>   		/** @info.has_usm: Device has unified shared memory support */
>   		u8 has_usm:1;
> +		/** @info.has_vrsr: Has capability to enter into VRAM self refresh */
> +		u8 has_vrsr:1;
>   		/** @info.has_64bit_timestamp: Device supports 64-bit timestamps */
>   		u8 has_64bit_timestamp:1;
>   		/** @info.is_dgfx: is discrete device */
> diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
> index 024175cfe61e..46a99d6ef1a5 100644
> --- a/drivers/gpu/drm/xe/xe_pci.c
> +++ b/drivers/gpu/drm/xe/xe_pci.c
> @@ -68,6 +68,7 @@ struct xe_device_desc {
>   	u8 has_llc:1;
>   	u8 has_pxp:1;
>   	u8 has_sriov:1;
> +	u8 has_vrsr:1;
>   	u8 needs_scratch:1;
>   	u8 skip_guc_pc:1;
>   	u8 skip_mtcfg:1;
> @@ -342,6 +343,7 @@ static const struct xe_device_desc bmg_desc = {
>   	.dma_mask_size = 46,
>   	.has_display = true,
>   	.has_fan_control = true,
> +	.has_vrsr = true,
>   	.has_heci_cscfi = 1,
>   	.needs_scratch = true,
>   };
> @@ -589,6 +591,7 @@ static int xe_info_init_early(struct xe_device *xe,
>   	xe->info.has_llc = desc->has_llc;
>   	xe->info.has_pxp = desc->has_pxp;
>   	xe->info.has_sriov = desc->has_sriov;
> +	xe->info.has_vrsr = desc->has_vrsr;
>   	xe->info.skip_guc_pc = desc->skip_guc_pc;
>   	xe->info.skip_mtcfg = desc->skip_mtcfg;
>   	xe->info.skip_pcode = desc->skip_pcode;

LGTM.

Reviewed-by: Karthik Poosa <karthik.poosa@intel.com>


