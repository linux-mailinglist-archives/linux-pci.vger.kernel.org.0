Return-Path: <linux-pci+bounces-36141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FA0B5781C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 13:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADAF444D8C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345992FF16D;
	Mon, 15 Sep 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="guK+37wA"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8302FF143
	for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935657; cv=fail; b=joDxWhNmxFnWxDKaI4xEPkTzPS3PUHVQ5QEFrBKili5TJS66BtOv/SsGNFBks5CxoUSIDV9dWwUSnCAN1ypPPIMGLVueK35TZ0sRoiow4O3ig9VM1o2NuDmng5evWm2Q5RjIAnayYtKWzcJ6l1KIuWqxoksi2cIJK3Zqvi2c8BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935657; c=relaxed/simple;
	bh=0zSSuKBsyvp8NgjerD8qWbJ0je0Pg5jdeF82L3Rkb+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D80wPx5m/3KIMEKOOdViKh6WBmsrzaLzauyfCiLlXBwRi5Uv4ZYn6Z1T7uc3hyxR14j0Fib6d7hQDnkqEt7ISmZgtEt6s+DxuVjOwsktGdAKUfdMsPKLVFd3Omz3DWcJVTYH49tTZ+ziq6B7wM+MxZertkYwx59gSI0teEyl3qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=guK+37wA; arc=fail smtp.client-ip=52.101.85.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AC2r6BuTzPjfT5QgYnECx+L3qVExcJ9iK25sJTq6zve0uhetDaczm9IrkHunEvmjyGBJgQ0m0bsLhCrDe/FSfe49AHnRhGe49pBlsvLdMtqLtyfpJHTYTT0WYoAPvlf8tWPu/Asp2TzXk9Drq0nwV6YU0qPWAIXqfYAHq55iWMdbpvjldC4hw48ugmbdCXG0q3Qk6VfmgP7bhh38F/QJFphdybqjq8t0miO68dm4SkgvfnNVECvYsnFibXYbnrozAo0XY3vGHgtIsIYs8KMpk4YGTz1y088G/uVg7rN8v6ZnYxIa1T3ipB37s0g9wR/CujDS6k0pI/mvqASyizhPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IovyHcnwG4phsVn8xLKNRQFHdWLHHJTkcg7EduxyneQ=;
 b=vnTdg2tf9awpdEMFQbn3LLqbu//f19nTrPSg+uIgJc0do0M0lkj11HBhrrp0uIVe4+qLZ7QwqtS56M4qO1bG1Nh5YG9Zjh5J69w1bfOC29XLxEt2Hf27kCXCxO8d2zxXBiO6hWQTWfb9jYFJS1vPKU/tIPPJyoBMT21sKr8AxLXKcXsGyKrVNZ4KdbZICeXHhQnkQr5pCbeoas1Gl28hp1XcOeoBgvBwV8ggEOuWS6oFEC63GBeJQDYij3iTr/RjJf0w4noYmQh3do7geQm6+DayWv9LnZ5ge4mEiBNH8PIRkXR/+qWDO9LcQjZY2xsyKyOHw2ySmRQyIuTeMGxORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IovyHcnwG4phsVn8xLKNRQFHdWLHHJTkcg7EduxyneQ=;
 b=guK+37wAEdQJeA5vevWmsT5RphRZ1IYHPZ8ac/MvOaGc35WORSFvdak694j58WJxfk18M/cBmCwG5fYetuj/+3mdBpSA/1dpqHQmayCuKdnRuS2tNLj+JaBUojoBGLZa9GunHdB/pyU5UE8l4OGvbbqnpl2bBgxSIpn8/AWc6B0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 11:27:29 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 11:27:29 +0000
Message-ID: <22cbe028-c1ad-456f-a046-12b4559394b4@amd.com>
Date: Mon, 15 Sep 2025 21:27:23 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH resend v6 04/10] PCI/TSM: Authenticate devices via
 platform TSM
To: Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
 <20250911235647.3248419-5-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250911235647.3248419-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYCP282CA0006.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::18) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: e9127e77-c7ef-4a49-a117-08ddf44adaa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3VWQjNYTDM4ZHV2NjVHQitETHFka1M0aXZHTTlBYTNQOE1BRXhMa2RlTWcz?=
 =?utf-8?B?L0hhTTRmbWZ6c1J0M0NsWmk4WFJZV3hsN0ZhaGhHWFdOY040MGFTV0VDV0gy?=
 =?utf-8?B?VlplN0lncC93SWRiTitMd1BWNG1OK2Q1SFlZdlNlZS9yWnI1QnozMEZUR256?=
 =?utf-8?B?R2IyQU42blpZMUJtZnRsVzNVdWQzbnVQNk5UN3BMbTg0NnhxNWhGRldiZUhS?=
 =?utf-8?B?c08rTlRxSmcxQVIxbVZVRFBINlg3VE1yTFU1cG5aeU4xeUJ2WDBLa2phTkFx?=
 =?utf-8?B?VjNVZTVwQkJaclhHc1Z1VVVmYWl1ZjBzWW42bXBrakw0RENwdHZHTVd2MVVC?=
 =?utf-8?B?NnpTRFhkcFpCZmx6b0NEam96VHpEcEUrby9ZVE1hTFRPazN0b0VwWDhtMVhC?=
 =?utf-8?B?Uk81ajkvT3BYZHRiVTJmT0FIcFdXampNbFBnOUE0UzdBUXhTVWJQaURtQXF6?=
 =?utf-8?B?aDM1R1A0YnVaKzhaT3Z3M1JnUi9PV21UYUtINjlPTXE4SG1FOW9sRW9pdldC?=
 =?utf-8?B?ODVEYW1scWQ4cnpHSm9FYlNyOFhnOFpoU2paT1c1dG9IbUdRbi9pR2FLSmdF?=
 =?utf-8?B?clk2YXozeGduUFJ6S2t5UWpHeGRDUmZ3aFRUOXBySXp2Tmw1SVFqSkVGelh5?=
 =?utf-8?B?WExPenJnQUZVc1kxeGxiS3RGaUFCdGZWN1FYeU1JN3FWbzR3VlA1QXFzckUy?=
 =?utf-8?B?ajZTdUpVYW1PalJadWtzZHlUTlZnRlZiRGphLzA5ZWFtdTdFYzR0WmUyWkw2?=
 =?utf-8?B?am5SWGdHanY4Q1p5ZFFLWDJUOXRWTmFuai9HZTNPN2ZoZUdhU1MwVWRUWkNT?=
 =?utf-8?B?eG92b2I4WDloYWFzVlZpdlM5Rjk5c3FkYmZRSGlpZGVIb1dIV0FVTnNWc3dz?=
 =?utf-8?B?bmNVbjZMZ3VvL0x2ZXdQMzdtUGI0UVVobjlacVM1bnFWd0hXMTgyMzlxNUJK?=
 =?utf-8?B?YVRoWDFOczJ6K2dPYnJoZHoxd2VqNWphdEU1blRQSzQrbDdzbFNuOHRSRG43?=
 =?utf-8?B?MjRYc1A4TGFJbnY2blpLbHRqdmV0ZkhZZ0pLaExZb0p1RVlaYmFRbE1LT2I2?=
 =?utf-8?B?dG9QdlVNQ0RndUVTRnhxR2F0d2hmd0N2Rml5SWRqeVlmSTZJSTk1bzVwaW82?=
 =?utf-8?B?dXlVemxFMlZVaTFjbXptSDRkRE5Kb28yc3hoUTdzUzdueW05bnlNUXhvSHNu?=
 =?utf-8?B?MVBkMjJQMlRiS3ljMHhaUnFyalozMzU1ZE1SdjJ1ZlZLMDlCNWppdE9WTkoy?=
 =?utf-8?B?TXFYa2JqMWVjTTNWdjlJVE5mSTFQR01UaUs3WGpQMnltTjNsYjZJRzVjalpL?=
 =?utf-8?B?a0o2WUJtMjNMMnhySnFUV3lRZllxdno1elBMc1Z5ZVBIdE5URXpqZU5jQVFw?=
 =?utf-8?B?ZWF1dWZ1SjlrZnVlQ0JtTDE3Yzlma3dwcVZYZm5hY1lLT0JsU3lLNTdsZkpQ?=
 =?utf-8?B?akF2b1BlZ2NySVBjSnNvNlR2WTN5RUtZNHg0aHo1QWsyZzdnbm9IZnVXRGt2?=
 =?utf-8?B?RHRERDlXdlkxa2s5elNNckNNRE5hd2lKRkF4MzJwUmtIVVlrbG5IM3NFSzBJ?=
 =?utf-8?B?VURnZDAxaTk5VWZGVW1leWxnTmFKZDNaQUlnZEJYRXpMOEhBOFNQRys5Zzgy?=
 =?utf-8?B?cWk0a0dmckIwWDc1dVJkcloxbjlhNFBUOGJFUmxFQXZ1dGxmaHZRZE9XTmVr?=
 =?utf-8?B?SFdld0tlWk9RVWhERkZVSmZHcGlnZUJucEYvK1QvMzQ0M2lHQVlvbFdlUmU1?=
 =?utf-8?B?ZGsyQ3duUjJxQmhYSTFjSm0yNXM5N01ha2JuaGRaMTIzZlltcG4wS3BHdjU3?=
 =?utf-8?B?RllHSVpuSU1ZTHJxUGNCOUU4dDA4Y3hFMWxJM0ZWN1N3Vkw2MmZZaWlzb0xm?=
 =?utf-8?B?ZVdKWGREUGszbFJaZGYxYStkN1RQb0diT210SjVTZzZ2R3NEOVJXTTI5aGNW?=
 =?utf-8?Q?89KZd9E6R8k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2VEUHFIaUZMaHg4cW9VdzdIb2pyeWVvLzA1N3YzZ2Y0Y0d3eklNMEc1NGxK?=
 =?utf-8?B?bnEzTXd0Mmt2WGc1SVJobGN3YWp6bFkzSDBNL2c3Z1A2bHg5Zm4rZC8rZzZs?=
 =?utf-8?B?OUM2QzZ1blFwemc1ZzlxSjBjWW9iWXhSVTZUaHAzQk1sT2R3bmFJMkx3d0Mw?=
 =?utf-8?B?UHlzMUdkbURPcTR1T1p0UlZCWWF0TkgyK3UwcU5lOWxBWUYrNHhIMWNWMjc1?=
 =?utf-8?B?R1RUTk05RlpBcTBlZGFPbmNFdndaTW5Tc2EyMk9jNXVEU293VmVwZHhqNmJp?=
 =?utf-8?B?Rk44MjNSeDZ2UVlFMm9tb3gwMFZCZ2UwaG1nU3lPdU9wYmg2am9meXNHc09l?=
 =?utf-8?B?UFVvK282eUlENGU1WFNyeERsTlJ3c3lGY1h0NEEzRDRLWGwyMkJJb0RORGsr?=
 =?utf-8?B?bkpsSGNpcVM5c0JFU0U4WlV6VHpZcU1PbjE4ajViY3JWQ0diOXQ5N3lFYTU1?=
 =?utf-8?B?WW1IRS9WN1plcGdWK2tTNDFhUFlmT2NvenhNTWlCUkp4RG9iZVlTYWpJQmww?=
 =?utf-8?B?Zkw0eWRmWjlzekhYMmZhZjZFTEdrSlRVVkhFTTdWcTRYNGhSckF2ZVpQMjY3?=
 =?utf-8?B?bXNWT1kwRlpNZkp2UUlqeXVmNEg2T1JmS0FiS1IwU0dJTWdHamRibnduSkhW?=
 =?utf-8?B?eUptWDNuV3lNeEdQSWYycG5UQmxEejJMZzJNZjVjOEY1VUZPQVpHN05LSG44?=
 =?utf-8?B?L3ZmZW54T1BZbHdaN3R5ZkE2emlESnNtOUt2a00vdXlVeDNzRWtXS25DaERp?=
 =?utf-8?B?Zkh3K0l1WGVrZlFWTG5QWDZxd095enJsbUJOTzBFOWx3Z1hURlYvZlZBY1BK?=
 =?utf-8?B?akJiSGJrbE5keVdxVVBtaVkyYmFIc2lDa3F0akpMbTYvKzIzWTIzM1ZQVkJY?=
 =?utf-8?B?U3o1Yjl4MHFVTi94WExXc05aNFUzNUVtQUI5L2J0T0Y4M04zaXBWei96SUdy?=
 =?utf-8?B?SW9XdmM4NHhkK0YrOUtVUy9PeVQ4NzJOU2U2WHZEQ3ZCWXFQZmlOQW5RRW1K?=
 =?utf-8?B?RHVUU3hWMFQ4dklyVmRhSkVWZ3VKenNzNlFGSCtYRkRsSVhBWXB4dWkza0lt?=
 =?utf-8?B?bkd0UVkvTUZsbzJSVHNhNkN5L042S2t0U0pJTVhqU01BaVVkckV2OUJUT3BP?=
 =?utf-8?B?NUZQVnova3RuQ2JZcVhEaUZrWVI4SkVsdCt5SmlHMkx1SEVRSHE3cWcySDNC?=
 =?utf-8?B?SHRMQ0dTSk53YXN2UmpXOENKblE5ZVBVOW5RZytYUWlURDRmZTNyOE5YSktV?=
 =?utf-8?B?dzhFZVlmdlMzK3A3Q3p2bkRTNmp1TjdSRjk1bzZxUHpVVi9ZZnM4N2orTy9I?=
 =?utf-8?B?UkFZanB5amtNbWR2T3FxaGpmRk1tbk0xTnU2VVlDcVp3dEY5MDdrRUVqQngx?=
 =?utf-8?B?QVQyQWRMQjBxNjEra0JUQ3FzdkVjSU40WGhwLytwSEdYWXpBK2lYNHlibU9G?=
 =?utf-8?B?QkozRW1MYXhyU3VPdks5QlJaSVQyWHZqUXMyQmlNTWlOaGh0YXp3MzJmOEJz?=
 =?utf-8?B?Rk80QTBaRjV1QWV3MUYvVm1QQmV5QVZ4VTNBTTNDby9IbVlRTTNqV2xDUFBE?=
 =?utf-8?B?NnJhV2V2VTY4bTFQcjNqRHNSVzVUalVFUmJOcjZlZVRSR2pkUjVwbXQ0S1hB?=
 =?utf-8?B?S0lmOGNQRTA0UjE3VElXZ0ZERVZQSHFBb096TFhjTGZGVGd4TFhNemJqbUtJ?=
 =?utf-8?B?WStGcFBvRTBBWllHMGl5TW1qOExZT3Zvb3F1K2R2UkplNitvL2RkbXhBRmJk?=
 =?utf-8?B?NTVPVENydnl3UGs3SUpnWk9mUkgwN0xEVGdYSld6VDZsbjJ1T3dLRkNWbnRU?=
 =?utf-8?B?aEJCTGhHeWp4ZFlyT3p4TmNpSU5Fc05iYWpGbEFJc2tsc0diZG9Kb1RlSmNG?=
 =?utf-8?B?ZXoxTFVNRFkxNmJ5ZHZ4N3RnQkFFbUhPWkpMa1RHclcrVkp4TkU0bkJUSjdI?=
 =?utf-8?B?WkZ1YUZpOGY5Y25LK1ByVFhrV3pxNllQL3JCbTQ3K1c2ZW51NkJ2OGdxemVz?=
 =?utf-8?B?U0pQM2p2UEJJWlo2VWtMaEVxTk1BRVMxSzBzUU9NTW1HQWtJcFIweG1acWNl?=
 =?utf-8?B?eXZJYXEvK2JYeHJRQWFkNG43dVZrR0wxZDZLc1RPdTV4cmRmSVRnakkxZmlt?=
 =?utf-8?Q?Iv4y/b1eQhhcn8a+cf77QxFJt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9127e77-c7ef-4a49-a117-08ddf44adaa6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 11:27:29.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lih4KUVPzELMmf3r+cIlGD1OwK8iSu/7yTMK7tLiWsazbZ0EAzRnYAWEOa742eFScoK3MFXGNEyLzxKm0Ag6OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368



On 12/9/25 09:56, Dan Williams wrote:
> The PCIe 7.0 specification, section 11, defines the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> protocol definition builds upon Component Measurement and Authentication
> (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> assigning devices (PCI physical or virtual function) to a confidential VM
> such that the assigned device is enabled to access guest private memory
> protected by technologies like Intel TDX, AMD SEV-SNP, RISCV COVE, or ARM
> CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a "DSM" (Device Security Manager) and
> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> to setup link security and assign devices. A confidential VM uses TSM
> ABIs to transition an assigned device into the TDISP "RUN" state and
> validate its configuration. From a Linux perspective the TSM abstracts
> many of the details of TDISP, IDE, and CMA. Some of those details leak
> through at times, but for the most part TDISP is an internal
> implementation detail of the TSM.
> 
> CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
> Userspace can watch for the arrival of a "TSM" device,
> /sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
> initialized TSM services.
> 
> The operations that can be executed against a PCI device are split into
> two mutually exclusive operation sets, "Link" and "Security" (struct
> pci_tsm_{link,security}_ops). The "Link" operations manage physical link
> security properties and communication with the device's Device Security
> Manager firmware. These are the host side operations in TDISP. The
> "Security" operations coordinate the security state of the assigned
> virtual device (TDI). These are the guest side operations in TDISP. Only
> link management operations are defined at this stage and placeholders
> provided for the security operations.
> 
> The locking allows for multiple devices to be executing commands
> simultaneously, one outstanding command per-device and an rwsem
> synchronizes the implementation relative to TSM
> registration/unregistration events.
> 
> Thanks to Wu Hao for his work on an early draft of this support.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-pci |  51 ++
>   Documentation/driver-api/pci/index.rst  |   1 +
>   Documentation/driver-api/pci/tsm.rst    |  12 +
>   MAINTAINERS                             |   4 +-
>   drivers/pci/Kconfig                     |  15 +
>   drivers/pci/Makefile                    |   1 +
>   drivers/pci/doe.c                       |   2 -
>   drivers/pci/pci-sysfs.c                 |   4 +
>   drivers/pci/pci.h                       |  10 +
>   drivers/pci/probe.c                     |   3 +
>   drivers/pci/remove.c                    |   6 +
>   drivers/pci/tsm.c                       | 627 ++++++++++++++++++++++++
>   drivers/virt/coco/tsm-core.c            |  40 +-
>   include/linux/pci-doe.h                 |   4 +
>   include/linux/pci-tsm.h                 | 159 ++++++
>   include/linux/pci.h                     |   3 +
>   include/linux/tsm.h                     |  11 +-
>   include/uapi/linux/pci_regs.h           |   1 +


A suggestion: "git format-patch -O ~/orderfile ..." produces nicer-to-review order of files especially where there are new interfaces being added.

===
*.txt
configure
Kconfig*
*Makefile*
*.json
*.h
*.c
===


>   18 files changed, 943 insertions(+), 11 deletions(-)
>   create mode 100644 Documentation/driver-api/pci/tsm.rst
>   create mode 100644 drivers/pci/tsm.c
>   create mode 100644 include/linux/pci-tsm.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 69f952fffec7..e0c8dad8d889 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -612,3 +612,54 @@ Description:
>   
>   		  # ls doe_features
>   		  0001:01        0001:02        doe_discovery
> +
> +What:		/sys/bus/pci/devices/.../tsm/
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		This directory only appears if a physical device function
> +		supports authentication (PCIe CMA-SPDM), interface security
> +		(PCIe TDISP), and is accepted for secure operation by the
> +		platform TSM driver. This attribute directory appears
> +		dynamically after the platform TSM driver loads. So, only after
> +		the /sys/class/tsm/tsm0 device arrives can tools assume that
> +		devices without a tsm/ attribute directory will never have one;
> +		before that, the security capabilities of the device relative to
> +		the platform TSM are unknown. See
> +		Documentation/ABI/testing/sysfs-class-tsm.
> +
> +What:		/sys/bus/pci/devices/.../tsm/connect
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Write the name of a TSM (TEE Security Manager) device from
> +		/sys/class/tsm to this file to establish a connection with the
> +		device.  This typically includes an SPDM (DMTF Security
> +		Protocols and Data Models) session over PCIe DOE (Data Object
> +		Exchange) and may also include PCIe IDE (Integrity and Data
> +		Encryption) establishment. Reads from this attribute return the
> +		name of the connected TSM or the empty string if not
> +		connected. A TSM device signals its readiness to accept PCI
> +		connection via a KOBJ_CHANGE event.
> +
> +What:		/sys/bus/pci/devices/.../tsm/disconnect
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(WO) Write the name of the TSM device that was specified
> +		to 'connect' to teardown the connection.
> +
> +What:		/sys/bus/pci/devices/.../authenticated
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		When the device's tsm/ directory is present device
> +		authentication (PCIe CMA-SPDM) and link encryption (PCIe IDE)
> +		are handled by the platform TSM (TEE Security Manager). When the
> +		tsm/ directory is not present this attribute reflects only the
> +		native CMA-SPDM authentication state with the kernel's
> +		certificate store.
> +
> +		If the attribute is not present, it indicates that
> +		authentication is unsupported by the device, or the TSM has no
> +		available authentication methods for the device.
> +
> +		When present and the tsm/ attribute directory is present, the
> +		authenticated attribute is an alias for the device 'connect'
> +		state. See the 'tsm/connect' attribute for more details.
> diff --git a/Documentation/driver-api/pci/index.rst b/Documentation/driver-api/pci/index.rst
> index a38e475cdbe3..9e1b801d0f74 100644
> --- a/Documentation/driver-api/pci/index.rst
> +++ b/Documentation/driver-api/pci/index.rst
> @@ -10,6 +10,7 @@ The Linux PCI driver implementer's API guide
>   
>      pci
>      p2pdma
> +   tsm
>   
>   .. only::  subproject and html
>   
> diff --git a/Documentation/driver-api/pci/tsm.rst b/Documentation/driver-api/pci/tsm.rst
> new file mode 100644
> index 000000000000..59b94d79a4f2
> --- /dev/null
> +++ b/Documentation/driver-api/pci/tsm.rst
> @@ -0,0 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +========================================================
> +PCI Trusted Execution Environment Security Manager (TSM)
> +========================================================
> +
> +.. kernel-doc:: include/linux/pci-tsm.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/pci/tsm.c
> +   :export:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 024b18244c65..f1aabab88c79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25619,8 +25619,10 @@ L:	linux-coco@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/ABI/testing/configfs-tsm-report
>   F:	Documentation/driver-api/coco/
> +F:	Documentation/driver-api/pci/tsm.rst
> +F:	drivers/pci/tsm.c
>   F:	drivers/virt/coco/guest/
> -F:	include/linux/tsm*.h
> +F:	include/linux/*tsm*.h
>   F:	samples/tsm-mr/
>   
>   TRUSTED SERVICES TEE DRIVER
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 105b72b93613..0183ca6f6954 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -136,6 +136,21 @@ config PCI_IDE_STREAM_MAX
>   	  platform capability for the foreseeable future is 4 to 8 streams. Bump
>   	  this value up if you have an expert testing need.
>   
> +config PCI_TSM
> +	bool "PCI TSM: Device security protocol support"
> +	select PCI_IDE
> +	select PCI_DOE
> +	select TSM
> +	help
> +	  The TEE (Trusted Execution Environment) Device Interface
> +	  Security Protocol (TDISP) defines a "TSM" as a platform agent
> +	  that manages device authentication, link encryption, link
> +	  integrity protection, and assignment of PCI device functions
> +	  (virtual or physical) to confidential computing VMs that can
> +	  access (DMA) guest private memory.
> +
> +	  Enable a platform TSM driver to use this capability.
> +
>   config PCI_DOE
>   	bool "Enable PCI Data Object Exchange (DOE) support"
>   	help
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 6612256fd37d..2c545f877062 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
>   obj-$(CONFIG_PCI_IDE)		+= ide.o
> +obj-$(CONFIG_PCI_TSM)		+= tsm.o
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>   obj-$(CONFIG_PCI_NPEM)		+= npem.o
>   obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index aae9a8a00406..62be9c8dbc52 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -24,8 +24,6 @@
>   
>   #include "pci.h"
>   
> -#define PCI_DOE_FEATURE_DISCOVERY 0
> -
>   /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
>   #define PCI_DOE_TIMEOUT HZ
>   #define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5eea14c1f7f5..367ca1bc5470 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1815,6 +1815,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>   #endif
>   #ifdef CONFIG_PCI_DOE
>   	&pci_doe_sysfs_group,
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	&pci_tsm_auth_attr_group,
> +	&pci_tsm_attr_group,
>   #endif
>   	NULL,
>   };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 56851e73439b..0e24262aa4ba 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -525,6 +525,16 @@ void pci_ide_init(struct pci_dev *dev);
>   static inline void pci_ide_init(struct pci_dev *dev) { }
>   #endif
>   
> +#ifdef CONFIG_PCI_TSM
> +void pci_tsm_init(struct pci_dev *pdev);
> +void pci_tsm_destroy(struct pci_dev *pdev);
> +extern const struct attribute_group pci_tsm_attr_group;
> +extern const struct attribute_group pci_tsm_auth_attr_group;
> +#else
> +static inline void pci_tsm_init(struct pci_dev *pdev) { }
> +static inline void pci_tsm_destroy(struct pci_dev *pdev) { }
> +#endif
> +
>   /**
>    * pci_dev_set_io_state - Set the new error state if possible.
>    *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4fd6942ea6a8..7207f9a76a3e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2738,6 +2738,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>   	ret = device_add(&dev->dev);
>   	WARN_ON(ret < 0);
>   
> +	/* Establish pdev->tsm for newly added (e.g. new SR-IOV VFs) */
> +	pci_tsm_init(dev);
> +
>   	pci_npem_create(dev);
>   
>   	pci_doe_sysfs_init(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 445afdfa6498..4b9ad199389b 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -55,6 +55,12 @@ static void pci_destroy_dev(struct pci_dev *dev)
>   	pci_doe_sysfs_teardown(dev);
>   	pci_npem_remove(dev);
>   
> +	/*
> +	 * While device is in D0 drop the device from TSM link operations
> +	 * including unbind and disconnect (IDE + SPDM teardown).
> +	 */
> +	pci_tsm_destroy(dev);
> +
>   	device_del(&dev->dev);
>   
>   	down_write(&pci_bus_sem);
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..724a58e3ccf1
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,627 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TEE Security Manager for the TEE Device Interface Security Protocol
> + * (TDISP, PCIe r6.1 sec 11)
> + *
> + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> + */
> +
> +#define dev_fmt(fmt) "PCI/TSM: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/pci-tsm.h>
> +#include <linux/sysfs.h>
> +#include <linux/tsm.h>
> +#include <linux/xarray.h>
> +#include "pci.h"
> +
> +/*
> + * Provide a read/write lock against the init / exit of pdev tsm
> + * capabilities and arrival/departure of a TSM instance
> + */
> +static DECLARE_RWSEM(pci_tsm_rwsem);
> +
> +/*
> + * Count of TSMs registered that support physical link operations vs device
> + * security state management.
> + */
> +static int pci_tsm_link_count;
> +static int pci_tsm_devsec_count;
> +
> +static inline bool is_dsm(struct pci_dev *pdev)
> +{
> +	return pdev->tsm && pdev->tsm->dsm_dev == pdev;
> +}
> +
> +/* 'struct pci_tsm_pf0' wraps 'struct pci_tsm' when ->dsm_dev == ->pdev (self) */
> +static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *tsm)
> +{
> +	/*
> +	 * All "link" TSM contexts reference the device that hosts the DSM
> +	 * interface for a set of devices. Walk to the DSM device and cast its
> +	 * ->tsm context to a 'struct pci_tsm_pf0 *'.
> +	 */
> +	struct pci_dev *pdev = tsm->dsm_dev;
> +
> +	if (!is_pci_tsm_pf0(pdev) || !is_dsm(pdev)) {
> +		pci_WARN_ONCE(tsm->pdev, 1, "invalid context object\n");
> +		return NULL;
> +	}
> +
> +	return container_of(tsm, struct pci_tsm_pf0, base_tsm);
> +}
> +
> +static void tsm_remove(struct pci_tsm *tsm)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!tsm)
> +		return;
> +
> +	pdev = tsm->pdev;
> +	tsm->ops->remove(tsm);
> +	pdev->tsm = NULL;
> +}
> +DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
> +
> +static void pci_tsm_walk_fns(struct pci_dev *pdev,
> +			     int (*cb)(struct pci_dev *pdev, void *data),
> +			     void *data)
> +{
> +	/* Walk subordinate physical functions */
> +	for (int i = 0; i < 8; i++) {
> +		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
> +			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +
> +		if (!pf)
> +			continue;
> +
> +		/* on entry function 0 has already run @cb */
> +		if (i > 0)
> +			cb(pf, data);
> +
> +		/* walk virtual functions of each pf */
> +		for (int j = 0; j < pci_num_vf(pf); j++) {
> +			struct pci_dev *vf __free(pci_dev_put) =
> +				pci_get_domain_bus_and_slot(
> +					pci_domain_nr(pf->bus),
> +					pci_iov_virtfn_bus(pf, j),
> +					pci_iov_virtfn_devfn(pf, j));
> +
> +			if (!vf)
> +				continue;
> +
> +			cb(vf, data);
> +		}
> +	}
> +
> +	/*
> +	 * Walk downstream devices, assumes that an upstream DSM is
> +	 * limited to downstream physical functions
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM && is_dsm(pdev))
> +		pci_walk_bus(pdev->subordinate, cb, data);
> +}
> +
> +static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
> +				     int (*cb)(struct pci_dev *pdev,
> +					       void *data),
> +				     void *data)
> +{
> +	/* Reverse walk downstream devices */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM && is_dsm(pdev))
> +		pci_walk_bus_reverse(pdev->subordinate, cb, data);
> +
> +	/* Reverse walk subordinate physical functions */
> +	for (int i = 7; i >= 0; i--) {
> +		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
> +			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +
> +		if (!pf)
> +			continue;
> +
> +		/* reverse walk virtual functions */
> +		for (int j = pci_num_vf(pf) - 1; j >= 0; j--) {
> +			struct pci_dev *vf __free(pci_dev_put) =
> +				pci_get_domain_bus_and_slot(
> +					pci_domain_nr(pf->bus),
> +					pci_iov_virtfn_bus(pf, j),
> +					pci_iov_virtfn_devfn(pf, j));
> +
> +			if (!vf)
> +				continue;
> +			cb(vf, data);
> +		}
> +
> +		/* on exit, caller will run @cb on function 0 */
> +		if (i > 0)
> +			cb(pf, data);
> +	}
> +}
> +
> +static int probe_fn(struct pci_dev *pdev, void *dsm)
> +{
> +	struct pci_dev *dsm_dev = dsm;
> +	const struct pci_tsm_ops *ops = dsm_dev->tsm->ops;
> +
> +	pdev->tsm = ops->probe(ops->owner, pdev);
> +	pci_dbg(pdev, "setup TSM context: DSM: %s status: %s\n",
> +		pci_name(dsm_dev), pdev->tsm ? "success" : "failed");
> +	return 0;
> +}
> +
> +static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	int rc;
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	const struct pci_tsm_ops *ops = tsm_dev->pci_ops;
> +	struct pci_tsm *pci_tsm __free(tsm_remove) =
> +		ops->probe(ops->owner, pdev);
> +
> +	/* connect()  mutually exclusive with subfunction pci_tsm_init() */
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +
> +	if (!pci_tsm)
> +		return -ENXIO;
> +
> +	pdev->tsm = pci_tsm;
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +
> +	/* mutex_intr assumes connect() is always sysfs/user driven */
> +	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> +		return rc;
> +
> +	rc = ops->connect(pdev);
> +	if (rc)
> +		return rc;
> +
> +	pdev->tsm = no_free_ptr(pci_tsm);
> +
> +	/*
> +	 * Now that the DSM is established, probe() all the potential
> +	 * dependent functions. Failure to probe a function is not fatal
> +	 * to connect(), it just disables subsequent security operations
> +	 * for that function.
> +	 *
> +	 * Note this is done unconditionally, without regard to finding
> +	 * PCI_EXP_DEVCAP_TEE on the dependent function, for robustness. The DSM
> +	 * is the ultimate arbiter of security state relative to a given
> +	 * interface id, and if it says it can manage TDISP state of a function,
> +	 * let it.
> +	 */
> +	pci_tsm_walk_fns(pdev, probe_fn, pdev);
> +	return 0;
> +}
> +
> +static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct tsm_dev *tsm_dev;
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return sysfs_emit(buf, "\n");
> +
> +	tsm_dev = pdev->tsm->ops->owner;
> +	return sysfs_emit(buf, "%s\n", dev_name(&tsm_dev->dev));
> +}
> +
> +/* Is @tsm_dev managing physical link / session properties... */
> +static bool is_link_tsm(struct tsm_dev *tsm_dev)
> +{
> +	return tsm_dev && tsm_dev->pci_ops && tsm_dev->pci_ops->link_ops.probe;
> +}
> +
> +/* ...or is @tsm_dev managing device security state ? */
> +static bool is_devsec_tsm(struct tsm_dev *tsm_dev)
> +{
> +	return tsm_dev && tsm_dev->pci_ops && tsm_dev->pci_ops->devsec_ops.lock;
> +}
> +
> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct tsm_dev *tsm_dev;
> +	int rc, id;
> +
> +	rc = sscanf(buf, "tsm%d\n", &id);
> +	if (rc != 1)
> +		return -EINVAL;
> +
> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
> +		return rc;
> +
> +	if (pdev->tsm)
> +		return -EBUSY;
> +
> +	tsm_dev = find_tsm_dev(id);
> +	if (!is_link_tsm(tsm_dev))
> +		return -ENXIO;
> +
> +	rc = pci_tsm_connect(pdev, tsm_dev);
> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +static DEVICE_ATTR_RW(connect);
> +
> +static int remove_fn(struct pci_dev *pdev, void *data)
> +{
> +	tsm_remove(pdev->tsm);
> +	return 0;
> +}
> +
> +static void __pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +	const struct pci_tsm_ops *ops = pdev->tsm->ops;
> +
> +	/* disconnect() mutually exclusive with subfunction pci_tsm_init() */
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +
> +	/*
> +	 * disconnect() is uninterruptible as it may be called for device
> +	 * teardown
> +	 */
> +	guard(mutex)(&tsm_pf0->lock);
> +	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
> +	ops->disconnect(pdev);
> +}
> +
> +static void pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	__pci_tsm_disconnect(pdev);
> +	tsm_remove(pdev->tsm);
> +}
> +
> +static ssize_t disconnect_store(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct tsm_dev *tsm_dev;
> +	int rc;
> +
> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return -ENXIO;
> +
> +	tsm_dev = pdev->tsm->ops->owner;
> +	if (!sysfs_streq(buf, dev_name(&tsm_dev->dev)))
> +		return -EINVAL;
> +
> +	pci_tsm_disconnect(pdev);
> +	return len;
> +}
> +static DEVICE_ATTR_WO(disconnect);
> +
> +/* The 'authenticated' attribute is exclusive to the presence of a 'link' TSM */
> +static bool pci_tsm_link_group_visible(struct kobject *kobj)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	return pci_tsm_link_count && is_pci_tsm_pf0(pdev);
> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_link);
> +
> +/*
> + * 'link' and 'devsec' TSMs share the same 'tsm/' sysfs group, so the TSM type
> + * specific attributes need individual visibility checks.
> + */
> +static umode_t pci_tsm_attr_visible(struct kobject *kobj,
> +				    struct attribute *attr, int n)
> +{
> +	if (pci_tsm_link_group_visible(kobj)) {
> +		if (attr == &dev_attr_connect.attr ||
> +		    attr == &dev_attr_disconnect.attr)
> +			return attr->mode;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool pci_tsm_group_visible(struct kobject *kobj)
> +{
> +	return pci_tsm_link_group_visible(kobj);
> +}
> +DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm);
> +
> +static struct attribute *pci_tsm_attrs[] = {
> +	&dev_attr_connect.attr,
> +	&dev_attr_disconnect.attr,
> +	NULL
> +};
> +
> +const struct attribute_group pci_tsm_attr_group = {
> +	.name = "tsm",
> +	.attrs = pci_tsm_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
> +};
> +
> +static ssize_t authenticated_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	/*
> +	 * When the SPDM session established via TSM the 'authenticated' state
> +	 * of the device is identical to the connect state.
> +	 */
> +	return connect_show(dev, attr, buf);
> +}
> +static DEVICE_ATTR_RO(authenticated);
> +
> +static struct attribute *pci_tsm_auth_attrs[] = {
> +	&dev_attr_authenticated.attr,
> +	NULL
> +};
> +
> +const struct attribute_group pci_tsm_auth_attr_group = {
> +	.attrs = pci_tsm_auth_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_link),
> +};
> +
> +/*
> + * Retrieve physical function0 device whether it has TEE capability or not
> + */
> +static struct pci_dev *pf0_dev_get(struct pci_dev *pdev)
> +{
> +	struct pci_dev *pf_dev = pci_physfn(pdev);
> +
> +	if (PCI_FUNC(pf_dev->devfn) == 0)
> +		return pci_dev_get(pf_dev);
> +
> +	return pci_get_slot(pf_dev->bus,
> +			    pf_dev->devfn - PCI_FUNC(pf_dev->devfn));
> +}
> +
> +/*
> + * Find the PCI Device instance that serves as the Device Security Manager (DSM)
> + * for @pdev. Note that no additional reference is held for the resulting device
> + * because @pdev always has a longer registered lifetime than its DSM by virtue
> + * of being a child of, or identical to, its DSM.
> + */
> +static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
> +{
> +	struct device *grandparent;
> +	struct pci_dev *uport;
> +
> +	if (is_pci_tsm_pf0(pdev))
> +		return pdev;
> +
> +	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
> +	if (!pf0)
> +		return NULL;
> +
> +	if (is_dsm(pf0))
> +		return pf0;
> +
> +	/*
> +	 * For cases where a switch may be hosting TDISP services on behalf of
> +	 * downstream devices, check the first upstream port relative to this
> +	 * endpoint.
> +	 */
> +	if (!pdev->dev.parent)
> +		return NULL;
> +	grandparent = pdev->dev.parent->parent;
> +	if (!grandparent)
> +		return NULL;
> +	if (!dev_is_pci(grandparent))
> +		return NULL;
> +	uport = to_pci_dev(grandparent);
> +	if (!pci_is_pcie(uport) ||
> +	    pci_pcie_type(uport) != PCI_EXP_TYPE_UPSTREAM)
> +		return NULL;
> +
> +	if (is_dsm(uport))
> +		return uport;
> +	return NULL;
> +}
> +
> +/**
> + * pci_tsm_link_constructor() - base 'struct pci_tsm' initialization for link TSMs
> + * @pdev: The PCI device
> + * @tsm: context to initialize
> + * @ops: PCI link operations provided by the TSM
> + */
> +int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
> +			     const struct pci_tsm_ops *ops)
> +{
> +	if (!is_link_tsm(ops->owner))
> +		return -EINVAL;
> +
> +	tsm->dsm_dev = find_dsm_dev(pdev);
> +	if (!tsm->dsm_dev) {
> +		pci_warn(pdev, "failed to find Device Security Manager\n");
> +		return -ENXIO;
> +	}
> +	tsm->pdev = pdev;
> +	tsm->ops = ops;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_link_constructor);
> +
> +/**
> + * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' (DSM) initialization
> + * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
> + * @tsm: context to initialize
> + * @ops: PCI link operations provided by the TSM
> + */
> +int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
> +			    const struct pci_tsm_ops *ops)
> +{
> +	mutex_init(&tsm->lock);
> +	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +					   PCI_DOE_PROTO_CMA);
> +	if (!tsm->doe_mb) {
> +		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
> +		return -ENODEV;
> +	}
> +
> +	return pci_tsm_link_constructor(pdev, &tsm->base_tsm, ops);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_pf0_constructor);
> +
> +void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *pf0_tsm)
> +{
> +	mutex_destroy(&pf0_tsm->lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_pf0_destructor);
> +
> +static void pf0_sysfs_enable(struct pci_dev *pdev)
> +{
> +	bool tee = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> +
> +	pci_dbg(pdev, "Device Security Manager detected (%s%s%s)\n",
> +		pdev->ide_cap ? "IDE" : "", pdev->ide_cap && tee ? " " : "",
> +		tee ? "TEE" : "");
> +
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +}
> +
> +int pci_tsm_register(struct tsm_dev *tsm_dev)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	if (!tsm_dev)
> +		return -EINVAL;
> +
> +	/* The TSM device must only implement one of link_ops or devsec_ops */
> +	if (!is_link_tsm(tsm_dev) && !is_devsec_tsm(tsm_dev))
> +		return -EINVAL;
> +
> +	if (is_link_tsm(tsm_dev) && is_devsec_tsm(tsm_dev))
> +		return -EINVAL;
> +
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +
> +	/* On first enable, update sysfs groups */
> +	if (is_link_tsm(tsm_dev) && pci_tsm_link_count++ == 0) {
> +		for_each_pci_dev(pdev)
> +			if (is_pci_tsm_pf0(pdev))
> +				pf0_sysfs_enable(pdev);
> +	} else if (is_devsec_tsm(tsm_dev)) {
> +		pci_tsm_devsec_count++;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * __pci_tsm_destroy() - destroy the TSM context for @pdev
> + * @pdev: device to cleanup
> + * @tsm_dev: the TSM device being removed, or NULL if @pdev is being removed.
> + *
> + * At device removal or TSM unregistration all established context
> + * with the TSM is torn down. Additionally, if there are no more TSMs
> + * registered, the PCI tsm/ sysfs attributes are hidden.
> + */
> +static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	struct pci_tsm *tsm = pdev->tsm;
> +
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +
> +	/*
> +	 * First, handle the TSM removal case to shutdown @pdev sysfs, this is
> +	 * skipped if the device itself is being removed since sysfs goes away
> +	 * naturally at that point
> +	 */
> +	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev) && !pci_tsm_link_count) {
> +		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +	}
> +
> +	/* Nothing else to do if this device never attached to the departing TSM */
> +	if (!tsm)
> +		return;
> +
> +	/* Now lookup the tsm_dev to destroy TSM context */
> +	if (!tsm_dev)
> +		tsm_dev = tsm->ops->owner;
> +	else if (tsm_dev != tsm->ops->owner)
> +		return;
> +
> +	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev))
> +		pci_tsm_disconnect(pdev);
> +	else
> +		tsm_remove(pdev->tsm);
> +}
> +
> +void pci_tsm_destroy(struct pci_dev *pdev)
> +{
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	__pci_tsm_destroy(pdev, NULL);
> +}
> +
> +void pci_tsm_init(struct pci_dev *pdev)
> +{
> +	guard(rwsem_read)(&pci_tsm_rwsem);
> +
> +	/*
> +	 * Subfunctions are either probed synchronous with connect() or later
> +	 * when either the SR-IOV configuration is changed, or, unlikely,
> +	 * connect() raced initial bus scanning.
> +	 */
> +	if (pdev->tsm)
> +		return;
> +
> +	if (pci_tsm_link_count) {
> +		struct pci_dev *dsm = find_dsm_dev(pdev);
> +
> +		if (!dsm)
> +			return;
> +
> +		/*
> +		 * The only path to init a Device Security Manager capable
> +		 * device is via connect().
> +		 */
> +		if (!dsm->tsm)
> +			return;
> +
> +		probe_fn(pdev, dsm);
> +	}
> +}
> +
> +void pci_tsm_unregister(struct tsm_dev *tsm_dev)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	if (is_link_tsm(tsm_dev))
> +		pci_tsm_link_count--;
> +	if (is_devsec_tsm(tsm_dev))
> +		pci_tsm_devsec_count--;
> +	for_each_pci_dev_reverse(pdev)
> +		__pci_tsm_destroy(pdev, tsm_dev);
> +}
> +
> +int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
> +			 size_t req_sz, void *resp, size_t resp_sz)
> +{
> +	struct pci_tsm_pf0 *tsm;
> +
> +	if (!pdev->tsm || !is_pci_tsm_pf0(pdev))
> +		return -ENXIO;
> +
> +	tsm = to_pci_tsm_pf0(pdev->tsm);
> +	if (!tsm->doe_mb)
> +		return -ENXIO;
> +
> +	return pci_doe(tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req, req_sz,
> +		       resp, resp_sz);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index a64b776642cf..f0bb580563c9 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -9,15 +9,18 @@
>   #include <linux/device.h>
>   #include <linux/module.h>
>   #include <linux/cleanup.h>
> +#include <linux/pci-tsm.h>
>   
>   static struct class *tsm_class;
>   static DECLARE_RWSEM(tsm_rwsem);
>   static DEFINE_IDR(tsm_idr);
>   
> -struct tsm_dev {
> -	struct device dev;
> -	int id;
> -};
> +/* Caller responsible for ensuring it does not race tsm_dev unregistration */
> +struct tsm_dev *find_tsm_dev(int id)
> +{
> +	guard(rcu)();
> +	return idr_find(&tsm_idr, id);
> +}
>   
>   static struct tsm_dev *alloc_tsm_dev(struct device *parent)
>   {
> @@ -42,6 +45,29 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
>   	return no_free_ptr(tsm_dev);
>   }
>   
> +static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
> +						 struct pci_tsm_ops *pci_ops)
> +{
> +	int rc;
> +
> +	if (!pci_ops)
> +		return tsm_dev;
> +
> +	pci_ops->owner = tsm_dev;
> +	tsm_dev->pci_ops = pci_ops;
> +	rc = pci_tsm_register(tsm_dev);
> +	if (rc) {
> +		dev_err(tsm_dev->dev.parent,
> +			"PCI/TSM registration failure: %d\n", rc);
> +		device_unregister(&tsm_dev->dev);
> +		return ERR_PTR(rc);
> +	}
> +
> +	/* Notify TSM userspace that PCI/TSM operations are now possible */
> +	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
> +	return tsm_dev;
> +}
> +
>   static void put_tsm_dev(struct tsm_dev *tsm_dev)
>   {
>   	if (!IS_ERR_OR_NULL(tsm_dev))
> @@ -51,7 +77,7 @@ static void put_tsm_dev(struct tsm_dev *tsm_dev)
>   DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
>   	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
>   
> -struct tsm_dev *tsm_register(struct device *parent)
> +struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
>   {
>   	struct tsm_dev *tsm_dev __free(put_tsm_dev) = alloc_tsm_dev(parent);
>   	struct device *dev;
> @@ -69,12 +95,14 @@ struct tsm_dev *tsm_register(struct device *parent)
>   	if (rc)
>   		return ERR_PTR(rc);
>   
> -	return no_free_ptr(tsm_dev);
> +	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
>   }
>   EXPORT_SYMBOL_GPL(tsm_register);
>   
>   void tsm_unregister(struct tsm_dev *tsm_dev)
>   {
> +	if (tsm_dev->pci_ops)
> +		pci_tsm_unregister(tsm_dev);
>   	device_unregister(&tsm_dev->dev);
>   }
>   EXPORT_SYMBOL_GPL(tsm_unregister);
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index 1f14aed4354b..7d839f4a6340 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -15,6 +15,10 @@
>   
>   struct pci_doe_mb;
>   
> +#define PCI_DOE_FEATURE_DISCOVERY 0
> +#define PCI_DOE_PROTO_CMA 1
> +#define PCI_DOE_PROTO_SSESSION 2
> +
>   struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
>   					u8 type);
>   
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> new file mode 100644
> index 000000000000..572aea6da27d
> --- /dev/null
> +++ b/include/linux/pci-tsm.h
> @@ -0,0 +1,159 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PCI_TSM_H
> +#define __PCI_TSM_H
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +
> +struct pci_tsm;
> +struct tsm_dev;
> +
> +/*
> + * struct pci_tsm_ops - manage confidential links and security state
> + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> + *	      Provide a secure session transport for TDISP state management
> + *	      (typically bare metal physical function operations).
> + * @sec_ops: Lock, unlock, and interrogate the security state of the
> + *	     function via the platform TSM (typically virtual function
> + *	     operations).
> + * @owner: Back reference to the TSM device that owns this instance.
> + *
> + * This operations are mutually exclusive either a tsm_dev instance
> + * manages physical link properties or it manages function security
> + * states like TDISP lock/unlock.
> + */
> +struct pci_tsm_ops {
> +	/*
> +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> +	 * @probe: establish context with the TSM (allocate / wrap 'struct
> +	 *	   pci_tsm') for follow-on link operations
> +	 * @remove: destroy link operations context
> +	 * @connect: establish / validate a secure connection (e.g. IDE)
> +	 *	     with the device
> +	 * @disconnect: teardown the secure link
> +	 *
> +	 * Context: @probe, @remove, @connect, and @disconnect run under
> +	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
> +	 * mutual exclusion of @connect and @disconnect. @connect and
> +	 * @disconnect additionally run under the DSM lock (struct
> +	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
> +	 */
> +	struct_group_tagged(pci_tsm_link_ops, link_ops,
> +		struct pci_tsm *(*probe)(struct tsm_dev *tsm_dev,
> +					 struct pci_dev *pdev);
> +		void (*remove)(struct pci_tsm *tsm);
> +		int (*connect)(struct pci_dev *pdev);
> +		void (*disconnect)(struct pci_dev *pdev);
> +	);
> +
> +	/*
> +	 * struct pci_tsm_devsec_ops - Manage the security state of the function
> +	 * @lock: establish context with the TSM (allocate / wrap 'struct
> +	 *	  pci_tsm') for follow-on security state transitions from the
> +	 *	  LOCKED state
> +	 * @unlock: destroy TSM context and return device to UNLOCKED state
> +	 *
> +	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
> +	 * sync with TSM unregistration and each other
> +	 */
> +	struct_group_tagged(pci_tsm_devsec_ops, devsec_ops,
> +		struct pci_tsm *(*lock)(struct tsm_dev *tsm_dev,
> +					struct pci_dev *pdev);
> +		void (*unlock)(struct pci_tsm *tsm);
> +	);
> +	struct tsm_dev *owner;


It is still a rather global thing. May I suggest this?

===
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index e8d9d19732f6..77b6ed52a872 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -77,7 +77,6 @@ struct pci_tsm_ops {
                 void (*unlock)(struct pci_tsm *tsm);
                 int (*accept)(struct pci_dev *pdev);
         );
-       struct tsm_dev *owner;
  };

  /**
@@ -119,6 +118,7 @@ struct pci_tsm {
         struct pci_dev *dsm_dev;
         struct pci_tdi *tdi;
         const struct pci_tsm_ops *ops;
+       struct tsm_dev *owner;
  };
@@ -221,10 +221,13 @@ struct tsm_dev;
  int pci_tsm_register(struct tsm_dev *tsm_dev);
  void pci_tsm_unregister(struct tsm_dev *tsm_dev);
  int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
+                            struct tsm_dev *tsmdev,
                              const struct pci_tsm_ops *ops);
  int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
+                           struct tsm_dev *tsmdev,
                             const struct pci_tsm_ops *ops);
  int pci_tsm_devsec_constructor(struct pci_dev *pdev, struct pci_tsm_devsec *tsm,
+                              struct tsm_dev *tsmdev,
                                const struct pci_tsm_ops *ops);
===

+ what is needed to compile all this. Otherwise LGTM. Thanks,


-- 
Alexey


