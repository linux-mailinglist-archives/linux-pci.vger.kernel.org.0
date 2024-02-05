Return-Path: <linux-pci+bounces-3125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096FA84A97D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 23:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B6A29B3D5
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 22:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18F1DA4F;
	Mon,  5 Feb 2024 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVcIZSkd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873417552;
	Mon,  5 Feb 2024 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172937; cv=none; b=koY7mRwndvkBMRHWjNocLwVI/3vETXK7h7crGM2aLFyp8qqxVKeaRq0YsJVVqI3sQLirf2GCrwTHdu2yvpG/3D0zqKg/6Q0vJI/szYawUWpXw72ptk5eKK76haKLJWBhK+wCMAGvt7eQ7K5gDG9O+p4r4NpljVkFq/bwOSofCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172937; c=relaxed/simple;
	bh=DnCjxT2XshchSsawOjYIcnaeIH3yQaFkalYSYgYAmes=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Af9uxMZpJdrsjWAgudRoc37MTj0VSmooYTdx/AFlEMCu9Y/cawevXh6TiLR5GY4SY0L2FAsVBRvddAwoDLzyr2KawDO4fnB2WuNqJupvnOxp1HjwDOygaA34QQ9+81WTBSPOZ2MEktxhYkMMBIMXWZHXUJdZ7A+uGCLM2MLosXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVcIZSkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDB8C433F1;
	Mon,  5 Feb 2024 22:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707172937;
	bh=DnCjxT2XshchSsawOjYIcnaeIH3yQaFkalYSYgYAmes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VVcIZSkd8xtGNl1+FJ92wYTnpAio29YDwI59SJYxL7bRu9pcL6LPTjUw76mrAa2Eo
	 7x2EbVGQlBse07cO8bGoA6X0lxu00+Q52xkwMLkvkrO5a4FB2BbLGbRwni5nzTCAwb
	 WvvfU7QwuFhLFfrqp+1dUIXfK25a44llpnMSDRa9R9tLfGykWUk9mwes9oEgoDkeTo
	 X5IwfEuAMIM7KdFSxN2WItQrhQms1NduZPtOWGz+i90Q/sBmm85whqy3AZoEManTGe
	 OQed1GhDhtAuqAe8jRZVzdfheSm1KWx3ileB4DdyS+x5jT7G4s7YdILNqCxil8vEXf
	 bHUgMkjF+SSzw==
Date: Mon, 5 Feb 2024 16:42:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: Jian-Hong Pan <jhp@endlessos.org>, Johan Hovold <johan@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@endlessos.org
Subject: Re: [PATCH v2] PCI: vmd: Enable PCI PM's L1 substates of remapped
 PCIe Root Port and NVMe
Message-ID: <20240205224215.GA829734@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc3fce1400541a269ecee2b2ee33d8f1ec8e52e7.camel@linux.intel.com>

On Mon, Feb 05, 2024 at 11:37:16AM -0800, David E. Box wrote:
> On Fri, 2024-02-02 at 18:05 -0600, Bjorn Helgaas wrote:
> > On Fri, Feb 02, 2024 at 03:11:12PM +0800, Jian-Hong Pan wrote:
> ...

> > > @@ -775,6 +773,14 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev,
> > > void *userdata)
> > >  	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
> > >  	pci_info(pdev, "VMD: Default LTR value set by driver\n");
> > 
> > You're not changing this part, and I don't understand exactly how LTR
> > works, but it makes me a little bit queasy to read "set the LTR value
> > to the maximum required to allow the deepest power management
> > savings" and then we set the max snoop values to a fixed constant.
> > 
> > I don't think the goal is to "allow the deepest power savings"; I
> > think it's to enable L1.2 *when the device has enough buffering to
> > absorb L1.2 entry/exit latencies*.
> > 
> > The spec (PCIe r6.0, sec 7.8.2.2) says "Software should set this to
> > the platform's maximum supported latency or less," so it seems like
> > that value must be platform-dependent, not fixed.
> > 
> > And I assume the "_DSM for Latency Tolerance Reporting" is part of the
> > way to get those platform-dependent values, but Linux doesn't actually
> > use that yet.
> 
> This may indeed be the best way but we need to double check with our
> BIOS folks.  AFAIK BIOS writes the LTR values directly so there
> hasn't been a need to use this _DSM. But under VMD the ports are
> hidden from BIOS which is why we added it here. I've brought up the
> question internally to find out how Windows handles the DSM and to
> get a recommendation from our firmware leads.

We want Linux to be able to program LTR itself, don't we?  We
shouldn't have to rely on firmware to do it.  If Linux can't do
it, hot-added devices aren't going to be able to use L1.2, right?

Bjorn

