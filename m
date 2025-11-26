Return-Path: <linux-pci+bounces-42119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD6C8A107
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 14:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11F2334935A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4E2EFD9F;
	Wed, 26 Nov 2025 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ApFKLEkQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E0F2F6578;
	Wed, 26 Nov 2025 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764164349; cv=fail; b=uIwOqBZj3IOfBpgxwG5v2pB7g7MJ9T812lLRFep69oGSTU19asp0HiH9HAHcHElJHKCmg6pPDJ6f/x/Q9CCk7u19USrEEih50FQliRGgzsaitNH+Bn704RfHkP7qCwA7cA/jCMVSNC0j8t3hPWYRYLeVqqlGdtXaNJqCLUJrWK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764164349; c=relaxed/simple;
	bh=S4mH7+zotP9SKpnKMyNqUxcPySb0nchKZwqvEnR6aqg=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=CXCaCjgWPyBZB9HZQqRaL7/U9MQn+qaYGbUgHtZ4xOHBgRdX5Z49CeC4IWohLrqlxw5xz/tj0IuzurDwHxCuUHjm0YTgBhKnX8yOOXWhhjKtV89Zxk0g0cGj1nRnDDJ9NkfWL7vam0IOTDt+hAfvhwJUR20X4C0HkPzEyb/hXrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ApFKLEkQ; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOKE01SasJE4oiit+1ZEQi8EarPKXaU5/P9NiEQH24N8KFhoFZ3wJwBopO2gTb7lumPZWgbHYUzIs1zI6RH8R4VO/W60KZ53XBwOKi8IpH62II28pmgAiYfB4Q1eVOn+XDK6DzQbhGVN2JFpbgUeUTu794/g7lJEjT5DVvHqO/LAhZrhXlZpGsIR4QRQtBL27YSEuoWWt0E8xl/5bTzGwXlKZTMoFjUCFt/LPZoFA7CDbWwC5Y8xw9B16M7hk3ge3E8zEmUsKaepnLeWhM7cgKUICjuPyJsO16GmzmrEaUAlzq2MbinYZ/Q0Gw5ADdf8XjtzJ4o8NOTnB7r3IWiyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+Kl7Xqo/RRTK/u6704vwwR9MPw7aqAja4ux0jw+Jys=;
 b=cX2HO6MwFmxscTmLnV6vicAdSzH0wbnwKOqV/08vzZgwwezRk2o/GgMBeJk/KULw+5JTcIDxN2TQw+wpCebx8paimJCz3ree5WMh24Q8SLEOmXancNquRMpXP9CzmKbqrIZH4tE+A9emSUsTKCPmW+f7USm0LQr9IPEXpuMASuvG4B2xkchEBOjv2amapQUA4TGHr8KbzLUnsBXdvrTak3L1VG4pPpdx/XnOUkgclVdqU3Jt9kavgtFZzcSJL4pP7OPi8ZGpJ0Q6/rz+Z3lO9FZYGPLSizatWRIvfgGo/4ml9534ozRH/kpOMc6Ik4uCiAG2WCr7J0pG3jB1s/mDoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+Kl7Xqo/RRTK/u6704vwwR9MPw7aqAja4ux0jw+Jys=;
 b=ApFKLEkQ5awnmdb7q50iaqTHfCJfSdpYAeRcCG0qovTaHqy3A6bmg+OjvjDY3fJ1JSzQ/F+HhBbSrLwiA/jRhh09F34WdAUysAhbbN0+zq9m6sll5DiYChawFWPurc4EeAOR9L+rcep4+jjGgJ1kxR786YShVAnWBcm7TfxqFSF2Ct0+il45oL/A3tEqPos8iUeydZMCl8NrcvKv8bD6FOl8Dplnc2sKL3Yb8Ss3+hn+270b7QSbbmw+FwPYKcO0/uQOCGc56kTAUqceOLHRrB5wnFABmpgTCfH7aW2v7ZwUk3AhgN8OX//64+YeDIf+/uY66COEcHCRII4c4EjWZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 13:39:04 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 13:39:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Nov 2025 22:39:01 +0900
Message-Id: <DEIO2E3R5L3T.2WKZP2C0TZQDY@nvidia.com>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io
 trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119112117.116979-1-zhiw@nvidia.com>
 <20251119112117.116979-4-zhiw@nvidia.com> <aSB1Hcqr6W7EEjjK@google.com>
 <DEHTK1CK84WO.28LTX338E4PXQ@nvidia.com> <aSXD-I8bYUA-72vi@google.com>
 <DEIGORHCX5VR.2EIPZECA0XGVH@nvidia.com> <aSbNddXgvv5AXqkU@google.com>
 <DEIO1A8N2C66.11BXTCZW4MKWZ@nvidia.com>
In-Reply-To: <DEIO1A8N2C66.11BXTCZW4MKWZ@nvidia.com>
X-ClientProxiedBy: TYCP301CA0067.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: a2998c8a-deff-4e1f-fe90-08de2cf12a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0VYdThObi9vZ2hnT1dkVDUyYXoxclVralNJNHF1REFKTSswNVlHeUQydGJr?=
 =?utf-8?B?NFpMd1hTd29GbXJmMzlJMjk4MWM0cTRKWmlTRWI4ajVIcUxaclFpK2J2YXd6?=
 =?utf-8?B?V0EwV0Irc0JXUWkwOHpYZ1JvNHEwRU83bysyQ0lVUEI4RlJIeWJydmVLZUc5?=
 =?utf-8?B?NGxneWc0eHFTZVNBaTBmUmhmbTh1SlN3T2ttRSswdWdSSU1ac2s2SHg3YXFo?=
 =?utf-8?B?Z2ZUcDM1SFV0R0dsM1QxeUNpMjZDN3lzTE1EK1NUNE8zL1VIWkJTeWVacU1C?=
 =?utf-8?B?YkxMem1Jd2M2OVVIR3FSdHkwWmo3QUJvV2dsczhON2ovNUdwSW5oaUdkQ3RV?=
 =?utf-8?B?TWIxR2lwUkdmRUZiUTdYZHpRaUV4Wm11blBNcVQ1d3NzSGtKQlpGZWZBMFZC?=
 =?utf-8?B?L0NseUozeTBmQ0tmRFUzOEVobCtLekZFS2U4dmphR0I3a20wMUZvQ0Z6VUZz?=
 =?utf-8?B?ODRBY3I2bDBzMVFkMjlRYURXaStQT0lONFhPb29JbEZMS24xb0Fpa1dMT3A3?=
 =?utf-8?B?TVFnQm9JQ3pGS3RqOHVaTTBsSDErRmY3UWhKYjBnWTcxeGJnQmVPVkdYWVJr?=
 =?utf-8?B?bWdMQnMvWEdHZ08wZnJsM0xLVGNscTliamR6UVJFTDgxUU04N2xXRHIvaXli?=
 =?utf-8?B?UlF4Z1NSOHhubWJTTnVDcTR3ZnZSd2hIMk5wVTNFRW9BYVFXbmVZa2RhZWJX?=
 =?utf-8?B?d1FVOEZhMkxQL1g5ZHJiV3hjODZoWjlpeHh3aFNibmdaeGpOMjFiMitxeCth?=
 =?utf-8?B?R1pRWkpmdUdYWjRsUE12eDNNU0Z0UnR1UDJBTGpNc3NTQWlwYnQrdDk3aVo4?=
 =?utf-8?B?NXd2NEdtTGF0RlFETlFxTktSWjJuMUlybDBVc1pwelNkbXVlM3BDN3ZXakJC?=
 =?utf-8?B?QW1qd29NMTR6d2lvaGVKczVxWUlmQlhpNjg0dUExZk9UYVFWcUowUklNcDJH?=
 =?utf-8?B?NlNlSFhHUjQ4cjViSUZIR1l5Q1ljT2tmcHNaM0dRbTZlTk9KdWIybW5FdVl6?=
 =?utf-8?B?SXlZQzFLN0g4alJYOWdxTk9VRmVyNmlwaVAxRkhXcTBDc3RCUThUVHpUdFBl?=
 =?utf-8?B?bnNwR0x5eEd2VFhnUUlvYlBzeHZkZTVnT1lyU0REcVVLYyt2YXpMNHduYzM3?=
 =?utf-8?B?UXJQT0JJUlFqZFJnZFc5MEo3REpNc2VZd1dNUjBDMTNHZDE0dlJSNmpLMllw?=
 =?utf-8?B?WGRwN0pVaVppOTQ5WkRTODhZWnkvSjFDeCt1ZER5TkVjdEhjOEg4aEZKOGly?=
 =?utf-8?B?S08yRDNmV2pOQnZhR0RsaG1VUGxQZUw1S1JrY1hsRkk3b2pORTk1ekZzSW1M?=
 =?utf-8?B?OTlQcGo5TkpNZndxdXFySnlzUU56UGpKTGhVeVRNa0ZHUEdSek5SU2I2N0dl?=
 =?utf-8?B?M1BGdW56ZlhwbWRNQnlwbFZnQW16T0FCM3JNL1lKbTJsbFVRMWl3Nld3Wm5G?=
 =?utf-8?B?djNZRUZZTFZ5UkNCN3MweCtVSzJrL205R0dOZ3RRM2xjOXI2ZHE5N2dCNmx4?=
 =?utf-8?B?MEtCdm0rNjRIak1BbW91UmpSWGNNS2Y4S1FERzBPU0gwZTdwQlpta1BYOGdH?=
 =?utf-8?B?dlJzTVBDd0UzamdHWVNMTWxwWWtHM05ha3lSTW4zWVo0VlZrallYdXhKQk9B?=
 =?utf-8?B?T1F1SG93UXNKd2xHSjlEN2ZCNU1neGZ0MHNPdEhrZTB1c1VVRmc4YTFtaGpW?=
 =?utf-8?B?Q0lYNkZlbDd1K3VmLzQybjZEZUxMZk1RZ1VxaE51ZkhBYkpGOFBmQllyVElq?=
 =?utf-8?B?amNKRXlmTmtERGRhb0ZXcVB5WC9iczA4ZFEzYTBrVkUzOTk1SEFvNDM3aFUy?=
 =?utf-8?B?cXpJdHpKbVoyRjNudm96L0FQTTFSY0pyRFNTOEY4SjBCeDRaRzV1ZDErT0JN?=
 =?utf-8?B?Yk90VktVMXVYekVsL3J1SjAxY0hWdmJRUUlCNlJINjhnQkpKTnh6Vk1zWFll?=
 =?utf-8?B?MExoa2gxSkUxbFFIVEpaQzdxMHBIV0JxUzdnQ2JYVmoxYThvQjFvV1Fwd0pL?=
 =?utf-8?B?Z0xCeFVVelZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEY4TlVnc3E3eWM4bHJxckxrU29raGk2MVFWSThCWjl5QndQZjNGblRFSE5k?=
 =?utf-8?B?Rkg3bHRhSWdTbjc5ZFdoVjJIb2ZuWlNnN0t5TERVeEltckR1bzREcFlNWE04?=
 =?utf-8?B?K3VxWGsydTJ1YzY2d3FsanZJV2lkaUNUdmtxd1FMT256WW8yd2wyUlZxODFE?=
 =?utf-8?B?SWdFWk85VVRiQ1NhQlp3RHFlWkltL2djcThKOU0xQWxtYjRjcjErSXZ2RjAy?=
 =?utf-8?B?emcwbXFWL0tpU1lFK1VoSFNDYy8xSy9nVGo0ZW1WUUlhZG9rcFdWQjZaODgr?=
 =?utf-8?B?a3ZweUF6TjJ3UnFHMll6dlNONm0waUxvS3NlOUpKR080ZGJ3TjAyUDZJdS9M?=
 =?utf-8?B?V0hWeWlNbC9hdE9JMWFZTG42M2hFYWY1djNxMy9WUUZ5c0R2RnlpZ1J6THdH?=
 =?utf-8?B?YVBibk1nODh2Ry9HMFRRN0N2OU8vV2c4NHA1N2VoWFczMEhSMDJnT3JNTzUy?=
 =?utf-8?B?ODN6NThpVWtvZ1pHTGJLSFZmb3VoaUhRTTJJWlZ0b2FkWVhhN2RmbldMREIy?=
 =?utf-8?B?UGhqMjgrZUM0c3kwMDd3cWtEOW01REFlL3NwcFJIenRpcUZIQy9wM1Ewamli?=
 =?utf-8?B?b05ZVHN1d3lCZ0FNeUllTktmQ0l1NmhkMkdUWmZBSDgvQWdEaGFFVE9VTEw5?=
 =?utf-8?B?cGpuQjc2eUNCa3NZZndaZ2R0ODlEL1NzNUVCbGFxY0pqRzloTHBQUm0rN2py?=
 =?utf-8?B?WkFUanRxL2dyempITkFlWjNVdkQwdncvVFZxVHY3cUl1Y2NndStTQ1FMWkxE?=
 =?utf-8?B?YlNrWlRzMllTQTlGenZNZDFNRmZPMnZoMkM5eFV5bzlTYm1yT1BsdjBZRGNU?=
 =?utf-8?B?SnJYbjYzZTloSEhwL01HQlI1azRYZ1ZBeDJWa0NndDhvMmlzNEhjOXJUN1Nw?=
 =?utf-8?B?ekdkeGRKRHFJcjJpR2FvUHFaR2hHdjdqekZ6d21HY3pjWGtzRHRlVmVtK3du?=
 =?utf-8?B?Mm9acHVnNWNYenBERzdIa3VrZnRBam14U3k4STRTMFJDUzN6K2w3RjVYeWw2?=
 =?utf-8?B?RVNhTW4vUU4yaHpOVHRxK0g4SDFFS21TUHJCME9UbStUWng2Z09TVU0xdEJj?=
 =?utf-8?B?MkZwNXoza213a1RlczI5Wk9qeVNVTHpsMmpVZzhheWZPcGt1YmVaeGlBSVg2?=
 =?utf-8?B?U0puQjMxQjNucXVETkJUQW5pcFgyOFFNd2plWFdIWHoyVWFCZHp2NzV3WWpy?=
 =?utf-8?B?WGhDUWN2SUNWZ09wOHRUY1plVGh0VmVmQVh4ZXhqWGExMnVmZFNEaWNPaC9Z?=
 =?utf-8?B?VnFEZFVxSDFqVTAwYUxHTjJjMWVKbUJxVWZ3T0dxamhDTEJoTS93Qm5HU1hQ?=
 =?utf-8?B?UDdmL09tY1F5dXRjRlpSUFhoaVljd3h1VldaeXhrb2dlZStXMGY2QTJvMWVQ?=
 =?utf-8?B?TzNoempubURkRXV0RWVDUkRnN1ZTVUFta2twcy9XS1JRa2R0Mmx3QlQyVzM4?=
 =?utf-8?B?aDh0SHhHZlRGcXRmeWtmTEpQNDVRTHkxRGNvTk5lU290YUN4Q0lEbTM5alVM?=
 =?utf-8?B?L1NtZ0VMTGNJb1JoQUlPSkNSKzR5eDRYVU5zU1FjUndZWmpQRU5LeW9pVU9J?=
 =?utf-8?B?bXdFb0FlWVJVWmdVeW9PM01mTzg4OE1hcGV4U002MDVIQlNpaG5LeVoyK3JU?=
 =?utf-8?B?WGJ3WmRvUEh3Vk5yWU1lcnlONXB2UnNoMVgxS0p2V0pnUVBvUnRWSGh2OG9s?=
 =?utf-8?B?Yy9hWWJvZHp5OVE3dk9zK0NPTHdoMkdOeW5TT0JjMG82dVRJNUVNWUR6dVlo?=
 =?utf-8?B?ZWVUcmtqOVFNWllxMEF5QmlacGh0akxUY2tUcFJaRnhzZ2FMRWt6QjV6UXdn?=
 =?utf-8?B?bFk1Z3JmRzdhSzFiZmRlMmx6Mm9PTGptYXl3RXN3RG1ieVQyWW8zQnRieS92?=
 =?utf-8?B?ZHVNVzJoemZPcG1DbHR1NVdaWFlYb3gwNHZDbDFEVDRkZGdRTW1KUHBiSEE2?=
 =?utf-8?B?dHUvU3paQU83QU81N211d2doOU9GcW1lbGdLR1lEdVhZYnBtMkFsTnhGSHdk?=
 =?utf-8?B?Sm9JU1JQTFgzN1RRcDZESVBYZW5LMVhHcDFYQUFxSFNZT1Ntd3gvWDVDVkNp?=
 =?utf-8?B?aytubFF0aDN0SDNjRmhMVXZIZEhOK0FTQjBJL1JoNG5yZktKZU5GeXFFZXBY?=
 =?utf-8?B?N1RUa0lwVjNIakt3SHlFd0d4ODEzOWVMSFBsOVZhSk1ZOFcwSHdBaWpqS0dT?=
 =?utf-8?Q?LgAP4Skkc0ciQr+7CX9KPXn01x2k72iecyn4ySw7ebzc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2998c8a-deff-4e1f-fe90-08de2cf12a99
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:39:04.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y97KfCahY2es0WG30KwR0QgGqPQAgSmpvv/6Bt/XF7ljh7WT5Q7Fckcpte6dNErRO/BojQpKHQr9YcY6vb1I+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521

On Wed Nov 26, 2025 at 10:37 PM JST, Alexandre Courbot wrote:
> On Wed Nov 26, 2025 at 6:50 PM JST, Alice Ryhl wrote:
>> On Wed, Nov 26, 2025 at 04:52:05PM +0900, Alexandre Courbot wrote:
>>> On Tue Nov 25, 2025 at 11:58 PM JST, Alice Ryhl wrote:
>>> > On Tue, Nov 25, 2025 at 10:44:29PM +0900, Alexandre Courbot wrote:
>>> >> On Fri Nov 21, 2025 at 11:20 PM JST, Alice Ryhl wrote:
>>> >> > On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
>>> >> >> The previous Io<SIZE> type combined both the generic I/O access h=
elpers
>>> >> >> and MMIO implementation details in a single struct.
>>> >> >>=20
>>> >> >> To establish a cleaner layering between the I/O interface and its=
 concrete
>>> >> >> backends, paving the way for supporting additional I/O mechanisms=
 in the
>>> >> >> future, Io<SIZE> need to be factored.
>>> >> >>=20
>>> >> >> Factor the common helpers into new {Io, Io64} traits, and move th=
e
>>> >> >> MMIO-specific logic into a dedicated Mmio<SIZE> type implementing=
 that
>>> >> >> trait. Rename the IoRaw to MmioRaw and update the bus MMIO implem=
entations
>>> >> >> to use MmioRaw.
>>> >> >>=20
>>> >> >> No functional change intended.
>>> >> >>=20
>>> >> >> Cc: Alexandre Courbot <acourbot@nvidia.com>
>>> >> >> Cc: Alice Ryhl <aliceryhl@google.com>
>>> >> >> Cc: Bjorn Helgaas <helgaas@kernel.org>
>>> >> >> Cc: Danilo Krummrich <dakr@kernel.org>
>>> >> >> Cc: John Hubbard <jhubbard@nvidia.com>
>>> >> >> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>>> >> >
>>> >> > I said this on a previous version, but I still don't buy the split
>>> >> > into IoFallible and IoInfallible.
>>> >> >
>>> >> > For one, we're never going to have a method that can accept any Io=
 - we
>>> >> > will always want to accept either IoInfallible or IoFallible, so t=
he
>>> >> > base Io trait serves no purpose.
>>> >> >
>>> >> > For another, the docs explain that the distinction between them is
>>> >> > whether the bounds check is done at compile-time or runtime. That =
is not
>>> >> > the kind of capability one normally uses different traits to disti=
nguish
>>> >> > between. It makes sense to have additional traits to distinguish
>>> >> > between e.g.:
>>> >> >
>>> >> > * Whether IO ops can fail for reasons *other* than bounds checks.
>>> >> > * Whether 64-bit IO ops are possible.
>>> >> >
>>> >> > Well ... I guess one could distinguish between whether it's possib=
le to
>>> >> > check bounds at compile-time at all. But if you can check them at
>>> >> > compile-time, it should always be possible to check at runtime too=
, so
>>> >> > one should be a sub-trait of the other if you want to distinguish
>>> >> > them. (And then a trait name of KnownSizeIo would be more idiomati=
c.)
>>> >> >
>>> >> > And I'm not really convinced that the current compile-time checked
>>> >> > traits are a good idea at all. See:
>>> >> > https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.com/
>>> >> >
>>> >> > If we want to have a compile-time checked trait, then the idiomati=
c way
>>> >> > to do that in Rust would be to have a new integer type that's guar=
anteed
>>> >> > to only contain integers <=3D the size. For example, the Bounded i=
nteger
>>> >> > being added elsewhere.
>>> >>=20
>>> >> Would that be so different from using an associated const value thou=
gh?
>>> >> IIUC the bounded integer type would play the same role, only slightl=
y
>>> >> differently - by that I mean that if the offset is expressed by an
>>> >> expression that is not const (such as an indexed access), then the
>>> >> bounded integer still needs to rely on `build_assert` to be built.
>>> >
>>> > I mean something like this:
>>> >
>>> > trait Io {
>>> >     const SIZE: usize;
>>> >     fn write(&mut self, i: Bounded<Self::SIZE>);
>>> > }
>>>=20
>>> I have experimented a bit with this idea, and unfortunately expressing
>>> `Bounded<Self::SIZE>` requires the generic_const_exprs feature and is
>>> not doable as of today.
>>>=20
>>> Bounding an integer with an upper/lower bound also proves to be more
>>> demanding than the current `Bounded` design. For the `MIN` and `MAX`
>>> constants must be of the same type as the wrapped `T` type, which again
>>> makes rustc unhappy ("the type of const parameters must not depend on
>>> other generic parameters"). A workaround would be to use a macro to
>>> define individual types for each integer type we want to support - or t=
o
>>> just limit this to `usize`.
>>>=20
>>> But the requirement for generic_const_exprs makes this a non-starter I'=
m
>>> afraid. :/
>>
>> Can you try this?
>>
>> trait Io {
>>     type IdxInt: Int;
>>     fn write(&mut self, i: Self::IdxInt);
>> }
>>
>> then implementers would write:
>>
>> impl Io for MyIo {
>>     type IdxInt =3D Bounded<17>;
>> }
>>
>> instead of:
>> impl Io for MyIo {
>>     const SIZE =3D 17;
>> }
>
> The following builds (using the existing `Bounded` type for
> demonstration purposes):
>
>     trait Io {
>         // Type containing an index guaranteed to be valid for this IO.
>         type IdxInt: Into<usize>;
>
>         fn write(&mut self, i: Self::IdxInt);
>     }
>
>     struct FooIo;
>
>     impl Io for FooIo {
>         type IdxInt =3D Bounded<usize, 8>;
>
>         fn write(&mut self, i: Self::IdxInt) {
>             let idx: usize =3D i.into();
>
>             // Now do the IO knowing that `idx` is a valid index.
>         }
>     }
>
> That looks promising, and I like how we can effectively use a wider set
> of index types - even, say, a `u16` if a particular I/O happens to have
> a guaranteed size of 65536!
>
> I suspect it also changes how we would design the Io interfaces, but I
> am not sure how yet. Maybe `IoKnownSize` being built on top of `Io`, and
> either unwrapping the result of its fallible methods or using some
> `unchecked` accessors?

That last sentence was ambiguous - for it to make sense, please rename
`Io` to `IoKnownSize` in the code sample above.

