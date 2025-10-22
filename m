Return-Path: <linux-pci+bounces-39002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D78CBBFBBB2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC0018C6BB0
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6B028B7D7;
	Wed, 22 Oct 2025 11:52:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022132.outbound.protection.outlook.com [52.101.126.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D502F8BF7
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133930; cv=fail; b=UyU1LE6r4fR4N1nNONco1ZmM1doJs1ODADf8S/lsxBhNX2cp75aDIPD+hR1hb9PMIb2vayU2cECvftb6c+s3x+7w5nZNm/P2TZ962HsF519DQgsvZlsXZfjmV/fjtT/u8rnrv0Np7eNz27pOaXBK0FQJR/4uPOm+mtk+iIqgHis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133930; c=relaxed/simple;
	bh=+RQqeehq0W112dGZ8xDZVQ+I1gNbpE96jCBEwAoiMbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UR6k/cki/Ntu8Ct/VJglSryEZMign6xCLnaSM+4JlLPu2LvzkumkPoOod1kXqAwXgM8wOimr4oCbIqNygGFQley6HggfS2v2CIGmknxSRx6m+AEmDYTOIYNF4O8Ok+g5pRkqFRHmu6Z4ByBR0CEHzvN3gZUHgGawspNzIite9n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNLUdponC9cC5NCvm/BytdUa7HMFPVQuZPBc5fNNz6T/ni/obzsP5sbFjuCnClmuag0uXA434iU/IDmS0GMiO1hZtfwMgkRlkNNoYElaUobCq5I83gNW+xhQpm87H0QR3RslDRwe1P1zwksjV/HpiUO3iyIlvfZ53pZ/iE3Pe4yANYsUUfGhx8j/BM+s1zYi+NwJ7Pm9yrUMzjChy1VvV1tWAI+T1ePg2DvNW0hNqivvxO1XWzHKxGt7H/MHcAFPCOqGosRbEMUoiRcwyBwJ5ycxtFQxkcp5VJQ36tAbQQCWfqBSidB3+ipVJ6R0AqQU/W/NLJPR6NE9dpbFVsfojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7uWOTv+MsKX1wZzhtP/pHwdFtaELmnOPFe3yiQEYsY=;
 b=lSVBx/gPUml/etSRJqWVSlEFjpY4T1zsRPOkB5O6DCEucg5bLIQLsMQFr/JWkG7x8up9ZWV3Dfa3lsryo6QnmQ6EGiDzhJldOO6Qt55Jp9BOipF0tc7OIeknJm8HTPTIdeefmZ/yUS1POimM69nqlzjqU+zhizVK8SFvlk0Gmj5Ry0Adz76NFElNkTQdbqCRmCB8wS/XV7IMHcNNwQFR/a6lD6LjokwumvtDMX6tz81B4jQeLDUkcvwevGvZWBiu3+vRAhIS282IalMbNb1hYArfFUBtcw13MnDiLN3QxR6pVy6xKUjYwUA5sQGr0YVzkHNDP+DaihIHPual3eloyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=google.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0002.apcprd02.prod.outlook.com (2603:1096:4:1f7::16)
 by TY2PPF1938678A3.apcprd06.prod.outlook.com (2603:1096:408::786) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 11:52:04 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:1f7:cafe::a4) by SI1PR02CA0002.outlook.office365.com
 (2603:1096:4:1f7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 11:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 11:52:03 +0000
Received: from [172.16.96.116] (unknown [172.16.96.116])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 2E5AE41604E0;
	Wed, 22 Oct 2025 19:52:03 +0800 (CST)
Message-ID: <a258b9bb-f289-4044-87fb-1ad3649cd8f5@cixtech.com>
Date: Wed, 22 Oct 2025 19:52:02 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add PCIe clkreq stuff for
 RK3588 EVB1
To: Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>,
 linux-pci@vger.kernel.org
References: <1761132954-177344-1-git-send-email-shawn.lin@rock-chips.com>
 <1761132954-177344-2-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <1761132954-177344-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|TY2PPF1938678A3:EE_
X-MS-Office365-Filtering-Correlation-Id: ac95f5e1-c6fc-4c65-7b52-08de11616b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWh6UkV2N29WM0hCcWdKdGZqK2Q5NDFuSi9sRUMyemphNE1FNnovekRET1pk?=
 =?utf-8?B?Z3NTVGhocktiSHJtQ1NLalRNZi9iNlhibmJIYnZNT1MxVURESFhGRlFvYXZx?=
 =?utf-8?B?QkRrZ1BBZXA1blkrSlNUU1lrYmh1SFZadG0xMnJEQStqNThwTHJ2dktKaFRO?=
 =?utf-8?B?VUlhMS9KUjJwWmxaWnFaSmQxaGMxVCtWS0RML01iNG1DMHZNUHV1VXIwZEZJ?=
 =?utf-8?B?RG93ci9LdUZDSm5LQm4zQ0F6NnNjWG1XSStSRDR0UHVaak53S1ZqQkJmOVQy?=
 =?utf-8?B?R1Uvb3BSSlpNYisyTjhpTk5mSVJhdk01VjhVakJTbHo0WWJicHdJYzdmUzRH?=
 =?utf-8?B?SXVQZFVzelBNRlJHcVVvV2s4TGpteXlCOEl2R0pIMEMxd1ltbzM2aDF3VGVE?=
 =?utf-8?B?MG50bkxzbXRIMmtiQnZjQ2c0WXJRcGVJV2JuYWZwV0hMRnljWis0S2dnUjVq?=
 =?utf-8?B?M29HdmRtdzhkb2pTdU10OWtYZEwxL3ViWndaQXVZU3kvWG8vYTlkc005ZHl0?=
 =?utf-8?B?YkJVL0JhUE5lc0VUTGdONDE1ZDNETVRSK0c1Wko3YW9SRFJZbmRiQTBxcjR1?=
 =?utf-8?B?SGk1dXBkMXMxZmY3cHQ4eVhXM1ZSNUp5bXhibmZyWXIrTkhRYVIrYit6U2xl?=
 =?utf-8?B?dTA0ZVdpSUF2SkVIVkM4OXdDYUxoUXMrQnY0QWhKR3dLZXVVVW5MbGZKUitm?=
 =?utf-8?B?K2JNRTVZNVdZWjBEWFJUWWRYVUhFb0hJb0VnUnNnVkNWeUIybW1PZlVkelJq?=
 =?utf-8?B?c3pyMi9JTXEySzNqZDBtRlFUS3h6OVlmb1lERE84WlZNdE5kb0RCM1g2Rm0z?=
 =?utf-8?B?MkZGY3NwNEVNaDlDUkkwR2hBQWY5eHhabjlkTWVwTk9PZ0tyVXUrOENSNk1D?=
 =?utf-8?B?WnlHelRzSmRidTJIajJ6NVR5UStJVGNNd3ZtYWFFOG0wbFNMTk1raGI3Mm9u?=
 =?utf-8?B?dGh5amtJSmFlV0dEcTk1U0ZxcEVnRnIrUms4cStJNDJRRWlxcTY0cFVSbGNq?=
 =?utf-8?B?cHRjQURCb0FFdjdkQW9MNDNwQXg1RE1SQVArTXJjcUFnclBaUEx5K0hjaWlO?=
 =?utf-8?B?N0M4a0ZEUnhXc0lBMEc3aUE1amhVd2IrcHB4TS9uM1YxdHNwK2dzaFdrR1RL?=
 =?utf-8?B?Q2tndEM1WUdMeTlyeHNFakNFbUdxa0xEQ3ptcFZsQzdOUUNnNlpjaUdXb3I3?=
 =?utf-8?B?TUJJbFhLbUtlZFN2RGJBYUZEc1pNaS9jcThPMlpBQkJjYjJlZXhxRng4Rmlz?=
 =?utf-8?B?R3EvWVkwK1BtaGRlSi9XcGh2eTNVNCtuUU9jUVpvQ1JWSjZmdXE2alZMWW04?=
 =?utf-8?B?OEtKQlE5K3JJRWd0N1AwcXVCK09KRTREbnBXWXhVdmU2cGxrUlZZZDNaaGl3?=
 =?utf-8?B?NXF2Y2VuSmRteEVsZHRWL3lPb2xrdmVNN2p6cHZiZGdZKzhzN3FmOTZGK29K?=
 =?utf-8?B?Z2l5WTFkc3E4d2ZkeElLRjFiWExZbzJKcmI4amlCQVhRdHpSQVdvcEhhSjAy?=
 =?utf-8?B?QnAydkRVV0Q2eXNONGhrNG9iajQ2RHFmTFZvcmZDQ0dvY3M3Z2ExNllhSCtO?=
 =?utf-8?B?bnJsVVB3dFJCRVg2UmlOVWJoeWVLZzFZdWFmbmZnZE1rNEgzR0RxSU9XZUlk?=
 =?utf-8?B?OGJXREt3L0t6U2w4QjQ3MlRMMWVIL2VITkl1UWZPNkNMMFRoL2NsWS8veDU2?=
 =?utf-8?B?dElIUFNNaVFqa0dYWi9aOVNsMVNpbENNUVlEcS9KUkE4NFEraS9tc2hIaFcy?=
 =?utf-8?B?cjkvMDhuZVNpYjRLWjc2cDdUV2VZYktsZVFRN2kwRDFyL1padjMrekMxVC9G?=
 =?utf-8?B?aDFVRnJ1L2Z3cW5qUGswNXV3NWJRMUlQUm4xcGdiVmNmaXVxZS8rMzlSLzV2?=
 =?utf-8?B?aTlQS1U1OEtjUWlac3hUOW9WUjV3d21GMytNbW5YbVhzdk5mVDg2RlhQS1pt?=
 =?utf-8?B?T1VYSFZVOGVnRkdzKy9OamRFejNCd3lMTk5sS2hZVThRMCtPZnFVNkh6c2pr?=
 =?utf-8?B?UStnYmlFZXRlWWNBTHNMb2JFVk85MEQrWlJVQWtYcGRueTFlejhaN0Z5YnRS?=
 =?utf-8?B?QzEyMzV4b2dWVi95KzQ0dmhMNnJGQmVKUGtJQitISXBUZzI4M3hwVkNmYjhE?=
 =?utf-8?Q?Sz1E=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 11:52:03.8472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac95f5e1-c6fc-4c65-7b52-08de11616b54
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF1938678A3



On 10/22/2025 7:35 PM, Shawn Lin wrote:
> EXTERNAL EMAIL
> 
> Add supports-clkreq and pinmux for PCIe ASPM L1 substates.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Hans Zhang <hans.zhang@cixtech.com>

Best regards,
Hans

> ---
> 
> Changes in v2: None
> 
>   arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> index ff1ba5e..c9d284c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> @@ -522,6 +522,7 @@
>          pinctrl-names = "default";
>          pinctrl-0 = <&pcie2_0_rst>, <&pcie2_0_wake>, <&pcie2_0_clkreq>, <&wifi_host_wake_irq>;
>          reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> +       supports-clkreq;
>          vpcie3v3-supply = <&vcc3v3_wlan>;
>          status = "okay";
> 
> @@ -545,7 +546,8 @@
>   &pcie2x1l1 {
>          reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
>          pinctrl-names = "default";
> -       pinctrl-0 = <&pcie2_1_rst>, <&rtl8111_isolate>;
> +       pinctrl-0 = <&pcie2_1_rst>, <&rtl8111_isolate>, <&pcie30x1m1_1_clkreqn>;
> +       supports-clkreq;
>          status = "okay";
>   };
> 
> @@ -555,7 +557,8 @@
> 
>   &pcie3x4 {
>          pinctrl-names = "default";
> -       pinctrl-0 = <&pcie3_reset>;
> +       pinctrl-0 = <&pcie3_reset>, <&pcie30x4m1_clkreqn>;
> +       supports-clkreq;
>          reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>          vpcie3v3-supply = <&vcc3v3_pcie30>;
>          status = "okay";
> --
> 2.7.4
> 
> 


