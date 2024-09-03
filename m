Return-Path: <linux-pci+bounces-12679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB496A514
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 19:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90341F256D9
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C3218C92D;
	Tue,  3 Sep 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b25C1xEG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD821C14;
	Tue,  3 Sep 2024 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383520; cv=none; b=l40AmRqijWNyEEHylXsjKizcL0vFjnsxSvSzLXNOwAuVsUjLQCUD4nUQ1X+YLACPij/RurRP32efwefJlntkCRE6zPeWRujqAu18IEpaU2LtOrljUtmvV3QtPenbryn0MbEYfp5jxjcsxOQ3+2OH3ISTDJg6SVrEVrhfJgoh2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383520; c=relaxed/simple;
	bh=LP56cnU6byzfTTmQxjj+Dqls6VQhgI4J9t5PyD+H3YY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b8yjaLl+htmnurCUqUbCYqq6Po1Veu2raa42ygR+AUqaZc4R+0khlfbV6ML8n3bnscjhWiCUdRvVNREwfM6P+dlbTAUd/2g4UUEPd4BfZxVmzvypvcTjxbTXDmzKqbPCTY6fbmD1vIHyJRE0r2tHy5k+zpcvIZ85K/CKFAMfPEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b25C1xEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A415C4CEC4;
	Tue,  3 Sep 2024 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725383519;
	bh=LP56cnU6byzfTTmQxjj+Dqls6VQhgI4J9t5PyD+H3YY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b25C1xEGEv1Uj0tKdQtpMlZUQlCbOQG1lAj/6pZp6IJYPdWdUw5FtItqPROaFxTo5
	 pyIgoHvkM55bnumJsoi5cnEkVYau3+w9yv6MzrSLjYagCEW1F0h3GoTvWJVPaPU+r7
	 b8+0sFG86TN5rDi5J/1fT4QhjsWGaszYRpijDhybFjxrR5N6i03sFoC5M45N+R6cvN
	 Umyig+BAyUZaiuJj5ibeCiHG8MPpEUXKOyZp5LzZnayzwotqQ+Djw0DsGH7UdBOuJG
	 MMLMiGyBRhq5KaW7UPZ0w7aVuoa1HBZtMyPMvNtSPiDg2c9mtvVkXqdaylrypJgi2n
	 xEJaSdyS4426Q==
Date: Tue, 3 Sep 2024 12:11:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
Message-ID: <20240903171157.GA254033@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac2dfbf-fd9a-4223-8d9e-bb41dbf98b1a@amd.com>

On Tue, Sep 03, 2024 at 11:29:23AM -0500, Mario Limonciello wrote:
> On 8/29/2024 19:01, Bjorn Helgaas wrote:
> > On Fri, Aug 23, 2024 at 10:40:20AM -0500, Mario Limonciello wrote:
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > 
> > > If a dock is plugged in at the same time as autosuspend delay then
> > > this can cause malfunctions in the USB4 stack. This happens because
> > > the device is still in D3cold at the time that the PCI core handed
> > > control back to the USB4 stack.
> > > 
> > > A device that has gone through a reset may return a value in
> > > PCI_COMMAND but that doesn't mean it's finished transitioning to D0.
> > > For devices that support power management explicitly check
> > > PCI_PM_CTRL on everything but system resume to ensure the transition
> > > happened.
> > 
> > Still trying to understand what's going on here.
> > 
> > I posted a change to pci_dev_wait() to read Vendor ID, look for Config
> > RRS status, and wait for a successful completion (when RRS Software
> > Visibility is enabled) [1].
> > 
> > You tested that and found that it didn't help with *this* issue [2].
> > I assume you tested something like v6.11-rc plus the patches from [1],
> > i.e., without the PCI_PM_CTRL changes in this series.
> > 
> >    1) Initially the device is in D0
> > 
> >    2) We put it in D3cold (using some ACPI method) because the
> >    autosuspend delay expired (?)
> > 
> >    3) Plugging in the dock wakes up the device, so we power up the
> >    device (via pci_power_up(), which again uses some ACPI method), and
> >    it should transition to D0uninitialized
> > 
> >    4) The USB4 stack sees the device but thinks it's in D3cold (?)
> ...

> > If you *did* include both [1] and patch 3/5, the implication would be
> > that pci_dev_wait() successfully read the Vendor ID, meaning the
> > device is not in D3cold when pci_power_up() returns.
> 
> The testing here was from the LTS 6.6.y kernel with both [1] and
> patch 3/5 from this series.
> 
> > Can you clarify what you see and possibly expand/correct my
> > timeline above?
> 
> The timeline you shared is nearly correct.  The USB4 stack *thinks*
> the device is in D0 because of the return of pci_power_up().
> 
> As by polling PCI_PM_CTRL we can see it's still in D3, so it hasn't
> made it to D0uninitialized yet.
> 
> I guess I reading between the lines you have an assumption that you
> can't read the vendor ID from D3; which doesn't appear to be the
> case from our testing.

A Vendor ID read of a device in D3hot should definitely work.
Obviously if the device were in D3cold, we'd get no response at all,
so the requester should log a UR error and fabricate ~0 data.

But if the device starts out in D3cold and we power it up, it should
not go through D3hot.  The only legal transition from D3cold is to
D0uninitialized (PCIe r6.0, sec 5.8).

OK, so with [1] and patch 3/5:

  1) Initially the device is in D0

  2) We put it in D3cold (using some ACPI method) because the
  autosuspend delay expired (?)

  3) Plugging in the dock wakes up the device, so we power up the
  device (via pci_power_up(), which again uses some ACPI method), and
  it should transition to D0uninitialized

  4) With patch 3/5, pci_power_up() calls pci_dev_wait() because
  dev->current_state == PCI_D3cold

  5) I *assume* RRS SV is enabled (lspci -vv of Root Port would
  confirm this; maybe we should add a pci_dbg message about which
  register we're polling).  If so, patch [1] means we should poll
  Vendor ID until successful completion.

  6) pci_dbg log should confirm the device is ready with a "ready %dms
  after D3cold->D0" message, which would mean we got a successful
  completion when reading Vendor ID

  7) For debugging purposes, it would be interesting to read and log
  the PCI_PM_CTRL value here.  Per sec 2.3.1, the device is not
  allowed to return RRS at this point since we already got a
  successful completion.

  8) The USB4 stack sees the device and assumes it is in D0, but it
  seems to still be in D3cold.  What is this based on?  Is there a
  config read that returns ~0 data when it shouldn't?

> > [1] https://lore.kernel.org/linux-pci/20240827234848.4429-1-helgaas@kernel.org/
> > [2] https://lore.kernel.org/linux-pci/30d9589a-8050-421b-a9a5-ad3422feadad@amd.com/
> > 
> > > Devices that don't support power management and system resume will
> > > continue to use PCI_COMMAND.
> > > 
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v4->v5:
> > >   * Fix misleading indentation
> > >   * Amend commit message
> > > ---
> > >   drivers/pci/pci.c | 28 ++++++++++++++++++++--------
> > >   1 file changed, 20 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 1e219057a5069..f032a4aaec268 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -1309,21 +1309,33 @@ static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_type, int
> > >   	 * the read (except when CRS SV is enabled and the read was for the
> > >   	 * Vendor ID; in that case it synthesizes 0x0001 data).
> > >   	 *
> > > -	 * Wait for the device to return a non-CRS completion.  Read the
> > > -	 * Command register instead of Vendor ID so we don't have to
> > > -	 * contend with the CRS SV value.
> > > +	 * Wait for the device to return a non-CRS completion.  On devices
> > > +	 * that support PM control and on waits that aren't part of system
> > > +	 * resume read the PM control register to ensure the device has
> > > +	 * transitioned to D0.  On devices that don't support PM control,
> > > +	 * or during system resume read the command register to instead of
> > > +	 * Vendor ID so we don't have to contend with the CRS SV value.
> > >   	 */
> > >   	for (;;) {
> > > -		u32 id;
> > > -
> > >   		if (pci_dev_is_disconnected(dev)) {
> > >   			pci_dbg(dev, "disconnected; not waiting\n");
> > >   			return -ENOTTY;
> > >   		}
> > > -		pci_read_config_dword(dev, PCI_COMMAND, &id);
> > > -		if (!PCI_POSSIBLE_ERROR(id))
> > > -			break;
> > > +		if (dev->pm_cap && reset_type != PCI_DEV_WAIT_RESUME) {
> > > +			u16 pmcsr;
> > > +
> > > +			pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > > +			if (!PCI_POSSIBLE_ERROR(pmcsr) &&
> > > +			    (pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0)
> > > +				break;
> > > +		} else {
> > > +			u32 id;
> > > +
> > > +			pci_read_config_dword(dev, PCI_COMMAND, &id);
> > > +			if (!PCI_POSSIBLE_ERROR(id))
> > > +				break;
> > > +		}
> > >   		if (delay > timeout) {
> > >   			pci_warn(dev, "not ready %dms after %s; giving up\n",
> > > -- 
> > > 2.43.0
> > > 
> 

