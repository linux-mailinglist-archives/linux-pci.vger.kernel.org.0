Return-Path: <linux-pci+bounces-37701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8719BC3E1F
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61A784E5C05
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC132ECE8F;
	Wed,  8 Oct 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kwDlHuxT"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56785248166;
	Wed,  8 Oct 2025 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912832; cv=fail; b=IVckvyWzUgwFa+iRvBHumkgGlPUhvVpmvkl39/F6Bu4C4g0gYGMZJ4R7OMkSK4cc4ZSOdSnQLk90gi5Vlx/Ew1KvikHOPhUJoK8M08anO8QevN6Kg3Peve0EBnZYswwzCFFUNqgpMYF2aIs/rILeITQLdsA0pSQ16sO8ib7MLpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912832; c=relaxed/simple;
	bh=mjK3zA97M1/QgQHIVa4UqATVAWPFYGfu1d5BsN+KKtw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b+ZYeqz5olE8mm3d2r184xm+y4HmikEjVxswec7n4HUB2zmsczisJk9RcxZYzkRwAUnxMpxk+ND4AtyniVEI1+TXAFo6Gq2CMi5CruhZIw/ylB1jezLHfSqr/52/yyEgwIQfW41HF4jQBzc2zRiw4p78067lvic1FmqlaUbisU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kwDlHuxT; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E28ADCcHDGGzpvxLRViadaz13qRzLrYqGZUQY+19qCzNcSKPPKnaJnOQsXzDrsYzo3c0hshMDyRtQnU65FFfF+OalhSO7SxAQPg621gux9lHfj9HD9xalnHUw5b25PmWVfRL3znADi/WXcNCi4QfalqGQQ5vnhtA8vJHov27UqTnaXmVBd5lyoaRd6bYCpv8AoF1x0objaI6CChNYV6oF1fdRQzv7fD2BNttD1GRIYna/h4r5S7qGi4q4nsnKQ2HIhDHBB8em82EUDqV8hhem1AJIqXVyVJ+LCRhj+v2pE8vb81/yz0tQCc5QfVCu75Y1jupe57sx0oiEH0S5lWCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXGtzKVKaxocHnf5rAx+p5bObZ+NdlBRbe4GkvJFujY=;
 b=f1dcbWoiNlaFgO3xsJjtBhjFV7XIhmocFXkRlQwpcLyfLg63Y8Y+p4QlM4SXNW3zG8102/i8BMGpYUSpzkyflCuHfOFFTG2u9asrdJa4mYR7Fe4nAc/Os0hlrufA25+m9/Q+ERKWPzZoc1WpkYfnBZyoLcCVMr3O8D+K8PtHTRHKVQHM31qPyoDbN+r4oImK7mff2z4aLhci/c7wQnGpjoYbrNpp1+isFxh2J+D3DyIOwUy1iq0znDZJffmaMuNUaP5/oQ9Cp6hL2FV2qLB12kna7B3fsF2JQerYs1BPDs10mVabzIbNlgykZkpHAh/EDa4QI8m3ElIF2uaTDcURFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXGtzKVKaxocHnf5rAx+p5bObZ+NdlBRbe4GkvJFujY=;
 b=kwDlHuxTvP50DQxzrUIr/snIgVKAgj/vbg0yY5YmQBxY+klybd5beUnIlbO0UY638jonp8cHp6sdZ4KkG6L3emN5X9UUj22AeQOXsxWb7n2eqcfbaWEpQporViHEyuWIRsFo9gNRf3eCB4Or86DYwaPSmzBTS8rM5D23XJDvmfABavhBR3lgbmafR8ifMXZU+iAJCAYLBJsNWcwTR8ZK6PxU8SAn+VlSSJd97Gqvu523OSJzNrwGZu3IBzVSX3Qfc9ZcSAmLWhe9CbOxJHcgJ2+PVzJAmSiE8rdChZbh/3EDw6E3oDJyZplSg9OgSGMeybhXDgsnZRU44V/CDvIvJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by SJ5PPF8AECCE022.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 8 Oct
 2025 08:40:25 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%3]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 08:40:25 +0000
Message-ID: <a4ce405c-4abd-400f-afd8-16c53170250e@nvidia.com>
Date: Wed, 8 Oct 2025 16:40:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: Resources outside their window must set
 IORESOURCE_UNSET
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
 <20250924134228.1663-3-ilpo.jarvinen@linux.intel.com>
 <CAMuHMdVtVzcL3AX0uetNhKr-gLij37Ww+fcWXxnYpO3xRAOthA@mail.gmail.com>
 <4c28cd58-fd0d-1dff-ad31-df3c488c464f@linux.intel.com>
 <CAMuHMdUbaQDXsowZETimLJ-=gLCofeP+LnJp_txetuBQ0hmcPQ@mail.gmail.com>
 <c17c5ec1-132d-3588-2a4d-a0e6639cf748@linux.intel.com>
 <CAMuHMdVbyKdzbptA10F82Oj=6ktxnGAk4fz7dBLVdxALb8-WWg@mail.gmail.com>
 <2d5e9b78-8a90-3035-ff42-e881d61f4b7c@linux.intel.com>
 <CAMuHMdU_tPmQd=9dCzNs+dEt3fHNsYpYPFnT6QZk546o-J-y9g@mail.gmail.com>
 <7640a03e-dfea-db9c-80f5-d80fa2c505b7@linux.intel.com>
 <CAMuHMdVgCHU80mRm1Vwo6GFgNAtQcf50yHBz_oAk4TrtjcMpYg@mail.gmail.com>
 <8b46093f-82bc-1c25-5607-ee40923b51af@linux.intel.com>
 <CAMuHMdUjhq2ZLFyMYv9KYRW8brsvXMH5xb5NW8shsHJmx7w2QQ@mail.gmail.com>
 <bd1810d7-3e37-b599-5105-02902e6edf33@linux.intel.com>
 <CAMuHMdUrM+WJm2JAPuLmUjA0wWpipdqTfW6mu7cQdAHEyCAwdw@mail.gmail.com>
 <cadef017-c330-888b-a092-04d0b42ff686@linux.intel.com>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <cadef017-c330-888b-a092-04d0b42ff686@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|SJ5PPF8AECCE022:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f942d7-e83d-4ae6-ddb2-08de0646534f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVhDSHR3NVN1SHdTclZkQkFhVmJnbE0xSFZHMlNkM2JmMjF1Snpyb013VFhj?=
 =?utf-8?B?WnB0WENmUkRYeHkxcjhPb204WWozdkJ2ajNkdFhxMWkxMjI4aE51T05peitL?=
 =?utf-8?B?eWc5WnJMZW5Yb0dWMDA4QW5SdzJ3NlJOV1ZkYVZmRGVVNzFJNWFtRkZTV2xH?=
 =?utf-8?B?V3h1ejB1eXNTYVcvVW12M2Z5SlJKWTdzUFZMSGttUERpQ2dBeGdWc1pkcVVk?=
 =?utf-8?B?RUt3WlB2S1NjT3pucytTbDFXYUY0SzM4TTVZTWgyVzdWSTBRZmJueHJ6ZTc0?=
 =?utf-8?B?aWFqRFRZcWh5OEk5L2NZM2tSSGRsM1lwUUxodlZGTHVKcGNVVTEvZXRWUSt2?=
 =?utf-8?B?eHM1Ym5zN0FjUjZoWW1BM2FyZEUwSkxrMWNVUzZKdERwZlBFaVZOd3RKV09z?=
 =?utf-8?B?cDhzMXROQitCSXdIY1Y4Uk1zTkFXZVFIak1BVCt0RW5HTStaTG10RXZQNXQx?=
 =?utf-8?B?V21RSWEreENJVVFMYm1jc0VsS1RBWWVBYTd0OWZ2ajg4OUMraFZZQmVpaEhs?=
 =?utf-8?B?a2c4cEE5UjJJUDlaSkNxbjVZaEd6ODlyZTB6MzUzL3VvV1huUWo1TWNUa1BV?=
 =?utf-8?B?ampFSTFnNy9jakdSWDBKYkUveWFnRGljUUZrbVU3OVhvbDVraGJEckVnVzAx?=
 =?utf-8?B?UmdnTFJMaTloM1FnNy90K3dRRzkxTW9mZnpxUXJnV3p5cjNxRkpMYzJIMDVQ?=
 =?utf-8?B?bTJGV3dPQ2dJY1JhMWtZclYvaWI1ZkhzKzA1c0taSU9UZmd2b3E2aXh3Tk1M?=
 =?utf-8?B?aFJ1ZHFOZWhRa0VzdG9pL2VVd29qTXJBODEvWHlHNHhvSFd3eEZyV0xkUXFk?=
 =?utf-8?B?b2hvclAxSHl2dThKN3NsWFJuOW9YYnhFQ2c4bkwxS2VPeWR3QkJ1WXRJNm1v?=
 =?utf-8?B?RWFwVFhrV1FzbmxmTU85WjNHUUNIUTFDYjJjclVVcWJuNHdmRmFUVjBwelpF?=
 =?utf-8?B?QjFmdnUvUzE5NldiT1k3aXFkdzB2WnFJVmEwdFFOWENPUXNRdnpjMWI2ODhs?=
 =?utf-8?B?cld1bHB0cnIySXZ4NXVTUXdNV3dCdllaTkMrV1RNQTUvRkpsTXFJOFNJVHJh?=
 =?utf-8?B?ZW9ZdGFvVityQmpEMnQxL09hdDZqU0pGaktjNWxmUDVvOG1oUUc1QkJOMkUw?=
 =?utf-8?B?V0ozb01JNlZxWjBWWDVNR1BUcGZTOElhMy9pbGJPYWJPRTVJYzM3cnlCandy?=
 =?utf-8?B?cWI3UzJtV3YrbEZOQTV6cVg2SktjZWlURDZFYU5hVjFlREVKaWxjTTJNbisv?=
 =?utf-8?B?OFR6WDA4SndSL2RDRmZkVVNvdHRHb2l6OEJWdFlId2Q5OHRiQTJIWi9TN1dl?=
 =?utf-8?B?V0o2MHhuQ1dnMktENWpIN2RLYlpITWxCS2g2UnI1SDFVTVQyUXhqK0FEMGxi?=
 =?utf-8?B?OWtVT3FUaEdGTG56Z212amZ1c2tvY2Z6V0lDd3NDSU90ek05bkhpUmZDTCtP?=
 =?utf-8?B?SzVOVG5WbCsvb1BjZVNYblpmN05Tbk1MdC8zSjN0cXhZM0lVOFZNU080VVRM?=
 =?utf-8?B?dFVBdGNaaXBNOVhMbktZNGNnc1owZzZrdTlKU2VYYkZNRG5TSStCTGhueTVV?=
 =?utf-8?B?Z2toajdjVmNvdk41VmhXelJkeUpYRTlKdGxIOHgvWlJDR0RwdEFDMmovVkd5?=
 =?utf-8?B?aHlIUXNYeE02TjR5a3dReXVzNlRnUTRzc1JLQlhyMnNRRlBqUTYrS2V1YWs5?=
 =?utf-8?B?WnRHNEhPMVZKWFMyM3luZWpSdGlBZ3liMW43T2MxdEZjdnFxZzVSZWNBNksx?=
 =?utf-8?B?VVkvRjlBV1Q1MTVudmhsdWVVaWkxSUNsRE9PUDRkK3diYlVRMXdMeU4xWVFF?=
 =?utf-8?B?RnJQZmlmVEhiMlQ5S09BUlVGd2xFZUNOT2x3Z29hZWdiVWhuMTFOVEpDYk9t?=
 =?utf-8?B?QlMyNEJzelAxVzFkZDdZYjB1Tzl0bTB1V1VKZWtlc1Ftbi9uYjhWektPcndB?=
 =?utf-8?B?am9FU0FhN1IrUE1OandyUkVQU1V3U3l5dTFRQStLUkNmOEhJZkJrUTJFSVpl?=
 =?utf-8?B?RUV0Zlc5aDdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVBuTy95SnFoZ1p3ekhROWFVUjF6SkpiTUpKS0Q1aEswTzBJTGJUU3liTG9U?=
 =?utf-8?B?ZGh1THgvazZJZ3RyU3RUL1U1OXg5L2QrbWpCRVNKS1BZa3JwYjJMcFNwRm5t?=
 =?utf-8?B?azRTN0w4YmxtaVB3OGZXTlFUaU1OZzRRaEsyWUtUWXlRUmZyc0g3dUpVYktG?=
 =?utf-8?B?QVcydjFCd1l6WlhzK0phUytxQndIbVBoUmJjWktLT1VsM2lYUFNPRVV2Rnlh?=
 =?utf-8?B?QUprMWNhOW5vTkM3TDVkY0pjL3ZHRkJtSXloMm1HSWpnRzZtNFZxT2VqeFpT?=
 =?utf-8?B?ZGM1dFpPRXhOQ0tleUgvcVBLeGQyRU5TTDBjeWg5T2luK2JMK2NkdEJIYUxN?=
 =?utf-8?B?RlE0WU1JOXZ2aDNwUlNyNXNnZjVNRHJpZGx5SXdEbG5wbTdwcVJqejN5UGlS?=
 =?utf-8?B?SUtLNE5tK0FWV042M1dOK1NSRUQ0dWpqTDVnaDY2bktRbVlNaEwxQWFCeHRF?=
 =?utf-8?B?THhRTDlSU2tLa0JHR3hhZVFpSFplN1F2YjRHQ01hNGJBY2h6eGdVTTZYcWt1?=
 =?utf-8?B?OFFmYlJmbklieHh0SWZYWVZWRkxKbElOUFJGU3JkcVQ5a1IwR29Fc1RiZmt2?=
 =?utf-8?B?UEZlalZDZndKcm5qWGlGWUZyUE9jU3kwTFpIT0pqNUkrVW9iQTlKVW9aZWhP?=
 =?utf-8?B?c3M5ajVvS2ZlQThtTlFRdFJNNFdNaWpTeVNEVVRJaVlxcFcrcGE3Q2U3MG9z?=
 =?utf-8?B?b1dyUnBPZFI3b3FuL25USmgxak0vbnlNc3VJcGsvZ0U3ajN6ZCtQMXppSzNZ?=
 =?utf-8?B?Vm4zTmFJc0Y5cStSanRyVEd6U1AzclhwbHdCdktTeG8wRktiMld3Smkwa1JF?=
 =?utf-8?B?L2s4WmRiYlZUb0lKOGNMTFB4anNTQzloWWxNdlRhY25PUG1wUWt5ZVV2Znhh?=
 =?utf-8?B?VFRBNHh2N2svR2hLL05tZE9rVExOVmR1d2tvTy9EUFo2N2tWN3NtQit1WWhp?=
 =?utf-8?B?YWZ5UEpyQk5pZnlJTE40bEZJVWZQeE9pclB5NHJQTEwzeitJaUhVVkdNaXo0?=
 =?utf-8?B?bXlBbWF5SE1hV1pVUC84R0ZEMUpXcUQrK3c5dElkbmFRNmg0VHpra0hNeVBi?=
 =?utf-8?B?Nk9uYm4wRzNmcURYNEJJeXBFc1Q1MUhzc2pTbDAzYlFmcnJsN1NEVGMxZEND?=
 =?utf-8?B?NVZvTlQ0ZGQrekwrNDJDK0t1MElqQzkvM2Jhcy9kazRCcW5xNmthY2Vuc2NT?=
 =?utf-8?B?N2d3QlZoZWg4eFNqcXJQRHdZRlArK08rd2Zwa0IydncyQnllSm1rc3poMDRW?=
 =?utf-8?B?ejVDTFlNL3FuQVhibmlQbFZMVll2TVhudXc5UktsWW9ZSFltRUtFYnFvR0hW?=
 =?utf-8?B?SzJDZXRuN0wrTXJhbitiY002TEQ2eU4rV2NmalIybitSNThscHQrYVZ2N200?=
 =?utf-8?B?N1BZZSs0QVl5Tm9VS29QaFoyOE5Xc3dEOGFJV3o5eEdHVHBZK3JoUmdKM244?=
 =?utf-8?B?OEk4d2hvSXhzakQ3OHEyZGl1RVRCTzN0VklkYzNCOGZRWk10MDJ3d0syM1lE?=
 =?utf-8?B?dWM3dUtQblVjeTFQRzJJMncwRXhaaHZTMUlRZFdzMHBlb1EzblExcTdQaTM1?=
 =?utf-8?B?ZWRMVFRRV20vUUNDaENyU2NQOUZpMlc5dEhVK0RXMUg0V2hLV1k4djBFN1ll?=
 =?utf-8?B?MDM4TWJ4ZmJiOHNqTXUvSGNZOHV0QkhpS2QxVFdQRUVLeDl4c2tuQW5DallF?=
 =?utf-8?B?UUkzUWZHL1UzOXdqVFdSL0twRVI4UkFFa3V0K1ZQSS94enFKTWNaOE41WXRD?=
 =?utf-8?B?eTJnNm53aCtwbVQreDQ2cXh3ZjBYOW1uTUZEMk8xQ3kyQldUZzc4SUdFUDlG?=
 =?utf-8?B?YnN3WXRzY2NpNTVVY0t2SXJjSEVVOVIvV3BMK3ZsQnNWNzNmaW85c0FvS2dH?=
 =?utf-8?B?QTBHNXAvMU8wMDZEeEw3TFhmNW5OdWVQVHE5cWtBcnZLOGpLNHhVbWdaeW9m?=
 =?utf-8?B?cGREVHBsM2luenB6MGdIR1VhTkI5OEdHSEJkd09EYXdrTDZPTThRUDU2ME1s?=
 =?utf-8?B?TW9paE5aM2RpTndMKzl6YVgzS1IxUTcxa1gyTTJNUXJqSElsUzFrTW9GUHF1?=
 =?utf-8?B?VGFRdlk5bnR4RmsvdHRDL1FVTWE3OGJUWVJKZlRrY3puTGpXbnpXY04zazl0?=
 =?utf-8?Q?5arWR2d4+dTVh1e1D7JShnKz1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f942d7-e83d-4ae6-ddb2-08de0646534f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 08:40:25.2091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmXZvApj1/MqwSbhK/RVg9ITDYjcM1atlyHQMSjeg6vk+dXL45+rHfw9GP2c4tMSb+4V46qghbgLFrrXhdy3CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8AECCE022



On 2025/10/8 1:30 AM, Ilpo Järvinen wrote:
> External email: Use caution opening links or attachments
> 
> 
> + Kai-Heng
> 
> On Mon, 6 Oct 2025, Geert Uytterhoeven wrote:
>> On Mon, 6 Oct 2025 at 14:37, Ilpo Järvinen
>> <ilpo.jarvinen@linux.intel.com> wrote:
>>> On Mon, 6 Oct 2025, Geert Uytterhoeven wrote:
>>>> On Fri, 3 Oct 2025 at 16:58, Ilpo Järvinen
>>>> <ilpo.jarvinen@linux.intel.com> wrote:
>>>>> On Fri, 3 Oct 2025, Geert Uytterhoeven wrote:
>>>>>> On Thu, 2 Oct 2025 at 18:59, Ilpo Järvinen
>>>>>> <ilpo.jarvinen@linux.intel.com> wrote:
>>>>>>> On Thu, 2 Oct 2025, Geert Uytterhoeven wrote:
>>>>>>>> On Thu, 2 Oct 2025 at 16:54, Ilpo Järvinen
>>>>>>>> <ilpo.jarvinen@linux.intel.com> wrote:
>>>>>>>>> On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
>>>>>>>>>> On Wed, 1 Oct 2025 at 15:06, Ilpo Järvinen
>>>>>>>>>> <ilpo.jarvinen@linux.intel.com> wrote:
>>>>>>>>>>> On Wed, 1 Oct 2025, Geert Uytterhoeven wrote:
>>>>>>>>>>>> On Tue, 30 Sept 2025 at 18:32, Ilpo Järvinen
>>>>>>>>>>>> <ilpo.jarvinen@linux.intel.com> wrote:
>>>>>>>>>>>>> On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
>>>>>>>>>>>>>> On Fri, 26 Sept 2025 at 04:40, Ilpo Järvinen
>>>>>>>>>>>>>> <ilpo.jarvinen@linux.intel.com> wrote:
>>>>>>>>>>>>>>> PNP resources are checked for conflicts with the other resource in the
>>>>>>>>>>>>>>> system by quirk_system_pci_resources() that walks through all PCI
>>>>>>>>>>>>>>> resources. quirk_system_pci_resources() correctly filters out resource
>>>>>>>>>>>>>>> with IORESOURCE_UNSET.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Resources that do not reside within their bridge window, however, are
>>>>>>>>>>>>>>> not properly initialized with IORESOURCE_UNSET resulting in bogus
>>>>>>>>>>>>>>> conflicts detected in quirk_system_pci_resources():
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
>>>>>>>>>>>>>>> pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: contains BAR 2 for 7 VFs
>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>> pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x1ffffffff 64bit pref]
>>>>>>>>>>>>>>> pci 0000:03:00.0: VF BAR 2 [mem 0x00000000-0x3dffffffff 64bit pref]: contains BAR 2 for 31 VFs
>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>>> pnp 00:04: disabling [mem 0xfc000000-0xfc00ffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
>>>>>>>>>>>>>>> pnp 00:05: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
>>>>>>>>>>>>>>> pnp 00:05: disabling [mem 0xfedc0000-0xfedc7fff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
>>>>>>>>>>>>>>> pnp 00:05: disabling [mem 0xfeda0000-0xfeda0fff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
>>>>>>>>>>>>>>> pnp 00:05: disabling [mem 0xfeda1000-0xfeda1fff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
>>>>>>>>>>>>>>> pnp 00:05: disabling [mem 0xc0000000-0xcfffffff disabled] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
>>>>>>>>>>>>>>> pnp 00:05: disabling [mem 0xfed20000-0xfed7ffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
>>>>>>>>>>>>>>> pnp 00:05: disabling [mem 0xfed90000-0xfed93fff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
>>>>>>>>>>>>>>> pnp 00:05: disabling [mem 0xfed45000-0xfed8ffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
>>>>>>>>>>>>>>> pnp 00:05: disabling [mem 0xfee00000-0xfeefffff] because it overlaps 0000:03:00.0 BAR 9 [mem 0x00000000-0x3dffffffff 64bit pref]
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Mark resources that are not contained within their bridge window with
>>>>>>>>>>>>>>> IORESOURCE_UNSET in __pci_read_base() which resolves the false
>>>>>>>>>>>>>>> positives for the overlap check in quirk_system_pci_resources().
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Fixes: f7834c092c42 ("PNP: Don't check for overlaps with unassigned PCI BARs")
>>>>>>>>>>>>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks for your patch, which is now commit 06b77d5647a4d6a7 ("PCI:
>>>>>>>>>>>>>> Mark resources IORESOURCE_UNSET when outside bridge windows") in
>>>>>>>>>>>>>> linux-next/master next-20250929 pci/next
>>>>>>>>>>>>
>>>>>>>>>>>>>> This replaces the actual resources by their sizes in the boot log on
>>>>>>>>>>>>>> e.g. on R-Car M2-W:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>       pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
>>>>>>>>>>>>>>       pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff -> 0x00ee080000
>>>>>>>>>>>>>>       pci-rcar-gen2 ee090000.pci: PCI: revision 11
>>>>>>>>>>>>>>       pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>>>>>>>>>>>>>>       pci_bus 0000:00: root bus resource [bus 00]
>>>>>>>>>>>>>>       pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
>>>>>>>>>>>>>>       pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional PCI endpoint
>>>>>>>>>>>>>>      -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
>>>>>>>>>>>>>>      -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]
>>>>>>>>>>>>>
>>>>>>>>>>>>> What is going to be the parent of these resources? They don't seem to fall
>>>>>>>>>>>>> under the root bus resource above in which case the output change is
>>>>>>>>>>>>> intentional so they don't appear as if address range would be "okay".
>>>>>>>>>>>>
>>>>>>>>>>>> >From /proc/iomem:
>>>>>>>>>>>>
>>>>>>>>>>>>      ee080000-ee08ffff : pci@ee090000
>>>>>>>>>>>>        ee080000-ee080fff : 0000:00:01.0
>>>>>>>>>>>>          ee080000-ee080fff : ohci_hcd
>>>>>>>>>>>>        ee081000-ee0810ff : 0000:00:02.0
>>>>>>>>>>>>          ee081000-ee0810ff : ehci_hcd
>>>>>>>>>>>>      ee090000-ee090bff : ee090000.pci pci@ee090000
>>>>>>>>>>>
>>>>>>>>>>> Okay, so this seem to appear in the resource tree but not among the root
>>>>>>>>>>> bus resources.
>>>>>>>>>>>
>>>>>>>>>>>>      ee0c0000-ee0cffff : pci@ee0d0000
>>>>>>>>>>>>        ee0c0000-ee0c0fff : 0001:01:01.0
>>>>>>>>>>>>          ee0c0000-ee0c0fff : ohci_hcd
>>>>>>>>>>>>        ee0c1000-ee0c10ff : 0001:01:02.0
>>>>>>>>>>>>          ee0c1000-ee0c10ff : ehci_hcd
>>>>>>>>>>>>
>>>>>>>>>>>>> When IORESOURCE_UNSET is set in a resource, %pR does not print the start
>>>>>>>>>>>>> and end addresses.
>>>>>>>>>>>>
>>>>>>>>>>>> Yeah, that's how I found this commit, without bisecting ;-)
>>>>>>>>>>>>
>>>>>>>>>>>>>>      +pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
>>>>>>>>>>>>>>      +pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
>>>>>>>>>>>>>>       pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional PCI endpoint
>>>>>>>>>>>>>>      -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]
>>>>>>>>>>>>>>      +pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
>>>>>>>>>>>>>
>>>>>>>>>>>>> For this resource, it's very much intentional. It's a zero-based BAR which
>>>>>>>>>>>>> was left without IORESOURCE_UNSET prior to my patch leading to others part
>>>>>>>>>>>>> of the kernel to think that resource range valid and in use (in your
>>>>>>>>>>>>> case it's so small it wouldn't collide with anything but it wasn't
>>>>>>>>>>>>> properly set up resource, nonetheless).
>>>>>>>>>>>>>
>>>>>>>>>>>>>>       pci 0000:00:01.0: supports D1 D2
>>>>>>>>>>>>>>       pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
>>>>>>>>>>>>>>       pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional PCI endpoint
>>>>>>>>>>>>>>      -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]
>>>>>>>>>>>>>>      +pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
>>>>>>>>>>>>>
>>>>>>>>>>>>> And this as well is very much intentional.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>       pci 0000:00:02.0: supports D1 D2
>>>>>>>>>>>>>>       pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
>>>>>>>>>>>>>>       PCI: bus0: Fast back to back transfers disabled
>>>>>>>>>>>>>>       pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
>>>>>>>>>>>>>>       pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
>>>>>>>>>>>>>>       pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Is that intentional?
>>>>>>>>>>>>>
>>>>>>>>>>>>> There's also that pci_dbg() in the patch which would show the original
>>>>>>>>>>>>> addresses (print the resource before setting IORESOURCE_UNSET) but to see
>>>>>>>>>>>>> it one would need to enable it with dyndbg=... Bjorn was thinking of
>>>>>>>>>>>>> making that pci_info() though so it would appear always.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Was this the entire PCI related diff? I don't see those 0000:00:00.0 BARs
>>>>>>>>>>>>> getting assigned anywhere.
>>>>>>>>>>>>
>>>>>>>>>>>> The above log is almost complete (lacked enabling the device afterwards).
>>>>>>>>>>>>
>>>>>>>>>>>> AFAIU, the BARs come from the reg and ranges properties in the
>>>>>>>>>>>> PCI controller nodes;
>>>>>>>>>>>> https://elixir.bootlin.com/linux/v6.17/source/arch/arm/boot/dts/renesas/r8a7791.dtsi#L1562
>>>>>>>>>>>
>>>>>>>>>>> Thanks, although I had already found this line by grep. I was just
>>>>>>>>>>> expecting the address appear among root bus resources too.
>>>>>>>>>>>
>>>>>>>>>>> Curiously enough, pci_register_host_bridge() seems to try to add some
>>>>>>>>>>> resource from that list into bus and it's what prints those "root bus
>>>>>>>>>>> resource" lines and ee090000 is not among the printed lines despite
>>>>>>>>>>> appearing in /proc/iomem. As is, the resource tree and PCI bus view on the
>>>>>>>>>>> resources seems to be in disagreement and I'm not sure what to make of it.
>>>>>>>>>>>
>>>>>>>>>>> But before considering going into that direction or figuring out why this
>>>>>>>>>>> ee090000 resource does not appear among root bus resources, could you
>>>>>>>>>>> check if the attached patch changes behavior for the resource which are
>>>>>>>>>>> non-zero based?
>>>>>>>>>>
>>>>>>>>>> This patch has no impact on dmesg, lspci output, or /proc/iomem
>>>>>>>>>> for pci-rcar-gen2.
>>>>>>>>>
>>>>>>>>> It would have been too easy... :-(
>>>>>>>>>
>>>>>>>>> I'm sorry I don't really know these platform well and I'm currently trying
>>>>>>>>> to understand what adds that ee090000 resource into the resource tree
>>>>>>>>> and so far I've not been very successful.
>>>>>>>>>
>>>>>>>>> Perhaps it would be easiest to print a stacktrace when the resource is
>>>>>>>>> added but there are many possible functions. I think all of them
>>>>>>>>> converge in __request_resource() so I suggest adding:
>>>>>>>>>
>>>>>>>>> WARN_ON(new->start == 0xee090000);
>>>>>>>>>
>>>>>>>>> before __request_resource() does anything.
>>>>>>>>
>>>>>>>>      Call trace:
>>>>>>>>       unwind_backtrace from show_stack+0x10/0x14
>>>>>>>>       show_stack from dump_stack_lvl+0x7c/0xb0
>>>>>>>>       dump_stack_lvl from __warn+0x80/0x198
>>>>>>>>       __warn from warn_slowpath_fmt+0xc0/0x124
>>>>>>>>       warn_slowpath_fmt from __request_resource+0x38/0xc8
>>>>>>>>       __request_resource from __request_region+0xc4/0x1e8
>>>>>>>>       __request_region from __devm_request_region+0x80/0xac
>>>>>>>>       __devm_request_region from __devm_ioremap_resource+0xcc/0x160
>>>>>>>>       __devm_ioremap_resource from rcar_pci_probe+0x58/0x350
>>>>>>>>       rcar_pci_probe from platform_probe+0x58/0x90
>>>>>>>>
>>>>>>>> I.e. the call to devm_platform_get_and_ioremap_resource() in
>>>>>>>> drivers/pci/controller/pci-rcar-gen2.c:rcar_pci_probe().
>>>>>>>
>>>>>>> Thanks, the patch below might help BAR0 (but I'm not sure if it's the
>>>>>>> correct solution due to being so unfamiliar with these kind of platforms
>>>>>>> and how they're initialized).
>>>>>>
>>>>>> Thanks, that has the following impact on dmesg:
>>>>>>
>>>>>>       pci-rcar-gen2 ee090000.pci: PCI: revision 11
>>>>>>       pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>>>>>>       pci_bus 0000:00: root bus resource [bus 00]
>>>>>>      -pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
>>>>>>      +pci_bus 0000:00: root bus resource [mem 0xee080000-0xee090bff]
>>>>>>       pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
>>>>>> PCI endpoint
>>>>>>      -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial
>>>>>> claim (no window)
>>>>>>      -pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
>>>>>>      -pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
>>>>>> initial claim (no window)
>>>>>>      +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
>>>>>>       pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
>>>>>>       pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
>>>>>> PCI endpoint
>>>>>>      -pci 0000:00:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial
>>>>>> claim (no window)
>>>>>>       pci 0000:00:01.0: BAR 0 [mem size 0x00001000]
>>>>>>       pci 0000:00:01.0: supports D1 D2
>>>>>>       pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
>>>>>>       pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320 conventional
>>>>>> PCI endpoint
>>>>>>      -pci 0000:00:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial
>>>>>> claim (no window)
>>>>>
>>>>> Did you e.g. forget to change pci_dbg() to pci_info() as these all went
>>>>> away, I cannot see why it should disappear because of my patch?
>>>>>
>>>>> (No need to apologize if that was the case, just confirming if that
>>>>> explains it is enough. :-))
>>>>
>>>> I indeed dropped that change. Adding it back...
>>>>
>>>>>>       pci 0000:00:02.0: BAR 0 [mem size 0x00000100]
>>>>>>       pci 0000:00:02.0: supports D1 D2
>>>>>>       pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
>>>>>>       PCI: bus0: Fast back to back transfers disabled
>>>>>>       pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
>>>>>>       pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
>>>>>
>>>>> Perhaps print here what's the parent resource of these resource.
>>>>
>>>> pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned (parent
>>>> [mem 0xee080000-0xee08ffff])
>>>> pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned (parent
>>>> [mem 0xee080000-0xee08ffff])
>>>
>>> Were these from a kernel without the problematic commit at all or with the
>>> problematic commit and my fix? They look like the former case. The full
>>> /proc/iomem also shows all the parent resources I think.
>>
>> With commit 06b77d5647a4d6a7 ("PCI: Mark resources IORESOURCE_UNSET when
>> outside bridge windows"), but without adding
>> "pci_add_resource(&bridge->windows, cfg_res);" in .probe().
>>
>>>>>>      -pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
>>>>>>      +pci_bus 0000:00: resource 4 [mem 0xee080000-0xee090bff]
>>>>>>       pci-rcar-gen2 ee0d0000.pci: adding to PM domain always-on
>>>>>>       PM: genpd_add_device: Add ee0d0000.pci to always-on
>>>>>>       pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 ranges:
>>>>>>      @@ -414,26 +416,22 @@ PM: ==== always-on/ee0d0000.pci: start
>>>>>>       pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
>>>>>>       pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
>>>>>>       pci_bus 0001:01: root bus resource [bus 01]
>>>>>>      -pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cffff]
>>>>>>      +pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0d0bff]
>>>>>>       pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conventional PCI endpoint
>>>>>>      -pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]: no initial claim (no window)
>>>>>>      -pci 0001:01:00.0: BAR 0 [mem size 0x00000400]
>>>>>>      -pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no initial claim (no window)
>>>>>>      +pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
>>>>>>       pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
>>>>>>       pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310 conventional PCI endpoint
>>>>>>      -pci 0001:01:01.0: BAR 0 [mem 0x00000000-0x00000fff]: no initial claim (no window)
>>>>>>       pci 0001:01:01.0: BAR 0 [mem size 0x00001000]
>>>>>>       pci 0001:01:01.0: supports D1 D2
>>>>>>       pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
>>>>>>       pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320 conventional PCI endpoint
>>>>>>      -pci 0001:01:02.0: BAR 0 [mem 0x00000000-0x000000ff]: no initial claim (no window)
>>>>>>       pci 0001:01:02.0: BAR 0 [mem size 0x00000100]
>>>>>>       pci 0001:01:02.0: supports D1 D2
>>>>>>       pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
>>>>>>       PCI: bus1: Fast back to back transfers disabled
>>>>>>       pci 0001:01:01.0: BAR 0 [mem 0xee0c0000-0xee0c0fff]: assigned
>>>>>>       pci 0001:01:02.0: BAR 0 [mem 0xee0c1000-0xee0c10ff]: assigned
>>>>>>      -pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0cffff]
>>>>>>      +pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0d0bff]
>>>>>>       rcar-pcie fe000000.pcie: adding to PM domain always-on
>>>>>>       PM: genpd_add_device: Add fe000000.pcie to always-on
>>>>>>       rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
>>>>>>
>>>>>> and on /proc/iomem (I used "diff -w" to reduce clutter):
>>>>>>
>>>>>>       ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec700000
>>>>>>       ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec720000
>>>>>>       ec740000-ec7401ff : ec500000.sound audmapp
>>>>>>      -ee080000-ee08ffff : pci@ee090000
>>>>>
>>>>> So what did add this previous? (Maybe use the same WARN_ON() trick as
>>>>> previously to find out.)
>>>>
>>>> First call:
>>>>
>>>>      + __request_resource from request_resource_conflict+0x24/0x3c
>>>>      + request_resource_conflict from devm_request_resource+0x48/0x9c
>>>>      + devm_request_resource from devm_request_pci_bus_resources+0x5c/0x70
>>>>      + devm_request_pci_bus_resources from devm_of_pci_bridge_init+0x7c/0x1c0
>>>>      + devm_of_pci_bridge_init from devm_pci_alloc_host_bridge+0x44/0x6c
>>>>      + devm_pci_alloc_host_bridge from rcar_pci_probe+0x34/0x384
>>>>      + rcar_pci_probe from platform_probe+0x58/0x90
>>>
>>> Thanks. So this is the call of interest, the rest are just the childs of
>>> it with the same address.
>>>
>>> I'm looking devm_of_pci_get_host_bridge_resources(), it seems to read
>>> "ranges" property but not "reg" at all.
>>>
>>> I wonder if devm_of_pci_get_host_bridge_resources() should also loop
>>> through "reg" addresses and add those to host resources which are outside
>>> of the "ranges"? Or if there should be a "range" that covers all what's
>>> in "reg" to get them added into host bridge resources? That would seem the
>>> generic solution instead of trying to do this in rcar_pci_probe().
>>>
>>> (Perhaps these are stupid questions, please excuse my lack of knowledge
>>> about OF things.)
>>>
>>> While looking at another issue report, I also notice of_pci_prop_ranges()
>>> assumes there are only bridge windows or BARs, but not both (not sure if
>>> this relates to anything, just an observation while reading these code
>>> paths).
>>
>> We still have Rob in CC...
> 
> While we wait, can you simply try to make the "ranges" large enough to fit
> the BAR0 too?
> 
> I think it will results in making the larger "ranges" entry the parent of
> ee090000-ee090bff : ee090000.pci pci@ee090000 entry in the resource tree
> which would also avoid the coalescing issue.
> 
> Again, I'm not entirely sure if that would be an acceptable solution.
> 
>>>> Second call:
>>>>
>>>>      + __request_resource from allocate_resource+0x1b8/0x1d4
>>>>      + allocate_resource from pci_bus_alloc_from_region+0x1e0/0x220
>>>>      + pci_bus_alloc_from_region from pci_bus_alloc_resource+0x84/0xb8
>>>>      + pci_bus_alloc_resource from _pci_assign_resource+0x78/0x150
>>>>      + _pci_assign_resource from pci_assign_resource+0x10c/0x310
>>>>      + pci_assign_resource from assign_requested_resources_sorted+0x78/0xac
>>>>      + assign_requested_resources_sorted from
>>>> __assign_resources_sorted+0x74/0x5c4
>>>>      + __assign_resources_sorted from __pci_bus_assign_resources+0x50/0x1f0
>>>>      + __pci_bus_assign_resources from
>>>> pci_assign_unassigned_root_bus_resources+0xa8/0x190
>>>>      + pci_assign_unassigned_root_bus_resources from pci_host_probe+0x5c/0xb0
>>>>      + pci_host_probe from rcar_pci_probe+0x2e0/0x384
>>>>      + rcar_pci_probe from platform_probe+0x58/0x90
>>>>
>>>> Third call:
>>>>
>>>>      + __request_resource from __request_region+0xc4/0x1e8
>>>>      + __request_region from __devm_request_region+0x80/0xac
>>>>      + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
>>>>      + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
>>>>      + pci_device_probe from really_probe+0x128/0x28c
>>>>
>>>> Fourth call:
>>>>
>>>>      + __request_region from __devm_request_region+0x80/0xac
>>>>      + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
>>>>      + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
>>>>      + pci_device_probe from really_probe+0x128/0x28c
>>>>
>>>> Fifth call:
>>>>
>>>>      + __request_region from __devm_request_region+0x80/0xac
>>>>      + __devm_request_region from usb_hcd_pci_probe+0x15c/0x35c
>>>>      + usb_hcd_pci_probe from pci_device_probe+0x94/0x104
>>>>      + pci_device_probe from really_probe+0x128/0x28c
>>>>
>>>>> It might have gotten broken because the coalesed resource
>>>>> ee080000-ee090bff overlaps with that other resource in the resource tree.
>>>>> But I don't see anything to that effect in the log so it's either silent
>>>>> failure or there's much filtered from the log.
>>>>>
>>>>>>      -  ee080000-ee080fff : 0000:00:01.0
>>>>>>           ee080000-ee080fff : ohci_hcd
>>>>>>      -  ee081000-ee0810ff : 0000:00:02.0
>>>>>>           ee081000-ee0810ff : ehci_hcd
>>>>>>       ee090000-ee090bff : ee090000.pci pci@ee090000
>>>>>>      -ee0c0000-ee0cffff : pci@ee0d0000
>>>>>>      -  ee0c0000-ee0c0fff : 0001:01:01.0
>>>>>>           ee0c0000-ee0c0fff : ohci_hcd
>>>>>>      -  ee0c1000-ee0c10ff : 0001:01:02.0
>>>>>>           ee0c1000-ee0c10ff : ehci_hcd
>>>>>>       ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000
>>>>>>       ee100000-ee100327 : ee100000.mmc mmc@ee100000
>>>>>>
>>>>>> Removing the pci@ee0x0000 and 000x:0x:0x.0 entries doesn't look
>>>>>> right to me? Or am I missing something?
>>>>>
>>>>> I cannot understand this output, these resources seem to have been now
>>>>> left without a parent and due to -w I don't know what's their real
>>>>> indentation level.
>>>>
>>>> The *_hcd resources are now at the top level.
>>>>
>>>>       ec700000-ec70ffff : ec700000.dma-controller dma-controller@ec700000
>>>>       ec720000-ec72ffff : ec720000.dma-controller dma-controller@ec720000
>>>>       ec740000-ec7401ff : ec500000.sound audmapp
>>>>      -ee080000-ee08ffff : pci@ee090000
>>>>      -  ee080000-ee080fff : 0000:00:01.0
>>>>      -    ee080000-ee080fff : ohci_hcd
>>>>      -  ee081000-ee0810ff : 0000:00:02.0
>>>>      -    ee081000-ee0810ff : ehci_hcd
>>>>      +ee080000-ee080fff : ohci_hcd
>>>>      +ee081000-ee0810ff : ehci_hcd
>>>>       ee090000-ee090bff : ee090000.pci pci@ee090000
>>>>      -ee0c0000-ee0cffff : pci@ee0d0000
>>>>      -  ee0c0000-ee0c0fff : 0001:01:01.0
>>>>      -    ee0c0000-ee0c0fff : ohci_hcd
>>>>      -  ee0c1000-ee0c10ff : 0001:01:02.0
>>>>      -    ee0c1000-ee0c10ff : ehci_hcd
>>>>      +ee0c0000-ee0c0fff : ohci_hcd
>>>>      +ee0c1000-ee0c10ff : ehci_hcd
>>>>       ee0d0000-ee0d0bff : ee0d0000.pci pci@ee0d0000
>>>>       ee100000-ee100327 : ee100000.mmc mmc@ee100000
>>>>       ee140000-ee1400ff : ee140000.mmc mmc@ee140000
>>>>
>>>> I assume the others are gone because they now conflict with the *_hcd
>>>> resources at the top level.
>>>
>>> Like you initially assumed, it is wrong (while it works as the resources
>>> themselves don't care that much about their parent they're under as long
>>> as the resource is assigned, it's still not intended to be that way).
>>>
>>> It might be worth to see if the coalescing in pci_register_host_bridge()
>>> somehow messes these resources up either by not doing the coalesing loop
>>> at all or by adding:
>>>
>>>                  if (res->parent || next_res->parent) {
>>>                          if (res->parent)
>>>                                  pr_info("Has parent %pR\n", res);
>>>                          if (next_res->parent)
>>>                                  pr_info("Has parent %pR\n", next_res);
>>>                          continue;
>>>                  }
>>>
>>> ...into the coalescing loop in case one of them happens to have a parent
>>> (this is to be tested with the rcar_probe() fix).
>>
>> The above restores the missing entries in /proc/iomem.
>> Changes to dmesg:
>>
>>       pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
>>       pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff
>> -> 0x00ee080000
>>       pci-rcar-gen2 ee090000.pci: PCI: revision 11
>>       pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>>      +Has parent [mem 0xee080000-0xee08ffff]
>>       pci_bus 0000:00: root bus resource [bus 00]
>>       pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
>>      +pci_bus 0000:00: root bus resource [mem 0xee090000-0xee090bff]
>>       pci 0000:00:00.0: [1033:0000] type 00 class 0x060000 conventional
>> PCI endpoint
>>      -pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]: no initial
>> claim (no window)
>>      -pci 0000:00:00.0: BAR 0 [mem size 0x00000400]
>>      +pci 0000:00:00.0: BAR 0 [mem 0xee090800-0xee090bff]
>>       pci 0000:00:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
>> initial claim (no window)
>>       pci 0000:00:00.0: BAR 1 [mem size 0x40000000 pref]
>>       pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310 conventional
>> PCI endpoint
>>      @@ -403,21 +397,24 @@ pci 0000:00:02.0: BAR 0 [mem size 0x0000
>>       pci 0000:00:02.0: supports D1 D2
>>       pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
>>       PCI: bus0: Fast back to back transfers disabled
>>       pci 0000:00:01.0: BAR 0 [mem 0xee080000-0xee080fff]: assigned
>>       pci 0000:00:02.0: BAR 0 [mem 0xee081000-0xee0810ff]: assigned
>>       pci_bus 0000:00: resource 4 [mem 0xee080000-0xee08ffff]
>>      +pci_bus 0000:00: resource 5 [mem 0xee090000-0xee090bff]
>>       pci-rcar-gen2 ee0d0000.pci: adding to PM domain always-on
>>       pci-rcar-gen2 ee0d0000.pci: host bridge /soc/pci@ee0d0000 ranges:
>>       pci-rcar-gen2 ee0d0000.pci:      MEM 0x00ee0c0000..0x00ee0cffff
>> -> 0x00ee0c0000
>>       pci-rcar-gen2 ee0d0000.pci: PCI: revision 11
>>       pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
>>      +Has parent [mem 0xee0c0000-0xee0cffff]
> 
> So this ended up locating another bug in the coalescing loop.
> 
> It's very dangerous to mess with resources like that as the backing
> struct resource is shared with whatever added that resource, which is
> different sites in this case.
> 
> I'm preparing a better approach to do the resource merge, however, I'm
> left unsure if the clean up of everything will happen "correctly" as this
> coalescing is removing resources from the resource tree which were added
> there by something else so it's then becomes very muddy who is responsible
> for releasing it in the end.

So what about a helper function pci_try_contiguous_apertures() to allocate 
across resources when single resource isn't large enough?

Anyway, I am happy to try your new approach.

Kai-Heng

> 
>>       pci_bus 0001:01: root bus resource [bus 01]
>>       pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0cffff]
>>      +pci_bus 0001:01: root bus resource [mem 0xee0d0000-0xee0d0bff]
>>       pci 0001:01:00.0: [1033:0000] type 00 class 0x060000 conventional
>> PCI endpoint
>>      -pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]: no initial
>> claim (no window)
>>      -pci 0001:01:00.0: BAR 0 [mem size 0x00000400]
>>      +pci 0001:01:00.0: BAR 0 [mem 0xee0d0800-0xee0d0bff]
>>       pci 0001:01:00.0: BAR 1 [mem 0x40000000-0x7fffffff pref]: no
>> initial claim (no window)
>>       pci 0001:01:00.0: BAR 1 [mem size 0x40000000 pref]
>>       pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310 conventional
>> PCI endpoint
>>      @@ -431,9 +428,10 @@ pci 0001:01:02.0: BAR 0 [mem size 0x0000
>>       pci 0001:01:02.0: supports D1 D2
>>       pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
>>       PCI: bus1: Fast back to back transfers disabled
>>       pci 0001:01:01.0: BAR 0 [mem 0xee0c0000-0xee0c0fff]: assigned
>>       pci 0001:01:02.0: BAR 0 [mem 0xee0c1000-0xee0c10ff]: assigned
>>       pci_bus 0001:01: resource 4 [mem 0xee0c0000-0xee0cffff]
>>      +pci_bus 0001:01: resource 5 [mem 0xee0d0000-0xee0d0bff]
>>
>>>>>>> If this works, we'll also have to decide what to do with the BAR1 (it
>>>>>>> didn't appear in your (partial?) /proc/iomem quote so I'm left unsure how
>>>>>>> to approach it).
>>>>>>
>>>>>> That is indeed not visible in /proc/iomem.
>>>>>
>>>>> I meant before the commit 06b77d5647a4d6a7 ("PCI Mark resources
>>>>> IORESOURCE_UNSET when outside bridge windows"), was it present?
>>>>
>>>> No, it was not present.
>>>>
>>>>>> I tried the following (whitespace-damaged):
>>>>>>
>>>>>> --- a/drivers/pci/controller/pci-rcar-gen2.c
>>>>>> +++ b/drivers/pci/controller/pci-rcar-gen2.c
>>>>>> @@ -179,6 +179,7 @@ static void rcar_pci_setup(struct rcar_pci *priv)
>>>>>>          unsigned long window_size;
>>>>>>          unsigned long window_addr;
>>>>>>          unsigned long window_pci;
>>>>>> +       struct resource res;
>>>>>>          u32 val;
>>>>>>
>>>>>>          entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
>>>>>> @@ -191,6 +192,8 @@ static void rcar_pci_setup(struct rcar_pci *priv)
>>>>>>                  window_pci = entry->res->start - entry->offset;
>>>>>>                  window_size = resource_size(entry->res);
>>>>>>          }
>>>>>> +       resource_set_range(&res, window_addr, window_size);
>>>>>
>>>>> You need to set flags properly too as this now tried to insert BUS, not
>>>>> MEM resource (DEFINE_RES() might be the more appropriate in that case
>>>>> anyway).
>>>>>
>>>>> However, if there's not &bridge->dma_ranges ranges entry, rcar_pci_setup()
>>>>> seems to initialize the resource to 0x40000000-0x7fffffff and I'm not sure
>>>>
>>>> I guess the not &bridge->dma_ranges case dates back to the time the
>>>> DTS didn't have dma-ranges yet.  However, upon closer look, the DTS
>>>> still doesn't have dma_ranges, thus always using the default.
>>>>
>>>>> how it's supposed to work if there's more than one of these devices as per
>>>>> the log above.
>>>>
>>>> Upon closer look, this is not a resource of the device, but an inbound
>>>> memory region.  Hence there is no issue if multiple devices use the
>>>> same region.
>>>>
>>>>>
>>>>>> +       pci_add_resource(&bridge->windows, &res);
>>>>>
>>>>> What would be the backing resource in the resource tree for this? I'm not
>>>>> sure if pci_add_resource() is going to result in adding one into the
>>>>> resource tree.
>>>>
>>>> Likewise, it should not appear in /proc/ioem.
>>>
>>> Thanks for checking it out.
>>>
>>> I wonder how it would be supposed to work if PCI resource fitting logic
>>> finds place for it and changes its address. I don't think it would ever
>>> happen because it should never fit...
>>>
>>> ...But the logic still is a bit fishy if rcar2 code expects that address
>>> to be fixed but doesn't flag the resource to have a fixed address.
>>
>> How can the PCI resource fitting logic change it? It is an inbound
>> memory region, not a normal BAR?
> 
> I thought it can happen because it appears as BAR1, all resources from
> BARs are eligible for the normal assignment but now that I think it more,
> the underlying struct resource is going different for that BAR1 and the
> actual dma_ranges entry.
> 
> --
>   i.


