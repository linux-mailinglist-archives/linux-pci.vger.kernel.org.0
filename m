Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741444C498A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 16:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbiBYPuZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 10:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242321AbiBYPuZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 10:50:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596261BE0CC;
        Fri, 25 Feb 2022 07:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645804193; x=1677340193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DNrB1zjz6lR2HM4GwMtv1uDsRQnAZcKdTXb9/LCxKm8=;
  b=ACQ/i69Ezep0naXNSDW+ybueoCWTRTyZZyhbx5A9Y2aHV196FJKe5gqk
   bdkStxSg/cRGj0A+IzFGJd66BfUQI8yjG4Hxj2VLR3iUBlKo3OGwVwAs2
   ZPYsokGsoJPOanNGLHfMmOiSY/SAY058SaXErlI+BmqXFg2zwkIYKwibl
   qMK9N1KNypoZSRPUqfLpnFG9v3slzrCpPxwh7TXLpZ4ayS9qIvDO0iDsm
   mQgehwj3kQ6mmWJPkwY3oOSYDvVUhbS3M/07UNkbdzzPACwYSV1K88l3l
   0eXfodRJfR9yH8FAywa7SxibblzrFkZOWn7Cn/KOI4Fs6BNc7CINHb1SR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315735474"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="315735474"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 07:49:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="592518949"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2022 07:49:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 07:49:52 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 07:49:51 -0800
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.2308.021;
 Fri, 25 Feb 2022 07:49:51 -0800
From:   "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "logang@deltatee.com" <logang@deltatee.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Subject: RE: [PATCH] PCI/P2PDMA: Update device table with 3rd gen Xeon
 platform information
Thread-Topic: [PATCH] PCI/P2PDMA: Update device table with 3rd gen Xeon
 platform information
Thread-Index: AQHYHdIG4Q22z4JZ0Um0Xan5JCcwz6ykgLnw
Date:   Fri, 25 Feb 2022 15:49:51 +0000
Message-ID: <f3fa3b81b9e14025ae28c490ce53006c@intel.com>
References: <20220209162801.7647-1-michael.j.ruhl@intel.com>
In-Reply-To: <20220209162801.7647-1-michael.j.ruhl@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I see that this patch is in the Linux PCI development patchwork.

I am not sure what the timeline for this process is.

Will this be accepted or rejected "officially"?

Do I need to do anything else to move this patch forward?

Thanks,

Mike

>-----Original Message-----
>From: Ruhl, Michael J <michael.j.ruhl@intel.com>
>Sent: Wednesday, February 9, 2022 11:28 AM
>To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
>bhelgaas@google.com; logang@deltatee.com; Ruhl, Michael J
><michael.j.ruhl@intel.com>
>Cc: Williams, Dan J <dan.j.williams@intel.com>
>Subject: [PATCH] PCI/P2PDMA: Update device table with 3rd gen Xeon
>platform information
>
>In order to do P2P communication the bridge ID of the platform
>must be in the P2P device table.
>
>Update the P2P device table with a device id for the 3rd Gen
>Intel Xeon Scalable Processors.
>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>---
> drivers/pci/p2pdma.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>index 1015274bd2fe..30b1df3c9d2f 100644
>--- a/drivers/pci/p2pdma.c
>+++ b/drivers/pci/p2pdma.c
>@@ -321,6 +321,7 @@ static const struct pci_p2pdma_whitelist_entry {
> 	{PCI_VENDOR_ID_INTEL,	0x2032, 0},
> 	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
> 	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
>+	{PCI_VENDOR_ID_INTEL,	0x09a2, 0},
> 	{}
> };
>
>--
>2.31.1

