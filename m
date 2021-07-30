Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657D43DB867
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 14:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbhG3MN1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jul 2021 08:13:27 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36815 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhG3MN1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jul 2021 08:13:27 -0400
Received: by mail-oi1-f179.google.com with SMTP id y18so12921321oiv.3;
        Fri, 30 Jul 2021 05:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/nWd7/gRGV1qmwqjSQqAFbq0T5N0Ue6f9xRmUkU8nE=;
        b=fBbJsZ2AERbldlv6Oni+QBQNC30lXFlL8WtLXR77069BvNv6//2Wg1hNFNUbjDOndv
         n15pOBidjrH96JR5JpIWrkqsLkATa8tuA4kaq258ZDn68bVjbmdE81BaDVMGX8aUhcTo
         YfSbfru4rYiG92d/ty5nZEh5U4F1em3pBXyKb/1PK5qhYWRa9SXtVYEdCd7UEDIQHIEG
         XPy8gBZTA5crfskNTPys8hpScLAht0ZAC8mspm4ygY0xAJBJk5Z4RoFcNgYm2/5AVsLt
         pI6tMSZgFrKLaWU9naBBhqcfC/u4/CGgm++CQKCO2DR/6knMqGGYu4Vm4vv6vQu8dhwO
         fEMA==
X-Gm-Message-State: AOAM532wWdg6BUIAxYRIhjA2KhLtVKeSUhAwdTQLj9HZHDbFkdiQrQ8g
        U8akIqgGI+YaWymXig+V6ANQ9ndOqMHzn9n6p68=
X-Google-Smtp-Source: ABdhPJz45M3knNhHMrzCYlaLNNR4m0GdsnXb7oHj0LtftPm2N3HMDgTHqU060pmcerIRLKGkOElBDfIUzpjvPVPoojY=
X-Received: by 2002:a05:6808:198c:: with SMTP id bj12mr1556667oib.71.1627647201379;
 Fri, 30 Jul 2021 05:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <4668274.31r3eYUQgx@kreacher> <1791325.tdWV9SEqCh@kreacher> <YQPUOgxldaqpxOxL@lahna>
In-Reply-To: <YQPUOgxldaqpxOxL@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Jul 2021 14:13:09 +0200
Message-ID: <CAJZ5v0gZ=Zk+RO_+=8hUtkeTgB9dHGcNVHsiTJdw_EZEsiKWSQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PCI: PM: Enable PME if it can be signaled from D3cold
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 30, 2021 at 12:28 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Jul 29, 2021 at 04:49:10PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > PME signaling is only enabled by __pci_enable_wake() if the target
> > device can signal PME from the given target power state (to avoid
> > pointless reconfiguration of the device), but if the hierarchy above
> > the device goes into D3cold, the device itself will end up in D3cold
> > too, so if it can signal PME from D3cold, it should be enabled to
> > do so in __pci_enable_wake().
> >
> > [Note that if the device does not end up in D3cold and it cannot
> >  signal PME from the original target power state, it will not signal
> >  PME, so in that case the behavior does not change.]
> >
> > Link: https://lore.kernel.org/linux-pm/3149540.aeNJFYEL58@kreacher/
> > Fixes: 5bcc2fb4e815 ("PCI PM: Simplify PCI wake-up code")
> > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Also this solves the reported issue so,
>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you!

I'll queue up these two patches for 5.15 barring any objections from Bjorn.
