Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0607667258
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 13:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjALMij (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 07:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjALMig (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 07:38:36 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC6B49167;
        Thu, 12 Jan 2023 04:38:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ks6ab+Qs04fBsYjcOtNrmK09OsiKsurzPmnB473TJzhJhhK06jRrmYlFG00OPftR8h05Vn4offwf2hClvFtJRU3Xji7P4uyr7Z9jjtWAKAz9mwi1vZTub/GfSTQCpU8fsLSVI5BQjVMSOrVA5UTD6N99UBYPetd9Uk+EkB5r9o+yW5fr7efwW83FSzRpJHF8q5CYatEKDbUZrJh5h4ADnMcHuDPJDcIA5IFLTa/F3bDVIYAHD1Kq/RzQshCmW1FPtmwrdr9Pv2OcqFNsspVXj+mfN647sEbzVGITb8RWksB3cndStLM5LJepLvwx7Ake7pjFOnytHghwff6HNYaXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPbMNpYJ1Dkfv4g3OwIgT87bnkTMtrMGWyhHb5+/oJM=;
 b=Vcr190PojWMYihFSv4aKA05YqcCuSzU2TIu6zi+x+G2ZE+hwZlv5/qzQZiGMUsS99l3BIeD3uLiP7or2B1ldrs2GrJ9PSqHhDN9NGzVDXWeznq5axE8fqKI3KaDTOchkL+4zYH8RvVlcyxNDBT2AAg7sSjzrEhFfBs467tuTGgKPycXhJJEafreyOddhGPyuWPRP63E/MZ34rWTQVolfhswMEGkwlirYyW7HouUxZ31MEoM/HN6xwgaCRpY/TwlulOfTMtItJ2Js3g2M4IKot89RNT5Njx/4cMwn5VWKd2Z/icJG7qj7S/LYzG1AIjn6MXp0/9XyWS20WZ8Lt72dBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPbMNpYJ1Dkfv4g3OwIgT87bnkTMtrMGWyhHb5+/oJM=;
 b=cAa/VKIFUQYZ7FPxA0Jx2NftEo4JhmN+N+SZKJANDZp/jcmDrZwCdQE3EnuSK37RxRLjqhmb+c5xS622VktwHWB/jt4aRUP+wVH1A4CABQliUgHP6/H55SXcDN5/PxhdpRPJJF3KlEmhcgX5vqqjNSW4kY81ZdURVwjT5uUqUs0w1exysbtRuWJvgLss3Z/Ec4VRAKJNN9lWGyHT2OIAfmOXSnHnTMbbkSc86G7A2roq2I+6u8lQ0J3CWeMpnJ9FOozfvjkmUpFBSIC6czcJTRYvQaIr+ezKmOCdT1DIXY27N3skOQf+k70hsHOOQPJWDTcLmQqQWokMxi7hkTGe5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 12:38:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 12:38:33 +0000
Date:   Thu, 12 Jan 2023 08:38:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matt Fagnani <matt.fagnani@bell.net>
Subject: Re: [PATCH 1/1] PCI: Add translated request only opt-in for
 pci_enable_pasid()
Message-ID: <Y7//SDtnfXGHfior@nvidia.com>
References: <20230112084629.737653-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112084629.737653-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:208:32a::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: aa25338e-846e-4f4d-688d-08daf499eaeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OjabO9q1YIy17EOQkyKfCp7N1g0Gqtxnred0CpiLL2CK/4MKJeL3yculPVgAvPAapOFB+jf5XW6WJwRfeI3iqcWk/5ftKRhAQXk7ojLs3AvKAv95U7pgVgEfN3RgHXJ20mJYqI5EIna59KTc2/unUHDXOT5puEAY46oCAIBfnfqSg0BzOBP30X0oWllS+L+hniiWfJ5bUV4Fu2GNf6/ghtAAOMZv+QZRnpobyoRasHOs8D6l0CFKOAcxSWVuN3LqcjY5BeAUn8SekEkOk6YeUzSvTwFUqV+kG3UyjeQG9Z7DuioLxX9Gz6uldfvLAP+8creQ2nED6ArVQ1eI3WiZ/c69gsExcP504/0xrP/wGAJtDuBZBPcKpLNSo0Rpz9RaAfkIBTDTtvPM6LybnBF91lpsflmqjr9TI5O1K9S0LaEWAJDWuRVNZj2Cto4DiNNBKnc+AHr26Q2JAGQsbtHcSKYJLhYblrZwFYd1YTy0PWaVCzgwIXo/vL3qSOeC6xOjepBOKHAGrSr0y5H3Q1IjHYbHA0YQHt2FJhngSl+70u7vdplq5gQ2VnjGVfoLihCX03L3QanbD06ERA7daAfvWInzNUBdfIZm33u5mVRSqki01sx88Jm+QwSqBmlHySK+VRbz1go9N9dF1dJ/bP1iTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199015)(4326008)(6486002)(41300700001)(478600001)(38100700002)(54906003)(2616005)(316002)(26005)(66946007)(186003)(86362001)(8676002)(66476007)(36756003)(5660300002)(6916009)(6506007)(7416002)(2906002)(83380400001)(4744005)(66556008)(6512007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LGZ0YqmmNkoiIibvLseVvMyPQGhY6EsFhNkztmAO2l/WfC5xVFsXLd9obwrt?=
 =?us-ascii?Q?QvF19fdm4ikmOHu3IFDn1TAbjsG04HTRmUgVo8WHL8TGQe0r9WmKizTL5ySp?=
 =?us-ascii?Q?QrRNYXkAJLy81flecdwlWn+TVlJU5FLIPwn3EvAQ9sd1o85LSs6+2ssSIZEj?=
 =?us-ascii?Q?XHnTKfvpdJplbB93SfwmjhyvNtN4Mke0fhS38hA52S1LmW6y9FjajEaaTKwK?=
 =?us-ascii?Q?ozNzJ95Z7hQRn3crH67NsVDS776bVkXGdYi0Sf/+oDdc4Ywo6UbD8IKbrKq0?=
 =?us-ascii?Q?Hh9ti2Q6Yjfc4TAxOjD8VXJKBN5LcBG02FvHKWghzHri0nWh0nuNOABTbQEO?=
 =?us-ascii?Q?3THk8NVjSW8SCFJOMW/T7SZToAp+4SQYN4jmrCbm5TW3DqI+nka1uvIJGzlz?=
 =?us-ascii?Q?10Z91DoSlL3j7qmKfKPwSRQHhE5Elkws95zlH25purqxmISsks0U3DHH0GtC?=
 =?us-ascii?Q?gwIW0Q2nweAB1g6sgStOGKh4K5/KE9R75FnWo7hq0tgNmEFEebCMLVJNUX7u?=
 =?us-ascii?Q?aGNPg3EJgQwKgd/92v82wS+Gi4W3SUhOsk809Um2iyoEyW4oGjWK20svzU7I?=
 =?us-ascii?Q?dpMLqteSXS/SCY3k1xf2A/NDEemB6PfaSf3bVOrVf1dGBwS5WN18FvlcXywD?=
 =?us-ascii?Q?xybB/Mra0a2sWuR3YDIUu+cwxJPZ0yhymE3hkWVQkZjf0VqrbEVB2cK6SNdH?=
 =?us-ascii?Q?dpx/K0x8wHCrzBFqeVM4grHuvsxymeUOcE3UTJqrUk6whNbctDg9va9Ucq+A?=
 =?us-ascii?Q?0cQYGFR2x27uE/ZpcF0HFJltTiwfxXK6HWO1o6MMB7NgLM5EqrlXGRdtsKmM?=
 =?us-ascii?Q?JTNe23gYnXLewV1eczcaCLXGAjbV+ghSQOdqA5DW5i7xK5wfIcMADyTR6Yo7?=
 =?us-ascii?Q?oa0VCGL9GKNemLp+B9+bqBxi8L+bKb9lrkligbJtpq0XC5LXESZwcXdQfH0R?=
 =?us-ascii?Q?oUOKH4yo3a6EDIhofx96BP29l/M7ON98D0G7PV76lTY2Ni5uWLhRV2Js4kbg?=
 =?us-ascii?Q?Z58KMRwOVOLG4n1b/J0BewKI8vYIbJ4dGtVc0XYnKz25gn5xm5ldJxzB3/P/?=
 =?us-ascii?Q?34GvxAsbc1smQvnSO4QG8oxvAtvSGb6btYxv57c57EwnSg/5gVodaByaAkWq?=
 =?us-ascii?Q?Cy+bsUBAThq4RlsnLveZX8Lq/GBiXTusOU4Ob4D6H7U/5vZXlCg5CYuVBKUu?=
 =?us-ascii?Q?GiDXiw8YsoYxJgvDUA59aU9wYkw5Brd0rn+S0d0NyxCQ05XLpp4qKhR4epXl?=
 =?us-ascii?Q?1yRky7lCL1et9P49flwNakpDaOYGS5SzMi7iycHUfCnWlfU1RQxto7VI2xwB?=
 =?us-ascii?Q?QoyEC+2xila6ct+qOE/5HF/ued6hb/RbTuohqGMHis8ao9v9coYAq0dC7fYX?=
 =?us-ascii?Q?t9SpLEFCcaBKgQQ3asOYwZZIgP68v69EccGLmf71ChIJSe2RXPMOYubjS8mS?=
 =?us-ascii?Q?wLY/cZ+3kuO311FKa+iTr3L6z/1RFS4fC8Orn6GWkc695oJrntrdt78IFNG9?=
 =?us-ascii?Q?TCK2uUfIICsOrpt89Kjax3IwuQbUjjXVJ2Fe8vT2tMV7tjjuWBM9q5M5LYk6?=
 =?us-ascii?Q?MDlr9drK/B8rcoriPacIVJwXLDEmT2/EMjiy8OmK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa25338e-846e-4f4d-688d-08daf499eaeb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 12:38:33.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRdjcNdMpubm3RP8fuR8ma1zfBG6GYwebr2+lHRLx6zrL/yWZtcS3GBFX8AKpSg6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 12, 2023 at 04:46:29PM +0800, Lu Baolu wrote:

> -int pci_enable_pasid(struct pci_dev *pdev, int features);
> +int pci_enable_pasid(struct pci_dev *pdev, int features, bool
> transled_only);

Please use a named flag so we can grep for it..

Discuss in the commit message that this is a temporary step and that
pci_enable_pasid() needs to be moved to the drivers

Jason
