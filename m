Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60416A75D6
	for <lists+linux-pci@lfdr.de>; Wed,  1 Mar 2023 22:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCAVHz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Mar 2023 16:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCAVHy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Mar 2023 16:07:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C1210EA;
        Wed,  1 Mar 2023 13:07:51 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677704869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B374OxTzVS9QcjckHvkiwhr+6E3lqWByqJOzxF2qGow=;
        b=1drUTVAXKqngwe09WrmIidH/RzxI6ZIGMbKPz/8rOfWchpWKji8v3Sd9k/iiJSrrs0Iqav
        rbrDSJRayQwz/HBJVgZWfK4WdTEZ9ZLJ36vYw81BaHEcJEbQQ8FnZ8/CjwLJi1YHx0fioe
        FpS8swwObQDVsKoiMAY6dQv8F4JwaAZjs4QrDFdNznCDcVxVD5LRWiE6z7+xGAYA2bVXj7
        S9Jyrmmiu+gesDGg71KvcSeCYWfjOwaACVFvCfUsv2R1Flux+bdkbfqUQqSI/G1XHmq0uW
        WXlWEHaA477XPYFtRUjNP8uOeSKbkX7NXdZQuCu18GBZIlqT7qUEnWqh6749wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677704869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B374OxTzVS9QcjckHvkiwhr+6E3lqWByqJOzxF2qGow=;
        b=5Ajx6tscPHnH64xp+028YR2a9czj6LIZcEPYMzh0ULXNf96J2x0Dqr24aGYiU87iLVJuBC
        Ka5YEgQGUGeS9VBg==
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [patch 05/39] genirq/msi: Remove filter from
 msi_free_descs_free_range()
In-Reply-To: <20230301115530.5ccea5ae@xps-13>
References: <20221111120501.026511281@linutronix.de>
 <20221111122013.888850936@linutronix.de> <20230301115530.5ccea5ae@xps-13>
Date:   Wed, 01 Mar 2023 22:07:48 +0100
Message-ID: <87mt4wkwnv.ffs@tglx>
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

Miquel!

On Wed, Mar 01 2023 at 11:55, Miquel Raynal wrote:
> tglx@linutronix.de wrote on Fri, 11 Nov 2022 14:54:22 +0100 (CET):
>
>> When a range of descriptors is freed then all of them are not associated to
>> a linux interrupt. Remove the filter and add a warning to the free function.
>> +		/* Leak the descriptor when it is still referenced */
>> +		if (WARN_ON_ONCE(msi_desc_match(desc, MSI_DESC_ASSOCIATED)))
>> +			continue;
>> +		msi_free_desc(desc);
>>  	}
>>  }
>
> It looks like since this commit I am getting warnings upon EPROBE_DEFER
> errors in the mvpp2 Marvell Ethernet driver. I looked a bit at the
> internals to understand why this warning was shown, and it seems that
> nothing "de-references" the descriptors, which would mean here:
> resetting desc->irq to 0.

Correct. This platform-msi ^(*&!@&^ hack really needs to die ASAP.

Marc, where are we on that? Is this still in limbo?

> I am wondering how useful thisd WARN_ON() is, or otherwise where the

It is useful as it caught bugs already.

> desc->irq entry should be zeroed (if I understand that correctly), any
> help will be appreciated.

Untested workaround below. I hate it with a passion, but *shrug*.

Thanks,

        tglx
---
 drivers/base/platform-msi.c |    1 +
 include/linux/msi.h         |    2 ++
 kernel/irq/msi.c            |   23 ++++++++++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -324,6 +324,7 @@ void platform_msi_device_domain_free(str
 	struct platform_msi_priv_data *data = domain->host_data;
 
 	msi_lock_descs(data->dev);
+	msi_domain_depopulate_descs(data->dev, virq, nr_irqs);
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 	msi_free_msi_descs_range(data->dev, virq, virq + nr_irqs - 1);
 	msi_unlock_descs(data->dev);
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -631,6 +631,8 @@ int msi_domain_prepare_irqs(struct irq_d
 			    int nvec, msi_alloc_info_t *args);
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 			     int virq, int nvec, msi_alloc_info_t *args);
+void msi_domain_depopulate_descs(struct device *dev, int virq, int nvec);
+
 struct irq_domain *
 __platform_msi_create_device_domain(struct device *dev,
 				    unsigned int nvec,
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1109,14 +1109,35 @@ int msi_domain_populate_irqs(struct irq_
 	return 0;
 
 fail:
-	for (--virq; virq >= virq_base; virq--)
+	for (--virq; virq >= virq_base; virq--) {
+		msi_domain_depopulate_descs(dev, virq, 1);
 		irq_domain_free_irqs_common(domain, virq, 1);
+	}
 	msi_domain_free_descs(dev, &ctrl);
 unlock:
 	msi_unlock_descs(dev);
 	return ret;
 }
 
+void msi_domain_depopulate_descs(struct device *dev, int virq_base, int nvec)
+{
+	struct msi_ctrl ctrl = {
+		.domid	= MSI_DEFAULT_DOMAIN,
+		.first  = virq_base,
+		.last	= virq_base + nvec - 1,
+	};
+	struct msi_desc *desc;
+	struct xarray *xa;
+	unsigned long idx;
+
+	if (!msi_ctrl_valid(dev, &ctrl))
+		return;
+
+	xa = &dev->msi.data->__domains[ctrl.domid].store;
+	xa_for_each_range(xa, idx, desc, ctrl.first, ctrl.last)
+		desc->irq = 0;
+}
+
 /*
  * Carefully check whether the device can use reservation mode. If
  * reservation mode is enabled then the early activation will assign a
