Return-Path: <linux-pci+bounces-37415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA01BB3D48
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 13:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407CB1C47B5
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 11:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C87E30CB42;
	Thu,  2 Oct 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YP0ysrtK"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4DA241139;
	Thu,  2 Oct 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759406341; cv=fail; b=iTs6NgE5B6Eumt1SY7nI6QugipqrHL9UZI/naPMQ7JkIDA+nnN0mKFA0bEmynuVu3XsrGJyUKTlz5V6iTZEx3uTGP5tQa5UHJUKSMNpeYAC42qPnBOhiDxTWvDWr78GC8P6nA/+/m8zpZp/rTeNya/NYGtqYJEc7qR1ykWJKSDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759406341; c=relaxed/simple;
	bh=MoBmvCa8RWkgiRV5BaN0QZO76xckiD+RPumPxTIe7aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iPkfagY6J5drvTNjeUpmaXS6Q/1LzwRTynn7rMKYJvybpcOFXmneYUyERVMBpcRhFcgC90gnYdkoL/tJlK2X1ZLw7Y5Gb2hCuZfrKw8jWm9FvhwjL7oDmnqK1SmfUV0q5GEx5LA6ogDrBmnG0w2N+VIfUtMUVQh7LAf+t61YAZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YP0ysrtK; arc=fail smtp.client-ip=52.101.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goxXABqi01yCo12rQ2ORVq848AswDEcHbykfav2I2l6QjZDCkRr6XR8geSVP5xXe6vdU0aibfK+kJ2DdLwTTFn74kmraoxK9Negt8rh7kgrRJlO3xd4xCf/xO7zW3hkH+l1Phtf4JQIrrx79urxvfjPSCq8PKiP8BObHLJe41c/Bi4UkxmTpp1wKwmMH85V4sRaqBotVO4Hj+T7WwWWv5aK21BOJDuz0UOI4PW/a7SGxlqa7UAYO4xPxMAmUoNTsRdcZiZScdI91tiT0e8x9AM4hjlMigVWt2RTPQauG39MZbdOERAczJmXuX+NQmlTmYynw0n4dGSHdIHw4K1Mmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iK6yGhStYtbz4J7z3jonIonT6NOqS5nBriSye9S2WhQ=;
 b=lPbvtvRMn39vn6bToVSP5q8prbzJdy4CUtonXKuvCPR6a6BGC9qFv7BVPowQPotxF39EwM7m4BE2i04L2GV09D0Oo6lSeeZRTzuXikq2IuwxYc8V3XuYethEgFBYvQz3UrbvwjWgnqxf2OlK1HBJyG90AFcSgW86moE0lz9zzsHPw3vvqIPktdHA5+QOhYyjqJg9qOFbQGJl49gCGYOxM4N+9N8W4bAUOCDI24gB/yUdXeqJfYnMgyAQ6sX9OVgmdnL92EGDtcMzKESXs8XHPjaSWZ5tC9YJMN+lvRb3Jz74FmZO3QVuyMCMCo/VKG6F5C0gX9HOe7NXzvcaCjIjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iK6yGhStYtbz4J7z3jonIonT6NOqS5nBriSye9S2WhQ=;
 b=YP0ysrtKrbx963qTlblmO0gaGX72IicFXTtVwNzhuR3aSPwvPF2O1RlIHeO7VH/tsXRXSQhf5AJuxFLwYcjLHKbZar4r6M2igw4sf0Ppzvjk5ZxSnyGUDznlsQFdMHdIeCQveFFBvmWaK5ur4y5MYWQuvIwfcWxqMbEnCFmBWjxVeRWGK74L5HOGuT8MZLvG3yS3oT6p2GxMdpdmrcDq1y9UiG+UNgmbITiTbB13PS1MJiP8GYBkiPPFoihX4ZM45wJfb9tUt1MYAUlubPc+k5eHdHwJJLMaoxckKJblUtBqdPuBVLauCQWft1CuMOqAS6Lke1x/5bM97dQwqglOqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Thu, 2 Oct 2025 11:58:53 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 11:58:53 +0000
Date: Thu, 2 Oct 2025 08:58:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Surath Mitra <smitra@nvidia.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Message-ID: <20251002115851.GB3195801@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
 <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
 <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
 <20251001144814.GB3024065@nvidia.com>
 <c56bd720-d935-4b51-b507-d794df3f66f4@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c56bd720-d935-4b51-b507-d794df3f66f4@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b8fc1c-aebb-4de4-1ead-08de01ab0ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yj991zzWz9b/oVCERTyB3kPIto2UMcQjCOAvAtfKpvzhdcWXpkZhRJrz+GdC?=
 =?us-ascii?Q?wQJVSYBJiorohYZ2+pdDGsIl+g3txMNvzH7dYbtbn2rsh2E7SfoeB42IdJ9D?=
 =?us-ascii?Q?TzZIBRWpO95a6zTnxghnyifgFNWLtT3QiPJ8LB7llyd2W86qZfx6rUPpv3rh?=
 =?us-ascii?Q?u7fLnRWdKt0JZbWDkqFi9iVMFPRALJO5C61Vm+eiKUqBYKu7b13n/ZxnW0Tv?=
 =?us-ascii?Q?BCvFurI+NzedsEZMfDP3TWOpuymOxYcIYBimLLNPQ0tHk1gYg+IyBNh4dMDm?=
 =?us-ascii?Q?RlsaRF2LA0HvRvoKQotAyTqwJqNTI/Bm3z6pTwSWMxZOREEDT/zRa6BG/KZk?=
 =?us-ascii?Q?y+N+jvkZl5/UDzbutp5dOvJr+xk+ivOqoySf7qSj5FdvzCfumvAvyh9BkgB4?=
 =?us-ascii?Q?1MyrjpX5cIgGfmGwnQsK+tyQ4IaZt7ZaVKB8kATkT4Jh4WRV94l1rqVAqrV2?=
 =?us-ascii?Q?Rd6dOjPvARpvz3oLH9ErLzRZmGbacDVOTKetb8/PhqvOIeNSC7Pt9vCfYRP+?=
 =?us-ascii?Q?RXUC3zq15tijZT+nMSC4NeUsF6bGSOHmtVLvDCdALAl6mfJUAMwtCl0kYj+U?=
 =?us-ascii?Q?AOxomd6Jj5nPZg1SQXkJY01hK/ZuPLxEKxr6hjAacm8Vem4pHgMVMTTaW6QO?=
 =?us-ascii?Q?tid7D9B58TUUcYUMgBqfmtu3/xDfiNW8GfdVqjC8m6S3NikpXXu+16AN6LuM?=
 =?us-ascii?Q?TgYpJvMuntnZ7mFNHYFpMEPK306JJu3VxpLLka63nw9nkggJOp2w5cVdE4mD?=
 =?us-ascii?Q?HfCJ4OlJoAoG5nAAFv+vVML9K5JNEWSBbmopCkwBkcszgZjOBZb6/QOHHltG?=
 =?us-ascii?Q?7Z2xnK8nPaIpJQOxQFnEwkLX6JBZtJBZ5GHIYnU/weKDRSokgH4fSLLYs99y?=
 =?us-ascii?Q?5Di7pY6cH5/T5UyuXUfBoYusH8MFU3t4P7C7zBRlrDwcRiv0bdShpam8c9Az?=
 =?us-ascii?Q?XsXfkaz+w6vhyMcRGMNOXIukEIh984Q+qm1JUP1gygmzRu3IN7JUcMsf1nLT?=
 =?us-ascii?Q?l1pwYKPX3ouMjfTzDbftD8RCUI0cFSHCMV5BaRy/jy/Xw/rqP1fYdirMIH8D?=
 =?us-ascii?Q?2UQvWEN3PG72RYMyu2K1K0czCfv3mIl74tE0CR+JyXY9WHJNJLO59U765KdS?=
 =?us-ascii?Q?VGaO1+bQpIDGIvks7CRmFJBffgJB8hsDnbz31HJx2v/ekMjMU8CHygU4ybV0?=
 =?us-ascii?Q?MrADgc60/JdkPO8BB5ziAleS/wqrnm/9BeB3pzdaTvsmEfnolhdjeg7kHP2r?=
 =?us-ascii?Q?41nH6QmCNp3jGZssUZCM67WHQR/lXjlq18vThO0YG9RYBj1BN/PRU/qTFwhw?=
 =?us-ascii?Q?8Cr9ltB4jEQvLFm5xmcVnEmkwHyhOMMwUYiDprY0XxL/SJE2uOszntVKOXEB?=
 =?us-ascii?Q?eHaYVTppdo3NvgQkAlh8oUcxjfSJUyXYVtSsSnfaXibMt7VjFIDSOvzpZPLY?=
 =?us-ascii?Q?/lDVZi0VCNFq+54dlj0bjSSSk5Q5k4Cj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uAYXb4e282h9M/AIm3UQ8gXGNO7s04fNxk2HzGWzzLYnCKKnGBXfVKNFTQ4R?=
 =?us-ascii?Q?1c4Wj0NnPwSfdEALMaub+k/vfh8hYm2u/3PgLqixOCvF14Pj1ozt/S4o2fU1?=
 =?us-ascii?Q?tZaYL5ijWK3gFby8H8nS6C/48FwMpLVfMdNtf0QZfr8PYdf0LiefqlKaAYGc?=
 =?us-ascii?Q?MBHSkpuUOlo0idURY7LkYvWOTLI2wnxh79+LElRi4oGOs2AbCal5K3WkWXUR?=
 =?us-ascii?Q?wtbOHwoMOq2Tr3Czn6INQm+/fEI78MWLjIwOC5HWKD7jhAX+9e6FNT30OCoZ?=
 =?us-ascii?Q?/jAID1+YnhlEdPXrW+GtK51x966dT7tIrxlvzLHgnGp95qsA6Fijn0JnI6Jl?=
 =?us-ascii?Q?3tcJCa4uJVjvUxaKUGd1smbIvCBEeJf1F+LbVib15ghBpTT7C0KRM43P5zKS?=
 =?us-ascii?Q?FApnGjv/YO48dfm9WnVjLvy1cV5fHuXfhqyF/bxONQIFjUDjAGg6/C8jlBIh?=
 =?us-ascii?Q?gmafBC5ouhzfESszDNs2Mvqn4A6VBYXg6SeKqNg60Dv7Bi6vBADk2YVjyyL9?=
 =?us-ascii?Q?oJOOb+EAWe6ccuh0ygfjsYPO/iu9o+uTL3wYoSwwVpeOdTgUH9wXYb8KeiAl?=
 =?us-ascii?Q?OiHO4RxBJc7EEMnAstpJ8nKW0ZizhZeAbdjAu+wroCWDWBAZ/BVpjXgdMkCt?=
 =?us-ascii?Q?ZW1VseqOyyO8q7EfnYavO1eNW/eOOr8RtYMZGMG2mfG7s65mQl/6v2o2eODD?=
 =?us-ascii?Q?rdEmh0A1oIjiQ5lYfOcNVyDxE6TrYOGYq7mMIST1FZulcb5vLXVKkG4UxyW1?=
 =?us-ascii?Q?ht5I6G843DWL/AJSTPzyWa2zoYg04vZlyTddWBpZqDWsaooQxEIXuXc4pvvz?=
 =?us-ascii?Q?5iiYKAln+s8nde6mFkpClCEn7MQffqbN1jn1nt5TMi9iu2GKM4kMQqLJy8U8?=
 =?us-ascii?Q?/cQAlsk9kFbsin1Px9DiwiuRiAFY2jnykuWfWRvuenq2LwjmbPKRpXvX/lQW?=
 =?us-ascii?Q?jc8m7Sz7MbsKPHEY4HJDfzfdq4Y6se4Ae7rtjb5tbNhlM8NUl1b9EYv1NDNe?=
 =?us-ascii?Q?AvscjTjzSQk6ipVMo8+h5GYA/2VrZbZZNavj4Bh79PHF2BwVunlBLfK0eVRu?=
 =?us-ascii?Q?sgojNODuPaULzDT3xhY7J6fkopn24EclB4WeuMcnxMjeV8pVcpo8jVrWk9D5?=
 =?us-ascii?Q?e2Tq4jTwVPabMskgdOruNftwH1MGoLvrjWeRnw/8gnnMM/q0A75aDLQF+xoR?=
 =?us-ascii?Q?3jRuxGZwrqfmxBg0SYOjGHjawCxE87PEho+dMpsvhHX9tXrSaK09hfs0OJPc?=
 =?us-ascii?Q?D7FhsQN0GQBBV5XzaG6s4sJBb3RNuVQwTXI2mTRSXnqslFW96xxZpojXe0va?=
 =?us-ascii?Q?WjXN2ONCd+/kLcaydUTzl+fljlMwd9mjvbQHomUmBKZSzOZ+/x6r5JQ7WZhe?=
 =?us-ascii?Q?rOMPIpyLX/zNwXmOz5QAk0o3fs3nbRXJNQM0hzJuKbNM8GVtJD2ThCRREktB?=
 =?us-ascii?Q?NhavKW5QwXKX4FD30I66SAlcagGKRFQistJYr2yA1Ywt3nA8q5QXFvkoDRZH?=
 =?us-ascii?Q?7DHJ1n2TkmanrV53KoJtvp9N61YWo3ic32f4t/hlWa9+NSkI7qD8WdirR0JL?=
 =?us-ascii?Q?Nbhnv6mQHLfWZqgqfgDbnoVApoxXsN93hwqAQjoU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b8fc1c-aebb-4de4-1ead-08de01ab0ed0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 11:58:53.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFzXkaeUE6Cl7jIvQONiFSL9xFA0bxBy/2wUNb6F73SG/81sgUpc5HY02VbdmSjH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285

On Wed, Oct 01, 2025 at 09:13:33PM +0000, Zhi Wang wrote:

> Right, I also mentioned the same use cases of NIC/GPU in another reply
> to Danilo. But what I get is NVIDIA doesn't use bare metal VF to support
> linux container, 

I don't think it matter what "NVIDIA" does - this is the upstream
architecture it should be followed unless there is some significant
reason.

Jason

