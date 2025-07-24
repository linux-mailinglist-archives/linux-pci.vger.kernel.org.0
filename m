Return-Path: <linux-pci+bounces-32899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDFDB11225
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 22:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE018172859
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF3823A9B0;
	Thu, 24 Jul 2025 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuTFjmKZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB423BF83;
	Thu, 24 Jul 2025 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388629; cv=fail; b=KrqTRuI8QAOTp8C7SR9Kz4HWv1ek6sDmLoaMzj62+Gtc9CKMVVBjBhw94WtKto28piMfQzTgQOd9kIYh7rNpKLfvrsMjQTE76CGONO0HEh/KaLAZF8HMRe2FcCkUorOhNulB9+4VJw+0A9r8zKMKfaPpW0FCMMFTV4b8tjrtzhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388629; c=relaxed/simple;
	bh=O/RyO8diHPIQN4yMwETLKyVvlLJXzTw0D1PbTMdEQXU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=UjVM/HijXNbbS4EmgPp6PgB1wOPpTWVRziaE1uIwmT/UxXGjJwBA+5scaQibPv2G5t2WLeBJjjKI8JJ8lKRvrwa1bzux86SKLpM2QJnQncNG7LS5kYEywPfFyBZdl3WoMavVrML2n6egpJuv7X/bX90DEKqZOPG1/wQnF+JnfpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuTFjmKZ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753388628; x=1784924628;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=O/RyO8diHPIQN4yMwETLKyVvlLJXzTw0D1PbTMdEQXU=;
  b=UuTFjmKZt0PtXC/XIkn6KOCpIY8YPSQWIrKUC3dCt+hZR2aN714bJAt2
   sixFO7UHJJj1j8NQQBh6/OLSWWNvXOfFHTQllr2TbwQQBoInbHR2NMkQ2
   D3RdKvwHF6B8bqes7E9saogxLjVFQ006SykKBoCbiRS3nMVVVdzFj3XL5
   5epjvZ6SBZndKjhJsjSEuM06JtwcSzpe7enqSw0BGrbytqfXfuHlBn6rt
   o2pucusmfOs0qIqzWyY6VWJD7lDPJqsim0o5THSI7tI16yoFyxVKn1mgh
   KSX+lXwNpkltOGuaK9wXUu+ufmqti64xo4J7rZdIB1dDzYFQvQ9/jVPOG
   Q==;
X-CSE-ConnectionGUID: uzQE7ZHWS+qLylBFKyQOkw==
X-CSE-MsgGUID: fby+SMZGT2aWlsx2hWk7ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55824928"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55824928"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 13:23:47 -0700
X-CSE-ConnectionGUID: +sjFxesHS5yshgeJI6OSZQ==
X-CSE-MsgGUID: k413S/r2RDmopR34ONz/Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="159653632"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 13:23:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 13:23:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 13:23:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.68)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 13:23:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSRd7Nq6mNo2yb1rDpsUdi2L6DjfAeHxrdVgGPoJsDVufJzR0kCNrH8ZdubClvtMtAFadEjgR6T+SYMbkPDxmFvF+54zvogc8cj9jz9c9WZY1t5Q4U8cMf9Gglb5DVxNosIGVZcmPBwGbB/3SBXvkm1tBwwlc1WZ+6+3n75QcFBKi587bnDhNYzldWy7ubgDNQpvqwRbgOW3250FMQruReaJliRLo+QfZtdVYj72isJpbhYxMYjmlnNNb/qRnytAY6DoNHVDauy8qbKZhGu3FfE00Sf2UqGpjf4zukyzpPnX3UlsIcpUpaYaJwdR5P7nr/F+a4vTb+wofrlY2jop3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgY1Kr4h3DsTsC45JZtVPPwnCspagR4cwEjLv803fzE=;
 b=dVsEvLN0pdT0XaS64eP9xSxHbda6DJDApxCcan6IQp6DkZ6lRuNPOOFsKhCcg0JUGFn8fCdmXNjH6mBNwAqIUqfA3soN0yzFJwWaSbTk0Y5mGZRhRocDSGgqUtjvvPQ7NHk6nThqQOjUUUTmDIlZakrTNlW5GoWHgHjXM7By/pzxk0BzbeEgWrMZp9B8moS1Xx4suVPewnIHdj691XYb8+47IsgaIt9MnQCRWjoe2tnpgfkoxSXqiExvw+SIwaifF+o93SQ8HiWOrSB8zbtAeWcwxqR52Bk4PwVCCVC7csgtBPDtgVaIeEIZu7F94pLhq3JCbJ6YQuZCfwdhQ4iScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 20:23:44 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%6]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 20:23:43 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 24 Jul 2025 13:23:41 -0700
To: "Bowman, Terry" <terry.bowman@amd.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <6882964d627d8_134cc710044@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <536c6bde-fe1c-400b-a8bc-bb40a23ef9fa@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-5-terry.bowman@amd.com>
 <6881896b8570_14c356100de@dwillia2-xfh.jf.intel.com.notmuch>
 <536c6bde-fe1c-400b-a8bc-bb40a23ef9fa@amd.com>
Subject: Re: [PATCH v10 04/17] CXL/AER: Introduce CXL specific AER driver file
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::19) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|MN0PR11MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c80556-c3db-486d-0336-08ddcaeffc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TCs4d3ROeldmMk9PUy83YUt6QmlRQnVQQUE4MkE0c2ZaQnoxUW5hZGFPT2hC?=
 =?utf-8?B?Q3YyZEVJQ2lKWlFGUThka2pxM1krWXR1UTFNTHRyQmw5WGNjQjBTVVlhMGow?=
 =?utf-8?B?QkNYWEYxNTFiMk5GT1Y5Wk5wWHVyazBjVndaNzhTQ29PcHlIOHVteEFrRFBO?=
 =?utf-8?B?dUdIQ1g0TXZSa3MrRmM2dmR6UDEyRTVlN3VyRGFmVXRDZVBNeWx1TTVUSHpC?=
 =?utf-8?B?SjJPRzFOdC8wZWNOQ0NXbE4wSmQ5VlgyUWhkTC84THBCZ0hUcndjVWhNd016?=
 =?utf-8?B?eGVSNXBWMkJhUytsd2xLNUJzWHNYSW8vb3VjQmMzRFlJckc3SUxtYlRWYnls?=
 =?utf-8?B?RitLOU1ya3YxLzNpdkJ0a0F6TVBMRWFoTjkrMWxUdmRYejcrYndBNzI4eVUx?=
 =?utf-8?B?RnZpV0NldCt1VjRhYmVvS3BpdHhpbC9RaEp2UzRwSEVKekVhQkY5QmtyNlRG?=
 =?utf-8?B?ZzV6KzJDRWc1aHFlb0JUZFlEWWY4a1RaL1NOWXN6dHViZUFLMGVmd05GUFZX?=
 =?utf-8?B?NG5jcWhySUY0Q29WTGRNeVZBNHJpUmhjTy9iU1BRdzZSSk9id3NUTXJrb3oy?=
 =?utf-8?B?NlU2cm8wbXdkdDl0QzJsVEc0eHZyOVF0UXJVK09TU3N0SmpFTlUxNTA0bTh0?=
 =?utf-8?B?UDMzbVBEaVJKd0pja0NVQ3V6Z3hBeExvb2E3di9rMk14VStjeGJ6NGJseG1Q?=
 =?utf-8?B?YmowY004ZktWV1JiSFE1djMxcVFjODdjVk9iNi9ZWkJiaHFZRVVZMjVhMXNP?=
 =?utf-8?B?MndmUENGTndFU1ZGdGRubUp0V3lEdEREVGtFWG9qRlc2dUwwcFhPbEFrMnlv?=
 =?utf-8?B?NHRDMDVNTkY1OERwcDNPOGNYdlBiVyt5VkRURDhFWklHREtrSEtKRmU5RmNT?=
 =?utf-8?B?R09wVHBzelNJWlBrWXdnaHczdVlXbGdHeUxiZjFWb0wwTjg5c0dOcVl5bHNS?=
 =?utf-8?B?K2l0d3VtdDlKNE5qODIxMCticHZTLzFCekQwOXJUSDBTUHFURnJMNUVEL0Jw?=
 =?utf-8?B?aHpPbTF4Vy9pUjFoMCsvUGtBdTFTL25ad0RxaVRYcDB6NG8rMWZ2TnJxQmVq?=
 =?utf-8?B?SDZpNW50ZnRZTmRUTGp5M3RLRmZDd0JBYjB1R1gvaWluRnNGSzdnZ0V0Z0N1?=
 =?utf-8?B?a2lNRC9uZ0JpNXFSVTVhaStteGZ4ZThXQWhQbm9CUnd6b3RmT3BVdmUzUWVB?=
 =?utf-8?B?UGxVTXRXd0hCUlpXRS9aZFlHeE1FVU1JNjgycC9PQmVNaWRHSWxmaFRLOU9U?=
 =?utf-8?B?R2taL25mR3Vac3hpeklxM1dydGpQTmxvT2dVcmg1bzRvdGZMWDlqdWkzQzg1?=
 =?utf-8?B?Q3NLSE5QR0JrUmdJdlhIV1JVWmg5VDRTL0dWZEV2K0ppYk9XQW5OdEdEY2hX?=
 =?utf-8?B?WUF3ZUUwL2VVOUxQbWlCejd1OXJqS3A5N3JRUXVOSXhvaUpITHRFSGFIRGhr?=
 =?utf-8?B?VkZsNDgva3djMEsvdjNpeUMzREgvL21pQmJUek1EQVF1RW9RQjdXeU9uTk9H?=
 =?utf-8?B?NTdrblh0V2xSVjRrbGdlVkI2SEIwTVplZmZmdlFwZ1NYN3pPVUFNTDd0MDVM?=
 =?utf-8?B?ak9BT2xOeW5tM3Y0SEY1dTQwWmF2ZDJKVzNpRzlIYTVXVUJLcExsUDZ0aHhY?=
 =?utf-8?B?RXpnbjlyYVpGOXEraWN1OWFreEpETWZpV1dNT0svY0xPR2h1aGZQLysvUGRx?=
 =?utf-8?B?N1duRkZ0VnNqMFVzUGNJWmdKbEJmay9KTFF3TXBGOGMxUkdDMnRQcVozdkVT?=
 =?utf-8?B?eWx6K3g3Z09EYlQzQmc1Y2hOLzFsWUJscTRSL09ITHJCckdDZ2ZqM1Fzc2tQ?=
 =?utf-8?B?TitmcnRiRG1VRlREcGtqWXBLQm1YRXQwQUpNVS8zUDkyclZaMVVUb0luR2lt?=
 =?utf-8?B?RVBFeEtCeWtTY3FvNklYeU05RUxQOFpwcnAvN1dPeXl6TythZFk4WHJhSjhV?=
 =?utf-8?B?VUIrdTBFY3pzQjFOVEIwZ1lPUnhWZ1RBQk5uQ3JHT2FyR2hrZWpYUlBvUGZK?=
 =?utf-8?B?NHl5cWZwUUV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V21tS3pBK3FLeGY3VFdQTWJETTVjQnNSalN3VWN4b1FQem9nSFRTdlo0dVRV?=
 =?utf-8?B?RFlFZm5HZ0lNQ0E1cWxxL2NNenRxdStJckgxYktFZDBBUDg3U01HQ2lJbDdr?=
 =?utf-8?B?ZTlsdzFKM2hsSEhWN1JuZE5MNVdMNEFRM2JWT2RQZXdaUWIray9HUWhQQzdi?=
 =?utf-8?B?bnNQUUsvclZQNmtlaEx4M2srVERoR2ZreHVwWENyRWs4dWR5dmhOam5HWTAz?=
 =?utf-8?B?aUhZT2VqNGxzb01Zay9HSVJ0aDFZalNNbWFBZ2R2Y2pVazJ5NGt2U0cxVUxz?=
 =?utf-8?B?YmtEdDZLUnJGdUZIOFRvcEdPUGZlSEN5UFM3WVIveEo0UFh3c0JsQjlYcmVm?=
 =?utf-8?B?Mk1ZWlVRcnQ4M1hxSWxyNCtXWTBBclo4cXVRWGs0MFgwVUZTbHovNGNDZDBL?=
 =?utf-8?B?U2NYQnR3TVhtMldHWWI1M0M1b2Y0U0lWZGsyb3RQOUhIWTFtS0pjTmt4Tlg0?=
 =?utf-8?B?MXFMZnQ3UDZiZjNCZFk5dC9ma0JCMVJFTkNScUErUlpla1hNc3RzTDd3UXAx?=
 =?utf-8?B?VURNTVlKcXdQb0hNVXNqdEo5a0FiTW9UM0J5dUxzdVJOWjJrNzU2UEtxV3lt?=
 =?utf-8?B?b0FBbGlYT3FvVnNuSFQwUnJub2JBMjZTaTZhR1I2Q1dLZkFtWlpJNWVNdUls?=
 =?utf-8?B?UXlFMEgrK0JBZHhZLzlEK1RrQmlKWWJUZFVtMlU0MTlCcmE5SCtsNFUxZCtp?=
 =?utf-8?B?TUl6Z1pCZ21oS0FjeWlVYjY1V0w5aitILzJjWTUrbDVKMW4veEV3R2IzKzhi?=
 =?utf-8?B?V0lUc1hpUzFEY0ZVamVoN3QveE1jWXNzTDhPaHRHWENId2RPdXR5R2s2TGtu?=
 =?utf-8?B?eXZkd3lhbXFYRm1EN3JWNCthb1BTdm9xUHYybmsvd2syVXdjVU5PQy9MNVRE?=
 =?utf-8?B?TUg3THE1WHF5NlJaeEh4WWIycUNxQmMxMDh5TXJORVhINHppRnJZaGdnVnJ0?=
 =?utf-8?B?bURTY1VKN1YvaWtsYi81MUVnc000dVU2SmowWURzMG91U3RxSmY5aEgrdUF3?=
 =?utf-8?B?cTJXWlBQNmdaZlRhSUhaeFRVZ2Jtem1lYU9YY2Q3bGE2ekg1SWdObkJFdU0w?=
 =?utf-8?B?TEVRdWUycXYwakc2TGR4Y2NrZEUreEdDdENhZGZiUzc2dkpRem1RREMxWmxp?=
 =?utf-8?B?bFRSLzl2ZXBkbzU3eWd0M2NwUytCdThJbWhhM0lzSnVqRlhGNFpuaG5yaHpZ?=
 =?utf-8?B?R0V0bHRia3ZZdGFQdzFwMUo2dFhnMSt6aGFHWm1NYVZteFZCT3FET0VBMCtI?=
 =?utf-8?B?bHBNRGNvOE00NWY5VnRVZE5QdFk4amZoVU00ZlE4bjhZQjBEN3psa2ZJN0dF?=
 =?utf-8?B?d3NIRG04c3dFdlg1dnNqaEQrYURhQlJXdUhwNG82Q0RRdUNKdnlFaXRLL2c2?=
 =?utf-8?B?ME1Cc3lHaGlMOGU3MkdzV2dnc1p2S0hxQ0R3TU9UQmpVOG9tWnBKWkJyV0w1?=
 =?utf-8?B?Um0vb3ptS3dNN2lOL205QkgxSWRVTXN3YXk2Qzh4ME9teVZFYnc3QmgrR25K?=
 =?utf-8?B?aEhUdndPRmxTUXIwTE1SUlNFMG1yUU5ucXJUZmQrclZZVW9OTWY2RmtpQTBo?=
 =?utf-8?B?eFpZdlFhRmVtcS9SaFhaN011OE5EVXA1dVNDQlRvNC9OQjl5bSsrbmkxd2JB?=
 =?utf-8?B?bFdvZGxQbW45QnN1N3hQTy9nT3E1dUhBTVVyaTRMYXJpSVhFQTNEaFdqQXNk?=
 =?utf-8?B?UG1JOHVwUE5Nd01nU3NmWkhZQ2F0UGZEQ0Rjb2p1Z0xJYjZKMzdETnFYVVVo?=
 =?utf-8?B?WmZFNEV0Y2d6ZmtCY3Vtcm5ZUE85b25PTE55azA5YnZGZFg3Z3I2SVkrK1BT?=
 =?utf-8?B?SUlnZXpRS3ZOa1V4cFlXZ1NVM0UyYjRienRHTHM1cDBZV01UNHVBdkFGbjJk?=
 =?utf-8?B?elk0MzlYM0JMSHJ4VldZTjd3WjhkK2JCSlBsZkRGVTdGSlpZNVh6anFFWlFU?=
 =?utf-8?B?cVNHMk5rcjBLWnF1SUJNRklRNzZGc2hENk1BTkIzNjVaOTJCVHdqQ3p2eWlW?=
 =?utf-8?B?bHhnOWRYVlYreS9RY2NsdWtWenRRYjc5UHg0Y0lMRHNKSEtMY29Ya09xRTR2?=
 =?utf-8?B?Z0pVVXdFZk9qcGFqdUpMN0xaalhjT0ZENVQyVjBsTnY3bVBEeEs4WjVqWlB6?=
 =?utf-8?B?S2w0eHRDeWRRdmV5QzdxR0Z6bU9GT0trdEpYcjRZUkxpSHNwbjlIZko3dVpi?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c80556-c3db-486d-0336-08ddcaeffc56
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 20:23:43.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2kNcJZVXTLiWudiL6goerUPVi4ZJc00XoKvKw/C1hcBpTSSi4b4iAaxjNunbOOk5yAsXt6wfFiYzFhfJzfBmb5mdr+pmkHrxNuYzhYqx58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5964
X-OriginatorOrg: intel.com

Bowman, Terry wrote:
> On 7/23/2025 8:16 PM, dan.j.williams@intel.com wrote:
> > Terry Bowman wrote:
> >> The CXL AER error handling logic currently resides in the AER driver f=
ile,
> >> drivers/pci/pcie/aer.c. CXL specific changes are conditionally compile=
d
> >> using #ifdefs.
> >>
> >> Improve the AER driver maintainability by separating the CXL specific =
logic
> >> from the AER driver's core functionality and removing the #ifdefs.
> >> Introduce drivers/pci/pcie/cxl_aer.c and move the CXL AER logic into t=
he
> >> new file.
> >>
> >> Update the makefile to conditionally compile the CXL file using the
> >> existing CONFIG_PCIEAER_CXL Kconfig.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> ---
> > After reading patch5 I want to qualify my Reviewed-by:...
> >
> >>  drivers/pci/pci.h          |   8 +++
> >>  drivers/pci/pcie/Makefile  |   1 +
> >>  drivers/pci/pcie/aer.c     | 138 ------------------------------------=
-
> >>  drivers/pci/pcie/cxl_aer.c | 138 ++++++++++++++++++++++++++++++++++++=
+
> > This is a poor name for this file because the functionality only relate=
s to
> > code that supports a dead-end generation of RCH / RCD hardware platform=
s.=20
> >
> > I do agree that it should be removed from aer.c so typical PCIe AER
> > maintenance does not need to trip over that cruft.
> >
> > Please call it something like rch_aer.c so it is tucked out of the way,
> > sticks out as odd in any future diffstat, and does not confuse from the
> > CXL VH error handling that supports current and future generation
> > hardware.
> >
> > Perhaps even move it to its own silent Kconfig symbol with a deprecatio=
n
> > warning, something like below, so someone remembers to delete it.
>=20
> cxl_rch_handle_error_iter() and cxl_rch_handle_error() need to be moved f=
rom pci/pcie/cxl_aer.c
> into cxl/core/native_ras.c introduced in this series. There is no RCH or =
VH handling in cxl_aer.c.=C2=A0
> cxl_aer.c serves to detect if an error is a CXL error and if it is then i=
t forwards it to the=C2=A0
> CXL drivers using the kfifo introduced later. I will update the commit me=
ssage stating more=C2=A0
> will be added later.

Wait, this set moves the same function to a new file twice in the same
set? I had not gotten that far along, but that's not acceptable.

The reasons I had assumed that the rch bits would remain as a vestigial
drivers/pci/pcie/rch_aer.c file to be cut from the kernel later are:

- The goal of forwarding protocol errors to the cxl_core is that the
  cxl_core maintains a cxl_port hierarchy. For the RCH case there is no
  hierarchy and little to no value in being able disposition or decorate
  error reports with the cxl_port driver.

- The RCH code requires a series of new PCI core exports for this
  one-off unfortunate mistake of history where the CXL specification
  tried way too hard to hide the presence of CXL. If this code is
  already on a deprecation path, that contraindicates new exports.

> Dave Jiang introduced cxl/core/pci_aer.c I understand the name is still u=
p for possible change.
> The native_ras.c changes in this series is planned to be moved into cxl/c=
ore/pci_aer.c for v11.=C2=A0
> The files were created with the same purpose but we used different filena=
mes and need to converge.

Why not put this stuff in the existing cxl/core/ras.c? I do expect that
we want to route CPER reports to cxl_port objects at some point, so the
"native" distinction is more confusing than beneficial as far as I can
see.=

