Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD4E6C73FB
	for <lists+linux-pci@lfdr.de>; Fri, 24 Mar 2023 00:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCWXUm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 19:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjCWXUg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 19:20:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2103DAF19;
        Thu, 23 Mar 2023 16:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679613635; x=1711149635;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y45bgVg+V0AiOBLKUFL3LTB2z/199US4q7biR6L56Qc=;
  b=JqDzaFT2H0lzv0mR5ORlPV25ZlTVvJ89H6xTog9TrLR9IiPkjJO4ukAE
   OYqihz5fwop9ORGeQ5RkGtDQT0qvPmfIKsnkbwAFgNs1j542PlwQrKALn
   zV4Dox4RyDKIxIgDvuVbNnpwDsWdXob7NxRlQOZglQRTmBTxShGt+snx7
   1tLQkc6qEUDW3AFL/VBm3RpZBajzDJFOFSt8MxSejAtjXLHy9bHm05US1
   mXORFMWywarZeHjETWavbUNTT0lNnu76VqOXFV6HdpoBJctoq+8FtMyI7
   i0P6YZOozQ1fuf3kZhkszBEX3Sa7IcyYjY8E1M3jDHZtFtEDCzfTP27Ke
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323515743"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="323515743"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 16:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="928422329"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="928422329"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2023 16:20:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 16:20:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 16:20:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 16:20:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTGtF0XDC5rEs42XopVjd3pEFweBW1kgQ/GkXBWR4YuWXPwmbsNBlCARoJgXUoplmhJw9Abb9lgF3ldKwas6xeIbMQzRJCRm0/nKvYARA/9TwWvbdCHM2B1kSD4GcWLv69zc+3wq+w6+jNzQyQD9ASeLSuh+B4FpxbCDenEHpsuXbNpNJqz6eJOEmuCqZTlqe/wfGS+biDS67l7kYR3EcbN3C7iz8UH/Gp0lnLElE/16gKajSuwo5yT4hqObovLERvKbD5iJ1sPf528jvT4km8sX8Pj9X9kxebNQO1trl5DXF+8WcIw4BKz8PE5l5frdnNU6Vkvuaf1Q4bhIiU93IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsK9QeWv1GtBmtBkrImSKuo+Tx5KRo5wB//sgNlwk50=;
 b=gJrZrTONVqG8sUyFgJCZNA/HQy1hoFd2/JCaj+M38Bm3jgzfm7gx419xVKLYrO39rjWXzyAAgdA0s3wiW0TU689srARFJjba7zQGIFMfap2vcKBxLStkRUaPO6rXSwP+4QQqUShrCy+nWmb4/wT3cZdabH2VD0cW037k2QZGljgRdq2EHNAs/XwuQCvPYaCigMVCtVL05XHWVXR1aziGndWOkXFACXX3cbA7Redo1LcrxrbGxg2Zt/ldOWw7po4wP0cGq0OgtreBh1CnyrbCgzqHoq4LE2MJsfY7lcMJP46HkJlRGDsAwRzGBgWtUkYmX3UhXH/eM8eBkDxs8+hP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6496.namprd11.prod.outlook.com (2603:10b6:8:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 23:20:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 23:20:29 +0000
Date:   Thu, 23 Mar 2023 16:20:26 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 18/18] cxl: Export sysfs attributes for device QTG IDs
Message-ID: <641cdebae1734_1d657a294f7@dwillia2-xfh.jf.intel.com.notmuch>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571672370.587790.13206197631776290440.stgit@djiang5-mobl3.local>
 <20230209154100.0000059d@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230209154100.0000059d@Huawei.com>
X-ClientProxiedBy: BYAPR11CA0061.namprd11.prod.outlook.com
 (2603:10b6:a03:80::38) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: c09d1244-0634-4226-c774-08db2bf530e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/RM/1cD5YVO4GlnWuGsUvpYOwW3b2jT53l1tzADwqABtp2TqHueK7kcvXeXm1EUj+HmXtXHIvlBDejMJC16+DbrXDBsZPnfWCaDfkyDobvK7eSnBNndG4OsfW+jxqx7hQEkh0Pxb9cxRSYtPcu/skCv+1zqCaWN3fdUWtvHWmC8ZNyz0MBq3m+cXBj7LTvxF5QQ+Lq6MlwsYOy1+JZiC3zv3fmazoe7mC1VykuGM0e5ehokXwh5ar+UR6FbQvPEnJJOvyWmuk32ItRxEJ6Ft6ud1jBCXx2NhZEntueiN/kBv1utUK9e5/u27cprFMkrX8q7Fv2g3hBnnztsci3WKAxILwSsyYvOQ94enmJVOdzm3+oHcxTYtdHwsnhD4AeXrtYnMsBF+AQVQ8p7dEszQhHncKCguGHt7CKtVkRKJ4bNkAQOhf5r8F56AqYTYofDQDNk3qt2HnDGCn5CRprOgvFGJjeO8VFDx4kR9/tWzoB6yaTk5IIkpzp6VQ12LrNlzMRWWA3Wd1Y4WiA8i2gijKBtDledRKplGGZx8niUhX+0qe4Hzd2nr3u6MpSZFzTSAVdLODzxTTJWmv4WDMaVRGMdsnl//Hhcs4ih3LC73gRUI8CzJmsYrYyDH0vWJBKsVPHqNYaL2auG4HB9fjSiHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199018)(66556008)(8676002)(66476007)(66946007)(4326008)(110136005)(6636002)(41300700001)(5660300002)(82960400001)(8936002)(316002)(26005)(6512007)(6506007)(6666004)(107886003)(186003)(478600001)(9686003)(83380400001)(6486002)(86362001)(38100700002)(2906002)(66899018);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sdtuoe33bX6R4BQmhL6KBAS4Lo55lOJIye+dQKkHN0iE03BYisq7KSCgETjp?=
 =?us-ascii?Q?7aBL5/6tlbscjaRTQ5YziOvHgrJ6yzp5ZwZ892bqaQrdnvUQJiNt+0SySwUq?=
 =?us-ascii?Q?2m+s3Z7sWbTcgtt0C+78Adl/CwOLx7eMg/LRp8BzUuGY/EKvimdPE/o+74rW?=
 =?us-ascii?Q?tqzoaXlTyz+xPnowm4xRj0hJVcCx0VAijZSCuKjWu4kNOsMRLCxx8qm0rHuz?=
 =?us-ascii?Q?Na3hYQBsRhgobMh+65O7BvXIBjgQ3qeayZCxQgHkfvVjcgJqBDtQVcQIHWsv?=
 =?us-ascii?Q?ujL4o7XBPArVwgvBanaEwkNvkAfwZmqUJYfdcVdWy221K9jtvbDSJzL//knF?=
 =?us-ascii?Q?z+gH9sPqvJmSCF3f8if9KrAwfsQMm8m0/Fw5/iRenAlkX0rxQqUPFAg+bhlT?=
 =?us-ascii?Q?I7jmwEACu9PWA8maQuZVjTTkr9888EWD8QDR+B+SLZsMyWsx9xORmg2+R+5+?=
 =?us-ascii?Q?xwyftM9ESsgwXR1tqRZveiblvj89gDoDhu/f9MLV4T+LdZDp4oEOD6mzY55J?=
 =?us-ascii?Q?yi7WQYssQgUoBrCzfHRyBgvcqsA19dgP9qMxrk0t0gUt17jzAnwNYR2N7m0C?=
 =?us-ascii?Q?qgAx+0Pl6UyXbJx/5+EpxLYIHlkiQZ7FLK52BFbt4xMf0Lq0CdJDgL4Zhqps?=
 =?us-ascii?Q?Vt2WFzgfuU5nFlzfoNtyvdknpORpH6FPeRYVkdzF1NSQC1SGzyzYs6UvSXYM?=
 =?us-ascii?Q?t7p4M6wyK89oOkXadgLjTsQHBVPbs2AJfoi4tnqStiYEXc9zWVmKLm2vwrW4?=
 =?us-ascii?Q?G6DNMjqTXIFST0uhRfh0t/4g94MS1Oq+jK0s41cZfPwJlkfnQ9Y9S33+ltOv?=
 =?us-ascii?Q?L61I+sliC58k3t9vIBau7Qap0P4SlvI6DxNs0pFF2jigruNLcVVFxTcoRtzB?=
 =?us-ascii?Q?n/gn2bgtqkvKuWdnBn38Bw4HfNcsx7DokIOXZMXZh0yLuR7DJsBZhiVZxWUQ?=
 =?us-ascii?Q?Jkxz+ccL+kZGpuTadihkvtk1EFlaqgn2q/INe0zq4cqSgxkvm8AZf4BxWaUS?=
 =?us-ascii?Q?iVoivdbA7mqypBTGu5vPAj+JuwINGd/iFQmGrOk3SonqFxEDQTNSlYVibupn?=
 =?us-ascii?Q?siSMFVLUL6GpX2yDflJAut3r1cBvz6X/RHyabDhGBKyOm/6WUtqouJxYMAti?=
 =?us-ascii?Q?K4LD6h7J/LPDpNo2AJZWVZtRNQNlZ8VLkrH1DhOi450ti4XJbSQSBFphB1Qy?=
 =?us-ascii?Q?f/P5bRYRMmvQp70jAgVoLKQLuMf/31+wop0ilNtTK12wmjrjV0A28r+95QU8?=
 =?us-ascii?Q?lbYbgEgkc+ENKAFVt+ohpFhfC2+2jpjIOMwbpWehjajhl7LpYO6+kRPGbdIo?=
 =?us-ascii?Q?bXJeXyPgung9iwv3SQwV9Du31DDS2PPDxbFm+/OfvTpTQjR4zh2+hliBdPVq?=
 =?us-ascii?Q?sih5YONT8S0WfIDRiEyHa/nGnsrNU29nJoGhoISW7vsEfC3GXcb3q0Si9C3f?=
 =?us-ascii?Q?lHGwi9H2Urg5N/y0ldIcP4zgo80JGqec2xkRZfRMCF7b/YxkrFzdWgzzIWCI?=
 =?us-ascii?Q?PULxKZXiTqcJn+ZGQYtiy8zPdNwizrA863ncO88gRhfxEdtlEqQV5bcP53Je?=
 =?us-ascii?Q?jxlbGRXIdkqzgC9e3NizrpVFI+l0ulWQQ1XiBHkPacxuLGxUdNJDBu8xDy5y?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c09d1244-0634-4226-c774-08db2bf530e6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 23:20:29.3126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENVrx5SXb/SfxP2poHTJWAD3HCfzLCgViml4cOI35+o0oUDtZ07rTHef0w1sE84vjWFTyr4nobAlRJqXRZ3IW2Bwlo06cKcVC/yBusow8yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 06 Feb 2023 13:52:05 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > Export qtg_id sysfs attributes for the respective ram and pmem DPA range of
> > a CXL device. The QTG ID should show up as
> > /sys/bus/cxl/devices/memX/pmem/qtg_id for pmem or as
> > /sys/bus/cxl/devices/memX/ram/qtg_id for ram.
> 
> This doesn't extend to devices with say multiple DSMAS regions
> for RAM with different access characteristics.  Think of a device
> with HBM and DDR for example, or a mix of DDR4 and DDR5.
> 
> Once we are dealing with memory pools of significant size there
> are very likely to be DPA regions with different characteristics.
> 
> So minimum I'd suggest is leave space for an ABI that might look like.
> 
> mem/range0_qtg_id
> mem/range1_qtg_id
> mem/range0_base
> mem/range0_length
> mem/range1_base
> mem/range1_length
> etc but with the flexibility to not present the rangeX_base/length stuff if there
> is only one presented.  For now just present the range0_qtg_id

I do agree that there should be some mechanism to dump this information,
I am just not yet sure the should prioritize for the case where someone
builds multiple performance classes per partition type. There would seem
to be design pressure against that given you can not allocate regions
out of DPA order otherwise capacity gets stranded.

So I am thinking something like a debugfs interface to dump all the
ranges but otherwise leave memX/{ram,pmem,dcd[0-7]} with a single
qtg-id each.

If it turns out later that devices really call for multiple qtg-ids
per-partition as a first-class ABI then there's the option of something
like:

memX/ram/qtg_id
memX/ram/qtg_id1
memX/ram/qtg_id2

memX/ram/qtg_range/
memX/ram/qtg1_range/
memX/ram/qtg2_range/

...but I hope the primary use case for devices with multiple performance
ranges is due to having 'pmem' or 'dcd' in addition to 'ram'.
