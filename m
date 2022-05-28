Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9542536D38
	for <lists+linux-pci@lfdr.de>; Sat, 28 May 2022 15:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiE1N7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 May 2022 09:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiE1N7d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 May 2022 09:59:33 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC08513DF1;
        Sat, 28 May 2022 06:59:32 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id i187so12215873ybg.6;
        Sat, 28 May 2022 06:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+CXMx1NEwI+f0FbgTC/8sLjQx/aw6M+u3COIG+3gDg=;
        b=RqTdyOw+ggFhKdRqEi5L5PqNhZb26tRGTQmOYioBaYwIOwcpwdUqTo2jg+t0QIB+ll
         ri0DWxvNb9T/Myq1etQY+eo//hhtTe6R9hQtEqOoqjwXTU8hbaWZoNMmounpgL3scPlf
         +mgW8v3PbxrHTHnUNZdPQYs977k5FqUCnYm4JTriGqXKTOkjFnZWgfbbA4yswpk7+exV
         b6VF+TtVg/g9EvyAiKYHZt7ny4F/asKMVxou1aUy7tL1YHcmsGFkMXUqikE/TrNGTSYy
         E023/oi4+4hO6Ag6CHWf9uRpALiusCqffriPoks5+Lt1rLQYuIq6PmD2Vj58ewEajTdZ
         lrDA==
X-Gm-Message-State: AOAM532dlUkMgV9fx3EAn//9gpHJqPIR5QTddLYGDtFQ4yFVzu/rntTI
        iF7G/zDyo//LOcyxMcILcEVPqd5Tjbbxj90nZgI=
X-Google-Smtp-Source: ABdhPJzH1bOkxGyfmakKHLI7AJXLtpbq684AMWJrqPR8vYXMPSbJ4FjM+McUcum7sjgpHabMIbGy9HWzKICfDQBy7SI=
X-Received: by 2002:a25:d98b:0:b0:65c:9dc9:7a8f with SMTP id
 q133-20020a25d98b000000b0065c9dc97a8fmr2321841ybg.622.1653746372167; Sat, 28
 May 2022 06:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220527225148.GA511276@bhelgaas> <20220527230923.GA513506@bhelgaas>
In-Reply-To: <20220527230923.GA513506@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 28 May 2022 15:59:20 +0200
Message-ID: <CAJZ5v0go+yGkkonBfXg8XYP5Bt9dcORa5vKeR3axS8m5QGUpCA@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] PCI/PM: Write 0 to PMCSR in pci_power_up() in
 all cases
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
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

On Sat, May 28, 2022 at 1:09 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, May 27, 2022 at 05:51:48PM -0500, Bjorn Helgaas wrote:
> > On Fri, May 27, 2022 at 08:52:17PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, May 26, 2022 at 9:46 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > On Thu, May 26, 2022 at 11:54:22AM -0500, Bjorn Helgaas wrote:
> > > > > On Thu, May 05, 2022 at 08:10:43PM +0200, Rafael J. Wysocki wrote:
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > Make pci_power_up() write 0 to the device's PCI_PM_CTRL register in
> > > > > > order to put it into D0 regardless of the power state returned by
> > > > > > the previous read from that register which should not matter.
> > > > > >
> > > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > ---
> > > > > >  drivers/pci/pci.c |   11 +++--------
> > > > > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > Index: linux-pm/drivers/pci/pci.c
> > > > > > ===================================================================
> > > > > > --- linux-pm.orig/drivers/pci/pci.c
> > > > > > +++ linux-pm/drivers/pci/pci.c
> > > > > > @@ -1230,15 +1230,10 @@ int pci_power_up(struct pci_dev *dev)
> > > > > >     }
> > > > > >
> > > > > >     /*
> > > > > > -    * If we're (effectively) in D3, force entire word to 0. This doesn't
> > > > > > -    * affect PME_Status, disables PME_En, and sets PowerState to 0.
> > > > > > +    * Force the entire word to 0. This doesn't affect PME_Status, disables
> > > > > > +    * PME_En, and sets PowerState to 0.
> > > > > >      */
> > > > > > -   if (state == PCI_D3hot)
> > > > > > -           pmcsr = 0;
> > > > > > -   else
> > > > > > -           pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
> > > > > > -
> > > > > > -   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
> > > > > > +   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> > > > >
> > > > > Can you reassure me why this is safe and useful?
> > > > >
> > > > > This is a 16-bit write that includes (PCIe r6.0, sec 7.5.2.2):
> > > > >
> > > > >   0x0003 PowerState     RW
> > > > >   0x0004                RsvdP
> > > > >   0x0008 No_Soft_Reset  RO
> > > > >   0x00f0                RsvdP
> > > > >   0x0100 PME_En         RW/RWS
> > > > >   0x1e00 Data_Select    RW, VF ROZ
> > > > >   0x6000 Data_Scale     RO, VF ROZ
> > > > >   0x8000 PME_Status     RW1CS
> > > > >
> > > > > We intend to set PowerState to 0 (D0), apparently intend to clear
> > > > > PME_En, and PME_Status is "write 1 to clear" to writing 0 does
> > > > > nothing, so those look OK.
> > > > >
> > > > > But the RsvdP fields are reserved for future RW bits and should be
> > > > > preserved, and it looks like clearing Data_Select could potentially
> > > > > break the Data Register power consumption reporting (which I don't
> > > > > think we support today).
> > > > >
> > > > > It seems like maybe we should do this instead:
> > > > >
> > > > >   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL,
> > > > >                         pmcsr & ~PCI_PM_CTRL_STATE_MASK)
> > > > >
> > > > > to just unconditionally clear PowerState?
> > > >
> > > > Or I guess this, since we want to clear PME_En as well?
> > > >
> > > >   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr &
> > > >                         ~(PCI_PM_CTRL_STATE_MASK | PCI_PM_CTRL_PME_ENABLE));
> > >
> > > Yes.
> > >
> > > Also, this patch actually only makes a difference if the device is
> > > going into D0 from D1 or D2, because we have always written 0 to the
> > > PMCSR during transitions from D3hot.
> > >
> > > It is inconsistent and confusing to do different things depending on
> > > the initial power state here and the code is simpler when 0 is written
> > > regardless.
> >
> > I agree that depending on the initial power state is confusing (it
> > confused me :)).
> >
> > What would you think of replacing this patch with the one below?
>
> Well, I don't know why I sent this, since I had already sent the pull
> request.  Not thinking clearly, I guess.  Anyway, your original patch
> is now upstream.  Sorry for the distraction.

No biggie.

If it turns out to be problematic, it can be changed to preserving the
reserved bits easily enough.
