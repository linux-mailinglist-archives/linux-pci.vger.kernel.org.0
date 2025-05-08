Return-Path: <linux-pci+bounces-27448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B1DAAFEF8
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 17:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB62618888EE
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C2E2797B1;
	Thu,  8 May 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk1M7IYK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D08526D4EE;
	Thu,  8 May 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717248; cv=none; b=trsc8khbqxDtuCJJPUbVAXtTOxL2hOpQSrDY/4qjM7Fu8bMwQ0cUAHY6kUGaC70Q7OQaEzFdtUS6JvsfYdarmgmJ0PpdgcfBu6pCYXCf1F5QuJDeYlIMmou3KPhcOhQ+6KV2eLPP2MSbwo0aS94AcJYTlOW27fkgaS/9TD4CSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717248; c=relaxed/simple;
	bh=yormhUEt8XHC3PTbUAynHNQJAL9v5mh6z/cnwi7mQzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPzUoJy36ug9sm/HIzAw2s1KRbovs56/y1tRgwAkWx5uFK/hKGuBQanxf/qCGR1+DKw4BNXCsv8FGYPBh5hqjUHb+H3kGM1pD+HL92v6e1NffYvvQxdY9baJuJnx5T9cY6T+xelMyK17QUEUqHqZxdWxl9o/oACL9RyhYmZYL/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk1M7IYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951F7C4CEE7;
	Thu,  8 May 2025 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746717247;
	bh=yormhUEt8XHC3PTbUAynHNQJAL9v5mh6z/cnwi7mQzw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gk1M7IYKExGjljdTpf1IfU5ou08bIjcdhIiSuSenW0kyxV2GExk7zCpzcFkUxNb0p
	 KXEEVwNdsaPukq/3O0umdNvXm5oxqmsLPMc8r3l7gC1JpNqi554/Z4hx3vxAMxJclV
	 +5Pp50KoPyPfgv17a2+Cl+75XGzCvajXBZVAaT1WYUG8BMIyl8cIfdZjE36dqQPT7T
	 s0R0XKsDqFUXMEVnGFksZaxpVpItRsErtGP3v84yXDsL9JOiTjPlvJkgw4CiWCuFOc
	 z0tLw2RoxVLCkp6hLHS8l/9oIAkDtpfn7tAJsmxW7A+B7VyHTq9Re5ATdBtjHTU3La
	 LCHMt5et1bI6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 38DC2CE076F; Thu,  8 May 2025 08:14:07 -0700 (PDT)
Date: Thu, 8 May 2025 08:14:07 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ilpo.jarvinen@linux.intel.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH] PCI/bwctrl: Remove unused pcie_bwctrl_lbms_rwsem
Message-ID: <606a5ead-1fcf-43a4-94d3-5d8c1e70dd92@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3840f086-91cf-4fec-8004-b272a21d86cf@paulmck-laptop>
 <20250508190845.4cae8b62@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508190845.4cae8b62@canb.auug.org.au>

On Thu, May 08, 2025 at 07:08:45PM +1000, Stephen Rothwell wrote:
> Hi Paul,
> 
> On Wed, 7 May 2025 15:04:57 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >
> > PCI/bwctrl: Remove unused pcie_bwctrl_lbms_rwsem
> > 
> > Builds with CONFIG_PREEMPT_RT=y get the following build error:
> > 
> > drivers/pci/pcie/bwctrl.c:56:22: error: ‘pcie_bwctrl_lbms_rwsem’ defined but not used [-Werror=unused-variable]
> > 
> > Therefore, remove this unused variable.  Perhaps this should be folded
> > into the commit shown below.
> > 
> > Fixes: 0238f352a63a ("PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_SEEN flag")
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: <linux-pci@vger.kernel.org>
> > 
> > diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> > index fdafa20e4587d..841ab8725aff7 100644
> > --- a/drivers/pci/pcie/bwctrl.c
> > +++ b/drivers/pci/pcie/bwctrl.c
> > @@ -53,7 +53,6 @@ struct pcie_bwctrl_data {
> >   * (using just one rwsem triggers "possible recursive locking detected"
> >   * warning).
> >   */
> > -static DECLARE_RWSEM(pcie_bwctrl_lbms_rwsem);
> >  static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
> >  
> >  static bool pcie_valid_speed(enum pci_bus_speed speed)
> 
> I added that to linux-next today and will remove it when it is no
> longer needed.

Thank you, Stephen!

Ilpo, I look forward to seeing this patch replaced by your improved
version with better comments.

							Thanx, Paul

