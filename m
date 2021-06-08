Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8023A0414
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 21:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbhFHT0i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 15:26:38 -0400
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:56801
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239550AbhFHTYi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 15:24:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3UJJviMzbQ1UzEc8tQI37TXfcDHSg0whsSHDHaW0N+0bebHApPXaOJuSZ8bERRNQpxRpr6VRRFkfGJqEvs8qpKEdQRrw/DIYEfr6vjLAQnEDXRoJZAdy5MyTXqdCvh3Veu5KEZw4ZVc0kG3oyw5m6/DXesve7kBm9xQDoET3GP1APsvT06+KAB8XX5FfKJoVUjKQLWM+YncN5sscTctC58djY0f1Bz5B9JUnNtEYklRQUaGocZnlBVvOi8OJ7IFX+nUo4zjmCTxmmA7Tnd1/MxPsfjCL61Ir/5OqJmHT1kIgS2C319q/bD/feU220wDvFPqzIikyyFlspgDx65Z3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI8y2KJXBXsLMyGiljhdr02/uBE4A87CEul7mgvcHvI=;
 b=nV6wW2kH8JwQJQ8oYi7btaWcGmKWjFPaqYZpGd8xmtUJptBkk7o5dXfZSCW6bF1eCODh8Lfo70mAHNUmfkhl5cZLBe9yrQAx2k+9gOF1niC+rLcajcTptXYIwpnJUNOmjX6or4Ic2slV/BAvBPH5V5QX8UVwfc9pUgHMHe8NYE4xhX5+S5dvCgOIiUBi8hpB6Z+IWkod6GrwDjzfFca/7a1j081jkSEWQzqKSXbMKBja3Jb/jNWn0hgNlIwoyuStoreTGhgsDE84euc07A/6IVrwyblSgrk0U/I+FZgtk7kyKh6B2DP6KpY6qd7ci07t3BbSDr9hjKSc08FENo518w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI8y2KJXBXsLMyGiljhdr02/uBE4A87CEul7mgvcHvI=;
 b=i+j7IKhWCl1IY94n7WbZ1z+ScqA/e+jQV/mvLZGmyYDtdBr4zNUHesNjlTFCWnHaEXRz9csX5kLiNeeXcoSE5stdviqM22ONrFSI4h2IwOW7/LYSNL7XKxL98r/IsSRdiDyk2LBoQSghYgNVZcH4YI1av4XJJhdDosgXg/01mwRJMqHdv56lzWcN653ZADYsHsQCmf/o0NkEqm5WM9hHIa+LNGJ3A+grjZHR3Lt7rkBbOlgovterubsFjj6BM3qaT4pf5b54xY0TJq4pgEdNl6t7u9IXNcOdDh+s7EWStxtvWFVW/Xa+vPPuhnY931ropnaqjFdorDQtgvM0YC4WFw==
Received: from MW4PR03CA0031.namprd03.prod.outlook.com (2603:10b6:303:8e::6)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 19:22:43 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::17) by MW4PR03CA0031.outlook.office365.com
 (2603:10b6:303:8e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 19:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 19:22:42 +0000
Received: from [10.25.75.134] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 19:22:39 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <amurray@thegoodpenguin.co.uk>,
        <gustavo.pimentel@synopsys.com>, <jingoohan1@gmail.com>,
        <Joao.Pinto@synopsys.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Query regarding the use of pcie-designware-plat.c file
Message-ID: <34650ed1-6567-3c8f-fe29-8816f0fd74f2@nvidia.com>
Date:   Wed, 9 Jun 2021 00:52:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96a5757f-5d3c-4796-a3b4-08d92ab2c9f6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4195:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4195DAF8159D907D63007710B8379@BY5PR12MB4195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kr0kyGvaIClwhxFth7sk5IgzfYp7Yo53bnau9JhfzNKUO/dcZuoXF2o0nHvld93Cd6/ZN1j0tKBbBs0qChuOvH23nrx9JMuAelSBwewe2kkpbC2TzqrazgXLiCmSzR0lfBe8xHPqJRTXnY5qiaQBaMQ1tc7tDyXQIT9aIjDe5ENMy4ixUCzWRnBEi7LrcCcbMsruLGHauZkNpvhsURqAL719FMky4/2No1ZaHsyxz/7MVVQsgVwlF21unyH8EP6KbRSJnwM6RXJ87A01mXsiB67Z7xW1gu8hSp+og2s4MoMW9JdNsnKZZqVOsKF/JzEK3RFKXZ45i/zEYw8eo/AD5Jd5GB47jt72L68UkesIRzHCuihZcOQE5izIYGdjnZbvTn8eFRg1vLs2mHx6UHxRjtv5ThpRj7xleIY+V7gDnNTO4koLXXfML0UHh5H6oU17WDo3HiDDCbWDK/bpddBnWlSl3awTPxNQp0qPs9YynRcatKQSjqadfzqePavFx3gYc9Y92/mH1fi2owdnmfd6PFqfcb8pPHZrrUfvygxQzALO/CRDPNYyorQH5ePlXLQRn4l07cNdhE4k6PiJgTGzZnH/5XA5LImiSRqDqswdto/EQkRVfrPmmxJwagUdFAZ1O8agfHOHHOD5d5puh0M4xlOnoUrBiFbwBMe4qd7cAtl1gYiM7d5JAXDJKosBhG63P7E1xothEcZrBwm8asnN6w==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(426003)(31686004)(2906002)(70586007)(70206006)(336012)(110136005)(5660300002)(478600001)(2616005)(4326008)(26005)(8936002)(47076005)(31696002)(186003)(16526019)(82310400003)(7636003)(356005)(36756003)(86362001)(82740400003)(36906005)(316002)(16576012)(36860700001)(8676002)(54906003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 19:22:42.9525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a5757f-5d3c-4796-a3b4-08d92ab2c9f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
I would like to know what is the use of pcie-designware-plat.c file. 
This looks like a skeleton file and can't really work with any specific 
hardware as such.
Some context for this mail thread is, if the config CONFIG_PCIE_DW_PLAT 
is enabled in a system where a Synopsys DesignWare IP based PCIe 
controller is present and its configuration is enabled (Ex:- Tegra194 
system with CONFIG_PCIE_TEGRA194_HOST enabled), then, it can so happen 
that the probe of pcie-designware-plat.c called first (because all DWC 
based PCIe controller nodes have "snps,dw-pcie" compatibility string) 
and can crash the system.
One solution to this issue is to remove the "snps,dw-pcie" from the 
compatibility string (as was done through the commit f9f711efd441 
("arm64: tegra: Fix Tegra194 PCIe compatible string") but it seems like 
a localized fix for Tegra194 where the issue potentially is global, as 
in, the crash can happen on any platform.
So, wondering if the config option CONFIG_PCIE_DW_PLAT can be removed 
altogether for pcie-designware-plat.c?

Thanks,
Vidya Sagar
