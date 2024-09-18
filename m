Return-Path: <linux-pci+bounces-13284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A32CE97BFB3
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 19:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4A71F22B83
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 17:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95161C9EC9;
	Wed, 18 Sep 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WLzvc1cL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E001C9EB3;
	Wed, 18 Sep 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726680704; cv=fail; b=RK89GrFx6pwkwefgtO7pDabrgZGjKqeXgcOwTLKIHnz96ITsLncEwT4ogsDWYQlE7h+DYjgPmyGfkGVizrki+yfd5CE7PUHA5PaGv/EgNVr4XMAO6jFGLq4h24smNN34JEUPU93V/Xk452KTYck792TutOSo3ywAWJgRSjbp+/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726680704; c=relaxed/simple;
	bh=f1WSub3CjGCWgY4AKiwsdS+6fWB+w+Qvk4/uS9EfHGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VjVUkBX25yyYd0zWRAQFURtD8OWl7BiZKZGAh18++YiGJmC7B6iVB1Iu1oLaHnGohSnTSr7zKB4fSfod+tclwXkzoqQvrfBRYtyfkzdY3Hijgo5X6N5QEZkQAUKmsZ2EPpvBU1YA9miSsK6ZQOjwYx5lOI4mfp+aN0WMgPQAgPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WLzvc1cL; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ql/oAqXUvoLABQHNy4a5J/AGHyfkxPWuNNjtMqs0umPaMzkHfl7DD9NuQVGXXiKMsguYgiIJYTdjFjaJIpFw6daHv+8aawLsfjiruRHp41/ETHZP8dTuDS0fjY3M6QiWcEhRGlr6BMV9KabqEwqR0EU2rPoVBTc7oi/bh3vtGGcoOxy8cDEfg8wpb+NgA+rBGXp3BC0tddo8h6l3y7fqcQrBRo3V0fvcNkw1pvTAfb8yr53n5ifO7h9P6W88ugpLbCyyJStctjV2vdQwILulroMU4q58lEkb7qP1z1UGTM7yuHDDYt+oPAioZr8eGmkeDrILWp4Yhd5tF84ofWTndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGkuZ1LSph2V4m2FW8dFZaz+lRIIkknkTkgX+G3LPxM=;
 b=LPDHqUorWTBY29d9TplhivIahxk9fGcXXsVHp+w7gIpyvE6mjdALGnBSXijkDZ0A+nciKeDL63gTbR1c7Kh12X71r+N2hYsTiac6tWEn/GQumvGknXJOIwKYuMvHICmIqS3yGwIV/qWt73ETDCgkf8PQyVNCQGvqnMMtniFRhazZRjQNCPWUq3luRqPfbJ12wbac3JafVmvS0/oYObhhzrLsymemDVbeqoBrRJm1NIPvJV791k85NiHVlHka6IaCs5h/g5G0Vw9uQyl/mMXer4ZwlY6PZOTuVmdz84KgHaInfJb+Nfel3/aaqfZLRdujuxKV6spRvdmB83UCW15NxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGkuZ1LSph2V4m2FW8dFZaz+lRIIkknkTkgX+G3LPxM=;
 b=WLzvc1cLKEJqw269nUf2rtRzv4Q5NLIFPZ4710y1qcdRqdAn8Psu+VSX8REEgwjFEZ6Ah31Yx7yt8/2wnYzMu1+BciQqulK/Ciw5oodcgMuHwpVyHitnjjv+dNrtH6R41Hucgdv47DSYaUCkm1xxw3P5n43YWI9/Ix0x/iPvCqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 17:31:39 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 17:31:39 +0000
Message-ID: <b02f2e6e-5ad2-2e7b-86a5-644f44ecdb6d@amd.com>
Date: Wed, 18 Sep 2024 18:31:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4 11/12] bnxt_en: Add TPH support in BNXT driver
Content-Language: en-US
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240822204120.3634-1-wei.huang2@amd.com>
 <20240822204120.3634-12-wei.huang2@amd.com>
 <c7b9cafc-4d9d-f443-12b5-bf3d7b178d2c@amd.com>
 <6fb7e2cf-e26d-4af5-84e4-2c56c184a1df@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6fb7e2cf-e26d-4af5-84e4-2c56c184a1df@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0157.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 94919958-f722-4ebb-7c08-08dcd807c0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlZIZzdvbXZCVW51cXJxNmlqbHB2L2NsU2hwUU04VDBUem11NW15LzM1RVRZ?=
 =?utf-8?B?SExnNzkrZzRhTUNIYUZSTEZDdUtTUlkwRSsyODhicHBBaHU1bDRpbm5UV2Rl?=
 =?utf-8?B?dXBqTC8zVEtVRXB2QjlQbjd3Y3ZkWHQyaVdrc3FZQ2ZyeGcyZkNTT2JBRFRS?=
 =?utf-8?B?TEh1VXFFNW5tZHFoREYxVFNxMmN1UDZwd05CRlBQSks5ZEtpKzU0UWVweFMy?=
 =?utf-8?B?K2huY0RxR2VXN2k2NnNacHFsMHd0Z1BtcmE1b1RHa3grRUdpOEdhYlkzV0Yy?=
 =?utf-8?B?K093K1ZwOEhVNml1dzdDbXFRcnB0SDVmdGZYL0RxSm5GS1NTK2JkL2pRRmUr?=
 =?utf-8?B?L1p6UUhqNGNneVpteTNaWVpNMUhQbEtJTlVSeWQ0WjFoRzNXZHc3MS9lYW4y?=
 =?utf-8?B?UEs5Tk1vTlNvMWZYTUlWTzkrTXFMWmZ4UXVUbER1eDVTUGx2SlFKWWxWSTg0?=
 =?utf-8?B?bmpRWktibGlrMmNyNGtYYkdGYThPL2I1ZFA4THdyZlR5cDBiZXZmWWkyL2lm?=
 =?utf-8?B?ZktKWjZ1RVc2dXBWM3pDQ002bTZLNk1RZ3pFcG1YUkgxVm9OYzhTZks3ZFh0?=
 =?utf-8?B?NnhhTWpqdEQ1eU1rMDNuM0hhaExpMVQ3TVQ5VjhWY09hMmwyOE94L1BaQmg1?=
 =?utf-8?B?dmJrd2x3YU96aktTRllQTnpvRVdTc3JpVmpuK3dvTFBBanJyYTVpRXAxVFpr?=
 =?utf-8?B?ZytPTEttMDVOR0hVaGI1ZzVYK0J4OGo1QWh6RTRlY28wMzBYdXJ6TDZJTUZm?=
 =?utf-8?B?NGZ1bWM5d3JKRkxWb0Vxb25TOVovbUpNZ0tPY1JoMmNCbnljY2RnNkJ5ZUR6?=
 =?utf-8?B?L0pNTExpMVdKNStVTHUwMDF2U3lzaHI5UytHOTJxZURrUzFQNnZOZDBtMlRt?=
 =?utf-8?B?eWVGdnB4NDNLQ3JXR0JkU2JmQUZGQWJycHpUcEpOMGhkeStUNlRSdzBRK2RW?=
 =?utf-8?B?R3RLUUt1OHlZR1FQV2FRalZtWGk0N0ZsaDBvR3hZbFA0MTFabExYUHpSRXp2?=
 =?utf-8?B?V25FUWxYTzBLdFFTbGEyc1BxRk43S09DUWtwN1NWK09uUHhNTjRxaEQ0RW1o?=
 =?utf-8?B?ZzZhbFZQaWpUYzhWTFV3SitybDVENHdwWndLOGVCQmxVdi9pUDd2d21iNW9h?=
 =?utf-8?B?V21FeGNaNnRPK0pnQjFqRHJucTYvU1FOV2g0YzVQYjJDVklXWCtTR3dQbDJX?=
 =?utf-8?B?VjdMQUVpem9idmxCak90amw2NDdZR0djb0gyY1NlanlON3czWjllaGE4RG1r?=
 =?utf-8?B?WGpQSVI0RUFpdVBJeklJQ2pGajJkRXFDSTYrZ044czBlaTBIeTM2MjRxV0d3?=
 =?utf-8?B?cnJxQWxnYk54bkdKM2M1UU5jZG9jY1JDNFB3enFrYWx0WmthTlUvKzNUQ0lt?=
 =?utf-8?B?SllQUDdyWkxXSkxxM2hXQ2lUdTZoRy85WEZLWXJXeUhMZmFmT3orOVIxdTVN?=
 =?utf-8?B?a1BFQjF5Zy9lUUFmM2xJYmwzTkRYbVp4cTN4UjNKc3RUNDJXeG0wN3ZZZE9z?=
 =?utf-8?B?M2pMMCtZME12RWdrN2VFY2NPYmJyM3ZxNkMydG80V3dEQnF4bmZjSE1TOHZi?=
 =?utf-8?B?cXJSaWNHR05Tb1hiLy9QYlRHTnBxUUhDVXZYaUx1SjNPcUw1U2NYSWRZdkZG?=
 =?utf-8?B?eUFFVWI0SGNqdlZha2FjUU1pZCtIYnRZNENhMkdFaHJzUWNXTXJMYUcrdXJE?=
 =?utf-8?B?VVlVcXNKTk5EYkNHNTdqUXM2UDAzSE1vVVQ0ZDZ5K0tteXJDMks4cUwwRVR2?=
 =?utf-8?B?VHhtNmJGU0tyUWpnb3daZkdWY1NIbEprSC9Db3NuVmpuSDFGMGJubm1YM21i?=
 =?utf-8?B?T1luTWh0ZytOeGE4b0F2QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlIzVnpDejNWSjIwNC8rdnpDM1c1ZHNIb0RpalNoNmZXeUkvT0g4L0d3ZXpl?=
 =?utf-8?B?MEp5N3F6dU9Od2RPazJsVUt1TTU2ZFh4OC9lNHo0UEJtVEFSTGp3K21QRk5w?=
 =?utf-8?B?dytWeERJRkx5ZDZMUHNVTnVNZWhjMTBqMTFxNkxjOE95L0c1LzBHWTExSjdm?=
 =?utf-8?B?YjBaRVhReEd1bWNac2FNWGxSOGRNMitUOUhBenhJVEtleGxaZnJpSjZIQmtO?=
 =?utf-8?B?NTFwQlZlZnZLWEsxY0Z4YnJZTEZTSnJMQ01jV2g1QTVQOVl0VjFocXh4cjd5?=
 =?utf-8?B?TGtZZUZZb2I1SzlHWUMxNXVEclZCRjU5aXY3M2lBM1hSenArNmhsaUgxcDZX?=
 =?utf-8?B?YksxWWY5ZWZhdGllYlJtRldBQ3JQcmdJTnM5T3BXZkRlaFEwNkpEWU5aNDVn?=
 =?utf-8?B?bWdnV3hOZ3Rwb01BTVduWFZLVjhkQWk2RzBXUERRUlJKeDFzNm5GTVltS20y?=
 =?utf-8?B?VGlVdnE5L3V2a3hOR21Oeks1YmswTXdSQmUrVEk3MWFSTHJ5SFYyVDRlYkcy?=
 =?utf-8?B?cGpyQyszUmtjU1pYZXgyOEVZM21nc3NhVE5BQ0d2L3ZRM2k0Vm9mWXdTdnRh?=
 =?utf-8?B?eHY4dFZ5S2RJMmoxS0YwUGRmMGFoTldpc2dzRW9pb1YwM2VmUVV5Z0YxRjg2?=
 =?utf-8?B?ZVRpVElhQzg0MUl4YzBYbEx1U1g5WXJjNHVJR0I3S29NNldjWW0rNjNqQTZU?=
 =?utf-8?B?NTNVTXRkeENzQTFTU0h5ZHNDUGU1US9XNHM5QWxRc0pyYzByQXU5WHNWZGlt?=
 =?utf-8?B?bC9xbklZV0pIOVg4U0grRkdDMmhTNTdSTW5iVThuM2pGUUVMZjk3UHVoY2J3?=
 =?utf-8?B?Vy9iVHRESFlYTERaS1hZenFyZlgzL0QzU0hZR2hYQjNtWkVWcVhnTXliTjFO?=
 =?utf-8?B?d2F0Z2Y0QURCdDd6ekFoblRFQXdHL0RkL2FjQXk5SzFVM3BvMVFzdUFJamg3?=
 =?utf-8?B?TUpSZXNvOTZpblM4eUw3MUdyRnVkRUQvVlJySUdNWFhEcmRKbVpnMGRLVFB5?=
 =?utf-8?B?TUFTc1B4d1EwNXJMSlpleDBVT1N3c3F1elRiL3VIcGExVkZBRjJ3MWtRSFVh?=
 =?utf-8?B?THgxTUFxbE1uQlhGd0I1ZStMeDRVSDZacWpCUWtQSEUwOUsxM1hzdUV6WlUz?=
 =?utf-8?B?ekRTV0hBTTFzNWREOG9iTXJFVG5RRHpxbTkyNjdyTkJlL0plOEpxMmExdHZD?=
 =?utf-8?B?bENTdzk4b0tGakZQZG5PMEw0Tm9GbG5QOGxDY012dzJubUtacnRSZW4zQUlQ?=
 =?utf-8?B?Nm5wa21sWnZac0p0dWxvMUJmR2JPN01TVElORTEvWTFGaHgvZWUwV2hzaXZy?=
 =?utf-8?B?c3F3NGQ2VVRCU3RXRzM1aHJ4dDQ1TWlETmYxemFQV01GYzM0cS90bURQT3Zq?=
 =?utf-8?B?Q25SQmRUdXZ4bHVqME5CS1JYWEhIaTJvMjlBd1A5ak9pY2xoNmIzQjRNUzRN?=
 =?utf-8?B?TzBsQ1dwZ3prK0FjdWwvaE1wT2hWbGJtZEE1dFZjcUR1cXdmckhZNXY1cDBh?=
 =?utf-8?B?OXNDWTJrYjZqV3VuUnBZR0g3WkVBTnR2NmpnU1pPaVBPb2hVTGovUmNmWWU4?=
 =?utf-8?B?ZExTY25EWVF5OUtOMk02Qkt0U2V6akVHM041Qy9NbkZxMFdVbXNCZFRpcGNp?=
 =?utf-8?B?azFyT3V4dm5WQ2hkSVVna1FlL0pTMzdtS2NFWXdidG9LYUJ6ZzlocXBqYmVu?=
 =?utf-8?B?QzZ1TVVjN0g1SHVaK2FJWjlNL1NOM3ljSGdlK0gvMXo2ay9FRVBOWERqR21s?=
 =?utf-8?B?RVNqRHBTeDBKbVdTOXA5NERYZWJ1UkNJM01SWjRpdHR2UVc3WndOVndESW1w?=
 =?utf-8?B?Mm5vZXArazdmaWMvUGk1cVNwRUpaYjg0MU9kWnE0aEZhazRyN2l2alZ4TE1C?=
 =?utf-8?B?SG85SGVoRjY4aG1tUks2WEdOeTBxRFhLbFk0cWRZR2dqWmk2OUdNRUw3WHRp?=
 =?utf-8?B?V2xzQWpYQXovOXpMVW4wSVF4VkQyTDY1bkhqTWhQOGcwUHBhMTNnMjJSM2ZS?=
 =?utf-8?B?MlhHbUxwOXd5QURpU1lQbUQvbVZtTmMwdVZPUG9MNmNQY3RQN0FYVnloMGdv?=
 =?utf-8?B?L2wvM3d2bXJkVWQyWWVDUExSeCt2OUtsR0NsL05ib1BwTXVsVEtFTnVpb0th?=
 =?utf-8?Q?vASssvofGgOyXsv2NXWpWYpzT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94919958-f722-4ebb-7c08-08dcd807c0c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 17:31:39.2729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jkdFtaMQMSPaOBQoURHW0kOEKZOn9+Qm1Y1pwjKS4303R+B5FrfaBtT1MWhWyPZ7+MzgV6q6E/5CuXYi0j9LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421


On 9/16/24 19:55, Wei Huang wrote:
>
>
> On 9/11/24 10:37 AM, Alejandro Lucero Palau wrote:
>>
>> On 8/22/24 21:41, Wei Huang wrote:
>>> From: Manoj Panicker <manoj.panicker2@amd.com>
>>>
>>> Implement TPH support in Broadcom BNXT device driver. The driver uses
>>> TPH functions to retrieve and configure the device's Steering Tags when
>>> its interrupt affinity is being changed.
>>>
>>> Co-developed-by: Wei Huang <wei.huang2@amd.com>
>>> Signed-off-by: Wei Huang <wei.huang2@amd.com>
>>> Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
>>> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
>>> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
>>> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
>>> ---
>>>    drivers/net/ethernet/broadcom/bnxt/bnxt.c | 78 
>>> +++++++++++++++++++++++
>>>    drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++
>>>    2 files changed, 82 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c 
>>> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> index ffa74c26ee53..5903cd36b54d 100644
>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> @@ -55,6 +55,7 @@
>>>    #include <net/page_pool/helpers.h>
>>>    #include <linux/align.h>
>>>    #include <net/netdev_queues.h>
>>> +#include <linux/pci-tph.h>
>>>       #include "bnxt_hsi.h"
>>>    #include "bnxt.h"
>>> @@ -10821,6 +10822,58 @@ int bnxt_reserve_rings(struct bnxt *bp, 
>>> bool irq_re_init)
>>>        return 0;
>>>    }
>>>    +static void __bnxt_irq_affinity_notify(struct 
>>> irq_affinity_notify *notify,
>>> +                       const cpumask_t *mask)
>>> +{
>>> +    struct bnxt_irq *irq;
>>> +    u16 tag;
>>> +
>>> +    irq = container_of(notify, struct bnxt_irq, affinity_notify);
>>> +    cpumask_copy(irq->cpu_mask, mask);
>>> +
>>> +    if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
>>> +                cpumask_first(irq->cpu_mask), &tag))
>>
>>
>> I understand just one cpu from the mask has to be used, but I wonder if
>> some check should be done for ensuring the mask is not mad.
>>
>> This is control path and the related queue is going to be restarted, so
>> maybe a sanity check for ensuring all the cpus in the mask are from the
>> same CCX complex?
>
> I don't think this is always true and we shouldn't warn when this 
> happens. There is only one ST can be supported, so the driver need to 
> make a good judgement on which ST to be used. But no matter what, ST 
> is just a hint - it shouldn't cause any correctness issues in HW, even 
> when it is not the optimal target CPU. So warning is unnecessary.
>

1) You can use a "mad" mask for avoiding a specific interrupt to disturb 
a specific execution is those cores not part of the mask. But I argue 
the ST hint should not be set then.


2) Someone, maybe an automatic script, could try to get the best 
performance possible, and a "mad" mask could preclude such outcome 
inadvertently.


I agree a warning could not be a good idea because 1, but I would say 
adding some way of traceability here could be interesting. A tracepoint 
or a new ST field for last hint set for that interrupt/queue.


>>
>> That would be an iteration checking the tag is the same one for all of
>> them. If not, at least a warning stating the tag/CCX/cpu used.
>>
>>
>>> +        return;
>>> +
>>> +    if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
>>> +        return;
>>> +
>>> +    if (netif_running(irq->bp->dev)) {
>>> +        rtnl_lock();
>>> +        bnxt_close_nic(irq->bp, false, false);
>>> +        bnxt_open_nic(irq->bp, false, false);
>>> +        rtnl_unlock();
>>> +    }
>>> +}
>>> +
>>> +static void __bnxt_irq_affinity_release(struct kref __always_unused 
>>> *ref)
>>> +{
>>> +}
>>> +
>>> +static void bnxt_release_irq_notifier(struct bnxt_irq *irq)
>>> +{
>>> +    irq_set_affinity_notifier(irq->vector, NULL);
>>> +}
>>> +
>>> +static void bnxt_register_irq_notifier(struct bnxt *bp, struct 
>>> bnxt_irq *irq)
>>> +{
>>> +    struct irq_affinity_notify *notify;
>>> +
>>> +    /* Nothing to do if TPH is not enabled */
>>> +    if (!pcie_tph_enabled(bp->pdev))
>>> +        return;
>>> +
>>> +    irq->bp = bp;
>>> +
>>> +    /* Register IRQ affinility notifier */
>>> +    notify = &irq->affinity_notify;
>>> +    notify->irq = irq->vector;
>>> +    notify->notify = __bnxt_irq_affinity_notify;
>>> +    notify->release = __bnxt_irq_affinity_release;
>>> +
>>> +    irq_set_affinity_notifier(irq->vector, notify);
>>> +}
>>> +
>>>    static void bnxt_free_irq(struct bnxt *bp)
>>>    {
>>>        struct bnxt_irq *irq;
>>> @@ -10843,11 +10896,17 @@ static void bnxt_free_irq(struct bnxt *bp)
>>>                    free_cpumask_var(irq->cpu_mask);
>>>                    irq->have_cpumask = 0;
>>>                }
>>> +
>>> +            bnxt_release_irq_notifier(irq);
>>> +
>>>                free_irq(irq->vector, bp->bnapi[i]);
>>>            }
>>>               irq->requested = 0;
>>>        }
>>> +
>>> +    /* Disable TPH support */
>>> +    pcie_disable_tph(bp->pdev);
>>>    }
>>>       static int bnxt_request_irq(struct bnxt *bp)
>>> @@ -10870,6 +10929,13 @@ static int bnxt_request_irq(struct bnxt *bp)
>>>        if (!(bp->flags & BNXT_FLAG_USING_MSIX))
>>>            flags = IRQF_SHARED;
>>>    +    /* Enable TPH support as part of IRQ request */
>>> +    if (pcie_tph_modes(bp->pdev) & PCI_TPH_CAP_INT_VEC) {
>>> +        rc = pcie_enable_tph(bp->pdev, PCI_TPH_CAP_INT_VEC);
>>> +        if (rc)
>>> +            netdev_warn(bp->dev, "failed enabling TPH support\n");
>>> +    }
>>> +
>>>        for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
>>>            int map_idx = bnxt_cp_num_to_irq_num(bp, i);
>>>            struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
>>> @@ -10893,8 +10959,10 @@ static int bnxt_request_irq(struct bnxt *bp)
>>>               if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
>>>                int numa_node = dev_to_node(&bp->pdev->dev);
>>> +            u16 tag;
>>>                   irq->have_cpumask = 1;
>>> +            irq->msix_nr = map_idx;
>>>                cpumask_set_cpu(cpumask_local_spread(i, numa_node),
>>>                        irq->cpu_mask);
>>>                rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
>>> @@ -10904,6 +10972,16 @@ static int bnxt_request_irq(struct bnxt *bp)
>>>                            irq->vector);
>>>                    break;
>>>                }
>>> +
>>> +            bnxt_register_irq_notifier(bp, irq);
>>> +
>>> +            /* Init ST table entry */
>>> +            if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
>>> +                        cpumask_first(irq->cpu_mask),
>>> +                        &tag))
>>> +                break;
>>> +
>>> +            pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag);
>>>            }
>>>        }
>>>        return rc;
>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h 
>>> b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>>> index 6bbdc718c3a7..ae1abcc1bddf 100644
>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>>> @@ -1224,6 +1224,10 @@ struct bnxt_irq {
>>>        u8        have_cpumask:1;
>>>        char        name[IFNAMSIZ + 2];
>>>        cpumask_var_t    cpu_mask;
>>> +
>>> +    struct bnxt    *bp;
>>> +    int        msix_nr;
>>> +    struct irq_affinity_notify affinity_notify;
>>>    };
>>>       #define HWRM_RING_ALLOC_TX    0x1

