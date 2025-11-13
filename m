Return-Path: <linux-pci+bounces-41066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E745C56215
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 08:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 211983468A8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 07:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCD132F763;
	Thu, 13 Nov 2025 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="adR0/tpo"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325432ED5C;
	Thu, 13 Nov 2025 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020597; cv=fail; b=SPVfd+VN5GbdqHkJQN2BTClbJh85gUxQ8me0Dq/X5WAwFeMDCcTnvaWWiyvT+ShMCzG+WLNoLDCDBj+OeWyQjPiXE/VgW3m86wo84Z1W31N80VhHrz2RNMLfMv9XGE19FSzrFXFirhoGrVjegJfsgNU8cOB0Wss8FeZ4WIckVl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020597; c=relaxed/simple;
	bh=XGO94WuGw6vPJrEZmVyaXjLyWb1MCqyuMx5O/pKDjsE=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=jay9mjhnDMQkgIkSmF9CS09MqRy6B5ME8FKv4+DoPJZ0oXmT6XQ08Bl/KFotCKJko5Ra91KfIxQxHbFhvlbGLRXTixzBXMMsdc9mpVLRRPDBCf8yxsmg/C5+2Wwh7U0AaOh5q7POdJdVxt8SeDRDd69lQmZzZkOxyPx2c8mUfCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=adR0/tpo; arc=fail smtp.client-ip=52.101.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cyea4iXL8EKIjR8UMysKuDy41f4uLte15NXu8EkKHO+hD8YQw3zPpmU4iwASN+LhitewZN+BZMvYPZuaMyOpTP63H3iIMUV3p/1V7AbU4220KS1sqUwFVRQLvuf08eyJQw6XaGR3dl5FgnCeA5aEZqDeFfiRmD4Z5qhXI+1KWFPDAJHViwkcoccEMTWDB5uHbtb/0jIVARkl9kGN2jRr212c+SA1X4bMaWjaN6cZEKqIU/3WG7K/jiD/O/S/EzKBD7Bd8qsexkZju3J9RSVKetM6gdVK/fAo57c9koqHxDC1pvl9/oTFzG/nW7RIZATDo/6ydV52dntOzN/WsumgPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0aKCg33Qvr6RYCbJbj9swJD+a4irnkaL3IMSf29/hk=;
 b=c+z6wSgDlZhvIq67Trn6W6ue6QG78gaeuX5jfaj0XlvpvgmddLEr84oGu7KZrbTJ/SGlfxu0lCnemf3khtSmevSYWw0Cq3bKdgalU/kZIll/ZBjpoIGa82KVrAThd1OhD7MeG0eq9TL6OAoUBteZey8kMG1Ftnx+5/ldXIbjKLhtOwB+Ddphxk5EC/Gghgjtv3jACeQqU6UNSh/cyy1MBGFZcBuKX0m/wbqAVB2QCXmb6H1TA/Xqu5MAnY8Q1nW6Shf3f7IcnYnGvQZmtSndq38gYfgKs8QJtTsE5+xKVYaspy0VVIYoELWtYk9h7S3R0QYf1FwHs/zzCJ3DrXGItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0aKCg33Qvr6RYCbJbj9swJD+a4irnkaL3IMSf29/hk=;
 b=adR0/tpoFkVx7SSwgZawkqjjtLS3Vk66JuScYBTANZ26Dr55d9fkxsee3oOOeJsnqqMekEBs3kugj7Yh/3htRoQTcx4MMZS3yxxufqP/1NJa8qwVmpU6NqN8xBE/oQDr7OVrK4A8A5lK//USBSkMx0qRmnUkwnQZCndvZevhJ9ezSec1n0GuWe68iTDp+KOHbxmxBCYBj9WJsEKBOutnxiI9zZmDqtCY9aQ5q6xgPvdCZxdh3mw3XkQ+qrhahBt2yWCA7sPsTkXI5W0keay660wD9OHXlY4wPbtSj589EkHa9E4co8VF+Rnk5yL219LHFCunsOrY52UxKN70TXAsOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 07:56:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 07:56:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Nov 2025 16:56:28 +0900
Message-Id: <DE7EN1I1WCL8.39OE95LPS6XXH@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v6 RESEND 6/7] rust: pci: add config space read/write
 support
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251110204119.18351-1-zhiw@nvidia.com>
 <20251110204119.18351-7-zhiw@nvidia.com>
In-Reply-To: <20251110204119.18351-7-zhiw@nvidia.com>
X-ClientProxiedBy: TY4P301CA0048.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: ef617cda-6bfb-41e5-b21b-08de228a28f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXk0ZDZLZHViNktzU3lscllyV0ViWkRUMEdmeGpuN2dRWVJld1ZwSHNqSnRG?=
 =?utf-8?B?dC9pWWhHRlczVmoxTHBiYlFrNXRCY1NWK2syeVhsbXczcTVXTFNHdEo4VTlr?=
 =?utf-8?B?Q1JTOVA3NzUwNHpxV0tMNW5TTTN4WWZ4NjZiQ0haMUdEWTU0a3ZoajZoYVBa?=
 =?utf-8?B?eTlmZUJlRnRlcVlCOHdYUVBCYitOUXhnMnMxODAvU3FKTEI0aVFzb2d0UkJx?=
 =?utf-8?B?V1kzMTVoeFR1TlNnUTZUUDFwSHQ5SkZ5aDFjOUlTWXVSOWdueUwzTCs0d2ZC?=
 =?utf-8?B?VUt6MmJEakJiVzZINEZQdEV3cFE4aXprOEVkSWxlemU1UFFyUks0b3dLMzZl?=
 =?utf-8?B?a3hDTTVEdk1qNDJ6eDJsbGt4NmV3aXdCaU5EdExSTUdLZ3M1YUdQRXI4T050?=
 =?utf-8?B?Mmt0eGhqK0Z4QVR2NkROV0RyQmZCb0lWSHRuMFMzZnFmcmFiYTNpcTNDdTcv?=
 =?utf-8?B?T1pqY2V6V3ZTdXJ5RUQxQytRRlFPSWZZZ0x2NFdNQmRUWHU2VlQvZEV5aVVU?=
 =?utf-8?B?eFJ0aStjcm5PRE5BditldE9oQVZPelN1Z1NzQVFrQ0xCK2pxOVlkMlpCV21x?=
 =?utf-8?B?dGZvRFZ6WDVpN0ZEbkU2aCszOVhkU3BMcndMNDg3bDQxdk1JSm1jRWhtWWEz?=
 =?utf-8?B?eCtQQkxPd2FvYmtmdW11aHU1SXpLS1h6OTA1ZS9vTmU3STRNVHQyL21jMXRD?=
 =?utf-8?B?SWdZRDEvYVpIZDd1cmUzVDd0UThPVVpPVHp1d3J6VkpTSU5CVmhxNFZHODdJ?=
 =?utf-8?B?TVlPK292U05sNE1ESmdwajVhUk4rY01lMzFTMlVSRzVRNkljWmRud2JWZmdp?=
 =?utf-8?B?Z1pHaUF5VmFmVFRtZjAzSjgzVXhsQVdYVW5rZnMrdE12bk5qemc2dXo1dmtY?=
 =?utf-8?B?T2JScUZxQzlFcm9QVW5qKy81Rk9Gek9meVMzbXJvT09QUFZ3enp2ZE5CS09S?=
 =?utf-8?B?NVVLclFSbGFZVGNDY0hIbk5WazYxSXZxNWlETXFjMzAxSm14bDlJNnhVUHpx?=
 =?utf-8?B?TW11ZVcrMFFuR2lPeGFZV09FVnR6SmtIek56cDBPS1loRmdGVkxYUGNUMHg5?=
 =?utf-8?B?N290NGNtUVcxREd5RGtYR1B0RWhuNlBzZkZXeUd4M0NZQWtEU2xMUnJqZ0ty?=
 =?utf-8?B?NlpIZE10clNyYyttNXB3aDUrK1drU1FZNHY1OXpXUDZXOEhieFRsYURUWisv?=
 =?utf-8?B?Z0JqU0JRMmFWaW1LL24rT1MwSHZyVm5kcDAxRG9qYktyLytzNkVVTUhjQmdE?=
 =?utf-8?B?S1B1bEZ2L0QwU0diWU9DMjZsSW00blJQczViNHByVHVYOTJQU0lQbW92M2lB?=
 =?utf-8?B?ZEhza0sxdUZ5dmovb1Z1bXhCVHNEK2tOcnAzNzZ4ZnU1VW1MUFB3TjYrZHpz?=
 =?utf-8?B?YS9pZStOOU5qNDhYTnpDK2tSOUc0aFpIeHBFMGhhMzh4b0xVeExsVHdpMEY0?=
 =?utf-8?B?Tk83ZkNqMHd4TUtidWlxZ1BXM0M1OVZlWXFjbFcySTlvV3dZUjREYlpoVEp6?=
 =?utf-8?B?cjZVc1RMUzVlU3JxMkl0WWpaTFVycFdPVGY4TWRvNTFYWE54KzZmMVNPQzNs?=
 =?utf-8?B?RzFCTHZFZnpyekdsVVFpc0FQMjlqSnJrOWo5ZEo4Y042K1NRdmdQL3dNWTdj?=
 =?utf-8?B?RTFHSWl5bVA5anB3OGN1azQzTU53eEVKMXNBRDJGczMreUFwSDVPMkpJV1J1?=
 =?utf-8?B?NzN2S2VrbkhMcTh6SjdxMTVFSkRVQ1ZGT2V0Y1AzQ2hHL3FOSlc1OXM3akU0?=
 =?utf-8?B?dEhlUXcwWTFiMFE5bDNTcnVpeHNPSkdoT0M0S2Ztb2tCakExYTB5cFVFLzlL?=
 =?utf-8?B?VlR2K3psNk1SUFZZTnF6WnlHb2x5NWpJbE4zbVlXSVhXdldSMWV1V01GWWhI?=
 =?utf-8?B?Z2w5UDV0VEkrV0VSQXk0a2JQeEpOK2JkamZzWDg0N1dGNzQzSjRmWFNRTmRJ?=
 =?utf-8?Q?6trzYQ/HLapjM+epHuRw78XywR01WQL/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXoxQ01weVVWR1QvN0p1blhEWHZza0NNd1V6UFJNNEJheU5VeXpmbFVnV1Ex?=
 =?utf-8?B?UG9kNW5xTGlMb2tJL21KbHBIbDBnNE5KMTVualB0RS9PcVVnQWtsSDB3OGV2?=
 =?utf-8?B?K2Y5NjZtSFpRNXdZUFZkVno4dWpzUEVnVmdqdWJxMDl4dmZKZitmbXUxZ29v?=
 =?utf-8?B?eG4yc3VRSXRNK21JejJuUWxtVXJJdmV4QU1rcHYwcWZnQTU1Z1RML3ZobHZ5?=
 =?utf-8?B?WG5XRjZMRVB6SnE0cjhDdllBbHROajV5OFp6UVJXbEUveUpHNnNPb080bHNz?=
 =?utf-8?B?Sm8rVGNSemowVng5RVhKQ01HRGhaNHhITGlYbmk1VVJRTEtMUElja3NjVGlC?=
 =?utf-8?B?ZnpZdDRMVW5aM092SnljRk5tQTRKR3dmc0w0WTV0c3lRWUh1NkxRb08xa1hM?=
 =?utf-8?B?RXpsNExjNHdoUXY4bHY2NVNnQitPMEVyaDF6a0pYVkRuY1NGZHlEKzJ4WlNy?=
 =?utf-8?B?UWhlckVTRFZSVG5TZUR6a3lsY2VROFlIU3NoRmFVb2pqanFHSXduOVFKUkJw?=
 =?utf-8?B?d0RqT1hRYW54RjA2aDhRWXlnWkN6bm5IV0UrdUlWVGd2SjFrQlNScXZURUY4?=
 =?utf-8?B?Ump6bTRKS0NVVERjcmtNSWdKNDdxQ0UzTUpyUFJNYlRnRWhjOU1sRWZlOUNN?=
 =?utf-8?B?YlpRbTdvaEdtLzN3Yzc3cjRmQVJtUWphbUh5UjFOaHkyd2d0RCtBQ3MvNEQy?=
 =?utf-8?B?NFNFcTRkWDFCYXowa0cvUjVlT3FWY095T1g1MUlhQUVjcDhnbENCOWtjWFBh?=
 =?utf-8?B?YjU4RThPY1U0ZHJSWkNCYTlIZzJNRzJ6UTdxbi82R1QyZkpqTmk4OVVCNy9Z?=
 =?utf-8?B?dWg4MkRjZExTbGIxanFCaTVsdTNqOXJkdEJFQ1JxcE9sQ01BRUtTdkRlSzFh?=
 =?utf-8?B?TzN2VTNOOWRDcUhyQlNWOFliMkpxclVkYUpGWWt6d3A1SU1oVnlvVSszVWN5?=
 =?utf-8?B?WThDb2pyaDB5eHhiZy8rSHBtUEkxa3NPZHZZZjgxZUFtWmRNNHQ5Q3M3MVBT?=
 =?utf-8?B?VXQrcTJpLzVLRmUybEZDSDVXc3V3dkQ3RjdUNGtMcDJ2d0NDeEp0ZURNYUs2?=
 =?utf-8?B?MytwbjVSdTM3UCs3R2VrUjNuQXpEK0JmNXlETi9VaVZFNkNRalo1UXdnTlJH?=
 =?utf-8?B?VEVhYlhHemo5dlR0alN1NVdJVis1OEZHdWtEcVVWZXdUcFducXBxYzk1K1ZB?=
 =?utf-8?B?M3h4QXc3Wk1qRDZ4L3lnZkZhdmJZRGRSc1FNL0hVUDJ3UHpHMWpWdGdRZG4z?=
 =?utf-8?B?ejh0eU16YXBIWFV6QW82T2hVUEQzcTV4MDAwejB0eS85VGRJVVFWS01sL1Nk?=
 =?utf-8?B?UDI4ZmYranFKZFp4LzRhVTFkSzlCMWExcmduL3dkOGZwd0I4c1pQNHJNUlRt?=
 =?utf-8?B?bDJOYkRCSm0raFE2T01CaFBxV25XZmZ4VXRnNldVM0RBR05kL1FZQ2s2cmtX?=
 =?utf-8?B?L3g1UzBCRDBKeFBZTWdrcEswc01qcEM1NDFsWm4zMFl3VTZFeGdXaVI5eGpr?=
 =?utf-8?B?Z0VUR3RmdVJUcW9hNTZRdlRyRGtwN0pUT28zTG1sMzlqUExxYkdMZUloTGhm?=
 =?utf-8?B?dVNwREdtOHFHa2hFVFptUnVldGxVb1VOazZ1U3J5bS9CK2ttMFQ2djlYMkZP?=
 =?utf-8?B?dnFNeHVBdTFxZHA3ekRDd2pPVlJycXJpVGxKSWFERE10YzNEVjhvUzJ1cUdk?=
 =?utf-8?B?RVh3UnRWczBpL2dTZVJiZ0xna2VvcUNWV21sNEwzSHVZQWNMYkY2ZjFtK2U4?=
 =?utf-8?B?Y1o2QUJuZjFVUjJDV1VvSDR4cEh4UkNYc2o2N0RmT1JNVFlWUEQvTXBnUUVI?=
 =?utf-8?B?aXRBQU0vblh3MW5EdDdGOGhGbitiWEZick1xRVc1N3poVU9lenN0TlZHV0s4?=
 =?utf-8?B?dU5yUEdDTDUzQ0VNcEhrcnFZVXVVaGtJM1lSZXlodWxDRkt0TTlUTkhoUjRX?=
 =?utf-8?B?TU1wamJCLzdTTVBlS3AxUDIzZk9zbllSOEFWRkpkcVRZWkpOTDZ4bUV3SlFI?=
 =?utf-8?B?UFg2WGliUFZFVUVKc0E3eGdKYlZLbmZuc3p3alFqTDNTY2J2Z2I1V1hJcGtJ?=
 =?utf-8?B?MjVRTzAxMWo4TWh3M2dWbUwyZmFsSVRJWFE0YlNLdnNwMGdzZXJnVm5oZ1pB?=
 =?utf-8?B?OU9nVVhtSlp5RUR5MDdTMHJNNEdpSmExTERZbEFGN2JyMGk1RG5jbkhhanM0?=
 =?utf-8?Q?bedpToIpC4q/L8ddDadzBenI1UqupjS10uMpbFGnqkVq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef617cda-6bfb-41e5-b21b-08de228a28f9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 07:56:32.3653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00HOQrccmGv7t2lE++88dpgyVtglS2UGYqrBSj0eKzunzYro1hOIIIYAeuwbFI2F3zpIwIcr6ArRSr18kycIRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867

On Tue Nov 11, 2025 at 5:41 AM JST, Zhi Wang wrote:
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
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/pci.rs    | 41 ++++++++++++++++++++++-
>  rust/kernel/pci/io.rs | 75 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 114 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 410b79d46632..d8048c7d0f32 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -39,7 +39,10 @@
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
> @@ -330,6 +333,28 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
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

The comment says this is either, but below we have:

> @@ -141,4 +200,18 @@ pub fn iomap_region<'a>(
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
> +    pub fn config_space_exteneded<'a>(
> +        &'a self,
> +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended.as_raw() }>>=
 {
> +        Ok(ConfigSpace { pdev: self })
> +    }
>  }

(typo on "exteneded" btw)

Which means that a caller can infallibly (both methods return a `Result`
but can never fail, for some reason) create a `ConfigSpace` that does
not match its actual size.

That's particularly a problem is `cfg_size` returns `256` but we call
`config_space_extended`, as the returned `ConfigSpace` will have a
`maxsize` that is smaller than its `MIN_SIZE`...

I guess we should either validate the size using `cfg_size` before
creating and returning the `ConfigSpace`, or have a single method that
returns a Result containing an enum which variants are the supported
sizes?

I am also wondering whether we want `ConfigSpace` to be generic over a
constant - it makes it possible to have instances or arbitrary size, and
makes them a bit cumbersome to define as we need to do something like
`ConfigSpace<'a, { ConfigSpaceSize::Extended.as_raw() }>`.

Maybe we can use types instead, e.g.

pub trait ConfigSpaceSize {
    const MIN_SIZE: usize;
}

pub enum Normal {}
impl ConfigSpaceSize for Normal {
    const MIN_SIZE: usize =3D 256;
}

pub enum Extended {}
impl ConfigSpaceSize for Extended {
    const MIN_SIZE: usize =3D 4096;
}

pub struct ConfigSpace<'a, S: ConfigSpaceSize> {
    ...

impl<'a, const SIZE: usize> Io for ConfigSpace<'a, S: ConfigSpaceSize> {
    const MIN_SIZE: usize =3D S::MIN_SIZE;
    ...

And then `cfg_size` could be replaced by just `config_space` which
returns an enum of the possible `ConfigSpace`s supported, that the
caller needs to match against.

Just an idea for your consideration, I don't know whether that would
actually work better. :)

