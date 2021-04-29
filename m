Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D247836EE7D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 19:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhD2RBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 13:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbhD2RBH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 13:01:07 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357B7C06138D
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 10:00:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b21so4812774ljf.11
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0HDs304V6rBQyJsC5AJ9JCDtTKnf5YiKXTX64eRPok=;
        b=ExZEkvb48KmMdff51m5EllB7RqJi7o96Jtn3zE3fRmXGBVkDfzxzZmLnWIq5F+BdEM
         q6cz07f9ztPJ3Y+jdlGik9OM0RnI/rho9TYwV1UhXhrBQA6aDsNZTG7hRI26Qc0ryVgj
         gQavAami2VG0lmlSiImr4AagqgDrhqmLkFypq6RtwXc83dhxlenMhB+LDhHVLNIMURfI
         fTSEu8MjopjkR03N++XlTEGNOFm1cTZu1KKiLdMtCngzZHV6ntqCm1+Hop9fah1h5JbZ
         Zsm2slRg6nDEOwvT6Zr/IdzMWQW9c4v0uSIKofH2VEpAtrDCEOAnIkyePqrkjvIveyFP
         Da2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0HDs304V6rBQyJsC5AJ9JCDtTKnf5YiKXTX64eRPok=;
        b=GYvQK383aYX4nnRYhSdbm9WdpjEXvctffmCDKotFlCLNbDNH6+mFZcW7TmbvQQmPIM
         mdeJ+pfdULhql/NUE4/eU4YJtqV6O8YTodo52OCfDC1GwvFXXJLmxNtSbXpEeGa5cE8t
         nhCU0yvwNorSj5W8Km/6w7T27igMFr2tIV7NPlw4vVAX43vobdQb7TGeNALHv+0ltLpu
         4QvotcZJqfV5aKZQCNo6HRUPxhwnhWa7W8v4JfmYx/TuG7jEqunWCJ5XURTCb+j8LaJg
         RuSllv6vhfdeEEyWmBCVOruHCcRhUfkl16uMMELZWiWRVMLgSPTC8mi3aIrQwuJw2cEs
         +f2w==
X-Gm-Message-State: AOAM530Zm4ah/94Mvuh9uJ5mDqfv25jYSBFkoF8dMcf2tS5CFXz0WneO
        OJ/MFDzVCAzYY1DgKYorjkxlxSumPdDnA61mWidNXA==
X-Google-Smtp-Source: ABdhPJw+ESSs7VTM3JdnNUYO1nFYP+5xozFj+wC6Na197QlKwaCYJN5flP6NE6Ly3ROztBiNyG6qGBwyM8dd8acjBKQ=
X-Received: by 2002:a05:651c:50b:: with SMTP id o11mr431200ljp.323.1619715617399;
 Thu, 29 Apr 2021 10:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210424021631.1972022-1-rajatja@google.com> <20210424021631.1972022-2-rajatja@google.com>
 <d53c72949d81db9f092a9aecb49bf56b47727738.camel@suse.com> <CAJZ5v0iNrSFjhmTE8K-JrO07kJon3ikhatbg0Jg2hs+x-frDJg@mail.gmail.com>
 <79b994f2476249498797e1784f735fd7@AcuMS.aculab.com> <21c6b5002c5ad36cd7fe0bb849f5eba12a614bca.camel@suse.com>
 <b5e031652f144ab6accbe553566676c9@AcuMS.aculab.com> <0601e45130495b152bec04eee4a50e302db4cfd2.camel@suse.com>
 <CAJZ5v0jEbjRSGPdfwvegawin5_N=m-UoP+Wa99EQ-QmkusiBCg@mail.gmail.com>
 <5ac7634acbe7569879234ad541879c79918f3e00.camel@suse.com> <CAJZ5v0jF1M95MJO+gGL2rmk=rmt5u0sYR-DCJW4+Bb5WP+3W7w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jF1M95MJO+gGL2rmk=rmt5u0sYR-DCJW4+Bb5WP+3W7w@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 29 Apr 2021 09:59:39 -0700
Message-ID: <CACK8Z6E_zbUguY2qUE5Jbgzj3fwcQ_xMVxHYs_VeY5Hm=S4zGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pci: Support "removable" attribute for PCI devices
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        David Laight <David.Laight@aculab.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 29, 2021 at 2:58 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Apr 29, 2021 at 11:03 AM Oliver Neukum <oneukum@suse.com> wrote:
> >
> > Am Mittwoch, den 28.04.2021, 14:21 +0200 schrieb Rafael J. Wysocki:
> >
> > > In principle, in the wake of Thunderbolt every PCI driver handling
> > > PCIe devices needs to be able to deal with a device that's gone away
> > > without notice, because in principle any PCIe device can be included
> > > into a Thunderbolt docking station which may go away as a whole
> > > without notice.
> >
> > Yes, but we are dealing with what we export to user space, don't we?
>
> Right, so it would be good to know why exporting this information to
> user space is desired.

For us, the driving motivation is to implement policies in userspace
for user removable devices. Eg:

* Tracking the statistics around usage of user removable devices (how
many users use such devices, how often etc).
* Removing user removable devices when a user logs out.
* Not allowing a new user removable device while the screen is locked.
* (perhaps additional such policies in future).

Thanks,

Rajat
