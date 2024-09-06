Return-Path: <linux-pci+bounces-12874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902F996EA19
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 08:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE7B1C2346C
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 06:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1444313BC0D;
	Fri,  6 Sep 2024 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="f4LuCrhc"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76F27450;
	Fri,  6 Sep 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603898; cv=fail; b=q9Klbtdg4wU1zRR0u6cpCyUEHm57rtvRTLDsqjDent2MrzpozO4s2honhKY8Yc7Es63FGk2a/ZEwNp1vGD4Nd6DrRMGj7dZH3vE+grtIgfZkflYlNl3RH+LHAa6CdmgkdwZlgEuPMrBb7aoJacdAskYtGLYQowoGi8MKN5/q47U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603898; c=relaxed/simple;
	bh=+mHEASn3D/LMlbXjHvcFcCjxUdYC8YoD4HXevw0FYSw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QwM2yT7ixzy7D2onbvsV0bF71D06B+61PnY9m7ikjlAf99eg0FxqyRrN5GiM89ItZPuB9Zk89fMrZyLdM0RNo+PtFkBqmtxbnUc6J2JesM0ii4SQ7jy37sdLWZMddplKW2qJuUFE1Bu5akpif8WJb2SsiKx+NVPqI6kO9LpcF0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=f4LuCrhc; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7JxLA53CvNiXQuV8Uyn1FXahktdh0hi2MsbMLrUmAmVj4KY9Xj/aGx8MvH2NuL3ZA/oMedabaCN4TeUPuiW8jOZ+dl+fWZE1PA755Nbh8O8eARBwyz4RKsReUa+COHkRIvRQ0fwLHFR1+NHRQyYL+Q+1H9Gr2UFKW/hmpCD97GxJ/u1sH9QaoNtrzVMTG28A0xFCtQ8e80Ak5+BJ8Cl6WD590avghTTjvDpGvxhCDZ8jbZYuHZFLVa/HfnbG1zeeKGfXoUfdny3WPmGkGfEjlBT2t31Aw3CasutLSKiLwmOGi+uzRQ35sFyvhraOZjWhZYKy0hF6TmgyxBVODTLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wl1gdL3OuOVAXP5cUuFqrq4X+3kPtMz5+bduqSYSbhM=;
 b=NS+EIwBLYRJ5YoL+1cVHVHZWKUGQueLScJfoI56xikS2z+63zkjWbFQ4O/pXbQa7/xgz2K90lYpJH2qrv39LhFmTd9NGbRRU0diH8cCFk8fRk8nV37wdP6g4Mwu3peZZ3K5i7r4uj1LufBnFxSTNOPkKxuUNT3/GUgWvYw/4jeG0enEGz/eVS/S0BBgSJuEDzgKq7kwmOyHw9D+sfrvkeJpc9feylhfoRU7eMjZlxZ3cMUsaeJJt8/5AOuaPmbLvquGMXbqzxtN8iGPltxnbj39DXH1BLWJvxQWeLwpfB56jBxERo8kLtwRtdQeKrUiOTLba1Usaz3CqLBkUHGMuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl1gdL3OuOVAXP5cUuFqrq4X+3kPtMz5+bduqSYSbhM=;
 b=f4LuCrhcy6b3vjDoMPXL+WjBEGx0T6tiPxObj+SERApf2DlJfgKwexQWP5xILes8eRKkSwbVsDH6dk+f4SrDfzFLL4LRMq/avxdlzG4genSaS60tIZYlUb8+o2yC/lS4VN/98xSSctY7mhAx7aOSYa48IYJnJsRBxPdHrkfZn4AgNLb8+bjLBCEF0Tkh2sDnqn0T2upQPCVLqqQgpwvUVn+oVVz0xzmOtAnvh+9mvTTk1XHByNnoPoVqw7UQwu3TQPiYho5OQouQgDRE/pYuul5m/4T6UM90WY1w7Rcig4Iz3u3DB76O4hdJphgL1HjqcFdZWTeD+G2w1AytqyZE0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7851.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:645::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 06:24:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 06:24:49 +0000
Message-ID: <c3e7aeaf-fe34-4ddc-9086-872096228986@siemens.com>
Date: Fri, 6 Sep 2024 08:24:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] PCI: keystone: Add supported for PVU-based DMA
 isolation on AM654
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
 Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>
References: <20240905163329.GA389144@bhelgaas>
 <35b5f0ff-50e7-42f9-8b66-b967476dd6c5@siemens.com>
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
In-Reply-To: <35b5f0ff-50e7-42f9-8b66-b967476dd6c5@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0275.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d38975-671e-4952-85b9-08dcce3c9bdf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3pZbFFUU05BZjZxV29GeU1na3pFSExHVmNiS1V1NGM3SUVWajVEVjd0NGFp?=
 =?utf-8?B?QnhHZ29WNjZlL0IzSk1ZODkzWmJjZHY2NVB5UkZ5YVBJQUtjcmRuaVQ3ZDhr?=
 =?utf-8?B?a3lTbWU2Qk9NMEw1aU9lamNpNkx0NGRqVG11K25ldWtDamFuVVhmSkUzbGtv?=
 =?utf-8?B?djlIUjZ4dFJxdmlOS2RKYUVhMCtoRGprbFErWDNsei9LcDNSL3BWRS9ubVFG?=
 =?utf-8?B?Y3JVd212RkpjMHl4UUExNFk5R3o3VG1CbTA1NGpDUmtVajNHU0RmVkRpRHlL?=
 =?utf-8?B?ZWxLblhVQTJkQ290VmNkSko3TlN2TXcxYk14TUZ4ZmJFR21Vb3ZWeHkySVRh?=
 =?utf-8?B?emdVZTV4czcwWWJRRFBZb2MvNHIzOXRuN2grb2RDUnlRakxoeTV6U0NEenBG?=
 =?utf-8?B?TVEvOXhKbWpVVDk3N25YY09FbGIxdUJaR09RaWlVUENCallRRk5ZUWxMbW5C?=
 =?utf-8?B?azhmKzNXRkRiVE1KdjlKaVY3eGV4L1BBV1ZOMmM0YjRpb1pqYmM3NkpmbjhE?=
 =?utf-8?B?ayttbUUzT2dwVnprb1pHeHkwV2VicndVYldMMC9SbzJnTCtzRzB3SjZOL29s?=
 =?utf-8?B?aWpFUmV1cFIwb0RUcUZ5Q3dyM2xHWDc1M3JYak53OHNldDBzRGpvcnJScVNB?=
 =?utf-8?B?TGFpYkZkQUdtenM3OHZ0alNlTnJrM3hyZncvQ2tQTGlLREx3b3VIYVFqRDBE?=
 =?utf-8?B?MXRtVko5QVBPMHpUR0tCWGRYZUVsbTVyLzErS1pxSW5CUWJoaEc2UUlZYk9R?=
 =?utf-8?B?OTkycTBoajZhVkhXKzF0alowa0Y3bnFlN1R3QWJidXZIdzd0TGU2WGpvT01Y?=
 =?utf-8?B?bUdzQVlITWtRNVVKZjJQdSt0QlNRenN5bVJ4QUxNRG5OSWlkQ2pVazZxcXRP?=
 =?utf-8?B?WjFiejFoQ1Y2TGdPcWtVbjVHN0E3RkwzeW5nWmNIdmh1ZlBrSTF5NDNoTEVh?=
 =?utf-8?B?UmlwTzB1UEpQNTAzcjZWek12c1AydVQzMm9sOGw3ZmJzd3NwYUtNOWFBZkJy?=
 =?utf-8?B?SnFuQlJVUWJIdjJLQ2VKcU1BTmgxWkdrZU0xenRsQ3c5SW1mZUxwNWxOdzJy?=
 =?utf-8?B?ZXNhMGRWN1ZCMGtra09PNjA4MnpYeTA5TjZaRjAyR2hrMi9mZjluM2tENVJM?=
 =?utf-8?B?Qm5ldTkvMXNwcFk0TGg0Z1BCWjkyNlVSdk9pUXhVOFJ5MjM4R2wveU1BdnVS?=
 =?utf-8?B?Tk1tTDJNa0dGbU9zYXFYSXlpbDRydDdNbnM1U1Z0R2hIaWIySC9rUmhNbkpX?=
 =?utf-8?B?TURpYkVWcmtsWjJrekVJNW1NcGM4U3MydFpta0lSTHQ3SlF6ejZQZzNpTURE?=
 =?utf-8?B?ZjJ1SFNPQXVmUEhsdThaOXUvcWp6ekp4enNIT2VaTjVHTHAxZFc4Vjgwb2tK?=
 =?utf-8?B?bnVEZHdYdUhlVjg0U25DMXV1Qld6Q0o5c281aWsrSXdpQklPUUFoNm0wMWdP?=
 =?utf-8?B?MTIxNEpQT1I5eVZvQ2FnaTduV285WEZIL3Nnc2gzOHkxRVUyaDk1U2F3UlpJ?=
 =?utf-8?B?ZU4xakR0aXJnc3hVQkVObTFxVHdlZllJNVVlNE9XWFhycExTNjJyK0tlSE9h?=
 =?utf-8?B?NFdrQmFMSjNtUXNTazFPVlVSeTZkeWRnWXJNWG85NUxoaThzNmlsSTdEeE9P?=
 =?utf-8?B?dG04c2g5Q2V1VVRCMDdSdFB2eHp1K3EvcWxxVXI3YWl6cXpVQ2dNQjRTVFN3?=
 =?utf-8?B?Ly9VYzRtdmNvU2NZOFc2dy9DbnlNd1ZINGFUK01oZ2hTSlFGUkorY2M1REpF?=
 =?utf-8?B?ZWE2QW5ucFVXWEh0NEJxSXJqd3pTdFVGTWhXaGFjS1FqUzZHMGVvRWRsQkNN?=
 =?utf-8?B?QTlqeUJvZElNS0tWMmlIUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b09NV3ViVDc0d2Mxa3d6cEdsaDdYV2kyay9ITXltQ3E3a053TUNOZnpTYTRQ?=
 =?utf-8?B?Wi9zTkJKRjcybTZLU2V2UU9HTWhrNWdsY09OYmpaRWJZVEljYmFYN2trZkNt?=
 =?utf-8?B?MXRWcjBRVGM0QVJBVmZCUFFDcE1kWjE3RTArOSt4dy9lY09ib0cyeUY4bnFQ?=
 =?utf-8?B?aHplWC9qSEZ6dXdlM25tc2hPbzFIeHRQeGl2VmZuNExkMnc0V0Z6ZUZpMGZi?=
 =?utf-8?B?cmhzTmM0SzAzUmhhZzF3ektYMkhtbFExSDZzUm5vOU1SZjhWVFZ6MjRBcitE?=
 =?utf-8?B?bGhoY3ZMaWJENWtGeEhXRlR5MEtKd29BUTd2aXA2TEh1M0tNZXduOUZKUGhR?=
 =?utf-8?B?bHBVT2psYTVKRWo0eVVuZEZmV3NIWjUzYlFmMjQzNEg5SG5WQ0E0Yi9JbUdm?=
 =?utf-8?B?NSt2aTRWY0x5clR3MzU3bldxNG16eGxUVGtnRE5NYmdNZDl5QnZwbDBFNFBk?=
 =?utf-8?B?T3hqa1RCaE41bWFEb0kveHRNSU1JeEhsOXRFcGJNN21laUdQN2REVHN6Rm1I?=
 =?utf-8?B?QmE1ekRBanVDQ2Z4QWozbUk0UUhNb1A0T3VVNG9POGI5MzcyY2FzMktiMmxK?=
 =?utf-8?B?ZVlPRGtJNlROdGNyK2s4b1dJSTJDYjNZY1d5SVdrTGl0NEEyeW40SW4wWXZo?=
 =?utf-8?B?NEdjR2xUWW9aR2QvZ2ozcTZUdUhjNXA3UkRrMUdDWk5WY0dVK2lBZS92TmNC?=
 =?utf-8?B?cmlINFZDbHhyOEE2bW9nTUF5Rk5HQ0tKejcydW10VW41RmJ1Tm5mME9YRzZv?=
 =?utf-8?B?bWUrYmpoQmpYcTgwNlBkc0tNRUhPWHVvSDlYd1laK1AweDVVMUZ2RHcyMlVE?=
 =?utf-8?B?RnE2WFp1Kytoa3pUYWR1MlhNbmh0eWp5WnNJb1lDRTVxT2FBRHUzM29tZ0Yv?=
 =?utf-8?B?NmJadFFLalZzMnlLUWJ3UXlCVEdpRFZXWWhBTlRqcC9CeTZNTTVwSFRtbWZ0?=
 =?utf-8?B?UWwzTkxXMXNwaGp5Yzhsc3BmNWxQM25SU2Zjdk1SaEJyQnBsV1E2OHNjS2Vz?=
 =?utf-8?B?eFovaTFHTUdDL0xaaFdURmFHL05oNk5SWS9UaGVhS3IrZWViOVFYaUNXeW56?=
 =?utf-8?B?ZWNmSkE0WG94V2NBTVFsY2JNRlozaEpOdXZ5a3lNTThCYTdDOU9BdlNUL3hH?=
 =?utf-8?B?dE1GWTN1RlFlSm9VaEQzQ2hWbGFCMEdXOFRDTUFadVNnOFkyZHNBdFY1b3ZI?=
 =?utf-8?B?c1lSUFJzdHM4QnFwWHlXV3JBM0g4NDdsajNxclJFUWU3RmZjcnNKb1BjQzZo?=
 =?utf-8?B?TTdwdHc5KytxajBaK21jTCtzcU1UcEdZSnE0czdHdEdoZHAvNi8rc3MzanZW?=
 =?utf-8?B?bXdzYWIxRkltY0F4V0ZIOEtNb3FEL3dBVlU5NkxtL0liNXNWNzd3RnJvaTNW?=
 =?utf-8?B?NmRrRDV2Sm8rN1g0VGNVYWpQUW96bUJjajROamxDTnJJRGYzL3hML016cGt1?=
 =?utf-8?B?K1NLWmZnUFZORlNLQ1NremhxVnVDdWhLTlo0RkFXdE1BTWtqcE5TRzlZRnN6?=
 =?utf-8?B?RTFDendTdFovT0F5VGRqck5JRngrbWtwT3ZZYlU2YXZkNUo2amcrR3d0azVU?=
 =?utf-8?B?NUNSY3BUeWtVVlY0UDRMNmpoNEhTazFPaVNhV0FKb2NaVjVBdFlySHo5RHdN?=
 =?utf-8?B?Z0gzK1ltOUQ4ZkxxNWJkZ3RLZS8zYmlIV2hIcCtoSUVaY3E4bTQxVk9tbGtk?=
 =?utf-8?B?cHpxR0VvNDhEaFFER3NBOHl6NDNJRE05T2hoRitmRk41a2pDWEFneDRScXg2?=
 =?utf-8?B?bkJ1QTZ0Tlk4eHNxVUpxZWJ1MHhBNzYraHZSSUp6eXdqaWl0aXZtbGdsVFZQ?=
 =?utf-8?B?RU12RndwZUVYdWZqc3pMM0FsRG1xZjNCa2VGWjBQeFEzdjdobjRQcFl1Rm9x?=
 =?utf-8?B?TE5YaVpQR1g1YUNQZWh4U3JiK0RjbFoyWXdjZmdwUGR4Mm1JT01Da0FCZnNq?=
 =?utf-8?B?MXVxK1d6NWM5dG5UVFhTdVRLMXNJRFF6WEtaT3NMVnJvZFVPSXlwTmVobk5D?=
 =?utf-8?B?dFlLQUlvV0IwRWl4Z2xPMXdHZmFpaFd1eFlIaUhBMzREcWNPWVhady9BWVo2?=
 =?utf-8?B?dTJCQnBoRldsL1VxaUNQQ0ptY1YwNVNlSFRhQzNuZS8vZk9sZEd3S0xabzU1?=
 =?utf-8?B?cWZVZk5xZmc1MXNHYWV6WVh1b2RLNnY2SE1WV1ZwaTFVVno1Y1hsRzdOZzhJ?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d38975-671e-4952-85b9-08dcce3c9bdf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 06:24:49.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CGEP5Rhll65zdpdSESI9NIkjafrn1boFwuVsc17XH0IP0LNDKwN5vJhaOXpAtHy6M68Fo8rfdmK7cyxm3134A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7851

On 05.09.24 21:07, Jan Kiszka wrote:
> On 05.09.24 18:33, Bjorn Helgaas wrote:
>>> +			res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>>> +							   ks_vmap_res[n]);
>>
>> Seems like we should check "res" for error before using it?
> 
> Oh, unfinished constructions.

In fact, devm_pci_remap_cfg_resource takes care of res == NULL.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


