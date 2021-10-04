Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BCE421212
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhJDO4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:56:10 -0400
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:35872
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234270AbhJDO4J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 10:56:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amv5xp5m5UkEjN+333FKIu+3NJ2p85Y7TX0LdVgUX1GqDFTiH60o8GTQEXVBk2hpoljle6BV2fLzH3RU2tyt3YoJeyuf5vRSH614UwJPXYcMI89ycIXduXdxt6IfVyQUfrdnVN0Ao3cwUJYShSyMS50XbiCLd6/zzWVWsnR6ZfqPfJy+HfDmV3Ix8qV3mxukYWhUAdTInkeYEAl8VYMNkT1pNOhJqXOSmibF337ezjAy3GEzOVBSICb2SWNhkfWPamoPz11ROYm6ZNdp+ckV+ZHqvap6KDIMAwZgNHuKjX54Phyx8kPltY6EAQqJhYUEEY56KUZ6VlgHXyYDznWp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsKJb26U3+gtb7PIb9WqUQ/aXXPgqu5T5t8Y4vk3Mcw=;
 b=gJXRCbagAJ6DO2xaSrXzt3VBOgIhAfiJS88Olj7FAFjkKrptszPllrrljeotM4NDHi/7KM1Y+d5RWL+yjXzI+7LPIaDLLsbZmD5mVnRL0b8BDBZeKGRp2Bgd4Y5AgureVZAdcJDLwaaLIiqsHTM9RIRk9X9h/RoeMYGwP23b+yrPMN/s2vttMjh88J8rHGTVi/1Hn/1311l6bLzFb9i3g//xzS4adZ7ERr5Q07IBP79x2Bop76+6YfTqrWWlWJUUiScj+3Sg5ZbGn93Tk9N3cYU60/SwcsDHK9Ryck5AO4Ff0C0ncRI1VSQDi/5oenLxlytWvnYu0vTv3gWr8i7Wwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsKJb26U3+gtb7PIb9WqUQ/aXXPgqu5T5t8Y4vk3Mcw=;
 b=TNmXPwmJnRxBygkPPXztQy0Mh2oHKCYantFRjeJUrooAzFL/sGI+V1h/aBufTs395mTkqS05qTcMU1NFQGIoBUdAzUjIzcpvGhec8aaHPnDC3c8jtzOjzOC5bMugJlahLSYg6MYfpNXUF7e0s7dCr+LH35vsD6jTRkbo0pVSnKU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1214.namprd12.prod.outlook.com
 (2603:10b6:300:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Mon, 4 Oct
 2021 14:54:16 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 14:54:16 +0000
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca> <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <809be72b-efb2-752c-31a6-702c8a307ce7@amd.com>
 <20211004131102.GU3544071@ziepe.ca>
 <1e219386-7547-4f42-d090-2afd62a268d7@amd.com>
 <20211004132759.GX3544071@ziepe.ca>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <613362ff-bd2f-b0b1-634a-55dc4c3837fd@amd.com>
Date:   Mon, 4 Oct 2021 16:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211004132759.GX3544071@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:bd14:2b97:8d11:9c50] (2a02:908:1252:fb60:bd14:2b97:8d11:9c50) by FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.13 via Frontend Transport; Mon, 4 Oct 2021 14:54:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93229e0a-f1c3-4f8a-1d9c-08d98746d5ed
X-MS-TrafficTypeDiagnostic: MWHPR12MB1214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB121461AFAB703FDAE10B502D83AE9@MWHPR12MB1214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BeFLnLDmWC5ejqhjuN7N6FIFoll5ICLPlRVvcj8fqAaesLviJJp66dxfFTLhYlVfF8stDW4+v429qnIQZbKx5GcwrD1NrxN7K+PkpHhZynq1yN1llan0ZvRhy56hubaPJ7SbdUWG0k05CY03Cap22+ELvB+BEtBAr0ZxD26kHGtMMYa/8fhg8cJcabVmD3BG/xvr1p4+D9VxzQHjJ84G/qCPtWNUq5pID2oZQnWZmGEPt6lElFS886bEX6gdkukVc7W+jzceh7z5swiuLuqM3ohvd94wTTKOrEYmfjcfLYoQggAhO7c3v2a5jwC+hgolzxSMPf0oC6qYJJCshO9cCrldOJAUcNwcMWL2xHo+dsSqWk9tNVXmJJDuNTIMXEu5A/RZPvnh6hWABOMjYgSs1KTDiTtlpjS2EiaHtwBckvnJkzzGJM+6LzN7i2FLi29jqkyZBbnSxbqw+dxchLrhHpfxwKg/vsIGR7x09Eky01/1E97SdD5kNKtkMB85Y4+b4HP9QyKtc0TX6lMh+hm/2e0kSxtpPbHAiNlvcmMY/U/YQ1H/tYHK1HGobcgSXbP+Mr81Kbjnh+B70DADA2hUO+wbj4dsACzABX3KE1pst1vkVF6uqWGAPo36XUYJyXDXyRH0q+xz1WwCrdd6DY9e0e511FjhRqtp2wnm+w4uye3HXg1OkRvCwz6w+76OFEkgkYkithB80Pq2Zt0HbbTs8tvUnMUFGHwY3aEvFyx7qmVJOVx7pFwQXAPwxQcBW/eq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(54906003)(6666004)(31686004)(4744005)(31696002)(508600001)(5660300002)(66946007)(83380400001)(36756003)(66476007)(8936002)(6486002)(2616005)(66556008)(6916009)(7416002)(186003)(38100700002)(2906002)(8676002)(316002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDVvUmN2V1FQUithdElRcTVIRlNrNm1mZUExVmQ4ZCs4QWN5OWlod3Q5V0Er?=
 =?utf-8?B?dUQrM3p5dm10M2RWQ0pETFJnWVplMmwwTnhjQVAxZjZOL1lPOWRuS0ZhYU83?=
 =?utf-8?B?eC94UnZFcmVvT3Z6TTRMTEpobk9lT1FtL0pUNWpCQktEbUM2NE5RSWh4UlRr?=
 =?utf-8?B?WG50ZkJCUEVWdXBmV3RzT3F1eU5kM2xVSEdyS1lHQTRzd3lIWCtDbjYweFVL?=
 =?utf-8?B?M2JrbmVZckhFaDFWTnpzcWtPQ21KNUZPNnJCUkltSmJSQi9teHNFRnBka1hn?=
 =?utf-8?B?T2I2VC8vZ2JocTZibzliZWNmZUlKT21MdWJvckF1aE9DOXJ6QktRcE94Qzly?=
 =?utf-8?B?RkJQdVdSZmlRRDZPSUhqUEVkeGQvMm9NU0trNDVSN1lmZndyU1dESHBlUmVp?=
 =?utf-8?B?M0VRTUhXOUFoT1pBUi8yL0lLTldUSkZaQWp2RTFaTlIvMWhGa2hYRkVIelA3?=
 =?utf-8?B?cmVtc2hzQzFBNzU5RUl3ZlByc1AzQmpXTjBPeFRtbzZwb1lhOVJWendyQnVq?=
 =?utf-8?B?VXpwWmVxWDBJaVdiU2h0Q2hOc211MWFBdjJoWkl4c2xvRnlpZXdDUW9pN1F5?=
 =?utf-8?B?S2JpcUViUzRPcTlmNy9MMGJOQXhKWkR3VC9aRjJvWGNNT0JuM2RZWWRFY2ZT?=
 =?utf-8?B?YnUxVHp6TUhjbGZUS1pITGlMcXk4Wk1Rc0RxWnVwNDJMV2VMMmRTVk9Fa2J2?=
 =?utf-8?B?MXJMNkxJNHlRQXB0QjIxUWVSeEIzY1FUMkFuYWVXUDRFeG10SUpRVkZqTXRj?=
 =?utf-8?B?NmU2QTB2M3c4N0RPdi84OUNRU3A5eUpieFhuL3pCa2wyYlNQcDFJK2xsN1la?=
 =?utf-8?B?MngvVUY5OVRtcWhwV3pRSUVhQUZPNDhaWlpCaDl2SklacEhBMjZUY3V4WlJP?=
 =?utf-8?B?a25rdTJSUU1qdEdOclE0SGFWdHk5QXFvU0cyTW5nWjhtN29rWmdJYmlrZ1pE?=
 =?utf-8?B?bGNaWmMrdjEwcWxvN0dETmpRUk93MXV2MzlMNDVnR3lCelRzcWFZRnNxbmNC?=
 =?utf-8?B?ZWJZRHhydGlZWHJhV3JUSi9yZlVXcmRnYkd6TzhtdHJ2NUFNT1pabVJLUWZK?=
 =?utf-8?B?c3JOaTNsUTZwNVZmdTBrNG1IUGlFR093QnZOMzRpSC9Fd24yK3FUR0ZhNUxJ?=
 =?utf-8?B?Sko0WXpFTTVuWHZHV2w2SGg4VmFlWmFaNE5jS2hLRGhKczRwVGlDZlRHMGRq?=
 =?utf-8?B?OUkyYmhVUUxTRjAzVkljL0tFdGFxOFYrQStRS3kyU2Z4SDRiSzE2YnY1SW8r?=
 =?utf-8?B?RkdCNm5OT0tBZjVLenBTMkVGek1rc2c2QlBCSGVFNno4a1dHZ1BUdmlGbnQ4?=
 =?utf-8?B?WDI0L1hBSHBZWGZUTUt3bWszSWQ4SEllZW1ka1kwQ2w1UkgyRmsrU1FIeU9o?=
 =?utf-8?B?N3A4OTQzM29OcnZ4NUtnNW56NXh4T2RRa1Q2RFYwMWpRUHBnUGwvRnVZU1lu?=
 =?utf-8?B?cm9GR2xHWnNPbzMvYTlnUnNjTUkwSGRIcVFaMVIvMUwxNHhJeCt2ZUN2Qy9h?=
 =?utf-8?B?SHJkemxnN1lqZXNmZ0ZBQjZpKytNZklBR1dXeVNOSGJUTmJoSEhFZXFYbHpF?=
 =?utf-8?B?RjZvY0JYRTRGeUo4UkxoT1JEamkzcWlVQWhaNkt4K1N1VGsxNUpORnJGdkNK?=
 =?utf-8?B?MWM3T3R3b0tubWNRaDlhWHh0YmZMYmtadkQ1S3RaUnB0dHp6NWQzZlV1ZVNn?=
 =?utf-8?B?TlZTNlp4cEU4bEFGWnBBWnVjdCtCUTlWL0FYQnVkak8zNnQ3aktWcUsxaU9i?=
 =?utf-8?B?RjIvbUVZTmRzaUJOcjlmL2JRNm9WZ01NWkJueWJ5OGErRDcvU3I1YUU4OHRP?=
 =?utf-8?B?K0JoUW8rb2QybXo1ZG96MEhiR1ltcVIzSzZrS0ZQWUd0dVJrL1FGQkRnUURy?=
 =?utf-8?Q?0rKI39UTTIH4+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93229e0a-f1c3-4f8a-1d9c-08d98746d5ed
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:54:15.9771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqSOru+Lpa7/li8gz64YdbiYsmZC1fN1JFtvOvogPKWG7BusoiTqVgvnSwxc7b+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1214
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 04.10.21 um 15:27 schrieb Jason Gunthorpe:
> On Mon, Oct 04, 2021 at 03:22:22PM +0200, Christian König wrote:
>
>> That use case is completely unrelated to GUP and when this doesn't work we
>> have quite a problem.
> My read is that unmap_mapping_range() guarentees the physical TLB
> hardware is serialized across all CPUs upon return.

Thanks, that's what I wanted to make sure.

Christian.

>
> It also guarentees GUP slow is serialized due to the page table
> spinlocks.
>
> Jason

