Return-Path: <linux-pci+bounces-32133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF38B0558B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 10:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34953A4128
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5288127511B;
	Tue, 15 Jul 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mSqMDSu3"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013014.outbound.protection.outlook.com [40.107.162.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8BE12DDA1;
	Tue, 15 Jul 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569727; cv=fail; b=sJneYxXyirqLQNivXNKDyVMweoCQoAvzX6p4Puc44QAxO5g/OK2C87ylWYHvMMQo4Er6oNFcvm/UA3jCm6mOwpAC6RScUcWUMHQVVOfkGR+Oki0TR4UsJp0joUPRZEX4IbT1V7VijLbP3AfnXBaxveDmvo5Bfwd1em+BFW/7Xsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569727; c=relaxed/simple;
	bh=+bforJkoCRmMk3SNVK4Z4x1QwXx7zygPX1U4JvGfqjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gVou35rSlZcjaeRXekr2iqZX5EiWpE1caeclPGQLIdkHnAZ3605lS1E0P7DbDqvx5zaVT3w+cJ3cn/akEGpLyLTjlo7EbtSSo1BqBp82I+H4MbKB9ZU7kCeSX1S7/LxShmY4S9N6Soz6wgEIO9d/PdKhEypGN3Ih2JRhBAQ1pHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mSqMDSu3; arc=fail smtp.client-ip=40.107.162.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJsQxX35xaG9WeRbIanMW/hPiYDuCoPzEjeBsUAS2pAA1x4Bx7PoMd2uSLFJxYTnhFI3WwKlTc2flB2+cwJ4yZjqRsAFiYvKXClCg+Z8rIqzAiVcjJKr/2fmeviNsjVUwR8TTQnqmDK/7MzLI9dIO0Vj6BW5Gol+6Z6G3xT6QOrkm8JqA3RbJNe7JIMXNG2mlpk8l8N6jLX/bbLcCdzBBLniYTW5XTNdP09U466avjgQ2N1+mIZU7Iat6U97kHcgoMSVaBBfKTEF0cXmAoXZ8GznrizapXNtPMyGBPvQ256AUUb8a76/rhgfsXX0dntgUwKFohrN547qg16Qnv+PfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjeikHKGFmWemReEvJlAAAS62wN3oHjb7YQnNUz+oeA=;
 b=eUuaxzmmUmINcwxBGA7KJc74su7D4wPyQ6WV6dzwZ+YVZMjQHLpBzWIGaBY8y/XgErJBEYJQzc2+xOAmWJvRkItKgPYxE0qtxP6CgPHEqEKhLnyjZtxeZ7cQL6GbVafzSh9oa8hhXqcmy6vIlvCU5nGjvACNu/96rz6GcO+IHxbsavp+PrFqObZi6l0G82++fYtEEJ0fIqQKIr/q2Qpz/2nZS0Ekf/zl/9C5g9OtM9yZsLBxwIsfm94yT2K1KemcM7sCBzMO/u1uSXjF4aYb3DWp63ioYHk3F0FvrY8IEj3B2yLi1DHezA5r4ULx6nehZvELW1eVVrnGMYnKsxuNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjeikHKGFmWemReEvJlAAAS62wN3oHjb7YQnNUz+oeA=;
 b=mSqMDSu3HY54CRgxXtbKXVQVSVnZOyY/v9d/Q3NSPD6Asy1Q+Uyugadp7oxOdeoYxlK7oL3JX+snYrTV2KQBn3/p63j2VyPauzdT/aLiEIXRWO5EfZyRRr2R5RMWJLpgvhDX2Y5k4SquBZWdjXxyE5UgEhb1kSdquyAiEpXjb1xtxyQydpQ7YTyn+lYbnmgpAJ7QzH5fx/urbIMEJk98JbX032jNuyU3iDiSOfvbhHlBUIVmmMi7XI9SSAKbYM3r96pcvEultYBROkZHxmCB5+QsCEntBZNoMIsG2gbPhODSqu3TZGUP1ytpU4H05ETA9U3mc0yqLBC09OhIVoa/tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6389.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:536::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 08:55:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 08:55:21 +0000
Message-ID: <e9716614-1849-4524-af4d-20587df365cf@siemens.com>
Date: Tue, 15 Jul 2025 10:55:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/7] PCI: keystone: Add support for PVU-based DMA
 isolation on AM654
To: Siddharth Vadapalli <s-vadapalli@ti.com>, huaqian.li@siemens.com
Cc: helgaas@kernel.org, baocheng.su@siemens.com, bhelgaas@google.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, diogo.ivo@siemens.com,
 kristo@kernel.org, krzk+dt@kernel.org, kw@linux.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lpieralisi@kernel.org, nm@ti.com,
 robh@kernel.org, ssantosh@kernel.org, vigneshr@ti.com
References: <aa3c8d033480801250b3fb0be29adda4a2c31f9e.camel@siemens.com>
 <20250422061406.112539-1-huaqian.li@siemens.com>
 <20250422061406.112539-5-huaqian.li@siemens.com>
 <7c8c29ee-2600-4eea-866f-8fe2d533418e@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <7c8c29ee-2600-4eea-866f-8fe2d533418e@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0254.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: c8672c7d-c286-4168-ba5b-08ddc37d5418
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eURuaWxYWjhJb0VBQW5DUEFMV0ZHbEZtbjVGN3FncHJZNkVPUTZmNFNOblhF?=
 =?utf-8?B?cXdTU1JmRUVPaTNiVlViTUtlNkZPcDVHUHZhWmx0MkY0NG03MWlwSndCbnZK?=
 =?utf-8?B?YzdYQlgwV0piUkdxM3grRmxVVWVoMERhaklFTlNkcmZPdTNWVG1kYzIvekQ3?=
 =?utf-8?B?eE93ZnZYam85dk9GQThKbVpyU0huNWNKVG1sVE9VVHM5eGY3aUtMTUhwU0dx?=
 =?utf-8?B?dmJCUFlFUy9xdmNrQk5wSkZPaU9jVS90dExnejF5VGpCNkgxalRpNFpuclRB?=
 =?utf-8?B?NXBoa0JhL2RUMjR1MnM5Y2Q3UWg2emRyYXNYdE1HWWN4MWZ6ZWVUL1RzTEFM?=
 =?utf-8?B?QThyanQwKzZkUGZUVkh0ZXV4V24rTzI1Y1NtUkpiN2dPM1ZPalVZT1A3dnUz?=
 =?utf-8?B?ZUY4R1NIVjdhOEFyWXY3ejBSR0tOU3BhMHZCQWUrT0V2TkxtdzlxRWhDaTRJ?=
 =?utf-8?B?RnJxeGNnbHhSc04rZFNjeS9VWDhzbldrdzJaVVpyRHo3OUw5ZytiaTFZdmp5?=
 =?utf-8?B?RmVjQ2hqeG1mMFdCMnlTOERuSElDY2pXNHE5Q3l0VE84ZytvV1ZLTVhmWUdH?=
 =?utf-8?B?SkFzQzN1SlluYXVhdFdXVnZYdVc2SWhHSmtPUXpERWRhNG51NkM1bTZkL1k0?=
 =?utf-8?B?bnJHTjBhdzRZalVLU3BoTUI5T01PTlY1OGlLalA2WFhxc0UwUU1oQ3BmYWtM?=
 =?utf-8?B?cDZjSTFXV0orQVBuMThIYWlEMlVDSWliSkUxQUVoQ0gwNE1vZnhsazFjUVB2?=
 =?utf-8?B?a3dGYVkyUnlQMlluMG1wQ2haTXZidkhOc2o0cmxMWCs1Zk1zSjJPTFpTMjM3?=
 =?utf-8?B?Sk44Y2pBRVZORm1XUG5UMm5aWHhSMlNvN0g3dEZyUTBMVjBkNnNzelNBOEtL?=
 =?utf-8?B?V25KbFYzUU8rU08xMHgwZmZTSkpsR0FHbDRSajgvWWtIN2M2TTNZR3JUTlRm?=
 =?utf-8?B?b1dJak5QOUh4OHAyU1Z5NUtRbFJXdUZxYStIelNjOUtVWmQ1UW9yMHNaWnhE?=
 =?utf-8?B?cGM1WDRaa3FDcGpLTkw4MkF2cG82eVErSW93T05hV0pMdnV2RWpoYjhmSkVo?=
 =?utf-8?B?V1BmOWF4eThLZ0QweVRhRi9zeHdtU3RhMWEyR3dCYkdqUkNaUWJuelA0Zjlp?=
 =?utf-8?B?cFhBU0lkWVNnL0p2TzgwUTA5SVRBUHZxUDhkWjJDWWdQNnBQN0NybzlYajRN?=
 =?utf-8?B?MkNIWmVnMTVmRmt6WFhBWW56MCs1YkhQRnpCaE42cG03dzFnS0FYSSszMHpK?=
 =?utf-8?B?S2FwcXZoSlB2bGNHZ1EzM0FVWHVlbGFvOEg0UndvbUtoTlc5dmtEQ0FZQUNI?=
 =?utf-8?B?NWtCdklzUkI0T2xXNzltTlpFc0oyQ0NLbUlQbko3elBIZzI1N0Nac25iT0RR?=
 =?utf-8?B?ejl1d05Cc21QQ2x1NDc3clhOYUVIZTdCNFh3WWJhaGRGV2dick9HellzWGpz?=
 =?utf-8?B?dE9oTjRzUTRWTmZnS0RvclF5Vk9ZM0YwYjV0eFdjM1FZc2NOWGdsdHNuUjQ2?=
 =?utf-8?B?YURaUCt3RTdTKytsNlBsMlRKL0FFd01DSzU3MnVSZHZhcjZWVFYySnFsUHc0?=
 =?utf-8?B?T2hseXBBeHlHWFBEZTRjUURKQWgyY1pzMnNkdU1NT3pJTVBEYXo1YlBGQS9P?=
 =?utf-8?B?MkVCalk0dVhxNGpTMnRMZzJxOG5lQmdxMWFOWW9seU00MksvRStkU3NOdDhn?=
 =?utf-8?B?MTdLeWw3RG93YTdZR2xpS2tEeFNVWEVFWWNNdGJtVFRyWEQ2cFVmYXRFMjZx?=
 =?utf-8?B?d0trQm9DdXZyVWdLVnhPVlJKR3hXR3hjengzUXo5SkdUK0xsc0VBRy96U0NC?=
 =?utf-8?B?RXBFMENsT1ozTVl5ZHF4Q242S0xyV3VhZkJSNmFHZFprNkxmTkJtVTZmR3Ex?=
 =?utf-8?B?U0tUb0J4Y2ZSTmdSd09ZOXJ2L1ZqRTJBbXdNbFdYbXNkTlVYNVBLWm1ya2Er?=
 =?utf-8?Q?sXHm+5lORE0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWN6TUFoT3pNOE1hQ2NxRGxETm4vZ0hETVdQNXhzQmhCVzdOQ0x4SVlBWVM3?=
 =?utf-8?B?SG5FekpKendqVkQvNHhIM0FhQUViOG5rWGZ6dm5QZjY3M2h4UVF2TGE1ZStq?=
 =?utf-8?B?L2FzSWJjRVVpaUFQS3VaVVZ1bXdLb2p3QlRUMTZRWlVyWWJIeVlmV0lrUkRr?=
 =?utf-8?B?aHFJbGl2SFFyUU44a2Q1Y3Y2VkNhWCs5Q1Jzd3pNdlluVHFQei9RZ1F6VGph?=
 =?utf-8?B?cTd6TDRMaDNGVjdxVnJ6a3BzdGVOOGsxUk45UldFS1g1SFRqVEVTVGZyOGZ5?=
 =?utf-8?B?c1pJSVRCcm9TbUJXQldaNEtObW5UbTRPZnJKalRjUjVtZVlyemppNVhWNWFu?=
 =?utf-8?B?L3daMGU4UHJ2eFdSS2plSWorRjlQZytyTnVXdEhrdGl5K1ljbldFWHB2L2NC?=
 =?utf-8?B?K1lURWRIMEVFTmpBMlVUZk96Ri90L014alNKUGVWVFI3UlBKYm5BbXl6aVVx?=
 =?utf-8?B?ZVcwN1pBa3ZkYTdPRlFhSWgrUGFHK3lINnlQWkxnU1NWZVdjOC9LOGxLdlMx?=
 =?utf-8?B?dTMwTURXenNQSjV6RVRwQ3J2bTBaZlA1Qld2eG5SSjFHTXU5Q2xTRFFZU0c1?=
 =?utf-8?B?OHZVMVRkd0Rsd3RTajdsQkV6RTRsZW91TSt0Rk9mUUNhQ3NVVzB0SmlpUDE2?=
 =?utf-8?B?bmpJbi9IT2trNHdWTWwvOXZrbVJWZVEvNm5MWGw0cy9ZZ3EvU1pHTjVvYkVH?=
 =?utf-8?B?Sjl4RjFabTFndnBsY1hYQitpWUlFWFF2ZFZwMFVublR0VGtUa1gzRjl0UXdE?=
 =?utf-8?B?QVRGeUhNMGJlMW5IamdPVzdvLy85RlBobjBKMDBiTGN6OC9XQWIrSU9JcWlM?=
 =?utf-8?B?MDVsbXUvRGtjSnpaTXlmb2NNODBHUU40bmRTM25hUE9CeXhyTkJ4c2YySDAx?=
 =?utf-8?B?SXo5c2E4L2NUWnNrS094cFUwbVJBZlMvS2dlQlBOWmdwSUg0YzRoZEhhRE5R?=
 =?utf-8?B?N29CblpVWEJSaTF4NjlzWkRYdXAvQTFJdHpSTmo4ZklTWUN2KzQ0cDRoVW9T?=
 =?utf-8?B?dk90Rk8vS0g1NkR3Z2ZMMTJJRnJWb3lsWUoxWE5xLzE2M2E3dm1tMlRkR3ps?=
 =?utf-8?B?UEYzR1N5MUY3Vk81OEI2UG9kQjl2VHdDeXNkOHNvVjR3TzRNeTdZa2VsYTds?=
 =?utf-8?B?YlI2QzJ2ZnlwMURidllmUnduczdRZXI1WnhScnJWM1d1bENQV0RvelFveG01?=
 =?utf-8?B?U2hKWVo5SHo2Yk1ob3lwSDh6bnpjSitoODlrOXNDVkZMUVA1VzBuTmt5Mmpl?=
 =?utf-8?B?Sjh3NGJIdEtiN0NSQzAvdStNcWdwZUIrYWxJOEJ3ZElxcEhVci9NS201UUov?=
 =?utf-8?B?QzJ4b3RYcGg0NEVtTGZxUzdPbkpHZTg2MUY1bFkrYXVmQVBSYitTTEd3OGxG?=
 =?utf-8?B?Q29jMGhEd2lKUHJ0bDNrRHpqbDR0WVFaYUNIeFNaZzluOXhWSlhEMGFnRHRr?=
 =?utf-8?B?Kys1Q1FmQjhBWmJVMnJ5TEhVNGFvK1Bwb2tZa3VMYTlwU2hvT2NlRHVSUDN0?=
 =?utf-8?B?MyswekNZUzF4QURFcTR3S1k3K2lNTmRZTTJpeWdzd1lVZE9vWDhFVk4xZTBp?=
 =?utf-8?B?ZTV4WXMxR0VYU0l5RWdVYkJMNlZ6NGlURTd1Mm1yNFZ6bXBqWlhxa21CMFlw?=
 =?utf-8?B?UHc1YkNDd2lUOC9zcUxRK2dxVnVtUXRBbHZ3QjhVazY0UkJwMC9UelZWZk5o?=
 =?utf-8?B?YUhwODJJdTJNK1liSFd5NjI1YkE3RzlsVTdrYm1tekMyZktHT0lWNXVZZTZJ?=
 =?utf-8?B?dHJkU1hmUUxnVVhKZWNsSzg4cFo4VWRLL2lJYjVlSzQrMDk3Ly9qWWZRdzM2?=
 =?utf-8?B?aFlrNWNER1k4U3NBKytGTFBUQmtlV2RUeVJpMHZ2a1h3QUFjSm42T1N4anFr?=
 =?utf-8?B?UXFaVDJyaEswKzhWQUEyb045RFlORlhoYzh3dk5BRjNuR0w2ZXNJYzIxVkVT?=
 =?utf-8?B?NlZHbkVtQ1djdWlKbVdCbGtjc0tYZWUzSXJuODdwSlB4alpDS0hNY2NHdXJx?=
 =?utf-8?B?dW9QeGhWRWg1a0lVMDFnNXJBODBadkN2VkVmNFowekg1WjFKaG9tMUhlRTVK?=
 =?utf-8?B?YmRDd1N5RnI3NFF6cStVYmZxU2o0SGx5WkJ3L0xhdm9qWDVJKzl3UnpKd3l6?=
 =?utf-8?B?NVgvZkViYWdxaHZsK3JSOGtpMGlPcXlvTHk5RUxpdDJNY2RyRHEwY28wc3cx?=
 =?utf-8?B?QVBpV1k3NjNnd05XbGw2WE8yaEQzenZSc1doWnp5QWxzRmVHOFZiK1pISHpj?=
 =?utf-8?B?SHJLcTVGVzMyOFdnUndkc3F5d3N3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8672c7d-c286-4168-ba5b-08ddc37d5418
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:55:20.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs4dCQa0cc9VBu3kP77tZGVVfgYaWV3vGaTb8xnB0Kiack1HdyOsz+l1xfs1kdo1GxZReZxLRlgW0ncOkxxKGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6389

On 25.04.25 18:48, Siddharth Vadapalli wrote:
> On Tue, Apr 22, 2025 at 02:14:03PM +0800, huaqian.li@siemens.com wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The AM654 lacks an IOMMU, thus does not support isolating DMA requests
>> from untrusted PCI devices to selected memory regions this way. Use
>> static PVU-based protection instead. The PVU, when enabled, will only
>> accept DMA requests that address previously configured regions.
>>
>> Use the availability of a restricted-dma-pool memory region as trigger
>> and register it as valid DMA target with the PVU. In addition, enable
>> the mapping of requester IDs to VirtIDs in the PCI RC. Use only a single
>> VirtID so far, catching all devices. This may be extended later on.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
>> ---
>>  drivers/pci/controller/dwc/pci-keystone.c | 106 ++++++++++++++++++++++
>>  1 file changed, 106 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 76a37368ae4f..ea2d8768e333 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/msi.h>
>>  #include <linux/of.h>
>> +#include <linux/of_address.h>
>>  #include <linux/of_irq.h>
>>  #include <linux/of_pci.h>
>>  #include <linux/phy/phy.h>
>> @@ -26,6 +27,7 @@
>>  #include <linux/regmap.h>
>>  #include <linux/resource.h>
>>  #include <linux/signal.h>
>> +#include <linux/ti-pvu.h>
>>  
>>  #include "../../pci.h"
>>  #include "pcie-designware.h"
>> @@ -111,6 +113,16 @@
>>  
>>  #define PCI_DEVICE_ID_TI_AM654X		0xb00c
>>  
>> +#define KS_PCI_VIRTID			0
>> +
>> +#define PCIE_VMAP_xP_CTRL		0x0
>> +#define PCIE_VMAP_xP_REQID		0x4
>> +#define PCIE_VMAP_xP_VIRTID		0x8
>> +
>> +#define PCIE_VMAP_xP_CTRL_EN		BIT(0)
>> +
>> +#define PCIE_VMAP_xP_VIRTID_VID_MASK	0xfff
>> +
>>  struct ks_pcie_of_data {
>>  	enum dw_pcie_device_mode mode;
>>  	const struct dw_pcie_host_ops *host_ops;
>> @@ -1137,6 +1149,94 @@ static const struct of_device_id ks_pcie_of_match[] = {
>>  	{ },
>>  };
>>  
>> +static int ks_init_vmap(struct platform_device *pdev, const char *vmap_name)
>> +{
>> +	struct resource *res;
>> +	void __iomem *base;
>> +	u32 val;
>> +
>> +	if (!IS_ENABLED(CONFIG_TI_PVU))
>> +		return 0;
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, vmap_name);
>> +	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	writel(0, base + PCIE_VMAP_xP_REQID);
>> +
>> +	val = readl(base + PCIE_VMAP_xP_VIRTID);
>> +	val &= ~PCIE_VMAP_xP_VIRTID_VID_MASK;
>> +	val |= KS_PCI_VIRTID;
> 
> While it has been stated that we are going to start off with a single
> VirtID for now and extend it later on, is there an example for how it may
> be extended? The only option I see is that of associating one VirtID for
> Low-Priority (LP) traffic and another for High-Priority (HP) traffic, in
> which case, it might be better to define them upfront and use them like:
> #define KS_PCI_LP_VIRTID	0
> #define KS_PCI_HP_VIRTID	1

Sorry for the late reply, was just reminded of this question:

When trying to design anything beyond the current use case, I would be
struggling right now with the how, simply because we would have no user
of extended APIs around to make sure that the result would be useful.
Can you envision such use cases? If not, I would rather suggest to
postpone any attempts to broaden the API until we have such users.

> 
>> +	writel(val, base + PCIE_VMAP_xP_VIRTID);
>> +
>> +	val = readl(base + PCIE_VMAP_xP_CTRL);
>> +	val |= PCIE_VMAP_xP_CTRL_EN;
>> +	writel(val, base + PCIE_VMAP_xP_CTRL);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ks_init_restricted_dma(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct of_phandle_iterator it;
>> +	struct resource phys;
>> +	int err;
>> +
>> +	if (!IS_ENABLED(CONFIG_TI_PVU))
>> +		return 0;
>> +
>> +	/* Only process the first restricted DMA pool, more are not allowed */
>> +	of_for_each_phandle(&it, err, dev->of_node, "memory-region",
>> +			    NULL, 0) {
>> +		if (of_device_is_compatible(it.node, "restricted-dma-pool"))
>> +			break;
>> +	}
>> +	if (err)
>> +		return err == -ENOENT ? 0 : err;
>> +
>> +	err = of_address_to_resource(it.node, 0, &phys);
>> +	if (err < 0) {
>> +		dev_err(dev, "failed to parse memory region %pOF: %d\n",
>> +			it.node, err);
>> +		return 0;
>> +	}
>> +
>> +	/* Map all incoming requests on low and high prio port to virtID 0 */
> 
> The question I asked above applies here too. How is it planned to extend
> support for multiple VirtIDs, if not on the basis of assigining one
> VirtID to LP traffic and another to HP traffic? Since we have an option
> of using different VirtIDs for LP and HP traffic, why not use it? Is
> there going to be an issue with using VirtID 0 for LP traffic and VirtID 1
> for HP traffic?
> 
>> +	err = ks_init_vmap(pdev, "vmap_lp");
>> +	if (err)
>> +		return err;
>> +	err = ks_init_vmap(pdev, "vmap_hp");
>> +	if (err)
>> +		return err;
>> +
>> +	/*
>> +	 * Enforce DMA pool usage with the help of the PVU.
>> +	 * Any request outside will be dropped and raise an error at the PVU.
>> +	 */
>> +	return ti_pvu_create_region(KS_PCI_VIRTID, &phys);
> 
> Same as above, we are passing a single VIRTID and not an array, so it
> isn't clear to me as to how it will be extended in the future.
> 
>> +}
>> +
>> +static void ks_release_restricted_dma(struct platform_device *pdev)
>> +{
>> +	struct of_phandle_iterator it;
>> +	struct resource phys;
>> +	int err;
>> +
>> +	if (!IS_ENABLED(CONFIG_TI_PVU))
>> +		return;
>> +
>> +	of_for_each_phandle(&it, err, pdev->dev.of_node, "memory-region",
>> +			    NULL, 0) {
>> +		if (of_device_is_compatible(it.node, "restricted-dma-pool") &&
>> +		    of_address_to_resource(it.node, 0, &phys) == 0) {
>> +			ti_pvu_remove_region(KS_PCI_VIRTID, &phys);
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>>  static int ks_pcie_probe(struct platform_device *pdev)
>>  {
>>  	const struct dw_pcie_host_ops *host_ops;
>> @@ -1285,6 +1385,10 @@ static int ks_pcie_probe(struct platform_device *pdev)
>>  	if (ret < 0)
>>  		goto err_get_sync;
>>  
>> +	ret = ks_init_restricted_dma(pdev);
>> +	if (ret < 0)
>> +		goto err_get_sync;
>> +
> 
> Shouldn't the above be moved into the case for "DW_PCIE_RC_TYPE" below? Or
> is this valid even when the SoC is configured to act as an Endpoint?

Fair remark. We currently have no setup for EP usage thus cannot even
say if it would make sense / would work as intended in that case as
well. Probably better to move then.

Jan

> 
>>  	switch (mode) {
>>  	case DW_PCIE_RC_TYPE:
>>  		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_HOST)) {
>> @@ -1366,6 +1470,8 @@ static void ks_pcie_remove(struct platform_device *pdev)
>>  	int num_lanes = ks_pcie->num_lanes;
>>  	struct device *dev = &pdev->dev;
>>  
>> +	ks_release_restricted_dma(pdev);
>> +
>>  	pm_runtime_put(dev);
>>  	pm_runtime_disable(dev);
>>  	ks_pcie_disable_phy(ks_pcie);
> 
> Regards,
> Siddharth.


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

