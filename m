Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12222A374
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 02:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgGWAAP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jul 2020 20:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbgGWAAO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jul 2020 20:00:14 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FAB02080D;
        Thu, 23 Jul 2020 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595462414;
        bh=qR5Eq1BercnCXvvQ8dDOJRkLZbzeTnJgz4nvdEMwtTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E6ws/PZfoxEU+IFafd8yFUq7Hh1Uk6qzAQ75Gl52bYOmFmQOb49XZR2MpLkijulCP
         bn05E7kPch7jBputAARe/DKfIUAAJ6GfObdGWL6U1BDKFCNQGAAZwg3W2m1oS/eGFX
         QP8Cm3oHSh7pQGDyi1iXEvrAJ53Fg8+qdT7aajB0=
Date:   Wed, 22 Jul 2020 19:00:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>, jroedel@suse.de,
        Myron Stowe <myron.stowe@redhat.com>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Wright <rwright@hpe.com>, Dave Young <dyoung@redhat.com>,
        Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
Message-ID: <20200723000012.GA1325359@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722215048.GL220876@anatevka.americas.hpqcorp.net>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 22, 2020 at 03:50:48PM -0600, Jerry Hoemann wrote:
> On Wed, Jul 22, 2020 at 10:21:23AM -0500, Bjorn Helgaas wrote:
> > On Wed, Jul 22, 2020 at 10:52:26PM +0800, Kairui Song wrote:

> > > I think I didn't make one thing clear, The PCI UR error never arrives
> > > in kernel, it's the iLo BMC on that HPE machine caught the error, and
> > > send kernel an NMI. kernel is panicked by NMI, I'm still trying to
> > > figure out why the NMI hanged kernel, even with panic=-1,
> > > panic_on_io_nmi, panic_on_unknown_nmi all set. But if we can avoid the
> > > NMI by shutdown the devices in right order, that's also a solution.

ACPI v6.3, chapter 18, does mention NMIs several times, e.g., Table
18-394 and sec 18.4.  I'm not familiar enough with APEI to know
whether Linux correctly supports all those cases.  Maybe this is a
symptom that we don't?

> > I'm not sure how much sympathy to have for this situation.  A PCIe UR
> > is fatal for the transaction and maybe even the device, but from the
> > overall system point of view, it *should* be a recoverable error and
> > we shouldn't panic.
> > 
> > Errors like that should be reported via the normal AER or ACPI/APEI
> > mechanisms.  It sounds like in this case, the platform has decided
> > these aren't enough and it is trying to force a reboot?  If this is
> > "special" platform behavior, I'm not sure how much we need to cater
> > for it.
> 
> Are these AER errors the type processed by the GHES code?

My understanding from ACPI v6.3, sec 18.3.2, is that the Hardware
Error Source Table may contain Error Source Descriptors of types like:

  IA-32 Machine Check Exception
  IA-32 Corrected Machine Check
  IA-32 Non-Maskable Interrupt
  PCIe Root Port AER
  PCIe Device AER
  Generic Hardware Error Source (GHES)
  Hardware Error Notification
  IA-32 Deferred Machine Check

I would naively expect PCIe UR errors to be reported via one of the
PCIe Error Sources, not GHES, but maybe there's some reason to use
GHES.

The kernel should already know how to deal with the PCIe AER errors,
but we'd have to add new device-specific code to handle things
reported via GHES, along the lines of what Shiju is doing here:

  https://lore.kernel.org/r/20200722104245.1060-1-shiju.jose@huawei.com

> I'll note that RedHat runs their crash kernel with:  hest_disable.
> So, the ghes code is disabled in the crash kernel.

That would disable all the HEST error sources, including the PCIe AER
ones as well as GHES ones.  If we turn off some of the normal error
handling mechanisms, I guess we have to expect that some errors won't
be handled correctly.

Bjorn
