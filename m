Return-Path: <linux-pci+bounces-20082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17516A158F8
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 22:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3620A16664E
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C91AA1F1;
	Fri, 17 Jan 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PYdtuG3c"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838719E7D1;
	Fri, 17 Jan 2025 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149229; cv=fail; b=ruL9rnsxngGAdBW23Riq+ja0S63XNAid03T5TDlIymjuc3PtNk96ivVLzp46jF2TALwwZaJZWoX3ANeUdB286+tcnTJJFBKY/J84Y004nk8HnBNCs9Sqnvk+jxL+7HiPrLpg+Ugy1QKQWoqNNbiXyqEcvejtbVziMrpUXDM3vrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149229; c=relaxed/simple;
	bh=TVGD+aE70XiywTDrvvy71jij8XKiDJe8XP4Yu1Xudcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UVwTvWOdZIhg6Hs/lnW3/FiXodqTh3n17Arg4FNwDDhkT28r1SOlFy/83kLezGBh5hGIe3vNeZDFnE+DKYAfMIUogY4nVi4gkPph6edu/49HnEWuGtSeUefw5UigzcNdlktBbS98IQ6uaCC9i3/aAEzreIWd8yttn9XITK+y0aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PYdtuG3c; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/IHLTeCsFbFpC62GNDU5cRVkVOGuaNzd1hGeQst72VxrNUHM8T88GiKOQef/3B89bYddXQlFVYFtczDlWxUsDbrmZ5bL4KayL61ZaqRO+d53NMzhrKTZRpGhWaW+fAgaviB5oJttB0JHB/PhvpqEqRQu2Zyyv2XRp9tYZtx5Q33vI8EtC/r2UIEa3rR0qNW+ssHbQzR5mgutsDRIwzB+veo9n3TIhSbsgdkbQREc3yjRB6EecPG95q89DL8hMMi/vkEBKjA0U0x5i1jg1qq7n8PjaNR5v/4ONgczQB8GmMzuwvVbkz1DVG2zsbnMK1Zz+pqh0j5z42cwMFBhh9iiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT2ve7Ah5Do8tCnPbFLqhD88Wsuk5EUPeOADh8lmhtg=;
 b=sBMuY9XS8E2Uw+LuzG9Sd5ZiT+9NWNQ6tYXmshpdjpuG1n3aqtEGxYl2Ryx60OSC+Ys/FjiiU7BEIbBP5UXBSq/MGMVr6ciVXnytggvlZiyks+rKxjPAhdyunBP574PYaJIkchBzIs5md2OrvIa+8SyTiNtzIIOwIaiBsj90eaLC+5v11eaXbiV3UWhc/36Fv2wzyGOB9SRf5GzdBW6wfnTkg9h64JAEW++qWsoyTukA0WnYNMU860pVHZQVd/qW4FABtUHA1/OKKhqWaGtchQy13ujWGqSVZ/pP86GjUOgLIaTPrXvf3+1+JG9vNRdnQGMyhjW6Tfs7HERZHLA6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT2ve7Ah5Do8tCnPbFLqhD88Wsuk5EUPeOADh8lmhtg=;
 b=PYdtuG3c4AsrS99YPcXXNXQ85+JYG0WlPAoURwVkaMsbZLiQ6QK3Y47qqLWUc/iWBpgdoXra3tzzHcyb3FJjfOqTbiH+2ue0y7aVMWEzKQkbAi+l+0X7dmS7GzH5vnmDIN872Cl7uhd3IXcOiNL3CD2F3/0vPlB8+hsz+GM9/gE=
Received: from MW4PR04CA0294.namprd04.prod.outlook.com (2603:10b6:303:89::29)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 21:27:02 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::bd) by MW4PR04CA0294.outlook.office365.com
 (2603:10b6:303:89::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.17 via Frontend Transport; Fri,
 17 Jan 2025 21:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 21:27:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 15:27:01 -0600
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 17 Jan 2025 15:27:00 -0600
Message-ID: <902a1886-c150-d77e-434c-b1a8816f7a29@amd.com>
Date: Fri, 17 Jan 2025 13:27:00 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] PCI: of_property: Rename struct of_pci_range to
 of_pci_range_entry
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
CC: Andrea della Porta <andrea.porta@suse.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
References: <20250117161037.643953-1-helgaas@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20250117161037.643953-1-helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 465f8b9d-18fc-4465-6497-08dd373daee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjNieXlTY28zcHE4NlpjMnk0eDVlZldyZ0F5VmdZdnd2aDV6WkxSdnF4VVda?=
 =?utf-8?B?cUJlaGtQK2ROaWJoY1RWQUxyR3J0N0FibmZZNC9qcU9IMHlEa1Rmb0IxbzBO?=
 =?utf-8?B?Snh6RGdkYlROcnY5aEJmSk42K2lsVUU4UndnV0lmZXpHMTd6UUtvc0ZSU3Zv?=
 =?utf-8?B?Yk9MSm9xZ2xwNUhFdWFzbUhWdm14aXVYYlNWZzN6U0g1WWRDNEZ0S3FHdGQ1?=
 =?utf-8?B?cXJkbDg2UmNQMDE5b1psOTZpdjlLMTF5bytyblVIMTNhajlFbGMrbkJIRVZs?=
 =?utf-8?B?QzdmSWszOXR1SWdRVis5VUJDanJ4Ky9RNjRublFZUDk0ZWRKWFZlMUxFRm42?=
 =?utf-8?B?OEJEa3FETCt2ZzNTSzBMK1ZmRkV4ZHRVUjRRK1ZqSmhpZEFrUkp1ZmdqQ3Ez?=
 =?utf-8?B?KzFBTzVKVStITDExWlBZalp2eVI2b2RaUDNPWEZzZUNsQTlpaTFORkR5VTRF?=
 =?utf-8?B?Q0l3bEJ0cG5yVVZFUHQzUld1dHMrQ3ZINEI4b3dNQ1ZoODVlcVQxUHl3ODVm?=
 =?utf-8?B?RDFtUGdnWXVYbEtGZVZHTGhMdTNsTElMM01tZFhPVlhwQWp4WncxQjhseVpz?=
 =?utf-8?B?OWJYaCtNd0g0dkNUNGNyek5NNjZGNUJ5cHM0ckN3M1QzdnU3OSs4dUkzSUVm?=
 =?utf-8?B?bXl6R3QrQVdDMzJVWnJkYVB0MjdpWEFHRjVBSmZYVFNUNkNBNmVaVzZ5NE5P?=
 =?utf-8?B?VnBBand1clpEVDgrTm1KRDZSVWc4QXd6Z0VOWCtyT01zUmtXR0VUUmhXNWI4?=
 =?utf-8?B?amk2QTlUTjdiWHF1cnNMa1BQUzlGQmZaak9XL1pCYzVKTElEUlFQK2NoaFc0?=
 =?utf-8?B?WkVoNGVreVIxbWJOMnY1Zkw1UnpuUW1tNjd2aS9JK1hNYVoxdFFBM24rOHNV?=
 =?utf-8?B?Tmc4c1pleThIdzBNZElwZ21kYmJXeTdNNFk0S1lteVVmVUFES01QNHp1eU1o?=
 =?utf-8?B?c1Y2OUVXa3VrWGJTZVlvVVN3ZVhlNXd3bmp2NmIzVzdLbXlRMm5oRFJqZ2cz?=
 =?utf-8?B?bTdFVTE1ZEVjL1Q1b3BqR2tDQnJXNTRyWGs0OXcrUDNUa2RaSVpLc0NPVm5G?=
 =?utf-8?B?Q3d6dlFBUnQ2bHRCWERUejNhK1NZeTFJbkJoditlY29Wb1U2ZTFqdU1EbDZX?=
 =?utf-8?B?UmxaS2J6RWVwUXpuN0hHRG1zempQWTRma1FkV1hRczFTd1pxTE9yR3dnUlBz?=
 =?utf-8?B?Nk1mYzVYSUhjVCtZd1p0Y0Jqa2FodkxDNXFHUmtuVUxtMWxielpac0tmRXJK?=
 =?utf-8?B?b1d3a2J1S2QxUzZOTmhQRGJHcVA5R1BUTGVaNGZIN2FNRE4rcjFEYlN3RDI2?=
 =?utf-8?B?U094Y2RWQTJoWU5UamVNSzh0cFYrd3B4RjZkUVJBZThOUXhNdnpWVE9nb0g4?=
 =?utf-8?B?U3N0MUc2ZGZVamtWM3llMi91a29OUjJBaSt1dkg5QmpSYk40OTNwWVd0c2dw?=
 =?utf-8?B?VmJrYmF6alYzZGg3UnAxMkRSOG5YSWVTQ0F5N2hyRFoxVVFRWTZvSmtjZ2o2?=
 =?utf-8?B?c1VjYzYwbVZ5SFpNcTVUd1MvdWd6YXI4MjFGMDcrbzk1WmFsOXRaZ1pPRDBn?=
 =?utf-8?B?SXN1a1AxWCtZSWFaRXdCL29mTE5PVXEvNmJmU3hhOGlZZGd0b0ZqdW1MMUx3?=
 =?utf-8?B?SjBPLzIxWDZwUlhOR09tbllyL0dFU3BoOThPM29zVFc4UmlGVjJnSlpoOWpF?=
 =?utf-8?B?UjFKdTVqblcxK1JkMTZmV1pDalR5amxQeG9sb1FEOGRQUGZMZmF2djZ0WkNa?=
 =?utf-8?B?NGx5bWwxNmhpK0xKOWw2UTJxZVNwbDIyRkl3M2FQbXN6RXpSTE9JRjd4ckFW?=
 =?utf-8?B?VVNndyswUCtUVmdJVE9BbGNuN0NobUE4N2todDd0ZHpQdjNyR0tlSTlJdURP?=
 =?utf-8?B?QlJFYm5wMndHRjIxMTJFNEpzby9rWTg2aHhwUXhuUmZaNmx3RHBDUi9OUnJX?=
 =?utf-8?B?ZnhOd0FmY0tVRG9FZ0Q2ZG83VE8zYVhvR3hMY0tPVVV2eml3b0NvOEJQUjRK?=
 =?utf-8?Q?D9AZJsAy+1HhGx6Mz+P1dEuUbqhh5o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 21:27:02.1586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 465f8b9d-18fc-4465-6497-08dd373daee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501


On 1/17/25 08:10, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previously there were two definitions of struct of_pci_range: one in
> include/linux/of_address.h and another local to drivers/pci/of_property.c.
>
> Rename the local struct of_pci_range to of_pci_range_entry to avoid
> confusion.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/of_property.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 886c236e5de6..58fbafac7c6a 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -26,7 +26,7 @@ struct of_pci_addr_pair {
>    * side and the child address is the corresponding address on the secondary
>    * side.
>    */
> -struct of_pci_range {
> +struct of_pci_range_entry {
>   	u32		child_addr[OF_PCI_ADDRESS_CELLS];
>   	u32		parent_addr[OF_PCI_ADDRESS_CELLS];
>   	u32		size[OF_PCI_SIZE_CELLS];
> @@ -101,7 +101,7 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
>   static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>   			      struct device_node *np)
>   {
> -	struct of_pci_range *rp;
> +	struct of_pci_range_entry *rp;
>   	struct resource *res;
>   	int i, j, ret;
>   	u32 flags, num;
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>

