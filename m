Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA68D1EA253
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 12:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgFAK7I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 06:59:08 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45310 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAK7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 06:59:08 -0400
Received: by mail-oi1-f194.google.com with SMTP id p70so3852985oic.12;
        Mon, 01 Jun 2020 03:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keLV8Gd9C9GRlhQTmWInhDyaWAHDTSmesa5VJ61KhzA=;
        b=Iwq0U5l30/QISPgqe5GgmwukfMZiUgKOx6QnPCciJLeHfI5t5pkzsj2MILdFG8y+Y3
         kkNfug1Tu7luwVu8YfCRM7lZ03gO+BMHt1vBFgwyg87IyojB+r9dgam2/aCTlkx2H19e
         FOubFxgYacwt72eUbiUGbhPRUz/iQ5a8EsgdULygvpnlwxm/wTMlHplO8Ny046QNlR3l
         mahvNtJwus0jRp7D6oueE5+RRFYb0z2UDxA7yOnmllAg31ZP8AJTMuZ2+H0B3sJInnSd
         Eu3kfLB5YGDu/7AmHjagNsxv/b470hIEz9rYtEvDeV8B//NL+a7CvOui1GfEAZpZ2FMu
         wo0A==
X-Gm-Message-State: AOAM532B49EQaSMBbuYmjq0jo8ow+E+ojP7gHoACIXgSadHtqq0UmTFH
        zxPVrA+uQQu13xApH1jvJM9/bWMycOMjxPKmmng=
X-Google-Smtp-Source: ABdhPJxKFI0X2eb7fOqmhHgAFLbKDxQT1bWtfSLhpslRIxFwL6VsL7FmOTE2aXhPfb3zKacj1e952K5zvKHjWjsWsjI=
X-Received: by 2002:a05:6808:486:: with SMTP id z6mr14374613oid.103.1591009146050;
 Mon, 01 Jun 2020 03:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <bdc33be8-1db6-b147-cbc4-90fa0dc3d999@gmail.com>
 <20200529202135.GA461617@bjorn-Precision-5520> <20200529205900.whx3mxuvt6ijlqwg@srcf.ucam.org>
 <824d63d8-668c-22c8-a303-b44e30e805e1@gmail.com> <20200529225801.szl4obsas6ndilz4@srcf.ucam.org>
 <7c8cab08-e2d4-1952-1923-aa023ea67657@gmail.com> <20200530071434.vjkqxfmgo7xpls6j@srcf.ucam.org>
 <20200530113344.GA2834@infradead.org>
In-Reply-To: <20200530113344.GA2834@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Jun 2020 12:58:49 +0200
Message-ID: <CAJZ5v0gxntUoxu70jpzsEHbytXwKC=EBsFD3y=0H6E0hLytybw@mail.gmail.com>
Subject: Re: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 30, 2020 at 1:34 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, May 30, 2020 at 08:14:34AM +0100, Matthew Garrett wrote:
> > On Sat, May 30, 2020 at 08:33:50AM +0200, Heiner Kallweit wrote:
> >
> > > It *was* default y. This changed with a914ff2d78ce ("PCI/ASPM: Don't
> > > select CONFIG_PCIEASPM by default") and that's what triggered the
> > > problem. If there's no easy solution, then maybe it's best to revert
> > > the change for now.
> >
> > Oh, sorry, I was looking at mainline. CONFIG_PCIEASPM should
> > *definitely* be enabled by default - platforms expect the OS to support
> > it. If we want to get rid of default y then I think it'd make more sense
> > to have a CONFIG_DISABLE_PCIEASPM that's under EXPERT, and people who
> > really want to disable the code can do so.
>
> I think the fact that the EXPERT didn't get removed in the above bug
> is a defintive bug.  But I'd go further and think the CONFIG_PCIEASPM
> option should be removed entirely.  There is absolutely no good reason
> to not build this small amount of code if PCIe support is enabled.

Well stated, thanks!
