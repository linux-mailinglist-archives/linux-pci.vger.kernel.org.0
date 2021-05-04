Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16ED53723D2
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 02:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhEDANa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 20:13:30 -0400
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:27296
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229497AbhEDANa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 20:13:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dxg7qIGI4vgpG5JjF3CGJhhGL/BL/JnproycOe8Jc0C789lbTnGJBwYVc+/PEWynvBnTnWNuyMy9SZhPuZl75JVGSH1A4fuK0Wg0BrZ6V6TdCNjELemOEfg4GMIeqZZtA3mVCD6TXp/apubCAgphaDA5mqPS4vGtofp9XYo4sIf+BffrfuGdFEUu3+y+RMQ7I5tZBpZVtOjdejktQeyA8A6gtjJVYlej7xpStEfV1EjZf+fwAEWCfCaZXgXszPwiNSvTTVRIsyOehWkM1jDWbLarrd8nVLaiRaFw76V5h2VRr9VMNxQHzIvuikutk5twlXtZN5gkVnXgX+/T84Spkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6wsklSkLPlyhjHfYFFzs3hqmGcJWrEzyR3+KtX004M=;
 b=AkNfb8GjlTDOaAZogwMWkawBccLPSyAOVoNrIT+MYuq0kv/eU9JpREZcXQrACsgxO9LpcRAM5ceecYSd2AF6Vpwt7ZZTrKreKOb9Kb1m11i1v4DukZEi2snUDEAlkNVzCEDVLorV8bTQN3Din768E7Drdcv0m5V7SVdmi6K9jmU8s6bhDmcpY7oYaammNX2JvJlOCZTsDS9AYAy1nX4qjRELQ4S70mYg0BD+YsTrlA065RTiuDYy35m84aJBJor7e9z4PApNL2aVZoVjvZgp/pfXNriD9Ppg8R20DMz8O3zGP0osspIgIqyjTLKkr97MSvkoK3uUS4Gvo4VWK8aqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6wsklSkLPlyhjHfYFFzs3hqmGcJWrEzyR3+KtX004M=;
 b=DJVaaIGcrDZOHF2Tkb7yWlb3/ve6nWjc29n8pF5QcBpiaQhlQPlVAs0LYlYWVi5Wur+4ftP4rvU8neL8rD/Ap3UkQGN5BFwdqvixPOGVUxPInfUrGQ32lqcnCSkRMnqh8RbIutKjyYH0OVqqXrUfRjm4mrFF50BDHCKyJGCMfc2hk8Z0FUMi8Q4eG3z0g5oe55iJdkS1YzIRonOxJ7EY6rLbGJc0vefqf6KddSl/qOTS0fYf6aXQ28BynGtJM7z4onKkRiiqyrQoq5C6nlUDRuCZYlU1oMkTkVEcW1tOpOaULt4wlc49HXfoiPCB/McrGWdQiMGpalquNvNzRFvneQ==
Received: from DM6PR03CA0004.namprd03.prod.outlook.com (2603:10b6:5:40::17) by
 BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.40; Tue, 4 May 2021 00:12:33 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::4e) by DM6PR03CA0004.outlook.office365.com
 (2603:10b6:5:40::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Tue, 4 May 2021 00:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.32 via Frontend Transport; Tue, 4 May 2021 00:12:33 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 May
 2021 00:12:32 +0000
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
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
 <20210408170123.8788-10-logang@deltatee.com>
 <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
 <aa0698ba-abad-8c07-2962-d66b6a7affd9@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <7a44c5b2-2ca8-514f-0952-711166acb502@nvidia.com>
Date:   Mon, 3 May 2021 17:12:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <aa0698ba-abad-8c07-2962-d66b6a7affd9@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af1c0519-6a29-4789-42be-08d90e9150b1
X-MS-TrafficTypeDiagnostic: BN7PR12MB2738:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2738F8A3A49F08595E066CC3A85A9@BN7PR12MB2738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsIKbooXENDu8IPLgv751tEvwS/p94XEeWTCN+AqxhlJ6LcSEW7LRgNCR1WStjPYosCu8quPqGrzi/guVh2+51oTtILAnZuSYvs5Mqrp1nvYYPMpLRBM4QWLosqhhQf78xvSbPp2gGDN+jeR5DJi8zYKj0v5pGgvmw/xq6699HuVA37EIHFK3OqIBoxEeHnww2pyEd0ho8zC/Yf1hhDGUdWAGKvN0OhiapdUKlAvsYvmO4ZsdvajJl8rrQ8ICBcuT/GfzmUzPdd72lqsJrmNOKxML1fVWRMbpRg3yH2degKydLxpd2KCALnzRssd640ZOtEh3x/3luENythODzcHOqOqXtZWG1ZO2WToNNwi1h/hFreJYB4R7hqAL/DwQSiYfBdWaNJHfBH7defryPjR6AlNisHXxk9Fy9+0tw5i7h/YUirgps5IBFg0HwBUrVCb08JDzMRRxpNWw95ZMW9diitSd+UW6tKMGNwG3R3Tq1EifLIhNTxXb7TuISbJ4jlgeJID+j7SuV0GY73sStz9Zl5H9Co9dy9YHvOUUOG7FKl9Txql9J6ksY9Ed5lmyUvqQxiQXCic5qWFD8K5HLvs6GR/MJCccP4voipcFGZw6pmG9SAhzoaJmD3VQ1VWdBxjfNV5mpiba7ML4qStnz/f4c/fotVyISfAJDg7+i4SWCkYd5YOI55V/2G9r8elaiXmhtVi1AT/DxHYn/H93+aCMw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(426003)(54906003)(36906005)(82740400003)(8676002)(110136005)(4326008)(7636003)(70586007)(316002)(70206006)(2906002)(478600001)(82310400003)(5660300002)(86362001)(36860700001)(16526019)(31696002)(16576012)(83380400001)(53546011)(31686004)(26005)(47076005)(356005)(7416002)(2616005)(336012)(8936002)(36756003)(186003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 00:12:33.5307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af1c0519-6a29-4789-42be-08d90e9150b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2738
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/21 9:55 AM, Logan Gunthorpe wrote:
...
>> The same thing can be achieved with fewer lines and a bit more clarity.
>> Can we please do it like this instead:
>>
>> 	for_each_sg(sgl, sg, nents, i) {
>> 		if (sg_is_pci_p2pdma(sg))
>> 			sg_unmark_pci_p2pdma(sg);
>> 		else
>> 			dma_direct_unmap_page(dev, sg->dma_address,
>> 					      sg_dma_len(sg), dir, attrs);
>> 	}
>>
>>
> 
> That's debatable (the way I did it emphasizes the common case). But I'll
> consider changing it.
> 

Thanks for considering it.

>>
>> Also here, a block comment for the function would be nice. How about
>> approximately this:
>>
>> /*
>>    * Maps each SG segment. Returns the number of entries mapped, or 0 upon
>>    * failure. If any entry could not be mapped, then no entries are mapped.
>>    */
>>
>> I'll stop complaining about the pre-existing return code conventions,
>> since by now you know what I was thinking of saying. :)
> 
> Not really part of this patchset... Seems like if you think there should
> be a comment like that here, you should send a patch. But this patch
> starts returning a negative value here.

OK, that's fine. Like you say, that comment is rather beyond this patchset.

>>>    	for_each_sg(sgl, sg, nents, i) {
>>> +		if (is_pci_p2pdma_page(sg_page(sg))) {
>>> +			ret = pci_p2pdma_map_segment(&p2pdma_state, dev, sg,
>>> +						     attrs);
>>> +			if (ret < 0) {
>>> +				goto out_unmap;
>>> +			} else if (ret) {
>>> +				ret = 0;
>>> +				continue;
>>
>> Is this a bug? If neither of those "if" branches fires (ret == 0), then
>> the code (probably unintentionally) falls through and continues on to
>> attempt to call dma_direct_map_page()--despite being a PCI_P2PDMA page!
> 
> No, it's not a bug. Per the documentation of pci_p2pdma_map_segment(),
> if it returns zero the segment should be mapped normally. P2PDMA pages
> must be mapped with physical addresses (or IOVA addresses) if the TLPS
> for the transaction will go through the host bridge.

Could we maybe put a little comment there, to that effect? It would be
nice to call out that point, especially since it is common to miss one
case (negative, 0, positive) when handling return values. Sort of like
we used to put "// fallthrough" in the case statements. Not a big deal
of course.

> 
>> See below for suggestions:
>>
>>> +			}
>>> +		}
>>> +
>>>    		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>>>    				sg->offset, sg->length, dir, attrs);
>>>    		if (sg->dma_address == DMA_MAPPING_ERROR)
>>
>> This is another case in which "continue" is misleading and not as good
>> as "else". Because unless I'm wrong above, you really only want to take
>> one path *or* the other.
> 
> No, per above, it's not one path or the other. If it's a P2PDMA page it
> may still need to be mapped normally.
> 

Right. That follows.

thanks,
-- 
John Hubbard
NVIDIA
