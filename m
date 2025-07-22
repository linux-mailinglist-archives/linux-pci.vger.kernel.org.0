Return-Path: <linux-pci+bounces-32752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2105EB0E368
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 20:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D16016D256
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 18:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4DC27FD4B;
	Tue, 22 Jul 2025 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="puxSRNEi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FE027FD5D;
	Tue, 22 Jul 2025 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208602; cv=fail; b=DzW8Lf0UBttufaGGWw+l928aS4vvTmTgyp771JqLsje41gLptFJnOcu5LF7UNTly8U5yfwWxjbe2Xg//qAnTpCEY/nGOKQpcCGrzYUbYSpNv3nWwr+rDu4r0MP4269V6oXaCk/4EMEzPWL2P8AlVZPKN/8fVlNNftTJ/rtiBxSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208602; c=relaxed/simple;
	bh=iGen8+M4zm3v+gT7sGKsy2SQAAsSZDwK5Ec7+bbNBvY=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VrSXzD/bvWcSOMXZL3lSHQ49Iwl95eFy+NUH9AE+2am0U4dwwY7Be1C0vAJudv+oEqOwMNrwj5Xu7N0vEftD+P0ofWL7hw9HmJ/3llmn0NunvhoL5VR9qbA9IcnVI+SqIdpNlCaeXzju+3V3iAk4D81onF7syd77skMFecarFhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=puxSRNEi; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmG3F7kuCS2U6YI+zlXlz5+7636cOxhTRDlPQ17Ei7b7lk2Z95n8jSRc/6/mt4k4PtIML3XDofE1QVaWTbxhfRkKDLj/pX7vRaAdkCKDaHq4pVLvMyCNxIDJgFwEiZRsKy88P+G/37JBB8PUjXyHfZ6O4HgCNBQ5ErsSCkUjnAEG8A8bT0cc0It6yNOe7QjnPP9kUFetHqdox6pSDHH9ZmVDL4R2sXw6n1dfyoDiG5qS2opKCabUqzxA3CnXIhKa0uPeW80P0TEwkAtFPxsq56zkXuF1RfqSiNFogW5v3oxaWwb6OC6OIPnhV3o8SFggohhglPPfRg80SDCfxbFjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDhk4W6bK3LbC1mGeXpik6/KlatDF8tztWEC7sNC2Iw=;
 b=ke1EDOxt39Iv1F2WJHivOm6wZvUGr03WeJPr41AUDnaxS5XQS0QvBd7wJ1xQWPcQzfwvS18v6+iOaqQVbj3Nyj5TPBgy2/VSweYnYDocRWTILHo/GEoK9/IPLbcSyNKdPzR1EkpsotHoMNBwYwI9SYMMJsvmEi4hIN43jdogdDiOl6Z44s0/I7n3EmfsuocHTjGAa/onUMe5Yn/+mQgf4XnZ9POGraiiAh5UP1NcLlauVuYtA9Hy3CrXGetd49apOn3Ki17CQiVa5eI6HYtuZL0884XCRSO/wAg2DuszlpEjID75Tno4T2J5srZCP+H7D1MLAuqq//cPZAx4QBpJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDhk4W6bK3LbC1mGeXpik6/KlatDF8tztWEC7sNC2Iw=;
 b=puxSRNEi7JVU5vN7SFhfoP9NfpgKJexXI4N4DOgj/nywFm7fDiWjV6/Hcfd1b+YQwjHbTPgLoHd4d3pHXoihteQC5sXEG2Rn5qZQ3F0k56s+k6aIIi/n3RoQGPNFzjWKw674zbJHG0SG/ZszDyQxPBFXtY2Z/2EwH6JSYp0EQuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Tue, 22 Jul 2025 18:23:16 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 18:23:16 +0000
Message-ID: <f569fcb2-52f0-476a-946f-56db53fa7f9c@amd.com>
Date: Tue, 22 Jul 2025 13:23:13 -0500
User-Agent: Mozilla Thunderbird
From: "Bowman, Terry" <terry.bowman@amd.com>
Subject: Re: [PATCH v10 14/17] cxl/pci: Introduce CXL Endpoint protocol error
 handlers
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-15-terry.bowman@amd.com>
 <24643016-688e-4c50-a577-3cf831cfb73a@intel.com>
Content-Language: en-US
In-Reply-To: <24643016-688e-4c50-a577-3cf831cfb73a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::32) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS7PR12MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c84dd85-a358-4818-623a-08ddc94cd3c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djZaVENCN2pXZm5ZVlNOaEp3VzBFUzdoVE1uMHpnTWhZaHZLOGFUdXFPOU80?=
 =?utf-8?B?dFpUUXZYN2gxYnRFb0lzTmRacDI2b1ZEUnZiUCtWSUljTlExZGJDR3kzN1k5?=
 =?utf-8?B?aUY2cnNrQmt6akRaNFpRVi8yUVVoR0hXSTNVOFoyY2c1UGxpSldVZ1ZsWHhr?=
 =?utf-8?B?ZEpMM3JWY2VJbUcwRHpQK1NwcVVFQk83cVczR3VzQUFhTGRrWlplVVduVGYw?=
 =?utf-8?B?c0RMdlBlTXZvaFF4MFlLMStoQWpycWNXNnBWMUtBNFJwU1JMdzdBUjlTb0J2?=
 =?utf-8?B?aCtXb2g3SmlEeUUyVWtydC9sazdaS1BYb0FpRm5IQVRZMzNVN3VnbUhkOXdS?=
 =?utf-8?B?TlNTQmpuWVJ0dXdJRVJqeTQrRXFSSWkzSERWV0o5dXpzQzZiMVdNeUtEanhv?=
 =?utf-8?B?V280K3pzNFdkanpGblZzRW52b1JpdHpjZFlmQWlscEF1QUR4WHFTRVZ3WVZS?=
 =?utf-8?B?SnhnTWNvT3F2Q2VnTlgrVit2Nzd2NUp3Qk9PTlB6ZXNka3FXaUw4VFdmRXgx?=
 =?utf-8?B?RXJFYXhhb2RJbkFvMUJudndRSXoydHlFQlduWnRmVE1nK0psVzg1UFIvNVNl?=
 =?utf-8?B?Q01IZlZ5UTlEZ0JyZUVHR0dFSGVFdUdGTFBtK1dKUjhsRlo4RnRHcGpkbXU2?=
 =?utf-8?B?ZE9SMGRmaVdEZS92R1dMY1BkN2NLMkFma09GeWMxdVNIQkpLY3ErYVVCWktj?=
 =?utf-8?B?REU1aThXQjI4M0I2cURiaGorNlREUThUNzFZa21PV1ZhbGkyMkhlOHhLbFI1?=
 =?utf-8?B?cTZDVWpWc29qQVdsUmloVDVoVTFxNjNBSS9TV0lhNE0zQ1BUZEtDaC90SDF0?=
 =?utf-8?B?WlhoV2FNcjNNbWlGdWtlRmdETEtraVJTVmFUK1pjaWgxVFZsZ0FhTDRNRHlX?=
 =?utf-8?B?a2NmOFpTdXVTbTFGYU05N2wzVS9YVGo2QmFFemxaNyt6VnRJVll6dXNydUxB?=
 =?utf-8?B?NTdsWjN2M3ZtckhFdW9KK3FCQnQ5YW5ZRGVyTnR0U2xiaGd0dWdzQmRjLzdQ?=
 =?utf-8?B?azlDQjRVTE0wVEUxTkhjbDhobTZ6ajJlcFVHSnJKNTNBV3lLYXV2RGhWTzNs?=
 =?utf-8?B?WnVuOTNjYi9IVmlVRFNRRUJBU1pBZTdzL09SZlRtclZBazZ1Y2Q1bTBxaEpI?=
 =?utf-8?B?RWthTnVTWXpGVk1veTl2YVNHSCszOGRSaWFaUUl2b25Ieit6QzdEWXFQV25z?=
 =?utf-8?B?YnlIM2IreHhXUXhrUnYvT2U1Sm5OOVhPRTVhS1VFcVduYkFGS3hnTnNOV2c0?=
 =?utf-8?B?TE03ZlF1YlRDRGNSb3ZHZWRodVArRC8zZzBDNEJUdkdaZE1EQ3hYYTVRdnpM?=
 =?utf-8?B?SGpEcU5DNGtnTVlqc3ZTNmNQSFh3Wi81SFpWUFJNNU1rWWJGN1c0aFpVMTll?=
 =?utf-8?B?emhZVThndzltTW5kTE1OWWZUUHlIWG1GRy9TejkyMzBOOW94MEkxU0pEdlJ2?=
 =?utf-8?B?dk92MDc3QnplZWlnK1N2eDVzWDRwaW9OUVhTSWRJS09kNkRpUmIwTmgwNDVY?=
 =?utf-8?B?KysrRGxWRFFHODhUTDAzdnNwVXE2NjdvNVZSZjJqZml0eENzd0hvRzZ0d2tC?=
 =?utf-8?B?MjdKRFhaMG9XQlVlYVlPV1BoOUJTemo1L0t2R1J5QmI2dWtyRld4S2M5QkRF?=
 =?utf-8?B?b081VktFNStzcHpzL0FuQXNTdFM4cmZad2VrQmdvWm1YRE9xNzgreWt4YmxR?=
 =?utf-8?B?c2p4K1VHbng5L0VGbFdnSGVteWJ3SkZ4VktPUlFuUzJvR3lDZy9qRTNydHRs?=
 =?utf-8?B?cXZpSDZrM2ZnZXZTTzlOOXAzVFV0dXJaM2VaSUp6dWdyejYvdEVxenQ5VGlx?=
 =?utf-8?B?NzBFSXUwWGV2WlIxUDVxMXZ6V3g4WVhjYXBxYnEyYmJoam5aQ1FtZlpaMTQx?=
 =?utf-8?B?VjVqNTY0YmhGUG5xM2RVSGlvdTZtWjVwN1paZHpTdmNjTENGOW5qcVJ4Vmc0?=
 =?utf-8?B?ZDRyd3JlbnYxYW5CUnl3Q3hZMkRQalpnOERneFltQVZCRmlJVktCeUY4a2FC?=
 =?utf-8?B?NWozcFRzU3VBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0t2U204aGxKaCtObHIrbm81UWxkSk8rZlZBN3lNbXdaTEJnQzNBRzNYMSt5?=
 =?utf-8?B?RjU3V21jVkxjTFdReWxSdHVrdlhwQWlocXZHMEUxZnR6SlVhcFExN0VaN0or?=
 =?utf-8?B?SlJLODV1T3gwNXZCaVRITlpMa3I5NE9EZXFGelByaE54MjRtRnczVCtKd1J6?=
 =?utf-8?B?ZGVhSTBNazZUQ1IyVEE3R0JMaUs3OUlWOXlrdmJVRnoyaGxIVlczSWR5c294?=
 =?utf-8?B?M1Mzd2NVblJPRlMwUXV6QWN2clNWZlRVR0ppWFVTMVZXNUptUHlDaUlUbzZa?=
 =?utf-8?B?SWdvMFBIMkZ3RmVkcEtydDk1dlowUXpGL3FGNnNYL25tN2dXdVBaTHJCYVNV?=
 =?utf-8?B?cU9jWVBocnU5eU1EZWtTMnRGWVRFU0g2dG9UdEN5ZnBCNVJVSlZiMVM5NFFo?=
 =?utf-8?B?SGczcmc5d24xSGlXelJPZmVlN0RoNGZ2Q1VVTGMyS1RRUi80SXhOQW9LLzdk?=
 =?utf-8?B?RTFCZHJuUXNaaHlOQmVDT0d0NDJTMW1PL2MvNFFFMURsYlZUVlhzanpoclV1?=
 =?utf-8?B?UjRXeDZDZ0dDS2o1ejNjYTFGY21IcXI2cHI0VXZlVWFTUWNta0cxVUc1YjQ3?=
 =?utf-8?B?M3pnTWZjelBZQTJJV3l6SXlDUy9iTFd2UnIvOTQwaUl2ZWdpNXBzK2YxUGJI?=
 =?utf-8?B?ckpyK2VMWERLVzdYWmxvNVF5WExaSGx2cEowaXNqU3pOZ1dFOWwxcHM0VFZF?=
 =?utf-8?B?Z1lPMERvSDdiUHdnZGh5YkJSTklaSXVjd3lBeGszbDc1N2d2a1lCbFpwa2tp?=
 =?utf-8?B?eUs1RGpMTVVCN3M4TExRb2lST3JpWDVmYU1XU2dnMm9vTW1IVzkxZXhidWNn?=
 =?utf-8?B?TEVyMkYzVnRSTzZIaWIyU043Q0dXQ0VQY1F5R1d3Q1JzYlpGY3pIT0xWaUI5?=
 =?utf-8?B?YTBBZlozL2VVZTYwcHVuQnAxV0wwSmNWVTRNRlgwUXVkQXR1NUN2eVQ5bHNG?=
 =?utf-8?B?WE9qNnBUdFFTVXZ0WWt5aFJmTzJnYWRoNXd6N3piUzhlK2NiNm5BTjJ3djQ3?=
 =?utf-8?B?S1ozSWwzNUpUZVIvZjlucEJhVUcxOHpyQk5FRkIwZXl4YytzQVVYMk9KMlBG?=
 =?utf-8?B?RXgxdU0rRDhkbFg0TGFNZlo3Wm5WbmNIN1BsS0VldUk5bFdFZGdLNUJZdG4z?=
 =?utf-8?B?Z3F6MnJVcUJ2cDlUSUdqZ3BZUk9zNDlyRkJnQ2FoWnBncVpOczNNZGhIMGVO?=
 =?utf-8?B?N0ZrSUdIUW82em5Uc3ZaVHdFYjh5Mlh2VVNsRGl4SEpzb3lnZ3g4VjRvMCtF?=
 =?utf-8?B?SXBKQmJEcDVCMjNZNHJvZ3FOTVNNWTU3T09nN2tWYWRoZkl1ejRrY21xdVlv?=
 =?utf-8?B?elhyRms2TEkwcnBGUkgxenFtTFBNcWlsZGdYY1NnYW5oRzk5ZnhqblNEMDNi?=
 =?utf-8?B?ZW1qa3JMVzFjR0Z6NCtUenZkdWxlaWljUThqdVZDM0FUSVlEcE93dVJVL1pu?=
 =?utf-8?B?T2VoZ2c5VnZUMzRkTm9TL1RieTVyWStoQUVtckl5bWtqWnE0N2RrU3U3YmJq?=
 =?utf-8?B?VXJYNlRmRU8wTk0xTE5OYjRrRS9zVkNOMXhtUVFveGJuZjZFbGpGZFBweHpp?=
 =?utf-8?B?dHFTT05qdDFMczRDeTYzTjcvOVpBVGFJZFR3UFR0aHEzQXlla3JQNlpWTTBo?=
 =?utf-8?B?YkovN1FOSDNnNHRBa1dKTVQvdnQ4Wklwc0hnSXpBNzBsL1RWZzAyY1NGVlRh?=
 =?utf-8?B?bFJ5ejYwQStiK2Y2c2Z6Z1VQRGxtR1VyR0FyYnY2QW1VMlg4ajRHSVBvYXZZ?=
 =?utf-8?B?eEg1NFZuSUk1VXllQm9JR2VnL2hIUGJDY3VrVXVWTnpiNlhGUTNuQkR2MjRV?=
 =?utf-8?B?Mk9DZmlFVzNabm1EWGJsSTlEb081ZElHQkNjMDUvRCtWK3puN2hwQ3JNblNE?=
 =?utf-8?B?dVdDVGl1VHZ3L2hFbDBMR0orYzFKdE8vcm10QUhubVNKRzlybktsNXVQYTJC?=
 =?utf-8?B?cEFXWVhSanVYZjMxZFJJT0ptcDFURWNUeGxaL2dwNS93ZkFreGx6T3NvbWl1?=
 =?utf-8?B?SlNsRVRhUGlLMnBSMGY2NGpYckVweVpEamY0SWU0bFdTalRlR29ISXhTVktp?=
 =?utf-8?B?WGI2aXFRT2pIQk9JVGNxcXVaNm9RUEdKN1NkRWFpaEt2TGN6ZnZSRkV3blV1?=
 =?utf-8?Q?PW70OD0QmVlg6w8z6wJ0A3bul?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c84dd85-a358-4818-623a-08ddc94cd3c8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 18:23:16.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxhOXqSYVKrtGCnH8Qoaw2NpE83WDOooUxFwZLHWAPHPkY+uAvan1JSzUMdpCBfWWL1xzQItFAftnGzvS/4nFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475



On 7/21/2025 5:35 PM, Dave Jiang wrote:
>
> On 6/26/25 3:42 PM, Terry Bowman wrote:
>> CXL Endpoint protocol errors are currently handled using PCI error
>> handlers. The CXL Endpoint requires CXL specific handling in the case of
>> uncorrectable error (UCE) handling not provided by the PCI handlers.
>>
>> Add CXL specific handlers for CXL Endpoints. Rename the existing
>> cxl_error_handlers to be pci_error_handlers to more correctly indicate
>> the error type and follow naming consistency.
>>
>> The PCI handlers will be called if the CXL device is not trained for
>> alternate protocol (CXL). Update the CXL Endpoint PCI handlers to call the
>> CXL UCE handlers.
> Would the CXL device still be functional if it can't train the CXL protocols? Just wondering if we still need the standard PCI handlers in that case at all. 
>
> DJ

A CXL EP failing training will not support CXL functionality. 

Once training fails the RAS registers may be unavailable. I'm concerned accesses to the 
MMIO RAS registers could possibly cause a MCE if the PCIe device doesn't respond. It will 
depend on how the training fails. This a reason to remove the PCIe handlers.

BTW, the AER status will be logged by the AER driver before a PCIe handler is called.

A while back Dan mentioned we should leave the PCIe EP handlers. He may have an opinion 
or more to add.

-Terry

[snip]


