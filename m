Return-Path: <linux-pci+bounces-15240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB5D9AF358
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 22:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E430284560
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645F6198826;
	Thu, 24 Oct 2024 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xo9g+mRd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8B22B67B;
	Thu, 24 Oct 2024 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800538; cv=fail; b=laziMziXKZRtwWukcy5w6Q2MpTl1Jvft/DR8WBLyFmfN97l33H4rpmALq22E+Z58xx4h6uCPxANX0/3jkeKIqWoVLKovYdGLa8TVpxpMBGIsAERvT0aaxpq23bcQ3brLdMum75udKzsJEPeVtKU+muitc77vr9cVsyX5rdwzbck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800538; c=relaxed/simple;
	bh=/EUsk15GcHaUMLl8uCRkJEUzm55VP1275HmqFiIDNN4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mLH06ju06RmE/M8r/F478uc0GCCIunlRqD6faHYTg3xR9+ORpKoqzXKIJnPY0aWklRWImp/9bRgdRq/Bmdg097fBfFXOgGShbFQNT+Ge3+PK/ULw2c1ezeruiO7rNPNvUUZRT9t4ae1Y5hY+7Dqo/5Fv/lzbe6U3eJkY5N3hcu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xo9g+mRd; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KS/fU6IPEfA6y6VqFoWOGfvyt/V3LteOc9WvynyhpjyhK7wKGGYCfUAGGKAYRqSQnH6OedIgpRlhox7KYQ357Gc1pfZH1JpuSyu6LAhhaL9VtkawnP0VlZm4A3eNzORxc6tZQA7eUhvO7HuXTXQa21uQ7EzSBDyRTEoDEn7JulGFOD0tezTQm6u30he76Czj2D4ZS8D1LOWJc2xL6a1Dd+Jv0MEUEs9H0Tdj5b9IvK11CLjPpLdKaS5jdf5EQ24TDjot4AYE+0H0mg7yxNx3uq350CBY1ji/69d2EH6R9CUu+rrZvGmUjFf67JRs8NC3qwHIUVYIvBxpSJMDKaa3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKYD/nmRi4Rykrr6F2T6AnFvAC7J1oyOuqVkyFIWPEg=;
 b=vqGxqmYtd6F2MhVosqLv3j2TykujGIg6QacL2Mg9Sokf0+Onom+4+N4y80h2jujb97Z3o4lxV3UMwncTMLLwSw0dyh6k1n+Pk9GUzaOM2g4zOjcmvGNgfIZoqYfBP+b8eOY4nZ59Yiz+wRPCPoPHYu7l0Oaupu2Mth6Ip18CMTzhqtjA+hgTsKsqVtywtOYxbJG5/JkK2jJhmAK57Ex/iyAievBLoOy8Wh32Kd+7HexxxgYipU/kzD5rl0OXwnjhDIa5NAJjEzUhXSkslzCVAllxOLoaVRCFMj1map5niWHsbzrxsRHi9lbvqa0XDmmNhAapZaaRWn5JB1lsMmTAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKYD/nmRi4Rykrr6F2T6AnFvAC7J1oyOuqVkyFIWPEg=;
 b=Xo9g+mRdja7tm9xBHcQfK7DSQkthL++2BwwylHE7a92D6PoBBw9A+MteQ7fR7p45hX+S6U3Gj3AxFOiADYcMOnTkqqKQB6ywkQ8FrmIRfSqtuLgeQzXGd5ItxrYW6YXYniNKBGZh/2cUhf0kHRNiR5IUuOWaF4MEgPcqFdacgRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Thu, 24 Oct
 2024 20:08:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 20:08:44 +0000
Message-ID: <79cb3a45-8f42-4ef8-9c21-acaae5fbbe04@amd.com>
Date: Thu, 24 Oct 2024 15:08:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] AMD NB and SMN rework
To: Bjorn Helgaas <helgaas@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
 john.allen@amd.com, bhelgaas@google.com, Shyam-sundar.S-k@amd.com,
 richard.gong@amd.com, jdelvare@suse.com, linux@roeck-us.net,
 clemens@ladisch.de, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, naveenkrishna.chatradhi@amd.com,
 carlos.bilbao.osdev@gmail.com
References: <20241024174647.GA964607@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241024174647.GA964607@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0078.namprd12.prod.outlook.com
 (2603:10b6:802:20::49) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f75cdb-2c28-4273-f405-08dcf467a99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHg5U2RJVkIvb2hjaUFpNHFHd0tNbXdkUnMyK2VSalkzbUVVVS9aNm5ld1JG?=
 =?utf-8?B?WlpEdEVUb2dpRHVkRk9ISEYyNmh1YTRNZXFBUEtKSG4reHk1d0tCdU9HbzhW?=
 =?utf-8?B?MGdCNkdaaDlJcnl4TlVUTkc4WW4rMFM3Y05RS3Q5em1SRDVHbGJEY256ZWJH?=
 =?utf-8?B?Y1M1dHdybVU1QkRXTkd6MVhCdzRwWFp2eG56a3NMN2svRlRac2dFbUlQWSt6?=
 =?utf-8?B?cXVhOXQzUm9PYlNlMXBzcFdqM0VndzhTMEdKVG1KLzRpQUY4UUhWY1h2aHJy?=
 =?utf-8?B?ejRvM212T0FVVjNkQkg5blQ5M0JRQS9JeXlIZXlQRm12YllTTjdkaU5pWjl5?=
 =?utf-8?B?ejFHKzExLzlvazRCUXBrcHBiS3ZsYm9sOVE4ekRtczNsb21aWkNFSGIrWDlK?=
 =?utf-8?B?ZnhOb0lhdGNyVGxvcktCNVlpU0piNXM1R1Q3amRNb2daTmJMRzQyVGFCZXFp?=
 =?utf-8?B?bzBuVTk4bWc3enhMOHl6U0hncE1MRmpIYXZzdGJSQjJaKzcyU3hYZ3JBSWxV?=
 =?utf-8?B?T2x4ZWhPQzZXSzhsY0dnTWJkR0hsUG91dDlVdEw2cVJzZG5TUVlXYmZEcjJ4?=
 =?utf-8?B?N3lQMlhEcG1pWjBpN1kvVnFtYzVtaFJBYTgyd3NJOW91QmdYVzhZc0kxeWRT?=
 =?utf-8?B?WGZIclBucDc4RkllVFAxdTVlOEJXdzQvUEQ5REZ4RUgrcVBrWEV3WTFIL2xk?=
 =?utf-8?B?NlJEbGsydGRZNyt3Z1NlaDlNb012T2UwODREa0Z4Qlgxbm41UHVsUHg5dG1I?=
 =?utf-8?B?NGFpWDJIU29Gam5PMmozYVhRR0xxK2pFUDFma0FUUzR0QmszYW1CNVVFZGx0?=
 =?utf-8?B?RUphN0RtL1B0SURmSmRoMEUzTzhBOS8vbS90S01pSVIweUJ3RnR3Rlh4ditL?=
 =?utf-8?B?dUtGaFlCdVpIMHFuNEQrNnNwcjMwbEZPcmZFajAybmhMajkwVmV3aE9KVGFs?=
 =?utf-8?B?anpzSlppUk9JbTZIc2xxVDJobWVYWks2RHlpd0F5cGtXV2plR3p0Z2RUaXY0?=
 =?utf-8?B?QU1ZUHJwdCs0bVVWdUp1eDl4Zjcvb1g3OGM2WXZUVDRzb1VBbjltODNacXMy?=
 =?utf-8?B?NWdISDdWZGFqZy9PSWFOTVh0NTI0M1VhWTg4K2xyZi9UT0tsQ2RFWk1hTjB2?=
 =?utf-8?B?SE1ia0Y2UlJJcGJCKzZOMklHOE5Tc2dxeXFsU3dEdzE1bXlyZkNockRpeUN1?=
 =?utf-8?B?RjR3amF2NTgzV2NxMnRGM1g5UndnTlFNY0Mvdi9HUkZWZDBsUEd5YUIyaWFP?=
 =?utf-8?B?VjRkQlIzQkp1Y0NZbWtJU2NoNzJSVjU1ZkFHMmlFcmUxR05ja0FFQUU5NVNB?=
 =?utf-8?B?UmVLaWhvdWxkRmRsVXZSV0NkMmQycFh2YjFiTTM0ZmowTlpqaVJGT1diVjU1?=
 =?utf-8?B?bnUxSFN3aWI5QkhTbUV1UWlOMDM2WW03bXNjK0p3Q2x0UFhrNVQvRGEyaEtH?=
 =?utf-8?B?R3huS0JHb01ETWdpK0ZRU0dRcTRiQS84RThGY1kwbmtLdmg1eDlOTFFjaE9s?=
 =?utf-8?B?cG1DeTdZempQNzcrUGsvOUJ1MFlPK2NBRDE4UG5jU05sOXowS0IzbTdFWk03?=
 =?utf-8?B?cEJISGxJajhQa29GRHVobWlhODZPRkpVLzg5MjErcU5xU0tIaVJ5U202Ym9T?=
 =?utf-8?B?Zi9wYlBjcVkrTnN6Tm9sNS9mYXdBeUxZZnAxeTZDQ3FDN3ZGYjF5UjNiWitv?=
 =?utf-8?B?UUNVVE9xdllzT2tFdEw4bENvTTJaMmZtTHZMdDFuUFBUZ0hreWNtRE1tUVQ3?=
 =?utf-8?Q?BCHsW7xGTDpdIw5gv4vVTpJNrkXg1D47EHc4jQ0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3laRy9Jci9EWGlRbk1MOGV3WkxEemliM2d1a1JCS01lbGpSRWRwdUN5a1ly?=
 =?utf-8?B?aUFEYU1tOHkxeXdOR1NaOEdYU0xhdko1UkZiSDhWNTBUYjQwUXN0MzJrUUpM?=
 =?utf-8?B?SjJ3OVVmNXZVYVVFUjZHeXhlSm50bEtwR2dvdWhFVkFQT3B2aXBySlc2R3lp?=
 =?utf-8?B?Tk15STRrYThmR3hHOHdhUmhDRC9pYWZRSE8zdFhFUk5NQnRGM2ZZaEdOVUp4?=
 =?utf-8?B?ZEV4MkdIdmV4NVFPNkVSTGxvcXpHVXBEZWE4dlBZWGhZSE5BcGlOZ3AzVUZj?=
 =?utf-8?B?bytVQ3hwTTZ3d2VHV2o2eXNWbkluNitoRDRrN2JKWFdVRmU5UVVGN3htMDcx?=
 =?utf-8?B?STlHSm5VSlQ1Q2sydkpFUkNZb2IrSTBYbW91OFlGSXBtdmY2b1NTMkh5ZmZt?=
 =?utf-8?B?cS9rcVZ5dENuZnhtc0ozZzQ0djcwY2FlT1cyTzFpMXNxTDZSNWxiMFBaWU9U?=
 =?utf-8?B?Zlp4andEMnV4QncyMjJ0ZVB6ZFBBemFTQUNEeTJVZFNxRXZzQnEvYUdtTXEx?=
 =?utf-8?B?U1R6clIvbmdaYTRTd3NVWVd0ekJ6elMwU2lYMjNpOXh1V1hvdFJYYWRuMzRq?=
 =?utf-8?B?RkZIZmdsUWhFS1l6S3NmU2VQK1FmYks0YTBrdTJOYSswUngzSHpqMTBBQUVw?=
 =?utf-8?B?SWFaSjE4SHRURlNCYWFyaFB6MmJHaU9td0I5NDdLVUZlTmgrNE5ZM0F3VUZY?=
 =?utf-8?B?NWpaQUN3d0xtdDlSam1zN2Z4Ym11Y0tQMW1veVpUL082c3Nzak5pbGg3MjlN?=
 =?utf-8?B?dm5scHdJQWdreUpjdW9rcklHcGFZcXQxeCtOL0Q3cS9SdXo1R2IrQUNMaGZn?=
 =?utf-8?B?dlZXZXp4aGNvZ2lwRzRveHAwZ21rL1lqVUNCVGlFVTcrVXpiV2JEK0FpMDAw?=
 =?utf-8?B?cE5hZHA0dExVT0ZzMFlNSmpBVXpGZ244VEN0a01oRFdkZ0ErZXQwcFZ3U3pP?=
 =?utf-8?B?WkxWVUprN3FYUjlzUlZxOXhIbVdrbzlMazhDWGo2Z2NNa0NpYVdvck0ydE0z?=
 =?utf-8?B?OXRpU2JKWGdZZGNrUFcyc29aSVZMZW5mdk4xYUwzRGNMeXMrcTk5Vzk1cHVr?=
 =?utf-8?B?RUF6WCtkSnhMQnhXazZZdlBGOHA1MGF1ZkZxRGtnOXVnckdwOXkxWE81Y25i?=
 =?utf-8?B?ditZc0Y2VFRwdHIzV0tzR0VLdWFjM0hzSHdKUVBzUW9udlVndFQzZnhFY0xX?=
 =?utf-8?B?QmRTOStDRzNYZEJrU09PVURJeDN5OUNvNzFjTFcrc3VmREVzRHh2MWV2VkZ4?=
 =?utf-8?B?YVJtbi9mZk9rREFmWitXeVlFc3EvNEw1cEJDQ0I3a1lGdUVIUzM3WnNLNFE4?=
 =?utf-8?B?VjFLUUJ2Q0NHdVhhemU0cVhETDRUM0ZILzRXdU55d1k1OXRGMTFiZEpmZSta?=
 =?utf-8?B?RndGODVOd1lwODA4aWFCUVU1N3JtNy9PL3E0ZXZ1TmU1SlUwT0dyYjh2Z0Zp?=
 =?utf-8?B?SFlLcC9pcEpLQ0ZlMGdaTDQ5WTB3R3hqUW1OTisvVm54RTdNNlpoeWYzWHNE?=
 =?utf-8?B?NHRiL2VEVHVsVG55RDBqdmFFRTBPNVlGaFA3SXJpdERnMDVTRmplU2FaZjFB?=
 =?utf-8?B?Y0VMNEE2dElYaVVzQlFuYWhIWGR1QSt2Ym8zZFJRTWJROUZLQ0xoVmlaQUtx?=
 =?utf-8?B?dXcvUHR0bG5LUXZxcmNpT1NXNnd6ZlQ2eHFyQmIzd0Uvc1Rha3g5T2piVnhM?=
 =?utf-8?B?eDF4NjJ6VzFzRTVvaWsxT2dEbVNyZXNFUklvRGUzeVBqNkZ4dXpFSUViZEFi?=
 =?utf-8?B?Q2FMYkoxVFpKem1OZVJRSWdCZmpqTlJ5T2YvblJMa0VGTTdadTdTVFMzN3lZ?=
 =?utf-8?B?emdNZ1VuTnBkeUZjdldyRDE0M2ZVbnN0T1pxc0VqU1JsQTFjekYxRXdCd0Rx?=
 =?utf-8?B?VkpybHlOS0xTWmJEOFRYbFFYY0ZGdkx0U0VPbCtSblc1QSsxNW55UzJ0SGxn?=
 =?utf-8?B?WHFGejA4S0hoS2pZNVRDVGs5c1ZjbzU3RUZFN1hndkptenFGSURJWTVnZmFy?=
 =?utf-8?B?ZHFQZUpWazQzMFZKZU4xTjlzRGg1dVV6MkFYWDU1K1VtUUNqWjNKUTZQdVB5?=
 =?utf-8?B?TkhuODduY2p5Z3k1V0MvNHcxV25KN3BQNnEyZEtCNmgzYlhQVWpETG8rSUhE?=
 =?utf-8?Q?+xIHmtCa2yAfeyTn1Kv5qKXcW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f75cdb-2c28-4273-f405-08dcf467a99b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 20:08:44.5903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atqHg20Bu8Fa6JcaqMV4xVa0IinkU/0H+iJV0NpfhSjw7+uPoDSLDNh+/Usa1PfJ9xhzlM3scl4sAJ4pjVgixw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486

On 10/24/2024 12:46, Bjorn Helgaas wrote:
> On Thu, Oct 24, 2024 at 12:01:59PM -0400, Yazen Ghannam wrote:
>> On Wed, Oct 23, 2024 at 12:59:28PM -0500, Bjorn Helgaas wrote:
>>> On Wed, Oct 23, 2024 at 05:21:34PM +0000, Yazen Ghannam wrote:
>>>> Hi all,
>>>>
>>>> The theme of this set is decoupling the "AMD node" concept from the
>>>> legacy northbridge support.
>>>>
>>>> Additionally, AMD System Management Network (SMN) access code is
>>>> decoupled and expanded too.
>>>>
>>>> Patches 1-3 begin reducing the scope of AMD_NB.
>>>>
>>>> Patches 4-9 begin moving generic AMD node support out of AMD_NB.
>>>>
>>>> Patches 10-13 move SMN support out of AMD_NB and do some refactoring.
>>>>
>>>> Patch 14 has HSMP reuse SMN functionality.
>>>>
>>>> Patches 15-16 address userspace access to SMN.
>>>>
>>>> I say "begin" above because there is more to do here. Ultimately, AMD_NB
>>>> should only be needed for code used on legacy systems with northbridges.
>>>> Also, any and all SMN users in the kernel need to be updated to use the
>>>> central SMN code. Local solutions should be avoided.
>>>
>>> Glad to see many of the PCI device IDs going away; thanks for working
>>> on that!
>>>
>>> The use of pci_get_slot() and pci_get_domain_bus_and_slot() is not
>>> ideal since all those pci_get_*() interfaces are kind of ugly in my
>>> opinion, and using them means we have to encode topology details in
>>> the kernel.  But this still seems like a big improvement.
>>
>> Thanks for the feedback. Hopefully, we'll come to some improved
>> solution. :)
>>
>> Can you please elaborate on your concern? Is it about saying "thing X is
>> always at SBDF A:B:C.D" or something else?
> 
> "Thing X is always at SBDF A:B:C.D" is one big reason.  "A:B:C.D" says
> nothing about the actual functionality of the device.  A PCI
> Vendor/Device ID or a PNP ID identifies the device programming model
> independent of its geographical location.  Inferring the functionality
> and programming model from the location is a maintenance issue because
> hardware may change the address.
> 
> PCI bus numbers are under software control, so in general it's not
> safe to rely on them, although in this case these devices are probably
> on root buses where the bus number is either fixed or determined by
> BIOS configuration of the host bridge.
> 
> I don't like the pci_get_*() functions because they break the driver
> model.  The usual .probe() model binds a device to a driver, which
> essentially means the driver owns the device and its resources, and
> the driver and doesn't have to worry about other code interfering.

Are you suggesting that perhaps we should be introducing amd_smn (patch 
10) as a PCI driver that binds "to the root device" instead?

If we made this change, I would wonder if it comes up early enough, 
particularly considering quirk_clear_strap_no_soft_reset_dev2_f0() uses 
the SMN symbols as PCI fixup final which happens before a driver 
attaches (pci_bus_add_device()).

There are some areas that do discovery (for example amd_node_get_root() 
in patch 6/16).

I think we should aspire to do is much discovery as possible but I don't 
know we can get TOTALLY away from some hardcoded topology information.

> 
> Unlike pci_get_*(), the .probe()/.remove() model automatically handles
> hotplug without extra things like notifiers in the driver.  Hotplug
> may not be an issue in this particular case, but it requires specific
> platform knowledge to be sure.  Some platforms do support CPU and PCI
> host bridge hotplug.
> 

Yeah hotplug won't matter for these.

> Thanks again for doing all this work.  It's a huge improvement
> already!


