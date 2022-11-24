Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DEB637D61
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 16:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKXPzW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 10:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKXPzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 10:55:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B404F16E8D8;
        Thu, 24 Nov 2022 07:55:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669305319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oW1vFoGkG1gZqHKm6cJJxeAutc3pzwTc7EeCCgEOa6U=;
        b=0STs4hhjniVU1gnUtiCn2+QbL9DvDE6kplZCXTj4CQQPcUinLqK2Z5vDrQreia+8ijFfLR
        e4mKYpcJSGAfu8auOR5DLm/uttM+VvKD+6er6Nka6+O1fDe6kwyhxHC2Vz+GoFC5amNLG9
        XZCyv8KeAIR0t3UrVu+0zDh8gfZvPkSKC5Drq/qfJ/j3fp1KvUWLrWdaC7gPQyei2L9S9W
        LfrNLxpO45JAHHhQS4jRef1P16FsdBY3PWvnM+E/0mpxhnKtaVIcXjGX2kFRUb7adg6GEl
        JjwXPKT1VphSef6tbprMD8+AX7/4zwhTXOGd9Z7AjjokyC6bMZvXR7TkvlURlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669305319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oW1vFoGkG1gZqHKm6cJJxeAutc3pzwTc7EeCCgEOa6U=;
        b=4Rss4EqtqqINndCFCf02V6OverlUL7auZMseRap9WhFAA1bfi3K6qgHJwtdqUBMXD5cybT
        KimBj3JaMip9fTCw==
To:     Marc Zyngier <maz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V2 09/21] genirq/msi: Make MSI descriptor iterators
 device domain aware
In-Reply-To: <86r0xsmk3o.wl-maz@kernel.org>
References: <20221121083210.309161925@linutronix.de>
 <20221121083326.002153609@linutronix.de> <86r0xsmk3o.wl-maz@kernel.org>
Date:   Thu, 24 Nov 2022 16:55:17 +0100
Message-ID: <87zgcgbb4q.ffs@tglx>
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

On Thu, Nov 24 2022 at 15:46, Marc Zyngier wrote:
> On Mon, 21 Nov 2022 14:36:29 +0000,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> +static int msi_get_domain_base_index(struct device *dev, unsigned int domid)
>> +{
>> +	lockdep_assert_held(&dev->msi.data->mutex);
>> +
>> +	if (WARN_ON_ONCE(domid >= MSI_MAX_DEVICE_IRQDOMAINS))
>> +		return -ENODEV;
>> +
>> +	if (WARN_ON_ONCE(!dev->msi.data->__irqdomains[domid]))
>> +		return -ENODEV;
>> +
>> +	return domid * MSI_XA_DOMAIN_SIZE;
>> +}
>
> So what I understand of this is that we split the index space into
> segments, one per msi_domain_ids, MSI_XA_DOMAIN_SIZE apart.
>
> Why didn't you decide to go all the way and have one xarray per
> irqdomain? It's not that big a structure, and it would make the whole
> thing a bit more straightforward.
>
> Or do you anticipate cases where you'd walk the __store xarray across
> irqdomains?

Not really. I just found it conveniant to deal with one, but yes we
could do the same thing with two xarrays.

But at the very end it does not make a huge difference. Fine with me
either way.

Thanks,

        tglx
