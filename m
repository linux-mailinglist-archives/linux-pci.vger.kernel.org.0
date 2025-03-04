Return-Path: <linux-pci+bounces-22824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C2A4D56B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36D4188D1CC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAB81F790C;
	Tue,  4 Mar 2025 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YZ+Ev52f"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010003.outbound.protection.outlook.com [52.103.68.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D32AE8D;
	Tue,  4 Mar 2025 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074858; cv=fail; b=UOfCKMwZg3oT3V1W2wEU5IyJDk4CyCNKrO8mwKYZamttrO9CZXUtmbTojWf74EUycwP+9DvgcZQtk1K2JpNJxN4pSEjXtHh0YnF1T/8mWOljMKjBViRjoLR46hPDJ72ksDWdog8PRAHu5/PdCNfCFBjaXSRUloeQt8JCpEyFt0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074858; c=relaxed/simple;
	bh=9rKyYOkqG1QDOrJqZZRq1QoleLG5LP19KslAF94iUKE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pLHr/azPembu4Db1QyjZvbGSOXbjZ66qzvJiltnKo2FV2gdb3xX0AStYvLB3PExi+UUTmZnhPgYUAk2rKSjr4Lrchb9k7pZxot+iOA/tg0ISDviwiRkHSfxpNSvwieaw25gDBPM9VLZVgnwYD5zKIGLWWF6jr4Ev3MDsq16Oy4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YZ+Ev52f; arc=fail smtp.client-ip=52.103.68.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIBrVSfP0Vmn87YCfh0JN6+ldu/1poNdI+wdMjwbDsJvA09kvtXrBVYCJchc8vZd2G6U8RR+GxNhxNsLs/W8UN4Mm7vnZP8lGe/73fwAd9l8wlHr1r1M/P2ggtFF5C/NgdQFUceEv7Zk6fQf/Jj49a9gG3ENqy7E6tOYJq8Zt0YRNH6WLhEgyeHy/I6GFfasYjsuE9QwfBVGk46zYOVr2spT3DluMnQuCPytgv2guPcBJcv9zw+O+R1P9x63aOwtI2KsAGOeZFV+7h2wKGUhrZ4hoRUiajaSORfG5VU7gsX8MXByev1OBKRpRGctXDV0iPVowTHnOQbndLYRqSQs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1F4R9RgzAqSdcG5gOVm2Xshnv98hHhzCkXlDEJBXbmA=;
 b=MWS4izMLioNvIGl1cRmN9koNzBpUFsUVV1qBmtpQrHpUe7alRm25B+n1z8ILxaSNocVUwTiuP9ih8nh2ZPm1iFGIc73n8coNgU8kX1WSvHhZS5/1M6gzANO31R7nxo6aSzUR2ZCJRMNVhHT/4/+GdYYfy2gvXMjZsD6plQlG1/6dtgtvkvM33lv2mmIB75VJ00kJh+mvkpSWFIRNS55wDckRpvuFoZhp05Eq+YoPtByZgSR6CYzk8ZejDW+KhZWL1aeFYkfWYeZmsnrbG3BZGB+VEnLc19BiKWAAGGtIQLTeU1USr+P201LiC2YayMe6SUSbs2AY11dO03dBaroyGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F4R9RgzAqSdcG5gOVm2Xshnv98hHhzCkXlDEJBXbmA=;
 b=YZ+Ev52fTwzBilHYpe0I4YARHniNZwg60+cDKDsg5+M2K4W2KZG5fKDeFYhARnUoQ/+LeyH94Nc9c8Af5MQEDdhehIUJfBds2j8gUZvLw8MqZ4HuHBffPNM1nODl0yS/hh3hl1fn2xHKx5vwccpr2kPkBFyTiGGLpfeXqsxVLhP+nARMDMZ03CZ5IBcPlcKh3i0PoYFSLxGVMdTQqA67KyINqtPaaYw6fzQdBEuDBnjcq2k8DNrV9Zw0bBr7XqEdRgAhy++t24tTZ60y49Spi24bPjvCjWWprd32OxoO8npZxOWyXMQ2L+MXyPyAzTxuncpJqNeDi9teCIlS5VySJA==
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14) by PN0PR01MB5495.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:62::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 07:54:03 +0000
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5]) by PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5%6]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 07:54:03 +0000
Message-ID:
 <PN0PR01MB103930AC8CABC36771EAE089CFEC82@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 4 Mar 2025 15:53:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] riscv: sophgo Add PCIe support to Sophgo SG2044 SoC
To: Inochi Amaoto <inochiama@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Johan Hovold <johan+linaro@kernel.org>,
 Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20250304071239.352486-1-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250304071239.352486-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::16) To PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14)
X-Microsoft-Original-Message-ID:
 <aa8807af-d9f8-4641-8a41-d484166a9f21@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB10393:EE_|PN0PR01MB5495:EE_
X-MS-Office365-Filtering-Correlation-Id: a49b3459-ea8d-4fca-a4a7-08dd5af1bafc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|8060799006|5072599009|15080799006|6090799003|19110799003|461199028|1602099012|10035399004|4302099013|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WER1eGRZMFgxUTJQWVVoZjF3WmtzV3FMTno3aDJ2S0xQcitqU1hycDhmWVZ0?=
 =?utf-8?B?RTA4eUFXL29Dek56U21JS2lrZSszUDEwNGh2NEdob0V4L04yUFZQTTF1M0ZK?=
 =?utf-8?B?Y1o5WFFnV09qOEJXdGdFM0IrMTFTbHFZK2RldnJObXlDcEhGQTJtd1k4c2h2?=
 =?utf-8?B?WENvcTRWNzBlYThza2U0UDV5MzQydGR4ZDB5Q2FmcVpOQTdDbUhKOUYyS1VI?=
 =?utf-8?B?U0JWaC9pd20xMU8wM05Ndkd6WjNDOExaM1AvMDVzOHZpWDE2ckJSSUl4bG8y?=
 =?utf-8?B?ZzhHdTFEdnd5VmF3QUttR0s2cnpBSXRiVUo5RHhteEF2czJvOE1SNHBMR0xv?=
 =?utf-8?B?MVFjMEFOdUpBOFQ2aUE1anozcVFOTmFITEVRQTNBb2paRjNlaHppa2xKNVFZ?=
 =?utf-8?B?RUU1SEdoTTdHdzAyRUE0eWFseGhKNEZMUTQvc3BjVEZSMldjRklGeEo3ZGlj?=
 =?utf-8?B?TlRmakFHL1BrYm1YcWRoelFDTlNGQVZMMG9iaHcwdDZSMEo4dmlFRWQ3cU56?=
 =?utf-8?B?M2N0cTQwUkY4MlBvVTVWM0NldDZ3L2l3RjNNS2ZQZUtDb2lhLzh1VUxqMUF4?=
 =?utf-8?B?OXhZTUVINkZGNEV2TlAzRWxPbytsK1EyYy9yMEc5UDlDMHljUXZIMkkyWEp3?=
 =?utf-8?B?L0I3L29kbzRqc3lPL00xdEYxdWkyZ2N3ZFBMSk54RmY0Mm1BVVNsaXFKT0ts?=
 =?utf-8?B?OVdQcDhUSWlkeVJoYlVla2hEVkF4ckZZUThwcWJEYUI2YnltQkVQeXBxYk1m?=
 =?utf-8?B?Z21DZXZUME51bm1GUHJQNEM5K0dwbjNuS2Z0WUM1SXE1dkdpM2pIMkpXd2hO?=
 =?utf-8?B?Q0hmRWhTSlRrb0MzZkc0ZTUxY0h5d3FaemVaaTREQ0NHakZxUGFnZzFhVjEr?=
 =?utf-8?B?UXVlcXUzUzdKbDZWRW9kckxiTzU3Vjh4RzhNdTlEVzNvcmFEN3ROQnVaVngx?=
 =?utf-8?B?L3lYWm9hek11WGtKdnk4SDN3dFM2QlZDY2ZGZStMRmdNN1o0aVU4VFJKbFpv?=
 =?utf-8?B?QlBhaTRpQ0gwZFNiZ0VDSm1RZDArNXBFMDhKdXd2ZExvZ2lkMW1sRlRxOTFr?=
 =?utf-8?B?bnhBaFNaN2xZZTl6YXlzSnlvNURMU0xDclE4cmgrV3FQV2NtM2lGazc3WVR1?=
 =?utf-8?B?VmdLMWhneGRNVHJsd0t3ZVk1TUkzQ1dSNVNTRzd3QXlKSnhmL29TbG85b3NL?=
 =?utf-8?B?Ym4ycURYNWFvenNBTW05MVdxZHM2VXpqY1lLRmgzQ0l0MkZJOXpvMGRxZTFa?=
 =?utf-8?B?ZVRxOGJua2lpaWZUUzdQWWYxcy90OXl1S0hONHMyWXE3V2JyNGtxRXdIZjhI?=
 =?utf-8?B?R0N5S2RTck5aTkdOUjVSaTlTTzd6c2pQWHExT2duTHRGTHRuK0lqdGtQd1Ni?=
 =?utf-8?B?RVJmV040WURlTDhZekdWWjVXTGVyemFPVTh2U1ZRcGRaTGl4S0JwVjlHRVh4?=
 =?utf-8?B?SGhnQ1F0NkROVnVPTHlVa1JYWll2L1FYQVkwVitVdVJOT1A4azVXUk9PWkQ5?=
 =?utf-8?B?VmgxTVVzTDNGUGJ0bjg2ZXFzME5HaVo5SWFZOE94ZGZXdm5YcStjWWxpZFdJ?=
 =?utf-8?B?d0YwOE8yWGRYam5SbklxRVNyS0lTQmtqUWVrWjZiNjQ0b0lIUmZFRkZBQ0Vt?=
 =?utf-8?B?d3d5VXpqQXhXV0ZkTmNJZVdZeWp0UGRDR09DcXprQzY4VDFaemgyN3FYMHFl?=
 =?utf-8?B?Q3o1UWZsZGRzMzV2RVlZOHBtMVkxY1FRMVpyQmhEVlFwd1dJa3hkSWRBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXZvR3ZJUTBkblBTUkl3VU9LcUxhVXEzSTVMek9KdXBHVXVxVlZzZi9GWU9w?=
 =?utf-8?B?ekhiMjM3Nm1RL2w2UEg3VWhxOEhIREM5Z0llMW4ydHJ5R1ZLK1VBbEdnSUlS?=
 =?utf-8?B?d1pSbm5ETmZhR0dWK2VsaFA1Uy80bWk3dEo0TFp4SHMxTFR2L1oydVdYSWto?=
 =?utf-8?B?SG9tNmFBMm9lTHNvbElrV04xZkJDaDZlWHJ5Y2Jrdk1OWWtvOHdhY0dVS0dJ?=
 =?utf-8?B?UHB4UENZaDJXVkl0aU5uMi9uZUxQV2YzQ1pPYndNWFhWcW4xRGE4Zm9jcXVs?=
 =?utf-8?B?aU9iNEFyRnlsMjVtR0cwaGkyU1JnWmhVOEVNZUUzSVQ0RnJQWmRuV2REc09X?=
 =?utf-8?B?V0s3ejBSdzJFWGxVM0lTb0JETzB5S1U5cURkOE5aMlE5RG1HdElhZTAzaGNq?=
 =?utf-8?B?S2trWkQxMDh0QnRMY3k4cEpLVm00WlhTR0tEL2VMbUFGSzkzQTd2RS94cFMv?=
 =?utf-8?B?TS9ybWlWV2JCamk5eXdMN21LUlEzdVMvYnFNSmFjTG0yU3NSK2o5Rm1lekE5?=
 =?utf-8?B?U1g3Z0NOcEJlV3VtRWRqWGdUQmZ0WEoyalozNFZFem1ETVdCTzJYWDVTS3NO?=
 =?utf-8?B?emFlSERaNTVZREpDYzVtZlVYOGxoc2N6QldOeUZMN25BWWhBWEMvVHVTV0ZN?=
 =?utf-8?B?S1ZmOGJhZ3Q4SWhDZTRQTW1kdWNmY2QwaHJDc1k0aGVpTkNsSi8xR0I1SkJL?=
 =?utf-8?B?Umd0SHpWbW9HQjJsaVpnc1VJMnVqRWRBYWVGR0VxcWlXN2d5QldSQWhOTmV4?=
 =?utf-8?B?Z0ViZjhwV0k0aVhBbkI3TFRlTWZKNmd6dWVrQW1JVWdQc1FxSTVDeWlLd0xP?=
 =?utf-8?B?aWxGeGVwT2tUWHVMTkFpMGlvQk5HQkN0QW5XOG56YUdRV3BEQURvOEd4ckpB?=
 =?utf-8?B?M3NJWW1Eb0Nad2hxZ213VVhKOWFHN25YOWFCa2pOZTRlYXdHdDJ5R20zWkMr?=
 =?utf-8?B?ejVQN0VjRlpReHRjb3ZXc1Rxc1pxRFJnOFpCR0p5ZnpuWkI2NTY5WVZodjUx?=
 =?utf-8?B?SHk0WnJXUFNURFNoT2JjLzZNV0pmWGRVQlh1dTB2VWora1V0U3B6ME41VklI?=
 =?utf-8?B?WDRUNXZnN1VkYmE1a2piZTNsRGt0S1M4dlB3L1BBOExMV21JUWthRDdoWDd2?=
 =?utf-8?B?eHM1L1c5TVN5QnFBc3NaZzNSd1VUdVJZK2tYaDBsaDhYcjFQVlliTWdSKytP?=
 =?utf-8?B?OFQ5c1dmL05LUjc0UkxkVElZQ3NjSmFzaDVzTnFyT2J5OTRyTWMxN1QrYjQw?=
 =?utf-8?B?b3g0M0xSOHd3dW9MVzJiekRtbFFyVHJ2b2M3TElqZ29CUHJzNzNDcDFrcEdR?=
 =?utf-8?B?aFJraGF6NTVwL2t5bnN6SkdROHNlQWZQQkhlMlhWS0FtaVljNzhIRk5yNmpC?=
 =?utf-8?B?dWRvc25NS3VhRmJ2YnhkMGR3Mk9QVDRDeU93NWZsRVNodUNuYk1yMmViNHlP?=
 =?utf-8?B?SnR6UmQzNzFUbDVIVjgraDd2Z25hSVRkcHBLTlNaeXlBOEtrVWhKUS9PQWVO?=
 =?utf-8?B?WmF1bGdNaTB3ZVhNNFJsTVllUE9kY05pYVBXbkRwaU1hMzlLcmtSMjRqZXFP?=
 =?utf-8?B?c252MHFONTJHZC9NMllWaGV0UlE1MTVoTTFwc1ZqMUxWUXVhTHBQemJ4OGVL?=
 =?utf-8?B?QTUvUDMzR0FYOXE4K2J1NW1yVTZRZ25lWTdycEpkVkJibjlGTE5EbThRTENv?=
 =?utf-8?B?eWpRcGUrTGt4VXNvNUZBQm8raUtvdzA4Z1VZUkozMFJNK1JTVXRxY1V3TkRs?=
 =?utf-8?Q?dPJ+ZcaPlKPQdtADrvbfPjcLNSKvFLAmHk2g1uB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49b3459-ea8d-4fca-a4a7-08dd5af1bafc
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 07:54:02.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5495

I think it should be v2, right? :)

On 2025/3/4 15:12, Inochi Amaoto wrote:
> Sophgo's SG2044 SoC uses Synopsys Designware PCIe core
> to implement RC mode.
>
> For legacy interrupt, the PCIe controller on SG2044 implement
> its own legacy interrupt controller. For MSI/MSI-X, it use an
> external interrupt controller to handle.
>
> The external MSI interrupt controller patch can be found on [1].
> As SG2044 needs a mirror change to support the way to send MSI
> message and different irq number.
>
> [1] https://lore.kernel.org/all/20250303111648.1337543-1-inochiama@gmail.com
>
> Changed from v1:
> - https://lore.kernel.org/all/20250221013758.370936-1-inochiama@gmail.comq
> 1. patch 1: remove dma-coherent property
> 2. patch 2: remove unused reset
> 3. patch 2: fix Kconfig menu title and reorder the entry
> 4. patch 2: use FIELD_GET/FIELD_PREP to simplify the code.
> 5. patch 2: rename the irq handle function to match the irq_chip name
>
> Inochi Amaoto (2):
>    dt-bindings: pci: Add Sophgo SG2044 PCIe host
>    PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
>
>   .../bindings/pci/sophgo,sg2044-pcie.yaml      | 122 ++++++++
>   drivers/pci/controller/dwc/Kconfig            |  10 +
>   drivers/pci/controller/dwc/Makefile           |   1 +
>   drivers/pci/controller/dwc/pcie-dw-sophgo.c   | 270 ++++++++++++++++++
>   4 files changed, 403 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
>   create mode 100644 drivers/pci/controller/dwc/pcie-dw-sophgo.c
>
> --
> 2.48.1
>

