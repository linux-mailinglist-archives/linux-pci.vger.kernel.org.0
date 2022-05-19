Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0652352DD63
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 21:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbiESTBz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 15:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244390AbiESTBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 15:01:50 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3CE5E758;
        Thu, 19 May 2022 12:01:39 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id x2so10280059ybi.8;
        Thu, 19 May 2022 12:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgmliyXEshKe8ze3MsG0OI5BIXp5ouCTuj68lO/qhlY=;
        b=RL7Zpx9Q66dOKXdYty+Eeu+imhiKw0oUaZjuJ+/+yrOw/2Q1I1FCW6mR5V4pNpVKG3
         RogSRuFKsAJ6KsZ/vKBX3SOsuQgD70Iyfunxiu9PSk6kFNSsVn24QaN9m9TmhTq6ax5S
         p7VVEzeY+SMAuBaU7xkmlFlV04mn7nTpXun1UxMUin4KHqW26wYiZaqg2MiklPdfLDHH
         MeldO865uS94v3VSf9AAPgX40zd50oJgjauapBFfyXsSWD3OT7vodelSpu3uTN0YDY5B
         1gZHo+VCCEcd+n3593Txs3AkRyYIx+sN62H9Pr3x2iM6V9Dgtw3lvwziY5aRwUWklMNO
         TUWw==
X-Gm-Message-State: AOAM533REvuXxU5Ni5t6SwD/56ECQG0sCTdlMr/3oyM+campsbicN8Vk
        c7vgdUTxsU95jgSknxA07zcEnIhudDsRw3YV2lA=
X-Google-Smtp-Source: ABdhPJz/aC95/DqdsvnoW1dLX/SnlankeUa5x1s79FSxX7u2dMMW2V98Sq7Vh7q90OH3aOE7skOQkfRia0rPk2ZEeIE=
X-Received: by 2002:a25:d687:0:b0:64e:3a41:8d5 with SMTP id
 n129-20020a25d687000000b0064e3a4108d5mr5838382ybg.622.1652986898304; Thu, 19
 May 2022 12:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0g6GdKfN4b5uwHEhh4hBuG=haVHaXc-XuMQLe8Wd41Y3g@mail.gmail.com>
 <20220517144846.GA1068039@bhelgaas> <CAJZ5v0iNaAd=yP3DgDVVpffKU6kt+nSpPeqxWJyRddaX5K4FRA@mail.gmail.com>
 <92f32b4703091acb0aaf3f784be448d469e9e2fa.camel@linux.intel.com>
In-Reply-To: <92f32b4703091acb0aaf3f784be448d469e9e2fa.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 May 2022 21:01:27 +0200
Message-ID: <CAJZ5v0iHgtTpW+ox=wK68cnuG6D+KvFiOCh2UF96dxq08Z3BSA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
To:     David Box <david.e.box@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Jingar, Rajvi" <rajvi.jingar@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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

On Tue, May 17, 2022 at 8:05 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> On Tue, 2022-05-17 at 16:54 +0200, Rafael J. Wysocki wrote:
> > On Tue, May 17, 2022 at 4:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Mon, May 16, 2022 at 10:59:32PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, May 16, 2022 at 10:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Fri, May 13, 2022 at 10:00:48PM +0000, Jingar, Rajvi wrote:
> > > > > > > -----Original Message-----
> > > > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > > Sent: Thursday, May 12, 2022 11:36 AM
> > > > > > > To: Rafael J. Wysocki <rafael@kernel.org>
> > > > > > > Cc: Jingar, Rajvi <rajvi.jingar@intel.com>; Wysocki, Rafael J
> > > > > > > <rafael.j.wysocki@intel.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > > > > > > David Box
> > > > > > > <david.e.box@linux.intel.com>; Linux PCI <linux-pci@vger.kernel.org>;
> > > > > > > Linux
> > > > > > > Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux PM <linux-
> > > > > > > pm@vger.kernel.org>
> > > > > > > Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to
> > > > > > > disable PTM
> > > > > > >
> > > > > > > On Thu, May 12, 2022 at 07:52:36PM +0200, Rafael J. Wysocki wrote:
> > > > > > > > On Thu, May 12, 2022 at 7:42 PM Bjorn Helgaas <helgaas@kernel.org>
> > > > > > > > wrote:
> > > > > > > > > On Thu, May 12, 2022 at 03:49:18PM +0200, Rafael J. Wysocki wrote:
> > > > > > >
> > > > > > > > > > Something like this should suffice IMV:
> > > > > > > > > >
> > > > > > > > > > if (!dev_state_saved || pci_dev->current_state != PCI_D3cold)
> > > > > > > > > >
> > > > > > > > > >         pci_disable_ptm(pci_dev);
> > > > > > > > >
> > > > > > > > > It makes sense to me that we needn't disable PTM if the device is
> > > > > > > > > in
> > > > > > > > > D3cold.  But the "!dev_state_saved" condition depends on what the
> > > > > > > > > driver did.  Why is that important?  Why should we not do the
> > > > > > > > > following?
> > > > > > > > >
> > > > > > > > >   if (pci_dev->current_state != PCI_D3cold)
> > > > > > > > >     pci_disable_ptm(pci_dev);
> > > > > > > >
> > > > > > > > We can do this too.  I thought we could skip the power state
> > > > > > > > check if dev_state_saved was unset, because then we would know
> > > > > > > > that the power state was not D3cold.  It probably isn't worth
> > > > > > > > the hassle though.
> > > > > >
> > > > > > We see issue with certain platforms where only checking if device
> > > > > > power state in D3Cold is not enough and the !dev_state_saved check
> > > > > > is needed when disabling PTM. Device like nvme is relying on ASPM,
> > > > > > it stays in D0 but state is saved. Touching the config space wakes
> > > > > > up the device which prevents the system from entering into low power
> > > > > > state.
> > > > >
> > > > > Correct me if I'm wrong: for NVMe devices, nvme_suspend() has already
> > > > > saved state and put the device in some low-power state.  Disabling PTM
> > > > > here is functionally OK but prevents a system low power state, so you
> > > > > want to leave PTM enabled.
> > > > >
> > > > > But I must be missing something because pci_prepare_to_sleep()
> > > > > currently disables PTM for Root Ports.  If we leave PTM enabled on
> > > > > NVMe but disable it on the Root Port above it, any PTM Request from
> > > > > NVMe will cause an Unsupported Request error.
> > > > >
> > > > > Disabling PTM must be coordinated across PTM Requesters and PTM
> > > > > Responders.  That means the decision to disable cannot depend on
> > > > > driver-specific things like whether the driver has saved state.
> > > >
> > > > Setting state_saved generally informs pci_pm_suspend_noirq() that the
> > > > device has already been handled and it doesn't need to do anything to
> > > > it.
> > > >
> > > > But you are right that PTM should be disabled on downstream devices as
> > > > well as on the ports that those devices are connected to and it can be
> > > > done even if the given device has already been handled, so the
> > > > state_saved value is technically irrelevant.
> > > >
> > > > That's why I suggested to check if the power state is between D0 and
> > > > D3cold (exclusive) and only disable PTM if that is the case.  It is
> > > > pointless to disable PTM for devices in D3cold and it may be harmful
> > > > for devices that are left in D0.
> > >
> > > "... it may be harmful for devices that are left in D0" -- I want to
> > > understand this better.  It sounds like nvme_suspend() leaves the
> > > device in some device-specific low-power flavor of D0, and subsequent
> > > config accesses take it out of that low-power situation?
> >
>
> This is exactly what we see. It's not all machines, but in our lab we've seen in
> it on 3 production systems out of about 20. And they were all different
> generations, a 7th, 8th, and 10th gen.
>
> nvme_suspend is relying on NVMe APST / PCIe ASPM to put the device in a low
> power state. The link state will be L1 or deeper while the device remains in D0.
>
> https://nvmexpress.org/resources/nvm-express-technology-features/nvme-technology-power-features/
>
>
> > That's my understanding of it.
> >
> > > If that's the case, it sounds a little brittle.  I don't think it's
> > > obvious that "pci_dev->state_saved was set by the driver" means "no
> > > config accesses allowed in pci_pm_suspend_noirq()."
> >
> > Well, yes and no.  The device may be in D3cold then, so
> > pci_pm_suspend_noirq() should at least check that before accessing its
> > config space.
> >
> > > And pci_pm_suspend_noirq() calls quirks via pci_fixup_device(), which are
> > > very likely to do config accesses.
> > >
> > > Maybe PTM needs to be disabled earlier, e.g., in pci_pm_suspend()?  I
> > > don't think PTM uses any interrupts, so there's probably no reason
> > > interrupts need to be disabled before disabling PTM.
> >
> > That certainly is worth investigation.  For one, I don't see any
> > obvious downsides of doing so.
>
> We will look at this.

Appreciated.

In the meantime, I think that it would make sense to pick up the first
patch in this series which is a good cleanup regardless.

Bjorn, could you do that, please?
