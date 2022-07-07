Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8270B56AACF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiGGSei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 14:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiGGSeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 14:34:06 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A33C5C967;
        Thu,  7 Jul 2022 11:32:25 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31c89111f23so128348077b3.0;
        Thu, 07 Jul 2022 11:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRf9ml7jXebCmHJtIo9hXGmvl5NfH5hP6TYRGyysBr4=;
        b=JB4bSD1u8UUZi8mBn59N2M9WdomsmlUxoBGxmNUP1deyObKnULkRtWjiLu0ObNdWiW
         Qgr+p/LXQfoACrK8fYMDqNoxcqbu2U0nBB8Hn6y78jIPH7Kyu2PGO0jRmFNCkWmnarG4
         F+2KFSL1ys8msVqTzKB/sunfTtx5QjyE6mfUQyXro8A/0L7zC23OMAajOPS/bRueQorY
         1MNiqrzCgSF/Wf2smZZT8Mp9dv2MGh5wX6oJ66TGRYLE71BSd5GNiBPq9ZyFO9ZMNHWf
         Ddw5eqHtFRS82okeHilyCuecLHN5x+EiW70CNSnRdDmk1BwPtM1HCi0UffbCk2XYSF9W
         GvFA==
X-Gm-Message-State: AJIora9Y3R6KaTbhQ2enPMpNxHFIFJ3AjLuS7pXRDXKfWc0MZQcj4QdF
        KUoUF2g1NJ+3e1SntCpPnQVXwGY3vFLgyAQDSsFH2JwiLiI=
X-Google-Smtp-Source: AGRyM1uLoifQN5Q5hSE3q0FTI97hoR0WKNSRBz0XN+Ejo0nkSmMs1C9YixxVSVG+X2gt6cvp/LIqdlEWGQZSrPseQKY=
X-Received: by 2002:a81:6943:0:b0:31c:ee3e:47c6 with SMTP id
 e64-20020a816943000000b0031cee3e47c6mr10527897ywc.515.1657218744731; Thu, 07
 Jul 2022 11:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220707172205.3205110-1-rajvi.jingar@linux.intel.com>
 <20220707172205.3205110-2-rajvi.jingar@linux.intel.com> <CAJZ5v0h02a=puAKY3wp2vqhXCHKxnzWFQvUOjMMtnENz3=39xg@mail.gmail.com>
In-Reply-To: <CAJZ5v0h02a=puAKY3wp2vqhXCHKxnzWFQvUOjMMtnENz3=39xg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jul 2022 20:32:13 +0200
Message-ID: <CAJZ5v0hqG+d6ZN9uQ5e0puftsUBaU-WKrnTZi_uVcyJhJ1hcNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/PTM: fix in pci_disable_ptm()
To:     Rajvi Jingar <rajvi.jingar@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 7, 2022 at 8:27 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jul 7, 2022 at 7:22 PM Rajvi Jingar
> <rajvi.jingar@linux.intel.com> wrote:
> >
> > Set ptm_enabled from 'struct pci_dev' to 0 in pci_ptm_disable() to
>
> I would set "Clear" here instead of "Set", but moreover ->

s/set/say/ sorry.

> > save the disabled PTM state for the device.
> >
> > Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
> > Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> > ---
> >  drivers/pci/pcie/ptm.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > index 368a254e3124..746e29779c27 100644
> > --- a/drivers/pci/pcie/ptm.c
> > +++ b/drivers/pci/pcie/ptm.c
> > @@ -44,6 +44,7 @@ void pci_disable_ptm(struct pci_dev *dev)
> >         pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
> >         ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
> >         pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> > +       dev->ptm_enabled = 0;
>
> -> I don't think that this is going to work without setting
> dev->ptm_enabled in pci_restore_ptm_state() if the restored state
> turns out to be "enabled".

And arguably, this function doesn't need to do anything if
dev->ptm_enabled is 0 already and this is the only check it needs to
do, because dev->ptm_enabled will only be set for PCIe devices that
have PTM.

> >  }
> >
> >  void pci_save_ptm_state(struct pci_dev *dev)
> > --
