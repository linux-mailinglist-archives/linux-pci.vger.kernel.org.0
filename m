Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4303F72A8A6
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jun 2023 05:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjFJDL3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 23:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjFJDLZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 23:11:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1412E3AB7;
        Fri,  9 Jun 2023 20:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686366684; x=1717902684;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2Cwep1D6+0qn8Ew8v/rbPPuZOD8FpNEbGH2JWC7CkFQ=;
  b=n4Zqj47DVgWJU2p7PW5zOIXsBZEgkV+jwJ3EBf41YysMmQES2K4amFXh
   Ure+F/v4U7g1D6+KJyEm1SydxSFzTs8BZ8bTQqw2yEJ4Pid9HAo0fC5BA
   hJUeEXQPSEhaRqDACDbiyKk2oP+3SDtd/JW8moSt+/nY9ivhL5De44ncR
   wNOOx1AyURm0Vp7hFku5tcco7L59woyu5aTHEWyvY9Qdf0QPp/57/wx0V
   RQ2szaPYm9CpY5tAGpk/w6Zd7dg1MqQKX9KXabZjZmZoTx/tN8c8rOjPf
   4SJA0CDLvEuj64KhNP5sMkW4hhrJeE/STCmiCBZIYupE6j5DDaWuyCjow
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="423604345"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="423604345"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 20:11:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="780525255"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="780525255"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2023 20:11:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 20:11:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 20:11:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 20:11:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMZMeV+NjSO2gWf9bK/sHlnOrt4CrvW8w3wzGkv2H6aqiM1GFBy4wehTk8OH7y5bllT/sO69SQL7oja9PxaUS48oNSkrlfVG7hcTj89Djoaq2V+WcQZVDBp21zcAqGxkh/IJ0diubw1Ja9KKjMfJ2Hv/TsGxjoP8BaWdi4Rjv6v4hUJtpvVeNuQEv2EhhIPqDvNJpSFFbEmt9vj/cIvUYGrsPNUcGKYO+e1ndW3dfkUjk7F/FJYzyu6/mqieW3PL8/aExqmEhNTv3jWfezSBaeJ9ewPQ2dslpkV8pd7fj2LDXgWS7bHAAVLzbMhu14NQL4rIknqhkUJi2zBYkrgkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gV3mm4kKUJCPPXNaliVVNTRu/iz7KWp16oIYH1mZ1Q=;
 b=MEB0JSu1TGYT7tnGqhXW6M7P+o+Q4w1tmTzR9KNaRZl+F7xxOp2vGuk6LNZa2l2WM2Q52H2YohHHRQaeJY0479o8PTJzOD8T6vr8OEZ8fNACt67YUHs8S1HYD1NPu4YMm2NZNFlLqPCFTCbD5RkYYatW7P/dt/1mk916pJJLU8iy77ZKLHBSZ3FHvAoGNpxjQlrGjiSoWCPESAuxR3G4m5ZEi2IUobJGsQUXzlgprmTo9fOKrbAIgQqYFioBP1gUmRRbwq+cd0z3fzmDZwjshPfkMntnJVMDTUz6poll+mOJ82k4gpwPhiPx/LdsnmGRgyvT5ZoJlQu+UQ8TwG4h0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8363.namprd11.prod.outlook.com (2603:10b6:610:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Sat, 10 Jun
 2023 03:11:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 03:11:21 +0000
Date:   Fri, 9 Jun 2023 20:11:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 20/26] PCI/AER: Refactor cper_print_aer() for use by
 CXL driver module
Message-ID: <6483e9d55e20e_e067a2948f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-21-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-21-terry.bowman@amd.com>
X-ClientProxiedBy: BYAPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:a03:117::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 82bb3f0b-a8f5-4391-cecb-08db69605dcf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMPLObt59R9DcHRhfDidE+LpsFMYSJR3HByraRojvcu/5v9s21In+x4UzXUtoe1VxcDOd9FoRvhRfQFWxVbcy2yG9R5Wo5hFfJzjDFRTmclnwhmplfdXb0ReArXbHS/6jWvo1sv1thoDZ+3rV1ilI9hPBAlFA5yaDAzHTRiA8rUHwjDqXlf5wuNvYfboO7j1+P5nSJ9JAzIgOkAo3+p1G3Wa/nZrpXhFWwFbLmrTWRBLLwt47Mt8Y03LD95Xe6LcUJAVaoFMAAo65TmRM5C2d7/eWA+RS2k9SamrF8D3MjCl5W2a4UPDoKAgtlUZdVfvVFLCY2uexyj7OngdrRkFQ0fjg8zAjBPgKqNZ4aH6nVYymciDO4+6nOP9ldbLXvbLZRAtcOj/+u6yQfwtgidH6u2T1VJCCYd48eWzBxr7mftI5IpkojeSobZlvonKFZ3OTL3WSTop3U7OIzXsqKs+ousgpsoa8jDGoTCBFYhYR1Zf2+7+vamJeCgzrgauS2uL3XyUNxyMsqhKPeAjWoquuPq+p09n0S0IIuD7+aZEOoQODAs4FFC+OWVtpB2RV1tX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199021)(54906003)(2906002)(5660300002)(7416002)(6486002)(86362001)(6666004)(478600001)(41300700001)(82960400001)(6512007)(6506007)(26005)(4326008)(316002)(38100700002)(9686003)(66476007)(66946007)(66556008)(186003)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WRFoWoShUjubXutyN38a/2LDCVreP2MzFvbrPWmfh7T/l4tQrd4eSKmN9EAA?=
 =?us-ascii?Q?k1tH7044zgN5cOxBjfBz45SBVWnGtnRBa72Y7gSCUt6il92EG51YJMMylMFH?=
 =?us-ascii?Q?GJlo7BQzkMV7Oz6OAex3MwM2ryQ0fpfUZ82JEGcGdPyvQ5WmruuJRnqaQzrG?=
 =?us-ascii?Q?CA+GoEfnjCrhBLNN2Y7VLKRc8nrRUEXxUhl36o7eClveGd73Q7yi2jlBF6EO?=
 =?us-ascii?Q?WP44ThtGg4v6oj04H/UXapSKJekiU+iptJowk4WQ4g17fjgsA/dQgUKtPu0L?=
 =?us-ascii?Q?X63P64XGxcS/3Q7y/BSXPlwcnOUGpIwCE3DOeQAFNbRQvg/pzysPRtft0THE?=
 =?us-ascii?Q?cPaQlyDZMAE7J3Fzwmr26yhvyFBOCo6wUjdgGtdzpOyzYxAvReTO05/VlZ5y?=
 =?us-ascii?Q?KVg9I2QeKm3oq5JaocmfTAWLhlnVvcRziCxNCtMMO4mpAn6+o2Eo861YYPFg?=
 =?us-ascii?Q?XtUiR3WVmqfCWQBNbhaXpi6kaqOM7ipJ/nof7d4tePGy41HaMhUJ+0Fy2Ufv?=
 =?us-ascii?Q?ehdKQ2CrDY5l9sGurKGugcQSV39xatAwttcvlsPLS82dy+wX4q2CYYLrjKge?=
 =?us-ascii?Q?uNA7Rs6dmw7H2xFp3nreEZfKmbF/zndu4vn7WoTtStK5Z1Y3j/wTnabTSNEd?=
 =?us-ascii?Q?8zY7AWpJtwhH0sqmYmW7IOjhB4bf7wGVLlHyut4fKO3pyNJncqMHRFDXctCE?=
 =?us-ascii?Q?MWvttjKXT9Ux8t1TDW6YdKQ5QXtdQuE4WsJQNbuWrVDryAaCDFo1T7dQwPwd?=
 =?us-ascii?Q?jYPrSesjvs8E+EUZGwCA2lsz22cAj2ClMrhgiM1PDBHpZNhrfXkqvodaeitN?=
 =?us-ascii?Q?VLL6NDK4EuScD1aNWth/N+2mmBnc7Op9OMVnKTTx45zdrLjVKWd0C94zLINQ?=
 =?us-ascii?Q?LU4qAGRyAzAOQoLE9uuMxYlVivdg8AR6Ejyt/5ykleZYFupv+LdWVweDlyTx?=
 =?us-ascii?Q?aOXRzCCtv85QgRbr8yWkpSmVyE0j1YSdctcZXjq8Csl4mACLEBsW4Rp92Nn4?=
 =?us-ascii?Q?oORQD7KkawVbGYjHYjksof43uX/BYmhUXTPAczODcknAz6EUyAU4ffFySzCI?=
 =?us-ascii?Q?u+yN1cQOiPjIRwnqpD/tK2RvmU3g7w1UmXtZCA2vRzfUptykraFjpXTvTvIR?=
 =?us-ascii?Q?bw0HzRXt8pyPzigpTdvaSef9EroVy9RK5dbsIW4cOtLeuxVxk+HzECZfXMJf?=
 =?us-ascii?Q?NjqYtTumcweUApOgZCRypOWjPsDl+nfKy0B5XTIOq/EyQ7CS1cWUEcO6LZM8?=
 =?us-ascii?Q?aN9CbyQbdslFH/UE4EzkTiSENyB5ONvci0PeDW0wVHEoJkj0IjR3RWfdD9eS?=
 =?us-ascii?Q?I3YLmM/nVZcUt1OHeRY+IGsPmNWqI8/wFPjYhPj3yS0nqajE+W8IjJej+EgQ?=
 =?us-ascii?Q?BIrgUbkmxcwZe/+h50PpD4IdiE7eO1yRL/JySUVsdlY0h0rON7BdP1acfTOi?=
 =?us-ascii?Q?I1P6ABinByKxCX7okxviRdRS9dYAKWqM4IsJ65QPVkx8LSYwMHyktTC9obBU?=
 =?us-ascii?Q?SCIoVD6bvkqNLGOk57Q4cwO4LtpIZG7ZN4fFmYl6TeeT0oDuPNZV21zCHCx2?=
 =?us-ascii?Q?iRD6Xa9UPEZ5ecTnRtGXrvnIhGpkIiESNL/7tyQ+LMoBmcxiV1a1tRkYAmPo?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bb3f0b-a8f5-4391-cecb-08db69605dcf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 03:11:21.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOZEUP/v2khvX/pxWDLIvFn6aGe39MYfPreeFAsm2O/PAbL15f9Ryy/TIYv6hsE8uG6vQAJ6eYMtxtjdsNdSr+Ac77iVUhk/JAE9l/Yksn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8363
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Terry Bowman wrote:
> The CXL driver plans to use cper_print_aer() for logging restricted CXL
> host (RCH) AER errors. cper_print_aer() is not currently exported and
> therefore not usable by the CXL drivers built as loadable modules. Export
> the cper_print_aer() function. Use the EXPORT_SYMBOL_NS_GPL() variant
> to restrict the export to CXL drivers.
> 
> The CONFIG_ACPI_APEI_PCIEAER kernel config is currently used to enable
> cper_print_aer(). cper_print_aer() logs the AER registers and is
> useful in PCIE AER logging outside of APEI. Remove the
> CONFIG_ACPI_APEI_PCIEAER dependency to enable cper_print_aer().
> 
> The cper_print_aer() function name implies CPER specific use but is useful
> in non-CPER cases as well. Rename cper_print_aer() to pci_print_aer().
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good to me.
