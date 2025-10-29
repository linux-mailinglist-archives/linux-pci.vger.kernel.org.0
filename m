Return-Path: <linux-pci+bounces-39626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74EC19DBD
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 11:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0157D1C60168
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983A030ACFD;
	Wed, 29 Oct 2025 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DEZRPqDs"
X-Original-To: linux-pci@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F88B3314D2;
	Wed, 29 Oct 2025 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734322; cv=none; b=pIx2Fp68Sl0x4fQ/TnEzF/sHZ3sfU78JENJAvf0/4iTO5Zouk+5eFGTgt6xj8zb7SZCXM8UTA59FZAIA+eCp59UT5n2bXg5BjI87Pox3/kTJi3Di8xxSuon2N1PBKPeKVzMWQbYCN2hzo342CxmmpDYawUUEDNTX5jqAtqwwtGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734322; c=relaxed/simple;
	bh=pIiDWLMcHPNCDu3VDDj3WW+NPX3JVHfK9+0n29qJrXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5WNMn9HxlmOI8qdprFZxqIdlWcELhNW8JwI6B2TFUPSRH9ikLqO/F+cEA0Ax4bA+gnvfuXbR2A8Rjp5oCvT7mRxkVxNL69qcgd87thSGoyLs9HpKCZp0SOvx4DoB6ZLX9/5tModHBxwWTcPqcfN+b+FxwIdjn9jwPBSyqP6W4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DEZRPqDs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VCeTPmprwIZqHHyx9w+bCB29D5ZTBfMPAZYy5YtbKRg=;
	t=1761734320; x=1762943920; b=DEZRPqDsNiIBrah0BMQ0jAQebI4BA0vyf8HMDb4dI8AgqMz
	iLiBCh4RSgvD51eZYu0Z2fOGgfC1/4aZ48rmhfX7VVFAHzmsDSW0lgrI8g9Op7iVwo8/qNxOtkwMS
	OArEDUeSr8k2Jzpc2Y0Of471Yqcks5iIYEinWslVjo3TBoUklcGnUm28yPW6YKv21BPf27/vfVj4r
	MtBAy6XqbD3WCAPSsTG37LYwn5CLz58R8HmSfMajAF/MHR9/o8D7Vr94c9535YIwplQYq65SXH3Pf
	+Fk+hQhCxKHbUu0lK/8md9QYi1LQndVcscouqH/KtLlpbDJuSVga6+AlxM547HcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vE3ZY-0000000EUxl-0BPl;
	Wed, 29 Oct 2025 11:38:32 +0100
Message-ID: <44428a7c1e1d4565556335d6fb28919053da5d4d.camel@sipsolutions.net>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Support function level reset
From: Johannes Berg <johannes@sipsolutions.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>, Luiz
 Augusto von Dentz <luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
 <linux-bluetooth@vger.kernel.org>,  "linux-pci@vger.kernel.org"	
 <linux-pci@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
 "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "K, Kiran"
 <kiran.k@intel.com>, "Ben Ami, Golan" <golan.ben.ami@intel.com>
Date: Wed, 29 Oct 2025 11:38:31 +0100
In-Reply-To: <20251028210640.GA1529794@bhelgaas>
References: <20251028210640.GA1529794@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-10-28 at 16:06 -0500, Bjorn Helgaas wrote:
> > Obviously, we know the state of the device, but ... it _does_ require
> > PCI removal *and* rescan, because the device completely falls off the
> > bus and needs to be rediscovered. The drivers also fundamentally have t=
o
> > be unbound from it, since all state of the device (including BAR setup)
> > is lost. I'm fairly certain that if you were to query even the device
> > IDs after the reset, you'd see 0xFFFFFFFF, but in truth I don't fully
> > understand how this works at the PCIe bus level.
>=20
> It might be different for other buses, but the PCI core really doesn't
> do anything to the device during removal or rescan.  It does turn off
> power management interrupts from the device and the like, but I'm
> pretty sure it doesn't reset the device or do anything to make it
> start responding to PCI transactions again.

OK, fair. I have hit various weird issues with cached config space in
the past (such as [1], which we never resolved), so I guess I'm possibly
being ultra careful here in what I'm assuming or not.

[1] https://lore.kernel.org/linux-pci/20230605203519.bc4232207449.Idbaa55b9=
3f780838af44ebccb84c36f60716df04@changeid/


> Obviously remove and rescan reinitializes the *driver* because the PCI
> core calls the driver .remove() method, reads the Vendor and Device
> IDs, reads and if necessary programs the BARs, and calls the driver
> .probe() method.

Right. So I guess in effect you're saying that device_reprobe() ought to
be sufficient.

For WiFi, this code goes back to another issue we had (somewhat
intentionally) where under certain circumstances during initialisation
the firmware can do a product reset without the driver being aware, and
then the driver just has to detect it by PCIe transactions failing with
0xFFFF'FFFF being read all the time. It's going to be hard to test this
case now, but we can still test the product reset.

For BT detecting the error and initiation product reset, it does seem
that doing (only) device_reprobe() for both functions is actually
sufficient. I believe the FLR code in BT is broken though, so we're
going to (re-)check all of this.

> I think it's really the PLDR that's making the difference here, not
> the remove and rescan.  I guess you could experimentally read some
> config registers after the PLDR and before the remove/rescan.

Yeah, just need to find real hardware with all the BIOS integration to
run it ;-) (Most of our testing uses VMs.)

> Since you know the other device is dead already, I don't have a
> problem with resetting the shared parts of the device, so you do need
> some way to poke the other driver to reinit.  But I think using the
> PCI core remove/rescan to do that makes it more complicated than
> necessary and distracts from what's really happening.

Fair. I think the easiest way to achieve this is still device_reprobe()
on the other device - eventually even if we tell the other driver then
it still will simply call device_reprobe() on itself, so there's no big
difference.

Thanks,
johannes

