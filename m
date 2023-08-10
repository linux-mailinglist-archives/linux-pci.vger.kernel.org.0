Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709EC7772A4
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 10:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjHJIRh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 04:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjHJIRh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 04:17:37 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30651ED
        for <linux-pci@vger.kernel.org>; Thu, 10 Aug 2023 01:17:36 -0700 (PDT)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A1655420B6
        for <linux-pci@vger.kernel.org>; Thu, 10 Aug 2023 08:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691655454;
        bh=f44e7D2QBwHFCwYMmxTx3K25qEi/6ZVWNBK4zCCggRI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ISfInLCmjQRfipfxqPCkq5hMFd9TNwooXJT2iedM4ceU3jDWVcxHoFojj6BRQIfZ7
         dV1zACTooLJaH55Ji9zRWS7iC7McoNBejBwpm4uLsvnGuSNttv8XuUbav5UqYvHe/I
         E+A87SGPWLYMwRM6fW+vWvycs8Jwvcg3Y8hFdaxFTY4EWc/Lfvr03H5lTcV+HEPTAQ
         3Uoj3EnYSlYvn2rV+EIhiGz7ZF6V3YHAq8FWICA/z9ehk8QTojOKjRWommuRg9g/n5
         hkDBJ8R823uSrlM5iollAidfM5rKo8Hw4uLRS5X4UbWe9NW/RCl3RLbMtXrcdcL8mj
         G6DzesLkbj4Ww==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26957018988so759526a91.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Aug 2023 01:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655453; x=1692260253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f44e7D2QBwHFCwYMmxTx3K25qEi/6ZVWNBK4zCCggRI=;
        b=K9EXD/sfCqJv9C/j2RfgKAFAzuZY7kqZM3KLzst2g/6x3Pf18K3mcSd8ye46rdfgDv
         Cwgw+RKYI7Q27vgJszxCT0pC/JhVRMC6V+iZ0CxGAvP/KgFIdgT/u0p/lqcz7mIRmPmI
         TQHdTa/qtrXZyTE/PBZeHIoAInGmltzUGf2DxhV8BEV2iAf89ZZy6NObGzG75f2UqU6y
         7xb3rX3gpNqqFeNrBrr4K5TDy86F529aD9v9LjZWk/TEIB0oKiY2seAASXzxGAHhoJOp
         ZbKjnH3Ae3o6aRM7SLqbOdWbYAoi3+hYp6Me66o1N5BxOCdJ5BZEUvLAclTOhRM0dNtL
         yfHA==
X-Gm-Message-State: AOJu0Yyjkp41LnJT9rytDKw57qskLhA1mm7AQaUZVtiDGnmYpxsumj7r
        UqHxpGbkdTwmZN/8nNzSiNtUlvM/Jq7ZMtQAfXzWotFOVv/63GbUl0p17E+i/2n4mk6x73Rlhe8
        T0G8vjB7REEuShM+K8b6g6rNpk+V9u8ZgbWOyMtsQzUVDFOIL1CMwWA==
X-Received: by 2002:a17:90b:4c09:b0:268:81c6:a01f with SMTP id na9-20020a17090b4c0900b0026881c6a01fmr1288517pjb.26.1691655453208;
        Thu, 10 Aug 2023 01:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElxY6iFsqxsLQaf6MEu/kiqWUUF1OuNBubJ3kjGr8Y/2zOMpSfHDBWZaiq094IGcEaQ3UBkRcs6NrBzaytr9g=
X-Received: by 2002:a17:90b:4c09:b0:268:81c6:a01f with SMTP id
 na9-20020a17090b4c0900b0026881c6a01fmr1288502pjb.26.1691655452859; Thu, 10
 Aug 2023 01:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p7RfVcZjw+ShtkTmhCAA4zpegRZOzwiXgmanthx_KMjxA@mail.gmail.com>
 <20230809185232.GA402997@bhelgaas>
In-Reply-To: <20230809185232.GA402997@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 10 Aug 2023 16:17:21 +0800
Message-ID: <CAAd53p5QhaCA09G0BrhyDBXTKBbcgpXq0yAsj7PkG6wF8Qr=_w@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] PCI/AER: Disable AER interrupt on suspend
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com,
        mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, koba.ko@canonical.com,
        "Oliver O'Halloran" <oohall@gmail.com>, bhelgaas@google.com,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 10, 2023 at 2:52=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jul 21, 2023 at 11:58:24AM +0800, Kai-Heng Feng wrote:
> > On Tue, Jul 18, 2023 at 7:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Fri, May 12, 2023 at 08:00:13AM +0800, Kai-Heng Feng wrote:
> > > > PCIe services that share an IRQ with PME, such as AER or DPC,
> > > > may cause a spurious wakeup on system suspend. To prevent this,
> > > > disable the AER interrupt notification during the system suspend
> > > > process.
> > >
> > > I see that in this particular BZ dmesg log, PME, AER, and DPC do shar=
e
> > > the same IRQ, but I don't think this is true in general.
> > >
> > > Root Ports usually use MSI or MSI-X.  PME and hotplug events use the
> > > Interrupt Message Number in the PCIe Capability, but AER uses the one
> > > in the AER Root Error Status register, and DPC uses the one in the DP=
C
> > > Capability register.  Those potentially correspond to three distinct
> > > MSI/MSI-X vectors.
> > >
> > > I think this probably has nothing to do with the IRQ being *shared*,
> > > but just that putting the downstream component into D3cold, where the
> > > link state is L3, may cause the upstream component to log and signal =
a
> > > link-related error as the link goes completely down.
> >
> > That's quite likely a better explanation than my wording.
> > Assuming AER IRQ and PME IRQ are not shared, does system get woken up
> > by AER IRQ?
>
> Rafael could answer this better than I can, but
> Documentation/power/suspend-and-interrupts.rst says device interrupts
> are generally disabled during suspend after the "late" phase of
> suspending devices, i.e.,
>
>   dpm_suspend_noirq
>     suspend_device_irqs           <-- disable non-wakeup IRQs
>     dpm_noirq_suspend_devices
>       ...
>         pci_pm_suspend_noirq      # (I assume)
>           pci_prepare_to_sleep
>
> I think the downstream component would be put in D3cold by
> pci_prepare_to_sleep(), so non-wakeup interrupts should be disabled by
> then.
>
> I assume PME would generally *not* be disabled since it's needed for
> wakeup, so I think any interrupt that shares the PME IRQ and occurs
> during suspend may cause a spurious wakeup.

Yes, that's the case here.

>
> If so, it's exactly as you said at the beginning: AER/DPC/etc sharing
> the PME IRQ may cause spurious wakeups, and we would have to disable
> those other interrupts at the source, e.g., by clearing
> PCI_ERR_ROOT_CMD_FATAL_EN etc (exactly as your series does).

So is the series good to be merged now?

Kai-Heng

>
> > > I don't think D0-D3hot should be relevant here because in all those
> > > states, the link should be active because the downstream config space
> > > remains accessible.  So I'm not sure if it's possible, but I wonder i=
f
> > > there's a more targeted place we could do this, e.g., in the path tha=
t
> > > puts downstream devices in D3cold.
> >
> > Let me try to work on this.
> >
> > Kai-Heng
> >
> > >
> > > > As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power Ma=
nagement",
> > > > TLP and DLLP transmission are disabled for a Link in L2/L3 Ready (D=
3hot), L2
> > > > (D3cold with aux power) and L3 (D3cold) states. So disabling the AE=
R
> > > > notification during suspend and re-enabling them during the resume =
process
> > > > should not affect the basic functionality.
> > > >
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > > v6:
> > > > v5:
> > > >  - Wording.
> > > >
> > > > v4:
> > > > v3:
> > > >  - No change.
> > > >
> > > > v2:
> > > >  - Only disable AER IRQ.
> > > >  - No more check on PME IRQ#.
> > > >  - Use helper.
> > > >
> > > >  drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > > index 1420e1f27105..9c07fdbeb52d 100644
> > > > --- a/drivers/pci/pcie/aer.c
> > > > +++ b/drivers/pci/pcie/aer.c
> > > > @@ -1356,6 +1356,26 @@ static int aer_probe(struct pcie_device *dev=
)
> > > >       return 0;
> > > >  }
> > > >
> > > > +static int aer_suspend(struct pcie_device *dev)
> > > > +{
> > > > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > > > +     struct pci_dev *pdev =3D rpc->rpd;
> > > > +
> > > > +     aer_disable_irq(pdev);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int aer_resume(struct pcie_device *dev)
> > > > +{
> > > > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > > > +     struct pci_dev *pdev =3D rpc->rpd;
> > > > +
> > > > +     aer_enable_irq(pdev);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  /**
> > > >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> > > >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > > > @@ -1420,6 +1440,8 @@ static struct pcie_port_service_driver aerdri=
ver =3D {
> > > >       .service        =3D PCIE_PORT_SERVICE_AER,
> > > >
> > > >       .probe          =3D aer_probe,
> > > > +     .suspend        =3D aer_suspend,
> > > > +     .resume         =3D aer_resume,
> > > >       .remove         =3D aer_remove,
> > > >  };
> > > >
> > > > --
> > > > 2.34.1
> > > >
