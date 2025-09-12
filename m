Return-Path: <linux-pci+bounces-36061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41291B55885
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 23:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E9D5C1406
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 21:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8142765D2;
	Fri, 12 Sep 2025 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aYwE49Gw"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61723D7D9;
	Fri, 12 Sep 2025 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757713177; cv=fail; b=mMws8bhDao6pRfv4cvaLbRuBr6je/+BESemzRA2WB69Bsz86byfNwoMDkKdsg0gJ00yz1UsFF2jZYLH/zScc5enWy3KX93X91atjOdH6SZ72dIR6ChVG9GvoA3XBco3arSq0c9lb3VYx6s/CHUbpXk+FVNBEj9Yoo64ZwxeY0Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757713177; c=relaxed/simple;
	bh=6ijU3+uhb/y40/x4EMmOq/Sgo/ZKrJXa2vLqy4VAVMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qA+Xfr5zUx8ZDGZIoUS8tN0XLYv7Tu7f9o6+T57B7BLwMJZepCAN8NbySZwLVi8vcariTYXmI7LFuZ2izJWiYRWZOis6qEmD8nNxTmEGH6uc8aNKzASB3ltNWMJr0HoiWWyqipF8u61+3VupRO9ncYmFNxOwIyXpVwvLpjaTGlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aYwE49Gw; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXPk5CM3B+tyyo3rSaf9vbDPfbrcpao3cO+/YLdp+VZGULlVwv+z93sjDelCraGOvbdi+3u5PIJjJeZoS8ObUD1NYHxlhLiLmMRWEx0RbGeST/DXX6Dz9ZWyHgHdm63SNiQWaHuMEecBiyj5awPorOJdFsCxmYn/JL8l54L9VAsefVa6e0dzeHwMcdP1bcyY4KSyFGnVjL2C/uKUyqnIm1DRpijzxe4FAxV0u3d+znVdCvkZfXMkG2kf3fW0wCec5UFofYL0kptug9pc4sCX00DAXsA8NDekGUFUIR5KZVmhM25iflf66MWznaEjhcF1unArIEGu2IAcM0uDeBgEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoozvgRL7Yfm473FrnkJYo4y68YWnVjaFzCUD41E0Bw=;
 b=w+0yNMg5+UCbg4jT+0gYfcpK2A1RKxPCW9I7OiyTMiCyEY9Xf6MN5p/bKHMOWUkHKc7Xl7iAL1uXqacImu+KwcMNh7tmqACVgqju5sHq3PasxqGDf3EgFsChxJsB/UmnTSWG7yxqta/98a6eLzZRGve3WEUYfAIpjpa5YqyYWw7sDG5QeVlKJIgKK2LFxDktll+yB0kOROhFIohsU9I+JjpFkZsghhuVCdfXy6+PA1ZQVIHF9/sbTdPSr28aFGNTfPnX00OEjAZ5ordHPZN2dKEAEFvTsurc4tMdMlq7cPLJ7ZUSk8jYb6mxtXaZk671YNX5GuNk038/BwtESHFNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoozvgRL7Yfm473FrnkJYo4y68YWnVjaFzCUD41E0Bw=;
 b=aYwE49Gw+CZnvk2qYKtJ+Lyigra4t3r6TWcoe4qeu1VUUB8xx/Ox90Xg9y+OBvrkqBRvRINlPkYWiGv7TjxPzI9OQg7Ac8V6+rIB94A4P/RH8U3KspUGM6GmDWRdRHt0dim6TXoZdRBE3Tc6vukh7+TNWL3LVQdv+32gI8I8LPak1oPPIrUDWlJeQLp9iIb9Pz+rJbsk6Jv8GBIWj7DaZmNTcDmdHmdCon6klwH8/6p+BV0uE9cfLndSypYMHsWNP1EiWPj4aFajc34O77du26O1IFFU8UDSiBlyv6OuFkl9ir0kslhBb29wIOqAKFjQR5AurCWgKTbX2a+TfgsaUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10747.eurprd04.prod.outlook.com (2603:10a6:102:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Fri, 12 Sep
 2025 21:39:32 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 21:39:32 +0000
Date: Fri, 12 Sep 2025 17:39:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH 2/2] PCI: endpoint: pci-epf-vntb: Add MSI doorbell support
Message-ID: <aMSTDt0xOzhDH2Gr@lizhi-Precision-Tower-5810>
References: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
 <20250815-vntb_msi_doorbell-v1-2-32df6c4bf96c@nxp.com>
 <gkgdzbbq2ykim4gfrkw5qnimdyyxcs3efkt3lot3bh7jmi57he@wxsxp3m3eg6k>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gkgdzbbq2ykim4gfrkw5qnimdyyxcs3efkt3lot3bh7jmi57he@wxsxp3m3eg6k>
X-ClientProxiedBy: PH0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA1PR04MB10747:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b0358e-26a7-4904-7460-08ddf244dc3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGpKSGRZc0dpenF6dkgzY3VKNUVOeXZHTS9kTTJ1WHpHaWZNL0hKZjgyTENJ?=
 =?utf-8?B?ejY0bkNoS09jc1VUVWk2WDc5MCtWUU9sRzdtbUgvTnkxWGp0RERxelQ5QXBq?=
 =?utf-8?B?dTMydTFhZXIrNTNFbUZPMUpwVDJ3V0Nxalpxc3hEejZqdGcxc0YzbnNtNTdy?=
 =?utf-8?B?em56Wjh2Vk9Wa1dYYXhmMUthbGtWU2ZJVk9nSXdTZlBFR0RNcTJBNjN6bXNG?=
 =?utf-8?B?ci91dnBCNmFwMVRvZ3ZNNFRtTkNaRlRyWjg1RGV3UW8xVkVvVXhKdzR2NzRB?=
 =?utf-8?B?U040WUswUWordElVMkt6TU1KcFJNTzR4RERMVUlCSjRTYVZEdkhkczg3UlhH?=
 =?utf-8?B?Qk9aMEhoMGh3a1JuQi9KNTZxci9OQlZab2FNVS9yWlBXYVBKVnhlV0RFZ0pE?=
 =?utf-8?B?bk1BSUJGZUZ2NlBMTmplb25lMUF2M3lXLzFxeTQvWWFWNElqcmU0Vm5FV05R?=
 =?utf-8?B?SFpIdnJkVDFIQkVmR1dnK1pDRHJFcmhqZFFkb2lTUk96bnZjbmpzVHJBTVpa?=
 =?utf-8?B?UExXSXN2OGdCK0VMR3hmdkJkbmo1MVN0eDMxb0l6dlZ0UlZqRmFZbTgwMG9E?=
 =?utf-8?B?aWdZWE8vVGNCb0tlTG9FcjBNNWptQ2Z5OEdReVIydGVEVzllckVjUzdwNERs?=
 =?utf-8?B?Mk1FVzV5cEtLQiswbEU0WEdNT3hTcjZiNlVGRDBHa3IrRGZ4UzZKRXZreE5X?=
 =?utf-8?B?d3krNHhlRHNsSkhaUTEzeTJkOUkxWlh4RndESW50dHROSnNrbkJPZWkrOGZW?=
 =?utf-8?B?eUtva1BZc0dsRlU3aS8vZ3JCdGpjL2VaY2RlWnJKYWFyMlVJVG1QWm9Hb0VM?=
 =?utf-8?B?WU1IS3pkcVJRdTVFZDlwNDUrdjdORVhHTncrazAraCtqUVhGTU5McjM1NXRN?=
 =?utf-8?B?TnhOcDRDNlA4SmYxajRaTkRwTDZ3dmRMeVh1TnVadTBHOG1kSHpka1ppRW82?=
 =?utf-8?B?MEdLMkp1ZU92SzQzRFpNSTB4UU9SV2h5NC9UYjdQU2lPOVYrdFM4Wk9DS0NK?=
 =?utf-8?B?L2N4MENWeVNNdkpMYWVxVzd4WmNqcTRIRUpaa2t0L0xlNWs2aSs3bUx2VXFU?=
 =?utf-8?B?bXloOEx2R2llMGYxeDZrcUNEY0tURVJzelo5L1pBZUZlQW00UTA1SzF2NGdZ?=
 =?utf-8?B?bTNDN2ZSWTM1Y3FmWDFjTEFsVFRpK3BvQVJhT2hxeVEvN2VNRlhnMXVnUUZG?=
 =?utf-8?B?bWNaTXFtRFAwN25FaHdWZjBLNG1TNXZRdkU4aERnVXFBRWRlNkRGZHROL3Z6?=
 =?utf-8?B?RnNyUUdzQzdxKzFnSFRQbnQyRzRqZ0p1aXZyWVdBTk9jeWNEMHlYeldRby9W?=
 =?utf-8?B?cTE5YjQzUmhEYmlEU2pJRFZkYU12RjVJSjNiTXRJU2ZVOWYvNFdHM1l0VFRS?=
 =?utf-8?B?QkFkNlFmNzJHaG5pMGd2UFlYS1VlTnNkcFVUd2I2U2daS09nS091SERmeGRG?=
 =?utf-8?B?cXE1TkZ1RjBLRVhsTURKM2RwQ3RFUm9VMGJMNEt4V2JoMTEzY0l0NHoyRW9N?=
 =?utf-8?B?WExuTDNDNmlPeGQ2ODMvZTVsMnlOR2FpZUd6bU5Kb3JuZ3d2Q3R2VXkxeE5x?=
 =?utf-8?B?anFSY25PT2g3Q2FESFk0M1VtKzZqOGR0WlRRQWRITGxtd0pyY2thVlIwb0wx?=
 =?utf-8?B?Vm42L2lvU1FleVdiWDVzWUVpd0lDS3lYc3JUaWRIU0V0N0FBQ3B2bUw1Qkh2?=
 =?utf-8?B?WG0vVGhkRHd6c2JUNlBMT1lvNTdwb0RHL096cmVoeGRWL3RPL09zYmtkRE5p?=
 =?utf-8?B?OTBGamJLS0ZndjZwUkx1bWhQeWF6ZHBmTEsweXlRKzNUVTZudTNBTjVhTEFP?=
 =?utf-8?B?TjBWOXAzdHVic2htSVdEaEdZQlhtMVZ6dzZKSk9VemN2VmNSMC9teldUSVVw?=
 =?utf-8?B?L3NCNmh4aHc0NU45bFVYT0J6ajQwMlBWMktzZlB0emxqTDZ1TFYvQml4R2JR?=
 =?utf-8?B?aDlsdkg0N21yN1VZS1R0ZXNDYm40RjlWdHhmUnZzc2NReDBNZ05BMmlyK1Ni?=
 =?utf-8?B?ZGZUdy9RRjdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2ZrQzlVdFI2QnhUcW1yMXB2U1pjRHJDWFdyaUhFWG1aeGRFVUQ3SEI1QUtF?=
 =?utf-8?B?dTNGd3pINXJ2Ri95a0YydFFUVU1mYVBjK2J5cXZacThJWDRrZFdweU1abmhn?=
 =?utf-8?B?STI2emh0ZEZNQkFXM2lVNHZqeTIvQy9ScGdtdTR4cG9GdXEvSFdPcGxlL1FP?=
 =?utf-8?B?b2YxVDNnb2xNSzFrQVo2QUxpeFdxeG5LMUxJWklnVng3bGU0OGJSTTFmN0dh?=
 =?utf-8?B?SnZtRWVVeGVRRmdzQU45bHlISXZ6cnRnVk43eUlodHJVWTFuc1lKN1BzcUZV?=
 =?utf-8?B?TXN3S0JGeTVKWldqelpqQ0ZNWDhDM2dwV1REaXMrc2JDWGlRUWRQNWJvby9l?=
 =?utf-8?B?WEVYRFpWWnBHajdQaFVsZE9XeFBlN1d1SHFDVGwvWUFzeEJmVTNyMHVjNTVF?=
 =?utf-8?B?RllIRVMyRjF3d2cxT1lHMXVKek16T01RTmhVWmV2SWpMbm4yU1JlWFBDQ05u?=
 =?utf-8?B?MUZrWCszS1Z6cVpqVjBsajdZUFFOZVo0UUtBUTBBbmwyOHQ5Zk9aNlVYMjQ5?=
 =?utf-8?B?czRuTVVqZXEyd1J3YUVNN2IxYzM1dGlBdEFaOHc3MVJWbXhxM3VkbjA3ZnNZ?=
 =?utf-8?B?bENNcFdmWWFkWDZIcncwWnNDUGpORU8xWll1YlVpaXRaRjl5K1o2cEFwazhz?=
 =?utf-8?B?d3gydlV4NVB5MmFLNTE4bC9hM1VvVEdUQWVneHE0RGRpaHkxcXJtVnRlYUhw?=
 =?utf-8?B?ejBPeDBRcTBsWEtRSGVMZHVMMSs1bGdubHBRbVZjSjlSN0w1Wkk2OEJKS1Q5?=
 =?utf-8?B?UHIzUkYzUHY5ekZuQW5ONy8wdmc5QWxMRFFmYjJXQTFUbkZneUNGOHhJS09p?=
 =?utf-8?B?SjRnN3p3UU1IdHFlNFpNUStHRUFUazE1dFhwcHpEY3U3dkJXZllYTlZxbHdH?=
 =?utf-8?B?VDZHSXFBaEJSQnhjdXp5Z0tFR3p2UE5BVk9EdHZMYzJsb0FEOFp0RU8zNm9U?=
 =?utf-8?B?MTY1a1J0RENHOWZ3LzdsL0tBR0NKZ0YvSC9YRWVhbmFSMkF3WjA3elNLZmFV?=
 =?utf-8?B?S3RYSDdCQ0JPS0pxVDFBZlplV2xLN0dtTkhrSzJGQXFwYXREYk1ENitPOVFG?=
 =?utf-8?B?OGdySWlGcnRPYkdrYkk0cXJmSlBvc05LU1JWc21UREl5Wk1VTCtNbHZDSjc4?=
 =?utf-8?B?V0NwNUQwZHJSY2tLa2pYaGRMandyRWVWcjhDZmJlcTVVbXdiRFB4QkNVRnBa?=
 =?utf-8?B?SVIxWm16azJaZ2l0Q0hzOVA3ZWVDa2NtMERQRCtZcFFIQmpraEhQblZmUTdB?=
 =?utf-8?B?N1dheUdKTmNYaUFDV1VoaVR6eFlSUE9vYmoxV2xFSUFFdVlveHBZeUlpbWFt?=
 =?utf-8?B?SUVNMlA5cERpU2VBK1dsMEZpeXJubllsQk5yVnEwMDRmcUdDZU4xZy9wektO?=
 =?utf-8?B?Z2tnell2eE9vdXNlSEZZL0sxZU9JS2hLRFZxYW5qcjlaOUZBNkhLNzdYTUl2?=
 =?utf-8?B?b05wdFdXdFV6NkpBNDBDRHY2czhFRzMzbDArUk5PcmZpSUZoYlFBbXlickkz?=
 =?utf-8?B?K0FIMU42SGdEOWNtM0dsNmxOWVNvSWtLakYwVFV2Q3RRR0luT2c2QkZTMkMx?=
 =?utf-8?B?ZS9IYThLc3E0Nm9ZZk1leExGM1ZUeEFrUGNnOHFHSlNzRnRIRjRMa05JdTdC?=
 =?utf-8?B?L2d2QmI4VzVHbWw2blNQUkt6WUYxb0l1M0ZYckRnVFhVZU8xaktyUlRwOHl1?=
 =?utf-8?B?M0YybDVWbGdZQWRWT2lQYW5HanBWMm1PWFAvNGlVZDl6bzF3Y0l3OS9CdXBV?=
 =?utf-8?B?TG81dE5DU2VwRnJjTnlBZjQxUFhoSGpxNy9BVys3eVFkSnR6d1VjWlZUTzlz?=
 =?utf-8?B?YzdULzlIemVYSjJST3RZTmlhWk1BV1V2NklwYzRNMEtuenYzWC9yVU9vU1pn?=
 =?utf-8?B?QzRSWm5GaDFTVlNmNFRKRkFJWCs3Z3UwdytVSklCekdrdDZORHdjZnU5UFUx?=
 =?utf-8?B?OFpjVEllYmpGbWlIbStUbUJONTl3Z1dpcXVrMkJiVlgxQXhHK0dXWTlRMnF2?=
 =?utf-8?B?ekxlamZvZFczZU4rVldGVisrcTZoZDByZXBlTVl2TnJmb2NWL1ZLcFF6WWdG?=
 =?utf-8?B?MDhmTVFzc2N4QzFqLzYrbnU5ZEovU20wRC9iRTRsblFLNzFyWmZqVFNFQUhC?=
 =?utf-8?Q?aVcJLrIpoJN6PGLOBzNpqqwQo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b0358e-26a7-4904-7460-08ddf244dc3d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 21:39:32.4783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CpohAFU9kBSHq9O8OLJ1wucFG5LCwrHwXZa8gqH2L0qbuF2BS1SbmtbQZjG2untHdIT3T4nrn2JuMQsa0PdXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10747

On Sat, Aug 30, 2025 at 09:14:43PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Aug 15, 2025 at 06:20:54PM GMT, Frank Li wrote:
> > Add MSI doorbell support to reduce latency between PCI host and EP.
> >
> > Before this change:
> >   ping 169.254.172.137
> >   64 bytes from 169.254.172.137: icmp_seq=1 ttl=64 time=0.575 ms
> >   64 bytes from 169.254.172.137: icmp_seq=2 ttl=64 time=1.80 ms
> >   64 bytes from 169.254.172.137: icmp_seq=3 ttl=64 time=8.19 ms
> >   64 bytes from 169.254.172.137: icmp_seq=4 ttl=64 time=2.00 ms
> >
> > After this change:
> >   ping 169.254.144.71
> >   64 bytes from 169.254.144.71: icmp_seq=1 ttl=64 time=0.215 ms
> >   64 bytes from 169.254.144.71: icmp_seq=2 ttl=64 time=0.456 ms
> >   64 bytes from 169.254.144.71: icmp_seq=3 ttl=64 time=0.448 ms
> >
> > Change u64 db to atomic_64 because difference doorbell may happen at the
> > same time.
> >
>
> Only the atomicity of db variable is enough?

So far yes, atomic OR and AND safe to check doorbell[n]'s each bit.

>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 153 +++++++++++++++++++++++---
> >  1 file changed, 136 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 83e9ab10f9c4fc2b485d5463faa2172500f12999..1c586205835fe9c7c5352e74819bccb4ece84438 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -36,11 +36,13 @@
> >   * PCIe Root Port                        PCI EP
> >   */
> >
> > +#include <linux/atomic.h>
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >
> > +#include <linux/pci-ep-msi.h>
> >  #include <linux/pci-epc.h>
> >  #include <linux/pci-epf.h>
> >  #include <linux/ntb.h>
> > @@ -126,12 +128,13 @@ struct epf_ntb {
> >  	u32 db_count;
> >  	u32 spad_count;
> >  	u64 mws_size[MAX_MW];
> > -	u64 db;
> > +	atomic64_t db;
> >  	u32 vbus_number;
> >  	u16 vntb_pid;
> >  	u16 vntb_vid;
> >
> >  	bool linkup;
> > +	bool msi_doorbell;
> >  	u32 spad_size;
> >
> >  	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
> > @@ -258,9 +261,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >
> >  	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
> >
> > -	for (i = 1; i < ntb->db_count; i++) {
> > +	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
> >  		if (ntb->epf_db[i]) {
> > -			ntb->db |= 1 << (i - 1);
> > +			atomic64_or(1 << (i - 1), &ntb->db);
> >  			ntb_db_event(&ntb->ntb, i);
> >  			ntb->epf_db[i] = 0;
> >  		}
> > @@ -319,7 +322,24 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >
> >  reset_handler:
> >  	queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler,
> > -			   msecs_to_jiffies(5));
> > +			   ntb->msi_doorbell ? msecs_to_jiffies(500) : msecs_to_jiffies(5));
> > +}
> > +
> > +static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
> > +{
> > +	struct epf_ntb *ntb = data;
> > +	int i = 0;
> > +
> > +	for (i = 1; i < ntb->db_count; i++)
> > +		if (irq == ntb->epf->db_msg[i].virq) {
> > +			atomic64_or(1 << (i - 1), &ntb->db);
> > +			ntb_db_event(&ntb->ntb, i);
> > +		}
> > +
> > +	if (irq == ntb->epf->db_msg[0].virq)
> > +		queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler, 0);
> > +
> > +	return IRQ_HANDLED;
> >  }
> >
> >  /**
> > @@ -500,6 +520,90 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
> >  	return 0;
> >  }
> >
> > +static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> > +					    struct pci_epf_bar *db_bar,
> > +					    const struct pci_epc_features *epc_features,
> > +					    enum pci_barno barno)
> > +{
> > +	struct pci_epf *epf = ntb->epf;
> > +	dma_addr_t low, high;
> > +	struct msi_msg *msg;
> > +	size_t sz;
> > +	int ret;
> > +	int i;
> > +
> > +	ret = pci_epf_alloc_doorbell(epf,  ntb->db_count);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < ntb->db_count; i++) {
> > +		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
> > +				  0, "vntb_db", ntb);
> > +
> > +		if (ret) {
> > +			dev_err(&epf->dev,
> > +				"Failed to request doorbell IRQ: %d\n",
> > +				epf->db_msg[i].virq);
> > +			goto err_request_irq;
> > +		}
> > +	}
> > +
> > +	msg = &epf->db_msg[0].msg;
> > +
> > +	high = 0;
> > +	low = (u64)msg->address_hi << 32 | msg->address_lo;
>
> Can you remind me when the 'address_{hi/lo}' pairs are set?

set at pci_epf_alloc_doorbell().

Frank
>
> Rest looks OK to me.
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

