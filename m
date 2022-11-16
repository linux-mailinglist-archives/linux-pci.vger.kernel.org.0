Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6870F62C790
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 19:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiKPSXo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 13:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239133AbiKPSXl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 13:23:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8AC6555;
        Wed, 16 Nov 2022 10:23:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkTW7hxk16iWRzvk5/Fz+OPkzFL+shs7yUnUgNEz/KanuQIm2PAHIe9OPxjd6Y0BTuyyDh9/PAeHYp2Dv1HohHYrvRwxI1qeSu2/mjohwP5X2HNW18qt3rpIzv1ZzkJR9gJTVCiusLuyDvt4Gd1rmkJJtD0cOhvu5AI2R9QtTSgxdRBR1Ey0rWbf4r0ApHrvTBJYnVrzd804lOFKc2rPP6te3SgzTZau5aS7e+JaSioPT72q4cFk3XI5FpU39dErqjg9bm2vVuXLU3LjHyTuZFh1oHBWld1SgnPdHFkyoQcb7qAb9wT/esab9Zx1BJSgarXGN+VtSKT0VrPTJ1bcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/RKzD91F60GeJQxCjxwF17exEKTRKeYW02xorSNxpQ=;
 b=IFUJ4ZK7SJzq+I7hyOuHwezS09KLo3NO7Th3LJtsZzmchtd4lDSFbMGeL1FOQ0hDC3qlCaCcniV6DMEcXFJzn8Na6aGvuCL3LhMYaFWqlyvwkOpSo8dPCOWN+gKuH1A7BGDKqMYQoTxWDMVDp/ccAzaR+jucVilCUX/BC91CHi74ckqGMN5gVQCXRYxrDzMvJuRh4Q/ZkcT6ZxI46aBfmUURRLplM/cXmBLxIQKuihIDf0x+sQlFV3YIpSszIZYgThk75H0U0RLn5jWE/L+OYA+kzP5nv75tPJnScpiAqUW8a2HaxnoQq1NOy0aHUEUchrJ9gBxEdh/zM8VBei18vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/RKzD91F60GeJQxCjxwF17exEKTRKeYW02xorSNxpQ=;
 b=LDBvQ5HwDXeo/lNKDVkD3QZSps9ujGzyW9QGi3Wap0AuXUtpKGZ8J5k7TAMS9ejuvs1CBNkQLsVdFLo+agVTsiDkfWnyJh3z/1hVSK05zIJJT4+ampCsB4K96pyHnGbqrbGHPF1yEeeiTgPC9YRsXbhhtIGtX1XrJDQ1JdD8m1Su7uabkEv/8fq32vLAOpbTq7mV+GdiJynpcKfh+02/9tJHUqmIy7xOYA3LZtoHPkDDHBw/ZOUrAvrs/zgbdGELjaJyup6JSo8HZ002ZzwU1z34bXsAQY6HATWHiVaSRFQIU0ixh3sO6BCv1q+TqzQ2vKbgAnjmW4vdOuQBRybIGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 18:23:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 18:23:37 +0000
Date:   Wed, 16 Nov 2022 14:23:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 03/20] genirq/msi: Create msi_api.h
Message-ID: <Y3Uqp1tsjS6WIEqI@nvidia.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.220687198@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111132706.220687198@linutronix.de>
X-ClientProxiedBy: BYAPR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:a03:54::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: b2448685-eab4-4558-bc33-08dac7ffae0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZfIWsLkNbnvkfnQ/YOts1YvMEvDaoOoIRKb/ibDdDYn8a3Hk2l67WLgrirDSB3LukL6hB2rY+31IZV1en6tHAmJNwjNoj2KU02UWSZteBqJ+a/K/eTXFfU78fw0CA71dfuYvd9+UQOnAhFm32NJt/P/EvpaOe09gVaYz4rorYG96uAOxgbdCoPk/2jNkxXDHi0Nc6/VwewbS+w58p+z7VI9ulxNI61hWpR/T282aQtg7BiFtTj9kqQhOlGPF88en89yfIDNL0WPp3INp9tpjdCShd/kKRlI4ZdaXrLXjBonLE5vDDT/eG9MPBpGup0QAKEAGRaBaNVAe+xSEmbrn6xaQozWSePpCe1+G3KqelkSyXvjNUD3vzj18jLJslSdfpUPdjTIt28stDk9e6oxhEiQAw29o7fa48h/bGYwYkjzHTRw7trp5XDmDC7D59EqMB3Vf/UiV2TeEee+zJ1t04vXGiF8fZp2QJVYOih+cbIB92+0920CSzU3xoECNyQf2IXiR5Cn9GVQ4iCN6oyra6xUGyFgpE3/r5Y+71IaaCzUripmP3X/XHNgSyiDDeTEf6kNdpckXE/HcZcNvouAT9qOFv0Mn7Gp4n5xFTsogk1iCxPg4JKNHlXUHw+Ktkpmj8QRTDRcH45XIXuvMt6jzv5e2V7z16jWlxdQIW0XAP2KktgTTAKVdVH4z5sjhTio8LD6y44BlhhTuuY0pBEKYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199015)(83380400001)(2616005)(186003)(54906003)(8936002)(2906002)(38100700002)(7416002)(4744005)(6486002)(5660300002)(478600001)(6506007)(41300700001)(6512007)(66556008)(66946007)(4326008)(66476007)(26005)(8676002)(6916009)(316002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/AOhXeL1/HW58mRV83DmdiRoD9w1AQirCHwAjrWP0abuL3trCnueDnqWe5F?=
 =?us-ascii?Q?UB7r4+InK6QdOGOkqqVyrORLnvyYzZ4fz3uiTzPpEthx7B6wXt133xMVTbee?=
 =?us-ascii?Q?XQbexlYvhswFJtl7D43xXf7nWHP+G7DvTL9daIq0D30T1KXx8ojggZvyD4ff?=
 =?us-ascii?Q?9JVxdpdVIwLsKT3jjXY1xEmSKvBK1dLqrCSaXWTW0hzc/R/nQU4uW7Y5UULX?=
 =?us-ascii?Q?XoAUrP8YjjUX3Q1Urg8Uq3ck9zAi8lgTsE0ONNozkP72OyPM9CEnSWH5Baqn?=
 =?us-ascii?Q?KYapuMyMgWU4GYs63yKMMUbASn7jpIfFc5bcBnIX4H3oLEA4H4leDdS59tHC?=
 =?us-ascii?Q?v6TDuoJqVMGwpNTy6wFVrUzjR/Cr73papRjCfgLG7w+RljyK1PYONA7kD2/R?=
 =?us-ascii?Q?FsfZ5TcPaimTYQ+WWst3y0ypW+dIuNgPvS9BKXmTvq4JEs0egTCzxe7WKzpc?=
 =?us-ascii?Q?HWZX0LFpD1dJzuY8BL6ocl2d27+9cYlZPMmpuzR3V8yrPwgtIL+lPC4lGT81?=
 =?us-ascii?Q?RwPTHCU+l9TzGdZmdQ3EpKfZzb9gIpLazZnxuNxqknR6gTY6yxqOrpeGszPv?=
 =?us-ascii?Q?pDhEG7Q9qCO61VM5LiyCs3qANShtdZT5ZbiAvsi4gau2Y5y9HfVgzviF51vH?=
 =?us-ascii?Q?SAabZXmMZ3uQe9kaxYKAXL7JcsMgmuYcE1GHp2hbrx6mQxZhi1bRYu2rH1wx?=
 =?us-ascii?Q?VK/ieHTT0WpMTiq8uVcAcJTsnaOT4i6BJeOkFFXtip/v8a/0pJoq50vjeyH8?=
 =?us-ascii?Q?RT+5ZY++XF9VRPb0VOGri1Qj6NPJiaI702RzrWFVl9B7HfjwNlWSOpvctCJq?=
 =?us-ascii?Q?ww0uYXHVHlqK7pDr8hP5UEDMNZM4iSWjQ6Vij4A3FvV0fBplEhtDqg5Vean2?=
 =?us-ascii?Q?D7RepLbHUWu55VgcZKd4eJelzOoHw8nabhUqExfoPLjADjPNspKVEKP8qq1g?=
 =?us-ascii?Q?YMCfNnkZrge747fLWgUpmY9kA8hsC9MwDygW/hKOIyCvTzgm7boL1oukX72R?=
 =?us-ascii?Q?Pip+T01+7LkuPQD4sIuNUVL5HnJQcmpNACuVxKHJ/FFw81T1CUE6u72yN20x?=
 =?us-ascii?Q?IlYGgZLhF/xGfl/Xt+QCCW8va11dPlqnwzaC7lNFC+WGYAj5xks262QNnQCu?=
 =?us-ascii?Q?GWd1U91ZWVWPh0ZfeOzjoWiFvlUDfwQi98tboc1KzJur3jmjZPKN4SCEuYBs?=
 =?us-ascii?Q?spuVRlOgpqlQ68uuDLe3d2+nmFxDuFKSI/18tIcTdf9tM2JD8KQLQKMa/TV6?=
 =?us-ascii?Q?gx5U7sVQVQgvRCPGZlfIEJ1S1nuSmPRX5Bmgj5n3cM0f+yhJMeI+pYcv4xcr?=
 =?us-ascii?Q?dltGpEvnmbgE2R1IpOjFu//NJhfi/rw55ufQGVmrPw6tXewmR90vaqWjOmZD?=
 =?us-ascii?Q?gGa0G0qYKfmCv4OmT8PkFO2dHdKk2wD0VQ4WBhaTpW/e8G5HsubqYyOpuQ+v?=
 =?us-ascii?Q?xfKNo7UQdlFwaWMNVaZrV1YcfsDwvp5opQuK2Ic6BD8MgZbMZQLZRGRRUEip?=
 =?us-ascii?Q?WDzjxtQ2zWTi2oN0c+q1Sc1VOh5rEX5Vk556S/8DknQl/3UFiZoEwaYbBUib?=
 =?us-ascii?Q?70JqvSEP6fJL4ThlQ95JcW99yLNSIGub6L+jipuQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2448685-eab4-4558-bc33-08dac7ffae0b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 18:23:37.8657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSSaDzAxAl8CvAWdru9GeMr1ZCgSnah5IDvUW7Q7zKiOeAMQ2Ba0ZeDqHPZpchW1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:56:42PM +0100, Thomas Gleixner wrote:
> Create a API header for MSI specific functions which are relevant to device
> drivers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/msi.h     |    6 ++++--
>  include/linux/msi_api.h |   15 +++++++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
