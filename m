Return-Path: <linux-pci+bounces-24128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD94A68EE5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 15:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1237A3B03D8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4635E1C0DED;
	Wed, 19 Mar 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YfKdtHkG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A611B6CE5;
	Wed, 19 Mar 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393946; cv=fail; b=CVKqgBRTU0QiRI3ix1/d5calGmKB+LFYQGcaAQuVBpbKWcJrdz7sX5DosILWGhgt6pJhKDOXkr3r0SWqgh6KnFJDEw2K18jzr0+6W7NtXvzG5xjvWRcZKQOcCmc/AT8ZcSdPmepTe04eIoUXVRdg3cchIXvbSPg5BgQ7hpqS1jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393946; c=relaxed/simple;
	bh=UUb05NvzCLTNBr1/+0TqXNhyDpihjVJQfq7WHum0eFM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=nQYTfhHJYZBkxQe0v7TZPFANmn/nZggoj79s2m8uAPi89jVrzjDKZ+q8KaaMC7bSFiuuCsZ6REDTcdfdtXfj7WdIJEe/t5cczczn0/UKDsakMQ9Ad5kflTFs3/9vKhRsvqoOyM3LEpni2KwwGVKrIqSK2i/uye57Wh9vhp4/xlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YfKdtHkG; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AklxE+JjptjKbyndxAKsMxxxoU4mh9eVHGRjw9eNmI2ocBhj066qf2rUd+fG7L7JWfVfJ70pFB/JaLM7HPRxnAa0GgZH9LszhN4sX8YbcdGGzi6ZrfZfvpD9zgFoNa2fhIFbJYjVj2RhFWKH/W+LlctqC3UzwCgbOtLIp5Bj3lY6Hm0eHklv8WjJtFMIazofRboyCnViadBu3WSS4FGtjmiU+SOKnHqmRAqlcMnNIajllJ/kpLXEGzONE8E1aHfxWsI72UShkG/WsTo3l2cVyDMHFp8TkdxtqR7RnS3SskEnIlCt2Exa7iVIYMO+Acz48GHAw7yyPC99p99+AUEIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMB+YhZVO5ivVbu581f6n4afDV4UzXwgWrMtdjs9+6I=;
 b=ODarGfol7FnDNHH+6TDj85ZtC8neEJ1By2d8NHhUBj7jyvQoXyJ6RZmYEfxXnPhqmcQ+DWZRcq7gwmMw0XxM6t50zzaXXKcDxKZTGrSQGikejKvIpp7zVx1he2b6i+aBJCu/GGAb2b9akvVIUg/bGE9BNx9SOjO3Sdur7RiyFhJhJw542+AKwVLjhsSRkkzjV090B2olb0ylkabUtFYiENE66chJqvvyaclIYL8dsLAC/MYA7Bqpapcz5PNJUj3VROkoV6FbYLhUJ80BTXJLTFhIE5J2YOJVOW/ZRKUmZrmW8YML5REa63R6I8ApP2xugWY7bA+DmEBhX13LF8IsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMB+YhZVO5ivVbu581f6n4afDV4UzXwgWrMtdjs9+6I=;
 b=YfKdtHkGyvTkx2ZtUkI/5lfgSXC0F8pGbcbuKRF0Y1tCRey51ZvmdhTXk0PoXdWjyYS9LGxWWgXZHRSW5YJ4a5rp2aDw7KVUZs4+UHmxuVauHKDqEXnX5f9FhsrSl+GU1AXzfRTU/WZ5BkCcXsVda2NFPnymciPdBr4e2PtC9NUbAc/l8RtSq24CyL6ihYjCmhQI51oanYNbpJWERG6YStq/uEbJQnMx8m5WhQvDGqSJQVVBE4xMSJ1A1NvphFtBAjXlNwJhup7fkAN6uhtb4OLgWBlaqG46+fJimx0iSBFK5kWqsI3HxUuvV3V1ZKPoihR/xHCa23QORA9lOs+xLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:19:00 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 14:18:59 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/2] rust/revocable: add try_access_with() convenience
 method
Date: Wed, 19 Mar 2025 23:18:54 +0900
Message-Id: <20250319-try_with-v2-0-822ec63c05fb@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE7S2mcC/3WMwQ7CIBAFf6XhLAbaVIsn/8M0Btmt7EEwQNCm4
 d+lPXnQ47y8mYVFDISRnZqFBcwUybsK7a5hxmp3R05QmbWi7UUnO57CfH1RstwYNSkJ0N0OgtX
 7M+BE7y11GStbismHeStnua4/IllyyXs1iUGbQQgJZ5cJSO+Nf6zRP4YGo/GIoAatvo2xlPIBD
 mVSutMAAAA=
X-Change-ID: 20250313-try_with-cc9f91dd3b60
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
X-ClientProxiedBy: OS0PR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:604:24::23) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: a8443bcd-8430-434d-081b-08dd66f0fda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlZ2TXRUUWRIenpucVRGM1FPRFQxS2dCYW9HMDhkMGRMTXQyZmg3NjJBNlNM?=
 =?utf-8?B?T29NSnA4VVpLUnMvci9ic21JMGV0TXNRMGRwWFNwVjhwbXl2b2t0aGoxdEg2?=
 =?utf-8?B?OU9KY2dHVWFnN3RCMVU0L3BnWVJlRGUxVFVDcW8rNWxzNC91anRxeStETURC?=
 =?utf-8?B?UFNrSWhHbURSL0IzMExidXl3VVZYVXg3MlFab2FObHp4OFF3c2didHJLVnlZ?=
 =?utf-8?B?SktoVG0zMWlkRXB2RTEzUHR0OVc1dmltcnZ1RDMwOEROQUZmSHkzLy9mVjlh?=
 =?utf-8?B?WHFRdG83QURFVHVhY2c3Q2hjRDB0b2x2cDJOTXh3Y0x2V3NaaFUzaUhmYWxQ?=
 =?utf-8?B?STF4KzYwWjRORjBLUXVSbTYrbmk2eEtoL3NHL2JkT2pDVDlMYnFHQUg5dmNI?=
 =?utf-8?B?emVSTVYza21lV3hweVEwd0ZqK1pnLzJVZE1DbVNQR01INHptZ3ZjSmlqb2xT?=
 =?utf-8?B?WjNRYW9SMmdVSDdrNmxvZjFoR2xNcGtNTnU3cXh2MmRtZ250dVdtM1JmcEMy?=
 =?utf-8?B?N2I2VXV4U0RXMVlYYlN6czl3OEhybUVOaFA1MENiUU1ldlo4VE1PRDk3N3dJ?=
 =?utf-8?B?V1VWT0NHcWRGeXhEZDZiV1hpemJla0dkTExhMUJ2ZEVTUkdJVU1JRElYbVpJ?=
 =?utf-8?B?bDI3KzBOdkhnNzZ3R3hFcFhEU05od0ZKSnlBd1pJNjBnUWwwc0NBRmxYWFo2?=
 =?utf-8?B?YmRjRmhQSmxLRjVSRlJ3a1k2ejl4UUNXUldVY3M1eEVoYzMrclMxd1RFNEVw?=
 =?utf-8?B?YkVFZkdjdXB3YjBWMDlXazgzMDBZTkxkNWxKbFVyYmk0ZG0ydWhNc1VMTXpl?=
 =?utf-8?B?TUt6NXpxdWxKeVQ1Z2kxUW55d2xSekFaZDVDa0tKMzZGNEVZd2VLTVd5UTFo?=
 =?utf-8?B?WkcwU0d2RUg4Vm9JN2lMZEVxc3YrTUYyR0d1UjV4WnpuSVFZbG56ZENEMGd2?=
 =?utf-8?B?QTZGY2FNZkJhVjRmM2N1U3dLa05PY2dzQmplT3lZRXhRRld0UEhXVlFTS1Vj?=
 =?utf-8?B?TkRqbnpOT1R5UzZWT0ROWjg0ODJCOElMeHhHQk9WRElRVlBnV2NVVjhFTGda?=
 =?utf-8?B?R21CNlN4Q0JQTFovT3haZkliY04wNS83S2pTTitPSCt6d09ZWXNoQm93ZU1M?=
 =?utf-8?B?Z1p1QzRYVnFLaDBJRnBncmF4WlBHVS8wcnlieGJlbXJweVFmZnhVUkpMVmlX?=
 =?utf-8?B?VHBrVnNXWWFXbE92YWxTZnJRVG1qbUFhMEh6R2U4bjFKQ1F4Rk16cityS2hp?=
 =?utf-8?B?MGpaK1JyNlpMeDB5QWo2MUV1KzV0SVd1RDJIYVU4SlNCeWNSZExNTUo5ZFhl?=
 =?utf-8?B?Mm55WklyTXRMWE5vV3Jhc0hMRlNTeEtEUSt0MmNyUy8xWUROWTU3SzFCa1dO?=
 =?utf-8?B?NlhVSWppNjJKb0lIYzkyTElRczlsRjlhaGZZRFBEOG9Qa2F6TjcwdWY1U0hY?=
 =?utf-8?B?T1EwVEJZaVZENEY2Q0lkZ2kvT2ZjREdzV2QwKzV5RTNOTk5zYmpDdklORDFw?=
 =?utf-8?B?TEkzTVFXUHk4YnFVS1BUZGhwRmt1NHpNQjE1dHYydXd6WkVFdjl4dlVxM045?=
 =?utf-8?B?TGFlL0V2eVVXa1FhVzhCK3loNE1NY3pmTWkrK0hLRzJQVlcyblYxKzRyaDN3?=
 =?utf-8?B?eWhxbU1sbVp4TDNjYTMxQzByVk9kZ2ptMUJMR1RuUVYxdHp0K3ZtbzRhUFlE?=
 =?utf-8?B?TGtCQ1JBQVJtMUpMUkVsRXdrWFZnM0xJOHpCcWZOZHZRd05hWEJReXRWaEIy?=
 =?utf-8?B?RG9WeVNBcHp3NDh1Y3VtSEdjWmVQNEYxY0MvU2VYaUUwbzN3TWtHbzVuNjYr?=
 =?utf-8?B?ZXdkdllPMlltMGpTYVRlelpLYkZVMG5SVmM2U2ZsS0xjZWI2WFY4R041MERI?=
 =?utf-8?B?UVJCOG9wQXFmeDR0ME9DdEcycTdTRVRncGFUbjBwMDVnZnE1KzJUVEpaNEs0?=
 =?utf-8?Q?mqvezZiajio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWJjYm8zUFRLTXZKcWgwUlhMbTlNU0ZwYkxJS1ZQU0JXaUlZeHRZNndTVGk5?=
 =?utf-8?B?aUU1ZFpOUUR1b3MyRHp6V3F4eDg0bHFsUUlBMTJYKzNxMEZ0cXR2TlRnRFRy?=
 =?utf-8?B?ci9SQWc5dkJIZ1N4czZERVJ0NkhSRGswOGtQdWxoT05xdm1lamFpRzdpdW1M?=
 =?utf-8?B?T05rSFRGajBhZU02VVpTVEZyZFhnZDdkemZuUkNTSFBacURWU3NvazJUdFh6?=
 =?utf-8?B?NkpkUGd4bllZcHRWQWJCS0RJaGJKNUN2NXVmRW81OGE3TGh3bU9Ram5WYjk0?=
 =?utf-8?B?MlBOdzJQZE9oUWxKZHJZMmdIeFdiMVhQTVBMVGF4YmV6b3VYMVQ2TGVTYm1H?=
 =?utf-8?B?bUtPSmM5a2w2YldoNHdaaCsyVzZRYU14MXFvcHBVNG1PdHRYRUV4bnBucGIx?=
 =?utf-8?B?WmhkcExMYmJXak9jMk1ybmR4YzRwM2MrR2VXZGFsK0Y0cVpPWWxETmh5SjZT?=
 =?utf-8?B?eGNkcDlqRjNSWEZMN1RIT3c3bWpOajBLTDB6WVlOWHhZbFRPOGNFc1NtallE?=
 =?utf-8?B?ZnVGUUcwT2pFN24weFVKYTRpaG9hSFlQTko5dXhEU3RROHZoamZsdDdtVG1G?=
 =?utf-8?B?d3VsSm54VGt0TG5XZUVTODBjTHcySytZQ0dMNGhHOE1lcVc5alVmZ0ViSWNX?=
 =?utf-8?B?WFMwTXRnUVB0c1lLNE9SK1l3bWl1aTBqYzJtaWY0cHYrOVpLT3pPM0N6ZVVJ?=
 =?utf-8?B?bzRxSnBOY2lEb2UrNzNaREE0WkJST2gwbzFPR0pteWtmeUxqOXRpWi9VNzhK?=
 =?utf-8?B?ZWxRdmxBK1ZqbkM3SlJBNFNHUGZTTkZmRWxIbWNvQUl2THduRjBXdm1JSG45?=
 =?utf-8?B?R2pGTHlISWdMTzJna203UlR1aGdnSE8zM3h4Y0JuZldMd3dSL20zS2w4d0da?=
 =?utf-8?B?OGhqdmR6d0lnZWFPdWxOczBPUXY3QUlVT3dHYllWVFdJT0NDNG0zMmt4MUMx?=
 =?utf-8?B?NzNZdDRlUkRaQnBYL2JuQXk5SUtxSy9xNGExM29ydE5NYnJDdUxmaSt5aSth?=
 =?utf-8?B?eUNIZUQzUzNsKzhyWStiYVk2bzJnMzlkZExmNG5WSk9XT2c0ZklxWHVSbWMy?=
 =?utf-8?B?SzNjY1BxQWZocHpNeTdlSE5pMFl1UGl2RnFYWGE1VytZNEhGNUcvVFlZNzFZ?=
 =?utf-8?B?ZlNZT2tlVld6c2pCOE5FV1RMSUFsYk9CSWo5NUwyR3RXc0hyRDN2NmFONlli?=
 =?utf-8?B?azh1MWVBbjQzQUxLYlRaYjVGYnhlVjJQa2JoTXRoZnhhVThSZFpkcytWVDlo?=
 =?utf-8?B?elJ4WlJ2YTY1QTdJL25UNzNFMTNQRVozamY5SmRydUI5aVRaSUtuTlA2S2RE?=
 =?utf-8?B?cFpuVlQzNW44Q2R0aUNQakRndlVvRWtETURnOS9paFBNUnJ2WFpweUVTM2F0?=
 =?utf-8?B?Slk0NGFaeDE4RmRFQjJwQjYvOHpMNjE1UFR3MFNPR3hPYnd1cmNoNy81bWJF?=
 =?utf-8?B?Q2F5TTRVK2xGcUlScHU0N2JlekpNb1ZTWjh5OXZuTmh2eVFBWm9LZWRtNjhH?=
 =?utf-8?B?NnM0emgzR3FCejJPZjdXMzhoRldadHpWVGxSUFlBM3Q4SUJaemFtaDJ6a3lT?=
 =?utf-8?B?bFc0QzNuaU5ocmVKQVFKVGVFZGNnUG1GRDNwV3J0L29pNUJ1cnM3dkc3bW5H?=
 =?utf-8?B?N1N5VHIzT2x2NmpqMmdkWnJMK2FHVCtNWlNIaXFFSmtPY2FEdEpsOEdLNytp?=
 =?utf-8?B?M1ZydzhoQnJlUVRDbTNrZjVaeDRVTGVBSEI5cTU5eVN2czNUcVk1aTU3OXdj?=
 =?utf-8?B?YWlPclkxdlJqZjVBK0lsbTJPSWRlekNxcGcwTGhVOUMwZlRqR3ZaalBUcXha?=
 =?utf-8?B?Y1drR25JNGVpcGw3YnlYVEFTeURCNFFobUtPSFl5a0pkelMzQ3ZHbnpGdjNk?=
 =?utf-8?B?UnNBeElnRml3K3NmL2trVlVVTlFSV1RSaXhjZE1DNW51NHA1QWxia3ZsdEJx?=
 =?utf-8?B?U2tYTmVDN2V5MlJlWW1DcmF5VUpDTWxQWHFvclo2SllsdkhDNFkrUjd6Tjhu?=
 =?utf-8?B?Q3QvSU51UFhRQU5lcjFlRm1PYWdzbFRTSnpUeTJodlhqM1pJZkdiTVVsR29S?=
 =?utf-8?B?QldBT29pbUhMLzM3a3AvTWlIdFE0TzErQWJNb1libjBuQm5kZWlFRVlmN0c2?=
 =?utf-8?B?bnBVa1RQWHpjd0paVWpGdW1rZkhZc29MbzdLc2xYejdQbEd4ZWk0RWFQQlA1?=
 =?utf-8?Q?e1TnvqkXbRvH2UNRNtgr99v3t1q+d+Sqrxf/p6SGh4o+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8443bcd-8430-434d-081b-08dd66f0fda6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:18:59.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2+4+LfgxHytPW+W7cHyz2os7UqjBVFk4OztgTrwGfEMnBUEk4sKxX3p1yhYf1FyiRx3dfrVvnHFE6h/6v09LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643

This is a feature I found useful to have while writing Nova driver code
that accessed registers alongside other operations. I would find myself
quite confused about whether the guard was held or dropped at a given
point of the code, and it felt like walking through a minefield; this
pattern makes things safer and easier to read according to my experience
writing nova-core code.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v2:
- Use FnOnce for the callback type.
- Rename to try_access_with.
- Don't assume that users will want to map failure to ENXIO and return
  an option.
- Use a single method and let users adapt the behavior using their own
  wrappers/macros.

---
Alexandre Courbot (2):
      rust/revocable: add try_access_with() convenience method
      samples: rust: convert PCI rust sample driver to use try_access_with()

 rust/kernel/revocable.rs        | 16 ++++++++++++++++
 samples/rust/rust_driver_pci.rs | 11 +++++------
 2 files changed, 21 insertions(+), 6 deletions(-)
---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250313-try_with-cc9f91dd3b60

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


