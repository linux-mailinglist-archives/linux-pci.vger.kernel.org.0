Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D470660BBBB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 23:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiJXVLo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 17:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiJXVLV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 17:11:21 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851976E2FB;
        Mon, 24 Oct 2022 12:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTeKsNGQ+5BHHHvGc+JEyiG3h7thRs7cgUk7fqW2zD+BtUrqfw6oi0cM0xlDU38X5Zva4JpO08yu5RTUV2jgIcXPOqV5b1qyjR+hyzeQaS6hNmL0VDFbxBu+nQXsOQTkIqUYnrCJ9qw2whRyTFx2EBWLUUpx506tyQodFKV8PrCVovXqlpJJQVULEnGMMCg6CvFhHl6UKgeq1dOzfp19SBojTAvEKKmv+HKRNCg2chX6yrQhxqOLcq79x1mFfGmF1pdngj4pJuiswo4aQQkZFOO+Hyj+d25swoHudbt3L0IxmNSUE91HVGvunSDKD8jwksexqfzh5d+Xac/maXkxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DM3OpcHV4qrDNwgMk6RAho/sAjTTyDZMU6e3TTHgZ3M=;
 b=UMzazzyyuFhl0InA8qrrB8+KW3CCXUbFX8cYrsC/6ogf2hUX+1OE/+AcXBJ5k/AYLspHkikQJImms7bE94I6VmBNUDRkdZqRmNPI+lvt7TgTEJjTtH7Ud7ICzKP8hSKpKOfJy54TDEfGwxVSUlbg9bH2w7i5WUbi52z9F+8RpZWsxHfySxaUstdFHuKfQR6iTXmfMfYl9z6tb09xovyCJtu4J/Rmci+cQ1q2oWQK8LyWRGxD6Q6uU7SU9HTXQSktunFSOt8mgZMGZnh8kTp4k8whUNzjEuenjzLNZOwlFaiSVXJAW3SYZa2BMdq2m+xvwLodwpARXaY40ZILLVkeMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DM3OpcHV4qrDNwgMk6RAho/sAjTTyDZMU6e3TTHgZ3M=;
 b=MtsnlUrRc63uVWAQ9RQn8LJoIC5uAG9R1Mjc8VL8ANy68XLCh53hND4/Nv+kdOVgedIwqwjId79gW06g+CMW00aI4iFOso6JIHiPpvQ32AO0cXtiXabzO3VPJ/6MnhLRwIQ1uYJEFEtL3A7CVw0+jbPwk31rOmb3QcUXP8EwlmCgrEdFqhnzhdIFZETqXDZC3hf8bExLWqCjortfW+MgbrY3ZhywzpoStWQhkyF+XTaHyeZj2gW/2hnGkjR6Z11R/A0DBSFRAbNgeEOILoK1OoGVV8MDHfajT9bYyc8+OIa78ZtouxKhpqpqP4Q1u3RcRYsc5RwAXEi+bGHq01zryA==
Received: from DM5PR08CA0038.namprd08.prod.outlook.com (2603:10b6:4:60::27) by
 CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.21; Mon, 24 Oct 2022 19:16:09 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::1b) by DM5PR08CA0038.outlook.office365.com
 (2603:10b6:4:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 24 Oct 2022 19:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Mon, 24 Oct 2022 19:16:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 24 Oct
 2022 12:15:57 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 24 Oct
 2022 12:15:56 -0700
Message-ID: <743ad0e5-6936-9287-d093-2ce1c2a3e32d@nvidia.com>
Date:   Mon, 24 Oct 2022 12:15:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v11 0/9] Userspace P2PDMA with O_DIRECT NVMe devices
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        "Jason Ekstrand" <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Martin Oliveira" <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Stephen Bates" <sbates@raithlin.com>, <viro@zeniv.linux.org.uk>
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221024150320.GA26731@lst.de>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221024150320.GA26731@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT068:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a06d9f-ab78-4ebf-82ef-08dab5f434e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLKsnIim759zFaUk9UGIFahRAASYeyVKOHj6HewX6jWkfIZpeeucfUW7GFxB2X+KQR4/Kuk3ObvE87Me9a1PaNlx7BdDuvNfNWSCzQut6Zh/pDKlApdAKhsJzXtH0tDnnOE135sWKHZKdtanJChJmD/r+RGchJbYSxW4p8yTJ1ud53nBtOX93yWbKjRoEAJVFGQrSxOlazobWT/5pYq4jW6viZ0MrF8+PEF3cLmpSCGmTng0XvZh9pHiMhBkQRWq9E2pmnCMW7XbxxXpmARErrsxLCvKcQiBY/YuPcuEc7sTFRDiW0b9+yqxxKD53TxRR1RhsZfHKGgs5t+vE38k1Sdamc09kEsywN18PoM27Yk5gGD6Fz6rfL1EQCLaX8sqahkyvuLLhpcQ7MBBmD4HXWZO8S9HTg2mGS4BXEKl8vRJLdaZb3lM6i8nbF9Vgaif3Oa/Dydv2114KflgUbUS6U69ghS/LLVX/esVk18pA9JBi+xZ2xJhEB7D6Pl/UeNP+PrSQZBA/+J+q+bWmAdSnelfR0OWxYS4nGmdgnWpoJHMI4C64tK342Tx01S5I7E+nTg/+AWbiJvdmqNZizLSE3ZCTvgiqPCcWRxjYs+wrhfjX4r8c65Wa5R8TubHZdWT+F85wobNSJNnSliY3zD5A5CfDOqS9sY1Y1dYfz2njzTYXnjyesgq2tlYxa3/61oGMigbqN1vsiPv2lF7/R7JDarCISrm1n5ysTorUCMVrgltT333p1ofgtMAdr3SugSWJpSpSJkmnGLUO2qSHW//1flZyvqbNtneHF1LJI8CVnwVhcT8sjci2KN/pWdIuVkFA641xMgnZSIKs0w76ZBwVeL8dH86c4HDkAMgPiUi2S+rYwatwSZQw+HXH5ObQm+//GRFtQFtg5iFVRpbfiJMbD6YqgUDRZ0HnvgARa/TYlc=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(31686004)(66899015)(356005)(36860700001)(41300700001)(16526019)(82310400005)(47076005)(478600001)(8676002)(86362001)(7636003)(966005)(82740400003)(31696002)(83380400001)(8936002)(5660300002)(186003)(2906002)(40460700003)(53546011)(336012)(2616005)(70206006)(70586007)(4326008)(7416002)(4744005)(426003)(40480700001)(316002)(16576012)(26005)(54906003)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 19:16:08.8953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a06d9f-ab78-4ebf-82ef-08dab5f434e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/24/22 08:03, Christoph Hellwig wrote:
> The series looks good to me know. How do we want to handle it?  I think
> we need a special branch somewhere (maybe in the block or mm trees?)
> so that we can base the other iov_iter work from John on it.  Also
> Al has a whole bunch of iov_iter changes that we probably want on
> the same branch as well, although some of those (READ vs WRITE fixups)
> look like 6.1 material to me.
> 

A little earlier, Jens graciously offered [1] to provide a topic branch,
such as:

     for-6.2/block-gup [2]

(I've moved the name forward from 6.1 to 6.2, because that discussion
was 7 weeks ago.)


[1] https://lore.kernel.org/ae675a01-90e6-4af1-6c43-660b3a6c7b72@kernel.dk
[2] https://lore.kernel.org/55a2d67f-9a12-9fe6-d73b-8c3f5eb36f31@kernel.dk

thanks,
-- 
John Hubbard
NVIDIA
