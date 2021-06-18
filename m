Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D6F3ACFCC
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 18:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhFRQHA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 12:07:00 -0400
Received: from mail-bn8nam08on2050.outbound.protection.outlook.com ([40.107.100.50]:57569
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235760AbhFRQGv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 12:06:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5oDFWHouMNVadG78Fao5aN+EoapEo5EEEAe0Mjr4iTg9de5tMJikANXa5rGS9RcoC59+hO3ygLa43PuPLbdR+bb055bDrgYXfAWaVol11dwtHIoYyl6cYCDj6wuh+jnx2wjMVLXis+DhcT9IQ9zrKqvL9XfJLk/a1Tgj3/N096sy3aF0DaOBTwgK2itelE15TBTAf8oLQlEH8VH/LCCHG10oKCZ3CYV7k4AoMLxY1ut71UTuyBOIDPhUXvgRHfiq9Jm8/oJIzCTl9B9pJEoPaGmEnqux2Qwag2+SFyKRPAFFw3u6FRqp1eGTqgM6R+qUtGFOhSrsmzg9uXtkNXOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efExUyw/LUOlK5E1DGknBmUOC3C5u2zRGNQhjke1TAM=;
 b=EDW6WhnPdRC1T2qgP/BHi5v7xZ60+eI1Bm83PEWSstOh1CnzZ4xOVi5lJOba94YIa/bhQycp/u3zXFewNBzYZCJBB0A6ecvEiUGi20OEEz7N+iUK88j2VTn4eyAJOJKwypu9Je0YjNTRAGJEG/DtYQteV3F37nQRbnjPAHHHEzIic7SbHY258fl8DwTdysWRBDloWP35oVej+THI1/yh4Va5aG/eZEyAhRCOh4ffLpxFVS7+fIS3GsaOrteLthq/cDlbOC7YDCCcWaV+AZx8tvb/vD6p1gurh7iPmzvDBszPjvE3tVooybACZxobUNC7zdZtazXeb+E0Tvx+RbfVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efExUyw/LUOlK5E1DGknBmUOC3C5u2zRGNQhjke1TAM=;
 b=Md4BcLmd9WOjKl0yeV6NEXc5XPe4mfp9nGTXf9VSYWnxIaKoIqj5Id81Mldkl0j4J4j9TLCLLHAoDbpxMEqBLrEPy3T1P9PotXLDri6EyAyf6GCpp+wwgB5l4gwmC7H3cRvg1KpvCTxqTxcuyvAdCj95b3crr2K2k5I1uQtKQCBWo1T6+/C+Dxy19FErQh8MNZreQdbu5mvFlUgKKBV6FmJfqCStFlJbLuDQ0tUKUFoJJt7KuIHBvUjvpUJb4Lfn00Q8WLupiYylnzQEkV4ao2einetUsuzfb7k+MEQC86KDeqi98ilKtnFWKkNw7U0zolsVZ88RSV2EF53dsjTcvA==
Received: from DS7PR03CA0006.namprd03.prod.outlook.com (2603:10b6:5:3b8::11)
 by CH2PR12MB3976.namprd12.prod.outlook.com (2603:10b6:610:28::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Fri, 18 Jun
 2021 16:04:40 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::f2) by DS7PR03CA0006.outlook.office365.com
 (2603:10b6:5:3b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Fri, 18 Jun 2021 16:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 16:04:39 +0000
Received: from [10.26.49.10] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Jun
 2021 16:04:37 +0000
Subject: Re: [pci:for-linus] BUILD SUCCESS WITH WARNING
 15ac366c3d20ce1e08173f1de393a8ce95a1facf
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Thierry Reding <treding@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>, <linux-pci@vger.kernel.org>
References: <20210618153812.GA3192337@bjorn-Precision-5520>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <eb1172bd-421a-f651-77cf-5607ec19e10e@nvidia.com>
Date:   Fri, 18 Jun 2021 17:04:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210618153812.GA3192337@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eb78e1a-a68a-46fa-bab5-08d93272c703
X-MS-TrafficTypeDiagnostic: CH2PR12MB3976:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3976EB27C82D703B46F5AD17D90D9@CH2PR12MB3976.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCcbe/0WVvP1Si7Cb8uEriLqo41vmIqo/uZwWZLK2PT7vYaQAps6EnHos5kyeeuDNTUYoqz+gfxVt0KSEGjDpmEZ2L/aRnKNcsS3qnklKjW02ddhJAPWXoRXAtBHfCoLPeCo8KDpjp5rucWK4RDX6bUGagMycymjSDo+zJojENnpCEHCebq/1C+m3G5J+JdTm2hGOLl5K0W7z8jUQ192AV3idTzmErZtPw2O0VaygXEsX57MBzCbxxBEMBa7GggcjMR7q7ubFPRcKrDc3vKN9WGqacjFktseiZ2oJis//rgYHtQicUPGEp/zjy3giHEG+aVKFdGHLk5eW6saEeBL0V7cbhW9cDGGFCpNZPZAs62LOFGoFKCdHkSbmE0HJEdWqTOtre19yxhfdxOr74MNPiic1NH8dFh8UvqYmUXK39fMRfBsO0besg1zp4cOj8DHXtLlzxhLWQvcq0mAwXGA3a7tJu1hFu4JP2EToWhX5qfONFra7OsQBRO5UpFA2gXKt7w8mmUlg3TsXe8kVxM5BV1lrKkRYUzJ95pIuA7FskLXFm7exAF1m+YlN15lv3NA5gORJwOfxA/Ij9IoL4rRen/KtUCnypB/yGRsTlgyg5DabDMxv4aapvG4M9kNVMS5x7GkPrXgPEnf6BR5NjlXfYoQDG4SW8L58T1+clGbz98qOxAARTC61eXYFRavF/iq
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(36840700001)(46966006)(16576012)(82740400003)(5660300002)(31686004)(2616005)(86362001)(4326008)(426003)(26005)(70206006)(356005)(6916009)(54906003)(4744005)(8936002)(82310400003)(7636003)(31696002)(8676002)(316002)(2906002)(36756003)(16526019)(36860700001)(186003)(53546011)(336012)(478600001)(47076005)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 16:04:39.5077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb78e1a-a68a-46fa-bab5-08d93272c703
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3976
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/06/2021 16:38, Bjorn Helgaas wrote:

...

> Please also let me know what changed that made this show up now.
> 
> We need to figure out whether this fix should be squashed into
> "PCI: tegra194: Fix MCFG quirk build regressions", applied before it
> on for-linus for v5.13, or applied for v5.14.

I see the issue even without the above patch and so I don't believe it
is related. I am not sure why it is only being flagged now. It looks
like commit c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint
mode in Tegra194") introduced this.

Jon

-- 
nvpublic
