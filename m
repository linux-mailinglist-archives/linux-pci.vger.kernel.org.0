Return-Path: <linux-pci+bounces-39848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FFCC223C0
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 21:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D99D466A1B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 20:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1566F329E56;
	Thu, 30 Oct 2025 20:16:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF239329E41;
	Thu, 30 Oct 2025 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855369; cv=none; b=kGEvDWq5mGtCWrYT96nc3E2uBio4q0cG2meAWwjtOHaT7ortIQv4wi/e7X4ESjqB2h1HF5811bw0TWR4e+R/b57OMHx2zYLYvMDK+7411O6DuvOkIB5dGkRlujmtrdOXMj7CRTOxNYH/AZOTQ8soyWJ0tfPibkSmHsXm1AK+1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855369; c=relaxed/simple;
	bh=BCTybeK7kbZPZoR7hVsfW499Ax65jB45Y6OolRAkkYY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P5LuysHR60sqmgz6edBX97eHxi6O0msVLYXJPVTcUVxzrGd4id3EROceNiSbsR4KcUwzpGlHm3C26dKNnzBTek8DzKV6VUpjtNn04zvm2hv/73mKUFvbiIAfGxRbE9wGyCmYBTh9Bj9mMqIh5UTmstM7EcuJynFZVSa3/oZhLE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 6C88692009D; Thu, 30 Oct 2025 21:10:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 60ED392009C;
	Thu, 30 Oct 2025 20:10:17 +0000 (GMT)
Date: Thu, 30 Oct 2025 20:10:17 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Thierry Reding <thierry.reding@gmail.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
    linux-mips@vger.kernel.org, loongarch@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
    linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] MIPS: PCI: Use contextual data instead of global
 variable
In-Reply-To: <20251030153121.GA1624982@bhelgaas>
Message-ID: <alpine.DEB.2.21.2510302003120.1185@angie.orcam.me.uk>
References: <20251030153121.GA1624982@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Oct 2025, Bjorn Helgaas wrote:

> It does complicate maintenance though.  I think all of mips ultimately
> uses register_pci_controller() and pcibios_scanbus().  Neither really
> contains anything mips-specific, so they duplicate a lot of the code
> in pci_host_probe().  Oh well, I guess that's part of the burden of
> supporting old platforms forever.

 FWIW new MIPS hardware continues being manufactured and if there is 
anything needed to clean up in generic MIPS/PCI platform code, then that 
can certainly be scheduled, subject to developers' resource availability.  
Individual MIPS platforms may vary of course, and with the solely legacy 
ones it will depend on the availability of hardware and engineers willing 
to maintain it.

  Maciej

