Return-Path: <linux-pci+bounces-24603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFADA6E884
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 04:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2373C3AE99D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 03:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD60419E7ED;
	Tue, 25 Mar 2025 03:12:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B619AD86;
	Tue, 25 Mar 2025 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742872367; cv=fail; b=I7SEPkNTjKLCGHGPRqwXwxHZNiSdM1d9572ClX2aKmOuAdNf0IRq3xb0Eg7l+BU00Mkl/7ZmUoZ1D280qhUMgksGPK7iMTG8e9JO4WRPEu+voqB+xuAEuTeGYRVRc+StaP8cPynTiJVDtQL8JdkvOs2PK5JGnAr7y9xvumxfoP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742872367; c=relaxed/simple;
	bh=N6BY0ASeksdwEZa51qQx2nROSSZITOI0xdHk5zHcHX8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SIasCS0drETmsrvDFJ25KqOxS4uj3KlVWuEgiPUTm4NWanC1GaBCVPN4Umsh4+gbLQRuxUKTMhfL6dXbYfgVZSbjqw/OzU/GmyRn0OiQHobQgtfNGGPtjx/b+diQToo2Qz3AO3VEMzv0KUNCLM0b54bd+kvqTr9sWE7LIEmx0og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.255.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tloOrZJbvJ8X1GrwQyhDgl9eZOBLNj/JLCG4Y1NWW0KszuQhRGuaBMG/YpBSItycNOPTuTFoaKJDtnQFo3rz9FrX5T4OEu6GP4BdtTXG/3w9Rr1LdJjTK5lzR72E9XcZs2UWx1hMVjZed4uIzM7Z3c5TeknuWVbsBsKm1SdTTSDO86HeztvSJbRkg1fzymD4gl5MOaJCPLc+6S515u22DzHbMOaKOHMWND8ZFB1d5X0tmBhiTJwrXJRlk8IP+WJpZx6Vh8mczUybhtVnfpSI/6Oq6Nxc6ixk5vP7X19y0DJ8nDPPfJoN83rZwjutqlFyXqQYPYQ4xQBVVJUFWJ0FjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5fX6tYFLqoABJePtFjXjD1/6pldin8cwJ5YaJ51PBg=;
 b=ymvl+I/n3mgx7pIB8MPgwPtQ7smFunBUGXfkrmYIvALmOJTB8asWH7i1lS/HWL/8yDKdPxUN7Bwvu2WJMsSJmKhM485TlNUKsqbK16cqaHkKXq3uWynCV/m5NSMX9yNplBPixXHpyl95VSG96pulG1tmoLC4irQbTCpszGSsHnL21SGKAdA29FJu8xVRQCPKSpby3/cfUjPNt4VDpY+jIaT9gCTpqGl+d2R/I/OxpIUjHcc3ZLp9Q4KDBRICaqfnrAwVehIWlfQT1Ege4IPx/i2NSadngACLehrTw60gBo63Sw2cqdhOOFyyZjInqrygcemcRPEAEkcMkxF7rE0qKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY4P286CA0011.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:26d::11)
 by SE1PPF50B2D80A0.apcprd06.prod.outlook.com (2603:1096:108:1::415) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 25 Mar
 2025 03:12:40 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:405:26d:cafe::aa) by TY4P286CA0011.outlook.office365.com
 (2603:1096:405:26d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 03:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 03:12:38 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0FBF84160502;
	Tue, 25 Mar 2025 11:12:38 +0800 (CST)
Message-ID: <2ab4bf45-5bfd-48b0-bb5f-262d60c6f507@cixtech.com>
Date: Tue, 25 Mar 2025 11:12:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] PCI: cadence: Add header support for PCIe next
 generation controllers
From: Hans Zhang <hans.zhang@cixtech.com>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "kw@linux.com" <kw@linux.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20250324082353.2566115-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1CDE19710828C0186B13EEA2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <c69ef0ad-9391-42f2-9b6f-1742e9a746e4@cixtech.com>
Content-Language: en-US
In-Reply-To: <c69ef0ad-9391-42f2-9b6f-1742e9a746e4@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|SE1PPF50B2D80A0:EE_
X-MS-Office365-Filtering-Correlation-Id: 015a30c6-3613-4145-1a4f-08dd6b4ae649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXhJOWdCWThhYUozT2Y3R2dVOTQvQStWV0dRQ3hONWdjMy90Z3I0b2FsYjN2?=
 =?utf-8?B?c1QrSmoxN2R3Z2ZHek1VMUFDZ0tTUTJJdDFPWHZsVmxoVjNuaE11dGUxZ3Ns?=
 =?utf-8?B?T0JWKzZpZGZoZjRVcG9yNlNOWEE4OUYxSUhYb0JWdS9wRFhIOWFtUGtYeGRZ?=
 =?utf-8?B?ZjVsSzljblRtbFF2SnFtcEJXdm4vUVN2allheFdlYkFjNmwwclROTDBveG9U?=
 =?utf-8?B?dUFZNXByU1hPVFNyYzVueUtkeW1zVXo0UXVURGZhZkYrQ2pwYWZOKzFyR0FZ?=
 =?utf-8?B?SUE2RTJTNmMyV1pWcURMM0lWRG8xdWtaMlR0K21EQ0pCbmlWbUJpL05Bc05X?=
 =?utf-8?B?Sm4yQmJobXFWUkpGdUp2RWpXUWIrSUp3TXdxNU1uWnpWQ3NvckRrYy82SGs0?=
 =?utf-8?B?MjRxZTMxM1RMN3ZoT3JTRmNKNTZuSUNWbjFlUUpaenRYNFNMeWxZRldhbitZ?=
 =?utf-8?B?c2lVUFhxa1pRYmlMcHBidG1pSWFwaGZ4WWhCcm0zYVNMYjZTd0dQZkNHTzBT?=
 =?utf-8?B?N01sSGU3VWhSTVR6by8yWDlPdlVjNGVYd0tUUVRhTjVSZUh5Uyt3bmF1aU9l?=
 =?utf-8?B?cHluTzFwaHNWQWxvR2ppYXBJalhrWWZ5M1I3cWlaTFJYWkRtMFdNTE5CUGh6?=
 =?utf-8?B?WmFTc0FlTG1jN0Z5dlE1bms0RDdjMEEvbFNOWkJheEtzWjBpYWJ0MUQ4cDNm?=
 =?utf-8?B?Z2tYdGFZSUFGcEJ6WnlwNDlLT05qeDk0bU5oSERVTDRvMHhyWWJhUzA2NWVI?=
 =?utf-8?B?My9VandYR2JBZjBpS1Q4Z2F2ZWZtczYxNGd3RW5tbnAvcmxTRmpCYVVvN0NI?=
 =?utf-8?B?c0dyblVrdUNiMWtDSmRnSWFqS0hrcHREdFNIMnhJS0ZUSENyQ2VCS0lrVmh5?=
 =?utf-8?B?LzVkWjZsYnJ1cDlpVktsRmdNWkNPbUFac3U2VFR4U0lQSERwRmlwN2Y3eVU3?=
 =?utf-8?B?cEYyd013T0xaY0t1TzJHcXhrRDBKU0M5bGxQVjFXckZYVkJMQ040c0Q4aEhi?=
 =?utf-8?B?RWtoMjlVTE9IVkxzUnBXSVpKUktGREl0R2JlS0lUZEtabWVpcytScHFvQ0ww?=
 =?utf-8?B?TUEyUGdHTXRObU5NcEFrdDkvcndQcEdFV08yMHN1akQzaVdCRk8zb0dnODdI?=
 =?utf-8?B?blhUU2ZNRDJqK1dKTmlBdjdnc01Zc21jTm9QN3hoV3NlTXNSaExla2JMQXhG?=
 =?utf-8?B?cTZ1SW9hMWpXMU00YTNFOENsdmd4bDNqRDEyWm00K3p2SFMyYWsxYkxYdGVT?=
 =?utf-8?B?QVhlU2JWemxqYkNya2RodTYyL1YzYjRVMzk5RkREOHRTRGJNZVd5YVd4UTdT?=
 =?utf-8?B?ZzAxRmNOWk41alF2cTE3aW1nanEwbytIL1kwOElaVW9CdmFkMFZhV0EveGZX?=
 =?utf-8?B?TFNSMGZhOUdBM1VZOU1XcktzVC8vSU14R3ZIczBBZ253b3BkZVptc2g3RWFm?=
 =?utf-8?B?dVJ0aWQ0R3d6R1Q3TWoydUgxSE9DdHA5NXlmSDdtS1B6RmlKUjEyNXJJaVpw?=
 =?utf-8?B?S1dVRS84M1BSUnhQbG5TL3FYTnpTaTRjSThUWTlkdG9HQys4bnBXejIxWEVp?=
 =?utf-8?B?NTlBckhPWGdEdmkrVklYcjZkQmpNdDI2aEY4dm9NcWQ5VU55V3BleVY1eW5U?=
 =?utf-8?B?RlpmT2JqU2ZRaFBaWC9CazhVSzVGUjN6Vng1dFJYZTI1WW1CK2RVSklIZUJz?=
 =?utf-8?B?a2lnaGFOdllaMS9sSG1RWm5qL3UxYk1ZTVZEU0k5ZkVleXFrcEZxSHFEWVF3?=
 =?utf-8?B?TUMzUDZhTkxMS0ZQOEtSQ1d2V2ozRE9yd1BVTm5EN29NZlRGYm1WRFZZZHZB?=
 =?utf-8?B?UVo0RWVQTndoalI3R0krQy83SkpLM0dDU05TMXhVTEJPK2tKMnlyTEhVWDRt?=
 =?utf-8?B?UjV6b2E0bTdKZndwOVpwSHc5djNUVGtLcTFZVE1WRFJCTTNrRzBxSUZ3SFhD?=
 =?utf-8?B?bWY0c3lTOThwVDA2UFFzaG41Y2tJTVFvMmd2dnJBRkltekw0Vzd6ak1uMFM3?=
 =?utf-8?B?UUpIV1NTSThRPT0=?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 03:12:38.9436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 015a30c6-3613-4145-1a4f-08dd6b4ae649
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF50B2D80A0



On 2025/3/24 18:09, hans.zhang wrote:
>> + * High Performance Architecture(HPA) PCIe controller register
>> + */
>> +#define CDNS_PCIE_HPA_IP_REG_BANK              0x01000000
>> +#define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK     0x01003C00
>> +#define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON     0x01020000
>> +/*
>> + * Address Translation Registers(HPA)
>> + */
>> +#define CDNS_PCIE_HPA_AXI_SLAVE                 0x03000000
>> +#define CDNS_PCIE_HPA_AXI_MASTER                0x03002000
> 
> Hi Manikandan,
> 
> Can you change this part of the code to look like this?
> 
> #define CDNS_PCIE_HPA_IP_REG_BANK(a)              (a)
> #define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK(a)     (a)
> #define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON(a)     (a)
> #define CDNS_PCIE_HPA_AXI_SLAVE(a)                (a)
> #define CDNS_PCIE_HPA_AXI_MASTER(a)               (a)
> 
> 
> 
> The offset we designed is: (Cixtech)
> #define CDNS_PCIE_HPA_IP_REG_BANK 0x1000
> #define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK 0x4c00
> #define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON 0xf000
> #define CDNS_PCIE_HPA_AXI_SLAVE 0x9000
> #define CDNS_PCIE_HPA_AXI_MASTER 0xb000
> #define CDNS_PCIE_HPA_AXI_HLS_REGISTERS 0xc000
> #define CDNS_PCIE_HPA_DTI_REGISTERS 0xd000
> #define CDNS_PCIE_HPA_AXI_RAS_REGISTERS 0xe000
> #define CDNS_PCIE_HPA_DMA_BASE 0xf400
> #define CDNS_PCIE_HPA_DMA_COMMON_BASE 0xf800
> 
> 
> The original register bank consumed at least 48MB address space which is 
> begin from 0x0000_0000 to 0x03020000. Because there is unoccupied 
> address space between every two register banks , our hardware remaps the 
> registers to a smaller address space which means the register bank 
> offset address is changed by custormer. So, we cannot utilise the common 
> code directly without rewriting the function.
> 
> 
> We submit and pull a Cadence case: #46872873
> 
> We will also reply to you in the case.

Reply from Cadence case Manikandan:
Another option I can propose is to pass these values through the DTS 
file … (Hopefully that would be lesser changes)

Hans:
I agree to get it through the DTS attribute, please modify it, so as to 
be more flexible. This offset value may be modified when RTL is integrated.

Best regards,
Hans

