Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2223262E083
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 16:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbiKQP6y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 10:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240048AbiKQP6q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 10:58:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489170A10;
        Thu, 17 Nov 2022 07:58:43 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668700722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3I3CzNiMhPDXaj6+qO5LxTRdoySb6A06cC9DobhxnIw=;
        b=bQxjphwBl7iwogrkqCjK+7FLmZa6Qtcx4r3iiQ1FC0jUbK1oTVodyNl0ST5ysr6E+f9hpK
        QCwMuR70kDyxRHafB6e7LjRChjCp6LSM4jCT0rPKSjsTOV70lGS2+tSQliU6n9XMpOhnuU
        yqUpfOIRzPRxwwiJ/swO9dWFM9ur4qLeBtdFmTtqkJ++1rCFPSzxgGgl4dNLyZGH53rC/8
        8KRlCoyPSbQLam9Vp5BkvlmNm1U6rsri5IGXpI2vUShQDfvaGqtVkLI1JILog20EsMLAkN
        6b9I0PiqZAxrz+u1jUItU3YaAmHIS2HFRyc7HpYsk9NhSAHLq/9yhAFEqvreEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668700722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3I3CzNiMhPDXaj6+qO5LxTRdoySb6A06cC9DobhxnIw=;
        b=XihOv7j87axcUTJcuy32uNcXPd3fJu/9c5Nk4HuevLscZM4hyjLlFPIJMK40aMLZ2CztLp
        7RbK5GcBuZ2latBw==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 02/33] genirq/msi: Provide struct msi_parent_ops
In-Reply-To: <Y3Uynk6brtNVFUH7@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135205.368911521@linutronix.de> <Y3Uynk6brtNVFUH7@nvidia.com>
Date:   Thu, 17 Nov 2022 16:58:42 +0100
Message-ID: <8735ahmv2l.ffs@tglx>
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

On Wed, Nov 16 2022 at 14:57, Jason Gunthorpe wrote:
> On Fri, Nov 11, 2022 at 02:58:14PM +0100, Thomas Gleixner wrote:
>> + * This is the most complex problem of per device MSI domains and the
>> + * underlying interrupt domain hierarchy:
>> + *
>> + * The device domain to be initialized requests the broadest feature set
>> + * possible and the underlying domain hierarchy puts restrictions on it.
>> + *
>> + * That's working perfectly fine for a strict parent->device model, but it
>> + * falls apart with a root_parent->real_parent->device chain because the
>
> This language hurt my brain :)

IKR

>> +bool msi_parent_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
>> +				  struct irq_domain *real_parent, struct msi_domain_info *info)
>
> 'real_parent' is global IRQ_DOMAIN_FLAG_MSI_PARENT of the dev for
> which we are constructing a msi_domain_info to create a child aka
> IRQ_DOMAIN_FLAG_MSI_DEVICE?
>
> 'domain' is the current step in the hierarchy as we walk up the ops
> pointers?

Yes.

> Maybe:
>
> @child_info: The MSI domain info of the IRQ_DOMAIN_FLAG_MSI_DEVICE
>              domain to be created
> @parent_domain: The IRQ_DOMAIN_FLAG_MSI_PARENT domain for the child to
>                 be created
> @domain: The domain in the hierarchy this op is being called on

Definitely better.

> And perhaps it would be a bit clearer to put the parent_domain inside
> the msi_domain_info, which is basically acting as an argument bundle
> for a future allocation call?

Maybe. Let me try.
