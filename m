Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 480E6172A64
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 22:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgB0Vph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 16:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgB0Vph (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 16:45:37 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C929924690;
        Thu, 27 Feb 2020 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582839936;
        bh=AM4kdeQCT+o/tr4whfJ+2H1/vGpVdw2AbR8i2yWI6fU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rjUNvDXW4SaRs8m5lIClDqaIbNTlJ26DXp3vVUY8/Jy/UL9SGe/nqsuWfDLrkSFcW
         MLd7bb0DD5Jn9X8LoDOFIlunDVkoy5xy9Ek9GPefa4wgKkzAt1dCuSNfEQj5ChCWW6
         Ng608tVC+sstuNJtr7v/hEO9LZ2eiaIxPcZJskF4=
Date:   Thu, 27 Feb 2020 15:45:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Spassov, Stanislav" <stanspas@amazon.de>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Wang, Wei" <wawei@amazon.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Schoenherr, Jan H." <jschoenh@amazon.de>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/3] PCI: Make PCIE_RESET_READY_POLL_MS configurable
Message-ID: <20200227214534.GA143139@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21926ab1c8216382801dca9130343f954247b408.camel@amazon.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 24, 2020 at 05:52:14PM +0000, Spassov, Stanislav wrote:
> On Mon, 2020-02-24 at 08:15 -0600, Bjorn Helgaas wrote:
> > On Sun, Feb 23, 2020 at 01:20:55PM +0100, Stanislav Spassov wrote:
> > > From: Wei Wang <wawei@amazon.de>
> > > 
> > > The reasonable value for the maximum time to wait for a PCI
> > > device to be ready after reset varies depending on the platform
> > > and the reliability of its set of devices.
> > 
> > There are several mechanisms in the spec for reducing these times,
> > e.g., Readiness Notifications (PCIe r5.0, sec 6.23), the Readiness
> > Time Reporting capability (sec 7.9.17), and ACPI _DSM methods (PCI
> > Firmware Spec r3.2, sec 4.6.8, 4.6.9).
> > 
> > I would much rather use standard mechanisms like those instead of
> > adding kernel parameters.  A user would have to use trial and
> > error to figure out the value to use with a parameter like this,
> > and that doesn't feel like a robust approach.
> 
> I agree that supporting the standard mechanisms is highly desirable,
> but some sort of fallback poll timeout value is necessary on
> platforms where none of those mechanisms are supported. Arguably,
> some kernel configurability (whether via a kernel parameter, as
> proposed here, or some other means) is still desirable.

IIUC we basically have two issues: 1) the default 60 second timeout is
too long, and 2) you'd like to reduce the delays further à la the
Device Readiness _DSM even for firmware that doesn't support that.

The 60 second timeout came from 821cdad5c46c ("PCI: Wait up to 60
seconds for device to become ready after FLR") and is probably too
long.  We probably should pick a smaller value based on numbers from
the spec and make quirks for devices that needed more time.

As far as reducing delays for specific devices, if we can identify
them via Vendor/Device ID, can we make per-device values that could be
set either by the _DSM or by a quirk?

I'm trying to wriggle out of adding yet more PCI kernel parameters
because people tend to stumble across them and pass them around on
bulletin boards as ways to "fix" or "speed up" things that really
should be addressed in better ways.

> I also agree there is no robust method to determine a "good value", but
> then again - how was the current value for the constant determined? As
> suggested in PATCH 2, the idea is to lower the global timeout to avoid
> hung tasks when devices break and never come back after reset.

I don't remember exactly how we came up with 60 seconds; I suspect it
was just a convenient large number.

Bjorn
