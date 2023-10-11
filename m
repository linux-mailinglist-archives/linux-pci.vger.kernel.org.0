Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070D97C50B2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjJKLAH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjJKLAH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:00:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6C294;
        Wed, 11 Oct 2023 04:00:05 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S58t734chz6K8FJ;
        Wed, 11 Oct 2023 18:59:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 12:00:03 +0100
Date:   Wed, 11 Oct 2023 12:00:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        Ilpo =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 04/10] PCI/ATS: Show PASID Capability register width in
 bitmasks
Message-ID: <20231011120002.00002244@Huawei.com>
In-Reply-To: <20231010204436.1000644-5-helgaas@kernel.org>
References: <20231010204436.1000644-1-helgaas@kernel.org>
        <20231010204436.1000644-5-helgaas@kernel.org>
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

On Tue, 10 Oct 2023 15:44:30 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The PASID Capability and Control registers are both 16 bits wide.  Use
> 16-bit wide constants in field names to match the register width.  No
> functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/uapi/linux/pci_regs.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 34bf037993f3..6af1f8d53e97 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -930,12 +930,12 @@
>  
>  /* Process Address Space ID */
>  #define PCI_PASID_CAP		0x04    /* PASID feature register */
> -#define  PCI_PASID_CAP_EXEC	0x02	/* Exec permissions Supported */
> -#define  PCI_PASID_CAP_PRIV	0x04	/* Privilege Mode Supported */
> +#define  PCI_PASID_CAP_EXEC	0x0002	/* Exec permissions Supported */
> +#define  PCI_PASID_CAP_PRIV	0x0004	/* Privilege Mode Supported */
>  #define PCI_PASID_CTRL		0x06    /* PASID control register */
> -#define  PCI_PASID_CTRL_ENABLE	0x01	/* Enable bit */
> -#define  PCI_PASID_CTRL_EXEC	0x02	/* Exec permissions Enable */
> -#define  PCI_PASID_CTRL_PRIV	0x04	/* Privilege Mode Enable */
> +#define  PCI_PASID_CTRL_ENABLE	0x0001	/* Enable bit */
> +#define  PCI_PASID_CTRL_EXEC	0x0002	/* Exec permissions Enable */
> +#define  PCI_PASID_CTRL_PRIV	0x0004	/* Privilege Mode Enable */
>  #define PCI_EXT_CAP_PASID_SIZEOF	8
>  
>  /* Single Root I/O Virtualization */

