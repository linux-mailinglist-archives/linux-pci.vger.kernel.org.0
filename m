Return-Path: <linux-pci+bounces-44409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 196DAD0C386
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 21:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AACC3006E2F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464B12C08D0;
	Fri,  9 Jan 2026 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xja9OdqT"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E51EE7C6;
	Fri,  9 Jan 2026 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992127; cv=fail; b=BdtrpltXdA7sqotK73FD0gkE3Zc/jXOu1NKyScfD9R5VlDlycoJ+O0mjyiBqfDv22n1Yif4HvZMr9egC+Cm0VvICCT1Fna4utvsnGgK+cs6bMkrHknbhcJrPW06te9aRH99AmSVH+8CVHBaoTsi+g5oN0vaP96PTJGwVjNkvSwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992127; c=relaxed/simple;
	bh=fWaIt3/GfjcQ7NpEfc7C4a6eutL2szoBcnkfNW4E3p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vCIuG7azSlLaKO2mAw1hLkKkQGDWdKkJfB8mkePCmhQrF9XuLGEoDZy9gF7qL05qwm3TbhxIuB9PYW2ROoQt8WR2tPN8khdx7VARy9ndUKFZEParg9PAs2VIoJQn9qWNhOYvq7d4CKH5hwY0hxxMYQbIdFTOL/byoSb0fzxBgIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xja9OdqT; arc=fail smtp.client-ip=40.93.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLYt69jXGI53K5ezeRRiBWlSROl6R2J9C4GsWk1bKRg2PKDcMGiNnwQAYtJagtRQRjfzOkorsmS7gwC8IjKF5n5vhcgfoTFm55i1UUxZpahM83TP6JRJL6zX8ZXr9KCIyVTt7+86ZqDFTRGRQXZwemHTsp/7JBqJAZPKPlH3a1QiUnhAPZ8DSd4K/U8OV2f5XFermmoCQOONLdgUnHUlidcj6bSDOhghzlRJd1qzX65PK8Ex6SD7JICQBQNcGUKWzANjrv4H+XSiiuA59CxCU90T/d2CNmq4MJuvUbZdyg8eWkH830q253QEvSipcweNi2EJ/c2Tk0OwmfFleaBG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwGtPLkS14EvuzTuhy7wvs7u6HmzSBVO6Id0k47mW7I=;
 b=eNLpcYb9Cemq/c7vSrU4loy9hoRnlTjkjWRtxZC5afOreK+9546OK2ZeViPrfH6+W+gJ0BvREo2hsJMzVXkncrHURVKWwZ95LzKjBuOfj8H4oxaB52ftGoezM2eKV8/ZzpCjgSLpHNjcmOj63k3Prt8MA72cujrBEFVRHZST0hxeKoBthjg0y03rlPLr43Co+hlAuq+iow09MBMxulJ4VT+7e/96T0mByD/hylsgNehNPitTIVtvHI1fpcUzj5kSa0XqcEpnSpjDeZbPm+L0tc/g6hC4tpFPCtvKJgtHKYjKraart3UVmwUMwp9waOMWJXhfpILdroOLdh8JQW9kCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwGtPLkS14EvuzTuhy7wvs7u6HmzSBVO6Id0k47mW7I=;
 b=Xja9OdqTt+KKeAg3OwkRyBzSpm2pajf25l32bqNSC1fjnxj8+A1gUj/aFhmbli2vqEjf5SxxVhTjZD34UM/8gTJ70xQ2PVXdiepBfjb52H9lFKEvqtPnA6bM+X73hwl1eARPt+UKHvDU3wtIomyunLBm7VmPLiTH1apF6DWjwD71UWYcS4YS9RclJIR+uH6heDqXxyDSvK4u43GEFc+esMZdwddsx6g2LKhrvGqVFRM5Xj+E280kerdyg4EZd3RejPbwHO5Dmld54EV/oEHSmWQJ7B6/dGoBvixc5xUikcw9hjCYe+3OGSq8CcDOq/YHqtHM4ijMS1U50AM6DyH/tQ==
Received: from SJ0PR03CA0380.namprd03.prod.outlook.com (2603:10b6:a03:3a1::25)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 20:55:21 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::ee) by SJ0PR03CA0380.outlook.office365.com
 (2603:10b6:a03:3a1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 20:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 20:55:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 12:55:01 -0800
Received: from [10.64.161.125] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 12:54:59 -0800
Message-ID: <d497553d-9737-4cb0-9fbc-ca929fec13f7@nvidia.com>
Date: Fri, 9 Jan 2026 21:54:52 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: Add ASPEED vendor ID to pci_ids.h
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, <iommu@lists.linux.dev>, <jammy_huang@aspeedtech.com>,
	<mochs@nvidia.com>
References: <20260109202636.GA561851@bhelgaas>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <20260109202636.GA561851@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 2561e50f-fcc1-4b6e-3eee-08de4fc166f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm9pdldCNE1XZ2xWSnF6U2p3SmYyRCt2ejhUcGlWMFFDd1c0bm4vdXdPMjVL?=
 =?utf-8?B?NXJHd0RmR2FUUTJoLzdvN1dINWtIV0doSnRlSjV3TktqYWszR1dPR1J6YzlE?=
 =?utf-8?B?UWZtU09VN3paVzJ6ckN5cnpXbXlnclZZZE42cmhvL2NiZG1Fc0RZNVI2dXpr?=
 =?utf-8?B?bS90K1ZwS3FtVXB4bHZ5SnJEdXduakVxVDJuSkhReHNkU015VVl0VEVESENx?=
 =?utf-8?B?bVVmK0lwZFFEOUs5K0xmL1JVbTVWR0RCVmM2OENyb0djdFpnNUE4R0hxdjI1?=
 =?utf-8?B?VzR3NWFVa3JlYXE5M2o4Nlh6TlNCMUk4VVhEVDIyTFlzS2ZqdUpobGE2aGNN?=
 =?utf-8?B?eERXekdEZFY5czVOaXFBM1BmdHU4V05tczNNZmhNdEhMZFdZR2NTUWp4N0w3?=
 =?utf-8?B?RjRaeEZkcnVVS0tET2lta1Roc0M4eHdZV1pROEt2WDRuU1d6MjN5ZzlkdEFK?=
 =?utf-8?B?UlB3b1NMT3JuWXFCTnhoK3YzSWZNQkJqa2JwYkFqRFBzTnlzRWhSY1NkQnEx?=
 =?utf-8?B?MzV5enlXSVBISlVJeStvMGRPWU5CVlBMcHU4MENUYVlvSHBTc2RjanI0QVdS?=
 =?utf-8?B?WGlwUTlRcEo3NVVWNVp6NytDZlBSdFYxWm9ULzlGV0FCRldSdUZXNi82OVp4?=
 =?utf-8?B?bzh6MU80VFpWcDVKYjlRQ1NBS3R2UEhEL2dySHlPbmlCSjBRRlNVQldaREhZ?=
 =?utf-8?B?clhlL01RYkZNQ0dTa2hLbzZUWUd1cVgvNjQyS0phZ1RuektQK29PenYyS2xs?=
 =?utf-8?B?c2dnRVMrdGZ3UnBiWFllYmc3aUNoUDBmWTF5dlRjSlFIek9GUkNVM2RzYjhu?=
 =?utf-8?B?bWVOalRPQ2lid1gyQWZqRzVmZ2hKM1dUVzRNd3MzNkp1a1lWdjl0V3I2M1lZ?=
 =?utf-8?B?SnpVV21sbVlvakc4VkhVMm5LU0EyU3orYTRnR3I5bDZZamRKR2dpYXE0c3Vn?=
 =?utf-8?B?WEZLV0ZSZkl3eXpTNlQyTm5IYjBncXVucy9oVUI1Y3NHVDNVUU0xOVlYbmlz?=
 =?utf-8?B?OGQ4STJlSVNMdEpPbzJrb21kSUNnajRzQ0Y3U29UTUQ2L2VMdHk1ZW1hOXRC?=
 =?utf-8?B?c2VLUEFCMnZ2V3hnTEUzcXV6WGpyNzNnYW80aFYrdVN1ZjFEdkdnRlF0TklX?=
 =?utf-8?B?MUEvdENqVkFDOWhnZmFSOVpWMlE2ZEN5RHp5REd0R0VISGo5am8zK2pOQ29V?=
 =?utf-8?B?bmNXYVNlYUttc29DQTlIM0dydHloVC9Ja1ZIdkRoclcyZFdVUkN5RGsvZWwz?=
 =?utf-8?B?ZWE5R25XelpOQVBBQnpzaVJOdVZMK0I5cGNxdjlxeXgrQmJXZzhIZzE5dnZC?=
 =?utf-8?B?K05hd09LSVVXSThzQmZaMlIzbjJ3dkhUVmFiKzJSZlVUU3V3a0ZGSEFWV2Y3?=
 =?utf-8?B?ZitzeHR0ZTVWUXhpKzE1RkpnRmNsQnVlY3BUdU1TOHVReGxKV1QwUEVKR0pX?=
 =?utf-8?B?a01oK3NRanF3Q0FEc1lsbVVqZ1VGRm1Nd25vbVI0RjY3TmRuSW56Z09LamRx?=
 =?utf-8?B?N2R1ZEs3SytrcVNQZDlHRTE2RDgzV1lSS3ZZdFdQY2Vyak02Z20wV0pFZ2Fw?=
 =?utf-8?B?Z1YwcFRJTGdnR0JBQk1QRG5JY3hoaFExT29icjFwMGpOWkFSMVdGT25UL3VT?=
 =?utf-8?B?dU5KRzFsTFBMWCtWejYvWk1SK3I5R3dra2FYeEVBU0J5UG5Ja00yNFY5Z3dp?=
 =?utf-8?B?eVpyeUpCM095bjdQdGpMMElGeVB1UXhFKzkyVUJZMzhTTXRIMWRkRkxzTHFW?=
 =?utf-8?B?S09ycUlhUTJqL0ZnTWJKR2xxcGF0MzlFVUVTVmVFWkJDNkpjYmFoK0ZXRGZL?=
 =?utf-8?B?SGtMZVA0M3hSV2h2VjUyYU9Ia2ZZTmlOUHZleVFpMnBOYVowRHRjRjI4dHcy?=
 =?utf-8?B?Wi9GS0hBOWllek0xTzFiZUdUbFhVZk1KMjNNNHdudmFYUkVWNkwrSTRkMVEy?=
 =?utf-8?B?TkR3c0Q2MkI1SnpFNlZZUnpkVFFmKzFkNnYrZDZSdGlic2tmZmcyV0F2VDk0?=
 =?utf-8?B?eGM1MC9qSHBJRHpQc3NZcXZTVlBmc1ptM0hwM2Z2MHdDb2pOaDlmWHpKY1NH?=
 =?utf-8?B?aDU4cmJmaUpONTg4ZmNZbmpUeUtUcUVWL0pRdkUzeHVQU1BoVFIvSHE1cHE5?=
 =?utf-8?Q?DTqU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 20:55:20.6355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2561e50f-fcc1-4b6e-3eee-08de4fc166f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927


On 09.01.26 21:26, Bjorn Helgaas wrote:
> On Wed, Dec 17, 2025 at 07:45:28AM -0800, Nirmoy Das wrote:
>> Add PCI_VENDOR_ID_ASPEED to the shared pci_ids.h header and remove the
>> duplicate local definition from ehci-pci.c.
>>
>> This prepares for adding a PCI quirk for ASPEED devices.
>>
>> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> Applied both to pci/iommu for v6.20, with
> s/PCI_BRIDGE_NO_ALIASES/PCI_BRIDGE_NO_ALIAS/, thanks!


Thanks a lot!

>
>> ---
>>   drivers/usb/host/ehci-pci.c | 1 -
>>   include/linux/pci_ids.h     | 2 ++
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
>> index 889dc4426271..bd3a63555594 100644
>> --- a/drivers/usb/host/ehci-pci.c
>> +++ b/drivers/usb/host/ehci-pci.c
>> @@ -21,7 +21,6 @@ static const char hcd_name[] = "ehci-pci";
>>   /* defined here to avoid adding to pci_ids.h for single instance use */
>>   #define PCI_DEVICE_ID_INTEL_CE4100_USB	0x2e70
>>   
>> -#define PCI_VENDOR_ID_ASPEED		0x1a03
>>   #define PCI_DEVICE_ID_ASPEED_EHCI	0x2603
>>   
>>   /*-------------------------------------------------------------------------*/
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index a9a089566b7c..30dd854a9156 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2583,6 +2583,8 @@
>>   #define PCI_DEVICE_ID_NETRONOME_NFP3800_VF	0x3803
>>   #define PCI_DEVICE_ID_NETRONOME_NFP6000_VF	0x6003
>>   
>> +#define PCI_VENDOR_ID_ASPEED		0x1a03
>> +
>>   #define PCI_VENDOR_ID_QMI		0x1a32
>>   
>>   #define PCI_VENDOR_ID_AZWAVE		0x1a3b
>> -- 
>> 2.43.0
>>

