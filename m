Return-Path: <linux-pci+bounces-5202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37A888CDB0
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 21:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DD21C370FC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 20:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3619213D26F;
	Tue, 26 Mar 2024 20:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3tbJ8UA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDEF13D265;
	Tue, 26 Mar 2024 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483262; cv=fail; b=LJaF2YfslanuUFcuCTkaUs3W6mj7q5ZaHJI4TAlPM9qFJJjMD5uUaRAQUKuV5CQlKQfQKpk8sTIucT3G49U/XuIuwJq41EsDex5uT5iFLOFOUMqbGR2apAz/n/yfeWm2AQKX3UDy9id/dlnvOsFsCEqjc/54iXHKMuE13HQCnk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483262; c=relaxed/simple;
	bh=HYmSmqF44NA4LUEhxD1klScTS2lQsT5xKPO0isHnBLY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=axK49m6+UKomMWd4rWorkK5XBzIaMaO483HKhOMAZ411br9paGYzZmI/peM8rJAGczxUeMZSBXUiUfIL5ESzwu7EglC4bUx8ZM+RV9wBFpjvkhT7NCYLQ1PoAtjW1EvsUtiqmPNFGhTxNZIaSCV0IFldjz4K+Or1GPFl+qO9Yp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3tbJ8UA; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711483260; x=1743019260;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HYmSmqF44NA4LUEhxD1klScTS2lQsT5xKPO0isHnBLY=;
  b=m3tbJ8UABzWQ66/EQm4vAItE1ONSXXqv2Rl8yfVQqLXiWXmLLmAXvuU4
   hJ2XTCuXQ01X7BH4ZjwT0RrsDW9WWjbYW2IoqYN9XHPUKjbcEEB2oW/Hz
   D3NfHA5lg20H9oypKfgMsfP0RLUkWAlsMxYw+yv5OcvjGlAzjNeiNCYer
   hTeYvmKPlB64w8eoWGpN7EZ6nHlCgFrkCh8WMz1ag/lubb9kbaGs3jfx9
   7ERl8ieVZOXleWryUp4ODxXSlWJAO52WOC8ilc3ILqMsxPEqaztiDRi8c
   uwTxbJhOSsggiCpKkumwcSAHm+qG4iwITNQWP9HWg5zREOuLN2dSTbuKv
   A==;
X-CSE-ConnectionGUID: FPo8AkH2QKqvtWiYY3n4Yw==
X-CSE-MsgGUID: PH4F9v2hQx2trdlrBUUsrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10358361"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10358361"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:00:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15983848"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 13:00:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 13:00:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 13:00:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 13:00:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4sWskisrrWqYTgdDzkauYlfyEEyTR02l/NViJOh98vdOUHb/ABcVwCXN4Yz1Yyx05+3RroVjO1gI138vzMSY9gh2+gB3it7gB0VY1M+laUprx6z1Rpy5zCjeWxCkq7H2h8To7yuHcTUjV9+C5CFTZ3zC9UV6TBmWEabIcykY9s3Z72Tu3bUANAQ6zIVxR/4nJCwfZYhq8miNUzBK7n7Jw7AtQBwzHXoRP5mULDAEGV2zKuw4zfWYCri9ahCg8J8NQMm8F2RlxcFYOhVqFPL9H/WjuJiDn+lLaSihzqrxorJN49z0fS6I3FVWBC4R2L+uwSI2ovP5vhq/0bG25lriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abUGaR/8w5zCXnSiMBkwPOe5nupx1JTcDroSNAmvX7w=;
 b=FIReqEf3jWj0RorGbgh8UPHovZdlviCPR+8YoWj+kr/ZeDyoytoOyowfx3wDYHvw57WN2MWgcxhHneN9dvHVm+GQwzJIDnYGY0GufZUqkSyk4QjN48Z1KmpAuantMmQ9/hdQb5gsfVxAubQ6wWPTWGZrB8nWbTnlVVkvvilGgeUIqwAvgsJDuIV8b7Pu+nK/+mzkhW1b3F1Oywdb9vwWe6iyq1lskA9oru38apPRvvtUlqsJ1Kz3RyqRT5sMbli+TXsKQN+K0wUHl4f3/+IAQq6CTDJAKsm4fLdm55nTym3E60PUFEiIWXFMZvRkZ1wIBWKuOnpfHRHFh7azfCX6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8348.namprd11.prod.outlook.com (2603:10b6:a03:53a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 20:00:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 20:00:50 +0000
Date: Tue, 26 Mar 2024 13:00:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	<kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>
CC: <y-goto@fujitsu.com>, <linux-pci@vger.kernel.org>, <mj@ucw.cz>,
	<dan.j.williams@intel.com>, "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: Re: [PATCH v3 2/3] Remove conditional branch that is not suitable
 for cxl1.1 devices
Message-ID: <6603296f71d1f_4a98a294a2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-3-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240312080559.14904-3-kobayashi.da-06@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:303:8d::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8348:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJfrRJ6ndF4Jl4PgqFHmhxRt+xdxRJ9Lcw0gmULyIlleVivJXZ/Di2bHD5pm0z9M0ywvgrDTw2vBkQV9pdHw5IL1QffU6Mx5HcqlP58SkC6krWs5Qfn06qdBTbVWe7hgDfQSZT8iXFyBI2PopUe24ywx/MgxcDsQl2D9wYVG0Nvn6MoauJnRZ4BjmQLiIrcq2Ay73L2ieRvexPUapFRlDOtSax7RWgnyD18ggth3Iv9TFLHMMTXRqvyEqW/cRlEUexWPO3G/9EkCQatssPKvOcmSjCOOOhLEEv6Y+GC9TH2BVX2uEvZWJlK7fboIWWUcUoS6XqJeB5nM7R7nljhL7sVZ8K3gdMULVKhN0+wkrGnDHFtbJgjg/mtIxIcmJfHRsInNBwFNHCZwZRojA1V6v+mS7KwWgevFkc9+T61bli9f5pUKWNlozD/W5bOEJ++ykN7xUYhdj8FZN46KZo5L0xrl8WVfORae4XG9sR7azAzg9ORgk4a/wyka0VjKN7SYjrMzeQnIbby7Vtktg4aks1SgPcfqCD6zafPlxltOfozATDh8h1LvtQAqrpXrWlX6h/PyAaCAnrrwb7wyALC1ejX5AXkSbgVGlFabnWjdhJwKWR8aP51NGaDvuDLVO4QcTPoqHBcTMJqsGD/8yW+FNG9OR8n+Kssz0c2aMnfoykQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HzF/9idgKlcLodguo3deS76qOA9K/SYML1j21A4t7ImPram0Y+JXWUrz78Tj?=
 =?us-ascii?Q?t0y1UEI5vF52Cm94vICELm2M9L2NVdr1LHQWMcFzgqek/IsirSVbsnWv7Ccv?=
 =?us-ascii?Q?6tyLWc7VfuunKJLecex1QTRUGEm+sMo6NzyGxypsSg/q/dLRBXFrKSC5wvhM?=
 =?us-ascii?Q?Ry8Oji7WN0cdVcDb1s765UsMY+q++3tJ9jbLdPjvVyvFVIH9YE5wsyF2cxhC?=
 =?us-ascii?Q?OVvd9CN5zQ6lnKpUJBXsgJZMzeuUX9h0Bc1H15FNIK4RDLrwCnkV+P5bbCDg?=
 =?us-ascii?Q?EXahxQYtQtU6TydcR6ku2T77JT2MHq0IuFmFMqfZLu1BYyMgj5/bGcvreGwf?=
 =?us-ascii?Q?eGugjBj3RSyRayyWbEFWVfUXwiJ6Jj3wK+trHnw9uwjermAEZMGwW4vTppOK?=
 =?us-ascii?Q?cGgWyreUSv2R6VacbImedBR9wgpedLhHdVQzHCohe3qi8j2kDpTAr2lEsjql?=
 =?us-ascii?Q?dLG07c4rCCBiGabWHueU5SQmlN0Hc5VoJ7jF+OVz7tx2EbSjngsv32ceEein?=
 =?us-ascii?Q?RxjVYmFiFlnlH9lj50eUsn81UJc4Mf3BWonTzRg171gW8IyqXETfbn+IFAQv?=
 =?us-ascii?Q?917Q7s171CeXqlOCsV7ZtTrPDL9F3HmxEC/FWKpv8I2X/ZRKHX/eKYpSpxac?=
 =?us-ascii?Q?55Slm2WrP550GjpnmF0Yys3sUaqj4/TLeo+k+NBOdVV/TQDfvuw1kASNAPaq?=
 =?us-ascii?Q?QNv3EsdqsCwUTP5jsJL/QmXBE989Ubrxfx1R8qQRuC8AP4pPD1wkXs1J0NgE?=
 =?us-ascii?Q?d0kLNeq0Tb+PH012NHDbvI6NSdZQ01U91TLLhcM+SsiRfnHI0LhuUZbi4oFR?=
 =?us-ascii?Q?nHYznDvJku9USZbGyhThroy6Q+w5Z8qNUJxmnuznJ6OP2j451oUK1T4ulW9f?=
 =?us-ascii?Q?XiKICVnulIEpq8Cimimk3KB4Gs3ldYbNpJ9vjheJplYDV0VsPkHkASBQ5DJL?=
 =?us-ascii?Q?DiNE2Ff9Q1ofHMG9NscspSxrcwnm7Tvkbnc2BnGPV5PWt8rrsOsbMgF2Fwpp?=
 =?us-ascii?Q?0WQ5vDou63SN+78mVELBAEbE6sRV9Drl8kztv8sOQAkxPpk3j5AQOCggWEYV?=
 =?us-ascii?Q?0YJxfA4lBQmYXvXja9PHmH21NsnzuIdrjwNu+eGyQTyZ9WqG5cqoYrQ1YHIF?=
 =?us-ascii?Q?zo7bsE4RRPEUuzt3dFVoKH4u0ZSvRP+WHj9BSBn+7ocrvUIBtsna5+g1b7Co?=
 =?us-ascii?Q?T/NrSt63ABpkTVV3MAy6uJEsxDXAYSPdXIu/8z+dhFwI8wR6Sxu//v6vqj/y?=
 =?us-ascii?Q?S0bpUHvT9W2Sq34M5u8K3/9m8OMDf5l/V4k6vZRGO/es+ziuzVu7A3xmKzYf?=
 =?us-ascii?Q?xQ3K9ha3qGUGzbM39sYo++1U2HZJFtz57mfr2zDvu+5j1/7vEqs/hKkqdTDw?=
 =?us-ascii?Q?009WUBl77TMX/79j5H5SZQfZXFD8H/OHJR15MtebNzTI6YQ9Pp5st1IW8421?=
 =?us-ascii?Q?FB7NOarhALhwBYA5aMSd1RE754EneDPMmvzL5ta1aaBc5ewryv/flL0/zmjN?=
 =?us-ascii?Q?r/zpB32imld6iuBuC9tITaF8e/iMIUZM4UalZBL7g3NOMsj3e8oJnHm55/OR?=
 =?us-ascii?Q?DI7vKzKOx0e2wNaUe0Kl+R1h6emisdce1vlfYnCnj6Hg9qRlGHFgnhUziA0b?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5063131e-4102-495f-34c5-08dc4dcf6f25
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 20:00:50.0039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwh0V7GjoWDRbwees8gqX2bEOaSI/oj5oy9q6jh5XyQNIDxc0izIuNjlC+zZ4lcHwOYapwMCg85TjUPN1Uqzr/lSJJaelcNySDAshLmqTJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8348
X-OriginatorOrg: intel.com

Kobayashi,Daisuke wrote:
> This patch removes conditional branching that does not comply with the specifications.
> 
> In the existing code, there is a conditional branch that compares "chbs->length" 
> with "CXL_RCRB_SIZE". However, according to the specifications, "chbs->length" 
> indicates the length of the CHBS structure in the cedt, not the size of the 
> configuration space. Therefore, since this condition does not comply with
> the specifications(cxl3.0 specification 9.17.1), remove it.

No, in Table 9-21 in CXL 3.1:

Base: If CXL Version = 0000 0000h, this represents the base address of
the RCH Downstream Port RCRB

Length: If CXL Version = 0000 0000h, this field must be set to 8 KB
(2000h)

The size of the CHBS structure is always much less than 8KB.

