Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB00553B7E2
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 13:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiFBLeb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 07:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiFBLea (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 07:34:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EA059BB5;
        Thu,  2 Jun 2022 04:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f37KiRKoYLS8hqQf4+CCreh20PtpOeOWN4mDRmDfJGGr+H371jqsGjm/0z8Sb38bdBB/ztZZwCpJjgAki4/OItRap09bvl07efqYsx06At+W4jREjaZz5lcv7F269cEiGa8dHd7dAfhbMkR3e9kx/PX45xiCDzKTB8UCHTaZqRR8jx6XKnrxoO02ZOC+P2h1+jxPnGx6GaH7KydUqj4f/aGjD23Mow+VG/GTrDD31rPbBWFNtqmww5ORQVY9dqLH7aD3sgo52m1ZCpDiIk6LzifjXHKiL9+9z1XsA8c54IX+c8YHyf7AoYXL6KLgeOR9sO2MMcy4WeHOhQElEul9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4MmQqD0uDI3XZ6uuDAOJVKCK6EhAEcqHKLaJw9fanc=;
 b=m7oSCYBsAaErO6zJhIrzXRs4o1jI7qGy000AdyhjEL/NOOjWpYHB3EVx0VIQKMgF0EN8u/+6X9/xPSNAa8QT6lIwRSoNYzc3ULPxRECTxn6CDr5EVLOs5qqjJ00uTZYzYqr7anOrE5l0tMTQgb2wPS0wUi+4f9B7DvGjIidWU/etzeZ1VaP9VzGXFjaRPLrVnt/1hMvsi4EF1IrXjNSd8VLPKv8l+NZHhs7l1i3akyrd3vkHjyxaqig2XClXdyefn8KLqgTIkVXyhwaUzYhHVoTVsRrDVz//t7iCCbKiIZTUrf0/ZQWFA+5ueIox9I3RdRxEjCIemucLsTbl6Lh3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4MmQqD0uDI3XZ6uuDAOJVKCK6EhAEcqHKLaJw9fanc=;
 b=gosPeY1kEyJw41UfnDfynj6/WMikIY3PBJNyUYuVN8l4ZIlcDqs6RDDxAEav87A+1a+FBr9zGsOf4R5r2dQaH3C2VoWD0nwzVWqvpXh4PxuQmdcCMUMm5wydUoYZRtWZkc9gNFp8sXuiHR0ja3bmZPrNaDk+U71zb8cP6Aq0BUNmsgYAkdUATk5pg82Lp0329Ogv54iu+oSAsZjgeaFbmQj3YZ1MBJamonO/Hc3+yUFIeJdJvT6CoPmaMJGNWZJNPWIuXoi60FufKm7zb8p/Tq9va9xVQQgPY+9nlSo0SLo9SIR6s7USvzdY+Ueve+wrjnLK7z6TIP9RHQiR9oIUhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by BN8PR12MB3092.namprd12.prod.outlook.com (2603:10b6:408:48::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 11:34:27 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::4c17:a358:335:87c5]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::4c17:a358:335:87c5%7]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 11:34:27 +0000
Message-ID: <7e1ddcb4-8e89-e7cf-3abf-b6dfba09102c@nvidia.com>
Date:   Thu, 2 Jun 2022 17:04:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] PCI: tegra194: Fix PM error handling in
 tegra_pcie_config_ep
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220602031910.55859-1-linmq006@gmail.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220602031910.55859-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::12) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61f3aff7-28ad-4dea-e307-08da448bd9af
X-MS-TrafficTypeDiagnostic: BN8PR12MB3092:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB30922A00F22F4C421FF143C3B8DE9@BN8PR12MB3092.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQBa7rO1a+9/ApPbtou/XZqsXh4oicP5kejamV8gF91zp0jjSfTM2OjPK+2g2YkZvWN0OL8Id1aE06NoeVw3xk6UHaR6FOh2CiJ8GmK2IeuMMBj224jDfhwdQO+4lxWMoLh4p2VUg6kB4bv/FaW6fblPuWeDMldztuVfPZF86bJVizz4f4VTHkWNPfe13JZHlyFYXUK3xin+fbBSiWD+4HEK7vJELHXwT352PBPfXhmLkcf9AZeYtuqvvLty1iXROZPifJB2hcXMo6RwSWjKRvl1KBCYLTlPFhmmWKRkaUcqcKqYJme5rhS6ienheZH51p++t7/Dfv3JhzftAB00oram4UcaSEAbxDwdM7+Xwcnab4hPoYZjyecAd6fokQ/dy7PDmZGTM+EnPNkVO5yDC7FhO/AD2hLaZ2yFmLEaqfmIiY2ncqwmxCnYtyGm0GINCmSbm2r8u9RKTxu6oYAVrisGGQlRIuY7JhXRd8Fv6HoDVLNhOb5UPTjPY7JTFUXerCqFWdV5kURK8AYnkY9OQKTIf7miZU86c+qOm1BB4mpt25jALoLZjotoCohIn391PHn/2pg8Hf8ftbO5vGpTmYl46Lzx+Ao+gp3KL2g/qyMiKfHzL5TG4x9Xzbvr6pZTUGGZLlLUMF2QlCzCedekuiR14/rIcf8QWXpsMy62LEH8GTuWllvK81hMBxw/9bnClSuBw0RHdFPBv+uVdHMRC7lGuRe9z6tYbnD1MulSz7X/LIUHW9u1PlLC5foMTQZM86OXI6A2UbzeQP7dUBWdUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6506007)(86362001)(66476007)(8676002)(110136005)(7416002)(8936002)(921005)(6486002)(508600001)(5660300002)(6512007)(31696002)(2906002)(316002)(31686004)(26005)(53546011)(2616005)(36756003)(38100700002)(66946007)(66556008)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGg3YUZ2aXJYK3lwWXk1TURtVVZZQkFmVXJhL2UrSkhyQ0VQdUxHQXZFNzZa?=
 =?utf-8?B?MElldXBnTWhYVVFwVW5zdE9pTWJHZ0dUejJUcm5nc1F5WHpFalE0UEhEaklY?=
 =?utf-8?B?VnovajBVa2czVXdiZDlNN3NUUDJkRGtKRlRlM2RIUEY0SU0yOU5jeEZtcnJx?=
 =?utf-8?B?akcvampQTUlvMm8vRUJidnVKcG9SeTBEeXM5VHFZL29xS25CWVIrYWpuUG5s?=
 =?utf-8?B?WXVVMlQxQ0VTVmVILzlJTVBwUVlTblI0VHBMYmk1OEQ3aWo3dDVIT2hpeExB?=
 =?utf-8?B?c0pkU3lHZ2J4YmZOMmZlWW5Fb1YwVHlmYktKSndKeWFicEZiNkRadE84ZHlH?=
 =?utf-8?B?bkNWQmxIb0NZeHBhZGNYUG00OXhZeHpHMCs0d2dpOTNlUEFJa3JvcUc1MnpK?=
 =?utf-8?B?WjNwdTgrNGFaWlE3RTgvbjZ2SEVsR2JVMVpVRGRuamxPdlhDVS9QL2FTT1Jr?=
 =?utf-8?B?ak13T1YyU0ozcm9uUXlWeEd1eDNnMGZiSEMrSjRQbEIvMjRibDdPSTB0UDFp?=
 =?utf-8?B?bmg1TW11VjdjVS9lQm9PVy9iQnJwUUxPSU1VYzIzbFQ3dVVrNFZNVnVNeEZx?=
 =?utf-8?B?SDBsWHdFc09kUldqZWJseU5Bem1iVkt2M0tJVFhvNGQvTHR5VDBRZEM4dmkv?=
 =?utf-8?B?TzUycjBqYjhPeUdyK1RGaHJ4eDl5eG5oR3BXUTdFMlhPd0pJRFN4dFhPWjh2?=
 =?utf-8?B?Y1hGSllGWEt0akcxUmROUHREZTZLcERNR1pJV25UdkN3YU5kd09lQVVDalBm?=
 =?utf-8?B?aWE3dHdJUUwyTXhoVHNqZm9UQXNGV1hWSnpEVTdNN2dXTlorcXpscXhXamk4?=
 =?utf-8?B?a2N0aUNRUmZOOHRLaFErdDZaeGxnWk1sVkk2eERFeThCZVA4VXIvWXI2TndI?=
 =?utf-8?B?QWVLNWMzbUNYOTdQZnoxQWVIbnJ3VUovRDBVNGZQa2EyMFdLZ2RnTlRjMFdS?=
 =?utf-8?B?bXlnblhUU1UzQ2JLd08vakh5QVlKbWJOT2NPTTRYVGVDUVk3RDl1SGJadGo1?=
 =?utf-8?B?cUxzOTcvWVFNVkxDSy91ckNnQ1FPRjJabWo3b1NrZko5c09pbEVIWTRyTWRj?=
 =?utf-8?B?OGpHQVhkTzNtKzdRUzRDUVAzdU02dkdHSW1UU1JVTEJxUDBDMU9yVXdGYmI5?=
 =?utf-8?B?cEJKN01JM1RnWlpabDVMa09HdGNUOUQ4SEZ1MXlpc3VOcDl5c0RxcEczdUlH?=
 =?utf-8?B?RkF2KzJTR244dit4NzhqSURYalgycW5XU09US3k0YmNIMjhZQm41dFF1WUpa?=
 =?utf-8?B?TWcwblpVUHdUdHFzT0lrS3NBTC9qcTY5Ly9vMDhLSHVmazNZbk9raGxvanpn?=
 =?utf-8?B?enl6M2RPZ3NYeGNrbUtZQ1ZPbzAvVTh1OUN0bUtuR2tnZDdkUzI2SHFaUkty?=
 =?utf-8?B?cGZ0aUFMR2VyeENEdk9nTzZLRjlWWFdVc3o2NElvWlRQVjlqZXV5Vmc0NjB3?=
 =?utf-8?B?bTdwQUlaazdWc2haQkhNejNMZ3dYUHVYTm1NbFZ1N01xMHhaUHFMTHhLaG9G?=
 =?utf-8?B?RXVqYXVZNTB3alZ1cXhRVXdNNXhlSHhQa01JODM1c2c2S1kwMXBmSHlESHJ3?=
 =?utf-8?B?NnRUYWxsZm5YMWIrK2Y4aWw5ZUdwejRrN1pCTzRLa0Rra1RzcTJoSXpPSUZt?=
 =?utf-8?B?YVNWZHk1SXNrTkxydDdxcFBqTitydVNQVmlsWjZ5bTA5VmF6UC9IV0NENWlJ?=
 =?utf-8?B?UUZCcXZGWlBhSkgxRmN0UVlPZm5ETnFtZDJBTzFKeCs1eUtGRkszQ1pTd3Jk?=
 =?utf-8?B?TjJjQUhVd095K3BCZVpKZ2ZUVVFjSFBwZmpKdEZxazZSSGlEVmJRdkdmL1VY?=
 =?utf-8?B?cVdQZno5Y3M1WDVzVEJLZXp4WTBDcmp1R2lWcFFPcHptcElmYWJiV1VUSzZ6?=
 =?utf-8?B?NkZTdGJJaEYwUGRHcldYS3VmNWZjREpwUFZvR3ozVE5adUNYTTVUMUVHdGRk?=
 =?utf-8?B?WDgwUGc2NklKNTdPUlF6VDFldmI2Y2lQSi9kNG1SNWJOZDc3aGp5bEwxUUJv?=
 =?utf-8?B?WE94NnBIcHBkb1huaGFqUUc2NTZlVDV2ZER4WUhiTVV6UlRKa25YQzUrUUoz?=
 =?utf-8?B?cXhBNTlGNkwvalFsV2dsSDlPOWQ4VFdzY2RwdDlxcUduTUZWRkpSTEJIN2NF?=
 =?utf-8?B?cUxRL3lHMUFTNHRDT1JQTy9KU1hwMW9BVHdQcms2QjhTcjc2V0FxeGNDWWQ5?=
 =?utf-8?B?Y2xHTSsvMzQ5Vy9hSlJvUEd6em05SjVqVGdDaXI1NjhZaUVBNTBhR1g1d2tv?=
 =?utf-8?B?M3ZUVGdDT1RqMEw2b0J1WUdSSjk5TVZjeHczcExyNlREa0lSckhSUVBoeVRV?=
 =?utf-8?B?S1lEM1cyTTUwUFAvVytRTHhHSlNjT1c5RzZvN1dpalR0NHZ3SC9vUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f3aff7-28ad-4dea-e307-08da448bd9af
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 11:34:27.3890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovNK1ZR8CEINQu5z8huoBnb0ZOZbAnU4dePxEw9zjpuG9ieK0aFtL6EuxhZhM40Y4dt+lKF9U/kRUyPL7xM/4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3092
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for pushing the change.

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>

On 6/2/2022 8:49 AM, Miaoqian Lin wrote:
> External email: Use caution opening links or attachments
> 
> 
> The pm_runtime_enable() will increase power disable depth.
> if dw_pcie_ep_init() fails, we should use pm_runtime_disable()
> to balance it pm_runtime_enable().
> Add missing pm_runtime_disable() for tegra_pcie_config_ep()
> 
> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index cc2678490162..d992371a36e6 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1949,6 +1949,7 @@ static int tegra_pcie_config_ep(struct tegra194_pcie *pcie,
>          if (ret) {
>                  dev_err(dev, "Failed to initialize DWC Endpoint subsystem: %d\n",
>                          ret);
> +               pm_runtime_disable(dev);
>                  return ret;
>          }
> 
> --
> 2.25.1
> 
