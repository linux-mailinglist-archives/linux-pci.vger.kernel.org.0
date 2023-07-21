Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9475275BD03
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 05:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjGUD6n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 23:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUD6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 23:58:40 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0011982
        for <linux-pci@vger.kernel.org>; Thu, 20 Jul 2023 20:58:38 -0700 (PDT)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EB1E63F438
        for <linux-pci@vger.kernel.org>; Fri, 21 Jul 2023 03:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689911916;
        bh=GocbvuUn/KKhNIVDE/WECAklLWGIdwfJnkvuB2CSoho=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=nVfV0ygjWpz+VuFmiRRcjnYNGBmft2vYvurktFE57Xn/ixGvCwrVsTZikp6Mfq6NO
         JQRZcgA1akFBLqqJQz0aP3EZ/qPQsxScT6z9jkEme+f/y/h1OMqYw1/G/GxMLwWyWn
         sNfOSgmdj+PwEyygekZPUNiOe+M7RhlJFRRuxGWR0JuJtduDiNT+MygiXcR6kurJ/B
         WTpwvfyLSMxMGLd3bgTANjpZ64hXzifh4AaETGb9TpixQSO/SLN7uMY1nW//5fnqes
         eCSmSpU/g8aeF9D5h8aC/lyrX9khwMJE5EoKMG7BxnA8VuotzsM68LeDyaQy5szCEf
         WI1Bmz8hJWJ1A==
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-765de3a3404so223256485a.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Jul 2023 20:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689911916; x=1690516716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GocbvuUn/KKhNIVDE/WECAklLWGIdwfJnkvuB2CSoho=;
        b=Foo4FNkF3xisu04c5ymexcRiISley4rF7UaZhEu4sqpt2nXBZpk2HfMBaSQ51/roJ+
         rQK4dLsa5OHMcx8aDUaJ7UYefpjAS9rhMhVwK8UwSPoVN6sx0Kkmm1nnsW+BHo8ByVwj
         usKKlHf49PvJhyjwHKm5eW8sPu+D3Oa4q//uwYwlFUezyEId3A3/lLzlPqsHCyvITEmX
         w0nR5n6nx9is6J5fKtK4pTSWWKD80jNnZ3JivwSj6kgsJU0ttQcR4FFn3hkIrxtR2llp
         4Wjsdh7BMkSThOo5XglcbgvJTGOY4NpmwryD++bwe1r7DUCrgW+kSyauTcLCDrdriIIo
         xQvQ==
X-Gm-Message-State: ABy/qLZlf3es5dQzV4fwQCE4qHPr85pPRNag9Eyfmx2vZn7/jvZyYJmm
        5M1o8YNhJWtvXZk6pc9ONvAiflR736DpyKMYAQQG5r/dpFUSaJIwsExUJ0rnAxdivSFzXl0CjGX
        5ADnTclgN36bV36g2h4fpKoCJ+mFTtFwJuyL+MLCbC2HMaw0+sp4k6w==
X-Received: by 2002:a05:620a:370f:b0:767:dd27:f91f with SMTP id de15-20020a05620a370f00b00767dd27f91fmr765499qkb.4.1689911915907;
        Thu, 20 Jul 2023 20:58:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHmRFr03QlbL90E1otFhV26tkDlQsoNE4/JIlUqeXJCA0CvGSuI6Y+qq5Ho+bsJ4Ch2FLZSeBw/KgODSH31WSs=
X-Received: by 2002:a05:620a:370f:b0:767:dd27:f91f with SMTP id
 de15-20020a05620a370f00b00767dd27f91fmr765485qkb.4.1689911915640; Thu, 20 Jul
 2023 20:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230512000014.118942-2-kai.heng.feng@canonical.com> <20230718111702.GA354713@bhelgaas>
In-Reply-To: <20230718111702.GA354713@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Jul 2023 11:58:24 +0800
Message-ID: <CAAd53p7RfVcZjw+ShtkTmhCAA4zpegRZOzwiXgmanthx_KMjxA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 18, 2023 at 7:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc Rafael]
>
> On Fri, May 12, 2023 at 08:00:13AM +0800, Kai-Heng Feng wrote:
> > PCIe services that share an IRQ with PME, such as AER or DPC, may cause=
 a
> > spurious wakeup on system suspend. To prevent this, disable the AER int=
errupt
> > notification during the system suspend process.
>
> I see that in this particular BZ dmesg log, PME, AER, and DPC do share
> the same IRQ, but I don't think this is true in general.
>
> Root Ports usually use MSI or MSI-X.  PME and hotplug events use the
> Interrupt Message Number in the PCIe Capability, but AER uses the one
> in the AER Root Error Status register, and DPC uses the one in the DPC
> Capability register.  Those potentially correspond to three distinct
> MSI/MSI-X vectors.
>
> I think this probably has nothing to do with the IRQ being *shared*,
> but just that putting the downstream component into D3cold, where the
> link state is L3, may cause the upstream component to log and signal a
> link-related error as the link goes completely down.

That's quite likely a better explanation than my wording.
Assuming AER IRQ and PME IRQ are not shared, does system get woken up
by AER IRQ?

>
> I don't think D0-D3hot should be relevant here because in all those
> states, the link should be active because the downstream config space
> remains accessible.  So I'm not sure if it's possible, but I wonder if
> there's a more targeted place we could do this, e.g., in the path that
> puts downstream devices in D3cold.

Let me try to work on this.

Kai-Heng

>
> > As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power Manage=
ment",
> > TLP and DLLP transmission are disabled for a Link in L2/L3 Ready (D3hot=
), L2
> > (D3cold with aux power) and L3 (D3cold) states. So disabling the AER
> > notification during suspend and re-enabling them during the resume proc=
ess
> > should not affect the basic functionality.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v6:
> > v5:
> >  - Wording.
> >
> > v4:
> > v3:
> >  - No change.
> >
> > v2:
> >  - Only disable AER IRQ.
> >  - No more check on PME IRQ#.
> >  - Use helper.
> >
> >  drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 1420e1f27105..9c07fdbeb52d 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1356,6 +1356,26 @@ static int aer_probe(struct pcie_device *dev)
> >       return 0;
> >  }
> >
> > +static int aer_suspend(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     aer_disable_irq(pdev);
> > +
> > +     return 0;
> > +}
> > +
> > +static int aer_resume(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     aer_enable_irq(pdev);
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > @@ -1420,6 +1440,8 @@ static struct pcie_port_service_driver aerdriver =
=3D {
> >       .service        =3D PCIE_PORT_SERVICE_AER,
> >
> >       .probe          =3D aer_probe,
> > +     .suspend        =3D aer_suspend,
> > +     .resume         =3D aer_resume,
> >       .remove         =3D aer_remove,
> >  };
> >
> > --
> > 2.34.1
> >
