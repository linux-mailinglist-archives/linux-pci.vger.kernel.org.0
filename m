Return-Path: <linux-pci+bounces-19757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E499A111BB
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 21:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBFF188A608
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 20:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718EE2080E0;
	Tue, 14 Jan 2025 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Umf8Wk3U"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655AE1FBE92;
	Tue, 14 Jan 2025 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736885463; cv=fail; b=VtNvPHctrAY5SJlWwdue4crkzDGm/J2/fi3kd0WlXHE6/egopT++boPAccdCVy+cR9fNWe+CWZXAaOX9GZ/4ZIunw+TqW4riF+f/nD+/TBo+37q6m7rEStF8a8uEpDK2TGC4+ptfoOJgBDgchzoHurvydeYkyROuzkSuOUSQ8dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736885463; c=relaxed/simple;
	bh=4BHAbrPQSWxgRCgbPmPJIVdfudgae0+HkOMMS7qsiJk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n0/MPc4aYcEgFjsLB2FKjNzPs38aJT9ccWNbrrYqgkx8zgUvJ1jwx06+EHvs3S6NwZbowgZc8bj20AJSpz2+h0fvKdGoTaaJ2HYBwg/B0w4/lQFMxJseAw6ug2A0G/ReCplHADeRORYsMfoeN0NDb1Z+zHA+d8XoJSf0h2JOBzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Umf8Wk3U; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMabnpIB7BOyKeVGkYe8aqMNbHCQUcswAPaF6QEQIjtSKWSnZZJgk+jMuMgnkbHSbsU2BlE3n44HOCJBCGp9287jXU4rToc4YtnOxpD+OjqubGnv7y/IAXXOTKLFgbrK+DrH2Xh6W1ZRYAZeQPOsBWpBGEDA2W8mJaj5tAmEcs43tglqXWJCc/++l5NUhcHkQsahaMqv+MbReqlOuTy+zUJia+NFwSYxLL/llw4jnOTWwMP3qqB3RGeClbd8IM+mDu/YwiCJ32c4Gh0SNzBJCibJV3pkkrKgyd9vKH2yHRqaUwTkkKZD8OIBFYjuNBG004wM4iBjkaNvbFmYfZ065Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqjqneXXDozAB9SIh4vApjXxbqbrZy6TS7GbKhGsx+Y=;
 b=ZS66xkePo/pY8pIHXwaKRbqz/guvLblYeEsiL5k+9yULz1l2eJ8urd1xnd9CIjiiS9p7lcxFu8TcMCYpKR0VaQ39s0ZNn6iIei/skfY6Epm0Aej5cXC3H8jfJmijG/sNskSg6poJ8hKg8KZs/8JCTXbsrquAsPJSoMVU6fGTs8Z16IVyC02Bji6C10WF5+7NRgQR3SEuVBKko5DZevvE94VI6DK73siy5fAGZQyxmxv+VjPiF7ySm6rB0c+7EnaGW9ULO8I2An6svMK/aL8toremtQfe4rMO78p4hyKCjHsloKDbtL0R3nNO0AdiNF/x9MyBZgl8InBCtZCZxhs9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqjqneXXDozAB9SIh4vApjXxbqbrZy6TS7GbKhGsx+Y=;
 b=Umf8Wk3Uxxc/cRuq6cnYjvlw/M3BIvUBOFvbvLvoOTxkvdm+E2oJiair2+O6xgj0MEroV/mX5pvP75Uhr1YnKSSx3UOqadfbQ6pL9/YL5n5uw2CwVEkSXDEDBGgrOyZsQZU/ePpyhVRXULoZdyWi5yOtJVvyz5HZ0idwAN2B9YQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Tue, 14 Jan
 2025 20:10:58 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 20:10:58 +0000
Message-ID: <976dcf2f-8f9d-4985-8cbb-005010307ab5@amd.com>
Date: Tue, 14 Jan 2025 14:10:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] PCI/AER: Add CXL PCIe Port correctable error
 support in AER service driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-6-terry.bowman@amd.com>
 <cb087065-f2f3-481c-84cf-aca2c5fd5ac4@zohomail.com>
 <20250114112008.0000167f@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250114112008.0000167f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0074.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::20) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2ae403-d8f1-4021-740e-08dd34d78f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0NUbzNQYU9SMzJLYmtvRHJ6clFEa0dScDZYQStQV0ZDdVEyR3NDZG1vK0h4?=
 =?utf-8?B?a0Z3RWhkbXN6SGR1VEtPYXZWMGllTDlHZDlFTktFMSt5L3QxOGU4amRZWjkx?=
 =?utf-8?B?ampESDZTV3hxVGpaUlR6WnBoWHlpaG1mT3BTajFLdHk2OHVlZ3pBbnIxc1F0?=
 =?utf-8?B?TEdVbldrRGVDSElQaG9PYUxQcTF6WnBpN1JCVUJORlFRMTBBQ1hLZ1RJM0la?=
 =?utf-8?B?c3N1T25CcnJDRk14RzExdzk0SncyYVF5QnNrTDNxc0pSRTFHTDcyeGRBdjFl?=
 =?utf-8?B?dkhWK1VUdHpYSXdCUVUveDRrblZTZDNCS2I0clZJSkVaQ3NKazR3ZGNpUWla?=
 =?utf-8?B?REtVcWs0NTNZR1dyYkxLdVZwTmw5YVdGVHRoQTBmbEk5NVg2S0tTNHVkSzNZ?=
 =?utf-8?B?YTUybkFoUFBHVzhjcXZCU2pmN0lVREx0bXhrTGk2NXBHU2RhWXRpMDZrZ3la?=
 =?utf-8?B?c0VxVWU0RUIxbXhQdWFHUFo0TWpaODliaXVzc3FoQWFBUE1CekFQb056S3BW?=
 =?utf-8?B?eW9WQWlvQ1J1V29kSDNaUFNnL2ZDN0VKUXo0cDZHZWtNakxkVHpuZmtieFFt?=
 =?utf-8?B?TnI4WFErQUdZaUl4SW4rL2RIVkZLUC9ZUVJIOVMvbFY3R3A0RHJya0s4V3pJ?=
 =?utf-8?B?dVZiWlBXKzh3ZWNCbm9jZy9yOE9qdzAzQ01GblNhQStVK1pCSnZCVzVPVFVp?=
 =?utf-8?B?cVB6QjcxZkpXaGtUSktFdk5peTk4M0ZYY0NCSkxPR3dVV0xpM3FuZ2xSNlpD?=
 =?utf-8?B?dDlZcnlXdGJsRTlPZEpKMU9MK2ZnU2wwNEt5eWcrRkMyK3VhZ2pqV0t6Unkz?=
 =?utf-8?B?dFM4T3ZaTlZoQ0xTelRnUEpqTkZvTjVRUzljTUx4ckpoVldyRWVCNWRLVFo0?=
 =?utf-8?B?N0VoSEdGYW9HUHJYRkFHRUl4KzcvZTlBVEdjT2ZqSEUwWkd0dGx0cDRCMXJY?=
 =?utf-8?B?cG9tRHE4WmJGVEpwOWVQMDZxQnpOVzZRR2F0UE5VY0xkblVkRzB3VEtqL21T?=
 =?utf-8?B?SVRhTjR4Q1ZWK2FFT1pqamxrQjRUTm9YcUF5Q3I1UDVWaFJLMjR2dWlTL0U3?=
 =?utf-8?B?U29HQk1FTjBRTkJYRmxkajJldGFHZ0dvcVhxQkdVdXp0UE1BRlFxaGpGamxD?=
 =?utf-8?B?OG9nQjFrVnpEWk45aWdaRWE0WDk1N0QvSGl4OEpRVm9JK3plMEYvc0tDeitx?=
 =?utf-8?B?Rzh2aTVEMENITkJ0U1AyRzhZV1pMYXpOSnVGQjJGc1V1dDBGanFxTExPdTdK?=
 =?utf-8?B?amMrWkE3T09uNk8rYTV4U01tRytScDhJbGQ3NGVXb1I3bk1hTTJhSXdYQ3Q4?=
 =?utf-8?B?QjZIRHpDdjg4WjNib3c0dTl2dU0reUh1S25BdmVQY1Q1NXZobDFORTl4VVo2?=
 =?utf-8?B?eVRsTVJtSXpHT09PYWFxcW8xR29xbm5VSDNFREwwSEJKem9Wam4vTEhmdFhU?=
 =?utf-8?B?Q1NMN1lCZFo0ZGlCRGl3YW9tNVZpaFM0Y0REdlJSY2lqSlRBYUM4VDduRHND?=
 =?utf-8?B?dkVmNGE4MHF5Nk1MQ0JTS3Fhc3JOVHUrUkpRTWRwbHFjU2NlTzNaVnRoRWhY?=
 =?utf-8?B?WTdJZDJ5aGxHOWJyQkNqbEYwaFloV1N5ajR4V25TUFdlTjdkRVVrRU1jUHl1?=
 =?utf-8?B?VVhZcVI2WWpBamZKaTVXb3Jic3l6M0Z6bDNVME1Ma1ZqcjFQeHJkWlJ4Nmcx?=
 =?utf-8?B?cXU4aHN4a1pScStIWTBHcHpPMnp1ZVoyRlBaSkI4ck1qY3dtaFFTODdrRzlH?=
 =?utf-8?B?QVFkclI4ZDdVQzdGcjJlUlNRSGo4dzdaT2ZkSnhzVXYwWFRSSm55eHJTRm5k?=
 =?utf-8?B?cmRhN1dTUUdtcHZTa2xrUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDZhLy9NdHBpZVd5N2ZnanUxUlJUSVpCeFgxK09sd1o1cEpNYll1ZFFrTTFv?=
 =?utf-8?B?VWxkTms0ZHUxVXNCc0Z6VTRoeC9sMGR4cHR3bU9SN2xEYlRWc1RHRG9ZdFYv?=
 =?utf-8?B?TzRHUUFieUtwMlpFanFZcWlheWtnM21DTGN0eXo5NXdiL2xtcUdHVk9xbkNV?=
 =?utf-8?B?Nm1QTCtPNCtBTzZOMGJoNUxRNEpuK3hmYUJIWEg5dHpzaGozbElVUEdqeXJj?=
 =?utf-8?B?UW1MQkJTMERTcERPcnU2ZWNlK1lnN21teGd5V3ozWXhVUm50YTFLU0loOEtG?=
 =?utf-8?B?ajFhR29zOGxWTWM1bXR2RUhWUVQvRFV3dC9XZVpINkZlekc1SVRuUlBwUUdv?=
 =?utf-8?B?ZDVsN1lCMHBLZjE4RXBvakhOcDBwSWw5MGxqWDh2bnBOdHQ5RVJ1b1N1TUov?=
 =?utf-8?B?RWVScEUwWWNOVFhSbFpsVk5PRXpHL1ZpY2RsS3VJZXhRaVZhVmNBNUxZek5j?=
 =?utf-8?B?RHdjSXViVk5Zck95cmhpUjNYL2xmZlpONGxEdWsvc1pNeUthdWV1MlhIaUIy?=
 =?utf-8?B?aGtNK3NMV1RKMXBubCs5c0p4V3BDNHZ6cGpkdDNDR284b0h6VnFxNkxXZUkw?=
 =?utf-8?B?TTZPK3VLMEpSY0s2WExNcnRjKzdyOUdNaXZ0WGVZTzdxVkdrVW52Y3VyL2pt?=
 =?utf-8?B?OXhlQU1TSXducUU3Y2dkbm93dVM2S2NpbWpiQ0Q5SEpCTjVid3pyampiV0RT?=
 =?utf-8?B?eHZhbUhUTkxkWGMrdGVqbldiNmpMbWhUbnZOd3VLUTlMYUNwS2VhNjdLNElh?=
 =?utf-8?B?Vk55S2NLVzBtZGRBWklvOGN1dHVPNVhGZTg2cWxhZEkydzc0ZXNNN1VsMmFL?=
 =?utf-8?B?RTVFWDRyZ253aTZSK0s5c3NQa0hyUit5elJSc0xjeE1Ta25KSGR2Z24rOXZi?=
 =?utf-8?B?M0NKVW5BQ3lZNjVNL3V5Z1NzdGVZZHkxdlcvcFM2VDFnTDROd1Q4bnQrKzJx?=
 =?utf-8?B?ejFybXVTM1crcnhsWTRERllZZUR5NmlwcWw2VTlVdko4TjRIR1JqOXBRTlN0?=
 =?utf-8?B?RTNwNDJXdGp6WWU3L2kwMmd5dVV3WHFBS2tWSExtcWNrdHh5YnUrVVFZcTRl?=
 =?utf-8?B?SVA2MVExWU5oR3kzZlQvdWpOMmtsWmE1TGZOdW1vKzkrME14bmVnMXEvTmJa?=
 =?utf-8?B?WkQvOVhCc25HeHhxQnY3WW91WCt3ZzZtZCsraVJ6UDlxTnd4VHpDOWdSU2Fq?=
 =?utf-8?B?ZkIzVkJvSFhtM3BhUWxVUjBxclhxdHhidmVEbTY4cnd6OGNnZGowWVc5cnpQ?=
 =?utf-8?B?dHBBNHJRRmQwbG1Hd1R2Rkp5QjU0b2g5a3lmbUtLTEZGQkFCbGVjeDdIOHp2?=
 =?utf-8?B?QmVINmpET0hVcnVuV1pZRTNhZlh1TVRaN3NyaHhEbTFWc1FXTHhWWXRQZkhS?=
 =?utf-8?B?MDBzQmh1KzBpL29aR2pmNmcxTUZoQm03WGdkSzMrOVpOcmx1SG1nclBOS21K?=
 =?utf-8?B?TWV0Y1AxZ0NKZTVFS1cxNkRYLzJISXRnZGI5QzJGZFV0VGVac3RTNUFTYU1t?=
 =?utf-8?B?d20rRUU2TGg0Y2FmY1NPcWhGQnM0VHYzQU5sK0F4ZzZ3WUE2b2hvaXlVTmhv?=
 =?utf-8?B?dWk3b2dmaUJpK2pOTm01UHB1SWRNZ0txTkh1QnQyU241VjBBODJHVHUwWVFZ?=
 =?utf-8?B?VVRiVklIb3lVcDBSaFdnSlhHNEltMzRNTTlyRWJzNHRiOE9UYzdaNkdOVUxH?=
 =?utf-8?B?aTF4NGhQUVBOOUdBWm56S0xHQTZjUFczN2s5cGcvQ2oxSTcvOUpjbVNNYzc0?=
 =?utf-8?B?U2x3Z21DM2xYMDBDRjNpM3hGTzVpQnEyV2xVTlpFNFdRbzJKRGNZV0Yvek5L?=
 =?utf-8?B?RTJSbnNXeGMzSGRNWGhCZHQrVDdSS2VRVnhTZEsweGpIbkNEZWpmb2FzYXhh?=
 =?utf-8?B?ZEpQQzVFQTI1SmZTejlWVGtZd3IzNUY5TlRiWmNyWE1wUFhFM0lHNFk4OFlv?=
 =?utf-8?B?U0NHRWtuaklrKytBRm5Wa1JKYTdYS1lrN0cyOVRSdFBUYmx3SS9XblVXcU5Q?=
 =?utf-8?B?MG9NNzJQdTFkVElzYThWSFR5bEZBZGg2cEZMQmFTUk9pT2JybnRjcVNpMDBE?=
 =?utf-8?B?azR0VWJvOTJObkM5SExZVkdNTXo5MmdqcDFteWpLSnU4cEloZ2luQTlCc1lu?=
 =?utf-8?Q?mb9foqZdwjOpQPKO6Uuo5ESw+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2ae403-d8f1-4021-740e-08dd34d78f54
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 20:10:58.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoNAs6+1zs6TRKkGYjoobtiRVWBdo4IeDmWdNmInJVxEXgm0G+BuWygx6ibTEIpQnqYiNC3rRppq/eBJlch0YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736




On 1/14/2025 5:20 AM, Jonathan Cameron wrote:
> On Tue, 14 Jan 2025 14:54:23 +0800
> Li Ming <ming.li@zohomail.com> wrote:
>
>> On 1/7/2025 10:38 PM, Terry Bowman wrote:
>>> The AER service driver supports handling Downstream Port Protocol Errors in
>>> Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
>>> functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
>>> mode.[1]
>>>
>>> CXL and PCIe Protocol Error handling have different requirements that
>>> necessitate a separate handling path. The AER service driver may try to
>>> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
>>> suitable for CXL PCIe Port devices because of potential for system memory
>>> corruption. Instead, CXL Protocol Error handling must use a kernel panic
>>> in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
>>> Error handling does not panic the kernel in response to a UCE.
>>>
>>> Introduce a separate path for CXL Protocol Error handling in the AER
>>> service driver. This will allow CXL Protocol Errors to use CXL specific
>>> handling instead of PCIe handling. Add the CXL specific changes without
>>> affecting or adding functionality in the PCIe handling.
>>>
>>> Make this update alongside the existing Downstream Port RCH error handling
>>> logic, extending support to CXL PCIe Ports in VH mode.
>>>
>>> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
>>> config. Update is_internal_error()'s function declaration such that it is
>>> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
>>> or disabled.
>>>
>>> The uncorrectable error (UCE) handling will be added in a future patch.
>>>
>>> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>> Upstream Switch Ports
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>>  drivers/pci/pcie/aer.c | 61 +++++++++++++++++++++++++++---------------
>>>  1 file changed, 40 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index f8b3350fcbb4..62be599e3bee 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -942,8 +942,15 @@ static bool find_source_device(struct pci_dev *parent,
>>>  	return true;
>>>  }
>>>  
>>> -#ifdef CONFIG_PCIEAER_CXL
>>> +static bool is_internal_error(struct aer_err_info *info)
>>> +{
>>> +	if (info->severity == AER_CORRECTABLE)
>>> +		return info->status & PCI_ERR_COR_INTERNAL;
>>>  
>>> +	return info->status & PCI_ERR_UNC_INTN;
>>> +}
>>> +
>>> +#ifdef CONFIG_PCIEAER_CXL
>>>  /**
>>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>>   * @dev: pointer to the pcie_dev data structure
>>> @@ -995,14 +1002,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>>  	return (pcie_ports_native || host->native_aer);
>>>  }
>>>  
>>> -static bool is_internal_error(struct aer_err_info *info)
>>> -{
>>> -	if (info->severity == AER_CORRECTABLE)
>>> -		return info->status & PCI_ERR_COR_INTERNAL;
>>> -
>>> -	return info->status & PCI_ERR_UNC_INTN;
>>> -}
>>> -
>>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>  {
>>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>>> @@ -1034,14 +1033,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>  
>>>  static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>  {
>>> -	/*
>>> -	 * Internal errors of an RCEC indicate an AER error in an
>>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>>> -	 * device driver.
>>> -	 */
>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>> -	    is_internal_error(info))
>>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>> +		return pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>> +
>>> +	if (info->severity == AER_CORRECTABLE) {
>>> +		struct pci_driver *pdrv = dev->driver;
>>> +		int aer = dev->aer_cap;
>>> +
>>> +		if (aer)
>>> +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>>> +					       info->status);
>>> +
>>> +		if (pdrv && pdrv->cxl_err_handler &&
>>> +		    pdrv->cxl_err_handler->cor_error_detected)
>>> +			pdrv->cxl_err_handler->cor_error_detected(dev);
>>> +
>>> +		pcie_clear_device_status(dev);
>>> +	}
>>>  }
>>>  
>>>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>> @@ -1059,9 +1067,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
>>>  {
>>>  	bool handles_cxl = false;
>>>  
>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>> -	    pcie_aer_is_native(dev))
>>> +	if (!pcie_aer_is_native(dev))
>>> +		return false;
>>> +
>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>>  		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
>>> +	else
>>> +		handles_cxl = pcie_is_cxl_port(dev);  
>> My understanding is if a cxl RP/USP/DSP is working on PCIe mode, they are also possible to expose a DVSEC ID 3(CXL r3.1 section 9.12.3). In such case, the AER handler should be pci_aer_handle_error() rather than cxl_handle_error().
>>
>> pcie_is_cxl_port() only checks if there is a DVSEC ID 3, but I think it should also check if the cxl port is working on CXL mode, does it make more sense?
>>
>>
> Good spot.
>
> Agreed a check on the mode makes sense.
>
> Jonathan

Hi Jonathan,

I responded to you and Ming here:

https://lore.kernel.org/linux-cxl/20250107143852.3692571-1-terry.bowman@amd.com/T/#m74f758d744ae446db5d07c541dc84f0a1d57996e

Regards,
Terry
>> Ming
>>
>>>  
>>>  	return handles_cxl;
>>>  }
>>> @@ -1079,6 +1091,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
>>>  static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
>>>  static inline void cxl_handle_error(struct pci_dev *dev,
>>>  				    struct aer_err_info *info) { }
>>> +static bool handles_cxl_errors(struct pci_dev *dev)
>>> +{
>>> +	return false;
>>> +}
>>>  #endif
>>>  
>>>  /**
>>> @@ -1116,8 +1132,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>  
>>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>>  {
>>> -	cxl_handle_error(dev, info);
>>> -	pci_aer_handle_error(dev, info);
>>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>>> +		cxl_handle_error(dev, info);
>>> +	else
>>> +		pci_aer_handle_error(dev, info);
>>> +
>>>  	pci_dev_put(dev);
>>>  }
>>>    
>>
>>


