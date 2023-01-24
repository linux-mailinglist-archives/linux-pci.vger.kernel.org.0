Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B366B678CF9
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 01:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjAXAsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 19:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjAXAsU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 19:48:20 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946D21E281;
        Mon, 23 Jan 2023 16:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674521299; x=1706057299;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wmj1g65iZxx9hjkt5qLNnjf8S3H+IluPJ9W1227V27Y=;
  b=JOL55E9q1nRgM0dWwzPH/qSPa5oN544CIuYE6TQ5o026VzJQ+PoXRj5G
   QwmPHEiPV8vauh4bw2bqg2XbK/fpVKfb6iL9PHksPk1thOxC48PL3FCIQ
   RoYfRkjHxbq4OsS57iTVVzIauNWbIi2sNhKsVxq/7A4GqM/CZf+b1BRoi
   BReHG/QDopXNzS4ouIn4abW9kbYxZGd3jYCtPI08t5Kd9/iw0Dr8nSlVA
   KYHgFbcfdo4h9eSZEzgfbSl+sdQ/v1W6bVC9AdugGjywq2nTkrnFhj/Cb
   zlDzEU6z33PiWrTU51r4poXEeJ+dTO95MWCM7vaOnwCS3t7Yr8iAETvR6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="390708752"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="390708752"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:48:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="692430411"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="692430411"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 23 Jan 2023 16:48:18 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 16:48:18 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 16:48:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 16:48:17 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 16:48:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntaG2W9yhI7bCZR0Uwqkd6RSk8G6BeG53MOb9pGQPn/CfQA+HHpsVPGA3mQC+ZtHJsefOtNzoRpEjJObSSx3k2J7xg45T1FSm6V7cnA42EKaUahpYQr8TqF3wJ4in0qsTIiot0JMQIOcTBvN4YybSKHVwfLV6+oVxw0yjYHaY+THjKwF4k6UYsHlON5IuJPiuHCDRQ8hNKP1qvEqv5D6DFFf9TpKNW5LCcstbcq1qpR0hdD50j5VjCu2qJkKNqM2b22YOxu61nm+hFG8bcjGHoqQhdCaU0arvCAryQENN/wGDa6kpVeY1z+IGnFLevcrcsywewPlc5UpvQKxfDFhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouv3eo7LMlir0L1JS22kPDWa6NKjTYErsxS6SkHEtWU=;
 b=E61GSL1qK7geulgk3pGW7RKuOIeX5kHuzW3duulyOJu2s+JruseJZJHKI0NuGfQCI3JiPNB5U9obGvF80OT5x9VixJ2NDjT4k9r9Sb5gHDnTNKEhtDrDxoCk/cq6t6vo2rbFKkXFpCWYQJDW7NADwNr8nMbnWw7KZjbmwdgc5toCha39tkzu3POYummqgRN3gVEgEjhfdiIYlDuwQyvVPCHJcN9v5dtEh7U3XAsDK80Oloxjo1IsmzESwbE8/pCcKJnzNEl/xwz8CYO9Tl4pmsU8q6RruC5zbG2kURt0W9Zu+J7eKTYiLPxcu4vnzkyFgMfJWob7JXhfGReMP52VSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4561.namprd11.prod.outlook.com (2603:10b6:5:2ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 00:48:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Tue, 24 Jan 2023
 00:48:11 +0000
Date:   Mon, 23 Jan 2023 16:48:07 -0800
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
Subject: Re: [PATCH v2 03/10] PCI/DOE: Provide synchronous API and use it
 internally
Message-ID: <63cf2ac78c080_521a29468@iweiny-mobl.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <b589059ddc82039f00d695d75ac4017504df6bf6.1674468099.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b589059ddc82039f00d695d75ac4017504df6bf6.1674468099.git.lukas@wunner.de>
X-ClientProxiedBy: BY5PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::39) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: a40baf4b-bde2-4ab8-26e3-08dafda4aaee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSG9CVcT1gbEG808pK0ox9zt2Ag82ST5JA8/dlJG9Zn/7tVi4tAQeVQV08J7ZgD0Pc/UJoBq7MoDsnbH7vU29qgIK6rDeTWDcrIpCmz6WFlpcTOu/uTy2jIxuONdE63FK/kaTFBRX05SA1Zrm/xb9NFVou3Wn0Il2pcUtI2FxHWoBRIfYTZSAnzmEzgZMxOq4seyxaoMWKzYudjm1HX4l+J4n9WRE8kw20DCC0wGrbATFDAQLYl+lbol/905c7N282hYTz6P6CY04AdRIVzq6erXN8C9TirNIHPZUpP9brqJErrUgPAfGifQUWjOPIRhsSZJgnq6KXvPZKndjXsYxrxrCd64EdcSwD2s6t1heHHFdzEysaZZlNu3lnb/gQr39Dqh4ulqUPZXSE+rz3Q5x5KlC1732Ey8dPbx+TlPvNY8gZxNqB4H5aRot/7CCCy/FfUjSmXxmR1mVdPPdX9FVTQgUbAk+VnlTzqREQCNrPIe14Xf+RDge/SZx7rcaB14YX5pAXklxMmzP8SZc3n4C3Q9Ul8y2a0HA+B7cndd4EM9+Pd3Ldg8Y38dajFVbqipjwcGm+JGE/mV0DszBXugtzrwTQWwiVpU2wwC2JsVC5mAaEXXJUh7C2Z62oZmoRhZPPsLBkNiq3KgW5wTrp0f+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(83380400001)(86362001)(38100700002)(82960400001)(2906002)(44832011)(5660300002)(41300700001)(8936002)(4326008)(9686003)(6506007)(6512007)(8676002)(186003)(6666004)(66556008)(66946007)(54906003)(316002)(6486002)(110136005)(66476007)(478600001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HiXy3XPJZ0K8GQrXaffcoZkhFu4OkfkaoxXyoMVqsfMvzgldVidnSii+rvhp?=
 =?us-ascii?Q?E6ZtYPJK0sdnvy7kMTV/x0WbyUh6bsoPhiwbrOpxIGYU7ZER9ajr3fnJLDTP?=
 =?us-ascii?Q?XWP2kv4tBYNSKOxHL6ZuCLfTUVfsLLkzRsii0P7jvp7dQe8ICYDB2Vi6xaRh?=
 =?us-ascii?Q?jjN7xV4JcsntfftGK1KYp2WRdQ79rjgsjw24qy4D4yARP/ERl1zq+jtcOabm?=
 =?us-ascii?Q?1Z8P73Bb388d4kY7Au/HAdhjflHXJN64B2G74XxE/JR254REzxB6eqodfa8p?=
 =?us-ascii?Q?yAJG/NWWm+zNRKQg3fJfTk6+Ecy3Yx26Em4j+WABDJp7yFCHHJudCnzSQSTW?=
 =?us-ascii?Q?p1hd0BVnzEQdqkBFPRM6QKMQbIG7A09el5AMsFqHKIe+n8/aM87jpbVzhEUM?=
 =?us-ascii?Q?Dnn2X/prjNqtZFF+Iw6PJlbziGUfZaPRZ9WjOvLzPTzPfI6YYcdMrV5qJ7hZ?=
 =?us-ascii?Q?rSBO3DGp85nVJ9j/3wjjbeHrLdV05JNojnVapr1kU2gBYv1M1zESRsjI4Yiy?=
 =?us-ascii?Q?CrDhVThLWAbr2ddEUu6ExhNu2mW7rs5OnFZYXyvnTFHF0yW0DF1yZALr4cJs?=
 =?us-ascii?Q?H+4unQuSFd7Ohc12wNaddbZHZbVhoDVgbyKPbHWX2b/xv2qNbVH8a0gIH7VR?=
 =?us-ascii?Q?CMJwI95ie5hZ8WXYX9NVgxbo6q7QWk44LHO4gyr7i+hhBFOCrBXxY4Qe7epo?=
 =?us-ascii?Q?DSE6wgvEt2IsBNgp9u74bDzNGnULE6jwaRHITky3u8+jie+C3rs5Jd54l9Dg?=
 =?us-ascii?Q?PSoUHAL5gRr3VkKONL+EpKLMV+sykvi2FVD8pB9laUG+lhW83MnuL4P3AYry?=
 =?us-ascii?Q?GDadEhvPmOL5WjV3ZDZtJEqJZ/X3I7GLGiCAFzORE1MSJrBE3+DNlb7pto/r?=
 =?us-ascii?Q?dS1iAAwU33SJzqYUFNpy6hryCAFEkflABUdzXatWk6eghY/nABy09XEsIZPu?=
 =?us-ascii?Q?UvBRKQXZ1fXNeV5uQoEr6mV8Rau48IX2wdNtibqoQJTUUIR7YHv6ajHMSp2L?=
 =?us-ascii?Q?NGJ2FcYZPeQ6wSebzGPl/djrgXcNrwFPSYxePPqMkOyL6UytaGwZ23TbtEwL?=
 =?us-ascii?Q?pY5hn/ndstRLDyqkO+gNwI8KWYAY6abq84dL5kJ9xVJN/d8ug3WzfATIGkP7?=
 =?us-ascii?Q?tIxJMHwkRv6YMtgb7uSvf7YdtutIhjvhwohzB0mwuPcinWHbdD6x2SmlRCJV?=
 =?us-ascii?Q?ugTSDxNBvCWgniYXNUFUAt/iKxff3EHTUvw74kQuRgU6xleEKS3oepKnKWpO?=
 =?us-ascii?Q?61Q6spGNxuBLOD3sUE8P20+NLtu0MsVoy8CgWqYlYFJqEZ4EA2ZDtVk5E0Ct?=
 =?us-ascii?Q?LImKclKl0XbqbfMSOAPeuRC7lqTV1PrKSblWCqw6WyklnxVCIsUj0MZjyaHA?=
 =?us-ascii?Q?OxOwfNqcOdTpwDtWPTIgeU+akCvY4jY8QUwgBq5rnV1e71aNnEA6ysfswPYn?=
 =?us-ascii?Q?Clw+d3yJ3zc1YPgdGS5dLtOJIgRStkXOUwhR1RwV21wZJnjAw6cJCxcG/xOc?=
 =?us-ascii?Q?+dXk/3Eraq/vlAjwXnr89TtYd+8shj3D/uhNJyyNf5r5ou1YQlNFbrQek8mX?=
 =?us-ascii?Q?nQBuYErjVaUWUgUce/RMF7F2ljd0OY/fBTEkYufx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a40baf4b-bde2-4ab8-26e3-08dafda4aaee
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 00:48:11.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qeG6sawfbVb7ljX39AyFh7rfieO7pAAbBWffKsNvp/6TQwAcpQdjQWQgHC+mav31Al/zo4OXQ+fXXmNIa8ZRhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4561
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
> The DOE API only allows asynchronous exchanges and forces callers to
> provide a completion callback.  Yet all existing callers only perform
> synchronous exchanges.  Upcoming commits for CMA (Component Measurement
> and Authentication, PCIe r6.0 sec 6.31) likewise require only
> synchronous DOE exchanges.
> 
> Provide a synchronous pci_doe() API call which builds on the internal
> asynchronous machinery.
> 
> Convert the internal pci_doe_discovery() to the new call.
> 
> The new API allows submission of const-declared requests, necessitating
> the addition of a const qualifier in struct pci_doe_task.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> ---
>  drivers/pci/doe.c       | 65 +++++++++++++++++++++++++++++++----------
>  include/linux/pci-doe.h |  6 +++-
>  2 files changed, 55 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 7451b5732044..dce6af2ab574 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -319,26 +319,15 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
>  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
>  				    *index);
>  	u32 response_pl;
> -	DECLARE_COMPLETION_ONSTACK(c);
> -	struct pci_doe_task task = {
> -		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> -		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> -		.request_pl = &request_pl,
> -		.request_pl_sz = sizeof(request_pl),
> -		.response_pl = &response_pl,
> -		.response_pl_sz = sizeof(response_pl),
> -		.complete = pci_doe_task_complete,
> -		.private = &c,
> -	};
>  	int rc;
>  
> -	rc = pci_doe_submit_task(doe_mb, &task);
> +	rc = pci_doe(doe_mb, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_PROTOCOL_DISCOVERY,
> +		     &request_pl, sizeof(request_pl),
> +		     &response_pl, sizeof(response_pl));
>  	if (rc < 0)
>  		return rc;
>  
> -	wait_for_completion(&c);
> -
> -	if (task.rv != sizeof(response_pl))
> +	if (rc != sizeof(response_pl))
>  		return -EIO;
>  
>  	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
> @@ -549,3 +538,49 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> +
> +/**
> + * pci_doe() - Perform Data Object Exchange
> + *
> + * @doe_mb: DOE Mailbox
> + * @vendor: Vendor ID
> + * @type: Data Object Type
> + * @request: Request payload
> + * @request_sz: Size of request payload (bytes)
> + * @response: Response payload
> + * @response_sz: Size of response payload (bytes)
> + *
> + * Submit @request to @doe_mb and store the @response.
> + * The DOE exchange is performed synchronously and may therefore sleep.
> + *
> + * RETURNS: Length of received response or negative errno.
> + * Received data in excess of @response_sz is discarded.
> + * The length may be smaller than @response_sz and the caller
> + * is responsible for checking that.
> + */
> +int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
> +	    const void *request, size_t request_sz,
> +	    void *response, size_t response_sz)
> +{
> +	DECLARE_COMPLETION_ONSTACK(c);
> +	struct pci_doe_task task = {
> +		.prot.vid = vendor,
> +		.prot.type = type,
> +		.request_pl = request,
> +		.request_pl_sz = request_sz,
> +		.response_pl = response,
> +		.response_pl_sz = response_sz,
> +		.complete = pci_doe_task_complete,
> +		.private = &c,
> +	};
> +	int rc;
> +
> +	rc = pci_doe_submit_task(doe_mb, &task);
> +	if (rc)
> +		return rc;
> +
> +	wait_for_completion(&c);
> +
> +	return task.rv;
> +}
> +EXPORT_SYMBOL_GPL(pci_doe);
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index ed9b4df792b8..1608e1536284 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -45,7 +45,7 @@ struct pci_doe_mb;
>   */
>  struct pci_doe_task {
>  	struct pci_doe_protocol prot;
> -	u32 *request_pl;
> +	const u32 *request_pl;
>  	size_t request_pl_sz;
>  	u32 *response_pl;
>  	size_t response_pl_sz;
> @@ -74,4 +74,8 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
>  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
>  int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
>  
> +int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
> +	    const void *request, size_t request_sz,
> +	    void *response, size_t response_sz);
> +
>  #endif
> -- 
> 2.39.1
> 


