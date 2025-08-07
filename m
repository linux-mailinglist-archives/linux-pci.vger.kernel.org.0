Return-Path: <linux-pci+bounces-33587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A35B1DF62
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 00:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA057AE8EA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEBE1E520E;
	Thu,  7 Aug 2025 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfUCWIYy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4143FE7;
	Thu,  7 Aug 2025 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754606264; cv=fail; b=QTEw/XBeFsBB9WNiDP0VEltqEg6XRqaKoYpYGY5wbQJGx932+w2fb/j1vbeTJ04oZfjeratILxYZ1cQzTQpmS8S9GjJIy3ltERkiKo1lfoOn9dQDDmQqfBhtwjYdYtLefJNdOknuM7jGgrIKHV1Pr+FPyGfwnk1ykcogI8IfDlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754606264; c=relaxed/simple;
	bh=83MOCKkV9TQkqLKqg9ASih+KTUWlhxSKyBXU9JrTeTk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=GbMv/DI7/hI2Ceudc7ZONzSxibc1nGq3MVr3P26TWBsY8YTdCdeBEYu9nKjOiG2dKtSwlGgxb/HKDlTVgE3Kq3DZHBdTOD8yoF7pURCNL4gD/NjAf+uKj391y8oZVri+S40hydAJ1GnO6Y2xAnHk0miXZ5b3/un57RPJGqWDyJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfUCWIYy; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754606263; x=1786142263;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=83MOCKkV9TQkqLKqg9ASih+KTUWlhxSKyBXU9JrTeTk=;
  b=dfUCWIYyL72VGHELTuiXex+s/hAsl+yWJFQQnUcJB8G0j/7RLTbUcTgN
   hFxDbW8Nb5QdcUEbusu5VkNy/EUpljwpiQuu2SihuyHpdIuy74gbLmWnS
   9aflplR29vMS9XQYGdoYNSwlIobm9VnV57x3UknhW5Fz2Mdv9hVWaXKp5
   E8y+F4fdK2z4RMVwLYCCyt+C5BGCI6aTQspf9Du72EERiPKIxW1A/BSY3
   bHmNz3OiaGJEGbyj4LwaIxPc6jKWPzXiyQnBAmmvfHGpXU3l4qB/TWEed
   stv0NcoKVatkrUFbRytgZcn92y2yu6MFXNs/3OvkuU7djWw/BGMXG5cR2
   A==;
X-CSE-ConnectionGUID: RbtAPK3pTEitBZTr0yrjGQ==
X-CSE-MsgGUID: gP/DBirARPy8PslMsada3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57087055"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="57087055"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 15:37:42 -0700
X-CSE-ConnectionGUID: 0NkisUPDRPCv1NEg1D0biA==
X-CSE-MsgGUID: whH+/q0lTQ61iuGeMYKo+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="196174356"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 15:37:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 15:37:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 15:37:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.82) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 7 Aug 2025 15:37:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kljw2X4idzdkCzmlLByfm9TS4wmm8hWTmHsZuDMQ3DHCKyVCzvPQousMJFOgAQ0VmcjHqdKEYQo4jnXLhOZJzT5Dzt1z8RQB3hcXZYevSZFylICTAE7UgC+UJWWGIjiLIHftNuryQrWlpIF+2VH/uV1dVEWN2+cx/4hISaEUzr1+CayDtoX/yPe8W+KKjZ1JWi3BUGj6xNLdBvCF0JLc3fxPnSCbBml4rnUegcH42IXh7quTwrX+cIwv4Lex4KHZo/exeBQ0l/zomu9uPo0vw+JPJU05MFHhYgnaRsIW4p1KBnw0UCiuZfiIQPQxIzYC3mFlcoC6IG2jNKfeCxbOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GeV4iU1+z08w/1uo1Tq5jyivbRLlx9Ax8xpRqRMzkw=;
 b=cDNHsElckYWgMxGwJqpQ95E06vAa4ueX7qvin1jPeEc7HdGnTdfip+6r+0xQHVTi9zecG5ARFDK+3dGtzo668+5B4jktdJiD6RizIxptxwoi/nlhaQW1BRZwa0OMVRyYkGHHJ7kYeW/l0EUdEBBpkPpuKBd7IEO/J//CIDNJEFEpojbieLWNmo8/LFCwOwnZPhpODBe3yEQ7HHvPnIBwGUbTmIJ2nf8fFo8g9oF0VsmIbAr6N/3kO3z5iseTw+/8ohtxNXbS7qCh+Q8YU1NatVN8q8DZSbh7+jcx1kv/0PPu0F3txLVTFYXYAULu+QqKckOjMfhTYPAyS69sbQf50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 22:37:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 22:37:38 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 7 Aug 2025 15:37:36 -0700
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Yilun Xu <yilun.xu@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Message-ID: <68952ab060b6d_cff9910033@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250807201236.GA60870@bhelgaas>
References: <20250717183358.1332417-3-dan.j.williams@intel.com>
 <20250807201236.GA60870@bhelgaas>
Subject: Re: [PATCH v4 02/10] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: d35d5e53-d2d2-4f31-4373-08ddd6030368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXlnU3kxY2hlMDZad2pXQ2dPcml4ZmVtcnU0Y3hFaHdIRmdRQXdtbGwvWDhN?=
 =?utf-8?B?VEFBbXBnVTBXZExoV3Q4Q3BZYURRZzhSUkIvcWkrL1BpUzVuaVR3elF5c0Yw?=
 =?utf-8?B?SlJNTG45K2ZCVDdkcy92YWhsWU01R2w3OXJOVWVUdHgyQWNYVXk2YVg4Qkd6?=
 =?utf-8?B?engxVUx6cExOTklKZW5ydnFRckpQcVJiYkcwY3l1UjQraDhSQlp5S0ZoZFZU?=
 =?utf-8?B?YjdQRDhyNTRwWDdoWDVDZGdBd2JULzN5SEd6SlZuTmdHUzFEc2tqc2ZTM0ov?=
 =?utf-8?B?dFBoRVo2QXB4WVNlNzhJQ1M2SHNxR3hTNDBOcTBHWGIzK0s3eTU3ZWZHOGxE?=
 =?utf-8?B?WHAyOVdudENsWTUwQUlVajEyK3YwZ0t5QXBIUG5acGRxeHVYMUJHYThhODV2?=
 =?utf-8?B?N0RYTnduRTU2WWh3ald5NFhxVFlNL1Z6Zk00WHRsbWdORTNEQlY4U1d4YU5w?=
 =?utf-8?B?VGRZRFZUZmhuMWZMMU5kL2pCeFcwSyt5Vi81RXRmL1BsNzJEY0dhclVCQzlE?=
 =?utf-8?B?VmFIL255UTNiUGwyMXRWY2RUcEpKcFh2L21HZkFTd0R1ZGd6MTZ3MHVjMmVv?=
 =?utf-8?B?cW51bkpCWklrMHVWRHhYUUNvbHcyeHJZeDdTWmhmc2hKUXN3anhXU05DQ0ZS?=
 =?utf-8?B?ektwRmZlcERYb1lXT3dvWkVzM3ZvWjBaV3RnQVNDdk5BamxocmRwVUdGWjVJ?=
 =?utf-8?B?VnJmUWR5V2tkenZGbzlSM3R6Mmd2ZkNJU3JtbnJzVmVvb2x3UXhqMWpNZzVy?=
 =?utf-8?B?MlZPNTFmenlUd3FwMVZwY1dqWVR3SVNpaXFwNWI5OEttU2hYQjV1cmJHUVYz?=
 =?utf-8?B?K09qOENBTk43cW1YdUlaMENpaWo4ektyQnB6cWJjN2VmamxEamFMUU5KZmEv?=
 =?utf-8?B?VkErTG1Xb1h3RTlTZmgya2FpakU3dFpzVUEzc0J1ZmQwQ1F2bGRyVkpUcFQ0?=
 =?utf-8?B?ZmNPY3ZLMXd3dlFHK2tmM1pDVEJzbzNJeXdHUDNSMnZMeGNhVFZVZzkxK0I2?=
 =?utf-8?B?RGZ2WXdFamVROURCYnBIcFdnYkE2TEJ4WVgvYzAvWFZSMnUvV0lhSk1nZldo?=
 =?utf-8?B?NDlOTHA3aUVHQVl4Q0xtZ2VIS0NkSEF5MEQ1NFhldURVMHpqN1p6OVN6YW9U?=
 =?utf-8?B?ZHJrQldIQ2ZoQUNtUXBweWlQbTVlRjBlNVpBNWxXUnhmbXFlV2JFcWFvMkhp?=
 =?utf-8?B?ekxKQlFjajFFdVJURU5OSTB1d3Y3U3A2VVh4Y0pPVHBLZEJYSXgrcUJqYmhu?=
 =?utf-8?B?SWJYWE8ySEc3bVF5d1F4dCtJYXZzL2hTaEtVSVp2WVE3ampPdHBDazhoaCt6?=
 =?utf-8?B?L3plU1hOYXM0VDZLTkZROW1SWnR1OE9HWGVyUGVXMlBFV1JrZ0F4VStpcUNS?=
 =?utf-8?B?TFN4WWRUdVl6MkllSkZqbk1KMy80cWp4UnZWazhNc3NMRkNXblM5T2xaWWo1?=
 =?utf-8?B?MFo0S3Rtd2xzd3B4WHdseHhxYmpvTUk5Y0FONEo3Wm9lMGtRTnA2Z2xSRHQ2?=
 =?utf-8?B?SkVoaHMzaVI1eEpaWklvZ0wzNm1rOGx1SzdyODJUbjFpb3k5NU9SM3U3TDk2?=
 =?utf-8?B?RHA1ZXE0VVRaY2h5KzlHMEhSNGhOYWZhWEVmbnVBejBGdDE3dnlSSXd3UmlO?=
 =?utf-8?B?M25LanVJUzdSV1RxeUhZR3M2a1lOVVlCWFBzWUkwd3RIekhoZWdDZ1dCYm5l?=
 =?utf-8?B?MURTcXY2Zll5V0pIZWlPc3FXTituUEVSc0F2cDRjQllGMUpLWHZJa0M3eXJS?=
 =?utf-8?B?L0krQ0FBUWVtcW51Z0xvaWMwYkhxRXdpdnRXR2hKR0J3Vjh5U2N1d1o2SVMr?=
 =?utf-8?B?SmdtODdVRUJPTUxrcjJFd3FlckppdCtmTFVNRVdHZFhwMVpBZkRPdm81dC9o?=
 =?utf-8?B?dGo3ZXZpTGlvU1RuT3ZxbTdxaElJQkZHS0M0dzJ3M2hodVNtUGVNSnp2eVlR?=
 =?utf-8?Q?Z3DNwE6XuT0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhSeWszNmdETG96RWMwR3R5MHd5ZThGbWJtMXB4REF6dTN1eU5TTUJHa2FT?=
 =?utf-8?B?d0JET1RyZU5YUzNHYVQ3MG1NREdQaStDekR5eDRwNkQwVllIa3VrUzk3eFFD?=
 =?utf-8?B?UU5zSHBIVTU2QmdIRlRHK0FvMjBtQ2liSStSL1Q3cloxbFFuTHYyd1I0bExZ?=
 =?utf-8?B?OFEyNXBnTDlQdytHb3FCUFFKQVRKR05YU0lGenVlQmNTS3UvMTVXRXJqSjEr?=
 =?utf-8?B?a2g1a2h5dTFVekp2RmxNamoxWFF6Ny9aLzhPSzVqTE5xTlBkdW13MmhFRHdC?=
 =?utf-8?B?RDQvQ3RmMHRvL2ZPYWdoc3I3VEQzZXdkZjlOTGdrRXhlNWFBdklXN0NLdnpP?=
 =?utf-8?B?SENKemxwQnBPN2VwMndwNzE2RFVqeU9paEVobm11THUzSG1nMitYUWdVSCth?=
 =?utf-8?B?NnRwelM3QU1RODZkbU5GUGlLT05mOHZVaVM4ZDIwZU5TQTRVYkVjc25EVDAv?=
 =?utf-8?B?TzNtc2pPbnhTaE5JVG5vRS9GNTk0UkltcjRzUnJFNjdPNk9BcG15Z3dzZVpt?=
 =?utf-8?B?SUdMNnhwSld3MW9sQ1k2NS9xSzQzSkNDK1dUeWRFUHJtcDdFOHhMdkxBQjQw?=
 =?utf-8?B?OHVReEhyemZVb0lNeGRFTnd6WmUwMG0zVy9aYmhXdkpWRFQ3VzlBL3FTQldm?=
 =?utf-8?B?UXhuS21lblhHT0hLMEkyWDhVcTZxMWFBNXB4UUZQRGxiYTRFUGdwZ2J5UFlR?=
 =?utf-8?B?Q2o4MENhQVhBajM2bnMvRllSR3dyREI3aFh0U2gyL2wzbEFLSDg3djZyN0pT?=
 =?utf-8?B?UGM2ZldKZit2aFlza2RZMHNoT0IrckdHM1NjSm1Ecm9kdEc2ZWtwRzAzbXYv?=
 =?utf-8?B?RWlwdjhHSHB5L21hSkJSejVFY0RGMUZwR21CTFlrVzVWckdxNGFoak9pU3FR?=
 =?utf-8?B?TGZoYnBoZzlNOU50SVZHRnljMmhnQ2MzYmhoR2VCdU8rN0xVeVcrTXZmd1V0?=
 =?utf-8?B?c2pwYndQbkRlSTdVTXhvNUxmVjViYks4eENwVWxxZWNUdkFaeVhEUXZZc09E?=
 =?utf-8?B?R3liU1U2Q3JlaEQ2Z2RnWkJhc3lHd0hPZGlsWXlwNUEveVJIcENxbW5OMGhs?=
 =?utf-8?B?SGlGNGpKTWU2REo5bzEwNzFHRDNVRkovVG0wYzRWWitGQm0xMkhwYXlaNUxj?=
 =?utf-8?B?UGwvbWIyZ3NKa0RLVGN6RnptMlRQY0tsSXRBK3J1RVpYK2ozVFAxOTl3WjNr?=
 =?utf-8?B?NFJZNmZ1WEsvTmd6UjI2WlhZcFgyZXBxUzZwZVpCQnl6UlhEVHJRRmk5SllR?=
 =?utf-8?B?aEhUN21ONlIzZXJ0emR0SUZFR3IzaEJnL3VFWjN3bm80TUpqMUlqT3krY1BK?=
 =?utf-8?B?eUdneWl6ZlpoUGVQSUpSYW0xTS9FTDU4Rm16dC9wVE53NTRGQVJDeG1rVHQ2?=
 =?utf-8?B?UkMyblpHai9jS1lrZjZWQzVYU0dmZ1JzUDJBVjJjVXpPTWZJNS81QThnWVlL?=
 =?utf-8?B?djJZWG51K1I3OEs4MEcvOXFERmRuNTRlMGFTdFZaazBJMXdGbUlTdEo3TUZE?=
 =?utf-8?B?ZUd3WElzL0F1WVROd3FBY1RvTzIwQXJyMDA0c2VvZUJYOWVSN0tPV0pFblYy?=
 =?utf-8?B?WDcvZExVbkQxbVhXWEU2dHl1R1ZmM3VOb1ZzZFJOcFVGUGZtb2kraUhTTVA4?=
 =?utf-8?B?Q09mZ2NkblhBUVV6c0dBT1JNYVBzMThsL2s5enhUaWRQMlVMMUU5UDNFYkxO?=
 =?utf-8?B?d1lNZUN6MmNhZnMxSGZhWElOekVRRzArR3dtZ3hHcmpabm41TUxHZlFzMkVJ?=
 =?utf-8?B?S2R6NDBvaVY3TDg2YkkwTFNUL3lLVklBa211ODcvbTZqUnozMzZMbTk4ZzFR?=
 =?utf-8?B?TURhZ3k3TzBzSkUrNzRoalNXUUZ4aUFCV0MxSjlrM2JzSWhqTnlRQmpuZk5U?=
 =?utf-8?B?RzZLMU1Qdk9DVVoyTzRORFcvQW9GMnE5YVJoeGcvTEU2TkFYSUtsMHNpa2ox?=
 =?utf-8?B?d3RCblpEVDhoTXgvRmhRSm54Tk8vV3hCSzJzMXF4bEZKRThUNnltOEFWdXlP?=
 =?utf-8?B?WHp2RHpkeUFrSHQza29Sa2M2emltamxkR0JWQjM4amI5VG9RL2VsU3FtUUxn?=
 =?utf-8?B?RTN4dStOSTQ1UXFpSTZIbjh5TWNUTW9XRVdxcDdjSEJjdWFsVWdEZjlFNW0x?=
 =?utf-8?B?U1dhd0p2YXdBZC9VYk5QbmJSNTBFUS9xSjRmQ3p4UlM0M3ZoSGlaOGhNdWFG?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d35d5e53-d2d2-4f31-4373-08ddd6030368
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 22:37:38.8137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKTvceuRtDbLNeOBCtwoNEieG7qGAkdor0bWLv5g6nf9CwFhMlDXRXyzsWvMJX91k7klFCeRWJpTCr19TUMWA0cMOmeflIQ/NBSQfM2HhR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7307
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Thu, Jul 17, 2025 at 11:33:50AM -0700, Dan Williams wrote:
> > Link encryption is a new PCIe feature enumerated by "PCIe 6.2 section
> > 7.9.26 IDE Extended Capability".
> 
> > +++ b/drivers/pci/ide.c
> > @@ -0,0 +1,93 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> > +
> > +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> > +
> > +#define dev_fmt(fmt) "PCI/IDE: " fmt
> > +#include <linux/pci.h>
> > +#include <linux/bitfield.h>
> 
> Trend is to alphabetize these.  And I think there should be more
> #includes here instead of using other things pulled in indirectly:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submit-checklist.rst?id=v6.16#n17

In this case I think it was only missing a:

#include <linux/pci_regs.h>

...but more includes are needed in follow-on patches. Added those and
alphabetized.

> 
> > +++ b/include/uapi/linux/pci_regs.h
> 
> > +#define  PCI_IDE_CAP_ALG_MASK		__GENMASK(12, 8) /* Supported Algorithms */
> > +#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> > +#define  PCI_IDE_CAP_LINK_TC_NUM_MASK	__GENMASK(15, 13) /* Link IDE TCs */
> > +#define  PCI_IDE_CAP_SEL_NUM_MASK	__GENMASK(23, 16)/* Supported Selective IDE Streams */
> 
> I'm totally OK with dropping the "_MASK" suffix since I think uses are
> completely readable without it, especially with __GENMASK()/FIELD_GET()/
> FIELD_PREP().

Sounds good, and helps with the column width pressure. There might be
isolated cases of "mask vs value" confusion, but I think proximity to
FIELD_PREP()/FIELD_GET(), like you say, makes this clear.

