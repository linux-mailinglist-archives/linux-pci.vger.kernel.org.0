Return-Path: <linux-pci+bounces-10746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E244293B7C3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 22:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A28B1C23C5E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 20:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F274C15D5C4;
	Wed, 24 Jul 2024 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KyeYXcF7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44177F15;
	Wed, 24 Jul 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851567; cv=fail; b=IYBR2KSdVOskOoqclQbY476vQn0iuTz9OteWJAb+sFmCWYYBuopFdQAF0sPVku0wPVPUf+PJ7xlRiHZNIQ1M18Sz0dprv2iMq0Eu8pFzcuEdbX+xW8iLcpkEG66etZpft2zqjMi2O6asdo2x1PTIqwfaR0VNIbJBHYKeir2anw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851567; c=relaxed/simple;
	bh=Atxm3GDu37WUN+3ihrzcypuD6lGaT6XA7TXJ6FV4Wjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JSfF1N/kCpRLl2Q/RLEe5fgS4g3aaHvqDlarnMfGDDvtv8F90fIvhEDZxh7HgKGCsMQvxshX6NHVhnPoD7bGhUb3otfALamuuEQfR+j4iljXFDFBv7qcNMA/JT5LO+yxj3YtxalulRMZAO6Al+r4BW4Yqw76XfwiTVVPILizGzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KyeYXcF7; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozdqKt+guYBG+eCeVjA6Y9zok2+2LUtxufDSxxKXOEa+ptU0FoNvoU7btG8N7MZ42bxe8KWQ2K0Ekjq/iOSySarcWeuJQlrWfi822Yit2ugCx6FNR4DwPUFnZaa8MCUvQA7OoDNscm3PVjDDWqQYNjeDTXkn2nxSoBML5TnRPvkHRWG4kBCTlOId1yT4t0fC+jOp+XgZGoU9YmQat1Ewvk4LyArJsW1oyIo8aNjjYddJj5h9p28D2cZRzb4ZS7cOKHunpC4Q7ihSzzkrOr5SvE+T8rdcGzX7y1vKTaItU+j5MNU1b74WPOJ4xoJqY0OMmsUwkTG2zOR2IklAsOIhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs8C7q480v5TXe6PsTsOeORmO+V1FuHFcJWvTw9Aatc=;
 b=rg++W3ZeVaUA9CR7Gehp1QNQkyBF0JAalnoNx7OFj++uRvRDrE5FvdDseIDRnsKCkTa1csbntghN2WWDN6dCq4ucdhmddqaqCwxFflyUHvpJJ9ofxb6yd4H3zEogHk3ctBWGFFpVm89tWDqUQ3K+bKPBTIvxIVVIRWewR0ZBIMIosD7U6jV9E2AR9BRiYHQJCrJ7zWnRuTAVwOW2Z/Re/dM1L7gFY/7kCOCs3tt+csGpvnclH1onebKqLJCuK0k2EVQ6KxhBKuu7AgdrjdfPMj5ByvbFeNK6R/EjaMENGwpjj7E1aA+j+j8rAtwuPlEykhQdamtr852zs795ZzcWWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs8C7q480v5TXe6PsTsOeORmO+V1FuHFcJWvTw9Aatc=;
 b=KyeYXcF7CKUQypplR3ttje+dCZo0UwNOWE6vSDmZDPVMw6Z5YqYBzCpbUrXWj2Pwl+9K2JMl8XHYOA88PKqhB6ovLAERRAwMpRxMuu9+L4ll4EF1i+E+fOx6vzcAUP+OFEeOV/C0cunNFyrlgU3rS1PpXuWKlqt7VNiQyQQS0+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Wed, 24 Jul
 2024 20:06:01 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%4]) with mapi id 15.20.7784.020; Wed, 24 Jul 2024
 20:06:01 +0000
Message-ID: <28b953c3-ef66-4bd2-a024-ec860399ffbf@amd.com>
Date: Wed, 24 Jul 2024 15:05:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 03/10] PCI/TPH: Add pci=notph to prevent use of TPH
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
 Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 bagasdotme@gmail.com, bhelgaas@google.com
References: <20240723224102.GA779599@bhelgaas>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <20240723224102.GA779599@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0042.namprd05.prod.outlook.com
 (2603:10b6:803:41::19) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7c0a14-2688-411d-6c80-08dcac1c0a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTFOdVJnRHo2dE4rK2ZXSEEzakU3ZVZrL2JJdUJZVnEyUE9xM1NMdDlNNWRN?=
 =?utf-8?B?UmVtT1ZGc2JVUWFjdC9remhxVlFtQnJlSFVaM292Y0pTWEs0VEJKdjJ3V1Zh?=
 =?utf-8?B?RG9YK3lIZU9ZMTMrd3lmbG1SNVNVaDhocDNtRlhadGVoQkxCUC9sb3dlbzRE?=
 =?utf-8?B?QkhBQWJUK2ZDOW5LakVNcGNSVUV5S1d6Z2NRK3FYdDYrdkhXTEhaTzhNNjlT?=
 =?utf-8?B?a3FVK2swWDcwdjM0S3N2OS9oNVNHanFsSVczaHd6WitrWTdrdHhHc3IvTDlV?=
 =?utf-8?B?K2ZzSjc5ZS8zTm9VdVo4VXNUZG8vUzVDd3B1VzFuQmMzNkUvQzJ0VkdlZEJH?=
 =?utf-8?B?RXFjQTBTK0Nqc0QvUzNzSnBzYkkzTGNpWjJpYUREWkxVUW82MUFZMVlaamly?=
 =?utf-8?B?ZGVUV1dsTElZSzlHeE9Ed2d0UUNUY0pyak9SWFRvUDlreUs2OUp1N3lBWFk5?=
 =?utf-8?B?Umx0MHVHUmszWTAwbFhHMkIzZkZoM2tYZHFoRy9GajJ4UlVaem9DOWF5VTJM?=
 =?utf-8?B?SmRadGRFZkxqN2xFMmhCVEVZbGxpT2NaazEyc1psSTBvK2hCZEtzemE0T0lE?=
 =?utf-8?B?MVFpSUpXcWs4ZVh5NHlBNXoxcmptZUpjMlVDMGVwZ1I3ckk5N1lINzJ6OFly?=
 =?utf-8?B?L2pkbjZQWFlnbThEZXkyRy90VktPa1psOCs1L1MvQURsbitwVVRURjdLVytx?=
 =?utf-8?B?NXBFVFkrYVVBUG5HVFJ0dktGSU5FSWVmWEp1ajIwSzBIaG1Ud25YTXh0MzAy?=
 =?utf-8?B?Y2ZDRkhHSGtSUDJJeU4vemZpb2IycG9oZk4zbk1EUGNQWVRTN2d1QzRZWlFz?=
 =?utf-8?B?eEtnOTlkdnJTb2MzM1dXM3FpMnNHVVQvSUNyR2RNNXdlcndZeGFRTGlaN29V?=
 =?utf-8?B?ZWRzcW9ONTBVSGx6djM1bzAvWmZUdEFpRWFxSjI4U295c01qNnVuWVA2Z1pH?=
 =?utf-8?B?V1BUT1IyN09jZWRtRmNjOHI1aEU2dzR1Nkw2amNLZUdxaGpUVVFPZjQ4a1V6?=
 =?utf-8?B?ZHRaQy9mSlRuMjJWbFZKMlJzY29aeitsZ3FFVWYxT2FCMVdOZFF6R0V3UUVi?=
 =?utf-8?B?U2VJOGZtNW91RTBCZzhuN254MDUvaUxNYWVURFZzcU5JVTAwT2RpTjdUT1Qw?=
 =?utf-8?B?MVQ5L3ZiMXV6c1lCSTA2TGpQU1pBUSttaDJFNVlzN1BNTXplZWlEb0xLOFZw?=
 =?utf-8?B?blJKMFhUR05FMFdpWWZFQjljS1AzL3JJN055aStuZG1ScWNsNDZIMHR4M29D?=
 =?utf-8?B?MFRGTGJ5S2dmUXhqYjBML2lhTEhzQ2gyRnRhQkNtNW9GMWliY0gyeXVnSG5Y?=
 =?utf-8?B?TmVFVFNwOFZFK0krWVNkcXREYzExdHZTeTQ3MzBzbk5acnJ3bUQ4dHJnbFo4?=
 =?utf-8?B?b0hzcTUwZEVLR3AyNkEwYUxNUFJjSG5nWVk4K1lWWWRjM2RnVVpUWHo1OXJ5?=
 =?utf-8?B?Y2ZnL1pSRm90OWpBZG94Tko4VGhnZGIvdHcyampRZjJiMTJrVFQ5bFFuTXBD?=
 =?utf-8?B?RTdxbzhSZEp3ZmhCWURPcVlXU3VKb1Q1T1hmZk5RL1drT3JCaDJhRFZXSmVm?=
 =?utf-8?B?eEdlZnc2T3ZNSFg5cGJVRjJON29CMGJ4RWFxNW9FOWJGaW9yazRmaGorRytZ?=
 =?utf-8?B?OGZ3STh2eWZBL2hzWmkvOUJ5NVp4QjJlbGZGeTJBaU96OElCT1Q5dGpIVnhl?=
 =?utf-8?B?MmlvRzJwRFQ0MmdyakZPK0JaUk9GRjA4MXNTUTRPN09Ob2ZoK3lMN3hNY2Jo?=
 =?utf-8?B?aFQ3Rm1IcjYwT2IwSVd1S0RsbmhuUTQxbUY5NnVTNUpkU2I0b2o1UjUvbE9R?=
 =?utf-8?B?Uy9KV1FXVkczTFUvYkxlUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjJ3WkxKZjB5SnBMWTE5NWhlbUxVSVR5TFVMQTZzQmgwbTVRdWp3K0pkTjlt?=
 =?utf-8?B?RE5OcnE4M0NDYXczMEkzcnd1NUtxcEVyTnB5UTZUL0c1cEZEVTdqR3pvK0lH?=
 =?utf-8?B?c005SEtUQUxSajNBTDFzZ3RvQ0wyV2JNS2Y2U0srYy9XNGxtS1ZJNmVnMnNE?=
 =?utf-8?B?aE5najdLejRrbDdCbUN2blQrRnorZ3EvRDQwUnN0eDRJaTd5azNYa0d4elRO?=
 =?utf-8?B?ZnhmUzA4VWRiMDZUQnAzUnlqQnFpdXZaSnRSNFJWL1J5L0Yyb3d5aXRjZ0hJ?=
 =?utf-8?B?TmpyUThTN1ZpNngrY3hENk1KRlpIcmM0ZDZJOVNEekVLRmIwYW0xSWU1NlRK?=
 =?utf-8?B?bTE0ZE9tb1d2KzJZVVZCS05vOVM0YXJmTzFod2g1YllIUVV5T1ZOa1dRUWdJ?=
 =?utf-8?B?MEhSWmtWdTZ2MUIxb2ZkVGVMV0Z6bUFTVzlXU0RFYzNtUmM5VUpiQy9rOUpX?=
 =?utf-8?B?OGl3NWJJTXZwT2RpNG93bmIweFY2TlpNOHNmaDRRZFZHN3R2V01FemQyM1Bm?=
 =?utf-8?B?alArTFlkaldDcmFCd0s4YlBMTk5YOEZ4ejlrNVUxbERIajA5WTJHTk80Z3Vh?=
 =?utf-8?B?S2YwYUNlTGVmbWNyNTZzaGZSb1lNd2RCWUdHSmNkZ0wvbm0yVzBxYTdRK0l1?=
 =?utf-8?B?dnNvcWRycmNWbDBWSzBMUmZPanNoRmM5ZUFKcmVhYlp4cXhkWGtYMFpqSVdk?=
 =?utf-8?B?aWNmcGZmRWRDWEdweUtBM0g4ZnEwYUxMcnMvcFB1RFluNzFiTDRqZlNUV3dh?=
 =?utf-8?B?MXhIK09DeTAvWWVPQ0VZc2ZxbGVQU0laKzhoVmRoNFVSZWlsQlg0MFRLUE5X?=
 =?utf-8?B?WUlhcE1RNmJKZDFnNmQ0aVlmZWhieEhGSlEvTFFBbUhLazJVam0vM25nK0tN?=
 =?utf-8?B?Vmd0b1B4L3hXMEFQOENncDFuZmpucFdqcjZoYTRJak5vQ1lZbzA2OFRSQ1Bp?=
 =?utf-8?B?b0dGclVvTWplMG5weVBFelpqNEo1WWIxU1VmdDNjK0U2R2VmL2JNNDREZUpz?=
 =?utf-8?B?K0dKNkttNi91ZWVRM0kyV0c2MksyZ2VBRG1UbitYajd5RjFzb2R6VDl3N2Ur?=
 =?utf-8?B?R2hIS1d6RVY4VDFLTDRscGtNa3VwSFJrSlEwZHZFMmZXZmlpUm1VcFBSY0J6?=
 =?utf-8?B?TW0yZXgvWS9RMU1PTTFlVzB5SE9SUFRZdGZuZzZLRjJPVENoMktPSUlEeHZ4?=
 =?utf-8?B?dlNOM2Y5WWtnUDJWUzVsMTZoam9rZ056eC8xa2FDc2c1eStnelY4bHRvTFdX?=
 =?utf-8?B?RXVTOWxESzhCcUZkZWdlZ2NiQWtRa1VualVFeG1WNmhBbW5LQlJsMVdEYVIx?=
 =?utf-8?B?MldUNCtRL2czRTdUWUx1T05QVlQwSkJuK0lMcmc5VS85dzN6VVMyVWJsczR1?=
 =?utf-8?B?WjFRTkcwZzhKNHh6L1V3bjdwbXUyRlVIeHlNaHZRUmlsVElWd2Fra2xnKy9h?=
 =?utf-8?B?cENXWUI3S3pPMXlIUHJlN2MwMmhKSGlDZnBLbU9nYXE2SVkxN0EycWZTU2Rz?=
 =?utf-8?B?cjJRZzVKYmlXeDlBM25oblBpc2F1Nk5uMiszb0hGcEtsWUJSeEpKUlFFY24w?=
 =?utf-8?B?NWJuM1RrWnlIR29zMGJRbmZxU1pIZExkYVFSK1kxNmp4RzB0NTVOV3A5NnlL?=
 =?utf-8?B?Z2xhY1NTbkNPSFU2RzAzWjNLRnFwQzJJZGp2YXZVREpHRFNIMHJqQndZSmd6?=
 =?utf-8?B?Ri9scGpTNU83M1hWOEpWMFNjQkR5a3FQVnJyS3NRT2JqNm54ZmZkL29CcXpr?=
 =?utf-8?B?OWovNURpVWhjQXlmUXRPUmF6aHErLys5ZDlKV3AyNERtb1dFVm9sdzh4V2NS?=
 =?utf-8?B?NVM5V0VORWhKdjJDRU04ZWVudE9lN2NicXpGWHA0K2llL1NQU0pyK2YwOE4z?=
 =?utf-8?B?MndVQmpaVlpCK2o3WFBOM3l1ZHpCSXpsRzhmVFp3alpuTGs2Z0FFMXliYmxi?=
 =?utf-8?B?dTdLUzRoMld4bEFicXBMMjFreUNCaG1qeFA2N2ZteWhYNDJ2NU1mSXVOS05B?=
 =?utf-8?B?dS96eTVwbzBhVkxzTVFpaVZzQmhoUVBNczZEZzB1Ylh2RnVmNitwYlZsd1Q0?=
 =?utf-8?B?aHRQQWlWM0JsTXlzNEVXM1M1cnNOR0xTdUhQUDFCdjZRaXlhbU1WMWI1YzFE?=
 =?utf-8?Q?x2zU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7c0a14-2688-411d-6c80-08dcac1c0a6b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 20:06:01.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VZBTFra6Ey1egPfQU9hh9QgDl4hNYqyuoXb71wxrld14ubE7vdPVB+eIilRnJZ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440



On 7/23/24 17:41, Bjorn Helgaas wrote:
> On Wed, Jul 17, 2024 at 03:55:04PM -0500, Wei Huang wrote:
>> TLP headers with incorrect steering tags (e.g. caused by buggy driver)
>> can potentially cause issues when the system hardware consumes the tags.
> 
> Hmm.  What kind of issues?  Crash?  Data corruption?  Poor
> performance?

Not crash or functionality errors. Usually it is QoS related because of
resource competition. AMD has

> 
>> Provide a kernel option, with related helper functions, to completely
>> prevent TPH from being enabled.
> 
> Also would be nice to have a hint about the difference between "notph"
> and "nostmode".  Maybe that goes in the "nostmode" patch?  I'm not
> super clear on all the differences here.

I can combine them. Here is the combination and it meaning based on TPH
Control Register values:

Requestor Enable | ST Mode | Meaning
---------------------------------------------------------------
00               | xx      | TPH disabled (i.e. notph)
01               | 00      | TPH enabled, NO ST Mode (i.e. nostmode)
01 or 11         | 01      | Interrupt Vector mode
01 or 11         | 10      | Device specific mode

If you have any other thoughts on how to approach these modes, please
let me know.




> 
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4655,6 +4655,7 @@
>>  		nomio		[S390] Do not use MIO instructions.
>>  		norid		[S390] ignore the RID field and force use of
>>  				one PCI domain per PCI function
>> +		notph		[PCIE] Do not use PCIe TPH
> 
> Expand acronym here since there's no helpful context.  Can also
> include "(TPH)" if that's useful.
> 
>> @@ -322,8 +323,12 @@ static long local_pci_probe(void *_ddi)
>>  	pm_runtime_get_sync(dev);
>>  	pci_dev->driver = pci_drv;
>>  	rc = pci_drv->probe(pci_dev, ddi->id);
>> -	if (!rc)
>> +	if (!rc) {
>> +		if (pci_tph_disabled())
>> +			pcie_tph_disable(pci_dev);
> 
> I'm not really a fan of cluttering probe() like this.  Can't we
> disable it in pcie_tph_init() so all devices start off with TPH
> disabled, and then check pci_tph_disabled() in whatever interface
> drivers use to enable TPH?
> 
>> +bool pci_tph_disabled(void)
>> +{
>> +	return pcie_tph_disabled;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_tph_disabled);
> 
> Other related interfaces use "pcie" prefix; I think this should match.
> 
> Do drivers need this?  Would be nice not to export it unless they do.
> 
> Bjorn

