Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FD2640EC5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 20:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiLBTvw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 14:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbiLBTvt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 14:51:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEF6EE960;
        Fri,  2 Dec 2022 11:51:48 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670010706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ky2yUk8LekMsMaCLi/lZDI8Q5R+Ohf0PcvEm+cGW1MU=;
        b=4HT1tnErgdjbN4WvLxSokg1x+2yYcCOUI5iJnWRBZcrr0UQeT3vNaXt+mHj1a4kzaHr30W
        6dnk0qV9Z4Xl9WMJ2uY3HCK41moCnZgtsulVYigSB/tedfaXdoiX/6g3+HrmYLXO2CILLk
        MirOI7anKQuQde8xibLYHhdcSF7Qqx8IlEt3Plof4QtWhSCBpX9/4BmL5douBS+XSNlYKP
        hqqhyV1nuUFsVofHm1Ecq8hv2JHj9Wb7qNfVoqe8ozKXhdu+mfp3d6TnTHqpYgZ5m+RH5V
        vtFvdwkWlHFNOV3gTtUcfErPUv+QXt57CgoiQ1fbnxcmf87Gz/VLPFYPJj3CMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670010706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ky2yUk8LekMsMaCLi/lZDI8Q5R+Ohf0PcvEm+cGW1MU=;
        b=DryMIJ6yRK2fF6k5l0OmokMkRQC/of5q2kTTzRP27RYwua7odjz322qUKn90yFwQrJD0Hn
        EJswk+HkqWjNntBw==
To:     Reinette Chatre <reinette.chatre@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: Re: [patch 33/33] irqchip: Add IDXD Interrupt Message Store driver
In-Reply-To: <4a15c569-0545-20ac-e74c-ae17f7eb067d@intel.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135207.141746268@linutronix.de>
 <4a15c569-0545-20ac-e74c-ae17f7eb067d@intel.com>
Date:   Fri, 02 Dec 2022 20:51:45 +0100
Message-ID: <87sfhxoa7i.ffs@tglx>
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

Reinette!

On Fri, Dec 02 2022 at 09:55, Reinette Chatre wrote:
> On 11/11/2022 5:59 AM, Thomas Gleixner wrote:
>> The necessary iobase is stored in the irqdomain and the PASID which is
>> required for operation is handed in via msi_dev_cookie in the allocation
>> function.
>
> The use of PASID is optional for dedicated workqueues. Could this be
> supported to let the irqchip support all scenarios?

Sure. I wrote this thing mostly out of thin air based on some ancient
PoC code. :)

> Since the cookie is always provided I was wondering if an invalid
> PASID can be used to let the driver disable PASID? Please see the
> delta snippet below in which I primarily made such a change, but added
> a few more changes for consideration.

Let me check.

> With the first change I am able to test IMS on the host using devmsi-v2-part3
> of the development branch. I did try to update to the most recent development
> to confirm all is well but version devmsi-v3.1-part3 behaves differently
> in that pci_ims_alloc_irq() returns successfully but the returned
> virq is 0. This triggers a problem when request_threaded_irq() runs and
> reports:
> genirq: Flags mismatch irq 0. 00000000 (idxd-portal) vs. 00015a00 (timer)

Bah. Let me figure out what I fat-fingered there.

> @@ -33,6 +34,8 @@ struct ims_slot {
>  #define CTRL_PASID_ENABLE	BIT(3)
>  /* Position of PASID.LSB in the control word */
>  #define CTRL_PASID_SHIFT	12
> +/* Valid PASID is 20 bits */
> +#define CTRL_PASID_VALID	GENMASK(19, 0)
>  
>  static inline void iowrite32_and_flush(u32 value, void __iomem *addr)
>  {
> @@ -93,12 +96,17 @@ static void idxd_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
>  	/* Mask the interrupt for paranoia sake */
>  	iowrite32_and_flush(CTRL_VECTOR_MASKBIT, &slot->ctrl);
>  
> -	/*
> -	 * The caller provided PASID. Shift it to the proper position
> -	 * and set the PASID enable bit.
> -	 */
> -	desc->data.icookie.value <<= CTRL_PASID_SHIFT;
> -	desc->data.icookie.value |= CTRL_PASID_ENABLE;
> +	if (pasid_valid((ioasid_t)desc->data.icookie.value)) {
> +		/*
> +		 * The caller provided PASID. Shift it to the proper position
> +		 * and set the PASID enable bit.
> +		 */
> +		desc->data.icookie.value &= CTRL_PASID_VALID;
> +		desc->data.icookie.value <<= CTRL_PASID_SHIFT;
> +		desc->data.icookie.value |= CTRL_PASID_ENABLE;
> +	} else {
> +		desc->data.icookie.value = 0;
> +	}

Looks about right. But that needs some sanity measures at the call sites
so that we don't end up with an invalid PASID in cases where a valid
PASID is truly required.

Thanks,

        tglx
