Return-Path: <linux-pci+bounces-42853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A5DCB0615
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 16:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DD953001863
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457152D4811;
	Tue,  9 Dec 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QcbG2dE4"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761C26B75B;
	Tue,  9 Dec 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765293448; cv=fail; b=KLB2Ub2XyaFBVVxgEdxEktacajM7ltx6yWGmtPTZsbVHDPXSLUlEjQna3Zc0I1pxpugZ50ea074auU6tZiWdmTz71YX/78cOTdT6W0xj+SoRCzXB7Dmlq8eyFgrWzC1eaG3W2DG+N70YCxaqNNJdv3Fx1ppNhE8py5B7HmUI7j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765293448; c=relaxed/simple;
	bh=qljsHoi8Y/ujmFxVucVy9znAKMG/jtcOLSK8rDYpdV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=swyh8Pc3gbwJjWErBdBuwaDD8qJH6FxCD05Tb6o9YN2zW3n/czS7dgH2LTgjG6xO/mya51p33zz+B1gmMka8EnvdVkMIfbhAmvhBcaGXBEmnBqCxHzVwRCDmd7a4VK+1UMaDJwNx2sNeFbSOLcymufAHyLEV/PrUL4dyARwmA+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QcbG2dE4; arc=fail smtp.client-ip=52.101.52.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Axmazxg55eJ6oeXkIvmsC+GsWvGfcZ27sxk0J5m/uBNS0bIKRLRDyb3BnIShO8T8NTX32WMqohq9GjdBP2iRWtAz3f0RoinsOczow/tZZF9dPRjwhakBhdj388lQBnxpEe6XHHFYJP+hoxozftseib+o7RHdBRVgkVtYsZKVPopOMSN+Rek91AddAx/nLmoKF7o3ILxVXWaEszuRRACzmc8DYokUuqKyhRomnFB8+paym+VAIUThjSIQiMp7qyAmAUbLbZ0P82qZCIKSqZ/9j43uSlHp/tX1/s5I5nN4WqT8b7+IGg0L/glqkcMrSWsQsy9qG5gZkbKG/euzxxcOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaVrIGt3cXiMQy92eaJXxp5hHRlUwiD19d4/Y4m//Co=;
 b=xFu7sIEPuSxR974hEgza2fe1N5T9qrAqgFoBUBCFB1TpdZvHy9olfBMsYkyl5LDbEGtZxKypxkG+rBADhyeb8H2toyHTeyqTVRUrS2RCeZCPp7UBWgvtjyocDypJxHSaSB3PEXqFeaSv/ECd/jRXH+RtX03H+k30ZoKjr0j9EwM/VA1KR8IdecRbgSUDHO8HE2WvFLo4HlqPbmdLhaelsr06qOWe10VHxKU8QoDrztWXT9KKr2Cvu8CS9ARm/dWtFjs2yd9JT+z8VP30bGwc5d1bAhJ5rkJuuxFtgaYhWlFVJcNsal5D5LcLI7CuCeXwJJ4pvC596riFDxmpEXswxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaVrIGt3cXiMQy92eaJXxp5hHRlUwiD19d4/Y4m//Co=;
 b=QcbG2dE4EbAHb/PA1muAjTr3WJ8lgxosT6Cw2NiQPTiqMJn2pAZ/j4aSYUHJCp4FEHpaHLCsMAnKbIWICUUznpHANMX/e54oYcGnOF0sY9q8rDqKtud0XjoCIepaHHd4YGM8xAdH8pM5tUKmqCs5+fk/AJ1w+3F6vAVZQJyaF8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SA5PPF50009C446.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 15:17:20 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 15:17:19 +0000
Message-ID: <2413985e-ef5f-48c2-a2d1-1cce91965752@amd.com>
Date: Tue, 9 Dec 2025 09:17:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 20/25] CXL/PCI: Introduce CXL Port protocol error
 handlers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251208183749.GA3302551@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20251208183749.GA3302551@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:806:20::29) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SA5PPF50009C446:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed0111b-c719-45c9-5dc1-08de37360b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjlpZnZDK0dJQjJXS3h0QU9jYVlpdFJFMXIzQkV1T0xIZ3I4VDIyQ2xTRDNr?=
 =?utf-8?B?aWtkYlBYQVFWRFE2ZVZ3SHVpR2pFWGViTHZHa2cvdzc1dGx2QWNpcHVUVFBG?=
 =?utf-8?B?VGE0NlFRSGV5RS8yVEhHR2RKblZ3UkdBSzJIK1Nkd0ZYNndZdmRqMHJqbk5R?=
 =?utf-8?B?R0tETHRBdFhXUGhPVUZueVJ2VjVwSFJDS1lDUHhDY21CK1htT25PRHpPcWs3?=
 =?utf-8?B?YjAyMGpBV2ZqY0NkOVBqUGNOTzNQekVxVlJSSXFlb0YxaVVRWmVsbEhPODJr?=
 =?utf-8?B?ZWhMU3dweks4Y2hCMUVFMW0vRE9CdEZMMlBTY3I5SldESGtNM2hDTDlZbjFZ?=
 =?utf-8?B?d3l6bTZBQzRRR3dnVUFnZm1zMEpZVW5xRHVwelY4elZ4TGdjMm5zbXU3c0RC?=
 =?utf-8?B?Ujk0QmNORTJYc0pTZ0FEcU94anI2N3NuU3dDOFZ5QURkTEdIdWRYYjJ3Qk9N?=
 =?utf-8?B?OGJFSkVtcGZaQWJQczZ6azNsa3I0L1RPUi85Rm1tTmlsWXZjK0plOEwyN28w?=
 =?utf-8?B?alB4VURreFBZcml1WXg3bjhLKzBxUnk1cVBkWlJ1RkVvcWVpNVd6eTVPUjg3?=
 =?utf-8?B?Szd2ek1EaUE3RFdyNldkTmVLenl1eS9qcWZYcmhad3IrL2drTHpQYllLVW5M?=
 =?utf-8?B?b3ZMUTNWcmVYTEhjR1Z3VlJGYUhublZoVDRtYjlFZE1nTVZoUUxwQnRtUUZU?=
 =?utf-8?B?WFA4dDUwZnNXbEJ2QmVqc1pjZUtpNTUvY3FBYUUwbnpzeGp0YUgzRFc1eWdk?=
 =?utf-8?B?MFJYc2QrbHBWS0M0ZzBBNWkyUFdMRS9ickphVE0zRnhLaGtTNFdPaHg4WldT?=
 =?utf-8?B?aDQ4N1k5MEg1Rzl0UUFJcW40bzM0dnV4bGd4dWpONVNGbmJ5MWhpbTN5Q0N5?=
 =?utf-8?B?eTEvZkVKdU4wa1k1SnY1NGN6Wm94eUlLZkw2NkF0UWRPKzF2VGVubVIxaEUz?=
 =?utf-8?B?WWhKcHY4SUFxaTVDbC9Fc0hEZVFBNEczeVk1aUt0KzR0TU1HUFJ1VDMrQURN?=
 =?utf-8?B?aTVqbWNPRkZzdDA5c0dSalRNRnpObHF1OHQ1TVBCZjY3azh3dGc5YjFmaVFl?=
 =?utf-8?B?ekl2UnRtQ1R2am5rVXhWTENNNndJYStBaHVaaFZVYW5uL1FiOS9qblhWMTNI?=
 =?utf-8?B?V2ovZVV0ZHdJcGxiV0hSNlFndUJlbFVCNlIxMCtZWGdid05PcUU3cHVDS3JJ?=
 =?utf-8?B?VFMrb1pLMlRIWjFFb3BEQ2tjMWlRTkxiN0JvRzErV0pQMmNsa3c2ZURUQ2h0?=
 =?utf-8?B?TTJ2WmJQbHVOOStGVk9GMCtydGRiVEwvU3Nlb1lmcGhmRTJIcS9BTjFVeExX?=
 =?utf-8?B?U0JUVzZtb2VjZ3JuaWxmTVd0UHh5OE45SFpvL3RtN0pqeVliY2ZFYmFWempY?=
 =?utf-8?B?MVlDRWlKbVZVSTg4Zng5cmlZRWdZT2QreDhtQWEvMWw0TjJpN0RPZEgyWWNW?=
 =?utf-8?B?aDlDaE9BaU1Cem5BenpheTFnc3o5dDZtU0RGcFd4TjM1Y3lZQ1FTTno5dW9z?=
 =?utf-8?B?SGd2MkIzdmNUcnpqOFZLSXd3QnBpY1M0VmhHYTR6WVBqZjZxSFVsNTdsYXpU?=
 =?utf-8?B?YjN4dnRiLzhlVVlHR3NqK0FZZ2x4anFBUURjdU04NVlRdzVYMC9la0ZOOU10?=
 =?utf-8?B?RzNiV3JCRHR1b2UxOE9IQTVrbDAwUjh4SVFoRk9DNGpvaHcvUXN1eW5lK1Br?=
 =?utf-8?B?amVzTUM5anV0dDB6RytzV0dJaUxib09EaEVleGxEUzV6M0xjN1NlNEcraUp4?=
 =?utf-8?B?eG5yeCtzSHdWSnU0QVVIMC9URUtnUXlpT2dlcmpydG8wcU0yRXVLTkoyQVNN?=
 =?utf-8?B?dGNhbzdCcktydjZLNVVoRVNXNTVQM3RCL1lvVGtEdTJSQ3R6QzNZVGNUUngz?=
 =?utf-8?B?dFBpV2V1OHBmTkVGYWxvK3g3Y2IzY2o0RS94dDBLZkN2Nm1JMkNHeW84RkJO?=
 =?utf-8?Q?M7/BiNxB1geQ9q4qqv2tqt59DG1w6I1I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1o4d050WmpmdHdUelpTdTR1OW00OHQ3eVY1Z1hRWWcvTTMxbDYwcVoycis3?=
 =?utf-8?B?R1k2eFJNazJPeHNybE9kZzB2QThBQTB0RW5aS0w3WXFhU1gvcy9LMHNqQ0xk?=
 =?utf-8?B?bnc4bUhyV0ROWDFpQk54aDZuZWE5bkd5MXFWMWdXOU9Xd2VyMlZpZGNSU2ZF?=
 =?utf-8?B?c2I3TFhJOGhFa0l2ajFqeEd5NmlPUlNaWVRRS1pKNGRJTnhQK2liN2pZcUdW?=
 =?utf-8?B?QzFvTWpRZ2hEdDJ3emtLd0R4L3ZhOFhKdjY2VE5hRVd5K1dQeTdnMnJER0JC?=
 =?utf-8?B?dk1NZnFLU0hRd1JmYlQ1a1Y5VncyMHJHaEw2S1hpRW1zQ2tGL2JYUTlZc3ZM?=
 =?utf-8?B?Sjl4Ukt5TDVVSEZ3MzB3eHN6NlpaQmFhRWRnWWI3dHRUdHM2MWc2ME1HYklP?=
 =?utf-8?B?K3k4YkhXTVpHZ3E3Q0RaQitodkxiOFlSV1RwakhGSXlCN3FuTUgrY2g5WmtN?=
 =?utf-8?B?aDRQV2o1RDVBTit1Mk9hKy9jblQzc2cxVS93NmlSV0pyR01Sd0FESytrQytu?=
 =?utf-8?B?MlBybE16TzJBMm9kWmQ0amVuVUJOaVJQS0RZaGkvanRBbUM1STRhUGlaSnZE?=
 =?utf-8?B?d1BINU41RnA3dTZLVGtQaklyN0RCT0hkWUZjaEdEQlc3RUpleU1VOVE0c0w1?=
 =?utf-8?B?Tzk3UEo5Y0x5dm5Hbnh0cmhMWWFXTkxGQ0ZRc0hBb0lGSUlNRjdXTE1zajl4?=
 =?utf-8?B?cE9UeVU0dWNydnlvaHA3ak5UamN6VExwaVB5bFZ5RVlicGk0TjFTUmc1VmlS?=
 =?utf-8?B?TTh2akZEOUZ3UEJUV0ZybDFGVFY3S0hrY2lpMXdHZFZ0Wk04ZGN3RWI5cS9z?=
 =?utf-8?B?UHJPSjR6c3B2ZFg0WGpjK3ZBNDJONWNNekJOd3dWeXRMcXJocTJvSStzQTQr?=
 =?utf-8?B?a0gxdi9yN0J3c3BhNFRvck9vVysyeGFwK1QvbTc0SmZjdnpVNVIxdTB5dnZj?=
 =?utf-8?B?M2VBdm9IMG9QV0Y2b3dJRFFnTEFTaVRMbkxKc2VQNUYrcUE5Vk5Lbjc0K2Q2?=
 =?utf-8?B?QWtyaWlQdk9vRkEya3hTYWRHbisrc3Y4b1Y0ZEs4ZzFKV0Uybk5kcFUyTVAz?=
 =?utf-8?B?amFsTUNEY3VmTGxwTUZDSGJGV0ZkTHdQRnlzYmMyKytWRWlUTlBJU0FXcTk1?=
 =?utf-8?B?blpUdGx6RUVjZ3RtZTNidHRlZVhHYmpFZVZkVEJ3MmlNOXZMUC8xai9zaGpU?=
 =?utf-8?B?RlY5MEoxbnZyMXQxd0VOV2NJOVhzV1kxc1dZRjV6eDFNVDhnS1FyQUJGRDhH?=
 =?utf-8?B?dktMWUF0THREYXA3TlQ4MlhsQ1Q3OStzQWVCQTBsdXpiSHRkME9UeVpIaVh1?=
 =?utf-8?B?bm5RdW9scGZkR3BVcG9nZ04vdWJKQjMzRGZtU1RaaDZoQkNTWWc5bGJ2L2hS?=
 =?utf-8?B?aEsvVndDU1ZlMkNwbHJkSFQzY0dMTytFUlUybHFQcDhKYkJ5VTFPMkIwVTg5?=
 =?utf-8?B?NG1WMUVZQlljR090b3BUNW1SSG1FTmV3NU5NcE9ZKzkwaU9HbkZsZFh3K0g0?=
 =?utf-8?B?Q3Z0d0UzZFRucmdDQ1J4T0FLOWFWMCtLYllzRm9IY3NyWWxTb2ZYekZOVTJS?=
 =?utf-8?B?UkhnLzRTQzNGR3hWY2pmQUVlNnd5U0NnRUNwNUowN0tMbFRxYW4vTFhTN294?=
 =?utf-8?B?NDk3dTV6T0FrOG9SbVJKSjltUHRkWExBTTMzSWg4MkZTd3BWbGNNNW5aMHht?=
 =?utf-8?B?djR6VmJSWWM0eUNvWGFKdTFpMjJyaDE1dlBoOHhMUVlRQ040NTFjcnlscDA1?=
 =?utf-8?B?T0hJTWFOOUcxMjIvZnV6ZVhtcWRyQVhQVHdWOWlEa09lSWVaMG54QWU4eXAx?=
 =?utf-8?B?dWtKekJpYW5nSE1rMnhrODRRM0NyWXdNT1hnVDZHNmpMVkhuRkpiTXJrWlJP?=
 =?utf-8?B?cWJJcHVDOEVHTnhENDJYRWdmeGVXdkdwZmZtNkl0eHFsaDMvYkQ0ZmRWTW0y?=
 =?utf-8?B?cElSQTdGZ2FZanQwK1dyczNEQWowSmxGRkZoNEhUWVFkOVRybDByMmN0UEpl?=
 =?utf-8?B?SmF6WG1FL1NBWjJFUjh5UEF3UFBaWitudy9rZVQ4em5zd2hnQTJtb1JHN3dS?=
 =?utf-8?B?b2gzS09nR2wreCtVeEhLUHlzUHd6SjZnSVBDek5UYS9sMzVXaDg2RVMrNGhV?=
 =?utf-8?Q?dGTM7fRizXVvk4wWy60h0WfkB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed0111b-c719-45c9-5dc1-08de37360b52
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:17:19.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHH+EAYR8TFo1PUKWeE+jyQpLUb7udN9PavUHPobwJ1e4JxSHaNaR8EmfoZA4X7sr7NJGuDIueyuq4Ja2EYG+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF50009C446

On 12/8/2025 12:37 PM, Bjorn Helgaas wrote:
> On Mon, Nov 03, 2025 at 06:09:56PM -0600, Terry Bowman wrote:
>> Add CXL protocol error handlers for CXL Port devices (Root Ports,
>> Downstream Ports, and Upstream Ports). Implement cxl_port_cor_error_detected()
>> and cxl_port_error_detected() to handle correctable and uncorrectable errors
>> respectively.
>>
>> Introduce cxl_get_ras_base() to retrieve the cached RAS register base
>> address for a given CXL port. This function supports CXL Root Ports,
>> Downstream Ports, and Upstream Ports by returning their previously mapped
>> RAS register addresses.
>>
>> Add device lock assertions to protect against concurrent device or RAS
>> register removal during error handling. The port error handlers require
>> two device locks:
>>
>> 1. The port's CXL parent device - RAS registers are mapped using devm_*
>>    functions with the parent port as the host. Locking the parent prevents
>>    the RAS registers from being unmapped during error handling.
>>
>> 2. The PCI device (pdev->dev) - Locking prevents concurrent modifications
>>    to the PCI device structure during error handling.
>>
>> The lock assertions added here will be satisfied by device locks introduced
>> in a subsequent patch.
> 
> Weird.  Can't you add the lock assertions at the same time you add the
> locks?
> 

It is a bit. I will try to fix this. I might try adding adding the lockdep() 
checks in the later later patch.

>> Introduce get_pci_cxl_host_dev() to return the device responsible for
>> managing the RAS register mapping. This function increments the reference
>> count on the host device to prevent premature resource release during error
>> handling. The caller is responsible for decrementing the reference count.
>> For CXL endpoints, which manage resources without a separate host device,
>> this function returns NULL.
>>
>> Update the AER driver's is_cxl_error() to recognize CXL Port devices in
>> addition to CXL Endpoints, as both now have CXL-specific error handlers.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 

Thanks.

>> @@ -1573,6 +1573,7 @@ static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>>  		return to_cxl_port(dev);
>>  	return NULL;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(find_cxl_port_by_uport, "CXL");
> 
> The usual export question: is there a modular caller()?
>

This should be non-static and non-exported. I'll change.
 
>> +	dev_warn_once(dev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> 
> Maybe "%#x" (add 0x prefix and use lower-case hex, unless there's a
> different CXL convention)?

Ok

-Terry

