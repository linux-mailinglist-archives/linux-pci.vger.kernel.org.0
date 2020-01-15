Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD3713CE03
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 21:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgAOUUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 15:20:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39592 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOUUb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 15:20:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so17000491wrt.6
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2020 12:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhQGA9v5B9UO5Q9PGnqpCtSgKgbmPkCZlk7QHpjWWGc=;
        b=MrPqp7EJN7qxuTYtKPPeNcmJjla3Vm6l/XtIW0uudLOBZZTCVmOC6v9m4OgW5JNOMh
         C9fkTg3t1xEVJd0sUCrGUe4UYuQnQ+pZX7ZTUASxn5kGcN/adby3Slwa/wrZ8N2uDgMf
         YPpbdpMcTEwd4yfEZ8k12k/YyLJLJEQkY6R0r/ecWIjdvt/Vc7LcT+fF1PTh4XZNokhR
         s5kBegJ4STu/Uq2Ye5pUEBfRIjlIjzDIRDQW1XAPHfIWKX9Uczh7zQK1UvLCpN7f0gwn
         q/RwPu+GcKkNnwx+ixAv2gZZUzErbIh9A0sPJWdV5dPCa7NjV65jpmNqLNbtsxF3bN9o
         Ssyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhQGA9v5B9UO5Q9PGnqpCtSgKgbmPkCZlk7QHpjWWGc=;
        b=QVCszYA7tbrlHSoa9lAtrGTqv1+pNKk8sqWHFRKksMT1wJUTpn2XyMK833T7Dkx+C/
         /DsN1b/j4i2Ms1GHaaOukqlTVqtfYS6HUB1arVAT8U0oL4ArGvRr5bXFUl4XtgA2XiIu
         IUX+m4zx8qzpuzi3yLX2wXIUdnc0ADNSsE0KUEjVMS2v5gZCXKUveulzZbBBBCDmRp1+
         iT8wiy0HOb0F/xGAjwdSU3A1gpQ5v8oJfI7cXGZ6mGPoa/l/C1Z8pL5cI5UM7Jupuqo+
         NuFhY5p2gaN0mu04j35kZkUQdnrbKVEiUiGmFY6VSnYT4loPbvKr8KhMrXVUeon3MO0B
         5xcw==
X-Gm-Message-State: APjAAAXrwtYCsyzV0GdlbaQkvar26ItXJrhCXMovaCCzOY97wf55jaNG
        PJVHLPfSs4wNHnZWOkEltzkRnpBSHV1svWYV7E2+3Q==
X-Google-Smtp-Source: APXvYqyHJ0fOjvdMpd/sLykUjdcL5D5L6PvlsNRUAnQKLbU8jCLgzkOCrjcj84KwDIe8qaTtqTY3AqsnFBv5RldE40o=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr33400269wrn.50.1579119629699;
 Wed, 15 Jan 2020 12:20:29 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_Onw1JgtAYiJgkdL55pe5UdVaJ7j-Tmj3THikWEs-nbkQ@mail.gmail.com>
 <20200115201738.GA190184@google.com>
In-Reply-To: <20200115201738.GA190184@google.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 15 Jan 2020 15:20:18 -0500
Message-ID: <CADnq5_MbiwYBNj5tB9=Dwj02Mi4GwJ7_5uBtx+8RkOdfC5HqLw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Adjust AMD GPU ATS quirks
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 3:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jan 15, 2020 at 12:26:32PM -0500, Alex Deucher wrote:
> > On Wed, Jan 15, 2020 at 12:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Jan 14, 2020 at 05:41:44PM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Jan 14, 2020 at 03:55:21PM -0500, Alex Deucher wrote:
> > > > > We've root caused the issue and clarified the quirk.
> > > > > This also adds a new quirk for a new GPU.
> > > > >
> > > > > Alex Deucher (2):
> > > > >   pci: Clarify ATS quirk
> > > > >   pci: add ATS quirk for navi14 board (v2)
> > > > >
> > > > >  drivers/pci/quirks.c | 32 +++++++++++++++++++++++++-------
> > > > >  1 file changed, 25 insertions(+), 7 deletions(-)
> > > >
> > > > I propose the following, which I intend to be functionally identical.
> > > > It just doesn't repeat the pci_info() and pdev->ats_cap = 0.
> > >
> > > Applied to pci/misc for v5.6, thanks!
> >
> > Can we add this to stable as well?
>
> Done!  Do you want it in v5.5?  It's pretty localized so looks pretty
> low-risk.

Sure.  Thanks!

Alex
