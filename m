Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03306678D38
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 02:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjAXBSq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 20:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjAXBSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 20:18:43 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3EACDDA;
        Mon, 23 Jan 2023 17:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674523115; x=1706059115;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=93hrz68O9G/Pro7pFnpUAO+ufm7TNY366ibzwxcJ9bg=;
  b=gMSsmpFjfea//9OXwFmLvTdJdsjfir+iq17VpRMqg4kr0kV2w3pBXYw6
   DZi2kqRVCUsi7UldnbiHb4wv4bRa69c9IX3vmzsLIOIA0cjjOC4YMGQ4D
   pWbaOs20h5cDRMhEHhQnw2SVGSHwiixnF3lfnkUg0YdFSvdscH4SuACIo
   b4tSJIP1bgCtcZEaNqJuNinIOkmjm2HFeE8BY8PO4r+LY5iRt1Fda9xoc
   IykdtJrGP7v2yPgjvVHMW4ml9lP/XlH5i6lz41/te/9y4NKk/f2OjrrRn
   43fNQV8ASRBVKPNafEB6nIF/yPFQZOAPNws320b3hrgvw+Uc8RhSziTNK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="309784244"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="309784244"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 17:18:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="725290937"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="725290937"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jan 2023 17:18:34 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 17:18:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 17:18:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 17:18:34 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 17:18:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDv3R76TEW0hVaPbQbrw+bx4NfY3ImIG1HmHVfJCAGMPYzRAKxOo71UguYLyZQQbEBqvFV52e9QRzQjGwD17QQbe4+rrb4Cge+wcJBMv4y20ubkgOZHq5BmiUFVkdZ9g7Dyd5G3b4Ph52RE1JXdTy6vR5CfbmPLCBkKqQpYGrCeYGvgarEHmQAcbhqKHGsOpSj+QmvDyhsCjbpLDir6qxax8ItA6irIlt2yP2hEBfv5TOqS/AIcHxX3qSgMsGtXO1NWx7uTPCEvl4K5zQLIzfSz8xFgjiDh3VTvBVK8f0ZDiJEV/a4ThkhojFmKnx1f2uKw0qIuW8xruB/N6cUbJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbpqyYLVevbD9IAR3NHTbxsn096aLIeIi4e5LGiPd+I=;
 b=RHA4YVrT0tklcjxFvsD+NxOuW5alXW+VML2PNJT4Sf+igEHpQEIUDT4c4pPbEPbN/wgqxioAH3cvpPe8QItfNfdwTx10mtcnwJRPj/EIbQ7s1WOuN5YvP9ohL+l9hT6X3SZbXniph8rcJ6rchcAOS65rGRbVBAFSBERsv5rQYGglW2YCRJ3W9mg1fRzEMJvddR+L5HiXVPrFdWDvf64x41s2rz6rr1PEltyyMS9xvVDL9kLGq/ccYdCf0AFGqlmSrHsv7NvwNndUhcJleyb3SWj0RKJ7uMz8Wtn1FUQpGHdoHwRiX6dipTtBl7bgcSZFULyrIK/L2rakWTR6RvhUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5397.namprd11.prod.outlook.com (2603:10b6:208:308::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 01:18:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Tue, 24 Jan 2023
 01:18:29 +0000
Date:   Mon, 23 Jan 2023 17:18:25 -0800
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
Subject: Re: [PATCH v2 08/10] cxl/pci: Use CDAT DOE mailbox created by PCI
 core
Message-ID: <63cf31e1ae7ed_5709294ee@iweiny-mobl.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
 <45e6f7b2ab780e78b42490bb49e9a193a5598a07.1674468099.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <45e6f7b2ab780e78b42490bb49e9a193a5598a07.1674468099.git.lukas@wunner.de>
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5397:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce8999f-91a9-4d63-9caa-08dafda8e6c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHFwidmfcxmTPR7vOhIUDTDR1thK9uXXqA1/yrtB5QAG+dHWerWzesi+JBvK/MC0bkn1cbXYYrvAM5spF65udRU+rmemkbHah7KJh/NjFnd9VmMDFOwZo1j6NS0SRKcJIIvkdrDs6BL24hwrshJ/3+iLvX3fK/bvrWLGaQfh+JqcUPEAqqRvaHTG2KNkWp71D82GBwg7GxelIfaR7xZn4iE28UkDItEuHXu9nkA9BkV4PJABC81JMqwbT2wdLqwLjVkm19FEVuco11zgXdaQfUA5sqvF06k0sQ/f6IciXR61ig3MNa0KM6nMrMInTkJgC3drlsYK2YiEJZyTFycJ5ED3T4iAWwa8zx8rnqNR3pQJZ3qg8E8Tyh2AEru+gXL0Oju5y6sCtEE/RbJYwAPusEeelST2mXd++bjZqVHeuGZ31G6mBjmNPxDwMhPUSiKHPXFL24RBf6umf4lkP71ke5uc+OJrOkXY/ua8D2SiTPhbYIVTPRMNyykHoP4Tg891VcicqOIMizw+6uWhJHwmbw+dwFFDJ79dsAP6MT/mrFHkwYzFQR/TzJ2uwLr1qzpxBtSM1SVcXeg++tnQUSB88GGcp+sxvmnuLV1eB8vRJJe5rjmXD80NLE+JRxFpA2Yt+m2Jsh6cZUZulh3IHX/DzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(15650500001)(38100700002)(82960400001)(41300700001)(2906002)(44832011)(8936002)(5660300002)(4326008)(8676002)(6506007)(316002)(54906003)(83380400001)(66556008)(66946007)(66476007)(86362001)(110136005)(478600001)(6486002)(6666004)(9686003)(26005)(6512007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xH6i+GG5zmEdpdDXK2i7OyRpXNkCYoL708FLxitQDA/1gjPQhpGEYCdRbs1s?=
 =?us-ascii?Q?3+9RXoQSIsjeCUXHAvWalGypFg48WQOpwij5ISSZADxjgM8oqMnxvDe7963u?=
 =?us-ascii?Q?dqOx+UZjfaP/L1mVetimmeSxnL/JnNgVARYjMO7FoKjHpGs29/h47e0z1VbF?=
 =?us-ascii?Q?ZYVdA1k9GREtczQPETU0+JbYqHAeTeWQp4OSiVcUZNkUIxLEfkPmGTTwzVlf?=
 =?us-ascii?Q?AhZ6vBVkH2bDytRMUXDcWKmgFQG0IVzLhxQcIRQBCXhb3JiPAj3ToNPlJnUP?=
 =?us-ascii?Q?eNB44ilFzWkVfAOIrk6J5IrT91jKyudG4zhvY+I5VUx9mSAO8bOeMZ1QXBes?=
 =?us-ascii?Q?fDfrYuPJOoQaZsfnexatdQN7qV7ws+Juuml7nQ8ydZQ3t8/zoACXHDKd7GJ0?=
 =?us-ascii?Q?OhdD/FplhHb1KIA8E4E0gl+rL+4KCn2cx8nUqs7Ev237ybkAxsZrQq7XB/kT?=
 =?us-ascii?Q?2exFQwm0goJBN+SxPMWooSsI+mRKIgWNIXDf6PzTd8nmTbE7azwM4n2/3Ogs?=
 =?us-ascii?Q?cPCLQh7Top7GY/XSagElZXC7TJaBuA/j7jkputz5s8kQISvolis2mBpa6LQP?=
 =?us-ascii?Q?loKpjDJF3PWh8LAL5S0/3vTVtd09RXpecWLrVvqLOEqPqjlvvX23QOo4VLsD?=
 =?us-ascii?Q?G3CLnV/BaWyHHmq9J4c5lZoYM7sGTlmCPV3SY9AwaNvT7+KWgY0Riop1kfZE?=
 =?us-ascii?Q?G+bpXhCVZYe5WVqhDfgSYqIiL5mOJ3w+SzC01k3hJpWONVf+uZebL0W/xhwe?=
 =?us-ascii?Q?bM+coQs683DoWix2m6mIt6qOInqUGKgT5oAv2oq6P3U8j3NCIsFSJNhVtfx4?=
 =?us-ascii?Q?9GpCfitoVnCY666LR7XWyrBNP5IePWE6J5P4G7L99IQdO7nDRpEekhe+n5TU?=
 =?us-ascii?Q?1bVO6jP7+wbJNdw8/W8VEhE90pJ+zKtBZiysvjmaTuN4ww4bgmEvCMwogZ+U?=
 =?us-ascii?Q?2Dtv6ANjiBjSyoADq3V02WN8dSPKTKd3sv9XJuvy3U7iL0KY80wJGZZYMcnV?=
 =?us-ascii?Q?KWgld0AEEUymLlhmeT+cs/6UGnfQO7rN7U4/VRiSOGQ1WmDxN0qjMV5fxm+Q?=
 =?us-ascii?Q?61gzXPHj5/e453W7zAeTzpek1603JmHndXbN7rnjlURaNYjC2hgYCq3EeC7s?=
 =?us-ascii?Q?16Wqo0M2p0FVqiGR3RvO3nwzAmz1V5NU1TPUJVzAPhFeTINjiLHkntfB+BiL?=
 =?us-ascii?Q?58/koi53C34GKsg0pH12IPoRZli/+Ta8rPwNxY3rqACWff0P2L/N+pcbz9TZ?=
 =?us-ascii?Q?L2cbpdeRaPgjfveSIwpVw1eCralV9SO1Vkya+hVyV28wMvV5XDjGF1ieE3zI?=
 =?us-ascii?Q?cj+WO3zhymi+dJIKlkXAjfqDCwVEdBeK9tWTzGpmt89rA4bAKJXfPvxNz42u?=
 =?us-ascii?Q?MTMzoVnzW8sQZCYmOz57Uc4IK3i6ihBgpeO9tsTZ9cJrduPDyHp9yeXw+9B0?=
 =?us-ascii?Q?JG9lhvF1g1sm90epI1QTtyTUJXUF3NdG9ymBFd4LAbHhJtvotEhSX3a1TdA4?=
 =?us-ascii?Q?VTVYhVqQbeRDjGPw+nGVo9QYhrQBJoxRIPKU2TDoPTd4AC1RH0s3LixHwIpk?=
 =?us-ascii?Q?pmIaV8mOsH41pHWpOyVTuH0U/LyHMrSCtAjg4u4lXVB9Q8RvjnZ0pJHNWic6?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce8999f-91a9-4d63-9caa-08dafda8e6c7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 01:18:29.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3VJaujx+pEdm7TPEgA7iiwDq2JALLai7zZTHMIgWkGWGX82Xvq2YSvt4qJ2YagAadeP9iBYp/K9u+TDw/95Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5397
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
> The PCI core has just been amended to create a pci_doe_mb struct for
> every DOE instance on device enumeration.
> 
> Drop creation of a (duplicate) CDAT DOE mailbox on cxl probing in favor
> of the one already created by the PCI core.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/cxl/core/pci.c | 27 +++++------------------
>  drivers/cxl/cxlmem.h   |  3 ---
>  drivers/cxl/pci.c      | 49 ------------------------------------------
>  3 files changed, 5 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a02a2b005e6a..5cb6ffa8df0e 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -459,27 +459,6 @@ EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
>  #define CXL_DOE_TABLE_ACCESS_LAST_ENTRY		0xffff
>  #define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
>  
> -static struct pci_doe_mb *find_cdat_doe(struct device *uport)
> -{
> -	struct cxl_memdev *cxlmd;
> -	struct cxl_dev_state *cxlds;
> -	unsigned long index;
> -	void *entry;
> -
> -	cxlmd = to_cxl_memdev(uport);
> -	cxlds = cxlmd->cxlds;
> -
> -	xa_for_each(&cxlds->doe_mbs, index, entry) {
> -		struct pci_doe_mb *cur = entry;
> -
> -		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
> -					  CXL_DOE_PROTOCOL_TABLE_ACCESS))
> -			return cur;
> -	}
> -
> -	return NULL;
> -}
> -
>  #define CDAT_DOE_REQ(entry_handle)					\
>  	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
>  		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
> @@ -569,10 +548,14 @@ void read_cdat_data(struct cxl_port *port)
>  	struct pci_doe_mb *cdat_doe;
>  	struct device *dev = &port->dev;
>  	struct device *uport = port->uport;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>  	size_t cdat_length;
>  	int rc;
>  
> -	cdat_doe = find_cdat_doe(uport);
> +	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +					CXL_DOE_PROTOCOL_TABLE_ACCESS);
>  	if (!cdat_doe) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
>  		return;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..e1a1b23cf56c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -227,7 +227,6 @@ struct cxl_endpoint_dvsec_info {
>   * @component_reg_phys: register base of component registers
>   * @info: Cached DVSEC information about the device.
>   * @serial: PCIe Device Serial Number
> - * @doe_mbs: PCI DOE mailbox array
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -264,8 +263,6 @@ struct cxl_dev_state {
>  	resource_size_t component_reg_phys;
>  	u64 serial;
>  
> -	struct xarray doe_mbs;
> -
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 33083a522fd1..f8b8e514a3c6 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -8,7 +8,6 @@
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/pci.h>
> -#include <linux/pci-doe.h>
>  #include <linux/aer.h>
>  #include <linux/io.h>
>  #include "cxlmem.h"
> @@ -359,52 +358,6 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	return rc;
>  }
>  
> -static void cxl_pci_destroy_doe(void *mbs)
> -{
> -	xa_destroy(mbs);
> -}
> -
> -static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> -{
> -	struct device *dev = cxlds->dev;
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	u16 off = 0;
> -
> -	xa_init(&cxlds->doe_mbs);
> -	if (devm_add_action(&pdev->dev, cxl_pci_destroy_doe, &cxlds->doe_mbs)) {
> -		dev_err(dev, "Failed to create XArray for DOE's\n");
> -		return;
> -	}
> -
> -	/*
> -	 * Mailbox creation is best effort.  Higher layers must determine if
> -	 * the lack of a mailbox for their protocol is a device failure or not.
> -	 */
> -	pci_doe_for_each_off(pdev, off) {
> -		struct pci_doe_mb *doe_mb;
> -
> -		doe_mb = pcim_doe_create_mb(pdev, off);
> -		if (IS_ERR(doe_mb)) {
> -			dev_err(dev, "Failed to create MB object for MB @ %x\n",
> -				off);
> -			continue;
> -		}
> -
> -		if (!pci_request_config_region_exclusive(pdev, off,
> -							 PCI_DOE_CAP_SIZEOF,
> -							 dev_name(dev)))
> -			pci_err(pdev, "Failed to exclude DOE registers\n");
> -
> -		if (xa_insert(&cxlds->doe_mbs, off, doe_mb, GFP_KERNEL)) {
> -			dev_err(dev, "xa_insert failed to insert MB @ %x\n",
> -				off);
> -			continue;
> -		}
> -
> -		dev_dbg(dev, "Created DOE mailbox @%x\n", off);
> -	}
> -}
> -
>  /*
>   * Assume that any RCIEP that emits the CXL memory expander class code
>   * is an RCD
> @@ -469,8 +422,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxlds->component_reg_phys = map.resource;
>  
> -	devm_cxl_pci_create_doe(cxlds);
> -
>  	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
>  				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
>  	if (rc)
> -- 
> 2.39.1
> 


