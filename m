Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EB575C170
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 10:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjGUIXS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 04:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGUIXN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 04:23:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0B4273A;
        Fri, 21 Jul 2023 01:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5UNyGqTlyIFGHTWJauQevkTHAKSUaOB58Xjkpgt5uO5qDg6ZO80No8Qz+QlXGXD8mL70eo/CneftLnH8RRh3zike6FI9h06sJ56mrflyCARb0pQFBQOfp+2rtD9jun8zlCcaRxGuGs2NZzu2JijZR3sjvWq3HyePfq6fGGJBtsborgZSlIh0HYHhpy+06CLSlPNxC2CNkuB9u00tCLPSR0QLLF+Aq1cuNHoVnqPttaQq2a8//fiyezr+ydlbU20BRx7drypJbeDOwO3/Zs/xvvEXR/v3lPQmV6JSVVUb7GxRX8IeY/Xz/8E75A6QKaa807khkIEAmvA2q5n8Z2Vng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jyzbgGtCCxWDYcma3W/oQX5MJ9OJGbs7QwutL2uYvM=;
 b=LBE0e9nZv5U2cgDnXHwuBIH5xer9BLXz01TTMPub31Onjyp9krgy420UJkXubG+CVMbL24lWGG5EHP0Le3E2F39k8W4RqedsZnQCKCN8e6681eC1IkLAvqSyCqTeaQv88ffT3INneYShO7lxzr5t+gMQFVD1hMQJDAlJhwqmsunsxMNzjOmVyPiw16aZ/nWvKM96PTZx9LiRG86v5dvecx7awaqF4+ZxSVRqT0DsL+FY+TTu4HE6rttAtcJOiKZHAHyM2mi9to0syJWUihLH8orkcDZsvVXeG1tEPss5dXcTDaYf7M8gjbxSv3PHmQggVplqkObuymoa3kzJ+VKjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jyzbgGtCCxWDYcma3W/oQX5MJ9OJGbs7QwutL2uYvM=;
 b=pzJx/RW8pv3dDQNVTor6AsPM4jj8AumkHhKeCRk9UF9XopM+gNdgzZz633rZu+370lijT0npQvVXsd7df24IQn1BxO2gDgOeSYx24J7VYuXBxE2hubnToalmbrqyR4UVGSJkLhzbGudcTDx47U84ictaKaTpv7PVRJJhVLGBEUthXkLq78UqlC9/yV0eb5kw9zdlYkc6Wum5QFiMjp8N5o+tMiGVsX6L2xHdWEzfw4xX1LAYa/5riIT99spKNnzYmOTrsbBtXsc21ccxRBC4hYeiadDI5AokIyULB8HvWdFqDbRS4gMsVc4jhbAzkiOX9WUjaikowPPk+jWWqPS8gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 08:23:08 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ab4c:b09f:b445:be6e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ab4c:b09f:b445:be6e%6]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 08:23:08 +0000
Message-ID: <53d1bf79-4353-49b5-76b6-c2266535c778@nvidia.com>
Date:   Fri, 21 Jul 2023 09:23:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V4] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
To:     Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        thierry.reding@gmail.com, Sergey.Semin@baikalelectronics.ru
Cc:     linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230619102604.3735001-1-vidyas@nvidia.com>
 <20230718025221.4001329-1-vidyas@nvidia.com>
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230718025221.4001329-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::7) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1f9da1-0efc-4282-a761-08db89c3b6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khMPaA9N8tb8hVXk5jZdv5jU+ktVJLPf45MmpRF9PZHBkK3dZ+pnDAz9GknLOsrXreXlWffKIiU/Ojy/0L1BfzgOsy9V4jsW6Pi0A137B493YXnZLl0R3hO25mUdkyanTfdgNceSIRFQtlc7o9yVotc4eJoD2uma5TMg8VjqwLw7d4Cj/awAvCXignwkO0bdryoTfA8Dn5bxlovsnxTPb6wqCbdWPERIP+RXu65EXgPaJKgLYy3kuwbO6EgmxqDyPqJU9nA/JUIfV7tcDGgDNn/Ukd28OrHjDDgwfrYJYY9skiC8SZsJSY8uSrqRIFvwHOlNcjxu8PNFxYtrQ1jr7aisF+NUqqkZQh1z3p7+avoCcnUAoHfzEYrZ5q+pawP14G1SCuRneEDafR7qTaENh1bWuVfc4ej0C3ds8raFDnqwqTM5fLBprJPVayTdjpHyCsE7q2HyEyTUhQ45oegUPeg8zwPZkeQyNsO1k009s5X66MCvnNdFTueJnYFVwq9zgTyz9MWM0VleDqRPasBpv0LAwDFR5wXFF626taPUHt23/DC7cbtNlnZjkrYrN+va7lJq+RR9U7yTlEeqZ8D0r8RFuD7Ivd7H8mpScDFnlP+bhy30DusdP5yd5Cc+1TXyemGOZhVXn07HZE57PTXbQLpDwO2uMsEP0HCmTaqvGeL04Rkb1Zm98YcMgRvbT58V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(31686004)(36756003)(86362001)(31696002)(186003)(38100700002)(478600001)(6486002)(6666004)(83380400001)(966005)(53546011)(2616005)(6506007)(6512007)(7416002)(8676002)(2906002)(5660300002)(4326008)(8936002)(316002)(66476007)(66946007)(41300700001)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWRHVnFxNjZ2UUpCRGlzWHAzeWE0WWh3ckdIMGVVaUtIbHdZTy9JbWZReUgy?=
 =?utf-8?B?OXlXNDNKWGhoU0h3TVQ2L1VkQ1gxY2VoNmVoQjBiZy9tc2RSQnlhS05CUWcv?=
 =?utf-8?B?b3AxK3NKMzZ1Zmx3VkxKR2RRcDJNRFlTSVJKcS9NQ2FraEZIRkpQakNIMWVO?=
 =?utf-8?B?S3I3Q0wwdEFMV1N4SzJaZGFtSmlFYi91NmhrdktaL0dicEFndDVYZlplcGtI?=
 =?utf-8?B?T08xRzRkNFdzZkxLR2JaSzRKdy8yTW1vQnlIZEFvY2dHcERFdTFRS0NibXl6?=
 =?utf-8?B?MlozeW5zVkFwNXpNenZOTmlQbFJvaXdkM2F6VkVkbnE5TmNINGU5ZUxJamVE?=
 =?utf-8?B?bjd3YW5qQmtJR0ZHSUVNRHV1MURIYlMyV1M0clNUWHlWWUQrVzl6TkVHdkV1?=
 =?utf-8?B?b1hScjRpb2JhYVl0RWNXLy9CTlpyRDkvY1NJM3gxY3p1ME4yUHUzdmcybmFa?=
 =?utf-8?B?OVZaL2dpWG1wVGZYVzIzcDhpZDFaaW9tWUpVMVJkV1Brdmpvb0FUUm0zSUdR?=
 =?utf-8?B?cityWnFHZS9aUlpLUGlYcS9ZOUVYdGd0VTZmNldneW8wcERBdHRWNU1GM0FS?=
 =?utf-8?B?NVZwY0p2VHRXN1QwMmRhVjd4VWhvNk5qeUlrRnlyUk9oKzlLRjFjVWlQVkZ1?=
 =?utf-8?B?cU1pOEhHK3VNNk05UzBRd0src2tRNUdabzZGWE1TalZ0VDk1NjQ2Mmp1VUgx?=
 =?utf-8?B?MzA0TXVhSVNZWGRIWFFNRVJCT0J6bCs3bWMxTSsycU1tTTl6RkRoRVZ2enhN?=
 =?utf-8?B?V0EzYWJ4cmRpTWhTc2ZWMHc1anczakczSWFsWnY2b0RLOXlkenN5bWRIRWlu?=
 =?utf-8?B?RDVYby9HcjBXZEdxM1BqeElDaDdJRzJOY3pjdlQyWTBENVFkYTJKcjdSNHdE?=
 =?utf-8?B?anVNK3U3K2pyMUNqS2lKcmpZWE9oUFU5Nk1LSUdIYnlldVoxN0Y4ZWNvZCt1?=
 =?utf-8?B?QUcydkM0V2lPN1hFNU81djM0OWJpK1VBNy8vNHU1Z3JvTW1oY2dHRWNFVUlW?=
 =?utf-8?B?a0FZdXVZcklFdHVyUE9yUGZNR2ZHZ0hyWFN5TkNWWjVOUGFYNk5Qd01mUjcy?=
 =?utf-8?B?R3E3ak16bFdKc1lhK2x5OUZXS1Vud0hLcDlEb0JOb0xSdjF0MW5xcXlEd1pP?=
 =?utf-8?B?NjBBV0lCUmtPcDNadFFqQ0RuY0NRcXVhSTFzVW5JcnBQR0s1MnlFd0plbG03?=
 =?utf-8?B?OVgyRHdZTmtVdlBSWnNZa0xXVHFMbXFSb01jUnRpMWVVeGNkaE90eDVJY0Na?=
 =?utf-8?B?SCs1Nkp1TVROOVV3cUpMSGpuWGpyVDhXSGkyWkx1NitlQllDYWlERzRTbm1P?=
 =?utf-8?B?YzhyRW5DR2h0OTkydndrWmZRTkVxMVFWMWZNaDRkU3FrMFVnYzZTWU16RHkr?=
 =?utf-8?B?YXYzdFFhOFFMSUo3cCtPeDdoQStoZTZVbFl0dnBzR3JIQmI1enBVV1JrTXJR?=
 =?utf-8?B?SEFaNkw3QlY4WkdZSUV5YlIxNThoTWs4ODJiZzFrYTAveG4vVVJyblFweUYw?=
 =?utf-8?B?UDc1N3JhUWp4NkVnWEl2VFV2bmpNVHV5QjRZTWR3azdqMktnck9ZdW1oMnJz?=
 =?utf-8?B?U0FXYlpoc0RUK2Z0Sk9tQ0FTbDZwblJyNlNkeTNEdlMveFBiOHl6amx0QVg0?=
 =?utf-8?B?MDJjUFd6L3BMcWJJbkxSOWNXTldDWTRtZVJLZXdJd3drU3BkenlnU2s4cDJU?=
 =?utf-8?B?L3JXVFlhNExyZU0zdHJrVjR4OEZuVFJpZG5xNkVoZzJJdGRKUUtlYW92azgw?=
 =?utf-8?B?enZFbXNraTNtZSt3d3ZEYk5vdlpKeEVEd0xHUWVnQWFWZVpqMXcvTG1zU2M2?=
 =?utf-8?B?eXNKZ3g5K2hveUM0L1lmS2JFYWJUdG5RWUMwL2FpaEVuYzZ0ci9FbnBQZlZ2?=
 =?utf-8?B?K2VSS25MV1pSTlUzWTFKWUkvMFNTZjlCeFU1ZjRBc0dOeUl0RHNxZDBqNGJI?=
 =?utf-8?B?NXBCVjRlNFlpbDk5QlYvdHhkUDg2RXFhTFlKb05hQXVDTW5CNDA4dEFjeTQ4?=
 =?utf-8?B?b1Rmc2pqaFRwaWUzUTY0Z2NtK2ZOVEdvbVRtWU9DSk9pdHJFcWlkTlRnM1c4?=
 =?utf-8?B?U0xhVHZVekVKVU9wY1MxWGtjSHhDZzNjZUxMVVJ4U2FwZEF5NFJFckxKeXNu?=
 =?utf-8?B?ODB0TVhhTXg1MXdWUHZnSGpFZk1pNU54aGoyM2JrVFhvVStlQUM5MnVQYlpl?=
 =?utf-8?B?aXpkK05oS1JNQnJLOWRKT0dVcmxGcm9mdW5FbldHbDQ5YmpkWUxzSEUzVENl?=
 =?utf-8?B?RE54RHVob0N5Mm5ocFQ3ZFpxb0J3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1f9da1-0efc-4282-a761-08db89c3b6b5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 08:23:08.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4iLFQY0kQki4QQAV7rWvRb0ERS5a4QoXQJacxo3xFQRZVfdDXjO2/mfDTtaqCCMKBy2W8UFEcizQOPw0OuXPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof, Bjorn,

On 18/07/2023 03:52, Vidya Sagar wrote:
> After commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
> payload"), we set MPS=256 for tegra194 Root Ports.
> 
> By default (CONFIG_PCIE_BUS_DEFAULT set and no "pci=pcie_bus_*"
> parameter), Linux configures the MPS of every device to match the
> upstream bridge, which is impossible if the Root Port has MPS=256
> and a device only supports MPS=128.
> 
> This scenario results in uncorrectable Malformed TLP errors if the
> Root Port sends TLPs with payloads larger than 128 bytes.  These
> errors can be avoided by using the "pci=pcie_bus_safe" parameter,
> but it doesn't seem to be a good idea to always have this parameter
> even for basic functionality to work.
> 
> Revert commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
> payload") so the Root Ports default to MPS=128, which all devices
> support.
> 
> If peer-to-peer DMA is not required, one can use "pci=pcie_bus_perf"
> to get the benefit of larger MPS settings.
> 
> [ rewrote commit message based on Bjorn's suggestion ]
> 
> Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * Rewrote commit message based on Bjorn's suggestion
> 
> V3:
> * Fixed a build issue
> 
> V2:
> * Addressed review comments from Bjorn
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 4fdadc7b045f..a772faff14b5 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -900,11 +900,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>   		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>   							      PCI_CAP_ID_EXP);
>   
> -	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
> -	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
> -	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> -	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
> -
>   	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
>   	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
>   	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
> @@ -1756,7 +1751,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>   	struct device *dev = pcie->dev;
>   	u32 val;
>   	int ret;
> -	u16 val_16;
>   
>   	if (pcie->ep_state == EP_STATE_ENABLED)
>   		return;
> @@ -1887,20 +1881,16 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>   	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>   						      PCI_CAP_ID_EXP);
>   
> -	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
> -	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
> -	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> -	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
> -
>   	/* Clear Slot Clock Configuration bit if SRNS configuration */
>   	if (pcie->enable_srns) {
> +		u16 val_16;
> +
>   		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
>   					   PCI_EXP_LNKSTA);
>   		val_16 &= ~PCI_EXP_LNKSTA_SLC;
>   		dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
>   				   val_16);
>   	}
> -
>   	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
>   
>   	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);



I see a version of this patch here ...

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/tegra194

However, I don't see this in -next yet. If you are happy with this 
latest version, could we get this into -next?

FWIW ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
