Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28451678DA5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 02:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjAXBoK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 20:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjAXBoJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 20:44:09 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966EA37B70;
        Mon, 23 Jan 2023 17:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674524648; x=1706060648;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MDGG5x8YGq2DyJ/PJNsZSLWz0Lj19h4ktmLfxrfd/C8=;
  b=PLsiLgC/xQSB7WSWUnmevvvhZkU5rbWHHy6t7QbIxeHYhE5N2bIyrHWK
   gcwyVUzfqzJ1pxwMun3Yss1Zddx17lmcYALnufvxDgMHu5Sg/DT4Tm18O
   vBQVoj0bcR1qBZtN5LjHkBewtFSbkJAHE2GgvpOQ8P7gliLiYLdrMq81n
   QvLK5gSGTPQ4jwpy3cXxLjRAg3q3nZodVJk0WRKAVWQrbupJ3BLxE51jP
   AYSXYl81W+fcxwaOtw1YzmZdjHfqlpC0gu8zf2V1PV071jWb4YNpTpCuP
   31vIT/ElPZsNWAp9b4Dl1nWf0pIMTDKXm9HrnCEYsi+T9LsXNyc4vO+5F
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="388556911"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="388556911"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 17:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="835809584"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="835809584"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 23 Jan 2023 17:44:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 17:44:07 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 17:44:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 17:44:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 17:44:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3ryTd6buDhum19tyVUTGnZnhRvOwEm0pPFSB+qd/dcG1/gNxMdPLWzrk2mFiUPOj+zfwHYVTMeA56UrfAZ0+5WqFNVHvcvWuk7WEYoqAgBHcAH8svCgTTN8aVeQe0IWL1kchV6wuLJFWHTkNSHOYXfsEpUFMwtALzunSrv+trIvijovWGfBNnz5wYwNWhwLgaIdA+bPhHlKPwMWE8VOiFFTVdZGjv2pUmdW6Qqm9EZbm39Jh9AtDOLy746vxKmZuUIy/u71NocpnLlMNlzje4ZnUs48J1+0+sjQuGcxC8gKoNalaieyl1309kYRgiC2UusKpY8uOE/rkAY+29IWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1qmHXYH3ojWayDWUo8WOnKM3mUSkKxqd2ib6qfLSBI=;
 b=gvGJnZS0jlaa666YcGbtOo5k2vSLEKIaal3MpCse7MiPKAJpAUXOX1/kXb/m0kanbmb4pLm7E0Syl+7ibFp+5mTd2QOfjIW8cfREwU88x71i4jhksFBoRvIJ76gvtfS3oF1KRZoXA2geBkx+Cba6roUerOaLYNSKJtC1zXoQHUMK71jNak3eWAYSkaxrkhfkRcZyo5QHd03Or44O4jkzEdyVeX+HcMQoSYMEH+QgxEATyOqRG3traZNi9ogHmhuxFNutbBJ7fNoUIizrFjv5SdFJJTm5AP2OK67kGgDoDLHmJjqABMFh7tTESHH8Zw9aC1qgdeqUyJfzP098GGArCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB5098.namprd11.prod.outlook.com (2603:10b6:806:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 01:43:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Tue, 24 Jan 2023
 01:43:57 +0000
Date:   Mon, 23 Jan 2023 17:43:53 -0800
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
Subject: Re: [PATCH v2 10/10] PCI/DOE: Relax restrictions on request and
 response size
Message-ID: <63cf37d8f30e3_5cca294fb@iweiny-mobl.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <4dba01ff87d630abdd5a09d52e954d3c212d2018.1674468099.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4dba01ff87d630abdd5a09d52e954d3c212d2018.1674468099.git.lukas@wunner.de>
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9b20ef-1fa2-46cc-c885-08dafdac7550
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jbe7u9N3qnFpSBStLy38kRGVm7xLGwnSwnmD4kpBUV2gcPNxJxMgyGgZ5+VCn/EVSk/5mPFgtIKaA8lxpePyW/ZKWdgo5DWHBXDFGMGffnGfERrN6m6HHl7I8XkxRkE1wPFG0wHT+q/1NdkgB2oXs4+Ke+4u6YrMGV/VvAJmLbJamnZImxzitT4lLZL1GElbcmZts9zQvdTbA6oC/kjSm4jeLe+pnGQo1lGLWQ/mp8XC+Giexx95FbHB9v9Jb9efYsMWS8z0Hv3Tq2BDFsMoYff6evUtP5TYVDRpvviE6dnW5Cxovowuj8MfdTExXcEE7gnBfZpIt9IJbUiI5QIK2VHqkWBfahM8lgeOis+tfZcHzd1Qm2QwTM2TxCBw9fisSFG2USBUo8BxSeS8mCsDOnvuMSL9cNiSa7xlA+Z3bnyqhPXgIB8CUCVxrkcgBQuy+9cHhDkvlRN4hEjDvacHCLACbZlpBTug6lMqUXdDYp+XcLEdYS2V09KMEJdo9VERYGIsSgmYOZlfbnYT0LrK5ARJtf2Oj3jyQT0WFel58lHcaxUL026X2V5wQFmItCombpaVl8nXj1ZUiD4IW65lyqV6ePnKb358EaiW3O9H2fxcHL2r5Oq4k+T2oCSvs8aTGor8MocOJm1C1vvXaHVYXWgrobevintoyomaZSlcsts=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(41300700001)(86362001)(82960400001)(5660300002)(8936002)(4326008)(44832011)(2906002)(38100700002)(83380400001)(966005)(110136005)(478600001)(6486002)(66946007)(26005)(6512007)(186003)(8676002)(6506007)(9686003)(316002)(54906003)(6666004)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8GEoG9zLFMJz1HulwPyhhfMDg0SM2c1WkfUV7vdMj1GX8UNagaWFxZu7t4Rf?=
 =?us-ascii?Q?oqtUOQN+MADLiegj0pZWDWyzypNUrfLpRHFsjtHWO//fi8ppBKbH9H92/EDb?=
 =?us-ascii?Q?gTfBV7WiWIJ2dXEbokT4f584ejUTXdYPJXryPVE7ZPmNfd4XaVae4FkpS7JQ?=
 =?us-ascii?Q?5/tyfom8LvAk53FewIMk9woYLLsNQVWrHI6xZtcnKGW8lg8H499U8KhKTe65?=
 =?us-ascii?Q?9mKwOqIGmzu89j88cdAtA4QTw+qXxWKyE+3OYHjDr6ZQtxLms3PWXEDAi7UX?=
 =?us-ascii?Q?NJCNm65ZCZRHA3vIAfIQg6i3oiZSKPBCKJ/PrjCnCeB0ZlnPOnlLBycjn8gO?=
 =?us-ascii?Q?zenf0LRixEwbKX8Hw9yabvV2S6C4LM5rvmIDduXEewIxkewjG6h/jXqZJ1qV?=
 =?us-ascii?Q?5xWO36MqwuDZwUc/anD3SAixa5D3bEDimRoXgdhxs6WcL/lZYzbcFto8DGei?=
 =?us-ascii?Q?ALKPyvY70+sdcAF8vSwCOPYdNWCBWrYvQ7Eq7BT+pBOdeY2ddUFty6Cq8er7?=
 =?us-ascii?Q?8tYPv3/YZylSPuitLLD9FX1U1aRAkfU1lTVRe2ntr1Tufwsnx8g3CS0cptmb?=
 =?us-ascii?Q?liSflhZahTPvSZbJA4+uwNM2AUqLCuH28CMMzY8DtUf0FfbM12gvKj75Y8ge?=
 =?us-ascii?Q?5wTb/oeDsrihf4Q3+YYZqqEstpZjX0ozz1VZfbkPNAEAlrtAcvKWCgs4NpGg?=
 =?us-ascii?Q?1Qh/u4MOiup+YIUAnYPJW684fDoXrkc39n+XecDLMIk7P9FbKZqF4bJCV5rc?=
 =?us-ascii?Q?8AowZUP37LPE+36ddhhsFmeIMwU8o/tFjw0tzR12/b9q2LvnzeUOV1i7pWvG?=
 =?us-ascii?Q?bEjRV8aVUeaTD9HxQbUe5LFYwLqvNOUafuFJEaw+fMRa0CO6NludBAL7IUMR?=
 =?us-ascii?Q?JauLlli+I7YgehLHjO4GdEqZTTOIG7aO0XqvEs9XO900uOQ66E1/rw+Dqs5C?=
 =?us-ascii?Q?JJHbl+h+7th/nKkd7UFoJjM3wXBrXpITNAp2urMWoQnhWCMAl63PyJZt1Wuj?=
 =?us-ascii?Q?EAukzTo10UB08QeqQLfmFQDwbL3Bioh9IskdScxg9YzGIISvfGuu/4bO0d3w?=
 =?us-ascii?Q?mdF4LG0dopFNlL2j4cazUOk1XG7uzaJzf1fVliRkSuBM/gVzP8gesf8OlHR7?=
 =?us-ascii?Q?flsOVAZDFIqgiUcQgG+7+7sORUH6wtZNXiny1Hx6qLRKdXpGgRP9PWwEO2yx?=
 =?us-ascii?Q?1qqNM0W/Hi1SgQXYXgKxg8IBWX0Ar1KD4idzDTCFiog7sa+G5qb4LCe7s1CY?=
 =?us-ascii?Q?65Fd5akGu9hGSoD6E1Ye6m3XQ3/5g6XoCkxnyrTY1gL/o4t/2SKkgBcXOnzH?=
 =?us-ascii?Q?lHICYBg5BtZsZMMM4IdtxxfPwBoINaDG8yZG/CM7UscsmWsZ4/XtaeE7bZl2?=
 =?us-ascii?Q?JmiNr6e4nqvOZweVSWl80P97OPhkJf4nFJeihaOtSZcyYhg/FczNPvfx9FvA?=
 =?us-ascii?Q?qP/MRBWShZYD46J4Xoudr55Ik15QUVp5inI6kgarp/pCS3QDhHPWNMqrC7H+?=
 =?us-ascii?Q?MoUQqvgllRyFPADu+eeBBdTKnVv1X1wRVwI8B2mn7iGl/bA7icNQQaKB5Thg?=
 =?us-ascii?Q?b4tfIFjo3MffurT6D/EufJTbuPubv/3s8xnvWbiBHmHuuFZs1hExQzWBVgBq?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9b20ef-1fa2-46cc-c885-08dafdac7550
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 01:43:57.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TaI3j5BYo77rF5FkCU3KMDk+lP3E2RnAWmqHim09873rvDK5jaNS9CxNformC3PyIfjYySS4UuzJGR+BoFtXFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
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
> An upcoming user of DOE is CMA (Component Measurement and Authentication,
> PCIe r6.0 sec 6.31).
> 
> It builds on SPDM (Security Protocol and Data Model):
> https://www.dmtf.org/dsp/DSP0274
> 
> SPDM message sizes are not always a multiple of dwords.  To transport
> them over DOE without using bounce buffers, allow sending requests and
> receiving responses whose final dword is only partially populated.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> ---
>  drivers/pci/doe.c | 66 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 40 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 0263bcfdddd8..2113ec95379f 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -76,13 +76,6 @@ struct pci_doe_protocol {
>   * @private: Private data for the consumer
>   * @work: Used internally by the mailbox
>   * @doe_mb: Used internally by the mailbox
> - *
> - * The payload sizes and rv are specified in bytes with the following
> - * restrictions concerning the protocol.
> - *
> - *	1) The request_pl_sz must be a multiple of double words (4 bytes)
> - *	2) The response_pl_sz must be >= a single double word (4 bytes)
> - *	3) rv is returned as bytes but it will be a multiple of double words
>   */
>  struct pci_doe_task {
>  	struct pci_doe_protocol prot;
> @@ -153,7 +146,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>  {
>  	struct pci_dev *pdev = doe_mb->pdev;
>  	int offset = doe_mb->cap_offset;
> -	size_t length;
> +	size_t length, remainder;
>  	u32 val;
>  	int i;
>  
> @@ -171,7 +164,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>  		return -EIO;
>  
>  	/* Length is 2 DW of header + length of payload in DW */
> -	length = 2 + task->request_pl_sz / sizeof(u32);
> +	length = 2 + DIV_ROUND_UP(task->request_pl_sz, sizeof(u32));
>  	if (length > PCI_DOE_MAX_LENGTH)
>  		return -EIO;
>  	if (length == PCI_DOE_MAX_LENGTH)
> @@ -184,10 +177,20 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>  	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
>  			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
>  					  length));
> +
> +	/* Write payload */
>  	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
>  		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
>  				       task->request_pl[i]);
>  
> +	/* Write last payload dword */
> +	remainder = task->request_pl_sz % sizeof(u32);
> +	if (remainder) {
> +		val = 0;
> +		memcpy(&val, &task->request_pl[i], remainder);

Are there any issues with endianess here?

> +		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
> +	}
> +
>  	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_GO);
>  
>  	return 0;
> @@ -207,11 +210,11 @@ static bool pci_doe_data_obj_ready(struct pci_doe_mb *doe_mb)
>  
>  static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  {
> +	size_t length, payload_length, remainder, received;
>  	struct pci_dev *pdev = doe_mb->pdev;
>  	int offset = doe_mb->cap_offset;
> -	size_t length, payload_length;
> +	int i = 0;
>  	u32 val;
> -	int i;
>  
>  	/* Read the first dword to get the protocol */
>  	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> @@ -238,15 +241,34 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>  
>  	/* First 2 dwords have already been read */
>  	length -= 2;
> -	payload_length = min(length, task->response_pl_sz / sizeof(u32));
> -	/* Read the rest of the response payload */
> -	for (i = 0; i < payload_length; i++) {
> -		pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> -				      &task->response_pl[i]);
> +	received = task->response_pl_sz;
> +	payload_length = DIV_ROUND_UP(task->response_pl_sz, sizeof(u32));
> +	remainder = task->response_pl_sz % sizeof(u32);
> +	if (!remainder)
> +		remainder = sizeof(u32);
> +
> +	if (length < payload_length) {
> +		received = length * sizeof(u32);
> +		payload_length = length;
> +		remainder = sizeof(u32);

It was a bit confusing why remainder was set to a dword here.  But I got
that it is because length and payload_length are both in dwords.

> +	}
> +
> +	if (payload_length) {
> +		/* Read all payload dwords except the last */
> +		for (; i < payload_length - 1; i++) {
> +			pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> +					      &task->response_pl[i]);
> +			pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +		}
> +
> +		/* Read last payload dword */
> +		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> +		memcpy(&task->response_pl[i], &val, remainder);

Same question on endianess.

Ira

>  		/* Prior to the last ack, ensure Data Object Ready */
> -		if (i == (payload_length - 1) && !pci_doe_data_obj_ready(doe_mb))
> +		if (!pci_doe_data_obj_ready(doe_mb))
>  			return -EIO;
>  		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +		i++;
>  	}
>  
>  	/* Flush excess length */
> @@ -260,7 +282,7 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>  	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
>  		return -EIO;
>  
> -	return min(length, task->response_pl_sz / sizeof(u32)) * sizeof(u32);
> +	return received;
>  }
>  
>  static void signal_task_complete(struct pci_doe_task *task, int rv)
> @@ -560,14 +582,6 @@ static int pci_doe_submit_task(struct pci_doe_mb *doe_mb,
>  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
>  		return -EINVAL;
>  
> -	/*
> -	 * DOE requests must be a whole number of DW and the response needs to
> -	 * be big enough for at least 1 DW
> -	 */
> -	if (task->request_pl_sz % sizeof(u32) ||
> -	    task->response_pl_sz < sizeof(u32))
> -		return -EINVAL;
> -
>  	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
>  		return -EIO;
>  
> -- 
> 2.39.1
> 


