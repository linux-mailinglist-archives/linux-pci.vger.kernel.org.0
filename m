Return-Path: <linux-pci+bounces-24325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50422A6B8FC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 11:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E603A5B07
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1275D217719;
	Fri, 21 Mar 2025 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KN52eEkj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2069.outbound.protection.outlook.com [40.92.23.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2956B1EA7E3;
	Fri, 21 Mar 2025 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553802; cv=fail; b=uWgHtQHPsuImdvM4yAmtD+EoR1LpQ6ddz9wTvc/A/dBXhyUNxdVFZ64pIsoFtAyNnzzyzSlr97WRGih9tWkim2BlQfnbo/tDleE36bB+ne9ccBbhjWvnQcX9zTg0qwQCJl7vBjrb6VJPfP87gw5kNYJTeNfkBuBIgHhExvw8NRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553802; c=relaxed/simple;
	bh=DPxRnpHJBt0XXcbRajc5AMzx7of1jgl4cp6DMkddHS4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SpQ7kN9dTW+XeoX/F/iwvugq4xoeaJPN/WgA7TltEIX/9nXSnXEVsmnQu9vfG5FJl6riET/2cs7YGeNJGG7UT4NT6CKlNdNsQnV7eIGXg1k3QuTgCNaRxiD8BwQnEAzrRIepI7VfJRk4w6G8LHsDyQwDhTYwWPbHdqJq6jUO5GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KN52eEkj; arc=fail smtp.client-ip=40.92.23.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvKViWEimxjOSlFoMgJHE7Lb9/N0Z0Ny20ZgddXN20fqWge0IBtEg9snX2C4m/6NG3wo/V/EtX4P5FJkyMZeXs54or5CdCbF/JlX0qh4SARrjonN+bEa/8YEUSWjM63EI9CJI09Dfu+gSNrR9luDe/PdMo/SNz36MmaT/aWI8ZoCRGHHL7TAdN/k9NNxLpHRMAj1IIKGa+SDQZFa7b6Hh98e8HOQ4xm6T1bQgBJd93gbQEwzlW7Qh2cEShGga5XV5M+YUxLPSU2KrW1qBDOdH18+6FhAL+N1GWGag/hxeNW+o+pUEx2cicNv8+w57uEacfDNbVmbuT0Wttvc7ZvXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXWE34v/94HAzIh87jCWB44OUISv/X6wy/WcUS/EwBQ=;
 b=cCeFXJS2ZtQOxksoFv7zoRam85P8T/uMIGfKBabDjWT2orozVA4slCXBV6OTil7A9psAk0csw7PooIf+ac+LBfR/wYbj3TozJOfQJudVY1r3NVyrwICzNYrwC4s5m/MPIPvi6ZOw0FG6UVyqs63uPV/zLTyy9393ygBuvLxkaT3H5JPIUeBH30oQ4eaQitehHrMaQT/NlnoaOGo6lsug9qPcCvPsiyqxoZuHzfFTr0UHJpE5Z4UI78QIqPC5hV0oDmp2yhVZL6haubfa9yRqO82lXkpAjrBu5zXpsS2ewhxRJT8NeLWV9PlPTvPmlO6BeR3n7HXR/+nYygShl98zZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXWE34v/94HAzIh87jCWB44OUISv/X6wy/WcUS/EwBQ=;
 b=KN52eEkjQcjBMEvtiIgijJIFqgodtOLc1B7wUpilWrGn4GOedUlCPDPAGw7aDQpjzXw2WhGBHshf+ltdQaWLKei/bAW3K+yZqUVVxYWasnZRZwPQzxAclPyOPnDmWQ7Difm0xF2oYtVye1HIly1c0uDgapNLzI4JHwds02yCCbX8eU3J5A+JcpKn3U2qdI2yY5GX/dmuIvUsR54+9MNc5005XjDbNbSFbATJ97q/ZIyFFVCA6G80UxWvRRg+rTYfXro3CFv07zAIF97IIw/hZPYhn/Caj6LdEfG/TIkloYeU0N2828ryz7Bz8jlBIjU9OeLOfROmZn2FFnWrrLZKOA==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DS7PR19MB4613.namprd19.prod.outlook.com (2603:10b6:5:2c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 10:43:18 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 10:43:18 +0000
Message-ID:
 <DS7PR19MB8883D5940E9B1AD153C6415A9DDB2@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Fri, 21 Mar 2025 14:43:05 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] dt-bindings: phy: qcom: uniphy-pcie: Add ipq5018
 compatible
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Nitheesh Sekar <quic_nsekar@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 20250317100029.881286-2-quic_varada@quicinc.com,
 Varadarajan Narayanan <quic_varada@quicinc.com>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-arm-msm@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>
References: <20250321-ipq5018-pcie-v5-0-aae2caa1f418@outlook.com>
 <20250321-ipq5018-pcie-v5-1-aae2caa1f418@outlook.com>
 <174255332861.2810991.11878697286839237760.robh@kernel.org>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <174255332861.2810991.11878697286839237760.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: DX0P273CA0062.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:59::10) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <2eeae784-4b03-408b-a77e-1b5abb3ced0b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DS7PR19MB4613:EE_
X-MS-Office365-Filtering-Correlation-Id: 760103e8-ddbd-44df-1b3d-08dd68653086
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|8060799006|19110799003|5072599009|461199028|15080799006|7092599003|10035399004|4302099013|3412199025|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUZUdmwzQURwWUhXbnovUS9sZ3VUdHZ0YXgzZE1RaEcvNlI2OG9SdjlNS3J3?=
 =?utf-8?B?R3E2MWFVUXJkdGFXcExmM3ZMc0Nic3ptNWc3NWw0cldrc1hHSTUzWjlSb1o1?=
 =?utf-8?B?ZEdmZ2NzTTVxZVU5U25kUm84bVlWVFRhd2psMG5RaGV0SExscW5lNkh6Uk5Z?=
 =?utf-8?B?SndWYTdKWEl0TTFCMnhncXBNNjM2WFF5dEhZWWxmTjNXRWJ6dXB3bC9hUGp3?=
 =?utf-8?B?K0I5TERmWjZSVC9ZbHlmdmd2MHRueUpqRWEzbUFoZWgxRnlVRGVGRHFuK2tJ?=
 =?utf-8?B?aTFMNTd6WlBpNkNGMXAxOTFUNHhWZS83RE5CTmZBU3lLY2VXZFdZd1RuTE1l?=
 =?utf-8?B?aU5UOFQ4ZlRIMldnUFh5S1duZFFCeWg2N2d2ak9SUmhnUCtTYldBeHR6bkFN?=
 =?utf-8?B?bkJ1Yi95OVJwS3JBOGlmOFlIRnVzKzZKN3lNK2l2R0hTeUR2K3dqWGFkdmlU?=
 =?utf-8?B?T0JEWTRTMmExckx6Z0lWY0lEQ21tb2ZTNm1jcGl4V2NPL3hISUZoMm5LYnZm?=
 =?utf-8?B?dTB4eW8xaWpPeENFNWtLbUpISFRHVENHRDM1bVJmWVpIaGdHUVNtcnV3SFVT?=
 =?utf-8?B?V3VMSXNwSDMyRy9CRVkwb3ltMCs1cmw4L2M2WDVkeFNHQ0NCb3dLSXVQL1BM?=
 =?utf-8?B?MW40VXNFbWUrRVFxc3hlU1hEMWNyZnIvRWg0dXVDSHoxQ3RLSkpVYVVMZnRZ?=
 =?utf-8?B?T1k3OXlHSlhFNVRibGxsMXcxKy9lU0UwRmF0c0ZCNldKZ2Y2WW51M0RuVGNR?=
 =?utf-8?B?dk51NlkzQ292TlRmUjBwVzU4dldEMEtSUnBXNTAvNlFpdHpBUnc1ZzBlVUFD?=
 =?utf-8?B?dkRITkxBNFg0dUVROXE5eGFMYXVjeXF1NnFlUkNlcVdtMFZocXJUejJTZ05M?=
 =?utf-8?B?bXVBVXg5clBsVWFLeWI2Mm0yWEdjcWZKTTgzZzMyOVIvMjNld2pyejRZZDRt?=
 =?utf-8?B?V21ZRDIxaytpWjNUdGZLTEdlK0hPeUl5YTJVc3BoUElva0FaLzFabVo0c1ZL?=
 =?utf-8?B?VnozcnhjelpPRi9zUmEzUjRHK3JRNUxzeXU1aG94djlDaEJtWDlxVVpQamdy?=
 =?utf-8?B?UEc2UGxzSDJreW9zRTJKTHNKMXlwaDgvUjFSRnU1b2haekY5QTZ5Q1dsZU1D?=
 =?utf-8?B?UFBwYTZqbnE0eTJXNGQxR25nKzR2STZEb2VndVZBSS9TdlBib2VFUXFOQTRV?=
 =?utf-8?B?dkNnTGRjQkFGdWlFZkR6Mi81Mmx2MDhVOW00cEpaT3FTK0RBb0YyQ0lmcFhl?=
 =?utf-8?B?T1ViSWZ2NW82MzBCcFkzTWdqNlpaOW1zL1Q5a09CbDlMTy9nQ3VSZlpFblhK?=
 =?utf-8?B?VnhZRWRweVY3SW1wUUtyNDErLzd0akZ0YkN6MTBET2pBRUpGL0FmcStJNzhG?=
 =?utf-8?B?bHR5ci9SSzNRYlJWd0cyNHRXWlRsTWo1dXpaVngvTEE4akx6YjdMeFFqc0RH?=
 =?utf-8?B?aWlxZ1JOMVlXaWRFaGRMbm1Oa0JJUmtKSGdCS2xnS1RzUzRaOWtxUFJ0L01L?=
 =?utf-8?B?Z1FnejZvSXZiR21YcG56Q2hDeUt5SlFoQjQvVU9neWpqM0V2dVpjc05scWJi?=
 =?utf-8?B?K3d3YUFYaEZiSzNiZ0E1am90ZkFXWGlqWUQwZ0hsYzBacUtMZjdlbThyL3l0?=
 =?utf-8?B?NGVrb3F3OWJpTWIwL2JBeUZyVEZqcy83Z2RwWmdiZWVqRkVhbTlLbkFoK1Jo?=
 =?utf-8?Q?/WqiYLa72rfAPfgUuu0O?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0lnUkxCWUdQaG1vd3ZqUHM3RXZQQnEzNnlRQUlJL2ZzUDdaUVRZd0tTWmc3?=
 =?utf-8?B?Z3VUckZBVGpBcUxZeG1pVWFHM29aS3locDR6TU04NFh2OGhKZWY4djUrOXpT?=
 =?utf-8?B?V0prYjFJQVloOEpXRjBreVg5cEdoMWFvdUtTdkk2VkdIcFRFZUF0dmtqWXRS?=
 =?utf-8?B?Wm83Uzh4cVdBSmRlb0h5SnJqZklCOG5nM2FCQW1FbzRzTjNRVmtoN1VET0JE?=
 =?utf-8?B?OFJ4NjhhZjZmOGgrVHFuY09NR1E4TFllSi9WcHdsZ3JiY1VLYmo3a2hCR1dz?=
 =?utf-8?B?SXc4a3hqNUo1MnJTUGlrR2s3eHg0WTJHRlpXUVJIUXdXYy9VR0k4ZlUxSWI3?=
 =?utf-8?B?WjlDZTZFMThOOWZ4RW1uVUxrZDVYWDNiU2dmaG1ocGR2Rk1LdUdSMWNhbTBs?=
 =?utf-8?B?emxhQnQ4UVpMSk05NTRQRmMvSGpXMzRORFBjR2llOFovblZ4L3NHeVdXSVFJ?=
 =?utf-8?B?V2JxN3lsL1B6NFRKM2tQaVRrVTE4U040TDA0ZDNScVZXbi9VcFZPek9jRUVF?=
 =?utf-8?B?YVE0UUN0Zm1kVS9haWFrRitXeUxaM01DVzNYWG9RM0hJaWNjUXp0MnFjOWh3?=
 =?utf-8?B?UUtONjdUZUtKTU11YUdOUHRNVXBmNXg2Qm9sdkRGTmhxK1lPNHRsczIvZGF3?=
 =?utf-8?B?UlNZL0ZqS2E4NmNpbGI0eTdUQXJ0bGI3STJ3M0hYNXN3Y1NuRzRNd0loNVlU?=
 =?utf-8?B?TGowRmJYSXlyM3cybC9vRDQ3eERHZ0NsQVVPRDZ0RXllOWFJOTRaOVVtc1hF?=
 =?utf-8?B?RHQ5WHZZNExRVXplM1JvcGx5d2hpYUJhMEZyczFuRnNhempmVEo5dXJXNFcx?=
 =?utf-8?B?ekYvbjVsNWdveXFoNENhSUdVbHoxdlFpZlo2NzN1UG5VckR4d3JKSlFXK2Rz?=
 =?utf-8?B?dGhiMlJiZ0tHV0UrcjBQOXh4by85QldxYzlPbXNyZlVRYzE0Nm8zUzJQeno5?=
 =?utf-8?B?a3Q4NTZXNFdtdVo0enVDaFpYa0VReWhCbFo3azdlUVV3VjJpdFZrK0Q0ZkxT?=
 =?utf-8?B?M3dmZkxMckhYa01kY29vdzdlQW10YVh3KzJIUW0rZ0VnTHIzZlVITTFSNSta?=
 =?utf-8?B?SGJ3QnA2TktXQ3NDUG5IQ2dER2Jzb2IvK2ZRU1RTY2VyZ0hlUEE4MzdIZ2hQ?=
 =?utf-8?B?OWNBNHR1MXBsQkFJUzQyQ3dZVnhBTThrbjl0am1UV2lCK1dST3l1MmlSa1pn?=
 =?utf-8?B?ZkxUS1BUZ3cxMzlDUlVsZ2QwZ0tvZVZWY09JTFlvOEU0QnRVTm9FVW1LMXAz?=
 =?utf-8?B?UGVBekF3eXhsK01OUSszK1JtS1B6MngxSksrUC91Z3QrZkM3MjZnZWJxYVNN?=
 =?utf-8?B?N1FuYzh5NjRrR0YxUVI1c0FKeUVNbGt0MUZxalhwc0RVV0U0bGtjeThxWjZv?=
 =?utf-8?B?Vk95YnVHZnhHQjExc0FENFZnV3BMN0RYemVMTDMwTjh3OHIwZVdleklvSFZY?=
 =?utf-8?B?eWlwd0NkN3E4WUswTzg3QTRpUFR3ZURuME9rVUpqZnZIVzhqcStNc1pwby9m?=
 =?utf-8?B?emhZaEt5MS9xaGwvVDQ0VHVpQmRBSVZTQWl6Q1dwWlFyc1dVWWMzQ25xbnYz?=
 =?utf-8?B?OVF1ZDcwcDQ3aTdERXhoa3NkTEw3ckxtQ2c0NURxQk5NUG9VZ1FzaFY4Qml0?=
 =?utf-8?B?WkJoRFVyQi9odmI4STNxWTVDNjc2VzlzWG51RkdPcTVFMnJEc1hxSm51WG40?=
 =?utf-8?Q?K17+psHO7n2OZsf4S10b?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760103e8-ddbd-44df-1b3d-08dd68653086
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 10:43:18.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4613



On 3/21/25 14:35, Rob Herring (Arm) wrote:
> 
> On Fri, 21 Mar 2025 13:09:50 +0400, George Moussalem wrote:
>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
>>
>> The IPQ5018 SoC contains a Gen2 1 and 2-lane PCIe UNIPHY which is the
>> same as the one found in IPQ5332. As such, add IPQ5018 compatible.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>>   .../bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml | 57 +++++++++++++++++++---
>>   1 file changed, 49 insertions(+), 8 deletions(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:0:then:properties:clocks: {'minItems': 1, 'maxItems': 1, 'items': [{'description': 'pcie pipe clock'}]} should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:0:then:properties:clocks: 'oneOf' conditional failed, one must be fixed:
> 	[{'description': 'pcie pipe clock'}] is too short
> 	False schema does not allow 1
> 	hint: "minItems" is only needed if less than the "items" list length
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:0:then:properties:resets: {'minItems': 2, 'maxItems': 2, 'items': [{'description': 'phy reset'}, {'description': 'cfg reset'}]} should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:0:then:properties:resets: 'oneOf' conditional failed, one must be fixed:
> 	[{'description': 'phy reset'}, {'description': 'cfg reset'}] is too long
> 	[{'description': 'phy reset'}, {'description': 'cfg reset'}] is too short
> 	False schema does not allow 2
> 	1 was expected
> 	hint: "minItems" is only needed if less than the "items" list length
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:1:then:properties:clocks: {'minItems': 2, 'maxItems': 2, 'items': [{'description': 'pcie pipe clock'}, {'description': 'pcie ahb clock'}]} should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:1:then:properties:clocks: 'oneOf' conditional failed, one must be fixed:
> 	[{'description': 'pcie pipe clock'}, {'description': 'pcie ahb clock'}] is too long
> 	[{'description': 'pcie pipe clock'}, {'description': 'pcie ahb clock'}] is too short
> 	False schema does not allow 2
> 	1 was expected
> 	hint: "minItems" is only needed if less than the "items" list length
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:1:then:properties:resets: {'minItems': 3, 'maxItems': 3, 'items': [{'description': 'phy reset'}, {'description': 'ahb reset'}, {'description': 'cfg reset'}]} should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml: allOf:1:then:properties:resets: 'oneOf' conditional failed, one must be fixed:
> 	[{'description': 'phy reset'}, {'description': 'ahb reset'}, {'description': 'cfg reset'}] is too long
> 	[{'description': 'phy reset'}, {'description': 'ahb reset'}, {'description': 'cfg reset'}] is too short
> 	False schema does not allow 3
> 	1 was expected
> 	3 is greater than the maximum of 2
> 	hint: "minItems" is only needed if less than the "items" list length
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250321-ipq5018-pcie-v5-1-aae2caa1f418@outlook.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade

thanks, did the upgrade and see the errors. Will fix in next version.
much appreciated!

> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Best regards,
George


