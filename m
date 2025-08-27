Return-Path: <linux-pci+bounces-34867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B973B379A1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 07:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9416E7A2AA1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB4C2BE05B;
	Wed, 27 Aug 2025 05:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tBMDt87m"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BD27815F
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 05:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270946; cv=fail; b=AdJNGjP74d56cpbSXKo60eQ0JAPdxoAY9E+1exww+8WTQjX/Rflg7S8oFc23qIiIi7o6/DI7/dAHrFiaS5CpPtWZOjmARcavd3sj5sd4rs6KkoSBHI178hkEV043hXfIyC81qVPS+qPsDc2jzaniVw4/Np+ikxe0oqUrSk2t59g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270946; c=relaxed/simple;
	bh=+FwOZQJs3ou9dPkkQgEpqXgPQCx1qjl+j5ir8OsbZH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qKLkjBDto7leQY8TLZpRn5t+QbycCqQ8h1gb2r/53gZSjuYSOmmfXsBFtRmuZ9bUWSrzXOVPUICx9RSZEw46ACg1axonCfUgmA2ffG4A8xBm8Qi/8rtzGo4Qpr3S4LUC4cpHv5eGpWZ6WDEcYyC/JJCvJ2T+W3UBPt5O2tM6egs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tBMDt87m; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy58XoyBMQO948W4INTzagw7doJ0nc1o9qAKaPV4vH5Xx5vkz+89yalRb2VRCH8Wr3q0tBU72okXW3dxwJo/p4CeiO9jKZBLK0h43LRwn4jrduWkdHIK+9284SZOenYATgrakm4Dwj4Ys40pztGEJEmmaD6dk0sA7HTzPH0AdzDenWRwvhbNoZZbhuj3g/xAQYsZkwxhfYmnt5qs5Ot+ML5S2AqEErBkqHNc6RfR2b4Q6m+xDOtB/qNl0U9OaTMTuHO4HJEh5yGo9Y8VOhTaVkR280BejkGdJEuCCytQ2bZOH3wGzgWzrSTduWpLczl++8l+faNbXvUSOlYNWxeatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbF0zTrWnBQYbr1vkAe8nz5gKdiIPNCQxwUc+6L8OBo=;
 b=d+Md06jRMxtcuNJVYRTzJx4gKHQ3NiYKkxF+qYjlumfCXeIIzOvPdTPkgIPueJbDUK6kDUsRk5mUfw6uXH7GmHAzz4NaBxRiWRiHA2hyk8WHOkIIBsJNflic27eu2TJnRmvqwofxOu/jGah5WM+nBASbOwiITn1iCBWLaXtVFuuByESFmG8U3hHSW2S7zMTwuCDNEl30CRUmVsZVmwKKbw2UamhsbswkZPbt831IuheLbt5LiSah3gA2HyEtcgaRlqRiAYlF4847GI6QscWmyVQtuUf+N2ep8X3uQd0jRHr3jYARwOiyyoyAVFMGZCcIa1eadsktslIjc0StqDDftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbF0zTrWnBQYbr1vkAe8nz5gKdiIPNCQxwUc+6L8OBo=;
 b=tBMDt87mV3+Tfwt2b2fZ6ccuEIeImF10l00PLnzFQvsgYUXA/S+iDM/CCStMxBPjBPu7EWY6BpLTAogagaArVUX1H+RZo5A4opou4pYfE4uGSLyB9RFxgUFZxSXgc1P48EK2V8z2ohdlklZSkgbPIUDkCauxqNnpUoIcGo1VGKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 05:02:23 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9052.021; Wed, 27 Aug 2025
 05:02:23 +0000
Message-ID: <d7ac4a49-da6f-4b84-8982-d181a76d65c1@amd.com>
Date: Wed, 27 Aug 2025 15:02:16 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com,
 Bjorn Helgaas <bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
 <80d568a9-f9a7-49b2-ac46-f3b4879c5066@amd.com>
 <68ae4e29d23b1_75db1006@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68ae4e29d23b1_75db1006@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0126.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::19) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: edd25dbc-1dc1-42f6-7d8c-08dde526e878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEdIVjd6UUVQRTA0em9UUVo1Qzk5d2UrNG5YV1pFdEdkTUY0S3dKNzlxRDcr?=
 =?utf-8?B?amkyT0RiaEduNzZzNDlzK3h6NE9nYXo3Z2RLeG04RGRmaWpPMHN2Ny9vdEh2?=
 =?utf-8?B?N0ZydmhSbUhjaFljQ2dHajdEd25HTE5wcHA2dW15cElQWjkrOHh2b1RJdWU3?=
 =?utf-8?B?bWxaMTRmL1lhdVkyMlEyQlMzbWNVSDZHdXBiNitSYjUrcmZDUWVhZE1zZnN2?=
 =?utf-8?B?UDNZSUErS2o2TFdZaVp5dk5nbGd4TnZwUVlpZCtObnJPYS90WG1xRDM5aDg5?=
 =?utf-8?B?ellHWkl4TzZnUlZDK280WExtWHQxQlp4L3dXNFJMMjloZzVuVkF1YkxHUy8z?=
 =?utf-8?B?M3UxYVRPam4xZXpUMjRjRVphWkw0UW5laXIvT1FXMXdRWGNUazdlWEpaYlI4?=
 =?utf-8?B?dkk4ZXZYT2YzTnEzRk91Nnd1RUxLRmY3dU04TDA3azNtNlFDUUFYUlkrczdL?=
 =?utf-8?B?UXpvQkMxaExTNHUrSVlnRjBseGhYazROSnVMSnkwVkVSRHFMR0RheVhZTVc3?=
 =?utf-8?B?R2lITEQ0NTFyaGdIeE82SE94WGRqdnBiK2hYOHkrR2IraExJVzNXeWd2Qm15?=
 =?utf-8?B?cEJPcEZjcm5hcmtXeE81dGcwQjFsWnJkeVlUdktOT2V5bG4wdkV5NytRTWVB?=
 =?utf-8?B?TEN0NUlDaWtzUk4raVlVVFI0VXFCWmZOQklTKzhjck9ydk1pTlcwMThva3dT?=
 =?utf-8?B?cmRZdW02N2RDQVV6ek1kN1I2dzZXaVkvU1hoZTRLNHZSVDhNTDg4RWwvZ2dl?=
 =?utf-8?B?Z3EzUExxaGN6bnpXb2s0Z0JQL1BKNXVYY1UrenVJREIyei9aMWJqWktSdlJ0?=
 =?utf-8?B?MklBYVVQblhSODYybXRrTzVPbzdEUWpydGU0Q25rTnNNNzJhUkRLTFZWVnJa?=
 =?utf-8?B?WTVYaWhXTmlvczBhU3pCQ3BFeU5CMHJCUit3aGRMTHh6RVhJb2FSRVFISGNR?=
 =?utf-8?B?b2FFbnlPYVpEWHZ3WjMzTnkrL3V2NjRncXFNa3RNamNyZ3pVM2RoOEZadElR?=
 =?utf-8?B?S3cvc3FBc04vY1k5N0wwNS9OSWdqdUZiSEJtS2ZOT2tLWWdwczluMzRBVGFX?=
 =?utf-8?B?eFl5M01WK0wycllvRW9rekRldDBxcEYrbHVnZ0ZtdUdtVHFQYmVXMVI3YWRn?=
 =?utf-8?B?MzVOc2RKdFZPYk84eVkvUmZnLzE2WmJ3ZzN5d0RIbHJrMHNlK0FKc3U1RUhi?=
 =?utf-8?B?M2E5TThPVWhUYU5MY3VoRTE5TXZlSCtlcURtRFNiV0s5bXdVUnZtRmUvSjV1?=
 =?utf-8?B?ek5jbDhWNHNkdDRIVHZFQ1N2dFRMS3BjY3RHcDNqam9JcUVOWWpaV01vRHR3?=
 =?utf-8?B?c0Z1NFdrWHNmbDRYRFBYalBFd1hPR0tOMjgzM05iZkF5cU1FR1p4NDZDV3Np?=
 =?utf-8?B?V3E3d1JQVlFoK2JtMk5CYjNIUW1qQWFKenk2Q1loMEJLNGNNV05wTk1qSTk3?=
 =?utf-8?B?dHJBTnVmODBwUzVPNlFEL0x2Qko4dHhVY2ZQZVVRdlNjeEhEWUkwQ1Nwa1F2?=
 =?utf-8?B?aWUxNUR3VzdZWnhPMUk1NFFMdWtNTEZ0dEplVUxsaWpWN3VhTDRyNzZUZVRY?=
 =?utf-8?B?NTk0MnBMOHBJd3ZxK0JoYlhYS0JDRzJmTVhacWRPMngxMHVrVk5mdE5xSGZB?=
 =?utf-8?B?YUJ0VFd4VzdGTUg1WElKc2tBSU9ZczZzazg5YVFFaWNPeWFmOHoxaWFwK3VK?=
 =?utf-8?B?Tm45R2dMNU1PNXRZY2k2NEpiMW84U0U1NnFxSmhnRk40WlJ0a0g2V2FDOVVu?=
 =?utf-8?B?TlFJRUJFdHBPQmgwekRnNmYwMWEycDhiVW9uYkswb2IyM0R6YjA4WFQrK253?=
 =?utf-8?B?YjFNY0NTS3NMVWxtcWxRR1A0ZDB6a2piWVBFTU1tKzFXNjRJeEJWWHRmZ3Bv?=
 =?utf-8?B?NW9INWNlcmEzTmliZE0wSEhUVnJ3RC9tVTREcmV1Ukk1akZFbjJwKzJKNnNr?=
 =?utf-8?Q?CHgA38XAeLw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUFlUW9vbjhNL25sdkhCK2tUR0FMSy91cjhsOFN4QjBVemhrMVZaNElsVlk4?=
 =?utf-8?B?Y2FSY2tWSTl4MXdFaVozTFRLZHQ1NGFpYnNwZHh0WEVXWFd6RE41U0hvN1g5?=
 =?utf-8?B?WlZnZjFwVlhhUDFzOHpyWTJiMG54YzdUY3BSdWdoQU9VZkx6cG51eEFqa3Yv?=
 =?utf-8?B?Tks0ZUZSZno5cDl2TEZ0UTlMandPR1VPN0pXQjJ0bkFkdW1UNjJtaDZXUHFX?=
 =?utf-8?B?V2tGeDNHNHNXQk4xU3R6M1ZyOEowRkJYZERIK2xTN2FVM3VOMWFaU2ZkbWlu?=
 =?utf-8?B?clF0L0p4WnlocThXYTN2alI4OE82aTdaY3BJRVlkMm5WVXRtSmlTL0RHdXky?=
 =?utf-8?B?VWFIMndwOHh6WWtoQ2ZWQnhkTk0xTWdQekROMnJhck0wRElmay9FejRmTzZZ?=
 =?utf-8?B?b21Od1A4VUx4cGFMSTk2SDhCQ2hkMzZkdU9rWjQ0UmxuN2VSYitJVmluV2pH?=
 =?utf-8?B?dFlnL3JKVG56RjVISFJEbjFOVTJTVzlKVGo5Q1ZkRkpZNFE1azcrU05wRmlF?=
 =?utf-8?B?WVhKczlKYmhhMm1TY1ZObEFXSXgza0RmM2ZnT091cEd0djUxaVZiUHFHUHVB?=
 =?utf-8?B?ejNOWHpOM1dqSkF4dWxrdmwrNEJlbDZkSnBpVzBZcVFlNlpFS25FdlRuNlkw?=
 =?utf-8?B?ZEdjTlFHV1hDZkJsanVOd3QzTVRRK050MjgxcXBIcGtUNDJhbnlhVkxHcXEr?=
 =?utf-8?B?NUxvQXA5V1lrcllaZmIvRFRIWUtCSDY2VERVanJwai9ndXE0aEx2UmRyYW1G?=
 =?utf-8?B?VDIvOFBqVWViWDdaaHh1MXh2UVZtTkZueVVPVHE3b09tOVJ2SllDMURaNkNY?=
 =?utf-8?B?RGVoODM5c3FoKzN3bTJnWThhOU5LU25FeVVERVZTQVRWVVZrQU1SQ2ZVRVdx?=
 =?utf-8?B?OFd2bjY0TzRNaFZCN2JPa3NjT2dvajZjekE3MFdDRlJTZ3hqSElGVWdoaysr?=
 =?utf-8?B?RWVhUmQrUjJHc2l1ZmtTYW4yd2g4RTM1NCtIekxrS1FtWDhocUJ2S1JJWElp?=
 =?utf-8?B?aUtWL1pBVHZLQkhJNXZrT0MyZDJoZHNQQmdpRXN4dmlDQ3hHWkx5U3BUYytx?=
 =?utf-8?B?RGlEQU9vOUV1bnU4Nk52Y1I3Ym5HUFJQUjVEcEpkenpDaGFQK3hCcmVNdC9h?=
 =?utf-8?B?OStZQkJ4YXA5R1FVMExjdGNPOHcyT3dpckxqMFF3dUYxbGVzZzJ5eUpPd2NS?=
 =?utf-8?B?R05OSFM2bHJEMFdYcVBEV0U0d29VdlZ2dThhMDFIcEpLWjdKUTlpcm5OZTdV?=
 =?utf-8?B?Q09nVlNRRmx6VUFlNEdJZXBQSXRSS1FKZ05ETklVM3RjL1Z1Nnd2UGpDa0Zj?=
 =?utf-8?B?V2dha3UrYlZPSmVMbEI3V1hqSCt4U1VuK3ZweFM0ZlJjV1FNVUg5bGxFUC9v?=
 =?utf-8?B?REV6aTljaElmRE93dHpuVUlSUlQxd0NZRUt3UEJHU2JQaTk0NUhTcnRPRld2?=
 =?utf-8?B?V3FYUFI0WUVzeGlaNlVrWGVrbk1YZTc1VDcvd3lscWtiWUp4d3hsYlR4bWRi?=
 =?utf-8?B?K1FnVEFJRUVKYWVMNnJ3bS9pM2dBVlpKeFdka2ZQZi9YcWJPc0ZXa1J2Yk1B?=
 =?utf-8?B?dHdFd29SaGM2cEFBek1PK1hIM0tsUENCZHlsRlhaY3NhSjd4NEVHb0ZwV1pw?=
 =?utf-8?B?emdGVms2Q290dTE2ZFRxdTVQYTlXUUt2MXg5MzhNZ0tYbkwya3k4WjBDQkZQ?=
 =?utf-8?B?SlNxd01TVENZejFjVmtlS2hYNTB0L2MvaTNvZ0YwZUdCR21ZY2JMbThRSGV4?=
 =?utf-8?B?SXJzMjc1YjIrdzVIazl4Tk9aMC9HZ0FqTFpoVWM0RVYzSEh4b2dTOExlSUlB?=
 =?utf-8?B?VHlTb09kbkYzNUljdGI3dnhYelFiR05sSkMvRXcxK1BNWHcrbWhxYVlYUm9M?=
 =?utf-8?B?a0NqOVg4dzFOK1VDY29pdFJ5NTkvOGJaUERNZEdaS0tseFJqZjhpc3ZtZURv?=
 =?utf-8?B?RXBoLzZrY1RGVURXTkU4aUJDVkxhYm91cklTa1liU2Nid2xGdHUvbW1nMUpl?=
 =?utf-8?B?S3ArTUtOcG8rMjhYUDgrdWxrUDJhYVphQkg5Q2tURlJDZDV6VEF6dU9tVGVQ?=
 =?utf-8?B?ZFREdnBQdDlab1JyYitDOFNoUEh2S2hUQlVDT3o0Rzl3dC9sS29NZVRvaEJV?=
 =?utf-8?Q?loKFHPUyz5go9WJTvuIaiRk9l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd25dbc-1dc1-42f6-7d8c-08dde526e878
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 05:02:22.9591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZXiq5VbcBxGpHq0dkknxyqCmlnPb/SrLDXUJkLnQg6IgOdHy3a8jnBg/tJzjAXk5Ly35pO045P4VreKP2Xk+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463



On 27/8/25 10:15, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>> index 0c662f9813eb..5c3f896ac9f4 100644
>>> --- a/drivers/pci/Kconfig
>>> +++ b/drivers/pci/Kconfig
>>> @@ -135,6 +135,20 @@ config PCI_IDE_STREAM_MAX
>>>    	  track the maximum possibility of 256 streams per host bridge
>>>    	  in the typical case.
>>>    
>>> +config PCI_TSM
>>> +	bool "PCI TSM: Device security protocol support"
>>> +	select PCI_IDE
>>> +	select PCI_DOE
>>
>> select TSM
> 
> Yup, already in v5.
> 
>> etc.
>>
>> but this is kinda wrong as it is quite bizarre to call
>> drivers/virt/coco/tsm-core.c's tsm_ide_stream_unregister() from
>> drivers/pci/ide.c's pci_ide_stream_release(), i.e. "virt" from "pci
>> core". imho the caller of pci_ide_stream_release() should just call
>> tsm_ide_stream_unregister() too, and so on. Thanks,
> 
> So I agree it is odd, and I orginally did not have this tie until the
> DEFINE_FREE(pci_ide_stream_release, ...) proposal. With that I want to
> allow for TSM drivers to teardown everything associated with IDE setup
> with one scope-based-cleanup helper.
> 
> It is not a mid-layer because nothing requires a TSM driver to call
> tsm_ide_stream_register(), but if they do register it then the PCI core
> helper will handle cleaning it up on error along with the rest of the
> resources.

I see but imho DEFINE_FREE() is weak justification for such cross-subsystem jumping, still. I was looking at the linker error as, like, "find a Wally". May be then drop EXPORT_SYMBOL_GPL() for tsm_ide_stream_unregister()? Thanks,


-- 
Alexey


