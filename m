Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515201B07E5
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 13:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgDTLpH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 07:45:07 -0400
Received: from mail-co1nam11on2078.outbound.protection.outlook.com ([40.107.220.78]:36321
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbgDTLpG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 07:45:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRn18vqMuonMDrI5ImDCz/oqCGW1VFYEJuXxNxocaDNMtJf3CFRiJOlJAjgSkOUEVdD7bjJ3LMwXRil5dvZQun9vxmsPJT8LGGfpSQNXnCD1t4jD0RpTiXc2AJPhS+tLdyit4ExQWFbMRj2IR3kpf56O1IL9Lj8EDwUZCMJtBGRpXqx70bpkN6j0+CZhB3rfl+PcEEAx40EJ4uW1hQu/yu4aPzVmNA8B7d3lRdtpk46qrpWXdRcWRhIlaZcIlFwtT2jFNV9yBBRjWtwCjgR6Z5giq1IjroOBfT/Z97qR61e79dUwNkC4SCRCMTKV4BJbhV/kQ10b60GHr/Q8hn7k+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOxyzzR0mhxCWFjqMmRMTu/FS8q3ZvQR03qdyayOSHQ=;
 b=nq0grDCjhRfjlFvyF8qKMoOTU4kIIm0ScWOMylmsKTCtyKO7gu4d+hU3TBJVb0fQlfY0QAvB7I3TlesxJUamzsRNA0/W5pZggs3QEBraqHihaDGlxkbe5YlO0H3IrK9Q+NqeduLy1NlATO9kDYl4GIvX8sTEXuXHAciWQJxD+jc19bgObHxGjZUy/vMOiH7EjaiC5aXI0OZs8uj4ed61HV7aDESoegVxfN40kEWIRRvrzXCr1Oora0scyBFJznSbJ8u4+r5wuXp0tH2KmJQdFn4AKjspdxiM5SU6ZSwEAFfKt0/w13J/hiG8fZ1mpP+r16LVsh1/dlxpXEnnCOdcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOxyzzR0mhxCWFjqMmRMTu/FS8q3ZvQR03qdyayOSHQ=;
 b=gs+ZG9qCeLmncq3kKzS21qtuAa8oBifreJwAkmXlwj48hVdiNvGCL4mEAPd3Ji++9QFkvBQbFUB6tYBrf/6SJ3kV4AtcFEkx4dzfGCfr2cLXOdruB7V3OAapMC5MzvElJBIuDU5EznB4U1zTJr5JuSEyMM5Svyw886aBtR/gLTU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3241.namprd12.prod.outlook.com (2603:10b6:5:186::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 11:45:03 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 11:45:03 +0000
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
To:     Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6b195512-fa73-9a49-03d8-1ed92e86f607@amd.com>
Date:   Mon, 20 Apr 2020 13:44:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200420081034.GA17305@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 11:45:00 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 632cf558-1abe-4fe7-d17e-08d7e5204385
X-MS-TrafficTypeDiagnostic: DM6PR12MB3241:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3241E3EE24A56078CE452E2283D40@DM6PR12MB3241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(16526019)(110136005)(52116002)(36756003)(316002)(66946007)(2906002)(4326008)(6666004)(66556008)(66476007)(6486002)(186003)(8676002)(8936002)(81156014)(31696002)(86362001)(31686004)(7416002)(5660300002)(2616005)(478600001)(4744005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TnM9tBkGiAqS+eg5u3M5Lzj83pEWCZbedekWZ7NyeLfIA+1OGNw+SctAsTqXdKP+ituQ/0WvpGY+gkSHGt9+iFbYKrcCYRN+QtFI50IuLa1O6vhiSJhDqMsCsG9BTQk0tHxoZcyEYAynW65hK7TuyFXkR3f8w3v6V00jjpZB2vSDmjn8zh2Jy9Dvto03b68ixDtKZlmWDt8I+IU0wkLzeI5wHNjVQt5qufecvwNzXyeZLO97IqnQR1JM1DtrLkbKISBtgndduR/pQtjgAhY1lWoUfFjcMgELS5F6dhMCwMiow6WLbZ25xTTtR0AiIsUYn7+oolQKlReimEWj9fCFsFsyywi34QZPIGklL3ht8KWzXasjNK3Eabnl8LMG2mKHBcD6Xh6OBVr6WfbOAOILXfNSWfL5vPAGTdXJEstbJgKjYj/zPje/VBS0Ni0+slsT
X-MS-Exchange-AntiSpam-MessageData: y5NRlB+r1IuqYhmKAKNFsm6FvLIfoSHp50mMQALscptuwy5BflGk8NJ6XgL13P076CbRx4Xs9JpYLcy+jdX3/WCskJgKuFVQyf+F/H/JnWYHW1I+9pwIR1xew5zP45ZjXnMvijyJ+xFAL8QJSoRFhLd5xqpkENf7dJpPodku+dVtkX6YGlAeYn1bLLX7ACRqLQhciOJ+zcLgaLh3w3uEvv7KZDdbLeiAEAuuRRNsMkiDC/NUmTznIXgckQlW09UTp0uNnbVKq3MYJ9i6mG1Dor2mKqfBc80AL3ykyydi3vdE3L4UJjwntVKHxGoEDXbnRds9QMAMEGzpNZFEjWdOQMePJKwrdTGKiNgnnpPikSqH0OqsLn44za0/gpHjJA2W5E9BrBM287ypsDSzSNOxjzYcJ3MEah5LgSvwLhqz/Gsc4GNlXfZIG85UJ2hyDuXlMlsoaLYgAG1myMbCRruomXD9ryBp4duOaJAS3zOI14ZGhaOB1LLjGF+QNBi/t0XNGVWbCgWRnFACPfMLZMl8DRRueONUdeUhBE1HltdK8bQ+TdmG5i6r+YvztilCPEAWcgCGUThnEIBXl00fUC3g5K+R4QCsn+mojiV6ss8md41eR62gbwX7o7lx162D3OsumNSyUgFvJFxtEN5GnmO8cboaDO99bqfp53Lnem9FhykVgjPooB8mNdIKPR1Ds/hDb/o/GO2QLeVN+YVp8ZLWyhvwfyAvWowtDkpZUK+rbw09yENm71P19Fi+jVS518aoLHPF++ii+9O8cHuIoB5WP1440eb/j45MSA1fsjslTFWXItkfS8z41cfdda6mbc7EGlfTr3uQ0c9sD9h7dHze/GY+whAA+KDVGm6nOuPqhNg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632cf558-1abe-4fe7-d17e-08d7e5204385
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 11:45:03.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Usu2ffe+8FnH1XtNKjI3J18f14G1t/lvYPjmmo2LvyFKQaO4A5bpFw/BRikZ5fDs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3241
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 20.04.20 um 10:10 schrieb Christoph Hellwig:
> On Mon, Apr 20, 2020 at 09:42:13AM +0200, Jean-Philippe Brucker wrote:
>> Right, I can see the appeal. I still like having a single mmu notifier per
>> mm because it ensures we allocate a single PASID per mm (as required by
>> x86). I suppose one alternative is to maintain a hashtable of mm->pasid,
>> to avoid iterating over all bonds during allocation.
> Given that the PASID is a pretty generic and important concept can
> we just add it directly to the mm_struct and allocate it lazily once
> we first need it?

Well the problem is that the PASID might as well be device specific. 
E.g. some devices use 16bit PASIDs, some 15bit, some other only 12bit.

So what could (at least in theory) happen is that you need to allocate 
different PASIDs for the same process because different devices need one.

Regards,
Christian.
