Return-Path: <linux-pci+bounces-31613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06D8AFB241
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 13:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423ED17EEA4
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218F3288C8D;
	Mon,  7 Jul 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzQ9mSTl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639015B135;
	Mon,  7 Jul 2025 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751887770; cv=none; b=jB+YNOgUTKlhImPc7RP08DPpxoN537KI4s2QEYowOv3ER1AIUZSNs+Ux/RHFdkvNgozxpCEabmgo1SIEFrVA4+2fT8UgzKXcWWzKwrA6qKBF4LxOLAzKOEM/rAmZFmbJkxI8PLV/f3nttDOK1bPcw4bW7tP60RhzH+PqUrs2F4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751887770; c=relaxed/simple;
	bh=pvrgPbujdZyNCnqS0MoPZy4z92NtoD/434IVrBGaRNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUF5K6KXvEZoSnO8lZOWkHwwu66LQN9adKQYSaxDB1ljMcNS6qIvgz4KlAZt0PmQMySB/WXAVoFQchYXbCjcNm6/SggggnNbDLRr0wCJ+QKXSOzSmBPplj9bXLcN+QWvSDys8+wDtdaAzAxCjTfiQkNZ57TA4ycsix01KLHZGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzQ9mSTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ADBC4CEE3;
	Mon,  7 Jul 2025 11:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751887769;
	bh=pvrgPbujdZyNCnqS0MoPZy4z92NtoD/434IVrBGaRNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzQ9mSTlqbjPryIzU8C3XJ2bHMoEKQ4PGiXh5kPvsK61snx3Ko7sg4bDQvAmsjNyn
	 VjBlyc7OVsGY2nwbPevisTcnOZK72lB3PDlNakMUad5FcfmPBbVvdvDypLIGh5uRc9
	 Q0bIaDP6yBFVAoBnE5RPw0SrJ4O16orY4aRAURr38XAqFX3GWO0SokyG/y9LHLARxi
	 hG7GbGWrC4zCJmvhUjqO8RheFBQ9GYnPogZwKq6XTG1kRXJ0oXeWcwj/OUXhvcw5+i
	 eI4LdHoFj/fSjCgPFR2upUo2YoxS57r/w2/C75umpqC6zf9X7F5LaM4bg7gRmYrh9F
	 /minS3KOUu35Q==
Date: Mon, 7 Jul 2025 13:29:22 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
	Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>, dingwei@marvell.com,
	Lukas Wunner <lukas@wunner.de>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 4/5] PCI: host-common: Add link down handling for host
 bridges
Message-ID: <aGuvkkeVkezGJWXn@ryzen>
References: <fr6orvqq62hozn5g3svpyyazdshv4kh4xszchxbmpdcpgp5pg6@mlehmlasbvrm>
 <20250530113404.GA138859@bhelgaas>
 <bixtbu7hzs5rwrgj22ff53souxvpd7vqysktpcnxvd66jrsizf@pelid4rjhips>
 <aGuqA92VDLK8eRY1@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGuqA92VDLK8eRY1@ryzen>

+ Mani's kernel.org email.

On Mon, Jul 07, 2025 at 01:05:39PM +0200, Niklas Cassel wrote:
> Hello Mani,
> 
> On Fri, May 30, 2025 at 09:39:28PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, May 30, 2025 at 06:34:04AM -0500, Bjorn Helgaas wrote:
> > 
> > > I think pci_host_handle_link_down() should take a Root Port, not a
> > > host bridge, and the controller driver should figure out which port
> > > needs to be recovered, or the controller driver can have its own loop
> > > to recover all of them if it can't figure out which one needs it.
> > > 
> > 
> > This should also work. Feel free to drop the relevant commits for v6.16, I can
> > resubmit them (including dw-rockchip after -rc1).
> 
> What is the current status of this?
> 
> I assume that there is not much time left before 6.17 cut-off.
> 
> 
> Kind regards,
> Niklas

