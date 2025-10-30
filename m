Return-Path: <linux-pci+bounces-39743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F25C1DF6E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 02:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C74A406836
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 01:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3157E266A7;
	Thu, 30 Oct 2025 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bJK6LtIj"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013035.outbound.protection.outlook.com [40.93.196.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34467184E
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786025; cv=fail; b=FRq8RoKX4nwAcE3U9eq+RbUDi/BCdPbKyPxpkKkZZWBiX5R1tE5fPeKyoGgcu6oedEwt9ayjVPckiJ3zMmYAdu/2/w82ymKMEH0PFAj58XGOzOS/MVe0WTyxwPD2nWuPpUDJv2HX0DzCdd3/jOHK7dbjLwuJKiJ/r4vSR7riV54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786025; c=relaxed/simple;
	bh=7E2Zxi5FPkXY6hYyfF4/84yp7YxErvPtx6ZsrhuQRyc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=De46jH9HGKcioALZ2XXa/YFOn3dnvpMCal/7qiW8JUlNRIUq2p26ERKFlC8wCYmFAXFnSaTY21lZ0emh+597zYDJRuzJH6PKuTPVmgkZNNgu32F0rOO6SNIJRrunOUh/yGWz/3W7K8FtvDDxV1xaFd08/oUEf1J5lzlC21VkFEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bJK6LtIj; arc=fail smtp.client-ip=40.93.196.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6F/7+dVQ58JyoFqNt9QSKq24ld1+LeLM99fIl+X1bGmhOJxtoTOVNIm7qwPCwIyM2M4lrlV0D7TBozstdXGdSUTUsOXBiyNMedbPXWOe555rcuh8A2Bx4+9hbik0WYaN88e15DBA9hAPdWjmM6aPaenp2QNpPujZWjRu5v/BUqIwWTxW5bjQv87Kw/oCcBJMerjTYbAFlYwV2zvng5SvujpYfvuHzw5ziBl48Q3kVLWFyq576rzGFLDJ72mU9rxrzRjy6ls34wbo1fTV71QJ73XxbePsDzggH6jE/XwglZ6T02GRVLnod2U4MSZfOA9xUpqDw9/BCz8ydw25Ee8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J66E02pivO1bfjgpMdJPYUP/WQ+Ly8NUHqYOPKDR2CA=;
 b=cdaoByxLZPTqbwbLu4KfYkzui4RsF/BOTm6qvNCds2syQlcBTFtGwoKPtwbLORWEkhzRs4l/j+0cVdWrOuENuFClfbxv4Z7pvav/StC9C/qBmHbhy7OOMcQ2LKLjBjX4j+lSMMn/SdQ8ra/mvBZAtfXJYxiYju/MSa1+4hb4KoTOJF5Trdsjj3MuLzpVadZP7wXab9sSWVwknffXFVckBFS/r2cC5WnBED5ZmZPz7pQaeNV6AvzzZsf+gHReiJAu+D9XOIowfmgqfUcLKl7gzO/t0MhOS/QAKHccHw150Ny1ju8/hqO8dzql3CVp2XkmG2Zqq74GsbpqE9P9i0CxCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J66E02pivO1bfjgpMdJPYUP/WQ+Ly8NUHqYOPKDR2CA=;
 b=bJK6LtIj82qxh5pzet/UtuGgxkQV6iIaEQJ9Jf7yJdNsU/TEauTpDe8ZWuU0EskyUPh5DigG0TXNY9rYHU+Xae3v0Nhydzoi+T1wrk9nVAs8swJ3d2rMXX+k5WISvrRxePOcgrw1IQ/E8w+/+0locA247r589QcJKevJxtAMvtc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 01:00:17 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.9253.013; Thu, 30 Oct 2025
 01:00:17 +0000
Message-ID: <b9782ea0-0ef9-4789-912b-a0abfd490a83@amd.com>
Date: Thu, 30 Oct 2025 12:00:02 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 1/9] coco/tsm: Introduce a core device for TEE Security
 Managers
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org, bhelgaas@google.com,
 gregkh@linuxfoundation.org, Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-2-dan.j.williams@intel.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20251024020418.1366664-2-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY0PR01CA0004.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::11) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: a1298b85-b2df-4e93-5018-08de174fb0fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGovS3BYQTZpZHJsQW5mZFM0YnladTdrYmFhbGF3VStWY3E4YTI0T2xKS1p6?=
 =?utf-8?B?WDIvY0F6QjlLbEdzMkdmVkZIb1pOZ1pnN21zZ3VrempYNTV1R0swRk9IUWdj?=
 =?utf-8?B?c2gyUi9Qb1lBUXExUys4bUpjRzJGWlFxZnV1aHljbXN4SWQwNXhHVEl6TUcw?=
 =?utf-8?B?WFNqQXAyamxCeFM0OFhrdnRCcUl6WHVaQUJnVlc0NzE3UDZuTHNDRy9aN3FD?=
 =?utf-8?B?eU1pL3Y3dHc4Tm5IQ3FvWXl0aWVGY1NqdTFieVdkWnFRR2NGY1Y2c3JnSEhi?=
 =?utf-8?B?b0IwYUZSc2R4M0h5dHltc1o2VDZwVWF3cjFHMVFTR2F2SktINkE1VTJhL2hi?=
 =?utf-8?B?U0JOSlJ5WXRWQzhlcUp3b0FEV2p2T3ZPRGFIVU8vZ0Yyb0FUY1Yza3dOUllp?=
 =?utf-8?B?TDlOTDhZMlVJaUh1akx3bDY1NjVqNW5UZDVnSUxieldTbmJ2NGhrT0pOelA0?=
 =?utf-8?B?QXRSYmFZUGRPNk15aXBMcjBVT2pDTHo1MkNabEdIMmMxL0RpMm56dWRDQjRL?=
 =?utf-8?B?UDJmWVJCV0hUNDVXbnIrVjdlRDRXQUpoTUNaaGc2ajVKUEVreXFNS3JqREJQ?=
 =?utf-8?B?R21KV2ovWWF2cUZiWk8zMFQxVVZsVWZqWWJYdFdtZ1hVQ3pTYU54Ny9rWHZ4?=
 =?utf-8?B?S1VVRnpMWXdudWpxTXZoL1VnNnM0VEFJaEF2UUNMOTB0OUhLVWt6R045MmNS?=
 =?utf-8?B?Zk5aUUFxR1diTC9IekJjMTk3YXg0SDBIVXd4dkVybitQckFEUVlPMEp0VDZ4?=
 =?utf-8?B?bHRMNGFJb29TM3c2VjRQOHdpVGVOMHVOV1ZwWlpuNFBLb2FMRDBDdVQ1ZitB?=
 =?utf-8?B?eUY1WlhPbTlFaUJBMU9VZjczWXlMYWNVNGdzQUNWbFoyZHBpYzNkU2QvYjkr?=
 =?utf-8?B?Ti9kb01jWGRsTmZoa1ppM1k0R1FoVlB3bmlhNzA2K010MnlDRGRyMHRjSDZm?=
 =?utf-8?B?cEFmS2VIbnNIRjZYZ1BUT1RUMGtnRDM0YXh4REZ4N0ljSm9vem0yaGxOczVa?=
 =?utf-8?B?Q29ad01xUUpSdll4VkJuZEpHallQWG1BdzVBbEJocUV0eVFzL3BHeFRmcG1P?=
 =?utf-8?B?bkFYeC9wQndhU1RSV004NWNnc1ZLRENLOW1aWTBTbDYzdTE5UDFQeEtZOXl3?=
 =?utf-8?B?M3Q4ak9YTHJVQWo0TXB0eHRBT2V0SGhORlJidENueWJtSzdSSUE0MDkyUGNq?=
 =?utf-8?B?eXZ0V2dGQ2k1emdpdldBU2drdU5vWFgwOXBsSS94VjJsWW0rY1JrSkQveVR3?=
 =?utf-8?B?SDEvT3lpZVhsdVQvd3M1V2ZVcmpNc3ZXL2ZrT1VZOFI0VjRzSlZmbFFsazFD?=
 =?utf-8?B?MnJ1MGwxZit2RFhyK25QUEZuNkpCcDhmN3dka3NrMmtMenY5N3lZY1pEN2tS?=
 =?utf-8?B?YzlPSGEvSWx1RjdwS0IweW9BcVpxNnIzQlZMS0NRdmtiRCtxVElBbE5PS3VM?=
 =?utf-8?B?Q09Ya2UweVI4aEN3UVZHNEpSMTZnOUlneXU1cStTRk9IcFpxT0VXQkpHTFZs?=
 =?utf-8?B?VDFsRm8xc2RBYjdab3BCMnJZeGtyeEhXc1h6bmZHSTZWRENVL0h6czhTS2Zq?=
 =?utf-8?B?VGdqa0ZPVWh2cnQwWTlNRitNcmtlMHU0T21XY05Fb3dBY1Jtc1BZZG1DSXBR?=
 =?utf-8?B?VXI4RWF5dGlVaHVqZTRIZWR1T0l2cUZQYTkvZlRKeUJWY3RxSXBJbmUzZzRH?=
 =?utf-8?B?b1oxV01neDFieHExaUh4MzVidWVQUlBSNmlCUlpLWFNpTFRrUmNYK0lpMUhz?=
 =?utf-8?B?SlA5dWxVcHNBUmx4OVhhb0tPYTNodzdpb1Vta1RMRGNucTBoZXE3L0xmYStU?=
 =?utf-8?B?SWlid01GVCt0a0t2Q1NYQXJ5dUdmVERsamZjc2FidXNBckR2alZrN3M3aGx1?=
 =?utf-8?B?TWVwdVE0ZFdRSUJWOGJsa3FDTUNNOTVWdXhuNWRKNzNzZUtMQVVCeE0xNCsr?=
 =?utf-8?Q?qVQcdTYx9n/gIYiLAhv8TO0d1J4n3HWx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXR4S1U3K1BUQ2wvbHZOZTdGRXpTeTZOdGw0Wnh3dEZQS0c4SmF0WEY3WHlI?=
 =?utf-8?B?TkdPNlZWc3FZd091UEpZWnFLRGY0Y2NnWjBoNXFaeDJvSjFITGZoU3BtdVd3?=
 =?utf-8?B?YTVFTjkzNUNFUkFJQnBYSGFONHBsRncxTllnWkFoeHlocnhZMzExY0ptazdB?=
 =?utf-8?B?Yk9YYmhoSzZSaTdzM0oyQTdubE9xODJsL0V5a0RWQXdpMmtsVEFrVC8xL2tl?=
 =?utf-8?B?dlNUdnBRRFprSGZPVi9wUGpzRk1sc0NKNGk2alN5YkY1QjROMnV5VXJDOFF4?=
 =?utf-8?B?bTVUNmdpTUE2MjNJZlN3dFQ2S2grdmxGblc2bGQra1NtNGVwTXdIT2pDVlNW?=
 =?utf-8?B?a0IrRzQrdk9yRHBtYkdoNzRHS29scDJmcG83QUxhQW90RitIWDlnT21wS1pP?=
 =?utf-8?B?b3lZWWNFSmdnTU42NW9EMUlsWWFxREZvVzhSZzJyZnFJbi85VEJUYWtrdmJs?=
 =?utf-8?B?VXg0ZmpwT2FEM3JVLzhUNEZkZVdCUVVqTzJOUkxGS3MvRXRTWm1QRmJKUGZK?=
 =?utf-8?B?ZDZRa0xZb2ZiVXJ0aEt1ck5SNGdReDVpMjUwUnRoV084Q3JZVlVnMDRJUWp1?=
 =?utf-8?B?cHlKbUZVQ3ZaanFMMVVFR2RYaWZ5dGpzVkZaUENTb3dPRjF3ZXExVXdmVFdT?=
 =?utf-8?B?M1JaeVh6aExkUVUzR21NYko0MTFWUGRVcGUzc3dOSjlLTGViQkxCeFhCTWl1?=
 =?utf-8?B?V3VoRWlCaGxkTUtxYUZ0TWdUVzQraXZnaVEwWlR0U2M3eVdFV0Q2azZvbEFm?=
 =?utf-8?B?V0VpNGFSTTBuWk9WeDhzVXh2MS9JWmpFUVY2UkRwa3hGdURpVlFab1NGVFlN?=
 =?utf-8?B?WUpOK3NDTUxHY2UvcWVNdjVYT1J4U0ttOXBHcmZ0Q1dFbzRYdmtRblpLaXRH?=
 =?utf-8?B?cWZ0TVVvQmUrYmd3ajhMWWhndXdXNFZJVWxrVER6YmpaTlk3UDdhb0V5emNL?=
 =?utf-8?B?S0VyVWozVUZwMVBWK2trVWQ4dXZ0WkFvNWtLMTFZdTZOUmlmVWR3WlloWkVw?=
 =?utf-8?B?dUJ4b2RQbGJHZVQ1cittMVhyR3RUWFQ2RU8zejgxYWs3czFHeU5uRldKQTl2?=
 =?utf-8?B?eFg1eUphZ29ZL2w5MXNZWG44VERCWE9maXBUQ2ZNYlkyTk92Yk1zS2NXMTFi?=
 =?utf-8?B?bmdlTkNLakhHNlJheVlDejAvZUJJVSs5VVhwNTNtam9QZytRU0pkd0RyeUxO?=
 =?utf-8?B?T1NBTjhQMmNqOFlNNXM4L0lMdzVTSU5RYk1VV2JVQ1VjZW0vN2NmZXlrb3hS?=
 =?utf-8?B?Y2s1Sm1mTUpQZi9uUktneit4bWlWNWlWYkh0aGhNZEErQlZJdDJEeUczUTJo?=
 =?utf-8?B?dnhBNHBNc1U2Rm45bU9Db3ZiSVFaWGNDUWZiNkdFaFIrVzRycEFMa2Nkb2FY?=
 =?utf-8?B?QlV5QU9hQURaRHQ5VFZJRTVLakdzUDBxU0pYNG5TVW1CODEzVTRRc1ZtQkhE?=
 =?utf-8?B?VDdZbUpUZ0J6Q2c3N2I5cUVMdDJKNnlJOU1GOStteWR4QVVIRFpKR2ZoSmFa?=
 =?utf-8?B?dDdDWDJEUDdLMXZIMDlja2doUjNoVnhqT0xXN3JINmxZVStBRHh3N2hjTzRh?=
 =?utf-8?B?cFQ5SVlJcHhhQzRFeWRtOW5va1RQRU1qRldHaUtRUWJpQlhuV1NkWnB1QzlL?=
 =?utf-8?B?aTlxckhucUM4L1ZVemhKL0tPVjYzaUxReTRyRitDSk1EdmREbXlVc3hrMTZK?=
 =?utf-8?B?eUR3UURlcS9UQk0xMi9aUUJBRk84M3dsaS9vSkFjVndGSGp2YU9CVWdQclh3?=
 =?utf-8?B?NlRyWUNDSDZRQUFaNkZBMG40d0ZGeDJDZGc3eS8ybWdiNkRSQnl0dnA3UEdq?=
 =?utf-8?B?ajltZXlhRmg5TUIrNmp4SWl2UkxHMVFIUitXTzRNZzg1Qmx3UFRNM3FiWWY1?=
 =?utf-8?B?OEk3cG9XS0JYUTF1NXdQaG1Ec1F1dUU1eDVyb0pidlVMS2RMdzhLRjNlQjVR?=
 =?utf-8?B?NzkzOUlTSWRhYi9FeDRNZWZ4ZDJvSUVkcjF4WDhlTnNRNnhRSFZZajVLRkNK?=
 =?utf-8?B?dWhFb3Z1Rkt5VE53RG9sTllFSHFNL2R2TkJlRmNWbnpQNlBFSlN2Y25zS0kr?=
 =?utf-8?B?Z0k1aHlaVm5HQnU3bm1JM0NQeUR5bXR1OVJ1bDA4RGUyOEVHaDR5OHNzZVJB?=
 =?utf-8?Q?QRJrDJJElpNCAdYaSokbJhA5V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1298b85-b2df-4e93-5018-08de174fb0fb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 01:00:17.5361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXeG5h3S18NJS4skwJCCQeW3q/nGthRr+7NImBolFztT8HrOozbM0RVxhDaBq0Oc3cLQ3Ga48UknpoCjacouLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729



On 24/10/25 13:04, Dan Williams wrote:
> A "TSM" is a platform component that provides an API for securely
> provisioning resources for a confidential guest (TVM) to consume. The
> name originates from the PCI specification for platform agent that
> carries out operations for PCIe TDISP (TEE Device Interface Security
> Protocol).
> 
> Instances of this core device are parented by a device representing the
> platform security function like CONFIG_CRYPTO_DEV_CCP or
> CONFIG_INTEL_TDX_HOST.
> 
> This device interface is a frontend to the aspects of a TSM and TEE I/O
> that are cross-architecture common. This includes mechanisms like
> enumerating available platform TEE I/O capabilities and provisioning
> connections between the platform TSM and device DSMs (Device Security
> Manager (TDISP)).
> 
> For now this is just the scaffolding for registering a TSM device sysfs
> interface.
> 
> Cc: Alexey Kardashevskiy <aik@amd.com>


Reviewed-by: Alexey Kardashevskiy <aik@amd.com>

> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/virt/coco/Kconfig                 |   3 +
>   drivers/virt/coco/Makefile                |   1 +
>   Documentation/ABI/testing/sysfs-class-tsm |   9 ++
>   include/linux/tsm.h                       |   4 +
>   drivers/virt/coco/tsm-core.c              | 109 ++++++++++++++++++++++
>   MAINTAINERS                               |   2 +-
>   6 files changed, 127 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
>   create mode 100644 drivers/virt/coco/tsm-core.c
> 
> diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
> index 819a97e8ba99..bb0c6d6ddcc8 100644
> --- a/drivers/virt/coco/Kconfig
> +++ b/drivers/virt/coco/Kconfig
> @@ -14,3 +14,6 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
>   source "drivers/virt/coco/arm-cca-guest/Kconfig"
>   
>   source "drivers/virt/coco/guest/Kconfig"
> +
> +config TSM
> +	bool
> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> index f918bbb61737..cb52021912b3 100644
> --- a/drivers/virt/coco/Makefile
> +++ b/drivers/virt/coco/Makefile
> @@ -7,4 +7,5 @@ obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
>   obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
>   obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
>   obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
> +obj-$(CONFIG_TSM) 		+= tsm-core.o
>   obj-$(CONFIG_TSM_GUEST)		+= guest/
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> new file mode 100644
> index 000000000000..2949468deaf7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -0,0 +1,9 @@
> +What:		/sys/class/tsm/tsmN
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		"tsmN" is a device that represents the generic attributes of a
> +		platform TEE Security Manager.  It is typically a child of a
> +		platform enumerated TSM device. /sys/class/tsm/tsmN/uevent
> +		signals when the PCI layer is able to support establishment of
> +		link encryption and other device-security features coordinated
> +		through a platform tsm.
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 431054810dca..aa906eb67360 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -5,6 +5,7 @@
>   #include <linux/sizes.h>
>   #include <linux/types.h>
>   #include <linux/uuid.h>
> +#include <linux/device.h>
>   
>   #define TSM_REPORT_INBLOB_MAX 64
>   #define TSM_REPORT_OUTBLOB_MAX SZ_32K
> @@ -109,4 +110,7 @@ struct tsm_report_ops {
>   
>   int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
>   int tsm_report_unregister(const struct tsm_report_ops *ops);
> +struct tsm_dev;
> +struct tsm_dev *tsm_register(struct device *parent);
> +void tsm_unregister(struct tsm_dev *tsm_dev);
>   #endif /* __TSM_H */
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> new file mode 100644
> index 000000000000..a64b776642cf
> --- /dev/null
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/tsm.h>
> +#include <linux/idr.h>
> +#include <linux/rwsem.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/cleanup.h>
> +
> +static struct class *tsm_class;
> +static DECLARE_RWSEM(tsm_rwsem);
> +static DEFINE_IDR(tsm_idr);
> +
> +struct tsm_dev {
> +	struct device dev;
> +	int id;
> +};
> +
> +static struct tsm_dev *alloc_tsm_dev(struct device *parent)
> +{
> +	struct tsm_dev *tsm_dev __free(kfree) =
> +		kzalloc(sizeof(*tsm_dev), GFP_KERNEL);
> +	struct device *dev;
> +	int id;
> +
> +	if (!tsm_dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +	id = idr_alloc(&tsm_idr, tsm_dev, 0, INT_MAX, GFP_KERNEL);
> +	if (id < 0)
> +		return ERR_PTR(id);
> +
> +	tsm_dev->id = id;
> +	dev = &tsm_dev->dev;
> +	dev->parent = parent;
> +	dev->class = tsm_class;
> +	device_initialize(dev);
> +	return no_free_ptr(tsm_dev);
> +}
> +
> +static void put_tsm_dev(struct tsm_dev *tsm_dev)
> +{
> +	if (!IS_ERR_OR_NULL(tsm_dev))
> +		put_device(&tsm_dev->dev);
> +}
> +
> +DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
> +	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
> +
> +struct tsm_dev *tsm_register(struct device *parent)
> +{
> +	struct tsm_dev *tsm_dev __free(put_tsm_dev) = alloc_tsm_dev(parent);
> +	struct device *dev;
> +	int rc;
> +
> +	if (IS_ERR(tsm_dev))
> +		return tsm_dev;
> +
> +	dev = &tsm_dev->dev;
> +	rc = dev_set_name(dev, "tsm%d", tsm_dev->id);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return no_free_ptr(tsm_dev);
> +}
> +EXPORT_SYMBOL_GPL(tsm_register);
> +
> +void tsm_unregister(struct tsm_dev *tsm_dev)
> +{
> +	device_unregister(&tsm_dev->dev);
> +}
> +EXPORT_SYMBOL_GPL(tsm_unregister);
> +
> +static void tsm_release(struct device *dev)
> +{
> +	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +	idr_remove(&tsm_idr, tsm_dev->id);
> +	kfree(tsm_dev);
> +}
> +
> +static int __init tsm_init(void)
> +{
> +	tsm_class = class_create("tsm");
> +	if (IS_ERR(tsm_class))
> +		return PTR_ERR(tsm_class);
> +
> +	tsm_class->dev_release = tsm_release;
> +	return 0;
> +}
> +module_init(tsm_init)
> +
> +static void __exit tsm_exit(void)
> +{
> +	class_destroy(tsm_class);
> +}
> +module_exit(tsm_exit)
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("TEE Security Manager Class Device");
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 545a4776795e..06285f3a24df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26097,7 +26097,7 @@ M:	David Lechner <dlechner@baylibre.com>
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/trigger-source/*
>   
> -TRUSTED SECURITY MODULE (TSM) INFRASTRUCTURE
> +TRUSTED EXECUTION ENVIRONMENT SECURITY MANAGER (TSM)
>   M:	Dan Williams <dan.j.williams@intel.com>
>   L:	linux-coco@lists.linux.dev
>   S:	Maintained

-- 
Alexey


