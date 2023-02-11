Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE601692BE6
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 01:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBKAXT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 19:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKAXS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 19:23:18 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6697F7BFF4;
        Fri, 10 Feb 2023 16:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676074997; x=1707610997;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zMr5iumtHeuHU5nvGMeoPNTTPO9xpqnQ2XYuPm/3GcI=;
  b=jQh2C5ibC/N9zdccUXEo3ygJZk8CRVjfyD5j+/TsWcodBdNCKf1zzgCe
   q5U84pvmTaq/T1gOOKxWIPlKpDKeT2ilKtoecF4lhP0uT4+mfF518lR1M
   JV0z4O3ZcPDzlzvrPfiuJU47t3O4tCqd6YeicOgaT+L8KlxeD8W4iniaD
   SQNzuTUI3oYQYVszHLNyt/H5HB5N37gL89UumQEKPB/6ndoCKtoz8DDmT
   p7CjxncfeGi064McmuKH42yV0xk5lKxx4uN3+eZefuUOrVaSiAGkPbpmU
   8//mVIN5eVxLlCAp+txFGEH+0T+nxCPfOY+2bAh8AHNB4XDP3HS+PKXW7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="310925181"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="310925181"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 16:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="670180065"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="670180065"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 10 Feb 2023 16:23:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 16:23:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 16:23:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 16:23:15 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 16:22:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExeDUOT21RO3Z8HrW5Ilo2rmTYvuwdGBP7T7Abq+kbanwR3Fz/kQ79S256KJO7UeeCfBQMDB0IyYilOahZZLYvPEg9rywIOiPh3TN8uzuhzWpZ1MfmN6+qZm+Z6wU/7TCijCXdziz02jv+Fe9DPFktE3t2Y4dijw/24eojBXbAacBeN/XPw64b9GMRLN9izjO5xtQDRxCanAsOa1yeFQLbJy1dCZMV04iblUdhnIuQCRDToV1wjbyhkfEyKK8n/BcJuJIG0VILQoWPz2jUPjpYw+uLc7w7olGIKH8KdzJ7cSPE+8ueoSzro0SKUOr1NJ7rGmouttCH5wbQQwYFfkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq3PdSiDMr1GygOizifOS4ZN2zUIqiKSmly4GJKp6cU=;
 b=UQZ9pQ1veB7whYVUFUjIM6xAAYK7SBSgcmDEN3ITSTHNmdbuHY/EhAGEvWjmWLZIDxSoRWeIiT5wu2BlRMRoVK3/oAR5LgHYrvu4tQe8ZBQFewreYPpDuOFlxlf2TXynlqyZoO/Q/dn8nHq2jqRbnAIzOIIOoDuqiIc7SoWZc+kbEpe2TNekFAUvHKYDPCy/moHHoXjhRI0IoaPcuQC95lh8E1W+VyKdmznQH/nHgpqgG76pBNCdXOP9sl5zlHsNqz2b/iL9a2LPisiHKic2ZbcwM/8bPsAte7wHakrvdGzUXSBA3O+md3NyjVcxef1/u/GC9kvBRTEPFxwJRU5sgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6921.namprd11.prod.outlook.com (2603:10b6:806:2a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Sat, 11 Feb
 2023 00:22:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Sat, 11 Feb 2023
 00:22:50 +0000
Date:   Fri, 10 Feb 2023 16:22:47 -0800
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
Subject: RE: [PATCH v3 01/16] cxl/pci: Fix CDAT retrieval on big endian
Message-ID: <63e6dfd7cc162_1e4943294e9@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1676043318.git.lukas@wunner.de>
 <bbbe1c4f3788052865941572565aeb2be67a6770.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bbbe1c4f3788052865941572565aeb2be67a6770.1676043318.git.lukas@wunner.de>
X-ClientProxiedBy: BYAPR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 36842b92-7e4e-4413-7df8-08db0bc61bdb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXPy7+9TL+P3sDk34hAqmy4w93JSpKKBrJfXbg+w18Kd12spODvXv375fc1C3LQW1paTGDamIRhMA45HXONOG0YQgtOVLrcOwJfrn7QtGEPqM9Xels9auOsLuW0aNrqsJ+oFB9wz6MTRrf9IJLvh/Pqhv3e87wVhbopyclfzHj4WW4tISSmxOwS8xnzWbA8YRb7pvymWNg5W3NC5Y3dDICSN6bi4Y/KCaNWGbYTzugWvL3FTre1B6wU0TAQn2GDYB0RhbWro1oXOJtR5prKCK2jVBvMX1Uyf5v06Xa8S1YAOqrTADNJ4Pe2wPG8euppDA7IIGxRza5pgQtCrLlgh3m+rduxXVhsy05O3NLPkF2TT9f+zJJV5LfEwgE+yZ8tQxnzjH4SxejE0hOB70156Cx8S0nEFXFy4KDQmebGXJBpxN6H7CFBZu/l/rX6mEsjtngCLaqFbIjoJRjiPs84ozhTaUOvjNutDXRtGt436zrqNkv5BNdeXAQquD0C4rYCbQJd2AwkN0RqO7Ck+Y/Ct/tigbat93ovAE3nui0Af6VmcSIliNwxa0JDUyDDyWO4uG8RYdq82UfgVz3fxt/U27gg3CL92z66bbTUHsy1lZJBSoE2KUNiAqrqdVQ85XeLlKNXSgjbBKmqjueazHNTqqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199018)(110136005)(6486002)(54906003)(478600001)(6666004)(41300700001)(6506007)(4326008)(8676002)(66556008)(66476007)(66946007)(9686003)(186003)(6512007)(8936002)(5660300002)(26005)(2906002)(316002)(83380400001)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ba7ddNqYZsAG3Kskk5CgqMoP2fDD0z1zDoNZwUU99DZFXbc2r9IkVRq7ejsn?=
 =?us-ascii?Q?+vQc2AULerIUYGz5iC2+PypgkI7xT5X7FmhqyUBukpFndMCx/k81/BHx0umT?=
 =?us-ascii?Q?EuxUyhyZva1RxOCBLUuH9KMsfajCCZFRStqZIk8RJihmAcws5LnuhYbzNfNX?=
 =?us-ascii?Q?o6FYvKsPd2INSrkCiLxlFSqswlLoDAQxStE9W0Ct1My0zrQreblQIpCNxAZd?=
 =?us-ascii?Q?uX5DpnkHq+MVpGCawKfdibuYGfwzwkPE6VTPjwT/1l58peK5rXW5xgQxtpez?=
 =?us-ascii?Q?kmHOzC6Hztt87aIvdISWNsjrEJ2/XQH6woB6ZBMJ1K3i4gUXT/J+M99FxYk/?=
 =?us-ascii?Q?y8Yh/lFp8EnNIm1VZYY6J3LpxGawWyFLJZc6OKwBKCoknxps7y36hFcK4WzL?=
 =?us-ascii?Q?odyzsO1frmNuQM99vMX9D+lMFRCZ1+0eXzf6FubFdaNEC02BdGW9EIBOE/nv?=
 =?us-ascii?Q?g0gDHmy9nLA/QSgW2KxwrWfQ28AJgYBj9ZRF9ZjtFXT0YspWnKedThoY4iKZ?=
 =?us-ascii?Q?dkoAXULXaPxHzxvB1fQjwbEncw+1elsvv5Hwsc65AK0d1MEx9k+EGle40E1y?=
 =?us-ascii?Q?IKNvGsaTp4K/thAIzCgVzNdp0WA7LDZyDxfk4zV5qLG7Dt47mKGZu8LZptiD?=
 =?us-ascii?Q?Uy3jz5YyimeACgr5ZklC4OIWt2dnThC3r2Bdu3xA4tMd2PnxnJ9lxewXhC83?=
 =?us-ascii?Q?P5Qg+7FfVk43EAJGKmepCRZafO3F1vLSPdRanMypdgeoocghdbLbC2r5N3Cl?=
 =?us-ascii?Q?JrMso3h60tBgz28kS0dVom7UpHnUWEmZsMjHtPAu5o4wjn1s6TEpXr9mVVYd?=
 =?us-ascii?Q?qrfdN046XWKifPV+HF4sTBADeL6MOsIhICfTFgz+dprXlHUCbqCW+s0i+TYe?=
 =?us-ascii?Q?nie+lT3IZUixd+mTHqAaxVX9F4FcFIJrHuUhaLRyGdiiSSqWMRt2N4TTf1Qq?=
 =?us-ascii?Q?uc2AAMAQoD4H5kExK+wdtg0cpMxk1tJ2704HvHrHdIKtjwvQegq3wh02YAKk?=
 =?us-ascii?Q?zOJ3wnjrbHc3W/NltLWTBiNizfCiX7Sx47wFseQLUA+v7BosV8xF4+7DVkeM?=
 =?us-ascii?Q?9xvDTfM20paR3dUXYaxIyJdHtk69Mq93kkh3Kc4C/Jh50Lwth0dyU0H5KQMz?=
 =?us-ascii?Q?Qk3qCrnF05yx+uRZfvr9jGY8RUGMewMeMI6zp+6sipcBXEp5ml6YV0d+PFvI?=
 =?us-ascii?Q?mwYUPT6jUoMqBN6P7hkIaZnFkZNo66hBdIa5PapxfWdHHgP9tKmXYQ9IIRFx?=
 =?us-ascii?Q?ulbo1ZXwaMmf+6U7IjvdOXXQlkT9VwvTmP8WPDYcox4MJmfOUigpTLe9TgZs?=
 =?us-ascii?Q?qpBNwrubpKRbuKj/NzlbbR5NSfj+Rie55D1SsLVnBGm8uHTB16RJAMozOMjS?=
 =?us-ascii?Q?gRaXZ670gK8EYsFyUDS4g3P1YelI11SLyrJ9b4bXeC/ELJu9d8YYwWT+grBv?=
 =?us-ascii?Q?QziwsXZCM3uKYw96T0OGYPQI08SWrNHsr8FmPQ4SyYVhbYAuv6hQ9aiId5R8?=
 =?us-ascii?Q?l3ictmk1fZZo3PJrZFoZ9rlgUzoOxLBXrgJuT9WXGYnXE3bkP5Ob3d7LRadl?=
 =?us-ascii?Q?l8waVFrG1icXVaABBTOsPM5TURjrUhVCWsXpDVY/4tgZuyo9tAGn348F3bVj?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36842b92-7e4e-4413-7df8-08db0bc61bdb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 00:22:50.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLKxeXy/NPsatDW+Y2ax98KbFu1Y8QRVeVgSsWvLtZXuxjRE+s5K3nUBQW/dMxOtP8RRP13Bq+ZKZrbG3ePCPuGCO9uwWLElhw3z8dw2AOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6921
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
> The CDAT exposed in sysfs differs between little endian and big endian
> arches:  On big endian, every 4 bytes are byte-swapped.
> 
> PCI Configuration Space is little endian (PCI r3.0 sec 6.1).  Accessors
> such as pci_read_config_dword() implicitly swap bytes on big endian.
> That way, the macros in include/uapi/linux/pci_regs.h work regardless of
> the arch's endianness.  For an example of implicit byte-swapping, see
> ppc4xx_pciex_read_config(), which calls in_le32(), which uses lwbrx
> (Load Word Byte-Reverse Indexed).
> 
> DOE Read/Write Data Mailbox Registers are unlike other registers in
> Configuration Space in that they contain or receive a 4 byte portion of
> an opaque byte stream (a "Data Object" per PCIe r6.0 sec 7.9.24.5f).
> They need to be copied to or from the request/response buffer verbatim.
> So amend pci_doe_send_req() and pci_doe_recv_resp() to undo the implicit
> byte-swapping.
> 
> The CXL_DOE_TABLE_ACCESS_* and PCI_DOE_DATA_OBJECT_DISC_* macros assume
> implicit byte-swapping.  Byte-swap requests after constructing them with
> those macros and byte-swap responses before parsing them.
> 
> Change the request and response type to __le32 to avoid sparse warnings.
> 
> Fixes: c97006046c79 ("cxl/port: Read CDAT table")
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+

Good catch, a question below, but either way:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> ---
>  Changes v2 -> v3:
>  * Newly added patch in v3
> 
>  drivers/cxl/core/pci.c  | 12 ++++++------
>  drivers/pci/doe.c       | 13 ++++++++-----
>  include/linux/pci-doe.h |  8 ++++++--
>  3 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 57764e9cd19d..d3cf1d9d67d4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -480,7 +480,7 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
>  	return NULL;
>  }
>  
> -#define CDAT_DOE_REQ(entry_handle)					\
> +#define CDAT_DOE_REQ(entry_handle) cpu_to_le32				\
>  	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
>  		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
>  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
> @@ -493,8 +493,8 @@ static void cxl_doe_task_complete(struct pci_doe_task *task)
>  }
>  
>  struct cdat_doe_task {
> -	u32 request_pl;
> -	u32 response_pl[32];
> +	__le32 request_pl;
> +	__le32 response_pl[32];
>  	struct completion c;
>  	struct pci_doe_task task;
>  };
> @@ -531,7 +531,7 @@ static int cxl_cdat_get_length(struct device *dev,
>  	if (t.task.rv < sizeof(u32))
>  		return -EIO;
>  
> -	*length = t.response_pl[1];
> +	*length = le32_to_cpu(t.response_pl[1]);
>  	dev_dbg(dev, "CDAT length %zu\n", *length);
>  
>  	return 0;
> @@ -548,7 +548,7 @@ static int cxl_cdat_read_table(struct device *dev,
>  	do {
>  		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
>  		size_t entry_dw;
> -		u32 *entry;
> +		__le32 *entry;
>  		int rc;
>  
>  		rc = pci_doe_submit_task(cdat_doe, &t.task);
> @@ -563,7 +563,7 @@ static int cxl_cdat_read_table(struct device *dev,
>  
>  		/* Get the CXL table access header entry handle */
>  		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
> -					 t.response_pl[0]);
> +					 le32_to_cpu(t.response_pl[0]));
>  		entry = t.response_pl + 1;
>  		entry_dw = t.task.rv / sizeof(u32);
>  		/* Skip Header */
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 66d9ab288646..69efa9a250b9 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -143,7 +143,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>  					  length));
>  	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
>  		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> -				       task->request_pl[i]);
> +				       le32_to_cpu(task->request_pl[i]));

What do you think about defining:

int pci_doe_write(const struct pci_dev *dev, int where, __le32 val);
int pci_doe_read(const struct pci_dev *dev, int where, __le32 *val);

...local to this file to make it extra clear that DOE transfers are
passing raw byte-streams and not register values as
pci_{write,read}_config_dword() expect.
