Return-Path: <linux-pci+bounces-28973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF431ACDE29
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18B33A63B2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F2613AD1C;
	Wed,  4 Jun 2025 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="geVj54ff"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5328EA41
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040674; cv=fail; b=rCrj3u7RMIGb5rzXBL5ZmZgng6RJe0kcwmp9CWj9TrqaKZ471fWw1Wm2FpvA9Gcenykxs2kLhQwhj9xSIHzUbXDqptVnrtWLARxDt+pnqs4I+IQhCW6APxrjAwpGVkMGV6Qq21rsVsCZ3TIGSI5Bgvhb6bcmRupKogu6c1i4Co4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040674; c=relaxed/simple;
	bh=MaIC6+Mr1v5R5uO1P09CV+pHEzpuFaolXgLXEauBRI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eHgOo12Jf4ZM8PDObR3ARtjeXka8l740hqAvzhj1BqDcjzXW2EWmJ2ppYkOem+PJOwz0XvFDnLugGy5tTF4FoP8ucWiaLmrkmeKSuIwsHBFqswoPAjYrupd7VjGBddi6xSMpkb6zQAjF0iEPi2rMsMUVnKT+np7U5hwZzWc/L94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=geVj54ff; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yctOp7wZf1sy/fSjgAwVtR4nen2gTn927kX7hiG3SwDjAbpVg6rwF8Hwx/MPBEcUbQlwmvkXivhVz/nSt8dtNFComW+gyIJYno4WGcwUtKpDYonE/0ECMPeTghHLPLSwAxAp7E9QycryIitGDMg/pD/TC3I2FP7HryR6sODeuf1Cu2icUpmnK/JSAp465/0ED/EECHJ74cbMDHi8kleegK+wdFsqvV+4hYbKleYef8lGu0CnWME8+wO4G+8JGtYu97nUV4mxy5KzAJ6PrcceahXOqitNx1ORZLMph5xnZaBVb0g8Y7No3RHsN3OXnz8LxjNtSt72qr+UzpVYl/zLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaIC6+Mr1v5R5uO1P09CV+pHEzpuFaolXgLXEauBRI8=;
 b=iULErlrfF2zX402lMMAmoMfrCMrnXhr6ycvu+d7cKwnFq1GLRdB7jmdQs9aHl5hBnr4tzFb0g0bFQ+Oe13Fa9BTKqbKs/sbf8nrTIT7UTr9VDe+Apysa0kkV7YZhPsM4VCGZOUBi8gfAVuvtgC/6tHnV1eP7rNGlymdslSAQu7b2yQm5n2lKzgbp1nnra7B5jK6bA3Wo/9IX3NvCGmaglGabFpoi2WFn2i/VEUmKf2XlMyHQdwtWpnyCwVJb7SnsBOmFctWG1aCotWWAyKv4qQMk4NOEEMTLk0v1O9iSpZ6RLWqqli4BRE+vIbRv2Yw9fKMGRg/jPBJCgK5EsmkvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaIC6+Mr1v5R5uO1P09CV+pHEzpuFaolXgLXEauBRI8=;
 b=geVj54ffB4iW2ckOMcMHBe+xU2K4LK7CGCqtPcp1s0NxOubjRp/AitikgKdaycJ6YOYZocNgV7fiquavZo6Dmd9G72PlHyMhraUgm+hAB0fyd/MKbQVzNhQ4q5GHulH6dKGJ7UNXbTwScze4Lpd/GwJJV4cyZMeXtKccvk9PROgPql77f91/61EFz3kvlY1TR0tNimi9V7zNvcFJdjd+I+FMScczKfGcp4txIVo1fZAMhtXQuEoP2SNAhIPxA7h2GZEknttp2R0dlAICYf509vEgow82YPenuEShkdvkrDiJJY2jyB7xG6x6HQANvqffoHcSCUrQp4bWf26gysOtwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 12:37:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 12:37:49 +0000
Date: Wed, 4 Jun 2025 09:37:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250604123747.GG5028@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <668b023e-d299-42e1-87fc-ec83c514374e@amd.com>
 <aD3clPC8QfL1/XYF@yilunxu-OptiPlex-7050>
 <c552a298-0dde-409d-9c2d-149b2e2389bf@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c552a298-0dde-409d-9c2d-149b2e2389bf@amd.com>
X-ClientProxiedBy: YT4PR01CA0321.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff13705-545e-4b76-e9db-08dda3649d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wrGiGIPXReb3tCR2/0iLjlTKzbIV+eaS3cj4lLMHR0KhHTHwF9+dWwUgZir3?=
 =?us-ascii?Q?LE7wjrY6HI+pp9fGxsdTz+pEBlDCLehsoYgL7ifEzEh6AoyhrGBbAY4FqaGK?=
 =?us-ascii?Q?GRAjCgUe2X/YJCyweEv9SLmOFoN4rIPoFNy/7MfY20OnG0ndZO67V75CYxxL?=
 =?us-ascii?Q?LHG1KwHOLVpIgOs2Omp6UXHa2GrCla9univRAaG7cUOC5d353oKlCrl8NGGV?=
 =?us-ascii?Q?MsixVxRdg3aPq24rOpglRw2Is4HaqZwT+eqKw70WjWBnrYCW4PyeuvCePiRt?=
 =?us-ascii?Q?Ma4j9IOTL1GmWRX8p+CyCSBN+TGlykE7l0zt8zQQEAkJ8L7NjcWikH2yXt1o?=
 =?us-ascii?Q?BvwnM9TMEUkx7hkZdwx4OfCj/EZktIF+IZUbmg7iHQhpVDBY4N6DWvtAGmS5?=
 =?us-ascii?Q?j6L0Ebe7+x/N0a7TWtLYdIMODduJU2rz0uJfdW9SZ0aWMmRsLeaewjX1Z6i9?=
 =?us-ascii?Q?V+lckZRbvun91LCuMtnQCa2DUAssTROv13Li6O8EM2akB5X8soY1478suwAQ?=
 =?us-ascii?Q?7wa/ur8An80wwcrr1WWP0g9lc5P7uBzipYuMsspZYkCHxUvCKK/Lw3Gwig0Z?=
 =?us-ascii?Q?uCwAyjeJiO9Th4oIWFNdVRxHLm4CpskqqafCEbYO6bJmlC/LEvPVQRVY0Pbi?=
 =?us-ascii?Q?zYIluxKbluh2irGdOI96StheDdBzolN017z9/Urs0Opp/dSseUygimsfcbVo?=
 =?us-ascii?Q?gzfim2sRcvI5vevM1oIClAVVvomtDbX/q/9EDnVVS9Df6la2/q5pefZpJ2v7?=
 =?us-ascii?Q?R7JrFRrBrgSXmKcFvq3KWyPybp4fRenqd27PdznG+bfFZw3O7iCCo0Y8U4qk?=
 =?us-ascii?Q?EmqlQnwh08RhJDw6cQHBajG4Ae9bNukxWPpvu8ppKUZdYax5Ntcb5ZyXPKqu?=
 =?us-ascii?Q?SCqJcZURWiwotQIk57xNUXdTKSWIsKtYPsTJWiA4FWTYPf7zANJgTAQuzVz+?=
 =?us-ascii?Q?PO20SgEpD1mxPZ/Xn+PQGQQjsYKFMXQwFJN0I1V4BD5Lg3GP+8uYmikGeiot?=
 =?us-ascii?Q?TcDT3vBS61sna0JiMfKrz6Tt0cPJdZ7rC2YEDG3J0cH8q4xeK7e6hi5nGJzF?=
 =?us-ascii?Q?psk+PrVg1bEQ4F93wxFmeoAFM6Qt0YZvUxkZ5XjfF7TI+xSQFq9HbpA6OqUG?=
 =?us-ascii?Q?XJOTV60K13gjkSOClU1ulc20qM1y1XTMyUAsGDR6is5SC2GWjJjx73XEtQ9e?=
 =?us-ascii?Q?KtwOEYEmoQUJoti8v4OF/uswqLqMWAxm9DOxqyE0aGY1zsYpwPDUVIInqVeT?=
 =?us-ascii?Q?ojSGUBbRqLl0MQ9VUq449+dMRSewlPGGf/ksLOF4L8mpQuoX2C83NC4AJL8A?=
 =?us-ascii?Q?RR26pBmvrURq7Ru8qIkbOjZiiKH4fWrXji+kQMMp8Sl0TfVECEJ/CwPKeJ0W?=
 =?us-ascii?Q?8QSYtdVePW20TzLMHw9hfkvhOS9DvrqE2TzEzrCydiqWQ5bsDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4i8ZEwC/8xP/cEM5lqfK7unTFBA+gvZNsnpHmWiNZDgAGg/DaG9sNcNyW6ee?=
 =?us-ascii?Q?S4u3CXmLYeDNLsBLHk4Gb/qn5KEDDU32NlfdxvLAaZ5nQAu7XTcuC7qlUe+d?=
 =?us-ascii?Q?lRr9chGDNG8/GpIB6mX0X2JF5snOR04Q3xADluYcwJPCPjgGBmVv5ESWwqlp?=
 =?us-ascii?Q?qIulMy0++tCdQ0VDGxmeaFyW9pKQYXuN2ArSMQ37Z+sM7mZURDwcfkYtxTYd?=
 =?us-ascii?Q?6Fl1vEyur4zIyk+HuxHyoKlHVzHli3OZQObh6hPZPA1c4LKftumz6/11ISob?=
 =?us-ascii?Q?VWMx7pprWHKRqJvoXYJ+mpMdrWWRRWfhakuoQFrVmuiE719gn0nutD8QdDtP?=
 =?us-ascii?Q?g57Z/u2WXUSHdhf5sB8p5ish5KHwPrFroar3JVRCBDe1Ixj4FNQ/0HJHut0O?=
 =?us-ascii?Q?gcwTu7lzLLMucXC01rDmpTAN7Rc4DtF78y8z3ysrs0x3vPuOap+8ppoBFVS3?=
 =?us-ascii?Q?xVP9MnjZNSp0bgbB/hRchZexMEyORYJvQg3YRYBzkxbkPr+aMXWzIOqhym5K?=
 =?us-ascii?Q?2JBlal8mZG/LUDI2EXZ7zzlpJPy5o1fYVhw75NQlvyFDCHuWK52AmhAz7A2e?=
 =?us-ascii?Q?+Fdg9ve1yc0h4HDuHFQ1JgyVzANmkYnCpHTm52ly9AfKeOuVuFQ1KYmK9XaG?=
 =?us-ascii?Q?63JZIe5phW9TPfO7f3G3kaAGtTF+1hvbEUymPAZc2TNytqfTM49dwrF/rIiL?=
 =?us-ascii?Q?wxR0fzwhpv8U0yg8E4zEl+GlY8O6WzBg94+sQe05Vim/0EvHhMzRoz9RLyN4?=
 =?us-ascii?Q?haMEFoZzMYHoZMHfhvOzdAFMgsQOpp6VeXJS265Q8PKkjrJGCo1ZqEc1YhZT?=
 =?us-ascii?Q?lIiavtygLifzTuHjWT9vXjzL1I81ijBXBmx6ktdJSl8diIRm39l1TaN0m9ZX?=
 =?us-ascii?Q?nw6oSIbWeFtTqq37l5aghAPUK6V8f35FzIfvG6VDqcHlhYhU6SdS2jAtQThQ?=
 =?us-ascii?Q?lnZqMwbmmzW/jJbzEl1//68TRutRJET2iR7OlT42I+jiZlnBIjUWqH2H14ve?=
 =?us-ascii?Q?MHF0AKEJ6+w2aXM8ynFnxihnJjbzz+XKpa1W8xYwKIuvOQy5gKz1obmEiBGc?=
 =?us-ascii?Q?HD/Y7NqK11NF3B8U/EyS/46nOzXR8Xigm0FCoRZ77OLSkHhnqrdezN332AaJ?=
 =?us-ascii?Q?Dp0A0/YqP415K7HdRK6mQtfeb07oQsC/d34IDM1wx/i3c5Q7F31Q3K0siUvD?=
 =?us-ascii?Q?2avnD6txC5upEvaXFTVTaI3WcYq/CvLuiaIPKZK3bh6RFPyyZtTnRHE3V6l1?=
 =?us-ascii?Q?flI1OXENszpLSGyEEof4IPSorujdDvV4iT9IW/Cl+RLxi4WLjOfJmqQimuIv?=
 =?us-ascii?Q?cyECQWDsWLks/uO5q1I2eZq65crAoWbVi3yA4F/QDwkFcrOMj6yaxE2yxXUy?=
 =?us-ascii?Q?DJDdJ7GcHT0DUF8vtENnK2P1IB7JvXgh/6f5QagGOb6Rv84negb/f1NoNPq2?=
 =?us-ascii?Q?8F47A15/xsRATCN5rFEJOba0OjZbQxQE0TPYak5wXytL7UJYnGhvCsMQAASh?=
 =?us-ascii?Q?zkvA4vA5iH/Ash07lZkC4I1+zHiBPBWjfS2oazY/rV3CC16YYnrhrti1rjbI?=
 =?us-ascii?Q?zWfj75PBwsRsyoeSfj24IIJxxSF5wpeI4nlfMPox?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff13705-545e-4b76-e9db-08dda3649d57
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:37:49.0124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8GFKCBJcI5Glf7j96v8vVkcO4PHkfWMplQCPMwzCKmSadkHtlXDeAqRPvwHzEQP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073

On Wed, Jun 04, 2025 at 11:47:14AM +1000, Alexey Kardashevskiy wrote:

> If it is the case of killing QEMU - then there is no usespace and
> then it is a matter of what fd is closed first - VFIO-PCI or
> IOMMUFD, we could teach IOMMUFD to hold an VFIO-PCI fd to guarantee
> the order. Thanks,

It is the other way around VFIO holds the iommufd and it always
destroys first.

We are missing a bit where the vfio destruction of the idevice does
not clean up the vdevice too.

Jason

