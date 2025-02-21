Return-Path: <linux-pci+bounces-21943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B37A3E967
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 01:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79C91885875
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 00:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A31479F2;
	Fri, 21 Feb 2025 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MvH8GtZ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2517D1CAA4
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099215; cv=fail; b=ZlSMm6T/Uvq/DX2GSczVnt/4m53MKM+d3jivdPssawqeOdbzMLh8Mhup5R4B6lNOA63zr192nWsxLdrv8shEGJD9L9HkNbOaUnV+Avisy4eC3Ullh4WkS5EbRIS4gRRSPzoo9l52WYgpp8lHKy4ZW5o7EcNADr9odtp5XO0qImE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099215; c=relaxed/simple;
	bh=jFRDcC5KTPs/CJBSqbmOlr3NtZHlIj9bBQmD1QZSSm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PsnMGJ0NL0M5qPjWMG40N10HWItntgnOZl4wma2ffUfKpXb+rIHNxVSTz7nfPsuqEBibc8V0bLREpWgDHZrpW+hh5MWLsJItETD3L6aoGjNuceTZVOIRUT+K5RMC8i45H7AdvQ5q6SsXin1rs4ZeWE420J2/j4J863bI6sWhu5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MvH8GtZ8; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJAUDvDBOAYTiulpW0/qCGmTieye+LFz/5MsM/+EhJy4g2NCPOTM0gG/AP8S/frW/+rjNRPAyhOsITAXHevd+HgytkCJftszoDQUuw05pWB5QR9B1HPlDURQDsNm5XLFoKxLQAd1/X6Nu7icAJsSkorcb5gQJlb+8BFmK9Brn50ZIjUTsGm4Q1/ZZilwpHbSY/nt45NFkBECE7wYvjZcXE+qVvYzCau/9rEuUSeMO0m2MB7kvcniKgJuhonHxN6tismXWBJ9CvRforxsueS2wAzuE2Z43+DunBFLlpR66NBj2OVmIaOxovF82VVOhuncQjjuiBlUpHDnUXyVxfbeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMp8+pNWnN7Uas2henBBO8lUn0GqYMNnwnFGwuQFJng=;
 b=QKj25FkHl71E18DOFwcUADhejGSIMnEoe0W3WJ2zKeoSGeP1HTHrhdvqFUFTqWTp2JISGEhiAs1Q9sz9ERry3ZR4f0Y7lUzvTs4ZYisS60BwA3DMUNf+5ZJNIYzRObawyGvEbDw9SNNZGGSr9U3sKtWOiRhjIlaLwb+GI/C/PjRF9hsKOmbNMxAH0X/dDx0hLjxebPI9qCraq7EEm3GIaN6Z7N/dGZwW8sdaOxVwiTA4FeK76SyQDwJms/yO+cnlwefjKd6+QFQJKnIO60NkZ+oLw2Xn5wb5G8qjHuP1AFvS6/GiTNWecau0pfWHIBPpYml7n3mNJCHSBOmJ8o3WSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMp8+pNWnN7Uas2henBBO8lUn0GqYMNnwnFGwuQFJng=;
 b=MvH8GtZ8+X48YOAS8AHa5Zh1lpOYrPuBQBasb8uOPvihwt5uq9h+/b64FxWlXAT4c4QRUoX3NMWHk29fpVzH02abvxtKBPRWi8HSDzd5HGNphbbkcP5M0a6rVyphYYogxDQN8zzEmLEOgaZm8oSmL/ACDOezy/BH0zrCnkf0sbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 00:53:30 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8445.016; Fri, 21 Feb 2025
 00:53:30 +0000
Message-ID: <fb236418-eaf7-4ff1-bf69-70b003be4ea1@amd.com>
Date: Fri, 21 Feb 2025 11:53:20 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
 <2e7f85ea-40ce-4b38-acd9-56c02718771c@amd.com>
 <67b76f5663f7f_2d2c294e2@dwillia2-xfh.jf.intel.com.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <67b76f5663f7f_2d2c294e2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a87b25c-c241-4218-d72e-08dd521228b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aCtEOUVDQjNKYjFtaXBlY0JNbmpRdzlLdVdNclc5YkIyN1dMbmNVdEpyTG1G?=
 =?utf-8?B?dER3bXB3dXlPd1BiVlNTOEdTWFZJNnBWWUZabjVYa1BMT0JQZm94QXdtazN2?=
 =?utf-8?B?c3BvMFlDc3pLNVRGeVV0WmM4MEhGMi9XWHh2c3dpc3dEWEh4UDlRYnZiN3FX?=
 =?utf-8?B?Q04xRXBlVUFZUTlzZEEvWUlwNmJiaklWN05qVG13cEVPZjR2d2dwY0dNdm9h?=
 =?utf-8?B?SDRWY1VPMlJTWDhVVVRsZnhhNDBIYmxNRmdrdFFSTEh3L2VqazFEY0RTSkdy?=
 =?utf-8?B?MC9rbFlXalAwMk94U1dvdHRaS1lEVnVpODJpdzkzYVpnSVRwMnVDSjFJZFln?=
 =?utf-8?B?MUQwSGtsYU9LWmI2T2R3TndDZlA2RXU0dkxpQU1mZ01ZN0QyTlQySFhjc0pH?=
 =?utf-8?B?SzdDeVhxZ0V0UUxvaExtUk8yOTVMbUpDZjlIZG9pYkFtaUdwa3hNdzFUSHd1?=
 =?utf-8?B?eGxaV3FIT2FCbCs2eDZFbUJGcTZaSDJ4eUtXQm1GdEt4ZGNmeVc5ZERyb3h6?=
 =?utf-8?B?dWYyVDE2OGdIWURySTB2ZXNhaTlXa1kvaVhzMHhTZDFCZmVhTHNKelB1WFRp?=
 =?utf-8?B?Z3dkR01NajZzRS8zL1QvSEVicGExZi9zVzRTYlVtbEZxOG1SdktsQkt5TzZ5?=
 =?utf-8?B?b3RqbkNjNVAwVFB6TnI2THlhTEJzRUplYi9QcUdDdnNhaDdWYW1oNjNQNGpS?=
 =?utf-8?B?UEhZWGJVdEczL0h3c2trUlk0OXJkc2twaW45S2NWVHZXaFZIb3hha3N0eEdH?=
 =?utf-8?B?dzhZeHRDRlBHa1RRN2UySFh4aUF6N25aQWVMMnZ1ZDdnSHA4N3p5NUF4K1RF?=
 =?utf-8?B?SGNYaHUyZVNCNGpieEV6Z0dGc2R2OXNEMkxVdlRKbVNObU0zRUdzNy81NU91?=
 =?utf-8?B?SU5YdE9tMHR2U3daWE4wVmdKQ1g4WTBOSmM0MFptMmY0QXNpQzNIRThFcjJD?=
 =?utf-8?B?WU5hQVBFemdlOVBLekJCQWNuS0RENUgvcklnM1FXTis3c3I5bXdOTjJQZGRo?=
 =?utf-8?B?YW9WNDZ2ZjNCVkYvNUhydU0xN296MXFJWjkrSTBxbXQ5a2x2ZXBlTzRzNTdX?=
 =?utf-8?B?SXN4dm5tRU9wcTErMXRUUVBqZTFtYVdWZWM1Q2txMkcvdVdqVDQ5WFFCU3VS?=
 =?utf-8?B?U0RVTy96Z2VlT1RJYkRlTE9vWWk3SzJXUUJ1dkVHSXhnSFFVTzM5Y0VWS2lr?=
 =?utf-8?B?b0RCTmJZUHFaSGZhWEpaakF6SGJBbUhjOFNDSUZGeGJkZkhYOW9vTkRVcG1r?=
 =?utf-8?B?MDFxR05Sb3VxNkRoV0RVOUNQUjJmZ2g3NDhnS1hseVZDMVdqNjZCQmh5MWxV?=
 =?utf-8?B?dmcyMXptT241Ymt1QWovcS9vakJHRTNWYWlwQ1c4Y2VuOXI4N0pBTE9mUmpa?=
 =?utf-8?B?di9EVVNENkVXVDlDTml0YU5JeEplOXpUVGF3UU9OdmRwV3F2Z05pUmFPWkx3?=
 =?utf-8?B?YlppQUlJTXV4UzZpckFMMkx3VXNuTkQvejk4czhIWTBCdU81NzNtdk5DMWVW?=
 =?utf-8?B?S1BSNnVEdjZkY21KdUR5SnRDaU9KcWhhTTd2L2xTTXNJc21OREVnR2ZtdzZm?=
 =?utf-8?B?MHJDQTB6d1QxQitUTUhxd3ovV0FoekExRkw5aWl0TTh6Q2pGck8wYVdqaUZO?=
 =?utf-8?B?TzBGNUMzMEt0UUJ1YkxQT1I2QTVsOCs3NVpXVzd1MEdQdHpCTDhnRlkxampV?=
 =?utf-8?B?YlBoTVJza2lNSkh4SHNSMVdGWGVLSVk3U1dxa2xkUlg2VGdzcXVZZGQyRTUv?=
 =?utf-8?B?YmZ1Z3kxdUJJRnZldkhSL0ZDTmplbXo4Z0l0ZXVEekNjSVNZU3VlWkhORko5?=
 =?utf-8?B?aWx2eExHZ08yRlJYREI4M0owakRoMXQxYjhLWUZyam0vcXljLzJjYzl6T25u?=
 =?utf-8?Q?W2+RYM5i6OB9I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGR0T21XM1FwOHgrT1pleGdudWRjQlV2UGh3UndHekZGYjA1MWV1b0pBaXhm?=
 =?utf-8?B?b1NVSitUc0Q0dU5wc3J0a0NsRG5GWUZmbU9pSElJTkw1UGRidXIrY1pLaDY4?=
 =?utf-8?B?L2w1YW1tQmtlTHZMMTVTa0x1a215VkFlMTZXSlpvU085cTNNbXZ1NnJqdjFx?=
 =?utf-8?B?TUxoRW9HQ1ZhKzNWdFYrUXhKb0s3K1oyeDBoSkZUQWx6OWM4ZWtRR0dibEQw?=
 =?utf-8?B?WW1Jc25PNk5KcmViZ2lIWERaMFIvTjRHTHpFQzRGMktDRTJWZ3VoYlNiUFRT?=
 =?utf-8?B?b2xOT21kdlN2ZlRhc05lZEQ3SUNBMHJ2MTRzNG5DTWNUNEVpNkt4RnN6dHgr?=
 =?utf-8?B?VUdvZWlyanphL2lBOGRxZTNhbW8yYzZBL3h5L0kzWFVvV1FOclhUZHpCWkNB?=
 =?utf-8?B?cloxd2htSUh0SkM1Syt0S1E5VVk4NVlyMzlYcEpjeHZNSkg3Yzg1OFVEVXlP?=
 =?utf-8?B?T3dWTzNXSmdYSXBvK1JLZ040bXEzKzBMSjRPM2gzZ2VHVjJ4NTlLaVNTVEF6?=
 =?utf-8?B?eGg2VGpSbDB1NlN5ZnVDMFdBQ01mQmNtdXI2bXVJVEpXQjRrTG5BWmtFYXM0?=
 =?utf-8?B?Z3VDVFRlVkk4UTdRM0tBZHBxamVSdVR4RzNITllxSDI2SFF0bU1sS3FWRlZB?=
 =?utf-8?B?YURlUlpTQjlwcENMYU16aGpEWkNJbmRENk51SlF1c2tJblcwb3NIbW1Sc24z?=
 =?utf-8?B?anhCcThzTzFYM0NQS055Y01OVjVyUGNQRXRjYnliWHZsb3poQkQyK2xuZTZE?=
 =?utf-8?B?TmlhM2E1dTQ5MUVkREhPZm5OYkxIRGZYdFhHY3Y5RFM2RTk4RjRpeEJsUXFn?=
 =?utf-8?B?Nmd3b28wbnd0bzZwNG4yYUtHRWswaThMbWhDUTI4NGhsMUZteWtRUUpTOFdT?=
 =?utf-8?B?Wk4yQU5vanQ0bkRrVkExc2I3ZHdVTUZDc1MwckxtWldGZktkRkkrTlFpQWNJ?=
 =?utf-8?B?TlNwTzNGU2xIbWF0UnkzRU5qUS9RbUt6djdxTnZwTDFRaE05SEhXZDd6WU04?=
 =?utf-8?B?QXVSNHdTcDlVeXJpSkRWT2xUK0tNVkNxdHBMcXRFb29WTGhtSVU0OXFYU3Iv?=
 =?utf-8?B?Q2l5aXVCcXlYS01CMzhnOEpWM2ExOElDN3pOZUNteUlKTFFaUHdsdWR4b2xj?=
 =?utf-8?B?b251UUowUlpySEcyMk1hR2RncGFrc0UrYjF4Ky9TQmxrMTNEWURrZ1l0TVV2?=
 =?utf-8?B?YnlCbzFqZWJDSWFtdnZibklkU00yVFYrei84K3ZPMEhvYkFreHh4VFBhYjkw?=
 =?utf-8?B?L0RndG9MMWcvU3JrUlUxaXJLRnlabCtmb1ZXM3dSUXRtS3hjN201S1crTkdR?=
 =?utf-8?B?M0xDNXp0cEIySUk1UnY1M0NyZ1Z5OEpGTFpNdmNpZTFXZjI3eFhSQys0UXRL?=
 =?utf-8?B?aGVrZ3lxYS9EM1R3aldjZEVMTktyMTBDaXg5MktVekxCR0lsOCtHR0VNNjVC?=
 =?utf-8?B?VEE2V3g2alJlZkRocGZldE5nQlVNbXZSK1VkdzdBQjZ3d1JIbHJSUlFjbzZo?=
 =?utf-8?B?dnhHSmkrNEFBOURFVlRMb2lBamlyekQ5enZ4enBWY20yMlRveTBCcGV0eEZV?=
 =?utf-8?B?UURyU2pVZzk5YzI2MFVnLzQwWmduVDVLL2w5OE9mZEliSnY4VHQwKzh4clJY?=
 =?utf-8?B?aDNpRnFuR2x1ZFgyc21HTnUwSUpKbkh0UkIvOFBUSzUySHZEaENIZGZ3RlFi?=
 =?utf-8?B?d3Q1NDF1VnhXOU5oTDdBZzBLbFNFd3lmK25pODdoZyttOUtvZ09iWnNlazZS?=
 =?utf-8?B?RkNWZ2NCSDdWQ1A3RmlKMHdyZ215ZitycVRxZkV3VFp0WXVRb2V3R3hmd2Fl?=
 =?utf-8?B?Z1JSQkY1QTZwR1lKTmNzTktJNTEwOW1paVJPRjd6dWlkQzR2NUFkS2lHb2cv?=
 =?utf-8?B?ajkzdDE5Z1NsNEhubUVsZW83amhiUVBrdWF4M0FQZ3A1YWJpMzdjaEozcWR1?=
 =?utf-8?B?a0c3czd0ckJYRWtrNjRCdC9GcDlGMVJxKzQzM1ZxVHBoQ1lYcVFCcnNMQkZY?=
 =?utf-8?B?ODF2V1d1SGt2Z3k3UGR4T1BxcXl3Q2RKY2gzdGR6YTlYemZxWkFFcUhXaktC?=
 =?utf-8?B?ZVBkUEoxNmhZQ0RNSlpYZk9ONUtwMDV2WktONVh5RWw5bnJSZ2orTlpFZDJu?=
 =?utf-8?Q?0a9fm+eZ34Eqxly6yANvtMcMX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a87b25c-c241-4218-d72e-08dd521228b5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 00:53:30.3823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fe5fiAmLh2w1Nk+UTSkcewkPNcYWJbovVH2uX5VvH1jW23AzVizSkQxO3gIQIcCTnFewR//ZYhqZbfwL8aV1YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466



On 21/2/25 05:07, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
>> On 6/12/24 09:23, Dan Williams wrote:
>>> Link encryption is a new PCIe capability defined by "PCIe 6.2 section
>>> 6.33 Integrity & Data Encryption (IDE)". While it is a standalone port
>>> and endpoint capability, it is also a building block for device security
>>> defined by "PCIe 6.2 section 11 TEE Device Interface Security Protocol
>>> (TDISP)". That protocol coordinates device security setup between the
>>> platform TSM (TEE Security Manager) and device DSM (Device Security
>>> Manager). While the platform TSM can allocate resources like stream-ids
>>> and manage keys, it still requires system software to manage the IDE
>>> capability register block.
>>>
>>> Add register definitions and basic enumeration for a "selective-stream"
>>> IDE capability, a follow on change will select the new CONFIG_PCI_IDE
>>> symbol. Note that while the IDE specifications defines both a
>>> point-to-point "Link" stream and a root-port-to-endpoint "Selective"
>>> stream, only "Selective" is considered for now for platform TSM
>>> coordination.
>>>
>>> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
>>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>    drivers/pci/Kconfig           |    3 +
>>>    drivers/pci/Makefile          |    1
>>>    drivers/pci/ide.c             |   73 ++++++++++++++++++++++++++++++++++++
>>>    drivers/pci/pci.h             |    6 +++
>>>    drivers/pci/probe.c           |    1
>>>    include/linux/pci.h           |    5 ++
>>>    include/uapi/linux/pci_regs.h |   84 +++++++++++++++++++++++++++++++++++++++++
>>>    7 files changed, 172 insertions(+), 1 deletion(-)
>>>    create mode 100644 drivers/pci/ide.c
>>>
>>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>> index 2fbd379923fd..4e5236c456f5 100644
>>> --- a/drivers/pci/Kconfig
>>> +++ b/drivers/pci/Kconfig
>>> @@ -121,6 +121,9 @@ config XEN_PCIDEV_FRONTEND
>>>    config PCI_ATS
>>>    	bool
>>>    
>>> +config PCI_IDE
>>> +	bool
>>> +
>>>    config PCI_DOE
>>>    	bool
>>>    
>>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>>> index 67647f1880fb..6612256fd37d 100644
>>> --- a/drivers/pci/Makefile
>>> +++ b/drivers/pci/Makefile
>>> @@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>>>    obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>>>    obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>>>    obj-$(CONFIG_PCI_DOE)		+= doe.o
>>> +obj-$(CONFIG_PCI_IDE)		+= ide.o
>>>    obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>>>    obj-$(CONFIG_PCI_NPEM)		+= npem.o
>>>    obj-$(CONFIG_PCIE_TPH)		+= tph.o
>>> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
>>> new file mode 100644
>>> index 000000000000..a0c09d9e0b75
>>> --- /dev/null
>>> +++ b/drivers/pci/ide.c
>>> @@ -0,0 +1,73 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
>>> +
>>> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
>>> +
>>> +#define dev_fmt(fmt) "PCI/IDE: " fmt
>>> +#include <linux/pci.h>
>>> +#include "pci.h"
>>> +
>>> +static int sel_ide_offset(u16 cap, int stream_id, int nr_ide_mem)
>>> +{
>>> +	return cap + stream_id * PCI_IDE_SELECTIVE_BLOCK_SIZE(nr_ide_mem);
>>> +}
>>> +
>>> +void pci_ide_init(struct pci_dev *pdev)
>>> +{
>>> +	u16 ide_cap, sel_ide_cap;
>>> +	int nr_ide_mem = 0;
>>> +	u32 val = 0;
>>> +
>>> +	if (!pci_is_pcie(pdev))
>>> +		return;
>>> +
>>> +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
>>> +	if (!ide_cap)
>>> +		return;
>>> +
>>> +	/*
>>> +	 * Check for selective stream capability from endpoint to root-port, and
>>> +	 * require consistent number of address association blocks
>>> +	 */
>>> +	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
>>> +	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
>>> +		return;
>>> +
>>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
>>> +		struct pci_dev *rp = pcie_find_root_port(pdev);
>>> +
>>> +		if (!rp->ide_cap)
>>> +			return;
>>> +	}
>>> +
>>> +	if (val & PCI_IDE_CAP_LINK)
>>> +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM +
>>> +			      (PCI_IDE_CAP_LINK_TC_NUM(val) + 1) *
>>> +				      PCI_IDE_LINK_BLOCK_SIZE;
>>> +	else
>>> +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM;
>>> +
>>> +	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {
>>> +		if (i == 0) {
>>> +			pci_read_config_dword(pdev, sel_ide_cap, &val);
>>> +			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val);
>>> +		} else {
>>> +			int offset = sel_ide_offset(sel_ide_cap, i, nr_ide_mem);
>>> +
>>> +			pci_read_config_dword(pdev, offset, &val);
>>> +
>>> +			/*
>>> +			 * lets not entertain devices that do not have a
>>> +			 * constant number of address association blocks
>>> +			 */
>>> +			if (PCI_IDE_SEL_CAP_ASSOC_NUM(val) != nr_ide_mem) {
>>> +				pci_info(pdev, "Unsupported Selective Stream %d capability\n", i);
>>> +				return;
>>> +			}
>>> +		}
>>> +	}
>>> +
>>> +	pdev->ide_cap = ide_cap;
>>> +	pdev->sel_ide_cap = sel_ide_cap;
>>> +	pdev->nr_ide_mem = nr_ide_mem;
>>> +}
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index 2e40fc63ba31..0305f497b28a 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -452,6 +452,12 @@ static inline void pci_npem_create(struct pci_dev *dev) { }
>>>    static inline void pci_npem_remove(struct pci_dev *dev) { }
>>>    #endif
>>>    
>>> +#ifdef CONFIG_PCI_IDE
>>> +void pci_ide_init(struct pci_dev *dev);
>>> +#else
>>> +static inline void pci_ide_init(struct pci_dev *dev) { }
>>> +#endif
>>> +
>>>    /**
>>>     * pci_dev_set_io_state - Set the new error state if possible.
>>>     *
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 2e81ab0f5a25..e22f515a8da9 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -2517,6 +2517,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>>>    	pci_rcec_init(dev);		/* Root Complex Event Collector */
>>>    	pci_doe_init(dev);		/* Data Object Exchange */
>>>    	pci_tph_init(dev);		/* TLP Processing Hints */
>>> +	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
>>>    
>>>    	pcie_report_downtraining(dev);
>>>    	pci_init_reset_methods(dev);
>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>> index db9b47ce3eef..50811b7655dd 100644
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -530,6 +530,11 @@ struct pci_dev {
>>>    #endif
>>>    #ifdef CONFIG_PCI_NPEM
>>>    	struct npem	*npem;		/* Native PCIe Enclosure Management */
>>> +#endif
>>> +#ifdef CONFIG_PCI_IDE
>>> +	u16		ide_cap;	/* Link Integrity & Data Encryption */
>>> +	u16		sel_ide_cap;	/* - Selective Stream register block */
>>> +	int		nr_ide_mem;	/* - Address range limits for streams */
>>>    #endif
>>>    	u16		acs_cap;	/* ACS Capability offset */
>>>    	u8		supported_speeds; /* Supported Link Speeds Vector */
>>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>>> index 1601c7ed5fab..9635b27d2485 100644
>>> --- a/include/uapi/linux/pci_regs.h
>>> +++ b/include/uapi/linux/pci_regs.h
>>> @@ -748,7 +748,8 @@
>>>    #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>>>    #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>>>    #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
>>> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
>>> +#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
>>> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
>>>    
>>>    #define PCI_EXT_CAP_DSN_SIZEOF	12
>>>    #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
>>> @@ -1213,4 +1214,85 @@
>>>    #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>>>    #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>>>    
>>> +/* Integrity and Data Encryption Extended Capability */
>>> +#define PCI_IDE_CAP			0x4
>>> +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
>>> +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
>>> +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
>>> +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
>>> +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
>>> +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
>>> +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
>>> +#define  PCI_IDE_CAP_ALG(x)		(((x) >> 8) & 0x1f) /* Supported Algorithms */
>>> +#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
>>> +#define  PCI_IDE_CAP_LINK_TC_NUM(x)	(((x) >> 13) & 0x7) /* Link IDE TCs */
>>> +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Selective IDE Streams */
>>> +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_MASK	0xff0000
>>> +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
>>> +#define PCI_IDE_CTL			0x8
>>> +#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4	/* Flow-Through IDE Stream Enabled */
>>> +#define PCI_IDE_LINK_STREAM		0xc
>>> +#define PCI_IDE_LINK_BLOCK_SIZE		8
>>> +/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
>>> +/* Link IDE Stream Control Register */
>>> +#define  PCI_IDE_LINK_CTL_EN		 0x1	/* Link IDE Stream Enable */
>>> +#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
>>> +#define  PCI_IDE_LINK_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
>>> +#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
>>> +#define  PCI_IDE_LINK_CTL_PCRC_EN	 0x100	/* PCRC Enable */
>>> +#define  PCI_IDE_LINK_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
>>> +#define  PCI_IDE_LINK_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
>>> +#define  PCI_IDE_LINK_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
>>> +#define  PCI_IDE_LINK_CTL_ID(x)		 (((x) >> 24) & 0xff) /* Stream ID */
>>> +#define  PCI_IDE_LINK_CTL_ID_MASK	 0xff000000
>>> +
>>> +
>>> +/* Link IDE Stream Status Register */
>>> +#define  PCI_IDE_LINK_STS_STATUS(x)	((x) & 0xf) /* Link IDE Stream State */
>>> +#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
>>> +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
>>> +#define PCI_IDE_SELECTIVE_BLOCK_SIZE(x)  (20 + 12 * (x))
>>> +/* Selective IDE Stream Capability Register */
>>> +#define  PCI_IDE_SEL_CAP		 0
>>> +#define  PCI_IDE_SEL_CAP_ASSOC_NUM(x)	 ((x) & 0xf) /* Address Association Register Blocks Number */
>>> +#define  PCI_IDE_SEL_CAP_ASSOC_MASK	 0xf
>>> +/* Selective IDE Stream Control Register */
>>> +#define  PCI_IDE_SEL_CTL		 4
>>> +#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
>>> +#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
>>> +#define   PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
>>> +#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
>>> +#define   PCI_IDE_SEL_CTL_PCRC_EN	 0x100	/* PCRC Enable */
>>> +#define   PCI_IDE_SEL_CTL_CFG_EN	 0x200	/* Selective IDE for Configuration Requests */
>>> +#define   PCI_IDE_SEL_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
>>> +#define   PCI_IDE_SEL_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
>>> +#define   PCI_IDE_SEL_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
>>> +#define   PCI_IDE_SEL_CTL_DEFAULT	 0x400000 /* Default Stream */
>>> +#define   PCI_IDE_SEL_CTL_TEE_LIMITED	 (1 << 23) /* TEE-Limited Stream */
>>> +#define   PCI_IDE_SEL_CTL_ID_MASK	 0xff000000
>>> +#define   PCI_IDE_SEL_CTL_ID_MAX	 255
>>> +/* Selective IDE Stream Status Register */
>>> +#define  PCI_IDE_SEL_STS		 8
>>> +#define   PCI_IDE_SEL_STS_STATUS(x)	((x) & 0xf) /* Selective IDE Stream State */
>>> +#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
>>> +/* IDE RID Association Register 1 */
>>> +#define  PCI_IDE_SEL_RID_1		 12
>>> +#define   PCI_IDE_SEL_RID_1_LIMIT_MASK	 0xffff00
>>> +/* IDE RID Association Register 2 */
>>> +#define  PCI_IDE_SEL_RID_2		 16
>>> +#define   PCI_IDE_SEL_RID_2_VALID	 0x1
>>> +#define   PCI_IDE_SEL_RID_2_BASE_MASK	 0x00ffff00
>>> +#define   PCI_IDE_SEL_RID_2_SEG_MASK	 0xff000000
>>> +/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
>>> +#define  PCI_IDE_SEL_ADDR_1(x)		     (20 + (x) * 12)
>>> +#define   PCI_IDE_SEL_ADDR_1_VALID	     0x1
>>> +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK   0x000fff0
>>
>> 0x000fff00 (missing a zero)
>>
>>> +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT  20
>>> +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK  0xfff0000
>>
>>
>> 0xfff00000
> 
> Whoops, was moving too fast, fixed.

just double checking - fixed 0x000fff00 too, right?


> 
>>
>> 31:20 Memory Limit Lower – Corresponds to Address bits [31:20]. Address
>> bits [19:0] are implicitly F_FFFFh. RW
>> 19:8 Memory Base Lower – Corresponds to Address bits [31:20].
>> Address[19:0] bits are implicitly 0_0000h.
>>
>>
>>> +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT 20
>>
>> I like mine better :) Shows in one place how addr_1 is made:
>>
>> #define  PCI_IDE_SEL_ADDR_1(v, base, limit) \
>> 	((FIELD_GET(0xfff00000, (limit))  << 20) | \
>> 	(FIELD_GET(0xfff00000, (base)) << 8) | \
>> 	((v) ? 1 : 0))
>>
>> Also, when something uses "SHIFT", I expect left shift (like,
>> PAGE_SHIFT), but this is right shift.
>>
>> Otherwise, looks good. Thanks,
> 
> I too would have liked to use the bitfield macros, but I notice that
> this would be the first bitfield macro usage in pci_regs.h and that
> bitfield.h is not a uapi header. In fact, there is no bitfield.h usage
> in all of include/uapi/.

oh I did not notice that. Makes sense now.


> How about a compromise, I will add your macro to include/linux/pci-ide.h
> based on offset and mask defines from include/uapi/pci_regs.h.

That works. tbh I would not even comment on these if I did not have to 
check these after finding 0x000fff0 and 0xfff0000 :) Thanks,


-- 
Alexey


