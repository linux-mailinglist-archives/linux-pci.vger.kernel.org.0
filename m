Return-Path: <linux-pci+bounces-41076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E022BC56F7F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 11:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CCA3BCE13
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3F43321AA;
	Thu, 13 Nov 2025 10:38:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022117.outbound.protection.outlook.com [40.107.75.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5DA214A64;
	Thu, 13 Nov 2025 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030310; cv=fail; b=aj2mr6qBIGJ62VmxpyNJlOfebe9jSs/TW1jix9Sg6LvF8Cd+PsDCPbsN17xNCeBZaFGnNJ6CYK1zjwgIM6iOsCExf0ZrNpkSFcNJ0xmtyjLVjKkmAcIySKwYCpqQhh3dRd/Kv3LW/r0R0P28PYxFmR4lGgrEVQLGBTux0EoE6YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030310; c=relaxed/simple;
	bh=DQKzlEwttSCWtuznoxK1lCC7Rf7iCQZzzOQqRfmvVsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eynqXRKojTOB5YFbUtikWX22jttnvkqXOZKNn8ZPBvvWq1U+rBkX3Ak2pNMWMYGi6B1KuZo8vLpGRi59WdkIvZrQ6uy28i33PkfyT1KrUg78k7NyOvRHvC8wsorIOiwSrLc13EDMpk4DJPruh7V/IA7GQV4B6SCsG85pDJq+Z7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5s9917xWoPBK6YSDwcu2QrRLax0//VdegR6dN7DWurTxBkldfPzMWRUTH9jm0TPuZiS7RaRjIXcLgRHSEmlk0TgchmnLBp7vLMJ6SjBQG0FV00+nPKLAcDUk8DSN/5SbiM7dJFeJ5Ub6lMz91LN55/gedE32t+5hB0V53MuI/pfZfHkkBg/FT9acXMt9YuHnbC4h8FCUbhxgyNqqMvVGZnisVhRMJSgiGTY4gqk/2Vllsm6k2pNe1eCLHm9zvu64k4qIHY20CZWYOCAxW7yt9q0b8Mmz5LHd8gkKT/tTLcgAnSB7eC0OA9CSTS+wT0ShL0m2hMqJBWbTfANUM5QDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iODD4cjwT3BBF6BOO1Y/noX2AdzyKEr8wOGO8Is9Bd4=;
 b=m9X+yWNDIYI5WmmQn9YsDQhCdv0qHBR4UzVTY9E07oz48sETkvtiFBc3M055dxj6WA2GKuo7L7CuvHtR009biPIRaXQt6XdQNvamo8AKxIDH6lRIrfWkUN1WyZabAjIUmCJBFvG6HUdY2F2NMsKx1E8pSYzqpha6fM6rnYj33gjCbmvbFfn8ozKGIq41MHxeejzRipZj13NVk6KZlLsxkUUYlXaFHBYjZRHoouR34uOMua0kgkBS3YgunVuw4pHBs822LkjMMRbtQwa3GuhuH2eAqEqE4AxuP9mdezvLHhP3BJY8VY5F1PVUpp67XD0yJfiyfjjliL8+PwycgTvPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arndb.de smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY4PR01CA0028.jpnprd01.prod.outlook.com (2603:1096:405:2bf::17)
 by SEZPR06MB5047.apcprd06.prod.outlook.com (2603:1096:101:44::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:38:23 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:405:2bf:cafe::ae) by TY4PR01CA0028.outlook.office365.com
 (2603:1096:405:2bf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 10:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 10:38:22 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0912940A5BD4;
	Thu, 13 Nov 2025 18:38:22 +0800 (CST)
Message-ID: <da56386a-b6ac-4034-a063-811cd7d71fa5@cixtech.com>
Date: Thu, 13 Nov 2025 18:38:21 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: Kconfig: change PCIE_CADENCE configs from
 tristate to bool
To: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com, unicorn_wang@outlook.com, kishon@kernel.org
Cc: arnd@arndb.de, stable@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com
References: <20251113092721.3757387-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <20251113092721.3757387-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|SEZPR06MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: 7162e3f7-ab1c-4907-838d-08de22a0c530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|32650700017|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TklIcXAvczR3Y1ZQc3RBZ2E2S0RiQ2xlOWhKYmt2YyttZXJuejBWTW5yNEYx?=
 =?utf-8?B?YnVqNW5IUjBXVTFLallXakkza2JHU2FLU1E4QTR1ejZ5TUVUQXMrdW44ZTF4?=
 =?utf-8?B?Z25iU2ZQWUkyaTZpZElVRkQ4NlRFeTl4endkN2F5VU1UQ0FSc0FLV1RaUVkr?=
 =?utf-8?B?MGRJU1E1aUVpMzVwYkhBYWFmeUNwQW9Wb2MvV1REWjJITnVYT3A5aEVpdUE3?=
 =?utf-8?B?Sy9EMlpwd0tYYmhYMU9iMU9sSUdPcmJNTDI5M1M5SENwMFdvMVJmZ0hlTldV?=
 =?utf-8?B?VlM1OWMrZEpOeG5Ka2E4M1pnd3dUeXBFQlZqTUpSWkJwRm9PeUIxc0wzaW9s?=
 =?utf-8?B?YkNjMHZtc3A4MU1CNDRXYkN4MHl1SmNxeFFxSElIa3M5OEw4THVPSHB5RitQ?=
 =?utf-8?B?cFk5RDZoUitTRmwxU2xJL3lXcFMxUEFTc2twdnlKYXR1bjN2c2xheU8rdG5D?=
 =?utf-8?B?ZXY4eTRsVWtweEJwbmN5azdrT25rbHptWkJ3a3c2NFRmeTJMU1Ara28rYk9B?=
 =?utf-8?B?U1ZWck5KeUFvemFwdUZEL1dtcXRncGpUQ1FwQXpSMGtMVmZOZ3NtcVgxc0tr?=
 =?utf-8?B?U2k4MitQL1k1dXpwcVNUUC81QmlRUVpwUWc3NENCOFk0OCtocUk1SjhzUWxX?=
 =?utf-8?B?WEVuenkxUlhiWHIwZ3ViQXRuMjFyZ082aCsrNVlxcVpwSTJqWXBXZ1VjMTFn?=
 =?utf-8?B?ZWN1b3gwN2dmVmVNc09lTVczOVdVQkovRGwzWHNENVc3aVljdjRSQ3R6TmdB?=
 =?utf-8?B?RWJOYkluV0l6QjVFWEtkb0RXL0RiZlJMNUl6RU1NdTB0M0VpbjZPeVVyeCt2?=
 =?utf-8?B?aGZLcmt3OVRpcm5lRVFKdkpOaDBxVHVidWVlQmZ3OWlGcFpxWUVRL0N2Zkov?=
 =?utf-8?B?dkRkNWx0S1BiaUVOa2RQYk9sZThsQ1A3UGZ4NS95STZocS9LMExmaHFZdEF2?=
 =?utf-8?B?SEp2ZWtJbTJrR3gxd1hYazVBMStRb1d5cm1JUHhBZnh4WS8vNFRaakJweHV3?=
 =?utf-8?B?dUJ4cGF4V01GVWJWSk5oUXQ3VFNHd0RZZzhTZS92QTRhbkh4enlqNG1HWjR6?=
 =?utf-8?B?cjQzT3NjSTA3a3hYckRTOG81NjkxWmE4MDJKZUtVdVFxODhhZHVqeTBVbThP?=
 =?utf-8?B?VTBNMStSR3duSzdkT3M3V2JWTEFzQjBXWXBWVXlob3hVbW1ZNkpVOC9QWkhI?=
 =?utf-8?B?RnR5TDROMTgxanJnMlhtN1ZycUFQaUFZR2ZmZm9TbVRkcFZac3RqY0pHZDhI?=
 =?utf-8?B?Y3pvZWRsRDg2R21kY0lpVW4xMktVenNORndpUHorR240bVB3TUJveWlKSzdk?=
 =?utf-8?B?WHpLNjNvcnRzN0MxSnRrTldJMEp3TFlvRmpaMXZiWkpSWFluZkRkTmkrUkJa?=
 =?utf-8?B?YkZqZDJITkNtVVlTMXRpYTMvZUw0WmVzZmdQVm5ha1BVdEQ2cjNhbkx4aDRo?=
 =?utf-8?B?dEh2ZWlmSVNkQXB6ZjNidXpOY3J1OGtpaXB1WlNMRlRxd0N6TVVONnZMSW1K?=
 =?utf-8?B?bkhCVTNOQktvbjFsWm0xWnRVdkpWV2c1NitZejdYSGd0K0Z1ZEtrSjFvRE5w?=
 =?utf-8?B?V0RZUURQOW52bmY3RmVKSXo4SDY0ZDY2L3FtTktRaU5QS1Z2S2VLSGx4dCt0?=
 =?utf-8?B?Y1UvaWJ6Z3FIOFJkcXVqV3BOY2RTK3ZTZW15YzlhYit5bHo3d0lQQkthSVg4?=
 =?utf-8?B?MGpyU3N2bFBhQ3NWUHFFVkEyaGZUbEdBOEJtTHVVRjRhV1AxMnRQZlFpRzIy?=
 =?utf-8?B?UFNTSzYvcTd6d1U5SDlHZzNHcTdrcEFJTUVsN3l2L2h2bVc2bnY5TFhZOHA4?=
 =?utf-8?B?YUxWdm1OQW5PeTN0R2lyb3lJMlFxYk55dDNhTkFEeXZCUEprYmp4bGtEQ3Vm?=
 =?utf-8?B?VnR6VUs5OHJ5bmVuRGFUMGlCbUhCWjhob3RwS3RET3NKRlI0OGUrTnFHRG93?=
 =?utf-8?B?WmFNNm5CdTN3T0hlUVkyS3V4UEVocmVDMHVUdUhnQVU1VEpWMXpRQVY2T2Zl?=
 =?utf-8?B?eWFsQllZdWZKcldhOG1vYkRXUkpUNlMwR2tBM1FkazNuckFlZlVHdVlHd0h1?=
 =?utf-8?B?L2xvdGFDRkZCWG1kelNqMzkwRTE0QnZacUp5b2dPdE1KeE1DUlFaUWFobU8y?=
 =?utf-8?Q?zXl0TICyIGgWAtF4mBoWc38Vd?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(32650700017)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:38:22.9384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7162e3f7-ab1c-4907-838d-08de22a0c530
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5047

Hi Siddharth,


Your patch repeats this part.


https://patchwork.kernel.org/project/linux-pci/patch/20251108140305.1120117-2-hans.zhang@cixtech.com/

Best regards,
Hans

On 11/13/2025 5:27 PM, Siddharth Vadapalli wrote:
> EXTERNAL EMAIL
> 
> The drivers associated with the PCIE_CADENCE, PCIE_CADENCE_HOST AND
> PCIE_CADENCE_EP configs are used by multiple vendor drivers and serve as a
> library of helpers. Since the vendor drivers could individually be built
> as built-in or as loadable modules, it is possible to select a build
> configuration wherein a vendor driver is built-in while the library is
> built as a loadable module. This will result in a build error as reported
> in the 'Closes' link below.
> 
> Address the build error by changing the library configs to be 'bool'
> instead of 'tristate'.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp@intel.com/
> Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>   drivers/pci/controller/cadence/Kconfig | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 02a639e55fd8..980da64ce730 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -4,16 +4,16 @@ menu "Cadence-based PCIe controllers"
>          depends on PCI
> 
>   config PCIE_CADENCE
> -       tristate
> +       bool
> 
>   config PCIE_CADENCE_HOST
> -       tristate
> +       bool
>          depends on OF
>          select IRQ_DOMAIN
>          select PCIE_CADENCE
> 
>   config PCIE_CADENCE_EP
> -       tristate
> +       bool
>          depends on OF
>          depends on PCI_ENDPOINT
>          select PCIE_CADENCE
> --
> 2.51.1
> 
> 


