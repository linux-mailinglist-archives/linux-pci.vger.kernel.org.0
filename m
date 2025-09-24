Return-Path: <linux-pci+bounces-36828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AF8B98298
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 06:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA6F1B20449
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 04:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FCB1EF091;
	Wed, 24 Sep 2025 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3itz8Je"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF427262E;
	Wed, 24 Sep 2025 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758686457; cv=none; b=R1T4EuAg3CADALoUkqaT+ZwJmntspysNN9ha+GkzUITx1RQXwDRMNLAlQrfWqIxXhVl4/hGFQfu7pN51Z/XiE4R84q/cJfOF1/bRuV1IFC59pnLtpTHTr+2smeRNyRI0B0defBacfPy3i1GPV5cZsvgb2s+zIKMBJgtmkU+5pvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758686457; c=relaxed/simple;
	bh=FlVkJiHVn3tV2L8XPm/j5zvtkE2PMBWJ6H5eopSmDUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VajFkfuXubP40qd9n8bQeKcQYHTg4LJbgG+1LwkqF89qIyG3vrABy4u1vnuWCBBZFcbpvPTjjwlPDtpQl0jTk+IvDRG2MqcfOhCa9UBWnpSBgKQt4sRL549sdVsKPfgeobliicKR1VLCmpUxe0qnlUavjUAEr7Xs6Ii8NDwqDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3itz8Je; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A900C4CEE7;
	Wed, 24 Sep 2025 04:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758686456;
	bh=FlVkJiHVn3tV2L8XPm/j5zvtkE2PMBWJ6H5eopSmDUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3itz8JedMcXsM6KstfiUKPU/EOs7z7sd3+sPLoLXdC86POYna6NrVzq5pqQ1ZZOi
	 8SDco7u9QD8wpPzH6rMs/3xb32YeLo4/nbt2lVixWR7zLxpYULMsNiOTY8WZDHt1qC
	 2+PSnlas7lP+LR4WWy4RIg++U52G0650y1v/7Uz3UGQCZi9Bko1j6JKKTZogpcn7JD
	 iaVpbc3jI8P31MOowpX9LKFQ85QB8IU38BvAiak6AjvRzcyJ7/lPHg4yzFO1jKys6i
	 XH842APffNMIidG275gTP/z8hzqymTQS3xngELa1AlDai0QX+A/RzKeYu6nf+4HzPO
	 gQMFzvVuT1C+Q==
Date: Wed, 24 Sep 2025 09:30:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar-host: Add static assertion to check
 !PCI_LOCKLESS_CONFIG
Message-ID: <mc5sglju5r7zubnnuzmnl6nf2t5xdz7x6rqbx26dnl5hzvnyhi@ydp767j7gqx5>
References: <20250923234644.82890-1-marek.vasut+renesas@mailbox.org>
 <ebcvi2mput6dyx5omlcvapjt6mwzrpq4h6c4o3kyfdxfrin35x@d75pxu652f6u>
 <85a97019-2f80-4104-b27a-6578612af1e4@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85a97019-2f80-4104-b27a-6578612af1e4@mailbox.org>

On Wed, Sep 24, 2025 at 05:34:55AM +0200, Marek Vasut wrote:
> Hello Manivannan,
> 
> On 9/24/25 5:25 AM, Manivannan Sadhasivam wrote:
> > On Wed, Sep 24, 2025 at 01:46:18AM +0200, Marek Vasut wrote:
> > > This driver can not function correctly without PCIe subsystem level
> > > config space access serialization. In case PCI_LOCKLESS_CONFIG is
> > > ever enabled on ARM, complain loudly so the driver can be updated
> > > accordingly.
> > > 
> > 
> > This limitation applies to almost all host controller drivers except those used
> > on Intel platforms like VMD and Hyper-V. So this would require adding the
> > Kconfig dependency for all those, not just for RCAR.
> 
> Correct.
> 
> > We could also add the dependency to the arch Kconfig, but there is still a
> > possibility that if the driver is used on a platform selecting
> > PCI_LOCKLESS_CONFIG, it would be broken silently. So adding the dependency to
> > the individual drivers that suffer from the limitation seems to be the right
> > thing to do.
> 
> Would you like me to send a few more patches which add !PCI_LOCKLESS_CONFIG
> into per-driver Kconfig entries, at least for drivers where I am sure they
> suffer from this currently hypothetical issue ...
> 

Sure.

> > Also, I'm not in favor of adding static_assert with Kconfig dependency in place.
> ... and drop the static assert ?
> 
> Then the drivers would at least be marked accordingly.

Yes. Better than what we have currently.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

