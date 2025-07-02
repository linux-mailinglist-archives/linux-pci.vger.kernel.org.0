Return-Path: <linux-pci+bounces-31288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D9AF5DF2
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 18:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359FD52477D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BAA1E0DD8;
	Wed,  2 Jul 2025 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ox3RK1I2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C711DDC08;
	Wed,  2 Jul 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472057; cv=fail; b=ZUVVBx6C5YthPzEKLzA6QXvFOOQH/wHJhcMZE990fOt6PBiC42mhzm9olaFsCPdUujjrpBe8NMajGeNRwcg9dHV5GUGqnfogVcCSDXyk0GpFfuDotDL9TSyqSWwJwYIPYPcMPdfA+nwDWjuqd2+CDqxoQMRY2iRRLn6HpYXKalg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472057; c=relaxed/simple;
	bh=u4RellzpxjMbF6xD1XYD+x+oTX9Xs/MiULKOquFiQ6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iglotCOpQ5kYYP1+hSoJhgBsSp8eueuH5/t45dxqh+5lQZ8bXD7ekx51VtgPnRGXtcdhQO9DnW2xnfyQOWmgmSwq9bPWBsz0v30pEc9pFe0juxGxOxoc2wVPy2xalUjcrGwhwXX9GEFar2hB/H+v10BQtwq4Ymmvn8kljrRJ90A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ox3RK1I2; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VV3bCZt+KcRbiVmnlWJIOXurmi5akgKnJW1NihBrfT3D6HcRcFEWLdZ8ZlCIu8/OPP7sAumgj/dC51E/UjIbyvlyFq9rZ3/MRhmH4btoM3Clv4SfeF/1bAwX6x/CQuJ1cRZwGBdYNM3yEtcmBOiGH1Pb4wXNb2iOfw04J4guizU6n8b+EWdlOTFByOjFiu0Xtm46Wjlmen2h7P1dq8SAIG7PrZcDKPdIbbuhCjMPB2JgWSIBZ1eGmga84BuXhU7hC9lapafQ3qEgMmvwD4bs6m8hu3MPtIwnjXjjF0SESjeq0FL9dNZwn7KGi++cyOlv3A2b5BvIf0X9NKUkTQ2Tyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4RellzpxjMbF6xD1XYD+x+oTX9Xs/MiULKOquFiQ6A=;
 b=zDdtnosyXq+rRE2EEjWpzum/S5tPjFMBTQm9xJKEw86/Bzne/QtbQtF/Cj0tNEVRkO7fLNPK8H5F82OGjYwZf1zFhgdUfdbjClMtrxiMRPEbR6i7gUszcMlpn3xpl128ofsqh0XHx53VzJtcBv/Z11aXr0sbtoxIiVMjNPMFIinbCMPqCledjasvupfrq7xDoXc0CzqKL9BRv6hNjwXusVbMQBr6amNi29Ox5YsZnwt62ePos/2NOLuVVS5EfjxAJED+YHm+H18+kdkfhqOh9YW912nCxCpy60ECoiXSjF06qaHTC3QqtUV5ZQ6LtdplwCgx9tt4JScxSMPu6ZFu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4RellzpxjMbF6xD1XYD+x+oTX9Xs/MiULKOquFiQ6A=;
 b=Ox3RK1I2SbJCzS9SkxOEe3pB+Pwpsqwoz6AMSCPNPE4YOlz/WZ7PxGj+wm2yExuzuzLMFUwgAdtBIlxi43PKsHja7S9fXJW6dyx9NuDHMqkGSV6miFtPQCoUavp8sFmUzLeN17xs0RTVpHLmNw4bZG2LYdDR2mBqT5LgrDinUvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 16:00:50 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 16:00:50 +0000
Message-ID: <f4c607f6-c82e-4c3f-998a-723902c6b976@amd.com>
Date: Wed, 2 Jul 2025 11:00:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/17] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-4-terry.bowman@amd.com>
 <20250627105336.0000297a@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250627105336.0000297a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:806:22::29) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ0PR12MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d65a75-4e38-42f0-da50-08ddb9819d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzJWdEhreWg4M2lXZU53bXFuZmEra2VGRTNPdENta1Y5ZE5LeE9SNjZ5OWpw?=
 =?utf-8?B?VDF3MWFsUzlLTC96S0U3ZG96K2FjUFNpMk01aURXQVRQTlduRHJWNjhKdjZK?=
 =?utf-8?B?TGJrYk9YMWpwTDI2OGtXWHNaL3NWZnIzRy9IY3JiSWVRdU42R3hsQXlMMkdN?=
 =?utf-8?B?OVU0czRGMHF2TTdhK1gwT3FLbWtjdWFHb2VzZDNNQTlrTjZUQzdKeU5ieit0?=
 =?utf-8?B?bnpKczZKaFZjTXFueE0rMjFYWlU5L092dU44clJsMHJqQ3ZTblZ4Q1Q5eXht?=
 =?utf-8?B?OWVxUnd3TUhjaE1uZEtremt3cEI0MWZIaWRiejZhUzljZGJSaG1mMHhiRWhN?=
 =?utf-8?B?WUF0UlpyZ1VlSUxWSW9XbGg4eW93eWhJeE1FVDJ4eXo0VHd6M0pMak9EUWRU?=
 =?utf-8?B?VHg1elVhbXBkV3RWYThYWk44b09mcDNSMUhHUEtmUXgvSEFlSlU3ZWlCQjFZ?=
 =?utf-8?B?emZZc0lHSmwwc0xJY25wVER1VWtuUjU3Ym9VTlFhT2JHcWVFVC9vOVYrT2RI?=
 =?utf-8?B?UVdMNjlCeS9LME5laUVPYnB1RjNMTlhSeE9aOFRQUnc0TVFPVDlnSFQzR2JH?=
 =?utf-8?B?ZXoxdHRSeVBzT2QvRml5Z1Jrd1J4YWxUUTBZTUJJam84RkxzcVJ0eG9sSFNB?=
 =?utf-8?B?TStWS1l2V3A1c0lCSEJDN2RMN2h6a3MwRmlEcEk4RWFTNlp1NGt5QXpGWWov?=
 =?utf-8?B?RCtaazF1OVdDU3RxcnBseFcyVTJPbUpLSS85ZjM1OXNjSi9FQTI5dEVKYXhh?=
 =?utf-8?B?TDJqZWVRdXJyWDY5RkdiOXhzcWhENjE3djM0cExoTzdiWWx5a2JtUFRnRzBQ?=
 =?utf-8?B?c2xONEZXRDBmdEpHVHZjU0FVaG9EWVk5Sy9GTEFXNVVJcEZOY2FqVVF5YnhY?=
 =?utf-8?B?b1FNL1lBQVRlU09kUk5wekV0U3lJZzdhTERBNk5nOWhmQ0pMVHVSZTlleTZr?=
 =?utf-8?B?WGN2WDVkRDVHQ1JZeVBzU1V4L2pQWGl4MzlBRi9zT2FMN05ZYm90OWxGTzRl?=
 =?utf-8?B?TzE4WXU2ZjIzV1c2Z2IvaVVBTlZjWmxscjdBUlQ1cTBLQW5wajQzMHgyenhR?=
 =?utf-8?B?QzNNTjZsUHVYVnRRZ09VNjRjc0FkR1FidFFQL204SEdhTy9oSE5OZjNoV0JI?=
 =?utf-8?B?cDRYZHBZcFhvVEk4RnJuMmpGR0UwaWhFY2IwQURHZityN09xSFlKNWdkdmll?=
 =?utf-8?B?NXdVdHRmcTF1OHN4WU9yUnAzUmFZelJGdmlJVkZ6NHZLaVhLNi9iMTBBNEpn?=
 =?utf-8?B?YURDUyttenE4SjBuOXI3TlpxUzdzWXkwQWpTWUwzZmxJYUFxbHFGQ211SGdy?=
 =?utf-8?B?VkRBVXppZjNSTXFSWlBhRkRvVDlKMFZ3QWNXcDZmMUdoWGg0QTdPNVBEc2lm?=
 =?utf-8?B?ajdxL0hzWEdveGhkeGhGVlN3RkV0bFVjaTdLWW91c09zL00vMm5rTzRCOVFy?=
 =?utf-8?B?eWh5STU0dzg1OVhHaHhGQWdXaXl6aHpsRU92eWI1bnJqdEhJUkxVUW1RUUNl?=
 =?utf-8?B?U3E2Q1ZMbDNRTUhpVjcvWVg5ZDNqMzlhbkRta1Jmd29mbGxXRjBkZTJ3S0p5?=
 =?utf-8?B?WGFNU2VJemhkOGdNVXl4MlA5bkFFRzhKZW5yMVp5N2xGNWZ1NlgzYzcxQU9G?=
 =?utf-8?B?YStISmlJVTEvdGNnSVZMV3Q2YjkvZXdYb0dZMThvWC84QUJtRmR0S1hsbGlQ?=
 =?utf-8?B?NnBLQ3JieGRjeFhuZEFnbWNaYTlsTmxDT0ZGcVpLZW1WTFVldTBwdHZaZEZk?=
 =?utf-8?B?TTcybGRIUGdITkowZHd4TnZKQ3R0RkNYb0Vhc1hZREwzdEpRSko0WUVYQlo5?=
 =?utf-8?B?M295UFV2ZWZ1eTFtamxPQWcydzJqTnBDWjBlRCszTzZ4UzNwMGtXRVY1cHhK?=
 =?utf-8?B?QW5PcWF4dU9pUWNRc2NUNWhqOEl5aTVqK2N5QmhCQlVFUER2UUlhdHhoVEtm?=
 =?utf-8?Q?CKPNVFATykg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0ZRL0NJRXZoOGV2cXVWOU9QRkNqakkvY2lpa1ZMd1lBelJ1SSsvbUo5ZUV6?=
 =?utf-8?B?VWxOM1lGZ1FGTm9LdytuelNRSEFCaWU3M2VleDJLZFEvbGtneTlsc1pad1FK?=
 =?utf-8?B?eXNDRUpPazFlL29FQ2RHY0pNU3RaOC9Hc3RCYmYyUmtuc2tQOVM1K0VRZ09i?=
 =?utf-8?B?VWhqb3VZeWZHWkp4RWtTb0xaVUpsYkkxVFJTbEZqV0NrcEhkTEd2K2ZkQU40?=
 =?utf-8?B?V2dPUHZWMUNPZWZEWGdlV2d5VHdhRDJDNFlrY3RpMm9COUNqS1ZFV21mRnNY?=
 =?utf-8?B?bU9IQ0hKbjhsQXZCNjB6UDFUWnhuTXFwZG5TcHVYNEpqTU5Sa0V2NGhxb3B2?=
 =?utf-8?B?ZHJOYWczUUNqRzRCVTBzSStFeGx2MGFaSU4vZ21wWGQ0RDRjR21ZM3NOQWtu?=
 =?utf-8?B?a20vUTZ3aERJMytGLy9JMit2SGVBdGhHck9SdFZ1bWVDOGRhaS9lNW1kakU0?=
 =?utf-8?B?ZUdaR3A2aWhqN29vN3RjTmdTVUJxUEsvUUZIeXBiem9LTEFvRmg5VXJhTC91?=
 =?utf-8?B?bVNibWRxdXFYUCtWV1FEc3EvbUVKeTVzRGdENW1aOFNGRG13K1VKc21QWmJ2?=
 =?utf-8?B?TnNsaGZxVWJHVEhLOG5KZisycHpDWmRQWitOWlAzZjdMME1neHJ6NEYzS2RE?=
 =?utf-8?B?ZEVkSi9xdDdSclFJdjhrcVNOdXRpZi9VTWlYelhqL2l4ZlJTQWJXMUdFWDRL?=
 =?utf-8?B?SjZQeFV6alBuSXVuV3dVU09PbjEwVGs5dmR0T1pJdTh1OGNEa2NRNmw1SXcz?=
 =?utf-8?B?M01nZDl4REtrNDZhRTdwVlpibXJjQ2IvTFArejArN3dKc1J4Ymh4OERNZHR6?=
 =?utf-8?B?TjJIWGY5VDhwcjlRYWFrM3FWQXlLMUo4Z09hN2Ruejc3YTJUV0dDTWNFVWsx?=
 =?utf-8?B?MUdTdHFjaVBwd2l2NjVqWFRQcXhDdmZ5ZzFCSmw5VzIvQThIWmFtektRZC83?=
 =?utf-8?B?SGg0d2xOQWhHTjVXczNSVVMyTWVDZy9UaXpheFZVYWlHZnQzd0ovWDRRV09a?=
 =?utf-8?B?c0ZudUtTTkhLeHNlbTdDZ1JQellIb2VrTm51WEFLa0ZQSkFLengxQTBqWFZw?=
 =?utf-8?B?c0VLK2xlSEFEZEVIZUtaL3pHU0cxclBKTTB2a01yZCt0Vll5T0lqenN2OHF1?=
 =?utf-8?B?TUVJcy9kMXNvaGVEZDVxWVdkMUhkNVFGWGhzcWNGQlB5Qk1FQzFnWUhXVnl1?=
 =?utf-8?B?S1NZSk9mWTlKQ2JDN3YrSS9UczlmRjZKWWdYRTMwQzlKeDROWjg4ZURVMU1m?=
 =?utf-8?B?REoySTR1WEppS1Y1azh2TEdsbGx5SWFPRXNIZnBXZzRqVkp2TnlmRUZNSWNM?=
 =?utf-8?B?RHVYTzBBdzlFZzlLRmJNTDZmQkZVck0yejFNTk50OEFNZndmUms5RGEyZ3J3?=
 =?utf-8?B?cFVMaTZxMXRCeno4bS9SS2lWU2o3MDA4djhZSFNrWW9TZndBYURwQzFKakxl?=
 =?utf-8?B?UGdxNWFubmc0Q25IekFrcVlPY2hWckYvTVJIUks0RVFzek1scGVVdUtSZmFo?=
 =?utf-8?B?eXVCZUtlOXl1aEt1THgrSlNPN2xSS3YvZEdLWTRMbWFxaXNhZ2N0TGZMaHpw?=
 =?utf-8?B?RXF6cFRDSlVwdFcyVSsyVmZEWHh2U0Z4QTVxQ0JjMzI5ZkQ1RHBVUlYxMmIz?=
 =?utf-8?B?emZOaUVBVW9TbzBBUk1jamptNmI2UGF2cDFYcmpzL004cUk5dGY4cnNWd3Zh?=
 =?utf-8?B?MEM4amZDOW5PS1lJYmRlMHIvdDZjbDUyeElZZ2E1UjdGa1kxR3hNV2ErY2po?=
 =?utf-8?B?KzVRMTZURmhKc3lXa2FBaVl5YUhyU2NvbCtrMHBnb0tyMnhZT21wWVg5QVhS?=
 =?utf-8?B?d2ZvWHk3SmRSTi90UHZFbXVOY3F4U0g1MXhjcitNTTR5TnpkRmR4ZDFUdlFL?=
 =?utf-8?B?ekgxdWZqUGpOZmlyNzE4TE1Sb3JGVXBVdDlDTG1NNDljdjRRbzEwWEhGcEdr?=
 =?utf-8?B?UG8vTmFlMTFEWERJKzhZYWQ3RGlDV3RQNFcyVzF5MTF3Y05OSlB5bTJ0eWVx?=
 =?utf-8?B?ZVU3RjhvT2I4T29ucmJFVm9NYTZUNDBMa0RITE9rSFdXQUM3S1lMTmtJRm9H?=
 =?utf-8?B?S01MRFJCcW5JR3R0dEZBaWxOTlFSem5FQ0dDOEc5MUxjL1VWR3ZvY3E5NXZE?=
 =?utf-8?Q?bl3GIOFFQjxOvik50PJwrRZLv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d65a75-4e38-42f0-da50-08ddb9819d22
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 16:00:49.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zrx3iX6rmPWtgt9QYfnBCeN0Drb+LZtfesWQLXNM6X606GYIAYqsKqmhG/SouZt3t0LO5mpdmPbEBwDjKp3cIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065



On 6/27/2025 4:53 AM, Jonathan Cameron wrote:
> On Thu, 26 Jun 2025 17:42:38 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
>> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
>> Type' for CXL device errors.
>>
>> This requires the AER can identify and distinguish between PCIe errors and
>> CXL errors.
>>
>> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
>> aer_get_device_error_info() and pci_print_aer().
>>
>> Update the aer_event trace routine to accept a bus type string parameter.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Thanks Jonathan.

-Terry

