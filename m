Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A994678D28
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 02:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjAXBOY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 20:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjAXBOX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 20:14:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED3C33451;
        Mon, 23 Jan 2023 17:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674522862; x=1706058862;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/kCFmxo/f+JOS8yU2geSITRq6EGDMXsfxLpT2Nx75JI=;
  b=C5hoeHlsg++XuBB/E3IVy7NcOoc0agM1/lYTkcY1hD4ERy8/GYmqfnzD
   jkoiV//s1Anxn7G5lcw7mb5AEyaa7/R0OnuS0fvGWzEonlZjL2sL5wbEk
   BQkxtyvbR2OFkunAO/+IOciqA0/lTeM//pX1qumExrlnMbZ+0cN7Oges6
   lOVR2ZNmSS72a5iIzsbJN9tXuG9PNYrv8rEfjcDxEv5MuzcZjsMDaH3m2
   GwcqDfU550LkU5NTCmkvNT30v7bDVHeZjSt6g4TnblvrFBJ8W773nSovp
   /rCxEH6w+He/zsoqnK5iMMJD3ffBMiI+0PawEHjjBGNH9mnJpmw66CyWP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="314105891"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="314105891"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 17:14:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="750656372"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="750656372"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jan 2023 17:14:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 17:14:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 17:14:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 17:14:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+k9QMabaKFK/foh1I6XUvuMdyOPvDNw5ZMZqANp/3nID34apbZYy4sJPuknhC63LSQWHvG90H9PVxjEZFb+/qGAgjQ7rIa4w9ZGaVvRvdnQZ0NhcPE4R8rWH7SfrWksq+Lp3vS1XtnjTzk5xQYAQTNNOC/flq2h8qN+xOuzj+LUYfoYzn4HQasFytHkENBhl2gR3DdahXJO3GEMLlLyiQen0JM+3MJ4w4D/TIVHWMbiVN6ZramUPrACAcsKmxUZpeAYQUCpo1G6ouDeaIvVEfUjQ8IpbScdMdFKebFnfjAxviF9yELOlRp9xEgMaE/vUrfBs+2EMK/uOW081k4KJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJO+/PM6lk3my+5LreR1sPLTdBuz+51iPQBLFz6nlUs=;
 b=NsifxRc/CuXSfBh7ywgCGSTkzquc/pLGzM11S1J0HaitRI3hkqaO+XxvVceHTx4wA/A5M66NEaDSU4KOO8htSDgCK+l0G9eH5pUB2l6dF5E1kW5/FgMBJNlLGZct2W7iYV58B76jP7kp9S1eZN91fnAaE53S7pKd+TZkrVMjv1dpDfHjBwR/Oged37WVgpZWC81R7t6mKHntNYvYtdezgKb5M8qdMbLFYiFXqwkaVKglaZTGKwf0sJ4xR3tOT/9yM+Vk8ZuLvduh5k9CzWG9rxAymv6yz+Vv5r+wQqfUdAAtkMn7WX63328LkEhEK5k2tImrj1UXp4lVYYH1+PlZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 01:14:13 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Tue, 24 Jan 2023
 01:14:13 +0000
Date:   Mon, 23 Jan 2023 17:14:09 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 07/10] PCI/DOE: Create mailboxes on device enumeration
Message-ID: <63cf30e1136fb_570929481@iweiny-mobl.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <5b03b8f4d2d04cf7e4997c71daee667c73eb427b.1674468099.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b03b8f4d2d04cf7e4997c71daee667c73eb427b.1674468099.git.lukas@wunner.de>
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: 28508731-1cc1-4a38-4ffd-08dafda84dcc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZER+FkZQfXnJeTzbRRwQVrs0jRdPk0I+Ws9H0QSDlFKBw5dVeRE/9rmC3E9xzr9qhw32XcrMwMwq93VPxNSEblR8mRlCqXYnxEj9Z148gvbXCsaO9Ymi4hvI6Nvm3ka/rzTfwb8zVH7+RBY70T3G+dJntNpMTDR7f9I/3KiKUfIICjV+shTY2+txU8oXZgQMep9qF+flNI6POl7reTNSIArcoNfUiBxHIcC4jQ6OsUL0gTZM+uJbQxiTHyqQj/llTLWAqP7iLJFgrZZWvN4pJyn/zfhzFQnmsyymQiCyoTTa059Sz0tby34wIRuHqFQLUHelVaovc2DbaD6Z07JKs7VzyYetE5qj+RuirzvhbXnFQW/XsEwj4Uis1QFCJB66466a+K1HpdqeNdUVvKB3ULrqEdNqsf11xjmk/veB74pIlHesOBoLMq4Kg+76yU9I/ZrTIge5fnqjDx0f0I03CMFjClFImOsVHKMeDJaFoStwUPv2/U0N6PezoGcCBvl/9s04+SNI0sASY4vi3GA4+ne/WPiefxQBAs8zvwK7XXyIcZWhS/NKpWCBKo6Qfg5VVa1fBD6KK5uJyfU8z5X1vgEzaT9buBLYVP10JIwyMYOE0kWU7J/qh9aRUpNWLVW5MBIEKWci+vj20f8lF2ZZGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199015)(8936002)(4326008)(8676002)(66556008)(66476007)(66946007)(83380400001)(6486002)(478600001)(6506007)(6666004)(6512007)(26005)(186003)(9686003)(54906003)(110136005)(86362001)(44832011)(316002)(5660300002)(2906002)(15650500001)(82960400001)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H7YyPhObGDDuLbgvMwpxUeI4+zrnFqqxKBswz3R9fFF6JdGf5dDcB+O6dKWA?=
 =?us-ascii?Q?nB9NfChtK7/U9vX+Mu02E7Ua2jlYNvZl2wb9IJNmR6fBOzBUjSsFzGLOXyNX?=
 =?us-ascii?Q?H3pxGDRgDs3zXmQqQCWjzTeyjAwAtPIS/HRKeHJjcVaB+Mnae+YXW2WxenDP?=
 =?us-ascii?Q?A9T0m1GCXLU8HS/y5hmqhudF0f3UAj1IpvB6fbV0nv36JnSHF2PkkNyE2BXn?=
 =?us-ascii?Q?GVXPGaxKxkJYYXDBfutgCmR0jCGbPDXtgey6R1fK9ozXHUsPT9edq8jRZU2I?=
 =?us-ascii?Q?z2EuG6CnwfYELoBwSe+Q5KTU0DorHa1Rj0k+uY/KAVOM1MJjj0ChB95nBVrz?=
 =?us-ascii?Q?2qmY3p3Mmb56ljH/ZWiToj9bGkJcxUMYuQVSyJ5RB2LEmNQSvAJh9TADxbs8?=
 =?us-ascii?Q?s8hN6vhLaIq0L7zs5tAR3+j4LlsQSNM7yBpzsxNQoQQ+cJh9jJB4WQokRXVC?=
 =?us-ascii?Q?+sVwR+HWPzSF6hcVno1/T2wGqHp863/XtqNzUnkQMKZMAmJusYj9uwq5qmp7?=
 =?us-ascii?Q?FvbUcaDS5Zma5KpEqaGrqIFR/ju3T2qAcMIPfIg2UUKIJX6KpQ5gHy7woEJv?=
 =?us-ascii?Q?Y/rTWom6yx9SKGlj1rNIkZ77bC4NqfmL3Ej4ePV4vVwzM/5XAlrPEOpIIz8f?=
 =?us-ascii?Q?1PGFZBZxwnapybNxFWsQfPFiMAqjAnU+gHvfdMUnaJmSGD6ijzgFMszBOgB6?=
 =?us-ascii?Q?S8iYXu/UJwAMFf5MAwc0dtMpkSl1n9GGVSSHb90pxsb9JX63ndSdWuhIuoFN?=
 =?us-ascii?Q?KtrAwo29+FBfRykzWy/bdKl1U8eLMaO45dVJNO3e/M3LPfmfiIGXCJmQVDQQ?=
 =?us-ascii?Q?2crSn5OunufWaDvIT1zqWLy8mTLohZVvNQxmHtcwICffhRx6O7VwoQec8/ga?=
 =?us-ascii?Q?38rylKpsUCUINEftFJNnmxU421e1g0X3/hDVdlnOWIKj187KxmrYSRPU8PIK?=
 =?us-ascii?Q?62aXIIiU/HgEkWo04Nqmz8p8bjQECc4km6j9O7C2DT0f1dZEt+v5pWdNOiV+?=
 =?us-ascii?Q?TcV2mWQXJF+6PtrM7zjsHQIWzh1cXFaveFhaezfcirA4OMlETI3iHDgpDA0a?=
 =?us-ascii?Q?JMkccXnEnXzhFLV+gaIL0ypn1+gF82h/5bMV6IEw39B7scGsTo4TE4D9O97x?=
 =?us-ascii?Q?Sxa37nx5Pn3KVEe47IIGHJhRp07ZyA/PrACWMWxRirEXXNwUeL0falt7xaHO?=
 =?us-ascii?Q?F7fLJ9B2baohp5VcGaVuzGKlRYaztyo2TmeAdw6ApOVhbwk1wkcTg3lO0VRM?=
 =?us-ascii?Q?jac7KTWe8oe61FAbJvyy6k5jMAmfZ51/E19GUEVLA8vEmtgdKpE6jx9/o2OD?=
 =?us-ascii?Q?EyFwvqcgNwllT8lXvsZYMNjg6RvVGAjyr8zshJQVy/osvLq323VpMFTO/dfQ?=
 =?us-ascii?Q?6d1nrVS/cXVpaQY4GvQc02INP4FGygS4VzXNIMqQtdTlf2s2FkPC/w5Y8zGN?=
 =?us-ascii?Q?MJ2qX5aHyFRp7lPmY4aoouvkxajn0KEckRtF/03dtJmYAtAnclZOyTWtAnXD?=
 =?us-ascii?Q?1846zdk++2IPFtok9UOPQORJT+7V+/UILg1bEZ9ofcQn4CCR/4DgM26NBuIu?=
 =?us-ascii?Q?KRPpGjEN8fOV5PbYZfJUIhEmo+kZROv9SJLjAvHFv5Q3gWpsBzvizuOV5+Fl?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28508731-1cc1-4a38-4ffd-08dafda84dcc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 01:14:12.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73xSCGz1R6Q70Pr2ehOhMaYv22cZSJBvVUFkGIUMcejrMmkA9r6+3h8xaR0V3qUBfTgA514ZxPIDg5AAU1ASMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
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

Lukas Wunner wrote:
> Currently a DOE instance cannot be shared by multiple drivers because
> each driver creates its own pci_doe_mb struct for a given DOE instance.
> For the same reason a DOE instance cannot be shared between the PCI core
> and a driver.
> 
> Overcome this limitation by creating mailboxes in the PCI core on device
> enumeration.  Provide a pci_find_doe_mailbox() API call to allow drivers
> to get a pci_doe_mb for a given (pci_dev, vendor, protocol) triple.
> 
> On device removal, tear down mailboxes in two steps:
> 
> In pci_stop_dev(), before the driver is unbound, stop ongoing DOE
> exchanges and prevent new ones from being scheduled.  This ensures that
> a hot-removed device doesn't needlessly wait for a running exchange to
> time out.
> 
> In pci_destroy_dev(), after the driver is unbound, free the mailboxes
> and their internal data structures.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>

I rather like this.  Much cleaner, thanks!

Minor comment below.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/doe.c       | 71 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h       | 10 ++++++
>  drivers/pci/probe.c     |  1 +
>  drivers/pci/remove.c    |  2 ++
>  include/linux/pci-doe.h |  2 ++
>  include/linux/pci.h     |  3 ++
>  6 files changed, 89 insertions(+)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index cc1fdd75ad2a..06c57af05570 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -20,6 +20,8 @@
>  #include <linux/pci-doe.h>
>  #include <linux/workqueue.h>
>  
> +#include "pci.h"
> +
>  #define PCI_DOE_PROTOCOL_DISCOVERY 0
>  
>  /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
> @@ -662,3 +664,72 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
>  	return task.rv;
>  }
>  EXPORT_SYMBOL_GPL(pci_doe);
> +
> +/**
> + * pci_find_doe_mailbox() - Find Data Object Exchange mailbox
> + *
> + * @pdev: PCI device
> + * @vendor: Vendor ID
> + * @type: Data Object Type
> + *
> + * Find first DOE mailbox of a PCI device which supports the given protocol.
> + *
> + * RETURNS: Pointer to the DOE mailbox or NULL if none was found.
> + */
> +struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
> +					u8 type)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb)
> +		if (pci_doe_supports_prot(doe_mb, vendor, type))
> +			return doe_mb;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_find_doe_mailbox);
> +
> +void pci_doe_init(struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	u16 offset = 0;
> +	int rc;
> +
> +	xa_init(&pdev->doe_mbs);
> +
> +	while ((offset = pci_find_next_ext_capability(pdev, offset,
> +						      PCI_EXT_CAP_ID_DOE))) {
> +		doe_mb = pci_doe_create_mb(pdev, offset);
> +		if (IS_ERR(doe_mb))
> +			continue;

I feel like a pci_dbg() would be nice here.  But not needed.

Ira

> +
> +		rc = xa_insert(&pdev->doe_mbs, offset, doe_mb, GFP_KERNEL);
> +		if (rc) {
> +			pci_doe_flush_mb(doe_mb);
> +			pci_doe_destroy_mb(doe_mb);
> +			pci_err(pdev, "[%x] failed to insert mailbox: %d\n",
> +				offset, rc);
> +		}
> +	}
> +}
> +
> +void pci_doe_stop(struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb)
> +		pci_doe_flush_mb(doe_mb);
> +}
> +
> +void pci_doe_destroy(struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb)
> +		pci_doe_destroy_mb(doe_mb);
> +
> +	xa_destroy(&pdev->doe_mbs);
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9ed3b5550043..94656c1a01c0 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -777,6 +777,16 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
>  }
>  #endif
>  
> +#ifdef CONFIG_PCI_DOE
> +void pci_doe_init(struct pci_dev *pdev);
> +void pci_doe_stop(struct pci_dev *pdev);
> +void pci_doe_destroy(struct pci_dev *pdev);
> +#else
> +static inline void pci_doe_init(struct pci_dev *pdev) { }
> +static inline void pci_doe_stop(struct pci_dev *pdev) { }
> +static inline void pci_doe_destroy(struct pci_dev *pdev) { }
> +#endif
> +
>  /*
>   * Config Address for PCI Configuration Mechanism #1
>   *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1779582fb500..65e60ee50489 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2476,6 +2476,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_aer_init(dev);		/* Advanced Error Reporting */
>  	pci_dpc_init(dev);		/* Downstream Port Containment */
>  	pci_rcec_init(dev);		/* Root Complex Event Collector */
> +	pci_doe_init(dev);		/* Data Object Exchange */
>  
>  	pcie_report_downtraining(dev);
>  	pci_init_reset_methods(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 0145aef1b930..739c7b0f5b91 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -16,6 +16,7 @@ static void pci_free_resources(struct pci_dev *dev)
>  
>  static void pci_stop_dev(struct pci_dev *dev)
>  {
> +	pci_doe_stop(dev);
>  	pci_pme_active(dev, false);
>  
>  	if (pci_dev_is_added(dev)) {
> @@ -39,6 +40,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	list_del(&dev->bus_list);
>  	up_write(&pci_bus_sem);
>  
> +	pci_doe_destroy(dev);
>  	pcie_aspm_exit_link_state(dev);
>  	pci_bridge_d3_update(dev);
>  	pci_free_resources(dev);
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index 7f16749c6aa3..d6192ee0ac07 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -29,6 +29,8 @@ struct pci_doe_mb;
>  
>  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
>  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> +struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
> +					u8 type);
>  
>  int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
>  	    const void *request, size_t request_sz,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index adffd65e84b4..254c79f9013a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -511,6 +511,9 @@ struct pci_dev {
>  #endif
>  #ifdef CONFIG_PCI_P2PDMA
>  	struct pci_p2pdma __rcu *p2pdma;
> +#endif
> +#ifdef CONFIG_PCI_DOE
> +	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
>  #endif
>  	u16		acs_cap;	/* ACS Capability offset */
>  	phys_addr_t	rom;		/* Physical address if not from BAR */
> -- 
> 2.39.1
> 


