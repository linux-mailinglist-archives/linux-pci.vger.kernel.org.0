Return-Path: <linux-pci+bounces-8995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7749090F640
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 20:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798841C2242E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE5C1586C2;
	Wed, 19 Jun 2024 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qKf0jMLW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40A15821A;
	Wed, 19 Jun 2024 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822679; cv=fail; b=CaWLN/D5lW4NINImz8GRlhm1bbRdM1UrINI3pgok91CaDrPACJbb1fp0blDVB0gJn1qj2n9bjODViz+wofmOuFtClppGvls/ECuJT3BVugasB1Zdl6V28TCZci2MgFmGwq8LYmar7UwZTIyJjs9yhOW4bMR07BrfpFi3nhomrIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822679; c=relaxed/simple;
	bh=5JMbQAt801HcRKXUVwHu80J82XY++cUVzQhvQrRQcLo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ubkz8pDw+zOpHa4ei9a95VL/Jz1ylLwChpOENsQkHOexhI1rsctaKru3Hvqrs57Sa5Ce7PcT4PxNWK5L6G5VeUe7O8/CmBLJcPykMexqX+Wld8uKSFvfv8UJ+zj2uQloB64zYSnEPo0fkazzm9ebAZqvevwPSOmqveYqebLA1+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qKf0jMLW; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoUd71ZwtNwnN2NUZ1EW1yI6nfinMu0P4KTn7VxCTst+k61q6hJq04ARP56SBgtvg4ob/GZuX4d6ZwHa94q9rNl+ibUGmPR+Oib0ItYmIkCQB/DWR+T3rcHNF+Vy7Iq9K1/UOZu6Ll1HcJu9F3irieqSGsuxcrHoB1dQ81raA489AVrc5BqWsdut+fQm03rtKU+GtqAVI4TiQjFOKdAJ23PRHlfKimrbIIH1Gnese1shcrJC+76FKjB/P2FTNgKoGzXgchbRlgI7PMfShe4VAZpik712OKaQPETcSZfkFSTOwveokUB9pkwMo5V6j3U5GHYD0fd2byIELSZirl2/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lum7Ea4kNOUZ8U2QLz5L4e0Mk2y4og0EFonOrKWjRuI=;
 b=PiMxyWulIgI48PXJPf2mj7Af/daBKHGeTwTujEHoMe0+qqyFkbKfXEVZLrkA8gorg4uqhXctdKadybJG/zcD919p5ENUxB/p5ZLSUdgVtFKSrxTceU+zU2gf9+c6cOrKQq96AVQIJMOXHtNSLKpdj2fUI7SX3fl0EjYlF1Yhp0UW2LmgnBjbb6jxS/5GLvhlaRnJMy/pvlCBN0QMGeRPCL9q9JCX4jUbWYkfZ8ZskyW/ISIW+seS3LdhinK+9la++MsoEBBUK+ZgcSnoirErbRTaRFmPsIJ8gw+2XXfZP6woJa4nJXNo3ioLsBv5LGBGXAYaJXNIIDwnqunEVbCmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lum7Ea4kNOUZ8U2QLz5L4e0Mk2y4og0EFonOrKWjRuI=;
 b=qKf0jMLWwj/tsQbWIjgZUT6+f4H9IR8czgedlA+Qyye1i5jkyOAZ8Q+uobL+ZLBEfY0Dvl87wvmlcBYcLyUN/pkcTgkH8sVOUh9fln+zhqkvpNN5h8oRQDEnoVVYLt4C+YdOO1v6Bbe6W+YEBFVdE7R1G00kXWxbl7501UbTFD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 18:44:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 18:44:34 +0000
Message-ID: <8112dfe4-2fae-417b-ac33-bbf8e38da621@amd.com>
Date: Wed, 19 Jun 2024 13:44:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PCI: Check PCI_PM_CTRL in pci_dev_wait()
To: Markus Elfring <Markus.Elfring@web.de>, linux-pci@vger.kernel.org,
 linux-usb@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Drake <drake@endlessos.org>,
 Gary Li <Gary.Li@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20240613054204.5850-2-mario.limonciello@amd.com>
 <2b8d9f45-97da-4baf-b72b-d91fa63420b3@web.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2b8d9f45-97da-4baf-b72b-d91fa63420b3@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0162.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c8c1c5-f857-4a43-1b78-08dc908fdd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEVWV1JrQ2ZwZjZkSUE0a2p2bzZXQWh4SitUYUNudGtMM3NzS09ZN2tmS3I1?=
 =?utf-8?B?N2hOVXZKMmxvV2wvY0NFSW51cWRwdDFNTXZ0Ui9GUnVYd05NemJ3YWlyTUlN?=
 =?utf-8?B?S3p6ZXRKSEkwUkRqQU5xZWZQYVVpUGl5clBWZml5VjhOK3pNYi9jZ1dLbUxI?=
 =?utf-8?B?eW1MRWJGbWlZRDhzVVFZbzdHbkdHSk5nNHFIV3RyRXowZjRkbU1Ga2oxeFNO?=
 =?utf-8?B?cVc4ZlpKRHNJTFRwNlMwODJjOW9SZHplVm45NThVNWhtM3lHME1TVG55Qyt6?=
 =?utf-8?B?MkQxdHNkOUkra1V4ZWFtdTFUY2drV2MvQnZDSGNZaHBsa1BBVWRRdmZXOGNM?=
 =?utf-8?B?NHRhelRTWURDcytUT0JMdGJGZm5qRXZsbmIxb214cTFFd0pCMnBlZi8vczVT?=
 =?utf-8?B?Z3NENk9lRk1sS3BjcmwwUjNwM0JVSVFUd25FVkdUV2VKd0lBeG9Na09oU1lQ?=
 =?utf-8?B?ZEplQWtGV0xSZC9hV3M1MWp4YlVMZW9uVGhhM0ErUWdUNkcxMTZTa2hUeUlL?=
 =?utf-8?B?R1dsbFI0eE5oeFNZZjMvb3M0bml3RWU3ODBpSGswM3BwVWcyMWdoWFJWOEVK?=
 =?utf-8?B?bndWdGFFV3NOQ3pEb0tDdUFROEVhTW9jNEJVcGRnMWJHRlBKSUt0WEY1R0Rp?=
 =?utf-8?B?M2JpYkM4M2VaK1hiQUJiNzMxQ05sNWhsTEl4UUpLeXo3MTEzYjJ2cVdCNDdr?=
 =?utf-8?B?YWpRZEk3M3lIaXJQdlIzSmloRkZ5OWVPZUVlSjFYUjVTOG9haDVFWlpuU3VG?=
 =?utf-8?B?Nmt3QmZPN3FneUt6U0VFT3E3a0pFcmo2ellFeC9ZN3pWV0ZpcnpwL0o0c004?=
 =?utf-8?B?Z1dlcUlBdUM2UERBNTBTQy9BclZ0RHpHSC9KeFpzdVcrTTQyK3lQd2ZFM0J3?=
 =?utf-8?B?b0l3NmdkRUsxYWJhM0xEbW5DTEZST0pibGlvbEI0THdqNVNDczRQTldPTHFT?=
 =?utf-8?B?MFBPQmprdGFPYWYrdWJlVk9UVWlZRDJGVTF0RkMzZ2Q5OWdMdjkyeXg4NXhN?=
 =?utf-8?B?dExYZ0pGSWliUDBBT05kRzcvdEgxK3hDOVpIVnZiZHNMc0FGS1ZiVDZpWjJL?=
 =?utf-8?B?RDI1MU9GNDQwKzVpUDI0ZlNzMnRpc0FQb1NlekRkRFk2bTlHZkQ5OFdRYXlL?=
 =?utf-8?B?N2lwUUlXTjlTVC9lcHdjRmMrN0lDRWRwMEYyWGp5M3E0UkZGc1ByZG15MFg4?=
 =?utf-8?B?Y3JhbWdlbXF2bWY1MmxlRGVySUhYMGJwTnptTWRpcnViK2VKSTd0RER2bWlZ?=
 =?utf-8?B?dXMwV2Z6blNuaDNaeDdQNGpIbGtaS1NRZG5lcGFod2RQMGs4NUEwSlNoSTYw?=
 =?utf-8?B?bWVZSE9pbnl2dVZzM1kxellHNjhoZ08vNCt4OEVUZFNmMFlzU0oxUVNTVG9q?=
 =?utf-8?B?Z0Q1Y28vSzVvZ2hMT25WYmg2VVpuWHZoRHYrZUlBUUdkRXJBVzlMVTFSUmRh?=
 =?utf-8?B?blF4c3JTR1NWUm5ubVkra1pIREUrb0ZGWmQwaEpUOEFKL3dXY1g4d0o3ZVdR?=
 =?utf-8?B?SWd0VzBmYXAycDVsa3FhY0MyVklwSUNTQ01VTFN6RWNTVEpIck9vTDVNSWRE?=
 =?utf-8?B?a3c0ZXcxR0htUDdpWHBmbWNSQndodDIzK2VWTzZHMVlNT0E3Z0N3YWJaeEt3?=
 =?utf-8?B?LzBsOU0yS2NHYms2WjR1ZllWTDNpMm9DWUphdTFRT3NIVmRvc1U5QUJEY3dK?=
 =?utf-8?B?b2pRcm1SSUtMTnFaS002bzhoS2g2NGpYQW0yb3BhN3hzaTdiSFp3MmFwU2JZ?=
 =?utf-8?Q?0nsklgAg4ZwwLCjYlA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0V4KytXNlMzWlFrTjNSTmhveWdueEFqNk9nTCtYTGxWOU5NL3Z6TnI2aDJJ?=
 =?utf-8?B?SGx3VVBxb0owRVVXd3JsVzlEUkJhcGxsMzBzT1VHU0NIYXpQV1hlN1pDUGZB?=
 =?utf-8?B?MTYwODlCNUd0VkUyZ0doRC9tYnUvMUl2cXpSdmxxbTRNQjFYYWhhMXB2eERE?=
 =?utf-8?B?ckFhdjc0U1MyNkRyQlU3MDF3Z3VKU0c3ek1TeHFEdmJ1SGdvVWU5WjVHSUVW?=
 =?utf-8?B?SzJVSmZBSk9CR0tZQ0F2bGtTbnRxdGJKVnBBZlFDODliQkd5RVJiR2FxUUht?=
 =?utf-8?B?MFl6aThXVHpZODVKMVJvVkJaazdLVHZya3d0Mm9RSUpQczNyd0oyQ2JCSHdC?=
 =?utf-8?B?RFM1dDFaZjhwL0RFb1FtdHpTbmR4WjRtdUUva1AzVzJLejJJL01YU1pHZnJt?=
 =?utf-8?B?RnNuaFZDenNBcVF4WmZ1QjNLR0ZOcVVsSTlCcDBpd2NpTFFPeGFaNS9TazlJ?=
 =?utf-8?B?UFRJaE9VMGZHL051NVhhN1J4bHAyeFhqdlhwQitJeE9tOHZ4UzBva3cxeWEy?=
 =?utf-8?B?OFRrZHhQa3R4aWJycG14N0R5YUdGK3RnRzVMYnZDWjRNMytqa0s3TGVWZ2tK?=
 =?utf-8?B?YlhPWUJXV2NBYk5IN2RMNEVhdlAydjFmekRaTTdzbjRSdjlqNUxlUG8rdWVO?=
 =?utf-8?B?N0RhRngwdkdhSm1pQ0J4NzRRb0xqOFNvdGxSZHFLU05PZ1lZT1ZpRmxtZHAz?=
 =?utf-8?B?eXc0R1JDVWdMa0pNZlM0d0FFZ0Uvc3Z5d2NheXlEL2orN1B2cXZiTG5ZMG8x?=
 =?utf-8?B?bmx0aUZ1UmZFb1JBU0lZZDUrSmNQUGI1TWlxRTN3N3JtZmk2ZFlCNVhERFVN?=
 =?utf-8?B?QzFpNVR2a08zNFJrRGYyNjJ4cE0wWEVEeUJmd0cwWExkKzBGQW5WR1RGUjJ4?=
 =?utf-8?B?MXdNYjBxQkxIbDVVeFNoNEx5b04zOXdrajIrMEZnVkF5RnBVWVNGZEs4czVm?=
 =?utf-8?B?Rzd4UjA4OHdzSEl2NzM2cTBuOE8ySnhBalc3Rk00MTlPVUVOZEJYNFUzMDds?=
 =?utf-8?B?NDIwL2E4RVlzckpQWjBUYWJjN0tSOTRzWnZMUE1uc1VaeGdZb2M5eTJpbWht?=
 =?utf-8?B?MHFDQnJYbWNNTHJEazMzbjdBY3ZmakZydis4MVJiZThnZ1g3Sk9oMkUxa3VE?=
 =?utf-8?B?Qm1ydjVoUXI2d2hXVGhGalhOWk1YL0NLMWxxRHRvV1lTekFFMXZ6Z3dySUdm?=
 =?utf-8?B?Qkdwb0VxdjYzc1ZCc1hCeTNUQnp6TWNjQk8ycFliT0hoT1lDYm5vSllRNHRF?=
 =?utf-8?B?QkJ4aEx4eDNOZW5ZdG1kYkNkZXhjblltTTR3QzI4NGxJcjRwTEZ4cmNTQUEr?=
 =?utf-8?B?L1RHT3FoSU9pUmRmZWFTVk1FeGF2dUFxWnE3akhiYVc5Q21NeTA1MTFSNGE5?=
 =?utf-8?B?WThNSVhkcDlUcitLNlRQbE9PcW43a2JrY0wyMXkrMk1HNm94ZnM1OFk5Z2Zh?=
 =?utf-8?B?N1ZQczNEb3ZXMDV1NkRiRU9qTDJwb1ptcjZPd3l5Y29xcHlqL3FScTJUYWYv?=
 =?utf-8?B?ZmhONURTc0pYZ3Q4M0ZPaUtzc3pmSmFnUWZlemhHcGI4ZHA3MzdENWZsSVgw?=
 =?utf-8?B?NUN2V1hZOUVESEtjY2E3ZkRCWU1pRWFBMHV2dE8yOWVVajM4YlhCcmdLVks5?=
 =?utf-8?B?VDY2WGp4eGFIQVpyakdNYWh0ekg3aDUwYXN4MW5EZ1EzNTFFS2pZOXJNR05D?=
 =?utf-8?B?SlUvOUFDUkl2UXdwTmgzK2YwS1VnL2F1UW93Z3o2c2U3Rkd5aExjZVpTaWZG?=
 =?utf-8?B?dEdSUGIxMk1vNlA3bFFUVlMwaGlqT2dINWhybUlWaGhXWnRKOUZVMGIwRmVM?=
 =?utf-8?B?Y2JaUXdxOXdxdE1WUzZWV1puZDhVOGFzblpnTWcxczdUNCtNbjFpL0VUY2xF?=
 =?utf-8?B?LzBqOFB4NDB3eitKS3hxbmRhUFhKLzl1MDJlRi9ValpzSFRMR3lNblNlSmVM?=
 =?utf-8?B?VmRoRUZ1Y0NxUUQzRmtxMzhTOWp0ZkdJZ3U3OFJOUFpxaFdzLy9odnZtQXdO?=
 =?utf-8?B?NWhGMmUrb3Z3dElPZHFuOExRTzdhMisvYjlQaFoyQzNTdzdnY1hodEdhTEdh?=
 =?utf-8?B?R2pJSWtvTGpxQ2ZtWU9zQkRDdm9BaE01ME9XQmgrUVFROWFxVmROejlDR1dq?=
 =?utf-8?Q?G0uU1w7B/qxU/xLBSFiq7gKur?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c8c1c5-f857-4a43-1b78-08dc908fdd35
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 18:44:34.7213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zz18fQCi9dN5N1eVpxkyviJlioKC1vuqqaOGEiKOAaNYmxtOy2J5wFVKXwVIX7bS8GZZWJRcWqd9PLK7hcHlmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048

On 6/19/2024 13:33, Markus Elfring wrote:
>> A device that has gone through a reset may return a value in PCI_COMMAND
>> but that doesn't mean it's finished transitioning to D0.  On devices that
>> support power management explicitly check PCI_PM_CTRL to ensure the
>> transition happened.  Devicees that don't support power management will
> 
>                          Devices?

Yes, thanks.  I'll fix that up for the next version once we have some 
alignment on the functionality outlined in these patches.

> 
> 
>> continue to use PCI_COMMAND.
> 
> Would the tag “Fixes” be relevant for such a change description?
> 
> Regards,
> Markus

I did trace back the history of the wait function and it goes back to 
4.6.  In my mind yes; it is a fix, but I don't think it should go that 
far back automatically.  I think we should prioritize getting it fixed 
for 6.11 or 6.12 and then can revisit how far back to do a stable backport.

For example AMD Rembrandt (where this race condition was found) isn't 
enabled until 5.17 or 5.18 IIRC.

The backports would have a dependency on 08e3ed12ca861 (from 6.5-rc1) 
and bae26849372b8 (from 5.5-rc1) and 821cdad5c46ca (from 4.14) and 
5adecf817dd63 (from 4.6-rc1).

