Return-Path: <linux-pci+bounces-37454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 688D8BB4C1C
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 19:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CCE189564B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E575272E63;
	Thu,  2 Oct 2025 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ubtY8WE3"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED59270557;
	Thu,  2 Oct 2025 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427774; cv=fail; b=ovGyM+ab1TL3PVWSATHoIjkhqU7N7pBEtaCfXryv47CV6EfvqNWQHFacopIh/AGTqlzCDlawR/wD+O/x6T9ZVdItYrKxG+j+kiv8bfnLKj1CqMizTBwLLt/Khcb4KjhrEryBm8LmCFnjkf/oWyTrxfN91YVZi9WU3LF63hUXgsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427774; c=relaxed/simple;
	bh=nCvrfc5AtPfTVLB24s64NgHh8wLngp+4/Sk3P70SGKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vF75M/lF9l9cAae7MGU3EL/N0X6XcynT4kCACjN7NaPoocZEGyKYFFy1bsUg3LwQOzrR2YWMFrYmWl7KB6Wbof5EFrApmbQCYwm1Vfe/U6G0TOO6A0oM5mx6dve1DfNYV7rfY7iz12ar84rdQcDkaNq3vGVlL/e3Fj7R3OzMc2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ubtY8WE3; arc=fail smtp.client-ip=52.101.62.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SptiOfTUamoWd8O3aCJ/uI684X/mMKF59JOU9HPOP7cH64n7m7xMXZ1+CFgRKtjcRsRKCv4oKKTs6yFadFRm5m9yHZ9UsMUJHbxyseRFz/2DD0B+7TQ4rMAh8eonM2/TT+kOYunrdqHj50yIpmqZuKa3q0ravWR81qVqt0tvrBO0THDUefiIh68EaU7+2N0LRbrz2eIkB5v2jO8K9axIrnCgdSOAsHTqap+UMRa+FBml1VrR2+UXz/rEQbR1/W8Fy3W7GqvBqXW0YRFnF/ZDMslx8MuAn1Rp6jaopGDFStEbYNExDdI0B+V2Wr0gTvkauHLEDFUAfdu6mYGhkLSYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJJ7C5XciyyQ3n/8TmYtI/5XSlyVhuFXMaZpi7RYaMU=;
 b=izi0gcsJu2IsSiuDK3PLZ1KaYz6dxZKXiJ9IUf2NIdl1jrqFIWHLiDcxvx3fJMsLjfM/R9zzuuvQfk0nwtHnwEX0jzqEDN1Ey0EbGSC6PcO+5STrfRkSSYh7sdEOmOAToAmPq/Q4dLG9xBjcDs3BHuAML9BNh6iPm3v7oduljRpXkmRSQs7VR8dx2nErKf+JOFsMlN0pCAxs7YkZEXrpKvANncD5Ob6V4CF/rNInPIZQKu189XB32XSgAUbo2cO8BfNWMlRvMdiA4PZTHtFWbG0dTj1R6+C7wIuklLeU/zMjVYLeEbEzKSSIPyZfFWZyiDhPA8hSoYjqnwIaX7V/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJJ7C5XciyyQ3n/8TmYtI/5XSlyVhuFXMaZpi7RYaMU=;
 b=ubtY8WE3l6LAanZkheaWurNxA5f39mAR3n0DdUEezTfLf8SepD4xbPsOLAUe6/fTRuK3wOy1ZxTtMeL3fgmmaHVbQ3cj+mM6ynuMYxlaxczxKwucsbQVil/fk5FaxGrMMl0jrkS8N+e7bgILDIMcuRUYtEsxWu0RORt4oxkvzGtVY8KIgQ0EKOG3rcJ0mL9Mcfxohy3/42HZjmqW46g1l69kZEUHYJLLOYzEJjKtMLLRj3Jh5iMNZfQw/3XCU2YqLhoCQMahTCV71gqlBRtbidFeehiMEBwBQkhY1XpSXPitxni0Ww0AJmdOE1lvEpTvq/bYUU+Lu1gOf57rNMIvLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 17:56:05 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 17:56:05 +0000
Date: Thu, 2 Oct 2025 14:56:03 -0300
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
Message-ID: <20251002175603.GB3299207@nvidia.com>
References: <20251002121110.GE3195801@nvidia.com>
 <DD7TWUPD83M9.5IO0VX7PP1UK@kernel.org>
 <20251002123921.GG3195801@nvidia.com>
 <DD7UVCEVB21H.SQ00WZLLPINP@kernel.org>
 <20251002135600.GB3266220@nvidia.com>
 <DD7XKV6T2PS7.35C66VPOP6B3C@kernel.org>
 <20251002152346.GA3298749@nvidia.com>
 <DD7YQK3PQIA1.15L4J6TTR9JFZ@kernel.org>
 <20251002170506.GA3299207@nvidia.com>
 <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
X-ClientProxiedBy: BN8PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:408:70::38) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 654bbaff-a88c-4b80-b7b8-08de01dcf52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f/fPDS24dr5ZwfkOTZ95YnCnG4a6PkSVOkHejlcGlQi4353YvBp309zV2YqQ?=
 =?us-ascii?Q?d8oFbVT0a6fe9CUqKCRqNgHd4AE8MWkqZg6D8StfdQjONsJ3/mgepKgrQ63Y?=
 =?us-ascii?Q?1AoaufvGyN28tBKRo0Eib8JSiPow0YeCSX++Cn+YJno/bpQbpDw5fqiXbVFj?=
 =?us-ascii?Q?zU66/nWDeEKANZWFMPRhbLlZn/84SESYyNCA1T3lB4VsvyJ3Dg6+PGeaPDWb?=
 =?us-ascii?Q?gQCFzWwH/ipLWHvSXeoYRjcXwp/2Myhl2cxQK+ovmCUIEIivfUgY0VfU8fo0?=
 =?us-ascii?Q?KY/Iv3+lbhmvEhF7+eSCLCvJPWZ5wVVd6QwIzHKP9F4FNPlITEeGU9HLUsm4?=
 =?us-ascii?Q?JbqjkQuIWW1iqERA6I1hBxveoUTj/wiHh80vDwti9vRcldXgNwvVbUsfVOFf?=
 =?us-ascii?Q?fOgPnPFCd5R93mC8CADKiNRkdRS3+D/GXtCT8/dQTtpDBWZrC6FvUYb0uaSP?=
 =?us-ascii?Q?nNyHqB1lrDbCmBC32foEs70sahGDj2L14Gq9SOTQ5DMQ1qsg0G5V2SD4MBif?=
 =?us-ascii?Q?UPypfPLw4uf2FESQDeKzI/1yJC8b+6vC/nWkWLPChyul/qSTRR2N9Goe1bWR?=
 =?us-ascii?Q?rgOghyRUQ2aOv5PXZR18sbBajJVitwXeDf5ehG7DkvL73wAxGFC4ABeOq24X?=
 =?us-ascii?Q?ES/HuUVntilfxvUVI1IMLzcYMx1ATVL04UAQN9wzLwVNsZz/8V3z6c/3Hc21?=
 =?us-ascii?Q?Fd3CeCZ0MA8DkPmzWWVcjbISrmR51RaCr0BeWSFcMoymuYkGCDxGQx8iqTVk?=
 =?us-ascii?Q?/S5q5x3UqW4Muei3nM9+VVEDvWjHC/z+np0d+u+TWgmrGwKKBk4Gvl59LD/p?=
 =?us-ascii?Q?ey+N9g3TNVqdYGI11RSEnQq98hIrm5LvUcVzkcafUrsHw0NTTiQ00RO9l/bO?=
 =?us-ascii?Q?tf9kM+VXNGfbpKtFYU9nV8QkKgJPI4porlj/XHxEMmeCCVip5lnOjm01F9rT?=
 =?us-ascii?Q?Ko0Zx5dXsngIXgCOtzWVi/ughFPLQHrZisfUlnvOvnY7qL/HqWQjbAoNLgQW?=
 =?us-ascii?Q?F7lOL/U2nY5UJvGD+X6HJhmTg9NbdDFS6OsdblWZT7mcmaicV507KPPNgsK7?=
 =?us-ascii?Q?uBYwYoZHET73qjrEf/jOIX45gI7Rna9kzBPKiARBXmh7ZUry4yqm3VXEQFI+?=
 =?us-ascii?Q?xqlj1I98wvS6KMV+q1K0akf3wFmw5xWfGpq6KapuaTanz2CPyBzLG4KjKPDb?=
 =?us-ascii?Q?4z3pdaamUGijIBGzjo27+Q/26zE7FhmoVVCWQ91niiA+ALgIy0EYXOYifaqV?=
 =?us-ascii?Q?lSy4NcURqCpGJqIVRZY+YTZSijUzDkNqCtFib2OHJiCrUmnTjCSi3rfUw1rJ?=
 =?us-ascii?Q?ww6lIyUvPjT2L7SBVzUrhsC2lLhL2U0TA2NZdSlejc7vgyYhQ1GdQl1RcCXr?=
 =?us-ascii?Q?Xd8TsL/Y0N7V8n1VStzIwNFKnMTJMGUP32/jj8I8oj98DPDPGM1Muhft/NAW?=
 =?us-ascii?Q?1SWUG5MfXhPKh/CQOOHT5SKNJ9LdbfKh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?81thpMexwZGfV1p1ZhNujGXuxawqa54hlDLYFybKJOTu2VFgiGC63T0EI21R?=
 =?us-ascii?Q?AeROpEWhLhiaoAGnjvSUls14fb0DK61lj90476tVsMt5+eBLrS6ArJYDuRx7?=
 =?us-ascii?Q?rRLvfCpIDuMgATC7+sUyTCGewQMEdDdWNPI1UqZZTSWngAO/jvn3ZGkp1OKz?=
 =?us-ascii?Q?mmgsvOSR/lkOFsMUtg0yHCBnpf7ajHAG8uPJ/aZuUC79D89jRalBWgSWbQ5q?=
 =?us-ascii?Q?7C41vA9IkDchO+mpB4tOolIbStOUz8vzVgHBnuS36zE21n1H/PSWu5cLJPdf?=
 =?us-ascii?Q?ErVJ5yCjbUTYbDwm/BAevTuR9c95/EX7hSlO4rbyMOkdU5dwdkkQ/zm9hva9?=
 =?us-ascii?Q?OHvRqE68dEU2uBGyR0BLEISlTmJ+fOOLv7YrRPZIBReNEFR0xyftKQr+NCe4?=
 =?us-ascii?Q?PLeCmFp5Jsl/JodgsHJ3t8mLM4RFNVXjtXoXGfYlzybtDamHahGo1nL8z83l?=
 =?us-ascii?Q?jq9VN0tZNIh08NuiVelQSH1HvRltVmMvcbLJTAcmdXG0II4pDV77D3CjwG5/?=
 =?us-ascii?Q?On2cSI5VJQYHkfk5X/l8tRwip2ixyiI6Aw40Wpax0Cm0F7Gs4XIfy0o77H8V?=
 =?us-ascii?Q?/JtUIm3HGftE5R8nIc1NylUyCDhDDIK4JIuY41fjZOfidtVCgvkIR46/fHQe?=
 =?us-ascii?Q?WpMrdHA58QdbeM682GwVFpLOGPyP82rtKNKu+b8+Zr0/EcNtsqKlH0qJPdOS?=
 =?us-ascii?Q?IeM95e3YCeoXQ6U93XpbNOy0lJB6WG8Qvfp0ATy+ZwJnftmXHoviOjDOStTp?=
 =?us-ascii?Q?jq3sHBfVzHrgEx/tCRYvgBjNn6JRS7s+uTUNGvPGysJh53Azb+/yEuLMyyfU?=
 =?us-ascii?Q?o4GXd1AhKVObbzaOR+HCPXJV/qU8thf6nL9GtYTIm7ul6Hw3KC3Pw43OZL1N?=
 =?us-ascii?Q?orK6Tpbo6SNmyK68RNUB8GcY6X8BgHJbPQPOX9qma1uWQ+1/J/9lxQY4Mjmq?=
 =?us-ascii?Q?gJQR9nV5mpFUu4PpXwJMVwHCirhP+Hj8CNBVRPOSLRmpS3FGxQ6bY01paEAr?=
 =?us-ascii?Q?JJl5hDxXqmGaAcT27MA1tdSXTb0buuwyY+43BHckn7BPkwhtyG+VG7EdJSeI?=
 =?us-ascii?Q?7DkBZAv1fGu2s7OB5oA74A8OIIudEv57spmEwM9xqG6tCOHWqpX4JrlZYKE3?=
 =?us-ascii?Q?p7QA9tylm2GNarjvHBiUYEMpmZLT0tH5qywdz4oJqqQfa2ucIV0Z4B27rNRN?=
 =?us-ascii?Q?03Z/Xex9gjLSkN2gBdzHLL31MGlcxPv94hWNsCxqbVfBiHUx3H+/bTVTtK6Z?=
 =?us-ascii?Q?wU9xNDMepkfkcYyBqjJ2RnjxTR8LWhLbcuPgskykbh8k3BxUA0lkfGYQv1OU?=
 =?us-ascii?Q?IcEIW67O64FbSyA2nM7MTUerrrujGX5AmhF09MGboRCKbh1e1ZJAWZZ7z1Rb?=
 =?us-ascii?Q?SAOpoMug+zFhqpskx9EFJ/ku6n6Pv9IlCSV6cCLRzL9cL3Fjlm3H3okrfpaZ?=
 =?us-ascii?Q?CcxJ1IBC7TXAYaLiqlylfhyqa2jSWXHVMYBuglGeuPq5pQZ556nNe6tZN3Di?=
 =?us-ascii?Q?htCqup5Ssv3zUKoTHgPHC/BDF/WTZfMkMSLF18bMiN6Ttx4KGBFV8KsM1Qdc?=
 =?us-ascii?Q?ZoXdldXj8/cRumYbUOI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654bbaff-a88c-4b80-b7b8-08de01dcf52c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:56:05.2732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6boIMJ1xnDAxos6N3Vv93w1IYtbqUPh1qHyIikl7fM4bV0VXLfYbH9oaAFZJVHcr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804

On Thu, Oct 02, 2025 at 07:37:45PM +0200, Danilo Krummrich wrote:
> > The driver to operate the function in "vGPU" mode as indicated by the
> > register has to be in nova-core, since there is only one device ID.
> 
> Yes, the PF driver on the host and the PF (from VM perspective) driver in the VM
> have to be that same. But the VF driver on the host can still be a seaparate
> one.

In most cases it is going to be bound to a vfio driver..

However, if you actually want a DRM subsystem device on the VF without
a VM I don't know why you'd use a different driver than the one used
by the VM on the very same VF, with the very same register programming
model..

> > I think it would be good to have Zhi clarify more of this, but from
> > what I understand are at least three activites comingled all together:
> >
> >  1) Boot the PF in "vGPU" mode so it can enable SRIOV
> 
> Ok, this might be where the confusion above comes from. When I talk about
> nova-core in vGPU mode I mean nova-core running in the VM on the (from VM
> perspective) PF.

I would call this nova-core running on a VF (assigned to a VM)

Not sure "vgpu" is a helpful word here, lets try to talk about what
.ko's and struct device_drivers's the various codes should live in..

> But you seem to mean nova-core running on the host PF with vGPU on top? That of
> course has to be in nova-core.

Yes, #1 would be implemented as part of nova-core.ko and it's
pci_driver. As I understand it around firmware loading nova-core has
to tell the FW if it wants to enable "vGPU" mode or not.

If it doesn't then the sriov_configure op should be inhibited and #2
disabled. If it does then sriov_configure should work, #2 is enabled,
and DRM on the PF is disabled.

> >  2) Enable SRIOV and profile VFs to allocate HW resources to them
> 
> I think that's partially in nova-core and partially in vGPU; nova-core providing
> the abstraction of the corresponding firmware / hardware interfaces and vGPU
> controlling the semantics of the resource handling?

> This is what I thought vGPU has a secondary part for where it binds to nova-core
> through the auxiliary bus, i.e. vGPU consisting out of two drivers actually; the
> VFIO parts and a "per VF resource controller".

This is certainly one option, you can put #2 in an aux driver of the
PF in a nova-sriov.ko module that is fully divorced from VFIO. It
might go along with a nova-fwctl.ko module too.

You could also just embed it in nova-core.ko and have it activate when
the PF is booted in "vGPU" mode.

Broadly I would suggest the latter. aux devices make most sense to
cross subsystems. Micro splitting a single driver with aux devices
will make more of a mess than required. Though a good motivating
reason would be if nova-srvio.ko is large.

> >  3) VFIO variant driver to convert the VF into a "VM PF" with whatever
> >     mediation and enhancement needed
> 
> That should be vGPU only land.

I think it is clear this part should be in a vfio-pci-nova.ko

Then you have two more:

4) A PCI driver in a VM that creates a DRM subsystem device

This is nova-core.ko + nova-drm.ko

5) A VF driver that creates a DRM subsystem device without a VM

Zhi says the device can't do this, but lets assume it could, then I
would expect this to be nova-core.ko + nova-drm.ko, same as #4.

Jason

