Return-Path: <linux-pci+bounces-31067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F825AED6B5
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 10:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2333C3AD045
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 08:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6777B226165;
	Mon, 30 Jun 2025 08:08:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022138.outbound.protection.outlook.com [52.101.126.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2979226188;
	Mon, 30 Jun 2025 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270938; cv=fail; b=ZtcsE/Kr+16wQJw/hzutO0SHR11GQhwuQKhaopzSSh9gtarf/pR8FRulLss4IjMl9xeApBL+8OFbN26yasg5/DLTaTFG7GvD8P5QiJbX5yH9tjj7uhZoKdQDeA3NxCSrpYSfGyAuyIuuQg8t4FODZmdOPmlxmR4kUt8h3oOTTvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270938; c=relaxed/simple;
	bh=l3kX32jMkvWEZ6hNm1IfjLd+m0xb4Y1fqk+qRQ4CN6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKSNdi8/1Ne5AB3MtPG7VtJ8h+3DDWZ9PbukrZtfg9OzLUNnY+cBRSYUeWJAV/wxXUa8+b4s3WKJKGtkv4A0UiOX+vpXJdP2/YrAJLlBe53Yt7o1HCtD+HUFd5BHCNow43CBXO8OC51PCZ4XyWZBr478bf8+vrKiaZ9fpMpFeCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8mBB7Dr9sfKQae6SyG3zLiXiMKHXqPxN/S9I6+WdeCKAX8b71c0f+i3T8Sp3jTfvXZztKXREHCLSMc9pWBAfbBWU7Kq3RwIQcQokTCh8BGEsdnHCOnLVOoK3HfzC5GZjwgdgD7tdcFiSVer7/8sDWMrHYESe6ivOnm7y3xQ6/YEHyeuj7yuiQRgz09dMPLHiAgayt3Ky2J5bAgwnn/mgd+sdy4D+tXtHp2vI3f7vLUjjioAXeVo47JbdY/TTCTreyPOo9pS2g0EpIDVqD5fT0pVWxkhouj23XhVFUYowqmsG3v+QIYHHyyAFMMc7wlpsuueetKZ205IgPo14r3cQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgevoxrV7mDFsw48DPlaLJ34GJ4oWoEPiWIlM1Nafgo=;
 b=Rs/1j0yTJ6hcYa1qLHp6bpJun/Tc4AbBAFoqhTWmwSEpYrZNEZ43xixmUyQqhpzCaA3QX1mLWcgPj8OL04WqUpnop/W91/Ay17gD2oTQgDyhQGiU82aYlLY4WhTEt/+G/pLmTtB5YF1rL/uvYjOSE7Xz9jdJ9DJpf3UUxI/R+owJkqI5O7SqiuiJo9NWrvcmPxQnXHtAlteScWAD9teya9EqhhEjnUDhgIGlbCzyetqbhye84taNLsOyEgWr1D1fAzzUYARxbdde/peCC3gXIhir9lMYkUfj3fmEkK3gYwYPBMu+qRWgrbpST+eAW38dyoxup42MSbfmOA/PNhaUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0026.apcprd02.prod.outlook.com (2603:1096:4:195::19)
 by KL1PR06MB6888.apcprd06.prod.outlook.com (2603:1096:820:10c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 08:08:53 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::c0) by SI2PR02CA0026.outlook.office365.com
 (2603:1096:4:195::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.27 via Frontend Transport; Mon,
 30 Jun 2025 08:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 08:08:51 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 380FC44C3CB6;
	Mon, 30 Jun 2025 16:08:51 +0800 (CST)
Message-ID: <d43f0142-3cb5-41a0-a6ae-4c3bd5eee346@cixtech.com>
Date: Mon, 30 Jun 2025 16:08:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/14] arm64: dts: cix: Enable PCIe on the Orion O6
 board
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
 fugang.duan@cixtech.com, guoyin.chen@cixtech.com, peter.chen@cixtech.com,
 cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-15-hans.zhang@cixtech.com>
 <20250630-stylish-pretty-stoat-bde7f3@krzk-bin>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20250630-stylish-pretty-stoat-bde7f3@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|KL1PR06MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 463c761d-9cd6-4e40-1b11-08ddb7ad59e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STNibHdsNWlCallFTmJzbWdHOWdsbnptdGYxbVFkaCtLUmdEakg1dUY5RmxW?=
 =?utf-8?B?elN1dTc3UHJsZUcxbGMxZzJOc3VKTW1vWFBTTk8zY3ZBTVNwdFVENk0vbk5q?=
 =?utf-8?B?QWdjY3NYRkJRUkFsVzg2Wjd6QmJDNm96Q09HZjNtenJpWU83NDY3UytCdDRC?=
 =?utf-8?B?eSt3azY0bHBaRTB2Q1JOZkV2V3FLZ3hOYkJta0ZLYll3R2pUdTZMSVBmZUpV?=
 =?utf-8?B?TTRSR1FGYmUvL3ZFUnlyb1VxMjQzVUFjLzdYWlFMeUkrMmQxWUp2azJwam9t?=
 =?utf-8?B?NDZsY21QdU5UMGNJODFyYUs4SWZEQUc3NDV4dTBYbUdRbVJhWUNGcHNMckY2?=
 =?utf-8?B?RzVYeCtYUk5TSW1YbzFXdnY5dkkwSXQ3Ukc2UU1RdjgxUEFibXY4bjFoUzA4?=
 =?utf-8?B?bCtyZVhFRmxRb05nSGZYNGxBR3pJNTN4SXR0WjlHNS9xM3R2enZEMHg4SGZL?=
 =?utf-8?B?dU9Ma09tZkpjMFhXb3JsNXM1czJYTTNCTFZkTW9WeU9Eajk2eWZtY3VqNEpz?=
 =?utf-8?B?REZpcnR6UE8wK2lpRnJobndhamhPa0hrQ0xuR0RpL09sMm5kTlljWVQzSDcy?=
 =?utf-8?B?NmJid0JOelN0Vm5KdlpEN1JpOU1yUlhVUW1QRjBzY1piVE14Mjh3UU5YUTZq?=
 =?utf-8?B?RE9kTHJLT2pZR2VwRW9zZ2FmYnd3bTJ6OGhML1FaOHl5azVYaDR5NGJ5QSt5?=
 =?utf-8?B?aGFzU2JCZTN2V1BTSGVXcFlUOFRqMEVYbTRNZm9tYk5BWEQ0YVBXVEdhdUJ1?=
 =?utf-8?B?b1ZNcm13NEs0c0NJY0FYS2tnay9NdWFmZzc2N2tmZkhwaksrZVEwdVNONnVh?=
 =?utf-8?B?L1NPY0dOd2UwelJyWGdCTUpVd1BlTVVONm8zZXV3Uk1SdS9OaE1lZWpUWVov?=
 =?utf-8?B?ejhtcG9CaXBXSDgvS1ExOUM3clRubnlPem1Jd05lSnJUSFh2aDZhR29YRGMr?=
 =?utf-8?B?SEhUYXFCNVY2emhyVHA5ekJyYWtDNnpXZXpadlgzZWt0WGpHL0k5dHZ3amc5?=
 =?utf-8?B?U0x2UStRTm11cHM4YjF1dkhoYytscXRrVE1jQ1BRdFhmd1dTQVUrbHJQbkls?=
 =?utf-8?B?K0VIck9qQkZaNEsrSzNJMFNJYmhRTjIxU29iT1l4Zk5GS2QvU3ZLWWg3Y0Vx?=
 =?utf-8?B?cTNONFFnTzk1REE5cG9rZEpIbVYvdmMwa0JqRDhRZnE5NWFFR21vb0I0Y25K?=
 =?utf-8?B?aGZFMnU4NUJzaE5HaVlVZktrNWRQbEF5OUc2cE9wNU5zU3dlbktTS0JIUE9q?=
 =?utf-8?B?RVFDT2pHVGtIVmhXSHZLeVUzR0pwbk11dEd1NUlVSFMxaEh0SlB3VCt5aVNt?=
 =?utf-8?B?OWxSN2ZuVmc0YVVTOTNtSUNJa2tYaVFKS283eCtSV1JYMHUxbE5BcUxCSGxH?=
 =?utf-8?B?Y1JlWlpXU0RzUTFmT3RPWURiNXQzeEI5WThsWlJ2UkZXdkg0RTVHenErUUpX?=
 =?utf-8?B?RjVOdjFBSWI1dGl2K1NDVzMySGUzUHNKQkwwUjBkNFNQVEt2UGNGanZuc0cz?=
 =?utf-8?B?NnNIMkJxS3V3Wll1Vld6Tlk0b1lDUDgrSHdHL0JZTElXRk9MQU1DLzJKN05K?=
 =?utf-8?B?SHlhT2NueXZrZjNDQnlXRlV0M1NyZXNsUzdZMnBhd0s5U21qUENpWVhEeXlC?=
 =?utf-8?B?SkRNeFdSMC92ZjVXSDI1T05qUTUrOFoyU2VqNHNCb0JQblFmdVRvandrVUhx?=
 =?utf-8?B?YWxacUVGYlFTUlVUSUc1N1Vmbms1L2JZTXFqNEZxdzdrcDZlY1hrcWpGOXhQ?=
 =?utf-8?B?dGRlS2hDUjJ0QnlLamQzS1ZiVVZFQ0FZbEF2UmxEd0l1YnM2MUFDUzhzbFdI?=
 =?utf-8?B?QmhTQkFSUkN5dCtkZS9PL2wwTlE4T0xMUDZLVmNoczU0VGtvNkNwTEhqdGMz?=
 =?utf-8?B?aCtYT0N2WkNXaDF3YUF3TmYvYkIwMDRRODJ3eGRkaUw1UU5QS1FxVVBmdDhP?=
 =?utf-8?B?cER5TG0rRm83TTBiTTU3OWU2Qmlnc2E5RUJtNU5OTFZoRnZJcm93WFErY2R1?=
 =?utf-8?B?dUlFMElRZUlLb09UQnNxU3ZWUC81L0w3WVU2aE1GSzUrMkhsb00xaEpNOExZ?=
 =?utf-8?Q?yMET4l?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:08:51.9631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463c761d-9cd6-4e40-1b11-08ddb7ad59e1
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6888



On 2025/6/30 15:32, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On Mon, Jun 30, 2025 at 12:16:01PM +0800, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Add PCIe RC support on Orion O6 board.
>>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
>> Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>
> 
> Where? Please provide lore links. The happened AFTER the SoB, so they
> must have been made public, right?
> 

Dear Krzysztof,

I have replied to patch 12/14. The subsequent versions will be deleted.

>> ---
>>   arch/arm64/boot/dts/cix/sky1-orion-o6.dts | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
>> index d74964d53c3b..44710d54ddad 100644
>> --- a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
>> +++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
>> @@ -37,3 +37,23 @@ linux,cma {
>>   &uart2 {
>>        status = "okay";
>>   };
>> +
>> +&pcie_x8_rc {
>> +     status = "okay";
> 
> And really two people reviewed this trivial changes? Really?
> 
> Plus what their review actually checked? This is obviously wrong - not
> following DTS coding style, so what such review meant? What did it
> 

Will delete.

Best regards,
Hans

> Best regards,
> Krzysztof
> 

