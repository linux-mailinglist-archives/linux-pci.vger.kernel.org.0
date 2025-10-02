Return-Path: <linux-pci+bounces-37432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A3FBB4194
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 15:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0AA932406D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745062FCC1A;
	Thu,  2 Oct 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GqutJRWg"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1479CD;
	Thu,  2 Oct 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413369; cv=fail; b=CUICa4WM6BdRFjUJuV0uqPkeqEFuqmxymxxQRL8tdkCTBQLZUmpDWCCcVYrIdYglBzGDEDFnOs3e45ssut5nXlgZhQz8RbkGJDlYBD96CUxutw2BrZz2+jMduU/kx5tJ5UTxLs/viDD4EBR9vfMFoWM5OnUcE2hcISo5tB5ylJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413369; c=relaxed/simple;
	bh=CfB+B/ZlpPWMThxM7jtteNN39NQB/hOkGEZEU+So9qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G8wgqOFRh3qMwSltQQMChyPAL97BxDN7cuDj4ToCm8K8TSkZGzvQxc8FmbZgnQ+9QTU2M79xLI9l9+6T7K2GPaK9B61l5G6FF3mfeFQq9XGejRS2nBmYTP4zf826LwCVSsAE1YXJ1Pvtj6CBW9E+1OM13GgdOnXlVLrHWCdIJm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GqutJRWg; arc=fail smtp.client-ip=52.101.52.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOUYntF9W5NcNGR+tKGoFi1k/GjJY4FCAaZkS1efBN09Izkk7y2/RA3CARrDs0jr9LWfqTLDcEMHNyYjuZfNmtvbhIsa4mGeewOorfPDMgKGZ1fLuJ4iV+ZTegykWXcaigCdNkYLBsesOkT2Qr+91Y+PmuJT5E8trElGYBjWqNnaOi/MUuTOubIvNo4alxbZUN61SGQgxWNUcr6Dp4fD3l0chO8XgIaga97duRO5vzSs90KpzmCOvO1X11aUI9lPfbKgKADJl3cK4Idjc0mC9CPG588Wg87/pbkygmV6vuNAlYoLAo0+31DCTql60I8fKqF54Ze27duLndHIUHKb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfB+B/ZlpPWMThxM7jtteNN39NQB/hOkGEZEU+So9qU=;
 b=hJfcHNX68fk36yahTMxQk+nDY05n3hbscA9aNCFNhdRz7ThzFvt7N2H9rhjfTfOoKK15XAin5MEeXHmjp9SkCsArEVZ0GwC3DqJbG2W/pO8gHJCTfO8+B67Ngj5E/nGWMH5qvkuMSM37VbMZ5An+nc2mdu1EGFar6TlOH3w8A/U+5Vi7NQBI4a4p+eGKM3oN47b8UtDl3DrHFnljdbih0lMWN7yAPQ+O97CI432ViHdwhVY7r87Wis+j1fTwL7DuEAG+WJLVDnqEXvxYp378+095iWKOD4t0GlAtlDAGh4uPw73Rh1kj5sMWMdkErNOJ2FtXkVLjK3GZ2pZT5ixu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfB+B/ZlpPWMThxM7jtteNN39NQB/hOkGEZEU+So9qU=;
 b=GqutJRWgkqDx0pM63vKeIaR66WSqdLHGqp18beHciV4XtUID6+WXWIo0knIyQsMqaYQJ2bvqKPnov/butUHS5LikIYzBTQ28Mi5ckqCrHFRgWWdM4ey3J7ckLQo8L5m6qowLT/gt8AA2cc4kc5tAHy0aHhAqJRWaHTUDjyR0AZPMvGC5PNPf0xi6c3H0VsU4DGsRlxgUXP2DmqTDjVAGwR1BZfoMKjj2p46WI+bLVl2WHkx73e85Q24ONiY9iHWblUHq53IQWGQvczOuYdnUEppViAEC9WNwVCeFwOWE5MHf/KHuWPFDwLQUNmbXCW+9apGas4buXabCBAX/KgcTaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.19; Thu, 2 Oct
 2025 13:56:02 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 13:56:02 +0000
Date: Thu, 2 Oct 2025 10:56:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] rust: pci: skip probing VFs if driver doesn't
 support VFs
Message-ID: <20251002135600.GB3266220@nvidia.com>
References: <20251002020010.315944-1-jhubbard@nvidia.com>
 <20251002020010.315944-2-jhubbard@nvidia.com>
 <20251002121110.GE3195801@nvidia.com>
 <DD7TWUPD83M9.5IO0VX7PP1UK@kernel.org>
 <20251002123921.GG3195801@nvidia.com>
 <DD7UVCEVB21H.SQ00WZLLPINP@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD7UVCEVB21H.SQ00WZLLPINP@kernel.org>
X-ClientProxiedBy: BYAPR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::48) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 7928d2cf-dd5e-4ca1-f7d1-08de01bb6c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cz25LdsN4Z3p30m2ZSuj5byXODOKx0I4BEYI03jWL9Ykdhe+4jYaBLpeaZKn?=
 =?us-ascii?Q?XXuP4mQdi+GMp9lV+fSqvksqoCfkN97QykwJwFc/KSr+50BvaYpvzP/tJH+C?=
 =?us-ascii?Q?eZvszhD5yolWUdw+JE55DXPbVffm9TBOfKjPiaXa+5fc07tuIxTAZyZuhUB7?=
 =?us-ascii?Q?n5ruteexxFUKBpdj79kb4WIEwSgxSTaQpLo6Z/WI6uIhodm1nTMyJIsMuD5k?=
 =?us-ascii?Q?bi+SdhI5Mjz3xYqu7hXGjOKhvWM1Cs8Sdr709Hy7arDrJsCxFIJ6V0PoS+/w?=
 =?us-ascii?Q?iolxTKl3gdgGxXG6EqONgLJevRIYc6Aga7/Hw/i4iNvZQzxH0e+C5KwY3CQe?=
 =?us-ascii?Q?4D1iEsHKKV5gwPgNYeNV9AqIXPoFxVDWXvw12SjGgVxGCqevcTexDydx6HLo?=
 =?us-ascii?Q?MyiUrN40HrY4affbRaHCnxjR89lMYQZTql0WnAGwPqTU4Te7TJk24WzVIUQf?=
 =?us-ascii?Q?8TnqeWffYcNOqtb6EF3pIX/dOf95q6rV3Y3QStfmAj26hOCKJ42mzmWYHiJk?=
 =?us-ascii?Q?+Xz5Zhsaw2AbnOLa8mNMtclhenqzTs/YCDrsCeyLKt2CuMSWIE8I4osSq6Jn?=
 =?us-ascii?Q?gu/ylzVz9dBg56fOSfizYe2BA6Jfy1hrrnXJpOB14f+E0PK9fkw/naZTfr/H?=
 =?us-ascii?Q?wKHnIBHvDoaUCz5ZQKS9JWjX5Bytq9hzGu86Rfpw0RC6bFIEUmZWwS0t5sF5?=
 =?us-ascii?Q?L2P7AzCvxEcW+7GHPMtch35i/WIQONxEVQcLwyP6yZMpiNzDLuqYvo+9If89?=
 =?us-ascii?Q?ic9F9eK3gRnZQ311jIyRB6Zat61Mn+7xLYlv59pV94AX+eGyi4evOa6yZ/lY?=
 =?us-ascii?Q?rt709Axp49BQYuOVT3y8x7N0syryVUwWrS65ilpPWRfkspsxBdhWM2vEoo7U?=
 =?us-ascii?Q?VmCsJIPKxD5DN9ndy8qjE2MC5GQBR3qZgWKjBd8B6W/05ZJzWcQYqJhn4Da/?=
 =?us-ascii?Q?KwjdPUgI82SbUnlxJ0qthjJJC2Vqpk87e5wzhhBmVfN/FRtSs4WTfCPmjGcZ?=
 =?us-ascii?Q?akZtMPajM363fhzm1NpK1jaP1mzN83uAcBgfIdV8bqr0sGJUPQAkwo2jW1vT?=
 =?us-ascii?Q?9RbIHcbXSRx6Ptdw8wLhrQGFLFkUqgjQj2falveXWT7hHgvjiZlkafPT+ntN?=
 =?us-ascii?Q?+DME7n5yOZmOkv2jlJiX6YUMT7dTEMIL+DDA9CO5d5O+s87qLOysbuOe5OHM?=
 =?us-ascii?Q?t/VrZaAeiYJ70cUIftydEKAA6OpqxQMKXsrVibsDuWw4W+d+w7q2nO5nzcbs?=
 =?us-ascii?Q?924wykfW5IG6/Y9mXWoAmwAdWjoRqLmKWpJJgI7078rhLWui2z0WHtHvp6na?=
 =?us-ascii?Q?IiGOG7nf9O368S6XnzGWGrU9GipKEadNyB8N+I7AqJUi8+6e1/r1pFOezsRn?=
 =?us-ascii?Q?Xaf4+W/LUrf4uf7yqoemwW0QGB5h+CcDp9Q41PbM1QOCiyKQ/zRzub+4EL/M?=
 =?us-ascii?Q?S9lZZCVZFCN9xSILbLyDR43457xROEJM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1gvK0ReY6khBEnnCgqYKL7JKRV6Na8dkJhsXRY41bC7b9inqW0H0jP3aNMK?=
 =?us-ascii?Q?Fj/x0vBo6Iyaxwl1EiHObZ2/scM9mjmkCwW3GThp5ShErLxaC0e+3IobjkW2?=
 =?us-ascii?Q?Nn6hz0VbVFTrI287OUmu0U8Z0wAGbbq9EtlCQWF56zRTbFPHjfq5ZPc/vHy/?=
 =?us-ascii?Q?NX9gfePa9bhLposFPU+19zktMc2JJ8zC57Ntg8winlds1OWPsg+Mgl1ysUKZ?=
 =?us-ascii?Q?kVZKnyzlZ0lr66o19Xu8Kz30l7eUvGnTJ71SmNtNoxtcKLZCOUrp9Eck2N41?=
 =?us-ascii?Q?4fWtC/qz+P+LpD1vo31VLpFckNFFbeLCl0z7uXsLxU45bcAQ8kb9T4FxaZuv?=
 =?us-ascii?Q?OeXEBSZA+knJsyIJ8OkvqMNU7ouj2DDYSzJf7JG3ZdA/RkVnJg1lPyhCSuZ1?=
 =?us-ascii?Q?5XOEdM3dwC0KLxp/eXIfUOk2ZZCtKXeI1PzpUfqMIDz2OXTJVBpwCzFBgYJu?=
 =?us-ascii?Q?UIE9EPjFRHFafRjs1q/FgQGj79NQqmY+7tGzPdutveaJawaOnULZJIqaAUpV?=
 =?us-ascii?Q?WbXG8Iq1WlvqMLGh2h1h+l7I9t4I+X0ZEs+H2dFmjIb6N2t4SvcIPFQlmyuR?=
 =?us-ascii?Q?odu2p92s6MAAeWhm1Z16UCW+iJDA8S70YcNl1wiI4N1SmtSQVoQzA66tsts5?=
 =?us-ascii?Q?cpnTH92ZAIEUwc4xyoNP58XCMj0bGks+oYtAbLQrRqgFf4CgdSmNKYVPRff7?=
 =?us-ascii?Q?LBzjxzWPmTPkY6xLQDxKF41Yg4eLEOsj+fBOwp00hXCVRfnoGg30N1NppR2M?=
 =?us-ascii?Q?KWEoa5IUymRxOVseoZGVB1JttI2T6QeHl3RO5go9lKIHrZqVTYLQPSyuncnb?=
 =?us-ascii?Q?VsctSAXZDdtHLKKJGL3H8nsCMa3ZSViG0RneObMRbfGak+ojfB6g+9LIoR9C?=
 =?us-ascii?Q?kEn5kbMufQ+BvPoB4UDwgiSD5a+tD9kRcZ7LOxH/jjsSaJplNXNc3f45GLjv?=
 =?us-ascii?Q?AQ1lWeMbvf1reBEL8Jqc7LiUW0kC6hGc2peK7HOhZ2tbxO+YiqDg9Db7nkK7?=
 =?us-ascii?Q?YY/w17E21CQ2WYnA1m3xuUNzPmvzdYJ/DTF85LCzeYfPGctxf5o+H4yXDzfP?=
 =?us-ascii?Q?1C6U7ORB+gkP6cWqnO1ZDTosc4kJ+hWPU1+zFL4htFyG74LeADF/FXsZol+E?=
 =?us-ascii?Q?DW89UZY2uj3tCgTCnxQOV6I8i+q68TvL6XOBTrzHlHM6iecJkv1zHZepQ7no?=
 =?us-ascii?Q?hcoF2JNz6KRYhonRhZsR4mNmdPKNjMTUgzXqssozFrHR+x2NKuj2M/c2BZj1?=
 =?us-ascii?Q?cG+WxtIEL2vaNvS/2X0BvaEkykXy5AZIuPnshEFRD2jdncg6AF0gjnxeNOYb?=
 =?us-ascii?Q?zGCAj2ODf6xwtsuukQXn8QadjHclFYpST3xa4pqLxjWAxTdhtHHGg/IPP1de?=
 =?us-ascii?Q?HpGV3GUN+97zdVgY7E3xJ26ZSWv8EckmJ1c6ZLjiQ9fipq3mpRb9BzVm8ykH?=
 =?us-ascii?Q?CBDAZonZArfsGEa0bbVwzwfJqugEw/QgMTiHD5FtMggn8wIfq3VKKdZmx+Kd?=
 =?us-ascii?Q?NmM/Cn6QGoOQab1QQD35b7L8BBfe5jG3TwGphJoY8wDd8byTTrctKmx8P6JO?=
 =?us-ascii?Q?hlFnpY429ZuIcmo3y5q9KO8Zx3qKsaRzOY/NYmwq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7928d2cf-dd5e-4ca1-f7d1-08de01bb6c6d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 13:56:02.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfGuOpTZcOqQIlmJPOw62w3oIcrIaJxXdUeQsV4UXauddH+KIqSeS5foncJrWjMy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128

On Thu, Oct 02, 2025 at 03:03:38PM +0200, Danilo Krummrich wrote:

> I think it's not unreasonable to have a driver for the PF and a separate driver
> for the VFs if they are different enough; the drivers can still share common
> code of course.

This isn't feasible without different PCI IDs. ICE does this for
example where they have two totally different drivers, and of course
two different PCI IDs.

> Surely, you can argue that if they have different enough requirements they
> should have different device IDs, but "different enough requirements" is pretty
> vague and it's not under our control either.

If you want two drivers in Linux you need two PCI IDs.

We can't reliably select different drivers based on VFness because
VFness is wiped out during virtualization.

> But, if there is another solution for VFs already, e.g. in the case of nova-core
> vGPU, why restrict drivers from opt-out of VFs. (In a previous reply I mentioned
> I prefer opt-in, but you convinced me that it should rather be
> opt-out.)

I think nova-core has a temporary (OOT even!) issue that should be
resolved - that doesn't justify adding core kernel infrastructure that
will encourage more drivers to go away from our kernel design goals of
drivers working equally in host and VM.

Nova core should work in that it probes, detects an unprovisioned VF
and then fails probe. This edge case could perhaps arise in a VM
anyhow and needs to be handled anyhow.

Also, this is all pointless until nova-core gets an sriov_configure
callback - you can't even turn on SRIOV without that!

Jason

