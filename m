Return-Path: <linux-pci+bounces-30561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F14AE7211
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 00:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB2E1892EF5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 22:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB2725A337;
	Tue, 24 Jun 2025 22:07:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFEE25A330;
	Tue, 24 Jun 2025 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802854; cv=none; b=ENUm3aP/NOH3t3pIQfgqJV+Tjw1djohgOoZ03J9JaksJeUCIfc+ibqLoHu5yWwHq78c8jTyOtwneSVYKkhWsM2FS6yN2OFlToqaXAlTmhQPuePSTTBfJhhz81GQq7njufbOOI2UL5MMNdlSsOJU5SdSXtzqHmM71mn9+eX3qDE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802854; c=relaxed/simple;
	bh=6If7XDwdxDI3bONWRISX9GcrX3VMrSPKzl+IHkdC3VQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KQYyLqIe5yh7+uWpQBZsGolXfrT60Wvcj7Qc2LTBQXM5OHQ2jUXPcc6ka0IsVeeCaNLAOAVsBcFSK/xb8SoJO4HINbfyWXQxKt2tNteW8m4HjFi0u1+7N49/jR4k2vdhff3cidTXiXD6fuC+AanHpu8ZtLi7/mTl6WAd6a3XflQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id AE1F192009C; Wed, 25 Jun 2025 00:07:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9EAAA92009B;
	Tue, 24 Jun 2025 23:07:28 +0100 (BST)
Date: Tue, 24 Jun 2025 23:07:28 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Jiwei Sun <sjiwei@163.com>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
    ahuang12@lenovo.com, sunjw10@lenovo.com, jiwei.sun.bj@qq.com, 
    sunjw10@outlook.com, Andrew <andreasx0@protonmail.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v4 0/2] PCI: Fix the issue of failed speed limit
 lifting
In-Reply-To: <20250624205441.GA1528511@bhelgaas>
Message-ID: <alpine.DEB.2.21.2506242302510.61655@angie.orcam.me.uk>
References: <20250624205441.GA1528511@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Jun 2025, Bjorn Helgaas wrote:

> > Jiwei Sun (2):
> >   PCI: Fix the wrong reading of register fields
> >   PCI: Adjust the position of reading the Link Control 2 register
> > 
> >  drivers/pci/pci.h    | 32 +++++++++++++++++++-------------
> >  drivers/pci/quirks.c |  6 ++++--
> >  2 files changed, 23 insertions(+), 15 deletions(-)
> 
> Sorry, this totally slipped through the cracks.  I applied both of
> these to pci/enumeration for v6.17.
> 
> Andrew reported tripping over this issue fixed by the first patch, and
> Lukas also posted a similar patch [1] to fix it, so I updated the
> commit log as below to include details of Andrew's report.
> 
> As Lukas did, I added a stable tag but made it for v6.13+ (not v6.12+)
> because I think the actual problem showed up with de9a6c8d5dbf
> ("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed"),
> not with f68dea13405c ("PCI: Revert to the original speed after PCIe
> failed link retraining").

 Thank you for taking care of these issues while I've been distracted with 
no resources available to actually try things in my lab.

  Maciej

