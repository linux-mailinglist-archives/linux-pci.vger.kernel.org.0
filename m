Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FE03B0567
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 15:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhFVNDs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 09:03:48 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:47000 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhFVNDr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 09:03:47 -0400
Received: by mail-ot1-f47.google.com with SMTP id v5-20020a0568301bc5b029045c06b14f83so4568706ota.13;
        Tue, 22 Jun 2021 06:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NcTRL4wccrHi9sSWNz57LOOjn+N0AxIofL4KbJc/ig=;
        b=rKKVuilxw5h291EJ82tyWC/8Px5Syo8ekdVf6odHwLwC11nknd/afhQoeYax5hZzHM
         c5JwPaLLjnQp0lCEeGjX4AQiUx+MYfw0546sVjKhhojUaK489k1qyayWenDxlk0nCnyA
         oQDnOPlusPVcAasOlVMhd0DpLrQoduHYwUrPQPO85TKppYBQuXbin+de72go8hbP7zUm
         hsiHDTp1KAVvPpM6RSdcvLXIJ13YmtXxg/Y/bseMG++N2rfNJk2j/tHjfuGVIC/6nolT
         Nus5Ibyd31rtl5M8kQKz3EyOlgR5uzg6585ti0iX7dSJZVIyBwuXKoS7B+/EfMuZdbJq
         03cw==
X-Gm-Message-State: AOAM530Bm06KOFUN83IWWUTXtlePdS/VU7EIc/cqu32X8rjVEA6BWRJE
        eb7rwBc5orxs3egWTy1vVHeTmbySfl9LB4Q5bHM=
X-Google-Smtp-Source: ABdhPJyKjHV3+esCsGlGeaN8t/I0yIGGj7Mdq25BoUCBh0UMOhrGtyHSGG83n+tY6Xh4X8RnJRiv35gNDnwtVaZXuqs=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr3176695otb.206.1624366891596;
 Tue, 22 Jun 2021 06:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0gkETL83rm71LiJ8sed=UFn00_Sss8wJ20-+KQiJR0hew@mail.gmail.com>
 <20210622125802.GA3323179@bjorn-Precision-5520>
In-Reply-To: <20210622125802.GA3323179@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jun 2021 15:01:20 +0200
Message-ID: <CAJZ5v0j9GS2y0tpnzaGu8n9=kbHD9QkBUDguANcJz01u+PX08g@mail.gmail.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 213481] e1000e
 hardware failure due to PCI patch in all kernels 5.10.36+ with Intel I219-V]
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael <phyre@rogers.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 22, 2021 at 2:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 22, 2021 at 02:21:06PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jun 22, 2021 at 12:02 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > FYI.  Looks like 4514d991d992 ("PCI: PM: Do not read power state in
> > > pci_enable_device_flags()") appeared in v5.13-rc1, so it would be nice
> > > to fix before v5.13.
> >
> > I think let's revert it for now and revisit.
>
> Sounds good.
>
> > Do you want me to push the revert?
>
> Sure, it'd be great if you could.  I'm traveling and don't have as
> much time as usual this week.  Thanks!

Will do, thanks!
