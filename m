Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70306A8450
	for <lists+linux-pci@lfdr.de>; Thu,  2 Mar 2023 15:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjCBOn1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Mar 2023 09:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCBOn1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Mar 2023 09:43:27 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE442CC76;
        Thu,  2 Mar 2023 06:43:24 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AC5B0FF804;
        Thu,  2 Mar 2023 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677768203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBEu4313wvc8JjbyIn5rJNCdAk7pwRKJxkVhQRUIhS0=;
        b=QcPI/XpDPw9RvoeywOApGHiUk+wYKTcQ3R73FbwKdbHd8k/oXBtODScU15QU/vDDOi8veX
        zKuF/Bi4l2/DhzDCDkcIywYwR1gzgr7H/WIqIBoXzbebGS3DFzL5PpnQCtha/eB+orUiN5
        P858d/Srqivw0A/DfBsQI+zjUNWCnS4n4Bih80v0JQA4r9hMQW1R7TteSMUrDXQ8y8ksds
        vPAAsinr7ZQw8Lzd4zcu1ITIArpH6XufhIMehX6cNRUqyyNA/kvWfuPYdnYtWy3/5uyiTW
        mPdG0h0VCQdJyT1+PF5mGIHpFfoI3YORcdi0523gSFmJ+Bry8ZDa0Mk0xxQxXw==
Date:   Thu, 2 Mar 2023 15:43:18 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <20230302154318.380c6cff@xps-13>
In-Reply-To: <87mt4wkwnv.ffs@tglx>
References: <20221111120501.026511281@linutronix.de>
        <20221111122013.888850936@linutronix.de>
        <20230301115530.5ccea5ae@xps-13>
        <87mt4wkwnv.ffs@tglx>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

tglx@linutronix.de wrote on Wed, 01 Mar 2023 22:07:48 +0100:

> Miquel!
>=20
> On Wed, Mar 01 2023 at 11:55, Miquel Raynal wrote:
> > tglx@linutronix.de wrote on Fri, 11 Nov 2022 14:54:22 +0100 (CET):
> > =20
> >> When a range of descriptors is freed then all of them are not associat=
ed to
> >> a linux interrupt. Remove the filter and add a warning to the free fun=
ction.
> >> +		/* Leak the descriptor when it is still referenced */
> >> +		if (WARN_ON_ONCE(msi_desc_match(desc, MSI_DESC_ASSOCIATED)))
> >> +			continue;
> >> +		msi_free_desc(desc);
> >>  	}
> >>  } =20
> >
> > It looks like since this commit I am getting warnings upon EPROBE_DEFER
> > errors in the mvpp2 Marvell Ethernet driver. I looked a bit at the
> > internals to understand why this warning was shown, and it seems that
> > nothing "de-references" the descriptors, which would mean here:
> > resetting desc->irq to 0. =20
>=20
> Correct. This platform-msi ^(*&!@&^ hack really needs to die ASAP.

:-)

> Marc, where are we on that? Is this still in limbo?
>=20
> > I am wondering how useful thisd WARN_ON() is, or otherwise where the =20
>=20
> It is useful as it caught bugs already.

Sure.

> > desc->irq entry should be zeroed (if I understand that correctly), any
> > help will be appreciated. =20
>=20
> Untested workaround below.

Excellent!

> I hate it with a passion, but *shrug*.

:'D

> Thanks,
>=20
>         tglx
> ---
>  drivers/base/platform-msi.c |    1 +
>  include/linux/msi.h         |    2 ++
>  kernel/irq/msi.c            |   23 ++++++++++++++++++++++-
>  3 files changed, 25 insertions(+), 1 deletion(-)

Kudos for the diff, which indeed works perfectly in my case. I guess
you'll make a proper patch soon, if that's the case you can add my:

Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>

Let me know otherwise.

Thanks a lot for the very quick fix!
Miqu=C3=A8l

> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -324,6 +324,7 @@ void platform_msi_device_domain_free(str
>  	struct platform_msi_priv_data *data =3D domain->host_data;
> =20
>  	msi_lock_descs(data->dev);
> +	msi_domain_depopulate_descs(data->dev, virq, nr_irqs);
>  	irq_domain_free_irqs_common(domain, virq, nr_irqs);
>  	msi_free_msi_descs_range(data->dev, virq, virq + nr_irqs - 1);
>  	msi_unlock_descs(data->dev);
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -631,6 +631,8 @@ int msi_domain_prepare_irqs(struct irq_d
>  			    int nvec, msi_alloc_info_t *args);
>  int msi_domain_populate_irqs(struct irq_domain *domain, struct device *d=
ev,
>  			     int virq, int nvec, msi_alloc_info_t *args);
> +void msi_domain_depopulate_descs(struct device *dev, int virq, int nvec);
> +
>  struct irq_domain *
>  __platform_msi_create_device_domain(struct device *dev,
>  				    unsigned int nvec,
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -1109,14 +1109,35 @@ int msi_domain_populate_irqs(struct irq_
>  	return 0;
> =20
>  fail:
> -	for (--virq; virq >=3D virq_base; virq--)
> +	for (--virq; virq >=3D virq_base; virq--) {
> +		msi_domain_depopulate_descs(dev, virq, 1);
>  		irq_domain_free_irqs_common(domain, virq, 1);
> +	}
>  	msi_domain_free_descs(dev, &ctrl);
>  unlock:
>  	msi_unlock_descs(dev);
>  	return ret;
>  }
> =20
> +void msi_domain_depopulate_descs(struct device *dev, int virq_base, int =
nvec)
> +{
> +	struct msi_ctrl ctrl =3D {
> +		.domid	=3D MSI_DEFAULT_DOMAIN,
> +		.first  =3D virq_base,
> +		.last	=3D virq_base + nvec - 1,
> +	};
> +	struct msi_desc *desc;
> +	struct xarray *xa;
> +	unsigned long idx;
> +
> +	if (!msi_ctrl_valid(dev, &ctrl))
> +		return;
> +
> +	xa =3D &dev->msi.data->__domains[ctrl.domid].store;
> +	xa_for_each_range(xa, idx, desc, ctrl.first, ctrl.last)
> +		desc->irq =3D 0;
> +}
> +
>  /*
>   * Carefully check whether the device can use reservation mode. If
>   * reservation mode is enabled then the early activation will assign a
