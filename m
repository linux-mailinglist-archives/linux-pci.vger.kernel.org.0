Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD446FF1D0
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 14:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbjEKMtQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 08:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbjEKMtP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 08:49:15 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDFB5B97
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 05:49:14 -0700 (PDT)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 754BC3F4E3
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 12:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683809353;
        bh=ol2Z7aMVfchGYQa9rHq5vwmYfVHXB9l1MkpDsHEuF7g=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=r13QcGAeC562TeVQOAnzogr1HvayvxEEL53xsUYsPHjk1KuhNOaqfqccOW95hIXm+
         Ha1Pu1NX4xQ5Ya/DvGWFEoab76xvXvyFP548zzjYp1uwUKBBrdrVUo9aJ2lqY+z0t5
         jDqTVmzbnZkX6PRuNGmcFHP9LidjUDnyFC7GVMUuAzrp18TrgO2+lGF5Cu3+kCzvFX
         Md/Hxy/5ziw+wOWMik4QvtnaeynF7GtCBMMfki9Ue56/GWeoaXhvAGeWU+87NMmUUa
         WAK5rkLa4+hkLTzbsu+c7XT+6ATlK5Bm94ojmq10h3MXsUL5omDqPv3i6rLyPXgT73
         ao8oKZLLSEpCg==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-52855ba7539so4536038a12.3
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 05:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683809351; x=1686401351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol2Z7aMVfchGYQa9rHq5vwmYfVHXB9l1MkpDsHEuF7g=;
        b=a+yygyNrWZ2xoO+lBauEFXW9AghgkdGAAuTdNnx79cUzvTTnzP4fc1KJ3DiBzkPATK
         r/feBxxNQoPcen/Vj6AwoS77Lyyfs9s9wJt759Mqg7HTrNOXaNlSG0W+IA53YQ8rM2C0
         euKQUIe82v5HB7/JIuU2TJNTMDJCalE81GuBOXqKg6MXwxBNMpnJRVGmX/zRiQayZlUJ
         gJv4JWnY5VgK1Wo0Vcy1yGHYqGHFypv/2M7ggw1XsrySrSgAUqtiY4N+XoU7kA1xrk1f
         rENl1LGFk38E+YxY+VD/HIhpSx14tmeWwotilolzqTUeIicMPJdcBuNSrP+W+oS+Q+YA
         7m4A==
X-Gm-Message-State: AC+VfDzanl2HpIlFP85W60w9nsIO29boLFnOHvkAXsY2ZuuMelmE7Z0F
        ijwSIpA9nHciPnXpq7JrJJWbZ6+3W2AuSgK+gU8OY8xu9P44Y8uM/CiIwBlfgTHDdLc+k+Tx/h7
        7SaZnOY9bVPGvOmBoVWDpsY8mmaumt16OvUmTPXGNjiBzoPFCJRxkhQ==
X-Received: by 2002:a05:6a20:8e04:b0:100:1583:f230 with SMTP id y4-20020a056a208e0400b001001583f230mr22433986pzj.53.1683809350851;
        Thu, 11 May 2023 05:49:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4O3tqxxukugzTWtunS2y3hSSJYIfQzWJ0EpAS43vCnCzWOri7iVs1hU9nKhzrLFBqWz843HwoBRtH1DQ2Yp8I=
X-Received: by 2002:a05:6a20:8e04:b0:100:1583:f230 with SMTP id
 y4-20020a056a208e0400b001001583f230mr22433964pzj.53.1683809350580; Thu, 11
 May 2023 05:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230424055249.460381-2-kai.heng.feng@canonical.com> <20230505192208.GA970992@bhelgaas>
In-Reply-To: <20230505192208.GA970992@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 11 May 2023 20:48:59 +0800
Message-ID: <CAAd53p7FpSDh2nHYk1Tory3bvhKcmNQFYqC2GOM+jEyy0osceQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] PCI/AER: Disable AER interrupt on suspend
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 6, 2023 at 3:22=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Mon, Apr 24, 2023 at 01:52:48PM +0800, Kai-Heng Feng wrote:
> > PCIe service that shares IRQ with PME may cause spurious wakeup on
> > system suspend.
> >
> > PCIe Base Spec 5.0, section 5.2 "Link State Power Management" states
> > that TLP and DLLP transmission is disabled for a Link in L2/L3 Ready
> > (D3hot), L2 (D3cold with aux power) and L3 (D3cold), so we don't lose
> > much here to disable AER during system suspend.
> >
> > This is very similar to previous attempts to suspend AER and DPC [1],
> > but with a different reason.
>
> What is the reason?  I assume it's something to do with the bugzilla
> below, but the commit log should outline the user-visible problem this
> fixes.  The commit log basically makes the case for "why should we
> merge this patch."
>
> I assume it's along the lines of "I tried to suspend this system, but
> it immediately woke up again because of an AER interrupt, and
> disabling AER during suspend avoids this problem.  And disabling
> the AER interrupt is not a problem because X"

Yes that's the reason :)
Will update the message to better reflect what's going on.

Kai-Heng

>
> > [1] https://lore.kernel.org/linux-pci/20220408153159.106741-1-kai.heng.=
feng@canonical.com/
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
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
