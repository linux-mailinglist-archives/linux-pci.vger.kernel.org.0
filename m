Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A7E4A93B3
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 06:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiBDFhh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 00:37:37 -0500
Received: from mail-mw2nam12on2042.outbound.protection.outlook.com ([40.107.244.42]:65025
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236404AbiBDFhg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Feb 2022 00:37:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BILbfTc75B49atY89iIhWRAji6bWlAGGbG7+S3MUF+erA1M5Nxql73j8ZNE1/YEMisJC4h+ohoma30TBva1xq/5MJhOMKown3elv0qJ6Vax/S2zAVJryKgdAmhHumR60wFOXmwpCs/rkrONNgdkBDbbXIAg5YbAKtdz/D944TQptn0rh6opbmPwuHjJ7ogMAy8hfpy3JcrTPeIMvw6IlRDVEaSxBq+ZWJwbYGj1HUMEn2piJ9Jbi/iLpWNE5R+/oHbmdK+yLbwlf8grZB5CBSWv8JFtTpSOs0OQbbkLNbQJelebnVnL25cX29Rnte/NmlOQSb2W3necBz/bMpiWdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbtGn4EFi3CXps3faYz4/9xa/rdHEe8r+lT9OFqYHic=;
 b=KkT2Apt15VWdz7cfHBvcTiHdz5xtdOWb/QCFZswqlbUr7LYjnomyui69Gb2GjwTp2RsABvI+LhyHXi+zVF9BZnrjgwyYx4dnBM9Q84Ia05QVy9AcxuB200vReWAPdVKaaLT89xedjrUB0A77Le9A2gphvYivg72648Op0BC0PL10+XtXYswsoP7ZrQUSgfjYkBoWUrEruC5lFb14knjLFk5e5RSr5eAz4kv0oMuT9/9qmfWnseifQSUCyGmCO3cGEGLh53FQ+++BHDq2FjELxK7i+Pxir9cjutHCuJR1sNgVtcn+QueTCBSyNI/cbExMU4gde96MnivpS0uFCu/G2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbtGn4EFi3CXps3faYz4/9xa/rdHEe8r+lT9OFqYHic=;
 b=MaHo4RgZs/bWyBx+SfToIUe1EZcyTOAzsNLkjKOC58CqIf1erW/qT6ohByH3Id16AKYko9jlqAFBAVp1yrnEV/ANk5tSqM8fLklG5pqB7NQo2GNW3FiwHKBJuorDi8GRb5TDi3eCONky5hK5aUg3PNnusDG37SPzKBnZ7ddnY2DxgnqF+rlDqD4T4fvnJvKc91zeUzyDmZt+D9FsARvaY1jO48Ah5EBuZILJfVPhR5CHQQhO6ZCqlv8qUd2yqpO5oiosoO+HIK+MN/9aUMB+uBJkbKXT6uMMz8SLoRLA/O3X5EJIy3wm3rP7WjBaA1aUTTvCMozzJaMCfX3k7FBddw==
Received: from MN2PR12MB3550.namprd12.prod.outlook.com (2603:10b6:208:108::22)
 by CH0PR12MB5385.namprd12.prod.outlook.com (2603:10b6:610:d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 05:37:34 +0000
Received: from BN9PR03CA0147.namprd03.prod.outlook.com (2603:10b6:408:fe::32)
 by MN2PR12MB3550.namprd12.prod.outlook.com (2603:10b6:208:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 05:37:33 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::34) by BN9PR03CA0147.outlook.office365.com
 (2603:10b6:408:fe::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 05:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 05:37:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 4 Feb
 2022 05:37:32 +0000
Received: from [10.25.75.81] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 3 Feb 2022
 21:37:25 -0800
Message-ID: <1035cfee-e546-df14-da5c-7510137ef397@nvidia.com>
Date:   Fri, 4 Feb 2022 11:07:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Content-Language: en-US
To:     "Kenneth R. Crudup" <kenny@panix.com>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <hkallweit1@gmail.com>, <wangxiongfeng2@huawei.com>,
        <mika.westerberg@linux.intel.com>, <kai.heng.feng@canonical.com>,
        <chris.packham@alliedtelesis.co.nz>, <yangyicong@hisilicon.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <abhsahu@nvidia.com>,
        <sagupta@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20220201123536.12962-1-vidyas@nvidia.com>
 <8aa96f79-402-4897-424f-64a2c6893de8@panix.com>
 <2ab59f0d-3ae7-ca5e-6bfc-12bed18813b2@nvidia.com>
 <38a02915-906f-c53-7e13-6c8710315e7@panix.com>
 <708b746c-1715-9d64-5a59-55c9ad81bd0a@nvidia.com>
 <f449b4a-a13-d32d-b7c3-da226aebd30@panix.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <f449b4a-a13-d32d-b7c3-da226aebd30@panix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aa34b75-7be1-4611-9853-08d9e7a0716c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3550:EE_|CH0PR12MB5385:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB355071AD96C0970B3B2632C3B8299@MN2PR12MB3550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilhQlhl1K70+93GAGVEAio88K1jzcfS5Y//PCdDGYJLB/DxErvMe299EFU77sECxaqbLDYlDUuCB2132stXTIZJHJpIS/4PQpCcduYZguia+/euCducbK/vJt+y7eQIrJ/Lk75lDZ0otzH3RyaTCX/9qmnJDSYVX1kc6AQWeOMXiaZBhcLtEKAPHKt5wyjPFZFFuNhFPq0C4W/tss8YyNUs9+P+Y3mX9kEkiLTG1k4UDS1gCraSynPvv6jBIYrMWB8DyNpOKweBJ0wrhI71ddLD9EMbmS2jd4+TdXe60SchI9ZCAOyytg1HyUW8isNvqUIc/QMaM/G42hVeYpO8OgodGLGKS4Lhb/ldWC4Y4P7AIlXpzTdmzqedM/uFi1HBFhnEiWfFJwcVLZ6Fd9VZ016bK6iAZYiBJd1Eo392DnjJUaDolprbkY3aakD1lF6qHOWnsuIpAk/d/4CriGOoQGqAj4Hjg7UcIhyvO1k2v1RigfRfu/3VpTYZWrOUW4lEJmDWtqgJt5TqY6uHLyRG+KFp/7rU3tgy5K1ScrLZq1gO76iKVAGHy+Sx8DDNZ6rZIRq8g8gF5MccKd2jQGqSr7/KodEFpwfe7qEGh17Lu0gE+J3rprRoDLg3ijW0y81WeMPur3io9kimfzqcGHilGrUciSmE+28P2a+6aFR/MxhR/7VgHa6GdAxGA2i5bgfpImrss+iLZ3W5a83ubsJnUx8fCJWPA57eZs4+c8AmOnlLQQbx9N4K7gRfT0jVw0ZhPafdGVk4qwi6YvDOyGQbLxw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7416002)(70206006)(70586007)(4326008)(4744005)(8676002)(316002)(40460700003)(6916009)(54906003)(15650500001)(5660300002)(36860700001)(2906002)(8936002)(31686004)(16576012)(83380400001)(86362001)(36756003)(31696002)(356005)(81166007)(426003)(47076005)(2616005)(53546011)(6666004)(16526019)(186003)(82310400004)(336012)(508600001)(26005)(32563001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 05:37:33.1486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa34b75-7be1-4611-9853-08d9e7a0716c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5385
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/4/2022 6:48 AM, Kenneth R. Crudup wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, 2 Feb 2022, Vidya Sagar wrote:
> 
>> but could you please confirm that you are using the same system as before?
> 
> Yeah, the same Dell XPS 7390 2-in-1 as last year.
> 
> I've merged this change into Linus' master and it's been
> suspending/resuming/hibernating with no issues so far. Is there anything else
> you'd like me to test?
Nothing more at this point. Thanks for your time though.

> 
>          -Kenny
> 
> --
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
> 
