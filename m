Return-Path: <linux-pci+bounces-26608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC940A99853
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 21:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0126A7AE619
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677921F4634;
	Wed, 23 Apr 2025 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Unen0lTw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6634A2F32
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745435536; cv=fail; b=NEZdMVqf24tpRbp/yuE2b/Je/RbcGaz8Abpg8pHMgfcOlDzQ9GyLc0BLCZu7A5fiIOqV/KngzMFfljA69u/qgRX8w0/1tyRCTqJzmH7FNWlDoKlBAu9T29HlFKZnzgOaLhvZhmwnexiJnySeZCpzNnKK9z1zf4AlMeLoLicNpIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745435536; c=relaxed/simple;
	bh=klylKhbxHJzBS4KjjzXvD+jWb6EFY1ItKs6OWzgy0do=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F1vtAT2pJrN7drTa35L0gnHfIzLwDbYgUC+PfSydgeLuz1nhhty7/ht9Og98L5X+oTbck3Eqx4Mc5vnuGiDMBfJoLwQGuxh56zQJEQHmEjFkDiwd9xHjxYIlEPqFQX3nR0Erq28DczsMlXz8aYppdYSvryCYSBnqro5i2N0h/VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Unen0lTw; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745435534; x=1776971534;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=klylKhbxHJzBS4KjjzXvD+jWb6EFY1ItKs6OWzgy0do=;
  b=Unen0lTwkoFJQNjRFQESr829DrtHgiafyK7DSBfPbH4rFav8/M29hFKG
   RrIsUmOwRPKRARvol5bhLZ/D9gAw5LzVGAK3Wlgdk2Ahvv8q1i/IbEMRy
   U2kmsGe82ylC77FjRkk+t2VOhnAqrIfrJOWg0RBwG8CPiZ7GXlpW2GMk/
   DMb2/0qYsEdlsOz3eHVsykmEj99ch/yzJSQ2aJOxRpqxNVXhK3mxUJAt9
   WPvzuVEj0ZM7cFh1GLJzSqe+ZcCwoZV+kN8Xm9q/VsT6JsqOSpCPRqo5c
   W971/1uPOJOnqcSf6JZkWsVMxFHMsLa8izRVj1dj2xkf2aGOowc5yfsYr
   Q==;
X-CSE-ConnectionGUID: sLZqO65ES92JkIC67AniEQ==
X-CSE-MsgGUID: UnV2iH5XQz+lWn0wMYUsqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="49709204"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="49709204"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 12:12:13 -0700
X-CSE-ConnectionGUID: C1HtVT1nSvSTN8JaRBcP4A==
X-CSE-MsgGUID: TJnwZFIASCeeymBBqUjsXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132698682"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 12:12:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 12:12:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 12:12:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 12:12:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rT6QJS4IzWIRvh/RFFh2fIeGLFm8w3/6n7DQqCeS1flYMUc3fhT5P0Hlj3N59InID+WsvgLsohwttlgocicdIf3q8zlz94s9RSoyA+u6tSE3q34W/j80/dieWpW/Ip0WIU75Fh7qNF0uDlmEfmowxo23RvEE2q0pQNZkJ/0Qh4JnyJpS3vCDPYA81671AupEqZ7uJnIsJLO6OORhRuh5x/k6b92arIc29GPt94P39IOXB/XtSvw9QOZ15J82Lj0lZyXbUNiO5F2s6ngtAyAM2o/JbsJ/u7HAuYZcaeJ5BRUVqj/DV8NJtzLOvz/1isAtfDUV38hmX70yh3Q5Bnyl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9LtbuSLOW3mwQSRCosW+/BnoW9l8I8y+W9CHX+0fWU=;
 b=lyvRsQxsvZFo98KNnyBeOrFewdFC8EH8sar8xLmTAdsjfb0reLYdXjGL21FGSZ5XGjzEJuE7ltZKS3ACsfnlVLYYlS/vBEr5GeG6/MN6Li9XWekePJpgreEFc1oLrNiTUmM36x01skMA62ND55arrhvdFkmKvHfD4VfSxnkFs3RC7F/aI9VLJqwhrsgu3GrWRLhQCAncACXukQKkgH9siF+DbBadgggAmqKKwYxKYHzAtpIDhZpgON2zHNCT9ldPwYtshnsrGQXRM44d0K6pZAHqL0kO9E8gywQm1ALJG08RFzVIDwgcfXISU9pev7vcJcBQlNC0pFXyFf9adxVMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM3PPF31D2DA56C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 19:12:10 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 19:12:10 +0000
Message-ID: <f7831afa-6dd0-461a-8c3a-0b5095fb69eb@intel.com>
Date: Wed, 23 Apr 2025 21:12:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Explicitly put devices into D0 when initializing
To: Mario Limonciello <superm1@kernel.org>, <mario.limonciello@amd.com>,
	<bhelgaas@google.com>, <huang.ying.caritas@gmail.com>,
	<stern@rowland.harvard.edu>
CC: <linux-pci@vger.kernel.org>, <linux-pm@kernel.vger.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>
References: <20250422133944.1940679-1-superm1@kernel.org>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20250422133944.1940679-1-superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0063.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::16) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|DM3PPF31D2DA56C:EE_
X-MS-Office365-Filtering-Correlation-Id: 423cef19-5dc4-4cc7-3306-08dd829abf27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3J2NmZuQ3VzbGFVSTBqeDc1UjZHUVlDNGVpMElWS0I3MnBHZzhmbWlYVnhG?=
 =?utf-8?B?bmh3cjM1c0tjdWJrcHQ2T1hFaVFad2JsYnhtNS91dFdZM05mUjBVOGVoRkZP?=
 =?utf-8?B?UEwzdHIxTlJFRXZLbTZreGw4dlJLN2lEWXFleDIyS0c0ZVBEdnF3V3dHaXRn?=
 =?utf-8?B?RjkweDNDTFU5Qld0ckpobTV0UmlrbFVFcFJhZm5iMUc0YjdHaElqTjhyNTVM?=
 =?utf-8?B?V3BrdXl6Nlh6QXhOd25rQ3VGVHR0M0p1UUV6MVFNa3F6RTFVTDNvWm82a1Rp?=
 =?utf-8?B?N1VOMmhSMjFTYVROdGdwYXpWZ2F2VlB5YzRod2RZcEVJUHVtb09TQ25TTFox?=
 =?utf-8?B?Y1kzcEhXVGdDeEJOcFhjRlJ1dHl6KzUwdFZrVTI0eit3czVlMG4vemQxNFZ2?=
 =?utf-8?B?V1Rxdk5FRC8ya1pSQnp3TTBZVUx0byswcU9UbDh2Tjg2WWQya3VCdHhLK0lQ?=
 =?utf-8?B?cy9XRUhIcjA5elBab1FEempMRnZaU2xVUXBTN0ZzZlEyTW1IYjRVMGpUdkF4?=
 =?utf-8?B?dVJIb2ZPU3ZjMkxWZmNGcTRsRGlGU0FPSlBNbVZrbE1OdGIvVlhjc0VOY25W?=
 =?utf-8?B?T21TVm1JQVN1OWMvbTJzYW1idXRzZHdINTNSUmhoYUdBY0ovZStLK2xKeU1Q?=
 =?utf-8?B?UWxvb1JFUEFGTWdNZzVhSXZCa1h2ZTlTZzBTaXpWczVXeGZ3eXJFbkF1eW9Y?=
 =?utf-8?B?VDE3dDlNZ2xDVHhmQUhWVzJGOEJCOVFpVnUxUVgybk9WWmo5YXlmQ2gzalBn?=
 =?utf-8?B?K2pSL1pDYll1aFBHQ00yK0tnSWgrcHhwb2w5d0JneStTcnZUc1Uxc2JhcE9N?=
 =?utf-8?B?N2djUFgxOGROaXpKK0dEYWVQcUMrdmRhTm1NQW9INTJqZ083M3c4U3ZaZ01V?=
 =?utf-8?B?RGh2akQ5SSt6VU9vZTE1VmRkQlJjZDQ5dDhXT2lqcHN5UVZnbXlwWHJQSkZP?=
 =?utf-8?B?Y0NMdUFMQmVLQ1ZYTUdkczV0cnpYcml3dWE4VnZGbzhzWEllZ012WDltT1Bw?=
 =?utf-8?B?d3lqWTZZV3pPTmRDMmRKbEREMFBFeEpPNUZieGZGZkNGanN6U3M3Yk44RTJO?=
 =?utf-8?B?TExLTUhVQTdDa1JlRDNNNzVoaElnU1pmZjdrQWdsbGJzWThtMzl3dVpoMW5M?=
 =?utf-8?B?OUg3RUdsM1Q2SWRwZDcxVjhST2laRUFreStyUUdkK0lVamYwRFdqVDZtQzhp?=
 =?utf-8?B?MDdRcVNYUmUreXF4dVk4ejNiK21MSTNxUVpxTW1nRjBsRzlJTnhnYS9lWkZH?=
 =?utf-8?B?d0YxM2pBSU94bHpYREMzWmVvYmFiQkhmMVc4ZzR2OS9JWmZ6a0d1NU1KZlNi?=
 =?utf-8?B?Kzk1cEd2VlUvL1lwNnNONThPWFY3TmN2T0NUWHd0dWNRaGpxOStpUXRhSEZY?=
 =?utf-8?B?c1oyTy9uY1ZUazB5NjBaRE9meWhyTE9yZEYwbWNMSm5McXJidnVKSGlmbEN3?=
 =?utf-8?B?N29iNS84UXBzd1BaYzF5Vlc4a1dNL2c3WDRqTjBvdTFjMSttczJkZ3hCL0Zn?=
 =?utf-8?B?Ry8vUHJiQlFWaUNzZ1k1WkFFZ1Uxdk1RMWZkOTdid3RLSTVESVZPU1I0WkEx?=
 =?utf-8?B?SUtaZ0hrNWl0MFUzQURVdnJUbDIzU1E1MkpnSmk1OU5ZMjlxcmM0RGFYK2p3?=
 =?utf-8?B?dmtWSDJ0OVdsT0F5eDdwWGlaMWE0Q1o4TGhnUzV6Vkd0NXRvTVRZT3hQNG0w?=
 =?utf-8?B?R2JsUCtWcFVRNHBuck9TY3BwSEJ4V1I3aGNVL0dFYUpVcjYxQ1NmMVE3Q0NV?=
 =?utf-8?B?c1NjMXZhcHlkUnhMRlVTWGlucmI4UzlmdTR5NFl3UDl5U0hXZGlIV081dytY?=
 =?utf-8?B?eTdVMGtGTUdzd0RXWWFFZEY5dmlsL2F1QU93ajdQRFRrYWlCTmg1WlovaUNS?=
 =?utf-8?B?ZmZqVmRjcGhtZlpPUmp1UHdoTzZKRE93ZFRGUW80YWIxMXFuVDZLa00xOG1P?=
 =?utf-8?Q?qDRPmsqj9og=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2x6Nmg3RHRxbVVyZ2RMTjRWS3ovWW5URjNyR2lzSTFlVDNiMVlnOWFIYjJS?=
 =?utf-8?B?Sm9ZNzBURTlHbFRwUTVWZE9WS0lRSW83eS90eDkxTW50NktCdTFGNHFQaHoy?=
 =?utf-8?B?TlVrL0xoQXpMZXlFMHF6aUR4eTdzbXdpQVk1bDI1UFBuOVZYZW90OTJUcHlw?=
 =?utf-8?B?N1NPa0xvb1BHR3FncGI3WG9NelNBeXlpTGNiRnoxREJGN2NvWFdhUGgreFNE?=
 =?utf-8?B?NVR6WWNuc3VNcExhUE9LNzFPcE5xc1kyQkR5Yk9HWWU1OU91MjdtSERqZFJS?=
 =?utf-8?B?ejBscnlIWWFmR1VxY2FRcUwwaGt6N01oeWtTYkFLUGUyK1hxVVdHbXlZbUNX?=
 =?utf-8?B?M1gzaWo4SmNEY0lEUUdCQUR2elo4Y2Y3R3NqUjhnVG9ZWUNEZ1Q0NzdQc0wy?=
 =?utf-8?B?MDJSaTRUczFZK1M0QjNORUJYRFNtaXkzVHpTeWJDOXRnbmpqTm9WSFcxaHZI?=
 =?utf-8?B?R3hxV2wxS2VnMlpxWE5BVHY2N01OZUVIR1R5KzZwYVpObXRsU3JzNWpMYkR3?=
 =?utf-8?B?YnJZNXVKaHNadE93TkduaEo2eG5NZUh5RDZGVUQyY1FTaDZhL3lHSnliK1VH?=
 =?utf-8?B?K2U3NDdwWk9NV1ZlRmhBQVlHTDd1UHFNWUdwUUpManFCV0hleVZmczRtUTdq?=
 =?utf-8?B?eXE4MnFZUU5QU1A0cGxMMnBsVndEcHJrSjl2aUR4aEtZempXa2VKdWZlVC9O?=
 =?utf-8?B?VER2czdMNDh4QUsxcWxhZmlYZ2V1ZlA5eTMyMXg0eUw3QTc4NUdBQUttS0Vm?=
 =?utf-8?B?T1BueE1WWUR4RVJaSGJoa0FkMEg2WlEvUzA3UFF2cmFmZ3BBOWpQaEE2U01I?=
 =?utf-8?B?by8yeEM5R2xYTXIvd2ZBNUZrY2tjQTFyb1R1Ulc2dUxJZDJ6MDVwQlprQzBD?=
 =?utf-8?B?aFgwMXRwSTlIMDZaUVhFUitjaTA3UlpmSkxhcHJXZ3lLeW9xbDRLUnNhMXhq?=
 =?utf-8?B?UnZVQ0c5bURDQ3BFRUp6aVJGdEV0a25BSVk5eTZienlOT0V1NXJKd255aVNp?=
 =?utf-8?B?dlRGOTJ4QlIvZUorOVBEUVQ5SElEdEFVTkJkTE1SbnpmRmc3UzhSZGtxTWNl?=
 =?utf-8?B?NFRSbW5YUGdxekhqb3drek9sUXY5VHJjakljVW0rTG8wYmQzdm1VR3FMVjl3?=
 =?utf-8?B?Nmd4dlRrVE9BWWx6emhDUFNwTTAxUjRQQkZ3dGM4SjJOREZlV05TMTF6TE42?=
 =?utf-8?B?dEczSXpMenVJTi9UNWRNZ3FXczZpNVIreW9jNFFNWFdmdUMzQTkrbXhWMHV0?=
 =?utf-8?B?UjduVnBDWXZuYUpKRVprNTMwd2pudGtlbWIxVFZyVGxDRk5LZkpveXF4VlQy?=
 =?utf-8?B?YW14c2pUZDZDT3lPV0ppZ2FHcFJCaW40Y01SWVFBTDF5UW5ZbEpkSVFoMlQ5?=
 =?utf-8?B?QnFiSzl2R1I5RkVId2w5SUM2dmtFUFR4dm9hTjZRTnp5WTVtMHQwOHRMZG1o?=
 =?utf-8?B?c2FoZWdCRmFtSVppSW9oRENieUVlb3Foa3NzdjNiRVV6OGVMZklnZVB1N20w?=
 =?utf-8?B?MFhTNWdhS0JZMmkyL08rWkRYY1laRzdqQ3J4Z1BPUS9IaWdmNTZUcG4zZWNS?=
 =?utf-8?B?UGFJVTFnb2plRzk4bjlDcGtPYXJ4RCtkc0IvR0FwTnozcmlqVWlBbTVBNVFY?=
 =?utf-8?B?RDljOGJXOS9YRHFIWEwyN0phUVVEa2xaazN2MVhzM21pRnV3Vll2MWE4QWRa?=
 =?utf-8?B?dkxlbXlzVE84dkdYQ1NncnZoNjlKNlFTS01YTHFoMmVyN1JFSUo5NnRwNzRp?=
 =?utf-8?B?MkRscXF6b0tmTnY0TklXSjNuckI1b0FkTGJ2aVhtM1JWV3FlVVpTditKd0Fr?=
 =?utf-8?B?MmxNZ29HZktpN0xXZXhSTngwM0U5QjVRWVlEem5oaStNYk54MXpSeks5dExR?=
 =?utf-8?B?WFVLZUEwWS9yQ29JbzFLSGJUdlN4K3VxeE8vN1FsV1F6c3Rkdis5Q3QzN002?=
 =?utf-8?B?djVIYkFYZ1dTU2JRUFAxdW1ZamdiTjJybUhlY2xHU0ttdkRCUHQ4UmJneGcr?=
 =?utf-8?B?ZGJvcWgzY2o5VjZXR3pkaXY1Z2t5bDhBblhtMXMvNm5URm1yRzRJeU1LMUNE?=
 =?utf-8?B?T3d1aUlTem41TllpZnp2SGpMVTlDQVFtc0g5SU45akFabGtzZzRlN0ZJMnNi?=
 =?utf-8?B?MTJHNU52Rkw3UjZPNGttTnlrN0VRd2MwNGFPWDJjdVRxMThUNCtPdXl0TnUy?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 423cef19-5dc4-4cc7-3306-08dd829abf27
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 19:12:10.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PaZ9DIJjPu3ZSM8vI+ZBgWlDP3n3WWncDfJB2YQYfsTk2ybAbPeDxg99vzOyOufgQLf3u2xx8Qz+DAk5cSiu7dSCYBRIaBH7kVao6+TINQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF31D2DA56C
X-OriginatorOrg: intel.com


On 4/22/2025 3:38 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> AMD BIOS team has root caused an issue that NVME storage failed to come
> back from suspend to a lack of a call to _REG when NVME device was probed.
>
> commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-states")
> added support for calling _REG when transitioning D-states, but this only
> works if the device actually "transitions" D-states.
>
> commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
> devices") added support for runtime PM on PCI devices, but never actually
> 'explicitly' sets the device to D0.
>
> To make sure that devices are in D0 and that platform methods such as
> _REG are called, explicitly set all devices into D0 during initialization.
>
> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI devices")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Note: an earlier internal version of this attempted to do this in local_pci_probe()
> but this doesn't affect PCI root ports and we need _REG called on the root ports too.
>
>   drivers/pci/pci.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 53a070394739a..cd87c8370dede 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3266,6 +3266,7 @@ void pci_pm_init(struct pci_dev *dev)
>   	pci_read_config_word(dev, PCI_STATUS, &status);
>   	if (status & PCI_STATUS_IMM_READY)
>   		dev->imm_ready = 1;
> +	pci_set_power_state(dev, PCI_D0);

I'd rather not do this after enabling runtime PM, but at the same time 
doing it before setting up PM would be rather unsafe.

I'd move the pm_runtime_forbid(), pm_runtime_set_active(), and 
pm_runtime_enable() sequence of calls after the pci_set_power_state() 
call above.


>   }
>   
>   static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)

