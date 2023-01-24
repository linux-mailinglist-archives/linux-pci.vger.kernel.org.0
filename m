Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7C2678D0A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 01:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjAXAz0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 19:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjAXAzZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 19:55:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE8A1A972;
        Mon, 23 Jan 2023 16:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674521723; x=1706057723;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1BTKIXpBmt6CR0gzqal6okFsh2+ph0rW4WhV1n2Ozfc=;
  b=SrkEhQ7JEJLes7VLGA5wedkH24W1H4s12ORio1cf7SICcXnGs6n3gVw2
   nj8Ylm0vRqrqx4/RZToyjunsPfgOy/jgG5x0f+twkuaqj2f8rhfkNZyL4
   2Hce7QcBASz+/WxYofcMbGg5M4lxN4+DsqC2ORMHG29UECI8XXgPTdbZe
   3PMTwJFBJAMoIzgot/98CM5gVx+7lb4MU1+yvewxi1PBgtj8jCtOON7v/
   EOnsvTYbFE/8mNUnuBvRg5xYy5Q3bd4/uBa+/1speDlEzVlm4cKh00wFx
   lI2+2T/A2iUegE4rrghP2wRYN3ESrEXnwldeX5aX8ql1eMVF/0DrsjKP4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="323896753"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="323896753"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:55:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="907303508"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="907303508"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jan 2023 16:55:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 16:55:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 16:55:18 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 16:55:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vx0fILrbz4yscJ+WIP0V90wYCkOKPnTehBhIq6XdcyvAo6sRzI9MsHJiZZjkMPixDEmsOR/uHf/YFRsfKKSmPvTJX3o1BRCuU/PJ2W1jD4QlwU1r2qXoVhUh5W9VtIZjGpfCb5IPf/5Ev1UHgTiwThAQzPwX25y+mCdYSEGOpLVuA6c4MrBFmnCHuOiftt0hYgYb+vAhJDOgkj/uEjPisrAo3lqVOAoCqKECZbVPcgANXuOI3oRmpjApTM8VL6wpsSr5Y9ayz2Iuv5ZrDrpMVkLr0AIIIvQh0LM2lpO8fDDRCvwrXmKPu4w6gz2EdBzvWPuv65Fko/ftg7ekJXhRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21XvMSLEB7/91uJlB3oBn4fyAhf5TJfSvdthRiRTfGM=;
 b=KsdQ+KSw2UeFxY0hXnoIzTaINXZp8q5PYOYzHvUHG4gTsw6JyZCGs6wi3JieuUpL6zXl8Gg/+SHZWCnTVBAtQrclYFj6Q9uy193CpSpG9ZW9AH1AdbZl7FWd42p4j1cYaxf4AGvcb+GX0TNp1SXSlYd2TAY9ECP8+d/bmVkxt7pMf5+NUcEP0jc4ZDRxKVLybB0SXc/CmsOlMY4ihkSNe4MjKWHxOPv3l6t9TGus3zMZR8Kg64XZtv6NDxFeQ+XvkSz4vlBEjE7+DHfP1k19WRoQQvWoi0ctDNidM3cyxjGOagG07yVtS+RFqx6KwBVKyXlop4voknbXCvCBo5MmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 00:55:15 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Tue, 24 Jan 2023
 00:55:15 +0000
Date:   Mon, 23 Jan 2023 16:55:11 -0800
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
Subject: Re: [PATCH v2 05/10] PCI/DOE: Make asynchronous API private
Message-ID: <63cf2c6fd2660_521a2941b@iweiny-mobl.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <ec7155b88895ab6a644c0ba33aaa10012d0e4fd7.1674468099.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ec7155b88895ab6a644c0ba33aaa10012d0e4fd7.1674468099.git.lukas@wunner.de>
X-ClientProxiedBy: BY5PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:180::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbc6254-99a1-4d95-0718-08dafda5a7aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6v+w+b31VuUv8W7LEs09GS2z8vyCPmHqOo9bynvIQpUtLprp9+5HjQVZeFuiU06QRXkAX32W4Oa/y+GKijJu84H3pvSZmeUQro+2NKnXxADdrElyzIXJI0t5tCDwWxRSHDKDVjtfp0tSRVIsy4ax1T6gzo2AyRR/mqUJQnRqPezu1OU89/TjDYJ0uMyk/oCGHvmf37eMEdnPFOcKnmw4jR0s1O4+rqH5TAImNmrLQbNJhf/XNN5EmsSM5WXaAlE0qvwVf5rpFtXBFI/kSisT2wngwzo4MySWW4xVgCm8cKKhcqqu3MK802rGsowlMnjgPFYswXqHP+gpJmqPioyv+WUYs/bBZ3kbiWM36y8ImDhIWiB1FISXRw2xO8A7SMUR8ATQwPO4X3w2IiVxB1DgWirrODujdxfzDkRxtcf+7DQ7tobITwFnQ3juMWnutcud24C8KIdv0YZxMo4UB/iFAB8GnRoumRnaiG7EiJv1O33riGBJO0iVRqaXi1xiXi4RkYl6I7c/QcfJB19Kz9WanoLd04eGzlhZmdu4hnERfUNmw1mp9lA7KBBz9vKdkk8kmh8McUupO03+UXGoi89mEDdHEMVTJFuSrlB/jM3KS9KPOGYWhvibKu+rE7JlwgCJG8fNyY4LqO5J3+zrP5t+Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199015)(83380400001)(26005)(6512007)(186003)(9686003)(6506007)(6666004)(86362001)(38100700002)(82960400001)(41300700001)(2906002)(8936002)(5660300002)(44832011)(478600001)(6486002)(316002)(8676002)(66476007)(4326008)(66946007)(66556008)(110136005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iagz7o9E0/6vqdYAgDqmiwwdlWdOawAyJLVAYUPZzTkGCaUy12GPDUthGqcw?=
 =?us-ascii?Q?f9ZuOXj9V2zcmsYdK7UWkeSC03/9f6zGsCrysSK2wdl6JUjWpVT3Fb9dVpXl?=
 =?us-ascii?Q?LgT47wcgd86XsX+jiCmkXF9wubUM4qKhWUV4S6cx+Y71ucrVo77zwMbka+E9?=
 =?us-ascii?Q?jHhDUX7zOQ1sNA0oSfn10bmALKtqylFZvSUKR6W0w+/W/270uVNNtFlLLSiN?=
 =?us-ascii?Q?qA4NEHjHgAu7lP8IX//VWJHsPH8XyyZG22l7o/ax0ENGojEKZ5GwuJWZydG6?=
 =?us-ascii?Q?Krietq6ljfJXA1l/SRRv90QIDXSBoByTkKD/HIvYm1Vcjx2W9FD+oQHwi9Rw?=
 =?us-ascii?Q?ubhbH+WUw4/eBa7Tx5n364voIlESycRdNfWhIWZ5lTkN8O+a49JOht5C67II?=
 =?us-ascii?Q?0eY3TVS4pP/Zz+d4ACf3mWWpnYVqZFFvmuKB/FMtl/cVivIqSJnpoSeeorb1?=
 =?us-ascii?Q?jlo3AfmYSrU12xXDVXyODQjRvIYqZqQUql9ThwxVAoeVws2ZKyqA8IpABfAW?=
 =?us-ascii?Q?RA7MZnvXeDx4JqtS14eJL5PSep3rLR5TwCrzj7j/AgDwf0xOJgj0rTY1uDTk?=
 =?us-ascii?Q?+m+ZP6SBz7EgebLJsjP2xF0qczgLFGlZmpje/4OjmkytXarMsENqZ5xK0Pre?=
 =?us-ascii?Q?T+wy4TwwAG0XKAGYPo09gogZWgefnnGVp2yOzOxboTNXOVMhvqDCKIPxh6Hm?=
 =?us-ascii?Q?4zEWvppS6pEyqUml3fGIbSzJnOO1+iyGbj7O0M9VPt6+1IgJJ+nB9aLqBSWR?=
 =?us-ascii?Q?OSAcypTyE15Xs0KDN7pf1jUO5lc9lKfVxoas7GsregQ/ZO2Y/Q2pzetesvg6?=
 =?us-ascii?Q?MC3zgzDb5oqFxI6V8cPXPHZCP07WsbbdLcrYQtbsNZKHvj862wQzP7BN4lrN?=
 =?us-ascii?Q?suuT6p3Fg0bLzZgFIL9b0rcwLJDgCiez0p9DAwzlQSNU4lLnEmtzJwAUeetL?=
 =?us-ascii?Q?Iq46NiD1/GRV6qASsL+8/Lh/Axf6c5LzxYO7WyVjqaYyUHJ+UU7DOe0h/JQJ?=
 =?us-ascii?Q?Vv9D0XCjNx5tl1nkmvxPoEic9e/sPGLEa0KaxEtwqXvOByICyuU8y7cuWwxx?=
 =?us-ascii?Q?y6SJSYhh+GbJh5m4JG7iv0CG+20CbWnkAOe97KmL8jBG2AwOrsWiGstNWoPb?=
 =?us-ascii?Q?aU984GSTFtqTZoPzKDgvlIn4ird23DvF/jZFk2BNym+fHqQWNeKu5NLKwo+0?=
 =?us-ascii?Q?Wi/GpmOJB9wcPC8qS+NVzbqBVv5yRDEYzyroVWrFlz+umxOTHAnFhFe00Zgb?=
 =?us-ascii?Q?zgd0I7STREYMz5/tFMrUKU0gNpRIukdX1PhwSvuSDKM3JbGqI9h2iOyza769?=
 =?us-ascii?Q?YXwBV9nuPpZ6Ca5iHlSrvgJJ2gYZepto34yb6Xr0Dig2D5n0e9VMQQd6VuuJ?=
 =?us-ascii?Q?YNdyT+DbKK2Zu6Mzs3XOtpL/9GvYBThU7hlWGxWCMAA5yMS4DCtMnfaUvPDv?=
 =?us-ascii?Q?ACGhbGYznT3pZ5P68vwKCNcnTAqp0kHsWjr1H9zkSVYCx5gRqvbSBpnqWA8O?=
 =?us-ascii?Q?LQI83td0fKgSXVxzvKYny7itntLdBUuHxggIT+7sW3M2GyF9MCZUuB3svjT9?=
 =?us-ascii?Q?UOAaSb3SIMnZ7XrAtt5k59V5pMO8LrD84ZJ9qlkJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbc6254-99a1-4d95-0718-08dafda5a7aa
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 00:55:15.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jf8483806xmDj6nLyS5AeCI3Dz62p2hLLNvxJLOiyq4kjt3k5ExsiqjIVy2ndUw+R7FheJ7I/uct5KJp8mCFmw==
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
> A synchronous API for DOE has just been introduced.  CXL (the only
> in-tree DOE user so far) was converted to use it instead of the
> asynchronous API.
> 
> Consequently, pci_doe_submit_task() as well as the pci_doe_task struct
> are only used internally, so make them private.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> ---
>  Changes v1 -> v2:
>  * Deduplicate note in kernel-doc of struct pci_doe_task that caller need
>    not initialize certain fields (Jonathan)
> 
>  drivers/pci/doe.c       | 45 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/pci-doe.h | 44 ----------------------------------------
>  2 files changed, 43 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index dce6af2ab574..066400531d09 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -56,6 +56,47 @@ struct pci_doe_mb {
>  	unsigned long flags;
>  };
>  
> +struct pci_doe_protocol {
> +	u16 vid;
> +	u8 type;
> +};
> +
> +/**
> + * struct pci_doe_task - represents a single query/response
> + *
> + * @prot: DOE Protocol
> + * @request_pl: The request payload
> + * @request_pl_sz: Size of the request payload (bytes)
> + * @response_pl: The response payload
> + * @response_pl_sz: Size of the response payload (bytes)
> + * @rv: Return value.  Length of received response or error (bytes)
> + * @complete: Called when task is complete
> + * @private: Private data for the consumer
> + * @work: Used internally by the mailbox
> + * @doe_mb: Used internally by the mailbox
> + *
> + * The payload sizes and rv are specified in bytes with the following
> + * restrictions concerning the protocol.
> + *
> + *	1) The request_pl_sz must be a multiple of double words (4 bytes)
> + *	2) The response_pl_sz must be >= a single double word (4 bytes)
> + *	3) rv is returned as bytes but it will be a multiple of double words
> + */
> +struct pci_doe_task {
> +	struct pci_doe_protocol prot;
> +	const u32 *request_pl;
> +	size_t request_pl_sz;
> +	u32 *response_pl;
> +	size_t response_pl_sz;
> +	int rv;
> +	void (*complete)(struct pci_doe_task *task);
> +	void *private;
> +
> +	/* initialized by pci_doe_submit_task() */
> +	struct work_struct work;
> +	struct pci_doe_mb *doe_mb;
> +};
> +
>  static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
>  {
>  	if (wait_event_timeout(doe_mb->wq,
> @@ -516,7 +557,8 @@ EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
>   *
>   * RETURNS: 0 when task has been successfully queued, -ERRNO on error
>   */
> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> +static int pci_doe_submit_task(struct pci_doe_mb *doe_mb,
> +			       struct pci_doe_task *task)
>  {
>  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
>  		return -EINVAL;
> @@ -537,7 +579,6 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  	queue_work(doe_mb->work_queue, &task->work);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(pci_doe_submit_task);
>  
>  /**
>   * pci_doe() - Perform Data Object Exchange
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index 1608e1536284..7f16749c6aa3 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -13,51 +13,8 @@
>  #ifndef LINUX_PCI_DOE_H
>  #define LINUX_PCI_DOE_H
>  
> -struct pci_doe_protocol {
> -	u16 vid;
> -	u8 type;
> -};
> -
>  struct pci_doe_mb;
>  
> -/**
> - * struct pci_doe_task - represents a single query/response
> - *
> - * @prot: DOE Protocol
> - * @request_pl: The request payload
> - * @request_pl_sz: Size of the request payload (bytes)
> - * @response_pl: The response payload
> - * @response_pl_sz: Size of the response payload (bytes)
> - * @rv: Return value.  Length of received response or error (bytes)
> - * @complete: Called when task is complete
> - * @private: Private data for the consumer
> - * @work: Used internally by the mailbox
> - * @doe_mb: Used internally by the mailbox
> - *
> - * The payload sizes and rv are specified in bytes with the following
> - * restrictions concerning the protocol.
> - *
> - *	1) The request_pl_sz must be a multiple of double words (4 bytes)
> - *	2) The response_pl_sz must be >= a single double word (4 bytes)
> - *	3) rv is returned as bytes but it will be a multiple of double words
> - *
> - * NOTE there is no need for the caller to initialize work or doe_mb.
> - */
> -struct pci_doe_task {
> -	struct pci_doe_protocol prot;
> -	const u32 *request_pl;
> -	size_t request_pl_sz;
> -	u32 *response_pl;
> -	size_t response_pl_sz;
> -	int rv;
> -	void (*complete)(struct pci_doe_task *task);
> -	void *private;
> -
> -	/* No need for the user to initialize these fields */
> -	struct work_struct work;
> -	struct pci_doe_mb *doe_mb;
> -};
> -
>  /**
>   * pci_doe_for_each_off - Iterate each DOE capability
>   * @pdev: struct pci_dev to iterate
> @@ -72,7 +29,6 @@ struct pci_doe_task {
>  
>  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
>  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
>  
>  int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
>  	    const void *request, size_t request_sz,
> -- 
> 2.39.1
> 


