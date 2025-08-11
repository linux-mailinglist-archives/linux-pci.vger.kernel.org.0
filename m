Return-Path: <linux-pci+bounces-33751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D52EB20C57
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEA6175B79
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EDA273D6B;
	Mon, 11 Aug 2025 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAXyy64c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0146447;
	Mon, 11 Aug 2025 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923137; cv=none; b=Z+xY+VncfSzc+RVvnZDUm+F+aGuVfkqaD3rWF7HgyVQ6ChXmH1IW+qG2678ufM0+fI2KEmArZ+wFLwlqA58I9i/se7EjWfxWIBhCt1PpnfLoauo9fXmtNJ6cIbVjKgmPaP+4bm5lu456pnSnII/c4jteE1HOtkAEqt9dCOmnBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923137; c=relaxed/simple;
	bh=RBPx0dxNh+rNTcptWvcSPGABtt0/X8BmM7RC5h2kOkE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MXCxQzfX2rjwVK8CFVmVlBpvTO720z6lzEL+ng00EbWbmZGvKFHgTOwMdi+iH7V/lyc/OHR21OsaeuzuwCLlw4Elhetxbqu1KUQ7+N+q0rkwbavJvSiu0Q48mJoghG05zfGSedHhO9ptwCG3KoSW9aMOssfR2hGmbclezrXyTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAXyy64c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EB2C4CEED;
	Mon, 11 Aug 2025 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754923137;
	bh=RBPx0dxNh+rNTcptWvcSPGABtt0/X8BmM7RC5h2kOkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rAXyy64cl/0Vqx16bd11on8kaBxmNBqqvHQkGrVD/cssPvyfXyzzL6CvbgzMVz9Ou
	 xt12AXdopJlFCKQWHKIRFTYBDzfG+t+CL3buVGedwVSOGmFH+GoFbH/3fycPdSLhZ8
	 da2YRJK6LCMmFDeKxQfBIWb4movWv+D0ViObnRBKHp5A8P1rXwnHiICa8mpTpV+JCk
	 uiQGg8m7Wfa3b6osa6Isry3Nvp0k8tyAJ/3P3XrjfCR8SHyr26YrVsrdfkuBen3Ak/
	 N1kajTLPuqmPXn0PW1pyoszYPVbYtZN93zUz5EHOW9Yw20xE3weQZNRMecNvSckhzS
	 32AGinS4/wk7A==
Date: Mon, 11 Aug 2025 09:38:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenneth Crudup <kenny@panix.com>
Cc: namcao@linutronix.de, mani@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: Commit d7d8ab87e3e ("PCI: vmd: Switch to
 msi_create_parent_irq_domain()") causes early-stage reboots on my Dell
 XPS-9320
Message-ID: <20250811143856.GA132204@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807160301.GA50800@bhelgaas>

On Thu, Aug 07, 2025 at 11:03:03AM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 06, 2025 at 04:07:30PM -0700, Kenneth Crudup wrote:
> > 
> > I'm running Linus' master (as of today, cca7a0aae8958c9b1).
> > 
> > If I revert the named commit, I can boot OK. Unfortunately there's no real
> > output before the machine reboots, to help identify the problem.
> > 
> > I have a(n enabled) VMD in my Alderlake machine:
> > 
> > [    0.141952] [      T1] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1280P
> > (family: 0x6, model: 0x9a, stepping: 0x3)
> 
> #regzbot introduced: d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")

#regzbot fix: d5c647b08ee0 ("PCI: vmd: Fix wrong kfree() in vmd_msi_free()")

