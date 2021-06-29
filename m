Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68273B6DDF
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jun 2021 07:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhF2FUN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 01:20:13 -0400
Received: from mail-bn8nam12on2079.outbound.protection.outlook.com ([40.107.237.79]:50784
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229480AbhF2FUK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jun 2021 01:20:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1nD7jVWxAVqom3aFVRK2kuNHHFTBw6vFxmKCbIMfrY6nQ3JrbGJpBCPP9g3kB3xralCwrgjGqmao84fEqw/kqB6FKct0Qvncs1d4T6GigmOZ6Tpyn4IIFv2r2tCWqegneKXWgHufMcZgJvYYlTSfRJElBBPAAgyUTgviXXBMY/eeQFYzg88VQ/pjKie6cleSfjvJSmgyYQOPTu+1UrQTqveYIYSoN6Cpdq6Gl3vbZsZ8MwgkOkOlMkC7ES/wOxplmblbYZ3jq95x+QKCMUvC78F2ZJwAloTQuxMUL7Hbl+3aFg3Mo5+Ia+VPw4QL/ZZNDITaiZxzTtX4CrCXohwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4FNYMpbFG9VwxjTld03H7PPG0JHTWYSfE8D2JTrnQs=;
 b=natRV+pkxMO68Zzxvp6WOtk1g6JpS/ZvkrVDeqUzUj47UYBrFXP35IeYm7GP4iVWHY+bYqqOMl0nHhN7TCUC2vcoFnBS9SwDpaX6UhO6tBYb6bGrKaNkFygXjvTdDJzifXU3Haq3B06u5eUy6GR67xjpEvv83xUNdsk7F2xs3unD3SZjJCZDkhbRdQm3j/NcV/RUsKSpQZX1p65lmDNj2lKdUdA5iOoQq+zcq5dAJjwmO0+xWwN1WAnmV3PBjYn7dkXaVseob1gPhCA6POph9/h6cr5mCiDhQ0cze6RfqOCurNeNQmXSqSeVH/w/SN6p7wLy4jI9Oi4lx3/o8/J7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4FNYMpbFG9VwxjTld03H7PPG0JHTWYSfE8D2JTrnQs=;
 b=XyQRn/3deVfx4FqLjQABxsdZYH5y+9A6jVdEX5qWDQha8qzV/tcnFbwo5HcU88Cdwq716Iwjx6TzXqIw4JiycAONlCjBPw0PGp37Z+gQuUjo156AWl97id4+T0/9SKmPEQpoXGc7FsUv0Md1yn5X6PvR3GVbBgs3aZm+s9pqqXvn4fW5uN1CoE0jBJv31OWu7wLWvkKRG2LLeZAp40iJxUnjFctSUYA8KprJeI60yAvXmfr5yByRJS4uuSaKbF78UvYlhJgRd9tJGhjxt7p1oyKr30KbRMXdry/DRHZPBEeaAPXRmEdTRQzpVb0+1dj3Nokm3kCf0nYcAGfESc/IUA==
Received: from DM5PR21CA0044.namprd21.prod.outlook.com (2603:10b6:3:ed::30) by
 BY5PR12MB3921.namprd12.prod.outlook.com (2603:10b6:a03:1a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 05:17:41 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::35) by DM5PR21CA0044.outlook.office365.com
 (2603:10b6:3:ed::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.2 via Frontend
 Transport; Tue, 29 Jun 2021 05:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 05:17:41 +0000
Received: from [10.40.205.49] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Jun
 2021 05:17:34 +0000
Subject: Re: [PATCH V3 0/5] Update pcie-tegra194 driver
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <20210623100525.19944-1-omp@nvidia.com>
From:   Om Prakash Singh <omp@nvidia.com>
Message-ID: <a3c03fba-78ee-d3fe-66e7-0f4e43c15e51@nvidia.com>
Date:   Tue, 29 Jun 2021 10:47:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623100525.19944-1-omp@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72267716-c20c-4b64-2ec4-08d93abd3836
X-MS-TrafficTypeDiagnostic: BY5PR12MB3921:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3921E82E5C101E4E7DB09709DA029@BY5PR12MB3921.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztE5keJM3SR2EfmdXs1pQwIsYEoyOYcF13w46mWO8r+dy0ROFTIxaYM28aEz3f91CqMC2JiRntPh13EtQ2VsRL8QS7rJ8elLVopheIQMkYfE12H7ma2gf05ssbD6C6apZ1oJkazjQY6DOdgK7NGEvt9wbHBSg9pJKLCn6dDeogVsrhm8ogifPPoq1UvVQ0BH6YkCb2kSYbnYPVf5MyeZJLlMwa6ENvapR8Qmw5jwouAliU591b6ZvV+FUlhJoGvLGkEKZiHNzZJLxcDlYoQtTijZMRXQoQ/JdQkMMUA7SBrLPTQWlpk63Zh5Py8Dj8EPu3oWuh99E4aPQXB63XsnWRZCY5lCpjrT0oJ2MIOQZy7WhIwEN6YgbDnapDqFHZ9pxAUgF9+B5xBO1QR4QLq+G2O5tZFjIbIPJ3W7i9LMsOhKRpQ7o8c7dCLPiV3/5VIUwMJOQVotrxXLAYu+tCSpfq/dPUqo4lEOTbNvqVjtdtd1AL4ZbKvZTiLvHE8lc7ai6A3vXCve5kI7ZsLm448+gHqpH4CntORx52yIW1YEXwtIm/aUCrPflzvgzs1dA+Xx5B0e5ioXHZiutWXUC/f/RSgA6/V2yUMznCGpgYQn7ttGdC7+lf5GtNutfz/MqCSzEv8ri+FeQV/NmTLybCXWRkrmZvA3p2GLTI0lrXRRdNpfalioVqFUMh8sywNKbVWzRW/MCPZnQVp9u0VO/5fhoRqx/fUBTjKoQScmyCrNH2FBfp2g1PPJTFHrjC/N/MS4L0KPJFd+eUA0/V952wM1Lxrx7OwIfLpMcuv1EbKwLeaengXUpn2Rl43xYkf3kbbiRHGcQIfvp56JULxz/yua67JPtCj5gYlxgGMO5fSm3hyhqtioSEXwqwBTg9EAgHCrb2D+SbRvnXkp6QCoik0VRQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(36840700001)(46966006)(15650500001)(8676002)(8936002)(82740400003)(6666004)(336012)(426003)(2616005)(7636003)(6636002)(356005)(5660300002)(31686004)(2906002)(70206006)(70586007)(107886003)(53546011)(54906003)(47076005)(31696002)(478600001)(4326008)(186003)(16576012)(16526019)(83380400001)(26005)(316002)(966005)(82310400003)(84040400003)(36860700001)(36906005)(86362001)(36756003)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 05:17:41.4891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72267716-c20c-4b64-2ec4-08d93abd3836
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3921
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,
Can you help review these patches.

Thanks,
Om

On 6/23/2021 3:35 PM, Om Prakash Singh wrote:
> External email: Use caution opening links or attachments
> 
> 
> Update pcie-tegra194 driver with bug fixing and cleanup
> 
> Changes from V2->V3
>    Updated subject line from "PCI: tegra:" to  "PCI: tegra194:"
> 
> Changes from V1->V2
>    PCI: tegra: Fix handling BME_CHGED event
>          - Update variable naming
>    PCI: tegra: Fix MSI-X programming
>          - No change
>    PCI: tegra: Disable interrupts before entering L2
>          - Rephrase the commit message
>    PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
>          - Update return value to -ENOTSUPP.
>    PCI: tegra: Cleanup unused code
>          - No Change
> 
> V1:
> http://patchwork.ozlabs.org/project/linux-pci/cover/20210527115246.20509-1-omp@nvidia.com/
> V2:
> http://patchwork.ozlabs.org/project/linux-pci/cover/20210606082204.14222-1-omp@nvidia.com/
> 
> Om Prakash Singh (5):
>    PCI: tegra: Fix handling BME_CHGED event
>    PCI: tegra: Fix MSI-X programming
>    PCI: tegra: Disable interrupts before entering L2
>    PCI: tegra: Don't allow suspend when Tegra PCIe is in EP mode
>    PCI: tegra: Cleanup unused code
> 
>   drivers/pci/controller/dwc/pcie-tegra194.c | 36 +++++++++++++---------
>   1 file changed, 22 insertions(+), 14 deletions(-)
> 
> --
> 2.17.1
> 
