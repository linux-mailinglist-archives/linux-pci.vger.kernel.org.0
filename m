Return-Path: <linux-pci+bounces-39458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D971C0FE33
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 19:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275E24E3B3F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 18:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB642D5410;
	Mon, 27 Oct 2025 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bfh2rtTh"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012053.outbound.protection.outlook.com [52.103.2.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB0F19D07A
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589167; cv=fail; b=HRI/T4enO9uhdS4bMtbfKSnr4L4VEDJBRWQQ7l+MibwE5u7uyLKuiKtz2pw0sexA+E0Fql6oL4978yjjdmvZryRL5ZOhtRzxnP0MF/G+02MnkRamJSivGthGlfYyT/KfHoAbcZ0IXfNhi3FHiFkC7gQtbJ1G+W4g6q7WPlPJD/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589167; c=relaxed/simple;
	bh=6bHWzLvSC1uJ8MYFffPVbEGMhrGPeULNy2T/TQ+DgyA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qwcVgCDRped2RVxFNq4l/3d7q+Z/8UtJ1kO0Vmt3+EItlFVTK2IFSYSvoXUxwBOMvn/KoiMZ4gMnWjPZ3CGaSGi3lY166Omnu0Vma6IpuwFv1BnNE49By3OgYKzwflUax8GwmcVYk5PlTPTEUyQatrQcaaQZ5AnPzUzXudLKwiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bfh2rtTh; arc=fail smtp.client-ip=52.103.2.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlQTQxedbrdNVsq4XgL611U+QBvNTNVYLEVk4zZuPpMnoDbhM1CjaMSzUlz2v1keAyELU7a+gaxQaP8Cga2+bapD/TWfXS05HQm1m9IydM280ypwoTGlm+guQGGCBx7Xb/vSnDRHdTZLv5xu6+SEPaqOtjwueRq09wNEMhG/NfzZx3lI8lVAv7k1/hWnQJSD2W36mOcVexy6vSGrYbjEAYIdsT2qHAcBE/3hg1Xi9cDGiCEpowwchlKp/UFb9r7brLsq3YpIf8anY4ArRvrmU6CHqmg9SxqXgJMiWTYjZ/+ydPaqeltp/M5D17LpWvIAjTrDLk/atuYc0qjibzadSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DR4FoP3ZsjVuyly7HXyUQ+NSn3J1WivxILwIkOIRp0=;
 b=FxIdiros907bnhjUIaJUjmT9kmRxnQOQD8kXPRJ+5tEN4QNKNYrfRRySCvRUqoywzFNPNBcc42zvPWkpuXhGPE7EVjkQw/eccoCZthExBCttdycx7bxxvyf5hXBNutH1TpByPRNcuK5iNa/2fb/W8jaf5SehCMLiK8h0a95WLBvkJZrYFgXv21EkUhXQeQybqRL16ilxS3pKC/ksvtm6wqc4O1qjSxn4cujPj4ZDy4NGG1wxf5oiYXIjWevMfiogWuJNiMomR2k5DeU1SUrv73VTrhEmnSj/UWXAd1AGFTfEY5tGOHUJR8NghBAp9NCcAfOdjEIYKcQjm8vi7q9hIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DR4FoP3ZsjVuyly7HXyUQ+NSn3J1WivxILwIkOIRp0=;
 b=bfh2rtTh/885TxHhZKQVIXsekSJLom+Uyq1XOTUvVKa8OR9gus+N57nsEH68UoUukhCPOYxpqxi8vG7JmXzhxBa4bzwfvwTjDwsGN2xnVm91lt1uepjvT21TKqylduqotDMbb+sqEwsUfoAkMLiMestubROs1wI7p44zmcOtAcdpAOuonwu/jx+kSOGM5OU35KBktn5yxbGPmHhjo+pJIJoY1iKcx3ltwh/HR8CzrquA7p3Z0tWCSyb+FYY+AVbE2UHMY9WsDYkzQ8+ZLYxivWwu45H15VhFmIcTKihCuWCxOJEg8/Z0rEF3tnfXlnWq1GFnVhr2rBgtOiLkabhINQ==
Received: from DM4PR05MB10270.namprd05.prod.outlook.com (2603:10b6:8:180::11)
 by PH7PR05MB9901.namprd05.prod.outlook.com (2603:10b6:510:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 18:19:21 +0000
Received: from DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c]) by DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 18:19:21 +0000
Message-ID:
 <DM4PR05MB102705BB2124288C68EEFDA04C7FCA@DM4PR05MB10270.namprd05.prod.outlook.com>
Date: Tue, 28 Oct 2025 02:19:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
To: FUKAUMI Naoki <naoki@radxa.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20251023164205.GA1299816@bhelgaas>
 <DM4PR05MB102709E0A9C0CF0D62AEC3524C7F1A@DM4PR05MB10270.namprd05.prod.outlook.com>
 <665677F9F810B6C1+af6c83fd-f262-4721-b544-4336aaa83bfe@radxa.com>
Content-Language: en-US
From: Linnaea Lavia <linnaea-von-lavia@live.com>
In-Reply-To: <665677F9F810B6C1+af6c83fd-f262-4721-b544-4336aaa83bfe@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0088.apcprd03.prod.outlook.com
 (2603:1096:4:7c::16) To DM4PR05MB10270.namprd05.prod.outlook.com
 (2603:10b6:8:180::11)
X-Microsoft-Original-Message-ID:
 <88b1ebf5-8dd6-4f47-8e8b-ac45134bb915@live.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB10270:EE_|PH7PR05MB9901:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df3df8e-2782-4063-c93e-08de15855977
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|15080799012|6090799003|19110799012|461199028|23021999003|5072599009|1602099012|40105399003|10035399007|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGVRWFduN2JpMHB3dnEwdUNHYUpicEppR0FQZVo5VGZtOVhxVzBXT1hnRjNv?=
 =?utf-8?B?UDVjcHZQNy9VNURVaDJicjVWV2NDZTBzMFBYSmtDOW1LbHIramgydU5DSGlv?=
 =?utf-8?B?WCt0RUJFWkFyQmxlbkV5dmxPZXpPaXAwT0dMdmpEM1A3ZGdJQnBnSUFReVhN?=
 =?utf-8?B?REJRZkhSOHBSWXBXenRXOEJHV3ZNYjd2a3ZmSXFHYjcrS1VSSTZpWGdvMk9O?=
 =?utf-8?B?N2h6WVpqeE5PbkxJT3N6eXhjTW9iUzM3WHRCZngzSnlvcjhkYWlrdHdwNXlw?=
 =?utf-8?B?amE2RWpzUmVZUHJPTGUrVFVkSDZkRVdXWjUydnZ4cHpyOUJ2TDhhOGdvK1ZB?=
 =?utf-8?B?MW5Hc0RrU2hvOEFhVEtJeTZCT0RwblU0c3ovQVN5YkJ6bmtkdVJIVTF0LzFk?=
 =?utf-8?B?THFMK3JFM3JTV3FUN3NMNHpxdjk0MDFkR3RxU3R5aDA2ZEpsUXluZTJYUTYr?=
 =?utf-8?B?ZE5zWGxDbkFZc3F2bTBxY2VVSEM2SWl4a0U1VGYwNGpHSUZ6cWgxaGZGYjhE?=
 =?utf-8?B?bmRzQW56b2lScFhoZjBsVTYxTkNQNHlGTkJXLzh1eDFIeFpxRDJpOFFjUGgw?=
 =?utf-8?B?UEpXWEkzSUErQTlPZm8rWVVhNU9obTg0MVFxUDNEd1FVSHZTTzlYUGwyU0VR?=
 =?utf-8?B?eDVDR1dSSFg3S1BReCtWczdaUys2M1h0b0RqeEhJeHdIZXQ5N0FySGxpV0Nv?=
 =?utf-8?B?eEp0eENDdkxXVUhWNDVTV0FyQkZaL0JhS1liKzdxN2tLbnVyeGhsWWdWNTZM?=
 =?utf-8?B?ZmVVQkdKZGVXUjkybGkzODk3Y0hJR3NNMit3elp3RXdlSXF6c1BZL1dGeWQr?=
 =?utf-8?B?Tnc3ZGdVSU5sUXh3QlRKMGt4TGV4Z1R3WVV2clRUR1pUdWR5MElCSVhTb1lK?=
 =?utf-8?B?Y3ppZ21wdXFVcVJjQ3hmZDRIQXUxK2k1RFN1QmRqamk2Mzlud2VySnBndlpU?=
 =?utf-8?B?bmdZVFM0dFhFOVBnTjB6bStYQXRCbzhSZHBiM1YyclVKTnNZWlFtRDN2L3ZC?=
 =?utf-8?B?LzNNQjBkZk10Z3A1cFZQR2lHeDFOVEZ1c2hjUzh4NHRkakowVG1US0dRVXhJ?=
 =?utf-8?B?WjNrWkM1NXpmYmZiVkNpazVDTWErWTdqeXJ0dGtkaHl0R3dEaEhDU213RHc5?=
 =?utf-8?B?eHJUTXF2Z3lQUTdjNXp1R2VxSlBXSjd2OW9Ea1JjZ1Y5K0ZwUnhjNFN1aThZ?=
 =?utf-8?B?WHV2U0Z1RnBDQWhVWCtrOFhjb2hid3NTbjB5bUt6MjZNc3pMWXR2MkVtbGlp?=
 =?utf-8?B?RmxTcFo5aTBSaEFDamlxdnBrMjRYT1N2bXBJL1Q5VUdHdzlWR1lrc2k2WjFs?=
 =?utf-8?B?eGpZSWQrMkgvUWdqcXNqNG1Cdkx5dHFmMzRxWXFzT3hIbzYwcTJSb1RZK0N3?=
 =?utf-8?B?cDFyR2xKcG9malFMWHQ4a0RMd1dyTXZES3lCbFV6TktGSEhXa0djZGNJMnRk?=
 =?utf-8?B?SHdtdWRkNlV6cHIyMXFCRjJuUW5jcHYvNVV0TFB0NnFCY2pPU3Vwd0tPdUVn?=
 =?utf-8?B?V1cySEhUZ21naE9jRGNYckxyS2xqK1ZNRnBycmUzQ1k4ODdNd2RFckFtZlpp?=
 =?utf-8?B?NXFtN01EVEgxL3QwQ1FLSFBOQzNLQWQ2UyszZ0d3NGtkUkpiYVR3cE8yS2lo?=
 =?utf-8?B?TU4xOWZwS203eTV5emEvSXJWZ3BqQWpsNnY4UXAyYTZXc2RHS1F5N0JBR3dJ?=
 =?utf-8?Q?aGWBZO7PCUg9Y04RvCkn?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUFzYytHSW1NbEE4dzI1U09BQUs1NmQ3OGRiV216T0JCV2VneVNuTTJieGIy?=
 =?utf-8?B?bXRpeTM2OTdUVDlWVjlnRUMramVROWZhMVVKTys2MkNRUzdtcWh6ZlF2UU1L?=
 =?utf-8?B?cnBnR0tjbTFSVUo4clpCWjhEYURQcmNmSXc5aGt5MElrQmhWSlc1Zi9CSmQy?=
 =?utf-8?B?dkk3NC9MOEE2Zm5xa21idktKYjRjM0RhbXdVWEtQNzFYTHJsY3FqNm42VCtm?=
 =?utf-8?B?TjlGbE9SNWFOZHkxaElSbjNPREVZRVFvOGg3Z1R6bnAxZG42eWRsMDliSmpo?=
 =?utf-8?B?V0NnWTVVSFN6LythRkM3SkdkeGtOK2tqejdmanYvZEE2OUdRaThGWWFwMWlK?=
 =?utf-8?B?T1hyVTZ2VUVkOU56dVpoOGtGeHhveTdPck94Tm81SmdYUTI5MTAxUnQ3OGZC?=
 =?utf-8?B?OER4cHl6dmQyYVNKVHl2QmpDNmUrQ0JMb1FyNCs2ZHJ6dVlwbStncmUxL3RR?=
 =?utf-8?B?c21GeklLN21BZlRPVWdzbWFUcDVRWFoxejNlTUtwOThEYzZLQ00vcHBuS2pw?=
 =?utf-8?B?ZTFkTUp4Nk11dWtBR2R1Qi9YOTd3bkhSNXkxZGxZMzZ0eSs2cStkeksyVDMz?=
 =?utf-8?B?NXgxSkxZQkpIOXN3czRvWnlZemxlZCt0cnFrQ1BGWWlhdG9Ed3lnUU0zaEh0?=
 =?utf-8?B?Z2txMjkyNTN3TTVUYndNMEltNWNaaTZFTUxjNk9iUjZsMkFOZmdPS250MUhO?=
 =?utf-8?B?YytYbTJxbUplZUx6MWFsaEk4SElDazdkN3ljTEhiMTZ5a2JuWHZReVRzNUlL?=
 =?utf-8?B?bFlabjM0TGN3a0JNdzZCeno3b3dpTzd4ZFZSUVhCazlCOW03KzA1M3VyY0lN?=
 =?utf-8?B?SHFneHE4SmFhK2crQUlFdEIwWFhYNWJFaVRDSEJaZWRLbmd2WGJGUTVoZ1d5?=
 =?utf-8?B?TUtBUXBFdCtsYjY1RnZ5QWkzdFVsNHA2NUJ2SFRRc3UrV3J1Q0VjdnNuVmYz?=
 =?utf-8?B?S2puclBIN1RHOG5yZ0hDVjFZcVh3OFU4M2hwM3VpRTFQT3hVbi9MclFaMmNo?=
 =?utf-8?B?cXRqNFdkNmhoY1l6bnFiTjlvMlcxR3B1eExNeHZxVWZCbVE2dHRVOEU3bW9t?=
 =?utf-8?B?N09EMTZlN3d3ZmM1VkFURlVlSzIwaXRValJZS0pBNW93b3k2cWl6dUpGeXFx?=
 =?utf-8?B?bEZ0dlFMbVV2aDgxdVlhRnVKeWd1dmtINlNGcVpIYWlBLzlQYkxFbUQwVDA3?=
 =?utf-8?B?Nk1ZUUUvaEwzbUF6SjBtdnBoRFlBM0JjS3dFWUJHbHBZRzVaRXdJN0QrZGhZ?=
 =?utf-8?B?dDJQQStFZzhWc0JRK1N4U29HQ0VsNDlEY0VvMWVWSzNLdmUrWEJJenNheWgv?=
 =?utf-8?B?L1NMVGR1dll2d09KS0RPTTBvR2hLNkZEcGNpTFRtelh6VGlzUy9sNWNSSHJI?=
 =?utf-8?B?RytZYUZFRGE0MC9BYkZIZlhxODJadFRyYTFSazJXMm10LzRuUy9ieTBWVHJm?=
 =?utf-8?B?SGNkQnlBSVZoSDg5RnljK013VHhhdUcvRHVKUGY3NjY1OHJlaGdJWjhDd2li?=
 =?utf-8?B?dzZMTWhpNmRnTzVLYmlsNi9pUmpZT1p0SUgrcVpUUXZMTk9LcThRMGNFRHkv?=
 =?utf-8?B?NktBOVRMbTU0ZW1ZbHo0aXRpTkpsbHFYeS9FWkcwc2xhVGlQWjRnVkM4V3Fi?=
 =?utf-8?B?OUhvajhiZm84ajh6TXBEYXZmMERLa2ZTK215U1VTZWZJM3Y1eHNtVVJvZ2tl?=
 =?utf-8?Q?o3BN/kVoVe3VTFX9xp/Z?=
X-OriginatorOrg: sct-15-20-8534-9-msonline-outlook-d08a8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df3df8e-2782-4063-c93e-08de15855977
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB10270.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:19:21.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB9901

On 10/27/2025 8:51 PM, FUKAUMI Naoki wrote:
> Hi Linnaea,
> 
> On 10/24/25 12:27, Linnaea Lavia wrote:
> (snip)> With the patch on 6.18-rc2 it fails later with ASPM.
>>
>> [    5.362080] [     T50] dw-pcie fc000000.pcie: error -ENXIO: IRQ index 1 not found
>> [    5.400163] [     T50] meson-pcie fc000000.pcie: host bridge /soc/ pcie@fc000000 ranges:
>> [    5.421350] [     T50] meson-pcie fc000000.pcie:       IO 0x00fc600000..0x00fc6fffff -> 0x0000000000
>> [    5.428902] [     T50] meson-pcie fc000000.pcie:      MEM 0x00fc700000..0x00fdffffff -> 0x00fc700000
>> [    5.436367] [     T50] meson-pcie fc000000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 4G
>> [    5.485658] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.491449] [     T50] meson-pcie fc000000.pcie: PCIe Gen.2 x1 link up
>> [    5.512122] [     T50] meson-pcie fc000000.pcie: PCI host bridge to bus 0000:00
>> [    5.515375] [     T50] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    5.521523] [     T50] pci_bus 0000:00: root bus resource [io 0x0000-0xfffff]
>> [    5.528847] [     T50] pci_bus 0000:00: root bus resource [mem 0xfc700000-0xfdffffff]
>> [    5.536237] [     T50] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 PCIe Root Port
>> [    5.543415] [     T50] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
>> [    5.543432] [     T50] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>> [    5.543441] [     T50] pci 0000:00:00.0:   bridge window [io 0x0000-0x0fff]
>> [    5.543448] [     T50] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
>> [    5.569461] [     T50] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
>> [    5.587641] [     T50] pci 0000:00:00.0: supports D1
>> [    5.591578] [     T50] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
>> [    5.603775] [     T50] pci 0000:01:00.0: [8086:2725] type 00 class 0x028000 PCIe Endpoint
>> [    5.614373] [     T50] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
>> [    5.621353] [     T50] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
>> [    5.621374] [     T50] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
>> [    5.623252] [     T50] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>> [    5.651205] [     T50] pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
>> [    5.664912] [     T50] pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
>> [    5.706596] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.748181] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.796864] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.798178] [     T50] pci 0000:00:00.0: bridge window [mem 0xfc700000-0xfc7fffff]: assigned
>> [    5.806100] [     T50] pci 0000:00:00.0: ROM [mem 0xfc800000-0xfc80ffff pref]: assigned
>> [    5.806382] [     T50] pci 0000:01:00.0: BAR 0 [mem 0xfc700000-0xfc703fff 64bit]: assigned
>> [    5.863079] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.904553] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.946013] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.987492] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.987517] [     T50] pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)
>> [    6.028979] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    6.080320] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    6.081421] [     T50] pci 0000:01:00.0: BAR 0: error updating (high 0x00000000 != 0xffffffff)
>> [    6.131210] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    6.132324] [     T50] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>> [    6.138215] [     T50] pci 0000:00:00.0:   bridge window [mem 0xfc700000-0xfc7fffff]
>> [    6.145683] [     T50] pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
>> [    6.151953] [     T50] pci_bus 0000:00: resource 5 [mem 0xfc700000-0xfdffffff]
>> [    6.165037] [     T50] pci_bus 0000:01: resource 1 [mem 0xfc700000-0xfc7fffff]
>> [    6.165782] [     T50] pcieport 0000:00:00.0: PME: Signaling with IRQ 25
>> [    6.181556] [     T50] pcieport 0000:00:00.0: AER: enabled with IRQ 25
>> [   11.500464] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [   11.543334] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [   11.544875] [    T491] iwlwifi 0000:01:00.0: of_irq_parse_pci: failed with rc=134
>> [   11.593524] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [   11.636355] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [   11.680033] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [   11.721230] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [   11.722728] [    T491] iwlwifi 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
>> [   11.773976] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [   11.816771] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [   11.859334] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [   11.901868] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [   11.944393] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [   11.945931] [    T491] iwlwifi 0000:01:00.0: HW_REV=0xFFFFFFFF, PCI issues?
>> [   11.952685] [    T491] iwlwifi 0000:01:00.0: probe with driver iwlwifi failed with error -5
>>
>> Booting with the patch and pcie_aspm=off made the PCIe card work again.(snip)
> 
> Regarding the ASPM issue, could you try v6.18-rc3 (in addition to your changes)?
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20251023180645.1304701-1-helgaas@kernel.org/

On 6.18-rc3 with the change the link does not come up without pcie_aspm=off.

[    0.000000] [      T0] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] [      T0] Linux version 6.18.0-rc3 (geeko@buildhost) (gcc (SUSE Linux) 15.1.1 20250714, GNU ld (GNU Binutils; SUSE Linux 16) 2.43.1.20241209-160000.2) #1 SMP PREEMPT_DYNAMIC Mon Oct 27 00:28:53 UTC 2025 (25c11a7)
[    0.000000] [      T0] KASLR enabled
[    0.000000] [      T0] Machine model: Khadas VIM3
[    0.000000] [      T0] efi: EFI v2.10 by Das U-Boot
(...snip...)
[    5.352599] [     T50] dw-pcie fc000000.pcie: error -ENXIO: IRQ index 1 not found
[    5.396341] [     T50] meson-pcie fc000000.pcie: host bridge /soc/pcie@fc000000 ranges:
[    5.398529] [     T50] meson-pcie fc000000.pcie:       IO 0x00fc600000..0x00fc6fffff -> 0x0000000000
[    5.418773] [     T50] meson-pcie fc000000.pcie:      MEM 0x00fc700000..0x00fdffffff -> 0x00fc700000
[    5.425683] [     T50] meson-pcie fc000000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 4G
[    5.474722] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.480590] [     T50] meson-pcie fc000000.pcie: PCIe Gen.2 x1 link up
[    5.484394] [     T50] meson-pcie fc000000.pcie: PCI host bridge to bus 0000:00
[    5.490965] [     T50] pci_bus 0000:00: root bus resource [bus 00-ff]
[    5.498755] [     T50] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
[    5.504874] [     T50] pci_bus 0000:00: root bus resource [mem 0xfc700000-0xfdffffff]
[    5.511625] [     T50] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 PCIe Root Port
[    5.518768] [     T50] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    5.525573] [     T50] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.531506] [     T50] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    5.538287] [     T50] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    5.545718] [     T50] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
[    5.553588] [     T50] pci 0000:00:00.0: supports D1
[    5.566793] [     T50] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    5.578507] [     T50] pci 0000:01:00.0: [8086:2725] type 00 class 0x028000 PCIe Endpoint
[    5.587460] [     T50] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    5.605768] [     T50] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
[    5.633594] [     T50] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
[    5.637380] [     T50] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    5.656009] [     T50] pci 0000:01:00.0: ASPM: default states L1
[    5.701063] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.702251] [     T50] pci 0000:00:00.0: bridge window [mem 0xfc700000-0xfc7fffff]: assigned
[    5.710285] [     T50] pci 0000:00:00.0: ROM [mem 0xfc800000-0xfc80ffff pref]: assigned
[    5.724147] [     T50] pci 0000:01:00.0: BAR 0 [mem 0xfc700000-0xfc703fff 64bit]: assigned
[    5.779528] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.822074] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.864902] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.907448] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.908544] [     T50] pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)
[    5.957865] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    6.000358] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    6.001437] [     T50] pci 0000:01:00.0: BAR 0: error updating (high 0x00000000 != 0xffffffff)
[    6.051178] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    6.052267] [     T50] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    6.058144] [     T50] pci 0000:00:00.0:   bridge window [mem 0xfc700000-0xfc7fffff]
[    6.069323] [     T50] pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
[    6.069333] [     T50] pci_bus 0000:00: resource 5 [mem 0xfc700000-0xfdffffff]
[    6.069341] [     T50] pci_bus 0000:01: resource 1 [mem 0xfc700000-0xfc7fffff]
[    6.081804] [     T50] pcieport 0000:00:00.0: PME: Signaling with IRQ 24
[    6.095413] [     T50] pcieport 0000:00:00.0: AER: enabled with IRQ 24
(...snip...)
[   11.750786] [    T518] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.793509] [    T518] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.795130] [    T518] iwlwifi 0000:01:00.0: of_irq_parse_pci: failed with rc=134
[   11.843840] [    T518] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.885754] [    T518] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.930959] [    T518] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.973534] [    T518] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.975045] [    T518] iwlwifi 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
[   12.026031] [    T518] meson-pcie fc000000.pcie: error: wait linkup timeout
[   12.068751] [    T518] meson-pcie fc000000.pcie: error: wait linkup timeout
[   12.117585] [    T518] meson-pcie fc000000.pcie: error: wait linkup timeout
[   12.158754] [    T518] meson-pcie fc000000.pcie: error: wait linkup timeout
[   12.226957] [    T518] meson-pcie fc000000.pcie: error: wait linkup timeout
[   12.228454] [    T518] iwlwifi 0000:01:00.0: HW_REV=0xFFFFFFFF, PCI issues?
[   12.235248] [    T518] iwlwifi 0000:01:00.0: probe with driver iwlwifi failed with error -5

> 
> Best regards,
> 
> -- 
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.


