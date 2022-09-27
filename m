Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C1C5EC543
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 15:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiI0N7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 09:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiI0N6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 09:58:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C38146610;
        Tue, 27 Sep 2022 06:58:39 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4McLm45ks9z688Z6;
        Tue, 27 Sep 2022 21:57:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 15:58:37 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 14:58:37 +0100
Date:   Tue, 27 Sep 2022 14:58:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V3 2/2] cxl/doe: Request exclusive DOE access
Message-ID: <20220927145836.0000572e@huawei.com>
In-Reply-To: <20220926215711.2893286-3-ira.weiny@intel.com>
References: <20220926215711.2893286-1-ira.weiny@intel.com>
        <20220926215711.2893286-3-ira.weiny@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 26 Sep 2022 14:57:11 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
> configuration cycles.  It assumes one initiator at a time.  While the
> kernel has control of the mailbox user space writes could interfere with
> the kernel access.
> 
> Mark DOE mailbox config space exclusive when iterated by the CXL driver.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
I wonder a bit on whether the failure should be fatal given that something
very odd would be required for it to fail.

I'm not that bothered though.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes from V2:
> 	Jonathan:
> 		s/PCI_DOE_CAP_SIZE/PCI_DOE_CAP_SIZEOF
> 		Set PCI_DOE_CAP_SIZEOF directly
> ---
>  drivers/cxl/pci.c             | 5 +++++
>  include/uapi/linux/pci_regs.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..621a0522b554 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -418,6 +418,11 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>  			continue;
>  		}
>  
> +		if (!pci_request_config_region_exclusive(pdev, off,
> +							 PCI_DOE_CAP_SIZEOF,
> +							 dev_name(dev)))
> +			pci_err(pdev, "Failed to exclude DOE registers\n");
> +
>  		if (xa_insert(&cxlds->doe_mbs, off, doe_mb, GFP_KERNEL)) {
>  			dev_err(dev, "xa_insert failed to insert MB @ %x\n",
>  				off);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 57b8e2ffb1dd..82a03ea954af 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1119,6 +1119,7 @@
>  #define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */
>  #define PCI_DOE_WRITE		0x10    /* DOE Write Data Mailbox Register */
>  #define PCI_DOE_READ		0x14    /* DOE Read Data Mailbox Register */
> +#define PCI_DOE_CAP_SIZEOF	0x18	/* Size of DOE register block */
>  
>  /* DOE Data Object - note not actually registers */
>  #define PCI_DOE_DATA_OBJECT_HEADER_1_VID		0x0000ffff

