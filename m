Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B3F5AB13F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiIBNRK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbiIBNQo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 09:16:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BF0126915;
        Fri,  2 Sep 2022 05:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtyYGa2ttRJxY50z5ekST/FoVaHQV2+ow30H29+tk7UszfD9bokARuMfje2MnTexeETr1jmv+r909paBl68wCboX98wyOlDUn8jQjJX3+3DEhhuLHcf1FfX37tEHb0pQI+kYGc+Mn1Rp1ThmWUxZ8iYf2UnXkEW8P948ycmFmZ5DJEd3RDzQVxg6WI4ZPJvyQbi1T6osyXzdBFXl922whCjXJpWHR3oUVJWB5n5CCCkOYLfRdvt3RvvN/tMBTmsLnKFGpAiTH8nB/KTby1hEQL6/vIrmm+BhevOKH83cxguo9OvFLevad0Fh3WkEBxqG/Sg+Twmd0GshHuCmuOgtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSqUhB8Yg5hABPRYqDnmKB3oabgKV2HWRLrXtSIk27k=;
 b=jI5RdxGDJe9wsW+yBH4YwVQ25hUdvGPHVB3H8WXQtbbIgC3nolJlqYWhGeH25pSwp80tPtzgKru1eJJ62jYxMXMk5Xw/WnOnrHqdyY3OERiZYT/I52FRMUhUM2riAy5OOgga7uOZFKsiNq6Bde9wYzUDHDgYzhnTuzq521qgACVXxPSiduJCUNQFd+83uv3yOlmH4Phdq0hfzGWSz4I6H92TjSFgpcPe5uuzNztborubaEeaQegsFYDe8CPLb6RUSetaiJcfrzKMz8hkqvNjoDG7dAJls4+7qf7I1PyXYww4fiIc2BBpw22i0XM3NsEhZuLQ2VBQY3+m5/rJ/hPLKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSqUhB8Yg5hABPRYqDnmKB3oabgKV2HWRLrXtSIk27k=;
 b=nvLbToj0uiZshgc06E6btK8ZZCIE21zjoc7bSZR3NrQuXAHld3oSe8tVXBq2v9FrRC1BGI7e9bRfqDOxbm52U7hoJD7OAOo+GzddLdxqpCQ01w6J7KsfQ5/qdp7HefLpe1VzuL2tZopSvUrbyPLPqBnTpL3Yk/MKmaCPwH1j1ltmaANJtuTgRYZwHGN9Oib5dY/2ZYRiSbhIWZyUFfAt2FrQMo3EXBvb3EO37mxIm/Xfh+v6/NTsYCnH27YK2by1qmVvEWj/jk1gudwlahK0xLRCUlD0K0W7hyxq6vSL9ZYLWFFlTjHV4x1G377Jt2BVgrSTbs4/YaMiHaQelriXpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 12:48:45 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.016; Fri, 2 Sep 2022
 12:48:45 +0000
Date:   Fri, 2 Sep 2022 09:48:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH v12 07/17] iommu: Try to allocate blocking domain when
 probing device
Message-ID: <YxH7rHvGfPuPgBg3@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-8-baolu.lu@linux.intel.com>
 <YwjeL2SVmdRpoWb6@nvidia.com>
 <316f6575-59ea-08e3-aaaf-bc1e4f42a574@linux.intel.com>
 <Ywz3A3tHEzY+Sf7b@nvidia.com>
 <c7d71936-ea06-3a71-d13a-cedd108413b5@linux.intel.com>
 <Yw4Qzif8W53ykR6K@nvidia.com>
 <c46ec383-bd51-1d78-ff81-0bee064ce1cb@linux.intel.com>
 <Yw9rwktDY9Uca/cv@nvidia.com>
 <53837119-9348-f9c9-1f49-cad639fc6ecd@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53837119-9348-f9c9-1f49-cad639fc6ecd@linux.intel.com>
X-ClientProxiedBy: MN2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:208:23e::35) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d435b4b-6c50-4961-020f-08da8ce17916
X-MS-TrafficTypeDiagnostic: BY5PR12MB4162:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROCFmbaYoy3oL+OesxicQ5P7zHI+55Qievf5XT+dChlTxXiKESkH/gSVKHaw0FJ7pw+7A6HIc2H6gwt5KSpZ4zXijnGhxlFukNj/dwak+XJVaPYe1AH6WQm9Vdqhdrm9LfCWbXDJQrADkl9PJDMKh7SFNewoAfKNqAKiuAum6jjjo/SIqpxY1h5yH3X/PZ7zBg0Oio2Z7/I6WY4rIII//7MO0O3AP+fp7/FGMpgoLTYZRih7Ky/kdLqgU2k34nj55MoN58eHN8dM/PFElGIxcWECUbMvGDLdRPKV95Wftkn5Uj7z27J1iP7HrvkQtaTlBYy+/TUboI9sdmJGXL3+yEIFZIVKTR4T7VLXz2vf5Vr/gGPVRMaiO5fmNbiWOhj/Xv2c7OS+Rpwoz53PPgDi65wKUpPUpK4OSWaxTf50Bmf4lQVLD7DOeSf4zkL4x/CVtTdnzAEgxx4jw+dqmh5cDuhJ8lWNWe8GEdQCIuJOWq8AqAfq/SJAlli0gPAPLxNV9VGVt4RvSGItMV50/+mgd4H4PqPa/8w4s123bI2aB0oHjcKxRPXqI2kh7tGCyC934JxWn04UPBEYKrTJSJ1UO3zeR3wbsig2bZNHxB1nF8idoY4ADXGP4N/YzIoZDdgZGxWj9TOKNxtA3ZssD5KG0E01DFF0UjpssBLHT3ZSOcxa4syu1d84ibMxOmWUQg7P+bNa14nZdmY0TYWzvQs0hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(83380400001)(38100700002)(66946007)(66556008)(66476007)(8676002)(4326008)(54906003)(6916009)(316002)(2906002)(4744005)(7416002)(8936002)(5660300002)(53546011)(26005)(6512007)(6506007)(186003)(2616005)(6486002)(41300700001)(478600001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BYmvnbdkE+/EqEk04qZBYlG7b0d+U95myhkqHxT08BCXynDz79RfthfBHdlN?=
 =?us-ascii?Q?otc19cuupvfddS8BaH38PZ6mwhiTrC/j1At/bwNCya5Czam7iDM9sDLjucvv?=
 =?us-ascii?Q?ZKha3sMtSENpOzUh0wCBHxrgEZHfZS0z8D2RelWS73EJ5ZYGQOgsthSC28Rc?=
 =?us-ascii?Q?CR/EHuNmgFAEjxuy20VGklkoCCLFHChoAFWJZseanmy9f+RCWluTgbgYUJ7b?=
 =?us-ascii?Q?wbnh2vydbMYB0tOD6oSB5l8BeRs7Mb9Y63nJdWpC8YuWwUt3Wfwc8eLy+iox?=
 =?us-ascii?Q?WbMgu9YkZB/ylioQpk/vYBqNt/NCJ0Py+RVKRf1USR9WiAph4BKI3j3ukMrE?=
 =?us-ascii?Q?OFkHbNz8EabLFTm+tFUYaYXeHG5f2ZmBUKEtmg+wQI9+ruVx+J9AIT/cb0pv?=
 =?us-ascii?Q?Aqbg63lpzvrBMnFrpIBVCgMwVGc+5E3Xu0E9bZjUS+tr6NoQgJxMhf+dqug8?=
 =?us-ascii?Q?bHAoUdIBjmwl0Obx2OZjIyFgOurGHYEmtV4FFnOUn/UWxkq47J1bnzC1VxZX?=
 =?us-ascii?Q?7sWmaHDupUzTkcwP8aFjjcPofx1+YpmsJiwMGSb6DqvjwcV5nlYCq9k2PINI?=
 =?us-ascii?Q?bU3mfFtgT/5D1WPJ7t9BBzw0xL6gUurFQblftb/4BVemz9I5E+c6V7dhR3TD?=
 =?us-ascii?Q?7FrCcT+zvy4iaRiw1HYdn/O2EpcykNEW64DZvSpblBeEaHcI5lJ4WJylyFsC?=
 =?us-ascii?Q?ggdq32QlLngDflnHd+nBDOGcmTacej/IQV0eZrRiT4PdkEn+9GLE6tbNHpVu?=
 =?us-ascii?Q?Yp/IhZz3L6VtojTmwmF5GIwIuywgDobZyJ4I96/FsLw7Jb9rV28DuC3FpSfP?=
 =?us-ascii?Q?W88hdU92mKSkweuHlULdm5KMCziWdUfQeo/RUf3aqR22ACl1MJFwyHNlqJpn?=
 =?us-ascii?Q?KTR3JYnZ90PAaNYHqFfvhhL3B5mvCei4mgSS0mIwMFqpnIUEuMP/+tX0yBOu?=
 =?us-ascii?Q?38tdU6QKJvg8uNweB8k5D4csiIkSfkkT2EeR9dAjgWuZp33ygHeOazcdIpOs?=
 =?us-ascii?Q?Rd8P0lN1YcgqwPXxU2uusKziZc6XJ1xQfoBiibU7ZHG7tPQ6R5QoOfhJAiAB?=
 =?us-ascii?Q?NtjW2pPB4oD5mg0DoI1MKLaObTqJQUQhv8CN639hcPmDJSCodGEdbDxCyLhs?=
 =?us-ascii?Q?xDs/uUnGhCXcR9gC8Rk9AbP2X9iJznEvjjpRX59Bq0sMqbGsPO86l8MRyh3P?=
 =?us-ascii?Q?u74olvSjAczdxlYpo656hBRDpdAC6rbk+S2xUMtRPvCU1Urr7Vbcffggox69?=
 =?us-ascii?Q?7NCeS5nHkeGlF7LXz4CdE0+POBuCkmq6H/P3vmvycxlCdnFQK02cdDn2YFII?=
 =?us-ascii?Q?0a8bTa8wrx/L2+AXIAajyPbCVqnT8SicoMM8IkMZy4W751h/q3597yy9FPEz?=
 =?us-ascii?Q?93Qtf0K7Od2bNdU1fuXn3AqrNhD6SboqRRDUEIp5AS2vytog8RetvVPa4uD3?=
 =?us-ascii?Q?V60wCiVHXxC7In495bwyKxMFVCWv/LUG6f6GvUZzeBIjIq+2UrtT14uho/CO?=
 =?us-ascii?Q?Q7r38vZRu2Fxqql2iHA/gVFiplV0J23tO1bxNswyAZXbOcLrOJTc6O3B88nn?=
 =?us-ascii?Q?7hv4adjbJWW5g9tDWpRIM0kk4gq8LkX9Zfb73+oy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d435b4b-6c50-4961-020f-08da8ce17916
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 12:48:45.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYnKff7bntFpp/DwqA7ANNkv3ddSy8MNr91mtCQDopY2OyM4vP1kECF46SPgljVC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 01, 2022 at 06:44:10PM +0800, Baolu Lu wrote:
> On 2022/8/31 22:10, Jason Gunthorpe wrote:
> > On Wed, Aug 31, 2022 at 09:49:44AM +0800, Baolu Lu wrote:
> > > > Maybe all of this is just the good reason to go to a simple
> > > > device->ops->remove_dev_pasid() callback and forget about blocking
> > > > domain here.
> > > 
> > > Do you mean rolling back to what we did in v10?
> > 
> > Yeah, but it shouldn't be a domain_op, removing a pasid is a device op
> > 
> > Just
> > 
> > remove_dev_pasid(struct device *dev, ioasid_t pasid)
> 
> It's clear now. Thanks!
> 
> How about below iommu_attach/detach_device_pasid() code?

I think this is probably the right thing

> By the way, how about naming it "block_dev_pasid(dev, pasid)"?

set/remove is a better pairing that set/block

Jason
