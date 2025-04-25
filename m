Return-Path: <linux-pci+bounces-26737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997B3A9C4E8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 12:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D12E97A2897
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D36D23F417;
	Fri, 25 Apr 2025 10:12:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01A1C8600;
	Fri, 25 Apr 2025 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575974; cv=none; b=LljsHBChPtoU7XJldkD9jnilFK4p+8D73lPaojcTbeDI7ChJirESX9B/cgLfLN4FV1lfZR3B0npkSrqDmJpMAzZd+fQ4BiPQxrUR9E11GLRXCPcElWLlmlxPFwx416P6mm6g33GbosZnpI/lFXXgMiIKiDzzvEtj5Y3n1XHJZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575974; c=relaxed/simple;
	bh=IHATJE1khszjObdsQyGJmBlU9Z+SAnlkzb5F0C6Gbvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOu8Uojz1o8+lbco0a60+JyJIin/p4WUuK0uFsId3ng/Hk0dV/CoPTYh+E5VMsEIyi7vjSGjcigZPQDsXsnFh/iJK1PbhquXs2wC1XHW0bTMQLfbXWtiPF2TztNOp1z4Tdil12ozqcXMdV1A365NL8dey3O+4QQQwdvYRQWriFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5E9332C4CBD4;
	Fri, 25 Apr 2025 12:12:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1E1F1EAA1C; Fri, 25 Apr 2025 12:12:49 +0200 (CEST)
Date: Fri, 25 Apr 2025 12:12:49 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v2 1/1] PCI/bwctrl: Replace lbms_count with
 PCI_LINK_LBMS_SEEN flag
Message-ID: <aAtgIfG8VG7vLDPN@wunner.de>
References: <20250422115548.1483-1-ilpo.jarvinen@linux.intel.com>
 <aAi734h55l7g6eXH@wunner.de>
 <87631533-312f-fee9-384e-20a2cc69caf0@linux.intel.com>
 <aAnOOj91-N6rwt2x@wunner.de>
 <e639b361-785e-d39b-3c3f-957bcdc54fcd@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e639b361-785e-d39b-3c3f-957bcdc54fcd@linux.intel.com>

On Thu, Apr 24, 2025 at 03:37:38PM +0300, Ilpo Järvinen wrote:
> On Thu, 24 Apr 2025, Lukas Wunner wrote:
> >   The only concern here is whether the cached
> >   link speed is updated.  pcie_bwctrl_change_speed() does call
> >   pcie_update_link_speed() after calling pcie_retrain_link(), so that
> >   looks fine.  But there's a second caller of pcie_retrain_link():
> >   pcie_aspm_configure_common_clock().  It doesn't update the cached
> >   link speed after calling pcie_retrain_link().  Not sure if this can
> >   lead to a change in link speed and therefore the cached link speed
> >   should be updated?  The Target Link Speed isn't changed, but maybe
> >   the link fails to retrain to the same speed for electrical reasons?
> 
> I've never seen that to happen but it would seem odd if that is forbidden 
> (as the alternative is probably that the link remains down).
> 
> Perhaps pcie_reset_lbms() should just call pcie_update_link_speed() as the 
> last step, then the irq handler returning IRQ_NONE doesn't matter.

Why pcie_reset_lbms()?  I was rather thinking that pcie_update_link_speed()
should be called from pcie_retrain_link().  Maybe right after the final
pcie_wait_for_link_status().

That would ensure that the speed is updated in case retraining from
pcie_aspm_configure_common_clock() happens to lead to a lower speed.
And the call to pcie_update_link_speed() from pcie_bwctrl_change_speed()
could then be dropped.

PCIe r6.2 sec 7.5.3.19 says the Target Link Speed "sets an upper limit
on Link operational speed", which implies that the actual negotiated
speed might be lower.


> > - pciehp's remove_board() calls the function after bringing down the slot
> >   to avoid a stale PCI_LINK_LBMS_SEEN flag.  No real harm in clearing the
> >   bit in the register at this point I guess.  But I do wonder, is the link
> >   speed updated somewhere when a new board is added?  The replacement
> >   device may not support the same speeds as the previous device.
> 
> The supported speeds are always recalculated using dev->supported_speeds. 
> A new board implies a new pci_dev structure with newly read supported 
> speeds. Also, bringing the link up with the replacement device will also 
> trigger LBMS so the new Link Speed should be picked up by that.
> 
> Racing LBMS reset from remove_board() with LBMS due to the replacement 
> board shouldn't result in stale Link Speed because of:
> 
> board_added()
>   pciehp_check_link_status()
>     __pcie_update_link_speed()

Good!  That's the information I was looking for.

Thanks,

Lukas

