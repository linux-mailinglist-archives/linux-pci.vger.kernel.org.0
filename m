Return-Path: <linux-pci+bounces-40991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824E5C52DB7
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 16:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE13503333
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B67338901;
	Wed, 12 Nov 2025 14:40:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC22BEFE0;
	Wed, 12 Nov 2025 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958437; cv=none; b=sIXctrwsxAuS10xnJZmtCrG+9ojNZTHCFi3W7mRjU3iorkMH8Cg4Y1IVRqHy+kKsg3bfZYmiSbCwPOzpGaDdF19De8h0INXQXNzXRv/FoFQRT9kz8BWYtLJ2EArx93ddKm51fQ/KfUnhiBUVzGsuDq/Drh2rvHFv30Q52Ohra6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958437; c=relaxed/simple;
	bh=xBow/5Bx/C4H/leIFzI5qQBxAYKpyLQSCzH+GuaoE78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ml+c4vvKg6zDbv3VbECch7tcAx6+Uw4PgQEwA1skdGqpoTj5lW3U6p7H8QhTgFb/+tMtYrlGnOk/algGke2sOBpWKAALEIb+EDRJMzFjoCpuPUO5P2sMCMTwDOOLUICVi3+sshnRY9Wjz5NMN1szMV7UG9nR490+yYsRAdaiBX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A35832C051E8;
	Wed, 12 Nov 2025 15:40:26 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 73C00162D4; Wed, 12 Nov 2025 15:40:26 +0100 (CET)
Date: Wed, 12 Nov 2025 15:40:26 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Hongxing Zhu <hongxing.zhu@nxp.com>, hypexed@yahoo.com.au,
	linuxppc-dev@lists.ozlabs.org, debian-powerpc@lists.debian.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI/ASPM: Allow quirks to avoid L0s and L1
Message-ID: <aRScWjHRy1FrGiwC@wunner.de>
References: <aRMC9z93mI5BKbW0@wunner.de>
 <20251111154445.GA2175922@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111154445.GA2175922@bhelgaas>

On Tue, Nov 11, 2025 at 09:44:45AM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 11, 2025 at 10:33:43AM +0100, Lukas Wunner wrote:
> > I note that a number of drivers call pci_disable_link_state() or
> > pci_disable_link_state_locked() to disable ASPM on probe.
> > Can we convert (all of) these to quirks which use the new helper
> > introduced here?
[...]
> I definitely agree.  I forgot to follow up on all of those cases.
> There aren't that many of them, but it looks like probably too many to
> address for v6.18, and I *think* it's safe to wait and deal with them
> for v6.19.

Yes I agree this isn't necessary for v6.18.

It may even be too late for v6.19 given the amount of time to come up
with patches, get them reviewed and allow sufficient time to soak in
linux-next.  And this would be a cleanup, so not really urgent.

I note that a lot of material has queued up in patchwork and only few
new features have been applied to pci.git this cycle, which I guess
has been caused by the unusual number of regressions introduced
during the merge window.  Given that, I'd down-prioritize conversion
of pci_disable_link_state() calls.

One feature I'd be keen to get in for v6.19 (if time permits) is this one:

https://lore.kernel.org/all/cover.1760274044.git.lukas@wunner.de/

I'm worried that the "pci_save_state() after pci_restore_state()"
anti-pattern gets cargo-culted to more drivers if it's not removed soon.
I can split patch [2/2] in that series into smaller patches and funnel
them through the individual subsystem trees if you'd rather not apply
them wholesale in one large treewide patch.

Thanks,

Lukas

