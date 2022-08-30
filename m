Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724875A68EB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 18:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiH3Q6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 12:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiH3Q6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 12:58:34 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7C7B69CF;
        Tue, 30 Aug 2022 09:58:32 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id y197so429553yby.13;
        Tue, 30 Aug 2022 09:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QwTPzippv9nFknfyh2bt7Km8y3L5Y24/vUQnMoNu/zw=;
        b=YNFZdZlfGNc4/e4qpIJTi5d6fY7hVg48oZmQDZtG5s+2/z0yJ3pZ4+so8DeQYRW8Sn
         BwSlmDSAxC+4XjuaXHuo1Rw8SAWjcD9M9HKmL2qyDP+9NuHDzAZ8QDYkt+Pc/pXJvwFI
         1+T86dhJ/SCBOMZoXjk+uuFp3DziusujNuC/jQ3qTVTjyEk92flJJZumR7NblpR+7aq1
         qoJ/zP6c5oSfJEFtR1fRNUxqmY/cwCz3wZ4Uz7IbgpqtqeKpiYETxTOmcvvB2uzDJT4g
         QtEW//LmL602bc1CB69l7qXL09HnMn81uSyPWg1lXSUzBCAsGaSioEi3S2MAcpZlQkyp
         R+Lg==
X-Gm-Message-State: ACgBeo0zhRqtKo2z77viDhLANW2zzJwsSjkdpvzHu1SgFHBlczSbAUmd
        JS+zM8HlTVdJjbJnnPZNps8CAqaWxfQjWZYq/vw=
X-Google-Smtp-Source: AA6agR7mtrFfiiYWCG6KyM2N/ARGZmXb9oaS4qpQFGTPfFI/HmT+X3xNmdn7/Sel5cGAE2qOC38m61YoCH88sHdJSIA=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr12426812ybm.482.1661878711809; Tue, 30
 Aug 2022 09:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220830104913.1620539-2-rajvi.jingar@linux.intel.com> <20220830162529.GA106073@bhelgaas>
In-Reply-To: <20220830162529.GA106073@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Aug 2022 18:58:20 +0200
Message-ID: <CAJZ5v0jL812FKOJsmijE7gx5GEYp0hQ9+3UtQ_WUr-Uf5pgxAg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/2] PCI/PTM: fix to maintain pci_dev->ptm_enabled
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 30, 2022 at 6:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Kai-Heng]
>
> On Tue, Aug 30, 2022 at 03:49:13AM -0700, Rajvi Jingar wrote:
> > pci_dev->ptm_enabled needs to be maintained to reflect the current PTM
> > state of the device. In pci_ptm_disable(), clear ptm_enabled from
> > 'struct pci_dev' on disabling PTM state for the device.
> > In pci_restore_ptm_state(), set dev->ptm_enabled based on the restored
> > PTM state of the device.
> >
> > In pci_ptm_disable(), perform ptm_enabled check to avoid config space
> > access in case if PTM is already disabled for the device. ptm_enabled
> > won't be set for non-PCIe devices so pci_is_pcie(dev) check is not
> > needed anymore.
>
> This one sounds like it's supposed to fix something, but I'm not clear
> exactly what.
>
> I have a vague memory of config accesses messing up a low power state.
> But this is still completely magical and unmaintainable since AFAIK
> there is nothing in the PCIe spec about avoiding config accesses when
> PTM is disabled.

Because ptm_enabled is expected to always reflect the hardware state,
pci_disable_ptm() needs to be amended to clear it.  Also it is prudent
to explicitly make it reflect the new hardware state in
pci_restore_ptm_state().

Then, pci_disable_ptm() can be made bail out if ptm_enabled is clear,
because it has nothing to do then and the pci_is_pcie() check in there
is not necessary, because ptm_enabled will never be set for devices
that are not PCIe.

> At the very least, we would need more details in the commit log and
> a hint in the code about this.
>
> > Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  v1->v2:
> >    - add ptm_enabled check in pci_ptm_disable().
> >    - set the dev->ptm_enabled value in pci_restore_ptm_state().
> >  v2->v3:
> >    - remove pci_is_pcie(dev) check in pci_ptm_disable().
> >    - add Reviewed-by tag in commit message
> > ---
> >  drivers/pci/pcie/ptm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > index 368a254e3124..1ce241d4538f 100644
> > --- a/drivers/pci/pcie/ptm.c
> > +++ b/drivers/pci/pcie/ptm.c
> > @@ -34,7 +34,7 @@ void pci_disable_ptm(struct pci_dev *dev)
> >       int ptm;
> >       u16 ctrl;
> >
> > -     if (!pci_is_pcie(dev))
> > +     if (!dev->ptm_enabled)
> >               return;
>
> This will conflict with a change Kai-Heng Feng and I have been working
> on, but I can resolve it when applying.
>
> >       ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> > @@ -44,6 +44,7 @@ void pci_disable_ptm(struct pci_dev *dev)
> >       pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
> >       ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
> >       pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> > +     dev->ptm_enabled = 0;
> >  }
> >
> >  void pci_save_ptm_state(struct pci_dev *dev)
> > @@ -83,6 +84,7 @@ void pci_restore_ptm_state(struct pci_dev *dev)
> >
> >       cap = (u16 *)&save_state->cap.data[0];
> >       pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
> > +     dev->ptm_enabled = !!(*cap & PCI_PTM_CTRL_ENABLE);
> >  }
> >
> >  void pci_ptm_init(struct pci_dev *dev)
> > --
> > 2.25.1
> >
