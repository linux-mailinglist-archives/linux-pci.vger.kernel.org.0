Return-Path: <linux-pci+bounces-43718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C416CDE318
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 02:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2299830062C9
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 01:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F0435898;
	Fri, 26 Dec 2025 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QjUr0+vC"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F72E63C;
	Fri, 26 Dec 2025 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766712298; cv=fail; b=QaGv3okxM+f1d1Km+5iRrJ+0yzDAC4KmCJ83g5iSOWBz8wjyua0SeklbK9UOzB0gML2cEcQDZAZAaYxuAMq/94wtvQ6OGaXl/luNqHZZH6wgk1gSpp4ME4JKcwBOySlrpohWK6eYx1Wv/NfFBhNJ7Vle0W4h6gjNwnuiPhQN9Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766712298; c=relaxed/simple;
	bh=41VDczaH14SSsaj0W/9Ku40fdpU13P3H1tSoVu6D4rE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hrPvjqrgOOBnvDaSkP5zYWGblL+Nex+FgMCcKoT5YNoYNFK+2iJ3LEVe75xGt8Q8uziu/YoEQu/b4l4NuQjxc1sNQQIp3TfDoR+I3hV11J4sBEC09xw33SMKB2TcAEW5Vu0qEMOFTl8gSrylOmxgqSkibym22PwY74Z9KWwJfNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QjUr0+vC; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0Ld1x/ghOg+IVFOGXUZIw3nXC53T1GpdHjHcUNHP+HZpFFT8lTx5Vsi9RS4BsgMuUTJxYQc8e7W63QwPhGr0Zvu9V+eqSF+pbN/V+bq04M2dI184FvzWy4geiVpSyf2vAk45oT+gDRthkb65TAo1yXsyK3Hi80oKP6hwuUVyLdcW9t4ZJzSsVvZGLtgSd5pOKAhmrLfvanw6ID6U4VIXmQ/EKrZ3jpYgJnIaQ1qJCI0vDARKJfHoIdaeWlyvRGxM8G7w9mfTWVd+8DobuVUSq1618HZeVEE5GAmzZxyJnm+kQ8ButpnLxm32YWUnOOqYnZQX+bG9o1vYIN+QXNPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mv4qf1Fg5WbC4JAXP3cc10Zlsc4ZEOtG/SgmnVz0UM=;
 b=iF/j3kxqSTGSfLJQvrG9IubgrK7GCbCEZgn38aU5OODOB9ZzFixn62F4d9dByrS2IjjVY0yJlND734ElIsKeRLzZMRm/lMml1GKbur3F4aZw72eM5VcfyRjMMcf0Z3ZKmEyXHWoQY9m09I9gVjz71Ue7AlNXjCDZnz6DPIVFu7nsX56gwr6U6M5QdZHl2D9QC8eBjRC1BxSwh/JYaMeKWCeoY7aWOLEa1FWLrCU2+E5TP+32KlZpWqKY0wCvt1u/n04f/Hlvbdg8vmTgeT5jfZi2+oMLkk/cFEqHDSa3HfWvf00woxCWmJf7Ze9oVBFxIbD40UlqVXAZS4e8KCRaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mv4qf1Fg5WbC4JAXP3cc10Zlsc4ZEOtG/SgmnVz0UM=;
 b=QjUr0+vCDbhlMJq/3FDIl3lpArOJDM92IvxW8xApMs4Ptt1Hx0l0YzrKSx0zMpWlFsAlTAI7NadTnnwKX89AqNL0DgsNAoVviZv7+Va5rAQZIvwnUzvi1pBWxBZgq/pOXWfmqbGLOWQ+YnTCF9m2go0gUwXTn6SjzrOPpmve7jeDOwLv2nMv/kMXiBcgO3Dm65FGNKWPgCsIX66zfHTLP3U3swYPFI5b0kcsAWXhY3MxJ1nDHaPyJUUBaZJwYfQs26R2zY2GbSp5bfYNckTe0EtnIMPMzrgnzQgr+9buTGl/Ua3h+KkQSik/1u1i7NnR3JeKszZWLNZwPYaVPZywRw==
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18) by PN2PR01MB7948.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 01:24:51 +0000
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4]) by MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4%6]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 01:24:51 +0000
Message-ID:
 <MA5PR01MB1250076F034FD97B4F611DF24FEB0A@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 26 Dec 2025 09:24:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/ASPM: Avoid L0s and L1 on Sophgo 2042 PCIe
 [1f1c:2042] Root Ports
To: Inochi Amaoto <inochiama@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Han Gao <rabenda.cn@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
References: <20251225100530.1301625-1-inochiama@gmail.com>
 <20251225100530.1301625-2-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20251225100530.1301625-2-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0041.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::7)
 To MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1e9::18)
X-Microsoft-Original-Message-ID:
 <88cea083-8e9e-42ee-a2cb-e78257ea3a43@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA5PR01MB12500:EE_|PN2PR01MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acc65b7-9316-46ff-4bad-08de441d8ffd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|8022599003|19110799012|15080799012|23021999003|461199028|1474299035|6090799003|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXBWTWo4M3dMaTR0YUUzSjV4WFFRS2hxVnJ4dzJLNTRDaEIvN1RFbEw2dXhr?=
 =?utf-8?B?NjlyMVlrNW1KMEdXejh0Qnhsd0ltYkczRlc1R3E0Q3Q3ZGkzbXdiKzV6cVRp?=
 =?utf-8?B?ekFKV2pGakcwbktzblkzYzZkVWRhZGlsMlJaUWlFRjhvanNMMzVrWU1ERWZw?=
 =?utf-8?B?NnB5WGZpMEJQcFpuTGdQYlg5T0YzOHJnZEM3bFhXaXJwWENPT1ZYWnBkZytq?=
 =?utf-8?B?SDhBMXRLUk80L0UrTnh0V1Q3MWR4Nk5VV0lKdC9NeTZUUjg1TUo5enY0Kzhu?=
 =?utf-8?B?M0MwTXplS1FKMkRmcmJBZ1hWTUZKcGZTQ0pyd0g1bVlLTURObkd1WHZQM3Y0?=
 =?utf-8?B?NStteCtNWWxMNE1Hb2ZrdEVLK21QOHJEMEwrMkVJYUF3SnhuRGQ2SjZFY3NB?=
 =?utf-8?B?RVc2VnBSaXZyV0JuS21obTlzTnl6SXpya3ZadEdwSVVoTzR6Y2xXN0ZLWXZq?=
 =?utf-8?B?QkNPcGJFZ0JMQVgvWVJBbU9kNzJSRFJkaEdoLzFEYjNSanUvNEpMZ3Y5cXJW?=
 =?utf-8?B?b1BCZXF6azlrK3RodWF0dmVLMXVOY1RaMmQ2SktqUGF3TkdmUjBtdW5ZSkhk?=
 =?utf-8?B?YWx2eG9wS2xwdWRNRkNOVC9DSUg3MUgzMkhNSHZ0VDdpTXZvWjd0eFpjYUtC?=
 =?utf-8?B?cXVIRXY1Q0xJQmtRem9uZFQvTExPKytsNytLU1pJNDk3Ym0wS3BnVDRxMmxo?=
 =?utf-8?B?T3g1Qk5EK2ZJeEpnMjBvQzhZbWRDM0taSmUyQXduWEhPRXUvWWFqR0VtMjlC?=
 =?utf-8?B?M0laZFQxNGF4d3dLSjl3WjlTdlpmWTlRNGFGS3FwOG1WQlVMSlFMcXVSS0s1?=
 =?utf-8?B?VTMvU2dhcDFiTHB4M3UvQ0MzaWE2UzZrSFV6R1p2TmRnUm9vbnRCV3lDa2lu?=
 =?utf-8?B?bGdmU2czWi9wUG9wTy8xOTVQQnp3QW1hREZvSWpidFFOSDdYOXQvRWFKK0VN?=
 =?utf-8?B?SWRqc0xNYXFhNFVrQzh6U1FXbG9hdW5YbkVpVkEyM2pnL1Q0VnBES2duVDRu?=
 =?utf-8?B?SjNsTktUK3lHeDNBR3NTRC9nSXgvaFdQdWF6R3pBVWQ0blZxQms5QzA1L2Zt?=
 =?utf-8?B?K1JtQkJlWFpNbGRLZUo3V1Y5VjYvVVZnS3lUUW8vUWVmWXBJVVhodXNGd3pp?=
 =?utf-8?B?T2R6SDNNL3o0ZllVQVhXbmlNV3dFdHBQR01NbHpPYmZoNUs5WWpyS2JuK3hU?=
 =?utf-8?B?NWZ4dHVhb1JndG5PZnpmS096ZGhqVjA5QTFRNFEyWUJVUHE1aml6eU5uQ1hK?=
 =?utf-8?B?a1BXZ2xaMFpUeDY2V2JBSlZuN0g0U09UYXZoNVhhZDRPakM5aGhtamtPajk4?=
 =?utf-8?B?N3FsbGhWZkZHb3Rrd1NZWXAyVStHejVTZ1NiSUJ2MXJBNi8xL1J5YlgwWXFW?=
 =?utf-8?B?ZTM2VmVVWlJVV3RWUEs1ZDlrVCt3MWNjN2lSd09iZ3RIalFFR0JsTS94SDc3?=
 =?utf-8?B?VTI4NmVvUUF4REx0UnAwNnBnZExOQkYxWUNnZGtIYTh0YUd0YktSeTRwaDlx?=
 =?utf-8?B?aDlqMDRGZThOT2JFQktGSjgxVFc4cTJGQ1dZSUFka1AzdjBIeXZ2eVRZK3l0?=
 =?utf-8?B?RTZ1R2I4eHlsbVAxM2t3OG1zZ2JReWp4TGhIa2Rpc2Q0NUp2dlJxTk02ZXho?=
 =?utf-8?B?ajVYRkJOR2JzNkJSa2M3ak5RSWpyWFE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ui9TRVJLUDM3Rnk5R2ZIMDlEMitzdTlaK3dscndickdXbllrMFVQK2hDVDhO?=
 =?utf-8?B?Y3JkdXJKUEs1cWFLdWVNRjVqbWVzQTJFeWxvMFBrWjZDdFlXZy9nRmJpbE9D?=
 =?utf-8?B?Z3V0SWh1andpTlVSYVB5QzZvMXFpMXBvMlV0SVd3RnhlTGxjWHpRVTArbkFp?=
 =?utf-8?B?b3FjUFF5L2Mxbk1vRGhRQXl5ZE9NOS9pdy9JdXE1NXVNWXpZQlgwWHkwdlBP?=
 =?utf-8?B?TUxFdnBxanF5MjdXQ1Izd2VyWkhtSXlVSHdBRjBRVHo4cFJSb0xoZi8rTTNQ?=
 =?utf-8?B?eGt0SVhtdTFhVm1ud0J1RHVkTnN5MjBNTmRva0l5a0lvbTljMEdSbk1BNWg0?=
 =?utf-8?B?Y1VQZ08zQWlLU3owSGlzWW5OWEc0bmZDY0U0cnAxZ2RmR0VYa3lsbHpMM1JH?=
 =?utf-8?B?b09RRDJOVDBWYll2TSsxcUpjb3N0UjJpQnRleXVSKy96TnRhblA3Q05na3Fv?=
 =?utf-8?B?SDYvanlSemlnZkZoZlR6bjhoeHF0K2JaaERDczRGdVJONTRTczBseWUweG9t?=
 =?utf-8?B?QlVJRjBzZEFFMlA3MzhRaGVxSDgzdENjU3Zjekw3K1FGeVdQSGVpYXlGMHNy?=
 =?utf-8?B?ZUVTMmdxNVg1S0NHZTAra05yTjRjakhramxFNU02UDZFQ3ZhVE95dTBXeWhB?=
 =?utf-8?B?Z3Q3VERVenM5QlY4Z0hiZ2F3Y0JmVldLeFowcHg3bFhoUTBlTVA1dzZyQlBM?=
 =?utf-8?B?VUdsZzNoK3ZqWW9JbUczQlZqZG1neXIyS0svamczVGxYbmpPUU5WYU1wb1BV?=
 =?utf-8?B?cCtPcndwUVpKUjNmeUp2bEhwTnpXeFI5Vk5wOFlqUkVLUVh6emVERzZLRlQ3?=
 =?utf-8?B?WlNwL0Z2bk9zbHBydXlnL3RiN1JQOHpwbGNiME5kTkZzeFFsRWQxOXFQL3lM?=
 =?utf-8?B?cTNDSWdjWVVveGtnTCtFbm4wVndBL2srM0pKdkZIWDE3K0FhUGtjKzNUalZy?=
 =?utf-8?B?aE1rUm5hNnV0c3BrNy9BeHZWSEdMc2Y3eEVCUkZoWTltWWxDRFg1M0d0TFJ3?=
 =?utf-8?B?bTRsOWFPenNlN2VGdVErRFhXSDlXVkdETVgvbkFvZW9IbHN4bjBCUEttYmxa?=
 =?utf-8?B?NUJ2SVl2eVNRTnIyUkkvaVQyc3BwMnAwRUgwakVseWVzTFVEWHNCTks3V0hq?=
 =?utf-8?B?b0hRUXIrVVpXL3l3bktUcTgyQ1N0cDFCblBLWmdQbldUZnlEcDAwNFppRGtm?=
 =?utf-8?B?eTJBdHl6VWZ2N2tUT0x2YlBpTGhyZ2ZlcGpaUnFzSG45SVdWUE9UM3JCdE1Y?=
 =?utf-8?B?ZnNYaElPOGRMMEExakpkb0RFM0o1NXQyT2dPcm1CRFl6K1l1em1Xb0JMSUI4?=
 =?utf-8?B?TjM1RkhXTHQvakNjT0g4SUNMTnRlTm5TbGxGTngvVy9rUG5FNGVZVkxSNGhu?=
 =?utf-8?B?WXMyYmpVeGR4TzEzd3l6a0djTVA2UzFMSkVLYndsODlnTEYyOHZGQUhjcXFO?=
 =?utf-8?B?RHpoNlNzdGlvdjBwNVBpWURPb0hPQlZsc2JIMm14c1FFeTlXZVhtRjdmaTV1?=
 =?utf-8?B?dndKTXdtTWppKzk4QlpxVUVSZWtDOTNvblNHQnZxREtwZk5Md2dZY3Jhbkdl?=
 =?utf-8?B?RE1MNXZaVE92QnltKzhPZzgzNHNKQnJHMlRmTEsrK1FNU2lzYUFJdEt5STNC?=
 =?utf-8?B?NlMwRnh5NlhENjdWWlhSeEVSa3RxVlgrZDRXMXozTTFBRFVEVHNpbVFhemFR?=
 =?utf-8?B?RVhXMVhlZyszOXJtWGszQUJEN2hnbHVnYnhXeDhZWDBFNEVieVNra3BUWXBl?=
 =?utf-8?B?aXVoaGNCMjNCOWpqVDlYSWh0RjU5WlBPS3lpeGZKZkZoNDV1d3lvQTRZMXZU?=
 =?utf-8?B?eEN4T3RmRjVVcHJVTDF5MWNFNWE0VnNra2pxb1hlQlF0WnhYbXpIOXIyUnZs?=
 =?utf-8?B?Qm1IYi96ODNHdDBXdjZPc0dQbUZheFRYcjEwQzAwMG1ROFExZUI1UmxVazFt?=
 =?utf-8?Q?bS3JqKU6cB4DMrID1XFWfNJh2AudiV5f?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acc65b7-9316-46ff-4bad-08de441d8ffd
X-MS-Exchange-CrossTenant-AuthSource: MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 01:24:51.2473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB7948


On 12/25/2025 6:05 PM, Inochi Amaoto wrote:
> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> states for devicetree platforms") force enable ASPM on all device tree
> platform, the SG2042 root port breaks as it advertises L0s and L1
> capabilities without supporting it.
>
> Override the L0s and L1 Support advertised in Link Capabilities by the
> SG2042 Root Ports ([1f1c:2042]), so we don't try to enable those states.
>
> Fixes: 4e27aca4881a ("riscv: sophgo: dts: add PCIe controllers for SG2042")
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Han Gao <gaohan@iscas.ac.cn>

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Thanks,

Chen

> ---
>   drivers/pci/quirks.c    | 1 +
>   include/linux/pci_ids.h | 2 ++
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b9c252aa6fe0..d775ff567d1b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2526,6 +2526,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1);
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PASEMI, 0xa002, quirk_disable_aspm_l0s_l1);
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SOPHGO, 0x2042, quirk_disable_aspm_l0s_l1);
>   
>   /*
>    * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a9a089566b7c..78638cbf2780 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2631,6 +2631,8 @@
>   
>   #define PCI_VENDOR_ID_CXL		0x1e98
>   
> +#define PCI_VENDOR_ID_SOPHGO		0x1f1c
> +
>   #define PCI_VENDOR_ID_TEHUTI		0x1fc9
>   #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
>   #define PCI_DEVICE_ID_TEHUTI_3010	0x3010

