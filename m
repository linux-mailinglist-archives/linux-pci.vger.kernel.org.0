Return-Path: <linux-pci+bounces-12835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C079996DC43
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 16:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16171C259DA
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE061D551;
	Thu,  5 Sep 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UzetKHg3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17569175A1;
	Thu,  5 Sep 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547612; cv=fail; b=uKhe7jWLjM4ifD7c/69GBR0bc+7kCXDyrB+I/lM9Tl7uMi8vF75z2HYQ6NGWy/tmj0BTR5upbhSQLe314oLvbyT/xAgET6h/tZImY3HKeDavlz8CKsPLtCnZzJ+Gad65gbjM5qFQdFcW8KdhxfZGQ8+h/uj6rTfWBqPBNi93dNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547612; c=relaxed/simple;
	bh=hedMh/mBXiJyFex9OQWPgz8rYMqBiZQ/Rt8WvoGBryc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XcBmaPoibhbcqBNNKENmWEtS/qrnKvUCapGsy2q91G9RyexJeEM3K3Ej7X19r/SSafn9Xzbm/nznTCCX/Ml/R0fZjxnvs/e7p0i2xCXjKD2wO9XjillfaaGoOWkdHYo/2Ob+tKZdD4lpSagHb2uhol0G8PBzoHWZW/Sv7q4LElw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UzetKHg3; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AG1/To1l92LF7V1UL7KF+7XUNFbmvn4nojU6goMdX1W7p3hsmbetPcwjV0cClWkg0FWiMYVVCR7y+wOBQMeatFSFqCrYaZbeDfCoSdM6DrKyNJXZU4+SISCQjjEOV+H1DOkOY8QKc9otqXQDQwE69KKQiNx7+5TSz3SLWsoiBtgP4hnBQIpEtG9UTwoZ1TchIF8bZRt//VLOUV2ANccaWxB6dfwMT8LXC/xS1IofNBP8wbq438YMRlduzgPatDfYPgpFD89ZBnwhEV/zRy5k3S3rMZ9ToC3dU10e3/BosEy3DYAx43d0UNCXYurE+GknzOZ/cYsKOADGWuSmgZPamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpT3lH8/BRnRidnJEDEerO8l3Jii5E9K9FhnOfZS1iI=;
 b=CCZvwLj2dDtG1B+HqNaLXXYMjvuS5LKAt1U3ZOxFo+4hPbcmWIPbbmEkvz0nf2z1TlgxV+7Nsqu1m0jdo1cfg+1Y8/pNFGcxrsoiXqrFsWg3gWSuN1TTzWmElie2rCZ2royrpK0AtyM+Oz6WSAXpzLRKcPdTufJCiUlR5OWIZZciEfCkcZvOWZsu3rSgAEXfFxZEqeG12IvJ0YTiWThMYzwB7+X5lpDh9faDkHt7sCmlh/mV0D6fB7XdKRURWtMIJUeqDEWy5j7ROHMFXqByStSafhT9KdRt4BUpU9nxBSnlEzcOkEuI7yOoxCHULZb7zShxmP6kI87dHTDiF4nKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpT3lH8/BRnRidnJEDEerO8l3Jii5E9K9FhnOfZS1iI=;
 b=UzetKHg3H2qiGwP8Z1lo5QdAv8/7x4tdk8H9IPC7boov8e7PRA1Vqa/d+wT29MXPUZTX4Zkbvxar4n24HVL7alP4YvLDrEXM4jdR5RjwE9VKX7Tr/mvTnQTY9E22HrZadbLuUX6eimDeHz5Xnf/fKmjSuXuUO7FFZfJudpKgRO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 5 Sep
 2024 14:46:47 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 14:46:47 +0000
Message-ID: <50d9910b-dbd4-48d1-ad43-f298d14986fe@amd.com>
Date: Thu, 5 Sep 2024 09:46:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 03/12] PCI/TPH: Add pcie_tph_modes() to query TPH modes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
 Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 bagasdotme@gmail.com, bhelgaas@google.com, lukas@wunner.de,
 paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240904194052.GA344429@bhelgaas>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <20240904194052.GA344429@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:806:6e::24) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc51336-8ff6-43e3-7e09-08dccdb99167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXVXZnZhYzdMbHhTdlk3K3BhU2t0YzFPNFI5ZXA0Q2VibmFMcmlJekJJS0Fk?=
 =?utf-8?B?WEp6M0w3dmdaM21UV2xRTUFtM2JuamVmc2E2TkpyMDBnMjZkK2JKVk5teWVK?=
 =?utf-8?B?eXhQRDlPSDZKN0pXakxjSjhxV09FR2tBK3dWQWc5R3ZRZnIrQXg2bDcvc0RQ?=
 =?utf-8?B?S1V2LzA3c1JnZXRpdjN4SFVkR1o2ekFHdkZZZVpvdi9Ob1cwdVFmNThsdGRJ?=
 =?utf-8?B?OHJ6a01QQW12NjBtcHIydUZvVkZXUGdxcDJiYUlneFc2ZnhoL3IwVWdMeCsw?=
 =?utf-8?B?dVlPbDNlVGd0d0s2eWd4Y3A3dXhRK3d4cDZSNytnT0tXWFpQSjVEbjVCcExh?=
 =?utf-8?B?K2JETGxRN0MrRVJCOHRWMDN6M2JlQnYzeDZPbXh4UnZIbytWcmk3RWs1TDJU?=
 =?utf-8?B?NUlFRWZkNGZ3SlZjeFFTNm03V1VaY05pNXVsZjI5UHh0Mk9OK2s5anZTNTQ3?=
 =?utf-8?B?ZlhBWmtrZUY5bi9qK3BkaGZXd2VQNlp6Y1crTnlramlTaXkvR2JiOWJlQ2xp?=
 =?utf-8?B?TzBBaHhDcituSmhrbmdXbDZUU2pSTDZDdCt6NndjOVFWdy9hSHJ2dGdYUVZm?=
 =?utf-8?B?REVRSG84SEdmSGJjOU03UDFCdUhTK21YR1ZOdVd3QmJTdUFWR2ZZTFR2bTAr?=
 =?utf-8?B?U3F1bWh5bTM1VFVPYktDVTVDK0p5bVRsWnFteFJqb3pwR3pTSTVFcnBSRFky?=
 =?utf-8?B?dEtmZFgyWlkrNU5FdmV4MjlNdUlJT1dYZithQ01YWjJpUHJweUZhYkdaejAy?=
 =?utf-8?B?d0NDN05pZHRvUisreXUvRkhvNWxyYS9PZWxoQTFqZ2lOQUdjYzFHbThmQ1Zi?=
 =?utf-8?B?QnVBS3R4ZWh4cFN1bUZYZlcrT0NOc1Axayt2VEoyV3orUUcwSUlYSkFScjVD?=
 =?utf-8?B?MEFxMFpLazBiRTBBV3Baa0lSazJ2VUNBam5pZm0zR2U2RjEvOUNOTytFT2lU?=
 =?utf-8?B?b282d3F6eGxIV2Z4Yi9DOFpCVWJ6elp2QmZtTkxJN0RJbU5velVNQ0dubDRr?=
 =?utf-8?B?cG9hbG40UXMyMFBINGRISHB1OEgyVGVhNnQ2MVQzWks1a2k0NExlejBLY1Jv?=
 =?utf-8?B?dURQZXBmb2plTTl6dlFUK2xjdFVySFI0ck5LdXpXcjNaYTBFWEdJcU1YWnF1?=
 =?utf-8?B?UmFZcERuK1ZBdytHM3R2UlNTR1YxbkFxckpIL3ZGNWFEcmI3NUxTc2RFckI3?=
 =?utf-8?B?ZHREN29LbGROb0xNMXlrQjlWZmp2R0NHRnhlbXFueWlzM2Z6R1VmMXYvUUFE?=
 =?utf-8?B?WWIzdG9sQ0lOd2lPZG15Tk9wSS8yQVFSc0l0d0xOb3ptQmVOOTBIajAzTUVt?=
 =?utf-8?B?ME8xUzU4T3NBWk9ib2g2MGVpMmNEUGNScFRidVlYNVpVRGZFbTZGWVVhYWNW?=
 =?utf-8?B?SU9rczBVbVRBc0ZEeENla3B1RDMrYlJnY3JqaVlFUHNVR3FqeW9DdVUveWh3?=
 =?utf-8?B?dEdMdjRKdTJBQmUzb1UzNXd5dHpMTCtZZjFKek5nVXdxZjVZZDNwekNQVEZy?=
 =?utf-8?B?QkMwS0crV1BHRFkwSzVLMmdMR0grNU9RaUxTeXNCK2FSWlpCRG5KOWJMZDY2?=
 =?utf-8?B?UWthMkV2ZGhwOStFUFV0aU1pNjZoeDVCMnVMSjdKRFpTVmJzeUhJYnVWVTlt?=
 =?utf-8?B?TVdxVG8rekw5K25OR2IvaUl3Mi9jTEdJVDI4WFdPdUZUSEtIS2NXN3ZoRzd0?=
 =?utf-8?B?c1dxc0tLNmNQaUxkcUs5U0lDMGxTSHlzR0lFd0pLRWhnV2dxS3VydW50RWpM?=
 =?utf-8?B?Z3g0VVhPMGNyUU13Nnd1Yjg5Zjh2b3BJb3o4MDRIeWtEWnFYSU40aFh3UXZP?=
 =?utf-8?B?NytLcWZTc2FHeEJLZjhNQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXM5R25tU3ozNmdDVDdwcGFoNFRjWWtZUldVVVIraC83SHNKSjFZVEkyVDRr?=
 =?utf-8?B?djJ6WkFlYUJUWkdFSnA5NEx1K1JtNDZodVFBMEIrTnNjRVJ0Wjdtc3c4Z0Zh?=
 =?utf-8?B?RU1GQ0ZOLy9DaVFWMmpkdG5ZekhtMWs2eklVc3FjLzFZQWJrTzRIcmJjMEFL?=
 =?utf-8?B?dlBRWUgzRy9JcUpCN2dieFdUblIzOXhQdHpMR2xCMk4vK3VWOWNNSUJOdUFU?=
 =?utf-8?B?c0VObVJMSUo0T05OSmdmcW5wWkFvQzlhMmFGVXhOVFdXMDdWQW5FNGFJSnIv?=
 =?utf-8?B?SUhDOG5kaGFBVUdXRVlXNEI4Sjh5WURMZmJVT3FlNVd4eURYYWplZ25TdnQx?=
 =?utf-8?B?dFh1bmllald0ZzFwN0g3Tnlnemh1RTUzUzRvM3hXaTRaS3pVRHRGaEpEVU5a?=
 =?utf-8?B?YTZSanErUlVYUzJ5UWxpSlkwMEtkdkM0cTBZVDZKSEtFdzBOdFlvaEllM25V?=
 =?utf-8?B?SXhwd1d0amorMVRBeDdoMVN2ZkpKM3IvcEtFT3BMRGdYTkx2Tjd4VGNIalAx?=
 =?utf-8?B?RUVsT0dwckRvdWs4bFBBUWtwaHlxYWR6cm41NmhlSThwRkh4aDhHc0Nod3Rm?=
 =?utf-8?B?cFdsbXdsZ1JockVGc0x6anZHa2xuMVpaQ3o1S1krUlFBMnJHc3pTT2tkeC9o?=
 =?utf-8?B?bjVDOWVwa1E0RTNHK04zTnVrRE1VanFubkVYb1FHeExvaC9FT0xTaDhHRWxU?=
 =?utf-8?B?MlFoUmVIUzRBSFBRazFrVUtLYUo3empOYlVvcTFjTzJYTjJyTlNFUURERnZE?=
 =?utf-8?B?Z1pRbWh1ZnM2V3RnUFN0cmFqc290Q2tFWUFCQlNNdG1QWUk5cDdSMGxUQzRy?=
 =?utf-8?B?ZW9QMDRGWGo4L1NIaHUyZ2VCTUphaVorazVseFFOQlliZm9BMWpnWGpLWmsr?=
 =?utf-8?B?bUpOd1o1STFWSVVJZXQrVitUWE5ZOE1qNWo1VDZxcXYzeVFsMW1kVjYvbUFy?=
 =?utf-8?B?RkUrdDhMWTE2Q3FhVy9Cc0prVVd6b28zWUN5bXpYNGFrKzZkUGh1dHJaeTdh?=
 =?utf-8?B?aUxWWjFQb2drYWcyKzhRc0pDeEdlQTRuUllyTjhxOXArMHJncmdGQXh2NFZX?=
 =?utf-8?B?Qnl0WDVyZGh6THVOYitROVRjUFVaZlIzU0Z4SWtkSUZUREFLb2pNRG5pUVk5?=
 =?utf-8?B?M0Q2RUh4MEdvUXAxQWpoSDJyNUtlakpzU2g3YjNZVnhrR1gydElNUEVWVlRY?=
 =?utf-8?B?TkJZb29MMVJWSEQ3czJxdmpjbkw0b0NxVi9vVGNuR2FVMVZwTkM5NlhLbm5r?=
 =?utf-8?B?bThKODErWDI0eS9SS2twTFYyQXpvTmhDU1BWSXhEZVhkMVVGNDZlSUM4eWIr?=
 =?utf-8?B?OXluWnRDMVdUUGduRnpsRFh2LzRuRm1WTjgyY0l6UXVlcFpDOEYyeTNBV2Fj?=
 =?utf-8?B?cW5oNjdKUmRVS21Fb3phT29mYXo2SjhDbUZRWndFQ25rdkpESmk5a2dIYTcr?=
 =?utf-8?B?Z00vYmQrMTU4VTc4Q1pGblhLdU9wZUxBWFhrb0tUb3RkNU9ZUThvdWJGWXlx?=
 =?utf-8?B?U0MwT2wwbnVXZjIxNXB2RlBqdEtzTFpEWEhPMGZNb0JHYjBXTFlsTmxBY1Rj?=
 =?utf-8?B?ZGpidVI2MFVjSVJaeXVEcGhoTHdBLy9TOG85c3ZFczI2THlYdm0xcUsrYWtx?=
 =?utf-8?B?ZG4vck41R3Z5NDBpeGlndStiNmNCM3NwdTh2TXJVNU5lVnRsc3Jzd21LYXgv?=
 =?utf-8?B?dkZad3p0U0pwaDl2ZE5vTHdQT2V2K1ZKdkJSbzNyUW0xSFcrcUJiUncvVmM0?=
 =?utf-8?B?eWttaVBIUHRMTXh3Vm10TXlxMi9JQmpKRzVQMitObFBZRzQ2dXlBSUNMUnA1?=
 =?utf-8?B?Mm9EcFIrU1Z3cXpQMThwR01VMWlULzVuRW0yVnZOOWh5L00vcHlNV2cwTlBn?=
 =?utf-8?B?RytVRjU4aFRwb0hDeWtnSFNvdGgwM09rTm9iY0w5djUvanFyMXZtK1g0cHpG?=
 =?utf-8?B?RkFqbWRwaGd0c0pENVlGb1RCTFR3cHBhVlhnYXlmdUhlWW8vZC82dHRDY00x?=
 =?utf-8?B?aWlpZlNnMS9neDZsQ2JWMHJKWU1CMFJLcDl4YmIyZCtmc3RCallMTE1XNzhv?=
 =?utf-8?B?WFpERzZMY3g3elFCbENlRG5wMXpkZjM3K2hvcDBXSlVma1dNOVc2aHVYM0xV?=
 =?utf-8?Q?y6pg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc51336-8ff6-43e3-7e09-08dccdb99167
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 14:46:47.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOg2KEaZs3w9a6jKEzQF6zZoNgp+iF5lhoRGkfDtySXSRe51Rfei485NJqyTlQRw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102



On 9/4/24 14:40, Bjorn Helgaas wrote:
> On Thu, Aug 22, 2024 at 03:41:11PM -0500, Wei Huang wrote:
>> Add pcie_tph_modes() to allow drivers to query the TPH modes supported
>> by an endpoint device, as reported in the TPH Requester Capability
>> register. The modes are reported as a bitmask and current supported
>> modes include:
>>
>>  - PCI_TPH_CAP_NO_ST: NO ST Mode Supported
>>  - PCI_TPH_CAP_INT_VEC: Interrupt Vector Mode Supported
>>  - PCI_TPH_CAP_DEV_SPEC: Device Specific Mode Supported
> 
>> + * pcie_tph_modes - Get the ST modes supported by device
>> + * @pdev: PCI device
>> + *
>> + * Returns a bitmask with all TPH modes supported by a device as shown in the
>> + * TPH capability register. Current supported modes include:
>> + *   PCI_TPH_CAP_NO_ST - NO ST Mode Supported
>> + *   PCI_TPH_CAP_INT_VEC - Interrupt Vector Mode Supported
>> + *   PCI_TPH_CAP_DEV_SPEC - Device Specific Mode Supported
>> + *
>> + * Return: 0 when TPH is not supported, otherwise bitmask of supported modes
>> + */
>> +int pcie_tph_modes(struct pci_dev *pdev)
>> +{
>> +	if (!pdev->tph_cap)
>> +		return 0;
>> +
>> +	return get_st_modes(pdev);
>> +}
>> +EXPORT_SYMBOL(pcie_tph_modes);
> 
> I'm not sure I see the need for pcie_tph_modes().  The new bnxt code
> looks like this:
> 
>   bnxt_request_irq
>     if (pcie_tph_modes(bp->pdev) & PCI_TPH_CAP_INT_VEC)
>       rc = pcie_enable_tph(bp->pdev, PCI_TPH_CAP_INT_VEC);
> 
> What is the advantage of this over just this?
> 
>   bnxt_request_irq
>     rc = pcie_enable_tph(bp->pdev, PCI_TPH_CAP_INT_VEC);
> 
> It seems like drivers could just ask for what they want since
> pcie_enable_tph() has to verify support for it anyway.  If that fails,
> the driver can fall back to another mode.

I can get rid of pcie_tph_modes() if unnecessary.

The design logic was that a driver can be used on various devices from
the same company. Some of these devices might not be TPH capable. So
instead of using trial-and-error (i.e. try INT_VEC ==> DEV_SPEC ==> give
up), we provide a way for the driver to query the device TPH
capabilities and pick a mode explicitly. IMO the code will be a bit cleaner.

> 
> Returning a bitmask of supported modes might be useful if the driver
> could combine them, but IIUC the modes are all mutually exclusive, so
> the driver can't request a combination of them.

In the real world cases I saw, this is true. In the spec I didn't find
that these bits are mutually exclusive though.

> 
> Bjorn

