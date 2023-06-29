Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A682742F7E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 23:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjF2V2w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 17:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjF2V2u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 17:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0532D66
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 14:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688074078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FtDP1Q6klKq+vrLWjMDjwV4PiAup+z6NgGkS2LHe5Nc=;
        b=PZTgp1u72JCncgcFX/eTvxtFHESsPCn5BpXKRswJhLeuFwx6Zyguovj4j+0/ZvKe4UctNh
        gYmDpsQKkCE8BbwuEEWtRezx27JA0pLsPzVhGeDdpXghi/HaLRLxBQO7JIegFUIBoEEgG0
        xqvojwYfjPLSugHCEBrsnrGijIPRwws=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-rfWufp7NNwKvVc5i2mkdLQ-1; Thu, 29 Jun 2023 17:27:57 -0400
X-MC-Unique: rfWufp7NNwKvVc5i2mkdLQ-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5634c4df8c4so1273127eaf.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 14:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688074077; x=1690666077;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtDP1Q6klKq+vrLWjMDjwV4PiAup+z6NgGkS2LHe5Nc=;
        b=YLGifVQf9lVHynu8OWrpEytJTOypE5CckX8Mn/ejSNv9lyHSJBp1gcbT2q2Y+GheiA
         ujDCpV6ilLVDWGUs1FirRjP94FgMqMfpTfrCd0bNGMg0BtcdEYnduMYLmWQtTKC4ns7p
         h+FueIqy9NN5EYqi0Av56F6BvfwOThugjj9TLq+psTajk9V43MKyizJp/5mWCp7+Mkr0
         jYp7fj4jMa6n+2z+9OLanGrq17IgGBDbpxJW3PwCnlQ1kzAtzS32niAUPkHe9N4zQYGh
         PoupmyrOJIZYlk462FuZoX0p2/6Ptv/zPoST0iD0HrDzi7U5myuW9aGU9ea6qGWnnvwq
         hKEA==
X-Gm-Message-State: ABy/qLb/X9GMwj+fnxIf83hfgHkgEbkyjKRljAzwWy6Fm5AC+tECTUQB
        u8hBt7GkYrg5/4gwPdr0I5iOwbA2hQXybMSj9PuQWGjz6QJ/Gjoabr1Y0kmFHywx248sTWygl+N
        i6taCmX2gMGPXJ/ypqMDb
X-Received: by 2002:a05:6359:a2f:b0:130:afe8:43de with SMTP id el47-20020a0563590a2f00b00130afe843demr693812rwb.30.1688074076885;
        Thu, 29 Jun 2023 14:27:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHzx3h21Xg8/xwK6dkJoKMUGl/nF1n+Ber6+b1C1nTGnByCFSLiEqMI7wHZ3ko1j+NUr89pAw==
X-Received: by 2002:a05:6359:a2f:b0:130:afe8:43de with SMTP id el47-20020a0563590a2f00b00130afe843demr693797rwb.30.1688074076589;
        Thu, 29 Jun 2023 14:27:56 -0700 (PDT)
Received: from thinkpad-p1.localdomain (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id k28-20020a05620a143c00b0075785052e97sm6571404qkj.95.2023.06.29.14.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 14:27:56 -0700 (PDT)
Message-ID: <3a6ce0da4d37ed2ba9673a60062e109503adca78.camel@redhat.com>
Subject: Re: [PATCH 1/1] PCI: dwc: Use regular interrupt instead of chained
From:   Radu Rendec <rrendec@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 29 Jun 2023 17:27:54 -0400
In-Reply-To: <20230629205830.GA447734@bhelgaas>
References: <20230629205830.GA447734@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2023-06-29 at 15:58 -0500, Bjorn Helgaas wrote:
> On Thu, Jun 29, 2023 at 04:42:07PM -0400, Radu Rendec wrote:
> > On Thu, 2023-06-29 at 14:57 -0500, Bjorn Helgaas wrote:
> > > On Thu, Jun 29, 2023 at 02:30:19PM -0400, Radu Rendec wrote:
> > > > The DesignWare PCIe host driver uses a chained interrupt to demulti=
plex
> > > > the downstream MSI interrupts. On Qualcomm SA8540P Ride, enabling b=
oth
> > > > pcie2a and pcie3a at the same time can create an interrupt storm wh=
ere
> > > > the parent interrupt fires continuously, even though reading the PC=
Ie
> > > > host registers doesn't identify any child MSI interrupt source. Thi=
s
> > > > effectively locks up CPU0, which spends all the time servicing thes=
e
> > > > interrupts.
> > > >=20
> > > > This is a clear example of how bypassing the interrupt core by usin=
g
> > > > chained interrupts can be very dangerous if the hardware misbehaves=
.
> > > >=20
> > > > Convert the driver to use a regular interrupt for the demultiplex
> > > > handler. This allows the interrupt storm detector to detect the fau=
lty
> > > > interrupt and disable it, allowing the system to run normally.
> > >=20
> > > There are many other users of irq_set_chained_handler_and_data() in
> > > drivers/pci/controller/.=C2=A0 Should they be similarly converted?=C2=
=A0 If not,
> > > how do we decide which need to use irq_set_chained_handler_and_data()
> > > and which do not?
> >=20
> > According to Thomas Gleixner, yes. Obviously I don't want to put words
> > in his mouth, but I think that's the gist of what he said in a reply to
> > an RFC patch that I sent a few weeks ago:
> > https://lore.kernel.org/all/877csohcll.ffs@tglx/
>=20
> Is it's a bug in pcie-designware-host.c, and it's also a bug in the
> other callers, we should fix them all.

I wouldn't call it a bug, because the driver works as long as the
hardware behaves. But if the hardware misbehaves and generates an
interrupt storm for whatever reason, you end up with an apparently
frozen system and no clue as to what's going on. By contrast, using
regular interrupts allows the interrupt storm detector to kick in. Then
the system works fine, and there's also a useful log message pointing
to that particular interrupt.

> But you do imply that there's some DesignWare hardware issue involved,
> too, so I guess it's possible the other drivers don't have an issue
> and/or actually require the chained IRQs.=C2=A0 That's why I asked how we
> should decide.

That makes sense. I don't know if it's a DesignWare hardware issue or
something else down the PCIe bus. Other folks in my team are
investigating the root cause. This thread has the details:
https://lore.kernel.org/all/pmodcoakbs25z2a7mlo5gpuz63zluh35vbgb5itn6k5aqhj=
nny@jvphbpvahtse/

I want to point out that this patch doesn't *fix* the root problem (the
interrupt storm). It just makes the kernel handle it (much) better if
it occurs.

I can't see why any driver would _require_ chained IRQs. As I see it,
chained interrupts are just a "shortcut" that circumvents the IRQ core
for (debatable) performance reasons. Other than that, they should work
the same as regular interrupts.

There are other benefits associated with using regular interrupts. One
of them is the ability to control the SMP affinity of the parent
interrupt. But that's a different topic.

Radu

> > > > -static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
> > > > +static void __dw_pcie_free_msi(struct dw_pcie_rp *pp, u32 num_ctrl=
s)
> > > > =C2=A0{
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 ctrl;
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (ctrl =3D 0; ctrl < =
MAX_MSI_CTRLS; ctrl++) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (ctrl =3D 0; ctrl < =
num_ctrls; ctrl++) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pp->msi_irq[ctrl] > 0)
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq=
_set_chained_handler_and_data(pp->msi_irq[ctrl],
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fre=
e_irq(pp->msi_irq[ctrl], pp);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq_domain_remove(p=
p->msi_domain);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq_domain_remove(p=
p->irq_domain);
> > > > =C2=A0}
> > > > =C2=A0
> > > > +#define dw_pcie_free_msi(pp) __dw_pcie_free_msi(pp, MAX_MSI_CTRLS)
> > >=20
> > > What is the benefit of the dw_pcie_free_msi() macro?
> >=20
> > It allows me to add the num_ctrls parameter to the corresponding
> > function (now renamed to __dw_pcie_free_msi()) without forcing all the
> > existing call sites to send MAX_MSI_CTRLS explicitly.
> >=20
> > I needed that extra parameter to avoid duplicating the tear down code
> > on the (new) error path in dw_pcie_msi_init() - see below.
> >=20
> > > > =C2=A0static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
> > > > =C2=A0{
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dw_pcie *pci=
 =3D to_dw_pcie_from_pp(pp);
> > > > @@ -361,9 +353,16 @@ static int dw_pcie_msi_host_init(struct dw_pci=
e_rp *pp)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (ctrl =3D 0; ct=
rl < num_ctrls; ctrl++) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (pp->msi_irq[ctrl] > 0)
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq=
_set_chained_handler_and_data(pp->msi_irq[ctrl],
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 dw_chained_msi_isr, pp);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (pp->msi_irq[ctrl] > 0) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
 =3D request_irq(pp->msi_irq[ctrl], dw_pcie_msi_isr, 0,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(dev), pp);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
(ret) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(dev, "Failed to reques=
t irq %d: %d\n",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0pp->msi_irq[ctrl], ret);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__dw_pcie_free_msi(pp, ctrl);
> >=20
> > This is where I'm using the extra parameter. If we fail to request an
> > interrupt, we need to free all the other interrupts that we have
> > requested so far, to leave everything in a clean state. But we can't
> > use MAX_MSI_CTRLS with __dw_pcie_free_msi() and rely on the check there
> > because there may be extra interrupts that we haven't requested *yet*
> > and we would attempt to free them.
>=20
> Makes sense, thanks.
>=20
> Bjorn
>=20

