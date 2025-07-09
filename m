Return-Path: <linux-pci+bounces-31770-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50810AFE996
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 15:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB3C16E287
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D400E26B763;
	Wed,  9 Jul 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LZssTa+V"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE852874E0
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066224; cv=fail; b=nu17Y0oZFo18eEped/aZMSMGKYYfbiaWR5tWbtSMQ3a6WVQFDQ6j1lNHd3SYcDwcICoZe8XUx6RcvQlnJAlMIptzkheyv0LX9SzI6fE3gjsCpmH5j0FsJHGPDHsLG9V97WTGUJNkEhIK3vAscwxLLWBo5mjS6VsNB5MRjFqEvGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066224; c=relaxed/simple;
	bh=LHTD4QCZ43PC7V9RRXyz+7Lr8nhL037XXaKwYkFobAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZEHqvNA8VXD8Km4ws08di8qaC71cMAQ3zuirNn+8i1WrR4Qmz1V5tbt8vn009rLzvZwG6KExz4bw0hX7+AbMJJR8aLewEaUpM8E8yVBcckcU0BsMTLCJicgaU9qITZe6GsB5oaeZwMSACFoxNrvtWE057HAzqB+DSWsSZB9EO/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LZssTa+V; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xg8empbsKHhJqQi8mKt/qQ/kBvvYiRd8SvmNlh4v6RI/FUYGy/1SPcQI5/DQVFoSZhsW2VfgCJoAsqF9xO7Dwb30LuGnY+VZ4pYEAOGHFoACD8mpc/6eHNyVAfFJQ9fUXfYc+ufOsYBbjEUnW8ENpIB95VGJ8PYtgTFMA1yniwNTXK656n6dZjM3IWZ5a3ShN99aKZFPvv7VqtyiCLEJhgkAxL2y0PisWog9XRPyLEVAvJFkhbaMW26IAgMiwakaF/XTDt+ECcAF9/YAlpz9ipqazSEL0rQD7NmvFU4Yfs5U85LRzk9UUx6Iv9LN9mKns4ePL5zPUAAfroFsSRNTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfXAhAXfhMPNiWYr6F49yFM7Nf0U7udprd9ozJoA4R4=;
 b=U7gJzGJk0VCAkewLX27uu7ZnOhd8YdF280PMBvUJHhOp+3druolMo9XDana9kbSEnH3MYkLCUgbC+An2DT2DK9q2hMggsWvigfg30wb+qNrlYgT2bgQyfqplkN3MuLBmMEHKQNTClMRMPGP95yzZEBGndFPTWvVja2/Cq/3xvbQ/GgCctda90tsB96FN70XVOozMk8+yDI337tfblraj2qm7RF3/sQdxyiwJZQAeM4ML+oVgl1h8pJXpFs8ugkWsOqM3GG0g/pxmGgDtq/rHL1VqzId0n0kLGWpxo4ASaDEgtak6J86hSkBKsCZ29MvmjvLqvBPs4YYtYgNwWmhWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfXAhAXfhMPNiWYr6F49yFM7Nf0U7udprd9ozJoA4R4=;
 b=LZssTa+VHj2AV89A289GQvKfQLxTthswXg+Pev9WZ1ZB/HYcScTqaJd+UJ55QwX7/bCu8ATKmH5y7IYW2ZslrWyiFz29WP+Y2fVDJACWiRJk7YDd2iMnK2UHcUUnftWzFizNayvJHndj32pkyhNcLDC+8lEKe2oB0VUhNMsIKCC4iYDE/I/MS/Q7RqaTF/ClpuqmKqnTIajCdTI5TIS04fNBDaYIs2p52C8/x+rMo+4znS8SF64C8rRJm2aUZgoh4DS86j1M4g/XrBTAMClJU7DLXczPo0EuS8VkHm0pqSJBPx2HOJBGpS1Ul05WgrFb8AyHwU+rpxvTZdclScXzVg==
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 13:03:40 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::c2) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.5 via Frontend Transport; Wed, 9
 Jul 2025 13:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 13:03:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 06:03:20 -0700
Received: from [10.223.2.16] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 06:03:18 -0700
Message-ID: <0c7aae03-a928-453c-bc5d-9f95a7e3cb52@nvidia.com>
Date: Wed, 9 Jul 2025 16:03:17 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Add missing bridge lock in pci_slot_lock()
To: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Keith Busch
	<kbusch@kernel.org>, <linux-pci@vger.kernel.org>
References: <1748530782-3332079-1-git-send-email-moshe@nvidia.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <1748530782-3332079-1-git-send-email-moshe@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 1baa2019-f571-49c3-5c59-08ddbee90669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VitySFdGRHZ3NzhxeExqWFJXWnc4REJqamtHYmVTcVJRcVJETUJHTVBPS0gx?=
 =?utf-8?B?UE9CVEpDb29BbnZPNURYY3BWWC9CN1JPblhVd29BUWxGTXd4UldXY0todEh2?=
 =?utf-8?B?N2VFWDBsVzRmSENQOUdlNjlncjNWK05zU0RXTWQ2V1g5Yyt4aGkyS1NGNjBH?=
 =?utf-8?B?VUN6NzZhdEJjU2xla0U5Tmh6cmlkTlBjd1ZUSjNhU3BsTW45dGpZeHJxL1hn?=
 =?utf-8?B?STNXS08zRWRiQmpjWjNMelhNYUQrcFI4b0F5RTlZT1FuRm91ZDFmTnN5VkV5?=
 =?utf-8?B?TEcvU3JPV3U0aHkrSEZTclFSODUzQXVCQWVqcXZ6Q0JiLzEvU2pNU09laGVI?=
 =?utf-8?B?a3c3V2hsVkZhM2Y4Uy9hUTJ6ajRYVWJGemoyY2tUcVdVUXNLZFM1WE1mR3B6?=
 =?utf-8?B?U0g2eXMycGtPZCt6ZFpyR3BmeFlyNERXNy9NdnFQNXJjUmxYakxoZHRGTDc1?=
 =?utf-8?B?M204K1lPQ3MxMGw1dkFDejdiRVpldzJCNUd4ZHp3QXNEY2FYWjNWaFZ1TTRm?=
 =?utf-8?B?RDlYT0pXd1pyRFJiRXUwNVlIQVFteSs4ZlN0NVhCQno2Vy9rSVo0eGxLNE1v?=
 =?utf-8?B?ZnpwNFp2anpjYWNaNXpCNnpPVkpicE5lUk40WkUrc0hKTDEvUlc3U29xYlkr?=
 =?utf-8?B?T2xjM0JUZDlFUUxpOWtoc3JhejhGOTk5YmJVZGhBZ1lBRU9NRG1DVlRKelhk?=
 =?utf-8?B?eFgrM0U2ZDYybFZkWTlHd0dQUEtBMlR1bUtEb09nVmFPYzR1QnhKZVU4OVRl?=
 =?utf-8?B?YmNQdGxibzNUVEd0QUhhdVJWVUI5VURXNXdoWi8rUVpHQjdCeHN3UUhTM2pS?=
 =?utf-8?B?bHVvWUF5eS9oZVNJVllTbG5XTjZITGt6SWp6Uk9yczhqY0s1QzBYVnowSFNM?=
 =?utf-8?B?T3UyT0RTaEJZazhWa0ZlVzdwVHdPcDN3OFVBbnVmdjJTL2lQcUJwR0wwNXdW?=
 =?utf-8?B?eThDaDA1MU9aMmJOUDRKOHJWLzlsZHRhUFpNVDB6R1RVL2lIWHRySHl6YXZ2?=
 =?utf-8?B?ckhvTWIwM2V1aEVVNWp5RmVybEY4RjZwS2RXa201R2xQQjFjbU0wZ0l5dDZJ?=
 =?utf-8?B?ckFha3pMOHhOVXdpdlU2RmR1OXVXRE5lcnh3TGlZdmdqSW8rbnIwai9EaTZ5?=
 =?utf-8?B?aTNqdStrU1U0Vlh6U3BmTWs5WlRrWFNmT2dzU1JQc3dSaWg0RDJmMkg3czE1?=
 =?utf-8?B?TFF5dlZXYm92VTIvUlVFRlpRaTNZdkRTd2VmY0JaU01sc3hEU0hQRTJEQ2ZD?=
 =?utf-8?B?MnU0SVdVRFhWVEc1bC80ZXo4V3FRU2V1dTVadWdXODV5MUlnR3ZDeTN2cUdE?=
 =?utf-8?B?b1VDY3lram94NWRVQ2R2OWJ6Q0lPR2ZjeW1oeFRIM3lhU2wyWmJnbDBzb2lZ?=
 =?utf-8?B?dkYzRlg5RmltbE9hVXhLOEFQR3gvSzNjTnYyaitHMkFnN01YNkhrMlV6S005?=
 =?utf-8?B?NTFSV0EwK2svbEc0eFlkK3JtSDl6OVNNU3F6aFd1S1N2L0VPL3N6Z3Ryb1VH?=
 =?utf-8?B?MXR4amo4aGRsczlqNFV4MEsvbXlJUlRsS0d3MXk5V2duNDc3RDZ4bkZvQmZL?=
 =?utf-8?B?RXdUM3RkdjI0cjJGTm1KOHhTTFRiNmlFTWtUUnQwdUNMcGs3TXVMa2FSNSts?=
 =?utf-8?B?ZWFUMkc1WVh0MEYyb1U1WDV1VndtTm1sS0ZVOHlSVDh3TzFIbVM2NmpNL252?=
 =?utf-8?B?eithcGFDMGJEd0ZjVDdCUnNMTkFqWE1PQWEvMU1Wa2hGYmQxOUpGeEs2Slh5?=
 =?utf-8?B?Qk9pVnQ4WGg3MHM3SlQyTU84VXN1Q1ZHR1JrNS9ZYWc0S0E1RnUvbmlWckk2?=
 =?utf-8?B?eXZYTFBOT0I0Y2c0QUhZcUswbit4ZGNpUE1NSVVyOVE1cjlNYVlDM0l4eGZv?=
 =?utf-8?B?bDNyVU1paVE2WHNmd3g4eEdLS1RIOEhjcE10QXV4Q3J6Zm5SbVFxSjBtYjBi?=
 =?utf-8?B?c0ptYk1KT2hQYTlVZ2VGSEpNd2VJWlBrdEhwUUpUODV1bTh5M0p2ci9tZnZW?=
 =?utf-8?B?VXg5VW9XVlIzVHFnREhoV1JUeE9yejVUU25wS1pZWHBZYkVLNE9ZOTlvOUsz?=
 =?utf-8?Q?s72zS9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:03:39.9112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baa2019-f571-49c3-5c59-08ddbee90669
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771



On 5/29/2025 5:59 PM, Moshe Shemesh wrote:
> Unlike pci_bus_lock(), which acquires the lock on the bus bridge before
> locking devices and subordinate buses, pci_slot_lock() currently miss
> locking the bridge. This may result in triggering warning on
> pci_bridge_secondary_bus_reset() [1].

Hi all,
Kind reminder regarding this patch. I'd appreciate any feedback or 
comments.
> 
> Fix it by adding bridge lock on pci_slot_lock() and pci_slot_trylock().
> 
> [1]
> pcieport 0000:c1:05.0: unlocked secondary bus reset via: pciehp_reset_slot+0xa4/0x150
> 
> Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> ---
>   drivers/pci/pci.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e77d5b53c0ce..c31929482122 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5518,6 +5518,7 @@ static void pci_slot_lock(struct pci_slot *slot)
>   {
>   	struct pci_dev *dev;
>   
> +	pci_dev_lock(slot->bus->self);
>   	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>   		if (!dev->slot || dev->slot != slot)
>   			continue;
> @@ -5540,6 +5541,7 @@ static void pci_slot_unlock(struct pci_slot *slot)
>   			pci_bus_unlock(dev->subordinate);
>   		pci_dev_unlock(dev);
>   	}
> +	pci_dev_unlock(slot->bus->self);
>   }
>   
>   /* Return 1 on successful lock, 0 on contention */
> @@ -5547,6 +5549,9 @@ static int pci_slot_trylock(struct pci_slot *slot)
>   {
>   	struct pci_dev *dev;
>   
> +	if (!pci_dev_trylock(slot->bus->self))
> +		return 0;
> +
>   	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>   		if (!dev->slot || dev->slot != slot)
>   			continue;
> @@ -5570,6 +5575,7 @@ static int pci_slot_trylock(struct pci_slot *slot)
>   		else
>   			pci_dev_unlock(dev);
>   	}
> +	pci_dev_unlock(slot->bus->self);
>   	return 0;
>   }
>   


