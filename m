Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AA21AF44F
	for <lists+linux-pci@lfdr.de>; Sat, 18 Apr 2020 21:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgDRTld (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Apr 2020 15:41:33 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52271 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728143AbgDRTld (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Apr 2020 15:41:33 -0400
Received: (qmail 8750 invoked by uid 500); 18 Apr 2020 15:41:32 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2020 15:41:32 -0400
Date:   Sat, 18 Apr 2020 15:41:32 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/9] PM: sleep: core: Rearrange the handling of driver
 power management flags
In-Reply-To: <CAJZ5v0hAyLv2+xE_eMgmra5kccDLGY941inJbKZyWPStKXk2nQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.2004181540230.8036-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 18 Apr 2020, Rafael J. Wysocki wrote:

> On Sat, Apr 18, 2020 at 8:00 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Sat, 18 Apr 2020, Rafael J. Wysocki wrote:
> >
> > > Hi,
> > >
> > > This is an update including some fixes and extra patches based on the
> > > continuation of the discussion [1].
> >
> > I haven't checked the updates in detail yet.  However, it seems that
> > dev_pm_skip_suspend() and dev_pm_skip_resume() should be EXPORTed,
> > since they are intended to be used by subsystems, which may be in
> > modules.
> 
> OK, so what about an extra patch to export them?
> 
> Currently there are no modular users of these functions.

Ah, all right.  So when/if I want to use them, I will submit such a 
patch.

Alan Stern

