Return-Path: <linux-pci+bounces-32058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A51EB03AB0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 11:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494E03A2BE0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AB123D29F;
	Mon, 14 Jul 2025 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="On9ryfo8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E069720F08E;
	Mon, 14 Jul 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484892; cv=fail; b=InZ8ySTImqXugVVaIvofssYV0ROtlBwJOTPyA0pQpoxhvESzhfSzRLR5yDGPPG781tCxGuE++/R30Hi5osBNsoxVmzXYYcu8TjQlAEKfUrhpBVfr4WG4eHQ/7EYiFlrUbkaetASJk+UMjjataLuqpNDkLTE4aZsdwgdPxbrvHkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484892; c=relaxed/simple;
	bh=BA2GJ18yfPSPMFlQR5Ki7P0dF0VQhZOSy16kRdV27pY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LOcPJMo4vIN0s9VGFduqouEWEkvszQ7hNMovux3boWwXkU3O4Es4U3X8YDfd0NToJqSNlZyrrGz1CENBbAjIN7NG3i+E8zQAylNNcUvtgF+G+zcuvd0jUXeQHLr1S33YXumyQylOydwXDXpvIve99Ban+SeVjzRfdpbCvSzB5og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=On9ryfo8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752484890; x=1784020890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BA2GJ18yfPSPMFlQR5Ki7P0dF0VQhZOSy16kRdV27pY=;
  b=On9ryfo8Y2LCDEE5YTFnHVX1Q69V3c6R0BOquXgHovRslDphV3NF7Xtu
   go6RQu3XrVSr83/0XqiHZpcIXaTZBCdNovBCiN3n8c7zLI/X9vg60elm+
   JZcM5QdW3WaW3Mhk/siadeJK8zXQr509l6BnsodLgNH2dNTEfPPJxNgzf
   NLVnYOQBZTduojAm6T6zi2c7Z0/tkGdbys/VGSBlroLzpMmFnWsx+biym
   3gCTOAb2R+CDgYYjvN/8ngNmEqjuLYAJGQKEg1o1bRU3M11SPr7hhuEZJ
   CbryCCUmTokF1G5XQMZM/R9b508565beQ4bT+WGCvYWjzwSg+Z7M1e/T9
   A==;
X-CSE-ConnectionGUID: Pd74mIFCRSqW3s1cu/0ChQ==
X-CSE-MsgGUID: ba3Std9mREe4OTeursR0ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54383185"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="54383185"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 02:21:29 -0700
X-CSE-ConnectionGUID: IxqQ8BSAQE2wbCCtUuA4AA==
X-CSE-MsgGUID: cb+x4g+uR/qihFwPMLYKnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161217087"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 02:21:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 02:21:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 02:21:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.59)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 02:21:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlPCfa8d2/TPuM1boJqM9O4f6iISZOzJWXqO6IilStM1BYogT3aNfopo+YTWWcKdZqvanWGmzgsGMj3VBxNfH/8YwojLsjR/UkOrwQx2PS0zBnIMRk1tgELvU6ucvpMcSqP++mac0D9fLdwxy/0Az3B6C+/3HwoYzMi3BrXsApgXOPuTRa6ZA8DjolQTZBTZA9ETIWWqkRvFqM4iIhlJi3KQqzN9gC50zxaWtTYW27NxY4JOSoFP0/u5IS3XL2CBuiHy7Xg7hrsfZjJio9SwSuraDAg4mbt/SB28WWxJeqZ1KSNJ54aAxWDH0NzdJRk0eXN/AiN5NwqJR6CPzYzM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BA2GJ18yfPSPMFlQR5Ki7P0dF0VQhZOSy16kRdV27pY=;
 b=Z594dxjFKnEhzs/Vd2ZbqE0lXu+1O5ksJTvnvTWCLCUN9C8HgYwP8p4zcVa9er8VNOZZFKCpISwWdx344iUN/rgk6KMTuXjjfrlmdsnyoz1T4Kt3t8wEix1c6Vrr5BKbWEi4xafazPWR1xfZbUXlnsB7gVbHk8urX1gOQBuGsZNb0TsqEV8JYZwrkR/B4L68RsJzH/aIVtwTE2PuWGMr8kcG+HzOVbSZULMm8hdCCvCF43g1VS/5aa/BOE+ALjtvXY+Z5jpTeOHXMGddcglvR4QTor+8RvTqquoy05LBD3ncov4bsyRt5QFN+0jk+5F1iL/DS2gUWCXMwjZk3QXqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA3PR11MB9326.namprd11.prod.outlook.com (2603:10b6:208:57d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Mon, 14 Jul
 2025 09:21:26 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 09:21:26 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Hutchings, Ben" <ben@decadent.org.uk>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, linux-pci <linux-pci@vger.kernel.org>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>
CC: Laurent Bonnaud <L.Bonnaud@laposte.net>, "1104670@bugs.debian.org"
	<1104670@bugs.debian.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] Bug#1104670: linux-image-6.12.25-amd64: system
 does not shut down - GHES: Fatal hardware error
Thread-Topic: [Intel-wired-lan] Bug#1104670: linux-image-6.12.25-amd64: system
 does not shut down - GHES: Fatal hardware error
Thread-Index: AQHb80VyGD9Wd1+V6ESvvw6FPrMBu7QxWpHg
Date: Mon, 14 Jul 2025 09:21:25 +0000
Message-ID: <IA3PR11MB898660E9CAF3728B3544C6C5E554A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <89159d74-c343-480f-9509-b6457244d65d@laposte.net>
 <8a232a97-5917-41d3-8e88-e68abdc83202@laposte.net>
 <c40b5e6cb26654f698e51b131956065b952ad222.camel@decadent.org.uk>
In-Reply-To: <c40b5e6cb26654f698e51b131956065b952ad222.camel@decadent.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA3PR11MB9326:EE_
x-ms-office365-filtering-correlation-id: a3912b29-77a2-4745-6c6a-08ddc2b7cec3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YVNCajlORVZsNkJQclZKK1BUL253KzNZQ282Y3pKNVYybGRxajZYOGQzTFB1?=
 =?utf-8?B?dHNSaUZJMkhZbzhDdWJUTWU5b0Q4TmQxOHNuSlFkbEhYYXlqbUNpRzdTd0N1?=
 =?utf-8?B?bHpqa0FaaWw4US80eTRlZm1sTGhGVkw5VVRLQVhqWUFHci9XdERqM1N3OEkr?=
 =?utf-8?B?bmJWNWRxQm40K2Rlb3YweUlFRHlQNmJKVFI4VzUxaWRHWlpSNjdrdGhYaGRz?=
 =?utf-8?B?QVhrTGtzZG5FWkJCSEg3NytGM0l1U25wTTJUTG4vL3FLOHhBNGdJUzI0R1JN?=
 =?utf-8?B?ejVkTVhkcmd6Y1pKaEw2VWFGSGVsWlMyZXVMQkltQmllYjJKdUZGMHlacytt?=
 =?utf-8?B?Z2k0U3E5cld4NStxZUs0Y3REbDJyeFZmWEMwL1lZWWZHZlM0WVZtZGNRcWpH?=
 =?utf-8?B?aUhFSlNiS3p5c1A1NFhwZy8rK21XSFFuK0JTOGJ3RklNTWlrbGxqaVJienhs?=
 =?utf-8?B?eVlNRURnUUptLzhLN0xJNXpMWmRNNDFqK1BFaCtyeE9uYXEweFgwMUtVbWo4?=
 =?utf-8?B?M0lKZzhCbkxVWWo4L2x2OWJsMlM2TFdybjJ3WUh5K2YzMmgxRlhTRmZja0Iy?=
 =?utf-8?B?VHNVYlY4TC9ncEpEY1NBaTBIS1pzdTNYNkxRcU1Zb29NTTBSZGhlT2xYVitF?=
 =?utf-8?B?NEFLTUpiMjU1cWpEMFg2WGIrempibUNEOFVIVzVmeVdSWVl2aGRhMGt5SmtW?=
 =?utf-8?B?UFd1N3k3blFQZFRRYXMyekhqMnpmMmFLUGl1c2hyTnUrSTRrZ0x1ZEl2WDVF?=
 =?utf-8?B?bUVFU1RlNTdQVEx3MkpBNDJiTS8waE5oYnplNEFZbFJmZWFPRkJpajF1RnRI?=
 =?utf-8?B?YlJpU2hUOHBJWTlGcVA3SFlHcERGdzIxVVBjVHlGdjg0bG9WUzBOQ3FCSGpX?=
 =?utf-8?B?YmxvOXZwVXpqRk9SR0lDQStISDdHMzg4ajhKQ3I0RHRZbE9xT21ZY1VLZUx0?=
 =?utf-8?B?L1U1cE9LYlF1a1dpYVRxL2VMTm9qMG5Ib3NQNklDYko5MlBhUnN0Nlp4OXJV?=
 =?utf-8?B?Rit4R3pIcENJcWc0allWT0hNQXlJUk84b2VhQWlWRVRudE03cUZ2dmhNdzNS?=
 =?utf-8?B?amtLYWNEeUJvd0szeGZCTjAvQnQrVHVPcmRMakZaZFRuTjF4NWZ6OG5qYW9J?=
 =?utf-8?B?NU9vdk90UjBjRld1cXgveHRpN2NGV3FGYWhsblM4MEFSVXVCRzRVbXljRFdY?=
 =?utf-8?B?T2xKZkhLWWVqQUdKNVlwOEh3ck04WjlUMG1KME1GeFRkUVlvWElJQVBsUVNp?=
 =?utf-8?B?NjNwM09CSU5SSmwxdEtGeVExWHZQclJGMWpiMXlNK3pQaDBSTEgzU09GRjZD?=
 =?utf-8?B?UzR3ZU82WVRIdnNmTUlzbVlqNy94MEtyU3hoaDlQbjlhemNFMUtuNkNReTdz?=
 =?utf-8?B?SFhFNjhFdllCUE90SUhZUzZzOHFCK0p4N0tsb1BheW9Ick5VVmpROWRmK0No?=
 =?utf-8?B?bWpGNyt5VzNTUDVFMCtSekJjc2NHeVJSYWEweHozTllsZkVEcFJqeUc3RVJt?=
 =?utf-8?B?UGFWZ01MYnJaVFkwUGVaUklsQUhSdTc4cnVVZ20rSGNIcDVxcGF3VFZQYXpj?=
 =?utf-8?B?Q1V2SitaSllMYVUxbU12aCtncmdaQ2F4cjczdytwaTJraWZ2UEcvb01uS2s1?=
 =?utf-8?B?dzdrTUJ3d1FESWs3Yi9jTTJkd054djRocWV4LzI3SFFDSElPSmxiYTVuSlNo?=
 =?utf-8?B?aE9IUDg5NStNV1g1OXhCc001NjRuSXV2NFI5TTlZMWEzQWhlNmVGTmg5TmxO?=
 =?utf-8?B?cm9GS1VkN00wMjg3M0RyZUdoaXZ1b0VWRGxEYm9LZ3JUdFVIdVZ5MHl0THJJ?=
 =?utf-8?B?L1VQYkZmcHRoWlRUSjFQUGxnc3lxY0tsVnk3VHgxcDYvTW1zcDZDZWx2VXdR?=
 =?utf-8?B?TWVXWm1GS3dobmRhUjVtOStsY2NBUVZtZVFETlFBMlMzSkVJajJYMzFXMUdT?=
 =?utf-8?Q?EfcyHRqLGGh96gPZ8W7wMZisQL63EgUB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnBxNi8rZXBVZTNmQk1OM2tvWEFGZlZXQk9VM3pGVWQ4MkcvaGw2QVlrQndH?=
 =?utf-8?B?VzBPWExZQWRnZmxOZTRISDNMdktjNVR3dWZtNmo5SHk5ejBkY0YycE9tL3FC?=
 =?utf-8?B?TUlnQm1iVE91U1VLTWxnQWlMaUFteGFXeURoWEpyQk9iQWs5TG1FcE5tTnJv?=
 =?utf-8?B?MFo2NDFWaDZ2RWhac1RoWXoyVjBXc0N4U0s2MXZiZUI0SzVqVXpNelVBak1G?=
 =?utf-8?B?RC9tOWdybS9LS3N6MGFGU1RxcktsRUNldjdOQXc1Z2pDQVF6aERycW5lYmF0?=
 =?utf-8?B?T0NsQmMvZEVQdWExTmR4ZTFld1VlMVdqa1RvVUFUdnlkei9Cd3BiVFpCZ3VZ?=
 =?utf-8?B?NCtxMWNYekZBejZ5dFVqM3RIYWxtemp2QVpDZmJURnFSeGZzSGYxSkw3MG9h?=
 =?utf-8?B?NklXRnpoWXM3WDFsY1hoeUtrMnJ2K0NJb0ZuUFpXSlVGZnVqdVpJUDhyRVZk?=
 =?utf-8?B?MlVUTkd1UE5hTVhJbzhvYmhnZXV5R2FqRkxwM1Q4OTBRN3hvMUwwbklXeDc1?=
 =?utf-8?B?QmRWbFZVVUxpUjlDaDZWQU9FbHhYQnoycWtHU3NmMmJpQ1cvWG03YnA2aUNy?=
 =?utf-8?B?by80QnhSWHBrL2RuSHIrV0RFcFVucHA3NzI3MGlZRnloait5SHBMa2ZDenln?=
 =?utf-8?B?VWNsd05YNjVtYTQ1aEttVjk1eklNNlQ4UGdobzl0eWZCNlJQZlVoL3A2eFJz?=
 =?utf-8?B?YjlyeGZmQkFmT0x0bkhBaUlXU29Fa1NZS3ZISUMwTEZIT1A0RU1XcVZUa3c4?=
 =?utf-8?B?alNiWFZMaWxTc3ozWllySlA1WVhnWjg3WDlOSGdhbTJpTmxIWXErODAyMUZz?=
 =?utf-8?B?RGkrZXNHVEIrNEh5NTVMRFFQRFg5NHhON1daWGpPRUk4NTdCakpDUTVCa0NW?=
 =?utf-8?B?SnllelFqRkY3T1lWdGdweDdiTlNIZGJGa054d1V0VzN4TmxYb1VPc0dOdHNq?=
 =?utf-8?B?Wm52VndLdXdsb3VjYUdFcTFSSDBWRURJTlVGV0xxUiswRW13UkdrVzJ2WThO?=
 =?utf-8?B?bU5qL3FOU3lWcGVRVTJHYWdYa3F4QmVrejlPYkxOejhJMElaeFRMMTVZekpj?=
 =?utf-8?B?WEdYWUR4MzhEa080a3hUWGtja01pd3Ywa0pEdGx4eVN6T25UYk5xNUQ4L29l?=
 =?utf-8?B?YjNpU0NHU21XQnljYU9jcXdiM0hSZ3huenBFK2dwZnZGVDZ5WkZ3ZGZpT3FT?=
 =?utf-8?B?ZVNRaElQVjJTbjdpbXNGUXh6bWNBcE4rWTgwR0JoQjAzdnh2SzFrRE0wSXZy?=
 =?utf-8?B?VmwySjdTSVpmTVMySHozV2lSWmlJdmtPakFUdHRndXJtYW5aZm5IMnpxY0NV?=
 =?utf-8?B?Nm1vK0Ftc1ZObmxPSStQWEk1Mnlxb0c0a1U4OCs3Q2JhaXk3RWlvbCtQSHdB?=
 =?utf-8?B?SVUwdjAxVlFzWUxlblBVbU95dU9YcWRsczhlSGxRY1lzcG5NRW1raysxb3dn?=
 =?utf-8?B?UEpQNHpsenJUSi9OL1l4WFdEbk9JODVEQzNiY0NRNDlIcUlFVkJhVGxmZ0lY?=
 =?utf-8?B?ZlJrQ2IzYVhqR0Y3clZwdFdvYVpjOFRHdnJmQVM1UlFrYTJza2t4L2JCeXcy?=
 =?utf-8?B?endhcGFZcnQrZ0JSdHl4M3FtcXdQQWl6SnJWd3k3MlZLazh1a1VIMitPdGVG?=
 =?utf-8?B?WmNuakdZTHVDSGRNMDN5Y3VEdXRrbzNvYVgyTWkwbmlDU2hnemZrL2VDWjc4?=
 =?utf-8?B?TUU4TlNkbkpLRlZFeWpXRjZSWVlEbWYxL2o2cmltVlVuMjlNVzYvaHF3WURn?=
 =?utf-8?B?UGJ4aTVyeURmVVpEZHVneTJUU1lsdDMwaUMrWFhNeDQxTXQ5OUtOQmtXWk1v?=
 =?utf-8?B?RG81K3lmbWtmaU83dWxXN1QzWndJMGlNSjRnT0xWR044MW1sUncwZUZhQ3Rm?=
 =?utf-8?B?a0ZOSFNzdDRncm5xaitIbjdmSHVySDNYbDlBVFRjR1N3VDJOM1JrZFpxMStw?=
 =?utf-8?B?MHJudGJ2ME9pQk9uVDZJb0pyZGgrME9xZlE3R003MXA5Z1dpTmM2eGl6ZS9t?=
 =?utf-8?B?c1N5enZZM3JzUWRKQ1dzemhCeUY0a0xqdDhaR2xoTlhyVFNZelZ1UVQ5NlpW?=
 =?utf-8?B?MXZCMFduWnRWOFhKUFNEUXlGZUpiZWxaNSs3NXdPVnlhNFlmK3R5KzB0WXdK?=
 =?utf-8?B?akpocHZ1NXpOdEtaRUJudkVYUktvSzJaTnJGSzFZYXRFOUlsWUJIVDFWL1U2?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3912b29-77a2-4745-6c6a-08ddc2b7cec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 09:21:25.9844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /h9RDB39ZP/pv9Ku57PfKbXZYv9AwQl32IIr+di6p+mmb3vqrjMtytDO2ajyVklymXOIc8P/xbpdOG+Qgy7KyIVP/BfQeV31QkvYbmE+coU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9326
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgQmVu
IEh1dGNoaW5ncw0KPiBTZW50OiBTYXR1cmRheSwgSnVseSAxMiwgMjAyNSA1OjEzIFBNDQo+IFRv
OiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbGludXgtcGNpIDxsaW51eC0NCj4g
cGNpQHZnZXIua2VybmVsLm9yZz47IFBhdmFuIENoZWJiaSA8cGF2YW4uY2hlYmJpQGJyb2FkY29t
LmNvbT47DQo+IE1pY2hhZWwgQ2hhbiA8bWNoYW5AYnJvYWRjb20uY29tPg0KPiBDYzogTGF1cmVu
dCBCb25uYXVkIDxMLkJvbm5hdWRAbGFwb3N0ZS5uZXQ+OyAxMTA0NjcwQGJ1Z3MuZGViaWFuLm9y
ZzsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW0ludGVsLXdpcmVk
LWxhbl0gQnVnIzExMDQ2NzA6IGxpbnV4LWltYWdlLTYuMTIuMjUtYW1kNjQ6DQo+IHN5c3RlbSBk
b2VzIG5vdCBzaHV0IGRvd24gLSBHSEVTOiBGYXRhbCBoYXJkd2FyZSBlcnJvcg0KPiANCj4gSGkg
YWxsLA0KPiANCj4gT24gU3VuLCAyMDI1LTA1LTA0IGF0IDEzOjQ1ICswMjAwLCBMYXVyZW50IEJv
bm5hdWQgd3JvdGU6DQo+IFsuLi5dDQo+ID4gICAtIFByZXZpb3VzbHkgdGhlIGtlcm5lbCB3b3Vs
ZCBvdXRwdXQgYW4gZXJyb3IgaW4NCj4gL3Zhci9saWIvc3lzdGVtZC9wc3RvcmUvIGJ1dCB3b3Vs
ZCBzaHV0ZG93biBhbnl3YXkuDQo+ID4NCj4gPiAgIC0gTm93LCB3aXRoIGtlcm5lbCA2LjEuMTM1
LTEsIHRoZSBzaHV0ZG93biBpcyBibG9ja2VkIGFzIHdpdGgNCj4gNi4xMi54IGtlcm5lbHMgKHNl
ZSBiZWxvdykuDQo+ID4gLS0NCj4gPiBMYXVyZW50Lg0KPiA+DQo+ID4gPDMwPlsgIDk2MS4wOTg2
NzFdIHN5c3RlbWQtc2h1dGRvd25bMV06IFJlYm9vdGluZy4NCj4gPiA8Nj5bICA5NjEuMDk4NzQz
XSBrdm06IGV4aXRpbmcgaGFyZHdhcmUgdmlydHVhbGl6YXRpb24gPDY+Ww0KPiA+IDk2MS4zNjE4
NzhdIG1lZ2FyYWlkX3NhcyAwMDAwOjE3OjAwLjA6IG1lZ2FzYXNfZGlzYWJsZV9pbnRyX2Z1c2lv
bg0KPiBpcw0KPiA+IGNhbGxlZCBvdXRib3VuZF9pbnRyX21hc2s6MHg0MDAwMDAwOSA8Nj5bICA5
NjEuNDE0NTI2XSBBQ1BJOiBQTToNCj4gPiBQcmVwYXJpbmcgdG8gZW50ZXIgc3lzdGVtIHNsZWVw
IHN0YXRlIFM1IDwwPlsgIDk2My44MjgyMTBdDQo+ID4gezF9W0hhcmR3YXJlIEVycm9yXTogSGFy
ZHdhcmUgZXJyb3IgZnJvbSBBUEVJIEdlbmVyaWMgSGFyZHdhcmUgRXJyb3INCj4gPiBTb3VyY2U6
IDUgPDA+WyAgOTYzLjgyODIxM10gezF9W0hhcmR3YXJlIEVycm9yXTogZXZlbnQgc2V2ZXJpdHk6
DQo+IGZhdGFsIDwwPlsgIDk2My44MjgyMTRdIHsxfVtIYXJkd2FyZSBFcnJvcl06ICBFcnJvciAw
LCB0eXBlOiBmYXRhbA0KPiA+IDwwPlsgIDk2My44MjgyMTZdIHsxfVtIYXJkd2FyZSBFcnJvcl06
ICAgc2VjdGlvbl90eXBlOiBQQ0llIGVycm9yDQo+ID4gPDA+WyAgOTYzLjgyODIxNl0gezF9W0hh
cmR3YXJlIEVycm9yXTogICBwb3J0X3R5cGU6IDAsIFBDSWUgZW5kDQo+IHBvaW50DQo+ID4gPDA+
WyAgOTYzLjgyODIxN10gezF9W0hhcmR3YXJlIEVycm9yXTogICB2ZXJzaW9uOiAzLjANCj4gPiA8
MD5bICA5NjMuODI4MjE4XSB7MX1bSGFyZHdhcmUgRXJyb3JdOiAgIGNvbW1hbmQ6IDB4MDAwMiwg
c3RhdHVzOg0KPiAweDAwMTANCj4gPiA8MD5bICA5NjMuODI4MjIwXSB7MX1bSGFyZHdhcmUgRXJy
b3JdOiAgIGRldmljZV9pZDogMDAwMDowMTowMC4xDQo+ID4gPDA+WyAgOTYzLjgyODIyMV0gezF9
W0hhcmR3YXJlIEVycm9yXTogICBzbG90OiA2DQo+ID4gPDA+WyAgOTYzLjgyODIyMl0gezF9W0hh
cmR3YXJlIEVycm9yXTogICBzZWNvbmRhcnlfYnVzOiAweDAwDQo+ID4gPDA+WyAgOTYzLjgyODIy
M10gezF9W0hhcmR3YXJlIEVycm9yXTogICB2ZW5kb3JfaWQ6IDB4ODA4NiwNCj4gZGV2aWNlX2lk
OiAweDE1NjMNCj4gPiA8MD5bICA5NjMuODI4MjI0XSB7MX1bSGFyZHdhcmUgRXJyb3JdOiAgIGNs
YXNzX2NvZGU6IDAyMDAwMA0KPiA+IDwwPlsgIDk2My44MjgyMjVdIHsxfVtIYXJkd2FyZSBFcnJv
cl06ICAgYWVyX3VuY29yX3N0YXR1czoNCj4gMHgwMDEwMDAwMCwgYWVyX3VuY29yX21hc2s6IDB4
MDAwMTgwMDANCj4gPiA8MD5bICA5NjMuODI4MjI2XSB7MX1bSGFyZHdhcmUgRXJyb3JdOiAgIGFl
cl91bmNvcl9zZXZlcml0eToNCj4gMHgwMDBlZjAxMA0KPiA+IDwwPlsgIDk2My44MjgyMjddIHsx
fVtIYXJkd2FyZSBFcnJvcl06ICAgVExQIEhlYWRlcjogNDAwMDAwMDENCj4gMDAwMDAwMGYgOTAw
MjgwOTAgMDAwMDAwMDANCj4gWy4uLl0NCj4gDQo+IEl0IHNlZW1zIHRoYXQgdGhpcyBpcyBhIGtu
b3duIGJ1ZyBpbiB0aGUgQklPUyBvZiBzZXZlcmFsIERlbGwNCj4gUG93ZXJFZGdlIG1vZGVscyBp
bmNsdWRpbmcgKGluIHRoaXMgY2FzZSkgdGhlIFI1NDAuDQo+IA0KPiBBIHdvcmthcm91bmQgd2Fz
IGFkZGVkIHRvIHRoZSB0ZzMgZHJpdmVyDQo+IDxodHRwczovL2dpdC5rZXJuZWwub3JnL2xpbnVz
L2UwZWZlODNlZDMyNTI3N2JiNzBmOTQzNWQ0ZDlmYzcwYmViZGNjYTgNCj4gPg0KPiBhbmQgYSBz
aW1pbGFyIGNoYW5nZSB3YXMgcHJvcG9zZWQgKGJ1dCBub3QgYWNjZXB0ZWQpIGluIHRoZSBpNDBl
DQo+IGRyaXZlciA8aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQxMjI3MDM1NDU5Ljkw
NjAyLTEtDQo+IHl1ZS56aGFvQHNob3BlZS5jb20vPi4NCj4gT24gdGloaXMgc3lzdGVtIHRoZSBl
cm9yciBsb2cgcG9pbnRzIHRvIGEgZGVpdmNlIGhhbmRsZWQgYnkgdGhlIGl4Z2JlDQo+IGRyaXZl
ciwgYW5kIG5vIHdvcmthcm91bmQgaGFzIGJlZW4gaW1wbGVtZW50ZWQgZm9yIHRoYXQuDQo+IA0K
PiBTaW5jZSB0aGlzIGlzc3VlIHNlZW1zIHRvIGFmZmVjdCBtdWx0aXBsZSBkaWZmZXJlbnQgTklD
IHZlbmRvcnMgYW5kDQo+IGRyaXZlcnMsIHdvdWxkIGl0IG1ha2UgbW9yZSBzZW5zZSB0byBpbXBs
ZW1lbnQgdGhpcyB3b3JrYXJvdW5kIGFzIGENCj4gUENJIHF1aXJrPw0KPiANCkkgc3VwcG9ydCB0
aGUgaWRlYSBvZiBQQ0kgd29ya2Fyb3VuZCwgYnV0IHdobyB3aWxsIGltcGxlbWVudCBpdCA/DQpB
bGV4DQoNCj4gQmVuLg0KPiANCj4gLS0NCj4gQmVuIEh1dGNoaW5ncw0KPiBFeHBlcmllbmNlIGlz
IGRpcmVjdGx5IHByb3BvcnRpb25hbCB0byB0aGUgdmFsdWUgb2YgZXF1aXBtZW50DQo+IGRlc3Ry
b3llZA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLSBDYXJvbHluDQo+IFNjaGVwcG5lcg0K

