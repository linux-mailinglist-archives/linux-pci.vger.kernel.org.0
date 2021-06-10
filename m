Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F8F3A3805
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 01:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFJXpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 19:45:31 -0400
Received: from mail-dm6nam08on2071.outbound.protection.outlook.com ([40.107.102.71]:60800
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230083AbhFJXp3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jun 2021 19:45:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7SpSxswrY4it3BT/UpKiufYx3IukhY4oLtr3EdVqVF0r272o4JZmkXXEjPbjoU0hFOVK2Bbxl/K6Bc5bJr+ar+6YjRzP9nxsFJwUUxUhdFcuGdmJUXycqLI07ilfEw7ZHL97PtYKKt7E81oh6lOgtCqa2im+dwgmUXrhmWTI5MNyw/6zA913pm7tAdoXuvmRJCbuBOlov8/7FkCd5tLL7PgKkyfPvkC9qBsVB3GVqzNFqGtcmGEzx3lvUYMvJqe7joIcDGqAB59WhmrmumPGTJaf6iyATf6cHKWH+Z390zgdc6Nvszp+OW5TR3Ohe/ynncLIK+ik+JzxYtai59RCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJoVG6QiE6CWTNWFXyN/CNsjC2s8XAeFc+nyb29L1J0=;
 b=hp803RMEsjnLLTAwmpQ89PQOjH2UmhMhLjoF2W59KRLbAcYkg36hVdxlCn0+Fj9zxApZFEThXMjRoKkDjaIotP/rsqKqPqCGvsuR2yAUCGs5NPUdDxEBZ+lPa+9hcTjgaR46H3rOE+LcAMWXS6TL6eU1+KKkSnShJRoqtxes483vPAI9/rPBqSApCif1bFkj9VNTso+OWd2z0HKBAo2evZssmdZ/pucd7sF40l+NhAjSfw+tXRW6t0pfHQWf82algiluOGJI0f8PstCgtpLiQqn4xSG2ix3nmPXFqG4cgNbhBsT/IB8DVo3QJfAGuMfw3QbnIUgjcvRnB9WlF1Wqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJoVG6QiE6CWTNWFXyN/CNsjC2s8XAeFc+nyb29L1J0=;
 b=QduYVlTHEBnrvoPfH45U2KF56RD+jhvMQd8+p98Q9Vup2hrTJH/iUa3Fj35eAO3LyOCRuF5G0PSAUlVfag/6zfQ6H1HUHWtofPzEBXFg8ZZODmFV1uRetmZrvjnoYDt/beZKPL0pR9WdRWOiXquexcRKjCVnhO2t5fQ2eYQps/4V46TAkU7ZKM0g/Kao1aOCCHEf2ILZSURPx+JnsDCPBBdlMMSallfXpNGsGHEYipXIVDi9JnQkN2yKOINxscud9Dcsbw2z6E9nsagZVhS4gOuN1eXo1K8k7ucgh57+nWIA4si+hfqu49tESm76CotUsAjzlLa6BmKvN3zwMzxhWg==
Received: from DM3PR12CA0132.namprd12.prod.outlook.com (2603:10b6:0:51::28) by
 DM5PR1201MB0009.namprd12.prod.outlook.com (2603:10b6:3:de::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Thu, 10 Jun 2021 23:43:31 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::d) by DM3PR12CA0132.outlook.office365.com
 (2603:10b6:0:51::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 23:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 23:43:31 +0000
Received: from [10.20.22.154] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 23:43:28 +0000
Subject: Re: [PATCH v7 7/8] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210610231615.GA2792521@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <762dd911-2899-f4e7-da38-860316febbf0@nvidia.com>
Date:   Thu, 10 Jun 2021 18:43:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210610231615.GA2792521@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e29fd5c-9b4c-4cda-4970-08d92c698dd0
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0009:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0009ACFB9CB3DC0B34573C00C7359@DM5PR1201MB0009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jns4zr4/EPuP7A1QQpYGptCoGJe7alYhueHmC0w+5Ep3saHoxmMxaDM9lpLMGtOsAL/c7oIsQc9fAjFpn48ik2lNwPnqu3IQT84KP7GK5SE0KPEk+HDU+qVst2iuJIgNPiU/UAD9h1Os7SSPH3BaaM3/abavvmEBTiJUsBVeMAu0M4+IS1iMnwnR3B6AJ57TW2CgNf+Y5dMVLnGi3TNcpNzJfb0hBhSFspN5yWpS9cd3CeuB1RKDIki7JP8NVvMCnT94gHF4dVvWTYIrjF7vI2mjWtvcHGWTSwKuUMNl1xdtbBjnSb/OCcpg7jwrCDvo7PYHO3TbzJOS4gcpDtBBfCcx5PPqteJoCTiQT5WUSGHMF1I9Itz/JQKUV4fBffuZzOxzTscBr9zc89DFsoG16ilXD8fRFiTD5/ML4z1WvU1hwIepsYuU5TMD7LW6zJ1Hp5fLMcpa10SMU9ndF0aywu6pC0rvFp3/+dDLdUz2NVTZW/bxv7wEJ6/tagTv/HxNG1WsB3rHXNNiIBBaJo7z4z63XJZGVNhjyEOmB6r3NWIM6QqVR0h173EKvSGPdc5pDvEx1meIO4gIWWKcVzxAEqzSVeKbO3SAGgWtIcwtD75/qj1F/rmuGEfzgxYZXo2UhWb4lCHq51VjJTyd4VrvxCqqveax75OnutR9T7nfhvngb0tXX7cUFVrpjz+dE3qo
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(36756003)(82310400003)(8936002)(426003)(83380400001)(54906003)(31686004)(4744005)(8676002)(86362001)(356005)(7636003)(478600001)(5660300002)(4326008)(31696002)(336012)(70586007)(36860700001)(82740400003)(110136005)(16526019)(2616005)(26005)(2906002)(316002)(16576012)(53546011)(186003)(70206006)(47076005)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 23:43:31.0202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e29fd5c-9b4c-4cda-4970-08d92c698dd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0009
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 6/10/21 6:16 PM, Bjorn Helgaas wrote:
>> From: Shanker Donthineni <sdonthineni@nvidia.com>
>>
>> On select platforms, some Nvidia GPU devices do not work with SBR.
> Interesting that you say "on select platforms."  Apparently SBR does
> work for some of these GPUs, but not on all platforms?  If you have
> any clarification here, I can still update the commit log.
>
Yes, SBR works for some GPUs but GPUs which are listed in this quirk will
not work and these GPUs are available only on selected server platforms.
I believe commit text reflects the issue but please update if needed. 

-
