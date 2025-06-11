Return-Path: <linux-pci+bounces-29483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257FCAD5CDF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 19:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FBB3A88FB
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C614021018F;
	Wed, 11 Jun 2025 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVSVeO9X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24CD20E708
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749661903; cv=none; b=Y0WCx5JiPv+p4wrOrd0swcG8KLdxS/w3qoGM6WJsq7qEfxkLeieruyp93M37aVzBYpe/m5uZ+fjSvaublcjxyDSQ3dLeqc7GXo0mp3Qp7tvpiBJpuMwZuW0r6w+7ocF7hfLH0J0TDDn3c/t1cIR7EpdliomnnsupexPFYlXNNuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749661903; c=relaxed/simple;
	bh=V7Qz7FopCPAo45OIg+BcHAIFCLPXhmSSHPLNyIjQaSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tax8SPLmE2/gTptJxGYZwRllu873U24iCIp3NMOkZuV5cOI7wBQTWd0gXd7RFVatol9ZwAMYT/01Ha5PVyWrZa9nBA9TFXa4GdUrAGC7v841y60Gprtf/BtWYZb4Yfph8UbzOOCISI/QQYqX1OJmKRphVyGUdzxtJ7pyVggwZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVSVeO9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D09C4CEE3;
	Wed, 11 Jun 2025 17:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749661901;
	bh=V7Qz7FopCPAo45OIg+BcHAIFCLPXhmSSHPLNyIjQaSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AVSVeO9XHwSxfVdXHIWY72HNElVtXYbcAiBWDg+CsV7SCE4gKhbWnXfDGKdXiqVTx
	 Z9/OXZ8cCgmRZzVm2XOMDh4DQI427WmL90FpdMiBOttGEIL+So00s/tUhpvulFt7ht
	 729kY9zbKhD8CdPW0oaDA+B7Q3e21MyaeJXXCuERbFJS1But5X7J8Dag1j3mpXf4Ys
	 DRE19nehHNRe0kErTdyBLRK9CiVGxsg8R0NjdMOHyi7uJY6VSQMStKeSUoMkme83vv
	 dkiGYV5UDIsPBz9rrotAk+LNGNexUZVVo/hibrXqCYCYsH+K2alhk7vFg4K5wy2W1e
	 f2gRGsrQEJrlw==
Date: Wed, 11 Jun 2025 22:41:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, ilpo.jarvinen@linux.intel.com, lukas@wunner.de
Subject: Re: [PATCHv2] pci: allow user specifiy a reset poll timeout
Message-ID: <reekyt4dm7uszybipm25xfxlksn5bm2cdpubx5idovxenpg44z@qcqs44xlevea>
References: <20250218165444.2406119-1-kbusch@meta.com>
 <Z_2kQMjR1uoKnMMo@kbusch-mbp.dhcp.thefacebook.com>
 <zqtfb77zu3x4w5ilbmaqsnvocisfknkptj4yuz64lu3rza5vub@fmalvswla7c5>
 <aEmxanDmx6f_5aZX@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEmxanDmx6f_5aZX@kbusch-mbp>

On Wed, Jun 11, 2025 at 10:40:10AM -0600, Keith Busch wrote:
> On Wed, Jun 11, 2025 at 09:58:59PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Apr 14, 2025 at 06:11:44PM -0600, Keith Busch wrote:
> > > On Tue, Feb 18, 2025 at 08:54:44AM -0800, Keith Busch wrote:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > The spec does not provide any upper limit to how long a device may
> > > > return Request Retry Status. It just says "Some devices require a
> > > > lengthy self-initialization sequence to complete". The kernel
> > > > arbitrarily chose 60 seconds since that really ought to be enough. But
> > > > there are devices where this turns out not to be enough.
> > > > 
> > > > Since any timeout choice would be arbitrary, and 60 seconds is generally
> > > > more than enough for the majority of hardware, let's make this a
> > > > parameter so an admin can adjust it specifically to their needs if the
> > > > default timeout isn't appropriate.
> > > 
> > > This patch is trying to address timings that have no spec defined
> > > behavior, so making it user tunable sounds just more reasonable than a
> > > kernel define. If we're not considering upstream options to make this
> > > tunable, I think we have no choice but to continue with bespoke
> > > out-of-tree solutions.
> > 
> > Do we know the list of devices exhibiting this pattern? And does the time limit
> > is deterministic? I'm just trying to see if it is possible to add quirks for
> > those devices.
> 
> No. I'm dealing with new devices being actively developed, with new ones
> coming out every year, so a quirk list would just be never ending
> maintenance pain point.

Sounds like you have a lot of devices behaving this way. So can't you quirk them
based on VID and CLASS?

> The fact I can't point them to off-the-shelf
> kernels to test with has been frustrating for everyone. If we just had a
> user defined option instead of forcing the kernel's arbitrary choice,
> then the problem is solved once and forever.

I think nowadays the use of module_params is not encouraged, though in this
case, it is already present and you are just trying to add one more option.
But, adding a new option for devices from a single vendor might not fly (though
only Bjorn could take that call).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

