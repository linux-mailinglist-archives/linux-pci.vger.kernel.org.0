Return-Path: <linux-pci+bounces-24629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61862A6EAEA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 08:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD27E3ADE16
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B6C25291D;
	Tue, 25 Mar 2025 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TeYr/vcO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2074.outbound.protection.outlook.com [40.92.41.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A791F3D5D;
	Tue, 25 Mar 2025 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889316; cv=fail; b=oK3cXcp6Z+BVFIghDEst6iapgxnMt60uf/hd3lnW5WlTWn5Iwaaos+vsfpiVrE8B29hrUVnAM9xQMzy8wAN9hRRgBu85RxtrqLnL6dFOJTzhGInu92NsNulmSBu5/76slD73yiqq4eHLLxSiv0kZJ6kBk8fKGOsAnNxBLsmJtpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889316; c=relaxed/simple;
	bh=Dns9tYVQuPgIjjHeP43X3StaDL344JgtFa7PustzUjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G3/IyEJ2KUp84DikYCR6fm4cj7blwjxT8b7ZRUg9xkIeLXYAvtsAWbCOhmMo1FUZw7VesrOSW2EOYOLjfEN7XMPr2v9c3KK1dVIvQWUB09XAK9HKcPGYXdoDeIJYcNQRsG2hRBDmur5vahydcm6EI0Oe9OW2rTpuqW0B3P9GYyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TeYr/vcO; arc=fail smtp.client-ip=40.92.41.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srlUK74xHWp3iuwf7d57Yfk4apLOCrFCu4nUQa7W/6tj7SMSzN+hjD0uQyJ/VOtMhrQEN4rQMxfOkSrsR722v+b3CQpNG0bYo/PBBu5cw8SWG85RhdRTDCifc4eyHD9ji2P5ioqBwfdF5OijfKMLGk7J/os54DXLVZMGLRIMuq/4NDJxCuguHgVrjgY+WJQv1JMIo76y+Z6ntIZJyJJPVxETdWW9bWpzpsFwgIfVdJhoq/VN/dDAPp0zTlq4a+PB9FABrClwf2BF24I1AubKNPvMpES4oJACmLKhDmntFPU3CUPTkv+OIN4Z7YdWisgHOs4jEyl4Nmytyc6A+6lYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDijx2iyotOdHPX9Y7so6wOaNsHeebWtG3mlS8olbDo=;
 b=wjRxOLYXKIlApSR26mbTWx0GGxYbeJtgykDwA+Un7kp526NGJ0N3XymePP6dV1Myfe7qqgg5lUt0nCcrtv28Xsupi+fzgZ2daLf1XJj4NiKi5l3pHW0MERbtZyLnuBlU3f8bEjMdKxeacCZsJZzfm3TRXsckxa6pdJIYgwi6aSJbjFn3S8e3F0ZQSSnQKvAY+VMOtquB1gdIGY83/koQYgmbXXAYruVclN0sxmBf0XT6GXuCghylRPAnhUk9fnmgVGuv2lyCnQOdpiCegyxQP9/BekHKWacuOtu/LIKFjemKOIFkBKjZKFoBiM5ipZCzliaclysSOyekvSumHE3hjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDijx2iyotOdHPX9Y7so6wOaNsHeebWtG3mlS8olbDo=;
 b=TeYr/vcO7w3ckFG2jMtftyMofUinYR0gWSdHh3Tnr7LHT5lq73mi6zMAbrYQbGW4+wpc395yFrWl3917YTwcLNVF/sK+iIej5AKPQLcbnhCxt9qkbB3HH2ql2b1m6ZxltIE5A3eEyxb3QlZ2Q+DF2WANciUxY0PMAT7wkQfxooR+zPpgNEjJTkikN+NTVLKAlfPsj/Cn7gJ4zm2BoLU1I3sIpXDZnyczhrwV2du/kdva6l2RV4GGr3UyeOkKo02Aby2kuu26NmeKDeIE288sVDhIjYLpJka2KmiVtwjqSAnkR/JfJbwJJVqp3o6ksGAb8K35cw4Sn+LtyRRoooDdgQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CY8PR19MB7082.namprd19.prod.outlook.com (2603:10b6:930:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:55:12 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 07:55:11 +0000
Message-ID:
 <DS7PR19MB88834DFB6D5E574BA89D5A5A9DA72@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Tue, 25 Mar 2025 11:55:00 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] Enable IPQ5018 PCI support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nitheesh Sekar <quic_nsekar@quicinc.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 20250317100029.881286-2-quic_varada@quicinc.com,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
References: <20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com>
 <20250324-shrew-of-total-philosophy-4fddc2@krzk-bin>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <20250324-shrew-of-total-philosophy-4fddc2@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0009.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::17) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <c4ee737a-29be-4f21-a5df-2cd452265e30@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CY8PR19MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc25a3c-e3d5-4407-872f-08dd6b725e61
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|6090799003|15080799006|461199028|7092599003|10035399004|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlRCRERPWElxWEJxK3dHams4ZVkzL2I5YjFZY1hBY1B5MS9mMnU1OThTbG9h?=
 =?utf-8?B?VXJ4NXlPMHJyakd3ZS9HejYwTWZ1MTRybk5JaTRPbWRCSVRmSmVCcXljbDV4?=
 =?utf-8?B?YjZSb2xyK3ZPcVZvTmxSODhBYnZCTWo1YlZzdjQ3cnJmL3AzM2VVbVExalVM?=
 =?utf-8?B?cHdkR0lpOHlmVVIvcHk0M0VIanhXTVd6S3hHQmhkaHR1Q3ZlbWZhbXBpTE8z?=
 =?utf-8?B?LzJHMXJydTdvNnpYaE04UTEvQTZhNG4zNEhqSTVhVnQxSm9VaWppa0w0dmVN?=
 =?utf-8?B?VE51K29OdEhoeWZKS1pVNDB6Rmo4ejZLMU01MjZadkF0TVZwTlZMclphK1Vk?=
 =?utf-8?B?SHFsUEg3VXNnelQ1cHYvVjR4eTYxbzRuZVpaRllxUDk1bHQyWkF3cWxFM3pn?=
 =?utf-8?B?S0JmN2dheEpYdXViL0NtMFFXNkkxeXFweWp6ZTV5eEZBcFdHMkRVNkhmQXFh?=
 =?utf-8?B?cXQvVnhYQmNlVGtGRnRtTytMTnAvNk12VzFPWFhYT0x3QzBhWVlVWEhkSFo5?=
 =?utf-8?B?eUs1NnNsem1RYVN2ZnM2YTFodEZGNU1zSDFMallyZ004R2hUNXNkeFZRNkVN?=
 =?utf-8?B?QW9kejBHdWpsaVlzcUZua0ZLUklYd3lRZ2JaUmxFcnFYYlhPRTZlSExrRkFv?=
 =?utf-8?B?LzBsbW94Skd4RWpTV1FTV0R4WndjZUhjaUJsWHdlMGZtYUpQZzh3QVlBWFZT?=
 =?utf-8?B?TDF5TjR0NFozZzBlSmdvUVh2L3BEWHpQalhnUFhESHVxT1JkcUQxWHEzY3Z1?=
 =?utf-8?B?ZTNyaUZncVR0UXdvUVI1Tk5DRHpwamdxMk5RdXR0MWR4Qyt6a1hXOWRTclhh?=
 =?utf-8?B?QnRZcHhnNGFkeHVzYjMzOVBiaTF5ZThxa0ZUUS9EQVVMQkE5cUlFeUhITW9R?=
 =?utf-8?B?TXRKN3JKSWRLUEF1MHpmYkZpNjV5ZmpWODQ4R2ZpeVpaZFZDR1FQQ29aMTFR?=
 =?utf-8?B?d3hubnI2WFNWMERjWnIvT0FoUkJIVUZPWWp1Y3dnZGxORFZZelFjdUhNTldw?=
 =?utf-8?B?czdsMExKWUZZVytzRytVVXNOSEhFL09kdU1vbk1ucnI0dFczTlI0ZG9NMVZE?=
 =?utf-8?B?amgwSU1kN0phTTRjUE1UOFVyNFQ5cDhEVFY2RGlWalJCYk5MR251Yk83bDZi?=
 =?utf-8?B?dmx6aFBNM3Z1azA3eWZSa3dGSnFETkxuTTVJQ0xzZEpyNzRXMy9YY09iZTdk?=
 =?utf-8?B?NjJoVGFONEIyK2dvaFBJbVA0QXBXMmQ5b3lKU2pXcE5yVWord3ZvcmRGK29Q?=
 =?utf-8?B?bzJJYlZzdDBuMjFrVTFzMVVyZVl2MFIyTTBmL09ZbVgyN0ptK3lOV1p4VGc3?=
 =?utf-8?B?OG1lbStQN2xzMUxJY0NsaC9zYUFyTDA2aUhEQ2lUU2lZQ3QrU1lXMFh6NkxI?=
 =?utf-8?B?WHJ0SzJyTTFYa0VRVUloUHJ0RUFGOXBSd0xLclZVUHNaL3AvMFJqVFdobGt0?=
 =?utf-8?B?b3lQV0t2ME9oaHZtdXRHVGJBMU80Mmpqd2xtRjNzTHIvZ3JoWEtxc0NFZy9Z?=
 =?utf-8?B?a1J4OHYvNTBBdThOMGZhZlhYc21PcktuNFNaa1RHaEVCcXlUWnQwVFFTWStk?=
 =?utf-8?B?RkE5YjQ4SkM0V3ExODNBbnIzK1NucVlYTEJJNXNrL1NqNzR4KzJCZmNyUGxI?=
 =?utf-8?B?SWhsNnRqRU1wUXV6MjJNV0NFZm42VTdCUU1jOERhQXc1aHNyQm42MzI1Wm5G?=
 =?utf-8?Q?L/xQaorBYsmGoqQtwBFb?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWMzVTA1cHAwOUdIUFVKbnVHbUh5cm1GWTJsQmVCUmduSmVkT1JZMmdDWUJF?=
 =?utf-8?B?eWFyMDFoR2JkQVNIc013RmNFRE9ORDJud0pjMFQ0VzFDenNtcXBmbDJITWZw?=
 =?utf-8?B?S2ptbjBvanhhbHFSMUtIMER5VzF2aWZna1NmUlNVMlkvVW83MFFnMXp0Mjgw?=
 =?utf-8?B?amswemVLR2xMNWREaXgxNS9mYXRVQlI1dU5Kc2s5NVdKb1h2U2MyeXZDM3M3?=
 =?utf-8?B?dC9kMTd1SExFOHJrYjVQeEZqbzQxSkRJdVRpYkM2VW9KbDl4TzNBOGd5UDZi?=
 =?utf-8?B?cEwvQ1JtODU4TVFjRDZJN1MyakVhVEZ3cjE3UW1oTXBoY05NazlmamZNUGJZ?=
 =?utf-8?B?TCsyaGVWMHo1b2p2UDhKdzhieE5SSWtuRnF0STNBaXRINTNEQk84VFd0T1lR?=
 =?utf-8?B?QmUyMERFdGhjU2pQMTArVkUxMlh3WER4Q0J2bWd2Rlg3TjZSQXg1YUJIU1Iy?=
 =?utf-8?B?TzcwTThIcldpZWRaK2dkVGZCVmhPaVRNaE5tQytORUsvR0MzdVZLUGZkYUlZ?=
 =?utf-8?B?eWZQTkxNWGtjZUtCZ29hbTBhaTdYVVljL0FRV1NESDVraHM4KzEzY09RTWFo?=
 =?utf-8?B?ZFdORTV2Mk1uRkx0bVE1b3FiNVU1SjQ5dWZvM2Rma2ZNbUtibGJnL1A1UUZJ?=
 =?utf-8?B?ZzhwUHBRQVoyL0Noc0ZiM2VqRjF1SytaMnJrWmd3VERDb3gydmVkTDRKMi9i?=
 =?utf-8?B?TzhOcjFNdDJ0TnRRV1Z1d0F6a3dUSTJNMmVlbU9aa3JQYnI4ZndiRG4wQ1dC?=
 =?utf-8?B?NmE3ZDFrL1ZmWGpOemhWQU5QMDR3bDRVT1EwQlBLOUJkSjkzZ0ZvY09Sc2dK?=
 =?utf-8?B?ZzF2RG1tamZKRVlONHVvM3B1KytTSHc2d3ExdGYwaEhkSUQvb1REZ3dSSDRE?=
 =?utf-8?B?OU1MblJVNnR5VGtPWW02NHVjbTFnZjQyZUplVlJqcHdnbXU1RjBmMWZWUEJQ?=
 =?utf-8?B?TFNBMXRLa1FUelJnaVhhOTZqVEN1WlEwa2pFMlFMelhNVHZEOFc3OXBtWXJQ?=
 =?utf-8?B?OTBFMGN0enllRVQwTEhCbnFQaVIzV290YXNzWHNCbFRyMUo2T1ZjRVc4MnhB?=
 =?utf-8?B?VUF1WG4rMVFPZ3gyYVNabGRWNzlMSlkrSHp3dVVTcEY0cnFXN1VjQWM2a2dV?=
 =?utf-8?B?WXhvbGNqYnltcVE4clRzczcvbVdkOS9wMEpjSHNMankyOENMeXl0UUpxekJh?=
 =?utf-8?B?RnVjWGlKdy82L1hiS0FyanhCUW5HWWZMTkFVbk1PMWR3L1R0QU1IckFHZGdN?=
 =?utf-8?B?UmZxKzBIdHVRL0V1THMzMnlGTERRcjdibEltN3FUbngxSzZsUHBzKzdpQXpp?=
 =?utf-8?B?aXdzd24zUzhyci9TaFlMdFZxWkx4YkRvTjhQcFQxUm1EQUQ1VDBaTms0ZFVL?=
 =?utf-8?B?RkE2ZnBhallwTnYySnk4RVlkNy9hWE80RGFnbUFVWUJYYW5oME9DVThUeXBS?=
 =?utf-8?B?RVRMLzJ1UGJhQkpHcDF0S3FFYW1SMUkxTHRCSURGeUMrdEd6VmtRYUgyb0J1?=
 =?utf-8?B?a3A0ZVZMaXRNRUh2SGpDRExoM1poSUZpSklmZ3RJM2pYaUhLcWl5bXFuOXN3?=
 =?utf-8?B?Y2dwd3didWFVWGhUQXdIcUJkdEVpKzVBS0xwajNNcjhKTHl1T01tR1NUbTkx?=
 =?utf-8?B?WTVzS2o2Tjc4ajExbkFrdGlPT3dIaFJJSmRaTWxTVFN1WWxPdDJsenZyMHo1?=
 =?utf-8?Q?Pp3Ph98gJGW9W8KwykQD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc25a3c-e3d5-4407-872f-08dd6b725e61
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 07:55:11.6055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7082



On 3/24/25 11:47, Krzysztof Kozlowski wrote:
> On Fri, Mar 21, 2025 at 04:14:38PM +0400, George Moussalem wrote:
>> This patch series adds the relevant phy and controller
>> DT configurations for enabling PCI gen2 support
>> on IPQ5018. IPQ5018 has two phys and two controllers,
>> one dual-lane and one single-lane.
>>
>> Last patch series (v3) submitted dates back to August 30, 2024.
>> As I've worked to add IPQ5018 platform support in OpenWrt, I'm
>> continuing the efforts to add Linux kernel support.
>>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>> Changes in v6:
>> - Fixed issues reported by 'make dt_bindings_check' as per Rob's bot
>> - Removed Krzysztof's Ack-tag on
> 
> Why?

In v5, I modified dt bindings (patch 1) to add descriptions and separate 
conditions for ipq5018 and ipq5332 as they have different nr of clocks 
and resets but left your tag in there. I removed it in v6 to run the 
changes past you again.

I intend to send the next version with comments addressed in patch 5 (to 
add a comment above the max-link-speed property). Anything else you 
would like to see addressed?

> 
> Again, I cannot compare this serie:
> 
>    b4 diff '20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com'
>    Grabbing thread from lore.kernel.org/all/20250321-ipq5018-pcie-v6-0-b7d659a76205@outlook.com/t.mbox.gz
>    Checking for older revisions
>    Grabbing search results from lore.kernel.org
>    Nothing matching that query.
>    ---
>    Analyzing 12 messages in the thread
>    Could not find lower series to compare against.
> 

I tried 'b4 prep -n <topical branch> -F <message-ID>' to try and preseve 
the history but that didn't work, unfortunately. Instead I used -f and 
forked it off the master branch of linux-next.

> 
> 

Best regards,
George


