Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAAF3995C8
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 00:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFBWRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 18:17:48 -0400
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com ([40.107.94.87]:27232
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229552AbhFBWRs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jun 2021 18:17:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5b/dt67M1S0vLnqFdo3JBI8/x8WG2h6v97WaoqoVqWOgeGRwbYlEZ5tHodCf5hIZDxNcSECTNM/03lnRmREDMuWwM+f7W3No0FJGfIEmUniPpSEFEDvUg8YY5d3Oj1TWmxp6hPqwQ8ntTswFxCF90sgT6gwP/MDTa3OFZGHgbMDvFLO+VLgXH8EdvchRbkIf/Q0j3FRK/zsiR8kFntU7REeg4tacVSJsZ4lFTE6nRx078OaRAdv52t6tKUq3hAc1kE6f8GlD+Jgjfc2MjXq/mZ10EiHlxNOv97wm0Fur7mzv7vrmPun5pejHfU+2kBjn5i09ZXi20C4ZINW7sUe3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f30UZs8Hb/wLwG2Qed+p7lMPmcHXnhft8zYcwrww1g=;
 b=NEsnXNDesCWzoNxW0sdApw51ijAW5e1N2CF0oCXEPjiWWynfdumqhsObizsnUrb7RUZpUxukSOibRacvospwAjp12G0Ml2Jsdg5vYY3weOfuN9zHJkgRMvUd6yx7DkxMsA6CgcyzOiQ365y1mIcKXlGt7C8LgNKtKvx2IuxUKlwYuEpSpOAmtM+tg3KsnpSp1whyW+QxKNP/PVWBOGCu8+Y65zpN83tX/BB5yKxryOd7cjPz6UgMSPfyllorujVlX17lHE5SXR4+XrlJhCwEjf6UJudpsC8pgwF6ZmnVGQQ2AOLgJEU18Q3YKqKNNw/7OysbsgVJaRlGnbplQ5vVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f30UZs8Hb/wLwG2Qed+p7lMPmcHXnhft8zYcwrww1g=;
 b=Ryne5DfRDGm9R0n5Eu6IyiqIYzDKv5GBFo+gNnhGklw6lq9Lk3eLGukqDfV5mc8aOcosXASMYyPeLqTSrddKCiYTqiODBjURm/e1plTNS5eaZF0n0SssJK1o5AE4ZiIBHe5VddWy2U3+AqoI3FvvR+LTUQz5eG5RwFqb74H8LKxhIVXOYKl8cs9BG3EwdxQiST6fVdETwdKIrfZHBl38oasmZtJ/Y1Qd7vGuRZNo9LJh9XY2XvdndJeJCSVIAOE9IYgrUNQ3vHAOSOWvoohv46sHOqcj4Wi5J9LKJ0X2f34qXflF5Ag9qAtJXg1V3oQhNS3WUoFQtCN3j2ooJkvFUw==
Received: from CO2PR04CA0146.namprd04.prod.outlook.com (2603:10b6:104::24) by
 CH0PR12MB5091.namprd12.prod.outlook.com (2603:10b6:610:be::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20; Wed, 2 Jun 2021 22:16:03 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::57) by CO2PR04CA0146.outlook.office365.com
 (2603:10b6:104::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Wed, 2 Jun 2021 22:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 22:16:02 +0000
Received: from [10.20.112.58] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 22:16:01 +0000
Subject: Re: [PATCH v5 7/7] PCI: Change the type of probe argument in reset
 functions
To:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>
References: <20210529192527.2708-1-ameynarkhede03@gmail.com>
 <20210529192527.2708-8-ameynarkhede03@gmail.com>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <206c0142-3d0e-2c55-55c4-e127d4b868b1@nvidia.com>
Date:   Wed, 2 Jun 2021 17:15:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210529192527.2708-8-ameynarkhede03@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a68be23-7f29-4ea9-16f3-08d92614025f
X-MS-TrafficTypeDiagnostic: CH0PR12MB5091:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5091997F930033031399A0C2C73D9@CH0PR12MB5091.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1j6t8HMJcwIf5xz9z5j5QaML1NKwUhoQtp2zF0RK3sAOwy7lL9mYYi2dS8dSIIiXwst5pdqgaeZYZ9pnSroJTwUTbfctPizaIgx/phwvyHTrcp3yBjeJUhqZWli8HbS/j1jUvmZnMZvUKhTuuinkl+eagnl34HeDA454O8/RhzICgBQF+hXX/ezXOBYwvSlOy9w3X1q8csmj1vUSqnI0HU1R17tCa0+5ILXaYNuer/MQASrkd1CHkXt/8A1F3ZSdMWSAiUHHk0MEGGZXLnYYx8R0Y8eQGmPbGYuCW9iW4TwPORCGZJhOth21JHKtXWvn9SAfZScLLcZ7Ih+hRja5EPYck13Rer3tesQunKl3UZeNEBER0jqhThU5h93B6qT0n+7gPV2jKlNNj9jmQnMc2FqVeTmklUkKaNNnb39rGzOFdVDxzFTWbhqQrN+0NDlIt9KlB726uCfzcegZfB30DX9VkgviUT8fcZpngCR9o1yJn19qCOlyQOWGqfcB+qQwhQCCUflI4MAsKd4f8mEi/kxI1fDTwm/CANEQ3oFfpO5MFovYPagQ1iVduZznyGnR7v43bappMzodiZH0LTctSMJX4ldUohX+UlmxNrEkR8FpZhn3ZyDVBiyXyNvapyF1N9Q5Vh1x7mixqIwh93Oivxq+5dK/ZiA3S+pzyUHt+7m/evyvyVO7iPpX/S7WCLtZ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(70586007)(5660300002)(31686004)(82740400003)(4326008)(31696002)(86362001)(336012)(16576012)(356005)(70206006)(7636003)(110136005)(54906003)(8936002)(36906005)(36860700001)(82310400003)(47076005)(16526019)(478600001)(8676002)(186003)(26005)(4744005)(2616005)(2906002)(316002)(426003)(53546011)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 22:16:02.9434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a68be23-7f29-4ea9-16f3-08d92614025f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5091
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/29/21 2:25 PM, Amey Narkhede wrote:
> Introduce a new enum pci_reset_mode_t to make the context
> of probe argument in reset functions clear and the code
> easier to read.
> Change the type of probe argument in functions which implement
> reset methods from int to pci_reset_mode_t to make the intent clear.
> Add a new line in return statement of pci_reset_bus_function.
>
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Suggested-by: Krzysztof Wilczyński <kw@linux.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>

