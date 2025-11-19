Return-Path: <linux-pci+bounces-41595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0E8C6DB9E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 10:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A919338785A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 09:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CC733C51B;
	Wed, 19 Nov 2025 09:26:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CFD33C521
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544406; cv=none; b=Ocwp5szUIX7tDV99O5XVy6U60h2RnNmZqEMtNsFuAimgEJRyNFYH9mW38OxXqlwYUP9vwrs6l5chAYgVwTXDiMVpPD6hSrZ0QbVr5lnQHSRxHh4nXvjakpFLh/Tt5Z2F0zEnErZa+TAdIp7r/8RTWgjf7t2eQO0OnULGzicLv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544406; c=relaxed/simple;
	bh=oNpTGsC4QvprmNrlInTE+PbgnX184cUJxLRiEWQALm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLqxlUagY2oYmtE4XV3fQzFx2k1QwSHsMLiCHYjAoVeKanmcSc6LKeger/9v2juEBZUNqT+Nkd2PUn0rh/lqlljMBhxhpz4Xso1DrrElALcDu3R45G40LAi4f1zNh3upDpZDkoc4ojPYkcrYmPYfhNBA6OyS6usl3omYBHVwtys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1B0E92C02BBE;
	Wed, 19 Nov 2025 10:26:42 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id EA318E7B1; Wed, 19 Nov 2025 10:26:41 +0100 (CET)
Date: Wed, 19 Nov 2025 10:26:41 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, qat-linux@intel.com
Subject: Re: [PATCH 0/2] PCI: Universal error recoverability of devices
Message-ID: <aR2NUbTQtD5nx1If@wunner.de>
References: <cover.1760274044.git.lukas@wunner.de>
 <20251114234543.GA2350415@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114234543.GA2350415@bhelgaas>

[trim recipients]

On Fri, Nov 14, 2025 at 05:45:43PM -0600, Bjorn Helgaas wrote:
> On Sun, Oct 12, 2025 at 03:25:00PM +0200, Lukas Wunner wrote:
> > Lukas Wunner (2):
> >   PCI: Ensure error recoverability at all times
> >   treewide: Drop pci_save_state() after pci_restore_state()
> 
> Applied to pci/err, maybe for v6.19?

Thank you!  Please note that the second patch (the treewide one)
was ack'ed by Giovanni Cabiddu:

https://lore.kernel.org/all/aQtgRy+zSVrvkZg+@gcabiddu-mobl.ger.corp.intel.com/

... so you might want to add that tag to commit 73f1f9b0a2c9
("treewide: Drop pci_save_state() after pci_restore_state()")
on the pci/err topic branch.

Thanks!

Lukas

