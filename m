Return-Path: <linux-pci+bounces-43030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A15CBC784
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 05:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B5CF3004B91
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 04:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54CE248868;
	Mon, 15 Dec 2025 04:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RJz41H8E"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F391FE45A;
	Mon, 15 Dec 2025 04:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765773343; cv=fail; b=tbBEJJ+8GXEgbdcRveHxsKvvNDCSBak7QuH56DofouVoEn38BZtlkikizsyaW7q/LLNRMnxYgpwfJrPxK2vTvUk6YSNnNxCrK+cT3NhSnbIBaSrkKHrRLhbx2FXhXCkXP5JrkdAwRg4LjFO7If+JbdCg/1hLuoEtWWrUiOdbpEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765773343; c=relaxed/simple;
	bh=YuvHwd3USZmgi84PjLRAtnYn7rHlVFEcn+vf3DRUpB0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=F7q74GUN73OWcoKczhazIVev1SkvN9Bz3N4qTw30nvt3II3mJRwspGY/L323lbgqCkeP1IfWLfPVjHRo3yoUQVIxDJOw5n+CiPx7zkMKhrKJTJECVEac3q585Bd0uXilCKNF3aCBgbhXA59MObOxx7HACGUtLeBMF1/rLVb6k4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RJz41H8E; arc=fail smtp.client-ip=52.101.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8pxE+uNevRY6+uswGQmgEH+wE1TTyWSxQvDifKqZacBHIPBe9cDFYkzy6z6CmnjB/rTAekxSSluDc85i6pX4tWwyBHPENY9FpQyGLJ9+mcck1A5IIDYguOfm4AZLWNWbEJpTe7ERIp/sy9ftlhOIIe21YDAxTjsyQA3ECRjOks3cB3e7XzZro/F4jhZd08skz8EondTzOO2IfXGBsYt5C0hY9XJtI4cQssx2COIOZWlmx7WjBVjNnJrZNPLrZpOBvGetJx+StTk8l7GoGcVCTg0AFWX43zbuwMAKOdKytr9SMbCHlkzy8S/oHhXNeasXGrjO43XH/6bTpilbSzlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPWW4Kq8RIQ1HNdxY5pmQXak+TN6KkBQ7K8rMTo7RDY=;
 b=zW/YTSYSQMnWGDyNhGs33iquM2Sp9CLIJNjfRs6Kf8vg2es3RKarcSIKSM2U7ivAlbP9EkCqRmC3jiMLl3EO24f8d9Fxa/7JJCQ0T1FJLTOHH92pXx1m+uJb6nzcbVicK+Xp4uIg+yXcZDbFi3wz5ZW6zde7xuz3xe3lWu764j5NJ6u/fctDYAvDiH5SKPazttOiDCRn0hMMzWpsTIrVdro5Wr4S25tsF7Xqe77yD35v7B2lbkRc6yB5/25kdLKer3hFFTqc34Dn4WRp+1T2U7DVOzfCRAUZUeVe9k+XOkdlrgY3B+rPCT5a7IBtZW3o8DWUBPVNJz+OrD/eIhQHFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPWW4Kq8RIQ1HNdxY5pmQXak+TN6KkBQ7K8rMTo7RDY=;
 b=RJz41H8EDf0Vw45As91jG/gblrzejFYuJlmAb30k40I98T43r/UV9hbLSzk0s30l6Axk88Lhqth3nfJB2g+36eS496XYBcKCvPuLSoy29Vd1S6NKfrvBUuhte+l6wmgN4ORbF6al6JBd/WbEnHAvSqbqbtUK1TSP1xzK3Il+36nceq/umukFL//2TOrXRd2AyJfm0hDhcCgTbHYEuiaqtwhggZiYxeRXtXuq6oqH5orLTDfCnZk3fKKVDtwu9cy/jZFvIBPrBB+ejhIfNb63Jj9a6wia1OGwZO6Jcr/CdsdeWuFg4Gcgr6bzisyw1yh9M70jXwH1LTYrc2+Kpg21/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:35:39 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:35:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 13:35:36 +0900
Message-Id: <DEYIEO1HG5KD.1UI84OJ1RNMCJ@nvidia.com>
Cc: <airlied@gmail.com>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <alex@shazbot.org>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>, "Nouveau"
 <nouveau-bounces@lists.freedesktop.org>
Subject: Re: [RFC 6/7] gpu: nova-core: reserve a larger GSP WPR2 heap when
 vGPU is enabled.
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-7-zhiw@nvidia.com>
In-Reply-To: <20251206124208.305963-7-zhiw@nvidia.com>
X-ClientProxiedBy: TY4P286CA0125.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fcbbd8-193f-4642-7757-08de3b936648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW5oYjIxTVpWQ1B1VnpnTSsvZHVCNUxNemZLN2RwOUJ5OGV6R09uMDkrTkJh?=
 =?utf-8?B?R1lKK2pQWXU3dFl6bEQrTjdKcWthcFRSM0gxSTZBTUtQQmtCL2ZJK1phM1ZL?=
 =?utf-8?B?bkpjQmNEeWU0aDdoMmRjcHkvZk1SaTBaWk9ibXlFdjYxeGYxOWdXS3R2L2po?=
 =?utf-8?B?M0xBcXZGQmZkYUZEeU9OczJsdWUwUUNYbDJ2cjhYSmsxVGlLTWlYcHVkUkh3?=
 =?utf-8?B?WU83VjA3R3hpSXl5S3MrWkZGWlpQdFFselV6N2dvMUM4ZGVuK2k0YkhGZUF0?=
 =?utf-8?B?L25hT1NFcXhMbThQZWZ5cURYMjA3SlZzZEdnK0crcEtFT3g4WjhLZmEyZlMx?=
 =?utf-8?B?bDZ6NXkrNnpPTXMvSjVrNW5jZitNR1NQTSswbHdKeHlCUWZXaENYT25xeTZH?=
 =?utf-8?B?Z25ZNWRhTGd3SzR1TXJxR1JzYy9zQTlsSmcrdkU1bjBGL0tsWVBVRG9XbXVC?=
 =?utf-8?B?c0tVNlVRbnBlcEhHYkdRRWMwWG9nQ1puU2NobEhuREc0d1Q4U1NjYzhCT3Fp?=
 =?utf-8?B?eDhTS0RVZWVGS3ZrcXRsQmx6Vi80V0cxSldTbXpQUGpHMndTMG1ZVkxSRmhR?=
 =?utf-8?B?WlVkRGFPeXgyTmFwak8zWEFuZHkxb2gwQXJDS3ljZnNqeWZNQ1lSSkpyNUli?=
 =?utf-8?B?ZDJmd2tXRmZTQmRwM2x1RnVGWlpNd0llSytpY2RhcnpuVVNta2dBdXhxQkR3?=
 =?utf-8?B?TXMrTmczR3I5Q1ZzWlBxTDZkR3ZKZ0J3K1Q1QllLb1Bva3Jpcm5yNDNWV2NW?=
 =?utf-8?B?ZXRsODNBMExWZ1pHclBVeWtVanZDZXdkZWNTKzJlamRFeGRUNHM4Nmtuc0Zm?=
 =?utf-8?B?bFNuUHI4MUNMdE5wWnMxWUNVRlZDN2R6cFp2RGZWMGVCL0czandsblZjcDlh?=
 =?utf-8?B?ZUxNc0NpMWNCSjc1b0l3SzRyb2I4WDIzK0ZLelBLdGdoNlVFYXltZm5PRGd6?=
 =?utf-8?B?UkNkTnArUjJhc2d6OCtkRERyemtWWTlYdlBUU2s4dWpLWXlqT0RacXBXVkNm?=
 =?utf-8?B?T3lIeWMvVTgvQ2hJK2lTQm9VaFJBV01kdEk4YTRkSWF2WWhBMGZ5QmFMWTMw?=
 =?utf-8?B?YXM3MHBPQ0VmL1BCK2ZxM3VzUjg2THlXbklPbXBiblZJai90UDR6d0RldWNN?=
 =?utf-8?B?RGpmdG9YZEhrSFJlOENibVhwSWU2STdTRXBKUzIwZ2RrTnppUldwOVB3cDZz?=
 =?utf-8?B?VCtxZ2UzQ1hxNmhRSVNIVVlMTDcvYS9uZ1hWZ3d0bGRiOU4wSDViUjV3ZW53?=
 =?utf-8?B?YUJDcFpkWnQwTnhBd0phRDZmZWxDYlR3WEwxM1pzcjVwdUkyQlFpYmhGMGNv?=
 =?utf-8?B?RlFCRURYaHdGVTlwTWszREVNTEcrSEkvRU9HWjRvOGpIbW8xbjBpUTFIZEN4?=
 =?utf-8?B?U2xSeDlpL0Jqbk5SR2JqSVBsYVYwQlhGYXlzM2R3UFVOTk53NVFJM0JScWJs?=
 =?utf-8?B?dUR3a09CMndYSWc1bE1xZkM2NUVDSXZUWnhpTnhncnF0MlJVZVZoQ2VmcUJX?=
 =?utf-8?B?SUVCZmR0bzc2Yk1NS05YNSthNk9hREUrbE1zMnd4czNuR09NWXlyTjB6aE52?=
 =?utf-8?B?elYvVmJtc3Q5dGF0dVdiNkkyNGFvQ3hiT25mdEsrdDZyNXAxcFNmNmhiWXNN?=
 =?utf-8?B?TjA4WDV6UC8yMXdHTmpDTFVReUY2a2NoYU5WR2xwaDJ5YkhhRzYvdWE3MVRh?=
 =?utf-8?B?VStEZ2lVSktmcW5hYVV2M0xjbmN6TWN4WTF0dksyM3dBZEFBYzUrTVhHWm5D?=
 =?utf-8?B?cmlabk5hcFZzSlBqcE5qb3JBdXdkUUhYeG84bkhNY3lkQXFxSUNGRU92QlVO?=
 =?utf-8?B?R2NmSVJTSlpEeURYcXdITERpeGc2Zk8vSTA2WXRhRTA2SDQyR3BvMG9EMzlW?=
 =?utf-8?B?NWx5WTVuOWltdXNaalZPTmxUTUZnNStvbkJIR2xaa1ZvemdQb05VRXlRQVh6?=
 =?utf-8?Q?xt4WbqoC3OPR8MjvxmVnP0ElKjnUpKBq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlpJQ2duSEREanZ1aDlzaU9XbWNRc1lmOU1Jd1hHenZ2ZkFUeWpoOEVZbGxK?=
 =?utf-8?B?N3pPMm0zTk9XUnUwUi9FYllVRW9EWXEyZmgvcXQyUS9VUjRKVXVpUWtySE9i?=
 =?utf-8?B?Zmw3bisvdzdUeWZaOSticVJGcEplSXRtdDZFOFJJbGJ5dDRibjF2dzd0TXR6?=
 =?utf-8?B?NWpySG1LTVJXdXg0NjFqZzYxbkQwckNQSmxqR1VtbWVFYlViazFERUpoejhQ?=
 =?utf-8?B?Q2FWZmVvQWk4TmdzaDVvUGpjUVh3Vm5RZkEvQzE2VWpidXJrUnBBUEZiVDdS?=
 =?utf-8?B?TVNHWHJhWi9zbU8yeTNCNjZ6UjdHSU5IOWdCR291Wm03eE1hU0xJa0VuMEdZ?=
 =?utf-8?B?OEhzakpQdXM1WjNISUJ1Vmgwc1FXMU9DRmdDUmFXMCtoRkNUVXdIb2tYVDA4?=
 =?utf-8?B?VndZb2dRZDlrT2xUQUlEMHVWeVI0OFFGeHY5YTBSRmxMWHB6elcxaTNUTjdh?=
 =?utf-8?B?dTkrLzM3UkwxVlMveGZCV0k0elpueGNjTUY2Y3lhOFhLRkpJQ2dvSHdXS1o3?=
 =?utf-8?B?UTBpTk85bHBsaHdmUk56cFVXaC9xbjhnaWlqVWJSMFQ5a0d4VDhsTjZkL2U5?=
 =?utf-8?B?cVZUUkxlVjByU09ZL1BId0RZajZjd2gvR2h1SHVDUitTK0hjZ3Fuck9oZkI3?=
 =?utf-8?B?L0ZMNTFUUUtmYnB3VktTdXdQaUlsVGZVbDFYWTQrYmJzODBiOStYTm1CdG03?=
 =?utf-8?B?S2QyOHRhMisxNU9zdVcvS3UzanJYcndML0w2cDMxbmlZWkRMOEZ2ZElPTG0v?=
 =?utf-8?B?YVYyQXVpcGs0SzJLU3NnaHhBTnVqWjkzT25TYXVtUFBVaG5SZksvM1ZZOFFR?=
 =?utf-8?B?emhaSzdDNVNhWGRKWkVOMTlxNWhDZGFiVncyV1EzdFBiV1VuRFh4aHI2QW5G?=
 =?utf-8?B?b3pSdXJITm9pYlprZ1YyUVhvbVNzcU1QTGdzRVgyNW1aazZmUVF2SjA4QWFl?=
 =?utf-8?B?WDN3QmpDOWdEZGpCNnVEc2RSMERNVVRoV012bGExdmt0RkkrdXVwZHhJWXg4?=
 =?utf-8?B?TXBXN3V2UUpFb2h2U3ZtbFBoN1NKd2F1YlJmbE9Ubkg2VDBSUk13Q28zVjV2?=
 =?utf-8?B?NEs3VVZGR3BEUlhhRTVZRVlMb0ZZVTNGd0NWRjJyU3U1RzVKdW1pZDFQVS9P?=
 =?utf-8?B?QW9hRmhoeXJ4RENYUVdmUEhRNnJqQU5NZHNHVEp1MCtZdlllS2IzNW1VMjRO?=
 =?utf-8?B?Y25jdk55UFlIM1JqU0FwazAxOTNsTUt3bjB2dzZhdE50WUJhSjJFWU16R3Jp?=
 =?utf-8?B?c1dUU1czelJNc2xLQXFxVFdxZ29iUVdpU0R0MXpLaHlQWXY4b1hHU25qVkQ3?=
 =?utf-8?B?aHMzN0U1dEJPODhHRjBiNzVCOXdGNEFWVWFXRTl0c1pqOTgxNGFMa2lzZWhr?=
 =?utf-8?B?dG1xZWtUZDhVYUxBK0p5ME11N0I3SEtYTHRPV0MvRnI3K1RDMmJkYTJDWWxu?=
 =?utf-8?B?NFdzd3BZTkgxSWdmRE9POXpQK2E0bTJsays3UUY2dUhHZ2kvcFJEUWtNWDhl?=
 =?utf-8?B?aEt5MnRIWGlwUGIvZ1ZxUm1JcFZrMk90aVJwOW9xQ2YxaC91YU4ydmttL2JK?=
 =?utf-8?B?TSt6eklMR093MmY0UVdNMkd1SGFRbURVajl4QlFUMk54bVVRcDdxMGttQ3BY?=
 =?utf-8?B?M3p2OU1DUzlnd0xDOEpHV3NTbVRxOUhBYi83RTZCb0xxQWJGbjZOSTBMNFlY?=
 =?utf-8?B?dnFmalpUNWlJQWRYQkNuaFJLbkNMdzZnM1k2T043dWNKUW56d29lRVBlMFAr?=
 =?utf-8?B?WHRqOGU1bjlBUEpxdExlTWRsR0hybmYxWmR3RlBBOE9XQ0tZNGp2cW5UTm81?=
 =?utf-8?B?MDJGbDQ3dUVjdC8rMEE1VVZ3Tnd6SU04K1ZIMWNNc05EYnk0eGVwNTRMQ1U4?=
 =?utf-8?B?VVdhZExnMnQ2b1ZqYk0yNStsaVNIaTJodUdGMDRNUmkvbXFnTjNCRE01OGI3?=
 =?utf-8?B?SENEaTg5QUthWElRbVlLbGdocnpsWUhrWTVzOFV0dTRXa1lWNWR4TTlGMFc2?=
 =?utf-8?B?dk84TFFoNzZGeHZaOTM3cGovcVFzSFBvL2VpQjJQamVlMTNlZ05nZWk4QStO?=
 =?utf-8?B?NjhIOUtzcmRpWGlGRU1VcFVIbDU2ak5peFNzOXcvR2VDY2JQWWpJK1FnL0tS?=
 =?utf-8?B?RjBOaFB1U1YzdG5VazhuOFd0ak9OSHpZcGdaTHhlQUg1T2ZwVW1IWWE2cExm?=
 =?utf-8?Q?9xSFCi/kRhjHbD+JMGwVAej3BMLVGFeaaO7IqHyF9/XH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fcbbd8-193f-4642-7757-08de3b936648
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:35:39.8003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96tzcPzwz3CFdUL8FCHiAt/fTAQbIm/EswFy/RQW9u8rDx081XnMfSERNd5eq46t2DRJuMnc02O1PXKKkz6g0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426

On Sat Dec 6, 2025 at 9:42 PM JST, Zhi Wang wrote:
> To support the maximum vGPUs on devices that support vGPU, a larger
> WPR2 heap size is required. On Ada with vGPU supported, the size should
> be set to at least 581MB.
>
> When vGPU support is enabled, reserve a large WPR2 heap size up to
> 581MB, set the max supported VF to max in WPR2 meta.

This patch also sets the number of partitions, this should be
mentioned in the commit log as well.

>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/gpu/nova-core/fb.rs       | 19 +++++++++++++++----
>  drivers/gpu/nova-core/gsp/boot.rs |  2 +-
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index 3c9cf151786c..9a5c40029f3a 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs
> @@ -119,7 +119,12 @@ pub(crate) struct FbLayout {
> =20
>  impl FbLayout {
>      /// Computes the FB layout for `chipset` required to run the `gsp_fw=
` GSP firmware.
> -    pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_fw: &GspFirmware=
) -> Result<Self> {
> +    pub(crate) fn new(
> +        chipset: Chipset,
> +        bar: &Bar0,
> +        gsp_fw: &GspFirmware,
> +        vgpu_support: bool,
> +    ) -> Result<Self> {
>          let hal =3D hal::fb_hal(chipset);
> =20
>          let fb =3D {
> @@ -181,8 +186,12 @@ pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_=
fw: &GspFirmware) -> Result<
> =20
>          let wpr2_heap =3D {
>              const WPR2_HEAP_DOWN_ALIGN: Alignment =3D Alignment::new::<S=
Z_1M>();
> -            let wpr2_heap_size =3D
> -                gsp::LibosParams::from_chipset(chipset).wpr_heap_size(ch=
ipset, fb.end);
> +            let wpr2_heap_size =3D if !vgpu_support {
> +                gsp::LibosParams::from_chipset(chipset).wpr_heap_size(ch=
ipset, fb.end)
> +            } else {
> +                581 * usize_as_u64(SZ_1M)

Do we have a constant defined somewhere in OpenRM for this 581 size? If
so, let's regenerate the bindings to add it and use it here.

> +            };
> +
>              let wpr2_heap_addr =3D (elf.start - wpr2_heap_size).align_do=
wn(WPR2_HEAP_DOWN_ALIGN);
> =20
>              wpr2_heap_addr..(elf.start).align_down(WPR2_HEAP_DOWN_ALIGN)
> @@ -202,6 +211,8 @@ pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_f=
w: &GspFirmware) -> Result<
>              wpr2.start - HEAP_SIZE..wpr2.start
>          };
> =20
> +        let vf_partition_count =3D if vgpu_support { 32 } else { 0 };

Same question for the `32` magic number here. I suspect this will evolve
with future chips, so we need to have a good source of truth so we can
abstract this when needed.


