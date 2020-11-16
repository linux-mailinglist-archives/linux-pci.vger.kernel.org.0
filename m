Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC032B4A65
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 17:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgKPQMw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 11:12:52 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54586 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbgKPQMw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 11:12:52 -0500
Received: from 89-64-89-143.dynamic.chello.pl (89.64.89.143) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id 06351fb59e3410d6; Mon, 16 Nov 2020 17:06:09 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Do not generate wakeup event when runtime resuming bus
Date:   Mon, 16 Nov 2020 17:06:08 +0100
Message-ID: <2582211.lb15P8fMpq@kreacher>
In-Reply-To: <20201113063745.GH2495@lahna.fi.intel.com>
References: <20201029092453.69869-1-mika.westerberg@linux.intel.com> <20201113063745.GH2495@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday, November 13, 2020 7:37:45 AM CET Mika Westerberg wrote:
> Hi,
> 
> On Thu, Oct 29, 2020 at 12:24:53PM +0300, Mika Westerberg wrote:
> > When a PCI bridge is runtime resumed from D3cold the underlying bus is
> > walked and the attached devices are runtime resumed as well. However, in
> > addition to that we also generate a wakeup event for these devices even
> > though this actually is not a real wakeup event coming from the
> > hardware.
> > 
> > Normally this does not cause problems but when combined with
> > /sys/power/wakeup_count like using the steps below:
> > 
> >   # count=$(cat /sys/power/wakeup_count)
> >   # echo $count > /sys/power/wakeup_count
> >   # echo mem > /sys/power/state
> > 
> > The system suspend cycle might get aborted at this point if a PCI bridge
> > that was runtime suspended (D3cold) was runtime resumed for any reason.
> > The runtime resume calls pci_wakeup_bus() and that generates wakeup
> > event increasing wakeup_count.
> > 
> > Since this is not a real wakeup event we can prevent the above from
> > happening by removing the call to pci_wakeup_event() in
> > pci_wakeup_bus(). While there rename pci_wakeup_bus() to
> > pci_resume_bus() to better reflect what it does.
> 
> Any comments on this?

I've missed it, sorry.

Now replied with a R-by, thanks!



