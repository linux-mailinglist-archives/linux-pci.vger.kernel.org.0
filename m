Return-Path: <linux-pci+bounces-12515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A2A9663C0
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 16:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0210EB232C8
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7421715C138;
	Fri, 30 Aug 2024 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g5GrpKDL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF71ACDE8;
	Fri, 30 Aug 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026915; cv=fail; b=ucZLm/uFva56rB8QCuLXDWrRDFDcxE/BhdTIQJsnDPg7jFSKZTek7BBZRgbrN6lsjV1le02ynahaWJqtiRXTJsXAlZVfEUQK7Ybew9rQufQM9A9HXNs2txImL9EbPo/nWeKtaHd0WYUozpjNMIiK6ODKf8FIBeWN9aPRZDGvyQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026915; c=relaxed/simple;
	bh=+ZmmkaTLrinufflvef2kQhFRwEJ6Svem9D6yfrCS8ss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bo3DiybAty23ylHYg1AF4VFFp4YRmCoeDrNPxzuclCQDJVZKoias4YwaE2gAhqVy3rAUK1PKchOg3PZC6gbfK1RT/RnIvLTQn7Agj1QbFLAmerzZMIOC0v9eFdrF03e91qiTl0IplqQ+RkoWBzop9tPdNw9EiYwiK4NMUQn3gMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g5GrpKDL; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsZQ8xyClQ2Hy3Cx+zop23tZ114QxlDWXK61v4lKG5a3NRGmd+9CYoVifGk2w0MB7Ss5OECtU0/NRzZd4LchlvybASGjMAIwDWKrRu4r/LM4hSHt2oZpu2DM96QUcfWcWbMUmPo+IB+VlfrRnj5golQJaEcb7RlH2677dIWvQuo0CAtMb9SckD9V3piuOmTy2Z0zbIAbWyXWyU5pqcEu8URuoI/uXVbXLKpaZ2pslmsSI5zikIWQiYUWxQI2qza7oZpH6qxU81OBMTFQxx0bX7Wu3+NZZeV+wNKo8zUrWCvqhaOSv1bJsUOk9Za0MvlH/bJ7OANpIvJhf7MDSpXLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hrKNouROWveGpcuc0NRklrzMWc0MEQa+9A/uasluRA=;
 b=s3AkjXxKXZdCX5o0mgv/40Abo+R+Zkt8pQNbBOa8fqgu6kgSQi/FXUzobgYxFSDKCe5a6JhOi0frbGyGySLKUUWbvS7Im3s+PNAXlmNEwjuRMSLEbAElsRiNg2HYzh0ioKfy+73AOtyO2Thv7+UJBUcsLG0JfhU/KApnNUJWtcZs78Faeouz9Awk4nPlkA7c3myqsV1rkyx57Cm5oRcMBP09WEwuh6O9vSK9bet6X99jccj7V+PosGw8N4FnJUfGFXad1ylF37BfRgJmVT4LJUpNosaUyvUCW6sZ3BC1l/mJQ4l+C5sx2Fj5WAvxn6Rv8c7CRzxshgZteaU8rSW/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hrKNouROWveGpcuc0NRklrzMWc0MEQa+9A/uasluRA=;
 b=g5GrpKDL8488srS3VIVoGqT0si96Oo5jXvTJgemKlaaQ73JLqiokj1OTXQg/YfgljFiKBUc2+NgUIJHiOng4oHOeDDFg3GBDI5l89mHThk+aOkCTDrLlm9YgRUTj8dcbbrh22gBgdxzyr+9D0DMrxlDTesdvR4ONchqF754vV5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 14:08:28 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 14:08:27 +0000
Message-ID: <150898c0-c3b6-41d2-9ce1-dda6607c1648@amd.com>
Date: Fri, 30 Aug 2024 16:08:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] PCI: xilinx-nwl: Add phy support
To: Bjorn Helgaas <helgaas@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 linux-arm-kernel@lists.infradead.org, Markus Elfring
 <Markus.Elfring@web.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Bharat Kumar Gogada <bharatku@xilinx.com>, Conor Dooley
 <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org
References: <20240809195455.GA209828@bhelgaas>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240809195455.GA209828@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0057.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::46) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b17a0a5-d37f-4c9a-31aa-08dcc8fd3842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aStXZGVud1JBWmtaVldoaXQyeGd3UEZJSUt1M1VlU0JaZmdLekptZEtJWEg0?=
 =?utf-8?B?ZkdsR1JvRlFobGRRUVNkdmFqeEVMQTZKS0hWcTlJb0gvbG1LdlpxOUZkNmtQ?=
 =?utf-8?B?WmpaS1J2TWlBSXFpZkFhSmxrVm1aMEY2bElCeEcxQUtEZnNEdHhsaGZsTUxQ?=
 =?utf-8?B?QnJtQmdNS1d3b2NtRUM3bWFSZGJsdW5YWEdWV25ldVE4bktNc2VoMGM3SHZ2?=
 =?utf-8?B?WTdXZHU3WHNLMjJzdjN6R1IwaFlpTVVwdTRwT0RlVzJrWk1kQ2lXV3VKNjlu?=
 =?utf-8?B?d3Fsc3BsaXU0ZFptNkUyYXZOTU90QUcxOGQwYUZJWmFnUklRdUJHUTVTRlp1?=
 =?utf-8?B?dG94cGJZejZtb1Z2bFI0WWhjOWFneUF5WmtaR0oyVHhoaGxmTlcwMEkrb0Rn?=
 =?utf-8?B?Y3NndHoyRWw1bHYyWVVsdGI5TkdoQmlUb3YvQlU5ek5US1AxeDFtZm9mQytP?=
 =?utf-8?B?di9ZQVJ1MVQ2S3o2MlkrQW40NHpSbUNpaWhtOG1NSjJTTVA3UDBBL0pjNm1j?=
 =?utf-8?B?U0ZLem5HTmZ5RU1KbDRnSGV5NE8vd3d6bXZEYXV3bXNsOFpMV1ZjNHVKVGdl?=
 =?utf-8?B?UlNzTk1KdlN2UC9Pc3BOR3B1cGNtK1hsOU0zbEdveVY0dG0xb0JVVU9YeFRY?=
 =?utf-8?B?ZEZaL2x4SHBiZmFsUlVUb1IvcjVKbDd6Um82Rkc1Tmo3Z1RrTElqdmN3a0I1?=
 =?utf-8?B?aUVEQnUycjFjWmVvN0taQzBWUFVncWJ4NGpSQnB4QTJWR25lQ0FJWjJ1YVFw?=
 =?utf-8?B?bDRoMmhYdTRkeXF0cmNYWVNnSGhLRTRuUW1yby9TNUkrK2pPbG1ucUFmOEVy?=
 =?utf-8?B?WVV3cSt3K3UxWklwWEJsWnpvRlE1dVovVlRPcHQyeHo1OGdCaHR4Q1B4MFNZ?=
 =?utf-8?B?cDNYNW1nTDR3c1AyMDR2RVphRVR2WERGY21Oc3lKbjcwNGpHTnVjQlc5dGQ4?=
 =?utf-8?B?dUh3RndXV1JPUDA3ekUzM011Ykl6TTF3TVg2WG44YkRDaExydjRqQ2N1Z0lC?=
 =?utf-8?B?V2VEMU9IU3I5VUdBVDY0bUlEVytCVlRCdFVvM2ovM293Y0V5ajE1SkxxTW5M?=
 =?utf-8?B?Y3FTcUpNVEd3dFJBRUV2T3dLbDZsdjlPQkd4VUlCMGU0TEpzYzE1S3plQm1B?=
 =?utf-8?B?NjB6Z0RGR09lK3B6bVpGUXQxNWJFUXBhRHpnN2NrRGMyb1VVOE1FS2RHYTNu?=
 =?utf-8?B?cGZ5TG5UVXhUT1VOay9hZkd1TytDTE5GR051b25WWTJwaXFQb3Z0Y09mVXI3?=
 =?utf-8?B?K3pZcnI4WGIwR0hiME9lK1ExMkQzOTlLSVhRSjdnY0EvTjNVUWMxZkdTRlc5?=
 =?utf-8?B?TUcxQjI5U3BhWjNsUnp0TzJuaS9GM3hXTC9VOFMzTDh4RXNSNlc3UFhCbGdj?=
 =?utf-8?B?NGM0ZjF4VGNOWTFCNFc5WG0vaWxPZ1g0TU5BOEl3NzJjOGZ4VlREN2RWYWxu?=
 =?utf-8?B?d0pxcm93OUphYUdGNnhXTWEvZkRnOFNyamlWTlFpaHpVK2lIMklKWWlHcTEv?=
 =?utf-8?B?V1FRQmxhODMraGE1QzAwaENOYU5rdWVMSGs4amxzaW5KMW9MNFNZTlhrQ3Zk?=
 =?utf-8?B?OVBQMVVQNytTRmRhdWUyVktGV1BPVTJBcU1qTjFXa1lQNktuK3ZnQkFEOWdE?=
 =?utf-8?B?RXdaTWR0eVp5d2FmdXNsUDkxOWgyZ0NUWmdNRlFxYnFwVDVDZDRFYVAxMTZw?=
 =?utf-8?B?UWQ3QlBXSHZPU0FYMUIyN0lxZW5qT1BSclE0VVF6QWtsRk10NjNrNEgxaGlU?=
 =?utf-8?B?UitFT05haThjMEt2d1hHMHJnSkFPaW9sRVBPWURSQ1NzMjk2OEg5dldKdk1Z?=
 =?utf-8?B?YUZNTnJQNithaTZNbGl0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0VhSHdydlU5bEptc0ZEdjJZQkFqemVoUG8yYzFmNjJCeThhak5weTNtOVJ6?=
 =?utf-8?B?MnJETW0rMUdMT1U2QmFrM3F4TjA5TnJzYVZUcnRZUDFRdEdFdjNEeHVocUJs?=
 =?utf-8?B?amM3c00vT2pJam5MT2dMV0plYitxbWFWRmk0RTVVWTY0SXFGTm5ucHFCbmky?=
 =?utf-8?B?dFlzQ1A3U2lPckUvNXBJNHRMNU9HLzhoeTFEaUJuUkFBdEJJYThPWjhBdk1V?=
 =?utf-8?B?MXQ3bktDTG01QWpseWtZL2E0a05CU1VaL3U4Y3IrVDRrNEwwbWpBTjdYNmI3?=
 =?utf-8?B?RlpVVXpkSHVpTW45d1hmMnFxSm5nb0d4SmpiWTNjTC9FdnVOeGt5QWd1ZndB?=
 =?utf-8?B?YytnOW1udEkvb0hwZnZiTTJDTEx6dGZhVjQxY29vcVJZc0tNL3g3UytRN3p0?=
 =?utf-8?B?bS9mdmpkUE0rNERjMXFIN2tnWE1NKzVmeTZkU3Bnaktqdlhodk9wV3JEWTlB?=
 =?utf-8?B?L3BFOUxXNGtLaXZDY3ZmdWY2RlZSWHk0R3lBUTNiYkJDcHMyWGxnMWNNODlm?=
 =?utf-8?B?QnRhU29QeGFwbnRnQS96QU8vSGorTDNnWG9RSUdhek9HdDJVNlZ2VllzUlhU?=
 =?utf-8?B?ZFhJRXlEakRQcFVGbXR1OUhBL3NBZ1JsQU8zYjFwZDNURXJ2aGQ2UkpPTTlq?=
 =?utf-8?B?MUNhWE1wR3JuNHNHTWNuMlcwVFNGOHdNTU94dURzeEoySng2OUlHd3g0Rm91?=
 =?utf-8?B?ZFVkTVpMT28va0hXNnVlamI4TnFJZ2N2M3VDWVhmTkNVR1ZpN1lSSWF1R01N?=
 =?utf-8?B?SlNsMVJwWnY3WERGZDdPS3QxREtOYnl4RXBteTBtL0pmekpacjZoQXdZaWJo?=
 =?utf-8?B?ME9UK1MvZ0YwNUVyVmY3TDR4RzE5TFRzaEUwTDhNMjRqVkxpZVErWXhFVHVM?=
 =?utf-8?B?NFpLek4yQXdybVYxbVhnY0M2cmVreDV0Ti9rT2tvS1RZbS8vOEdHblFDVTh3?=
 =?utf-8?B?dnVaRnFRVUhGKzhYZnV5ZDZHNDNGc1pIUTFrU3QzSXdjT2ZJQ05aK0Jhb2d1?=
 =?utf-8?B?Y3N6Q3pzUXFhU2VPUmtCRWw3OWdjeVNZTkVHcGplb1RZZ2hYNEFybmRPalZp?=
 =?utf-8?B?Vndia3RHelpMQnM5YlpwRUJROHZQaHh6VHR3V0xDSkZGZmtUZnpQNVF6WkN6?=
 =?utf-8?B?M3ZTblJlM08vTDI4TlcvTXlybzNzclpOTzBaTjd1TnBGdXJXZFJCMlovOCtq?=
 =?utf-8?B?N2xBOFRzK0VKMXBvTjlkaDFzcDVaVmlxdzlaK3Q4alpSRVVTQjc3QjVJOU9m?=
 =?utf-8?B?YUtkWXIyVTI4L2prZ3hMeVF6U1MrSU9SZGNMdWYvWmxBNVFuZC9ya2ZxL0h1?=
 =?utf-8?B?REVOZW4wSDVab002SXdxYXlEV3oyck0wUTBUbVYyY2V5VVZwQVdFemZiQUhK?=
 =?utf-8?B?SldvVEd4eU9BcTBYZ21xczVIUG4yYUpnUlVhWnpkd0NyZmpLN2hhSmloOTZM?=
 =?utf-8?B?V3REU3o1RzczSlQ4cDkxcy9tYXZCNkZaSlNLM3hSWkFZZFBZVVJmaXFzcnFt?=
 =?utf-8?B?RktjcnMyYjIvSEc0Z2F6T1gzZjJLT2diSUcwWXRac2d5SkFZV1VkbUk1cXNa?=
 =?utf-8?B?c1ZHaE5lT3B3OXNyRTVHK0Vtc0RDYjViQXc4b2hOd2hydHpVWTNjb0QxaW9q?=
 =?utf-8?B?V254V3ZwaXJ2cG13V3hObE5oRXc1OHY0OXM4RzYrQkxUR3JyUTM5RWdTMEJu?=
 =?utf-8?B?WDNZSEU0VHNHaFczVjZVMkE5NmR2QmI4M2syMEtmdExobUdZQkswbjZNdlRx?=
 =?utf-8?B?SHFrTy9kMkhjVFFPbGdOT0Q1RjhoV1JQaDhOYU9FNjFqdWlvRTZqdnNQaEFI?=
 =?utf-8?B?b0JtZGdPMWthaXlOdGZhbTY0SGFCaGk2ODcxbHcyTlVUcFo2c1BISTBJVjdW?=
 =?utf-8?B?bkpUS3JoMjByTUFoRG9rdkFKOCtkZFVadE5LbjVWeVljdXpjVnNjSndkbkdh?=
 =?utf-8?B?QmZmWVlVWlljcVBZcTdRd0taaXRmdFBzRWY1cGZRTTRBcXA2a3BpM1dGYlFX?=
 =?utf-8?B?bytSNjc3c2pUckdDY0FiQWtmb2NIc29WVXNkRDROL3A0R2ZxTi92aGdZNEJo?=
 =?utf-8?B?R1lqeTdLOVFZWnFicjN6RDRLOGgrcXdyZ0VVd0JTYUNGcUdqMmZLTmwzYTFE?=
 =?utf-8?Q?2uuiMzRQwLmYG17IBx9FSU5xc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b17a0a5-d37f-4c9a-31aa-08dcc8fd3842
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 14:08:27.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dbjWTSil4eDVXXoj8+2x0DFd9QAnlUFVBz9oMX/ERTx+TrTIEAugHAoQgzNoz4R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940

Hi Bjorn,

On 8/9/24 21:54, Bjorn Helgaas wrote:
> On Fri, May 31, 2024 at 12:13:30PM -0400, Sean Anderson wrote:
>> Add phy subsystem support for the xilinx-nwl PCIe controller. This
>> series also includes several small fixes and improvements.
>>
>> Changes in v4:
>> - Clarify dt-bindings commit subject/message
>> - Explain likely effects of the off-by-one error
>> - Trim down UBSAN backtrace
>> - Move if to after pci_host_probe
>> - Remove if in err_phy
>> - Fix error path in phy_enable skipping the first phy
>> - Disable phys in reverse order
>> - Use dev_err instead of WARN for errors
>>
>> Changes in v3:
>> - Document phys property
>> - Expand off-by-one commit message
>>
>> Changes in v2:
>> - Remove phy-names
>> - Add an example
>> - Get phys by index and not by name
>>
>> Sean Anderson (7):
>>    dt-bindings: pci: xilinx-nwl: Add phys property
>>    PCI: xilinx-nwl: Fix off-by-one in IRQ handler
>>    PCI: xilinx-nwl: Fix register misspelling
>>    PCI: xilinx-nwl: Rate-limit misc interrupt messages
>>    PCI: xilinx-nwl: Clean up clock on probe failure/removal
>>    PCI: xilinx-nwl: Add phy support
> 
> Applied the above to pci/controller/xilinx for v6.12, thanks!
> 
> I assume the DTS update below should go via some other tree, but let
> me know if I should pick it up.

Would be good if you can pick it up with the series together.
I have already acked that patch before.

Thanks,
Michal


