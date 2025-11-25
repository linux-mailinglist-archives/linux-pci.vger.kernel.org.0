Return-Path: <linux-pci+bounces-42045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FF6C855FD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25CD64EB7D5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3B0320CC9;
	Tue, 25 Nov 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PMCDYoth"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B45032572B;
	Tue, 25 Nov 2025 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080446; cv=fail; b=h+81fQhijUKPVnaTBhk/FlU+fTnqd4cEg8M6jQW4tDThYyJnlWNlccC9vvKF9umM9mqCu69UJ/5ldJhgS9FUOUQ5Uxpz3InGHTJZu9ypFWp5BgpXCHyKMuJjEZMiz5oEvNxgfgIxl6/y4gpThPlVKRADnhX/P6pj2S72S8ZS3TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080446; c=relaxed/simple;
	bh=LGkmQnWp1LBbJVjXZZXyJrdMZXa7mIVQNMPNyM1j18A=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=t1DzgJIfdHzvJiHbDT4nJRPAAqOwUt+huzmqzHjOF6ljUUXHkMlYNC9EpXVKcDmye+5ZKck5OCgiuGjQK5sdMZxv/5RcsJXKAyGrwzJcH4G527ly7gLVCA7YqjYs3RUByGdc61/PNwgj/K+hTTUG3/1ZCz8h5Ray+J1TPV6666c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PMCDYoth; arc=fail smtp.client-ip=52.101.85.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0iRnmaTA9ZiNegFHTrIptp3tFMUHEjvHf1+7ztAd/vBd+RwGKe+hji1nD0ravEUNjRNKz8SAw8Bv18yxa7i+E8PUaxZeztLS5yAtqZB+mz56A56VIr0PECMPdWuaCxOFq/7sq0UHASL5ucP1mt0uFCcIKcx7Sb2iWicVXPpQ1PXSYGuPZMHy5IlR7s0oiIwU8sK4FVhMIZsI9zGEgypaLaYoCdEf3b7IKVGbgu1U+xbAXxagBmo0BPeTZpHzXSg1icvrqmt4Yq5T7RLBkNX94R97AB8GgYGMzkb1LQGBweDCiI3TGXzekk80s35mvCsdg065HUoNamqowKTG8dPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XoavscFNzA+sjqlNYf/Kv4w2xNIdUh3uz4ilzo5lQQ=;
 b=vFo0YE5LATmWBw6Tu65iRPDOSxYE6UFEJN8LDLtkKL53q2ZDmI1TYFLc/uR2Xi202IgGR6YYa/7GYlvIVtye3nC2UkpWKA3nBAMMiDzv0kyQ20aS9QifGzfq8S7dFzgb9LMhNgOq7TqJbpT3e6K82m84v7e5oTqPXwaxo4O55n+r+ojnIBCLuLovZy23urX0CC2+q7IHcjlbIakQew9GHeuxLlMpa5mgYSR/rzbxCjzWfN2wk4cJ+koAjaoEqQv1Jc6lwFmuI+ql9JiPVrN70mDFpFJEIfjuL699EPL7hEW3XnnnOLJG81RToJDGCHneFs6ramIoDrG3MSRYFHKP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XoavscFNzA+sjqlNYf/Kv4w2xNIdUh3uz4ilzo5lQQ=;
 b=PMCDYothuRDJfuqsR4XWfpGGvEDbV9Xvbsd87mPXsObRwrIR9J4f+wQKZ9jqcoHL9pF/pqckpjy3qiaf03Ndbn+KSCceEdwebuR9PWgwAUzgee7AvHYGTuEdj3JMIieDVN5iINAD3Am4demBueqzTrgk0mZHsxt843TkXsuWD71t0KWSKrAt+inziaur4q0c03uOpVOqZ4PTuxoTx1jC4XeJaOOmNJQhp22+/RmKPt7ZvlCqlRM3XMssaf40TmJG/odromx54kLDcOccul/oH+YoUg9Pjd9R+WcW/d7YQUd+YtixFF0YjfOt9BtGjoXs3/HNRFqYCSdYPdkopsSYMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 14:20:37 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 14:20:37 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Nov 2025 23:20:33 +0900
Message-Id: <DEHUBNKNSNXH.14A4OGQKY5KZR@nvidia.com>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v7 5/6] rust: pci: add config space read/write support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119112117.116979-1-zhiw@nvidia.com>
 <20251119112117.116979-6-zhiw@nvidia.com>
In-Reply-To: <20251119112117.116979-6-zhiw@nvidia.com>
X-ClientProxiedBy: TYCP301CA0003.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 9251d62f-5020-4730-4293-08de2c2dcdb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEt6SDBZUWE5ZG4rczZuTjFWNW1NWFBHbEtOem5DU0Y2QnoxK3BGNVlpeWtr?=
 =?utf-8?B?QWJrTjJVbEdmUmo1T004WjNtYzJVd0ZGSnR0Y0tsU0lnazRrRnNvZkhVV0NS?=
 =?utf-8?B?Tmc1NWx3QnZKSEo3NmFJN003Q0NYTU0xb3c3Y3R4WDZUd3R6WUxubjNPaHV5?=
 =?utf-8?B?WlpSWVgrOXRFOTlJYkM2cjUwTTBacGQwZ1BiK25iUVlQUjB0dlBUS0d4VHFi?=
 =?utf-8?B?YVF2RXlQUXdpb2pYZUZRaGx0a245Ynk4OFJXREM4dVNSS1I4WVphNFdJaVI2?=
 =?utf-8?B?NytKZlBwaldKSG1GSy9iSWloT01kY3pEcnhmbUgrYWFueERWSkNJZElqbzJ5?=
 =?utf-8?B?T2NlM1paVFgwNDMrOGRwa3o4WnpLTCtRWHRPQm15RnprdUZvU1B3N0h1ZUl2?=
 =?utf-8?B?QVRNUHJjYVdnb3NpRWUyUlUySjdCKzhBeGREencyUDFsbS9sZjBYVHZNRnJK?=
 =?utf-8?B?WDV6TTh6OXIvd25hZDg2WlRSQVYyYVZnUzZjWW9xU0F5UCtmSXk2T3lwc0VQ?=
 =?utf-8?B?dWhlRHd3SitNQ3BjeTVMbmt5OUpFMkxEVVZoRU5za2NyWmpTUkhWSXY3MzVh?=
 =?utf-8?B?NHo3emtDK21Fa1NTMUNST1ZDUXJLQ0haWitla0tEZytZWUhYQ2tIVHFkaVNr?=
 =?utf-8?B?dFhiakRGbFNVR2h6NzFuQkpqWUVqN015eU1obTFJZUpnODlpZjZJdmx3cHRO?=
 =?utf-8?B?Q2Q0S1FBQjc5dVNUNzZzNDgrTjcvWFJDSWRJZlpGbGNuWHJBdWU1Y3RyRUtX?=
 =?utf-8?B?STREdndDRVprcVNncXR2T3c4NVJNdXkvTmRRZ01DaWVOeHprdE5wcGU3L1Q4?=
 =?utf-8?B?eWdaMURCLzJwZDFUZzErMXhjS0ZETyt0eUNtSU50Mm1ySlR4QTBpdjR6alkv?=
 =?utf-8?B?K1k5Vk5qTmdnQzY5ZGwyVUhWVFd2c1VaU3ZJeG40LzMvVTQrSlpjS0JDekkx?=
 =?utf-8?B?NTBvZFFEakZLY0tIZy9TZ1Mwamc0ZGRORDNySHJqWlNGbTdkOVRpanVXS1ZD?=
 =?utf-8?B?UWhkSVRuR2xoMms2d0J0eXNFVlFjcDBjajVINHc5U05rMVhtWFlTWUtzTi9J?=
 =?utf-8?B?M2lvWW1vZGRuTUZqeHVKeFhsem42bjl4SmE5Q0Roc1NydFVqVDdZazg4UlVP?=
 =?utf-8?B?QlQzL3JlVTNVS0kxV3NxaEQ3ZFFJUEp0bTcxN3pzdC91cnZ5YWM3aUFMM0JK?=
 =?utf-8?B?aEMwYk9pVmE2YmtBbEZ0akw4NDFJRVJCR0l3T3NuRCs4em1pb25DbEtYTzJD?=
 =?utf-8?B?ZkEwcUpMb1p0UjhmdUpLcXh5UjZZdnkwbXFSQ0NUMEV3ZmNGSU9IL2tlYk83?=
 =?utf-8?B?QzhHUlVGRFN5bXQrem16a3I2VGxoSFBtajZvS3FYU2hkQ2o1ZExWYVQrMTFZ?=
 =?utf-8?B?NjBORVJUZlkwS0FrTlNrY3hGa1JOVXV5Ukhoa1pnRTN6ZzhLaXBJMG1ya2p6?=
 =?utf-8?B?L1pGV2dBM2c2L1p3VVQ3TDA0ZHlRQk5oOWc5dFU4eHpnN0c4UTh5RXF1Rnkr?=
 =?utf-8?B?aS81T0RVbGJNTnovMW0zWVRTSkxPT053U0l5RzVNbXNnV25oRkxJQVkvV1U2?=
 =?utf-8?B?cExyeWVFYjZzc3Bnc0Q2aEVhVkRRbkhjd2Z1Smp0WXhzYUVJQ3c4YTBsbUlF?=
 =?utf-8?B?WS9SN0p2SVhLTmdDQnlmRGZxc2E1dEFWejFFeHA0aUlYNFJ5YSt2aUpTbElz?=
 =?utf-8?B?WElETlZqWjRNWG5zVWpPRW01ZWF6dXdkVXJobGNuMHMxWTlhbURQazMwLy9i?=
 =?utf-8?B?MmIycGtoa25OQVNiUTV2R3I5bU5xRzZSTW45L25aSVQzYjhFVnM1ZWlXZjJz?=
 =?utf-8?B?RDh5anZRYU9wK0hxYXd1Tk8xbmJZWkRZTXhCbnpHYWpRanppTURQOVkyZXhZ?=
 =?utf-8?B?QzZIT2lCcUdmRm5STXlSQWt5VnAzd2FNRDF3aThsKzY0TlRtMVNra1I5V3p2?=
 =?utf-8?Q?VyetOufbbQkzKETA87yDjtHe25u5nxix?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVdWSEhuTWFQckRqU2xZc3k0TnRCcjZ4TUsvb3VrSnZCWmFjMldtaEJZSnhH?=
 =?utf-8?B?bC9DUzd5R0IyUDdkZUhscmZ2M1BMaTFKZFhlYWpYWEJTb2lYa3dSdmltV1Q4?=
 =?utf-8?B?NjVvN0VPbmU2cTJzV3hHYmgvVW02Z21mOG8yR1JQRmRVMmtZR2hUWnBYcTlS?=
 =?utf-8?B?eWFnek56SGFqaWxuNEd3WFlTOW5rcjFFR24xQTV2b1ZheDRwbUFqMWxkS1Mv?=
 =?utf-8?B?K1puNndXb29UY0xGc3RKdUVLb1lMRC96REt4NE01ZjZGZW1mVWdlS2JYaXAz?=
 =?utf-8?B?QzY2SDlmZ1lsQmdHTHFGSEpCV1p6RDA3d1lnajl3d0pyK1NqbW9tQ0gzWFRT?=
 =?utf-8?B?RkFPWnVRcmdHK1lVb3M4SUp3UjkrRS8xdXJVa2U0bERjcWMwUEt5SWVPczd5?=
 =?utf-8?B?a2s3TVkzeVBSd2xObENWVHFJRHJPOS9FNlJIL2ZNK1J0NFk4alJJdEtTa3M4?=
 =?utf-8?B?UlVpbUJOVVhMSDRlSmxsZDc3U2t3Rk5kV0tTbmRwVkxOaVhUR0FWUzB3OXlB?=
 =?utf-8?B?dnRoVFluZ1NNOTVTUEhQeVQzVWtvS0lnZnJVVkxYLzdNMXN4WjBtUy9aWU1F?=
 =?utf-8?B?OGJBODg0NCtlaTFBMURsUXRLRFNkZFBBbEVDVkFGaUFDNzByUHh0YnF3cCsw?=
 =?utf-8?B?Y2Z5ekhtNlJJWitjVVJOSGx1OVZGbXlOeFdMQTljQUdkaHR2TlBGNkFwSDJZ?=
 =?utf-8?B?OU5OS29TSUZGaGtVano4VVJadmtDUFZxRitsMXJTeU1QUmxNUHcwVjRpZ3Rz?=
 =?utf-8?B?SzN5dGhrTzd3OXJQd2s3a0JXeDdaMSsxc0FDdEYwaGhpOTRUMWF2WFlyMXo1?=
 =?utf-8?B?NTFNczRSUUZmelJCS0ZsU0taOUk3R3NRT0hMc2txZWJwY29oQ3I4MStxSlhK?=
 =?utf-8?B?L3VPUGVTYmNmS2EwWm5IZkNiSWQzMFBXS2ZVTDdSc1JJSktoV2JLZEFBSkpS?=
 =?utf-8?B?a001cmE2WStNb3J1MXRUZi9pNUkwUkErajFHWlVrTUVrZzFVdTRlZ0dvZnpw?=
 =?utf-8?B?aFgrQ0VoUXdiNTVGL0xsNE1hNExSbDFUTk1kVXBwZ3NnWjBrMjE3aStDTUZ3?=
 =?utf-8?B?SVV3b3pKZ2dMUnJUN3lHQ1JQTjFQRSs1RHQwUU9OUHJ1MzRuM3FrZ1pObyt4?=
 =?utf-8?B?RzBGZnFUTGk0V2hlT3lPV1BMcjlwaTFYNmg2a2ROb0laTEdKc1g4N1FNV2JC?=
 =?utf-8?B?ZStJK2xqcHlWbGZNQ011M01GQTBMUkY4TnExQ1pwVC9YWm00OU9vcnlhL1pQ?=
 =?utf-8?B?eVBpZTJLcldpUkZMTkh6MjFxTnAwTHE3QnlmOTBVV3ZTZExkTmY0SnB6V1RV?=
 =?utf-8?B?UUkvUWhVR2tGTlpRaFZucHZmSDFBdFRlcm4wSnhJVTlyMlNxdmxXZTc4OEVk?=
 =?utf-8?B?TjlDV2Q5VGl4QU1MV0Jldk40WGV1T1BEOVJoK2U2RVpzN2FDM01jd004bUhF?=
 =?utf-8?B?VUVSazRjZ3RVUU9BaDVYQXdMZXBEeXlGTUFMNDVXNnJHcytpY1dIL0dOVlp4?=
 =?utf-8?B?WWc4bEpkZDFKYlBQSXBrR1VDeHhPZ2ZkcG5kSFlJVmNYZTdzQWFWRnIyM1U4?=
 =?utf-8?B?Q2F2eFQ1bW53SWtxUUEzZzlxUnh0dEJySS9WVlppd05aaXBDNUo5b2tvcDEv?=
 =?utf-8?B?SkhyQnNpWHRQRzlrYSs5OG83UnhrcFBlMVc0aXBiNHNiTDVmL3Q3M1doOVkw?=
 =?utf-8?B?blhOOHBnZE9aRXh3R2FWd2dLd01TUGRWMlVqQ0NVcGp6a3l3L3lwbk9tdDRQ?=
 =?utf-8?B?ZDRobEU2dVFFckYwdWtzOWtvY3VlTjRDK1EwY2NuUStIOUd3Z3FOL0FLQnpw?=
 =?utf-8?B?dFhFMzA4NEtPRmRvMjRNZHFQcm90bmMxNTB5YkRDT2s5azNuZWxNNVRuQlZ4?=
 =?utf-8?B?SFBXQUZWZDZCM0szcjY2M1Y0Mlp4RjQxaEp2UXhtbVAvYitFWVp2bGtldEdI?=
 =?utf-8?B?ZFZtM25oS1JsTm1LSmR0ZXMvQ3ZOcVFsWVUybGt1WnZzTGsveE9pVlZkRFdp?=
 =?utf-8?B?dzFGaFYxcURLY1hYaU9TeGp6YmhkQUxVblE5RUNXYmczaGN4WkR4OWVvK09Y?=
 =?utf-8?B?TnRkdWFIU0g0blI1ajFxR01IVEV4cGRaZUdZV25OYUE2VGVVTVN3bTZJelp6?=
 =?utf-8?B?a08zTDM5Umt0M2dhSnNkUHAyRWhiZmpBb1FCNGU2bzhXUmtvZnRGeC9ndjNK?=
 =?utf-8?Q?8JLwVqmqHEfPIOzyojrjN9FcXo5+SID1PSzd8E4Rd6Pt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9251d62f-5020-4730-4293-08de2c2dcdb7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 14:20:37.4344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XG1iKx7f16xCBikQWYP0SA5MeRWpE0wZ43sO4dnREiKkOvcnsk3OtXpuvQxnXvBy4pXPQ0FWAQJw7WpcSFZ1ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009

On Wed Nov 19, 2025 at 8:21 PM JST, Zhi Wang wrote:
> Drivers might need to access PCI config space for querying capability
> structures and access the registers inside the structures.
>
> For Rust drivers need to access PCI config space, the Rust PCI abstractio=
n
> needs to support it in a way that upholds Rust's safety principles.
>
> Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
> accessors for PCI config space. The new type implements the `Io` trait to
> share offset validation and bound-checking logic with others.
>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/pci.rs    |  43 ++++++++++++++-
>  rust/kernel/pci/io.rs | 118 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 159 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 82e128431f08..f373413e8a84 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -40,7 +40,10 @@
>      ClassMask,
>      Vendor, //
>  };
> -pub use self::io::Bar;
> +pub use self::io::{
> +    Bar,
> +    ConfigSpace, //
> +};
>  pub use self::irq::{
>      IrqType,
>      IrqTypes,
> @@ -331,6 +334,30 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
>      }
>  }
> =20
> +/// Represents the size of a PCI configuration space.
> +///
> +/// PCI devices can have either a *normal* (legacy) configuration space =
of 256 bytes,
> +/// or an *extended* configuration space of 4096 bytes as defined in the=
 PCI Express
> +/// specification.
> +#[repr(usize)]
> +pub enum ConfigSpaceSize {
> +    /// 256-byte legacy PCI configuration space.
> +    Normal =3D 256,
> +
> +    /// 4096-byte PCIe extended configuration space.
> +    Extended =3D 4096,
> +}
> +
> +impl ConfigSpaceSize {
> +    /// Get the raw value of this enum.
> +    #[inline(always)]
> +    pub const fn as_raw(self) -> usize {
> +        // CAST: PCI configuration space size is at most 4096 bytes, so =
the value always fits
> +        // within `usize` without truncation or sign change.
> +        self as usize

While correct, an even more solid guarantee is the fact that `self` is
itself represented by a `usize`.

> +    }
> +}
> +
>  impl Device {
>      /// Returns the PCI vendor ID as [`Vendor`].
>      ///
> @@ -427,6 +454,20 @@ pub fn pci_class(&self) -> Class {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          Class::from_raw(unsafe { (*self.as_raw()).class })
>      }
> +
> +    /// Returns the size of configuration space.
> +    fn cfg_size(&self) -> Result<ConfigSpaceSize> {
> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        let size =3D unsafe { (*self.as_raw()).cfg_size };
> +        match size {
> +            256 =3D> Ok(ConfigSpaceSize::Normal),
> +            4096 =3D> Ok(ConfigSpaceSize::Extended),
> +            _ =3D> {
> +                debug_assert!(false);
> +                Err(EINVAL)
> +            }

Should we implement `TryFrom` for `ConfigSpaceSize` and use it here?

(can't wait for the `TryFrom` derive macro to come and remove the need
for this kind of boilerplate!)

<snip>
> @@ -141,4 +243,18 @@ pub fn iomap_region<'a>(
>      ) -> impl PinInit<Devres<Bar>, Error> + 'a {
>          self.iomap_region_sized::<0>(bar, name)
>      }
> +
> +    /// Return an initialized config space object.
> +    pub fn config_space<'a>(
> +        &'a self,
> +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal.as_raw() }>> {
> +        Ok(ConfigSpace { pdev: self })
> +    }
> +
> +    /// Return an initialized config space object.
> +    pub fn config_space_extended<'a>(
> +        &'a self,
> +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended.as_raw() }>>=
 {
> +        Ok(ConfigSpace { pdev: self })
> +    }
>  }

This still has the problem that one can create an extended config space
object even if the device's `cfg_size` is `256`. Both
`config_space` and `config_space_extended` should fail if `cfg_size`
returns an invalid value, and `config_space_extended` should also fail
if the returned size less than `ConfigSpaceSize::Extended`.

