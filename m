Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96CF6EDB63
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 07:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjDYF4E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 01:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjDYF4D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 01:56:03 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57149028
        for <linux-pci@vger.kernel.org>; Mon, 24 Apr 2023 22:56:01 -0700 (PDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 55C164427D
        for <linux-pci@vger.kernel.org>; Tue, 25 Apr 2023 05:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682402160;
        bh=Id7udfZYtH6BsDtkq+NCghDI2bVivdmoQ1W5SFhM1jY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=FwuI9+xaaXjniRQvF+TCmxJNQ4NmmJCUBUro61I29IM/z3Q4ahaVY6zUsgx0wRtIR
         WUPpJfLamxm/qTWJCdq/BwSRm4JFEMktglE1rL71oK1M7p3Huieb+Lypj7lHsfPagV
         a1n9JVInKLKBGK6yJC9bynyA7SzRz/pz6fiyCExjTULuzpugzf+JcG3khzd61unjHE
         +oWnhQAR4ex4jfNNvzJHa+WKS5ua/f4gg+UQDU4Gmk52VsLTrSjxwBij6qN0i3Seki
         G6Y5/6dEnqyL2a2z8j829Ye8FP4gYWh/ZGoQ3hQA9a5y3nDyR9XgdF4rFik/s1UO7P
         l8VZMdZyzCTjQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-24b25d3538eso2900311a91.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Apr 2023 22:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682402158; x=1684994158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id7udfZYtH6BsDtkq+NCghDI2bVivdmoQ1W5SFhM1jY=;
        b=IJtnNMb64DljAQ7htR4bILBetshgR1yb3W0OtnvVoSimx4aBU+HHAEaTe6f+aUZV7V
         0fQCEZwStZlT0Ga4AwWlqpRJr3uD+Hu8hCEClxnVLsryaPULBHU7XjH6jG5YcQ4DyDsH
         lMnovwOcpykielT+szYSoAkQt9VTFN2v8JAp+ygVI71DBT9xfBy9HkwMMt3fmYZLnZ4q
         SAhVIXD07xWJnLv1EjTNFfblWHph+8V0jZW2iiC71T2FToyawdioZMqoEOckUmfpuY6s
         CBTi6frHtqk8PDPXBBjMVWUZrPc3CoCYCQoLUFfbERd0zNnorVgcaSrH5eOaj/E7eFfH
         bsBg==
X-Gm-Message-State: AAQBX9d3Q5PZTBmBZcrt0DzNQhxiLKfjNRYDviPOxUaPQnuOnVPCjtcc
        y8OuDgrNnGhOyik0ewsL2TEXZ9ro5drWog7bhIHtm/XAtRQO0hh8PTQw6VD8f055rm4fkCjywjF
        auNiw2Z6h2bFCG4p4q6+QdYc23T4V5Rf7imoougj+OaMtFhVqz1UBnw==
X-Received: by 2002:a17:90a:db98:b0:23d:35c9:bf1c with SMTP id h24-20020a17090adb9800b0023d35c9bf1cmr16510977pjv.16.1682402158512;
        Mon, 24 Apr 2023 22:55:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350b7kWz5yV4oUWM1W5oTc7vK7mYHi9zee2bSsM2FXwzSHPKR9WAWiGE0RrYEySVLYX02QT2QH5IsznEqnW7pSFw=
X-Received: by 2002:a17:90a:db98:b0:23d:35c9:bf1c with SMTP id
 h24-20020a17090adb9800b0023d35c9bf1cmr16510969pjv.16.1682402158193; Mon, 24
 Apr 2023 22:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230424055249.460381-1-kai.heng.feng@canonical.com>
 <20230424055249.460381-2-kai.heng.feng@canonical.com> <97260e8b-1892-49a5-3792-0e3c28378fc0@linux.intel.com>
In-Reply-To: <97260e8b-1892-49a5-3792-0e3c28378fc0@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 25 Apr 2023 13:55:46 +0800
Message-ID: <CAAd53p5nrTQOxLkv+e9gLu3R9iOLXz5taJuwaAO4_W7_y89vEw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] PCI/AER: Disable AER interrupt on suspend
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 25, 2023 at 7:47=E2=80=AFAM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 4/23/23 10:52 PM, Kai-Heng Feng wrote:
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
> >
> > [1] https://lore.kernel.org/linux-pci/20220408153159.106741-1-kai.heng.=
feng@canonical.com/
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
>
> IIUC, you encounter AER errors during the suspend/resume process, which
> results in AER IRQ. Because AER and PME share an IRQ, it is regarded as a
> spurious wake-up IRQ. So to fix it, you want to disable AER reporting,
> right?

Yes. That's exactly what happened.

>
> It looks like it is harmless to disable the AER during the suspend/resume
> path. But, I am wondering why we get these errors? Did you check what err=
ors
> you get during the suspend/resume path? Are these errors valid?

I really don't know. I think it's similar to the reasoning in commit
b07461a8e45b ("PCI/AER: Clear error status registers during
enumeration and restore"): "AER errors might be recorded when
powering-on devices. These errors can be ignored, ...".
For this case, it happens when powering-off the device (D3cold) via
turning off power resources.

Kai-Heng

>
>
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
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
