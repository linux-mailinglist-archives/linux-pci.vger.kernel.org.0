Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF4E623A79
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 04:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiKJDbQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 22:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiKJDbI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 22:31:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE072ED77;
        Wed,  9 Nov 2022 19:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668051065; x=1699587065;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4I8sc8jUq+9aF97KjuhlcVlqbzsmDp6dCbE2hmVhT+E=;
  b=WpJYkUwq3dLEY3Nh80qJfJlj+JWDqm03KIRuYXH7YBsCKg6PQu6gmCjl
   yk84i5bkv7pNPhWm8i11Nfchl0PZTV9w2TEPruwsmgL7vVE0zfP5PkTTg
   pXnFY/yTfGPZCXxDg+ZqMQITnH5DoDGDdGYTSa9eGPC04lqSnHUylkzD8
   KdR9Fa+SUyFn+24NXmNDaycgMClo03O6wRGzffI3OFcmDRrRq18vT6RGK
   v83fYnzYONKLIkMc2vwgzPvw/bdCmNzgwmgblPaDM1LsiWpYnq6ayneQ4
   4Axor93S25LH+bU9nvlRe6i0q1zlnsPfFs8CwNCtbndf/R8v8hf5Z7cP9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="337948340"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="337948340"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 19:31:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="639447803"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="639447803"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 09 Nov 2022 19:31:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 19:31:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 19:31:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 19:31:03 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 19:31:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrP/ZQElVrALgx7HgBeM2Edc52Ipuzuq0Vupfwi2oH9IzWFLvBTFONjHXXEj4J5rIDSQY7TDpyqLWH+y90D3IdYOYp3qhRy3vsXwBzAsCf6PACUDNBsd013tcRDKN0fllkJADVZEI7PvcVVesTRUC0NqTKF3UVWCmMbtOwTXM/WmwxZheAPllhtszZ/SqffMdSk62njx/SL+Fc5nSZKERNSuKwMx2g6Egtlvq2/VuD8iqcTOqThZTNa5PIOLVPCyMsNpeAfZf+KsDCX6Y+yjjXW92yTO6MFKeFscpqq/4PVBd6o2ELPwClz6lgMDV/OSEqdM6m5nXSuLLe9JOFzRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyCjCyV7N/sOeRbxLTk9KDmdcW0TOoMKv0aubxDssBQ=;
 b=heEhJpFzJ9jhz1D/idIE0XBv1MhhQ9F6V5E7GASksYW2iJK/mkKWXQERUq3fwDAG5mae1b+X+S/gY9mhm03bCUJ0RXTGrL2pAztbtESlR9ClYRrzGuwcriMY70JIMF3aVu8E40gA573334yAYDKsNbgYREBFSYCfxHQwz0LhKxndxfG4sfPUXgJBbvgrxw4UzhVR0mWtHlmH8o9Ktp1L6R4xwN+zV/nDHKaC5PqUWLNVq8HaqTaG/XkzTmNpSR4YzOeZP4C9NpncpAxI9JqdIWmFfKxDJqZvhRWjM/6EN/D4aFgrauyZJQP6KJ7KldKIvQ4bUlvDMWR3/+sdMt4hoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 03:30:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 03:30:59 +0000
Date:   Wed, 9 Nov 2022 19:30:53 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <Y2xwbYEKKc9KXUDy@iweiny-desk3>
References: <20221024133633.00000467@huawei.com>
 <20221025232535.GA579167@bhelgaas>
 <20221102171524.thsz2kwtirhxn7ee@offworld>
 <Y2MAdaCES+aUc2QH@iweiny-desk3>
 <20221103001833.n2gsoflnji3pcsfr@offworld>
 <20221103180916.00000bae@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221103180916.00000bae@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: 884bd3c7-e2e8-43ff-5c00-08dac2cbfc65
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWa1W/VX7HsirYZp/BrGOIb83vFmf2OttbFwJ5NtcsDlZO86c9H3gfs//sd1kTFbOghCCGGC58SZC/601zJPvfXjfnHkr45MXqLyP6Pn1TS73Ly83W9kFtzS+vIMrmFVlDRen0y/LsE9hzgbZHtjuBwXpd8O1OammJvz0UyB8ef/VBJLlyuPZUAeeYR0fUVEAJTX8wZWC7IhRfXvtaaeF4R/9k9PYo2q7XXN6WevRWa2M+qloquUtNWowt0ST0a1tGaTfBTyhY/5t3s59AvpQI24AhYKXfa46LTKv2m5/ennoIBOzy1mq5p9LUM/Oz9vDq/YXVM/tUoGg3kH/rmo8aRQbBRyEXCbQocNFSkoiZWocR80oHolkzpPvwicxy4GBCIPDr7FU53d4ZVIE2Kwwf5q/Z8dvAwJ/AWLZa7bIUUEK+t0/LgBW7DvyYCY73fAK2bqMOWQb1Vn4rKmK4QNmB7vFkLJVQ2/uUDe8wf5svu8zj/AKYJRsXyDA+KCzxd1mlmf/EZq9PZp+NZIqqLRJZP32RucJi0Wqkej4NA6wFua0wxgX2Wu7r3qZkEC9jMTu4ARpDCxGtwEbUnwxbHiU+/CTS5L4AQe+URWbpLp/IsEdRSd+REZfyWB3iR9EN3g51eOFkIdiJvNbR8RBHkxwDicWt+nUm82Hcu8FaPMC1iU8BAvyaL/rRgYB7VPC+f/HutRsZ/xaeTwGLQs/lsRVKD/VST9ZZqa/6X/kHLnjinYsldBznIP6R9gqdYeI2Em
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(66476007)(66556008)(38100700002)(8676002)(82960400001)(53546011)(66946007)(316002)(4326008)(44832011)(6506007)(83380400001)(2906002)(41300700001)(9686003)(186003)(6512007)(86362001)(5660300002)(26005)(7416002)(8936002)(6486002)(478600001)(54906003)(6666004)(6916009)(33716001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CVUIclMQSFVc9k8BtHfuDOYWGjdzI36KnpSXS12TFBB6aSgi9Jyc0ubOo278?=
 =?us-ascii?Q?UTPwGlNv9Idjly/lIgUpH7wXiGCt/xtTWqETaIofBKXA8RL3ZU80Glu2848n?=
 =?us-ascii?Q?3en33poC5OYWS4lUyv1Aeo4Jm2+/SXJAn/6rDxYBpAVhY0OYBa40G7F+Dd+x?=
 =?us-ascii?Q?YoUlyTm2xpmkX0T+QnN/bhJitQEWPZe1TXF5hzmmolr+o/Ci4qrskvZc2Cwr?=
 =?us-ascii?Q?Gpr64uFn223ZkoxSEhHeZZsq+Ca/ujmotd1j6faLGSHleGmDTlagI0yn7pCf?=
 =?us-ascii?Q?q7UA8C0AKvYwuckgztFATJLnV8OM4ZxMtW29FmCq7Kg7LmgIYEnceiiWi7aC?=
 =?us-ascii?Q?BKP1/w3yT2+0DUeSgZTMI6Uy17lrsNoMWcxdj4cdym5mXtQFtHYJZIXellMV?=
 =?us-ascii?Q?YyzJEVkRm6RlJf9ZcUXKG54kS1ZY9wIho0IaXMkp++Hd7ENTa8xzlaLXlEM+?=
 =?us-ascii?Q?dRHf4vkVAsEFdfz2A+xGuxqA+VdvRLRJauVKBbAjA2fkoI0t9pZIf4WL6tZ3?=
 =?us-ascii?Q?xqvEdW/682m97y/q5hK28q8q/OKr0K+xp9xSFF65cVrHktOFwV1IQvlOTfgf?=
 =?us-ascii?Q?dpFSMd/7Ry+YzmuN/l2ltAgsKveq9iFDqenmFDmjvNmSw0zIU+bZbzXP67au?=
 =?us-ascii?Q?YE7G9IyuPP0VCWrhVYE4rIiRTmz5FcKYd1j+rsOPYDwVfMKShU+PR8sJcTtu?=
 =?us-ascii?Q?nkqZaSdUrk+wFaK6P3+wKoR+9ER1y0owaepM6oKXoPz2ALmX4pfnYBcr6Nz3?=
 =?us-ascii?Q?WUQgjntly0fvbEYuXNbwZUaBdgkxn2BrnTNZiexYDmSz2QZFc6bVyZeA6fds?=
 =?us-ascii?Q?VxzvnhPvTcEXFcdf2y5T9B6de+ET+9pW+tq5MA847b4+QjY+E2a+1DXzjxTt?=
 =?us-ascii?Q?3hsHVsdkKMylJ7sK1Thl22vxqyRXdMUBDzDF9KnCKQVyaNi/3yBj1Fw5iHNf?=
 =?us-ascii?Q?npMlILEerzR4wwlEnaWKYRakE56uOc9Y2XjWFA+lmXHP0CH39wIK1BiYhiJJ?=
 =?us-ascii?Q?86OoeGkGh5mCDelJsFkb7YGcDlXM/5mqlx1pEjVGhA/1SV7VLrTrbxO7IB4s?=
 =?us-ascii?Q?iMlY/r/79MsWxYhRCaxIosBWaIoN++iaSbm5sqkDyRKU20bIGgWxvWblLZK6?=
 =?us-ascii?Q?FXZPrhfDMfP5Q/PnXBr4/JR+KvmwYGU/7nUMiNWyjUq47+jiko0FvrBGKhdP?=
 =?us-ascii?Q?lOU4Mv2cPXwAcMBaAyyZj7PQUvy/ifLhPMQ7MWvs3tjBzmQ6J3cZ1CcN2Mcc?=
 =?us-ascii?Q?7RNr0CkzLuarJ0FXsaladiEOasdULDQIhePP0BlN7LjNBQLo2vbPjcFDbKGM?=
 =?us-ascii?Q?eAuEknhyPTkritrWqDAG6Ta2YWrdxknBXDgSERJ0IHvPe9PnKZu5Vb14lvkh?=
 =?us-ascii?Q?tY4ldNpNUMZker9w2uat7GkA9nwYpSfmxkiq88HAnNy5GmWoPgp64AnFWuAK?=
 =?us-ascii?Q?CdigwV/WwkAtIGZIseOjSeEYfUh5DgqdSnAXbxj52Rwrjn1ZcRQ73ZuIiINn?=
 =?us-ascii?Q?jUZ6NHNOeKkXjFwLat7uovIEj48r9cqiCwKgM4QozOx1SrG9kB3gkNeuBnuC?=
 =?us-ascii?Q?CfMado8Ti5QEvgaX0njp/lU66K06fuOy/oFD0F/9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 884bd3c7-e2e8-43ff-5c00-08dac2cbfc65
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 03:30:59.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvlVG+8Dq9ULTZTVTjDjWrAV7Hlc0jPb552RkfgOwX3FNYgSTWMm+zb8N3RxeHcBeXBi8gSw5Eutd1cs5Or0Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 03, 2022 at 06:09:16PM +0000, Jonathan Cameron wrote:
> On Wed, 2 Nov 2022 17:18:33 -0700
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > On Wed, 02 Nov 2022, Ira Weiny wrote:
> > 
> > >On Wed, Nov 02, 2022 at 10:15:24AM -0700, Davidlohr Bueso wrote:  
> > >> Most CXL features that can have irqs will normally use only the first 16,
> > >> with the exception of isolation (cxl 3.0), which per the spec is up to 32.  
> > >
> > >Dan, Dave, and I were discussing this and we agree.  For now the only things
> > >people are working on are within the first 16 so why not just request 16 as the
> > >max for now?  
> > 
> > It is a fair compromise, yes.
> 
> works for me.

I made what I thought would be a simple change to your patch and built this
into my series.

Unfortunately the following does not work with the current Qemu.

/*
 * NOTE: Currently all the functions which are enabled for CXL require their
 * vectors to be in the first 16.  Allocate this number as the min/max.
 */
#define CXL_PCI_REQUIRED_VECTORS 16

...

        rc = pci_alloc_irq_vectors(pdev, CXL_PCI_REQUIRED_VECTORS,            
                                   CXL_PCI_REQUIRED_VECTORS,
                                   PCI_IRQ_MSIX | PCI_IRQ_MSI);

This is because Qemu CXL devices only support (with the event changes I have
made) 8 msg numbers.  So the code fails to allocate any vectors.

I guess I should have known better.  But allocating something less than 16 I
guess needs to be allowed.

But that also means that beyond knowing _if_ irq's have been enabled I think
each CXL feature needs to know the number of vectors allocated so they can
ensure their msg numbers are going to work.

So how about the following as a diff to this patch?

In the event code I have then used the nr_irq_vecs field to determine if I
should enable the irq for each log.

If you are ok with it I'm going to squash it into your patch and send out a new
version of the event log series.

Thanks,
Ira


From 105561243c800442a2b7ff39b931e73b0a89bc34 Mon Sep 17 00:00:00 2001
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 9 Nov 2022 12:35:07 -0800
Subject: [PATCH] squash: Allocate up to a static 16 vectors.

This covers the current desired features which CXL needs now.
---
 drivers/cxl/cxlmem.h |  4 +--
 drivers/cxl/cxlpci.h |  6 ++++
 drivers/cxl/pci.c    | 68 +++++++++-----------------------------------
 3 files changed, 22 insertions(+), 56 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 78ff6dca3c4b..03da4f8f74d3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -212,7 +212,7 @@ struct cxl_endpoint_dvsec_info {
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
  * @doe_mbs: PCI DOE mailbox array
- * @has_irq: PCIe MSI-X/MSI support
+ * @nr_irq_vecs: Number of MSI-X/MSI vectors available
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -249,7 +249,7 @@ struct cxl_dev_state {
 
 	struct xarray doe_mbs;
 
-	bool has_irq;
+	int nr_irq_vecs;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index eec597dbe763..b7f4e2f417d3 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -53,6 +53,12 @@
 #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
 #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
 
+/*
+ * NOTE: Currently all the functions which are enabled for CXL require their
+ * vectors to be in the first 16.  Use this as the max.
+ */
+#define CXL_PCI_REQUIRED_VECTORS 16
+
 /* Register Block Identifier (RBI) */
 enum cxl_regloc_type {
 	CXL_REGLOC_RBI_EMPTY = 0,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9dc32b802594..e0d511575b45 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -428,71 +428,34 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
 	}
 }
 
-/**
- * struct cxl_irq_cap - CXL feature that is capable of receiving MSI-X/MSI irqs.
- *
- * @name: Name of the device/component generating this interrupt.
- * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
- *		    feature does not have the Interrupt Supported bit set, then
- *		    return -1.
- */
-struct cxl_irq_cap {
-	const char *name;
-	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
-};
-
-static const struct cxl_irq_cap cxl_irq_cap_table[] = {
-	NULL
-};
-
 static void cxl_pci_free_irq_vectors(void *data)
 {
 	pci_free_irq_vectors(data);
 }
 
-/*
- * Attempt to allocate the largest amount of necessary vectors.
- *
- * Returns 0 upon a successful allocation of *all* vectors, or a
- * negative value otherwise.
- */
-static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
+static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
 {
 	struct device *dev = cxlds->dev;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	int rc, i, vectors = -1;
-
-	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
-		int irq;
-
-		if (!cxl_irq_cap_table[i].get_max_msgnum)
-			continue;
-
-		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
-		vectors = max_t(int, irq, vectors);
-	}
-
-	/*
-	 * Semantically lack of irq support is not an error, but we
-	 * still fail to allocate, so return negative.
-	 */
-	if (vectors == -1)
-		return -1;
+	int nvecs;
+	int rc;
 
-	vectors++;
-	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
+	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_REQUIRED_VECTORS,
 				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
-	if (rc < 0)
-		return rc;
-
-	if (rc != vectors) {
+	if (nvecs < 0) {
 		dev_dbg(dev, "Not enough interrupts; use polling instead.\n");
+		return;
+	}
+
+	rc = devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
+	if (rc) {
+		dev_dbg(dev, "Device managed call failed; interrupts disabled.\n");
 		/* some got allocated, clean them up */
 		cxl_pci_free_irq_vectors(pdev);
-		return -ENOSPC;
+		return;
 	}
 
-	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
+	cxlds->nr_irq_vecs = nvecs;
 }
 
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -561,10 +524,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	if (!cxl_pci_alloc_irq_vectors(cxlds)) {
-		cxlds->has_irq = true;
-	} else
-		cxlds->has_irq = false;
+	cxl_pci_alloc_irq_vectors(cxlds);
 
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))

base-commit: aae703b02f92bde9264366c545e87cec451de471
prerequisite-patch-id: e3c882f3fce0872c2259538d00ad798236ec251f
prerequisite-patch-id: a8faa71e6d79cb30eae9b863349f0cb5ffa55b05
prerequisite-patch-id: f8e6edeb4a1d8bc4b34a509cb3d4a625becdf1b3
prerequisite-patch-id: 665a2b5af761a3f50e20da2fa8e5fdc9df13969d
prerequisite-patch-id: 5cd9f56597f9c8637201193849f68811a94d2309
prerequisite-patch-id: 89be9f2bd84118682b9b37e4f3a6e057fd4ad0d6
prerequisite-patch-id: 3de731a18a28c32572bf65f38e8eb2fb927e4f56
-- 
2.37.2

