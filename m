Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3137FFCB
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 23:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhEMV3W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 17:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhEMV3V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 17:29:21 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D0EC06174A
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 14:28:11 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u1so14524670qvg.11
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 14:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fmvdoLSgkwi/R8QI7xytbFJUtHDfK5QUMvGfMxvQfx0=;
        b=eX7A9nTtBGalDd1gTAkKERuDhVN3exKSkMAgk0rA87PLkpTyaboAeZGX5bFpV2PqiO
         wMDnGLgLIhaffXaHR3il3z+0sNmxUsK1GxVDua5Wd5hOqpniDidbMe3oTKLiWfJE9k0R
         j7Jy28hCMn+EDTUEG9WeSHoFw6sp8LWH9fub5T87hgkWz02GIqofJfznd6MBCNB9Vsyh
         bYRKSAJcvu+lI79mc71BJsfr8zslFSzAp7J4oDhyOyiuTulCuV2CetcrrZVaAT0N9mCj
         p8UpLVDehbzaEt2f4wi86zX4yjeptKI3T6L2KFa4oQgb/PkEBKugSrWOyNzP/ineNf1b
         vnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmvdoLSgkwi/R8QI7xytbFJUtHDfK5QUMvGfMxvQfx0=;
        b=TohJPqPu6PXvdXGQ0L011H4bQrRUgw0j/3r1OT/t7VDuTz87LUXkSGevfHlz3O7U5j
         WcEDkfx//7FKo4sYdvKo+BNDzI7wHyoJzfDpCPrxbal+1JEUec25lPbTFRSx7y2wAqLa
         0sBPAuvWvBIIkmzZhth1Tc/5h54merqFr6SBWbGN3UYbAJeGyuthehaOvZBSNHSFO7JM
         DULQQ55iX7DYnLLdJ9P2Q/uQZKcH6ZbK8JKmlkW31XJRaPvV/gVnw+Jb6WuzVeAnbBSt
         TQXCsZAS1j51jw8pnVZLYLv5/g7K194FQy858UaeQGBbxpaZ0OD2xQhKjfSZxVoM5xM5
         PBgw==
X-Gm-Message-State: AOAM532i33MCVj8ON5gCzqKLLD3OLJHoNzeO5ShLv0Nl0x20wUhk08fD
        LEwdIU5AvzEP7FKBCwjWvsVbzSeZoJWPLHK0jppTIg==
X-Google-Smtp-Source: ABdhPJzSWgo/fT0b5/gVIzR8fNNVEepfHgJIvqXjyp8Cng77w/FmLAf+U/pc5NFzixC4yrMvTCWeu8oqd4th3G1KSE0=
X-Received: by 2002:ad4:518a:: with SMTP id b10mr43153800qvp.19.1620941290413;
 Thu, 13 May 2021 14:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210326161247.GA819704@bjorn-Precision-5520> <YF8NGeGv9vYcMfTV@kroah.com>
In-Reply-To: <YF8NGeGv9vYcMfTV@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 May 2021 14:28:01 -0700
Message-ID: <CAPcyv4iepHgyfruQVi9xNYfrD=7fAQfU=mCeYzcfDSNkASz5vQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Allow drivers to claim exclusive access to config regions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 27, 2021 at 3:47 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 26, 2021 at 11:12:47AM -0500, Bjorn Helgaas wrote:
> > [+cc Christoph]
> >
> > On Wed, Mar 24, 2021 at 06:23:54PM -0700, Dan Williams wrote:
> > > The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
> > > configuration cycles. It assumes one initiator at a time is
> > > reading/writing the data registers. If userspace reads from the response
> > > data payload it may steal data that a kernel driver was expecting to
> > > read. If userspace writes to the request payload it may corrupt the
> > > request a driver was trying to send.
> >
> > IIUC the problem we're talking about is that userspace config access,
> > e.g., via "lspci" or "setpci" may interfere with kernel usage of DOE.
> > I attached what I think are the relevant bits from the spec.
> >
> > It looks to me like config *reads* should not be a problem: A read of
> > Write Data Mailbox always returns 0 and looks innocuous.  A userspace
> > read of Read Data Mailbox may return a DW of the data object, but it
> > doesn't advance the cursor, so it shouldn't interfere with a kernel
> > read.
> >
> > A write to Write Data Mailbox could obviously corrupt an object being
> > written to the device.  A config write to Read Data Mailbox *does*
> > advance the cursor, so that would definitely interfere with a kernel
> > user.
> >
> > So I think we're really talking about an issue with "setpci" and I
> > don't expect "lspci" to be a problem.  "setpci" is a valuable tool,
> > and the fact that it can hose your system is not really news.  I don't
> > know how hard we should work to protect against that.
>
> Thanks for looking this up and letting us know.
>
> So this should be fine, reads are ok, it's not as crazy of a protocol
> design as Dan alluded to, so the kernel should be ok.  No need to add
> additional "protection" here at all, if you run setpci from userspace,
> you get what you asked for :)
>

Circling back to this after thinking of the implications and looking
at the review of the DOE code, this situation is different than your
typical "userspace gets to keep the pieces if it does a configuration
write". If we assume well behaved non-malicious userpace, it has no
reason to muck with critical config registers. If userspace changes a
BAR value and the system fails, yup, that's its own fault. The DOE
mailbox is different. There are legitimate reasons why non-broken
userspace would want to read some DOE payloads while the kernel is
retrieving its payloads. It also simplifies the kernel implementation
if it does need to worry about other agents interrupting its
transfers. My mistake was making this restriction apply to reads, but
I'm not on the same page that blocking writes is fruitless just
because userspace can do other damage with config writes.

So either the kernel DOE driver needs to use pci_cfg_access_lock() and
revalidate the state of the DOE after acquiring that lock, or it needs
to claim the interface completely and provide a driver for userspace
to submit requests that can be scheduled in the kernel's DOE queue.
