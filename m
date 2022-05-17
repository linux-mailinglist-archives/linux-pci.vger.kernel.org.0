Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA44052A56D
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 16:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240458AbiEQOyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 10:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349450AbiEQOyf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 10:54:35 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7BB50447;
        Tue, 17 May 2022 07:54:32 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id e194so19447192iof.11;
        Tue, 17 May 2022 07:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8nn88xQh9eGLKIffo1TE6yNWGKhqJHXOhxiPgSDN0E=;
        b=TJbJUVog3vcrz0zoSnCUaSiO+S4a0kT/cl95I3D1/KcKPTcGZ3sgpl1gJkFdViso1j
         KGL+KrmPp4XdbEytUsywYZcFcDA6haUbmlR3BNqTNbGGiJDZyZNYmE218noTLNAW7vud
         TcuHf7DSPemojfGMnvs/JvqQBIlj8e8hNK23QJTfD5TYSl8oaE87GaYHMfyz8X0wpvHj
         rwJMIbOiik7lTuJFFw86xk2578inwTNtRWDid27kI/FF0h6DjLql+YUjSGRsrdAHCYst
         OpLv8asCPeE1jj3ZDuE9rQ6a+qML28qOmZnbbPdDytvmE3MncsMsfLIOkr3FPPIaWMUA
         8c8g==
X-Gm-Message-State: AOAM533WfNqFLrWqRlWpNtK7T91G7SArSdJLeyxxanwTvuc/saidNy2I
        rtVjL2Hmcc5a9WaGTdaQ8pMKUC6+HngB4cICo2o=
X-Google-Smtp-Source: ABdhPJyUbjhY69ilI/s9mBNDVH5iERYUtRrDzsbW/o8lztqPEGggfJCDCG4DcINQoLOPIxgyFBXYTR3Y9cWQF9ak7V0=
X-Received: by 2002:a05:6602:2082:b0:657:ad1c:795e with SMTP id
 a2-20020a056602208200b00657ad1c795emr10733535ioa.187.1652799272034; Tue, 17
 May 2022 07:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0g6GdKfN4b5uwHEhh4hBuG=haVHaXc-XuMQLe8Wd41Y3g@mail.gmail.com>
 <20220517144846.GA1068039@bhelgaas>
In-Reply-To: <20220517144846.GA1068039@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 16:54:20 +0200
Message-ID: <CAJZ5v0iNaAd=yP3DgDVVpffKU6kt+nSpPeqxWJyRddaX5K4FRA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Jingar, Rajvi" <rajvi.jingar@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Tue, May 17, 2022 at 4:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, May 16, 2022 at 10:59:32PM +0200, Rafael J. Wysocki wrote:
> > On Mon, May 16, 2022 at 10:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, May 13, 2022 at 10:00:48PM +0000, Jingar, Rajvi wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > Sent: Thursday, May 12, 2022 11:36 AM
> > > > > To: Rafael J. Wysocki <rafael@kernel.org>
> > > > > Cc: Jingar, Rajvi <rajvi.jingar@intel.com>; Wysocki, Rafael J
> > > > > <rafael.j.wysocki@intel.com>; Bjorn Helgaas <bhelgaas@google.com>; David Box
> > > > > <david.e.box@linux.intel.com>; Linux PCI <linux-pci@vger.kernel.org>; Linux
> > > > > Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux PM <linux-
> > > > > pm@vger.kernel.org>
> > > > > Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
> > > > >
> > > > > On Thu, May 12, 2022 at 07:52:36PM +0200, Rafael J. Wysocki wrote:
> > > > > > On Thu, May 12, 2022 at 7:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > On Thu, May 12, 2022 at 03:49:18PM +0200, Rafael J. Wysocki wrote:
> > > > >
> > > > > > > > Something like this should suffice IMV:
> > > > > > > >
> > > > > > > > if (!dev_state_saved || pci_dev->current_state != PCI_D3cold)
> > > > > > > >
> > > > > > > >         pci_disable_ptm(pci_dev);
> > > > > > >
> > > > > > > It makes sense to me that we needn't disable PTM if the device is in
> > > > > > > D3cold.  But the "!dev_state_saved" condition depends on what the
> > > > > > > driver did.  Why is that important?  Why should we not do the
> > > > > > > following?
> > > > > > >
> > > > > > >   if (pci_dev->current_state != PCI_D3cold)
> > > > > > >     pci_disable_ptm(pci_dev);
> > > > > >
> > > > > > We can do this too.  I thought we could skip the power state
> > > > > > check if dev_state_saved was unset, because then we would know
> > > > > > that the power state was not D3cold.  It probably isn't worth
> > > > > > the hassle though.
> > > >
> > > > We see issue with certain platforms where only checking if device
> > > > power state in D3Cold is not enough and the !dev_state_saved check
> > > > is needed when disabling PTM. Device like nvme is relying on ASPM,
> > > > it stays in D0 but state is saved. Touching the config space wakes
> > > > up the device which prevents the system from entering into low power
> > > > state.
> > >
> > > Correct me if I'm wrong: for NVMe devices, nvme_suspend() has already
> > > saved state and put the device in some low-power state.  Disabling PTM
> > > here is functionally OK but prevents a system low power state, so you
> > > want to leave PTM enabled.
> > >
> > > But I must be missing something because pci_prepare_to_sleep()
> > > currently disables PTM for Root Ports.  If we leave PTM enabled on
> > > NVMe but disable it on the Root Port above it, any PTM Request from
> > > NVMe will cause an Unsupported Request error.
> > >
> > > Disabling PTM must be coordinated across PTM Requesters and PTM
> > > Responders.  That means the decision to disable cannot depend on
> > > driver-specific things like whether the driver has saved state.
> >
> > Setting state_saved generally informs pci_pm_suspend_noirq() that the
> > device has already been handled and it doesn't need to do anything to
> > it.
> >
> > But you are right that PTM should be disabled on downstream devices as
> > well as on the ports that those devices are connected to and it can be
> > done even if the given device has already been handled, so the
> > state_saved value is technically irrelevant.
> >
> > That's why I suggested to check if the power state is between D0 and
> > D3cold (exclusive) and only disable PTM if that is the case.  It is
> > pointless to disable PTM for devices in D3cold and it may be harmful
> > for devices that are left in D0.
>
> "... it may be harmful for devices that are left in D0" -- I want to
> understand this better.  It sounds like nvme_suspend() leaves the
> device in some device-specific low-power flavor of D0, and subsequent
> config accesses take it out of that low-power situation?

That's my understanding of it.

> If that's the case, it sounds a little brittle.  I don't think it's
> obvious that "pci_dev->state_saved was set by the driver" means "no
> config accesses allowed in pci_pm_suspend_noirq()."

Well, yes and no.  The device may be in D3cold then, so
pci_pm_suspend_noirq() should at least check that before accessing its
config space.

> And pci_pm_suspend_noirq() calls quirks via pci_fixup_device(), which are
> very likely to do config accesses.
>
> Maybe PTM needs to be disabled earlier, e.g., in pci_pm_suspend()?  I
> don't think PTM uses any interrupts, so there's probably no reason
> interrupts need to be disabled before disabling PTM.

That certainly is worth investigation.  For one, I don't see any
obvious downsides of doing so.
