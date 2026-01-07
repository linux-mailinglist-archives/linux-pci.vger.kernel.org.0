Return-Path: <linux-pci+bounces-44165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F23CFD110
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 11:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 266ED3002896
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 10:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6DE2D23A5;
	Wed,  7 Jan 2026 10:01:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84125248868;
	Wed,  7 Jan 2026 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780069; cv=none; b=jOzAR8yTkdR5SsXKJHs1qztEWt2odSNV1NbY4Rc3NN+21VqHDyDrHVAVpq/mr+k9RYP2CH3gTECPGn7mRtq+nFrbwO8MGnPnUOlkKABZSS3in81PK9L3ZM5xHdKA4G3oY69/mIxzPu62dqJLidstlJs3bR8izmZbZMqv+Pw0BBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780069; c=relaxed/simple;
	bh=9AN/as1mCSm39ZJL7zdB6E6tE3aLfIuQS8uHK1Sh+Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK/j5PJMykVub45EU9lhqgKdPTDTFMHiWZg6OjKoKymSNOCCk8icHCoE1TvkyMmM+rpf1avhFomdeM/rzHZ3NHDUnnwYq+tOqs5TI78/ubwflYAWmOJFBENyb3zGqtpHaFUual1TX5Q6YVJqD7x6d3QXbJCkxTJBxC1bJhG+kdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id B3E732C06AB1;
	Wed,  7 Jan 2026 11:01:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9E81F3098E; Wed,  7 Jan 2026 11:01:04 +0100 (CET)
Date: Wed, 7 Jan 2026 11:01:04 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
	andreas.noever@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
	feng.tang@linux.alibaba.com, helgaas@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com, westeri@kernel.org
Subject: Re: [PATCH] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Message-ID: <aV4u4Hxnxbvo8FMr@wunner.de>
References: <20260107093021.GN2275908@black.igk.intel.com>
 <20260107095435.1390-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107095435.1390-1-atharvatiwarilinuxdev@gmail.com>

On Wed, Jan 07, 2026 at 09:54:33AM +0000, Atharva Tiwari wrote:
> I've been using the mainline kernel
> (which I compiled about two weeks ago),
> and the problem still isn't fixed,
> so PTM is most likely not the root cause.

The commit Mika called out went into v6.19-rc1, we're now at v6.19-rc4,
so unless you're closely tracking Linus' tree, I'm afraid you may not
have been using a recent enough kernel to verify Mika's suggestion.

Thanks,

Lukas

