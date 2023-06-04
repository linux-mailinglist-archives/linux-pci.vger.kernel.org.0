Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156AD721645
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jun 2023 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjFDLGw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 4 Jun 2023 07:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFDLGv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 07:06:51 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70551CF;
        Sun,  4 Jun 2023 04:06:50 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso76112266b.0;
        Sun, 04 Jun 2023 04:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685876809; x=1688468809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iul/lfmfErHcNmWNvS+6469y34DXHRpFyOnb+NMJ3Pc=;
        b=jAQ3H6qglq5xvL9AZAc3fjkkIJC2Xx0HpxPFFltbLn0sYCAQ+fcNFd015JWZHtr6Mq
         Zojl3j5Nr6MVWbo3u0RbbMhFKXqcsmpywzklOFDaLauQ+nCkfEKIkqFaBPhDYDTuH6BZ
         DOZJECf5stB1vvuHQlTPsVCc3Tv1ZaORvBtvHVg10kbLUOaTk2B1+LSNqjmGUCV3tUnY
         ehPyWjiO4TzOgjP4oFAaVuod+d5ggE4CGpcWdngjhyChhoaDIpzbbuE/PcohyjEa5S7u
         vks8AGhcZ48cZl4o0bsG553VktbdOZSREEDix1IRW10P7ax6RcFj1qhYKmrGub39hphF
         ykng==
X-Gm-Message-State: AC+VfDxBAavNs3IWUHFa4+YDyGGayB+Vjh5sAerBRi3O4Jm9MhXJD/G0
        jF/GiWE7bNY6jcxbpKBrcjELR9AmT+xF7J9YYe8=
X-Google-Smtp-Source: ACHHUZ7N1b8OvpjZ7+uRkzDlT+9iVd5uIpbWzkB1JHj9/zLCBm+FKUHl1ojiQ0/WiCsbb7O9qcUHDdroZrUAEYzIi80=
X-Received: by 2002:a17:906:d2:b0:977:cb73:ef6a with SMTP id
 18-20020a17090600d200b00977cb73ef6amr1967397eji.3.1685876808573; Sun, 04 Jun
 2023 04:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230602031122.18350-1-mario.limonciello@amd.com> <ZHpPOzT0nm+vddPq@bhelgaas>
In-Reply-To: <ZHpPOzT0nm+vddPq@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 4 Jun 2023 13:06:34 +0200
Message-ID: <CAJZ5v0jr=2FYhyoJMZFV7hcbiO8Ugj4OZVhrtSyb3j+SuXs=+Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: Call _REG when saving/restoring PCI state
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 2, 2023 at 10:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, Len, linux-acpi]
>
> Hi Mario,
>
> On Thu, Jun 01, 2023 at 10:11:22PM -0500, Mario Limonciello wrote:
> > ASMedia PCIe GPIO controllers connected to AMD SOC fail functional tests
> > after returning from s2idle. This is because the BIOS checks whether the
> > OSPM has called the _REG method to determine whether it can interact with
> > the OperationRegion assigned to the device.
>
> "s2idle" is a Linux term; I'd prefer something that we can relate to
> the ACPI spec.

From the ACPI spec viewpoint, s2idle is S0, so this means that _REG
needs to be called under specific conditions when the system is in S0.
I'm not sure if this is really ACPI-compliant.

> Maybe a pointer to the specific function in the driver that has a
> problem?  Based on the patch, I assume the driver uses some control
> method that looks at PCI config space?
>
> > To fix this issue, call acpi_evaluate_reg() when saving and restoring the
> > state of PCI devices.
>
> Please include the spec citation: ACPI r6.5, sec 6.5.4.  The URL has
> changed in the past and may change in the future,

That's true, but it has been promised to us that these URLs will be
stable for the foreseeable future.

Besides, the spec version and section information is there in the link itself.

> but the name/section number will not.
>
> > Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/pci/pci.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index e38c2f6eebd4..071ecba548b0 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1068,6 +1068,12 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> >       return acpi_pci_bridge_d3(dev);
> >  }
> >
> > +static inline int platform_toggle_reg(struct pci_dev *dev, int c)
> > +{
> > +     return acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
> > +                              ACPI_ADR_SPACE_PCI_CONFIG, c);
> > +}
>
> You never check the return value, so why return it?
>
> The function actually doesn't *toggle*; it connects or disconnects
> based on "c".
>
> This looks like it only builds when CONFIG_ACPI=y?
>
> >  /**
> >   * pci_update_current_state - Read power state of given device and cache it
> >   * @dev: PCI device to handle.
> > @@ -1645,6 +1651,9 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
> >  int pci_save_state(struct pci_dev *dev)
> >  {
> >       int i;
> > +
> > +     platform_toggle_reg(dev, ACPI_REG_DISCONNECT);
>
> I would expect these to be in the PM code near the power state
> transitions, not in the state save/restore code.  These functions
> *are* used during suspend/resume, but are used in other places as
> well, where we probably don't want _REG executed.
>
> Cc'd Rafael and PM folks, who can give much better feedback.

Right, they are not PM-specific.

Also, it looks like this isn't really about system suspend, but about
the device (port?) going into D3(hot/cold?) and back into D0.

I'm not sure if the spec mandates the need to reevaluate _REG on
device power state transitions.

At least, it looks like the operation region becomes invalid when the
device goes into D3 and there is no provision in the spec I can recall
ATM to notify AML about that.

IOW, once _REG has been called, the operation region needs to stay
valid from the perspective of AML using it which I think is not the
case on the affected platform.

> >       /* XXX: 100% dword access ok here? */
> >       for (i = 0; i < 16; i++) {
> >               pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
> > @@ -1790,6 +1799,8 @@ void pci_restore_state(struct pci_dev *dev)
> >       pci_enable_acs(dev);
> >       pci_restore_iov_state(dev);
> >
> > +     platform_toggle_reg(dev, ACPI_REG_CONNECT);
> > +
> >       dev->state_saved = false;
> >  }
> >  EXPORT_SYMBOL(pci_restore_state);
> > @@ -3203,6 +3214,7 @@ void pci_pm_init(struct pci_dev *dev)
> >       pci_read_config_word(dev, PCI_STATUS, &status);
> >       if (status & PCI_STATUS_IMM_READY)
> >               dev->imm_ready = 1;
> > +     platform_toggle_reg(dev, ACPI_REG_CONNECT);
> >  }
> >
> >  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> > --
