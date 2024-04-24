Return-Path: <linux-pci+bounces-6646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C768B0EE2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCF1293FD3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2344A16ABC7;
	Wed, 24 Apr 2024 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/J5TyQe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6F16D301
	for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973332; cv=none; b=d88MiCiggMqwC9KJ0uBJVsl7c+Yg1FfySZbhkEaveNTAY0ovvWWLmdG8GGY6ISR8RtmlRK1DLHN4zSzn89tFq3raKs73fiD8fbwkusBZRff4a4+6Xh1Salc0q2GCQT0e4W9jVMcyn/Q5uW+mavx8slJrLTOztASLuI0x5+U76ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973332; c=relaxed/simple;
	bh=/om+TZWyepj4za93/IvGc09W4ivmdTmFXbh1+X9HE4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jQAa2beTFZ8/all2sa2kR+FgjCmPfles/Cv+wRXWTr4oEmy4U+PqTLMhsrtbPBOMX8y7OgezV16AIYqIyPa1GE9LRkmU3OMJHwe1iWGXJX5JNj93ZYS9/4eszhh1B5F49hdMvH4FjZpNXweOjCw0FCvjs8fgRpIzaubw+sUAtHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/J5TyQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D455C113CD;
	Wed, 24 Apr 2024 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713973331;
	bh=/om+TZWyepj4za93/IvGc09W4ivmdTmFXbh1+X9HE4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=G/J5TyQenJKp2yDDUxY9rtpOvipZh8KK+XrSD5oPlMrf2DfkwFI07pq10AWRQYd9y
	 NCMhVDuYR6SMlYaUu4z1fCuYCmbEFMywTvxfmFMMqfocdgOrm+PqSgF2OBMJGPm6za
	 dkwu/cjFKh31ULqd4BZpdc01IyWAmU+2YnCK8VC+sGKUDg2pddlz5Dwzpsoj9i183u
	 TaKeOE4dzB5SA+Rg5QPurH15Zy21wXO6S7MuzOseSLZQvB+wURa4g73uBHoNXvgp/x
	 wqsLBi3NJZf4xoPTqL9APzrgjxJMGLChnyD10Dhmjs587zzgxLT7ffivmNzoJ1qasY
	 9GxPhyg+6PoFA==
Date: Wed, 24 Apr 2024 10:42:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: Booting with `pci=nobios` fails on Dell XPS 13 9360
Message-ID: <20240424154204.GA494608@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed4d665b-7f3c-4459-a697-a28ed745d0c3@molgen.mpg.de>

On Wed, Apr 24, 2024 at 07:30:42AM +0200, Paul Menzel wrote:
> On the Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, booting Linux
> 6.9-rc5-00036-g9d1ddab261f3 with `pci=nobios`, the internal keyboard does
> not work, and there are DRHD (IOMMU) errors and intel-lpss errors printed by
> Linux. (As the keyboard does not work, I am unable to enter the LUKS
> passphrase, and capture the Linux messages.)
> 
> Is that option supposed to work, and should Linux be able to detect and
> configure itself without the help from the system firmware?

Linux definitely needs help from firmware to boot, but "pci=nobios"
doesn't turn off very much, and I would think Linux would still boot
on a machine like yours that has ACPI with MCFG/ECAM, etc.

My guess is some early PCI config access before we set up ECAM is
failing.  You might be able to capture console output as a video,
especially if you slow it down with boot_delay=.  I've used something
like "nosmp initcall_debug ignore_loglevel boot_delay=60 lpj=3200000"
as a starting point.  Must enable CONFIG_BOOT_PRINTK_DELAY for this to
work.

Bjorn

