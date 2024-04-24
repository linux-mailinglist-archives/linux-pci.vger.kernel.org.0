Return-Path: <linux-pci+bounces-6624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2428B08D0
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 13:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277C41C20C49
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 11:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E89315A48B;
	Wed, 24 Apr 2024 11:58:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8C159919
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959910; cv=none; b=d+J8Et4HK5gjXt/s+5RilTEELE66WhkkZA9I/fo8B9Npu5+Y5GlLzN1TToO5K5MKVVNG4oDUinLK8vjUZlPxPB/UrUYBZsPIWnORW2Wb6oPj0p96nMKxO9Bx2BQ0gxDXUxUH0Zy8zxyC7dyUmTZOcGi97SltO2Qp3kqZkvBW6KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959910; c=relaxed/simple;
	bh=NeXDK5p3aNzw3rjcaMN51LxcwHpcq+bz8Z40G1upPMU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RygCdK9ztK7PeeE2hUBlPoVuPDd8rHDgIieMYaRy5AXkhdmDZgnDYc0I4oeKNxF97lkBc7WJLx0BYXZRhDSaGtgVakCccFZwGEsnxva8fpxmWfbQ2xqSWCmyQRrQ+XNmnaLKZuGBNj0xauLrmzH/o/jJSpIUnPEpmduQZWwsDf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0E63E92009C; Wed, 24 Apr 2024 13:58:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 0AEA692009B;
	Wed, 24 Apr 2024 12:58:25 +0100 (BST)
Date: Wed, 24 Apr 2024 12:58:24 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
    linux-pci@vger.kernel.org
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 218765] New: broken device,
 retraining non-functional downstream link at 2.5GT/s]
In-Reply-To: <20240423152330.GA441398@bhelgaas>
Message-ID: <alpine.DEB.2.21.2404241240530.9972@angie.orcam.me.uk>
References: <20240423152330.GA441398@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 23 Apr 2024, Bjorn Helgaas wrote:

> FYI.  The retraining was added by a89c82249c37 ("PCI: Work around PCIe
> link training failures").
> 
> Paul, is this a regression?  a89c82249c37 appeared in v6.5.  I
> *assume* whatever is below bus 01 did actually work before v6.5, in
> spite of the fact that apparently PCI_EXP_LNKSTA_DLLLA was not set 
> when we enumerated the 00:1c.0 Root Port?

Bjorn,

 Has <https://patchwork.kernel.org/project/linux-pci/list/?series=824858> 
gone anywhere?  I believe this would've addressed the issue of the delay.

 Over the last couple of months Ilpo and myself have been discussing the 
issue of clearing leftover LBMS state and Smita has literally just posted 
a proposed solution for that, which I haven't yet had time to go through.  
The combination of a new day job, overall shortage of time, and hardware
playing tricks with me has contributed to me not having made anything in 
this area recently.  I haven't lost interest though and I'll see what I 
can do.

  Maciej

