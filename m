Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37794371FB6
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhECScY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:32:24 -0400
Received: from mail-dm6nam08on2047.outbound.protection.outlook.com ([40.107.102.47]:55905
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229898AbhECScX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 14:32:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehaYuQUhU/piWQ/RmRWICn1YY+4KmBXiZ+CGqvUQS/1Sr8+5oSv202ZJ1wFRjNMk8nSA+l2z55g+Cs544nYfwUgDiM/pnbAy12ZMmsPy+2Ml7i9ysrJgI+NNPxhWvnIfT39uHc990Yqfh/1aUQHiX6orBUcRy1ZwVdeAhseQXo2XTJ1HuGm4s/rfxNbQBHWUHbV8akvIwbUXFYezBc81zoNp8SAO0oWykCvC3Z1I5nVnOfBQ/HNOYz9CwHhAbMsafDxSPMMyykc8vz/fbRBVCkxHlAtlmQ0R2Qa0JK1iX80LhU7iATqDXB2j7HXe02834ZyubHGN9L8ZcrTciP+BNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/Hrxe/7Zeko4JoAb7LF3j6hd4IMxyuBm5892liasNM=;
 b=GXdV0g3k2d9Z9nctJjtXd9FcOzY0+kNA3ms3fWMf/KTfv6gTJGL+AJfByYdtwnHceAC71oXBNyXsMY5tFjD1oIZZE1Z4GVEFB9vZV9o3kowSpjf5FdRaMslk0hy/wqNZkd1xN+N5qOcR6VJoR4v+3+r8jwHFPpR1emID4XwX6gQB1SYIeuGZEEHeUgBWqaxesghT6mdKAQ2o/fGiX+s7VkXe65Cert5uKrzazdouXrR5cDDVwMN6SUVSg6d9OAaVznV7qWZgUCIy3hZ0yBdoudrQIREc8bQHIRGLMZK1e3S24oQkrsKy88StBXuui+K5Y7SuaI+vcM87EGEKa+AhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/Hrxe/7Zeko4JoAb7LF3j6hd4IMxyuBm5892liasNM=;
 b=JLkRvlkvk7Yh6dVbkRF/EX5TP7Y/KV9LXBiNv872w2oOwBTzRxqJu86mGYdHiLYX+nhroCkOa8q0E/kxJvD+46NlQ/uMEQymEIhfMLMtGw5uSmQx6JNJJNO3P9QNnVXawjxGcXEg4dhrLRh6PGCx2pOcncQYPkNZDd657+yf3Kh8o6EeuayqVmb5fUh5gexnq5CY/maAsKj9XgsIqIvuRbUF+rkWrT7LlgxQvAL+lBM3T2MuYHl43KdJL+aS134DtJ7ZLYMm9fS76pNxe7WgUyiZ78L60Wc3kizIoqCgn06I7bqrJ9oOPjmW58reDvR5K/molMu3a7F5Ohil/Gs1wA==
Received: from MWHPR11CA0048.namprd11.prod.outlook.com (2603:10b6:300:115::34)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Mon, 3 May
 2021 18:31:28 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::cf) by MWHPR11CA0048.outlook.office365.com
 (2603:10b6:300:115::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Mon, 3 May 2021 18:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 18:31:27 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 18:31:27 +0000
Subject: Re: [PATCH 04/16] PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take
 pagmap and device
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
        Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-5-logang@deltatee.com>
 <ce04d398-e4a1-b3aa-2a4e-b1b868470144@nvidia.com>
 <f719ba91-07ba-c703-2dc9-32cb1214e9c0@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f07f0ca7-9772-5b3b-4cea-9defcefaaf8b@nvidia.com>
Date:   Mon, 3 May 2021 11:31:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f719ba91-07ba-c703-2dc9-32cb1214e9c0@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f71ab17-7629-46c3-d0de-08d90e61aa29
X-MS-TrafficTypeDiagnostic: CH2PR12MB4326:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4326A095B0124E8E8A0C9B99A85B9@CH2PR12MB4326.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NX6rczyjRrodFYa73SzvitidMCdtY9QPwDA9ZNKNQWIULxL0WzP88yqlZ2JK6XVSYuznMB0Xs6Kwj6i0lZ/Bq3NqoJuEjiDxnNpkafM0T8/ETCBikR3z6MZ9sUgwtPIY6+585PRlTbyRjvvBdCK5hU2t1qwJ8dpyYiqPeML3QGEdSqB3qlhs3NTF34yAXtBweORoLhvZQbrATZ9jgo0b5ntgeeDKs/Uu1WInQzEd/kMvbvgAm17Ima1PaNHbjz07fZCtYkNE9xX89AZDUbVP481X4Es8qv56DOCFewlYlTwVTGPhF94+lOrAh03aSpMeMVCtdKVZWP9n8AvRgPY10d0qLd+6DgUANSS0FPAohet2UIfbCNNOijiBwOJhGs4BcoSv8en7xpeMX+tsn+ZE0EPbhmEZOqH4k+ydyJVjkmPd6ZZQPLYpTTjewzfyHQGgbDcWqC9BltJ2dqZRgh8857RshtPVCGqvvtQ/bf42LR+eaP2k8Yv+osDWNB/JclusavaJaeTdRvopvQ/3L5FSwBpELshhB7/ehF9Q2zXG202UoZEeOsXGeQIrQfSu2YU2WjVzjP6zdOXHi2I+DZKDJg0ZHvgJS7YYXpe6OHLBvPrgS4/z2m1D2Jb3quT0/um/9V4uas+Vu3Oqn20InLycS60UeX5TMDU2HQ3ZKpEPEox2dBDbdaj2s+exG529gRJHKjlWAn3zXcr6MN/GnF0PDw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(36840700001)(46966006)(7636003)(53546011)(316002)(7416002)(31686004)(8936002)(110136005)(82310400003)(54906003)(356005)(83380400001)(70586007)(426003)(82740400003)(16576012)(70206006)(36906005)(2906002)(4326008)(478600001)(186003)(26005)(16526019)(8676002)(36756003)(31696002)(86362001)(2616005)(336012)(5660300002)(36860700001)(47076005)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 18:31:27.8060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f71ab17-7629-46c3-d0de-08d90e61aa29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/21 9:30 AM, Logan Gunthorpe wrote:
> 
> 
> On 2021-05-02 2:41 p.m., John Hubbard wrote:
>> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>>> All callers of pci_p2pdma_map_type() have a struct dev_pgmap and a
>>> struct device (of the client doing the DMA transfer). Thus move the
>>> conversion to struct pci_devs for the provider and client into this
>>> function.
>>
>> Actually, this is the wrong direction to go! All of these pre-existing
>> pci_*() functions have a small problem already: they are dealing with
>> struct device, instead of struct pci_dev. And so refactoring should be
>> pushing the conversion to pci_dev *up* the calling stack, not lower as
>> the patch here proposes.
>>
>> Also, there is no improvement in clarity by passing in (pgmap, dev)
>> instead of the previous (provider, client). Now you have to do more type
>> checking in the leaf function, which is another indication of a problem.
>>
>> Let's go that direction, please? Just convert to pci_dev much higher in
>> the calling stack, and you'll find that everything fits together better.
>> And it's OK to pass in extra params if that turns out to be necessary,
>> after all.
> 
> No, I disagree with this and it seems a bit confused. This change is

I am not confused here, no. Other places, yes, but not at this moment. :)

> allowing callers to call the function with what they have and doing more
> checks inside the called function. This allows for *less* checks in the
> leaf function, not more checks. (I mean, look at the patch itself, it
> puts a bunch of checks in both call sites into the callee and makes the
> code a lot cleaner -- it's removing more lines than it adds).
> 
> Similar argument can be made with the pci_p2pdma_distance_many() (which
> I assume you are referring to). If the function took struct pci_dev
> instead of struct device, every caller would need to do all checks and
> conversions to struct pci_dev. That is not an improvement.
> 


IMHO, it is better to have all of the pci_*() functions dealing with pci_dev
instead of dev, but it is also true that this is a larger change, so I
won't press the point too hard right now.

The reason I commented was that this refactoring goes in the opposite
direction that I would be going in, if I were to start "improving" this
part of the kernel, via refactoring.

Anyway, I'll leave it alone.

thanks,
-- 
John Hubbard
NVIDIA
