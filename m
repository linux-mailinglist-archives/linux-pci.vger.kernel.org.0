Return-Path: <linux-pci+bounces-20645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F1A25141
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 03:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C511639DD
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 02:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9773F29405;
	Mon,  3 Feb 2025 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RydyDGkb"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011027.outbound.protection.outlook.com [52.103.67.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D7AD23;
	Mon,  3 Feb 2025 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738550156; cv=fail; b=DvlP9vEbqp8mOu7MaWz/bDKlY3mKhD1N9j7Dc8x+8JuiD5BavIVSFE3ewgakrh8A1xWRm1xPgYMIsrphidbx8ZM41JQoiSJidFgVEOCmkm+SIFNR3ZPBSHmCAeQXtXWbZMjcLdqDfMX1WY2u9XmdhcQrSsDtqq5babRbgC8TlwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738550156; c=relaxed/simple;
	bh=dZwv3bQOBAAll+e0LQH+ZCN89DZrkEigX6E2Y1/PHNk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I9uPJpaVg64x85EAsFz1edLX8cPm3GPVxawDB7wC/zU5+iu9tU5G5n6Ka6KBDmMqo0rYClcwSVh/3REZOlg2+ESuKqNu47otq7x4w1kjFapL4MsPY+wUm7pA9L6OT7qf7MDa59qiTe2CWqPgq/xWNUvL7gR2/emBVoiryl7/dhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RydyDGkb; arc=fail smtp.client-ip=52.103.67.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/sC8hnI+v3RqJQwjguNWVaEWCFqFdKUBD6MY2e5Sqq+EKJQ64I53ohvC3/4l2NAX7trA6Zhw9Olk87OBSjuZh+i5+K+9G9UJZxNwHm281LjopveDOh6T7KvUvEVU00jVPdkhN+J3gdLRXOnANiLu+AsUTasBNly4qVKJDHFCDMCrCzoacvrbSpTN1xl/OHJOqfOAZFOFK7ZsPLdLLKkQMlahIjFLcmNi9UBYdFeYOswTQpoHTq/G8HOVNSfQyZ5HSAz/bkbdgqksslm1ivFY0UIxhqWY9PIobwGaH0i0VWg/wfZMZpPd8LJ3O8W/yb8259r1QYu8Q+S49p+cS+/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFZzq5OR//dbgbVT1l5nbWLUvqmmnSfpLFumz/u2Kis=;
 b=Sx6l3qVFcswd3jwL3M8fuY8qMN2KGSLW3AlfmWvjNiamMTR1aqtZoiHOLDETaCXObZxM1Duw1I0SlSaXcQthNlCjwcnaj7JlQWGAQntCMBXgBOI89Tmt/tQhRh7aVqTe9HGQR4yQisc+y+SX++yxGgHhA+Mx2ZwPVBHFHfkl6uv36nu7fp773S+m59A0MDHWe1gzh7C+oeLPfqCusbWLcYpHUgx7/mPnfcWzuEn6j9ob7GLCtoZBk85B2w+LHDH4Nj5H2TA3EQkvCdMbWS8Tte7z88MpZM0ghuMrJVXKwSOejdBy5sEu5A6E1wYbkLVtRkBi+QV8bLO2XykkU/EonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFZzq5OR//dbgbVT1l5nbWLUvqmmnSfpLFumz/u2Kis=;
 b=RydyDGkbTaLJ4CvkdXWP1lQSISP0TIGwN8UNlvbfETSQpcbRAqi8FStDEhULXXLvxgPuz6CgAoSZT2rQ0NvBPWZ+DnmbkDkekjmS3Kv16sgrwI+1ilM9MtjyKCdia+YGZEeoRwxipeNGPNEuVhh0WjnxkLHGDPN2MjcQgdpLnlL/XC+HPgtX4T/sptxPVJiH/awlhJ6SwMVyteHnBLHKibAaOEyI7Q5bEKe6bPaS+jcgEjpMFFCuXBNOw/eQ1lUdkMDCiYn9pr3sJU0DoSWdSuUROJvcF6q60fe7Tt9iXdMA4m36K9a3MgRyuHiIJg6E0cNE9mNpsBObcuyS6K8PEw==
Received: from PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ba::9)
 by MA1PPF6F7A0F25D.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a04::97) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 02:35:33 +0000
Received: from PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e59c:e6ad:e596:123b]) by PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e59c:e6ad:e596:123b%3]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 02:35:33 +0000
Message-ID:
 <PNXPR01MB748840AED6CBFF32269D80C2FEF52@PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 3 Feb 2025 10:35:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
From: Chen Wang <unicorn_wang@outlook.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20250122222147.GA1117670@bhelgaas>
 <PN0PR01MB6028C76DCC20B81498081CE1FEED2@PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN0PR01MB6028C76DCC20B81498081CE1FEED2@PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ba::9)
X-Microsoft-Original-Message-ID:
 <484c7787-b086-4357-94d3-3a73e121ce00@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNXPR01MB7488:EE_|MA1PPF6F7A0F25D:EE_
X-MS-Office365-Filtering-Correlation-Id: af5cc2be-0e36-412d-0b0c-08dd43fb6ec3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|5072599009|461199028|19110799003|6090799003|8060799006|7092599003|41001999003|1602099012|3412199025|10035399004|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEtOd0dBcFRCZWpTdW9ic2t3S1hxckVqc0xZclQ2WU5ibU9TTldkdklES2lP?=
 =?utf-8?B?N0svb2RacUNoOU5RQW0zMGRzK3l1TEl6TGxkSjBuNFl3UXBlSXJodUUySFR2?=
 =?utf-8?B?ZlpSenNEUWJKVm9xL3h2UUxzRnQ4SkRWWlVrZ2psZytHeWZqVEZsTWd0K1RK?=
 =?utf-8?B?V2l3d3FOSWRkWjd0Q2REWG1lQ1ZpcncweVR4dCt2Tkw4ejIzOS92cFBSQTNY?=
 =?utf-8?B?RDgyZG5QcGZld3VISFNBRjZDZW15WkUxQ0Rjd0FIZ2JOTW9MK0Y5WHN5b0oy?=
 =?utf-8?B?SnpCYTByVmlENVk4UXRTVTU2SGFDZHk3SXRCWjlnVndkZldXWCtRL0M0ZVVp?=
 =?utf-8?B?cXUrVGZZTkFmVjZsdGpEcFdkRkVhejA1SkxZSnphNnhxeFlBQ1YxUkNYYmNV?=
 =?utf-8?B?eE4zcWN6OHdPTEc5d2hnQTBsaS9Vc1pLZ2Y4SFlsYmNJbXpocXRxbU9SUis5?=
 =?utf-8?B?Sk1wY2FNOTQrOVplWkU2R2NJdVhyUG1hbDRBOXlvWmxtNEpNYW5VRmdaSVh2?=
 =?utf-8?B?YTdDc1ZiS0RENUVFc2JDaEJtZUtiYmZzSm54L2pWRTFuMGlDRUxlVjY2UkxH?=
 =?utf-8?B?YnNWWkZhY3F5aDdYTXUzd2pENmdEOW9wUk9Ea3BOYUxjUUtwcTludURuOXk3?=
 =?utf-8?B?RTdzRVpBWmxFcVFtditFZVp2NVM3aWFpNFdDUTBvRkFVYzgwalFEaHpFQjVW?=
 =?utf-8?B?MVlEYmgrMUpiMEtFSVFRYkY1Vmx4V1Rua0FtVHVKbmR2OHNhMzlWY0xRcDFx?=
 =?utf-8?B?MHRRWDdnNmZIMkN1c0RhY1hLOG9aWFEzT0lraVJFUlkyTDNJWVQ2TWprb2J2?=
 =?utf-8?B?SloxdTNDNGNTZjFsZXBhMERsdEpNRWFvTGhZWStpa0Ria0ltdGsyRzFjdWVF?=
 =?utf-8?B?WEFwaDEzWVdON051RHdnendwUys5VTIvWCtpNDU3VWZzVkUxRHFRb3RoV2JF?=
 =?utf-8?B?R3drc3FPQ1I3Y1VGM254WVp2UkVYLyt0MnFNM2lLQ0R3cHJON3Y5b01uNCtt?=
 =?utf-8?B?RjNsY1Z2b05BRXBiL0dLS25IdGRwSUczRUhNQ2RVNWg4RzlCMSs3QXI0S3Fw?=
 =?utf-8?B?dENhOTNEbDg1UlBPeW52dEZBSWF0QWZBTCs4K1dCeW13NC9xNW8wZGt0WUgx?=
 =?utf-8?B?MjUyVVJIb25zYmxVZkdDV3AwamlMd3ZwTXFsMzZYbVlIbmlncEtaOVJkTzVy?=
 =?utf-8?B?bUpVbTR6cUY3RnJyamhUeWxWQWg5OThIaUR2MzdLclhLOFZOYWFUaFNndVpJ?=
 =?utf-8?B?M0ZIWFF6b1hIMld3L0kxaVlFWW00VUZueGpHQlYrUHQ0QkNPRjZFbFVSQzVN?=
 =?utf-8?B?N2dUczBsUVdCQm1PeWxYclpnS2h4RnpqcklGVlZTclNxSENZM0ZPY3c5b2Zn?=
 =?utf-8?B?U0VmeDJvMWVHUWh2UkRIdlFUTFhuaDJxaC9ENXlwa2ZmZkVCTG14d0V3R09w?=
 =?utf-8?B?bnFNWXJUU1d4Q3E5eHpUaUtRR2MrQ3ZhdThRWE1RRnJhQUN1S2J0Q0Y2WE1G?=
 =?utf-8?B?SDZjcEMvbXp1ZzVnSGUyeGN1OW1xOTlHK2k2YmNtUm43S2lnL01KYkpiRXFk?=
 =?utf-8?B?c2V3SThCNlNvc0puK0lZbFk4Tk1IOEFWanhkTGZqQm1sR0VJY2VuWHhmeDlI?=
 =?utf-8?B?dXpSZ1lQVFcvWit0eXprcDRrbjFmQWFxOXBORU5zaDhjNEN6SnRQcnIxTW1O?=
 =?utf-8?Q?k4s8kP1+wSXEWlQ5nTxb?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1l1SlVlNWljTTQ2bzZQeGZnR0lpWWY5NnhvTUdyZ0xGdWN5TG5TRHJZa041?=
 =?utf-8?B?QmNCNERjd01kU3lmWU4yYzRTd0lQUU1VMFY4ZUtxdERqOXlRRmJkd1ZraWNV?=
 =?utf-8?B?SDIxMnUvM3poaEZDMmcrSGJJMkp0ek00WUxBcXRWVEVSSC9QU1FpUUJVc1ZO?=
 =?utf-8?B?bEl6TWpwWjNOQ0dYb01Cc2tTZVp2VWY5eDh4RzNKUVhYajNHeU5PMzdMb2Nh?=
 =?utf-8?B?NXFPTG9PYUZMNHhmSTRIa0NFQ09YY1IzMVBWTFlaMEd6cUppZHdKcmo5MlRw?=
 =?utf-8?B?aVJLdCt6dXRvd0VJMXIrakNRcitnYTNrTElJdndxT1NUTzlGU2VnRTRhZnZE?=
 =?utf-8?B?QVN4NXQ0dUJYVnN1MG1IK0RVRFRKWm5tQVpESmRZblNTWVdDc3U1aWxzK1JW?=
 =?utf-8?B?SWhnUFJtS256Q1VFSDNNTm5hWFc0UVF5YU9aQ3h5dG8xZDh3TUorbi9yNTAx?=
 =?utf-8?B?VjdqOEppVkJmY2x2WUVHcVJaZ0FQdUV4dU5HanBxVEwzWmNGREh3RlhlcUJL?=
 =?utf-8?B?WDd4aVoxT1VETjNkcWxhalNOUWFLZXNBNnYwRHRvenYrek8vWms5S0RpeHFN?=
 =?utf-8?B?ZjBkMUUxNHFTK2Vqd3NDZWx1Tkd4RXBGcmk4akN5WUJlSkloVzFXamhOUmdI?=
 =?utf-8?B?RWg1clBKNkoxbEZEa0NsNUJkQXdxKzlOSXVOOVo5N3ByWVp1WHh2c0VaSjkx?=
 =?utf-8?B?aGRwc2wxTGxvbXd2L3RKcys2QURzdldoMmJ3YkdwZ3RsanpSL012ZS9lM20y?=
 =?utf-8?B?b3FleE9Hb3pPR3NCYm9yakRYdmJMb2UvUDVObW9WVDBnNjhVcHh1T3JQV3Rm?=
 =?utf-8?B?NS9CR0h2dVFreWorcWN4aXFxSWhPZTduQ2dzZ2lPU052TFN5c2J5U2ZLci9V?=
 =?utf-8?B?dGRYYThGL0NFc3NtRklOaXFXTHVHOXBnMkJMNk1vTVcwSGRCaGcvR1Z3MEFl?=
 =?utf-8?B?ZWNwYmVtdHQ5WEsxMTJtNFp4VE5OU3FwdUE5VlRXZVdmS1l5blNPTHZVT29R?=
 =?utf-8?B?ajdobjYvVis2allsSERZa1NubENyb3hOTHJIK1dvZGRESXRoRzJqL0E4Z0xn?=
 =?utf-8?B?bWtRUFJEN2hoQUY4bjEyQmIxQlZvcWlzOHQ1eXBHOW1XWEVnN21penU1Uy9i?=
 =?utf-8?B?emdvbWM5ZHgwUVNIdkRQRHVKRjNXQkV2VUlzVEtRYnVPREtoc01oQi9uWHFH?=
 =?utf-8?B?aVhlenBMY0ZNWXozYmVLZm5vbVByeWM1bVBKTEg5RUE5ei9wbllDb3VWN0Ry?=
 =?utf-8?B?MU1pTWFjbExHTEJkNFZXTmdJL0U1dklzZTFtRDlWeXJKeGV2ZXE2dEpQU1Uy?=
 =?utf-8?B?NG9yeXMxaXdRcWwvYXlPQU5SSjYwL01WRnVrRndNc1lKK2NhUjhTVmRrZmlx?=
 =?utf-8?B?aXBwbjNzRzRNVU85ZHpZOGRaT2RiYlhmYUZVYm5pSGFMTFE0cU02cHFEMVJS?=
 =?utf-8?B?bElsMHJtTVRGZU1UeUlqZUdHWHhDYUIxR2tVbktib1ZxQlhaQUpsREM1MzB6?=
 =?utf-8?B?Tkl4YVdDSTBkNVh3NHFUQWxxa3F2L3NQMjB2Y3NaMEdYZHpDRk1qK05uR3Vl?=
 =?utf-8?B?OXpFbDArYXZkZlFEdSttU2tuUzFCZXBoWEpZTDdJaHdVbHNmWmRxclhMUTQy?=
 =?utf-8?B?YTJPZWVuTGpLMm5xZnF5M3puUFlWSmxVWE1Rb1VObjFuZ0ttc05MTUo0empB?=
 =?utf-8?B?clVNZHpQUEM0Mm5YbGxhUUo1djI2RysydnM5TFRPOVp3Slh6UVh3YXJRcDZt?=
 =?utf-8?Q?0pgiFDLTIYt84/enWxcVz1I2CxGoNeqqycXPEP1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5cc2be-0e36-412d-0b0c-08dd43fb6ec3
X-MS-Exchange-CrossTenant-AuthSource: PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 02:35:33.4270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPF6F7A0F25D

hi, Bjorn, what do you think of my input?

Regards,

Chen

On 2025/1/26 10:27, Chen Wang wrote:
> hello~
>
> On 2025/1/23 6:21, Bjorn Helgaas wrote:
>> On Wed, Jan 15, 2025 at 03:06:37PM +0800, Chen Wang wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> Add binding for Sophgo SG2042 PCIe host controller.
>>> +  sophgo,link-id:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: |
>>> +      SG2042 uses Cadence IP, every IP is composed of 2 cores 
>>> (called link0
>>> +      & link1 as Cadence's term). Each core corresponds to a host 
>>> bridge,
>>> +      and each host bridge has only one root port. Their configuration
>>> +      registers are completely independent. SG2042 integrates two 
>>> Cadence IPs,
>>> +      so there can actually be up to four host bridges. 
>>> "sophgo,link-id" is
>>> +      used to identify which core/link the PCIe host bridge node 
>>> corresponds to.
>> IIUC, the registers of Cadence IP 1 and IP 2 are completely
>> independent, and if you describe both of them, you would have separate
>> "pcie@62000000" stanzas with separate 'reg' and 'ranges' properties.
>
> To be precise, for two cores of a cadence IP, each core has a separate 
> set of configuration registers, that is, the configuration of each 
> core is completely independent. This is also what I meant in the 
> binding by "Each core corresponds to a host bridge, and each host 
> bridge has only one root port. Their configuration registers are 
> completely independent.". Maybe the "Their" here is a bit unclear. My 
> original intention was to refer to the core. I can improve this 
> description next time.
>
>>  From the driver, it does not look like the registers for Link0 and
>> Link1 are independent, since the driver claims the
>> "sophgo,sg2042-pcie-host", which includes two Cores, and it tests
>> pcie->link_id to select the correct register address and bit mask.
> In the driver code, one "sophgo,sg2042-pcie-host" corresponds to one 
> core, not two. So, you can see in patch 4 of this pathset [1], 3 pcie 
> host-bridge nodes are defined, pcie_rc0 ~ pcie_rc2, each corresponding 
> to one core.
>
> [1]:https://lore.kernel.org/linux-riscv/4a1f23e5426bfb56cad9c07f90d4efaad5eab976.1736923025.git.unicorn_wang@outlook.com/ 
>
>
>
> I also need to explain that link0 and link1 are actually completely 
> independent in PCIE processing, but when sophgo implements the 
> internal msi controller for PCIE, its design is not good enough, and 
> the registers for processing msi are not made separately for link0 and 
> link1, but mixed together, which is what I said 
> cdns_pcie0_ctrl/cdns_pcie1_ctrl. In these two new register files added 
> by sophgo (only involving MSI processing), take the second cadence IP 
> as an example, some registers are used to control the msi controller 
> of pcie_rc1 (corresponding to link0), and some registers are used to 
> control the msi controller of pcie_rc2 (corresponding to link1). In a 
> more complicated situation, some bits in a register are used to 
> control pcie_rc1, and some bits are used to control pcie_rc2. This is 
> why I have to add the link_id attribute to know whether the current 
> PCIe host bridge corresponds to link0 or link1, so that when 
> processing the msi controller related to this pcie host bridge, we can 
> find the corresponding register or even the bit of a register in 
> cdns_pcieX_ctrl.
>
>
>> "sophgo,link-id" corresponds to Cadence documentation, but I think it
>> is somewhat misleading in the binding because a PCIe "Link" refers to
>> the downstream side of a Root Port.  If we use "link-id" to identify
>> either Core0 or Core1 of a Cadence IP, it sort of bakes in the
>> idea that there can never be more than one Root Port per Core.
> The fact is that for the cadence IP used by sg2042, only one root port 
> is supported per core.
>>
>> Since each Core is the root of a separate PCI hierarchy, it seems like
>> maybe there should be a stanza for the Core so there's a place where
>> per-hierarchy things like "linux,pci-domain" properties could go,
>> e.g.,
>>
>>    pcie@62000000 {        // IP 1, single-link mode
>>      compatible = "sophgo,sg2042-pcie-host";
>>      reg = <...>;
>>      ranges = <...>;
>>
>>      core0 {
>>        sophgo,core-id = <0>;
>>        linux,pci-domain = <0>;
>>
>>        port {
>>          num-lanes = <4>;    // all lanes
>>        };
>>      };
>>    };
>>
>>    pcie@82000000 {        // IP 2, dual-link mode
>>      compatible = "sophgo,sg2042-pcie-host";
>>      reg = <...>;
>>      ranges = <...>;
>>
>>      core0 {
>>        sophgo,core-id = <0>;
>>        linux,pci-domain = <1>;
>>
>>        port {
>>          num-lanes = <2>;    // half of lanes
>>        };
>>      };
>>
>>      core1 {
>>        sophgo,core-id = <1>;
>>        linux,pci-domain = <2>;
>>
>>        port {
>>          num-lanes = <2>;    // half of lanes
>>        };
>>      };
>>    };
>
> Based on the above analysis, I think the introduction of a three-layer 
> structure (pcie-core-port) looks a bit too complicated for candence 
> IP. In fact, the source of the discussion at the beginning of this 
> issue was whether some attributes should be placed under the host 
> bridge or the root port. I suggest that adding the root port layer on 
> the basis of the existing patch may be enough. What do you think?
>
> e.g.,
>
> pcie_rc0: pcie@7060000000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // host bride level properties
>     sophgo,link-id = <0>;
>     port {
>         // port level properties
>         vendor-id = <0x1f1c>;
>         device-id = <0x2042>;
>         num-lanes = <4>;
>     }
> };
>
> pcie_rc1: pcie@7062000000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // host bride level properties
>     sophgo,link-id = <0>;
>     port {
>         // port level properties
>         vendor-id = <0x1f1c>;
>         device-id = <0x2042>;
>         num-lanes = <2>;
>     };
> };
>
> pcie_rc2: pcie@7062800000 {
>     compatible = "sophgo,sg2042-pcie-host";
>     ...... // host bride level properties
>     sophgo,link-id = <0>;
>     port {
>         // port level properties
>         vendor-id = <0x1f1c>;
>         device-id = <0x2042>;
>         num-lanes = <2>;
>     }
> };
>
> [......]
>
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    pcie@62000000 {
>>> +      compatible = "sophgo,sg2042-pcie-host";
>>> +      device_type = "pci";
>>> +      reg = <0x62000000  0x00800000>,
>>> +            <0x48000000  0x00001000>;
>>> +      reg-names = "reg", "cfg";
>>> +      #address-cells = <3>;
>>> +      #size-cells = <2>;
>>> +      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
>>> +               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
>>> +      bus-range = <0x00 0xff>;
>>> +      vendor-id = <0x1f1c>;
>>> +      device-id = <0x2042>;
>>> +      cdns,no-bar-match-nbits = <48>;
>>> +      sophgo,link-id = <0>;
>>> +      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
>>> +      msi-parent = <&msi_pcie>;
>>> +      msi_pcie: msi {
>>> +        compatible = "sophgo,sg2042-pcie-msi";
>>> +        msi-controller;
>>> +        interrupt-parent = <&intc>;
>>> +        interrupts = <123 IRQ_TYPE_LEVEL_HIGH>;
>>> +        interrupt-names = "msi";
>>> +      };
>>> +    };
>> It would be helpful for me if the example showed how both link-id 0
>> and link-id 1 would be used (or whatever they end up being named).
>> I assume both have to be somewhere in the same pcie@62000000 device to
>> make this work.
>>
>> Bjorn
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

