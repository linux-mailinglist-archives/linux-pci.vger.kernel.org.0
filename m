Return-Path: <linux-pci+bounces-17503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD5A9DF858
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 02:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27201162A16
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 01:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187CD17C68;
	Mon,  2 Dec 2024 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ce+qyb70"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010001.outbound.protection.outlook.com [52.103.68.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36A91804A;
	Mon,  2 Dec 2024 01:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733101997; cv=fail; b=ruXsvFpBIqoweQCU8EKQn5ozFLHYjVENgbxjNBB/AZYmoSrEK/uFD6OSXRef//sStyEy99OM8zKqFFaDEJePg0ORqxURNRkX68JUIpzgsAMaIPRnqvi0GOCi0H+Ps/Nq/l2VS8wyNF3Ql4jXN7mVEbJyfGtYMi06ru9lTo8QC0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733101997; c=relaxed/simple;
	bh=flGgbyu3K5b8dAbClGqdFXYXkPbXVAPT5qgPyCcDf9U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QX/hXELO/qEnOIOzYLCkw61wEvo3bnvuMCPLsoxauSa3RdIZnef+BSP5LqGfUQwFJUv82r5il00TmTgatmy4zWHPUSk5MVBV5w0HPtz3+1/NdTHV6pf66gcKzfn/LuB4MOwo9PHglY5dJJCib+r9oZ7ILYHCa5lptfXj1x36PAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ce+qyb70; arc=fail smtp.client-ip=52.103.68.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqzYTrKYPIfxCPhLD9fsbNobEN/MmZz+bmZFn+IzYCK3tPjScMzhTd4W/qH/DNSMsRsM7uRO/MuXUUVsetbP7A733XP9bqW8sVSIom+xxDehdl1nCSiccAS+fmx8C2m7vjHApI9KhEFgRz8EAdjUPNt2gOOR8Ue+5qayM3rT5DY8kY7AQdrGHxw/8zaGeHMQBFYSWcR2vaEpwpRl8t46B6f1u8KIhV7F3mM0Js2CcUCws6U8zhF/VE75oza7eKEssQNQ/fHtsZDjKk9b8ZWKYZbjYsshDwe1sK5suoCtYZ879195Ev+U0NyZvKB/2MHTxyGq05R5YHAYbpDlGdG0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unIjfumOIbj6MvEdaMElnhmqgQvlPVF+bAFpF/CON2Q=;
 b=P0C2Dsl18WKOX2ySGf1Ry7eNNaihIFdCD4Kn2wv6F6Dhlfg9CcNf1/nfiRGR40pI4rZ8+uOlgzbrwB4K5bvcEK3Rcevs92amg0e7/mVw5K9dLW9DznznpJOapYMOYE17Y3Cm3q+D89yCYctGA5oGsr8tYg0qiM1/vS5x+vYG+nxyNJh0zSfWsQq/3nkvquB3pW6J/CpktInKN+EAU/vOUFA8wGxBw3vonfbG5scaZO0VR9iknyCA4GPdRq8toV6vMoPdAYJyZzcBJao3gVhbGzEzASRx1RXUARF+MAM6RAblO9aYt0xHvrKHqYWzgQpJ0/wYfXQQzPWMwfpJEgA3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unIjfumOIbj6MvEdaMElnhmqgQvlPVF+bAFpF/CON2Q=;
 b=ce+qyb70bO7lISc15J+g5K9STRwENLkNekMbvz4UmNthgNZMQEu92ybwGqCJ2mE0bl2FNUBs6gq0revICP/UzQGFgvGVaaNmg5Hf4Ej2/OsEFC3nMlP4V9MHUSy8kinlY6Xzd3ozTCpOJLtgUga+6glh7pFF+31rfHM77TYNvQUUCn8Q4PjczPer0vYNVQEodC9LYUoo6McsIyxEThj+JbI29XMO6BH+4oAZEQgQBxymuBLBR7/Fn9/CVSDOPzGRQjLJTCQxRfCnwYznQnSLQgAmJzdt6qT+UMH0l9fq9Yhn2TQjd/b3vnRLsFf1CDXRG8J5e2d8zG78VWI43X7OuQ==
Received: from MAXPR01MB3984.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:68::20)
 by MA0PR01MB7395.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 01:13:04 +0000
Received: from MAXPR01MB3984.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::285f:e601:b80b:465a]) by MAXPR01MB3984.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::285f:e601:b80b:465a%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 01:13:04 +0000
Message-ID:
 <MAXPR01MB398467232518EDC15113B93BFE352@MAXPR01MB3984.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 2 Dec 2024 09:13:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20241129195000.GA2770247@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241129195000.GA2770247@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To MAXPR01MB3984.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:68::20)
X-Microsoft-Original-Message-ID:
 <848e1bff-1945-4279-918c-4177ece805f4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAXPR01MB3984:EE_|MA0PR01MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a01d3e-b2df-4b48-029b-08dd126e78da
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|19110799003|6090799003|7092599003|8060799006|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0s0WWVBTmZTOUZ5OXpjY3pJdUtzMW1hMEhjS3FJeVpDWnFwT0NVNGVYVnhM?=
 =?utf-8?B?V2p2MHVaUDNhVkwxSkVDRHdCWGQvdGY0TkFPNkVtSVFaelFjVHl1d3pMbmVs?=
 =?utf-8?B?ejBvRHMweWhBYUMwODJ5ZVl6UmZoU2ZKdHhBNHhudmYwRTVVRDhtNnU0ZDhz?=
 =?utf-8?B?WldCZzZUdjNaY0ZCbHdlYnI2OHEzSTVNWm1EL091eml1eFlJN1cwVHQ2Y1V1?=
 =?utf-8?B?cDZ0eFZocU0xWWkvMlRXSC84U1RqMWgzQVZvWXVLN0M2cDhvRlFNVEx1ck8z?=
 =?utf-8?B?MkJ5NWZ2dlJ6WUdEZS9CNjYxYlJadHdXWkRMTHVzd01wRW53TTFlYkpZS0dN?=
 =?utf-8?B?dlEyRWFuV3l6UEVvTXhwOGJQckZhUWxWYlpwaXJkdlU0Z3VETHpxMG1jYXhR?=
 =?utf-8?B?MWVGU1VIdWJJS2U0UG9OK0JZRUlNN0w0cVpZZ2JEUlljdTZoMVJvdjR5ZVZi?=
 =?utf-8?B?RklaZHlBc3RiQmRXa05OSG1hUGRpWVhLdkxGQlBnQ01ycUZ3bllCYm01UHho?=
 =?utf-8?B?dTcwQ1Z6UGZGZFRJcklUTEdZUU1UV1hCR2tMNDFQZ1ZMR0loNlZSaEJEUXE0?=
 =?utf-8?B?SmpNNHA4RG9tT3BZOGl1ZHA3RGZDd29uTHp0YWFrZnJreTVtRTgrSDBWaUxX?=
 =?utf-8?B?aXp5RktNTEU1NDBXeEFyc04xQmFmdkl6RTcwcVd2ZlYzbmJpbVNLamt2cWsy?=
 =?utf-8?B?MFl3T0RCaHBsQWNQelJGMEJSZ0VqVUpac1NxVEdKSHhjRzJpeGM0bHErenJV?=
 =?utf-8?B?UkZDUVQ0K2RwQlFPd29uSmptOHJ1WE0wZTVaZ1JVUGo0NVFpYWc0eGpUME1z?=
 =?utf-8?B?ZTFOZEtNNHNTOWFnN0F6SnNUcGpwRExOWldvVmY0VEd2RTljOEk3cm1mRXR6?=
 =?utf-8?B?WmQxbFVnT3RTNmxSNk41RkFxVlRKaUUyU0RDOVBLZW83QU16Qjg4RUFudzhJ?=
 =?utf-8?B?bEFDQ1c3cHByamdOMVZrWmM0RWpPMktUTERwU29ITkVkcWhpREUra3RPZTNN?=
 =?utf-8?B?c1U5L2NHTStuSUdzenRYMG9jRm9JT243ZWxCZy9JSFY2UWFnZ01Lam1vVEJm?=
 =?utf-8?B?NW5ZY3ZoRXpsamZic3Y2dzMxalpycTlySENnOGpteGo3Zm5xQkU1cjlVU011?=
 =?utf-8?B?Q2VWQjJuQ05lZWphcDg1SHI3WjFjYUdSYjYrTk1rbUVOakpQdWViRXQxTm9L?=
 =?utf-8?B?QjFkamtsUzYrcjZna3hkRmg3SWdmcjlWbWxML0UwZWVHRFZ4ZW1rOC84SmNF?=
 =?utf-8?B?Y2hNMDNQMmxWVnozeUo4N05XU082aEcrbWl1YlA5TEZUaVcyT2xtMUt5WjVF?=
 =?utf-8?B?NS9jZmhEeTlCMytJeDcvcXM2R0NCN0dMTEh6VGhhNzV1OXJFM2oybkRZUlNU?=
 =?utf-8?B?NmtHQkJpVVJIeVowN3VycXNFMDVpVVErU1ZmTXBac2hmN0YxM00zMWpJV3BV?=
 =?utf-8?Q?llrTKXb7?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEtXY1RDaWc3OWFMS0FROU4xNXRmU3lzSVMvSFFJVlB6QzhtYzl0ZDBsS2VN?=
 =?utf-8?B?MEZhYUlCanR3M3krbVgyZm84b2hmelpnMG4vVHg3TG5PbytNU0NYL0dwYTc3?=
 =?utf-8?B?ZUVhemlZYmRLODFFYmlVVHpzc3F3Y1NIUWhlbWk1RlBZT0swNngrRlU0M2g5?=
 =?utf-8?B?R25UUnZ2UmhJUHZZZmp6eE42Q0tDbEx0RW1WTmdvdjVqaVlpTEU4MGlzZW5x?=
 =?utf-8?B?MFdibGh5ZDBzSmEyaXJ5ZUNpQnVudUkvaW4yaDVWc3dHZXhTaFNBNzRwSmEx?=
 =?utf-8?B?Ui9SVm9XQ0cyb3l2aFNkN0pYS0E5eVBrQ3ZDamQ5QTZuLzYydUloVjNLQ1gr?=
 =?utf-8?B?b2F2aU51UmkxYUJpRlBDSWRkZUEwQXk4UnE1elg5cEFnOVJqcTdiNHFxdURO?=
 =?utf-8?B?aFgrZnhsRk1PWklaZmZLSGpaaHdtNW9ndjJBR20xRG8zay9DS24yblZUNDVX?=
 =?utf-8?B?TkhvcWdTL0hqelFLT1VGMzZtNlAxL0luZEFZODNvM04vTFVYblhRSndubVB5?=
 =?utf-8?B?bXE5bWdMd00xbEpXOGtMTjJ2Ym9EMXZHS3ZyVENLd2FKTXhmTTlQejdBWDQr?=
 =?utf-8?B?Q01KODg2eGhsWWJPWGtVQW9SZUVjUEs4dnluTzNIblJ6Zk0vVnhsK0I2U2dV?=
 =?utf-8?B?aExMU3pDNkxSNzJBMjRxb0hHOG90cWVLejdUaHNnU2l1OVZpdDVkd1Rva3o0?=
 =?utf-8?B?ckNjcjE3aEtsTmFVUW1MWHRkQ0d1UEczNGp4bjdXNEdFVHhYaEVGcDEvOE5l?=
 =?utf-8?B?OHJxcmRob0FSQ3BrOGlhZzRJVHkxR0twbUpnd0VML3NZVkZ1cHdyZW1LaXpv?=
 =?utf-8?B?TVFOeDROWERxTURFdTJqZlpZRUxBVm5yVlVhaWpHWVFiMFhObDd0N3ppMlF3?=
 =?utf-8?B?UTJNUWQvYkZJcFBIRlg4WTV3cUhNYkljdmpzOUlUVUgvRDhMUEU4d24rQzVG?=
 =?utf-8?B?SWNOMHpjWDNIQitLbXgvemZhRUhteG5NL0NLRGplWE9YdnVmYk9TdnJmTlVO?=
 =?utf-8?B?RVBpRDN2blpBR3RtdUowekdXUk9mOFhmbEZLMXQ2dmt5MjFxdkRRdCtNSnE1?=
 =?utf-8?B?ZHVMMUdpK0RXOVFBRjFKNS9WYkRxc0xiT1o3cmpNenFFZ1oyR0FURUgzdXpi?=
 =?utf-8?B?Nkhnc3R0Um1jaE9McEZSaWJiazEvUkZKdDBYQ3BlN0RHTkxSeXVRVVh1bm8w?=
 =?utf-8?B?c2NhdW9IQWROMG8xdm91TElGQ2tQc05ocHRITk5LSUdXSjFsZjBHQ2dzQXMz?=
 =?utf-8?B?aVo1cTFXNW5leks5c0FBSWR0YnY0eVk2NjRPOFVVSGxQdHJPWjF2R0hLdkVS?=
 =?utf-8?B?c2FqbkRMMitYZTV2YmgvYkNsbTVJVGgvVkdMQW1qSDRZallOSUN5bFI3YTBs?=
 =?utf-8?B?M3prYTUrR09DSE9JdjV6SDhHclg2Smt3NG1vZ3pEbDErTndNa2lhbnMyYmNV?=
 =?utf-8?B?TThwdlZCUTd5TG5rbGpubnUrM2RITGw3Ni8ySktCQkx2di9LdUozUFNZTGU1?=
 =?utf-8?B?UzlyaXNwTWF6eTFERVJEREg4WWpvNlRtek8vTWIvekN5RE10NzVYUjVvSFIr?=
 =?utf-8?B?Lzd5VllzTFNMa2ozK1ZEY09nMTZmbXRvN2pnNmdpTkpzTlhBWGUydGtVZk1s?=
 =?utf-8?B?bFRNNTFBdFltVTc2Uk5Ra3d6Mll6Z25mNTFPMFpqUU9vUUN5Vy8xV0VTZkpv?=
 =?utf-8?Q?kLS3BdxbabnraBTVuaaY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a01d3e-b2df-4b48-029b-08dd126e78da
X-MS-Exchange-CrossTenant-AuthSource: MAXPR01MB3984.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 01:13:04.3204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7395


On 2024/11/30 3:50, Bjorn Helgaas wrote:
> On Fri, Nov 29, 2024 at 05:51:39PM +0800, Chen Wang wrote:
>> On 2024/11/13 5:20, Bjorn Helgaas wrote:
>>> On Mon, Nov 11, 2024 at 01:59:56PM +0800, Chen Wang wrote:
>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>
>>>> Add support for PCIe controller in SG2042 SoC. The controller
>>>> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
>>>> PCIe controller will work in host mode only.
>>>> +++ b/drivers/pci/controller/cadence/Kconfig
>>>> @@ -67,4 +67,15 @@ config PCI_J721E_EP
>>>>    	  Say Y here if you want to support the TI J721E PCIe platform
>>>>    	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
>>>>    	  core.
>>>> +
>>>> +config PCIE_SG2042
>>>> +	bool "Sophgo SG2042 PCIe controller (host mode)"
>>>> +	depends on ARCH_SOPHGO || COMPILE_TEST
>>>> +	depends on OF
>>>> +	select PCIE_CADENCE_HOST
>>>> +	help
>>>> +	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
>>>> +	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
>>>> +	  PCIe core.
>>> Reorder to keep these menu items in alphabetical order by vendor.
>> Sorry, I don't understand your question. I think the menu items in this
>> Kconfig file are already sorted alphabetically.
> Here's what menuconfig looks like after this patch:
>
>    [*] Cadence platform PCIe controller (host mode)
>    [*] Cadence platform PCIe controller (endpoint mode)
>    [*] TI J721E PCIe controller (host mode)
>    [*] TI J721E PCIe controller (endpoint mode)
>    [ ] Sophgo SG2042 PCIe controller (host mode) (NEW)
>
> "Sophgo" sorts *before* "TI".

I see what you mean. I thought we just had to make sure the item IDs in 
the Kconfig file were in alphabetical order.

I will make changes in the next version based on your suggestions.

>>>> +	if (pcie->link_id == 1) {
>>>> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_LOW,
>>>> +			     lower_32_bits(pcie->msi_phys));
>>>> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_HIGH,
>>>> +			     upper_32_bits(pcie->msi_phys));
>>>> +
>>>> +		regmap_read(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, &value);
>>>> +		value = (value & REG_LINK1_MSI_ADDR_SIZE_MASK) | MAX_MSI_IRQS;
>>>> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, value);
>>>> +	} else {
>>>> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_LOW,
>>>> +			     lower_32_bits(pcie->msi_phys));
>>>> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_HIGH,
>>>> +			     upper_32_bits(pcie->msi_phys));
>>>> +
>>>> +		regmap_read(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, &value);
>>>> +		value = (value & REG_LINK0_MSI_ADDR_SIZE_MASK) | (MAX_MSI_IRQS << 16);
>>>> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, value);
>>>> +	}
>>> Lot of pcie->link_id checking going on here.  Consider saving these
>>> offsets in the struct sg2042_pcie so you don't need to test
>>> everywhere.
>> Actually, there are not many places in the code to check link_id. If to add
>> storage information in struct sg2042_pcie, at least four  u32 are needed.
>> And this logic will only be called one time in the probe. So I think it is
>> better to keep the current method. What do you think?
> 1) I don't think "link_id" is a very good name since it appears to
> refer to one of two PCIe Root Ports.  mvebu uses "marvell,pcie-port"
> which looks like a similar usage, although unnecessarily
> Marvell-specific.  And arch/arm/boot/dts/marvell/armada-370-db.dts has
> separate stanzas for two Root Ports, without needing a property to
> distinguish them, which would be even better.  I'm not sure why
> arch/arm/boot/dts/marvell/armada-370.dtsi needs "marvell,pcie-port"
> even though it also has separate stanzas.
>
> 2) I think checking pcie->link_id is likely to be harder to maintain
> in the future, e.g., if a new chip adds more Root Ports, you'll have
> to touch each use.
>
> Bjorn

Thanks for your input. I looked at the Marvell solution you recommended. 
It seems that it is a relatively complex IP design to support mvebu, 
which can flexibly support the export of 1 to 4 variable root ports.
The Cadence IP used by SG2042 is much simpler, and it is fixed to export 
up to two root ports. So I plan to implement it in a simple way. 
Changing "link_id" to "pcie-port" will look better. The writing of link 
actually refers to the terminology in the Cadence manual, which is 
actually the concept of port.

By the way, there is no demand for scalability at present, because it is 
said that Sophgo currently only uses Cadence IP for the SG2042 SoC, and 
subsequent products should switch to solutions from other suppliers.

Any question please let me know.

Regards,

Chen



