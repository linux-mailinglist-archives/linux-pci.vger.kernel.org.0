Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E085B23C5
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 18:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiIHQls (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 12:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiIHQlr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 12:41:47 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A8DF7571;
        Thu,  8 Sep 2022 09:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmSAZVdYdpOuKLnBGWQGFN8msuGXOUqqDXYvaaaa5a0oRCm0zcIvGtFotuon6lH+Q30eXjkC4DMC+RCsAWVXV+T4ajmudaMfRRkay+sSTxbFVwTxUBSt2jFQkDV8H5piuS15f9ld7m3jb+g67ShLqMJq+648KFMn9x7QgRo+6GXu3cQ6X2ZStBfCEn0phmC2SjNAgxA+of/5yShK/738t2mM1sdGixd29lkCku1aGLXgWSxYU3WnDVW+g0N9EwivnS25cjbo9M8O4FGEGXQ6dXyr6ZJxUnExzXWgJA47qKhvpL8l0FPXsV17f9iyDEmZnYbkgkAmXYW4yqA/ouDhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77J2XpoI9MoQ5XPrsEwzFDFzURRiP1RHX3dcwirxNAo=;
 b=a4buYFb7PdWm5E8o4cqXcEJJ8WciE+3e9oIVweKuTr31Dsb8Ad/GGn1UPQ+a/kvAu2rYUED638A97GqjxapHQZy5bQ3VxIr1WXjGpZsZTJFnKeRiJwf1OaiNVwFIyBO0Rwn6JmxICemSxgepjoYAHuVL17jRmdvwrdoW5Db2Ykc5oVahB91WhZiOkUXwIzAu4jLrilfgvvvmwvKTWRwEDPI9IrG/qZYxYwCOm8cX8pZMQLcP31GSxOg6U++VPQFLX2A0cHhL0Jy9bEaHJi4Tedkvr6nVp+7lgl9Ze3UC5ZKveppBvWBzLycvaUbGcgJNHnz4aYI3/Fdb4tqiOfF4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77J2XpoI9MoQ5XPrsEwzFDFzURRiP1RHX3dcwirxNAo=;
 b=KM5Ckr3VT53FaaIEkuJu00tdBSQ/FSrQGkzgPfEwRsqfdTYSWj3ber6zDY3+kpIO1ZAzrY7l0N+DalZby39hCVeSabGweP31mpBFFNOfUdEX1xdTbVtElr+yh8Z5H+F4JlmOqZcNBS4vj4g4MROyst3Wk6hx9/FMBjjjUKz0gE6qXNL4rwly5kQSllJamfG2nO+DkDcMESSKaZ9++nJJddLDIuHpyAkgb3zXP5taJpqhXLF5zHWDAwNFmRCjQ/2YZHypN7iACsER36pk4uOtnSWyS9hvbbXMvdgCsRGcRhmrejHbiFfGcQBljU0lMYQGr2UaYhC+sqeplrRMvtLazA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 16:41:44 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 16:41:44 +0000
Date:   Thu, 8 Sep 2022 13:41:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 09/13] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <YxobR/brG9VlxPvX@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-10-baolu.lu@linux.intel.com>
 <Yxd2+d/VOjdOgrR2@myrica>
 <682d8922-200d-8c89-7142-83e7b3754b8d@linux.intel.com>
 <YxhqbhMmWLeFS512@myrica>
 <YxjV1y/FF0nCI/WO@nvidia.com>
 <YxoXfCQcD3yC5ppn@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxoXfCQcD3yC5ppn@myrica>
X-ClientProxiedBy: BL0PR01CA0012.prod.exchangelabs.com (2603:10b6:208:71::25)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|SJ0PR12MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4c9828-f1d7-476e-ee8f-08da91b90389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hG+Wou3V3Q8FXDOLBfwnEST4g5CxKjA/5EyNDP4UmaAAg20ZzL8NFvvi74yG1Hl9B6g7YXark9elgyUQeVF2/bGVQiedcUo6hXkqaC63Ejb913yPVb+Utza+yrQvdrpeaojCYhRTGz2td7uiGY04ehAMLm53cQzc1bjdVL0IQUQk1nzTkD/9kAHTgbaLIuzMHD0XMCiaEHFAFcPrpo+kjYd8V/TUgq54DIxUozrgVDUvx8LcYmz/0RPsuMk07W4wEwCcAIiMe98snOEoEJCsuSmE4wuPXqyks9uXmkUGECSlycsuq6yO2FmtxNyhz9DKEjmsM2QmJ/tddBoPUivZz9GtiwfIU2rrVwQMT+wf8ivemI+4qBeXAZBKceQXJmt0cCQax8yKTGWYKYhsM55z8zR5tNoPf3rHghNjKPqskmNpJOgxi8Pl6XdmmK42H6lctI4Q3oeWJ+F7ZaMUHi23yNrg68m9Kd/NtzIqJSFTzBjNYQTL5Y0ZYLFD1nERL0KFtrWLDjadoSVqAzReR12F4/1mxNMYFm7L9ZUDoUlaMzRCFnZyqiRg1O5Hkvec3y+gWJVkGJKfGYvmTPmd751sU19ys0unvJigP0QpyU1HB/IgaPSmtc5pXITIkY9p8eVHOscDPxojwODLJddO5AAsNju950u9onoEGFBjAl83wgeoSjceagwgd+6S5I6R3+IwZwDzrtqNiegmHrxIdyyoGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(38100700002)(2616005)(36756003)(54906003)(6916009)(186003)(316002)(66946007)(6512007)(26005)(478600001)(7416002)(6486002)(66556008)(8676002)(4326008)(66476007)(2906002)(6506007)(86362001)(5660300002)(41300700001)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DHsVugHe0+BtMBQNLWeD4ley8yFxzOv9Gv4P8HyC34eereYDoWFpdg/1odXh?=
 =?us-ascii?Q?W0TqWXvS8nt5V9nVQZFNHcoYshLr1OX4qtaheMCQ96vythXcGD2XsKhtwKeD?=
 =?us-ascii?Q?RtAqhY17kxFsUG2tIoSROn1F4Rh7HlPV9fBW5DFud1fVOgTFvbHaWkYCU0x5?=
 =?us-ascii?Q?ECisT4S7nLosbX2LC8EuCBg959QQupfeH+BWrE/GXQaVa0r19PBXT5Yw/pHb?=
 =?us-ascii?Q?971iHo8Wmk/TG/XWQY+yLYNSrTHua48D9NHrgqaql/lonnbpb1U/wecVxh3Z?=
 =?us-ascii?Q?WgxmdfZHpUa0nxVu8tgKhpDpOurHxyNLAxTXwaNyFkLJLf/NvYau3QehPRzw?=
 =?us-ascii?Q?ecsxERL43yXILhjjqtKB28WxX2RxUqWmBlOJLOZmdK5dvuwtp3utirI6UkRb?=
 =?us-ascii?Q?yk2Y4xWWjqUNdgt3zuL6OGugcxFyXnxAvzYghMuJYByqmz2CuiQMY31dJZkz?=
 =?us-ascii?Q?+Kjt0MmDc1tSea7dNSHg1ArxSFfHzCTu5jo8H97ql77dmE7/Q1/GpJsHZ9Aq?=
 =?us-ascii?Q?rPZHrVPcNl37dzyvXu7Wq2fJ7xepFtqlKRUqgJt4UD8peRgsG44SEEpjNqIs?=
 =?us-ascii?Q?KcWTRJtuFW27AYeqKyjV8DYY4AusHGJRof0wAWyvSNyRbxb+rcxL+O97JgT0?=
 =?us-ascii?Q?9COKrKFJWxfI812GgoQrTmEB+rn/omGSI2Sw0VeBUWBG0pCfhXqzMJaah0e2?=
 =?us-ascii?Q?wSraJYhShyjtbMOVJAaHcXPkOnpCEdpCxKsJS95LrnUPbvRvuptuQanTqnVW?=
 =?us-ascii?Q?PV6C5ZzBvL+yryjCJDmSJK83YS48J+3ScRyxLJL5sUzmYGLjWhGHxbGTrFse?=
 =?us-ascii?Q?GL1AayLEfHJg9NecAQh2sGbQR+1h940hBd1tbAM6k/0btMk1F7S0IxR++0pU?=
 =?us-ascii?Q?+fWjBn8GzY6s2Mt+QOF2n7SdfTh2P8YBcvc5MgrvHtWj6v9K3v8THS8NIFT+?=
 =?us-ascii?Q?SUZKBmk2XX3rDrFDExQexPlW1vxqt4gvYHLUKsPsxI/T9cQOwiMuL0Z2DHW9?=
 =?us-ascii?Q?L3ZcxU6ft+PMVeeOKArpSbB1XNmNw8kOVuUYq5PgVODlfKT6Ao6znPy1w3UP?=
 =?us-ascii?Q?maWF1Nj2aOEheXITlP67+vBXQ0Z9wqysfMsrXrY8sPi7XALyvV+s7dDlxWHk?=
 =?us-ascii?Q?UDTXbLUbQ0WZJzptf9bsxeVgIFvCm3jY80vbdO/5j/nIdqDQOw2im4NcDreX?=
 =?us-ascii?Q?EW8CHPjsM8AaZzJEUUibkfL8xSfoOf/XfMQHq2wpDNwt0sf526Yxxuz49eVQ?=
 =?us-ascii?Q?+S6KwlTgStBryZKRJjA3qcX0Kc/07AB3Fjp8qfpAlgNdfPQutDwfSD0DrFmP?=
 =?us-ascii?Q?23ox75Km51HJk84RFUmY31dBJ79J3ZXXjqCKughYRSHxuVcHRhZqrCIc0yZp?=
 =?us-ascii?Q?WxVbT4b+yMPx83pAVArgX87+mOMjB3B0HRuwkwoGv9W+2CW3vEgaFItoS8yg?=
 =?us-ascii?Q?gu3STeQUALCZ/O+fhVE+KqmtvYnwRNmj8CE9VBwLxdFK7GkxZU/8Nzmx98Of?=
 =?us-ascii?Q?rkyPEK69eoQIfRNbmdDP4fNrqk1y1MGK0r29HJOETAoAwEK7bnTMVwHACMIV?=
 =?us-ascii?Q?sSzqopkifSbWyTFV3msZLiai+6+XcZCVPDvZNmFO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4c9828-f1d7-476e-ee8f-08da91b90389
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 16:41:44.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbyGZ3M/NNxnWa/tumbV75WpaJZNz6ggCrwIyzhyDUeDIXtVaGHruDe9QNv1Oa4s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5469
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 08, 2022 at 05:25:32PM +0100, Jean-Philippe Brucker wrote:
> On Wed, Sep 07, 2022 at 02:33:11PM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 07, 2022 at 10:54:54AM +0100, Jean-Philippe Brucker wrote:
> > 
> > > Is iommu_domain still going to represent both a device context (whole
> > > PASID table) and individual address spaces, or are you planning to move
> > > away from that?  What happens when a driver does:
> > > 
> > >   d1 = iommu_domain_alloc()
> > >   iommu_attach_device(d1)
> > >   d2 = iommu_sva_bind_device()
> > >   iommu_detach_device(d1)
> > > 
> > > Does detach
> > > (a) only disable the non-PASID address space?
> > > (b) disable everything?
> > > (c) fail because the driver didn't unbind first?
> > 
> > I think it must be (a), considering how everything is defined and the
> > needs for vIOMMU emulation.
> 
> Yes (a) is probably better. The SMMU driver currently implements (c) to
> ensure that you can't switch device driver without unbinding everything
> first, and we should keep that check somewhere

Yes, the owner stuff is a logical place to put that, when ownership
is all released the PASID table of the group must be empty. Lu?

> > Otherwise everything blows up if you attach an iommu_domain to two
> > RIDs - the API demands that every RID gets its own PASID mapping, even
> > if the RID shares iommu_domains. We do not have an API to share PASID
> > tables.
> 
> Well, we still do since SMMU implements it. Changing the API is fine, but
> someone will need to rework the SMMU driver to align with the new meaning
> of iommu_domain. I can take a stab if no one volunteers but probably not
> before next year.

I think given the current progression it is OK for this series to
leave the SMMU driver with a bit of a different view of how the API
should work. The main target here is the in-kernel drivers and they
won't trigger these cases.

As we extend things into userspace PASID support we may want to block
SMMU PASID support through iommfd/vfio until it is updated.

I've been thinking on and off about this - we likely need to have a
conformance test suite as part of iommufd that is specifically for
checking that the iommu driver meets the API. So it would do things
like exercise scenario (a), attaching domains to all sorts of
combinations, and so on.

We know this from other driver subsystems that drivers can implement
the uAPI incorrectly and it causes a lot of pain for userspace.

Jason
