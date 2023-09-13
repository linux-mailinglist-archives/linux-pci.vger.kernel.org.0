Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FA579E1BC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 10:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbjIMIOS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Sep 2023 04:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbjIMIOR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 04:14:17 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B36A1729;
        Wed, 13 Sep 2023 01:14:13 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3a9e49495ddso643179b6e.1;
        Wed, 13 Sep 2023 01:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694592852; x=1695197652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnSAOSHIBJbqxMtsOgmwPFLCipyOoc3+qm5hsWXanew=;
        b=BLWYHPxY7YGi2ySxx70vkHHA4nhpO0Ty9z2tRPXYZoTHUkK66hufM2LkIMSDqKi1Jc
         g76BEDGveeK+aFi73k/zbzeHBgPDsdbULbAveiQMxRtGxxz+HyzdwgjcnIN+ecA7VPlf
         E/vfR63xbnu5czcK40+YYK6jTpGCqSwAYJrfTgnhR1fAhsr1/qf5eZqp8i/mK1Mb7Ucs
         cLm5ACx5WRpG8zvZsIepcJl3JXcYTLw3v6t3oelDXbaEOErJosMo5W3T1tSqz2WKwGKZ
         o0bz0yPBcCgTQ1R40FLM/9+k8IqscBywHpE0wUOfBvOfXvBVShea8SXpzHb6dat01D3O
         19pQ==
X-Gm-Message-State: AOJu0YwF2R2WfwgdSabWg7rfBHGitB0LmqKtB0vGypOLqlrt7CZvD/8H
        8XWneA48ullBTHP7tkrn7X17yJGF5fo708qkUko=
X-Google-Smtp-Source: AGHT+IHC87tUXlU8UTe5IOrC3jQqtG+BAepY8MyKyNF/xGAPiqwCbHrLA9RUsVvoBqrpJNiLHtjmG0jv8ctPlDrx9go=
X-Received: by 2002:a05:6808:4492:b0:3a9:e85d:b689 with SMTP id
 eq18-20020a056808449200b003a9e85db689mr2216268oib.0.1694592852656; Wed, 13
 Sep 2023 01:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230913040832.114610-1-mario.limonciello@amd.com>
 <20230913040832.114610-3-mario.limonciello@amd.com> <20230913042522.GB1359@wunner.de>
 <fd981219-d864-4c46-a348-61f73a9df596@amd.com>
In-Reply-To: <fd981219-d864-4c46-a348-61f73a9df596@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Sep 2023 10:14:00 +0200
Message-ID: <CAJZ5v0jkw9W-DtyKvHjtYwP8rBkg1gT_Dcugp9Nt4hpSK5DE4w@mail.gmail.com>
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4 controllers
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 6:44 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 9/12/2023 23:25, Lukas Wunner wrote:
> > On Tue, Sep 12, 2023 at 11:08:32PM -0500, Mario Limonciello wrote:
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -2752,6 +2752,11 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
> >>      if (target_state == PCI_POWER_ERROR)
> >>              return -EIO;
> >>
> >> +    /* quirk to avoid setting D3 */
> >> +    if (wakeup && dev->dev_flags & PCI_DEV_FLAGS_NO_WAKE_D3 &&
> >> +       (target_state == PCI_D3hot || target_state == PCI_D3cold))
> >> +            target_state = PCI_D0;
> >> +
> >>      pci_enable_wake(dev, target_state, wakeup);
> >>
> >>      error = pci_set_power_state(dev, target_state);
> >
> > Would it be possible to just add the affected system to
> > bridge_d3_blacklist[]?
>
> It's initially reported on Lenovo Z13, but it affects all Rembrandt and
> Phoenix machines that have USB4 controller enabled.
>
> It's reproduced on every OEM system I have access to.
>
> >
> > Or would that defeat power management of other (non-affected)
> > Root Ports in the same machine?
> >
> > There's already PCI_DEV_FLAGS_NO_D3, would it be possible to just
> > reuse that instead of adding another codepath for D3 quirks?
> >
>
> The root port can handle D3 (including wakeup) at runtime fine.
> Issue occurs only during s2idle w/ hardware sleep.
>
> In v16/v17 (see cover letter for links) Rafael suggested to tie this
> specifically to suspend behavior and when wakeup flag is set.

Right, it is not necessary to avoid D3 on those ports for PM-runtime
and when there are no system wakeup devices underneath.

> I didn't think it was appropriate to overload the existing flag because
> of this difference.

I agree.
