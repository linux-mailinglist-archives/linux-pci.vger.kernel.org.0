Return-Path: <linux-pci+bounces-8956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5184F90E4D7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 09:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2971C20BDB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 07:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8181BF50;
	Wed, 19 Jun 2024 07:48:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE32D208D0;
	Wed, 19 Jun 2024 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783281; cv=none; b=qwpBve1N3AOHEGNP2PeAzCKQ1C9h/B2T4Co1xrvsON8LO68+jszFFoIGeaQmud9JNe8iCmggpKsSqlkpQL7rMrLdCHW3AQlWVQ7D4iFZ9zpe9bjV0mEYJ1HhMVNUdftE9TFJOcPHpZj9yp7s8ZF4b361kbqyWG3obFodqLfTItg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783281; c=relaxed/simple;
	bh=0SzwLqthtkETXwopUS/Jo5+thBK5ziuiLb9+Qum/lOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcZX7BlTbK/vKVXvyFeD2hQU+5wUJgsbRjoh8fBfYfJHh6EwKj4VK6PJXM5gvHzmTubchMoLUF07UTyEgzqgH1BJW3s//oD+5LKoEF69zuwS/hQUa6TM8PPEtCe3JWzcWEHVo9snv03QyE0hLg6r08WELhOnMh2TiccyAsjol2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 2925B3000C769;
	Wed, 19 Jun 2024 09:47:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 15F92393EF2; Wed, 19 Jun 2024 09:47:51 +0200 (CEST)
Date: Wed, 19 Jun 2024 09:47:51 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Bowman Terry <terry.bowman@amd.com>,
	Hagan Billy <billy.hagan@amd.com>,
	Simon Guinot <simon.guinot@seagate.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
Message-ID: <ZnKNJxJwdtWRphgX@wunner.de>
References: <20240617231841.GA1232294@bhelgaas>
 <27be113e-3e33-b969-c1e3-c5e82d1b8b7f@amd.com>
 <cf5f3b03-4c70-7a35-056e-5d94fc26f697@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf5f3b03-4c70-7a35-056e-5d94fc26f697@amd.com>

On Tue, Jun 18, 2024 at 02:23:21PM -0700, Smita Koralahalli wrote:
> On 6/18/2024 11:51 AM, Smita Koralahalli wrote:
> > > > > But IIUC LBMS is set by hardware but never cleared by hardware, so if
> > > > > we remove a device and power off the slot, it doesn't seem like LBMS
> > > > > could be telling us anything useful (what could we do in response to
> > > > > LBMS when the slot is empty?), so it makes sense to me to clear it.
> > > > > 
> > > > > It seems like pciehp_unconfigure_device() does sort of PCI core and
> > > > > driver-related things and possibly could be something shared by all
> > > > > hotplug drivers, while remove_board() does things more specific to the
> > > > > hotplug model (pciehp, shpchp, etc).
> > > > > 
> > > > > From that perspective, clearing LBMS might fit better in
> > > > > remove_board(). In that case, I wonder whether it should be done
> > > > > after turning off slot power? This patch clears is *before* turning
> > > > > off the power, so I wonder if hardware could possibly set it again
> > > > > before the poweroff?
> 
> While clearing LBMS in remove_board() here:
> 
> if (POWER_CTRL(ctrl)) {
> 	pciehp_power_off_slot(ctrl);
> +	pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
> 				   PCI_EXP_LNKSTA_LBMS);
> 
> 	/*
> 	 * After turning power off, we must wait for at least 1 second
> 	 * before taking any action that relies on power having been
> 	 * removed from the slot/adapter.
> 	 */
> 	msleep(1000);
> 
> 	/* Ignore link or presence changes caused by power off */
> 	atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
> 		   &ctrl->pending_events);
> }
> 
> This can happen too right? I.e Just after the slot poweroff and before LBMS
> clearing the PDC/PDSC could be fired. Then
> pciehp_handle_presence_or_link_change() would hit case "OFF_STATE" and
> proceed with pciehp_enable_slot() ....pcie_failed_link_retrain() and
> ultimately link speed drops..
> 
> So, I added clearing just before turning off the slot.. Let me know if I'm
> thinking it right.

This was added by 3943af9d01e9 ("PCI: pciehp: Ignore Link State Changes
after powering off a slot").  You can try reproducing it by writing "0"
to the slot's "power" file in sysfs, but your hardware needs to support
slot power.

Basically the idea is that after waiting for 1 sec, chances are very low
that any DLLSC or PDSC events caused by removing slot power may still
occur.

Arguably the same applies to LBMS changes, so I'd recommend to likewise
clear stale LBMS after the msleep(1000).

pciehp_ctrl.c only contains the state machine and higher-level logic of
the hotplug controller and all the actual register accesses are in helpers
in pciehp_hpc.c.  So if you want to do it picture-perfectly, add a helper
in pciehp_hpc.c to clear LBMS and call that from remove_board().

That all being said, I'm wondering how this plays together with Ilpo's
bandwidth control driver?

https://lore.kernel.org/all/20240516093222.1684-1-ilpo.jarvinen@linux.intel.com/

IIUC, the bandwidth control driver will be in charge of handling LBMS
changes.  So clearing LBMS behind the bandwidth control driver's back
might be problematic.  Ilpo?

Also, since you've confirmed that this issue is fallout from
a89c82249c37 ("PCI: Work around PCIe link training failures"),
I'm wondering if the logic introduced by that commit can be
changed so that the quirk is applied more narrowly, i.e. *not*
applied to unaffected hardware, such as AMD's hotplug ports.
That would avoid the need to undo the effect of the quirk and
work around the downtraining you're seeing.

Maciej, any ideas?

Thanks,

Lukas

