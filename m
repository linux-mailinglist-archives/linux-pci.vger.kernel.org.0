Return-Path: <linux-pci+bounces-4492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0CD8715A0
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 07:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C898B20EDA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 06:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F214CB54;
	Tue,  5 Mar 2024 06:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GWX1X3jR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285E43C087;
	Tue,  5 Mar 2024 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709618558; cv=fail; b=uVv6J8pda7y5ZKalWend32/sqIPBbFwsPniPq+YpNRVens7ScTRw6Tu2czstOgVWbe3vMuB2yDi26q0aeNSkh5eDrpc7g1MQ5Nm9ano3IPNKxJCR4iTbcC29+L9GAFkzMsUFj8GV6VQZm7QWrRwNi5gNtP4HmZO3imGrioDVYZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709618558; c=relaxed/simple;
	bh=vWB9HVJMcrrYTXwIPAgimPGlvlDjNSy8nLcf4A//mGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dnTc/ecFIOktqFhLhpqHgHxBZ49qznWTN3snTaPtRjZhfDRPSgMAOAiTlUwjBE/Xu2NwQAODXwbi9WUnSQZsoW3Ob0pUUvoPyKaZ1x4nJ3gSBvj7pYR3J3aKC6sRnafb4HcaAzK/+bNF+XK+lyw2L5hq2xWB0ZCYBZ0G/LdLQ1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GWX1X3jR; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0wT/sD/RUvyznfT2bImWks+Ebekq7IzglKGRcsfPgBN0UgVEYsKakK2w6kaEDWGt161cly4/VBt+AJ6YVcHr2n5aAP9c3U4HKz4OQ9uTcDwNoEGpQ4ig5DEn7RYcvVvtmU9SI0s39BWr6jDUVAuIqH5HNzBKlOuO7zFkLg3iAOyzEylD4v6mMcnl4InA88WPAA3wZ69OHK7BcC7sjOwF07ye4qWSqYWGx3dgm4ErXMAHw+eJapQy8u/QL1Ns90LCSax5+ZAhA7RJwtHyGHia6uULDApP5yGyi9NtZ6ZOZNIonYWIS+u+R0kzaPW4LFg+9RxHOQDba8cPhEnmI0FcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3fk4Wm4pObT/TFM3D+OWrGkSPZLmKlNM5aWiFND9t8=;
 b=IL51ULtVXJieqLroa4GIuSJutq3OFAEUWET3unNpbBGpY2MZVPXi7Q1CqqUjabgI/UlOaI17IfsR24UseRqgMxuMPWt6iGriYsv4EtQ2aoem9DVyY4fvP7q9akpI68RMphtbikHaiEC2syAvTVbeZG2UQk0g5M5Ih1gfxYed+mVBsAhMqfHnKcjX907Hya7R2mAooZQ23UC6FjZO36kvHYh36GRMHcl7/KHBZkRwQVnSU175nf5upSpXpfDc330qjbq9MoM5agf03t1sjGccfdHXRfaDpgpopr8ubBX/Yq6+elGdgBNAXCwp0r+p2E9a5QB/T4xOVVf4lickpdbUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3fk4Wm4pObT/TFM3D+OWrGkSPZLmKlNM5aWiFND9t8=;
 b=GWX1X3jRCJ6rrVwoeYVrPZvOutXSLqaVcyaDwObPTGTCUyT0ewhVx56lnIZkEFW/RdC2ibOgy91cnGHL0F3mgVf/csPsEb8XX1eSP9zAQ7A9hFxRqoGCIPiPEUfNwf6fT88BjncvKbfEAY+TLxK6Z2EpU6n6HO/FJshSyP2xu/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 06:02:35 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::ed15:6173:2f14:f539]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::ed15:6173:2f14:f539%5]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 06:02:35 +0000
Message-ID: <089cddf1-3686-4403-a480-07fddd66ab4b@amd.com>
Date: Tue, 5 Mar 2024 17:02:27 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH kernel v2] pci/doe: Support discovery version
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>
References: <20240226033114.3100118-1-aik@amd.com>
 <20240227204116.GA30259@wunner.de>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20240227204116.GA30259@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY0PR01CA0006.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::22) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: c66a4e87-4e22-4dc7-5788-08dc3cd9da50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zjn8KuN8i3yglyd5P4fDK+Q0eaB1NwMw1/lEfm7NRbNjiDlGr82jl9Npt/QLXSJjpMHpSD6PrRLWbXj/SrZ3PcUlcg9+VQMe9JdIbgxi/0Iing4PBItr+g4OOlYr3MJmSp5dpSxLst1DiGGdThHYq3smIVqfF7/q9tSqyek6OUE0rk6liNg8d+63hLcJV5ESwldZrGejwnDjnSKPcANkIp8F+2wQpshJ141AsfXIECMGRIbq5P1o0kG0N0Egc9Ng8SlXfQbwdRLiLujgkK/YCrcv3KD++dRLYkRheVYd6KPfryXSCDAEbVgNJwlk0D/uYqBGKw45Q6vuL3yLB8q3zUlEzaw10oypt4j5zLSaTQ/92BaCBzTM5ZFjT947X2Cj+yo+kbDMUEbAP9HwKk4i1Ugc555eckb5YUNFCB0ArJUBPyTYv4LoOYDbmdlnAAbe2TQ9YnQ+OQiZolrvkgYFsNOQUR0p/tXlrylNddxY1nuDS3+bXUTwlHJ2oKwBmuF666HB92Hx3zfYxc7zTr9oIgyBL63Tg8sWjUN/zingLT+w6N92xdCt/62mG/6B9kFuvNZpc1bktT7XMb/gv+kLJFZzxVWWcVB2/RyfGw6aR3nvqHCmOQeoJVBxbBvdC2gItu6PWp0Fj+oEXWZuMiTkzMMEKbYzY6ayAZTSb/ZbCj8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk4zL0dDTFBySGIvamY3bkpnNHlqL0VQNSsrbjR2QTBld29IM0dFaFJ0R1d0?=
 =?utf-8?B?eUk2SHBpd0RBa3BUSC8rNjY2b0lRbGtIb0s3VGUyZE5Qb0IvR1dMTyt6T29D?=
 =?utf-8?B?cGROQ1ZtK1V3WjNtNG01dWpSRlJkZ1MvUGhNVGE0K3hIdGtZSFlZVVRBWHhO?=
 =?utf-8?B?cUFrdzl4T08yRXZpSVV3Zkc0aGtsTkhoWmg3L0tzVjZHaVZWUHFqN29HZ3JU?=
 =?utf-8?B?bTNKMXIwN1UrK1hzK3dRenlMYkVHWUtBME00M0Z6QzVNNWVjc2VPUDVOVjFI?=
 =?utf-8?B?SVN5ajBvOHQ5SmRabDkxVERoeVVvQVpBbnhlSkRaRGY4UExwRzRzU1NORGF4?=
 =?utf-8?B?SmFaSlpQdERick1GNkhGYlRIMm42QnZJRFNPUkxhL1Z5UDhOb2F5Sy84VUNB?=
 =?utf-8?B?aFBHTUxQNUkxMDNUanVCbDQwTzdPeVgyVkRHSzE4U0E0KzNHVmhPeEVlNml2?=
 =?utf-8?B?Z21hNVI2Nm56NjRFcmE1NTZwbG1ROWFWUFRkWXovT0VBS3NQZ2NmNkxrYUxB?=
 =?utf-8?B?WGVQZ2VVZ0U2bmJEMm5pT0g2bUdjY0VvS2xONC9oTUpxQ3FQRDFxMVlNM0Fv?=
 =?utf-8?B?bmM2bHIxT1NxU05kWUZvSXlEWWZneGQrL01nQ1dqa214LzA2eHdDczNUOURi?=
 =?utf-8?B?RmR3eW40enErWnhwd1JCc0ZjRk5QK1hJeUVRWWxBMVRRcXg2anVoVnoxRlpH?=
 =?utf-8?B?TUZIRkl5TkJTRXFRTExQdHlBbWU0aUVnUXptM1VLL2kwS3FqcXpTZjZPVzhw?=
 =?utf-8?B?MjJjZFI5bmVHZ25IdnhmYjhDaFF5S2UwWG96L3RXbVR1ZXAxNE11VWtPbEh3?=
 =?utf-8?B?a3YybW41bUpMelBHZVNDakF4NjBpbzFnamg5WExkMGR6Wm44K3dqOE9rckQy?=
 =?utf-8?B?OW1kSlYwSElBK3hWSmJqN0xiVzZKcUN4cTdMUVE5TVdYV3A1RzUrRFlycE1K?=
 =?utf-8?B?dkx3MGdoazdadFVnS1lvamZXWW1HZS9oWE1ocmUwSXNzRzdQanJQWm95Ujgr?=
 =?utf-8?B?L1RQRVF3dERja3hxMTBPa0kwcFhGU2xoYjVJUjN2dmF6d0t2amd3UnpOWkhr?=
 =?utf-8?B?VEtlSHJYemtqQitnSmhCNHp5NlNHYVpxcnZocXFvVFA2NWM4VTlQdExPNCtl?=
 =?utf-8?B?NkVWdnJ4dGU3aHhlU0lYTU10L1BqdmZjVitycUFvd1pCbUdwRm5KMlBQbHlL?=
 =?utf-8?B?bG12T3hLbkUzbU53UmJuV0V6b25mdHc3YkFYbDZWZVUxTTBSbnF6bEdxUS94?=
 =?utf-8?B?QUN0cnEyMFlNRjIrM0JxYSt6S3JjbUtOTWs3ODc2R3JKNFhrcmttTExxYnV6?=
 =?utf-8?B?d0JFamMvcmdwNWtUc3VtYmF4MWtKQ0hPWEZrSGJoNytlNHB3OUJ1WXNZY0da?=
 =?utf-8?B?bVZUVElVRWgyREhBR2Ivd2svekJHdUNFQitiZUY5UmhCR0JhUnpkNDhSYlJ6?=
 =?utf-8?B?MGovZ3Z6WitCUDVhek15V1p2QUZrRTJOWW5vTEVaU1E2TGRkUjhQVVVJaVZ4?=
 =?utf-8?B?L2dsOWp5WUtiOXNlL3VPQkp6SFJVRm1zbndpNFlpYTNtZzJYYzQ3OEpUdGtN?=
 =?utf-8?B?T2lobzJEY3d1T05MZkNtVmF1WGVla3R4Y1RicG4rVWpMb3lyOG5JTnpidlNx?=
 =?utf-8?B?dDdEeS85UGRkSmREdEZ5SmNyQ1ZqeERsTlhMb0xpMGRjR3BoLy9VZVYzbFNR?=
 =?utf-8?B?YjdTU3BKbTAzaXAvS2t5MHl4aDEyaVViVHd2bHA5UG1qSTBNVTM1VHJMWE9n?=
 =?utf-8?B?YlRWdW9CNGpGUnFNb0NTcFpFSjFmcXRIRUFtbmM3dTd4U1RlTDRvdlIyZWZa?=
 =?utf-8?B?T0t6aTl1M042ZjNFeXhUTjdrTEhva3JpbjlGaU1PM1NNYTd6VkxkMGZkamNF?=
 =?utf-8?B?NE1VZ3cwUGw3Q3RMZGRGYlBUWDV4MFhvY2lSY2xXVVpaMzV6T3lZQ2FUQi9x?=
 =?utf-8?B?NjJFT1NIY0dtb21jZUhhK2RHdFRPS09WQWFrVHB5WXBock5sL0ZxS2tRK0Vh?=
 =?utf-8?B?VGptcEZGTG42OEJ0akRQUStZL2JqVTJVbGNSbHV5S0lleEFRWGNQM2xNSWhj?=
 =?utf-8?B?WjNOaklUVlZJaXlmVWdRbkI4VzFWNGZPcTlGTWtFUGpCT3NwT2ZlNzdzaHVl?=
 =?utf-8?Q?lBZYyf8lV/BRSTMxXQZnEWP/Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66a4e87-4e22-4dc7-5788-08dc3cd9da50
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 06:02:35.1118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtRbTSVNnfAZ2VSuCtK5xq/E69AIUxqHPSZ3T4xQVFlrWmb5I1+kIOis5ase1qiTwCsAg/3ApwOKPylnyutmng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873



On 28/2/24 07:41, Lukas Wunner wrote:
> On Mon, Feb 26, 2024 at 02:31:14PM +1100, Alexey Kardashevskiy wrote:
>> Does PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER need to be in pci-regs.h?
> 
> Yes that's fine.
> 
> 
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1144,6 +1144,7 @@
>>   #define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
>>   
>>   #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
>> +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER	0x0000ff00
>>   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
>>   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>>   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
> 
> "DISCOVER" duplicates the preceding "DISC", maybe just
> "PCI_DOE_DATA_OBJECT_DISC_REQ_3_VERSION" for simplicity?

Well, mostly because the PCIe spec specifically says "discovery" in the 
field description, not just "version", but ok, I'll drop it.

btw "DISC" is just confusing, it has nothing to do with discs. _PROTOCOL 
is not even correct anymore, now, in PCIe r6.1 it is called "type", 
lovely :) s/PCI_DOE_DATA_OBJECT_DISC_/PCI_DOE_DISCOVERY_/ (because 
DO==DATA_OBJECT) imho would do better but may be some other day.

> 
> 
>> -static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
>> +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8 *index, u16 *vid,
>>   			     u8 *protocol)
>>   {
>> +	u32 disver = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER,
>> +				(capver >= 2) ? 2 : 0);
>>   	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
>> -				    *index);
>> +				    *index) | disver;
> 
> Hm, why use a separate "disver" variable?  This could be combined
> into a single statement.


Less ugly since we want to keep it 80 chars long (do we, still?). Like 
this looks meh:


{ 

         u32 request_pl = 
FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
                                     *index) |
FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_DISCOVER_VER,
                                     (capver >= 2) ? 2 : 0); 

         __le32 request_pl_le = cpu_to_le32(request_pl); 



If we did 100 chars, I could do:

{ 

         u32 request_pl = 
FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX, *index) |
                          FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER, 
(capver >= 2) ? 2 : 0);
         __le32 request_pl_le = cpu_to_le32(request_pl); 




> 
> Subject should probably be "PCI/DOE: Support discovery version 2".

> Otherwise LGTM.

Thanks! I'll repost soon.

> 
> Thanks,
> 
> Lukas

-- 
Alexey


