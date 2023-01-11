Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29C8665B0E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 13:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjAKMKk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 07:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjAKMKb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 07:10:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0553B91;
        Wed, 11 Jan 2023 04:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673439031; x=1704975031;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iigiv3Mr0nfKnk0VPPJ0msPuFSgKxvHpRPEJM06CmSY=;
  b=nn0bWsOlZvFFRB8l60Qmi5jyD4SKDC40d03h70MPk8oO4h7/d8U0MKfJ
   7RMaIFgTnbxUhd2j5LHn59GTjjfkXsPhqtK5ctjYVSdVRXaipsi4JN5Ga
   Ra7sJhyGmGatEOxfESWMPIa4z7Qdc9Aty1WExwvtIXv1X8bC9Se6Nf0/U
   b1VEjuHJBuNawmFkXFW//LMdt0FRXdLsdezbjDECtx5dpJFECIiTWp5ZM
   h3AIr1oToDTFor5tXSobhOjByfA5mg05xzfEEv+jRGL2lu4pD48iFkhqW
   2oYr7gM5O7H6bzS0Tsdh7f09vWVSD136B9kBLYsDaNfHV45q9J2uMSlV3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350624789"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350624789"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 04:10:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="650736540"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="650736540"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 11 Jan 2023 04:10:29 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 04:10:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 04:10:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 04:10:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 04:10:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld8PPF9KKG3pQx0lh1+vRA7bHO1fYsHtoMxXbehQoXJqr5e27DPsSYEPklu7GJaRlEIGfidXydp7biCqVdTaD9giocz6gv+a1JP7l/DapEcQDie+uZkOfpV1zIlMewwme+45XEqX1mwGFK9bbgPyxBiNtvOXr22o2R0dRpEtFY8RPvSXu+7wp6xEeu+IRxA/5WjtV4Nqr9g8lHt9Nc6Bui1C2ZPvvANliT1zpBky2oflXMBUfbyjoBkmRYYmCIV+rRNYwsB0s2pjlwbujEiX/4v4wFuMU738rVW0o4pAPXyyEjnT0xk3veO5cbBKGYwuQicuuwTr3dx1BTj1VDgHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5nUklc5w58+LNHluNeLdU7TG1aUBMFAgymLghXiJTE=;
 b=J6m3rEewvlszQFORz/ovffkbFLY062VhMp+puF0SmAfSmPsK0iebnllvc/x/H8IGixIVb1qhcUQiEGAwEbXSYWMRAH1+DnAry0hQzhM3GG/bDAfqrXahKVI+NVyLgog3OqkHMbx8oCirOG+S4IXrrW00nnmcnFzgvZKTX8X+6r5cBKKBjdsbLjXAAi5roUtPFO/O3mXjmaoYndQQBYp1Z2128Qz+qNEUXAaqqrwpCEKo4i4bUIVgv5WaL3/cr7Y8ODl/dHg7ybHyJqjhTZuBiWmvf09cfCHRm4xA8Nt6h6xStJwUuJC1Tt7vRWjoqesloPvLXIyd+MgVJWZgRHOsEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 12:10:26 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::7b39:df5f:fe4e:f158]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::7b39:df5f:fe4e:f158%2]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 12:10:26 +0000
Date:   Wed, 11 Jan 2023 12:10:16 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        Dan J Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        "Matt Hansen" <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        <mumblingdrunkard@protonmail.com>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI: Fix extended config space regression
Message-ID: <Y76nKJRWA6mnbwjW@gcabiddu-mobl1.ger.corp.intel.com>
References: <20230110180243.1590045-1-helgaas@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230110180243.1590045-1-helgaas@kernel.org>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|BL3PR11MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a7b718-4217-4ffd-8c98-08daf3ccd29e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3EEdHBuBel9BoP4MJn6SYYLfKzNTzB5VRsjMTTsyzyeVoFDMydQzaxA69DaDvlh4jeRYTVSQD5UgPJ3Pbh7m1NWgdtklyEsqiSFGXLEj6irfNNeOuNxH8+QMJbL04P+d9EPLtq1EMOMm1r4i5NJ3nNmi0tJgMkR+hE9cBv9fbr4t0eyVQ0IVWUGDrRkiZbGdPp9wawHNQjKa1O4vLb7FRSZFNvK32EkOCrNZP9ZgR3KjyTKOx+sxC7WVDf8HTUgiwsMG1bAB6gY5HUuNluN2rM69naLtAKI95jicB6cGP27RxA5l6+5lL8bwbtH/C4tI3BlFyAq6vcOO3x08zWJ6jxPM9AQA32sb4TWkLRSVlnYVDXpEcMi6sYybT6NuLK02hdwwzZEuG0Z66ybE86iZAS3v3zBIZsxFu+MMnf3AsorwtBh00jr0S612ozUj4ufQDqOvKK9DSYr9XlZMKX0pNt/ye5eX4Wkb2Tfi6sh+gGSMMUwxQiLUS7SPHqRFQ/Pk4stTDI3VutyZuyH4zcwlQtebRfl9M2YrbwkTEjTyWCKYnnKeRCpaBTlHJ1QWNnPz9+uEkoIEdWG2MIir+GY2Wj5hDqoB6kJcRtLrL0bhWvLQ+5JYExE+8TMj6VlAlHoD684IAXJXMw3Cvz6GUSdSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(7416002)(6666004)(6506007)(2906002)(8676002)(4326008)(6916009)(5660300002)(8936002)(4744005)(44832011)(38100700002)(6512007)(82960400001)(478600001)(41300700001)(6486002)(26005)(186003)(36916002)(66556008)(66476007)(66946007)(86362001)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/dFhFbHVqqrPjFTHsqlakcyrQkPu+CRBd2qz2GZF5RQonuQg5/7K/iT+c3ON?=
 =?us-ascii?Q?GdRqBxG1e54In66nSf5t328m2wHruWe9lfFac3Ot7+f5S902vKzux7fzvQMs?=
 =?us-ascii?Q?Egi+F+6Uxe15LrjCq4YSg3z6VowbvWASM1RKhvIiiV222sQ2ENnfxHrIjBK0?=
 =?us-ascii?Q?fk9q3m40ij4WdSRYuAOUj4ZG/NXOhnf8vQs6lAaZLPB1InzxoYPUnfp28igc?=
 =?us-ascii?Q?2p8ViUVcHPvCr2cQ/ANhuEcpRKDr+FFbyPJCReRje8Jsb41c0RJl/SuDZHu6?=
 =?us-ascii?Q?6+U3PO0wxalyJB40yocFhXumkqoASNx3fjoWLW1pxieuE47w6sGgB8fFHev4?=
 =?us-ascii?Q?0WhC43P8IW5YVMr7Z8D+L8JQ9+h26Ezl72r/su5jtu2szg05KO/szz1T/4X8?=
 =?us-ascii?Q?vSa2p6jUijnTXNrpSZdshGP607KAPsrm0mcwy5JiqIhEHD7QM9GYLqubfGIZ?=
 =?us-ascii?Q?GXsk29TCFG00L3bwZcNre9tFYNabC7RFb8QpOrHDDPhkZGf+gvWgGq4rcD4h?=
 =?us-ascii?Q?bBI/hONjVgtjD5mP/QIRVNJIGbhdtG2hjE9yp0lKikxBXa+pKKdAW6PnbIbU?=
 =?us-ascii?Q?i0Xqqa78zVrxfYXebM/TqFurCN3tohM7TaJ8GtRUuKny9+UwH/3A38mwSYVZ?=
 =?us-ascii?Q?dP6NjPJYjltaAux4u0UHUErWu0HDfFgAmiyo6IIwb51xs0UnyuxHKhdG4juo?=
 =?us-ascii?Q?2CtI9axVH8Pr8vgN/dQ6yBW7alGCkn6XNfe92O6Yhs3Mqn54yv586KayVR0O?=
 =?us-ascii?Q?dx8UuWue0r5Wz/VzinbEmD5Ymy6KE1p2qhAlyExrBhcIlWgIaiEGr/T+X79u?=
 =?us-ascii?Q?yt3DzhabOhk3TqKjxgPuxJR3XzJ/Y4CZ06TDC96U+1taoZR08okZ1YtJFIhk?=
 =?us-ascii?Q?6gIOtU6E+rTVZZOyQpRJvd5qNN+3s8R8iQRxIVnFivXIDngGSD+9kfIOXanb?=
 =?us-ascii?Q?9dsab0QoGLXyrKq8IkAwEdgtA8oTenxkIPnwF1aSV8fTJOlK0lHGcOvvnSio?=
 =?us-ascii?Q?xVFAxfPR5BxAAYBo+4gOpv4JZqXIspvZ32znmFS14GRa7i5RHcSE1QY3QAol?=
 =?us-ascii?Q?+Tl8ZjU3Fd3q2wji4mgr3jbwo67YH4JUpjO05RabbPv1NPIEGgeGC+Sfx77u?=
 =?us-ascii?Q?Svp2PYx+fQ3kgPCWoH5DBohvD9Ve5550XE5Sdu7PZbLyj8Anb1BQUYoYKFe+?=
 =?us-ascii?Q?BzI3oK75FUCWRUBOhIomyAgwdt3meu+0q2GvEJcXgLRn51HgZCPhcWf8qc19?=
 =?us-ascii?Q?aeWcXP3QvxdyubkeSfLwtWJpXlxAlcQz7vxU/HeEAii+QpQSJktpyeJ2iy+v?=
 =?us-ascii?Q?vMok/RDh8lUKj7vZOeh3vVI6ijUN8BaHuUP9KpruCUzmKpqVXOl6B6HAm9IS?=
 =?us-ascii?Q?nq6Kgl5OnBiCq5feOyGf2+Ns6Ntg4BHCfK7b9ZOlb2Y8DjjRdP8m7eHFFV/M?=
 =?us-ascii?Q?OLTzlvG4C0XubUJAkdk5J7je03qvj33qQR2NO7bSNt788vQGdDVi/KRxgfwo?=
 =?us-ascii?Q?bKjmGBXjlLBQFQy5gkFKzJO70Z1vt5VYJLY5mstKGwVoaYRk1j56j940XEFp?=
 =?us-ascii?Q?mDYj+rEA23nMCIHbPihf4U1/C7nDL20MmILSEXCSN+8B71MUckyFXYMSerOn?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a7b718-4217-4ffd-8c98-08daf3ccd29e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 12:10:26.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V8RO9KBJHZNaZjApYj3NQJEM5MYUT46ftGdoLwCCqnRWHe3i5bsvwvfUPVCjwZDPegEllmFLBiRjvl7qyqSehdWGmHaPAlkR2A43T8MC5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 12:02:41PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") appeared
> in v6.2-rc1 and broke extended config space on several machines.
> 
> This broke drivers that use things in extended config space, e.g., perf,
> VSEC telemetry, EDAC, QAT, etc.
For QAT:

Tested-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

-- 
Giovanni
