Return-Path: <linux-pci+bounces-24892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8D8A7409B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 23:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CC3177310
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 22:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655EC1DE89D;
	Thu, 27 Mar 2025 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KtgvPmo6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D21DE4DC;
	Thu, 27 Mar 2025 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743113078; cv=fail; b=MykHxzgA9vdTwTRYiEu3QT69pLB60ye8fMDZNrwjuj/njfmtT3RGW7oSuqrlaTw4My7SfYlZcVIKlFbcAPs6glty206eWvVonWRZqj8jtm8AHCgORUpysU9OHf1KRf980D0vf4NUSP88/VfY1KqawgJ//oy6GLSM/cydPqpA5RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743113078; c=relaxed/simple;
	bh=IcDWmOQF1IIBtuIqQLHVnug7eHK4HCCU9tyZ+ZTV6Z4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s+PuvCRX57G4lXKoQEtbWlmA4q4O5F2AbA/X1poGcw9uXZG26HJKpkhVJFVNTT0N0g+8BVW+YBKNSx1bhKU9eVgCSgqgcDqCW6Jh5+63IyVEPIIm+Oat+uXWB8YJBugOLt3O0H6zTpyox7IySam3YqQDGQ6V7z5rL5Njoo396V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KtgvPmo6; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvoXnrwX1LmVwO8rmLoe8T4TnOAgjLxRu8GDDpslWBMngNEOo1lRa19c8Supol/o/f/B++NDYH38cT3X1/VjxqYaGdzWWtyurrJrGpLytew1SeR0oPqjSZzDlw9wW4zz7tXeuYYTn/xnEi/iy3qncXgml/iTa8LdyJxJ7VhMhtUFHHmuG5WjFsjpBgmodsm5GyxnUpLq7DJmMQ3JKedX0o47e0cYNUCPKMhzZDclPFTVF5LQ/1ENV6ny9IvJuJ+HWFaFkKzCLFyVBAUiPlkfVWqNMVPFHsvSTsByVWCiY5mAutOvO9g69LyT1JHggtCw87MTV2cLzzpfldqLmgP30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCS2HIZ1YbAAlf5jyezsSXmN6e57ta3fnu6OJyz/jFU=;
 b=Fe/Q4XteE42o1ZzjCbd5UFVCpHtkkHyY1upQeDheEO6URjPT94n/7Kdh4NWHWBNN9N26sarDeyEMskteYOAbHOmxPcZW9udZ+Bv5YmbauAI/Z8+ImsQwZIpr7Ea0SVAiEqX076MZh6MAuElEZi4K3ohIoKGM3EF/l9dn8QxRNchPJMCbJ5xNkUmC/L/LzwzrDUtjZ6CQxOw02w6AjDuJbnwoOQWg6zLzFSi03yiHM01b9SrykDiNmQR4BIkeZJbCbzlP10icRjRYBVAYaYLCNMyyFadv2pJWJt611kXUJETRhi03NcyzaUOSZl6x5ZvOLp5Z6zxJJgBpOch8Uk0Cdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCS2HIZ1YbAAlf5jyezsSXmN6e57ta3fnu6OJyz/jFU=;
 b=KtgvPmo6wz4Jx2tnsyMbCGVsmVrKA6+j9KZPNLC7gn9FmcITaxHBPTPjF7QFMOAgMtd30q0+6+xnCZHQJMwOS3e80vZ1Y1Ui4LAZOhUWYbRB++44zVP07Okp+XvK1eEps4cZUvl8KIPPyn0fa3WopH6jTKs7QTPrIJ6YrxVZp/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA0PPF316EEACD8.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 22:04:33 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 22:04:33 +0000
Message-ID: <fa7f62f6-9072-48e9-98bf-d004b6828f3e@amd.com>
Date: Thu, 27 Mar 2025 17:04:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/16] Enable CXL PCIe port protocol error handling and
 logging
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327171607.GA1434835@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250327171607.GA1434835@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0121.namprd11.prod.outlook.com
 (2603:10b6:806:131::6) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA0PPF316EEACD8:EE_
X-MS-Office365-Filtering-Correlation-Id: 66083987-23a8-4533-df5d-08dd6d7b5adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak9rYk50MEtlUk1LY0l2K2dGTHEvMEZLYVVUdTNJd2ZCME5WYlBiRlQ0eDhE?=
 =?utf-8?B?cm9KUUxEaHlacERHOXZMc1FQUlBRVkJkcnlPUzlOejZ0SGVzSVNPcFhXZDNB?=
 =?utf-8?B?UEo5YlR3cU54cFNFQmVsV01jeTJnRFpZdmZYY1F1ZjIzSityQVhVWjU0bWJv?=
 =?utf-8?B?ZERhdlVRSlptMmI0T2t4bWIvNmVCdFV5dDlnckpYOWZ2bURHZUtSeFUzaWhj?=
 =?utf-8?B?UnluWVdJSEYzQnJ6R3FjK2ZkV1FrOThlKzV6dTEwQ2FvdDJSL1NsSU40Sjkw?=
 =?utf-8?B?SEhrSW1nL3MveXNlTFpFelR2cWRXT1lYOHQ4aEp0dnZTWk9DRUh3Q2dBaWM0?=
 =?utf-8?B?Ky96V1ZjOEVISVlST1h1bWJMeUdQSEZEcXhjdllSTE84WTdQbUFlWkhIb1Nx?=
 =?utf-8?B?eWJuNzhLL1I0NGpyZlJrZXdMOC92QUpDVEZwbmJaenBuTGIxYzVLbXFjQVNH?=
 =?utf-8?B?SFRSYjV5VzNmT0I4RHdTai9OanVYUUk1eHlqRVJyMksvbWNWdEMwckd1UENQ?=
 =?utf-8?B?Y3NqeityWFByQkpOUnJ6a3I1bllFb1p6U3NuWkN4c01Yclo4RjlPdndQYTN4?=
 =?utf-8?B?cVQrSmZIR0x1dGw3Z0NKVkdBSkRlUXZGOFIzNGxXVG1XbksxeWpJcVNLQ1Nv?=
 =?utf-8?B?T0pNdnhyNzF2WTVKSUxhL1lDYlBpM3FMeTFhQ0xTNDBVZU1nQ3ZVRkpZRUh2?=
 =?utf-8?B?M3F4SzVDaENReWovSkJPOTgxQlF6NTR0a3JKeW53WmNpNjIxVVZLYkFpWmRQ?=
 =?utf-8?B?OFgxTzBlbVdKbFJvZGEyemNuZzg3SHJNRGM2RktlM0orTlE1cGY4SHR3bHFP?=
 =?utf-8?B?TnJoOEJvU2VDMHBYYXFxd0hNK3MwNmFIczJYanJhN3NFWG85NmFSUVRLblRR?=
 =?utf-8?B?aE9vM2M2Q095REFxcnZFUnNpMGtnQjFEWE93OGtXUlFDd25NOFBqTm5DYkk0?=
 =?utf-8?B?NVA2OStkMWNvNmNGYkZEb0dFUUtRQVB6eXJyajV3dURjZmJwSVlvSjRvU2Z1?=
 =?utf-8?B?SFZRZDFtejllbjJEcGpoVW5Fb1ZUTXhoaEh3NmhZQXRNTDVJc2xlelZZL1pr?=
 =?utf-8?B?eTRKOHVoY3YyTmxTK0JFYUpsdUtnREgrQkVnWEFQVXRacUJHejJCSlpzKzdM?=
 =?utf-8?B?SlpraC9ST0pRbE8rU2pROHRobkRtZFZ2ZHdKUTZndUsrR1BoUGdsZU41aER0?=
 =?utf-8?B?dVZ4VkZFZEhNOHVhM3NVL0RnRnUvMnFQMTBkYkJOblk2RE9RMkJUTmdDSC9N?=
 =?utf-8?B?aHhXeXBLNjlHUWpWQW9FZm9kM1dKaU83U1Y2cnhmOThSVFhsWHE1bEU2S0JD?=
 =?utf-8?B?UWlkTUtYZk02VjBSUkt1a0xCc1JLQU1oT3ZPQjJha1FXUkVCRDYrMGhlNURs?=
 =?utf-8?B?L2FMenA1T1JPSUJmOSt0SDlDMTFXeWgrTDRjV2FCOXNGTmwxdWxyQmh0SVdo?=
 =?utf-8?B?ZldmdDIwYVE1M3RJUjl3dDB5Umk5aDlZVW93UGRRSS9yTWFqQ2pBM0E1cnlB?=
 =?utf-8?B?Q2ZMRnRab1RMWU13U1JHNzQ5bW9EaUpNZ2xudFMzb0c5Q0E3K1hrQU5QaHpz?=
 =?utf-8?B?ekk2dGhmR1RqZ29rQ2pLbysyeDVwVWNYeWpsOCtDWDg2d0M5VHhQUldIaUov?=
 =?utf-8?B?SmVkOGVmRHpITi9IWlpvNzVPR2l3YXE5bW9RU0dBKzZZNWlOUzBpcnZTR1RO?=
 =?utf-8?B?c3g2THA0cU9uR0JZMDdwbjRIM0RxWVNMZ0twQ1Vrb1hFSUUyQUIvS01teTMw?=
 =?utf-8?B?N0x6elZ0dUZvaUlvRE5Kckp0YlU3V2R6dFk0MHdHcDAvcXZKeDZoZEdOOTgv?=
 =?utf-8?B?YWpFQ2tkdzRXTnJhNkwxWFdVVnNhcU9SOTVRSDVhaTEvYk9pdkx5NTUvNUE0?=
 =?utf-8?Q?i/tqUeYI2rt9R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW1DY3lPbU5PcGdMS0RHTk9HU05sWS9TbVIxTVNnUmJFdGRHUEVwMnBheUt0?=
 =?utf-8?B?VGdCK1h1RWlnc3UzQVpkUWUwa3lJYjhURmU5c3h4dTE0bTlxVDg5UFZOUklL?=
 =?utf-8?B?Z2VIWS81amdOLzRQMjhGeXltNVFWak1kZHVKL3dTenc3bUlyS3E5anhmNnVG?=
 =?utf-8?B?MjBVUzhoZlA3OFR0ZkM1UHdTK1JrdWJQNHp0RWxYZENGWnVIb0toNTk4S0tD?=
 =?utf-8?B?U1VMK2UxQzV0ZExQSE1QOXFnYTRmd1dXc3BpMmt0TDNzT21KcWZmTy9BNFB6?=
 =?utf-8?B?MDI0ZmkrNDI1N0Q4b0s5NmRxMnVNWVlYY3BwVW1FdVRKQy85UVgrMmFyQmw4?=
 =?utf-8?B?Vm9nWkRKYW0xWFZ5MlpRMDR0bzdBa1E1R0FDZUtCQW9xV0ZRQW5GRDl5TXB3?=
 =?utf-8?B?c3p0RHBrTzJWV29FdXFHNThWdGhaUmhJcVZKMGtVYmZ1eVJHbW9QL2RRU25u?=
 =?utf-8?B?ZnFFeWhCdWFFUFdqMzFNZTkwdTdNS0xSekNOZXZTek5MQ09OKzkrM3NUaW9P?=
 =?utf-8?B?WFAwbWZFRGw1YnY2MjJqbU5rUEV5Wnh2WkdOQlBjS1EyQWpFMnpLWWVpTTla?=
 =?utf-8?B?MmdpMUMzS3hiQVV3WjA4UUMzZVg5dVFYRGgzVnJ3OHJlU0VyalhiOER3d0lM?=
 =?utf-8?B?ZndUcmRyQVN2dkdXYXYwNVpnRW1WWFkwK0g3bXNZSGlOQTBuSk91SzV4WkY5?=
 =?utf-8?B?N3VzL29udURtaUZ5OFRlVjE2cFJqY0tBaEZ1MVJJUm9CeThEK3crbTFHdXha?=
 =?utf-8?B?dGVORUNFdGh4K0tHdmx0eWhCOE1FNGFzRXV4aGFZN3lvRC9BdzdTckNRZEF0?=
 =?utf-8?B?aVZNb1J2WG85UkVKRUhsRm5wL0dKcWdwSXZCb3AyUlZMeklUSnlDQitXTUNF?=
 =?utf-8?B?UGY2dEJzSUZ5QWN1MFo2S1FnaFhYdHpXemI2N3ZnT2xwM0ZtQ0pUek10NzZw?=
 =?utf-8?B?bHhoTW15ZDVtQXprVEMvU1lSU0ErMzRFeUVldjQ3VmdNMkxSalVocU9zczAr?=
 =?utf-8?B?OVYrNm0vSE9OWVlKMHpBUE1BWlRRUldQTTRFcHdaaGdod3hQUmJPMXplaGlR?=
 =?utf-8?B?WUZ3ZFp3RXRjREtqNDlzTVdycGUvZXZVN2F1WHVrRzB2UWh6YlhtdXg2eS8y?=
 =?utf-8?B?a1N3dnZOQXRxdGZlckduRG14MDB4dVluVW15Ym1CUVUxTmc3cG9SUjBnSmI2?=
 =?utf-8?B?V3JoanZvU29zREVqZWYyM2hoUnBYQTVlUnExK3JwSjN0QmN3WEFBeU5KZlFi?=
 =?utf-8?B?a1pqTUdSTzB0QVM5V2hYRC83eTZTZnZ6ZlNuTkwyNzVQS2FDOHkzSzM5ckFp?=
 =?utf-8?B?blJTaW8yYmFraVByUFNDZlJiSnc1YVB0Z1hkZytBSGpBcjJTL0tQT1o1ZHl2?=
 =?utf-8?B?QUtwdFk3YVBWT3dvS0NyMEc0cDRoVThJZjRvS003RUhENG9mZ0ptS0NnVFdR?=
 =?utf-8?B?VEoxT3FkekNOd1pzcXJENGVXNytwdWdKOFZPNTRMcWphT0dKVGNJNTg3a1JE?=
 =?utf-8?B?SklGSW10ekluSWo0cm1qZWwyYkthV0JoQ24ySlVDdnlmTzVCSXUvTlh5L0l1?=
 =?utf-8?B?U3p2VTUvbXhmdWlUK2tWRk1ENlBzLzlBc3YrT1BwbmtvcFkyZFdidndPVnRo?=
 =?utf-8?B?LzhjbS84K1FlTllwRzErSDhabEIycjY5RVNEaVFjaUxkcHVSVyt0c01lRm9I?=
 =?utf-8?B?cllLOG9NUkJZSEt4TGxma1MvYXdVVTBoMThNNHNkQ0xnbWVFQ1dTTGhjMFo1?=
 =?utf-8?B?VUNIa0ZvTHRkdE53K05SSktGblhBU0Erd3h0bVRhZWhiNGJGd1VJR1NHRVl6?=
 =?utf-8?B?dkRtZDVWZVpxeVhMaVJ6dWdPS25XaEhiRkYxZlkzcWJBd1N4YXJVSWpuT044?=
 =?utf-8?B?dkZ3OG1SRmlwdE9yVXJQb2tZV2VSOVlmMnE3aTdvU0hVSFZjZUxZajNET1J4?=
 =?utf-8?B?S1FTWHoxbGZMdWpyS3RlTk55NnBYYWFDSWxjNzQ1d0ZnQSt2TTdqemg4aVZk?=
 =?utf-8?B?NFFZSWxFYzFIMmZETmxOT2RtV1FNMWdvOStBSmgzbXdEUkw2V3I3VjBCeVRM?=
 =?utf-8?B?MHpjcFdZK1ZQSlVFRG53WkxOMVZzVWc1MG8vUnpmZktnS2RJVUdKYlk4N2d0?=
 =?utf-8?Q?jt5Nkw7ZZHIInTBvV8/Ms4ChY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66083987-23a8-4533-df5d-08dd6d7b5adc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 22:04:33.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZvnH9cFlZ4bvUfm0K7KnLU/Hp6SP0Zc8pJEojt51wZJTGk3oo7AAVN6zeReOE/cFvSyx5oM3rO6rrTA8Ai+ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF316EEACD8



On 3/27/2025 12:16 PM, Bjorn Helgaas wrote:
> On Wed, Mar 26, 2025 at 08:47:01PM -0500, Terry Bowman wrote:
>> ...
>> Terry Bowman (16):
>>   PCI/CXL: Introduce PCIe helper function pcie_is_cxl()
> Something like "Add pcie_is_cxl()" is probably enough.
>
>>   PCI/AER: Modify AER driver logging to report CXL or PCIe bus error
>>     type
> No need to repeat "AER" in the subject.  Could start with "Report" or
> "Distinguish" since "modify AER driver logging" is kind of low-value
> information.
>
>>   CXL/AER: Introduce Kfifo for forwarding CXL errors
>>   cxl/aer: AER service driver forwards CXL error to CXL driver
>>   PCI/AER: CXL driver dequeues CXL error forwarded from AER service
>>     driver
> Both should say what the patch changes.  "AER service driver forwards"
> and "CXL driver dequeues" could be descriptions of existing behavior
> or something else.  Starting with a verb will help make this clearer.
>
> Maybe don't need to repeat "AER" in "CXL/AER: AER ..."
>
>>   CXL/PCI: Introduce CXL uncorrectable protocol error 'recovery'
>>   cxl/pci: Move existing CXL RAS initialization to CXL's cxl_port driver
> Drop "existing" and at least one "CXL" to increase information density
> in subject.
>
>>   cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
>>   cxl/pci: Update RAS handler interfaces to also support CXL PCIe Ports
>>   cxl/pci: Add log message if RAS registers are not mapped
>>   cxl/pci: Unifi CXL trace logging for CXL Endpoints and CXL Ports
> s/Unifi/Unify/
>
>>   cxl/pci: Assign CXL Port protocol error handlers
>>   cxl/pci: Assign CXL Endpoint protocol error handlers
>>   cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
>>   CXL/PCI: Enable CXL protocol errors during CXL Port probe
>>   CXL/PCI: Disable CXL protocol errors during CXL Port cleanup
> Don't repost just for any of this, but it looks like there are some
> kernel test robot warnings that need to be addressed.  When you do,
> tidy up these subject lines so they are capitalized consistently.
Hi Bjorn,

I added all the changes. The commit titles read much better.

Terry

