Return-Path: <linux-pci+bounces-41060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7DDC55D77
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 06:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E465C4E21AF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 05:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9062512E6;
	Thu, 13 Nov 2025 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="MUaLWdtZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716D35CBC9;
	Thu, 13 Nov 2025 05:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763012943; cv=fail; b=r3z+qrkcyLAUgLT/q/W0slqr3ZquoEhSVJcxfDwLoCz4Vw6dltqeyOCcEnbiHKipQ618H1GMhtgcOveijMu6FmRDBegycn397KtA/TD04Rp5tlRZmiLILMle6LtZ5cyTE5Qh64wXuXE03xBANMU84K7fa4NMpFPZdE18CBMdwq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763012943; c=relaxed/simple;
	bh=/N9TG8SmZqMzI0Ya+vyB3NpHq/2E9zhrzZtOQTL2zEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DwzT4Fzu6wGn/p/RPnHtFyL/dSQ9Kg4duatCbudjlQCSD4IOyexSaBs7HiUcuBaQIFCvmn5LnLuUZaJNQ6VHumEJRsxSQssj4kF+TjzfowQR9kxw2rya3UIg6zCOM3bmAKZ0zm006u0ifJn7US7wrQNNK4XCtr+xJXZb0vzKCJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=MUaLWdtZ; arc=fail smtp.client-ip=52.101.65.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6QuYJHelQLRvdSy/E/5qK5qJL+6GP8jv8FbNb3Ntya2mrovwDUVAr5/4V7UESCjoey7qVdapV7MBT5k+MYzBai+yYSJz39sUXc9RBbaHAUPVarr0Earo4wzAGeT2vON7NMtLTyWvKjkliNYiMxanSYAMTsqsNuoDRXQrDqltF+CNsKPGF5VgMmKkNv5LUGZA/QNQHlXfUpUGGWVk7t1vx4afmTARPtSaf8AnWI0frJZSE24pq/fWCrZnJl0eZ/V7eCMhv9rh8t9fiwFC5hxAkn5B4b0vjqfascPiv3KyPc+HrzQphwKxetld+oKFIz1Vzdg5IaHCfWGCcGdsusz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3oZypIm5BZZtNp9WP9unlYFUNtyHLU2sm+ucDQ5/nw=;
 b=HmvQXtxbVXJHwFiZTHRcow4eZ7FRHG7m4F5k7G/k3vfCL1IDd0lnlF/RRhl7FZOwU4Y45p3vWcZeDTcFdPUJj3KOM8ywZu6PRFxW6lq3QlTGUqDLyIPYQV09rezVICwGxD3Oj04I0K7vVyAo0guyosRsbbuE4ADgRHiKs5V9XEe8Daqd0PMs+dWLH6xoMPDQeARzDPsuMTGay5FZ3wFJsuId8OFTxhs+1zEZJeG4Ik1pP3QF5eAmUrzjGo2+1fsWdZLjp1jY2k8At6YtQ7KxOySVS5WGJAnYXuy/Ui6pvoqny24LOR5vZutiq/eEIKy2a5zS3Q49hta7aFoT3L8m2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=gmail.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3oZypIm5BZZtNp9WP9unlYFUNtyHLU2sm+ucDQ5/nw=;
 b=MUaLWdtZGh0bjHDTLA1VFIXLHTrC+qjgLlr1HNwwpeXT2eN8n3BuRsmL7CVzbT61gXfmpO2zr2lRQIh1fk+HXyqw9aarLlBZ0758bd7Vc+HVWB6EzbzmdMdP1HSGg0L0PyYuYKmDfiEkvQ+q2FQ5LfcXWUnDqAMqAgRstzjaw3CCGB/hh5cEF83cxRYw3u4aaDPEByF+eLkj7KCt8EBgQIWeAGIHwJx6iNXySArUm44qNu4wWC3WSfL8z2BZokbp0DqEyamJWuyWL3U3RA6GNqosv08MdCserS3kQVYu2Ue6Lwcjux9eJHhylzJdNIb+hHjfs+51WU3H+p9+/taPqA==
Received: from DB9PR06CA0008.eurprd06.prod.outlook.com (2603:10a6:10:1db::13)
 by AM7PR10MB3574.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 05:48:54 +0000
Received: from DB1PEPF00039231.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::2b) by DB9PR06CA0008.outlook.office365.com
 (2603:10a6:10:1db::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Thu,
 13 Nov 2025 05:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB1PEPF00039231.mail.protection.outlook.com (10.167.8.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 05:48:54 +0000
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 13 Nov
 2025 06:48:46 +0100
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 13 Nov
 2025 06:48:45 +0100
Message-ID: <be8d69f9-c21b-4b9e-b7b5-92dfdc668857@de.bosch.com>
Date: Thu, 13 Nov 2025 06:48:38 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Marko Turk <mt@markoturk.info>, <dakr@kernel.org>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20251101214629.10718-1-mt@markoturk.info>
 <aRRJPZVkCv2i7kt2@vps.markoturk.info>
 <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com>
 <7f3bb267-7cff-45e1-84a7-15245cffd99f@de.bosch.com>
 <CANiq72=xZ08i3MFqXyxFG63gq29EUggoyb57SJWPNW-Y_VFqqg@mail.gmail.com>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <CANiq72=xZ08i3MFqXyxFG63gq29EUggoyb57SJWPNW-Y_VFqqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039231:EE_|AM7PR10MB3574:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd3159c-6984-4f38-959b-08de227854ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3RxcDZObmczTllKcDlUVm1CUXB2MDZ5L3JNem9Td2FGRWkyY2hTWG5nM3B3?=
 =?utf-8?B?eVNGbFVPalNxTDV2OHF4REhGLzk4S21DM2pmcGNtQlAranVNK0IremtjVURF?=
 =?utf-8?B?NjRON3RJTEdraWpYcEd6T0l4MWlBVFZaUUtndXJ4bkowalVrOWpuOHMvaTF5?=
 =?utf-8?B?dkZteUw1VXlXNmZMbXMrenZRYmVxaUtQdVVNU1BDNjBoalNBd0hodEx2d3ZX?=
 =?utf-8?B?YmMvN2xLN1NjejBDVUt4dS9mbW5mdEJkZDdHUCtpbVZzTml2ZVFCQ1RrWVM0?=
 =?utf-8?B?M1pYcUE5bjR5eklxUkRmZzhEMTkyQkowVHdRWVZtUG5ITlZGajlNVGVOcDZU?=
 =?utf-8?B?UjRhWlFacEZSSERqK0h1cHBoaTI2emNxaHNpVTlTb0EzSlBEUThma1Q3VDF6?=
 =?utf-8?B?NTdXcU9TeHkxbkYxbmlIWnljSEpFcWxVeEgwWC90RW90Nm5NSFFjVmtXSFZF?=
 =?utf-8?B?ZjV2R3ZzN21pcGJHQXFobHF4N2t5QmNTR21YLzVVSDdrR2ppUE9US1JJV2Fw?=
 =?utf-8?B?cXJrZklVbWxUR3hpK3VCTStENXBGNFZFdU1OZ0V2S0l6d3dQall5bzRxUU9T?=
 =?utf-8?B?d2Z0UTVlSkdZWldYTUZRZnVTL2xwZlpPOFY2UWxVa1BaZzlkVVJZSnF5bEhB?=
 =?utf-8?B?TUlXRHVBclRwckw3RzdPNk5vc0ttSlZjaXVCaHlXb0ludkJVdXVOU0xlYnlk?=
 =?utf-8?B?WlJLaVNPL3FqdWtRa3NONGdpeXhKUXdnVEVQZDlKZVl5bEMvd2REN1NiQjRD?=
 =?utf-8?B?UGVKQXdocCtuaXpnZWkxZEJnQnJjdTI0SGRyZXRoSWdNaHFudUV5Q0xVOEFZ?=
 =?utf-8?B?RDdwSnlLLzY3Lzl3RHhUcVFtZVBsV01xVC9SdjlnU0kxZE9uUUdlWWRpQk1z?=
 =?utf-8?B?R3VUazVtYXVZTFlCbTB3SW1BZXpVL2ZySEtmM3FDVXRHQ09rRzJwZE1OZ0V2?=
 =?utf-8?B?M2U4bW5WUGl5Qkx6REFoYnhscU1nc1dmbFhkYjkrYXJMbnRUTWR2eGhmc01F?=
 =?utf-8?B?SEs4MGV0SFFEc2w0RTBBWHI2QVlBM2ZDSjJaZ0tjNCtpZk8vVGVkQjNISzhv?=
 =?utf-8?B?L3dPcFVGVThEaEtrbnRqQXh3dU52VXBDTkVtYWI1M2x5aERNa2NYaktDOE0y?=
 =?utf-8?B?dGl1Q0ZjL2p5TVhWLzdjVHdvcjl5WFZ3OUJudmxOMHF5SlVtdVZod1pIK0M0?=
 =?utf-8?B?MFR4eHVDeVp3ZERZU01Nc0RTd0pQNjEvVWRZcGRXZlNvSmpZWEYya3ZzSTVO?=
 =?utf-8?B?dzNJempHNGZva2Y1OVREM1RPcnk4ZUVUVVc2WXBuVldrQWE1aUFvR243NGVQ?=
 =?utf-8?B?Sy8razdCY0haK2d5MVBCWG0zVis0U3J5VmhXRHZHQUdCSDRkRjVtSGRnSmI2?=
 =?utf-8?B?WFJHQ0xMWjNJMUhZZlNHY2Znd1lCSkxOUmxoUzhIOTVqSzc0R3pzdUhWbys4?=
 =?utf-8?B?WEI4U2RDUkxtczFNUWovSFAzUGdWTkQvRDZ0VUIwYVZIQ2dxMVYrYkIyejU1?=
 =?utf-8?B?T3pFZGRzbHJReEEyVGdGMDVhQ2JZTXQzTGJMS0lLd3FadDBtVTVpSlBzSzRi?=
 =?utf-8?B?Vng3dGg2V0hLaStEcDliMTZFWmZVV21WZHZFcnJ0cmVJOVlCaVFiVUxjU3RC?=
 =?utf-8?B?Qy9jSFV4RkpFTFc2a2FmYzZEdlFKNDcrZ0ZqVFRrS0VIaGlSd2hkQkR2QW1y?=
 =?utf-8?B?YzJhRFNJMjRRWjNVUWM3cHZXZ0N3Nm85WVJIK3lFN0JGQmxHcG1ZQ3FPRk5m?=
 =?utf-8?B?U1BzbkdQWi80U3ByamptMHRWRDRPRWlBVmFrQm9Yckx6NC9HZ2NlQ1ZSZi9F?=
 =?utf-8?B?NUZBb3R4VTlYL0F2SjFWYnQzcTk5cDV3NjNWcksydllNSERnUGJzM05JNTAr?=
 =?utf-8?B?Y3pWbFUwREtGL0pIQ2k3bEYrN0VXWjNGdjdHdEYyUVFMOEtERUZ4U3c4L0tt?=
 =?utf-8?B?Q0dkZWZ5SFMwUEdkRndJTkZ0QlkwT3BaWFhQakEzQkxpeVhiRS92cDBweUp6?=
 =?utf-8?B?Tjloc3hFV2lMdll5SjU1ekowTTk0TURsTXp6QmNTVHYzTE52VlVQdlhjZkl4?=
 =?utf-8?B?L0M4V3VuVEFpUzFDNE83SzRMWDFhbzZXajZsMS9rUkhSV3BsaDRUaDJVUzBp?=
 =?utf-8?Q?+99E=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 05:48:54.6166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd3159c-6984-4f38-959b-08de227854ca
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3574

On 12/11/2025 11:24, Miguel Ojeda wrote:
> On Wed, Nov 12, 2025 at 11:17 AM Dirk Behme <dirk.behme@de.bosch.com> wrote:
>>
>> Hmm, I can't find the initial patch in my Inbox. Even
>>
>> https://lore.kernel.org/rust-for-linux/aRRJPZVkCv2i7kt2@vps.markoturk.info/
>>
>> doesn't seem to have it?
> 
> It was only sent to the linux-pci list -- for situations like this,
> you can click in the "[not found]" message at the bottom, and then on
> 
>      Message-ID: <20251101214629.10718-1-mt@markoturk.info>
>      found in another inbox:
> 
>      ../../linux-pci/20251101214629.10718-1-mt@markoturk.info/
> 
> where that last line is a link to the other list that you can click to find it.
> 
> I hope that helps!


Yes, thanks, that helps a lot!

And yes, the change itself looks good. I gave this a try with x86 QEMU 
and as expected (as mentioned it is a no-op on x86) I get with and 
without this patch

rust_driver_pci 0000:00:04.0: pci-testdev data-match count: 1

With this:

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks,

Dirk

