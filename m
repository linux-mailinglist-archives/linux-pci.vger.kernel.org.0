Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E512F737225
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 18:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjFTQzx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjFTQzw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 12:55:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256F391;
        Tue, 20 Jun 2023 09:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlTR129qmn1LQNMXQ3wxklTbJH43byKHbelp/Z9Ey1gFnsmVtzAMWEdijJH6d6FGJYBC8wIw+KjFFxJtG3er/QeLjIhdY7FA6Bnuw9rOczfNL52u5ISCTL5tFpo8PiTvO6AtHqEgaSMK+XHeZ4QpXe9bY2wF0j4zdYhXm8+sgpwF1ek94CaBa5EIAGpK5XDM6pYfCDnchV9qakFChDpM7gE+HqR7/Ay317+1jmFHOMQCcCSOsy7VUFZUENEgEKdnaE1yfIRfRCFDccqGYKEPI719kQXwt2VS6j25orefbzrbeoXlLUPmHl3POjAAI4lkW7tLz4u/nGXO6pO/GjgSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Fwfg170SNKMwBnMcPZ5kwhpn4TN5a4rHik3TKZaJzw=;
 b=jM9GhwFj4qchuq6dejXr9rD5IWsdNJ5ic/UIw/f0UaJgBY9PX/llICNoAqjGu/KQvbg0SzcXDYiW56rEf4GQfY/eXvmGsUdZi2dnxSpf8HjhfCkXS/VUu+pfIWEdi+SMNdUBnZXA9HJS/o9FI/sywvBJRDZWf+c5hS2wC8d1hKxbI7BnP5uuduHMydu5/Kdf3ZFyrRlkpoxNY/7p1QmC5UrZxmqkKdR/ijkaD6XGWRYGDPNIGoI0QjBjS4tZPSUthRHfAHQSF0ddikfqZ9sQEKvC+d+H7rL7ozgZ8qUXKNhBkfvQ0YCQv9LbKblJsA8wdJ8iaqiNpAXGN8XA+UZLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Fwfg170SNKMwBnMcPZ5kwhpn4TN5a4rHik3TKZaJzw=;
 b=E8jlSn1CCKQyY2tqH+rOKZWjogSnIVOyv1rtdVQoOu7mUOpus/D8AtpVusx5DNrfc7pIRWzbBQL6pQDzgs4Pj//iarSunCuuJy3+yiX2ayOy29UmCiG9yhJ9YImWbdBZ6+3zk9b3bat9h8qJjuVY4tnr1aA+Y77ImQAyWuIYMv0p0Ec8g+Fae8mpjSXBtmcGtBr3AjrxwilZbbE4SOn2+ljIvxAlydk1h1cMF7/QiMHXPsFb2t/9do+coN06vM0+tvutVA1lwYwH+GaM32X8yEaonYmQYZ1+lqbQrMKsr+NoVeEnNvXzuJqgCGMZ+3+gJvq5WO3eHiscRRb7PKRdZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 16:55:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 16:55:48 +0000
Date:   Tue, 20 Jun 2023 13:55:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
Message-ID: <ZJHaE2+XOgQj1q2k@nvidia.com>
References: <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com>
 <ZIiRK2Dzl2/9Jqle@ziepe.ca>
 <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZIxTmGU4a5dniEY3@nvidia.com>
 <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
 <520e2be4-726f-c680-c010-a308cdddbae0@arm.com>
 <ZIyxFpzh3WG+ifws@nvidia.com>
 <90823b33-1f44-8789-9a38-282407fd9f15@arm.com>
 <ZJBf5DP60prFH5R2@nvidia.com>
 <CAKgT0UccM=_D-gJdzjqeUmRZWnSHVaUABjgQBEamLYauE8WTCA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UccM=_D-gJdzjqeUmRZWnSHVaUABjgQBEamLYauE8WTCA@mail.gmail.com>
X-ClientProxiedBy: CH0PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:610:cc::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: d1447e5a-0b32-46f1-6f40-08db71af328f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsDc7TBZwzm8Wy4EH9T/zgJllxAla5ykRuYjkxczRfEUI9V3aYLtrtD5A2rgqcP2QB2D1lWlX5urr5fdeGWmpAB+N8kzFI+8zPOGihTXhos6hFTRlExa/+Ry5rPnyxjbT1KxVLsA8sHYPpuMT890zNXaAXitRhNuKd654KkPiQEz2aq5lDxyv2peovC6e6V8KXARKkoyXgfbaTemmbSl174lezRXVXK65nkXJfXQqbjmiDmS2h3yBeuaxGZVnkKih5mK/73k/iyFVEywQAr/U2hVnGl2TruVzgWVB9krxTnGSpvbn90qin7uldBRce5gxyYCQPUdBxG5bujMg42hGkoObcDgd/rIA+lLiFY9GugWaekNbtUPz/HCN6fVPc4QQbrwO5UR6lZ4LoPEEIGYvC7q0FBhJYX4411oelDbv1gkCEtvfDqJyMo36IuiCd+aPifdgkmHvSunMzukV22tlI/sE6v871NgMeflViTUbWrbUPDQGXRIVCD+/4mtgJ9rRK8zuWuKHN4PX4GszOP8NTyyidl40htoJRIcL6EIhoZebkHk4QcRMT9rU6vtxI6zwGV5VXDxd7jkmAfqzR7tCX10aijgmGBcSLX6dpiGaNo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(36756003)(5660300002)(66476007)(6916009)(86362001)(8936002)(8676002)(41300700001)(66556008)(4326008)(38100700002)(316002)(66946007)(6486002)(6512007)(26005)(6506007)(186003)(4744005)(2906002)(2616005)(478600001)(83380400001)(54906003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fWu9HNs0cKirJtu13Ak5fE1RNO8x+3+mftJjCV1gUoaodetxIPxFzMYcK3B8?=
 =?us-ascii?Q?a5YwRQ6ldzzQ4J6xjMSJ8s6D764Eiw7EbOLT21/eXSfB81rLEZkYJHXawMyk?=
 =?us-ascii?Q?8yVSu/iU+bFgwRHwY3+oTsrpVS9yPchIsWk+76WcmC1A66CeEvXdI/pHiVI/?=
 =?us-ascii?Q?zj4uEnQYkkwgeWTZEzgwMWHNPuP4gxwJBZDmjmorc/F1vuwQYsVI87xOD99s?=
 =?us-ascii?Q?UR2kZX/vTMzJ8Glbu6l7og+/JAtS49ixpxuns14KYv33Yg3cgDvcL2EZ9sEO?=
 =?us-ascii?Q?ZpAo0xD8suWO3V3kFZC67nq3xlCMINz5oxY9V229uv7QOnjGL0++JB8Y3/ZZ?=
 =?us-ascii?Q?BAd3MPUsxB/MLrlbp5pXa9l/09Dw2fOUP7j6s3YxqkagsdK6NNHWmwa7eegP?=
 =?us-ascii?Q?HJuXSpYSsxejP1SAebFAKQjfbWQoyviXJcTIIXMl0al1JhPvI+6YU8WP4MNA?=
 =?us-ascii?Q?YPX5GX6V/NIXU8FV/ZHIz/TDeuUTR/PGt8Gp37N+TnF2/UTGUeU8Eq8nSHJQ?=
 =?us-ascii?Q?JSlChAor41TXBCJtlTtaSWCb04fLshLUieT54lRMDZVpQpBRKbeLe3Gf1zcX?=
 =?us-ascii?Q?p4eY79rV0Rcka494bSwOb2+I1jbyQsmgy6JgYjhcIzq7mtwTqMWL0LtL8qsw?=
 =?us-ascii?Q?CmAFqMLURp599jsK/P9e7MESlroNpsGrnlyRUbFJP0GyumM6v9bJFuZ/esU5?=
 =?us-ascii?Q?QYHnaJmaFw1RGaIykz0rA7eePTDQfWbE923SbU8VWl0v1aeYae/yUs83ujVU?=
 =?us-ascii?Q?PGU2cOfUchjHRNLjkONYFN6Jk3neJInjAA9v0EARO+egAmm5UIiQXRDqqtsI?=
 =?us-ascii?Q?5vwK96MrkoIxDQjdGYMuGDn+tz3Qg8ovXnvmMnREW8Gpd/BZTik1bk70Z98f?=
 =?us-ascii?Q?VgPl889FPqBwdqhf8uB+SWDqSXQnZg92v5ieqcacxycaYWtx8+7Yz2eMn+Hu?=
 =?us-ascii?Q?2kq3gCRbPnfPOyHI1f0mXo4K34qxif1GLOnGvHiinjjN/LmwrVLQmHT+AUSj?=
 =?us-ascii?Q?hR8a8PCbYYCXK5l+YBlLwVO7bZVAbeapsaKS3SEo9QtuTq5+N8PEP/txh3MB?=
 =?us-ascii?Q?t1zC4+WKMyCimtgCj0bg24rSb9DjQGGgmamuU+H4+z6/dc7+OGz1fuPSZ7KT?=
 =?us-ascii?Q?VdN1V7Cc405kHBKXsjIAApw9iwgRGenGEChcV5405b1mR8yodOH3BM4PiMKx?=
 =?us-ascii?Q?H8Gn+VBhHJQtg213Xgf4uao0rAOKe5lQ9cj8sHV8H7VtLy++nGAckgWPfwoA?=
 =?us-ascii?Q?kqckcGclAq3teTEqLn9YpxN4fKm0YZessMy0wF1SBwEqBV2XEGq2Fcp2mtb9?=
 =?us-ascii?Q?RYGmTBqBGoUhXXet5bJ4yQFzMbXVIjv4VJTZ5zGGxRoNuwfrsgRxlJ2MmUSW?=
 =?us-ascii?Q?K0XigGMrLfbDWVhoI0M2xsTyZBJNzVZVhvGmoocD9lxGG3cECVyu4DM5111M?=
 =?us-ascii?Q?fzzxQQE70PTGjdDLe244gsfN+FnQM7l+a+AeAwbKk1wCxibRODeWOBkP16j2?=
 =?us-ascii?Q?cdk2bZ+SiOC/kKK3QVKcRgxZSQbqOv5TBJkd7kAUA1P1jU6oo6880DhmyhTH?=
 =?us-ascii?Q?hUi5fUWov/dFk8Wreu/wsxWHnYYkh98wILUVnkDN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1447e5a-0b32-46f1-6f40-08db71af328f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 16:55:48.6129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sl8nYGIWstL9k2HxrEi03LwQlfrGsGU0Yrg5XpboMTfLXWRtWj2ytoQo5Arp5czi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 20, 2023 at 07:57:57AM -0700, Alexander Duyck wrote:

> I think this may have gone off down a rathole as my original question
> wasn't anything about adding extra reserved regions. It was about
> exposing what the IOVA is already reserving so it could be user
> visible.

Your question points out that dma-iommu.c uses a different set of
reserved regions than everything else, and its set is closer to
functionally correct.

IMHO the resolution to what you are talking about is not to add more
debugging to dma-iommu but to make the set of reserved regions
consistently correct for everyone, which will make them viewable in
sysfs.

Jason
