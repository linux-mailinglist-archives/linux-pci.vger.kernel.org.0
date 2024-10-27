Return-Path: <linux-pci+bounces-15425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B639B1F42
	for <lists+linux-pci@lfdr.de>; Sun, 27 Oct 2024 18:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D9C2817E9
	for <lists+linux-pci@lfdr.de>; Sun, 27 Oct 2024 17:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FCA178378;
	Sun, 27 Oct 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XEDtyJcj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95CD14BF86;
	Sun, 27 Oct 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730048405; cv=fail; b=lmmuUY5t6Ldly/cyYCZHBB5MbeESp4cNmoSy33CaONTxLB3nC9mV1qwoQw7OrVg+dvLrdFRFfyC5tx6c/orvgBrKcvdQU9Avn8Prl7bmavx50qFJ733acio6QJYRh5VFHDYGaDJstJYWBCQ6YNkyh5mcRh5mucwkZVOYjjhUReE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730048405; c=relaxed/simple;
	bh=ePPc63xIzbOIiy3HQ45j8XHNqqiaIoK2tpW9S/q4418=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MqnGWogbRE4gkVk+qFb6FEbf1tLHpJiOcJT6amecNVWchmi2KTlrFJdnoopXqNgcH3sigf8CBMdvbZ+/pJPgqPcxu9DyIYIN2SpgrsePzgb4N1ABucxOkaAM94ldnJli12v0fnS2p97zzF+416PLhiBqyGRKpRhHk5RrKf00Qpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XEDtyJcj; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqcc+cEPmvAb4zUuAuvd8xW4yGC/t31f7QxDDp06wDqe3JmocCfjONMvX2q8TSqwMGeQMWfzZRa7T/4uuGC/ZSYHnpHkBuBLxAxyONTgWXQQeJOs+RdWVtjIF8otVcKLlq1zdDOvevkSg2r7FmpP+xGS1EJ/PpnK2ZUy1I9BUfqY5hY+lf8wY4W97KnXx39CyhtObJNv1ceZ8iuhxA6AwghgBflywQTW3Tyamzmt1UIi0CE0bhiXmxpDH8BjSRr9TrlqXvGkzBBu6xShC+A0eBc98l7JJpHr2UZg3v5BJyjSsrSiE643mr4XbusCZ9PZejZjTbVZ4C3GTXrJa1IsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAcpDX53UCppY5EGRPJdBVYgdRPksCRew6onENRrTB0=;
 b=fXML6bvacORlSd6FkzIVvrKlPEzs+9UYj0phzSmEvc/78Loc7AUB28dOWTY3YvuMVqOXVf/oLHMHz/o9HkfDHNjekamzM+IogHS1bvSjNPYovzwB2Bbl7LAlr58CVEQjMoCoOSiByxggmdcAXfwziH9ZB3FxObK5/elNwP3ofAoD8evJSdyrMafaHhjuQE+Jd2p8qvEINUfUr7mOwPnKdU73ZRD5srxZ+Fj+98mSWpT1QdZY1k0IVAModmM9FEM/46WOqP5gHJc3GJJyGA6fBDerhD6BAGXg/e2CcCYvSJV1uN+IpyUcywxfBkDu/66a5XPCGqzyvZxIUHXXfhXSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAcpDX53UCppY5EGRPJdBVYgdRPksCRew6onENRrTB0=;
 b=XEDtyJcj8y/jqtBWmM4bhTlTAcPzDVTU7LAnpw/ARjGeH3WrTNDRZPzmaPqDbWt2kaunzDXjFbTNwd5ghc1YSR5eowQFc0sK1OAs71a+C6UHn+WyLu/7NxxvVjL14BkNGTjh+rP83jwLFyqJfCc6c8syMR9I/NGtCO4FpjONeK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sun, 27 Oct
 2024 16:59:54 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8093.024; Sun, 27 Oct 2024
 16:59:54 +0000
Message-ID: <f765146b-b361-46c1-b11e-194b2b667adf@amd.com>
Date: Sun, 27 Oct 2024 11:59:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/14] Applies to Base commit: 8cf0b93919e1 (tag:
 v6.12-rc2) Linux 6.12-rc2
To: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:806:24::17) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c19c33-67f8-43c0-b1bb-08dcf6a8c785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjh5UXF1VVBSekY4S3NtcnczT1drQzZBQzZQSGNRSXB2dytKNURjVDE2UU9R?=
 =?utf-8?B?Ylg2SGFZZ3Z4d1QxWG5xUWdFN0sxU2loRGdlUjRKbFdlSktvZDhxRFU2SUxy?=
 =?utf-8?B?Y3FPMjBGSWVGdUFEN2lxVC9QdFJuN3NvTEJHK0VzZDVGYUl1Ukd6Q2pvbVlt?=
 =?utf-8?B?Y29sQUszaGErUkszRm9yVEp2b2lUTkJSYVJRR2dBNGxZcFJjTStPcDhVTmsv?=
 =?utf-8?B?V2hGNDN6bVVZNk03Z25PMnR1bkxFbmhQaHhCWUV2R0g5VUF1bXdabkxQc0xJ?=
 =?utf-8?B?OGJ4YkdNeTdSN3NaMmZadzhhV3JUaTMxWDBnR1hGMlVuUnNvTEsxTUcrRFlp?=
 =?utf-8?B?WUtmcFArNktKcjVvSEtuRkxTOEI0dEZaK3BtaGF1eEViTHAyaVRHR0NEb0p1?=
 =?utf-8?B?K1UwT3hOcHBuWHZjY1BRZVNCbWxHSXZTSTY4L1JPY1RrUXRnSVpMUDh1RjE2?=
 =?utf-8?B?Rlpjaml2NUxzZkVTTFlnd2puY0loZnBuUjBvVk4rTjUrbDRqVEV0RnlPL1oy?=
 =?utf-8?B?RTBBdkFOY0xSclZ1U0ZWT08rWjQzdnRUWWMvM243b0NBQ2F1UDYvOVp2WWl2?=
 =?utf-8?B?OE1mdUpmdHRCelRTVlhVL01STCtXcTg0czRKbGhIb2Qrd0loRml6V0FqMFQy?=
 =?utf-8?B?cHpQNlJ0SEZCMzdhTHpFRGFURmtrYmcwTVYyc3hlSjB6RFdRaFhTQjVyNG4r?=
 =?utf-8?B?UlNiZUloRUdzV29SbnBTeHJleUMzQVIvQWJOT0kvdVd4VS9GblBQOXVDVVRt?=
 =?utf-8?B?VEZwdGg1TTRKanNDSkFoRFNwUkpnYXFnYXJVZnlkUW1mWW5LRDF1YlhBdkZw?=
 =?utf-8?B?bmFTSUtuUytEVXNwUWtQSUJLTEUyTC9Sd3k0NGZ3L0tLWERyVXJ6aW4zVDdS?=
 =?utf-8?B?UFU3VURZZFdOSDdDOHNLaU5BcVp1cVBiTHZSWW55SDVNOGhxb0dOWkw2TUhG?=
 =?utf-8?B?TlI2THhOQk5xdFFPVEJKL0JnWGtlZWZLVFM0VEVJbWRuZEdyTnBMZjU3MzZ5?=
 =?utf-8?B?YUE2cExUb29JMWNCYlpjUXl0SVF1R2J3cUFVOVhvRVVHcEtFbVFSWXBoV21Q?=
 =?utf-8?B?REU5UzNwM2xIcWxnNUF0dXphZkpOYjVCdmo2ZDM2ODJzdVRjNW1rNDczcVdK?=
 =?utf-8?B?OE0rOGNBYkZsUlI1bi9TMENVQ3BSdVlUUDhYR2ZRQ1IyVTNydnVhcERlRVpr?=
 =?utf-8?B?cG1JR2FhVkplMURBcXVzbHVpQW9La1NmeGF6SlZDUkVQNDUrdzJhbi9kQVV3?=
 =?utf-8?B?M3Vnaml5V1ZVd3pReXBVY0tkMWd6d1VvMzh1RkhzUmtIMHlwVkRQOFVoa2l1?=
 =?utf-8?B?OW16dS8vLzZGV2VLYkVGRGhvSnMvNGxCdzIyT1lNbXlQdHR5TnZWckVqWXA4?=
 =?utf-8?B?MFAvbU0rUmJaNDZwclF5dW1UVmMrMlJSTGNJTHRFaE0xTUJjdTRtdDhYZDd4?=
 =?utf-8?B?Z01NaGg4RjNqTmYwZTgzdFZCNW1wVTJ1dVhrTEMzQXJCOWJqZ2RwekRFYXVh?=
 =?utf-8?B?cXRwelc0UjRlU0xpTFVsdUZxU3FJVTZhdEEveVRMektONE53alBIRXNMUjli?=
 =?utf-8?B?ak5WdnZIU25iZEUzWGIwb0R6T0dWRTlxTjhUcVZpdmk2bXVOQkRiVVhKVCsv?=
 =?utf-8?B?QkVMZHV3MlBRYXVtRmZ0RmxJMmNmRERRVXVXc2NrUmJOZm91TGhBTThIYnpn?=
 =?utf-8?B?RmVINjFrQkVxWmVPRm9tK1RQcnFzYmZnRWtZOExWc2diN0t1Z3dkSmdWcVNU?=
 =?utf-8?B?Q01XVFp0a1pIRlY1bnEyY2VWeWV1VzVSM3kvVEtzL3hSRWRkVVVnK0hHN0FU?=
 =?utf-8?Q?i0MTQAvdyk5Cs4d5mmJY6GalVi5jFbXK7PC1E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0pOcWpWOEJQLyt5dm0yVzFzTkRUUkR3bnUrTDY5Nk5WYTFyMU9pWUpaSllU?=
 =?utf-8?B?aUNkalZUMzE5Skd1cVZkOXpMdVdCWXVyS3gvY1JGREcyR3BzdEV3OE1RcG1O?=
 =?utf-8?B?aktNS0FDbVh6L3BCNnJQM0pvWWlHMm1NUWxlb2hLWmd0Y0toUzVIWFlncGhP?=
 =?utf-8?B?TC9WbzliY3JneE5yZUQ3L2dscnU3Vkc4cXV2ZWlSVkxBZjlqY0tFR2dsdzlI?=
 =?utf-8?B?dytrQ0ZkRU9tb096L29GYUZQRzRRa0NsL1REQS9HU2NIbjdnRTV5UTRIRWZa?=
 =?utf-8?B?RVhHZmhBZXMvb2QxU0plNm5LNXR0dC9ZVUtVaU5HZ3U2d0hSN2lHbDZwRFh2?=
 =?utf-8?B?WHlEeUZzS1FHdHdRakxEL0tWZnBZajFmZWNQdUJZTWNwT2ZKbkhOYmVvUGpk?=
 =?utf-8?B?NXlIYThSc3piWmlhMnoveWt5enhpTnJpWHNZTGFDUjgxYjZnWTlxUzU4L1FT?=
 =?utf-8?B?a2lnSzJTTFFUS1RQejRFMXZTSHE4eGcxbGlVNmgwSFlMWG5mYkMyV1RrNEpS?=
 =?utf-8?B?UzlDSFk4cXZUOWxqdnlKcnpYRDZHYzNNanRsbmF6R1VRV3pQV1hBM2VEbERz?=
 =?utf-8?B?TGQzTTlUclJ6ZkRMM0NnMnk2RmlyZVdXc0Z1STNzanJxL29xSEpSTVJnc2c1?=
 =?utf-8?B?MUNQMXp0djdMYlFqZklZSGJRVWhmak1Pc0QvYmtjd2tJd2FKUVNITzRYRjQy?=
 =?utf-8?B?bWNBMFFpRkljTEZ6RldYSHlXNEp2QVN1aDVSY1IzY0Q0YjRjTmsxYTAwRUxO?=
 =?utf-8?B?azhDNmkvTXNQTmtpOUF3d0NhNmVQcWkrVmlWcDhLVWdTbEhBcThvQ0hQN1Rr?=
 =?utf-8?B?c0gydXlxVkZ3TjBtWWhDbXVpUitldEhtT1dyekZoMnFBZGJpb3FvaXFSdy9U?=
 =?utf-8?B?bE5XUlR5SlpraEFOY2xoWlBnT2lyRXVoenRpM0ZFYXVMUDZZbzV6ZXI2c3Z2?=
 =?utf-8?B?Q1p1VDY4VVhnSFcxRXRzZi8xSDF0dGd2QVZqZTViRXhDUnRJMXdsRmxZOWlt?=
 =?utf-8?B?bExvdWpzSnFiY0VTR2hGQ0t1aHpwZ3IxTWhMakx3NnJlclYxUDJrZzZhRTB2?=
 =?utf-8?B?YlE0MGFKWmRWRXp5YmxHWW5qazU5RTE3VjAwMC83b1VUZjArc2x6RldCN09x?=
 =?utf-8?B?S0VBSFQ2NEcrbTlWbm5hazU1bG8rclh5M1c1SWVCY0FvWWtpSTNnRGptNGlo?=
 =?utf-8?B?SWFPaVFvU3lBYUpaOTBqaGJIL29EenNnSkZNcHBpQ2poeVdRUDZTL3I0ZUhy?=
 =?utf-8?B?bEdZbXFxY3JwTUhlZGxycjhsc1gzQlVjZVM0c0x2QWdEdDVLYm5pVmwrN3R4?=
 =?utf-8?B?eTk0a1RscUY1cElnTjdXeXhVWWd4VzUyU3FZSXFvRHEwSnJIR0lQVnE0WkU4?=
 =?utf-8?B?K2FVSTdDZURya0doTGpCQmNwamNtaFJGQkU2ajF2MEdadEIwcFVGRW5BT1Bu?=
 =?utf-8?B?QzBLejZZNmtuV0FWZ0ozSlp3Q1VUSkx1M0QyUVBDSUFSZU9lYmQxTDJ1WHBL?=
 =?utf-8?B?MWNYc1I2Qmppb1Y5dFZuNjhCUFBXcHl4Mmc5N1Exbk1KYVQ5UHNUa0V5eDRk?=
 =?utf-8?B?bjZmOS9Wc1Z0WGE3U2JPcnBCRHZKYVhRS0U1VVRTaEN2djFkU3dUYmp2bURO?=
 =?utf-8?B?YmRKdXQ1Z0ZyWkVPOTAreFZPR1hNN0pkTDQzU3p6MU1LOFZ6TGcwUlRlMWVZ?=
 =?utf-8?B?WVlISTA1dVVrY0NCZmEvazVZWFV0VnJwcElwbmVNUU84eHF2YW95RWNhQURm?=
 =?utf-8?B?UFUrT0xwVHJsR0EwUUVaNk1qSkpPWm5rVmdCRWZsNFZnaU43VWgxL1o0TW1P?=
 =?utf-8?B?Y1FsQ0Robk1QZnJTS0VHVFNQelJKbzkwSDhkdHo5ZDFxd0tGRWdCckFwZnNP?=
 =?utf-8?B?elNKbmZId0ZKQVFRV2ZBRmhKbklHckc0aGFzakJaS0dYaGsybVdNMkpTTG5w?=
 =?utf-8?B?dEF0SElkWDZpQTd3ZHlzbUNucC93ZDRQTEdmSm54aGNPcmlXTlVxRUh1QUxZ?=
 =?utf-8?B?V1lDVTMvOFhyVjZnTFJTQzR1azh0Q1dDRVdnSkRRRGpBejlBQ1ZlM2p6b1lj?=
 =?utf-8?B?aTRBUWd3T2pYbkllV1phZmZGdFdETmNKb0llalNpRmVObGdlRHJkQ1pFL0Fo?=
 =?utf-8?Q?CJpj7olEQS3rMJs2yIqzbH66G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c19c33-67f8-43c0-b1bb-08dcf6a8c785
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 16:59:54.4976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xhvwjgX8e6FttQUOYmWAq1FNJ1m/EWSkHMgtuxv0VNirNRuUKaJ5/1TksuBxdODotbrYvAYzKsL41Ctqv9QeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841

Correction. This applies to:

8cf0b93919e1 (tag: v6.12-rc2) Linux 6.12-rc2

On 10/25/2024 4:02 PM, Terry Bowman wrote:
> This is a continuation of the CXL port error handling RFC from earlier.[1]
> The RFC resulted in the decision to add CXL PCIe port error handling to
> the existing RCH downstream port handling in the AER service driver. This
> patchset adds the CXL PCIe port protocol error handling and logging.
>
> The first 7 patches update the existing AER service driver to support CXL
> PCIe port protocol error handling and reporting. This includes AER service
> driver changes for adding correctable and uncorrectable error support, CXL
> specific recovery handling, and addition of CXL driver callback handlers.
>
> The following 7 patches address CXL driver support for CXL PCIe port
> protocol errors. This includes the following changes to the CXL drivers:
> mapping CXL port and downstream port RAS registers, interface updates for
> common restricted CXL host mode (RCH) and virtual hierarchy mode (VH),
> adding port specific error handlers, and protocol error logging.
>
> [1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554-1-terry.bowman@amd.com/
>
> Testing:
>
> Below are test results for this patchset using Qemu with CXL root
> port(0c:00.0), CXL upstream switchport(0d:00.0), CXL downstream
> switchport(0e:00.0). A CXL endpoint(0f:00.0) CE and UCE logs are
> also added to show the existing PCIe endpoint handling is not changed.
>
> This was tested using aer-inject updated to support CE and UCE internal
> error injection. CXL RAS was set using a test patch (not upstreamed but can
> provide if needed).
>
>  - Root port UCE:
>  root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
>  pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
>  pcieport 0000:0c:00.0:    [22] UncorrIntErr
>  aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>  cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
>  Kernel panic - not syncing: CXL cachemem error. Invoking panic
>  CPU: 1 UID: 0 PID: 146 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc2-cxl-port-err-g2beab06a67d1 #4414
>  Tainted: [E]=UNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x27/0x90
>   dump_stack+0x10/0x20
>   panic+0x33e/0x380
>   cxl_do_recovery+0x116/0x120
>   ? srso_return_thunk+0x5/0x5f
>   aer_isr+0x3e0/0x710
>   irq_thread_fn+0x28/0x70
>   irq_thread+0x179/0x240
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_irq_thread_fn+0x10/0x10
>   ? __pfx_irq_thread_dtor+0x10/0x10
>   ? __pfx_irq_thread+0x10/0x10
>   kthread+0xf5/0x130
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x3c/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Kernel Offset: 0x29000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>  ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
>
>  - Root port CE:
>  root@tbowman-cxl:~/aer-inject# ./root-c[  191.866259] systemd-journald[482]: Sent WATCHDOG=1 notification.
>  e-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
>  pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
>  pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
>  pcieport 0000:0c:00.0:    [14] CorrIntErr
>  aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>  cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='Received Error From Physical Layer'
>
>  - Upstream switch port UCE:
>  root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
>  pcieport 0000:0d:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00400000/02000000
>  pcieport 0000:0d:00.0:    [22] UncorrIntErr
>  aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>  cxl_port_aer_uncorrectable_error: device=0000:0d:00.0 host=0000:0c:00.0 status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
>  Kernel panic - not syncing: CXL cachemem error. Invoking panic
>  CPU: 1 UID: 0 PID: 148 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc2-cxl-port-err-g2beab06a67d1 #4414
>  Tainted: [E]=UNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x27/0x90
>   dump_stack+0x10/0x20
>   panic+0x33e/0x380
>   cxl_do_recovery+0x116/0x120
>   ? srso_return_thunk+0x5/0x5f
>   aer_isr+0x3e0/0x710
>   ? free_cpumask_var+0x9/0x10
>   ? kfree+0x259/0x2e0
>   irq_thread_fn+0x28/0x70
>   irq_thread+0x179/0x240
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_irq_thread_fn+0x10/0x10
>   ? __pfx_irq_thread_dtor+0x10/0x10
>   ? __pfx_irq_thread+0x10/0x10
>   kthread+0xf5/0x130
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x3c/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Kernel Offset: 0x24c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>  ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
>
>  - Upstream switch port CE:
>  root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
>  pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
>  pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
>  pcieport 0000:0d:00.0:    [14] CorrIntErr
>  aer_event: 0000:0d:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>  cxl_port_aer_correctable_error: device=0000:0d:00.0 host=0000:0c:00.0 status='Received Error From Physical Layer'
>
>  - Downstream switch port UCE:
>  root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
>  pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
>  pcieport 0000:0e:00.0:    [22] UncorrIntErr
>  aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>  cxl_port_aer_uncorrectable_error: device=0000:0e:00.0 host=0000:0d:00.0 status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
>  Kernel panic - not syncing: CXL cachemem error. Invoking panic
>  CPU: 1 UID: 0 PID: 147 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc2-cxl-port-err-g2beab06a67d1 #4414
>  Tainted: [E]=UNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x27/0x90
>   dump_stack+0x10/0x20
>   panic+0x33e/0x380
>   cxl_do_recovery+0x116/0x120
>   ? srso_return_thunk+0x5/0x5f
>   aer_isr+0x3e0/0x710
>   irq_thread_fn+0x28/0x70
>   irq_thread+0x179/0x240
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_irq_thread_fn+0x10/0x10
>   ? __pfx_irq_thread_dtor+0x10/0x10
>   ? __pfx_irq_thread+0x10/0x10
>   kthread+0xf5/0x130
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x3c/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Kernel Offset: 0x19c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>  ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
>
>  - Downstream switch port CE:
>  root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
>  pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
>  pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
>  pcieport 0000:0e:00.0:    [14] CorrIntErr
>  aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>  cxl_port_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 status='Received Error From Physical Layer'
>
>  - Endpoint CE
>  root@tbowman-cxl:~/aer-inject# ./ep-ce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000040/00000000 into device 0000:0f:00.0
>  pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
>  cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
>  cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00000040/0000e000
>  cxl_pci 0000:0f:00.0:    [ 6] BadTLP
>  aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Bad TLP, TLP Header=Not available
>  cxl_aer_correctable_error: memdev=mem1 host=0000:0f:00.0 serial=0: status: 'Received Error From Physical Layer'
>
>  - Endpoint UCE
>  root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00040000 into device 0000:0f:00.0
>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
>  cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
>  aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
>  cxl_aer_uncorrectable_error: memdev=mem1 host=0000:0f:00.0 serial=0: status: 'Memory Byte Enable Parity Error' firs'
>  cxl_pci 0000:0f:00.0: mem1: frozen state error detected, disable CXL.mem
>  cxl_detach_ep: cxl_mem mem1: disconnect mem1 from port2
>  cxl_detach_ep: cxl_mem mem1: disconnect mem1 from port1
>  pcieport 0000:0e:00.0: unlocked secondary bus reset via: pciehp_reset_slot+0xac/0x160
>  pcieport 0000:0e:00.0: AER: Downstream Port link has been reset (0)
>  cxl_pci 0000:0f:00.0: mem1: restart CXL.mem after slot reset
>  devm_cxl_enumerate_ports: cxl_mem mem1: scan: iter: mem1 dport_dev: 0000:0e:00.0 parent: 0000:0d:00.0
>  devm_cxl_enumerate_ports: cxl_mem mem1: found already registered port port2:0000:0d:00.0
>  devm_cxl_enumerate_ports: cxl_mem mem1: scan: iter: 0000:0e:00.0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
>  devm_cxl_enumerate_ports: cxl_mem mem1: found already registered port port1:pci0000:0c
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4500
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4500
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  <snip>
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  cxl_bus_probe: cxl_nvdimm pmem1: probe: 0
>  devm_cxl_add_nvdimm: cxl_mem mem1: register pmem1
>  pcieport 0000:0e:00.0: RAS is already mapped
>  cxl_port port2: RAS is already mapped
>  pcieport 0000:0c:00.0: RAS is already mapped
>  cxl_port_alloc: cxl_mem mem1: host-bridge: pci0000:0c
>  cxl_cdat_get_length: cxl_port endpoint4: CDAT length 160
>  cxl_port_perf_data_calculate: cxl_port endpoint4: Failed to retrieve ep perf coordinates.
>  cxl_endpoint_parse_cdat: cxl_port endpoint4: Failed to do perf coord calculations.
>  init_hdm_decoder: cxl_port endpoint4: decoder4.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
>  add_hdm_decoder: cxl decoder4.0: Added to port endpoint4
>  init_hdm_decoder: cxl_port endpoint4: decoder4.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
>  add_hdm_decoder: cxl decoder4.1: Added to port endpoint4
>  init_hdm_decoder: cxl_port endpoint4: decoder4.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
>  add_hdm_decoder: cxl decoder4.2: Added to port endpoint4
>  init_hdm_decoder: cxl_port endpoint4: decoder4.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
>  add_hdm_decoder: cxl decoder4.3: Added to port endpoint4
>  cxl_bus_probe: cxl_port endpoint4: probe: 0
>  devm_cxl_add_port: cxl_mem mem1: endpoint4 added to port2
>  cxl_bus_probe: cxl_mem mem1: probe: 0
>  cxl_pci 0000:0f:00.0: mem1: error resume successful
>  pcieport 0000:0e:00.0: AER: device recovery successful
>
>  Changes in v1 -> v2
>  [Jonathan] Remove extra NULL check and cleanup in cxl_pci_port_ras()
>  [Jonathan] Update description to DSP map patch description
>  [Jonathan] Update cxl_pci_port_ras() to check for NULL port
>  [Jonathan] Dont call handler before handler port changes are present (patch order).
>  [Bjorn] Fix linebreak in cover sheet URL
>  [Bjorn] Remove timestamps from test logs in cover sheet
>  [Bjorn] Retitle AER commits to use "PCI/AER:"
>  [Bjorn] Retitle patch#3 to use renaming instead of refactoring
>  [Bjorn] Fixe base commit-id on cover sheet
>  [Bjorn] Add VH spec reference/citation
>  [Terry] Removed last 2 patches to enable internal errors. Is not needed
>  because internal errors are enabled in AER driver.
>  [Dan] Create cxl_do_recovery() and pci_driver::cxl_err_handlers.
>  [Dan] Use kernel panic in CXL recovery
>  [Dan] cxl_port_hndlrs -> cxl_port_error_handlers
>  [Dan] Move cxl_port_error_handlers to pci_driver. Remove module (un)registration.
>  [Terry] Add patch w/ qcxl_assign_port_error_handlers() and cxl_clear_port_error_handlers()
>  [Terry] Removed PCI_ERS_RESULT_PANIC patch. Is no longer needed because the result type parameter
>  is not used in the CXL_err_handlers callabcks.
>
> Changes in RFC -> v1:
>  [Dan] Rename cxl_rch_handle_error() becomes cxl_handle_error()
>  [Dan] Add cxl_do_recovery()
>  [Jonathan] Flatten cxl_setup_parent_uport()
>  [Jonathan] Use cxl_component_regs instead of struct cxl_regs regs
>  [Jonathan] Rename cxl_dev_is_pci_type()
>  [Ming] bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_uport) can
>  replace these find_cxl_port() and device_find_child().
>  [Jonathan] Compact call to cxl_port_map_regs() in cxl_setup_parent_uport()
>  [Ming] Dont use endpoint as host to cxl_map_component_regs()
>  [Bjorn] Use "PCIe UIR/CIE" instesad of "AER UI/CIE"
>  [Bjorn] Dont use Kconfig to enable/disable a CXL external interface
>
> Terry Bowman (14):
>   PCI/AER: Introduce 'struct cxl_err_handlers' and add to 'struct
>     pci_driver'
>   PCI/AER: Rename AER driver's interfaces to also indicate CXL PCIe port
>     support
>   cxl/pci: Introduce helper functions pcie_is_cxl() and
>     pcie_is_cxl_port()
>   PCI/AER: Modify AER driver logging to report CXL or PCIe bus error
>     type
>   PCI/AER: Add CXL PCIe port correctable error support in AER service
>     driver
>   PCI/AER: Change AER driver to read UCE fatal status for all CXL PCIe
>     port devices
>   PCI/AER: Add CXL PCIe port uncorrectable error recovery in AER service
>     driver
>   cxl/pci: Change find_cxl_ports() to non-static
>   cxl/pci: Map CXL PCIe root port and downstream switch port RAS
>     registers
>   cxl/pci: Map CXL PCIe upstream switch port RAS registers
>   cxl/pci: Rename RAS handler interfaces to also indicate CXL PCIe port
>     support
>   cxl/pci: Add error handler for CXL PCIe port RAS errors
>   cxl/pci: Add trace logging for CXL PCIe port RAS errors
>   cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers
>
>  drivers/cxl/core/core.h       |   3 +
>  drivers/cxl/core/pci.c        | 180 +++++++++++++++++++++++++++-------
>  drivers/cxl/core/port.c       |   4 +-
>  drivers/cxl/core/trace.h      |  47 +++++++++
>  drivers/cxl/cxl.h             |  10 +-
>  drivers/cxl/mem.c             |  29 +++++-
>  drivers/pci/pci.c             |  14 +++
>  drivers/pci/pci.h             |   3 +
>  drivers/pci/pcie/aer.c        |  99 ++++++++++++-------
>  drivers/pci/pcie/err.c        |  54 ++++++++++
>  drivers/pci/probe.c           |  10 ++
>  include/linux/pci.h           |  13 +++
>  include/ras/ras_event.h       |   9 +-
>  include/uapi/linux/pci_regs.h |   3 +-
>  14 files changed, 396 insertions(+), 82 deletions(-)
>
>
> base-commit: 739a5da7ed744578a9477fb322f04afecafca6b0


