Return-Path: <linux-pci+bounces-34203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 986DDB2AC27
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 17:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9AA7A1951
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DBF24C076;
	Mon, 18 Aug 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="smabW86B"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEAD24A063;
	Mon, 18 Aug 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529866; cv=fail; b=mb1ZDLO80SNN6XqRaDOz/6i5AixcnvUXF9dl9/zaQLNWphmXHIwk61LvNIdQlRDJmZRAjgoA/IRhxV+sbTOaZ4+m9SsmS0qEIeozbC6oAdjHXOUpOCQm5E5oD+4CRp5iWO2i2pvgDmW2zjOK3E+pYqJu/on/z99UqaaW0jxEcm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529866; c=relaxed/simple;
	bh=zWifkVy9ORwssaByvt0SVZQ3Af1BEL3fqCSRLa8mNvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T+nUsIERGfp7+KbXvz/7J/0EM0653Tx8zmibnnTawvjiS+No0BI4f9tJrdMuJK+meBCuuGhFdEktAPuk4Bgl5fHFoj6bwDbha4CX0/A8i4Axyi0BahOt0NaiwpHo9wDLqM9xpaMwEx3OCQ83Op2IWioKS60s2ygSb5YgYso7ds8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=smabW86B; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9E8M890q99lLzlEAICN5DGdPb9MPb7wnmW/3VebbCJZpN22hdNMsqfk93d6RZE8RUicqCDMWMxLvdAyoIYjUbmDNyqPaRYsiAAi/QL6yFN0H8w/ie2hjwTpsNbd4dFNHp/58p6HN9h62C5ZY8uKzsUNzTxqQjTmguJiSq2Bq/l+nI0GwSpdG3c9tZovdra0bbkGqsu0zTD18/2p2RVpT8LqmIiAHuzj2leUSdnE9JKfZxXEPCUBFab3dj0/Kal8E4iKOA4AR3QZTRblKT8lEpEG7zzlS+ncWF8QNRkn6ZplGBzwGasr9YO6z6ubJ9HE6hP8K1kUtlnIXPmnu1wahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4pjkKnpKyJJq3gxFmlsUEniaPL+PFg7H3b+ci/Z0YQ=;
 b=SKN6JpnOYTrlldOyW27XOvRpOjFR6Uhiqziuy7U+wdczFaqu4gW9+M1BWcJat74hnyE8j1L+wsxYT2ghR45kzoKVZmDNIO1iY+79A2R2DqLLIOIJEnkIaUvnoKTfv6Ko50r3W0FWzCLtCC/WcuKqYdRGPU4kMdC+K36sA27T90+2uvUPezDc8BgYtPcwie4nXLCzQV0hTzQhR/Ac+knx2U3KinFxZFb0ulupMDgF0ezl4y78aOS7r740ekhIdjN7MB0rG0wiVEsM2fAA7D8wvGMUFQa1Vqky9crtq1WDAkEQ8vVd3+pLvrqzTSHeygf0enHsieq6zKzmCssKCY0Jiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4pjkKnpKyJJq3gxFmlsUEniaPL+PFg7H3b+ci/Z0YQ=;
 b=smabW86Bzhl/thj1uAFhWRhjX0KkKspQNjeCQ87InJOceH+Yx9pGUcCS5oAteq5+jw6gaKbFmO0RuIDFbrsP2iVH5dwNHbKqV91t5IQlaEA1v+0t+yqxzlV1MaqUPgBjXIbKYVix+EgsbG3lzBSKiCc++e8vG3mHKhUq+r+c5UA=
Received: from BN0PR04CA0180.namprd04.prod.outlook.com (2603:10b6:408:eb::35)
 by LV8PR12MB9713.namprd12.prod.outlook.com (2603:10b6:408:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 15:11:01 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::c) by BN0PR04CA0180.outlook.office365.com
 (2603:10b6:408:eb::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 15:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 15:11:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 10:11:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 10:11:00 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 10:11:00 -0500
Message-ID: <af3f61d0-7288-76fa-9d4c-9b33e8411f8a@amd.com>
Date: Mon, 18 Aug 2025 08:11:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] PCI: of: Update parent unit address generation in
 of_pci_prop_intr_map()
Content-Language: en-US
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Rob Herring <robh@kernel.org>
References: <20250818093504.80651-1-lpieralisi@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20250818093504.80651-1-lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|LV8PR12MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d00d3d5-890b-4ece-4389-08ddde6971bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVE5Tmw2cWZtdWNYUU1vSFlTa0VzbXJESEgyU0syWkc4VFRqUWJqKzZKOTFG?=
 =?utf-8?B?TkF6V0VIT2R5UWtrbGxleVByeGFMVnNEQ2VtUmVGckJuMXQ4RjVMZEpIdkpq?=
 =?utf-8?B?VlZFUU9TZkdxWERyS3plRi9aQzQ2STVhRncxSWF5Y3ZzdG9sdnlkVTFHSXB4?=
 =?utf-8?B?cVM3N1ZxSWdOdDVObUJGNE41ZTl4VzJXa2Y4eEovUS9WU01XVlNQSURJQWN5?=
 =?utf-8?B?Rm4yejJSeUV1ODFEZW9oOVVwRzlwVFgxd2VGMmtvRXpwNTlmcTlCMEZxTHAr?=
 =?utf-8?B?VGp4eWhUbGVyNmY2b0xtRTFxa2g5WWZWU2xoK3pLWHN5L3EySkh1aVNGdTAy?=
 =?utf-8?B?RnFYRGhuR05hY2hValNsU0N0SDY1TEhLTFo3TXQrVnZqR2liVXR1bzVSeXFh?=
 =?utf-8?B?MVordThva0J4RXlVbUoyZ1dLVTBCSzFZQm9sZFRuZEt2MzhiRFBlZlV1eEhB?=
 =?utf-8?B?dElNUnRPSm1qQW42L0txbi9mT0xCaXlPM1R6U01oNmoxU1o1UmNWMUZTMVJB?=
 =?utf-8?B?N2J6RkRhcU1XVmFOeFRjV0lBdTlZdk4zbTI0d2x5WjZPOFZXYXozTlZuQnFu?=
 =?utf-8?B?Z1pTY0FDRVpXVTA4cExheEVXaHJVZUxpR2UycVExcFZ1MjZIMFZMemdUNmJZ?=
 =?utf-8?B?blcwSGgxdiszU1V6MVVRMk9zU0hQT25VQXRZVmw3Z3M2WVMxc1JaZmt6ZEQ2?=
 =?utf-8?B?Q0VlUjJWZWJsSm9wKzJGK0l5VTJyNXFwV1JmaDdyQm5DL0JDbDFVUGFSWjRR?=
 =?utf-8?B?YUJKdDdnbHFCSjFkSm0raGo1U29xVkVkZFFlTTR3bDlSZDc1V3p3MGpZUWVM?=
 =?utf-8?B?WXR5cE0yd1BUZ092bk4rdUNydTgxdmZ3TGpzVUpORDVESUtPVnc0Q2tjUE9P?=
 =?utf-8?B?aXhITkNIWllSQytjT1c1am43ZVVTYk12UUtORFY5UGltbmdzMTA5Sy9ZVGt4?=
 =?utf-8?B?b0lKeEFSMXAxYUtWcWl6eFJlUWdFMUZjZHZFb3NKZFpRTDlhRGduVWMzTnBx?=
 =?utf-8?B?WXhqcFU0SnlkMG4rS3lwdEM4K3JyN0FQdUtnOVBvcUN1SHZ3ZHI4b0VLYXh5?=
 =?utf-8?B?eGFQZHV5WGhuTW1pMXFoSExwakc1UU1JM0VlYkV4OFFRL1crdllLM21peFlN?=
 =?utf-8?B?YlpLU2dyd0p4MFg4aUVFa0o4YVRpWGdvOHJ1L1l0dExmTFM2SjR0d0JORWVZ?=
 =?utf-8?B?RFBVeGR3R00wNngzbEd1bFhuMDhiUXVXYnJvNitCUk5KUlFKRExyVjRMVGNs?=
 =?utf-8?B?SDl1THB4ZllBREJSMFR6TU9hNHJncDJqVktEWW9EZkwyRFJ3ak4rNHpZalI2?=
 =?utf-8?B?ZUZ3RTFoZStvanUrNlRNYW9haXRBbkh0TGl5YWJOdThPSldyMzZVNVRVRVBj?=
 =?utf-8?B?TUliU3Qrc1k5V0srWW0yWGFOSVc5eGk0TWhTOWFQUGNSdUhkVGlkMDFraThH?=
 =?utf-8?B?cmlPNUxKUTlrU0tqZE9ZZjZMVHBmLzd0ZE1Wdmh6NmduK1o5NlhGVElkY01m?=
 =?utf-8?B?c0RoVE85Q0E0YXZ1ay9tSzFlTXNuN2YwZDRlWWhIbDViOC9HU0NkekV0dkJB?=
 =?utf-8?B?V2ZZUEZjZHpZdFppSnUzYnBQUGc4cHZ0UzI0dHN5anh5bFdHNlk5bVZxWVVS?=
 =?utf-8?B?NUlFLzZpVllFNFpzSDRLMUJhWDJuZFZ6aFJWY1U3TUJVRm9aWFNKWTBOcGtF?=
 =?utf-8?B?d0NMUlljMURkSWxLdlRVNWg5WHF5N3ZTMThyZTRtM0Nya242MDZRTUlxU0hz?=
 =?utf-8?B?N1lPbEZEWVhYSjFkL0U4elk1VzVWNXlpNmRpK3NCT0hqamRZOENvaDlVQTB1?=
 =?utf-8?B?MGNGS2toZk5kSmpaTDhNZXVkS0pNT0x3K04xbE1NYVdqQk1qUEhkYXJpblhO?=
 =?utf-8?B?YllNQWV0bU83elZMUG11T25FMnlmaVFRNE5Wbi9kMzVZdEVhVnlDVkRZRkFr?=
 =?utf-8?B?VFMxdElKOG0xSmZuNVliaERGdVNmRXBDREt0a01tUGJNaUZxNW81dUtRNWQx?=
 =?utf-8?B?N0dIT2ZTM2dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:11:01.7072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d00d3d5-890b-4ece-4389-08ddde6971bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9713


On 8/18/25 02:35, Lorenzo Pieralisi wrote:
> Some interrupt controllers require an #address-cells property in their
> bindings without requiring a "reg" property to be present.
>
> The current logic used to craft an interrupt-map property in
> of_pci_prop_intr_map() is based on reading the #address-cells
> property in the interrupt-parent and, if != 0, read the interrupt
> parent "reg" property to determine the parent unit address to be
> used to create the parent unit interrupt specifier.
>
> First of all, it is not correct to read the "reg" property of
> the interrupt-parent with an #address-cells value taken from the
> interrupt-parent node, because the #address-cells value define the
> number of address cells required by child nodes.
>
> More importantly, for all modern interrupt controllers, the parent
> unit address is irrelevant in HW in relation to the
> device<->interrupt-controller connection and the kernel actually
> ignores the parent unit address value when hierarchically parsing
> the interrupt-map property (ie of_irq_parse_raw()).
>
> For the reasons above, remove the code parsing the interrupt
> parent "reg" property in of_pci_prop_intr_map() - it is not
> needed and as it is it is detrimental in that it prevents
> interrupt-map property generation on systems with an
> interrupt-controller that has no "reg" property in its
> interrupt-controller node - and leave the parent unit address
> always initialized to 0 since it is simply ignored by the kernel.
>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Lizhi Hou <lizhi.hou@amd.com>
> Link: https://lore.kernel.org/lkml/aJms+YT8TnpzpCY8@lpieralisi/
> ---
>   drivers/pci/of_property.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 506fcd507113..09b7bc335ec5 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -279,13 +279,20 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>   			mapp++;
>   			*mapp = out_irq[i].np->phandle;
>   			mapp++;
> -			if (addr_sz[i]) {
> -				ret = of_property_read_u32_array(out_irq[i].np,
> -								 "reg", mapp,
> -								 addr_sz[i]);
> -				if (ret)
> -					goto failed;
> -			}
> +
> +			/*
> +			 * A device address does not affect the
> +			 * device<->interrupt-controller HW connection for all
> +			 * modern interrupt controllers; moreover, the kernel
> +			 * (ie of_irq_parse_raw()) ignores the values in the
> +			 * parent unit address cells while parsing the interrupt-map
> +			 * property because they are irrelevant for interrupts mapping
> +			 * in modern system.
> +			 *
> +			 * Leave the parent unit address initialized to 0 - just
> +			 * take into account the #address-cells size to build
> +			 * the property properly.
> +			 */
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   			mapp += addr_sz[i];
>   			memcpy(mapp, out_irq[i].args,
>   			       out_irq[i].args_count * sizeof(u32));

