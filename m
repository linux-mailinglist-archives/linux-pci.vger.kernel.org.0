Return-Path: <linux-pci+bounces-37316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B16DBAEF28
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 03:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55D319428B9
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 01:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F05D1D9663;
	Wed,  1 Oct 2025 01:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eoj30XYb"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32706BFCE;
	Wed,  1 Oct 2025 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759281799; cv=fail; b=eVfrDvDtVJzepHiAy5+ammE7/uMYOGnE5WjOQn9EBUdpTXqWGdadMKPW5iDd0vDRJ981f2GPUhltAvMkpmdmMp5aw9XXVSPrWVn4lgGhHFnXQOQo1dqcHycpBxvyFnQckyeh7/qhkgCPCxqZWQ/S4HHjrhRnXjvmxMG35aRYvhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759281799; c=relaxed/simple;
	bh=Hc44pNfW4vN0BOY8Cmw/4fqT1SU/W6fsgbH29Qe76KI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rM6/o8tQIOJ2t1VAe4CsIOGX6Bw/hkCZdcr1OaKysgAJGk3OeflCg139IRjpUe5vu0r2sgfdvHH6cdsLvQJyYBzgmF1sFkDt2yp1Igcqgvzq5yleq4RBqTdMG6wd0xE8kCnXlbFYjFMUWdUNIJnTpDL2U4b9t0Q9ZFjBk7LvdLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eoj30XYb; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odctdhUC1NqRErjkpRD4dmODx1oihiWV4JOtm+FUFaV9mY4LR3nVh5Eu5q/SYTnVHTplPOwUbKFLnnnn/R31Yylmj+QwyeelEoPq0zrAzI4YJ0oYE0wNUweMAtOtKmcYdMIKYaJ+eKDNsFcbug1yThJKKXmSRpgDZguGcXCZFzcW62vRlBXbRK/ohGsZxGGPvYzU+wbt0ZWLw9iCB1Hz+V/DcrOkqJUIT+wJpdBsrQKQpdwlw0wsNAUewY9Uu1gjutMRc5DWnXB5raqz7swfm5kuEO1k8nH+s+qy+1y9jHyf8MW9VkLpRPwdxkoQl3KbDa0Yqxi2u+DhOG5gKjNqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEV8Oae4PKQkDsadb+NiRZwrdzlzUmLEj9B3dd0un1I=;
 b=RMJ9onc1AJa8F+oOQqhaceK15BSipURBkA9oUps/AOwBR8yEkv6egNKCYsD5ulKfPqm6QpErBmTs1yLcy1Nr3Tdi+rpTeTfp7p5OnTGlRs/Fk2T1EcywTpAwOvivQjt0fhykTROiJmCV9CQqUyvFy1ArJZi7AFZ8NjyOqO3dP/Ed33NaIuuog21ENYMX4eNp3ctATZa91gRSjqudaKQbDAIFs+Ep6N6Gv2sUlhBpJycu10JBwAfyeNxFdz5IVTm2cYBa/DaLJS6eo12R8xm6si0zCSrTuq7yv8+zHEFeRMeozoWcEBScDuK0h7VYtsGDoNWLjNoIza8/MBynvUkAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEV8Oae4PKQkDsadb+NiRZwrdzlzUmLEj9B3dd0un1I=;
 b=Eoj30XYbdtWhPrr/O/aXIpaO10IqPGdejatoOAul0PBu6GGwB7ARmCW6oAaLTvczvDEAFNxMbT98f19gcPxj0Yc2RZUVSVTiakgu7yf4HTC+jQgR8rSrzvLNKApnnlnYOr1CCXRNa7XmhE3uNaCj02CuhbNH37GydWNdXcvJCboe7IJ09vLZEozFngK+7DHUkK5wO5nwPD2kQWV92vpFPtklFf295XfAE2NUY4DHqoJ17i8Bz7g0zqmrK1eKECkdFxX6noyDT6m4m1EzHJ4g5OqSZzWMrgYj9eXGsvWhVsxYg5s59HGo2vV0oJBxtowTP+BAHszaJtOxQwJxefjqNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by CY8PR12MB7124.namprd12.prod.outlook.com (2603:10b6:930:5f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 01:23:15 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.014; Wed, 1 Oct 2025
 01:23:14 +0000
Message-ID: <e77bbcda-35a3-4ec6-ac24-316ab34a201a@nvidia.com>
Date: Tue, 30 Sep 2025 18:22:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
To: Alistair Popple <apopple@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::10) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|CY8PR12MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec430f4-f500-4ca8-3bb1-08de00891802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzdQMlh3dFpBWDBwa2VOSy9SaE1XcWlXMnA3SndMbGVCUmVrRTEvVWdVYTBI?=
 =?utf-8?B?cWcvYzJiWWJjZjF5MmJmZzlJTnBiRjdGV25zNndDQjJHNjhqZmlnSmF5eWdZ?=
 =?utf-8?B?RnNrZlFWUVpFRFhNNGJPNGlxSWh0UlZ0bzNqMFFpRXJjSExaeFE2WW1BczNE?=
 =?utf-8?B?ZHREOFpBM2VYakdOc1FCbWJWN295MDI0SEtrQlE1U1hUdDRldFF6aHNpa0lj?=
 =?utf-8?B?U2ROdDBHcDNQSkpvVmdtMk1TSWRqa2x3NWpXdEV1aEprOXVOa05ndUpONDhT?=
 =?utf-8?B?NWNEbExwZDBWODErMC9TYmtvb1JJMUN1UFdlZ2hXaUpxTHR2NEZEYW1WYU5x?=
 =?utf-8?B?SldYdjBQcWVtNmJsVlhETExzSjVFSTJZaG1pK0tXeDRlSWJjTDNVVUFOZzhv?=
 =?utf-8?B?allteWp6VHFQMEUxbzVJMFZZVkRWcVNWeTVGR1FGenlidW5vcGRxUW1GU3ln?=
 =?utf-8?B?b3c0ZDRjcy9JSE8zZE9LZDA3U1JseTZpNzBpa1BxQWsxMWVIemN4OWwydlZI?=
 =?utf-8?B?NDJoR2FITituU0tVU2dlQWVnV2NmNjZ0NlNLbDRMY3lUcjQ1S1Z0cmxhbnNV?=
 =?utf-8?B?Sk8zejBmUlUyaEsxbURsZ0FoaHhuQ21pUFdnbHVqSzVpeHVkNmpWUHZWTTUz?=
 =?utf-8?B?OUtlWG9YMy9ESnI0UU1HVWY0TS9ENUc0RjY0ZW9odWs5T1dKVjhXKytKTW52?=
 =?utf-8?B?dVVkR2ZPVUtCc04zT1dLYWgyNElqYXhVZmVtcVRZbksyWlJjU2thU3hOakc3?=
 =?utf-8?B?dmxEWHZ2SlhOTTk1MVQxbFFuNXJmTDlZODdxVHROZGp4akZ6QlNtZlpLeDl3?=
 =?utf-8?B?VHFLRHNyMzg5c0FzR2lFS3ROVWlXTk1iZTE3WDFZbHMwTm5iUGVzL09oN2hl?=
 =?utf-8?B?WFpNTEVtSzJ1TGE1NDl5aWRMcUV2c3JyM1BOYy9hSzNkUkhWaVZKWnpISzlp?=
 =?utf-8?B?dThpUUZJTlcxSThacnF1SEN6VU13VkpYTC9uSW9uZUFNeXNkSTdJMlUzZi96?=
 =?utf-8?B?Sm52UmN5TTk1WVV1RWc0R0VBaHdwSEF0cy9ML2RhQTJhYkhDakJpWXlhMXhm?=
 =?utf-8?B?VnJsV2hYSWVqNE1wV0ZEbEkydzNkMkNoZGdGbG1kbWtmdEhSeGNBOTFwcUVD?=
 =?utf-8?B?d2FXQXNkRnUyS1ZDMlFQeEhoQWFXSUdaREtXOFVmZVE4SllWUXZ0cUFPdUdB?=
 =?utf-8?B?cXZ1ZGRBRk94U0poa1BqbXNLbnh4N0tKVytXdzNPN0ZacnZmcVloZjA4aEtz?=
 =?utf-8?B?REJMSXJtbk9qTkREbWlibkpEcnpDOFo3M1VQMUpxRU9GQkRtRUUyYmcrVkJT?=
 =?utf-8?B?OEpaSEx2YjFuRzk1MGxVcjBDTm1zT2U1cHZicFhlb1VQOXE1MUhsRXNYVThV?=
 =?utf-8?B?Slg3WmZ0YVZQTTNobGJ3L1RNaG0rbGFNYVdRQ3BaR3pYRUhpSVgxQXB4TEVp?=
 =?utf-8?B?UG1GeG5jaDB5UElZcjdsVzRlS1BHSWlFMWlqeGZ6SlJWOWN1dVg4TkNsNSt2?=
 =?utf-8?B?b2dpbWluT01WNEQwKyt3MGtsUTNSYWZEYTBYK3VDY3F0Zk1LdFNIY1hVTU93?=
 =?utf-8?B?M3NLdkpieGRvUElrQW5GaU9tVmYvdmlxZWF1SDlmdkNGR0lyUjQrcmE5VnBH?=
 =?utf-8?B?dHJIV0JSaDgzZHAyUU9lRTRvdVFJYnY2YnQ0Y1JhWlRNZVVkSzJaVmFrYjFu?=
 =?utf-8?B?WjlNNFJxMmdpZGhMNXZQaW9hK1RKaEtrd2lMVTYxUlpyUUFmZ0JHZk16UzlX?=
 =?utf-8?B?dTI3dUV3QTcxQ0ZiZHAvQkpwWTZRUVlwM3cxZ0p2WkNRWFYyZHJBa09GMDRM?=
 =?utf-8?B?L2VkQ0VhaEM2N0kwUTNtQUNRTFVOb1J4N3pKbmRIUjVSSnBWTkI2WWFCclVl?=
 =?utf-8?B?VExkYnQzaXlrdnhOS1EyVWFSbVdFaWk1NlowMFRDNjVwK2Y1elB3SmN2VWhj?=
 =?utf-8?Q?GYhCAvqc/HpeRs6L5Cqu+8M5NmBJfgwN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHYyQWhOR3RDS0c2cUw4Z3BNUnVHOUdmOFdOZFgzenNmTTk3TVFBZDFzUVlx?=
 =?utf-8?B?VnJUTkcrTlVGYStmZDErQmtyS2tLejdMYVgyM2oybW41ZDg4MjZxOE1WU1VZ?=
 =?utf-8?B?K3RuVHNUcUFJdzBwc2dsZzg5MUExTzlBZWwrS1JubzIybUJ2U2JPVGZDbXg3?=
 =?utf-8?B?bEE5YmgrTmQzY05Wb1RGTHlJUklkTndFd0xQS0tvL3RrdnlUWXpCcVlTR1dz?=
 =?utf-8?B?OWVWT1U3RFVKbFlvYjhRN2JOT2NVMGR1RFBlaXplTE9zUFM2SGFyVFJUQjRR?=
 =?utf-8?B?TnN0Qk0xR1pvcWJJMnVYaUxmRlg2dXpJUE1CWFRXdTlpSDc2U29jSkpnaS85?=
 =?utf-8?B?NVZLU0JZc3VxOEptNTdGcGQxcVkzRXV1TG5ySmgrTlN0TEs4TXJ0eEhnUGVH?=
 =?utf-8?B?S1ZleHgvNnJVUm4vQmx2Y3QrK3gyOERGY2FYa05TWnBFSEZKeUR3WjdxMVZp?=
 =?utf-8?B?TVFQNHBwb0hORno2Rk9xc3ZLU0Z4d3E2YUdFa0NXck5lZ2xKaGJxY0llN0M4?=
 =?utf-8?B?UW1qa25vV0NmcHlIYThvdFR4VHg1M3pyUDdSTk9jaWVVd3FxdFpsM3lNUEFG?=
 =?utf-8?B?SkZlRTE5SUtlT29WV015OG4zNzdvU084VXBpbDR0R01XWWNmVW53cFgzZ0kv?=
 =?utf-8?B?NWhkaVhCVXRzY0Y5cmd2em0rTlkxVDZReVJYUlhhSzAzN0xWUklxalpjTU85?=
 =?utf-8?B?SHJ0ZW9LV3pLTW9HUlJtRkZIVGJjRUs4R1lUK0JUWjdzQ0JBODd2ZWhHakpF?=
 =?utf-8?B?bURUSFRaZ2VtTVo0V1FQakFZd3g2WTViRjQ1UEZjK3AzNFplY1hLNDl5cEhv?=
 =?utf-8?B?THQxK1Mwak1pT1JIZFJMNHkvUzNETExxVkpqZkZkSUFSNEZpYTFwcmsyMXgy?=
 =?utf-8?B?UURBSXhGaTR6UHZCTU93U1VLNm03ZEk5ZlR0TFM1NmxLcmtUOTlqVGdsVG1P?=
 =?utf-8?B?eEZOR1pNUWNxazF6N0FkdGozU3lPRjVEODFsS0U1VTFVTEpsTm5GejNseVQ3?=
 =?utf-8?B?bGhVZFZCK2hnQjdPRWF6LzJybSt6eHpmbk5hRlZCaWVVam5ySkdvbk1NbEV2?=
 =?utf-8?B?SmgyUmNzK01UczVkQWFlYWF5L2FEZVpYWFNPOGhIRjdoblJyUjdSelorZUds?=
 =?utf-8?B?K1FRb2dQZDZVc2NXSjVSM3gzWmpPNnpHSXlGMndnODRTUDlsRzhVQWVmZGN3?=
 =?utf-8?B?VWVCa0JkbFhvTGVZTUNWY1g2UytnY2g4Y01pNFI1bllpaVVNUHRkV1c4RmxL?=
 =?utf-8?B?NkZPdEJXN1pTS3FXWTJMVk5HbDNQcEJmb2NzL25IS2d5aFRsN1N4UEE4cVU0?=
 =?utf-8?B?UUZTRGRNYWFENWM2NlpGcEJzVjFIWGpXK1huOFFVdm9rU1c4SFY2ajViYTRm?=
 =?utf-8?B?R0tHTkR2WXkxRDFkeHUvR1F6RjBoK2VFNE5ERkpoeUo4dlNNQUoxcFlLWG5O?=
 =?utf-8?B?MjJPMVRRQXNBTTNITGxhTi9JbzE0SUxUL29vZjlMcUovZVd6RGZ4UVJmdlpZ?=
 =?utf-8?B?ajU2WndOTEpyRngxcHNRb2I2dDN5T2o5WE1vTEhobE9lNlE2TE96bGFlNXoy?=
 =?utf-8?B?THhYUFFReTJqb2tzTTEzeFBoV08wWEJGUUkycm1pOFFoWUtrMktoOEhDUkNI?=
 =?utf-8?B?UlcyQU5XQXpRVW5aN25mZEdSa00rUDJPdkE5OTJDcnhPaG1aTks2U1BLTUJS?=
 =?utf-8?B?QTZkKzk5cHhQcGk5OXZtaTl5dlNoc0Z1bTIrMks4N1VmczNERTF5eDFhNmF3?=
 =?utf-8?B?blRELzJaUitBS2d5Ty91QTY5RTdaQTQ2SGphdU9YUDhOQWRreXVMZlFrRTdl?=
 =?utf-8?B?Mjc1b2M3RW5MM0tXbGJxQ2E4Z1FUN1VsQ2lPVE9FSGFyTkRtdFQzY1lwYldW?=
 =?utf-8?B?Z1ltK3ZPNm9QVkVoengyUERxbW9VS2V4OTZ6TEM5ZHdzdGdiV0o3aHErYXVB?=
 =?utf-8?B?YUI0c05hZ2R1cGRhSWVuUWZDU21XOWJYcG82OFlUNjJQeVlpbXpveklaa3pS?=
 =?utf-8?B?b2FpcW1qeWlCWFRaY0JoMGR4K3ozRGkrSW9CUFBGUEJZZ2RJNElTalNHRTBz?=
 =?utf-8?B?eUdTVjJOcm56Q2wxSHR5QnRGNzQ5cm1aTEtBRkpYVDdBek9hK2lmOXlETXRX?=
 =?utf-8?Q?/mpwYzFR/RrX4D8+eXGDcEzcm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec430f4-f500-4ca8-3bb1-08de00891802
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 01:23:14.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL0CKNIFxp9P5XKd+vaKUuBFIFDdB/531WsVZUUru50c3OdfuugwZ7BO7DsonyEJAIdspkRMznAwJ5WunwP3eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7124

On 9/30/25 5:29 PM, Alistair Popple wrote:
> On 2025-10-01 at 08:07 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
>> Post-Kangrejos, the approach for NovaCore + VFIO has changed a bit: the
>> idea now is that VFIO drivers, for NVIDIA GPUs that are supported by
>> NovaCore, should bind directly to the GPU's VFs. (An earlier idea was to
>> let NovaCore bind to the VFs, and then have NovaCore call into the upper
>> (VFIO) module via Aux Bus, but this turns out to be awkward and is no
>> longer in favor.) So, in order to support that:
>>
>> Nova-core must only bind to Physical Functions (PFs) and regular PCI
>> devices, not to Virtual Functions (VFs) created through SR-IOV.
>>
>> Add a method to check if a PCI device is a Virtual Function (VF). This
>> allows Rust drivers to determine whether a device is a VF created
>> through SR-IOV. This is required in order to implement VFIO, because
>> drivers such as NovaCore must only bind to Physical Functions (PFs) or
>> regular PCI devices. The VFs must be left unclaimed, so that a VFIO
>> kernel module can claim them.
> 
> Curiously based on a quick glance I didn't see any other drivers doing this
> which makes me wonder why we're different here. But it seems likely their
> virtual functions are supported by the same driver rather than requiring a
> different VF specific driver (or I glanced too quickly!).

I haven't checked into that, but it sounds reasonable.

> 
> I'm guessing the proposal is to fail the probe() function in nova-core for
> the VFs - I'm not sure but does the driver core continue to try probing other
> drivers if one fails probe()? It seems like this would be something best
> filtered on in the device id table, although I understand that's not possible
> today.

Yes, from my experience with building Nouveau and Nova and running both
on the same system, with 2 GPUs: when Nova gets probed first, because Nova
is a work in progress, however far it gets, it still fails the probe in
the end.

And then Nouveau gets probed, and claims the GPU.

thanks,
-- 
John Hubbard


