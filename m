Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4661E802DE
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2019 00:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbfHBWhC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Aug 2019 18:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbfHBWhC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Aug 2019 18:37:02 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27AA82087E;
        Fri,  2 Aug 2019 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564785421;
        bh=k6A88DuQEvAIoLZeKCV5w8lg3gPfOlEbV8DJruVNIvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HaEoVLJwSjtIMakvSZXXvIDVQkyQQ7paLq7JQYIOPb1FJyOAa7VrtP77sau3BwOaN
         YdwpFNHzZRYFWXWZUmN6x6kqK8fhg1q5kxVa44OGLrUCqklfTEciGGZyLOGkcThD0o
         NnZ5IyDLLbL+gXKEeAjLnTjYJU6FAmQEWNU39SZ0=
Date:   Fri, 2 Aug 2019 17:36:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [Regression] Commit "ACPI: PM: Allow transitions to D0 to occur
 in special cases"
Message-ID: <20190802223659.GO151852@google.com>
References: <578BD3F1-B185-471B-A3EB-FF71BA34B822@canonical.com>
 <20190731213001.GC151852@google.com>
 <6494680.N7F1gMbocb@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6494680.N7F1gMbocb@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 01, 2019 at 12:26:51AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 31, 2019 11:30:01 PM CEST Bjorn Helgaas wrote:
> > [+cc Thunderbolt folks, see
> > https://lore.kernel.org/r/578BD3F1-B185-471B-A3EB-FF71BA34B822@canonical.com
> > for beginning of thread]
> > 
> > On Thu, Aug 01, 2019 at 12:04:29AM +0800, Kai-Heng Feng wrote:
> > > Hi,
> > > 
> > > After commit "ACPI: PM: Allow transitions to D0 to occur in special cases”,
> > 
> > This is f850a48a0799 ("ACPI: PM: Allow transitions to D0 to occur in
> > special cases").
> > 
> > > Thunderbolt on XPS 9380 spews the following when it runtime resumes:
> > > [   36.136554] pci_raw_set_power_state: 25 callbacks suppressed
> > > [   36.136558] pcieport 0000:03:00.0: Refused to change power state,
> > > currently in D3
> > 
> > We really should be smarter about what we print here, maybe something
> > like the patch below?
> > 
> > pci_raw_set_power_state() prints "Refused to change power state" if
> > (in this case) the value of (PCI_PM_CTRL & PCI_PM_CTRL_STATE_MASK) is
> > 0x3.  Most likely we got 0xffff from PCI_PM_CTRL because the device is
> > in D3cold.  If the device is in D3cold, pci_raw_set_power_state() has
> > no hope of doing anything because it only uses PCI PM config
> > registers, and they're inaccessible in D3cold.

> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 29ed5ec1ac27..63ca963ebff9 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -851,6 +852,11 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
> >  		return -EIO;
> >  
> >  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > +	if (pmcsr == (u16) ~0) {
> 
> Is the "device not accessible" the only case in which we can get all ones from this?
> 
> If so, the change will be fine by me.

There are several RsvdP bits in that register, so it's not possible to
read all ones except in error cases.  I'll finish up a patch for it.

Bjorn
