Return-Path: <linux-pci+bounces-41993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 755ECC82A14
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 23:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B92E4E11F0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 22:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5483334C36;
	Mon, 24 Nov 2025 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3fXEPDQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0174330B36
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764022261; cv=none; b=Dxe2tVIfxGrb9en6b+mTyuPbjtgQlfiFNopTOib04PNbgZz6WJbOKV+xDoBW4hzGubHlb6vesfhK1T7WbTFDe2xLBKCvybQRXgxBaammrd5vD1oDQep5CrO35prpRagvI7v/6RYfx36gNJJMOBfBacPJqujhgxGhqqWQxXzXhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764022261; c=relaxed/simple;
	bh=UsXhBOBNmqsMTTUB6JBqI/XfVmzEW6sOsIyelQ0NUtM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nkZoq88YuSODr4vBRCWYKnHvBxbW7AG6U4rvrXNtZYuVot1mpwGPilUBcYYLVZqwxFH8sRVpdOdElDk4Udzo69gdmERe3ZCKURCwoOa+nXZr98bKYCWEjh/0HSMSfjRhSWtziMstDMqPWL8e9+ivb8B9mI44mCnSa5xeGp/Qj/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3fXEPDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438FAC4CEF1;
	Mon, 24 Nov 2025 22:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764022261;
	bh=UsXhBOBNmqsMTTUB6JBqI/XfVmzEW6sOsIyelQ0NUtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=e3fXEPDQZ9ePKo45xltu1vITqq4l/JMYSRNcWab//ifrp0oRwC/S20mjMMtp+Kp0u
	 BhE+jGVtEJyQZTThuxLjeUB/7fhc21zIF8pQ6a5+rxF0lWztIS7NtTviE0qghAKzMr
	 UnX6ZriWFHYzpunWDfPnz0wSK07i3winA/gT+3QUK+94Gy18iHwG7Lp2VmwxIvweH7
	 1oCKwUruiiIR5yzZS+Z9HgnoGM7oyYdChfUB1u1lr7O3kKChBL16FIwXtczctrmBJm
	 4hlwKRpTRadwIVDNvgJgkidaA1IX3/vp1o3RpZEaJV6Ae8m6uNnH7TClE6ZjWUme20
	 gM/jag5QqjE2g==
Date: Mon, 24 Nov 2025 16:11:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Riana Tauro <riana.tauro@intel.com>,
	"Sean C. Dardis" <sean.c.dardis@intel.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alek Du <alek.du@intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, qat-linux@intel.com,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 1/2] PCI: Ensure error recoverability at all times
Message-ID: <20251124221100.GA2717085@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSCkB7C5EF2BVdfM@wunner.de>

On Fri, Nov 21, 2025 at 06:40:23PM +0100, Lukas Wunner wrote:
> On Thu, Nov 13, 2025 at 10:15:56AM -0600, Bjorn Helgaas wrote:
> > On Thu, Nov 13, 2025 at 10:38:09AM +0100, Lukas Wunner wrote:
> > > On Wed, Nov 12, 2025 at 04:38:31PM -0600, Bjorn Helgaas wrote:
> > > > On Sun, Oct 12, 2025 at 03:25:01PM +0200, Lukas Wunner wrote:
> > > > It would be nice if there were a few more
> > > > words about pci_save_state() and pci_restore_state() in
> > > > Documentation/.
> > > > 
> > > > pci_save_state() isn't mentioned at all in Documentation/PCI
> > > 
> > > Right, it's documented in the Documentation/power directory. :)
> > 
> > Yes, in the pci.rst I mentioned, but it mostly uses the "saves the
> > device's standard configuration registers" wording.
> > 
> > I'm just wishing for a more concrete mention of "pci_save_state()",
> > since that's where the critical "state_saved" flag is updated.
> 
> Hm, Documentation/power/pci.rst does contain this:
> 
>    "Then, pci_save_state(), pci_prepare_to_sleep(), and
>     pci_set_power_state() should be used to save the device’s
>     standard configuration registers, to prepare it for system wakeup
>     (if necessary), and to put it into a low-power state, respectively."
> 
> I'm struggling to find a better way to phrase it.

The part that seems confusing to me is that pci_save_state() is the
switch that turns off PCI core power management.  The state save part
is not obviously connected with the power management part, at least
from the function name.

But that paragraph goes on to say:

  Moreover, if the driver calls pci_save_state(), the PCI subsystem
  will not execute either pci_prepare_to_sleep(), or
  pci_set_power_state() for its device, so the driver is then
  responsible for handling the device as appropriate.

so the doc actually *does* mention the connection, and although
pci_prepare_to_sleep() and pci_set_power_state() sound sort of like
internal functions, I guess that makes sense because drivers doing
their own power management would be using things like that.

I do raise my eyebrows a bit at them though; there are only seven
drivers that use pci_prepare_to_sleep(), which makes me a little
suspicious -- what is so unique about those drivers?

A bunch of drivers use pci_set_power_state().  Many seem to be rolling
their own PM resets.  Several others use it in suspend/resume for
reasons that aren't obvious to me but are likely legit.

> > And I'm not sure Documentation/ includes anything about the idea of
> > a driver using pci_save_state() to capture the state it wants to
> > restore after an error.
> 
> Right, while pci_save_state() usage is mentioned in the PCI power
> management documentation, it's not mentioned at all in the error
> recovery context.  So I'm proposing this amendment:
> 
> https://lore.kernel.org/r/077596ba70202be0e43fdad3bb9b93d356cbe4ec.1763746079.git.lukas@wunner.de/

Thanks!

Bjorn

