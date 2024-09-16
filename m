Return-Path: <linux-pci+bounces-13250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C593997A890
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 23:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7661F24BFE
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 21:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5B315B119;
	Mon, 16 Sep 2024 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="06ra3QFZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525E217753;
	Mon, 16 Sep 2024 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726520918; cv=fail; b=AKBaetbzmRVED3pJg8U5oBtnu9/ottqy+ufzIsISJf0gkFi6p4yd4FzJHAxDnDW5htgmgqbrzVy3Lmba7EcXkr2IJZ27Yxg6Mlg0YVijFZl30dBFm1LgWxKWFM/Qlc1IgcSdb1+0t85E0rKFFHuiAD/O5zOGUsjlqc+vgtdazXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726520918; c=relaxed/simple;
	bh=VSBnFUf0iyGTWnyxYjN1GggLsM+yAdC9nRRk/WSqriA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cU9V5ssqaks/egGuJKE9gI59nDgOudLRsOxaNEDrXFyPxW/B7WT+GjPdxTwZq8Rdm8XZn2uJfF7gfNySJ5hZaQnFVYCRGrOxKAZF2z5XTrAGVx+mKyAmSf4Xdz844U1quYscVTxEWLrFi+MD9G9sLTa0E4UxIMrTJffPEfX5RP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=06ra3QFZ; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyVT4gI1zHjViV1/kdUSVJcDZKUKyYAt7Askv/yRGc+Q9xxJpsn/t40cvx9SW1zvdk3T4NPBAxJWXXho4h3CvYqTDHAX6BNw9QAg+ynmE5NigcsVB+i0D8h7IPcL8nX+0tdMe67V26lnBERSBDhkuwEt+xynqos9INv5MlAy/l4vvLTdhsVSFNDD68OuHho8Ba4ZPRzFH1vqQL9BZOWmJVdRRMYh4Dq1467FFY3LPpsKPvDVA6Jk/7rV3LUKL5nu6Ijsx1w3BEhmVR33TEjGMJ5jS15MNbve9AIXgxqeWrLj9QwSWUrYXUvm8vHW348ua4cpIdDoOxHXWwKNV6pLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTe2uXkfuqvt9a/OB7rKoxAvpUKsk38sE1m6H07EGNY=;
 b=KBt2cjBrs/HbP9505ElhtGmGbM8GYILKiwZgi/cLRS7xz682HjRzX/nIrGZilElKaRuInkR8csk7hmrBpWclHtlM3FL8QuRtrY/n/jF3PuYvF8wBB2Xsk7KXWebmP7xwzhtKZidsQ+9ZcYHPOi1uQfH/DtIy9czrfQpD14BJo+wXNIfFQAQA5szYEvLysqRL/1ygBe46WEiTh5zDKUjbtr1UFERqmFt3C4vYIOdgT9lygC3cEXpIN8mu7u+9ws8obAZQiSmTf+cft0ZYQN1W7DD1xJ2DeYdOp4N5UD7niMQxlI1HkUzeA1mMTiRoSXuSan2C2DDRiKnpF1xUum2tAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTe2uXkfuqvt9a/OB7rKoxAvpUKsk38sE1m6H07EGNY=;
 b=06ra3QFZULUASlCvThvoqc8qHLWhdmoLQLfdWNHFYD8MSui7BqeTbvAdZENRU05XI2d3yrEuzycoOH47k3HA/eP7bJ/BLP52sdG8s37ZvW0tWmjPAiy5L9DkzPSoPihE3sbq+k9Qpw0vniy75AGTq9O0s6AR03yQf06K/Ue9Sks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 21:08:33 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 21:08:33 +0000
Message-ID: <273c175a-f640-456b-991b-15a332147540@amd.com>
Date: Mon, 16 Sep 2024 16:08:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 02/12] PCI: Add TPH related register definition
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
References: <20240905164128.GA391042@bhelgaas>
From: Wei Huang <wei.huang2@amd.com>
Content-Language: en-US
In-Reply-To: <20240905164128.GA391042@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::19) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 980f776f-877c-465c-739d-08dcd693b934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGdaRlBpa21hMHNpRXpuOFA2VFdZNzdZamYyRG9tNFdCL1pqSU1pYnk0S2hE?=
 =?utf-8?B?ZXVGMkRKL0RNaVF5ZGZ2OWVOVE5lb3djR2hRRmh6clR6Vy9JT3FmRjlta1Zx?=
 =?utf-8?B?YTAzQjl6U1VnNC9MWW13ZUJWL2V2NWlnVllaSEhEVEZ4dHVLTStQWHRnQUxX?=
 =?utf-8?B?SHloS0xCVFBrZ3F6eTdUY01QSm9jSGlJUUhtbFh3MXV0RGp1Y0JIbUNjL2Vr?=
 =?utf-8?B?WWNHT2pnOXQ3b0VhQ3UzWlZodFZ0b2tsSzQrKzVvaFJGczZFeHVnRlpyekwv?=
 =?utf-8?B?MFB5dG0xOTlPb0NSYUhRYVgxZDRGRDJ5a0w2Q3NtSWxaSys1QWFLNnppOW9Y?=
 =?utf-8?B?NWh5NDEzVndqTkVkRkZBT3NLSjFyU3J1ZFhXV3JyaGtPVHJZR0piUlJZaTRh?=
 =?utf-8?B?NittRXVlVGJsS0tielNqbzFSaHNXU1l4a2M1NDZHMHlvdnJWNHd4LzZvbmFI?=
 =?utf-8?B?Y0ZWRm5RcHNHcmhPVlpYNTZyK0UyMUI3cmJFdG9IbVhVb1JpVFVxUDN2Y0ox?=
 =?utf-8?B?ZERZTWNzbG16T1lQNUZvUmJmeEpsR1FHNVk0WTNtR21sK2JPaFBoa0NoaC9s?=
 =?utf-8?B?NjFiQnUvR1MxUGc0SnhVSkVqb0U1RXZ1T1NCS2pXcENMN2F1dEErc0QxM084?=
 =?utf-8?B?cU9OTmZ5b0NTUUdxY2dOMUhxL2RrRVlqM0NYQXF0aUxlNTE0ZkhlYjFlM1JS?=
 =?utf-8?B?Q2pLWjB2V2gybVJGRjB0ODNOUVByZXhrVWhrL3E2MU1nK0tjbGpVRlZYVncw?=
 =?utf-8?B?T1hidmF1OFVQYjl6cUZDZ0RkR2VCS0NYdW04aWoxQVdLM2d1NHlOWXpwNmZG?=
 =?utf-8?B?Qkdxb2YwUUhxaVRmSytnMlM1aERoUVZWcks0V0lyZnpIY2R0aXJXN05tY1pa?=
 =?utf-8?B?UHpheFlyQXRhV25yYjc5OWJQb1U0VnhsWHRJd1IwVmkzNk81bXZBNVlOZTRI?=
 =?utf-8?B?Y2l5MnZTWUlzenVFNFZ0NmphUGhKWU1teWtmVStVUnRLdVltT0JhYk1wUnZa?=
 =?utf-8?B?TGdra3MvaDhpT01hZGRheFhhYWE5RXV3eWk1U1VvVUFVM0NqNTZlTFRTMW0v?=
 =?utf-8?B?MWRJMVhMbkk2SGpDMUI1VU5JOFVYWlBBb20rL2hnK090NkV1Vzc3ditrRmN4?=
 =?utf-8?B?U1E4NWFXVHhPNTJNYmRNeWsrVmpyMHhqRXp5VkNSTWxmS0NCVzF6aDBtY1VD?=
 =?utf-8?B?elM2UDZkQXV3a2RYRW8zZnc3VEt4eFNkalc0WDMzNy85ZmFRZENYZzM4djJI?=
 =?utf-8?B?MUpjdnFPUmRQQUZhdmo4ZjB4TW9WNDl0VzVBT01rTDg0OWtpc3lrUmRRTzVu?=
 =?utf-8?B?ZlpGM0ZOeTFaM1pvOU9NLzVFd2hjQitqOEtaZS9peE5KYStLQ2tNbEVXOVJB?=
 =?utf-8?B?YzdON3c5bHB1akEveFNYVW1YeWgxNktDL21YbCtDK0Y5YU1UcFFqQ1o3NVBP?=
 =?utf-8?B?dkNyaDZPaWxwT2RScE54OFQvMmZEVXRmTCtndEdWY2RhM0FXek1DeGwvUkNh?=
 =?utf-8?B?a082Y25QOTZnWGhkdkJlUVN2QmIybkZabTQyb2E2NWMySFVscGEzZVlVTEZG?=
 =?utf-8?B?dU42Um14TnE4UXU3MnE4LytGc0JqbFVDMVdZOGl2SUFCdW9OZFBhZWlpWjRo?=
 =?utf-8?B?Tis0MUlHRFh2RUlhaDN2Y1pNRDQ5NW1BZXJpOGtOMzRkZWZmLzhlc2ZObGM3?=
 =?utf-8?B?cXBGcXBjRktpMGJQUzRndnVWMTFlQllTQWFwcXVIOVlqUnhPc0NYMjdXc1pB?=
 =?utf-8?B?aE1BTVUwbVd2NW9ZcVVucWIwQmVsa3ozR1BvWHROUDU4c2lXbk9adjl2WE50?=
 =?utf-8?B?QXliMS9sRkV0bWc1L3AzQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjRlSGVlNTdNUzB0WXVtMzUwOExseG80SDJzRCtFcXlQSXRYelkrT0hnbE9Y?=
 =?utf-8?B?ZFlocHM2S2lEOFlSZ2N5OXd3aHA2SmJiZ3BhN1dnaWQ2cWpmRUZySEExY1NY?=
 =?utf-8?B?cG40aS9nMzl3MWhCRzNMZk5tZjlmb2RhYmZnUSswMWlaMUZPRW8rbUNrdGtj?=
 =?utf-8?B?Y2JUTkpzVUtRUDAxOUFrZ3BtU1hHeGt1dFdjYkpOZksvM3k1L1FqVVZZUEor?=
 =?utf-8?B?VE9SUW1sOVpCMlo3ZkQ4VlgrTGdRV0haVkR1Qk9GS0owdXNQSVVkaUh0UENO?=
 =?utf-8?B?YUtoRnV6UHlxU1BoMTBlajZFRy94QnFqWEN5UkFidW5TVlNia0JJSngwWUUy?=
 =?utf-8?B?dGpKcUIydzRqanFBamxDOWpTWDNzb3FjSXU2Sk5RRkhHYzBSSVBpckVHZ1BL?=
 =?utf-8?B?ZTBPMk9UYUpQb3NQTGpCSVNCVzRNdWF1MUQ1YUlCSFpvWFI2K3FHWmxCcFRB?=
 =?utf-8?B?VVVHQVZQSWNvVGsyRGZWaklhNS9JQ3phUjBmOHJSN3UvTkwyUjlPYjBDT3A1?=
 =?utf-8?B?T3gzR3M1Ui9hdXU5YTJqdXQ0dnpkVjVDam1BTkhXSVQyWlZhVDlBRWpoUmZN?=
 =?utf-8?B?RGxUclFlekExbzBhcVZ2WEtsMGxENFVhdGsvZkx5ZlRhSjV2aU4rOGsrOVIw?=
 =?utf-8?B?dTVCbjk4ejZJQ2V5R2N3SVh3a0oxaGZlbkRxcGE0cnYyQWNLMmRWVnZjYUhy?=
 =?utf-8?B?N1poQlhsRStIbmF1YU9IbFN4UVFuSGtzTXE4STd2OG9xcDlzRmdJRHo5aStZ?=
 =?utf-8?B?VjhRYXJrSXdtQldEMVY2TG5XajVXZnR3dVBaVVhnR1lFQmFFcDh1YjJTazhJ?=
 =?utf-8?B?WTZUMWUxaHJIOTBUTTF1K3M3eUhvS3UyS0p4N1FMRHhUNkZqNXNwZzdiY3Vk?=
 =?utf-8?B?d29Ca3FrNGNBQW1YZzBwZFJ4WUcrZ3JXL1dsL1hOS0g2TFhDU1pLcmRqbmd2?=
 =?utf-8?B?WGdnQXQ5c0Q4OU9HNjFHZWFsaWo5aU4xL1Zya0g5cFBOMytDamlFcS85Znha?=
 =?utf-8?B?d2pLbE5iVEJzYWJ0SHVobjg3ZHZIenpwY3kvdDNaMUFvZzZaOVFTNTI0eUNr?=
 =?utf-8?B?SFhBMHgzalJJRkxWWXJzd0pmd2dwYmtoVHpZb3lTRE4wd2JQcDdwV2hXbXFx?=
 =?utf-8?B?OXd0VWF0ZzVKdU1LS2F2WFk0NUQrVEc3QnNTeEtRSG53UXk0REV0M3kwY2Yz?=
 =?utf-8?B?VVhtSmx4SXkxS0p2TG4xYmEweWErY2p0cWJyK0VwcXdMVnlrZ2tWY2NhQjEv?=
 =?utf-8?B?TlVWc3RybTdvNzBCODZSREpqVnhNWE9vVWNyTVZQeTVIR1hMNzYwVGxDb0Ux?=
 =?utf-8?B?cjhHUmFCa0V1cmRPVWI3eU5LcnNGaHlXeEtGeEZ5TUlWWVY4Z2lRT01hQ0NC?=
 =?utf-8?B?YzAvYllrVEdoTjVFT0FTSmVRb2NkZVRqTVRvU0U1V2orcnNHRHpjM1lBMmwr?=
 =?utf-8?B?K1NvUExrU2tMSWxVb2xPR0E4K1hvMUtlZmhobDVGZ2xlU3BubkVhS3BrUVVS?=
 =?utf-8?B?MGRGbkZ5Q29PWmhvVnMrQ2xGUUdCZFVhMWZsS1J6M0Vvb1JvNGtaU1FWSnhZ?=
 =?utf-8?B?enJmUjFYcGJaTWZ6cE1GaitoTzBDQXIxeDI2amhHL1UvMm9GUWpXcFFscHhR?=
 =?utf-8?B?QUlabC9FRTR0WElUVytqWm5xazdnM3Y0MjM2UmlDZkU2ZHNZazUwWHBET2o5?=
 =?utf-8?B?THpnVlorSzk5MjJpTE9LNURKZUo1UkJYMzdyeE9aWG5ZWEk3cUtIZSt2MVFJ?=
 =?utf-8?B?cUM3WmQzVlJlQnpXNWYzZW5EenRnMk1obGxkUjF1NTlVRTdVTjl5SkhBZ0dk?=
 =?utf-8?B?c1FSb2hlVTllZ0tNOE9uYUx2UlJ5K3dSa04zeTBBZGhGZFFxZGpLdWhiNnNI?=
 =?utf-8?B?dTU1QVRzejltUjIxNnJlZVJzM1V6U0RSN2lmUE4xaldoYWtPemFtb2FFbXpm?=
 =?utf-8?B?YjBVSTVpSEVxQUhGY0ZzTU1GdnRZSHF1SzUwVkdaN1YzU1hyczZBbmRNbXZO?=
 =?utf-8?B?THRGeGZtb01Lb2M5M2prZ000RFJqOFNGRGpMUk55MUVWbjBGaVhYTXNJelpM?=
 =?utf-8?B?dzJlVm1YUmJSTWhXd3BOS1N2SUEybkowMGFCMzRadG5EMUpsZmtBWWpOalRN?=
 =?utf-8?Q?jnryLNMud+NfWaDsP8YZZgHOk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980f776f-877c-465c-739d-08dcd693b934
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 21:08:33.7997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDd1g8fdkNSQnKVrxulifBLIWAftjFT2ktbPp5J32kqg60aA74Mbu4okM3MaESK5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402



On 9/5/24 11:41 AM, Bjorn Helgaas wrote:
> On Thu, Sep 05, 2024 at 10:08:33AM -0500, Wei Huang wrote:
>> On 9/4/24 14:52, Bjorn Helgaas wrote:
>>> I think these modes should all include "ST" to clearly delineate
>>> Steering Tags from the Processing Hints.  E.g.,
>>>
>>>    PCI_TPH_CAP_ST_NO_ST       or maybe PCI_TPH_CAP_ST_NONE
>>
>> Can I keep "NO_ST" instead of switching over to "ST_NONE"? First, it
>> matches with PCIe spec. Secondly, IMO "ST_NONE" implies no ST support at
>> all.
> 
> Sure.  Does PCI_TPH_CAP_ST_NO_ST work for you?  That follows the same
> PCI_TPH_CAP_ST_* pattern as below.

So I tweaked a bit in V5 to make them look cleaner: instead of ST_NO_ST, 
V5 has ST_NS. Similar pattern applies to other modes:

PCI_TPH_CAP_NO_ST =>    PCI_TPH_CAP_ST_NS
PCI_TPH_CAP_INT_VEC =>  PCI_TPH_CAP_ST_IV
PCI_TPH_CAP_DEV_SPEC => PCI_TPH_CAP_ST_DS

Ctrl register has similar changes.

