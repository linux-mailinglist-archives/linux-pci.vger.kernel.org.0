Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C836E63B3D6
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 22:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiK1VDY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Nov 2022 16:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiK1VDY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Nov 2022 16:03:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA20C12;
        Mon, 28 Nov 2022 13:03:22 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669669400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XhB7JGU0+3dUf/xb6vSXZN0hUM70VXiiaFn2KBna12A=;
        b=zlvNwIwoHG+fU4gxnuatMPxfyVs5ZSLePNJu4/ocONdVKcLEZDqxHiVlXWATLTuFzvzVQH
        wvylbGYhnIJkRBfI06fvH8zrEydybvoGyJU4k6idIaEb8132jwZUwabOGcYf5ls2TUSa81
        SbeW0BZ0iRRMeh23zOgiaOb0YEuMrwElmiEaTS7Nepm/GHglMgTFNCurANP6kTLFcFlxT+
        S6h+mst5tidq7iJ67Vk4o2lLC31GVx0EpMSI7Jy53xj9hjy0e+Xb2TiEVK7iM0+bf272Ze
        2pAQf4pFBLaQtNW95y+qQXVA9uI271Sl7FODDOKRr/856Yr93LB6VMiYkim0lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669669400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XhB7JGU0+3dUf/xb6vSXZN0hUM70VXiiaFn2KBna12A=;
        b=CWSwp1XKO4MBIhCx2CWco0lkUyqfbLhLh5RYHrL1h2GQY7cqKnAbOprHdP8gtA7ZMoKFpk
        LeZC3c+3eRBaziBw==
To:     Frank Li <Frank.Li@nxp.com>
Cc:     agross@kernel.org, ammarfaizi2@gnuweeb.org, andersson@kernel.org,
        andrew@lunn.ch, bhelgaas@google.com, festevam@gmail.com,
        gregkh@linuxfoundation.org, gregory.clement@bootlin.com,
        jgg@mellanox.com, kristo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        nm@ti.com, okaya@kernel.org, robin.murphy@arm.com,
        s.hauer@pengutronix.de, sebastian.hesselbarth@gmail.com,
        shameerali.kolothum.thodi@huawei.com, shawnguo@kernel.org,
        ssantosh@kernel.org, vkoul@kernel.org, will@kernel.org,
        yuzenghui@huawei.com, imx@lists.linux.dev
Subject: Re: [patch V2 33/40] irqchip/imx-mu-msi: Switch to MSI parent
In-Reply-To: <20221128204710.2084706-1-Frank.Li@nxp.com>
References: <20221121140050.386216606@linutronix.de>
 <20221128204710.2084706-1-Frank.Li@nxp.com>
Date:   Mon, 28 Nov 2022 22:03:20 +0100
Message-ID: <87tu2ivlk7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Frank!

On Mon, Nov 28 2022 at 15:47, Frank Li wrote:
> On Mon, Nov 21, 2022 at 03:40:09PM +0100, Thomas Gleixner wrote:
>>  	 * The device MSI domain can never have a set affinity callback it
>> --- a/drivers/irqchip/irq-imx-mu-msi.c
>> +++ b/drivers/irqchip/irq-imx-mu-msi.c
>> @@ -24,6 +24,8 @@
>>  #include <linux/pm_domain.h>
>>  #include <linux/spinlock.h>
>>  
>> +#include "irq-gic-msi-lib.h"
>> +
>
> I think irq-gic-msi-lib.h is not good name. Actually mu-msi is not arm gic.
> irq-gic-msi-lib do common work, which not related arm gic at all.

I realized that after a while too, but the main purpose of this series
was to establish that the core design holds up to handle the gazillions
of ARM variants out there and to solicit technical feedback from the
involved parties.

>>  static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *dev)
>>  {
>>  	struct fwnode_handle *fwnodes = dev_fwnode(dev);
>>  	struct irq_domain *parent;
>>  
>>  	/* Initialize MSI domain parent */
>> -	parent = irq_domain_create_linear(fwnodes,
>> -					    IMX_MU_CHANS,
>> -					    &imx_mu_msi_domain_ops,
>> -					    msi_data);
>> +	parent = irq_domain_create_linear(fwnodes, IMX_MU_CHANS, &imx_mu_msi_domain_ops, msi_data);
>
> coding style change should be in sperated patch.

Thanks for the thorough technical feedback!

       tglx
