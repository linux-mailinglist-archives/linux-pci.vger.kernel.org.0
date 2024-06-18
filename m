Return-Path: <linux-pci+bounces-8930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58A190DDB7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 22:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2741C22465
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 20:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DAF16CD09;
	Tue, 18 Jun 2024 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkroOP1X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E84D8DC;
	Tue, 18 Jun 2024 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743720; cv=none; b=ns+oaNkwv3K97ResotHsm+CBiKLT1rM3r2reahgjPQKuPQ/3BQ4pTjOEiPngzJVPLHSD51I+4Y29d1aoMWfTkgtOaqyV3Z/MdofRjyrnJfZdX+mUKeVCwAvqpiPC9CYln1FZBkFdnlwoE8Ytn93a1VH9FkKCU+CJFAavmUvqY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743720; c=relaxed/simple;
	bh=vifOR8wqTe33GN1ZxE0aE3JJoX2X6ojZd3vgLTYu4qs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ayK02a5sNZiSFC3/B0ZDk6kF/jTBHVDTQTiBylDZHVl90TI87g03wuNSY2d22cPnlacXpATeqgkL1VqICiVhZPGYp+TchPGgWm/ljR/ZVuLkA3hhqCQb5YwdHaJ5tGYizjYi1ybq3viAY5XmGcZ8QSZSlcm6UtkQtNwpd9fxvow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkroOP1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87306C3277B;
	Tue, 18 Jun 2024 20:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718743719;
	bh=vifOR8wqTe33GN1ZxE0aE3JJoX2X6ojZd3vgLTYu4qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kkroOP1XahDe8y0PCYQZWwyr7NzPoNIwKnMyP+cVjWRCKFcCxKBzRGDNp5obZrYbz
	 TXvRrpIY6765aIvN+9QFQnMrnolLmfu4CvKLK7bKU1bY4quBie2SutBEJe4aty31YW
	 46peRLKOHaHiKEX9ERj/dQSuM/jhak/eoJ05OYZUB2jh7Nr0wShO63IhXLoT/4I5hU
	 /GzijQeVV3O7i0uDFm9QjeJHWAIhkUsrRqB83M7ASE/xRb/Aj64+dtmUD6SN8zZ5CE
	 cnAZbMmfem036ZIZuOAsM99HquNtT9GWtVtxfwcD78kDR96olXaYPTHaR4isWpg+AR
	 IpRfOm6YY/erQ==
Date: Tue, 18 Jun 2024 15:48:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bagasdotme@gmail.com,
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org,
	kch@nvidia.com, hch@lst.de, gloriouseggroll@gmail.com,
	kbusch@kernel.org, sagi@grimberg.me, hare@suse.de
Subject: Re: [PATCH v8 2/3] PCI/AER: Disable AER service on suspend
Message-ID: <20240618204837.GA1262769@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p7O51mG7LMrEobEgGrD8tsDFO3ZFSPAu02Dk-R0W3mkvg@mail.gmail.com>

On Thu, Apr 25, 2024 at 03:33:01PM +0800, Kai-Heng Feng wrote:
> On Fri, Apr 19, 2024 at 4:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Apr 16, 2024 at 12:32:24PM +0800, Kai-Heng Feng wrote:
> > > When the power rail gets cut off, the hardware can create some electric
> > > noise on the link that triggers AER. If IRQ is shared between AER with
> > > PME, such AER noise will cause a spurious wakeup on system suspend.
> > >
> > > When the power rail gets back, the firmware of the device resets itself
> > > and can create unexpected behavior like sending PTM messages. For this
> > > case, the driver will always be too late to toggle off features should
> > > be disabled.
> > >
> > > As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power
> > > Management", TLP and DLLP transmission are disabled for a Link in L2/L3
> > > Ready (D3hot), L2 (D3cold with aux power) and L3 (D3cold) states. So if
> > > the power will be turned off during suspend process, disable AER service
> > > and re-enable it during the resume process. This should not affect the
> > > basic functionality.
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=209149
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=218090
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > Thanks for reviving this series.  I tried follow the history about
> > this, but there are at least two series that were very similar and I
> > can't put it all together.
> >
> > > ---
> > > v8:
> > >  - Add more bug reports.
> > >
> > > v7:
> > >  - Wording
> > >  - Disable AER completely (again) if power will be turned off
> > >
> > > v6:
> > > v5:
> > >  - Wording.
> > >
> > > v4:
> > > v3:
> > >  - No change.
> > >
> > > v2:
> > >  - Only disable AER IRQ.
> > >  - No more check on PME IRQ#.
> > >  - Use helper.
> > >
> > >  drivers/pci/pcie/aer.c | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index ac6293c24976..bea7818c2d1b 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -28,6 +28,7 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/kfifo.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/suspend.h>
> > >  #include <acpi/apei.h>
> > >  #include <acpi/ghes.h>
> > >  #include <ras/ras_event.h>
> > > @@ -1497,6 +1498,28 @@ static int aer_probe(struct pcie_device *dev)
> > >       return 0;
> > >  }
> > >
> > > +static int aer_suspend(struct pcie_device *dev)
> > > +{
> > > +     struct aer_rpc *rpc = get_service_data(dev);
> > > +     struct pci_dev *pdev = rpc->rpd;
> > > +
> > > +     if (pci_ancestor_pr3_present(pdev) || pm_suspend_via_firmware())
> > > +             aer_disable_rootport(rpc);
> >
> > Why do we check pci_ancestor_pr3_present(pdev) and
> > pm_suspend_via_firmware()?  I'm getting pretty convinced that we need
> > to disable AER interrupts on suspend in general.  I think it will be
> > better if we do that consistently on all platforms, not special cases
> > based on details of how we suspend.
> 
> Sure. Will change in next revision.
> 
> > Also, why do we use aer_disable_rootport() instead of just
> > aer_disable_irq()?  I think it's the interrupt that causes issues on
> > suspend.  I see that there *were* some versions that used
> > aer_disable_irq(), but I can't find the reason it changed.
> 
> Interrupt can cause system wakeup, if it's shared with PME.
> 
> The reason why aer_disable_rootport() is used over aer_disable_irq()
> is that when the latter is used the error still gets logged during
> sleep cycle. Once the pcieport driver resumes, it invokes
> aer_root_reset() to reset the hierarchy, while the hierarchy hasn't
> resumed yet.
> 
> So use aer_disable_rootport() to prevent such issue from happening.

I think the issue is more likely on the resume side.

aer_disable_rootport() disables AER interrupts, then clears
PCI_ERR_ROOT_STATUS, so the path looks like this:

  aer_suspend
    aer_disable_rootport
      aer_disable_irq()
      pci_write_config_dword(PCI_ERR_ROOT_STATUS)    # clear

This happens during suspend, so at this point I think the link is
still active and the spurious AER errors haven't happened yet and it
probably doesn't matter that we clear PCI_ERR_ROOT_STATUS *here*.

My guess is that what really matters is that we disable the AER
interrupt so it doesn't happen during suspend, and then when we
resume, we probably want to clear out the status registers before
re-enabling the AER interrupt.

In any event, I think we need to push this forward.  I'll post a v9
based on this but dropping the pci_ancestor_pr3_present(pdev) and
pm_suspend_via_firmware() tests so we do this unconditionally.

> > > +     return 0;
> > > +}
> > > +
> > > +static int aer_resume(struct pcie_device *dev)
> > > +{
> > > +     struct aer_rpc *rpc = get_service_data(dev);
> > > +     struct pci_dev *pdev = rpc->rpd;
> > > +
> > > +     if (pci_ancestor_pr3_present(pdev) || pm_resume_via_firmware())
> > > +             aer_enable_rootport(rpc);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  /**
> > >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> > >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > > @@ -1561,6 +1584,8 @@ static struct pcie_port_service_driver aerdriver = {
> > >       .service        = PCIE_PORT_SERVICE_AER,
> > >
> > >       .probe          = aer_probe,
> > > +     .suspend        = aer_suspend,
> > > +     .resume         = aer_resume,
> > >       .remove         = aer_remove,
> > >  };
> > >
> > > --
> > > 2.34.1
> > >

