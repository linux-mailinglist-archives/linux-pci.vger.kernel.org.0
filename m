Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB13039957B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 23:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFBViu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 17:38:50 -0400
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com ([40.107.93.52]:22560
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbhFBVit (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jun 2021 17:38:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFdUX2+1pCluPIkHpabQEnhsjvnia3ChyiA71Qbv+Ly7ir8fb3UcyRIm8j1wGZ3yaqQuLui2nz0kXVOGe4YXtbw2q2FN/ei7YEO44nh6xjdBydLG2RlfMl0Q9CW5N5wHlEOo6KULE0cwNwYI90GGGaRhCdfH0hh437hAb/33gSsk/UAhCUtKdDQwfPygHjDYFHaG4Eeu99021FNnZt6BBsAOj4KVTIVlKj41nuKkUM4lU9gz9GKB/zFIJm6Xb3jKUC1r/GkrPMqntO6PEcMw2YIviN716pt30mHAnTxRUyd/nPTrhwMth1VSSXs0uWek/dfV6vuJsLYUvLo92g7Uhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HZFzj7V46lVo1PFYOwlDR8TAb266MCvt4XTLltOXKY=;
 b=HDXw8jjQBgXkeNNeVuvVj8S1tm7khej6esLqOF455BgByzMe863W9ZtQlrDUeaVQqGGN+cGBXn+o0+WsOWH2xenr8U6CYMNNYFaVH+JVlTSF6GKY7hE/bD2QYTey9+OJYx5Ss0ckn3A7JhjQsx8SoenlvDWG1V6wdn3A988Wg0S1yPQIFk9pqwnVwP+gUrcGUQh0Xzvl20v5jZD1bMPVXIL6YEblehfwMnHtXiRN/Hx3sUb+zWzEWAzJOZTrH6hFQteUaKtSZ50np34ZrdM/lOBjV1JWFXjwKHT3yFXIfio/b1AgmriBCKp41ywQOlAinD0WBXzeieoQ40CuVuJJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HZFzj7V46lVo1PFYOwlDR8TAb266MCvt4XTLltOXKY=;
 b=UkH2YLTRhIWDGVVsQbFfiu+I7/a5K72DLVJK56UiGdJIOao/JDgHdb58Ed+C1LvF8bVMRloRPvqmr6YPqtvA19K9PEH1f0zJ/jPJm/QnlQXQYJMl1vFZUGSMTQZitgme7MNKtmKIaKiqulm4v0Ul6hUsKlOdSBoqftkM/xL4M75U2BamO7GsRNYDH8bHqdY0aPp36BgKqDId06mD7bl3itgOj29KCCrF9zeMZBJh9s2f4gnFs+55L+XLKenArCf31Bz7+gssFA72mxIBQCe7KhII6iDeDMoNDLoi3jmHCV2AHOP0lydfVcApYDHo6Wi/FeFxn0bW0ineBsLtsPIweQ==
Received: from BN0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:408:e6::15)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 21:37:04 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::eb) by BN0PR03CA0010.outlook.office365.com
 (2603:10b6:408:e6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 2 Jun 2021 21:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 21:37:04 +0000
Received: from [10.20.112.58] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 21:37:02 +0000
Subject: Re: [PATCH v5 2/7] PCI: Add new array for keeping track of ordering
 of reset methods
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>
References: <20210529192527.2708-1-ameynarkhede03@gmail.com>
 <20210529192527.2708-3-ameynarkhede03@gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <060a92e0-70a0-35bd-0b0e-fc5566608b77@nvidia.com>
Date:   Wed, 2 Jun 2021 16:37:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210529192527.2708-3-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f22fcfde-a195-42af-9d94-08d9260e90af
X-MS-TrafficTypeDiagnostic: SA0PR12MB4351:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4351E47A372A4A0173720834C73D9@SA0PR12MB4351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKxvhcgBnfO5JOFr4jVyH0GbW2RToagY73VxPDYpfxALTCkAuUvKxexZfAaUAgrw/1/WaayQ8SjkuPvq/yF8f0GuNdQpjgU7EXCXkWIzz4FeIMb0ubG2GuTyEd9lJ3rxWA/694dEXTNLJbDqgQUi5F9hXX+/pFuYU77i85D1WBco3jGSFo/aXDdn/v/f9vkv8lKItpyHNydquBIi8RjQoCMXCkJ6p5mJ5Cn7SqN00JVL+VWk3iwLksDXJhQdlnfnTCS1HiInvw7eT7NKOdsqYblXQM0reHd4NjmrKkmdp56pI8uIOc4iN91aJae5W/lFBCUoP+7Cw5TqhuZRnzvVBw02VkM1fXn4wIrWkghlH+nYTWltnHco+BxtFZEtW4/Zg8hQm4nfO/2Q0+FLs6d1LQFDqSAum5TANvSQdTAmM3/Zww5X2FflnA1rNNKPrU56eV3o5aaqQ2V2UKh18GE658ZGrS8a8saYlL2vDbEqk16EecdEpoxqhFuOs+8oR8vAWucBJVQVAMNSsZqYF3jggx0Fh5DkoyGRLpXuXYvLdCpf/ecLJ122c0m91oUXoL8t++vQN3dzPk7/kOm6raA48O7D/yd0ln6h4kcgyWR5lEzEYFZySkS4N6vsgrwBRpsTD3upIiC2Ud9Q+0pL7vNiJjGqZqcLXPQOfxV76VoyT9gSGLPIGcAkgQjdIz7zJC+y
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(70206006)(53546011)(54906003)(82740400003)(478600001)(70586007)(36906005)(8936002)(4326008)(5660300002)(110136005)(16576012)(8676002)(86362001)(31696002)(82310400003)(4744005)(7636003)(26005)(31686004)(47076005)(356005)(83380400001)(336012)(426003)(2616005)(316002)(2906002)(186003)(16526019)(36756003)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 21:37:04.6702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22fcfde-a195-42af-9d94-08d9260e90af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/29/21 2:25 PM, Amey Narkhede wrote:
> Introduce a new array reset_methods in struct pci_dev
> to keep track of reset mechanisms supported by the
> device and their ordering. Also refactor probing and reset
> functions to take advantage of calling convention of reset
> functions.
>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>

