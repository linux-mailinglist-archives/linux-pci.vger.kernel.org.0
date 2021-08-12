Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93723EA519
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 15:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbhHLNEp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 09:04:45 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:1345
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235092AbhHLNEp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Aug 2021 09:04:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bD9fR5EDMC7OssJrOZj3ECatvCbuu6TmcAi6eBBPqP80zLBNMn+Kym72PgMh8mrpuv7yj0QTvhQHkHcoHj9VM3nLdWp50GXXp9U6IRWk4GaBEgrLRwy4y0PRVfAcnzdsBe0X8b/4IWATh8iyVK48Yf9c/luYg2sy3LZVv6PQyODm/uypUPmnp7hkqHsRqM8vTYyQwzzTtxg++yb0EuF6Evv1TtK9bcGgZFlYWrNaZ+8PVi83m+P1dY2cXQZGi7O11/8pFQRK/OnbBnArFeuv8u9DT6y4E9IsvUSA2MkUrEfUC+lvjsMbtgOKZS5VM/2j/jJ/ecGMLOGr96SspBZkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mom5duWsg2jqNgF5yYMIXqEtiLapTvCn/c0m5mXvs+Q=;
 b=LVLCVwZxw9BsQBiMimpxB7VXH/BX1RB+Zm3trecN+hUynAk3j0OM+dlyuUeCuE0dmctHNzFKPeC40E+HMCHoZgWqUsQl/iqJCyU90b4ZysuBz+rflU5ie2lgl6UhHHBdNOCaQ69Oa0bIwFMpTxEMaM2nR9HOcpmyIEyCXxdIxklHyVtwetlCuJsC31PAZObFofxO2vw5iEuZ098D1oq7y9hEOyL/jerc4DXCME6OVjXEefHnyFkRF6yjeOLgigP8RZ2U1Fr3lHsiKRlXOtFISTsAapdqGGUPnTAyRQgIFuSlzCk7TdFeLfphRwEkNe4KWpNJitmVwWkgUa5sCYgU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=nutanix.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mom5duWsg2jqNgF5yYMIXqEtiLapTvCn/c0m5mXvs+Q=;
 b=Yhnh+/Xm9ANOWvmf+MnVNZP8L54b335EbShzVKrKzQ8O5BBUwImAnsgsxAckbGOhPQ8Vq39dQ4rOvicLxG1dKwkWWzWbQaiN++S2P53m+hzyiiz8/Rmnh76ZKD7wBEdAU19prpikBVy9oYD+ctp01SMBNx7l2twNMRWb7oL6gswkM5KBVd6tpwWAQOOKouFLcSevgLIvBqt1+aIwChv+7qulKmXh3at9riNAk+0W7YbJMXxa/imfgLqrYSRbcYAboGJQCt9joglIApgcHtyT50hM9UtmkHmPYN0gXL0XdFn/aAeTB/7sOfTcla/j8UuDp0YKk7cSOuRWU3ErRUNcBQ==
Received: from MW4PR03CA0130.namprd03.prod.outlook.com (2603:10b6:303:8c::15)
 by SN6PR12MB4734.namprd12.prod.outlook.com (2603:10b6:805:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Thu, 12 Aug
 2021 13:04:18 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::b6) by MW4PR03CA0130.outlook.office365.com
 (2603:10b6:303:8c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Thu, 12 Aug 2021 13:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 13:04:18 +0000
Received: from [10.20.114.145] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 12 Aug
 2021 13:03:49 +0000
Subject: Re: [PATCH v15 0/9] PCI: Expose and manage PCI device reset
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Amey Narkhede <ameynarkhede03@gmail.com>,
        <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210805162917.3989-1-ameynarkhede03@gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <098c3305-55ee-9244-792b-4281a2ecd158@nvidia.com>
Date:   Thu, 12 Aug 2021 08:03:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210805162917.3989-1-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fb6e98b-0e03-4cc9-3b70-08d95d91b1a2
X-MS-TrafficTypeDiagnostic: SN6PR12MB4734:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4734BE3FD0712E661C32DB5FC7F99@SN6PR12MB4734.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaQM+EvYlPwD23jFwUnW1frVJkHsqD6+Ju/dSdeURdY/BEgP+l5/Fpx9I5SE9KdR2vVRTzdAT1nmSk49BT66rj6CSfeh7yNPOHS1hIdKSzfJYLofYO14gS9apBhi053p4mO8DbqwhmNy/owyTROAkwm8oqxfhBcilR5X5lVcEtw6OAp/66fhtvyqpG7YV2FU4S9WgMO0QSEpKO/l8taA9Aee+XOBGomU/E3qxA3IcHF9dq3LTZi6nHhIUz+KDVMGPFZz7PLVXmY0MYBQwhAujwe52PpEhP3qAVgBY6qLYlInPrjZX9L3H05UzfEdKxmLMYvuG44oBOBWxfs4b6ZHHyL4CurBBddllpBZQ8AJVtwkUgmr0F1lZNjknk+PjQSOHy7F/apXRWB+bh6SwD4VswrwZ07hjGw7g9NIMZslLxwN7+x0GWEZu7Upoh7HKJ7TLdDSz1OidWKDjaNaIcDnwhHH/sTuh2IhJeTAX6ONOlA/Xs4SUO97ztEQSljYR78LtS7e5FSfr9aXldkCGKEZEH7UM/UHOi0N6QKxY9ryG+rBJ8iGAPp949diqKJK5Dsd9z0s1T/Wu/qJiHGbLrPLunqssqggot9EHm5zeTbvz3nCuGBOjfBp+iWVBsp01J3VyELsE0mqsu8P5YppM4dpOL9szlAV+GQ0hyIkI6Tff+ZSkscFih0sJpW2zdOmh/ouQ+fHozE1WHutvJJnhjqU0I2H8qLW5fJ36jb5qKM8KVE=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(336012)(2616005)(36906005)(4326008)(16576012)(296002)(316002)(8936002)(186003)(5660300002)(26005)(16526019)(70586007)(31686004)(70206006)(426003)(7416002)(7636003)(6916009)(36860700001)(86362001)(53546011)(82310400003)(356005)(508600001)(54906003)(36756003)(31696002)(47076005)(83380400001)(8676002)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 13:04:18.0236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb6e98b-0e03-4cc9-3b70-08d95d91b1a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4734
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 8/5/21 11:29 AM, Amey Narkhede wrote:
> External email: Use caution opening links or attachments
>
>
> PCI and PCIe devices may support a number of possible reset mechanisms
> for example Function Level Reset (FLR) provided via Advanced Feature or
> PCIe capabilities, Power Management reset, bus reset, or device specific reset.
> Currently the PCI subsystem creates a policy prioritizing these reset methods
> which provides neither visibility nor control to userspace.
>
> Expose the reset methods available per device to userspace, via sysfs
> and allow an administrative user or device owner to have ability to
> manage per device reset method priorities or exclusions.
> This feature aims to allow greater control of a device for use cases
> as device assignment, where specific device or platform issues may
> interact poorly with a given reset method, and for which device specific
> quirks have not been developed.
>
> Changes in v15:
>         - Fix use of uninitialized variable in patch 3/9

We would like to include this feature in the v5.15 release. Could you please look
at the updated patches and provide review feedback?

Thanks,
Shanker Donthineni


