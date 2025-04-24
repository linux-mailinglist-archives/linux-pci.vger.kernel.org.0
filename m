Return-Path: <linux-pci+bounces-26689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4214EA9B0D7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 16:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFD8921981
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3069078F59;
	Thu, 24 Apr 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cxg7gIqi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F6A1A83E2;
	Thu, 24 Apr 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504553; cv=fail; b=B3Ec+7b8ZWsS4PglP2cKqZyl7784yCGi0x4Lc2E2zcAYbFYoH7Uzk8SgidZ0zyjyc2bjk3vpwxCN8LFFDTf8x4CVSaPNV26Jct6EWH/4M7UE5iVmXZEMKXANjlZt+YpZEcKpBe3rmHh15G6y844HnQBFBCzvh5uXPL68q8iN/Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504553; c=relaxed/simple;
	bh=9vlw2DM3iiuW5ujGYQJ3INTVUAkOi2wawP/thdeNKN4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hJiX1813DJ18SiZjHClpcS7Psi4DwXPjyve9E8ehuigkIgWSH98l6NOVKNN4gTykKvaOWGTlaK/51t0Ybq3FJ47SwZbPep1DjoK5irRjdwSzigH0TAVQRW1Vwcf6znY/Gq9hgz5eKC2VCx8nbYELlteIRfGHevdZlZm0i7t0A3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cxg7gIqi; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEz9ot+DaKDth7yAQUX3gl9xmwUc6CZEseHcJ9ULW5z8G6Oo8QgNiXfQhK1/g80tGcbnrf7TnmuFMoLQCsO1rtmqmyFuY7OxgPhP9Zbzml/AKppJDrvVLUDzn1lMaesOLI55RlUt+lrnY1di9BzUKFLlDk5exkeeX76OQZdM6FgakxOzP25l37wt2VhM3dLPxXRJQCPu8q6m3pgZx1vTWGz0rFrASPRmj2S7SMmIjhNnsOW+4Yf/dMsOZKo2jysmzDEL3fF58eExy1Pz8XNtdwL2CFd6ZaK428hyPQOm95H4Mj+MLqm9PYedYRBTO47YfAGMDIIar1w4tRmVqvYmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYyb679Qwo8t2aQeVERVVIwVnlvjajH6ksW559PvrTg=;
 b=eTaaYcUQ5MY/n35HybhiCL920XcRjjkYJZ2R6X1cpQq5Ak2IfM6MlDQs3n+kwsnLNr1qQ4H10cPCjmvl0aVziDdRKhCZ29GHO2nX6ActlgN0xewC/l18hHy/khBRYRaJCv6egotLCPKYGtaaj3KYrcfWf8CbxJGF8XaGsuIIdULzsUUmg6BoCF8VVEED0QMxTbX1jcp5dlz+tNOVXq2hu+bGunBNCa8WHDo8iox1eKh7Rwvv/euvMKAkqeb1uFklYTwoBbvCnTDOQvZzKXSx9WuF1UV9fQmEVEYkJ4vfET2eL56Th2L7fhhj+1kET9Ib1u8Xbo2rUmkMcFVnnHSE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYyb679Qwo8t2aQeVERVVIwVnlvjajH6ksW559PvrTg=;
 b=cxg7gIqiXIrqY+TWkl2JkMLF57giS7alYboPQMh8cjqf4NTWcVo2+1DdOnUXdAX9eSwFB7YkgF5UHyJfKAdGxXOYifspvBTCzp4ZJL4Lv8utn0L6iRoRnhGYaHClW7ACSDr56WHtF+RVm9I2WquhLPZlBQywon2RnERQ1O7GdgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 14:22:29 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 14:22:29 +0000
Message-ID: <e9ff4d38-e393-4260-b021-119739154816@amd.com>
Date: Thu, 24 Apr 2025 09:22:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/16] CXL/PCI: Introduce CXL uncorrectable protocol
 error 'recovery'
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
 <20250327014717.2988633-7-terry.bowman@amd.com>
 <20250423173540.000034b3@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250423173540.000034b3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0080.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::17) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 40deb957-44eb-4f3a-985a-08dd833b717e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3JrVE8wWWJEcUd0czF3TXh5a25EMVJhZG1mVW1KcmNVN2xwcWorcEpyNEVG?=
 =?utf-8?B?aWlLSU50eXpWVCtnczJhODY1QzNRVjlRaTVtdVNnai84bmtJNUwvV0ZKVkRM?=
 =?utf-8?B?ajJjYVhnLytTZ0dTRVkycG5OamNZL0NrL0luZzllNkFyZUVYVnRwU21VbFVi?=
 =?utf-8?B?ZmVvMEpwRk5lUlVpY3VCSUI1MEFIM1piQllIeFFhNEtJK3pPVlJwa0RUOFpJ?=
 =?utf-8?B?andHNDdYSXJQZzRWaDd3N0kra2VINW8rb2ZTcktQa1kwZmsybm1wZThVRTBQ?=
 =?utf-8?B?SVpZSGUxRmpiZURFRlNqMHJudlVIVmRGUVd4WnhacnlvY2lFWHc4c1BqNldV?=
 =?utf-8?B?VzRMd2Q4OGxWbTFEWit6M0ppWk51ZWh5K09WaXFtUVduOW1hWjU5ZmI0VXRp?=
 =?utf-8?B?ZlJlL1RDUXRNcFd1R1BNQXdXNGFvakhhRW1XMFhZaWlzYlpCOGZ3ME05M3Nj?=
 =?utf-8?B?bmtkcTlpU3h6RGQzeHNuWFdwY0JnMXBYVTU2K1UxSENCRGJHT2NxclBvamhW?=
 =?utf-8?B?RlQxTnZVMUZhWmlaclg5WGdWc00yTGZlMTc4WC9SRyt6OUZpbnNJeU1NSmYv?=
 =?utf-8?B?QVJMYUhaUGNtNW5aOWZYWVVWVTFPM0RLeFMzUXRlL09LeER4WWh3QWdjV0J1?=
 =?utf-8?B?aSs2cDA3T1JOeUpSdmM0K2x1bEJSamQzUEVXb1AvYm04QmZKNXkwdCtyVXAv?=
 =?utf-8?B?Wkl2eklqdUZPREJSZDk1d09QdERNeEUxL2FFREFsUWFESjZ5YkNxMzU1cENH?=
 =?utf-8?B?NWE0YytnZXN6UHpETFlpL3JraGZETHlhZ05vdVVWWUo3d2ZTa2JmRFEzcGts?=
 =?utf-8?B?OTBtcnR3SWo5c2t5ZHBDNzM0eUxlRDRtU2lIRVZTVERSbjhZdTNYV3pxeFlV?=
 =?utf-8?B?eUtDQm16eG9QT2VSd0FUL1N3blhxZ2Q3a2NteEo0cXViZlQ1ZytiUDZWMUxl?=
 =?utf-8?B?U1JieHFXejBWMXpZSUZmdEJUSi9qOUt1Y3lsdm0wNzlScDRDdjdkelRYbFh4?=
 =?utf-8?B?V2xpWTVjRXM1bFpzQUowWjVnYjNTSm53dWdCaTF4Y2RvMnN4K2tXQ1I0SFR3?=
 =?utf-8?B?ZU53bWl2dHhNTjZFTHFQZFJxOThDZ2ZLQlhZUGloOHUzYWFNREx4TUpjSmFi?=
 =?utf-8?B?Y1VDTE5jWHZ4TGJXNDFWYURDdFFQNjRQRFN3bEo1SEJsUXdDSDBIVEtTYUkz?=
 =?utf-8?B?TXoxMmQ5M2hnK1c2UUpQTlV0Tm4rcFl0d2RzVjVaWUlFcGdGelZkZFJDYmdR?=
 =?utf-8?B?R2FlVTAycTZ2aTBNemhsaURiVk04VWc1MTdmV1FYdEhIalpEZDVEd0lGb1k1?=
 =?utf-8?B?RmUvbGdSY2FLK1RVaU5CVHZMamRCTTJkTUY0c0Z6b3RkaFJ2aG83ZWR2UnV2?=
 =?utf-8?B?cUl3VGJyakMrZEM2MUJCRGVuWG9ndzFnaXdQZTcrMDdxOXU0Znd5NFlXeHpG?=
 =?utf-8?B?bGYrc2YrVGNuNzJjdHpyNGJrZm53ZlhzUGNZNDA1dnRtWnZ3bHdwbXBRc04w?=
 =?utf-8?B?dGdzWjZRMHZQWmZSQVVJUktHeElQUmhvUmh1Nm4ydWpWMEo2eTIzaHJhZlVX?=
 =?utf-8?B?WkdsT2RnVHFIWC9KczkxUTJ5WVBLekZ3L2wxUUJFV2hNblpEcDlFeXZ6SlNH?=
 =?utf-8?B?SGVtbE1HL1cwSzhpWFN0VVpXOGRZMDFWTzVnd2wvQWFBQkJ2VCtnY25vR0Rj?=
 =?utf-8?B?S1NYcTZNWUZ5ZTJJZk1qZkpTcFl0YkE4SW1NM3kvWE9EdURLVmxCNGZ0UVJz?=
 =?utf-8?B?VVFrYm40ekM0MEN2NlhaMWlBSXBWNWFIN2dCNHNqRnRoWjJZU2hlQ092R2po?=
 =?utf-8?B?WWs2QUo5RFNjRlNSeWdjMFNGdkNzcWl6QmhpQUJ5YUNJTHdqbDBDVlQrWkdI?=
 =?utf-8?B?MVhYUXl1RFVGMHpWWWwyNWh0V2RtVXpzeWUwaUZzN1RpU0hCZjhZNXpvUEti?=
 =?utf-8?Q?927xUh+mtSU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGk4WXdNdUpzSGtvei9Rakd0eEhtRURxNk8zSzYyYVFvckRnV2VwbkdYMDRN?=
 =?utf-8?B?TGJUditPYnM2L1hUWW1FRmFtQVJtT3JxRCtoL0VsVGhtSlh5VVZCZi9zbm9a?=
 =?utf-8?B?Z2x6ei95blltZWZOR2lFcU9qaTNROGhBMC8yRDBwMjlPSmhTbEcyRlhsZzRD?=
 =?utf-8?B?cEdiWTlwcUdjUWt6Zm5oeTNUUUhEcnZPZW5RMVlWVU0vNVdwUFY5Z2ppSHA2?=
 =?utf-8?B?aWdBN2d2YytSK2hFbWV3VDhRR3hobGFmOWRKT01lcHVmb3lYY21DOU9jUVBl?=
 =?utf-8?B?QzhrckFHcTVHbFdQSndObktLai9jczRGM1BTeU41VU5KcVUrRzhYMnFRWkRp?=
 =?utf-8?B?b0Vrb1pvTjRJd3VvYVd2cnljTUtsd1RxOW41Z1E4WjlxLzQ2V3FNRlpkQ2hK?=
 =?utf-8?B?Q1BUSVN0M2N0QXBnQkdvNjRIa1VxaUVoTUVtYXdyMzBnVENCazJLY2JTT1B2?=
 =?utf-8?B?MXFtcEZERCtzWkhOcVp1L2dsZitWejdwbC8vd3F4WGt0a1pTcEtGVzE3Q1dD?=
 =?utf-8?B?WVBPRDhWUE5oa2lxeXFGN1k0d0VGa0JuVXlacVZ0V0FHRFZJQTFFTmEzN0M2?=
 =?utf-8?B?SFFKeG5LaW9IY0J6Z3BuYXhjalpMMy9OQVpQYklMQnY3OVEvKy9FSzk2N3RU?=
 =?utf-8?B?cHJXRWVOYjVmcHhWc1ZlWXFSamUzdXR2OEcrUjVsY3p0NW8yYWVSU0NCOXJF?=
 =?utf-8?B?bGN1NkJpWlJSTGdmK0h1N1p1K1pzZHlzYURnNktvNzVZK1NqSnBmUFAwR08y?=
 =?utf-8?B?eDVKTXFTQjhKUGV4VDhSeHg1aGJCT01XbzdXaE5tR05iYW9reDV2cVU4OHZa?=
 =?utf-8?B?QUlJdVFZSGpZVDIvU1FFV1lhVDdGSGUzaWhrbWdzc2F1akMzMXZpOFVhYWY0?=
 =?utf-8?B?UjVNdFJEemg0RTNVeTNVNytpTlI2cFVrU1VMaFk4d2dYSmZvTExXNFY4VHBK?=
 =?utf-8?B?bjNDQUpoblRIT2p4bmZ3TjFjb1JhRDRtRFcrcnJsVDkxY3A5bGk1ZFZodjhK?=
 =?utf-8?B?VkFiZjhxb0dtQWk1L1RKZGR3MlRlWDNlMXFTNVhxS1Y5T01sNkN6bFRnOElD?=
 =?utf-8?B?ZnRVeUNocXhST2thWldkeFBFd2g3NVJ1RFVVYy8ySDNvbE1hL2d5UlNUTHhH?=
 =?utf-8?B?NTFGeG5pNG5wVyticisrVldNMVJhdXAxVWNha2NGc01WcFpDelBLbjV5dzlo?=
 =?utf-8?B?RWZwaVZ4OVlDRXZuNWRCN0JLdEM4T3JvMm5oTFJpbGZnekExUUpxU3dQYktD?=
 =?utf-8?B?djlBUWpCdllzT1ZGakl2TVFUT3h5V29SakZsSEsrK1pnTEFJMUVIclc5Lzlh?=
 =?utf-8?B?d0FMQk15V29RQzVzUXM3Ni9uQVlldFY2ME1mcHd3VC93YXI2UGx0dW5mdDhN?=
 =?utf-8?B?TExjOU0zeWNUOXBFK0duejBDK2Z3Ym9zMUNXWDVxbnJFZ2RxdVRmVjdGNkJp?=
 =?utf-8?B?MTZaWUsxWnZMbDFPY2o4ZGkzZUVNZGlrZ2UvYkxRd3IyNUQ1NXZPUkVsR1Fk?=
 =?utf-8?B?T214ZnRiZHFhQmZmQ3VZNlp6WVl0bHNtbnlkZ1BtUUNNMzB6SGVHU09uVEhv?=
 =?utf-8?B?b3l0R2p3c21VNkRpMHNwbkNsenNYRUhLSUhONi9EYlRVUTlGSWhHMGltTnQz?=
 =?utf-8?B?L2pXRUhNN29oL1pOTHNQVk5xYWVDTU9sc004SUxOdmVXTkNyYWlPSW9MeTR6?=
 =?utf-8?B?QytZbDhzRW94L0NrT0s4dGhuWXAvcEhlS1FBN0ZZS0NCUC9mak1uckJIa1Bz?=
 =?utf-8?B?YTd6L281WjVMUjNPQk5HOTJ1ZEhhNGRlR2ZTbjV4YlVid1RlNE5rUjNDRlN0?=
 =?utf-8?B?SFlKdHNYbzFBNnh1L1lIUTZiZEpJWmJxc0J4NnExcUh5cEJoVVlyMXI1R1FK?=
 =?utf-8?B?SGF2aS9SZDljaWxRb21scFk4Q044VTIwTUozSkI4d0lNVnVYZ3JtOU9vWExn?=
 =?utf-8?B?UjZveUpMMlJnL1VMbWJ5U0F5VGhJb3ZZWkxOT1E4ZzhpUnJSanE0QmlqUDcw?=
 =?utf-8?B?Zmp6MVRvb1EycXVtUlhUOWJqZ1FjRTNwMkhjL2k3cllIOUlDdjNRNllFZ3hz?=
 =?utf-8?B?RDNTVXgzS3BYRjl4MDBlbFdZZnJUZU01OWRMZW4vUVd3VnQwbU1Lam1KbHRI?=
 =?utf-8?Q?aCzxABtqFhifKkxeWFTu4yjMe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40deb957-44eb-4f3a-985a-08dd833b717e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 14:22:28.8930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZnqCDr7EdEmAhAPuJcQfZe9Io/AxkJaJX9pOLvJNqkEHtHi9vQZYnmfhxwbN1p8YHavC4HYduRAAhFLmKjHLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094



On 4/23/2025 11:35 AM, Jonathan Cameron wrote:
> On Wed, 26 Mar 2025 20:47:07 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
>> handling. Follow similar design as found in PCIe error driver,
>> pcie_do_recovery(). One difference is that cxl_do_recovery() will treat all
>> UCEs as fatal with a kernel panic. This is to prevent corruption on CXL
>> memory.
>>
>> Copy the PCIe error handlers merge_result(). Introduce PCI_ERS_RESULT_PANIC
>> and add support in the merge_result() routine.
>>
>> Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the
>> first device in all cases.
>>
>> Copy report_error_detected() to cxl_report_error_detected(). Update this
>> function to populate the CXL error information structure, 'struct
>> cxl_prot_error_info', before calling the device error handler.
>>
>> Call panic() to halt the system in the case of uncorrectable errors (UCE)
>> in cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use
>> if a UCE is not found. In this case the AER status must be cleared and
>> uses pci_aer_clear_fatal_status().
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/ras.c | 92 +++++++++++++++++++++++++++++++++++++++++-
>>  drivers/pci/pci.h      |  2 -
>>  include/linux/pci.h    |  5 +++
>>  3 files changed, 96 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index eca8f11a05d9..1f94fc08e72b 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -141,7 +141,97 @@ int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_create_prot_err_info, "CXL");
>>  
>> -static void cxl_do_recovery(struct pci_dev *pdev) { }
>> +
>> +static pci_ers_result_t merge_result(enum pci_ers_result orig,
> Rename perhaps to avoid confusion / grep clashed...
Ok. I'll rename to cxl_merge_results().
>> +				     enum pci_ers_result new)
>> +{
>> +	if (new == PCI_ERS_RESULT_PANIC)
>> +		return PCI_ERS_RESULT_PANIC;
>> +
>> +	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
>> +		return PCI_ERS_RESULT_NO_AER_DRIVER;
>> +
>> +	if (new == PCI_ERS_RESULT_NONE)
>> +		return orig;
>> +
>> +	switch (orig) {
>> +	case PCI_ERS_RESULT_CAN_RECOVER:
>> +	case PCI_ERS_RESULT_RECOVERED:
>> +		orig = new;
>> +		break;
>> +	case PCI_ERS_RESULT_DISCONNECT:
>> +		if (new == PCI_ERS_RESULT_NEED_RESET)
>> +			orig = PCI_ERS_RESULT_NEED_RESET;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return orig;
>> +}
>> +
>> +static void cxl_walk_bridge(struct pci_dev *bridge,
>> +			    int (*cb)(struct pci_dev *, void *),
>> +			    void *userdata)
>> +{
>> +	if (cb(bridge, userdata))
>> +		return;
>> +
>> +	if (bridge->subordinate)
>> +		pci_walk_bus(bridge->subordinate, cb, userdata);
>> +}
>> +
> Trivial but seems there are two blank lines where one will do.
Ok

-Terry

>> +
>> +static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
>> +{
>> +	struct cxl_driver *pdrv;
>> +	pci_ers_result_t vote, *result = data;
>> +	struct cxl_prot_error_info err_info = { 0 };
>> +	const struct cxl_error_handlers *cxl_err_handler;
>> +
>> +	if (cxl_create_prot_err_info(pdev, AER_FATAL, &err_info))
>> +		return 0;
>> +
>> +	struct device *dev __free(put_device) = get_device(err_info.dev);
>> +	if (!dev)
>> +		return 0;
>> +
>> +	pdrv = to_cxl_drv(dev->driver);
>> +	if (!pdrv || !pdrv->err_handler ||
>> +	    !pdrv->err_handler->error_detected)
>> +		return 0;
>> +
>> +	cxl_err_handler = pdrv->err_handler;
>> +	vote = cxl_err_handler->error_detected(dev, &err_info);
>> +
>> +	*result = merge_result(*result, vote);
>> +
>> +	return 0;
>> +}
>> +
>> +static void cxl_do_recovery(struct pci_dev *pdev)
>> +{
>> +	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
>> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>> +
>> +	cxl_walk_bridge(pdev, cxl_report_error_detected, &status);
>> +	if (status == PCI_ERS_RESULT_PANIC)
>> +		panic("CXL cachemem error.");
>> +
>> +	/*
>> +	 * If we have native control of AER, clear error status in the device
>> +	 * that detected the error.  If the platform retained control of AER,
>> +	 * it is responsible for clearing this status.  In that case, the
>> +	 * signaling device may not even be visible to the OS.
>> +	 */
>> +	if (host->native_aer) {
>> +		pcie_clear_device_status(pdev);
>> +		pci_aer_clear_nonfatal_status(pdev);
>> +		pci_aer_clear_fatal_status(pdev);
>> +	}
>> +
>> +	pci_info(pdev, "CXL uncorrectable error.\n");
>> +}
>>  
>>  static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>>  {
>


