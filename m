Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495777D121
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2019 00:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfGaW0z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 31 Jul 2019 18:26:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56913 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfGaW0z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jul 2019 18:26:55 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 0f4f0307dd885295; Thu, 1 Aug 2019 00:26:52 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [Regression] Commit "ACPI: PM: Allow transitions to D0 to occur in special cases"
Date:   Thu, 01 Aug 2019 00:26:51 +0200
Message-ID: <6494680.N7F1gMbocb@kreacher>
In-Reply-To: <20190731213001.GC151852@google.com>
References: <578BD3F1-B185-471B-A3EB-FF71BA34B822@canonical.com> <20190731213001.GC151852@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, July 31, 2019 11:30:01 PM CEST Bjorn Helgaas wrote:
> [+cc Thunderbolt folks, see
> https://lore.kernel.org/r/578BD3F1-B185-471B-A3EB-FF71BA34B822@canonical.com
> for beginning of thread]
> 
> On Thu, Aug 01, 2019 at 12:04:29AM +0800, Kai-Heng Feng wrote:
> > Hi,
> > 
> > After commit "ACPI: PM: Allow transitions to D0 to occur in special cases”,
> 
> This is f850a48a0799 ("ACPI: PM: Allow transitions to D0 to occur in
> special cases").
> 
> > Thunderbolt on XPS 9380 spews the following when it runtime resumes:
> > [   36.136554] pci_raw_set_power_state: 25 callbacks suppressed
> > [   36.136558] pcieport 0000:03:00.0: Refused to change power state,
> > currently in D3
> 
> We really should be smarter about what we print here, maybe something
> like the patch below?
> 
> pci_raw_set_power_state() prints "Refused to change power state" if
> (in this case) the value of (PCI_PM_CTRL & PCI_PM_CTRL_STATE_MASK) is
> 0x3.  Most likely we got 0xffff from PCI_PM_CTRL because the device is
> in D3cold.  If the device is in D3cold, pci_raw_set_power_state() has
> no hope of doing anything because it only uses PCI PM config
> registers, and they're inaccessible in D3cold.
> 
> Presumably there's some platform PM method that is supposed to take
> the device out of D3cold, and maybe we're missing that somehow?

Yes, there is.

> Based on an lspci I found at [1], I suspect 03:00.0 is a Thunderbolt
> switch leading to [bus 04-6d].  From your log, it looks like these
> devices don't work:
> 
>   03:00.0 Thunderbolt Upstream Port
>   04:00.0 Thunderbolt Downstream Port
>   04:01.0 Thunderbolt Downstream Port (Slot 1)
>   04:02.0 Thunderbolt Downstream Port
>   04:04.0 Thunderbolt Downstream Port (Slot 4)
>   05:00.0 Thunderbolt NHI
>   39:00.0 XHCI USB
> 
> If 03:00.0 is stuck in D3cold, that would explain why none of these
> things work.
> 
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1826125
> 
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 29ed5ec1ac27..63ca963ebff9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -851,6 +852,11 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>  		return -EIO;
>  
>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +	if (pmcsr == (u16) ~0) {

Is the "device not accessible" the only case in which we can get all ones from this?

If so, the change will be fine by me.

> +		pci_err(dev, "device not responding; can't change to power state D%d\n",
> +			state);

But I wouldn't break this line.

> +		return -EIO;
> +	}
>  
>  	/*
>  	 * If we're (effectively) in D3, force entire word to 0.
> 

Thanks!



