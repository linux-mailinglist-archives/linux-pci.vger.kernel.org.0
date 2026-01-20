Return-Path: <linux-pci+bounces-45288-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEl6JL7Ib2mgMQAAu9opvQ
	(envelope-from <linux-pci+bounces-45288-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:26:06 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3654F496B3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 233468087CC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2EC315D22;
	Tue, 20 Jan 2026 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NEdz+SQu"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4A3E95B5;
	Tue, 20 Jan 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927279; cv=fail; b=A9l3rkQ9L3apR3jO+8d5D5ju7SLJTXMJ3wCY9FyveWF23dIqeiOpO9Ij7KeLm5SgXDpD34eguTqZc1kUE3w58qrGp4GShB3z/7yoB/DVD13HZfIEDMMNzsvRtTHQo9NL/QpaA44ttxH3E0zuHQsqTBZh2GSpuO7V3DTRwtoZTWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927279; c=relaxed/simple;
	bh=rVplmDL5JIEko9YyRNo639caoKoIzjy0/1DiSvrOL8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jQsrPO9MF0AdJaqUbAj41psbO0mc8JYGtcYLiBz62EHysUFHuEUZ2d3l5ggv5vHvSajXFa9gWMd97pfRVINXy02c5zq02r0npp1xuKFe/0xtY0krA+moP5sE/IYRgUo+/b0GhTAaqYrgT/fWxCuPSjtrqrPLReuGESDz6eAF2+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NEdz+SQu; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbKsq9F+93uWshkKEw9Q8E1YhuiPS+abNUlvjHp0fY8E8w4Hi1Fcac/YSBc2hra645P2Ec0S+M4fGjDcOwmhDvOpN58AlagPWktciTobR5WEF5o6x30dmT5jC7ekxT6PGBppnbCTbl4dxMCwSIBbLOfA3RZR5ytEsrjtaq7KiCd6faistnSf6o7LSFjDKURI8ekzk18E7UPFhZWYfYsdpriH2iktSRFIqYMadaS0kXWIPCwZvfwN+EHOPgum3GZ12kTDKqsZ/pJ/3EPv2p/Bx0KhFZcRNhglMGPlYcTd6x+b6Dzlsrz4WN/yqc4lLDGvA+dua9yd8CPGU+BMs74kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP1JOE/ga4Bp5UmgToUB2XnU/O6l85iybwojJhnQAhg=;
 b=CjL/LR62Xpce1G407v5tQV6q35mcmIUzBjeZpveiDnv4g6/nBj0BZpHe8yV2HKyNZFyRAWfCyBUuThguH2NEpNCqbf+u8Y+P+Q5bUePR8p2npgRXsKt9za/DPOEuHFaCvfazH5jkpe073mzq3j+4NwJga6j+EX/tJkUs0PiR0M9MAZzr2bt0PvZKKq3wNIwL5/hvL775DzpEanI2V9cbVH3SG9wzcH2a6vmG0FwZWMvRsSah/vN26cKF5q7HCBZfs0oMlmRgMMXrSehUU5QwzT0wapxc22h/eRQoSlTNpcvqx7cXcKqxXYiH8SB/YSMwL/JClk693OEibyjjt5G9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OP1JOE/ga4Bp5UmgToUB2XnU/O6l85iybwojJhnQAhg=;
 b=NEdz+SQuXETuBuuV5mUyQUqRxKMG8BGInpsf+T0UsrbI/tkcqpt7aM2s2RUCGscNyDNW67kIW3mOAJxYAvUXHOl3eP5D1Wl4pf6qbMiIXlVtJryKlhB0YrmXaazGITruQHMhHK+Ykav5H+Owa20Xx2TrDrQx8GxUUM940u5R+lH3+a30z7iVFT6m7pTsj/d2u5jVWaMbTmAOv1OMKwJEyy4QxUcZGFEXlM7oseN3qLRBSerd1NOhJAdy4RVmeh0qhJLD8uQXqYFf3WXT3CFFBJoLe/Cj4jS5AISS9sdkm734PB+/5qZZpIAoaTQlXDTjQkwE/HEKjmgMVDutaQeUxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 16:41:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 16:41:13 +0000
Date: Tue, 20 Jan 2026 12:41:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: bhelgaas@google.com, akpm@linux-foundation.org, bp@alien8.de,
	rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] PCI: Add support for ACS Enhanced Capability
Message-ID: <20260120164112.GD1134360@nvidia.com>
References: <SI2PR01MB43931A911357962A5E986FFEDC8CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB43931A911357962A5E986FFEDC8CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: BL1P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: b6130edc-761f-449e-e004-08de5842b8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tf2OUkNTiEUhnLRrw5pfAaB/8N6/SC+eviSwUXdUU0oJyP67vZ5CyoFZjdz0?=
 =?us-ascii?Q?GzQxdHkHXWnB+1C9MRaacMKgaUpabrzGt03jDzTlRPL9BidLJiFijH59nf3/?=
 =?us-ascii?Q?cdqQToGUBvyMARLEvLhSdHK+P/Fq3+vJ76uS9mYXVXOYzYaFVEqsscyXHzXn?=
 =?us-ascii?Q?RjujWCeiBv7bq1CCR0RnVkxO3Iwdmf78atiHauf4kf2UyUIxn5saJnIw9NoM?=
 =?us-ascii?Q?IZ5svo/hUTY0Z+lxBrOmp0AYVz5FCisyshUIKRMhH8HFYmX1RJGEb93/VOdc?=
 =?us-ascii?Q?jT30scxJvLEMlnrEf1tYVgUVpuEITAYFbqdc1iHxGW3zSDAstZF7XlRpLYQE?=
 =?us-ascii?Q?6aYstuo7mqQ+AEhqQC7ONPHnV5m+9QQEbNLj3r8kakfyou1U0JizdOjEzh7V?=
 =?us-ascii?Q?AP2FguvOnzsMk/GFNlViBcsqRPUA32dGajEx8bD45mNRcuWe3tfi3P2YlrtL?=
 =?us-ascii?Q?zoYz01TsHLGXi440eDOrs1YflsRsEMGL7tny0u+jWl5QSKnB5Ehjj0xO1D1y?=
 =?us-ascii?Q?BwL9NyjmrC/cgFaIV8nJf+GhOtZRreebI9CVOx7cewwmFMNU4c66AzeijDHo?=
 =?us-ascii?Q?V9tPeUUya5WUTPIAfwDX3ZNTPFkRhrXwyo3w+O0Mdw5K3VNc59yJWu8TbONH?=
 =?us-ascii?Q?jkucsTkQViaRL5TvSmYeoju4FhaR6hPfzvTmd4z1TsSAoGZ7iepZDx3C737k?=
 =?us-ascii?Q?09POdYuMgx4WIUW09nrGJvBmHvJJJQ/YE5GW4L5ArQ5q608fpQgiIJ8tiIPU?=
 =?us-ascii?Q?Ay/pkmtKnnfTd+d1+XjNATIbR/Dwo7WsDl4bAv+lArtVQMBCYCFqsLLKZxgi?=
 =?us-ascii?Q?NReLldvdDuwft2LK9Xkmn726mWib3ewVY4VdJLWgX2FzfeeOSH6IO2W0aOlm?=
 =?us-ascii?Q?6/GZJ8fyZ6Cmbr2OwT1zqQl2lE0kVaXYxUfWWCOM5u9raht/zYqFfaoFkNVM?=
 =?us-ascii?Q?j6zPBzMg3wyt5bz9iJDXRWjl6zMT7UtiF5MoqeRpcUi8sU5CPoTYvGhduzTR?=
 =?us-ascii?Q?zzhC9yVn8lzapbLGz8G0pbWseDW4Y6WGe+cvaKF5Enbh7yO6IbkF5yarav2H?=
 =?us-ascii?Q?Y6Z9I5pMatlmJBVO6zWq8Me1BbV49LkEGJTfmI3RlnX4MPJdl3LOXcd7HJBy?=
 =?us-ascii?Q?QhPfSVA6LSxGOVqx/i1AAQAIVRaa2VGloSX+LPBBLp13ml7rT899RLH6CI9s?=
 =?us-ascii?Q?XbflzGcBVJdiuxPM+SeidUuOSeHtp5NgFRaogzm0xwekAyuaPczXkcJrSPx7?=
 =?us-ascii?Q?kXMKMZIzXbZkDaclMKBC3VV1/cNG/oNJBBQIuqNPqen00xzpOqiktYgINutR?=
 =?us-ascii?Q?QytpIC/gfhLi3mOYvzuATCjfzgfGJABVa5NHr99xaxs5TbtJ9QrJIkiEedR4?=
 =?us-ascii?Q?IwqGksneIRcmXdRi5lITXp7ki5m6oWMcsVteq9FUgg0rr9Tlrg+jMpkXvwu5?=
 =?us-ascii?Q?D3TzPVZE+yagHzUgKPcefepG8pFtHu1UFFU3o8RvAEALGnJJk65PJn1CbRhn?=
 =?us-ascii?Q?feIxPnPFyAV8hs6bgSBDbhBMkQhBNv6AiQo8jGqQCVRbVJRRzA9UTwJUiAIW?=
 =?us-ascii?Q?aLUjrTs0X631C77fLNI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y2XXmVEFvzRRDrux/oUwjRinH0mcFJhtsZ6p2PMv0ZCvZ3jGd8xCi9hC9xWd?=
 =?us-ascii?Q?Km2jw9MORtsgAtHSJ+VmFaZCQqbqla4dfU2IyEUtIdErYo1FH9/JKGHO56f/?=
 =?us-ascii?Q?aLE/N6l3S1alGim0PKVlkVTayC8L/wW1Ydno1laBgEG4f7zw3jhbqJxkGSOF?=
 =?us-ascii?Q?nJdnbaHAX9/69TWOZPVxwaCjhOuZf0TZht1G5qgMqJa4UV9CnenuYrarvEkP?=
 =?us-ascii?Q?zVnhA4YvQemd3+UxxZwLRAX4RiyOY1RC8jyFhibTHuNNjlZGlHDReqesCrTA?=
 =?us-ascii?Q?f/lsMXmcD4V0BsCxg22L/mlV0xHg3EH2YEKDF2E9tET9jTni2Oamlqxe0d8N?=
 =?us-ascii?Q?MHjBzD9PEn3VpFz/W1zoVeAA5Z8roEiuDjeYAyT/js7hl0GUJtYnN/BfpdE4?=
 =?us-ascii?Q?itKEdQ4BF8HQqTBvipi65m7FsuQ1IMxJez9aFXGL4sejiiwlPwcr1aB54b5p?=
 =?us-ascii?Q?DY2W7n545j8q/pUtBXhqUvpzu2iyR/QgM6tFXCchxhKW7gcMoQvimcFAWvk0?=
 =?us-ascii?Q?HO/aKjaghExauRZacqX00rg0FfbCJW9lwDYaAgIblpXtMlWnwKQc5Kzt4V86?=
 =?us-ascii?Q?1z3R8ti0U7IJcYPFQj1r/grnJk/e9afOgVEdXVpTfLgxQOgMpS8ehevPUTPB?=
 =?us-ascii?Q?zQRRe97l/sXnlOJIYu3I+gWPkBWkbelMFaQtfyRcANpkeOUQYoM4CKsrdiw+?=
 =?us-ascii?Q?1Hr8xVCtlwEM9UfV8/EUQ98gUk4tV83QLmLQvGxiVHch2n4Pe3I/MhoL/0yB?=
 =?us-ascii?Q?P6+UMGFdWn7z3h3og+t5yz4JBXTMx1f34se+qWFOUe4Bb2NKyrA44zWb9APD?=
 =?us-ascii?Q?rS1/NpdiudghRvOyPdIKgk3UTW1pxcuUJbmcBslH3SQhGSPha0Sq9GFvUUmw?=
 =?us-ascii?Q?0UCkdHwYkYYUgM/lB55uSl5gCF6tds3Jj12kX2cPSdXUsMXqlbKOFtEoTtcS?=
 =?us-ascii?Q?2yjQwpkaucV/eKUFnMbv2VY9rTNgaUD30di9xI2h5XwUdhQybtzlDmKd5pCI?=
 =?us-ascii?Q?sVxCesbu8IoKrUcbNsB3HMfzRZYBnuEwJpMlI+f7CQoKHimSRwsAOD6qdQrI?=
 =?us-ascii?Q?iD4wqLFNs8j68WuuYSNfYORMQtleN4PYDy+LShq2IVK4Nj0ElpmoaDinIk8g?=
 =?us-ascii?Q?1rzfSQ2bRdKB/a6evWtMahdttS0JvOuNpOLyqee3R9shiPU2xzELCPG+gedU?=
 =?us-ascii?Q?UOGdtgYgmt4gPmKPWlxvbO9qz9dhksqsc2hJosLyIihw+sFEAsmYzjaAXo/S?=
 =?us-ascii?Q?NnTGO/F4+OYp4+ddUgL/jwmYsaRUZpiGsUk8WUAM1SOYvsfHfJWwSHYf8Dyj?=
 =?us-ascii?Q?LxUHs/I3Nx9690YGFlOkyE4zj+eMmqqZOjdTitMPjlyE69r9woYgmuIbF58j?=
 =?us-ascii?Q?TTv5ElRr0D5jz4Mf/FmQqcFSsfY9mvb0U7xuargjLIyWF0LFybDFM8jrRafv?=
 =?us-ascii?Q?ksSMV2s7sPC/owWXhe89fjY19k39h0HxsyvTdoMR+fgTpdVLkhJGlZ5ocTKM?=
 =?us-ascii?Q?CAM9gd3cJYiWnExqBfDqDqncX1EHuorSm22ELLihN+YKn3w/v2QfdjIeK8w/?=
 =?us-ascii?Q?IQvVoN8d9JfSC1C8mqwtzPr05C20bseSK/iv+WcaSxSkcYAbMtqeyA70TNFY?=
 =?us-ascii?Q?FIwWu+Xw3k+lRubpFZVhnRoghbuU4WHKicx2y5Vkle0WUGCdcYxQy/gphjDu?=
 =?us-ascii?Q?2fn0wKJdvjpG4vzOyzUsw5ZXtillNK4xSYS47M5KNLWdxbajD74DCQ7DTMZg?=
 =?us-ascii?Q?Ms6yL1MnaA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6130edc-761f-449e-e004-08de5842b8ef
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 16:41:12.9967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIkQ9gVCKzmyGnbDdk3DyM+M5xnwxv+lx2k3qBgQBl6yJFd18h3XJ4xrF7XbbDQX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-45288-lists,linux-pci=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-pci@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3654F496B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 02:11:30AM +0800, Wei Wang wrote:
> Add support for the ACS (Access Control Services) Enhanced Capability,
> introduced with PCIe Gen 5. These new configuration options can be
> controlled via the config_acs= boot parameter.
> 
> By default, the ACS Unclaimed Request Redirect Control (URRC) bit is
> enabled if supported by the hardware (i.e., if the ACS Enhanced Capability
> is present). This setting is particularly important for device passthrough
> in virtualization scenarios.

The memory target access bits should be set to request redirect as
well. Linux's grouping logic effectively has assumed the enabled behavior
forever.

Jason

