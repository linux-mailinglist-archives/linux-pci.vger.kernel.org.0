Return-Path: <linux-pci+bounces-35173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C2CB3C93A
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 10:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E014EA2657A
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD0E29BD89;
	Sat, 30 Aug 2025 08:12:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B212BD012;
	Sat, 30 Aug 2025 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756541575; cv=none; b=ogvaWWzTtVlLMfWEjj2oAVQdDPVLml7JDdLeFAJnf3uV0q9yJXmMo4afaRrz4bZ3Vy8ApmyRqSN4HTwm14CL//f9jLYYPOfo9FfuaKnHM+yM0JMxEMkPweKLqpvx0fhBikaO08xkJyfHdPW4I8ErHM2davNIeKUSPShyLcnGRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756541575; c=relaxed/simple;
	bh=0Qsv2NDtSw5dFzo+jOgeWEX/UzFBI5BN3ERw/nxoX2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcjuleN9QWvGRJIa1w8SH6xRgJW/XrDR/qN6gOxJItAUI1n1u+wN8IlBu15vT2Npzs1BUpFZuRWbgHa29gE7funvMoFDOBg2qSPN9YvUv0qWpWzsTKSN8fzYNt2smEHn/G8TwPOY2p0Sj+fAqqmz9+1QZJ227FPfbZu3E9DzEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6CBCE2C051E5;
	Sat, 30 Aug 2025 10:12:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2F6123AA697; Sat, 30 Aug 2025 10:12:44 +0200 (CEST)
Date: Sat, 30 Aug 2025 10:12:44 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Linas Vepstas <linasvepstas@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Terry Bowman <terry.bowman@amd.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 3/4] PCI/ERR: Amend documentation with DPC and AER
 specifics
Message-ID: <aLKyfNHC2hz__BCS@wunner.de>
References: <cover.1756451884.git.lukas@wunner.de>
 <42726e2fd197959d6228d25552504353ffb53545.1756451884.git.lukas@wunner.de>
 <CAHrUA364QSpcJOu=96JV-3hR9G5M0FSUPNhb4AspULAcXvQP6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrUA364QSpcJOu=96JV-3hR9G5M0FSUPNhb4AspULAcXvQP6w@mail.gmail.com>

On Fri, Aug 29, 2025 at 06:25:08PM -0500, Linas Vepstas wrote:
> On Fri, Aug 29, 2025 at 2:41AM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > +   On platforms supporting Downstream Port Containment, the link to the
> > +   sub-hierarchy with the faulting device is re-enabled in STEP 3 (Link
> > +   Reset). Hence devices in the sub-hierarchy are inaccessible until
> > +   STEP 4 (Slot Reset).
> 
> I'm confused. In the good old days, w/EEH, a slot reset was literally turning
> the power off and on again to the device, for that slot. So it's not so much
> that the device becomes "accessible again", but that it is now fresh, clean
> but also unconfigured. I have not studied DPC, but the way this is worded
> here makes me think that something else is happening.

With DPC, when a Downstream Port (or Root Port) detects an error,
it immediately disables the downstream link, thereby preventing
corrupted data from reaching the rest of the system.  So the error
is "contained" at the Downstream Port.

It is then necessary for system software (i.e. drivers/pci/pcie/dpc.c)
to "release" the Downstream Port out of containment by re-enabling the
link.  This happens in dpc_reset_link() by writing (and thus clearing)
the PCI_EXP_DPC_STATUS_TRIGGER bit in the PCI_EXP_DPC_STATUS register.

In-between, the devices downstream are inaccessible.

Disabling the link results in a Hot Reset being propagated down the
hierarchy below the Downstream Port.  So there's no power cycle
involved.  After the link is re-enabled, devices are in power state
D0_uninitialized and need to be re-initialized by the driver in
->slot_reset() and/or ->resume().

If you feel the above-quoted paragraph isn't accurate or complete
or doesn't capture this sequence of events properly, please let me
know what specifically should be rephrased / amended.

Thanks for taking a look!

Lukas

