Return-Path: <linux-pci+bounces-32893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB4FB11046
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 19:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEFE4E6B53
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 17:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284802E3AE0;
	Thu, 24 Jul 2025 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BZC6Ymt3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D512EA46F;
	Thu, 24 Jul 2025 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753377687; cv=fail; b=AOcEyk+w2NA+eauk1EoijpZVCh8RGeATwe7vW+s6D4J5INfwGmY6m3BNj+FjVnOl3/QJyhVOFC7949fKyqxu/OIv0VzoB7GYDShFQgcN5N2te4hJYNKPaqJwZP+9Gy1aTRyxKeDspBIrxrSiCIj15/gt63QEHF6MqqThsi4eGYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753377687; c=relaxed/simple;
	bh=P71YDKM16ezeKMJ1HUWcmFZ7G+HXUrYjO2G66zzbonk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UEbdYoYTIPUrLbnKjSO73zCubkoxinlXZSNnERI49/yRMcLFmu732XRJAXwpJ9K5mq1M1hp7SE+mknRo5CXEvyoFdbeQ0L4LCo6rHJeA6E7CmpXUHjqzhkpvw967GEL0dtNl3wHKcdDhlMicy2cXPHGVFKAbEGrvmzxzLSm9C0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BZC6Ymt3; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPySkJvGxmbf9P/I011jbJm3j4lBopjPzbufpeEMSoTi3Ve+dnjFyXZSFV2rzuUjd/g1gZXC94dvZ+Cx+OcF1jF/Njx1pElCDhAdE57scL7UiDnCN/YD+Fl/PfGsnhxf09aqyr0nJdApZZh8u2CGPzihN7qEylFYoOhEIN6kQIKsSoGowlHNG1YNvHh7a9wkP6R2bb+0PLwr/xijZPAZKOoWIbAYbtNBgZcysPTxJ1dI8WclpLq3iZZ2WWIEVnO+i0nCJ0R4ZphTFUffx4Qfhgpl/CCmWZgSr0fDqMfVdbxrAN26mumb32qGoFKe/fk7fnJXwbSkkhmoUkj7bzjTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oq148THKxOKkJz7nghSWBtjJVuhU7Wo51DF4B5Y6UF8=;
 b=S9SxE3xbKlq0QC9pd8JXk6HqFsSeRCOxUUy8M8nWZ0c8ZdvlEJslhjpJDRyf5BJlGrqmUmuAZyKBIR8NqVTUYCeOzQ2FxJIiK1VIMyfC538q1FZ+x5uHURNRBQb1LCx7liXtc1I5J68XGMNWjdlLH9eGQQQ4DLyAns/pGYbRPeJgZ9Np1WiSMUV5+3olYKvxqzkA/Y3xVuDRwNW1LPu69GlZxIzVo8o7pXtJSYpRBLukTv17h+dc0DIl6eQmm/f2dTn/DcOVxCHA2mZzJ3Cc/qVUApk20AV8vTrczCUkAJlgPdSwt192QvhrPlQ0gvX/PfEBOoCWpxU1i1EGzqVL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq148THKxOKkJz7nghSWBtjJVuhU7Wo51DF4B5Y6UF8=;
 b=BZC6Ymt3BIjDY1evXehk9J7EMEUYB7fce3OyXDDOuQYHJIDHPMPzuPWW7Im5LO47D0ACDEbuy3QQNsjUdpMHYAS/wZchtBp9h30aBnAvBVPO72ip1hXJLW+loKNYDjEPTY1Wvf8DmvXIntWQCGVm/Vxg+OsZ4Iy2ai0Otv37BuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Thu, 24 Jul 2025 17:21:20 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 17:21:20 +0000
Message-ID: <3734d11a-724e-4478-afab-27e7d3d9c95c@amd.com>
Date: Thu, 24 Jul 2025 12:21:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/17] CXL/AER: Introduce kfifo for forwarding CXL
 errors
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-6-terry.bowman@amd.com>
 <688193f446411_134cc71007b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <688193f446411_134cc71007b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:806:28::31) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a13f0b-8e1a-413a-e12b-08ddcad681ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkhWZTBLcUxoemlwV1lNTGQ2cXFHUnRBVVU5RlI3THViM3pkb0RIWU52UlV6?=
 =?utf-8?B?ZG0wR0VSbjk0MzFQMVVEbFRUeDBkQmhyWjhlUEZ5VHJWME11U0lMRGhwZzNS?=
 =?utf-8?B?QXpxRlRGLzBlcSswWFA3TlIrOUdyZ0NQS2gxc1FTdHBsWEFpKzBWdmlZTldz?=
 =?utf-8?B?WG1kcWRwTlJoaXYzVzl5N1lqaG4wTE90RytUM1BCcW8xcm52Zk9vZUJpUHJQ?=
 =?utf-8?B?Qzl5NDhod2wraEFxQ2ZaUFBoYXg0ZFBOazdXVnUxdXV0TmVuWkFUL09KUzBk?=
 =?utf-8?B?c0xuK3NwQlBJb0JUWkFsTmhSQU9xUHFDS0R3QUR6V05TNG83R09BU2l4SHEv?=
 =?utf-8?B?czVoUjIxSEYvcGtPWU9aZUZIYmxUR1BKMEJ4NmpGQzBqenBZbzB3dmtzUjg0?=
 =?utf-8?B?TXIyYW9hYUxRdkkraFo2VStaaEY3bkE1UzI2UGZKL2lIdkhCa3NNYTJBTzUx?=
 =?utf-8?B?aWdYSm9WSjhDNkoyNTdVbHdDYmNFQWtoMnZnSzI0cG5FbUVxNlV6ZTN0MDFn?=
 =?utf-8?B?TjNNN1R3V3U1blJtSjBmRjZTbXZwY1BNUUs5dlFpSGUyd0pEK1hvVXhBNHRs?=
 =?utf-8?B?dDFTTUVHMHh3REJWWmpSMDI3d1RzRm5DQ00ybk5xQlZaazA1TG43eEZYMC94?=
 =?utf-8?B?R2I3ZnRTTDg2TmRobHA3QkZ2V004UDFsaEJJMWRHc0FTTStlV0hPOW9zQjM4?=
 =?utf-8?B?cUZZVW5lZVpJVysvbzMrNGhFdDlQVC80Rit3N1A1YjFSWHNSMm1MVFc4dzBX?=
 =?utf-8?B?WUZPNzlFTDA3TVIzMjdvL2dtWWdKN3JVZnZKalQwZTRSNUJHblFKYU0vbUVs?=
 =?utf-8?B?YmZENXdYZjRaclJ6NWVJT252UDRhVElSdm1scU1qNVJLa2dpdFJPaTBQWFlv?=
 =?utf-8?B?WU4weFdIOXpBWDM4OXpVaUhEelV4eVlSY3pWTEwxOFdHR2FsdHd4UGI2c2RC?=
 =?utf-8?B?VXkyeVRQMVc1WFpSN0VyeVd0UGo1QW91dHY0em8rS3FoeWpMcU1rcTR0c3Nq?=
 =?utf-8?B?WkJoalY5OUs0d3dIYURablQ5WGsvTFpiUncwb1krZjhDbFFzSVNLN3poOFZB?=
 =?utf-8?B?N09GRjhTc20xcHFBMjlicHNxTU9hYTZRVmt0Ri9QS3UvNEJNdGU2T2Rrb0tD?=
 =?utf-8?B?QUNiTmxhTFhnM1htMS9lSUtEMjRONjd2VXp4ZDg4cmZpeGFUeWZvUkxjdjhY?=
 =?utf-8?B?NHM0K1J1RktZYW4yaXNXWk5ETTR5eXZldVYreVhFVitLYjlGR3ZjMU5HUW9t?=
 =?utf-8?B?c3VyclFTV1dxeHMxdG1zVzE5ekJMVWdEaEZNMkZhUzZQOERmYXczRVFRcVN3?=
 =?utf-8?B?WVZsVGtxeTRuNk95MFZnM2Zxd3h2WG1id3I5N1RKQk9GeUxmdHhlODk1WEZI?=
 =?utf-8?B?VzdYbnFQVnVvbmppSWdwTEphT1hzY1E5Vm9XTWpyZndsZWkzZFI4cVpqcHVh?=
 =?utf-8?B?MGIvVUhEUmZKRS9STkc5RHh2U25iNytYN2lJOEF0SmxDcFowa3RlTk0yQjFa?=
 =?utf-8?B?SFdZMWtTOW9qWmluN3JkdEJLQVpTMjArTkx5YXN4UFhOc0FOK3VaSXZ5WDBL?=
 =?utf-8?B?NEhTOFQ1V1F4bFVPZVdoZEJ4ay9ZTXd0cUlERk5MckwzOEw2dFlObzN4UEpK?=
 =?utf-8?B?SzJTQzRLb1VaY1dvSm1kTnJ0cDRNNnV1VkhlZGI0TzUwUEw4Y0FYWEhZUjlU?=
 =?utf-8?B?aGNwZmFCSTBvanRWbWFoSnZkVHBuWEN2V3p5SHZ5dXlJS1F0SmorcGhRemcr?=
 =?utf-8?B?Rm04aGpwZTA0TjR2OW41MzVRTEFEenVoTHlQd0JXZmFMZldVQ2thN2IwTXdM?=
 =?utf-8?B?VnFVSjg5REhIdWtnK2R0TTh2L0Zoa2ZkbG1BbmdmK285ZC9ObEx2T0FhWk5R?=
 =?utf-8?B?bVEvd3NIUlJRNXEzbUsxOU9zTVp2bzZzNElHRzV4S2s5anFnMEM5OEhlZnVS?=
 =?utf-8?B?N1VEWk9wMzZEY3d3NTlqL2c0bWxuSjFGM1JXdmMzS090dkRzcGVHWVdXZENY?=
 =?utf-8?B?U0UyTVJCbEVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUdvd3ErMDFmWFNyVXR1RFlFbmsrbGpzQVZTYlBsTmZyRmR6WEVaMERuRlZT?=
 =?utf-8?B?cjlUSlNESDhyeDB0WW1sVTIyR3oxN3l2Q3RZUmQ5ck9VaVBROFJhckhvOXNi?=
 =?utf-8?B?RUd3eW5ZTHVPSXQ3R2Q5bzR3dzdlRjQyc0tMN2o1djhKYW1kN3MvMVpZMlRX?=
 =?utf-8?B?bm03bW0xYnJNRWlCWnNqY1paTlg0SWYzQkxKR2FhZERGYkE3K09uZllpOHBQ?=
 =?utf-8?B?ZzgvOFUwdisxdExTVHdEcm5KbkVDUE5ldDBXRURQUGsyUkhnVFpzOVdJaTdq?=
 =?utf-8?B?WGxjdUJlYVB6U1hzUWpDcWtBZ1VHK0ZJYU1OVmlja04vOVdCWnh0NTlOZitG?=
 =?utf-8?B?VlRJcWQ1dTJOYXZzeXR4L09Gc3psYlNnY2VVS0NuOC9iNSthTXE1Wnhrd0s0?=
 =?utf-8?B?cDdWbFo1K1JWQUpUSXJhOEpzL25JNHZFWGpaNnRVeEtmRmRjWlhIcHA4Qkpu?=
 =?utf-8?B?SEpNbEZwdWltNHF4NndPdzF2Y0NTWDVnSDdLTE9JbExUZFlYSFNuYjY4MHZ2?=
 =?utf-8?B?SXZUamxLcDl2WXZ1MTdrc3UyYWFEYUhrLy9OTXlOa3Y0NitmL2JmaG5tYzBu?=
 =?utf-8?B?YjFOVHZMdTZ4QW9Mc3FOMi95K1MyYk9jMGVOL3F0cHZBdTl0a2FqSFNrdWxR?=
 =?utf-8?B?SWVVaUZrVDdPSEkxZ1ZEbVFDZ3JydkJwVVg4S29mQUc5aTc2VExvclhPM0tR?=
 =?utf-8?B?Z0lxTzVnemxQK2VycGcwVFdSVk5HQVhFZ2hMRVVqekRNbFZNUjJnYk5EbEFh?=
 =?utf-8?B?RkEwU1VpSE9JcXdIaHJYTng0ZTFvckxaMUcrSEFDeTJYa3BOUU50TnBiUHR5?=
 =?utf-8?B?QTBGSUZ2a2h0UXduMHhqMlFEQnA1SFEvQ1k5bmVFMTF5L1BOMjlCQThXYkNy?=
 =?utf-8?B?S2JzdHU1YjArdnZscG1aQlBuTjFLNC9LcEs2azFUUko5bTU0WGFxN0xJdHlk?=
 =?utf-8?B?d3hmMStHYUZ4aFovajFrQkx6dTl6aUxFbkg2SUU4QVVGR3Q5OTlrazV5Y0Jn?=
 =?utf-8?B?NDFVcnBVcmtXS3F0Y3JTeDFlVGd5SUNlT2E5bXFTamVWKzVNSVZ5VTZMM0hp?=
 =?utf-8?B?Ykx2TlVFMTBqbDBCV1RIVVRuN3I2ODV0WUJiVFB1cTFBc2c2aGQweE9kU21p?=
 =?utf-8?B?aHM3MVNPWFJPaGVZZTYwa2ZXblJKb3dPWkNaZDgzczdBMVBaNDltQnlINC9q?=
 =?utf-8?B?U1dVbHhEZS9nWkVDcjM3VmRna01ZL2hIc0d4MkRNeTduRjQzeGNyU21qZkxH?=
 =?utf-8?B?SERjL3F5d2krMG0rVVN1TkFjU3Z5RUtGcjNMOFczb3NFd0dLUU5kZmNBcmZJ?=
 =?utf-8?B?NDF0TVVKdFYxQkEyUFowbzJneDdmc2FJYVdhQW1PeFByTW1pMVVsTzBLSFZP?=
 =?utf-8?B?YXMwSjFkTGJIejhPLzRWOFAyWFFGY2RtUWNtSGltODhRRTU3M0hHeVhZMWt3?=
 =?utf-8?B?MFBoT2dFd2RrTkQvTzk2S1BYSWNLVm1yeWNDdERYVEFmZzY2cFBicVoyNXN5?=
 =?utf-8?B?bjVucGp1K2JxdmZBbWoyZ3prVGtXN1RrR2d5akExZlpBVnVnbmR5ZUdGTDhY?=
 =?utf-8?B?clFUbnkxTjRDUjVFRGs3aW4xOTloYTJic1pMWDhMSHNKQ1p2UHdPRTNKTWdo?=
 =?utf-8?B?UzZNaWk3NFovajJkTkt0bmRKSWgxbUZmZWc3VTBDZ1J4NGk5M3laZWVEdmc1?=
 =?utf-8?B?aXFkYzJMVU5TdUpIQTRuem9ubEZuNUxhcDhOU0hPcWQxbWlPUFowT01yUHBE?=
 =?utf-8?B?bGdFRDNDdEl1SVZ0ckRzbm5WNVRrMTAwYzk0K1VkK2NrbUJUOUtqRGlNc1ZY?=
 =?utf-8?B?TlVyNURvNzBTRnlMK3BGUm1hQTRLbk00NWU4cWNrNHZEWWg3MWUwOUhaUi9E?=
 =?utf-8?B?MlRRZXNkeUxCajFhVnBsUk5uaEM4S3kzUEtoY1o2MWRuaTZOYWdCM3BVemln?=
 =?utf-8?B?RHpTTUhJbS91V1JUTzJEYlJwWDJ2SnZxTmp4MVZtU21vZWZXQzgvbUFGcWI2?=
 =?utf-8?B?TXNnQXFQSEhkVEdPSE9KT0J0a2ZkbnVLSUkzMzVGd1o0M0hrTml0MkV4STZ5?=
 =?utf-8?B?UzVuS1ZHem1QVXpqeTk3VUllNzRQeWk5Mk43bmQveGZwR1A1dkd2c2pNL2Fy?=
 =?utf-8?Q?5OsmtfA0mxnrWsl5/ghjD8/RV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a13f0b-8e1a-413a-e12b-08ddcad681ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 17:21:20.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rU8oEOrM38MHa64V1HxGd21w9e9CInkP+yN7WEdK3sMGct87ThOYF3S2R2qCLMwIv4eArs6/z3HQbK0vYBujaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719



On 7/23/2025 9:01 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> CXL error handling will soon be moved from the AER driver into the CXL
>> driver. This requires a notification mechanism for the AER driver to share
>> the AER interrupt with the CXL driver. The notification will be used
>> as an indication for the CXL drivers to handle and log the CXL RAS errors.
>>
>> First, introduce cxl/core/native_ras.c to contain changes for the CXL
>> driver's RAS native handling. This as an alternative to dropping the
>> changes into existing cxl/core/ras.c file with purpose to avoid #ifdefs.
>> Introduce CXL Kconfig CXL_NATIVE_RAS, dependent on PCIEAER_CXL, to
>> conditionally compile the new file.
> I see no daylight between CXL_NATIVE_RAS and PCIEAER_CXL, one of those
> needs to subsume the other. I also do not understand the point of
> "NATIVE" in the name. Will not CPER notified protocol errors be routed
> to the same CXL error handling infrastructure as AER notified protocol
> errors? I.e. the aer_recover_queue() path?

This change and comment is planned to be removed in v11. Instead of introducing this 
as a new file. The same changes will instead be added to pci_aer.c/pci_ras.c Dave Jiang
is introducing here:

https://lore.kernel.org/linux-cxl/20250721170415.285961-1-dave.jiang@intel.com/
>> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
>> driver will be the sole kfifo producer adding work and the cxl_core will be
>> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
>>
>> Add CXL work queue handler registration functions in the AER driver. Export
>> the functions allowing CXL driver to access. Implement registration
>> functions for the CXL driver to assign or clear the work handler function.
>>
>> Introduce 'struct cxl_proto_err_info' to serve as the kfifo work data. This
>> will contain the erring device's PCI SBDF details used to rediscover the
>> device after the CXL driver dequeues the kfifo work. The device rediscovery
>> will be introduced along with the CXL handling in future patches.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/Kconfig           | 14 ++++++++
>>  drivers/cxl/core/Makefile     |  1 +
>>  drivers/cxl/core/core.h       |  8 +++++
>>  drivers/cxl/core/native_ras.c | 26 +++++++++++++++
>>  drivers/cxl/core/port.c       |  2 ++
>>  drivers/cxl/core/ras.c        |  1 +
>>  drivers/cxl/cxlpci.h          |  1 +
>>  drivers/pci/pci.h             |  4 +++
>>  drivers/pci/pcie/aer.c        |  7 ++--
>>  drivers/pci/pcie/cxl_aer.c    | 60 +++++++++++++++++++++++++++++++++++
>>  include/linux/aer.h           | 31 ++++++++++++++++++
>>  11 files changed, 153 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/cxl/core/native_ras.c
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 48b7314afdb8..57274de54a45 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -233,4 +233,18 @@ config CXL_MCE
>>  	def_bool y
>>  	depends on X86_MCE && MEMORY_FAILURE
>>  
>> +config CXL_NATIVE_RAS
>> +	bool "CXL: Enable CXL RAS native handling"
>> +	depends on PCIEAER_CXL
> This nice helpful option is hidden if someone forgets to set the
> PCIEAER_CXL option which does not have helpful text. Given the
> dependencies, I am leaning towards drop this new option, move the
> help text to PCIEAER_CXL... but let me read the rest of the patch first.
>
> You can move PCIEAER_CXL to drivers/cxl/Kconfig if you want to keep all
> the CXL options in the CXL menu.
>
>> +	default CXL_BUS
>> +	help
>> +	  Enable native CXL RAS protocol error handling and logging in the CXL
>> +	  drivers. This functionality relies on the AER service driver being
>> +	  enabled,
> No need to put dependencies in the help text the tool will tell them
> that PCIEAER=y is a dependency.
>
>>         as the AER interrupt is used to inform the operating system
>> +	  of CXL RAS protocol errors. The platform must be configured to
>> +	  utilize AER reporting for interrupts.
> Per above, does any of CXL CPER reporting make its way into this path?
>
>> +
>> +	  If unsure, or if this kernel is meant for production environments,
>> +	  say Y.
> I think: "If unsure, say Y" is sufficient.
>
>> +
>>  endif
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 79e2ef81fde8..16f5832e5cc4 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -21,3 +21,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
>>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>> +cxl_core-$(CONFIG_CXL_NATIVE_RAS) += native_ras.o
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 29b61828a847..4c08bb92e2f9 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -123,6 +123,14 @@ int cxl_gpf_port_setup(struct cxl_dport *dport);
>>  int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>>  					    int nid, resource_size_t *size);
>>  
>> +#ifdef CONFIG_PCIEAER_CXL
>> +void cxl_native_ras_init(void);
>> +void cxl_native_ras_exit(void);
>> +#else
>> +static inline void cxl_native_ras_init(void) { };
>> +static inline void cxl_native_ras_exit(void) { };
>> +#endif
>> +
>>  #ifdef CONFIG_CXL_FEATURES
>>  struct cxl_feat_entry *
>>  cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
>> diff --git a/drivers/cxl/core/native_ras.c b/drivers/cxl/core/native_ras.c
>> new file mode 100644
>> index 000000000000..011815ddaae3
>> --- /dev/null
>> +++ b/drivers/cxl/core/native_ras.c
>> @@ -0,0 +1,26 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/aer.h>
>> +#include <cxl/event.h>
>> +#include <cxlmem.h>
>> +#include <core/core.h>
>> +
>> +static void cxl_proto_err_work_fn(struct work_struct *work)
>> +{
>> +}
>> +
>> +static struct work_struct cxl_proto_err_work;
>> +static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
>> +
>> +void cxl_native_ras_init(void)
>> +{
>> +	cxl_register_proto_err_work(&cxl_proto_err_work);
>> +}
>> +
>> +void cxl_native_ras_exit(void)
>> +{
>> +	cxl_unregister_proto_err_work();
>> +	cancel_work_sync(&cxl_proto_err_work);
>> +}
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index eb46c6764d20..8e8f21197c86 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -2345,6 +2345,8 @@ static __init int cxl_core_init(void)
>>  	if (rc)
>>  		goto err_ras;
>>  
>> +	cxl_native_ras_init();
>> +
>>  	return 0;
>>  
>>  err_ras:
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 485a831695c7..962dc94fed8c 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -5,6 +5,7 @@
>>  #include <linux/aer.h>
>>  #include <cxl/event.h>
>>  #include <cxlmem.h>
>> +#include <cxlpci.h>
>>  #include "trace.h"
>>  
>>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 54e219b0049e..6f1396ef7b77 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -4,6 +4,7 @@
>>  #define __CXL_PCI_H__
>>  #include <linux/pci.h>
>>  #include "cxl.h"
>> +#include "linux/aer.h"
>>  
>>  #define CXL_MEMORY_PROGIF	0x10
>>  
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 91b583cf18eb..29c11c7136d3 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -1032,9 +1032,13 @@ static inline void pci_restore_aer_state(struct pci_dev *dev) { }
>>  #ifdef CONFIG_PCIEAER_CXL
>>  void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
>>  void cxl_rch_enable_rcec(struct pci_dev *rcec);
>> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
>> +void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info);
>>  #else
>>  static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
>>  static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
>> +static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
>> +static inline void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info) { }
>>  #endif
>>  
>>  #ifdef CONFIG_ACPI
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 0b4d721980ef..8417a49c71f2 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1130,8 +1130,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  
>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>  {
>> -	cxl_rch_handle_error(dev, info);
> No, can not just drop what was working before, even if you restore the
> functionality in a later patch in the same series.
>
> I would expect that this patch at a minimum maintains RCH handling and
> forwards anything else to the CXL core for VH handling.

You want RCH handling to stay here in the AER driver or does the patch changes need 
to be reworked to present the change better?

>> -	pci_aer_handle_error(dev, info);
>> +	if (is_cxl_error(dev, info))
>> +		forward_cxl_error(dev, info);
>> +	else
>> +		pci_aer_handle_error(dev, info);
>> +
>>  	pci_dev_put(dev);
>>  }
>>  
>> diff --git a/drivers/pci/pcie/cxl_aer.c b/drivers/pci/pcie/cxl_aer.c
>> index b2ea14f70055..846ab55d747c 100644
>> --- a/drivers/pci/pcie/cxl_aer.c
>> +++ b/drivers/pci/pcie/cxl_aer.c
> With the RCH bits moved to its own file then this file would be 100%
> concerned with typical CXL VH error handling and deserve to carry the
> "cxl_aer.c" name.
The plan was to move all the handling to cxl/core/pci_aer.c or whatever it is renamed.
>> @@ -3,8 +3,11 @@
>>  
>>  #include <linux/pci.h>
>>  #include <linux/aer.h>
>> +#include <linux/kfifo.h>
>>  #include "../pci.h"
>>  
>> +#define CXL_ERROR_SOURCES_MAX          128
>> +
>>  /**
>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>   * @dev: pointer to the pci_dev data structure
>> @@ -64,6 +67,19 @@ static bool is_internal_error(struct aer_err_info *info)
>>  	return info->status & PCI_ERR_UNC_INTN;
>>  }
>>  
>> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>> +{
>> +	if (!info || !info->is_cxl)
>> +		return false;
>> +
>> +	/* Only CXL Endpoints are currently supported */
>> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC))
>> +		return false;
>> +
>> +	return is_internal_error(info);
>> +}
>> +
>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>  {
>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>> @@ -136,3 +152,47 @@ void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>  	pci_info(rcec, "CXL: Internal errors unmasked");
>>  }
>>  
>> +static DEFINE_KFIFO(cxl_proto_err_fifo, struct cxl_proto_err_work_data,
>> +		    CXL_ERROR_SOURCES_MAX);
>> +static DEFINE_SPINLOCK(cxl_proto_err_fifo_lock);
>> +struct work_struct *cxl_proto_err_work;
> Please make this one combo object with one registration entry point. 
>
> struct cxl_prot_err_work {
>         struct work_struct work;
>         DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
>                       CXL_ERROR_SOURCES_MAX);
> };      
>
> Bonus points to go back and clean up the CPER code to do the same to
> reduce the amount of "registration" APIs.

Ok.

>> +
>> +void cxl_register_proto_err_work(struct work_struct *work)
>> +{
>> +	guard(spinlock)(&cxl_proto_err_fifo_lock);
> This lock acquisition is not protecting anything. 'unsigned long'
> assignments are already atomic and forward_cxl_error() looks like it
> happily de-references NULL pointers without checking the lock.
>
> I would make it an rwsem. Hold the rwsem for write at registration /
> unregistration...

Ok.

>> +	cxl_proto_err_work = work;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_register_proto_err_work, "CXL");
>> +
>> +void cxl_unregister_proto_err_work(void)
>> +{
>> +	guard(spinlock)(&cxl_proto_err_fifo_lock);
>> +	cxl_proto_err_work = NULL;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_proto_err_work, "CXL");
>> +
>> +int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd)
>> +{
>> +	return kfifo_get(&cxl_proto_err_fifo, wd);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_proto_err_kfifo_get, "CXL");
>> +
>> +void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info)
>> +{
>> +	struct cxl_proto_err_work_data wd;
>> +
>> +	wd.err_info = (struct cxl_proto_error_info) {
>> +		.severity = aer_err_info->severity,
>> +		.devfn = pdev->devfn,
>> +		.bus = pdev->bus->number,
>> +		.segment = pci_domain_nr(pdev->bus)
>> +	};
> ...hold the rwsem for read when de-referencing a 'struct
> cxl_prot_err_work *'
>
>> +
>> +	if (!kfifo_put(&cxl_proto_err_fifo, wd)) {
>> +		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");
> In the case that 'struct cxl_prot_err_work *' is NULL, perhaps this
> should be a dev_warn_once() to say "hey, we're seeing CXL errors, but
> nobody registered the CXL core!?".

Ok.

>> +		return;
>> +	}
>> +
>> +	schedule_work(cxl_proto_err_work);
>> +}
>> +
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 02940be66324..24c3d9e18ad5 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -10,6 +10,7 @@
>>  
>>  #include <linux/errno.h>
>>  #include <linux/types.h>
>> +#include <linux/workqueue_types.h>
>>  
>>  #define AER_NONFATAL			0
>>  #define AER_FATAL			1
>> @@ -53,6 +54,26 @@ struct aer_capability_regs {
>>  	u16 uncor_err_source;
>>  };
>>  
>> +/**
>> + * struct cxl_proto_err_info - Error information used in CXL error handling
>> + * @severity: AER severity
>> + * @function: Device's PCI function
>> + * @device: Device's PCI device
>> + * @bus: Device's PCI bus
>> + * @segment: Device's PCI segment
>> + */
>> +struct cxl_proto_error_info {
>> +	int severity;
>> +
>> +	u8 devfn;
>> +	u8 bus;
>> +	u16 segment;
>> +};
>> +
>> +struct cxl_proto_err_work_data {
>> +	struct cxl_proto_error_info err_info;
>> +};
> Why not use cxl_proto_error_info directly?
At one point I thought there was a good reason for using it later in another case.
I'll use cxl_proto_error_info directly.

-Terry


