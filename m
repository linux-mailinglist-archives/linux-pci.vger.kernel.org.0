Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8091E4A61BF
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 17:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiBAQ6y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 11:58:54 -0500
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:21408
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229847AbiBAQ6x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 11:58:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0dWhh5K/hTXuLbdDkpIjTdaoZjfupZVWqc9zHkLffeC6V5TR4huuJyGP54QVDmsZu48V7Xh3cYplf2oBRrFlCl9DJi+ljBeilG/s7YdLJK6ThqjUigivbM+J2K+nx2caRBVFzqSDXRM+PhLDqDSdKDYtc6qj4w8Y7x3xiEBQm8ij1nbQfH+hB/plqFSQzCxDaFjlmgNaI5pUKQHKlyxODF7AXD9G0gNLSE/rP4GZl7eBivSaP1LC98wvljuv5iczo/9Hnppje4AsNjwZM/CtODsNcOvExC1rZH+3YFverad5xLiABE2WIHsSYt31TxhrEOt0O4gTEn+1+coML8atQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1Jc9WOCPz2c+d7N7BqRNTNpvgb+FRKwXmuwtiK4vgE=;
 b=d9eJgo/JPYNaEyHblAmF760nD2BcQPhscq1BUYqJ3fmePBJJQdvRJAddRkHiIg7lIDxLIoApPuxzVr6Qe0GU1Vq2ubKnEXPcP+pI2ZIg50jK1iQ9DMhCPYVifDREGhzdCdrrVnfWl85JF+8VHlZZojs1V2N4MZE0Yn1+/Mqe6J23/+3Sc/ROAeN4XiK7nw3eBlwMsAgj/CJQl26S/t/Nc36RugRFM+mE2LK4z0ggCTU0+Tkv3AHkTgkSP8C4vgI52CJ+SOV8wZVxZDohcm8nfJhl5bbXZz3jiHFj0yHXxvKDOZ+ZLUlJJgF35GbBoQyCCw78ar+TcMXDZ7pzIJuMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1Jc9WOCPz2c+d7N7BqRNTNpvgb+FRKwXmuwtiK4vgE=;
 b=qXR1McJmn3iRlMdReE1YB3VUjJZPEow5E9BW/zpLN7j8beFBN7drx6GLcYrhAXqgOHta75HW32o25vG3c+rgNhFJAfRH5e2ZiNWZd1+zNZav3dVy+reYN5hk6GYmBVedDWVDLGmipvHhzWuHuxzFobaOd8i7i9tAt02FtqmiHbg6/j4sXSzAlOb7W4pw4shswWWxz4FBkxsEIlpR2K04/JguauLcGy3bYepIV9ZphF3OLmggc+myF7QzjeGeFphp+DKmzgQD1RnSyrN5ez2h4odpfWVKgOcJL4CiZZpItPkPzErqcdPxSZGjuXr+SY8/LROXLFfYiLbWO/6cs5t1UQ==
Received: from MW4PR03CA0276.namprd03.prod.outlook.com (2603:10b6:303:b5::11)
 by DM5PR12MB1371.namprd12.prod.outlook.com (2603:10b6:3:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Tue, 1 Feb
 2022 16:58:51 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::6) by MW4PR03CA0276.outlook.office365.com
 (2603:10b6:303:b5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Tue, 1 Feb 2022 16:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 16:58:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 16:58:50 +0000
Received: from [10.25.79.72] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 08:58:47 -0800
Message-ID: <0bd9fdc1-99d4-1c59-7343-3708b331b2b5@nvidia.com>
Date:   Tue, 1 Feb 2022 22:28:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: Query related to shutting down NVMe during system suspend
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
CC:     <rafael.j.wysocki@intel.com>, <hch@lst.de>, <bhelgaas@google.com>,
        <mmaddireddy@nvidia.com>, <kthota@nvidia.com>,
        <sagar.tv@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <65b836cd-8d5d-b9c2-eb8f-2ee3ef46112b@nvidia.com>
 <20220201163054.GA2838889@dhcp-10-100-145-180.wdc.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220201163054.GA2838889@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65e157f5-a374-4b9d-41f0-08d9e5a41fab
X-MS-TrafficTypeDiagnostic: DM5PR12MB1371:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB13713861F61D9B67CA24CB55B8269@DM5PR12MB1371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwtsEU78TzuXiI0Lhsmq1CyVpd+Xa2kWBIpZIPjlbUTnherpl4S/mIPtFwavw28mydO3kJDZydYeP2F/fmXsX55+q3cEWZgXiGmPZ9sVsgicq3H8EaIgKMR1MZ2bLZ5sTHq6XJbqOReZPrihf9Qou8GcDWJhaGx1HzQrF9p7UUPnV2hHtVI7etsHA045BF8LTJk7+7Jj8TzkTehjFvkkQGRdKKzCrYWduTUI8+dbUCUIiu+f3aFgFk5eHA458BwRyAAe0UhHMajHR5BGXI+LsEXKEy2Dr4ha0m+cmgi+AlK842JVWvVRHluj02wajssp2g4YWy3SaKIc5OLas8rORZwY2BShp1kHIF6EwuBTW9qkvLOmL8M2azRfbKKvHpLw2/UsPAjBypBy7dVCjroD8zFQMayXbqUpIFUUeQcVc1GfGPZyqhFELrr5erRKKZzwE2j4CBx4/GFfhpBx5AapsnWWLyk71EGIkdmk3dSPwGsEKK2U+1+KK0hQFon0NR556uQEfl5ui43X/Sc+24W7rgNTN5nl9hueVYiMTp/rdBTG+OHkpcDVVY2Xpew6JQk5EROQjOMMLaPXrctdbDSDMH/uG+TmcQGQ4MT7xDVW+XBox2jciRqlG/PYPeM/4qeA6Zi4dv7Q/e2pTbnnh7BcNoRuy7hk+5pFIUTbuC58OaNeewLaPhcYRzOFX/jtzK6IqquWA8bBmM8DoQg2V3/K1EpoHtoZuXyJtjmVETBQcA9ZCb/aOKuuV7ycVV/l3+LRy4HpVMjWWsHLsvD4wtvLQyJjiwWoUVcr2VNOUUjnfXgSjuA6WOEoPqW4xz/W6y2qIqHuZL4LqRJXXAcOyCX8Gw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(47076005)(31686004)(83380400001)(53546011)(36860700001)(966005)(508600001)(6666004)(186003)(36756003)(336012)(16526019)(26005)(426003)(2616005)(40460700003)(8676002)(2906002)(4326008)(70206006)(31696002)(15650500001)(82310400004)(86362001)(8936002)(356005)(6916009)(70586007)(81166007)(316002)(16576012)(5660300002)(54906003)(43740500002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 16:58:51.7256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e157f5-a374-4b9d-41f0-08d9e5a41fab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1371
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for the super quick reply and I couldn't agree more.

On 2/1/2022 10:00 PM, Keith Busch wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Feb 01, 2022 at 09:52:28PM +0530, Vidya Sagar wrote:
>> Hi Rafael & Christoph,
>> My query is regarding the comment and the code that follows after it at
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c?h=v5.17-rc2#n3243
>> What I understood from it is that, there is an underlying assumption
>> that the power to the devices is not removed during the suspend call.
>> In the case of device-tree based platforms like Tegra194, power is
>> indeed removed to the devices during suspend-resume process. Hence, the
>> NVMe devices need to be taken through the shutdown path irrespective of
>> whether the ASPM states are enabled or not.
>> I would like to hear from you the best method to follow to achieve this.
> 
> Since platform makers can't converge on how to let a driver know what
> it's supposed to do, I suggest we default to the simple shutdown suspend
> all the time. We can add a module parameter to let a user request nvme
> power management if they really want it. No matter what we do here,
> someone is going to complain, but at least simple shutdown is safe...
> 
