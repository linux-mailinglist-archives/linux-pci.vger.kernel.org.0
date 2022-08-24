Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAEF59F42F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiHXH0U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 03:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiHXH0S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 03:26:18 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663E948C95
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 00:26:16 -0700 (PDT)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 046FD3F80F
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 07:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661325975;
        bh=RKMDC66Hnqek9iMZSAeuthSntMHl0KNHEil6I2t6IMA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=K761Lf1G8eH8xA3OjuxphC+2Wea1DAutcMeR++OZvP0fmIw1P0+i5/ASNzpuzF3oH
         NjAECs6WckvvYI1Dyp21lkq69wtwG7fFsYVH9xsbzOfxFkObyeUW1bUf3fSo+3zp2x
         t1yilV8JIcMgqRYmVlOFwJpqsbPx828ejn71AniwweNfsdJ0cHXlyw0cMwMp0gLf4f
         oydP40bmWp8N91YP++HhRa7vGKYSDg+/S/rxXceLpFcB/dwppM11uhlXuRjyVnJJ0S
         ooVmhWYwBLW2lWaGQrrZOXRlZaWN4FpzrBmoPUe/7vd78CtJfbeDQoArQyy6IIVYVZ
         g8zcbouPDbaOA==
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-11d20677c8cso1845985fac.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 00:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RKMDC66Hnqek9iMZSAeuthSntMHl0KNHEil6I2t6IMA=;
        b=Ribo2ToceCHFBTXymthJEo0EDPNpUI5KEaBBjNfuDAMzxt2jek+WaK2iLmLSWUXkQW
         fLhbVdoufYezQNO5qy/8hKTx97hlpRiJ2vBmOe7ODh/6zna5y0Wb4h1/kemNz5JFfs/3
         qDuny84V0b5W5AO2IITHk+mJV6LVj6ObpShvAktKbszWSs1u0UCXCewVVTDwEkbQG1NF
         WsKFWcAMfcAoSrFCIcPK3tkh3/Y7FOMyXpwbQo5k59lzb8qmWVrm9tgjb8m3CAYcsaFc
         MbYqMlzICqd04spIJ4NbHYk1fbut2ts4ykht9rlFBrw+x9Hi2Nk5S65OUWyG81hNzFJC
         NReQ==
X-Gm-Message-State: ACgBeo3gVq9jFASPcKuuAt5qcYXp0gneh94dKUnfgrf+OGxogvjMBzFs
        a+c3x1OkoHRBZ4w90BfZp/RSglRm7P8Ty1Jp4JO4KqrBS5wkvMjHIP8y7Cee57+oy3JHjPVxEvR
        1L8P2pqm3DVetiyUja72FqWEcxl7kY/vL2swdCu7pzvR2iR/1f5t8ig==
X-Received: by 2002:a05:6870:8901:b0:11d:416d:2ccb with SMTP id i1-20020a056870890100b0011d416d2ccbmr2927261oao.176.1661325973575;
        Wed, 24 Aug 2022 00:26:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7FmkwklTHwZ2basUPCHATRktTE3mGiZpq0BKWnXooCwDXZa9gowJyAQI1ujHRJlvLbbbs+3ciwprQMKznfcgI=
X-Received: by 2002:a05:6870:8901:b0:11d:416d:2ccb with SMTP id
 i1-20020a056870890100b0011d416d2ccbmr2927246oao.176.1661325973206; Wed, 24
 Aug 2022 00:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220706123244.18056-1-kai.heng.feng@canonical.com> <20220819234949.GA2515897@bhelgaas>
In-Reply-To: <20220819234949.GA2515897@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 24 Aug 2022 15:26:00 +0800
Message-ID: <CAAd53p74M2=gEoTiS3L7wC1a2YRJv+w=fV8_jPVaLtr4+Vvabg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable upstream port PTM during suspend
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 20, 2022 at 7:49 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jul 06, 2022 at 08:32:44PM +0800, Kai-Heng Feng wrote:
> > On Intel Alder Lake platforms, Thunderbolt entering D3cold can cause
> > some errors reported by AER:
>
> What's the connection with Thunderbolt?  I see "thunderbolt
> 0000:0a:00.0" in dmesg, but I think we see that message only because
> 0a:00.0 happens to be in the hierarchy below the 00:1d.0 Root Port,
> not specifically because it's a Thunderbolt device.

I mentioned "Thunderbolt" because those bridge devices are part of
Thunderbolt chip. Sorry for the confusing.

>
> Here's the hierarchy:
>
>   0000:00:1d.0 Root Port              to [bus 08-71]
>   0000:08:00.0 Switch Upstream Port   to [bus 09-71]
>   0000:09:00.0 Switch Downstream Port to [bus 0a]
>   0000:0a:00.0 Endpoint (USB controller)
>   0000:09:01.0 Switch Downstream Port to [bus 0b-3d]
>   0000:09:02.0 Switch Downstream Port to [bus 3e]
>   0000:3e:00.0 Endpoint (USB controller)
>   0000:09:03.0 Switch Downstream Port to [bus 3f-71]
>
> The error logged by 00:1d.0 is an Unsupported Request with Requester
> ID 08:00.0.
>
> I think the only relevant thing is that 08:00.0 has PTM enabled and
> 00:1d.0 has PTM disabled because pci_prepare_to_sleep() only disables
> PTM for Root Ports.  The same thing could happen if 08:00.0 were an
> Endpoint or a non-Thunderbolt Switch Upstream Port.
>
> Is entering D3cold relevant here?  I don't know how to tell from dmesg
> that we're entering D3cold.  If we actually put 08:00.0 in D3cold, I
> don't think we would see the Unsupported Request because 08:00.0 can't
> send PTM requests from D3cold.

Right, the D3cold is achieved when power resources of 00:1d.0 is off.
So when the PTM request is logged, 08:00.0 is still at D3hot.

>
> > pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> > thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> > xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> > pcieport 0000:00:1d.0: AER: device recovery failed
> >
> > In addition to that, it can also block system from suspending when
> > a Thunderbolt dock is attached to the same system.
>
>
> > The original approach [1] is to disable AER and DPC when link is in
> > L2/L3 Ready, L2 and L3, but Bjorn identified the root cause is the Unsupported
> > Request:
> >   - 08:00.0 sent a PTM Request Message (a Posted Request)
> >   - 00:1d.0 received the PTM Request Message
> >   - The link transitioned to DL_Down
> >   - Per sec 2.9.1, 00:1d.0 discarded the Request and reported an
> >     Unsupported Request
> >   - Or, per sec 6.21.3, if 00:1d.0 received a PTM Request when its
> >     own PTM Enable was clear, it would also be treated as an
> >     Unsupported Request
> >
> > And further: 'David did something like this [1], but just for Root Ports. That
> > looks wrong to me because sec 6.21.3 says we should not have PTM enabled in an
> > Upstream Port (i.e., in a downstream device like 08:00.0) unless it is already
> > enabled in the Downstream Port (i.e., in the Root Port 00:1d.0).'
> >
> > So also disable upstream port PTM to make the PCI driver conform to the spec
> > and solve the issue.
> >
> > [1] https://lore.kernel.org/all/20220408153159.106741-1-kai.heng.feng@canonical.com/
> > [2] https://lore.kernel.org/all/20220422222433.GA1464120@bhelgaas/
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216210
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: David E. Box <david.e.box@linux.intel.com>
> > Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pci.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index cfaf40a540a82..8ba8a0e12946e 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2717,7 +2717,8 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
> >        * port to enter a lower-power PM state and the SoC to reach a
> >        * lower-power idle state as a whole.
> >        */
> > -     if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> > +     if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > +         pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
> >               pci_disable_ptm(dev);
> >
> >       pci_enable_wake(dev, target_state, wakeup);
> > @@ -2775,7 +2776,8 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
> >        * port to enter a lower-power PM state and the SoC to reach a
> >        * lower-power idle state as a whole.
> >        */
> > -     if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> > +     if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > +         pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
> >               pci_disable_ptm(dev);
> >
> >       __pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
>
> What do you think of the following possible rework?  I think it's
> functionally the same except that it disables PTM on Endpoints as well
> as Switch Upstream Ports.

Your rework works for me, with much better comment :)

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

>
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95bc329e74c0..96487a9ce5bf 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2707,14 +2707,19 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>                 return -EIO;
>
>         /*
> -        * There are systems (for example, Intel mobile chips since Coffee
> -        * Lake) where the power drawn while suspended can be significantly
> -        * reduced by disabling PTM on PCIe root ports as this allows the
> -        * port to enter a lower-power PM state and the SoC to reach a
> -        * lower-power idle state as a whole.
> +        * We want to disable PTM on Root Ports because that allows some
> +        * chips, e.g., Intel mobile chips since Coffee Lake, to enter a
> +        * lower-power PM state.
> +        *
> +        * PCIe r6.0, sec 2.2.8, strongly recommends that functions support
> +        * generation of messages in non-D0 states, so we assume Switch
> +        * Upstream Ports or Endpoints may send PTM Requests while in D1,
> +        * D2, and D3hot.  A PTM message received by a Downstream Port
> +        * (including a Root Port) with PTM disabled must be treated as an
> +        * Unsupported Request (sec 6.21.3).  To prevent this error,
> +        * disable PTM in *all* devices, not just Root Ports.
>          */
> -       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -               pci_disable_ptm(dev);
> +       pci_disable_ptm(dev);
>
>         pci_enable_wake(dev, target_state, wakeup);
>
> @@ -2764,15 +2769,8 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
>         if (target_state == PCI_POWER_ERROR)
>                 return -EIO;
>
> -       /*
> -        * There are systems (for example, Intel mobile chips since Coffee
> -        * Lake) where the power drawn while suspended can be significantly
> -        * reduced by disabling PTM on PCIe root ports as this allows the
> -        * port to enter a lower-power PM state and the SoC to reach a
> -        * lower-power idle state as a whole.
> -        */
> -       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -               pci_disable_ptm(dev);
> +       /* See rationale above for disabling PTM */
> +       pci_disable_ptm(dev);
>
>         __pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
>
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 368a254e3124..ec338470d13f 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -31,12 +31,18 @@ static void pci_ptm_info(struct pci_dev *dev)
>
>  void pci_disable_ptm(struct pci_dev *dev)
>  {
> -       int ptm;
> +       int type, ptm;
>         u16 ctrl;
>
>         if (!pci_is_pcie(dev))
>                 return;
>
> +       type = pci_pcie_type(dev);
> +       if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
> +             type == PCI_EXP_TYPE_UPSTREAM ||
> +             type == PCI_EXP_TYPE_ENDPOINT))
> +               return;
> +
>         ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
>         if (!ptm)
>                 return;
