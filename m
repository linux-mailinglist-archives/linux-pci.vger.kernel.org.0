Return-Path: <linux-pci+bounces-28365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC32AC2FBF
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 14:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79480166186
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 12:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9011A5B90;
	Sat, 24 May 2025 12:40:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E1123BE
	for <linux-pci@vger.kernel.org>; Sat, 24 May 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748090429; cv=none; b=XTedRIm8vM2+40kLqtw1TTUssoC+VnAasIEEenGIM/zhfT+BhHC7Q01tu/NMhX0JoTkoTP1PnhNzC8emu9lxFaNo+ZYMjZM2wHiS47L5neL2eQxGzdNFwpZRfN091RyHWTfhKv0mA6L1JiLSRDim6RpgmZ/04DMImBR2uLjrrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748090429; c=relaxed/simple;
	bh=Oied1YYcqdyDQ841iZ7QY4lgdKHitOt3zRIKYjDKgn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cde5iJccAOOgAOB+1IrM/wzluSDSFzUru/ZlCio6aBZ3pS60D2ezsSqlap1j+gRUPKN6oPlJfaWz3m8Mi5j3xqVxh70x3PPQrGZiafHKszApxQ+Eldfujf850+uuEfD+DL9KVvRzFV+USiWyFquOP/6pC6fadNg7loiNNuWYq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 285B220091A8;
	Sat, 24 May 2025 14:40:23 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 215B21EB477; Sat, 24 May 2025 14:40:23 +0200 (CEST)
Date: Sat, 24 May 2025 14:40:23 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: reset_slot() callback not respecting MPS config
Message-ID: <aDG-NzeW0fdIwall@wunner.de>
References: <aC9OrPAfpzB_A4K2@ryzen>
 <aDAInK0F0Qh7QTiw@wunner.de>
 <hqdp64mksr6whmncm5dhrjima32v5oyng4ov6hdklcamqtm4ib@prsatdutb5oj>
 <aDCLYl3y-4ktQrjH@wunner.de>
 <6jslic5nfxz3ywllriiw7uw6jwc6iz362nwuane6xam66kbv6a@x6krddl53mkg>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6jslic5nfxz3ywllriiw7uw6jwc6iz362nwuane6xam66kbv6a@x6krddl53mkg>

On Fri, May 23, 2025 at 09:00:27PM +0530, Manivannan Sadhasivam wrote:
> I thought that it *might* be possible to reset individual ports,
> so that's why I passed the root port 'pci_dev' to the callback
> in a hope that the controller drivers could use it to identify
> the root port they are resetting.

Makes sense.

> You are right. We should check if the parent bus of the bridge
> is a root bus or not.

Okay, that's simple enough:  pci_is_root_bus(dev->bus)

> Yes, pretty much so. I could rename it to reset_root_port(),
> since I still believe that multi root port setups may be able
> to reset them separately.

Conceivably, a PCIe host controller might also possess RCiEPs
in addition to Root Ports.  Those are allowed to be FLR-capable,
but could also be reset through a platform-specific means.

PCIe r6.3 page 121 defines the term "Root Complex Component",
which encompasses Root Ports but also RCiEPs.  So if you want to
be super generic, you could use that term in lieu of Root Port,
though it consumes more characters.

Thanks,

Lukas

