Return-Path: <linux-pci+bounces-36829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DD9B985AF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 08:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960F63BECF0
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 06:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1149C20E704;
	Wed, 24 Sep 2025 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMsG38RH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2B4317D;
	Wed, 24 Sep 2025 06:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694384; cv=none; b=DSKO3MULWi3vegoibVYg8YZe8PzLePjt4FqQmtCLmk1evlfbnZxraysjioRs1pCuH/YDt0XzdMd20nT41ETmzcq96XPPwQ1hPp5IZ7LiCXhjyx+ZrwHySUWExOyFO1TWQ9LeScxEX262W909W4nsMv4LijZ+YrwMwEAbRIYoM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694384; c=relaxed/simple;
	bh=1UEle53cr/Kv5Rm5m19M0DEsVfErsAhUm/vUUdeROmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX2701blAfgQE6qqsXQOjqaVQ7V0eNFA0bRmLg81EBo8L/LpwVEjE2/D+XEAdQzUhyE+0JUTd4gD7USlGJiuEtk4Qkl4gMDqzUiQvUJFNlgFo29WoOpi/0ffmVOPZOYigNKTv6RAY26p0bPIz9fHuSEkh5tdf3voAvysfH3mv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMsG38RH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4426C4CEE7;
	Wed, 24 Sep 2025 06:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758694383;
	bh=1UEle53cr/Kv5Rm5m19M0DEsVfErsAhUm/vUUdeROmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMsG38RHF74A4ZJrx+dnp7K786jvjltrHBJ7SYwl26hURMm04AUi+sGUF46ERDfPu
	 Dp2E2L1Is5obutKqjQ2FaEia86HrjgGn5k/ElwR7lQjdV9AncAjHDvkheVxYJpZYVd
	 qQquwOu9+n0XoBQDdBLReRIVBvsZiWp9glzjXxoVmxg837W1KXiQdhJsL3Lh05Gfba
	 oo9zWXDBznqUQfQ07/siiYJ+a17rqnL61S2fchHpOOZe/RxHi+erwR4Yu0K52XJpCy
	 NqLlRHVxBjGUg16y58Mt3hyTfnN7xHeaQutajObQTB+NCuxzCQUs/eD5aiV9Ox2RII
	 x/OHzfAJKL6wQ==
Date: Wed, 24 Sep 2025 11:42:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kenneth Crudup <kenny@panix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	"David E. Box" <david.e.box@linux.intel.com>, rafael@kernel.org, bhelgaas@google.com, 
	vicamo.yang@canonical.com, ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
Message-ID: <s7t5duadivgemkwmx4vjrzsaxy3xdeotwve734sq7iy477g2ur@lwusjd2iklxl>
References: <20250904171158.GA1268495@bhelgaas>
 <121a26de-b5d4-42a2-ae52-02b386f17109@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <121a26de-b5d4-42a2-ae52-02b386f17109@panix.com>

On Thu, Sep 04, 2025 at 10:16:55AM -0700, Kenneth Crudup wrote:
> 
> On 9/4/25 10:11, Bjorn Helgaas wrote:
> 
> > but if we can get in -next for a bit now, that would be great.
> 
> Yes, please 🙂 Other than some my-hardware-specific gcc flags, this effort
> in its various forms is the only diff between Linus' master and what I run,
> and for nearly 3 years now; it'd be great to see it in mainline (and a
> hearty thank you all for getting us nearly there!)
> 

ASPM patches targeting devicetree plaforms are now in pci/aspm and merged to
pci/next for testing. David could send a followup to add the VMD driver now
reusing the pcie_{aspm/clkpm}_override_default_link_state() helpers.

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=aspm

- Mani

-- 
மணிவண்ணன் சதாசிவம்

