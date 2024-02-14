Return-Path: <linux-pci+bounces-3456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7848854DA6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 17:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0991C217FC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 16:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2525FB8A;
	Wed, 14 Feb 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9tgLLbz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D875F871;
	Wed, 14 Feb 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926815; cv=none; b=ncEXcs6w7frit687tDZZkmA5DFuqzultu/thLRa9SfXtUWfLXPNYYBSscbz2aY61FiAgdpjiDGJmv1Jtt21Of6TjFDcIiHd8/opbtWcTq1EDBNdfekd/Bj3No33D5P0wWqTDXrucwrRdTbbWb/rm3iamdXz5meAUYRrXjwUSLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926815; c=relaxed/simple;
	bh=7qfrnwneSTETdWc/MSsQJm5c32O3g3e00oMGNngWvdA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bd9/ZoVBs25oQxI4KFuXoF6IarmZVgFRA9pzQyrTp+jc0mbdtm8mSiroXJUPHc3nv+kOWXRtk2z7JcCLE8TQaTiw3zIwCheqe9CHInfgXa2isgsuXfMCy07vjpmr9toRgQdPR86OYdkYit5JAiINTgKoOVbBI2lviqhNeXuJrR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9tgLLbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8A5C433F1;
	Wed, 14 Feb 2024 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707926815;
	bh=7qfrnwneSTETdWc/MSsQJm5c32O3g3e00oMGNngWvdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U9tgLLbzW1pYyi63ZIZJXqnQMdQ7wpz/W6lsEZg0Vj2Aiw25wTfuXXhU27ljokdqG
	 Y9ZKkeN9rcDJTudtdXqjl/yNA4hXi1HNVEAQzx5PUMaNPkaSeI78Ym1La6TriopzGJ
	 kEXTbA68dpMJmlr8smYAcoG+YGXrzsMo/I8dut7g3gGm9Ejs3WI2McNKY6o8TCAYC+
	 ffGE6h8GpLgpjv62GNDvgA5BSDP5gjj74dLGRotkxhiER3hMFkpqZMKKk14mnVihD9
	 BD6ecs/6mIGfo7m8XF7E1qk2bxg+EBTpHNf3ouJC1NLyCKk0TTfXnsBs9C6psV/G+v
	 x3Qb+7cpL/ykw==
Date: Wed, 14 Feb 2024 10:06:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	bhelgaas@google.com, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, stanislaw.gruszka@linux.intel.com,
	lukas@wunner.de, rafael@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: Re: [PATCH v1] PCI / PM: Really allow runtime PM without callback
 functions
Message-ID: <20240214160652.GA1254564@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcy-I9-HcA_RuOyY@black.fi.intel.com>

On Wed, Feb 14, 2024 at 03:20:35PM +0200, Raag Jadav wrote:
> On Wed, Feb 14, 2024 at 03:01:29PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 14, 2024 at 12:43:35PM +0200, Raag Jadav wrote:
> > > On Tue, Feb 13, 2024 at 02:06:48PM -0600, Bjorn Helgaas wrote:
> > > > On Mon, Feb 12, 2024 at 12:02:33PM +0530, Raag Jadav wrote:
> > 
> > ...
> > 
> > > > >  0)               |  pm_runtime_work() {
> > > > >  0)               |    rpm_idle() {
> > > > >  0)               |      rpm_check_suspend_allowed() {
> > > > >  0)   1.500 us    |        __dev_pm_qos_resume_latency(); /* = 0x7fffffff */
> > > > >  0)   4.840 us    |      } /* rpm_check_suspend_allowed = 0x0 */
> > > > >  0)   1.550 us    |      __rpm_get_callback(); /* = 0xffffffffb4bc84f0 */
> > > > >  0)   1.800 us    |      pci_pm_runtime_idle(); /* = -38 */
> > > > >  0) + 17.070 us   |    } /* rpm_idle = -38 */
> > > > >  0) + 22.450 us   |  } /* pm_runtime_work = -38 */
> > > > 
> > > > What is this timing information telling me?
> > > 
> > > It's a raw ftrace dump.
> > 
> > (Told ya that people would be surprised with this without seeing how you get
> >  this and what fields mean)
> 
> I can add stat headers in v2 which I think will be more helpful.

That's not what I was asking.  *Why* is the ftrace dump here?  Is the
point that we're calling a function we shouldn't?  That this patch
improves performance?  Without some interpretation of what the dump
shows, it's just noise.

Bjorn

