Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEFF290D48
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 23:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404084AbgJPV2t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 17:28:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392202AbgJPV2s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Oct 2020 17:28:48 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E85DC214DB;
        Fri, 16 Oct 2020 21:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602883728;
        bh=qzkgxAHSgBjFEvzLY/tm7vJsCuShehWruOQ31vgTKTA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bMvgxROKUn+Wx5lQT7ZYs+r7LVyalWAlcQcloJmIJ/u5JMpC7HGdqn8eDHe2eVGie
         Py12UHVD0l6siVvuoI8YkR/LIoh5q+Pxc7objQCndYPeWXf9JJ9c4SQLbcnZyOBgSz
         QdsLbT4XM9Q7dlvHdjAKAuEoJNQ/nXR91BD2qAx8=
Date:   Fri, 16 Oct 2020 16:28:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
Message-ID: <20201016212846.GA109479@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA85sZsnMd3SdnH2bchxfkR7_Ka1wDvu9Z592uaK3FFm4rszTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 14, 2020 at 03:33:17PM +0200, Ian Kumlien wrote:
> On Wed, Oct 14, 2020 at 10:34 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> > > On Oct 12, 2020, at 18:20, Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > On Thu, Oct 8, 2020 at 6:13 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> > >> OK, now we're getting close.  We just need to flesh out the
> > >> justification.  We need:
> > >>
> > >>  - Tidy subject line.  Use "git log --oneline drivers/pci/pcie/aspm.c"
> > >>    and follow the example.
> > >
> > > Will do
> > >
> > >>  - Description of the problem.  I think it's poor bandwidth on your
> > >>    Intel I211 device, but we don't have the complete picture because
> > >>    that NIC is 03:00.0, which doesn't appear above at all.
> > >
> > > I think we'll use Kai-Hengs issue, since it's actually more related to
> > > the change itself...
> > >
> > > Mine is a side effect while Kai-Heng is actually hitting an issue
> > > caused by the bug.
> >
> > I filed a bug here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=209671
> 
> Thanks!

Sigh.  I feel like I'm just not getting anywhere here.  I still do not
have a "before" and "after" set of lspci output.

Kai-Heng's bugzilla has two sets of output, but one is a working
config with CONFIG_PCIEASPM_DEFAULT=y and the other is a working
config with Ian's patch applied and CONFIG_PCIEASPM_POWERSAVE=y.

Comparing them doesn't show the effect of Ian's patch; it shows the
combined effect of Ian's patch and the CONFIG_PCIEASPM_POWERSAVE=y
change.  I'm not really interested in spending a few hours trying to
reverse-engineer the important changes.

Can you please, please, collect these on your system, Ian?  I assume
that you can easily collect it once without your patch, when you see
poor I211 NIC performance but the system is otherwise working.  And
you can collect it again *with* your patch.  Same Kconfig, same
*everything* except adding your patch.

Bjorn
