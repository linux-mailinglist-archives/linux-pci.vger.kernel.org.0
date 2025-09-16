Return-Path: <linux-pci+bounces-36254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F7EB594C8
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 13:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F1DB7A7420
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB428C862;
	Tue, 16 Sep 2025 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BrW9Nbhf"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010000.outbound.protection.outlook.com [52.103.68.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88D27E043;
	Tue, 16 Sep 2025 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020810; cv=fail; b=j7arESzO8H3G6AjHbKiqgUVpJRUapa9LGAMT9fcE0ehAnjNsT3RFaTrQsmJLTvLABy6+EZZyVeySH5duHGrmkj+A/V6Oxri6fjOa5X0WMbMWsugAuwDApewszB1Q2rB/FFSUEbwZCOQiXoO/Rh4vM/8uoVtLLr8iiNvo+FKE1Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020810; c=relaxed/simple;
	bh=H/VNUBnrwXbXDKLcaKNIsowRVgAOnaFEkop2WEPkKTI=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=gNp/+DVx/e5m8m82Yl2Pnrxw2rHQwSuUM6LOhpVAwFYMyIdhoCToxYM8vLodhhY04TFY2yJ5h9t0kDRD8ON4ZXaRV2bT2auJq0Xe2ZvHe7E1x/suRLRGijQTOlgAu+G1Gzjam6EYaNVK84zcZtBdnZvwh8XdF25zT21ZCLVdW1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BrW9Nbhf; arc=fail smtp.client-ip=52.103.68.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCEajQEFaMK0Mby5pxLITQw0SxPxh/iELYQgqPr8hG/8vLmQvgC1ioOB6aXsW4dmGar66XSZglFr2i8FMHihxxSzUFQAWRJETwTAPxqCo/dQdIKg33AXztErZpnZ5/kdjCNSYm/eFQh8Z2z6r1TI5BhvzYBjpI1qHqdU7cvzAqys856NTYASdtkkuY1ekDh7zvhFttdB8hfgc6CMP2va5CRsX/7bwJZC4x7J2wkuRRAQG1iHcSk7+YSx33nDrseY4ziZF+ptEf2IgIJgSTxZwNwJgSNtCosRxKrXmAp+sSfJFdqpD7v8GD7K0twkPWWaBznlR0FZuF+sei+u0YXL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op3D7/goUTQ5LpwwKdFPv/F+JK5K0I/OMeTRnPwrwv4=;
 b=Ft7tJcwlf/Roz8tb2yGEi6yg0Us/zHpmDo2klMC8cwh+cQG8uWHnkkYEvHWadhaw0hrxwX7G9fDDLVu8/UqS821J3YzKGdgdfGr46UyJANn6bh9fITuJCCjGBCcN8dEUhKAyJ2e4UuDv4smmp80uihHZB9uG/eW6qUR6ICgRn82iB5pxNqkEefYEmwdXc77XcMFbQbLa184tm111Ty0yvmkuZSzDJJTWIa0gA70Q9eMNs/wVV+6YHNXLZPmYwPgubBisylAMqCjoK8WVXrnjij5WnHJQ7bgW6MsKPuHMr4rzv/ga/qcFFflVEEjxxzX/Z7wKHq3yE+TZs+Ix3h+8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op3D7/goUTQ5LpwwKdFPv/F+JK5K0I/OMeTRnPwrwv4=;
 b=BrW9NbhfSh2XZ+ZqoGI/SR8M+YttC5E6jy5fYLWZXKzur4iP3IZ0aHV9qrdGxxToH4poiOVTbhy67ZK9K2rDyYpX3udQp6RWcIouekMRXfqQlGVQGDFgaWyt6ELS7xzVfo4uGhnM0zG4pLTOIlcvsY5CD5FY0D21Uf5tUziicdLZZmHqMpS2bXzb+VVASPcTTUyf+AcdNATqAYpBmypDAfLnH5Ubvv1m2hOAw5s0psuddGvUvc8VHrRENGJlavo+sGKWlgovVhH3Dbce3WdFncfrbDNF7KJ0RedhoaW9lmLRxSMxA1U4WHTnWt9Rze2TPALfevod8j5oRE3nRsGhIQ==
Received: from PN4PR01MB11064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2f4::10) by MA0PR01MB9078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 11:06:34 +0000
Received: from PN4PR01MB11064.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::aedf:9d47:d2fd:7de0]) by PN4PR01MB11064.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::aedf:9d47:d2fd:7de0%7]) with mapi id 15.20.9115.017; Tue, 16 Sep 2025
 11:06:34 +0000
Message-ID:
 <PN4PR01MB11064C24A188A68558B5CD94DFE14A@PN4PR01MB11064.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 16 Sep 2025 19:06:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Add PCIe support to Sophgo SG2042 SoC
To: Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1757643388.git.unicorn_wang@outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, kwilczynski@kernel.org,
 u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 arnd@arndb.de, bwawrzyn@cisco.com, bhelgaas@google.com, conor+dt@kernel.org,
 18255117159@163.com, inochiama@gmail.com, kishon@kernel.org,
 krzk+dt@kernel.org, lpieralisi@kernel.org, mani@kernel.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org,
 s-vadapalli@ti.com, tglx@linutronix.de, thomas.richard@bootlin.com,
 sycamoremoon376@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev,
 rabenda.cn@gmail.com, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
 fengchun.li@sophgo.com, jeffbai@aosc.io
In-Reply-To: <cover.1757643388.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To PN4PR01MB11064.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2f4::10)
X-Microsoft-Original-Message-ID:
 <291160b7-5431-46ba-b53a-5ecebb896bde@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN4PR01MB11064:EE_|MA0PR01MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: b3cbf5ee-30e5-4eb0-b3c1-08ddf51118e4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|461199028|8060799015|19110799012|5072599009|6090799003|1602099012|40105399003|52005399003|41105399003|440099028|3412199025|4302099013|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHZnVUk0SmkvcUkvMVJTMERraUYzVlgwamVHamptdWlqZnlzU29OREdmR0E3?=
 =?utf-8?B?aUU4ZlpZVEZCcXc5QkhnNjBoQ29lcHFqTEppY2ZLT1BWQ1dJY0NvT2RLVk9n?=
 =?utf-8?B?clU0ZEJaZE1tOUtVMVByUmtmZ2xRNHFEeXpPSlBhV3FyaE5XbVU0QmV4ektN?=
 =?utf-8?B?VThhNC9pOEorRm10YThyaExlNU9oejRibXlvTUZxYzQ3ODZUQVd4VXgwdWFN?=
 =?utf-8?B?U2dKTUE3QUtvbFlQZFRkWGU2YnFHS2x4d0JWMURuTkZ3a0FUS0I3Q1FnZS9i?=
 =?utf-8?B?ZUJpazlXYzN1bUhQWEVJUTlQZmpvUGtXcER1U3VuRVd2UFN3TnVseC9jMFdC?=
 =?utf-8?B?ZjBZTjRLUjBoMXBuYmp3Y3FtR2R2eUlxRUU0dHRaWkJDM3VnM1dxallzTGRV?=
 =?utf-8?B?QldwMzJMZmFkdE5ZWGFvWkU4TzF3SU4vMmR6QXM0WHRWdHNTb0FJaHJnOC9m?=
 =?utf-8?B?N1ZDbHZPTEJURUl1TXlVWHJwZW56Z29SQzk1dFhSdDdrSGNsaEJ6c2JoK3Rw?=
 =?utf-8?B?WnRjUklYNmVGQ0hCekplZzFFdDE4VUthSXc2OGVXUU80YUlNK0ROaGVnVVp2?=
 =?utf-8?B?cnlRaTR0SjJ2bjYzZEZEdlJONVBIL2tnNSt3ODVWbEMzZFdsa04wRFlVSjNk?=
 =?utf-8?B?dVIzd01ibnIyc2JoYWlzVGVxYkcxZGROYUhNNDVTdHVwVGt4bVZuWGg1VWdk?=
 =?utf-8?B?bmZoTG1rSnJqWkRMMXRMRGMyMDM3ZHJqK0d0a2duOHp1RnI1dFFCQmc2UUhj?=
 =?utf-8?B?RHEyRTBjSW42U2NGcXA3MlkzdUFxWVZFbFgwclNtZXAvZWdaTUxFb1JVbDR5?=
 =?utf-8?B?NkdpcjdCRm5BU0NNbWtYTmlNcGVQM01GaTVjWFc1eFJRb3A2NFZHRmF2NUlV?=
 =?utf-8?B?N0VkSDlwMkpFc1hFN3lHSXFTeWQ0dTdtQ21RRVVYTkN3TWtMQkRrT01EU3dE?=
 =?utf-8?B?aFdOa0ZMN21OR0tmUlZOMTA4dkxEdFBmUk1TM2xrR3ZMbWhkcFBKdVJKcmZS?=
 =?utf-8?B?WE5ya0trU0QvSGZ5dVFJVHJmRXFUT3JmcWNPbzkzWTUzKzI2UzMvaHJyMEpK?=
 =?utf-8?B?NldGUkt2U3lDTDdEaHRuZk84dm5FYyswMGduQ1IyRjRVRTNOSHZXQnVUTkdP?=
 =?utf-8?B?K3d2YXZ2NTluaktEekZKTnN0cXdGSUZibXBiTDRET0pVa1BWVUNoU0p2RHNW?=
 =?utf-8?B?M2YxdmcxY1F5ajFrS0ZqQnpJTmhSb01sQWRrOHhwNlN1OFNQWlRSb1R2RFcr?=
 =?utf-8?B?RlJGMjBFUXZKbUZmaW1YVnVaU0xSQXhqV1d4M0V2Z21ZYndsWFgwVHJSSTNX?=
 =?utf-8?B?dVp6bjlxUGJzV2lWK2VVcGVSeFBoRksxalNZZWFWYnkzQ2twdWh5UEpnN1Rt?=
 =?utf-8?B?SFBsa0ZDSWo3M1dXRHMvMnlNbzdPMCtUM2U4dXBFcVVVZXFDZk9MRFlXd3hO?=
 =?utf-8?B?SjBPNnhNT1hMT1RDeXVkYU5VdWlYeExUMXpES1JabTd1S29UMUxSOHNNMXdJ?=
 =?utf-8?B?N0VtZXBwNnd4TWRHcEl5cmVmWE5DYnJSYkFtbklwUFpOZmlSVkIxVm5HMktl?=
 =?utf-8?B?bmI1L0N5OFhLQnVGYmsyOE55eFZrV0FVZzBFbFZYK1M0ZGJMSzM4UUZOb2Iv?=
 =?utf-8?B?dnYxQzlIRXpIY2VPUmlqSTJaT05uZXB4K0Q0NFJOU0dkUXJlQTBPZU1iZWJh?=
 =?utf-8?B?Q09QRmR0MW50V0kxZEhIUjJjNkRUa2s0YVZwbnk3ck8xc3NPV0xDU0VCQVdC?=
 =?utf-8?B?QzIwN3FIQkZQemVnTVRIbnhtZzU2V3ZGRFlKRkN0V3JTcVIwbFYwekZWQlNH?=
 =?utf-8?B?Sk43R1pTUUVhaWhxUFhmemRJVG5SQVdKSEF4RGJ1SXlrYmphOCtyWnRQMS96?=
 =?utf-8?Q?+qbSCq3OoSgWZ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzZMb3l0TGtRbS9KNkpKajdQVUlSUGlPVWNwbFhsUUFTcjlpYWhmNHRJamh2?=
 =?utf-8?B?NUtzVERocjFTN1ZhT2lReDF2VVg2T01mUDJiLyt4eUttMFJJR0tQaGJzRW1v?=
 =?utf-8?B?WVg4djZRZklwNGQ1WnVrbWxiRHRUdExmNGMydEdVS29yUU93TjdxMk5ubEM3?=
 =?utf-8?B?ZTNPUnB6akMvWUlnRFpENDhJOXdYVk1kRjRlc3VjY3dmRFRQOHgzd1ozYzE1?=
 =?utf-8?B?clBadmRtK2tzVzRnV1VqejdmblltNDFWV2I5aGl3SEtscnZYZ3BkNVcyMHVz?=
 =?utf-8?B?Q3BJMHgrSHhiejduc1g2NnFvY0xZdGh3WFA2TTk3R2ZEeEE0RVVldnNYVjYw?=
 =?utf-8?B?bzFWdU9kUUlkTGNkVm82cS81RE9yUUM5MTlwbVlwbW43RTN5ajNpVDlxbFdu?=
 =?utf-8?B?NlFUVldEMkl3dEgyTGhrcVp6VHlzcmNnVnE3RVZsajRqaTVRUVo3SVJFZmlF?=
 =?utf-8?B?RVNndVV2T2l2Z1BYOTlURGozVS8xOXZlY3M2Qy9ia1VmQlNkTHJsV004RjZE?=
 =?utf-8?B?R2c3aFJVOGdsd0ZzSVZoK2hsYVlmcis1VEEyUEswQVNIckJSRTM3MzJ4d0Qv?=
 =?utf-8?B?UC9ucXplU1RyVGduSFVpUEdNdnNXMVJKRnV0Q01BRk5Wblc4WnRidHl5MEVH?=
 =?utf-8?B?TFMwSFlqK0x4NWxoazIwb24wOUkxTVJxUlBzUHZadWpVaG5HVEJXcnljRFJl?=
 =?utf-8?B?NllNL2pJYVhTTmFoa1RMUVc2S1Q0dXZJcWQwL1NXUE1wdGwvNHB2aHhKUzJy?=
 =?utf-8?B?S1RlR00vVFlEMTJXckZTOEpubDA2L041UnJNMXo5dmQ1eVNXWXNSekdWbldr?=
 =?utf-8?B?bFgzRlB5N3NFRGFrY3VoSTdyYzJ5WWkwWDhxWVBKdlI4VTl0Z21aN0ZITThq?=
 =?utf-8?B?Q0g4Z2paWWNmbGF3YnQvQ2JvQ3JUenByS1B5aG1ramYrRXpiMGtvbEhMM3ht?=
 =?utf-8?B?OEpVUHUvck5peXBYbVVOamdqdCtycXIwKzVhbjlGeUlwYis3TE5wdVNQSUYz?=
 =?utf-8?B?bHpINTF3VWE0S3NBb0R2c0J5Y1p4dHhnZVJRTjk3cTR4Z3BNS1ZSekhNVWx2?=
 =?utf-8?B?bEUvcFkxWWcybUYwVXhIdHdBZGt0Q3JncGdTWXEyUENDWHFOM3h3L2htanM1?=
 =?utf-8?B?NDI1dGtwMU9OWml1L1NXeVRlcVdaNTVoTFpBRjFoM0JXNDdUMDhVZVFaY21E?=
 =?utf-8?B?RzdwVFNWL0x3RlNPV0hVbGd2UXBvQkV1aDZwcStYRFhiYTdENDdQUnFobFB2?=
 =?utf-8?B?NFdvM0NJbFpaemY1ZFdwUnVjVGVsQUsxRGRRaGRKWnNvdktMNDZxaEViQW1i?=
 =?utf-8?B?eFRXc3hXb28yRGs0bm9na3I0VXd0bjZTMnVSV1NrTkp3S2ZWU29uSUpHUTQr?=
 =?utf-8?B?b2hXdHpVM3cvM1BMU0xkN0tMN3lyaWJRczUrY2UrWHBaTzlIL2ZsMWUwNWR0?=
 =?utf-8?B?QWloMmpqS1NBZnphbGxJNVlvYTAzYXRpcjdwd1E1ejJLS3FxVmorZGxoMTBI?=
 =?utf-8?B?V0cvT0hUeXpXSmx2YW5PVXpYRGs1Z0c3dkQvdU5STm5ya29JUHZtVEgvVnRx?=
 =?utf-8?B?MWp1VjllaFdIbU01ekRmeStPanRCQlFYSWthc21FekNiRFVjRjNNK3U5TTBk?=
 =?utf-8?B?dWlhYlZDajl1cWtEbGJqVVRCdFZuMFFXdzRWUFB1Ukx0c1lpUC9pcmhyQ1VG?=
 =?utf-8?B?VTROWlM2aStIcXlNMzl4Y0hXQjY1QlBsRndGaE9jRUJ5U1FVZmJMM2MrYnFE?=
 =?utf-8?Q?h0vLhGYey+gF0BaJCUQ7oP1aYk1Xl3KB9fqpUop?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cbf5ee-30e5-4eb0-b3c1-08ddf51118e4
X-MS-Exchange-CrossTenant-AuthSource: PN4PR01MB11064.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 11:06:34.0720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9078

Hello, Bjorn,

Is it ok for you to pick this patchset, so we can see this in next 6.18.

You can pick [1/7]~[3/7], I can handle the left dts part.

Thanks,

Chen

On 9/12/2025 10:35 AM, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> Sophgo's SG2042 SoC uses Cadence PCIe core to implement RC mode.
>
> This is a completely rewritten PCIe driver for SG2042. It inherits
> some previously submitted patch codes (not merged into the upstream
> mainline), but the biggest difference is that the support for
> compatibility with old 32-bit PCIe devices has been removed in this
> new version. This is because after discussing with community users,
> we felt that there was not much demand for support for old devices,
> so we made a new design based on the simplified design and practical
> needs. If someone really needs to play with old devices, we can provide
> them with some necessary hack patches in the downstream repository.
>
> Since the new design is quite different from the old code, I will
> release it as a new patch series. The old patch series can be found in
> here [old-series].
>
> Note, regarding [2/7] of this patchset, this fix is introduced because
> the pcie->ops pointer is not filled in SG2042 PCIe driver. This is not
> a must-have parameter, if we use it w/o checking will cause a null
> pointer access error during runtime.
>
> Link: https://lore.kernel.org/linux-riscv/cover.1736923025.git.unicorn_wang@outlook.com/ [old-series]
>
> Thanks,
> Chen
>
> ---
>
> Changes in v3:
>
>    This patchset is based on v6.17-rc1.
>
>    Fixed following issues for driver code based on feedbacks from Bjorn Helgaas,
>    Mingcong Bai, thanks.
>
>    - Fixed the issue when building the driver as a module. Define own pm_ops
>      inside driver, don't use the ops defined in other built-in drivers.
>    - Improve .remove() function to properly disable the host.
>
> Changes in v2:
>
>    This patchset is based on v6.17-rc1. You can simply review or test the
>    patches at the link [2].
>
>    Fixed following issues based on feedbacks from Rob Herring, Manivannan Sadhasivam,
>    Bjorn Helgaas, ALOK TIWARI, thanks.
>
>    - Driver binding:
>      - Removed vendor-id/device-id from "required" property.
>    - Improve drivers code:
>      - Have separated pci_ops for the root bus and child buses.
>      - Make the driver tristate and as a module.
>      - Change the configuration name from PCIE_SG2042 to PCIE_SG2042_HOST.
>      - Removed "Fixes" tag from commit [2/7], since this is not for an existing bug fix.
>      - Other code cleanups and optimizations
>    - DT:
>      - Add PCIe support for SG2042 EVB boards.
>
> Changes in v1:
>
>    The patch series is based on v6.17-rc1. You can simply review or test the
>    patches at the link [1].
>
> Link: https://lore.kernel.org/linux-riscv/cover.1756344464.git.unicorn_wang@outlook.com/ [1]
> Link: https://lore.kernel.org/linux-riscv/cover.1757467895.git.unicorn_wang@outlook.com/ [2]
>
> ---
>
> Chen Wang (7):
>    dt-bindings: pci: Add Sophgo SG2042 PCIe host
>    PCI: cadence: Check pcie-ops before using it
>    PCI: sg2042: Add Sophgo SG2042 PCIe driver
>    riscv: sophgo: dts: add PCIe controllers for SG2042
>    riscv: sophgo: dts: enable PCIe for PioneerBox
>    riscv: sophgo: dts: enable PCIe for SG2042_EVB_V1.X
>    riscv: sophgo: dts: enable PCIe for SG2042_EVB_V2.0
>
>   .../bindings/pci/sophgo,sg2042-pcie-host.yaml |  64 ++++++++
>   arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts  |  12 ++
>   arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts  |  12 ++
>   .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  12 ++
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  88 +++++++++++
>   drivers/pci/controller/cadence/Kconfig        |  10 ++
>   drivers/pci/controller/cadence/Makefile       |   1 +
>   .../controller/cadence/pcie-cadence-host.c    |   2 +-
>   drivers/pci/controller/cadence/pcie-cadence.c |   4 +-
>   drivers/pci/controller/cadence/pcie-cadence.h |   6 +-
>   drivers/pci/controller/cadence/pcie-sg2042.c  | 138 ++++++++++++++++++
>   11 files changed, 343 insertions(+), 6 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
>   create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c
>
>
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585

