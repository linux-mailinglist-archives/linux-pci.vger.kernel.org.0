Return-Path: <linux-pci+bounces-25341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A702A7CE44
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 15:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8573188EADB
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75A51957FC;
	Sun,  6 Apr 2025 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pj/VN1Cl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D252E62BD;
	Sun,  6 Apr 2025 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743947902; cv=fail; b=Pnp8XWY4GMJuFR1D2gfz4UjIMqYEqyT3buUqDWBYW6DFoFWSbUqGEMT7IdeRgiETMXWR3PFB/5TgcamfDZHpcFL8Q9zWZK9LmzA4sGsKDP81jAl5IH+iU33/tYLpqwb703SWbYx7RMRsfaSToRElZAAQ1Ba7+VuAg2K1ePvZMxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743947902; c=relaxed/simple;
	bh=UWIbdFuQi3vmp73f9NhorIVHLYVS33jxFe17CidCTaI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=aP7ZgERG+Xjr+koUjpsZ8mZXqQ0oVSA0tOy9EcvwpX7hvEpZ02alIWuzDmpNAnfQqJs6fRy2dLjRKB5iuK/LMumg/SwRAgZeKcQWnq8/9RyWIZkD9wIj2QrigiIvxWDeMtDLdx2m0tSHn0sOLtDYK0ZN7iaCZjszr/nnl98vWms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pj/VN1Cl; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsXuceXUR9I/RalduavNkTWyNlBDrt9T1V9immzBIfrnrNxVLP3ckIzBtB2Wj3Vcp9gZHgFr8a/zlyb2jU+IxomXxmLy+Xj4p1MOaa8wvlU2vdB7nJeOJ27bsyp+ZMjGA9aEOE81fqbY1h0tMOIaMvogwoqKPVBFr8wunlV+LBngnbqwN53wSj1tEIIRas1MaBFrag4WubVKeAlRfy9ardqd6PHbGGykbniQvtKgO+2dDGLutuMBJpWD7PHNBC+NW40AqUmIFGHGh4rfbad2WMMC/fX9/xd1+a/KRncGDtoGdLLfskhwb6Z9gu6oACVWly/YahkRytrmiTmA6nAUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vlNAMg1m+8oKaaYsccSZ5Ew8OHMJUYKa/PclL1zvsY=;
 b=K6EchPDuCqP8REvKJ/QDHQncSBuZQCKO04pK7nBxdoKC+uPqKTTlTymRoso8GKCciUSzzNogEzRnU0B3SHQyvk0aTtLdkY6pd+jNAqi701D2zKT7kVcHJzQTZ7yHhHsUk1/RzUESqQr6uP4gyjtKTwf15zDQoJlp5B7okjZ4DSdlaqPRG62Hiyaw9XitJ4IMi7mQbi2lBqSXF2fyuotgZvX+wT0PNMCokcabyR0oWB2P04t0dwL1pHXVAySYdwFah8qefPh+Y/U11k8LqiUT60mHzABz2E6mUBW30dw+9ux8qOvUE8m59e7JMITYlaV9nYouEZL/fHhEElEdnji6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vlNAMg1m+8oKaaYsccSZ5Ew8OHMJUYKa/PclL1zvsY=;
 b=pj/VN1ClU+uKmZRjaSO9+We9On9PDeJLtLx+3VbdZHXugffRjX/updbf9wJYqvjK7qIp4uK2xgHEqLj5PEBGpbFy+upq1rov9MIPtHLscrNBvkEICccnE+6DowZT9uLtWA4CH0+fCBXxfoa9ff6+OyMgZjWA18I2S+UHu9FDa1df2s9Fk0uzBRijs/ZUf9wfT+AuJExg/kK+tLo43vKZaNKBa6EgaL9Xoapyx4/TLXJJaaCxfEnEEtTOlyUd1kTsi54R2fowivv0ucEMl6jB/izWQgNessTROJNVHO99DCOj7Zuvte23KYpQnY/MSp97n2SXj2FvO0sU37O4yhu0uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Sun, 6 Apr
 2025 13:58:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8606.029; Sun, 6 Apr 2025
 13:58:18 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v3 0/2] rust/revocable: add try_access_with() convenience
 method
Date: Sun, 06 Apr 2025 22:58:14 +0900
Message-Id: <20250406-try_with-v3-0-c0947842e768@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHaI8mcC/3WNQQ7CIBBFr2JYixkgreDKexhj6AB2FrYGGrRpe
 ndpVzXR5ZvMe39iyUfyiZ12E4s+U6K+K6D2O4at7e6ekyvMJMgKlFB8iOPtRUPLEU0wwjnV1MD
 K+zP6QO81dbkWbikNfRzXchbL9UckCy54ZQJoixpAuHOXyZE9YP9Yon8M69D6o3dGW7M1lt0st
 1tmY0oOXEvpsVYIVWi+zHmeP/v8LpsNAQAA
X-Change-ID: 20250313-try_with-cc9f91dd3b60
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Danilo Krummrich <dakr@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TYCP286CA0286.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b8963c-4975-4c4e-40c4-08dd75131542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDRBcnc2YWtkVTUyeDhFZENiWjJ4Qk0vKzhqMkpVOGdqU1BmWTVIVllXY21m?=
 =?utf-8?B?S3YrWGNydndQWVZGUjBWbG43T3lYY3VpU00rVGNWT3dPZ21OYUdyUnJHYllS?=
 =?utf-8?B?VzVnR2kwQmM5blFSRmpDOHZwWmVEbzlHeUdOWUkxUzYzck9Gcko0KzBQUXEx?=
 =?utf-8?B?cjJjWWluQmdpWmU2Z1NLRjd3TDdjZ0Ywc0xPQ3ZodFRMTU1ESlovUkpCUW40?=
 =?utf-8?B?ZmxEUDVNUWp3TXhmbU1GZStjbWNnZ3UzcG1WWDQrWHp2MGh5Tm9VWkFQZU5X?=
 =?utf-8?B?QklHeGJPYmFrVWxtdUd0WE1TOWk0Tm4vWWd4ZHdUWXBQNVgrVHIyMkNnejlQ?=
 =?utf-8?B?Zk9OVjRWZjJtUXlEYmU0dlluYmVFZm5EbUxHRXRkVk0vTVBPb3UwS3lmMDN3?=
 =?utf-8?B?blYwNzNtMVNUQW4yQVZKYzVxZVlXaUZkUmkwTVluVjZ1ZkhxMzFEN21WRkw4?=
 =?utf-8?B?QkJFUkcrblBYeEdVamNWRkl1MFEvZHhHQnUzMkhFK1Qrd0E2K096RTRwYm9i?=
 =?utf-8?B?QXZ6b0ZqUlN3aWRmYUovOGQ3eCtKTXV3cjRHWXBFVVhRTnFodTVCbnhaKzMw?=
 =?utf-8?B?RkQ2MDJKcURXdXZ3VlM5U29RREJsZGFBNlJNdXJmMEZMT0tUWjdacklGQ2pW?=
 =?utf-8?B?eG05VWFvMTQyN0I2MFRjWklEc3Jpc2RDUFJ5ekVTM2YrM3VoUFk1YkJzbHU4?=
 =?utf-8?B?cVRWcXBrNjk1YUFUM3p1REtsNVlNejN4aFB4alVqV0JuVnpaSmFSMGl6UkRG?=
 =?utf-8?B?NXY3SFVYR0dWYVNIcmU4OWpQUlB4bWZwSW1MM2FXUDIrYUg3YnlvRWZQQTJ6?=
 =?utf-8?B?aWVlWEpGZE1FZmtJSnpxc0VKUndRbTBLVjRGOGhFMFE3cXNOMkwrUDIvdTd2?=
 =?utf-8?B?WVcremtrZFF2SEVDQmxpV21nbENIYmlwNENIbC9FNkhGaDJ0WVQzYmNEbEc0?=
 =?utf-8?B?NVI0ZTh6ZVgwL0VyR0MvZzEzVXF5OHhXRVpOakp1RDJ1ZE0raGYvSDB1Nllw?=
 =?utf-8?B?NEh5MHQzeUdqQ2t4T1BkVnljY2hKS3FaKzV0RjlqMmQxNXdOVHRXK09GYlBE?=
 =?utf-8?B?b0pScDdlbCt5cVVJek9oUXM5cWd1YzBuQkhOa0pHTDVQNHdGMHdJTE5zTmxY?=
 =?utf-8?B?V1BlYnpLaXp4cXBqZnVKS3R5K1Flb3VnMzhkMWdIRGVDcjl4SWRsUEVKRWVL?=
 =?utf-8?B?bWhwK0lpLzdDQ05BTUttWHFlWVBqSHBFUmJDaVM3bHh3dzk2em9zTTkvc1Zq?=
 =?utf-8?B?VDdiMDlNNUhpaXpZQVI3N1V6SDRUc3U4eTE3Q2RJZjVsWGNnUTRLZ1BEczFJ?=
 =?utf-8?B?Um1TTmxsay93N1ovTDIyNzR1NW01SElJYjE2Y2tpVGowVkRadmJET1llSFln?=
 =?utf-8?B?RktYSjd0RTZPT0I1Z2lQYnlvd0NQRm1ZaHE5Zmt1U1pWWTQ1NStyeU1JeXhJ?=
 =?utf-8?B?WFlRSjc0bW95OFA0NjltYXdSQ3o3NGYvaWZzOG5Tbm5oT3EvRjY2VHZaakFY?=
 =?utf-8?B?cDNGdk1IRTdEd1NpcVNjWHVzQ3NBNXZISWw1Ym11aXhpbUovZWNOaEV3dzJ3?=
 =?utf-8?B?Q2F2VldmQVc3RDkxZkw5czRvNVBuenJPVThlRE8wSVhmSTVZVVd3anhOLzBQ?=
 =?utf-8?B?dVdBT2RlUEhzNXQ1WnRSQ0YwN1A3V1BQV1I4YVRHOEdxUTI3eTMrVGkzWmVZ?=
 =?utf-8?B?bnYvTkNCdVlsUjJxd3NyYW1pbG1kYzhvNjgwOHhOaEVnNTVhcWVTTUtsUDJa?=
 =?utf-8?B?VGlrSkc4cDQ1MFFrdTd2RTM4QTZpa01kZW5EK3NMWlMrRnlLa1o4UHBPZ0Ni?=
 =?utf-8?B?ckE2ME9FZDFadEFIUFYwTDY3V1E1RlhMNVlMMG1WZHVRY1RiMVduM1R0cnlM?=
 =?utf-8?B?Um1vWWtwM1RwYXVhbzlWWGZkRldWUlRRMUdxYXJYRWdBb0xvZzZUbC8vbHFx?=
 =?utf-8?Q?f5GVsSXaUhU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm94MEN2YlM0a25odWlPeVVTdHlJM3N4ZU9VeC96ZUNnd204MXNVdEUzUjlK?=
 =?utf-8?B?WmVtTGt1cGJBdkg4eU5qRDFrNjZyZEhMdjJDeGxEdWxPZy91dlpURzlRU3hQ?=
 =?utf-8?B?RTBqaitIV2ErYnkxaCs5MGdkK3JJN0ExcldRMHBkQWsyWjAvNVJZdXgzeDA5?=
 =?utf-8?B?emNkTWcxSXRZY2l3ZDhpcHhTb0dmSXpRZ2ZjQnd6M3lrYWw3UUlhVGFCOWdr?=
 =?utf-8?B?V2JURExyeW5keFA2SnR0VzAwMmNNRmVrbjlqdnlIRGtYYlg5VWt0Y2Z1Zy90?=
 =?utf-8?B?MUtEYXIwblZNS01jalNYeGZuL2NvOVgzdnlYOXRMcCtUaTJNVVpQL2s5OHpJ?=
 =?utf-8?B?TTBreFpqRnJEVUp1NGl2amoxMkF0S1FrVXJxUDNUcFZ2WU9hNmtuN04rRjBC?=
 =?utf-8?B?V2FwNjhVUEk1anhKdDNsUk5pcVlWbWtVbENiQ25zYmJ6OWFSb3NzeXhDSkpi?=
 =?utf-8?B?USt3Z0t6aTJwRE9SRXFidWovZWdFaTJyaXNMZ2w2bko2MkdCRmpqYmhLaWw1?=
 =?utf-8?B?bU5WbE5Ta2llaDNpRWJkWCtwei9YRW4vbHE1cTFScjRJb3dUSCtkOExXTW9Y?=
 =?utf-8?B?Ukk1U2p2Q1o4SlliRzh5cEdSMHhla1o2aUVPOGlYRlhOd0Z4RDdSdUYxMlV3?=
 =?utf-8?B?Sml5VVFOLzJwL3ZWZnptWEZoZFVsOU1OcE02U3FkcFluMStjMlRaeUtjT0RO?=
 =?utf-8?B?YXF3Y1FibDdVUjdiR0JkTlJjMHhuTFlHNzFJMmJlWG54U1U5QXM0alg5YkhK?=
 =?utf-8?B?WDZEcFd6MEt6VHNEQllhZmtFUk54VHFETjB5SFZsL3MxOUxQMGptTDIwVVZs?=
 =?utf-8?B?dVhic2t0ekVKaGlEeUVNTWdmdlFyM28xVE9JekVtWmhhTEtVaE1Mdm0xUjhp?=
 =?utf-8?B?ZTZSaTFOV2RNSkFPVXpmeTVaa0w3M2w0ZjVlbnVEcUt2dzVka2NvOEc0d2dK?=
 =?utf-8?B?UEhmS1g3NDl2TW1FcDVQK0R5RVB4M1FMOWtPeG8xcnJEYXlTMjZlaUxRZzlU?=
 =?utf-8?B?eHJGemxVekNSWmM5RlBHNTZiNXJoMzIyeTZvcHNMTHltMHppRGdsQ2ZzRHVQ?=
 =?utf-8?B?dnRSNXljVEVPT245amp2R2c4U0hod3FrWXN1cW5IeVlNcXkrZVR2YkgxOHk2?=
 =?utf-8?B?NHdFUzJVUjc4ckVOODc2OS9FRmRsbXNnbG1aTjFsalBxRHF3TGx3eWNtdmJQ?=
 =?utf-8?B?eU5DTUVIbmlGWWdtNmszMk5SNjhqdG14Ym1pQjVFd2pncFZ2QXgrbHNHQ3pG?=
 =?utf-8?B?bC9ITjdiYTYxR3hQUHdqNU9yS2xiQ3doTHZEZUJRZjlwZEtFbEJYZTJQdmwr?=
 =?utf-8?B?eUU4am54SEN1V0VmbDNNMDE5TFZrd1dDRFpTVlRCekhxa2swZWVrMGFSWkFp?=
 =?utf-8?B?QnJ4M1VzWloxMHI4elBWMTBBS1FKQ2xNT094cXl3MFN5ay9XUk03WDNFNUp1?=
 =?utf-8?B?K0dRSHR4YXNaRTNIUTJYM3c2TFJpS1A1a0k2bWpMbG9uYWc3Z3RhRk5hMHZO?=
 =?utf-8?B?ZU4xdVhrcXdUNHlDdkRoUzdJSHNHdEVyRk92MTVwWEtmWFp1eVpGamkrVXBj?=
 =?utf-8?B?dlhEWHZkOTA2MjgvdDl2V01kTDY5Z2JVRmxTRXpSQmdwWEpYdTRyOENEMEo2?=
 =?utf-8?B?S2FFbGxxOEZ4c3pZMWlXbFNPTVk5MzdvVjliZVMxbjJHVTBSeFlYeFZ0ajNP?=
 =?utf-8?B?cy8zc0JUd2lTS2xRdjBiVW5yMDhSbHEzaHIwRzFESzBzT2VqNk9DTytNb3RT?=
 =?utf-8?B?N0NGdHdkZ01qWTBqMXVqVW9Cc2p6TjRhY1QzdTV5K3R0T2llVXhLUUV6OTdL?=
 =?utf-8?B?dmRQN3oyWWhVSWs0VlpmaUpTU2hXK2JoeVVTd0ZTd28ySE81dG5OUlNnZE1O?=
 =?utf-8?B?amJJdnlxMXk2VE51UkRHTnVCbE5OTDRlUm1qa2hqZjNqTkdrdWtBbWNvcCt2?=
 =?utf-8?B?ZjFnaHE1U1ZYaEc4ZUFZNElPc1M5cTBLUDZCa1ZzWW02VnlpRVU4Y1U5Rmdn?=
 =?utf-8?B?Tmg3L1luaHBST1RmclM0bkdRWkZEZUYvQ3lSKzV3K3pPRVkxMTlSWklaY0xp?=
 =?utf-8?B?MmJ5bHcxMmdFdS95b0p2ME1jYWpBK3dtN2RPcVpLcHRtSDJxdFY5eE9HS3Z2?=
 =?utf-8?B?ZmlsVnBhSitkK1oxZytCd0ExM3ZXZ0syVU5OZlR6Wi9lbkpBVTRnTU4rYnNp?=
 =?utf-8?Q?nrUI+DlC3l1UpT2/bg45EHdbiQmWjZQ/NNIQcb5IASTF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b8963c-4975-4c4e-40c4-08dd75131542
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2025 13:58:17.9776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kobNe0jX+d51G9xPmx+Wu9/1Wm1CiWxmHpoyjAWUuI+CDBoQ0qQu+Q5l7gzPqGZIRb/vH8Lpvdu8t5LYIcrnKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403

This is a feature I found useful to have while writing Nova driver code
that accessed registers alongside other operations. I would find myself
quite confused about whether the guard was held or dropped at a given
point of the code, and it felt like walking through a minefield; this
pattern makes things safer and easier to read according to my experience
writing nova-core code.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v3:
- Add Acked-by from v2.

Changes in v2:
- Use FnOnce for the callback type.
- Rename to try_access_with.
- Don't assume that users will want to map failure to ENXIO and return
  an option.
- Use a single method and let users adapt the behavior using their own
  wrappers/macros.

---
Alexandre Courbot (2):
      rust/revocable: add try_access_with() convenience method
      samples: rust: convert PCI rust sample driver to use try_access_with()

 rust/kernel/revocable.rs        | 16 ++++++++++++++++
 samples/rust/rust_driver_pci.rs | 11 +++++------
 2 files changed, 21 insertions(+), 6 deletions(-)
---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250313-try_with-cc9f91dd3b60

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


