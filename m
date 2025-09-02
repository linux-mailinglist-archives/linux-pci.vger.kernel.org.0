Return-Path: <linux-pci+bounces-35338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92479B40CEE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 20:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 788CA4E48E0
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 18:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B05734A30B;
	Tue,  2 Sep 2025 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RldtQcZG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D26346A0C;
	Tue,  2 Sep 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756836646; cv=fail; b=SzyeJIRjZZGoJbH7CR2uEAGHOhkMJL0L72gL+OFFRtzDMTuedlfJD+vnmZXcTO2dlOneDoJBIwdlZMZ8wUNoLWKcqdCHP5zx97wDgsioa7DRaZGJKnxJnxvUKa+BJ80M6IrCDUaL/WCurmx7cEpHdG3wCaBGCV61hXSGEirMP8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756836646; c=relaxed/simple;
	bh=RfmDq4ubLPuls51y2A0JV9pThwCFJ5jLXC1o7Pnvvsg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MhjaW5rwXKIUPzmj91xHEsxHC6XeCd1pkJq/nY2QL8HwH6NoEa05qdkTcUK4lxEjNvVuyS77RwmVzGiokcHP1N4uCaJDHP1htvt1L1FaPtyBfnTzi0dF/XMjb0XzqbJeBU283LXmQVQ5U+2a7o+RB6T+vkDDgXUQ2u3+s/5F4s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RldtQcZG; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756836644; x=1788372644;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RfmDq4ubLPuls51y2A0JV9pThwCFJ5jLXC1o7Pnvvsg=;
  b=RldtQcZG2sS3Pysi9zKA6Gc4SYA5vMqj5jM5KbM6iiQPp9+HimeZ6ohU
   nMdI5w62wnJyYYHoObUzMJ+M/SshdQl8OMBVGgf7osadf/2p3Y9wQYvIE
   6Db7MQFN3g1FTBPkshYQzbvxy99qbzVHaORxpqMVXH3PlBEFctgvBMBnf
   Ovi/lScEAfYSkBxog6AnWk8W1A3FiVefMTwcGqXJpKUfCYPOcdc08hU2a
   23SyexinoXnW5fc9wTgavimrHw7po+pzHg9jKbIY42XjOeiDw3rRPQ1pT
   ieoXhCrz2iJURpxf5+zPjbC2CoMtB5pILKA5ybiNd2xhzoTg8JlLkptnn
   g==;
X-CSE-ConnectionGUID: fCR8NJOGSfemEQfhYZ1e/Q==
X-CSE-MsgGUID: w2ImlUziQi2K0bgT3B0Ulg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58158921"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="58158921"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 11:10:43 -0700
X-CSE-ConnectionGUID: jMCtzwJVT9efRe/fg8gwsA==
X-CSE-MsgGUID: TRhbOyXxT4uuxVEK7SOGug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="175720957"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 11:10:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 11:10:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 11:10:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.71)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 11:10:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAuHk/e2ENAEUrznFIEEMlpGYqfP4L7JO1x7EuGFZv//qPh7zWLTltQe9gYBC2vmAOQ4zmmjrESmwvTXgRjHj49HcxKmOua4gpBvFeZN1pwid40kBARkYjTw98uAk07KwkzKNm3sdRmC6QLOC2OwY34TbHEUBodTRSfWv5uQAliJBys7jUgqHWPQVN6dsbxep5bDzc0GHpPPQQoehBbDbS/XN18JgoL1k7qQgAW/YKYzXO95MG8ecl+a/TrE507lpQAtdq93lUNGwbBYPxjZ3Ed3Td115JPKCOhMAi9MRsBKLBmhOMduFnZyMVrp7u2JA39pBe+foxWuKirbOSL5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kU0JjHfIH+Ddl4TkUGoBJfGiFFokMHJOpUcemoq6kp0=;
 b=cI5OC9bPbgjxtCAmi9sIScNAAB8ablHTgguOobgK8WKmdUBl3MkRNA1xoXLA2nQaeOWnMrWvZwJ3rWlOlW/VNV5JsEJN6lsLjnRMTZPPVDSujlSqh2dAuebYidNNBUlQZbDIvUqFhBwD85msBjM/WAsLgdvs9mxoTO8+52SjO+c126wvHYdbTYrLsrklUHlm2q8Bz7MZOuxElMW6cNVGmv7yVrqs9kTES6TTQi0GhB4vVLLonq9MUIloBx+Kd0+TPUUes26CY5FfhC/mm/q+0PBhUmmTJYIkTfXI5MJI+bznju43ocg2SYXivRG487gnzDXs2Y2T/vEKXBdA+59hWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8431.namprd11.prod.outlook.com (2603:10b6:930:c7::17)
 by PH3PPFBA2AA2BA3.namprd11.prod.outlook.com (2603:10b6:518:1::d46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 18:10:40 +0000
Received: from CYYPR11MB8431.namprd11.prod.outlook.com
 ([fe80::546b:dc38:a70f:1c27]) by CYYPR11MB8431.namprd11.prod.outlook.com
 ([fe80::546b:dc38:a70f:1c27%4]) with mapi id 15.20.9094.016; Tue, 2 Sep 2025
 18:10:40 +0000
Message-ID: <74c328b6-efdf-4592-b0af-6eae089f3a83@intel.com>
Date: Tue, 2 Sep 2025 11:10:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v3] idpf: add support for IDPF
 PCI programming interface
To: Paul Menzel <pmenzel@molgen.mpg.de>, Madhu Chittim
	<madhu.chittim@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<horms@kernel.org>, <linux-pci@vger.kernel.org>
References: <20250829172453.2059973-1-madhu.chittim@intel.com>
 <857bf36b-6bc7-44f8-bb5e-7c9460e4ef1c@molgen.mpg.de>
Content-Language: en-US
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
In-Reply-To: <857bf36b-6bc7-44f8-bb5e-7c9460e4ef1c@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:303:b4::8) To CYYPR11MB8431.namprd11.prod.outlook.com
 (2603:10b6:930:c7::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8431:EE_|PH3PPFBA2AA2BA3:EE_
X-MS-Office365-Filtering-Correlation-Id: b21d152b-ac62-4bbc-eae6-08ddea4c062b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGR6ZW1IRkV0alNBRjhteDE3UkxQQUFQcFBINHJNSmtYMm5kOGNWT3doM0hj?=
 =?utf-8?B?V3U2Vnc0TS9wUGdYTzdDZW9CU1RmZWtJZCtycGloS2ZHbURwSmcyakhQbTBH?=
 =?utf-8?B?OWdPbGtnRnd2cm1NSEN4elpLZlpQT2tndmZZaXdxN3p0dlB2MHl4bUNrTW5r?=
 =?utf-8?B?dGtQaWpHZERGanh0aWtERTdndFpuL0YvSHRsckJOYXBQL2ZtZDJIU2hqZTlC?=
 =?utf-8?B?dDRIVVJPdzZJL045QjRzbEZMSGdjcC9hTmR5ZjZMS3g2eHJWVWVOa3UxSitO?=
 =?utf-8?B?cXl0cjBQU0s0QVA5NGxkZDZBVTBNMjk4UWpISXlpbXNPYW9JUUpOUE1RTm83?=
 =?utf-8?B?dWx3U0VWalgzaW5uNm5rT28xbHRxL0QvNWgxYzFZQU5hNDhHQ0RodWc0eS9Q?=
 =?utf-8?B?OW40T2ZUeS9JaFI4V1A5bjFjcHFnc3kxZmRzSTZjT2FnOXR6ZlROQkpyRUNh?=
 =?utf-8?B?c3dIeG1kRzNXN2szZEx0L3Qwd1BhTzBCTlJFZlFpVHdmelkvS09SQnNMQ0VV?=
 =?utf-8?B?RmxSNGMxbUlCTHV2TTJsemhzclhJSjJ2ek9KZjdwcS81TGNNK0h0TnJiQ2x6?=
 =?utf-8?B?VTdPdFVpc2tOSXdxemVaVzZtSEFhajlqbXU1UzV1WmRPUjhOc2g1ZStudTh6?=
 =?utf-8?B?ZGtLQkdvQTVsMnlHc1pKUUJYYXBLZzUwWkVrS2Q5cGtxMGl1WlhtTWttOE1j?=
 =?utf-8?B?WmJZT1dteEpjOWlGV0UzYzJJWDE1aVRHTmwveWdWOWhadGVwZWVzMzNTakV0?=
 =?utf-8?B?UkRVc2dEVk9FQkI0YkZ2UEZBLzdhUm56ZkFpc1U1SUlsa2drOEZ6eFZlQ1ZG?=
 =?utf-8?B?ODMrcWxRbDd4T2xEU080M3lGUXd5SnFtQUgzcFRIYUpXdkJXMDhoOUR5cHJ1?=
 =?utf-8?B?bnZydThFT0ZsQzNieDQ0U0tMWHY2SjNCSTAxc1hNU0FyL3RtL2NDbStlSXo1?=
 =?utf-8?B?cmJLbytiV0JpVWRhZGZHdGE2R0NzdlBsRFZ5bXNOaWxNWFhSazRLNWJsUTFD?=
 =?utf-8?B?YzJKR1BtUXNqZjJaem9MdzE1MGlvQ3VnbXlpOTd6OWFHbkpjK1ZheUNqdDd0?=
 =?utf-8?B?OVMzYnU3SEQ3dmVnb2hhdGZselNJYWFUZ3JJR2ZpTjllSm4yT1hkUUFjYlNP?=
 =?utf-8?B?bEd1YXRRRG8vaDNtYWI3dkIreFVQN01ETXZtRVpnZENXZFVlTGlMazBJV1NX?=
 =?utf-8?B?bkswL1FKV1B0Ny9CQ05Sa0YxelVabDhMUllzcWZGODUyVkF2ajl6NUhtZ0tY?=
 =?utf-8?B?T1VMczZmT1Z6VjIxMVJGSHRiaDNuMmh0RUN0VG9DcmQzODE0SHc0WFBZTEFj?=
 =?utf-8?B?VEl6b1Vody8rNHhieGRaU084NXFOa0g3L2xnamw0YkdtYTFqTkEvRzN3MmRu?=
 =?utf-8?B?NU9oYzJQS3F3eUNXb0tYODc4bUNHdGtnUjBDRm9XL0pNc0IvdGE3M2djaXNG?=
 =?utf-8?B?TnQ5am00QzVoRDIrbHdLN2hWV256NGpaeDRleHA5c1gvS0pDb29RUGpNNmlU?=
 =?utf-8?B?eG5sWVZ3eFM1UDVrUTZHT2t3TWRUMWxKMFlCbGoxbDdsTlNSSmZuN3NONTlu?=
 =?utf-8?B?SHY1Ni9tQ1NEUFp0aWJLd2UxSzkzNG1PVzJCcGVMUWliekQxZkFLMkpsT3Rn?=
 =?utf-8?B?UE9lV0htZlI3cUJPK2tTTXcrYUo5R2JvNUlFeDlscklDTHl2RFg1TmpnRVJY?=
 =?utf-8?B?MExyeCs1WGl6QkpFUXE4NFBwcVlFSnJVcnZ2ME1XQmRNTTdPVjBLUThoZVIr?=
 =?utf-8?B?VkJ6b3lORGlMbGx2bmY0Y3djQ0FpQUorODg2dE12ZG5qTHJVM3c1SDYxOVFZ?=
 =?utf-8?B?NVRRSFkxTVJoZXdMeE1KSkxuK2EzMGdrTU5VWjE5a2QxVWs3K2QvdmFiN1Zp?=
 =?utf-8?B?UW9QbmNvREw1K0xJeGV5aWNDZDVpYkRyeTE1WjhldEVTYVZaMUFBTXNHREZP?=
 =?utf-8?Q?BzOQSj0+TZg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8431.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5Nc3VZalk0RTBaZjFpd3F6TzdONkxPdEVoSFpPTFNWTDhNYjEzYVZFYnhR?=
 =?utf-8?B?Kzdsd3lUWjVtejAzeWRWSmovSG83Y1RVcDdyTXRrcE4raVJiY3pLSGhML0hp?=
 =?utf-8?B?Q2d5a0kwOWhPVHV5UnNTUUlseTUvR0EwczRVWkIwZ0hIUk9BajlFV2NvZk5k?=
 =?utf-8?B?c08zeTZHS3E0ZnFpeXpvK0VacHZTK2c4WTB2Sy9GeWxJL1o3dm9vdlZVUitS?=
 =?utf-8?B?YzUrbzNidytHcktvbE1IYnZ2MmxzZ3FzcGVIYXRIWlhIVnJ6eUpyUHU2bjhI?=
 =?utf-8?B?N0VLM3hGNnFMaE5pR1FnQ2Z2SGxUUE43TUVhelRBWmFhYmEyVGdYek9yTzJi?=
 =?utf-8?B?K2ZWYWkrZVZqVWZ2Y0xsZUQveDYzYUFGT0F5Q1RVZmFSVldxVWhCZi8yZE5k?=
 =?utf-8?B?VVdCVVlOQm1iWW9kZkdyUzFaOHZUYXlMeFppR0tqL21Jakc0aU5TTlJwRWpP?=
 =?utf-8?B?Qk1CWTY3QnBybG5GTTNpcFV4OW5Bd3BoSDdEbXduTnA1UjgydWpYU0xSVFdw?=
 =?utf-8?B?TmxpZ2owVXJ1NXc0dERzYzNOZHgzaHRHUU1TM2dwOTNxRzZWdncxWG1ZNEpO?=
 =?utf-8?B?RWlFeEkxSXVhUm1NdUd4VlhjdCtwb3N0OHBaVXV3U0ZHTHRXbmJUV0h4SGhX?=
 =?utf-8?B?VG5kSEFjMUNlQithb093NXpZTFJtdm1zQndvK0RPSHZmbWtMelhRUGZRbU1N?=
 =?utf-8?B?TFk4Q0dqb2FMa2VpNmZFODFuVnFkeWhXTUgzZEk0OTJTV1ZCaUdXYUZ3UU9r?=
 =?utf-8?B?ZjdPZldkZ1p2YXBGbHhNLzdFamh6bDVQM3BhS21EamRCTjh3dUNNeFZrdExn?=
 =?utf-8?B?YVNncytJUHVEbnFMRjJIUFo5UzV4M1FycW1nTGV2d1YzWjVPbGhJRWdyL1po?=
 =?utf-8?B?MkhiVXVJK2ROaXRma0pLaGxveGNRcVUySDRJaWRFd1p1U0JQc0U1TG82VDc4?=
 =?utf-8?B?elJTcWx5dVhUbVFyMjJwR2ZwTTk1ODY0cWlxZmVRcFJmWjFZVXN3SDB1K2JU?=
 =?utf-8?B?WVY0Y2Q3OGttdkZRME1RM0V3QloxQVg4T1pxaG00RlhWK2JWUVRRWTJvbWZI?=
 =?utf-8?B?TS92T2Q2dlZXeTF3V0NkbXZLUDBTVS84RVN2MzdTbVpTUENiSTBrOHRxN0wr?=
 =?utf-8?B?SU1zdHIwUEJobnZSazVzYURGOGN6RkhzTk9zQXRMRmd2d2dpNng5MmtqT3ZW?=
 =?utf-8?B?MDUwbjJwdW1hUzhaVVdRbzRZN3dXNEZKLzJ0elhSZDRoenJ2Rkp4aHZ2N0ZQ?=
 =?utf-8?B?R1I0STJXaVIxZEl3YlFJUlIxZzE0ZGpHVlVuSm81M1ZhN3lKODJYTEcxeGVO?=
 =?utf-8?B?ZTR6R1BZRDNKZHJXOTkzdDN2R2M4b0ZjYTB0UUhKQlRFL05YMzh3NjZaOVht?=
 =?utf-8?B?d0E3UTNrTHlxM0gzdFlsTEd4bDIvSW00enMyRlV5czJnbUlOY3JTRkp6M3gv?=
 =?utf-8?B?UkV2ZmdGeDdDVURRa05UQ3pCWHF1NUkweURQVEtKNDNsLzRQTGluU1NQNTR2?=
 =?utf-8?B?NHJvcE1zaG9QclNJYlA0aUpsN0N5cHQrSjBaNklLRldyZEd0UlUvcWs5QWk5?=
 =?utf-8?B?Tk1uUUFXRDZZOGtkOVFaTkxteC9yRzludXc5UDZHZitIUmVSWklaWDJ3ZWQv?=
 =?utf-8?B?a3hkUDF3V24wemw2b2pJQ3RWMkR2WEJQSmlmN09jMHJhN1N5cE1SbG9VUVBk?=
 =?utf-8?B?YzNjb3BzYzRDNjN5ckI1eW16UkRibzQzRitRMTdxOHdHVTN0aTZ6VDd4OFdK?=
 =?utf-8?B?MEt4L0pIMmRHdC9nZDc3WU5abk9oalVBczY0WWd0Ukg4R3VqaGVSRXpyRlBQ?=
 =?utf-8?B?aExmcDd5eXhuRGpSaW1ndTZEWCtpMFFhUXM3MWNqekhDaHcyVlByc2w4R0kr?=
 =?utf-8?B?WGlMb1JLNS9SdFVFTFcvalZVdE9EaVRzcXlaeGVrQWlNa2IyajdrZ3Vmd09N?=
 =?utf-8?B?NU4wQnljakk5SnByb0VpRnJ2cCs2WWdacng3cW5zT014bE4zdThRMkVlY3lp?=
 =?utf-8?B?K0pnaGJBM2lMUldiRU41MHFMcGoxdm5ESkVDaXZaZld0MXdYa01aVXBmbDNN?=
 =?utf-8?B?TTJPT0gwZGY5Z2FLWFBva1pMNlorR0dzTi9tbUtNSSthMHlBVmtKdXJHR3J0?=
 =?utf-8?B?cDNHQUIwVzhDYlAySnZ2ZUQzV2ZrVks5L1hzeFAvV2dJSUgrVk9zREc5UHRZ?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b21d152b-ac62-4bbc-eae6-08ddea4c062b
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8431.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 18:10:40.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fhu+A/jGkd9ryBPxBueyK5XHEXY1wLeClqkUQOAf7EkBy7mHuXVtBLwDb2rcMQseWxUvfS7wzc7OrPuLK/S15sLCFqwAnsgtbRI8dnltZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFBA2AA2BA3
X-OriginatorOrg: intel.com



On 8/29/2025 3:07 PM, Paul Menzel wrote:
> [Cc: +linux-pci@vger.kernel.org]
> 
> Dear Madhu, dear Pavan,
> 
> 
> Thank you for the patch.
> 
> 
> Am 29.08.25 um 19:24 schrieb Madhu Chittim:
>> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>>
>> At present IDPF supports only 0x1452 and 0x145C as PF and VF device IDs
>> on our current generation hardware. Future hardware exposes a new set of
>> device IDs for each generation. To avoid adding a new device ID for each
>> generation and to make the driver forward and backward compatible,
>> make use of the IDPF PCI programming interface to load the driver.
>>
>> Write and read the VF_ARQBAL mailbox register to find if the current
>> device is a PF or a VF.
>>
>> PCI SIG allocated a new programming interface for the IDPF compliant
>> ethernet network controller devices. It can be found at:
>> https://members.pcisig.com/wg/PCI-SIG/document/20113
>> with the document titled as 'PCI Code and ID Assignment Revision 1.16'
>> or any latest revisions.
> 
> Could you please add some information, how you tested this?
> 

Thanks for the review.

I verified the changes in this patch by loading the driver on the 
existing hardware which supports the 0x1452 and 0x145C device IDs and 
new hardware which supports IDPF PCI programming interface.

Sure, I will add this testing info to the commit message.
>> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>> Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
>>
>> ---
>> v3:
>> - reworked logic to avoid gotos
>>
>> v2:
>> - replace *u8 with *bool in idpf_is_vf_device function parameter
>> - use ~0 instead of 0xffffff in PCI_DEVICE_CLASS parameter
>>
>> ---
>>
>> Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> 
> This looks like a stray line, but will probably be ignored, when applied.
> 

Will fix it.

>> ---
>>   drivers/net/ethernet/intel/idpf/idpf.h        |  1 +
>>   drivers/net/ethernet/intel/idpf/idpf_main.c   | 73 ++++++++++++++-----
>>   drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 37 ++++++++++
>>   3 files changed, 94 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ 
>> ethernet/intel/idpf/idpf.h
>> index c56abf8b4c92..4a16e481faf7 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf.h
>> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
>> @@ -1041,6 +1041,7 @@ void idpf_mbx_task(struct work_struct *work);
>>   void idpf_vc_event_task(struct work_struct *work);
>>   void idpf_dev_ops_init(struct idpf_adapter *adapter);
>>   void idpf_vf_dev_ops_init(struct idpf_adapter *adapter);
>> +int idpf_is_vf_device(struct pci_dev *pdev, bool *is_vf);
>>   int idpf_intr_req(struct idpf_adapter *adapter);
>>   void idpf_intr_rel(struct idpf_adapter *adapter);
>>   u16 idpf_get_max_tx_hdr_size(struct idpf_adapter *adapter);
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/ 
>> net/ethernet/intel/idpf/idpf_main.c
>> index 8c46481d2e1f..493604d50143 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
>> @@ -7,11 +7,57 @@
>>   #define DRV_SUMMARY    "Intel(R) Infrastructure Data Path Function 
>> Linux Driver"
>> +#define IDPF_NETWORK_ETHERNET_PROGIF                0x01
>> +#define IDPF_CLASS_NETWORK_ETHERNET_PROGIF            \
>> +    (PCI_CLASS_NETWORK_ETHERNET << 8 | IDPF_NETWORK_ETHERNET_PROGIF)
>> +
>>   MODULE_DESCRIPTION(DRV_SUMMARY);
>>   MODULE_IMPORT_NS("LIBETH");
>>   MODULE_IMPORT_NS("LIBETH_XDP");
>>   MODULE_LICENSE("GPL");
>> +/**
>> + * idpf_dev_init - Initialize device specific parameters
>> + * @adapter: adapter to initialize
>> + * @ent: entry in idpf_pci_tbl
>> + *
>> + * Return: %0 on success, -%errno on failure.
>> + */
>> +static int idpf_dev_init(struct idpf_adapter *adapter,
>> +             const struct pci_device_id *ent)
>> +{
>> +    bool is_vf = false;
>> +    int err;
>> +
>> +    if (ent->class == IDPF_CLASS_NETWORK_ETHERNET_PROGIF) {
>> +        err = idpf_is_vf_device(adapter->pdev, &is_vf);
>> +        if (err)
>> +            return err;
>> +        if (is_vf) {
>> +            idpf_vf_dev_ops_init(adapter);
>> +            adapter->crc_enable = true;
>> +        } else {
>> +            idpf_dev_ops_init(adapter);
>> +        }
>> +
>> +        return 0;
>> +    }
>> +
>> +    switch (ent->device) {
>> +    case IDPF_DEV_ID_PF:
>> +        idpf_dev_ops_init(adapter);
>> +        break;
>> +    case IDPF_DEV_ID_VF:
>> +        idpf_vf_dev_ops_init(adapter);
>> +        adapter->crc_enable = true;
>> +        break;
>> +    default:
>> +        return -ENODEV;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * idpf_remove - Device removal routine
>>    * @pdev: PCI device information struct
>> @@ -165,21 +211,6 @@ static int idpf_probe(struct pci_dev *pdev, const 
>> struct pci_device_id *ent)
>>       adapter->req_tx_splitq = true;
>>       adapter->req_rx_splitq = true;
>> -    switch (ent->device) {
>> -    case IDPF_DEV_ID_PF:
>> -        idpf_dev_ops_init(adapter);
>> -        break;
>> -    case IDPF_DEV_ID_VF:
>> -        idpf_vf_dev_ops_init(adapter);
>> -        adapter->crc_enable = true;
>> -        break;
>> -    default:
>> -        err = -ENODEV;
>> -        dev_err(&pdev->dev, "Unexpected dev ID 0x%x in idpf probe\n",
>> -            ent->device);
>> -        goto err_free;
>> -    }
>> -
>>       adapter->pdev = pdev;
>>       err = pcim_enable_device(pdev);
>>       if (err)
>> @@ -259,11 +290,18 @@ static int idpf_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *ent)
>>       /* setup msglvl */
>>       adapter->msg_enable = netif_msg_init(-1, IDPF_AVAIL_NETIF_M);
>> +    err = idpf_dev_init(adapter, ent);
>> +    if (err) {
>> +        dev_err(&pdev->dev, "Unexpected dev ID 0x%x in idpf probe\n",
>> +            ent->device);
>> +        goto destroy_vc_event_wq;
>> +    }
>> +
>>       err = idpf_cfg_hw(adapter);
>>       if (err) {
>>           dev_err(dev, "Failed to configure HW structure for adapter: 
>> %d\n",
>>               err);
>> -        goto err_cfg_hw;
>> +        goto destroy_vc_event_wq;
>>       }
>>       mutex_init(&adapter->vport_ctrl_lock);
>> @@ -284,7 +322,7 @@ static int idpf_probe(struct pci_dev *pdev, const 
>> struct pci_device_id *ent)
>>       return 0;
>> -err_cfg_hw:
>> +destroy_vc_event_wq:
>>       destroy_workqueue(adapter->vc_event_wq);
>>   err_vc_event_wq_alloc:
>>       destroy_workqueue(adapter->stats_wq);
>> @@ -304,6 +342,7 @@ static int idpf_probe(struct pci_dev *pdev, const 
>> struct pci_device_id *ent)
>>   static const struct pci_device_id idpf_pci_tbl[] = {
>>       { PCI_VDEVICE(INTEL, IDPF_DEV_ID_PF)},
>>       { PCI_VDEVICE(INTEL, IDPF_DEV_ID_VF)},
>> +    { PCI_DEVICE_CLASS(IDPF_CLASS_NETWORK_ETHERNET_PROGIF, ~0)},
>>       { /* Sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(pci, idpf_pci_tbl);
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/ 
>> net/ethernet/intel/idpf/idpf_vf_dev.c
>> index 7527b967e2e7..09cccdf45b50 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
>> @@ -7,6 +7,43 @@
>>   #define IDPF_VF_ITR_IDX_SPACING        0x40
>> +#define IDPF_VF_TEST_VAL        0xFEED0000
>> +
>> +/**
>> + * idpf_is_vf_device - Helper to find if it is a VF device
>> + * @pdev: PCI device information struct
>> + * @is_vf: used to update VF device status
>> + *
>> + * Return: %0 on success, -%errno on failure.
>> + */
>> +int idpf_is_vf_device(struct pci_dev *pdev, bool *is_vf)
>> +{
>> +    struct resource mbx_region;
>> +    resource_size_t mbx_start;
>> +    void __iomem *mbx_addr;
>> +    long len;
> 
> Use size_t?
> 
>      include/linux/ioport.h:static inline resource_size_t 
> resource_size(const struct resource *res)
> 
> 

Will fix it.
>> +
>> +    resource_set_range(&mbx_region,    VF_BASE, IDPF_VF_MBX_REGION_SZ);
>> +
>> +    mbx_start = pci_resource_start(pdev, 0) + mbx_region.start;
>> +    len = resource_size(&mbx_region);
>> +
>> +    mbx_addr = ioremap(mbx_start, len);
>> +    if (!mbx_addr)
>> +        return -EIO;
> 
> Should some kind of error be printed with a hint, what the user could do?
> 

Sure, will add a print here.

>> +
>> +    writel(IDPF_VF_TEST_VAL, mbx_addr + VF_ARQBAL - VF_BASE);
>> +
>> +    /* Force memory write to complete before reading it back */
>> +    wmb();
>> +
>> +    *is_vf = readl(mbx_addr + VF_ARQBAL - VF_BASE) == IDPF_VF_TEST_VAL;
>> +
>> +    iounmap(mbx_addr);
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * idpf_vf_ctlq_reg_init - initialize default mailbox registers
>>    * @adapter: adapter structure
> 

Thanks,
Pavan


