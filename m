Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC2F685D62
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 03:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjBACgb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 21:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBACga (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 21:36:30 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E142B14EA9;
        Tue, 31 Jan 2023 18:36:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcwAg3xNUBDi1YwTMnAl9inwDGqN1pZWtrFoI4wbcebvDRNH2D1TSgBRy8i8r/lwYsULRu9e2GbnoPr6ps8YIUtClh/ivNs4Vy2zqC2zyHmYKrFQB0rNu3jN/r8dqM8oBEyKup5YX2VgOZqDRGzA9m9L5Nkh+tLffG6TGwY8pf2fYa8xYamakQwRr2X0gvAXZoz8aC/fvyTSIl4ULHZ4mxfVymv2RCy2E0mkqfTNBs5gWqmVrFp6rvHqKndgl5i+bLToLxfASDVpm3ngDUgCXTJsYVYGI9LP4sG5OPQUAMiOM8fUa9Pp9wYJfDjsXjt641LJGg+PQVkr5L+akpclLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyRBbP0pvMcwe0sMKpeRRCK2bun6Qmlz+MOPJKA0Pg8=;
 b=BLVF8RE67i0iXKJSdd4xLLLNcN4m53JiYQSd+nvJbKaJJQJZ3G+5+GrzxDNbn5m5jOlnJPgU+CxaalF9p/iiCDjkpdS9hcNNvVkCqIHNdiInm98gVfu95VhvIUkLsH32gsbrJMoYlYLzEYg0WyfiHhPNM3qxsV+lEWMeevcRWetPtx8clVXZV0fOphLaNvAfUyo1yDnQvTkjl2C4NCFoSHDTzoFzqrHbkkd4zDaXfp9Q0xofievLflfrMGKhFPXwCbLWiW3t80OupjZtfc9B6BM6AazggtCuSLuYY0svYThCD/e9HPjQ2zwo5DqSXaRWSmzeaWBEogfKjnTYxvXdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyRBbP0pvMcwe0sMKpeRRCK2bun6Qmlz+MOPJKA0Pg8=;
 b=XcvJEGxcclDudpuf6GHqqFFs/KnMk781VZGjYQT77O7Lt3SYChV+/VcvldmMEEX6obDYJmJhoqu12I3YD2UIT1n2XQGgFJGcvsITz7NQXyRN09OWDcyjrtW2fIEdA97N0RafyQu8eeDpb7E8cg+qmZIyIyxitNIYslwnTM/H/Z1abuSY8re6ZHplexC9BE65kTrTv+Xaq4FYP7X+d0afcXlffLSFtajxvxFjNM9jQoJX6XEeRwuCzof3eSGFDPe6e/bgKN32UDwGBhZLE8qm1e9NrPm6mtpgflqukYmykjZKnALSveLBM5T/eaX//7CMxZA8jwANJKXh5pRzTTC13Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 02:36:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 02:36:28 +0000
Date:   Tue, 31 Jan 2023 22:36:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Message-ID: <Y9nQK9P3HOxEeZ4U@nvidia.com>
References: <030e66e0-fb54-b77d-5094-4786684ba97d@linux.intel.com>
 <20230201001419.GA1776086@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201001419.GA1776086@bhelgaas>
X-ClientProxiedBy: MN2PR22CA0030.namprd22.prod.outlook.com
 (2603:10b6:208:238::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 029bf56e-708a-4a27-8804-08db03fd1ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMfde8sv45hUqDTK08aptWHjrGxwLOVDhZvYU+HIQFqZ+MGSxbesjD/9h7NiM+4HBvYLwjfEs/8IEYLxcRG5dJ/X6hnhV6sAJ2oDVhCurbKruW99izKRwdlUkoO4KKXv7hfAEMzf2cDQwlklAMGH+fnoU25FAGSTnZikuxrSdUcp7sWm4EQ2Sl+pQtArbRpchCsMDi9aVsBaK1ZCdrmc7gWujvl3+P/3ChC1ut85Lka5AD5FpwQAc8RSMJxfcK0UT281tBeaSAZafm6oyO+8qsqPXzReMhdxu4Q9YbdIbf75Dy1wYy/8vCGpqk3k6c7J3MJOTAOJaKTzXew8qj0JXbz/NGJPWAVMMAseeupM6VdOu+dl5jWqmkd8ZgVbsi2qDD4oetUyNq1LqV+MvbF5uiw2mAlTVctOfssStE9QJLaY0BzUy7s7Jxx26wBeVQs3HWyVSlOu4ZqXMtuH8wJ8S/kuFz2oOJax1kYLyfwwS4gOn7ZLYCUSd03iN87OQ2mf+VQP8pKQouWYX5tOW1OKQcRq0v71sw3yalMv50BdpjQfhzEy4y6QOYYdUlUD2aoq6q9MV+w3+gsP+R/CfZXx6RwBh0YKF4c/QxZsdvMuqhrvn1skyZwmC70yrPlduxzd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199018)(66556008)(86362001)(38100700002)(54906003)(66476007)(36756003)(5660300002)(316002)(4326008)(6916009)(66946007)(8936002)(8676002)(2906002)(41300700001)(83380400001)(478600001)(6486002)(2616005)(7416002)(26005)(6512007)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RLMlnAYIi5+7CMYEXp8f2WbwBtceZTeWm5OtgjhOvc4GYPGAVTOh+cMkQsp9?=
 =?us-ascii?Q?RFpdvZs90xwb7ll5nGfjCHh3je3EEUF6LJdR3SuKlPVbQ37IE1RKFCgU9V0y?=
 =?us-ascii?Q?5doaQAqjX4oaxaRf75GUDizNd0eS3CAUEEEkcyc/pmECvbQXP5eIS5Byty9z?=
 =?us-ascii?Q?dx40MZviU95xVJ+l6CjZnB7P6bKXCQIegW7RXdrRT6PZt9H8Fk8sinJrAAbK?=
 =?us-ascii?Q?WmLF1N9BxiVY5n7J7/UpQ00IzdEWVC+28Il0IXHGvzgGTaL7G7WSORXDqQXB?=
 =?us-ascii?Q?WNyC0fj+/FkuSoom9ueCNdNsHw4+B4piGD61eQxtCv9WPKNdbhCEA8xgyd4y?=
 =?us-ascii?Q?t/fyHXcDwcQ7cZd6doP7Tb/8e74szqTTbB9F6S8ZDlhh4rcLMGqPGFYb2fOz?=
 =?us-ascii?Q?Z2IoATjJIj6I+Dm+rZX2GjEn8IDMZwrWZrabo9jwyOYB1qM/cjOKJIcYSGy/?=
 =?us-ascii?Q?LECpK++KEpKTVGFU7s0ILGjeJx3+MW5qYhkd2I9pBTagd26YpJnqR8FFTjcx?=
 =?us-ascii?Q?QqUi3aFW/0iSHhTu2UJ0h2myAJEVvbmnKYueHNBNXlXQZ99sPtHjUwC+wzLp?=
 =?us-ascii?Q?FpfemrEqm7KuxNws15+tEuGroMgjTNyJCK2OEwZkWYumWcPBXDOhxkwZwJuS?=
 =?us-ascii?Q?r+62x3KTq+UuNrz6Hy7wAIPUCMAD8g7KpG8PmlEwu0T7FUoBHF0LleahuZoC?=
 =?us-ascii?Q?rD3ZOlW0aHe9NJggdAcQBmqwSMtwSXLLE8jwj26ew7cgHmTNrPBqDAo7vl16?=
 =?us-ascii?Q?qyRYLl74W3K8CyzqZ/FjBxH9wnJKMXH4ll8+sUFB66cmX7UOGAv05wqV4/mj?=
 =?us-ascii?Q?H/1NRHbYUw9HmNuIkX3dASVG4xbMkTokj9YiHelbTZv6NCJbBcZdS+smp1U6?=
 =?us-ascii?Q?KvjcEDf6zdfNWS8IUgdQg62gu06OaiEVW/CuCCn6pUpm/6JVc1wS2Ti6hekX?=
 =?us-ascii?Q?WwsP1TcgLR7dfdbWExMC3OhRfG/8ZlgC+5ANbBOYsk4hRbZUuzshAUWumDhz?=
 =?us-ascii?Q?VO2TSVL61JPpyHHpg+SOXGrRvNDGx8C8jCpEzPIPxF9R5M70oacrKGnzakOY?=
 =?us-ascii?Q?0MX1ZeyTYoWg3A8FdDdvHpkLj2cOALJQAiFBCdjFVL956z9TgCy/W3PESAPN?=
 =?us-ascii?Q?Iogloxhrgf34pwWQwoSQ+PPOXVbBdeY+7IKtZa1GX+f2TEb4OPpQ0R5N6GYb?=
 =?us-ascii?Q?gDBABv6dfEu/kqSwF2d3EPZG6NbqIMN5852mFZ4iUoSA7K4vHBv/fwM8E6Bd?=
 =?us-ascii?Q?Bkje8uG/aOCvcpDtRTqNfgKTc6RcZo1Jv3Bjokhn/RyEAtLJ5Oqc+wdqYKmR?=
 =?us-ascii?Q?/DsOvQtCFclw/F3OCAdPAdMCoj+0c2MQbhy8spx68wGqg/R63mHOn1wq1wFg?=
 =?us-ascii?Q?dMiyRnL5+6pLvAj/BeV86q/pl1VKYmV6Rw9jN6vHE3UhsxvdyzPmiWb58hlU?=
 =?us-ascii?Q?imRQrTiDEiY631Q+di5m8tCRfM+43CBpeGZP7W8Xkfd0z5FpkHW7OH8bwusJ?=
 =?us-ascii?Q?HVd2koadspJxia/eh+98b16MDxsq8cTpVZFrzJQrVLIfHuDsQnKOINwcYMbf?=
 =?us-ascii?Q?R+XqmrDlf5GmA8Ejw5IRiNivBHhMkK4i3u15xciq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029bf56e-708a-4a27-8804-08db03fd1ed8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 02:36:28.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/Ha38uTltMgaHfVNamAMcR8hUPUj9Ob+1WNEDnMZjzwSZB+9tfalFWiuD1G0vDQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 31, 2023 at 06:14:19PM -0600, Bjorn Helgaas wrote:

> > AMD GPU is one of those devices.
> 
> I guess you mean the AMD GPU has ATS, PRI, and PASID Capabilities?
> And furthermore, that the GPU *always* uses Translated addresses with
> PASID?

I'm not versed in the spec lingo, but the GPU issues MemRd/Wrs with
the translated bit set and no PASID header - which is the correct form
for an address that was translated by ATS.

To get to that it issues ATS requests, and only the ATS related
requests will carry the PASID.

ATS related requests always route to the root port, which is why it is
functionally equivalent to ACS RR/UF in these cases.

Translated requests always route where they are supposed to go, even
with P2P and things.

> And this applies even if there is no ACS or ACS doesn't support
> PCI_ACS_RR and PCI_ACS_UF.
> 
> The black screen happens because ... ?

AMD GPU driver bugs blow up if it cannot setup PASID.

> I couldn't figure out the NULL pointer dereference.  I expected it to
> be from a BUG() or similar in report_iommu_fault(), but I don't see
> that.

IIRC it is a buggy error unwind handling in the AMD GPU driver.
 
Jason
