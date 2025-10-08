Return-Path: <linux-pci+bounces-37729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C36ABC680A
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 21:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BA5404D07
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 19:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3469265614;
	Wed,  8 Oct 2025 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAcuD6ym"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85523BD1F
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953099; cv=none; b=MiAu75Ctj2HgfHeepScqnaO/NvR9UpyxM1PE1kE8CmqBkny/Gi1idNjrniSaZsUSLHXMbXoWBR55/pBUWdtzcd+7PdVwpIBjYZNzTMAWWwP2xGrvCa84ozow85wIK2Wwio8h3wNY+Lnk48c1B7YYPlGDroAUBwsTzAsgc3KZpT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953099; c=relaxed/simple;
	bh=X8WscWl9Z2DK2YNQwSrDB6wnFX5g9gZRrRmOM3LJtUM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KhebXGWTo7H8PJTW34IMQTQwmR862mFJUPiN3QMEcyF5eLzfllFMsA2iK/Odhy9QBNI9viglh19fzjIMVQ33xymKFBwjKgHciSBzua4YDYABLB5NbuAlrgifiUCahfZldxu/dYbhPOcZvIMJK4ez/OB3ijWBDp9J0JOhl1TzFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAcuD6ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BE9C4CEE7;
	Wed,  8 Oct 2025 19:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759953098;
	bh=X8WscWl9Z2DK2YNQwSrDB6wnFX5g9gZRrRmOM3LJtUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TAcuD6ym3YBqj5+34XPnATejDFCy+g6d9w3TH7DksLXOO+X3/syG+cVf7xh2e/WwJ
	 aL76+8qjqGBoG1Wru79xkWPdlfeRPLsIaIuzq6K7s7hMi0AnrcjM3JoHPA0bet9xqj
	 +e1wy4/OXcaQfvj9JH+ZnJ7w/eO8A3Lqh57XFIsAi90gklcRw7xnPWF3QV15CjUdGf
	 iW7BrJJMVNJlEksF9wxIDo9aIgITGOoM4qe46T2ENkwIBJ1lGeSjdqqkGPCbilVbUW
	 c+0ZUqvnliyU6jYb/8iGI8Emv2MA0C8i089ARGFBcLblAMecnoP3PLSLOUvmyiwc1A
	 w/H2GpyZt5y+Q==
Date: Wed, 8 Oct 2025 14:51:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	Christian Zigotzky <info@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251008195136.GA634732@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de>

On Wed, Oct 08, 2025 at 06:35:42PM +0200, Christian Zigotzky wrote:
> Hello,
> 
> Our PPC boards [1] have boot problems since the pci-v6.18-changes. [2]
> 
> Without the pci-v6.18-changes, the PPC boards boot without any problems.
> 
> Boot log with error messages: https://github.com/user-attachments/files/22782016/Kernel_6.18_with_PCI_changes.log
> 
> Further information: https://github.com/chzigotzky/kernels/issues/17
> 
> Please check the pci-v6.18-changes. [2]

Thanks for the report, and sorry for the breakage.

Do you happen to have a similar log from a recent working kernel,
e.g., v6.17, that we could compare with?

> [1]
> - https://wiki.amiga.org/index.php/X5000
> - https://en.wikipedia.org/wiki/AmigaOne_X1000
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92

#regzbot introduced: 2f2c7254931f ("Merge tag 'pci-v6.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci")
#regzbot link: https://github.com/chzigotzky/kernels/issues/17

