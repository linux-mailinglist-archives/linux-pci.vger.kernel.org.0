Return-Path: <linux-pci+bounces-5207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB288CFC6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 22:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1891A1C65CF5
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 21:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223E12AAF3;
	Tue, 26 Mar 2024 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTMh6vKd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191BD1E884;
	Tue, 26 Mar 2024 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487604; cv=none; b=Brq6cBjLFlAYZJpCF7MFTTODO5ciF17dZ6Su0CsLabYlORvZu13wepmuWSsaXLucDQs1lyDWj81opWqDamC0hgVzH8BuvE1ad2JUmZWdxc0I2f9/sxqHjDlCta2kkiiFT7AS9mktABYFkiSdeNkWGYli+d85/v+xWT97tFwc5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487604; c=relaxed/simple;
	bh=xQbKi5ntxrvhKyrBYbFCg4gD4cqWuSqGy6wuGhwULrs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jNwm6d9pvtWQfFLbGvlYkh/EI3f7HUkw+37WQJwRy5m8Ag5H7w6I0jItcvxsA/TJNfi7oSqgI1j9zUI7cuPYO1/oSrbVMK4dKJQgo8bJ438+ddX20J7oXpEmm+1FXz6yziw+SPf8xUrhQ5/l4HhshUJobdlKk/gbvdmGFc/m7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTMh6vKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89491C433C7;
	Tue, 26 Mar 2024 21:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711487603;
	bh=xQbKi5ntxrvhKyrBYbFCg4gD4cqWuSqGy6wuGhwULrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pTMh6vKdfNM1gwB5XSP2SDKVR7BQOukK9RhvLK+uWVhgb3b2GcHeyWh4rS4EX9Xbf
	 ivE0HquIBK+7iVxzAebpl0JkwRySbdbAV01OhX1Yb5bo3igqFexnNKtb35gxuW6HwJ
	 G+kn7onehmpJ4XRN9GHxxiVkJt7yKGV5/JGO2vZpEeIS2Gw4TZukVCguQ5oHgc3/UW
	 Esmea/O3Pk18Rj2YA8nY2lW1C/JG/SvHt/8v6ShEY8H26vnYlqHb/Iw6Ss2U8x0NwZ
	 +ZC29+bMDvq9peveevf2B5pW1SVESHf0lp1OCEQEydsS1RpyK5uBWlh7hQZq+3slpu
	 ZTm9BrTjIiEeQ==
Date: Tue, 26 Mar 2024 16:13:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [pci:enumeration 28/28] drivers/mfd/intel-lpss-pci.c:57:49:
 error: 'PCI_IRQ_LEGACY' undeclared; did you mean 'NR_IRQS_LEGACY'?
Message-ID: <20240326211321.GA1497270@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f13e9775-9dca-4a8f-b6bb-6d5a8f6dbccd@kernel.org>

On Tue, Mar 26, 2024 at 08:52:36PM +0900, Damien Le Moal wrote:
> On 3/26/24 19:19, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git enumeration
> > head:   8694697a54096ae97eb38bf4144f2d96c64c68f2
> > commit: 8694697a54096ae97eb38bf4144f2d96c64c68f2 [28/28] PCI: Remove PCI_IRQ_LEGACY
> > config: i386-buildonly-randconfig-001-20240326 (https://download.01.org/0day-ci/archive/20240326/202403261840.1RP419n5-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240326/202403261840.1RP419n5-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202403261840.1RP419n5-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/mfd/intel-lpss-pci.c: In function 'intel_lpss_pci_probe':
> >>> drivers/mfd/intel-lpss-pci.c:57:49: error: 'PCI_IRQ_LEGACY' undeclared (first use in this function); did you mean 'NR_IRQS_LEGACY'?
> >       57 |         ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
> >          |                                                 ^~~~~~~~~~~~~~
> >          |                                                 NR_IRQS_LEGACY
> >    drivers/mfd/intel-lpss-pci.c:57:49: note: each undeclared identifier is reported only once for each function it appears in
> 
> Bjorn,
> 
> Not sure what is going on here. I did an allyesconfig build on x86_64 and did
> not see such issue. Did the build bot missed some patches ?
> 
> And the above also reminds me that we could change NR_IRQS_LEGACY to
> NR_IRQS_INTX too.

Sorry, this is my fault because I dropped the intel-lpss-pci.c patch
because I was thinking Andy's patch would make it obsolete [1].  And
it *does*, but we don't know the ordering of when his patch and this
series will be merged into -next or upstream, so ...

Anyway, I blew it, and I restore the intel-lpss-pci.c patch in the
series, and we'll just have a trivial merge conflict to resolve until
they're both upstream.

Sorry for all the confusion.

Bjorn

[1] https://lore.kernel.org/r/20240325210444.GA1449676@bhelgaas

