Return-Path: <linux-pci+bounces-29871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEFFADB267
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 15:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464771883F10
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3792877C1;
	Mon, 16 Jun 2025 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeFgSnAK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18112BF013;
	Mon, 16 Jun 2025 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081499; cv=none; b=Uvz6ZDwa6cFMjP5gL9e1o7xwX23Nvmy9mDbxCo7ZFTHAs9LKI+lYQqwTP+cnJPCeUBFJ8DJPDA1vhZ0SKzAoyPDmEqgEkAPigwXNMzmKMfYIgSJvl9CxgWm9K3LzFLjz+x3vpmxK4WyCase8n+fElEQt+QYk42Rwu3iUXtrB+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081499; c=relaxed/simple;
	bh=1xgboebGlal25X+TwAIYlHFbAqB7xNLLW9NyvUYl28E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6X0pPU/hRmI/SvTc+NBjND9MQ+64q0j5wpby+pZZ8KsM9TcbtAxGN9gELJBehQr0oKtoMHQ5kHXFWlALTO6Gyv7ZPQFuLZysl06C1EfVBwvrDhPNrxA3kwBCfAsu2iH6cyNCxBWsf4pcX+8xJRceDKfIG8uvf+QDoW4xRoyfOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeFgSnAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56140C4CEF0;
	Mon, 16 Jun 2025 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750081498;
	bh=1xgboebGlal25X+TwAIYlHFbAqB7xNLLW9NyvUYl28E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeFgSnAKqRIFvzW2IMzj9z72x12kiwSHRTf4f5YbGCBdI35baEv+AW343N3LvoBBM
	 tuDbAk/W19WqqHx3fuwP/PLmBEuQpkVsmCoiYbYK9DFPok04bGwNXsiN/l3/njmecJ
	 DqgPM9c7uWGpwdtpDJzXt0iNNuP3RJ9IgGgmV1HKFHYGN0yOXLWuxAo8hPTf7lXfXX
	 6jwwPtxInK08VrBvA+sqRqwhPJMb8zCFxTbafvwCxwnEhcQNfjf7WtVbXbIkoZuVx4
	 lhYPVqzUzzktlKjf4XiiwZg+Nz2f3ZRYBtpV92zvq9EDCoM33QWbdRYN4R53DY2qtY
	 PD6j0ZVHhuzdQ==
Date: Mon, 16 Jun 2025 19:14:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lukas Wunner <lukas@wunner.de>, kernel test robot <lkp@intel.com>, 
	bhelgaas@google.com, oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>, 
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
Message-ID: <pwb4g7worzsnryimt3ymdfsxu7bxvhlr74rqodmiof5auolhrc@vpi7wzrp7osh>
References: <20250616053209.13045-1-mani@kernel.org>
 <202506162013.go7YyNYL-lkp@intel.com>
 <ji3pexgvdkfho6mnby5jumkeaxdbzom574kbiyfy4dcqumtgz2@h4nmwjvox7nl>
 <aFAZL1GgEH9l-zj9@wunner.de>
 <CAMRc=Mf=Z+d3UKdwEXkw1Xm9G=qVwh6=fXsfgS6JiOM6Z7H50w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf=Z+d3UKdwEXkw1Xm9G=qVwh6=fXsfgS6JiOM6Z7H50w@mail.gmail.com>

On Mon, Jun 16, 2025 at 03:30:27PM +0200, Bartosz Golaszewski wrote:
> On Mon, Jun 16, 2025 at 3:16 PM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > On Mon, Jun 16, 2025 at 06:07:48PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Jun 16, 2025 at 08:21:20PM +0800, kernel test robot wrote:
> > > >    ld: drivers/pci/probe.o: in function `pci_scan_single_device':
> > > > >> probe.c:(.text+0x2400): undefined reference to `pci_pwrctrl_create_device'
> > >
> > > Hmm, so we cannot have a built-in driver depend on a module...
> > >
> > > Bartosz, should we make CONFIG_PCI_PWRCTRL bool then? We can still allow the
> > > individual pwrctrl drivers be tristate.
> >
> > I guess the alternative is to just leave it in probe.c.  The function is
> > optimized away in the CONFIG_OF=n case because of_pci_find_child_device()
> > returns NULL.  It's unpleasant that it lives outside of pwrctrl/core.c,
> > but it doesn't occupy any space in the compiled kernel at least on non-OF
> > (e.g. ACPI) platforms.
> >
> 
> And there's a third option of having this function live in a separate
> .c file under drivers/pci/pwrctl/ that would be always built-in even
> if PWRCTL itself is a module. The best/worst of two worlds? :)
> 

I would try to avoid the third option at any cost ;) Because the pwrctrl/core.c
would no longer be the 'core' and the code structure would look distorted.

Let's see what Bjorn thinks about option 1 and 2. I did not account for the
built-in vs modular dependency when Bjorn asked me if the move was possible. And
I now vaguely remember that I kept it in probe.c initially because of this
dependency.
 
- Mani

-- 
மணிவண்ணன் சதாசிவம்

