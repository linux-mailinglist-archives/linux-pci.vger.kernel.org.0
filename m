Return-Path: <linux-pci+bounces-6011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA75B89F187
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 13:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C7A1F21575
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0818D15ADAA;
	Wed, 10 Apr 2024 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C0mBTrhc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2113.outbound.protection.outlook.com [40.107.237.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCA1494D6;
	Wed, 10 Apr 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750273; cv=fail; b=jCxtYuluM1elRu5oyw8Aup0aivJKF3a1DN7Csq+hpCpzVdNRGe+cenj5WDrIIoHTzWTJvVPKyxexngti4y1tBKKW4HIewgX38P1MMYrYc50p4h+KSH8rlvOP9y8FPdblGy1s+EA3LrEZGnTlZRdYomG88DgZY7WEhlZdxJqwtGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750273; c=relaxed/simple;
	bh=6TkiB8BmmN6a+t7DyYLqykHmxxg6iLmBKB4lqpKfni4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lc8D6ljH4pOuETprMbU6IBs5FwK8AY6dKXhiqrM3M+pAKZ1jMEwzww+9n50IuMwo12wATL3/WfpKfPxShUNJ9JcQuIOMRoY3jW8dKF/UtpB2L9jzPGn6L6cTkzq2p94UJBB42wGXzvn7CKBitbAx4FJAEp0xLq9UmH6hEQiLKPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C0mBTrhc; arc=fail smtp.client-ip=40.107.237.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA1zdCzLfCpeWdjX3TKogjWKAlBFvgzIGdi+EcLVbvGmOh05ueDJzZXFlN8RENqo8tia4l/trCkMCNdKRAqVPhYJ+waMdgzE7iIIQobo3RtR2aLuWMy3odE3UKpzQX0I/rJeoQSrHc2NuhWaMSpBMixJyZUQarn6VpEAYadtfrmbI6soqvhVazpd9VV5fbw0FW/Yza4E1At26swR+GFmp1oOa6VDZ8NJOY2UkJccFPfbfxtU7UR3pD/CCfDxzuuA65ReVz6cKiLSrYMB803H6cVvgj/9a3fjKaDNJYmOhuzdpzuOxRfRu0xtFrtDVgxqSJgGn7vaJk2hEqfPoo58/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iH3r/t+tRbXNrtWhF8Djoaf3FfifaAiilCDFsXVgMFE=;
 b=f0hklcK+oD9zBOczmyHPPcKThNKptt6m9Ca3pDtcoEgec38NEbtkcFlEmspMoOhHwU34V4GhEtguBRIYTEmeHw9RmTSYjXbnMurLabrbtngiHZSCp8gqIY+rq53Z9cXef4wNoM0ymp3kYk8Nbdzyt+5I1yBPZpScbr+htDQVKympUPM3BX7kXguloy23qVMsuD35rjFlIE92jwxoiUTc4dhZVv8DlK/THPvRRCr/eFME00DTKqsPFIPXf2y+r8TXO3CGBHPqu+umF/+GQzcPA9wuUFQRXu3zNLNLzGjqU1R/5MIIiQGqqrI/YoKrJCmIueA8gHt87AdqjI+c7rpBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH3r/t+tRbXNrtWhF8Djoaf3FfifaAiilCDFsXVgMFE=;
 b=C0mBTrhc1k+bBtnraZs02aGiKgwRSxmkQaJOR0MHE6r728c0PjIsWS6YMpIC1Nq+YBIX51UsHQCFHW+Wf/+BvOnP/asfgsCOYMGQVFCu8ysooQgQP9IbrxEMdxfo5iQERMZagqx7frBoJJVKMJzs4yiAuZpB9tggjYOFnwIYK1g=
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 11:57:48 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::ad43:48cb:df1c:c72f]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::ad43:48cb:df1c:c72f%6]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 11:57:48 +0000
Message-ID: <579ece56-2a6a-4cfb-b29b-f7bfda67588d@amd.com>
Date: Wed, 10 Apr 2024 17:27:38 +0530
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 02/18] PCI: endpoint: Introduce pci_epc_map_align()
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-3-dlemoal@kernel.org>
 <dccb87db-d826-43fa-a499-cf36ea9b10d5@amd.com>
 <3a2aff21-4b1d-4f99-bd49-bf75f41cb924@kernel.org> <Zg_skLWnl04-pxkn@ryzen>
Content-Language: en-US
From: Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <Zg_skLWnl04-pxkn@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::14) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|PH0PR12MB8049:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KIMVmdHZHuQlfAG8O9uk7Dk+EOU6kc+fpQAQt1n1RUuPKm15Ap0JJudd4QIvQvM9JQlCiyarMGaKys13rjby/cwCtG6Nm3J2sCBnPcWVVQs4/NWlaiPjpFuzvsmA/fTwN9x3jT0xmEiEOEvKpnOl8a4FUd+9xdgfaq5ttBd9D5/U6WlEK20JNs5vLpgH3GsLdxfMEiusjlLt5oKtYryWkY8ONl1qfWMC3lLuxhqjdg6mhGbLlufIMzXAh6Tt7nQOBSOGm6ILd1tui8o73F2lrZVueOkZRqWjx4mhJJhLFdZY5/O98KUXZSG3NMVubevR+WmMbe0nP1ga1jmxBz7fh6e9V8pgkYNN5SVLUGMTltQj+mPneMeRXYjUU9cezFHI5Kb4zddlD9CdjCSV+FA+10tNDpwUWOYZ5oGwHfkP/JW2v9kbg4VcqzRAC2veFgo35B2kXqhyRwMXJVDwx7Pm1xZXCOdxiHSFKGQC598x/Bz28gP3ViZAq+we9E+bsdheCM/2IRAaRDx7zaBzr2nuPJAbgsCmlkKnJYAK4gBJZDQ99O6MyOWD9E5y0+CYOFf7qeU1EKVwZPkqdVXxympocGEzGF5/yhUPp5zArqfkU5jYtJM3VH95nPFDEFSMn82r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkdCckVGVjFSRjh3bnRLVjhvdXl5WWsySFlqdG9RSVBna25ZNittbGc2NG1t?=
 =?utf-8?B?enZYaEdJWTVWQnlhUmVsT3VNVFhuZTNjZlB2dkRES1hZcU5iODJpTVA4SzNZ?=
 =?utf-8?B?a2NvNFIwSkIyWXBSN1NsZTNHaERiekRNZ1dtOFZranpiSk9BRU8rUVVsYWFk?=
 =?utf-8?B?QWYxUFczc2o1NW5IcldxQmtpYTJoV2d6b0J2YnA1UlZJZlhkNlRLcGhwZVQv?=
 =?utf-8?B?L2UwcXdjajZZVVh2SmlzemdxWHE2RHA2UGlaa0UvQStwaTZ2Y0lzSDkrT1Jv?=
 =?utf-8?B?V0hqSDV1SUpHYll6eXVVelZrbUFPQUFtaXNsaXNiRmhnMHdqTWx2TWg3TEM1?=
 =?utf-8?B?aFU4cWtSWThjdEFYaElyMStxTjZBNnBNeU1mbXQ2aDFPa010UGsya2thN0Rz?=
 =?utf-8?B?dTUvQTEzajlGNDlyUmV2dElWNGJML042b3BiaUYyd1dZN3EyQUY1b3cvRUxl?=
 =?utf-8?B?bEJ2aFE4UlAzWURFN1FiZENzK3V2Zi9FUnV6d05EbG5FeU9nQVMxUWNsUE1E?=
 =?utf-8?B?V3dWTS9QRlRnZjd4WWtJaVR4WFdPTVZxTGJvbG1VQWhRRzVJVXdSdXBYaW1R?=
 =?utf-8?B?TnYrQUhva3hLbENUc2JqUlk1QlpadHRXcW9RN0djTnVPcTNFYjJPQnp5d1pj?=
 =?utf-8?B?MlJWV1lwVGpPdEphcmdzZEE0dDdwWThSNmFnWlZjSzMvTVVpNUxGb0piYk1k?=
 =?utf-8?B?MDAydnc3SFc1RXdlb1VIdFc0d1NIeDliKzllWkpSQmpHdWZuUWM3Mm9rQ3g3?=
 =?utf-8?B?VFpOR2ozSkhOekltQ1NUQVIrM29UaEMyWHV4dDVtT3VlcDZjRzRvZEt0VGRI?=
 =?utf-8?B?OEx2ZForQi93c0ZoWms1MTJSWmJlUlhuSkNQK1pMbkFZWk9CMkVNdzA0K0sr?=
 =?utf-8?B?SFFKQytYdkdsUVR0L2NRMXJVaHI0T3RXRlVKOGVqNzJuamc5MEdhbW5SUmZx?=
 =?utf-8?B?ZkhOeUV1YWxvNVhlbEtnV1ZuTDBXUUxPL3J0dDZSaXVMUTJpWko0aTA4NlBo?=
 =?utf-8?B?SlM2K2RXYkdpQ1E2a3ZmK1VQK1VNMGRCNEFoM2lpVXRIRzFGaW1KK2tna0lm?=
 =?utf-8?B?TGhKUGY5cDNyRmF6bklaTitvM21aSXV5RWNRRTBwQ2ZSZXhYZFNJS2JQRzhs?=
 =?utf-8?B?WGkxWVZpTjdDVENDaVkrTGxzUjQ0S1F4MjFPWHAwejd4YVBhaDlwWllCL01i?=
 =?utf-8?B?VWY3T0dMSWo5b3Z5eGRzSk9jSDhuTWhoZk1OVGI4aU9PeTlYakRLcHdNcG91?=
 =?utf-8?B?bnpwMFNKaFJ4aTdHYWM3QzVSVlp6V1N3Z3E5RlMvWmdxK3pmTEh3WG5pcmJC?=
 =?utf-8?B?cmlhYlYwbzZoTkM3Vk5OYU5jWWJyTkI0TEQwT1FBMDYzTTFmT2F3MEF4UmhH?=
 =?utf-8?B?RFZ1WWQ5MHhteVJBS09oMnRCa3VNMHl6MnB5RFdodlhyTlZkbUljeVBQYXJo?=
 =?utf-8?B?SkI5dUpjSEVOdlFLakdoMzVkWEI4YkRBMndweE9icHc1eDZFUHZxV0Q4R2J6?=
 =?utf-8?B?NVVBUWZlQ2I1UmJGZVVLTmxGM3NmZTgrTUR4N2JXZmcyd2o1eThFczFlOWs4?=
 =?utf-8?B?bWgwSGFpREFweWMveDhvQm82L3pxem91aGgvVktrTHVJaldxSmNnQ0pOMEpx?=
 =?utf-8?B?RUlhSmlIWkdQaDRUck16Z1hvNDZLdGFNbVNuMFJJc2RSRkh3dTdKYnN4YXFW?=
 =?utf-8?B?UEpyUTMveEpNRGJSeGZVeklleWJZSU00dEp0L2VPSU15NlRuMjRjOVV1UGtJ?=
 =?utf-8?B?TS9WajF3emVLeWl5WHlGV3ZDOENjVVBSeDV3aDFIcFpzSVNCODRITG1qQmpa?=
 =?utf-8?B?VzB3dzNkS3dzdE9BSDYyOTVSTWtIcHVxS08xWHJsMDVld3pBdmlhYjl3LzIv?=
 =?utf-8?B?TnA2YlREdlJYR1p2aUo4bzdLTXA3Y0pRa1dvcm5yR1pCNVBKSmJkaER6UG9x?=
 =?utf-8?B?WGVuTjFkbXVUMHdVclM4U2xjREcrQVJBNWY2UzRpeVJHeFhSaUNuU1Y3aGhy?=
 =?utf-8?B?Uy9rdys5OFdWSEJraVp2ZkhCYXREcnJFaHVhRzFBY2U0SEVHV3daR3lYb24w?=
 =?utf-8?B?YVNLcG1TdzFGK05YMy8wcHdVREdhaFd2WTdPUlhFbjF1NjNnZXVzK2E1LzBV?=
 =?utf-8?Q?vy+mBc5Y/CAxk+xcZQXHaEfIh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef4cac8-494f-4628-8e72-08dc5955709a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:57:48.1701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9smtdc5+iwy6lYNXyuogB4Yjxx02DlkHAjbS9uoajdYUGWw8xH/yZ7Iuh9MdJ760VPhJUkPa0MVmte3ytHryaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049



On 4/5/2024 5:50 PM, Niklas Cassel wrote:
> On Thu, Apr 04, 2024 at 11:43:47AM +0900, Damien Le Moal wrote:
>> On 4/3/24 21:33, Kishon Vijay Abraham I wrote:
>>> Hi Damien,
>>>
>>> On 3/30/2024 9:49 AM, Damien Le Moal wrote:
>>>> Some endpoint controllers have requirements on the alignment of the
>>>> controller physical memory address that must be used to map a RC PCI
>>>> address region. For instance, the rockchip endpoint controller uses
>>>> at most the lower 20 bits of a physical memory address region as the
>>>> lower bits of an RC PCI address. For mapping a PCI address region of
>>>> size bytes starting from pci_addr, the exact number of address bits
>>>> used is the number of address bits changing in the address range
>>>> [pci_addr..pci_addr + size - 1].
>>>>
>>>> For this example, this creates the following constraints:
>>>> 1) The offset into the controller physical memory allocated for a
>>>>      mapping depends on the mapping size *and* the starting PCI address
>>>>      for the mapping.
>>>> 2) A mapping size cannot exceed the controller windows size (1MB) minus
>>>>      the offset needed into the allocated physical memory, which can end
>>>>      up being a smaller size than the desired mapping size.
>>>>
>>>> Handling these constraints independently of the controller being used in
>>>> a PCI EP function driver is not possible with the current EPC API as
>>>> it only provides the ->align field in struct pci_epc_features.
>>>> Furthermore, this alignment is static and does not depend on a mapping
>>>> pci address and size.
>>>>
>>>> Solve this by introducing the function pci_epc_map_align() and the
>>>> endpoint controller operation ->map_align to allow endpoint function
>>>> drivers to obtain the size and the offset into a controller address
>>>> region that must be used to map an RC PCI address region. The size
>>>> of the physical address region provided by pci_epc_map_align() can then
>>>> be used as the size argument for the function pci_epc_mem_alloc_addr().
>>>> The offset into the allocated controller memory can be used to
>>>> correctly handle data transfers. Of note is that pci_epc_map_align() may
>>>> indicate upon return a mapping size that is smaller (but not 0) than the
>>>> requested PCI address region size. For such case, an endpoint function
>>>> driver must handle data transfers in fragments.
>>>>
>>>> The controller operation ->map_align is optional: controllers that do
>>>> not have any address alignment constraints for mapping a RC PCI address
>>>> region do not need to implement this operation. For such controllers,
>>>> pci_epc_map_align() always returns the mapping size as equal
>>>> to the requested size and an offset equal to 0.
>>>>
>>>> The structure pci_epc_map is introduced to represent a mapping start PCI
>>>> address, size and the size and offset into the controller memory needed
>>>> for mapping the PCI address region.
>>>>
>>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>>> ---
>>>>    drivers/pci/endpoint/pci-epc-core.c | 66 +++++++++++++++++++++++++++++
>>>>    include/linux/pci-epc.h             | 33 +++++++++++++++
>>>>    2 files changed, 99 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>>>> index 754afd115bbd..37758ca91d7f 100644
>>>> --- a/drivers/pci/endpoint/pci-epc-core.c
>>>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>>>> @@ -433,6 +433,72 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>>>>    
>>>> +/**
>>>> + * pci_epc_map_align() - Get the offset into and the size of a controller memory
>>>> + *			 address region needed to map a RC PCI address region
>>>> + * @epc: the EPC device on which address is allocated
>>>> + * @func_no: the physical endpoint function number in the EPC device
>>>> + * @vfunc_no: the virtual endpoint function number in the physical function
>>>> + * @pci_addr: PCI address to which the physical address should be mapped
>>>> + * @size: the size of the mapping starting from @pci_addr
>>>> + * @map: populate here the actual size and offset into the controller memory
>>>> + *       that must be allocated for the mapping
>>>> + *
>>>> + * Invoke the controller map_align operation to obtain the size and the offset
>>>> + * into a controller address region that must be allocated to map @size
>>>> + * bytes of the RC PCI address space starting from @pci_addr.
>>>> + *
>>>> + * The size of the mapping that can be handled by the controller is indicated
>>>> + * using the pci_size field of @map. This size may be smaller than the requested
>>>> + * @size. In such case, the function driver must handle the mapping using
>>>> + * several fragments. The offset into the controller memory for the effective
>>>> + * mapping of the @pci_addr..@pci_addr+@map->pci_size address range is indicated
>>>> + * using the map_ofst field of @map.
>>>> + */
>>>> +int pci_epc_map_align(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>>> +		      u64 pci_addr, size_t size, struct pci_epc_map *map)
>>>> +{
>>>> +	const struct pci_epc_features *features;
>>>> +	size_t mask;
>>>> +	int ret;
>>>> +
>>>> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (!size || !map)
>>>> +		return -EINVAL;
>>>> +
>>>> +	memset(map, 0, sizeof(*map));
>>>> +	map->pci_addr = pci_addr;
>>>> +	map->pci_size = size;
>>>> +
>>>> +	if (epc->ops->map_align) {
>>>> +		mutex_lock(&epc->lock);
>>>> +		ret = epc->ops->map_align(epc, func_no, vfunc_no, map);
>>>> +		mutex_unlock(&epc->lock);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Assume a fixed alignment constraint as specified by the controller
>>>> +	 * features.
>>>> +	 */
>>>> +	features = pci_epc_get_features(epc, func_no, vfunc_no);
>>>> +	if (!features || !features->align) {
>>>> +		map->map_pci_addr = pci_addr;
>>>> +		map->map_size = size;
>>>> +		map->map_ofst = 0;
>>>> +	}
>>>
>>> The 'align' of pci_epc_features was initially added only to address the
>>> inbound ATU constraints. This is also added as comment in [1]. The PCI
>>> address restrictions (only fixed alignment constraint) were handled by
>>> the host side driver and depends on the connected endpoint device
>>> (atleast it was like that for pci_endpoint_test.c [2]).
>>> So pci-epf-test.c used the 'align' in pci_epc_features only as part of
>>> pci_epf_alloc_space().
>>>
>>> Though I have abused 'align' of pci_epc_features in pci-epf-ntb.c using
>>> it out of pci_epf_alloc_space(), I think we should keep the 'align' of
>>> pci_epc_features only within pci_epf_alloc_space() and controllers with
>>> any PCI address restrictions to implement ->map_align(). This could as
>>> well be done in a phased manner to let controllers implement
>>> ->map_align() and then remove using  pci_epc_features in
>>> pci_epc_map_align(). Let me know what you think?
> 
> First you say that you want to avoid using epc_features->align inside
> pci_epc_map_align(), and then you say that we could do it in phases,
> and eventually stop using epc_features->align in pci_epc_map_align().
> 
> I'm confused... :)
> 
> Do you really want pci_epc_map_align() to make use of epc_features->align ?

Would like pci_epc_map_align() to not use epc_features->align as 
pci_epc_map_align() is for PCIe address programmed in outbound ATU 
(destination) and epc_features->align is for physical address programmed 
in inbound ATU (target for BAR accesses).

I mentioned "in phases" for if some platforms require 
pci_epc_map_align() to use epc_features->align, we could keep 
epc_features->align in pci_epc_map_align() till all of them implement 
the map_align() callback (and need not be part of this series itself). 
But eventually stop using epc_features->align in pci_epc_map_align() 
once all the platforms that require alignment implement ->map_align().

 > > Don't you mean ep->page_size ?
> (Please read the whole email to see my reasoning.)

page_size is for two purposes:
1) Dividing into fixed size blocks the outbound address space for 
simpler memory management
2) Alignment restrictions for source address (outbound address space) of 
the outbound ATU (so page_size is for source alignment restriction in 
outbound ATU and pci_epc_map_align() is for destination alignment 
restriction in outbound ATU. Source address would be an address in the 
outbound address space and destination address would be PCI address 
usually provided by the host).

Even if some platform doesn't require source alignment restriction, it 
still has to divide into fixed size blocks.
> 
> 
>>
>> Yep, good idea. I will remove the use of "align" as a default alignment
>> constraint. For controllers that have a fixed alignment constraint (not
>> necessarilly epc->features->align), it is trivial to provide a generic helper
>> function that implements the ->map_align method.
> 
> We can see that commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a9a801620efac92885fc9cd53594c0b9aba87a4
> 
> Introduced epc_features->align and modified pci_epf_alloc_space() to use it.
> 
>  From reading the commit, it appears that epc_features->align was intended to
> represent inbound iATU alignment requirement.
> 
> For DWC based controllers, the inbound iATU address must be aligned to:
> CX_ATU_MIN_REGION_SIZE.
> 
> AFAICT, epc_features->align currently has nothing to do with traffic outbound
> from the EP.

It was initially added that way but I abused that in pci-epf-ntb.c
> 
> 
> For aligning the reads/writes to buffers allocated on the host side,
> we currently have .alignment in the host side driver:
> https://github.com/torvalds/linux/blob/v6.9-rc2/drivers/misc/pci_endpoint_test.c#L966-L1021
> 
> Which should be set to the outbound iATU alignment requirement.
> 
> For DWC based controllers, the outbound iATU address must be aligned to:
> CX_ATU_MIN_REGION_SIZE.
> 
> 
> Additionally, we have ep->page_size, which defines the smallest outbound unit
> that can be mapped.
> (On DWC based controllers, tis is CX_ATU_MIN_REGION_SIZE.)
> 
> ep->page_size is used to specify the outbound alignment for e.g.
> dw_pcie_ep_raise_msi_irq() and dw_pcie_ep_raise_msix_irq():
> https://github.com/torvalds/linux/blob/v6.9-rc2/drivers/pci/controller/dwc/pcie-designware-ep.c#L488
> https://github.com/torvalds/linux/blob/v6.9-rc2/drivers/pci/controller/dwc/pcie-designware-ep.c#L555
> 
> which makes sure that we can write to the RC side MSI/MSI-X address
> while satisfying the outbound iATU alignment requirement.
> 
> See also:
> https://lore.kernel.org/linux-pci/20240402-pci2_upstream-v3-2-803414bdb430@nxp.com/
> 
> 
> 
> Now I understand that rockchip is the first one that does not have a fixed
> alignment.
> So for that platform, map_align() will be different from ep->page_size.
> (For all DWC based drivers the outbound iATU alignment requirement is
> the same as the page size.)
> 
> However, it would be nice if:
> 1) We could have a default implementation of map_align() that by default uses
> ep->page_size. Platforms that have non-fixed alignment requirements could
> define their own map_align().

IMHO generic/core functions should not overload ep->page_size or 
epc_features->align as each of them has their own specific purpose.

> 
> 2) We fix dw_pcie_ep_raise_msi_irq() and dw_pcie_ep_raise_msix_irq() to use
> the new pci_epc_map_align().
> 
> 3) It is getting too complicated with all these...
> epc_features->align, ep->page_size, map_align(), and .alignment in host driver.
> I think that we need to document each of these in Documentation/PCI/endpoint/

right, .alignment should be deprecated and each of the others should be 
documented to indicate the specific purpose it's added for.
> 
> 4) It would be nice if we could set page_size correctly for all the PCI device
> and vendor IDs that have defined an .alignment in drivers/misc/pci_endpoint_test.c
> in the correct EPC driver. That way, we should be able to completely remove all
> .alignment specified in drivers/misc/pci_endpoint_test.c.

We should remove .alignment specified in 
drivers/misc/pci_endpoint_test.c and each EPC driver should populate 
->map_align() callback to provide the correct alignment. Don't think 
this should change the page_size.
> 
> 5) Unfortunately drivers/misc/pci_endpoint_test.c defines a default alignment
> of 4K:
> https://github.com/torvalds/linux/blob/v6.9-rc2/drivers/misc/pci_endpoint_test.c#L968
> https://github.com/torvalds/linux/blob/v6.9-rc2/drivers/misc/pci_endpoint_test.c#L820
> 
> It would be nice if we could get rid of this as well. Or perhaps add an option
> to pci_test so that it does not use this 4k alignment, such that we can verify
> that pci_epc_map_align() is actually working.

+1

Thanks,
Kishon

> 
> 
> 
> In my opinion 4) is the biggest win with this series, because it means that
> we define the alignment in the EPC driver, instead of needing to define it in
> each and every host side driver. But right now, this great improvement is not
> really visible for someone looking quickly at the current series.
> 
> 
> Kind regards,
> Niklas


