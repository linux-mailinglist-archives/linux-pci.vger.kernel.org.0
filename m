Return-Path: <linux-pci+bounces-13724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7B698E186
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 19:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877C21F255CB
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 17:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8652F1D0F76;
	Wed,  2 Oct 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2/uSPwDz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11D1D0F62;
	Wed,  2 Oct 2024 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727889552; cv=fail; b=XOIn1ST5f9ixsQZEpSsUHCsSwEdRzQSMPutQ+FnvmjLzeEsDCvZ/fiNBQp9+0SCTw1M1XJSGeAlvwmAvF//BrwDEQZVZnZul6i0TNgFfbVLGKAg7b4xMgj1Oyc7+9Cy3cmt0SyRrBgZGyk1W9AodTxMfvw3GyGbA7xHfRIG9EbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727889552; c=relaxed/simple;
	bh=F0yCp+bgqR21maVA46MdUFsbWKT1laVZsQ0Kt5qFTj0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hl8NFznx5qkFpqKOvoJFgTb+KXJqUxLuz/7GO9n3m4iMpZerKqX5b30vrEkw89WU89NMfcqoK9pac/dM0PCjEUQ6Zu+pD9WJoR0LZ5uJDS5cCfdJBXa9uq2pjKqfr8TbGRGhziBv8QQIFzQMa4ttdOJvePIHsd34Vtcc19GcEwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2/uSPwDz; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgdv4Hk0UqGaBOMFHNFzEqjM0M9kx03ZmPNGOQatpY6XG8vHVQEojJNVQxYoVO5SZgIdBrd2yKWm8NQJZXvvXZXr/NzQzmd5Dn8hMPe3jzHuguoCmvQmtUSOcYLMJlnxhdwwjj8bUZjWDrg9gH19RueIHgs/5CMk+u+7YWLw71q+R2s1lhMLBpfEZuOnWRYN25Sfyv+vakbqIoiMUAttv/dqGQKBeKaiMjEFwkmvAZkLuTKnRw8EKz84fZtqIhh3Ee5fLeLrNN4kspfLVEIU8U5+St88OTcgWJG6XWU1ZRoHBAu49Z2w5tQ35z2Yj2FankpUTPrxOV8cLie6TnEtfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNd4GhGPjhi0LQsUwLuSc/MUIW0iVWFpCN5PPVer030=;
 b=RSv9tZB2LGQ6UwsHIGethxZA5kS5d5V/dZySw1PcNE+NMlcPan+gQaJltYysgNLKNiHBY5xvXlvB4AOrh16hruB3w8kOe548TElOjOkGQnoKL9aZJYmsfLM7dl3g2jDE6pvAK95r5kADP+bCYZkMlnEjBCDl6roSjnM+fBLPvR++LmvIcD5lwITMbCw+Dnv4yywZtb23PPTtcQJmDUmuqcHB8XbGcSgQzXKvm1nyz6MHWw434AsPQsmRecq3MuME2Vqm8wyU2/8i9pjXYnzf6+ewcLnfGiNOSgLY756VGLIwpNw8U3PEDXXE3qvG0NTFUg1gp9brToMd7yMvx3TH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNd4GhGPjhi0LQsUwLuSc/MUIW0iVWFpCN5PPVer030=;
 b=2/uSPwDz2gtPO8Uk4AgvI2RiB5isMFNJNAzLzi2O6T/3KqsaECDFrFgVVJpOY5MR4fU16w6Qm+m7bEEsVY5ooARY+HT71bLLlpA3K3xRq69rrYjU9OiArpMqO0gKmV3Nhczhd80kURnTBCFhPVKMlWvNrOL5crqQ39igdr8yyfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:19:06 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%3]) with mapi id 15.20.8026.014; Wed, 2 Oct 2024
 17:19:06 +0000
Message-ID: <ab0caf10-3688-41f6-ba9a-ea10ae3abc59@amd.com>
Date: Wed, 2 Oct 2024 12:19:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 0/5] PCIe TPH and cache direct injection support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
 Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 bagasdotme@gmail.com, bhelgaas@google.com, lukas@wunner.de,
 paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240930165519.GA179473@bhelgaas>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <20240930165519.GA179473@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0157.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::24) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc173a8-a0d8-4eeb-7d24-08dce30651b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djZjSTRqTGhQVXVoOVlNeHEyNjRMU3BBSm9yc0VXZWszcEZKZ1RZaWpEL0Mz?=
 =?utf-8?B?NjZla1lYZ0s5djZQN2YvSGlmL0hEa2VTVkttVkFsV3VLTTRZS1YxSnh6M3ZB?=
 =?utf-8?B?N0xmWTZLM0daYUtGZG52c1VlMTFkTGlxb2dMNjNDYXoxMXVpVXRBRzlDVndP?=
 =?utf-8?B?QkZDdzhUL0h6SjdMZkZDaVE3aDQyeWR6QUUrdlBYR1c5K2U1MndTa2xhZXhp?=
 =?utf-8?B?SU9MTFl5QXBZU0s2d3dVbjZTeUxyY3JCMzJvZVcxRmZkZDYwZEhOKzM0Y3Bm?=
 =?utf-8?B?bFN1a1VOREpzS3dNc0RYbDNVU09iK25Nd2ZlbFduN3FPa0NhV3ZoWWFQeWFk?=
 =?utf-8?B?UGY5TXBVWG9tamdKaFRUUVV4Si92VWNRNk9oenlQTm1MVW9ZRXZDTG52SFVt?=
 =?utf-8?B?VzdNMW9SOGppdkYxbGcyaVpDSGVaSUM3V0ZnVEs4b0FMaEpBNmFKNUZmeGFB?=
 =?utf-8?B?UCsraUM2VzgvQUprbk11MXpvOHlPTEJnNGxySWwvbWRGeTNJWlNzbHZFNGpQ?=
 =?utf-8?B?WEZpaC9ZUkdpbnNnYitvUHM1VjJrUFo4ZVVPQXI1WjJESXBRaVFhN2d3ZCs3?=
 =?utf-8?B?WitLeWpYMUtxdEJIbzA1aWs2ek03K0REMW5mOEthQTdNR2FLQWtzcXlxYXNs?=
 =?utf-8?B?dGNGMVU5MnVZOGladXBETXB6V1JuSjk2MFJRbWw4cnVmZTVKVVduY1hFdldx?=
 =?utf-8?B?cVRjaFR2NTRFdzBWbnNwOHVvMGlJUTZXQktKV28rdWNlWnFkM0UrRUcxOHdV?=
 =?utf-8?B?SnZrU0JaWFo0NVVqL3cydWRVV3JkNTJUdWs0VjZJM1J4NS8zMWRWcjc2TDhN?=
 =?utf-8?B?NDNTUEp5dktaN1V4QXN3TU9JQ0orSU0ycms0R2tLVEJKM1pyRzZQMTQ3WWtZ?=
 =?utf-8?B?WTdkNXhPaWdKVUtqMjA3dDMydXRmdU4yQjBYdHZ5YzVVT2U4K2NXcXR3Q1Rm?=
 =?utf-8?B?OC9QTGh6VjNaeTgveHBnNUw0MTdrMGVtT2dFbk9ZUERVNngySjJpUnBYRFRn?=
 =?utf-8?B?NE9PSDdXTENvSzgza3BPbTZQclREVitGb0FtZE4xcFdWR3VVaW5sUU1CU3NB?=
 =?utf-8?B?eEhDclVvT2ZjOXJDa1M0VEVCYVpjVnJiQnhQekhtMExRa1FtSXYwUzZsS2RQ?=
 =?utf-8?B?c2VGMVRxZDh4UlMyMlQrTTdLUG5saFpHeXVNbmR6QUpYZGlaQUdnY0ViSXkw?=
 =?utf-8?B?bjltMENUQ25qME1WWkpUZ080SjNWZ3VzRDZZSmxEVkNyMVJNUE84REI4OWVJ?=
 =?utf-8?B?SnNUb2ZlT0pGVGFYbzBvNmZQZCsrTFVzWlBIcjJHVi9WSDZpQzAvODdLM0h4?=
 =?utf-8?B?UTVQTDF2ZXRDRktRWDFJN054OGp2QkFlMzVDcE1NbmRGV3FtbnpKckR4QlV3?=
 =?utf-8?B?b2RCTTNLakJlR3RGRjVFVGFzSzNDZUZjTStxa2NqNmNlMEt2VWxUUmxvQlhQ?=
 =?utf-8?B?c2c0UXU0K2orcW01WnNyWnFMakNHb3dhcFJSQytaTFlESWc5a3Y2dEtmUVlX?=
 =?utf-8?B?bEJBZkVGMW1qMlpRNCt3TjFXakphcG80Mmd5aE8wR3JFbzVLRzFSTzBja2xZ?=
 =?utf-8?B?NEN2WWw2YXBhb3YzUFVDc3hRQkIyMzNDM2kwQ3ZCMWJYN3ZIelo0aGJBNlZz?=
 =?utf-8?B?L0FiZlhTd1JIeW5rMWpjVEV2NjBCOGUxZHhLdlBwOE1QWVE3NWx3VTFadVpa?=
 =?utf-8?B?bGFWQXRKT0xBUmJSVlUvZDNGOVBmcDh4UnlTZWlyTHU5cXdxOXZuNkZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1owb3NYYWUyOWJzcUh2Y3hJUitwK0xZOU9oazZkZWRBalcvMTZjZUs4OHox?=
 =?utf-8?B?aWJFeWJldEtYc3oydThDT2NmbHkyekN6UkpFY1NLV29CanFDZ2dBY3cxdmtQ?=
 =?utf-8?B?dFZlWXBrNldRcThuWld2Q3drdXdlc1NEeFdNdGNkSkJxa0dRUHovWWpic2N4?=
 =?utf-8?B?aVhibE91cGdaTXZBL3R3Q3QwOEZlNHl0WkVnZDBLVlVHNHhRbGltSVdvcFlL?=
 =?utf-8?B?QUJzRXA2ejVPOU9aeFdPZFhEUWlGZERlMFRuVUZDU1JkcHRTT3o1V1ZkQTgx?=
 =?utf-8?B?YmttN1hBbzNmRnVjTmdMay80eFRXNnIvc2NBaDR3ZTdORTJtVWpkdDZFKzgx?=
 =?utf-8?B?SnovSWV6YUpKanhCOFd1OTlVZXNFTWNEajNvNnVCTDVYTU1iZUc5aXZTSDlV?=
 =?utf-8?B?VUZuT2pxQy9VKzF4VkZaREF3OE14S0JNZDN3M1J1aENPSGYyVzN5VStuU3FT?=
 =?utf-8?B?STArQ1MxK1M4ZXFoeFJyQ3BJZ2pXZWczM24rR1ppOTlJQytnWDNhZmh1NE91?=
 =?utf-8?B?WXNLZVlEOGphY0xEQTRVMHFmekZaMXBHYW5sbDlwcFhOeDlDOTRvS2VWc0ZS?=
 =?utf-8?B?Y3VtL081VFJ6cVJHOUlyWDVJNmM2N2EwYkFJOWx0SjQ5RjVONEZ1ZjFqeStl?=
 =?utf-8?B?MFptaTZGVU90WEFNYWs3S0RscDh1N0djYjJqcGhFdTZwY2FZUlBOaVMvM2k5?=
 =?utf-8?B?TXRjczdxMnlZeE1lR0tRaTNZK2VQUnNOMUFDektJbVlYUUo2czhKUTRHWDBj?=
 =?utf-8?B?d2xEUFQvSENwQlF5ci9pSTNCZFhHRWptVk90MFVzQWlYNFpSeXZwRm1BNmlk?=
 =?utf-8?B?U2hzYW1KSXBxbVAzMTJaOGQwUW9VcXJtS2hMVFdGVGo5c2RzeTNTN1hGbEFa?=
 =?utf-8?B?VEIrcCtQYW1XUUliSmRpa0pWOVFMTXMvMGxUMW1wNWR5OHRmNU5sT3NPNzdY?=
 =?utf-8?B?ZEYyYU5STGFBQTZqd3N3Q1ZtanQ4dElkL1V2Vit1RkFMTk9mYVNGc2FNUVU3?=
 =?utf-8?B?Y3lHYzdRK0Q4RzFtUGk0NnljWFM2bmxUK21ZdTh4VmdCbGJkbVBJN283KzVX?=
 =?utf-8?B?cXFzNG15SGtoSTE3dms5S21XOCtqSG14SGZtaFYyOG9nVHkxK1FxZDVrUXJs?=
 =?utf-8?B?Rkg1d2xaVlB6QVRxcDYyOHZ0dm5RTDJoMHpxWG90SFlHMm1XMTUzV3FUb0ZL?=
 =?utf-8?B?ZG94bWJhdXEwVzJkM3NPZTF4SWtRSDdhdjBUdk4wNzhkU2Jpc0gyYW1Nc1Vz?=
 =?utf-8?B?SW1hZjVtQlc0OFFkZ01ZeDQ3TGI3TURzaUU1Sm0rajkvNW1YNjlEN3ZnaWlS?=
 =?utf-8?B?NFRISFhxRmpHUEs1cTJ1QUUrUHRJYmNtL0dpcnFCUno2SkFHSFpxcVlQRUp0?=
 =?utf-8?B?QzE0KzUyMDlRUHE5SnZvaU9qcVZYS2J6d1pSVFhFT0Z0Q3VKL1ZLM3N5NTNL?=
 =?utf-8?B?dmpSdHhrVVJ5ODBGd2hZaFJFQ0g2alloMTI4Ym93WEt2aFkrR1U4Z1lHTUg2?=
 =?utf-8?B?LzI2YWgvc0d2b1c1QVVLTjhLRXNDTFNQb3h1eEtuT2pLa3dVbmgvMzVSbWtj?=
 =?utf-8?B?VUltN0JQWmkwT3NUcThGVjdYVFJIbEVqeVlqVVZpajhZaFFxSDNPcU1VS3RY?=
 =?utf-8?B?VUh5NlVoMHVBKzhTUjhxanBoM1VkWUNHMlJYSEdPb0daVGtqcVpqeVFRRGtQ?=
 =?utf-8?B?ZEVTT3NqM215VDhGcnNOQndSa09YS3BtWVgweFhJMmxYRzcvSUF6MHJtQmdp?=
 =?utf-8?B?ZGRzaEV1Qk45WWxKWmFKQ0xKLzgyb1NYMmVZTDREZkZDcFdzSmhFQjhZYUhN?=
 =?utf-8?B?bk5lU3VtbWJ3Yjh6bnlrWnhLZStJTEExdTkvdGNFdUdhdzMycnFuSFhYcFM3?=
 =?utf-8?B?cWpRemtNanoyei81cmtzb2FObWVXV1JBQnd0M0FacEo0N09lSXJabTQzUzJ4?=
 =?utf-8?B?bkxsWlBka2tKVlJjZHcreStFZUdGczBQaEE3d3BWVnc0SkxnL1IxQUhsQ3Rq?=
 =?utf-8?B?Q3NTVlhTdjZncnRGMk9aWmVqbkwzbnNTNHNRTXp2ZjFNTjQ2VEVVTXBrV25X?=
 =?utf-8?B?OUNIQm4ycVRCTDJrTnB5emJpWlMyaVNobDN2NzEzMnM0enFJYnEwbkJUVUds?=
 =?utf-8?Q?54W4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc173a8-a0d8-4eeb-7d24-08dce30651b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:19:06.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCEt0XFkHq6Gr5RcY4bYNM9h2kDLsAmTqD4NYZQZD4PeegKT6tVQCDTfOw6pJrwG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301



On 9/30/24 11:55, Bjorn Helgaas wrote:
> On Fri, Sep 27, 2024 at 04:56:48PM -0500, Wei Huang wrote:
>> Hi All,
>>
>> TPH (TLP Processing Hints) is a PCIe feature that allows endpoint
>> devices to provide optimization hints for requests that target memory
>> space. These hints, in a format called steering tag (ST), are provided
>> in the requester's TLP headers and allow the system hardware, including
>> the Root Complex, to optimize the utilization of platform resources
>> for the requests.
>>
>> Upcoming AMD hardware implement a new Cache Injection feature that
>> leverages TPH. Cache Injection allows PCIe endpoints to inject I/O
>> Coherent DMA writes directly into an L2 within the CCX (core complex)
>> closest to the CPU core that will consume it. This technology is aimed
>> at applications requiring high performance and low latency, such as
>> networking and storage applications.
>>
>> This series introduces generic TPH support in Linux, allowing STs to be
>> retrieved and used by PCIe endpoint drivers as needed. As a
>> demonstration, it includes an example usage in the Broadcom BNXT driver.
>> When running on Broadcom NICs with the appropriate firmware, it shows
>> substantial memory bandwidth savings and better network bandwidth using
>> real-world benchmarks. This solution is vendor-neutral and implemented
>> based on industry standards (PCIe Spec and PCI FW Spec).
>>
>> V5->V6:
>>  * Rebase on top of pci/main (tag: pci-v6.12-changes)
>>  * Fix spellings and FIELD_PREP/bnxt.c compilation errors (Simon)
>>  * Move tph.c to drivers/pci directory (Lukas)
>>  * Remove CONFIG_ACPI dependency (Lukas)
>>  * Slightly re-arrange save/restore sequence (Lukas)
> 
> Thanks, I'll wait for the kernel test robot warnings to be resolved.

Fixed in V7. I tested with clang 18.1.8 and compilation with W=1 passed.

> 
> In patch 2/5, reword commit logs as imperative mood, e.g.,
> s/X() is added/Add X()/, as you've already done for 1/5 and 3/5.

Fixed

> 
> Maybe specify the ACPI _DSM name?  This would help users know whether
> their system can use this, or help them request that a vendor
> implement the _DSM.

I added more information (rev, func, name) in the code and in the commit
message. End-users should be able to use this info to locate this _DSM
method in ACPI DSL.

> 
> In patch 4/5, s/sustancial/substantial/.  I guess the firmware you
> refer to here means the system firmware that would provide the _DSM
> required for this to work, i.e., not firmware on the NIC itself?
> Would be helpful for users to have a hint as to how to tell whether to
> expect a benefit on their system.

We need both NIC FW and system FW to support TPH. I revised the commit
message to clarify.

I cannot speak for Broadcom on which NIC FW version will support it. I
know that, upon release, this feature will be backward compatible and
carried on in the future.

> 
> The 5/5 commit log could say what the patch *does*, not what *could*
> be done (the subject does say what the patch does, but it's nice if
> it's in the commit log as well so it's complete by itself).  Also, a
> hint that using the steering tag helps direct DMA writes to a cache
> close to the CPU expected to consume it might be helpful to motivate
> the patch.

Fixed. Thanks you for the detailed feedback!

> 
> Bjorn

