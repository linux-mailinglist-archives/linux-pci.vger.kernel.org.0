Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9727122EF3F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 16:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgG0OOm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 10:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730582AbgG0OOl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 10:14:41 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D1F2173E;
        Mon, 27 Jul 2020 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859280;
        bh=hqGjzG7kcr/MsbjRxsV9hAB3/B1VJxy+zFkGz8jLWdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gVWT8qiP8B2d3sTJWw8jQuwCKb3Ijd21gSw5+UBWrb5jM7RD83N2Xm6QSWdZUsPF4
         eGVxErBhMwzWE7lKlM103qKgBzyjtjdGMAgnxaU3R+cp4PsPNU3lmozQjqz094GyZx
         2MntVodiw2oVVzOD8/Rq62m6IKmhl5bzXm6+YpII=
Date:   Mon, 27 Jul 2020 09:14:38 -0500
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
Message-ID: <20200727141438.GA1743062@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaa64572fac0fc411b79a9adb59b5bbcbdf4b1a8.camel@ettle.org.uk>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 25, 2020 at 09:27:11PM +0100, James Ettle wrote:
> On Fri, 2020-07-24 at 18:13 -0500, Bjorn Helgaas wrote:
> > 
> > Maybe we should simplify this a little bit more.  James, if you don't
> > touch ASPM config at all, either manually or via udev, does the ASPM
> > configuration stay the same across suspend/resume?
> 
> Yes, it stays the same. Explicitly: 
> 
> With the udev rule disabled, immediately following clean boot from
> power-off (and no additional tinkering), ASPM is OFF to the best of my
> knowledge:
> 
>  - link/l1_aspm in sysfs is 0 for PCI devices 0000:01:00.[01];
>  - the processor sleeps no deeper than package C3.
> 
> The situation above is the same following a suspend/resume cycle --
> both in terms of sysfs, and observed package C-state occupancy.
> 
> [Tested on kernel 5.7.10, but the behaviour is the same as prior
> kernels.]

I don't know the connection between ASPM and package C-states, so I
need to simplify this even more.  All I want to do right now is verify
that if we don't have any outside influences on the ASPM configuration
(eg, no manual changes and no udev rules), it stays the same across
suspend/resume.

In https://bugzilla.kernel.org/show_bug.cgi?id=208117#c12, we saw that
ASPM L0s was disabled before suspend but was enabled after resume.
That should not happen.

You're looking at the sysfs link/l1_aspm file, which tells us what the
PCI core thinks the state is, but I'm not confident that's accurate,
especially because the driver fiddles with the state behind the back
of the PCI core.  So let's read the ASPM state directly from the
hardware like this:

  sudo lspci -vvs 00:1d.0 | egrep "^0|Lnk|L1|LTR|snoop"
  sudo lspci -vvs 01:00   | egrep "^0|Lnk|L1|LTR|snoop"

Can you try that before and after suspend/resume?
