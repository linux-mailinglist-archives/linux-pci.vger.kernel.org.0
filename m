Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59209733851
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245126AbjFPSsj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 14:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjFPSsj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 14:48:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D1A30FB;
        Fri, 16 Jun 2023 11:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvuNx5on5HcAfZ/yJIE83GA+jVsnsb7f4W4/c0s86z292nAHjLj8lDv4U6RgcB3CNOj5mqGpTNLbxWbor1ALVgoWuvBNrUkd2FFXSmSr45SDUTNLQYTKCKxycFMK4TP/WkY2aOR1WnVzKRBKj90Rfi02+6p+PFNr1TPHPz+8AkQefZeHhalm04afsnjritN3D0rRWJeCysHQWkZe5Uymu6ZF4XrqPDoKXWpIUyre3ZJsjAvl0+xyzEGnUoRXDUt6HqScZtHQitKmzgHzi0VngLrkpHfKQ7Ogb6I801egxqDF1RB2LTXwRd0Xx5awp+oZstsUmODiQsH1aQpIb8W/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNlJyaYIOLJyx821FEg5s7yz07k/FQJ//h0jgiMXeIY=;
 b=oMUufT2+SaDyLoqtPFZbUiV/GQhdR+4cAGRJ1MXZSCZkMT0vIMg/c0wp8kQNSPKI61/Uo20KuIJH9HNYEQcBLFOXGW06RO/+6LCHfiqZql8Rm5CCQJGr6IYXqWnYs2TSCI9j2XEl5NGBC11c4DByT9VaiV/51OhAeOv6V1BgDXyGWXQI0zr/TNiZzqZOY4o6TOlB1S7p4fogKNr2xJY3849BxqHW4OfPa9+/5GFGZBdUDZWbeHwplFvBHIuE7FbLqivVMyaZM/6xJNILaeoWiuM1T+aLuEq7Y53PyNAhZIE7ii+LoCBAI4AxNnQflSuuDFljUewFlQnVgSjwVhcgXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNlJyaYIOLJyx821FEg5s7yz07k/FQJ//h0jgiMXeIY=;
 b=SfZxTsZiJVCyRx56UY730ebG9vsZ7skcrTDW7ioxHBM5H6dfPtnv6Ut/FEwEEn10IjUnzsXINoC6TMJcNKsa2m3jSBcy03ogcKuZSdJ4OtmETQAPaGF8Kb+q02kY1IwEqxqoXGax/1KQDCahrvKBB0kzl8r46U6O20Exk/+0ZUVWkekaVYU+vvj7qXV4BNvve7PWwBDKXkv8TJzCmCx6j0CTXlInU+dRykcNaYtx4rEYLKMdJC3U+fH7CF0vmn3dXA5CtIYQYSQjniP6RO/l/vw/aNC3qsg/Wo8u8zaacM2ZPJu5LY5bqW8jkOKPEvM4YUiNoTPzk0Vp6mvYIyauug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 18:48:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 18:48:36 +0000
Date:   Fri, 16 Jun 2023 15:48:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
Message-ID: <ZIyug9KX9VHCxe5i@nvidia.com>
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
 <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com>
 <ZIiRK2Dzl2/9Jqle@ziepe.ca>
 <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZIxTmGU4a5dniEY3@nvidia.com>
 <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
X-ClientProxiedBy: MN2PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:208:234::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 2432cd68-2cbd-4443-767c-08db6e9a4a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwcl0mLTUVo00WJGwjh5AlY5ZhaYII0czirSYwHJgAstOVTTOS66ewbE2LWKJG3wwvZC5dY1KKrvN4cTbLZSxxlFsEJLZIkvfb9g2cq5Hf/JMvEvpRLVyWOVuNVnvbhmJxczXHLE5zYr1laPjfsg/t1qnLI0PpSsADaPnmZWuWkLooO2CJerOfrBBA+2PUl7OYEiWy60geeKpDXk42X4AFcwNlJjqMoBX6b6ubj6aFwEyLxiBCXGCQq9tvye/JPh+1y4qR8Onz22LdysP7fs2YuMl6MeRxciLf+zUEBbviKd9JwBGDxd8JiHJckpAp5s6QOMJm2hL/J/8dm4AC+dr0wqrneF9lSy4LNC4IYDhzQbO3sgMIoLMd9LHKDjyZTDCGcfzPbV3C6UVG09LStM73wPf5O7WsZrhdv42Em3mLvngScBE32fUhMpBit9dxsVDzRhVZcFxJm59goVuUDo+/LaAx5YYtTZxvOF7Kv/WhaqElscnVw7REmWwwgO+LegxsCHXHnpacF2rQG9r5PH4x8RMu2SmWld6RV8qYogXtspzOgVx9AFShFAamhZaqk2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(54906003)(41300700001)(86362001)(66556008)(66946007)(6486002)(6916009)(8936002)(8676002)(66476007)(316002)(36756003)(4326008)(478600001)(6512007)(5660300002)(26005)(83380400001)(186003)(6506007)(4744005)(2906002)(38100700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jKZZ+oYb+Xc1du9QlEmeSxv71DWdp5gtdL0YGrd5rtuo7GpdqpAoi9KUQr10?=
 =?us-ascii?Q?JZtNPCfOvc9MtFugfgBH4qV9eajcUO9gXjW2qtlf2wTq8CMy0kFvkbyFkAXP?=
 =?us-ascii?Q?9jS+xmRqn0rYZ4a/dnJNPEz0NaliE9Vd6cp2OI3Es7ZWZd1lTliu6IHvNbBT?=
 =?us-ascii?Q?1GENaBbKAIFHoXKBx+X3z/g04W6GIR9k3MUOEuWsCqhcA1Q++36MuJbeakAa?=
 =?us-ascii?Q?XnNW/Q3rWQAV/HLmD0Z1QIIICxVxoBfrCLPEaD2BXIpk4uQ8eYrEYH9IVk9K?=
 =?us-ascii?Q?0rdsk6xP/UuKj5janTGy+tArNq0JfcTA8fksTK4JstSQMEERswEJs4ur0YNp?=
 =?us-ascii?Q?CPMe97z7NAr1uJRaALNMJoFNyGJd54eZ2lMr80/3N2f9GnIZxf3E0KgcW6x3?=
 =?us-ascii?Q?p4SfAJWhLNeqOPCFvTrMwB9NwQIGjVWidxC11VCWYecp2m8MZDmw55MhrD/9?=
 =?us-ascii?Q?AWYfaOe9WJsxMRrJbk3ZSsSzonIwqe99RIfIy/wERvw5pI3MtTczpvwrI+f6?=
 =?us-ascii?Q?6o5TvLHLEUQIHZQUEIo9YpCCZW7b8afF5/80mwlHwyAc7e06+VSafqxSNF1n?=
 =?us-ascii?Q?9oVdWG9IoBvd7cHgNo/ip9AsNQNNZF8f6mHzfqGIWdYT2QHyuq4GRdJpYEcw?=
 =?us-ascii?Q?1HzvMhNB27q2ACwwWTC2X04ylLbYX9JgaVzc5d1zTUQtkldHdV6Ja5vAmvXA?=
 =?us-ascii?Q?fVNOH8Q8CoUiYKNIEz2GGfkw12foxbzifIu0Ghydlfy60TmA7DDhyuAj+3sL?=
 =?us-ascii?Q?j7jnmYSk5Yzhz4UdncD/Is5oetW40p2wqRaay/RyG1JHpiVrvOjH/OjP5tw2?=
 =?us-ascii?Q?H5wMu9vDf6QZc7zR7rk2v/LarDOIiFOZIaHzcZPetHXsoAbSi7iJTaWIv8FI?=
 =?us-ascii?Q?yxaMPkT5T3fet64mvaDtF+3vEIcfd0U6/w0p5daF5zLRhZj7UVpbAUY0zrBs?=
 =?us-ascii?Q?zk+NW5ATnOBZue+oXbq+iGrPejhM81GYehYpt3SCJMHLizgOnGVoUU0WVs0V?=
 =?us-ascii?Q?v+LGgl4ql1jhTRd2GCI6gRkb11rKBozQ/QykzNdDPW9+Az0l5a+mQejN6MG1?=
 =?us-ascii?Q?eZnIyp7WXFVjj0DfXqD+3l+ksfy6ZQIzAfp1T1zYlBxiO8Uoj58t+oZQ4I7z?=
 =?us-ascii?Q?3te8Fw+YrbrW/+cA6T2R7ZVuXXBObhpH+itlJcQpLr0KKswfSwshWnYyrxG0?=
 =?us-ascii?Q?ZebIpDH96zC6FgPV5hMiORbfv0H9GQT48YZpO2w3zUkqfZB1LqUTqlFEsIyU?=
 =?us-ascii?Q?J8FLlkkp6vx4mamSzScT5mojVVD23RwbT9BiO8SwQXFUxgLxMxkHjq9t7G0q?=
 =?us-ascii?Q?ySzERXIav2iyU7cBY77vavAgB/6b3IfH14DpKG8w7AcI/opbYtMgcNI/R9KK?=
 =?us-ascii?Q?HQBKhvCZG5YRK1W8AaBdp5GUUFrclidbW8mE69fvBHFXmZvZmNmTarN34ewf?=
 =?us-ascii?Q?nuGgnzaVgE2YlrtoS9mC03aau0UYnsnAO3Pau8Q1YcXMZe3nWyFGTmXD62fq?=
 =?us-ascii?Q?R9wpl3j3lTFFoqqaU3WWpHS9eVlFYgl1SeQcwMtAbdA4t/g6kXXP7xBiDis2?=
 =?us-ascii?Q?n8iRi9xTTTmVb9PLf28=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2432cd68-2cbd-4443-767c-08db6e9a4a8f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 18:48:35.9507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AoBEKZxeyGgxtaPqxZ6lrZ6DSVRJg0XdfVEWuQWTTvYnveN2AUMQxyS9JSNel19
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711
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

On Fri, Jun 16, 2023 at 08:27:21AM -0700, Alexander Duyck wrote:

> > > The problem is that the user may not open all the devices then
> > > currently there is no way for it to know the windows on those
> > > unopened devices.
> > >
> > > Curious why nobody complains about this gap before this thread...
> >
> > Probably because it only matters if you have a real PCIe switch in the
> > system, which is pretty rare.
> 
> So just FYI I am pretty sure we have a partitioned PCIe switch that
> has FW issues.

Yeah, that is pretty common :(

But I think you've touched on a gap in the API.

Jason
