Return-Path: <linux-pci+bounces-27194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC8DAA9C66
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 21:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB2D3A1979
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009BC19ABAB;
	Mon,  5 May 2025 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nNgISAsr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3D51AA1C4
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472854; cv=fail; b=GZLsVVhS15wvK1rWROs+dMmFy8msq1nLYYCYqIENGXFUJBCdB26unpmdo/YAuDmuGwP0s6BxUlwAD0H5mLQOVTnp7MJHOv+SKhvFxOFDalI9uvYQupDouhrhCb+Zsdp15uieHM06KLRyELeLuinyOUhBL18SOyCt1o6r7WG++fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472854; c=relaxed/simple;
	bh=mKPjbtcADNB2/APi5WYy8Lprh067PwTV7baK15BuUkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pX29B5/BVgEMW07laQq+RjCdhKTd+FNaXzN9hb2fqR2DbmnkMeBmUWoL5+bcZ1a1JOASkC1y6toICeigkJdE9M22XeeUxRZ4Gjhww6u1YaSZn9rl3n7m79W60g53Zjt2HYu9slEh5iD7oJqrNJZC/iY4obgxbGT8LHbu/Qf9BMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nNgISAsr; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxc7/GjW5MuaM0myKnjVHMs6yc0wBRqPXnYm3ywpGNIx8d3C88ZaMiJoRdTyZYQUuInxQpHrAJy/wuSb2hdZU70A9uXGZ7p4kRAK8WKbXO+h45eeNidAVrkujFuU4zqi8XwlgYG5XU+fdpaTyHf8npCyGjvvyfUAm3N0aEHLG8BVq5PEmzgVR7vPtr1FRz8vdemU6vqaHOfFkeTwPR3WqXrRbdo5l9DEdDD1z/8mQaesB0en0rln9MAIaXE4PsX5DZ9zpWmGRAJaeAFedORBHugMpPQBoRgskO5R69QP/Psg3XDlxxM5X6J3G54Ph2UIk5XHnUKxQ31975bFbKfLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfvVDpfPuVgP6FIcxYtD0cpR3J37LyE+2ykE+LGuXG4=;
 b=AwKabk3o8YCIp19/m9G+U79yllcAUDGgHLRek5ffM+N/EvYE32YlUGq1M+/i/2Ff0raawWejNbcSDRQLi/aRclpp5Dkx+Sn5t5u2CjiAgrjPB3ihReSfx61JBshCaINoNoRNb9FSePNbv1kv0kOkgZOjcUzOgiD4WUWJZkvYjzDoUiRQyb9DJTFw0jETTFQnwn8IieKEh4ZPshCnj+t2xWWTV0jIw7Gzo7jUgLoj/79pxBB0sxz/LYWoXtgwxcqCBvrHVEqURF0uOtAPNuAmWBPDktOhm75Ok6FNb2GTja/tovi1YKkB1TFC5lV4JxdNSNLEVXwLkK/BjawJelSYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfvVDpfPuVgP6FIcxYtD0cpR3J37LyE+2ykE+LGuXG4=;
 b=nNgISAsr423B2XF1vhJAhpwIVKcwnq+osTqhiAfcCpzKCR1010h8n1bmP412q04ZoG3Ig5fwghA3LPbk/2qMQqz2QA10uvAdZPsU8bwYYbov8TLN5EldD+ijkL45SYjVfRYOJFe41tFXJN2bcP/8BKGtOI7sXPWLQPH50B+s79A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7)
 by BN7PPFD91879A44.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 5 May
 2025 19:20:50 +0000
Received: from IA1PR12MB6409.namprd12.prod.outlook.com
 ([fe80::96d9:e0c7:bf0e:14c1]) by IA1PR12MB6409.namprd12.prod.outlook.com
 ([fe80::96d9:e0c7:bf0e:14c1%4]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 19:20:50 +0000
Message-ID: <1944cb5c-2352-456d-bf4a-5b39d7ae0fe5@amd.com>
Date: Mon, 5 May 2025 14:20:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Explicitly put devices into D0 when initializing
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 bhelgaas@google.com, rafael.j.wysocki@intel.com,
 huang.ying.caritas@gmail.com, stern@rowland.harvard.edu
Cc: linux-pci@vger.kernel.org
References: <20250424043232.1848107-1-superm1@kernel.org>
Content-Language: en-US
From: "Perry, David" <david.perry@amd.com>
In-Reply-To: <20250424043232.1848107-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:806:23::13) To IA1PR12MB6409.namprd12.prod.outlook.com
 (2603:10b6:208:38b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6409:EE_|BN7PPFD91879A44:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c825f99-9e4a-4c41-1a4d-08dd8c09f241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmFQNEtqWGV2R2ZYZDJoNTYwWkVsZmxtcFhGeVE4VjlLVDl5MlY4elJvN0tu?=
 =?utf-8?B?dDllcVdwL2tIOWhYcGhYSDRIenJVWWQyRkxxcHg4RU5VWkJxR2ZsNHdlTlYw?=
 =?utf-8?B?UFNmMWRFeFRXK3BFSzlld1BxRkV3VS9xajM4cWVnREFDZXMrYWhZS3NscWxq?=
 =?utf-8?B?eEtUMHYweHNHWGtJcHF1Y3BNbDJRU0Y4SHA2YnNTcWY4OWVRcDZ0eTVNZXNV?=
 =?utf-8?B?RnExRE1PY0pkbEIzL1dIY3Z5Ni9SNDRQWk5MZEQ5TW9Sc2pGa3cxZVVYMGZ2?=
 =?utf-8?B?ODhHSVhDMW9QNXdpOFdMMytsUlRmd01IU1Q5STY4aEFIMnF5R3ZqL1JwbFRt?=
 =?utf-8?B?ZmIwUS9oMEpyNDlZaEFyb2wzNTdXRU9URGFqUkEvKzkraGllaktnemZEeUFS?=
 =?utf-8?B?TDBLV3EzWU15YWxjLzYrNDVWLzZ6c09ubTBla0hhQVVmUG1mRDBXMm53bDQy?=
 =?utf-8?B?UFQ0d1ZsYU1lSTNJeC9mcFZhU0pNRDk5aXpmZFN4dDBoa3Nxd08vK1ArcWxE?=
 =?utf-8?B?cjJwV3RwcG9KL1VRQTlzOXczYXR0aXJkYXZqN1k2Q0l2dkI2TlBLS056M0Y2?=
 =?utf-8?B?eDJ6RmdOSlJnZmlkdUZ0K1lqTmxXdkg5Z0l2T0lseForNEQxL3RmWWpzbS9o?=
 =?utf-8?B?MWJaSEhIZUtRQitjL3l1YnBwMFV3NUcvVGZ2R2ZoS2dIYmNQNThLMkgyZDVQ?=
 =?utf-8?B?TEpnRzNNRm9JSTMzV2NMaEtHcVB1NFlvZndJcXUrMURlZ09mTWsxdUdTOVNE?=
 =?utf-8?B?TkVCVDhkanJmRWl2SmVKNkN1a09ZRk5tQjRGUnE0TmxNbHJWVG56cjhaTVRI?=
 =?utf-8?B?MDNYVmlpd0RCb1RjbnpSeTVDQ1VOdDBTd2VUWDM0US9vMVRnbDJmbnZYOFRx?=
 =?utf-8?B?aGxmaGt0RDczV3lPWmh4UXh4MFdxMGtDdjdNRnFOd21mVWxUeWdGMWZPOXJE?=
 =?utf-8?B?Z0IrUWpmZjNyZ0xzd1VjeUhkdEp2azRLKy9Rd3Z2ekJYVzkwbGpULzZuRkxN?=
 =?utf-8?B?OUFsRC80c0JCbXRGR0J4YUx0L0owaXdvSmpJN0xSbTdmMVl4YWMwUWFKdzdq?=
 =?utf-8?B?bEhWNmZlSzhMZDdHQ0p0M05pdVRHdmtQaWxoRno1Y1BsK1AyNEdWN1FQT0h5?=
 =?utf-8?B?Wldxbi85dXVyYU80LzZhRXZkZXo1RVBOcysxdTlFUjNJSFZiL1l1cEIrOUVn?=
 =?utf-8?B?SGZSSFpLMnJYYTF5VXpSUFZwakZLbkZRUHg0VUkvT2RaRVlpOHdRdUkyeGI5?=
 =?utf-8?B?bnVkbVBCUXdySHNVN0k3VDlsMnBjc2xtaFRqVTdGVWo5b2RMb1V2UmpMcXpI?=
 =?utf-8?B?Tk93Q2hkWGN5dmdKbGhXdVlMZ00zVzBDQ2dHWkJPL2YxT0YvTmh3ZE5JTE5M?=
 =?utf-8?B?UHJjMXJjQVVQK3dYWG1yOStQMXo4UkZCazA2elNlalNSYTFKb05XNVV2OEZH?=
 =?utf-8?B?ZzJKNkdPZXJodWtCc1BGRFpSb21SaU15YzdtVDlBa0pJK2gxR0JVQnlGVndE?=
 =?utf-8?B?TGJkM2g4WkJ5bWEzYjJtVDZ3SGM1eDArUk9kSkEyUmE5ZE1iVGpTZU9yRVQ5?=
 =?utf-8?B?Sm1FWjYwZlVQUGRoTjNMbVR6TjJhejhSNDFic0VCOVVocnZ4d0c0Und6MGtO?=
 =?utf-8?B?MFdHNzJsQndXeVIraDB1dmZQay9WdGRmWlhmZy9WVzN0WENILzUreUVEWjY3?=
 =?utf-8?B?YmJ2T29qTlRFL2pmdGpsYVBjZEJIZmN4VytxdzlhVUtxbXl0dktMZkpmaytm?=
 =?utf-8?B?MVA4cnI1ZFBsOFAxSWdIRjJnSU12bGIrQzIwY2Q4UDZSWU9STHVSV2tZMHI4?=
 =?utf-8?B?aklRWitYOXZiWVFVNnovZ2N3K0xRZHlOKzRrbDdsTFZvVGtlTkpMNGNLUE1D?=
 =?utf-8?B?UUJmb0YxMnpscDRCZ216dndvaUJpSmJZcEhHM0tOZTdra0VPdWUxVUVycW5y?=
 =?utf-8?Q?5XycsR4Aiz4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6409.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akxyUU1CWCtQWmlLdXZOY3JBN2N1QXpQcHhVSWVFTDBLdlFHT2hPY3JjQzV5?=
 =?utf-8?B?RkZSZGtRZm1iQzFhRE1GT1NrYzc0cVlrU3JEL28reHdvVWd1ajRlK0tqMUd1?=
 =?utf-8?B?WDF6eXBMTm5Cd3BKaEkweTBMeStubXg2YzhHUFdETiszb3JOejRKL3BqeVhl?=
 =?utf-8?B?OEFOQW9qbkxQcklpUERwOEdRY1JTMzBTVnYxY0FBbkpSTWRsb0NHUlVKUGRv?=
 =?utf-8?B?QUxhOEoza1pjYWJRNVZkeTBpTFNUT0tEM0l4NmNxWW9oSmJBVVBqNEEzMEYz?=
 =?utf-8?B?NkxPeG9FeGxld1gySTl6eHhVT2RZSG1DT0tHYTFrTnlLVkpNR25xV1g2UnY3?=
 =?utf-8?B?M0c0bHRtSFlZa2duNXFtNW1leEdwOEtsczlXSm5mNFhnNmxSNGN4MzI0ek9y?=
 =?utf-8?B?ZGRma3FxcmsvTnBucVlnU1NKV3VTUWk1eGZ3ZXkySnlLRndyUW9GTm5qLzlU?=
 =?utf-8?B?N2o0WmZ0RXRRNXdKVzdyd0tYeVhqZm9HeElrWm9SbkNaaHlWY3N6SkhudDBL?=
 =?utf-8?B?YnoxMU9rbUtRNTZCeW9RcWVxMGw2dVJIU1FXOXlNK3lRZjlKOWhxaU0vRHJS?=
 =?utf-8?B?NDFnQ0NXUWxselovWnB5RlgzT3NMd0NCZ0t5eHl0ZC8vL2lRaUx3ZFNhWXVi?=
 =?utf-8?B?U09aRzUySjBjMFVINzhoR3c2ZmN4MzJUMGhKSXVPcXlZMmpkQVJkT0o5cmNB?=
 =?utf-8?B?aEpJOUx0NVRvVERsdCs0MDhpb1B2cnRqdGZuMDF3Z3BkOHFQbVF6Ni9WL2cz?=
 =?utf-8?B?K2FlcVFDZDQySnVQaW5mNUVxK2RMWDNTSFhraDg3RGhvZzhxcG9RQUpoZVZB?=
 =?utf-8?B?WjBKMGFYRGFrTzhJZXVXWFpuc09FZDNXUHUvRUpLUVdCdlpUNDFWRnYrNEtl?=
 =?utf-8?B?UXpjVXA3Znc0NjQyR0pya3ZGYUk1ZlAwNUpRSE9XNE5qcDNvckI1cys0V3E0?=
 =?utf-8?B?UDlDZmlzS1ROY3lvbGgzMEFEQmlUR3BzZUhUWkRjcG40MjVZOE9LejFOdWhW?=
 =?utf-8?B?WmxyblpJd0cxZGZMbzdEQXZYbjRZYjZDTm51cUhtK0hxbDhZemNsa2V5UWJX?=
 =?utf-8?B?RVR6cit0Tm5jeGxYeGsvY0d3Zy9MZi9rYU1jek44NUVidXhjVnVsNUtvYUND?=
 =?utf-8?B?RHVsdzlUSTNPc2dFMk0wRXNZeFd5V3ZKbkY1SmNVM2JyRGpCdlI5WmYvbWw0?=
 =?utf-8?B?L2lXWmpwdk92V2dkNEhXQkVHcklKaUtDVzlyWG1BYTY1dm5xdHQ1TnVKay9J?=
 =?utf-8?B?Ym0rZThSelVtVEg4djlINHRmWERobE44UkFZVklLZjU3YUxvcUtLZUlYNno5?=
 =?utf-8?B?N2U3R0hpalNMTlJMenhiN1o4QjNOZjArVWVDa3czZjBySGJIRnI1dkRtZ25x?=
 =?utf-8?B?Y0xqNlNXYjdTRmtld2FwN0ludUs5TUdyM0ZVQWVFR3NRZ2VWbndzWGliU050?=
 =?utf-8?B?ZVlTRWRFSmQ5UzZHek16YWRMQUJIZGRONDlMTjZ6bTB4WGYxVjVQZUF3RG5D?=
 =?utf-8?B?UWN0SmNZSHZLVW9ER0VZcXQ3R2RacFpOcUk1ZmNPUHl4Um1BblIxSmFuNENq?=
 =?utf-8?B?djVWUE1JS3FWMmNYZWRSY2dEU2d4R3NXazlWVTErYjFCOWhTNmtoZzVSRFdQ?=
 =?utf-8?B?SjZ1WktRRzFwY1grejRmalV2SkNPY0xtSjFuYzdRNmpFdWt1aTFFTnFmRU1l?=
 =?utf-8?B?T09hU0x0Zmppc3pubGMxemFPdVE5U1EvUXVRbmV6RVRSUEtvamhzcEd2Wloy?=
 =?utf-8?B?WWtmWTM0djEzUFlFTXIzZ3NweFpIb0RRR1FiUzl1Nzd0UTdZVFhTeTNEdTF2?=
 =?utf-8?B?OVVpOCtPckwwVkNUWDNtdU1NTmw1WU4wK0tYMkc2VDNnL0ErN0MxNHozdENM?=
 =?utf-8?B?dUZVbUZtUHRNYWpuOU13QWR2eHI0bHZWeFpiNFdWZGpkMkNBWk0rd1ErNXMv?=
 =?utf-8?B?a2U5eC83TE5vREFCS1dHWVM5aWpKT2IrTlZ4QTMxZktpZlVZY0ZZbHlQSDdi?=
 =?utf-8?B?UDdRQlFYUUpoc2NNa2I5Z040TlZlMG16UnJzbnVlOXNOd1BKVlZXbVM5RTN2?=
 =?utf-8?B?eFNoK0EzTFJ0MERTbDBQYy9UWmpWcXpaUWIrajFTUGpBTVBaYktFb3RyRGU4?=
 =?utf-8?Q?mjOszT19U+Uu/9QTwFZLiaWlk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c825f99-9e4a-4c41-1a4d-08dd8c09f241
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 19:20:50.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fjlwSLJHTLj0+xg+ZGNZK6FOiSgbej2x8rgb6iKFosv2COVlw3J9cH7/v9Rrsc62Yi4XyUdgDF06n3L+RJdqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD91879A44

Verified the patch on AMD reference board.

Tested-By: David Perry <david.perry@amd.com>

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
> v2:
>   * Move runtime PM calls after setting to D0
>   * Use pci_pm_power_up_and_verify_state()
> ---
>   drivers/pci/pci-driver.c |  6 ------
>   drivers/pci/pci.c        | 13 ++++++++++---
>   drivers/pci/pci.h        |  1 +
>   3 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index c8bd71a739f72..082918ce03d8a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -555,12 +555,6 @@ static void pci_pm_default_resume(struct pci_dev *pci_dev)
>   	pci_enable_wake(pci_dev, PCI_D0, false);
>   }
>   
> -static void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
> -{
> -	pci_power_up(pci_dev);
> -	pci_update_current_state(pci_dev, PCI_D0);
> -}
> -
>   static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>   {
>   	pci_pm_power_up_and_verify_state(pci_dev);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e77d5b53c0cec..8d125998b30b7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3192,6 +3192,12 @@ void pci_d3cold_disable(struct pci_dev *dev)
>   }
>   EXPORT_SYMBOL_GPL(pci_d3cold_disable);
>   
> +void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
> +{
> +	pci_power_up(pci_dev);
> +	pci_update_current_state(pci_dev, PCI_D0);
> +}
> +
>   /**
>    * pci_pm_init - Initialize PM functions of given PCI device
>    * @dev: PCI device to handle.
> @@ -3202,9 +3208,6 @@ void pci_pm_init(struct pci_dev *dev)
>   	u16 status;
>   	u16 pmc;
>   
> -	pm_runtime_forbid(&dev->dev);
> -	pm_runtime_set_active(&dev->dev);
> -	pm_runtime_enable(&dev->dev);
>   	device_enable_async_suspend(&dev->dev);
>   	dev->wakeup_prepared = false;
>   
> @@ -3266,6 +3269,10 @@ void pci_pm_init(struct pci_dev *dev)
>   	pci_read_config_word(dev, PCI_STATUS, &status);
>   	if (status & PCI_STATUS_IMM_READY)
>   		dev->imm_ready = 1;
> +	pci_pm_power_up_and_verify_state(dev);
> +	pm_runtime_forbid(&dev->dev);
> +	pm_runtime_set_active(&dev->dev);
> +	pm_runtime_enable(&dev->dev);
>   }
>   
>   static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b81e99cd4b62a..49165b739138b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -148,6 +148,7 @@ void pci_dev_adjust_pme(struct pci_dev *dev);
>   void pci_dev_complete_resume(struct pci_dev *pci_dev);
>   void pci_config_pm_runtime_get(struct pci_dev *dev);
>   void pci_config_pm_runtime_put(struct pci_dev *dev);
> +void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
>   void pci_pm_init(struct pci_dev *dev);
>   void pci_ea_init(struct pci_dev *dev);
>   void pci_msi_init(struct pci_dev *dev);

