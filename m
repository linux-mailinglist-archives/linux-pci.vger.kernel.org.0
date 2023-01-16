Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C16166C951
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 17:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjAPQsJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 11:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjAPQrb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 11:47:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C6F40BF1;
        Mon, 16 Jan 2023 08:35:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673886917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5aBMbxFAFIdStpWd8PjTw92BwcyzNQZ6KDghf5lWME=;
        b=WcOzXIZhvSGHI4kvKmeXfaaJdxjdle5MVf1vpbxI/AmUPipq+r7qwkITTv//VM9mg2PMc7
        LJyptKIS3yd4uD1y6XgEyOBdnZINhLk4pwbRiAJcb7tXuvov9dJEQxirB+Wi2tCA8f1eIa
        h2cO72zuZ79rBMwZaKUf4/SNsPtLgaWlTBOzrBSUW7ykALM+MBfG/QKRYEG1fzOv6vMTSa
        yJY53J3efC7hTx+lqxx5IvHLGh81f78i2M2JK9nKssO6CgT8pgnSPs0ravGlqLQ+uozKD7
        9S28aL/s/ATwBDcokK0dTbo+ezQyz5JBswbnBs3R4ZIqdf2rLtC9muKIMPPjcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673886917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5aBMbxFAFIdStpWd8PjTw92BwcyzNQZ6KDghf5lWME=;
        b=9t2m2hJfCfUhEd3ewF1n6zPM2zYK0sf7ZNxJnZ3SeXx+vQAZEnM9dxnpLeYBFOWDXJwYSF
        lbgkBHygutn1QsAw==
To:     David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xen.org>
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
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V3 16/22] genirq/msi: Provide new domain id based
 interfaces for freeing interrupts
In-Reply-To: <1901d84f8f999ac6b2f067360f098828cb8c17cf.camel@infradead.org>
References: <20221124225331.464480443@linutronix.de>
 <20221124230314.337844751@linutronix.de>
 <1901d84f8f999ac6b2f067360f098828cb8c17cf.camel@infradead.org>
Date:   Mon, 16 Jan 2023 17:35:16 +0100
Message-ID: <875yd6o2t7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

David!

On Mon, Jan 16 2023 at 09:56, David Woodhouse wrote:
> On Fri, 2022-11-25 at 00:24 +0100, Thomas Gleixner wrote:
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ops->domain_free_irqs)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ops->domain_free_irqs(domain, dev);
>
> Do you want a call to msi_free_dev_descs(dev) here? In the case where
> the core code calls ops->domain_alloc_irqs() it *has* allocated the
> descriptors first... but it's expecting the irqdomain to free them?

No. Let me stare at it.

> However, it's not quite as simple as adding msi_free_dev_descs()...

Correct.

> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 955267bbc2be..812e1ec1a633 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -1533,9 +1533,10 @@ static void msi_domain_free_locked(struct device *=
dev, struct msi_ctrl *ctrl)
>  	info =3D domain->host_data;
>  	ops =3D info->ops;
>=20=20
> -	if (ops->domain_free_irqs)
> +	if (ops->domain_free_irqs) {
>  		ops->domain_free_irqs(domain, dev);
> -	else
> +		msi_free_msi_descs(dev);

This is just wrong. I need to taxi my grandson. Will have a look
afterwards.

Thanks,

        tglx
