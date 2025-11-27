Return-Path: <linux-pci+bounces-42190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD36C8D439
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 08:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B93AD3435EB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7544F320CAB;
	Thu, 27 Nov 2025 07:58:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBFC31DD97;
	Thu, 27 Nov 2025 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764230308; cv=none; b=qLpNST6MBQHJuz2tFGPwYAG/TBg7BgZjTb1gdELnb035ITsRQhT3UcPmDqqJBWa9Md7Pa/bnXpNgIIUsIbY+ZiyLDZxPdsn4tY130fhu+m36kejfZiZSaeACBW4d6FZL/5sf75WApWmyv2KLfgKUTzgOcHK0FQYUeLvyVzhWiRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764230308; c=relaxed/simple;
	bh=d43ltFcxFlKBSbW/DcXgPPdGTuQetMivVrzMboDm0W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ly+riwoRrwRiLvnOGO9FP/23aWx6dvxBZJo3guTJLg/hXWD0vL6ZhDfDi57SK8CURMDT4f3w0dsGcNjjztsMJN2kch9lwVPJS48zWiT1mOHxhevKn1B4MCOxMlFxi+GkRSc75rM5QGhYk6GRhroAqQTlaKrJ829LOqjnkTd0TDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 534712C000A8;
	Thu, 27 Nov 2025 08:58:22 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2F6661D8E7; Thu, 27 Nov 2025 08:58:22 +0100 (CET)
Date: Thu, 27 Nov 2025 08:58:22 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Riana Tauro <riana.tauro@intel.com>,
	"Sean C. Dardis" <sean.c.dardis@intel.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alek Du <alek.du@intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI/PM: Reinstate clearing state_saved in legacy
 and !pm codepaths
Message-ID: <aSgEnt12QQLXCfWr@wunner.de>
References: <aSb3Qt6n55Fsl7IF@wunner.de>
 <20251126234603.GA2832326@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126234603.GA2832326@bhelgaas>

On Wed, Nov 26, 2025 at 05:46:03PM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 26, 2025 at 01:49:06PM +0100, Lukas Wunner wrote:
> > In the patch, I made the "pci_dev->state_saved = false" assignment
> > conditional on !pm_runtime_suspended() in the "freeze" codepath.
> > I didn't do the same in the legacy codepath because none of the
> > drivers using legacy PM callbacks seem to be using runtime PM.
> 
> Maybe it's moot because we hope there will be no new users of PCI
> legacy PM with runtime PM, but I don't think there's anything to
> *prevent* that or to protect against out-of-tree drivers.
> 
> The implicit assumption that there are no such drivers makes it look
> like there's something magic involving state_saved, legacy PM, and
> runtime PM.  It might be worth doing the same in the legacy PM path
> just for readability.

Drivers having both legacy callbacks and modern callbacks (including
runtime PM callbacks) cause emission of a WARN splat in
pci_has_legacy_pm_support().

Drivers need to activate runtime PM by dropping a runtime PM reference
on probe (see the code comment in local_pci_probe()).  In theory a
driver could have legacy callbacks but no modern callbacks and still
use runtime PM by calling pm_runtime_put_noidle() on probe.  So I
compiled a list of drivers implementing legacy callbacks (included
at the end of this e-mail for reference), grep'ed through them
for any "pm_runtime" occurrences and found none.

Hence it seems very unlikely that drivers using legacy callbacks and
runtime PM exist.  We probably shouldn't accommodate for such use cases
but should rather try to incentivize conversion to modern callbacks.

When compiling the list I sadly noticed that new drivers do exist
which use legacy callbacks.  A case in point is:

drivers/net/ethernet/google/gve/gve_main.c

... which started using legacy callbacks in 2021 with commit 974365e51861
("gve: Implement suspend/resume/shutdown").

I guess there is no real incentive to convert to modern PM callbacks and
finding someone who has the hardware and can test patches is hard
(most drivers are for ATA, some for really old 1990s hardware).
Plus, a lot of detailed knowledge about PCI PM is necessary to avoid
breakage, making this a task that can't easily be delegated to new
contributors.  And everyone with the knowledge is overworked already.
So we keep dragging this tech debt along which complicates codepaths. :(

> Stepping back, I guess that when drivers use generic PM, we already
> save config state during suspend and restore that state during resume,
> and do the same when entering/leaving hibernation.
> 
> And the point of this patch is to do the same when drivers lack PM or
> use legacy PCI PM, or when devices have no driver?

Right.  To have a consistent logic that state_saved is always cleared
before commencing the suspend sequence, in all codepaths.

> Maybe third try is the charm?
> 
>   For drivers using PCI legacy suspend, save config state at suspend
>   so that state, not any earlier state from enumeration, probe, or
>   error recovery, will be restored when resuming.
> 
>   For devices with no driver or a driver that lacks PM, save config
>   state at hibernate so that state, not any earlier state from
>   enumeration, probe, or error recovery, will be restored when
>   resuming.

Perfect.

> IIUC, after "Ensure error recoverability", the PCI core will always
> save the state during enumeration, so drivers shouldn't use
> pci_save_state() at all unless they make config changes that they want
> restored during error recovery?
> 
> Or, I guess (sigh) if they do their own power management?

Exactly right.

> > Also, in case the meaning of "freeze", "thaw", "restore" isn't clear,
> > here's the order of a hibernation sequence (suspend to disk):
[...]
> Thanks, this is extremely helpful.

FWIW, this is the sequence of suspend-to-memory, obviously much simpler:

  pci_pm_prepare()
  pci_pm_suspend()
  pci_pm_suspend_late()
  pci_pm_suspend_noirq()
  pci_pm_resume_noirq()
  pci_pm_resume_early()
  pci_pm_resume()
  pci_pm_complete()

And runtime PM:

  pci_pm_runtime_suspend()
  pci_pm_runtime_resume()

Thanks,

Lukas

-- >8 --

Drivers with legacy PCI PM callbacks:

  drivers/ata/acard-ahci.c
  drivers/ata/ata_generic.c
  drivers/ata/ata_piix.c
  drivers/ata/pata_acpi.c
  drivers/ata/pata_ali.c
  drivers/ata/pata_amd.c
  drivers/ata/pata_artop.c
  drivers/ata/pata_atiixp.c
  drivers/ata/pata_atp867x.c
  drivers/ata/pata_cmd640.c
  drivers/ata/pata_cmd64x.c
  drivers/ata/pata_cs5520.c
  drivers/ata/pata_cs5530.c
  drivers/ata/pata_cs5535.c
  drivers/ata/pata_cs5536.c
  drivers/ata/pata_cypress.c
  drivers/ata/pata_efar.c
  drivers/ata/pata_hpt366.c
  drivers/ata/pata_hpt3x3.c
  drivers/ata/pata_it8213.c
  drivers/ata/pata_it821x.c
  drivers/ata/pata_jmicron.c
  drivers/ata/pata_macio.c
  drivers/ata/pata_marvell.c
  drivers/ata/pata_mpiix.c
  drivers/ata/pata_netcell.c
  drivers/ata/pata_ninja32.c
  drivers/ata/pata_ns87410.c
  drivers/ata/pata_ns87415.c
  drivers/ata/pata_oldpiix.c
  drivers/ata/pata_opti.c
  drivers/ata/pata_optidma.c
  drivers/ata/pata_pdc2027x.c
  drivers/ata/pata_pdc202xx_old.c
  drivers/ata/pata_piccolo.c
  drivers/ata/pata_radisys.c
  drivers/ata/pata_rdc.c
  drivers/ata/pata_rz1000.c
  drivers/ata/pata_sc1200.c
  drivers/ata/pata_sch.c
  drivers/ata/pata_serverworks.c
  drivers/ata/pata_sil680.c
  drivers/ata/pata_sis.c
  drivers/ata/pata_sl82c105.c
  drivers/ata/pata_triflex.c
  drivers/ata/pata_via.c
  drivers/ata/sata_inic162x.c
  drivers/ata/sata_mv.c
  drivers/ata/sata_nv.c
  drivers/ata/sata_sil.c
  drivers/ata/sata_sil24.c
  drivers/ata/sata_sis.c
  drivers/ata/sata_via.c
  drivers/bluetooth/hci_bcm4377.c
  drivers/gpio/gpio-bt8xx.c
  drivers/message/fusion/mptfc.c
  drivers/message/fusion/mptsas.c
  drivers/message/fusion/mptspi.c
  drivers/mtd/nand/raw/cafe_nand.c
  drivers/net/ethernet/atheros/atl1e/atl1e_main.c
  drivers/net/ethernet/atheros/atlx/atl2.c
  drivers/net/ethernet/google/gve/gve_main.c
  drivers/net/ethernet/microsoft/mana/gdma_main.c
  drivers/net/ethernet/toshiba/tc35815.c
  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
  drivers/net/wireless/mediatek/mt76/mt7615/pci.c
  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
  drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
  drivers/scsi/nsp32.c
  drivers/scsi/qedf/qedf_main.c
  drivers/scsi/qedi/qedi_main.c
  drivers/scsi/stex.c
  drivers/tty/serial/serial_txx9.c
  drivers/video/fbdev/chipsfb.c
  drivers/video/fbdev/i810/i810_main.c

