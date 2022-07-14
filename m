Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EA257560B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 21:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiGNT6s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 15:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiGNT6r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 15:58:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99572718;
        Thu, 14 Jul 2022 12:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657828725; x=1689364725;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tDoi/H0ETQFawRqc06j0JNMJWRDLQ5gApWclVkeP1xM=;
  b=fevWNrHhPEx321KulYlaESJADv47Zrh1jugJZjuInbiSdsSBdSJAU4Bf
   2EyOhFqhOQNMrDALz86kGMwYnnHYHgLukF1EMmUlH6oRS8ZW1bl0+Nony
   hPCnRv2Rd9bLoDfV+aMV+akh2dvjRHeHnAslOhO84Y+EHNTj6Ml2SWO/r
   zjGmnRxmfnTYDPjMAvHbvqcQS8+Hkc5EgLJq+mFQrQJNoj6T6jU1GRgmc
   q8kbwFt3ly4YLPYUGIF8eoAY9VC4T356b1vOgHAykb2cOu5eZ7MahjV5Q
   leyP+KBiwoTXhDYCkeiV08DkeZibLN0t45WXuA+Z5turGgdVM+mWH07RI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="349583828"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="349583828"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 12:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="685699092"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2022 12:58:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 12:58:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 12:58:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 12:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJi7ETP67Wu6NS9ZWfTc+32c4i66xS/15mkM7i/AoQOS5N61dkbMHqIse3O6TbUYjm+d4C8FKExD9HDbXn+KoIyqj39Y/yKhG+4w/t7iSzw47o+P5ROGoqRlwyyXmoNbllu8aWhXU36gsjDNK16ST69hb5n2LJ1/i9eCyYr/qWX7hHmv1hxQ05U69GIcUmlopXutJjXQPPjZmbreaaKDAe4XsvRmJL9Sel8iWdd3Du0cSVqTUoS4Z1NoT3laoY02VnoP+XejJ/X4oJaONGKPiPTIAbVyzXfsagxJvOeBCv3JrrB5HHmjDKp3AdxGK6ngbyvBhWS6Px1gc3j8nv5cYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ykKgakUnzu4hyxgz5Ssn9B0R6gY2vCEourZGPunZjM=;
 b=S/zU1DXwhlnRG/M7s4cDTT1JlbCMix8I1Cx3fj5Pw+FtSNOVeYm11HIDSejoLtf7xGYpw6+W5euUWcKGn8ojM4yBl+4Wlq0t3fcqUTNqV4/a31eA7QwSJvTeaKbQkaMFuBA865yJTzi4XVtd3v2L/2mR171CLL1VGcgLqYlCwP4henTECqxP/BpU0I00FDd6SwpZ49/uPzJ5VVI8hyFQ46EPu0e0VuJgcFBLHbLwOYdn3vFK3BIOiuoM5KbDuuTdALV+XJJytGdBTAcC4jwqViCXeAKTiVkUGGxGQwBYpKN/PO7Ulmb1dxiAVK58zzQp6MczvCRn009THKFFs/smhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM5PR1101MB2124.namprd11.prod.outlook.com (2603:10b6:4:55::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.25; Thu, 14 Jul 2022 19:58:39 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%5]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 19:58:39 +0000
Date:   Thu, 14 Jul 2022 12:58:32 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V13 9/9] cxl/port: Parse out DSMAS data from CDAT table
Message-ID: <YtB1aE/xUnoeuOtp@iweiny-desk3>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-10-ira.weiny@intel.com>
 <62d045039d44b_16fb9729443@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62d045039d44b_16fb9729443@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY3PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:217::15) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1465be7-d9be-4a73-9793-08da65d33ecc
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2124:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7utY3k5PjbLkhage29rE/wxVYqH13VHbU8YrWRypQU14LTWu+M2R3KDfkHOfF/VaxrmdQjp7SnS8EnwILPQTFOGor9idZImsIbBvybyjJjsnax7XMCRsVs9U8nA5cPcfuHcmGBuEJLjq6NilUNLedOkoS5M4bD71PsQL1LiSZ2fDiracZ3FuLjIwXmgrukqDMrfaIxfMFj1i/EcYTfBgg6RuvB9sOrfSKZz3PXGmRlEp5OZOa08t0wZvneKaHqXS8jR38eizihHC4jKzujenYqWTc5q4EMGtA7oscUpcWAK8MwZlQAYGIuPi3qF2uK0xXw4PLbveC47GhHmNptcoK4i0drqeF5J93AtKyg9ACoxxzxDcDdqehnHguSAdN9DYsx5MqvUcOeMqDAvOZqWU8/949UqIPTLfePOShD5J4wfmUDIghwAZW9CeHmzfRsSjnnbmESSrWOik79lZpR5apOn8RX91jgwNdDgmmYVIy0dUQE21hvtzMuKrZnNs3tElHPIJEYspmMZCdonz6fd85h9GvujnK7bXoclBSyTHnVc2XGD7IeSS6nFdoCYOKHJMBeEqCkpTU2HMOl8CyGaDd4S5aWz6DMs2H13TUCiyqRWDoS0aofUYioQJjqyZAY5QMmZMlEMUvrivM83GDzSQbbGnOBtsPMe7MJhphdR8wKcQlyXYi9TxyrGsTKgALyOlljeGxNyFzs1/inRPosKGz5joC+dcNn/NPFvEhMVLe1sOk8qQ/steraaCOJhRXKx/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(396003)(39860400002)(136003)(376002)(8936002)(5660300002)(4744005)(82960400001)(9686003)(6512007)(6506007)(86362001)(2906002)(44832011)(6486002)(41300700001)(478600001)(6862004)(33716001)(4326008)(38100700002)(6666004)(6636002)(8676002)(66946007)(54906003)(66476007)(66556008)(186003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7xGjwlxohZDXwlYEI8nhehwucZ6vJQvYI3iNqKSAcV6NDRPQ5oA4hUQ5VSz8?=
 =?us-ascii?Q?Qs8KjATLNa6U+lZ6/M32rBhoQEeTD0cu49ronpR8C/BHBQwKKj9QGuoDDQOX?=
 =?us-ascii?Q?xxSzVJwkKyOyVlbmFbNBi4OUZNdfKEqJjkeiYqoC8gTTJMB6DSltKZZZeFgg?=
 =?us-ascii?Q?Q3ybnIpXz4p2TeEmQ1FdvUGihlcHIwg5cWjzb4hK2qMLCOZWLWA7Ub54Skd8?=
 =?us-ascii?Q?tKYwZYdaePsxCum1Mbeght+WQKDEM5nuGeHQNVAyTA6XLbCdrReuSAKBzYDG?=
 =?us-ascii?Q?WVxyJqWc/6BmLeAJZufvkEIjKQcUpGqtNrU+8GEdKkVEpMP+OdI5x2EGthCU?=
 =?us-ascii?Q?UZVzZedYhFql5+A1KUwtM/20tbX1XCLoszxxrQXp5FocZ0zpyCmegFaiPdGl?=
 =?us-ascii?Q?V8MxrThyFmIT+LHTdxch3/Y0lL0kgrhSk52V2YLjtLKXla/djxOKbOHC6C2E?=
 =?us-ascii?Q?6jJxPM9t+Yvf61VNwpJGXkprOKzzzKGBq3FwICN4rs+QVnq3kb1Bk/AfJKsp?=
 =?us-ascii?Q?rG0jp+/Lh2FZGwko1BmtMKNMd1PtcStEG32uCOZFtDWOa9TuGL8eQK3kTswZ?=
 =?us-ascii?Q?sLjvgcadFGCOsyWy5732memWubrzjuN4GLsY8c5TgG73eWKtdZbvrwpWKS7j?=
 =?us-ascii?Q?1NyaGC/gLlsIJkY/B0ostotQkKpyrC1H9Fn5lSBBDwAXCLYuUjnC7fX1hm9U?=
 =?us-ascii?Q?JbuqFuUNPDSePjw21RT+QI9wRNI35HgD0dURlVcowHUW6Kwt5YCXT4iBjRul?=
 =?us-ascii?Q?+PJRjVuAyT99kEAXjbWgILI2vsfSGbZ2s3PJHyHT+8Ueh9YGmIpQUw/81/Az?=
 =?us-ascii?Q?/l0Rs7wvNMuaJ3BHXjmUR7sEQ9YrqNXM40cauLmgfwMOLOThNaaKVY4sjej+?=
 =?us-ascii?Q?2YPoRov5WBVoTYNdqiqC+g1c3hk60nXiUyUJIg94Q2iVcN6dNCPOCfSzKCAY?=
 =?us-ascii?Q?pLx4h9GYBso3Mg3j3fpJhXVUdeHqVjGoeQv9eMIarhUTyjGugoTdo/ffc9qd?=
 =?us-ascii?Q?jZ6yezKUx5FWVWR+9Y2lQgbnVCkycUwkzh9NaTo++BOtV+yFtbbHKuN+APvf?=
 =?us-ascii?Q?07+V9eMvTfJGH4ZdYpSyo83CyFIlTlIZVdytz+ChvQXKChrYhdcYtsNN0/Dw?=
 =?us-ascii?Q?AHZ8oWJs0JrkvERL7W1fKGHX4xDYxoMxwZy/7MdyNHbaK7b6uXd7euxuCpMM?=
 =?us-ascii?Q?y8VmlcasGsNtTd3Z5kbVVCKG0hK9Vgy5Bawmr0QXbMDZ5V/yCcOw5QF3xC5b?=
 =?us-ascii?Q?GKXenM6oKV+oTF8zVb3kFl3VFAXqrpi+Boj+3gTlv+EiMDFf9vrFPzPnzkbg?=
 =?us-ascii?Q?uXfRIqagFg5nCVYv0G8f5qFPpUGcp6e94ETJ5wYP1JncnQwKVAlQ/CpN/7BZ?=
 =?us-ascii?Q?aueH3mFXfbhp4ULpqtssLo/SiXFeRXjPFRitvF78EpmbAmxYIP2ItdXKIfSB?=
 =?us-ascii?Q?g1ho6B9wOqqOYbmlN4n4cxVpDXnxySNLHmJ6k+MX//oe2TjKG7BmmnWeZsoa?=
 =?us-ascii?Q?fA3SHuBtRaj7nlazaDIKB8EmnJyYO0xZziSv3aPvaUOVQ4qANbhg4Heo7i3z?=
 =?us-ascii?Q?59nvDnFub4az/ZXKPphR66p2HnVX9ql1FofC9xXsR4h7K7smoUxMdDi/+VOx?=
 =?us-ascii?Q?G/tQf8sANeUAIbrVjmNejZ4w+L0aDBS6ykA2ZwbVrASK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1465be7-d9be-4a73-9793-08da65d33ecc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 19:58:39.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pLRUdrWLifnGlS7IFkrU0seo+1C41YPbZRiDBQxzWrrWtXfMLci9Ot6HWPDurAaFjhfDHu6PzhWCXVN6cshMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2124
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

On Thu, Jul 14, 2022 at 09:32:03AM -0700, Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL Ports with memory devices attached need the information from the
> > Device Scoped Memory Affinity Structure (DSMAS).  This information is
> > contained within the CDAT table buffer which is cached in the port
> > device.
> > 
> > If CDAT data is available, parse and cache DSMAS data from the table.
> > Store this data in unmarshaled struct dsmas data structures for ease of
> > use later.  Ensure DSMAS headers are not malicious or ill formed so as
> > to cause buffer overflow errors.
> > 
> 
> Per patch 6 the parsing needs to move to a refactored version of the
> ACPI table parsing,

I'm not seeing that parsing ATM but I'll figure out what you mean.

> but for now it can just be dropped.

Dropped.
Ira
