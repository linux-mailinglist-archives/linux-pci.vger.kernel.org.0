Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D47A3995CD
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 00:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFBWSx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 18:18:53 -0400
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:46048
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229707AbhFBWSx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jun 2021 18:18:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCHERx0JuZGJ190PsIRKUK+yHj9KKxKe6A/TsuDJRgKI8ZzGZNRxE7GqODY9Q+LdaubzErYTNrFeGdfQsZ0/g/akQ3CjNtRVmdmFMwgD/CO4xl/Ox8zpuARi37bjCA+lRjn7mv2Y0CNcR7cwMAEi+3jowlNPCan7ocdqBR/0Vj2bGVDNh/PzmVnRZbC/0BhMT4mBAV7bYFjGF35SgRHjI3K/gLr3d1ixy5nr9nvyShUR2+ihCJffBQwPHMbjNyB3yNMbwmGqiTihpZx/GvZRMNJR/abFHAvpnjsCCrUys3xxgwR+LAFiBJ2c4YiVNQo1ZTFVWdgmIaR6w3L8O+txZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCBKr9QzoIBIjtfyZydbAJEhVF3OBClQP3gjS1eZEa8=;
 b=hPD1OjuUmc9Tg34RPHg8ntOc0izEGgpLqMfRcKC9pS/2eiiB1/bUAuPXGA0M/nXoZJnL1FRKnRRSxkHKvvG1S61uQ9EvJ32IUp03cOLNAiE/35U0YFmEYRiwYuXesGO+0lddQ18LRENuAkXRgLQzDuzPH4v6JUr74sR9npsP/4veaqLsYUQmrPzHf4OdzfPYvGCUgHbQIRzYnTltNgbo15OdjdvVqeOCVe6WIwf3gVg3Z9zHShGdRjDkPdHUCMB9QzPJjDfFg4GQyX0tAKON9sUvwH0xp204GDGPUI4uby8VDRlTmw44X4QoaeSKTlCLXBbrh0ZoLM0MwcQ1+WBGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCBKr9QzoIBIjtfyZydbAJEhVF3OBClQP3gjS1eZEa8=;
 b=fMlP4dvguigg1SkPrYfE5GoQVQpbbRRuDUC46ct+6yCrW2DJzy/UGYyV6joThCyZlnwa3iA6ssIBU/QcnHFjGEp3M6nhyavwn6KDZzRUKct/6TJBuysoEcgTwxeKDnEFevdMN/2pKQLH+Mz3BY6Gyd8N1uQ5jxanW5QscnINi1tpmt52xbzb2VzlzK4uUGuvo/nA+mwQPmsEU6Bl9PyDw9p5OqNUpT9b8W8ucFQvKOvfMod/VCmLkZcqfEqb8Ttv6FVtzR+4rcPitASZxzoFrHBbOtjKhjSTeQPNsYKb9EKnMkq91zUW+ICdVvK8F8/SO7bcbFfOqMevwo9WNgsxPg==
Received: from DM6PR02CA0069.namprd02.prod.outlook.com (2603:10b6:5:177::46)
 by CH2PR12MB4874.namprd12.prod.outlook.com (2603:10b6:610:64::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 22:17:08 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::13) by DM6PR02CA0069.outlook.office365.com
 (2603:10b6:5:177::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Wed, 2 Jun 2021 22:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 22:17:08 +0000
Received: from [10.20.112.58] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 22:17:06 +0000
Subject: Re: [PATCH v5 4/7] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>
References: <20210529192527.2708-1-ameynarkhede03@gmail.com>
 <20210529192527.2708-5-ameynarkhede03@gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <b3b62684-d905-1825-57db-044defeaa0a2@nvidia.com>
Date:   Wed, 2 Jun 2021 17:17:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210529192527.2708-5-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c279ae6-5b5c-4109-0f16-08d926142950
X-MS-TrafficTypeDiagnostic: CH2PR12MB4874:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4874743ACB96C122678C71DFC73D9@CH2PR12MB4874.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1eu+HAjnFSgGh6uRgGvxkgYnEAvzG6pPHhDavTnUtERq16v7uIP/gJ3UkQZVDm4uoHfxsTBoRahcYVYtp/ehay6Vs4bRFjZ3l6lbWQu8bjpRPnTSLZqDRU9jUYfMQJEU0NES4kw9jwUFOvG5JIQK3MzBjrjxD7RJIFGYNiubTcg9nA5gcxyWbh+z9U0FC01VU2fBLk6t6VjoVJy/PHJniuKEQOIjjEr2g8Y3TRxnim/vGXZzwkNqcaiKUAJK+KZXs3GgQQI6udS26MiQu2gA8TqFKX9B15SaSXTDE1xSH1Qm/iHXDH6VKM99pkSsIdLP3R0xbpBiM5WUWHHuMGZWCB1YAEgEPtT4rEGg2zQSby6+Kk6D9MXyZJ3glrlSxbsgO+ul56sps5V371vbvmKL33wnmKrC7tKE60vRmvW8ibhXw1PYFJhiZ5agWbhOOLrY4BEIpW600mGiSXKObOzBIsYMNAaON6xiN3i7AmLWu3qR00uGmJGUf53ZHwAwqkJOaFeE9wagOp7yEBIejdgcXT3f8XdbFvAk5V0ZMxDjzfAfe8KnjcPkEYkuzGqrgM20jbOgx8P0dq3PkLI6J5P3x7xZymxge0jAb4y7cLKFud0BUG8XP/guoCBHBY/d61HakOPUiWlXG0EHoY3ZZzjY5BGnEgf66Kqyi+QtsMJCuYsxi6Hv4ymFSVRD3roaMzR
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(82740400003)(86362001)(36756003)(7636003)(4744005)(8676002)(31696002)(356005)(110136005)(70586007)(2616005)(70206006)(53546011)(83380400001)(47076005)(16526019)(16576012)(478600001)(36906005)(316002)(5660300002)(36860700001)(336012)(4326008)(26005)(82310400003)(54906003)(2906002)(8936002)(426003)(186003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 22:17:08.2980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c279ae6-5b5c-4109-0f16-08d926142950
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4874
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/29/21 2:25 PM, Amey Narkhede wrote:
> Add reset_method sysfs attribute to enable user to
> query and set user preferred device reset methods and
> their ordering.
>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
