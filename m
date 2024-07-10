Return-Path: <linux-pci+bounces-10089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB0B92D69A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 18:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38179B26470
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FD4191F8E;
	Wed, 10 Jul 2024 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4YmfZ0p6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4268C194A66;
	Wed, 10 Jul 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628920; cv=fail; b=CpouSd0T3kbrJUupGeBBMu3G3pmRt9gfBSDHLR5NFOeEHlSVraq+Tyq2dWHLaklA9WvOPUCNuSpVnKzx7Nyo1+sdFIbAC+jQ+Q5PCV/ewU1kYvJzFTfgccfyR5owfTx/BwaDHGZ8CkBtrHEQI1qEYnq7aRvLBupKS+hFw797qDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628920; c=relaxed/simple;
	bh=E2fhUII02KmOskJi5b1c/VwLh5zB1JoeMnixg9EN7so=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JI7fGKc6UQPi2Soba3aMSvJoudJOhFbBlkIVZsYhGBW/HwnFfrR72umP5RZJS+snING22Hk3FZeBFF7htSYDiTmYYLk3emAw7RTjgLMhf8ub+Y+D1tBhSW0ChydIXPufX/IgbonKj1pp13PXq2CzHWLhxS7bqX7j4pDiukd0xeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4YmfZ0p6; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QG+zMXiEmySTkhJLBOigNRbLzJM21dYzhLlt2+j3NhxQw//YTTqJfAhIbMsGlHXVu9Zu6ZZaHc8LNifqhh8ZSmF9ose+vFjM5t2qawGvepGe0DNDF2chkUhZb2rtgbqOZFcFNxMo/HFhTK3ffgKlBUyDbPnDgLbQlkJBfH0CiQeb+SlGyRGcNAw3pTHNX9Ict3rQsAxdNfiswy9aihGtQifAnZ5uYvkBRrGstRbQqGiHs8bSmREtOO7CNZmqyAV24raTxdpQvrgtkxTb/mI/kM/hFpttgTIpY19IuFbLM+eO84ixGlm9MughIyLYQ33Z8E+hYZ/WJJZ5NsHq7BAygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCSVvOp4cUj0PpneMl1yesVt98FI8o0XKQZ31d5McxA=;
 b=LDIH16cXS+BKO5gdoMDYSLksmE91vt2pbKJrOxyzjiiCAKF2djMHZAoJqJQgdnJHgwEZO7zKRkyC50GVlVFi3sHHnMHcCTKOCuvhehHY465dn6hZRa3y+L+rLBc9gk8fzHkMtuYmK6Oinj/aLgWBgPzq3WH4BFtnNBVeRugfaitcUoTsfbXfGAWujc2Q5U3SKBxI6z6ripG2azP9ostyAhbHX4dRAx6jd05CDGU0bPEB5+eoP27qCOuZKD/3mvOQJyVBYGk9KqFoRSt0LpgfBrf8JdyN6GQG7TPukoijnSdKjOWMKSyy61n6hHEMA/hX7HXHBXPzb+JpU4C9Db8njw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCSVvOp4cUj0PpneMl1yesVt98FI8o0XKQZ31d5McxA=;
 b=4YmfZ0p6oHhHmZqO2iV/+4Q5GN3GIIgnEUDLKOURFL5D2xsnPHeOG0JihyuIURzSu/+xxqeh2VZVeMRUaa6EG42kjFLWG3Nw3eJTdvtSIvBAa0TsIfFGymjMCm29OD1oxkZDnbRQfgMC3IrwSytAWFSGW7OA7t0kpz6xUxZ6S/Y=
Received: from DM6PR01CA0028.prod.exchangelabs.com (2603:10b6:5:296::33) by
 SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 16:28:36 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:5:296:cafe::bf) by DM6PR01CA0028.outlook.office365.com
 (2603:10b6:5:296::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Wed, 10 Jul 2024 16:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 16:28:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 11:28:34 -0500
Received: from [172.25.198.154] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 11:28:34 -0500
Message-ID: <4180d699-8f26-4882-bc0c-9e4b4c46645a@amd.com>
Date: Wed, 10 Jul 2024 12:28:33 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] PCI: align small (<4k) BARs
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240709133610.1089420-1-stewart.hildebrand@amd.com>
 <20240709133610.1089420-7-stewart.hildebrand@amd.com>
 <302bd9a7-41cb-7b04-4acd-a4a96d5dfe2f@linux.intel.com>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <302bd9a7-41cb-7b04-4acd-a4a96d5dfe2f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4163b3-a9b3-41e8-e077-08dca0fd58df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUVMTDlvWmJ5bmhyVTZLL0ZpSkh6UTQ1T2dxL2hRYlEzb3ZyRzY2MHArUExr?=
 =?utf-8?B?MFNRa3prSTVmQk94ZFRObHU5TElpZXM1aGl5MWxMSndheGw5TDJLazVuS0Qv?=
 =?utf-8?B?d2grQzhMOUlEQTRGTWYrT1hqQ3hsVDRlQUZ2aHUvZDFkNWxyZi9wTVY4bjBO?=
 =?utf-8?B?OWRsUGlDM0Z6clZmcEo2NHY5YUc3bmVkcGlMQ1JMaEYyTVhUWDlhMndjNVFP?=
 =?utf-8?B?YkhCcldqcEV2cXZ3OFBMRHY1TStDZjlLU2M1d0k5RTNVbWd2d3dDVjBxNy9k?=
 =?utf-8?B?eFNJNXpBbGV3aVVwdjhyOE4rMGhWN2FjWmQ1UmdVN1NIb2lKQ1h0SXduSWlu?=
 =?utf-8?B?dWcyRzhnMldRaEdyRHVvektQb0h4Wmo4STUrOE1jTHhBajhpNWJhM2NveGtS?=
 =?utf-8?B?UWtrbTFkOXgyRXlrN2o0Q3JNVktmMHpiclk3UTBMZUpySkN5RktMd3pyUWsy?=
 =?utf-8?B?UTU2anVYcmRNR2hxYXlrcTlsYXQwSzg4bEM3eW9wRmgzTUF3WXRTemI0YWlW?=
 =?utf-8?B?eU5Ud0NLWGVKZHZUN2x2QUw4K3NNdnc0YTRtU2xTcVcyTmNvRDArcWxtcXNF?=
 =?utf-8?B?dUFnQmoxZDdOK2VoVmpHd1dGL2RaalBUM1RyZE5OQjM3QWdVNm14NDZWeHF2?=
 =?utf-8?B?N0RFaytwSFY2SXI2TXhOdTR0amtvTE8wV1UyQ3RrN3V1L0QrR0o4UGRIMFU2?=
 =?utf-8?B?Y0Naemh2ZTliOEhxZXNOZUYxYWJ3dVQrK1FHS1AvMTVjeVFIU3VGbS9NL09z?=
 =?utf-8?B?dzV3Um9ydDVYNGwzMHdLNWk3citUMkdDRnRROEM3MGpGSGYza3dwY3RMWDlu?=
 =?utf-8?B?Y1p3UTN2cjlOR0FacHdLalJobWlCOTNZTDdyeHYva05jczlSN3ZQYis3TEth?=
 =?utf-8?B?YWNwYXdSbXpCMW1mSzFscXBmdmpNOGFVcTFqREdBL1NpcE1yZ1hmMEovTWJx?=
 =?utf-8?B?dlJHTy93T3BScVdrL3ByWktReGVTdElKYUlQTkJtMXd0OFRnSkhycURqVVlJ?=
 =?utf-8?B?RzJJMlY4ZjZOeGJyNHg2Vkp4RkpPQVczcWRlVlZOOVNERjFEUUJwRTVnbWFE?=
 =?utf-8?B?aHo0Z3Z4ekgrKy9MNDBGV0FCNnl6M0pIVllIcndJd2xFLzJ3MHJ2aGpUaVIv?=
 =?utf-8?B?UlIxS1ZrUytpWUxoVVVZMWRYY0d4YytqRzNadGVDSERqeEdEMjJvZWExNHcv?=
 =?utf-8?B?enBmeENMVlRkUG5ESnhrWTR2RFpuVDdFeEpCNWp5bm1xMVhBNWh6SVNjOUZa?=
 =?utf-8?B?SjltTVVlWnZORnc4N1N1c3ZrYTRxYTRVTzQzUHp3Z0s3Y3pZa2kzU3U5TFBN?=
 =?utf-8?B?a3hEK3RrS2svS0pBUWUrQi9YWEZwMUt5ZCtSc2tGZTBXRExZQ0R6L0VwRTVh?=
 =?utf-8?B?YTFWQitRU2JyS0UyTUpWYmU3YkdCN01JMHdHM2I3b2xaMHdaS203MXNIVDZ0?=
 =?utf-8?B?YmV0eXgwL0pTOEppOGwyUnNtbjhQbk9CUS9KN0RyMmxsWVZMNjgwbnQzeTRV?=
 =?utf-8?B?T0xLZlJZV09CdE5QdW5NamNKbk9aM05Hb05rM2ZtZS8zT2xkcXgzR0h6TytW?=
 =?utf-8?B?N2lJNHVKbUk5ekZxVGdSaU5oR2MzUzdQWUowVklGaWpxVGlBY3phLzVBMnJw?=
 =?utf-8?B?TU9KenVsVGxJaHNUY0NFamlHZ0dpWlZwaGt3bWU0UzJ1SDZDTnhqWXljYjJu?=
 =?utf-8?B?V1c3S2cwS3EzK3RtSHE4ZXNGbjE1b0lRS1BnRXZvVlJNNnpXYW1qMG8xc3lH?=
 =?utf-8?B?OWQzNy91M04veFo2SjlWdHo0WWFwVDZJL2hWRkhGcURFUnpkNjNjQmFhbURJ?=
 =?utf-8?B?L0N6UjhNNnZvTjgwOHVKVkptUjljU25yL2xJS09JcjNZeXEvZmJNTnBHaytT?=
 =?utf-8?B?WFB5OU9BaU9rZ0hiNmIwMHgvdW83WXpsa1g1TkpLaFlPTWY2SFRJVWFKSTRq?=
 =?utf-8?Q?gLgKz9Oc1fU3WIvtTCdj5ez7cohYUtTo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 16:28:35.6286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4163b3-a9b3-41e8-e077-08dca0fd58df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

On 7/10/24 09:56, Ilpo Järvinen wrote:
> On Tue, 9 Jul 2024, Stewart Hildebrand wrote:
> 
>> Issues observed when small (<4k) BARs are not 4k aligned are:
>>
>> 1. Devices to be passed through (to e.g. a Xen HVM guest) with small
>> (<4k) BARs require each memory BAR to be page aligned. Currently, the
>> only way to guarantee this alignment from a user perspective is to fake
>> the size of the BARs using the pci=resource_alignment= option. This is a
>> bad user experience, and faking the BAR size is not always desirable.
>> See the comment in drivers/pci/pci.c:pci_request_resource_alignment()
>> for further discussion.
>>
>> 2. Devices with multiple small (<4k) BARs could have the MSI-X tables
>> located in one of its small (<4k) BARs. This may lead to the MSI-X
>> tables being mapped in the same 4k region as other data. The PCIe 6.1
>> specification (section 7.7.2 MSI-X Capability and Table Structure) says
>> we probably shouldn't do that.
>>
>> To improve the user experience, and increase conformance to PCIe spec,
>> set the default minimum resource alignment of memory BARs to 4k. Choose
>> 4k (rather than PAGE_SIZE) for the alignment value in the common code,
>> since that is the value called out in the PCIe 6.1 spec, section 7.7.2.
>> The new default alignment may be overridden by arches by implementing
>> pcibios_default_alignment(), or by the user with the
>> pci=resource_alignment= option.
>>
>> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
>> ---
>> Preparatory patches in this series are prerequisites to this patch.
>> ---
>>  drivers/pci/pci.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 9f7894538334..e7b648304383 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6453,7 +6453,12 @@ struct pci_dev __weak *pci_real_dma_dev(struct pci_dev *dev)
>>  
>>  resource_size_t __weak pcibios_default_alignment(void)
>>  {
>> -	return 0;
>> +	/*
>> +	 * Avoid MSI-X tables being mapped in the same 4k region as other data
>> +	 * according to PCIe 6.1 specification section 7.7.2 MSI-X Capability
>> +	 * and Table Structure.
>> +	 */
>> +	return 4 * 1024;
> 
> SZ_4K

Ah, thank you! I'll fix.

> 
> + add #include for it if its not yet included by the .c file.
> 

I'll add #include <linux/sizes.h>

