Return-Path: <linux-pci+bounces-26993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3066AA07ED
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 12:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB77189F63C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F26215049;
	Tue, 29 Apr 2025 10:02:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250E1C5D4B;
	Tue, 29 Apr 2025 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745920946; cv=none; b=mtEbJ7mDpT0V6q3/C/idEEqLPvBZS3k5wUMuNVaTJTauNwEeS+YOazsW+RXBqCsEMtFEegVxUUE7d5KuJVs2n/hZSXKZwaLcU6UqHrm892Wkly2R3liqk5fDlm16ROW0IWXCUrnGAAYweUmC117Rj3qnTGUzl25PObavULdR0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745920946; c=relaxed/simple;
	bh=wbMS1Nbi9qxzvhfFmoY2xyviFUoT/2hBLVnNwtBWpxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPpLoLE01y12/92SEIHPwHO15tPpDFjqnFLm+lwnfBc+6y2NteBvDmNtOAtFTXJM23hgyDnoWuxCs5L80leGbUW9AviY7z74BQxncYv48ZvVfuhNqSpiqjLXZel6C3WiVHL0dgeTgSoLSadeGqltntz3Q0Z58OY1EWwioMY7oqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id CF34D200A463;
	Tue, 29 Apr 2025 12:02:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1197A1730B; Tue, 29 Apr 2025 12:02:13 +0200 (CEST)
Date: Tue, 29 Apr 2025 12:02:13 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v2 1/1] PCI/bwctrl: Replace lbms_count with
 PCI_LINK_LBMS_SEEN flag
Message-ID: <aBCjpfyYmlkJ12AZ@wunner.de>
References: <20250422115548.1483-1-ilpo.jarvinen@linux.intel.com>
 <aAi734h55l7g6eXH@wunner.de>
 <87631533-312f-fee9-384e-20a2cc69caf0@linux.intel.com>
 <aAnOOj91-N6rwt2x@wunner.de>
 <e639b361-785e-d39b-3c3f-957bcdc54fcd@linux.intel.com>
 <aAtgIfG8VG7vLDPN@wunner.de>
 <e154f382-629e-f910-ea56-7cce262df079@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e154f382-629e-f910-ea56-7cce262df079@linux.intel.com>

On Fri, Apr 25, 2025 at 03:24:45PM +0300, Ilpo Järvinen wrote:
> On Fri, 25 Apr 2025, Lukas Wunner wrote:
> > On Thu, Apr 24, 2025 at 03:37:38PM +0300, Ilpo Järvinen wrote:
> > > On Thu, 24 Apr 2025, Lukas Wunner wrote:
> > > >   The only concern here is whether the cached
> > > >   link speed is updated.  pcie_bwctrl_change_speed() does call
> > > >   pcie_update_link_speed() after calling pcie_retrain_link(), so that
> > > >   looks fine.  But there's a second caller of pcie_retrain_link():
> > > >   pcie_aspm_configure_common_clock().  It doesn't update the cached
> > > >   link speed after calling pcie_retrain_link().  Not sure if this can
> > > >   lead to a change in link speed and therefore the cached link speed
> > > >   should be updated?  The Target Link Speed isn't changed, but maybe
> > > >   the link fails to retrain to the same speed for electrical reasons?
> > > 
> > > I've never seen that to happen but it would seem odd if that is forbidden 
> > > (as the alternative is probably that the link remains down).
> > > 
> > > Perhaps pcie_reset_lbms() should just call pcie_update_link_speed() as the 
> > > last step, then the irq handler returning IRQ_NONE doesn't matter.
> > 
> > Why pcie_reset_lbms()?  I was rather thinking that pcie_update_link_speed()
> > should be called from pcie_retrain_link().  Maybe right after the final
> > pcie_wait_for_link_status().
> 
> My reasonale for having it in pcie_reset_lbms() is that LBMS is cleared
> there which races with the irq handler reading LBMS. If LBMS is cleared 
> before the irq handler reads linksta register, it returns IRQ_NONE and 
> will misses the LBMS event. So this race problem is directly associated 
> with the write-to-clear of LBMS.

pcie_reset_lbms() is only called from two places:

(1) pciehp's remove_board() -- no need to update the link speed of an empty
    slot and you've proven that the speed *is* updated by board_added()
    once there is a new card in the slot.

(2) pcie_retrain_link() -- retraining could always lead to a different
    speed, e.g. due to electrical issues, so unconditionally updating
    the link speed makes sense.

It feels awkward that a function named pcie_reset_lbms() would also
update the link speed as a side effect.

> While I don't disagree with that spec interpretation, in case of ASPM, the 
> question is more complex than that. The link was already trained to speed 
> x, can the new link training result in failing to train to x (in 
> practice).

It's probably rare but bad wiring or soldering issues can always cause
a lower or higher speed than before.

My recommendation would be to move the invocation of
pcie_update_link_speed() from pcie_bwctrl_change_speed()
to pcie_retrain_link().

Just to cover the case that the retraining initiated by
pcie_aspm_configure_common_clock() leads to a different speed
and pcie_reset_lbms() wins the race against the bwctrl irq handler.
It's a corner case, but if we've identified it now, might as well
fix it I guess?

Thanks,

Lukas

