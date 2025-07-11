Return-Path: <linux-pci+bounces-31974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3638BB027B9
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 01:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53F43A566A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C05223714;
	Fri, 11 Jul 2025 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WKw2pUMr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646BA19D07A;
	Fri, 11 Jul 2025 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277209; cv=fail; b=ROGgFy21HPLWMiqsKqS3NFT7HW5ZtWCyt+Y33af8ZJ0gfgz0E4+yanecrVHseT33Szsj99HasTo39DgRPK0nr2tpTBVlMG4qwhXJ2c6aYz2XONlF+6asdu69DKrvHrVClIC/SCI3ANmNShWB4VkYgTC9h+2fjYjEHDhAzPcVGAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277209; c=relaxed/simple;
	bh=RnAFNrDRynnPZ0L5Y3gVR+j0HeOUkWnSCK+QCxPBIjo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GeHljKFtsOjbZ/8bkoXz2gGIVq1IyHm+RGx5vOXp/DQXL2g57sPuGEt6BJB23XCqBoKGTf+FFiFs2kAYnNrotfna5tUhEeE/VeWWIt8zQydyHp83X/AMxrZrCm8pphuxACxZm25917/sz+Z0V+HfkfHro4mbtDhEJ2xEkfHhg9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WKw2pUMr; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOBi0oJNhx90174/C9oPkAvmME7XPLDJzKEtcUJoU5mJ5FGyVdkXy62jzgOkc/ayOqRHRMqruac3i0jC8auBYfodkjEmNvc1wqugZV1lPy+flxAFm5zwoDcgWJ+2Rudyq7dniAWf0C7NGPuBgeu2g4AtvZQRMcn2lNf+983R7Li/IORibm7jrSoHFBpJnosibJhRiM6nCxGFiY8Xo3MCIyKcRBSnc1L8mEpYa8J8MxnXVDUqDZS1xZkXvWxtzEcSLRoJuYfwXxNXdloXFLmg9e9H/nOU90DOCQQ4tVLaWKQ4j3iok0ao0uHwJzxwXt4oevxN+Hfnk8WSo3MYcWWZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBI6TVXXPN/QfijTFIF7DrWTbgW7ZML807tHzYZLSaY=;
 b=r0IFf//qrjAXkH2TkDv2cDC7MuaGXXGMGdnliqlYIbEpktHzvOphVGLqQgEr5Smc+7MErLD4wHZkLEGWAJeBC5bb+0xO5fBDPDbAtbFUMi+RKVQ4pR3aTWVOv3e3Mk4AntMt+zHPP7OWxxwB6OZEwp81duQJp9YL439sslj5kHb1tr8GMRuX8xkM45b1FOHEaRqNuzRs73IoUWGMVi0bHGUZ44/foKVNTha0JjkUbw+QX7BcMPcIMgfG2ErQM9yR0/d8ulA87J7qXxCR7a90a+kNg0eix2j56HfsZrafamfqw9HlUHIJ3dsnP6eCB0i0fdqtsLViBZ9rq1oPyYwOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBI6TVXXPN/QfijTFIF7DrWTbgW7ZML807tHzYZLSaY=;
 b=WKw2pUMrTb2V7gGV+HBIirO/sbpFccRKN/rpcEBnEXWZieD+2Tmg+NTtfYxkRVhYmD0WeKA9qlaTk1CHCGQAy5nyBLWCttFloromJCC0iZmcw5/fpEK3PNfWQLHNcD8SGAC+nbcug6i+kPitiqmA/HQ25Ff4oueKqwTEk05i+9LA5Nh5Rne+4lqVEuZQ3bChRKRMIJDhuj0mAjHlMxQVCd7Ict3kiuw1zr7gDAY49AKx9/7pMQtZ9+JJDiLxy+DFQwMgo/cZBRKrD1SF/awvkats+INX5p1CSbIaqMr+TiTuP6tbE2Cua1ahL6OJnA5OpzKH3JWHGSWgrFELnJvGyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Fri, 11 Jul
 2025 23:40:04 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.8901.018; Fri, 11 Jul 2025
 23:40:03 +0000
Message-ID: <9a71bf2e-0818-4567-81fa-95b1a4173939@nvidia.com>
Date: Fri, 11 Jul 2025 19:40:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rust: dma: add DMA addressing capabilities
To: Danilo Krummrich <dakr@kernel.org>
Cc: abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, a.hindborg@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, bhelgaas@google.com, kwilczynski@kernel.org,
 gregkh@linuxfoundation.org, rafael@kernel.org,
 rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250710194556.62605-1-dakr@kernel.org>
 <20250710194556.62605-3-dakr@kernel.org> <20250711193537.GA935333@joelbox2>
 <DB9HMM5M24FE.1VR5ZE5YJ66CK@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DB9HMM5M24FE.1VR5ZE5YJ66CK@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF00013E0D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:11) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 807968db-820d-4706-5de8-08ddc0d4426f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGtnalVmcmFvZmNjM3I5ZnIzMXp0QnI4VnVDS29BdkFrK3dWRmNTdVl3Q2JF?=
 =?utf-8?B?WGlRb0o4L09kS29RNjM1aWdSVzllREpZVFI1c1VCdWRXQU80clVGWVZLb2dI?=
 =?utf-8?B?ZU5DY2ZWNzZMSHh2aUlXaUhmc1BnSDdVTnViTzhlS3lycmptQUpaeENkNEhs?=
 =?utf-8?B?c3llSjlRTFpnTFlsbjVRdE9sUFQ2Z2I3NlFTUlFJMFhNYjNTb0x4WjYyUjBq?=
 =?utf-8?B?SHVwaSsrMEZHYTl1aWg2NnZvL3U2d3R4Z0xxOEhmQXBwMkwzNWRQRmdwS2Zm?=
 =?utf-8?B?VENrdEFrbnUvQ3MrOXVJRHRYNGZ4L0Ftb1JNMCtiUWdjbmlaa0RRRjZzQzVk?=
 =?utf-8?B?czVXODdFL3E3eFBrYUFWK2wwSkJwd0MzVndHOHh0V096RUZaOGxpeWtlZDNM?=
 =?utf-8?B?QlFYZUY4Nm04QzVlS0FZUG9CZDJYNkVKTWlSU1l3NWZuTHBMWVVmWGhPUzR1?=
 =?utf-8?B?cGNkbHFIWjU3UjRMQlptV3ZsSWJCSUdrRHluT2RyVm16ZmdHclZIczJ1bXZK?=
 =?utf-8?B?T04rUWhrY0dNdXFtYzlBdElEK0ZubGJMZVAzZFFENjZRcUt5RWErZWhQcjhN?=
 =?utf-8?B?RUg2dGZTckxlL01hcllFcVhIREFpampjbk0zYUZ6aHRnL1FZakhsUWhDRHEw?=
 =?utf-8?B?RzRITzRGMW9wZFhFU2lYZHdkd2JKVkR3U0RyRkxDbWw0d0FzTEVnYTFidGVP?=
 =?utf-8?B?TUV6dHZFY08rd3dESmR2Z2UybHNEc09TZ1NGQVpJY3J3d1F4QVQxNktrNllk?=
 =?utf-8?B?UjRKMEMwdHFJRVJicStieU9rMEkxandkQUV0OW8rNFVCRUI0Ym5BeDVWUUdV?=
 =?utf-8?B?U3pad3VsY1YrbDJzdlBFY3NucFh6WFJmcGp5cTAyNHZnMUlOYnR5L3oxdmNI?=
 =?utf-8?B?YTEybGRwQnRCMmpXWTQrWTN0N3NuViswZ1NQdG8wU0xOUXIxM29qajMxZEN0?=
 =?utf-8?B?RC95eUpTeW5KaDRnb1A1N0pvQ2ZRU3FWTVZVQ0ZyK1JQNGJzcG1LYkcxUFZj?=
 =?utf-8?B?TnFZampockxtSUc1TmRQU1pSOTVVUjNDNzMvY0VkLzBnRHpvdWUrUTczaWNI?=
 =?utf-8?B?M2hieU5OSlJJWXFTdnRJK2tVSHh5aHBKOWREZEJsak9tSUpsOVlHdlp6d1RC?=
 =?utf-8?B?Q2pYajZDZlF4dXVvMCtFekM4ZloxY21wZm94RitYeU1OWXcxaWl6MmU4Qkdy?=
 =?utf-8?B?eUNpNUdzR1N5TENhWEhrdVdRU3ZjbllZRDVzbnE3bU1saTlGNlNQb1pqRUQr?=
 =?utf-8?B?VHpSMTlQem9PT290ZzB1Q3F3Q2Z4MzdVemEwMmo2ano0Ymp4VGNUb2xhWFN4?=
 =?utf-8?B?SzhRT3dwdGhNdGNLeUdkczhETVdaMmxKM1Jzb0kxWE1BUStvSE5UWVU3SXJh?=
 =?utf-8?B?VVhHd25PWVFGcmJrNkNzVEF0QzhmQStGWnFub2V5YlEwdXZZRmNVeVNkTTBy?=
 =?utf-8?B?c3F5ZUZoR3l2cHZJZEtqQUZGSkMveVE4c2xPQUxOQ1p2a0hEbG1yN29YT28x?=
 =?utf-8?B?ZzFnQkZwMDg1bUw1cCtheU5aanhBUUFKcEo4NFB1L25oSFpKZkNpU1NRaWxI?=
 =?utf-8?B?Wlo4VEZVSGhaSmc4ZElKM3h0RzQ4cnh2YTM0My9kUjNwSWhUdXRzalNYaTlt?=
 =?utf-8?B?S1h0eVB0MnVxSUZSL1lsUmNsTk1ZQlBJWnREWHhwdm5MK2Nob3hxVzZxNkg3?=
 =?utf-8?B?Wlk2dFBrQWRWLzV0NmIzODVld1JlQjArSnhjYXFwRWRvMWgzZHlTMVRTcFJq?=
 =?utf-8?B?THRZbis2S0dISTFMZk50UWRmZXNYb054NktCV1BKZXRmQ2NHVW83VVZPZHps?=
 =?utf-8?B?ZzNkSExMUmp2WmVxbWxTbGpGWnpXL2NCazFpK2NHUUNMNndlMVpTMmp3ay8w?=
 =?utf-8?B?YTd5a2plZXZiaGJaTlJQdjBCcFdqaGp0WDRxUnhjaVhtYmxWZldaU1Y0VllW?=
 =?utf-8?Q?BZdLZVsUJK0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXdxbUdDZXZyclJhd09qOUpSRGdUdFdKS204ZUhnV25kNDVlM2VqVmdHYTFm?=
 =?utf-8?B?R3RoR0FBVW9RRU9NV2Y4cm93dnZzdHpZdlgzQW1xUUYzMlZtZER3YkFoM1JC?=
 =?utf-8?B?eWdHWlRCc0VUUWJreHZOckdtNDBuVWxRY2ltSXpkcGxuN1krN1lWaVlkUnht?=
 =?utf-8?B?YVhGS3VNenNpMTRiTEFPOUZrUUdjUkpYZjZXYWNvaWdLN3FPVjYra0s0WDVw?=
 =?utf-8?B?V1NrbHc0bUtBQmpSSEI5WWNTWlRCcytnUUNQdGdCVXVwSUVia0pLN2tENy9W?=
 =?utf-8?B?eDc0TXF6aTA5UTVyVnZuUkIveWlDend5V0JEczhKaVFkZE9IRjBESTd5VDJH?=
 =?utf-8?B?bU0ySTVCVHVuWFZOVnJOaEYvM2lZVjlwVG9TRVF3QjRTR0tUNHpUTU5oN1NN?=
 =?utf-8?B?Njg3dkx6anZndFNRMDNJL0N5QjZtWk1RZisrQUZQdlIzT1h6NUpqUFZ5SCs0?=
 =?utf-8?B?RVJnai9JVEljd0pRQWNMOHhRK09ZTkFsSGYvejJQR2tyRmc0Ylk4eUFNZmZH?=
 =?utf-8?B?UDRqNjFtS28zaTFlNnkzT3RFdFB2cm1jMU8xRVJmNGxGV3l0dDVaVjlmM1VB?=
 =?utf-8?B?aFdTY3NLaHNsclp4dm5IdlM5N3c4ZEtjOGdJVlIwM0dSay9EMUxYanUwdWtj?=
 =?utf-8?B?SE9jUDFsbGtmelRhT012SUZJaW16MTdqamR1bWFEdGZOb0t2ck1PeERBN1VF?=
 =?utf-8?B?bnpRMkEyZGhpYmlxT2pSUVp4a3JEVzZLbVRGSjJ0TFpqeHIycGUvbzZEdTdL?=
 =?utf-8?B?TW1qQ2xpSGt4cGF5RWpJNUdWYTNRQzZaeUhrUzhnUkY3TWdoZmI0VXV3U2FO?=
 =?utf-8?B?YmdaV1pMU2oyUW01dWU3dVNOaTUwdHRCOGhMSEZUR1l5cnBESW10TUh6Szlx?=
 =?utf-8?B?MjlUWDhmN2l6RXZ0Q0FrQndpcW1IYVdhdjBmUmFwdkFxOTRUalhqSnYvS25h?=
 =?utf-8?B?bnVTMmgvRzE0V1E2dk94TFlwcXREeWgweU03aitqZTdxckxaMGZacHhuVmJ3?=
 =?utf-8?B?MFA1UmtVNU9aYzRtUzFOSytnTjBYajBwVEZHdUlWNzFOUTVjclE3d1YvVWxU?=
 =?utf-8?B?WWVZSDgvbGVnQW5EVTltZXdHZVhpRElGTHpiYWxDb0ZTRWU4eTJZTWJRZ21r?=
 =?utf-8?B?c2RlbTdWeVBxb1lBRm9WSnhSYkZTZkVwTmRVTlZ0OTUxU0ltMUtjYnozL1Zh?=
 =?utf-8?B?SS9DM1hCRWNpbzEyN0ltV242Q3BPbC9Gd05jZEdvTnF3Q1VKdFhFSUhTM1k4?=
 =?utf-8?B?N3YxSTRIeGRERjdnSjAwQ1l0UE5hK0laQ05haGFiUGdld2I4eVJNTEdaVlJi?=
 =?utf-8?B?b3d3RmpPSzNDUE41ZDBLd2JvSmZUUUpvZExRSFVPQlZOTnpncnVmb3dRb2Q3?=
 =?utf-8?B?VkFxWDFJQ0xyYWQvLzJZamVMT21lWDBtRGQ5SEtPUnlRakZDVDFJY2xPS2Rr?=
 =?utf-8?B?MHRJbWVQekNEZzB1eTNWT25pNVNObjMzK0JFWUtmR0xGcU1mQ2FxSkNSSnZa?=
 =?utf-8?B?WVM5K1lNQm5SK1NvY1dPc2M3eHhqS3pSNERkM3l2ZUFHVjY2eXQwS0R5dEVB?=
 =?utf-8?B?d3BiMk5HcWt4eE1RM1Q2UWI3Rmt5M1dvMkhDNkVTN2o4NUU4R1Z2ZmpFSDlP?=
 =?utf-8?B?WHdhSHJscnlqa2szWVlmalNENTdNbHp0aTZ2NWN6S25zQzlJT21BWEIrU3BJ?=
 =?utf-8?B?VWJrcnB1MzFEOFV6UkdhNTdiTWc1SkpUaDkwRGxlZEN0aE41SktKYWt6SDFw?=
 =?utf-8?B?czZtdm1Mdjg4RThYSVNsb1hDZnJEZGozbE00STVKRWxKMWRDSXhTbWNBOUlY?=
 =?utf-8?B?TjdOSzhwNE1PemNuUFo3cHF6QnREd2FWS2xyV0t2ZkU5eU9qWUxOeFE1M0xU?=
 =?utf-8?B?bEoyb1hHbk9kK0o0VmxJeTRYUldUUXNZSFZIL0pZYWFIYUJMN3JMQ1lBZFUy?=
 =?utf-8?B?TWpCZ1dSU1orTjRCSlE0TG9xYThtMXkwUkNyd2pMWDBnbTFrNkhCT09KTXlG?=
 =?utf-8?B?RWhzZG16L0NBVWZMeGdHWFM0MWFQMHdqd1c0OU0vUTZvcHowR1F1ZnNqTmhV?=
 =?utf-8?B?UWR4QldXK0NTQ0ViV3FyR2ZvL1MzUisrZ1RoT0g2aGVCaE8zYWpIaC9FV0R2?=
 =?utf-8?B?eEp4TjFEUzg1ejd5aXV5amw5MW91MlpEaHRURVV6WjdFQ3VaSXQvOXA2YVk1?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807968db-820d-4706-5de8-08ddc0d4426f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 23:40:03.7994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLYVKffjXvTDSTWUdcvI33DHzRCanzLjkSz9GY5HkLCmbR118xqFxqd2+xKUUTvlJJeLvv05QRysIjUt5d9QSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414



On 7/11/2025 3:54 PM, Danilo Krummrich wrote:
> On Fri Jul 11, 2025 at 9:35 PM CEST, Joel Fernandes wrote:
>> It looks good to me. A few high-level comments:
>>
>> 1. If we don't expect the concurrency issue for this in C code, why do we
>> expect it to happen in rust? 
> 
> The race can happen in C as well, but people would probably argue that no one
> ever calls the mask setter function concurrently to DMA allocation and mapping
> primitives.
> 
After going through the DMA code some more, I am convinced the concurrency is an
issue so marking the higher-level rust wrapper as unsafe { } makes sense.

Thanks Danilo for the discussion and Miguel also for the clarifications on the
other thread.

 - Joel


