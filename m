Return-Path: <linux-pci+bounces-18714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F769F6A2D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 16:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF8716F968
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F731B425A;
	Wed, 18 Dec 2024 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckZyT4wE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDEE83CD2;
	Wed, 18 Dec 2024 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536218; cv=none; b=cavfN3bXHyht5wCOfLNa79zRS+ntNuxAWJOjTFoviXpn4YsfqeuTwMG0mz3hD6oeS5BZarvQpV/6ek6y59oLz48lg/abK6AQWcZFHwZsRWZs80V6AFoBlWgWx8bbgw05EiJaPTCMELHWxZ7yCacexX6jKRCxxxSXACjjRA4Uv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536218; c=relaxed/simple;
	bh=pV53DNsEAQUUqEbKTuBTU79zFR/OgRoI0q7N2gO9G1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfrm45A8xiZEq9a+LX4BmQhGKfOk5rCXNHht64nXlP9k86fe18hJnuhI7IO0JfnWweWaspECKsa5YiBM3SGRVyUP8m9n4J4hV0f8VnlNS9zjkbS+pd7iMjSavw770hoyVGMXkM2jk+oYNAk501lpEzKsgiVVBc9dFTwEr/IJt/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckZyT4wE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64A6C4CECD;
	Wed, 18 Dec 2024 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734536217;
	bh=pV53DNsEAQUUqEbKTuBTU79zFR/OgRoI0q7N2gO9G1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckZyT4wEZOVTcStFkB+JOGy0TQHpJwlbfMyNFzZ65TisvEg0JUYC0PJHMv9sDTm/q
	 6N+gCtAgw1tiBQpgpftf+sLfV38mgo6IqjatV4XRVj0S4mycmOvr9OQ81Z1FAQVvfO
	 LGro7QI2lbXT4mRUOJu6Xop6Spg0NwpYO+drshUZZoWUKozqcKfh67K6OdQPPC9M2N
	 xmhT7XHRH7k7/dwXq1CX+m5qP8gelpq+mYdVUQ69Mwa1PSE8NPnmB0fMkTVqu1KEkm
	 YBJ6huDSaCJa+i2bZi9sNFeFdfDzL7p+6ey5CM53oZYJn+lojtvWpmYCO4nIlnlJ+p
	 sWVU2so7Ch85A==
Date: Wed, 18 Dec 2024 08:36:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: lgoncalv@redhat.com, bhelgaas@google.com, jonathan.derrick@linux.dev,
	kw@linux.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, nirmal.patel@linux.intel.com,
	robh@kernel.org, bigeasy@linutronix.de, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] PCI: vmd: Fix spinlock usage on config access for RT
 kernel
Message-ID: <Z2LsFoXotl_SHmNk@kbusch-mbp.dhcp.thefacebook.com>
References: <20241218115951.83062-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218115951.83062-1-ryotkkr98@gmail.com>

On Wed, Dec 18, 2024 at 08:59:51PM +0900, Ryo Takakura wrote:
> PCI config access is locked with pci_lock which serializes
> pci_user/bus_write_config*() and pci_user/bus_read_config*().
> The subsequently invoked vmd_pci_write() and vmd_pci_read() are also
> serialized as they are only invoked by them respectively.
> 
> Remove cfg_lock which is taken by vmd_pci_write() and vmd_pci_read()
> for their serialization as its already serialized by pci_lock.

That's only true if CONFIG_PCI_LOCKLESS_CONFIG isn't set, so pci_lock
won't help with concurrent kernel config access in such a setup. I think
the previous change to raw lock proposal was the correct approach.
 
> @@ -385,13 +384,11 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>  {
>  	struct vmd_dev *vmd = vmd_from_bus(bus);
>  	void __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
> -	unsigned long flags;
>  	int ret = 0;
>  
>  	if (!addr)
>  		return -EFAULT;
>  
> -	spin_lock_irqsave(&vmd->cfg_lock, flags);
>  	switch (len) {
>  	case 1:
>  		*value = readb(addr);

There's a comment above this function explaining the need for the lock,
which doesn't make a lot of sense after this patch.

