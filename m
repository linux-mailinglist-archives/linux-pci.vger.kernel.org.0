Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B59F6327AA
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 16:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiKUPRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 10:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiKUPR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 10:17:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55FD1D70;
        Mon, 21 Nov 2022 07:13:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34DF91FB;
        Mon, 21 Nov 2022 07:13:54 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF31F3F73B;
        Mon, 21 Nov 2022 07:13:43 -0800 (PST)
Message-ID: <4a2836d6-3088-c513-7541-be7c8a0464a5@arm.com>
Date:   Mon, 21 Nov 2022 15:13:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [patch V2 02/40] ACPI/IORT: Make prototype of
 iort_pmsi_get_dev_id() always available
Content-Language: en-GB
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
References: <20221121135653.208611233@linutronix.de>
 <20221121140048.408064684@linutronix.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221121140048.408064684@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-11-21 14:39, Thomas Gleixner wrote:
> W=1 build complains:
> 
> drivers/irqchip/irq-gic-v3-its-msi-parent.c:110:12: warning: no previous prototype for function 'iort_pmsi_get_dev_id' [-Wmissing-prototypes]
>     int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
> 
> Reported-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> ---
>   include/linux/acpi_iort.h |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -26,13 +26,15 @@ int iort_register_domain_token(int trans
>   			       struct fwnode_handle *fw_node);
>   void iort_deregister_domain_token(int trans_id);
>   struct fwnode_handle *iort_find_domain_token(int trans_id);
> +
> +int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
> +
>   #ifdef CONFIG_ACPI_IORT
>   void acpi_iort_init(void);
>   u32 iort_msi_map_id(struct device *dev, u32 id);
>   struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
>   					  enum irq_domain_bus_token bus_token);
>   void acpi_configure_pmsi_domain(struct device *dev);
> -int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);

FWIW I'd prefer to add a "return -ENODEV" stub in the #else section to 
match the others.

<wonders why this was inconsistent to begin with, goes off to dig 
through Git history...>

Oh hey, then we could also finally make good on that 6-year-old promise 
that "The weak function will be removed when the ACPI counterpart is 
merged." :)

Thanks,
Robin.

>   void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
>   		       struct list_head *head);
>   void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
> 
