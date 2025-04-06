Return-Path: <linux-pci+bounces-25343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10456A7CE48
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 15:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15CB7A5AF5
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A1F1624DC;
	Sun,  6 Apr 2025 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QVR+hqUf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968B21931E;
	Sun,  6 Apr 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743947908; cv=fail; b=Syuawb8zV5R38YYavx5f6DlMi/EtBqfVvUKdzhnMDpK/SyUWO9K+xZoPQZJ9bstKFnQUhrO1u9wcmyZJehbXz9a6eU2w5VBdgbVZ+HcQAreV76Sdysq4oyjZf0mhcNPsfZ6BPFjZqPd45/GpZDHzf6cTHf00rvsiP8R0CBDm0pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743947908; c=relaxed/simple;
	bh=pASRsEDLBhpD7zIL/ScwJG/SfOD6EAWQJBbzpS7BlUU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cMnU89JuqghmhyupEYet5Nzlrt+sSNsiXXTvFSLAC25JNnJsH2GmLFsgc+dZRuokYzt+K1/duPyymBQ8+B+2uE5m3+NDt9WiGVE1zp96oT9liKsJS02fL3cn8qzAwgxNg092Ny2mvw5tnSl+bbgBBLvvAlVTYIcaX4TGW/FSW38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QVR+hqUf; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E44xrc0k/X0UnuFTqTtjd2Y++QNIsHYizi1V2RkFvPzKy+DlOU6EUI4hMLzebn15RDoSmjiRaC5Pza6qUnqpNaIX79T1k0V/cTyhfPh5viIuzT0qO+qNA+I0nksNSD9gx0LVC5wFNWg1TMsv+smwaRH5zjTtFZNSCNJ1kUFBVvs0wfkR1z1xtOt/DQTrn3/OCkPsC+6jTXqnsPmON9SH9EkcdCtUmRxEvzFoLiTYfp/HFIJ/HYL7QsuxtHQXbT+/c0UX1gty/vSwdjz6J8SbHL+lNCXAiNcwNCASSB6OEWi7OQ0u7jiGnjI+miS0BCtgsXPTe3Ry2MGiESSKNzmB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wN663O5IG2V103W6KejVe+94Kw913rm56VcqpJ/b9w=;
 b=gymz1woI+tHA3mrn8CHmcdPV/ycr9fARMj5I5CAIhNybvoDBpelIScJk1hfUIutlXe7zDExu66HyCeGoaPHyhuTRQ0GJREp1BN0daIkacnLAJKbvmCFayomNU8MLjRLAiz8926lLfaSBLPaAnggMJTLY8oW8rRgII1f3HYx9+K+pjUB2HA/D6YKZamNNRjuyh/KctDjhS0XVSJwldxYchO8yBTHv2QEipasj/FXctXpvGO2BrAxRMyyGtAENq2rWcHHmHL0I1faVBylJgkrPlgEddOR2oPzV4DHlYNYC9dn4VLdIVnXLuVpoCu3x5AcCfFoQp1S1AqUc0SSiMgrD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wN663O5IG2V103W6KejVe+94Kw913rm56VcqpJ/b9w=;
 b=QVR+hqUfaBGrT5vjefkWE0x4hnHwkLF481ceN0gu4UotnckhwSrn4WKdDRnABnlo4SAVtazSMwSsrTqNjapwtnChNFhpWBdKGgZK04BVqSSVFYhsRB8/9v5Ud63ivC1yWvyJTynQHSYfZE+UqnVCEaAoBXHjOkrt+ygoBfhLcroulddWsJ+6CN/3oiPNhvOta2oxFgqVqu2EbV9kUFGqorJm7V2dgm0FmbaR7uFDYOaJf25P5tT4Rs2D2gCsay4iuR7XbMaqtSf5eVxVWFggTUyho5kZ9cH9hrMKLggsmwIwGukgETAIcj4YFZTyS3yrZrielAExNcGvlrfvoBmeSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Sun, 6 Apr
 2025 13:58:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8606.029; Sun, 6 Apr 2025
 13:58:24 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 06 Apr 2025 22:58:16 +0900
Subject: [PATCH v3 2/2] samples: rust: convert PCI rust sample driver to
 use try_access_with()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250406-try_with-v3-2-c0947842e768@nvidia.com>
References: <20250406-try_with-v3-0-c0947842e768@nvidia.com>
In-Reply-To: <20250406-try_with-v3-0-c0947842e768@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Danilo Krummrich <dakr@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TYCP286CA0293.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9baabd-4179-4b3f-552d-08dd751318f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0xBa3dOcUd3Q3ZyZGpGMnFNOFdpb0dUWmgweHkyRUk0aHlGaHFxbGFGRStW?=
 =?utf-8?B?eUgybldHODRpdjlYNnNoNDZHejNoeGRtY3FveDZTM1hINk5ra2xDYUtKYmQv?=
 =?utf-8?B?b1NYTVB4ODdVS3EvcmtZTjByazVKbDBIelpuTmJZUW84V2FONWJYWm0xbUlX?=
 =?utf-8?B?VHVMNklhOE9KZDVPV3hZcThoTWJnMUNGektYa1NZZGVqdy92N0dYaDk5OWxr?=
 =?utf-8?B?SldOWjRDU0FvT0JXMnl5ZklhaVF6MnUxRjBWdzdUSHcvT29IN3Z2K3pQSW50?=
 =?utf-8?B?NnRwU0dvakVMZjk0YXlQRHpmaVVpQkljUU1LRlI0V3YzenBPeGpVTUpEM0sz?=
 =?utf-8?B?eVdITlA1QTA0cGcrVnJJMEVoTllkaHJpUzNvSVZrL1A5YnB6RmVHdjU1Z0JX?=
 =?utf-8?B?bFVIbDRTREtnZXJhREp0M3I4L1FuZlVjL2MzbndpSGU0bkQrU3VrZTF0S0U0?=
 =?utf-8?B?bm1Yck1CUHdSTS9FYnZBazZXQmNRTzMrZkJFM1MzUWhta29Ec3hweDkxNm5u?=
 =?utf-8?B?R3hHMWdjck5JUW1ZUUVUSENEYUtZaXgyVHUwQzVWdXFGaTF1SFBrSENVNzRo?=
 =?utf-8?B?ZFNhNjNqR2Y4VEtGaENPL2t1VmxWcUhpUjNpVDlSQTFVa2QzWkUreFVXaE9p?=
 =?utf-8?B?amJVbWtPZzVKMGFHN3MveXRSVjBnRUpVVXE2MS9rUGUyclBPbzFla3ZvdUVH?=
 =?utf-8?B?ZEd3eHN1NlMvTFFtREtkMGpWLzBLTWI2NVh6T1dNbjlDaVVzTENMT1NGRENG?=
 =?utf-8?B?VHRtb2lvVkVRVHVxQ3FueHdLTGgrNkxTNUJoV3BHa1k0ckllckhMbDJZak9q?=
 =?utf-8?B?M3VaZ1QzVnRVS3lhd3p3ZUtYdzlVWmMzREpRWmluNjJIdDNNV1gxRnVERlhF?=
 =?utf-8?B?UjZtOUJadmRXclA0SUZub3N1K3JYcU90aEQ3TXVNTk5kRExMK0w0bzZ3SFBK?=
 =?utf-8?B?LytnSklyL3BuRjlqMksrN0dYaFk5M1pMdUJValorUWFOY2J0ZWd0YkI3WjM4?=
 =?utf-8?B?NmduS1M3dVZmYTNKaVYyY1JNdjdwYjRlMW5NY25adFhFelNGdmd2ODUyUGdx?=
 =?utf-8?B?K2pBWTV1SzdnZy9kU0NXZDVlZUgvT0xDVGlxakVSY3B0NkNSSnk0ZWNwWDcy?=
 =?utf-8?B?VHVlQUVWQU9MaVQ3czIvMXFrTnRzK0FGbkhGNlhNTFA1Y2dOZnNPRU5zMC9L?=
 =?utf-8?B?QnJZY0V5R2lyYVVpVXVyaWRKeDJlQitRcWRhMXBuSTZ6dkc2THh5dXJCdUEw?=
 =?utf-8?B?YlBUU3JzcGxUZFZ6Q0hnZ2V6Z2dnNXNXR2lyMjBkN09jeFEweGNUdWV6T3o0?=
 =?utf-8?B?NGFpSklGUVRha1pMN1ZSSjZmcmROM2VSME4ya2l3UnY4SzdlSEdhZkpVcnpv?=
 =?utf-8?B?R2pmbHRUS0Y5VGNwRlpzWHA4a0Z5bHRtOEdFSnljUlZ6UGRjMkhYSUdoVmg2?=
 =?utf-8?B?SEFyenhtYzFBbGxzUTJNNSszRUM1NDZYL2xCUytacVVwdm94NGF5YnI5T3BV?=
 =?utf-8?B?V2x4TTNZSEhCNFRLWENIb1RVaTZ4RU53SmJjQ3NvTEJ1T3MxNFp6bHZmbDY5?=
 =?utf-8?B?WXRSZ3VMYXFjcis4dHVMekZObWFTL25xUDlCNVZ6OXNkYXZWaCtaVHptUS9P?=
 =?utf-8?B?T0RjNXhOTnF6cnN5M0IzYWkrNE9KZVoveXdZS3JCQXBlNUZwaEVGVHVyb2VE?=
 =?utf-8?B?Qzc4a1lDMmozQXJ5MmVzV2ZuTnpTS3BrNWJaMWhsUmJMWWIrVEpZU2FrUEpO?=
 =?utf-8?B?WUlsditGYlhiRE1vcERieEUwa3JOdTR5SmFJZ1FBZ3ZRcGFqdEV5OEJSM2Js?=
 =?utf-8?B?WXlvQTFnRStZdmc2MlJoMWZMTkM0bEx1TERIMjNjVTBTdThIUnEyd2RVdDFO?=
 =?utf-8?B?Ui9xd1JKTU14dHlrTVRtV1JLVkwyRlVrMEpsVXhXR25XclZ6UWhCWDA5MzQ5?=
 =?utf-8?Q?CZ9Gf1vcZj0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU9VMEduemovaUFLZDJVKzZnaytLamc4UkN4Y3VlcWlzN3pUeTMwcGNTNFR3?=
 =?utf-8?B?WWNqeWE4Q2hNekpYaWRCZ0llQlJKTDJVZjBKbHVhc2wxaFhYUjVVZTUxYkdO?=
 =?utf-8?B?SWVyTDF1VXdpeUllTGJZdmg0T0RXRVFoSTBYM0pCNXgrcCtwTjdFUUhHMTJt?=
 =?utf-8?B?aUVjdkR0MVBkbTNsV2JxcGlTU29KY2VZbmt4TDlob1Q4NnQvVDhpMldidjFY?=
 =?utf-8?B?UE1SVm11U3RwZDdRcURGVDFBL1I4K0R1M1ZCY3REeXBuQldGYkc0QzFGTzVv?=
 =?utf-8?B?WTZBVitEYkI4T2loSnBaS0owa0VWREZpTDhzYWthVFRQd0tGRSt6UXF3QS9L?=
 =?utf-8?B?bkJKVDB3cldxaVMrYVd3SGR0a0JwaUdIVHdHc3A3UFd1SzdraGRqTVA4MXIr?=
 =?utf-8?B?b0RLQWVId3hGMHRITVZBcFBTaG5zTFJ2N2dCc2wyNEVuQmlkSFJGV21IL3ln?=
 =?utf-8?B?RjdCb2tUY2ZlMnB0SXdpeFFZK1NmTmpRQ1BYczNtU3lPUVJWQ29NYjhBK3cv?=
 =?utf-8?B?aVJrdGZESGVvTUR3UXM4MnpUWnllOEcwOE92NHA3VGdTS2pERzg1NGl0UHNm?=
 =?utf-8?B?b1dQSjFaUmxWb1pPZUhybHRoWUE3eHBXUlBsaWpGdjlZSVVCVEhwamg5WC82?=
 =?utf-8?B?cEhEdnVIUEN0aTlsMUFjc3N1Y1l1aVdPK2daWFFxNHZmNGhxYTlXS0pTbnFH?=
 =?utf-8?B?VGtTcUZWZHNNSEZ0eE5QNHJpVk1YR2FoM1JINi9abWpoQmxwaWxYcTR2a3RG?=
 =?utf-8?B?Z1UrSDBVVkVnYmp5akd2MGV6WktqL2l0L3RuWjJvdVJNK1ZZQVhpOWozY2J0?=
 =?utf-8?B?RUJQL2xmanQvanB6VUlCY3ZUbyt0K3Vhd1BoSnY0SnZBTFpmUnU4ZC9tNTh1?=
 =?utf-8?B?cmNuN1MyVUxUYmhkdlN0Qm5TUEtEcWU0L2ZGSXVycno2WmswUUtUR1EzR1ZF?=
 =?utf-8?B?b2VOV1NRV0Q4L3RkMXRBcHg4cHlXcUQrbzhpUUR2bkZ2aVBtYjIrWlRLUUFD?=
 =?utf-8?B?dTVMQ2c0VnNRTUhXSEE2eWFhbDY5aWZWOHBJQ25OTUJxUXFtM1RUM3pHWW1Y?=
 =?utf-8?B?RVA3Q1J0U0U0c1lQMFRHVERhc3F4MmQ5b2Vxamk2UkErK1NQRkt6d09NTzhy?=
 =?utf-8?B?REptb1NLNkJTemdQdnBud1Y2R0Y1Rk1xUklwdVJpODNWbDFFZk5RNXI2Nk9a?=
 =?utf-8?B?TTMzS1lpT2ZCNG04K3dzQkNIck9Bd1VtaXRsRSsyTmtIM3JxUURmRkhSRGxO?=
 =?utf-8?B?ZGVDZUloMDc3L3o0NnpjUnBQL3dPN1lOUGtCOEVQc3U2NjNWM0NBQUJMQkpD?=
 =?utf-8?B?Tkt0VGZ5ZDJvR1dUem5HalhxS0pCeUNjMXowSTBtY1pvaFVHYmVWM1hhTWNm?=
 =?utf-8?B?c2JOUlhsR3M3V2lLaURpNktPODJUZnVIMWtvREFiWm03TE5JNWNkUTBqVDFX?=
 =?utf-8?B?SnZhM1F2T0swWm5MaTBQNG1zWnIzeGJuUXlCSHlkZ0swbWtIKy8xNzQxSFFr?=
 =?utf-8?B?OUsvYTROeUtRbDVmcVNJUmcxV3ZCNGd2UUtObElkNUQvZ2xGU1VwNUxVZ2Ji?=
 =?utf-8?B?dXMrUzVObDErRlFZOEl5Qm9IY3ljOFhZSStVdTF1WVUxWkZlTDgvZHFYNXo4?=
 =?utf-8?B?UDhQSzFBUW5UMlplOWl4anhvdlhadUV3YWpwb054a0JUQWhrL1VacHlNMUl6?=
 =?utf-8?B?MzlkRHQzc09qOFM3RjFwTXZubnFWU2RoWGlEYmpmcTJBWUxncjZjM0w1OXBE?=
 =?utf-8?B?MDVjWHZkcVpURnJldU5Na2t1dHhpd0R2K2Q1RldPbjBYL0ozWFQvUnFBeUxw?=
 =?utf-8?B?NVhHY0xRd0syZ1p5RDRpK1Z2SXFZcmRaTllIdDFjeHJaeXkvcW1Dc1lZM3pt?=
 =?utf-8?B?OVFNQWNkd3BBbUZBbDNJcVF3Z25QUkZqUDE3Q01MYTBiNjNFM3FwYnBXMDR2?=
 =?utf-8?B?NWp1cHQvQ1B3QUUvNUNRd3VaNm9EUEJJVGxBVHRxRzlEVDNQSFUxQ2FxWDFk?=
 =?utf-8?B?M0tpb2oxRDk1QUZnODVacy9oWGp6Z3ZLbW11UDdIWlJDUWgrSjhCaHQvZFN2?=
 =?utf-8?B?Mmc4ZjBYT1RjTHJtRnE5RFdZbG9JNWFORTFEaFNybDJuWW9uS2l4SkFBakxQ?=
 =?utf-8?B?TTYrQ0tra2dlUnQ3TFZ6M01mUGFsRlBLWFg2S1lsbGUzSXJIZU1Ec2JFYjlO?=
 =?utf-8?Q?YE/mOE6CaRpyV5SzY56MVflalolEhj+GxUGgc5f5i+8s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9baabd-4179-4b3f-552d-08dd751318f7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2025 13:58:24.1315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B50Y4zl8pc0ECI7+fruLRRR36PDjwJltcLJYHAaTSFRNVmMeHbZlwzCwOh37K7tEiyLDSIYiEKYR856UQdwDIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403

This method limits the scope of the revocable guard and is considered
safer to use for most cases, so let's showcase it here.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 1fb6e44f33951c521c8b086a7a3a012af911cf26..f2cb1c220bce42d161cf48664e8a5dd19770ba97 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -83,13 +83,12 @@ fn probe(pdev: &mut pci::Device, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>>
             GFP_KERNEL,
         )?;
 
-        let bar = drvdata.bar.try_access().ok_or(ENXIO)?;
+        let res = drvdata
+            .bar
+            .try_access_with(|b| Self::testdev(info, b))
+            .ok_or(ENXIO)??;
 
-        dev_info!(
-            pdev.as_ref(),
-            "pci-testdev data-match count: {}\n",
-            Self::testdev(info, &bar)?
-        );
+        dev_info!(pdev.as_ref(), "pci-testdev data-match count: {}\n", res);
 
         Ok(drvdata.into())
     }

-- 
2.49.0


