Return-Path: <linux-pci+bounces-31317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904F0AF6470
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 23:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6B91C27746
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 21:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500392405FD;
	Wed,  2 Jul 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FC1/cHDj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D5823C4EA;
	Wed,  2 Jul 2025 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493384; cv=fail; b=BVU+Dvau3h/LqW4nT+WUnDWm17Qrnf35CiYX9d2cXNCxnFZj7NDIAxKKSwDUa9IUmMw7WkOdo/ExpD2koMpz1Z48tWrjFj9C3W1ajDcHZT5n56e+jzVk46RW0O0s6Oez2mUrqvvJ7YQjaplZ+jJkJ+sT22HTv/eiPLBpnaaPYFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493384; c=relaxed/simple;
	bh=US2FoiAGFZuBCZic78IkjbMv6qR06H7vAI6uQ7wvK2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b+MU1p2i9YpZCl+lcto95i2N4jo3b2Vu9RU1P3DpC+nYe6LtGHNvBK8fm5MIzolHtNnzKb2HvGB+3948VKr7cbNeC0WVIqqhP68qaIiMnvA2/0L03l516kmoWM2ibkJXj0KVJZUHbavc48cYcd2ywc+1FP/e+MA1RcerORPRguA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FC1/cHDj; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJoAGwLB81J15+gfQN+7kX7oZl/iW3DZxCszbQFIXJ8eKS4LM7t0eAI8kjrDpE4bFsnhJCrhCqVmqFbn1o6HrIE51sNQnF/18j6BBqI1BFgFQRHp1FdEx2mPrreqDOGR4ACyKnAKv11cRXCOFMHeIWfqmnAXsaFbeJPN2wiyOQsIX+A421BQkdZfTcEuApQ5ifQpTHF3fKnCpMXC0GTWsjMLjth5VGUWmXz4eJrZrpKOf5sHuth910I8AQLNIeeAaLmBDwgJ/Y2pcHm7VyB79F4DLaLJQGgbetiUeEobCTSBs2EWNUwA/AZZhKslX2Umg+T/VA0qvMhCLemj2UpNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pgops0njKwOGn2PaXeRAzJCa08yHIQONeyXIZEC9sjg=;
 b=kR8FoNqBWtGOt9BMMkRNbyzqZIpzn+1uRqFZceYxVM6k+mGqg+lBcKBpfXSFHEIHjRV5nZzVdDcbdYWdwv8C1rRVuVbVliVrHLsCLYGTSPrGE/OdtP7/s8VHmLj+DBL9m0jCXkU571pkYhcFssbsm0IYeY+z5CitFryzdP9ZRoI9FrI5Rt2o6xdjMEOEuYfxQd67LI94XSBjffly3Kape50xOcKJSj4eLI0OAcZBcDYhWvXwVETIHp/Z5X8okZxO9c+1tVZECXmqLCS4TH+5YmTjVL8mNHCHVbsjZo8Ws/yi9XQaKAu9aX5aDhfcT6ARLgUCFeZlzTmUWwZRLZVdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgops0njKwOGn2PaXeRAzJCa08yHIQONeyXIZEC9sjg=;
 b=FC1/cHDjM24IfD/zLlhYjS8Qn2qEw35h6exAYJVusApWyd1FDNA9k8vsWyA5j2P6CfGIq0PtS1dBX2CcpByP6POvnn6UYWKzICgbADvCLGt44w+VQjnwcpQ4Wha/DIA2MpP9xmc0nkNXpFW//ZzLLTwIvu+lRqvFq9TZGrqLw40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 2 Jul
 2025 21:56:19 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 21:56:19 +0000
Message-ID: <cc98e985-3c91-403a-8317-c160128fd5c7@amd.com>
Date: Wed, 2 Jul 2025 16:56:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/17] cxl/pci: Unify CXL trace logging for CXL
 Endpoints and CXL Ports
To: Shiju Jose <shiju.jose@huawei.com>, "dave@stgolabs.net"
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "ming.li@zohomail.com" <ming.li@zohomail.com>,
 "Smita.KoralahalliChannabasappa@amd.com"
 <Smita.KoralahalliChannabasappa@amd.com>, "rrichter@amd.com"
 <rrichter@amd.com>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
 "PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>,
 "lukas@wunner.de" <lukas@wunner.de>,
 "Benjamin.Cheatham@amd.com" <Benjamin.Cheatham@amd.com>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-13-terry.bowman@amd.com>
 <6b8b65df7c334043863b1464e04957db@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6b8b65df7c334043863b1464e04957db@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:806:f2::22) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 567d6058-93a0-4616-0b0d-08ddb9b34649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHZrU2lvTHc4aXdoby9va1RjRERmSHI2U0Q1VENCek80RkdEOUJsNkhSQmVz?=
 =?utf-8?B?U0svWEd3L0djNklGbkloZVppWStuWklzSWJWQ1FPaTVNUU5RNEltVTNMbXBM?=
 =?utf-8?B?RXc4TFJJTlE3dTBjZERCd082VW5wWUdvekJXVXFrTHZsdDB4ZkRPcFhUdWpj?=
 =?utf-8?B?YlJXMGRoRUNNcUxES1pPMGtBa212SFRpc0FER1FMemFISUJkSERiZjJzS0N1?=
 =?utf-8?B?OXhwdEcvYXVySk1KMjArVTZPK2UwbmlId1l4bW4wU3M5RXlKUDFzdjY3NVg1?=
 =?utf-8?B?ajZrYURUYWtCazBzbHdXRXd5djNNU0pkdnlpUndVNTNxaWErSlM3cTFEWndV?=
 =?utf-8?B?Vy9ZL2hRc3NUSUlPYUF2YU5tU1N1b29xam9LM2FSUEMzR01NSFR6T05kZ3M3?=
 =?utf-8?B?dTlEM1pQMWJzRzZpamFWQkJtaGs4WjZNVVJjdWRsS3pNQitkQTRSdjQrRngw?=
 =?utf-8?B?OHF2T1JjMk82SVZoRkttaXp6SmdTWlFRNUpZSmdWZWl1Nm54QmdGYnBwZzZt?=
 =?utf-8?B?M01OS0RMK1hXV1BLakhOVytZVk54QzhBemI5WXE2Tlc1S3ppYTYwNytZRVZD?=
 =?utf-8?B?MGkrclR2L3NWeWNrdEhuL0hsdkFEcjIyL2xMelNhQTc5K1MvOE5COExMUHZl?=
 =?utf-8?B?RE9GSTQ0bTVQMnVUM3hncHJNUWdoNVRoWTJyWlZ5aDFzdkx3VXdLSktES21z?=
 =?utf-8?B?cjZYSjQ0anlzZzRQUjRlbjMzc2k4bGRXVVlvZWZKQjBZdUJQdmlXNVFUNld6?=
 =?utf-8?B?R01JZXFySkgyYzdHSTMwREhWVzAvYndSK0RUbCtWK21QMzhQc0tPMkgwYnFP?=
 =?utf-8?B?bE9Pd0czbVBpeGwwUVhTc0NZT1ZzQW5pRVlCYXNvNFVER1Npa0NTVnlrc0dp?=
 =?utf-8?B?S2lZdlFya3JTN0VMaVRKODU0S2daSnZrcU4xRFhLOGVwRnZlK1p1RWFIbkRu?=
 =?utf-8?B?RS9zMzJ5WFM4dVpWYlB6NHJSaGcySXdhZXdUMGVrcXVmVG5qaVhLczhOdkFi?=
 =?utf-8?B?K0QyanI0d0dmcFpxM0J4YWp4d2hjU0ZOdnJTTE9vSWdOVytrcHRoaVFuM2Z5?=
 =?utf-8?B?cXNHVFQ3OWxGWWlpR2xzZEVUNDIrQzRUZEZXL1Y4T1lOVkF3VGdLUzZkQzJO?=
 =?utf-8?B?aENQQXplZGlNMVZTd093L3dUa28wbHhqVEpDOThTZ2dlUlB4Q0Z4NUZjVWo2?=
 =?utf-8?B?WkhYOFFVKyt5eHVYdzJ3cDIwRDFoMytucXlsY2RQU2NYaWxFL2hFcjluQlkr?=
 =?utf-8?B?Mm11UGV4K0lzMDRCR2V0ZDNNdXZ5L2tlYlMxUnZkbnJvZWc5WTZ0alJTRWxX?=
 =?utf-8?B?SXdkSkYxWXIwVk5UUUF5TGhMZ0VLbzdWQ1N2TkU3bTNEQzRBa3RONitWUXRU?=
 =?utf-8?B?VUhEU2hMN3lVbTVFcHdNelNxS0RHN3gzWFNUdnRqUDA5MVBoMmQ3aDl1NGRW?=
 =?utf-8?B?RXhqa1RFd1JjcEtjRThzZHRTUGw4NUVQWWMvRDRNWGpLL1dhTFY5ekZ1K1Bm?=
 =?utf-8?B?bEJoL0ZUVmpXb21EYmVXaXA3YlpoWkpoamFtelhnU1ZxK1lSK3FuSEsrUDlM?=
 =?utf-8?B?TUZsdHRhQmtnTGN4VDcrV0tYcGFUM3pzUHFDNFNmcXRITE4zUnR6RWRVcGV3?=
 =?utf-8?B?U3gwcm9zUjZ5VTlSbG1IaERydkhDNHlray8xZXJEcHk0U1NoL3Z3OVI4eUgz?=
 =?utf-8?B?dUxMS28zRTFWbGgrSzdnS0VOcHRmT0NiS0tRN0gwbGNPdWJYb1daZzAyMjFw?=
 =?utf-8?B?ZDdjbkgyUUV1L2Exd04vUzFoYTNJbGNwRUR3MHhMYkw4OXE4bGtkN1F4Y1hu?=
 =?utf-8?B?aGxhTitraXVVSi9JaXlrUTVUWC8xRnFVT3FKa2tBTUJjYkRmeUwyTk81ZC9W?=
 =?utf-8?B?VGVYM0JVSE5oanBHSUIwcGlTTEpHV0Q4dmdXU00yeVVVdVRCalRmYzlCZVBs?=
 =?utf-8?B?Vkg2NzZ0cmwwcU1SRCtrVlJvWnBFNkdqaDREaENheVBBbERsbWszeXZyNk9i?=
 =?utf-8?B?SElDdGVXMXpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHV5T1FlbUNwLzRSQkNRQ2hxSzA5U3ZGTE00b2VMdW5zanZ6TmovMEg3S0xI?=
 =?utf-8?B?eC9kMzVad3lPdjlMTXBlSThxS0syQlNRWGMxcExpMWhWRE9ZTVZrWnpYd3Nk?=
 =?utf-8?B?d1UxV2RKb0l6QzF3SU8wZ2NzaW5VYnR2RzZkcWx4aURrVDZVek5oY3BRMHBp?=
 =?utf-8?B?NDhnMnMzZzBPdXNHdG9YN1ljYkU3dDBsZWtrZnVRZll1c3g1Z3JxUDZXcm0x?=
 =?utf-8?B?NHJEMWFJZVdlaDhkVjR4eXdUdjdzaER6MHdpSjM0MjZGY2Mvckh5V0JvVUsv?=
 =?utf-8?B?ZlpmaWJwQ1FLUjM5ekx3cXpiOHdpZi8wYnFvV2ZkK0dXTUQrR1lNcXlPazZu?=
 =?utf-8?B?d3V6MFcyMjJuOFNvTitjUm4rU01hNmVXNXN1QWtLdnpIcVE4K2l6cGMydDUx?=
 =?utf-8?B?ZGNFNEV5V2V3aGZ4dUpSQzR5ek5RMmluQmxkZXNjSDNaQWtmRlFhamoxdEFO?=
 =?utf-8?B?c01WV3NXNXJXVklFZENmeFVmZ2hRaW9ncDZLcXZSNElNQ28xTjJZQks5Z2Vq?=
 =?utf-8?B?dlpwN1R1K1E5Qkl4Y05WWnJhSWd1V2pvVHNkOWFJWDNPbUVKWXJWZ0pacTdm?=
 =?utf-8?B?Y2JIZndGbXFaQ3VXNkVPL0dlWUFaNFRmeTFIbzBWd0FWQWhtVjQ4RVBwOGdk?=
 =?utf-8?B?MEJwKzdvcE1EQThFR0pzU2JsYmhGSTRMbnZHSEwyQy9pUUVxWGdweEJ2WGFY?=
 =?utf-8?B?UEVpRm4zQ2lvSEI3eCttMHZmcHhicGpRZXVxdVNTWGJ0b1c1Y0hhMkJDNmJs?=
 =?utf-8?B?NlFwYUNVWWlTQ2RKckxzOW5LQzFZdFpJTnNMSFZXN1dRWHlwdGNKNncyVzQy?=
 =?utf-8?B?a3ZKNVFEY0p3M2VEa3JzNWJ6d3dUNENnWmtLbFhQOEUyakc5Z1lhcmtlVDBE?=
 =?utf-8?B?WkpJOVh4cG9uWlhzSDRBREwrbWpMZFhmLzJWbnJmY00ydFBFMzkrbnZaSmpR?=
 =?utf-8?B?N1dmYmNPN1dPcnlLNEtEbXUyczUwbVpQSGRveS96ZGo0OXNjcWlQemE0WllL?=
 =?utf-8?B?UHJ1ZG1PUmpYSWhnUXBNK0lHQ3N2WFJzWjRkK2tEOFJzVi9tcUQ4a2Z1VDda?=
 =?utf-8?B?c0hhSTBiZklvSEdlb1BLT083VFlvQnBFdkNmcUxGcmVGSHdrNjZqUS9qV1hY?=
 =?utf-8?B?ZUFvWmNlRWZXcGVNMUdZeUlUU2xXdk9GUHUyR29TZnQ5a3NJWDRNZ3l3d2lG?=
 =?utf-8?B?S0NUVVUwRmVJR3l4aEFiLzVvQURKVktYTTR3dkx5bjRkNzNpSWZlNGZRUitk?=
 =?utf-8?B?NXhROUxXejJKYzFsUXRlaEpiUkNrQ094ZGY4ZVo1bTErS2d3U2FmVUY3RlhY?=
 =?utf-8?B?cUVYb3BxTys5bkN0b1lIVitxaXJxRUIyUjEvUmlUdHVaM3RFOGRZemhGREow?=
 =?utf-8?B?OVRVcUpxaFZpYTcvOUp0VVlwWUtJUkpNWDJHallzY0FyYmh2b2dyaUZ3Q2J2?=
 =?utf-8?B?dUtCSUVOUEs2RXVZT0pDYzZpWWFUdnNUQzZCZm02RjhFajNxT3ROM0F6TUpo?=
 =?utf-8?B?UXkvYTEyWk53SDlWaWM3VE1ycWpXN1pzUmRIQ3VVc2xIelByRERTNTlsc3lU?=
 =?utf-8?B?NmZZN0RGUFZBKzFacEFmUVNFbVRaQ1ZWc1diOXdwUU04dUdGaDJvSURIdkk0?=
 =?utf-8?B?L2JMQVl4ZFZmVmJBVjlzaW44YktlNVNnQVBzMllrY3c5aHk2azRvQVFkLzlP?=
 =?utf-8?B?L092c1RMdUhIZVF0cGZOYnpMY1hsZnVUOUthMWhkbk1ZdUVyRUNVSkUvOUtm?=
 =?utf-8?B?NjNFUUJzOVFQWG5obm16NnF1OUE2K0RjdEVYaWhaVC9QbGJ5dFJWYyszZ2Y2?=
 =?utf-8?B?cTlZQlV1SlpiTWhOYUNQd3BreFhUcFhGaDhpYWNBbmFITUlDSC92K1lmVXd1?=
 =?utf-8?B?Q1RScDJFMkZvZHBEVjJnYkhwTVB3K25Bbjl4NGsyZ250aWJuR3ZBY3A4Yldp?=
 =?utf-8?B?eFVERHN2MEpyN0ZEUVNCVGNXUEpJbjRqTm82Z25BVmNUbkpwaEFmMGpjbTRI?=
 =?utf-8?B?VUN4eDlYTUc5OTlCR0lwSlIrVVduSmFROFRGTG9iN2ZwMmMrb0NSdnlaOVBl?=
 =?utf-8?B?MmRFR09ubzdOc2wzb2p0ZGtUOUFqSHN0VVZjN3p4cmtSdDBHWm9KU1VwTHRu?=
 =?utf-8?Q?lu0gMBqFPYTs4q0KmHBhk3k0k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567d6058-93a0-4616-0b0d-08ddb9b34649
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 21:56:18.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oT4mm4tZvrJbQd6JB5AP+reu2jTyGix/qbPAxlr6B50/Sj6gO09U8KPWdD+YM/j+KTW77KEegASoK+imEPZAUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932



On 6/27/2025 7:22 AM, Shiju Jose wrote:
>> -----Original Message-----
>> From: Terry Bowman <terry.bowman@amd.com>
>> Sent: 26 June 2025 23:43
>> To: dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>> dave.jiang@intel.com; alison.schofield@intel.com; dan.j.williams@intel.com;
>> bhelgaas@google.com; Shiju Jose <shiju.jose@huawei.com>;
>> ming.li@zohomail.com; Smita.KoralahalliChannabasappa@amd.com;
>> rrichter@amd.com; dan.carpenter@linaro.org;
>> PradeepVineshReddy.Kodamati@amd.com; lukas@wunner.de;
>> Benjamin.Cheatham@amd.com;
>> sathyanarayanan.kuppuswamy@linux.intel.com; terry.bowman@amd.com;
>> linux-cxl@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org
>> Subject: [PATCH v10 12/17] cxl/pci: Unify CXL trace logging for CXL Endpoints
>> and CXL Ports
>>
>> CXL currently has separate trace routines for CXL Port errors and CXL Endpoint
>> errors. This is inconvenient for the user because they must enable
>> 2 sets of trace routines. Make updates to the trace logging such that a single
>> trace routine logs both CXL Endpoint and CXL Port protocol errors.
>>
>> Keep the trace log fields 'memdev' and 'host'. While these are not accurate for
>> non-Endpoints the fields will remain as-is to prevent breaking userspace RAS
>> trace consumers.
>>
>> Add serial number parameter to the trace logging. This is used for EPs and 0 is
>> provided for CXL port devices without a serial number.
>>
>> Below is output of correctable and uncorrectable protocol error logging.
>> CXL Root Port and CXL Endpoint examples are included below.
>>
>> Root Port:
>> cxl_aer_correctable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0
>> status='CRC Threshold Hit'
>> cxl_aer_uncorrectable_error: memdev=0000:0c:00.0 host=pci0000:0c serial: 0
>> status: 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity
>> Error'
>>
>> Endpoint:
>> cxl_aer_correctable_error: memdev=mem3 host=0000:0f:00.0 serial=0
>> status='CRC Threshold Hit'
>> cxl_aer_uncorrectable_error: memdev=mem3 host=0000:0f:00.0 serial: 0 status:
>> 'Cache Byte Enable Parity Error' first_error: 'Cache Byte Enable Parity Error'
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>> drivers/cxl/core/pci.c   | 19 ++++-----
>> drivers/cxl/core/ras.c   | 14 ++++---
>> drivers/cxl/core/trace.h | 84 +++++++++-------------------------------
>> 3 files changed, 37 insertions(+), 80 deletions(-)
>>
> [...]
>> static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data
>> *data) diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h index
>> 25ebfbc1616c..494d6db461a7 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -48,49 +48,22 @@
>> 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>> )
>>
>> -TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>> -	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
>> -	TP_ARGS(dev, status, fe, hl),
>> -	TP_STRUCT__entry(
>> -		__string(device, dev_name(dev))
>> -		__string(host, dev_name(dev->parent))
>> -		__field(u32, status)
>> -		__field(u32, first_error)
>> -		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>> -	),
>> -	TP_fast_assign(
>> -		__assign_str(device);
>> -		__assign_str(host);
>> -		__entry->status = status;
>> -		__entry->first_error = fe;
>> -		/*
>> -		 * Embed the 512B headerlog data for user app retrieval and
>> -		 * parsing, but no need to print this in the trace buffer.
>> -		 */
>> -		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>> -	),
>> -	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
>> -		  __get_str(device), __get_str(host),
>> -		  show_uc_errs(__entry->status),
>> -		  show_uc_errs(__entry->first_error)
>> -	)
>> -);
>> -
>> TRACE_EVENT(cxl_aer_uncorrectable_error,
>> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32
>> *hl),
>> -	TP_ARGS(cxlmd, status, fe, hl),
>> +	TP_PROTO(struct device *dev, u64 serial, u32 status, u32 fe,
>> +		 u32 *hl),
>> +	TP_ARGS(dev, serial, status, fe, hl),
>> 	TP_STRUCT__entry(
>> -		__string(memdev, dev_name(&cxlmd->dev))
>> -		__string(host, dev_name(cxlmd->dev.parent))
>> +		__string(name, dev_name(dev))
>> +		__string(parent, dev_name(dev->parent))
> Hi Terry,
>
> Thanks for considering the feedback given in v9 regarding the compatibility issue
> with the rasdaemon.
> https://lore.kernel.org/all/959acc682e6e4b52ac0283b37ee21026@huawei.com/
>
> Probably some confusion w.r.t the feedback.
> Unfortunately  TP_printk(...) is not an ABI that we need to keep stable, 
> it's this structure, TP_STRUCT__entry(..) , that matters to the rasdaemon.
>
>> 		

Oh. Apologies, I didn't realize TP_STRUCT was an ABI requirement. I will change back
the TP_STRUCT as well.

-Terry

>> __field(u64, serial)
>> 		__field(u32, status)
>> 		__field(u32, first_error)
>> 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>> 	),
>> 	TP_fast_assign(
>> -		__assign_str(memdev);
>> -		__assign_str(host);
>> -		__entry->serial = cxlmd->cxlds->serial;
>> +		__assign_str(name);
>> +		__assign_str(parent);
>> +		__entry->serial = serial;
>> 		__entry->status = status;
>> 		__entry->first_error = fe;
>> 		/*
>> @@ -99,8 +72,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>> 		 */
>> 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>> 	),
>> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error:
>> '%s'",
>> -		  __get_str(memdev), __get_str(host), __entry->serial,
>> +	TP_printk("memdev=%s host=%s serial=%lld status='%s'
>> first_error='%s'",
>> +		  __get_str(name), __get_str(parent), __entry->serial,
>> 		  show_uc_errs(__entry->status),
>> 		  show_uc_errs(__entry->first_error)
>> 	)
>> @@ -124,42 +97,23 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>> 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer"
>> }	\
>> )
>>
>> -TRACE_EVENT(cxl_port_aer_correctable_error,
>> -	TP_PROTO(struct device *dev, u32 status),
>> -	TP_ARGS(dev, status),
>> -	TP_STRUCT__entry(
>> -		__string(device, dev_name(dev))
>> -		__string(host, dev_name(dev->parent))
>> -		__field(u32, status)
>> -	),
>> -	TP_fast_assign(
>> -		__assign_str(device);
>> -		__assign_str(host);
>> -		__entry->status = status;
>> -	),
>> -	TP_printk("device=%s host=%s status='%s'",
>> -		  __get_str(device), __get_str(host),
>> -		  show_ce_errs(__entry->status)
>> -	)
>> -);
>> -
>> TRACE_EVENT(cxl_aer_correctable_error,
>> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>> -	TP_ARGS(cxlmd, status),
>> +	TP_PROTO(struct device *dev, u64 serial, u32 status),
>> +	TP_ARGS(dev, serial, status),
>> 	TP_STRUCT__entry(
>> -		__string(memdev, dev_name(&cxlmd->dev))
>> -		__string(host, dev_name(cxlmd->dev.parent))
>> +		__string(name, dev_name(dev))
>> +		__string(parent, dev_name(dev->parent))
> Same as above.
>> 		__field(u64, serial)
>> 		__field(u32, status)
>> 	),
>> 	TP_fast_assign(
>> -		__assign_str(memdev);
>> -		__assign_str(host);
>> -		__entry->serial = cxlmd->cxlds->serial;
>> +		__assign_str(name);
>> +		__assign_str(parent);
>> +		__entry->serial = serial;
>> 		__entry->status = status;
>> 	),
>> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
>> -		  __get_str(memdev), __get_str(host), __entry->serial,
>> +	TP_printk("memdev=%s host=%s serial=%lld status='%s'",
>> +		  __get_str(name), __get_str(parent), __entry->serial,
>> 		  show_ce_errs(__entry->status)
>> 	)
>> );
>> --
>> 2.34.1
> Thanks,
> Shiju


