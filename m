Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957672B6B24
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 18:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgKQRIe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 12:08:34 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37621 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgKQRIe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 12:08:34 -0500
Received: by mail-oi1-f195.google.com with SMTP id m17so23359562oie.4;
        Tue, 17 Nov 2020 09:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AL1xSYp2gyfSOi6pekmECFPt18SndW3oAy1PcApXrAk=;
        b=EMFch2NfBtP9llmYGFPd0+q08gJjQCLDVnSbwp7ks2JEF6Gh3jJxfZO/i2vJ1eP+IR
         oGh6jTXKcOLVjxoHUsqmgCtYM+Sklopnu4f3RUIthXduen9NX4YrZuzf/z3DJ3noevnj
         bPX2F8G7Yux+soXnCgLgwp6loDUPW7M64s6ApIykxJMWOo7yjvkz+auwaP0SuJhOiGDb
         C7w7nIVzwfqyiyCRcQeTDViDnTblz06Wxq3TCpItPihlh+yT9MubauzrGZGm4Uld17lk
         EJNBQ1bQ1NUMfTUaJ36j1yMZnAVY4sPildDod+wb94ALNaVeFHMU/4d2DtPxu5WVjFaS
         Wefw==
X-Gm-Message-State: AOAM531dbQCDQ+/Aw8omZQE+HSlblUHPJZ1rqP3iLhjVQfkpkCMi/VSV
        5NxNUQ1CeziUv4i1u3+CihUnavyrWKRmFQXpRL8=
X-Google-Smtp-Source: ABdhPJxbxTcA9HVbedXOHbNt9M8eAGYKqz4vu12wjxfkv2kCIaIICgzjNhP+HsN9h1b91BUztlMYLwWFJP7i8hG3ke0=
X-Received: by 2002:aca:cf4b:: with SMTP id f72mr29963oig.157.1605632913518;
 Tue, 17 Nov 2020 09:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
 <20201116165159.GE4077@smile.fi.intel.com> <CAJZ5v0hL2Pbus-U6i4nGaf1rwWNq6ZosVL6N2bwDiFw7W8tOEw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hL2Pbus-U6i4nGaf1rwWNq6ZosVL6N2bwDiFw7W8tOEw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Nov 2020 18:08:22 +0100
Message-ID: <CAJZ5v0ip53BeCO-z2XxrWVvQ37X8HLF+jGtMZUp917cGW9MtTg@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] resource: introduce union(), intersection() API
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 5:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Nov 16, 2020 at 5:51 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Nov 03, 2020 at 10:45:03PM +0200, Andy Shevchenko wrote:
> > > Some users may want to use resource library to manage their own resources,
> > > besides existing users that open code union() and intersection()
> > > implementations.
> > >
> > > Provide a generic API for wider use.
> >
> > Greg, Rafael, if there is no further comments, can it be applied?
>
> I don't have any. so I can take this series if there are no concerns from Greg.

No concerns mentioned, so applied as 5.11 material, thanks!
