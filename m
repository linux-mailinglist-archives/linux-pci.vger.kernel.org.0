Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B68692C6C
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 02:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBKBGY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 20:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBKBGW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 20:06:22 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F6A75F52;
        Fri, 10 Feb 2023 17:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676077581; x=1707613581;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BXBBUOhekBTxra7kUdTdDz4fyFRypTr2XL93Sh+lWCs=;
  b=O4l0487r59IsVJj3MSjD03fHCIBWYxpvioQRaZP/AikM5Hvu4OBzP373
   IZp7qDnDb9vSm4iNCA+ksK1RIUyrUWaPOGNX6QEPQ9A0eHemCgLFUB7W2
   5QZ853zVmHdQaWcIhDPDH1MMSTHavRhqP4OksoXuJL7pUxqmXcHANOmNU
   fQ7zueQqOuq1DlTD7mXUYN3pK+BMo6LzEOz3GzDu32hzDK8lnr9nH+XWe
   F3UcOi43hHW6Z7tAsAdbobCkF3m0u7bd0m8BmCpDZSbr6hfEA+pvZ3xPj
   v2kJKkfjMOFALcZQb9hkcH1KoNOrI0Foaud2Z69xJ25ThxIWk9lNNwtOR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="314209519"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="314209519"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 17:06:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997124915"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="997124915"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 17:06:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 17:06:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 17:06:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 17:06:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpYhF2XCL1GWO2NAVM4quxGwDvnHf8d+iS3uHoEIjwhpYXf7jQ3i6XngTeAYjzwUypSeDyMqg4kC02TDCg1eOHCYRE8i1kPPooE7M1GlYSyqhbZKSNsYdaLpqz/HMhuOPYwb52s2wnIrBLvouykNrv9zQxaOJy0pcaq0U+FyxnqGGf/QXA93sFAq8ZCxDV8wrqXU2rSubT+fAjwpjzlOuwmVUuQgh/KJxr48umBbFIxOryiiME9D6uwhkKWa8JWgqBb/Yme66S4ecdliBZV41RVYya2grdsn6jbUpD33Ft7mxTSEZV2dYglX0N6jcvxhMBx4NBe1AiVv1Rj7XhQ5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PU/AQE5fR2J+Kib3v9paRNUVN1DQAiewvWnhGyxCrqE=;
 b=U9pLclM/WM0sTJcnnGqzX3kc26uvkzSNEb5KxnMRTojKPmhICDuGdOLB5vKl9eExpAU7RzaHVFfKn+ZQhM4yKNg+X2d5hG0PICjjaxmI9IHQn3htqNRPLu9+ksJNHLA7xBgUK1/GT02u+giZHg4ckZoR0JRjx5bAjCWExMI6wJaGV/oSugfJuE1YWpF5V/bgZaWog08OdWkEqJvPIVh8Cv0523i8P09F5Q4Zo0EUUi4L06HAcQ71yqhN+fpmMFLSlHRl5+AIjlYRRDkOpuls8PuDFXHDstwKvgl5yGaPBdXqfsrnpHka6fZn5WSwOQdPs4vHgg56TVXQhRys6ESMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6973.namprd11.prod.outlook.com (2603:10b6:510:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Sat, 11 Feb
 2023 01:06:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Sat, 11 Feb 2023
 01:06:18 +0000
Date:   Fri, 10 Feb 2023 17:06:14 -0800
From:   Dan Williams <dan.j.williams@intel.com>
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
Subject: RE: [PATCH v3 06/16] PCI/DOE: Fix memory leak with
 CONFIG_DEBUG_OBJECTS=y
Message-ID: <63e6ea06909bd_1e49432943@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1676043318.git.lukas@wunner.de>
 <53bd8006bae1385905eec702c97f66695363c527.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53bd8006bae1385905eec702c97f66695363c527.1676043318.git.lukas@wunner.de>
X-ClientProxiedBy: MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d115d99-2803-4037-5230-08db0bcc2df9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQhV/pOe+yOLwatdOSfy8/cd3DMvAb7Jls5V0zUledcIgrtkcxdGuM5Ht7hg+qqhcOLQoWXdCZJxXEnCEldRTan2feZiWP1TlCwou0rAFaSFdBldV7QslH6crslnodxMX6G6suIMaRAL+tmzLcsYmdkBpqHkBEVOVe+3ltdbD4EQZ/BcLJVz4B0LS/52QtdbPtDXzANUTQp0oesJgDDSK/DNiuHvKKOZw1uBaGM3i7ndx3WDo43XvIYVYtCPJSh3thM95Y8WmaxTaXx5Kdnmv62a9+xFMZzn90po3RCiz+xzUjd7FIaA/ZQ9t0h2gQW/R+7HcOtQ+jJVpvw+VDUvFQ4aNMS0vphXQfekjIB+gqSQuOBgKtorpMiSQs+xWBvf9usytpm4TlChyh3pnwPAxx8r7gfT3ROh3H+RqvaQqPed+qLOUo36x6n1keYsRLcetUWxy86Y5xNy7KVmBfCFxAoUPAVAKUXUnPT8tezL32j/AfAuS75Cu6mSYbWii7fs88WYX/33nA+3bk3u1JZL3p9dbZS+Ehi74+OBNlSLdvgxHTigLT9viD/w44j8AmpQysvuAhf/7FZ3c99sTuz2A/ls8G1txJRsW1jwRHql0i53X974XzISz/FO7yD3ZbgVDq0nBv+kelP8K/2iPHebLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199018)(6486002)(86362001)(478600001)(6666004)(9686003)(4326008)(66946007)(6512007)(83380400001)(186003)(6506007)(26005)(66556008)(54906003)(110136005)(316002)(82960400001)(41300700001)(8676002)(66476007)(2906002)(5660300002)(38100700002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2XVIgBRs55Tr0DtDLVsetmAiyFF9jPkc/zFaGaM+2Sa+3JHQqSOuchh1aje?=
 =?us-ascii?Q?lojwN8mlJrT6o/jP9bZ2D8d/2MfyNqClFcWwwwlFgW0cgBkLMln2OQA3qmBG?=
 =?us-ascii?Q?p/hQie0ZvxhP3Ut63E6WRWC5T0CrOX2MM9XcWK0N0uqz4lZWh/BARFQhBKRS?=
 =?us-ascii?Q?75fMMKIVsbR007yH+s7VJ0bktuT91e3n6cfHaW2u+Smt8m0RT+LDsss7ANhU?=
 =?us-ascii?Q?CZWFR8YO97OLITrdi4LppIeZVTGalF/KSDjBMv5S4tZEHnyV1soETGMM+P0z?=
 =?us-ascii?Q?clROjcSsPqSWFGPCQZvjyW1vmr0ljjGUuFg9p50bEpwZ9X9odTdwiUNHWZlS?=
 =?us-ascii?Q?Qyl013WhhXfCfEC0XtKMzK0nIyRsT0j3WwxKDPM+WOj/OL0cL8mY3pFa5aor?=
 =?us-ascii?Q?Z1lKo5DaUe55L8LINV7i8ATjIq4VOhDYSb3dWpZPySFvVWTMafNE0aV2/ruH?=
 =?us-ascii?Q?rsQdeuUFtu3T2feHdqBkSP/SUGIC2NOB4/EVIIAN8RilaS/A34OF5M3ee9FF?=
 =?us-ascii?Q?zBULgF26zxyvav69XJX7LHvIGYT5Oyf6pnZ0Yv3iGnNH66QEb0HmCRn0aEUU?=
 =?us-ascii?Q?5022Qm8bU9Gsq4ftuAuYRBvKou8v3xwozc1/sbQ8SAtfYcGDkK8Ziaymnu2p?=
 =?us-ascii?Q?f8uMI+QgYNdFOy9mlTgaO4EsKCSpNjZfe0l4qJCf9EQkNVjoWyb5pEjm5LnM?=
 =?us-ascii?Q?ijyAfW9O1Z6Ty4F5y+KMaqNBoZwQ1GZ/sFcm2bqeMqiCyBKJ5h88tVd+riHY?=
 =?us-ascii?Q?LNsgmQrqZfXHaTJfutAR0zPAF/TzxpjCALsb60rYfn79lYm12gPrdGSwxm9c?=
 =?us-ascii?Q?nwK4wpx4+ra82+tovLqrulb9j42B29LxaQf1eXBa8M95AasXSWaxED8qLklH?=
 =?us-ascii?Q?earquINogpB7ILcEF46Jqb9PWmdA7iXRx6sIIYjnpet/Jxzxp3N8F7OleLHq?=
 =?us-ascii?Q?3aTjP2Au7t5vvo5/WYau9qh6jfvXQXlui6nXoy1CKJ6lWdfV1BoFCru6f1ge?=
 =?us-ascii?Q?cOogHCKPFdST6OnHsfbavbbb/L//NQAVmO34FsS4e08HS0ts84Szt0o7YBjv?=
 =?us-ascii?Q?73noHpAyCXl8+j0srjePtupZNpfO95XHSpWeHpZZcIMhhyNw/UGNszt/vU38?=
 =?us-ascii?Q?Cst7tVL1HsDoL1N7S9BKqJ0QWApaT+n8I1dMtSvbl8PPueOFNXKIiVtim7gS?=
 =?us-ascii?Q?leztA3G8tdwHtOYh/OCR5sdhkgPSgVkAHvKEt6/8uNxH1nf63+U1r/xZLqAD?=
 =?us-ascii?Q?HDSe3IlQhAG1GfCWGP1U8dicwppaE19dPtEOcdMogFuLusXVT7cUx8/teE7H?=
 =?us-ascii?Q?mcqguVL6N3oSAThSPQguqmYvMJLzJ42RBjmMc35Ho1Tq9p3k8SblpGMgxzTj?=
 =?us-ascii?Q?g+p42NhxHXBBGNgR/fHsm8BUdB+N6Vk3WFhYLbyRv0z3gBSCZQ2yopDb/oIZ?=
 =?us-ascii?Q?Gxq6FqZqfi/Of7R1pEHxx6bLNX2n54KK3QSJYxz0uAxMHXkhA3dMr3a13aMQ?=
 =?us-ascii?Q?0X8eObjfZYqrhXTIwjeNhtJLF9XfueVIjGgiTyBUoUKgnulGd2NYJSIQCL17?=
 =?us-ascii?Q?2RIuZoEN65OKfhNcWoNZ53HO2gbSyfJ8FhovcQurbrRvowRtqdVjwivUpmIM?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d115d99-2803-4037-5230-08db0bcc2df9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 01:06:17.7480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FRMEBReIrl5R6pxQe0c7M+menuLHnPDrFqq5g755CD5D/Na0g0xTN5upBID7mgQxz7seFnI7TZotbwDRWSGRq16nX0Icgy1HpkHsqguMjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6973
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> After a pci_doe_task completes, its work_struct needs to be destroyed
> to avoid a memory leak with CONFIG_DEBUG_OBJECTS=y.
> 
> Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: stable@vger.kernel.org # v6.0+
> ---
>  drivers/pci/doe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index c20ca62a8c9d..6cf0600a38aa 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -224,6 +224,7 @@ static void signal_task_complete(struct pci_doe_task *task, int rv)
>  {
>  	task->rv = rv;
>  	task->complete(task);
> +	destroy_work_on_stack(&task->work);
>  }
>  
>  static void signal_task_abort(struct pci_doe_task *task, int rv)
> -- 
> 2.39.1
> 
> 

For 5 and 6, carried over from the v2:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

1 through 6 seem suitable to go in as fixes at any time.
