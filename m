Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D76371F92
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhECSYo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:24:44 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:35028
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229603AbhECSYn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 14:24:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNq8jsoZQrScr8p5uDj4NNejTZMAHjeMmeqyInOA9eo5b/tq870QhknNMvM89TsOnqgG1OfU5T4Ny4bTkibrkMecowp+tXcl+Q7recDbxm7sC5aiulR4IvTD13tusPvcoRN7tC2//iXmlZ4n1yGeWMt8rNkZZxQIG7uVCcj4/tL70Sn0BGLDMWpnh6G98KJyEAXp7xr9Ns0FSjRiv3UrvEdToyUPU9Ltx1W9NbgwhBiA2ntwRHLp1suq1BzpyJ6u2uVpt1MY8DtQvDJxQSX6/0KYt2gden62YkgLX9A6bgNvCemHwJw/xd6nAiiM9zAILoaPb5UjIAlGf4mpmEm+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVx0ZtULOxre4CPTnCnobT4Mv5nknBt37whXM0h58gk=;
 b=nWMwxtYPEOLzi7o22yQ7MYykNV7NkTVKgAnW4I6tWkjKVKgAqE5Kc1b8yC4UK3w3qNh9fskeIMfgREheRbN8J3876S9xYxBGcN9v1nADymuFoAr+G3B1ITgGilPuer4hEu4X/ORDZZsi0gD6EgDtSgE0nOA4MIK4VwZVG5oAJMPGpqjrAZU39zLzQTPsVFUzCz6Hb1DixuXpzNSZLFrRrh6ipYBILZLE0mD/3+FK+xZ/lxgf1jSPLrtZazMQLVIizzk4in0qvltXlb0BN5mj0pRnFoNIXA0etTBp8ZJqxfPq3ysZ94OmbwaPixGg7cwiXMFeqhnuSaLlfLPh50s9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVx0ZtULOxre4CPTnCnobT4Mv5nknBt37whXM0h58gk=;
 b=oWNfhDoG4gOUOX6shzvvqPqEREtAGDEVP5iF9JC0dt5yKjMlN6aeVZ10E2qCgUm/MBWoNUPAKA3s/H14msSn+YaYmRxg+JXatlqG6GN++cACt2r4wlJhNFGmdfPLw9QJ/2AVWN/C/id5AwTAFUaFmlNWpqTLTcInkhO0tpNmhd1+JZIdZlq7hZwd2gRfGsHFNkySmwiJl7a/FhdhJUVt13SowIIOoEsd1hQi5YAerlyYgGO+F0rd4wj9bqawZXS4fxs4z6wpivSm4SB1H5NmrKVUG6VPTM1Q4Vo9e64qmTcn1u7b9CeJeYg4lYMZPDU9I06OuSgxL0tLr3D6XX4rEw==
Received: from MW3PR06CA0016.namprd06.prod.outlook.com (2603:10b6:303:2a::21)
 by BYAPR12MB4774.namprd12.prod.outlook.com (2603:10b6:a03:10b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Mon, 3 May
 2021 18:23:47 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::c2) by MW3PR06CA0016.outlook.office365.com
 (2603:10b6:303:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.32 via Frontend
 Transport; Mon, 3 May 2021 18:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 18:23:44 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 18:23:43 +0000
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mm@kvack.org>, <iommu@lists.linux-foundation.org>
CC:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-2-logang@deltatee.com>
 <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
 <8ea5b5b3-e10f-121a-bd2a-07db83c6da01@deltatee.com>
 <3bced3a4-b826-46ab-3d98-d2dc6871bfe1@nvidia.com>
 <8402ca0b-f147-fb99-bab4-71f047d2ba46@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f8acf4ad-04a0-a31e-189d-5cf702d80f30@nvidia.com>
Date:   Mon, 3 May 2021 11:23:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <8402ca0b-f147-fb99-bab4-71f047d2ba46@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0a0f13b-b528-4961-aab6-08d90e609635
X-MS-TrafficTypeDiagnostic: BYAPR12MB4774:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4774D44D8B4703A9034DDC2FA85B9@BYAPR12MB4774.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uXoxlnUQce3Wh9ZUG/XgjRJehieEWu0faVCBdA8n//L1fwWW0eKg0HweX3Bkjt2qiiiyP7JG+0W+eklWc1yPL41EuQw/Vf30XpNCKe9u7LClqOLrEeq828ZbUcH/CM4HA/lfJosKfonLzKoF115Jz83zsFHuArTmIlRyY7S1Pcon2JPPmqNdIDVxQoHeTTaPyEzZnphWdytoLOC9eB1+eH16AfK+XeQdo0QmxoQDMNTY0TUNxDBqTm6fs1R7DzSMZxjeaDW6FEQbaLxxtyyIH1vjq76tIKAYmQfZnIJy249NQuWs/w5WkHaDbpgBuK0v3DZzUkaSKP9lW5DAuSxOoaQ1QdbFXk7hZNgKbXDNkBOPcE/Hao4cs3CWJw7/z9pFienjSIYyaOBWqKgtnjRPlWL7YJ2fOQJ4wV6st3hoEGMsItkJ4s/qchDs4WypL7RU2DVJqpimJxkWjbwEenn5yyNpforTyHaMdDNhEYGKuhAw5owa1VT1iHIv1aPtua9a8SdrTqJk0Bjjrlh2YJZnjkqjnP6YpCgdhKELluWbqm/i/JkOo0Roo7gFZHrqJJhXEQM0okF3yKq6hgYx9aD+SQkSkdF6mbrf393VqoBw4JHxjebeLNn/YyNPX40cgLSj8idouQv2CpoUk/vw9h2fWbxF5Tv7T3C7BuuXxo8us2m+4TLluxSTpLQVQdwY8wpxKSBUdYA2aeFzarhIze0Wg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(36840700001)(46966006)(36906005)(316002)(16576012)(110136005)(336012)(31696002)(47076005)(54906003)(36860700001)(82740400003)(426003)(7416002)(5660300002)(356005)(8936002)(83380400001)(4326008)(2616005)(26005)(31686004)(7636003)(82310400003)(186003)(16526019)(36756003)(53546011)(86362001)(70206006)(70586007)(478600001)(2906002)(8676002)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 18:23:44.8255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a0f13b-b528-4961-aab6-08d90e609635
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4774
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/21 11:20 AM, Logan Gunthorpe wrote:
...
>> That's the thing: memory failure should be exceedingly rare for this.
>> Therefore, just fail out entirely (which I don't expect we'll likely
>> ever see), instead of doing all this weird stuff to try to continue
>> on if you cannot allocate a single page. If you are in that case, the
>> system is not in a state that is going to run your dma p2p setup well
>> anyway.
>>
>> I think it's *less* complexity to allocate up front, fail early if
>> allocation fails, and then not have to deal with these really odd
>> quirks at the lower levels.
>>
> 
> I don't see how it's all that weird. We're skipping a warning if we
> can't allocate memory to calculate part of the message. It's really not
> necessary. If the memory really can't be allocated then something else
> will fail, but we really don't need to fail here because we couldn't
> print a verbose warning message.
> 

Well, I really dislike the result we have in this particular patch, but
I won't stand in the way of progress if that's how you really are going
to do it.

thanks,
-- 
John Hubbard
NVIDIA
