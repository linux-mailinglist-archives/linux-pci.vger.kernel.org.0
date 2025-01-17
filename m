Return-Path: <linux-pci+bounces-20074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E50A15767
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 19:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CB63A4A1B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 18:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5DE1AA7A9;
	Fri, 17 Jan 2025 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AArNDjEM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87EE1A8401;
	Fri, 17 Jan 2025 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139293; cv=fail; b=XeYcdlQwp8bxXmLWyq3lRCO5yEa8ryrrNFjflYhJdgO7IoRASPhMoprsvb94nxMoXnN+eTT311EQqPS5tZxaSTaw0r3/DEjq3Hjmq9SVMM8vnJtjtTQOON09wRnvppme8sOU8DBkSV6vBJPSCIFYIZyM6fODGgikpLU7JrzU0o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139293; c=relaxed/simple;
	bh=ueCI2p+LoXmgZlRTbEP1IN1uTMqHRkPcrB3g/U1s+No=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RyiTkJoUxxg78ojaIkKYBkawE6YuaLyOE+aAvliOJIwMdIkY1cwP1ob9s1fYxHLGASY+2wPbVNpisrW5I5qEIGmHGpXExfPbhC9vlVZlL6fBItGHqB0z7GugRC3hQcMWYpIHocuhoN2Kal4/iYc7tfi3IBsAo6KxkUZ7FZ+n4jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AArNDjEM; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/+lXxB7CxtRDEgEP/4FWoi9xIkAlrysuJxRjZFADN+8zGep83z8c+u718C5ccEBZekFeYWq78Mr7rs2NqXrijrgWFJHG8s6gbHgkxACbsrJ4ADjpU997F/gPG7xDW9q5ZTa984SIg3WE7XoZpO3qEMSZzpZzhpaA4sqMEtCU1mNlvROw0rP3yNiLU0uc8W6aKnpHMx0bcE5iOHXCyXnbcYm3nrC1ODdl/DpIr0JmF1cCEiOj1K5wkBnNwVV/kbRSSgR/84/wxaGroEDWX1qe0TDarsvbAXAcAR7bQn/2FNwDCPV2d6PyRnelAB+mbxJIT3+sRfA+gyCYw8aMhZU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptDKbcjABbgkZzTDx7uVQ+WCUN8Swo7WInQox8Cuq3s=;
 b=ty2A9Lg69rNzb4pi22OBmXLfsBuu2QPO9l6tbDJFnxp3SWbqlXz2Gxfl+9t42ufCgoQty2qseyAIjtuwG6fr+8V7kBudech6HsFIisqpk9WvKKLWJe5u4LBXL8zH06aOn4nFVugwxWipc3HIKuice2v6zhAwwBFf7qU1ZGHnTSzpX4MImFQuGcDlObat1T893970kdkoYMQS4EBTJziwxdUugtqnkHrTktkpzbdb808ZbefxCK5MtUy9uhSNguItoyxrpKvKcCXkNdRFD++RV2oLqV0Y7onb/sgs289aFzaNanJvhJs76XK7BLyuqcrfw3milpdbdYolLcJpKM2wIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptDKbcjABbgkZzTDx7uVQ+WCUN8Swo7WInQox8Cuq3s=;
 b=AArNDjEMxMavVbgynn/hC88t52Lgsqd5INL3Hfm/uBtTdu4ExDhakk4oSHiOLfL8WG5ZohElI4/1W5tMND34NtLvd2mbX0L5q7nVnxHf4ZNMaVg6oKlhgbSITClXdJlf3kbDawCFaaBu/xiPTQ8N/lRQJIXIIRbP3laC+RZvcv0Bb2ywbYvW1qLQiYepXlyPXtsWR36P51uSEOOW8xf+GSsWMKyvkdQqKoLrASkZ7UnppV8bG3X17M8Mtm+Ev5+GXFCWmtMygHEZ4tePz4ciLtI/fzWUdT6WRtFUVm9fAHtTarnAwjxvgNw7s6X3fy+Kbwvmu7YaMr0CedYBjrphkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 18:41:28 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 18:41:28 +0000
Message-ID: <02c3adb0-ff46-45ea-a67f-8d4728302b3b@nvidia.com>
Date: Fri, 17 Jan 2025 10:41:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, vidyas@nvidia.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com,
 sdonthineni@nvidia.com
References: <20250102184009.GD5556@nvidia.com>
 <2676cf6e-d9eb-4a34-be5e-29824458f92f@nvidia.com>
 <20250107001015.GM5556@nvidia.com>
 <c9aeb7a0-5fef-49a5-9ebb-c0e7f3b0fd3e@nvidia.com>
 <20250108151021.GS5556@nvidia.com>
 <0ea48a2b-0b6d-49e2-b3f7-ab4deef90696@nvidia.com>
 <20250113200749.GW5556@nvidia.com>
 <6ea9260b-f9cd-4128-b424-11afe6579fdc@nvidia.com>
 <20250116190118.GW5556@nvidia.com>
 <4d5224c6-bc0b-4ca9-9f1a-71d701554b3d@nvidia.com>
 <20250117132802.GB5556@nvidia.com>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20250117132802.GB5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:303:8c::23) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|SJ2PR12MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbaadaf-e5aa-4c04-22c7-08dd37268dc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1BzbW1kOXN5clpFQWYwMlNzZGdzZlBoUGZwL0tmMVdjU1ltY0Eya3BQaTVp?=
 =?utf-8?B?Mjhlb2dlck1TWkxzK0o0ZlpKckdqc1NGTjZNa2wreWN4eHJ5YVNCVTRZT1Jz?=
 =?utf-8?B?WWhHU25uYkxRZ2Y0S3BJZWxtZnEwWGYyYW9JekpWb2gwR1czRGtHQTdNNnpH?=
 =?utf-8?B?SHJ2WnNTeUtqbXRvQ0Eya2M5UFlmSjd3K2tIOVM4T041TU1KQ3RaVGZCTjJv?=
 =?utf-8?B?RERTeFZVSWtDckI5QWt3WDhSc1Evcm11Qk1OTFNSWXZVcG5IWENadHF5MlUr?=
 =?utf-8?B?N1dMYjNSUTVlc3lVUTJkdnlBeW55bmxLclNTcjlyMWVaa2ZiWGwrMVVqNnJ1?=
 =?utf-8?B?bWorWERiS1JzejZTMkloYUJ5NXllZGd5elNlbEhyWlI4Mzh4SXpTU2h0R1Zx?=
 =?utf-8?B?UjYzK1FhWlE2VzhrZEVoeUNaQ1JuN3RpMHJ3ZWlWM1ltMFdCMkpNbWljWTFz?=
 =?utf-8?B?aHc0UjcxYVVpNWkvazBpaFJFN2QxVWRDU0RZVXlOTEdmY2N3WWErdlNGM1Nk?=
 =?utf-8?B?TmE0STBmN2ZFUzJyZjN5MDl4RDVCUkltNThSUVp2bHVwMGtDOVBwWXZGaVVz?=
 =?utf-8?B?UUFUa25oQy9jRytDZ2VzTWJEc0IxbHNkRGdZbEJtWGRObS80a0EzeS9IWEM3?=
 =?utf-8?B?c1czMGtEaEJjQXFSeERnQXgrVjRXUGt0cFVYM0kwM0xsZ1h0a2NnMmk2Vlk0?=
 =?utf-8?B?NXpzN1h1L0hDT2Jndk43b2h3SVFJZWRidmtmUnBVQldseHhjNTdsdDJueFdw?=
 =?utf-8?B?ZG9IVU55dVV1SGpZZjFDSm91aG1ML1k4NzI2aVRacjBacFR1czdnZVlhUGxv?=
 =?utf-8?B?OXN5UnpYVWFjS0plUTJodEZIQklMdW82VzlUM2Rjb3BRZXZuRjdRTjZXRXIr?=
 =?utf-8?B?WFZtaVl5YzNYK1JpdTNSa3l0QzB1T1BrUFZHRjNQTUorSFVkNENtcEpqck5C?=
 =?utf-8?B?V1N0VUt4UjZIREJjZFh1NEJNa3J0WGxVRjR2K1JUWHlRV2dsOUhaQTdaOVNt?=
 =?utf-8?B?Zk9CZ1hEQkhpYlV4U1NaNTFmR056SGNzT2M2OGxPbENhYWhvSy9iZUw1UmZB?=
 =?utf-8?B?TUNBVE1rMTI1OGNHa3JJdFh2ZEVVRDRidGw1SS9UWXFBT2ZobFE4Q1Bwd1Qx?=
 =?utf-8?B?U1d5VEFRZEhENXpKazBsMmlqUkw1VUhhN3l1eUk0bHFlYmpKTzRoNldyajBQ?=
 =?utf-8?B?UHBsUTNMVlF5SVJwdXcrUVAxR1NCNjdhdG93SEVNZUE0dFd5VER5WDl0MUdr?=
 =?utf-8?B?bWpvWmt6aVB4TVZMMTVHcHg1ZEFnVW5wMHpKYzhBTmZnTXc1aE9sekdWSldk?=
 =?utf-8?B?Yis0NU13bzF1U1hrdmFxUTUyVEtBOFozeG1SRDJIamZmN2luNVpFb2VXenM2?=
 =?utf-8?B?NW1YdzA3c21vaHdGMTNUMk81QjUyVXNCN3BUaVVjNGNMRktkMTJWdXdiUUh5?=
 =?utf-8?B?dlpjTFJtbEZ6Q09FdHZnUlM0SFRIb3pGWjlONnRFNUhCbHlMbURxL3haNGd4?=
 =?utf-8?B?Z1BLeS9zR1NQdjdyV242Y1NqVmpDRVQvbVYwenpNUzhobExTODluRnRHdE9o?=
 =?utf-8?B?QklBdEZZdWg2SVNGcFhla3EvYTJOeUdMeDM3Y3pST1BRRi80RGFpZitWNklO?=
 =?utf-8?B?eE1nbXFFcmNjbkM0U2pyTkVpUEJYQXRKTVdtQkk4ZHRhVDR4R2EycjhDT2ts?=
 =?utf-8?B?cDVIaHVWRmZHWFFMZXNWRlJmQ0pnUDVGNE9lS2ZTR3VmRVRvaXl3aE55ZEFx?=
 =?utf-8?B?cXlBMzNTWEdTSnNZT2x2eW00SWNuQU5iZVcxVUxpV2tReGwycXlJNW1nSTNy?=
 =?utf-8?B?c1owSk5SUThIVEd4SW9oZW9QVld0T3VFVUo2NFUvb1RKczVzSHgwRElnTnl4?=
 =?utf-8?Q?OZiAP+cbA8pvR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFdTRXQ2RUVQQUJXb1VkUFNNSE5NZEJjdkpyR1BrY2NKbVorZzg1dEUzaFVQ?=
 =?utf-8?B?ZWtWcE90ejhFdjk3aXQrblBHN25qaUhYL00wd0FxTWJnaGZUMlVDU0VHaTh0?=
 =?utf-8?B?ejk4ZURVbDJ3Nzg2c1krTDhOYXRpUWVqb0s0RzIwV3ZrRnRxSGVNTmtGQXR3?=
 =?utf-8?B?QnpNUHlweWhKZ3BQdytCdHNOUDkrSEJXQXVSVHZQc1BaMzJKUmxrUzRibXc4?=
 =?utf-8?B?RThKemJUSHcvQXlPYlJIOFFsS3dUdVV4Y3NXT2VHcVFYb3VDNHhXekZJcDAy?=
 =?utf-8?B?c2NCUDhRTm90dnZqYWxjRkIvaVk2VHJNSGVhNjhtWkU1OVdsMXBWSEt4MGRv?=
 =?utf-8?B?RmNNdlRIWlJ6YVU5ZTRKTXFwS2MwdEFuNVliWTFzajFCUDQ2ZHRwTFMwU3VE?=
 =?utf-8?B?VmtLMlBwMVFrVmxuWnpOWWVWVzgrUmFBdVQ0eVN4b1dEN3hYQW5uNFJldHFU?=
 =?utf-8?B?Z0tlYktLMWkzbmdpYmFxRWw2SEVnYldjMXUrY2Z2UHlRNXNuYk1hdmI2VVEx?=
 =?utf-8?B?WDBLR2YzLzR3V1R5SHUvQzk2eHN4UjNyc1E5YTNCVWdZazl2V1ZWUnVuSEVh?=
 =?utf-8?B?eW11aHRtTEt4dkg0YnhBMnhWakFmOHJrSTRkcFo5VEU0TzZ4TCs5MHdsQUlP?=
 =?utf-8?B?U21FaXNnQTB3bjVkcDhmdmd2WGpwMGZyQ1orZHVNOUU2dHRtckFJaGRzaGVL?=
 =?utf-8?B?NkdoK3lTME8zL3RpSWgvRjE2aFBNMjVMWGlTR3hJdlJEZm94eFdVMkVEU29Z?=
 =?utf-8?B?cTkwRHN2SEVOaXRWMk0vTlV2d3hhL0tYQVdON21Lb3lOeWR6VEFPVnQ2bVdX?=
 =?utf-8?B?bjJ5RzQrTzFkeDdHd2prQ3ZONWpXb1JZVTBrN2lIUGhGVldpSkpCVWZMOWxa?=
 =?utf-8?B?ajdGVHdCSGhBZGVxeVhEaEEza2ViRmtBZk9rUTM3WUhwVjFHK3R1ckxEK3dR?=
 =?utf-8?B?a1ZLcytJYTl3UG5KZ1cyODFCNGdDTm5yS0ZNd05kK0pIYXY4Q2hYY0tTQjQ0?=
 =?utf-8?B?OERqNDhmWngyL29ObjNGd2hHeThGUTNhRW9vMkNuSHo1TDVDVDAzdEdzVTYr?=
 =?utf-8?B?bHF5ZGpzZFk1aG5FU3JTZTArQ1NZUm1nQVluZ3VueEFzOWtPSXpyV2QvSHQw?=
 =?utf-8?B?aE4wclJkN1RPY1praWYwalJoMmVqQzB3SCtwRGR1d1NaTkZTYlg2czBaOEVV?=
 =?utf-8?B?TUg2bngveG1Ob3BMVGhUc010L25wMGZhSGI0MUw2Z0NOTVhYS2RzdDdoSENG?=
 =?utf-8?B?WnNBempGNjVjYkNVdWhMVDY2MDVaSTNlV2s5ck01OWRodHF5QjA2TEJYL3pX?=
 =?utf-8?B?OHlkMm1IdWZKY2F2aWFldnhwVnlyVUJLaThFVFBJOGxoVnYvL2owb25Wb0tE?=
 =?utf-8?B?SHRoaU9oOGtaSHVFaG5TS01pRktVS2RSaXJyZk10a1gyNXc1cXdlcmZLb293?=
 =?utf-8?B?UmdHNXoxeURuTHNYZWY3VVlZOUpIeDlvMTBsNE02TGxmUTlZMTdxQWxlcDJD?=
 =?utf-8?B?KzNSVnNvc0F3NnpycGkyZXhQSE5SNWUza2xqTFhMREhWemh5SjFRQ2gxQ2JL?=
 =?utf-8?B?Y2huTXg3TjdrNVd3UW5qOHlxU2VONzVQd0U1RG1jL0czNU5QMmpTVyt2czhM?=
 =?utf-8?B?dlFISERoUFg1Wkx2MzFLWWpnSW40UTRnOW4yWERuYkNUVzBWNENja0Fkd2tQ?=
 =?utf-8?B?Y2FWM1JlMEFodlFMRUpFcFlvTWdqUlg1a1YydzFyMmtOUTZPY0ZON3pYNVRV?=
 =?utf-8?B?Z1hIWXZPcnFHU2UrUWhrcVhJbVlPVzhTYm5XdTRzMkg0S0F6WEE5ZGN1eWIy?=
 =?utf-8?B?VzAxZk10dVUxYXhXOE8vTVJ6d1BPRVlreHlSMm1hUEx1WFBvTXZySHlKQ2hK?=
 =?utf-8?B?cTl0UjhoSTZlK3BhMEN5U1JjK0F0UEVNVW1wZStmTHlDenRpeTFKNGhEYnk4?=
 =?utf-8?B?R2hyeExkeXRYOEx3WlQ2NlhXaUduYzBiRFFvOFJhUUVyYklwa3cyMHVock9j?=
 =?utf-8?B?RXB4eWl3RW1leVlGaVl2S0VaTWxDc1g2MEY1TGZQMFB1S0V5UUtuSG93YVND?=
 =?utf-8?B?TktWOVZZM3g0dmxLNTN5YS91a0w2ZDBHeE1GQlNTb3ZWSzhtMm1YZGUxNmN2?=
 =?utf-8?Q?XspSk2LtFwRDoDzsy9hvSd9F9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbaadaf-e5aa-4c04-22c7-08dd37268dc3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 18:41:28.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lffzdIcb5hvgpySURO/wdHiEUjt+wCY8DUM4JyQT7zTNSBUiRD4BQJbdJ2laPq0Tcy24Ie0BXNI+axuEWyCedw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717



On 1/17/25 05:28, Jason Gunthorpe wrote:
> On Thu, Jan 16, 2025 at 05:21:29PM -0800, Tushar Dave wrote:
> 
>> -       /* If mask is 0 then we copy the bit from the firmware setting. */
>> -       caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
>> -       caps->ctrl |= flags;
>> +       /* For mask bits that are 0 copy them from the firmware setting
>> +        * and apply flags for all the mask bits that are 1.
>> +        */
>> +       caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);
>>
>>
>> I ran some sanity tests and looks good. Can I send V2 now?
> 
> I think so, I'm just wondering if this is not quite it either - this
> will always throw away any changes any of the other calls made to
> ctrl prior to getting here.

Yes.

> 
> So we skip the above if the kernel command line does not refer to the
> device?

That is correct as well.

> 
> Ie if the command line refers to the device then it always superceeds
> everything, otherwise the other stuff keeps working the way it worked
> before??

Yup.
If kernel commandline is present (either config_acs or disable_acs_redir) and 
device match occurs in function '__pci_config_acs', we discard any changes done 
to ctrl by kernel prior to this call. Else we do not touch ctrl and it works as 
before.

And IMO, that is how it should be. This gives admin a control to configure ACS 
using kernel parameter based on ACS value that FW has set (and not kernel).

-Tushar

>
> Jason

