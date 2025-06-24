Return-Path: <linux-pci+bounces-30548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCE9AE70EB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 22:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45FF3B006D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 20:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4752E8895;
	Tue, 24 Jun 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRHIxi1f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE0B26CE23;
	Tue, 24 Jun 2025 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750797140; cv=none; b=Ugsp0nGY8aHYrEE79qfHLvy8J4Foyz9jynfYqhrZKrmGoGBe5v7f5/MhXUsArXIvjXQ3dUAIBO9JLHIKvWksy2TPP7FtDfoqZRlPMmt3eqRUcgOJj9mM5yEYgL8OmpKpAYcSovSja8B67HJbjwo65KoYVzK7bMTjZjeDxjZrIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750797140; c=relaxed/simple;
	bh=XCDfAzSe3v5F6wUubtknrcpSgjVyoC+pMzibwnbJWew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGuqbXoeFazFy5m3hv/NxcZzVEwo0Q4CBjZde4aX5+TYE+fPNIu7f9gJZoHc24/0byc90N+TfuBacS8NL7EOOO+DllVNAhhn1QIUXkX6pkYmjYCb8DQQ+ikCGqW7/6yC7NDMUvHHiYEBClpEWvg6GOx4o+EX+FAUMbjx0KJdp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRHIxi1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBD5C4CEE3;
	Tue, 24 Jun 2025 20:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750797139;
	bh=XCDfAzSe3v5F6wUubtknrcpSgjVyoC+pMzibwnbJWew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RRHIxi1fQ+n4A2kB/lD7P5ZitD1OcDHBSEFHdAxKXCMyrVsL45HaNNuqiPyKcxaRj
	 eFmU6ljdUdbeEYP8mtGU0pz5MwrGO8u7NpKpjPowFP4SUVQhd/60TzGxwWKsfxaPp+
	 bx6UtWFYeqUILMIRZYGYOVhXqxenfrQeRw2q6YnvUR+mrBSjV5W1eDZ4cloDN1Y85c
	 o/3i9x1A0mxa5PwpRP/Yaubgg7EmkubQjWO8t9x3TMAcu8HoUt0SPVteRWkpmfkAsA
	 hOfDI/tiUT0QKjKuEploqVXgXvOhG43BLPl0nO53uGh/vvH0GT0AaF+ubrBKdlfASF
	 mxQG3k9tCFz1A==
Date: Tue, 24 Jun 2025 14:32:17 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [pci:endpoint/epf-vntb 3/3] Warning:
 drivers/pci/endpoint/functions/pci-epf-vntb.c:695 function parameter 'bar'
 not described in 'epf_ntb_find_bar'
Message-ID: <plmgfnjrht5ffpqpz2fcw7wdoompgrq66znm5nuhkablozys4i@kmnq52ge6gxj>
References: <202506240711.TJdFg8To-lkp@intel.com>
 <1jcyatjww6.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1jcyatjww6.fsf@starbuckisacylon.baylibre.com>

On Tue, Jun 24, 2025 at 11:45:29AM +0200, Jerome Brunet wrote:
> On Tue 24 Jun 2025 at 07:49, kernel test robot <lkp@intel.com> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint/epf-vntb
> > head:   a0cc6e6fd072616315147ac68a12672d5a2fa223
> > commit: a0cc6e6fd072616315147ac68a12672d5a2fa223 [3/3] PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs
> > config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250624/202506240711.TJdFg8To-lkp@intel.com/config)
> > compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250624/202506240711.TJdFg8To-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202506240711.TJdFg8To-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> Warning: drivers/pci/endpoint/functions/pci-epf-vntb.c:695 function
> >parameter 'bar' not described in 'epf_ntb_find_bar'
> 
> Hi Manivannan,
> 
> Sorry about that. Do you prefer a fix on top of what you have already
> merged in your 'endpoint/epf-vntb' branch or a complete respin of the
> series ?
> 

No worries. I fixed it in the branch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

