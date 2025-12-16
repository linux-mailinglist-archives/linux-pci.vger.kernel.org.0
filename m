Return-Path: <linux-pci+bounces-43092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72610CC0FBF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 06:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05594305DCD9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 05:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAE62E8B9F;
	Tue, 16 Dec 2025 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Les5bBTs"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651031A04D;
	Tue, 16 Dec 2025 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765862054; cv=fail; b=ER4WQHqn3Q+bjPgkJvolIBz1utCldfoaq5QfFyrDN+bzln14hPCM6ZZ8Y5G3zvmULn+dEsH7PGqZ6hZVxMwpBrHC7Go8PIjQzt9sGa5GgA9A6OtcTErqfT5jXULsHO94sSJbNA9VMU0u7aYFK+XjcxN/yBGTdijLljLwS0uscbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765862054; c=relaxed/simple;
	bh=QCP6ZKGSBm+k+OP5LciU248qPSdHMSJY5w22IkfxJow=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=P7qt9Cl2zmbC/BRJnNB0a8S7mhlngpOcefO3cxLQKXgIyNctvwRUl5oT26yakVxEv58QkEkEnoSQ/QNPUU2pQ9Wji4Px9lpFgq+BSbuxfT5RO/WX288x1fA8kKMzNZKCR6GtO85KjeyzQ2RiqaqADrqyOZDkqshmBP3jX2Xj03U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Les5bBTs; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8N5rntJ+/Wi+5cHo5zHUfWjL4qt4t8T46/cncwGH9jDC/e4U1N01RCxCyuv5EvowMG6Qwubj2OWr5CRM6mCsM71iEcCeuNwxUoU3SiEe0lom24zS2fj8oYh7BMAFZG3xHrez0exo1x5W/RjcPZjviCWslwE/i7YOZm/+TDdE4ilvGHegAtV0QaFre54ohqW8vGdY5BNY7thvK9M9Bs9KlHLu9rwm1L1UxNMoaOZEiJl3K3La1yyz34m3r8EMnh59svu7ei2LiBbxp1TZearXHV4LAi2VVZBQGgfVsl8xPsJMlkyDP8f8m3KSuOlcdawI/Zg7MtntUayjfTVzwLjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEG3TBh1YGF5iOf1CfYYbA1iDYden9DyvM9Dm1AH/Iw=;
 b=VE+LoSjWQl2Pxcs+4VUA2A8B89qKo4dxYgzh8geU5c5oMULcFP9qI44sSQSMZOjQjCpDj8Fja4tujAw5Tdm5Tr1EjAzRgtH7wpZ8O2mZo/A8cEVe4p+5tludm5NxyEpfrakXORxqnQgV1wrmif688eSBNH2eyfB1Y8CuQGJWhzpHHyeX07EkXq8pfsLJWC86oyIttHDvH8fCE5+360mNqP6Sa5sl8nc17jHf0X5elhciVRtVoiiRZg5evJ4utFYZ0vYP9PmUpLNTRszf7NVEHlWPSZaJEPo7cKK1V6opvcvX46FHnP0KU5baVeBSA+38te5MsdKMOi5IgvItEEfpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEG3TBh1YGF5iOf1CfYYbA1iDYden9DyvM9Dm1AH/Iw=;
 b=Les5bBTsAJGW+qtear/lnxkJIkEJKH2F95BDazpk6ClRruQwg4d9HeOPh99YsvFrRhgSYBZeRE6vkEgPs9Y8MnMXgf3aQolN9hbaeJ1Rw864EIon2dSYKW+0h6Vn37vH9p7gOaLidRL5SVI0FgXYhe+KYedzt1hM0jbR7loCJRGrNDuoNVSdgwIRqe6qL7upIBD6FcTn+OfCXBX82zbbb3l4iI6IBykS7b9/+MJrUPAUkgPdwIX7Sl6WA9Jq+KCmx4i+l7nnHVJbFKqa/QHEJ1y5QY/pRiJ77nvxueKo8XHd4fiGrat1ko/WE81vypd9WO3QPgyM4vDjTuccfN0mDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8816.namprd12.prod.outlook.com (2603:10b6:8:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 05:13:40 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 05:13:40 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 16 Dec 2025 14:13:28 +0900
Subject: [PATCH 2/7] rust: add warn_on_err macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-nova-unload-v1-2-6a5d823be19d@nvidia.com>
References: <20251216-nova-unload-v1-0-6a5d823be19d@nvidia.com>
In-Reply-To: <20251216-nova-unload-v1-0-6a5d823be19d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Edwin Peer <epeer@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P301CA0060.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ef5000-6d45-4b7c-956a-08de3c61dff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFlaTkk4V1YwbEE3S2hiU0s0d0RLOFRLem5SbWcyWE9jSzlCZXZuZnF5L1Nw?=
 =?utf-8?B?Z0NycVllYzA3WXlOOGx3OUY5WUQxUnB4V1JRbUZBNUwrbDhEeGVqNG1Wdmw2?=
 =?utf-8?B?SkU5bDRtV2R0eXJNaE1hQVhKRzdRM1lWWTRuQmgyWUlvN0dWbjlNWUdPR0Fa?=
 =?utf-8?B?S1RaUGtUakNTVEJCQ1Y1UVVqdjNjSFlDaXl5SEtJbE9tNmlQL241dmZIMG1K?=
 =?utf-8?B?TUlzV0Rxam82dUpWMHFEWlZpM1lGY1NSSXZkcU1tOVlFUGJvRHliZFFrdDhs?=
 =?utf-8?B?dWprTDU2ZmtCVi9TZlhLTlVjNnBuQVZGdFIvOXljQWo0dTJpZ0c4MVdoTHEw?=
 =?utf-8?B?bSt2NEhWVDMyZk5OL0UvZVFNcmt4ekIwZm1QbUNSc3Z1YThuNVpuODV2UUxV?=
 =?utf-8?B?UXRMaysyQlMxWUlETzZzVjIxRmZFRHN3QStXY3JIOWpGbzhGWi9pSDhWbmx3?=
 =?utf-8?B?NXVueFB4aHBHOFZrQjN3bThGaDRyeld0TCtoM2xidkl6UTBNYW13NkJIaWFV?=
 =?utf-8?B?Z0NUMGJtSFV3Y2JXTjBXQlB3NVpBcjh3QzVRR00wMk1WOGNuTVRzZDNjUlZ2?=
 =?utf-8?B?ejR1YzF2SzQ0RUhPT0ZwVkwxTkVpRk5LMFZ6YkN6MThqTUhEdjJiVGFvLzBW?=
 =?utf-8?B?L3RRTHZJWVNkRm1RNzdNUXFmREJKQm5xUWZaY3JETmY4TUEyOGg2azM0Ym5X?=
 =?utf-8?B?WlZNWmEyanFlelhhV0U1M3Ntak4vSXh5S1FiVC8yM0tUdVRubVdGa0I0VlJl?=
 =?utf-8?B?bDRPQUxHQjdvSkdYVThRcDFETmQwQUNBOVlNWS91ZDFiU3VhZ0dxRGxEMkUr?=
 =?utf-8?B?SGNBNk1mdHhqS1loQnVCeEVCZzZVM1VEU3QrNGM0MmdGVUFibEdGS0V3U05N?=
 =?utf-8?B?QjhGdmxXVGhDdTZNSjhkZjZvblRpL3hITUZQWGhCWVlJVGE1bHNSeDRiVjZt?=
 =?utf-8?B?WGRRK3AzQ2lGV04vWEd3QSt0VlNoTW9md0pqak45dVkwZWU2SXd3c201U2FH?=
 =?utf-8?B?Z01sZThOR21jSDZyVUhOa0RsVzkzRk1qWXBSeSs5VEp2QkN6WEhtTU9HUTEy?=
 =?utf-8?B?WWR0OFRDaWNUOEtQOEJyUXN1cncyTmozaFd0RGFmbFR5b3loNkJtaFR5a1NM?=
 =?utf-8?B?MEo1K2thMDNVQkhGMHRrRWowWWxHa3dJck40UzJqRXVMajdzaTlCUUppaXlt?=
 =?utf-8?B?Tk9weFhoRzRmdHpuZ3UwR0NBTzRreEEraXFWek80ckpJYnJZYWVpZUdDTXJE?=
 =?utf-8?B?dmhRbHZKQm81NHBkNHBWSDkzTE9MTk04bVcxQXFqQlpOZnRsTkFyaWhCQ2x0?=
 =?utf-8?B?cnptYTJZOCtQODNrcFZkNmo2V25MQzBURVhidnFEK3I0c3RkdkZjazJ4WVBw?=
 =?utf-8?B?aXZueFFDeWRyK2M2eE5lelJNaDErd0hrSGhTM0NzeWIvNDk2bkFSNjlic2Rp?=
 =?utf-8?B?eVhrUW1FNzZiWXFHeVhHd1hXOEdtaTBocG11ZHlYZVFMUFdwdFQ4WnlNSE1t?=
 =?utf-8?B?L3lXMW5weXV6WElqTzl1d1lpUHdJQXM3VXdPZ3JIV2VucFlOMUZHcVd1NEps?=
 =?utf-8?B?UGR0WHpITjNVVHNtWGdNUG1JQmhtMHlyYnZ2STV1c21ZSE45bjZtWXlMelJE?=
 =?utf-8?B?UE4vMWw2b0lEcUgwc1Ayc1RzZFoyb2NJaGRBNE9Xeno2eFBtM2dRMlZ6anZj?=
 =?utf-8?B?SkxZd0tlNjhodGZweVBBVVlac2toYUpHOHRBbWdZYldnSEFabTNBbDNhaWcw?=
 =?utf-8?B?cm5mTDFRdWoremhYVC81S3NpYkx2SStGWmJFOXhKdnZhcEVvQnNTcVFEenFF?=
 =?utf-8?B?RXlic3NScjQ4bVdaWmhORCs1STJVWVcvRkxvalkramlrV2ZkL1FoeTlIWitG?=
 =?utf-8?B?SXlELzB3b09KUFd0dHU3UUlKTjV1WlhjRDNRZkxtVjZLaUhrSm5EUk12dzBy?=
 =?utf-8?B?M2xWTHQvaG9Td00vckowN25kbmtRV05OOVhueU5XU05OdTdmSWNuNWpRaGxC?=
 =?utf-8?Q?j6wtlm5bULhBDUoB7TdGvn4ntRU3ZA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzRPeFlTZ2dEU3o1YlhMVFBuQWQweXFDelB0dTJONFQrVkpBczc2ay91OE5J?=
 =?utf-8?B?SURoT3oyRHhlVS96ait3VGZHeEw2RGVoSlJNMlU0L3g0Y1FSSVl2NW5CaGt0?=
 =?utf-8?B?bXZ5SGRQcE1SU3NkRGxyamQ1VFliY3hsVVRjU0ZIVENuZHZUVDJUbXFCQ3Fq?=
 =?utf-8?B?U1U2U3BhSUlCVHZQTWdLV3dCcUIrVk9YTGtMakF5NGRFWDVOVmMvaUx1YWVZ?=
 =?utf-8?B?eE1ERkpLR3h4SnV5MHozeklMQVVkN0VWY0ZNUzJZTWJSSFpWV0dpQm1BNmNq?=
 =?utf-8?B?MVZYM0hNL3E0SlpBMThtVnNjNFJRdVlyME84VjhYMUZjM0x5WWN5cXpRMEwx?=
 =?utf-8?B?dno0Rm43R01uTDhwY0h2RUUwSXV2NGdZY1MxUU14KzRLOXRWdVFkb045c3h5?=
 =?utf-8?B?NFUvekdFbnlHRUxmbTNYazM1cmNSVGhjSXlMVVk0SU8yTWc4UUplUnBaWURn?=
 =?utf-8?B?YnluUHoyT09ZZS9iakFtbkI4NC9QUUxUYUltYjhLY0NXNzErbFpWTEpFREJX?=
 =?utf-8?B?Vm45M1N3UW12RUJXZlYzOEM2bS85ekFRUS8xbUFsZS9tWUVqaVlBMW9BcjJK?=
 =?utf-8?B?NVFSQUVVTklYY0VNcE1HSXZHN3g2Q3dNTEQ0b0E2TnF6UWN2S09HZVhwVGRK?=
 =?utf-8?B?OU5JWXRTcUNXcU5MaHhsUjRvcTVxcWNmb3h5a3FEdHhsejBhVzJ0akUzYUlh?=
 =?utf-8?B?N0Y2REdmL2NmRVliK0YvU3ZxMnFoRWpjd1VZd1pUR01vd3J0QVlEYWlUVUJY?=
 =?utf-8?B?UHY1QW8zZFc2TkJpSGVmY1o3Z3NsajZNV0p3WEpEWjZ5MUZOR21FalcrdC9u?=
 =?utf-8?B?VHBLRjVyQStjRlhQbkJ4SmxQS1pMZWltRlB6N2Q3YlV3ZG84NkNuRXMweWc5?=
 =?utf-8?B?TnI5c2YvTEtkTnpSQ3RtYkJsajhwUUY0MjZIUEsrRWY2QzRFajVQVGNSaUNL?=
 =?utf-8?B?R3J1dCsxVE5pNDFsZTllOGkraHRFMkN0M1R0QXAwMmZtVmhDSFpJYmpJTE85?=
 =?utf-8?B?SjAxczRVbGZTZFpNK0VMVmNiMWd3ZlJjMGM2N1hyZitHdkMxNS9hUHp5Wlcv?=
 =?utf-8?B?S0kxR2ZCQ1V6Zm0wWHhqNWlmMStYK3dOQVBqK3YrM29sczRyLzVjNmdJU1Fl?=
 =?utf-8?B?SGx4Mlo2eGRQdUcwWngvakU1QUNJbnVlNDBHeFV2V3hYMEpveDlIeklhR014?=
 =?utf-8?B?VHYxQ0hGKzlxRWQwQjB5SSthWUlwN3dCRVhBaHJGcUdPYUVTb0EwbjdPNjNG?=
 =?utf-8?B?MzhibFRJREhIbVJUaXBtSkkrTFZuMjBTWFpOdDFUNEhkNWpGcUtLemt3bDly?=
 =?utf-8?B?V3M3R0tXZ0d0OXRkQm5lZElyNXUxTDVHeklMVjhpWUdWelB1WkE3cTRiMlkx?=
 =?utf-8?B?QTJPQWNoU0FOaGpmTGFxOEErT2dScGp0UENmelJUOHpQd0N4OVk5S3ptc1ln?=
 =?utf-8?B?WnRqOG9IUTIxbjdSWDc5bzd6cmZNa2F0T1dET3FHL1R4VWJ0UGh5VVV1NWEy?=
 =?utf-8?B?SnRlMm50R0FZYkg1aFFibE9QeE5sbzkwVktOeHdBT0FmQWRrMU9xTms4bkM1?=
 =?utf-8?B?V2RDMHdIZU9YemlhR1N0cDF1UnI3VDJBamJ6SWlFamxaRmhVNkg5ckJXajUx?=
 =?utf-8?B?UE90OGYxd01DVFNYNDBOelNrRHhlcnhpZUVrRXlKbTJYZEltZkxSRDN1UWdx?=
 =?utf-8?B?WEVvckNyNkNtNTB3RXBPSFR5NCs4UzZmOHlWSEtmYWR6RVdUQ2hYa1pLVVVJ?=
 =?utf-8?B?dWs0Qmd1Sm4wb09WOW80cTVIVWVhOUQ3T2F2bldhMFhJYjVJWG95cDUwVS9u?=
 =?utf-8?B?T0N0UGZVbmNmVm96VlFEZWl1MmpBbHQwZHlQZU9aT3UrM1FNcVNxaFFDY2wr?=
 =?utf-8?B?alE4dkxLQ09HNTlsQVJNcjJMOXRSVEtUZnlDM20yVVQydTg5VGNFVTJtSnpu?=
 =?utf-8?B?QkpmZlZBQWZZUG9iN0owdlY4OFZtd01XOWthQkEyUlZtcHZRVlRmUlhkMjNR?=
 =?utf-8?B?VUg3ZlBGeWVpRFNuWUdqeWQySlZxRHR2MCtNeEVHV3lwU2ZVNlVQZzl1Z0da?=
 =?utf-8?B?Tk9hQXZkaExDRnVXNVVBMVVQc3BpNkxLM3YxK1FrSU1oWmpVYnNJZHR4TXdz?=
 =?utf-8?B?M3l6ZkZPRU9paElUWGRJNnNSMlhMaGRuUnllWHdPZGlTbFpHdzZaeE1zY1Vy?=
 =?utf-8?Q?LMZVsGjGQ1ZAQa/UaMIyB47jhyTkNHV91GCPTZ85vkaf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ef5000-6d45-4b7c-956a-08de3c61dff3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 05:13:40.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM2469chYOi7vZ7OQ5opoUgzso0Zfl5/40BJlmDSK5bMcH+xcsr9rY2d+jynkK5nyeHs2GGulASa8zzpv5P2lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8816

While we already have the `warn_on` macro, a common usage patterns in
Rust is to check whether a `Result` is an error. Add a helper macro that
allows this.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/bug.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
index 36aef43e5ebe..255c780bb4f7 100644
--- a/rust/kernel/bug.rs
+++ b/rust/kernel/bug.rs
@@ -124,3 +124,13 @@ macro_rules! warn_on {
         cond
     }};
 }
+
+/// Report a warning if `res` is an error and return it unmodified.
+#[macro_export]
+macro_rules! warn_on_err {
+    ($res:expr) => {{
+        let res = $res;
+        let _ = $crate::warn_on!(res.is_err());
+        res
+    }};
+}

-- 
2.52.0


