Return-Path: <linux-pci+bounces-44966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C0BD255BC
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45F9C3001FE1
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C58235FF64;
	Thu, 15 Jan 2026 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O9nK0dsh"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840A280331;
	Thu, 15 Jan 2026 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490852; cv=fail; b=RFsTKM58zZM4vEgH9d9/7veyc2H0SyIcz5EzyM7R5MCRwdNS7OKLkbKeXP1F2Eu7hN0VeqLuAOUs0MagsJndCkdxSp/3WemO9E5y3slu0nlzqJLA6FA5VnnaQaFb1CZYQKwR+CtM1zcaY/+4LcUS6pxaUU6ONmjKUgn9KMwoAAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490852; c=relaxed/simple;
	bh=rCyQ8NKeoJ80L84eV8aiNP9cU/UA06GxXprFO1v1whE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k6H0MbBGJkgB48Fyf/Epb+DHkh8wXAO41Iol7Jqdk63W0Z5n1x8s5yiatgTV5lbnpzYdNHgkV8vVu9JrhFr880KVVQ32Vktovd0pyZToaNGHZduHtevziv/tN05uaC8+b7mldZu7wGlgZve0VhWIw0pEYK3E8/NhrHjiDgMG7uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O9nK0dsh; arc=fail smtp.client-ip=40.107.209.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNO7C8TtZsg8vrGPQPkuUJwoRm0Cv7OzTqFnqkJbK/T0o0tpSZg+NiqSbPops3qCfF9F61DDPi//nS5knQLZGPNObxaxMnb8YBsYW98BbpLWIy3JWCwpaBLqkaGLVVf1Y0L5q5Llz9NwnEqhD3fg+zqDOYD9iwjjL6c+zbJG2JS9j+4dQk5rLN2bqW3UzKetlBi2wBAPiGQ77pagDP2pdq5j9Fsxi3f5OMtyAN8z0h0qYUrgOYdAjWNGEj0GFAb0rRerMgLONdgzKdlQIJh48gVwnrKjDrITDSBrQtpMefp8AlRIoiD7N4gelDrTjpRMvF02NCptNZkJZQZEqIofqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abuPG13xYBMSgMLudVvGe4xbRdnvJujg+t0ECA3jtEw=;
 b=kI11xS1QU6i0uGEXU7/THhRolI7IP8+eOSAcF1H+KuW/s31b2bCGuDu+Lrlh4QJUodoK+VuH1ChaoKdd4cpsEXoi+vtMReWyIPUuDtO0EOdDwEuC2vBuhoolhBnvkoDNvs5m+IpVJyBrZZ+zS1QRMFhZj/vYu4ZBWHZFRjoiFb9bSSAjusYggkCw0Xxss3xQ7q8zGvAOIY0QaHt3HbjVx4mUyFkFlBrAuTunsrRFMvG4JbKmz0d749wqwLP4uMJxeK6tg1JSdGXpQjYbqhcNbVIJQx29SNR0Jh5lZjPZu44caEN1pwI6fHsdZGRtpRCdeJmtxz2VnPrFfjXKrue1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abuPG13xYBMSgMLudVvGe4xbRdnvJujg+t0ECA3jtEw=;
 b=O9nK0dsh5KoTP+c8l5sOOkjCrFdBSeMTq4K1gaEDqS9fLRLoJJSp1jphIi85Y4ooF0tQTvgbIjn/JWVVMaWHgTSVTCpe+TCgDV65O4eMb007N0hGxgYjGCUPZPwv2NTmhREEM+xS6S4CJReor3AMhHtfnnDeAHEQ4tT4k7fJTK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 15:27:27 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 15:27:27 +0000
Message-ID: <950c4b96-7789-4e28-8aae-23edeb5aeadb@amd.com>
Date: Thu, 15 Jan 2026 09:27:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 32/34] cxl: Update Endpoint uncorrectable protocol
 error handling
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-33-terry.bowman@amd.com>
 <696813ae1d175_34d2a1001a@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <696813ae1d175_34d2a1001a@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:806:120::20) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 30263fe8-e6cb-4dfe-2533-08de544a9701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXhwUWtyaE9iN1FxUTVJSWQwdmN3ZzlBQ3hJMUxYWmhUSGdHMnRvMnNncFVH?=
 =?utf-8?B?Y1BxeUt2Ulloemh0QTMvSFZ5c1ArTkxnL09PcERKaU9iYVZBMnp3UnJYUjRR?=
 =?utf-8?B?VitFZ0RrUmRHVWVQenFuaWRXWlZaM1h0V28yTVNyUk0wcG1Sbm1VUXZ4Q1hv?=
 =?utf-8?B?WmR5TFFiYkpNSU5KdjZoVjZEZWI0L3ZyN0s0Si9GaU5KVnhKS3lqSEdiajhW?=
 =?utf-8?B?bFluQ2FnSSsrQ1Vsenl1V3E0UmQyUUlxbHA3UVhrckZZaU1vVmlzREdpNU9o?=
 =?utf-8?B?WTZkQ25WMXpGdHN1L3NuVVRVbWpqcEhGZjRmSVRYYzVOR1JkSFY4bFZNTVkx?=
 =?utf-8?B?M096UlovVUhjSEYyM0EyMEN1ay9XdVJvTW10K0lkRktYM2FOTHpmb3JTVUN4?=
 =?utf-8?B?bTRUNGgxR240YWhOSlVVdFhjWVJER1BNSDQ3ZTJsT1IwYzZhTFpFd2p4OWxT?=
 =?utf-8?B?UlBDK05mR0lLMlZSckVsYlVwMEh5L1FJa1ppMm9STENKM2pJWk5QTXp4N3l0?=
 =?utf-8?B?T1dhOTNCMzFrcHdVSFowWG94bE5uTmEycWZia0QrdG5aV1pZWXEzNkRyR3E3?=
 =?utf-8?B?bE5ZdmlUazVsZ28yVktSeTd6UDcwNzJsZDZrZEhsRGNMN1MraEp4cTl2NVpK?=
 =?utf-8?B?bnVBbnlqNC9zU29IYnpIeFJqbkw0ZVpJbVZLaHpuZWc3ZjlnZ0lxWWU2dG5n?=
 =?utf-8?B?ZXp6TFBudHY3cDFIL0xPaW9ZUDNwSG8vSzFVVk8wWmlSby9kaWk1bFBPcUFh?=
 =?utf-8?B?cHB1dkU5K3hyRVQ3OTU3dnl4UytYNUEzd3R3YStudTdGekRuZlBwNXFhVFJr?=
 =?utf-8?B?cGJpekZYSkhwK09qcWo0TGdpMUxKcENGZ0swQUtEYU1FRkV3dFVpL2t5ZlYv?=
 =?utf-8?B?MlBSSXNmS0FsZCtHcWg3N3ZKcC9rOHhUcTZwNE05TTFtUkNlTVJXZmpUanpF?=
 =?utf-8?B?eTlBWlM2UU5FSkVtamRTQ1dVZ2VpM3FjNm1jTW5ET0paWXhhR3RkaXEwOXdT?=
 =?utf-8?B?N1U2eDlMYjhmNmdZcmZwRThad3UvR1FmTEVkbnVmajZ1U3M5WmZVMndIZTJM?=
 =?utf-8?B?Y2l1OWUzNFZxZDdwK0tGUW9zQmlZRlFoaVlBZkZVQTZ6MFFvRUlnR1F0SEls?=
 =?utf-8?B?K2c5Mk1vV1BXZkYwNGxCbEw2UE9DM1BuMjZicWJuNnVtOXRlSVJnU29iQkVx?=
 =?utf-8?B?eTNWNUxrSyt3OHJwL08rVDI4WjhxQnJYRVFOWUpyYnh5SUFUYjJYQ0JTUndC?=
 =?utf-8?B?NW9KbStnL0NFVFkyb21PMWwxeU8rTGF3cFRtc1prMGFGM2lzKzFxWUplcEFl?=
 =?utf-8?B?eWZRMnF4WVI1anYwejU0YmlxSmo5NzdqbHdWS0tsVVBTWE9XNy92Ukpmd2d0?=
 =?utf-8?B?SmUvQ0ZaSUZNVWQvNmd5Mmh2NUM3ZFZQZ1UxVmZ6SVlCaEZLNm5VQy84djAz?=
 =?utf-8?B?WUY4UmZmb1V0TW85NlpuYTN2UlJlZEVjMTZzUG9OSnppNjlidzc2eTlFWFha?=
 =?utf-8?B?ajhyRUZ2UVJFT25sZTZhL2ozTFgweFNkWEpsODl6SGNPMzgzQy9zTzJmYXpW?=
 =?utf-8?B?Umtyd1NvSklLUVNDQmthd0hnVVJhUjNrWVZxTnNwOEtSMlFuUWRjWUx0eFJa?=
 =?utf-8?B?ODZTdlp3L1dwSk5GemNteHY2VnRBSWNJMExWUVc3SC8xK1RGMFBFZ0trTWNY?=
 =?utf-8?B?aWNxTTQyNmFKd1B6U09xZk1PSWtaQ0NDVUx0TnF2eWZKUkszWWJPRWtYRjVK?=
 =?utf-8?B?bXl5TG9zV0dEVytyWGJsNzF2b3Z0d0hRMGMxa1RJb1IycVpMaGJheDV5Y0dz?=
 =?utf-8?B?Q1lBOFlZQkYzWHl0WVNUMStxd0IvNkoyZDZLajQ1M2dDcWxLL0ZPVW84cC96?=
 =?utf-8?B?M0Nvc3ZSV2UzSzIrMHlxSFBUTmtPSVRlRzJUZjhlWURHd0RKT09VWGl5YlNQ?=
 =?utf-8?B?Q09OZEpGUHZnblFSOFZucUxvRUtqQ2h6VFlTd0RIV2J5TFdjelNEdTlobGpI?=
 =?utf-8?B?eG1KMkNndVhmV0p5blhuUXB4eGRtWWp5S1pkUTJFdVdRK2xJS2NURUptMGFo?=
 =?utf-8?B?WXlrY3UrOTQrb0VBblAzOXQ5YlROVUEzSjlHMkdXbFllVjBZQnJZa0tTMzk0?=
 =?utf-8?B?VTVwUE0zUHN3NkNtcjRYamRLZW5mYVNzZmdiTUtVVkwvQUdyOU5rZzZ5TzBP?=
 =?utf-8?B?RHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUgzRW1FaXJjT0ROU05sdnFsYm13dmxjcGV1ZzRSdGN3ZkNGQVVLRzVuYUZw?=
 =?utf-8?B?cjk1cHFLUkEreW5IeVloeEhReHpCVlVFRXRFbUF0VnpBOXZkMG1KZUJydFp5?=
 =?utf-8?B?cnR6NEJYRkFqVUx3QjM0V1FZbGROR2R2S2dkZmZjZUxhZW53R2h0YkhpS1Ny?=
 =?utf-8?B?YndiWkkxUE5aRGFuaTRLMzRYSnRmYXZ3QURoN29yaWNUVnh5bXludnUycWt4?=
 =?utf-8?B?blI2ZFJud0xHem1udlpOQUM3d2h1RnBrTlhaejBnU3pkVzdoRmpVeUFIdXBp?=
 =?utf-8?B?NU5kdndNL2FLVC94QUFDUWhtMFlDQ2trK09IMytteGhLZHdtcG12di9KdDFW?=
 =?utf-8?B?bEhqMW51Qk5YUjg0anYyRWtweGdsTzQ3dHdwc3Q2SHpUc0E5WFZ0ZzF1d1hI?=
 =?utf-8?B?NG1NbEsyZkY2SUlsSys1YjZhbVFxSFBIWEhSblViOCtuaHdhWElkQmdwSmE4?=
 =?utf-8?B?K0ZiOTVKaG10aGV3bmV4dGovRWlWaXZOV2pEQTlrMWhNTFh3R2pNMk84cmlx?=
 =?utf-8?B?QklCNnFJakIrbFR1N0VtNlB0TTZidEdXVENWcHV6MFZuVDJrL0VMcnlEQTAv?=
 =?utf-8?B?Q0l5MjFhMGpmUHRJejlwWEErSyt2UTA5bDc1a09Talh3a0wzSXduKzEybmNY?=
 =?utf-8?B?NTFFVERDSkhlUUMrVEI5WTBCOEMrNGowSVk0dWNhTkFCbTBOSHNWK2NzR0RJ?=
 =?utf-8?B?akxCN0tRNDV0QWFnbVZwWWxnaTdLeGJ6cWZUSUtDelRtekpHSGhYdENKZFJl?=
 =?utf-8?B?bWJ6Y0puYzFjUVZKbCsybVFMUEpoU05kNnFxcG1qNmNCVy9vQTlXWWdIMjhF?=
 =?utf-8?B?dVk0TVRTR2xCVmFNVW5EVmZmSDhyTjgwekRkMnlUdnkwbjd3VkxCR242S3JJ?=
 =?utf-8?B?V1I2ekRkemM4Qnd0NllpdDJsTGV2bDVNeHRqUG1Lc2QzQU50KzVqYmxHdGRq?=
 =?utf-8?B?S3IxUDVqNU55Yk9RbDFrZUk3ODZhY1BvalVYcjhJNUVYUk1PQjU0bWJITE9a?=
 =?utf-8?B?ZVdnK1dKWGpRYzBiZWMyaTV3R3dCbXJoUHlaV2JSWWtXdXRaZUsvLzdzZkxX?=
 =?utf-8?B?M0d1bVcrVDRTMitJQTEvMGRrb2NQQ2lEK2p3Z3hxNVlkVWxsOTk5ZGVkV3JI?=
 =?utf-8?B?R3pUUDR2Nmkzdk0yR2V0QndrTS90OGJRRWZNSnd0YTBubVlLRnhKaDlLbEpm?=
 =?utf-8?B?c0o3NGlmamlaK2swbXFPTmZnSEttMlMzdk03M1ZZY3o4TXk0Y0pORnBDdjNF?=
 =?utf-8?B?bk9kSy9iNk93N2Y2aDh6SCs1UHFNYi9xelZZWDdxMm44WjlNbFlzYWg4M0Jo?=
 =?utf-8?B?WVBTM2d3am1kaWdaamorSzJtZDdXdkM1NHNjVWh3TXROc1cxcGszdG9vZDBl?=
 =?utf-8?B?U056RWFVNWRYenhmSkdEelRFTUUyUlJ2MW5tWE5hSDhtb1B5MDZpKzNRN0I3?=
 =?utf-8?B?Y3Jlb3NnS1gweWZPeEovd0hrbnUybXR4OG1sdWN6WEhTdGFlWFV4TktGakFI?=
 =?utf-8?B?aWRMdXpHaFVxWVJKaGhoNXBHTEovanVCU2poSWk3RVZ0LzFlOEowVXlVMDhC?=
 =?utf-8?B?UThDSkpqalRmNmlMNStyU2hlMy8vVUQyQ2tzOGMySGtJWStIamptVE8vWXE0?=
 =?utf-8?B?V0d1Q0YrZEl2STNJeSsxQ1huSFh6L0dGOE9weFNydmMyTG9SMmhmNksxdFk3?=
 =?utf-8?B?WVNjMmNYaVlaVzhYeFdVNDJmTzFvS1hadmlUSU9mdVlxKzBlcm04WGtDeWJK?=
 =?utf-8?B?aGNGckFpL2pVbFZaSG0xNHpQMnhMUFNSTFJobXNPYWMzeEpPWktpTlFBQjJ3?=
 =?utf-8?B?WlhhQmxrTGZMaTI3TXc0Snp6ZTRWdTEyY1FKSzVvSGorSnJ0TjM1WjAwZ0FT?=
 =?utf-8?B?V3l0NGZjZ2NJSi85ZFAwckc0TUozWmxBaG5wZDdZM1k5elJuOG8wSDYrNzNM?=
 =?utf-8?B?ZGhZNXFMS2lxbEFhTldJU3BSWFNpa3o4SmpNdDNSY0VyeVZuMXpxSmcwWTQ5?=
 =?utf-8?B?a3FTL2pzNlhmRmF0ZVhGWURyY2d0MU9oanhiNnBvZmlndWNVYmJyUEdQZVdQ?=
 =?utf-8?B?NFp3d3RzUkpWOHpIc1BvRTVBVFlvQWxyeU50QUNTM3lldXlkZUVxR2dwSnhi?=
 =?utf-8?B?N2dqZnAwZnQ1cUQyQmxLSU1XMUZFY0lMSWdleUVGallBaVlOWmkxTXlrK2Rv?=
 =?utf-8?B?ZEVidlUrMUdQM0VKRHl0cUNmMjhjQXV0cmZzUUtNdHV0RkRwSkQyWGU2Rm5v?=
 =?utf-8?B?VkNUM2xMRTZJanhzOXZPeFBZeXFtd1VVWUVSMGFucURtSEtYckNlTVNMTFlI?=
 =?utf-8?B?QmpOYWJaWFhiSmIyUW5NNXR0blU1L0w1OTBBUW94NlQrWUYvQXNrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30263fe8-e6cb-4dfe-2533-08de544a9701
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 15:27:27.2094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ta+FnrQfV3pp4e2uwAF1GPatkAzz1S+4Mx5Ej/HyWUuLNEp1TB8zerGYwXwuZvQ3X7JEk6bdrNCnBAfABrXKdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414

On 1/14/2026 4:07 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> The CXL drivers must support handling Endpoint CXL and PCI uncorrectable
>> (UCE) protocol errors. Update the drivers to support both.
>>
>> Introduce cxl_pci_error_detected() to handle PCI correctable errors,
>> replacing cxl_error_detected(). Implement this new function to call
>> the existing CXL Port uncorrectable handler, cxl_port_error_detected().
>>
>> Update cxl_port_error_detected() for Endpoint handling. Take the CXL
>> memory device lock, check for a valid driver, and handle restricted
>> CXL device (RCH) if needed. This is the same sequence initially in
>> cxl_error_detected(). But, the UCE handler's logic for the returned
>> result errors is simplified because recovery will not be tried and
>> instead UCE's will result in the CXL driver invoking system panic.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
>> ---
>>
>> Changes in v13->v14:
>> - Update commit headline (Bjorn)
>> - Rename pci_error_detected()/pci_cor_error_detected() ->
>>   cxl_pci_error_detected/cxl_pci_cor_error_detected() (Jonathan)
>> - Remove now-invalid comment in cxl_error_detected() (Jonathan)
>> - Split into separate patches for UCE and CE (Terry)
>>
>> Changes in v12->v13:
>> - Update commit messaqge (Terry)
>> - Updated all the implementation and commit message. (Terry)
>> - Refactored cxl_cor_error_detected()/cxl_error_detected() to remove
>>   pdev (Dave Jiang)
>>
>> Changes in v11->v12:
>> - None
>>
>> Changes in v10->v11:
>> - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
>> - cxl_error_detected() - Remove extra line (Shiju)
>> - Changes moved to core/ras.c (Terry)
>> - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
>> - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
>> - Move #include "pci.h from cxl.h to core.h (Terry)
>> - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
> [..]
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 96ce85cc0a46..dc6e02d64821 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
> [..]
>> @@ -373,55 +399,21 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>>  
>> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>> -				    pci_channel_state_t state)
>> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>> +					pci_channel_state_t error)
>>  {
>> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>> -	struct device *dev = &cxlmd->dev;
>> -	bool ue;
>> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
>> +	pci_ers_result_t rc;
>>  
>> -	guard(device)(dev);
>> +	guard(device)(&port->dev);
>>  
>> -	if (!dev->driver) {
>> -		dev_warn(&pdev->dev,
>> -			 "%s: memdev disabled, abort error handling\n",
>> -			 dev_name(dev));
>> -		return PCI_ERS_RESULT_DISCONNECT;
>> -	}
>> +	rc = cxl_port_error_detected(&pdev->dev);
>> +	if (rc == PCI_ERS_RESULT_PANIC)
>> +		panic("CXL cachemem error.");
> [..]
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index acb0eb2a13c3..ff741adc7c7f 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1051,8 +1051,8 @@ static void cxl_reset_done(struct pci_dev *pdev)
>>  	}
>>  }
>>  
>> -static const struct pci_error_handlers cxl_error_handlers = {
>> -	.error_detected	= cxl_error_detected,
>> +static const struct pci_error_handlers pci_error_handlers = {
>> +	.error_detected	= cxl_pci_error_detected,
> 
> I still feel like we are disconnected on the fundamental question of who
> is responsible for invoking CXL protocol error handling.
> 
> To be clear, all of this:
> 
>   cxl/port: Remove "enumerate dports" helpers
>   cxl/port: Fix devm resource leaks around with dport management
>   cxl/port: Move dport operations to a driver event
>   cxl/port: Move dport RAS reporting to a port resource
>   cxl/port: Move endpoint component register management to cxl_port
>   cxl/port: Unify endpoint and switch port lookup
> 
> Was with the intent that cxl_pci and any other driver that creates a
> cxl_memdev never needs to worry about CXL protocol error handling. It
> comes "for free" by registering a "struct cxl_memdev".
> 
> This is the rationale for "struct pci_dev" to grow an "is_cxl"
> attribute, and for the PCI core to learn how to forward PCIE internal
> errors on CXL devices to the CXL core.
> 
> The only errors that cxl_pci needs to worry about are non-internal /
> native PCI errors. All CXL errors will have already been routed to the
> CXL core for generic handling based on a port lookup.
> 
> So the end state I am looking for is no call to
> cxl_port_error_detected() from any 'struct pci_error_handlers'
> implementation. Untangle that ambiguity in the AER core and do not
> inflict it on every CXL driver that comes after.
> 
> I think we are close to that outcome if not already there by simply
> deleting this last cxl_pci_error_detected() -> cxl_port_error_detected()
> "false dependency".
> 
> Now, if an endpoint driver ever thinks it can do anything sane with CXL
> protocol error beyond what the core is already handling, then we can
> think about complications like passing a cxl_port error handler
> template. I struggle to think of a case like that.

Thanks for explaining. If I understand correctly the CXL PCI error handlers
should only look at AER (no CXL RAS). We probably don't need a CXL PCI CE 
handler in this case either because the AER is already handled & logged by 
the AER driver. The UCE CXL PCI handler is needed to return a pci_ers_result 
to the AER driver. How does this sound ?

-Terry

