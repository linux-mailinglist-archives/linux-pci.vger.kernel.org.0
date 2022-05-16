Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52BB52929D
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 23:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349255AbiEPVMx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 17:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349863AbiEPVLv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 17:11:51 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D411FA61;
        Mon, 16 May 2022 13:59:44 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2fee9fe48c2so45665917b3.3;
        Mon, 16 May 2022 13:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8CuZFsnTOi32M4APK7fICwRmlRzyWraAOnG9eilkyo=;
        b=jLQWTnfFKtrSqFaqll7upzyWIWIuSopUONa3xYqrH4bXL/fI3yAyFlcjmfGnpyqAOj
         womYBTP+CExHEogIe1+59c7j7c9XQN3FX0IIE81Wops1vj7WRWm8ARvKxIu6XTJerbEQ
         TYlv6nnDCGjYRC1oQINXtgY4zxzQhYqMUJzhqb2LdK5Kv45+S7eMMY2tdGxgMP9oUDpG
         KiNaw3lHjYqo8aI/I4sKUe8924awtqOtM3T4dvTY7aL4V6OBUe8vPvCgyi97lptmfmtX
         5wxlp78E/IssiqeV0YOzV59gkvXL5YveVcPEEK8vcjSgIt6msj7/1MpjBgfVzjrNF/1I
         DyOA==
X-Gm-Message-State: AOAM530m5bRgTRET/gEB6DADpuSk+BzQkQWUaxEPZo/+y6mZ4I2TNmyE
        s432g4+FGPV6Ch8oJL1HklUrXYxfoXoyKyLydGgCngxF0/s=
X-Google-Smtp-Source: ABdhPJxKhTbm4KUGm4E639zehLL3oGJVzd+DOuaL3l/fDv4EecMJc90THrk+O6ZSiJ+y9oKlD0rCncRNi3iCskiwqB8=
X-Received: by 2002:a81:260a:0:b0:2f4:ca82:a42f with SMTP id
 m10-20020a81260a000000b002f4ca82a42fmr22397134ywm.149.1652734783486; Mon, 16
 May 2022 13:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR11MB5070B095B8A28634B43A231F9ECA9@SJ0PR11MB5070.namprd11.prod.outlook.com>
 <20220516200927.GA1046452@bhelgaas>
In-Reply-To: <20220516200927.GA1046452@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 May 2022 22:59:32 +0200
Message-ID: <CAJZ5v0g6GdKfN4b5uwHEhh4hBuG=haVHaXc-XuMQLe8Wd41Y3g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Jingar, Rajvi" <rajvi.jingar@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Mon, May 16, 2022 at 10:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, May 13, 2022 at 10:00:48PM +0000, Jingar, Rajvi wrote:
> >
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Thursday, May 12, 2022 11:36 AM
> > > To: Rafael J. Wysocki <rafael@kernel.org>
> > > Cc: Jingar, Rajvi <rajvi.jingar@intel.com>; Wysocki, Rafael J
> > > <rafael.j.wysocki@intel.com>; Bjorn Helgaas <bhelgaas@google.com>; David Box
> > > <david.e.box@linux.intel.com>; Linux PCI <linux-pci@vger.kernel.org>; Linux
> > > Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux PM <linux-
> > > pm@vger.kernel.org>
> > > Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
> > >
> > > On Thu, May 12, 2022 at 07:52:36PM +0200, Rafael J. Wysocki wrote:
> > > > On Thu, May 12, 2022 at 7:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Thu, May 12, 2022 at 03:49:18PM +0200, Rafael J. Wysocki wrote:
> > >
> > > > > > Something like this should suffice IMV:
> > > > > >
> > > > > > if (!dev_state_saved || pci_dev->current_state != PCI_D3cold)
> > > > > >
> > > > > >         pci_disable_ptm(pci_dev);
> > > > >
> > > > > It makes sense to me that we needn't disable PTM if the device is in
> > > > > D3cold.  But the "!dev_state_saved" condition depends on what the
> > > > > driver did.  Why is that important?  Why should we not do the
> > > > > following?
> > > > >
> > > > >   if (pci_dev->current_state != PCI_D3cold)
> > > > >     pci_disable_ptm(pci_dev);
> > > >
> > > > We can do this too.  I thought we could skip the power state
> > > > check if dev_state_saved was unset, because then we would know
> > > > that the power state was not D3cold.  It probably isn't worth
> > > > the hassle though.
> >
> > We see issue with certain platforms where only checking if device
> > power state in D3Cold is not enough and the !dev_state_saved check
> > is needed when disabling PTM. Device like nvme is relying on ASPM,
> > it stays in D0 but state is saved. Touching the config space wakes
> > up the device which prevents the system from entering into low power
> > state.
>
> Correct me if I'm wrong: for NVMe devices, nvme_suspend() has already
> saved state and put the device in some low-power state.  Disabling PTM
> here is functionally OK but prevents a system low power state, so you
> want to leave PTM enabled.
>
> But I must be missing something because pci_prepare_to_sleep()
> currently disables PTM for Root Ports.  If we leave PTM enabled on
> NVMe but disable it on the Root Port above it, any PTM Request from
> NVMe will cause an Unsupported Request error.
>
> Disabling PTM must be coordinated across PTM Requesters and PTM
> Responders.  That means the decision to disable cannot depend on
> driver-specific things like whether the driver has saved state.

Setting state_saved generally informs pci_pm_suspend_noirq() that the
device has already been handled and it doesn't need to do anything to
it.

But you are right that PTM should be disabled on downstream devices as
well as on the ports that those devices are connected to and it can be
done even if the given device has already been handled, so the
state_saved value is technically irrelevant.

That's why I suggested to check if the power state is between D0 and
D3cold (exclusive) and only disable PTM if that is the case.  It is
pointless to disable PTM for devices in D3cold and it may be harmful
for devices that are left in D0.
