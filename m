Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F42648AB3
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 23:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLIWTW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 17:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIWSy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 17:18:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9249766D;
        Fri,  9 Dec 2022 14:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670624330; x=1702160330;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2ILPPonIBBw9KOlLLt3Z1aTanIR+9GJf5CvH5wbtIrw=;
  b=CauYBTDPTiMMoYm2iUHvsgybg64p14Tv+O8mdKWWrKK9YHAO/Z/pAv+M
   /bJYcWThNDwQ9rxdWGumnOmIwj+qYaTDoABmZ+eVjaH1ZVNhM3FAdbpoQ
   NhxUddp+ub/+cQJuQC3B6ST862phPVfdkGRV5nm/Wvzbd0A+LoSHsblef
   kJ+/NTPT9WeLHKW5mOUIUXqiGUM1d2tYNq5ViPNXAbNz3G3Jol3aW5wP4
   PQgObQlyCxKkiS47KqkUVDITOWSKphHhzg+gGgXb3zNXI83dGjMT5V7/V
   hDeCHc6bjOlmaLt+uFnfMaVDxttIi0FFFp1JXZe4jzHevjnM5xmgn6Hhc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="379773351"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="379773351"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 14:18:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="647539607"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="647539607"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2022 14:18:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 14:18:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 14:18:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 14:18:49 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 14:18:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhtqcaEktdBBYLxcWnIA2/YEGMigfGb7z8flbTdnOXrudABNz+v6q5igktT7MIk9/ZNMbMkQSttmnxsL+Rgmk2Cdz05eQb0CKPbbtSX1vSU/lwqIIAdqoOhy7WuQPwLit4oyJti8sCEctQhyRiDJ3bYBvqsx+O6PHhmOhDhEPOYyXM/uv7Yz+ljjtquMcnl7ZCTlF3wlG3yVBachr55MmckcmLAZp/8SdkTRY3i3DUPBQliw835vp9ozmh5a2ZlDJwmIukYGUaCvCDaoH8u29zEE6TSSU6zGebh4XzZ56vuOpAy1hHrcl6D9dD69az8DuWak88SWXu7lNbbLvGVKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/OIqFOgJxP5kgFmNo1seekGTIgu8DZ1ati9sBssy70=;
 b=YruKvwt4VVt8z5j/SQju6nTa8pfmXb7ezXeAmQXkrvipdLireC5z1x+spskQaTQwqtLJa0hdsnrME3sejGWnbxGP7BHP3eeOC3+ZpQfRCuf72Ea7VooFth1RWMThhC+NiW5qVxns8QBjlYgb8VKYpZYvkGboT/3jcUIR1D83WFA1JHUkF4ku0Rq0ej3Gs1AcvmADLrjF0uaJlgaE5uWzi4qR6kjuvBOq3cU63f21rSUE0QlSomVO7Ti01fLjh5XDBMJIpW0Gi7B8DN50jy5cLLWKPENegAoPOGe9w3s3XrOkefrSKz2Z+ja++Ly+RaBYV/jNm26g6lj8x5d48Nvs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4551.namprd11.prod.outlook.com
 (2603:10b6:208:269::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 22:18:37 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.019; Fri, 9 Dec 2022
 22:18:36 +0000
Date:   Fri, 9 Dec 2022 14:18:29 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V3 5/8] cxl/mem: Trace Memory Module Event Record
Message-ID: <6393b43552fcf_579c1294d5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-6-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221208052115.800170-6-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|MN2PR11MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed484e3-33b5-4fea-98cf-08dada33512c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIfEvKFWKa+H/O7YUBw64eiXBB3C/az/FpmT9+GKgexXMTpbGSCRlNElC+c1/F2O0G39rA5tqWSZ5IjDDfshc7Pqb1/TlHRZrx/eercSy8OKgHcZZWS9UGiyDRiFY/K4ZvT66x7fkwbDIF2z5l3AL2i/nk9xbyKhvL//IaMbnbF8UEemvTTO/t34uI6uJBVwt4XhbbmW5OONfxYiJC8GF2/r68AXnlxapu6UAUIfhTmF7rIqegV7Z/pC6hBKtGhrfydp04zDahdBEEI+MlqFMXxbZAf7mPoXMMA27FFST8MhRlVX3yTxYJXS5JK3VT7tMxJvNVrBobbYjE10WSHMqQ3BlVguDAy4dcAlnTdfp3eJmPlFNmJ2xEi3AG2f30F9YTXjrHcJFHVBuwZHmQ8M6/uHy9HFuzQhskcRks8t3pvfR5LgnRdOA1pRX1pFpn7c+zk+Ae4Lg+tpDKHESngXGLN0NhV1VFnv/tcGx/WX5YQGIY8ppI/RK5GdOTIPkUT2+uoZpBLdW+q2atCHHSmkidG4ZkpWFIWl5475sWWQIsaEIT1Ek4ehllXAUt3chMbzLPQF2G61w1f1BHgqGEkspa5I2mUh2xOswvjHLBxxlJFyMQ4elD9xG1rnLaCsZtB503GVk2XTuULeoScMg02+9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(2906002)(6200100001)(4744005)(6862004)(8936002)(316002)(54906003)(66476007)(8676002)(5660300002)(4326008)(41300700001)(66556008)(66946007)(6512007)(186003)(478600001)(26005)(9686003)(6486002)(86362001)(38100700002)(82960400001)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ZVRM4+X3Zjr+OjvXr5JLUQfLVZ12s5Dg3aRQh2MWyQLj7J72vE2nyBfZd2X?=
 =?us-ascii?Q?d03+QoWVv5/DrjktRnBbsWVRMTK2N8fHNwqNHhCa9YU0eJqUTsaLY9bbaKXH?=
 =?us-ascii?Q?XRB8V9WhX4yFdkUiXVc0p6Gs01yz5TwCsA94HD0R33Q+80Wdpu3fxTTdjf9D?=
 =?us-ascii?Q?y3MZWUXphT7OlynTnoN7crk00I+1ors37yMYDubVDvQDcwLwRbIhhCYfyGZx?=
 =?us-ascii?Q?mGwYaaj1r3ADxVYuPNNhvvLEskg355K1nZZySgODxD54WYXAeKtXmRj6BAd0?=
 =?us-ascii?Q?Tx8Zb0XsPx2w/vy5sz8eNq562oOU/vBgvPoXt5eadveIvq2gsXgpz8hurMit?=
 =?us-ascii?Q?cBZxRDlMmS2fyOwTzw7iS7Wr//nlIRzCXvZ/ebBQwyvgKr9WhKJLgEGJfHcZ?=
 =?us-ascii?Q?q7ptmOGOwAg3Wdaf92Lgnec1oJT2F8pJNu3MAYo5BqkCRVgP0lNQ/yRFy63h?=
 =?us-ascii?Q?7aQzkbcBFjx9WOveA3OI+aGL1cx+DMve99ko8d56c9grE50MaxNMceXsjaEX?=
 =?us-ascii?Q?4IikRDFVDnsdGHhbRUDV2btGZuR9bTQFJnvDp194k1CZsTACqz5/ienlYBAD?=
 =?us-ascii?Q?+RwmSh2RLo+Kdzfoz8JP4EWoL7sXI5LekdgookThaEIVzvq1J5bJLUMEjTFm?=
 =?us-ascii?Q?AxzVi/aPFtMnAgM4+mmIOaCrW7o5nTtMm95s0IhKRzqndTpPcBQ3qrfbQirb?=
 =?us-ascii?Q?2pXO1J7zuqs/t8jvN7/QN7/dMEwkJ/CSDRKNu5tPBWALPte0YOpkK9VPPRAg?=
 =?us-ascii?Q?VEJ/qKoU4FH3X+UqtDs9k/At2nRiAupUlWQY967p1N6W6CHjmyM2mW7PKrZk?=
 =?us-ascii?Q?HT+cOnsyma3z9izzR3npf1GBghacXWlGSQJ8eKE8QqbUvVZi49eTjFwO0d4C?=
 =?us-ascii?Q?P7Qb8J50TtT9IycDwqRzGGmi5BLn9hflRM8WDMKJqDWAZXOAD/oMiI2iYHkl?=
 =?us-ascii?Q?ec+fc2wcpL9xQ61/bs9stz/k9m/Ec7diqdChXoap5LvttNprtBWht++m9Sax?=
 =?us-ascii?Q?7TojOyJQVzE9tUdTwsC/i1E38Q050RjNjs6G25WgMh5TlQujdwj8//YEKKIr?=
 =?us-ascii?Q?VXtYPKzjx7FQeQXWxqx4IsviepxRn1w0JUrDPo8WhFL7i8LWpl09fuuu/01d?=
 =?us-ascii?Q?jz2alKrIqxRNfavy3hU+PBhKZVxmHE0JQtaJTpPIjTIglmn/HHW2W/+F0en9?=
 =?us-ascii?Q?B/pwGrKXPXMzBRVMS+/tN53nomtApu18Zza+ERY5rjgarNl1dEtDjQwQJEUn?=
 =?us-ascii?Q?Zpxw2JHoAysmSq5fOmQrEKPO2bSVnwZEgKt+yZH07DxBoxU9qOEoudyfWRXU?=
 =?us-ascii?Q?eE7VlAk2z0Dm9TNsRHikVXNQZb8tsWfOtlfAo+PaHRNsrMNtyAQaBZUxdv7O?=
 =?us-ascii?Q?nV6AIpR85x6AIg8wjWe06GwIbobtHzvt6z63GP0DRhWs1QaC7Y3glLor+a5n?=
 =?us-ascii?Q?9TatSVIyVsz2bXxUCO17+O5TXny/3qcW3h6VBpqsblfjeyoHHMwBx9/r3oyl?=
 =?us-ascii?Q?dAKHAXE1QdmNIiEvkfZVWXB0/qQ+QngyugmUaQRY12fu5OHGmlrejSivr5MJ?=
 =?us-ascii?Q?ByhCcwZJ9lpOcWo4skI3dQRTOswlHEHGYZHxXf3cK4vierWC/JqG3xWLvaAD?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed484e3-33b5-4fea-98cf-08dada33512c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 22:18:36.8129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sOCd80htMPuMyXpq+v3ZJxOs0K4zyhAyuLC7zpQOW5acnjqZeE+lPBAmmPvDRetkzpUlDycU0VonRNoZ94IUj2bxcR/Q3FGGtMVj9CzW6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4551
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.
> 
> Determine if the event read is memory module record and if so trace the
> record.
> 

Modulo carrying forward the review comments from previous patches, feel
free to add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
