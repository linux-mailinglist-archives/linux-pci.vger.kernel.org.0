Return-Path: <linux-pci+bounces-32241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8FCB06FC2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 09:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFE2189F0AA
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 08:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2882928CF5E;
	Wed, 16 Jul 2025 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TbIJ5b9p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u+0xHGWs"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37642877C8;
	Wed, 16 Jul 2025 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652793; cv=none; b=p/llFgAYoC5Jue2/nx/j60QQ+Pwx0JeKqmkZO9lGi4J0+7wlrF8eASQKzOkpSuzeWcIjyQhR2UP+UC7RExCDbFRUAzQX1GV4/vS4bHxq2oNhoHw8hwev9Vp2wrUPLnPnnWLLL97m4I6YocdNDDVikPnM4AYZXcl5vVoZ+25Qntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652793; c=relaxed/simple;
	bh=Ar0Xb/Uf8JcXVLRgVcSyG1l0VNAQj6K9qFOU9YD1KGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEl03w/Usa6MVWf1P/irrXbXETpwCG73v317fPBIS2MDqElXhSfNMaSLM3EBr9bKZwlyMjUOgMwF1gzPM+57J2IWiKIBt6WYOTY8HbCrgz4Ur4LlqI4Kakeo3NwLT8QrEd4cuNJsABJOhZk1Dsz+JYJ9V07PdC360z8iQECXGUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TbIJ5b9p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u+0xHGWs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 09:59:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752652784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNqMoBx61d+HMyv4cP0TPSF1O81dNABhWxIpn3gpQyY=;
	b=TbIJ5b9pDaeCsnZ8PUhEMT7Y3+Iga0EcCg09V0TNLdpWOGdr7x407Y8U6AE2pciN8pn+Tm
	UjEEKtNC84cf9m5lSVTLU6ea55Lfe4lgUiJhaKCv5ac3KxPNxiaVV7TrgoXB1MxhUFSh3J
	8f7yRDyP/3rVxtmLOy25GwjtfE4BW/14NziCxoqkpJXNQdpdQ9XLSb/e4bvwWhLhFBN2mU
	+Xf8sm/fUJS1rNi0o846TLyPFhI+WlBUHqJeI+qzC9vIzYRSwhF9L9O4uzhvUnMu+izMLb
	OV2CGcw+7YUUgSsxBdC9hz9/vJBOv+tBTnHidqNv34BWh3C/2gIg4MqviN9QOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752652784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NNqMoBx61d+HMyv4cP0TPSF1O81dNABhWxIpn3gpQyY=;
	b=u+0xHGWsSbGWdBLjEvD4tgttGTvUnfDq9Xeehwcp0Rjrwkhc07ykuhUFysc6gbxcDZn4j9
	dL+pqY6yoTQ6abDQ==
From: Nam Cao <namcao@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/controller: Use dev_fwnode()
Message-ID: <20250716075942.2aCLkdCs@linutronix.de>
References: <20250611104348.192092-16-jirislaby@kernel.org>
 <20250715184917.GA2479996@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715184917.GA2479996@bhelgaas>

On Tue, Jul 15, 2025 at 01:49:17PM -0500, Bjorn Helgaas wrote:
> On Wed, Jun 11, 2025 at 12:43:44PM +0200, Jiri Slaby (SUSE) wrote:
> > irq_domain_create_simple() takes fwnode as the first argument. It can be
> > extracted from the struct device using dev_fwnode() helper instead of
> > using of_node with of_fwnode_handle().
> > 
> > So use the dev_fwnode() helper.
> > 
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > ---
> >  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 5 ++---
> >  drivers/pci/controller/pcie-mediatek-gen3.c          | 3 +--
> 
> I think the pcie-mediatek-gen3.c part of this is no longer relevant
> after Nam's series [1].

fwnode is still needed after my patch. As part of
struct irq_domain_info info = { ... }

You could squash this one into my patch. I personally would leave it be.
But fine to me either way.

> This pcie-mediatek-gen3.c was the only thing on the
> pci/controller/mediatek-gen3 branch, so I'm going to drop that for now.
> 
> The pcie-mobiveil-host.c part is still queued on
> pci/controller/mobiveil for v6.17.
> 
> [1] https://patch.msgid.link/bfbd2e375269071b69e1aa85e629ee4b7c99518f.1750858083.git.namcao@linutronix.de

Best regards,
Nam

