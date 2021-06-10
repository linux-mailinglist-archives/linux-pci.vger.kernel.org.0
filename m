Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E043A34AB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 22:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFJUSR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 16:18:17 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:52504
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230236AbhFJUSR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 16:18:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS88fto062dEWPavsmFK2G8GmejgYAf6hrBkM+DU2WOY35lsPcivm1a3UmxfyPxCn/v3FOIGea1FIH/hN/DncqpGNq7XYQlHzYMQ+a1o9yWILaEb3u21Pmew9s+XyVJ7LGf680vVO09UEkvA30jqkZ/bcM3qEW8/VSL6/6wqhP8BlDuGoxEjGKlolIZz+AwwkkOZgMrRjo4tg88OFUhxPElKg+sML9eSfkHaDK/z55xLlBTbJsft3Trgng42FtGJdNgY+KTRWgXr7rw3/n/kh1IT9pzwJe5dyPaCPp4sNZe7kSdyILsti+8s80YwfA7vIh0SMoaQtbD0muUdlnJoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPjeLtvnKG4Z4LObb6SyuvlNs8yEX6GfAI2gwhfDImE=;
 b=HXZuOmjg4W7trxI6DfZyYUM/Y8TWq9zLhGIYus9xZuDhUfeeZyI2lz0ze9nI+vrEpULVjAq7F9BfhiXUAiSVAcieZ3aGnnJa+Nyovuglonxm9V14UZqWKvEtdu+CgMeZiZJsH82mxFfnrCpVaXhMMk3FkRJPOC0e6siBviVpMvR9Rar5U1NrjK0/8PKVTJ2XqQKM2vAZCLlJZkCPO4Dge9HxnDWCqqoaxyCbKY1gao4unrcOJF+BcY/TpNXyTv4vaH/dtmiGA5lUoybk6z4YTGS7K4553ixfYocmWqzJVzofBy6NeZdNFPsVGj7krubRCAtOIUV6mj5jyOeFMf+IPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=nutanix.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPjeLtvnKG4Z4LObb6SyuvlNs8yEX6GfAI2gwhfDImE=;
 b=kEn/8XgjF61GWTsHMJY1qenXk1sqAWDszSQrOdro2D+prdYgyPIPlK2iG/xnzwjAh6L5lRct1q58ZIwHtecatFxMC1uZwVf+uz5mAuxgMwCMYOaMyyZ85PFjMVHcQ6X/lscSkGKC3pOceiEohhItlTZZ6x45jEC5/5LdfgStmQ9Der6j9zXSe6j48Zry/PSMHYfCJOSXbiI1rTJNda6mVtFWSNzxw88Stt6SrqVoUO0povc36zuj+ckcRq3xkQJN2gnFdevgHcDswqvnkJEeSyK5rQ3DA1o0iunBMw6Kpa1DtGOHraMyvsxzzwxyZoU6YczWl9r2rvEkEdlwii7Xng==
Received: from BN9PR03CA0536.namprd03.prod.outlook.com (2603:10b6:408:131::31)
 by BL1PR12MB5095.namprd12.prod.outlook.com (2603:10b6:208:31b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 20:16:19 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::20) by BN9PR03CA0536.outlook.office365.com
 (2603:10b6:408:131::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 20:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 20:16:19 +0000
Received: from [10.20.22.154] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 20:16:16 +0000
Subject: Re: [PATCH v7 3/8] PCI: Remove reset_fn field from pci_dev
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
 <20210608054857.18963-4-ameynarkhede03@gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <0198a346-ae32-f9f6-8c14-aef2721647e5@nvidia.com>
Date:   Thu, 10 Jun 2021 15:16:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210608054857.18963-4-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 953e47cc-90b4-45d5-7304-08d92c4c9bc1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5095:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50958D02086C2A8518A16458C7359@BL1PR12MB5095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxWrsq4TDr7/CNzTG/VSkUltN6t3cqd98x2/TKNoMziSl4YFwzoVOovGtIuCS/YLLklUlwV79DjC8hc1/JYZSxJlyFezB0+xZkQYyZUJovPXp2TgWRoD8RRPjMIhCvfyea56Jbv0cjMJ/sbC5RqAuo/pwwQd+G+W0vYDPRGWEksmKbtFjlZwvSipo7j9QSdSUbSFJl/1q1cGylLs+R8T5Jnrew51p/tiN4R9gKt9/1Sl8nU2mSYeReuAuLEPQ5Zeuk/PKmEECG8mvXwbtCqsqivFw5nAUuMxZY3I1uouGFvNS3zQmyESVL08uDgBynd6XZAZ9YcdvyEExEhtBMebd7rZxusEL+VC2FTX7hkkfDYhBKOQxiNhJuzocG0n2ifJor/0yd42TIeMn1yXBhNHTHjlUA0fJj2JlmvNfIaj1s5ufcPsAm7FwuLSlnyjfkulJgP1SImJVhqjtCT4356KuDzyPvTxed2+fqqYuCIsLv2GUGfdDcBiZe1FejJ1AFrkcgkRLLYnlcS4CT65yiCjwPR8lZwxTp6iEmWu+DnI1CQj1M/oBytDZTi/6+HEyr3sZu8ffJ/QVCW67A7RpHJ2IO6WmnHPKLeZb4EBOeKlBWyW6gwsGy0ZnvIS+dQh5tZWRV1TtFHNlAA2TEmaO5gVZJPrJGw2KoYSsDZheqK7KbyFdzB7Uc4YwLR8SxYX8VYN
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(36840700001)(46966006)(82740400003)(16576012)(70586007)(36860700001)(26005)(2616005)(110136005)(4326008)(2906002)(5660300002)(336012)(16526019)(186003)(31696002)(54906003)(70206006)(426003)(296002)(316002)(7416002)(8936002)(36756003)(82310400003)(83380400001)(356005)(7636003)(8676002)(4744005)(86362001)(31686004)(53546011)(478600001)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 20:16:19.0129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 953e47cc-90b4-45d5-7304-08d92c4c9bc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5095
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/8/21 12:48 AM, Amey Narkhede wrote:
> reset_fn field is used to indicate whether the device supports any reset
> mechanism or not. Remove the use of reset_fn in favor of new reset_methods
> array which can be used to keep track of all supported reset mechanisms of
> a device and their ordering.
>
> The octeon driver is incorrectly using
> reset_fn field to detect if the device supports FLR or not. Use
> pcie_reset_flr() to probe whether it supports FLR or not.
>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
