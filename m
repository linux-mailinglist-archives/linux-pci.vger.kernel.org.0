Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927E67C512F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjJKLLQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbjJKLLB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:11:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4B31A8;
        Wed, 11 Oct 2023 04:10:46 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S593K0B7Pz67cXm;
        Wed, 11 Oct 2023 19:07:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 12:10:43 +0100
Date:   Wed, 11 Oct 2023 12:10:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        Ilpo =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 07/10] PCI/PME: Use FIELD_GET()
Message-ID: <20231011121042.00003d13@Huawei.com>
In-Reply-To: <20231010204436.1000644-8-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
        <20231010204436.1000644-8-helgaas@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Tue, 10 Oct 2023 15:44:33 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use FIELD_GET() to remove dependences on the field position, i.e., the
> shift value.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pcie/pme.c        | 4 +++-
>  include/uapi/linux/pci_regs.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index ef8ce436ead9..a2daebd9806c 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -9,6 +9,7 @@
>  
>  #define dev_fmt(fmt) "PME: " fmt
>  
> +#include <linux/bitfield.h>
>  #include <linux/pci.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> @@ -235,7 +236,8 @@ static void pcie_pme_work_fn(struct work_struct *work)
>  			pcie_clear_root_pme_status(port);
>  
>  			spin_unlock_irq(&data->lock);
> -			pcie_pme_handle_request(port, rtsta & 0xffff);
> +			pcie_pme_handle_request(port,
> +				    FIELD_GET(PCI_EXP_RTSTA_PME_RQ_ID, rtsta));
>  			spin_lock_irq(&data->lock);
>  
>  			continue;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e97a06b50f95..9fb8a69241f4 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -637,6 +637,7 @@
>  #define PCI_EXP_RTCAP		0x1e	/* Root Capabilities */
>  #define  PCI_EXP_RTCAP_CRSVIS	0x0001	/* CRS Software Visibility capability */
>  #define PCI_EXP_RTSTA		0x20	/* Root Status */
> +#define  PCI_EXP_RTSTA_PME_RQ_ID 0x0000ffff /* PME Requester ID */
>  #define  PCI_EXP_RTSTA_PME	0x00010000 /* PME status */
>  #define  PCI_EXP_RTSTA_PENDING	0x00020000 /* PME pending */
>  /*

