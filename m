Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3862A22FB9B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 23:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgG0VrP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 17:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgG0VrP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 17:47:15 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8CB62070B;
        Mon, 27 Jul 2020 21:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595886434;
        bh=4KHzr6s9qazdRG4uIrQgBE5hj3ZCg9MSVH8IOy0oqo4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m8MzimSTDbym1tEunWUc/6M1BccMkDGih1rrJafaILcBTbNrd6/p3CZZ+ovg6N7RO
         vZy9S8oIZaJpgQqiRxCFgw5GArxNYxpDfm02WWK5km9gZs4IfFRZMR7t9f5dxrxrok
         WV41SmZtDRqp0GywHA+DDWYlBDqsD1KhpPkOO+vs=
Date:   Mon, 27 Jul 2020 16:47:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     James Ettle <james@ettle.org.uk>
Cc:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>,
        Rui Feng <rui_feng@realsil.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <lenb@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacopo De Simoi <wilderkde@gmail.com>
Subject: Re: rtsx_pci not restoring ASPM state after suspend/resume
Message-ID: <20200727214712.GA1777201@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02332767323fc3ecccea13dd47ecfff12526112.camel@ettle.org.uk>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 27, 2020 at 08:52:25PM +0100, James Ettle wrote:
> On Mon, 2020-07-27 at 09:14 -0500, Bjorn Helgaas wrote:
> > I don't know the connection between ASPM and package C-states, so I
> > need to simplify this even more.  All I want to do right now is
> > verify
> > that if we don't have any outside influences on the ASPM
> > configuration
> > (eg, no manual changes and no udev rules), it stays the same across
> > suspend/resume.
> 
> Basically this started from me observing deep package C-states weren't
> being used, until I went and fiddled with the ASPM state of the
> rtsx_pci card reader under sysfs -- so phenomenological poking on my
> part.
> 
> > So let's read the ASPM state directly from the
> > hardware like this:
> > 
> >   sudo lspci -vvs 00:1d.0 | egrep "^0|Lnk|L1|LTR|snoop"
> >   sudo lspci -vvs 01:00   | egrep "^0|Lnk|L1|LTR|snoop"
> > 
> > Can you try that before and after suspend/resume?
> 
> I've attached these to the bugzilla entry at:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=208117
> 
> Spoiler: With no udev rules or suspend hooks, things are the same
> before and after suspend/resume. One thing I do see (both before and
> after) is that ASPM L0s and L1 is enabled for the card reader, but
> disabled for the ethernet chip (does r8169 fiddle with ASPM too?).

Thank you!  It's good that this stays the same across suspend/resume.
Do you see different C-state behavior before vs after?

This is the config I see:

  00:1d.0 bridge to [bus 01]: ASPM L1 supported;     ASPM Disabled
  01:00.0 card reader:        ASPM L0s L1 supported; L0s L1 Enabled
  01:00.1 GigE NIC:           ASPM L0s L1 supported; ASPM Disabled

This is actually illegal because PCIe r5.0, sec 5.4.1.3, says software
must not enable L0s in either direction unless components on both ends
of the link support L0s.  The bridge (00:1d.0) does not support L0s,
so it's illegal to enable L0s on 01:00.0.  I don't know whether this
causes problems in practice.

I don't see anything in rtsx that enables L0s.  Can you collect the
dmesg log when booting with "pci=earlydump"?  That will show whether
the BIOS left it this way.  The PCI core isn't supposed to do this, so
if it did, we need to fix that.

I don't know whether r8169 mucks with ASPM.  It is legal to have
different configurations for the two functions, even though they share
the same link.  Sec 5.4.1 has rules about how hardware resolves
differences.

> [Oddly when I set ASPM (e.g. using udev) the lspci tools show ASPM
> enabled after a suspend/resume, but still no deep package C-states
> until I manually fiddle via sysfs on the card reader. Sorry if this
> only muddies the water further!]

Let's defer this for now.  It sounds worth pursuing, but I can't keep
everything in my head at once.

Bjorn
