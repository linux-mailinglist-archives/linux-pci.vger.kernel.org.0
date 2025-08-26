Return-Path: <linux-pci+bounces-34794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B08F3B37448
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B07E1B272DF
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 21:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607D72F8BDF;
	Tue, 26 Aug 2025 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="siOiICve"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632EE2F7468;
	Tue, 26 Aug 2025 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756242761; cv=fail; b=K38aVc8jymeDXeIrWLqz2Yd+yGzehtnb0qoirWRghr/V6Po37gD0Ms7XdmA+EGHK9lXrHNre7GthS1ZIng/eNb+ZMxUiyscK4Tf8r4csadJu6pre2xlpeCdD2lIWcRmpYdEi46EZ3BsXRyQdL5XLiNcb88KMjSlZ1jlsl58WBsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756242761; c=relaxed/simple;
	bh=u9+f90hX8cZT0amiXQ6LqJFFSJNOsaz2v2UzHgl/4dg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DUOoTNijSAU0YwUozxRiXtAfTNQHt5XIhySkDA7ZtM4kiSz41e0mV1O8UR0h4FnOXOjQZX1jEu+c/UAYDK7UchFZgBFp9whd+tdYOdL53Hq2ZjmPiQkBu0xJCToEShS6yzUp/8Gi/Ox3vTvX+i4FrXmIiQsjCaJFC61lDbG1dDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=siOiICve; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0KNJC3oWkqVaHSNJHU3xuF3IU4XARMJQUjchg9cWe31ix2yDGkHW1fcwn3+ZN1PSuwMzIwr2vz9L0BKidttZUsrPEkk8oi/tbqWkPdDLuQTtdNFKJhtYHXIXhaQlOnxUwALP0DngTsKI0oGw+Tp2xTjRclvIBUASYFpwuPARKfNTqORnVucGsfBP2T1kE+LrdIb+i3zoTJADWdCc9q3fTMhmxGBHwhjjXmZtuxQfCGfLBdAThL4vBWIfOamKPE48RqzTLN1/jjEa3c5wkgIBNcYa6cGx55vAz2FeUHuBfva5r7B1TvfG6/ypTdPkXkD8HIrVgGppVHqmOVDUXBqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofBXfEpmWLmmj4gM9GadvgaWYZJ1wMwvaIsR/nRyV4I=;
 b=GulJvtfTOLNzLx/rM14hB8RBucW+D/Z8iOG8Jr+1CEvBQmiM9zR887Qco3AXdY6zWKhwM+wWAZ8vTFDJ6zzJ4ndZFS6FWOGxFPlD50xBuCnK6DKpbpOJNve3xd8I+8gJzOi0/GPXEX6KSODlaw+mUJcLibzwqtRs5xDXzkX2g+b2ItsYCjz/N1wqiIdq0b+GjCHYPhAjtm4YmDtSvCG1DJqu1hmFkmJl2/fddjjvxfXHWPnAe3ThuIljU6zJY9IzOPSyl30q1jrQ+av0WdhRQqLYYyG7GEunT9D9IzA97xSukGxFncV89I4oa9g+MPNtJSpDTkD/RA2ASr9Q/dGaWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofBXfEpmWLmmj4gM9GadvgaWYZJ1wMwvaIsR/nRyV4I=;
 b=siOiICve+TLWCwujNih084CP7HOw7kv/taEMkpbbN1fFI1qZ6w/xytZrjIjn4fbDVbCNmKDAWnsD6ydUMtohanhCfxp2eUItO55dN8iV/XSIIyJUiDvrL4tyRNOuWJCIsAbFNDKkvXs9qxTZKQCN2Zo0rWZewyzxWumJ6W/EDoDGCdkNw/1Gg4BuRKM10zSAi7VNkQi19aSKjZlWU5sHETsvIPACbRpRRoF9YX9ecLx/JGUEDoBzPQJ9FqdkX9sZljGZeYu54bPhUu/T3O8LqoBrafC4kbKZeBL/VA1mlhY6/+R2sKYGZq+HS+jMH0kgppcZ2r8YoFZ998SYnl2f7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Tue, 26 Aug
 2025 21:12:36 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 21:12:36 +0000
Message-ID: <5813de21-dfa5-4277-8f33-8e15939eb74b@nvidia.com>
Date: Tue, 26 Aug 2025 14:12:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] rust: pci: provide access to PCI Vendor values
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>
References: <20250822020354.357406-1-jhubbard@nvidia.com>
 <20250822020354.357406-3-jhubbard@nvidia.com>
 <DCBIF83RP6G8.1B97Z24RQ0T24@nvidia.com>
 <DCBIPY9UJTT4.ETBXLTRGJWHO@kernel.org>
 <b1cbdc99-317e-454c-bf03-d6793be5b13c@nvidia.com>
 <54b19bdc-5d88-4f71-ad8e-886847ccee8a@kernel.org>
 <65072e90-a1cd-43bb-bc31-04b16947113f@nvidia.com>
 <c137a383-6dec-4031-af45-0da821574f38@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <c137a383-6dec-4031-af45-0da821574f38@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:180::27) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b19caf-335c-4017-a387-08dde4e547b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUV5L3kzb0ErYlhDMi9MdzQrR3ZtM2dCTXByQlB1RENINkpuZEFYdXlSZmwx?=
 =?utf-8?B?WVBuVi83QUNBZ0hKemM2QjR2d2NtaUY3ZEVTenlCZkJCd3l6RWFuMUJ5M0E1?=
 =?utf-8?B?WjQ4SDV5MS9yVThOdEZhdHk0aGNyd2t5NXFDNmNZOVh1clAveDBLSGcyYjZk?=
 =?utf-8?B?WGowbTJJaFUrZ2w2eXMrVFVST0hCYUJsMXZjNk92ZUR1T01LWGxQUE9lVXkw?=
 =?utf-8?B?cTQwaThnY3hUVW5GVWQzTktMSDdTc1g5RHQrNkRSc0g3MVg3NkhJT3dIbElR?=
 =?utf-8?B?UTRWUGJIS2todllWdjNvRHZnVFhMMWJlMVhsamY3VitmRUZwaU05KzNOeUxw?=
 =?utf-8?B?a2JKWVUyTzlEYmpNNmhRYU83Z1RlV0tKcE5ESW5DNnh3YXloZjU0V0JKSGZ4?=
 =?utf-8?B?MW4zNnJDUk81TTRhRzF0R21YcEIyNkdSaWR1ZzRvNFptQnpXbTZ2TElMMzZz?=
 =?utf-8?B?NFliZW5kZUFpR2N3UHMvVnpXNkhEenJnZzV4bGNWTjIwNXl2WVlLRVpNRExG?=
 =?utf-8?B?S3F4dmU1dmpJSENybEZWeC91MHVkWG5PUkY4ckkzVFdFSzMrQ3ArTDF0M0gy?=
 =?utf-8?B?ejUraEliMUtZWWtIV3NQN3FEbUhnb3VId1lRdG54Y1c2RlhsTFFCTVJiV2NB?=
 =?utf-8?B?a05vdFRsT21BREc5N0NkVFQrK3p5ejZBSmwvYTJNd21YVVpoZkdRZkNQbHdB?=
 =?utf-8?B?V2JvOTQ0K2drTHlENk01R2pXaE5pSlRYS0laTWZCNjdYbkhCaDlEczNXa3lW?=
 =?utf-8?B?Q3dxYkxaNEx3UW44QnZJWHBrRDJYSHE0eElrTGl4aUFkREdBOWorOS80anMx?=
 =?utf-8?B?THVRRWtreGdvOXhxVnpLR0dPWWJ0ckNYZjhUOFJDa2YzQVVzRVUrem9aREJw?=
 =?utf-8?B?OUFJcWVGTHlhT2FaNU4wSFJOemIxaVUyVCtKdUlzMnc5VThSRmJDOG4veURU?=
 =?utf-8?B?SENrb1oxZlFVSjRWQitBWnptdFlmalpFQ0QxcEF4SFpvZjR5OTJCbHNsK2xv?=
 =?utf-8?B?U1BmSnRrVHVqTzJDMU8yMXNxTEJUbTlwcnJHK0NNSTlScWV1UnNUQ29uekxq?=
 =?utf-8?B?dEdIRUVEa09HODhYZ1NwSzF2bU84WWo3c1dBVUNlN1hQK2xySGpndlpHeDhH?=
 =?utf-8?B?eHF2dTJLbURFOXVZTmhFTmxuMTh6cUx3TUs0WG1UcTU3Q04zRFhSNWdHTzBG?=
 =?utf-8?B?L0Z2cjBXUWpUd3d3STZzaDh4V1ZlY0tQZGJLUkZodytVZVpDQnJTTzdzSUd2?=
 =?utf-8?B?UHRDcHlGem02OFFqT2plZzAzaGIzUW1meDhCd3lJcG81T3l5bjFxelVoLzgw?=
 =?utf-8?B?RFp3U1BpRDRFd3B0bzlZZm9aSzN4VEZnSit0VWIrYTZ3ZnI4cXNQQ3JZbHZa?=
 =?utf-8?B?b1FkdUFVTTJHQXlnT2ZRZjNaVkVNVnZyYUROaGVucTE0a2FZdXR5OWRBeTZQ?=
 =?utf-8?B?aXpZZi84VjJLeFNKWWxNaEZkaERER0NLYmNEbUtCVzg4MTloTCtVVkVONVNU?=
 =?utf-8?B?MHNNTTZPNi9ZeXQwZDd0Vk9zK25BaVNTanRpa1NjbklnWHF1a1g1TEhuZ1pu?=
 =?utf-8?B?VFFtY3Y2UDhKWUNXZlV5QXE3Qll2eWJZc1QrdWxjWlZ1TEFZNWE4dndhZnNG?=
 =?utf-8?B?T0NwRmRySE5CdUV1Zjh5MysyQzJrNWY0Yml3NWdmSWdFM1UrcWgrSElCQ05p?=
 =?utf-8?B?dk1rSitxQklRN2hudkovVzl1VmRMSVJJTFlHMGtDOWUycUxoMkVkQTNSd1dp?=
 =?utf-8?B?bWlqUHJHdmFza0xtYytTQTd2T3pLWGZTMVFNdUt3dit3Y0ZBSXUrQjJmTytN?=
 =?utf-8?B?Mm5adEhmcmI4R0g4bUZVSFhOS2h0VkxsbWNkUDhwbmNtdEMwN2gyL3llTjN5?=
 =?utf-8?B?M1ZDYTMxYk96c3Vzc1dCdDN0azdTek9CQk05SE5QNlF5TDJnOC9HVnNIOVNU?=
 =?utf-8?Q?HlMTAOPCYSE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVAvQWM0WHphaEdqbFo4WSt3MkRGUW11YWE0dVdnREVJU1Myd0d2ZldsTWVw?=
 =?utf-8?B?MUM1WVVnRGU4aEdkbVB5TmNFbVhreHl1TDJSdXVrUDRjZ1lFQURwREdDU2U3?=
 =?utf-8?B?Sk8wVWVjV0pRSHhsa1dwVnB4Y2VwRE9ReTF3elZ3a3FDb2VjNDZ3NWd0aXBH?=
 =?utf-8?B?OXQzSzRZZ1dOcHlhUmFDOU5Lb2NVNS91NzhCeEhqZ2crSmpaNkttdDVWbXRo?=
 =?utf-8?B?VnN0cHRUZTNLWVBmandPdWhJRVpNeXcvMjBaenowczBLTzZGVzBsZmJTUlRK?=
 =?utf-8?B?eHIvS2Q3OTBwbTQxakxHa0hkWHBsRTM1K2diRWhXMGR4eFpTUGIvTTBmb2Nl?=
 =?utf-8?B?RW5abnowMnhWL2hjVjN1MS9TSVV6Sy9UWTdnNUVJRlFqTUdPYlA1dnV2Ylds?=
 =?utf-8?B?ZWwrUUZFeGxlVWwybnE2b1lXdkZBVm1JR3AvMTAyd010N2htZVZPSlR0Wk1J?=
 =?utf-8?B?SWVJM0M5UDlVZFVsUncvS0tielRHUjFLVldJNTdEcUQ5VnBkTHFaQkdER01Q?=
 =?utf-8?B?NThFOFVRbGdVNlBKNk5tdVVJQXBVZUY1Y1ZLWnMrb2VacVJ6QU8vZkMrT3Q2?=
 =?utf-8?B?WFVhZXNJQ3pnQVdqSnZLL0MwRnQ4NFJQWnVBeVZMWVAyNmFyV2xpWUV6eHN0?=
 =?utf-8?B?OWk5WUZ1VFdpbVVBQ0J4cllhOGlrSkk2R3ozK284cTFFQk5KRmdYR2VxamJ5?=
 =?utf-8?B?NGxNdFhxNWU3K2Z6S0ZpQTRQTSsycHV0VW16ZEV1dUxpZjYzN1FpUkhxWGkz?=
 =?utf-8?B?QkE0MS9VejQ3MHhTbWFGMUREMzNlUU5jLzEydkpISHZhSTBKRTdNRFVFMEda?=
 =?utf-8?B?WGQ5anUrV3BYMyt6dno2emhkY0xLeTZDcmo1cjlQNGFOOFUyT0swU0xEYmZh?=
 =?utf-8?B?WDVGbS9VL0VtbGdmTjdEZGhWMHNoZmkzNEc1a1Ura1hYRlBDTVB3WnU1WWhM?=
 =?utf-8?B?QWwxSndRdkJaaTZJOHBnT3o1SEZMellKVzJ4Yi94RE1PQ0xqQVFCbkJLbkZy?=
 =?utf-8?B?RWczV013elpKT1I5bUlmaGJHUWZvNHZEVUgxRHFxR0hKUXJ3Qy9NTTMvcWE5?=
 =?utf-8?B?MVV5MjJsV3ZLUEpwNlJHN2VuRkRKZXhud3YreEpxWG9CQmlQM1MzOVpRVHUz?=
 =?utf-8?B?OVA3cWVCa2RRSTd4cUE1eXRrUXVKQjNOUGxWeUc5dENQc29SSFFiWDlOdUFW?=
 =?utf-8?B?SWFVUHhkUGRNbTVlRmVoM1JvWlovNi9HTmtHU1YwQytUZS9yV29USVFwVHFO?=
 =?utf-8?B?UVd4YUsyalZmUGlQSFowblpDSWZTdUd4RnQ5dHlrZWQ1MDVhbXphZ2dnRkhX?=
 =?utf-8?B?dVl3Mzg1Y21sSGtOY1RVbTc5RmdSVU16eEdUVjl0RDdnL0FQbDBZZHVVMEw0?=
 =?utf-8?B?Z3RnVDVST1BkeFhCY2paelR6VitWbzlNTWRZc0ppSWF6R1VpejFkUjFmRFdR?=
 =?utf-8?B?WVlibGg3YzE3QnQzQ25mdHBFaUxtSlBVUDd0N1NlUUlHUmFjbHk2MUdNbm9G?=
 =?utf-8?B?MGFiNDlWaG9sc0ttajdQVFl4NUtBOGl4Tk43aGZjYTZsOXZuZ0hIOHFUR3Zt?=
 =?utf-8?B?UDdFY2Rzb1BpRDBVNVQyOGV5d2I3L1R3OGR2blhUcSs4aFI0c04rZUw1QWZ0?=
 =?utf-8?B?bk5VSWJjeVdaOGErZmNSTFgwSS9aUWFySU8zQ0JINFREcGVQTlF6UzlLMUxq?=
 =?utf-8?B?NmpiOGV2anJYMmExdE93N1RNYkpYSFZRWUR4SDlIbXJJb2t1eVZlOHAzSmRm?=
 =?utf-8?B?eFNxc0NSQzVQNFc5b0wzTFZHQkNVdGk5dWpPdmVYeFFuNldKU1VidldUQnIw?=
 =?utf-8?B?SWNjSGF0anhWeG9TVktseUlycnhpMGx2Q243TjUvQUtRNzRrVGtuenB3NWwx?=
 =?utf-8?B?MGRGZ2ZhQkxOMngwVldwa0dGb3owSU8rN0N2eVZOVUhmY1RDWlROSWRYQW5U?=
 =?utf-8?B?aEJDOWhhN2dpYXJYeGV6WEpqRmI1ZUpiSUdqTFBBcmRvWEh2VFVMY3BiTlZJ?=
 =?utf-8?B?NGhRb1pwUk11VmxXZkdidW9kQ3NlNHNuVk9nMVN3MWhzaFZuK2cxM3J3SEtu?=
 =?utf-8?B?QzNQSmd1UHM3bXVCRklrVEZVSEd0OEVielFjc1lFQ0xqN2FwS0E0YmNtZ2Ft?=
 =?utf-8?Q?q+xkWezV1s6huA9VLK4EpSdNz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b19caf-335c-4017-a387-08dde4e547b6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 21:12:36.0646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUix0U0V/DzaopdTJkWFGx6Q3WKPyGhvjuC+l9NnGzhyeElLezoYwC8a+y4o8/mx/HWk18hdzt5mtvuxJQS8bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261

On 8/26/25 2:00 PM, Danilo Krummrich wrote:
> On 8/26/25 10:58 PM, John Hubbard wrote:
>> I have no idea "where appropriate" is, here. These are not hot paths, and
>> the existing pci.rs methods such as Device::vendor_id() are not inlined,
>> and so my initial approach is to just not inline any of this...
> 
> I think we can inline those functions that only consist out of a single 
> constructor (i.e. Self {...}) or a single function call either way.

Got it, thanks for clarifying!

thanks,
-- 
John Hubbard


