Return-Path: <linux-pci+bounces-26691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736CAA9B112
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 16:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957FD5A4801
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5EC27456;
	Thu, 24 Apr 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1W88S5zl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCFC15C15F;
	Thu, 24 Apr 2025 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505060; cv=fail; b=NstvLbop/yGyoCo0knU7zL9uCBuMZFQhNr0rFj/XCHx7FA0SrrKq7s9LPRsXOEMI/vqtvkwzLI+Jopqc03GOb86XPu9MZmQDIsFey3GsLoUt1r83Gf4cjpiyDSY2JeROn+O89h16DHNO3ARjrlar2Tw+csGLs6W2RssjZDFs4dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505060; c=relaxed/simple;
	bh=xahuQPZXxAfCcMcYoI7BCWXCKgC3ZaAxiF9/UGRrDmE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PLxv90icSIe385xIB5pk1L8hayXFtNKaumV8efb4gTGtY7r4Q2Q1zKLwYxFJ8Xq4fEhubxRChw57D9WndkZoUQLKiY2uzvUrn+SSQzWRpv9AP5HBnbYhyrSds/PLLqMl+s7qqPbSyaLk4zVxsUnPJlB+Amhf9DGU2V6vKEl1Edg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1W88S5zl; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9fTOjNbKXl1g8F0EympL0abFQl/YI61+tGJ/p4+5XjItoFFHGZgfqqwFjaoLL1Dc3M/HjmlcU6oMD2KGlCHik/qousAx8eeibsBs0xgp+x7oKvmYcYuY43swxRhJ4gdrbg33TVRr3b23iwIKzI36mR027aU7rksZwWzT+56QPp2Qa+QQQz11/HDrXs2ded0wEf1m0swYJxIgWt9ZbeNaPfys3oiNhmynwj7OMHvISGyFeq3Ytjo3uwESd19STcyyvg/Y8ynt3xqYCloXfr+gLQVbV3yB70PNVun0yWu6ppAXMTyZlyFn+k6HTF+u5LnrG5eITaCxXMs0pB5FZSoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74iBGC0og9BVRWdSy/xxuInNYLMZSNOwt3b+jm/GtCw=;
 b=hrmTa1LoJvwFYc3SunsQWDp+l1Ej/1LFvldWbHNePKt10Yz/3RsD+99+CrjwjN88CiZ8T3liBMko4nAfA4zOSC3U5rBLOLXfvOxrK+FMAwDp562wvFMvyo2yH99QbNn1jbMIcvvTUV029Ic/ZbwGqj/90MzCaXapBbVaw6c83JESYqRP/53BIPkJBdCP5wVhhEjqkwl9CgVClWVhmhzTZqgGzKJ69NMn5y0KPmb/pmPX9nOMv1cYMKZk/MTTfGWr3OqWnDxl/cXUtU4LQ4pVMMM+fVS5/PrjjLg8wYap4e2Tm52gDCgkzhnoZ9GBzRbP2KqASsTv5doU9k+IryK4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74iBGC0og9BVRWdSy/xxuInNYLMZSNOwt3b+jm/GtCw=;
 b=1W88S5zlsavF0r/FrZS/6QW3Iwi4Hlc1JET6RN47LANEb3xLLn75hiu+kYnA7XoOMjBTo5UIIzWnKAlzfv82fFJ3AGutRCakn0wYRpzx3fI3/IhjMn2dbjHxsS6UIjMjUQj9ykOp9iBxoCqllEo1lCKFlgxZ5E1aczTNcRB1sWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 14:30:52 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 14:30:51 +0000
Message-ID: <139b2f1e-2ddd-4e4f-a63c-4516263250cf@amd.com>
Date: Thu, 24 Apr 2025 09:30:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/16] cxl/pci: Add log message if RAS registers are
 not mapped
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-11-terry.bowman@amd.com>
 <20250423174105.0000597b@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250423174105.0000597b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:806:24::18) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 163b5020-cb84-4833-373c-08dd833c9d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUw0SUo0aUFDMGVucmFicWE3RmwvVGE0ZU1RaUU0am5RdlFDMlJqVzVJamdH?=
 =?utf-8?B?Zkk2T3VoY3VyTHAwNHNnT0IyOHZzT3dFT09oVThpeGVZbG9YREtaRW04aEgr?=
 =?utf-8?B?LzZEbmNOZVo0dHo0cFY1Zmp0NkRZOWF2dXYvazI4UHVkTGdHMGQ4djdDOURZ?=
 =?utf-8?B?aXRNL3hJUEVVOFN2Y01ISHR3Z3Q2T1RraXRrMFZZUzdBQUtsNnM5eWdKL0Ex?=
 =?utf-8?B?dzVZRFd5M2V2UHladFhIOWR0NUgzSFc0ajhYUUV4Z3dyYXZNN25ObEwrelR5?=
 =?utf-8?B?R0p5TFlKMTJhc0NZN2hCNWNFMVdVT1RZVjd1SEdDU29rc2RZV3ZrNjRTRHQ4?=
 =?utf-8?B?cVU5UUNlRi9wMmtpallGUGZrRm9nWnVJblA5cmYxaUg5QWNqanRjTmVCcHZF?=
 =?utf-8?B?OGRNNU5jRmx1QmQrTGh5ZDgxZDRPUjdQM003dndsSjMyRnliWURQNWYwT2h1?=
 =?utf-8?B?RTVOK2J3M1NvbloycEZPSlcwWW5mSmJoeWJ6QzZsbnpZQ2k2cndweG1memY5?=
 =?utf-8?B?NGZhamNpVGN5R2I4ZENCdjNCb2dNSjV2dlBvdzI1aU9tZ29nNlVLcGQwa2lE?=
 =?utf-8?B?TjlIOHhnTnNhcWpheXVGV3BtL3RPOW5KYyswTXRXSk9zN2hRU1Q0dUw1OEV6?=
 =?utf-8?B?VFB1NU8zd1dxeGU2eU16OGhkM0lBMkZ0M3g3d09mZHoyN1ArSU5pMVBXTnMx?=
 =?utf-8?B?ekttL25qZkl4VGc0UWlkUlc1cG15Rm0xZjNkZHVjY1I2dEo2T0RQd1ZWYVRR?=
 =?utf-8?B?VFZXMDZaQmpPZnJZUHg0SktNVFhwZlF5cUpWb0lpdXpSeTZTTTZ6cUNWMmN1?=
 =?utf-8?B?NzQvMUpjYjRWd1FSakw0RnN2eVY3MFpnaTRrcTN3cWREMVVQekZjQTZVYkhW?=
 =?utf-8?B?SzB2YWZ6UkJzYSt4dHBRdTJmRHo4VzZ5Yk9DRTFmS0d1TEJYL2RUTnhhOERI?=
 =?utf-8?B?NVhVWWFyakM0VXdsR0tRUEVucWQ3MEJ0aXRINVhjOC9ScG1kb1BUSVFFMXJV?=
 =?utf-8?B?TFZkT21iOVhqeDVFTHRxM0N0RzdyY2VQRkphN0I2RnZ2a094NnQ2Mzg0RDVP?=
 =?utf-8?B?alBGendYNVpObzFyYTV1cy9lTTMrTnoyQjVPT1l6cXFSb1dvd2NjZXlDWFVS?=
 =?utf-8?B?V04xUUw3d1drbkpiQ0tndmpTVEhoYnhlcHNpUnVuVXRKQmJiM0tTcEtQY1c2?=
 =?utf-8?B?bmQwOXA1SFZMVUIwS3dIL0Q1MXBZY095OHZPSGkzRmxsbitXT2w5M3Bhc0hW?=
 =?utf-8?B?cmo3VXFhbXNyaWlncEgvdlZDU3VVeERLamxZRVRZVnBnNUhLTUczN09CS3Aw?=
 =?utf-8?B?azVoMVRXWlBHMU1zUkhRWUM5UHBocjBuTWVsRXBNNkZvMUEvbm9HZkZucDdv?=
 =?utf-8?B?bVE1M2lmenNZWVlXNWlOV1BCU080Sm9Dc1lDUDFtd24yYlgzUTR2OE9mTU5F?=
 =?utf-8?B?TTJwTFp0Tnc0bGRNcEhENEVUeSsvQVNEeHZyVk15M0lpMlYzMS9IYnlvY0Fs?=
 =?utf-8?B?bm9MSGRTNUN0RHU3R213L3V2K0ZPY1JrSmp5Wm1EL1Vrb0RzVmFBNkRYNyt0?=
 =?utf-8?B?M1FYT3I3R0d1d2tEUXA1Wnp0NFg4cDZ0YmpndEJLUXJHZm9qdHV4NlVxRXBn?=
 =?utf-8?B?NkQwOE5PMkhIajdRTjZhcjdUV2RteEN1bVZVdHNEb2dhSWFvdXdtc3RpZWlH?=
 =?utf-8?B?TW5ZeHZXSzZrSG1XbmNSbFV4cXVZN1MwSnlmeFdlT1BBdVNmNmU3eFcxdVMy?=
 =?utf-8?B?dmZ4OG4rVWV0YkVlWVJQTlF0UVpJZkF5MXJBanorb2RkSU9EWUFlZ0xHazRO?=
 =?utf-8?B?MzlVb05abVQzdlQ0VXZXR2t5OE4yYzdPT1ppSjJpMmdJUDBVb0l5L04zYTh1?=
 =?utf-8?B?ZU9RQ1l2L291bk9keG1nQ2NLRlFKM280N1pIaDJKQ0hqb2FpdTNCam1sWGti?=
 =?utf-8?Q?46jIRzLXGZM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWp4V2JXMDVkdkk5SUYycE93YmY3YzhVTkFGYnJybnM4TEpVcVpGNnliMC92?=
 =?utf-8?B?Rm8vS0xndHRNSTFtcXBXM1dGQ21VTDlyTFdsVzVJYnZFdDF3ZUFlaStKVHJk?=
 =?utf-8?B?c3ZyNHh1VmZIRnRHOFdrNTFqbHpDRFh0NUx6Nkt6RXFnMk90SnA1S2I5T3hQ?=
 =?utf-8?B?OUxiQkEyeE9vb3hoeU1lbGZ5V3RkdUxncTJ5elR6Ty9mQzZLTU5Xb2JGNlZS?=
 =?utf-8?B?RkpFa21JRGJRbVdtNlF6R3pxVG1Eb252NXZTWFliZkM1YzVuMzcvd2QvcFVB?=
 =?utf-8?B?WGpWUUpKOHpXVkNIQkNDNXEzZGhWYXRJTzluVm8xMS9ON2ZCeEhlWTVKOEo5?=
 =?utf-8?B?VUJCMEtNZldHWXhXSmF0eUppYUd2cnZFTXh0NENFRzV2QVg4MUQ2MGVEVnJw?=
 =?utf-8?B?Ny9wSjVJaXV1RWV5TnBuUHhxdVVmd2orZlpQYWtpdVExeTRqYk0wa1V2d1Mv?=
 =?utf-8?B?SUs4RHp2U2RueTEweHc0VFNmLzJWYWRValYyRGo4WmswTFBuWHpDNlRzNjdP?=
 =?utf-8?B?cTVReUxsUWwrQmgzaXducGVFNlQ3c3VRdEYrazZhbHh0bHpyY0RGQkpqUWVV?=
 =?utf-8?B?V205alk2ZmpKOTlXOVJocXByY294WDBYUVFOdVdBK1NUQllKcUkrdUdXUmZ4?=
 =?utf-8?B?WWFwN1huVXI3MzlWcnFzQ1ZmdVhYd3FMOFJOaGVTWGQxMUdFeEhjZVlMSUxY?=
 =?utf-8?B?bE9CQWswejlkM1h5WEZJZ050K0lXczRYT0s3STdGVWVEV2xFT09uNFZKS0Ru?=
 =?utf-8?B?ODJBM3FQa2U1YnRPSFkxUFhmZFcxbzFpbEdNOWMwemtwci9jNGNCeC9mRFNS?=
 =?utf-8?B?d3RiQU1PblVZeDB3d1drVnJUSU9qSUZlUXpBeU01OU96TWZGZENHbjBZVS8z?=
 =?utf-8?B?c25peHBxQnAva3lIZVFGZ1dhZ0pNb1pUQUdmZFJMU0doK0JiaGtGcHRXQTlp?=
 =?utf-8?B?dm5DYUpyZmtyUW5YeGdXSnRrTXJBNmxaSU9Lc3g3TGdOQ21VN2h3ZGlpYlNx?=
 =?utf-8?B?OWJwMklsUHRZeTF3KzJ5T3BkV2l2TmozMUpLWmhVcjVVK3B3WDFJaDk2NnBB?=
 =?utf-8?B?c3c1Vlk3R1k3cG9ucE9UM2xxbWhDRVNVbGk4MWZEWXZnTm03K0ZHMDA0TXJv?=
 =?utf-8?B?MnZoZm5yQ2FNOFoxb2VWZTFlRnpZM0tCRnJTUmRXcEdRL0Y5V1gyNXNTVHBO?=
 =?utf-8?B?cVF6TVozdEVycGN0N1VZeGpZUGI1UVgyMll2VEtNYVdaL09nZmFxczlKYVNw?=
 =?utf-8?B?WExodGZkY0F3V3FUWnJScXlRTm50bHdoV2t5SDFneDdnZ3ZLYTNqdmYyaUhM?=
 =?utf-8?B?cHhMcHBiZ3AvRFZWQmxsR2gyY1cvcUZvLythWDB1RkpyTnNjUm5hT0xhLzBN?=
 =?utf-8?B?dFRET2RjMXBDSUoyR3VDVTFTQXlRKzRuRm50Qnl6ZUNXS1hHTFVTQU9teTFt?=
 =?utf-8?B?TWNnQ0FDUlJpRGNLV01zQjdtV0F3MFY4NmRkeWxiM0RNZGczeHNaRFNCeXBp?=
 =?utf-8?B?MlNkak1CQmJXL3A4U3c2d2N5M0Z1VXM2YlVMeTNEeXhhblFjNmllaXc5dXhO?=
 =?utf-8?B?SnBrMzlBeS82aEMrQ1U5UUpab3dIeVFiQ2RFY2Jzd21HeVJmakVnU3AyWkNh?=
 =?utf-8?B?d1M3L0tkakdWa1RadldWY0dUZ2NjL1JscHc4TmFKaThSUjZ6NEUrbmRwZDVq?=
 =?utf-8?B?REVYbm5lb1pqV1VLemFqekZ3V3k0RkxZQTNZUldxNGpLT0FTZGxxSDNVQjdw?=
 =?utf-8?B?NkdoYWVCblRNKy9kVEhlaFMrdENqeng0OFIxUUxWWGhVNzlmM2c3UDBjci9F?=
 =?utf-8?B?eElyRFpEclI2N0xYV051MEUvNkZWbGkzRzRudGpIRHgzbnJIZ2Y4ZHF4ekY4?=
 =?utf-8?B?S0ZDbUZSVVFTMG5maUh4bmh1dy9WRVZOeXNmV3RucUtEVm0wMHdmK2hYUFN0?=
 =?utf-8?B?Z3BiaWdQMkVlSWs4c2puZU5HZDRIdXFLRWsrSkdLN2VEWEVkK1J1TlphZTBx?=
 =?utf-8?B?OWxic1pHYlJsNmo5RGg5TTJseERNYlkwL0MwUkFrdUhJZWFQc3YvUUlBWnhV?=
 =?utf-8?B?L1FQLy80RlpqUy84RFFCeWdNVTRmakpNaWUxUXAxSmFxN1RjTlRnMFUzVk44?=
 =?utf-8?Q?lYq92QbLzuguVdOVNPs2bA6RP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163b5020-cb84-4833-373c-08dd833c9d30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 14:30:51.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ic+zsZyuAli05K/wllukoariqUoYVfC6IS1xj6g0SIPiyYkIimEIjH0Ic8JDjSrtMC5iIAEO50L3/zXh6yjz6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564



On 4/23/2025 11:41 AM, Jonathan Cameron wrote:
> On Wed, 26 Mar 2025 20:47:11 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The CXL RAS handlers do not currently log if the RAS registers are
>> unmapped. This is needed in order to help debug CXL error handling. Update
>> the CXL driver to log a warning message if the RAS register block is
>> unmapped during RAS error handling.
>>
>> Also, refactor the __cxl_handle_cor_ras() functions check for status.
>> Change it to be consistent with the same status check in
>> __cxl_handle_cor_ras().
> Not keen on an 'also' bit in here.  Seems entirely separable
> into its own patch.
>
> Two trivial one thing patches seems better than one slightly larger one.
> Actual changes seem fine to me so feel free to add
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> to resulting pair of patches.

Hi Jonathan,

I will split the patch as you recommend.

-Terry

>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/pci.c | 17 +++++++++++------
>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 1cf1ab4d9160..4770810b2138 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -656,15 +656,18 @@ static void __cxl_handle_cor_ras(struct device *dev,
>>  	void __iomem *addr;
>>  	u32 status;
>>  
>> -	if (!ras_base)
>> +	if (!ras_base) {
>> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>>  		return;
>> +	}
>>  
>>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> -		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>> -	}
>> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>> +		return;
>> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +
>> +	trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>>  }
>>  
>>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>> @@ -700,8 +703,10 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>  	u32 status;
>>  	u32 fe;
>>  
>> -	if (!ras_base)
>> +	if (!ras_base) {
>> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>>  		return false;
>> +	}
>>  
>>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);


