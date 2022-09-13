Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3495B6946
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 10:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiIMINz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 04:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiIMINy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 04:13:54 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3845A883;
        Tue, 13 Sep 2022 01:13:53 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3452214cec6so130678717b3.1;
        Tue, 13 Sep 2022 01:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9sLM6RJy6I6JLzRHcKSPJWKNKk6jtaeZF6Edx/6Pve0=;
        b=XQq80t0mRs7BMUFpptwTiRk5uHA3ZvE5hGeH3oKUTdenbKqr0+9o0ZNZw09ptfSIUB
         hUrAYFOoF9DplpkPh8SxTvSU29cxcK8Byw8ys9bfDg2W1anol1L7tAjT1UXzAjlmooGx
         I5fZyxPJj3J0KDys8dKkp4vUvZmYNkgNV6zQDnOqIPjDm8B00EumQrA2Z4UW+6kjKwjW
         E88HqMfrZQZMmZcPs6uFXsmdsNecNCLAQh6nimqTNoYlg2PM4Jn+zXWBlOeg9MS/uWaY
         Etni99U+V556j4ZC5c/w8vyzRnZ37npENnDO0YTu5czZiXH/H//A18aP8s0KsMRUoVEa
         Zv3g==
X-Gm-Message-State: ACgBeo2NSnEpdSark038Sj+ppTUJruq430ilwUu9mxbnomVPX5FSBixi
        U0+JHYrQqdw3mt1j1iIO2R/Nj3KVMNOd38BNg4I=
X-Google-Smtp-Source: AA6agR5WgrB5LKptPjltFV5HyxgV+69DAbH09My27NgjzeNaXZIOdRzKMTvc3H0xqFCKSqucFzlUUG70Xy+qgJvpKsI=
X-Received: by 2002:a81:9407:0:b0:345:6683:d757 with SMTP id
 l7-20020a819407000000b003456683d757mr24666022ywg.326.1663056832590; Tue, 13
 Sep 2022 01:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <Yx6yl9jNu6S8xOJ+@black.fi.intel.com> <20220912203619.GA537411@bhelgaas>
In-Reply-To: <20220912203619.GA537411@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 13 Sep 2022 10:13:41 +0200
Message-ID: <CAJZ5v0g6EBwtT9B0tUNc05-N4XjMt0i0Cm2zO+uJAibV9FrxfQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] PCI/PM: Always disable PTM for all devices during suspend
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
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

On Mon, Sep 12, 2022 at 10:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Sep 12, 2022 at 07:16:23AM +0300, Mika Westerberg wrote:
> > On Fri, Sep 09, 2022 at 03:24:56PM -0500, Bjorn Helgaas wrote:
> > > Bjorn Helgaas (9):
> > >   PCI/PTM: Cache PTM Capability offset
> > >   PCI/PTM: Add pci_upstream_ptm() helper
> > >   PCI/PTM: Separate configuration and enable
> > >   PCI/PTM: Add pci_suspend_ptm() and pci_resume_ptm()
> > >   PCI/PTM: Move pci_ptm_info() body into its only caller
> > >   PCI/PTM: Preserve RsvdP bits in PTM Control register
> > >   PCI/PTM: Reorder functions in logical order
> > >   PCI/PTM: Consolidate PTM interface declarations
> > >   PCI/PM: Always disable PTM for all devices during suspend
> >
> > For the whole series,
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Thank you very much, Mika, Kuppuswamy, and Rajvi for your effort in
> reviewing and testing these.  I know that's a lot of work, and I
> really appreciate it.
>
> I put these on pci/pm together with Rajvi's pci_pm_suspend_noirq()
> simplification for v6.1.

Awesome, thanks!
