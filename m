Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCDB1B0992
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgDTMkT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 08:40:19 -0400
Received: from mail-eopbgr750070.outbound.protection.outlook.com ([40.107.75.70]:59726
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbgDTMkS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 08:40:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuTKzlnaAap+PflC6UNAwkdWbAWWFO2/3KH9FCLvLa+GLvZhjopdtrgjxLgKjQO1nlcjpMv+xVHXbZgMKrSP7rdMN5pkZ5JhOXKMkPiRHvzhfg1Ew83yS6kIpJFJr6106wqHuTUug+WShyYdpsj3VnIjQazAXH4LH/pdATxRSsZVu28+hxym5UoGdST8pd3vvothd1qYT7d0QZBN3mdOoyEqM2IvKYV0RwePiMw9aiWA0YS34RdQf5nwSI9tRz9lsyj28b+dP5OVf7rhJUw4Gq2GjnAg1KHrjirxGnZMGPE9jGqDJFxfuAypySxloulj0lK3YdtB/UzaodSm0BFvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15a3GnumC19u3Q448ZVTc3UIlKkPdASCim+iBINpgck=;
 b=dm7BUTQd+Q8hswrlvXDCnelShlNDThMXjvUHn26eOBiOLjFDnnGwen2y1+7KrsJ8EP+TCvk/1NSD4D6J8hUd8+Itx5I9qM2r1paYgVg35XfyudykXwDfOpxR+hEX3fWtxKumkGde/kIxFNaGv2WWS9njJ+L2WbaUTQSKdNCdp6wy04PMxblpcvDQDL2f3BWo8wdnoALO+5gXxHwOli9fr2zMh+mMBZQ95Nu07M9+NnIb1DxOkvQahxjrqu3bKkDdDpSRdfaFSCXkMA5iNY8XwoTMFoNOm/HbdaMZm+PlkrjYD+2kzKnyDtlXOI7WflSxXl6xbdFSDJB5g4ZW8PXEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15a3GnumC19u3Q448ZVTc3UIlKkPdASCim+iBINpgck=;
 b=e0rZAY+roCY7STiIrQzPPJ3S9wAFMI1ewTIPYqd7VwVA8yzvYOKr/RMXyVaYqKfhqexWYmcIRf5MtWJjRW5wcjGeVrUDQgfAMm577wU9jsF3mCTwaq0tbhrP7MlDgJTO/Lq8DSXqCoSZKc0LX0gQs+7r1YNQhs/hV1fv3DF6xOU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3098.namprd12.prod.outlook.com (2603:10b6:5:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 12:40:14 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 12:40:14 +0000
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
To:     Christoph Hellwig <hch@infradead.org>,
        Felix Kuehling <felix.kuehling@amd.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, zhangfei.gao@linaro.org,
        jgg@ziepe.ca, xuzaibo@huawei.com
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org> <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org> <20200420074213.GA3180232@myrica>
 <20200420081034.GA17305@infradead.org>
 <6b195512-fa73-9a49-03d8-1ed92e86f607@amd.com>
 <20200420115504.GA20664@infradead.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <966e190e-ca9f-4c64-af05-43b0f0d8d012@amd.com>
Date:   Mon, 20 Apr 2020 14:40:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200420115504.GA20664@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0103.eurprd07.prod.outlook.com
 (2603:10a6:207:7::13) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM3PR07CA0103.eurprd07.prod.outlook.com (2603:10a6:207:7::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.5 via Frontend Transport; Mon, 20 Apr 2020 12:40:10 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3160d303-c6c8-49d9-d749-08d7e527f913
X-MS-TrafficTypeDiagnostic: DM6PR12MB3098:|DM6PR12MB3098:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB309823358CB495CF0C01E1B683D40@DM6PR12MB3098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(36756003)(52116002)(186003)(6636002)(31696002)(16526019)(31686004)(478600001)(6486002)(5660300002)(86362001)(8936002)(4326008)(6666004)(2906002)(66946007)(66556008)(66476007)(81156014)(66574012)(8676002)(110136005)(7416002)(316002)(2616005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efugUPiNs5RHrr8Fj8C6f0/P8LmMrLf2vPMppXcgf8/x+emZxErQj68ajkrim60Ulpb7qLE7LgBvbgLH13UAiIXWGoLg9pgJCzu0D/ZzSfSuwWme/HD4d0IonMJFyubAtJ1Z7O0jYCz9790mAdtjruuJZxiVqLmUIUvEXJnx0jTgA4/rIgjCTnid9zBvjJXZglX4VwCR9R0hwfFJ4/VQlPkUEUGlZ56TKT1yKbsw7JWitZ9APwWistmp4I9WpE4QA3SRwOGLGKrvpLhwXolul07HxKXtt9Xtz2P9CuzsqFqA8NhpyVstXSu9UYgJSs3nMaWNazZGzqXHYyO4kQw6AMtVOvRRs32t/5ken+izZSoogZk2s+IiIi2r03JRuJJseYTVd0+6KITqKIV7MVwsCcwnqu5LAny7jSbuMyg9S9RXeHEJ4hKddzKdV+XMwlyz
X-MS-Exchange-AntiSpam-MessageData: KGs7kskpLNZ814rjWPchfm2aEHQ3igHquB9ZfeHHXrFwe5S1nbTlRlqffdCyBNlvi2n6LzlEz9t9H8c4uy5AGa9haNu1tijutkEc3c60iMf6Fzt1dxc3bJMz8Aec4XKdEckkSaBifunslbzINGBnyOmLWvguV/N2s9bbkloJNgVSfb9blMRBQ29Nv9AMKMHDVhxjbkuuMt/QE9urDKh+SP+csHys4opdb0jRSeyu1c/CujtrM+ZRcD4wkE2BUlPTme0IxlGHcZGtXiPlCJ41pDdceKCFZ1ae8cJnyzJBwdiuWfs2PqHM3aCzB+QYFL/86l60HC/jkzkvouoVfSK++Ld2sibAiSqhvn0n2ZA8SUoMX6r+Fo86ZRupmuQLEb/D0MX+NL8K1nMb+TFFJS7tmQoMBkP0/kx4z4MBXAxQMnFTa+54fxamjln6+XBIpkYIoKFCOxvr1/0ie1PFkmB8vPPFTcPqoJVDtn4w7oCwBmmKJ7pcQzgMQdrIUJOGGXwX4Tj+QBr3U+c2ouseHkQgn0rwwY1tDIuvnAryi5MuV3wASLbjmHd0qNlGfLeOzZtmBoGylsdKWfdNF3tw1azS9BPDRUMNTrdJe1kuGEcWIlTSUUC/twEIz0zv8nmG0oHkGY1r2DlyZuo+wXFKd1xMFiQAQoLhgEYFexJd5F7z10/wJzBfIIxDq79c03elTmlV3HBCiOvMgZxZcl4ujZtiK35Dm0dDE/ETc006B4Rbmfg8BTUN9kiKlprj4CSUL96HtX/YRSahuGyvVVWT/oyYoupEpHB9H/ooUJZIRdKDunxf7kO6Wup7pWKnVJF4nPVHs26wxzQghyaw2gTlMcZPAiCkV70shxW/j7ZhlLEdPHg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3160d303-c6c8-49d9-d749-08d7e527f913
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 12:40:14.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0c6qHkoa3ugzEHQmd3AsEsoI3JBDwiO4toqkxqk5offu+fcrlzTpGdMPiFL5Ci6D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3098
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 20.04.20 um 13:55 schrieb Christoph Hellwig:
> On Mon, Apr 20, 2020 at 01:44:56PM +0200, Christian König wrote:
>> Am 20.04.20 um 10:10 schrieb Christoph Hellwig:
>>> On Mon, Apr 20, 2020 at 09:42:13AM +0200, Jean-Philippe Brucker wrote:
>>>> Right, I can see the appeal. I still like having a single mmu notifier per
>>>> mm because it ensures we allocate a single PASID per mm (as required by
>>>> x86). I suppose one alternative is to maintain a hashtable of mm->pasid,
>>>> to avoid iterating over all bonds during allocation.
>>> Given that the PASID is a pretty generic and important concept can
>>> we just add it directly to the mm_struct and allocate it lazily once
>>> we first need it?
>> Well the problem is that the PASID might as well be device specific. E.g.
>> some devices use 16bit PASIDs, some 15bit, some other only 12bit.
>>
>> So what could (at least in theory) happen is that you need to allocate
>> different PASIDs for the same process because different devices need one.
> This directly contradicts the statement from Jean-Philippe above that
> x86 requires a single PASID per mm_struct.  If we may need different
> PASIDs for different devices and can actually support this just
> allocating one per [device, mm_struct] would make most sense of me, as
> it doesn't couple otherwise disjoint state.

Well I'm not an expert on this topic. Felix can probably tell you a bit 
more about that.

Maybe it is sufficient to keep the allocated PASIDs as small as possible 
and return an appropriate error if a device can't deal with the 
allocated number.

If a device can only deal with 12bit PASIDs and more than 2^12 try to 
use it there isn't much else we can do than returning an error anyway.

Regards,
Christian.
