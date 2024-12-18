Return-Path: <linux-pci+bounces-18720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F088C9F6B48
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 17:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA877A1096
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52941F37C9;
	Wed, 18 Dec 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6Bxb+Ws"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238361F9A84
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539719; cv=none; b=dNQEz85rFxwGmQ28i3jUq+4hmbTPVDKOAPPn/xQRw2q8Y5qehlcJtgamCbPRfThnHFx9FjfjC1MjYyL9W596Z3I9eTVVADG0CgfYgIVE0pHsiz78sFb7HzFFddmoFz6pHTfH0JT8JQAT6qQJdJtoy0uMh0MhaIYPawIeJ0Mps6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539719; c=relaxed/simple;
	bh=5Qeud0hlfKqfjnQkNyBh9m0bx42Gm5iT1s3sP8bpxbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phGfObmpzmE3+LXkBNdhS/5uitQXgh7IWF6GKLJcPN8bFajAxAvsJO6du4bYb3RPsVLUZAqelkjEzQbiAQJQsXzd4jbECE3c+2OWmKcBnGuYEy9rGIACVwdKscKmf1KUuSHLsdyeFEuTczPvSbSiCvSyGyfIcrFXNgHDtMv09cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6Bxb+Ws; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734539717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p8iac//61liihadRi/lZrjLL09vXOaqSrKw2kN/ai+c=;
	b=d6Bxb+WsyNM4c6qLkY6M5lEkztld+q0MM+6je5iafp+eDzSK1r3USNwAFa8qV3XGItieHe
	NusSYG2Jhk7+UowBFVri6l78P1ZOdEIztECFIJ10eZlphMtipSzjK9bYIlcqXTi4SDZUHv
	5bvzRm+lM9AMgXD5w0Q4CXzbz8+/Cb0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-kM8NYVBwMkO8DDB3EbRSfw-1; Wed,
 18 Dec 2024 11:35:13 -0500
X-MC-Unique: kM8NYVBwMkO8DDB3EbRSfw-1
X-Mimecast-MFC-AGG-ID: kM8NYVBwMkO8DDB3EbRSfw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFB3319560AB;
	Wed, 18 Dec 2024 16:35:09 +0000 (UTC)
Received: from localhost (unknown [10.22.80.196])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B757D1955F41;
	Wed, 18 Dec 2024 16:35:08 +0000 (UTC)
Date: Wed, 18 Dec 2024 13:35:07 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ryo Takakura <ryotkkr98@gmail.com>, bhelgaas@google.com,
	jonathan.derrick@linux.dev, kw@linux.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, nirmal.patel@linux.intel.com,
	robh@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] PCI: vmd: Fix spinlock usage on config access for RT
 kernel
Message-ID: <Z2L5u40lDvK7_Gdb@uudg.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2LxAU0U_G5wI_2M@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Dec 18, 2024 at 08:57:53AM -0700, Keith Busch wrote:
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

Sorry, I also missed that and induced Ryo Takakura to rewrite the patch.

Luis


