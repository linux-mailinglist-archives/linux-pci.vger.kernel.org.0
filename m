Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DD4363E49
	for <lists+linux-pci@lfdr.de>; Mon, 19 Apr 2021 11:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhDSJNk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Apr 2021 05:13:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52012 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhDSJNj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Apr 2021 05:13:39 -0400
Received: from mail-lj1-f200.google.com ([209.85.208.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lYPxs-0003CB-HF
        for linux-pci@vger.kernel.org; Mon, 19 Apr 2021 09:13:08 +0000
Received: by mail-lj1-f200.google.com with SMTP id o4-20020a05651c0504b02900bef5ae012aso3545509ljp.23
        for <linux-pci@vger.kernel.org>; Mon, 19 Apr 2021 02:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHrGaUBBYyCaNzmHKZvwphNNADBKXI78oljxwo2iTJU=;
        b=b4TpIT1VDeXz48/x0F4TBfL0xNpSu8XqMhTWA45TGgCpcyyaNYC1m2LX0lm3+8uIQv
         5t8aabXHC4/EU/Vjx+N3JIUYLRH2CSqvGtBV6/BBlxjLdiBF2HEHzRXT+jD++jBAyEg6
         cxmAlmlYHfBRILsurbB2dhtQKkbQ0iCcOqgKPAq1QBi4IHSRFAa8tVU4XMDMob0tP1+2
         zEbFHWkKCJZcpeyUQxcqr5prEx9JfwHx+Lttcxj+SJfUz8KmI2OcxuHoNJIsU06jLHp0
         twrSuqpPbrAlLtyx+NiZou60eO74/2Ssodk1fUtTivJabT4cFCDY4Y7NHyDJ6DrbX+Uh
         Wy6A==
X-Gm-Message-State: AOAM531qn6iw3+owEW5GB6CduRZQaiDXrJFh7674AJ57vYJGs31zawUJ
        nU64FmWckMsqom4MpFLM/fARiGkh64parKZWMQ0v7MrSyDXh/ph9hh+mQGVmI3Tty1BwRnlOuD3
        L6z26VHbGWf2x0UnZrGvmt6cHUKNe4Jvl02KiPVCWWFYmWcydYWnbog==
X-Received: by 2002:a2e:88cc:: with SMTP id a12mr10499427ljk.402.1618823587974;
        Mon, 19 Apr 2021 02:13:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5p4Cqe2LM2xihhB901ADZVyCoqpBYFwrEVNhlgmv694HLCWYkSrMQLviXTAGoM6hTk/BVK+Ahw4DphBE194o=
X-Received: by 2002:a2e:88cc:: with SMTP id a12mr10499417ljk.402.1618823587729;
 Mon, 19 Apr 2021 02:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210329052339.20882-1-kai.heng.feng@canonical.com> <CAAd53p7fBKadTdsWZOe4O8ZuQDS6BCmkuA1ettZC7vxAxNw7Bw@mail.gmail.com>
In-Reply-To: <CAAd53p7fBKadTdsWZOe4O8ZuQDS6BCmkuA1ettZC7vxAxNw7Bw@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 19 Apr 2021 17:12:56 +0800
Message-ID: <CAAd53p7cVuT6tjS3DQUxVw4--4vhF5Kb0C5yN1_hNLrX=QEnew@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Disable D3cold support on Intel XMM7360
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 12, 2021 at 4:18 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Mon, Mar 29, 2021 at 1:23 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > On some platforms, the root port for Intel XMM7360 WWAN supports D3cold.
> > When the root port is put to D3cold by system suspend or runtime
> > suspend, attempt to systems resume or runtime resume will freeze the
> > laptop for a while, then it automatically shuts down.
> >
> > The root cause is unclear for now, as the Intel XMM7360 doesn't have a
> > driver yet.
> >
> > So disable D3cold for XMM7360 as a workaround, until proper device
> > driver is in place.
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212419
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> A gentle ping...

Ok, I think I found the root cause:
https://lore.kernel.org/lkml/20210419090750.1272562-1-kai.heng.feng@canonical.com/

So we can ignore this patch.


Kai-Heng

>
> > ---
> > v2:
> >  - Add comment.
> >
> >  drivers/pci/quirks.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 653660e3ba9e..c48b0b4a4164 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5612,3 +5612,16 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
> >  }
> >  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
> >                                PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> > +
> > +/*
> > + * Device [8086:7360]
> > + * When it resumes from D3cold, system freeze and shutdown happens.
> > + * Currently there's no driver for XMM7360, so add it as a PCI quirk.
> > + * https://bugzilla.kernel.org/show_bug.cgi?id=212419
> > + */
> > +static void pci_fixup_no_d3cold(struct pci_dev *pdev)
> > +{
> > +       pci_info(pdev, "disable D3cold\n");
> > +       pci_d3cold_disable(pdev);
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7360, pci_fixup_no_d3cold);
> > --
> > 2.30.2
> >
