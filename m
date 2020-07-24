Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE722D219
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jul 2020 01:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgGXXNM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 19:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgGXXNL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 19:13:11 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71BE62070B;
        Fri, 24 Jul 2020 23:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595632390;
        bh=HZpnpiku6KxH32mX+B577S8tCYjbRxTgV8cNsa4GI0Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PJhmVJgNVwvKOOofJUhYxWH9OJlKHXgaL829NsQ9oUXK4voII5EuZMs9dhXJnGY3a
         tHN5LR4krlkI2F2vSfIRyDQEHwb/0uswkc/YsXPleq7ui3IRCxM7588YO4p4Udpg/8
         NTcdV51wVN9JwZA4L1qVSA4PIoAedVR7NdU0dw5s=
Date:   Fri, 24 Jul 2020 18:13:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>
Cc:     Rui Feng <rui_feng@realsil.com.cn>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Ettle <james@ettle.org.uk>, Len Brown <lenb@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacopo De Simoi <wilderkde@gmail.com>
Subject: Re: rtsx_pci not restoring ASPM state after suspend/resume
Message-ID: <20200724231309.GA1551055@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83fa1c44e8d342618eb5fbc491ec4779@realtek.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 24, 2020 at 07:16:26AM +0000, 吳昊澄 Ricky wrote:
> Hi James, Bjorn,
> 
> The Card reader(10ec:5287) is a combo chip with Ethernet(10ec:8168),
> we think it is not cause by setting our device config space in idle
> time.
>
> We dis/enable the ASPM(setting config space) at busy/idle time, it
> can make our R/W performances well not a work around function
>
> PCI Host and Device setting self config space and do handshaking, we
> think it does not affect the system

Are you able to reproduce the problem?  Specifically, James observes
that before suspend, ASPM L1 is enabled, but after resume, L0s and L1
are enabled.  The ASPM state should be the same after resume.

See:

  https://bugzilla.kernel.org/show_bug.cgi?id=208117#c8
  https://bugzilla.kernel.org/show_bug.cgi?id=208117#c9

James *is* manually enabling ASPM L1 via a udev rule, which
complicates things a little.  The sysfs link/l1_aspm functionality
he's using is new and could well be buggy.

Maybe we should simplify this a little bit more.  James, if you don't
touch ASPM config at all, either manually or via udev, does the ASPM
configuration stay the same across suspend/resume?

> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: Friday, July 24, 2020 1:13 AM
> > To: 吳昊澄 Ricky; Rui Feng
> > Cc: Arnd Bergmann; Greg Kroah-Hartman; James Ettle; Len Brown; Puranjay
> > Mohan; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Jacopo De
> > Simoi
> > Subject: Re: rtsx_pci not restoring ASPM state after suspend/resume
> > 
> > [+cc Jacopo]
> > 
> > On Thu, Jul 23, 2020 at 11:56:22AM -0500, Bjorn Helgaas wrote:
> > > James reported this issue with rtsx_pci; can you guys please take a
> > > look at it?  https://bugzilla.kernel.org/show_bug.cgi?id=208117
> > >
> > > There's a lot of good info in the bugzilla already.
> > 
> > Likely duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=198951
> > 
> > Jacopo, could you please attach a complete dmesg log and "sudo lspci
> > -vvxxxx" output to your bugzilla?
> > 
> > ------Please consider the environment before printing this e-mail.
