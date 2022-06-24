Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EED558D75
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiFXCro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFXCr2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:47:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4914B56F8B;
        Thu, 23 Jun 2022 19:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038847; x=1687574847;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hZDzbqdvdL0Lsair8D6fHdnqjSy4yrUja0LuPqwSDB4=;
  b=lzDG+/XQ5DVrkE0R8QnGY0hlW9iR2zdPtrvGFq7mGLSJxUuqQg7nNbUO
   Dp1DD6IVt4szptsXoDtoYG7+p3CsjX+Cjrv1bX+gtUt6y969Rp46ORLri
   mHiKyoKRJUSg52EgGlOteJfbR8tH1EN8vfuStewxK+OCtfiyKu8QjCq1O
   +CBlsii/KPpIwPHHTeY/DtUWF5hokzLFVh6VdAW2epv9SlT6rKG1uZguf
   JAAWDAkKCO5nGyqF23XCc43p7u/egJ8nKnFlMC1xY247197XSQAyukv/l
   4iCS3wdkG6ZLqsxI3dLftYRdjJcNOF5yOzkM+vJnAqQQx+xi9P0W+DPV+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261331954"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="261331954"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="834933986"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 19:47:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:47:26 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHVfm674r11T17iUG2ZtMvn6+0cX9gri7Hv7iKkiglnKxXDNxHI3R5f8qTFS7cJNB9sXoUm/o0E6lLdbf/LQ0QEhWruIYlP588L/TMOyKVaV5WhDRSwtxS8LA17fMhcalBoEVjnTAEsDFAtY2D8g3YcshgRFzIeCJAwDKua1RBMLSwypcj7nUGvo/Ul8fJeTMKypWvPnl2BmwsJZsTjaFpdJUEtwDc0LTrjRNHPpNnprMexARACnSMFsX3zEJ0KfHdl5qfAXW6/tHS6ImTOQ+S4jEEYTHoTxT1ZesCyMcnOhxFMdbICm48ePS+kP7E352R60ZZ8s1tQMI/NgJ8DCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYEsxWpRW4rAw7Q7uQ++hy5O504P+o8Td4t+Uu2rV8A=;
 b=F7WEe0CDJyucS3sWsegIKj9vUt4g/HP8e9s7ZJJ+wplN4Lnoej2rG0Pv80LRNDFFEpigPRAoWcTyMLxnT2muXs/3Bf0aBlLCeBtaDZSAtniObeAQbp4iiDOYbo4BUPWoVHdKOPbyV+4klXoHUapIcwQ9wcIFyCbbfaW0YcC6roKQA/L9sywReDhcgBbm6KAPjZ+aMnPNvVJhRDuG1KlZKUqFABcAar6rjaG2rtKM8Zx9kujDsUNUTnN0zCsLgs3o/ih0E5qlPQQqCZpb1+m8wmFPj5bkqAW352zypuumJ5XZnIwoiu3WCA70L6Rh4aJ+RHoQAIQEXRiLbcUfCmIRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:47:24 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:47:24 +0000
Date:   Thu, 23 Jun 2022 19:47:18 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 18/46] cxl/hdm: Add support for allocating DPA to an endpoint
 decoder
Message-ID: <165603883814.551046.17226119386543525679.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR1701CA0013.namprd17.prod.outlook.com
 (2603:10b6:301:14::23) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82b96727-8f4c-4f2b-5798-08da558bdb9e
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fu/+kI1RcnuVEJoMRrvb/ErhL/XUFHgtmTXEvYjKWaQlVJHU05KZaRlpC3qvQ6b3vZ3aAQ7WrxtdLuplPBZPG5/4JMwuW7907QwJKHCGAMH8qW5DfqyYhhSiN5Qcf2fYJvUHK/39YEDFqbt/bMx9sPCL6mmm39QVPdCDUg9llnJKKo8gi+99v8dA+4xces7/VtOVi1ZrG0ozH2U/nEh9P9G3Sck5vA78E7z+BKVxbslfSdSkxENsr2DhrFhMypWutq4I3XW02Hd8CeUOS6+BUaU+BrtyGavQy7f9yBlQKWChRjzseJI8SS1uSsSM81L2KFbOv+JRpZL3oe5j/IIQ42NZg2P3w8ImZVtaG7RdhwaWh0cKH4iIOVJb3+siHDDbGwyxLfJEPWhNxxsz3J/t8DUOP9U3pOWeoIHxsVrAklwR3gou+jB4JJbebhleY3G9W8qXKxJ5xZDguaAfciK2yOfTyG8VqmY81ZCamZE6nOwQMp5Qc58tu5Vn+rMHMHwYejBoqdP4VPNW8L0Fmm0X0zij88H5na7bjNd3XDhnA5Ta///Hp641VCWZez+ZRJ5qMIbmI2Nh/IJo4kEmJTFx03iaqhgmKQCT0tB0EVE0k7AYmGaWP8DAdkwNXb0V5b+ZGgMZnqQ3kOCb1OhcMQkTJpnj+Lo2w7DhOSrp8yZYU4QdWfEgIrHs3kKcGWiat3vb5ifrqI0c1lEnt5BvCdmJ36r1/ljnb6rMQX8GgUFyh/yFPtfnov/iUf41E8Ioqa1c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(6666004)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(30864003)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W7xXCLXLp3ZjB6E+5tGLIszE+CA/udL8rwgzf7oDUDH4N7UexDmKAhOmTCb2?=
 =?us-ascii?Q?Zt4WTfV4d4qJmFFIDj/reWEEVi0P3QBPIgYttTDnRhnpsgbzWPKpQF637iOl?=
 =?us-ascii?Q?mKoOshr4jTnuKNNq+zQ+ml+80mdID2t2Fst4UmrVeaTCdZ4ggId9/zkdi+gQ?=
 =?us-ascii?Q?XZJ9W+jer5wrAFlAiuCQrARlsuiBcb+y4GIpswzXtS4pY5KPZurF6/MYQO0u?=
 =?us-ascii?Q?3fGJM/HPwKMW1LPjt1a9rLmFS049NLIjGEG9gIr2i1lhafWsYUBh2PE43usW?=
 =?us-ascii?Q?Zfvr+bbHysPzc3jp+9/MmJyxhFHVAe4ahobLe5iWFkJQzeUaKqaIRBLHTm1F?=
 =?us-ascii?Q?+lKcvjys3jDcLqIWUT8QDJVFzC3ESQ5yqk6guIGykCbEq9UxQuKD0abaXcBN?=
 =?us-ascii?Q?OEv7H3G4AtgiIER1JrXzjzmAuAfgYXJR16Rni0GMfIFEt7TVXa8i66XYjZbV?=
 =?us-ascii?Q?Ka3QkLLCJZD+Q97y3qqkUULn9Ggj9CizMyTHuPd7NTUWK3o0LzYxZ9M1+Xes?=
 =?us-ascii?Q?BRIT6BTFFuLydsmRhlc1wPL+tF9fcT3pJYSnCWknQIbJx1DstUbm7r4uc3n+?=
 =?us-ascii?Q?UPJsgHPAqzR22ENBDwE7n7Y3Pzmlxz03I8PmFgA7H9o4V78+3Z8BXwLGq9ef?=
 =?us-ascii?Q?X1dCeFeH2R2bSFl41Xl84gXwx34C3IpUN4+Cn6ZcpuLyOadtXRIxafLZXjVo?=
 =?us-ascii?Q?eXrxhxzzMkuL6QQ6VVpAvh+3oq9QVt2Mu/4Wl2pDA7/j9zLs+I1WEPVU4CTR?=
 =?us-ascii?Q?zTQgvKuad1rY5ahjQALesLat/tHmKml7zbnXHLYmjLtQctG1LnGnS7/gdZXY?=
 =?us-ascii?Q?9/q/0XZsNABwZ/rs80rmblPbPiNiEi/ZDwTr0E5+s1tNqm49lKBWvja/XOF5?=
 =?us-ascii?Q?V2FqWNJRa/vOhkpJU0VuxExhKGOcY85BH87L+mZwsRURxXL+dNHJ2+GD4KM7?=
 =?us-ascii?Q?Pb3Pjus9ss1r2fIM3TN4PIWStmaA89JuwKKlaiphQ4iS2IkaKQH5JLIArltn?=
 =?us-ascii?Q?GTyT2ZZdIv7rAePPJV25PQnxUPXKwf4yU/EklAl7D0e/bSlnTE3PH1p7j+An?=
 =?us-ascii?Q?l4zQgTyArSZl9EvHpX0ZTV5+hYSmdYk15aWJEqtvQJeRBg1pyZGdjedFm422?=
 =?us-ascii?Q?IjhNMy9R9ZO7CTt9Qk+wKxRroewGvpNaTKI+0ReIJN19KQRO3v5Rpzrqpljd?=
 =?us-ascii?Q?3vlNK95OZQXldbC59xoHOsokSdqviPe8gUyCsIKXq17x09NBIedE1xdocYOj?=
 =?us-ascii?Q?9flCxBoIulBvCp4iah46OA+oeOVEIMso3ynbJYIGnfYPnIJMVgD1WcT6TMiC?=
 =?us-ascii?Q?/+ESSIJm6pgx7Q9C2vCnXcr5IvS40In0DdlK35yxlw+xuchMDxBYn8j1gy76?=
 =?us-ascii?Q?8dgF0cakje49hr/dGaRo/5YCuYTHFDxmguUi2wzg594SBNDAvFNGRkHFKf22?=
 =?us-ascii?Q?0lw2RbLzZrW/bI8CjKr1RBIZBp+NS9WhrMbTy7x3aPZiBXmdHFXX1DINdyEL?=
 =?us-ascii?Q?ZhSzs1vVlf9qxCwNz4aQQJNmo9bl7orQhhjdiJpyoUsGUkNDml2Ueh6aC4g1?=
 =?us-ascii?Q?AvUWxwStQr0mHQs6K72U7RGJwljkhxSi4x/1zZDwEz+kePkoSCf65OR+s4PS?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b96727-8f4c-4f2b-5798-08da558bdb9e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:47:20.1155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4P6+eJKn9b9gKK+73Yt+Z756PZGo+UFEG61HMu8dOWtmdbRl7UuPvTh7wpvvsFOZs5sDTQSYQr+Tv1pbMf8/IQ4yqJ/Sr0gWfhosF7P08w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2789
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

The region provisioning flow will roughly follow a sequence of:

1/ Allocate DPA to a set of decoders

2/ Allocate HPA to a region

3/ Associate decoders with a region and validate that the DPA allocations
   and topologies match the parameters of the region.

For now, this change (step 1) arranges for DPA capacity to be allocated
and deleted from non-committed decoders based on the decoder's mode /
partition selection. Capacity is allocated from the lowest DPA in the
partition and any 'pmem' allocation blocks out all remaining ram
capacity in its 'skip' setting. DPA allocations are enforced in decoder
instance order. I.e. decoder N + 1 always starts at a higher DPA than
instance N, and deleting allocations must proceed from the
highest-instance allocated decoder to the lowest.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   37 +++++++
 drivers/cxl/core/core.h                 |    7 +
 drivers/cxl/core/hdm.c                  |  160 +++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c                 |   73 ++++++++++++++
 4 files changed, 275 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 091459216e11..85844f9bc00b 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -171,7 +171,7 @@ Date:		May, 2022
 KernelVersion:	v5.20
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
+		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
 		translates from a host physical address range, to a device local
 		address range. Device-local address ranges are further split
 		into a 'ram' (volatile memory) range and 'pmem' (persistent
@@ -180,3 +180,38 @@ Description:
 		when a decoder straddles the volatile/persistent partition
 		boundary, and 'none' indicates the decoder is not actively
 		decoding, or no DPA allocation policy has been set.
+
+		'mode' can be written, when the decoder is in the 'disabled'
+		state, with either 'ram' or 'pmem' to set the boundaries for the
+		next allocation.
+
+
+What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint",
+		and its 'dpa_size' attribute is non-zero, this attribute
+		indicates the device physical address (DPA) base address of the
+		allocation.
+
+
+What:		/sys/bus/cxl/devices/decoderX.Y/dpa_size
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
+		translates from a host physical address range, to a device local
+		address range. The range, base address plus length in bytes, of
+		DPA allocated to this decoder is conveyed in these 2 attributes.
+		Allocations can be mutated as long as the decoder is in the
+		disabled state. A write to 'size' releases the previous DPA
+		allocation and then attempts to allocate from the free capacity
+		in the device partition referred to by 'decoderX.Y/mode'.
+		Allocate and free requests can only be performed on the highest
+		instance number disabled decoder with non-zero size. I.e.
+		allocations are enforced to occur in increasing 'decoderX.Y/id'
+		order and frees are enforced to occur in decreasing
+		'decoderX.Y/id' order.
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1a50c0fc399c..47cf0c286fc3 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -17,6 +17,13 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
 void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length);
 
+int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
+		     enum cxl_decoder_mode mode);
+int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
+resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled);
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 8805afe63ebf..ceb4c28abc1b 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -248,6 +248,166 @@ static int cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
+{
+	resource_size_t size = 0;
+
+	down_read(&cxl_dpa_rwsem);
+	if (cxled->dpa_res)
+		size = resource_size(cxled->dpa_res);
+	up_read(&cxl_dpa_rwsem);
+
+	return size;
+}
+
+resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled)
+{
+	resource_size_t base = -1;
+
+	down_read(&cxl_dpa_rwsem);
+	if (cxled->dpa_res)
+		base = cxled->dpa_res->start;
+	up_read(&cxl_dpa_rwsem);
+
+	return base;
+}
+
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
+{
+	int rc = -EBUSY;
+	struct device *dev = &cxled->cxld.dev;
+	struct cxl_port *port = to_cxl_port(dev->parent);
+
+	down_write(&cxl_dpa_rwsem);
+	if (!cxled->dpa_res) {
+		rc = 0;
+		goto out;
+	}
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+		dev_dbg(dev, "decoder enabled\n");
+		goto out;
+	}
+	if (cxled->cxld.id != port->dpa_end) {
+		dev_dbg(dev, "expected decoder%d.%d\n", port->id,
+			port->dpa_end);
+		goto out;
+	}
+	__cxl_dpa_release(cxled, true);
+	rc = 0;
+out:
+	up_write(&cxl_dpa_rwsem);
+	return rc;
+}
+
+int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
+		     enum cxl_decoder_mode mode)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct device *dev = &cxled->cxld.dev;
+	int rc = -EBUSY;
+
+	switch (mode) {
+	case CXL_DECODER_RAM:
+	case CXL_DECODER_PMEM:
+		break;
+	default:
+		dev_dbg(dev, "unsupported mode: %d\n", mode);
+		return -EINVAL;
+	}
+
+	down_write(&cxl_dpa_rwsem);
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
+		goto out;
+	/*
+	 * Only allow modes that are supported by the current partition
+	 * configuration
+	 */
+	rc = -ENXIO;
+	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
+		dev_dbg(dev, "no available pmem capacity\n");
+		goto out;
+	}
+	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
+		dev_dbg(dev, "no available ram capacity\n");
+		goto out;
+	}
+
+	cxled->mode = mode;
+	rc = 0;
+out:
+	up_write(&cxl_dpa_rwsem);
+
+	return rc;
+}
+
+int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	resource_size_t free_ram_start, free_pmem_start;
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct device *dev = &cxled->cxld.dev;
+	resource_size_t start, avail, skip;
+	struct resource *p, *last;
+	int rc = -EBUSY;
+
+	down_write(&cxl_dpa_rwsem);
+	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+		dev_dbg(dev, "decoder enabled\n");
+		goto out;
+	}
+
+	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
+		last = p;
+	if (last)
+		free_ram_start = last->end + 1;
+	else
+		free_ram_start = cxlds->ram_res.start;
+
+	for (p = cxlds->pmem_res.child, last = NULL; p; p = p->sibling)
+		last = p;
+	if (last)
+		free_pmem_start = last->end + 1;
+	else
+		free_pmem_start = cxlds->pmem_res.start;
+
+	if (cxled->mode == CXL_DECODER_RAM) {
+		start = free_ram_start;
+		avail = cxlds->ram_res.end - start + 1;
+		skip = 0;
+	} else if (cxled->mode == CXL_DECODER_PMEM) {
+		resource_size_t skip_start, skip_end;
+
+		start = free_pmem_start;
+		avail = cxlds->pmem_res.end - start + 1;
+		skip_start = free_ram_start;
+		skip_end = start - 1;
+		skip = skip_end - skip_start + 1;
+	} else {
+		dev_dbg(dev, "mode not set\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (size > avail) {
+		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
+			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
+			&avail);
+		rc = -ENOSPC;
+		goto out;
+	}
+
+	rc = __cxl_dpa_reserve(cxled, start, size, skip);
+out:
+	up_write(&cxl_dpa_rwsem);
+
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
+}
+
 static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    int *target_map, void __iomem *hdm, int which,
 			    u64 *dpa_base)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 54bf032cbcb7..08851357b364 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -188,7 +188,76 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 		return sysfs_emit(buf, "mixed\n");
 	}
 }
-static DEVICE_ATTR_RO(mode);
+
+static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	enum cxl_decoder_mode mode;
+	ssize_t rc;
+
+	if (sysfs_streq(buf, "pmem"))
+		mode = CXL_DECODER_PMEM;
+	else if (sysfs_streq(buf, "ram"))
+		mode = CXL_DECODER_RAM;
+	else
+		return -EINVAL;
+
+	rc = cxl_dpa_set_mode(cxled, mode);
+	if (rc)
+		return rc;
+
+	return len;
+}
+static DEVICE_ATTR_RW(mode);
+
+static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	u64 base = cxl_dpa_resource(cxled);
+
+	return sysfs_emit(buf, "%#llx\n", base);
+}
+static DEVICE_ATTR_RO(dpa_resource);
+
+static ssize_t dpa_size_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	resource_size_t size = cxl_dpa_size(cxled);
+
+	return sysfs_emit(buf, "%pa\n", &size);
+}
+
+static ssize_t dpa_size_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t len)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
+	unsigned long long size;
+	ssize_t rc;
+
+	rc = kstrtoull(buf, 0, &size);
+	if (rc)
+		return rc;
+
+	if (!IS_ALIGNED(size, SZ_256M))
+		return -EINVAL;
+
+	rc = cxl_dpa_free(cxled);
+	if (rc)
+		return rc;
+
+	if (size == 0)
+		return len;
+
+	rc = cxl_dpa_alloc(cxled, size);
+	if (rc)
+		return rc;
+
+	return len;
+}
+static DEVICE_ATTR_RW(dpa_size);
 
 static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_start.attr,
@@ -241,6 +310,8 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 static struct attribute *cxl_decoder_endpoint_attrs[] = {
 	&dev_attr_target_type.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_dpa_size.attr,
+	&dev_attr_dpa_resource.attr,
 	NULL,
 };
 

