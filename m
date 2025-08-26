Return-Path: <linux-pci+bounces-34694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C1B35183
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 04:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E872124473E
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 02:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC4A1F7580;
	Tue, 26 Aug 2025 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pBHZ80op"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7486F1F2C45;
	Tue, 26 Aug 2025 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174792; cv=fail; b=r3HM15PuVtA/xZpQKIqX0jpSm9os7jLc4JwcEGRBG0yEeEOU22oqolmzC03wmtdZFon5xvKCOGmvKdtSCG3QGqpc3xr4LSpJq9OlbSTLfIAuwNNdZl6FD7JYamp04V5RnV8yEf1C2vXY0YVWZ1ygitW123/B47zk9LdNRkAKnUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174792; c=relaxed/simple;
	bh=+GekuV1hKbOBUGa+cZokJHCAdSBze0k7Jr8A5k/uQSo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IgQhAc91jKlmNZyAeG/H2XmvURcoVgi9HYiwWHAAU7yiwZ8xarY751UUYwbakAr7XKsrlQ12ifp/IPPxDfPWrywYwWH3MuTMq9EkB3k/eyHAfBVwfHZlGLuNelkG8OC+J1B9P3EII7BcDzNOhEjpLfdsReq17cOxb/zXaoaghbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pBHZ80op; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7DKqtPaRq5QtixIC62Zbu0Z35kvbpp56jRVzwFAXl1uQjNjqCnoqsdGX+mjugZ76H2AlTOePLf93TphVHYrjS8/1rNhWgjn+DPBCV/jFVJMBN5ISsTofsajX3a3CV5Qc3Db4yJPWzx7j//Nw2/9UUEpumb1hY2g1IhdQt77Aif6POcjUFr915B4TK8LUGx3QPiuKPeIefaD3+wO6BfUkp0iAqSx3Fty5nh1Ckq/wSq3ynOj7bs/pe2vKULRRudixSPoyDuGDXSRsWhIjKz9a+lpgisjNqsfOH1v9I0KktZ4uZzuC3vEHQQiEBOYx4Yp4XGlIEg1x9bH23aIb3h9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo15Ciu6oqpS4fBmcOpvVvAo3rRsh4JWXEx3VqrX/Ns=;
 b=nzl6c1YfxftAfb2zj/ZgcNtLGAQBwGbiKuIvYkWpepWxjMt+enxSHXrhXkvrLAEOnoeoLT64uOKDnbYoTU0CPi2/AMxi4sL06khD2eqPCdJLpd+qsD00yeGjECk10U77SlOeloW7FoS5msV4zY3pgLgrWS7mRoWDk09v0fPGoEGBTOPTpFrRYJ7rtk6VQCqR1eNkN2LMBSGrp0XPueXeYFR7+fQdte0vS4TFqYLFTuq8omzQS8ha8Y3KI0SKeFsRtpUfc6yhxh7up9hQwRYXMl93GoFeNPSKQcQxPALC9Og0ulCjetXzw3ORw3FG5qQXyfByeZsZ3AzC5nEmoFqi5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo15Ciu6oqpS4fBmcOpvVvAo3rRsh4JWXEx3VqrX/Ns=;
 b=pBHZ80opFCfWxKuV+TveHU6YqcTTCtFMnhIAbf6zaZzlx/Ks+oBIl7VlXTygpmiZ/CP4WPzNLNEHqz8W5kBChRUjpJaHRkWPor3G9+dRSb35RNOI558i1OsMR2HCQba3g9kVXX3SSGy3qjws0t7DZFGavJAa3gcQGwxhtsMBNNrSv6Tr10MwQUfzgnNdUyQ50pvaINeqfGPSCXyFPjpZ/2wNl9ALDdNb55+Gutni8yV5Pq4Qawh5m3s1nvvtZ0rd4zWocNqUx0soPiL1RaV7T6t2X94JyslVby55H2TwVIq3xGgCCdGwlBA26gRdWpwfiGEzq++UzdpkywnQrVS/BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 02:19:49 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9052.014; Tue, 26 Aug 2025
 02:19:48 +0000
Message-ID: <f0d38862-5d4d-4418-b8ab-d7d7b3c63b67@nvidia.com>
Date: Mon, 25 Aug 2025 19:19:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] rust: pci: provide access to PCI Vendor values
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
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
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DCBIF83RP6G8.1B97Z24RQ0T24@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::32) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d48b375-ba25-4cc0-55b3-08dde447081e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0xjK1JlRnF5d3FIR1NWc2ppVDk1L3MwbTlYTWIvUFl2Vlg4Q2I4aVE1OWFN?=
 =?utf-8?B?dmMrZmdsTHA5SUFybnhUbnQvR3hVZWM0cVlhSndSQWpTWGV1cW94UE5Uak9m?=
 =?utf-8?B?ZTBTSUdRNy9acE00c1lFN0psdGkyRW9QcTJ3K1liZlZ3TWNNRkVXbUJQYm5H?=
 =?utf-8?B?ZU8xR3NEWCtQTW9Fbzd1Mm1jdFJzNElyZG5xMyt0OVNjUUxmV09XUXZaZjJX?=
 =?utf-8?B?cmp3R01kaHBPbEpJWEhzelpiTXZoTm56b25kTE9IeTQyZlM0M3Z1QUhtbHVL?=
 =?utf-8?B?dlNkWXpSWDdaeUViMEVMY1FWZVAwK09FWXVBcUVpdUNjYlFBTkNQKzJhSGhN?=
 =?utf-8?B?aXJwa0d6TTRENnZVV3ErSjFFMUZ4eFVjWWVMcEtaSURYWXNkbkthK0pmWWRZ?=
 =?utf-8?B?Rk1zWkZkWnJGNVBWc3piOWYvcVJZVEFpejFxS1E3SGcyMWI4bU9nNGxiM0gr?=
 =?utf-8?B?ME1MVituSWZ2dXZzTzVTWTYzWC93M3FlNE9JN2hzNGJodFkxSTVGWXNnZlpT?=
 =?utf-8?B?elVkZnNWN211RjR1MUZ3dU1kcWwvSmtOdHk0QWR6NDd1eXZ0YWNQY3VFQXM5?=
 =?utf-8?B?bDV2R1I1MjNpN0JoT3dodUt2MnBJdjRuV1ZacGI3WmZBekovaUIvRkZGMDhs?=
 =?utf-8?B?OUZGWXVpSGtjemRrTm14QXUyWm9XSVdveVNQZmNXVmVEMjNUQ09BSVFZc0ps?=
 =?utf-8?B?UTNiWDdtK1hVMjVod1pNUmlXU3FHUkphMVZKaHpuQ2RZa3JEMnQ1ZDRMNXdu?=
 =?utf-8?B?ZjZPREhNdTMvM3lzQ2RaNENQbnAxZ0tqaEJOeVFyeDZNQmFPSGw4OWYvZmdq?=
 =?utf-8?B?TW9tbXFUZ3diZ1JIbDd1c1EwS3BWbWhvTWg1bDY1Mk51NkR1NjhJYU1TUkVB?=
 =?utf-8?B?TEJaUTRZd0xwUk5ZSm02Y1o3L1RHTG81cGFGVHFCY0p6OXNCUlI2MldneHVN?=
 =?utf-8?B?bHExL0lSQUNDNHVzT3lwWUhlTDNibGNpY2piUUExRndmMTRNTTB1SWU3bTVY?=
 =?utf-8?B?ejFOTUtrOXNGdlJ6YUlVL1dhWkVoQ0ZKTFpPWjU5dzltS1NzYmozWkhyNUpJ?=
 =?utf-8?B?Mi9PclhBcFY5ZmFuL2R0Mjh2U0lnSXFSOVMyWDNOYzJFOHBnRHluK2JFSHVx?=
 =?utf-8?B?REgrZkJuQzNueCs3OUJoemt1TWsxQklrOStNOEZIVGxPNlI3Y0I4S0I2NE9h?=
 =?utf-8?B?Z2kvaUxjZVh2WHZXMzBndGNWWHFTZkVnVzB6MjJIa0JUVWFtSGp1a2xuaGhO?=
 =?utf-8?B?T0M0bnZ1RXI2OXhQQ2RzV0s1Q1ZtM2JieWtHdGMxOUdhdURndDZRdDZLRTEz?=
 =?utf-8?B?YllBN29wbTNUcG9hMXphbm5CZW1NYmNLendKV2gyWnlza2hlTVcvaEVjbEhr?=
 =?utf-8?B?c3NkaWlzRVZNK1FvU0tDMVBDeDJONTZXSStSRmtRQWNJVVdXQUVwc2xzVWpt?=
 =?utf-8?B?dml4M3N2NDNWUnd4aEoyajY5QlFIbWh6U2tRbFV5ZUVMTDhDZWs1WjAvNytl?=
 =?utf-8?B?clBhNzJ5N0thT0cvak9URDByaGlKRERhemJNNDFhWkI4a1U3RnNtK01tczJ5?=
 =?utf-8?B?cmhEZGFkTXkwY1FuQzJBdkpCME1SQi9FSDE1REhUTmx4S2p4RkY2Q1NlMmZQ?=
 =?utf-8?B?Yis3VDNNRkQxUHl2SFpMUE9ucVdaVE1IcVptUDRSU3dCMmU4Qk52czFqbm5S?=
 =?utf-8?B?cnNSRGo5ci8zWUwyalhXa3JsM0w3b0JXanV0cDBaSlEwNEFkeEVjZjlLdDl6?=
 =?utf-8?B?YW5mc3RVeWFJemMvRUlHZW51YXVEU1FmNGFwb2dTWDVuc0tZZnNSdnFRV2tV?=
 =?utf-8?B?YmhXcXpqQ2lTTU9MVkhIT0ZPbmhNdmFBWFJMSFhsUmhIbTU3YUdRVjJOWFZQ?=
 =?utf-8?B?Q0M2R2drdXVFcWplTWNwT3NGWTZiQy9lN2t4REtwOGloZnl1a1E3Mm4vVFRM?=
 =?utf-8?Q?TZ66yeSZxKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzZlRDc5YVdhajNMb2oyMnRwaXJGNmJYM2dSNnRGYTRoM1d1U2FMeFNLMDhs?=
 =?utf-8?B?V2RLZm9nM0xpYUh0WTR1VlN3U3lUOHBCR05pSGE3a0ovdWdPWTV5WkplN05U?=
 =?utf-8?B?eDUzZ0p3VU5QT2VjV0RWM0pKbkVZYVo1QzZXYk1xWXVwNFVhdWlQcjl2Sjlt?=
 =?utf-8?B?UWpOUytMU0hlKytoaWdyY1lYdml2Y3BRWXdsaEs0WDVlekpjZ2YvOTB0QW1Q?=
 =?utf-8?B?V1doTXdqK0Z1aFFQUVpnYVZTaUpYUnRER2N3MUp0Q3VYWlA5WmI0TnZLWUFN?=
 =?utf-8?B?d0Uxa3QwbE5KVGV4WEhqNmpvb1hNaFoyVFpJNGFmQlpvY3pEUkJnOGxxTmJk?=
 =?utf-8?B?VDQ5bHpnazF4V0hrT0NTUjZpWUIrMU5pR290UUp0U2ZkOFY2d1JsRlIzcTZs?=
 =?utf-8?B?QnE1bnVxYkhaZE5yUHF6QzlPL3I0cFloOXBMTk5LbU5Qbk5ZamVXU2NzRHFP?=
 =?utf-8?B?b0Y4Nk5DYmVBOCt4NDdHaTRick5hU3pqaEFmckkvNzE5TWlJWTJmc21HV2ZJ?=
 =?utf-8?B?NzE1MHR1NzZBSGRUdEp6WVdVTERDTXlvNFhFLzN0TFlUaFIvS2gxZ0Q2MWFV?=
 =?utf-8?B?RU9xUEhHcSt3dVEvNHE5dkx0WXZQUStlMTVCWHIzSXRVa0ZaNkx1eml5bGNF?=
 =?utf-8?B?UFNkTFZEekplaDFhMWZna2d1N2dSMUxxT1Y5aGM0bDdGdWQyblZ2UGlqMlha?=
 =?utf-8?B?UVF6MnA1cGJmMjJvRFlHenV5ZW51d3FiZ2ZWWEc4eE8zRVpnWEh3TFltNTht?=
 =?utf-8?B?U2l0WnYyT0hOaEV4bWM2WE9Cb3QzMkQ2WUhTOTZMNUszSDFWa1I5WWpJS1o4?=
 =?utf-8?B?OGV6R3hpUHQ3c0RaNktWSnJhZk5BQVF5VnFrWEI3Rm1reWExOHh0MWRKZk1I?=
 =?utf-8?B?UTVhdnJrSWVwNXJ3Y0tnbEwyV29ia1E1WWdaMTVMS3VJWWl2bDBWY1kzVExy?=
 =?utf-8?B?cXphZzBtK0kvaVQvc2loL0lOaEd2K0xGQ0tZeFZuckZVVnpUcTFzU2pmRU93?=
 =?utf-8?B?ZGwvaVR3Skd0UHFTa0V2WWR2QzBKTUNHY3dDSTVqQkV1SjlCNHBoQU01RUt6?=
 =?utf-8?B?ZFZkTngvdVc3VDZlR3grczdRZ1B0RG9wM3gzdEc4WWYvV3FySmo1Smx3MXZ3?=
 =?utf-8?B?WU9iYWMvZFFXZjJIQjlEM0NsY1pzYjFsSGVmUmswNmhCVEJkbW5lNDM5UVZn?=
 =?utf-8?B?dE5zQiswYTZ2bkJLK05Xa3JSN2I1S2tTUjcvVXpyMTJXVlN5K0dvUmdrRDZt?=
 =?utf-8?B?NEREVEJJWS85VWM4c1BMRjBvSnV1SXh1bFhGLzJFWVA5NWticU44VjlITUEw?=
 =?utf-8?B?S3RkUHB3by9FVks1dUdZUG4zOW0yUWNmUjFTMW4wKzNsZjVtRGtOUHNrVHNj?=
 =?utf-8?B?elNQTCtvNzJ5ZThuN3pzWWhjbHFhY3RoZ29hcVl3Q0pMbFJicE8ySkRGd3VB?=
 =?utf-8?B?cTVEN2hTR0JPNHJibVlsUjRCeU5vQ256eVhrblpZQ1pwaGd6bWdMVHp1OExC?=
 =?utf-8?B?RUVRUld4OU5zdCtpUXRFbnpDc2tCUzRzaSs3WGNVQUdkbXZPZ1VOcElienpx?=
 =?utf-8?B?ZTF3N1ZOa3MzNG9zZm5FdVRYS3U4aGppQTBDWmFjR1E4S3lWd3hWMnUrWURO?=
 =?utf-8?B?UTllUjFqbGhuMWxnTkIvWkJBL091NGFrUHhQMEtON0ZKcUh0M1RaVHROWDJ4?=
 =?utf-8?B?dzVodHM3OEtuMEFnV2FnTThyR0VHU2doSjRTVDZ4V1F2SW1JS0pFb1ZmMXla?=
 =?utf-8?B?RkRuMDZNeTFaZkcrbmxVcEpMNFk2YTd5UWQzbkp0NG1BTDN3ZTFwb0FhcUlR?=
 =?utf-8?B?NEttSGlPWjRNMTJ2cWRSYXlLMjF2UzJkSktoc2hKOStWdDcwWVRSRnpzNGVh?=
 =?utf-8?B?VVNaYkxpdTBSVjJ0S1JrZU92L1BMcnA4NGJURGN3d2ZydHlHeTBPRkRiMkQr?=
 =?utf-8?B?dnB3NWZ0dXRTdTdjb0VEeEJYTzZML2NIL3JrNnBmMVNVV0xJck5lZ2k4UE1h?=
 =?utf-8?B?dXo1SWlGbFk1NGpaZm8wWms0SHNrVWxtYmNaMENvVytGekxUK0NFNFFsV1pz?=
 =?utf-8?B?aHVLQlFKTFN6Sld4cW1oWkM5eE1xV0UzSEhxTWtSM1B5QytCMGFZSnhkd2F6?=
 =?utf-8?Q?mceYAjqNEswmcpXcWDK37sDe/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d48b375-ba25-4cc0-55b3-08dde447081e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 02:19:48.8227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrA3gtcW9cWjE35tEuMlUrP7S3Bc68TCU4U5U7U5C6L4Z3GGfGxQbkniDwpbd22iZSkzp7iGWZ9UgejR6cckww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589

On 8/25/25 5:33 AM, Alexandre Courbot wrote:
>> +/// Once constructed, a `Vendor` contains a valid PCI Vendor ID.
>> +impl Vendor {
>> +    /// Create a new Vendor from a raw 16-bit vendor ID.
> 
> The argument is 32-bit. :) Which triggers the question: why store these
> as u32 if a u16 is the right size?

Good point! I'll change it to u16.


thanks,
-- 
John Hubbard


