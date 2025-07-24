Return-Path: <linux-pci+bounces-32891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D4FB1101C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5743B2976
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC71D1EB5DD;
	Thu, 24 Jul 2025 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="16iJlk6i"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E022083;
	Thu, 24 Jul 2025 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376578; cv=fail; b=QA8cmlYTonPnf651W0dtGiginx9ROqwIRqF4bs+1ivMeFiPq/Xrxu0yAk/yVmLrCkHc8oN8yNd1zDkBtvmFkwDznCZDYY2bZt+9v4PbcKnnAq+yiURKWaC7vD0aMZfr3kPw7rEiozMAU2fPn1ifdKM5hZ0i1Qbtf+6eFGIsSjLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376578; c=relaxed/simple;
	bh=J0JyqbUbiT+TFzBYy8PqLcTNZgZZ5s3pE0j9kaCf2z4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KVaD+dffQDq6cv3bP/EZE058YxcZ+52f0ovR6qU43VhUIpoOvvTfXzJWLTD9x4nAogjpAYHQvssHbtzLol7WqM4y2jhzxEE5s4LWN/Bq+PTkOEiScJ6YAKQnp0sNiNa6l6ricrTm2pE8GKCV8aHO12D/vvdBEnEDfW7O1yebKzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=16iJlk6i; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2sY9+jgDt0D5Q/TqAYPAb5mOhtm6WWP37Ditm5B03tOiEcdfUQGQ2sANQw7qYyytfkuiUqoY2rANDl7dFIZHEdhgwHMcTRv4z7dyxCtpim6enCKoEOzdqdxoPGK9zfcdOr7GcSgi7n8I/6ok9i7f9K3/M1eEhRyuLEs3um5Iq0wbFfqIaLj5NLH83ypngg0Pq3wlXbVQTpMTGYU8DkIQ7H0nDH4aW8caXNVg+rwY6KZD0j9lscS1fOJ/Or1Rue+mnU1yve6tM16Osr/iVHs86/C9UztboCNgjSPsjKglIIEB/TUO1pq3pYcetJi8W+bzTDJ78ILD9CvLvHRa41QQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbNEjvNT1cLiAiV9OkGdRiAccNN5bdK0OD7gM3LgheA=;
 b=bVOXew0WyTWY5/YO3uS8a0+McCx8m2I1ZJNqd5Rnk+W3qfT8wT0vps8ZoFmp05FVBzlrR4vLJfgiLMnjv6w5EXzW01GRPTsqBPzvVyhqi6nX9YAb0jbl4HLB4v9GaEhZNXmyQgkN1myCW1r0JKHT2RYvowzIcDgrqeNMT3IgpGq3xBvNozb4wluxEzPsA2CCFA12rqlkqVualIUO/8+bcP/syfwkaro8Gr1pxIFY6NCb1in8GQvM2Obt56YFKcr8C/WY6ibZOHZFk8YZTDQOt+s+NMQZZXIV8Z2/BgRYJPLS0Wb8yHqi9ZvlEud2Ypq6ziKr/8iYCwaEnBrEkw+f3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbNEjvNT1cLiAiV9OkGdRiAccNN5bdK0OD7gM3LgheA=;
 b=16iJlk6ir9DJEilwlwFiixW2WX8WzPcJktIp7d76RJYHGhTvDHRvfwRFtrN0sZOjnDATxyOxHTKjhzhOq0cjPPMPdgnoWQevzrwaXfzeZsR3qku1iKdgeZ7bhN/U6NSCDERPrSCuKShSsNwK0CqsIqgjvaZW8PNTC5l1iE58O8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.22; Thu, 24 Jul 2025 17:02:52 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 17:02:50 +0000
Message-ID: <536c6bde-fe1c-400b-a8bc-bb40a23ef9fa@amd.com>
Date: Thu, 24 Jul 2025 12:02:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/17] CXL/AER: Introduce CXL specific AER driver file
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-5-terry.bowman@amd.com>
 <6881896b8570_14c356100de@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6881896b8570_14c356100de@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:806:23::20) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 70276acf-412c-43f3-6ea5-08ddcad3ec30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0MzYmFjS3pVcG5OQVF2TW1maGQ3aTFqb3A3YlhwekV0bUUzQ3BLNU56VW0z?=
 =?utf-8?B?ejBWQk5xc0pVZHNWSHNIMDNQWW9BWXNYQWFlQ1E4WGpwcmFtQndMK1Y5M0pH?=
 =?utf-8?B?U3hPL243eThZK3ZWVUlvRWxoMmNkYkdwMG81YmUyMys4aFFqZVhLNmZ0ZjBV?=
 =?utf-8?B?SUxQU0JQZ093TUNieWFZdmgrZjRnb3R3QndsczlkcDZsL0huSTB2RHBaRFpl?=
 =?utf-8?B?cElsSGRDY2U0M1QrQUxGdXFnSXpwZGlFaU9HdURWQ2E5U3kyeXVVcTFUMzhK?=
 =?utf-8?B?RFcyZ0tra0NiSWZEWC8ySmx4S0FUUFZQRzk0SkRQd3FVWWtpaGFXVkdkVytX?=
 =?utf-8?B?UFFZY1JENGI1Wjcza0Q0dU5SZDQxNzNFZTZrUkZQa2hQY0NiL3dOeTRNUS9o?=
 =?utf-8?B?eTNJOWVqcFoxK2VianhaUGVWSGthaVV0Zm4rM05QNE9jekdrS2gxK0pzNXhz?=
 =?utf-8?B?SUExZWVTRmZ3WVFoWEZzVmJIOUQrTER4NkFCemRYeHdCaS9lOWZGTCtva2xw?=
 =?utf-8?B?WXVDNEkxMEVlOTcwUUhpM0psL3lHVnhhemI1VHRONHU2MWlFUFZ2RHBoSWtT?=
 =?utf-8?B?ZmFrVDRJQ1NVR3c5RlJyV1R0TjVpTXhCSGorSkY4Y2lnK3k1QkVTZkV4UGZP?=
 =?utf-8?B?NXg5NHBVMXozNEFIWU5yaUJ2YVJySUFIMlRadGFlcDFvRTByT1ZneElRYVlJ?=
 =?utf-8?B?UEdidFpnWEgzZCsvV21ZREFSRlNIQ0JqaE1wOFBBdlI5V25mMEhyS0RsRkdp?=
 =?utf-8?B?MjJEK2RNSFQ5Q3dyUTdjVy9MN0xPY3QvY0l4RXBZbUVkcWZMZTFkcnVicGor?=
 =?utf-8?B?UmpoU3QrUlVPOWFzK0VrVXFMODQ4QnhUOHV5ZEJTQ0ZNMHRqSmpVOHJLT0ty?=
 =?utf-8?B?ZGJTUndMaUxKZkdsbzlEcXVlUG01OUtVVW13VWJ4Qk1mbHZVOWRPdUZsRGZn?=
 =?utf-8?B?Wk5aMmVuZVV4ZCtIMEdCVmJHd0RjWjVHNjhSZmhYVGV4NHNhUzdqZ0w0Zk93?=
 =?utf-8?B?UkIwRGVYQ21ma1UzcUNsbTFSa0tveXZ1bFpRaGpqakxnT3RnU3FWQ08xSi9l?=
 =?utf-8?B?Rkc3d3h6UkNBdG5ya2h2cHlaQ3lkbGsyaTlIVDNReGkyZk5SdnFSSHVxQTNl?=
 =?utf-8?B?emtqdCs5SHBYT2s5WWZiQkJPaDJ5TkxxSkh3Y1d3V3ppOFFkOFc4dUk4QUxN?=
 =?utf-8?B?QTFTWk9udS9xRmNFV2JwSnd3ZE9wdlUvclptREFrWjZ0TFNjRnVwcXJ4eXpt?=
 =?utf-8?B?ajlJaEJOdms3R1FsTjhrOExQQ09HNmsyUkJtSzRZYzZTUlQ3TU5Ib1hPTFVT?=
 =?utf-8?B?ektwTnJuenE3Vmw5Rm9qeEdXR3VoR1NocVMvMXR5V3o2OStsb3JVcjNmVkRG?=
 =?utf-8?B?QWh0clZyVm9LVW5SRGpQbjUyMFd0NDRibVhpcS9pRi9sK0NVNzNmeElrY05N?=
 =?utf-8?B?N09ScFhXMGdjdjBvUS9TT0xheDJ2UkI5NnBFRlFLeEYyK0FKSzdrV2hmcHlv?=
 =?utf-8?B?NlViWEFWeW05eFc1MjFSN1JWaDVXamZXY0t2UmNKbklsbmhSd1VjejFPK2pH?=
 =?utf-8?B?V0x4QXlhMnI1dTRXWXpxUFhLRjUxcFZyNXVtZ3FZclhCTTF2eVpkcVBSejNi?=
 =?utf-8?B?N1F3ZGc0dXAwcE82YnRXS0RuMUt2QkdmRHdPZDB2TUlmUTUwZ1ArcDBYaFAx?=
 =?utf-8?B?T0xoVGpJcENIWmFzblp0N0IzamJGTmh0b0xRMERYaWw3Q2YrOHdXUTBCV0Iz?=
 =?utf-8?B?ZklSRlNQM1gvM0xCWk9LMzFJVVNVUXRHR3lYWG03enJEbGJpc3huRHRxWXYz?=
 =?utf-8?B?bXBMdUdESUxIaEhIeXdYY2RlVFlYbUdqR0VqWXBaTWRPZkFZSWhiZ2dzWk9Z?=
 =?utf-8?B?VWJaQit4amk0REtCRjhtNThyWE1Gc2hKNURTNWJkRGIrdXJBR2RyeDJqRkxj?=
 =?utf-8?B?cUVjZk9kdEN0eklnYnNEZVNOZktoNm9kR0xNMlR6SWNXNnQ0eUhUSkk2Z1FQ?=
 =?utf-8?B?RjlhZUVvUURnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUhKL09ybDhEait6eEd1Y3FRWnN4TnExMWkwVm9TQkVjY2dYNHB3NEY4Q01T?=
 =?utf-8?B?Mk94bEsxZjlTQUl1NllSTmVTbjFEMVYwTGdJQkVnay9JZFpGN25kdTEzM1Bm?=
 =?utf-8?B?MzhMT0dQRkRjT01ieVJQZVQ0bFVkY09IMjRlVlV5UTlYaUx2OGFTQlVBS1JN?=
 =?utf-8?B?Tm1qeWxRbGFEeFdqd2JKLys1MmtUUVczUWRFQmhLbzMxenpCK2Zia1U5d0FH?=
 =?utf-8?B?UENKY3ZxbEhCbkVCN3dWRmpmKytwSmVqVW82SUdNeEFEdEgxOWExNTYybS92?=
 =?utf-8?B?SGhDd3FtUjd4cWpOdVNYb2trbTRjVlFRNzhWV3ZpamJuSkF1T09PM2MzNzNn?=
 =?utf-8?B?eXBJMlIycHRiUkFFdDZXVnpYakRvaWtHWUZ6YVdkT3hnOXVGTUtGQW5iWkxJ?=
 =?utf-8?B?aE4rUTFBZ3lOV3pydVVDNElPUzZ3SzFXRktLZTEyUEtaTW1pWTg4YURRZ3cx?=
 =?utf-8?B?cDB5RXRwakZvVHNZOGtnSUVxOVlFMTU0K2hnS3VwZHhpUkxIeVJvWVlmV2Vr?=
 =?utf-8?B?cGJsS0tvSFRqTjJ5enJWeUdBdE5vU29MV0lTNGpFbkx1WXNXZjUwUjAwS05T?=
 =?utf-8?B?RTJHZjJzV04vUTM1WlVLSnhjM3dnTFVYNFJWc0ZESUVPZTFpOEZZSlc0Z3I5?=
 =?utf-8?B?T3paOTdVd0l6bFl6YmthQ0pZd2MyVUhyRjJEOGhEYTdudjZuVXd6VWkrOXgw?=
 =?utf-8?B?UkRHZUJua09NYXk0bGdmUXA3eTRmbzZQaUJ4NnF1b1N3cUVDNXRQUlY4Wkdy?=
 =?utf-8?B?MjlHbXhIWWk3Q1ljdlZ0clpnd0JwK1NFSzFBaExRRU1NajdsWCtEa05vL1BX?=
 =?utf-8?B?SkYwNmJ3QzNUdVJ0amtnZFBiU3I0eE9hb3QxUUNOZk1QeE9qTEVLejhSdnNq?=
 =?utf-8?B?VVRUVlFsQTZqWDBoaXpBdm5xZ0N5eEFZMURvWmhGaXVmRkw3ajFoZ0VHSmFL?=
 =?utf-8?B?a3ZYRHFMdUpjR0dJYXpFeElWVDA3QUJxTzd0c2lESE1mcDlzMzZOcmZ0RGd3?=
 =?utf-8?B?RjZaN05ubnNrTjRUdytPd214YWJ6ajdaeG9tUnZhOXMxSlBaUjlUWi9URzdm?=
 =?utf-8?B?Y1BORW1IUGMrWm9mZFp4ekZza1NxZVFvemlLMUJLaVV5dEFzdU9YbE1WakZG?=
 =?utf-8?B?ZitrVllSVW5TKzQyUXR2YUpzVFhQbjc3NXVBMHRIT0JXYUFXOWlHRjllbWdD?=
 =?utf-8?B?MlVNemoxTmVWbS82bEZpdHExa3ZFK2liVHhhQllnSVY0MnVwdDFYNUFLaHp4?=
 =?utf-8?B?UllUMlJwdmlyZVhqS3VkUm1NSkZ6SHYyclJ5RHdBV0RuMERSZ2dVR2JUTWZm?=
 =?utf-8?B?d3NBUzc1UURRWVYwVE1BTGgwc0EvUW8yOEYySUIvRnB1ZDNycDRRQ1FRNTlH?=
 =?utf-8?B?ZTBFUGdENStYQ3NFOWVFbmZITWlhMVo2MTF5YW95VFVnVkZibWlsOWdMaGJD?=
 =?utf-8?B?R1cyTmFPS21MWDhxeVZBTmxiSjZBUkQ4THdNN0tJTCttQjVxUklldW8rS0s0?=
 =?utf-8?B?bDFNeEozT3FicStFMXFvWnhqTGFmYUFUTmdtbE1NSlhpbjFvVUdwYlQyc25y?=
 =?utf-8?B?S0daanZTMkZLM2pLcjEvVFVXYkRHZ25kYjNOL2lVc3drNUVXREdFSEQyVms0?=
 =?utf-8?B?YzJ6ZDREVERMTTdManJ2YmJadGhoNHF0REZxRHFJS0tDY3diZTNkUUZDWHJo?=
 =?utf-8?B?TE5ITld5allHdDhWNjdtc1ZSbE5DN1J3THBGQkhHbjZnSTRNOXdVR2lHM2dh?=
 =?utf-8?B?SWhLbTVoQ0JJQnFmY2E0V25GanllRmRCWDFpWnVya3dNV05vdDBCajAyaDhT?=
 =?utf-8?B?UjNrR1Y4L0lUNlQ1Z2J4ZlZzaVQzWG9nVTBvZ3hPWDA2T1lWSjhtY252MEJC?=
 =?utf-8?B?TG80SitIc2c0RmlRdzBvWjVhU2ZqR0Q1NS9GQTVEOGdBRlZ1OUtxMUtTeDNo?=
 =?utf-8?B?QUVMV3JoWmhPN3lVdWdhb1ZLblpyblFheFZUUEUwRUFZUDQxNURwTEh4RUNq?=
 =?utf-8?B?c0pRTnhkbU12aURUMnRHTWZ5QlgvalhiNXNtL2lwVEV6YkFrZ2VaWDNvbllL?=
 =?utf-8?B?TmRvcGJ0WFZzUEwzUGhhTnl6V09GMXFJQVhjWWhjWDJLeC9valdPbG42aUxv?=
 =?utf-8?Q?HbPfYbLWfOk15DJEYzLigXQnB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70276acf-412c-43f3-6ea5-08ddcad3ec30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 17:02:50.8285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzBu7tP2dr34Ubes7bnV+3ZihmazxOEbh7lpjmKSZXoygeojAXRfk247/Ot+8lTQCp43m3u+4l8b5v5UnchPiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952



On 7/23/2025 8:16 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> The CXL AER error handling logic currently resides in the AER driver file,
>> drivers/pci/pcie/aer.c. CXL specific changes are conditionally compiled
>> using #ifdefs.
>>
>> Improve the AER driver maintainability by separating the CXL specific logic
>> from the AER driver's core functionality and removing the #ifdefs.
>> Introduce drivers/pci/pcie/cxl_aer.c and move the CXL AER logic into the
>> new file.
>>
>> Update the makefile to conditionally compile the CXL file using the
>> existing CONFIG_PCIEAER_CXL Kconfig.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
> After reading patch5 I want to qualify my Reviewed-by:...
>
>>  drivers/pci/pci.h          |   8 +++
>>  drivers/pci/pcie/Makefile  |   1 +
>>  drivers/pci/pcie/aer.c     | 138 -------------------------------------
>>  drivers/pci/pcie/cxl_aer.c | 138 +++++++++++++++++++++++++++++++++++++
> This is a poor name for this file because the functionality only relates to
> code that supports a dead-end generation of RCH / RCD hardware platforms. 
>
> I do agree that it should be removed from aer.c so typical PCIe AER
> maintenance does not need to trip over that cruft.
>
> Please call it something like rch_aer.c so it is tucked out of the way,
> sticks out as odd in any future diffstat, and does not confuse from the
> CXL VH error handling that supports current and future generation
> hardware.
>
> Perhaps even move it to its own silent Kconfig symbol with a deprecation
> warning, something like below, so someone remembers to delete it.

cxl_rch_handle_error_iter() and cxl_rch_handle_error() need to be moved from pci/pcie/cxl_aer.c
into cxl/core/native_ras.c introduced in this series. There is no RCH or VH handling in cxl_aer.c. 
cxl_aer.c serves to detect if an error is a CXL error and if it is then it forwards it to the 
CXL drivers using the kfifo introduced later. I will update the commit message stating more 
will be added later.

Dave Jiang introduced cxl/core/pci_aer.c I understand the name is still up for possible change.
The native_ras.c changes in this series is planned to be moved into cxl/core/pci_aer.c for v11. 
The files were created with the same purpose but we used different filenames and need to converge.

Let me know if you still want the rename to rch_aer.c.

-Terry

> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 17919b99fa66..da88358bbb4f 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -58,6 +58,13 @@ config PCIEAER_CXL
>  
>  	  If unsure, say Y.
>  
> +# Restricted CXL Host (RCH) error handling supports first generation CXL
> +# hardware and can be deprecated in 7-10 years when only CXL Virtual Host
> +# (CXL specification version 2+) hardware remains in service
> +config RCH_AER
> +	def_bool y
> +	depends on PCIEAER_CXL
> +
>  #
>  # PCI Express ECRC
>  #


