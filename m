Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD62775231
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 07:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjHIF1u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 01:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjHIF1s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 01:27:48 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E811BFA
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 22:27:46 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EE9EA44494
        for <linux-pci@vger.kernel.org>; Wed,  9 Aug 2023 05:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691558865;
        bh=peTqRYjSDavpbcFsnXWNHqx4GHBTnLZGnwi7ZOE5E/E=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pJzcoQ/PbtpMORrPORSDvrisYTtCaXaYLPr5e0X7iiehN5ABj18oTTieOSyek8QHM
         P0BdkRk+zvcsr+wx0zFVyVGxe1szLXjHUUU60hs9XFf6ylfoGz/EfFzPJjITb1NY3h
         v/pWNx1pc+5zgxirf2u1l9ICEjqf3X9ljd/u28tRKg+L/lV+BFZb8Xcb+luYKxiC2y
         OVfNlBiAqLvSPpl4fEPWW8oxSmKWRwXQ7EmUQzxXAx78ERN9WKew+KErqmcflBrGCp
         m6nNHvLJ3px6CDoZPyDKr7lPVQ6UjkeeoiVB7ZBH5TZriJg0KcBuP+o/J1MYFw3a+r
         gntz5oMpEvF1g==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-40fefde5a99so74641101cf.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Aug 2023 22:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691558863; x=1692163663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peTqRYjSDavpbcFsnXWNHqx4GHBTnLZGnwi7ZOE5E/E=;
        b=YdjIOr2hgWCXSrK77F+vYl7GQfsCsgI4XBtH/1exGHawpEKJJctj/NPMneunqmUMEB
         09rq//VUvmw9dGAQLhLBxHtJmIz68yLber+3wUSBVW62aiHoGOKLB4XPIWyauqM29Ziv
         d7lpmj1dcObTe4epq1dtCN+U/BhN0h0z9QWGHK+4OJ5ZO0AJLLm9gm+bRxrrgXCqonHg
         jotSiTeaxnXBSI0yYfaJqFbc0BPlSlTzSBdvsxQjEim5jZtBrMtfNca/tCcuFVttjGXc
         TEBa5XAUXxGgGrpsOVQwdU7DaBNaDiLmUqgC1Sedd0IX+014LQgqFnq42fob7mPM4EjQ
         gqIQ==
X-Gm-Message-State: AOJu0YxKin9+uoRYmPaeGgwSCygriNEnW35b9i0xVIChNSK3X3z8o4LX
        RzVIUinLXNkkeuw7+NsCtk1XTDZH1QlxGTjTnyo3pyLhdfLPJKLdT7ju4m71CUhU1bnUhBfTeN+
        00ohCG3a9F6ntOwwMfYycOSCCb3PV8LOdTxw4UkvPn0fTlrj4VPimLf1fXHd0jsO5
X-Received: by 2002:a05:622a:11c1:b0:3fb:42cb:aa9 with SMTP id n1-20020a05622a11c100b003fb42cb0aa9mr2718322qtk.45.1691558863718;
        Tue, 08 Aug 2023 22:27:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9g/gnVBCzUhuSlDB+/aiLzLLlM41Q7Jkfkb1MkwSdlek2Jh+LrgosRiAQ7l1kU79JzGuecMBwAu2knwmTAj8=
X-Received: by 2002:a05:622a:11c1:b0:3fb:42cb:aa9 with SMTP id
 n1-20020a05622a11c100b003fb42cb0aa9mr2718308qtk.45.1691558863469; Tue, 08 Aug
 2023 22:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230512000014.118942-2-kai.heng.feng@canonical.com>
 <20230718111702.GA354713@bhelgaas> <CAAd53p7RfVcZjw+ShtkTmhCAA4zpegRZOzwiXgmanthx_KMjxA@mail.gmail.com>
In-Reply-To: <CAAd53p7RfVcZjw+ShtkTmhCAA4zpegRZOzwiXgmanthx_KMjxA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 9 Aug 2023 13:27:31 +0800
Message-ID: <CAAd53p5WkzydfLAkMa6Dgt5vS0w5FHATfoDj3f=YkK-hPgJ+vQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] PCI/AER: Disable AER interrupt on suspend
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linuxppc-dev@lists.ozlabs.org,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, koba.ko@canonical.com,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org,
        mika.westerberg@linux.intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 11:58=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Tue, Jul 18, 2023 at 7:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org=
> wrote:
> >
> > [+cc Rafael]
> >
> > On Fri, May 12, 2023 at 08:00:13AM +0800, Kai-Heng Feng wrote:
> > > PCIe services that share an IRQ with PME, such as AER or DPC, may cau=
se a
> > > spurious wakeup on system suspend. To prevent this, disable the AER i=
nterrupt
> > > notification during the system suspend process.
> >
> > I see that in this particular BZ dmesg log, PME, AER, and DPC do share
> > the same IRQ, but I don't think this is true in general.
> >
> > Root Ports usually use MSI or MSI-X.  PME and hotplug events use the
> > Interrupt Message Number in the PCIe Capability, but AER uses the one
> > in the AER Root Error Status register, and DPC uses the one in the DPC
> > Capability register.  Those potentially correspond to three distinct
> > MSI/MSI-X vectors.
> >
> > I think this probably has nothing to do with the IRQ being *shared*,
> > but just that putting the downstream component into D3cold, where the
> > link state is L3, may cause the upstream component to log and signal a
> > link-related error as the link goes completely down.
>
> That's quite likely a better explanation than my wording.
> Assuming AER IRQ and PME IRQ are not shared, does system get woken up
> by AER IRQ?
>
> >
> > I don't think D0-D3hot should be relevant here because in all those
> > states, the link should be active because the downstream config space
> > remains accessible.  So I'm not sure if it's possible, but I wonder if
> > there's a more targeted place we could do this, e.g., in the path that
> > puts downstream devices in D3cold.
>
> Let me try to work on this.

We are seeing another case where the issue happens on D3hot [0].
So I wonder if it's possible to disable AER unconditionally?

[0] https://bugzilla.kernel.org/show_bug.cgi?id=3D216295#c3

>
> Kai-Heng
>
> >
> > > As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power Mana=
gement",
> > > TLP and DLLP transmission are disabled for a Link in L2/L3 Ready (D3h=
ot), L2
> > > (D3cold with aux power) and L3 (D3cold) states. So disabling the AER
> > > notification during suspend and re-enabling them during the resume pr=
ocess
> > > should not affect the basic functionality.
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > > v6:
> > > v5:
> > >  - Wording.
> > >
> > > v4:
> > > v3:
> > >  - No change.
> > >
> > > v2:
> > >  - Only disable AER IRQ.
> > >  - No more check on PME IRQ#.
> > >  - Use helper.
> > >
> > >  drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index 1420e1f27105..9c07fdbeb52d 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -1356,6 +1356,26 @@ static int aer_probe(struct pcie_device *dev)
> > >       return 0;
> > >  }
> > >
> > > +static int aer_suspend(struct pcie_device *dev)
> > > +{
> > > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > > +     struct pci_dev *pdev =3D rpc->rpd;
> > > +
> > > +     aer_disable_irq(pdev);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int aer_resume(struct pcie_device *dev)
> > > +{
> > > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > > +     struct pci_dev *pdev =3D rpc->rpd;
> > > +
> > > +     aer_enable_irq(pdev);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  /**
> > >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> > >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > > @@ -1420,6 +1440,8 @@ static struct pcie_port_service_driver aerdrive=
r =3D {
> > >       .service        =3D PCIE_PORT_SERVICE_AER,
> > >
> > >       .probe          =3D aer_probe,
> > > +     .suspend        =3D aer_suspend,
> > > +     .resume         =3D aer_resume,
> > >       .remove         =3D aer_remove,
> > >  };
> > >
> > > --
> > > 2.34.1
> > >
