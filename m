Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7327B371F70
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhECSV2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:21:28 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:49761
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229472AbhECSV0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 14:21:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF9nU+IugYIVFLlgtD28vBVXzUoN8dsHFrObRnGqM0fCMSPxyco6OzJ95xoerqmq0A1oX6Kyr7viPhY6Z3BtYX1lgcgoINLq5ArdnGGazB6TCKNpoRFXeZCVPiuz4LPNg7gLDgh0CjDyfEDomG6emzefERV0jDq+2C41hlB/GBRqsovSI1aIf7D1Zcyapjk85qDdwzmSm7BgtGj853aLreAH6ExTv4GRhByUhKAdbzP56NkfuAoLFeOiszF2EybIr0BzIbOi/t3jvMW0kvX2995ZDBQuCS0GGBCoY7VPj8GdSs+zQfRyetkWQ1KfGXT30FEA0vdaZFpdLbdZ2hbrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9xqhPQxRINPKBEM2wIQ3yUt/apZa8lcpKVrgcDF22o=;
 b=ivR5gnpFPDuaexspjhaJIVY+rSmqlcLKHJFJkMfRYZTcDa3IoX4zTRo9tPemaYzqFhsU2CCS6/RpN0wJrSWdK0b576RBaPnm9nIT8UEMEUtagKqCYA5XZ38PyQpB58iZqL1NGxVM+hf820dIfA+33AnhVTD37nil6dOXoD9MkMqb4sA29zli2aGZBFKY0GnQsa3v+hsJOvWOK11m49CezEcM8snDfhemFNGnOyMIqHiZkzADEw0fKuxRL6I+Jo1igQaRonVxBavpsenibouWiV3H2EeUpV7UUHgiql9u3ncvbooCs6T+JZlHCFWLszw626kBK2bVkljOTmQzZUcepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9xqhPQxRINPKBEM2wIQ3yUt/apZa8lcpKVrgcDF22o=;
 b=P6gvU381ZpCZO1MVINQkrJruOoSMIHDqYBFmzb3zvFwNDx0ip46hRfeRwufAZ5VBGJUm91lonZby9BkR/c+VLaxtRz1yNe631O49OfYtdOqRhvV4fyylufsuiShpy1eYh76xuFYntG7E/amsfdP6kMnASnsY6voDMtlLciOxl9lJegAEjpnOzJtgY000+EKiFjj8qvvAgHL+ZG2wc6LTQarjpIo4o+3vmanCtPcKTiRw+MDhf2fKvg1fGUD2rPoiOQ63doxE7AJ3EyHc0vKHlkk2sS3rRYYtokckrxzTn4bP8lIUZTyHY5kNvjs2JjMVru67Z/ukb7fEQGksQTItPA==
Received: from DM3PR12CA0135.namprd12.prod.outlook.com (2603:10b6:0:51::31) by
 BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.41; Mon, 3 May 2021 18:20:31 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::f6) by DM3PR12CA0135.outlook.office365.com
 (2603:10b6:0:51::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Mon, 3 May 2021 18:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 18:20:31 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 18:20:30 +0000
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
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
 <20210408170123.8788-3-logang@deltatee.com>
 <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com>
 <d4091d87-7d9e-8cde-4e1c-01b877b6785f@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b40529f9-03d8-ab61-4f4d-8f5bd8f860c9@nvidia.com>
Date:   Mon, 3 May 2021 11:20:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <d4091d87-7d9e-8cde-4e1c-01b877b6785f@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79acc9a7-e96c-4828-413d-08d90e6022ed
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3589AC00CA3BE922C965B720A85B9@BYAPR12MB3589.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cZ24FGZKHLksu0NEJGiydLlzlEoVZyR+qQUcjxfwwo/R9FfmGCPQPEm04G3yQ5CtYS5jUNGFIQK4WjeuONpGPcNFR4DPPgOyoLPm3NXAFPBDDoWJ10Qe9eu6oxPyp04tvKXCxaYzNlEkqINrbk/j8rPubJ016SFdhphBck7/fKjij6aiakot0hOphAJOxN4AU8QtIZEs7X8rKG6EiG99xQyDczUSV9XS0cxL81vKoNkl4PgZOQmVHu9rtlnbIhMQWGTu7ZJSSM94l/iqhL7CuUobcmfn766DqxJxckvUiCP2mDsPQ3nzKsHb1Vs8/IRSMeyT3gFmNVHUtbj0JImpc9AJ7uOXq8JgMHSEVIEahdWHHgkml7FlnKVBQOoyoABo4M2kqJIwaDLl7hqzC83oIXGxil5uac6C34Frqgxpu3UYjp5MfC6T+iBV24fgCPRcrdxePXky72VO2942kLAnl7hWx0Np7h25ft5w5jkkvK1YbsQj2NYyCnlgcRa2NE2Ulyjj/6S4npXxsVK6hQ2vhh5tEiaf6/hAvP4/+3EqSsZ7zbk/9B/Axp0xpVW68ZKzJpqOQ7kHg9KqcnicA79Z8uW4o5gpm1Mf4VWuKQY8ikmu2ZvguMvDS/JCA898QTP5c9U88k4DYGrha6E9Ei464pm4Uvemv12/YyEaYKF/aGVezMUnU2Nwf9Ylyf7uKZDkNfusq1isAvlaAjj5n11zQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(110136005)(16526019)(16576012)(36906005)(5660300002)(70206006)(7416002)(186003)(426003)(86362001)(54906003)(70586007)(316002)(4326008)(2616005)(8676002)(336012)(53546011)(8936002)(26005)(36860700001)(356005)(47076005)(478600001)(31686004)(31696002)(2906002)(82740400003)(83380400001)(36756003)(7636003)(82310400003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 18:20:31.4299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79acc9a7-e96c-4828-413d-08d90e6022ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3589
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/21 9:08 AM, Logan Gunthorpe wrote:
...
>> By the way, pre-existing code comment: pci_p2pdma_whitelist[] seems
>> really short. From a naive point of view, I'd expect that there must be
>> a lot more CPUs/chipsets that can do pci p2p, what do you think? I
>> wonder if we have to be so super strict, anyway. It just seems extremely
>> limited, and I suspect there will be some additions to the list as soon
>> as we start to use this.
> 
> Yes, well unfortunately we have no other way to determine what host
> bridges can communicate with P2P. We settled on a whitelist when the
> series was first patch. Nobody likes that situation, but nobody has
> found anything better. We've been hoping standards bodies would give us
> a flag but I haven't heard anything about that. At least AMD has been
> able to guarantee us that all CPUs newer than Zen will support so that
> covers a large swath. It would be nice if we could say something similar
> for Intel.

Thanks for explaining the situation!

> 
>> OK, yes this avoids taking the pci_bus_sem, but it's kind of cheating.
>> Why is it OK to avoid taking any locks in order to retrieve the
>> first entry from the list, but in order to retrieve any other entry, you
>> have to aquire the pci_bus_sem, and get a reference as well? Something
>> is inconsistent there.
>>
>> The new version here also no longer takes a reference on the device,
>> which is also cheating. But I'm guessing that the unstated assumption
>> here is that there is always at least one entry in the list. But if
>> that's true, then it's better to show clearly that assumption, instead
>> of hiding it in an implicit call that skips both locking and reference
>> counting.
> 
> Because we hold a reference to a child device of the bus. So the host
> bus device can't go away until the child device has been released. An
> earlier version of the P2PDMA patchset had a lot more extraneous get
> device calls until someone else pointed this out.
> 
>> You could add a new function, which is a cut-down version of pci_get_slot(),
>> like this, and call this from __host_bridge_whitelist():
>>
>> /*
>>    * A special purpose variant of pci_get_slot() that doesn't take the pci_bus_sem
>>    * lock, and only looks for the 00.0 bus-device-function. Once the PCI bus is
>>    * up, it is safe to call this, because there will always be a top-level PCI
>>    * root device.
>>    *
>>    * Other assumptions: the root device is the first device in the list, and the
>>    * root device is numbered 00.0.
>>    */
>> struct pci_dev *pci_get_root_slot(struct pci_bus *bus)
>> {
>> 	struct pci_dev *root;
>> 	unsigned devfn = PCI_DEVFN(0, 0);
>>
>> 	root = list_first_entry_or_null(&bus->devices, struct pci_dev,
>> 					bus_list);
>> 	if (root->devfn == devfn)
>> 		goto out;
>>
>> 	root = NULL;
>>    out:
>> 	pci_dev_get(root);
>> 	return root;
>> }
>> EXPORT_SYMBOL(pci_get_root_slot);
>>
>> ...I think that's a lot clearer to the reader, about what's going on here.
> 
> Per above, I think the reference count is unnecessary. But I could wrap
> it in a static function for clarity. (There's no reason to export this
> function).
> 

Yes, please.


thanks,
-- 
John Hubbard
NVIDIA
