Return-Path: <linux-pci+bounces-30885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499E6AEAC07
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 02:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CB23BB239
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 00:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33234171D2;
	Fri, 27 Jun 2025 00:54:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B2F9460
	for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750985680; cv=none; b=JXIqRIkLMkU/q08RjnPw7uMFF3r6Y2OtHdxyK60xqiCyX98kv72MnpOGg9l7tCxecIN8PldAEMJ4eY2dtLTqtHgofpYJy2Vpkkb3RNWzg4J4tbLeoM5LurYp6T+EMyxvL6GG7ZRBwjpHDHeEjXZ2H+sBMaYbpTanLaCmI/JTb+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750985680; c=relaxed/simple;
	bh=LF08KnzXJwvn80n6UjK0PCmMKTu7Z472ZeU5tziIrYU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dTfAMkeI7238EPA6WFM43RB571wo9HTFVi+Ip2CSTVnI26qUF1WyNHvNYF6f/Wovk/FUgGP8NjXx2vLPDCNQxSgpoeeXu22EMAnO5QwCHC9WNXQKz0JPkPGO+lnrIf7h6VnN2+I2c1//xQqDbOfyxzdiEulQx1SrW/cODtJdyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id D435C92009C; Fri, 27 Jun 2025 02:54:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id CFD1A92009B;
	Fri, 27 Jun 2025 01:54:26 +0100 (BST)
Date: Fri, 27 Jun 2025 01:54:26 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Matthew W Carlis <mattc@purestorage.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    ashishk@purestorage.com, msaggi@purestorage.com, sconnor@purestorage.com
Subject: Re: [PATCH 0/1] PCI: pcie_failed_link_retrain() return if dev is
 not ASM2824
In-Reply-To: <20250627002652.22920-1-mattc@purestorage.com>
Message-ID: <alpine.DEB.2.21.2506270140430.13975@angie.orcam.me.uk>
References: <20250627002652.22920-1-mattc@purestorage.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 26 Jun 2025, Matthew W Carlis wrote:

>   I have reached out several times about issues caused by the
> pcie_failed_link_retrain() quirk. Initially there were some additional changes
> that we made to try and reduce the occurrences, but I have continued to
> observe issues where hot-plug slots end up at Gen1 speed when they should not
> have been or the quirk invoked when the link is not actually training at all.

 Have you verified that with a fix[1] applied for a regression introduced 
by commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set 
PCIe Link Speed") discussed in the other thread[2] you can still see those 
issues?

References:

[1] "PCI: Fix the issue of failed speed limit lifting", 
    <https://lore.kernel.org/r/20250123055155.22648-1-sjiwei@163.com/>

[2] "PCI: Fix link speed calculation on retrain failure",
    <https://lore.kernel.org/r/1c92ef6bcb314ee6977839b46b393282e4f52e74.1750684771.git.lukas@wunner.de/>

  Maciej

