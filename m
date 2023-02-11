Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518F4692C48
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 01:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBKAu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 19:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjBKAuz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 19:50:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B597E02E;
        Fri, 10 Feb 2023 16:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676076649; x=1707612649;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ld6KBYGKe7eDjgJV/5qqToYK2PQYWawdqTBTF+Nsiik=;
  b=kxxetHlsLOWKVB/BaxKRTxJpojqICobE8ze0J3soJgkCSv7Syhw3bMEY
   Z8a3WnNAyaokfc2mNafv4JkniswrU8uGGwONs7MRfx9KotY/MvcFqt6XU
   A24N8Q3wtPGfWxY3OVdkFGf1YnvmGrko7clBL8VTNU2xZoefF0sP4w0zV
   P+dBn2dV+1zVAOXf/f1rOo9S+C2p6fVzIKyKN4t+b7bAbAUhTrDBls/Pz
   HtYX7Q9fakyMI5+wAxcvfXzPAWUkHzOmY9swRJs3/4o4P66z3vCR5lquU
   QYBu5YQfaoyFRYgVw8M4IKW21ZQxBCBp7t4HVfLx5aqik0t5Mld10PxSt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="330575040"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="330575040"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 16:50:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997123195"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="997123195"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 16:50:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 16:50:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 16:50:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 16:50:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wik7/Q7lODn2PLCOS0EDnzLvjPyIo966Ez7jR+QH6j90U8wNDPPfIprebtahc0+EXdeufHfWgwwCqaZwhWQgH8RtpPc7r0hRX3KwWShJUp6H27AdX9HVmvbqjTRxai3BnFjqUy7/viTxYaKt7t31+7MUz4Y3a0f2+UTjB/Yltvieofsoo6D61NQCntNAs+is/s9r+1dB62mdA1e0g69hIYKzjvKSVyDr90CbuUm4rtz7IuKJ0IWLaBPfu5i1ib1qDVnXulSE5+HSvdwHNdZvVJs7UwJXw2bdvHm3TBFdvrIcnALPMZqsfGsXqaOO9teocrkYUr7AUNT7LykP2l93hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XoPlI9Lmq16QxxZvCyJDGnuZ3eKbRMoINx5Gb3WieE=;
 b=XQwFsccgNoWHUlkA+p8XkbGKAb0+Wr7X+cGxGG9cCCgJa1rgWTMULbap2C9kne+lo+nRhYqa+fDBBl8Rl95OUesEkoTvpmYVqpSyZLMZ3Bt+ZyxwPMpTUDKFYocWLUVgrGVjgn+tiaXVbxLrCoCK8jnbYr5z2lXtL2qBfhNvDkUYhf7CLNr1UCXtW/l8cf3TngEjYPM8f9J7ueqn8DUBWF5M8HDzws+Ml8aTacrgpWiQIy71rRL/0EwLonuplyNi8g2Emci9iE6zpsUumwMzAxtXwvAEQYeJlKp4UmrhvGr/993R3rms/ayCJlW+RvOJnRsLlZNTVmViSxO+/SK54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7815.namprd11.prod.outlook.com (2603:10b6:208:404::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sat, 11 Feb
 2023 00:50:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Sat, 11 Feb 2023
 00:50:41 +0000
Date:   Fri, 10 Feb 2023 16:50:38 -0800
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
Subject: RE: [PATCH v3 03/16] cxl/pci: Handle truncated CDAT entries
Message-ID: <63e6e65e5e1f3_1e494329496@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1676043318.git.lukas@wunner.de>
 <5b4e23f256b3705360d84eccb9652e4b558a77b5.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b4e23f256b3705360d84eccb9652e4b558a77b5.1676043318.git.lukas@wunner.de>
X-ClientProxiedBy: BYAPR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b50ccb-c102-4a29-c4cf-08db0bc9ff81
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxk6i7amD8KrvT2K4QmhlkWkSxeGpdk/rBC7ryeO34L6mk6dScjBmqR1D82GN8Tz7l1ujbDib7BntKDtpUMZvzsBXuRCQWCCVsS5bFyveLXdvCQQVvJOcatGs1CTY16/6UmzWrBnVR/c8i2nrpyZ4zpXPBInWhdt2BiCxFtWRruFYSk2LF8GEFsmNsTyeaZ8ReRMiLDe1rvYQq3dQlqvhOwAAw/pgiHPU9KxO3/ShEaR1IrHhD2CBv7H6kvMS8EWDe+Bg3TDpFJ5gT3i1luItu+Foj4AUda6+zaqYGWSKfoJQvcMMBjj4L8zizNfK0dJYSHbZbPzk3bdyO1rq6ef9Sv9DM2KPSSJmqgAqNAQFgxZs6/PBBCF2af1Ik6HbDJb97RKVNcASZjyoPZSmQmkdJzIncNiRoT7Qvafeq/xI4O/vwWyg0ihE1tFf0F4ZDLnDW1w2SX/yxbgBnLg9Or2MGzdHmceCcKvzFgqRdAXxfhWA4KXEcF7m4/wwrl1vhfgPs+J0+ypEvzWh6NXE3QIW9ltYt+l5kz43itBjAbwtwL4i4qE92QAGFed1PSOdNiebsOl5J0Sc3LqC1939lYkL+oI+cN5P3LCeMDIlhnqme1YBFmGSVJCKZ8FdYs6wWypgHmevnFtArNrSW8ZFQeOdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(478600001)(6666004)(2906002)(6486002)(9686003)(6512007)(6506007)(186003)(26005)(41300700001)(8676002)(66476007)(66556008)(66946007)(316002)(4326008)(8936002)(110136005)(5660300002)(54906003)(82960400001)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X5AVFzoUnCyxRwFTvRgwc6M/lCQOSmwnUWADNp4UpPYzMwjowRhvdmAgMsA2?=
 =?us-ascii?Q?21Ymmsg5vKN7TfG1BovPOX9W8Z0T/Co7ocNF01ekwnHPEwD1IJRnNVFwJUsZ?=
 =?us-ascii?Q?TUl2vyfLYs77p5IJtyUkIXE6+BL+2S9mLcVgq2cXcTYK87BHsY3z3r0vGCMG?=
 =?us-ascii?Q?QmKnMMM+c5tLTlczxbvSLgFlYRlfBwE32DGtEKli7+HXooIvX18rUWLW2yWd?=
 =?us-ascii?Q?YDZIIX3Kh0G4/lTY3dpv0q/081KCsS/QSzzURBDAX7SJx/qHu2Qd4/SdHOOF?=
 =?us-ascii?Q?e0ELyBkue2fYuRb42u7TJjtPsK5jKFkJtHzDLf6PnhKtTZXLju7SEy4BGePB?=
 =?us-ascii?Q?yQg01jOOCxSHtF98sG2AIAo2Z62QMM2N6Zi9DEmixO0joODzB4zF8CV0Y7Yh?=
 =?us-ascii?Q?HvMoqzZogCt16mt9a3mf+n5ztZuJnAKKz9CmnZycKRwbXfqboTaXoUImnt2E?=
 =?us-ascii?Q?CocWG3cfZdZp9Sf+Ajifp8vrfRuJ8/Yp2Tbulo33ieggAsiKit4i/rJnSXXW?=
 =?us-ascii?Q?APJTEubIvpEbKQt66nZnVSZFWK+n64oIlz3W8KQ1gbWntzKCm8ufjYPZI3fI?=
 =?us-ascii?Q?aK3M2Sz1QqUdD2tB9ZUvZhtECoBOMSrHXyY61KyeUl4LTWK7JXoTPxZpm9Hq?=
 =?us-ascii?Q?6ciFc8tM9B6IiDupiuGYHtplX8yshvlPZAkHHbQqeCoph38UeqNQLolzTdN+?=
 =?us-ascii?Q?uh1gLYCHi0JZIqenpUdRhDGAvsIE5aQ8dgBdNzxGB10M1Ti4IyQHunNjKjK5?=
 =?us-ascii?Q?OYFNV1EzjBaaPLW0KYpau09XiyHuXQ5gYpm5+9hnRWgOduGV3xqVD+MggYZh?=
 =?us-ascii?Q?RyvQitsXHDI1Ivuix+B3Vn1/SsxhMJA68qx27jvetv4GMJBuwpIhayCJgrFX?=
 =?us-ascii?Q?c736z1o00nsRkOQ4R638d3z4zPxKjTQN/+7g3SMKFHTF3adqFcmxfDSER+LC?=
 =?us-ascii?Q?RyouFEjCmRUBccoBHs4HixHsnSwAJc1cgfbZSmAjZWBLn1krxkD1iZI2lL2f?=
 =?us-ascii?Q?EI5NlsTkGxmCXeCa7j482Y7fHPWM5tIEuvUo6O2pEpy1ltUuwiuO4Iz7/HoN?=
 =?us-ascii?Q?iKstCCJxhD1aesZpdi70kezkHzTs36z/um39N1Ag+JjchjOMsWkRcR0v0eUA?=
 =?us-ascii?Q?+QQUJC3vu6pFM08U3a61gtMF0aTU2/L7Ga/RR7VyvIG9L8iY7bM2uqnPHq4q?=
 =?us-ascii?Q?5nZp9AEn02jdoSA1UI5erGichCSs/wNQjoB3j4cAxvNf49ZoyQj2Sun3L9dj?=
 =?us-ascii?Q?LQKkktP7kTm96bWE0OxOCOkQCWmo6Ux/ciBsSpJoQF97Ol5e/IpeuvCwC+H/?=
 =?us-ascii?Q?pihfSCOtbR6xC9QhUu6x0dWEfhEH/dv6pwFc8WonuOe0hzgQZ4EOIHlVqB89?=
 =?us-ascii?Q?tz310yzRDk7/sMKuueVODRqKWeodpTtvMaAMQ0UxAouKB0k4qNvYs54HmKUQ?=
 =?us-ascii?Q?R/nZtfB8K63H72/+pedMN+Jfzq7AkTutQOFqChew9K64myKe+Z9ZdfwzHZSu?=
 =?us-ascii?Q?vZF3JlIxVbKe5bandlkeUeN9P9XjUM0ld9MZ7J8C8EaW16bSnzCCcB424QMr?=
 =?us-ascii?Q?N4STFonAvAH6jp+QADfOf2Aob6AMglXkHPUpB6Ro3eb4NSnIDRcFzC2VTNj6?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b50ccb-c102-4a29-c4cf-08db0bc9ff81
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 00:50:40.7490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbLuIKnvER2rixRa2SXMhrlimHbaKBmxiS0nbQqqMsorLbs1ljSKLm9karWvOVZBOpl/rM1UIYM6K9Caa7drmjhT4J2YiTxTxq5SPirD4Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7815
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> If truncated CDAT entries are received from a device, the concatenation
> of those entries constitutes a corrupt CDAT, yet is happily exposed to
> user space.
> 
> Avoid by verifying response lengths and erroring out if truncation is
> detected.
> 
> The last CDAT entry may still be truncated despite the checks introduced
> herein if the length in the CDAT header is too small.  However, that is
> easily detectable by user space because it reaches EOF prematurely.
> A subsequent commit which rightsizes the CDAT response allocation closes
> that remaining loophole.
> 
> The two lines introduced here which exceed 80 chars are shortened to
> less than 80 chars by a subsequent commit which migrates to a
> synchronous DOE API and replaces "t.task.rv" by "rc".
> 
> The existing acpi_cdat_header and acpi_table_cdat struct definitions
> provided by ACPICA cannot be used because they do not employ __le16 or
> __le32 types.  I believe that cannot be changed because those types are
> Linux-specific and ACPI is specified for little endian platforms only,
> hence doesn't care about endianness.  So duplicate the structs.
> 
> Fixes: c97006046c79 ("cxl/port: Read CDAT table")
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+
> ---
>  Changes v2 -> v3:
>  * Newly added patch in v3
> 
>  drivers/cxl/core/pci.c | 13 +++++++++----
>  drivers/cxl/cxlpci.h   | 14 ++++++++++++++
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 11a85b3a9a0b..a3fb6bd68d17 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -547,8 +547,8 @@ static int cxl_cdat_read_table(struct device *dev,
>  
>  	do {
>  		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
> +		struct cdat_entry_header *entry;
>  		size_t entry_dw;
> -		__le32 *entry;
>  		int rc;
>  
>  		rc = pci_doe_submit_task(cdat_doe, &t.task);
> @@ -557,14 +557,19 @@ static int cxl_cdat_read_table(struct device *dev,
>  			return rc;
>  		}
>  		wait_for_completion(&t.c);
> -		/* 1 DW header + 1 DW data min */
> -		if (t.task.rv < (2 * sizeof(u32)))

Ah, I guess that's why the previous check can not be pushed down
further, its obviated by this more comprehensive check.

> +
> +		/* 1 DW Table Access Response Header + CDAT entry */
> +		entry = (struct cdat_entry_header *)(t.response_pl + 1);
> +		if ((entry_handle == 0 &&
> +		     t.task.rv != sizeof(u32) + sizeof(struct cdat_header)) ||
> +		    (entry_handle > 0 &&
> +		     (t.task.rv < sizeof(u32) + sizeof(struct cdat_entry_header) ||
> +		      t.task.rv != sizeof(u32) + le16_to_cpu(entry->length))))
>  			return -EIO;

Looks correct for catching that the response is large enough to
communicate the length and that the expected length was retrieved.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
