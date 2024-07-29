Return-Path: <linux-pci+bounces-10972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C8393F8CD
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 16:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95D91F22B7F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5461C15538C;
	Mon, 29 Jul 2024 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vzOH7zWh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B2414601E;
	Mon, 29 Jul 2024 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264986; cv=fail; b=CWeFCpPV8plcHW2QyFHF4QT09NmmP7h9FCQeB5HFFjXrJVvIpY3VlN1sXwjxZN8kEwNv5uYNqNrbDEfE5x5fRzTl8+O56K1QUxtjxHhCWViPPf2gQs+PgUVvXtHLSAgnftzIYxp/fy7b3WWY+kQo0SYVpHQlmX2GezZb8KE2gsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264986; c=relaxed/simple;
	bh=1lx0zeKt85HAfLuBZhwEMF9oJCZ71w3BFP3F5Cq1jfs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M2uCOb7Tm24PrV+omF88CdWvkIjppJsWoYshQNM4ViVzPF9sgOqqaummpJpLTqnlIHFelz4h2PNvvw8IJtKW5oEvF3XqWANQDfOT2rHMjGrD9sAPWIsMgQGz1BPe8HmOLFdU41h5QYxBmlkWpOjG5bnXFbR+48q2eBkHDTNkuX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vzOH7zWh; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFDFo4HdhAOyHQ50uSz//D4Lchs3lafmZSBuofmA9reVpua++Ey3LDsW3z+iMLTH2Ro2FGQkwZkh/zJ9TlNtvjUy0PNRR73oSRo3p1MSOggjLfhIvW56128La9SjHMs5M/IkDP3QjfR4n2OMlHlYIsguBX2Tmq/A5daCYVIZoF+lDGYxeoEFK2v36xpuQwhi+UjeQlBSeZnL5xPFRxDFUilWeWRGHG4qmg6IvwsKGdbavN/mPetNCVnspYI+BCUl5KbgB7GHRTMZ5m42Z4x/kGDEb0AeQODgbmyZwxJj7qQuc4ynj+C35Fpc9MUfp8V5wjkJX79hIcPlvsmMzesG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kFGOySOmrdvYRmqtjsjsDoBoX4Jgt5kgaQJuL0OfdU=;
 b=Giw/UTqBHZXBidpHZApX+uvw+T+DvitW4H3i4aosPRxnmP/WkU8gkNlL4GGOmEePfOu7y20fWcpTvNi65uvYNEoF0+3is2yxkDkbyLRCCgLqoPQGAQkBGRB5BGxFFqGJXCUs53Q6CrR/u2nlwFDZNW4G5EXStZ965ioSNj7KM0Z7/ihACdis5C3wFFCgGBeDTpDLZNA77OVeIp+lyYmPosgYxCsVzg3cDULLzyFWQctn7iPS5HwGa6WA/O9XrGlejwCwR9tvOwXv/G78+PdF+DKGRh+Hw8MFD++fdxd8Hqjq6lqOXod5pp1ZRb9k/+AOyoOUghuF24c9v4P7eYupVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kFGOySOmrdvYRmqtjsjsDoBoX4Jgt5kgaQJuL0OfdU=;
 b=vzOH7zWhzFcIB+SSn0Kfwk0P4jQkl+fZhJOp2/bZMUidyUy3PhHuQOjVxKW6nYmTbxJzBznFda2Yns0pAIwUxg8Mhas82HbvIa03OqllaU2R61SAbw4dM2H54tXDwyUoaZNz7nR15M05BONPZ7ndq6+OIw7p5u8rIn0V89l7cpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Mon, 29 Jul
 2024 14:56:21 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 14:56:21 +0000
Message-ID: <c60a0d22-5002-49a4-8dc9-a7b689ed685f@amd.com>
Date: Mon, 29 Jul 2024 09:56:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 03/10] PCI/TPH: Add pci=notph to prevent use of TPH
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
 Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 bagasdotme@gmail.com, bhelgaas@google.com
References: <20240725212915.GA860294@bhelgaas>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <20240725212915.GA860294@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0094.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::14) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 409a3310-5891-416e-15c9-08dcafde9bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHRiSWVZY3hjNW9Ja1FIQUYrSVovOXhXZHI5T1VSRUxZS3lWOUxjOHAxRG1M?=
 =?utf-8?B?eGxTYjJyNEJHeTlGTEZpTUlLSkhLYXRVb3llOHlEU0U2b0tpWnR4TitYVkMr?=
 =?utf-8?B?RDVoRlhnd0lGZWZGZHEwdkRFTkdXODRWa0ZVMWFqRkRpU3NHQUVtY01GbXE4?=
 =?utf-8?B?K29RL2E4THh1YlFqNXZmNDBWUndqU0Y1TVY3b1lmTDJ3ZzlYcWxmMzhCZCtT?=
 =?utf-8?B?cVV4L3RtUy9MTGpEaVg1aHNtNXlvekVQT2sxcGEwemxZcnYxSmZlLytEQUor?=
 =?utf-8?B?R1BoM3Z3cmtQUGZMN0luYWdCcGJ0dzNIYzcrNTFiSSt6Wjl0TmNEYmkxOXN1?=
 =?utf-8?B?K1JIRXNXdjFmUFFzMUhmZDFGL1VTRS80RURQZHBvN2xVa2lMcldjdC9pQ0pB?=
 =?utf-8?B?QmlpLzZwTCtJM0F0N0MvZGg0ZVBLMVNJdmZCS0Q5NVduYlZpK0todE9UVEdE?=
 =?utf-8?B?cDhMNS9SN2QrL0dsZmQ4M0Z5Yzd0bm5acVFsNUo4b1NHaDBaem5odjFxdVNX?=
 =?utf-8?B?UE5TOGVWeGlSbEwrSmsyejF2UEtOdlNYK1N3WkQwcnB5NDcrcllobDRKUFRE?=
 =?utf-8?B?a0lJQXp1ZUFIME5NdEVWaFo4eVpRd292RGdZN3pNYkMvQTYyTTh3WFhNR2JI?=
 =?utf-8?B?N2QyNEtSeFBjVTlqN1JMQ2RXamI4V1FEdTdYR1hEdzQxYmlkQ1hWdWtqcnlo?=
 =?utf-8?B?dkZPU1UwOGxPVmJSUkxzMTVMNURUbWpFZGtIeTQvZTlpWExmdHV3K1NlYWh3?=
 =?utf-8?B?bndoTW9tSUlPbE8za0IrMTl6cVhqaWFienFpRVErRU01TmRhd2hUNFpXUkJ1?=
 =?utf-8?B?eTZneWZTWCtNUy9sY0hJWkxkdU5nc25FSHBxRjRDcWE1Z3JVaSt1SzFLZ1U1?=
 =?utf-8?B?RmIzUmdtOHFZQnQ0aEhiWk9DeG9iMFpNUU5wQnNjUnRYekxYL3VPczZ5M05h?=
 =?utf-8?B?T0ZCdEwwOHhHK0luczNMMGJhVEJUVUMvOVMvRFlRcFdXWm5jQ0YyYklSSTQx?=
 =?utf-8?B?MGxOWnBRMGdaa1V0OEh6b1AyejR1a2pGLzNBbXdTWGJ3b3NqSjdOazMrazUw?=
 =?utf-8?B?L21hQXJzblBWMmhUM05GQXpHTWZNUjNKb0laWWJmaHhpL3p4M0xEdmtJL1ZE?=
 =?utf-8?B?SjhTaHY5cHJISGtNN2hMYkRMT1R6V1dNQndkMEhlb0tvZm55em5ZTFZ3dU90?=
 =?utf-8?B?a3ZQWWlodlVYbEFZS1Q1NWxxNmp2aUZOMVNiUi92R1h3dEVmd3gzQUpkWUo3?=
 =?utf-8?B?dkZRMEppZWxUNDFQWGhWZUdZNS90d2tTUmZkcmMvQThBNXdqcWx5V1pKdkw2?=
 =?utf-8?B?NHkybGZVT3RiTEZEd2JQai9GdkVPNnFqbk1sY2hqR0RUQWZQbHRVSy9ZYjd0?=
 =?utf-8?B?cE43ZUFlQlBIWjE0dlM4QXhKcWtjbERxdDVacStaeHZZdmxIRnc5OWdZOFNG?=
 =?utf-8?B?WGNtOXVia0FCcm1vNHpZMkcvZVptNGlkT0hTZ1NBd2lRaituMlZEY0RRWTdm?=
 =?utf-8?B?RExLYzFmeVBqMEtKVWJyMU5uaWd2aks5UXJ3dkkwNFVRd00yVG1tUkZFbExJ?=
 =?utf-8?B?V1YwelFWblhKcjZ5c3I1eWVaUU1jQTF3N2tXWXhlanRtYkQxTytJZDliT1pY?=
 =?utf-8?B?Wmt6K2wyVkozNStyN3hhNU9JTmRNaWo2N1huUFBLWlNBNS9XcXpYa0dGYW1K?=
 =?utf-8?B?NTdqbEpFM0c3SkYvNWN3cWxOaml0aC9qcGhNM25OcmEwWFh1a2IvL2NpWlJV?=
 =?utf-8?B?WlNRYWZ0MDc3RXZyUzRZTGI3a3k1YTB6WjlTM3FPN2djVWNHaEtEMm5pc2ZH?=
 =?utf-8?B?bG5RVGlSWXl0aC8rN2NRQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnJaUm9qSklKRHhBTjZodFhubkdReFlJUE9hSkdtL3p6b3ptbW1iZWpWWGxK?=
 =?utf-8?B?MzhsN2JONk02OFBtVFIyaTBPRmpPRENZenVjc0ZFTlp1bUVjWVZHdzBFaUFD?=
 =?utf-8?B?bENLM3RDdU9FWUR2dUxJU1VUYy8rR2UreHR5c3pMU0IydjFteUhmSmcyQ1dr?=
 =?utf-8?B?dWRXNms0NTU5U1pFN2R0S2RpbGRLQm5GWjlsQitYSEowcnVGZkFxSjQySndV?=
 =?utf-8?B?dW5tWFM2OGN2Yndabm5sUDlJblA2aWhiMFJuN2gzOVBiSEdwZDVhc25PUm5t?=
 =?utf-8?B?QXBHMExsTW43TW9ZK0EyVXAxN0hxc1FRc1FCK1lQRW9CVjVRMElSSitYeWhB?=
 =?utf-8?B?OW9HYmUybSt3Zm1lOGducGhNTjNaMGE0c0xBS1ZHOHFMdTd1a0RUYkRKVXFu?=
 =?utf-8?B?Ykgyckg3MnZZVjlpQk5TdUllQ0RnTklnVkxvQ2U4RWh3MmdFV1hNT0JRbmll?=
 =?utf-8?B?TU93SUVlVVV2dm9QcHlrWkhPSXRQQlBoRFJaWkJFdDNCNzVNQnFrY3Zla0pB?=
 =?utf-8?B?K00wOGJ0VlpiVDlhRTZxNXBLZTRXa0RBQVErdkhhMXNCTDlET0NIQy9lN0x0?=
 =?utf-8?B?U0ZLclN1dXN1Z1pBTEh3ZFU4Wjl4ZU0yL0U4VTZLbjg2cDJyalg4eHhvTHdw?=
 =?utf-8?B?ZXdiWVpLNi9FWGRiM2dXYndYcmQrU0Q3QXVMR2RzUDlRWXBKaDRnK3dXUW12?=
 =?utf-8?B?QlMzNjgzZ1JjQjdSQmJKY0cvTWVBMnJaZEtENGFMc3FFUzhSdTNSRzdCeTQ1?=
 =?utf-8?B?am13RFdWSXB3MzRrbS9RMEU4Q2J2RWlCd1AwNFppOVpTdmoxV0NMUkZpUFVa?=
 =?utf-8?B?K3NvdnlsV3NyRk1UTzN2N1VpVTh2TGl3cG5yYVFicGl0cHNuUXp4QXpwZTA4?=
 =?utf-8?B?S09pSFhVSVZONHgzeG8yR1YrdWtVMkJwZUhTN2tkejdiUXVwS0Zkbys0VUxj?=
 =?utf-8?B?K0k2NGVadXYzT2VPREhPVld3cUFiTi9JMWdDckU3ejI5anFLT1FBc3BYSGhw?=
 =?utf-8?B?ZmkyeUtOQm5tR2x0LzBvU2YxN1lVWGwzcFRtUVZFemRhUlpZMnRTeDRrVldG?=
 =?utf-8?B?bFNwR0NjaTNvZDZoQTJaT2wrMWZOekVHY29EbTN0YlZFK3pQWHdjVjF6RGdU?=
 =?utf-8?B?bEI4R1BPKzRuL000Z3VXbmduNVE3Y0c2bXZ1ZjhPbE16ZzlldERwUDlQQVdB?=
 =?utf-8?B?eVJZbUN1cFd4U2tWaVVrYnZPcnRCNFVKQnFxMVdBaFFIUVRkSEtQMzd3Wjc4?=
 =?utf-8?B?czc1dm0vT3orWW1McEI4aXFyZzk4R3plUUtIRkloYUF0WGJXZWdnWG1oRE1H?=
 =?utf-8?B?UmV6em5qTks3cWEyQ1hFVTNaTXJ3TkZyVWhNcXBreFNobFFoSWdNRHp2cTBR?=
 =?utf-8?B?VVd2TytERHZyZk0rZUw4WXlidGg3eTJwOS9NcW0rUUFWK3dsTFZFOVlQTHN4?=
 =?utf-8?B?ZEt6eUp0V3VLaWQwQm5McFFrSXkvbWVEZ1FGcjVEWUdETk1TMkYxcXdJcGdF?=
 =?utf-8?B?ZFBUTHRXdVYzMjVLZVNrUUxPREZCWldrZk5VU2pXTjJCUnEzZUNPUlIvRTlY?=
 =?utf-8?B?WjZuY2x2YVg5TDFMOXcvY0tYSG9LWS9PNTdaN2tnQXZDb3ROZm4vbHdneUZv?=
 =?utf-8?B?dFhMQ21jZlJnMjUreCtNY29RZlhjZWFISUJaczN0anhQd1hEUlRUTUp3MWRL?=
 =?utf-8?B?THE1V0RTMDk1SnpiZHlCMlFYRThwRE1UTDRQNHNyMlFOTVlBdHoySTA1MUM0?=
 =?utf-8?B?YjI4Y3B1T2dKcUFWcnJ4NzRKekVuRWhkMHFUSUYwYzFUSyszQk85RXdqUWc5?=
 =?utf-8?B?SXF1ckM0MVZ4RUpMZUtjem1VVjBZTmJsNVdGOUtqMTN3NitIdnZ2TTlEcXRD?=
 =?utf-8?B?UU1rSjJIWDFBSTJzZEh4dzBuYXQ3NEx1RENUaGRNQ256WnF3L2oyQkx3cERI?=
 =?utf-8?B?NFpGZVBaQWxENFZtSGZBVktmWi91Y3ZWUEc5UUYwSHo1cHoySHFia2Z6ZUdF?=
 =?utf-8?B?N1RMSjFSZ0dqM0tXRHRZZjJWeDQxN3ljamJRSmZEeXN4ZE9MUFQ2VXNWMHdR?=
 =?utf-8?B?blJMS3ZHL0I2M1ptU3dVVkZ5TXJsTGQ1MUxjSTVaL0tHR2VMWUVSTWx1TWZY?=
 =?utf-8?Q?PO5HlfWHl78ryR0N+2L3bmWVB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409a3310-5891-416e-15c9-08dcafde9bc1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 14:56:21.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45KqJ/tUgD86FIvdst9dZwuKUfZdFvIXVMmbvj0EUxY7SFWJF/JX5AF+aWyqXkfn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450



On 7/25/24 16:29, Bjorn Helgaas wrote:
> On Wed, Jul 24, 2024 at 03:05:59PM -0500, Wei Huang wrote:
>>
>>
>> On 7/23/24 17:41, Bjorn Helgaas wrote:
>>> On Wed, Jul 17, 2024 at 03:55:04PM -0500, Wei Huang wrote:
>>>> TLP headers with incorrect steering tags (e.g. caused by buggy driver)
>>>> can potentially cause issues when the system hardware consumes the tags.
>>>
>>> Hmm.  What kind of issues?  Crash?  Data corruption?  Poor
>>> performance?
>>
>> Not crash or functionality errors. Usually it is QoS related because of
>> resource competition. AMD has
> 
> Looks like you had more to say here?

I hit the send button too fast. What I wanted to say was there will be
AMD QoS patches to control TPH. Note that they will be hooked up under
x86/resctrl. Since they are AMD specific, it will be independent from
PCIe subsystem code.

> 
> I *assume* that both the PH hint and the Steering Tags are only
> *hints* and there's no excuse for hardware to corrupt anything (e.g.,
> by omitting cache maintenance) even if the hint turns out to be wrong.
> If that's the case, I assume "can potentially cause issues" really
> just means "might lead to lower performance".  That's what I want to
> clarify and confirm.

Corrrect, only QoS-related concerns. There won't be any correctness
concerns.

> 
>>>> Provide a kernel option, with related helper functions, to completely
>>>> prevent TPH from being enabled.
>>>
>>> Also would be nice to have a hint about the difference between "notph"
>>> and "nostmode".  Maybe that goes in the "nostmode" patch?  I'm not
>>> super clear on all the differences here.
>>
>> I can combine them. Here is the combination and it meaning based on TPH
>> Control Register values:
>>
>> Requestor Enable | ST Mode | Meaning
>> ---------------------------------------------------------------
>> 00               | xx      | TPH disabled (i.e. notph)
>> 01               | 00      | TPH enabled, NO ST Mode (i.e. nostmode)
>> 01 or 11         | 01      | Interrupt Vector mode
>> 01 or 11         | 10      | Device specific mode
>>
>> If you have any other thoughts on how to approach these modes, please
>> let me know.
> 
> IIRC, there's no interface in this series that reall does anything
> with TPH per se; drivers would only use the ST-related things.
> 
> If that's the case, maybe "pci=notph" isn't needed yet.

I can go with it. There will be a BIOS option to turn it off on AMD
platform. I would expect similar options on other vendors' platforms. So
I am not overly concerned about dropping pci=notph.

> 
> Bjorn

