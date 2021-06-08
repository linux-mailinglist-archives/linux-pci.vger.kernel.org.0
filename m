Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A713A02F5
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 21:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhFHTLc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 15:11:32 -0400
Received: from mail-dm6nam08on2080.outbound.protection.outlook.com ([40.107.102.80]:42048
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236435AbhFHTIK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 15:08:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNgcqzgHJdpE4/BBwUMUUz163t5f6oE6rcBQ0dHoZaxEff2otJ8ZnsP1DvhQZmJ8uVOrFG/O/FCbQHah1xho33G/WnhbzjoUEeCPtCLcdb0Zngi4ibQGk5brdVt8A1Kh9OgwOaxFsLYAG50Rc3HSPAHO7RBrpIU3u/RPH+uRQbuTV1M92DJB54xnTw6OqsUdvuqRagZ1oGLQJe9o6UF6OxuTkeV/pKuwhBPw1gwLKUEmJNAARkf2ScYsat3tm7g7bDgX4kKLSTeYmXtih75HHcYQndNHKzv13ikpcMo5vpgbfMuaGjFsTf6CFU5D2D+C8s4kIk9qcX/Y+RMuZqwCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5XtHq8GCN9l88qbJNPrfuf54MjUrqp9AiAez3dplrc=;
 b=j4GrKfX3846UQzDHUonTLHsyXGJagdqNYZq0fKpSNdz5xzzR9MCNH0W+z4BxYGNCDEHcmF0D3bhDjkTNsycSpogocy7CymMhqFbf4xV7ejD/e7s5wPd4iaPiYFCMtyLVknx98/mqjfMXjZ19C41AgfVBGqRvGzAlz4dcxdZYDuGPIHch0bDVfKn+wxNVTHR3VU6xVysBBW54Rm1FpZkjxPnHfked2Px0bIvDoCihBBeo+ZkH0S+XFv23L/xOkvrrOwhaqLe6gwnmgRJ6DfVoNr492cltPkpzd7J8nExuagEYN2MonxAN1xFxt9JEy+NfK4IMnxpkK0dK6FiB0hNp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5XtHq8GCN9l88qbJNPrfuf54MjUrqp9AiAez3dplrc=;
 b=ikT8rhuJzIgo6TP94/eAgLIkKp5NnY0+NbiFp2ExCZy2w/GxOrLDEF7JMXS0JalS0ZkAmBYRVdf7gZ7BKN9M8lBmMWzZcbzJCMwUkGxYyHNLnPXOGokiqZ3Wd5JFL+LEz3rne8YOOSOtoESkf5pBNn4pVQ0ps/TlCVCeZxdacKh4RkxFR8zOtpyEVnPCoP1vn9lNeyDQmPsDO2N6JA7l3K19JfzaklHYUmxJ+/UHwXHqL7TTgAnjFAkYzR7vb5ftjIF7OUs1yNr1tuIAI/iZbPqo5IaqibVFCdKmRfXNbcZ6TxA3hBu/ogl+BPJFQ/N9CVLLxr7hQ3zFs84+pllQDA==
Received: from BN6PR16CA0021.namprd16.prod.outlook.com (2603:10b6:404:f5::31)
 by MN2PR12MB3757.namprd12.prod.outlook.com (2603:10b6:208:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Tue, 8 Jun
 2021 19:06:15 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::34) by BN6PR16CA0021.outlook.office365.com
 (2603:10b6:404:f5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 8 Jun 2021 19:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 19:06:14 +0000
Received: from [10.25.75.134] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 19:06:10 +0000
Subject: Re: [PATCH v3 2/4] PCI: of: Relax the condition for warning about
 non-prefetchable memory aperture size
To:     Punit Agrawal <punitagrawal@gmail.com>, <helgaas@kernel.org>,
        <robh+dt@kernel.org>
CC:     <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <alexandru.elisei@arm.com>, <wqu@suse.com>, <robin.murphy@arm.com>,
        <pgwipeout@gmail.com>, <ardb@kernel.org>,
        <briannorris@chromium.org>, <shawn.lin@rock-chips.com>
References: <20210607112856.3499682-1-punitagrawal@gmail.com>
 <20210607112856.3499682-3-punitagrawal@gmail.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ac6bf3c8-fe8e-5897-b225-699a7c46a818@nvidia.com>
Date:   Wed, 9 Jun 2021 00:36:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607112856.3499682-3-punitagrawal@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69b6990a-2749-4593-7863-08d92ab07d0d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3757:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3757BB2FF950C21D874CD7C1B8379@MN2PR12MB3757.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvYnF2eWSs8fJ+xrJv7oR7Uh00kYJMioes8bV2xb4mZVng6bGquYoJ7sHQ5x5IJN0rgdK00bHWxST8oziSVP3fMzAy/50E9PXkx+0pqA/DlVz2vdfpvc7MKsBoaYXDm6G66Up4QamuLfnync9Q0u3ZmSXEXoRd93E6Zrb1b800KIQyhz1CDg4zzgeBaV3MPC1hUqLZtX8sFMZSokZ6Ccg0CTzBN4M8BnnzeBcQukd1c9QAL0wqp4TGgf+YvQcK6sEKYSW6Hw8Z19/WPggmXiVdk7xYoWwURKRbLXN48CB7WsnIkAKIOQ199n3dCdyznSlgsiqAa/0BXCZXjZQSbL++14978eEUbm1gqhiNvHTpv9sb5MBzL2n8woK2p+BxonKgzn02m/24HHiLHcWLQONhrIvs/kJtVfYmHptZbYMR/tPfwkTq2ht66c5ixNyP5fhw5ePnKckL0+soOuQc556u3tdJUwyisGitE3AVvzNBjex4gM29JABB/rKdOA0SrQZHqeIpBb3mwAZfyWUXjsbYzCtrh0ssuMZpGfCdpt+KhwgN8/B21m+A44rQ8bbCnolM1phjvKqYEFDqP5H4pNfKwcebpaTe7dVM7vCU0NmsO47FWAqaaGtAImAHyH+nEzGnSgtm9/amjuIcgzfzMQCnoH/uGgUmPh/Slt40ZxexhqabNsFkc8XYOAStOYritF6HoEQJAD+WVlE5ldaZ1lzeyMVY79iBqDZxzMnRbCmMQ0onW3vVFoq4p6+C6kKbT+bYiVE9IdPqBdHUMwEh05Uvj8S1B2t8FzNYE280xClv/aidWTNHYvT2Q+MQG7XIvd
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(46966006)(478600001)(2616005)(36756003)(7636003)(426003)(336012)(36860700001)(966005)(47076005)(82740400003)(26005)(2906002)(31696002)(4326008)(356005)(7416002)(53546011)(31686004)(82310400003)(5660300002)(16576012)(110136005)(86362001)(54906003)(36906005)(316002)(186003)(8936002)(70206006)(70586007)(16526019)(83380400001)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 19:06:14.8599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b6990a-2749-4593-7863-08d92ab07d0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3757
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/7/2021 4:58 PM, Punit Agrawal wrote:
> External email: Use caution opening links or attachments
> 
> 
> Commit fede8526cc48 ("PCI: of: Warn if non-prefetchable memory
> aperture size is > 32-bit") introduced a warning for non-prefetchable
> resources that need more than 32bits to resolve. It turns out that the
> check is too restrictive and should be applicable to only resources
> that are limited to host bridge windows that don't have the ability to
> map 64-bit address space.
I think the host bridge windows having the ability to map 64-bit address 
space is different from restricting the non-prefetchable memory aperture 
size to 32-bit.
Whether the host bridge uses internal translations or not to map the 
non-prefetchable resources to 64-bit space, the size needs to be 
programmed in the host bridge's 'Memory Limit Register (Offset 22h)' 
which can represent sizes only fit into 32-bits.
Host bridges having the ability to map 64-bit address spaces gives 
flexibility to utilize the vast 64-bit space for the (restrictive) 
non-prefetchable memory (i.e. mapping non-prefetchable BARs of endpoints 
to the 64-bit space in CPU's view) and get it translated internally and 
put a 32-bit address on the PCIe bus finally.

- Vidya Sagar
> 
> Relax the condition to only warn when the resource size requires >
> 32-bits and doesn't allow mapping to 64-bit addresses.
> 
> Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Cc: Vidya Sagar <vidyas@nvidia.com>
> ---
>   drivers/pci/of.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 1e45186a5715..38fe2589beb0 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -581,7 +581,8 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>                          res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> 
>                          if (!(res->flags & IORESOURCE_PREFETCH))
> -                               if (upper_32_bits(resource_size(res)))
> +                               if (!(res->flags & IORESOURCE_MEM_64) &&
> +                                   upper_32_bits(resource_size(res)))
>                                          dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
> 
>                          break;
> --
> 2.30.2
> 
