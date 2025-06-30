Return-Path: <linux-pci+bounces-31064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B986EAED697
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 10:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C498F188ECF2
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA265239E95;
	Mon, 30 Jun 2025 08:03:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023098.outbound.protection.outlook.com [52.101.127.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9B23AB87;
	Mon, 30 Jun 2025 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270601; cv=fail; b=V5i30yzB3R+MHVvIPdsoVR7HFr02lQuwUht91EPdnUx+NM1a776ZlFQPwyyCHKkZhGuIbdLfbLCzT/1YGCBhxQ6Q9qYIFGTZJM67E6Xy8e+zADkYmKuGT/Xets91oRmHQHVsCp2O94Gc7oSNuEfwpO6CjU5zIlBdgDJ+8k+GPCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270601; c=relaxed/simple;
	bh=/eGkI81IGWnVrCABATLqi3CFMmkgyJ6+viXzItu5pyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbCwn8FKoDCS5SsDw5tz5EmOLjW8mx7FsALY4UxmiZLxZuszVxm/DIxXDy50AtaoeZwoZ/JqVkZW9ucpeeS2Rnp438xnclNjsHC3pvZxgJr+I7y9HcxrcIAJiZPU7c1hywBq5EYWWAaBaH9JsFmBocpIen82kCf2nIwe1uZnCmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wquQoopZg57lP/z0ZOLqrhyzIGbuWnEP9DXELvEaDzTTbqrbK2Zed83y6i1bq73l8X16AZkP5DkzAOm5vVa8AIDLJxZ3HTBDVct9lnPLdR3r1Sahcw8ruke5LQxOAxGFBxZdAb9jwOlTwwxElZoEi93cbOf4RvqGY8eHr/swyRH0GceWCad7Ca03Od9YFcBEA1e3YRgzWKOrvMloK79HzmPPPhTerPCznqbscV6A00uGRZI64dC7Avp7YX61Hbld0Ir/oK4H3w2s0nO3N5ZznuqIAn+sCoXiJVO1AMo82miI7XVAK7NgraMlUQBfu7XPH1Pyw+vtTSMEp9U6ERokvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6AIt9ONd473KcvUOykpgKSqJ26wMyiMT0BA9ur7ZC8=;
 b=wW/IrO4Q+nlSC5jvy4FH1wTXvU4syq8Rdr7GaICMt2gdx4SHt+ILoIfdupkB5i7tLku60nA1o7gUs/P0P+Rg2+p1kIhDVVyrFUtQX9my5ppdAh+cEfeqWQog1V35MteW2bwHl4ukBwYRRoKf86L19SfDSBtY2ZKdAjzzs8+dUppJ9wZ2c1xPIBsD30GDwo7knei+dtucKvLB0yMSZ0Ga6L5y2jgs5W6aNpy1W/67r0aaA7iiBlimCphco2fjm1gdBMkUbi95FLGN7I12UmhzSFjAQfUIrWKmLH0oXrJH4Gp8aurNLDWN+qH++Apf1ZyQP5u0fBYRs+bruhoA6rZ1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22) by
 TY0PR06MB5056.apcprd06.prod.outlook.com (2603:1096:400:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Mon, 30 Jun
 2025 08:03:14 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:c7:cafe::a2) by SG2P153CA0035.outlook.office365.com
 (2603:1096:4:c7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.3 via Frontend Transport; Mon,
 30 Jun 2025 08:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 08:03:12 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 530D144C3CAA;
	Mon, 30 Jun 2025 16:03:11 +0800 (CST)
Message-ID: <5b00c979-0c1d-4f12-8544-c9edbaaf0c8c@cixtech.com>
Date: Mon, 30 Jun 2025 16:03:11 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/14] dt-bindings: pci: cadence: Extend compatible for
 new EP configuration
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-3-hans.zhang@cixtech.com>
 <20250630-antique-therapeutic-swift-dec350@krzk-bin>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250630-antique-therapeutic-swift-dec350@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|TY0PR06MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: fea46873-0800-4247-5bd1-08ddb7ac8f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHBLMTJsbktTOFkxS01aVHZWY1l5WCtrek00ZzU5YUJveTArZjc0UWwrdVYz?=
 =?utf-8?B?RDljUEJ2bnpuQUczTW9CTW5WNmg0ejluMWUrU29CUkFob1U0T3NOZkpWdENj?=
 =?utf-8?B?d3d0N2dkRmpydkdzdGlyWTFUMVQrb1lVSGJVNGQxd0xUMFJ3V1hKdXJFMFJq?=
 =?utf-8?B?UW5sMnBhTFJ4WlRDWHY2N0wrM1pnRGVPc1BJYk54b0s2WFZVNXVUc1FLSXNR?=
 =?utf-8?B?ek5iK01sZy83TW5XWTJqNWk0RjJ2SGQxTEdza2dzSDM4UlJTWk5LV0dVVits?=
 =?utf-8?B?VWNxcEd2WTZhRjRWSEtuODVKT0k3QTM1TWtHbG1yWmJjbERQdWovejltdjlt?=
 =?utf-8?B?MHVnVU10amhTaE5tOEZMRC9pWCtqdEtjRXY2UDVUc0wyVlRQNFVnY2xwWnFG?=
 =?utf-8?B?MzJFWk1wcWttdkswMjlhSzRWOWpuUFllbDJxajFMK2pFb2k0YW5yanpKYmZa?=
 =?utf-8?B?eFZDMFF0RnI1S292ck5iMjMxVy9RQ3gxN2thZlpHUU5xQTgwQ09CVHgrbDRu?=
 =?utf-8?B?cnpscUc3RXVjRlRubGFYQWt3TWlwR2FnT0NsUnpzMGJaZmREWmRBNDUrd1ZY?=
 =?utf-8?B?OEpIaDdndUpCeVhkSzJBZ2FxSnhmZFdRZm96Tlo1L2J1NXd3cHM1Y1hPNmRP?=
 =?utf-8?B?QnVRQUhOL3psSWpRUk9vNVVCRENFWVFkNWIzUVZzSkZpOUszVVRBVzVUVFgz?=
 =?utf-8?B?S2xIMCs4V0ZsU2YxdDhrN3B2Wnk0cmxvWmVUSGVmUlQvS05XTGc4VVpITlk4?=
 =?utf-8?B?N2hDcjF5NWNxeXQ0RktKQmE0Q2tJRitpbVJoRHJJQTZIMFE1SFNCRmJsb0Vx?=
 =?utf-8?B?eXArdzdkQWFOTWpMVjlISkJtdElHaTMrSXpoM0tLTTBoTnRBcGFpVmVOdE5R?=
 =?utf-8?B?U0ZtZnpEWnAyZlR6MFpXTzlUOFpvaVJVSTF6d1czbnNKMFl5RHp1ODhjSm1o?=
 =?utf-8?B?MGNyeWlIMmxMT1JTdmQ3OTF0cHdZQlFIVDJ3N3E4V3VUSXFkNWFGbWswbmhL?=
 =?utf-8?B?blp1ZEY1SmJ0WkliWlBPYm50V3pkWkhneU9PZnNtVzBYd3JHSHFQaGZDN1Zv?=
 =?utf-8?B?TnoxakpGQkoxYlc2MHFXNzZ1a2xjRHNkR0x6YkMzYTI3RXpCUC9TWlhnZTFP?=
 =?utf-8?B?enI4QjE0Wm5neDluQXA1SUJLb3J0TDU5alBJSVVxek9KVThCbUUzMUFGalFW?=
 =?utf-8?B?U0hST0dUdCtyRXhVTHo4d2JJUlB0dElMZWNmZi9FZlU0Z3RhczJzYlJ5ZWVS?=
 =?utf-8?B?Z3lDc3laV3krZzE1dTRIQlQrR0IrS3hpWWc1S3pMd1AzNUZmRTgwUmthNHU2?=
 =?utf-8?B?U2JrUEpSclhTWnVDTW1ZUmtORXdTQ3RROFdZVndXRVlhNFhTRW8ycVduSWYy?=
 =?utf-8?B?MnNhMVZhem1EbFdidSthQ2pTZHY5RE5rVkYyQ3ZoVWIrMkxWb1cyL01FajFB?=
 =?utf-8?B?VUcyYVRMcGd3dlFKRWZYWEFqeTB1Rkp1cFpxbXREUDV0ckVZQytlb2VvbENs?=
 =?utf-8?B?VENUcTdHQXE1OFh5UHpRN3NCaE8yRm1WT05MYUpvdWU5OFRhVWdGQzhIWEcv?=
 =?utf-8?B?cTVkRG1YbEdtbmpUckpzeGQ1dkc4MmtrL0d1YUNWLzBZTlVpR041SCtXUWpJ?=
 =?utf-8?B?LytlYnRFd3ovdkM3clROWWg0aitPblkyc1dWMWVLMWhCcEYvVDVuUExuMmVW?=
 =?utf-8?B?T2UvekFCQThpSitZZU55bjIvOEFSSzFYVm9pRjFTclZiT2tqdGxtQXY3K3F0?=
 =?utf-8?B?YnlFZmpOTmZKc2RrSXNseHZMNUViaHQ3dGNRQk5TdGF6clpWdUtWdmxlWVlN?=
 =?utf-8?B?VHU0WW50MEpZTGJsTEdzcldsSkxUam1IK0RjRzJXWUY5Y3dnOVVTNDNYdUZX?=
 =?utf-8?B?bDlpYlUxQkY5RWJWaDhWaDdENzR3VWxSVUVJOU8rNGJDNi9ucUlzQnpYMVYz?=
 =?utf-8?B?dDFPQ09DUnY0ZmxWWnZ6cTRXK3hlc0lSK3VublhyTnU0b05QVExYcTdTZVN5?=
 =?utf-8?B?T2VpSHM5STBYVkZ4OWZndHJxa1RPM3p6OXVLWmNOTTBDLytaOXBtQkQ0VG45?=
 =?utf-8?B?UXArU3p0UDhMelZPRjg5MWZXbFBYWmtUZkp6dz09?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:03:12.0010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fea46873-0800-4247-5bd1-08ddb7ac8f3d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5056



On 2025/6/30 15:27, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On Mon, Jun 30, 2025 at 12:15:49PM +0800, hans.zhang@cixtech.com wrote:
>> From: Manikandan K Pillai <mpillai@cadence.com>
>>
>> Document the compatible property for HPA (High Performance Architecture)
>> PCIe controller EP configuration.
>>
>> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> 
> Missing SoB.
> 


Dear Krzysztof,

Thank you very much for your reply. Sorry, I missed it. Will add:
Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>



> Why are you sending someone else's patches? This just duplicates the
> review and creates confusion.
> 
> Did you address ENTIRE previous review when you resent this?
> 

Previously, due to the Manikandan environment issue, the entire series 
of patches couldn't be sent. Now it is Manikandan who sends the patch to 
me by email, not by git send email. Then I will send out the patches of 
Manikandan together with those of Cix Sky1.

The following is the previous communication record:
https://lore.kernel.org/linux-pci/4bcc07b1-00ce-4ff9-bf23-e06b78950026@cixtech.com/

https://lore.kernel.org/linux-pci/d275cfe1-db7e-47d6-9ec6-b36f13524d65@kernel.org/


Regarding the opinions you mentioned that some Maintainers' issues were 
not resolved before, please reply from Manikandan here.

Best regards,
Hans

> Best regards,
> Krzysztof
> 

