Return-Path: <linux-pci+bounces-14584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E68099F77E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 21:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7921F24964
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 19:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6401B394A;
	Tue, 15 Oct 2024 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rPhzGdkV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F564824A0;
	Tue, 15 Oct 2024 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729021850; cv=fail; b=EJ30Uki1WnLolTMYOPuZDc/BYK5Uq/EC2qwXH33/H6eLlXsntypnB7My3gn+2STdDDk7MqVxDFZJgoA4qGOO+/MUPdS7FM86qZOUlqOzRNgptdYA2l9grM05G8s0+0NhcV6riSJv5ZV985ga6aOdgsnsM8sCyptkRCrUKUw8mDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729021850; c=relaxed/simple;
	bh=rBNjr6kRv3/yIwqc/jRraCQ/hHpllxvlDjPvfJRQLWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RA8y0vsOL0tPkc8EftyPykjjQ/6K89ennsWS+C0ubkTEXY5fs3He/nkBdgZBdSSSWV3f1HAb4h9wH1RQAnGTT2FtJ0viFA9J8cK1dc4XamWtxhiXrT1hId3X12qw1oJhfr1PC5dILnzFQJMN5ILKE8Y7LwexRtc6O4NrwriqUL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rPhzGdkV; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGm0i5Bb8WibCCSQcoT2vioNloDLZ9EsRovlRIK5/oPR6ahns7NKfmwE6ddDI4v0wBdg9eFlzzmGKHHfHIst5BLu3HzvaOzQCgpGcQreokelzS3TESAbfKfz1jt4DNNTjX9+NJgFTDyvP3zKtXr4hpzdJGx0yEnnaT0h9GCoDsU5kq80g8l8PfuSIwBSVLJB5/2J8yMHgqs4VKUvm/G13HcEOG7k71u6gr40GTnja47S++soerzPi1kyUw3HPNe7Unn+ATmbGVWGmF6BIHASFch2DkFNT5uLvYowE/19MYxa7D/x0IhzX3Cbp3fUp+Uuf2byKpCfeqX7XpK0a07mWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCprr2fyTRR/0ZtIgFRG33NQWfz+G3RuQYJDL8I6ne0=;
 b=Jindh9oWhUvZ84d/LZljfTY1n+t81ZgCwb78Z+g8XSCvTGp4cW0ISOCBj+I/cnviCalDUC536HUYQ9ytILWFxqw0hVyI3qIIADEYVARSO27eTkaU1Ajsri7wcPbm/zSF4n1U8YfmgV1/ybAZIyh+sD9y9JWTfGP9uQXNeE7wPDSNMLQ9Pz1lM+kxQCUrkkOmcILW4/nIVvHPhIIjisPyezgdCawFRS3FvIW2ia7kMo6ZLxYBP5+kn8tZMK4+GpHL5FZs/Z1m222tD6wqJ0ki9dy3JUhO74/Fk8CF077xudah7oKwzZlQ0pZks3TZsfjjRWyf9HUDx0dpN6eAUTzS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCprr2fyTRR/0ZtIgFRG33NQWfz+G3RuQYJDL8I6ne0=;
 b=rPhzGdkVPVgCAM5Lxod7MMn+zqhnZjvlgvWtmI+dDxl+kxO0RNsi3TFDSfHp0zM7WMTfxAQZ9AQ3gp8rW6QvP25to/DTqXz0D25hUR6DzztXlgwu3ZNsNTq1ypLOEs2Rn1j7IEgMBPrNOfJNGdG8Kru6ryy4FiC0hZvN1q7oadk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Tue, 15 Oct
 2024 19:50:43 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%3]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 19:50:43 +0000
Message-ID: <341139a9-a2d0-465e-bdd3-bdd009b78589@amd.com>
Date: Tue, 15 Oct 2024 14:50:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 4/5] bnxt_en: Add TPH support in BNXT driver
To: "Panicker, Manoj" <Manoj.Panicker2@amd.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "gospo@broadcom.com" <gospo@broadcom.com>,
 "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
 "ajit.khaparde@broadcom.com" <ajit.khaparde@broadcom.com>,
 "somnath.kotur@broadcom.com" <somnath.kotur@broadcom.com>,
 "andrew.gospodarek@broadcom.com" <andrew.gospodarek@broadcom.com>,
 "VanTassell, Eric" <Eric.VanTassell@amd.com>,
 "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "horms@kernel.org" <horms@kernel.org>,
 "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lukas@wunner.de" <lukas@wunner.de>,
 "paul.e.luse@intel.com" <paul.e.luse@intel.com>,
 "jing2.liu@intel.com" <jing2.liu@intel.com>
References: <20241002165954.128085-1-wei.huang2@amd.com>
 <20241002165954.128085-5-wei.huang2@amd.com>
 <20241008063959.0b073aab@kernel.org>
 <MN0PR12MB6174E0F2572E7BFC65EA464BAF792@MN0PR12MB6174.namprd12.prod.outlook.com>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <MN0PR12MB6174E0F2572E7BFC65EA464BAF792@MN0PR12MB6174.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:806:122::18) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ed30e2-d219-4074-7fb8-08dced52a765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUM4VlJpRFlneW00ME9TYUU3OG1hdDJRNEJ0NldkU3RaZmprTTBjM1VYV3Vv?=
 =?utf-8?B?U01vcXlHeDNZVFZrcVNqYjhEMGVJUjVaZFh4MTRyTCtqaVFqSlY1OTZYbkF6?=
 =?utf-8?B?ZmJ4OUEvRVc0dmRodmYrM01zcE12Tlo3N29xM3JNZEtRSmZzZXVIN1RzcEFN?=
 =?utf-8?B?b29SZHhNRUpzdkNLdzY0elpUZG9CclhYZkl6cUNTQkhheFVEOVgyOGI0b1l2?=
 =?utf-8?B?WlhESmY4MkZpb2lMeEVYb0ZVVmhQeVVaSnBsbXQzVmk1SkZnZ1JCRDlMT1I5?=
 =?utf-8?B?RkF5K1FRVENMcFZWenVSWEk3RHRnNzR0Ni9LTGUwTThKY2hDNy91QWFIOWRl?=
 =?utf-8?B?aHhJa2NLdUN2QXY0N0h3aFVTUisyOFhQQXFCeHFlRm5ab0ZrM3lmVmkvNDJy?=
 =?utf-8?B?bVRocnlLU3MvbXpKaktGcElGb0V0d1VFUWdxc0I2My9MR1duTzd2S3BsVXdn?=
 =?utf-8?B?TVZSeXBtRHNiRndCVTJYMFlhUnA3QnRyclRNb0ZwWUVHTEpaWGJzQk11Vmt2?=
 =?utf-8?B?U3NwOTdyTjhKa01lSGZITHM1OUdLTXYwdmxmcDRzSmc1R3IwcC9qdE5ZbWxH?=
 =?utf-8?B?bGtkRDRtZGRWR0szMitEOFVqRmlXWjdjZTFQejlXMWFzL0ZDS0g1RlZkdU9i?=
 =?utf-8?B?dFkrdklGaGF5Vmo4ZkpEVGtaanlTYUozMlQzay9JWi9KRU1rSHFBQTFjaGlO?=
 =?utf-8?B?Mnp5K0tqYWRESmxXSUJmaXhURk1SS1R5VmVTaXhZaldhME9aUGR6dm1ZUk1Z?=
 =?utf-8?B?YmhnQXZNdWpjamwydWtsM0YxczVnTVgwUWNqbVc1VlFLazlTQXRVYzJ3UWYy?=
 =?utf-8?B?cWpCU1l6d3JERnV6MnZBeUlHelFCVnFIa1Y2Z2pWdEwwZEtsMjk1VGpnT3ZW?=
 =?utf-8?B?WUtqZCtobXIrYW4zN01xNnh4eVBRMU5SWnJ6djduNFowT0JXTFE5S2NDUG9x?=
 =?utf-8?B?cGRoQmJGWU00RzQ3ODlndGhiYTRMZVlDdEsrTlRHbXREaytHMUptMGhjWU50?=
 =?utf-8?B?cVhseGtDeDNYS2J1S1FZM3pvWW9lcVpJL3llM1JmL2UyZk8yWVgydTU2KzQw?=
 =?utf-8?B?ZzZDVFhJT3F3RGIxM2djaEtTSGtkRHp5WDIzdkpmTENUclJ4bDRld2M4SUdk?=
 =?utf-8?B?Vk1pWUZ4bFR4dlJTdmpVcGl0eG8zNXZVeXo2MXBRWmVWMVFrS2t0M044SFJB?=
 =?utf-8?B?eVprRXpTWjA4cE1UQjJkbExFbnhvaFpXNzFRU2o5SjBTdTQwK0RNelEvR01G?=
 =?utf-8?B?dlQ1V1dncVVmTXEwbFIzZUlnc0dwYWZQYURnWkFmMzAyaHBMKzY5SjVLb1Az?=
 =?utf-8?B?V0F5Y21WTFQyMlByVXBRaHFzMHRYTzM5YVgvU0RQNVN6bUVCazFoQWZtOFBj?=
 =?utf-8?B?U28vbnd3WHlURFBoZVVmNitpZ1hqZHF5VWV5Z1NUYmVWSXU0dnpPc3NDeGJw?=
 =?utf-8?B?V3dZeFVWeXRMWWdFT3F5WURiRHg1WGJoZXlRL0NKZ3Z2NWU2UkY2VnJyVGFX?=
 =?utf-8?B?dVpHUFRFTmpORjJKM3VtVnc2cXovWkhiaEZZZG5ucTdoTWVYdzNXM3JydVdK?=
 =?utf-8?B?cmxwczYvL1pkSnVHczgvYmx6cUg0TTJmR01ZTXZ4VDlmbWdpbElwN1VzelUw?=
 =?utf-8?B?TU8vRzNPUGdQZllpMWE1WklMK0ZsNFRtZGtoSnk4RzlLYkhzdXhUMzZPdTVn?=
 =?utf-8?B?eC9OcGxrbkZiQ3RZYzlXRWxHejAwWTBKMVkyTUhvckovWCttcFJOTCtRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGNOSmdaOCtTRjRWUkpYL2haaWhVem5udlhYblluYkRUbW1kS2ZhUW5oamh2?=
 =?utf-8?B?S3VlQW5tVmllUVBKSi9oKzNLeDdOZmdLMWRuOW9yOVZHT1psRjNWbGJFY3Fv?=
 =?utf-8?B?RjE4Z3FQTkwyc0txK3dmQk1GZkxuSlB3d3ZVbWZRM1VDTDYzMmhlYXVhS1Ur?=
 =?utf-8?B?SU9HQVVmdUM2TStJeGdobCsxM1pMMjRxVmc1eFFiZkYzWlVMQVNpeUV0VUsr?=
 =?utf-8?B?L1JFUFpEZE0xemkvRjdEbEl5Tm9LVW1wemtraytCR2FDWTd3SkNnRzVYMUpZ?=
 =?utf-8?B?ZVhYeEQzek9JRzdBWHJrQytnR2wwdDZxQW80OElaaURNV2ZnOHcyYkw0aXZI?=
 =?utf-8?B?RktYZ1NIYzNtdzUyd2JwMk1HK0FRUjVLTGRUbmRVNyszMThCNFc5eEhuMVR3?=
 =?utf-8?B?MmtuOVR5OG5mQU9aSjRFT1dUVGdxMlYxYnpWZWNSMVBNcW0vN3JUNDdmcmVz?=
 =?utf-8?B?Y0NQSEwwbGFEUkVibzFKdW5GalVOVVd0RWJjRnZpdTNQY2NjVmo4VDVBRG1Q?=
 =?utf-8?B?ZnpDdlNpZWpiYzZMLy9oWVlsOTV3QlgwMEFLYmh3bXdwaEcybXRUam0yWWFM?=
 =?utf-8?B?NXJPbTlQRTNHMFkrakVSRzZDaHltMFhmVjdHRDJUenZ1QUoyY09yYmZraS94?=
 =?utf-8?B?b0pKeGhmR0NKN0I5MHU5eVZiWGZkbktPZ1BxSEdJdS9aRGIvcnF3OFZFSHBI?=
 =?utf-8?B?cFovbkhHWE51VzdHOEdzMERCa253SlVSYldTVFpEdTJtY0tWNUVIeHBnR2ND?=
 =?utf-8?B?emRlM3dSbi9nODJpNlJsTTMrUWZqL0tsNGxVdVAxWU9KYzBBaHRhcDFwWGFt?=
 =?utf-8?B?eFlUMVp6NkpzejNEMFBwOGoydHIzckE1YVJRUFNkaWoyN1U4d25mZ2IvR0dm?=
 =?utf-8?B?YVdHaU5oVkhlZVR4QjhnTjNHaENWY2tlWGpUb1BBcWxZREdydk9VTkNRNnlu?=
 =?utf-8?B?eThKdUNLdnREVDBUZkF6cHJMZ0R5dXZUbXRnUWs0amNpS1AwdzcrS3JSUnBm?=
 =?utf-8?B?cUNZeXVLMzVLN2lsKzlUOWlVL0ZpaE9PaHRBcE1PYUtiWWMzWWptZVdtZFlC?=
 =?utf-8?B?eUdMbnNENmVtdFV5Zy8ra0k0Rk9PUDRQRWpTVWx6R2xscXZTaUF1c3A1aUMw?=
 =?utf-8?B?WGlUdzhKVWdxNjZoczlQNmR0L3pZQVVkeURRYkJva0FXdGF2aHQrRGNTUTN5?=
 =?utf-8?B?ME9Tc3U4UkVRZXlUNmhzQ0M0dVFERlpBb05yWHgrQmZEb1VyVjNLMEpVVXJR?=
 =?utf-8?B?Z3VqYzN5QTZ0RklVMkd1QlIrYTRXZ3FjNnRVL1hkcHFqUXYxRmFQRXJiU2Jw?=
 =?utf-8?B?V2laeGE1THUvL1VJZWYvNWFKeUJLSk96T2JzeG5NcEVaSWRBWk9CWU1NS0hG?=
 =?utf-8?B?VVlQNnVJTjU1bkZXZWVLM3U0SSsycHdVbHBXVjdFcU9xeERxaVhXN1BNQkxB?=
 =?utf-8?B?MkRUSmVFR3FvYmFldktnNituTjgzakFQMmFzMUdNaUhIU2RnTk9vQkcybkds?=
 =?utf-8?B?bFFrMzVtN1Zaa1ltMkEvUHBnVWt1T3owYi9nOENOc3FPS21Tb05CT2VONVAv?=
 =?utf-8?B?bkZ6eDVwMUZwYkFUZWF6Y1FZaWJKbFlHNjBCeXZzZUY0aUdWdlMwWXhiVHpy?=
 =?utf-8?B?UVFrK1FmQ0x2WHZ1THUwblRveXcvbjAyZEZ1RE1LaS92NXh6K3JnQ3E5RlBh?=
 =?utf-8?B?UlViUWk3eVlhYzFNanl5eitkSWlLTUk1dzhWUmwraEpTRHkvcEVBdVR4Y2k1?=
 =?utf-8?B?SjBPM0t3L2VnNWRFODNQYWJEWldFQnRqaWFOeHozOUFQN1U1RFB6d0pmNHZm?=
 =?utf-8?B?MWRJOWxFdnpFcWdLWWg0aTJDZnZoQ01Md1R0OFVoWXM4NEptZ0haVVBJNFYz?=
 =?utf-8?B?ZkhEcExEaGdBV0RZeU9GMkZSNFNYWU96d3Q0WXhVOFp3WE53ODJabkJtYkwr?=
 =?utf-8?B?YlRqNFkrWi83VWhRK1BRZlJ1V0ZoK3M1SzVZWWdXU2l0RlU1cDRJc2IxZ2p5?=
 =?utf-8?B?Vm9SckZobnFMRVdvTHMwOXlSYnl4QVEwUzlRQ2xIQ2MxdUVmUkROYVVJYlJS?=
 =?utf-8?B?bmR1eTErTllsSHYwT1BKL0FuZW5HcEdjVXZ2L21TVUVQWUxnU2daTHg3bGV2?=
 =?utf-8?Q?NXLU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ed30e2-d219-4074-7fb8-08dced52a765
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 19:50:43.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SiH6HXbHS89SbFyL9e2vdjGNKAxESuOmp6yLQzVE3vN5bRjWTprrlAWDuZRLAJW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340

[These question are for both Jakub and Bjorn]

Any suggestions on how to proceed? I can send out a V8 patchset if Jakub
is OK with Manoj's solution? Or only a new patch #4 is needed since the
rest are intact.

Thanks,
-Wei

On 10/11/24 13:35, Panicker, Manoj wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hello Jakub,
> 
> Thanks for the feedback. We'll update the patch to cover the code under the rtnl_lock.
> 
> About the empty function, there are no actions to perform when the driver's notify.release function is called. The IRQ notifier is only registered once and there are no older IRQ notifiers for the driver that could get called back. We also followed the precedent seen from other drivers in the kernel tree that follow the same mechanism .
> 
> See code:
> From drivers/net/ethernet/intel/i40e/i40e_main.c
> static void i40e_irq_affinity_release(struct kref *ref) {}
> 
> 
> From drivers/net/ethernet/intel/iavf/iavf_main.c
> static void iavf_irq_affinity_release(struct kref *ref) {}
> 
> 
> From drivers/net/ethernet/fungible/funeth/funeth_main.c
> static void fun_irq_aff_release(struct kref __always_unused *ref)
> {
> }
> 
> 
> Thanks
> Manoj
> 
> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, October 8, 2024 6:40 AM
> To: Huang2, Wei <Wei.Huang2@amd.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; linux-doc@vger.kernel.org; netdev@vger.kernel.org; Jonathan.Cameron@Huawei.com; helgaas@kernel.org; corbet@lwn.net; davem@davemloft.net; edumazet@google.com; pabeni@redhat.com; alex.williamson@redhat.com; gospo@broadcom.com; michael.chan@broadcom.com; ajit.khaparde@broadcom.com; somnath.kotur@broadcom.com; andrew.gospodarek@broadcom.com; Panicker, Manoj <Manoj.Panicker2@amd.com>; VanTassell, Eric <Eric.VanTassell@amd.com>; vadim.fedorenko@linux.dev; horms@kernel.org; bagasdotme@gmail.com; bhelgaas@google.com; lukas@wunner.de; paul.e.luse@intel.com; jing2.liu@intel.com
> Subject: Re: [PATCH V7 4/5] bnxt_en: Add TPH support in BNXT driver
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, 2 Oct 2024 11:59:53 -0500 Wei Huang wrote:
>> +     if (netif_running(irq->bp->dev)) {
>> +             rtnl_lock();
>> +             err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
>> +             if (err)
>> +                     netdev_err(irq->bp->dev,
>> +                                "rx queue restart failed: err=%d\n", err);
>> +             rtnl_unlock();
>> +     }
>> +}
>> +
>> +static void __bnxt_irq_affinity_release(struct kref __always_unused
>> +*ref) { }
> 
> An empty release function is always a red flag.
> How is the reference counting used here?
> Is irq_set_affinity_notifier() not synchronous?
> Otherwise the rtnl_lock() should probably cover the running check.

