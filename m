Return-Path: <linux-pci+bounces-22277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52987A43302
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 03:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1831897ED2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 02:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9211D7DA67;
	Tue, 25 Feb 2025 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cCAlc+lF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D27C364D6
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450330; cv=fail; b=CRo0DmMiJDaIH5lIr9EjxBnVY2PwSWMYy8bDRm9FtcjXc/k7UYGqldB10o6W4ewgSIArXR8jdhoNYNDeKT8v5gTNGdDVGOmeJuwAzHJi0eSfvmUXYWGSgMMoCdO8iMmNmMvQw2QqmUdEtpsA1MzWtDB9FqDT+n9K/5uAJH3iZF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450330; c=relaxed/simple;
	bh=+sSI+6dJrjE0aoai8c25cU9DYw7eatW5jdh6w+qEumk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t2C2zR6cutpsMRm7g+RGI5vqwjiccPsedZa49HYKOkLHKJGCr8JJBgpAezYuwDDbvPs/EFxfCvNKWJDT5JsdiqVyDeHh1jLsARlM+hT0ASu4xpG4Hlc48Lrrc9S6CyQD4m0nVCkVLG1wkQGc9SbanMi2xxZ3VPnvg5o//OjIN3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cCAlc+lF; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zck5w+kVXhlwxyvhtDWjcFwfl4V9t1tqoj6RnOcyA6oE5YG4TkCRBhjeva8rzE7mJWXoEquUS52yebiZXz0varI7fKGnMgiC7uGCBoM9Cll+hTV3+OJf7EyjSTSQ3MpbZNU+iqQbVrd75SxU7l68tVB46gbqdRmiNBvG6Fa3gx5u+K4HCRoqyxOlsx1q4TXL4SBWXHK6027WVN6095lT2/7RPo7SF0ro1/9fP7V9KEIIjyLk32eGWsc24v17cNskEODLT+BEqxSibSHI5x2b4wyBIwnCeo8L+NWGqHzJ5Btvh6dlzNXxGNwzANlf8FxSZUflvVz6SzJwicrixTOtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqsIKnVU1vSOBcV2T6T5/rmGsfopjQ3m4WBiAG/g6tc=;
 b=S6OtPYLoArC67m76ogDlYtYmMI/fOAT360zuL8vmaAmPhSe/QaMolhRTe733Hjtr6pW6TuAaB1Kz3HoIF8vN5HZVlKdLxU/pMNaVsJU5QRLZ3s5SAxbk/WCoY+bzK/gtBnwNiJtCOe3I3C1L+p7MtZbxT5vXr6Sm3/MhasozdcZXyfY0kZdAPe31ms+UdgD769g8ri9MoEmTRhzcRqO7+5vPxfiHc4zNatl+fNSlAd9ZzrR2M5BD0nQGPlUfGhhRLIUkBW1UAJy0j7dR5ZLC7qYAayHPJn+euK6PRohmOn94VDaiay5+TVuwg96O93wHJo4nkSpl5uNzSB1UMshCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqsIKnVU1vSOBcV2T6T5/rmGsfopjQ3m4WBiAG/g6tc=;
 b=cCAlc+lF4/jv+jWd9AAP6GKhs69Synm42pdMeX19Pr1Xuu35Ajw4UfrqLkGl+PhFDK4HOp0Oh4wGkMQl1N24R2D935sEjJrIzKOwed2hEs7TriA06sgHRauQ3TJ2tiWyzdrefIeGiFvW50UnW/a5op/YmbEJ4lUjX7FMt4Arhu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Tue, 25 Feb
 2025 02:25:22 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 02:25:22 +0000
Message-ID: <e26a15e0-e3cc-4290-acf5-5549a505c110@amd.com>
Date: Tue, 25 Feb 2025 13:25:13 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 07/11] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-coco@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
References: <173343743678.1074769.15403889527436764173.stgit@dwillia2-xfh.jf.intel.com>
 <20241210192140.GA3079633@bhelgaas>
 <67b90d8d78418_2d2c2946a@dwillia2-xfh.jf.intel.com.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <67b90d8d78418_2d2c2946a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWP282CA0068.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1dd::20) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: f268b233-9d1b-4146-14f9-08dd5543a766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlpzTjV6TVBXdUtpSWxOUGViUDdjck1GbW5hc2Z2L1paR1YxajRrNUNwM2FW?=
 =?utf-8?B?aVdXaDl6aS9VZlJjWWlTY2oxMUpjSmx0ZmtsdlFhSmxOVmVGWVNoemk1Smc3?=
 =?utf-8?B?Smd5RUlKVWN3SU5QT0Y3Ti81U0NVeXVxMmZXTEY1bUZ1V3E4V2dUWk5jbHk0?=
 =?utf-8?B?Zk9DTHNUN21xQk9yaVZBNExHM3JvNFp4eFE4emRnVXhPNWI1SzdtaW9GOWk5?=
 =?utf-8?B?VllFWjJ1S1h3YVRaZUsreldid1M4Qzd5WUFSdUZCWHRjSGg5TE1iMkFtbDdz?=
 =?utf-8?B?RnZkdEdzQS9XcmZZT2dlOTRIdnltMjQxd0V1MUdPNGgxOVRmbGlxYlFuRVVs?=
 =?utf-8?B?dlNER2pRTWF2dFlKNEhHcHZ6NHhOb3cvNDcwaGpFRk1nei9LRkNYaEV5dU9k?=
 =?utf-8?B?TkNDWk9VeFpHcmlLZmhXM1VCNkNTdmdGdkpnS2pxNU5kSnVhYzY1ZEI3NWRT?=
 =?utf-8?B?T1JFOTNJeDlHQzJpNjEwTGtPNmdyODhMbzA5SmZQOVlSRmRBRW8vRm43dTFn?=
 =?utf-8?B?TlJEclZZZGtvNDBudXRNVkhCRGNKa29mNFM1cTJaTW01QWtsRU5oSS92ZHpt?=
 =?utf-8?B?eXdEazBRYkVmRXRwVkltTjFkdnoxclg2T0pMZmV5T2FETHVUVzZEeUowRmQ1?=
 =?utf-8?B?SnJWTmYvU2pLdnYycjR5QzBDaC9ab0t5ZDNrdHpkMTIwZVQ2NUpNR2R0K05R?=
 =?utf-8?B?NHRKTXFLNTM0SDRMOEQray80dk9lVjc3REpnSlhzNy9TNlh0Uk1hYUhQT3I3?=
 =?utf-8?B?OUpRR3JHZ3dmc2R1UkpBcFpmeUhJZHByOWxjWXVVY1F6NmVYZElQWkt4dnB1?=
 =?utf-8?B?NXJrSEl1ZkxUQkRVcnAvcHNBemtKQzRma0g0Yk5qR3lvZUE4L0EwUm8rN3F0?=
 =?utf-8?B?dlFvdnEvNXJweDNDM1RGa3daVVZvN3E2OFB3Q2llb01xMHJSUGdzNmdrNmc1?=
 =?utf-8?B?R25qSVEwL0FjTDNmM0VLYVNBVS9YenM5ZHY0RG9qZXN2ek1FWjROTkxPOTlm?=
 =?utf-8?B?NVJrM0p0dW5NWnMrdjVOUUY4US9lbDhXTWQ1TlhFWi80Y3R0cU41RXZvVUJK?=
 =?utf-8?B?NmtEbHBFSE4zRXMremRaVlltY1N5V1dyQnAvdy9DSXUrcXNjMjgwWStIZ0lJ?=
 =?utf-8?B?dVI0NHgzajhNV09CM0t0RUxwMUFZeTh5Ynp1WHAwQUFWMnRlZXl5VWhFMGYx?=
 =?utf-8?B?Rjh5N01EcE1YWWU0NUV4T0Z6WFVUcTU1R1l1VXFIcGhwM2FVT2JxeHRBQTJ2?=
 =?utf-8?B?aFczcHFCTTRKTncydXpIZ0NldVNLN0g5ZUVDNVVxMUZURm5DZ0MvMG41Z0lo?=
 =?utf-8?B?bmc3c2MyYlh0dC96YWV4R0J3SzB4cFU5bVZIcVBSWUcvNnEyWVlVTHBpV3gz?=
 =?utf-8?B?TkttdHVDVmdmL29YWTVsVmFIM3FCa2M3TkV5QUptQmFUeEduOGo0TWt1S2Fa?=
 =?utf-8?B?aGxBeXdNTDR4VTFpZHNDTG5KaGxQZzRmNjZNNzdHQkFYaEoxYzZsM3ZUZW4v?=
 =?utf-8?B?WUVMaFRGZlNKano0ck1qZFB4bU9aQmd2L05zdktiNHZNUzZQTWYrNFRKdnRz?=
 =?utf-8?B?clZCd1ZlNWo4djV2TjBtUUZ2MVdxMFZIMzlFNjVTYThENk9ZSzdiRG5NWEoy?=
 =?utf-8?B?QW93clFoZXoydHNTMEVsS1dQclp0UGlLTHdVYy8zNkwxR1NleXVncWlnWWNB?=
 =?utf-8?B?UmNqazBhOUlUNTNpM2JxTFR6a1lMNHdSV0pIZm94L0p2dzNndjYvTVpNcHdJ?=
 =?utf-8?B?RVNVRU5ZbDJNUlZLNk5JRmplQWE0d1N2SW9hMk1QSzhDQXVxaUVPNUxSRnBN?=
 =?utf-8?B?MjEyR09XL0Y4d3lCOExHbWtHUzY0LytLSTI1RWFsNUV5dXZWejBxaklSaWNa?=
 =?utf-8?Q?F5C7+BFfc1ySi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUNlVlRWSlVYbU1uU1hUQWNoUVZkeTNKWEZYUXF2dTgxMDkra01TQVo2L1dT?=
 =?utf-8?B?NGE0Q0U1NXlHc3BkS25QaDlTbGRNREx3aldqRDRZVDh6emR0WHAyNE1uU1VU?=
 =?utf-8?B?RnVZbmU2WWlDZUhiS3NJL2FWUy9JRkc0ZmFsMFkvWXlaY0Q1c0ZRQkxHREZJ?=
 =?utf-8?B?VWJtbjRHa1k3ZTM1R0ZBTm56aXRMYnhMUGlXblNUS3JpT1hDR2tCbU5wUk1Z?=
 =?utf-8?B?aFZxSmtIV1ZDUnNtMktObDN6bjk2TnhyTk1yczlRNXg4cXhvemRBTVZvcDVz?=
 =?utf-8?B?Um8vMlg4SjMwVTNmeHpCbUJvKzNUU0I5dGZpTGZSNEZFNFF4VVRYRkM3WHJF?=
 =?utf-8?B?cVYxMi9GSm40aVFmWnMxMTltdkZ6bE1BS3NRZmxMWnZtdCt5dWs1MUQwZjZp?=
 =?utf-8?B?bCtQdXZzZzBrOWszemtRRkswYkNLVy9nOTNaK0k1RmZub1F6QWl3WUNmYVh2?=
 =?utf-8?B?d0hEVUNYaWpiMnNRa0VueFVCYW5YQnZ3NnZrbnhDZk4xZ2dOYlcySU5HMTZX?=
 =?utf-8?B?dW9IR3BHVjk2RUt3Y1U2VXpseU9jL1lwbzBoeGxUQnNiQ0FiRUp2cys1d1Rl?=
 =?utf-8?B?TTRMaDhaZll4V0JLQlJxaUZ3eW8xRWdVcnp4azJ4M3EzZ0tPc05jUVhPSWE5?=
 =?utf-8?B?cW5RSUhxLzNVaEN4M0dhZStwdkZ3S0dGRzFVVDJlazBHekxFaDVYelNXeW8x?=
 =?utf-8?B?eTBZZVVFYXNQNFlSWVdZRVhZUzVjMUwwNGxqdHBpVGVrUlFreWxYTGhJMFB0?=
 =?utf-8?B?emZxUGVUVGVya2ZIZ0MvSWMyOTgvQVluQ09mSHhnalpRZGxLREpxTFFOcTV4?=
 =?utf-8?B?TlZhcHo1ci9NMUVCQUtwc2pHcFJ4ZlRYUDZwTk96Vk9XRmsyMXNmc04rVjlV?=
 =?utf-8?B?THh3dnMvQmt5eW5FZ2pkekp4cDRKdTBmMkJnQW5wbm9ubk5BT1pRWm1xYk9j?=
 =?utf-8?B?SVhqU3hEN1l6Wi9NK3dTMmdFOUVLRjk5QUJncUh4WTlqcjFFcWVPVzZFdXpV?=
 =?utf-8?B?YmFMM01LYWU1TzFzb20zdVJjYzB6NUVLOHFjNHR4MnFUdVJyczZkNWhTNUFo?=
 =?utf-8?B?S2dxMlBBUnZySDJyQ0JrT0EwaVljT3F6NVJIQXo5eVVCYVhxd2k5eitLck51?=
 =?utf-8?B?MGlYWTZIMVcwYkQzRGxodDF4OVM1Y0trTkx6UHA2aVdWQUxBT2dtUHJoMURu?=
 =?utf-8?B?OFFXK3Q4UW45ZkZ4QjluZHpZTThPdkR2czd3OVJ0WDk1eFNOc0thZlNnZVdi?=
 =?utf-8?B?YzJlME1kVStSbFFWSi9ZeDlVOTAwa2o4ZzZBUTRlVkpGYTlQcUl5ckRxaFZS?=
 =?utf-8?B?WDVMTGYwK0s0cGIyZXdLTmNNV1dOTmJUVWZ3MjZMdzJCWndYeTcwT1orbFpR?=
 =?utf-8?B?a3g2VjUwQ1A3QldBSzgySkZjeWtpM0xTS2MrU3FtTm10S3YxZ0p6VWVyRUJp?=
 =?utf-8?B?RDdlcVhQZU9jbS9NSVY5bFNLR3RkZ2ZBZXNobHdKclJkQm9KbXRFeElzTGRR?=
 =?utf-8?B?NzNGQ2Uvekg0VkxVanlJN1JBSlcrRFJpSTA3cmxieHp2WnNHY3RZaGNkOHRF?=
 =?utf-8?B?YnVveXFTdVVKd21aeEZSUlU4NkdSUEh2MCtoN2pxUEJYQVFVeHZHTlRiektP?=
 =?utf-8?B?Y1k0SVo5aUdlZ0o3NUtxWnNHRmM5aFNlUTMzU3BYMFM4bzU5cVpHVmlibitJ?=
 =?utf-8?B?c0F6UHJPS0RYVWNrREg2L3FQQXo3RlJYSFduck5KWEkxN0NTdFFMSjFDbzhV?=
 =?utf-8?B?RktWajJpUUU2L3lSZUd1S0FPVEJFM09TaC8rQ3pGUDZxY29BMHNhQS8xVFE5?=
 =?utf-8?B?d25wNnZra3FORnpVU0ZCUmZmVkxlVkwyNmNYWnh5aGlkUzhTMjdYOS9GZVp2?=
 =?utf-8?B?V3o0ZTN3QjN6WXdPYys0S1FVaGx5VUtmS1lXSitNNUlRaDhRSmdVMEdBYUI2?=
 =?utf-8?B?OGFsUVcvRWs4cjgyZjVoT1hIV2pZeklGUUhrTkJ3NTVLYmxmMnR4ZWJVSkYr?=
 =?utf-8?B?ZU14VFovY2c4RU4vZk9xVVBPVnp3M0lXN2llcjNQeElEYTRFM0p3aGRQQi9P?=
 =?utf-8?B?WlE3eS9HQ0FCZGF5SmMrL0xWcnhURnNrbEROZDJWTkpqdzZvWHJ2dHpmWFRR?=
 =?utf-8?Q?FF3ihHYyyg0iQHhN9LgXlMrVk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f268b233-9d1b-4146-14f9-08dd5543a766
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 02:25:21.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yKPQYwRw6d+2MqAE2mJ2x70zNvbunQ4/f2C0GVoNL6VzLtFDvhshLDkBWEvn7WygS7UTeX+jE/8trUwvy+r8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207



On 22/2/25 10:34, Dan Williams wrote:
> Bjorn Helgaas wrote:
>> On Thu, Dec 05, 2024 at 02:23:56PM -0800, Dan Williams wrote:
>>> PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
>>> enumerates new link capabilities and status added for Gen 6 devices. One
>>> of the link details enumerated in that register block is the "Segment
>>> Captured" status in the Device Status 3 register. That status is
>>> relevant for enabling IDE (Integrity & Data Encryption) whereby
>>> Selective IDE streams can be limited to a given requester id range
>>> within a given segment.
>>
>> s/requester id/Requester ID/ to match spec usage
> 
> Fixed.
> 
>>> +++ b/include/uapi/linux/pci_regs.h
>>> @@ -749,6 +749,7 @@
>>>   #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>>>   #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>>>   #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
>>> +#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
>>
>> It doesn't look like lspci knows about this; is there something in
>> progress to add that?
>>
>> https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/lib/header.h?id=v3.13.0#n257
> 
> Alexey, do you have plans to follow up your IDE addition to pcituils
> with this DEV3 support given the "Flit Mode" detection requirements of
> "IDE RID Association Register 2"?

No sorry I do not, I do not have any device with this capability to try 
lspci on. When/if I get one - then, sure. Do you have such device btw? 
Thanks,


-- 
Alexey


