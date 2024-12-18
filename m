Return-Path: <linux-pci+bounces-18718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008379F6AB1
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 17:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAB7171979
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BB6198822;
	Wed, 18 Dec 2024 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HQcDSI+M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eFw1OrdA"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFB3145B1D;
	Wed, 18 Dec 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537801; cv=none; b=fr2u86h7HRs13H8I35OX2LQ/fCG09Z1C4elNjdYEA0x3GdsJA3VL1RwSH2ZB9xtrYP+VutE2JNJlJV6FCXLyKAecCad2AIJGZCwQMNMGbw4/tKHJOLTFib09eVDj2m7XbfjBCrInX7XWT0L6SUdp7IY2nPOUShOqmVCnVr3jtCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537801; c=relaxed/simple;
	bh=Si/VAs3+6Saj2eWKNnvuJJ/Mt+JRj8McFgux9WjQOUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN4F3YU7LpKmZafPHF2vo6Y7pXXk8Bt8UwAtDeeQosL3faU2OYtysn7nUpfnyqyR2iQp8c2jijT2wuQuK4nWJL3YF00qmiw1naFFfDy+TQ9D5Zo8qslIjPt9hXzj6m5okAQ67+tigpA4etljBKwEn5I9V8Oxwc4lqoomvDSCo68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HQcDSI+M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eFw1OrdA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 17:03:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734537798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gseOPJ3O68lx3hSAAMu7P/vaf8EmvlWF2AeUxqoAXao=;
	b=HQcDSI+MJgNckYZejbkRNSHS67i5qXV0USZeQVgO8gqzbbKIB4u/C0HVhELb/S+blysoeb
	f8QiemXRMe4Lw7Ae+ixP/a/dN8oIc1tTgFiI+T6RdweG8n37ZzA+kVG3XfkNPRfbqfGOBz
	wVYDRmwYO1/bK4QYewL+XGPXTiLgknu/XWYcLf2c+vBDnJVf3ippDXlCHxR7qDUb2JM449
	zo3hZ1IMNrKdv8Xolq1WlP2ow2pe2TnpjX2p5GMfpZFjG2UoZD+NsV4tlLMVHZ/I80DFT9
	t3hPuiCZD8yHXQVUj7yx5+K7q/A0gMJyWrxttAHPXf2QfQGavcoH0bQm2lsR3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734537798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gseOPJ3O68lx3hSAAMu7P/vaf8EmvlWF2AeUxqoAXao=;
	b=eFw1OrdA5J7ny+gBbwdZqmZcB6e1IGN9PaPe/SUrGiJ9KsM5BYUeP8n4iuIIgiIQjBPMpt
	k3w8ZMds/hmfL1DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Ryo Takakura <ryotkkr98@gmail.com>, lgoncalv@redhat.com,
	bhelgaas@google.com, jonathan.derrick@linux.dev, kw@linux.com,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	nirmal.patel@linux.intel.com, robh@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] PCI: vmd: Fix spinlock usage on config access for RT
 kernel
Message-ID: <20241218160316.NHEIKDfT@linutronix.de>
References: <20241218115951.83062-1-ryotkkr98@gmail.com>
 <Z2LsFoXotl_SHmNk@kbusch-mbp.dhcp.thefacebook.com>
 <20241218154838.xVrjbjeX@linutronix.de>
 <Z2LxAU0U_G5wI_2M@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2LxAU0U_G5wI_2M@kbusch-mbp.dhcp.thefacebook.com>

On 2024-12-18 08:57:53 [-0700], Keith Busch wrote:
> On Wed, Dec 18, 2024 at 04:48:38PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2024-12-18 08:36:54 [-0700], Keith Busch wrote:
> > > On Wed, Dec 18, 2024 at 08:59:51PM +0900, Ryo Takakura wrote:
> > > > PCI config access is locked with pci_lock which serializes
> > > > pci_user/bus_write_config*() and pci_user/bus_read_config*().
> > > > The subsequently invoked vmd_pci_write() and vmd_pci_read() are also
> > > > serialized as they are only invoked by them respectively.
> > > > 
> > > > Remove cfg_lock which is taken by vmd_pci_write() and vmd_pci_read()
> > > > for their serialization as its already serialized by pci_lock.
> > > 
> > > That's only true if CONFIG_PCI_LOCKLESS_CONFIG isn't set, so pci_lock
> > > won't help with concurrent kernel config access in such a setup. I think
> > > the previous change to raw lock proposal was the correct approach.
> > 
> > I overlooked that. Wouldn't it make sense to let the vmd driver select
> > that option rather than adding/ having a lock for the same purpose?
> 
> The arch/x86/Kconfig always selects PCI_LOCKESS_CONFIG, so I don't think
> the vmd driver can require it be turned off. Besides, no need to punish
> all PCI access if only this device requires it be serialized.

Okay. That makes sense.

Sebastian

