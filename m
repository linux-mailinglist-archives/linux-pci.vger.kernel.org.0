Return-Path: <linux-pci+bounces-23555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D401DA5E837
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 00:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A203AF570
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 23:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F3A1F1526;
	Wed, 12 Mar 2025 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ehc7Dvcw"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010002.outbound.protection.outlook.com [52.103.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD111F1517;
	Wed, 12 Mar 2025 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821438; cv=fail; b=fdO6T1LApLTjhO4VbfIhsU6IwoH7daDRSXTXnCSr2xi81AtKk5I5jdFB2b7TTQXco4sp8EBT/HSKM4XSW5UvkfDa1GjZW4HAF9fckByYarS5gxikpUlfVyMiZmNi1eR4a49Jq10vKb/KeiIla5iwS96ywSiLuapqJll/92UbE48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821438; c=relaxed/simple;
	bh=K6WukhTjalWsQe+n+6Tv76rm5LNZab1hitRba/6uCiw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mxObQSjGteHSbUAiTnHF0Hki2HRZD7NYP3eX2T1Vxhzo7ScVTG8StcCfgIu2vBFwEDgMrpMnO5tNuTAgnI+nbM6e7dznbWS57KDd2kt/bMkV2U1z24XullzUvLYmj5fK7zqTN47rjDSJnOlaTVHNCt6K3fghyamZYyzeDvvTwfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ehc7Dvcw; arc=fail smtp.client-ip=52.103.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5GsU2RAqf0DFCTi/p09FgqFUQolQHoIyPFlI2rxM2xX+wkm6eHZp9KN/h969i3+6zzH8zBsOFcjcsDMgk2XMc4WpDoKiOZ64/15BV8vYhix+MpZtFwW9erdPbiX7vmrDarx6HJVYzykS9YNduVqYkaGPSi1PFdLKx6N1BUWogFo1V6RDP7mpk7Vily0u7QErqebkUvEYOQXMQJuLyQMeMdGGBThFgLG1REz3H3sRDqzf3tHhkUUqf6XSlw0dLP6ld+SpTyJPbckMg6JnlDBW+3A2FEQhDSj3awd8RkDHLvKtu6oEuQmAyj3Y1DCGFNLk2jTSPcFWEVdzupXU5pXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4vvww9v+SacrEJKoTdJITLehYVwNp6+vV6KFBSSwMw=;
 b=SBDaUiJzNDpONLoOM3N9ixnA/iRz/Q8FMg51YHueaQzdcpBNjFU9/+V/WU4FQ6k/mlhHcKwc5r6JFTkkk2S49QJWuuvlr6mdTNgjbHuirFuF1Et4fbXpguUP/CaSa2R3l1s/VuQctPGaxAqjp0ERteb+nwpaYz9bW7RplruUIpbv4n3zfo/jlufmYqDxv+69W/Eo41eDatyI2Jy0cqxhflc9whAI++H04pnppK6DcTSJElKlXTejdXvwFd+75BmpEF23/NUX1Ajy1gTivEj+1sCHILedTFCgN6Rwmw4UOcC+5jHhBN640PxjCUsivIibXY2AUTC4L7eFXs4MZnE2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4vvww9v+SacrEJKoTdJITLehYVwNp6+vV6KFBSSwMw=;
 b=Ehc7DvcwQo6y9Z6XAYRWETM9aQfnbYLw16xWXy5p6BLnqPAGCuRTUeYFCPf8yBCf3+vBrMg2Argta/ZtF/J4sSyqdMPdggk5JKgL/eswjRZhx1bflF2gZ0UbN+SNu4rvNTJhLVyUIYXvO1ItL3xa/2PxmVg23OzQW18gUYbxZ2BCxTB+a/R8pG67Xc7LcfWc2m9ACHSr2X6WEu1Oel3q92tGf373cjwFKFhobnjzMPrnGI+uQ0yJKjcyZ2NJj9cOR4I6NPJxytpn95f37pVTkaot3nOSKlzUXnPbpC5deUCvU4O3qnughSlaz8ZIw9T1Lml6/Dl46i+pJl2CKqNMQQ==
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14) by MAZPR01MB8163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:84::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Wed, 12 Mar
 2025 23:17:08 +0000
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5]) by PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5%3]) with mapi id 15.20.8511.028; Wed, 12 Mar 2025
 23:17:08 +0000
Message-ID:
 <PN0PR01MB10393C19522C3D75500E770B1FED02@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 13 Mar 2025 07:17:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: Fix NULL pointer error for ops
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "lpieralisi@kernel.org >> Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chen Wang <unicornxw@gmail.com>,
 kw@linux.com, robh@kernel.org, s-vadapalli@ti.com,
 thomas.richard@bootlin.com, bwawrzyn@cisco.com,
 wojciech.jasko-EXT@continental-corporation.com, kishon@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 sophgo@lists.linux.dev
References: <20250312153346.GA678711@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250312153346.GA678711@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1eb::14)
X-Microsoft-Original-Message-ID:
 <52cfd0bf-3139-40c6-aa73-85fa11b2af23@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB10393:EE_|MAZPR01MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 87556c5b-c28e-4ec5-1553-08dd61bc0279
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|7092599003|461199028|8060799006|5072599009|19110799003|6090799003|1602099012|3412199025|10035399004|4302099013|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUN3d2IvVUp0NUpSS3pvbGRoR0JMKzlQZFRPVEhFSmZaN3N5ZVJoZ2RjTDgw?=
 =?utf-8?B?SU5GVnlVc0o4WUE2QWxEYjZDUzVJa1BMZkJ4dmFxMmpFbGwyRmk4MWJFQTds?=
 =?utf-8?B?aUY1QzhReFM1REZINnBueElvWHcxQTBvemZPTGJnUmhPSWlaVjhxSnB1SWFn?=
 =?utf-8?B?cWZJb3ZKaXZLNlhtNm5lamx4dDQ0UlQxOThaL1UzdUJMWnF0Z0xacU5EcWRY?=
 =?utf-8?B?aCtEVGMxMmd2cUdIWkd4elhWRWthdk45WlpSdFhDY1FnMUoxWFl4YktlUnFI?=
 =?utf-8?B?Mm5nQm5iamlrbzRVVVVjeXZ0Mi9TSSs2Z0ZDMjQyRWt5WUNVN0Jwd2Vta3d2?=
 =?utf-8?B?TEpsR3VYUjBJd3hDMlBRRnpjb2c3aFdtVWljNms2R1BQWTZiNm1KU01Wbmta?=
 =?utf-8?B?NThZUCtlNm1ZL2YwWStpYkg3ZlBzMWdpaVh1ZDZhZERHU3U3M3QxMG11SG4r?=
 =?utf-8?B?R29mbDQ0VEtudWRUYm5DZUZ6YzJiWU5US29iMzlUK2xXazRBZTRDNDQrQVFU?=
 =?utf-8?B?SnVNL3RTSDZOWHN6eUhGaHVOUnp5eC9SZW9oaThIK0N4c2FRRUtQKzZIRU5N?=
 =?utf-8?B?ZEpFZVdkVCtFa3JLZS9ZeW4zRFErRm5ZcGp6QVVwSnBDWFhWZVVxQ1ZHOWhJ?=
 =?utf-8?B?bUZkbXJFWHArdDlLRzJUM1BIYWRTUUR4NE5SelF4ZDNpNXJ2RDJlWkFUTGo4?=
 =?utf-8?B?M1YxdzE5ajhRRVBnRVJxcHZlZWthc0Q3VUtZMm1IRTFZZUpuZ0E3UkpBcmJx?=
 =?utf-8?B?NDJUSEhjSzJQeXdDYXdRRTZ3N004eGx2aE40RFVaMHdhRUVBOVpQRzMwQVVE?=
 =?utf-8?B?RTZSaDdBRzRIS1JDTXlSYzBsWWM2elF6dGZGYXpqWlJVOXhSbC9BUmlyc3Vn?=
 =?utf-8?B?TDl3dHRhNFN5NHF2MC9DcE94b3hYQVhNUDdYU2dwNmNEamhvaGFtY1Y1WVdq?=
 =?utf-8?B?SXdBQ0wzeUxUVml1akdoRktpa255c29KSzF1emE3aWhCYWxRRkZKTzF5Smc4?=
 =?utf-8?B?MzRpQ3hTaENzN245VjI1b2xYdFZPVnZyVWJDTHB5Q2hxeUdid01sa3hKNFkz?=
 =?utf-8?B?RHlpRlRTTGRnQVpuekJJeHdhUVJzWjdQWitLVDBWd3M0Q0Qyc25PcEZWK3VQ?=
 =?utf-8?B?Ym9lUzZnUHFJb29NM0VFM0t1NXkybXdiSndzY3h4MEYreDduNm1NWnBCeFBm?=
 =?utf-8?B?ckFOc2ovZlVnSnExZ0JBUFhzVzZNSnR6UVA3M0Z0NjdSb0hybExKWHFxamNS?=
 =?utf-8?B?SHVHUmg0bzBRL3hnTHZUcEdNdHhzM1llZjN3cHZFU05mY3JXSEJpT3pHWVF2?=
 =?utf-8?B?MHRqV1VXS1ZmYkJWdGF5aUE5ZFVMcEtHSzU2MjFoMTBtVTZYaUEwd2lCNFFO?=
 =?utf-8?B?eUxGQTQ0WURsV0xLUXJsdWpydGQ0MDkzd2NtZGFGekw3M0wxSGl1dmlWZS8z?=
 =?utf-8?B?Yks3Y0c5TmdTdWd4OUkrTjJBY2JJbWI3YURjQ0lDV3ZOdzN2VnFQWDUySXhY?=
 =?utf-8?B?YUtiUGRWWlRtTmJjay9NbUZNUGZ0aTVXM3pKVzdTRVkyYmhDZkFUd0ZFUllX?=
 =?utf-8?B?aDN3cElZaVpMVk5OeFJNWUpwOWJ3ZjdBTjhIOXhCTU5uWS80NGgrZHRPWmpn?=
 =?utf-8?B?SG5VQ0Q1Vk84U2NsVWM5K2pVKzVsaHFBM0FncFpHQ0JLSFVma3RNbFoxZWxs?=
 =?utf-8?B?d2p6T21HRFpVbXlSSUV4Z1VyZ3FxbXg1cSt0OWYyRDF3SWF0ZUY1dlpxVFZT?=
 =?utf-8?Q?oDV9KN8jcPW3RULxnel+AboygF6pXIMsPNrTGkU?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkIwUVY2SWVSQWVhdDNQeFJRODFiV2h0cnc5M1Z3bTc3R0pQVzRQa0ZQZmpi?=
 =?utf-8?B?N1EyWDQxaUxkUGlkMWNpY2RSUTBoQUtIazlPampyalhEVjJCY3Y2MmI0clhR?=
 =?utf-8?B?eXQ3d2tnR205Q0Z0Y0k1aUpwL2FiWUpJSXlxMk1mYklpbm9xZUw3TTdRZHlS?=
 =?utf-8?B?L0JrQ3FXZHZYUTYxM201dk1xVFNjaXI0NVVsWm1KMzlZZWpnODJwRUVCN3Fw?=
 =?utf-8?B?cEJNSStpTXpyd2FUa2tXcnRaREhKd2JoZ1owbEV6c3hLeFp2WmF4Wms0d3VB?=
 =?utf-8?B?RVhEMkpOTW5kdTN4NVh3R2hLa3lhQnJ5THBOb0hhQzRwNEU5cC8zc1dGZ21j?=
 =?utf-8?B?eDJMRzZkYWpYc3NsOVVhVklRSXRjK01iQlI2elYySFdFTmJuQWp2RXBBbGdL?=
 =?utf-8?B?SGVLT3loMFNZS2FhNVJiaDlKM3hFa0l2cWU1SWVVeVcrOC9tQmNPMzVmNkha?=
 =?utf-8?B?dSttZURKQVBubGFSVXhyRkV4am9Nd2NFSE5BQnN6bHM1WXM0TkJkRTlyUlRv?=
 =?utf-8?B?T3QzOU1RQ2JlNWZKbXViOE0vWHI1bzZHRHN3S1hKdU5Mbk8xYVF1eURZMmpL?=
 =?utf-8?B?N2ZNUmdORlVMdzU2S2dXM21kYWVwclBhN1kwckRxbWFacTJsdWpRY1FZVU0r?=
 =?utf-8?B?UCtMbGR2dHNIbk42TXVCSVgxWTdFTk9MS1NzblVSSzNqNExaZWNCVTZwalpK?=
 =?utf-8?B?NnFUU25sWHFEUzExYjRDN2NSYW5qSDNoK0FTTW1CUU10anNmb01CWnkyK29G?=
 =?utf-8?B?MnhzNkVVQXEvVFpFZ2NPN1h0WVdORU5WZGw3cFlPMkFYWFdZK2ZOZ21PQ1cr?=
 =?utf-8?B?dDVDMjJRRitmLzg5US9PRm9OT1dHSTF4b0M4T3dMYjdWc3JxeGw5dVhiSmpz?=
 =?utf-8?B?ZDRLZ1lBaGw3TUFrNGJOYnNvYWMxWHNwUmJsWnV3djBqL3hRdFdWbFJQWWg3?=
 =?utf-8?B?TFlPcERhWUZoMkQxMUkwZVZyMTdmQmo4d3lLanVpL3dFRGk4R3ZBbWoyMkpu?=
 =?utf-8?B?VHB2NTdVajNncVNhRElaeE80VnpXK1BYa3FFRWRidGF0SzdEWHVMcHV6NlNC?=
 =?utf-8?B?ZFo1N2NhaktZM0VFNWRtaCtGR3YzcDFCNW1tcmlicG5pTkE2cG9KQ3NVTVhV?=
 =?utf-8?B?NlRMOUswdG5DWTBWbldMeithL3dnT0NXWmNweFBKdll1UUhxM2lwRExiM2ZX?=
 =?utf-8?B?R2JlR25WUjFhVzBEYXFnZEtjUmRxT2FwejNtN3lJNzNXMFAwczMrUldqTmtQ?=
 =?utf-8?B?a1c5VGF2TWk2eTliWlA4dmVBYWo5SGxhRXJBZm5hdjlpU0xLaVhBbWRqSXM0?=
 =?utf-8?B?K1FVZVdOZ0VaZXgvaEdPcnd2aEtVdUZXYWFIdnFFQWxWejdKRU5Yd1JFRVVC?=
 =?utf-8?B?ZFB0aWJpZzdkMzBlUkxhQ0owNG9SOHlKOWVMZ1hxTzBoVTNUNmk3UVRmMlJ0?=
 =?utf-8?B?dGZnMHpVUDUyQkhHMllaWDhSb0tUU3o1M01UNmhYdm1uRVlwc1E3Z1RGVngx?=
 =?utf-8?B?UG5lZGpJcHBJbXl6eUs1cU1lQ0NwMktuTWJFeFcxU1pVbjc1SnJPcUV2dFlC?=
 =?utf-8?B?OHhSY1psUmNxV3FoMndrdmZMMWpvclp6bzdGb3NWdnlzNytzZWhObWFZZE9U?=
 =?utf-8?B?L1FJSWNSendNYzQ4UG5KbkQ1QUtkMVRNdXJOS2U0THB6NjVyWTVLWTZudlNk?=
 =?utf-8?B?S0ZhcENYM1RIdk5kcTBTV0taamxRcEJyblZvRk1hdzB1NFh3WlZyNk50V0l0?=
 =?utf-8?Q?PfnP3oXysgEC1THCA966UdWRQx52WvT7fojVCBs?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87556c5b-c28e-4ec5-1553-08dd61bc0279
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 23:17:08.2843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8163


On 2025/3/12 23:33, Bjorn Helgaas wrote:
> On Wed, Mar 12, 2025 at 10:08:43AM +0800, Chen Wang wrote:
>> Hello, Bjorn, Lorenzo & Manivannan,
>>
>> I find your names in MAINTAINERS for PCI controllers, could you please pick
>> this patch for v6.15?
>>
>> Or who else should I submit a PR for this patch to?
>>
>> BTW, Siddharth signed the review for this patch (see [1]). Please add this
>> when submitting, thanks in advance.
>>
>> Link:
>> https://lore.kernel.org/linux-pci/20250307151949.7rmxl22euubnzzpj@uda0492258/
>> [1]
>> On 2025/3/4 16:17, Chen Wang wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> ops of struct cdns_pcie may be NULL, direct use
>>> will result in a null pointer error.
>>>
>>> Add checking of pcie->ops before using it.
>>>
>>> Fixes: 40d957e6f9eb ("PCI: cadence: Add support to start link and verify link status")
> AFAICT this does not fix a problem in 40d957e6f9eb, since there is no
> driver that calls cdns_pcie_host_setup() or cdns_pcie_ep_setup() with
> a NULL pcie->ops pointer, so I think you should drop this Fixes: tag.
>
> I see that you probably want to *add* an sg2042 driver [2] where you
> don't need a pcie->ops pointer (although the current patch at [2]
> *does* supply a valid pointer).
>
> So there's no urgency to apply this until you post an sg2042 driver
> that doesn't fill in the pcie->ops pointer.  The best way to do this
> would be to include this patch in the series that adds the sg2042
> driver.
>
> Then the commit log can explain exactly why we need it (because the
> sg2042 in the next patch of the series doesn't need a pcie->ops
> pointer), and it will be easy to review.
>
> [2] https://lore.kernel.org/r/ddedd8f76f83fea2c6d3887132d2fe6f2a6a02c1.1736923025.git.unicorn_wang@outlook.com

OK, I'll do as you say.

Regards,

Chen

>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>> ---
>>>    drivers/pci/controller/cadence/pcie-cadence-host.c | 2 +-
>>>    drivers/pci/controller/cadence/pcie-cadence.c      | 4 ++--
>>>    drivers/pci/controller/cadence/pcie-cadence.h      | 6 +++---
>>>    3 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> index 8af95e9da7ce..9b9d7e722ead 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> @@ -452,7 +452,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>>>    	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
>>>    	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
>>> -	if (pcie->ops->cpu_addr_fixup)
>>> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>>>    		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>>>    	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
>>> index 204e045aed8c..56c3d6cdd70e 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence.c
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
>>> @@ -90,7 +90,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
>>>    	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
>>>    	/* Set the CPU address */
>>> -	if (pcie->ops->cpu_addr_fixup)
>>> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>>>    		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>>>    	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
>>> @@ -120,7 +120,7 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
>>>    	}
>>>    	/* Set the CPU address */
>>> -	if (pcie->ops->cpu_addr_fixup)
>>> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>>>    		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>>>    	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>>> index f5eeff834ec1..436630d18fe0 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>>> @@ -499,7 +499,7 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
>>>    static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
>>>    {
>>> -	if (pcie->ops->start_link)
>>> +	if (pcie->ops && pcie->ops->start_link)
>>>    		return pcie->ops->start_link(pcie);
>>>    	return 0;
>>> @@ -507,13 +507,13 @@ static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
>>>    static inline void cdns_pcie_stop_link(struct cdns_pcie *pcie)
>>>    {
>>> -	if (pcie->ops->stop_link)
>>> +	if (pcie->ops && pcie->ops->stop_link)
>>>    		pcie->ops->stop_link(pcie);
>>>    }
>>>    static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
>>>    {
>>> -	if (pcie->ops->link_up)
>>> +	if (pcie->ops && pcie->ops->link_up)
>>>    		return pcie->ops->link_up(pcie);
>>>    	return true;
>>>
>>> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6

