Return-Path: <linux-pci+bounces-12411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4448963D46
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 09:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605821F22E6F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 07:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA161487D1;
	Thu, 29 Aug 2024 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oHpyCG8h"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D99D446D1;
	Thu, 29 Aug 2024 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917143; cv=fail; b=ZZAyADc7C24IX+N2QutMPAmw0sh9s9+qmfnkenOg5sxGiB9cn1opkCuiYIm6t64v8qQKrTrVTX50cpFTJFHZcCWJNeVqSJ7vEmp5eCTjNp3qWfPpYlEU/JrceEnPLCKG2sgSExCFJHh3SfpoT3jLcdVQhwZRKNVrPUEsYoWlOoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917143; c=relaxed/simple;
	bh=MQLqrY/6j/YfcKiTJ+NmMmxD7bFEyGoVlMZ9E5oIQOU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hkzClMGQScoa400T4CYKQg1YMRbnEmzTGe8Cb1tbLQhTmnV4aKk9BypizkUmMfM7TauPBxFUAFQWfXgXbGDFvU2oVqhyHkBgGduP07qrDIEPHLgL6/8w3dsxntqrjuLkAWLYCXeLvOvqVmqqZQ9EUhJd5bGlpBMfQyuLH+BbqOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oHpyCG8h; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqOvL7jjVNRffX3l7ntziNIZC4SP7HN65/I0e0isML6ulQi/3OewXTiC/YnH2hXbnpa5+Qiuf1qZoHfcjUSp6z47uadwF4UmTLd2sCri5B5uqr+fAbIwRg/H8fd8dGqjLi30Q8OErCEXp7FQx6TiCrnKN9qSVsO0eSfzN875ZGzun44RTDFlTux7rmPHn0MmBFdGIEEhSgSYDmzLTjjIsWuDZ/jBpzLQTM87H6UaQ38390RRId6JcrXN41R5WS/0NmtX1eUnbUgVrY5pMuxxirwPHZNyLwnKnuj/WVqYhis5tCrON3oocim13UKcf76ecXGLwwDK7ZN8iMSv7Cne+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkIeePlUQZRhpEX1YqJSCIS8mGtBfUQxv3gAxAaRTzM=;
 b=xtZcXlkCD5VjAfoAOD0mATTnre8ooPqFb+fwmtT6iw66m3rpxitD3a7xqCgQykDifXzitcWzL3CosFnEAk39+8svB7F5k6gaXNEiNcCx2JphDNoUGK6s7nxKr4RXwu0hxIP3eqPXDHlBarit+949EqcDzXo/5YZpfDgLgmEepjbhQgJncoyLvEczQYggj/4HMTQOX6aDIw/kkfp9VKn56kHu/SD7cqt7lZZqjyLWAttK8KiJcr4CaTdbw+fgmTl45a2fciGjc0XRdKuDDsFp+ewFb2xoGx37I8lHH5wdGQOj5NX5wcbsik5srFCVrsX7YDmbUFN8rNagZaYKC3nnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkIeePlUQZRhpEX1YqJSCIS8mGtBfUQxv3gAxAaRTzM=;
 b=oHpyCG8haWfWhMdyCb60at9EJdEnpFM1gTTkker46SVBFDGmk8qu+Y2qAihtMr8JL39gIoCoWVVh6wFtHjqP00EaWRMLYT45dNSBcSmolb04/HJWgBmmERVn+igLjEd+WBTqZoNj6W68cYCI4hRqjE+0CR5++EBr8h7jxs/yeiAnucZYDZit3/zBQMa40Wsqp//GTwQGMjjOd+FYGPdNxO6O7M8ns97zIpMF9VTnxx7qWOzGGPs/QmrvmFi5Q5fSdx0UCplohHshes84jXmFAPyB1hRh21pOoRrc8spsGtQkgU72sm65F3v8RIbXFerdIo00HLrg87AcxIbjHIlafg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS1PR10MB5529.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:474::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 07:38:57 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 07:38:57 +0000
Message-ID: <df7d3134-302d-45ed-ba72-b5473ac5e3aa@siemens.com>
Date: Thu, 29 Aug 2024 09:38:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Bao Cheng Su <baocheng.su@siemens.com>, Hua Qian Li
 <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1724868080.git.jan.kiszka@siemens.com>
 <752fb193661bb5e60e5aae6f87704784cbad145d.1724868080.git.jan.kiszka@siemens.com>
 <2tc4eistthjifxsedwux3x7c52xlhkt5d3h2pcbe3glzzga6pg@bvbbsghc57zu>
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
In-Reply-To: <2tc4eistthjifxsedwux3x7c52xlhkt5d3h2pcbe3glzzga6pg@bvbbsghc57zu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS1PR10MB5529:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fa4793-9ace-4b3e-78e6-08dcc7fda438
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0xNSGQ5UytPS1piZmNkWEpzVXF0RDg5L0JEYVl0d1ZDMkVrLzdTUEhMYlMw?=
 =?utf-8?B?OGkyZ2pFR0srYU1PQjFlL05vc0xQWksybEZ6WTNVbVcrTGpBZHNBVWhMQUFN?=
 =?utf-8?B?UHB3cHR3czVYcGUvYmsyWDVlTjJ0dzZpNWlsL3pmNjhOTzk4S050TzNZYVNZ?=
 =?utf-8?B?ZWNpd3pibDFnMENSVWpDT2dYL09hQjJnMmF4OGs1dnpsVVJ5ZmhQTGRZelVB?=
 =?utf-8?B?enMwWnJQZ2pkUHVCSHpXekdHSjhDWWhsNk1BbmowblNTSmdVK0c3YXBweGZo?=
 =?utf-8?B?NEk1NFlDOCthSStCeXRNc3I4RDlDMFhsTFl5bnplbjA4NzlvSGcrSWRteDJM?=
 =?utf-8?B?emFhUUQvU280Z1FkNUcybDNhTTU0eUVKM0hjTzRMOUswZC9BU3QwbWVuTHBQ?=
 =?utf-8?B?R0hDTDhtMTZ5TDJpWXJPd2JtR05YWTJRM0FveVpWYnZydm55YU03dWtsQlp6?=
 =?utf-8?B?OHlGU2Z1dkRHQ0U0eUJKQVZpbTU3U0hYcFMxRXMySUlaeXFXeTdYdFBsWUVU?=
 =?utf-8?B?L1Jna1FyejA5cURlUkdKMUF2bTBRSFRpT08rK2lzbStLZitZV0dnVU9xNmYv?=
 =?utf-8?B?YVJhTlBDcDZpYVlUNkp5VGk4Qnp0Z3lpekJmeEk4Nzl3SGx6cXNPalUvcWRm?=
 =?utf-8?B?QXpDRnkzSjN3UklGRzRJdmcyYXpNdVA0ZUVUYk9XTWUzbmxZTHY3SXVKUlRX?=
 =?utf-8?B?ZW14dDNBRy80b1RZRzZlYlhwRkZ5YlZWeWRTWWpxei9ZRERMNDZhcXA0RFZ0?=
 =?utf-8?B?UHJoY09WazdyYVE4WEVHenNWTFRuT1Rvd0ZxalJucDFnSzBtQ2ZXb1lNeFFa?=
 =?utf-8?B?dCttQS9ma1p4MTB3UW5iSStIK3doYjdyeDcveUtuZGZ5UmF4M1NsYUF0Ukhu?=
 =?utf-8?B?ZmVsM0crc1Y0VGxFY0dQb1N3TnhRZEh1NXpmNnQvb0U4dXVHdEpqUXhnT1N6?=
 =?utf-8?B?d2tRZHpsbUtNamkzb3Aya0QyN0VUajJkMnQwenFsSk9HNWlqSWZvd3F6QTdW?=
 =?utf-8?B?RkRRMlpTV3ZFMFhCVXYzUTNIUDF3RVMwellqbkQ3RzRWWlJmSU9iMU9SckpP?=
 =?utf-8?B?VXBZOUJBOUduWDd5bDQyK0lmUDRZdWNkRWJlTkJObEhmSmg4amRtQ1JzbTJV?=
 =?utf-8?B?cVlGbnVjaGxjZ1pVTjVLK1JaMHlsSm9CSXBFakxWZytVZTQyWGgrVFRjOGZj?=
 =?utf-8?B?KzJPMlB4TG5BYkFCMjhKWmhyajRoMWxPaFhaNWwyekVGbjBOb2ZSR2JyOHpL?=
 =?utf-8?B?aUNCOGdhOGNxSWh3ODNLZUNxUzdvMXYzRkNBWHBINUZtRmV3M01DKzI3SS9D?=
 =?utf-8?B?YVRCVnc4TEIyR2wxYTRmTDZlby9Kbnhib2NteG9qS2FJT05pb0hMcUxvNC9Z?=
 =?utf-8?B?czZ5TGRORmwxZ2RRVXp3clQwZnBOZkVWanhZa0JkNnJxS1dZMGxCcnFaUnpN?=
 =?utf-8?B?b1pMV1ZwTm5lZ3R1SHdkL05Rb3J2US9mTlh2ZVdTREwxNi9vT3BWdElndjBN?=
 =?utf-8?B?T1FlalRMVDV5TCtOQVlpSnZKS1dvT0c0SXR6RTJlcEorQUhtMmV0MlBocmdX?=
 =?utf-8?B?UXgrYzRyQWVQclk0emFQejNxVGlxRFlSendPc1JUNk5CZWJZdjZYL0ZOQWdp?=
 =?utf-8?B?QzJNZ3ZoTGN0RmlYRmtVbytjUVdPT1owd2RtSUlmYU1GU3E5aWN0YzJFbzFP?=
 =?utf-8?B?aTdicGJCRkQzL1VlZGx1TkNwNXpvTHZFSG9rbXcrVy9xUWZpWjVUVDd1eldR?=
 =?utf-8?Q?bliwnDW1433RQrlfwI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDNmV1dBRGtEb29XTWpZeklGNXR4anh2MFhuTVh6ZmJoeDAwMXB0K3pqS2d3?=
 =?utf-8?B?NW9uTlJJd2RhTU4zdFlLY0VrS2RIRWx5QWxnKy9taldRUWw3ZExvMTdyeTJz?=
 =?utf-8?B?b1lkWGVjcS9GK3pEbkdURVpXNUNQdTNURWdvRmk5QTc3ZGNLVEZuaE5MK2Zv?=
 =?utf-8?B?anBXOFhmM3lMK3ZxNUNlQmZhRXlHay8rd2NpL3dJVUN0VjVCREpDSWNNUzdH?=
 =?utf-8?B?bkN4NmhFaCtmUFZDRzZaaUdnelhnd0RHeXEwUXVUSE1IdFRiY1AwOGhvWmlV?=
 =?utf-8?B?amFjWEtNbkFwMUpMaU5XUXlMK1FLWGlMdUd4aUp5Z2hUMmpFYXRzMHI4Rzdz?=
 =?utf-8?B?TTQ1NU1iMzdkTmJMN0hxdWxMNE1xZVY3Y0VEVno2MCtVUW9kUWVlVTFFNy84?=
 =?utf-8?B?VW1wQTRtTGJzeFBuYzV1SHNnNHpjUHhuc3kxazMzWklORlI3SGY0Q3BnbDYv?=
 =?utf-8?B?cTRjdHptaTB4bWNaaEVuMWkxRjNLV2hzK0QyN25TeG9FOHJqWTd6amtOWHZt?=
 =?utf-8?B?NnR3dVFWTjlKVTVsK3cvcU8zQ2U2U3pnano5QmNtSHNqSFRYSzVRbDBKYVlX?=
 =?utf-8?B?T0hzc055Z3A1UEhmMnZMRWxGTTdVdktpL24xbkxJVmtIc3RyRVNRNVkxUnEx?=
 =?utf-8?B?WkFyU29RNmZNWk5kTnNPa250MCszeUZjL0RGSmVsR3NXNmNkY05NL24yRUtV?=
 =?utf-8?B?NzFmTWIwaHQ0RGc2V29PZGZlL3h6Vy9TbTQ0T1NFRGxNM2ZSVWIwV0MvZ2gr?=
 =?utf-8?B?dmVNVW1WREY1N1YxK2wzcjFQZFNSL2x2YVA5L3lkT05odE10K21mRXRpWWU4?=
 =?utf-8?B?bU1ZM2xnZnE4TWpSSWdBZXBJeG16emJRRE00NDlmTE4yZFBMOHB2QnpvdWQ1?=
 =?utf-8?B?OG9KOVB5UUJ6Vk5wS2c0QVl4L0o1dzBjQkgvNExWKzRnekhER0VNd0NGZFNK?=
 =?utf-8?B?SkwwVTd3aElKT0ZoSzk5akdOTWd4em5xc1N3SjRsNHIvci9ub3U2NHBXTnNy?=
 =?utf-8?B?dGg4OGZta0JoeEt5NTdSOWdURHpoZnNsS1RKNm9WNENncjRUdnhUcGJRTVRa?=
 =?utf-8?B?QjNxWkpwQ0JiMFcrMGRZZGExK2xZdkFOdkJnSlhSSnpQUFFsOXJBMzNBMU41?=
 =?utf-8?B?TU5oVFlxODR1TWpFaXk4UVZLa0x5V2VIZlJGWXhmYmUyMkJKV1d6Wm1pSnh6?=
 =?utf-8?B?SU1obFd3ZCtqQ0V1aU03M21WYzlwUDVRU2piamlnb3R6cjEvVmozV2xlZ2Ft?=
 =?utf-8?B?dkJLZ3pON2FaOVJCdFFKTDFaYzF4Y3JrZGd0c2xqRzFSMFo0cU8wMHRWUjBo?=
 =?utf-8?B?bzBNbDdpMGtxZUhOdFUvVjZvSkx2NFk0TWY3dGlVdTlxUnJVSTJTdC9mR1Nn?=
 =?utf-8?B?bUNTZVZCWDBlT1JyRHJGZTJIaStkem9HMmJMemd0YlBPSS9FS3ZTWXAwaTVR?=
 =?utf-8?B?MmYzTlF3UGJKV3MyNVMyd2JRQ1pjYUxya3VsK0JWUTFnaEErekgwQXpMS3lY?=
 =?utf-8?B?dDdDVDRleVhVeFVHSU9mc01EWEcxbWtZWVNJMU1yUmU0MXMzRS9pWXZ5Ymoy?=
 =?utf-8?B?LzZvbGhmZi9uNFBJTEFVUDlnUEFBaWVDbHhEeUdzeHAzVUNzdTgzVU4yS1VG?=
 =?utf-8?B?Z09zQ2RtVGRIc09kUUp1UWFpUVFnQytOeUNkbnYrUldXNzY5cUpjZTAxbFli?=
 =?utf-8?B?V1QvRUlLMzB1cUlSQ2lWb0lFcUlOQXVncjZrVG02N0drR3FRUFlPMVdMaXhT?=
 =?utf-8?B?b3BNY0xYa2psQUFiTEo2L2VNajhZaWU1MVprdUwyWkUyak1xRkwvcDFlMTk5?=
 =?utf-8?B?RDdIUTB2QUtDN0pOYkRUZFNqd3Y4Y3JyN2FReWVHRHh4bUZKNnI0WkZtU21X?=
 =?utf-8?B?bTlZdG9TOTZER1VSYkVSMVRBOGRUNGRENml3WVJiUW85V1B0emZvMi8xcktv?=
 =?utf-8?B?ZlhmaXN6T3ZHQXVmdmVrellqMTJ2ZFZTQldsd3YxN0V5VFlIcVA4RGxBZFY3?=
 =?utf-8?B?WU9wZ3QvN0M5SHJaMS9SWWlGeGlZeWxKbmkvUXdSM0RoakxzdmVWU1JnMVNh?=
 =?utf-8?B?aVlQVDdFcnJWTysxZGkyMWlWWE05czBRWGRhemJTOFV3M0NHRUhCdVNpZ1B4?=
 =?utf-8?Q?KTekalnyWe+hLQ/Mbvmo801Ct?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fa4793-9ace-4b3e-78e6-08dcc7fda438
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 07:38:57.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8hFAs6K3frP12r8OBf46f9LQcHicK6fxwVxnppjICXPnR0xZFtUkuWPzF345dmYAbGrfA2xlvR9/MrezWkcXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5529

On 29.08.24 08:14, Krzysztof Kozlowski wrote:
> On Wed, Aug 28, 2024 at 08:01:15PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
>> to specific regions of host memory. Add the optional property
>> "memory-regions" to point to such regions of memory when PVU is used.
>>
>> Since the PVU deals with system physical addresses, utilizing the PVU
>> with PCIe devices also requires setting up the VMAP registers to map the
>> Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
>> mapped to the system physical address. Hence, describe the VMAP
>> registers which are optionally unless the PVU shall used for PCIe.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> CC: "Krzysztof Wilczyński" <kw@linux.com>
>> CC: Bjorn Helgaas <bhelgaas@google.com>
>> CC: linux-pci@vger.kernel.org
>> ---
>>  .../bindings/pci/ti,am65-pci-host.yaml        | 52 ++++++++++++++-----
>>  1 file changed, 40 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> index 0a9d10532cc8..d8182bad92de 100644
>> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
>> @@ -19,16 +19,6 @@ properties:
>>        - ti,am654-pcie-rc
>>        - ti,keystone-pcie
>>  
>> -  reg:
>> -    maxItems: 4
>> -
>> -  reg-names:
>> -    items:
>> -      - const: app
>> -      - const: dbics
>> -      - const: config
>> -      - const: atu
>> -
> 
> Properties must be defined in top-level.
> 
> https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> 

Tried that already, moving the else: part to top-level, but dtschema
(2024.5) checks fail then. Could you explain why?

>>    interrupts:
>>      maxItems: 1
>>  
>> @@ -84,12 +74,48 @@ if:
>>        enum:
>>          - ti,am654-pcie-rc
>>  then:
>> +  properties:
>> +    reg:
>> +      minItems: 4
>> +      maxItems: 6
>> +
>> +    reg-names:
>> +      minItems: 4
>> +      items:
>> +        - const: app
>> +        - const: dbics
>> +        - const: config
>> +        - const: atu
>> +        - const: vmap_lp
>> +        - const: vmap_hp
> 
> This as well goes to the top.
> 
>> +
>> +    memory-region:
>> +      minItems: 1
> 
> Missing maxItems and this must be defined in top-level.
> 

As explained (and documented), there is no maximum. And this does not
apply to ti,keystone-pcie because only the AM65 supports the PVU.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


