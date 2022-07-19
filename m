Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513B857AA18
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 00:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbiGSW6K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 18:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbiGSW6J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 18:58:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859CD62A72;
        Tue, 19 Jul 2022 15:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658271484; x=1689807484;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uDuvvQP6sv3t2rXLTQDyIv6WmgHKNdM7w1I0knxrNDQ=;
  b=YVZjiPLY2nXSLBOxHFPZc2dfWi3XFVtLzsA0EcD1m8yB6odvFjhsg2yb
   ueAB2lOz1msOAvncN60GCYRqBWCTlsY0a6QGCCoTzN0Hib7yQY+Z4lF2O
   JZpK4flaUiN710+jST8Cd0JM0EZ2KCYvGvzej9O0/ZU7QIMiPRMK0OfiL
   Hg6vcppf+v13R8RW5GA8qM+Frlw3JBVoLTYlaPPuKUD/O5lqdYoFrNOqF
   LKZdz5OGywhe8VrL35QZA/tCgCWemi5sfkq6EkSqti314j78SfQDvIY4E
   lbKQjGRrd+C5wkmCMBBHLgFKXdzzxKoEaWbTnDVGlKTcUhFC1v1uWKCRh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="372928346"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="372928346"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 15:58:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="724435287"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 19 Jul 2022 15:58:03 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 19 Jul 2022 15:58:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 19 Jul 2022 15:58:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Jul 2022 15:58:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlS9RMTw4XPTifTB+ZnK3M8aTRqNUIo9XxwIZSJrkP1GZs1SeDnb9cfZ9J3m//dwY9AHrWSp7F35hQgXzG0IjlnVaLJNFQ7KX7ipqsEzN+uwm2iuym2iacLf/Si16CHwiOjqx82qvL+xCAI6Me/ldbg4R0GvxopmQewiIxAcaGyIhYtEJFzCRgas0wB0xmM25pYTeOyBz3i2HDa2h56Ov6+nskfS5iOys67vfmSI8Y4i9JinB7MYMaI0ug9X/Vn7oWZW5yL5Rae3GKu2h66tVzXz+okIkbW6VF9oqie/jrqy3HvxgJmRFhAeMvJuLNxp+s1cBAFNCt8zncPPrkAW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po3MVLVpD1u0pKLWLZ6wnbWBZhcrnloHb922SFNNDg4=;
 b=cwoK9t52tFP0WQurS8mLBcYv3Apx55aQ+/gjlZD/vOThE4Z7ELj5QIfqjlaAnw6ArMhi1ZmhMX0OuO44r50C+z+rLqGOuH8y9YNu9/cyk/iqqfmWeygCCjOossrKLjN7A57m9iKXUMiF677nfvWsgEwZHhna6b0CXWPkhQsINUCvW2N14HhEdy1+mllRtZbenCncVgzwVtH1z5M3Hqna323Z9y7HY8jbjLlU54hSgukwgcIS0obJGPbzXaz/WoUIEQFM82N27OjsCTshFSGYDClPlgX7ePYlIRwHcM7AnYcnlP1wqVKrnFIeDS+C9jZvNUgYx+2vTNzRgEPJVeBMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH0PR11MB5345.namprd11.prod.outlook.com
 (2603:10b6:610:b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 22:57:56 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.024; Tue, 19 Jul
 2022 22:57:55 +0000
Date:   Tue, 19 Jul 2022 15:57:53 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V16 0/6] CXL: Read CDAT
Message-ID: <62d736f123b7c_11a166294fb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220719205249.566684-1-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220719205249.566684-1-ira.weiny@intel.com>
X-ClientProxiedBy: BYAPR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::15) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df89ed6e-2d42-4049-c629-08da69da1e1e
X-MS-TrafficTypeDiagnostic: CH0PR11MB5345:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wwOhczlTvIEtjtKl1O68wFl4fUnAFmjug/Mbspqcxv2PXToHzekg73u2e6xAdIUx/n6M9A2a+0RvaWy3kTTWerqOn8ua79VAvWgcRmQ0cHEg3YnGmYKATnqyeNYz5sdy4khpfkaCIRRCSjmeSPpe064sVLVZZBYA+a3wsM3hAgL7eqNwoSnZYsX1u0/zML+ReQHCrkXsXqBC3XbF+fY/kE7tYoxktdZphaSYz4OxtTG73yosLIbnlaQs8opPXbG7PYYeVpBgM/S9dRrDhtVUrGuVAK8p3r4H0jRjFzd5SjDovSU3Mg5N/t/75854ztDhSAkcQTUL8w19lmD90oc/QdQPKQkZ2BLbaOBppqQ5E5Xw67YrmUR/nXhoC9mQBE/7C1G7J6AjXHQxS8n5Dv00BZ2951r5vd8H/4rfWpfZIlunc8TJ5S2/OzD4avaLyf1AUJNSS7j/fkXTBgFZgHDTn1lYLzQusUWoUyQHbPzAAuz6lrEH6kpzFImiRhLlHJAgPm5CVYCnldLmc7LTTl01GsrnJu/pKeDaVj5XNWCGYr+bpZd0wrh5+hyJ+Idsm5e9RJpdFGpFXehpDz9pIVZDcau22oUlyauLbg4FAf0GRkQ8Mt4b5suRXWjxOLE817tdhfTMpKa5fUn31L9Kv36Qofo7zgzhB+iGmsnwawWblH9ieswHhKMRL7xEVcBqQ2MaphmCGuLGs452pnESVCn4UUFmnKX8qokDjdpH0hHxvD1XushPBokflpZgO6cnYx7R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(376002)(136003)(39860400002)(478600001)(8936002)(6512007)(5660300002)(86362001)(26005)(41300700001)(9686003)(6486002)(2906002)(6506007)(83380400001)(38100700002)(186003)(82960400001)(66556008)(316002)(8676002)(110136005)(4326008)(66476007)(54906003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SVHxfeabuhiW25UQjAcjOcqKNbv3AZXQWhfmFTZHosmvPwiDsWrAtADLs3oC?=
 =?us-ascii?Q?OtD8HQZWfK6xRXzm44I2l6UoHkFeKmR31DgbgGxYIRpB5B96rtt5mzxyqll+?=
 =?us-ascii?Q?OO2Cn3Gu3ysRPjJmCKuoX86F8n2rKCsKsI30kUf6F9d9XXZlt3i989FGGMdo?=
 =?us-ascii?Q?VBfaU4KGPI3ilMK7DcvL7SIOwBczmGcXPqTEUDYJPUgwG+3QAlHckB9ofwyv?=
 =?us-ascii?Q?ZXmgVoXgLRlqJl7Je0OrMRRncUMWEKBUmFu/tluodot+W7jC5mGqYX1Rr3FH?=
 =?us-ascii?Q?nHFTTnTimtz+aKm2NQTdDLqv2G/a9vRtv8O6bYPIBpERG8tEKcQ/SFUHjYkX?=
 =?us-ascii?Q?KpEw+RzbCPeQ6o056MOBMNA4NCxRFYIzoJn2TGQZLk6q71jqZHfT0DKxruwA?=
 =?us-ascii?Q?WmPIHFoU8uwtpeqrntp+WmcV7zcSTrql303aej6tKful6S7d62JPNN9fcuBP?=
 =?us-ascii?Q?HjQUPNoA4ivvVdopIzy0kBDfvuscfJALHd3Ffi+z5tCgbir+soTnbbCtBYJW?=
 =?us-ascii?Q?JmMC/7d1GwE1eFMSFXhWwxHdtWHbGPqMqUc8ilSqmLUnZwIyzPkMsWfZS+HV?=
 =?us-ascii?Q?YYE8OMLIVQSX71DR1njiN2KQ7zU+Xo04I/wFoK37CPWAcewOceb+886zpIeC?=
 =?us-ascii?Q?OHxKVvp14zGn9enzLEC17T1wuB61cDm9CZlOODvfsisI5eNx3WpwH5elEW8E?=
 =?us-ascii?Q?ypawrh/q/00undRaMk5+hN3WTIWPitlLuMy9uRUvBD3yoGh3KaqJxblcf9ca?=
 =?us-ascii?Q?5vZQyshC8of503Dd/m/vVc2bGMVEx28EzHrplE73aKqzbM75NbGmoGg4Vwa1?=
 =?us-ascii?Q?FS3CM84jNyT16plvTJ53JgmdwTMsL/2C3eq4HYvxGVEXYDMlw3Sqn1kUIsnU?=
 =?us-ascii?Q?Wb8Jz4qA4sicdnE7WBMXTiokmTuRp3i6aNXM/OqifsvQeakIhAdcWv1jzDYw?=
 =?us-ascii?Q?IX5la+xzBpVvQwTvmhFaLBgMUosY6WVbFYzUzMeLS2dyY9ZqCJuHQyZFfchZ?=
 =?us-ascii?Q?ajg8xfztweTL3tINjCBmWmUf2MY7faOt195e9rVhnWAi+zZ8agZEHMpHH3Ff?=
 =?us-ascii?Q?Xo+V6YBmYZwptreAg3RT7qb3qSFi6e5SY4gagGYkFmJMkOfgN/tgXUscp4wi?=
 =?us-ascii?Q?l892CxVfkTEVuyeui8iPvR8FTs/TqxCrdWLGicrLeblwnP30Slm5KSm9A2AD?=
 =?us-ascii?Q?vKnZZFZmjgA4LmQ872gB5qa0C3+FV7UIhjfkvhQfzBV3IuXbqKKmtadzIjt9?=
 =?us-ascii?Q?yynXPJWiT9V7T0OBEhfpjKIdW5jwhx8KlDPuXKQ0ralxK3w+kGHy24Nib65O?=
 =?us-ascii?Q?Qvfddbqmhhpwe2Jhq/CjL5CCCht7QElTS7qbKwdvidNe7wHQAwKUIodIlwlI?=
 =?us-ascii?Q?EY9hE/hlMwOlzOL/HquPz2QV185RbZmIEJ7l1gWxhAlZwOhux6hgE+WTlUjo?=
 =?us-ascii?Q?lqMEz+Z7y7Z/EWqZYUrnNyPVU8JLD5iqjzVWz5vluMtLT+lcPOMpcmf2+fPB?=
 =?us-ascii?Q?Lp6udMZBacEmxqskbXcGcriA/8UyDuEwHtJbIW0MUbqczAU3TV2n7ypnffA6?=
 =?us-ascii?Q?6fr3N1xWoeYUnorfnWhTyanw9Rdwzz6NXcx7vT01UUfaYH/fpBnrok/4kf+3?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df89ed6e-2d42-4049-c629-08da69da1e1e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 22:57:55.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCTSXq7iOANdGQYuvQ0eW6VrJyKH4VSBn8Q8ktYRp4ILIerc7ZakZ3AZcO7awSFgWl/fYYoptSsdYZG9m1W1hUeCD5Xq0zZ8bJ4SX54U0nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5345
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> 
> Details of changes are in the individual patches.
> 
> Major changes from V14:[11]
> 	Pick up Dan's V15 version of the CDAT patch
> 	Fix up 3/7 with Jonathans cleanups
> 	Drop valid check patch and deffer to ACPI vailidation later
> 
> CXL drivers need various data which are provided through generic DOE mailboxes
> as defined in the PCIe 6.0 spec.[1]
> 
> One such data is the Coherent Device Attribute Table (CDAT).  CDAT data provides
> coherent information about the various devices in the system.  It was developed
> because systems no longer have a priori knowledge of all coherent devices
> within a system.  CDAT describes the coherent characteristics of the
> components on the CXL bus separate from system configurations.  The OS can
> then, for example, use this information to form correct interleave sets.
> 
> To begin reading the CDAT the OS must have support to access the DOE mailboxes
> provided by the CXL devices.
> 
> Because DOE is not specific to DOE but is provided within the PCI spec, the
> series adds PCI DOE capability library functions.  These functions allow for
> the iteration of the DOE capabilities on a device as well as creating
> pci_doe_mb structures which can control the operation of the DOE state machine.
> 
> For now the iteration of and storage of the DOE mailboxes is done on memdev
> objects within the CXL stack.  When this is needed in more generic code this
> can be lifted later.
> 
> This work was tested using qemu.

Looks good Ira, thanks for sticking with it, thanks Jonathan for getting
it started and all the review plus test environment, and thanks Bjorn
for the help steering this away from an aux-bus mistake. All applied and
soaking on cxl/pending, but will move to cxl/next shortly.
