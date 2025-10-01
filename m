Return-Path: <linux-pci+bounces-37312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64053BAEE01
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 02:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1C53C6504
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 00:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7635E19994F;
	Wed,  1 Oct 2025 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kkFs9Fwe"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7042F2D;
	Wed,  1 Oct 2025 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759278594; cv=fail; b=TdV9judh+QTfjziQNJE6LLDwqk3+EWoZX9KTTymwXSpw+SjVlQwKJiiBptF+Tp79FbIZJ679afhabDTCf30sjm8qrwaVzFnVPGFRLZiTMe0FbNm8IHgtcOpMjxrBBn3qfIBH1J2KCXjH5cFLF8T5GNJnn2w+t97IFGxmusDGQQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759278594; c=relaxed/simple;
	bh=4bbEVInkmCY5/C4AQcv8hIi68WXs1JauPaFr2q1PvvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ptTRKYoCdQv2qGAJ85EIddJwTUuGEAp7bpMzrBYmv20dzgOXAr5Wyn/RsIkbnQUpHklT5PircIXXjPgPcTln7eSepvHVQym6Z8sYZhXGwS1gdRmQGuqq8c9I6/2eCaKmQ4TEB8/taS8QkbRj3lCud43jvPTe89wlo4cCdWtRbLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kkFs9Fwe; arc=fail smtp.client-ip=40.107.208.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgWl+uSbpc673tq74NaOkSTc3QIQxofFv80W+tI4G0FgtYwcqjbt0kX/gk/KU+Ld4q2TyGgVnhpgP9GhTZQC3h4TQr1KHKKgAoH1rra7YrmOAHhrg4aouCEr/VTWRaJIdv2yQfZ41XbmCxWIhSVkVN/p8cstNnlfySbICjrVHK7GzZzQACYXO4z9HO/Misw3bStIDxmd3gKbVAdL5cNWbtwjBH72kix6Zk2NuINJEJ9FIKvFDtC6bI0sICkauQ5B1GJuTT71fAvxYlc1tM5lv+uKU4V2hCWrZsgAFUGGJSOnQ+5/DdNV4FDeC1gC7zhTXR0vZabmgXqdCJhxlSwAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGCjkPuUo1bfDxP9s609nIaHuPdwacBmwtJRBcFDQwU=;
 b=QRWkwSoLvXGwu/U3Bph0cmKaIJs1N9IYhADwhHRm3diaiYVTK7kznClJxTvWj/NATLx8I+thNnRmfM8GlxpnqX+hCJ4YibjF25yFW/T+i/bSJC8yKIo2+APgwYTOabe3qNkkBA/24n2RyFAw3CvWIFCveJ0K/s1ItWLB/0wOfAmde8L/qUKNaH9gfhZK+RNh6fTHzmQo0ab/pmoLYELFXRoDSi764CiLHorMobcRFnRzn7zFZIGPtC9e4uoHgcdWQ5/Qfq2bSe7DAeBp6YbFs+bni/VfLsqVecmxv2dxvG/veh3oZSMqQVaFknnLqbsLtQh/NHgVhUyzorCPNvAFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGCjkPuUo1bfDxP9s609nIaHuPdwacBmwtJRBcFDQwU=;
 b=kkFs9Fwe6lhyGaCpVzK3zkCFlul/J+E0YoD6gtcOD5OgwxHkfmBI6D1Pj6OSpswE5udFUVuIvGcOBSk8Tj0gV2jChGfVMmcvUjBEQ7jh10F/aOMOYrcNJMJ49mrSUPUoGIoDZoRpzBmzvx4CpIUurkkBl+dCmz0A/4V0wydu/2fuK1IlKCAvYAM6EVRY6GGLe+HYXB6svPqHzYDJw1bOTsat52MPWNdDlSDmU4jJ25aFAaLQSaPF7nttZpkpw43ojTaEHGa3TwMWk4srZYqL2F8ntCqy58/gy3yNnikC/eYqN7kbyeU+uwm22Pl9mIJb9PQl2bP2VWt5978zLE4BUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 1 Oct
 2025 00:29:49 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 00:29:49 +0000
Date: Wed, 1 Oct 2025 10:29:45 +1000
From: Alistair Popple <apopple@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Message-ID: <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930220759.288528-1-jhubbard@nvidia.com>
X-ClientProxiedBy: SY6PR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b2b7f3-0fe0-4d1d-f5fb-08de0081a167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dCA2fXYnODmQmpqIhfrJ0/iTFscXoL73fa+z2W4YaeJrAA0ObpTaKua6ehhh?=
 =?us-ascii?Q?blwuYkXFRd4Nl3TNcr7QotGhT/X0nCYUqcKj5Flq7f81tP6pkCVzGEkrHrpS?=
 =?us-ascii?Q?HI8nv1Jz/z/VMzt4xVgufU9eZg7n7pGclQJ407q+J7K703q7hqj7fV632a4n?=
 =?us-ascii?Q?O+UE/2/oWp06eNiNCk9EyUAjtkwZBP+VV2Ti1PsVDxMnxUSwM5aS2s5TWZcb?=
 =?us-ascii?Q?nhgCDgxCVl/ti0C04JZT7P07uTrh6acw44tgt2N2W0rWdl1jvXrzzgInqHpY?=
 =?us-ascii?Q?HRTpWhDue0E9lnWMJh8RfTjfc4bMPzz9X6RgM4zdw9652UuBpOrFgvTureZJ?=
 =?us-ascii?Q?FxhyGwBVafNvlZDhfofN2liwCSAosfmIIKB9/ZfncjcyRbnNG12/Yz6d6ZMS?=
 =?us-ascii?Q?AJjBlycPL8EOQzAkGPW+AYcYrZnS/YATtNC9kvYST+a6oB17fDzYFxxBhwfe?=
 =?us-ascii?Q?SEZJxjqspneMWMypWdalIoOVKwCZ/NnvlW1RxyM74z+b56q9b+1V4docMOin?=
 =?us-ascii?Q?+j/jUHOLVWdZKy8HCCuPmWIsKG/sbTqn2fxHGLTUBcPatUWoxsriMD770gNd?=
 =?us-ascii?Q?LgJSe9B/0O3+3eIuUc14Me6icDBZeuY5l66nmsJAAB11rRzb9luENtwbXNNB?=
 =?us-ascii?Q?OEA+zmDfoWxDk0CzcmXpid4waNsHLSYzkDDH0l1kGinxIc1bXg495BqkeGeK?=
 =?us-ascii?Q?7J1Uj/prcfb7vztHcOZH0p9jrkWBRIC0uWAO08iUk2cjhxMBSFeR0bg4n0MV?=
 =?us-ascii?Q?GrbvGWpnhnH6JqxMT6E8CttIlkNmfvdn64O+aG48ua/s8NmNaExhMnNforcf?=
 =?us-ascii?Q?R6dKE6PqpmN2UMfZjiHW5lp6+EaJFaGc3YhD26Qtd1QKO+Tqw7Ae9VajOJrf?=
 =?us-ascii?Q?2nYXcJfBUrYZGYiipJXyB53xUaASYkZbT0LymkSgzFvRbXSwManLXkEYwQH7?=
 =?us-ascii?Q?k/5EA2IEFJEE5mL/pTjIgDqKwWXIu/dWNUPmU9ZPD+0+jiwvuE/w0DTLgxnc?=
 =?us-ascii?Q?+eqpgud7YNAWZfv7kcCUEUr8fCXilFN92OzidTf/rTQVrqKTe5a/tHm7ypMQ?=
 =?us-ascii?Q?eR3LprkkC9LHZweJ59pwnL3XkeNRHPiKbeZJBXPBfyW+6lR2GANvXRgvoxIe?=
 =?us-ascii?Q?c0qakLR8+CdnUjSWAgs7N2rYmFvSgG/s6T+Lb1dsxfjK4KzLRvzINlVGfrDw?=
 =?us-ascii?Q?yQ1VnSlqapYgonowO4/dgP/0ObJjBvaYlR/SfuaCBAY+0HQloLPDXkWRil89?=
 =?us-ascii?Q?sspzTI+aNWhBFiGktIj7euEEsA5c29tWL8+SfRpYPkXZuuy/4KfthnPbYHKw?=
 =?us-ascii?Q?ykXwqmN9T+UpCVjJX7bNeMMiE8P9p6NGdd4H3my9tl2+sZHQuWUufxzOSCV8?=
 =?us-ascii?Q?aS1szLmNRD2Q0DetS7c488KDbIPDQaDk5Ne/49B4/qco3fKl5AC2EzfXk8nN?=
 =?us-ascii?Q?M7EMoXEXVBEGWxYiDwdpWORAqPYEAAtRzn4TBpajyuhKBpRz0GRAXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HmkaPxAA+s/jp0OZIoyNFlUrn11lDjAN1JMCk3XzRdAE37WVI00fQOyDS7P5?=
 =?us-ascii?Q?vmqtrgeea0lxnPzzgY6Eo/HYY9spEEAoakC9zTfDjAXCVzh4PxTi6XrPzyk/?=
 =?us-ascii?Q?lfWOH0rJz7fEBdrntv5KtfxSHSI7cIRwars8Ck3rkmWCBEfqODmvCIZTeqfV?=
 =?us-ascii?Q?SVHC1hg/vr2K9eLocGFSTZfEzaEIYf9FYHK4Pr/YguGQCMTI+NyWAcMm5ewj?=
 =?us-ascii?Q?djqEqP5tWpEj4FVy7VCbtSFg+taTnD/Pp/SKVf5Gl2Qmh605eK/EjuY53Ort?=
 =?us-ascii?Q?+wfboKrgSCd4d75a0ZkzhS366QtZ8MKn8FBUyeV+cc6Wsve0ppBtJNfwyEHk?=
 =?us-ascii?Q?W25KWsyV81DnJhLDKocbb44Nd/467BLq7OS5TZlxSMCmed7VXAQYvMyZe2Kb?=
 =?us-ascii?Q?ncxsEdQ+rE5aAjWfXLfeQY7w7hMFo/olBpcHIxkHAvFD5nmM2ClJquYpw/qQ?=
 =?us-ascii?Q?SWKhbIky7UEmsMloWrZkFRFVuwT6blmUq/jpsw3Cvw4gWeYg438JGOuPbqBk?=
 =?us-ascii?Q?TPt1j5n74/cOEBuJY8uDAjnTnf0kP1xG3CUAwJZb3T6QrQgEL9m/+DTWPsEq?=
 =?us-ascii?Q?6aRcV4favBbeLnpF4GjBUQzG9ThwQ5XXLbmxNYoqCQUbWjwuTY3NV6byc94/?=
 =?us-ascii?Q?ftNNATJY7GDd4uj+/+C2JFnU/02lOYwX3TSKdg4vQ8hL5tVE2yzyE+71eAVF?=
 =?us-ascii?Q?UuNyXDBD/36yOVAprgvOOWdTBoQxV+9JIMM/vhaNbeQHnqQapwkwyg3+gPox?=
 =?us-ascii?Q?qp8R91OdxVyJyuSnX0rGNV64lcg3pfr8M4NPSuTva2vsMOa6/LKvsPgtSEkk?=
 =?us-ascii?Q?qhDclaOXric9/ihWH+5VnO2lLjt48E5yEmOOjSsZ47hLDEnTr+4OlmdXbqYh?=
 =?us-ascii?Q?4rmX/8i49lfdaRSrsKs/7t7hbwwCWuKWNfPQzWUXKB1/ZRMx/YXlh8XbLNKH?=
 =?us-ascii?Q?eS/j9hyF9jSZfdCh4aFEW7Hq3bDFzagMz+oRHOQZaDjReKB4NzakC55Ca6Sk?=
 =?us-ascii?Q?RmncUES2MkGQISv7jp4tMZOVc9UQ5ERhWo7yhEetlgm8YeLquSd4QT796+t+?=
 =?us-ascii?Q?mLDp/N/nVegtMQ3VnkSmVUU2bR19rj+MwOc/sz6VkM4UcfhFd474dYe0uG+M?=
 =?us-ascii?Q?eBjk4Nndru++7F7Jk5XxPOSb9mksTIbkpHjmcL2Tw5rSds5tiS+sqoe5Xx2B?=
 =?us-ascii?Q?Y8+VYe0EMMIBr/i2DRB7GIErKMiZDio6+AVOs81tOHdkak7+nYdoihgjX+uv?=
 =?us-ascii?Q?lYtpXouzMNi0z3FvD74X1p+P7vQ+mapi5udJScV6f848kuojEXn/p9rNbFRO?=
 =?us-ascii?Q?RdePlu1JJvSLypaOPOQccpO8uJYG72EXCcVOkdbjpttBOREZe2XRdMDeYome?=
 =?us-ascii?Q?h1Ydex/sO2L56h9obLSA5wBsQVlBPGyXCniV11E32Z+DuyILnnwNXpVdAjjM?=
 =?us-ascii?Q?OIYY6Zc7/sjCa4iv5S1KzLZnEOFMxdFY+ycx4UClImvT0phdQLaOxMnax/8F?=
 =?us-ascii?Q?JusYh68qiDX6UYSw/4ZxWCwWjYcKCUA4nwc5vJ+BOWYVjVlGob0wGLzTKShp?=
 =?us-ascii?Q?9ariM0O12smWV8+XQm3qH6Zbe93mm68GZmileasT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b2b7f3-0fe0-4d1d-f5fb-08de0081a167
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 00:29:49.4003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0Jlv0qSHKyJ1cSyKycWlsU0rJXc00NqlGJVLn6ErImqJVR5K6nX+t/51CEBNFKl8fhC5csYkcEchFJmpYj5cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B

On 2025-10-01 at 08:07 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
> Post-Kangrejos, the approach for NovaCore + VFIO has changed a bit: the
> idea now is that VFIO drivers, for NVIDIA GPUs that are supported by
> NovaCore, should bind directly to the GPU's VFs. (An earlier idea was to
> let NovaCore bind to the VFs, and then have NovaCore call into the upper
> (VFIO) module via Aux Bus, but this turns out to be awkward and is no
> longer in favor.) So, in order to support that:
> 
> Nova-core must only bind to Physical Functions (PFs) and regular PCI
> devices, not to Virtual Functions (VFs) created through SR-IOV.
> 
> Add a method to check if a PCI device is a Virtual Function (VF). This
> allows Rust drivers to determine whether a device is a VF created
> through SR-IOV. This is required in order to implement VFIO, because
> drivers such as NovaCore must only bind to Physical Functions (PFs) or
> regular PCI devices. The VFs must be left unclaimed, so that a VFIO
> kernel module can claim them.

Curiously based on a quick glance I didn't see any other drivers doing this
which makes me wonder why we're different here. But it seems likely their
virtual functions are supported by the same driver rather than requiring a
different VF specific driver (or I glanced too quickly!).

I'm guessing the proposal is to fail the probe() function in nova-core for
the VFs - I'm not sure but does the driver core continue to try probing other
drivers if one fails probe()? It seems like this would be something best
filtered on in the device id table, although I understand that's not possible
today.

> Use is_virtfn() in NovaCore, in preparation for it to be used in a VFIO
> scenario.
> 
> I've based this on top of today's driver-core-next [1], because the
> first patch belongs there, and the second patch applies cleanly to either
> driver-core-next or drm-rust-next. So this seems like the easiest to
> work with.
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/
> 
> John Hubbard (2):
>   rust: pci: add is_virtfn(), to check for VFs
>   gpu: nova-core: reject binding to SR-IOV Virtual Functions
> 
>  drivers/gpu/nova-core/driver.rs | 5 +++++
>  rust/kernel/pci.rs              | 6 ++++++
>  2 files changed, 11 insertions(+)
> 
> 
> base-commit: 6d97171ac6585de698df019b0bfea3f123fd8385
> -- 
> 2.51.0
> 

