Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA31371F8B
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhECSXd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:23:33 -0400
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com ([40.107.93.66]:52772
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229607AbhECSXc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 14:23:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDo7SLVuz+HbwBFR8DpaSTasFWtbZpPyk+zZcLvUePujXtXsSasC49xBlyXkraQ3aK52yvjwGh4qit/QPWiK0PzfGO/JNZHqjdv3RwKVaqETdrs5oAYXiZ+J1T3mt24MYmngZfydCLtr2agESTqzGNTVjTQ9iAZzpkDo0XCxyENBUDlFxX6IRE2WiyJdHX83RxbISQ5R8XN3ZtsetnsUisLbMPA3C1R1J6/FYwSgLmprELJk5u3RIbUx38s5mex94KpcEaKUo3qh1OLgUMDsIgMnMpjrTc1rEDEWljgLRyrlyon1HRy2Go73zpvXx6TclvSs9AG5QDiE2xI9qhVeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh603q+IyN73ofGUEV/YQVGZO2H7r0W0NPpO0A2WQB0=;
 b=UumbdaHPDQvd21Z5IENd5rWlcjHPgWnrztJHv8SC+QuDlxpRsiDeB36LECeAIGCz0xmzwiWPnH/5F2NZ6Bdn0cV982surzCpMbLDCUNjblVWi3vPvpfRMz6D8HYVe5tfPEb24FcpN5QzaLGOJ6USQAFBvBO6dXfX1j10TqNwx2Zv+/DCkALFCcXchPRJ0+oe7fzVFCpZI4N1fUMXfcPDOxQnyoiuw0Eu6ttuiCEZ0z3C5hj9sqDnNqJVPaZym7IzdpCo3PWtYv4T5AZGM4ED2O2kmTP8u1lKtIRfo4rBQrdNDmFcyD/sjXAZnlC76EYpNj+MkKHWwao8DyQ8swosqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wh603q+IyN73ofGUEV/YQVGZO2H7r0W0NPpO0A2WQB0=;
 b=X7prm8j0vltbdUm9AQdhqn6TpNPHPOTJy3uVSSHnzqDaSga9yDEEo10YPqCMNapGbZyqVfyeI+AmJqylSlPz6njJidVgYjl8Lis4VoZszLlCsp/EfRBujSwVnYymOhK05dAm3NeI2VwRCjUgj+TS2D2nuzeAywo6BKbdRXVyU2VmoERDQpAwJ8t6MFBsQkt1eSoylVCwp20Q0JrTI4x5DgI3svqMiU+LaVcEaKg7s0OZOWJMUN6SIRKQETJJOW2/hiCHcTwhW7FubL+vVOQaVwKBSn1HXXVVeFsiQbtNtSYa+lOKHu7k1hh7IdCkVOp3c3/3zfC2If+r3idqvpRNrQ==
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by BN8PR12MB3282.namprd12.prod.outlook.com (2603:10b6:408:9e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Mon, 3 May
 2021 18:22:37 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::9f) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend
 Transport; Mon, 3 May 2021 18:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 18:22:36 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 18:22:35 +0000
Subject: Re: [PATCH 03/16] PCI/P2PDMA: Attempt to set map_type if it has not
 been set
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
 <20210408170123.8788-4-logang@deltatee.com>
 <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
 <a1b6ffa9-7a9c-753f-6350-5ea26506cdc3@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <ec3b9d57-a1c3-601a-323e-718a2eeb50af@nvidia.com>
Date:   Mon, 3 May 2021 11:22:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <a1b6ffa9-7a9c-753f-6350-5ea26506cdc3@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e38825af-e751-43d2-78ba-08d90e606d82
X-MS-TrafficTypeDiagnostic: BN8PR12MB3282:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3282B19F208F53D6BC074CF9A85B9@BN8PR12MB3282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8uXTH+i9MS2FHcEEHX6Ch8ZrhI34sDhqQI9x0IBImJ5+lw8FtMlKIFn0L5bZdBmuUv7PYfw52yhk0FGJVAJNdXZsiOTbxhSIOoKqJb+XvWq9caD4YaJVMbxbfyGKz1miRj4fHMG42z2JqiwJ3Tvqk567yaj2muZxvueDQXghqAGbKNXepOi642WOlhRz3GLcDUgwq9Mn1sdZCmQmxw+VeLdAcJ9bHFjDGcxzDWDWSe6TllNKwfOyoi8o/Bsms+4mbsQCktEQ8o+oK0gaNXwrd1V2mt9SQ48B8xU/TGRwLyqM6rAT+w6+EkzNn6S/r1B6KFON7Z1rwzWdhiRTRgMmo5rgP8EZizsdwtQ+hDjYZk/MoQRrrzBrZXnaWO8FnNZWOatHwFk1WXT0aCmYmfW3Z/FR7Dg3ObeUPAbOhFYgCsz0oWK488uBGuwATgkC5dQtQRlHxHC4n7MGOtV9xgFY51W1OhYOXN4SPol78jaqS8uc6/tmAQpbT96fVZwzYfVCbkMmkNT4sP4YBk/3S99+SBw06vPr3YLdQT3Es93CpssL+ipIsUEOIDuq/BodzUTsdO/UzqlURSxNqSq2mU3hUY6OliKFYGAzV6dTKZeHcwInKAchqHK9xZ/a+OehifNCHFxJw4UHP0dbZvLmnLDhqbm69BfkyihqObsVXV2Eh8/Yc4yeYkXa1+ifGxJMRQiDrGEAujXkY2T/JtGlfz15qQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966006)(36840700001)(31686004)(2616005)(478600001)(426003)(8936002)(7636003)(36860700001)(53546011)(31696002)(336012)(7416002)(16526019)(54906003)(186003)(2906002)(5660300002)(8676002)(83380400001)(86362001)(110136005)(82310400003)(16576012)(316002)(4326008)(70206006)(356005)(70586007)(47076005)(26005)(36756003)(36906005)(82740400003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 18:22:36.5193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e38825af-e751-43d2-78ba-08d90e606d82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3282
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/21 9:17 AM, Logan Gunthorpe wrote:
>> Returning a "bridge distance" from a "get map type" routine is jarring,
>> and I think it is because of a pre-existing problem: the above function
>> is severely misnamed. Let's try renaming it (and the other one) to
>> approximately:
>>
>>       upstream_bridge_map_type_warn()
>>       upstream_bridge_map_type()
>>
>> ...and that should fix that. Well, that, plus tweaking the kernel doc
>> comments, which are also confused. I think someone started off thinking
>> about distances through PCIe, but in the end, the routine boils down to
>> just a few situations that are not distances at all.
>>
>> Also, the above will read a little better if it is written like this:
>>
>> 	ret = xa_to_value(xa_load(&provider->p2pdma->map_types,
>> 				  map_types_idx(client)));
>>
>> 	if (ret == PCI_P2PDMA_MAP_UNKNOWN)
>> 		ret = upstream_bridge_map_type_warn(provider, client, NULL,
>> 						    GFP_ATOMIC);
>> 	
>> 	return ret;
>>
>>
>>>    }
> 
> I agree that some of this has evolved in a way that some of the names
> are a bit odd now. Could definitely use a cleanup, but that's not really
> part of this series. When I have some time I can look at doing a cleanup
> series to help with some of this.

I'm OK with doing cleanup later. I just tend to call it out when I see it.

> 
>>>    static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
>>> @@ -877,7 +884,6 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>>>    	case PCI_P2PDMA_MAP_BUS_ADDR:
>>>    		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
>>>    	default:
>>> -		WARN_ON_ONCE(1);
>>
>> Why? Or at least, why, in this patch? It looks like an accidental
>> leftover from something, seeing as how it is not directly related to the
>> patch, and is not mentioned at all.
> 
> Before this patch, it was required that users of P2PDMA call
> pci_p2pdma_distance_many() in some form before calling
> pci_p2pdma_map_sg(). So, by convention, a usable map type had to already
> be in the cache. The warning was there to yell at anyone who wrote code
> that violated that convention.
> 
> This patch removes that convention and allows users to map P2PDMA pages
> sight unseen and if the mapping type isn't in the cache, then it will
> determine the mapping type at dma mapping time. Thus, the warning can be
> removed and the function can fail normally if the mapping is unsupported.
> 

Let's add some of those words to the commit description, perhaps, it's nice
to have. Obviously a minor point though.

thanks,
-- 
John Hubbard
NVIDIA
