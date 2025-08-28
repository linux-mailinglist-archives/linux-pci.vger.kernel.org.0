Return-Path: <linux-pci+bounces-35051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CA9B3AAE2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 21:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC3B1892A5E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 19:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205382652A2;
	Thu, 28 Aug 2025 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjFvU8gv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC9F217654
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409240; cv=fail; b=ix+MnT6A2/PNjPKzD3wKycdPiGjnqinJjmlrZE3Ux7tYMHcwnU/6TIrQROYAWMK2Fv/Y6oQk/fCeEPXnvcAEZr5FkSJ/fknnk/deqb1zTBBJpTber9duW/mm0jCqj+Vy26YJsENRA3JAMgBafdbanBZH0Z62kRJ0jUN4Qv1rNW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409240; c=relaxed/simple;
	bh=nxkzZnprod5rA2uraVAhTYu+oZlQuJ0eVf1jIM2aGvU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=OsidKN160YDD7qUmF6DcAPSYYcQRfa2Te5JssoOBY2P1ucFhp0mSyvoPNl04i+zLIKAQlbv0jLWpAbVfMUJwcT6BPTxsuAULSdqSQlIEp62WQduff4vz/+CxCc5xbR5DQkrdwaDmgZIUzxyMozriMlNAroqKNb3kiRSuzi1PzOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjFvU8gv; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756409238; x=1787945238;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=nxkzZnprod5rA2uraVAhTYu+oZlQuJ0eVf1jIM2aGvU=;
  b=AjFvU8gv4iXhSEwvJVXbiabv09VWuJ2m+S37HdmKy3kyTpub0Urlqgv1
   pvLK/Odpfe5rtMSl0lHjEQjJRpw4oe8KUdCyJOOFuiz5aJOFsIdHoE6hZ
   +Yy6XWsjSSqTDXG8zqUGRYs6w46gFgyCeFBjzAHhxSTYea7c5uE1KkqPr
   ZK5x1vIUO4HlNMBgQ9alp/YP3OSabRp9innLGjsmlKRaFXRWOJBeuop7d
   vgOG2HiB1C6itLGTZbiAPNMsqotsSsYbdJFhGQDYacSiz5WgsKRXRKkQY
   tdlbRAkQzPX9pWD1TTSAHI1y1ElEWwa7gil44XbR0ZpHp/T8fp9Njuv5V
   w==;
X-CSE-ConnectionGUID: 67dw4qDMQ5K8Nn8Wu3RYTw==
X-CSE-MsgGUID: FuKO2pkGRVepTclfy8zxCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="68968352"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="68968352"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 12:27:18 -0700
X-CSE-ConnectionGUID: RCtaf044QtW1ibnilfmWPA==
X-CSE-MsgGUID: hqdr+dMGQ7unAD0eh/ENKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170101000"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 12:27:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 12:27:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 12:27:16 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.74)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 12:27:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFOQ+IcXYXo6TRyWMvOFr/yFgs1GIVC8u5jq5Oe+OB6fxtl+u+SiLSM0gYDP6hIsAg80cZPPQ4Ie1PnGDiLseZQRFhlBqDr6jA/snYPw8vCF49tM8tzyay2liZA7UFz67AGsF+5YGDgxYx7wHUJ/imLwhCURqZWnzFRf+oHNR6LjTvEsSVKAX1xWNc/EU2EdIJijHpQ/T+TFvgGW5oPSz9Pl5Jx21+gYUAV5FdS6PFEgqop4PKIcsKi64/wUWMb4ysTmlPh1Er1StlKt8dINq8aF1euLK3kNbKrqOp9OGdmrE6SFm2aNGSSyRQ0X/oylqltB1B26eenNpzbaU+sIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Moo7PEIB+/wbAOBrHmPIK8c4iukFa4gARSkk06eho9M=;
 b=Wi6mFTeCDUOMPUl0ulZaBPJrrXfl8mi2Ja60fdNpsMLurMW7VFEdWn+HcaeA+4yKJ/Jwc9xIpjnOlWe2BPiKtSfr1nTeV+Glg88Hf4GNpuRhPL3buVLWKelRVq1St1QBtJ3N2Oz1YFFWvwjzEnmJwAdpH1C3YXfnNKWuYA12ELgO2tPnMXmX6rAB8NlvkdqYtRE2k07mkFGfG6kDLwx54k0s5AtvULqy0E/z8BBxniCLmV95T0FUJNsI0/iEbC4+Nb7rqTrRxBGOJpz22I4EkkPxXqshCt7T7807cWCR1bjEn+576bYMm6cA8IZ0qUX61l+qEqql/rTvuo9bQCMYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7483.namprd11.prod.outlook.com (2603:10b6:8:147::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Thu, 28 Aug
 2025 19:27:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 19:27:10 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 28 Aug 2025 12:27:08 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<aneesh.kumar@kernel.org>, <suzuki.poulose@arm.com>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Message-ID: <68b0ad8c4e24e_75db100e6@dwillia2-mobl4.notmuch>
In-Reply-To: <e35667f8-f1bf-4cd4-bb2c-b854c8f59d0e@amd.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
 <849c12a9-f801-46f8-8fff-09fbc259843e@amd.com>
 <68ae491e1348a_75db10072@dwillia2-mobl4.notmuch>
 <e35667f8-f1bf-4cd4-bb2c-b854c8f59d0e@amd.com>
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR08CA0072.namprd08.prod.outlook.com
 (2603:10b6:a03:117::49) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cfff87d-c104-475f-e53b-08dde668e1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TndQZDRoNVZNQjVpTVBVbnhac00rR1ZGL3JVQ3NpQTdMUXhqZXJEOHBmK0VW?=
 =?utf-8?B?djhMK1h5eHc4a1JiRVh4Vm9jL3BqZ241MUtrZWxQK25KUkxGMk5FejNRam53?=
 =?utf-8?B?VjVmQndRZ3ZVNy9GV25hWllDc1hxb0lhRzFaT1BqL29GMktBYzZucWFBWkJp?=
 =?utf-8?B?eTZUOGJ6NDI5a2pBY09XUzBZL1N1K1hybXZvRTMyalB1cEJmblY4RkZlTE8w?=
 =?utf-8?B?RGFQVUlURnEzZUFyYWFseXFlMTFiZzZCRnlDVjlXb0lRNVZHTVZJbHQxOVN0?=
 =?utf-8?B?SzNrcDQ2WDhMQmxaRnhaUFdiVHVXZDNuVng2VXk3NE5DajRBMTBTY3EwZ0ln?=
 =?utf-8?B?dGlHUDN2Rk5ZZEF5aE1wWnJpN0p2QksrdnFFYWIzeVp2Z1NaaEFNbWswOWZD?=
 =?utf-8?B?UjZmYnQxOENFZTBQaVBIUHJET2swNzBveTRZeDF2TmxqSnNsSlZ6Tk1TbUVJ?=
 =?utf-8?B?OFpBN1M2Tk5RYXdQTzJRMDBtQ1ZyYWZlVWh4K21oV3FsdTJGaDcyS2xHNER1?=
 =?utf-8?B?NkFVZktQM2ErMzFYZnowZjVOczNQTjZlTGhHUmZXT0RTY2tDRjZVd0pGTEtq?=
 =?utf-8?B?UmR6aG9jRlpqdzFCUUxSeU9PK3RnK01GZFJmbDJxQ0ljWWtIZjl4ZHVubDF5?=
 =?utf-8?B?ZUtyako3Mngyai9CNlE0TWhpN3BUT2ZzdFB3ckM3UGpqUHFzWFRzVVc0T1Bw?=
 =?utf-8?B?SmxlaXY1YXlVOUpPSFI0eHBSbVF4Wk1ZR3RJeDZxRCt1NGNkK2NzUU9tZldm?=
 =?utf-8?B?dGNqK2FDVHlNWDhTSEZrMXcwbzA1K21aM2RhRjYzcDFpcCtNQ2hoemtLSXVh?=
 =?utf-8?B?R0pIMHlHNVhPUTNTTlRtbkU5ZWJ0eXpPL1FtUnVXUVJJdWVZTm11UDVOM3F1?=
 =?utf-8?B?ZDdBY3BiMXhLZkpqV2hBdDMvMVl2RUZoWFVud0N3YXpTendocEdhdlE0cXNO?=
 =?utf-8?B?VWp2TjVYanZhQ1ZtTTkxL1ZSVTFSdmU1bVF0WjBleG1oSmcxM2d6MFY4bFRO?=
 =?utf-8?B?bjNKOW81MU9CVWNUakVxNWlEVExoNE1KdTUyWk93SUtXd0hVMSt2NFE4aE5U?=
 =?utf-8?B?K0RMeENiQUs0ZkVtZzRPcEorc01RQ0tvN1F2ZWxhQTdPNjc4Z2d3OXVGMmdX?=
 =?utf-8?B?VWRVYWVaY2k3OXZNZmdURnZOVjE1R3hGd2t6azJ1WkU4dUJGczAyektMRm5O?=
 =?utf-8?B?UGNWZVl4TFFXT1hUL2I3MlpISklWQlIxcGo4c3pnUHNkNWdBa0ZBS1A1NzhX?=
 =?utf-8?B?b2F3V3RUZ3BwTElQU3JjVnJSNldYM2NmcDUvQWJQNkVHK1ZWL1hGUmhHLzdx?=
 =?utf-8?B?dSt4VytuellyYmVtaVkzTjNFZ2FPeC9KclVZdUVJQVBBcDNpQWtWVXNycHBF?=
 =?utf-8?B?TndpWFR6TmRDdHZOa0FTY0ZuUDFHVHdaOXA3aHF1Z1EzMk1OaGtSWldXK1dn?=
 =?utf-8?B?cU5NMXdmRTB0eG0rWUdlVG5lZVNSSHpmMkJyU0VzQmlPMHJ6Vk9zVHNoQ01I?=
 =?utf-8?B?ODRGUTVXOUJRNkNSaUZyV1VFaTQxUzIvT1J6Nk1FVGc3SUlxbXZiZ0NvMWp0?=
 =?utf-8?B?Y0c4ejA1VHhBczdTMEJubWlHODgxMmgrWVNLYTJabUNqaDMxWEJxRmlFQ3JX?=
 =?utf-8?B?RVh0Ykl3NTFWcTV5WjJTSWY0VldleDlaRlhjcUl1dGtTSkYrcW1zb2ZFQzBx?=
 =?utf-8?B?dFU3MHZNL3FEOVRiT0FlNFVzRVU1WThoL1c1amNUVzBmaUJIYXE1aHVFb0RJ?=
 =?utf-8?B?a0FHZkFWSE5xQ3Qxa3lWYXZZT1pYcVd5aUxXeExldGgva2xoRGlYQkpxQ1pX?=
 =?utf-8?B?NzBCeHlTSjIzYVdIZ1NHNThFV3JLR3FYTTNaQ0hNbktiSWNSWndXVG5TYjBB?=
 =?utf-8?B?VWxnQmZpRC9TeHhoVE1TaS9Mb0pKRmc3K1VNM24rS0JPbUp5VTRKODNtay8r?=
 =?utf-8?Q?cKLdBrOw7iU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTk1azhHMjZCRWFraGZaQyt2ZW1RVjVJalpsL0xodDM5elE1cXNjSTZZNm5x?=
 =?utf-8?B?dERrWWUxajVmaU1SUThmYXdPRUNDaTJzWHd4alRCUm1TbDR2cnlBeVVvRWo2?=
 =?utf-8?B?NC9jZ1B1Yk5oQjdNbllJWTJ0UURSSUpFRjVSM1lycmV5ZDZReFRKNkNvMVRD?=
 =?utf-8?B?UitDUVBzNUtHbkRod3N3aGNGaUVvMlhUd05XOVFpTG0rOVVJdW1ZVlpjd3d0?=
 =?utf-8?B?RHJrYlcyRjBoVzNWd3FTVis1NDZxNHZ4ay9NQjFBUUFRbVIzaEx1K21pVHAw?=
 =?utf-8?B?ZHdZMldWYWxCL242REY1SkdTMWk3K1BpUVpOYjNHcGdMUlBvS0RjVWlBbDhj?=
 =?utf-8?B?RmR6WU5MRUlmWlFvUkVtSVN4QWNPZDYxK1hFUytZb0N1ek9oVm5ZakpSWlEy?=
 =?utf-8?B?ZmhnMWFVN1dFc05WR0dsdE1NSkF3andleXF3cTJVYjF1VDJ5YnZ1d2RYbS9x?=
 =?utf-8?B?NENtalkzUjVFVFFpWHZzTHRqaEdUMjdkVU14dFFnaXNCbFVjQTBlQkVPbElr?=
 =?utf-8?B?ck5FTE1WRlVHc0JEVU53NE8wUjd1TmdCQy94QSs2MDNaeVFuY0o5djd3VlUx?=
 =?utf-8?B?Z1djTm03WGQ4SnZtaFdwVFhHenlGMm13SDZSdkhGSCs4VUYxUkMzQTZqbkFk?=
 =?utf-8?B?dnBzVVlNbERxNGRYanpjRjlRWEFjZ3ZaNWxrVnZpTnJVR3RtTDJ4R0pmR2J1?=
 =?utf-8?B?VGJpV2ZWVG5KZE92UzVGdzRnY0dMam0vN2FtWks4cmlvNWRiYTNpZ253cGV2?=
 =?utf-8?B?UzYyRUVoSnlvUGt3aCt1eFlwbG03SUxzR1VxNVYvVm5pZXFXNUtWc0Y4aVps?=
 =?utf-8?B?cEdoNU1yZ3NZZzlVNE5WaUZubUhEVDUxQTVkaEtUZ2EzKzNCaGhyUmx2a0d4?=
 =?utf-8?B?bmtWNFR3cVlMaHpFaXVOOG1XUTB6R3JTOW5obWp5WmhNenNSblNYMlIvYk9k?=
 =?utf-8?B?TlREaUx5eFc0OWN2dVZSR1VKZjBuVlRWU21aeUFEWlRtbE1ZUmEwZlpvNjBk?=
 =?utf-8?B?VTJBcmF0MjVlcXJ2SlVMUlR1QitHVHRUUk5rdVZNRDVNQ0VTdGo3OVMvaXEw?=
 =?utf-8?B?NStwbXpBT1BBMVJBWGd2ejdvZEx5MkRsbUd5L3RVazB5QUt3T2hLTDM3MnZY?=
 =?utf-8?B?ZUhMVjRCZFFCNk1RUTNENFVKWld2NkdaOUpLcGFqY1EzM3dRaGZhRldrVk0x?=
 =?utf-8?B?d1haU2tvbWVnVThTalBwNjJsOUp1S3R1TTlnU3FPMjRySmJ0OHArdUU5YmdU?=
 =?utf-8?B?YU0wU3RjaG5TVHN1cElqRlhLWFdwOTMydytEbjN5bE5nZW1xWWJyZXRuWDVI?=
 =?utf-8?B?amlYUGFGOHBkRkRqNmxBNW5DTk1jY1Yya2tKR0hjMmlZWlpUR3V0aWYwckZE?=
 =?utf-8?B?c1ZQZlpLK0pXUnBvRVZYSVhJemsxLzlzSnZVd0ttZjdVQ3FORnE3eTNueXlt?=
 =?utf-8?B?bFYvOTBlaXJGb1dsRXkvZFp0Z01QT3ZYVlhHNkZLU2pYZzcrV3ZlZUVWZGRu?=
 =?utf-8?B?SnpEZC9HV0swUmU3UWREa3lLc0FpUnFnYWhNTDExV3NKNnRCa2xYK0VWOEZn?=
 =?utf-8?B?cUpOdllnZzlHL25oQXZqOTV3R3NmaHBlRzNvMFo3Vmlsc3U5cEhtaFQ2d1g3?=
 =?utf-8?B?Y3Y2N1BEUDhRNkFRMHo2bGFGa255RXZubDhBZnM5NzdGaW55bU0ydzAxS01K?=
 =?utf-8?B?cXdlbll2WkdXaHE3c2REd3l0NnEwUDdXcW11ajQ0V2lhWGdpcEJ1eWw2V1hR?=
 =?utf-8?B?NkNmVVUzdml1Wlg4SlFBcXlINk80WVUxeU9xWFgzMWFla1VKYW1SaXlVc1hi?=
 =?utf-8?B?dUFZMzNvOTNuZXdhbldTZnNCU0FhaTZsS20vZjUxcWRaVE5FanEzTHVxazJh?=
 =?utf-8?B?c0ozVTZ3SDRhdXZLM0ZvQVljbkNMYUsvRmlRUDdQUGc5VHg4K21rL0laczlJ?=
 =?utf-8?B?cDJMaklQWkl3VTZoY1JnL1VhTTF3KytubGx2RUgvWWJXWmF4SkxvOXJEUGox?=
 =?utf-8?B?V1grTHVMc1YzaG54Qi9ubFlWeEV0UDEwT1hKdmZEYUpjSTBDZ3dVb0xaaEtq?=
 =?utf-8?B?ZkRKK1d4bmR4WjljS0xycWhHUDJlQlJCdEx0a1BXUzhCYm0rNmg0bmNLNERm?=
 =?utf-8?B?dStEZVFkNmFzNStVNWdxeTVqVVZTSStYTTVPRytEK1g2c09pcEJqVUJnN3F0?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfff87d-c104-475f-e53b-08dde668e1e4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 19:27:10.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fyy3hwtY8w2ry2CdhyOlAu50Ueqfz9kqJ/hAI7UQDL3gGW4k43wYFcZQkcEAijbLu/mtODfVoBaOl3e/V4FQUTpMH84UdGVwcuyGOcwLHFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7483
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
>=20
>=20
> On 27/8/25 09:54, dan.j.williams@intel.com wrote:
> > Alexey Kardashevskiy wrote:
> > [..]
> > [trim multiple pages of uncommented context, please trim your replies]
> >=20
> >>> +/**
> >>> + * pci_tsm_pf0_initialize() - common 'struct pci_tsm_pf0' initializa=
tion
> >>> + * @pdev: Physical Function 0 PCI device
> >>> + * @tsm: context to initialize
> >>> + */
> >>> +int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 =
*tsm)
> >>
> >> Here it is: struct pci_tsm_pf0 *tsm  (it is really a "dsm")
> >=20
> > All of the context returned by the TSM driver is a "tsm" context, the
> > only time use "dsm" is in referring to the actual pci_dev that runs the
> > SPDM session.
>=20
> ah ok. Just seems a bit counterintuitive to use a short "tsm" acronym for=
 something else than the actual TSM as defined in the PCI spec and in this =
case - it is the opposite to the spec's "TSM" - it is a DSM, the other end =
of trust chain. And if I wanted to reference the actual TSM in the same fun=
ction - that would be "tsm_dev".=E2=81=A0=E2=81=A0=E2=81=A0=E2=81=A0=E2=81=
=A0 And the actual DSM pci_dev is barely used, it is mostly "struct pci_tsm=
_pf0".

The "dsm" pci_dev is used for type-checking assignable subfunctions vs the
device that runs the SPDM session, and it is used as the device to lock
when running operations on any subfunction.

> >> In pci_tsm: struct pci_dev *dsm (alright)
> >>
> >> May be we need some distinction between PF0's pci_dev and pci_tsm_pf0 =
but still these are DSMs.
> >>
> >> In pci_tsm_pf0 it is: struct pci_tsm tsm, imho "base" is less confusin=
g (I keep catching myself thinking it is a pointer to tsm_dev).
> >=20
> > Ok, I can change it to base.
> >=20
> >> "tsm" would be what you call "tsm_dev" which is ok but seeing short "t=
sm" used as "dsm" or "TSM data for this pci_dev" is confusing.
> >>
> >> s/pci_tsm/pci_tsm_ctx/ and s/tsm/tsm_ctx/ ? Thanks,
> >=20
> > What is a tsm_ctx? The s/pci_tsm/pci_tsm_ctx/ rename is not adding more
> > clarity for me.
>=20
> TSM-related attributes of a PCI device. Not the best name, true.
>=20
> > If Aneesh or Yilun also find that rename clarifying I
> > will switch. For v5 I will stick with 'struct pci_tsm' as the PCI objec=
t
> > that wraps TSM driver produced objects.
> yeah, if it is just me, then never mind, I'll get used to it.
>=20
> > The reason I do not think of "pci_tsm" as a "tsm_dev" is because PCI is
> > always a consumer of an outside of PCI TSM service provided, PCI does
> > not have a TSM concept internal to it.
> "struct pci_dev" describes a PCI device, "struct pci_ide" - a PCI IDE str=
eam but "struct pci_tsm" does not describe PCI TSM... Hm. Thanks,

How about keep ->tsm as the short name in 'struct pci_dev', but rename
the type 'struct pci_tsm_ctl'? It is a core control data structure for
TSM operations. It is not a "context" like device drvdata where the
owner can do whatever it wants, it is a core control structure that a
low-level TSM driver can wrap with its own control attributes.=

