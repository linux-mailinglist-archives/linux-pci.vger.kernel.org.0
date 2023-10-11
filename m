Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A96F7C50BD
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346709AbjJKLCZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346690AbjJKLCX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:02:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24E3B6;
        Wed, 11 Oct 2023 04:02:20 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S58tn6d4Rz6K6FZ;
        Wed, 11 Oct 2023 19:00:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 12:02:17 +0100
Date:   Wed, 11 Oct 2023 12:02:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        Ilpo =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 05/10] PCI/ATS: Use FIELD_GET()
Message-ID: <20231011120217.0000770b@Huawei.com>
In-Reply-To: <20231010204436.1000644-6-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
        <20231010204436.1000644-6-helgaas@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 Oct 2023 15:44:31 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use FIELD_GET() to remove dependences on the field position, i.e., the
> shift value.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
One trivial comment inline. Either way.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/ats.c             | 7 ++-----
>  include/uapi/linux/pci_regs.h | 1 +
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index f9cc2e10b676..c570892b2090 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -9,6 +9,7 @@
>   * Copyright (C) 2011 Advanced Micro Devices,
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/export.h>
>  #include <linux/pci-ats.h>
>  #include <linux/pci.h>
> @@ -480,8 +481,6 @@ int pci_pasid_features(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_pasid_features);
>  
> -#define PASID_NUMBER_SHIFT	8
> -#define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
>  /**
>   * pci_max_pasids - Get maximum number of PASIDs supported by device
>   * @pdev: PCI device structure
> @@ -503,9 +502,7 @@ int pci_max_pasids(struct pci_dev *pdev)
>  
>  	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
>  
> -	supported = (supported & PASID_NUMBER_MASK) >> PASID_NUMBER_SHIFT;
> -
> -	return (1 << supported);
> +	return (1 << FIELD_GET(PCI_PASID_CAP_WIDTH, supported));

Could drop the bonus set of brackets..

>  }
>  EXPORT_SYMBOL_GPL(pci_max_pasids);
>  #endif /* CONFIG_PCI_PASID */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 6af1f8d53e97..833e5fb40ea5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -932,6 +932,7 @@
>  #define PCI_PASID_CAP		0x04    /* PASID feature register */
>  #define  PCI_PASID_CAP_EXEC	0x0002	/* Exec permissions Supported */
>  #define  PCI_PASID_CAP_PRIV	0x0004	/* Privilege Mode Supported */
> +#define  PCI_PASID_CAP_WIDTH	0x1f00
>  #define PCI_PASID_CTRL		0x06    /* PASID control register */
>  #define  PCI_PASID_CTRL_ENABLE	0x0001	/* Enable bit */
>  #define  PCI_PASID_CTRL_EXEC	0x0002	/* Exec permissions Enable */

