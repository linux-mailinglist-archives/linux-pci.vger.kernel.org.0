Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1679B3D8441
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 01:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhG0Xu3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 19:50:29 -0400
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:7520
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232766AbhG0Xu2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 19:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGr9eHkKrIvhn4efIYrkZPaUWB9okzr4+PfvmX4/WVXslqdS41dTzNKCUy2i423KKY4KjhEQ3ao1HVI/p66oNbwpwCGgWfkBcCaqS9utxxipdd0bnkS5nSAdMMhN17zW/GJ0OjwkV7h6Bq3j9tYVgkMmTCbTfpu7xy7qvtbROv0ApRQxzd6Wtqai4zOJbbA6vjNUlFSGVtY/b+uMiWpz+Xwcr+tO54LPzrz3dQWaVIkG85J/U1gfMbNg/aQyCiFaQ7SDg2gfjlfaQ7fhXHOndG/OEVwOR/hDp5DL4UenK6QhaKAPdoyp/xJDPFTdTlQInYVJt79HSkDczbQNT2H9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsVNCh+BHprDQTy1iF7feN3JxIfcFZ8+LLZ+P/ZO+no=;
 b=G3EzZoY+mSOk3sK7LWpH+SE5Rq/NrPM+tdDv8NuWCuYEE7m5ptpaGK7vQ+fW5Ic/QJgmAsRqQ3uE+sQbSQ6tbiCvvVURBNYAe6gMDO6B9xOkMJS5x+/zBW4L36FlIdKMz48lou5j4PbxWfpz66fVQhfCr/r+8zyBcolmOVn7k6DTd7yoVsi+/VJl7M/inwq3VC9N5VuhM5Wzxxi3TokkitcYqAkkiESxIHzMHev6Pv5sGozLQgJAPxBuoLdfwNBnRM+uJ8Uhwsk9+K+spynItbrNW2Oge31ZuHsiopsmnbSooV1W3j8XLA3TvvXOGCt03YFdHg/QNxgp3KTbLO8cfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsVNCh+BHprDQTy1iF7feN3JxIfcFZ8+LLZ+P/ZO+no=;
 b=U9PJysEErZ07eY6CXNULhmgDg34V2Z21/hyZqznnOcnDUvIHOA3SLXEB1rqbn1bk9PNGUZsEPXq3aFCphV8HMmaUcMb0rwk/6wFr8x4CxpLX1VcV+k8VUxPIc3OL0OwQyWPxz666c8K59dyxU6o7/JZ33PNUcQeFjxzOgT4+01gi7hxyZK2mwpXo3W7Zt6RpIyWYTp+jFEBrQemM89Zrbxom0UqDQwFIEm8BcmrJvdkeS7bdVsZK50vyvZXOsPJauCLtWjD4DaQ9PesjLd3kVl7Tl0p2awzJDfXlme20nWst/JLNxBs0p5/FCWY1WAplfrdbWFNEUPkbi19qj0KpTw==
Received: from BN6PR17CA0012.namprd17.prod.outlook.com (2603:10b6:404:65::22)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Tue, 27 Jul
 2021 23:50:26 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::8e) by BN6PR17CA0012.outlook.office365.com
 (2603:10b6:404:65::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Tue, 27 Jul 2021 23:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Tue, 27 Jul 2021 23:50:26 +0000
Received: from [10.20.23.47] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 27 Jul
 2021 23:50:24 +0000
Subject: Re: [PATCH v10 6/8] PCI: Setup ACPI fwnode early and at the same time
 with OF
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kw@linux.com>, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
References: <20210727233025.GA756574@bjorn-Precision-5520>
From:   Shanker R Donthineni <sdonthineni@nvidia.com>
Message-ID: <64d72141-4f7c-c513-fc61-ff3e5a208933@nvidia.com>
Date:   Tue, 27 Jul 2021 18:50:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727233025.GA756574@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce0d96fe-78b5-4e63-b2a2-08d951594ee4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-Microsoft-Antispam-PRVS: <DM6PR12MB421994981EDF17251B90C9D5C7E99@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSIN0popyFKU1Sc56yaqKOCRXuHDLgTuX2UWWuN1AnI/B3Gqw6y0gpywsaxIT9A/bKnrz832oGmslIxjQiJWm/6nPCkepbCvfDtDNmxMYCwKCk6HfBWFZ0zQTkPlxdD3WPfj6BXRqrAtxWAS1Xj2vwrme07fSGZq6E2NkxAhwZkBM41v2wTZMLHqwx4M1ohfX2j7nBX4ib7HyZAwSp9bVAIgCPytDmvZILPjy2pUXDS8U49/p5+9TRKV7TafHHgCZBBBrSiBid8wfgDx+I1fERdSDgvZqvujIYkBtNL8JqXwbXWUtAtRWY6NXzdgugDHV/g6VAstKS7QvW5wINB0aD3OJPv9S7EEyR+sXuN41nfglKmJNf8HQeMIEs4RspmdMQ7SRls7NBYu1ZcN54qQpF6gQc72VzPUSXn39HTimOuFUkNKdZzjhgvKM/by1OLnZreJIpBWlEP+s0uLizpgLnOiPpZF4JRsODWyD3xf7arZVtVI3BjglRbz+orn0zU13rPZsw75ZxP+bU3bVRP774OwbScNkQBlUJCnT7CiwOmCZD+L2ddE0Kvj2PLl8/1EoZLoSHOufx2h+trwwj0+t1t2sIGAEOACa6YNjCvngC1hCvTUfRn/70gUnwjWXc4mb5fHf/pNJpo45xSfCAQQwxtDWIE4g5mXpfDLOq+9pDBW1b7FBELcqucXJRPecat0Z/coJXrHttnrn3ood0it1Xf0owSKnvqfWcrBrZVQL6U=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(46966006)(2616005)(110136005)(16576012)(7416002)(478600001)(86362001)(4744005)(70206006)(356005)(47076005)(16526019)(336012)(82740400003)(2906002)(426003)(186003)(54906003)(26005)(36906005)(5660300002)(36860700001)(316002)(31696002)(8676002)(7636003)(31686004)(70586007)(8936002)(82310400003)(4326008)(36756003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 23:50:26.5536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0d96fe-78b5-4e63-b2a2-08d951594ee4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn

On 7/27/21 6:30 PM, Bjorn Helgaas wrote:
>> From: Shanker Donthineni <sdonthineni@nvidia.com>
>>
>> The pci_dev objects are created through two mechanisms 1) during PCI
>> bus scan and 2) from I/O Virtualization. The fwnode in pci_dev object
>> is being set at different places depends on the type of firmware used,
>> device creation mechanism, and acpi_pci_bridge_d3() WAR.
> WAR?
>
Thanks for catching a mistake, will remove it in the next patch.

-Shanker
