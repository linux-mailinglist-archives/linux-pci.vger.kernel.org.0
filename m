Return-Path: <linux-pci+bounces-35281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446FFB3EAF8
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 17:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6643B68FE
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91DE2EC08C;
	Mon,  1 Sep 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ors65SUB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BBA2EC0AE;
	Mon,  1 Sep 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740371; cv=none; b=GeniM8edF4QSsCk3WHEOMyVkineuTaCYzTSaM06NY40vA3fD+vW/8KkdPx3tzW296lO0zCxbZ0wZ4xBdtjzNwE8YNx8iMjkzeZfgeNsBAm2fW+fp3eEJFCl8Nbl1oXuO3+DzjqBuQ8GcXe5vttxyInEacf8Hkto8GtnfDnhGTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740371; c=relaxed/simple;
	bh=M5aHzYQAvwRvc1NBqMpzXH45laDa9yugTUcECcR0yCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EZtz5mhi5oY/LS6N+5kslYuTKVEiyWsPBGff5tNREZY5peYdu0BYylqmLiqR4eveoDZPNAOBRuv1ahnH853l3dlJEYPKDv9VoMAqWoTNAD/zuPEVDAdVpXdDYxlNyh0pbjkATIMonq1L8pQiqe0lgkgi+liO+7vgUCsdCLyAf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ors65SUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C37C4CEF1;
	Mon,  1 Sep 2025 15:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740371;
	bh=M5aHzYQAvwRvc1NBqMpzXH45laDa9yugTUcECcR0yCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ors65SUBhX4j/+CAYcjVVyuDHKj3yp4i9rAV4bvVnt1ZBHQsFk6rQdOP3TIPE6JW0
	 3q4uzvRVjG2ocCyqYdGvTqF9e3mmDyfp/JhVEAasr0/PlRbfnEmeD6JK1r9bsN1kEO
	 XZExUl/LaBu/woeJMacyr5y6DquhZvSLdxMUSJu9M/Zcb3BmlSSj3dzfjNXQWuRAdw
	 QsWu8aAyFTRfR4/eCWoCVpbcxzap47J3MX8XOmCXOquCK8vCxm9KemXXdi44c2ALs+
	 88ZzchqhWp7K4qSdvpk2frL5wli3BGrNhFyVc1n9JCPJYNQu2SmzP9RsHbcP8eUswG
	 79uTQlT+enkBA==
Date: Mon, 1 Sep 2025 10:26:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Longbin Li <looong.bin@gmail.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
Message-ID: <20250901152609.GA1114913@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901152452.GA1114741@bhelgaas>

On Mon, Sep 01, 2025 at 10:24:54AM -0500, Bjorn Helgaas wrote:
> [cc->to: Thomas]
> 
> On Mon, Sep 01, 2025 at 01:35:17PM +0100, Mark Brown wrote:
> > On Wed, Aug 27, 2025 at 02:29:07PM +0800, Inochi Amaoto wrote:
> > > For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> > > the newly added callback irq_startup() and irq_shutdown() for
> > > pci_msi[x]_templete will not unmask/mask the interrupt when startup/
> > > shutdown the interrupt. This will prevent the interrupt from being
> > > enabled/disabled normally.
> > > 
> > > Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
> > > cond_[startup|shutdown]_parent(). So the interrupt can be normally
> > > unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.
> > 
> > Tested-by: Mark Brown <broonie@kernel.org>
> > 
> > This is causing multiple platforms to fail to boot in -next, it'd be
> > great if we could get it merged to fix them.
> 
> It looks like you merged 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown
> for per device domains"), Thomas.  I assume you'll merge this fix too?
> 
> Let me know if you'd prefer that I take it.  Looks like a candidate
> for v6.17.

Oops, looks like there's a v2:

  https://lore.kernel.org/r/20250827230943.17829-1-inochiama@gmail.com

