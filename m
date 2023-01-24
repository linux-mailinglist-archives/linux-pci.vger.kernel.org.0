Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA32D678D04
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 01:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjAXAwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 19:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjAXAwd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 19:52:33 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B02B28C;
        Mon, 23 Jan 2023 16:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674521552; x=1706057552;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QqEIO+lNt9aSVcBSqqa6kBXFMEmUClc9/elPMX7Z2io=;
  b=ntoJUBWVkDlhc7JSuS2yJNif+W399SUoIp6Hvg4X5C6TkI2aJ4atbEdh
   mggill1Pup9QoLEjKEpIIlneyfUo/OrUVna7A//Rk8iq6t4uEvLhuWXq4
   GFbB6OTqEZPJsHx228SBVABvGfyrnmsbf+eH5FFbYM+NAWzQAmtxE2Qjg
   a8PRhoZfQVZnHFpQlmrjimaTG3QLCs/QfYSE4TElRTHszm19UDxkgJGMp
   Ac133dd4llKXEGnnnVsoz+mYdIxfIEl4VlasvOvPxyHboDDW2go9LtqYt
   3jxjg/GkTxDvatgGoGNpzbMg+Q5QhCJIzBqsyul46fyFKMOP2ccAaBgMg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="412432774"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="412432774"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:52:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="785884103"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="785884103"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 23 Jan 2023 16:52:31 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 16:52:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 16:52:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 16:52:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRM9WXZGMY4qDrOJ6XklF/6xEuh5D+PkHnjjSihDpQ+a70egEvnOQpStMxq6eCC0W8GCvDGqh/Lfvi08Seo25Y8/PtnDJy5YkFXt/mKzsMdgP0VGMYXWq0jqcpfg9GBrPV4OsoYJwApUtfp4eK/RZBQlwKPjbkFc4QZ+oRG+v1pbrHOMgf6CSfLEnef4qvEGWV9NVKU9tzZ9Xks4ZG7iosInNXitDq6k2bpras/ayOeQilJgDyKOcqVUsghEGH/y3qIjueJ3QfjCzhnvCKyAI5Mk3ULFGpM53o7o4VS1jkwHdkVNHBXcgjCUAOAEuRz4haALYBWzW40+3vx96BNUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjfBHjPmWWZt8JFPJGEO8TFm4i5M4Qs7LQBNkiNakqA=;
 b=IJPqs0wp6oIMWg+W74mGlzIuSeF/ujeAcaGispDOVAQ6yWU2SNbcZ2wSpDuc+jemJb0eR3GD8y29d2Uy9nfqW7CYIZMtFjYe6s8mY/tADUxfA/Y64lVKm1ov7fPlw+5vAzx7SVTWumLryb31Hhlf9NP64FreqhX/T+2OgByXfoXB+UpyQOItJGiOKqNwVbvXviR+qU69yqFx+sKlTbwi0ph9fg0WUnRjYna4ZKlf/aI60nHSqmjIpRzz7JGrvAU3GXYLa0MyngN9G72kW7ZnGAGlKnrGhS9vzXERHXYqGmfl12yy/3fSpv0wN8enCVzRAGMPrmoOC8xIOp9HN7d4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 00:52:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Tue, 24 Jan 2023
 00:52:22 +0000
Date:   Mon, 23 Jan 2023 16:52:19 -0800
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
Subject: Re: [PATCH v2 04/10] cxl/pci: Use synchronous API for DOE
Message-ID: <63cf2bc3cf76_521a294a1@iweiny-mobl.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <b5469cbb8a3e138a1c709ed3eaab02d7ca8e84b2.1674468099.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b5469cbb8a3e138a1c709ed3eaab02d7ca8e84b2.1674468099.git.lukas@wunner.de>
X-ClientProxiedBy: BY5PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3cfcda-d107-4fbb-e9c8-08dafda540b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4LCOOYnUmybyGZPpzEu9ydqe7yyP+JIxrTZnb9rQUJS800R9ZGfTuLocex5XgDUgCbkGZGSBWtu18mWqX+CJZooFRJRb9cR5qxbgP1QEsBPgCT9hxvj5gvkeqJ6ya13Y02Su3DOktxqZQPhGR8GipWkVfC5LMg1O32MO40zUvFO6Q73uz+gsV4S9X/G5zWoxt9Abl/Ign67Uj1DdldIiPM4nlpx/gI46AfpSR3NdrsG+I0MIakVbgv8Jzf+ggSYJJwLJX9Z3YlT5HWRZdxHxBqnBgryUCYsH4FqeK1XM0Nq2G9TPwkhF2qqE8tf9gF2A8B8d5F8gK7uIm6xxJKrmYyQkJSI28/bZIGin0gti5K6iqyT5vG7c50scdohIXhlKzj83f0rWQ05ROYJwn7FMrd+ulJleryK47SrbOkdDiZwR1xPw+PtsE0Pymhtcx5Y/4l2k2YBGhAXIXwm4CJvRbXYxA9UmbhhxPSXzrpZKEg2nbTbit/1v4v98RMIc0oN8MgZVLzxkiEQ36YNAgir/yQ/fp+ioiBb0qtYNlhCePluizcB08V2CegWqv6JIBVy3p5d2LnX8fNLo0nYeJuX1h5TWWye4pv6oApSvOcpjuPbwOOy+6UuCYUh+eYbvG3nCVfWNbENE/rTn9wHlc9KxkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199015)(83380400001)(26005)(6512007)(186003)(9686003)(6506007)(6666004)(86362001)(38100700002)(82960400001)(41300700001)(2906002)(8936002)(5660300002)(44832011)(478600001)(6486002)(316002)(8676002)(66476007)(4326008)(66946007)(66556008)(110136005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RRIzVoFI5qEoE9BztEOkVLbjjtO0YyooWCGkH+l+/GQYMnNYWOb4OFZ3FlYn?=
 =?us-ascii?Q?Fl8GuqDpKLLw1tasYZfAQBEDeOhXoHt1NIV4CZxLGf3O/i76EhTH3kFjKql1?=
 =?us-ascii?Q?MOHJ0IeoSytEBK8xEAoD9z7woMKH7mEvQ6UnaL2zb/cVvcjhoQ/D43V7LBFR?=
 =?us-ascii?Q?5mWbU43zLCyRNeUddFntl+1Vi5X6ugMbbVWlQCw8rJ50McWM7ij/1yhONHnc?=
 =?us-ascii?Q?rTXiTn5j/t2cDeYhdU/WQy0UcL25Z4/q1nhGOH+5BwjhUmu5620OObIKuyk4?=
 =?us-ascii?Q?bZkuu6JvNTTfwnvEq076CEN7VQG4+rlV0ob/fmhF9pU+gsm/1A365Hy3ZcC6?=
 =?us-ascii?Q?jdWXgehGsKn5I6HmqsNUff9jTPSo4F3zwAxLO9UJZpdC5lBkPl9DAhwhI6lV?=
 =?us-ascii?Q?uJjJDcz73vmSSq8WEeYX3f0huTtWI7Aj+smUzii46Tp2AVrT4fkRLWSh4vpA?=
 =?us-ascii?Q?PBW93eqCEJhrTLeOA7+tdXeOrGuAIqNomgTN1hqaVJi96ifd911yFmyPP4ZL?=
 =?us-ascii?Q?5PTKo1G2plav0fUPYg+uJxacYk+J/cF9OhZ9mX2OXDoFTeYOAI05VlSqna61?=
 =?us-ascii?Q?abpc6ibNqI8plyaUVP2N8om8DwPIHMYHGkgWSypt+E8xjIPK+b6fBJVS7laC?=
 =?us-ascii?Q?G7s18AmrjLJycp/xSfNtmME8VnZgpi/W9qf0ovimqms4A5ZLoYuloCe17qNH?=
 =?us-ascii?Q?mhPiw6UtgZcZSZMLVGUWfMxsI5Kv6yaXAQTdvT+EOG1Y9C0crOinE5r3P0RQ?=
 =?us-ascii?Q?3BoLHHs3Uol9XKPefFMT+8tvYqYgdhF1qYw1f1DDD87kSrNcB25erhl0h0fp?=
 =?us-ascii?Q?tNpa5phB2d6kLgSZzXE1MaK7wtxjIZErbR7UQ6IVF3QhZU5ulHnYRoaM/Opa?=
 =?us-ascii?Q?ouCvzBTnR0PbtliXKoAEah9T0yHFX/DGnsjgXuMuxKG5GmEHDPtFCrsCN69s?=
 =?us-ascii?Q?LXijMLLWqyY364/yCCxfq6d74LXydhdQDKKF7cm+oxJC2cTJmFjDENiR2rlF?=
 =?us-ascii?Q?CNSu/mSEWT8tVzOrwnRzDZlyEYzc25YviYwTVnnmmamK8gFwasfA0oE4ye5c?=
 =?us-ascii?Q?2PzFjzPwqxtxFdTAxSJ3DhTdEfafs9ChWwTGm3wo5zTEYnM6etS94/S7DxvM?=
 =?us-ascii?Q?Q/0FDgbT1ITG/+chIHVZDYZMEFFbCAmu0jwyFWJNM+Y6MKAWi51AkkkrBMx9?=
 =?us-ascii?Q?OfcAWXfyywgtbs1tPTN5+/b8FEZ0mMNWzDqjCLamtLgdpK/mAugL7qtKj0Pm?=
 =?us-ascii?Q?DUd3s91QLq0GKFJyT6dA1Z1flw4Mgwj1oByCEOuSnnNbSpm4RvlbvDflR0tJ?=
 =?us-ascii?Q?SCOE07+3m/PyBgm0xkkI64Up87m7dL0OEG3VpNO0f/++0z2Ra4o3GK4NhSHl?=
 =?us-ascii?Q?kcyUOKeE5rgsSjm2a4ImN/ejtkH+TcKa/uOYxQcQJ+o+iGVaVKUJHQHlt+Ip?=
 =?us-ascii?Q?qttKlTeK9Yb4u8WEnZC3bA5e92GM/WFqH4sgQdWE7NayaAo4OyxEUVxV0rPF?=
 =?us-ascii?Q?8WJ9Xt3OQxiED7ml375ggGM0TKM7/T3hbVX03mj2RE+6dHLGmYWu0Tryr8gJ?=
 =?us-ascii?Q?/uUna7ckZih4KnTnzA4/6D6sU2ZzuNSDs+1x0dLM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3cfcda-d107-4fbb-e9c8-08dafda540b4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 00:52:22.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxhCc+tS59IjKsLVx0wucAtA07HgqL3LCzyvuUldiHro5yUQGDpfUgxyLztgKu7mY/jIFEIdywdK/kBclnkoFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999
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
> A synchronous API for DOE has just been introduced.  Convert CXL CDAT
> retrieval over to it.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> ---
>  drivers/cxl/core/pci.c | 62 ++++++++++++++----------------------------
>  1 file changed, 20 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 57764e9cd19d..a02a2b005e6a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -487,51 +487,26 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
>  		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
>  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
>  
> -static void cxl_doe_task_complete(struct pci_doe_task *task)
> -{
> -	complete(task->private);
> -}
> -
> -struct cdat_doe_task {
> -	u32 request_pl;
> -	u32 response_pl[32];
> -	struct completion c;
> -	struct pci_doe_task task;
> -};
> -
> -#define DECLARE_CDAT_DOE_TASK(req, cdt)                       \
> -struct cdat_doe_task cdt = {                                  \
> -	.c = COMPLETION_INITIALIZER_ONSTACK(cdt.c),           \
> -	.request_pl = req,				      \
> -	.task = {                                             \
> -		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,        \
> -		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS, \
> -		.request_pl = &cdt.request_pl,                \
> -		.request_pl_sz = sizeof(cdt.request_pl),      \
> -		.response_pl = cdt.response_pl,               \
> -		.response_pl_sz = sizeof(cdt.response_pl),    \
> -		.complete = cxl_doe_task_complete,            \
> -		.private = &cdt.c,                            \
> -	}                                                     \
> -}
> -
>  static int cxl_cdat_get_length(struct device *dev,
>  			       struct pci_doe_mb *cdat_doe,
>  			       size_t *length)
>  {
> -	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
> +	u32 request = CDAT_DOE_REQ(0);
> +	u32 response[32];
>  	int rc;
>  
> -	rc = pci_doe_submit_task(cdat_doe, &t.task);
> +	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> +		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +		     &request, sizeof(request),
> +		     &response, sizeof(response));
>  	if (rc < 0) {
> -		dev_err(dev, "DOE submit failed: %d", rc);
> +		dev_err(dev, "DOE failed: %d", rc);
>  		return rc;
>  	}
> -	wait_for_completion(&t.c);
> -	if (t.task.rv < sizeof(u32))
> +	if (rc < sizeof(u32))
>  		return -EIO;
>  
> -	*length = t.response_pl[1];
> +	*length = response[1];
>  	dev_dbg(dev, "CDAT length %zu\n", *length);
>  
>  	return 0;
> @@ -546,26 +521,29 @@ static int cxl_cdat_read_table(struct device *dev,
>  	int entry_handle = 0;
>  
>  	do {
> -		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
> +		u32 request = CDAT_DOE_REQ(entry_handle);
> +		u32 response[32];
>  		size_t entry_dw;
>  		u32 *entry;
>  		int rc;
>  
> -		rc = pci_doe_submit_task(cdat_doe, &t.task);
> +		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> +			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +			     &request, sizeof(request),
> +			     &response, sizeof(response));
>  		if (rc < 0) {
> -			dev_err(dev, "DOE submit failed: %d", rc);
> +			dev_err(dev, "DOE failed: %d", rc);
>  			return rc;
>  		}
> -		wait_for_completion(&t.c);
>  		/* 1 DW header + 1 DW data min */
> -		if (t.task.rv < (2 * sizeof(u32)))
> +		if (rc < (2 * sizeof(u32)))
>  			return -EIO;
>  
>  		/* Get the CXL table access header entry handle */
>  		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
> -					 t.response_pl[0]);
> -		entry = t.response_pl + 1;
> -		entry_dw = t.task.rv / sizeof(u32);
> +					 response[0]);
> +		entry = response + 1;
> +		entry_dw = rc / sizeof(u32);
>  		/* Skip Header */
>  		entry_dw -= 1;
>  		entry_dw = min(length / sizeof(u32), entry_dw);
> -- 
> 2.39.1
> 


