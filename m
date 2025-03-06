Return-Path: <linux-pci+bounces-23061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB679A54C97
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 14:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E50218911F7
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF0433B3;
	Thu,  6 Mar 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OmkfCqqN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9DC33FD;
	Thu,  6 Mar 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269030; cv=fail; b=Utl0UB+1Yt9kefK33H8IvIV+dVBTR5tLmCXNg2XperycZYDeGJUABB2I3aqU7eFwXVORssgJXaPdWjlPbZEfOjp40jncHl20vHO3NnJRXWidI3FR/fvfMiAxCXmzZNglN3ZiHB/4vtIm5MFceVxaSSQdlAvTZInS68NXStF3AXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269030; c=relaxed/simple;
	bh=whX5mcvLyrTbaaST2V/R+GUBK1Asm3o83Ntjsd3XBYE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ePUGBsYmoTwbOEmL63OE8vMh+1DRJ8GZbIytqAlNu5Asr9XdSOKiMfvvsbsEByzi4iJ2yCgEnLekkgc1Ky4FC6oBOpJ9KQ45L3TB7VNMel6UgvfXHhx+RGPdMBxOiNHIODaPN1IksUHjWHcHghIbRogUXU8iQcGAjNbWTs8nGmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OmkfCqqN; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRRt0Oe8KtEYRtvjVHke1Gw7x3qpkfnZSxt/+0BDF5O7TF5Jny/9HBIOVEliGruwY2I0PA2jBCfd5+MF7yxenwrYRpY3Teg9d6nZZLx3Zvwlj1ELsvs+l45RgN4MMkLIpNqXZ2OpH/z0i74ydB60Ct9g5Qg48mwghe5zqEhy6gdAlnef/LsS7yGxWwvqtO388CjRb2S0tjAXH0BD8r5DxGLRFFPfoBaE/y8OQRhKbH038r9OoFAU9eRktJfzsQbSMHp8v9bebeqAOwr2FVIAkEBy7WYPBzAHKA7T6LovDCqh1BmRP8cBfFzV2eiu14qlIapEg93wrVqQIJgLu556tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whX5mcvLyrTbaaST2V/R+GUBK1Asm3o83Ntjsd3XBYE=;
 b=DhJ7LUJ4jcpzMWggoMsMsvS/K7yWnCpHKgSL8xMLCLL+Y8CVpLd1obZmbvyJLLnl+iYVGxzUzdWaIrYXKWOjKtq7g/vFilV+rii/11e/8ikWLPex5AO2syEMKRdfkOQlLs5fHah1iGNpNTx6Iaus8K7fbsoelpL2DCLqENCCFHBLxpBWFtxRCcHtGD5fzJTV7a1yLnrYkNQpyhKxns3ygDWaEqaLnN8/J7n5qYwDvIJBV2VeQFxVIY+syQAVVL/OuozYV6sHf4Kohk3W+JDvGPnavZ38lXp6OF915XLFmOl9/BOTHblb8Ppp+g1KS3LBBGZuxyGuLdNlRaBJIvj/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whX5mcvLyrTbaaST2V/R+GUBK1Asm3o83Ntjsd3XBYE=;
 b=OmkfCqqNxj6yTuZACFmp7Iv/Iir131TROFy6Dt4qY4KI6ZwOjKigENZGszOBMcM9sKJfdgLe6ORTjQwPcrcgAEjaiGJpVajKFvqFkZ1aUW98j6HogC7w884SiLrtGgQ77wa7E5tUVcn5LQtxGwxn1FQ65kVkAO9WhjspXioY7BU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 13:50:27 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 13:50:26 +0000
Message-ID: <fa799539-8d8c-4f9e-864d-41e18df2094b@amd.com>
Date: Thu, 6 Mar 2025 07:50:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/17] cxl/pci: Add error handler for CXL PCIe Port RAS
 errors
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-13-terry.bowman@amd.com>
 <67c7994bd79b1_1327329455@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67c7994bd79b1_1327329455@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:806:d0::18) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 15cc8839-0ffb-4b8e-7446-08dd5cb5d971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RE5vek9MbkhxQUEyTXU5T1RoTTAyV2tMQWs2T0FZMjU1c1hzVHBlWE1jUWxL?=
 =?utf-8?B?dmQ0Z2dSUHh4NTY0dkZBU0VNaUtweWdyL2ZmbUF5MWo1L1RCZFB3Y253UDJY?=
 =?utf-8?B?MTN3Skd6RStZbEJTSjFkV2drVTJQVnpIdDEyM21ad21BQVN2WU1XOGVMejcr?=
 =?utf-8?B?SmVRTll4ZEV3RDNIRVZTWEt4dFBIVkxFS0JVVitFS01OamltVEprVVJTMjFz?=
 =?utf-8?B?VkJ0RzlOc0E0em1IYlhUVmRIczVwc1ZXY1JldjNveWcrUkxSclpNVC9lVjVB?=
 =?utf-8?B?QjI2TFVjQ1BEL0ErSHcyUHBlQXlqekl1V1NmNlBBdk93M1QwbVFsVkt4THpM?=
 =?utf-8?B?WkhkVGN0SVpBeDJZVnBVeUtnbGRaSlhFSUFzU2FJcDkrQWxpM3FKd1N6U3or?=
 =?utf-8?B?MXNMdENrTitPdnFsQUFzUHpHRW5IMEpHaTliTDdwbFRVRTYyR1V0eSs5cjNn?=
 =?utf-8?B?ZWY0OTNFelgxSVF5dERFWWhKMkRKcTVDN1hVampKSXdBZnFmQzlPaFNoMnBD?=
 =?utf-8?B?dUc0b2FjZWViZHJRRk4xWlJsS0VEblJWSE9oKzd0Rm45emNKTnBHNEFRUEdq?=
 =?utf-8?B?dEpnb3c0L21iaWR2SGNrOW9aamgrQWpQQnUxV1RjMTNId1pEZ2p2V2pKU2lh?=
 =?utf-8?B?czBkK0psTnhsK2hheWpyNXNZKzB4RDI4bk1iQm4vQ01GUmZKT3FSaHJyOHFx?=
 =?utf-8?B?M1BiNXF6OE1Vc3hrd1VXYU9Md2YzR3RKQ3BlM1NSQ0orV2JsMnFpL0tyU1Yw?=
 =?utf-8?B?a2JlaFBQN3hQc2NkMHAzcUdjdXpBQy9CUmFtcktYcncvbVNaOHVZU0IyVEJy?=
 =?utf-8?B?aThPZ0VSODVZdksvYy9EWDdUTFVKRWlhZHM3QUxTL094NkRYUXgvdy96em9j?=
 =?utf-8?B?bHBJWnZqZFB3L1RjSTNEd0liaEVVZkFDVFIzSWJRSVFocXBkM00yZlExaC9y?=
 =?utf-8?B?aEtydkV3c05zNkNVeTRybWMyRXBqcEp4VnRlMG1INXF0Sy9TVG8zTFZZK1Mr?=
 =?utf-8?B?Rkw0U1A4c0I1OVFhS2NwY1o3TElqN24rZEh0R2l3WkswOCtmaGFuMW52SHZ1?=
 =?utf-8?B?K0l0dzJnMURuRGZZaXQ4MTJqR2wvM0RoUlUwdHF0YUk5VmZ0SENuRGRHZ1Zp?=
 =?utf-8?B?UmwxdS9xY1BlV25IT2VTclJGY0J6UUUvTEJZTWorblFnMHowbS82MTJGRmJH?=
 =?utf-8?B?emNqbTVZQlB5TXFoMWdmTlk4aTJoVG54Nk9BN0ZERHN5YWEyNVRtQ0ZnbTZG?=
 =?utf-8?B?dU50V2gzTFpMbTR5dXUwRE1Rd0lsVGxTbmFERjNSUlpkUXpIR3V4N2t4aCtI?=
 =?utf-8?B?TmpHdFd0M1dKL01lVFVWSUVvNUcybnQwWEF0MHh0VGZjVEFXeGJ4Qy8rZ1dO?=
 =?utf-8?B?ZzA5bGNLanczSmhJcTZleDFYQ3JDQVlJN3NvNyswMTM2bkZEMFRYcERTaHFW?=
 =?utf-8?B?TFJxcU00RWFvZTVxdnAxUDhwMWNJZHAzRG45ZXVmeTBjMzFSSVlqSmwzV0cx?=
 =?utf-8?B?TkpWTUQ1VGE1d3c3Q25VL25pNU9iVEZGNXYrR3FmMFJQTXUxNFd0WWxNNGtj?=
 =?utf-8?B?d0tYTXltM3RieDNyR0VNSkRuOEsrdjBRTWp4bnI1UG8zUlR5cTVBa20yVGNl?=
 =?utf-8?B?UEsyeDF6MFhzZHVDTVlZbjlmMDJIVFFlT01pa3pUYjBGb2d4V3hFanBuMkhY?=
 =?utf-8?B?L0p5eFdsRlRBTjRsYlVSak9IYUg3MVIvbGFlKzNyelFObWdvU21RbU5BYVdZ?=
 =?utf-8?B?a3lBZmFHWlJPK1Jod25KYjJKancydk9HL0tIRTRRak1BV0VPS2lCNWQ5R3hi?=
 =?utf-8?B?eWhTb1MvdkpBcWF0TXFYc25CZDVmRG90Q0tnYWpWZ1VZa1lTTDMzNUk3S1Bq?=
 =?utf-8?B?ZnQySkRjWTZpZTBjVFhpaERIbkdVL2RydkdmRXh5L1FLcW5EU2puV09BQnZJ?=
 =?utf-8?Q?2SsuSc87dCg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0M2OVJnOEJLRVhvNEY4OWg0UXo5S0JsZjRpeXlsU3F4dDJPWWNyNFJQOFJO?=
 =?utf-8?B?ZDhldms3bDVFS2Y3S0xWMHJ0eHpPSktzek9WdEJhMTh5Nm83OTVJZ1A0TG9a?=
 =?utf-8?B?TFMxZlpvUEU2VmNtTlRpMUJTUDlpaTBtZmExSFpoLzZ2bThnaGFWN1FsaUFu?=
 =?utf-8?B?UjMrOW9WREdnWG02ZEpmUWZKY1c1VC9USDluMmFYVHM0ZSswSGdyalVIaWJK?=
 =?utf-8?B?MERQcmJxMUQyVW9XZ2ZvcVR6S1A2bUJsa2Y4TTJ2TmVLSmdZc0E1VWZDUTN6?=
 =?utf-8?B?UlNhWnFXQ09SaVVTYnpmaExzNVY4SWlhSG1UTzBMVTNOYStPZ2ZWOWRKQy9u?=
 =?utf-8?B?SllqY28yYm5vSzhTRXAxYjJKeFFKZEFFR0dZY1RjOThacFlBUm5OaGV3T3Zj?=
 =?utf-8?B?Um01ZDVtMytoWDBjc25FYU5EMHdpZm5oVWhDdDN4OUlDMGdqVkNadEZ3SmYr?=
 =?utf-8?B?WVZoemc2dmsrUklRazZ6TXZNMU5jdlpWOVJSZmFpdE4xRFpBYkVmaXpLMGxm?=
 =?utf-8?B?d0kwc21rY3pMVEZHQjJDSTB0TEtWd0hLUUpwci92anJ0NS8yODJya0YwOVMv?=
 =?utf-8?B?RnVBVW5lellhL3NIalZOV1ZoOUtRUFNRQlp2OExJRmo1dDFueWpoTjdkWTZJ?=
 =?utf-8?B?Wk9XWU0zZzJYamUwYk1aS3RNRXU1WG95c0l6STRkYTJTcG9rUkloRmpKSUJz?=
 =?utf-8?B?VS8zY2ZhRDRpMk1yc2pPMWVKcVhaWXVSUWs5UkpyVnJQMjdEMUFIdXQ2dXh5?=
 =?utf-8?B?MlNrYnRsc00yVVllQ1BoNmFXWmJUbHFaL0kyTWNva3Z2MnNWY2cydU11TnAr?=
 =?utf-8?B?Q3BQci9oSEs4US9lb3pIRVROckkxbzhNM2xvSkNsOExhQk5YMTBLSlIwTzND?=
 =?utf-8?B?Wnp5U0ZWV0lrcDdMV1pLTGtVTGM4TVdJK3A4Y0t2YUx3dU5OaVZ0dzlrTngw?=
 =?utf-8?B?b3FpVVVpaWZ0MTdUV0czNmhzMnIzRlRMenhKMVo5MXFDeWRXWE9Idlptallr?=
 =?utf-8?B?V21WcUF5YVJ4ek5tMzg2REo4RjFiK2xWNGQraVN3cEZNbzJXb2lNVVNNL3hP?=
 =?utf-8?B?R25jZjBHejNQeEVaRUhaK3d6ZTFuanBCWVRuMDJRNE9rUm4zODBTNnQrS216?=
 =?utf-8?B?MkxrQmtEb1ZYbHJRTDhDbkNxM2tyM3kyK3dFd3lCOEtzSVI2bnlMZmZneEZM?=
 =?utf-8?B?TUdLeXBOV1BYT1pTMC84UTB1d1crTWQ5RWRVVGRjWkdIb2dGeksvYlh6a2My?=
 =?utf-8?B?Mk1VMUtFUnN2NkYvdWt4MTJSUjNtemxQZzJ6aC93MWJYcE5yRnl4dWtKSncy?=
 =?utf-8?B?VmtsNFh1UHRESHlySTNyYU9iVnAwcWoyQXExZWhKakZRaVNreVlzZDV0dith?=
 =?utf-8?B?ZEw3UjVSSjF2d1NiU3RnUHo4d1FqeFJwY0FzU1RRTEM1ZzUrZEpyZXN2dmpN?=
 =?utf-8?B?bHpEMlg5YkNBSzNEK3VsM1Q2K2F1dmFmNTJZczVvRXQ3TG9xaDRRUkYwMkFP?=
 =?utf-8?B?VCtJdmhZdjlaOVplTDcrZDF3REhNLzlHVEZadmNVMXEwRWI3ZituSm00K3pQ?=
 =?utf-8?B?T1RhZExrRTg0K2NYWkxzbEFXZ01vOTY2UXp6bS9wdDJXenRJeFVDWVk5QVVJ?=
 =?utf-8?B?ZFFIRHN3Y2MwYnpxb3NLcUt1dDd2cERsaXFyWG4zT1MyMTZ1eEVoRExjbHNE?=
 =?utf-8?B?YzJ5amd0VHlOeVlkRUx6TmhXWktNOG1ZcURwYjlQUmtlRVFsSzBXUVovUXZJ?=
 =?utf-8?B?ZGFQcC9WaW9yZjV3VG9RMi9jR0NuVDhZUmdKdVdWdVMrZjRxODFWd0UxRzZl?=
 =?utf-8?B?VVJjYWtSdGRUZGZJdU1ZcTdCS1U2ZFZKQTRYVUVObDFDeHVadUZWclQ2Zjdx?=
 =?utf-8?B?QjNqaGpUMWdxSW12ZnlRWjhVeWVaay9QOWtEYnNzbkpYUjg4VHgzeW5zYTFZ?=
 =?utf-8?B?ZDZSTS9aNGx5NHBqNXJXOFFDbkJBallGUXR3dVFSRUpCdThUVi9sMFpBV2tm?=
 =?utf-8?B?WkVnUUNWbGpIU00rdTBPUjljc0xhZE9KN1FmTS9mL1ZSSjg1ZFBieFZ1dWE2?=
 =?utf-8?B?ZkQ2dlVtM0NpYUFRZzNyR3dsMlhNOWNveGY5bSs3a3JFWFUrcG5CeEFrNE9p?=
 =?utf-8?Q?yaCxwJUJQ8ORzsO3VEsMwSjsi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cc8839-0ffb-4b8e-7446-08dd5cb5d971
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 13:50:26.5084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdmU8kZ/QHAMCXdVOLIIb6rZzTy8OFgfVm7aKn0WcnwvxxKZrpKfccy71BMHiBitnbUcWgBKo4seGyyA5KqrhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043



On 3/4/2025 6:22 PM, Ira Weiny wrote:
> Terry Bowman wrote:
>> Introduce correctable and uncorrectable (UCE) CXL PCIe Port Protocol Error
>> handlers.
>>
>> The handlers will be called with a 'struct pci_dev' parameter
>> indicating the CXL Port device requiring handling. The CXL PCIe Port
>> device's underlying 'struct device' will match the port device in the
>> CXL topology.
>>
>> Use the PCIe Port's device object to find the matching CXL Upstream Switch
>> Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
>> matching CXL Port device should contain a cached reference to the RAS
>> register block. The cached RAS block will be used in handling the error.
>>
>> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
>> a reference to the RAS registers as a parameter. These functions will use
>> the RAS register reference to indicate an error and clear the device's RAS
>> status.
>>
>> Update __cxl_handle_ras() to return PCI_ERS_RESULT_PANIC in the case
>> an error is present in the RAS status. Otherwise, return
>> PCI_ERS_RESULT_NONE.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> [snip]
>
>> +
>> +static void cxl_port_cor_error_detected(struct pci_dev *pdev)
> This causes a build error in this patch because it is defined but not used
> until later.
>
> Might be worth deferring to the future patch?
>
> Ira
Hi Ira,

Thanks. I moved the patch to prevent the warning.

Terry




