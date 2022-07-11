Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6FD56D216
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 02:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiGKAI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 20:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKAI1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 20:08:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B551570C;
        Sun, 10 Jul 2022 17:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657498105; x=1689034105;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Nn+FNrB3SBkvcdWFuP5we5qPuBdVDthM1rEUKEOqURw=;
  b=XWcLBrvK/tbE3SdsdN7iAcfODer+ZiXDlq+tfO7T2Bh04EtTwR3RqQNw
   hFLujUMmbGXxjhiRbKaPrcMQgS5b8I/YgZ0TjXmWOXu7zCPqOohwQEQd/
   G5brublyzS7b1+wcYEpvv3rVN2UWItWnHln2i+nSZZZcv34TBr0oCit/p
   iG1F2FXM9gqQ0tIavkEbjylMUeb0/St3jtlRJazruDwGdIOiBN2q6M7iV
   8hJAa6fd6hItG0/NLH3d8Me+uuoSN/nctg/2pE+l60bK0Qi6ReacSm12C
   SG4Db1ZhGNY5BgtEN1a28yjgetbFwAKKhWgWDMqz29TTt4JXHW0Dzcdep
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="348530689"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="348530689"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 17:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="627299747"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 10 Jul 2022 17:08:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 17:08:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 17:08:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 17:08:24 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 17:08:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQXZRptjyIdHxTfqXXY4fANxTCeSOSBiZsS4606jCzewX9PO7pavDND9lyIu8iK9l+CZG5JjQ023KU/mp+o1RkdLXJ/RJ9qTmIBx8aT2SJwF41MOdDojWCh+LAJlXqhLEDHHt2blKL+6WRyPzvrBCksquCxwbe8wuz6I4h1CCA+1vd/t+6GEqqGYErZz6PDeFfNJXXYtQ+Wx6PnEiU0UvM1EUyyzCLvRSHqH+9EhWDUHlEIGpcQr2zRMC4bMiyozBsbJWFLDaWD77DOonnt2YFpbuzuxva2iB4m7c+HIpEeOdFQBJ0nGTBEt6QPTrUg87oTDgQuiaTOLNyLUb9PJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2YHmgRLGzyj0qlwYbXGb2voVZqdcdoee6StlNCiFqA=;
 b=BhpLFYWjWX2BDWXMqbZUh3AH2LlOSy5PbK97PqRWJrfkPniqraLx8u6Mr1HJYBgnLeWWOJM/9WOnQErqYSDGjrvwOqPUUBPAor8QyZsxQyDYN6P2WG7nTR9/fvea9ySalxSqVjrRXErJDWkILDUM3KO+F/VnwAUNs7kZySqw1Q/sMkmVfhUhNH22Eo81B/8xr/PDlJATDlOrfy96hnfMpDswAiWBG23/njOcM8FhBG1lCmmm2mnGJG+XgQUMTTNsbi8A+S3Td2tCVpoR5rZO3LWe82AEYxln0lEPlI8BMp/bIDfA5uy01wIClie2PsieqhP1WBEljzABvko0gaPEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB4943.namprd11.prod.outlook.com
 (2603:10b6:a03:2ad::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 00:08:22 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Mon, 11 Jul
 2022 00:08:22 +0000
Date:   Sun, 10 Jul 2022 17:08:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 34/46] cxl/region: Add region creation support
Message-ID: <62cb69f47767b_353516294c9@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-9-dan.j.williams@intel.com>
 <20220630141721.00005dce@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220630141721.00005dce@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0258.namprd04.prod.outlook.com
 (2603:10b6:303:88::23) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 802f114b-d767-45da-1319-08da62d1775e
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4943:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJbgNMAdo9TVKZQC7vfy7HH8KGpSED0cjh+6EH7TUS/14OtczdHr7C4gnLnu3T4QGlGooBt2VuoiicC4/w483L6UrQa+ADMDZCEHVxL4jgrFqVVUqhZ4o1lyr3R37UNTmqa2E5Y0XBq35NWkEDFKddB6bpd36rM33x7lZyvZoPni7A56f3P4qTA2YbL7Qx7wt2YHD3WDbAkuyrVt0w2f3RCFtW5ZXgGK/Bg/yFlwxis1fc4+7Xh8Q/zkxppcO47NkHcDKINvOeOXv2BRoAO9+jF9xILJ/JLZunLmk1FbNOfaOyqCPZ3wiXjIwuspfFRUmqF8S2GjYYuj7GlnaAUpUwhjSF6jH8CYR1jsm/p6tvNSEK53bixseXOfSKlMI+tHL0ytJsWBSAG3n0yznnRf1BECwzf9vb+VQx6LUMKcEI5melcax6XCwQCZd5K/HY5j0h9apLOabdWGw2zMR2WuwFNg6pm/8xdvQ/BNm7yf+QUOIC7j+uSQmQf1LcUBU1O8t6m1riPMDT6gWMymSFNMDL5+zMfG1a/Nj9Wb6qxLrFHiK1/HVX+9WJvll4kCjke0rNagZGJi+9Q5ZT/xoHOhVTLleuUYIWXA1LydWEBex5TcXWeOaXCFvGeGAwHcihuBuX9XX9xFML2dBOWKXGCP4NGlXXNnRCLe0qF91VJCoW3ltpov7XArSG4Z5qndjmBpyyKr8Wc2mdsK06zoMvD3zz3K94zAmYDa5ez/6l75v8wHYyU89INi1ywDZZOT15u182DLSDzaRu4frnN/p62EEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(376002)(366004)(136003)(8676002)(66476007)(186003)(4326008)(316002)(66556008)(66946007)(6486002)(110136005)(26005)(86362001)(478600001)(41300700001)(6506007)(6512007)(9686003)(2906002)(38100700002)(8936002)(83380400001)(30864003)(5660300002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AFkdAPx0ec+kJprUr5Sd8TtfvvEubCBGbdwPMYbUco3km0z/p7QuF7AYBugk?=
 =?us-ascii?Q?y7nApdttDkYzGI+z+tGuOsB6mzQsKICbXfqkL+EOFDASYSEC91qZE2zHEmzx?=
 =?us-ascii?Q?bXqZ7dH+vENbzLuS9CMEkxoZnI8MXAHgR2uxNgno/LBQz67rjn8/uPEsr8CS?=
 =?us-ascii?Q?jG9DKQai8/ZNymrh5/bspZQRdAS2qnK7T9MIu2YcoJ9JJuxfZobxG1jx1Rcw?=
 =?us-ascii?Q?ip6NytJOgx49RLtxqzQyiReiAqYTX8c6ZCF7b/hXyR8Dv6CmmeJPuYa8mXb5?=
 =?us-ascii?Q?1h8z6uPnKiNw6tVVz4I1+2IVjIJ/4Tzyi08x7K11KsHNGsAAgenUnP0YVWFL?=
 =?us-ascii?Q?l4e0R5LpawxggIAz22Uu1R87dm4GfGQmvCxJ5GsQmI1jHCUf5oQfVrRwPh2E?=
 =?us-ascii?Q?S1wvxi0j/yyZ1CbVpiBMLeJYloot/J0/ALDh9OdHjOx1wHaOJ1M/LH4kac8C?=
 =?us-ascii?Q?QCyGBx7gJasHnuJDh0Q3Geddob4T6LbG6MngJDh6TbWTQ6c1jOVv/bfUui7A?=
 =?us-ascii?Q?1jMKBgEyf1URu/1CrOwAEzcsZsQ/X6GNqSXK0FL6OHLELW6OAwbAHWBsQZnk?=
 =?us-ascii?Q?FDtszsK0LVNxI42n8MNOfzpv55EcDVaGaJduXX/r5EIpbGIJHnb2j53svlpN?=
 =?us-ascii?Q?tX5Ob4wzBP7e1P9QugDIvGD27kX0jK1H3OLFlr6VNQrVilEp2zI7c28IyKQv?=
 =?us-ascii?Q?y5YI9HXUlqVGuQjK++4fHCEMMKkgZvBNjnnmRX53hmvY4VRljPiDczqAGJKd?=
 =?us-ascii?Q?KZIB3pUzWRTitio9n3da55szuAl3z96KHT0xJfbIMvSds3zH9CqyjSYVxe+T?=
 =?us-ascii?Q?vW1nSetwiuRfBSow1J10MZdtRKzIUexE+gNi24H//P/FW6nMqMW0IqYP0xSL?=
 =?us-ascii?Q?W86qcBtvUVOmcnfNdFMXI/AwWMR3EL521cIk1Dc27vPEjwiEsj2DRUaZywqz?=
 =?us-ascii?Q?ua6vz/Wx8MY9qJstvygBFwfFauxDYupk7L47RqXhQOId3l7jKvbIYM2D2327?=
 =?us-ascii?Q?DCVaEAFW9VDG/J5C6tXkaLJFPdcjXB+T1usPuMJ0n6JDJhTuDzz9HJVsQFGH?=
 =?us-ascii?Q?P9uzwhcx0mK8aAoorC6zWQSRMR/SQ15R8YcdqMejSAyuk8187Nly6QeJSN/2?=
 =?us-ascii?Q?XzF+G0+YEXkusdgZiPirk8fk+oufhM5apXdb25lYmFDkbNv9VxbIOhLu+fdO?=
 =?us-ascii?Q?5rrFK/YBfB4TXGUcLCHeuUNCBI5If/6yTW30sFq7Jw4lff1bxgHCl8IaeZ+t?=
 =?us-ascii?Q?VSc88BktiH5i03KfWBnwEdGNsiGkGLH4vMd+xqBAJ06F7uuxpfySxfG51jDZ?=
 =?us-ascii?Q?sV7ZAR1lHDLvOXt6dVsxp37vQ++9yuyCQDP1ECoQGay9wlv37I9TWVrUsx9B?=
 =?us-ascii?Q?qR1MloCF9Eb1NcepEjvjDc6EzxeOUwp3YmjTYVRzCyK0RlHnVcM2iWXNJMqK?=
 =?us-ascii?Q?mBUn+HHt6YGZRWIhY01yz1yGG7Dj0GgOHeNJvhUZMbg1dzPaCiLDtaheFDgb?=
 =?us-ascii?Q?RhuCaat2kg2VGMzAoyq0LL+FYZKI431iyNUK+gPu+IWXBwgU5fHDVQ9ZFtpR?=
 =?us-ascii?Q?XNirhQmfx3q2VqQjvli50yArLRg24yN34D5bLItdQD4a1rxcKFPvfFO6FOOI?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 802f114b-d767-45da-1319-08da62d1775e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 00:08:21.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxEIqv6KGaYd5OVDXbhtgFPnPgX9VqdjnVlNw1oJEKx7PJ6NqRA5/gNrW7TXPKzIQY8MMZNllCzafx7Kk0A2Sio6n7KQqc46tp2pZEoqVA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4943
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 21:19:38 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Ben Widawsky <bwidawsk@kernel.org>
> > 
> > CXL 2.0 allows for dynamic provisioning of new memory regions (system
> > physical address resources like "System RAM" and "Persistent Memory").
> > Whereas DDR and PMEM resources are conveyed statically at boot, CXL
> > allows for assembling and instantiating new regions from the available
> > capacity of CXL memory expanders in the system.
> > 
> > Sysfs with an "echo $region_name > $create_region_attribute" interface
> > is chosen as the mechanism to initiate the provisioning process. This
> > was chosen over ioctl() and netlink() to keep the configuration
> > interface entirely in a pseudo-fs interface, and it was chosen over
> > configfs since, aside from this one creation event, the interface is
> > read-mostly. I.e. configfs supports cases where an object is designed to
> > be provisioned each boot, like an iSCSI storage target, and CXL region
> > creation is mostly for PMEM regions which are created usually once
> > per-lifetime of a server instance.
> > 
> > Recall that the major change that CXL brings over previous
> > persistent memory architectures is the ability to dynamically define new
> > regions.  Compare that to drivers like 'nfit' where the region
> > configuration is statically defined by platform firmware.
> > 
> > Regions are created as a child of a root decoder that encompasses an
> > address space with constraints. When created through sysfs, the root
> > decoder is explicit. When created from an LSA's region structure a root
> > decoder will possibly need to be inferred by the driver.
> > 
> > Upon region creation through sysfs, a vacant region is created with a
> > unique name. Regions have a number of attributes that must be configured
> > before the region can be bound to the driver where HDM decoder program
> > is completed.
> > 
> > An example of creating a new region:
> > 
> > - Allocate a new region name:
> > region=$(cat /sys/bus/cxl/devices/decoder0.0/create_pmem_region)
> > 
> > - Create a new region by name:
> > while
> > region=$(cat /sys/bus/cxl/devices/decoder0.0/create_pmem_region)
> 
> Perhaps it is worth calling out the region ID allocator is shared
> with nvdimms and other usecases.  I'm not really sure what the advantage
> in doing that is, but it doesn't do any real harm.

The rationale is that there are several producers of memory regions
nvdimm, device-dax (hmem), and now cxl. Of those cases cxl can pass
regoins to nvdimm and nvdimm can pass regions to device-dax (pmem). If
each of those cases allocated their own region-id it would just
complicate debug for no benefit. I can add this a note to remind why
memregion_alloc() was introduced in the first instance.

> 
> > ! echo $region > /sys/bus/cxl/devices/decoder0.0/create_pmem_region
> > do true; done

I recall you also asked to clarify the rationale of this complexity. It
is related to the potential proliferation of disaparate region ids, but
also a lesson learned from nvdimm which itself learned lessons from
md-raid. The lesson from md-raid in short is do not use ioctl for object
creation. After "not ioctl" the choice is configfs or a small bit of
sysfs hackery. Configfs is overkill when there is already a sysfs
hierarchy that just needs one new object injected.

Namespace creation in nvdimm pre-created "seed" devices which let the
kernel control the naming, but confused end users that wondered about
vestigial devices. This "read to learn next object name" + "write to
atomically claim and instantiate that id" cleans up that vestigial
device problem while also constraining object naming to follow memregion
id expectations.

> > 
> > - Region now exists in sysfs:
> > stat -t /sys/bus/cxl/devices/decoder0.0/$region
> > 
> > - Delete the region, and name:
> > echo $region > /sys/bus/cxl/devices/decoder0.0/delete_region
> > 
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > [djbw: simplify locking, reword changelog]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl       |  25 +++
> >  .../driver-api/cxl/memory-devices.rst         |  11 +
> >  drivers/cxl/Kconfig                           |   5 +
> >  drivers/cxl/core/Makefile                     |   1 +
> >  drivers/cxl/core/core.h                       |  12 ++
> >  drivers/cxl/core/port.c                       |  39 +++-
> >  drivers/cxl/core/region.c                     | 199 ++++++++++++++++++
> >  drivers/cxl/cxl.h                             |  18 ++
> >  tools/testing/cxl/Kbuild                      |   1 +
> >  9 files changed, 308 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/cxl/core/region.c
> > 
> 
> ...
> 
> 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 472ec9cb1018..ebe6197fb9b8 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -9,6 +9,18 @@ extern const struct device_type cxl_nvdimm_type;
> >  
> >  extern struct attribute_group cxl_base_attribute_group;
> >  
> > +#ifdef CONFIG_CXL_REGION
> > +extern struct device_attribute dev_attr_create_pmem_region;
> > +extern struct device_attribute dev_attr_delete_region;
> > +/*
> > + * Note must be used at the end of an attribute list, since it
> > + * terminates the list in the CONFIG_CXL_REGION=n case.
> 
> That's rather ugly.  Maybe just push the ifdef down into the c file
> where we will be shortening the list and it should be obvious what is
> going on without needing the comment?  Much as I don't like ifdef
> magic in the c files, it sometimes ends up cleaner.

No, I think ifdef in C is definitely uglier, but I also notice that
helpers like SET_SYSTEM_SLEEP_PM_OPS() are defined to be used in any
place in the list. So, I'll just duplicate that approach.

> 
> > + */
> > +#define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
> > +#else
> > +#define CXL_REGION_ATTR(x) NULL
> > +#endif
> > +
> >  struct cxl_send_command;
> >  struct cxl_mem_query_commands;
> >  int cxl_query_cmd(struct cxl_memdev *cxlmd,
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 2e56903399c2..c9207ebc3f32 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> > +#include <linux/memregion.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/device.h>
> > @@ -300,11 +301,35 @@ static struct attribute *cxl_decoder_root_attrs[] = {
> >  	&dev_attr_cap_type2.attr,
> >  	&dev_attr_cap_type3.attr,
> >  	&dev_attr_target_list.attr,
> > +	CXL_REGION_ATTR(create_pmem_region),
> > +	CXL_REGION_ATTR(delete_region),
> >  	NULL,
> >  };
> 
> >  
> >  static const struct attribute_group *cxl_decoder_root_attribute_groups[] = {
> > @@ -387,6 +412,7 @@ static void cxl_root_decoder_release(struct device *dev)
> >  {
> >  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> >  
> > +	memregion_free(atomic_read(&cxlrd->region_id));
> >  	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
> >  	kfree(cxlrd);
> >  }
> > @@ -1415,6 +1441,7 @@ static struct lock_class_key cxl_decoder_key;
> >  static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >  					     unsigned int nr_targets)
> >  {
> > +	struct cxl_root_decoder *cxlrd = NULL;
> >  	struct cxl_decoder *cxld;
> >  	struct device *dev;
> >  	void *alloc;
> > @@ -1425,16 +1452,20 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >  
> >  	if (nr_targets) {
> >  		struct cxl_switch_decoder *cxlsd;
> > -		struct cxl_root_decoder *cxlrd;
> >  
> >  		if (is_cxl_root(port)) {
> >  			alloc = kzalloc(struct_size(cxlrd, cxlsd.target,
> >  						    nr_targets),
> >  					GFP_KERNEL);
> >  			cxlrd = alloc;
> > -			if (cxlrd)
> > +			if (cxlrd) {
> >  				cxlsd = &cxlrd->cxlsd;
> > -			else
> > +				atomic_set(&cxlrd->region_id, -1);
> > +				rc = memregion_alloc(GFP_KERNEL);
> > +				if (rc < 0)
> > +					goto err;
> 
> Leaving region_id set to -1 seems interesting for ever
> recovering from this error.  Perhaps a comment on how the magic
> value is used.

Comment added.

> 
> > +				atomic_set(&cxlrd->region_id, rc);
> > +			} else
> >  				cxlsd = NULL;
> >  		} else {
> >  			alloc = kzalloc(struct_size(cxlsd, target, nr_targets),
> > @@ -1490,6 +1521,8 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >  
> >  	return cxld;
> >  err:
> > +	if (cxlrd && atomic_read(&cxlrd->region_id) >= 0)
> > +		memregion_free(atomic_read(&cxlrd->region_id));
> >  	kfree(alloc);
> >  	return ERR_PTR(rc);
> >  }
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > new file mode 100644
> > index 000000000000..f2a0ead20ca7
> > --- /dev/null
> > +++ b/drivers/cxl/core/region.c
> > @@ -0,0 +1,199 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> > +#include <linux/memregion.h>
> > +#include <linux/genalloc.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/idr.h>
> > +#include <cxl.h>
> > +#include "core.h"
> > +
> > +/**
> > + * DOC: cxl core region
> > + *
> > + * CXL Regions represent mapped memory capacity in system physical address
> > + * space. Whereas the CXL Root Decoders identify the bounds of potential CXL
> > + * Memory ranges, Regions represent the active mapped capacity by the HDM
> > + * Decoder Capability structures throughout the Host Bridges, Switches, and
> > + * Endpoints in the topology.
> > + */
> > +
> > +static struct cxl_region *to_cxl_region(struct device *dev);
> > +
> > +static void cxl_region_release(struct device *dev)
> > +{
> > +	struct cxl_region *cxlr = to_cxl_region(dev);
> > +
> > +	memregion_free(cxlr->id);
> > +	kfree(cxlr);
> > +}
> > +
> > +static const struct device_type cxl_region_type = {
> > +	.name = "cxl_region",
> > +	.release = cxl_region_release,
> > +};
> > +
> > +bool is_cxl_region(struct device *dev)
> > +{
> > +	return dev->type == &cxl_region_type;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(is_cxl_region, CXL);
> > +
> > +static struct cxl_region *to_cxl_region(struct device *dev)
> > +{
> > +	if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
> > +			  "not a cxl_region device\n"))
> > +		return NULL;
> > +
> > +	return container_of(dev, struct cxl_region, dev);
> > +}
> > +
> > +static void unregister_region(void *dev)
> > +{
> > +	device_unregister(dev);
> > +}
> > +
> > +static struct lock_class_key cxl_region_key;
> > +
> > +static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int id)
> > +{
> > +	struct cxl_region *cxlr;
> > +	struct device *dev;
> > +
> > +	cxlr = kzalloc(sizeof(*cxlr), GFP_KERNEL);
> > +	if (!cxlr) {
> > +		memregion_free(id);
> 
> That's a bit nasty as it gives the function side effects. Perhaps some
> comments in the callers of this to highlight that memregion will either be freed
> in here or handled over to the device.

Added to the devm_cxl_add_region() kdoc that the memregion id is freed
on failure.

> 
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	dev = &cxlr->dev;
> > +	device_initialize(dev);
> > +	lockdep_set_class(&dev->mutex, &cxl_region_key);
> > +	dev->parent = &cxlrd->cxlsd.cxld.dev;
> > +	device_set_pm_not_required(dev);
> > +	dev->bus = &cxl_bus_type;
> > +	dev->type = &cxl_region_type;
> > +	cxlr->id = id;
> > +
> > +	return cxlr;
> > +}
> > +
> > +/**
> > + * devm_cxl_add_region - Adds a region to a decoder
> > + * @cxlrd: root decoder
> > + * @id: memregion id to create
> > + * @mode: mode for the endpoint decoders of this region
> 
> Missing docs for type

Added.

> 
> > + *
> > + * This is the second step of region initialization. Regions exist within an
> > + * address space which is mapped by a @cxlrd.
> > + *
> > + * Return: 0 if the region was added to the @cxlrd, else returns negative error
> > + * code. The region will be named "regionZ" where Z is the unique region number.
> > + */
> > +static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
> > +					      int id,
> > +					      enum cxl_decoder_mode mode,
> > +					      enum cxl_decoder_type type)
> > +{
> > +	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
> > +	struct cxl_region *cxlr;
> > +	struct device *dev;
> > +	int rc;
> > +
> > +	cxlr = cxl_region_alloc(cxlrd, id);
> > +	if (IS_ERR(cxlr))
> > +		return cxlr;
> > +	cxlr->mode = mode;
> > +	cxlr->type = type;
> > +
> > +	dev = &cxlr->dev;
> > +	rc = dev_set_name(dev, "region%d", id);
> > +	if (rc)
> > +		goto err;
> > +
> > +	rc = device_add(dev);
> > +	if (rc)
> > +		goto err;
> > +
> > +	rc = devm_add_action_or_reset(port->uport, unregister_region, cxlr);
> > +	if (rc)
> > +		return ERR_PTR(rc);
> > +
> > +	dev_dbg(port->uport, "%s: created %s\n",
> > +		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
> > +	return cxlr;
> > +
> > +err:
> > +	put_device(dev);
> > +	return ERR_PTR(rc);
> > +}
> > +
> 
> > +static ssize_t create_pmem_region_store(struct device *dev,
> > +					struct device_attribute *attr,
> > +					const char *buf, size_t len)
> > +{
> > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> > +	struct cxl_region *cxlr;
> > +	unsigned int id, rc;
> > +
> > +	rc = sscanf(buf, "region%u\n", &id);
> > +	if (rc != 1)
> > +		return -EINVAL;
> > +
> > +	rc = memregion_alloc(GFP_KERNEL);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	if (atomic_cmpxchg(&cxlrd->region_id, id, rc) != id) {
> > +		memregion_free(rc);
> > +		return -EBUSY;
> > +	}
> > +
> > +	cxlr = devm_cxl_add_region(cxlrd, id, CXL_DECODER_PMEM,
> > +				   CXL_DECODER_EXPANDER);
> > +	if (IS_ERR(cxlr))
> > +		return PTR_ERR(cxlr);
> > +
> > +	return len;
> > +}
> > +DEVICE_ATTR_RW(create_pmem_region);
> > +
> > +static struct cxl_region *cxl_find_region_by_name(struct cxl_decoder *cxld,
> 
> Perhaps rename cxld here to make it clear it's a root decoder only.

Yes, in fact it should just be a 'struct cxl_root_decoder' type
argument.

> 
> > +						  const char *name)
> > +{
> > +	struct device *region_dev;
> > +
> > +	region_dev = device_find_child_by_name(&cxld->dev, name);
> > +	if (!region_dev)
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	return to_cxl_region(region_dev);
> > +}
> > +
> > +static ssize_t delete_region_store(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   const char *buf, size_t len)
> > +{
> > +	struct cxl_port *port = to_cxl_port(dev->parent);
> > +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> As above, given it's the root decoder can we name it to make that
> obvious?

Right, this is now:

struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
