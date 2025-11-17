Return-Path: <linux-pci+bounces-41419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05436C64963
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 059F234A394
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C540523A9AD;
	Mon, 17 Nov 2025 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rgh07U1i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q0uC8dVI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E42AEF5;
	Mon, 17 Nov 2025 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388316; cv=fail; b=RSY0l4ORnaVg06FSsvSxeqSXvYFzJsIfBfVO4i6CdeL+E79zbugIH7YOnqIAx/0xI674Y4TnnGRXy93NeFbkv2eaa6+n5Dswbi+MVs/JQMeWjZnHPpNh4c+vHg+MYORqQvgNJOkGyG3gF/pggSgrrwUxhZ9YtopvU9YPZeOrI74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388316; c=relaxed/simple;
	bh=YfaRaXQ5NWC6qspL1BMmIINrQlx6Uis6JjfU+9UG8Nw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mM+W9x3GbQ06NU21N5/yn8rfP2PMVGePsx3L8VMH5Eax3FqJnZAg/LSCtzt12+Kq7whuRStqndHh9r1sv+NL1Om3z2jPlIhfTh/ZYdTmea9YwVT75wGgbb+HkA0MtYr9ik0P2Di1zhFZqk4fAbDkDbL9WKbPbFvI5MQ4Z6/EBVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rgh07U1i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q0uC8dVI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC8MTO011850;
	Mon, 17 Nov 2025 14:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tMDSo/vxy8BjLhD6e4EtWnLNQi5Qja3VLhKX4gBebOc=; b=
	Rgh07U1iNLaT6g1MKggcu+GjZe2vfw1inw0pxCfsRfdNEONR2agyw3na+RTF2V7H
	99ouq94LQuu+otFPOsnCpUo7Gj79gdRI/ZDMV4WR3LYAwOVqW8zc80RLFCweeKt9
	2vI4j1RPbDCNvd5HJlntRjdeeta7k8IxbzCGP6u8pdekVF3lhPzYV+0QR9uLa+/G
	OPELejByeT5EEtEigNI5Lk5SMBmeJRaI27x8o5pqeaL9gkCHSmJ7YSXkfvwoL+kg
	FAlZS56zg9cQFh6r0taqV8trykQw6AevvTFbZbsiiZ6ne8S36690Q3zSTrEqONz2
	/WN5M/PEsE0UmAe3edGkeA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej902j2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 14:04:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHDFFZB007884;
	Mon, 17 Nov 2025 14:04:47 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy7r452-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 14:04:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKzyUqdJK7XyoHoIy69SJpWzpOuK2957DIhg4nkGMSxF3KU+lJ//64Y6VOklOmp5Z0O58Lp6IM8RbDOj/9hqAeTINWKqtPPo7FERQVCbNf5QwIJmsmnjf9xmt73fnW5OgZPYwzJKu2crvDI6WZp3Bm/4CFuIuBJ5SFv594RZCylzC2+rFeK3LVbDg+85mWSFIMNf4ZzfL9QT9b9EPipN13jN0ari/MG4xN0QXy0cub0LnvP2M5xb67f+EcpNClg7aC7l3cUum8bdlivJXDBvMke3ab0e4RKDP29mOLOY5unbEyPrMw1cSJW7wa6yXjcP18eaYXaE7eUmT0dzukFTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMDSo/vxy8BjLhD6e4EtWnLNQi5Qja3VLhKX4gBebOc=;
 b=xyzt5q645J3Aa8iVvo9Vr2K9tb8w+MA2A+uaxPwjfQPjOgclTETvJ0a6BDBWNebpdDRfO6HrjCVw3YqMJDxX+kLhQ3zld8Yq15z6nUW3zu7qQvDwWf2Dl/T1FDrjZYikX5zdPJJlxhpKSr1Jb/roHNulln0YoWRsSK+YsviXvbpLb+JCxO0BEZrF5miCpR11zJqCYf47gPaXHesCN0QfK6G2h1MoCXoOFViyT9+WEpwBCYDLHXDYhyyjCgy6jvkddMD3hnnqnGG9SMuoDYEmcXvD0AHs217qitPEdAZ8yU0OyuZlExB8lh43JtUtBZk9FJdaj8qt0TrDYZ/d0F59WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMDSo/vxy8BjLhD6e4EtWnLNQi5Qja3VLhKX4gBebOc=;
 b=Q0uC8dVIDkgd6EUMUtlNBXCMvrdrucUhdihpYmS6y4IqcxnlZGYwhzWV/P/D1/j9lrhpmAjRh0dONQHyM5G2gOtYJg06DZYTmv36eLydep23nwC1ht8Sv4DVG0pbq9i+P9jkDsGGCugp8HrrZtWCBE3rN2hDwZMQ+kqFPOG9wLA=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS4PR10MB997598.namprd10.prod.outlook.com (2603:10b6:8:318::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 14:04:45 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9253.017; Mon, 17 Nov 2025
 14:04:44 +0000
Message-ID: <32bec7e0-6631-4850-835b-c0c377722dca@oracle.com>
Date: Mon, 17 Nov 2025 19:34:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v7 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S
 SoC host driver
To: Claudiu <claudiu.beznea@tuxon.dev>, bhelgaas@google.com,
        lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com, p.zabel@pengutronix.de
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20251117090859.3840888-1-claudiu.beznea.uj@bp.renesas.com>
 <20251117090859.3840888-3-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251117090859.3840888-3-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0422.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::13) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS4PR10MB997598:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f2f470-e9bf-4ec3-defd-08de25e242c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW85RVRYbUtLUnFYVUZMRjNPbHV5KytOWDdKSFUwU3ZITXlqVTN5R2JieVZO?=
 =?utf-8?B?NEJJMThXeTIrdURwZS9IeWIrZm9xcDFiUVNzdW5qTU1vRGdLR3AxWDdGNWR4?=
 =?utf-8?B?bVFTSDduT3JiNGpJMWhzSDA3c1lWUTlxaVhXL3VucW96VmNZdlc0ckJ2VTRM?=
 =?utf-8?B?aHVlblgrREhWQ2tkS3IySmZNOXd3U1d0NVJ6SHVRRzVUejYwNyt2NVhFcTQ4?=
 =?utf-8?B?bS9ldGFUMEM4SlhiS1lwYnlnQnVpS1JmeWFqZlZNY2Zkanh3OVdyZHl4dUFE?=
 =?utf-8?B?TmFBcGxLYjNsOWVra0xrOFhjTG9obkI5Z1BpQ0JPblB4bzBHVXhMWW5hMnBk?=
 =?utf-8?B?U0xkSm5xdkQ4dXlMNXRwMG5uL0hMMjk4bmVBY1lkeFRIZW1JOFA3aHVQL2kz?=
 =?utf-8?B?ZU12bkFWSzNoeGI0UkFxbGRqbFFmVURKQXBxQmN3KytTQkwyRlVPZy82S0pW?=
 =?utf-8?B?aDEvaVFrVmFtck1MR1pEVm1CNlI1ckhJQStCa1FJWEVqK2psWXpZUXJZTVlC?=
 =?utf-8?B?d3JCN2prdXM2UEh2RUwzZWRxYWs1OFVIUm5BMG1ER1AwVWx5R0JiaWFJTWMw?=
 =?utf-8?B?eVNQL25RNlprbXBCdHA0TkFuWVJjNTVUdlBKRjQ3RXh2VFc0SzVKNmUxNk1L?=
 =?utf-8?B?Rnl0N01TdXJxd21FRE5Sa043T2JXbURCNlovOXVhaTNEUGc1d3VIMU54MDVx?=
 =?utf-8?B?a24xSVFDUG93RHNyOXBldWgxbm9DMGRKUFJBOU1JWXF2NjhaQXdjd3lGVEc1?=
 =?utf-8?B?ZFdHMHBNeEFqaFloekZFM3AxdGFYR1FkdGNmN1ZBd1RmR3l1N04yM3N2dWU0?=
 =?utf-8?B?dGQrcW56b2I1Q0ZkdjRrK2JTQ1RPQ1diaTBadFdnMjNTQ3ZCOWZ6YmNLVnNE?=
 =?utf-8?B?MURVUGpiK3VIb1lacmswaW5aOEd0SXpIWlVUd1hNOFN5RGFsVnh0aHNYMGQx?=
 =?utf-8?B?b201MUs3L0ZDa3p1V0d4ZnZHRlFhOUVWYkduUnNFck1ZeGxud0R5ZmZxQnJz?=
 =?utf-8?B?QnBGMk9LTmVzZ3pVTndZOUhWdWswOUV4NUNSc2FyalE2R1ZZOUMzekZLMjZ6?=
 =?utf-8?B?cUFGczJtc1NISHVVUlFpZjBrbnlCZVJTZEcwdXJPYnNmVDZhZWZxUnkrcENu?=
 =?utf-8?B?TWV1L1NmVUZDZ2pNNU4yTXdVUG9VYUk4YmY2TEFSb1NvTjBXYTJ6cUlQcEtt?=
 =?utf-8?B?MG5rOXpMcDJldHdGamdEKzZFdVhUcUhTY05sM2dOdUs5NzhSUnN6TExIWHhr?=
 =?utf-8?B?dmlqcUFzUWZMVmNrelJzbnh1NmhaRjVGZURydk9ZLzM1Nk0zSUNIRXJERlRi?=
 =?utf-8?B?a1Z3MmdKZ0VYWlRIS1l0SGE2VEZKbzhYSnpMbnluK2Y3WkI2eWE5RnF2Mmpp?=
 =?utf-8?B?Zkl3RVhvd1JtL1Rzc283UUdjSFpDeDZqUWRkRTBmemFBZGlwTVhFZzdCekhJ?=
 =?utf-8?B?Q2tsYnI2Y3NGS045b1U4N1VxRnJJZXZ4TDU3MVByYklXOStRTEliUU9KSWE0?=
 =?utf-8?B?WEZVSEt3Wkd4MGozWStPcmE5M3pCMWt6bHUzamlSMVZ4eHZ2REVVbWwrdERx?=
 =?utf-8?B?Qm9HdktIcU5TQy91TjZrMi9YbHRqTklTRk1BZksySGR6dHFGOW9iSStpU0JR?=
 =?utf-8?B?NWdtSlRmNWhDY2RsS3Noa1FwYXpVZ1NEZDZENTFZTDJoREpac083MkZCcTlE?=
 =?utf-8?B?Qjd2UWk3V2dnbDJlQm5USWsvem1ha0swZFJjR2JtOUd3YUk3dGl4b3V3UmZB?=
 =?utf-8?B?TUxFVkMwRkRhd3lybTNGZlBzUC9SQ3FZaU9ia3RhaVVhRkNUalhseXNtUHBY?=
 =?utf-8?B?bjQ2dG9GbStPSW1YQ3JYOTY1VE05cGhYQ2ZzRjRPbUlsdndOMEkxdjVyR2hH?=
 =?utf-8?B?cGRsRlRFbkJ3YzV3OXNlWitvbmFqUTVtWXNRNTB5ZVJQSEI3VjJESmNKcno3?=
 =?utf-8?B?MytEVlYvRy92SjYyeEVqQ2UxdFoxU1hQalZJenlmTCtFKzhEZkFpR2VxNy9j?=
 =?utf-8?Q?pq0EByC5cTf1uvC/z+4wz7GiEoh11Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUY4M2YvM0NUM0JVM3dUanJHbE1ORlRXR1BML1Z4QUwzTGdOa3QwOGRMdjly?=
 =?utf-8?B?UmNvSHRQWHRGd2NwOEZjUFo2UEJlQU5tVzJUOFpLYTlwTXZVcnhXVGdod0FW?=
 =?utf-8?B?d0VpTS8xaTdRNUd5ODRiaFkraGZGcXBhNVJBUkJYeU9hdUl4Q01iN2RiU0Rv?=
 =?utf-8?B?NGlQOWUvZWs5a3pKc24yV1gyUUt1ZUhPcm5GOGZGMmk2UzlPQUJvUUlLSG4z?=
 =?utf-8?B?azcwUlNiVkVlRTJvR2tjRytyUlZteU0rdzU1MkNWaGlDck45NWY4QkJHLy9Q?=
 =?utf-8?B?R3EwMDZ6QVVuRk11dS84TGluZDBCZUpWNlRER1NWWWlPQkxHa2Mralg3YU5S?=
 =?utf-8?B?L2htU1FBRHFlclNZd21zd0RHOG83cGIxeTRhTTlIVXhBVkVCbU1tNFd1RHBl?=
 =?utf-8?B?ckkvTmdRc1JzVGpFY3JpL0ZNbHlCalpGaGI2V3lrU3pHbkxyTHY2NjRiMGJS?=
 =?utf-8?B?NzFveW5Ldmh4c2FvRk0zSmxrR2h0OWpBZ2tBcjZJOWdIbkpQblhlRFU5YlVx?=
 =?utf-8?B?MW9WbWZwWDUzMC9saDJ4Y3ozUWN1OUIxVDBqMDVlOGFhdHl1UVFNaEdBbko1?=
 =?utf-8?B?S1FqWWxtbzR6VVBaeTdRemQvVW1ZOHlhV0xmSmJidnhzWlpzaDYvOGdEeDNC?=
 =?utf-8?B?aVZZK3BIWHpQQzVvQmgrMy9pdXpjT0I4NUxCd2d4U0Y3ai9NSG02bHZxU1NK?=
 =?utf-8?B?Ry9Sa0wxd0M2cWxaUmRHcEJJNjNSZnMwTGRGYzQzSGhwblpyOHdVcVBMSm5O?=
 =?utf-8?B?dGQvLzhCWE1XUG8vMTVNSmREU1BwV2xXT281c1B5a1RFb2hVM0VLL1lOQXVV?=
 =?utf-8?B?MlBRUmNlSWxsMW9ReWhiMjlBR1h6RllUVjkxcmRQejdWMzhRVVFxMVlIbVZQ?=
 =?utf-8?B?SmMzZTlwUVZ2SnQra24wMjFQU1BWclJ4a05jRGFhQ1BZaTRXYk1FS0o4MzNq?=
 =?utf-8?B?YWVoa2xaS1c2NlJKd1BxanpNcm9jUnBwRmpMNXMrY1dMWXBPOG5UeUxJNlU4?=
 =?utf-8?B?alIxaGlHazd3NXpkTEZMd1RqSWptTGxoRnFLcEp4QVRhOWFYQ01kTy9mdVBv?=
 =?utf-8?B?WldValRJK3ZWMDRQQ0FTQUk5cWdaYUx4Q1dLVENGV3l4OTI1TmltWmxCczQ1?=
 =?utf-8?B?QS8yRmNHY1VkdWdaYndxZXZSWjF2VU5GaVBsalExeDZaTVAxRFhZZWl6Rk5Q?=
 =?utf-8?B?Rk14UzNFT2UxZTQ1ZWRhSDZZd0VOdlZLeXZyVnd1eWNpdmJQNUdmSG5zdVJp?=
 =?utf-8?B?K01GZWgyQ2VSN2ZYeGMvMmlPMmprb1dnd0dLQmxDeE1TRERldDRUT2ZyYmdr?=
 =?utf-8?B?elFWRlIxZHpqL1RYbW10U0tDM1V5N010NGJmcitZN0dhUSt0cm9ZMlpVaGU3?=
 =?utf-8?B?ZVpoTG5sT1pZTGdpSXNFRnNjNEhGNjNHOWMzaHZyekdSb3VPY1VtTThCRVRy?=
 =?utf-8?B?N2ZkcHZNbktFbHMwMmhqVG9GS29DKzFrT2pMWWFycDhlQVV1RDNPeU9uQkNO?=
 =?utf-8?B?aHUrUEE0enR0a0VlV1dMWGdLY3AyRFkybWxsNWdZNEk3UlMwdmFMWXpvT3Zk?=
 =?utf-8?B?UzBMNFN3UlgxNlA0ZWFuVW9rQnFHT0JyNmJSai96S0Y3Q2QrRVFFWWxMOWxz?=
 =?utf-8?B?MDhiT3ZuM2xjM1JLVmdHVVRVMVFWdU1YaWw5VDdUcUN4TjNJRVRCUGtBN3Mw?=
 =?utf-8?B?VHlibE9VME4xdlJaWSt3Y1pjQUxOdzZkWXJLOXlEeDFmRmg3Vjd4cVQ0cWFj?=
 =?utf-8?B?OFd4ZllFUVc5dmNhWGN1Nnlqa1U5WURFclpXN1ZSMnZkVkN0YzRaTFY1ZHpa?=
 =?utf-8?B?SVpnNE9tK1VmcWZUS3VnaGZjOWp1TXNCVlNjYzM4aFZ4SlljYlBqd2JFQVMw?=
 =?utf-8?B?NHVOZ3hXV1AxWEFsRXp6YWo0OStSMkFxb0pkS1VPWnlhM3p2bG5EMDMxcUVH?=
 =?utf-8?B?cnJ0LzhIaGxPa3hseGFUREVaTlJmSGRiNWxzYUpIRVk0RlhOalFSbld4RVBZ?=
 =?utf-8?B?RHV3TE5FOExHQlZWbGxob2pkcjFOVW45elZNWVBnM2VYSXp2ZVB1TTl4b0xt?=
 =?utf-8?B?YjhFazZxNTJ2Q3l0ZWtDN2VqNlpSWFJNL1IwM05HeFY1NG9XSDByT1JDZklk?=
 =?utf-8?B?YkFzN2VTOHkyWXlwbXJOLzl1d1FiUmMzdVZiZmgydlhiVXRJK2h2K2ovTzdL?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qpcWG3uMRgen7U4O9E6kBpIJyQPxkSYgEs8li4Gcdck2ZiwTCvp6NW1oXwOZ4/B5xZb/H6CuVeefOeGkvIqkmyEDFF35jmcHCJcBIuM6JWFWg+28xgAS03L7YjRJ8k7UNxgYT97WaivmFnuhQgoHWznG2ubj/Fzu3iwLQPtlhAFbUOWzRJQ7wPfZOC0jlShWLF11CP9qFeYqBajnd0KPd6xmQgD27vOCu5v3AreW64eJ0r19rSenTIqgxuRS6vAGamiL+u6IuTVkEueQ+v+0ZizfRdctj3XBxuISdBF3PYCv2bz/aUXsb7oPtfHpV/RgMTj/63RBA/DLWjEh4W6Banv79rsfB3fHe9PyXX0GcHd3xlHf5RBQbmId6G7PCBWqFFbc9O1KdhygE6Zl2JPyZqWazO8qQqQRuInpn6JqvrMhOsxgESC6LqOEovetKwQnMmUplo8P2GuPjf3PjqixZnCHK4OenvJlRnEwewv1Ik5GPV09xtCF7L1/TPAFVG9FDzOaXykN9EAPZ1oKZHP8IF/lcvkmkxLlUe1Io3VVa8eZEqL7MjqavQ8RiZ6Dhl3IbIQui2SWV+Gf5QOc6cDIi7WALtDBbclCrjBn97e/rcg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f2f470-e9bf-4ec3-defd-08de25e242c2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 14:04:44.8371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9OFjuRdQQc/KwvyaDcqSqK8MdCt9Q6lU72cCAhbof24w2vCkEIfaCWA9IaHBGrwv37Cv+CL9gvtaCnfT8XZ9Yvw0G2wEplO68Ms802eIkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170119
X-Authority-Analysis: v=2.4 cv=OMAqHCaB c=1 sm=1 tr=0 ts=691b2b82 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=2o1gQppgAWVB5bntMgAA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 0XwuNg_TLCihxPrrYwM8fKQ2Ku2rnzWg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX9pPpewjgU/Ot
 B9Cx1SvDyv3DJMTUjkbaL0uLpt/aZs24qN2NmWjH5tNgalX7Dlwj/opBlvssiqEXa53v3U2RtFt
 nQXm6pZ5F6oAiF+r0lAkxT6/Ct3O68jX/G1mFxeCASbBzUr/uXu9b8MAqrf4SyFDeHqbYe+7r5k
 5MXRYpJS2dneqAQKI3x9JBoqsQMms2Zh2dQvLInw6m3vL3+TpbkFWyT9hYIIGzgOuxlRFFHBN6O
 5Q+aKSNBdJumiVF8DzC2qIK/UlMJXfOPv3mvYuqTXgNpFlA4C0IPzGcGc3Z4S9En2pdTH87wgLK
 t+pix3orReLq9Qcic+0AUjdCiYAyrdinJ12hAHp0kFJRmFL7EEgmos0H/hQSS5uVP+9wJBv5wjp
 VaPZBTwrrQHXBBsnvaEFzS5Ick2tzQ==
X-Proofpoint-GUID: 0XwuNg_TLCihxPrrYwM8fKQ2Ku2rnzWg

> +
> +/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
> +static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
> +				 int where, int size, u32 val)
> +{
> +	struct rzg3s_pcie_host *host = bus->sysdata;
> +
> +	/* Enable access control to the CFGU */
> +	writel_relaxed(RZG3S_PCI_PERM_CFG_HWINIT_EN,
> +		       host->axi + RZG3S_PCI_PERM);
> +
> +	pci_generic_config_write(bus, devfn, where, size, val);

why ignore pci_generic_config_write ret ?

> +
> +	/* Disable access control to the CFGU */
> +	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static struct pci_ops rzg3s_pcie_root_ops = {
> +	.read		= pci_generic_config_read,
> +	.write		= rzg3s_pcie_root_write,
> +	.map_bus	= rzg3s_pcie_root_map_bus,
> +};
> +
> +static void rzg3s_pcie_intx_irq_handler(struct irq_desc *desc)
> +{
> +	struct rzg3s_pcie_host *host = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned int irq = irq_desc_get_irq(desc);
> +	u32 intx = irq - host->intx_irqs[0];
> +
> +	chained_irq_enter(chip, desc);
> +	generic_handle_domain_irq(host->intx_domain, intx);
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static irqreturn_t rzg3s_pcie_msi_irq(int irq, void *data)
> +{
> +	u8 regs = RZG3S_PCI_MSI_INT_NR / RZG3S_PCI_MSI_INT_PER_REG;
> +	DECLARE_BITMAP(bitmap, RZG3S_PCI_MSI_INT_NR);
> +	struct rzg3s_pcie_host *host = data;
> +	struct rzg3s_pcie_msi *msi = &host->msi;
> +	unsigned long bit;
> +	u32 status;
> +
> +	status = readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIS);
> +	if (!(status & RZG3S_PCI_PINTRCVIS_MSI))
> +		return IRQ_NONE;
> +
> +	/* Clear the MSI */
> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
> +			       RZG3S_PCI_PINTRCVIS_MSI,
> +			       RZG3S_PCI_PINTRCVIS_MSI);
> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSGRCVIS,
> +			       RZG3S_PCI_MSGRCVIS_MRI, RZG3S_PCI_MSGRCVIS_MRI);
> +
> +	for (u8 reg_id = 0; reg_id < regs; reg_id++) {
> +		status = readl_relaxed(host->axi + RZG3S_PCI_MSIRS(reg_id));
> +		bitmap_write(bitmap, status, reg_id * RZG3S_PCI_MSI_INT_PER_REG,
> +			     RZG3S_PCI_MSI_INT_PER_REG);
> +	}
> +
> +	for_each_set_bit(bit, bitmap, RZG3S_PCI_MSI_INT_NR) {
> +		int ret;
> +
> +		ret = generic_handle_domain_irq(msi->domain, bit);
> +		if (ret) {
> +			u8 reg_bit = bit % RZG3S_PCI_MSI_INT_PER_REG;
> +			u8 reg_id = bit / RZG3S_PCI_MSI_INT_PER_REG;
> +
> +			/* Unknown MSI, just clear it */
> +			writel_relaxed(BIT(reg_bit),
> +				       host->axi + RZG3S_PCI_MSIRS(reg_id));
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void rzg3s_pcie_msi_irq_ack(struct irq_data *d)
> +{
> +	struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(d);
> +	struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
> +	u8 reg_bit = d->hwirq % RZG3S_PCI_MSI_INT_PER_REG;
> +	u8 reg_id = d->hwirq / RZG3S_PCI_MSI_INT_PER_REG;
> +
> +	guard(raw_spinlock_irqsave)(&host->hw_lock);
> +
> +	writel_relaxed(BIT(reg_bit), host->axi + RZG3S_PCI_MSIRS(reg_id));
> +}
> +
> +static void rzg3s_pcie_msi_irq_mask(struct irq_data *d)
> +{
> +	struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(d);
> +	struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
> +	u8 reg_bit = d->hwirq % RZG3S_PCI_MSI_INT_PER_REG;
> +	u8 reg_id = d->hwirq / RZG3S_PCI_MSI_INT_PER_REG;
> +
> +	guard(raw_spinlock_irqsave)(&host->hw_lock);
> +
> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
> +			       BIT(reg_bit));
> +}
> +
> +static void rzg3s_pcie_msi_irq_unmask(struct irq_data *d)
> +{
> +	struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(d);
> +	struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
> +	u8 reg_bit = d->hwirq % RZG3S_PCI_MSI_INT_PER_REG;
> +	u8 reg_id = d->hwirq / RZG3S_PCI_MSI_INT_PER_REG;
> +
> +	guard(raw_spinlock_irqsave)(&host->hw_lock);
> +
> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
> +			       0);
> +}
> +
> +static void rzg3s_pcie_irq_compose_msi_msg(struct irq_data *data,
> +					   struct msi_msg *msg)
> +{
> +	struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(data);
> +	struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
> +	u32 lo, hi;
> +
> +	/*
> +	 * Enable and msg data enable bits are part of the address lo. Drop
> +	 * them along with the unused bit.
> +	 */
> +	lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) &
> +	     RZG3S_PCI_MSIRCVWADRL_MASK;
> +	hi = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRU);
> +
> +	msg->address_lo = lo;
> +	msg->address_hi = hi;
> +	msg->data = data->hwirq;
> +}
> +
> +static struct irq_chip rzg3s_pcie_msi_bottom_chip = {
> +	.name			= "rzg3s-pcie-msi",
> +	.irq_ack		= rzg3s_pcie_msi_irq_ack,
> +	.irq_mask		= rzg3s_pcie_msi_irq_mask,
> +	.irq_unmask		= rzg3s_pcie_msi_irq_unmask,
> +	.irq_compose_msi_msg	= rzg3s_pcie_irq_compose_msi_msg,
> +};
> +
> +static int rzg3s_pcie_msi_domain_alloc(struct irq_domain *domain,
> +				       unsigned int virq, unsigned int nr_irqs,
> +				       void *args)
> +{
> +	struct rzg3s_pcie_msi *msi = domain->host_data;
> +	int hwirq;
> +
> +	scoped_guard(mutex, &msi->map_lock) {
> +		hwirq = bitmap_find_free_region(msi->map, RZG3S_PCI_MSI_INT_NR,
> +						order_base_2(nr_irqs));
> +	}
> +
> +	if (hwirq < 0)
> +		return -ENOSPC;
> +
> +	for (unsigned int i = 0; i < nr_irqs; i++) {
> +		irq_domain_set_info(domain, virq + i, hwirq + i,
> +				    &rzg3s_pcie_msi_bottom_chip,
> +				    domain->host_data, handle_edge_irq, NULL,
> +				    NULL);
> +	}
> +
> +	return 0;
> +}
> +
> +static void rzg3s_pcie_msi_domain_free(struct irq_domain *domain,
> +				       unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct rzg3s_pcie_msi *msi = domain->host_data;
> +
> +	guard(mutex)(&msi->map_lock);
> +
> +	bitmap_release_region(msi->map, d->hwirq, order_base_2(nr_irqs));
> +}
> +
> +static const struct irq_domain_ops rzg3s_pcie_msi_domain_ops = {
> +	.alloc	= rzg3s_pcie_msi_domain_alloc,
> +	.free	= rzg3s_pcie_msi_domain_free,
> +};
> +
> +#define RZG3S_PCIE_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS	| \
> +					 MSI_FLAG_USE_DEF_CHIP_OPS	| \
> +					 MSI_FLAG_NO_AFFINITY		| \
> +					 MSI_FLAG_PCI_MSI_MASK_PARENT)
> +
> +#define RZG3S_PCIE_MSI_FLAGS_SUPPORTED	(MSI_FLAG_MULTI_PCI_MSI		| \
> +					 MSI_GENERIC_FLAGS_MASK)
> +
> +static const struct msi_parent_ops rzg3s_pcie_msi_parent_ops = {
> +	.required_flags		= RZG3S_PCIE_MSI_FLAGS_REQUIRED,
> +	.supported_flags	= RZG3S_PCIE_MSI_FLAGS_SUPPORTED,
> +	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
> +	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
> +	.prefix			= "RZG3S-",
> +	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
> +};
> +
> +static int rzg3s_pcie_msi_allocate_domains(struct rzg3s_pcie_msi *msi)
> +{
> +	struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
> +	struct device *dev = host->dev;
> +	struct irq_domain_info info = {
> +		.fwnode		= dev_fwnode(dev),
> +		.ops		= &rzg3s_pcie_msi_domain_ops,
> +		.size		= RZG3S_PCI_MSI_INT_NR,
> +		.host_data	= msi,
> +	};
> +
> +	msi->domain = msi_create_parent_irq_domain(&info,
> +						   &rzg3s_pcie_msi_parent_ops);
> +	if (!msi->domain)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "failed to create IRQ domain\n");
> +
> +	return 0;
> +}
> +
> +static int rzg3s_pcie_msi_hw_setup(struct rzg3s_pcie_host *host)
> +{
> +	u8 regs = RZG3S_PCI_MSI_INT_NR / RZG3S_PCI_MSI_INT_PER_REG;
> +	struct rzg3s_pcie_msi *msi = &host->msi;
> +
> +	/*
> +	 * Set MSI window size. HW will set the window to
> +	 * RZG3S_PCI_MSI_INT_NR * 4 bytes.
> +	 */
> +	writel_relaxed(FIELD_PREP(RZG3S_PCI_MSIRCVWMSKL_MASK,
> +				  RZG3S_PCI_MSI_INT_NR - 1),
> +		       host->axi + RZG3S_PCI_MSIRCVWMSKL);
> +
> +	/* Set MSI window address and enable MSI window */
> +	writel_relaxed(upper_32_bits(msi->window_base),
> +		       host->axi + RZG3S_PCI_MSIRCVWADRU);
> +	writel_relaxed(lower_32_bits(msi->window_base) |
> +		       RZG3S_PCI_MSIRCVWADRL_ENA |
> +		       RZG3S_PCI_MSIRCVWADRL_MSG_DATA_ENA,
> +		       host->axi + RZG3S_PCI_MSIRCVWADRL);
> +
> +	/* Set MSI receive enable */
> +	for (u8 reg_id = 0; reg_id < regs; reg_id++) {
> +		writel_relaxed(RZG3S_PCI_MSIRE_ENA,
> +			       host->axi + RZG3S_PCI_MSIRE(reg_id));
> +	}
> +
> +	/* Enable message receive interrupts */
> +	writel_relaxed(RZG3S_PCI_MSGRCVIE_MSG_RCV,
> +		       host->axi + RZG3S_PCI_MSGRCVIE);
> +
> +	/* Enable MSI */
> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIE,
> +			       RZG3S_PCI_PINTRCVIE_MSI,
> +			       RZG3S_PCI_PINTRCVIE_MSI);
> +
> +	return 0;
> +}
> +
> +static int rzg3s_pcie_msi_setup(struct rzg3s_pcie_host *host)
> +{
> +	size_t size = RZG3S_PCI_MSI_INT_NR * sizeof(u32);
> +	struct rzg3s_pcie_msi *msi = &host->msi;
> +	struct device *dev = host->dev;
> +	int id, ret;
> +
> +	msi->pages = __get_free_pages(GFP_KERNEL | GFP_DMA, 0);
> +	if (!msi->pages)
> +		return -ENOMEM;
> +
> +	msi->dma_addr = dma_map_single(dev, (void *)msi->pages, size * 2,
> +				       DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(dev, msi->dma_addr)) {
> +		ret = -ENOMEM;
> +		goto free_pages;
> +	}
> +
> +	/*
> +	 * According to the RZ/G3S HW manual (Rev.1.10, section 34.4.5.2 Setting
> +	 * the MSI Window) the MSI window needs to fall within one of the
> +	 * enabled AXI windows. Find an enabled AXI window to setup the MSI
> +	 * window.
> +	 */
> +	for (id = 0; id < RZG3S_MAX_WINDOWS; id++) {
> +		u64 base, basel, baseu;
> +		u64 mask, maskl, masku;
> +
> +		basel = readl_relaxed(host->axi + RZG3S_PCI_AWBASEL(id));
> +		/* Skip checking this AXI window if it's not enabled */
> +		if (!(basel & RZG3S_PCI_AWBASEL_WIN_ENA))
> +			continue;
> +
> +		baseu = readl_relaxed(host->axi + RZG3S_PCI_AWBASEU(id));
> +		base = baseu << 32 | basel;
> +
> +		maskl = readl_relaxed(host->axi + RZG3S_PCI_AWMASKL(id));
> +		masku = readl_relaxed(host->axi + RZG3S_PCI_AWMASKU(id));
> +		mask = masku << 32 | maskl;
> +
> +		if (msi->dma_addr < base || msi->dma_addr > base + mask)
> +			continue;
> +
> +		break;
> +	}
> +
> +	if (id == RZG3S_MAX_WINDOWS) {
> +		ret = -EINVAL;
> +		goto dma_unmap;
> +	}
> +
> +	/* The MSI base address need to be aligned to the MSI size */
> +	msi->window_base = ALIGN(msi->dma_addr, size);
> +	if (msi->window_base < msi->dma_addr) {
> +		ret = -EINVAL;
> +		goto dma_unmap;
> +	}
> +
> +	rzg3s_pcie_msi_hw_setup(host);
> +
> +	return 0;
> +
> +dma_unmap:
> +	dma_unmap_single(dev, msi->dma_addr, size * 2, DMA_BIDIRECTIONAL);
> +free_pages:
> +	free_pages(msi->pages, 0);
> +	return ret;
> +}
> +
> +static void rzg3s_pcie_msi_hw_teardown(struct rzg3s_pcie_host *host)
> +{
> +	u8 regs = RZG3S_PCI_MSI_INT_NR / RZG3S_PCI_MSI_INT_PER_REG;
> +
> +	/* Disable MSI */
> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIE,
> +			       RZG3S_PCI_PINTRCVIE_MSI, 0);
> +
> +	/* Disable message receive interrupts */
> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSGRCVIE,
> +			       RZG3S_PCI_MSGRCVIE_MSG_RCV, 0);
> +
> +	/* Disable MSI receive enable */
> +	for (u8 reg_id = 0; reg_id < regs; reg_id++)
> +		writel_relaxed(0, host->axi + RZG3S_PCI_MSIRE(reg_id));
> +
> +	/* Disable MSI window */
> +	writel_relaxed(0, host->axi + RZG3S_PCI_MSIRCVWADRL);
> +}
> +
> +static void rzg3s_pcie_teardown_msi(struct rzg3s_pcie_host *host)
> +{
> +	size_t size = RZG3S_PCI_MSI_INT_NR * sizeof(u32);
> +	struct rzg3s_pcie_msi *msi = &host->msi;
> +
> +	rzg3s_pcie_msi_hw_teardown(host);
> +
> +	free_irq(msi->irq, host);
> +	irq_domain_remove(msi->domain);
> +
> +	/* Free unused memory */
> +	dma_unmap_single(host->dev, msi->dma_addr, size * 2, DMA_BIDIRECTIONAL);
> +	free_pages(msi->pages, 0);
> +}
> +
> +static int rzg3s_pcie_init_msi(struct rzg3s_pcie_host *host)
> +{
> +	struct platform_device *pdev = to_platform_device(host->dev);
> +	struct rzg3s_pcie_msi *msi = &host->msi;
> +	struct device *dev = host->dev;
> +	const char *devname;
> +	int irq, ret;
> +
> +	ret = devm_mutex_init(dev, &msi->map_lock);
> +	if (ret)
> +		return ret;
> +
> +	msi->irq = platform_get_irq_byname(pdev, "msi");
> +	if (msi->irq < 0)
> +		return dev_err_probe(dev, irq ? irq : -EINVAL,
> +				     "Failed to get MSI IRQ!\n");

irq is uninitialized. do you mean msi->irq?

> +
> +	devname = devm_kasprintf(dev, GFP_KERNEL, "%s-msi", dev_name(dev));
> +	if (!devname)
> +		return -ENOMEM;
> +
> +	ret = rzg3s_pcie_msi_allocate_domains(msi);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Don't use devm_request_irq() as the driver uses non-devm helpers
> +	 * to control clocks. Mixing them may lead to subtle bugs.
> +	 */
> +	ret = request_irq(msi->irq, rzg3s_pcie_msi_irq, 0, devname, host);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to request IRQ: %d\n", ret);
> +		goto free_domains;
> +	}
> +
> +	ret = rzg3s_pcie_msi_setup(host);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to setup MSI!\n");
> +		goto free_irq;
> +	}
> +
> +	return 0;
> +
> +free_irq:
> +	free_irq(msi->irq, host);
> +free_domains:
> +	irq_domain_remove(msi->domain);
> +	return ret;
> +}
> +
> +static void rzg3s_pcie_intx_irq_ack(struct irq_data *d)
> +{
> +	struct rzg3s_pcie_host *host = irq_data_get_irq_chip_data(d);
> +
> +	guard(raw_spinlock_irqsave)(&host->hw_lock);
> +
> +	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
> +			       RZG3S_PCI_PINTRCVIS_INTX(d->hwirq),
> +			       RZG3S_PCI_PINTRCVIS_INTX(d->hwirq));
> +}
> +
> +static int
> +rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
> +		      int (*init_irqdomain)(struct rzg3s_pcie_host *host),
> +		      void (*teardown_irqdomain)(struct rzg3s_pcie_host *host))
> +{
> +	struct device *dev = host->dev;
> +	int ret;
> +
> +	/* Set inbound windows */
> +	ret = rzg3s_pcie_parse_map_dma_ranges(host);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to set inbound windows!\n");
> +
> +	/* Set outbound windows */
> +	ret = rzg3s_pcie_parse_map_ranges(host);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to set outbound windows!\n");
> +
> +	ret = init_irqdomain(host);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init IRQ doamin\n");

typo doamin -> domain

> +
> +	ret = rzg3s_pcie_host_init(host);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to initialize the HW!\n");
> +		goto teardown_irqdomain;
> +	}
> +
> +	ret = rzg3s_pcie_set_max_link_speed(host);
> +	if (ret)
> +		dev_info(dev, "Failed to set max link speed\n");
> +
> +	msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +
> +	return 0;
> +
> +teardown_irqdomain:
> +	teardown_irqdomain(host);
> +
> +	return ret;
> +}

Thanks,
Alok

