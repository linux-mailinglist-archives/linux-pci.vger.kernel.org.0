Return-Path: <linux-pci+bounces-9604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB20F9246F1
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 20:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEB51C24CB0
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 18:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E6F1C8FA9;
	Tue,  2 Jul 2024 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Y/u2SqR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A001C0DF4;
	Tue,  2 Jul 2024 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943450; cv=fail; b=sZUmNYTtAWtEd417qEdqHhDkQ2fhf8A/i/jkg9sAtO0qCP5DEQ4130UVwFbY1iqE9QifucaRE8N2jbjbXJcj4eJMMwiWRKZu78LtLNLyqZbfaxZhQc7lUlSpm1rMGLWsksoMFfRBDT2Vkmk5+bFIJf3fhiWpX9B70rqerPoZkAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943450; c=relaxed/simple;
	bh=I9gsdB4wjvpuTKxfFK0TfrfEnoENn+e5AJeFx/mJQaQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fu6jjgCW9+NXApDdAQ/pUxXDNvw6sUC109twsS67HFroba6W0eHnb/aWroMVFi5lOYyNNxsaXn6qxB45BJO6VLJr6wQ/O7DdybFGOq0FrvB61bIXoYhu3z9JA1fLvms5cgxJrIHKgp8yYvepjN5uEyNbaJWKSt53mnXCijairpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Y/u2SqR; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdLoOFJ6iTEkbt9ct2JHVwwKJ1WUaNE7y5WJ7RH0tss9fkmva3XtHZbmYjJM/jwTj+NZfSzO9OzdFiSZtWgI+AlEcugbj7zs3oP5f34UqxsRQFsaWSs5orpdHzg1Aeetw3pVJ+DXOjebTcpaOykB/1uXF0Pq95XMQqQRrfBfuUqLLYbeaQwZqq5QdbTmmNM5mw+9Nrdt+pCiejljMh8M0Rmun3DtCZvdVRTcieDQ7d6AxGfuGf3H3FdmU8AIfvP7cLwAmbHaL2fEyS4HslwbvF4DXY7tVfx1qrhkjO4iIJ9DBc2hUq+0BcFEccGOvyfbvdi8UWmRAcKcpyxp7aGhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObuXu3wRv653Cf0Otd0EWEv/W3liv/2j6oDkVFpOsJA=;
 b=Vw4V7yBmIrlQd09F9wcVJaYj+1mlxrwvn3V1kmWQBEw8qYa3f6HOAnaUVKQInz1YPraou0TpX0gebmfuWB2myzlBjcc7fXPoNIcDj8wXhx3Hov0sNr+wPNorxNiPx047X1qXak7M4Nkt426h5ZP6SB2LOYSwrhVUL8eAuDnVBs6DIFywxq+5gNLIzBrj8t3cUMTvAVHzkR4kjgc4Tt/T+ms9WvTGTdqG4vZN1mNhDllikKBTB5HXBSoMvifnb2S+AAMvzvP9IwV4QBsI9FQdDSb1J7ZO3p/anEBG+LqyKOSionQwvJeQtY8AVOpUEbjhgeyZ+xgr/Xcht8VC6lL0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObuXu3wRv653Cf0Otd0EWEv/W3liv/2j6oDkVFpOsJA=;
 b=4Y/u2SqRj4IhW1VXPzyAqIkuoNgUmp5A3BIjjlzjdN/pcDrqoHULGE3F41uPk9iJuYWVUEuMyDvvhfiD90CeoBnnVfWrHpgCmMqKnWeAAwZQCKpsxmd4hFxQX+ny0EHOlq8u3/pIw8Si2C4yADDlNsz2b5+K+vMYxWZznh7y++8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 18:04:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 18:04:03 +0000
Message-ID: <32f45838-f0d1-48c8-8ab4-1a02511be401@amd.com>
Date: Tue, 2 Jul 2024 13:04:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/pwrctl: Decrease message about child OF nodes to
 debug
To: Bartosz Golaszewski <brgl@bgdev.pl>, superm1@kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amit Pundir <amit.pundir@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Praveenkumar Patil <PraveenKumar.Patil@amd.com>
References: <20240702173255.39932-1-superm1@kernel.org>
 <CAMRc=MfBJi2BGZxfLHgbu2AgRyZ9Z_smWMCy_hD6HuW3HxrNsw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAMRc=MfBJi2BGZxfLHgbu2AgRyZ9Z_smWMCy_hD6HuW3HxrNsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0191.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ddd571-d337-402b-6c22-08dc9ac15b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHEvQnFvVmc5ZWNnaHA3QkhVdy96bzlXSUwzalBGTUgvaXp2NWd5cnpjUlVp?=
 =?utf-8?B?WER5TmRlUlhQSC9KWk9qZjdlMEhNbUZ2ejFob2JsQ08wV1NrZW5XQnRxdFox?=
 =?utf-8?B?SFBXWUZXM01LT25XN1lKNUp6UmRJcG9nQkMxUVNiLzQ0MFNJRkt6UC9LZFlC?=
 =?utf-8?B?UjQ1WGFUQnoveXVxdnBRK0tyYkZ1dnpxcGhHS0QrWHdxMys5cHZxbkh6Rmtv?=
 =?utf-8?B?a2dHTVJWcWI3R3d3ZGIxMGorYmR4MnNRblpBcWZ3Sm5BV1JIazQzRjRLSjUz?=
 =?utf-8?B?T0lteHAxYlh5NzBkOExsZFM4NjczMnlZejBEMXZrUElHeTJTRCtvNTVNZFZa?=
 =?utf-8?B?eVZydlVxbmNTanp1TzBJbnRPVnY5TXpDaXR4L1kzTkdrYmFPdVZtTnphOU5i?=
 =?utf-8?B?N1lnU2RoS0lZTnlxazQ1SHBkdHlVakd6Nm1oUXluL1d4eHRCYWlBMDNjMTNM?=
 =?utf-8?B?cFljOVdad1YrekFZcFM0MGlLT0UwenlpVDdwcnpWem95ZTkzNlBXWGhsSVRB?=
 =?utf-8?B?YnhPQjJuNXMwZi9jQVVBZ1M1YVhSak1hZW83TTM1OGNqaVVFVXRXbURSK1Vu?=
 =?utf-8?B?SGNUNmZJWGhhTGNqZFcxV0xsbmZJVUJJSTRRYjlvT0IvVlBKcVhFNmZlR2JJ?=
 =?utf-8?B?Rk9ZcEZ2bEo2MzRGSTE0U29JdmNRSFFseGxndHFGZGpHZ3JCVWpvUDhxQ2lC?=
 =?utf-8?B?WFhNbE5xM1JhSUU5RC9Iby9IUU5WemJLY2k1a1pOWVdDb0gyaWF2NWxRalYv?=
 =?utf-8?B?VlZZTXdPc0tXL3JDY3BFTHZpU1hoUjU0ZW1kaFV2MkZVa0xvMS9kVnhYUFlo?=
 =?utf-8?B?UGR5VWtTTWdBdVRtMTAyb2M4UGx5bnUxMHBNTHVWaXpaSTVmNXh3ZWJDQ3Vy?=
 =?utf-8?B?R0VXeFdPRzhZUU1MbU1XTzJDT1pzZUcxQmdrdDU5enlPUXpvc1l5WG5jN2tH?=
 =?utf-8?B?eFQwMnlKZkkzbkZocUpzc3dJL3VYWlJ6ckFBMXNHMU0wT1FzY3dPMWtsSnhO?=
 =?utf-8?B?WGxqMjZreWM0d3pCMTYrYm1TRlhZY3hsVkttODNJYjkrOTNLU3gxeWIvYlhL?=
 =?utf-8?B?bDJjSjkzRVRmSmU4enFNTDNwUi9mYnhpUUovc2l3K0phZnMvbThib1hqWEV3?=
 =?utf-8?B?bWZYSXhjSjRpVnd1MzFlSHNuMFU5ZEFvSVR3OUVvVzBrVWhBL1J3MlVYeXZo?=
 =?utf-8?B?eVRLdDZCSXl1eFZYNUFYbll0Ymt6aDhWVVBpaUl3NXNkZGZpNVo4OU9PeUZV?=
 =?utf-8?B?YklzU3VFeXkzZE8vMkRTTTdZQmdTQ21ZaG5OM0FFcGNUS0RVWG9vWmlaeEtT?=
 =?utf-8?B?OFd2MDJkZ1dHWnpneTJDbjFrTVVSSHNqOGdNWlorSDNmc0lBWDBLVklmd1Ru?=
 =?utf-8?B?dDJBQm91MWVoc1dLeUNHbnRqOUwvRVkxVHNuMEREL3RVTGRlcnk0VXN6cSty?=
 =?utf-8?B?L0dOV2dNU1UyYS84OEk5VVZUN2hUcTdlenFzdkdvVUFDQnVFU1FaUGRUWHVx?=
 =?utf-8?B?Nm15a2NSRlJLdFJGQjkrd1I1aTJLRDJsY0F1NmlwME9FZFY5WVpNT1QvUzlH?=
 =?utf-8?B?THFpZk9WL2l6SzNxcG9uOGdTa0ZSUHgzZ2ZsemhrVlh4VTY1am5aOENBSEZt?=
 =?utf-8?B?NFJHVFRiT1o4cG1nK0k4NFVCVUgzK3pRb1cvc0poQ0pvTjl6VzJMWVc2SVRL?=
 =?utf-8?B?Q1prWC9EMjQ4ZFRyN3NYamtHSFNzVkFFb1IzUVZOVmY5bEhVUVZacmNRLysy?=
 =?utf-8?B?blJWaUdQTkt6TGJyUTJjQmFkS3ZMbkMyeTRBNmNQNHVQSXNKUDduMGphZXJD?=
 =?utf-8?B?WDZLaUZTaWxCVWc0VW95UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVZzc1RycFR2V1E2UFJMalp0YnVLeUNxVUlIV0NvWDY1OWltUFk3VHJlNXV6?=
 =?utf-8?B?cWZYSmpDL1c4WENMMldTLzlSQ0xkNjZFY1RFVmc1ZzNIaEtoOWxUQTIvL204?=
 =?utf-8?B?ZEFlWE5oNVo4dWIydEJlMzNyV0R5bUxucXNYRVNtUERQN3F3V3BDem5aVWw2?=
 =?utf-8?B?b0dPSE5QWEJGcktwSG52bUVkdE1tRkZhb3haUFU4aXl6R2kwM2RZUzVxcXRU?=
 =?utf-8?B?ZS9JV0ZYK0wxUWx0SnJtS0xqN2x2clIrYTJCZmtpT2Y4THdKK09hWmZjUzJL?=
 =?utf-8?B?bGkrcDdJcDJlWTZZb2wxdkZhZkk0eG1tNWRtdG8vOXZPSmFqZ1RKYmZLbXNC?=
 =?utf-8?B?Y2QwcGY5RHNYMEpJOGYvVTdENml4UnVLWTAyV3VpanlRb0lzMmZ2VkVjWCti?=
 =?utf-8?B?L0NjTDV5UHpLb0JlbzA0ejF5V0U0WWlYUVdRZVp3c1NMakZPdWtNbktrQVIx?=
 =?utf-8?B?bEVBRHFuZVhONFU4VWtHMTZXZGFqSjhIZHExMXUwM3oybVNsbjBVOVZyc0xa?=
 =?utf-8?B?Tmpmd0QwTGU0QXBSOEp6ZjBKZFhla1hqZ1E3d2JGdTFJc0ZBRHJkcFpySy9v?=
 =?utf-8?B?WkQwR2pRVEhuRTR0RUx0aXI2cUlsbTRsR3oyaGJGdVJ6TEZrRjZaamFZNmFT?=
 =?utf-8?B?U29zQ1Brc1FaSUZVMkRhYTA5Z1JlMjNWN1dYYk0wc0l0ckxQYis0NUlVOUhQ?=
 =?utf-8?B?b2hLWFlUVkFzdG1MTnR1V1JoWVJoR0l1QUt3YThIUngwLzErMGFoUUVIMFVN?=
 =?utf-8?B?eXIxTnY4VHU2c2N1RWx4a1JVTlkxeTE2TWhjeXVOR2F6N2xmRW56d3luYzFJ?=
 =?utf-8?B?bE14UmFTRDUzdUFMRSswSitzZThWdnIvT1hqQmJHYUJtcy9zaCtVNWRGSEZs?=
 =?utf-8?B?UkI0Qys0VVpqQ1A2Ymc5K3FlSnRUOVZrWURzL2lMSGdjU1E4WG44bkZFY3hi?=
 =?utf-8?B?YmQ2SWpsTlZHZVA3VTMwY2t1Q0pLWnpHOGJ2cmF5RTVLWU5Uc2tZWnZpNW5M?=
 =?utf-8?B?djZDV3JPM3prQ3dFYmJEMHdOWVFyT1ZDRFNaZWR1VjZpRXA1dGdER3JrVjlo?=
 =?utf-8?B?Rlc0OEk0alhBWUlGZ01LZ1pNYnFSSGNhUXQzSkdXaURVNXBSYnEwTUVGcWlP?=
 =?utf-8?B?dVVDOUJDZkhHWk5ZQXJqZFNVVlRRODFReUp6bnBEelh3dVBEcGM3QzduWEti?=
 =?utf-8?B?U1BnRVRTQktyNEtUZXByL3E1Qi9BM3U5WHpMWVI3K0lpQ09LUm80Tnh0YUtH?=
 =?utf-8?B?U2V2YmJqK093U0J1QkhBK1FxR3BqVnUrZ0wvZktmQ2ZXRzFJVFdmNXZjM3lv?=
 =?utf-8?B?ejBxUXI3bkVxeTFQZ0xxTEhqdjFYRERKSWpSMmpoYy9iSGJiS213VFVXVzNu?=
 =?utf-8?B?SDNIdDhSWVJKaEpscnlDd1NJS1VSazVXRnZUdUFLWTh6QUtSRGIvYktKdGpl?=
 =?utf-8?B?TmtuMzNwU0J6Ty9Md0lMRnoyUVBLMXlJSkxRNDR5WmVSOU9DQ0o3T3ZHQ3hy?=
 =?utf-8?B?bmpZNlc3b0lzQ3hsYktnQ2dYazB5aTIzNDdRWUQxcGgrNHNZRHZacjlPWjJE?=
 =?utf-8?B?MnIrcURNZVREMUptKzBBSUtUcFIzeXZqZXo4UUdja3psV3NUYzJabmJUbDlO?=
 =?utf-8?B?NUNncjE1OGswTHpnbm9iQ09JSEZLNWVsRjBFNlc5dFl6STFjQVdybXpmZTho?=
 =?utf-8?B?NXN4SlhyTE9XUDk1enpTaEtTdkNUMVNLd25qeHRBZ0QwdXMwUzZRWjNCZHZU?=
 =?utf-8?B?UFBudmtMVlR5V1pJb21jU1dwbExyZ3ZQL3BRZHNYV2lLQkJBbEFlVm8wR1Q3?=
 =?utf-8?B?NGhlOFpTd2hPUWhmQWEyQkRHRTcrRjRmcHdsVlZUR1pWRlFYUDY4RDF1eTh5?=
 =?utf-8?B?V3BraGNjeFhtc1JKVkNrVXJ0dk9VU2Z5R3ZsQURiUGtqcitIb2JBNE5sY1Vx?=
 =?utf-8?B?S2dIUi9nOGpnTEgrMWtBU2thNlBYMEVpN1ZvWXhUQ2VicU15ZTBKYk1KdkdB?=
 =?utf-8?B?RVdBcjZDWlhRMHk3RmQwVXQvdkdDVm5lYmhFK2JUOEFGTXZQaDJSVGhkQ3dF?=
 =?utf-8?B?WlpOVXBOOWZnN0NsU3FYcnlWK1lPNnpxM1pYTjY3bmZxVzcwenJDYlU3U0Qy?=
 =?utf-8?Q?9YptU1oVHjD7gsIeUdUEV2bOY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ddd571-d337-402b-6c22-08dc9ac15b4f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 18:04:03.2088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COqTbU3KQvXPOa9iHlZextUZRyHlr3xni2nYdF0KY1aA9o5MdgC7paEt19yGI/130HFMaP4AWrnp2UqD+OBONA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048

On 7/2/2024 13:00, Bartosz Golaszewski wrote:
> On Tue, Jul 2, 2024 at 7:33 PM <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> commit 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF
>> nodes of the port node") introduced a new error message about populating
>> OF nodes. This message isn't relevant on non-OF platforms, so downgrade
>> it to debug instead.
>>
>> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> Cc: Amit Pundir <amit.pundir@linaro.org>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QRD & SM8650-HDK
>> Cc: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
>> Reported-by: Praveenkumar Patil <PraveenKumar.Patil@amd.com>
>> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/bus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index e4735428814d..f21c4ec979b5 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -354,7 +354,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>>                  retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
>>                                                &dev->dev);
>>                  if (retval)
>> -                       pci_err(dev, "failed to populate child OF nodes (%d)\n",
>> +                       pci_dbg(dev, "failed to populate child OF nodes (%d)\n",
>>                                  retval);
>>          }
>>   }
>> --
>> 2.43.0
>>
>>
> 
> Ah! I was under the impression that of_platform_populate() would
> return 0 with !OF but it returns -ENODEV instead...
> 
> Maybe do:
> 
> if (retval && retval != -ENODEV) and keep pci_err() here?
> 
> Bart

Sure, fine by me.  I'll drop a v2.

Thanks!

