Return-Path: <linux-pci+bounces-39627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6B2C19E44
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 11:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2B018950D6
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 10:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BCD1D27B6;
	Wed, 29 Oct 2025 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ghBfH+6r"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010044.outbound.protection.outlook.com [52.103.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252B924293C
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761735060; cv=fail; b=B15MnvSOab9DjmGd1AT/cVqEgFjP2JKbUGHNIMDrxOy19e6vPyQ1YqTefKcW+9UMIsEoakcEzWaCzcX20AHW3yOTcPAEO1QR2YHLUdOdduYql2rWYnodCFRSWDM+L4iga5viiPoFTt7Z/kpOegQvfKj11+L2EgS+gFYpdxPa6sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761735060; c=relaxed/simple;
	bh=avDXZRvQayVhDKi/I4oM0t9jqgCZz/1ivX0wb9wKtjQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jf4dV1EvSNhJepzef/1q4lRO6nN0LgI4VDefE4qMKf8cOmJ6B6QVhbQTPZSracO4HS2RTqoxAZKN8S8k6CiblVHNI1Fb6o62C0J5YGUKlgfhrn7lnjDkFj3mVs2mb/yzOnKrULyYLswydNaisj11Hq2kR94PhNC4s0ZcrlTdjJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ghBfH+6r; arc=fail smtp.client-ip=52.103.7.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOdzuQxkW33mPL1NvvusP76KQYoG3H8z2BDE59KgidQXW8XmTNAvTF9/E0JRHDP1UXz9v8WXd+h+FqwEY8usSDmBNtPV4p5rdvAJwBzEiuPqbzTtCr9A5jmGQZ913IMb5M/1EYL4g8+zJIuVfmuydsODJgqdkX/wMpz8Aq5q/tUESzf1eC+0RaiW+fLH4HLBA49appFiTy3eveod/kG5xjiwzAZGUmfYGi8hZXxMSSoWViwsgqRfAmueLgcc1WfE9XkYCRf+zisaKyrHQfPQT4Pxu5w4QzWgAi0nSwbdFjvaJ6bWaWCyySSwL7hSWZ7sc7C6RElOD8wSk8Gf6CVN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdcPAq+5SwZdwZF7Nj65cWsDhOdwI5KpppO6VjdqN80=;
 b=LRLYdJfDNdAoPD1cnX9zBNqdhT8M0i1rrWdAXZJrFFv/U7dPIjtbL6Nkfe51Mb2UZZlabsLoTD9puKPSI2d8mRHqC907ExBXWtIYIk78x0QPeFyzpW3AOm4wd7KIZ+tk16wzc29mJwkmkbp+1BS2tZc7ybzqtfSCcq35SV/d3idxTbkH+/qLPnZSO4uoD3/2Z/aDOsorQsxBQmlWrwWTmJCRlecJ8zMmDxxjmdJ+rik/VpLUehnu+5BsJoGbUh9Vu9I2X2YXLs2TG9pK4j7N8ePBUOtLYCKfIwfy3pI7Ep9mv8hLygEf+3vbv3ZnKGbQBxh2YUowZjy7ULQKdwirjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdcPAq+5SwZdwZF7Nj65cWsDhOdwI5KpppO6VjdqN80=;
 b=ghBfH+6rVTAajX55XUbAAeZt/W2540nFnJu0RikWKriMvWAYmErzaPWBna3C358dsUrXSO/CYBBOmdSeCusXCIKH64S1sJlvn4O5MQj2X/6R26bGWq1xA2XRt48WzOb3kSu5dxuomd5gAFXV3dgDx0dSLWE5cg516aSzwi5vIl/aoKrJezijOb38sHk31HeRcSX8u1m2W15GGZ7PDyzdraXS3EBB7O09iUa8BV9+IdQyQ2rNwjThs/FlaItMIByPrMbfHuiplHANXf+KL5ZGoM2pLFoepvyvrn5ToO/YNZUMch5q6tMiTiev2f/MpFXseZ0x6Znk2ydhWLH8h+fW5Q==
Received: from DM4PR05MB10270.namprd05.prod.outlook.com (2603:10b6:8:180::11)
 by PH7PR05MB9732.namprd05.prod.outlook.com (2603:10b6:510:27e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 29 Oct
 2025 10:50:55 +0000
Received: from DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c]) by DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 10:50:54 +0000
Message-ID:
 <DM4PR05MB1027063F8AA9069B66A632C2EC7FAA@DM4PR05MB10270.namprd05.prod.outlook.com>
Date: Wed, 29 Oct 2025 18:50:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: FUKAUMI Naoki <naoki@radxa.com>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20251028221607.GA1533456@bhelgaas>
Content-Language: en-US
From: Linnaea Lavia <linnaea-von-lavia@live.com>
In-Reply-To: <20251028221607.GA1533456@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 DM4PR05MB10270.namprd05.prod.outlook.com (2603:10b6:8:180::11)
X-Microsoft-Original-Message-ID:
 <5e0112fa-1b5c-4f4f-a0b1-75d55deb075d@live.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB10270:EE_|PH7PR05MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be0bd22-8df8-4063-7a3a-08de16d908af
X-MS-Exchange-SLBlob-MailProps:
	8U9+OAG/EBKOIrvw0yg1SUYvgCcNu9WKpz4Jf6HGto8or+EefH020qIyeHfTT5kBAU1JrhBMrbxMn/0ZO1MMrY1d+6jhNa1o3Po0kmFtug2xZGejPY7ELSdPjh1nu9ffw97eRxwauRt15+z6fQCKvSkBevSSsRC2M854pNG54WbJXM6kqC0ZNvxE6i28j7szg2xp8jE29yK7fqej892GQn5Gahkpg2xsSezxzNGegrsLzAkc04sz1HRWvbFWzemE1+5V7eBjQ58UO8HJDECl1ZMNV6NW2vyiJI7G2i5f5afApjfp9PuR3rKMIAwn/9Nn0lh1vQn2Mukk5rmOIuEkk6idUrcbgyzAStk6GvdG1FGJlLHHdWrwijSmCpW9t9zbN8CvutCO7AoPmhcep3GRjIL0nQ+9W0y7O6aooNACQmtvaiBgpyz6PP7udpFsvxQIrYKG/YScIKJpKXtybGeIF7wKTwN7BVXBBCYAuo2rztm0WuxxAEWjjFkZ2aS8cfKUT3u/x5evHOCelja+ERNd9cEsAnfXcCqpM2uedCvsX4X6PDO+RRU9CJiimAD7oBTFR6ZFu51wvWbzQpxKDjTAndlFcrWny7lIZ9x6xOkHzLh70/xF8xfGPseeSD4mhZz/KKqv9b5lSBslcmzNG+4kz9EHjmSA4triTzFr3AKlVnOjZq0+D6JIoHr/B1b/qL00eIvStCuOgBOIgFyles220FpFoygMQQcqi7dU0dFU4eBcTaGa1fCENLow/eKt2rh62IN/05H1AxylyTKjRK1Ti6GrJyFoxO/oyeRaZPg0fUJPGmeI+dVkojT9wRFhEqbRB9llN2f8N4/nA/YFDi5cag==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|23021999003|15080799012|41001999006|6090799003|12121999013|19110799012|8060799015|3412199025|10035399007|4302099013|440099028|40105399003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlhZa21PNllSVkFLOG9GeHZodjk4R2wwQzlCUUhDN1dkVUFka0VzOWErSmti?=
 =?utf-8?B?T2dXQUQzWkI5RDdlTG5EMmlyQUZJVXBXL0ZwUCtMeDBqUUdMcmRpWGUyb1RW?=
 =?utf-8?B?MDA4dXhUVUtONzB3MHNBM0YvbDFuOHRFRkFScE5iY1VsRHp2ZWFyUmtwZ1VP?=
 =?utf-8?B?TmpEYlpyVzFGMzdaL3JaOHJXY1lNajNCKy94YjZadHVEQ0ZCS2h2UmMzVWUy?=
 =?utf-8?B?ejlzbGQyak1MR1VLeWs0cUhTUGN6QUVqQXlmUDB5UldJSEYzVXpqTnlwTmNw?=
 =?utf-8?B?aE5hYWVRM0Z3QkFuQ2hvL2NUNGw0eWltNnczdUNFSlJIK1ZTTUI0WTZVVEt2?=
 =?utf-8?B?VjU4V1h1MWw3K3RUWmZLQWc2WEVhTTdoNVRtOThUdU14aVRhMUtGMDM2YklB?=
 =?utf-8?B?SSt6blc3eDAzSjN0VTN2Snd6VVdHWnJJekJuNzE1RERkdDNkdkJyOTdzQlBs?=
 =?utf-8?B?YlU5bHVLaHVlVUM3NThUbGpFZkI1Z0VYQkFWVjU4VGNlcDArQjRXck41amIv?=
 =?utf-8?B?WkpmM21RME5wMUlpZ3BoQ1kxbzNXT2p6WEtQR3VwY0JGQ1kwQWEyR0xJdlMw?=
 =?utf-8?B?VHN1ZmdwMUszbjQza1lJL3gybUR0ZHhHbFN0YnJUa3VqUjlKT0Y2bmhNSkZU?=
 =?utf-8?B?M3VLSzhScFl0TWFvM3ZFV1ZZMlh1c2Z0cDY1RDZpMXppRWE0VjdyVzVCZTBq?=
 =?utf-8?B?OC8wVG9ZODR5Q0xiVi9DbHdOeTNGT25HeWZEZXFZTUV3RWlQVDZNZ0p0UW1h?=
 =?utf-8?B?SlR2OXJtcElCdkRZU25HeGZhVy9rVllNTjFadmVWQkxxQjlRaDV5WHRqaFJa?=
 =?utf-8?B?RUhVTzJxT0NIc1V3OXNweStwR1FWSndxZXRyRWVSSWNqSFBZSU1pbmhyRFY0?=
 =?utf-8?B?clE2Tld3bEZDTUdIRjRXU1owMks2WjZyMXpMazlvZ0sycWw1L2ZQYjhNREMr?=
 =?utf-8?B?b2s2MGt0L3IwSFAycEwrQ1pleXM0QTg0MnpLL3g5Q09vbzU0RDRod2tJVTFM?=
 =?utf-8?B?UXNYUXlPUVk2aVdpMXFFYSt5M2RlUmo3alBWaEtmb1Zncy9iWHViYmVFTXRO?=
 =?utf-8?B?Q05Iald0UjdGeS9PUE9hQk8vZHhzOWlEZi9Ibzd6SGxQOUIzd0FHUWxzVkZB?=
 =?utf-8?B?MkhrVWJndWdHMlVBNS95dG1uQ09PbktFbW51VWFaRVNLMVZSWkV1M2sxeUhC?=
 =?utf-8?B?dk4vdld5bFoxb2gvRkpoRDVSemhGRnVvKzdCZUhnVzN5c0F1WmFYNjBUMzBB?=
 =?utf-8?B?MXUwNFBvbVRnd056NEJoWUNqbklJb1hVVE1iT1ZDVWVpcjd6eklMcHI3NFhS?=
 =?utf-8?B?YzJ5Y0oyVXJ6NGE2RnlZeGJIUVNjWTFqZFZIMkN1Z05WZjQ5NHU3Q3Y0ZGs0?=
 =?utf-8?B?QjluVEhSTi90akMxNUpJeW5QNHFYYmtaaVhjV1U5dERIaTlnbE0wU0IwdGpu?=
 =?utf-8?B?V0ZucngxblhWRlRrd2tQSkd5L3dNYSszNnVPVW9uU09GaGNhenU3TlQzbmNC?=
 =?utf-8?B?Wkc2SFRHbVZJNmpPa2hyYlJ3ZlJ5OElRVStxc1p4ZzlPQ2UwcGlhOWVJbHNh?=
 =?utf-8?B?Y3VxalYwUHA3ckFUTjhMRFI4RG1GZTNJUDBZY2lIMkRyU0tCY3F0MGxPRUZH?=
 =?utf-8?B?eHRUcGdDaWpMQ0RaS2pNUXIxRGxXeXFwa2xkMlptWnF3bzdXQjBCQ3BMWkFl?=
 =?utf-8?B?R29BQlFpbHhUM2FIK0xEZWhkRWtXTEZ2QWFSZzBMVkdRQXlpOFR4YXM4NURq?=
 =?utf-8?B?UHdYVFRVeHNmVXd2NGNJQkl1OXBNWDN2VGhmUUhmbnNqVmVCKzJPWjVHZjRn?=
 =?utf-8?B?aW9aOFVpeVIwVFNZTnc2OGVONGZLYzU2ZGZnT0ZWdXQxUC9QL0R4QWRoWndB?=
 =?utf-8?Q?uPt/LCMiNxpVS?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SksreWlINTJuVkp4dXRxem12WHg2WTZZMHlBRHpuZjliZzVQZnJ3ZW5ZaEVl?=
 =?utf-8?B?SnkwcFhOKytma1cvZnU4Ylk3OUg0QW14amhJeUlPL3hncTU1RTF4OVlINGRh?=
 =?utf-8?B?L01XcVdwb1djaElJWTh3N3hDaTl5NHUyMnR4WlNHY2JOWTFXZmZNQU1vQTNa?=
 =?utf-8?B?N0J5YTZEMnArVjUyVW1wQU54SWdxLzhXTmlkWE9lQlNaZGJpQ1dKTy8zME0z?=
 =?utf-8?B?TXJEdlE4cVhhQWtWb3NHYXJSYktDMnFRVTdFWUdMNGJkT3ZxTWJ6WDJ0ZjBn?=
 =?utf-8?B?L0MxQjl2K0xtbXI4Z0hDM04yWkFJR3hrMXdHdGJiVWQxUFF5N3c0d1JjU0Ri?=
 =?utf-8?B?OUZ2Zy9UUUI5Ui8wSXBaUEJsc21ENUtFd0pndjRhdklSNC85bXBUcTEzVUs4?=
 =?utf-8?B?WFB6TmhvRWgxaHFzWlorTUJEWmlmR083SFlGUmJGZG1jQUF6bVVnOTV3ZU80?=
 =?utf-8?B?RWJPS29QVXk1d0pPS0daTVRtcFZIbGdDcXNHdG9TbVRRZklUZ2JERy81YnU3?=
 =?utf-8?B?MkFOeUhNK1hhU1lva3prcSsxMkxyTHpGTGFodVpveVlJYW4rV2FoUHVwYSs0?=
 =?utf-8?B?S1RGMkZ2a3Y3enVtcXAxM0ZFZ2k1WFc5Z1ZYcmljNmlkWnZucFIxRGRZTit5?=
 =?utf-8?B?VmRIL3J0c29pT0tDdEVzcXB0c3JzbGZxMllvUkNWVVhsL1F0QjZwQ2xzdjNt?=
 =?utf-8?B?bWUxZnpRR0xwNmtZQTd4RDc3VW1HT2V1dUpWbGloUTZYaHB1L0QrdTR3THpo?=
 =?utf-8?B?TGs0c2EzeWhWNXc1L3Q2bU5xYWpQMkNDNVQ3dWI0SERVNjRpUkVuRzJRckhF?=
 =?utf-8?B?Slp5OXNKTFNvSDErYm1RWVhCaUhKZVVMVExXSUVndVRWclVNb0lKV1hSQWVv?=
 =?utf-8?B?M2VXSElPa2hJY3JrYWRHR014WlAzcnZhdXl6bEg1Njl0MmVOblNZVEpyYXA1?=
 =?utf-8?B?Z0tubnlnM3VJZnNrZkhDQXYzT1k3RDh5c0dhVm51TFRMYXpRR0g5eTRuMjln?=
 =?utf-8?B?cEVDa3UwZ294WWxFakVGL2hneE01YXNkc05VUnJndVoxLzIzTGtoRHplMnU5?=
 =?utf-8?B?ZW5iMStBbDVmQ2tDOUp3WHpWdVdBM2kwaUFEbHVyVnQvL3JVRXRhSU1tZkNY?=
 =?utf-8?B?MXY5OUphQmlKSitSbHJtT3Zqc0xWenNxK2IvMnpXS1dYK3NzTEwvWTF6QTI5?=
 =?utf-8?B?WG8zY21IWGhaQnZ6OUlVVGFvTGZUODQ4NGJSZ1lnNGlsZzFvdE1hU251MGth?=
 =?utf-8?B?cmhZUDBzSTJHSHhCRFFMZWVoZGR0SkhoYlVJTzJzV3pCT1pxOXI4WkFxZ3U2?=
 =?utf-8?B?Z24rODhjOE5KR2VBWnZORUVvdUNkTDJTNDVCRjRJRmdJRTlvajFiaURZemxz?=
 =?utf-8?B?NkQwT2huSmF4U01tUWxJaTNnMWRGeGJOVGVYUFBsdWpsZEFXTC8yWURrZUVk?=
 =?utf-8?B?WXBxNE5IMkZ4MGRrQVlCSEN4UUFlSE1VamFEd3RFMUJEQTloM0NRbUJmZjV4?=
 =?utf-8?B?OTVqTFdaWU9hSFNUeG1aS2FaNS85WHNoMWhMZTNKeDNTY2Z4YTlzZy8wQjU3?=
 =?utf-8?B?dk1peVJuNDBqaXorL1VKODl5MnZGQlZQRk1vZkdjam42bVprL2RBcTcxK3Jk?=
 =?utf-8?B?YzVmVm42aWdIMTg3WGtseUoyZ1dWUVJVaS8zQXc3aEtWaE43MFNqL3gxcHQ1?=
 =?utf-8?Q?nlRNpGUOLc9tf7XuWOTK?=
X-OriginatorOrg: sct-15-20-8534-9-msonline-outlook-d08a8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be0bd22-8df8-4063-7a3a-08de16d908af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB10270.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:50:54.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB9732

On 10/29/2025 6:16 AM, Bjorn Helgaas wrote:
> On Tue, Oct 28, 2025 at 02:19:13AM +0800, Linnaea Lavia wrote:
> 
>> On 6.18-rc3 with the change the link does not come up without pcie_aspm=off.
> 
> Thanks for testing this!
> 
> I think there are two problems:
> 
>    1) On v6.18-rc2, the meson-pcie probe failed with:
> 
>         meson-pcie fc000000.pcie: error -EBUSY: can't request region for resource [mem 0xfc000000-0xfc3fffff]
> 
>       so we didn't even try to bring up the link.  I think this was
>       fixed in v6.18-rc3 by a1978b692a39 ("PCI: dwc: Use custom pci_ops
>       for root bus DBI vs ECAM config access").

On vanilla 6.18-rc3 probing still fails with the same error.
I'm booting with additional patches from
https://lore.kernel.org/linux-pci/DM4PR05MB102709E0A9C0CF0D62AEC3524C7F1A@DM4PR05MB10270.namprd05.prod.outlook.com/

>    2) On v6.18-rc3, we brought up the link and enumerated 01:00.0, but
>       as soon as we tried to enable ASPM L1, the link stopped working:
> 
>> [    5.396341] [     T50] meson-pcie fc000000.pcie: host bridge /soc/pcie@fc000000 ranges:
>> [    5.474722] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.480590] [     T50] meson-pcie fc000000.pcie: PCIe Gen.2 x1 link up
>> [    5.484394] [     T50] meson-pcie fc000000.pcie: PCI host bridge to bus 0000:00
>> [    5.511625] [     T50] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 PCIe Root Port
>> [    5.578507] [     T50] pci 0000:01:00.0: [8086:2725] type 00 class 0x028000 PCIe Endpoint
>> [    5.587460] [     T50] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
>> [    5.656009] [     T50] pci 0000:01:00.0: ASPM: default states L1
>> [    5.701063] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.724147] [     T50] pci 0000:01:00.0: BAR 0 [mem 0xfc700000-0xfc703fff 64bit]: assigned
>> [    5.779528] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.822074] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.864902] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.907448] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
>> [    5.987517] [     T50] pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)
>> [    6.081421] [     T50] pci 0000:01:00.0: BAR 0: error updating (high 0x00000000 != 0xffffffff)
> 
> Can you try the patch below on top of v6.18-rc3?  It should prevent
> enabling ASPM L1.  Can you also collect the output of "sudo lspci -vv"
> on some working kernel?
> 
> I'm a little concerned that [16c3:abcd] is too general because it
> looks like that ID has really been abused by vendors:
> https://patchwork.kernel.org/patch/10798497/
> 
> I wonder if there's a way for meson-pcie to write a corrected
> Vendor/Device ID in the Root Port so we could make a quirk that's
> specific to the Meson controller.
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..9cd12924b5cb 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>    * disable both L0s and L1 for now to be safe.
>    */
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
>   
>   /*
>    * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain

I have applied the patch on 6.18-rc3 but it's still trying to enable ASPM for some reasons.

# dmesg | grep -i -e pci -e iwlwifi -e aspm
[    0.128511] [      T1] PCI: CLS 0 bytes, default 64
[    5.317257] [     T46] dw-pcie fc000000.pcie: error -ENXIO: IRQ index 1 not found
[    5.326946] [     T46] meson-pcie fc000000.pcie: host bridge /soc/pcie@fc000000 ranges:
[    5.342763] [     T46] meson-pcie fc000000.pcie:       IO 0x00fc600000..0x00fc6fffff -> 0x0000000000
[    5.349971] [     T46] meson-pcie fc000000.pcie:      MEM 0x00fc700000..0x00fdffffff -> 0x00fc700000
[    5.365746] [     T46] meson-pcie fc000000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 4G
[    5.412380] [     T46] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.428546] [     T46] meson-pcie fc000000.pcie: PCIe Gen.2 x1 link up
[    5.437432] [     T46] meson-pcie fc000000.pcie: PCI host bridge to bus 0000:00
[    5.443332] [     T46] pci_bus 0000:00: root bus resource [bus 00-ff]
[    5.449420] [     T46] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
[    5.458553] [     T46] pci_bus 0000:00: root bus resource [mem 0xfc700000-0xfdffffff]
[    5.467944] [     T46] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 PCIe Root Port
[    5.471907] [     T46] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    5.478740] [     T46] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.484611] [     T46] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    5.484626] [     T46] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    5.506118] [     T46] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
[    5.506238] [     T46] pci 0000:00:00.0: supports D1
[    5.518667] [     T46] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    5.545255] [     T46] pci 0000:01:00.0: [8086:2725] type 00 class 0x028000 PCIe Endpoint
[    5.552744] [     T46] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    5.569336] [     T46] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
[    5.585775] [     T46] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
[    5.600929] [     T46] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    5.614576] [     T46] pci 0000:01:00.0: ASPM: default states L1
[    5.660049] [     T46] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.660155] [     T46] pci 0000:00:00.0: bridge window [mem 0xfc700000-0xfc7fffff]: assigned
[    5.660168] [     T46] pci 0000:00:00.0: ROM [mem 0xfc800000-0xfc80ffff pref]: assigned
[    5.660180] [     T46] pci 0000:01:00.0: BAR 0 [mem 0xfc700000-0xfc703fff 64bit]: assigned
[    5.701644] [     T46] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.743113] [     T46] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.784552] [     T46] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.825987] [     T46] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.826012] [     T46] pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)
[    5.867488] [     T46] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.920348] [     T46] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.928302] [     T46] pci 0000:01:00.0: BAR 0: error updating (high 0x00000000 != 0xffffffff)
[    5.977964] [     T46] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.979072] [     T46] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.984964] [     T46] pci 0000:00:00.0:   bridge window [mem 0xfc700000-0xfc7fffff]
[    5.992437] [     T46] pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
[    5.998751] [     T46] pci_bus 0000:00: resource 5 [mem 0xfc700000-0xfdffffff]
[    6.005694] [     T46] pci_bus 0000:01: resource 1 [mem 0xfc700000-0xfc7fffff]
[    6.012641] [     T46] pci 0000:00:00.0: Disabling ASPM L0s/L1
[    6.018859] [     T46] pcieport 0000:00:00.0: PME: Signaling with IRQ 22
[    6.025864] [     T46] pcieport 0000:00:00.0: AER: enabled with IRQ 22
[   11.554656] [    T500] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.597429] [    T500] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.598989] [    T500] iwlwifi 0000:01:00.0: of_irq_parse_pci: failed with rc=134

lspci -vv also showed ASPM enabled.

# lspci -vv
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 22
         Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
         I/O behind bridge: [disabled] [16-bit]
         Memory behind bridge: fc700000-fc7fffff [size=1M] [32-bit]
         Prefetchable memory behind bridge: [disabled] [32-bit]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         Expansion ROM at fc800000 [virtual] [disabled] [size=64K]
         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                 Address: 0000000009f0f000  Data: 0000
         Capabilities: [70] Express (v2) Root Port (Slot-), IntMsgNum 0
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag- RBE+ TEE-IO-
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 256 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <2us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
                 LnkSta: Speed 5GT/s, Width x1
                         TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                 RootCap: CRSVisible+
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP+ LTR-
                          10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                          FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                          AtomicOpsCtl: ReqEn- EgressBlck-
                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                 LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
                          EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported
         Capabilities: [100 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
                         ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr+ HeaderOF+
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
                 RootCmd: CERptEn+ NFERptEn+ FERptEn+
                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                          FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
         Capabilities: [148 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+
                           PortCommonModeRestoreTime=55us PortTPowerOnTime=12us
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                            T_CommonMode=55us
                 L1SubCtl2: T_PwrOn=18us
         Kernel driver in use: pcieport
         Kernel modules: shpchp

01:00.0 Network controller: Intel Corporation Wi-Fi 6E(802.11ax) AX210/AX1675* 2x2 [Typhoon Peak] (rev 1a)
         Subsystem: Intel Corporation Wi-Fi 6 AX210 160MHz
         !!! Unknown header type 7f
         Region 0: Memory at fc700000 (64-bit, non-prefetchable) [size=16K]
         Kernel modules: iwlwifi

On 6.17.4 ASPM is disabled and runs fine. Same with booting with pcie_aspm=off on 6.18-rc3.

# dmesg | grep -i -e pci -e iwlwifi -e aspm
[    0.130646] [      T1] PCI: CLS 0 bytes, default 64
[    5.293543] [     T50] dw-pcie fc000000.pcie: error -ENXIO: IRQ index 1 not found
[    5.311673] [     T50] meson-pcie fc000000.pcie: host bridge /soc/pcie@fc000000 ranges:
[    5.327280] [     T50] meson-pcie fc000000.pcie:       IO 0x00fc600000..0x00fc6fffff -> 0x0000000000
[    5.334502] [     T50] meson-pcie fc000000.pcie:      MEM 0x00fc700000..0x00fdffffff -> 0x00fc700000
[    5.348164] [     T50] meson-pcie fc000000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 4G
[    5.394829] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.402776] [     T50] meson-pcie fc000000.pcie: PCIe Gen.2 x1 link up
[    5.407944] [     T50] meson-pcie fc000000.pcie: PCI host bridge to bus 0000:00
[    5.413924] [     T50] pci_bus 0000:00: root bus resource [bus 00-ff]
[    5.417269] [     T50] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
[    5.432718] [     T50] pci_bus 0000:00: root bus resource [mem 0xfc700000-0xfdffffff]
[    5.452231] [     T50] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 PCIe Root Port
[    5.455854] [     T50] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    5.455869] [     T50] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.455878] [     T50] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    5.455885] [     T50] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    5.455892] [     T50] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
[    5.456855] [     T50] pci 0000:00:00.0: supports D1
[    5.467372] [     T50] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    5.494508] [     T50] pci 0000:01:00.0: [8086:2725] type 00 class 0x028000 PCIe Endpoint
[    5.499799] [     T50] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    5.522939] [     T50] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
[    5.554392] [     T50] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
[    5.568852] [     T50] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    5.593133] [     T50] pci 0000:00:00.0: bridge window [mem 0xfc700000-0xfc7fffff]: assigned
[    5.606402] [     T50] pci 0000:00:00.0: ROM [mem 0xfc800000-0xfc80ffff pref]: assigned
[    5.620315] [     T50] pci 0000:01:00.0: BAR 0 [mem 0xfc700000-0xfc703fff 64bit]: assigned
[    5.633022] [     T50] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.644676] [     T50] pci 0000:00:00.0:   bridge window [mem 0xfc700000-0xfc7fffff]
[    5.656118] [     T50] pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
[    5.669110] [     T50] pci_bus 0000:00: resource 5 [mem 0xfc700000-0xfdffffff]
[    5.669122] [     T50] pci_bus 0000:01: resource 1 [mem 0xfc700000-0xfc7fffff]
[    5.683041] [     T50] pcieport 0000:00:00.0: PME: Signaling with IRQ 25
[    5.697591] [     T50] pcieport 0000:00:00.0: AER: enabled with IRQ 25
[   11.028699] [    T506] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
[   11.117043] [    T506] iwlwifi 0000:01:00.0: Detected crf-id 0x400410, cnv-id 0x400410 wfpm id 0x80000000
[   11.120720] [    T506] iwlwifi 0000:01:00.0: PCI dev 2725/0024, rev=0x420, rfid=0x10d000
[   11.134491] [    T506] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6E AX210 160MHz
[   11.224884] [     T75] iwlwifi 0000:01:00.0: loaded firmware version 89.af655058.0 ty-a0-gf-a0-89.ucode op_mode iwlmvm

# lspci -vv
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 25
         Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
         I/O behind bridge: [disabled] [16-bit]
         Memory behind bridge: fc700000-fc7fffff [size=1M] [32-bit]
         Prefetchable memory behind bridge: [disabled] [32-bit]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         Expansion ROM at fc800000 [virtual] [disabled] [size=64K]
         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                 Address: 0000000003c9c000  Data: 0000
         Capabilities: [70] Express (v2) Root Port (Slot-), IntMsgNum 0
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag- RBE+ TEE-IO-
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 256 bytes
                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <2us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
                 LnkSta: Speed 5GT/s, Width x1
                         TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                 RootCap: CRSVisible+
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP+ LTR-
                          10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                          FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                          AtomicOpsCtl: ReqEn- EgressBlck-
                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                 LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
                 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- EqualizationPhase1-
                          EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported
         Capabilities: [100 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
                         ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                 CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr+ HeaderOF+
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
                 RootCmd: CERptEn+ NFERptEn+ FERptEn+
                 RootSta: CERcvd+ MultCERcvd+ UERcvd- MultUERcvd-
                          FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
         Capabilities: [148 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+
                           PortCommonModeRestoreTime=55us PortTPowerOnTime=12us
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                            T_CommonMode=55us
                 L1SubCtl2: T_PwrOn=18us
         Kernel driver in use: pcieport

01:00.0 Network controller: Intel Corporation Wi-Fi 6E(802.11ax) AX210/AX1675* 2x2 [Typhoon Peak] (rev 1a)
         Subsystem: Intel Corporation Wi-Fi 6 AX210 160MHz
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 24
         Region 0: Memory at fc700000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [c8] Power Management version 3
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [40] Express (v2) Endpoint, IntMsgNum 0
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W TEE-IO-
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
                 LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L1, Exit Latency L1 <8us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 5GT/s, Width x1
                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
                          10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                          FRS- TPHComp- ExtTPHComp-
                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-
                          AtomicOpsCtl: ReqEn-
                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                 LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
                          EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported
         Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
                 Vector table: BAR=0 offset=00002000
                 PBA: BAR=0 offset=00003000
         Capabilities: [100 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
                         ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr- HeaderOF-
                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [14c v1] Latency Tolerance Reporting
                 Max snoop latency: 0ns
                 Max no snoop latency: 0ns
         Capabilities: [154 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                           PortCommonModeRestoreTime=30us PortTPowerOnTime=18us
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                            T_CommonMode=0us LTR1.2_Threshold=79872ns
                 L1SubCtl2: T_PwrOn=18us
         Kernel driver in use: iwlwifi
         Kernel modules: iwlwifi


