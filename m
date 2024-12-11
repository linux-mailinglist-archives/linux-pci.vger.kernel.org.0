Return-Path: <linux-pci+bounces-18106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E19F99EC827
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 10:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C282161D2A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B59222D75;
	Wed, 11 Dec 2024 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TpWuLp5v"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C28217F34;
	Wed, 11 Dec 2024 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907665; cv=fail; b=ctO388U3tUwiNwfVZNP56r3gxRh5agV8t7g+2utW3Zm6OI83ke1DaAziCOXHsrTjKCS1wKTVq64eb1l0iAloiuqvPFYJ9UBiHvOBYf9sz5hF/joSB9RLMrA9D1oHqn5DPsgo/HvgznbNGzGWw8J7idznt5Gqu0b/D/3VHKUsZEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907665; c=relaxed/simple;
	bh=XkzV1OGLCOzcFLo2lWWFDzPki633M+IzWvGF4Kbo4Hw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nEANdKVHlnwUmuEcwjctc04FSBEFw18H4A+71cPUvYedQlkPHwUXJModLxG73oTJYi2NImpu1IDWx7lmrJq4G3A+jOqBPiaKMJHuFcm1c6JLLauvhzWRk53ZcyeWjZaaEAWPsbEXx2VkncmNtkQqRbeF4ZLCPPObHdDSVt1QB3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TpWuLp5v; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBzFL4spw+wAIx5j77ksebVUpy4XRo9+48jkh9rU88cCYsAXu8xlvtYB5R5kJskSRJ9iQ3ek2nXcsTv0D/fg0m68SA1OrZnXyNwg1Ya2HAwwMcIFBXYxRp1O4R/biKNqkr96JkQLe9TyFSM0xg7Z+Er6RqYYrfmA0MZj8wFUt2UQ6ivntYDS5rwcRtSEjEew6LMf+JAG2ziWh7w39raCTOfUGuxhQS1BEh317eci5sgHdG9mkDdcg+awGfI6RTidnUWkl/DEu8fBZ7ibZHpvhfW9EgBr6grtP0Rx+dikQXt/ZVX9tXqhZdsog/dNcXn0w7edlj5WCWVtM/rQprsv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6pMR4zrBklJEknNRNWg6wl6duICDMw7i8fdWyTcChU=;
 b=Dx32cYXAQkyZ2QCL5mXRCYR0dZlXdLh0l6rNhRh8Q0mHiqCCkhn+otbfpLES+znYUv9Z7EPE/yvFa787StiPQ3MOGmLE7TgThYM3bEMB9KUjQUR+Fas6f7G39ULxm1VTOO25mHCb8gKcanNbzINa9SAkX2/+ZGGsCc8NgLTEWxrtk4p/mxvbErcwYYUg+p45svTknf4WTFkTnmkQHMR0nwP9N7UQnnsh72GoYFsJvMGaCKVpk2ePJMIrMOCkihdMsFWBxHbAB1c/yL+P+lPH4gT7fvbCOORlC8kayo3BGqZqE/V0vVdtImv3mZo/LE8pVtTUzR/LCn2BU60b3UQJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6pMR4zrBklJEknNRNWg6wl6duICDMw7i8fdWyTcChU=;
 b=TpWuLp5vBTaShTEwuwuTB5VUbROQbI5PvRYbgGaslB7Lw2r5lEWt/YaAxo4x7mfv45ysJldekUvBMNdd0RjW+DcelIK7zJNYudUgz4fXh9fwGIddxuSN5h4Cx2W0Cr0PMYFKTUiJ7LSbc4WPK2jkr3v1utFssBAcapAB7Ijxa/FQCWge0sq1oe10pBqwGlYBCmX8CedtKDnCoJwZMZKylNYQFGr01wy8tNoE103xGc2rqz7m9KJ8HzR9deJS1nR7r+lDwOaUNYUjsDUGKb591kAWdR2V2ZEtxuPEc0s7qXv25mIprqLxjDUK/ZjCPFItbHKxvQU8RPse6jqoolc+ZA==
Received: from BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:13::10)
 by PN3PR01MB6683.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:81::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 09:00:51 +0000
Received: from BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d3b0:ebc1:c2d0:d13a]) by BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d3b0:ebc1:c2d0:d13a%6]) with mapi id 15.20.8207.010; Wed, 11 Dec 2024
 09:00:51 +0000
Message-ID:
 <BM1PR01MB4515ECD36D8FC6ECB7D161C5FE3E2@BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 11 Dec 2024 17:00:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
To: Bjorn Helgaas <helgaas@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20241210173350.GA3222084@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241210173350.GA3222084@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:13::10)
X-Microsoft-Original-Message-ID:
 <012506a1-0358-475e-83da-7c2331336ed2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4515:EE_|PN3PR01MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: 653cf6c0-fe4a-41c3-8e1e-08dd19c24f8f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|7092599003|8060799006|19110799003|461199028|6090799003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0JEYW9jWWpJQVRWeDBsMjFVSzltSUlQRllYSXo0THRpQ3hkcGtnaUVhcFRj?=
 =?utf-8?B?ZnRITm9BZ1NoK0I1RGFaelN4RWQ4VGUydzdOS0VyeTh4SDhjRll5QUtOMWl4?=
 =?utf-8?B?cmNnTWg4ZEkwYUpoM2o5d3BpMDc1OXJLWExCQkNWd1FWV3RRM3Y1TDBwTGNn?=
 =?utf-8?B?a25NMnEzT2Y5Nm44blo5dGdSYUNYM0I3WGVWTDBSa2hSbzdqTGp1eml6eDNR?=
 =?utf-8?B?UDN4UjA4a1JhQUU3OHJuRnpHZ25ITTIzSWh1ZElSL2xnNFRDZWtvQitCdFRi?=
 =?utf-8?B?ekpHRENKREo1S281ZTdienNMZVdOMmVMNVBNYjhHZWJsMkE5MlBvK1NvOEVT?=
 =?utf-8?B?Tzl0bWdSY3FmWVZKUjg3VUJBcjFwT295MTVOd0NIekRFWnlFNjVRd1IzbUFy?=
 =?utf-8?B?dmlBa2c2VGU5WWlBVjczY1Uxcy9qYWdjb0RJRE9nbFVxM1FqOWdIaWszK1ZD?=
 =?utf-8?B?QnVobEx4dTRJVEhVc0tVTmg5Nmo2RDJZQ055UFltY2VOM2xnOHZtNFRvSUdm?=
 =?utf-8?B?ZStoR1l4cGc3cWRleHNnc2dEaE5jWkg5NmxZUDE4RDVkbFB6WENiclZSS1hi?=
 =?utf-8?B?blV2TFJsY0NXVlpmZjVxZ0RXaHpBckJBKzFPNXBIZFJWVFZBa2NrVDQ1ZVdt?=
 =?utf-8?B?Y1hhK3FhNk5hd0V5b2d5L1hjR0ozN1VoYlFLZk51WndiSGpkR25IZ0ludWFp?=
 =?utf-8?B?MHpxZmM0TWtTYmRqM29DZllOc0gyZmh0QU1BZ0tYRnpFbzU4Uk5oTm1pY0Zo?=
 =?utf-8?B?cDZlcjY1UUJwSUI5WjM4NUZlNHlJSWRDUlVaWXNPSnZPdFhwVGdpNWp6dlpZ?=
 =?utf-8?B?UVJubnhoRmZWNnJDL0dURFQveU9EMEg0ODc1K2FiZmtnT3V2cWpxQ0FtV0Qv?=
 =?utf-8?B?RjNoSlFXN2xlUkN4SmFVMUZkeVFtUkZmT1dnelZ5WDhqQS9uR3d3dnVsLzBK?=
 =?utf-8?B?YWNhVVdhWXNNTDV1czR6RVVQYWlqKzJYSkxBOFJxZVlMZ3ppSDRoeDdHVkdw?=
 =?utf-8?B?SmZvZ1ZSU0RBN3p2QkJ3U0hBZkNYalQ2dW8ydjYwdFlsVUZPRm1JR08xRklJ?=
 =?utf-8?B?YXNZWVlCQ2xNN1pZZWFCNkYxSTNmamdsNURZN01TWHBkOU5jVFNkdmdKTzNT?=
 =?utf-8?B?b0FVUUE0Yk5Bc3FDS0lSeDNsYlEzczlha0x2NmFqY2J0VlJqdmFDek1tbTNH?=
 =?utf-8?B?elZLNmorY05HZFNoMnByYnBzbTNCWTFTUnRueTkrMzNPTXpqYXFUSTF1VGtz?=
 =?utf-8?B?ZFdCQ212aG1FNlcwZGJLbFlnRWtYWVJYNkZmQ25hNTc5ZDc3V1VJeHNsOWpk?=
 =?utf-8?B?cTNDUzI1dnJKdkhVNVF1NlByYkxZNmYxZ3V3S1IzeDVMckk5anNsbGs2TFR2?=
 =?utf-8?B?bW5VK3IxeEpaQ3ZLZXBwZkdNYWFxWlpOYkFGbkJFYzhxaTBUNGltdnZoOTd2?=
 =?utf-8?Q?mcw0s8xL?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGdaNWVZNGVJcUJETy81NWdBVkZMU251NkhzbERGWDBlVElMYVRBQXRwc0dS?=
 =?utf-8?B?VHlLbDBlVFZXK1R2VXZkSWxkS1EzelRGbEF5NW1uVXhMZXBRSEdmS2FyaWFh?=
 =?utf-8?B?VUp5cjR6TmdGZ2lTTW5pbWNlaVFMcU00blVxbzFOL1kzNlJ5M0JNVFMwb0N0?=
 =?utf-8?B?UnhyaFNZNWV3WEJQZGpOZ0g1T1o5cmlqVzZyb1J6SnBzZTZjS2xyY2ZQaTNi?=
 =?utf-8?B?WUJVYUg1ZTdqYjhtaU9INktsaGF2ZjN0NUV3OWtkS1JDYkZhY3phdnNqN1Fu?=
 =?utf-8?B?LzNpbVQ4K0NxaFhYWDZEUWRCSFVkb3JCdlpIQXdyZ2dOcnJWU2tOZDRZcHZ0?=
 =?utf-8?B?eFBtRXBickRmMTFBWEp5NEFTWlJLQ0VranA5VFRiVlRVWE8wQmhDd2ZyS1V2?=
 =?utf-8?B?UFZJT0x4bDNQb1N5eCtpaTNVT0tJeVdvU1JQRHpBVUxJNFh5WGFZY1IrVVdT?=
 =?utf-8?B?OHlLaW9RRUxDMEsra2d0SER2dHZLejFGNmRrNUlIbXYyUW5WT01oRDF5cVNp?=
 =?utf-8?B?emhGQ0E4RHc0cEZMR28wQXB0MFBTd29TNFB3UFpzNEYrUHNneGM1eVdrR0Zz?=
 =?utf-8?B?L090UWhjcWFxRzdJd1Arbit1bmkrWmp4aVJVbXVGT2JrZXl1MGVYMitoN0JH?=
 =?utf-8?B?ZkVWck9rWEs5Q2l2YVZzNVFXbEMvRW1zdFp3MzlYRUt4aGFIdTVYVWRoUXdi?=
 =?utf-8?B?ZGE2MXZSTzgyak9ZbGhSWmdKZ2JORzVQL2ZnSlAvcy96RXNCcExXb3hUbm9Y?=
 =?utf-8?B?ZUIzeGl4NTQrOEVOOHQ5V1BJM3JqZUxOQVQ5ZDAxenBTamxCUTIrRFd3K0dP?=
 =?utf-8?B?dzdOaTRHTnQvQVozNzRPYjJzeFp6ZlZJZXRGN2hydUx2dzUzVWRFSTVhT1FR?=
 =?utf-8?B?STgvOWxJaEdxdC9yL1Z4cjZSUTltbEloSlVYcWpkY2xHd3NHemNjWDlLcUQ4?=
 =?utf-8?B?VjU3SnZiWS9TeEpzY0xGVmgwYW52Ym4rNWt6SUtWL3ZRSTUwaWF3Rkx6WmRv?=
 =?utf-8?B?VDhpY2E0K29Pdk11T3BOVGNSc2FoSmYvMkwraSt6dy83LzNyVjZXR2NNbnBy?=
 =?utf-8?B?MEltUjNUWHlheWJzOXA4ZXNvQk42Rjc3S0dmWjRZZFFxanFjbTZwTEdFelps?=
 =?utf-8?B?YUtTbjAzbVpTZ2x5VFlCYlVGVVpnQ3dZTk9pMFRyU0FleHVjU1ZoTXZMVXBK?=
 =?utf-8?B?YnJtbGdncXZoT3pHbzNlQ0xNYURMR2Z4UzZtaUNlV3hvVjJOWHVXbDlreVJm?=
 =?utf-8?B?djBLQnBqWVBXQmkvR3N6aVVkWmZxeGJTZFUxYTd1WGdKWlN2Nm05eWpHR3U1?=
 =?utf-8?B?dFdGMEJRQk1rSGlvcHdKRGtEVjhLOURtVjUwS3RteTI1U2t2dkNnend1Mjdk?=
 =?utf-8?B?bWlMd1NRSmJSOTFIVXM2ZGFVL0dGTldVSGpXMGpyaTNibk1PSldacVE3NVhO?=
 =?utf-8?B?R1F2MUU1R3prRzFEMnlJUXJaeDlvVEkranF0ZHdtME84UnViYWtFRGdsQSs3?=
 =?utf-8?B?UU5lTENLb2RTRE8rRTB0QlZvTEkrQ3AvYW9zZlViS3hCNUJWRTdIQ0w0YUVy?=
 =?utf-8?B?cGtYTzd0aFhVQUtqWXgvcHhkVHF1R29lbnRXNlNkUjczTXBQaGJjb2VZWG93?=
 =?utf-8?B?K29DYTNGZDhMQkxseW9aa2NsQVl4eXZSVXZhYnlCVWVaL0k5bEo0M2lrcnlY?=
 =?utf-8?Q?E8RFHDtdITidQmKXNaIv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653cf6c0-fe4a-41c3-8e1e-08dd19c24f8f
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4515.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:00:51.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6683


On 2024/12/11 1:33, Bjorn Helgaas wrote:
> On Mon, Dec 09, 2024 at 03:19:38PM +0800, Chen Wang wrote:
>> Add binding for Sophgo SG2042 PCIe host controller.
>> +  sophgo,pcie-port:
> This is just an index, isn't it?  I don't see why it should include
> "sophgo" unless it encodes something sophgo-specific.
I previously understood that if it is not a standard attribute defined 
by the dts schema, such as pcie-port, which is defined by me, it must be 
prefixed with vendor. Is that right?
>
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      SG2042 uses Cadence IP, every IP is composed of 2 cores(called link0
> Add space before "(".  More instances below.
ok
>
>> +      & link1 as Cadence's term). "sophgo,pcie-port" is used to identify which
>> +      core/link the pcie host controller node corresponds to.
> s/pcie/PCIe/ for consistency in the text.  More instances below.
ok
>
>> +      The Cadence IP has two modes of operation, selected by a strap pin.
>> +
>> +      In the single-link mode, the Cadence PCIe core instance associated
>> +      with Link0 is connected to all the lanes and the Cadence PCIe core
>> +      instance associated with Link1 is inactive.
>> +
>> +      In the dual-link mode, the Cadence PCIe core instance associated
>> +      with Link0 is connected to the lower half of the lanes and the
>> +      Cadence PCIe core instance associated with Link1 is connected to
>> +      the upper half of the lanes.
> I assume this means there are two separate Root Ports, one for Link0
> and a second for Link1?
Yes. So the naming of pcie_rcX is wrong, I will correct it, thanks.
>
>> +      SG2042 contains 2 Cadence IPs and configures the Cores as below:
>> +
>> +                     +-- Core(Link0) <---> pcie_rc0   +-----------------+
>> +                     |                                |                 |
>> +      Cadence IP 1 --+                                | cdns_pcie0_ctrl |
>> +                     |                                |                 |
>> +                     +-- Core(Link1) <---> disabled   +-----------------+
>> +
>> +                     +-- Core(Link0) <---> pcie_rc1   +-----------------+
>> +                     |                                |                 |
>> +      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
>> +                     |                                |                 |
>> +                     +-- Core(Link1) <---> pcie_rc2   +-----------------+
>> +
>> +      pcie_rcX is pcie node ("sophgo,sg2042-pcie-host") defined in DTS.
>> +      cdns_pcie0_ctrl is syscon node ("sophgo,sg2042-pcie-ctrl") defined in DTS
>> +
>> +      cdns_pcieX_ctrl contains some registers shared by pcie_rcX, even two
>> +      RC(Link)s may share different bits of the same register. For example,
>> +      cdns_pcie1_ctrl contains registers shared by link0 & link1 for Cadence IP 2.
> An RC doesn't have a Link.  A Root Port does.
>
>> +      "sophgo,pcie-port" is defined to flag which core(link) the rc maps to, with
>> +      this we can know what registers(bits) we should use.
>> +
>> +  sophgo,syscon-pcie-ctrl:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the PCIe System Controller DT node. It's required to
>> +      access some MSI operation registers shared by PCIe RCs.
> I think this probably means "shared by PCIe Root Ports", not RCs.
> It's unlikely that this hardware has multiple Root Complexes.
Ok, I will fix this.
>
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - vendor-id
>> +  - device-id
>> +  - sophgo,syscon-pcie-ctrl
>> +  - sophgo,pcie-port
> It looks like vendor-id and device-id apply to PCI devices, i.e.,
> things that will show up in lspci, I assume Root Ports in this case.
> Can we make this explicit in the DT, e.g., something like this?
>
>    pcie@62000000 {
>      compatible = "sophgo,sg2042-pcie-host";
>      port0: pci@0,0 {
>        vendor-id = <0x1f1c>;
>        device-id = <0x2042>;
>      };

Sorry, I don't understand your meaning very well.  Referring to the 
topology diagram I drew above, is it okay to write DTS as follows?

pcie@7060000000 {
     compatible = "sophgo,sg2042-pcie-host";
     ...... // other properties
     pci@0,0 {
       vendor-id = <0x1f1c>;
       device-id = <0x2042>;
     };
}

pcie@7062000000 {
     compatible = "sophgo,sg2042-pcie-host";
     ...... // other properties
     pci@0,0 {
       vendor-id = <0x1f1c>;
       device-id = <0x2042>;
     };
}

pcie@7062800000 {
     compatible = "sophgo,sg2042-pcie-host";
     ...... // other properties
     pci@1,0 {
       vendor-id = <0x1f1c>;
       device-id = <0x2042>;
     };

}

And with this change, I can drop the “pcie-port”property and use the 
port name to figure out the port number, right?


>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    pcie@62000000 {
>> +      compatible = "sophgo,sg2042-pcie-host";
>> +      device_type = "pci";
>> +      reg = <0x62000000  0x00800000>,
>> +            <0x48000000  0x00001000>;
>> +      reg-names = "reg", "cfg";
>> +      #address-cells = <3>;
>> +      #size-cells = <2>;
>> +      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
>> +               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
>> +      bus-range = <0x80 0xbf>;
>> +      vendor-id = <0x1f1c>;
>> +      device-id = <0x2042>;
>> +      cdns,no-bar-match-nbits = <48>;
>> +      sophgo,pcie-port = <0>;
>> +      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
>> +      msi-parent = <&msi_pcie>;
>> +      msi_pcie: msi {
>> +        compatible = "sophgo,sg2042-pcie-msi";
>> +        msi-controller;
>> +        interrupt-parent = <&intc>;
>> +        interrupts = <123 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-names = "msi";
>> +      };
>> +    };
>> -- 
>> 2.34.1
>>

